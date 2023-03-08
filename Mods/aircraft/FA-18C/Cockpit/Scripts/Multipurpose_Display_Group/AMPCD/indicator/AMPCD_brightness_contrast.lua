dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/MPD_page_defs.lua")
dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/device/MDG_device_common.lua") -- MDG IDs

local shiftX = glyphNominalWidth200 * 2 + fontIntercharDflt200 * 1.5

local placeholder = addPlaceholder("AUTO_andBrightnessContrastPlaceholder", {shiftX, 0}, nil, {{"Set_isdraw_by_MDG_ID", MDG_SELF_IDS.HI}, {"AMPCD_brightnessContrastShow"}})

local backgroundBorder = 15
local backgroundYhalf = glyphNominalHeight200 * 0.5 + backgroundBorder

local backgroundWAutoXsz = glyphNominalWidth200 * 6 + fontIntercharDflt200 * 5 + backgroundBorder

local backgroundWAutoVerts = {{-backgroundWAutoXsz, -backgroundYhalf},
							  {-backgroundWAutoXsz, backgroundYhalf},
							  {backgroundBorder, backgroundYhalf},
							  {backgroundBorder, -backgroundYhalf}}

addMesh("BackgroundWithAuto", backgroundWAutoVerts, default_box_indices, {0, 0}, "triangles", placeholder.name, {{"AMPCD_brightnessContrastIsAuto", 1}}, "BLACK")

addStrokeText("AUTO_text", "AUTO", STROKE_FNT_DFLT_200, "RightCenter", {-(shiftX + fontIntercharDflt200 * 0.5), 0}, placeholder.name, {{"AMPCD_brightnessContrastIsAuto", 1}})

local backgroundNoAutoVerts = {{-(glyphNominalWidth200 + backgroundBorder), -backgroundYhalf},
							  {-(glyphNominalWidth200 + backgroundBorder), backgroundYhalf},
							  {backgroundBorder, backgroundYhalf},
							  {backgroundBorder, -backgroundYhalf}}

addMesh("BackgroundNoAuto", backgroundNoAutoVerts, default_box_indices, {0, 0}, "triangles", placeholder.name, {{"AMPCD_brightnessContrastIsAuto", 0}}, "BLACK")

addStrokeText("BrightnessContrastValue", "", STROKE_FNT_DFLT_200, "RightCenter", {0, 0}, placeholder.name, {{"AMPCD_brightnessContrastValue"}}, {"%d"})

