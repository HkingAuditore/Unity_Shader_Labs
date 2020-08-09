Shader "Grass/FixedGrass"
{
 Properties
    {
        [Header(Grass Basic Color Setting)]
        _MainTex ("Texture", 2D) = "white" { }
        _Color ("Color", Color) = (1, 1, 1, 1)
        _RimColor ("Rim Color", Color) = (0, 0, 0, 1)
        _RimPower ("Rim Power", Range(0.0, 1.0)) = 6.0


        [Header(Grass Lighting Setting)]
        _AOTex ("AO Texture", 2D) = "white" { }
        _AOColor ("AO Color", Color) = (1,1,1,1)      
        _Shininess ("Shininess", Range(0.00, 1.0)) = 0.5
        _ShadowColor ("Shadow Color", Color) = (1,1,1,1)

        
        [Header(Fur Setting)]
         _FurTex ("Fur Pattern", 2D) = "white" { }
         _Cutoff ("Cutoff", Range(0.01, 1.0)) = 0.5
        _FurLength ("Fur Length", Range(0.0, 1)) = 0.5
        _FurDensity ("Fur Density", Range(0, 2)) = 0.11
        _FurThinness ("Fur Thinness", Range(0.01, 10)) = 1
        _FurShading ("Fur Shading", Range(0.0, 0.5)) = 0.05



        [Header(Fur Animation Setting)]
        _ForceGlobal ("Force Global", Vector) = (0, 0, 0, 0)
        _ForceLocal ("Force Local", Vector) = (0, 0, 0, 0)
        _WindAmplitude ("Wind Amplitude", Float) = 0.01
	    _WindFrequency ("Wind Frequency", Float) = 5
	    _WindDistribution ("Wind Distribution", Float) = 120
    }
    
    Category
    {

        Tags { "LightMode" = "ShadowCaster" "Queue"="Geometry+1" "LightMode"="ForwardBase" "IgnoreProjector" = "False" "Queue"="Geometry+1" }
		LOD 200
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
                #pragma shader_feature _NORMALMAP_ON
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
                half _Shininess;
 
                fixed _Cutoff;

                sampler2D _MainTex;
                half4 _MainTex_ST;
                sampler2D _FurTex;
                half4 _FurTex_ST;
                sampler2D _AOTex;
                half4 _AOTex_ST;


                fixed4 _AOColor;
                fixed4 _ShadowColor;


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

                    fixed3 col = tex2D(_MainTex, i.uv.xy).rgb * _Color;
                
                    fixed ambient = lerp(0,1,(tex2D(_AOTex,i.uv.xy*5).r + tex2D(_AOTex,i.uv.xy*5).g + tex2D(_AOTex,i.uv.xy*5).b)*.657);
                    fixed4 ambientCol =fixed4((ambient * _AOColor).rgb,ambient*0.5);

                    fixed diffuse =lerp(0,1,saturate(dot(worldNormal, worldLight))*shadow);
                    fixed4 diffuseCol =fixed4((diffuse * _LightColor0).rgb + ((1-diffuse) * _ShadowColor * 0.5).rgb,diffuse);

                    fixed specular = pow(saturate(dot(worldNormal, worldHalf)), _Shininess*2.5)*0.85;

                    col = col*(1 - ambientCol.a) + ambientCol * ambientCol.a;
                    col = col * diffuseCol * lerp(0.86,1.4,specular-ambient*0.2)  ;

                    fixed3 color = col + diffuse;


                    return fixed4(col ,1);
                }
                ENDCG           
            }  

            Pass
            {
                CGPROGRAM
                
                #pragma vertex vert
                #pragma fragment frag
                
                #pragma target 3.0
                #include "UnityCG.cginc"
                #include "UnityPBSLighting.cginc"
                #include "UnityStandardBRDF.cginc"
                #pragma multi_compile_fwdadd_fullshadows
                #pragma multi_compile_fwdbase
                #include "Lighting.cginc" 
                #include "AutoLight.cginc"

                #define FURSTEP 0.03
                #include "FurPass.cginc"
              
                ENDCG
                
            }
            
            Pass
            {
                CGPROGRAM
                
                #pragma vertex vert
                #pragma fragment frag
                #define FURSTEP 0.06
                                #pragma target 3.0
                #include "UnityCG.cginc"
                #include "UnityPBSLighting.cginc"
                #include "UnityStandardBRDF.cginc"
                #pragma multi_compile_fwdadd_fullshadows
                #pragma multi_compile_fwdbase
                #include "Lighting.cginc" 
                #include "AutoLight.cginc"
                #include "FurPass.cginc"
                
                ENDCG
                
            }
            
            Pass
            {
                CGPROGRAM
                
                #pragma vertex vert
                #pragma fragment frag
                #define FURSTEP 0.09
                                #pragma target 3.0
                #include "UnityCG.cginc"
                #include "UnityPBSLighting.cginc"
                #include "UnityStandardBRDF.cginc"
                #pragma multi_compile_fwdadd_fullshadows
                #pragma multi_compile_fwdbase
                #include "Lighting.cginc" 
                #include "AutoLight.cginc"
                #include "FurPass.cginc"
                
                ENDCG
                
            }
            
            Pass
            {
                CGPROGRAM
                
                #pragma vertex vert
                #pragma fragment frag
                #define FURSTEP 0.12
                                #pragma target 3.0
                #include "UnityCG.cginc"
                #include "UnityPBSLighting.cginc"
                #include "UnityStandardBRDF.cginc"
                #pragma multi_compile_fwdadd_fullshadows
                #pragma multi_compile_fwdbase
                #include "Lighting.cginc" 
                #include "AutoLight.cginc"
                #include "FurPass.cginc"
                
                ENDCG
                
            }
            
            Pass
            {
                CGPROGRAM
                
                #pragma vertex vert
                #pragma fragment frag
                #define FURSTEP 0.15
                                #pragma target 3.0
                #include "UnityCG.cginc"
                #include "UnityPBSLighting.cginc"
                #include "UnityStandardBRDF.cginc"
                #pragma multi_compile_fwdadd_fullshadows
                #pragma multi_compile_fwdbase
                #include "Lighting.cginc" 
                #include "AutoLight.cginc"
                #include "FurPass.cginc"
                
                ENDCG
                
            }
            
            Pass
            {
                CGPROGRAM
                
                #pragma vertex vert
                #pragma fragment frag
                #define FURSTEP 0.18
                                #pragma target 3.0
                #include "UnityCG.cginc"
                #include "UnityPBSLighting.cginc"
                #include "UnityStandardBRDF.cginc"
                #pragma multi_compile_fwdadd_fullshadows
                #pragma multi_compile_fwdbase
                #include "Lighting.cginc" 
                #include "AutoLight.cginc"
                #include "FurPass.cginc"
                
                ENDCG
                
            }
            
            Pass
            {
                CGPROGRAM
                
                #pragma vertex vert
                #pragma fragment frag
                #define FURSTEP 0.21
                                #pragma target 3.0
                #include "UnityCG.cginc"
                #include "UnityPBSLighting.cginc"
                #include "UnityStandardBRDF.cginc"
                #pragma multi_compile_fwdadd_fullshadows
                #pragma multi_compile_fwdbase
                #include "Lighting.cginc" 
                #include "AutoLight.cginc"
                #include "FurPass.cginc"
                
                ENDCG
                
            }
            
            Pass
            {
                CGPROGRAM
                
                #pragma vertex vert
                #pragma fragment frag
                #define FURSTEP 0.24
                                #pragma target 3.0
                #include "UnityCG.cginc"
                #include "UnityPBSLighting.cginc"
                #include "UnityStandardBRDF.cginc"
                #pragma multi_compile_fwdadd_fullshadows
                #pragma multi_compile_fwdbase
                #include "Lighting.cginc" 
                #include "AutoLight.cginc"
                #include "FurPass.cginc"
                
                ENDCG
                
            }
            
            Pass
            {
                CGPROGRAM
                
                #pragma vertex vert
                #pragma fragment frag
                #define FURSTEP 0.27
                                #pragma target 3.0
                #include "UnityCG.cginc"
                #include "UnityPBSLighting.cginc"
                #include "UnityStandardBRDF.cginc"
                #pragma multi_compile_fwdadd_fullshadows
                #pragma multi_compile_fwdbase
                #include "Lighting.cginc" 
                #include "AutoLight.cginc"
                #include "FurPass.cginc"
                
                ENDCG
                
            }
            
            Pass
            {
                CGPROGRAM
                
                #pragma vertex vert
                #pragma fragment frag
                #define FURSTEP 0.30
                                #pragma target 3.0
                #include "UnityCG.cginc"
                #include "UnityPBSLighting.cginc"
                #include "UnityStandardBRDF.cginc"
                #pragma multi_compile_fwdadd_fullshadows
                #pragma multi_compile_fwdbase
                #include "Lighting.cginc" 
                #include "AutoLight.cginc"
                #include "FurPass.cginc"
                
                ENDCG
                
            }
            
             Pass
            {
                CGPROGRAM
                
                #pragma vertex vert
                #pragma fragment frag
                #define FURSTEP 0.33
                                #pragma target 3.0
                #include "UnityCG.cginc"
                #include "UnityPBSLighting.cginc"
                #include "UnityStandardBRDF.cginc"
                #pragma multi_compile_fwdadd_fullshadows
                #pragma multi_compile_fwdbase
                #include "Lighting.cginc" 
                #include "AutoLight.cginc"
                #include "FurPass.cginc"
                
                ENDCG
                
            }
            
            Pass
            {
                CGPROGRAM
                
                #pragma vertex vert
                #pragma fragment frag
                #define FURSTEP 0.36
                                #pragma target 3.0
                #include "UnityCG.cginc"
                #include "UnityPBSLighting.cginc"
                #include "UnityStandardBRDF.cginc"
                #pragma multi_compile_fwdadd_fullshadows
                #pragma multi_compile_fwdbase
                #include "Lighting.cginc" 
                #include "AutoLight.cginc"
                #include "FurPass.cginc"
                
                ENDCG
                
            }
            
            Pass
            {
                CGPROGRAM
                
                #pragma vertex vert
                #pragma fragment frag
                #define FURSTEP 0.39
                                #pragma target 3.0
                #include "UnityCG.cginc"
                #include "UnityPBSLighting.cginc"
                #include "UnityStandardBRDF.cginc"
                #pragma multi_compile_fwdadd_fullshadows
                #pragma multi_compile_fwdbase
                #include "Lighting.cginc" 
                #include "AutoLight.cginc"
                #include "FurPass.cginc"
                
                ENDCG
                
            }
            
            Pass
            {
                CGPROGRAM
                
                #pragma vertex vert
                #pragma fragment frag
                #define FURSTEP 0.42
                                #pragma target 3.0
                #include "UnityCG.cginc"
                #include "UnityPBSLighting.cginc"
                #include "UnityStandardBRDF.cginc"
                #pragma multi_compile_fwdadd_fullshadows
                #pragma multi_compile_fwdbase
                #include "Lighting.cginc" 
                #include "AutoLight.cginc"
                #include "FurPass.cginc"
                
                ENDCG
                
            }
            
            Pass
            {
                CGPROGRAM
                
                #pragma vertex vert
                #pragma fragment frag
                #define FURSTEP 0.45
                                #pragma target 3.0
                #include "UnityCG.cginc"
                #include "UnityPBSLighting.cginc"
                #include "UnityStandardBRDF.cginc"
                #pragma multi_compile_fwdadd_fullshadows
                #pragma multi_compile_fwdbase
                #include "Lighting.cginc" 
                #include "AutoLight.cginc"
                #include "FurPass.cginc"
                
                ENDCG
                
            }
            
            Pass
            {
                CGPROGRAM
                
                #pragma vertex vert
                #pragma fragment frag
                #define FURSTEP 0.48
                                #pragma target 3.0
                #include "UnityCG.cginc"
                #include "UnityPBSLighting.cginc"
                #include "UnityStandardBRDF.cginc"
                #pragma multi_compile_fwdadd_fullshadows
                #pragma multi_compile_fwdbase
                #include "Lighting.cginc" 
                #include "AutoLight.cginc"
                #include "FurPass.cginc"
                
                ENDCG
                
            }
            
            Pass
            {
                CGPROGRAM
                
                #pragma vertex vert
                #pragma fragment frag
                #define FURSTEP 0.51
                                #pragma target 3.0
                #include "UnityCG.cginc"
                #include "UnityPBSLighting.cginc"
                #include "UnityStandardBRDF.cginc"
                #pragma multi_compile_fwdadd_fullshadows
                #pragma multi_compile_fwdbase
                #include "Lighting.cginc" 
                #include "AutoLight.cginc"
                #include "FurPass.cginc"
                
                ENDCG
                
            }
            
            Pass
            {
                CGPROGRAM
                
                #pragma vertex vert
                #pragma fragment frag
                #define FURSTEP 0.54
                                #pragma target 3.0
                #include "UnityCG.cginc"
                #include "UnityPBSLighting.cginc"
                #include "UnityStandardBRDF.cginc"
                #pragma multi_compile_fwdadd_fullshadows
                #pragma multi_compile_fwdbase
                #include "Lighting.cginc" 
                #include "AutoLight.cginc"
                #include "FurPass.cginc"
                
                ENDCG
                
            }
            
            Pass
            {
                CGPROGRAM
                
                #pragma vertex vert
                #pragma fragment frag
                #define FURSTEP 0.57
                                #pragma target 3.0
                #include "UnityCG.cginc"
                #include "UnityPBSLighting.cginc"
                #include "UnityStandardBRDF.cginc"
                #pragma multi_compile_fwdadd_fullshadows
                #pragma multi_compile_fwdbase
                #include "Lighting.cginc" 
                #include "AutoLight.cginc"
                #include "FurPass.cginc"
                
                ENDCG
                
            }

            Pass
            {
                CGPROGRAM
                
                #pragma vertex vert
                #pragma fragment frag
                #define FURSTEP 0.60
                                #pragma target 3.0
                #include "UnityCG.cginc"
                #include "UnityPBSLighting.cginc"
                #include "UnityStandardBRDF.cginc"
                #pragma multi_compile_fwdadd_fullshadows
                #pragma multi_compile_fwdbase
                #include "Lighting.cginc" 
                #include "AutoLight.cginc"
                #include "FurPass.cginc"
                
                ENDCG
                
            } 

        } 
        
        Fallback "VertexLit"
   }
}       