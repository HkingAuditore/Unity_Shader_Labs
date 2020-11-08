Shader "ToonFire/ToonFireFX"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _MaskTex ("Mask Texture", 2D) = "white" {}
        _RampTex("Ramp Tex",2D) = "white" {}
        
        _BackMaskSpeed ("Back Mask Speed", float) = .1
        _FrontMaskSpeed ("Front Mask Speed", float) = .8
        _FrontSize ("Front Size", Range(0,1)) = .5
        _FireClip ("Fire Clip", Range(0,1)) = .5
        _FireRampMap ("Fire Ramp Map", Range(0,1)) = .5
        _FireRampOffset ("Fire Ramp Offset", Range(-1,1)) = .5
    }
    SubShader
    {
        Tags {"Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent"}
        ZWrite Off
//        Cull Off ZWrite On ZTest Always
        Blend SrcAlpha OneMinusSrcAlpha
        LOD 100
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            sampler2D _MaskTex;
            float4 _MaskTex_ST;
            sampler2D _RampTex;

            float _BackMaskSpeed;
            float _FrontMaskSpeed;
            float _FrontSize;
            float _FireClip;
            float _FireRampMap;
            float _FireRampOffset;


            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                //火苗
                fixed4 baseShape = tex2D(_MainTex, i.uv);

                fixed2 backMaskUV = i.uv + _Time.y * fixed2(0,-_BackMaskSpeed);
                fixed backMask = tex2D(_MaskTex, backMaskUV).r;

                fixed2 frontMaskUV = fixed2(i.uv.x*1.5,i.uv.y) * _FrontSize + fixed2(_FrontSize,0)  + _Time.y * fixed2(0,-_FrontMaskSpeed);
                fixed frontMask = tex2D(_MaskTex, frontMaskUV).r;

                fixed mask = backMask * frontMask;
                fixed fire = baseShape.r*mask+baseShape.r;
                

                //RAMP
                fixed fireRampMap = saturate(pow(fire + _FireRampOffset,_FireRampMap));
                float3 col = tex2D(_RampTex, float2(fireRampMap,fireRampMap)).rgb;
                
                return fixed4(col,fire > _FireClip ? 1 : 0);
            }
            ENDCG
        }
    }
}
