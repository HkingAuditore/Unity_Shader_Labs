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
sampler2D _MainTex;
half4 _MainTex_ST;
half4 _Color;
half _Shininess;
sampler2D _AOTex;
half4 _AO_ST;
half4 _AOColor;
half4 _RimColor;                         
half _RimPower;                          
half4 _ShadowColor;                      
                     
sampler2D _FurTex;
half4 _FurTex_ST;                       
sampler2D _FurHeightTex;
half4 _FurHeightTex_ST;
sampler2D _FurShadeTex;
half _FurHeightMin;
half _FurHeightMax;

half _Cutoff;                            
half _FurLength;                         
half _FurDensity;                        
half _FurThinness;                       
half _FurShading;
half _FurHeightAdjust;
half4 _ForceGlobal;                       
half4 _ForceLocal;                        
half _WindAmplitude;                     
half _WindFrequency;                     
half _WindDistribution;  


v2f vert(appdata_base v)
{
    v2f o;

    v.vertex.x += ( sin(_WindDistribution + _Time.y * _WindFrequency) * _WindAmplitude) * v.texcoord.y*FURSTEP;
    v.vertex.y += ( cos( _WindDistribution + _Time.y * _WindFrequency) * _WindAmplitude) * v.texcoord.y*FURSTEP;
    o.uv.xy = TRANSFORM_TEX(v.texcoord, _MainTex);
    o.uv.zw = TRANSFORM_TEX(v.texcoord, _FurTex);

    fixed4 height =  tex2Dlod(_FurHeightTex,v.texcoord);
    float heightAdjust = height.r+height.g+height.b;
    float3 P = v.vertex.xyz + v.normal * _FurLength * FURSTEP * clamp(pow(heightAdjust,_FurHeightAdjust),_FurHeightMin,_FurHeightMax);
    P += clamp(mul(unity_WorldToObject, _ForceGlobal).xyz + _ForceLocal.xyz, -1, 1) * pow(FURSTEP, 3) * _FurLength * clamp(pow(heightAdjust,_FurHeightAdjust),_FurHeightMin,_FurHeightMax);
    o.pos = UnityObjectToClipPos(float4(P, 1.0));
    o.worldNormal = UnityObjectToWorldNormal(v.normal);
    o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
    TRANSFER_SHADOW(o)  

    return o;
}

fixed4 frag(v2f i): SV_Target
{
    fixed3 worldNormal = normalize(i.worldNormal);
    fixed3 worldLight = normalize(_WorldSpaceLightPos0.xyz);
    fixed3 worldView = normalize(_WorldSpaceCameraPos.xyz - i.worldPos.xyz);
    fixed3 worldHalf = normalize(worldView + worldLight);

    fixed3 noise = tex2D(_FurTex, i.uv.zw * _FurThinness).rgb;
    fixed alpha = clamp(noise - (FURSTEP * FURSTEP) * _FurDensity, 0, 1);

    fixed shadow = saturate(lerp(SHADOW_ATTENUATION(i),1.0,(distance(i.worldPos.xyz,_WorldSpaceCameraPos.xyz)-100)*0.1));  
    // fixed shadow = SHADOW_ATTENUATION(i);  

    fixed4 col = tex2D(_MainTex, i.uv.xy) * _Color;
    col -= (pow(1 - FURSTEP, 1.2)) * _FurShading;

    half rim = 1.0 - saturate(dot(worldView, worldNormal));
    col += fixed4(_RimColor.rgb * pow(rim, _RimPower), 1.0);

    fixed ambient = saturate((tex2D(_AOTex,i.uv.xy*5).r + tex2D(_AOTex,i.uv.xy*5).g + tex2D(_AOTex,i.uv.xy*5).b)*.357);
    fixed3 ambientTmp = dot(UNITY_LIGHTMODEL_AMBIENT.xyz,(1,1,1))<0.8?UNITY_LIGHTMODEL_AMBIENT.xyz+(1.5,1.5,1.5):UNITY_LIGHTMODEL_AMBIENT;                    
    fixed4 ambientCol = fixed4((ambient * _AOColor * pow(1.5,FURSTEP+2)).rgb,ambient);
    ambientCol.rgb = ambientCol.rgb*(1 - 0.23) + ambientTmp * 0.23;
    col = col*(1 - ambientCol.a) + ambientCol * ambientCol.a;

    fixed diffuse = saturate(saturate(dot(worldNormal, worldLight)) * shadow);
    fixed4 shadeSampler = tex2D(_FurShadeTex,i.uv.xy*2);
    diffuse = min(diffuse,shadeSampler.r);
    fixed4 diffuseCol = fixed4((diffuse * _LightColor0).rgb + ((1-diffuse) * _ShadowColor * 0.5).rgb,diffuse*pow(1.5,FURSTEP+3));
    col *= diffuseCol;
    

    fixed specular = pow(saturate(dot(worldNormal, worldHalf)), _Shininess * 1.55);
    col *= lerp(0.86,1.4,specular-ambient*0.2);

    


    clip(alpha-_Cutoff);

    return fixed4(col.rgb,saturate(alpha*1.25));
}

