Shader "MultiUVs/MultiUvsEmission"
{
    Properties
    {
        _EmiTex ("Emission Texture", 2D) = "white" {}
        [HDR]_EmiColor("Emission Color", Color) = (1,1,1,1)
        [KeywordEnum(UV0, UV1, UV2, UV3)] _UVSet ("UV Set", Float) = 0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" "Queue" = "Opaque" "IgnoreProjector" = "True" "ForceNoShadowCasting" = "True"}
        LOD 100
        Blend SrcAlpha OneMinusSrcAlpha


        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_fog
            #pragma multi_compile _UVSET_UV0 _UVSET_UV1 _UVSET_UV2 _UVSET_UV3

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex   : POSITION;
                float2 uv0      : TEXCOORD0;
                float2 uv1      : TEXCOORD1;
                float2 uv2      : TEXCOORD2;
                float2 uv3      : TEXCOORD3;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };

            sampler2D _EmiTex;
            float4 _EmiTex_ST;

            float4 _EmiColor;
            float _UVSet;

            v2f vert (appdata v)
            {
                v2f o;

                #if _UVSET_UV0
                    float2 targetUv = v.uv0;
                #elif _UVSET_UV1
                    float2 targetUv = v.uv1;
                #elif _UVSET_UV2
                    float2 targetUv = v.uv2;
                #else
                    float2 targetUv = v.uv3;
                #endif

                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(targetUv, _EmiTex);
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                float indicator = (tex2D(_EmiTex,i.uv).r+tex2D(_EmiTex,i.uv).g+tex2D(_EmiTex,i.uv).b)*0.33;
                float4 col = _EmiColor * (1-indicator);
                UNITY_APPLY_FOG(i.fogCoord, col);
                return fixed4(col.rgb,_EmiColor.a);
            }
            ENDCG
        }
    }
}
