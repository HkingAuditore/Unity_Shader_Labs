﻿Shader "Wave/WaveSimulator"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}

		_OceanDeepColor("Ocean Deep Color",Color) = (1,1,1,1)
		_OceanShallowColor("Ocean Shallow Color",Color) = (1,1,1,1)
		_OceanSpecularColor("Ocean Specular Color",Color) = (1,1,1,1)
		_Fresnel("_Fresnel", Range(.001, 1)) = .5
		_Gloss("_Gloss", Range(0, 1)) = .5
		_Range("_Range", Range(0, 5)) = .5
		_OutlineThred("_Outline Thred", Range(0, 1)) = .5
		_FadeDistanceNear("_Fade Distance Near", Range(0, 100)) = .5
		_FadeDistanceFar("_Fade Distance Far", Range(0, 100)) = .5

		_FoamColor("Foam Color",Color) = (1,1,1,1)

		_TessellationEdgeLength("Tessellation Edge Length", Range(5, 1000)) = 50
		_TessellationIntensity("Tessellation Intensity", Range(1, 5)) = 2


	}

	SubShader
	{
		Tags { "LightMode" = "ForwardBase" }

		Pass
		{
			CGPROGRAM
			#pragma vertex tessvert
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
				float fade:TEXCOORD4;
			};

			struct g2f {
				v2f data;
				float2 barycentricCoordinates : TEXCOORD5;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			float _TessellationEdgeLength;
			float _TessellationIntensity;

			fixed4 _OceanDeepColor;
			fixed4 _OceanShallowColor;
			fixed4 _OceanSpecularColor;
			fixed _Gloss;
			fixed _Fresnel;
			fixed _Range;
			fixed _OutlineThred;
			fixed _FadeDistanceNear;
			fixed _FadeDistanceFar;
			
			fixed4 _FoamColor;


			v2f vert(appdata v)
			{
				v2f o;
				
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				fixed4 texCol = tex2Dlod(_MainTex, float4(o.uv * 0.5 , 0, 0));
				
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.vertex.y += 0.6 * cos(0.84 * v.vertex.x + 0.73 * v.vertex.z - 0.83 * _Time.y)
							+ 0.3 * cos(0.92 * v.vertex.x + 0.86 * v.vertex.z - 1.9 * _Time.y)
							+ 0.2 * cos(1.856 * v.vertex.x + 0.952 * v.vertex.z - 0.70 * _Time.y);
				o.vertex.y += (texCol.x+texCol.y+texCol.z)*0.333;
				o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
				o.worldNormal = UnityObjectToWorldNormal(v.normal);

				float posView = length(mul(UNITY_MATRIX_MV,v.vertex).xyz);
				o.fade = 1 - saturate((posView - _FadeDistanceNear) / (_FadeDistanceFar - _FadeDistanceNear));
				
				UNITY_TRANSFER_FOG(o,o.vertex);
				return o;
			}

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

			struct InternalTessInterp_appdata {
				float4 vertex : INTERNALTESSPOS;
				float3 normal : NORMAL;
				float2 uv : TEXCOORD0;
			};

			InternalTessInterp_appdata tessvert(appdata v) {
				InternalTessInterp_appdata o;
				o.vertex = v.vertex;
				o.normal = v.normal;
				o.uv = v.uv;
				return o;
			}

			float TessellationEdgeFactor(InternalTessInterp_appdata cp0, InternalTessInterp_appdata cp1) {
				float4 p0 = UnityObjectToClipPos(cp0.vertex);
				float4 p1 = UnityObjectToClipPos(cp1.vertex);
				float edgeLength = distance(p0.xy/p0.w, p1.xy/p1.w);
				float outPut = edgeLength * _ScreenParams.y / _TessellationEdgeLength;
				outPut = clamp(0, 5, outPut)*_TessellationIntensity;
				return outPut;
			}

			UnityTessellationFactors hsconst(InputPatch<InternalTessInterp_appdata,3> v) {
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
			InternalTessInterp_appdata hs(InputPatch<InternalTessInterp_appdata,3> v, uint id : SV_OutputControlPointID) {
			  return v[id];
			}

			[UNITY_domain("tri")]
			v2f ds(UnityTessellationFactors tessFactors, const OutputPatch<InternalTessInterp_appdata,3> vi, float3 bary : SV_DomainLocation) {
			  appdata v;

			  v.vertex = vi[0].vertex*bary.x + vi[1].vertex*bary.y + vi[2].vertex*bary.z;
			  v.normal = vi[0].normal*bary.x + vi[1].normal*bary.y + vi[2].normal*bary.z;
			  v.uv = vi[0].uv*bary.x + vi[1].uv*bary.y + vi[2].uv*bary.z;

			  v2f o = vert(v);
			  return o;
			}
			//----------------------------------------------------------

			fixed4 frag(g2f i) : SV_Target
			{
				float3 worldNormal = normalize(i.data.worldNormal);
				float3 worldView = normalize(_WorldSpaceCameraPos - i.data.worldPos);
				float vdotN = dot(worldView,worldNormal);
				float3 worldLightDir = normalize(_WorldSpaceLightPos0.xyz);
				float3 halfDir = normalize(worldLightDir + worldView);
				fixed3 ambient = UNITY_LIGHTMODEL_AMBIENT.rgb;
				fixed3 reflectDir = normalize(reflect(-worldLightDir, worldNormal));
				
				float3 diffuse =  max(dot(worldNormal, worldLightDir), 0) * _LightColor0;
				

				// float minB = min(i.data.color.x, min(i.data.color.y, i.data.color.z));
				// i.data.color = smoothstep(0, fwidth(minB), minB);
				
				float fresnel = pow( 1.0 - dot(i.data.worldNormal, normalize(UnityWorldSpaceViewDir(i.data.worldPos))), 1.636);
				float farControl = _Range * pow(i.data.fade,2.01);
				fresnel = pow(lerp(fresnel,farControl,0.2),1/farControl);
				//fresnel = 1.0 - pow(lerp(0.1,0.6,farControl),fresnel);
				fixed3 specular = _LightColor0.rgb * _OceanSpecularColor.rgb * pow(max(0.0,dot(reflectDir, halfDir)), 1 / _Gloss);
				
				float4 col = fixed4(0,0,0,1);
				col.rgb = lerp(	_OceanDeepColor,
								_OceanShallowColor,
								smoothstep(0.1,.5,fresnel * _Fresnel) * (specular + diffuse + ambient ) * smoothstep(_OceanDeepColor,_OceanShallowColor,_OceanShallowColor * 20));

				//return col;
				return fixed4(worldNormal,1);
			
				//return fixed4(farControl,farControl,farControl,1);
				return fixed4(fresnel,fresnel,fresnel,1);
			}
			ENDCG
		}
	}
}
