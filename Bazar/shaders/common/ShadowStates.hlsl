RasterizerState shadowmapRasterizerState
{
	CullMode = Front;
	FillMode = SOLID;
	MultisampleEnable = FALSE;
	DepthBias = 0;
	SlopeScaledDepthBias = -1.0;
	DepthClipEnable = FALSE;

};

DepthStencilState shadowmapDepthState
{
	DepthEnable = TRUE;
	DepthWriteMask = ALL;
	DepthFunc = GREATER;
	StencilEnable = FALSE;
};
