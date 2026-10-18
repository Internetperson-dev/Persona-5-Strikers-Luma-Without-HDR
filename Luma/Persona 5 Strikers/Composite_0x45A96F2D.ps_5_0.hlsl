// Katana engine PostEffect3 composite - UPSCALE ONLY version
// Preserves vanilla game rendering (exposure, chromatic aberration, vignette, lens flare, LUT)
// Outputs LINEAR colors — display composition handles gamma correction
// Removes all Luma HDR additions (DICE tonemapping, colour grading intensity, saturation)
// clang-format off
#include "Includes/Common.hlsl"
#include "../Includes/DICE.hlsl"
#include "../Includes/ColorGradingLUT.hlsl"
#include "Includes/cbComposite.hlsl"
// clang-format on

SamplerState sampleLinear_s : register(s7);
Texture2D<float4> g_tSceneMap : register(t0);
Texture2D<float4> g_tLensFlareMap : register(t1);
Texture2D<float4> g_tExposureScaleInfo : register(t2);
Texture3D<float4> g_tHdrLut : register(t3);
Texture3D<float4> g_tLdrLut : register(t4);

// 3Dmigoto declarations
#define cmp -

static const float LUTSize = 32.0;

// The vanilla log shaper
float3 EncodeLUTInput(float3 color)
{
    return saturate(log2(color * 5.55555582 + 0.0479959995) * 0.0734997839 + 0.386036009);
}
float3 DecodeLUTInput(float3 encodedColor)
{
    return (exp2((encodedColor - 0.386036009) / 0.0734997839) - 0.0479959995) / 5.55555582;
}

