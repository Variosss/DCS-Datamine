dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/MPD_page_defs.lua")
dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/FLIR/FLIR_tools.lua")

---------------------------------------------------
-- On/Off placeholder
local flirRoot			= addPlaceholder("MPD_FLIR_AG_Root", {0,0})
local flirRoot_L		= addPlaceholder("MPD_FLIR_AG_Root_L", {0,0}, flirRoot.name, {{"MPD_FLIR_TgpType", LITENING}})
local flirRoot_A		= addPlaceholder("MPD_FLIR_AG_Root_A", {0,0}, flirRoot.name, {{"MPD_FLIR_TgpType", ATFLIR}})
local operRoot			= addPlaceholder("MPD_FLIR_AG_OnOff", {0,0}, flirRoot.name, {{"MPD_FLIR_OperPlaceholder", 1}})
local operRoot_L		= addPlaceholder("MPD_FLIR_AG_OnOff_L", {0,0}, flirRoot_L.name, {{"MPD_FLIR_OperPlaceholder", 1}})
local operRoot_A		= addPlaceholder("MPD_FLIR_AG_OnOff_A", {0,0}, flirRoot_A.name, {{"MPD_FLIR_OperPlaceholder", 1}})
local videoOnRoot		= addPlaceholder("MPD_FLIR_AG_VideoOn", {0,0}, operRoot.name, {{"MPD_FLIR_VideoOn"}})
local videoOnRoot_L		= addPlaceholder("MPD_FLIR_AG_VideoOn_L", {0,0}, operRoot_L.name, {{"MPD_FLIR_VideoOn"}})
local videoOnRoot_A		= addPlaceholder("MPD_FLIR_AG_VideoOn_A", {0,0}, operRoot_A.name, {{"MPD_FLIR_VideoOn"}})

-- ## REL, ##LASER
addStrokeText("MPD_FLIR_TTG_L", nil, STROKE_FNT_DFLT_120_WIDE, "RightCenter", {450, 30}, operRoot_L.name, {{"MPD_FLIR_TTG"}},
	{"", "", "", "", "%2d REL", "", "%2d LASER", "", "%2d TTMR", "%2d TTI"})
addStrokeText("MPD_FLIR_TTG_A", nil, STROKE_FNT_DFLT_120_WIDE, "RightCenter", {450, 60}, operRoot_A.name, {{"MPD_FLIR_TTG"}},
	{"", "", "", "", "%2d REL", "", "%2d LASER", "", "%2d TTMR", "%2d TTI"})
-- TGT range
addStrokeText("MPD_FLIR_TGT_Range_L", "", STROKE_FNT_DFLT_120, "RightCenter", {450, -120}, operRoot_L.name, {{"MPD_FLIR_TGT_Range"}}, {"%5.1f TGT"})
addStrokeText("MPD_FLIR_TGT_Range_A", "", STROKE_FNT_DFLT_120, "RightCenter", {450, 30}, operRoot_A.name, {{"MPD_FLIR_TGT_Range"}}, {"%5.1f TGT"})

-- Coordinates
local FLIR_coords_root_L = addPlaceholder("FLIR_coords_root_L", {-410,410}, operRoot_L.name, {{"MPD_FLIR_LSS_ON", 0}})
addStrokeText("MPD_FLIR_coordinates_lat_L", "", STROKE_FNT_DFLT_100, "LeftCenter", {0, 0},	FLIR_coords_root_L.name,
				{{"MPD_FLIR_coordinates_display", 1}, {"MPD_FLIR_coordinates_Lat"}}, {"%c%3d°%02d.%02d'", "%c%3d°%02d'%02d\"", "%c%3d°%02d.%02d%02d'", "%c%3d°%02d'%02d.%02d\""})
addStrokeText("MPD_FLIR_coordinates_lon_L", "", STROKE_FNT_DFLT_100, "LeftCenter", {0, -30},	FLIR_coords_root_L.name,
				{{"MPD_FLIR_coordinates_display", 1}, {"MPD_FLIR_coordinates_Lon"}}, {"%c%3d°%02d.%02d'", "%c%3d°%02d'%02d\"", "%c%3d°%02d.%02d%02d'", "%c%3d°%02d'%02d.%02d\""})

addStrokeText("MPD_FLIR_coordinates_altitude_L",	"",		STROKE_FNT_DFLT_100, "LeftCenter", {0, -60}, FLIR_coords_root_L.name,
				{{"MPD_FLIR_coordinates_display", 1}, {"MPD_FLIR_coordinates_altitude"}}, {"%5d FT"})

-- Bullseye
addStrokeText("MPD_FLIR_Bullseye_L", "", STROKE_FNT_DFLT_120, "RightCenter", {410, 0},	FLIR_coords_root_L.name,
				{{"MPD_FLIR_Bullseye"}}, {"%03d°/%5.1f"})

