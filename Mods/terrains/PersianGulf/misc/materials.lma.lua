materials_export = 
{

--- RunwayOnlay 5.0
--- �������� �������� ���������
{
	name = "RunwayOnlay5.0";
	lsa3_material = "defmaterial";
	postexport = "Structured";

	shaderdefines = 
	{
		'BLEND_ALPHA',		-- overlayColor �������� ������� � ����� 0.5
	};

	paramsources = 
	{
		-- Diffuse textures
		{ type = "TEXNAME"; name = "fabricTexture";		submat = "color0";				defaultvalue = "fabric.default.tif";			 texturearray="!fabric";},
		{ type = "TEXNAME"; name = "decalTexture";		submat = "color1";				defaultvalue = "decal.default.tif";				 texturearray="!decal";},
		{ type = "TEXNAME"; name = "cracksMaskTexture";	submat = "color2";				defaultvalue = "cracksmask.default.tif";		 texturearray="!cracksMask";},
		{ type = "TEXNAME"; name = "dirtMaskTexture";	submat = "color3";				defaultvalue = "dirtmask.default.tif";			 texturearray="!dirtMask";},
		{ type = "TEXNAME"; name = "overlayTexture";	submat = "color4";				defaultvalue = "gray.png";						 behavior="unique";},
		-- Normal map textures
		{ type = "TEXNAME"; name = "fabricNormalTexture"; 	  submat = "bump0";			defaultvalue = "fabric.default.nm.tif";        	 texturearray="!fabric.nm";},
		{ type = "TEXNAME"; name = "cracksMaskNormalTexture"; submat = "bump1";			defaultvalue = "cracksMask.default.nm.tif";    	 texturearray="!cracksMask.nm";},
		-- Specular map texture
		{ type = "TEXNAME"; name = "specularTexture";  submat = "ID_SH"; 				defaultvalue = "fabric.default.spec.tif";						 texturearray="!fabric.spec";},
		{ type = "PROPERTY"; name = "colorIndex"; defaultvalue = "14";},
		{ type = "PROPERTY"; name = "shaderDefine"; defaultvalue = "NODEFINITIONS";},
	};
	streams = 
	{
		{ name = "P";			type = "FLOAT3";},			-- �������
		{ name = "N";			type = "FLOAT3";},			-- �������
		-- diffuse
		{ name = "fabricUV";    type = "FLOAT2"; invertV=true; assignedTotexture="color0";},		-- uv-���������� ��� fabricTexture 
		{ name = "fabricTextureIndex"; type = "INT1";},												-- index		
		{ name = "decalUV";  type = "FLOAT2"; invertV=true; assignedTotexture="color1";},			-- uv-���������� ��� decalTexture
		{ name = "decalTextureIndex"; type = "INT1";},												-- index		
		{ name = "cracksMaskUV";  type = "FLOAT2"; invertV=true; assignedTotexture="color2";},		-- uv-���������� ��� cracksMaskTexture
		{ name = "cracksMaskTextureIndex"; type = "INT1";},											-- index		 
		{ name = "dirtMaskUV";  type = "FLOAT2"; invertV=true; assignedTotexture="color3";},		-- uv-���������� ��� dirtMaskTexture
		{ name = "dirtMaskTextureIndex"; type = "INT1";},											-- index		 
		{ name = "overlayUV";  type = "FLOAT2"; invertV=true; assignedTotexture="color4";},			-- uv-���������� ��� overlayTexture
		-- normals
		{ name = "fabricNormalUV"; type = "FLOAT2"; invertV=true; assignedTotexture="bump0";},		-- uv-���������� ��� fabricNormalTexture
		{ name = "fabricNormalTextureIndex"; type = "INT1";},										-- index		 
		{ name = "cracksMaskNormalUV"; type = "FLOAT2"; invertV=true; assignedTotexture="bump1";},	-- uv-���������� ��� cracksMaskNormalTexture
		{ name = "cracksMaskNormalTextureIndex"; type = "INT1";},									-- index	
		{ name = "fabricNormalTangent";  type = "FLOAT3"; invertV=true; tangentFor="fabricNormalUV"; },			-- tangent ��� fabricNormalUV
		{ name = "fabricNormalBinormal"; type = "FLOAT3"; invertV=true; binormalFor="fabricNormalUV";},			-- binormal ��� fabricNormalUV	
		{ name = "cracksMaskNormalTangent";  type = "FLOAT3"; invertV=true; tangentFor="cracksMaskNormalUV"; },	-- tangent ��� cracksMaskNormalUV
		{ name = "cracksMaskNormalBinormal"; type = "FLOAT3"; invertV=true; binormalFor="cracksMaskNormalUV";},	-- binormal ��� cracksMaskNormalUV
		-- specular
		{ name = "specularUV"; type = "FLOAT2"; invertV=true; assignedTotexture="ID_SH";},	-- uv-���������� ��� specularTexture
		{ name = "specularTextureIndex"; type = "INT1";},									-- index	
		
	};
},

--- Surface 5.0
--- Материал для поверхности с автоматическим мапингом и назначением текстур
--- Без шумов
{
	name = "Surface5.0";
	preexport = "preexport5.0";
	postexport = "postexport5.0";
	sharedMaterial = "Surface5.0shared";

	streams = 
	{
	};
	paramsources = 
	{
		{ type = "PROPERTY"; name = "shaderDefine"; defaultvalue = "NODEFINITIONS";},
	},
},

--- Материал для экспорта общей геометрии Surface5.0
{
	name = "Surface5.0shared";
	preexport = "preexport5.0";
	postexport = "Structured;postexport5.0";
	exportPrimitives = false;

	streams = 
	{
		{ name = "Pbase"; type = "FLOAT3"; spaceType="worldspacepoint"; },
		{ name = "nextLodIndex"; type = "INT1"; },
		{ name = "Nbase"; type = "FLOAT3"; terrainDefinition="GENERATE_NORMALS";},
		{ name = "maxEdge"; type = "FLOAT1"; },
		{ name = "depth"; type = "FLOAT1"; },
	};
},

--- Материал для манифолдов меш ассетов (sharedBuffer)
{
	name = "MeshAssetManifold5";
	exportPrimitives = false;

	streams = 
	{
		{ name = "xyz2uvw"; type = "FLOAT16"; },
		{ name = "tangent"; type = "FLOAT4"; },
		{ name = "binormal"; type = "FLOAT4"; },
	};
},

--- SurfaceReflection 5.0
{
	name = "SurfaceReflection5.0";
	lsa3_material = "defmaterial";
	preexport = "preexport5.0";
	postexport = "postexport5.0";
	sharedMaterial = "Surface5.0shared";

	streams = 
	{
		-- Вершины
		{ name = "baseIndex"; type = "INT1";},	
		-- Расстояние до границы
		{ name = "closestReceiverPointHeight";   type = "FLOAT1"; },
	};
	paramsources = 
	{
	},
},

--- SurfaceVaryHouse5.0
{
	name = "SurfaceVaryHouse5.0";

	preexport = "preexport5.0";
	postexport = "postexport5.0";
	sharedMaterial = "Surface5.0shared";

	shaderdefines = 
	{
		'DOUBLESIDED',
		'USE_COLOR_PALETTE',
	};

	paramsources = 
	{
		{ type = "TEXNAME"; name = "surfaceColorTexture";	submat = "color0";				defaultvalue = "white.png";	requiredUvset="UV0"; behavior="unique";},
		{ type = "TEXNAME"; name = "fabricTextureArray";	submat = "color1";				defaultvalue = "fabric.default"; requiredUvset="UV1"; hideExtension=true; texturearray="!fabric";},
		{ type = "TEXNAME"; name = "decalTextureArray";		submat = "color2";				defaultvalue = "decal.default"; hideExtension=true; texturearray="!decal";},
		{ type = "TEXNAME"; name = "occlusionTexture";		submat = "color3";				defaultvalue = "defaultVaryhouseAO.png"; behavior="unique";},
		{ type = "TEXNAME"; name = "selfillumTexture";		submat = "selfillumTexture";	defaultvalue = "black.png";	behavior="unique";},
		{ type = "TEXNAME"; name = "normalmapTexture";		submat = "bump0";				defaultvalue = "normalZ.png"; behavior="unique";},

		{ type = "PROPERTY"; name = "shaderDefine"; defaultvalue = "NODEFINITIONS";},
		
		{ type = "PROPERTY"; name = "visibleShelfPass"; defaultvalue = "1";},
		{ type = "PROPERTY"; name = "visibleFinalPass"; defaultvalue = "1";},
		{ type = "PROPERTY"; name = "castSurfaceDetails"; defaultvalue = "0";},
		{ type = "PROPERTY"; name = "castShadows"; defaultvalue = "1";},

		-- чтоб в атласе работало
		{ type = "PROPERTY"; name = "paletteTexture";   submat = "color0"; defaultvalue = "white.png"; preexport="paletteTexture";},
	};

	streams = 
	{
		-- для NEXTLOD_BLEDING
		{ name = "baseIndex"; type = "INT1"; },
		{ name = "N"; type = "FLOAT3"; preexport="normals"; },

		{ name = "fabricTextureArrayIndex"; type = "INT1";},	-- fabricTexture index
		{ name = "fabricTexCoord";  type = "INT1"; assignedTotexture="color1"; spaceType="worldspacepoint"; manifold=true;},
		{ name = "decalTextureArrayIndex"; type = "INT1";},	-- decalTexture index
		{ name = "decalTexCoord";  type = "INT1"; assignedTotexture="color2"; spaceType="worldspacepoint"; manifold=true;},
		{ name = "surfaceColorTexCoord";  type = "INT1"; assignedTotexture="color0"; spaceType="worldspacepoint"; manifold=true;},
		{ name = "occlusionTexCoord";  type = "INT1"; assignedTotexture="color3"; spaceType="worldspacepoint"; manifold=true;},
		{ name = "selfillumTexCoord";  type = "INT1"; assignedTotexture="selfillumTexture"; spaceType="worldspacepoint"; manifold=true;},
		{ name = "normalmapTexCoord";  type = "INT1"; assignedTotexture="bump0"; spaceType="worldspacepoint"; manifold=true;},

		{ name = "paletteV";	type = "INT1";			preexport="paletteV"; terrainDefinition="USE_TERRAIN_PALETTE";},	
	};
},


-- Blend5.1 
{
	name = "Blend5.1";
	lsa3_material = "defmaterial";
	preexport = "OffsetMapChannelIfNo;preexport5.0;parametricUVW";
	requireServices = "references;surfacedetails";
	postexport = "postexport5.0";
	sharedMaterial = "Surface5.0shared";

	shaderdefines = 
	{
		'SOLIDBORDER',
		'USE_NORMALMAP',
		'USE_OVERLAY', 
		'USE_UVW_MANIFOLD',
		'USE_MR_CLOSEUP',
	};

	streams =
	{
		-- для NEXTLOD_BLEDING
		{ name = "baseIndex"; type = "INT1"; },

		-- UVW
		{ name = "parametricUVW"; type = "FLOAT3"; ifShaderDefine = "!USE_UVW_MANIFOLD"},
		{ name = "parametricTangent";   type = "FLOAT3"; ifShaderDefine = "!USE_UVW_MANIFOLD"},
		{ name = "parametricBinormal";   type = "FLOAT3"; ifShaderDefine = "!USE_UVW_MANIFOLD"},
		{ name = "parametricUVW";   type = "INT1"; sharedBufferType = "MeshAssetManifold5"; ifShaderDefine = "USE_UVW_MANIFOLD"; },

		{ name = "offset";		   type = "FLOAT1"; required=true;},

		{ name = "blend";		type = "INT1"; assignedTotexture="color4"; setMaterialManifold=0; },

		{ name = "closeupR";	type = "INT1"; assignedTotexture="color3"; setMaterialManifold=1; },
		{ name = "closeupG";	type = "INT1"; assignedTotexture="color2"; setMaterialManifold=2; },
		{ name = "closeupB";	type = "INT1"; assignedTotexture="color1"; setMaterialManifold=3; },
		{ name = "closeup0";	type = "INT1"; assignedTotexture="color0"; setMaterialManifold=4; },

		{ name = "overlay";	type = "INT1"; ifShaderDefine = "USE_OVERLAY"; assignedTotexture="color5"; setMaterialManifold=5; },

		-- индекс ассета
		{ name = "assetIndex"; type = "INT1"; interpolation = "per primitive"; defaultValue = -1; ifShaderDefine = "ASSET_INDEX"; },
	},
	paramsources = 
	{
		{ type = "TEXNAME"; name = "overlayTexture"; submat = "color5"; defaultvalue = "gray.png";		behavior="unique";},
		{ type = "TEXNAME"; name = "blendTexture";   submat = "color4";									behavior="unique";},
		{ type = "TEXNAME"; name = "normalmapTexture";  submat = "bump0"; defaultvalue = "normalZ.png"; behavior="unique";},

		{ type = "TEXNAME"; setMaterialTextureIndex = 4; name = "closeupR"; submat = "color3"; defaultvalue = "CloseupTextures.default.tif"; texturearray="!CloseupTextures";},
		{ type = "TEXNAME"; setMaterialTextureIndex = 5; name = "closeupG"; submat = "color2"; defaultvalue = "CloseupTextures.default.tif"; texturearray="!CloseupTextures";},
		{ type = "TEXNAME"; setMaterialTextureIndex = 6; name = "closeupB"; submat = "color1"; defaultvalue = "CloseupTextures.default.tif"; texturearray="!CloseupTextures";},
		{ type = "TEXNAME"; setMaterialTextureIndex = 7; name = "closeup0"; submat = "color0"; defaultvalue = "CloseupTextures.default.tif"; texturearray="!CloseupTextures";},

		{ type = "TEXNAME"; setMaterialTextureIndex = 8; name = "closeupMR_R"; ifShaderDefine="USE_MR_CLOSEUP"; submat = "color3"; changeExtension=".mr.tif"; defaultvalue = "CloseupTextures.default.mr.tif"; texturearray="!CloseupMetalnessRoughnessTextures"; },
		{ type = "TEXNAME"; setMaterialTextureIndex = 9; name = "closeupMR_G"; ifShaderDefine="USE_MR_CLOSEUP"; submat = "color2"; changeExtension=".mr.tif"; defaultvalue = "CloseupTextures.default.mr.tif"; texturearray="!CloseupMetalnessRoughnessTextures"; },
		{ type = "TEXNAME"; setMaterialTextureIndex = 10; name = "closeupMR_B"; ifShaderDefine="USE_MR_CLOSEUP"; submat = "color1"; changeExtension=".mr.tif"; defaultvalue = "CloseupTextures.default.mr.tif"; texturearray="!CloseupMetalnessRoughnessTextures"; },
		{ type = "TEXNAME"; setMaterialTextureIndex = 11; name = "closeupMR_0"; ifShaderDefine="USE_MR_CLOSEUP"; submat = "color0"; changeExtension=".mr.tif"; defaultvalue = "CloseupTextures.default.mr.tif"; texturearray="!CloseupMetalnessRoughnessTextures"; },

		{ type = "PROPERTY"; name = "colorIndex"; setMaterialInt = 0; defaultvalue = "4";},

		--- shaderDefine
		{ type = "PROPERTY"; name = "shaderDefine"; defaultvalue = "NODEFINITIONS";	}, -- SOLIDBORDER
	},
},

-- HardSplat материал для поверхности с closeup текстурами и управляющей для нее. Все через текстурные массивы
{
	name = "HardSplat5.1";
	lsa3_material = "defmaterial";
	preexport = "OffsetMapChannelIfNo;preexport5.0;parametricUVW";
	requireServices = "references;surfacedetails";
	postexport = "postexport5.0";
	sharedMaterial = "Surface5.0shared";

	shaderdefines = 
	{
		'USE_ROOF_TEXTURE',
		'USE_NORMALMAP', 
		'USE_OVERLAY',
		'CLOSEUP_NORMALS',
		'LAYER1_IS_WATER',
		'CLAMP_MAINTEXTURES',
		'SOLIDBORDER',
		'IGNORE_TRANSPARENCY', -- have more priority(overwrite) then SOLIDBORDER
		'USE_MR_CLOSEUP',
	};

	streams = 
	{
		-- для NEXTLOD_BLEDING
		{ name = "baseIndex"; type = "INT1"; },

		-- UVW
		{ name = "parametricUVW"; type = "FLOAT3"; ifShaderDefine = "!USE_UVW_MANIFOLD"},
		{ name = "parametricTangent";   type = "FLOAT3"; ifShaderDefine = "!USE_UVW_MANIFOLD"},
		{ name = "parametricBinormal";   type = "FLOAT3"; ifShaderDefine = "!USE_UVW_MANIFOLD"},
		{ name = "parametricUVW";   type = "INT1"; sharedBufferType = "MeshAssetManifold5"; ifShaderDefine = "USE_UVW_MANIFOLD"; },

		{ name = "offset"; type = "FLOAT1"; required=true;},

		{ name = "main";		type = "INT1"; assignedTotexture = "color5"; setMaterialManifold = 0; },
		{ name = "closeupR";	type = "INT1"; assignedTotexture = "color4"; setMaterialManifold = 1; },
		{ name = "closeupG";	type = "INT1"; assignedTotexture = "color3"; setMaterialManifold = 2; },
		{ name = "closeupB";	type = "INT1"; assignedTotexture = "color2"; setMaterialManifold = 3; },
		{ name = "closeupA";	type = "INT1"; assignedTotexture = "color1"; setMaterialManifold = 4; },
		{ name = "closeup0";	type = "INT1"; assignedTotexture = "color0"; setMaterialManifold = 5; },
		{ name = "overlay";		type = "INT1"; ifShaderDefine = "USE_OVERLAY"; assignedTotexture = "color6"; setMaterialManifold = 6; },

		-- индекс ассета
		{ name = "assetIndex"; type = "INT1"; interpolation = "per primitive"; defaultValue = -1; ifShaderDefine = "ASSET_INDEX"; },
	},
	paramsources = 
	{
		{ type = "TEXNAME"; name = "color";		submat = "color5"; defaultvalue = "white.png"; changeExtension=".color.tif"; },
		{ type = "TEXNAME"; name = "roof";		submat = "color5"; defaultvalue = "zero.png"; changeExtension=".roofs.tif"; ifShaderDefine = "USE_ROOF_TEXTURE";},
		{ type = "TEXNAME"; name = "splatmap";	submat = "color5"; defaultvalue = "white.png"; changeExtension=".tif"; },
		{ type = "TEXNAME"; name = "normal";	submat = "color5"; defaultvalue = "normalZ.png"; changeExtension=".nm.tif"; ifShaderDefine = "USE_NORMALMAP";},
		{ type = "TEXNAME"; name = "overlay"; submat = "color6"; defaultvalue = "gray.png"; ifShaderDefine = "USE_OVERLAY"; },

		{ type = "TEXNAME"; setMaterialTextureIndex = 0; name = "closeupR"; submat = "color4"; defaultvalue = "CloseupTextures.default.tif"; texturearray = "!CloseupTextures";},
		{ type = "TEXNAME"; setMaterialTextureIndex = 1; name = "closeupG"; submat = "color3"; defaultvalue = "CloseupTextures.default.tif"; texturearray = "!CloseupTextures";},
		{ type = "TEXNAME"; setMaterialTextureIndex = 2; name = "closeupB"; submat = "color2"; defaultvalue = "CloseupTextures.default.tif"; texturearray = "!CloseupTextures";},
		{ type = "TEXNAME"; setMaterialTextureIndex = 3; name = "closeupA"; submat = "color1"; defaultvalue = "CloseupTextures.default.tif"; texturearray = "!CloseupTextures";},
		{ type = "TEXNAME"; setMaterialTextureIndex = 4; name = "closeup0"; submat = "color0"; defaultvalue = "CloseupTextures.default.tif"; texturearray = "!CloseupTextures";},

		{ type = "TEXNAME"; setMaterialTextureIndex = 5; name = "closeupMR_R"; ifShaderDefine="USE_MR_CLOSEUP"; submat = "color3"; changeExtension=".mr.tif"; defaultvalue = "CloseupTextures.default.mr.tif"; texturearray="!CloseupMetalnessRoughnessTextures"; },
		{ type = "TEXNAME"; setMaterialTextureIndex = 6; name = "closeupMR_G"; ifShaderDefine="USE_MR_CLOSEUP"; submat = "color2"; changeExtension=".mr.tif"; defaultvalue = "CloseupTextures.default.mr.tif"; texturearray="!CloseupMetalnessRoughnessTextures"; },
		{ type = "TEXNAME"; setMaterialTextureIndex = 7; name = "closeupMR_B"; ifShaderDefine="USE_MR_CLOSEUP"; submat = "color1"; changeExtension=".mr.tif"; defaultvalue = "CloseupTextures.default.mr.tif"; texturearray="!CloseupMetalnessRoughnessTextures"; },
		{ type = "TEXNAME"; setMaterialTextureIndex = 8; name = "closeupMR_0"; ifShaderDefine="USE_MR_CLOSEUP"; submat = "color0"; changeExtension=".mr.tif"; defaultvalue = "CloseupTextures.default.mr.tif"; texturearray="!CloseupMetalnessRoughnessTextures"; },

		{ type = "PROPERTY"; name = "colorIndex"; setMaterialInt = 0; defaultvalue = "4";},

		--- shaderDefine
		{ type = "PROPERTY"; name = "shaderDefine"; defaultvalue = "NODEFINITIONS"; }, -- SOLIDBORDER
	},
},

-- HardSplat материал для поверхности с closeup текстурами и управляющей для нее. Все через текстурные массивы
{
	name = "HardSplatArray5.1";
	lsa3_material = "defmaterial";
	preexport = "OffsetMapChannelIfNo;preexport5.0;parametricUVW";
	requireServices = "references;surfacedetails";
	postexport = "postexport5.0";
	sharedMaterial = "Surface5.0shared";

	shaderdefines = 
	{
		'USE_ROOF_TEXTURE',
		'CLOSEUP_NORMALS',
		'USE_OVERLAY',
		'LAYER1_IS_WATER',
		'CLAMP_MAINTEXTURES',
		'SOLIDBORDER',
		'IGNORE_TRANSPARENCY', -- have more priority(overwrite) then SOLIDBORDER
		'USE_MR_CLOSEUP',
		'USE_SELFILLUM'
	};

	streams = 
	{
		-- для NEXTLOD_BLEDING
		{ name = "baseIndex"; type = "INT1"; },

		-- UVW
		{ name = "parametricUVW"; type = "FLOAT3"; ifShaderDefine = "!USE_UVW_MANIFOLD"},
		{ name = "parametricTangent";   type = "FLOAT3"; ifShaderDefine = "!USE_UVW_MANIFOLD"},
		{ name = "parametricBinormal";   type = "FLOAT3"; ifShaderDefine = "!USE_UVW_MANIFOLD"},
		{ name = "parametricUVW";   type = "INT1"; sharedBufferType = "MeshAssetManifold5"; ifShaderDefine = "USE_UVW_MANIFOLD"; },

		{ name = "offset"; type = "FLOAT1"; required=true;},

		{ name = "main";		type = "INT1"; assignedTotexture="color5"; setMaterialManifold=0; },
		{ name = "closeupR";	type = "INT1"; assignedTotexture="color4"; setMaterialManifold=1; },
		{ name = "closeupG";	type = "INT1"; assignedTotexture="color3"; setMaterialManifold=2; },
		{ name = "closeupB";	type = "INT1"; assignedTotexture="color2"; setMaterialManifold=3; },
		{ name = "closeupA";	type = "INT1"; assignedTotexture="color1"; setMaterialManifold=4; },
		{ name = "closeup0";	type = "INT1"; assignedTotexture="color0"; setMaterialManifold=5; },

		{ name = "overlay";		type = "INT1"; ifShaderDefine = "USE_OVERLAY"; assignedTotexture = "color6"; setMaterialManifold = 6; },

		-- индекс ассета
		{ name = "assetIndex"; type = "INT1"; interpolation = "per primitive"; defaultValue = -1; ifShaderDefine = "ASSET_INDEX"; },
	},
	paramsources = 
	{
		{ type = "TEXNAME"; setMaterialTextureIndex = 0; name = "color";    submat = "color5"; defaultvalue = "HardSplatColor.default.tif"; changeExtension=".color.tif"; texturearray="!HardSplatColor";},
		{ type = "TEXNAME"; setMaterialTextureIndex = 1; name = "roof";		submat = "color5"; defaultvalue = "HardSplatColor.default.tif"; changeExtension=".roofs.tif";	texturearray="!HardSplatColor";},
		{ type = "TEXNAME"; setMaterialTextureIndex = 2; name = "splatmap"; submat = "color5"; defaultvalue = "HardSplatTextures.default.tif"; changeExtension=".tif";		texturearray="!HardSplatTextures";},
		{ type = "TEXNAME"; setMaterialTextureIndex = 3; name = "normal";	submat = "color5"; defaultvalue = "HardSplatNormal.default.tif"; changeExtension=".nm.tif";		texturearray="!HardSplatNormal";},
		{ type = "TEXNAME"; setMaterialTextureIndex = 14;name = "selfillum"; submat = "color5"; defaultvalue = "HardSplatSelfIllum.default.tif"; changeExtension=".si.tif"; texturearray="!HardSplatSelfIllum"; ifShaderDefine="USE_SELFILLUM"; },

		{ type = "TEXNAME"; setMaterialTextureIndex = 4; name = "closeupR"; submat = "color4"; defaultvalue = "CloseupTextures.default.tif"; texturearray="!CloseupTextures";},
		{ type = "TEXNAME"; setMaterialTextureIndex = 5; name = "closeupG"; submat = "color3"; defaultvalue = "CloseupTextures.default.tif"; texturearray="!CloseupTextures";},
		{ type = "TEXNAME"; setMaterialTextureIndex = 6; name = "closeupB"; submat = "color2"; defaultvalue = "CloseupTextures.default.tif"; texturearray="!CloseupTextures";},
		{ type = "TEXNAME"; setMaterialTextureIndex = 7; name = "closeupA"; submat = "color1"; defaultvalue = "CloseupTextures.default.tif"; texturearray="!CloseupTextures";},
		{ type = "TEXNAME"; setMaterialTextureIndex = 8; name = "closeup0"; submat = "color0"; defaultvalue = "CloseupTextures.default.tif"; texturearray="!CloseupTextures";},

		{ type = "TEXNAME"; setMaterialTextureIndex = 9;  name = "closeupMR_R"; ifShaderDefine="USE_MR_CLOSEUP"; submat = "color4"; changeExtension=".mr.tif"; defaultvalue = "CloseupTextures.default.mr.tif"; texturearray="!CloseupMetalnessRoughnessTextures"; },
		{ type = "TEXNAME"; setMaterialTextureIndex = 10; name = "closeupMR_G"; ifShaderDefine="USE_MR_CLOSEUP"; submat = "color3"; changeExtension=".mr.tif"; defaultvalue = "CloseupTextures.default.mr.tif"; texturearray="!CloseupMetalnessRoughnessTextures"; },
		{ type = "TEXNAME"; setMaterialTextureIndex = 11; name = "closeupMR_B"; ifShaderDefine="USE_MR_CLOSEUP"; submat = "color2"; changeExtension=".mr.tif"; defaultvalue = "CloseupTextures.default.mr.tif"; texturearray="!CloseupMetalnessRoughnessTextures"; },
		{ type = "TEXNAME"; setMaterialTextureIndex = 12; name = "closeupMR_B"; ifShaderDefine="USE_MR_CLOSEUP"; submat = "color1"; changeExtension=".mr.tif"; defaultvalue = "CloseupTextures.default.mr.tif"; texturearray="!CloseupMetalnessRoughnessTextures"; },
		{ type = "TEXNAME"; setMaterialTextureIndex = 13; name = "closeupMR_0"; ifShaderDefine="USE_MR_CLOSEUP"; submat = "color0"; changeExtension=".mr.tif"; defaultvalue = "CloseupTextures.default.mr.tif"; texturearray="!CloseupMetalnessRoughnessTextures"; },

		{ type = "TEXNAME"; name = "overlay"; ifShaderDefine="USE_OVERLAY"; submat = "color6"; defaultvalue = "gray.png"; },

		{ type = "PROPERTY"; name = "colorIndex"; setMaterialInt = 0; defaultvalue = "4";},

		-- маска splatmap для прибивания overlay. например чтоб не было overlay на синем канале надо поставить {1, 1, 0, 1}
		{ type = "PROPERTY"; name = "overlaySplatmapMask"; setMaterialFloat4 = 0; defaultvalue = "1, 1, 1, 1";}, 

		--- shaderDefine
		{ type = "PROPERTY"; name = "shaderDefine"; defaultvalue = "NODEFINITIONS";	}, -- SOLIDBORDER
	},
},

-- Lake5.1 материал
{
	name = "Lake5.1";
	lsa3_material = "defmaterial";
	reflectionReceiver = true;
	preexport = "OffsetMapChannelIfNo;preexport5.0";
	postexport = "postexport5.0";
	sharedMaterial = "Surface5.0shared";

	shaderdefines = 
	{
		'LAKE_COLORCLIPMAP',
		'USE_OFFSET'
	},

	paramsources = 
	{
		{ name = "colorIndex"; setMaterialInt = 0; type = "PROPERTY"; defaultvalue = "6";},

		{ name = "waterReflectionFactor"; setMaterialFloat = 0; type = "PROPERTY"; defaultvalue = "0.4";},	-- степень отражения
		{ name = "waterColorBlendFactor"; setMaterialFloat = 1; type = "PROPERTY"; defaultvalue = "0.6";},	-- подмешивание цвета земли в воду

		{ type = "PROPERTY"; name = "shaderDefine"; defaultvalue = "NODEFINITIONS";},
	},
	streams = 
	{
		-- для NEXTLOD_BLEDING
		{ name = "baseIndex"; type = "INT1"; },

		{ name = "offset"; type = "FLOAT1"; required=true; ifShaderDefine="USE_OFFSET";},
	};
},

{
	name = "OnlayMarks5.1";
	lsa3_material = "defmaterial";
	preexport = "parametricUVW";
--	postexport = "Structured";
	paramsources = 
	{
		{ type = "TEXNAME";		name = "fabricTexture";			setMaterialTextureIndex = 0; submat = "color0";	defaultvalue = "fabric.default.tif";		texturearray="!fabric";},
		{ type = "TEXNAME"; 	name = "cracksMaskTexture";		setMaterialTextureIndex = 1; submat = "color1";	defaultvalue = "cracksmask.default.tif";	texturearray="!cracksMask";},
		{ type = "TEXNAME"; 	name = "specularTexture";									 submat = "ID_SH";  defaultvalue = "default.mr"; changeExtension=".tif"; },
		
		{ type = "PROPERTY";	name = "colorIndex"; 	setMaterialInt = 0;		defaultvalue = "14";},
	};
	streams = 
	{
		{ name = "P";					type = "FLOAT3"; },	
		{ name = "N";					type = "FLOAT3"; },	

		{ name = "parametricUVW"; 		type = "FLOAT3";},
		
		{ name = "fabricTexCoord"; 		type = "INT1"; assignedTotexture = "color0"; defaultCopyFrom = "color0"; setMaterialManifold = 0; },
		{ name = "cracksMaskTexCoord";  type = "INT1"; assignedTotexture = "color1"; defaultCopyFrom = "color0"; setMaterialManifold = 1; },
	};
},

-- ��������� ���������� ��� ������
{
	name = "RadarPointsOnlay5.1";
	exportPrimitives = false;
	structuredStream = true; --because exportPrimitives = false;
	
	postexport = "Structured";
	streams = 
	{
		{ name = "P";     		type = "FLOAT3";},
		{ name = "N";     		type = "FLOAT3";},
		{ name = "intensity";   type = "FLOAT";		required = false;	defaultValue = 1.0},
		{ name = "omni";		type = "FLOAT";		required = false;	defaultValue = 0.0},
	},
	paramsources = 
	{
		{ type = "PROPERTY"; name = "colorIndex"; setMaterialInt = 0; defaultvalue = "6";},
	},
},


--- River 5.1
--- Земля+карта: реки и берега
{
	name = "River5.1";
	lsa3_material = "defmaterial";
	preexport = "preexport5.0;parametricUVW";
	postexport = "postexport5.0";
	sharedMaterial = "Surface5.0shared";

	shaderdefines = 
	{
		'LAKE_COLORCLIPMAP',
		'USE_MR',
		'DISABLE_WATER',
	};

	paramsources = 
	{
		{ name = "diffusetexure"; type = "TEXNAME"; submat = "color0"; },
		{ name = "watertexure"; type = "TEXNAME"; submat = "color1"; ifShaderDefine = "!DISABLE_WATER";},
		{ name = "mrtexture"; type = "TEXNAME"; submat = "color2"; defaultvalue = "white.png"; ifShaderDefine = "USE_MR";},

		{ name = "colorIndex"; setMaterialInt = 0; type = "PROPERTY"; defaultvalue = "6";},

		{ name = "waterReflectionFactor"; setMaterialFloat = 0; type = "PROPERTY"; defaultvalue = "0.4";},	-- степень отражения
		{ name = "waterColorBlendFactor"; setMaterialFloat = 1; type = "PROPERTY"; defaultvalue = "0.6";},	-- подмешивание цвета земли в воду

		{ type = "PROPERTY"; name = "shaderDefine"; defaultvalue = "NODEFINITIONS";	},
	},
	streams = 
	{
		-- для NEXTLOD_BLEDING
		{ name = "baseIndex"; type = "INT1"; },
		-- Вершины
		{ name = "parametricUVW";   type = "FLOAT3"; },

		-- Текстурные координаты для colorTexCoord
		{ name = "color1TexCoord"; type = "INT1"; assignedTotexture="color0"; setMaterialManifold=0; },
		-- Текстурные координаты для waterTexCoord
		{ name = "waterTexCoord"; type = "INT1"; assignedTotexture="color1"; defaultCopyFrom="color1TexCoord"; setMaterialManifold=1; },

		-- индекс ассета
		{ name = "assetIndex"; type = "INT1"; interpolation = "per primitive"; defaultValue = -1; ifShaderDefine = "ASSET_INDEX"; },
	};
},

--- Земля+карта: дороги
{
	name = "Road5.1";
	lsa3_material = "defmaterial";
	preexport = "preexport5.0;parametricUVW";
	postexport = "postexport5.0";
	sharedMaterial = "Surface5.0shared";

	shaderdefines = 
	{
		'USE_NORMALMAP',
		'USE_MR',
		'NOISE_PLANAR_MAPPING',		-- использовать планарный мапинг для noiseTexture и noiseSpecTexture
		'HACK_NORMALS',				-- костыль чтоб не выворачивались нормали в 5.1
		'CAST_CASCADE_SHADOWS'
	};

	paramsources = 
	{
		{ name = "colorTexture"; type = "TEXNAME"; submat  = "color0"; behavior="unique";},
		{ name = "uvTexture"; type = "TEXNAME"; submat  = "color1"; },
		{ name = "markTexture"; type = "TEXNAME"; submat  = "color2"; },
		{ name = "normalmapTexture"; type = "TEXNAME"; submat  = "bump0"; defaultvalue = "normalZ.png"; },		
		{ name = "noiseTexture"; type = "TEXNAME"; defaultvalue = "gray.png"; submat  = "color3"; },		-- применяется multiply*2
		{ name = "mrtexture"; type = "TEXNAME"; defaultvalue = "default.mr.png"; submat  = "ID_SH0";},
		{ name = "colorIndex"; 	setMaterialInt = 0; type = "PROPERTY"; defaultvalue = "5";},
		{ name = "flirType"; 	setMaterialInt = 1; type = "PROPERTY"; preexport="buildFlirType";},
		{ type = "PROPERTY"; name = "shaderDefine"; defaultvalue = "NODEFINITIONS";	},
	},
	streams = 
	{
		-- для NEXTLOD_BLEDING
		{ name = "baseIndex"; type = "INT1"; },

		{ name = "N"; type = "FLOAT3"; preexport="normals"; ifShaderDefine="HACK_ASSETS_NORMALS";},
	
		-- UVW
		{ name = "parametricUVW";   type = "FLOAT3"; },
		{ name = "parametricTangent";   type = "FLOAT3"; ifShaderDefine="USE_NORMALMAP";},
		{ name = "parametricBinormal";   type = "FLOAT3"; ifShaderDefine="USE_NORMALMAP";},

		-- Текстурные координаты для color1TexCoord
		{ name = "color1TexCoord"; type = "INT1"; assignedTotexture="color0"; setMaterialManifold=0; },
		-- Текстурные координаты для color2TexCoord
		{ name = "color2TexCoord"; type = "INT1"; assignedTotexture="color1"; setMaterialManifold=1; },

		{ name = "noiseTexCoord"; type = "INT1"; assignedTotexture="color3"; setMaterialManifold=2; },
		{ name = "specTexCoord"; type = "INT1"; assignedTotexture="ID_SH0"; setMaterialManifold=3; },

	},
},


--- Rock 5.1
--- �������� ����
{
	name = "Rock5.1";
	preexport = "OffsetMapChannelIfNo;preexport5.0;parametricUVW";
	postexport = "postexport5.0";
	sharedMaterial = "Surface5.0shared";

	shaderdefines = 
	{
		'USE_NORMALMAP',
		'PBR_TEXTURES',
	};

	streams = 
	{
		-- ��� NEXTLOD_BLEDING
		{ name = "baseIndex"; type = "INT1"; },

		-- UVW
		{ name = "parametricUVW";		type = "FLOAT3"; ifShaderDefine = "!USE_UVW_MANIFOLD"},
		{ name = "parametricTangent";   type = "FLOAT3"; ifShaderDefine = "!USE_UVW_MANIFOLD"},
		{ name = "parametricBinormal";	type = "FLOAT3"; ifShaderDefine = "!USE_UVW_MANIFOLD"},
		{ name = "parametricUVW";		type = "INT1";	 sharedBufferType = "MeshAssetManifold5"; ifShaderDefine = "USE_UVW_MANIFOLD"; },

		{ name = "offset"; type = "FLOAT1"; required=true; },

		{ name = "colorTexCoord"; type = "INT1"; assignedTotexture = "color0"; defaultCopyFrom = "color0"; spaceType="worldspacepoint"; setMaterialManifold = 0; }, -- uv-���������� ��� �������
	},

	paramsources = 
	{
		{ type = "TEXNAME"; name = "colorTexture"; submat = "color0"; defaultvalue = "white.png";	},
		{ type = "TEXNAME"; name = "mrTexture"; submat = "color1"; defaultvalue = "mr.png"; changeExtension=".tif"; },
		{ type = "TEXNAME"; name = "normalTexture"; submat = "bump0"; defaultvalue = "normalZ.png"; ifShaderDefine="USE_NORMALMAP"; changeExtension=".tif"; },

		--- shaderDefine
		{ type = "PROPERTY"; name = "shaderDefine"; defaultvalue = "NODEFINITIONS"; },
	},
},

--- Runway 5.1
--- �������� ���������
{
	name = "Runway5.1";
	reflectionReceiver = true;

	preexport = "preexport5.0;parametricUVW";
	postexport = "postexport5.0";
	sharedMaterial = "Surface5.0shared";

	shaderdefines = 
	{
		'APPLY_AUTOMAPPED_OPACITY',
		'APPLY_AUTOMAPPED_DIFFUSE',
		'BLEND_BY_OVERLAY_ALPHA',
		'USE_CAVITY_FROM_SPEC_B',
	},
	
	paramsources = 
	{
		-- Diffuse textures
		{ type = "TEXNAME"; name = "fabricTexture";			submat = "color0";	setMaterialTextureIndex = 0; requiredUvset="UV0"; defaultvalue = "fabric.default.tif";		texturearray="!fabric";},
		{ type = "TEXNAME"; name = "fabricNormalTexture"; 	submat = "bump0";	setMaterialTextureIndex = 1; requiredUvset="UV0"; defaultvalue = "fabric.default.nm.tif";	texturearray="!fabric.nm";},
		{ type = "TEXNAME"; name = "specularTexture";		submat = "ID_SH"; 	setMaterialTextureIndex = 2; requiredUvset="UV0"; defaultvalue = "fabric.default.mr.tif";	texturearray="!fabric.mr";},

		-- crackMask
		{ type = "TEXNAME"; name = "cracksMaskTexture";		submat = "color2";	setMaterialTextureIndex = 3; requiredUvset="UV3"; defaultvalue = "cracksMask.default.tif";	texturearray="!cracksMask";},
		{ type = "TEXNAME"; name = "cracksMaskNormalTexture";submat = "bump1";	setMaterialTextureIndex = 4; requiredUvset="UV3"; defaultvalue = "cracksMask.default.nm.tif";	texturearray="!cracksMask.nm";},

		-- others
		{ type = "TEXNAME"; name = "decalTexture";		submat = "color1";		setMaterialTextureIndex = 5; defaultvalue = "fabric.default.tif";		texturearray="!fabric";}, --decal
		{ type = "TEXNAME"; name = "dirtMaskTexture";	submat = "color3";		setMaterialTextureIndex = 6; defaultvalue = "dirtMask.default.tif";		texturearray="!dirtMask";},
		{ type = "TEXNAME"; name = "borderTexture";		submat = "opacity0"; 	setMaterialTextureIndex = 7; defaultvalue = "default.tif";			texturearray="!fabric";},
		{ type = "TEXNAME"; name = "overlayTexture";	submat = "color4";									 defaultvalue = "gray.png";					behavior="unique";},

		{ name = "colorIndex"; setMaterialInt = 0; type = "PROPERTY"; defaultvalue = "1";},
		{ type = "PROPERTY"; name = "shaderDefine"; defaultvalue = "NODEFINITIONS";},
	};

	streams = 
	{
		-- ��� NEXTLOD_BLEDING
		{ name = "baseIndex"; type = "INT1"; },

		{ name = "parametricUVW";   type = "FLOAT3"; },
		{ name = "parametricTangent";   type = "FLOAT3"; },
		{ name = "parametricBinormal";   type = "FLOAT3"; },

		-- UV manifolds
		{ name = "fabric";		type = "INT1"; assignedTotexture="color0"; setMaterialManifold=0; },
		{ name = "cracksMask";	type = "INT1"; assignedTotexture="color2"; setMaterialManifold=1; },
		{ name = "decal";		type = "INT1"; assignedTotexture="color1"; setMaterialManifold=2; },
		{ name = "dirtMask";	type = "INT1"; assignedTotexture="color3"; setMaterialManifold=3; },
		{ name = "overlay";		type = "INT1"; assignedTotexture="color4"; setMaterialManifold=4; },

		-- borderUV
		{ name = "borderUV"; type = "FLOAT2"; invertV=true; assignedTotexture="opacity0";
							 ifShaderDefine="APPLY_AUTOMAPPED_OPACITY;APPLY_AUTOMAPPED_DIFFUSE"},	
	};
},


--- RunwayOnlay 5.1
--- �������� �������� ���������
{
	shaderdefines = 
	{
		'USE_PALETTE',
		'ENABLE_METALLIC'
	};

	name = "RunwayOnlay5.1";
	lsa3_material = "defmaterial";
	preexport = "parametricUVW";
--	postexport = "Structured";
	paramsources = 
	{
		-- Diffuse texture
		{ type = "TEXNAME";		name = "fabricTexture";			setMaterialTextureIndex = 0; submat = "color0";	defaultvalue = "fabric.default.tif";		texturearray="!fabric";},
		-- Normal map texture
		{ type = "TEXNAME";		name = "fabricNormalTexture"; 	setMaterialTextureIndex = 1; submat = "bump0";	defaultvalue = "fabric.default.nm.tif";		texturearray="!fabric.nm";},
		-- Specular map texture
		{ type = "TEXNAME";		name = "specularTexture";		setMaterialTextureIndex = 2; submat = "ID_SH"; 	defaultvalue = "fabric.default.mr.tif";		texturearray="!fabric.mr";},
		-- Palette texture
		{ type = "TEXNAME"; 	name = "paletteTexture";		submat = "color1";				defaultvalue = "fabricPalette.tif"; ifShaderDefine = "USE_PALETTE" },
		
		{ type = "PROPERTY"; name = "paletteV";	  setMaterialInt = 0;	  defaultvalue = "0"; 		 preexport = "paletteVRunway51";   ifShaderDefine = "USE_PALETTE" }, -- V coordinate in palette
		{ type = "PROPERTY"; name = "paletteU";	  setMaterialFloat = 0;	  defaultvalue = "0";	 	 preexport = "paletteURandomize";  ifShaderDefine = "USE_PALETTE" }, -- U coordinate in palette, randomized
		{ type = "PROPERTY"; name = "baseColor";  setMaterialFloat4 = 0;  defaultvalue = "0,0,0,0";	 preexport = "baseColorRunway51";  ifShaderDefine = "USE_PALETTE" }, -- Base color of fabric texture
		
		{ type = "PROPERTY"; name = "shaderDefine"; defaultvalue = "NODEFINITIONS";},
		
		{ type = "PROPERTY"; name = "colorIndex"; setMaterialInt = 1;	  defaultvalue = "0"; }, 
	};
	streams = 
	{
		{ name = "P";			type = "FLOAT3";},			-- �������
		{ name = "N";			type = "FLOAT3";},			-- �������

		-- UVW
		{ name = "parametricUVW";   type = "FLOAT3"; },
		{ name = "parametricTangent";   type = "FLOAT3"; },
		{ name = "parametricBinormal";   type = "FLOAT3"; },

		-- diffuse
		{ name = "fabricUV";		type = "INT1"; assignedTotexture="color0";	setMaterialManifold=0; },	-- uv-���������� ��� fabricTexture 
		-- normals
		{ name = "fabricNormalUV";	type = "INT1"; assignedTotexture="bump0";	setMaterialManifold=1; },	-- uv-���������� ��� fabricNormalTexture
		-- specular
		{ name = "specularUV";		type = "INT1"; assignedTotexture="ID_SH";	setMaterialManifold=2; },	-- uv-���������� ��� specularTexture
	};
},

-- Sea5.1
{
	name = "Sea5.1";
	lsa3_material = "defmaterial";
	reflectionReceiver = true;
	preexport = "preexport5.0";
	postexport = "postexport5.0";
	sharedMaterial = "Surface5.0shared";

	streams = 
	{
		-- для NEXTLOD_BLEDING
		{ name = "baseIndex"; type = "INT1"; },
	},
	paramsources = 
	{
		{ type = "PROPERTY"; name = "colorIndex"; setMaterialInt = 0; defaultvalue = "6";},
	},
},

-- Простой материал с диффузной текстурой
{
	name = "Simple5.1";
	lsa3_material = "defmaterial";
	preexport = "OffsetMapChannelIfNo;preexport5.0;parametricUVW";
	postexport = "postexport5.0";
	sharedMaterial = "Surface5.0shared";

	shaderdefines = 
	{
		'USE_NORMALMAP',
		'USE_MR',
		'USE_SELFILLUM',
	},

	streams = 
	{
		-- для NEXTLOD_BLEDING
		{ name = "baseIndex"; type = "INT1"; },

		-- UVW
		{ name = "parametricUVW"; type = "FLOAT3"; ifShaderDefine = "!USE_UVW_MANIFOLD"},
		{ name = "parametricTangent";   type = "FLOAT3"; ifShaderDefine = "!USE_UVW_MANIFOLD"},
		{ name = "parametricBinormal";   type = "FLOAT3"; ifShaderDefine = "!USE_UVW_MANIFOLD"},
		{ name = "parametricUVW";   type = "INT1"; sharedBufferType = "MeshAssetManifold5"; ifShaderDefine = "USE_UVW_MANIFOLD"; },

		{ name = "offset"; type = "FLOAT1"; required=true; },

		{ name = "colorUV"; type = "INT1"; assignedTotexture = "color0"; defaultCopyFrom = "color0"; spaceType="worldspacepoint"; setMaterialManifold = 0; },

		-- индекс ассета
		{ name = "assetIndex"; type = "INT1"; interpolation = "per primitive"; defaultValue = -1; ifShaderDefine = "ASSET_INDEX"; },
	},
	paramsources = 
	{
		{ type = "TEXNAME"; name = "colortexture";		submat = "color0"; },
		{ type = "TEXNAME"; name = "normalTexture";		submat = "bump0"; 			   defaultvalue = "normalZ.png"; },	
		{ type = "TEXNAME"; name = "specularTexture";   submat = "ID_SH"; 			   defaultvalue = "default.mr.png";   ifShaderDefine = "USE_MR";},
		{ type = "TEXNAME"; name = "selfillumTexture";  submat = "selfillumination0";  defaultvalue = "black.png";   ifShaderDefine = "USE_SELFILLUM";},

		{ type = "PROPERTY"; name = "colorIndex"; setMaterialInt = 0; defaultvalue = "4";},

		--- shaderDefine
		{ type = "PROPERTY"; name = "shaderDefine"; defaultvalue = "NODEFINITIONS"; },
	},
},

-- SurfaceVaryHouse5.1
{
	-- TODO
	name = "SurfaceVaryHouse5.1";
	lsa3_material = "defmaterial";
	
	shaderdefines = 
	{
		'DOUBLESIDED',
		'USE_NORMALMAP',
		'AFB_LIGHT_MODEL',			-- todo: выпилить
		'USE_PALETTE',
	};

	--structuredStream = false;
	preexport = "OffsetMapChannelIfNo;preexport5.0;VaryHouse5.1";
	postexport = "postexport5.0";
	sharedMaterial = "Surface5.0shared";
	streams = 
	{
		{ name = "baseIndex"; 			type = "INT1"; },

		{ name = "N"; type = "FLOAT3"; preexport="normals"; ifShaderDefine="HACK_ASSETS_NORMALS";},
		
		{ name = "UV1";			type = "FLOAT2";		invertV=true; defaultValue="0.5"; },		-- uv-координаты для fabricTexture
		{ name = "UV1tangent";  type = "FLOAT3";		invertV=true; tangentFor="UV1"; },			-- tangent для UV1
		{ name = "UV1binormal"; type = "FLOAT3";		invertV=true; binormalFor="UV1";},			-- binormal для UV1
		{ name = "UV2";			type = "FLOAT2";		invertV=true; defaultValue="0.5"; },		-- uv-координаты для decalTexture
		{ name = "UV3";			type = "FLOAT2";		invertV=true; defaultValue="0.5"; },		-- uv-координаты для occlusionTexture
		{ name = "UV4";			type = "FLOAT2";		invertV=true; defaultValue="0.5"; },		-- uv-координаты для selfillumTexture
		{ name = "normalMapTexCoord"; type = "FLOAT2";	invertV=true; assignedTotexture="bump0"; 			defaultValue="0.5"; },	-- uv-координаты для normalmapTexture
		
		{ name = "offset"; 		type = "FLOAT1"; required=true; },
	},
	
	paramsources = 
	{
		{ type = "TEXNAME"; name = "occlusionTexture";		submat = "color2";				defaultvalue = "defaultVaryhouseAO.png";	requiredUvset="UV3";		behavior="unique";},
		{ type = "TEXNAME"; name = "selfillumTexture";		submat = "selfillumination0";	defaultvalue = "black.png";					requiredUvset="UV4";		behavior="unique";},
		{ type = "TEXNAME"; name = "normalmapTexture";		submat = "bump0";				defaultvalue = "normalZ.png";              								behavior="unique";},
		{ type = "TEXNAME"; name = "paletteTexture";		submat = "color3";				defaultvalue = "fabricPalette.tif"; },

		-- Fabrics
		{ type = "TEXNAME"; setMaterialTextureIndex = 0; name = "fabricTextureArray";					submat = "color0";	defaultvalue = "fabric.default.tif";  requiredUvset="UV1";  changeExtension=".tif"; 		texturearray="!fabric";  setFabricDataToMaterialFloat4 = 0;},
		{ type = "TEXNAME"; setMaterialTextureIndex = 1; name = "fabricNormalmapTextureArray";			submat = "color0";	defaultvalue = "fabric.default.tif";  requiredUvset="UV1";  changeExtension=".nm.tif"; 		texturearray="!fabric.nm";},
		{ type = "TEXNAME"; setMaterialTextureIndex = 2; name = "fabricMetalnessRoughnessTextureArray";	submat = "color0";	defaultvalue = "fabric.default.tif";  requiredUvset="UV1";  changeExtension=".mr.tif"; 		texturearray="!fabric.mr";},
		{ type = "TEXNAME"; setMaterialTextureIndex = 3; name = "fabricSelfillumTextureArray";			submat = "color0";	defaultvalue = "fabric.default.tif";  requiredUvset="UV1";  changeExtension=".si.tif"; 		texturearray="!fabric.si";},
		
		-- Decals
		{ type = "TEXNAME"; setMaterialTextureIndex = 4; name = "fabricTextureArray";					submat = "color1";	defaultvalue = "fabric.default.tif";  requiredUvset="UV2";  changeExtension=".tif"; 		texturearray="!fabric";},
		{ type = "TEXNAME"; setMaterialTextureIndex = 5; name = "fabricNormalmapTextureArray";			submat = "color1";	defaultvalue = "fabric.default.tif";  requiredUvset="UV2";  changeExtension=".nm.tif"; 		texturearray="!fabric.nm";},
		{ type = "TEXNAME"; setMaterialTextureIndex = 6; name = "fabricMetalnessRoughnessTextureArray";	submat = "color1";	defaultvalue = "fabric.default.tif";  requiredUvset="UV2";  changeExtension=".mr.tif"; 		texturearray="!fabric.mr";},
		
		{ type = "PROPERTY"; name = "shaderDefine"; defaultvalue = "NODEFINITIONS";},
		
		{ type = "PROPERTY"; name = "OPTIONS";      setMaterialInt = 0;    defaultvalue = "0";},		
		{ type = "PROPERTY"; name = "paletteV";	    setMaterialInt = 1;	   defaultvalue = "0";	 preexport="paletteV2";},		-- V coordinate in palette
		{ type = "PROPERTY"; name = "colorIndex";   setMaterialInt = 2;    defaultvalue = "2";},
		{ type = "PROPERTY"; name = "flirType";     setMaterialInt = 3;    preexport="buildFlirType";},
	},
},
-- SurfaceVaryHouseLod5.1 
{
	name = "SurfaceVaryHouseLod5.1";
	lsa3_material = "defmaterial";

	preexport = "preexport5.0;parametricUVW";
	postexport = "postexport5.0";
	sharedMaterial = "Surface5.0shared";

	shaderdefines = 
	{
		'DOUBLESIDED',
		'USE_NORMALMAP',
	};

	streams = 
	{
		{ name = "baseIndex"; type = "INT1"; },

		{ name = "N"; type = "FLOAT3"; preexport="normals"; ifShaderDefine="HACK_ASSETS_NORMALS";},

		-- UVW
		{ name = "parametricUVW";		type = "FLOAT3"; ifShaderDefine = "!USE_UVW_MANIFOLD"},
		{ name = "parametricTangent";   type = "FLOAT3"; ifShaderDefine = "!USE_UVW_MANIFOLD;USE_NORMALMAP";},
		{ name = "parametricBinormal";  type = "FLOAT3"; ifShaderDefine = "!USE_UVW_MANIFOLD;USE_NORMALMAP";},
		{ name = "parametricUVW";   type = "INT1"; sharedBufferType = "MeshAssetManifold5"; ifShaderDefine = "USE_UVW_MANIFOLD"; },
		-- Текстурные координаты
		{ name = "diffuseTexCoord";   setMaterialManifold=0; type = "INT1"; assignedTotexture="color0"; defaultValue="0.5"; },
		{ name = "specularTexCoord";  setMaterialManifold=1; type = "INT1"; assignedTotexture="ID_SH";  defaultValue="0.5"; },
		{ name = "selfIllumTexCoord"; setMaterialManifold=2; type = "INT1"; assignedTotexture="selfillumination0"; defaultValue="0.5"; },
		{ name = "normalmapTexCoord"; setMaterialManifold=3; type = "INT1"; assignedTotexture="bump0"; defaultValue="0.5"; },
	},
	paramsources = 
	{
		{ type = "TEXNAME"; name = "diffuseTexture";   submat = "color0";											},
		{ type = "TEXNAME"; name = "specularTexture";  submat = "ID_SH"; defaultvalue = "default.mr";				},
		{ type = "TEXNAME"; name = "selfIllumTexture"; submat = "selfillumination0"; defaultvalue = "black.png";    },
		{ type = "TEXNAME"; name = "normalmapTexture"; submat = "bump0"; defaultvalue = "normalZ.png";				},

		{ name = "colorIndex"; setMaterialInt = 0; type = "PROPERTY"; defaultvalue = "1";},

		{ type = "PROPERTY"; name = "shaderDefine"; defaultvalue = "NODEFINITIONS";},
		
		{ type = "PROPERTY"; name = "flirType";     setMaterialInt = 1;    preexport="buildFlirType";},
	},
},


-- ������ ����
{
	name = "WaveHeightOnlay5.1";
	
	streams = 
	{
		{ name = "P";     type = "FLOAT3";},
	},
	paramsources = 
	{
	},
},


-- Управление прибоем
{
	name = "BreakingWaves4.0";
	
	streams = 
	{
		{ name = "P";     type = "FLOAT3";},		-- Вершины
		{ name = "UV0";   type = "FLOAT2";invertV=true;},		-- uv-координаты 
		{ name = "UV0tangent";  type = "FLOAT3"; invertV=true; tangentFor="UV0"; },		-- tangent для UV0
		{ name = "UV0binormal"; type = "FLOAT3"; invertV=true; binormalFor="UV0";},		-- binormal для UV0
	},
	paramsources = 
	{
		{ type = "TEXNAME";  name = "opacityTexture"; submat = "color0"; defaultvalue = "white.png";	requiredUvset="UV0";},
	},
},


-- Трава. 
{
	name = "Grass4.1";
	streams = 
	{
		{ name = "P";     type = "FLOAT3";},		-- Вершины
		{ name = "N";     type = "FLOAT3";},		-- Нормали
		{ name = "UV0";   type = "FLOAT2";invertV=true;},		-- uv-координаты для текстуры цвета
	},
	paramsources = 
	{
		{ type = "TEXNAME"; name = "colorTexture"; submat = "color"; requiredUvset="UV0"; preexport="Multitexture"; defaultvalue="!plantColorTextures.lua";},
		{ type = "TEXNAME"; name = "alphaMaskTexture"; submat = "opacity"; defaultvalue="white.png"; requiredUvset="UV0";},
		{ type = "PROPERTY"; name = "shaderDefine"; defaultvalue = "NODEFINITIONS";},
		{ type = "PROPERTY"; name = "windFlex"; defaultvalue = "0.01";},
	},
},

-- инстансер через Compute 
{
	name = "HwInstancer4.1";
	preexport = "PointInstancer";
	requireServices = "references";
	streams = 
	{
		{ name = "P";     type = "FLOAT3";										},		-- Вершины
		{ name = "AXISX"; type = "FLOAT2"; ifShaderDefine = "!ARBITARY_ROTATE";	},		-- AxisX
		{ name = "AXISX"; type = "FLOAT3"; ifShaderDefine = "ARBITARY_ROTATE";	},		-- AxisX
		{ name = "AXISY"; type = "FLOAT3"; ifShaderDefine = "ARBITARY_ROTATE";	},		-- AxisY
		{ name = "AXISZ"; type = "FLOAT3"; ifShaderDefine = "ARBITARY_ROTATE";	},		-- AxisZ
		{ name = "SEED";  type = "FLOAT1";										},		-- seed
		
	},
	paramsources = 
	{
		{ type = "PROPERTY"; name = "shaderDefine"; defaultvalue = "NODEFINITIONS";},
	
		{ type = "PROPERTY"; name = "levels"; defaultvalue = "012345";},
		{ type = "PROPERTY"; name = "reference"; defaultvalue = "";},
		{ type = "PROPERTY"; name = "maxlevel"; defaultvalue = "0";},
		{ type = "PROPERTY"; name = "shaderDefine"; defaultvalue = "STANDARTSTRUCTURE";},
		{ type = "PROPERTY"; name = "colortexture"; defaultvalue = "#empty#";},
	},
},

--- afb_omni_light
{
	name = "afb_omni_light";
	lsa3_material = "defmaterial";
	normals = 1;
	colors = 0;
	preexport = "EDMLight";

	shaderdefines = 
	{
		'USE_LIGHTPALLETE',
	};

	paramsources = 
	{
		{name = "colorTexture"; type = "TEXNAME"; submat = "color0"; defaultvalue="white.png";},
		{name = "opacityTexture"; type = "TEXNAME"; submat = "opacity0"; defaultvalue="white.png";},
		{name = "maxscale"; type = "PROPERTY"; defaultvalue="1";},
		{name = "mindistance"; type = "PROPERTY"; defaultvalue="0";},
		{name = "maxdistance"; type = "PROPERTY"; defaultvalue="1";},
		{name = "frequency"; type = "PROPERTY"; defaultvalue="1";},
		{name = "duration"; type = "PROPERTY"; defaultvalue="1";},
		{ type = "PROPERTY"; name = "shaderDefine"; defaultvalue = "NODEFINITIONS";},
	};
	streams = 
	{
		-- Вершины
		{ name = "P";   type = "FLOAT3"; },
		-- Текстурные координаты для colorTexture и по-умолчанию
		{ name = "colorTexCoord"; type = "FLOAT2"; invertV = true; assignedTotexture="color0";},
		-- Текстурные координаты для opacityTexture
		{ name = "opacityTexCoord"; type = "FLOAT2"; invertV = true; assignedTotexture="opacity0";},
		-- Нормали
		{ name = "N";   type = "FLOAT3"; },
		-- Тангент
		{ name = "T";   type = "FLOAT3"; tangentFor = "colorTexCoord"; invertV=true;},
		-- Бинормаль
		{ name = "B";   type = "FLOAT3"; binormalFor = "colorTexCoord"; invertV=true;},
		-- Центры полигонов, относительно которых производится масштабирование
		{ name = "centers"; type = "FLOAT3"; spaceType = "worldSpacePoint";},
	};
},
--- afb_spot_light
{
	name = "afb_spot_light";
	lsa3_material = "defmaterial";
	normals = 1;
	colors = 0;
	preexport = "EDMLight";

	shaderdefines = 
	{
		'USE_LIGHTPALLETE',
	};

	paramsources = 
	{
		{name = "colorTexture"; type = "TEXNAME"; submat = "color0"; defaultvalue="white.png";},
		{name = "opacityTexture"; type = "TEXNAME"; submat = "opacity0"; defaultvalue="white.png";},
		{name = "topwardColor"; type = "PROPERTY"; defaultvalue="1, 1, 1";},
		{name = "downwardColor"; type = "PROPERTY"; defaultvalue="1, 1, 1";},
		{name = "splitTransition"; type = "PROPERTY"; defaultvalue="1";},
		{name = "hotspot"; type = "PROPERTY"; defaultvalue="60";},
		{name = "falloff"; type = "PROPERTY"; defaultvalue="90";},
		{name = "ambient"; type = "PROPERTY"; defaultvalue="0.05";},
		{name = "maxscale"; type = "PROPERTY"; defaultvalue="1";},
		{name = "mindistance"; type = "PROPERTY"; defaultvalue="0";},
		{name = "maxdistance"; type = "PROPERTY"; defaultvalue="1";},
		{name = "frequency"; type = "PROPERTY"; defaultvalue="1";},
		{name = "duration"; type = "PROPERTY"; defaultvalue="1";},
		{ type = "PROPERTY"; name = "shaderDefine"; defaultvalue = "NODEFINITIONS";},
	};
	streams = 
	{
		-- Вершины
		{ name = "P";   type = "FLOAT3"; },
		-- Нормали
		{ name = "N";   type = "FLOAT3"; },
		-- Текстурные координаты для colorTexture и по-умолчанию
		{ name = "colorTexCoord"; type = "FLOAT2"; invertV = true; assignedTotexture="color0";},
		-- Текстурные координаты для opacityTexture
		{ name = "opacityTexCoord"; type = "FLOAT2"; invertV = true; assignedTotexture="opacity0";},
		-- Центры полигонов, относительно которых производится масштабирование
		{ name = "centers"; type = "FLOAT3"; spaceType = "worldSpacePoint";},
	};
},
--- EDM_omni_light
{
	name = "EDM_omni_light";
	lsa3_material = "defmaterial";
	normals = 1;
	colors = 0;
	preexport = "EDMLight";

	shaderdefines = 
	{
		'USE_LIGHTPALLETE',
	};

	paramsources = 
	{
		{name = "colorTexture"; type = "TEXNAME"; submat = "color0"; defaultvalue="white.png";},
		{name = "opacityTexture"; type = "TEXNAME"; submat = "opacity0"; defaultvalue="white.png";},
		{name = "maxscale"; type = "PROPERTY"; defaultvalue="1";},
		{name = "mindistance"; type = "PROPERTY"; defaultvalue="0";},
		{name = "maxdistance"; type = "PROPERTY"; defaultvalue="1";},
		{name = "frequency"; type = "PROPERTY"; defaultvalue="1";},
		{name = "duration"; type = "PROPERTY"; defaultvalue="1";},
		{ type = "PROPERTY"; name = "shaderDefine"; defaultvalue = "NODEFINITIONS";},
	};
	streams = 
	{
		-- Вершины
		{ name = "P";   type = "FLOAT3"; },
		-- Текстурные координаты для colorTexture и по-умолчанию
		{ name = "colorTexCoord"; type = "FLOAT2"; invertV = true; assignedTotexture="color0";},
		-- Текстурные координаты для opacityTexture
		{ name = "opacityTexCoord"; type = "FLOAT2"; invertV = true; assignedTotexture="opacity0";},
		-- Нормали
		{ name = "N";   type = "FLOAT3"; },
		-- Тангент
		{ name = "T";   type = "FLOAT3"; tangentFor = "colorTexCoord"; invertV=true;},
		-- Бинормаль
		{ name = "B";   type = "FLOAT3"; binormalFor = "colorTexCoord"; invertV=true;},
		-- Центры полигонов, относительно которых производится масштабирование
		{ name = "centers"; type = "FLOAT3"; spaceType = "worldSpacePoint";},
	};
},
--- EDM_spot_light
{
	name = "EDM_spot_light";
	lsa3_material = "defmaterial";
	normals = 1;
	colors = 0;
	preexport = "EDMLight";

	shaderdefines = 
	{
		'USE_LIGHTPALLETE',
	};

	paramsources = 
	{
		{name = "colorTexture"; type = "TEXNAME"; submat = "color0"; defaultvalue="white.png";},
		{name = "opacityTexture"; type = "TEXNAME"; submat = "opacity0"; defaultvalue="white.png";},
		{name = "topwardColor"; type = "PROPERTY"; defaultvalue="1, 1, 1";},
		{name = "downwardColor"; type = "PROPERTY"; defaultvalue="1, 1, 1";},
		{name = "splitTransition"; type = "PROPERTY"; defaultvalue="1";},
		{name = "hotspot"; type = "PROPERTY"; defaultvalue="60";},
		{name = "falloff"; type = "PROPERTY"; defaultvalue="90";},
		{name = "ambient"; type = "PROPERTY"; defaultvalue="0.05";},
		{name = "maxscale"; type = "PROPERTY"; defaultvalue="1";},
		{name = "mindistance"; type = "PROPERTY"; defaultvalue="0";},
		{name = "maxdistance"; type = "PROPERTY"; defaultvalue="1";},
		{name = "frequency"; type = "PROPERTY"; defaultvalue="1";},
		{name = "duration"; type = "PROPERTY"; defaultvalue="1";},
		{ type = "PROPERTY"; name = "shaderDefine"; defaultvalue = "NODEFINITIONS";},
	};
	streams = 
	{
		-- Вершины
		{ name = "P";   type = "FLOAT3"; },
		-- Нормали
		{ name = "N";   type = "FLOAT3"; },
		-- Текстурные координаты для colorTexture и по-умолчанию
		{ name = "colorTexCoord"; type = "FLOAT2"; invertV = true; assignedTotexture="color0";},
		-- Текстурные координаты для opacityTexture
		{ name = "opacityTexCoord"; type = "FLOAT2"; invertV = true; assignedTotexture="opacity0";},
		-- Центры полигонов, относительно которых производится масштабирование
		{ name = "centers"; type = "FLOAT3"; spaceType = "worldSpacePoint";},
	};
},
--- AFB_omni_light5.1
{
	name = "AfbOmniLight5.1";
	lsa3_material = "defmaterial";
	preexport = "EDMLight;";
	streams = 
	{
		{ name = "P";   type = "FLOAT3"; },
		{ name = "centers"; type = "FLOAT3"; spaceType = "worldSpacePoint";},
	
		{ name = "UV0"; type = "FLOAT2"; invertV = true; }, -- координаты для рисования лайта. Плашка лайта должна быть размаплена от 0 до 1.
	};
	paramsources = 
	{
		{ type = "PROPERTY"; name = "shaderDefine"; defaultvalue = "NODEFINITIONS";},
		
		{ type = "PROPERTY"; name = "frequency";   	setMaterialFloat = 1;   defaultvalue = "1";},
		{ type = "PROPERTY"; name = "duration";   	setMaterialFloat = 2;   defaultvalue = "1";},
		{ type = "PROPERTY"; name = "phase";   		setMaterialFloat = 3;   defaultvalue = "0";},
		
		{ type = "PROPERTY"; name = "paletteV";   	setMaterialInt = 0;    	defaultvalue = "0";},
	};
},
--- afb_spot_light
{
	name = "AfbSpotLight5.1";
	lsa3_material = "defmaterial";
	preexport = "EDMLight;";
	streams = 
	{
		{ name = "P";   	type = "FLOAT3"; },
		{ name = "N";   	type = "FLOAT3"; },
		{ name = "centers"; type = "FLOAT3"; spaceType = "worldSpacePoint"; },

		{ name = "UV0"; type = "FLOAT2"; invertV = true; }, -- координаты для рисования лайта. Плашка лайта должна быть размаплена от 0 до 1.
	};
	paramsources = 
	{
		{ type = "PROPERTY"; name = "shaderDefine"; defaultvalue = "NODEFINITIONS"; },

		{ type = "PROPERTY"; name = "frequency";   		setMaterialFloat = 1;    defaultvalue = "1"; },
		{ type = "PROPERTY"; name = "duration";   		setMaterialFloat = 2;    defaultvalue = "1"; },
		{ type = "PROPERTY"; name = "phase";   		 	setMaterialFloat = 3;    defaultvalue = "0";},

		{ type = "PROPERTY"; name = "topwardColor"; 	setMaterialFloat4 = 0;   defaultvalue = "1,1,1,1"; },
		{ type = "PROPERTY"; name = "downwardColor"; 	setMaterialFloat4 = 1;   defaultvalue = "1,1,1,1"; },
		{ type = "PROPERTY"; name = "splitTransition"; 	setMaterialFloat = 4;    defaultvalue = "1"; },
		{ type = "PROPERTY"; name = "hotspot"; 			setMaterialFloat = 5;    defaultvalue = "60"; },
		{ type = "PROPERTY"; name = "falloff"; 			setMaterialFloat = 6;    defaultvalue = "90"; },
		{ type = "PROPERTY"; name = "ambient"; 			setMaterialFloat = 7;    defaultvalue = "0.05"; },
		
		{ type = "PROPERTY"; name = "paletteV";  		setMaterialInt = 0;   	 defaultvalue = "0";},
	};
},
--- AFB_omni_light5.1
{
	name = "OmniLight5.1";
	lsa3_material = "defmaterial";
	preexport = "EDMLight;";
	streams = 
	{
		{ name = "P";   type = "FLOAT3"; },
		{ name = "centers"; type = "FLOAT3"; spaceType = "worldSpacePoint";},
	
		{ name = "UV0"; type = "FLOAT2"; invertV = true; }, -- координаты для рисования лайта. Плашка лайта должна быть размаплена от 0 до 1.
	};
	paramsources = 
	{
		{ type = "PROPERTY"; name = "shaderDefine"; defaultvalue = "NODEFINITIONS";},
		
		{ type = "PROPERTY"; name = "frequency";   	setMaterialFloat = 1;    defaultvalue = "1";},
		{ type = "PROPERTY"; name = "duration";   	setMaterialFloat = 2;    defaultvalue = "1";},
		{ type = "PROPERTY"; name = "phase";   		setMaterialFloat = 3;    defaultvalue = "0";},
		
		{ type = "PROPERTY"; name = "paletteV";   setMaterialInt = 0;    defaultvalue = "0";},
	};
},
--- EDM_spot_light
{
	name = "SpotLight5.1";
	lsa3_material = "defmaterial";
	preexport = "EDMLight;";
	streams = 
	{
		{ name = "P";   	type = "FLOAT3"; },
		{ name = "N";   	type = "FLOAT3"; },
		{ name = "centers"; type = "FLOAT3"; spaceType = "worldSpacePoint"; },

		{ name = "UV0"; type = "FLOAT2"; invertV = true; }, -- координаты для рисования лайта. Плашка лайта должна быть размаплена от 0 до 1.
	};
	paramsources = 
	{
		{ type = "PROPERTY"; name = "shaderDefine"; defaultvalue = "NODEFINITIONS"; },

		{ type = "PROPERTY"; name = "frequency";   		setMaterialFloat = 1;    defaultvalue = "1"; },
		{ type = "PROPERTY"; name = "duration";   		setMaterialFloat = 2;    defaultvalue = "1"; },
		{ type = "PROPERTY"; name = "phase";   		 	setMaterialFloat = 3;    defaultvalue = "0";},

		{ type = "PROPERTY"; name = "topwardColor"; 	setMaterialFloat4 = 0;   defaultvalue = "1,1,1,1"; },
		{ type = "PROPERTY"; name = "downwardColor"; 	setMaterialFloat4 = 1;   defaultvalue = "1,1,1,1"; },
		{ type = "PROPERTY"; name = "splitTransition"; 	setMaterialFloat = 4;    defaultvalue = "1"; },
		{ type = "PROPERTY"; name = "hotspot"; 			setMaterialFloat = 5;    defaultvalue = "60"; },
		{ type = "PROPERTY"; name = "falloff"; 			setMaterialFloat = 6;    defaultvalue = "90"; },
		{ type = "PROPERTY"; name = "ambient"; 			setMaterialFloat = 7;    defaultvalue = "0.05"; },
		
		{ type = "PROPERTY"; name = "paletteV";  		setMaterialInt = 0;   	 defaultvalue = "0";},
	};
},
-- Map4.0
{
	name = "Map4.0";
	lsa3_material = "defmaterial";

	shaderdefines = 
	{
		'VIEW_IN_MAPTEX',	-- показывать в MAPTEX моде
		'VIEW_IN_TAD',		-- показывать в TAD моде
	},

	streams = 
	{
		{ name = "P"; type = "FLOAT3";},		-- Вершины
	},
	paramsources = 
	{
		{ type = "PROPERTY"; name = "shaderDefine"; defaultvalue = "NODEFINITIONS";},
		{ type = "PROPERTY"; name = "colorIndex"; defaultvalue = "0";},
	},
},

-- BlendAnimation4.1
{
	name = "BlendAnimation4.1";
	lsa3_material = "defmaterial";
	postexport = "WindDeformerBox";

	streams = 
	{
		{ name = "P"; type = "FLOAT3";},		-- Вершины
		{ name = "PSEQUENCE"; type = "FLOAT3"; structured=true;},		-- Вершины
		{ name = "NSEQUENCE"; type = "FLOAT3"; structured=true;},		-- Нормали
		{ name = "UV0"; type = "FLOAT2";invertV=true;assignedTotexture="color0";},		-- Вершины
	},
	paramsources = 
	{
		{ name = "colorTexture"; type = "TEXNAME"; submat = "color0"; defaultvalue="white.png";},
		{ name = "selfillumTexture"; type = "TEXNAME"; submat = "selfillumination0"; defaultvalue="black.png";},
		{ type = "PROPERTY"; name = "frameCount"; defaultvalue = "1";},
		{ type = "PROPERTY"; name = "shaderDefine"; defaultvalue = "NODEFINITIONS";},
		{ type = "PROPERTY"; name = "periodAnimation"; defaultvalue = "1";},
		{ type = "PROPERTY"; name = "shaderDefine"; defaultvalue = "NODEFINITIONS";},
	},
},

-- LightSpot4.1
-- Пятно света на земле
{
	name = "LightSpot4.1";

	shaderdefines = 
	{
		'USE_LIGHTPALLETE',
	};

	streams = 
	{
		{ name = "P"; type = "FLOAT3";},		-- Вершины
		{ name = "UV0"; type = "FLOAT2"; invertV=true;},
	},
	paramsources = 
	{
		{ type = "PROPERTY"; name = "shaderDefine"; defaultvalue = "NODEFINITIONS";},
		{ type = "TEXNAME"; name = "selfillumTexture"; submat = "color0"; defaultvalue = "white.png"; requiredUvset="UV0";},
	},
},

-- Деревья с инстансированием через compute
{
	name = "Speedtree4.1";
--	preexport = "Tree";

	shaderdefines = 
	{
		'DOUBLESIDED',
		'WINDDEFORMER',
		'NORMALS_FROM_CENTER',
		'NORMALS_INTERPOLATE_UP',
		'NO_BC3N',		-- поднять в speedtree7. так как в speedtree7 нормали в dds, но не bc3n
		'FLIR_AS_SURFACE'
	};

	postexport = "TreeInstancer5.1";				-- исправляет боксы для билбордов

	streams = 
	{
		{ name = "P";     type = "FLOAT3";},		-- Вершины
		{ name = "N";     type = "FLOAT3";},		-- Нормали
		{ name = "diffuseTexCoord";   type = "FLOAT2";},-- uv-координаты для текстур (diffuse, specular, normal)
		{ name = "lodTransition";   type = "FLOAT4";},	-- данные для схлопывания/развертывания полигонов при переходе между лодами
		{ name = "options";  type = "INT1"; preexport = "buildingOptions";}, -- scale: X=1, Y=2, Z=4
		{ name = "geometryType"; type = "FLOAT1";},	 -- тип полигона
		{ name = "tangent"; type = "FLOAT3";},		-- tangent
		{ name = "ambientOcclusion"; type = "FLOAT1"; }, -- AO
	},
	paramsources = 
	{
		{ type = "TEXNAME"; name = "diffuseTexture"; submat = "color0"; defaultvalue = "gray.png"; },
		{ type = "TEXNAME"; name = "normalTexture"; submat = "color1"; defaultvalue = "normalZ.png"; },
		--{ type = "TEXNAME"; name = "detailTexture"; submat = "color2"; defaultvalue = "gray.png"; },
		--{ type = "TEXNAME"; name = "detailNormaltexture"; submat = "color3"; defaultvalue = "normalZ.png"; },
		--{ type = "TEXNAME"; name = "specularMaskTexture"; submat = "color4"; defaultvalue = "black.png"; },
		--{ type = "TEXNAME"; name = "transmissionMaskTexture"; submat = "color5"; defaultvalue = "black.png"; },
		{ type = "TEXNAME"; name = "paletteTexture"; submat = "shininessstrength"; defaultvalue = "gray.png"; },

		{ type = "PROPERTY"; name = "verticalBilboards"; defaultvalue = "1"; },
		{ type = "PROPERTY"; name = "fade2bilboard"; defaultvalue = "0"; },
		{ type = "PROPERTY"; name = "bilboardData"; required = false; structured = true; },
		{ type = "PROPERTY"; name = "windFlex"; defaultvalue = "0.01"; },
		{ type = "PROPERTY"; name = "gamma"; defaultvalue = "1"; },
		{ type = "PROPERTY"; name = "center"; defaultvalue = "0";},
		{ type = "PROPERTY"; name = "height"; defaultvalue = "15";},

		{ type = "PROPERTY"; name = "shaderDefine"; defaultvalue = "NODEFINITIONS";},
	},
},
-- Дома
{
	name = "VaryHouse4.1";
	lsa3_material = "defmaterial";
	
	shaderdefines = 
	{
		'DOUBLESIDED',
		'USE_COLOR_PALETTE',
		'OCCELATOR',
		'HEELING',
		'AFB_LIGHT_MODEL',
		'USE_HEATMAP',
		'FLIR_NO_INSTANCE_RANDOMNESS',	-- For tiling geometry, such as fences
	};
	structuredStream = true;
	preexport = "VaryHouse4.1";
	postexport = "Structured";
	box = "main";
	streams = 
	{
		{ name = "P";					type = "FLOAT3";},		-- Вершины
		{ name = "N";					type = "FLOAT3";},		-- Нормали
		
		{ name = "UV0";					type = "FLOAT2";	invertV=true; defaultValue="0.5"; },	-- uv-координаты для surfaceColorTexture
		{ name = "UV1";					type = "FLOAT2";	invertV=true; defaultValue="0.5"; },	-- uv-координаты для fabricTexture
		{ name = "UV1tangent";  		type = "FLOAT3";	invertV=true; tangentFor="UV1";   },	-- tangent для UV1
		{ name = "UV1binormal"; 		type = "FLOAT3";	invertV=true; binormalFor="UV1";  },	-- binormal для UV1
		{ name = "UV2";					type = "FLOAT2";	invertV=true; defaultValue="0.5"; },	-- uv-координаты для decalTexture
		{ name = "UV3";					type = "FLOAT2";	invertV=true; defaultValue="0.5"; },	-- uv-координаты для occlusionTexture
		{ name = "UV4";					type = "FLOAT2";	invertV=true; defaultValue="0.5"; },	-- uv-координаты для selfillumTexture
		{ name = "normalMapTexCoord"; 	type = "FLOAT2";	invertV=true; assignedTotexture="bump0"; 			defaultValue="0.5"; },	-- uv-координаты для normalmapTexture
		{ name = "heatmapTexCoord";   	type = "FLOAT2"; 	invertV=true; assignedTotexture="filtercolor"; 		defaultValue="0.5"; 	ifShaderDefine = "USE_HEATMAP"; },	-- uv-координаты для heatmapTexture
		
		{ name = "fabricTextureArrayIndex"; type = "INT1";},	-- fabricTexture index
		{ name = "decalTextureArrayIndex"; 	type = "INT1";},	-- decalTexture index
		
		{ name = "occelatorPivot"; 	type = "FLOAT3"; 		preexport="occelatorPivot";	spaceType="worldSpacePoint";},	-- occelatorPivot
		{ name = "OPTIONS";     	type = "INT";           preexport="buildingOptions";},	-- Не переименовывать и не менять тип, тк в преэкспорт материала ссылается на этот стрим чтоб пропихнуть опции для flir
		{ name = "paletteV";		type = "INT1";			preexport="paletteV"; 			terrainDefinition = "USE_TERRAIN_PALETTE";},	-- V coordinate in palette
		{ name = "flirLuminosity";	type = "FLOAT";			preexport="flirLuminosity"; 	ifShaderDefine = "FLIR_LUMINOSITY";},			-- Flir brightness moved to vertices from texture
	},
	paramsources = 
	{
		{ type = "TEXNAME"; name = "surfaceColorTexture";	submat = "color0";				defaultvalue = "white.png";				requiredUvset="UV0"; 	behavior="unique";},
		{ type = "TEXNAME"; name = "fabricTextureArray";	submat = "color1";				defaultvalue = "fabric.default.tif";	requiredUvset="UV1"; 	hideExtension=true; texturearray="!fabric";},
		{ type = "TEXNAME"; name = "decalTextureArray";		submat = "color2";				defaultvalue = "decal.default.tif";		requiredUvset="UV2"; 	hideExtension=true; texturearray="!decal"; },
		{ type = "TEXNAME"; name = "occlusionTexture";		submat = "color3";				defaultvalue = "defaultVaryhouseAO.png";requiredUvset="UV3"; 	behavior="unique";},
		{ type = "TEXNAME"; name = "selfillumTexture";		submat = "selfillumination0";	defaultvalue = "black.png";				requiredUvset="UV4"; 	behavior="unique";},
		{ type = "TEXNAME"; name = "normalmapTexture";		submat = "bump0";				defaultvalue = "normalZ.png";                    				behavior="unique";},	
		{ type = "TEXNAME"; name = "heatmapTexture";   		submat = "filtercolor";			defaultvalue = "gray.png";										behavior="unique";  ifShaderDefine = "USE_HEATMAP"; },

		{ type = "PROPERTY"; name = "shaderDefine"; 		defaultvalue = "NODEFINITIONS";},
		{ type = "PROPERTY"; name = "visibleShelfPass"; 	defaultvalue = "1";},
		{ type = "PROPERTY"; name = "visibleFinalPass"; 	defaultvalue = "1";},
		{ type = "PROPERTY"; name = "castSurfaceDetails"; 	defaultvalue = "0";},
		{ type = "PROPERTY"; name = "castShadows"; 			defaultvalue = "1";},
		
		-- А ещё есть виртуальный параметр flirType, который можно назначить на модель. В преэкспорте материала этот параметр упихивается в стрим OPTIONS

		-- чтоб в атласе работало
		{ type = "PROPERTY"; name = "paletteTexture";   submat = "color0"; defaultvalue = "white.png"; preexport="paletteTexture";},
	},
},

-- VaryhouseLod4.1 
{
	name = "VaryHouseLod4.1";
	lsa3_material = "defmaterial";
	preexport = "VaryHouse4.1";
	postexport = "Structured";

	shaderdefines = 
	{
		'DOUBLESIDED',
		'OCCELATOR',
		'USE_COLOR_PALETTE',
		'ALPHA_TEST',
		'USE_NORMALMAP',
		'HEELING',
		'AFB_LIGHT_MODEL',
		'USE_HEATMAP',
		'FLIR_NO_INSTANCE_RANDOMNESS',	-- For tiling geometry, such as fences
	};

	structuredStream = true;
	streams = 
	{
		-- Вершины, нормали
		{ name = "P"; type = "FLOAT3"; },
		{ name = "N"; type = "FLOAT3"; },
		
		-- Текстурные координаты
		{ name = "diffuseTexCoord";   type = "FLOAT2"; invertV=true; assignedTotexture="color0"; 			defaultValue="0.5"; },
		{ name = "heatmapTexCoord";   type = "FLOAT2"; invertV=true; assignedTotexture="filtercolor"; 		defaultValue="0.5"; ifShaderDefine = "USE_HEATMAP"; },
		{ name = "specularTexCoord";  type = "FLOAT2"; invertV=true; assignedTotexture="ID_SH";  			defaultValue="0.5"; },
		{ name = "selfIllumTexCoord"; type = "FLOAT2"; invertV=true; assignedTotexture="selfillumination0"; defaultValue="0.5"; },
		{ name = "normalmapTexCoord"; type = "FLOAT2"; invertV=true; assignedTotexture="bump0"; 			defaultValue="0.5"; },
		{ name = "UV0tangent";  	  type = "FLOAT3"; invertV=true; tangentFor="normalmapTexCoord"; },		-- tangent для UV1
		{ name = "UV0binormal"; 	  type = "FLOAT3"; invertV=true; binormalFor="normalmapTexCoord";},		-- binormal для UV1
		
		-- параметры
		{ name = "occelatorPivot"; 	type = "FLOAT3";  preexport="occelatorPivot"; spaceType="worldSpacePoint";},	-- occelatorPivot
		{ name = "OPTIONS";     	type = "INT";     preexport="buildingOptions";},	-- Не переименовывать и не менять тип, тк в преэкспорт материала ссылается на этот стрим чтоб пропихнуть опции для flir
		{ name = "paletteV";		type = "INT1";	  preexport="paletteV"; terrainDefinition="USE_TERRAIN_PALETTE";},			-- V coordinate in palette
	},
	paramsources = 
	{
		-- текстуры
		{ type = "TEXNAME"; name = "diffuseTexture";   submat = "color0";														behavior="unique";},	
		{ type = "TEXNAME"; name = "heatmapTexture";   submat = "filtercolor";			defaultvalue = "gray.png";				behavior="unique"; ifShaderDefine = "USE_HEATMAP";},	
		{ type = "TEXNAME"; name = "specularTexture";  submat = "ID_SH"; 				defaultvalue = "default.mr.png";		behavior="unique";},
		{ type = "TEXNAME"; name = "selfIllumTexture"; submat = "selfillumination0"; 	defaultvalue = "black_greyAlpha.tif";   behavior="unique";},
		{ type = "TEXNAME"; name = "normalmapTexture"; submat = "bump0"; 				defaultvalue = "normalZ.png";			behavior="unique";},
		{ type = "TEXNAME"; name = "paletteTexture";   submat = "color1"; 				defaultvalue = "white.png"; },

		-- А ещё есть виртуальный параметр flirType, который можно назначить на модель. В преэкспорте материала этот параметр упихивается в стрим OPTIONS

		-- параметры
		{ type = "PROPERTY"; name = "shaderDefine"; defaultvalue = "NODEFINITIONS";},
		{ type = "PROPERTY"; name = "castShadows"; 	defaultvalue = "1";},
	},
},


-- Подложки под дома
{
	name = "VaryHouse4.1lightrend";
	box = "lighting";
	structuredStream = true;
	streams = 
	{
		{ name = "P";     type = "FLOAT3";},		-- Вершины
		{ name = "occlusionTexCoord";   type = "FLOAT2"; invertV=true; assignedTotexture="color0"; defaultValue="0.5"; },
		{ name = "selfillumTexCoord";   type = "FLOAT2"; invertV=true; assignedTotexture="selfillumination0"; defaultValue="0.5"; },
	},
	paramsources = 
	{
		{ type = "TEXNAME"; name = "occlusionTexture";	submat = "color0";				defaultvalue = "white.png";	behavior="unique";},
		{ type = "TEXNAME"; name = "selfillumTexture";	submat = "selfillumination0";	defaultvalue = "black.png"; behavior="unique";},
		{ type = "PROPERTY"; name = "shaderDefine"; defaultvalue = "NODEFINITIONS";},
	},
},


-- Wire4.1 
{
	name = "Wire4.1";
	lsa3_material = "defmaterial";
--	preexport = "OffsetMapChannel";
	postexport = "PostexportWire";

	streams = 
	{
		{ name = "P"; type = "FLOAT3";},		-- Вершины
	},
	paramsources = 
	{
		{ type = "PROPERTY"; name = "shaderDefine"; defaultvalue = "NODEFINITIONS";},
	},
},

-- HeatSpot5.1
{
	name = "HeatSpot5.1";

	streams = 
	{
		{ name = "P"; type = "FLOAT3"; },		-- Вершины
		{ name = "UV0"; type = "FLOAT2"; invertV = true; },
	},
	paramsources = 
	{
		{ type = "PROPERTY"; name = "shaderDefine"; defaultvalue = "NODEFINITIONS"; },
		{ type = "TEXNAME"; name = "heatmapTexture"; submat = "color0"; defaultvalue = "black.png"; requiredUvset = "UV0"; },
		
		{ type = "PROPERTY"; name = "routesMode"; setMaterialInt = 0; defaultvalue = "1";},	
	},
},

-- Деревья с инстансированием через compute
{
	name = "Speedtree5.1";
--	preexport = "Tree";

	shaderdefines = 
	{
		'DOUBLESIDED',
		'WINDDEFORMER',
		'BLEND_TO_SURFACE',
		'FLIR_AS_SURFACE'
	};

	postexport = "TreeInstancer5.1";				-- исправляет боксы для билбордов

	streams = 
	{
		{ name = "P";     			type = "FLOAT3"; },	-- Вершины
		{ name = "N";     			type = "FLOAT3"; },	-- Нормали
		{ name = "diffuseTexCoord"; type = "FLOAT2"; }, -- uv-координаты для текстур (diffuse, specular, normal)
		{ name = "lodTransition";  	type = "FLOAT4"; }, -- данные для схлопывания/развертывания полигонов при переходе между лодами
		{ name = "options";  		type = "INT1";   preexport = "buildingOptions";}, -- scale: X=1, Y=2, Z=4
		{ name = "geometryType"; 	type = "FLOAT1"; }, -- тип полигона
		{ name = "tangent"; 		type = "FLOAT3"; }, -- tangent
	},
	paramsources = 
	{
		-- Текстуры
		{ type = "TEXNAME"; name = "diffuseTexture"; 	submat = "color0"; defaultvalue = "gray.png"; 			  								},
		{ type = "TEXNAME"; name = "normalTexture";  	submat = "color1"; defaultvalue = "normalZ.png"; 		  								},
		{ type = "TEXNAME"; name = "AOTexture"; 	 	submat = "color6"; 										ifShaderDefine = "USE_3D_AO";	},
		{ type = "TEXNAME"; name = "paletteTexture";  	submat = "color7"; defaultvalue = "treesPalette.tif"; 	ifShaderDefine = "USE_PALETTE";	},
		{ type = "TEXNAME"; name = "baseColorTexture"; 	submat = "color8"; defaultvalue = "black.png"; 	 										},
		
		
		{ type = "PROPERTY"; name = "verticalBilboards"; setMaterialInt    = 6; defaultvalue = "1";       },	-- Количество вертикальных билбордов в атласе билбордов
		{ type = "PROPERTY"; name = "fade2bilboard"; 	 setMaterialFloat  = 0; defaultvalue = "0.0";     },	
		{ type = "PROPERTY"; name = "bilboardData"; 	required = false; structured = true; },					-- Буфер с координатами в атласе билбордов
		
		{ type = "PROPERTY"; name = "windFlex"; 		 setMaterialFloat  = 1; defaultvalue = "0.01";    },	
		{ type = "PROPERTY"; name = "gamma"; 			 setMaterialFloat  = 2; defaultvalue = "1.0";     },		

		-- Текстурные координаты для AO
		{ type = "PROPERTY"; name = "AOMatrix"; 	setMaterialMatrix = 0; defaultvalue = "1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1"; ifShaderDefine = "USE_3D_AO";},
		
		-- Строка палитры. Каждый меш дерева независимо от своего типа может содержать вертексы других типов, которые надо красить
		{ type = "PROPERTY"; name = "paletteVBranches";	    		setMaterialInt = 0;		defaultvalue = "0";},
		{ type = "PROPERTY"; name = "paletteVFronds";	    		setMaterialInt = 1;		defaultvalue = "0";},
		{ type = "PROPERTY"; name = "paletteVLeafs";	    		setMaterialInt = 2;		defaultvalue = "0";},
		{ type = "PROPERTY"; name = "paletteVFacingLeafs";	   		setMaterialInt = 3;		defaultvalue = "0";},
		{ type = "PROPERTY"; name = "paletteVBillboardVertical";	setMaterialInt = 4;		defaultvalue = "0";},
		{ type = "PROPERTY"; name = "paletteVBillboardHorizontal";	setMaterialInt = 5;		defaultvalue = "0";},

		-- Старый способ - храним бейз колор в mps. Не поддерживает сезоны
		{ type = "PROPERTY"; name = "baseColorBranches";			setMaterialFloat4 = 0;	defaultvalue = "0,0,0,0";},	
		{ type = "PROPERTY"; name = "baseColorFronds";				setMaterialFloat4 = 1;	defaultvalue = "0,0,0,0";},
		{ type = "PROPERTY"; name = "baseColorLeafs";				setMaterialFloat4 = 2;	defaultvalue = "0,0,0,0";},
		{ type = "PROPERTY"; name = "baseColorFacingLeafs";			setMaterialFloat4 = 3;	defaultvalue = "0,0,0,0";},
		{ type = "PROPERTY"; name = "baseColorBillboardVertical";	setMaterialFloat4 = 4;	defaultvalue = "0,0,0,0";},
		{ type = "PROPERTY"; name = "baseColorBillboardHorizontal";	setMaterialFloat4 = 5;	defaultvalue = "0,0,0,0";},
		
		-- Индекс бейз колора в текстуре бейз колора дерева. Нужно для поддержки сезонов
		{ type = "PROPERTY"; name = "baseColorIndexBranches";				setMaterialInt = 7;		defaultvalue = "0";},	
		{ type = "PROPERTY"; name = "baseColorIndexFronds";					setMaterialInt = 8;		defaultvalue = "0";},
		{ type = "PROPERTY"; name = "baseColorIndexLeafs";					setMaterialInt = 9;		defaultvalue = "0";},
		{ type = "PROPERTY"; name = "baseColorIndexFacingLeafs";			setMaterialInt = 10;	defaultvalue = "0";},
		{ type = "PROPERTY"; name = "baseColorIndexBillboardVertical";		setMaterialInt = 11;	defaultvalue = "0";},
		{ type = "PROPERTY"; name = "baseColorIndexBillboardHorizontal";	setMaterialInt = 12;	defaultvalue = "0";},
		
		-- shaderDefine
		{ type = "PROPERTY"; name = "shaderDefine"; defaultvalue = "NODEFINITIONS";},
	},
},
-- Дома
{
	name = "VaryHouse5.1";
	lsa3_material = "defmaterial";
	
	shaderdefines = 
	{
		'DOUBLESIDED',
		'OCCELATOR',
		'HEELING',
		'USE_NORMALMAP',
		'AFB_LIGHT_MODEL',			-- todo: выпилить
		'USE_PALETTE',
		'USE_PALETTE_ROOM_LIGHT',
		'USE_COLOR',
		'USE_HEATMAP',
		'USE_CUBEMAP_OPACITY',
		'FLIR_NO_INSTANCE_RANDOMNESS',	-- For tiling geometry, such as fences
	};
	structuredStream = true;
	preexport = "windowsRooms;VaryHouse5.1"; -- преэкспорт windowsRooms выполняется для мешек на которых установлен дефайн USE_CUBEMAP_OPACITY. windowsRooms выполняет триангуляцию меша, разбиение меша на изолированные меши и дублирование исходного меша, но без флага USE_CUBEMAP_OPACITY
	postexport = "Structured";
	box = "main";
	streams = 
	{
		{ name = "P";			type = "FLOAT3";},		-- Вершины
		{ name = "N";			type = "FLOAT3";},		-- Нормали
		
		{ name = "UV0";			type = "FLOAT2";		invertV=true; defaultValue="0.5"; ifShaderDefine = "USE_COLOR"; },				-- uv-координаты для surfaceColorTexture
		{ name = "UV1";			type = "FLOAT2";		invertV=true; defaultValue="0.5"; ifShaderDefine = "!USE_CUBEMAP_OPACITY"; },		-- uv-координаты для fabricTexture
		{ name = "UV1";			type = "INT1"; spaceType = "worldspacepoint"; assignedTotexture="color0"; defaultValue="0.5"; setMaterialManifold = 0; ifShaderDefine = "USE_CUBEMAP_OPACITY"; },
		{ name = "UV1tangent";  type = "FLOAT3";		invertV=true; tangentFor="UV1"; ifShaderDefine = "!USE_CUBEMAP_OPACITY"; },			-- tangent для UV1
		{ name = "UV1binormal"; type = "FLOAT3";		invertV=true; binormalFor="UV1"; ifShaderDefine = "!USE_CUBEMAP_OPACITY"; },			-- binormal для UV1
		{ name = "UV2";			type = "FLOAT2";		invertV=true; defaultValue="0.5"; ifShaderDefine = "!USE_CUBEMAP_OPACITY"; },		-- uv-координаты для decalTexture
		{ name = "UV2";			type = "INT1"; spaceType = "worldspacepoint"; assignedTotexture="color1"; defaultValue="0.5"; setMaterialManifold = 1; ifShaderDefine = "USE_CUBEMAP_OPACITY"; },
		{ name = "UV3";			type = "FLOAT2";		invertV=true; defaultValue="0.5"; },		-- uv-координаты для occlusionTexture
		{ name = "UV4";			type = "FLOAT2";		invertV=true; defaultValue="0.5"; },		-- uv-координаты для selfillumTexture
		{ name = "normalMapTexCoord"; type = "FLOAT2";	invertV=true; assignedTotexture="bump0"; 			defaultValue="0.5"; ifShaderDefine = "!USE_CUBEMAP_OPACITY"; },	-- uv-координаты для normalmapTexture
		{ name = "normalMapTexCoord"; type = "INT1"; spaceType = "worldspacepoint"; assignTotexture="bump0"; defaultValue="0.5"; setMaterialManifold = 2; ifShaderDefine = "USE_CUBEMAP_OPACITY"; },
		{ name = "heatmapTexCoord";   type = "FLOAT2"; 	invertV=true; assignedTotexture="filtercolor"; 		defaultValue="0.5"; ifShaderDefine = "USE_HEATMAP"; },	-- uv-координаты для heatmapTexture
		{ name = "windowTexCoord";	  type = "INT1"; spaceType = "worldspacepoint"; assignedTotexture="opacity";			defaultValue="0.5";	ifShaderDefine = "USE_CUBEMAP_OPACITY"; setMaterialManifold = 3; preexport="windowTexCoord";},	-- uv-координаты для маппинга окна на грань кубической комнаты с длиной ребра равной единице; преэкспорт windowTexCoord делает рандомный сдвиг всех текстурных координат windowTexCoord на целое число единиц вдоль каждой из осей u и v
	},
	paramsources = 
	{
		{ type = "TEXNAME"; name = "surfaceColorTexture";	submat = "color4";				defaultvalue = "white.png";					requiredUvset="UV0"; 		behavior="unique"; ifShaderDefine = "USE_COLOR";},
		{ type = "TEXNAME"; name = "occlusionTexture";		submat = "color2";				defaultvalue = "defaultVaryhouseAO.png";	requiredUvset="UV3";		behavior="unique";},
		{ type = "TEXNAME"; name = "selfillumTexture";		submat = "selfillumination0";	defaultvalue = "black.png";					requiredUvset="UV4";		behavior="unique";},
		{ type = "TEXNAME"; name = "normalmapTexture";		submat = "bump0";				defaultvalue = "normalZ.png";              								behavior="unique";},
		{ type = "TEXNAME"; name = "paletteTexture";		submat = "color3";				defaultvalue = "fabricPalette.tif"; },
		{ type = "TEXNAME"; name = "heatmapTexture";   		submat = "filtercolor";			defaultvalue = "gray.png";												behavior="unique"; ifShaderDefine = "USE_HEATMAP";},

		-- Fabrics
		{ type = "TEXNAME"; setMaterialTextureIndex = 0; name = "fabricTextureArray";					submat = "color0";	defaultvalue = "fabric.default.tif";  requiredUvset="UV1";  changeExtension=".tif"; 		texturearray="!fabric";  setFabricDataToMaterialFloat4 = 0;},
		{ type = "TEXNAME"; setMaterialTextureIndex = 1; name = "fabricNormalmapTextureArray";			submat = "color0";	defaultvalue = "fabric.default.tif";  requiredUvset="UV1";  changeExtension=".nm.tif"; 		texturearray="!fabric.nm";},
		{ type = "TEXNAME"; setMaterialTextureIndex = 2; name = "fabricMetalnessRoughnessTextureArray";	submat = "color0";	defaultvalue = "fabric.default.tif";  requiredUvset="UV1";  changeExtension=".mr.tif"; 		texturearray="!fabric.mr";},
		{ type = "TEXNAME"; setMaterialTextureIndex = 3; name = "fabricSelfillumTextureArray";			submat = "color0";	defaultvalue = "fabric.default.tif";  requiredUvset="UV1";  changeExtension=".si.tif"; 		texturearray="!fabric.si";},

		-- Decals
		{ type = "TEXNAME"; setMaterialTextureIndex = 4; name = "fabricTextureArray";					submat = "color1";	defaultvalue = "fabric.default.tif";  requiredUvset="UV2";  changeExtension=".tif"; 		texturearray="!fabric";},
		{ type = "TEXNAME"; setMaterialTextureIndex = 5; name = "fabricNormalmapTextureArray";			submat = "color1";	defaultvalue = "fabric.default.tif";  requiredUvset="UV2";  changeExtension=".nm.tif"; 		texturearray="!fabric.nm";},
		{ type = "TEXNAME"; setMaterialTextureIndex = 6; name = "fabricMetalnessRoughnessTextureArray";	submat = "color1";	defaultvalue = "fabric.default.tif";  requiredUvset="UV2";  changeExtension=".mr.tif"; 		texturearray="!fabric.mr";},
		
		{ type = "TEXNAME";	setMaterialTextureIndex = 7; name = "cubemapTextureArray";					submat = "opacity";	defaultvalue = "room1.dds";	texturearray="!rooms"; preexport="cubemapTextureArray"; ifShaderDefine = "USE_CUBEMAP_OPACITY"; },
		
		{ type = "PROPERTY"; name = "shaderDefine"; defaultvalue = "NODEFINITIONS";},
		
		{ type = "PROPERTY"; name = "OPTIONS";      setMaterialInt = 0;    defaultvalue = "0";},		
		{ type = "PROPERTY"; name = "paletteV";	    setMaterialInt = 1;	   defaultvalue = "0";	 preexport="paletteV2";},		-- V coordinate in palette
		{ type = "PROPERTY"; name = "colorIndex";   setMaterialInt = 2;    defaultvalue = "2";},
		{ type = "PROPERTY"; name = "flirType"; 	setMaterialInt = 3;  						 preexport="buildFlirTypeBuilding";},
		{ type = "PROPERTY"; name = "roomLightPaletteV";	setMaterialInt = 4;	   defaultvalue = "0";	 preexport="roomLightPaletteV";},		-- V coordinate in palette

		{ type = "PROPERTY"; name = "occelatorPivot"; setMaterialFloat = 0; defaultvalue = "0";  preexport="occelatorPivot2";},	-- occelatorPivot
		{ type = "PROPERTY"; name = "flirLuminosity"; setMaterialFloat = 1; defaultvalue = "0";  preexport="flirLuminosity2";},
		{ type = "PROPERTY"; name = "occelatorPeriod"; setMaterialFloat = 2; defaultvalue = "0";}, -- in seconds
		
		{ type = "PROPERTY"; name = "fabricUVrect";	setMaterialFloat4 = 1;	ifShaderDefine = "USE_CUBEMAP_OPACITY"; preexport="fabricUVrect"; }, -- fabricUVrect
	},
},


-- VaryhouseLod5.1 
{
	name = "VaryHouseLod5.1";
	preexport = "VaryHouse5.1";
	postexport = "Structured";
	lsa3_material = "defmaterial";

	shaderdefines = 
	{
		'DOUBLESIDED',
		'OCCELATOR',
		'HEELING',
		'ALPHA_TEST',
		'USE_NORMALMAP',
		'AFB_LIGHT_MODEL',			-- todo: ��������
		'USE_PALETTE',
		'USE_COLOR',
		'USE_HEATMAP',
		'FLIR_NO_INSTANCE_RANDOMNESS',	-- For tiling geometry, such as fences
	};

	structuredStream = true;
	streams = 
	{
		-- �������, �������
		{ name = "P"; type = "FLOAT3"; },
		{ name = "N"; type = "FLOAT3"; },
		
		-- ���������� ����������
		{ name = "diffuseTexCoord";   	type = "FLOAT2"; invertV = true; assignedTotexture="color0"; 			defaultValue="0.5"; },
		{ name = "heatmapTexCoord";   	type = "FLOAT2"; invertV = true; assignedTotexture="filtercolor"; 		defaultValue="0.5"; ifShaderDefine = "USE_HEATMAP";},
		{ name = "specularTexCoord";  	type = "FLOAT2"; invertV = true; assignedTotexture="ID_SH";  			defaultValue="0.5"; },
		{ name = "selfIllumTexCoord"; 	type = "FLOAT2"; invertV = true; assignedTotexture="selfillumination0"; defaultValue="0.5"; },
		{ name = "normalmapTexCoord"; 	type = "FLOAT2"; invertV = true; assignedTotexture="bump0"; 			defaultValue="0.5"; },
		{ name = "UV0tangent";  		type = "FLOAT3"; invertV = true; tangentFor="normalmapTexCoord"; },		-- tangent ��� normalmapTexCoord
		{ name = "UV0binormal"; 		type = "FLOAT3"; invertV = true; binormalFor="normalmapTexCoord";},		-- binormal ��� normalmapTexCoord
		
		-- ���������
		{ name = "paletteV";			type = "INT1";	defaultValue="-1"; preexport="paletteV3"; 		ifShaderDefine = "!USE_COLOR"; },
		{ name = "baseColorPacked";		type = "INT1";	defaultValue="0";  preexport="baseColorPacked";	ifShaderDefine = "!USE_COLOR"; },
	},
	paramsources = 
	{
		-- ��������
		{ type = "TEXNAME"; name = "diffuseTexture";   submat = "color0";														behavior="unique";},
		{ type = "TEXNAME"; name = "heatmapTexture";   submat = "filtercolor";			defaultvalue = "gray.png";				behavior="unique"; ifShaderDefine = "USE_HEATMAP";},	
		{ type = "TEXNAME"; name = "specularTexture";  submat = "ID_SH"; 				defaultvalue = "black.png";				behavior="unique";},
		{ type = "TEXNAME"; name = "selfIllumTexture"; submat = "selfillumination0"; 	defaultvalue = "black_greyAlpha.tif";   behavior="unique";},
		{ type = "TEXNAME"; name = "normalmapTexture"; submat = "bump0"; 				defaultvalue = "normalZ.png";			behavior="unique";},
		{ type = "TEXNAME"; name = "paletteTexture";   submat = "color1";				defaultvalue = "fabricPalette.tif"; },

		-- ���������
		{ type = "PROPERTY"; name = "OPTIONS";      setMaterialInt = 0;    defaultvalue = "512";},		
		{ type = "PROPERTY"; name = "colorIndex";   setMaterialInt = 1;    defaultvalue = "2";},
		{ type = "PROPERTY"; name = "flirType"; 	setMaterialInt = 2;   						preexport="buildFlirTypeBuilding";},
		{ type = "PROPERTY"; name = "paletteV"; 	setMaterialInt = 3;    defaultvalue = "-1";	ifShaderDefine = "USE_COLOR";},
		{ type = "PROPERTY"; name = "occelatorPivot"; setMaterialFloat = 0; defaultvalue = "0";  preexport="occelatorPivot2";},	-- occelatorPivot
		{ type = "PROPERTY"; name = "occelatorPeriod"; setMaterialFloat = 1; defaultvalue = "0";}, -- in seconds
		{ type = "PROPERTY"; name = "shaderDefine"; defaultvalue = "NODEFINITIONS";},
	},
},

-- Wire5.1 
{
	name = "Wire5.1";
	lsa3_material = "defmaterial";
--	preexport = "OffsetMapChannel";
	postexport = "PostexportWire";

	streams = 
	{
		{ name = "P"; type = "FLOAT3";},		-- Вершины
	},
	paramsources = 
	{
		{ type = "PROPERTY"; name = "shaderDefine"; defaultvalue = "NODEFINITIONS";},
	},
},

-- RasterChart
{
	name = "RasterChart";
	lsa3_material = "defmaterial";

	streams = 
	{
		{ name = "P"; type = "FLOAT3";},		-- Вершины
		{ name = "colorTexCoord"; type = "FLOAT2"; assignedTotexture="color0"; invertV=true; },
	},
	paramsources = 
	{
		{ name = "colorTexture"; type = "TEXNAME"; submat = "color0"; },
		{ type = "PROPERTY"; name = "shaderDefine"; defaultvalue = "NODEFINITIONS";},
	},
},


-- инстансер для птиц через Compute 
{
	name = "BirdInstancer4.1";
	preexport = "PointInstancer";
	requireServices = "references";
	streams = 
	{
		{ name = "P";     type = "FLOAT3";},		-- Вершины
		{ name = "AXISX"; type = "FLOAT2";},		-- AxisX
		{ name = "SEED";  type = "FLOAT1";},		-- seed
	},
	paramsources = 
	{
		{ type = "PROPERTY"; name = "levels"; defaultvalue = "012345";},
		{ type = "PROPERTY"; name = "reference"; defaultvalue = "";},
		{ type = "PROPERTY"; name = "maxlevel"; defaultvalue = "0";},
		{ type = "PROPERTY"; name = "shaderDefine"; defaultvalue = "STANDARTSTRUCTURE";},
	},
},


-- инстансер через Compute 
{
	name = "HwInstancer5.0";
	preexport = "PointInstancer";
	requireServices = "references";
	streams = 
	{
		{ name = "TYPE";  type = "INT1";},			-- Тип объекта
		{ name = "P";     type = "FLOAT3";},		-- Вершины
		{ name = "AXISX"; type = "FLOAT2";},		-- AxisX
		{ name = "SEED";  type = "FLOAT1";},		-- seed
		{ name = "OPTIONS";  type = "INT1";},		-- опции (1-renderFinal, 2-renderShadows, 4-renderReflections)
	},
	paramsources = 
	{
		{ type = "PROPERTY"; name = "shaderDefine"; defaultvalue = "NODEFINITIONS";},
	},
},


-- Improvement over hwInstancer5.0
-- Allows for arbitary rotations (pitch and roll were not included before)
-- Utilized bitpacking. Example: There are 25M instances on Persian Gulf. 
-- Every extra uint or float in the following structure makes terrain size larger by 100 megabytes
-- Packing data into bitfields allows to shove more information into same size
-- Impact on perfomance is minimal
{
	name = "HwInstancer5.2";
	preexport = "PointInstancer";
	requireServices = "references";
	streams = 
	{
		{ name = "P";  			   type = "FLOAT3"; },	-- Position 
		{ name = "TYPE_OPTIONS";   type = "INT";    },	-- 16 bit type, 16 bit options 
		{ name = "SEED_SCALE";     type = "INT";    },	-- 16 bit seed, uniform distribution [0; 1], 16 bit half precision float scale 
		{ name = "AXIS";  	 	   type = "INT3";   },	-- 16 bit per axis projection, uniform distribution [-1; 1]. 48 bits per axis. Axis are XZ 
	},	
	paramsources = 
	{
		{ type = "PROPERTY"; name = "shaderDefine"; defaultvalue = "NODEFINITIONS";},
	},
},

-- Surface details 2
{
	name = "SurfaceDetail4.1";
	streams = 
	{
		{ name = "P";     type = "FLOAT3";},		-- Вершины
		{ name = "XZ";    type = "FLOAT4";},		-- поворот/скейл
		{ name = "SEED";  type = "FLOAT1"; preexport="generateSeed"},		-- seed
	},
	paramsources = 
	{
		--{ type = "TEXNAME"; name = "colorTexture"; submat = "color";},
		{ type = "PROPERTY"; name = "reference"; defaultvalue = "";},
		{ type = "PROPERTY"; name = "splatlayer"; defaultvalue = "";},
	},
},
-- Surface details 5
{
	name = "SurfaceDetail5.0";
	streams = 
	{
		{ name = "P";     type = "FLOAT3";},		-- Вершины
		{ name = "AXISX";    type = "FLOAT2";},		-- поворот/скейл
		{ name = "SEED";  type = "FLOAT1"; preexport="generateSeed"},		-- seed
		{ name = "reference";  type = "INT1";}, -- типы сурфейс детейлов
		{ name = "splatlayer";  type = "INT1";},    -- splatlayers
	},
	paramsources = 
	{
		{ type = "PROPERTY"; name = "splatlayers"; defaultvalue = "";},
	},
},
--- OldRunway 5.1
--- �������� ���������
{
	name = "OldRunway5.1";
	reflectionReceiver = true;

	preexport = "preexport5.0;parametricUVW";
	postexport = "postexport5.0";
	sharedMaterial = "Surface5.0shared";

	shaderdefines = 
	{
		'APPLY_AUTOMAPPED_OPACITY',
		'APPLY_AUTOMAPPED_DIFFUSE',
		'BLEND_BY_OVERLAY_ALPHA',
		'USE_CAVITY_FROM_SPEC_B',
	},
	
	paramsources = 
	{
		-- Diffuse textures
		{ type = "TEXNAME"; name = "fabricTexture";			submat = "color0";	setMaterialTextureIndex = 0; requiredUvset="UV0"; defaultvalue = "fabric.default.tif";		texturearray="!fabric";},
		{ type = "TEXNAME"; name = "fabricNormalTexture"; 	submat = "bump0";	setMaterialTextureIndex = 1; requiredUvset="UV0"; defaultvalue = "fabric.default.nm.tif";	texturearray="!fabric.nm";},
		{ type = "TEXNAME"; name = "specularTexture";		submat = "ID_SH"; 	setMaterialTextureIndex = 2; requiredUvset="UV0"; defaultvalue = "fabric.default.spec.tif";	texturearray="!fabric.spec";},

		-- crackMask
		{ type = "TEXNAME"; name = "cracksMaskTexture";		submat = "color2";	setMaterialTextureIndex = 3; requiredUvset="UV3"; defaultvalue = "cracksMask.default.tif";	texturearray="!cracksMask";},
		{ type = "TEXNAME"; name = "cracksMaskNormalTexture";submat = "bump1";	setMaterialTextureIndex = 4; requiredUvset="UV3"; defaultvalue = "cracksMask.default.nm.tif";	texturearray="!cracksMask.nm";},

		-- others
		{ type = "TEXNAME"; name = "decalTexture";		submat = "color1";		setMaterialTextureIndex = 5; defaultvalue = "decal.default.tif";		texturearray="!decal";},
		{ type = "TEXNAME"; name = "dirtMaskTexture";	submat = "color3";		setMaterialTextureIndex = 6; defaultvalue = "dirtMask.default.tif";		texturearray="!dirtMask";},
		{ type = "TEXNAME"; name = "borderTexture";		submat = "opacity0"; 	setMaterialTextureIndex = 7; defaultvalue = "fabric.default.tif";			texturearray="!fabric";},
		{ type = "TEXNAME"; name = "overlayTexture";	submat = "color4";									 defaultvalue = "gray.png";					behavior="unique";},

		{ name = "colorIndex"; setMaterialInt = 0; type = "PROPERTY"; defaultvalue = "1";},
		{ type = "PROPERTY"; name = "shaderDefine"; defaultvalue = "NODEFINITIONS";},
	};

	streams = 
	{
		-- ��� NEXTLOD_BLEDING
		{ name = "baseIndex"; type = "INT1"; },

		{ name = "parametricUVW";   type = "FLOAT3"; },
		{ name = "parametricTangent";   type = "FLOAT3"; },
		{ name = "parametricBinormal";   type = "FLOAT3"; },

		-- UV manifolds
		{ name = "fabric";		type = "INT1"; assignedTotexture="color0"; setMaterialManifold=0; },
		{ name = "cracksMask";	type = "INT1"; assignedTotexture="color2"; setMaterialManifold=1; },
		{ name = "decal";		type = "INT1"; assignedTotexture="color1"; setMaterialManifold=2; },
		{ name = "dirtMask";	type = "INT1"; assignedTotexture="color3"; setMaterialManifold=3; },
		{ name = "overlay";		type = "INT1"; assignedTotexture="color4"; setMaterialManifold=4; },

		-- borderUV
		{ name = "borderUV"; type = "FLOAT2"; invertV=true; assignedTotexture="opacity0";
							 ifShaderDefine="APPLY_AUTOMAPPED_OPACITY;APPLY_AUTOMAPPED_DIFFUSE"},	
	};
},


--- RunwayOnlay 5.1
--- �������� �������� ���������
{
	name = "OldRunwayOnlay5.1";
	lsa3_material = "defmaterial";
	preexport = "parametricUVW";
--	postexport = "Structured";
	paramsources = 
	{
		-- Diffuse texture
		{ type = "TEXNAME";		name = "fabricTexture";			setMaterialTextureIndex = 0; submat = "color0";	defaultvalue = "fabric.default.tif";		texturearray="!fabric";},
		-- Normal map texture
		{ type = "TEXNAME";		name = "fabricNormalTexture"; 	setMaterialTextureIndex = 1; submat = "bump0";	defaultvalue = "fabric.default.nm.tif";		texturearray="!fabric.nm";},
		-- Specular map texture
		{ type = "TEXNAME";		name = "specularTexture";		setMaterialTextureIndex = 2; submat = "ID_SH"; 	defaultvalue = "fabric.default.spec.tif";	texturearray="!fabric.spec";},
		
		{ type = "PROPERTY";	name = "colorIndex"; defaultvalue = "14";},
	};
	streams = 
	{
		{ name = "P";			type = "FLOAT3";},			-- �������
		{ name = "N";			type = "FLOAT3";},			-- �������

		-- UVW
		{ name = "parametricUVW";   type = "FLOAT3"; },
		{ name = "parametricTangent";   type = "FLOAT3"; },
		{ name = "parametricBinormal";   type = "FLOAT3"; },

		-- diffuse
		{ name = "fabricUV";		type = "INT1"; assignedTotexture="color0";	setMaterialManifold=0; },	-- uv-���������� ��� fabricTexture 
		-- normals
		{ name = "fabricNormalUV";	type = "INT1"; assignedTotexture="bump0";	setMaterialManifold=1; },	-- uv-���������� ��� fabricNormalTexture
		-- specular
		{ name = "specularUV";		type = "INT1"; assignedTotexture="ID_SH";	setMaterialManifold=2; },	-- uv-���������� ��� specularTexture
	};
},

-- OldSurfaceVaryHouse5.1
{
	-- TODO
	name = "OldSurfaceVaryHouse5.1";
	lsa3_material = "defmaterial";
	
	shaderdefines = 
	{
	};
	--structuredStream = false;
	preexport = "OffsetMapChannelIfNo;preexport5.0;parametricUVW;";
	postexport = "postexport5.0";
	sharedMaterial = "Surface5.0shared";
	streams = 
	{
		{ name = "baseIndex"; 			type = "INT1"; },

		{ name = "N"; type = "FLOAT3"; preexport="normals"; ifShaderDefine="HACK_ASSETS_NORMALS";},

		{ name = "parametricUVW"; 		type = "FLOAT3"; ifShaderDefine = "!USE_UVW_MANIFOLD"},
		{ name = "parametricTangent";   type = "FLOAT3"; ifShaderDefine = "!USE_UVW_MANIFOLD"}, -- tangent для UV1
		{ name = "parametricBinormal";	type = "FLOAT3"; ifShaderDefine = "!USE_UVW_MANIFOLD"}, -- binormal для UV1
		{ name = "parametricUVW";		type = "INT1";   sharedBufferType = "MeshAssetManifold5"; ifShaderDefine = "USE_UVW_MANIFOLD"; },
		
		{ name = "surfaceColorTexCoord"; type = "INT1"; assignedTotexture = "color0"; defaultCopyFrom = "color0"; setMaterialManifold = 0; }, -- uv-координаты для surfaceColorTexture
		{ name = "fabricTexCoord"; 		 type = "INT1"; assignedTotexture = "color1"; defaultCopyFrom = "color0"; setMaterialManifold = 1; }, -- uv-координаты для fabricTexture	
		{ name = "decalTexCoord"; 		 type = "INT1"; assignedTotexture = "color2"; defaultCopyFrom = "color0"; setMaterialManifold = 2; }, -- uv-координаты для decalTexture
		{ name = "occlusionTexCoord";	 type = "INT1"; assignedTotexture = "color3"; defaultCopyFrom = "color0"; setMaterialManifold = 3; }, -- uv-координаты для occlusionTexture
		{ name = "selfillumTexCoord";	 type = "INT1"; assignedTotexture = "selfillumination0"; defaultCopyFrom = "color0"; setMaterialManifold = 4; }, -- uv-координаты для selfillumTexture
		{ name = "normalmapTexCoord";	 type = "INT1"; assignedTotexture = "bump0";  defaultCopyFrom = "color0"; setMaterialManifold = 5; }, -- uv-координаты для bump0
		
		{ name = "offset"; 		type = "FLOAT1"; required=true; },
	},
	paramsources = 
	{
		{ type = "TEXNAME"; name = "surfaceColorTexture";	submat = "color0";				defaultvalue = "white.png";	requiredUvset="UV0"; behavior="unique";},
		{ type = "TEXNAME"; name = "occlusionTexture";		submat = "color3";				defaultvalue = "defaultVaryhouseAO.png";	requiredUvset="UV3"; behavior="unique";},
		{ type = "TEXNAME"; name = "selfillumTexture";		submat = "selfillumination0";	defaultvalue = "black.png";	requiredUvset="UV4"; behavior="unique";},
		{ type = "TEXNAME"; name = "normalmapTexture";		submat = "bump0";				defaultvalue = "normalZ.png";                    behavior="unique";},

		{ type = "TEXNAME"; setMaterialTextureIndex = 0; name = "fabricTextureArray";					submat = "color1";	defaultvalue = "fabric.default.tif";	requiredUvset="UV1"; changeExtension=".tif"; texturearray="!fabric";},
		{ type = "TEXNAME"; setMaterialTextureIndex = 1; name = "fabricNormalmapTextureArray";			submat = "color1";	defaultvalue = "fabric.default.tif";	requiredUvset="UV1"; changeExtension=".nm.tif"; texturearray="!fabric.nm";},
		{ type = "TEXNAME"; setMaterialTextureIndex = 2; name = "fabricSpecularComponentsTextureArray";	submat = "color1";	defaultvalue = "fabric.default.tif";	requiredUvset="UV1"; changeExtension=".spec.tif"; texturearray="!fabric.spec";},
		{ type = "TEXNAME"; setMaterialTextureIndex = 3; name = "fabricSelfillumTextureArray";			submat = "color1";	defaultvalue = "fabric.default.tif";	requiredUvset="UV1"; changeExtension=".si.tif"; texturearray="!fabric.si";},
		{ type = "TEXNAME"; setMaterialTextureIndex = 4; name = "decalTextureArray";					submat = "color2";	defaultvalue = "decal.default.tif";	requiredUvset="UV2"; texturearray="!decal";},

		{ type = "PROPERTY"; name = "shaderDefine"; defaultvalue = "NODEFINITIONS";},
		
		-- чтоб в атласе работало
		{ type = "PROPERTY"; name = "paletteTexture";   submat = "color0"; defaultvalue = "white.png"; preexport="paletteTexture";},
		
		{ type = "PROPERTY"; name = "colorIndex";	setMaterialInt = 0;    defaultvalue = "2";},	
		{ type = "PROPERTY"; name = "OPTIONS";      setMaterialInt = 1;    defaultvalue = "0";	 preexport="buildingOptions2";},		
		{ type = "PROPERTY"; name = "paletteV";	    setMaterialInt = 2;	   defaultvalue = "0";	 preexport="paletteV2"; terrainDefinition="USE_TERRAIN_PALETTE";},			-- V coordinate in palette
		
		{ type = "PROPERTY"; name = "flirType";     setMaterialInt = 3;    preexport="buildFlirType";},	
	},
},
}

