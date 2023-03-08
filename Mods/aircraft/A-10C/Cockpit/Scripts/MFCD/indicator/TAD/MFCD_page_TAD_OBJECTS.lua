
dofile(LockOn_Options.script_path.."MFCD/indicator/TAD/MFCD_TAD_tools.lua")

local  texture = 2.2 * texture_scale

--dbg_print(string.format("objects level  = %d,\n",DEFAULT_LEVEL))

function create_waypoint(class)
  local el = CreateElement(class)
		el.use_mipfilter 	= true
		el.controllers		= {{"tad_pos_symbology_available"}, {"tad_map_point", (max_pixels_count/2)*GetScale(), (max_pixels_count/2)*GetScale(), -1}}
		el.h_clip_relation  = h_clip_relations.COMPARE
		el.level 		    = DEFAULT_LEVEL							   
	return el
end

function create_waypoint_without_orientation(class)
  local el = CreateElement(class)
		el.use_mipfilter 	= true
		el.controllers		= {{"tad_pos_symbology_available"}, {"tad_map_point", (max_pixels_count/2) * GetScale(), (max_pixels_count/2) * GetScale(), -1}, {"remove_orientation"}}
		el.h_clip_relation  = h_clip_relations.COMPARE
		el.level 		    = DEFAULT_LEVEL							   
	return el
end


el_bullseye					= create_waypoint("ceTexPoly")
el_bullseye.name 			= "el_bullseye"
el_bullseye.material	    = MFCD_GREEN
el_bullseye.vertices        ={{ -17 ,-17},{ -17 , 17},{  17, 17},{  17 ,-17}}--{{ -16 ,-16},{ -16 , 16},{  16, 16},{  16 ,-16}}
el_bullseye.indices			= box_ind
el_bullseye.tex_params   	= {246/512,463/512, texture, texture}	
Add(el_bullseye)


el_ownship_fon					= create_waypoint("ceTexPoly")
el_ownship_fon.name 			= "el_ownship"
el_ownship_fon.material	   		= MFCD_BLACK
el_ownship_fon.vertices         ={{ -16.5 ,-16.5},{ -16.5 , 16.5},{  16.5 , 16.5},{  16.5 ,-16.5}}
el_ownship_fon.indices			= box_ind
el_ownship_fon.tex_params   	= {1 - 32/512, 32/512, 2 * (16 / 16.5)*texture_scale, 2 *(16 / 16.5)*texture_scale}		
--el_ownship_fon.controllers      = {{"tad_pos_symbology_available"}}
Add(el_ownship_fon)

el_ownship					= CreateElement "ceTexPoly"
el_ownship.primitivetype    = "triangles"
el_ownship.material	     	= MFCD_GREEN
el_ownship.vertices         ={{ -16 ,-16},
							  { -16 , 16},
							  {  16 , 16},
							  {  16 ,-16}}
el_ownship.indices			= box_ind
el_ownship.tex_params   	= {1 - 32/512,32/512,2*texture_scale,2*texture_scale}		
el_ownship.use_mipfilter 	= true
el_ownship.parent_element   = el_ownship_fon.name
el_ownship.h_clip_relation  = h_clip_relations.COMPARE
el_ownship.level 		    = DEFAULT_LEVEL
Add(el_ownship)


el_spi					= create_waypoint_without_orientation("ceTexPoly")
el_spi.name 			= "el_spi"
el_spi.material	    	= MFCD_WHITE
el_spi.vertices         = {{ -18 ,-18},{ -18 , 18},{  18, 18},{  18 ,-18}}
el_spi.indices			= box_ind
el_spi.tex_params   	= {315/512, 463/512, texture, texture}	
Add(el_spi)


el_tgp					= create_waypoint_without_orientation("ceTexPoly")
el_tgp.name 			= "el_tgp"
el_tgp.material	   		= MFCD_GREEN
el_tgp.vertices         = {{ -4*1.6 ,-16},
						   { -4*1.6 , 16},
						   {  4*1.6 , 16},
						   {  4*1.6 ,-16}}
el_tgp.indices			= box_ind
el_tgp.tex_params   	= {368/512, 463/512, 1.1 * 4 * texture_scale / 1.6, 1.1 * 2 * 1.6* texture_scale / 1.6}		
Add(el_tgp)


