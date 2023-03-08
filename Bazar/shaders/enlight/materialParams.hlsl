#ifndef MATERIALPARAMS
#define MATERIALPARAMS

Texture2DArray cascadeShadowMap: register(t122);
Texture2D      terrainShadowMap: register(t106);
Texture2D      terrainESM: register(t105);

Texture2D skyTex: register(t124); 			//prerendered sky
Texture2D skyTex2: register(t107);			//256x256 prerendered sky with fog on the ground

Texture2D cloudsShadowTex: register(t120);
Texture3D cloudsShadowTex3D: register(t91);
Texture3D cloudsDensityMap: register(t89);

Texture2DArray	secondaryShadowMap: register(t121);

#endif

