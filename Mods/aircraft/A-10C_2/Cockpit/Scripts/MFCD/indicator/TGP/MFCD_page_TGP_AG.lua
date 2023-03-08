dofile(LockOn_Options.script_path.."MFCD/indicator/TGP/MFCD_TGP_tools.lua")

Label_OSB1   = add_OSB_label(1, "CNTL")

-- the branch symbol and the label itself were separated
-- intentionally to reflect the actual label alignment
Label_OSB1_symbol						= default_label_text(1,true)
Label_OSB1_symbol.value					= BRANCH_L
Label_OSB1_symbol.parent_element		= Label_OSB1.name
Label_OSB1_symbol.init_pos				= {-27, 0, 0}

addOSB_Box(1, {Label_OSB1, Label_OSB1_symbol})

--add_test_gray_scale_control()
add_B_S_control()

add_flir_gain_control()
add_current_laser_designator()
add_time()
add_lss_osb_block()
add_time_of_fall()

add_dummy_boxes({8, 9, 10})
add_dummy_boxes({16, 17})

function add_dbg_mask()
	dbg_los_pos				   = CreateElement "ceMeshPoly"
	dbg_los_pos.name           = "dbg_los_pos"
	dbg_los_pos.primitivetype  = "lines"
	dbg_los_pos.material	   = MFCD_SOLID_RED
	dbg_los_pos.indices        = {0,1,1,2,2,3,3,0}
	dbg_los_pos.vertices       = {{0,10},{10,0},{0,-10},{-10,0}}
	dbg_los_pos.controllers    = {{"tgp_dbg_elevation",GetScale() * (max_pixels_count/2)/math.rad(180)},
								  {"tgp_dbg_azimuth"  ,GetScale() * (max_pixels_count/2)/math.rad(180)}}
	dbg_los_pos.init_pos       = {max_pixels_count/2,max_pixels_count/2}
	SetLowerLeftCornerOrigin(dbg_los_pos) 
	Add(dbg_los_pos)

	dbg_mask				= CreateElement "ceMeshPoly"
	dbg_mask.name           = "dbg_mask"
	dbg_mask.primitivetype  = "lines"
	dbg_mask.material	    = MFCD_SOLID_GREEN
	dbg_mask.controllers    = {{"tgp_dbg_draw_mask",GetScale() * (max_pixels_count/2)/math.rad(180),GetScale() * (max_pixels_count/2)/math.rad(180)}}
	dbg_mask.init_pos       = {max_pixels_count/2,max_pixels_count/2}
	SetLowerLeftCornerOrigin(dbg_mask) 
	Add(dbg_mask)

	dbg_mask_outlined				 = CreateElement "ceMeshPoly"
	dbg_mask_outlined.name           = "dbg_mask_outlined"
	dbg_mask_outlined.primitivetype  = "lines"
	dbg_mask_outlined.material	     = MFCD_SOLID_RED
	dbg_mask_outlined.controllers    = {{"tgp_dbg_draw_mask",GetScale() * (max_pixels_count/2)/math.rad(180),GetScale() * (max_pixels_count/2)/math.rad(180),1.0}}
	dbg_mask_outlined.init_pos       = {max_pixels_count/2,max_pixels_count/2}
	SetLowerLeftCornerOrigin(dbg_mask_outlined) 
	Add(dbg_mask_outlined)
end

add_osb_static_hint(1,_("Go to A-G Control page"))
add_osb_static_hint(2,_("A-G Mode is Active"))
add_osb_static_hint(3,_("Go to Standby Mode page"))
add_osb_static_hint(4,_("Go to A-A Mode page"))

--uncomment next line to view mask zones
--add_dbg_mask()
