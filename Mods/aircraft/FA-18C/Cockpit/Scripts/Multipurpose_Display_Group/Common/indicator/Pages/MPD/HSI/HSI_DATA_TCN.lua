dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/MPD_page_defs.lua")
local CustomStrDef = {fontScaleY_150, fontScaleX_150, 11 * GetScale(), fontInterlineDflt150 * GetScale()}
local DistanceBetween150Lines = 48

add_PB_label(3, "GPS")
add_PB_label(5, "UFC")
add_PB_label(6, "  A/C  ")
add_PB_label(7, " WYPT ")
add_PB_label(8, {"  TCN  ", nil, nil, true})
add_PB_label(9, "MDATA")
add_PB_label(10, "HSI")
add_PB_label(11, "NAV CK")

local TCNLabelPosX = -150
local TCNLabelPosY = 280
addStrokeText("Tacal_Label", "", CustomStrDef, "LeftCenter", {0, TCNLabelPosY}, nil, {{"MPD_HSI_TCN_Data_Channel"}})
addStrokeText("Tacal_Latitude", "", CustomStrDef, "LeftCenter", {TCNLabelPosX, TCNLabelPosY - DistanceBetween150Lines}, nil, {{"MPD_HSI_TCN_Data_setDegrees", 0}}, {"%c%3d°%02d.%02d'", "%c%3d°%02d'%02d\"", "%c%3d°%02d.%02d%02d'", "%c%3d°%02d'%02d.%02d\""})
addStrokeText("Tacal_Longitude", "", CustomStrDef, "LeftCenter", {TCNLabelPosX, TCNLabelPosY - DistanceBetween150Lines * 2}, nil, {{"MPD_HSI_TCN_Data_setDegrees", 1}}, {"%c%3d°%02d.%02d'", "%c%3d°%02d'%02d\"", "%c%3d°%02d.%02d%02d'", "%c%3d°%02d'%02d.%02d\""})
addStrokeText("Tacal_ELEV", "ELEV", CustomStrDef, "LeftCenter", {TCNLabelPosX, TCNLabelPosY - DistanceBetween150Lines * 3})
addStrokeText("Tacal_ELEV_Data", "", CustomStrDef, "LeftCenter", {0, TCNLabelPosY - DistanceBetween150Lines * 3}, nil, {{"MPD_HSI_TCN_Data_Altitude"}})
addStrokeText("Tacal_MVAR", "MVAR", CustomStrDef, "LeftCenter", {TCNLabelPosX, TCNLabelPosY - DistanceBetween150Lines * 4})
addStrokeText("Tacal_MVAR_Data", "", CustomStrDef, "LeftCenter", {0, TCNLabelPosY - DistanceBetween150Lines * 4}, nil, {{"MPD_HSI_TCN_Data_setDegrees", 2}}, {"%c%3d°%02d'"})

addStrokeText("Tacal_Page_Number", "", STROKE_FNT_DFLT_100, "RightCenter", {505, 60}, nil, {{"MPD_HSI_TCN_Data_Station"}})
add_PB_symbol(12, "124-arrow-up")
add_PB_symbol(13, "124-arrow-down")