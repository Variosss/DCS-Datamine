dofile(LockOn_Options.script_path.."MFCD/indicator/TGP/MFCD_TGP_tools.lua")

Label_OSB1    = add_OSB_label(1, "RTN")

-- the branch symbol and the label itself were separated
-- intentionally to reflect the actual label alignment
Label_OSB1_symbol						= default_label_text(1,true)
Label_OSB1_symbol.value					= BRANCH_L
Label_OSB1_symbol.parent_element		= Label_OSB1.name
Label_OSB1_symbol.init_pos				= {-21, 0, 0}

Label_OSB19				= add_OSB_label(19, SYS_ACTION)
Label_OSB20				= add_OSB_label(20, ROTARY)

add_flir_integration()
add_gain_control()

TGP_calibration_method = {}
for i = 0, 2 do
	TGP_calibration_method[i]						= default_label_text(20,true)
	TGP_calibration_method[i].parent_element 		= Label_OSB20.name
	TGP_calibration_method[i].controllers			= {{"tgp_calibratin_method",i}}
end

TGP_calibration_method[0].value	= "CAL\nSHORT"
TGP_calibration_method[1].value	= "CAL\nLONG"

TGP_calibration 						= default_label_text(19,true)
TGP_calibration.value					= "START\nCAL"
TGP_calibration.parent_element 			= Label_OSB19.name

-- Visual appearance is the different from this 
-- message in A-G and A-A modes (with the video source)
TGP_FLIR_HOT_STBY						= CreateElement "ceStringPoly"
TGP_FLIR_HOT_STBY.name					= "TGP_FLIR_HOT_STBY"
TGP_FLIR_HOT_STBY.material				= font_MFCD_GREY
TGP_FLIR_HOT_STBY.alignment				= "CenterCenter"
TGP_FLIR_HOT_STBY.stringdefs			= txt_labels_font
TGP_FLIR_HOT_STBY.value					= "FLIR HOT"
TGP_FLIR_HOT_STBY.init_pos				= {max_pixels_count/2, 490,  0}
TGP_FLIR_HOT_STBY.UseBackground			= true
TGP_FLIR_HOT_STBY.BackgroundMaterial	= MFCD_SOLID_BLACK
TGP_FLIR_HOT_STBY.controllers			= {{"tgp_flir_hot"}, {"tgp_power"}}
SetLowerLeftCornerOrigin(TGP_FLIR_HOT_STBY)
Add(TGP_FLIR_HOT_STBY)
use_mipfilter(TGP_FLIR_HOT_STBY)

addOSB_Box(1,  {Label_OSB1, Label_OSB1_symbol})
addOSB_Box(19, {Label_OSB19, TGP_calibration})
addOSB_Box(20, {Label_OSB20, TGP_calibration_method[0], TGP_calibration_method[1]})

add_dummy_boxes({5})
add_dummy_boxes({6, 7, 8, 9, 10})
add_dummy_boxes({17, 18})


add_osb_static_hint(1,_("Return to Standby Mode page"))
add_osb_static_hint(19,_("Start Calibration (No Function)"))
add_osb_static_hint(20,_("Select Calibration Method (No Function)"))
