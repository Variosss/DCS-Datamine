dofile(LockOn_Options.script_path.."MFCD/indicator/TGP/MFCD_TGP_tools.lua")

Label_OSB1   = add_OSB_label(1  ,"RTN")

-- the branch symbol and the label itself were separated
-- intentionally to reflect the actual label alignment
Label_OSB1_symbol						= default_label_text(1, true)
Label_OSB1_symbol.value					= BRANCH_L
Label_OSB1_symbol.parent_element		= Label_OSB1.name
Label_OSB1_symbol.init_pos				= {-21, 0, 0}

addOSB_Box(1, {Label_OSB1, Label_OSB1_symbol})

add_osb_static_hint(1,_("Return to A-G Mode page"))

Label_OSB7   = add_OSB_label(7,  ROTARY)
Label_OSB7.controllers = {{"tgp_LSS_ON", 0}}

Label_OSB8   = add_OSB_label(8,  ROTARY)

Label_OSB9   = add_OSB_label(9,  ROTARY)
Label_OSB9.controllers = {{"tgp_LSS_ON", 0}}

Label_OSB17  = add_OSB_label(17, DATA_ENTRY)
Label_OSB18  = add_OSB_label(18, DATA_ENTRY)
Label_OSB20  = add_OSB_label(20, DATA_ENTRY)


add_test_gray_scale_control()
add_time()
add_flir_integration() -- OSB 16
add_gain_control() -- OSB 10

TGP_coordinates_display_type = {}
for i = 0,2 do
	TGP_coordinates_display_type[i]						= default_label_text(7, true)
	TGP_coordinates_display_type[i].parent_element 		= Label_OSB7.name
	TGP_coordinates_display_type[i].controllers			= {{"tgp_coordinates_display",i}}
end

TGP_coordinates_display_type[0].value = "OFF"
TGP_coordinates_display_type[1].value = "LL"
TGP_coordinates_display_type[2].value = "MGRS"

addOSB_Box(7, {Label_OSB7,
			   TGP_coordinates_display_type[0],
			   TGP_coordinates_display_type[1],
			   TGP_coordinates_display_type[2]})
			   
add_osb_static_hint(7,_("Select Coordinate System"))

tgp_coordinates_system = {}
for i = 0,2 do
	tgp_coordinates_system[i]						= default_label_text(9, true)
	tgp_coordinates_system[i].parent_element 		= Label_OSB9.name
	tgp_coordinates_system[i].controllers			= {{"tgp_coordinates_system",i}}
end

tgp_coordinates_system[0].value = "OFF"
tgp_coordinates_system[1].value = "METRIC"
tgp_coordinates_system[2].value = "U.S."

addOSB_Box(9, {Label_OSB9,
			   tgp_coordinates_system[0],
			   tgp_coordinates_system[1],
			   tgp_coordinates_system[2]})

add_osb_static_hint(9, _("Yardstick Display"))
	
add_LSR_LatchOnOff()	

add_FocusReset()
			 
tgp_taaf					= default_label_text(20,true)
tgp_taaf.parent_element 	= Label_OSB20.name
tgp_taaf.formats            = {"TAAF\n%.f"}
tgp_taaf.controllers		= {{"tgp_TAAF",0}}

addOSB_Box(20, {Label_OSB20, tgp_taaf})
add_osb_static_hint(20,_("Enter Advisory Alert Altitude"))

tgp_laser_spot_search_code					= Copy(tgp_taaf)
tgp_laser_spot_search_code.parent_element 	= Label_OSB17.name
tgp_laser_spot_search_code.formats          = {"LSS\n%d"}
tgp_laser_spot_search_code.controllers		= {{"tgp_laser_spot_search_code",0}}
Add(tgp_laser_spot_search_code)

addOSB_Box(17, {Label_OSB17, tgp_laser_spot_search_code})

add_osb_static_hint(17, _("Enter LSS Code"))

tgp_laser_code					= Copy(tgp_taaf)
tgp_laser_code.parent_element 	= Label_OSB18.name
tgp_laser_code.formats          = {"L\n%d"}
tgp_laser_code.controllers		= {{"tgp_laser_designation_code",0}}
Add(tgp_laser_code)

addOSB_Box(18, {Label_OSB18, tgp_laser_code})

add_osb_static_hint(18, _("Enter Laser Designation Code"))

Label_OSB19  = add_OSB_label(19, ROTARY)

ShowFriendlies = {}
for i = 1, 2 do
	ShowFriendlies[i]						= default_label_text(19,true)
	ShowFriendlies[i].parent_element 		= Label_OSB19.name
	ShowFriendlies[i].controllers			= {{"tgp_ShowFriendlies", i - 1}}
end

ShowFriendlies[1].value = "FRND\nOFF"
ShowFriendlies[2].value = "FRND\nON"

addOSB_Box(19, {Label_OSB19, ShowFriendlies[1], ShowFriendlies[2]})
add_osb_static_hint(19, _("To show friendly SADL symbols"))

