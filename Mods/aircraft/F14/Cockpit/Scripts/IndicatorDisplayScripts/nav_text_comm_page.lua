--dofile(LockOn_Options.script_path.."Scripts/HorizontalSituationDisplay/Indicator/hsd_tools.lua")

--clip_box_in(0,0,135,160)
fontsize = 0.0045
fontshrink = -0.0003

local grid_origin = create_origin()

--create_box(0,0,135, 155, BACKGROUND_MAT, artificial_horizon, h_clip_relations.DECREASE_IF_LEVEL ,HSD_DEFAULT_LEVEL + 1, true)


-- WIND
wind_string		= my_create_textured_box_2k(1920,140,1956-1920,176-140)--my_create_textured_box_2k(186,206,846,846)
	wind_string.name 	= create_guid_string() 
	wind_string.material = MDIG_MAT_A
	wind_string.init_pos = element_init_pos_shift(-180, 60, 0, 2048) --{-90/tex_dim*scale, 30/tex_dim*scale, 0}
	wind_string.parent_element = grid_origin.name
    wind_string.h_clip_relation = h_clip_relations.COMPARE -- COMPARE -- REWRITE_LEVEL
	--wind_string.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL
	wind_string.level			= HSD_DEFAULT_LEVEL
	wind_string.controllers = {{"mdig_bright"},{"datablock6_text"}}
AddElement(wind_string)

-- WIND slash
wind_slash		= my_create_textured_box_2k(1403,231,1424-1403,263-231)--my_create_textured_box_2k(186,206,846,846)
	wind_slash.name 	= create_guid_string() 
	wind_slash.material = MDIG_MAT_A
	wind_slash.init_pos = element_init_pos_shift(32, 60, 0, 2048) --{16/tex_dim*scale, 30/tex_dim*scale, 0}
	wind_slash.parent_element = grid_origin.name
    wind_slash.h_clip_relation = h_clip_relations.COMPARE -- COMPARE -- REWRITE_LEVEL
	--wind_slash.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL
	wind_slash.level			= HSD_DEFAULT_LEVEL
	wind_slash.controllers = {{"mdig_bright"},{"datablock6_text"}}
AddElement(wind_slash)


-- wind dir string
local wind_dir_string           = CreateElement "ceStringPoly"
    wind_dir_string.name            = create_guid_string()
    wind_dir_string.material        = HSD_FONT_BASE --"font_NAV"
    wind_dir_string.stringdefs    = {fontsize, fontsize, fontshrink, 0}
    wind_dir_string.init_pos        = element_init_pos_shift(-70, 60, 0, 2048)
	wind_dir_string.init_rot         = {0, 0, 0}
    wind_dir_string.alignment     = "CenterCenter"
	wind_dir_string.parent_element = grid_origin.name
    wind_dir_string.h_clip_relation = h_clip_relations.COMPARE -- COMPARE -- REWRITE_LEVEL
	--wind_dir_string.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL
	wind_dir_string.level			= HSD_DEFAULT_LEVEL
	wind_dir_string.use_mipfilter = true
	wind_dir_string.additive_alpha = true
	wind_dir_string.isdraw			 = true
	wind_dir_string.change_opacity	 = false
	wind_dir_string.isvisible		 = true
	wind_dir_string.collimated = false
    --wind_dir_string.stringdefs      = {compassnrheight,compassnrwidth, 0, 0}
    wind_dir_string.formats		= {"%03d"}
    wind_dir_string.controllers 		= {{"mdig_bright"},{"datablock6_text"},{"wind_dir_str",0}}
    --wind_dir_string.value         = "028.0"
Add(wind_dir_string)

-- wind speed string
local wind_speed_string           = CreateElement "ceStringPoly"
    wind_speed_string.name            = create_guid_string()
    wind_speed_string.material        = HSD_FONT_BASE--HSD_FONT_GREEN --"font_NAV"
    wind_speed_string.stringdefs    = {fontsize, fontsize, fontshrink, 0}
    wind_speed_string.init_pos        = element_init_pos_shift(130, 60, 0, 2048)
	wind_speed_string.init_rot         = {0, 0, 0}
    wind_speed_string.alignment     = "CenterCenter"
	wind_speed_string.parent_element = grid_origin.name
    wind_speed_string.h_clip_relation = h_clip_relations.COMPARE -- COMPARE -- REWRITE_LEVEL
	--wind_speed_string.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL
	wind_speed_string.level			= HSD_DEFAULT_LEVEL
	wind_speed_string.use_mipfilter = true
	wind_speed_string.additive_alpha = true
	wind_speed_string.isdraw			 = true
	wind_speed_string.change_opacity	 = false
	wind_speed_string.isvisible		 = true
	wind_speed_string.collimated = false
    --wind_speed_string.stringdefs      = {compassnrheight,compassnrwidth, 0, 0}
    wind_speed_string.formats		= {"%03d"}
    wind_speed_string.controllers 		= {{"mdig_bright"},{"datablock6_text"},{"wind_speed_str",0}}
    --wind_speed_string.value         = "028.0"
