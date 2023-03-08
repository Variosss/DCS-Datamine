dofile(LockOn_Options.script_path.."MFCD/indicator/MFCD_useful_definitions.lua")

rendered_font_defs   = predefined_fonts[1] -- {0.0057, 0.0057,0,0}

function add_test_gray_scale_control()
	local 	Label_OSB5_base   = add_OSB_label(5, SYS_ACTION .. "  ")
	local 	Label_OSB5		  = {}
	for i = 0, 1 do
		Label_OSB5[i]						= CreateElement "ceStringPoly"
		Label_OSB5[i].alignment				= "LeftTop"
		Label_OSB5[i].value					= "TST"
		Label_OSB5[i].stringdefs			= txt_labels_font
		Label_OSB5[i].UseBackground			= true
		Label_OSB5[i].parent_element		= Label_OSB5_base.name
		if i == 0 then
			Label_OSB5[i].material				= font_MFCD
			Label_OSB5[i].BackgroundMaterial	= MFCD_SOLID_BLACK
		else
			Label_OSB5[i].material				= font_MFCD_BLACK
			Label_OSB5[i].BackgroundMaterial	= MFCD_SOLID_GREEN
			Label_OSB5[i].controllers			= {{"tgp_test_gray_scale"}}
		end
		Add(Label_OSB5[i])
		use_mipfilter(Label_OSB5[i])
	end
		
	addOSB_Box(5, {Label_OSB5_base,Label_OSB5[0],Label_OSB5[1]})
	add_osb_static_hint(5,_("Toggle Test Gray Scale"))	
end

-- "B-S" - reset LOS to boresight/Enter boresight elevation
function add_B_S_control()
	--local Label_OSB5_base   		= add_OSB_label(5, DATA_ENTRY .. "  ")
	local Label_OSB5_base   		= add_OSB_label(5, DATA_ENTRY)
	--shift_button_pos(Label_OSB5_base, 5, -5, 0) -- an attempt to deconflict with TGP altitude numerics
	
	local Label_OSB5				= CreateElement "ceStringPoly"
	Label_OSB5.alignment			= "RightTop"
	Label_OSB5.formats				= {"B-S\n%d"}
	Label_OSB5.stringdefs			= txt_labels_font
	Label_OSB5.UseBackground		= true
	Label_OSB5.parent_element		= Label_OSB5_base.name
	--Label_OSB5.init_pos			= {22, 0, 0} -- "for CenterTop"
	Label_OSB5.init_pos				= {38, 0, 0}
	Label_OSB5.material				= font_MFCD
	Label_OSB5.BackgroundMaterial	= MFCD_SOLID_BLACK
	Label_OSB5.controllers			= {{"tgp_boresight_angle"}}
	Add(Label_OSB5)
	use_mipfilter(Label_OSB5)
		
	addOSB_Box(5, {Label_OSB5_base, Label_OSB5})
	add_osb_static_hint(5,_("Reset LOS to Boresight/Enter boresight elevation"))
end

function add_flir_gain_control()

	local Label_OSB18          = add_OSB_label(18, ROTARY)
	local TGP_gain_level       = {}
	local TGP_gain_level_value = {}
	for i = 0,1 do
		TGP_gain_level[i]							= default_label_text(18,true)
		TGP_gain_level[i].parent_element 			= Label_OSB18.name
		TGP_gain_level[i].controllers				= {{"tgp_gain_level",i}}

		TGP_gain_level_value[i]							= CreateElement "ceStringPoly"
		TGP_gain_level_value[i].material				= font_MFCD
		TGP_gain_level_value[i].alignment				= "LeftCenter"
		TGP_gain_level_value[i].stringdefs				= txt_labels_font
		TGP_gain_level_value[i].UseBackground			= true
		TGP_gain_level_value[i].BackgroundMaterial		= MFCD_SOLID_BLACK
		TGP_gain_level_value[i].controllers				= {{"declutter"},
														{"tgp_flir"},
														{"tgp_gain_level",i},
														{"tgp_gain_level_value",0}}
		SetLowerLeftCornerOrigin(TGP_gain_level_value[i])
		TGP_gain_level_value[i].init_pos				= {OSB_positions[19][1] - 5,(OSB_positions[19][2] + OSB_positions[20][2] )*0.5,0}
		Add(TGP_gain_level_value[i])
		use_mipfilter(TGP_gain_level_value[i])
	end

	TGP_gain_level[0].value	= "GAIN"
	TGP_gain_level[1].value	= "LVL"
	TGP_gain_level_value[0].formats	= {"%dG"}
	TGP_gain_level_value[1].formats	= {"%dL"}
		
	addOSB_Box(18, {Label_OSB18,TGP_gain_level[0],TGP_gain_level[1]})
	add_osb_static_hint(18,_("Select Gain or Level Schedule Control (No Function)"))
	
	local Scrollers = addScrollers(20, 19, 10,
		{{"declutter"}, {"locked_OSB_status", 20 - 1, -1}},
		{{"declutter"}, {"locked_OSB_status", 19 - 1, -1}})
	
	addOSB_Box(20, {Scrollers[3]})
	addOSB_Box(19, {Scrollers[4]})

	add_osb_hint_format_controllers(19, {_("Decrease %s(No Function)")},{{"locked_OSB_status",19 - 1,-1},{"tgp_gain_level_hint",0}})
	add_osb_hint_format_controllers(20, {_("Increase %s(No Function)")},{{"locked_OSB_status",20 - 1,-1},{"tgp_gain_level_hint",0}})
	
