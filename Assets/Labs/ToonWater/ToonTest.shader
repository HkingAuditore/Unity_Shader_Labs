// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ToonWater/ToonTest"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _BumpMap ("Bumpmap", 2D) = "bump" {}

        _SeaColor0("SeaColor0", Color) = (0.05098039,0.2470588,1,0.6509804)
        _SeaColor1("SeaColor1", Color) = (0.05098039,0.2470588,1,0.6509804)
        _RimColor("RimColor", Color) = (0.05098039,0.2470588,1,0.6509804)
        _Outline("Outline", Color) = (0.05098039,0.2470588,1,0.6509804)
        _RampThreshold("RampThreshold", Range( 0 , 1)) = .5
        _RampSmooth("RampSmooth", Range( 0 , 1)) = .5
        _RimThreshold("RimThreshold", Range( 0 , 1)) = .5
        _RimSmooth("RimSmooth", Range( 0 , 1)) = .5

        _TessMinDistance1("TessMinDistance", Range( 0 , 10)) = 1
        _TessMaxDistance1("TessMaxDistance", Range( 2 , 240)) = 240
        _TessFactor1("TessFactor", Range( 1 , 128)) = 32
        [HideInInspector] __dirty( "", Int ) = 1
    }

    SubShader
    {
        Tags
        {
            "RenderType" = "Transparent" "Queue" = "Transparent+0" "IgnoreProjector" = "True"
        }
        Cull Back
        CGPROGRAM
#include "UnityShaderVariables.cginc"
        #include "UnityCG.cginc"
        #include "UnityStandardUtils.cginc"
        #include "Tessellation.cginc"
        #pragma target 4.6
        #pragma surface surf SimpleSpecular alpha:fade keepalpha noshadow vertex:vert tessellate:tessFunction
        struct Input
        {
            half filler;
            float3 worldPos;
            float4 screenPos;
            float3 worldRefl;
            float2 uv_MainTex;
            float2 uv_BumpMap;
            float3 viewDir;
            INTERNAL_DATA
            float3 worldNormal;
        };

        uniform float _TessMinDistance1;
        uniform float _TessMaxDistance1;
        uniform float _TessFactor1;

        sampler2D _MainTex;
        sampler2D _BumpMap;

        float4 _SeaColor0;
        float4 _SeaColor1;
        float4 _RimColor;

        float _RampSmooth;
        float _RampThreshold;
        float _RimSmooth;
        float _RimThreshold;

        float4 tessFunction(appdata_full v0, appdata_full v1, appdata_full v2)
        {
            return UnityDistanceBasedTess(v0.vertex, v1.vertex, v2.vertex, _TessMinDistance1, _TessMaxDistance1,
                                          _TessFactor1);
        }

        float hash(float n)
        {
            return frac(sin(n) * 43758.5453);
        }

        float hash(float2 p)
        {
            return frac(sin(dot(p, float2(127.1, 311.7))) * 43758.5453123);
        }

        float noise(in float2 p)
        {
            float2 i = floor(p);
            float2 f = frac(p);
            f = f * f * (3.0 - 2.0 * f);

            return -1.0 + 2.0 * lerp(lerp(hash(i + float2(0.0, 0.0)),
                                          hash(i + float2(1.0, 0.0)), f.x),
                                     lerp(hash(i + float2(0.0, 1.0)),
                                          hash(i + float2(1.0, 1.0)), f.x), f.y);
        }

        float sea_octave(float2 uv, float choppy)
        {
            uv += noise(uv);
            float2 wv = 1.0 - abs(sin(uv));
            float2 swv = abs(cos(uv));
            wv = lerp(wv, swv, wv);
            return pow(1.0 - pow(wv.x * wv.y, 0.65), choppy);
        }

        float udRoundBox(float3 p, float3 b, float r)
        {
            return length(max(abs(p) - b, 0.0)) - r;
        }

        float map(in float3 pos)
        {
            // pos *= cubeForm;
            // pos.y += Yelevation;

            pos.y += 3.66;
            pos.z += 0.4;
            pos *= 0.35;

            float res = udRoundBox(pos - float3(0.0, 1.25, 0.0), float3(0.15, 0.15, 0.15), 0.01);
            res = min(res, udRoundBox(pos - float3(0.33, 1.25, 0.0), float3(0.15, 0.15, 0.15), 0.01));
            res = min(res, udRoundBox(pos - float3(0.33, 1.25, 0.33), float3(0.15, 0.15, 0.15), 0.01));
            res = min(res, udRoundBox(pos - float3(0.0, 1.25, 0.33), float3(0.15, 0.15, 0.15), 0.01));

            res = min(res, udRoundBox(pos - float3(0.0, 1.58, 0.0), float3(0.15, 0.15, 0.15), 0.01));
            res = min(res, udRoundBox(pos - float3(0.0, 1.58, 0.33), float3(0.15, 0.15, 0.15), 0.01));
            res = min(res, udRoundBox(pos - float3(0.33, 1.58, 0.0), float3(0.15, 0.15, 0.15), 0.01));
            return res;
        }

        float mapWater(float3 p, int steps)
        {
            float freq = 0.16;
            float amp = 0.6;
            float choppy = 8.0;
            float2 uv = p.xy;
            uv.x *= 0.75;

            float d, h = 0.0;
            const float SEA_SPEED = 1.8;
            const float2x2 octave_m = float2x2(1.6, 1.2, -1.2, 1.6);
            float seaTime = (1.0 + _Time.y * SEA_SPEED);
            for (int i = 0; i < steps; i++)
            {
                d = sea_octave((uv + seaTime) * freq, choppy);
                d += sea_octave((uv - seaTime) * freq, choppy);
                h += d * amp;
                uv = mul(uv, octave_m);
                freq *= 0.9;
                amp *= 0.22;
                choppy = lerp(choppy, 1.0, 0.2);
            }

            return h - 0.2 * exp(-max(0.0, 1.0 * map(p)));
        }

        float3 getNormalWater(float3 p, float eps)
        {
            float3 n;
            n.y = mapWater(p, 5);
            n.x = mapWater(float3(p.x + eps, p.y, p.z), 5);
            n.z = mapWater(float3(p.x, p.y, p.z + eps), 5);
            n.y = eps;
            return n;
        }

        void vert(inout appdata_full v)
        {
            float3 org = (float3(6.0*cos(v.normal.x), lerp(2.2, 10.0, v.normal.y), 6.0*sin(v.normal.z)));
            float3 dist = org;
            v.vertex.xyz += getNormalWater(v.vertex.xyz, dot(dist,dist) * 0.83f);
            v.normal = normalize(getNormalWater(v.vertex.xyz, dot(dist,dist) * 0.83f));
        }

        float Schlick(float f0, float VoH)
        {
            return f0 + (1. - f0) * pow(1.0 - VoH, 5.0);
        }

        half4 LightingSimpleSpecular(SurfaceOutput s, half3 lightDir, half3 viewDir, half atten)
        {
            half3 normalDir = normalize(s.Normal);

            float ndl = max(0, dot(normalDir, lightDir));
            float ndv = max(0, dot(normalDir, viewDir));

            fixed3 lightColor = _LightColor0.rgb;
            fixed3 ramp = smoothstep(_RampThreshold - _RampSmooth * 0.5, _RampThreshold + _RampSmooth * 0.5, ndl);
            ramp *= atten;
            float3 rampColor = lerp(_SeaColor0.rgb, _SeaColor1.rgb, ramp);

            fixed4 color;
            fixed3 diffuse = s.Albedo * lightColor * rampColor;

            float rim = (1.0 - ndv) * ndl;
            rim *= atten;
            rim = smoothstep(_RimThreshold - _RimSmooth * 0.5, _RimThreshold + _RimSmooth * 0.5, rim);
            fixed3 rimColor = _RimColor.rgb * lightColor * _RimColor.a * rim;

            color.rgb = diffuse + rimColor;
            color.a = s.Alpha;
            return color;
        }

        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
            o.Albedo = _SeaColor0;
            o.Alpha = 1;
        }
        ENDCG

    }
    //Fallback "Diffuse"
    CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18000
1920;-10;1920;1019;1287;290;1;True;False
Node;AmplifyShaderEditor.RangedFloatNode;1;-683.6302,268.335;Inherit;False;Property;_TessFactor1;TessFactor;2;0;Create;True;0;0;False;0;32;14.8;1;128;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2;-685.5018,455.3778;Inherit;False;Property;_TessMaxDistance1;TessMaxDistance;1;0;Create;True;0;0;False;0;240;240;2;240;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;3;-685.0072,361.1917;Inherit;False;Property;_TessMinDistance1;TessMinDistance;0;0;Create;True;0;0;False;0;1;0;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceBasedTessNode;4;-361.8607,339.0957;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;-1;6;ASEMaterialInspector;0;0;StandardSpecular;ToonWater/ToonTest;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;True;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;4;0;1;0
WireConnection;4;1;3;0
WireConnection;4;2;2;0
WireConnection;0;14;4;0
ASEEND*/
//CHKSM=BCEEAC611138D7CA836BC7082372026ACAD2EBD1