el_steerpoint					=  create_waypoint_without_orientation("ceTexPoly")
el_steerpoint.name 				= "el_steerpoint"
el_steerpoint.material	     	= MFCD_GREEN
el_steerpoint.vertices          ={{-17.5, -17.5},
							      {-17.5,  17.5},
								  { 17.5,  17.5},
								  { 17.5, -17.5}}
el_steerpoint.indices			= box_ind
el_steerpoint.tex_params   		= {421/512, 463/512, texture, texture}
el_steerpoint.controllers		= {{"tad_pos_symbology_available"}, {"tad_ownship_waypoints_enable"},
                                   {"tad_map_point", (max_pixels_count/2)*GetScale(), (max_pixels_count/2)*GetScale(), -1},
								   {"remove_orientation"},
								   {"tad_current_waypoint_color", 1, 1, 0}}
Add(el_steerpoint)


el_steerpoint_name				   = default_label_text(20, true)
el_steerpoint_name.parent_element  = el_steerpoint.name
el_steerpoint_name.init_pos		   = {16.5,0,0}
el_steerpoint_name.stringdefs	   = txt_smallest_font
el_steerpoint_name.formats         = {"%s","%d"}
el_steerpoint_name.controllers 	   = {{"tad_ownship_waypoints_enable"}, {"tad_waypoint_labels_enable"},
                                      {"tad_map_point_number", 1}, --{"tad_map_point_name",0},
									 {"tad_current_waypoint_color", 1, 1, 0}}
el_steerpoint_name.h_clip_relation = h_clip_relations.COMPARE
el_steerpoint_name.level 		   = DEFAULT_LEVEL							   

-- Selected course steering
el_scs					 =  create_waypoint_without_orientation("ceTexPoly")
el_scs.name 			 = "el_scs"
el_scs.material	     	 = MFCD_YELLOW
el_scs.vertices          ={{-17.5, -17.5},
						   {-17.5,  17.5},
						   { 17.5,  17.5},
						   { 17.5, -17.5}}
el_scs.indices			 = box_ind
el_scs.tex_params   	 = {421/512, 463/512, texture, texture}
el_scs.controllers		 = {{"tad_scs_available", 1},
							{"tad_map_point", (max_pixels_count/2)*GetScale(), (max_pixels_count/2)*GetScale(), -1},
							{"remove_orientation"}}
Add(el_scs)

								   
el_scs_name				     = default_label_text(20,true)
el_scs_name.material	     = font_MFCD_YELLOW
el_scs_name.parent_element   = el_scs.name
el_scs_name.init_pos		 = {16.5,0,0}
el_scs_name.stringdefs	     = txt_smallest_font
el_scs_name.value            = "SCS"
el_scs_name.h_clip_relation  = h_clip_relations.COMPARE
el_scs_name.level 		     = DEFAULT_LEVEL


el_mark_z					= create_waypoint_without_orientation("ceTexPoly")
el_mark_z.name 				= "el_mark_z"
el_mark_z.material	     	= MFCD_WHITE
el_mark_z.vertices          = bx(8, -7.5, 7.5)
el_mark_z.indices			= box_ind
el_mark_z.tex_params   		= {32/512, 203.5/512, texture, texture}
el_mark_z.controllers		= {{"tad_ownship_waypoints_enable"},
							      {"tad_map_point", (max_pixels_count/2)*GetScale(), (max_pixels_count/2)*GetScale(), -1},
							      {"remove_orientation"}}
Add(el_mark_z)

el_mark_z_name                 = Copy(el_steerpoint_name)
el_mark_z_name.name 		   = "el_mark_z_name"
el_mark_z_name.parent_element  = el_mark_z.name
Add(el_mark_z_name)	

----------------------------------------------------------------------------
local vv_length_max = 14 --16


function add_SADL_EntityAir(name, verts, tex_start, dy_line, material)

local el_air_base             = create_waypoint("ceSimple")
      el_air_base.name        = name
  Add(el_air_base)

local  line_width_K = 1.2

