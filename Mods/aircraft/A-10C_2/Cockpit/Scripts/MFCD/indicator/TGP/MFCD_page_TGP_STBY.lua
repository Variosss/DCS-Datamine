dofile(LockOn_Options.script_path.."MFCD/indicator/TGP/MFCD_TGP_tools.lua")

Label_OSB1   = add_OSB_label(1, "CNTL")

-- the branch symbol and the label itself were separated
-- intentionally to reflect the actual label alignment
Label_OSB1_symbol						= default_label_text(1,true)
Label_OSB1_symbol.value					= BRANCH_L
Label_OSB1_symbol.parent_element		= Label_OSB1.name
Label_OSB1_symbol.init_pos				= {-27, 0, 0}

addOSB_Box(1, {Label_OSB1, Label_OSB1_symbol})

add_current_laser_designator()

Label_OSB18_Text = add_text_osb_position(18, "SVC")
Label_OSB18_Text.init_pos = {soi_min_x, OSB_positions[18][2]}
Label_OSB18_Text.controllers = {{"declutter"},
	{"locked_OSB_status", 18 - 1, -1}}

Label_OSB18	= add_OSB_label(18, SYS_ACTION)
Label_OSB18.controllers = {{"declutter"},
	{"locked_OSB_status", 18 - 1, -1}, {"WOW", 1}}
		  
add_osb_static_hint(18, _("Enable TGP Servicing (No Function)"))
addOSB_Box(18, {Label_OSB18_Text, Label_OSB18})

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

add_osb_static_hint(1, _("Go to Standby Control page"))
add_osb_static_hint(2, _("Go to A-G Mode page"))
add_osb_static_hint(3, _("Standby Mode is Active"))
add_osb_static_hint(4, _("Go to A-A Mode page"))

