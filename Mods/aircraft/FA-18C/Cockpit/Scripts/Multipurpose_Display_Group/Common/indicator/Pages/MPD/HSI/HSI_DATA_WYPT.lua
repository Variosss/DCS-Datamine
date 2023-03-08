dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/MPD_page_defs.lua")
local CustomStrDef = {fontScaleY_150, fontScaleX_150, 11 * GetScale(), fontInterlineDflt150 * GetScale()}
local DistanceBetween150Lines = 48

add_PB_label(3, "GPS")
add_PB_label(5, "UFC")
add_PB_label(6, "  A/C  ")
add_PB_label(7, {" WYPT ", nil, nil, true})
add_PB_label(8, "  TCN  ")
add_PB_label(9, "MDATA")
add_PB_label(10, "HSI")
add_PB_label(11, "NAV CK")

local ACLabelPosY = 300
local WYPTDataPosY = 210
local WYPTDataPosX = -320
local WYPTOSPosY = -90
addStrokeText("WYPT_Number", "", CustomStrDef, "LeftCenter", {-80, ACLabelPosY}, nil, {{"MPD_HSI_WYPT_Data_WaypointSelectedNumber_Label"}})
addStrokeText("WYPT_GPS_ID", "", CustomStrDef, "CenterCenter", {0, ACLabelPosY + DistanceBetween150Lines}, nil, {{"MPD_HSI_WYPT_Data_GPS_ID"}})
addStrokeText("WYPT_Page_Number", "", STROKE_FNT_DFLT_100, "RightCenter", {505, 60}, nil, {{"MPD_HSI_WYPT_Data_WaypointSelectedNumber"}})

addStrokeText("WYPT_Latitude",	"",	CustomStrDef, "LeftCenter", {WYPTDataPosX, WYPTDataPosY}, nil, {{"MPD_HSI_WYPT_Data_setDegrees", 0}}, {"%c%3d°%02d.%02d'", "%c%3d°%02d'%02d\"", "%c%3d°%02d.%02d%02d'", "%c%3d°%02d'%02d.%02d\""})
addStrokeText("WYPT_Longitude",	"",	CustomStrDef, "LeftCenter", {WYPTDataPosX, WYPTDataPosY - DistanceBetween150Lines}, nil, {{"MPD_HSI_WYPT_Data_setDegrees", 1}}, {"%c%3d°%02d.%02d'", "%c%3d°%02d'%02d\"", "%c%3d°%02d.%02d%02d'", "%c%3d°%02d'%02d.%02d\""})
addStrokeText("WYPT_Grid_label",	"GRID",				CustomStrDef, "LeftCenter", {WYPTDataPosX, WYPTDataPosY - DistanceBetween150Lines * 2})
addStrokeText("WYPT_Grid",			"11S KA 761174",	CustomStrDef, "LeftCenter", {WYPTDataPosX + 145, WYPTDataPosY - DistanceBetween150Lines * 2}, nil, {{"MPD_HSI_WYPT_Data_Grid"}})
addStrokeText("WYPT_Elev_label",	"ELEV",	CustomStrDef, "LeftCenter", {WYPTDataPosX, WYPTDataPosY - DistanceBetween150Lines * 3})
addStrokeText("WYPT_Elev",			"",		CustomStrDef, "RightCenter", {46, WYPTDataPosY - DistanceBetween150Lines * 3}, nil, {{"MPD_HSI_WYPT_Data_Elevation"}})

