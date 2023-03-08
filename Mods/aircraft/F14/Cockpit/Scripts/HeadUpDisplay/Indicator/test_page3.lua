dofile(LockOn_Options.script_path.."Scripts/HeadUpDisplay/Indicator/definitions.lua")
-------------------------------------------------------------

clip_box_in(0,-25,200,200)

local grid_origin = create_origin()

-- pullup cue  30mil wide, 10 mil high
local pullup_cue 			= my_create_textured_box_2k(335,467,121,46,nil,nil,508)
	pullup_cue.name 	= create_guid_string()
	pullup_cue.material = "HUD_MAT"
	pullup_cue.init_pos = {0, 0, 0}
	pullup_cue.parent_element = grid_origin.name
	pullup_cue.isdraw = true
AddBoxedHUDElement(pullup_cue)

clip_box_out(95,0,25,120)