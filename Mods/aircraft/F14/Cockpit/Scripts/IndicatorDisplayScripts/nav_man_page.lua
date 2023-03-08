--dofile(LockOn_Options.script_path.."Scripts/HorizontalSituationDisplay/Indicator/hsd_tools.lua")

fontsize = 0.0053

clip_box_in(0,0,135,160)

local grid_origin = create_origin()

--create_box(0,0,135, 155, BACKGROUND_MAT, artificial_horizon, h_clip_relations.DECREASE_IF_LEVEL ,HSD_DEFAULT_LEVEL + 1, true)

--dofile(LockOn_Options.script_path.."Scripts/HorizontalSituationDisplay/Indicator/nav_base_page.lua")
dofile(LockOn_Options.script_path.."Scripts/HorizontalSituationDisplay/Indicator/nav_text_comm_page.lua")


-- tcn brn hdg
local tcn_brn_hdg     = my_create_textured_box_2k(100,1746,150-100,1786-1746)--my_create_textured_box_2k(186,206,846,846)
	tcn_brn_hdg.name 	= create_guid_string() 
	tcn_brn_hdg.material = MDIG_MAT_A
    tcn_brn_hdg.vertices = tex_box_vert_shift(tcn_brn_hdg, 0, 2*(510+40))
	tcn_brn_hdg.init_pos = {0, 0, 0}
	tcn_brn_hdg.init_rot = {0, 0, 0}
	tcn_brn_hdg.parent_element = grid_origin.name
    tcn_brn_hdg.h_clip_relation = h_clip_relations.COMPARE -- COMPARE -- REWRITE_LEVEL
	--tcn_brn_hdg.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL
	tcn_brn_hdg.level			= HSD_DEFAULT_LEVEL
	tcn_brn_hdg.controllers = {{"tcn_bearing"}, {"mdig_bright"}}
AddElement(tcn_brn_hdg)

-- tcn brn tail
local tcn_brn_tail     = my_create_textured_box_2k(290,1900,340-290,1950-1900)--my_create_textured_box_2k(186,206,846,846)
	tcn_brn_tail.name 	= create_guid_string() 
	tcn_brn_tail.material = MDIG_MAT_A
    tcn_brn_tail.vertices = tex_box_vert_shift(tcn_brn_tail, 0, -2*(510+40))
	tcn_brn_tail.init_pos = {0, 0, 0}
	tcn_brn_tail.init_rot = {0, 0, 0}
	tcn_brn_tail.parent_element = tcn_brn_hdg.name
    tcn_brn_tail.h_clip_relation = h_clip_relations.COMPARE -- COMPARE -- REWRITE_LEVEL
	--tcn_brn_tail.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL
	tcn_brn_tail.level			= HSD_DEFAULT_LEVEL
	tcn_brn_tail.controllers = {{"mdig_bright"}}
AddElement(tcn_brn_tail)


-- MAN string
local man_string		= my_create_textured_box_2k(1670,140,1756-1670,176-140)--my_create_textured_box_2k(186,206,846,846)
	man_string.name 	= create_guid_string() 
	man_string.material = MDIG_MAT_A
	man_string.init_pos = element_init_pos_shift(0, 180, 0, 2048) --{0, 90/tex_dim*scale, 0}
	man_string.parent_element = grid_origin.name
    man_string.h_clip_relation = h_clip_relations.COMPARE -- COMPARE -- REWRITE_LEVEL
	--man_string.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL
	man_string.level			= HSD_DEFAULT_LEVEL
	man_string.controllers = {{"mdig_bright"}}
AddElement(man_string)


-- CRS mark
local crs_mark     = my_create_textured_box_2k(1790,55,1876-1790,91-55)--my_create_textured_box_2k(186,206,846,846)
	crs_mark.name 	= create_guid_string() 
	crs_mark.material = MDIG_MAT_A
	crs_mark.init_pos = element_init_pos_shift(1000, 1200, 0, 2048) --{500/tex_dim*scale, 600/tex_dim*scale, 0}
	crs_mark.init_rot = {0, 0, 0}
	crs_mark.parent_element = grid_origin.name
    crs_mark.h_clip_relation = h_clip_relations.COMPARE -- COMPARE -- REWRITE_LEVEL
	--crs_mark.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL
	crs_mark.level			= HSD_DEFAULT_LEVEL
	crs_mark.controllers = {{"mdig_bright"}}
AddElement(crs_mark)

-- CRS string
local crs_string           = CreateElement "ceStringPoly"
    crs_string.name            = create_guid_string()
    crs_string.material        = HSD_FONT_BASE --"font_NAV"
    crs_string.stringdefs    = {fontsize, fontsize, 0, 0}
    crs_string.init_pos        = element_init_pos_shift(1000, 1100, 0, 2048)
	crs_string.init_rot         = {0, 0, 0}
    crs_string.alignment     = "CenterCenter"
	crs_string.parent_element = grid_origin.name
    crs_string.h_clip_relation = h_clip_relations.COMPARE -- COMPARE -- REWRITE_LEVEL
	--crs_string.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL
	crs_string.level			= HSD_DEFAULT_LEVEL
	crs_string.use_mipfilter = true
	crs_string.additive_alpha = true
	crs_string.isdraw			 = true
	crs_string.change_opacity	 = false
	crs_string.isvisible		 = true
	crs_string.collimated = false
    --crs_string.stringdefs      = {compassnrheight,compassnrwidth, 0, 0}
    crs_string.formats		= {"%03.0f"}
    crs_string.controllers 		= {{"crs_select_str",0},{"mdig_bright"}}
    --crs_string.value         = "028.0"
Add(crs_string)



clip_box_out()