void main(
    float4 v0 : SV_Position0,
    float2 v1 : TEXCOORD0,
    out float4 o0 : SV_Target0)
{
    const float4 icb[] = {{0, 0, 1.000000, 0},
                         {0, 1.000000, 0, 0},
                         {1.000000, 0, 0, 0},
                         {1.000000, 0, 0, 0},
                         {0, 1.000000, 0, 0},
                         {0, 0, 1.000000, 0},
                         {0, 1.000000, 0, 0},
                         {1.000000, 0, 0, 0},
                         {1.000000, 0, 1.000000, 0},
                         {1.000000, 0, 1.000000, 0},
                         {1.000000, 0, 0, 0},
                         {0, 1.000000, 0, 0}};
    float4 r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11;

    r0.x = cmp(0 < g_vSun2dInfo.z);
    r0.y = cmp(0 < g_vLimbDarkenningInfo.w);
    r0.z = cmp(g_vCompositeInfo.z < 0);
    r0.w = g_tExposureScaleInfo.Load(int3(0, 0, 0)).x;
    r1.xy = cmp(float2(0, 0) < g_vCompositeInfo.zy);
    r1.x = r1.x ? g_vCompositeInfo.z : 1;
    r0.z = r0.z ? r0.w : r1.x;
    // UPSCALE ONLY: no Luma exposure multiplier — use vanilla exposure
    r1.xz = v1.xy * g_vCompositeLastViewport.zw + g_vCompositeLastViewport.xy;
    const float sceneUVScale = LumaData.CustomData4 > 0.0 ? LumaData.CustomData4 : 1.0;
    r2.xyz = g_tSceneMap.SampleLevel(sampleLinear_s, r1.xz * sceneUVScale, 0).xyz;
    r2.xyz = clamp(r2.xyz, 0.0, FLT11_MAX);
    r0.w = cmp(0 < g_vEtcEffect.x);
    if (r0.w != 0)
    {
       r0.w = (uint)g_vEtcEffect.y;
       r3.xy = r1.xz * float2(2, 2) + float2(-1, -1);
       r1.w = dot(r3.xy, r3.xy);
       r3.xy = r3.xy * r1.ww;
       r3.xy = g_vEtcEffect.xx * r3.xy;
       r3.zw = g_vSceneTexSize.xy * -r3.xy;
       r3.zw = float2(0.5, 0.5) * r3.zw;
       r1.w = dot(r3.zw, r3.zw);
       r1.w = sqrt(r1.w);
       r1.w = (int)r1.w;
       r1.w = max(3, (int)r1.w);
       r1.w = min(16, (int)r1.w);
       r2.w = (int)r1.w;
       r3.xy = -r3.xy / r2.ww;
       r4.xyz = icb[r0.w + 0].xyz * r2.xyz;
       r3.zw = (int2)r0.ww + int2(1, 2);
       r5.xyz = icb[r3.z + 0].xyz + -icb[r0.w + 0].xyz;
       r6.xyz = icb[r3.w + 0].xyz + -icb[r3.z + 0].xyz;
       r7.xyz = r4.xyz;
       r8.xyz = icb[r0.w + 0].xyz;
       r9.xy = r1.xz;
       r3.w = 1;
       while (true)
       {
          r4.w = cmp((int)r3.w >= (int)r1.w);
          if (r4.w != 0)
             break;
          r9.xy = r9.xy + r3.xy;
          r10.xyz = g_tSceneMap.SampleLevel(sampleLinear_s, r9.xy * sceneUVScale, 0).xyz;
          r10.xyz = clamp(r10.xyz, 0.0, FLT11_MAX);
          r4.w = (int)r3.w;
          r4.w = r4.w / r2.w;
          r5.w = cmp(r4.w < 0.5);
          if (r5.w != 0)
          {
             r5.w = r4.w + r4.w;
             r11.xyz = r5.www * r5.xyz + icb[r0.w + 0].xyz;
          }
          else
          {
             r4.w = r4.w * 2 + -1;
             r11.xyz = r4.www * r6.xyz + icb[r3.z + 0].xyz;
          }
          r7.xyz = r10.xyz * r11.xyz + r7.xyz;
          r8.xyz = r11.xyz + r8.xyz;
          r3.w = (int)r3.w + 1;
       }
       r2.xyz = r7.xyz / r8.xyz;
    }
    r2.xyz = r2.xyz * r0.zzz;
    if (r0.x != 0)
    {
       r3.xyz = g_tSceneMap.SampleLevel(sampleLinear_s, g_vSun2dInfo.xy * sceneUVScale, 0).xyz;
       r3.xyz = clamp(r3.xyz, 0.0, FLT11_MAX);
       r0.xzw = r3.xyz * r0.zzz;
       r3.xyz = g_tLensFlareMap.SampleLevel(sampleLinear_s, r1.xz, 0).xyz;
       r3.xyz = clamp(r3.xyz, 0.0, FLT11_MAX);
       r1.w = dot(r0.xzw, float3(0.222014993, 0.706655025, 0.0713300034));
       r1.w = cmp(g_vEtcEffect.w < r1.w);
       r1.w = r1.w ? g_vEtcEffect.z : 0;
       r0.xzw = r3.xyz * r0.xzw;
       // UPSCALE ONLY: no Luma flare intensity multiplier — use vanilla flare
       r2.xyz = r0.xzw * r1.www + r2.xyz;
    }
    if (r0.y != 0)
    {
       r0.yz = float2(-0.5, -0.5) + r1.xz;
       r0.x = g_vCompositeInfo.x * r0.y;
       r0.x = dot(r0.xz, r0.xz);
       r0.y = sqrt(r0.x);
       r0.y = -g_vLimbDarkenningInfo.y + r0.y;
       r0.z = cmp(0 < r0.y);
       r0.y = saturate(-r0.y * g_vLimbDarkenningInfo.z + 1);
       r0.y = r0.z ? r0.y : 1;
       r0.z = cmp(0 < r0.y);
       r0.x = g_vLimbDarkenningInfo.x + r0.x;
       r0.x = g_vLimbDarkenningInfo.x / r0.x;
       r0.x = r0.x * r0.x;
       r0.x = r0.z ? r0.x : 1;
       r0.x = r0.x * r0.y;
       // UPSCALE ONLY: no Luma vignette intensity multiplier — use vanilla vignette
       r2.xyz = r2.xyz * r0.xxx;
    }
    // UPSCALE ONLY: apply vanilla LUT directly — no colour grading intensity
    r0.xyz = g_tHdrLut.SampleLevel(sampleLinear_s, EncodeLUTInput(r2.xyz), 0).rgb;

    if (r1.y != 0)
    {
       r1.xyz = saturate(r0.xyz);
       r1.xyz = log2(r1.xyz);
       r1.xyz = float3(0.454545468, 0.454545468, 0.454545468) * r1.xyz;
       r1.xyz = exp2(r1.xyz);
       r1.xyz = g_tLdrLut.SampleLevel(sampleLinear_s, r1.xyz, 0).xyz;
       r1.xyz = r1.xyz + -r0.xyz;
       r0.xyz = g_vCompositeInfo.yyy * r1.xyz + r0.xyz;
    }
    // UPSCALE ONLY: output LINEAR colors — no gamma correction, no HDR tonemapping
    // The display composition handles gamma correction after UI blending

    o0.xyz = g_vRadialBlurCenter.zzz * r0.xyz;
    o0.w = 1;

    return;
}
