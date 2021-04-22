Shader "EyeTracing/EyeTracing"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Eye Tex", 2D) = "white" {}
        _BallTex ("Eye Ball Tex", 2D) = "white" {}
        _Radius ("Radius", Range(0,1)) = 0.5
        _Angle("Angle", Range(0,1)) = 0.5
        _Glossiness ("Smoothness", Range(0,1)) = 0.5
        _Metallic ("Metallic", Range(0,1)) = 0.0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard fullforwardshadows

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _MainTex;
        sampler2D _BallTex;

        struct Input
        {
            float2 uv_MainTex;
        };

        half _Glossiness;
        half _Metallic;
        half _Radius;
        half _Angle;
        fixed4 _Color;

        UNITY_INSTANCING_BUFFER_START(Props)
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            // Albedo comes from a texture tinted by color
            fixed4 col = tex2D (_MainTex, IN.uv_MainTex) * _Color;
            half fixedAngle = radians(clamp(_Angle*360,0,360));
            fixed2 ballOffset = fixed2(_Radius * cos(fixedAngle),_Radius*sin(fixedAngle));
            fixed4 eyeball = tex2D (_BallTex, IN.uv_MainTex + ballOffset);
            col = col*(1 - eyeball.a) + eyeball * eyeball.a;
            o.Albedo = col.rgb;
            // Metallic and smoothness come from slider variables
            o.Metallic = _Metallic;
            o.Smoothness = _Glossiness;
            o.Alpha = col.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