Add(wind_speed_string)


-- TAS
tas_string     = my_create_textured_box_2k(1412,55,1496-1412,91-55)--my_create_textured_box_2k(186,206,846,846)
	tas_string.name 	= create_guid_string() 
	tas_string.material = MDIG_MAT_A
	tas_string.init_pos = element_init_pos_shift(-144, -60, 0, 2048) --{-72/tex_dim*scale, -30/tex_dim*scale, 0}
	tas_string.init_rot = {0, 0, 0}
	tas_string.parent_element = grid_origin.name
    tas_string.h_clip_relation = h_clip_relations.COMPARE -- COMPARE -- REWRITE_LEVEL
	--tas_string.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL
	tas_string.level			= HSD_DEFAULT_LEVEL
	tas_string.controllers = {{"mdig_bright"},{"datablock6_text"}}
AddElement(tas_string)


-- GS
gs_string     = my_create_textured_box_2k(1300,55,1352-1300,91-55)--my_create_textured_box_2k(186,206,846,846)
	gs_string.name 	= create_guid_string() 
	gs_string.material = MDIG_MAT_A
	gs_string.init_pos = element_init_pos_shift(-144, -180, 0, 2048) --{-72/tex_dim*scale, -90/tex_dim*scale, 0}
	gs_string.init_rot = {0, 0, 0}
	gs_string.parent_element = grid_origin.name
    gs_string.h_clip_relation = h_clip_relations.COMPARE -- COMPARE -- REWRITE_LEVEL
	--gs_string.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL
	gs_string.level			= HSD_DEFAULT_LEVEL
	gs_string.controllers = {{"mdig_bright"},{"datablock6_text"}}
AddElement(gs_string)



-- TAS string
tas_string           = CreateElement "ceStringPoly"
    tas_string.name            = "tas_string"
    tas_string.material        = HSD_FONT_BASE --"font_NAV"
    tas_string.stringdefs    = {fontsize, fontsize, 0, 0}
    tas_string.init_pos        = element_init_pos_shift(-40, -60, 0, 2048)
	tas_string.init_rot         = {0, 0, 0}
    tas_string.alignment     = "LeftCenter"
	tas_string.parent_element = grid_origin.name
    tas_string.h_clip_relation = h_clip_relations.COMPARE -- COMPARE -- REWRITE_LEVEL
	--tas_string.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL
	tas_string.level			= HSD_DEFAULT_LEVEL
	tas_string.use_mipfilter = true
	tas_string.additive_alpha = true
	tas_string.isdraw			 = true
	tas_string.change_opacity	 = false
	tas_string.isvisible		 = true
	tas_string.collimated = false
    --tas_string.stringdefs      = {compassnrheight,compassnrwidth, 0, 0}
    tas_string.formats		= {"%04d"}
    tas_string.controllers 		= {{"mdig_bright"},{"datablock6_text"},{"tas_str",0}}
    --tas_string.value         = "028.0"
Add(tas_string)

-- GS string
gs_string           = CreateElement "ceStringPoly"
    gs_string.name            = create_guid_string()
    gs_string.material        = HSD_FONT_BASE --"font_NAV"
    gs_string.stringdefs    = {fontsize, fontsize, 0, 0}
    gs_string.init_pos        = element_init_pos_shift(-60, -180, 0, 2048)
	gs_string.init_rot         = {0, 0, 0}
    gs_string.alignment     = "LeftCenter"
	gs_string.parent_element = grid_origin.name
    gs_string.h_clip_relation = h_clip_relations.COMPARE -- COMPARE -- REWRITE_LEVEL
	--gs_string.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL
	gs_string.level			= HSD_DEFAULT_LEVEL
	gs_string.use_mipfilter = true
	gs_string.additive_alpha = true
	gs_string.isdraw			 = true
	gs_string.change_opacity	 = false
	gs_string.isvisible		 = true
	gs_string.collimated = false
    --gs_string.stringdefs      = {compassnrheight,compassnrwidth, 0, 0}
    gs_string.formats		= {"%04d"}
    gs_string.controllers 		= {{"mdig_bright"},{"datablock6_text"},{"gs_str",0}}
    --gs_string.value         = "028.0"
Add(gs_string)


--clip_box_out()