-- Laser Status
local laserArmedRoot = addPlaceholder("MPD_FLIR_LaserArmed", {0,0}, operRoot.name, {{"MPD_FLIR_LaserAvail"}})
local laserArmedRoot_L = addPlaceholder("MPD_FLIR_LaserArmed_L", {0,0}, operRoot_L.name, {{"MPD_FLIR_LaserAvail"}})
local laserArmedRoot_A = addPlaceholder("MPD_FLIR_LaserArmed_A", {0,0}, operRoot_A.name, {{"MPD_FLIR_LaserAvail"}})
addStrokeText("MPD_FLIR_LaserStatus_label", "", STROKE_FNT_DFLT_120, "CenterCenter", {0, 400}, laserArmedRoot.name, {{"MPD_FLIR_LaserStatus_Label"}},
		{"", "L ARM", "M ARM", "LTD/R", "MARK", "LTD", "LTD/R", "MARK"})

-- LST tracking
addStrokeText("MPD_FLIR_LST_label", "LST", STROKE_FNT_DFLT_120, "CenterCenter", {00, 400}, operRoot.name, {{"MPD_FLIR_LST_Label"}})

-- Laser Codes
addStrokeText("MPD_FLIR_LTDC_label_L",	"CODE",	STROKE_FNT_DFLT_120, "RightCenter", {450, -194}, operRoot_L.name, {{"MPD_FLIR_LTDC_label", 0}})
addStrokeText("MPD_FLIR_LTDC_code_L",	"",		STROKE_FNT_DFLT_120, "RightCenter", {450, -224}, operRoot_L.name, {{"MPD_FLIR_LTDC_label", 1}}, {"%4d"})
addStrokeText("MPD_FLIR_LSTC_code_L",	"",		STROKE_FNT_DFLT_120, "CenterCenter", {171, -450}, operRoot_L.name, {{"MPD_FLIR_LSTC_label", 1}}, {"%4d"})

addStrokeText("MPD_FLIR_LSTC_label_A",	"LST",	STROKE_FNT_DFLT_120, "LeftCenter", {380, -149}, operRoot_A.name, {{"MPD_FLIR_LSTC_label", 0}})
addStrokeText("MPD_FLIR_LSTC_code_A",	"",		STROKE_FNT_DFLT_120, "LeftCenter", {380, -179}, operRoot_A.name, {{"MPD_FLIR_LSTC_label", 1}}, {"%4d"})
addStrokeText("MPD_FLIR_LTDC_code_A",	"",		STROKE_FNT_DFLT_120, "LeftCenter", {380, -209}, operRoot_A.name, {{"MPD_FLIR_LTDC_label", 1}}, {"%4d"})
addStrokeText("MPD_FLIR_LTDC_label_A",	"LTD/R",STROKE_FNT_DFLT_120, "LeftCenter", {380, -239}, operRoot_A.name, {{"MPD_FLIR_LTDC_label", 0}})

-- Pushbuttons
---------------------------------------------------
-- Only Litening PBs
add_PB_label(9, {"MARK", laserArmedRoot_L.name,  {{"MPD_FLIR_MARK_PB", 0}}, {{"MPD_FLIR_MARK_PB", 1}}})

add_PB_label(11, {"TRIG", laserArmedRoot_L.name, {{"MPD_FLIR_TRIG_PB", 0}}, {{"MPD_FLIR_TRIG_PB", 1}}})
add_PB_label(13, {"VVSLV", operRoot_L.name, {{"MPD_FLIR_VVSL_PB"}}, {{"MPD_FLIR_VVSL_Box"}}})
add_PB_label(14, {"UFC", operRoot_L.name, {{"MPD_FLIR_UFC_PB", 0}}, {{"MPD_FLIR_UFC_PB", 1}}})

---------------------------------------------------
-- Only ATFLIR PBs
add_PB_label(10, {"MVTGT", operRoot_A.name, {{"MPD_FLIR_SETUP_Label", 0}, {"MPD_AFLIR_MV_TGT"}}})

add_PB_label(11, {"TRIG", laserArmedRoot_A.name, {{"MPD_FLIR_SETUP_Label", 0}, {"MPD_FLIR_TRIG_PB", 0}}, {{"MPD_FLIR_SETUP_Label", 0}, {"MPD_FLIR_TRIG_PB", 1}}})
add_PB_label(13, {"VVSLV", operRoot_A.name, {{"MPD_FLIR_SETUP_Label", 0}, {"MPD_FLIR_VVSL_PB"}}, {{"MPD_FLIR_SETUP_Label", 0}, {"MPD_FLIR_VVSL_Box"}}})
add_PB_label(14, {"UFC", operRoot_A.name, {{"MPD_FLIR_SETUP_Label", 0}, {"MPD_FLIR_UFC_PB", 0}}, {{"MPD_FLIR_SETUP_Label", 0}, {"MPD_FLIR_UFC_PB", 1}}})

---------------------------------------------------
-- Both PBs
add_PB_label(17, {"LST", operRoot.name, nil, {{"MPD_FLIR_LSS_PB", 1}}})