addStrokeText("WYPT_OS_Rng_Label", "O/S RNG", CustomStrDef, "LeftCenter", {WYPTDataPosX, WYPTOSPosY})
addStrokeText("WYPT_OS_Rng", nil, CustomStrDef, "CenterCenter", {130, WYPTOSPosY}, nil, {{"MPD_HSI_OS_Data_Range"}})
addStrokeText("WYPT_OS_Brg_Label", "O/S BRG", CustomStrDef, "LeftCenter", {WYPTDataPosX, WYPTOSPosY - DistanceBetween150Lines})
addStrokeText("WYPT_OS_Brg", nil, CustomStrDef, "CenterCenter", {130, WYPTOSPosY - DistanceBetween150Lines}, nil, {{"MPD_HSI_OS_Data_Bearing"}}, {"%3d°%02d'%02d\"%c"})
addStrokeText("WYPT_OS_Grid_Label", "O/S GRID", CustomStrDef, "LeftCenter", {WYPTDataPosX, WYPTOSPosY - DistanceBetween150Lines * 2})
addStrokeText("WYPT_OS_Grid", "", CustomStrDef, "LeftCenter", {-60, WYPTOSPosY - DistanceBetween150Lines * 2}, nil, {{"MPD_HSI_OS_Data_Grid"}})
addStrokeText("WYPT_OS_Elev_Label", "O/S ELEV", CustomStrDef, "LeftCenter", {WYPTDataPosX, WYPTOSPosY - DistanceBetween150Lines * 3})
addStrokeText("WYPT_OS_Elev", nil, CustomStrDef, "CenterCenter", {130, WYPTOSPosY - DistanceBetween150Lines * 3}, nil, {{"MPD_HSI_OS_Data_Elevation"}})

addStrokeLine("WYPT_Line", 760, {-360,  WYPTOSPosY - DistanceBetween150Lines * 3 - 20}, -90)
addStrokeText("WYPT_TOT", "", CustomStrDef, "LeftCenter", {-380, WYPTOSPosY - DistanceBetween150Lines * 4}, nil, {{"MPD_HSI_WYPT_TimeOnTarget"}})
addStrokeText("WYPT_GSPD", "", CustomStrDef, "LeftCenter", {58, WYPTOSPosY - DistanceBetween150Lines * 4}, nil, {{"MPD_HSI_WYPT_GroundSpeed"}})
addStrokeText("WYPT_SequenceData", "", STROKE_FNT_DFLT_150, "LeftTop", {-330, WYPTOSPosY - DistanceBetween150Lines * 4.62}, nil, {{"MPD_HSI_WYPT_SequenceData"}})

addStrokeBox("WYPT_SelectedTargetWaypoint_Box", 52, 40, CenterCenter, {-309, -327}, nil, {{"MPD_HSI_WYPT_TargetWaypoint", 72, -42}})
addStrokeText("WYPT_SomeData_3", "23", STROKE_FNT_DFLT_100, "CenterCenter", {350, -435})

add_PB_label(1, "  SEQUFC")
add_PB_label(2, {"A/A WP", nil, nil, {{"MPD_HSI_WYPT_BullseyeBox"}}}, {"", nil, {{"MPD_HSI_WYPT_BullseyeNumber"}}})
add_PB_label(4, "SLEW")
add_PB_symbol(12, "124-arrow-up")
add_PB_symbol(13, "124-arrow-down")
add_PB_label(14, {"REF WP", nil, {{"MPD_HSI_WYPT_RefWpShow"}}, {{"MPD_HSI_WYPT_RefWpBox"}}}, {"XX", nil, {{"MPD_HSI_WYPT_RefWpId"}}})
add_PB_label(15, {"    ", nil, {{"MPD_HSI_WYPT_SequencePBLabel"}}, {{"MPD_HSI_WYPT_SequencePBBox"}}})
add_PB_label(16, " FLRP ")
add_PB_label(17, {"OVFLY1", nil, {{"MPD_HSI_DATA_WYPT_OvflyLabel"}}, {{"MPD_HSI_DATA_WYPT_OvflyBox"}}})
add_PB_label(19, {"PRECISE", nil, nil, {{"MPD_HSI_WYPT_isPrecise"}}})
add_PB_label(20, {"DATUM 47", nil, {{"MPD_HSI_WYPT_DATUM"}}}, {"WGS-84", nil, {{"MPD_HSI_WYPT_SPHEROID"}}})