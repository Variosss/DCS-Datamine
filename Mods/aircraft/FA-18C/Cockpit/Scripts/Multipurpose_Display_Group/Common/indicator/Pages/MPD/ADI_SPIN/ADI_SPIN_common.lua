dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/MPD_page_defs.lua")

local EADI_CAS_AltBoxEdgeX = 398
local EADI_CAS_AltYPos = 393
local AirspeedXShift = 139

local EADI_CAS_AltBoxHeight = 70
addStrokeBox("EADI_Altitude_Box", 176, EADI_CAS_AltBoxHeight, "RightCenter", {EADI_CAS_AltBoxEdgeX, EADI_CAS_AltYPos})
addStrokeBox("EADI_Airspeed_Box", 151, EADI_CAS_AltBoxHeight, "LeftCenter", {-EADI_CAS_AltBoxEdgeX, EADI_CAS_AltYPos})

local customStringDef200_speed_alt_thou = {fontScaleY_200, fontScaleX_200, 10 * GetScale(), fontInterlineDflt200 * GetScale()}
local alt200interchar = 8
local customStringDef200_alt = {fontScaleY_200, fontScaleX_200, alt200interchar * GetScale(), fontInterlineDflt200 * GetScale()}
local alt150interchar = 7
local customStringDef150_alt = {fontScaleY_150, fontScaleX_150, alt150interchar * GetScale(), fontInterlineDflt150 * GetScale()}

local AltitudeXShift = 11
--local alt200thouXshift = (alt200interchar + glyphNominalWidth200) * 3
local alt200thouXshift = (alt150interchar + glyphNominalWidth150) * 3

-- altitude below 1000 ft
addStrokeText("EADI_altitude_below_1000", nil, customStringDef200_alt, "RightCenter", {EADI_CAS_AltBoxEdgeX - AltitudeXShift, EADI_CAS_AltYPos}, nil, {{"HUD_EADI_AltitudeNumerics", 0}})
-- altitude above 1000 ft
addStrokeText("EADI_altitude_above_1000_thousands", nil, customStringDef200_speed_alt_thou, "RightCenter", {EADI_CAS_AltBoxEdgeX - alt200thouXshift - AltitudeXShift, EADI_CAS_AltYPos}, nil,
	{{"HUD_EADI_AltitudeNumerics", 1}})
addStrokeText("EADI_altitude_above_1000_hund_tenths", nil, customStringDef150_alt, "RightCenter", {EADI_CAS_AltBoxEdgeX - AltitudeXShift, EADI_CAS_AltYPos}, nil,
	{{"HUD_EADI_AltitudeNumerics", 2}})

-- altitude symbol (none, R, flashing B)
addStrokeText("EADI_altitude_symbol", nil, STROKE_FNT_DFLT_200, "LeftCenter", {EADI_CAS_AltBoxEdgeX + 10, EADI_CAS_AltYPos}, nil, {{"HUD_EADI_AltitudeSymbol"}}, {"B", "R", "X"})

addStrokeText("EADI_VerticalVelocity", nil, STROKE_FNT_DFLT_150, "RightCenter", {EADI_CAS_AltBoxEdgeX - AltitudeXShift / 2, EADI_CAS_AltYPos + 65}, nil, {{"HUD_EADI_VertVelocityNumerics"}})

addStrokeText("EADI_Airspeed", nil, customStringDef200_speed_alt_thou, "RightCenter", {-EADI_CAS_AltBoxEdgeX + AirspeedXShift, EADI_CAS_AltYPos}, nil, {{"HUD_EADI_AirspeedNumerics"}})
