--dofile(LockOn_Options.script_path.."Scripts/HorizontalSituationDisplay/Indicator/hsd_tools.lua")

clip_box_in(0,0,135,160)

local grid_origin = create_origin()

--create_box(0,0,135, 155, BACKGROUND_MAT, artificial_horizon, h_clip_relations.DECREASE_IF_LEVEL ,HSD_DEFAULT_LEVEL + 1, true)


-- datablock1
datablock1 			= my_create_textured_box_2k(48,1818,184,184)--my_create_textured_box_2k(186,206,846,846)
	datablock1.name 	= create_guid_string() 
	datablock1.material = MDIG_MAT_B
	datablock1.init_pos = element_init_pos_shift(924, 1000, 0, 2048) --{500/tex_dim*scale, 600/tex_dim*scale, 0}
	datablock1.parent_element = grid_origin.name
	datablock1.controllers = {{"mdig_bright"}}
AddElement(datablock1)


-- datablock2
datablock2 			= my_create_textured_box_2k(368,1818,184,184)--my_create_textured_box_2k(186,206,846,846)
	datablock2.name 	= create_guid_string() 
	datablock2.material = MDIG_MAT_B
	datablock2.init_pos = element_init_pos_shift(-924, 1000, 0, 2048) --{-500/tex_dim*scale, 600/tex_dim*scale, 0}
	datablock2.parent_element = grid_origin.name
	datablock2.controllers = {{"mdig_bright"}}
AddElement(datablock2)

-- datablock3
datablock3			= my_create_textured_box_2k(48,1598,214,134)--my_create_textured_box_2k(186,206,846,846)
	datablock3.name 	= create_guid_string() 
	datablock3.material = MDIG_MAT_B
	datablock3.init_pos = element_init_pos_shift(0, -1224, 0, 2048) --{0, -(510-45)/tex_dim*scale, 0}
	datablock3.parent_element = grid_origin.name
	datablock3.controllers = {{"mdig_bright"}}
AddElement(datablock3)



clip_box_out()

