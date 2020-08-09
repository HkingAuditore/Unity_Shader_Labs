Shader "Grass/Grass"
{
 Properties
    {
        _Color ("Color", Color) = (1, 1, 1, 1)
        _Specular ("Specular", Color) = (1, 1, 1, 1)
        _Shininess ("Shininess", Range(0.00, 1.0)) = 0.5
        _Cutoff ("Cutoff", Range(0.01, 1.0)) = 0.5
        _ShadowAdjust ("ShadowAdjust", Range(0.01, 1.0)) = 0.5
        
        _MainTex ("Texture", 2D) = "white" { }
        _FurTex ("Fur Pattern", 2D) = "white" { }
        
        _FurLength ("Fur Length", Range(0.0, 1)) = 0.5
        _FurDensity ("Fur Density", Range(0, 2)) = 0.11
        _FurThinness ("Fur Thinness", Range(0.01, 10)) = 1
        _FurShading ("Fur Shading", Range(0.0, 1)) = 0.25
        _AOColor ("AO Color", Color) = (1,1,1,1)      
        _ShadowColor ("Shadow Color", Color) = (1,1,1,1)
        _ShadowRange ("ShadowRange", Range(0.01, 1.0)) = 0.5


        _ForceGlobal ("Force Global", Vector) = (0, 0, 0, 0)
        _ForceLocal ("Force Local", Vector) = (0, 0, 0, 0)
        
        _RimColor ("Rim Color", Color) = (0, 0, 0, 1)
        _RimPower ("Rim Power", Range(0.0, 1.0)) = 6.0

        _WindAmplitude ("Wind Amplitude", Float) = 0.01
	    _WindFrequency ("Wind Frequency", Float) = 5
	    _WindDistribution ("Wind Distribution", Float) = 120
    }
    
    Category
    {

        Tags { "LightMode" = "ShadowCaster" "Queue"="Geometry+1" "LightMode"="ForwardBase" "IgnoreProjector" = "False" "Queue"="Geometry+1" }
        //         Tags { "LightMode" = "ForwardBase" "RenderType"="Opaque" "Queue"="Geometry+1" "ForceNoShadowCasting"="True"  }
		LOD 200
        //		Blend Zero SrcColor
        Cull Off
        ZWrite On
        Blend SrcAlpha OneMinusSrcAlpha
        
        SubShader
        { 
            Pass
            {
                CGPROGRAM
                
                #pragma vertex vert_surface
                #pragma fragment frag_surface
                #define FURSTEP 0.00

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

                fixed4 _Color;
                fixed4 _Specular;
                half _Shininess;
                fixed _ShadowAdjust;
                half _ShadowRange;
                half _WindAmplitude;
                half _WindFrequency;
                half _WindDistribution;
                fixed _Cutoff;

                sampler2D _MainTex;
                half4 _MainTex_ST;
                sampler2D _FurTex;
                half4 _FurTex_ST;

                fixed _FurLength;
                fixed _FurDensity;
                fixed _FurThinness;
                fixed _FurShading;

                fixed4 _AOColor;
                fixed4 _ShadowColor;

                float4 _ForceGlobal;
                float4 _ForceLocal;


                fixed4 _RimColor;
                half _RimPower;

                v2f vert_surface(appdata_base v)
                {
                    v2f o;
                    o.uv.xy = TRANSFORM_TEX(v.texcoord, _MainTex);
                    o.pos = UnityObjectToClipPos(v.vertex);
                    o.worldNormal = UnityObjectToWorldNormal(v.normal);
                    o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
                    TRANSFER_SHADOW(o);
                    return o;
                }



                fixed4 frag_surface(v2f i): SV_Target
                {
                    
                    fixed3 worldNormal = normalize(i.worldNormal);
                    fixed3 worldLight = normalize(_WorldSpaceLightPos0.xyz);
                    fixed3 worldView = normalize(_WorldSpaceCameraPos.xyz - i.worldPos.xyz);
                    fixed3 worldHalf = normalize(worldView + worldLight);
                    fixed shadow = SHADOW_ATTENUATION(i); 
                    

                    fixed3 albedo = tex2D(_MainTex, i.uv.xy).rgb * _Color;
                    fixed3 ambient = UNITY_LIGHTMODEL_AMBIENT.xyz * albedo*_AOColor;
                    fixed3 diffuse = _LightColor0.rgb * albedo * saturate(dot(worldNormal, worldLight));
                    fixed3 lightting = saturate(dot(worldNormal, worldLight));



                    fixed3 specular = _LightColor0.rgb * _Specular.rgb * pow(saturate(dot(worldNormal, worldHalf)), _Shininess);

                    fixed3 color = ambient + diffuse + specular;


                    return fixed4(color*(shadow+_ShadowAdjust), 1.0);
                }
                ENDCG           
            }
 
            Pass
            {
                CGPROGRAM
                
               #pragma vertex vert_base
               #pragma fragment frag_base
               #define FURSTEP 0.03
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

                fixed4 _Color;
                fixed4 _Specular;
                half _Shininess;
                fixed _ShadowAdjust;
                half _ShadowRange;
                half _WindAmplitude;
                half _WindFrequency;
                half _WindDistribution;
                fixed _Cutoff;
                
                sampler2D _MainTex;
                half4 _MainTex_ST;
                sampler2D _FurTex;
                half4 _FurTex_ST;
                
                fixed _FurLength;
                fixed _FurDensity;
                fixed _FurThinness;
                fixed _FurShading;
                
                fixed4 _AOColor;
                fixed4 _ShadowColor;
                
                float4 _ForceGlobal;
                float4 _ForceLocal;
                
                
                fixed4 _RimColor;
                half _RimPower;

                v2f vert_base(appdata_base v)
                {
                    v2f o;
                    v.vertex.x += /*abs*/( sin(/*v.vertex.z */ _WindDistribution + _Time.y * _WindFrequency) * _WindAmplitude) * v.texcoord.y*FURSTEP;
                    v.vertex.y += /*abs*/( cos(/*v.vertex.y */ _WindDistribution + _Time.y * _WindFrequency) * _WindAmplitude) * v.texcoord.y*FURSTEP;
                
                    float3 P = v.vertex.xyz + v.normal * _FurLength * FURSTEP;
                    P += clamp(mul(unity_WorldToObject, _ForceGlobal).xyz + _ForceLocal.xyz, -1, 1) * pow(FURSTEP, 3) * _FurLength;
                    o.pos = UnityObjectToClipPos(float4(P, 1.0));
                    o.uv.xy = TRANSFORM_TEX(v.texcoord, _MainTex);
                    o.uv.zw = TRANSFORM_TEX(v.texcoord, _FurTex);
                    //clip(_FurTex.a - _Cutoff);
                    o.worldNormal = UnityObjectToWorldNormal(v.normal);
                    o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
                    TRANSFER_SHADOW(o)  
                    return o;
                }
                fixed4 frag_base(v2f i): SV_Target
                {
                    fixed3 worldNormal = normalize(i.worldNormal);
                    fixed3 worldLight = normalize(_WorldSpaceLightPos0.xyz);
                    fixed3 worldView = normalize(_WorldSpaceCameraPos.xyz - i.worldPos.xyz);
                    fixed3 worldHalf = normalize(worldView + worldLight);
                    fixed shadow = SHADOW_ATTENUATION(i);  
                    
                    fixed3 albedo = tex2D(_MainTex, i.uv.xy).rgb * _Color;
                    albedo -= (pow(1 - FURSTEP, 3)) * _FurShading;
                    half rim = 1.0 - saturate(dot(worldView, worldNormal));
                    albedo += fixed4(_RimColor.rgb * pow(rim, _RimPower), 1.0);
                    
                    
                    fixed3 ambient = (dot(UNITY_LIGHTMODEL_AMBIENT.xyz,(1,1,1))<0.8?UNITY_LIGHTMODEL_AMBIENT.xyz+(1.5,1.5,1.5):UNITY_LIGHTMODEL_AMBIENT) * albedo*_AOColor;
                    fixed3 diffuse = _LightColor0.rgb * albedo * saturate(dot(worldNormal, worldLight));
                    fixed3 lightting = pow(saturate(dot(worldNormal, worldLight)),_ShadowRange);
                    fixed3 specular = _LightColor0.rgb * _Specular.rgb * pow(saturate(dot(worldNormal, worldHalf)), _Shininess);
                
                
                    fixed3 color = ambient + diffuse + specular;
                    fixed3 noise = tex2D(_FurTex, i.uv.zw * _FurThinness).rgb;
                   
                    fixed alpha = clamp(noise - (FURSTEP * FURSTEP) * _FurDensity, 0, 1);
                    clip(alpha-_Cutoff);
                
                    return fixed4(color*(shadow+_ShadowAdjust), alpha*3.5);
                }


                
                ENDCG              
            }
            Pass
            {
                CGPROGRAM
                
               #pragma vertex vert_base
               #pragma fragment frag_base
               #define FURSTEP 0.06
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

                fixed4 _Color;
                fixed4 _Specular;
                half _Shininess;
                fixed _ShadowAdjust;
                half _ShadowRange;
                half _WindAmplitude;
                half _WindFrequency;
                half _WindDistribution;
                fixed _Cutoff;
                
                sampler2D _MainTex;
                half4 _MainTex_ST;
                sampler2D _FurTex;
                half4 _FurTex_ST;
                
                fixed _FurLength;
                fixed _FurDensity;
                fixed _FurThinness;
                fixed _FurShading;
                
                fixed4 _AOColor;
                fixed4 _ShadowColor;
                
                float4 _ForceGlobal;
                float4 _ForceLocal;
                
                
                fixed4 _RimColor;
                half _RimPower;

                v2f vert_base(appdata_base v)
                {
                    v2f o;
                    v.vertex.x += /*abs*/( sin(/*v.vertex.z */ _WindDistribution + _Time.y * _WindFrequency) * _WindAmplitude) * v.texcoord.y*FURSTEP;
                    v.vertex.y += /*abs*/( cos(/*v.vertex.y */ _WindDistribution + _Time.y * _WindFrequency) * _WindAmplitude) * v.texcoord.y*FURSTEP;
                
                    float3 P = v.vertex.xyz + v.normal * _FurLength * FURSTEP;
                    P += clamp(mul(unity_WorldToObject, _ForceGlobal).xyz + _ForceLocal.xyz, -1, 1) * pow(FURSTEP, 3) * _FurLength;
                    o.pos = UnityObjectToClipPos(float4(P, 1.0));
                    o.uv.xy = TRANSFORM_TEX(v.texcoord, _MainTex);
                    o.uv.zw = TRANSFORM_TEX(v.texcoord, _FurTex);
                    //clip(_FurTex.a - _Cutoff);
                    o.worldNormal = UnityObjectToWorldNormal(v.normal);
                    o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
                    TRANSFER_SHADOW(o)  
                    return o;
                }
                fixed4 frag_base(v2f i): SV_Target
                {
                    fixed3 worldNormal = normalize(i.worldNormal);
                    fixed3 worldLight = normalize(_WorldSpaceLightPos0.xyz);
                    fixed3 worldView = normalize(_WorldSpaceCameraPos.xyz - i.worldPos.xyz);
                    fixed3 worldHalf = normalize(worldView + worldLight);
                    fixed shadow = SHADOW_ATTENUATION(i);  
                    
                    fixed3 albedo = tex2D(_MainTex, i.uv.xy).rgb * _Color;
                    albedo -= (pow(1 - FURSTEP, 3)) * _FurShading;
                    half rim = 1.0 - saturate(dot(worldView, worldNormal));
                    albedo += fixed4(_RimColor.rgb * pow(rim, _RimPower), 1.0);
                    
                    
                    fixed3 ambient = (dot(UNITY_LIGHTMODEL_AMBIENT.xyz,(1,1,1))<0.8?UNITY_LIGHTMODEL_AMBIENT.xyz+(1.5,1.5,1.5):UNITY_LIGHTMODEL_AMBIENT) * albedo*_AOColor;
                    fixed3 diffuse = _LightColor0.rgb * albedo * saturate(dot(worldNormal, worldLight));
                    fixed3 lightting = pow(saturate(dot(worldNormal, worldLight)),_ShadowRange);
                    fixed3 specular = _LightColor0.rgb * _Specular.rgb * pow(saturate(dot(worldNormal, worldHalf)), _Shininess);
                
                
                    fixed3 color = ambient + diffuse + specular;
                    fixed3 noise = tex2D(_FurTex, i.uv.zw * _FurThinness).rgb;
                   
                    fixed alpha = clamp(noise - (FURSTEP * FURSTEP) * _FurDensity, 0, 1);
                    clip(alpha-_Cutoff);
                
                    return fixed4(color*(shadow+_ShadowAdjust), alpha*3.5);
                }


                
                ENDCG              
            }
            Pass
            {
                CGPROGRAM
                
               #pragma vertex vert_base
               #pragma fragment frag_base
               #define FURSTEP 0.12
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

                fixed4 _Color;
                fixed4 _Specular;
                half _Shininess;
                fixed _ShadowAdjust;
                half _ShadowRange;
                half _WindAmplitude;
                half _WindFrequency;
                half _WindDistribution;
                fixed _Cutoff;
                
                sampler2D _MainTex;
                half4 _MainTex_ST;
                sampler2D _FurTex;
                half4 _FurTex_ST;
                
                fixed _FurLength;
                fixed _FurDensity;
                fixed _FurThinness;
                fixed _FurShading;
                
                fixed4 _AOColor;
                fixed4 _ShadowColor;
                
                float4 _ForceGlobal;
                float4 _ForceLocal;
                
                
                fixed4 _RimColor;
                half _RimPower;

                v2f vert_base(appdata_base v)
                {
                    v2f o;
                    v.vertex.x += /*abs*/( sin(/*v.vertex.z */ _WindDistribution + _Time.y * _WindFrequency) * _WindAmplitude) * v.texcoord.y*FURSTEP;
                    v.vertex.y += /*abs*/( cos(/*v.vertex.y */ _WindDistribution + _Time.y * _WindFrequency) * _WindAmplitude) * v.texcoord.y*FURSTEP;
                
                    float3 P = v.vertex.xyz + v.normal * _FurLength * FURSTEP;
                    P += clamp(mul(unity_WorldToObject, _ForceGlobal).xyz + _ForceLocal.xyz, -1, 1) * pow(FURSTEP, 3) * _FurLength;
                    o.pos = UnityObjectToClipPos(float4(P, 1.0));
                    o.uv.xy = TRANSFORM_TEX(v.texcoord, _MainTex);
                    o.uv.zw = TRANSFORM_TEX(v.texcoord, _FurTex);
                    //clip(_FurTex.a - _Cutoff);
                    o.worldNormal = UnityObjectToWorldNormal(v.normal);
                    o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
                    TRANSFER_SHADOW(o)  
                    return o;
                }
                fixed4 frag_base(v2f i): SV_Target
                {
                    fixed3 worldNormal = normalize(i.worldNormal);
                    fixed3 worldLight = normalize(_WorldSpaceLightPos0.xyz);
                    fixed3 worldView = normalize(_WorldSpaceCameraPos.xyz - i.worldPos.xyz);
                    fixed3 worldHalf = normalize(worldView + worldLight);
                    fixed shadow = SHADOW_ATTENUATION(i);  
                    
                    fixed3 albedo = tex2D(_MainTex, i.uv.xy).rgb * _Color;
                    albedo -= (pow(1 - FURSTEP, 3)) * _FurShading;
                    half rim = 1.0 - saturate(dot(worldView, worldNormal));
                    albedo += fixed4(_RimColor.rgb * pow(rim, _RimPower), 1.0);
                    
                    
                    fixed3 ambient = (dot(UNITY_LIGHTMODEL_AMBIENT.xyz,(1,1,1))<0.8?UNITY_LIGHTMODEL_AMBIENT.xyz+(1.5,1.5,1.5):UNITY_LIGHTMODEL_AMBIENT) * albedo*_AOColor;
                    fixed3 diffuse = _LightColor0.rgb * albedo * saturate(dot(worldNormal, worldLight));
                    fixed3 lightting = pow(saturate(dot(worldNormal, worldLight)),_ShadowRange);
                    fixed3 specular = _LightColor0.rgb * _Specular.rgb * pow(saturate(dot(worldNormal, worldHalf)), _Shininess);
                
                
                    fixed3 color = ambient + diffuse + specular;
                    fixed3 noise = tex2D(_FurTex, i.uv.zw * _FurThinness).rgb;
                   
                    fixed alpha = clamp(noise - (FURSTEP * FURSTEP) * _FurDensity, 0, 1);
                    clip(alpha-_Cutoff);
                
                    return fixed4(color*(shadow+_ShadowAdjust), alpha*3.5);
                }


                
                ENDCG              
            }
            Pass
            {
                CGPROGRAM
                
               #pragma vertex vert_base
               #pragma fragment frag_base
               #define FURSTEP 0.15
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

                fixed4 _Color;
                fixed4 _Specular;
                half _Shininess;
                fixed _ShadowAdjust;
                half _ShadowRange;
                half _WindAmplitude;
                half _WindFrequency;
                half _WindDistribution;
                fixed _Cutoff;
                
                sampler2D _MainTex;
                half4 _MainTex_ST;
                sampler2D _FurTex;
                half4 _FurTex_ST;
                
                fixed _FurLength;
                fixed _FurDensity;
                fixed _FurThinness;
                fixed _FurShading;
                
                fixed4 _AOColor;
                fixed4 _ShadowColor;
                
                float4 _ForceGlobal;
                float4 _ForceLocal;
                
                
                fixed4 _RimColor;
                half _RimPower;

                v2f vert_base(appdata_base v)
                {
                    v2f o;
                    v.vertex.x += /*abs*/( sin(/*v.vertex.z */ _WindDistribution + _Time.y * _WindFrequency) * _WindAmplitude) * v.texcoord.y*FURSTEP;
                    v.vertex.y += /*abs*/( cos(/*v.vertex.y */ _WindDistribution + _Time.y * _WindFrequency) * _WindAmplitude) * v.texcoord.y*FURSTEP;
                
                    float3 P = v.vertex.xyz + v.normal * _FurLength * FURSTEP;
                    P += clamp(mul(unity_WorldToObject, _ForceGlobal).xyz + _ForceLocal.xyz, -1, 1) * pow(FURSTEP, 3) * _FurLength;
                    o.pos = UnityObjectToClipPos(float4(P, 1.0));
                    o.uv.xy = TRANSFORM_TEX(v.texcoord, _MainTex);
                    o.uv.zw = TRANSFORM_TEX(v.texcoord, _FurTex);
                    //clip(_FurTex.a - _Cutoff);
                    o.worldNormal = UnityObjectToWorldNormal(v.normal);
                    o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
                    TRANSFER_SHADOW(o)  
                    return o;
                }
                fixed4 frag_base(v2f i): SV_Target
                {
                    fixed3 worldNormal = normalize(i.worldNormal);
                    fixed3 worldLight = normalize(_WorldSpaceLightPos0.xyz);
                    fixed3 worldView = normalize(_WorldSpaceCameraPos.xyz - i.worldPos.xyz);
                    fixed3 worldHalf = normalize(worldView + worldLight);
                    fixed shadow = SHADOW_ATTENUATION(i);  
                    
                    fixed3 albedo = tex2D(_MainTex, i.uv.xy).rgb * _Color;
                    albedo -= (pow(1 - FURSTEP, 3)) * _FurShading;
                    half rim = 1.0 - saturate(dot(worldView, worldNormal));
                    albedo += fixed4(_RimColor.rgb * pow(rim, _RimPower), 1.0);
                    
                    
                    fixed3 ambient = (dot(UNITY_LIGHTMODEL_AMBIENT.xyz,(1,1,1))<0.8?UNITY_LIGHTMODEL_AMBIENT.xyz+(1.5,1.5,1.5):UNITY_LIGHTMODEL_AMBIENT) * albedo*_AOColor;
                    fixed3 diffuse = _LightColor0.rgb * albedo * saturate(dot(worldNormal, worldLight));
                    fixed3 lightting = pow(saturate(dot(worldNormal, worldLight)),_ShadowRange);
                    fixed3 specular = _LightColor0.rgb * _Specular.rgb * pow(saturate(dot(worldNormal, worldHalf)), _Shininess);
                
                
                    fixed3 color = ambient + diffuse + specular;
                    fixed3 noise = tex2D(_FurTex, i.uv.zw * _FurThinness).rgb;
                   
                    fixed alpha = clamp(noise - (FURSTEP * FURSTEP) * _FurDensity, 0, 1);
                    clip(alpha-_Cutoff);
                
                    return fixed4(color*(shadow+_ShadowAdjust), alpha*3.5);
                }


                
                ENDCG              
            }
            Pass
            {
                CGPROGRAM
                
               #pragma vertex vert_base
               #pragma fragment frag_base
               #define FURSTEP 0.18
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

                fixed4 _Color;
                fixed4 _Specular;
                half _Shininess;
                fixed _ShadowAdjust;
                half _ShadowRange;
                half _WindAmplitude;
                half _WindFrequency;
                half _WindDistribution;
                fixed _Cutoff;
                
                sampler2D _MainTex;
                half4 _MainTex_ST;
                sampler2D _FurTex;
                half4 _FurTex_ST;
                
                fixed _FurLength;
                fixed _FurDensity;
                fixed _FurThinness;
                fixed _FurShading;
                
                fixed4 _AOColor;
                fixed4 _ShadowColor;
                
                float4 _ForceGlobal;
                float4 _ForceLocal;
                
                
                fixed4 _RimColor;
                half _RimPower;

                v2f vert_base(appdata_base v)
                {
                    v2f o;
                    v.vertex.x += /*abs*/( sin(/*v.vertex.z */ _WindDistribution + _Time.y * _WindFrequency) * _WindAmplitude) * v.texcoord.y*FURSTEP;
                    v.vertex.y += /*abs*/( cos(/*v.vertex.y */ _WindDistribution + _Time.y * _WindFrequency) * _WindAmplitude) * v.texcoord.y*FURSTEP;
                
                    float3 P = v.vertex.xyz + v.normal * _FurLength * FURSTEP;
                    P += clamp(mul(unity_WorldToObject, _ForceGlobal).xyz + _ForceLocal.xyz, -1, 1) * pow(FURSTEP, 3) * _FurLength;
                    o.pos = UnityObjectToClipPos(float4(P, 1.0));
                    o.uv.xy = TRANSFORM_TEX(v.texcoord, _MainTex);
                    o.uv.zw = TRANSFORM_TEX(v.texcoord, _FurTex);
                    //clip(_FurTex.a - _Cutoff);
                    o.worldNormal = UnityObjectToWorldNormal(v.normal);
                    o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
                    TRANSFER_SHADOW(o)  
                    return o;
                }
                fixed4 frag_base(v2f i): SV_Target
                {
                    fixed3 worldNormal = normalize(i.worldNormal);
                    fixed3 worldLight = normalize(_WorldSpaceLightPos0.xyz);
                    fixed3 worldView = normalize(_WorldSpaceCameraPos.xyz - i.worldPos.xyz);
                    fixed3 worldHalf = normalize(worldView + worldLight);
                    fixed shadow = SHADOW_ATTENUATION(i);  
                    
                    fixed3 albedo = tex2D(_MainTex, i.uv.xy).rgb * _Color;
                    albedo -= (pow(1 - FURSTEP, 3)) * _FurShading;
                    half rim = 1.0 - saturate(dot(worldView, worldNormal));
                    albedo += fixed4(_RimColor.rgb * pow(rim, _RimPower), 1.0);
                    
                    
                    fixed3 ambient = (dot(UNITY_LIGHTMODEL_AMBIENT.xyz,(1,1,1))<0.8?UNITY_LIGHTMODEL_AMBIENT.xyz+(1.5,1.5,1.5):UNITY_LIGHTMODEL_AMBIENT) * albedo*_AOColor;
                    fixed3 diffuse = _LightColor0.rgb * albedo * saturate(dot(worldNormal, worldLight));
                    fixed3 lightting = pow(saturate(dot(worldNormal, worldLight)),_ShadowRange);
                    fixed3 specular = _LightColor0.rgb * _Specular.rgb * pow(saturate(dot(worldNormal, worldHalf)), _Shininess);
                
                
                    fixed3 color = ambient + diffuse + specular;
                    fixed3 noise = tex2D(_FurTex, i.uv.zw * _FurThinness).rgb;
                   
                    fixed alpha = clamp(noise - (FURSTEP * FURSTEP) * _FurDensity, 0, 1);
                    clip(alpha-_Cutoff);
                
                    return fixed4(color*(shadow+_ShadowAdjust), alpha*3.5);
                }


                
                ENDCG              
            }
            Pass
            {
                CGPROGRAM
                
               #pragma vertex vert_base
               #pragma fragment frag_base
               #define FURSTEP 0.21
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

                fixed4 _Color;
                fixed4 _Specular;
                half _Shininess;
                fixed _ShadowAdjust;
                half _ShadowRange;
                half _WindAmplitude;
                half _WindFrequency;
                half _WindDistribution;
                fixed _Cutoff;
                
                sampler2D _MainTex;
                half4 _MainTex_ST;
                sampler2D _FurTex;
                half4 _FurTex_ST;
                
                fixed _FurLength;
                fixed _FurDensity;
                fixed _FurThinness;
                fixed _FurShading;
                
                fixed4 _AOColor;
                fixed4 _ShadowColor;
                
                float4 _ForceGlobal;
                float4 _ForceLocal;
                
                
                fixed4 _RimColor;
                half _RimPower;

                v2f vert_base(appdata_base v)
                {
                    v2f o;
                    v.vertex.x += /*abs*/( sin(/*v.vertex.z */ _WindDistribution + _Time.y * _WindFrequency) * _WindAmplitude) * v.texcoord.y*FURSTEP;
                    v.vertex.y += /*abs*/( cos(/*v.vertex.y */ _WindDistribution + _Time.y * _WindFrequency) * _WindAmplitude) * v.texcoord.y*FURSTEP;
                
                    float3 P = v.vertex.xyz + v.normal * _FurLength * FURSTEP;
                    P += clamp(mul(unity_WorldToObject, _ForceGlobal).xyz + _ForceLocal.xyz, -1, 1) * pow(FURSTEP, 3) * _FurLength;
                    o.pos = UnityObjectToClipPos(float4(P, 1.0));
                    o.uv.xy = TRANSFORM_TEX(v.texcoord, _MainTex);
                    o.uv.zw = TRANSFORM_TEX(v.texcoord, _FurTex);
                    //clip(_FurTex.a - _Cutoff);
                    o.worldNormal = UnityObjectToWorldNormal(v.normal);
                    o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
                    TRANSFER_SHADOW(o)  
                    return o;
                }
                fixed4 frag_base(v2f i): SV_Target
                {
                    fixed3 worldNormal = normalize(i.worldNormal);
                    fixed3 worldLight = normalize(_WorldSpaceLightPos0.xyz);
                    fixed3 worldView = normalize(_WorldSpaceCameraPos.xyz - i.worldPos.xyz);
                    fixed3 worldHalf = normalize(worldView + worldLight);
                    fixed shadow = SHADOW_ATTENUATION(i);  
                    
                    fixed3 albedo = tex2D(_MainTex, i.uv.xy).rgb * _Color;
                    albedo -= (pow(1 - FURSTEP, 3)) * _FurShading;
                    half rim = 1.0 - saturate(dot(worldView, worldNormal));
                    albedo += fixed4(_RimColor.rgb * pow(rim, _RimPower), 1.0);
                    
                    
                    fixed3 ambient = (dot(UNITY_LIGHTMODEL_AMBIENT.xyz,(1,1,1))<0.8?UNITY_LIGHTMODEL_AMBIENT.xyz+(1.5,1.5,1.5):UNITY_LIGHTMODEL_AMBIENT) * albedo*_AOColor;
                    fixed3 diffuse = _LightColor0.rgb * albedo * saturate(dot(worldNormal, worldLight));
                    fixed3 lightting = pow(saturate(dot(worldNormal, worldLight)),_ShadowRange);
                    fixed3 specular = _LightColor0.rgb * _Specular.rgb * pow(saturate(dot(worldNormal, worldHalf)), _Shininess);
                
                
                    fixed3 color = ambient + diffuse + specular;
                    fixed3 noise = tex2D(_FurTex, i.uv.zw * _FurThinness).rgb;
                   
                    fixed alpha = clamp(noise - (FURSTEP * FURSTEP) * _FurDensity, 0, 1);
                    clip(alpha-_Cutoff);
                
                    return fixed4(color*(shadow+_ShadowAdjust), alpha*3.5);
                }


                
                ENDCG              
            }
            Pass
            {
                CGPROGRAM
                
               #pragma vertex vert_base
               #pragma fragment frag_base
               #define FURSTEP 0.24
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

                fixed4 _Color;
                fixed4 _Specular;
                half _Shininess;
                fixed _ShadowAdjust;
                half _ShadowRange;
                half _WindAmplitude;
                half _WindFrequency;
                half _WindDistribution;
                fixed _Cutoff;
                
                sampler2D _MainTex;
                half4 _MainTex_ST;
                sampler2D _FurTex;
                half4 _FurTex_ST;
                
                fixed _FurLength;
                fixed _FurDensity;
                fixed _FurThinness;
                fixed _FurShading;
                
                fixed4 _AOColor;
                fixed4 _ShadowColor;
                
                float4 _ForceGlobal;
                float4 _ForceLocal;
                
                
                fixed4 _RimColor;
                half _RimPower;

                v2f vert_base(appdata_base v)
                {
                    v2f o;
                    v.vertex.x += /*abs*/( sin(/*v.vertex.z */ _WindDistribution + _Time.y * _WindFrequency) * _WindAmplitude) * v.texcoord.y*FURSTEP;
                    v.vertex.y += /*abs*/( cos(/*v.vertex.y */ _WindDistribution + _Time.y * _WindFrequency) * _WindAmplitude) * v.texcoord.y*FURSTEP;
                
                    float3 P = v.vertex.xyz + v.normal * _FurLength * FURSTEP;
                    P += clamp(mul(unity_WorldToObject, _ForceGlobal).xyz + _ForceLocal.xyz, -1, 1) * pow(FURSTEP, 3) * _FurLength;
                    o.pos = UnityObjectToClipPos(float4(P, 1.0));
                    o.uv.xy = TRANSFORM_TEX(v.texcoord, _MainTex);
                    o.uv.zw = TRANSFORM_TEX(v.texcoord, _FurTex);
                    //clip(_FurTex.a - _Cutoff);
                    o.worldNormal = UnityObjectToWorldNormal(v.normal);
                    o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
                    TRANSFER_SHADOW(o)  
                    return o;
                }
                fixed4 frag_base(v2f i): SV_Target
                {
                    fixed3 worldNormal = normalize(i.worldNormal);
                    fixed3 worldLight = normalize(_WorldSpaceLightPos0.xyz);
                    fixed3 worldView = normalize(_WorldSpaceCameraPos.xyz - i.worldPos.xyz);
                    fixed3 worldHalf = normalize(worldView + worldLight);
                    fixed shadow = SHADOW_ATTENUATION(i);  
                    
                    fixed3 albedo = tex2D(_MainTex, i.uv.xy).rgb * _Color;
                    albedo -= (pow(1 - FURSTEP, 3)) * _FurShading;
                    half rim = 1.0 - saturate(dot(worldView, worldNormal));
                    albedo += fixed4(_RimColor.rgb * pow(rim, _RimPower), 1.0);
                    
                    
                    fixed3 ambient = (dot(UNITY_LIGHTMODEL_AMBIENT.xyz,(1,1,1))<0.8?UNITY_LIGHTMODEL_AMBIENT.xyz+(1.5,1.5,1.5):UNITY_LIGHTMODEL_AMBIENT) * albedo*_AOColor;
                    fixed3 diffuse = _LightColor0.rgb * albedo * saturate(dot(worldNormal, worldLight));
                    fixed3 lightting = pow(saturate(dot(worldNormal, worldLight)),_ShadowRange);
                    fixed3 specular = _LightColor0.rgb * _Specular.rgb * pow(saturate(dot(worldNormal, worldHalf)), _Shininess);
                
                
                    fixed3 color = ambient + diffuse + specular;
                    fixed3 noise = tex2D(_FurTex, i.uv.zw * _FurThinness).rgb;
                   
                    fixed alpha = clamp(noise - (FURSTEP * FURSTEP) * _FurDensity, 0, 1);
                    clip(alpha-_Cutoff);
                
                    return fixed4(color*(shadow+_ShadowAdjust), alpha*3.5);
                }


                
                ENDCG              
            }
            Pass
            {
                CGPROGRAM
                
               #pragma vertex vert_base
               #pragma fragment frag_base
               #define FURSTEP 0.27
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

                fixed4 _Color;
                fixed4 _Specular;
                half _Shininess;
                fixed _ShadowAdjust;
                half _ShadowRange;
                half _WindAmplitude;
                half _WindFrequency;
                half _WindDistribution;
                fixed _Cutoff;
                
                sampler2D _MainTex;
                half4 _MainTex_ST;
                sampler2D _FurTex;
                half4 _FurTex_ST;
                
                fixed _FurLength;
                fixed _FurDensity;
                fixed _FurThinness;
                fixed _FurShading;
                
                fixed4 _AOColor;
                fixed4 _ShadowColor;
                
                float4 _ForceGlobal;
                float4 _ForceLocal;
                
                
                fixed4 _RimColor;
                half _RimPower;

                v2f vert_base(appdata_base v)
                {
                    v2f o;
                    v.vertex.x += /*abs*/( sin(/*v.vertex.z */ _WindDistribution + _Time.y * _WindFrequency) * _WindAmplitude) * v.texcoord.y*FURSTEP;
                    v.vertex.y += /*abs*/( cos(/*v.vertex.y */ _WindDistribution + _Time.y * _WindFrequency) * _WindAmplitude) * v.texcoord.y*FURSTEP;
                
                    float3 P = v.vertex.xyz + v.normal * _FurLength * FURSTEP;
                    P += clamp(mul(unity_WorldToObject, _ForceGlobal).xyz + _ForceLocal.xyz, -1, 1) * pow(FURSTEP, 3) * _FurLength;
                    o.pos = UnityObjectToClipPos(float4(P, 1.0));
                    o.uv.xy = TRANSFORM_TEX(v.texcoord, _MainTex);
                    o.uv.zw = TRANSFORM_TEX(v.texcoord, _FurTex);
                    //clip(_FurTex.a - _Cutoff);
                    o.worldNormal = UnityObjectToWorldNormal(v.normal);
                    o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
                    TRANSFER_SHADOW(o)  
                    return o;
                }
                fixed4 frag_base(v2f i): SV_Target
                {
                    fixed3 worldNormal = normalize(i.worldNormal);
                    fixed3 worldLight = normalize(_WorldSpaceLightPos0.xyz);
                    fixed3 worldView = normalize(_WorldSpaceCameraPos.xyz - i.worldPos.xyz);
                    fixed3 worldHalf = normalize(worldView + worldLight);
                    fixed shadow = SHADOW_ATTENUATION(i);  
                    
                    fixed3 albedo = tex2D(_MainTex, i.uv.xy).rgb * _Color;
                    albedo -= (pow(1 - FURSTEP, 3)) * _FurShading;
                    half rim = 1.0 - saturate(dot(worldView, worldNormal));
                    albedo += fixed4(_RimColor.rgb * pow(rim, _RimPower), 1.0);
                    
                    
                    fixed3 ambient = (dot(UNITY_LIGHTMODEL_AMBIENT.xyz,(1,1,1))<0.8?UNITY_LIGHTMODEL_AMBIENT.xyz+(1.5,1.5,1.5):UNITY_LIGHTMODEL_AMBIENT) * albedo*_AOColor;
                    fixed3 diffuse = _LightColor0.rgb * albedo * saturate(dot(worldNormal, worldLight));
                    fixed3 lightting = pow(saturate(dot(worldNormal, worldLight)),_ShadowRange);
                    fixed3 specular = _LightColor0.rgb * _Specular.rgb * pow(saturate(dot(worldNormal, worldHalf)), _Shininess);
                
                
                    fixed3 color = ambient + diffuse + specular;
                    fixed3 noise = tex2D(_FurTex, i.uv.zw * _FurThinness).rgb;
                   
                    fixed alpha = clamp(noise - (FURSTEP * FURSTEP) * _FurDensity, 0, 1);
                    clip(alpha-_Cutoff);
                
                    return fixed4(color*(shadow+_ShadowAdjust), alpha*3.5);
                }


                
                ENDCG              
            }
            Pass
            {
                CGPROGRAM
                
               #pragma vertex vert_base
               #pragma fragment frag_base
               #define FURSTEP 0.30
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

                fixed4 _Color;
                fixed4 _Specular;
                half _Shininess;
                fixed _ShadowAdjust;
                half _ShadowRange;
                half _WindAmplitude;
                half _WindFrequency;
                half _WindDistribution;
                fixed _Cutoff;
                
                sampler2D _MainTex;
                half4 _MainTex_ST;
                sampler2D _FurTex;
                half4 _FurTex_ST;
                
                fixed _FurLength;
                fixed _FurDensity;
                fixed _FurThinness;
                fixed _FurShading;
                
                fixed4 _AOColor;
                fixed4 _ShadowColor;
                
                float4 _ForceGlobal;
                float4 _ForceLocal;
                
                
                fixed4 _RimColor;
                half _RimPower;

                v2f vert_base(appdata_base v)
                {
                    v2f o;
                    v.vertex.x += /*abs*/( sin(/*v.vertex.z */ _WindDistribution + _Time.y * _WindFrequency) * _WindAmplitude) * v.texcoord.y*FURSTEP;
                    v.vertex.y += /*abs*/( cos(/*v.vertex.y */ _WindDistribution + _Time.y * _WindFrequency) * _WindAmplitude) * v.texcoord.y*FURSTEP;
                
                    float3 P = v.vertex.xyz + v.normal * _FurLength * FURSTEP;
                    P += clamp(mul(unity_WorldToObject, _ForceGlobal).xyz + _ForceLocal.xyz, -1, 1) * pow(FURSTEP, 3) * _FurLength;
                    o.pos = UnityObjectToClipPos(float4(P, 1.0));
                    o.uv.xy = TRANSFORM_TEX(v.texcoord, _MainTex);
                    o.uv.zw = TRANSFORM_TEX(v.texcoord, _FurTex);
                    //clip(_FurTex.a - _Cutoff);
                    o.worldNormal = UnityObjectToWorldNormal(v.normal);
                    o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
                    TRANSFER_SHADOW(o)  
                    return o;
                }
                fixed4 frag_base(v2f i): SV_Target
                {
                    fixed3 worldNormal = normalize(i.worldNormal);
                    fixed3 worldLight = normalize(_WorldSpaceLightPos0.xyz);
                    fixed3 worldView = normalize(_WorldSpaceCameraPos.xyz - i.worldPos.xyz);
                    fixed3 worldHalf = normalize(worldView + worldLight);
                    fixed shadow = SHADOW_ATTENUATION(i);  
                    
                    fixed3 albedo = tex2D(_MainTex, i.uv.xy).rgb * _Color;
                    albedo -= (pow(1 - FURSTEP, 3)) * _FurShading;
                    half rim = 1.0 - saturate(dot(worldView, worldNormal));
                    albedo += fixed4(_RimColor.rgb * pow(rim, _RimPower), 1.0);
                    
                    
                    fixed3 ambient = (dot(UNITY_LIGHTMODEL_AMBIENT.xyz,(1,1,1))<0.8?UNITY_LIGHTMODEL_AMBIENT.xyz+(1.5,1.5,1.5):UNITY_LIGHTMODEL_AMBIENT) * albedo*_AOColor;
                    fixed3 diffuse = _LightColor0.rgb * albedo * saturate(dot(worldNormal, worldLight));
                    fixed3 lightting = pow(saturate(dot(worldNormal, worldLight)),_ShadowRange);
                    fixed3 specular = _LightColor0.rgb * _Specular.rgb * pow(saturate(dot(worldNormal, worldHalf)), _Shininess);
                
                
                    fixed3 color = ambient + diffuse + specular;
                    fixed3 noise = tex2D(_FurTex, i.uv.zw * _FurThinness).rgb;
                   
                    fixed alpha = clamp(noise - (FURSTEP * FURSTEP) * _FurDensity, 0, 1);
                    clip(alpha-_Cutoff);
                
                    return fixed4(color*(shadow+_ShadowAdjust), alpha*3.5);
                }


                
                ENDCG              
            }

            
        } 
        
        Fallback "VertexLit"
   }
}       