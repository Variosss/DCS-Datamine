#ifndef ATMOSPHERE_SAMPLES_H
#define ATMOSPHERE_SAMPLES_H

struct AtmosphereSample
{
	float3 sunColor;
	float3 transmittance;	// color multiplier
	float3 inscatter;		// color additive
};

StructuredBuffer<AtmosphereSample> sbAtmosphereSamples: register(t119);

#ifndef EXTERN_ATMOSPHERE_INSCATTER_ID
int2 atmosphereSamplesId;//startId, count
#endif

AtmosphereSample SamplePrecomputedAtmosphere(int localSampleId)
{
	return sbAtmosphereSamples[atmosphereSamplesId.x + localSampleId];
}


#endif