local  vv_background			        = CreateElement("ceHWLine")
       vv_background.name		        = name .. "_vv_background"
       vv_background.vertices	        = {{-1, -1.8 * line_width_K}, {vv_length_max, -1.8 * line_width_K}, {vv_length_max, 1.8 * line_width_K}, {-1, 1.8 * line_width_K}}
       vv_background.maskvertices	    = {{ 0, -1.8 * line_width_K}, {vv_length_max, -1.8 * line_width_K}, {vv_length_max, 1.8 * line_width_K}, { 0, 1.8 * line_width_K}}
       vv_background.indices		    = box_ind
       vv_background.maxlength	        = vv_length_max
       vv_background.length		        = 0
       vv_background.material		    = MFCD_BLACK
       vv_background.tex_params         = {0.1, 350.5/512, texture, 0.9 * texture}
       vv_background.parent_element	    = el_air_base.name
       vv_background.h_clip_relation	= h_clip_relations.COMPARE
       vv_background.level			    = DEFAULT_LEVEL
       vv_background.controllers        = {{"tad_SADL_EntityAirVelVector", vv_length_max}}
       vv_background.use_mipfilter	    = true
       vv_background.init_pos           = {0, dy_line + 0.3, 0}
       vv_background.init_rot           = {90, 0, 0}
       Add(vv_background)

local  body                   = CreateElement "ceTexPoly"
       body.name              = name .. "_Body"
       body.material          = material or MFCD_GREEN
       body.vertices          = verts
       body.indices           = box_ind
       body.tex_params        = {tex_start[1], tex_start[2], texture, texture}
       body.parent_element    = el_air_base.name
       body.h_clip_relation   = h_clip_relations.COMPARE
       body.level             = DEFAULT_LEVEL
       body.use_mipfilter	  = true       
       Add(body)

local  vv_colored			        = Copy(vv_background)
       vv_colored.name		        = name .. "_vv_colored"
       vv_colored.vertices	        = {{-1, -0.9 * line_width_K}, {vv_length_max, -0.9 * line_width_K}, {vv_length_max, 0.9 * line_width_K}, {-1, 0.9 * line_width_K}}
       vv_colored.maskvertices	    = {{ 0, -0.9 * line_width_K}, {vv_length_max, -0.9 * line_width_K}, {vv_length_max, 0.9 * line_width_K}, { 0, 0.9 * line_width_K}}
       vv_colored.material		    = material or MFCD_GREEN
       vv_colored.tex_params        = {0.1, 350.5/512, texture, 0.8 * texture}
       vv_colored.init_pos          = {0, dy_line, 0}
       Add(vv_colored)
 
	return el_air_base, vv_background, body, vv_colored
end

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
function bx(xsz, ymin, ymax)
	local ymin = ymin or -xsz
	local ymax = ymax or  xsz
	return {{-xsz, ymin}, {-xsz, ymax},
			{ xsz, ymax}, { xsz, ymin}}
end

function tx(x, y)
	return {x/512, y/512}
end

function add_SADL_EntityAirAltitude(parent, dy, material)
local   alt                    = CreateElement "ceStringPoly"
        alt.UseBackground      = true
        alt.parent_element     = parent.name
        alt.alignment		   = "CenterCenter" 
        alt.material		   = material or font_MFCD
        alt.BackgroundMaterial = MFCD_SOLID_BLACK	  
        alt.stringdefs	       = txt_smallest_font
        alt.formats            = {"%d"}
        alt.controllers        = {{"tad_pos_symbology_available"}, {"remove_orientation"},
                                  {"tad_SADL_EntityAirAltitude", 0, math.rad(30), 20 * GetScale()},
                                  {"move", 0, dy * GetScale(), 0}}
        alt.h_clip_relation    = h_clip_relations.COMPARE
        alt.level 		       = DEFAULT_LEVEL	
        use_mipfilter(alt)
        Add(alt)
        
        return alt
end

function add_SADL_EntityEmergencyIndicator(parent)
	E_Indicator                    = CreateElement "ceStringPoly"
	E_Indicator.UseBackground      = false
	E_Indicator.parent_element     = parent.name
	E_Indicator.alignment		   = "CenterCenter" 
	E_Indicator.material		   = font_MFCD_RED
	E_Indicator.BackgroundMaterial = MFCD_SOLID_BLACK	  
	E_Indicator.stringdefs	       = txt_smallest_font
	E_Indicator.value              = "E"
	E_Indicator.controllers        = {{"tad_pos_symbology_available"}, {"remove_orientation"},
								  	  {"tad_SADL_EmergencyIndicator"}}
	E_Indicator.h_clip_relation    = h_clip_relations.COMPARE
	E_Indicator.level 		       = DEFAULT_LEVEL	
	use_mipfilter(E_Indicator)
	Add(E_Indicator)
