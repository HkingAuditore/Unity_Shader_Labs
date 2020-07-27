// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Aurora/AuroraSky"
{
    Properties
    {
        [Header(Sky Setting)]
        _Color1 ("Top Color", Color) = (1, 1, 1, 0)
        _Color2 ("Horizon Color", Color) = (1, 1, 1, 0)
        _Color3 ("Bottom Color", Color) = (1, 1, 1, 0)
        _Exponent1 ("Exponent Factor for Top Half", Float) = 1.0
        _Exponent2 ("Exponent Factor for Bottom Half", Float) = 1.0
        _Intensity ("Intensity Amplifier", Float) = 1.0


        [Header(Star Setting)]
        [HDR]_StarColor ("Star Color", Color) = (1,1,1,0)
        _StarIntensity("Star Intensity", Range(0,1)) = 0.5
        _StarSpeed("Star Speed", Range(0,1)) = 0.5

        [Header(Cloud Setting)]
        [HDR]_CloudColor ("Cloud Color", Color) = (1,1,1,0)
        _CloudIntensity("Cloud Intensity", Range(0,1)) = 0.5
        _CloudSpeed("CloudSpeed", Range(0,1)) = 0.5

        [Header(Aurora Setting)]
        [HDR]_AuroraColor ("Aurora Color", Color) = (1,1,1,0)
        _AuroraIntensity("Aurora Intensity", Range(0,1)) = 0.5
        _AuroraSpeed("AuroraSpeed", Range(0,1)) = 0.5

    }

    CGINCLUDE

    #include "UnityCG.cginc"

    struct appdata
    {
        float4 position : POSITION;
        float3 texcoord : TEXCOORD0;
        float3 normal : NORMAL;
    };
    
    struct v2f
    {
        float4 position : SV_POSITION;
        float3 texcoord : TEXCOORD0;
        float3 normal : TEXCOORD1;
    };
    
    half4 _Color1;
    half4 _Color2;
    half4 _Color3;

    half4 _StarColor;
    half _StarIntensity;
    half _StarSpeed;

    half4 _CloudColor;
    half _CloudIntensity;
    half _CloudSpeed;

    half4 _AuroraColor;
    half _AuroraIntensity;
    half _AuroraSpeed;


    half _Intensity;
    half _Exponent1;
    half _Exponent2;
    
    v2f vert (appdata v)
    {
        v2f o;
        o.position = UnityObjectToClipPos (v.position);
        o.texcoord = v.texcoord;
        o.normal = v.normal;
        return o;
    }
    
    
    // 星空散列哈希
    float StarAuroraHash(float3 x) {
	    float3 p = float3( dot(x,float3(214.1 ,127.7,125.4)),
			        dot(x,float3(260.5,183.3,954.2)),
                    dot(x,float3(209.5,571.3,961.2)) );

	    return -0.001 + _StarIntensity*frac(sin(p)*43758.5453123);
    }

    // 星空噪声
    float StarNoise(float3 st){
        st += float3(0,_Time.y*_StarSpeed,0);

        float3 i = floor(st) ;
        float3 f = frac(st);
    
	    float3 u = f*f*(3.0-1.0*f);

        return lerp(lerp(dot(StarAuroraHash( i + float3(0.0,0.0,0.0)), f - float3(0.0,0.0,0.0) ), 
                         dot(StarAuroraHash( i + float3(1.0,0.0,0.0)), f - float3(1.0,0.0,0.0) ), u.x),
                    lerp(dot(StarAuroraHash( i + float3(0.0,1.0,0.0)), f - float3(0.0,1.0,0.0) ), 
                         dot(StarAuroraHash( i + float3(1.0,1.0,0.0)), f - float3(1.0,1.0,0.0) ), u.y), u.z) ;
    }


    // 星云散列哈希
    float CloudHash (float2 st) {
        return frac(sin(dot(st.xy,
                         float2(12.9898,78.233)))*
        43758.5453123);
    }

    // 星云噪声
    float CloudNoise (float2 st) {
        st += float2(0,_Time.y*_CloudSpeed);

        float2 i = floor(st);
        float2 f = frac(st);

        
        float a = CloudHash(i);
        float b = CloudHash(i + float2(1.0, 0.0));
        float c = CloudHash(i + float2(0.0, 1.0));
        float d = CloudHash(i + float2(1.0, 1.0));

        float2 u = f * f * (3.0 - 2.0 * f);

        return lerp(a, b, u.x) +
                (c - a)* u.y * (1.0 - u.x) +
                (d - b) * u.x * u.y;
    }

    // 星云分型
    float Cloudfbm (float2 st) {
        // Initial values
        float value = 0.0;
        float amplitude = .5;
        float frequency = 0.;
        //
        // Loop of octaves
        for (int i = 0; i < 6; i++) {
            value += amplitude * CloudNoise(st);
            st *= 2.;
            amplitude *= .5;
        }
        return value;
    }



    //极光噪声
    float AuroraHash(float n ) { 
        return frac(sin(n)*758.5453); 
    }

    float AuroraNoise(float3 x)
    {
        float3 p = floor(x);
        float3 f = frac(x);
        float n = p.x + p.y*57.0 + p.z*800.0;
        float res = lerp(lerp(lerp( AuroraHash(n+  0.0), AuroraHash(n+  1.0),f.x), lerp( AuroraHash(n+ 57.0), AuroraHash(n+ 58.0),f.x),f.y),
	    	    lerp(lerp( AuroraHash(n+800.0), AuroraHash(n+801.0),f.x), lerp( AuroraHash(n+857.0), AuroraHash(n+858.0),f.x),f.y),f.z);
        return res;
    }
    //极光分型
    float Aurorafbm(float3 p )
    {
        float f  = 0.50000*AuroraNoise( p ); 
        p *= 2.02;
        f += 0.25000*AuroraNoise( p ); 
        p *= 2.03;
        f += 0.12500*AuroraNoise( p ); 
        p *= 2.01;
        f += 0.06250*AuroraNoise( p ); 
        p *= 2.04;
        f += 0.03125*AuroraNoise( p );
        return f*1.032258;
    }
    float GetAurora(float3 p)
    {
    	p+=Aurorafbm(float3(p.x,p.y,0.0)*0.5)*2.25;
    	float a = smoothstep(.0, .9, Aurorafbm(p*2.)*2.2-1.1);

    	return a<0.0 ? 0.0 : a;
    }


    half4 frag (v2f i) : COLOR
    {
        float p = normalize(i.texcoord).y;
        float p1 = 1.0f - pow (min (1.0f, 1.0f - p), _Exponent1);
        float p3 = 1.0f - pow (min (1.0f, 1.0f + p), _Exponent2);
        float p2 = 1.0f - p1 - p3;

        // 星云
        float cloud = Cloudfbm(i.texcoord.xz * 8);
        float4 cloudCol = float4(cloud * _CloudColor.rgb,cloud*0.8);

        // 星星
        float star  =StarNoise(i.texcoord.xyz * 64);
        float4 starOriCol = float4(_StarColor.r + 3.25*sin(i.texcoord.x) + 2.45 * (sin(_Time.y * _StarSpeed) + 1)*0.5,
                                   _StarColor.g + 3.85*sin(i.texcoord.y) + 1.45 * (sin(_Time.y * _StarSpeed) + 1)*0.5,
                                   _StarColor.b + 3.45*sin(i.texcoord.z) + 4.45 * (sin(_Time.y * _StarSpeed) + 1)*0.5,
                                   _StarColor.a + 3.85*star);
        star = star > 0.8 ? star:smoothstep(0.81,0.98,star);

        float4 starCol = fixed4((starOriCol * star).rgb,star);



        //极光
        float aurora = GetAurora(i.texcoord.xyz);
        float3 boreal = float3 (_AuroraColor.rgb  * GetAurora(float3(i.texcoord.xy*float2(1.2,1.), _Time.y*_AuroraSpeed*0.22)) * .9  +
                        _AuroraColor.rgb * GetAurora(float3(i.texcoord.xy*float2(1.,.7)  , _Time.y*_AuroraSpeed*0.27)) *  .9 +
                        _AuroraColor.rgb * GetAurora(float3(i.texcoord.xz*float2(.8,.6)  , _Time.y*_AuroraSpeed*0.29)) *  .5 +
                        _AuroraColor.rgb  * GetAurora(float3(i.texcoord.xz*float2(.9,.5)  , _Time.y*_AuroraSpeed*0.20)) *  .57);
        float4 auroraCol = float4(boreal,aurora*0.8);



        float4 skyCol = (_Color1 * p1 + _Color2 * p2 + _Color3 * p3) * _Intensity;
        skyCol = skyCol*(1 - starCol.a) + starCol * starCol.a;
        skyCol = skyCol*(1 - cloudCol.a) + cloudCol * cloudCol.a;
        skyCol = skyCol*(1 - auroraCol.a) + auroraCol * auroraCol.a;
        return skyCol;

    }

    ENDCG

    SubShader
    {
        Tags { "RenderType"="Background" "Queue"="Background" }
        Pass
        {
            ZWrite Off
            Cull Off
            Fog { Mode Off }
            CGPROGRAM
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma vertex vert
            #pragma fragment frag
            ENDCG
        }
    } 
}
