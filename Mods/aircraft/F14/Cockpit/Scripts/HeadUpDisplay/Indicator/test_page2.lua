dofile(LockOn_Options.script_path.."Scripts/HeadUpDisplay/Indicator/definitions.lua")

clip_box_in(0,-25,200,200)

local grid_origin = create_origin()

-- 30mil wide, 15mil high
local velocity_vector 			= my_create_textured_box_2k(59,345,121,83)
	velocity_vector.name 	= create_guid_string()
	velocity_vector.material = "HUD_MAT"
	velocity_vector.init_pos = {0, 0, 0}
	velocity_vector.parent_element = grid_origin.name
	velocity_vector.isdraw = true
AddBoxedHUDElement(velocity_vector)


clip_box_out(95,0,25,120)