end

function add_SADL_EntityGroundType(parent, color)
local   gtype                    = CreateElement "ceStringPoly"
        gtype.UseBackground      = false
        gtype.parent_element     = parent.name
        gtype.alignment		     = "CenterCenter" 
        gtype.material		     = color
        gtype.stringdefs	     = txt_smallest_font
        gtype.formats            = {"%s"}
        gtype.controllers        = {{"tad_pos_symbology_available"}, {"tad_SADL_ground_track_type", 0}}
        gtype.h_clip_relation    = h_clip_relations.COMPARE
        gtype.level 		     = DEFAULT_LEVEL	
        use_mipfilter(gtype)
        Add(gtype)
        return gtype
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
el_dl_PPLI_air_base, el_dl_PPLI_air_vv_back, el_dl_PPLI_air_body,
	el_dl_PPLI_air_vv = add_SADL_EntityAir("el_dl_PPLI_air", bx(17.5), tx(99, 292), 16)

el_dl_PPLI_air_body.controllers = {{"tad_pos_symbology_available"}, {"tad_SADL_air_PPLI_color"}}
el_dl_PPLI_air_vv.controllers = {{"tad_pos_symbology_available"}, {"tad_SADL_EntityAirVelVector", vv_length_max}, {"tad_SADL_air_PPLI_color"}}

el_dl_PPLI_air_flmem_num                    = CreateElement "ceStringPoly"
el_dl_PPLI_air_flmem_num.UseBackground      = true
el_dl_PPLI_air_flmem_num.parent_element     = el_dl_PPLI_air_base.name
el_dl_PPLI_air_flmem_num.alignment		    = "CenterCenter" 
el_dl_PPLI_air_flmem_num.material			= font_MFCD
el_dl_PPLI_air_flmem_num.BackgroundMaterial	= MFCD_SOLID_BLACK	  
el_dl_PPLI_air_flmem_num.stringdefs	        = txt_smallest_font
el_dl_PPLI_air_flmem_num.formats            = {"%d"}
el_dl_PPLI_air_flmem_num.controllers        = {{"tad_pos_symbology_available"}, {"remove_orientation"},
                                               {"tad_SADL_flight_member_index", 1, 99},
                                               {"tad_SADL_flight_member_index_txt", 0}}
el_dl_PPLI_air_flmem_num.h_clip_relation    = h_clip_relations.COMPARE
el_dl_PPLI_air_flmem_num.level 		        = DEFAULT_LEVEL	
use_mipfilter(el_dl_PPLI_air_flmem_num)
Add(el_dl_PPLI_air_flmem_num)
    

el_dl_PPLI_air_flmem_is_donor                   = CreateElement "ceTexPoly"
el_dl_PPLI_air_flmem_is_donor.material          = MFCD_GREEN
el_dl_PPLI_air_flmem_is_donor.vertices          = bx(5)
el_dl_PPLI_air_flmem_is_donor.indices           = box_ind
el_dl_PPLI_air_flmem_is_donor.tex_params        = {32.5 / 512, 266.5 / 512, texture, texture}
el_dl_PPLI_air_flmem_is_donor.parent_element    = el_dl_PPLI_air_base.name
el_dl_PPLI_air_flmem_is_donor.h_clip_relation   = h_clip_relations.COMPARE
el_dl_PPLI_air_flmem_is_donor.level             = DEFAULT_LEVEL
el_dl_PPLI_air_flmem_is_donor.controllers       = {{"tad_SADL_flight_member_index", 100, 100}}
el_dl_PPLI_air_flmem_is_donor.use_mipfilter	    = true       
Add(el_dl_PPLI_air_flmem_is_donor)	

