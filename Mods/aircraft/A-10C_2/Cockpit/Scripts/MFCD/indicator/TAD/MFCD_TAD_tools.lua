dofile(LockOn_Options.script_path.."MFCD/indicator/MFCD_useful_definitions.lua")


-- Is done in a separate function due to TAD symbology display priority
function Add_NOT_SOI_display_TAD()
	local NOT_SOI					= Add_NOT_SOI_display_helper()
	NOT_SOI.init_pos				= {0, NOT_SOI_coord_y - max_pixels_count/2, 0}
	Add(NOT_SOI)

	return NOT_SOI
end


function add_tad_cursor()
	local  cursor_base			= CreateElement "ceSimple"
	Add(cursor_base)

	local border_background   = {}
	local border			  = {}

	local border_background_vertices = {
							  {{-10.5,0},{10.5,0}},
							  {{0,-10.5},{0,10.5}},
							  }
	local border_vertices 		   =  {
							  {{-10,0},{10,0}},
							  {{0,-10},{0,10}},
							  }
	local size  = 2
	local tex_param_default = 2*texture_scale

	for	  i = 1,2 do
		border_background[i] 		       = CreateElement "ceSimpleLineObject"
		border_background[i].material	   = MFCD_BLACK
		border_background[i].width       = 2*size
		border_background[i].tex_params  = {{0.5,503/512},{0.9,503/512},{texture_scale,0.5*tex_param_default}}	
		border_background[i].vertices    = border_background_vertices[i]
		use_mipfilter(border_background[i])
		border_background[i].h_clip_relation = h_clip_relations.COMPARE
		border_background[i].level 		    = DEFAULT_LEVEL
		border_background[i].parent_element = cursor_base.name 

		border[i]			       = CreateElement "ceSimpleLineObject"
		border[i].material	   = MFCD_GREEN
		border[i].width          = size
		border[i].tex_params     = {{0.5,503/512},{0.9,503/512},{texture_scale,tex_param_default}}	
		border[i].vertices       = border_vertices[i]
		use_mipfilter(border[i])
		border[i].h_clip_relation  = h_clip_relations.COMPARE
		border[i].level 		     = DEFAULT_LEVEL
		border[i].parent_element   = cursor_base.name 
	end

    Add(border_background[1])
	Add(border_background[2])
	Add(border[1])
	Add(border[2])

	return cursor_base
end


function add_tad_coordinates_display_mode_selection()
	local label_9 = add_OSB_label(9, ROTARY)
	local label_9_text = {}
	
	for i = 1,3 do
		label_9_text[i] = default_label_text(9, true)
		label_9_text[i].parent_element = label_9.name
		label_9_text[i].controllers = {{"tad_coordinates_display_mode",i - 1}}
	end
	
	label_9_text[1].value = "OFF"
	label_9_text[2].value = "LL"
	label_9_text[3].value = "MGRS"
	
	add_osb_static_hint(9,_("Select Coordinate System"))
	addOSB_Box(9,{label_9,label_9_text[1],label_9_text[2],label_9_text[3]})
end


-- SetLowerLeftCornerOrigin(elem) function is not used here,
-- as TAD cursor should be rendered before the bullseye info display
function add_bullseye_info()
	local   bullseye						= CreateElement "ceStringPoly"
	bullseye.material				= font_MFCD
	bullseye.alignment				= "LeftTop"
	bullseye.stringdefs				= txt_labels_font
	bullseye.UseBackground			= true
	bullseye.value					= "BULL"
	bullseye.BackgroundMaterial		= MFCD_SOLID_BLACK
	bullseye.controllers			= {{"tad_pos_symbology_available"},  {"declutter"}, {"tad_bullseye_enable"}, {"tad_bullseye_avail"}}
	--bullseye.init_pos          	= {soi_min_x - OSB_symbol_spacing,soi_max_y + OSB_symbol_spacing,0}
	--SetLowerLeftCornerOrigin(bullseye)
	bullseye.init_pos          		= {soi_min_x - OSB_symbol_spacing - max_pixels_count / 2,
                                           soi_max_y + OSB_symbol_spacing - max_pixels_count / 2, 0}
	Add(bullseye)
	use_mipfilter(bullseye)

	local   bullseye_info					= Copy(bullseye)
	bullseye_info.formats			= {"%03.f°/","%03.f"}
	bullseye_info.init_pos          = {0, -OSB_symbol_spacing - 5, 0}
	bullseye_info.controllers		= {{"tad_pos_symbology_available"}, {"tad_bullseye_bearing", 0},
										   {"tad_bullseye_range", 1, navy_miles}}
	bullseye_info.parent_element	= bullseye.name
	Add(bullseye_info)
