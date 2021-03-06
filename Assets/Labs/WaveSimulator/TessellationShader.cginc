﻿#pragma vertex tessvert
#pragma fragment frag
#pragma hull hs
#pragma domain ds
#pragma target 4.6
#pragma geometry geo

#include "UnityCG.cginc"
#include "Lighting.cginc"

struct appdata
{
    float4 vertex : POSITION;
    float2 uv : TEXCOORD0;
    float3 normal:NORMAL;
};

struct v2f
{
    float2 uv : TEXCOORD0;
    float4 vertex : SV_POSITION;
    float3 worldPos:TEXCOORD1;
    float3 worldNormal:TEXCOORD2;
    float3 color:TEXCOORD3;
};

struct g2f
{
    v2f data;
    float2 barycentricCoordinates : TEXCOORD0;
};

// sampler2D _MainTex;
// float4 _MainTex_ST;


v2f vert(appdata v)
{
    v2f o;
    o.vertex = UnityObjectToClipPos(v.vertex);
    //o.uv = TRANSFORM_TEX(v.uv, _MainTex);
    o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
    o.worldNormal = UnityObjectToWorldNormal(v.normal);
    return o;
}

//显示wireframe
[maxvertexcount(3)]
void geo(triangle v2f IN[3], inout TriangleStream<g2f> tristream)
{
    g2f g0, g1, g2;
    g0.data = IN[0];
    g1.data = IN[1];
    g2.data = IN[2];

    g0.barycentricCoordinates = float2(1, 0);
    g1.barycentricCoordinates = float2(0, 1);
    g2.barycentricCoordinates = float2(0, 0);

    float3 bary0, bary1, bary2;
    bary0 = float3(g0.barycentricCoordinates, 1 - g0.barycentricCoordinates.x - g0.barycentricCoordinates.y);
    bary1 = float3(g1.barycentricCoordinates, 1 - g1.barycentricCoordinates.x - g1.barycentricCoordinates.y);
    bary2 = float3(g2.barycentricCoordinates, 1 - g2.barycentricCoordinates.x - g2.barycentricCoordinates.y);

    g0.data.color = bary0;
    g1.data.color = bary1;
    g2.data.color = bary2;

    tristream.Append(g0);
    tristream.Append(g1);
    tristream.Append(g2);
}

//---------------------------------------------------
//曲面细分
struct InternalTessInterp_appdata
{
    float4 vertex : INTERNALTESSPOS;
    float3 normal : NORMAL;
    float2 uv : TEXCOORD0;
};

InternalTessInterp_appdata tessvert(appdata v)
{
    InternalTessInterp_appdata o;
    o.vertex = v.vertex;
    o.normal = v.normal;
    o.uv = v.uv;
    return o;
}

//基于视距计算细分程度
float TessellationEdgeFactor(InternalTessInterp_appdata cp0, InternalTessInterp_appdata cp1)
{
    float4 p0 = UnityObjectToClipPos(cp0.vertex);
    float4 p1 = UnityObjectToClipPos(cp1.vertex);
    float edgeLength = distance(p0.xy / p0.w, p1.xy / p1.w);
    float outPut = edgeLength * _ScreenParams.y / TESS_EDGE_LENGTH;
    outPut = clamp(0, 5, outPut) * 2;
    return outPut;
}

UnityTessellationFactors hsconst(InputPatch<InternalTessInterp_appdata, 3> v)
{
    UnityTessellationFactors o;
    o.edge[0] = TessellationEdgeFactor(v[1], v[2]);
    o.edge[1] = TessellationEdgeFactor(v[2], v[0]);
    o.edge[2] = TessellationEdgeFactor(v[0], v[1]);
    o.inside = (o.edge[0] + o.edge[1] + o.edge[2]) * (1 / 3.0);;
    return o;
}

[UNITY_domain("tri")]
[UNITY_partitioning("fractional_odd")]
[UNITY_outputtopology("triangle_cw")]
[UNITY_patchconstantfunc("hsconst")]
[UNITY_outputcontrolpoints(3)]
InternalTessInterp_appdata hs(InputPatch<InternalTessInterp_appdata, 3> v, uint id : SV_OutputControlPointID)
{
    return v[id];
}

[UNITY_domain("tri")]
v2f ds(UnityTessellationFactors tessFactors, const OutputPatch<InternalTessInterp_appdata, 3> vi,
       float3 bary : SV_DomainLocation)
{
    appdata v;

    v.vertex = vi[0].vertex * bary.x + vi[1].vertex * bary.y + vi[2].vertex * bary.z;
    v.normal = vi[0].normal * bary.x + vi[1].normal * bary.y + vi[2].normal * bary.z;
    v.uv = vi[0].uv * bary.x + vi[1].uv * bary.y + vi[2].uv * bary.z;

    v2f o = vert(v);
    return o;
}

//----------------------------------------------------------

// fixed4 frag(g2f i) : SV_Target
// {
//     float3 worldNormal = normalize(i.data.worldNormal);
//     float3 worldView = normalize(_WorldSpaceCameraPos - i.data.worldPos);
//     float3 worldLightDir = normalize(_WorldSpaceLightPos0.xyz);
//     float3 halfDir = normalize(worldLightDir + worldView);
//     float diff = max(dot(worldNormal, worldLightDir), 0);
//     float3 diffuse = diff * _LightColor0;
//
//     float minB = min(i.data.color.x, min(i.data.color.y, i.data.color.z));
//     i.data.color = smoothstep(0, fwidth(minB), minB);
//     float4 col;
//     col.rgb = i.data.color * diffuse;
//     return col;
// }
