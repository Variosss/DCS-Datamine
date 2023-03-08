dofile(LockOn_Options.script_path.."MFCD/indicator/MFCD_useful_definitions.lua")
dofile(LockOn_Options.script_path.."MFCD/indicator/DSMS/MFCD_DSMS_useful_definitions.lua")

AddMaverickPowerTimeLabel()

GUN_stat							= CreateElement "ceStringPoly"
GUN_stat.name						= "GUN_stat"
GUN_stat.material					= font_MFCD
GUN_stat.alignment					= "LeftCenter"
GUN_stat.init_pos					= {max_pixels_count/2 - 80, OSB_positions[10][2]}
SetLowerLeftCornerOrigin(GUN_stat)
GUN_stat.stringdefs					= predefined_fonts[3]
GUN_stat.UseBackground				= true
GUN_stat.BackgroundMaterial			= MFCD_SOLID_BLACK
GUN_stat.formats					= {"%4d CM","%4d HEI", "%4d TP",  "XXXX XX "}
GUN_stat.controllers				= {{"DSMS_gun_stat", 0}}
Add(GUN_stat)
use_mipfilter(GUN_stat) 

training_label							= CreateElement "ceStringPoly"
training_label.name						= "TRAINING_LABEL"
training_label.material					= font_MFCD_BLUE
training_label.alignment				= "CenterBottom"
training_label.init_pos					= {max_pixels_count/2, (OSB_positions[7][2] + OSB_positions[6][2]) / 2}
SetLowerLeftCornerOrigin(training_label)
training_label.stringdefs				= predefined_fonts[1]
training_label.UseBackground			= false
training_label.BackgroundMaterial		= MFCD_SOLID_BLACK
training_label.value					= "TRAINING"
training_label.controllers				= {{"DSMS_training_label"}}
Add(training_label)
use_mipfilter(training_label) 

training_frame					=  line_2_pixel({{-45,23},{45,23},{45,2},{-45,2},{-45,23}}, MFCD_BLUE)
training_frame.parent_element	=  training_label.name

GND_SAFE_txt							= CreateElement "ceStringPoly"
GND_SAFE_txt.name						= "GND_SAFE_txt"
GND_SAFE_txt.material					= font_MFCD_BLACK
GND_SAFE_txt.alignment					= "CenterBottom"
GND_SAFE_txt.init_pos					= training_label.init_pos
SetLowerLeftCornerOrigin(GND_SAFE_txt)
GND_SAFE_txt.stringdefs					= predefined_fonts[1]
GND_SAFE_txt.UseBackground				= true
GND_SAFE_txt.BackgroundMaterial			= MFCD_SOLID_WHITE
GND_SAFE_txt.value						= "GND SAFE"
GND_SAFE_txt.controllers				= {{"DSMS_GND_SAFE_txt"}}
Add(GND_SAFE_txt)
use_mipfilter(GND_SAFE_txt) 

RIPPLE_MESSAGE_txt_pos                          = training_label.init_pos
RIPPLE_MESSAGE_txt_pos[2]                       = RIPPLE_MESSAGE_txt_pos[2] - 24

RIPPLE_MESSAGE_txt								= CreateElement "ceStringPoly"
RIPPLE_MESSAGE_txt.name							= "RIPPLE_MESSAGE_txt"
RIPPLE_MESSAGE_txt.material						= "font_MFCD_BLACK"
RIPPLE_MESSAGE_txt.alignment					= "CenterBottom"
RIPPLE_MESSAGE_txt.init_pos						= RIPPLE_MESSAGE_txt_pos
SetLowerLeftCornerOrigin(RIPPLE_MESSAGE_txt)
RIPPLE_MESSAGE_txt.stringdefs					= predefined_fonts[1]
RIPPLE_MESSAGE_txt.UseBackground				= true
RIPPLE_MESSAGE_txt.BackgroundMaterial			= "MFCD_WHITE"
RIPPLE_MESSAGE_txt.formats                      = {"250 MS RIPPLE", "RIPPLE INVALID", "NO RIPPLE"}
RIPPLE_MESSAGE_txt.controllers					= {{"DSMS_RIPPLE_MESSAGE_txt"}}
Add(RIPPLE_MESSAGE_txt)
use_mipfilter(RIPPLE_MESSAGE_txt) 

labels = {}

labels[0]						= CreateElement "ceStringPoly"
labels[0].name					= "OSB_" .. string.format("%d",0)
labels[0].material				= font_MFCD
labels[0].UseBackground			= false
labels[0].BackgroundMaterial	= MFCD_SOLID_BLACK
labels[0].alignment				= "CenterTop"
labels[0].value					= BRANCH_L .. "PROF"
labels[0].stringdefs			= predefined_fonts[1]
shift_button_pos(labels[0],0  + 1,0)
SetLowerLeftCornerOrigin(labels[0])
Add(labels[0])
use_mipfilter(labels[0])

