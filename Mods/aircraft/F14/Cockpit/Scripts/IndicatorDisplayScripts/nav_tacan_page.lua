--dofile(LockOn_Options.script_path.."Scripts/HorizontalSituationDisplay/Indicator/hsd_tools.lua")

fontsize = 0.0053

clip_box_in(0,0,135,160)

local grid_origin = create_origin()
grid_origin.controllers = {{"show_tacan"}}

--create_box(0,0,135, 155, BACKGROUND_MAT, artificial_horizon, h_clip_relations.DECREASE_IF_LEVEL ,HSD_DEFAULT_LEVEL + 1, true)

--dofile(LockOn_Options.script_path.."Scripts/HorizontalSituationDisplay/Indicator/nav_base_page.lua")

-- aircraft
local ac_mark		= my_create_textured_box_2k(259,1527,122,145)--my_create_textured_box_2k(186,206,846,846)
	ac_mark.name 	= create_guid_string() 
	ac_mark.material = MDIG_MAT_A
	ac_mark.init_pos = {0, 0, 0}
	ac_mark.parent_element = grid_origin.name
    ac_mark.h_clip_relation = h_clip_relations.COMPARE -- COMPARE -- REWRITE_LEVEL
	--hdg_mark.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL
	ac_mark.level			= HSD_DEFAULT_LEVEL
	ac_mark.controllers = {{"mdig_bright"}}
AddElement(ac_mark)


-- tcn brn hdg
tcn_brn_hdg     = my_create_textured_box_2k(98,1744,54,44)--my_create_textured_box_2k(186,206,846,846)
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
tcn_brn_tail     = my_create_textured_box_2k(288,1898,340-290+4,1950-1900+4)--my_create_textured_box_2k(186,206,846,846)
	tcn_brn_tail.name 	= create_guid_string() 
	tcn_brn_tail.material = MDIG_MAT_A
    tcn_brn_tail.vertices = tex_box_vert_shift(tcn_brn_tail, 0, -2*((510+40)))
	tcn_brn_tail.init_pos = {0, 0, 0}
	tcn_brn_tail.init_rot = {0, 0, 0}
	tcn_brn_tail.parent_element = tcn_brn_hdg.name
    tcn_brn_tail.h_clip_relation = h_clip_relations.COMPARE -- COMPARE -- REWRITE_LEVEL
	--tcn_brn_tail.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL
	tcn_brn_tail.level			= HSD_DEFAULT_LEVEL
	--tcn_brn_tail.controllers = {{"tcn_bearing"}}
	tcn_brn_tail.controllers = {{"mdig_bright"}}
AddElement(tcn_brn_tail)

-- deviation tick
local deviation_tick     = my_create_textured_box_2k(1466,1496,548,108)--my_create_textured_box_2k(186,206,846,846)
	deviation_tick.name 	= create_guid_string() 
	deviation_tick.material = MDIG_MAT_A
	deviation_tick.init_pos = {0, 0, 0}
	deviation_tick.init_rot = {0, 0, 0}
	--deviation_tick.parent_element = grid_origin.name
    deviation_tick.parent_element = grid_origin.name
    deviation_tick.h_clip_relation = h_clip_relations.COMPARE -- COMPARE -- REWRITE_LEVEL
	--deviation_tick.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL
	deviation_tick.level			= HSD_DEFAULT_LEVEL
	deviation_tick.controllers = {{"crs_arrow"}, {"mdig_bright"}}
 AddElement(deviation_tick)


-- deviation bar
local deviation_bar     = my_create_textured_box_2k(460,1500,500-460,1800-1500+4)--my_create_textured_box_2k(186,206,846,846)
	deviation_bar.name 	= create_guid_string() 
	deviation_bar.material = MDIG_MAT_A
    deviation_bar.state_tex_coords = {
        --get_tex_coord(460,1500,500-460,1800-1500), -- default TO
        get_tex_coord(586,1500,626-586,1800-1500,2048,2048), -- FROM
    }
	deviation_bar.init_pos = {0, 0, 0}
	deviation_bar.init_rot = {0, 0, 0}
	deviation_bar.parent_element = deviation_tick.name
    deviation_bar.h_clip_relation = h_clip_relations.COMPARE -- COMPARE -- REWRITE_LEVEL
	--deviation_bar.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL
	deviation_bar.level			= HSD_DEFAULT_LEVEL
    deviation_bar.controllers = {{"crs_deviation"}, {"mdig_bright"}}
AddElement(deviation_bar)


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
    --rng_string.formats		= {"%03.1f"}
    rng_string.controllers 		= {{"mdig_bright"},{"rng_tacan_str",0}}
    --rng_string.value         = "028.0"
Add(rng_string)


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
    crs_string.controllers 		= {{"mdig_bright"},{"crs_select_str",0}}
    --crs_string.value         = "028.0"
Add(crs_string)


clip_box_out()

