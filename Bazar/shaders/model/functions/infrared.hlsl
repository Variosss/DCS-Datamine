#ifndef MODEL_INFRARED_SHADING_HLSL
#define MODEL_INFRARED_SHADING_HLSL

#include "common/constants.hlsl"

#ifdef INFRARED_SHADERS //IR

#ifdef BANO_MATERIAL

	PS_OUTPUT diffuse_sun_ps_ir(VS_OUTPUT input)
	{
		clipModelBySeaLevel(input.Pos.xyz / input.Pos.w);
		MaterialParams matParams = calcMaterialParams(input, MP_DIFFUSE | MP_NORMAL);

		PS_OUTPUT o;
		float a = 0;
		calcBANOAttenuation(matParams.diffuse.a, matParams.normal, matParams.toCamera, matParams.camDistance, a);
		o.RGBColor = float4(dot(matParams.diffuse.rgb, IR_MULT).xxx, a);
		return o;
	}

#else

	#include "common/lightingFLIR.hlsl"

	#if defined(FLIR_MAP) && defined(DIFFUSE_UV)
		#define TRUE_FLIR

		Texture2D FLIRMap;

		float4 calcFLIR(VS_OUTPUT input, uniform uint LightsList = LL_SOLID) {
			float4 flir = FLIRMap.Sample(gAnisotropicWrapSampler, input.DIFFUSE_UV.xy + diffuseShift);
			float v = flir[0] * flirCoeff[0] + flir[1] * flirCoeff[1] + flir[2] * flirCoeff[2] + flir[3] * flirCoeff[3];

			MaterialParams mp = calcMaterialParams(input, MP_DIFFUSE);
			float4 c = float4(v, v, v, mp.diffuse.a);
			c.xyz += CalculateDynamicLightingFLIR(input.Position.xy, input.Pos.xyz / input.Pos.w, LightsList).xxx;
			return c;
		}

		PS_OUTPUT diffuse_sun_ps_ir(VS_OUTPUT input) {
			PS_OUTPUT o;
			o.RGBColor = calcFLIR(input, LL_SOLID);
			return o;
		}

	#else		// fake flir

		#include "functions/aorms.hlsl"
		PS_OUTPUT diffuse_sun_ps_ir(VS_OUTPUT input) {
			PS_OUTPUT o;

			MaterialParams mp = calcMaterialParams(input, MP_DIFFUSE | MP_SPECULAR);

			o.RGBColor = float4(mp.aorms.y, mp.aorms.y, 0, mp.diffuse.a);
			o.RGBColor.xyz += CalculateDynamicLightingFLIR(input.Position.xy, input.Pos.xyz / input.Pos.w).xxx;
			return o;
		}

	#endif

#endif


#endif

#endif
