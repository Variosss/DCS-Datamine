dofile(LockOn_Options.script_path.."HMD/indicator/InitParams.lua")
dofile(LockOn_Options.script_path.."HMD/indicator/HMD_symbology_defs.lua")

MDG_init_specifics = readParameter("MDG_init_specifics")
dofile(MDG_init_specifics)

if override_materials == true then
	default_material  = override_material
	stroke_font		  = override_font
else
	default_material  = stroke_material
end

DEFAULT_LEVEL     		= readParameter("MDG_init_DEFAULT_LEVEL")

HUD_TFOV_mils    		= 10 * DegToMil -- HUD Total Vield of View radius in milliradians
HUD_TFOV_DI       		= DegToDI(10)   -- HUD Total Vield of View radius in DIs

dbg_addIndicatorCenter()

-- Fonts

-- WARNING! The only available fonts sizes for MDG stroke symbology are: 100% (20 DI), 120%, 150%, 200%
-- Do not define your own sizes!

-- F/A-18 MDG DIs (display increments)
glyphNominalHeight100 = 20
glyphNominalWidth100  = 12
glyphAspect = glyphNominalWidth100 / glyphNominalHeight100

glyphNominalHeight120 = glyphNominalHeight100 * 1.2
glyphNominalHeight150 = glyphNominalHeight100 * 1.5
glyphNominalHeight200 = glyphNominalHeight100 * 2

glyphNominalWidth120 = roundDI(glyphNominalWidth100 * 1.2)
glyphNominalWidth150 = glyphNominalWidth100 * 1.5
glyphNominalWidth200 = glyphNominalWidth100 * 2

fontScaleY_100 = glyphNominalHeight100 * GetScale()
fontScaleY_120 = glyphNominalHeight120 * GetScale()
fontScaleY_150 = glyphNominalHeight150 * GetScale()
fontScaleY_200 = glyphNominalHeight200 * GetScale()

fontScaleX_100 = glyphNominalWidth100 * GetScale()
fontScaleX_120 = glyphNominalWidth120 * GetScale()
fontScaleX_150 = glyphNominalWidth150 * GetScale()
fontScaleX_200 = glyphNominalWidth200 * GetScale()

fontIntercharDflt100 		= 4
fontIntercharDflt120 		= 6
fontIntercharDflt150 		= 6
fontIntercharDflt200 		= 12
fontIntercharDflt120_wide 	= 9
fontIntercharDflt150_wide 	= 9

fontInterlineDflt100 		= 5
fontInterlineDflt120 		= 6
fontInterlineDflt150 		= 12
fontInterlineDflt200 		= 12

STROKE_FNT_DFLT_100 		= 1
STROKE_FNT_DFLT_120 		= 2
STROKE_FNT_DFLT_150 		= 3
STROKE_FNT_DFLT_200 		= 4
STROKE_FNT_DFLT_120_WIDE 	= 5
STROKE_FNT_DFLT_150_WIDE 	= 6

stringdefs[STROKE_FNT_DFLT_100] 		= {fontScaleY_100, fontScaleX_100, fontIntercharDflt100 * GetScale(), fontInterlineDflt100 * GetScale()}
stringdefs[STROKE_FNT_DFLT_120] 		= {fontScaleY_120, fontScaleX_120, fontIntercharDflt120 * GetScale(), fontInterlineDflt120 * GetScale()}
stringdefs[STROKE_FNT_DFLT_150] 		= {fontScaleY_150, fontScaleX_150, fontIntercharDflt150 * GetScale(), fontInterlineDflt150 * GetScale()}
stringdefs[STROKE_FNT_DFLT_200] 		= {fontScaleY_200, fontScaleX_200, fontIntercharDflt200 * GetScale(), fontInterlineDflt200 * GetScale()}
stringdefs[STROKE_FNT_DFLT_120_WIDE] 	= {fontScaleY_120, fontScaleX_120, fontIntercharDflt120_wide * GetScale(), fontInterlineDflt150 * GetScale()}
stringdefs[STROKE_FNT_DFLT_150_WIDE] 	= {fontScaleY_150, fontScaleX_150, fontIntercharDflt150_wide * GetScale(), fontInterlineDflt150 * GetScale()}

--
hmd_waterlineShiftY = 0--DegToDI(4)
-- Airspeed/Altitude numerics definitions
hmd_CAS_AltBoxGapY 	= 5
hmd_CAS_AltBoxEdgeX 		= 350

-- Automatic Blanking
autoBlank = addPlaceholder("HMD_Auto_blanking", {0,0}, nil, {{"HMD_Auto_Blanking"}})

-- placeholders
hmd_waterline_origin = addPlaceholder("HMD_waterline_origin", {0, hmd_waterlineShiftY}, autoBlank.name)
hmd_CAS_BoxOrigin    = addPlaceholder("HMD_CAS_BoxOrigin", {-hmd_CAS_AltBoxEdgeX, 230},		hmd_waterline_origin.name)
hmd_Alt_BoxOrigin    = addPlaceholder("HMD_Alt_BoxOrigin", {hmd_CAS_AltBoxEdgeX + 26, 230}, hmd_waterline_origin.name)
hmd_dacPosition		 = addPlaceholder("HMD_DAC_positionPH", {0,0}, nil, {{"HMD_DAC_Position", RadToDI()}})

