#ifndef MODEL_COLOR_TABLE_HLSL
#define MODEL_COLOR_TABLE_HLSL

/*
#Source is https://lospec.com/palette-list/sheltzy32
colors = [
	0x8cffde, 0x45b8b3, 0x839740, 0xc9ec85,
	0x46c657, 0x158968, 0x2c5b6d, 0x222a5c,
	0x566a89, 0x8babbf, 0xcce2e1, 0xffdba5,
	0xccac68, 0xa36d3e, 0x683c34, 0x000000,
	0x38002c, 0x663b93, 0x8b72de, 0x9cd8fc,
	0x5e96dd, 0x3953c0, 0x800c53, 0xc34b91,
	0xff94b3, 0xbd1f3f, 0xec614a, 0xffa468,
	0xfff6ae, 0xffda70, 0xf4b03c, 0xffffff,
]
print('static const int N_COLORS = %d;' % len(colors))
print('static const float3 color_table[N_COLORS] = {')
for c in colors:
	r = ((c & 0xff0000) >> 8 * 2) / 255.0
	g = ((c & 0x00ff00) >> 8 * 1) / 255.0
	b = ((c & 0x0000ff) >> 8 * 0) / 255.0

	print('\tfloat3(%.3g, %.3g, %.3g),' % (r, g, b))
print('};')
*/

static const int N_COLORS = 32;
static const float3 color_table[N_COLORS] = {
        float3(0.549, 1, 0.871),
        float3(0.271, 0.722, 0.702),
        float3(0.514, 0.592, 0.251),
        float3(0.788, 0.925, 0.522),
        float3(0.275, 0.776, 0.341),
        float3(0.0824, 0.537, 0.408),
        float3(0.173, 0.357, 0.427),
        float3(0.133, 0.165, 0.361),
        float3(0.337, 0.416, 0.537),
        float3(0.545, 0.671, 0.749),
        float3(0.8, 0.886, 0.882),
        float3(1, 0.859, 0.647),
        float3(0.8, 0.675, 0.408),
        float3(0.639, 0.427, 0.243),
        float3(0.408, 0.235, 0.204),
        float3(0, 0, 0),
        float3(0.22, 0, 0.173),
        float3(0.4, 0.231, 0.576),
        float3(0.545, 0.447, 0.871),
        float3(0.612, 0.847, 0.988),
        float3(0.369, 0.588, 0.867),
        float3(0.224, 0.325, 0.753),
        float3(0.502, 0.0471, 0.325),
        float3(0.765, 0.294, 0.569),
        float3(1, 0.58, 0.702),
        float3(0.741, 0.122, 0.247),
        float3(0.925, 0.38, 0.29),
        float3(1, 0.643, 0.408),
        float3(1, 0.965, 0.682),
        float3(1, 0.855, 0.439),
        float3(0.957, 0.69, 0.235),
        float3(1, 1, 1),
};

#endif