add_SADL_EntityAirAltitude(el_dl_PPLI_air_base, -28)
add_SADL_EntityEmergencyIndicator(el_dl_PPLI_air_base)

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
el_dl_track_air_friendly    = add_SADL_EntityAir("el_dl_track_air_friendly", bx(17.5, -1 ,17.5), tx(171, 292), 16)
add_SADL_EntityAirAltitude(el_dl_track_air_friendly, -28)
add_SADL_EntityEmergencyIndicator(el_dl_track_air_friendly)

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
el_dl_track_air_neutral_unk, el_dl_track_air_neutral_unk_vv_back,
	el_dl_track_air_neutral_unk_body, el_dl_track_air_neutral_unk_vv_colored =
		add_SADL_EntityAir("el_dl_track_air_neutral_unk", bx(13, -13, 13), tx(241, 292), 12, MFCD_BLUE)

el_dl_track_air_neutral_unk_body.controllers = {{"tad_SADL_track_color"}}

el_dl_track_air_neutral_unk_vv_colored.controllers	= {{"tad_SADL_EntityAirVelVector", vv_length_max},
													   {"tad_SADL_track_color"}}

local el_dy = -28
el_dl_track_air_neutral_unk_alt = add_SADL_EntityAirAltitude(el_dl_track_air_neutral_unk, el_dy, font_MFCD_BLUE)
el_dl_track_air_neutral_unk_alt.controllers = {{"tad_pos_symbology_available"}, {"remove_orientation"},
											   {"tad_SADL_EntityAirAltitude", 0, math.rad(30), 20 * GetScale()},
											   {"move", 0, el_dy * GetScale(), 0},
											   {"tad_SADL_track_color"}}
                                  
add_SADL_EntityEmergencyIndicator(el_dl_track_air_neutral_unk)

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
el_dl_track_air_hostile = add_SADL_EntityAir("el_dl_track_air_hostile", bx(13, -13, 15), tx(310, 292), 11, MFCD_RED)
add_SADL_EntityAirAltitude(el_dl_track_air_hostile, -28, font_MFCD_RED)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
el_dl_track_ground_neutral_unk                      = create_waypoint_without_orientation("ceTexPoly")
el_dl_track_ground_neutral_unk.name                 = "el_dl_track_ground_neutral_unk"
el_dl_track_ground_neutral_unk.material             = MFCD_BLUE
el_dl_track_ground_neutral_unk.vertices             = bx(13)
el_dl_track_ground_neutral_unk.indices              = box_ind
el_dl_track_ground_neutral_unk.tex_params           = {379 / 512, 292 / 512, texture, texture}
el_dl_track_ground_neutral_unk.controllers			= {{"tad_pos_symbology_available"}, {"tad_map_point", (max_pixels_count/2) * GetScale(), (max_pixels_count/2) * GetScale(), -1},
													   {"remove_orientation"},
													   {"tad_SADL_track_color"}}
Add(el_dl_track_ground_neutral_unk)

add_SADL_EntityGroundType(el_dl_track_ground_neutral_unk, font_MFCD_BLACK)
add_SADL_EntityEmergencyIndicator(el_dl_track_ground_neutral_unk)

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
el_dl_track_ground_neutral_unk_notfilled            = create_waypoint_without_orientation("ceTexPoly")
el_dl_track_ground_neutral_unk_notfilled.name       = "el_dl_track_ground_neutral_unk_notfilled"
el_dl_track_ground_neutral_unk_notfilled.material   = MFCD_BLUE
el_dl_track_ground_neutral_unk_notfilled.vertices   = bx(13)
el_dl_track_ground_neutral_unk_notfilled.indices    = box_ind
el_dl_track_ground_neutral_unk_notfilled.tex_params = {241 / 512, 292 / 512, texture, texture}
Add(el_dl_track_ground_neutral_unk_notfilled)

add_SADL_EntityGroundType(el_dl_track_ground_neutral_unk_notfilled, font_MFCD_BLUE)
add_SADL_EntityEmergencyIndicator(el_dl_track_ground_neutral_unk_notfilled)

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
el_dl_track_ground_hostile                      = create_waypoint_without_orientation("ceTexPoly")
el_dl_track_ground_hostile.name                 = "el_dl_track_ground_hostile"
el_dl_track_ground_hostile.material             = MFCD_RED
el_dl_track_ground_hostile.vertices             = bx(18)
el_dl_track_ground_hostile.indices              = box_ind
el_dl_track_ground_hostile.tex_params           = {392 / 512, 208 / 512, texture, texture}
Add(el_dl_track_ground_hostile)

