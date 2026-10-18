// Display composition - UPSCALE ONLY version
// Passthrough with gamma correction at the end (after UI blending)
// No HDR processing, no gamut mapping, no colour grading
// clang-format off
#include "../Includes/Common.hlsl"
// clang-format on

Texture2D<float4> sourceTexture : register(t0);
Texture2D<float4> uiTexture : register(t1);
SamplerState linearSampler : register(s0);

float4 main(float4 pos : SV_Position) : SV_Target0
{
    float sourceWidth;
    float sourceHeight;
    sourceTexture.GetDimensions(sourceWidth, sourceHeight);

    float2 uv = pos.xy / float2(sourceWidth, sourceHeight);

    float4 color = sourceTexture.Load((int3)pos.xyz);

    // UPSCALE ONLY: apply vanilla gamma correction at the end (after UI blending)
    // This matches the vanilla game's output encoding
    color.rgb = pow(abs(color.rgb), 1.0 / DefaultGamma) * sign(color.rgb);
    color.rgb = saturate(color.rgb);

    return color;
}
