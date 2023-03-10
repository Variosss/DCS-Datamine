dofile(LockOn_Options.script_path.."MFCD\\indicator\\COMM\\MFCD_COMM_common.lua")

------------------------------------------------------
-- Header
AddTextValComm("InventoryText",	"CenterTop",
	{max_pixels_count/2, (OSB_positions[20][2] + OSB_positions[19][2]) / 2 + 15},
	predefined_fonts[3], false,	nil, "COMM PAGE")

------------------------------------------------------
-- OSB 19
addOSB_LabelWSymb(19, "ARC210\nPRESETS", BRANCH_L)
add_osb_static_hint(19, "View ARC-210 Presets")


------------------------------------------------------
add_dummy_boxes({1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 16, 17, 18})