-- F/A-18 MDG DIs (display increments)
fontIntercharHMD_mid_120  = 8
stringdefs_HMD_mid_120  = {fontScaleY_120, fontScaleX_120, fontIntercharHMD_mid_120 * GetScale(),  fontInterlineDflt120 * GetScale()}

-- A line through a string, like the Radar/RWR 'not ready' status (RDY with a line through it).
-- If 'fontSize' is omitted, then 120% font parameters will be used.
function addLineThroughAString(name, pos, parent, controllers, charsNum, stringAlign, fontSize)
	
	local lineGap = 5
	
	pos = pos or {0, 0}
	
	local glyphWidth
	local glyphHeight
	local fontInterchar
	
	if fontSize == STROKE_FNT_DFLT_100 then
		glyphWidth		= glyphNominalWidth100
		glyphHeight		= glyphNominalHeight100
		fontInterchar	= fontIntercharDflt100
	elseif fontSize == STROKE_FNT_DFLT_120 then
		glyphWidth		= glyphNominalWidth120
		glyphHeight		= glyphNominalHeight120
		fontInterchar	= fontIntercharDflt120
	elseif fontSize == STROKE_FNT_DFLT_150 then
		glyphWidth		= glyphNominalWidth150
		glyphHeight		= glyphNominalHeight150
		fontInterchar	= fontIntercharDflt150
		lineGap 		= 6
	elseif fontSize == STROKE_FNT_DFLT_200 then
		glyphWidth		= glyphNominalWidth200
		glyphHeight		= glyphNominalHeight200
		fontInterchar	= fontIntercharDflt200
		lineGap 		= 8
	elseif fontSize == STROKE_FNT_DFLT_120_WIDE then
		glyphWidth		= glyphNominalWidth120
		glyphHeight		= glyphNominalHeight120
		fontInterchar	= fontIntercharDflt120_wide
	elseif fontSize == STROKE_FNT_DFLT_150_WIDE then
		glyphWidth		= glyphNominalWidth150
		glyphHeight		= glyphNominalHeight150
		fontInterchar	= fontIntercharDflt150_wide
		lineGap 		= 6
	else
		glyphWidth		= glyphNominalWidth120
		glyphHeight		= glyphNominalHeight120
		fontInterchar	= fontIntercharDflt120
	end
	
	local dirX
	local dirY
	
	if stringAlign == "RightBottom" then
		dirX =  1
		dirY =  1
	elseif stringAlign == "LeftBottom" then
		dirX = -1
		dirY =  1
	elseif stringAlign == "CenterBottom" then
		dirX =  0
		dirY =  1
	elseif stringAlign == "RightTop" then
		dirX =  1
		dirY = -1
	elseif stringAlign == "LeftTop" then
		dirX = -1
		dirY = -1
	elseif stringAlign == "CenterTop" then
		dirX =  0
		dirY = -1
	elseif stringAlign == "RightCenter" then
		dirX =  1
		dirY =  0
	elseif stringAlign == "LeftCenter" then
		dirX = -1
		dirY =  0
	else
		dirX =  0
		dirY =  0
	end
	
	local lineLen = glyphWidth * charsNum + fontInterchar * (charsNum - 1) + lineGap * 2
	
	local shiftX
	local shiftY = dirY * glyphHeight / 2
	local rot
	
	if dirX == 0 then
		shiftX = lineLen / 2
	else
		shiftX = dirX * lineGap
	end
	
	if dirX == -1 then
		rot = -90
	else
		rot = 90
	end
	
	addStrokeLine(name, lineLen, {pos[1] + shiftX, pos[2] + shiftY}, rot, parent, controllers)
end

-- Steering dot is made by 5 circles. The total size of the symbol is 12 DI (number in the catalog - 105)
-- Is used by HUD and RDR formats
function addSteeringDot(name, pos, parent, controllers)
	local SteeringDotPlaceholder = addPlaceholder(name.."_PlaceHolder", pos, parent, controllers)
	-- NOTE: addStrokeCircle(...) has segment detail of 4, thus the actual points number is 4 times greater
	local segLen8pts  = math.pi * 2 / 2
	local segLen16pts = math.pi * 2 / 4
	local segLen32pts = math.pi * 2 / 8
	addStrokeCircle(name.."_Circle1", 1.5, nil, SteeringDotPlaceholder.name, nil, nil, segLen8pts)
	addStrokeCircle(name.."_Circle2", 3, nil, SteeringDotPlaceholder.name, nil, nil, segLen8pts)
	addStrokeCircle(name.."_Circle3", 4, nil, SteeringDotPlaceholder.name, nil, nil, segLen8pts)
	addStrokeCircle(name.."_Circle4", 5, nil, SteeringDotPlaceholder.name, nil, nil, segLen16pts)
	addStrokeCircle(name.."_Circle5", 6, nil, SteeringDotPlaceholder.name, nil, nil, segLen32pts)
end
