dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/MPD_page_defs.lua")

local Compass_root = addPlaceholder("MPD_ACL_Compass_root", {0, 0}, nil, {{"MPD_ACL_Compass"}})
drawCompass(400, Compass_root.name, {{"MPD_ACL_Compass_Label"}})
addStrokeSymbol("MPD_ACL_Aircraft", {"stroke_symbols_MDI_AMPCD", "136-aircraft"}, "FromSet", {0, 0}, nil)
local Ground_Track_Pointer_root = addPlaceholder("MPD_ACL_Ground_Track_Pointer_root", {0, 0}, Compass_root.name, {{"MPD_ACL_GroundTrack"}})
addStrokeSymbol("MPD_ACL_Ground_Track_Pointer", {"stroke_symbols_MDI_AMPCD", "130-ground-track-pointer"}, "FromSet", {0, 355}, Ground_Track_Pointer_root.name)
addStrokeCircle("MPD_ACL_Circle", 200, {0, 0})
local CommandHeading_root = addPlaceholder("MPD_ACL_CommandHeading_root", {0, 0}, Compass_root.name, {{"MPD_ACL_CommandHeading"}})
addStrokeSymbol("MPD_ACL_CommandHeading", {"stroke_symbols_MDI_AMPCD", "command_heading"}, "FromSet", {0, 420}, CommandHeading_root.name)

addStrokeText("ACL_Command_Airspeed", 		"           ",		STROKE_FNT_DFLT_120, "RightCenter", {-110, 460}, nil, {{"MPD_ACL_Command_Airspeed"}},
	{"CMD A/S %3d", "CMD A/S    "})
addStrokeLine("ACL_Command_Airspeed_Changed", 	214, {-110, 442}, 90, nil, {{"MPD_ACL_Command_Airspeed_Changed"}})
addStrokeText("ACL_Command_Altitude", 		"             ",	STROKE_FNT_DFLT_120, "RightCenter", {-110, 424}, nil, {{"MPD_ACL_Command_Altitude"}},
	{"CMD ALT %5d", "CMD ALT      "})
addStrokeLine("ACL_Command_Altitude_Changed", 	254, {-110, 406}, 90, nil, {{"MPD_ACL_Command_Altitude_Changed"}})
addStrokeText("ACL_Command_RoD_label", 		"CMD ROD",			STROKE_FNT_DFLT_120, "RightCenter", {-310, 388})
addStrokeLine("ACL_Command_RoD_Changed", 		134, {-310, 370}, 90, nil, {{"MPD_ACL_Command_RoD_Changed"}})
addStrokeText("ACL_Command_RateOfDescent", 	"       ",			STROKE_FNT_DFLT_120, "RightCenter", {-310, 352}, nil, {{"MPD_ACL_Command_RoD"}}, {"%7d"})

-- Window R1
addStrokeText("ACL_Window_R1", "        ",	STROKE_FNT_DFLT_120, "LeftCenter", {110, 460}, nil, {{"MPD_ACL_Window_R1"}},
	{"", "ACL RDY", "CMD CNT", "LND CHK", "NOT CMD", "W/O", "CHG CHNL"})
addStrokeLine("ACL_Window_R1_Changed", 154, {110, 442}, -90, nil, {{"MPD_ACL_Window_R1_Changed"}})
-- Window R2
addStrokeText("ACL_Window_R2", "      ",	STROKE_FNT_DFLT_120, "LeftCenter", {110, 424}, nil, {{"MPD_ACL_Window_R2"}},
	{"", "MODE 1", "MODE 2", "T/C", "TILT"})
addStrokeLine("ACL_Window_R2_Changed", 114, {110, 406}, -90, nil, {{"MPD_ACL_Window_R2_Changed"}})
-- Window R3
addStrokeText("ACL_Window_R3", "       ",	STROKE_FNT_DFLT_120, "LeftCenter", {310, 388}, nil, {{"MPD_ACL_Window_R3"}},
	{"", "10 SEC", "ADJ A/C", "VOICE"})
addStrokeLine("ACL_Window_R3_Changed", 134, {310, 370}, -90, nil, {{"MPD_ACL_Window_R3_Changed"}})
-- Window R4
addStrokeText("ACL_Window_R4", "       ",	STROKE_FNT_DFLT_120, "LeftCenter", {310, 352}, nil, {{"MPD_ACL_Window_R4"}},
	{"", "ACL 1", "ACL 2", "ACL N/A", "TEST"})
-- Window R5
addStrokeText("ACL_Window_R5", "UTM FAIL",	STROKE_FNT_DFLT_120, "LeftCenter", {310, 316}, nil, {{"MPD_ACL_Window_R5"}})
	


-- PBs
add_PB_label(8, {"       ", nil, {{"MPD_ACL_Scale"}}})
