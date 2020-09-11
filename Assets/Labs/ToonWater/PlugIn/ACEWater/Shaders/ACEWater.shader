// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ACE/Water"
{
	Properties
	{
		_WaterColor("WaterColor", Color) = (0.05098039,0.2470588,1,0.6509804)
		_WaterColor2("WaterColor2", Color) = (0.3254902,1,0.9921569,0.5333334)
		_ScatteringColor("ScatteringColor", Color) = (0,0.792304,1,0.6392157)
		[HDR]_FogColor("FogColor", Color) = (0,0.8451186,0.9528302,0.05098039)
		_MaxDepth("MaxDepth", Float) = 3
		_TessMinDistance("TessMinDistance", Range( 0 , 10)) = 1
		_TessMaxDistance("TessMaxDistance", Range( 2 , 240)) = 240
		_TessFactor("TessFactor", Range( 1 , 128)) = 32
		_WaveHeight00("WaveHeight00", Float) = 0.2
		_WaveSteepness00("WaveSteepness00", Range( 0 , 1)) = 1
		_WaveParam00("WaveParam00", Vector) = (1,0,0.5,1)
		_WaveHeight01("WaveHeight01", Float) = 0.1
		_WaveSteepness01("WaveSteepness01", Range( 0 , 1)) = 1
		_WaveParam01("WaveParam01", Vector) = (1,1,0.5,1)
		_WaveHeight02("WaveHeight02", Float) = 0.2
		_WaveSteepness02("WaveSteepness02", Range( 0 , 1)) = 1
		_WaveParam02("WaveParam02", Vector) = (0,-0.75,0.5,2)
		[Toggle(_GERSTNERGROUP1_ON)] _GerstnerGroup1("GerstnerGroup1", Float) = 0
		_WaveHeight10("WaveHeight10", Float) = 0.2
		_WaveSteepness20("WaveSteepness20", Range( 0 , 1)) = 1
		_WaveParam10("WaveParam10", Vector) = (1,0,0.5,1)
		_WaveHeight11("WaveHeight11", Float) = 0.1
		_WaveSteepness11("WaveSteepness11", Range( 0 , 1)) = 1
		_WaveParam11("WaveParam11", Vector) = (1,1,0.5,1)
		_WaveHeight12("WaveHeight12", Float) = 0.2
		_WaveSteepness12("WaveSteepness12", Range( 0 , 1)) = 1
		_WaveParam12("WaveParam12", Vector) = (0,-0.75,0.5,2)
		[Toggle(_GERSTNERGROUP2_ON)] _GerstnerGroup2("GerstnerGroup2", Float) = 0
		_WaveHeight20("WaveHeight20", Float) = 0.2
		_WaveSteepness10("WaveSteepness10", Range( 0 , 1)) = 1
		_WaveParam20("WaveParam20", Vector) = (1,0,0.5,1)
		_WaveHeight21("WaveHeight21", Float) = 0.1
		_WaveSteepness21("WaveSteepness21", Range( 0 , 1)) = 1
		_WaveParam21("WaveParam21", Vector) = (1,1,0.5,1)
		_WaveHeight22("WaveHeight22", Float) = 0.2
		_WaveSteepness22("WaveSteepness22", Range( 0 , 1)) = 1
		_WaveParam22("WaveParam22", Vector) = (0,-0.75,0.5,2)
		_SkyCube("SkyCube", CUBE) = "white" {}
		_SkyScale("SkyScale", Range( 0 , 1)) = 0.348
		_SkyFresnelBias("SkyFresnelBias", Float) = -0.01
		_SkyFresnelScale("SkyFresnelScale", Float) = 0.11
		_SkyFresnelPower("SkyFresnelPower", Float) = -0.5
		_RefractionScale("RefractionScale", Float) = 1
		_RefractionDepthScale("RefractionDepthScale", Float) = 0.2
		_Refraction("Refraction", Float) = 0.02
		_RefractionMaxDepth("RefractionMaxDepth", Float) = 10
		[Normal]_NormalMap("NormalMap", 2D) = "bump" {}
		_NormalScale("NormalScale", Float) = 1
		_NormalUVTileTotal("NormalUVTileTotal", Float) = 0.22
		_NormalUVMapMoveScale0("NormalUVMapMoveScale0", Vector) = (0.001,0.1,1,0)
		_NormalUVMapMoveScale1("NormalUVMapMoveScale1", Vector) = (-0.09,0.06,1,0)
		_FoamColor("FoamColor", Color) = (1,1,1,1)
		_FoamTexture("FoamTexture", 2D) = "white" {}
		_FoamUVTileTotal("FoamUVTileTotal", Float) = 0.22
		_FoamUVMapMoveScale0("FoamUVMapMoveScale0", Vector) = (0.001,0.1,1,0)
		_FoamUVMapMoveScale1("FoamUVMapMoveScale1", Vector) = (-0.09,0.06,1,0)
		_FoamDensity01("FoamDensity01", Range( 0 , 1)) = 0
		_FoamDensity11("FoamDensity11", Range( 0 , 1)) = 0
		_FoamWidth01("FoamWidth01", Range( 0 , 1)) = 0
		_FoamWidth11("FoamWidth11", Range( 0 , 1)) = 0
		_FoamWidth02("FoamWidth02", Range( 0 , 1)) = 0
		_FoamWidth12("FoamWidth12", Range( 0 , 1)) = 0
		_FoamWidth03("FoamWidth03", Range( 0 , 1)) = 0
		_SunColor("SunColor", Color) = (1,1,1,0)
		_SunDir("SunDir", Vector) = (0.7,-0.6,0.77,0)
		_SunShininess("SunShininess", Range( 0 , 1000)) = 1
		_SunInensity("SunInensity", Range( 0 , 10)) = 0.6470312
		_GlitteringClamp("GlitteringClamp", Range( 0 , 1)) = 0
		_GlitteringPow("GlitteringPow", Range( 0 , 1000)) = 0
		_DistanceFadeMin("DistanceFadeMin", Float) = 0
		_DistanceFadeWidth("DistanceFadeWidth", Float) = 100
		_CausticsTexture("CausticsTexture", 2D) = "white" {}
		_CausticsIntensity("CausticsIntensity", Range( 0 , 1)) = 0.5
		_CausticsUVTileTotal("CausticsUVTileTotal", Float) = 0.22
		_CausticsUVMapMoveScale0("CausticsUVMapMoveScale0", Vector) = (0.001,0.1,1,0)
		_CausticsUVMapMoveScale1("CausticsUVMapMoveScale1", Vector) = (-0.09,0.06,1,0)
		_NoiseTexture("NoiseTexture", 2D) = "white" {}
		_NoiseScale("NoiseScale", Float) = 0.1
		_Smoohness("Smoohness", Range( 0 , 1)) = 0
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		GrabPass{ }
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		#include "UnityStandardUtils.cginc"
		#include "Tessellation.cginc"
		#pragma target 4.6
		#pragma shader_feature _GERSTNERGROUP1_ON
		#pragma shader_feature _GERSTNERGROUP2_ON
		#if defined(UNITY_STEREO_INSTANCING_ENABLED) || defined(UNITY_STEREO_MULTIVIEW_ENABLED)
		#define ASE_DECLARE_SCREENSPACE_TEXTURE(tex) UNITY_DECLARE_SCREENSPACE_TEXTURE(tex);
		#else
		#define ASE_DECLARE_SCREENSPACE_TEXTURE(tex) UNITY_DECLARE_SCREENSPACE_TEXTURE(tex)
		#endif
		#pragma surface surf StandardSpecular alpha:fade keepalpha noshadow vertex:vertexDataFunc tessellate:tessFunction 
		struct Input
		{
			float3 worldPos;
			float4 screenPos;
			float3 worldRefl;
			INTERNAL_DATA
			float3 worldNormal;
		};

		uniform float _WaveHeight00;
		uniform float _WaveSteepness00;
		uniform float4 _WaveParam00;
		uniform float _WaveHeight01;
		uniform float _WaveSteepness01;
		uniform float4 _WaveParam01;
		uniform float _WaveHeight02;
		uniform float _WaveSteepness02;
		uniform float4 _WaveParam02;
		uniform float _WaveHeight10;
		uniform float _WaveSteepness10;
		uniform float4 _WaveParam10;
		uniform float _WaveHeight11;
		uniform float _WaveSteepness11;
		uniform float4 _WaveParam11;
		uniform float _WaveHeight12;
		uniform float _WaveSteepness12;
		uniform float4 _WaveParam12;
		uniform float _WaveHeight20;
		uniform float _WaveSteepness20;
		uniform float4 _WaveParam20;
		uniform float _WaveHeight21;
		uniform float _WaveSteepness21;
		uniform float4 _WaveParam21;
		uniform float _WaveHeight22;
		uniform float _WaveSteepness22;
		uniform float4 _WaveParam22;
		UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
		uniform float4 _CameraDepthTexture_TexelSize;
		uniform float _RefractionScale;
		uniform float _Refraction;
		uniform sampler2D _NormalMap;
		uniform float4 _NormalUVMapMoveScale0;
		uniform float _NormalUVTileTotal;
		uniform float4 _NormalUVMapMoveScale1;
		uniform float _NormalScale;
		uniform float _RefractionDepthScale;
		uniform float _MaxDepth;
		uniform float _FoamWidth01;
		uniform float _FoamWidth02;
		uniform float _FoamDensity01;
		uniform sampler2D _FoamTexture;
		uniform float4 _FoamUVMapMoveScale0;
		uniform float _FoamUVTileTotal;
		uniform float4 _FoamUVMapMoveScale1;
		uniform float _FoamWidth11;
		uniform float _FoamWidth12;
		uniform float _FoamDensity11;
		uniform float _FoamWidth03;
		uniform float4 _FoamColor;
		uniform sampler2D _CausticsTexture;
		uniform sampler2D _NoiseTexture;
		uniform float _NoiseScale;
		uniform float4 _CausticsUVMapMoveScale0;
		uniform float _CausticsUVTileTotal;
		uniform float4 _CausticsUVMapMoveScale1;
		uniform float _CausticsIntensity;
		uniform float _RefractionMaxDepth;
		ASE_DECLARE_SCREENSPACE_TEXTURE( _GrabTexture )
		uniform float4 _WaterColor2;
		uniform float4 _WaterColor;
		uniform float4 _ScatteringColor;
		uniform float4 _FogColor;
		uniform samplerCUBE _SkyCube;
		uniform float _SkyFresnelBias;
		uniform float _SkyFresnelScale;
		uniform float _SkyFresnelPower;
		uniform float _SkyScale;
		uniform float4 _SunColor;
		uniform float _DistanceFadeMin;
		uniform float _DistanceFadeWidth;
		uniform float _GlitteringPow;
		uniform float _GlitteringClamp;
		uniform float3 _SunDir;
		uniform float _SunShininess;
		uniform float _SunInensity;
		uniform float _Smoohness;
		uniform float _TessMinDistance;
		uniform float _TessMaxDistance;
		uniform float _TessFactor;


		float3 Gerstner( float2 pos , float amplitude , float steepness , float4 param , out float3 normal , out float3 tangent )
		{
			 float2 direction = param.xy;
			    float frequency = 1.0 / param.z;
			    float phase = param.w * frequency;
			    steepness = clamp(0, param.z / amplitude, steepness);
			 float f = dot(pos, direction) * frequency - phase * _Time.y;
			    float sin_f = sin(f);
			    float cos_f = cos(f);
			    float qa = steepness * amplitude;
			 float wa = frequency * amplitude;
			    float qwa = steepness * wa;
			    float3 displacement;
			    displacement.x = direction.x * qa * cos_f;
			    displacement.y = direction.y * qa * cos_f;
			    displacement.z = amplitude * sin_f;
			    normal.xy = direction * (wa * cos_f);
			    normal.z = qwa * sin_f - 1;
			    tangent.x = qwa * direction.x * direction.y * sin_f;
			    tangent.y = qwa * direction.y * direction.y * sin_f - 1;
			    tangent.z = -wa * direction.y * cos_f;
			    return displacement;
		}


		float4 tessFunction( appdata_full v0, appdata_full v1, appdata_full v2 )
		{
			return UnityDistanceBasedTess( v0.vertex, v1.vertex, v2.vertex, _TessMinDistance,_TessMaxDistance,_TessFactor);
		}

		void vertexDataFunc( inout appdata_full v )
		{
			float4 ase_vertexTangent = v.tangent;
			float3 ase_vertex3Pos = v.vertex.xyz;
			float2 temp_output_12_0_g498 = (ase_vertex3Pos).xy;
			float2 pos7_g499 = temp_output_12_0_g498;
			float amplitude7_g499 = _WaveHeight00;
			float steepness7_g499 = _WaveSteepness00;
			float4 param7_g499 = _WaveParam00;
			float3 normal7_g499 = float3( 0,0,0 );
			float3 tangent7_g499 = float3( 0,0,0 );
			float3 localGerstner7_g499 = Gerstner( pos7_g499 , amplitude7_g499 , steepness7_g499 , param7_g499 , normal7_g499 , tangent7_g499 );
			float2 pos7_g500 = temp_output_12_0_g498;
			float amplitude7_g500 = _WaveHeight01;
			float steepness7_g500 = _WaveSteepness01;
			float4 param7_g500 = _WaveParam01;
			float3 normal7_g500 = float3( 0,0,0 );
			float3 tangent7_g500 = float3( 0,0,0 );
			float3 localGerstner7_g500 = Gerstner( pos7_g500 , amplitude7_g500 , steepness7_g500 , param7_g500 , normal7_g500 , tangent7_g500 );
			float2 pos7_g501 = temp_output_12_0_g498;
			float amplitude7_g501 = _WaveHeight02;
			float steepness7_g501 = _WaveSteepness02;
			float4 param7_g501 = _WaveParam02;
			float3 normal7_g501 = float3( 0,0,0 );
			float3 tangent7_g501 = float3( 0,0,0 );
			float3 localGerstner7_g501 = Gerstner( pos7_g501 , amplitude7_g501 , steepness7_g501 , param7_g501 , normal7_g501 , tangent7_g501 );
			float3 _Vector1 = float3(0,0,0);
			float2 temp_output_12_0_g473 = (ase_vertex3Pos).xy;
			float2 pos7_g474 = temp_output_12_0_g473;
			float amplitude7_g474 = _WaveHeight10;
			float steepness7_g474 = _WaveSteepness10;
			float4 param7_g474 = _WaveParam10;
			float3 normal7_g474 = float3( 0,0,0 );
			float3 tangent7_g474 = float3( 0,0,0 );
			float3 localGerstner7_g474 = Gerstner( pos7_g474 , amplitude7_g474 , steepness7_g474 , param7_g474 , normal7_g474 , tangent7_g474 );
			float2 pos7_g475 = temp_output_12_0_g473;
			float amplitude7_g475 = _WaveHeight11;
			float steepness7_g475 = _WaveSteepness11;
			float4 param7_g475 = _WaveParam11;
			float3 normal7_g475 = float3( 0,0,0 );
			float3 tangent7_g475 = float3( 0,0,0 );
			float3 localGerstner7_g475 = Gerstner( pos7_g475 , amplitude7_g475 , steepness7_g475 , param7_g475 , normal7_g475 , tangent7_g475 );
			float2 pos7_g476 = temp_output_12_0_g473;
			float amplitude7_g476 = _WaveHeight12;
			float steepness7_g476 = _WaveSteepness12;
			float4 param7_g476 = _WaveParam12;
			float3 normal7_g476 = float3( 0,0,0 );
			float3 tangent7_g476 = float3( 0,0,0 );
			float3 localGerstner7_g476 = Gerstner( pos7_g476 , amplitude7_g476 , steepness7_g476 , param7_g476 , normal7_g476 , tangent7_g476 );
			#ifdef _GERSTNERGROUP1_ON
				float3 staticSwitch514 = ( localGerstner7_g474 + localGerstner7_g475 + localGerstner7_g476 );
			#else
				float3 staticSwitch514 = _Vector1;
			#endif
			float3 _Vector2 = float3(0,0,0);
			float2 temp_output_12_0_g494 = (ase_vertex3Pos).xy;
			float2 pos7_g495 = temp_output_12_0_g494;
			float amplitude7_g495 = _WaveHeight20;
			float steepness7_g495 = _WaveSteepness20;
			float4 param7_g495 = _WaveParam20;
			float3 normal7_g495 = float3( 0,0,0 );
			float3 tangent7_g495 = float3( 0,0,0 );
			float3 localGerstner7_g495 = Gerstner( pos7_g495 , amplitude7_g495 , steepness7_g495 , param7_g495 , normal7_g495 , tangent7_g495 );
			float2 pos7_g496 = temp_output_12_0_g494;
			float amplitude7_g496 = _WaveHeight21;
			float steepness7_g496 = _WaveSteepness21;
			float4 param7_g496 = _WaveParam21;
			float3 normal7_g496 = float3( 0,0,0 );
			float3 tangent7_g496 = float3( 0,0,0 );
			float3 localGerstner7_g496 = Gerstner( pos7_g496 , amplitude7_g496 , steepness7_g496 , param7_g496 , normal7_g496 , tangent7_g496 );
			float2 pos7_g497 = temp_output_12_0_g494;
			float amplitude7_g497 = _WaveHeight22;
			float steepness7_g497 = _WaveSteepness22;
			float4 param7_g497 = _WaveParam22;
			float3 normal7_g497 = float3( 0,0,0 );
			float3 tangent7_g497 = float3( 0,0,0 );
			float3 localGerstner7_g497 = Gerstner( pos7_g497 , amplitude7_g497 , steepness7_g497 , param7_g497 , normal7_g497 , tangent7_g497 );
			#ifdef _GERSTNERGROUP2_ON
				float3 staticSwitch546 = ( localGerstner7_g495 + localGerstner7_g496 + localGerstner7_g497 );
			#else
				float3 staticSwitch546 = _Vector2;
			#endif
			float3 temp_output_12_0_g509 = ( ( localGerstner7_g499 + localGerstner7_g500 + localGerstner7_g501 ) + staticSwitch514 + staticSwitch546 );
			float3 ase_vertexNormal = v.normal.xyz;
			float3 ase_vertexBitangent = cross( ase_vertexNormal, ase_vertexTangent) * v.tangent.w * unity_WorldTransformParams.w;
			v.vertex.xyz += ( ( ase_vertexTangent.xyz * (temp_output_12_0_g509).x ) + ( ase_vertexBitangent * (temp_output_12_0_g509).y ) + ( ase_vertexNormal * (temp_output_12_0_g509).z ) );
			#ifdef _GERSTNERGROUP1_ON
				float3 staticSwitch515 = ( normal7_g474 + normal7_g475 + normal7_g476 );
			#else
				float3 staticSwitch515 = _Vector1;
			#endif
			#ifdef _GERSTNERGROUP2_ON
				float3 staticSwitch545 = ( normal7_g495 + normal7_g496 + normal7_g497 );
			#else
				float3 staticSwitch545 = _Vector2;
			#endif
			float3 normalizeResult18 = normalize( ( ( normal7_g499 + normal7_g500 + normal7_g501 ) + staticSwitch515 + staticSwitch545 ) );
			v.normal = normalizeResult18;
		}

		void surf( Input i , inout SurfaceOutputStandardSpecular o )
		{
			o.Normal = float3(0,0,1);
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float customSurfaceDepth94 = -UnityObjectToViewPos( ase_vertex3Pos ).z;
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float4 ase_vertex4Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float3 ase_viewPos = UnityObjectToViewPos( ase_vertex4Pos );
			float ase_screenDepth = -ase_viewPos.z;
			float clampDepth = ase_screenDepth * _ProjectionParams.w;
			float3 worldToViewDir3_g504 = mul( UNITY_MATRIX_V, float4( float3(0,1,0), 0 ) ).xyz;
			float2 appendResult132 = (float2(_NormalUVMapMoveScale0.x , _NormalUVMapMoveScale0.y));
			float3 ase_worldPos = i.worldPos;
			float2 appendResult131 = (float2(_NormalUVMapMoveScale1.x , _NormalUVMapMoveScale1.y));
			float2 temp_output_12_0_g498 = (ase_vertex3Pos).xy;
			float2 pos7_g499 = temp_output_12_0_g498;
			float amplitude7_g499 = _WaveHeight00;
			float steepness7_g499 = _WaveSteepness00;
			float4 param7_g499 = _WaveParam00;
			float3 normal7_g499 = float3( 0,0,0 );
			float3 tangent7_g499 = float3( 0,0,0 );
			float3 localGerstner7_g499 = Gerstner( pos7_g499 , amplitude7_g499 , steepness7_g499 , param7_g499 , normal7_g499 , tangent7_g499 );
			float2 pos7_g500 = temp_output_12_0_g498;
			float amplitude7_g500 = _WaveHeight01;
			float steepness7_g500 = _WaveSteepness01;
			float4 param7_g500 = _WaveParam01;
			float3 normal7_g500 = float3( 0,0,0 );
			float3 tangent7_g500 = float3( 0,0,0 );
			float3 localGerstner7_g500 = Gerstner( pos7_g500 , amplitude7_g500 , steepness7_g500 , param7_g500 , normal7_g500 , tangent7_g500 );
			float2 pos7_g501 = temp_output_12_0_g498;
			float amplitude7_g501 = _WaveHeight02;
			float steepness7_g501 = _WaveSteepness02;
			float4 param7_g501 = _WaveParam02;
			float3 normal7_g501 = float3( 0,0,0 );
			float3 tangent7_g501 = float3( 0,0,0 );
			float3 localGerstner7_g501 = Gerstner( pos7_g501 , amplitude7_g501 , steepness7_g501 , param7_g501 , normal7_g501 , tangent7_g501 );
			float3 _Vector1 = float3(0,0,0);
			float2 temp_output_12_0_g473 = (ase_vertex3Pos).xy;
			float2 pos7_g474 = temp_output_12_0_g473;
			float amplitude7_g474 = _WaveHeight10;
			float steepness7_g474 = _WaveSteepness10;
			float4 param7_g474 = _WaveParam10;
			float3 normal7_g474 = float3( 0,0,0 );
			float3 tangent7_g474 = float3( 0,0,0 );
			float3 localGerstner7_g474 = Gerstner( pos7_g474 , amplitude7_g474 , steepness7_g474 , param7_g474 , normal7_g474 , tangent7_g474 );
			float2 pos7_g475 = temp_output_12_0_g473;
			float amplitude7_g475 = _WaveHeight11;
			float steepness7_g475 = _WaveSteepness11;
			float4 param7_g475 = _WaveParam11;
			float3 normal7_g475 = float3( 0,0,0 );
			float3 tangent7_g475 = float3( 0,0,0 );
			float3 localGerstner7_g475 = Gerstner( pos7_g475 , amplitude7_g475 , steepness7_g475 , param7_g475 , normal7_g475 , tangent7_g475 );
			float2 pos7_g476 = temp_output_12_0_g473;
			float amplitude7_g476 = _WaveHeight12;
			float steepness7_g476 = _WaveSteepness12;
			float4 param7_g476 = _WaveParam12;
			float3 normal7_g476 = float3( 0,0,0 );
			float3 tangent7_g476 = float3( 0,0,0 );
			float3 localGerstner7_g476 = Gerstner( pos7_g476 , amplitude7_g476 , steepness7_g476 , param7_g476 , normal7_g476 , tangent7_g476 );
			#ifdef _GERSTNERGROUP1_ON
				float3 staticSwitch516 = ( tangent7_g474 + tangent7_g475 + tangent7_g476 );
			#else
				float3 staticSwitch516 = _Vector1;
			#endif
			float3 _Vector2 = float3(0,0,0);
			float2 temp_output_12_0_g494 = (ase_vertex3Pos).xy;
			float2 pos7_g495 = temp_output_12_0_g494;
			float amplitude7_g495 = _WaveHeight20;
			float steepness7_g495 = _WaveSteepness20;
			float4 param7_g495 = _WaveParam20;
			float3 normal7_g495 = float3( 0,0,0 );
			float3 tangent7_g495 = float3( 0,0,0 );
			float3 localGerstner7_g495 = Gerstner( pos7_g495 , amplitude7_g495 , steepness7_g495 , param7_g495 , normal7_g495 , tangent7_g495 );
			float2 pos7_g496 = temp_output_12_0_g494;
			float amplitude7_g496 = _WaveHeight21;
			float steepness7_g496 = _WaveSteepness21;
			float4 param7_g496 = _WaveParam21;
			float3 normal7_g496 = float3( 0,0,0 );
			float3 tangent7_g496 = float3( 0,0,0 );
			float3 localGerstner7_g496 = Gerstner( pos7_g496 , amplitude7_g496 , steepness7_g496 , param7_g496 , normal7_g496 , tangent7_g496 );
			float2 pos7_g497 = temp_output_12_0_g494;
			float amplitude7_g497 = _WaveHeight22;
			float steepness7_g497 = _WaveSteepness22;
			float4 param7_g497 = _WaveParam22;
			float3 normal7_g497 = float3( 0,0,0 );
			float3 tangent7_g497 = float3( 0,0,0 );
			float3 localGerstner7_g497 = Gerstner( pos7_g497 , amplitude7_g497 , steepness7_g497 , param7_g497 , normal7_g497 , tangent7_g497 );
			#ifdef _GERSTNERGROUP2_ON
				float3 staticSwitch544 = ( tangent7_g495 + tangent7_g496 + tangent7_g497 );
			#else
				float3 staticSwitch544 = _Vector2;
			#endif
			float3 normalizeResult135 = normalize( ( ( tangent7_g499 + tangent7_g500 + tangent7_g501 ) + staticSwitch516 + staticSwitch544 ) );
			#ifdef _GERSTNERGROUP1_ON
				float3 staticSwitch515 = ( normal7_g474 + normal7_g475 + normal7_g476 );
			#else
				float3 staticSwitch515 = _Vector1;
			#endif
			#ifdef _GERSTNERGROUP2_ON
				float3 staticSwitch545 = ( normal7_g495 + normal7_g496 + normal7_g497 );
			#else
				float3 staticSwitch545 = _Vector2;
			#endif
			float3 normalizeResult18 = normalize( ( ( normal7_g499 + normal7_g500 + normal7_g501 ) + staticSwitch515 + staticSwitch545 ) );
			float3 temp_output_136_0 = mul( ( BlendNormals( UnpackNormal( tex2D( _NormalMap, ( ( _Time.y * appendResult132 ) + ( ( _NormalUVMapMoveScale0.z * _NormalUVTileTotal ) * (ase_worldPos).xz ) ) ) ) , UnpackNormal( tex2D( _NormalMap, ( ( _Time.y * appendResult131 ) + ( ( _NormalUVTileTotal * _NormalUVMapMoveScale1.z ) * (ase_worldPos).xz ) ) ) ) ) * _NormalScale ), float3x3(normalizeResult135, cross( normalizeResult18 , normalizeResult135 ), normalizeResult18) );
			float3 objToWorldDir257 = normalize( mul( unity_ObjectToWorld, float4( temp_output_136_0, 0 ) ).xyz );
			float3 worldToViewDir5_g504 = mul( UNITY_MATRIX_V, float4( objToWorldDir257, 0 ) ).xyz;
			float2 temp_output_12_0_g504 = ( min( ( _RefractionScale * clampDepth ) , _Refraction ) * ( (worldToViewDir3_g504).xz - (worldToViewDir5_g504).xz ) );
			float clampDepth9_g504 = Linear01Depth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, float4( ( (ase_screenPosNorm).xy + temp_output_12_0_g504 ), 0.0 , 0.0 ).xy ));
			float2 temp_output_276_0 = saturate( ( (ase_screenPosNorm).xy + ( ( step( clampDepth , clampDepth9_g504 ) * temp_output_12_0_g504 ) * saturate( ( ( clampDepth9_g504 - clampDepth ) * _RefractionDepthScale ) ) ) ) );
			float eyeDepth95 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, float4( temp_output_276_0, 0.0 , 0.0 ).xy ));
			float temp_output_252_0 = saturate( (0.0 + (( ( 1.0 - ( customSurfaceDepth94 / eyeDepth95 ) ) * (( _WorldSpaceCameraPos - ase_worldPos )).y ) - 0.0) * (1.0 - 0.0) / (_MaxDepth - 0.0)) );
			float2 appendResult55 = (float2(_FoamUVMapMoveScale0.x , _FoamUVMapMoveScale0.y));
			float2 appendResult56 = (float2(_FoamUVMapMoveScale1.x , _FoamUVMapMoveScale1.y));
			float3 temp_output_251_0 = saturate( ( ( ( ( 1.0 - saturate( ( ( temp_output_252_0 - _FoamWidth01 ) * _FoamWidth02 ) ) ) * _FoamDensity01 ) * ( (( tex2D( _FoamTexture, ( ( _Time.y * appendResult55 ) + ( ( _FoamUVMapMoveScale0.z * _FoamUVTileTotal ) * (ase_worldPos).xz ) ) ) + tex2D( _FoamTexture, ( ( _Time.y * appendResult56 ) + ( ( _FoamUVTileTotal * _FoamUVMapMoveScale1.z ) * (ase_worldPos).xz ) ) ) )).rgb * 0.5 ) ) + ( ( 1.0 - saturate( ( ( temp_output_252_0 - _FoamWidth11 ) * _FoamWidth12 ) ) ) * _FoamDensity11 ) ) );
			float temp_output_240_0 = (temp_output_251_0).x;
			float2 appendResult492 = (float2(ase_worldPos.x , ase_worldPos.y));
			float4 tex2DNode490 = tex2D( _NoiseTexture, ( ( _Time.y + appendResult492 ) * _NoiseScale ) );
			float2 appendResult497 = (float2(tex2DNode490.r , tex2DNode490.g));
			float2 appendResult444 = (float2(_CausticsUVMapMoveScale0.x , _CausticsUVMapMoveScale0.y));
			float2 appendResult446 = (float2(_CausticsUVMapMoveScale1.x , _CausticsUVMapMoveScale1.y));
			float temp_output_188_0 = ( 1.0 - saturate( (0.0 + (( eyeDepth95 - customSurfaceDepth94 ) - 0.0) * (1.0 - 0.0) / (_RefractionMaxDepth - 0.0)) ) );
			float4 screenColor98 = UNITY_SAMPLE_SCREENSPACE_TEXTURE(_GrabTexture,temp_output_276_0);
			float temp_output_143_0 = saturate( ( _WaterColor.a * temp_output_252_0 ) );
			float3 lerpResult151 = lerp( (_WaterColor2).rgb , (_WaterColor).rgb , ( temp_output_143_0 * temp_output_143_0 ));
			float3 lerpResult142 = lerp( lerpResult151 , (_ScatteringColor).rgb , saturate( ( _ScatteringColor.a * temp_output_252_0 ) ));
			float3 lerpResult149 = lerp( lerpResult142 , (_FogColor).rgb , _FogColor.a);
			float3 blendOpSrc191 = (screenColor98).rgb;
			float3 blendOpDest191 = lerpResult149;
			float3 lerpBlendMode191 = lerp(blendOpDest191,(( blendOpDest191 > 0.5 ) ? ( 1.0 - 2.0 * ( 1.0 - blendOpDest191 ) * ( 1.0 - blendOpSrc191 ) ) : ( 2.0 * blendOpDest191 * blendOpSrc191 ) ),temp_output_188_0);
			float3 temp_output_425_0 = ( ( (( ( tex2D( _CausticsTexture, ( appendResult497 + ( ( _Time.y * appendResult444 ) + ( ( _CausticsUVMapMoveScale0.z * _CausticsUVTileTotal ) * (ase_worldPos).xz ) ) ) ) * 0.5 ) + tex2D( _CausticsTexture, ( appendResult497 + ( ( _Time.y * appendResult446 ) + ( ( _CausticsUVTileTotal * _CausticsUVMapMoveScale1.z ) * (ase_worldPos).xz ) ) ) ) )).rgb * _CausticsIntensity * temp_output_188_0 ) + ( saturate( lerpBlendMode191 )) );
			float3 ifLocalVar222 = 0;
			if( temp_output_240_0 > _FoamWidth03 )
				ifLocalVar222 = ( (_FoamColor).rgb * temp_output_251_0 );
			else if( temp_output_240_0 == _FoamWidth03 )
				ifLocalVar222 = temp_output_425_0;
			else if( temp_output_240_0 < _FoamWidth03 )
				ifLocalVar222 = temp_output_425_0;
			o.Albedo = ifLocalVar222;
			float4 color270 = IsGammaSpace() ? float4(0,0,0,0) : float4(0,0,0,0);
			float3 newWorldReflection48 = normalize( WorldReflectionVector( i , temp_output_136_0 ) );
			float3 ase_worldViewDir = Unity_SafeNormalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float fresnelNdotV50 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode50 = ( _SkyFresnelBias + _SkyFresnelScale * pow( 1.0 - fresnelNdotV50, _SkyFresnelPower ) );
			float smoothstepResult392 = smoothstep( _DistanceFadeMin , _DistanceFadeWidth , length( (( ase_worldPos - _WorldSpaceCameraPos )).xz ));
			float clampResult381 = clamp( pow( (newWorldReflection48).y , _GlitteringPow ) , 0.0 , _GlitteringClamp );
			float3 objToWorldDir309 = mul( unity_ObjectToWorld, float4( temp_output_136_0, 0 ) ).xyz;
			float3 normalizeResult531 = normalize( _SunDir );
			float3 normalizeResult307 = normalize( ( ase_worldViewDir + normalizeResult531 ) );
			float dotResult308 = dot( objToWorldDir309 , normalizeResult307 );
			float3 temp_output_324_0 = ( ( ( (texCUBE( _SkyCube, newWorldReflection48 )).rgb * fresnelNode50 ) * _SkyScale ) + ( (_SunColor).rgb * ( ( smoothstepResult392 * clampResult381 ) + ( pow( saturate( dotResult308 ) , _SunShininess ) * _SunInensity ) ) ) );
			float3 ifLocalVar269 = 0;
			if( temp_output_240_0 <= _FoamWidth03 )
				ifLocalVar269 = temp_output_324_0;
			else
				ifLocalVar269 = (color270).rgb;
			o.Emission = ifLocalVar269;
			o.Smoothness = _Smoohness;
			o.Alpha = 1;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspect"
}
/*ASEBEGIN
Version=18000
1920;-10;1920;1019;1237.59;1613.918;2.451535;False;False
Node;AmplifyShaderEditor.Vector4Node;539;-5865.165,3791.146;Inherit;False;Property;_WaveParam22;WaveParam22;36;0;Create;True;0;0;False;0;0,-0.75,0.5,2;0,-0.75,0.6,2;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector4Node;541;-6218.175,3647.146;Inherit;False;Property;_WaveParam20;WaveParam20;30;0;Create;True;0;0;False;0;1,0,0.5,1;1.06,0.23,3.79,8.83;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;537;-6443.884,3573.366;Inherit;False;Property;_WaveSteepness22;WaveSteepness22;35;0;Create;True;0;0;False;0;1;-0.46;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;535;-6442.175,3487.146;Inherit;False;Property;_WaveSteepness21;WaveSteepness21;32;0;Create;True;0;0;False;0;1;1.3;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;534;-6440.466,3407.146;Inherit;False;Property;_WaveSteepness20;WaveSteepness20;19;0;Create;True;0;0;False;0;1;1.05;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;540;-6058.175,3375.146;Inherit;False;Property;_WaveHeight22;WaveHeight22;34;0;Create;True;0;0;False;0;0.2;0.13;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;536;-6074.175,3215.146;Inherit;False;Property;_WaveHeight20;WaveHeight20;28;0;Create;True;0;0;False;0;0.2;0.15;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;538;-6042.175,3711.146;Inherit;False;Property;_WaveParam21;WaveParam21;33;0;Create;True;0;0;False;0;1,1,0.5,1;1,1,0.83,1;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;506;-6128,2416;Inherit;False;Property;_WaveHeight11;WaveHeight11;21;0;Create;True;0;0;False;0;0.1;0.14;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;533;-6074.175,3295.146;Inherit;False;Property;_WaveHeight21;WaveHeight21;31;0;Create;True;0;0;False;0;0.1;0.14;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;505;-6112,2496;Inherit;False;Property;_WaveHeight12;WaveHeight12;24;0;Create;True;0;0;False;0;0.2;0.13;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;507;-5920,2912;Inherit;False;Property;_WaveParam12;WaveParam12;26;0;Create;True;0;0;False;0;0,-0.75,0.5,2;0,-0.75,0.6,2;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector4Node;503;-6096,2832;Inherit;False;Property;_WaveParam11;WaveParam11;23;0;Create;True;0;0;False;0;1,1,0.5,1;1,1,0.83,1;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;508;-6497.709,2694.22;Inherit;False;Property;_WaveSteepness12;WaveSteepness12;25;0;Create;True;0;0;False;0;1;-0.46;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;502;-6128,2336;Inherit;False;Property;_WaveHeight10;WaveHeight10;18;0;Create;True;0;0;False;0;0.2;0.15;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;504;-6496,2608;Inherit;False;Property;_WaveSteepness11;WaveSteepness11;22;0;Create;True;0;0;False;0;1;1.3;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;509;-6494.291,2528;Inherit;False;Property;_WaveSteepness10;WaveSteepness10;29;0;Create;True;0;0;False;0;1;1.05;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;510;-6272,2768;Inherit;False;Property;_WaveParam10;WaveParam10;20;0;Create;True;0;0;False;0;1,0,0.5,1;1.06,0.23,3.79,8.83;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;29;-6512,1728;Inherit;False;Property;_WaveSteepness00;WaveSteepness00;9;0;Create;True;0;0;False;0;1;1.05;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;28;-6144,1696;Inherit;False;Property;_WaveHeight02;WaveHeight02;14;0;Create;True;0;0;False;0;0.2;0.13;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;32;-6288,1968;Inherit;False;Property;_WaveParam00;WaveParam00;10;0;Create;True;0;0;False;0;1,0,0.5,1;1.06,0.23,3.79,8.83;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;31;-6512,1888;Inherit;False;Property;_WaveSteepness02;WaveSteepness02;15;0;Create;True;0;0;False;0;1;-0.46;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-6144,1552;Inherit;False;Property;_WaveHeight00;WaveHeight00;8;0;Create;True;0;0;False;0;0.2;0.15;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;34;-5952,2128;Inherit;False;Property;_WaveParam02;WaveParam02;16;0;Create;True;0;0;False;0;0,-0.75,0.5,2;0,-0.75,0.6,2;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;30;-6512,1808;Inherit;False;Property;_WaveSteepness01;WaveSteepness01;12;0;Create;True;0;0;False;0;1;1.3;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;33;-6112,2032;Inherit;False;Property;_WaveParam01;WaveParam01;13;0;Create;True;0;0;False;0;1,1,0.5,1;1,1,0.83,1;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector4Node;129;-5862.066,988.9139;Inherit;False;Property;_NormalUVMapMoveScale1;NormalUVMapMoveScale1;51;0;Create;True;0;0;False;0;-0.09,0.06,1,0;0.03,0.001,0.5,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector4Node;124;-5862.816,516.5392;Inherit;False;Property;_NormalUVMapMoveScale0;NormalUVMapMoveScale0;50;0;Create;True;0;0;False;0;0.001,0.1,1,0;0.001,0.1,0.2,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;27;-6144,1616;Inherit;False;Property;_WaveHeight01;WaveHeight01;11;0;Create;True;0;0;False;0;0.1;0.14;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;123;-5846.816,788.5389;Inherit;False;Property;_NormalUVTileTotal;NormalUVTileTotal;49;0;Create;True;0;0;False;0;0.22;0.3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;517;-5573.752,2267.427;Inherit;False;Constant;_Vector1;Vector 1;67;0;Create;True;0;0;False;0;0,0,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.FunctionNode;542;-5706.175,3391.146;Inherit;False;GerstnerWaveX3;-1;;494;da0432b290a00594e83efed3eeb65c75;0;9;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT4;0,0,0,0;False;9;FLOAT4;0,0,0,0;False;10;FLOAT4;0,0,0,0;False;3;FLOAT3;15;FLOAT3;0;FLOAT3;16
Node;AmplifyShaderEditor.Vector3Node;543;-5519.927,3146.573;Inherit;False;Constant;_Vector2;Vector 1;67;0;Create;True;0;0;False;0;0,0,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.FunctionNode;501;-5760,2512;Inherit;False;GerstnerWaveX3;-1;;473;da0432b290a00594e83efed3eeb65c75;0;9;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT4;0,0,0,0;False;9;FLOAT4;0,0,0,0;False;10;FLOAT4;0,0,0,0;False;3;FLOAT3;15;FLOAT3;0;FLOAT3;16
Node;AmplifyShaderEditor.DynamicAppendNode;132;-5478.066,556.9142;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;544;-5197.893,3444.417;Inherit;False;Property;_GerstnerGroup2;GerstnerGroup1;27;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Reference;546;False;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StaticSwitch;545;-5208.475,3331.025;Inherit;False;Property;_GerstnerGroup3;GerstnerGroup1;27;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Reference;546;False;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StaticSwitch;515;-5262.3,2451.879;Inherit;False;Property;_GerstnerGroup1;GerstnerGroup1;17;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Reference;514;False;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StaticSwitch;516;-5251.718,2565.271;Inherit;False;Property;_GerstnerGroup1;GerstnerGroup1;17;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Reference;514;False;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;138;-5776,1712;Inherit;False;GerstnerWaveX3;-1;;498;da0432b290a00594e83efed3eeb65c75;0;9;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT4;0,0,0,0;False;9;FLOAT4;0,0,0,0;False;10;FLOAT4;0,0,0,0;False;3;FLOAT3;15;FLOAT3;0;FLOAT3;16
Node;AmplifyShaderEditor.DynamicAppendNode;131;-5494.066,988.9139;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;117;-5494.066,700.9141;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;125;-5478.066,876.9137;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;512;-4846.628,2108.719;Inherit;False;3;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;126;-5222.066,588.9142;Inherit;False;WaterUV;-1;;502;92d4681b6e0fd3e41a1a096df51a9c42;0;2;2;FLOAT2;1,0;False;8;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;513;-4842.9,2250.659;Inherit;False;3;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TexturePropertyNode;133;-5032.304,707.2673;Inherit;True;Property;_NormalMap;NormalMap;47;1;[Normal];Create;True;0;0;False;0;a6472d3ac6f8173458bd73f66710e618;a6472d3ac6f8173458bd73f66710e618;True;bump;Auto;Texture2D;-1;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.FunctionNode;119;-5222.066,908.9139;Inherit;False;WaterUV;-1;;503;92d4681b6e0fd3e41a1a096df51a9c42;0;2;2;FLOAT2;1,0;False;8;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;128;-4662.066,652.9142;Inherit;True;Property;_TextureSample4;Texture Sample 4;87;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.NormalizeNode;135;-4398.371,1768.749;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NormalizeNode;18;-4398.321,1695.535;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;121;-4662.066,844.9138;Inherit;True;Property;_TextureSample3;Texture Sample 3;87;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;130;-4070.068,876.9137;Inherit;False;Property;_NormalScale;NormalScale;48;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.BlendNormalsNode;134;-4267.301,762.1788;Inherit;False;0;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CrossProductOpNode;111;-4198.62,1277.034;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.MatrixFromVectors;112;-3772.583,1242.401;Inherit;False;FLOAT3x3;True;4;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3x3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;122;-3878.068,764.9139;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;136;-3485.747,961.2318;Inherit;False;2;2;0;FLOAT3;1,0,0;False;1;FLOAT3x3;1,0,0,1,0,0,1,0,1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;295;-3320.703,476.077;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;294;-3347.303,354.4756;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;293;-4829.324,316.4747;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;292;-4852.127,267.074;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;290;-4822.158,-1393.065;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldPosInputsNode;491;-2119.355,-2501.18;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WireNode;291;-4796.95,-1442.792;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleTimeNode;496;-1859.876,-2578.673;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;492;-1832.872,-2468.305;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TransformDirectionNode;257;-4492.006,-1501.196;Inherit;False;Object;World;True;Fast;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.FunctionNode;276;-4203.593,-1473.274;Inherit;False;Refraction;42;;504;07e6eef5367028a4bbcf1b3d60556e23;0;1;1;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;494;-1721.331,-2367.332;Inherit;False;Property;_NoiseScale;NoiseScale;78;0;Create;True;0;0;False;0;0.1;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;495;-1666.149,-2489.441;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PosVertexDataNode;93;-4313.188,-1251.286;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WorldPosInputsNode;102;-3928.299,-731.1782;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.Vector4Node;442;-1862.602,-2274.514;Inherit;False;Property;_CausticsUVMapMoveScale0;CausticsUVMapMoveScale0;75;0;Create;True;0;0;False;0;0.001,0.1,1,0;-0.03,0.04,1.04,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;493;-1527.603,-2450.694;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ScreenDepthNode;95;-3950.64,-1398.119;Inherit;False;0;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;443;-1846.602,-2002.514;Inherit;False;Property;_CausticsUVTileTotal;CausticsUVTileTotal;74;0;Create;True;0;0;False;0;0.22;0.2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;489;-1516.223,-2727.46;Inherit;True;Property;_NoiseTexture;NoiseTexture;77;0;Create;True;0;0;False;0;9ba1cb507c1a0df40bbc151b84efdcec;9bcc0538ff18cfa4b962f477ae06711d;False;white;Auto;Texture2D;-1;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.WorldSpaceCameraPos;103;-3991.973,-899.2733;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SurfaceDepthNode;94;-4031.923,-1255.046;Inherit;False;0;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;444;-1494.602,-2242.514;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;106;-3647.521,-1104.082;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;490;-1246.99,-2608.025;Inherit;True;Property;_TextureSample7;Texture Sample 7;54;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector4Node;441;-1877.302,-1809.215;Inherit;False;Property;_CausticsUVMapMoveScale1;CausticsUVMapMoveScale1;76;0;Create;True;0;0;False;0;-0.09,0.06,1,0;-0.05,-0.04,0.46,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;445;-1510.602,-2098.514;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;104;-3652.136,-795.9333;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;105;-3502.888,-1151.854;Inherit;False;Constant;_Float1;Float 1;75;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;101;-3509.801,-1388.226;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;447;-1494.602,-1922.515;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;255;-3204.377,-1166.652;Inherit;False;Property;_RefractionMaxDepth;RefractionMaxDepth;46;0;Create;True;0;0;False;0;10;6.11;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;181;-3156.089,-1295.465;Inherit;False;Constant;_Float4;Float 4;32;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;497;-939.2303,-2566.923;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;446;-1510.602,-1810.515;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ComponentMaskNode;107;-3420.617,-799.1042;Inherit;False;False;True;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;448;-1238.602,-2210.514;Inherit;False;WaterUV;-1;;505;92d4681b6e0fd3e41a1a096df51a9c42;0;2;2;FLOAT2;1,0;False;8;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;108;-3343.213,-1091.768;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;182;-3150.889,-1393.065;Inherit;False;Constant;_Float6;Float 6;32;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;450;-1238.602,-1890.515;Inherit;False;WaterUV;-1;;506;92d4681b6e0fd3e41a1a096df51a9c42;0;2;2;FLOAT2;1,0;False;8;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;164;-2764.187,-692.6582;Inherit;False;Constant;_Float2;Float 2;32;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;183;-2918.598,-1463.386;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;163;-2764.187,-813.6582;Inherit;False;Constant;_Float0;Float 0;32;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;401;-1038.676,-2060.799;Inherit;True;Property;_CausticsTexture;CausticsTexture;72;0;Create;True;0;0;False;0;89d36441cc98b6a43a20ba938c57741d;9bcc0538ff18cfa4b962f477ae06711d;False;white;Auto;Texture2D;-1;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.RangedFloatNode;159;-2972.635,-761.288;Inherit;False;Property;_MaxDepth;MaxDepth;4;0;Create;True;0;0;False;0;3;2.75;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;498;-805.856,-2396.866;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;109;-2987.708,-903.7624;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;194;-2615.86,-1454.14;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;530;-3540.441,2445.6;Inherit;False;Property;_SunDir;SunDir;65;0;Create;True;0;0;False;0;0.7,-0.6,0.77;0,0,0.77;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;488;-366.175,-2073.643;Inherit;False;Constant;_Float3;Float 3;53;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;53;-4110.125,-241.5611;Inherit;False;Property;_FoamUVTileTotal;FoamUVTileTotal;54;0;Create;True;0;0;False;0;0.22;0.2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;452;-678.6021,-2146.514;Inherit;True;Property;_TextureSample6;Texture Sample 6;87;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector4Node;52;-4126.125,-513.5611;Inherit;False;Property;_FoamUVMapMoveScale0;FoamUVMapMoveScale0;55;0;Create;True;0;0;False;0;0.001,0.1,1,0;-0.03,0.04,1.04,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCRemapNode;156;-2526.696,-860.5796;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;499;-824.6937,-1864.382;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector4Node;54;-4142.125,-49.5615;Inherit;False;Property;_FoamUVMapMoveScale1;FoamUVMapMoveScale1;56;0;Create;True;0;0;False;0;-0.09,0.06,1,0;-0.05,-0.04,0.46,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;55;-3758.125,-481.5612;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;58;-3774.125,-337.5612;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;227;-1826.622,-499.9083;Inherit;False;Property;_FoamWidth01;FoamWidth01;59;0;Create;True;0;0;False;0;0;0.633;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;451;-678.6021,-1954.515;Inherit;True;Property;_TextureSample5;Texture Sample 5;87;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;252;-2241.112,-886.3575;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;57;-3758.125,-161.5614;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalizeNode;531;-3256.441,2453.6;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode;56;-3774.125,-49.5615;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;487;-199.961,-2148.013;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;154;-2241.154,-1337.517;Inherit;False;Property;_WaterColor;WaterColor;0;0;Create;True;0;0;False;0;0.05098039,0.2470588,1,0.6509804;0.0518868,0.2461469,1,0.6588235;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;186;-2262.248,-1595.88;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;304;-3469.688,2237.781;Inherit;False;World;True;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleAddOpNode;486;-23.74702,-2021.726;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;60;-3502.125,-129.5614;Inherit;False;WaterUV;-1;;508;92d4681b6e0fd3e41a1a096df51a9c42;0;2;2;FLOAT2;1,0;False;8;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;228;-1572.478,-419.3865;Inherit;False;Property;_FoamWidth02;FoamWidth02;61;0;Create;True;0;0;False;0;0;0.577;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;61;-3422.125,-321.5612;Inherit;True;Property;_FoamTexture;FoamTexture;53;0;Create;True;0;0;False;0;9bcc0538ff18cfa4b962f477ae06711d;9bcc0538ff18cfa4b962f477ae06711d;False;white;Auto;Texture2D;-1;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.FunctionNode;59;-3502.125,-449.5612;Inherit;False;WaterUV;-1;;507;92d4681b6e0fd3e41a1a096df51a9c42;0;2;2;FLOAT2;1,0;False;8;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;140;-1989.955,-1144.503;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;187;-77.12964,-1490.115;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;241;-1981.238,-79.07618;Inherit;False;Property;_FoamWidth11;FoamWidth11;60;0;Create;True;0;0;False;0;0;0.064;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;229;-1448.715,-542.6677;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;305;-3026.821,2280.963;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldPosInputsNode;396;-3097.007,1686.772;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldSpaceCameraPos;397;-3161.542,1836.438;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleSubtractOpNode;389;-2848.477,1755.426;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;176;-3745.327,-1631.066;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;415;158.6316,-1960.157;Inherit;False;Property;_CausticsIntensity;CausticsIntensity;73;0;Create;True;0;0;False;0;0.5;2;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;150;-1378.391,-1240.439;Inherit;False;Property;_ScatteringColor;ScatteringColor;2;0;Create;True;0;0;False;0;0,0.792304,1,0.6392157;0,0.792304,1,0.6156863;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;143;-1814.955,-1141.503;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;62;-2942.125,-385.5612;Inherit;True;Property;_TextureSample2;Texture Sample 2;87;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;242;-1619.699,-119.1077;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;416;122.1806,-2072.306;Inherit;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;63;-2942.125,-193.5613;Inherit;True;Property;_TextureSample1;Texture Sample 1;87;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;148;-2231.583,-1526.203;Inherit;False;Property;_WaterColor2;WaterColor2;1;0;Create;True;0;0;False;0;0.3254902,1,0.9921569,0.5333334;0.3254902,1,0.9933245,0.4823529;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TransformDirectionNode;309;-3155.292,2040.733;Inherit;False;Object;World;False;Fast;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;230;-1202.46,-492.0097;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;188;106.4192,-1509.535;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalizeNode;307;-2825.43,2280.364;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;243;-1726.507,0.4058335;Inherit;False;Property;_FoamWidth12;FoamWidth12;62;0;Create;True;0;0;False;0;0;0.691;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldReflectionVector;48;-3062.458,793.102;Inherit;False;True;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SaturateNode;232;-1007.463,-491.0097;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;141;-1121.339,-1061.323;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;308;-2608.646,2240.405;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;417;720.6937,-2073.167;Inherit;False;3;3;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;65;-2526.125,-257.5612;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ComponentMaskNode;390;-2669.976,1749.934;Inherit;False;True;False;True;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;244;-1373.444,-68.44968;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;231;-977.4627,-598.0097;Inherit;False;Constant;_Float10;Float 10;83;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;475;-1050.245,-1667.428;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ComponentMaskNode;380;-2619.436,1887.172;Inherit;False;False;True;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;144;-1843.271,-1485.184;Inherit;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;382;-2635.124,2121.765;Inherit;False;Property;_GlitteringPow;GlitteringPow;69;0;Create;True;0;0;False;0;0;339;0;1000;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;153;-1613.955,-1151.503;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;146;-1825.955,-1352.503;Inherit;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TexturePropertyNode;46;-2958.028,570.1392;Inherit;True;Property;_SkyCube;SkyCube;37;0;Create;True;0;0;False;0;65844975f3a977b419b0d5fdff86f07a;65844975f3a977b419b0d5fdff86f07a;False;white;LockedToCube;Cube;-1;0;1;SAMPLERCUBE;0
Node;AmplifyShaderEditor.RangedFloatNode;233;-846.2217,-395.1777;Inherit;False;Property;_FoamDensity01;FoamDensity01;57;0;Create;True;0;0;False;0;0;0.275;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;315;-2703.393,2420.957;Inherit;False;Property;_SunShininess;SunShininess;66;0;Create;True;0;0;False;0;1;12.20621;0;1000;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;532;-2473.271,2246.708;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;175;-486.1141,-1664.126;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;234;-775.4658,-518.0097;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;430;851.481,-2044.187;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;245;-1178.447,-67.44968;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;151;-1387.955,-1439.503;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ComponentMaskNode;363;-2386.576,-273.7114;Inherit;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;64;-2350.125,-161.5614;Inherit;False;Constant;_Float5;Float 5;92;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;246;-1148.447,-174.4497;Inherit;False;Constant;_Float7;Float 7;83;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;394;-2424.01,1856.57;Inherit;False;Property;_DistanceFadeWidth;DistanceFadeWidth;71;0;Create;True;0;0;False;0;100;-60;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;366;-2325.666,1948.349;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;367;-2261.713,2121.784;Inherit;False;Property;_GlitteringClamp;GlitteringClamp;68;0;Create;True;0;0;False;0;0;0.5;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LengthOpNode;391;-2431.059,1755.426;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;155;-611.3591,-1282.043;Inherit;False;Property;_FogColor;FogColor;3;1;[HDR];Create;True;0;0;False;0;0,0.8451186,0.9528302,0.05098039;0,0.8539361,0.9433962,0.03529412;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;147;-946.7989,-1063.356;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;145;-1115.955,-1290.503;Inherit;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;395;-2426.062,1636.099;Inherit;False;Property;_DistanceFadeMin;DistanceFadeMin;70;0;Create;True;0;0;False;0;0;60;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;44;-2487.823,814.6671;Inherit;False;Property;_SkyFresnelBias;SkyFresnelBias;39;0;Create;True;0;0;False;0;-0.01;-0.01;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;314;-2317.293,2240.257;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;317;-2340.692,2423.557;Inherit;False;Property;_SunInensity;SunInensity;67;0;Create;True;0;0;False;0;0.6470312;83.18073;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenColorNode;98;-55.78935,-1679.7;Inherit;False;Global;_GrabScreen0;Grab Screen 0;96;0;Create;True;0;0;False;0;Object;-1;False;False;1;0;FLOAT2;0,0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;49;-2321.246,643.0121;Inherit;True;Property;_TextureSample0;Texture Sample 0;92;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;LockedToCube;False;Object;-1;Auto;Cube;6;0;SAMPLER2D;;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;247;-1017.206,28.38232;Inherit;False;Property;_FoamDensity11;FoamDensity11;58;0;Create;True;0;0;False;0;0;0.886;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;429;965.6876,-2024.795;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;142;-583.554,-1427.174;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;248;-946.4496,-94.44968;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;236;-570.7564,-485.7376;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;381;-1935.413,1951.99;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;66;-2158.125,-273.5612;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SmoothstepOpNode;392;-2143.042,1722.426;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;47;-2493.823,989.6671;Inherit;False;Property;_SkyFresnelPower;SkyFresnelPower;41;0;Create;True;0;0;False;0;-0.5;-0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;45;-2495.823,903.6671;Inherit;False;Property;_SkyFresnelScale;SkyFresnelScale;40;0;Create;True;0;0;False;0;0.11;0.11;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;152;-350.6219,-1282.043;Inherit;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;318;-2151.263,1449.141;Inherit;False;Property;_SunColor;SunColor;64;0;Create;True;0;0;False;0;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FresnelNode;50;-2263.596,841.9141;Inherit;False;Standard;WorldNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;322;-2020.211,644.4458;Inherit;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;316;-1921.192,2238.657;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;249;-741.7402,-62.17759;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;178;144.8549,-1679.745;Inherit;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;387;-1789.515,1717.362;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;546;-5206.963,3220.656;Inherit;False;Property;_GerstnerGroup2;GerstnerGroup2;27;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;237;-390.2678,-379.1676;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;428;934.7635,-1764.492;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StaticSwitch;514;-5260.788,2341.509;Inherit;False;Property;_GerstnerGroup1;GerstnerGroup1;17;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;149;-24.78394,-1416.822;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ComponentMaskNode;319;-1912.062,1449.141;Inherit;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;67;459.4572,-655.4617;Inherit;False;Property;_FoamColor;FoamColor;52;0;Create;True;0;0;False;0;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;297;-1702.494,990.8174;Inherit;False;Property;_SkyScale;SkyScale;38;0;Create;True;0;0;False;0;0.348;0.348;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;399;-1616.211,1805.102;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;51;-1825.435,856.924;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;511;-4857.818,1834.815;Inherit;False;3;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;250;-186.6313,-305.2533;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;431;942.709,-1252.785;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.BlendOpsNode;191;729.5868,-1247.645;Inherit;False;Overlay;True;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;425;991.9464,-1258.169;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;270;144.2967,-217.6613;Inherit;False;Constant;_Color0;Color 0;40;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;320;-1445.545,1695.007;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ComponentMaskNode;364;674.4333,-657.7975;Inherit;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;89;-4397.586,1627.943;Inherit;False;GerstnerNormalize;-1;;509;65b5dbdc6530c4e4197f0726eb54b3fc;0;1;12;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;296;-1439.585,851.2843;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;251;-7.690535,-298.1665;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;5;-101.1564,764.9492;Inherit;False;Property;_TessMaxDistance;TessMaxDistance;6;0;Create;True;0;0;False;0;240;240;2;240;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;324;-1103.366,853.7269;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-100.6618,670.7631;Inherit;False;Property;_TessMinDistance;TessMinDistance;5;0;Create;True;0;0;False;0;1;0;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;427;1113.525,-550.6453;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;426;1136.907,-595.2817;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;92;-281.9833,942.2677;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;239;-110.3762,-543.0014;Inherit;False;Property;_FoamWidth03;FoamWidth03;63;0;Create;True;0;0;False;0;0;0.93;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;529;886.72,-402.1515;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;71;-300.9157,930.1975;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ComponentMaskNode;271;385.5789,-215.2118;Inherit;True;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-99.28484,577.9064;Inherit;False;Property;_TessFactor;TessFactor;7;0;Create;True;0;0;False;0;32;14.8;1;128;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;240;264.462,-473.5012;Inherit;True;True;False;False;False;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ConditionalIfNode;222;1280.596,-500.0694;Inherit;False;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DistanceBasedTessNode;8;222.4848,648.6671;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.WireNode;91;-118.9662,511.0609;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;518;1814.37,-213.9571;Inherit;False;Property;_Smoohness;Smoohness;79;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;388;-1863.855,1060.909;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ConditionalIfNode;269;700.348,-278.9005;Inherit;True;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;70;-138.5257,505.1185;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;2195.604,-376.9063;Float;False;True;-1;6;ASEMaterialInspect;0;0;StandardSpecular;ACE/Water;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;True;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;542;2;536;0
WireConnection;542;3;533;0
WireConnection;542;4;540;0
WireConnection;542;5;534;0
WireConnection;542;6;535;0
WireConnection;542;7;537;0
WireConnection;542;8;541;0
WireConnection;542;9;538;0
WireConnection;542;10;539;0
WireConnection;501;2;502;0
WireConnection;501;3;506;0
WireConnection;501;4;505;0
WireConnection;501;5;509;0
WireConnection;501;6;504;0
WireConnection;501;7;508;0
WireConnection;501;8;510;0
WireConnection;501;9;503;0
WireConnection;501;10;507;0
WireConnection;132;0;124;1
WireConnection;132;1;124;2
WireConnection;544;1;543;0
WireConnection;544;0;542;16
WireConnection;545;1;543;0
WireConnection;545;0;542;0
WireConnection;515;1;517;0
WireConnection;515;0;501;0
WireConnection;516;1;517;0
WireConnection;516;0;501;16
WireConnection;138;2;20;0
WireConnection;138;3;27;0
WireConnection;138;4;28;0
WireConnection;138;5;29;0
WireConnection;138;6;30;0
WireConnection;138;7;31;0
WireConnection;138;8;32;0
WireConnection;138;9;33;0
WireConnection;138;10;34;0
WireConnection;131;0;129;1
WireConnection;131;1;129;2
WireConnection;117;0;124;3
WireConnection;117;1;123;0
WireConnection;125;0;123;0
WireConnection;125;1;129;3
WireConnection;512;0;138;0
WireConnection;512;1;515;0
WireConnection;512;2;545;0
WireConnection;126;2;132;0
WireConnection;126;8;117;0
WireConnection;513;0;138;16
WireConnection;513;1;516;0
WireConnection;513;2;544;0
WireConnection;119;2;131;0
WireConnection;119;8;125;0
WireConnection;128;0;133;0
WireConnection;128;1;126;0
WireConnection;135;0;513;0
WireConnection;18;0;512;0
WireConnection;121;0;133;0
WireConnection;121;1;119;0
WireConnection;134;0;128;0
WireConnection;134;1;121;0
WireConnection;111;0;18;0
WireConnection;111;1;135;0
WireConnection;112;0;135;0
WireConnection;112;1;111;0
WireConnection;112;2;18;0
WireConnection;122;0;134;0
WireConnection;122;1;130;0
WireConnection;136;0;122;0
WireConnection;136;1;112;0
WireConnection;295;0;136;0
WireConnection;294;0;295;0
WireConnection;293;0;294;0
WireConnection;292;0;293;0
WireConnection;290;0;292;0
WireConnection;291;0;290;0
WireConnection;492;0;491;1
WireConnection;492;1;491;2
WireConnection;257;0;291;0
WireConnection;276;1;257;0
WireConnection;495;0;496;0
WireConnection;495;1;492;0
WireConnection;493;0;495;0
WireConnection;493;1;494;0
WireConnection;95;0;276;0
WireConnection;94;0;93;0
WireConnection;444;0;442;1
WireConnection;444;1;442;2
WireConnection;106;0;94;0
WireConnection;106;1;95;0
WireConnection;490;0;489;0
WireConnection;490;1;493;0
WireConnection;445;0;442;3
WireConnection;445;1;443;0
WireConnection;104;0;103;0
WireConnection;104;1;102;0
WireConnection;101;0;95;0
WireConnection;101;1;94;0
WireConnection;447;0;443;0
WireConnection;447;1;441;3
WireConnection;497;0;490;1
WireConnection;497;1;490;2
WireConnection;446;0;441;1
WireConnection;446;1;441;2
WireConnection;107;0;104;0
WireConnection;448;2;444;0
WireConnection;448;8;445;0
WireConnection;108;0;105;0
WireConnection;108;1;106;0
WireConnection;450;2;446;0
WireConnection;450;8;447;0
WireConnection;183;0;101;0
WireConnection;183;1;182;0
WireConnection;183;2;255;0
WireConnection;183;3;182;0
WireConnection;183;4;181;0
WireConnection;498;0;497;0
WireConnection;498;1;448;0
WireConnection;109;0;108;0
WireConnection;109;1;107;0
WireConnection;194;0;183;0
WireConnection;452;0;401;0
WireConnection;452;1;498;0
WireConnection;156;0;109;0
WireConnection;156;1;163;0
WireConnection;156;2;159;0
WireConnection;156;3;163;0
WireConnection;156;4;164;0
WireConnection;499;0;497;0
WireConnection;499;1;450;0
WireConnection;55;0;52;1
WireConnection;55;1;52;2
WireConnection;58;0;52;3
WireConnection;58;1;53;0
WireConnection;451;0;401;0
WireConnection;451;1;499;0
WireConnection;252;0;156;0
WireConnection;57;0;53;0
WireConnection;57;1;54;3
WireConnection;531;0;530;0
WireConnection;56;0;54;1
WireConnection;56;1;54;2
WireConnection;487;0;452;0
WireConnection;487;1;488;0
WireConnection;186;0;194;0
WireConnection;486;0;487;0
WireConnection;486;1;451;0
WireConnection;60;2;56;0
WireConnection;60;8;57;0
WireConnection;59;2;55;0
WireConnection;59;8;58;0
WireConnection;140;0;154;4
WireConnection;140;1;252;0
WireConnection;187;0;186;0
WireConnection;229;0;252;0
WireConnection;229;1;227;0
WireConnection;305;0;304;0
WireConnection;305;1;531;0
WireConnection;389;0;396;0
WireConnection;389;1;397;0
WireConnection;176;0;276;0
WireConnection;143;0;140;0
WireConnection;62;0;61;0
WireConnection;62;1;59;0
WireConnection;242;0;252;0
WireConnection;242;1;241;0
WireConnection;416;0;486;0
WireConnection;63;0;61;0
WireConnection;63;1;60;0
WireConnection;309;0;136;0
WireConnection;230;0;229;0
WireConnection;230;1;228;0
WireConnection;188;0;187;0
WireConnection;307;0;305;0
WireConnection;48;0;136;0
WireConnection;232;0;230;0
WireConnection;141;0;150;4
WireConnection;141;1;252;0
WireConnection;308;0;309;0
WireConnection;308;1;307;0
WireConnection;417;0;416;0
WireConnection;417;1;415;0
WireConnection;417;2;188;0
WireConnection;65;0;62;0
WireConnection;65;1;63;0
WireConnection;390;0;389;0
WireConnection;244;0;242;0
WireConnection;244;1;243;0
WireConnection;475;0;176;0
WireConnection;380;0;48;0
WireConnection;144;0;148;0
WireConnection;153;0;143;0
WireConnection;153;1;143;0
WireConnection;146;0;154;0
WireConnection;532;0;308;0
WireConnection;175;0;475;0
WireConnection;234;0;231;0
WireConnection;234;1;232;0
WireConnection;430;0;417;0
WireConnection;245;0;244;0
WireConnection;151;0;144;0
WireConnection;151;1;146;0
WireConnection;151;2;153;0
WireConnection;363;0;65;0
WireConnection;366;0;380;0
WireConnection;366;1;382;0
WireConnection;391;0;390;0
WireConnection;147;0;141;0
WireConnection;145;0;150;0
WireConnection;314;0;532;0
WireConnection;314;1;315;0
WireConnection;98;0;175;0
WireConnection;49;0;46;0
WireConnection;49;1;48;0
WireConnection;429;0;430;0
WireConnection;142;0;151;0
WireConnection;142;1;145;0
WireConnection;142;2;147;0
WireConnection;248;0;246;0
WireConnection;248;1;245;0
WireConnection;236;0;234;0
WireConnection;236;1;233;0
WireConnection;381;0;366;0
WireConnection;381;2;367;0
WireConnection;66;0;363;0
WireConnection;66;1;64;0
WireConnection;392;0;391;0
WireConnection;392;1;395;0
WireConnection;392;2;394;0
WireConnection;152;0;155;0
WireConnection;50;1;44;0
WireConnection;50;2;45;0
WireConnection;50;3;47;0
WireConnection;322;0;49;0
WireConnection;316;0;314;0
WireConnection;316;1;317;0
WireConnection;249;0;248;0
WireConnection;249;1;247;0
WireConnection;178;0;98;0
WireConnection;387;0;392;0
WireConnection;387;1;381;0
WireConnection;546;1;543;0
WireConnection;546;0;542;15
WireConnection;237;0;236;0
WireConnection;237;1;66;0
WireConnection;428;0;429;0
WireConnection;514;1;517;0
WireConnection;514;0;501;15
WireConnection;149;0;142;0
WireConnection;149;1;152;0
WireConnection;149;2;155;4
WireConnection;319;0;318;0
WireConnection;399;0;387;0
WireConnection;399;1;316;0
WireConnection;51;0;322;0
WireConnection;51;1;50;0
WireConnection;511;0;138;15
WireConnection;511;1;514;0
WireConnection;511;2;546;0
WireConnection;250;0;237;0
WireConnection;250;1;249;0
WireConnection;431;0;428;0
WireConnection;191;0;178;0
WireConnection;191;1;149;0
WireConnection;191;2;188;0
WireConnection;425;0;431;0
WireConnection;425;1;191;0
WireConnection;320;0;319;0
WireConnection;320;1;399;0
WireConnection;364;0;67;0
WireConnection;89;12;511;0
WireConnection;296;0;51;0
WireConnection;296;1;297;0
WireConnection;251;0;250;0
WireConnection;324;0;296;0
WireConnection;324;1;320;0
WireConnection;427;0;425;0
WireConnection;426;0;425;0
WireConnection;92;0;18;0
WireConnection;529;0;364;0
WireConnection;529;1;251;0
WireConnection;71;0;89;0
WireConnection;271;0;270;0
WireConnection;240;0;251;0
WireConnection;222;0;240;0
WireConnection;222;1;239;0
WireConnection;222;2;529;0
WireConnection;222;3;426;0
WireConnection;222;4;427;0
WireConnection;8;0;7;0
WireConnection;8;1;6;0
WireConnection;8;2;5;0
WireConnection;91;0;92;0
WireConnection;269;0;240;0
WireConnection;269;1;239;0
WireConnection;269;2;271;0
WireConnection;269;3;324;0
WireConnection;269;4;324;0
WireConnection;70;0;71;0
WireConnection;0;0;222;0
WireConnection;0;2;269;0
WireConnection;0;4;518;0
WireConnection;0;11;70;0
WireConnection;0;12;91;0
WireConnection;0;14;8;0
ASEEND*/
//CHKSM=0C845D3CA6BCDEFCBA53F33E871DAC32D59B8475