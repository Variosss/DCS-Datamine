--dofile(LockOn_Options.script_path.."Scripts/HorizontalSituationDisplay/Indicator/hsd_tools.lua")

clip_box_in(0,0,135,160)

local grid_origin = create_origin()
grid_origin.init_pos = {0, 0, 0}

big_plate          = my_create_textured_box_2k(25,1058,987-25,2020-1058)--my_create_textured_box_2k(186,206,846,846)
	big_plate.name 	= create_guid_string() 
	big_plate.material = MDIG_MAT_C
	big_plate.init_pos = {0, 0, 0}
	big_plate.parent_element = grid_origin.name
	big_plate.controllers = {{"mdig_bright"}}
AddElement(big_plate)


lubberline          = my_create_textured_box_2k(1980,417,2022-1980,923-417)--my_create_textured_box_2k(186,206,846,846)
	lubberline.name 	= create_guid_string() 
	lubberline.material = MDIG_MAT_C
    lubberline.vertices = tex_box_vert_shift(lubberline, 0, 500)
	lubberline.init_pos = {0, 0, 0} --{-500/tex_dim*scale, 600/tex_dim*scale, 0}
	lubberline.parent_element = grid_origin.name
	lubberline.controllers = {{"mdig_bright"}, {"compass"}}
AddElement(lubberline)
--AddMaskLevel(lubberline, HSD_DEFAULT_LEVEL)


left_circle          = my_create_textured_box_2k(1058,267,1195-1058,404-267)--my_create_textured_box_2k(186,206,846,846)
	left_circle.name 	= create_guid_string()
	left_circle.material = MDIG_MAT_C
	left_circle.init_pos = {-1, 0.85, 0} --{-500/tex_dim*scale, 600/tex_dim*scale, 0}
	left_circle.parent_element = grid_origin.name
	left_circle.controllers = {{"mdig_bright"}}
AddElement(left_circle)

right_circle          = my_create_textured_box_2k(1058,267,1195-1058,404-267)--my_create_textured_box_2k(186,206,846,846)
	right_circle.name 	= create_guid_string() 
	right_circle.material = MDIG_MAT_C
	right_circle.init_pos = {1, -0.75, 0} --{-500/tex_dim*scale, 600/tex_dim*scale, 0}
	right_circle.parent_element = grid_origin.name
	right_circle.controllers = {{"mdig_bright"}}
AddElement(right_circle)


-- SAM mask
sam_mask          = CreateElement "ceMeshPoly"
	sam_mask.name 	= create_guid_string() 
	sam_mask.material = HSD_BG_MAT
	sam_mask.primitivetype = "triangles"
	sam_mask.vertices	= {{-220/1024, 100/1024},
                                             { 220/1024, 100/1024},
                                             { 220/1024,-100/1024},
                                             {-220/1024,-100/1024}}
	sam_mask.indices		 = default_box_indices
	sam_mask.init_pos		 = element_init_pos_shift(-370, 265, 0, 2048)
	sam_mask.init_rot		 = {0, 0, 0}
    sam_mask.h_clip_relation	= h_clip_relations.REWRITE_LEVEL
    sam_mask.level				= HSD_DEFAULT_LEVEL+1
    sam_mask.collimated		= false
    sam_mask.isdraw		        = true
    sam_mask.isvisible			= true
    sam_mask.z_emable		= true
    sam_mask.use_mipfilter	= true
    sam_mask.additive_alpha	= false
	sam_mask.parent_element = grid_origin.name
	sam_mask.controllers = {{"mdig_bright"}}
AddMaskLevel(sam_mask, HSD_DEFAULT_LEVEL+1)

-- SAM frame
sam_frame          = my_create_textured_box_2k(1058,120,282,122)--my_create_textured_box_2k(186,206,846,846)
	sam_frame.name 	= create_guid_string() 
	sam_frame.material = MDIG_MAT_C
	sam_frame.init_pos = element_init_pos_shift(-370, 265, 0, 2048)
	sam_frame.parent_element = grid_origin.name
	sam_frame.controllers = {{"mdig_bright"}}