add_SADL_EntityGroundType(el_dl_track_ground_hostile, font_MFCD_BLACK)
add_SADL_EntityEmergencyIndicator(el_dl_track_ground_hostile)

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
el_dl_track_ground_hostile_notfilled            = create_waypoint_without_orientation("ceTexPoly")
el_dl_track_ground_hostile_notfilled.name       = "el_dl_track_ground_hostile_notfilled"
el_dl_track_ground_hostile_notfilled.material   = MFCD_RED
el_dl_track_ground_hostile_notfilled.vertices   = bx(18)
el_dl_track_ground_hostile_notfilled.indices    = box_ind
el_dl_track_ground_hostile_notfilled.tex_params = {310 / 512, 208 / 512, texture, texture}
Add(el_dl_track_ground_hostile_notfilled)
add_SADL_EntityGroundType(el_dl_track_ground_hostile_notfilled, font_MFCD_RED)
add_SADL_EntityEmergencyIndicator(el_dl_track_ground_hostile_notfilled)

el_dl_PPLI_ground            = create_waypoint_without_orientation("ceTexPoly")
el_dl_PPLI_ground.name       = "el_dl_PPLI_ground"
el_dl_PPLI_ground.material   = MFCD_GREEN
el_dl_PPLI_ground.vertices   = bx(12)
el_dl_PPLI_ground.indices    = box_ind
el_dl_PPLI_ground.tex_params = {171 / 512, 208 / 512, texture, texture}
Add(el_dl_PPLI_ground)

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
el_dl_minispi                   = create_waypoint_without_orientation("ceTexPoly")
el_dl_minispi.name              = "el_dl_minispi"
el_dl_minispi.material          = "INDICATION_MFCD_WHITE"
el_dl_minispi.vertices          = bx(15)
el_dl_minispi.indices           = box_ind
el_dl_minispi.tex_params        = {449 / 512, 295 / 512, texture, texture}	
el_dl_minispi.controllers		= {{"tad_pos_symbology_available"},
                                   {"tad_map_point", (max_pixels_count/2) * GetScale(), (max_pixels_count/2) * GetScale(), -1},
								   {"remove_orientation"},
								   {"tad_SADL_local_tgt_color"}}
Add(el_dl_minispi)


el_dl_target_line                  = CreateElement("ceHWLine")
el_dl_target_line.name             = "el_dl_target_line"
el_dl_target_line.vertices		   = {{0, -2}, {8 * max_pixels_count, -2}, {8 * max_pixels_count, 2}, {0, 2}}
el_dl_target_line.maskvertices	   = {{0, -2}, {8 * max_pixels_count, -2}, {8 * max_pixels_count, 2}, {0, 2}}
el_dl_target_line.indices		   = box_ind
el_dl_target_line.maxlength	       = 8 * max_pixels_count / GetScale()
el_dl_target_line.material		   = MFCD_BLUE
el_dl_target_line.tex_params       = {0, 350.5 / 512, 2 * texture_scale, 2 * texture_scale}
el_dl_target_line.h_clip_relation  = h_clip_relations.COMPARE
el_dl_target_line.level		       = DEFAULT_LEVEL
el_dl_target_line.use_sigle_line   = true
el_dl_target_line.controllers	   = {{"tad_pos_symbology_available"},
                                       {"tad_spi_display_enable", 1},                                     
									   {"tad_donor_SPI_line", (max_pixels_count/2) * GetScale(), (max_pixels_count/2) * GetScale(), 1/GetScale()},
									   {"rotate", math.rad(90.0)}
									  }
use_mipfilter(el_dl_target_line)
Add(el_dl_target_line)

el_dl_track_ground_friendly            = create_waypoint_without_orientation("ceTexPoly")
el_dl_track_ground_friendly.name       = "el_dl_track_ground_friendly"
el_dl_track_ground_friendly.material   = MFCD_GREEN
el_dl_track_ground_friendly.vertices   = bx(12)
el_dl_track_ground_friendly.indices    = box_ind
el_dl_track_ground_friendly.tex_params = {241 / 512, 208 / 512, texture, texture}
Add(el_dl_track_ground_friendly)

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
el_dl_emergency_point               = create_waypoint_without_orientation("ceTexPoly")    
el_dl_emergency_point.name          = "el_dl_emergency_point"               
el_dl_emergency_point.material      = MFCD_GREEN
el_dl_emergency_point.vertices      = bx(13)
el_dl_emergency_point.indices       = box_ind
el_dl_emergency_point.tex_params    = {241 / 512, 292 / 512, texture, texture}
Add(el_dl_emergency_point)