end

function add_tad_save_delete_profile_notification()
	local osb = 3
	local   Label_OSB_03_save  	   = add_OSB_label(osb, SYS_ACTION .. " ")
	Label_OSB_03_save.controllers = 
			{{"declutter"}, {"locked_OSB_status", osb - 1, -1},
			{"tad_save_profile_notification"}}

	local   Label_OSB_03_del  	   = add_OSB_label(osb, SYS_ACTION .. " ")
	Label_OSB_03_del.controllers = 
			{{"declutter"}, {"locked_OSB_status", osb - 1, -1},
			{"tad_save_profile_notification", -1}, {"tad_is_default_profile", 0}}
		
	add_osb_static_hint(osb, _("Save / Delete Profile"))
		
	local 	Label_OSB_03_value = {}
	
	for i = 1, 2 do
		Label_OSB_03_value[i]						= CreateElement "ceStringPoly"
		Label_OSB_03_value[i].alignment				= "LeftTop"
		Label_OSB_03_value[i].stringdefs			= txt_labels_font
		Label_OSB_03_value[i].UseBackground			= true
		Label_OSB_03_value[i].material				= font_MFCD
		Label_OSB_03_value[i].BackgroundMaterial	= MFCD_SOLID_BLACK
		Add(Label_OSB_03_value[i])
		use_mipfilter(Label_OSB_03_value[i])
	end
		
	Label_OSB_03_value[1].value = "SAVE"
	Label_OSB_03_value[1].parent_element = Label_OSB_03_save.name
	Label_OSB_03_value[2].value = "DEL"
	SetLowerLeftCornerOrigin(Label_OSB_03_value[2])
	
	Label_OSB_03_value[2].init_pos	= {OSB_positions[osb][1], soi_max_y + OSB_symbol_spacing, 0}
	Label_OSB_03_value[2].controllers = 
			{{"declutter"}, {"locked_OSB_status", osb - 1, -1},
			{"tad_save_profile_notification", -1}}
			 
	Label_OSB_03_value[3]						= CreateElement "ceStringPoly"
	Label_OSB_03_value[3].alignment				= "LeftTop"
	Label_OSB_03_value[3].stringdefs			= txt_labels_font
	Label_OSB_03_value[3].UseBackground			= true
	Label_OSB_03_value[3].parent_element		= Label_OSB_03_save.name
	Label_OSB_03_value[3].material				= font_MFCD_BLACK
	Label_OSB_03_value[3].BackgroundMaterial	= MFCD_SOLID_GREEN
	--	Label_OSB_03_value[2].controllers			= {{"isBlink", 0.5}} --TODO:FIXME
	Label_OSB_03_value[3].value					= "SAVE"
	Add(Label_OSB_03_value[3])
	use_mipfilter(Label_OSB_03_value[3])
		
	addOSB_Box(3, {Label_OSB_03_save, Label_OSB_03_del,
		Label_OSB_03_value[1], Label_OSB_03_value[2], Label_OSB_03_value[3]})
	
	local ConfrmTxt  = "    PRESS AGAIN TO    \n" ..
						"    CONFIRM DELETE    "

	addConfirmation("CONFIRM_DELETION_TEXT", {{"tad_delete_profile_confirmation"}}, ConfrmTxt)
end

