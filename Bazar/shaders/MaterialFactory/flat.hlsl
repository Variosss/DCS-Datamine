Texture2D TextureMap;

bool textured;

struct vsFlatInput{
	float3 vPosition:		POSITION0;
	float2 vTexCoord0:		TEXCOORD0;
};

struct vsFlatOutput{
	float4 vPosition:	SV_POSITION;
	float2 vTexCoord0:	TEXCOORD0;
};

vsFlatOutput vsFlat(in const vsFlatInput i){
	vsFlatOutput o;
	o.vPosition  = mul(float4(i.vPosition.xyz, 1.0), matWorldViewProj);
	o.vTexCoord0 = i.vTexCoord0;
	return o;
}

float4 psFlat(in const vsFlatOutput i) : SV_TARGET0
{
	float4 color = textured ? TextureMap.SampleLevel(WrapLinearSampler, i.vTexCoord0.xy, 0) : float4(1.0f, 1.0f, 1.0f, 1.0f);
	return float4(color.rgb * uMatDiffuse.rgb, color.a * uOpacity);
}

technique10 opaque{
	pass P0{
		SetVertexShader(CompileShader(vs_4_0, vsFlat()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psFlat()));

		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);              
	}
}
technique10 opaque_z{
	pass P0{
		SetVertexShader(CompileShader(vs_4_0, vsFlat()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psFlat()));

		SetDepthStencilState(enableDepthBuffer, 0);
		SetBlendState(disableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);              
	}
}
technique10 transparent{
	pass P0{
		SetVertexShader(CompileShader(vs_4_0, vsFlat()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psFlat()));

		SetDepthStencilState(disableDepthBuffer, 0);
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);              
	}
}
technique10 transparent_z{
	pass P0{
		SetVertexShader(CompileShader(vs_4_0, vsFlat()));
		SetGeometryShader(NULL);
		SetPixelShader(CompileShader(ps_4_0, psFlat()));

		SetDepthStencilState(enableDepthBuffer, 0);
		SetBlendState(enableAlphaBlend, float4(0.0f, 0.0f, 0.0f, 0.0f), 0xFFFFFFFF);
		SetRasterizerState(cullNone);              
	}
}