end


function add_flir_integration()
	local Label_OSB16 = add_OSB_label(16, ROTARY)
	local TGP_FLIR_integration = {}
	for i = 0, 1 do
		TGP_FLIR_integration[i]						= default_label_text(16,true)
		TGP_FLIR_integration[i].parent_element 		= Label_OSB16.name
		TGP_FLIR_integration[i].controllers			= {{"tgp_flir_integration", i}}
	end
	TGP_FLIR_integration[0].value	= "INT\nHOT"
	TGP_FLIR_integration[1].value	= "INT\nCOLD"
	
	addOSB_Box(16, {Label_OSB16,
			   TGP_FLIR_integration[0],
			   TGP_FLIR_integration[1]})
	add_osb_static_hint(16,_("Select FLIR Integration(No Function)"))
end

function add_gain_control()
	local Label_OSB10      = add_OSB_label(10, ROTARY)
	local tgp_gain_control = {}
	for i = 0,1 do
		tgp_gain_control[i]						= default_label_text(10,true)
		tgp_gain_control[i].parent_element 		= Label_OSB10.name
		tgp_gain_control[i].controllers			= {{"tgp_gain_control",i}}
	end

	tgp_gain_control[0].value = "MGC"
	tgp_gain_control[1].value = "AGC"

	addOSB_Box(10, {Label_OSB10,
			   tgp_gain_control[0],
			   tgp_gain_control[1]})
	add_osb_static_hint(10,_("Select Gain Control(No Function)"))
end

function add_current_laser_designator()
	local Label_OSB7	 = add_OSB_label(7, ROTARY)
	Label_OSB7.controllers = {{"declutter"}, {"locked_OSB_status", 7 - 1, -1}, {"tgp_lss_active", 0}}

	local TGP_current_designator_OSB = {}
	for i = 0,2 do
		TGP_current_designator_OSB[i]						= default_label_text(7,true)
		TGP_current_designator_OSB[i].parent_element 		= Label_OSB7.name
		TGP_current_designator_OSB[i].controllers			= {{"tgp_designator_type",i}}
	end
	
	TGP_current_designator_OSB[0].value	= "LSR"
	TGP_current_designator_OSB[1].value	= "IR"
	TGP_current_designator_OSB[2].value	= "BTH"
	
	addOSB_Box(7, {Label_OSB7,
				TGP_current_designator_OSB[0],
				TGP_current_designator_OSB[1],
				TGP_current_designator_OSB[2]})
	
	add_osb_static_hint(7,_("Select Designator"),{{"tgp_lss_active", 0}})
end


function add_laser_arm()
	local Label_OSB7 		= add_OSB_label(7, ROTARY)
	local tgp_laser_arm 	= {}
	local tgp_laser_switch  = {}
	
	--label.alignment				= "LeftCenter"
	--label.init_pos				= {soi_max_x,OSB_positions[7][2]}
	
	local arm_base = CreateElement "ceSimple"
	arm_base.init_pos = {soi_max_x,OSB_positions[7][2]}
	arm_base.controllers = {{"declutter"}}
	SetLowerLeftCornerOrigin(arm_base)
	Add(arm_base)
	
	for i = 0,1 do
		tgp_laser_arm[i]					= default_label_text(7,true)
		tgp_laser_arm[i].parent_element 	= arm_base.name
	end
	
	tgp_laser_arm[0].controllers		= {{"tgp_laser_arm_training"}}
	tgp_laser_arm[0].value				= "TRNG\n"
	tgp_laser_arm[1].controllers		= {{"tgp_laser_arm_training",-1}}
	tgp_laser_arm[1].value				= "CMBT\n"

	for i = 0,1 do
		tgp_laser_switch[i]						= default_label_text(7,true)
		tgp_laser_switch[i].parent_element      = tgp_laser_arm[0].name
		tgp_laser_switch[i].controllers			= {{"tgp_laser_master_switch",i}}
	end
	
	tgp_laser_switch[0].value	= "\nOFF"
	tgp_laser_switch[1].value	= "\nON"

	tgp_laser_switch[2]						= Copy(tgp_laser_switch[0])
	tgp_laser_switch[2].parent_element      = tgp_laser_arm[1].name
	Add(tgp_laser_switch[2])

	tgp_laser_switch[3]						= Copy(tgp_laser_switch[1])
	tgp_laser_switch[3].parent_element      = tgp_laser_arm[1].name
	Add(tgp_laser_switch[3])
	
	addOSB_Box(7, {Label_OSB7,
			  	  tgp_laser_arm[0],
				  tgp_laser_arm[1],
				  tgp_laser_switch[0],
				  tgp_laser_switch[1],
				  tgp_laser_switch[2],
				  tgp_laser_switch[3]})
	