function AddGrid(delta_pixel_x,delta_pixel_y,rows,cols)
	local rows          = rows or 570/delta_pixel_y
	local cols          = cols or 570/delta_pixel_x
	
	local sz_x          = cols * delta_pixel_x
	local sz_y          = rows * delta_pixel_y
	
	local verts       = {{0,0},
						 {sz_x,0},
						 {sz_x,sz_y},
						 {0,sz_y}}
	local indices     = {0,1,2,2,3,0}
	
	
	local lines       = sz_y / delta_pixel_y
	
	for j = 1,cols do
		verts[#verts + 1] =  {delta_pixel_x*j ,   0}	indices[#indices + 1] = #verts - 1	
		verts[#verts + 1] =  {delta_pixel_x*j ,sz_y}	indices[#indices + 1] = #verts - 1
	end
	
	for i = 1,rows do
		verts[#verts + 1] =  {0   ,delta_pixel_y*i}		indices[#indices + 1] = #verts - 1	
		verts[#verts + 1] =  {sz_x,delta_pixel_y*i}		indices[#indices + 1] = #verts - 1
	end

	material			= MFCD_SOLID_RED
	grid			    = CreateElement "ceMeshPoly"
	grid.material	    = material
	grid.primitivetype  = "lines"	
	grid.vertices       = verts
	grid.indices	    = indices
	Add(grid)
	return grid
end

-- hooked items type 
function hook_text(alignment)
 	local label					= CreateElement "ceStringPoly"
	label.UseBackground			= true
	if inverse then
	    label.material = font_MFCD_BLACK
	    label.BackgroundMaterial = MFCD_SOLID_GREEN
	else
	    label.material = font_MFCD
	    label.BackgroundMaterial = MFCD_SOLID_BLACK	  
	end

	label.stringdefs = txt_labels_font

	if alignment == "LEFT" then
	    label.alignment = "LeftTop" 
	elseif alignment == "CENTER" then
	    label.alignment = "CenterTop"
	else
        label.alignment = "RightTop"
	end

	Add(label)
	use_mipfilter(label)
	return label
end

HT_NON_TDL     			 = 1
HT_MA          			 = 2
HT_AIR_PPLI    			 = 3
HT_AIR_TRK   			 = 4
HT_LND_PNT_PPLI  		 = 5
HT_SRF_PPLI_LND_TRK_PPLI = 6
HT_SRF_TRK_LND_TRK       = 7
HT_EPLRS_POS_REPORT      = 8
HT_EPLRS_ENTITY_DATA     = 9
HT_LND_PNT        		 = 10
HT_LCL_TGT 		         = 11
HT_EMERGENCY_PNT 		 = 12

function add_tad_hook_info()
local   d_y = font_1_y 
local   x_r = soi_max_x - 2 * OSB_symbol_spacing - font_1_x - 5
local   y_r = soi_min_y + 2 + 5 * d_y

----------------------------------------------------------------------------
local   base 			= CreateElement "ceSimple"
		base.controllers  = {{"tad_pos_symbology_available"}, {"tad_hook_info_available"},
							 {"tad_hook_info_enumeration", 1, 2}}
		-- SetLowerLeftCornerOrigin(elem) function is not used here,
		-- as TAD cursor should be rendered before coordinates
		LowerLeft_WithOutParentness(base)
		Add(base)

-----------------------------------------------------------------------------
local   BRH						= hook_text("RIGHT")
		BRH.formats				= {"%03.f°/", "%03.f\n"}
		BRH.controllers			= {{"tad_info_bearing", 0},
								   {"tad_info_range", 1, navy_miles}}
		BRH.parent_element      = base.name
		BRH.init_pos			= {x_r, y_r}

-----------------------------------------------------------------------------	
local   H						= hook_text("RIGHT")
		H.formats				= {"%.f", "NO EL"}
		H.controllers			= {{"tad_info_height", 3.280839895}}
		H.parent_element      	= base.name
		H.init_pos				= {x_r, y_r - d_y}
		
-----------------------------------------------------------------------------
local   NetAdress				 = hook_text("RIGHT")
		NetAdress.formats		 = {"TN %s", "%02d %s", "FM EPLRS"}
		NetAdress.controllers	 = {{"tad_hook_NetAddress"}}
		NetAdress.parent_element = base.name
		NetAdress.init_pos		 = {x_r, y_r - 2.0 * d_y}

local LeftBlockVertDispl = 7

-----------------------------------------------------------------------------
local   IDENT						= hook_text("LEFT")
		IDENT.formats				= {"UNKWN", "PENDNG", "ASFRND", "FRIEND", "NEUTRL", "SUSPCT", "HOSTLE"}
		IDENT.controllers			= {{"tad_hook_info_by_hooked_obj_type", HT_AIR_TRK, HT_SRF_TRK_LND_TRK, HT_LND_PNT, HT_LCL_TGT},
									   {"tad_hook_identity"}}
		IDENT.parent_element        = base.name
		IDENT.init_pos			    = {x_r - 40 * font_1_x - font_1_x / 2.1, y_r - d_y - LeftBlockVertDispl}

local   DataPlacer 			        = CreateElement "ceSimple"
        DataPlacer.parent_element   = base.name
        DataPlacer.init_pos         = {x_r - 36 * font_1_x, y_r - 3 * d_y}
     	Add(DataPlacer)
        
----------------------------------------------------------------------------
-- Upper portion
local   air_ppli_dependent_4_row 			      = CreateElement "ceSimple"
		air_ppli_dependent_4_row.controllers      = {{"tad_hook_info_by_hooked_obj_type", HT_AIR_PPLI}}
        air_ppli_dependent_4_row.parent_element   = DataPlacer.name
     	Add(air_ppli_dependent_4_row)

-----------------------------------------------------------------------------
local   FuelOnboard						= hook_text("LEFT")
		FuelOnboard.formats				= {"F%d"}
		FuelOnboard.controllers			= {{"tad_hook_FuelOnboard"}}
		FuelOnboard.parent_element      = air_ppli_dependent_4_row.name
		FuelOnboard.init_pos			= {-4 * font_1_x - font_1_x / 2.1, 3 * d_y - LeftBlockVertDispl}

-----------------------------------------------------------------------------
local   Time						    = hook_text("LEFT")
		Time.formats				    = {"", "AC%02d:%02d", "DA%02d:%02d",
		    "AR%02d:%02d", "DP%02d:%02d",
		    "TE%02d:%02d"}
		Time.controllers			    = {{"tad_hook_is_DL_point", 1},
		                                   {"tad_hook_Time"}}
		Time.parent_element             = DataPlacer.name
		Time.init_pos			        = {-4 * font_1_x - font_1_x / 2.1, 3 * d_y - LeftBlockVertDispl}

-----------------------------------------------------------------------------
local   WeaponsOnboard					= hook_text("LEFT")
		WeaponsOnboard.formats			= {"%s"}
		WeaponsOnboard.controllers		= {{"tad_hook_WeaponsOnboard"}}
		WeaponsOnboard.parent_element   = air_ppli_dependent_4_row.name
		WeaponsOnboard.init_pos			= {-4 * font_1_x - font_1_x / 2.1, 2 * d_y - LeftBlockVertDispl}

local   voice_call						= hook_text("LEFT")
		voice_call.formats				= {"%s"}
		voice_call.controllers			= {{"tad_hook_info_by_hooked_obj_type",
                                            HT_AIR_PPLI,
                                            HT_LND_PNT_PPLI,
                                            HT_SRF_PPLI_LND_TRK_PPLI},
										   {"tad_hook_voice_callsign", 0}}
		voice_call.parent_element       = air_ppli_dependent_4_row.name
		voice_call.init_pos				= {-1 * font_1_x}
		
local   Platform					    = hook_text("LEFT")
		Platform.formats			    = {"%s", "UNKNOWN",
			"FIGHTER", "ATTACK", "BOMBER",
			"AD ARTY", "SAM", "TANK", "TROOPS", "LND MRK",
			"SHIP",}
        Platform.controllers		    = {{"tad_hook_info_by_hooked_obj_type",
                                            HT_AIR_PPLI,
                                            HT_AIR_TRK,
                                            HT_LND_PNT_PPLI,
                                            HT_SRF_PPLI_LND_TRK_PPLI,
                                            HT_SRF_TRK_LND_TRK,
                                            HT_EPLRS_POS_REPORT},
									       {"tad_HookPlatform"}}
		Platform.parent_element		    = DataPlacer.name
		Platform.init_pos			    = {10 * font_1_x}

local   EmerType					    = hook_text("LEFT")
		EmerType.formats			    = {"NOSTAT",
			"DN A/C", "MN/WAT", "DITCH", "BAIL", "DISTRS"}
        EmerType.controllers		    = {{"tad_hook_info_by_hooked_obj_type",
                                            HT_EMERGENCY_PNT},
									       {"tad_HookEmerType"}}
		EmerType.parent_element		    = DataPlacer.name
		EmerType.init_pos			    = {10 * font_1_x}

local   ground_speed					= hook_text("RIGHT")
		ground_speed.formats			= {"%03.fG"}
		ground_speed.controllers	    = {{"tad_hook_info_by_hooked_obj_type",
                                            HT_AIR_PPLI,
                                            HT_AIR_TRK,
                                            HT_SRF_PPLI_LND_TRK_PPLI,
                                            HT_SRF_TRK_LND_TRK,
                                            HT_EPLRS_POS_REPORT,
                                            HT_EPLRS_ENTITY_DATA},
                                           {"tad_hook_is_DL_point", 0},
		                                   {"tad_hook_ground_speed", 0, 1.943844}}
		ground_speed.parent_element		= DataPlacer.name
		ground_speed.init_pos			= {26 * font_1_x}


local   ReqStores_BDA_VoiceChnl					= hook_text("RIGHT")
		ReqStores_BDA_VoiceChnl.formats			=
		    {"%s", -- Required Stores/Voice Freq Channel
		     "BDA UNK", "TGT DSTR", "PART DSTR", "RE-ATCK", -- BDA
		     "ATTACKING", "ENGAGING", "INVES", "COVERING", "DISENG", -- Engagement Status
		     }
		ReqStores_BDA_VoiceChnl.controllers	    = {
		    {"tad_hook_info_by_hooked_obj_type",
		      HT_AIR_PPLI, HT_AIR_TRK, HT_LND_PNT_PPLI, HT_SRF_PPLI_LND_TRK_PPLI,
		      HT_SRF_TRK_LND_TRK, HT_EPLRS_POS_REPORT, HT_EPLRS_ENTITY_DATA,
		      HT_LND_PNT, HT_LCL_TGT, HT_EMERGENCY_PNT},
		    {"tad_hook_ReqStores_BDA_VoiceChnl", 0}}
		ReqStores_BDA_VoiceChnl.parent_element  = base.name
		ReqStores_BDA_VoiceChnl.init_pos		= {x_r, y_r - 3 * d_y}
        
----------------------------------------------------------------------------
-- Lower portion		
local 	mgrs					= hook_text("CENTER")
		mgrs.parent_element     = base.name
		mgrs.formats			= {"%s %s %05d %05d\n"}
		mgrs.controllers		= {{"tad_coordinates_display_mode", 2}, {"tad_info_coordinates_MGRS", 0}}	
		mgrs.init_pos           = {max_pixels_count / 2, y_r - 4 * d_y} --{x_r - 29 * font_1_x, y_r - 4*d_y}

----------------------------------------------------------------------------
local   lat_lon = Copy(mgrs)
	    lat_lon.parent_element  = base.name
	    lat_lon.formats			= {"%c%.2d %.2d.%.3d %c%.3d %.2d.%.3d\n"}
	    lat_lon.controllers		= {{"tad_coordinates_display_mode", 1}, {"tad_info_coordinates_LL", 0}}	
	    Add(lat_lon)
--[[	
local   dbg_cursor 				= CreateElement "ceSimple"
		LowerLeft_WithOutParentness(dbg_cursor)
		Add(dbg_cursor)
		
local 	lat_lon_cursor					= hook_text("CENTER")
		lat_lon_cursor.material 		= font_MFCD_RED
		lat_lon_cursor.parent_element   = dbg_cursor.name
	    lat_lon_cursor.formats			= {"%s%02.f %06.3f %s%03.f %06.3f\n"}
	    lat_lon_cursor.controllers		= {{"tad_cursor_coordinates_LL", 0}}	
		lat_lon_cursor.init_pos         = {max_pixels_count / 2, y_r - 2 * d_y} --{x_r - 29 * font_1_x, y_r - 4*d_y}
--]]
----------------------------------------------------------------------------
--[[
local 	str36					= hook_text("RIGHT")
		str36.value			    = "123456789!123456789!123456789!123456789!12"
		str36.parent_element   	= base.name
		str36.init_pos          = {x_r,y_r + 1*d_y}
--]]

--[[
----------------------------------------------------------------------------
local   grid = AddGrid(-font_1_x, -font_1_y, 5, 42)
		grid.parent_element	= base.name
		grid.init_pos       = {x_r, y_r}
--]]

end
