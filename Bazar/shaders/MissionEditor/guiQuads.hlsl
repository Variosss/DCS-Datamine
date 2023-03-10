
uint getTextureIndex(uint quadIndex)
{
	uint i0 = quadIndex / 8;
	uint i1 = (quadIndex % 8) / 2;
	uint i2 = (quadIndex % 8) % 2; //first / second uint16

	uint twoUint16 = texIndices[i0][i1];

	return i2==0 ? twoUint16 & 0xffff : twoUint16 >> 16;
}

VS_OUT getQuadVertex(VS_INPUT IN)
{
	VS_OUT o = (VS_OUT)0;

	float quadIndex		= IN.Position.z;
	float4 quadBounds	= bounds[quadIndex];

	IN.Position.xy = quadBounds.xy + IN.Position.xy * quadBounds.zw + position.xy;
	IN.Position.z = 0;
	
	if(textureArrayPresented > 0)
	{
		o.TexCoord.z = getTextureIndex(quadIndex);
	}

	if(texturePresented > 0 || textureArrayPresented > 0)
	{
		float4 quadTexCoors = texCoords[quadIndex];
		o.TexCoord.xy = IN.TexCoord.xy > 0 ? quadTexCoors.zw : quadTexCoors.xy;
	}
	
	int colorIndex = ceil(fmod(quadIndex, colorCount));
	
	o.Color = colors[colorIndex];	
	o.Position = mul(float4(IN.Position.x, IN.Position.y, 0, 1), WVP);
	return o;
}
