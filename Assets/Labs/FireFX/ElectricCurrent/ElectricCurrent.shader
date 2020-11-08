Shader "Unlit/ElectricCurrent"
{
    Properties
    {
        [HDR]_TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
        _MainTex ("Particle Texture", 2D) = "white" {}
        _MaskTex ("Mask Texture", 2D) = "white" {}
        _RampTex ("Ramp Texture", 2D) = "white" {}
        _InvFade ("Soft Particles Factor", Range(0.01,3.0)) = 1.0
        _FireOut("Fire Out",float) = .5
        
        _BackMaskSpeed ("Back Mask Speed", float) = .1
        _FrontMaskSpeed ("Front Mask Speed", float) = .8
        _FrontSize ("Front Size", Range(0,1)) = .5
        _BackSize ("Back Size", Range(0,1)) = .5
        _FireClip ("Fire Clip", Range(0,1)) = .5
        _FireTransparency ("Fire Transparency", Range(0,1)) = .5

    }

    Category
    {
        Tags
        {
            "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" "PreviewType"="Plane"
        }
        Blend SrcAlpha OneMinusSrcAlpha
        ColorMask RGB
        Cull Off Lighting Off ZWrite Off

        SubShader
        {
            Pass
            {

                CGPROGRAM
                #pragma vertex vert
                #pragma fragment frag
                #pragma target 2.0
                #pragma multi_compile_particles
                #pragma multi_compile_fog

                #include "UnityCG.cginc"

                sampler2D _MainTex;
                float4 _MainTex_ST;
                sampler2D _MaskTex;
                sampler2D _RampTex;
                fixed4 _TintColor;
                fixed _FireOut;

                float _BackMaskSpeed;
                float _FrontMaskSpeed;
                float _FrontSize;
                float _BackSize;
                float _FireClip;
                float _FireTransparency;

                struct appdata_t
                {
                    float4 vertex : POSITION;
                    fixed4 color : COLOR;
                    float4 texcoord : TEXCOORD0;
                    UNITY_VERTEX_INPUT_INSTANCE_ID
                };

                struct v2f
                {
                    float4 vertex : SV_POSITION;
                    fixed4 color : COLOR;
                    float2 texcoord : TEXCOORD0;
                    float customData	: TEXCOORD1;
                    UNITY_FOG_COORDS(1)
                    #ifdef SOFTPARTICLES_ON
                float4 projPos : TEXCOORD2;
                    #endif
                    UNITY_VERTEX_OUTPUT_STEREO
                };

                

                v2f vert(appdata_t v)
                {
                    v2f o;
                    UNITY_SETUP_INSTANCE_ID(v);
                    UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
                    o.vertex = UnityObjectToClipPos(v.vertex);
                    #ifdef SOFTPARTICLES_ON
                        o.projPos = ComputeScreenPos (o.vertex);
                        COMPUTE_EYEDEPTH(o.projPos.z);
                    #endif
                    o.color = v.color;
                    o.texcoord = TRANSFORM_TEX(v.texcoord, _MainTex);
                    o.customData = v.texcoord.z;
                    UNITY_TRANSFER_FOG(o, o.vertex);
                    return o;
                }

                UNITY_DECLARE_DEPTH_TEXTURE(_CameraDepthTexture);
                float _InvFade;

                fixed4 frag(v2f i) : SV_Target
                {
                    #ifdef SOFTPARTICLES_ON
                        float sceneZ = LinearEyeDepth (SAMPLE_DEPTH_TEXTURE_PROJ(_CameraDepthTexture, UNITY_PROJ_COORD(i.projPos)));
                        float partZ = i.projPos.z;
                        float fade = saturate (_InvFade * (sceneZ-partZ));
                        i.color *= fade;
                    #endif
                    
                    //基础色
                    fixed4 tex = tex2D(_MainTex, i.texcoord);
                    fixed4 col;
                    col.rgb = _TintColor.rgb * tex.rgb * i.color.rgb;
                    col.a = saturate(pow(tex.a * _TintColor.a * i.color.a,1.2));
                    
                    //火苗
                    fixed2 backMaskUV = i.texcoord * _BackSize + _Time.y * fixed2(0,-_BackMaskSpeed);
                    fixed backMask = tex2D(_MaskTex, backMaskUV).r;
    
                    fixed2 frontMaskUV = fixed2(i.texcoord.x*1.5,i.texcoord.y) * _FrontSize + fixed2(_FrontSize,0)  + _Time.y * fixed2(0,-_FrontMaskSpeed);
                    fixed frontMask = tex2D(_MaskTex, frontMaskUV).r;
    
                    fixed mask = backMask * frontMask;
                    col.a = col.a * saturate(pow(mask,_FireClip)) ;

                    //ramp采样
                    fixed fireRampMap = col.a;
                    float3 ramp = tex2D(_RampTex, float2(fireRampMap,fireRampMap)).rgb;
                    ramp = smoothstep(.3,.8,ramp);
                    
                    clip(col.a- i.customData);
                    
                    UNITY_APPLY_FOG_COLOR(i.fogCoord, col, fixed4(0,0,0,0));
                    return fixed4(col.rgb * ramp,col.a);
                }
                ENDCG
            }
        }

    }
}