addOSB_Box(0+1, {labels[0]})
add_osb_static_hint(0+1, _("Go to Profile Main page"))

labels[1]						= Copy(labels[0])
labels[1].value					= BRANCH_L .. "MSL"
shift_button_pos(labels[1],1  + 1,0)
SetLowerLeftCornerOrigin(labels[1])
Add(labels[1])
use_mipfilter(labels[1])

addOSB_Box(1+1, {labels[1]})
add_osb_static_hint(1+1, _("Go to Missile Control page"))

labels[3]						= Copy(labels[0])
labels[3].value					= BRANCH_L .. "SJET"
shift_button_pos(labels[3],3  + 1,0)
SetLowerLeftCornerOrigin(labels[3])
Add(labels[3])
use_mipfilter(labels[3])

addOSB_Box(3+1, {labels[3]})
add_osb_static_hint(3+1, _("Go to Selective Jettison page"))

labels[4]						= Copy(labels[0])
labels[4].value					= BRANCH_L .. "INV"
shift_button_pos(labels[4],4  + 1,0)
SetLowerLeftCornerOrigin(labels[4])
Add(labels[4])
use_mipfilter(labels[4])

addOSB_Box(4+1, {labels[4]})
add_osb_static_hint(4+1, _("Go to Inventory Main page"))

Profile_name						= CreateElement "ceStringPoly"
Profile_name.name					= "PROFILE_NAME"
Profile_name.material				= font_MFCD
Profile_name.alignment				= "CenterCenter"
Profile_name.init_pos				= {max_pixels_count/2,(OSB_positions[8][2]+OSB_positions[7][2])/2,0}
SetLowerLeftCornerOrigin(Profile_name)
Profile_name.stringdefs				= predefined_fonts[3]
Profile_name.UseBackground			= true
Profile_name.BackgroundMaterial		= MFCD_SOLID_BLACK
Profile_name.formats				= {"%s"}
Profile_name.controllers			= {{"DSMS_profile_name"}}
Add(Profile_name)
use_mipfilter(Profile_name) 

Profile_name_underline					= CreateElement "ceStringPoly"
Profile_name_underline.name				= "PROFILE_NAME_UNDERLINE"
Profile_name_underline.material			= font_MFCD
Profile_name_underline.UseBackground	= false
Profile_name_underline.alignment		= "CenterCenter"
Profile_name_underline.controllers		= {{"DSMS_profile_not_wpns_off"}, {"DSMS_profile_name"}, {"DSMS_underline"}}
Profile_name_underline.stringdefs		= predefined_fonts[3]
Profile_name_underline.parent_element	= Profile_name.name
Add(Profile_name_underline)
use_mipfilter(Profile_name_underline)

HUD_mode						= CreateElement "ceStringPoly"
HUD_mode.name					= "HUD_mode"
HUD_mode.material				= font_MFCD
HUD_mode.alignment				= "CenterBottom"
HUD_mode.init_pos				= {max_pixels_count/2,Profile_name.init_pos[2]+30,0}
SetLowerLeftCornerOrigin(HUD_mode)
HUD_mode.stringdefs				= predefined_fonts[1]
HUD_mode.UseBackground			= false
HUD_mode.BackgroundMaterial		= MFCD_SOLID_BLACK
HUD_mode.formats				= {"XXXX", "NAV", "GUNS", "CCIP", "CCRP" , "AIR-TO-AIR", "TEST", "STANDBY"}
HUD_mode.controllers			= {{"DSMS_hud_mode"}}
Add(HUD_mode)
use_mipfilter(HUD_mode) 

Label_SGL							= CreateElement "ceStringPoly"
Label_SGL.name						= "LABEL_SGL"
Label_SGL.alignment					= "CenterTop"
Label_SGL.value						= "SGL"
Label_SGL.material					= font_MFCD
Label_SGL.stringdefs				= txt_labels_font
Label_SGL.controllers				= {{"DSMS_profile_not_wpns_off"}, {"DSMS_profile_not_maverick"}, {"DSMS_profile_not_air_air"}, {"DSMS_profile_active_release_mode", 0}}
Label_SGL.UseBackground				= false
Label_SGL.BackgroundMaterial		= MFCD_SOLID_BLACK
Label_SGL.init_pos					= {max_pixels_count/2,Profile_name.init_pos[2]-30,0}
SetLowerLeftCornerOrigin(Label_SGL)
Add(Label_SGL)
use_mipfilter(Label_SGL)

Label_PRS							= Copy(Label_SGL)
Label_PRS.value						= "PRS"
Label_PRS.controllers				= {{"DSMS_profile_not_wpns_off"}, {"DSMS_profile_not_maverick"}, {"DSMS_profile_not_air_air"}, {"DSMS_profile_active_release_mode", 1}}
SetLowerLeftCornerOrigin(Label_PRS)
Add(Label_PRS)
use_mipfilter(Label_PRS)

