dofile(LockOn_Options.script_path.."symbology_defs.lua")
dofile(LockOn_Options.script_path.."Displays/Common/indicator/Units.lua")

-- units
local displaySize_inch	= 2.45	-- [inch]
local displaySize_m		= displaySize_inch * InToMeter	-- [m]
local dpi = 120
local displaySize_DI	= displaySize_inch * dpi

local DI2M			= displaySize_m / displaySize_DI	-- [m]
local DisplayHeigh	= 600		-- DI
local DisplayWidth	= 600		-- DI


-- Scale
SetCustomScale(DI2M) -- Display Increments

stroke_font			= "font_stroke_EHSI"
stroke_material		= "EHSI_WHITE"

if override_materials == true then
	default_material	= override_material
	stroke_font			= override_font
else
	default_material	= stroke_material
end

DEFAULT_LEVEL = 11


dbg_addIndicatorCenter()

-- Fonts
STROKE_FNT_DFLT_FAIL		= 1
STROKE_FNT_DFLT_LBL			= 2
STROKE_FNT_DFLT_ROSE		= 3
STROKE_FNT_DFLT_IND			= 4
STROKE_FNT_DFLT_MODE		= 5

-- WARNING! The only available fonts sizes
-- Do not define your own sizes!

--
local lclScale = GetScale()

glyphHeight_FAIL			= 32
glyphWidth_FAIL				= 20
fontInterchar_FAIL			= 5
fontInterline_FAIL			= 0
fontScaleY_FAIL				= lclScale * glyphHeight_FAIL
fontScaleX_FAIL				= lclScale * glyphWidth_FAIL
fontIntercharScale_FAIL		= lclScale * fontInterchar_FAIL
fontInterlineScale_FAIL		= lclScale * fontInterline_FAIL

glyphHeight_LBL			= 11.0
glyphWidth_LBL			= 6.0
fontInterchar_LBL		= 2.0
fontInterline_LBL		= 6.0
fontScaleY_LBL			= lclScale * glyphHeight_LBL
fontScaleX_LBL			= lclScale * glyphWidth_LBL
fontIntercharScale_LBL	= lclScale * fontInterchar_LBL
fontInterlineScale_LBL	= lclScale * fontInterline_LBL

glyphHeight_ROSE		= 16.0
glyphWidth_ROSE			= 9.0
fontInterchar_ROSE		= 2.0
fontInterline_ROSE		= 2.0
fontScaleY_ROSE			= lclScale * glyphHeight_ROSE
fontScaleX_ROSE			= lclScale * glyphWidth_ROSE
fontIntercharScale_ROSE	= lclScale * fontInterchar_ROSE
fontInterlineScale_ROSE	= lclScale * fontInterline_ROSE

glyphHeight_IND			= 15.0
glyphWidth_IND			= 8.0
fontInterchar_IND		= 3.0
fontInterline_IND		= 2.0
fontScaleY_IND			= lclScale * glyphHeight_IND
fontScaleX_IND			= lclScale * glyphWidth_IND
fontIntercharScale_IND	= lclScale * fontInterchar_IND
fontInterlineScale_IND	= lclScale * fontInterline_IND

glyphHeight_MODE		= 13.0
glyphWidth_MODE			= 7.0
fontInterchar_MODE		= 3.0
fontInterline_MODE		= 2.0
fontScaleY_MODE			= lclScale * glyphHeight_MODE
fontScaleX_MODE			= lclScale * glyphWidth_MODE
fontIntercharScale_MODE	= lclScale * fontInterchar_MODE
fontInterlineScale_MODE	= lclScale * fontInterline_MODE

--
stringdefs[STROKE_FNT_DFLT_FAIL]	= {fontScaleY_FAIL,	fontScaleX_FAIL,	fontIntercharScale_FAIL,	fontInterlineScale_FAIL}
stringdefs[STROKE_FNT_DFLT_LBL]		= {fontScaleY_LBL,	fontScaleX_LBL,		fontIntercharScale_LBL,		fontInterlineScale_LBL}
stringdefs[STROKE_FNT_DFLT_ROSE]	= {fontScaleY_ROSE,	fontScaleX_ROSE,	fontIntercharScale_ROSE,	fontInterlineScale_ROSE}
stringdefs[STROKE_FNT_DFLT_IND]		= {fontScaleY_IND,	fontScaleX_IND,		fontIntercharScale_IND,		fontInterlineScale_IND}
stringdefs[STROKE_FNT_DFLT_MODE]	= {fontScaleY_MODE,	fontScaleX_MODE,	fontIntercharScale_MODE,	fontInterlineScale_MODE}


-- Functions

