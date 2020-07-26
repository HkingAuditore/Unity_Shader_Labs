// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

Shader "Unlit/Outline"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _BrushTex("Brush Texture" , 2D)  = "white" {}

        _MainColor("Main Color" , Color)  = (0,0,0,1)
        _OutlineColor("Outline Color" , Color)  = (0,0,0,1)


        _OutlineThred("Outline Thred" , Range(0.01,2)) = 0.25
        _OutlinePow("Outline Pow" , Range(0,3)) = 2
        _OutlineRange("Outline Range" , Range(0,6)) = 0.25
        _Size("Size",Range(0,3))=0


        _BrushPow("Brush Pow" , Range(0,1)) = 0.25
        _BrushRange("Brush Range" , Range(0,1)) = 0.25
        _Hstep("HorizontalStep", Range(0,1)) = 0.5
        _Vstep("VerticalStep", Range(0,1)) = 0.5  
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        Blend SrcAlpha OneMinusSrcAlpha
        LOD 100
        
        Pass
        {

            Blend SrcAlpha OneMinusSrcAlpha
            cull front
            // Zwrite off
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
                float3 normal:NORMAL;
            };
 
            struct v2f
            {
                float2 uv : TEXCOORD0;
 
                float4 vertex : SV_POSITION;
            };
 
            sampler2D _MainTex;
            float4 _MainTex_ST;

            sampler2D _BrushTex;
            float4 _BrushTex_ST;

            float4 _OutlineColor;
            float _Size;
            
            v2f vert (appdata v)
            {
                v2f o;
                // 采样笔刷噪点
                float4 brushNoise = tex2Dlod(_BrushTex, v.vertex);


                // 法线外扩
                float4 Vpos=mul(UNITY_MATRIX_MV,v.vertex);
                float3 Vnormal=mul(UNITY_MATRIX_IT_MV,v.normal);
                Vnormal.z=-0.05;

                fixed4 position_cs =  mul(UNITY_MATRIX_MV, v.vertex);
                position_cs /= position_cs.w;

                //根据视角缩放计算描边宽度 
                float linewidth = -position_cs.z / (unity_CameraProjection[1].y);
                linewidth = sqrt(linewidth);

                float3 viewDir = normalize(position_cs.xyz);
                float3 scaledir = mul((float3x3)UNITY_MATRIX_MV, normalize(v.normal.xyz));
                float3 offset_pos_cs = position_cs.xyz + viewDir * 0.5;

                o.vertex=mul(UNITY_MATRIX_P,Vpos + float4(Vnormal,0)* _Size * (brushNoise.r + brushNoise.g + brushNoise.b) * 1.1 *linewidth  / 40);
                position_cs.xy = offset_pos_cs.xy + scaledir.xy * linewidth * brushNoise.x * _Size ;
				position_cs.z = offset_pos_cs.z;
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                o.vertex = mul(UNITY_MATRIX_P, position_cs);
 
                return o;
            }
            
            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 col = tex2D(_BrushTex, i.uv);     
                if (col.x + col.y + col.z > 1.3)
		            discard;        
           
                return fixed4(_OutlineColor.xyz,col.a * 0.8);
            }
            ENDCG
        }
        Pass
        {
            Blend SrcAlpha OneMinusSrcAlpha
            cull front
            // Zwrite off
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
                float3 normal:NORMAL;
            };
 
            struct v2f
            {
                float2 uv : TEXCOORD0;
 
                float4 vertex : SV_POSITION;
            };
 
            sampler2D _MainTex;
            float4 _MainTex_ST;

            sampler2D _BrushTex;
            float4 _BrushTex_ST;

            float4 _OutlineColor;
            float _Size;
            
            v2f vert (appdata v)
            {
                v2f o;
                // 采样笔刷噪点
                float4 brushNoise = tex2Dlod(_BrushTex, v.vertex);


                // 法线外扩
                float4 Vpos=mul(UNITY_MATRIX_MV,v.vertex);
                float3 Vnormal=mul(UNITY_MATRIX_IT_MV,v.normal);
                Vnormal.z=-0.05;

                fixed4 position_cs =  mul(UNITY_MATRIX_MV, v.vertex);
                position_cs /= position_cs.w;

                //根据视角缩放计算描边宽度 
                float linewidth = -position_cs.z / (unity_CameraProjection[1].y);
                linewidth = sqrt(linewidth);

                float3 viewDir = normalize(position_cs.xyz);
                float3 scaledir = mul((float3x3)UNITY_MATRIX_MV, normalize(v.normal.xyz));
                float3 offset_pos_cs = position_cs.xyz + viewDir * 0.5;

                o.vertex=mul(UNITY_MATRIX_P,Vpos + float4(Vnormal,0)* _Size * (brushNoise.r + brushNoise.g + brushNoise.b) * 0.65 *linewidth  / 40);
                position_cs.xy = offset_pos_cs.xy + scaledir.xy * linewidth * brushNoise.x * _Size ;
				position_cs.z = offset_pos_cs.z;
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                o.vertex = mul(UNITY_MATRIX_P, position_cs);
 
                return o;
            }
            
            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 col = tex2D(_MainTex, i.uv);                
                return fixed4(_OutlineColor.xyz,col.a * 0.8);
            }
            ENDCG
        }

        Pass
        {
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
				float4 worldPos : TEXCOORD1;
				UNITY_FOG_COORDS(4)
				float4 vertex : SV_POSITION;
				float VdotN : TEXCOORD2;
                float3 worldNormal : TEXCOORD3;  
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            sampler2D _BrushTex;
            float4 _BrushTex_ST;

            fixed4 _Outline;
            fixed4 _MainColor;
            fixed _OutlineThred;
            fixed _OutlineRange;
            fixed _OutlinePow;
            fixed _BrushPow;
            fixed _BrushRange;

            fixed _Hstep;
            fixed _Vstep;


            v2f vert (appdata v)
            {
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.worldPos = mul(unity_ObjectToWorld , v.vertex);
                o.uv = v .uv;
				float3 viewDir = normalize( 
                    mul(unity_WorldToObject, 
                    float4(_WorldSpaceCameraPos.xyz, 1)).xyz - v.vertex);
				o.VdotN = dot(normalize(viewDir),v.normal);
                o.worldNormal = mul(v.normal, (float3x3)unity_WorldToObject);  
				UNITY_TRANSFER_FOG(o,o.vertex);
				return o;

            }


            fixed4 frag (v2f i) : SV_Target
            {
                // 采样
                fixed4 col = tex2D(_MainTex, i.uv) * _MainColor;                
                fixed4 brushTex = tex2D(_BrushTex, i.uv);     




                //光照
                fixed3 worldNormal = normalize(i.worldNormal);
				fixed3 worldLightDir = normalize(UnityWorldSpaceLightDir(i.worldPos));
                fixed diff =  dot(worldNormal, worldLightDir);
                diff *= (brushTex.x+brushTex.y+brushTex.z) * 0.7;
                diff = (diff * 0.5 + 0.5);
                if(diff < 0.4){
                    diff = 0.3;
                }else if(diff < 0.6){
                    diff = 0.5;
                }else{
                    diff = 1;
                }
                

                //灰度
                fixed brushGrey = pow((brushTex.r + brushTex.g + brushTex.b)*0.33,diff * _BrushPow);


                //边缘计算gray
                fixed edge = pow(i.VdotN, 1) / (_OutlineRange * brushGrey);
	            edge = edge > _OutlineThred * brushGrey ? 1 : edge;// 小于thred的部分视为边缘
	            edge = pow(edge, _OutlinePow); //边缘颜色处理

                UNITY_APPLY_FOG(i.fogCoord, col);
                
                fixed gray = (brushGrey > _BrushRange ? 1:pow(pow(brushGrey,i.uv.x * 0.2),i.uv.y)) * (edge+0.5 * diff)/2;

                fixed4 output = gray * col;

                return float4(output.rgb, 1.0);
                return float4(diff,diff,diff, 1.0);
                // return fixed4(tmp.xyz, col.a * brushTex.a);


            }
            ENDCG
        }


    }
}
