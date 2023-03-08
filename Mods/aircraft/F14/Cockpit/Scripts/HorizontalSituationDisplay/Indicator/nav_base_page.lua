dofile(LockOn_Options.script_path.."Scripts/HorizontalSituationDisplay/Indicator/hsd_tools.lua")

dofile(general_page_path.."nav_base_page.lua")

local dest_src_origin = create_origin()

local DEST_SOURCE_Y = -1295

-- 1
local dest_wp1     = my_create_textured_box_2k(1553,230,8,36)
	dest_wp1.name 	= create_guid_string() 
	dest_wp1.material = MDIG_MAT_A
	dest_wp1.init_pos = element_init_pos_shift( 0, DEST_SOURCE_Y, 0, 2048)
	dest_wp1.init_rot = {0, 0, 0}
	dest_wp1.parent_element = dest_src_origin.name
    dest_wp1.h_clip_relation = h_clip_relations.COMPARE
	dest_wp1.level			= HSD_DEFAULT_LEVEL
	dest_wp1.controllers = {{"mdig_bright"},{"mdig_dest",1}}
AddElement(dest_wp1)

-- 2
local dest_wp2     = my_create_textured_box_2k(1595,230,21,36)
	dest_wp2.name 	= create_guid_string() 
	dest_wp2.material = MDIG_MAT_A
	dest_wp2.init_pos = element_init_pos_shift( 0, DEST_SOURCE_Y, 0, 2048)
	dest_wp2.init_rot = {0, 0, 0}
	dest_wp2.parent_element = dest_src_origin.name
    dest_wp2.h_clip_relation = h_clip_relations.COMPARE
	dest_wp2.level			= HSD_DEFAULT_LEVEL
	dest_wp2.controllers = {{"mdig_bright"},{"mdig_dest",2}}
AddElement(dest_wp2)

-- 3
local dest_wp3     = my_create_textured_box_2k(1642,230,24,36)
	dest_wp3.name 	= create_guid_string() 
	dest_wp3.material = MDIG_MAT_A
	dest_wp3.init_pos = element_init_pos_shift( 0, DEST_SOURCE_Y, 0, 2048)
	dest_wp3.init_rot = {0, 0, 0}
	dest_wp3.parent_element = dest_src_origin.name
    dest_wp3.h_clip_relation = h_clip_relations.COMPARE
	dest_wp3.level			= HSD_DEFAULT_LEVEL
	dest_wp3.controllers = {{"mdig_bright"},{"mdig_dest",3}}
AddElement(dest_wp3)

-- FP
local dest_fp     = my_create_textured_box_2k(1400,322,53,36)
	dest_fp.name 	= create_guid_string() 
	dest_fp.material = MDIG_MAT_A
	dest_fp.init_pos = element_init_pos_shift( 0, DEST_SOURCE_Y, 0, 2048)
	dest_fp.init_rot = {0, 0, 0}
	dest_fp.parent_element = dest_src_origin.name
    dest_fp.h_clip_relation = h_clip_relations.COMPARE
	dest_fp.level			= HSD_DEFAULT_LEVEL
	dest_fp.controllers = {{"mdig_bright"},{"mdig_dest",4}}
AddElement(dest_fp)

-- IP
local dest_ip     = my_create_textured_box_2k(1500,322,36,36)
	dest_ip.name 	= create_guid_string() 
	dest_ip.material = MDIG_MAT_A
	dest_ip.init_pos = element_init_pos_shift( 0, DEST_SOURCE_Y, 0, 2048)
	dest_ip.init_rot = {0, 0, 0}
	dest_ip.parent_element = dest_src_origin.name
    dest_ip.h_clip_relation = h_clip_relations.COMPARE
	dest_ip.level			= HSD_DEFAULT_LEVEL
	dest_ip.controllers = {{"mdig_bright"},{"mdig_dest",5}}
AddElement(dest_ip)

-- ST
local dest_st     = my_create_textured_box_2k(1599,322,52,36)
	dest_st.name 	= create_guid_string() 
	dest_st.material = MDIG_MAT_A
	dest_st.init_pos = element_init_pos_shift( 0, DEST_SOURCE_Y, 0, 2048)
	dest_st.init_rot = {0, 0, 0}
	dest_st.parent_element = dest_src_origin.name
    dest_st.h_clip_relation = h_clip_relations.COMPARE
	dest_st.level			= HSD_DEFAULT_LEVEL
	dest_st.controllers = {{"mdig_bright"},{"mdig_dest",6}}
