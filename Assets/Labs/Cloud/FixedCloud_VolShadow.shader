Shader "Cloud/FixedCloud_VolShadow"
{
 Properties
    {
        [Header(Grass Basic Color Setting)]
        _MainTex ("Texture", 2D) = "white" { }
        _Color ("Color", Color) = (1, 1, 1, 1)
        _RimColor ("Rim Color", Color) = (0, 0, 0, 1)
        _RimPower ("Rim Power", Range(0.0, 1.0)) = 6.0
        _ViewColor ("View Color", Color) = (0, 0, 0, 1)



        [Header(Grass Lighting Setting)]
        _AOTex ("AO Texture", 2D) = "white" { }
        _AOColor ("AO Color", Color) = (1,1,1,1)      
        _Shininess ("Shininess", Float) = 0.5
        _ShadowColor ("Shadow Color", Color) = (1,1,1,1)

        
        [Header(Cloud Setting)]
         _FurTex ("Cloud Pattern", 2D) = "white" { }
         _CloudRampTex ("Cloud Ramp", 2D) = "white" { }
         _ShapeTex ("Shape Pattern", 2D) = "white" { }
         _Cutoff ("Cutoff", Range(0.01, 1.0)) = 0.5
        _FurLength ("Cloud Length", float) = 0.5
        _FurDensity ("Cloud Density", Float) = 0.11
        _FurThinness ("Cloud Thinness", Range(0.01, 10)) = 1
        _FurShading ("Cloud Shading", Float) = 0.05
        _CloudHeight("Cloud Height", float) = 1
        _CloudHeightThinness("Cloud Height Thinness", Float) = .5



        [Header(Cloud Animation Setting)]
        _ForceGlobal ("Force Global", Vector) = (0, 0, 0, 0)
        _ForceLocal ("Force Local", Vector) = (0, 0, 0, 0)
        _WindAmplitude ("Wind Amplitude", Float) = 0.01
	    _WindFrequency ("Wind Frequency", Float) = 5
	    _WindDistribution ("Wind Distribution", Float) = 120
        _CloudSelfSpeed("Cloud Self Speed",Float) = 2
        _CustomLightDir("Custom Light Direction",vector) = (0,0,0,0)
    }
    
    Category
    {

        Tags { "Queue"="AlphaTest" "RenderType"="TransparentCutout" "IgnoreProjector"="True"}
		LOD 200
        Cull Off
        ZWrite On
        Blend SrcAlpha OneMinusSrcAlpha
        
        SubShader
        { 

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
                #include "ShadowPass.cginc"
              
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
                #include "ShadowPass.cginc"
                
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
                #include "ShadowPass.cginc"
                
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
                #include "ShadowPass.cginc"
                
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
                #include "ShadowPass.cginc"
                
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
                #include "ShadowPass.cginc"
                
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
                #include "ShadowPass.cginc"
                
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
                #include "ShadowPass.cginc"
                
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
                #include "ShadowPass.cginc"
                
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
                #include "ShadowPass.cginc"
                
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
                #include "ShadowPass.cginc"
                
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
                #include "ShadowPass.cginc"
                
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
                #include "ShadowPass.cginc"
                
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
                #include "ShadowPass.cginc"
                
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
                #include "ShadowPass.cginc"
                
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
                #include "ShadowPass.cginc"
                
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
                #include "ShadowPass.cginc"
                
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
                #include "ShadowPass.cginc"
                
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
                #include "ShadowPass.cginc"
                
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
                #include "ShadowPass.cginc"
                
                ENDCG
                
            } 
            Pass
            {
                CGPROGRAM
                
                #pragma vertex vert
                #pragma fragment frag
                #define FURSTEP 0.65
                                #pragma target 3.0
                #include "UnityCG.cginc"
                #include "UnityPBSLighting.cginc"
                #include "UnityStandardBRDF.cginc"
                #pragma multi_compile_fwdadd_fullshadows
                #pragma multi_compile_fwdbase
                #include "Lighting.cginc" 
                #include "AutoLight.cginc"
                #include "ShadowPass.cginc"
                
                ENDCG
                
            } 
            Pass
            {
                CGPROGRAM
                
                #pragma vertex vert
                #pragma fragment frag
                #define FURSTEP 0.70
                                #pragma target 3.0
                #include "UnityCG.cginc"
                #include "UnityPBSLighting.cginc"
                #include "UnityStandardBRDF.cginc"
                #pragma multi_compile_fwdadd_fullshadows
                #pragma multi_compile_fwdbase
                #include "Lighting.cginc" 
                #include "AutoLight.cginc"
                #include "ShadowPass.cginc"
                
                ENDCG
                
            } 
            Pass
            {
                CGPROGRAM
                
                #pragma vertex vert
                #pragma fragment frag
                #define FURSTEP 0.75
                                #pragma target 3.0
                #include "UnityCG.cginc"
                #include "UnityPBSLighting.cginc"
                #include "UnityStandardBRDF.cginc"
                #pragma multi_compile_fwdadd_fullshadows
                #pragma multi_compile_fwdbase
                #include "Lighting.cginc" 
                #include "AutoLight.cginc"
                #include "ShadowPass.cginc"
                
                ENDCG
                
            } 
            Pass
            {
                CGPROGRAM
                
                #pragma vertex vert
                #pragma fragment frag
                #define FURSTEP 0.80
                                #pragma target 3.0
                #include "UnityCG.cginc"
                #include "UnityPBSLighting.cginc"
                #include "UnityStandardBRDF.cginc"
                #pragma multi_compile_fwdadd_fullshadows
                #pragma multi_compile_fwdbase
                #include "Lighting.cginc" 
                #include "AutoLight.cginc"
                #include "ShadowPass.cginc"
                
                ENDCG
                
            } 
            Pass
            {
                CGPROGRAM
                
                #pragma vertex vert
                #pragma fragment frag
                #define FURSTEP 0.85
                                #pragma target 3.0
                #include "UnityCG.cginc"
                #include "UnityPBSLighting.cginc"
                #include "UnityStandardBRDF.cginc"
                #pragma multi_compile_fwdadd_fullshadows
                #pragma multi_compile_fwdbase
                #include "Lighting.cginc" 
                #include "AutoLight.cginc"
                #include "ShadowPass.cginc"
                
                ENDCG
                
            } 
            Pass
            {
                CGPROGRAM
                
                #pragma vertex vert
                #pragma fragment frag
                #define FURSTEP 0.90
                                #pragma target 3.0
                #include "UnityCG.cginc"
                #include "UnityPBSLighting.cginc"
                #include "UnityStandardBRDF.cginc"
                #pragma multi_compile_fwdadd_fullshadows
                #pragma multi_compile_fwdbase
                #include "Lighting.cginc" 
                #include "AutoLight.cginc"
                #include "ShadowPass.cginc"
                
                ENDCG
                
            } 
            Pass
            {
                CGPROGRAM
                
                #pragma vertex vert
                #pragma fragment frag
                #define FURSTEP 0.95
                                #pragma target 3.0
                #include "UnityCG.cginc"
                #include "UnityPBSLighting.cginc"
                #include "UnityStandardBRDF.cginc"
                #pragma multi_compile_fwdadd_fullshadows
                #pragma multi_compile_fwdbase
                #include "Lighting.cginc" 
                #include "AutoLight.cginc"
                #include "ShadowPass.cginc"
                
                ENDCG
                
            } 
            Pass
            {
                CGPROGRAM
                
                #pragma vertex vert
                #pragma fragment frag
                #define FURSTEP 1.00
                                #pragma target 3.0
                #include "UnityCG.cginc"
                #include "UnityPBSLighting.cginc"
                #include "UnityStandardBRDF.cginc"
                #pragma multi_compile_fwdadd_fullshadows
                #pragma multi_compile_fwdbase
                #include "Lighting.cginc" 
                #include "AutoLight.cginc"
                #include "ShadowPass.cginc"
                
                ENDCG
                
            } 
            Pass
            {
                CGPROGRAM
                
                #pragma vertex vert
                #pragma fragment frag
                #define FURSTEP 1.05
                                #pragma target 3.0
                #include "UnityCG.cginc"
                #include "UnityPBSLighting.cginc"
                #include "UnityStandardBRDF.cginc"
                #pragma multi_compile_fwdadd_fullshadows
                #pragma multi_compile_fwdbase
                #include "Lighting.cginc" 
                #include "AutoLight.cginc"
                #include "ShadowPass.cginc"
                
                ENDCG
                
            } 
            Pass
            {
                CGPROGRAM
                
                #pragma vertex vert
                #pragma fragment frag
                #define FURSTEP 1.10
                                #pragma target 3.0
                #include "UnityCG.cginc"
                #include "UnityPBSLighting.cginc"
                #include "UnityStandardBRDF.cginc"
                #pragma multi_compile_fwdadd_fullshadows
                #pragma multi_compile_fwdbase
                #include "Lighting.cginc" 
                #include "AutoLight.cginc"
                #include "ShadowPass.cginc"
                
                ENDCG
                
            } 

        } 
        
//        Fallback "Transparent/Cutout/VertexLit" 
   }
}       