Label_RIP_SGL						= Copy(Label_SGL)
Label_RIP_SGL.value					= "RIP SGL"
Label_RIP_SGL.controllers			= {{"DSMS_profile_not_wpns_off"}, {"DSMS_profile_not_maverick"}, {"DSMS_profile_not_air_air"}, {"DSMS_profile_active_release_mode", 2}}
SetLowerLeftCornerOrigin(Label_RIP_SGL)
Add(Label_RIP_SGL)
use_mipfilter(Label_RIP_SGL)

Label_RIP_PRS						= Copy(Label_SGL)
Label_RIP_PRS.value					= "RIP PRS"
Label_RIP_PRS.controllers			= {{"DSMS_profile_not_wpns_off"}, {"DSMS_profile_not_maverick"}, {"DSMS_profile_not_air_air"}, {"DSMS_profile_active_release_mode", 3}}
SetLowerLeftCornerOrigin(Label_RIP_PRS)
Add(Label_RIP_PRS)
use_mipfilter(Label_RIP_PRS)

Label_NT							= CreateElement "ceStringPoly"
Label_NT.name						= "LABEL_NT"
Label_NT.alignment					= "CenterTop"
Label_NT.value						= "N/T"
Label_NT.material					= font_MFCD
Label_NT.stringdefs					= txt_labels_font
Label_NT.controllers				= {{"DSMS_profile_active_fuze_type", 0}}
Label_NT.UseBackground				= false
Label_NT.BackgroundMaterial			= MFCD_SOLID_BLACK
Label_NT.init_pos					= {max_pixels_count/2,Profile_name.init_pos[2]-50,0}
SetLowerLeftCornerOrigin(Label_NT)
Add(Label_NT)
use_mipfilter(Label_NT)

Label_NOSE							= Copy(Label_NT)
Label_NOSE.value					= "NOSE"
Label_NOSE.controllers				= {{"DSMS_profile_active_fuze_type", 1}}
SetLowerLeftCornerOrigin(Label_NOSE)
Add(Label_NOSE)
use_mipfilter(Label_NOSE)

Label_TAIL							= Copy(Label_NT)
Label_TAIL.value					= "TAIL"
Label_TAIL.controllers				= {{"DSMS_profile_active_fuze_type", 2}}
SetLowerLeftCornerOrigin(Label_TAIL)
Add(Label_TAIL)
use_mipfilter(Label_TAIL)

Label_qty							= CreateElement "ceStringPoly"
Label_qty.name						= "label_qty"
Label_qty.alignment					= "CenterTop"
Label_qty.formats					= {"QTY %d"}
Label_qty.material					= font_MFCD
Label_qty.stringdefs				= txt_labels_font
Label_qty.UseBackground				= false
Label_qty.BackgroundMaterial		= MFCD_SOLID_BLACK
Label_qty.init_pos					= {max_pixels_count/2,Profile_name.init_pos[2]-70,0}
Label_qty.controllers				= {{"DSMS_profile_active_qty_avail"}, {"DSMS_profile_active_qty", 0}}
SetLowerLeftCornerOrigin(Label_qty)
Add(Label_qty)
use_mipfilter(Label_qty)

Label_feet							= CreateElement "ceStringPoly"
Label_feet.name						= "label_feet"
Label_feet.alignment				= "CenterTop"
Label_feet.formats					= {"%d FT"}
Label_feet.material					= font_MFCD
Label_feet.stringdefs				= txt_labels_font
Label_feet.UseBackground			= false
Label_feet.BackgroundMaterial		= MFCD_SOLID_BLACK
Label_feet.init_pos					= {max_pixels_count/2,Profile_name.init_pos[2]-90,0}
Label_feet.controllers				= {{"DSMS_profile_active_feet_avail"}, {"DSMS_profile_active_feet", 0}}
SetLowerLeftCornerOrigin(Label_feet)
Add(Label_feet)
use_mipfilter(Label_feet)


add_osb_static_hint(2+1, _("Manual select station 6"))

add_osb_static_hint(5+1, _("Manual select station 7"))
add_osb_static_hint(6+1, _("Manual select station 8"))
add_osb_static_hint(7+1, _("Manual select station 9"))
add_osb_static_hint(8+1, _("Manual select station 10"))
add_osb_static_hint(9+1, _("Manual select station 11"))

add_osb_static_hint(15+1, _("Manual select station 1"))
add_osb_static_hint(16+1, _("Manual select station 2"))
add_osb_static_hint(17+1, _("Manual select station 3"))
add_osb_static_hint(18+1, _("Manual select station 4"))
add_osb_static_hint(19+1, _("Manual select station 5"))
