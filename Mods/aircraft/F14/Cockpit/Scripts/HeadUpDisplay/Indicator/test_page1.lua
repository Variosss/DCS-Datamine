dofile(LockOn_Options.script_path.."Scripts/HeadUpDisplay/Indicator/definitions.lua")

--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------

clip_box_in(0,-25,200,200)

local grid_origin = create_origin()

-- aircraft reticle
-- 60mil wide, 10 mil high
local static_plane 			= my_create_textured_box_2k(2,429,234,82)
	static_plane.name 	= create_guid_string()
	static_plane.material = "HUD_MAT"
	static_plane.init_pos = {0, 0, 0}
	static_plane.parent_element = grid_origin.name
    static_plane.isdraw = true
AddBoxedHUDElement(static_plane)


clip_box_out(95,0,25,120)