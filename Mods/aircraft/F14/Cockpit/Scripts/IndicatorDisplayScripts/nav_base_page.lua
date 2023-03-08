--dofile(LockOn_Options.script_path.."Scripts/HorizontalSituationDisplay/Indicator/hsd_tools.lua")

clip_box_in(0,0,135,160)

local grid_origin = create_origin()

--create_box(0,0,135, 155, BACKGROUND_MAT, artificial_horizon, h_clip_relations.DECREASE_IF_LEVEL ,HSD_DEFAULT_LEVEL + 1, true)


-- compass
compass 			= my_create_textured_box_2k(50,50,1050-50,1050-50)--my_create_textured_box_2k(186,206,846,846)
	compass.name 	= create_guid_string() 
	compass.material = MDIG_MAT_A
	compass.init_pos = {0, 0, 0}
	compass.controllers = {{"compass"}, {"mdig_bright"}}
	compass.parent_element = grid_origin.name
AddElement(compass)


-- hdg mark
hdg_mark		= my_create_textured_box_2k(98,1898,94,94)--my_create_textured_box_2k(186,206,846,846)
	hdg_mark.name 	= create_guid_string() 
	hdg_mark.material = MDIG_MAT_A
	hdg_mark.init_pos = element_init_pos_shift(0, 2*(510-45), 0, 2048) --{0, (510-45)/tex_dim*scale, 0}
	hdg_mark.parent_element = grid_origin.name
    hdg_mark.h_clip_relation = h_clip_relations.COMPARE -- COMPARE -- REWRITE_LEVEL
	--hdg_mark.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL
	hdg_mark.level			= HSD_DEFAULT_LEVEL
	hdg_mark.controllers = {{"mdig_bright"}}
AddElement(hdg_mark)

-- tail mark
tail_mark		= my_create_textured_box_2k(98,1898,94,94)--my_create_textured_box_2k(186,206,846,846)
	tail_mark.name 	= create_guid_string() 
	tail_mark.material = MDIG_MAT_A
	tail_mark.init_pos = element_init_pos_shift(0, -2*(510-45), 0, 2048) --{0, -(510-45)/tex_dim*scale, 0}
	tail_mark.parent_element = grid_origin.name
    tail_mark.h_clip_relation = h_clip_relations.COMPARE -- COMPARE -- REWRITE_LEVEL
	--tail_mark.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL
	tail_mark.level			= HSD_DEFAULT_LEVEL
	tail_mark.controllers = {{"mdig_bright"}}
AddElement(tail_mark)


-- course selected
crs_arrow         = my_create_textured_box_2k(1720,1140,1760-1720,2000-1140)--my_create_textured_box_2k(186,206,846,846)
	crs_arrow.name 	= "hsd_course_arrow"
	crs_arrow.material = MDIG_MAT_A
	crs_arrow.init_pos = {0, 0, 0}
	crs_arrow.init_rot = {0, 0, 0}
	crs_arrow.parent_element = grid_origin.name
    crs_arrow.h_clip_relation = h_clip_relations.COMPARE -- COMPARE -- REWRITE_LEVEL
	--crs_arrow.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL
	crs_arrow.level			= HSD_DEFAULT_LEVEL
	crs_arrow.controllers = {{"crs_arrow"}, {"mdig_bright"}}
AddElement(crs_arrow)

-- heading selected
hdg_select    = my_create_textured_box_2k(100,1550,170-100,1600-1550)--my_create_textured_box_2k(186,206,846,846)
	hdg_select.name 	= create_guid_string() 
	hdg_select.material = MDIG_MAT_A
    hdg_select.vertices = tex_box_vert_shift(hdg_select, 0, 2*(510+25))
	hdg_select.init_pos = {0, 0, 0}
	hdg_select.init_rot = {0, 0, 0}
	hdg_select.parent_element = grid_origin.name
    hdg_select.h_clip_relation = h_clip_relations.COMPARE -- COMPARE -- REWRITE_LEVEL
	--hdg_select.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL
	hdg_select.level			= HSD_DEFAULT_LEVEL
	hdg_select.controllers = {{"hdg_selected"}, {"mdig_bright"}}
AddElement(hdg_select)



-- ADF bearing
adf_brn    = my_create_textured_box_2k(288,1708,362-288,1802-1708)--my_create_textured_box_2k(186,206,846,846)
	adf_brn.name 	= create_guid_string() 
	adf_brn.material = MDIG_MAT_A
    adf_brn.vertices = tex_box_vert_shift(adf_brn, 0, 2*(510-120))
	adf_brn.init_pos = {0, 0, 0}
	adf_brn.init_rot = {0, 0, 0}
	adf_brn.parent_element = grid_origin.name
    adf_brn.h_clip_relation = h_clip_relations.COMPARE -- COMPARE -- REWRITE_LEVEL
	--adf_brn.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL
	adf_brn.level			= HSD_DEFAULT_LEVEL
	adf_brn.controllers = {{"mdig_bright"},{"datablock6_adf"},{"adf_bearing"}}
AddElement(adf_brn)



-- ATT REF source




clip_box_out()

