dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/MPD_page_defs.lua")
------------------------------------------ Track up and North up ---------------------------------------------------
local Backup_Mode_Root = "Backup_Root"
addPlaceholder(Backup_Mode_Root, {0, 0}, nil, {{"MPD_HSI_CourseRoseMode_Root", 3}})
local Backup_Mode = "Backup_Mode"
addPlaceholder(Backup_Mode, {0, 0}, Backup_Mode_Root, {{"MPD_HSI_CourseRoseMode_Rotate"}})
drawCompass(400, Backup_Mode, {{"MPD_HSI_Compass_Label"}})
addStrokeSymbol("aircraft_BackupMode", {"stroke_symbols_MDI_AMPCD", "136-aircraft"}, "FromSet", {0, 0}, nil, {{"MPD_HSI_CourseRoseMode_Root", 3}})

local SpaceBetweenRow = 45
addPlaceholder("LatLongAlignDisplay", {-180, 235}, nil, {{"MPD_HSI_EnableAlignLatLonDisplay"}})
addStrokeText("Latitude",				"",	STROKE_FNT_DFLT_150, "LeftCenter", {0, 0}, "LatLongAlignDisplay", {{"MPD_HSI_AlignLatitudeLongitude", 0}}, {"%c%3d°%02d.%02d'", "%c%3d°%02d'%02d\"", "%c%3d°%02d.%02d%02d'", "%c%3d°%02d'%02d.%02d\""})
addStrokeText("Longitude",				"",	STROKE_FNT_DFLT_150, "LeftCenter", {0, -SpaceBetweenRow}, "LatLongAlignDisplay", {{"MPD_HSI_AlignLatitudeLongitude", 1}}, {"%c%3d°%02d.%02d'", "%c%3d°%02d'%02d\"", "%c%3d°%02d.%02d%02d'", "%c%3d°%02d'%02d.%02d\""})
addPlaceholder("HdgSpdAlignDisplay", {0, -SpaceBetweenRow * 2}, "LatLongAlignDisplay", {{"MPD_HSI_EnableAlignHdgSpdDisplay"}})
addStrokeText("CV HDG",		"CV HDG XXX°",	STROKE_FNT_DFLT_150, "LeftCenter", {0, 0}, "HdgSpdAlignDisplay", {{"MPD_HSI_AlignCvHdg"}}, {"CV HDG %03d°"})
addStrokeText("CV SPD",		"CV SPD XXKTS",	STROKE_FNT_DFLT_150, "LeftCenter", {0, -SpaceBetweenRow}, "HdgSpdAlignDisplay", {{"MPD_HSI_AlignCvSpd"}})

local XTACANInfo = -450	
local YTACANInfo = 400
local TRCSpaceBetweenRow = 30
addStrokeText("TACANBearingAndRange", "", STROKE_FNT_DFLT_120, "LeftCenter", {XTACANInfo, YTACANInfo}, nil, {{"MPD_HSI_TACAN_BearingAndRange"}}, {"%03d°/%5.1f", "%03d°"})
addStrokeText("TACANStationIdentification", "", STROKE_FNT_DFLT_120, "LeftCenter", {XTACANInfo + 30, YTACANInfo - TRCSpaceBetweenRow * 2}, nil, {{"MPD_HSI_TACAN_StationIdentification"}}, {"%c%c%c"})


local TN_UP_Mode_Root = "Track_and_North_Up_Root"
addPlaceholder(TN_UP_Mode_Root, {0, 0}, nil, {{"MPD_HSI_CourseRoseMode_Root", 0}})
local TN_UP_Mode = "Track_and_North_Up"
addPlaceholder(TN_UP_Mode, {0, 0}, TN_UP_Mode_Root, {{"MPD_HSI_CourseRoseMode_Track_North_UP", 0}})

local NavType = 
{
	TACANType = 0,
	WYPTType = 1,
}

local TACANMarkNameNTU = "TACANMarkRootBackup"
addPlaceholder(TACANMarkNameNTU, {0, 0}, TN_UP_Mode, {{"MPD_HSI_Navigation_Mark", NavType.TACANType}})
addStrokeSymbol("TACANMark_Front_NUT", 	{"stroke_symbols_MDI_AMPCD", "TACAN-mark-front"}, "FromSet", {0, 440}, TACANMarkNameNTU)
addStrokeSymbol("TACANMark_Back_NUT", 	{"stroke_symbols_MDI_AMPCD", "TACAN-mark-back"}, "FromSet", {0, -440}, TACANMarkNameNTU)

local Main_Name = "HSI_Main_Root"
addPlaceholder(Main_Name, {0, 0}, nil, {{"MPD_HSI_PB_Label_Main_PB_1_5"}})
add_PB_label(1, {"ACL", Main_Name, {{"MPD_HSI_Main_ACL"}}, {{"MPD_HSI_Main_ACL_Box"}}})