--dofile(LockOn_Options.script_path.."Scripts/HorizontalSituationDisplay/Indicator/hsd_tools.lua")


clip_box_in(0,0,135,160)

local grid_origin = create_origin()

--create_box(0,0,135, 155, BACKGROUND_MAT, artificial_horizon, h_clip_relations.DECREASE_IF_LEVEL ,HSD_DEFAULT_LEVEL + 1, true)

--dofile(LockOn_Options.script_path.."Scripts/HorizontalSituationDisplay/Indicator/nav_base_page.lua")
dofile(LockOn_Options.script_path.."Scripts/HorizontalSituationDisplay/Indicator/nav_text_comm_page.lua")

-- VEC string
local vec_string		= my_create_textured_box_2k(1500,140,1578-1500,176-140)--my_create_textured_box_2k(186,206,846,846)
	vec_string.name 	= create_guid_string() 
	vec_string.material = MDIG_MAT_A
	vec_string.init_pos = element_init_pos_shift(0, 180, 0, 2048) --{0, 90/tex_dim*scale, 0}
	vec_string.parent_element = grid_origin.name
    vec_string.h_clip_relation = h_clip_relations.COMPARE -- COMPARE -- REWRITE_LEVEL
	--vec_string.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL
	vec_string.level			= HSD_DEFAULT_LEVEL
	vec_string.controllers = {{"mdig_bright"}}
AddElement(vec_string)


clip_box_out()