el_dl_emergency_point_E                    = CreateElement "ceStringPoly"
el_dl_emergency_point_E.parent_element     = el_dl_emergency_point.name
el_dl_emergency_point_E.alignment		   = "CenterCenter" 
el_dl_emergency_point_E.material		   = font_MFCD
el_dl_emergency_point_E.UseBackground      = false
el_dl_emergency_point_E.BackgroundMaterial = MFCD_SOLID_BLACK
el_dl_emergency_point_E.stringdefs	       = predefined_fonts[1]
el_dl_emergency_point_E.value              = "E"
el_dl_emergency_point_E.h_clip_relation    = h_clip_relations.COMPARE
el_dl_emergency_point_E.level 		       = DEFAULT_LEVEL	
use_mipfilter(el_dl_emergency_point_E)
Add(el_dl_emergency_point_E)

el_dl_MA_objective_attack                   = create_waypoint("ceTexPoly")
el_dl_MA_objective_attack.name              = "el_dl_MA_objective_attack"
el_dl_MA_objective_attack.material          = MFCD_RED
el_dl_MA_objective_attack.vertices          = bx(9.5, -8.5, 9.5) 
el_dl_MA_objective_attack.indices           = box_ind
el_dl_MA_objective_attack.controllers       = {{"tad_pos_symbology_available"}, {"tad_map_point", (max_pixels_count/2) * GetScale(), (max_pixels_count/2) * GetScale(), -1},
								              {"remove_orientation"}, {"blinkingMA"}}
el_dl_MA_objective_attack.tex_params        = {32.5 / 512, 208 / 512, texture, texture}
Add(el_dl_MA_objective_attack)

--[[
el_dl_dog_balls			        = CreateElement "ceTexPoly"
el_dl_dog_balls.name		    = "el_dl_dog_balls"
el_dl_dog_balls.material		= MFCD_WHITE
el_dl_dog_balls.vertices        = bx(10, -5, 6)
el_dl_dog_balls.indices         = box_ind
el_dl_dog_balls.tex_params      = {468.5 / 512, 208 / 512, texture, texture}
el_dl_dog_balls.parent_element	= el_dl_MA_objective_attack.name
el_dl_dog_balls.init_pos        = {0, 2}
el_dl_dog_balls.h_clip_relation = h_clip_relations.COMPARE
el_dl_dog_balls.level 		    = DEFAULT_LEVEL							   
use_mipfilter(el_dl_dog_balls)
Add(el_dl_dog_balls)
--]]

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
el_dl_MA_objective_other                   = create_waypoint_without_orientation("ceTexPoly")
el_dl_MA_objective_other.name              = "el_dl_MA_objective_other"
el_dl_MA_objective_other.material          = MFCD_GREEN
el_dl_MA_objective_other.vertices          = bx(9)
el_dl_MA_objective_other.indices           = box_ind
el_dl_MA_objective_other.tex_params        = {99 / 512, 208 / 512, texture, texture} 
Add(el_dl_MA_objective_other)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
el_dl_MA_initial_point                   = create_waypoint_without_orientation("ceTexPoly")
el_dl_MA_initial_point.name              = "el_dl_MA_initial_point"
el_dl_MA_initial_point.material          = MFCD_GREEN
el_dl_MA_initial_point.vertices          = bx(11)
el_dl_MA_initial_point.indices           = box_ind
el_dl_MA_initial_point.tex_params        = {32.5 / 512, 117 / 512, texture, texture}
Add(el_dl_MA_initial_point)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
el_dl_local_target_report                     = create_waypoint_without_orientation("ceTexPoly")
el_dl_local_target_report.name                = "el_dl_local_target_report"
el_dl_local_target_report.material            = MFCD_WHITE
el_dl_local_target_report.vertices            = bx(18)
el_dl_local_target_report.indices             = box_ind
el_dl_local_target_report.tex_params          = {310/512, 208/512, texture, texture}
Add(el_dl_local_target_report)