AddElementLevel(sam_frame, HSD_DEFAULT_LEVEL+1)

-- SAM symbol
sam_symbol          = my_create_textured_box_2k(1619,515,1665-1619,603-515)--my_create_textured_box_2k(186,206,846,846)
	sam_symbol.name 	= create_guid_string() 
	sam_symbol.material = MDIG_MAT_C
	sam_symbol.init_pos = element_init_pos_shift(-370, 265, 0, 2048)
	sam_symbol.parent_element = grid_origin.name
	sam_symbol.controllers = {{"mdig_bright"}}
AddElementLevel(sam_symbol, HSD_DEFAULT_LEVEL+1)


-- AAA mask
aaa_mask          = CreateElement "ceMeshPoly"
	aaa_mask.name 	= create_guid_string() 
	aaa_mask.material = HSD_BG_MAT -- HSD_BLACK or HSD_WHITE
	aaa_mask.primitivetype = "triangles"
	aaa_mask.vertices	= {{-220/1024, 100/1024},
                                             { 220/1024, 100/1024},
                                             { 220/1024,-100/1024},
                                             {-220/1024,-100/1024}}
	aaa_mask.indices		 = default_box_indices
	aaa_mask.init_pos		 = element_init_pos_shift(370, 265, 0, 2048)
	aaa_mask.init_rot		 = {0, 0, 0}
    aaa_mask.h_clip_relation	= h_clip_relations.REWRITE_LEVEL
    aaa_mask.level				= HSD_DEFAULT_LEVEL+1
    aaa_mask.collimated		= false
    aaa_mask.isdraw		        = true
    aaa_mask.isvisible			= true
    aaa_mask.z_emable		= true
    aaa_mask.use_mipfilter	= true
    aaa_mask.additive_alpha	= false
	aaa_mask.parent_element = grid_origin.name
	aaa_mask.controllers = {{"mdig_bright"}}
AddMaskLevel(aaa_mask, HSD_DEFAULT_LEVEL+1)

-- AAA frame
aaa_frame          = my_create_textured_box_2k(1058,120,282,122)--my_create_textured_box_2k(186,206,846,846)
	aaa_frame.name 	= create_guid_string() 
	aaa_frame.material = MDIG_MAT_C
	aaa_frame.init_pos = element_init_pos_shift(370, 265, 0, 2048)
	aaa_frame.parent_element = grid_origin.name
	aaa_frame.controllers = {{"mdig_bright"}}
AddElementLevel(aaa_frame, HSD_DEFAULT_LEVEL+1)

-- AAA symbol
aaa_symbol          = my_create_textured_box_2k(1619,421,1688-1619,490-421)--my_create_textured_box_2k(186,206,846,846)
	aaa_symbol.name 	= create_guid_string() 
	aaa_symbol.material = MDIG_MAT_C
	aaa_symbol.init_pos = element_init_pos_shift(370, 265, 0, 2048)
	aaa_symbol.parent_element = grid_origin.name
	aaa_symbol.controllers = {{"mdig_bright"}}
AddElementLevel(aaa_symbol, HSD_DEFAULT_LEVEL+1)



-- AIR mask
air_mask          = CreateElement "ceMeshPoly"
	air_mask.name 	= create_guid_string() 
	air_mask.material = HSD_BG_MAT
	air_mask.primitivetype = "triangles"
	air_mask.vertices	= {{-220/1024, 100/1024},
                                             { 220/1024, 100/1024},
                                             { 220/1024,-100/1024},
                                             {-220/1024,-100/1024}}
	air_mask.indices		 = default_box_indices
	air_mask.init_pos		 = element_init_pos_shift(-370, -550, 0, 2048)
	air_mask.init_rot		 = {0, 0, 0}
    air_mask.h_clip_relation	= h_clip_relations.REWRITE_LEVEL
    air_mask.level				= HSD_DEFAULT_LEVEL+1
    air_mask.collimated		= false
    air_mask.isdraw		        = true
    air_mask.isvisible			= true
    air_mask.z_emable		= true
    air_mask.use_mipfilter	= true
    air_mask.additive_alpha	= false
	air_mask.parent_element = grid_origin.name
	air_mask.controllers = {{"mdig_bright"}}
