dofile(LockOn_Options.script_path.."MFCD/indicator/TGP/MFCD_TGP_tools.lua")

Label_OSB1   = add_OSB_label(1  ,"RTN")

-- the branch symbol and the label itself were separated
-- intentionally to reflect the actual label alignment
Label_OSB1_symbol						= default_label_text(1,true)
Label_OSB1_symbol.value					= BRANCH_L
Label_OSB1_symbol.parent_element		= Label_OSB1.name
Label_OSB1_symbol.init_pos				= {-21, 0, 0}

addOSB_Box(1, {Label_OSB1, Label_OSB1_symbol})

add_FocusReset()
add_LSR_LatchOnOff()
add_test_gray_scale_control()
add_flir_integration()
add_gain_control()
--add_flir_gain_control()
add_laser_arm()
add_osb_static_hint(7,_("Select Laser Mode"))
add_time()

add_dummy_boxes({6, 8, 9})
add_dummy_boxes({17, 18, 19, 20})

add_osb_static_hint(1, _("Return to A-A Mode page"))
add_osb_static_hint(2, _("Go to A-G Mode page"))
add_osb_static_hint(3, _("Go to Standby Mode page"))
add_osb_static_hint(4, _("A-A Mode is Active"))