end

function add_time()

	local 	tgp_time			= CreateElement "ceStringPoly"
	tgp_time.material			= font_MFCD
	tgp_time.alignment			= "LeftCenter"
	tgp_time.stringdefs			= txt_labels_font
	tgp_time.UseBackground		= true
	tgp_time.BackgroundMaterial	=MFCD_SOLID_BLACK
	SetLowerLeftCornerOrigin(tgp_time)
	tgp_time.init_pos 			= {soi_min_x - 21,soi_min_y + 2*size_ARS + 15}
	tgp_time.formats			= {"%02d:%02d:%02d"}
	tgp_time.controllers		= {{"tgp_time",0}}	
 	use_mipfilter(tgp_time)	
	Add(tgp_time)
end

function add_lss_osb_block()

	local Label_OSB6					= add_OSB_label(6, SYS_ACTION)

	local TGP_LSS_mode					= default_label_text(6,true)
	TGP_LSS_mode.parent_element 		= Label_OSB6.name
	TGP_LSS_mode.value					= "LSS"
	TGP_LSS_mode.controllers			= {{"tgp_lss_mode",0}}

	local TGP_LSS_mode_active			= default_label_text(6,true,true)
	TGP_LSS_mode_active.parent_element 	= Label_OSB6.name
	TGP_LSS_mode_active.value			= "LSS"
	TGP_LSS_mode_active.controllers		= {{"tgp_lss_mode",2}}

	local TGP_LST_mode_active			= default_label_text(6,true,true)
	TGP_LST_mode_active.parent_element 	= Label_OSB6.name
	TGP_LST_mode_active.value			= "LST"
	TGP_LST_mode_active.controllers		= {{"tgp_lss_mode",1,3,4}}
	addOSB_Box(6, {Label_OSB6,TGP_LSS_mode})
		  
	add_osb_static_hint(6,_("Activate LSS/LST mode"))
end


function add_time_of_fall()
	local timer = CreateElement "ceStringPoly"
	timer.alignment				= "RightTop"
	timer.stringdefs			= txt_labels_font
	timer.UseBackground			= true
	timer.material				= font_MFCD
	--timer.value                 = "R0M:SS"
	timer.BackgroundMaterial	= MFCD_SOLID_BLACK
	timer.controllers           = {{"tgp_time_of_fall"}}
	timer.init_pos              = {soi_max_x - 13, soi_min_y + size_ARS + 30}
	SetLowerLeftCornerOrigin(timer)	
	Add(timer)
	use_mipfilter(timer)
end


function add_coordinates_field()
	local 	TGP_coords_placer			= CreateElement "ceSimple"
	TGP_coords_placer.name		= "TGP_coords_placer"
	TGP_coords_placer.init_pos 	= {max_pixels_count / 2, 55}
	TGP_coords_placer.controllers   = {{"tgp_LSS_ON", 0}}
	SetLowerLeftCornerOrigin(TGP_coords_placer)
	Add(TGP_coords_placer)

	local 	mgrs			= CreateElement "ceStringPoly"
	mgrs.name				= "tgp_coordinates_mgrs"
	mgrs.material			= font_MFCD
	mgrs.alignment			= "CenterCenter"
	mgrs.stringdefs			= txt_labels_font
	mgrs.UseBackground		= true
	mgrs.BackgroundMaterial	= MFCD_SOLID_BLACK
	mgrs.parent_element     = TGP_coords_placer.name
		
	mgrs.formats			= {"%s %s %05d %05d\n", "%.f"}
	mgrs.controllers		= {{"tgp_coordinates_display", 2},
								   {"tgp_coordinates_MGRS", 0}}	
 	Add(mgrs)
	use_mipfilter(mgrs)

	local lat_lon = Copy(mgrs)
	lat_lon.name            = "tgp_coordinates_lat_lon"
	lat_lon.formats			= {"%s%02.f %06.3f %s%03.f %06.3f\n", "%.f", "%.f"}
	lat_lon.controllers		= {{"tgp_coordinates_display", 1},
								   {"tgp_coordinates_LL"}}
	Add(lat_lon)

	local altitude = Copy(mgrs)
	altitude.name            = "tgp_coordinates_altitude"
	altitude.alignment		= "LeftCenter"
	altitude.init_pos 		= {55, -11}
	altitude.formats		= {"%.f"}
	altitude.controllers	= {{"tgp_coordinates_display", 1, 2}, {"tgp_coordinates_altitude", 3.28}}
	Add(altitude)
	  
	local TGP_LCODE 		= Copy(mgrs)
	TGP_LCODE.name		    = "TGP_LCODE"
	--TGP_LCODE.alignment	    = "LeftCenter"
	--TGP_LCODE.init_pos	    = {-99, -23}
	TGP_LCODE.alignment	    = "RightCenter"
	TGP_LCODE.init_pos	    = {-44, -11}
	TGP_LCODE.formats       = {"L%d", "L////"}
	TGP_LCODE.controllers   = {{"tgp_bomb_laser_code"}}
	Add(TGP_LCODE)
	  
	local TGP_AutolaseStatus 		        = Copy(mgrs)
	TGP_AutolaseStatus.name	        = "TGP_AutolaseStatus"
	TGP_AutolaseStatus.parent_element = TGP_LCODE.name
	TGP_AutolaseStatus.alignment      = "RightCenter"
	TGP_AutolaseStatus.init_pos	    = {-55, 0}
	TGP_AutolaseStatus.value          = "A"
	TGP_AutolaseStatus.controllers    = {{"tgp_AutolaseStatus"}}
	Add(TGP_AutolaseStatus)
