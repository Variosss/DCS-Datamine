dofile(LockOn_Options.script_path.."HMD/indicator/InitParams.lua")
dofile(LockOn_Options.script_path.."symbology_defs.lua")
dofile(LockOn_Options.script_path.."Displays/Common/indicator/Units.lua")

MDG_init_specifics = readParameter("MDG_init_specifics")
dofile(MDG_init_specifics)

if override_materials == true then
	default_material  = override_material
	stroke_font		  = override_font
else
	default_material  = stroke_material
end

DEFAULT_LEVEL     		= readParameter("MDG_init_DEFAULT_LEVEL")

HUD_TFOV_mils    		= DegToMil(10) -- HUD Total Vield of View radius in milliradians

dbg_addIndicatorCenter()

-- Fonts
-- Currently used miliradians
local lclScale = GetScale()

glyphHeight_100			= 7.0
glyphWidth_100			= 4.0
fontScaleY_100			= glyphHeight_100 * lclScale
fontScaleX_100			= glyphWidth_100 * lclScale
fontIntercharDflt_100	= 2.0
fontInterlineDflt_100	= 2.0
fontIntercharScale_100	= fontIntercharDflt_100 * lclScale
fontInterlineScale_100	= fontInterlineDflt_100 * lclScale

-- 125%
glyphHeight_125			= 1.25 * glyphHeight_100
glyphWidth_125			= 1.25 * glyphWidth_100
fontScaleY_125			= 1.25 * fontScaleY_100
fontScaleX_125			= 1.25 * fontScaleX_100
fontIntercharDflt_125	= 1.25 * fontIntercharDflt_100
fontInterlineDflt_125	= 1.25 * fontInterlineDflt_100
fontIntercharScale_125	= 1.25 * fontIntercharScale_100
fontInterlineScale_125	= 1.25 * fontInterlineScale_100

-- 150%
glyphHeight_150			= 1.5 * glyphHeight_100
glyphWidth_150			= 1.5 * glyphWidth_100
fontScaleY_150			= 1.5 * fontScaleY_100
fontScaleX_150			= 1.5 * fontScaleX_100
fontIntercharDflt_150	= 1.5 * fontIntercharDflt_100
fontInterlineDflt_150	= 1.5 * fontInterlineDflt_100
fontIntercharScale_150	= 1.5 * fontIntercharScale_100
fontInterlineScale_150	= 1.5 * fontInterlineScale_100


STROKE_FNT_DFLT_100			= 1
STROKE_FNT_DFLT_125			= 2
STROKE_FNT_DFLT_150			= 3

stringdefs[STROKE_FNT_DFLT_100]			= {fontScaleY_100, fontScaleX_100, fontIntercharScale_100, fontInterlineScale_100}
stringdefs[STROKE_FNT_DFLT_125]			= {fontScaleY_125, fontScaleX_125, fontIntercharScale_125, fontInterlineScale_125}
stringdefs[STROKE_FNT_DFLT_150]			= {fontScaleY_150, fontScaleX_150, fontIntercharScale_150, fontInterlineScale_150}

--
hmd_waterlineShiftY 		= 0--DegToMil(4)

-- Automatic Blanking
autoBlank = addPlaceholder("HMD_Auto_blanking", {0,0}, nil, {{"HMD_Auto_Blanking"}})

-- placeholders
hmd_waterline_origin = addPlaceholder("HMD_waterline_origin", {0, hmd_waterlineShiftY}, autoBlank.name)
hmd_dacPosition		 = addPlaceholder("HMD_DAC_positionPH", {0,0}, autoBlank.name, {{"HMD_DAC_Position", RadToMil()}})

