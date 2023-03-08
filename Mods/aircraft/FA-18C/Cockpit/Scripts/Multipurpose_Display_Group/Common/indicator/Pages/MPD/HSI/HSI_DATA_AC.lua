dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/MPD_page_defs.lua")
local CustomStrDef = {fontScaleY_150, fontScaleX_150, 11 * GetScale(), fontInterlineDflt150 * GetScale()}
local DistanceBetween150Lines = 48

local NOSEC_GPS_root = addPlaceholder("NOSEC_GPS_root", nil, nil, {{"MPD_HSI_DATA_AC_NOSEC_GPS_Enable"}})
addStrokeBox("NOSEC_GPS_Box", 52, 160, "LeftCenter", {PB_positions[2][1] - 7, PB_positions[2][2]}, NOSEC_GPS_root.name, {{"MPD_HSI_DATA_AC_NOSEC_GPS_Box"}})
add_PB_label(2, {"NOSEC", NOSEC_GPS_root.name}, {"GPS", NOSEC_GPS_root.name})
add_PB_label(3, "GPS")
add_PB_label(5, "UFC")
add_PB_label(6, {"  A/C  ", nil, nil, true})
add_PB_label(7, " WYPT ")
add_PB_label(8, "  TCN  ")
add_PB_label(9, "MDATA")
add_PB_label(10, "HSI")
add_PB_label(11, "NAV CK")

local ACLabelPosY = 300
local ACDataPosY = 210
local ACDataPosX = -170
local ACGPSDataPosY = -90
local ACGPSDataPosX = 95
addStrokeText("AC_PositionKeepingSource",	"INS",			CustomStrDef, "LeftCenter", {-60, ACLabelPosY},										nil, {{"MPD_HSI_DATA_AC_PosKeepingSrc"}}, {"", "INS", "TCN", "ADC", "GPS"})
addStrokeText("AC_Latitude",				"N 36°19.99'",	CustomStrDef, "LeftCenter", {ACDataPosX, ACDataPosY},								nil, {{"MPD_HSI_DATA_AC_PosLatitude"}}, {"%c%3d°%02d.%02d'", "%c%3d°%02d'%02d\"", "%c%3d°%02d.%02d%02d'", "%c%3d°%02d'%02d.%02d\""})
addStrokeText("AC_Longitude",				"W119°57.13'",	CustomStrDef, "LeftCenter", {ACDataPosX, ACDataPosY - DistanceBetween150Lines},		nil, {{"MPD_HSI_DATA_AC_PosLongitude"}}, {"%c%3d°%02d.%02d'", "%c%3d°%02d'%02d\"", "%c%3d°%02d.%02d%02d'", "%c%3d°%02d'%02d.%02d\""})
addStrokeText("AC_WSPD_Label",				"WSPD",			CustomStrDef, "LeftCenter", {ACDataPosX, ACDataPosY - DistanceBetween150Lines * 2})
addStrokeText("AC_WSPD",					"OKT",			CustomStrDef, "LeftCenter", {0, ACDataPosY - DistanceBetween150Lines * 2},			nil, {{"MPD_HSI_DATA_AC_WindSpeed"}})
addStrokeText("AC_WDIR_Label",				"WDIR",			CustomStrDef, "LeftCenter", {ACDataPosX, ACDataPosY - DistanceBetween150Lines * 3})
addStrokeText("AC_WDIR",					"45°",			CustomStrDef, "LeftCenter", {-20, ACDataPosY - DistanceBetween150Lines * 3},		nil, {{"MPD_HSI_DATA_AC_WindDirection"}}, {"%d°"})
addStrokeText("AC_MVAR_Label",				"MVAR",			CustomStrDef, "LeftCenter", {ACDataPosX, ACDataPosY - DistanceBetween150Lines * 4})
addStrokeText("AC_MVAR",					"E 12°42'EST",	CustomStrDef, "LeftCenter", {-40, ACDataPosY - DistanceBetween150Lines * 4},		nil, {{"MPD_HSI_DATA_AC_MagneticVariation"}}, {"%c%3d°%02d'", "%c%3d°%02d'"})

