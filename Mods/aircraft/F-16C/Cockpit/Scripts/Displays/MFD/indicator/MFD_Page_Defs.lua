dofile(LockOn_Options.script_path.."Displays/MFD/indicator/MFD_Tools.lua")
dofile(LockOn_Options.script_path.."Displays/Common/indicator/Units.lua")
dofile(LockOn_Options.script_path.."symbology_defs.lua")

-- Scale
SetCustomScale(PXtoIn() * InToMeter) -- Display Increments

collimated			= false

stroke_font			= readParameter("MFD_Font_Name")
stroke_material		= readParameter("MFD_Material_Name")

if override_materials == true then
	default_material	= override_material
	stroke_font			= override_font
else
	default_material	= stroke_material
end

DEFAULT_LEVEL			= readParameter("MFD_init_DEFAULT_LEVEL")

-- Fonts

-- WARNING!
-- Do not define your own sizes!

-- F-16 MFD PX (pixels)
glyphHeight_8_12			= 12
glyphWidth_8_12				= 8
fontScaleY_8_12				= glyphHeight_8_12 * GetScale()
fontScaleX_8_12				= glyphWidth_8_12 * GetScale()
fontIntercharDflt_8_12		= 2 * GetScale()
fontInterlineDflt_8_12		= 3 * GetScale()

glyphHeight_10_14			= 14
glyphWidth_10_14			= 10
fontScaleY_10_14			= glyphHeight_10_14 * GetScale()
fontScaleX_10_14			= glyphWidth_10_14 * GetScale()
fontIntercharDflt_10_14		= 4 * GetScale()
fontInterlineDflt_10_14		= 4 * GetScale()

glyphHeight_14_18			= 18
glyphWidth_14_18			= 14
fontScaleY_14_18			= glyphHeight_14_18 * GetScale()
fontScaleX_14_18			= glyphWidth_14_18 * GetScale()
fontIntercharDflt_14_18		= 7 * GetScale()
fontInterlineDflt_14_18		= 7 * GetScale()

glyphHeight_20_28			= 28
glyphWidth_20_28			= 20
fontScaleY_20_28			= glyphHeight_20_28 * GetScale()
fontScaleX_20_28			= glyphWidth_20_28 * GetScale()
fontIntercharDflt_20_28		= 8 * GetScale()
fontInterlineDflt_20_28		= 8 * GetScale()

glyphHeight_28_36			= 36
glyphWidth_28_36			= 28
fontScaleY_28_36			= glyphHeight_28_36 * GetScale()
fontScaleX_28_36			= glyphWidth_28_36 * GetScale()
fontIntercharDflt_28_36		= 10 * GetScale()
fontInterlineDflt_28_36		= 10 * GetScale()

glyphHeight_6_9				= 9
glyphWidth_6_9				= 6
fontScaleY_6_9				= glyphHeight_6_9 * GetScale()
fontScaleX_6_9				= glyphWidth_6_9 * GetScale()
fontIntercharDflt_6_9		= 2 * GetScale()
fontInterlineDflt_6_9		= 3 * GetScale()

STROKE_FNT_DFLT_8_12		= 1
STROKE_FNT_DFLT_10_14		= 2
STROKE_FNT_DFLT_14_18		= 3
STROKE_FNT_DFLT_20_28		= 4
STROKE_FNT_DFLT_28_36		= 5
STROKE_FNT_DFLT_6_9			= 6

stringdefs[STROKE_FNT_DFLT_8_12]		= {fontScaleY_8_12,  fontScaleX_8_12,  fontIntercharDflt_8_12,  fontInterlineDflt_8_12}
stringdefs[STROKE_FNT_DFLT_10_14]		= {fontScaleY_10_14, fontScaleX_10_14, fontIntercharDflt_10_14, fontInterlineDflt_10_14}
stringdefs[STROKE_FNT_DFLT_14_18]		= {fontScaleY_14_18, fontScaleX_14_18, fontIntercharDflt_14_18, fontInterlineDflt_14_18}
stringdefs[STROKE_FNT_DFLT_20_28]		= {fontScaleY_20_28, fontScaleX_20_28, fontIntercharDflt_20_28, fontInterlineDflt_20_28}
stringdefs[STROKE_FNT_DFLT_28_36]		= {fontScaleY_28_36, fontScaleX_28_36, fontIntercharDflt_28_36, fontInterlineDflt_28_36}
stringdefs[STROKE_FNT_DFLT_6_9]			= {fontScaleY_6_9,   fontScaleX_6_9,   fontIntercharDflt_6_9,   fontInterlineDflt_6_9}

DYNAMIC_DATA =
{
	RADAR_CONTACTS				= 0,
	RADAR_TRACKS				= 1,
	RADAR_AG_CONTACTS			= 2,
	IFF_CONTACTS				= 3,
	HSD_DEFENSE_ZONES			= 4,
	HSD_SYSTEM_TRACKS			= 5,
	FCR_SYSTEM_TRACKS			= 6,
	HAD_CONTACT					= 7,
	HAD_SYSTEM_TRACKS			= 8,
}