AddElement(dest_st)

-- HB
local dest_hb     = my_create_textured_box_2k(1192,55,54,36)
	dest_hb.name 	= create_guid_string() 
	dest_hb.material = MDIG_MAT_A
	dest_hb.init_pos = element_init_pos_shift( 0, DEST_SOURCE_Y, 0, 2048)
	dest_hb.init_rot = {0, 0, 0}
	dest_hb.parent_element = dest_src_origin.name
    dest_hb.h_clip_relation = h_clip_relations.COMPARE
	dest_hb.level			= HSD_DEFAULT_LEVEL
	dest_hb.controllers = {{"mdig_bright"},{"mdig_dest",7}}
AddElement(dest_hb)

-- MAN
local dest_man     = my_create_textured_box_2k(1670,140,87,36)
	dest_man.name 	= create_guid_string() 
	dest_man.material = MDIG_MAT_A
	dest_man.init_pos = element_init_pos_shift( 0, DEST_SOURCE_Y, 0, 2048)
	dest_man.init_rot = {0, 0, 0}
	dest_man.parent_element = dest_src_origin.name
    dest_man.h_clip_relation = h_clip_relations.COMPARE
	dest_man.level			= HSD_DEFAULT_LEVEL
	dest_man.controllers = {{"mdig_bright"},{"mdig_dest",8}}
AddElement(dest_man)

-- INS
local nav_src_ins     = my_create_textured_box_2k(1677,53,61,38)
	nav_src_ins.name 	= create_guid_string()
    nav_src_ins.state_tex_coords = {
        --get_tex_coord(1677,53,61,38), -- 0
        get_tex_coord(1697,320,61,38,2048,2048), -- 1
    }
	nav_src_ins.material = MDIG_MAT_A
	nav_src_ins.init_pos = element_init_pos_shift( 0, DEST_SOURCE_Y, 0, 2048)
	nav_src_ins.init_rot = {0, 0, 0}
	nav_src_ins.parent_element = dest_src_origin.name
    nav_src_ins.h_clip_relation = h_clip_relations.COMPARE
	nav_src_ins.level			= HSD_DEFAULT_LEVEL
	nav_src_ins.controllers = {{"mdig_bright"},{"mdig_nav_src",1}}
AddElement(nav_src_ins)

-- IMU/AM
local nav_src_imu     = my_create_textured_box_2k(1388,138,61,38)
	nav_src_imu.name 	= create_guid_string() 
    nav_src_imu.state_tex_coords = {
        --get_tex_coord(1388,138,61,38), -- 0
        get_tex_coord(1697,320,61,38,2048,2048), -- 1
    }
	nav_src_imu.material = MDIG_MAT_A
	nav_src_imu.init_pos = element_init_pos_shift( 0, DEST_SOURCE_Y, 0, 2048)
	nav_src_imu.init_rot = {0, 0, 0}
	nav_src_imu.parent_element = dest_src_origin.name
    nav_src_imu.h_clip_relation = h_clip_relations.COMPARE
	nav_src_imu.level			= HSD_DEFAULT_LEVEL
	nav_src_imu.controllers = {{"mdig_bright"},{"mdig_nav_src",3}}
AddElement(nav_src_imu)

-- AHRS/AM
local nav_src_ahrs     = my_create_textured_box_2k(1800,140,56,36)
	nav_src_ahrs.name 	= create_guid_string() 
	nav_src_ahrs.material = MDIG_MAT_A
	nav_src_ahrs.init_pos = element_init_pos_shift( 0, DEST_SOURCE_Y, 0, 2048)
	nav_src_ahrs.init_rot = {0, 0, 0}
	nav_src_ahrs.parent_element = dest_src_origin.name
    nav_src_ahrs.h_clip_relation = h_clip_relations.COMPARE
	nav_src_ahrs.level			= HSD_DEFAULT_LEVEL
	nav_src_ahrs.controllers = {{"mdig_bright"},{"mdig_nav_src",2}}
AddElement(nav_src_ahrs)
