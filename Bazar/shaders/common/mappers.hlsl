#ifndef MAPPERS_H
#define MAPPERS_H

float2 spheric_mapping(float3 ref)
{
	float den = 2 * sqrt(ref.x * ref.x + ref.y * ref.y + (ref.z + 1.0) * (ref.z + 1.0));
	return (ref.xy / den) + 0.5;
}

#endif