AddMaskLevel(air_mask, HSD_DEFAULT_LEVEL+1)

-- AIR frame
air_frame          = my_create_textured_box_2k(1058,120,282,122)--my_create_textured_box_2k(186,206,846,846)
	air_frame.name 	= create_guid_string() 
	air_frame.material = MDIG_MAT_C
	air_frame.init_pos = element_init_pos_shift(-370, -550, 0, 2048)
	air_frame.parent_element = grid_origin.name
	air_frame.controllers = {{"mdig_bright"}}
AddElementLevel(air_frame, HSD_DEFAULT_LEVEL+1)

-- AIR symbol
air_symbol          = my_create_textured_box_2k(1058,429,1139-1058,484-429)--my_create_textured_box_2k(186,206,846,846)
	air_symbol.name 	= create_guid_string() 
	air_symbol.material = MDIG_MAT_C
	air_symbol.init_pos = element_init_pos_shift(-370, -550, 0, 2048)
	air_symbol.parent_element = grid_origin.name
	air_symbol.controllers = {{"mdig_bright"}}
AddElementLevel(air_symbol, HSD_DEFAULT_LEVEL+1)





-- NAVY mask
navy_mask          = CreateElement "ceMeshPoly"
	navy_mask.name 	= create_guid_string() 
	navy_mask.material = HSD_BG_MAT
	navy_mask.primitivetype = "triangles"
	navy_mask.vertices	= {{-220/1024, 100/1024},
                                             { 220/1024, 100/1024},
                                             { 220/1024,-100/1024},
                                             {-220/1024,-100/1024}}
	navy_mask.indices		 = default_box_indices
	navy_mask.init_pos		 = element_init_pos_shift(370, -550, 0, 2048)
	navy_mask.init_rot		 = {0, 0, 0}
    navy_mask.h_clip_relation	= h_clip_relations.REWRITE_LEVEL
    navy_mask.level				= HSD_DEFAULT_LEVEL+1
    navy_mask.collimated		= false
    navy_mask.isdraw		        = true
    navy_mask.isvisible			= true
    navy_mask.z_emable		= true
    navy_mask.use_mipfilter	= true
    navy_mask.additive_alpha	= false
	navy_mask.parent_element = grid_origin.name
	navy_mask.controllers = {{"mdig_bright"}}
AddMaskLevel(navy_mask, HSD_DEFAULT_LEVEL+1)

-- NAVY frame
navy_frame          = my_create_textured_box_2k(1058,120,282,122)--my_create_textured_box_2k(186,206,846,846)
	navy_frame.name 	= create_guid_string() 
	navy_frame.material = MDIG_MAT_C
	navy_frame.init_pos = element_init_pos_shift(370, -550, 0, 2048)
	navy_frame.parent_element = grid_origin.name
	navy_frame.controllers = {{"mdig_bright"}}
AddElementLevel(navy_frame, HSD_DEFAULT_LEVEL+1)

-- NAVY symbol
navy_symbol          = my_create_textured_box_2k(1220,388,100, 81)--my_create_textured_box_2k(186,206,846,846)
	navy_symbol.name 	= create_guid_string() 
	navy_symbol.material = MDIG_MAT_C
	navy_symbol.init_pos = element_init_pos_shift(370, -550, 0, 2048)
	navy_symbol.parent_element = grid_origin.name
	navy_symbol.controllers = {{"mdig_bright"}}
AddElementLevel(navy_symbol, HSD_DEFAULT_LEVEL+1)




clip_box_out()

