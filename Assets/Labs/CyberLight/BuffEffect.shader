Shader "Unlit/BuffEffect"
{
    Properties
    {
        _EffectTex ("Effect Texture", 2D) = "white" {}

        [HDR]_MainColor("Main Color", Color) = (1,1,1,1)
        [HDR]_EdgeColor("Edge Color", Color) = (1,1,1,1)
        [HDR]_FlowColor("Flow Color", Color) = (1,1,1,1)

        _Speed("Speed", float) = 1

        _Range("Range", Range(0,2)) = 1
        _OutlineThred("OutlineThred", Range(0,1)) = 0.5

    }
    SubShader
    {
        Tags { "RenderType"="Transparent" "Queue" = "Transparent" "IgnoreProjector" = "True" "ForceNoShadowCasting" = "True"}
        LOD 100
        Blend SrcAlpha OneMinusSrcAlpha


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
                fixed3 normal : NORMAL;

            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
                float4 objectPos : TEXCOORD1;
                float4 VdotN : TEXCOORD2;
                float3 viewDir : TEXCOORD3;
                float  width : TEXCOORD4;
                UNITY_FOG_COORDS(5)
            };

            sampler2D _EffectTex;
            float4 _EffectTex_ST;


            sampler2D _MainTex;
            float4 _MainTex_ST;

            fixed4 _MainColor;
            fixed4 _EdgeColor;
            fixed4 _FlowColor;

            fixed _Speed;
            fixed _Offset;
            float _Range;
            float _OutlineThred;


            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _EffectTex);
                o.objectPos = v.vertex;
                float3 viewDir = normalize( 
                    mul(unity_WorldToObject, 
                    float4(_WorldSpaceCameraPos.xyz, 1)).xyz - v.vertex);
                o.viewDir = viewDir;
				o.VdotN = dot(normalize(viewDir),v.normal);

                //根据视角缩放计算描边宽度
                fixed4 position_cs =  mul(UNITY_MATRIX_MV, v.vertex);
                position_cs /= position_cs.w;
                float width = -position_cs.z / (unity_CameraProjection[1].y);
                width = sqrt(width);
                o.width = width;


                UNITY_TRANSFER_FOG(o,o.vertex);

                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // 流动动画
                fixed scroll = _Speed * _Time;
                fixed4 col = _MainColor;
                fixed scrollProject =abs(i.objectPos.y+scroll - round(i.objectPos.y+scroll));

                fixed4 buffCol = tex2D(_EffectTex, fixed2(i.objectPos.x*3,scrollProject));
                fixed buffId = (buffCol.r +buffCol.g + buffCol.b)*0.33;


                //边缘光
                fixed edge = abs(i.VdotN  + (buffId*0.2) )/(1+smoothstep(0,1,_Range)); 
                edge = smoothstep(0,1,edge);
                edge = smoothstep(0,_OutlineThred,edge);   
                edge = 1 - edge;       

	            fixed4 edgeCol = fixed4(_EdgeColor.rgb + fixed3(0.2,0.2,0.2) * sin(_Time.y * _Speed)*0.5,abs(edge)*_EdgeColor.a);
                
                fixed4 flowCol = fixed4(_FlowColor.rgb,lerp(0,1,smoothstep(0,0.7,buffId*0.25+_FlowColor.a*0.2)));
                edgeCol = edgeCol*(1-flowCol.a)+flowCol*flowCol.a;
               //边缘颜色处理
                col = col*(1-edgeCol.a)+edgeCol*edgeCol.a;
                   

                UNITY_APPLY_FOG(i.fogCoord, col);
                return col;
            }
            ENDCG
        }
    }
}
