Texture2D tex;

float2 texOffset(float2 tc, float4 tcPos)
{
   return tcPos.xy + tc*tcPos.zw*(1-4/1024.0) + 2/1024.0;
}

float2 texMoveOffset(float2 tc, float2 speed, float time)
{
   return abs(fmod(tc + time*speed + 2/1024, float2(1.f,1.f)*(1-4/1024.0) ));
}

float2 texMoveOffset(float2 tc, float2 startSpeed, float timeStop, float time)
{
   time = min(time, timeStop);
   float2 acc = -startSpeed/timeStop;
   return abs(fmod(tc + time*startSpeed + acc*time*time*0.5f + 2/1024, float2(1.f,1.f)*(1-4/1024.0) ));
}

float4 tex2dFromAtlas(float2 tc, float4 tcPos)
{
//TODO учитывать смещения в mipmap
#ifdef DIRECTX11
	return tex.SampleLevel(WrapLinearSampler, texOffset(tc, tcPos), 0);
#else
	return float4(1,0,0,0.5);
#endif
}