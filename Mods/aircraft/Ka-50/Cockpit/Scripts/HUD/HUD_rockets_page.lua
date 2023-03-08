dofile(LockOn_Options.script_path.."HUD\\HUD_definitions.lua")

rockets_piper = add_piper("rockets_piper", {{"current_sight"}})


add_piper_distance_sector("rockets_distance_sector", "rockets_piper")
add_piper_DLZ_tick  	 ("rockets_min_range_tick" , "rockets_piper", 0,10000)
add_piper_DLZ_tick  	 ("rockets_max_range_tick" , "rockets_piper", 2,10000)