addStrokeText("AC_GPS_HERR_Label",			"GPS HERR",		CustomStrDef, "LeftCenter",	{ACDataPosX, ACGPSDataPosY})
addStrokeText("AC_GPS_HERR",				"400FT",		CustomStrDef, "LeftCenter",	{ACGPSDataPosX, ACGPSDataPosY},									nil, {{"MPD_HSI_DATA_AC_GPS_HErr"}})
addStrokeText("AC_GPS_VERR_Label",			"GPS VERR",		CustomStrDef, "LeftCenter",	{ACDataPosX, ACGPSDataPosY - DistanceBetween150Lines})
addStrokeText("AC_GPS_VERR",				"234FT",		CustomStrDef, "LeftCenter",	{ACGPSDataPosX, ACGPSDataPosY - DistanceBetween150Lines},		nil, {{"MPD_HSI_DATA_AC_GPS_VErr"}})
addStrokeText("AC_GPS_TIME_Label",			"GPS TIME",		CustomStrDef, "LeftCenter",	{ACDataPosX, ACGPSDataPosY - DistanceBetween150Lines * 2})
addStrokeText("AC_GPS_TIME",				"16:54:42Z",	CustomStrDef, "LeftCenter",	{ACGPSDataPosX, ACGPSDataPosY - DistanceBetween150Lines * 2},	nil, {{"MPD_HSI_DATA_AC_GPS_Time"}})


addStrokeText("Baro_Label", "BARO", STROKE_FNT_DFLT_120, "LeftCenter", {-355, -465})

addStrokeText("Baro_Value_Thousands", "", STROKE_FNT_DFLT_150, "RightCenter", {-333, -500}, nil, {{"MPD_HSI_DATA_AC_AltWarn", 0, 2}})
addStrokeText("Baro_Value", "", STROKE_FNT_DFLT_120, "RightCenter", {-272, -500}, nil, {{"MPD_HSI_DATA_AC_AltWarn", 0, 1}})
addStrokeText("Baro_Zero", "", STROKE_FNT_DFLT_150, "RightCenter", {-272, -500}, nil, {{"MPD_HSI_DATA_AC_AltWarn", 0, 0}})

addStrokeText("Radar_Label", "RADAR", STROKE_FNT_DFLT_120, "LeftCenter", {-215, -465})

addStrokeText("Radar_Value_Thousands", "", STROKE_FNT_DFLT_150, "RightCenter", {-175, -500}, nil, {{"MPD_HSI_DATA_AC_AltWarn", 1, 2}})
addStrokeText("Radar_Value", "", STROKE_FNT_DFLT_120, "RightCenter", {-115, -500}, nil, {{"MPD_HSI_DATA_AC_AltWarn", 1, 1}})
addStrokeText("Radar_Zero", "", STROKE_FNT_DFLT_150, "RightCenter", {-115, -500}, nil, {{"MPD_HSI_DATA_AC_AltWarn", 1, 0}})

addStrokeLine("Altitude_Warn_Line_", 220, {-353, -447}, -90)
addStrokeText("Warning_altitude", "WARN ALT", STROKE_FNT_DFLT_120, "LeftCenter", {-321, -430})

add_PB_label(1, "NORM")
local pb4 = add_PB_label(4, {"", nil, {{"MPD_HSI_DATA_AC_FccBlim"}}}, "BLIM")[1]
pb4.formats = {"", "N\nA\nV", "T\nA\nC"}
add_PB_label(13, {"", nil, {{"MPD_HSI_DATA_AC_TrueHeadingPBLabel"}}}, "HDG")
add_PB_label(15, {"", nil, {{"MPD_HSI_DATA_AC_isLATLN_DCML"}}}, "LATLN")
add_PB_label(17, {" TAWS ", nil, nil, {{"MPD_HSI_DATA_AC_TAWS_Box"}}})