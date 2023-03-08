dofile(LockOn_Options.script_path.."Scripts/HeadUpDisplay/Indicator/definitions.lua")
-------------------------------------------------------------

clip_box_in(0,-25,200,200)

local grid_origin = create_origin()

local movable_reticle 			= my_create_textured_box_2k(286,146,233,233)
	movable_reticle.name 	= create_guid_string()
	movable_reticle.material = "HUD_MAT"
	movable_reticle.init_pos = {0, 0, 0}
	movable_reticle.parent_element = grid_origin.name
	movable_reticle.isdraw = true
AddBoxedHUDElement(movable_reticle)

clip_box_out(95,0,25,120)