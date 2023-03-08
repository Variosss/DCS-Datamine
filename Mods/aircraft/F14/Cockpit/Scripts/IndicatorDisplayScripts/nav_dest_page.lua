--dofile(LockOn_Options.script_path.."Scripts/HorizontalSituationDisplay/Indicator/hsd_tools.lua")

fontsize = 0.005

clip_box_in(0,0,135,160)

local grid_origin = create_origin()

--create_box(0,0,135, 155, BACKGROUND_MAT, artificial_horizon, h_clip_relations.DECREASE_IF_LEVEL ,HSD_DEFAULT_LEVEL + 1, true)

--dofile(LockOn_Options.script_path.."Scripts/HorizontalSituationDisplay/Indicator/nav_base_page.lua")
dofile(LockOn_Options.script_path.."Scripts/HorizontalSituationDisplay/Indicator/nav_text_comm_page.lua")


-- tcn brn hdg
tcn_brn_hdg     = my_create_textured_box_2k(100,1746,150-100,1786-1746)--my_create_textured_box_2k(186,206,846,846)
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
tcn_brn_tail     = my_create_textured_box_2k(290,1900,340-290,1950-1900)--my_create_textured_box_2k(186,206,846,846)
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


-- DEST mark
local dest_string		= my_create_textured_box_2k(1550,55,1657-1550,91-55)--my_create_textured_box_2k(186,206,846,846)
	dest_string.name 	= create_guid_string() 
	dest_string.material = MDIG_MAT_A
	dest_string.init_pos = element_init_pos_shift(0, 180, 0, 2048) --{0, 90/tex_dim*scale, 0}
	dest_string.parent_element = grid_origin.name
    dest_string.h_clip_relation = h_clip_relations.COMPARE -- COMPARE -- REWRITE_LEVEL
	--dest_string.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL
	dest_string.level			= HSD_DEFAULT_LEVEL
	dest_string.controllers = {{"mdig_bright"}}
AddElement(dest_string)



-- RNG mark
local rng_mark     = my_create_textured_box_2k(1910,55,1994-1910,91-55)--my_create_textured_box_2k(186,206,846,846)
	rng_mark.name 	= create_guid_string() 
	rng_mark.material = MDIG_MAT_A
	rng_mark.init_pos = element_init_pos_shift(-1000, 1200, 0, 2048) --{-500/tex_dim*scale, 600/tex_dim*scale, 0}
	rng_mark.init_rot = {0, 0, 0}
	rng_mark.parent_element = grid_origin.name
    rng_mark.h_clip_relation = h_clip_relations.COMPARE -- COMPARE -- REWRITE_LEVEL
	--rng_mark.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL
	rng_mark.level			= HSD_DEFAULT_LEVEL
	rng_mark.controllers = {{"mdig_bright"}}
AddElement(rng_mark)


-- RNG string
local rng_string           = CreateElement "ceStringPoly"
    rng_string.name            = create_guid_string()
    rng_string.material        = HSD_FONT_BASE --"font_NAV"
    rng_string.stringdefs    = {fontsize, fontsize, 0, 0}
    rng_string.init_pos        = element_init_pos_shift(-1000, 1100, 0, 2048)
	rng_string.init_rot         = {0, 0, 0}
    rng_string.alignment     = "CenterCenter"
	rng_string.parent_element = grid_origin.name
    rng_string.h_clip_relation = h_clip_relations.COMPARE -- COMPARE -- REWRITE_LEVEL
	--rng_string.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL
	rng_string.level			= HSD_DEFAULT_LEVEL
	rng_string.use_mipfilter = true
	rng_string.additive_alpha = true
	rng_string.isdraw			 = true
	rng_string.change_opacity	 = false
	rng_string.isvisible		 = true
	rng_string.collimated = false
    --rng_string.stringdefs      = {compassnrheight,compassnrwidth, 0, 0}
    --rng_string.formats		= {"%03f"}
    rng_string.controllers 		= {{"mdig_bright"},{"rng_dest_str",0}}
    --rng_string.value         = "028.0"
Add(rng_string)




clip_box_out()