end

function add_frame()
	local   frame_start 		= CreateElement "ceSimple"
	frame_start.isdraw		    = true
	frame_start.controllers     = {{"tgp_track_frame",2*(max_pixels_count/2)*GetScale(),2*(max_pixels_count/2)*GetScale()}}
	Add(frame_start);

	local size					= 2.2 -- текстура немного не влезает
	local tex_param_default		= 2 * texture_scale
	local box  					= CreateElement "ceBoundingTexBox"
	box.material	   		= MFCD_GREY_2
	box.width				= size
	box.tex_params			= {{0.1,503.5/512},{0.9,503.5/512}, {texture_scale, tex_param_default}}
	box.vertices			= {{-20,-20},
							   { 20,-20},
							   { 20, 20},
							   {-20, 20},
							   {-20,-20}}
	box.controllers			= {{"tgp_track_frame",2*(max_pixels_count/2)*GetScale(),2*(max_pixels_count/2)*GetScale()},
							   {"tgp_frame_box",1*(max_pixels_count/2)*GetScale(),1*(max_pixels_count/2)*GetScale()}}
	box.h_clip_relation  = h_clip_relations.COMPARE
	box.level 		     = DEFAULT_LEVEL
	Add(box)
	use_mipfilter(box)
end

function add_priority_target()

	local   cross_hair_priority		  		   = CreateElement "ceSimple"
	cross_hair_priority.controllers	   = {{"tgp_priority_target",2*(max_pixels_count/2)*GetScale(),2*(max_pixels_count/2)*GetScale()}}
	Add(cross_hair_priority)

	local 	cross_hair_priority_lines = {}
	for i = 1,2 do
			cross_hair_priority_lines[i]				 = line_2_pixel({{-(max_pixels_count/2)*0.1,0},{(max_pixels_count/2)*0.1,0}},MFCD_GREY_2)
			cross_hair_priority_lines[i].parent_element  = cross_hair_priority.name
			cross_hair_priority_lines[i].init_rot        = {90 * (i - 1),0,0}
			cross_hair_priority_lines[i].h_clip_relation = h_clip_relations.COMPARE
			cross_hair_priority_lines[i].level 		     = DEFAULT_LEVEL
	end

end

function add_FocusReset()
	Label_OSB6   = add_OSB_label(6,  SYS_ACTION)

	tgp_focus_reset						= default_label_text(6,true)
	tgp_focus_reset.parent_element 		= Label_OSB6.name
	tgp_focus_reset.value				= "FOCUS\nRESET"

	addOSB_Box(6, {Label_OSB6, tgp_focus_reset})
	add_osb_static_hint(6, _("Focus Reset"))
end


function add_LSR_LatchOnOff()
	Label_OSB8   = add_OSB_label(8,  ROTARY)
	   
	tgp_latch = {}
	for i = 1, 2 do
		tgp_latch[i]						= default_label_text(8,true)
		tgp_latch[i].parent_element 		= Label_OSB8.name
		tgp_latch[i].controllers			= {{"tgp_latch", i - 1}}
	end

	tgp_latch[1].value = "LATCH\nOFF"
	tgp_latch[2].value = "LATCH\nON"

	addOSB_Box(8, {Label_OSB8, tgp_latch[1], tgp_latch[2]})
				   
	add_osb_static_hint(8,_("Latch Setting"))
end