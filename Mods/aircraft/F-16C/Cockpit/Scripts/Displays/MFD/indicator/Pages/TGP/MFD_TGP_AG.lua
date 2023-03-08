dofile(LockOn_Options.script_path.."Displays/MFD/indicator/MFD_Symbology.lua")
dofile(LockOn_Options.script_path.."Displays/MFD/indicator/Pages/TGP/MFD_TGP_tools.lua")
dofile(LockOn_Options.script_path.."Displays/MFD/indicator/Pages/SMS/MFD_SMS_tools.lua")

-- On/Off placeholder
local flirRoot = addPlaceholder("TGP_Root", {0,0})
local operPlaceholder = addPlaceholder("TGP_OnOff", {0,0}, nil, {{"TGP_OperPlaceholder", 1}})
local videoOnPlaceholder = addPlaceholder("TGP_VideoOn", {0,0}, operPlaceholder.name, {{"TGP_VideoOn"}})
--
local TGP_NoModeMenu = addPlaceholder("TGP_NoModeMenu_Root", {0, 0}, operPlaceholder.name, {{"TGP_ModeMenu", 0}})

-- Laser Status
addStrokeText("TGP_LaserStatus_label", "L", STROKE_FNT_DFLT_8_12, "CenterCenter", {60, -140}, TGP_NoModeMenu.name, {{"TGP_LaserStatus_Label"}})
addStrokeText("TGP_MarkerStatus_label", "PTR", STROKE_FNT_DFLT_8_12, "CenterCenter", {90, -140}, TGP_NoModeMenu.name, {{"TGP_MarkerStatus_Label"}})
addStrokeText("TGP_LaserCode", "", STROKE_FNT_DFLT_8_12, "CenterCenter", {0, -194}, TGP_NoModeMenu.name, {{"TGP_LaserCode"}})

-- Laser Codes
addStrokeText("TGP_LSS_code",	"",		STROKE_FNT_DFLT_8_12, "RightCenter", {180, 110}, TGP_NoModeMenu.name, {{"TGP_LSS_code"}})
local lssRoot = addStrokeText("TGP_LSS_label",	"LSS",	STROKE_FNT_DFLT_8_12, "RightCenter", {180, 85}, TGP_NoModeMenu.name)
addStrokeBox("TGP_LSS_Active", 30, 16, "RightCenter", {2,0}, lssRoot.name, {{"TGP_lss_active"}})

-- Range
addStrokeText("TGP_Range", nil, STROKE_FNT_DFLT_8_12, "RightCenter", {-130, -200}, TGP_NoModeMenu.name, {{"TGP_Range"}})

local TGP_coords_root = addPlaceholder("TGP_coords_root", {-65,190}, TGP_NoModeMenu.name, {{"TGP_LSS_ON", 0}})
addStrokeText("TGP_coordinates_lat_lon",	"",		STROKE_FNT_DFLT_8_12, "RightCenter", {0, 0}, TGP_coords_root.name,
				{{"TGP_coordinates_display", 1}, {"TGP_coordinates_LL"}}, {"%02.f %06.3f\n%02.f %06.3f\n", "%.f", "%.f"})

addStrokeText("TGP_coordinates_altitude",	"",		STROKE_FNT_DFLT_8_12, "RightCenter", {0, -18}, TGP_coords_root.name,
				{{"TGP_coordinates_display", 1, 2}, {"TGP_coordinates_altitude", 3.28}}, {"%.f"})

-- Maverick
local maverick_root = addPlaceholder("Maverick_root", nil, nil, {{"SMS_AG_isMaverick"}})
local staLeft_root = addPlaceholder("StaLeft_root", {-170, -140}, maverick_root.name)
local staRight_root = addPlaceholder("StaRight_root", {170, -140}, maverick_root.name)

addTgpMaverickHandoff("SMS_AG_Mav", maverick_root.name, 3, {{"SMS_AG_LoadedWeapon", 3}}, {"SMS_AG_SelectedStation", 3})
addTgpMaverickHandoff("SMS_AG_Mav", maverick_root.name, 7, {{"SMS_AG_LoadedWeapon", 7}}, {"SMS_AG_SelectedStation", 7})

---------------------------------------------------
-- OSBs
add_PB_label(2, "    ",	TGP_NoModeMenu.name, {{"MFD_Declutter"}, {"TGP_HandoffLabel"}}, nil, {"MAN", "AUTO"})

add_PB_label(7, "NT",	TGP_NoModeMenu.name, {{"MFD_Declutter"}})
add_Selectable_PB_Label(8, "S\nP",	TGP_NoModeMenu.name, {{"MFD_Declutter"}, {"TGP_SnowplowLabel"}, {"TGP_SnowplowSelected", 0}}, {{"TGP_SnowplowSelected", 1}})
add_PB_label(9, "CZ",	TGP_NoModeMenu.name, {{"MFD_Declutter"}, {"TGP_CZ_LabelShow"}})
add_PB_label(10, "TGT",	TGP_NoModeMenu.name, {{"MFD_Declutter"}, {"TGP_SPI_Label"}}, nil, {"S\nT\nP", "O\nA\n1", "O\nA\n2", "T\nG\nT", "I\nP", "R\nP"})