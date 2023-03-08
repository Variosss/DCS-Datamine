dofile(LockOn_Options.script_path.."MFCD/indicator/TGP/MFCD_TGP_tools.lua")

Label_OSB1   = add_OSB_label(1, "CNTL")

-- the branch symbol and the label itself were separated
-- intentionally to reflect the actual label alignment
Label_OSB1_symbol						= default_label_text(1,true)
Label_OSB1_symbol.value					= BRANCH_L
Label_OSB1_symbol.parent_element		= Label_OSB1.name
Label_OSB1_symbol.init_pos				= {-27, 0, 0}

addOSB_Box(1, {Label_OSB1, Label_OSB1_symbol})

add_test_gray_scale_control()
add_flir_gain_control()
add_laser_arm()
add_time()

add_dummy_boxes({6, 8, 9, 10})
add_dummy_boxes({16, 17})

--by TIS request custom hint for this button mustbe  showed even if the button is locked for user 
 local hnt_laser_arm			 = add_osb_static_hint(7,_("Laser Mode Indication"))
	   hnt_laser_arm.controllers = {}

add_osb_static_hint(1,_("Go to A-A Control page"))
add_osb_static_hint(2,_("Go to A-G Mode page"))
add_osb_static_hint(3,_("Go to Standby Mode page"))
add_osb_static_hint(4,_("A-A Mode is Active"))
