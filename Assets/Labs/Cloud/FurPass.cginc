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
half4 _ViewColor;                      
                     
sampler2D _FurTex;
half4 _FurTex_ST;
sampler2D _ShapeTex;
sampler2D _CloudRampTex;
half _Cutoff;                            
half _FurLength;                         
half _FurDensity;                        
half _FurThinness;                       
half _FurShading;
half  _CloudHeight;
half _CloudHeightThinness;
half4 _ForceGlobal;                       
half4 _ForceLocal;                        
half _WindAmplitude;                     
half _WindFrequency;                     
half _WindDistribution;
half _CloudSelfSpeed;
half4 _CustomLightDir;

inline float4x4 GetRotateMatrix(float3 eularAngle)
{
    eularAngle.xyz*=0.01745;  //UNITY_PI/180     角度转弧度
    //X轴旋转
    float angleX=eularAngle.x;
    //Y轴旋转
    float angleY=eularAngle.y;
    //Z轴旋转
    float angleZ=eularAngle.z;

    float sinX=sin(angleX);
    float cosX=cos(angleX);
    float sinY=sin(angleY);
    float cosY=cos(angleY);
    float sinZ=sin(angleZ);
    float cosZ=cos(angleZ);

    float m00=cosY*cosZ;
    float m01=-cosY*sinZ;
    float m02=sinY;
    float m03=0;
    float m10=cosX*sinZ+sinX*sinY*cosZ;
    float m11=cosX*cosZ-sinX*sinY*sinZ;
    float m12=-sinX*cosY;
    float m13=0;
    float m20=sinX*sinZ-cosX*sinY*cosZ;
    float m21=sinX*cosZ+cosX*sinY*sinZ;
    float m22=cosX*cosY;
    float m23=0;
    float m30=0;
    float m31=0;
    float m32=0;
    float m33=1;

    float4x4 matrixRota=float4x4(m00,m01,m02,m03,m10,m11,m12,m13,m20,m21,m22,m23,m30,m31,m32,m33);
    return matrixRota;
}

v2f vert(appdata_base v)
{
    v2f o;

    v.vertex.x += ( sin(_WindDistribution + _Time.y * _WindFrequency) * _WindAmplitude) * v.texcoord.y*FURSTEP;
    v.vertex.y += ( cos( _WindDistribution + _Time.y * _WindFrequency) * _WindAmplitude) * v.texcoord.y*FURSTEP;

    float3 P = v.vertex.xyz + v.normal * _FurLength * FURSTEP;
    P += clamp(mul(unity_WorldToObject, _ForceGlobal).xyz + _ForceLocal.xyz, -1, 1) * pow(FURSTEP, 3) * _FurLength;
    o.pos = UnityObjectToClipPos(float4(P, 1.0));
    o.uv.xy = TRANSFORM_TEX(v.texcoord, _MainTex);
    o.uv.zw = TRANSFORM_TEX(v.texcoord, _FurTex);
    o.worldNormal = UnityObjectToWorldNormal(v.normal);
    o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
    TRANSFER_SHADOW(o)  

    return o;
}

fixed4 frag(v2f i): SV_Target
{
    fixed3 worldNormal = normalize(i.worldNormal);
    fixed3 worldLight = normalize(mul(GetRotateMatrix(_CustomLightDir.xyz),_WorldSpaceLightPos0.xyz));
    fixed3 worldView = normalize(_WorldSpaceCameraPos.xyz - i.worldPos.xyz);
    fixed3 worldHalf = normalize(worldView + worldLight);

    fixed shadow = saturate(lerp(SHADOW_ATTENUATION(i),1.0,(distance(i.worldPos.xyz,_WorldSpaceCameraPos.xyz)-100)*0.2));  

    fixed4 col = tex2D(_MainTex, i.uv.xy) * _Color;
    col -= (pow(1 - FURSTEP, 1.2)) * _FurShading;

    half rim = 1.0 - saturate(dot(worldView, worldNormal));
    fixed4 rimCol = fixed4(_RimColor.rgb * pow(rim, _RimPower), _RimColor.a);
    col = col*(1 - rimCol.a) + rimCol * rimCol.a;

    

    half dither = saturate(pow(frac((sin((i.worldPos.x+i.worldPos.y))*114+514)*810 + float2(_CloudSelfSpeed,0)*_Time.y),0.5))*0.5;
    fixed4 noise = tex2D(_FurTex, i.uv.zw ).rgba;
    dither = noise.r>0?1:dither;
    // dither *= noise.r;
    fixed shape = tex2D(_ShapeTex, i.uv.xy + frac(float2(_CloudSelfSpeed,0)*_Time.y) ).r * dither ;
    fixed alpha = clamp(noise.r*shape - (pow(FURSTEP,1)) * (_FurDensity+0.01*(sin(_Time.y*1.5*clamp(shape,1,2.2)))), 0, 1);
    // alpha *= i.pos.x*(col.r +col.g +col.b);
    half clipRate = pow(_Cutoff+pow(FURSTEP,3),(i.pos.z-_CloudHeight)*_CloudHeightThinness);
    clip(alpha- clipRate);
    
    fixed ambient = saturate((tex2D(_AOTex,i.uv.xy*5).r + tex2D(_AOTex,i.uv.xy*5).g + tex2D(_AOTex,i.uv.xy*5).b)*.357+0.7);
    fixed3 ambientTmp = dot(UNITY_LIGHTMODEL_AMBIENT.xyz,(1,1,1))<0.8?UNITY_LIGHTMODEL_AMBIENT.xyz+(1.5,1.5,1.5):UNITY_LIGHTMODEL_AMBIENT;                    
    fixed4 ambientCol = ambient * _AOColor;
    ambientCol.rgb = ambientCol.rgb*(1 - 0.23) + ambientTmp * 0.23;
    

    
    half NdotL = max(0,dot(i.worldNormal,worldLight));
    half smoothNdotL = saturate(pow(NdotL,2-(alpha- clipRate)*_FurShading));
    smoothNdotL = pow(smoothNdotL,_Shininess);
    // smoothNdotL = smoothNdotL < 0.6 ? pow(smoothNdotL,2.5) : pow(smoothNdotL,0.5) ;
    fixed4 shadeCol = fixed4(tex2D(_CloudRampTex, fixed2(smoothNdotL,0)).rgb,smoothNdotL );;
    // shadeCol.a *= smoothNdotL*_ShadowColor.a;
    
    half NdotV = smoothstep(0,1,max(0,dot(i.worldNormal,worldView))*1.25);
    half smoothNdotV = saturate(pow(NdotV,2-(alpha- clipRate)));
    fixed4 viewCol = _ViewColor * smoothNdotV;
    // col *= smoothNdotL;
    col = col*(1 - viewCol.a) + viewCol * viewCol.a;
    col = col*(1 - shadeCol.a) + shadeCol * shadeCol.a;
    


    
    return fixed4(col.rgb,saturate(pow(alpha*1.25, dither)*_Color.a));
}

