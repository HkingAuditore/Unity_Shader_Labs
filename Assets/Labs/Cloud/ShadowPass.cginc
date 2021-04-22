#pragma target 3.0
#include "UnityCG.cginc"
#include "UnityPBSLighting.cginc"
#include "UnityStandardBRDF.cginc"
#pragma multi_compile_fwdadd_fullshadows
#pragma multi_compile_fwdbase
#include "Lighting.cginc" 
#include "AutoLight.cginc"
struct v2f
{
    float4 pos: SV_POSITION;
    half4 uv: TEXCOORD0;
    float3 worldNormal: TEXCOORD1;
    float3 worldPos: TEXCOORD2;
    SHADOW_COORDS(3)
};
sampler2D _MainTex;
half4 _MainTex_ST;
half4 _Color;
half _Shininess;
sampler2D _AOTex;
half4 _AO_ST;
half4 _AOColor;
half4 _RimColor;                         
half _RimPower;                          
half4 _ShadowColor;                      
half4 _ViewColor;                      
                     
sampler2D _FurTex;
half4 _FurTex_ST;
sampler2D _ShapeTex;
sampler2D _CloudRampTex;
half _Cutoff;                            
half _FurLength;                         
half _FurDensity;                        
half _FurThinness;                       
half _FurShading;
half  _CloudHeight;
half _CloudHeightThinness;
half4 _ForceGlobal;                       
half4 _ForceLocal;                        
half _WindAmplitude;                     
half _WindFrequency;                     
half _WindDistribution;
half _CloudSelfSpeed;
half4 _CustomLightDir;

v2f vert(appdata_base v)
{
    v2f o;

    v.vertex.x += ( sin(_WindDistribution + _Time.y * _WindFrequency) * _WindAmplitude) * v.texcoord.y*FURSTEP;
    v.vertex.y += ( cos( _WindDistribution + _Time.y * _WindFrequency) * _WindAmplitude) * v.texcoord.y*FURSTEP;

    float3 P = v.vertex.xyz + v.normal * _FurLength * FURSTEP;
    P += clamp(mul(unity_WorldToObject, _ForceGlobal).xyz + _ForceLocal.xyz, -1, 1) * pow(FURSTEP, 3) * _FurLength;
    o.pos = UnityObjectToClipPos(float4(P, 1.0));    o.uv.xy = TRANSFORM_TEX(v.texcoord, _MainTex);
    o.uv.zw = TRANSFORM_TEX(v.texcoord, _FurTex);
    o.worldNormal = UnityObjectToWorldNormal(v.normal);
    o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
    TRANSFER_SHADOW(o)  

    return o;
}

fixed4 frag(v2f i): SV_Target
{

    fixed3 noise = tex2D(_FurTex, i.uv.zw).rgb;
    fixed alpha = clamp(noise, 0, 1);

    clip(alpha-_Cutoff);

    return _Color;
}


