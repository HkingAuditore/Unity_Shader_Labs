// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "Scarecrow/Ocean"
{
    Properties
    {
        
       [HDR]_OceanColorShallow ("Ocean Color Shallow", Color) = (1, 1, 1, 1)
       [HDR]_OceanColorDeep ("Ocean Color Deep", Color) = (1, 1, 1, 1)
       [HDR]_OceanColorFre ("Ocean Color Fre", Color) = (1, 1, 1, 1)
       [HDR]_OceanColorSSS ("Ocean Color SSS", Color) = (1, 1, 1, 1)
       _BubblesColor ("Bubbles Color", Color) = (1, 1, 1, 1)
       _FoamColor ("Foam Color", Color) = (1, 1, 1, 1)

        _Specular ("Specular", Color) = (1, 1, 1, 1)
        _Gloss ("Gloss", float) = 20
        _SSSPow ("SSS Pow", Range(.001, 5)) = .5
        _SSSHeight ("SSS Height", float) = .5
        _SSSIntensity ("SSS Intensity", float) = .5
        _EmissionStrength ("Emission Strength", Range(0.001, 100)) = .5

        _FresnelScale ("Fresnel Scale", Range(0, 1)) = 0.5

        _Caustics("Caustics", 2D) = "black" { }
        _Caustics_ST("Caustics ST", Vector) = (1,1,0,0)
        _CausticsSpeed ("Caustics Speed", float) = 20
        _CausticsGrow ("Caustics Grow", float) = 20
        _CausticsOffset ("Caustics Offset", Range(0,.1)) = .05
        _CausticsIntensity ("Caustics Intensity", Range(0,2)) = .5

        _ShoreRange ("Shore Range", Range(0.001,1)) = .5
        _LinearShoreRange ("Linear Shore Range", float) = 30
        _LinearShoreGradient ("Linear Shore Gradient", float) = 80
        _ShoreTransparency ("Shore Transparency", Range(0.001,1)) = .5
        _FracIntensity ("Frac Intensity", float) = .5
        _FracTransparency ("Frac Transparency", Range(0,1)) = .5

        _Displace ("Displace", 2D) = "black" { }
        _Normal ("Normal", 2D) = "black" { }
        _Bubbles ("Bubbles", 2D) = "black" { }
    }
    SubShader
    {
        Tags { "RenderType" = "Opaque" "LightMode" = "ForwardBase" }
        LOD 100
        GrabPass{"_ScreenTex"}
        
        Pass
        {
            CGPROGRAM
            
            #pragma vertex vert
            #pragma fragment frag
            
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #include "AutoLight.cginc"
            
            struct appdata
            {
                float4 vertex: POSITION;
                float2 uv: TEXCOORD0;
            };
            
            struct v2f
            {
                float4 pos: SV_POSITION;
                float2 uv: TEXCOORD0;
                float3 worldPos: TEXCOORD1;
                float4 screenPos: TEXCOORD2;
                float4 screenUV : TEXCOORD3;
                float4 projPos : TEXCOORD4;
            };
            
            fixed4 _OceanColorShallow;
            fixed4 _OceanColorDeep;
            fixed4 _OceanColorFre;
            fixed4 _OceanColorSSS;
            fixed4 _BubblesColor;
            fixed4 _FoamColor;
            fixed4 _Specular;
            float _Gloss;
            float _SSSPow;
            float _SSSIntensity;
            float _SSSHeight;
            float _EmissionStrength;
            fixed _FresnelScale;
            sampler2D _Displace;
            sampler2D _Normal;
            sampler2D _Bubbles;
            float4 _Displace_ST;

            sampler2D _CameraDepthTexture;
            sampler2D _ScreenTex;
            
            sampler2D _Caustics;
            float4 _Caustics_ST;
            float _CausticsSpeed;
            float _CausticsGrow;
            float _CausticsOffset;
            float _CausticsIntensity;
            
            float _ShoreRange;
            float _LinearShoreRange;
            float _LinearShoreGradient;
            float _ShoreTransparency;
            float _FracIntensity;
            float _FracTransparency;
            
            inline half3 SamplerReflectProbe(UNITY_ARGS_TEXCUBE(tex), half3 refDir, half roughness, half4 hdr)
            {
                roughness = roughness * (1.7 - 0.7 * roughness);
                half mip = roughness * 6;
                //对反射探头进行采样
                //UNITY_SAMPLE_TEXCUBE_LOD定义在HLSLSupport.cginc，用来区别平台
                half4 rgbm = UNITY_SAMPLE_TEXCUBE_LOD(tex, refDir, mip);
                //采样后的结果包含HDR,所以我们需要将结果转换到RGB
                //定义在UnityCG.cginc
                return DecodeHDR(rgbm, hdr);
            }
            
            
            v2f vert(appdata v)
            {
                v2f o;
                o.uv = TRANSFORM_TEX(v.uv, _Displace);
                float4 displcae = tex2Dlod(_Displace, float4(o.uv, 0, 0));
                v.vertex += float4(displcae.xyz, 0);
                o.pos = UnityObjectToClipPos(v.vertex);
                o.screenPos = ComputeScreenPos(o.pos);
                o.screenUV = ComputeGrabScreenPos(o.pos);
                o.projPos = o.screenPos;
		        COMPUTE_EYEDEPTH(o.projPos.z);
		        //o.screenPos = o.pos;
                
                o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
                return o;
            }

            float4 CalculateSSSColor(float3 lightDirection, float3 worldNormal, float3 viewDir,float waveHeight, float shadowFactor)
            {
                    float lightStrength = sqrt(saturate(lightDirection.y));
                    float SSSFactor = pow(saturate(dot(viewDir ,lightDirection) )+saturate(dot(worldNormal ,-lightDirection)) ,_SSSPow) * shadowFactor * lightStrength * _EmissionStrength;
                    return _OceanColorSSS * (SSSFactor + waveHeight * .1);
            }

            float3 GetCaustics(float2 uv,fixed factor,fixed offset)
            {
                //焦散
                fixed2 causticsUv = uv * _Caustics_ST.xy + _Caustics_ST.zw;
                causticsUv += _CausticsSpeed * _Time.y * factor;
                // RGB split
                fixed s = 1.5 * offset;
                fixed r = tex2D(_Caustics, causticsUv + fixed2(+s, +s)).r * _CausticsIntensity;
                fixed g = tex2D(_Caustics, causticsUv + fixed2(+s, -s)).g * _CausticsIntensity;
                fixed b = tex2D(_Caustics, causticsUv + fixed2(-s, -s)).b * _CausticsIntensity;
                return fixed3(r, g, b);
            }
            
            fixed4 frag(v2f i): SV_Target
            {
                fixed3 normal = UnityObjectToWorldNormal(tex2D(_Normal, i.uv).rgb);
                fixed bubbles = tex2D(_Bubbles, i.uv).r > 0.4 ? 1 : 0.1;
                
                fixed3 lightDir = normalize(UnityWorldSpaceLightDir(i.worldPos));
                fixed3 viewDir = normalize(UnityWorldSpaceViewDir(i.worldPos));
                fixed3 reflectDir = reflect(-viewDir, normal);               
                reflectDir *= sign(reflectDir.y);

                //屏幕深度
                float sceneZ = max(0, 
                    LinearEyeDepth(UNITY_SAMPLE_DEPTH(tex2Dproj(_CameraDepthTexture, UNITY_PROJ_COORD(i.projPos)))) - _ProjectionParams.g);
                float partZ = max(0, i.projPos.z - _ProjectionParams.g);
                //深度差
                float depthGap = sceneZ - partZ;
                float shore = smoothstep(0.1,0.5,saturate(1 - depthGap * _ShoreRange)) > 0.25 ? 1 : 0 * _ShoreTransparency;
                float linearShore = smoothstep(0.1,0.65,saturate((1-depthGap + _LinearShoreRange)/_LinearShoreGradient));

                
                //采样反射探头
                half4 rgbm = UNITY_SAMPLE_TEXCUBE_LOD(unity_SpecCube0, reflectDir, 0);
                half3 sky = DecodeHDR(rgbm, unity_SpecCube0_HDR);
                
                //菲涅尔
                fixed fresnel = saturate(_FresnelScale + (1 - _FresnelScale) * pow(1 - dot(normal, viewDir), 4));
                fresnel = fresnel < 0.5 ? 0.05 : 0.4;
                
                half facing = saturate(dot(viewDir, normal));
                facing = facing < 0.5 ? 0 : 1;
                fixed3 oceanColor = lerp(_OceanColorShallow, _OceanColorDeep, facing);
                
                fixed3 ambient = UNITY_LIGHTMODEL_AMBIENT.rgb;


                //焦散
                fixed3 caustics = min(GetCaustics(i.uv,1,1),GetCaustics(i.uv,_CausticsGrow,_CausticsOffset));
                caustics *= linearShore;
 
                
                //泡沫颜色
                fixed3 bubblesDiffuse = _BubblesColor.rbg * _LightColor0.rgb;
                // fixed bubblesControl = saturate(dot(lightDir, normal)) > 0 ? 1 : 0;
                // bubblesDiffuse *= bubblesControl;

                
                //海洋颜色
                fixed3 oceanDiffuse = oceanColor * _LightColor0.rgb ;
                fixed diffuseControl = saturate(dot(lightDir, normal));
                oceanDiffuse *= diffuseControl < 0.7 ? 0.7 : 0.8;
                
                fixed3 halfDir = normalize(lightDir + viewDir);
                fixed3 specular = _LightColor0.rgb * _Specular.rgb;
                fixed specularControl = pow(max(0, dot(normal, halfDir)), _Gloss) < 0.2 ? 0.1 : 0.5;
                specular *= specularControl;
                specular *= sky * .3;
                fixed3 diffuse = lerp(oceanDiffuse, bubblesDiffuse, bubbles);

                //折射
                fixed4 fra = tex2D(_ScreenTex, (i.screenUV.xy + _FracIntensity * (saturate(1 - depthGap) + 0.5) * sin(2 * _Time.y))/(i.screenUV.w ));
                fra.a = linearShore * _FracTransparency;

                //近岸泡沫
                fixed foam = shore;
                fixed4 foamCol = foam * _FoamColor;
                foamCol.a *= _ShoreTransparency;

                fixed4 sss = CalculateSSSColor(lightDir,normal,viewDir,i.worldPos.y + _SSSHeight,_SSSIntensity);
                fixed3 col = ambient + lerp(diffuse, _OceanColorFre, fresnel) + specular ;
                col +=  _CausticsIntensity * caustics;
                col = (1-sss.a)*col+sss.a*sss;
                col = col * (1-fra.a) + fra * fra.a;
    
                
                
                col = col * (1-foamCol.a) + foamCol * foamCol.a;
                
                return fixed4(col,1);
            }
            ENDCG
            
        }
    }
}
