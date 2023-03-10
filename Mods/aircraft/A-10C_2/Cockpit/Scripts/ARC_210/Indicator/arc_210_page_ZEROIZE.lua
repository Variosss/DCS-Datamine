dofile(LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_useful_definitions.lua")

--AddBackground()

--local txt_label			= AddTempSettingLabel({"ZEROIZE IN PROGRESS", "ZEROIZE COMPLETE"})
local txt_label			= AddTempSettingLabel({"UNAVAILABLE", "UNAVAILABLE"})
txt_label.init_pos		= {max_pixels_count_x/2, max_pixels_count_y/2}
txt_label.alignment		= "CenterCenter"
