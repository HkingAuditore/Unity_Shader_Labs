Shader "Cyber/cyberProjection"
{
    Properties
    {
        _CyberTex ("Cyber Texture", 2D) = "white" {}
        _CyberTexBack ("Cyber Texture Back", 2D) = "white" {}
        _MainTex ("Main Texture", 2D) = "white" {}

        [HDR]_EdgeColor("Edge Color", Color) = (1,1,1,1)
        [HDR]_OutsideColor("Outside Color", Color) = (1,1,1,1)

        _Speed("Speed", Range(-5,5)) = 1
        _OutlineThred("OutlineThred", Range(0,1)) = 0.5
        _Range("Range", Range(0,2)) = 1
        _Size("Size", Range(0,1)) = 0.5
    }
    SubShader
    {
        Tags { "RenderType"="Transparent" "Queue" = "Transparent" "IgnoreProjector" = "True" "ForceNoShadowCasting" = "True"}
        LOD 100
        Blend SrcAlpha OneMinusSrcAlpha


        Pass
        {
            // Cull Off

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
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
                UNITY_FOG_COORDS(3)
            };

            sampler2D _CyberTex;
            float4 _CyberTex_ST;
            float4 _CyberTex_TexelSize;

            sampler2D _MainTex;
            float4 _MainTex_ST;

            // fixed4 _MainColor;
            fixed4 _EdgeColor;

            fixed _Speed;
            fixed _Offset;
            float _Range;
            float _OutlineThred;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _CyberTex);
                o.objectPos = v.vertex;
                float3 viewDir = normalize( 
                    mul(unity_WorldToObject, 
                    float4(_WorldSpaceCameraPos.xyz, 1)).xyz - v.vertex);
				o.VdotN = dot(normalize(viewDir),v.normal);


                UNITY_TRANSFER_FOG(o,o.vertex);

                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // 流动动画
                fixed scroll = _Speed * _Time;
                fixed4 col = tex2D(_MainTex,i.uv);
                fixed scrollProject =abs(i.objectPos.x+scroll - round(i.objectPos.x+scroll));

                fixed4 cybercol = tex2D(_CyberTex, scrollProject);

                fixed alpha = 1;
                alpha -= i.objectPos.x;
                if(cybercol.r + cybercol.g + cybercol.b < 1){
                    alpha = 0; 
                    col = max(cybercol,col);
                } 


                //边缘光
                fixed edge = pow(i.VdotN, 1) / _Range;
	            edge = edge > _OutlineThred ? 1 : edge;   
                edge = 1 - edge;       
                //小于thred的部分视为边缘
	            fixed4 edgeCol = pow(edge, 0.1) * fixed4(_EdgeColor.rgb + fixed3(0.3,0.3,0.5) * (sin(_Time.y * 3)+1)*0.5,edge);
               //边缘颜色处理
                col = col*(1-edgeCol.a)+edgeCol*edgeCol.a;
                   

                UNITY_APPLY_FOG(i.fogCoord, col);

                return fixed4(col.rgb,alpha);
            }
            ENDCG
        }
        Pass
        {
            // Cull Off

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
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
                float4 vertex : SV_POSITION;
                float4 objectPos : TEXCOORD1;
                float4 VdotN : TEXCOORD2;
                UNITY_FOG_COORDS(3)
            };

            sampler2D _CyberTexBack;
            float4 _CyberTexBack_ST;
            float4 _CyberTexBack_TexelSize;

            sampler2D _MainTex;
            float4 _MainTex_ST;

            float4 _OutsideColor;

            // fixed4 _MainColor;
            fixed _Speed;
            fixed _Offset;
            fixed _Size;

            v2f vert (appdata v)
            {
                v2f o;
                v.vertex.x -= _Size;
                v.vertex.y -= _Size;
                v.vertex.z -= _Size;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _CyberTexBack);
                o.objectPos = v.vertex;


                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                fixed scroll = _Speed * _Time / 2;
                fixed4 col = tex2D(_MainTex,i.uv);
                fixed scrollProject =abs(i.objectPos.x+scroll - round(i.objectPos.x+scroll));

                fixed4 cybercol = tex2D(_CyberTexBack, scrollProject);

                fixed alpha = 1;
                if(cybercol.r + cybercol.g + cybercol.b < 1){
                    alpha = 0; 
                    col = min(cybercol,col);
                } 

                col *= _OutsideColor;

                   

                UNITY_APPLY_FOG(i.fogCoord, col);

                return fixed4(col.rgb,alpha*0.5);
            }
            ENDCG
        }
        Pass
        {
            // Cull Off

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
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
                float4 vertex : SV_POSITION;
                float4 objectPos : TEXCOORD1;
                float4 VdotN : TEXCOORD2;
                UNITY_FOG_COORDS(3)
            };

            sampler2D _CyberTexBack;
            float4 _CyberTexBack_ST;
            float4 _CyberTexBack_TexelSize;
            float4 _OutsideColor;


            sampler2D _MainTex;
            float4 _MainTex_ST;

            // fixed4 _MainColor;
            fixed _Speed;
            fixed _Offset;
            fixed _Size;


            v2f vert (appdata v)
            {
                v2f o;
                v.vertex.x += _Size;
                v.vertex.y += _Size;
                v.vertex.z += _Size;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _CyberTexBack);
                o.objectPos = v.vertex;


                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                fixed scroll = _Speed * _Time * 2;
                fixed4 col = tex2D(_MainTex,i.uv);
                fixed scrollProject =abs(i.objectPos.x+scroll - round(i.objectPos.x+scroll));

                fixed4 cybercol = tex2D(_CyberTexBack, scrollProject);

                fixed alpha = 1;
                if(cybercol.r + cybercol.g + cybercol.b < 1){
                    alpha = 0; 
                    col = min(cybercol,col);
                } 
                col *= _OutsideColor;


                   

                UNITY_APPLY_FOG(i.fogCoord, col);

                return fixed4(col.rgb,alpha*0.5);
            }
            ENDCG
        }
    }
}
