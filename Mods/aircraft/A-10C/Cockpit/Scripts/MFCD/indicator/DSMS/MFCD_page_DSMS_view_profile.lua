dofile(LockOn_Options.script_path.."MFCD/indicator/MFCD_useful_definitions.lua")
dofile(LockOn_Options.script_path.."materials.lua")
dofile(LockOn_Options.script_path.."MFCD/indicator/DSMS/MFCD_DSMS_useful_definitions.lua")

AddStatLabel()

Label_OSB2							= CreateElement "ceStringPoly"
Label_OSB2.name						= "LABEL_OSB2"
Label_OSB2.material					= font_MFCD
Label_OSB2.UseBackground			= false
Label_OSB2.BackgroundMaterial		= MFCD_SOLID_BLACK
Label_OSB2.alignment				= "CenterTop"
Label_OSB2.value					= BRANCH_L .. "PROF\n MAIN"
Label_OSB2.stringdefs				= predefined_fonts[1]
shift_button_pos(Label_OSB2, 2)
Add(Label_OSB2)
use_mipfilter(Label_OSB2)

addOSB_Box(2, {Label_OSB2})
add_osb_static_hint(2, _("Return to Profile Main page"))

Label_OSB3							= CreateElement "ceStringPoly"
Label_OSB3.name						= "LABEL_OSB3"
Label_OSB3.material					= font_MFCD
Label_OSB3.UseBackground			= false
Label_OSB3.BackgroundMaterial		= MFCD_SOLID_BLACK
Label_OSB3.alignment				= "CenterTop"
Label_OSB3.value					= "SAVE"
Label_OSB3.stringdefs				= predefined_fonts[1]
Label_OSB3.controllers				= {{"DSMS_save_profile_label", 0}}
shift_button_pos(Label_OSB3, 3)
Add(Label_OSB3)
use_mipfilter(Label_OSB3)

Label_OSB3_inverted					= CreateElement "ceStringPoly"
Label_OSB3_inverted.name			= "LABEL_OSB3_INVERTED"
Label_OSB3_inverted.material		= font_MFCD_BLACK
Label_OSB3_inverted.UseBackground	= true
Label_OSB3_inverted.BackgroundMaterial= MFCD_SOLID_GREEN
Label_OSB3_inverted.alignment		= "CenterTop"
Label_OSB3_inverted.value			= "SAVE"
Label_OSB3_inverted.stringdefs		= predefined_fonts[1]
Label_OSB3_inverted.controllers		= {{"DSMS_save_profile_label", 1}}
shift_button_pos(Label_OSB3_inverted, 3)
Add(Label_OSB3_inverted)
use_mipfilter(Label_OSB3_inverted)

Label_OSB3_symbol					= Copy(Label_OSB3)
Label_OSB3_symbol.value				= SYS_ACTION
Label_OSB3_symbol.controllers		= {{"DSMS_save_profile_symbol"}}
shift_button_pos(Label_OSB3_symbol, 3, -30)
Add(Label_OSB3_symbol)
use_mipfilter(Label_OSB3_symbol)

addOSB_Box(3, {Label_OSB3, Label_OSB3_inverted, Label_OSB3_symbol})
add_osb_hint_controllers(3, _("Save profile changes"), {{"DSMS_save_profile_label", 0}})

add_dummy_boxes({4, 5})

Label_OSB6_SGL						= CreateElement "ceStringPoly"
Label_OSB6_SGL.name					= "LABEL_OSB6_SGL"
Label_OSB6_SGL.alignment			= "RightCenter"
Label_OSB6_SGL.value				= "SGL" .. ROTARY
Label_OSB6_SGL.material				= font_MFCD
Label_OSB6_SGL.stringdefs			= txt_labels_font
Label_OSB6_SGL.controllers			= {{"DSMS_profile_release_mode", 0}}
Label_OSB6_SGL.UseBackground		= false
Label_OSB6_SGL.BackgroundMaterial	= MFCD_SOLID_BLACK
shift_button_pos(Label_OSB6_SGL,6,-1*OSB_label_spacing,0)
Add(Label_OSB6_SGL)
use_mipfilter(Label_OSB6_SGL)

Label_OSB6_SGL_MAV					= CreateElement "ceStringPoly"
Label_OSB6_SGL_MAV.name				= "LABEL_OSB6_SGL_MAV"
Label_OSB6_SGL_MAV.alignment		= "RightCenter"
Label_OSB6_SGL_MAV.value			= "SGL "
Label_OSB6_SGL_MAV.material			= font_MFCD
Label_OSB6_SGL_MAV.stringdefs		= txt_labels_font
Label_OSB6_SGL_MAV.controllers		= {{"DSMS_profile_qty_mav"}}
Label_OSB6_SGL_MAV.UseBackground	= false
Label_OSB6_SGL_MAV.BackgroundMaterial= MFCD_SOLID_BLACK
shift_button_pos(Label_OSB6_SGL_MAV,6,-1*OSB_label_spacing,0)
Add(Label_OSB6_SGL_MAV)
use_mipfilter(Label_OSB6_SGL_MAV)

Label_OSB6_PRS						= Copy(Label_OSB6_SGL)
Label_OSB6_PRS.value				= "PRS" .. ROTARY
Label_OSB6_PRS.controllers			= {{"DSMS_profile_release_mode", 1}}
--Label_OSB6_PRS.controllers			= {{"DSMS_profile_is_not_IAM"}, {"DSMS_profile_release_mode", 1}}
Add(Label_OSB6_PRS)
use_mipfilter(Label_OSB6_PRS)

--Label_OSB6_TAND						= Copy(Label_OSB6_SGL)
--Label_OSB6_TAND.value				= "TAND" .. ROTARY
--Label_OSB6_TAND.controllers			= {{"DSMS_profile_is_IAM"}, {"DSMS_profile_release_mode", 1}}
--Add(Label_OSB6_TAND)
--use_mipfilter(Label_OSB6_TAND)

Label_OSB6_RIP_SGL					= Copy(Label_OSB6_SGL)
Label_OSB6_RIP_SGL.value			= "RIP SGL" .. ROTARY
Label_OSB6_RIP_SGL.controllers		= {{"DSMS_profile_is_not_IAM"}, {"DSMS_profile_release_mode", 2}}
Add(Label_OSB6_RIP_SGL)
use_mipfilter(Label_OSB6_RIP_SGL)

--Label_OSB6_SBS						= Copy(Label_OSB6_SGL)
--Label_OSB6_SBS.value				= "SBS" .. ROTARY
--Label_OSB6_SBS.controllers			= {{"DSMS_profile_is_IAM"}, {"DSMS_profile_release_mode", 2}}
--Add(Label_OSB6_SBS)
--use_mipfilter(Label_OSB6_SBS)

Label_OSB6_RIP_PRS					= Copy(Label_OSB6_SGL)
Label_OSB6_RIP_PRS.value			= "RIP PRS" .. ROTARY
Label_OSB6_RIP_PRS.controllers		= {{"DSMS_profile_is_not_IAM"}, {"DSMS_profile_release_mode", 3}}
Add(Label_OSB6_RIP_PRS)
use_mipfilter(Label_OSB6_RIP_PRS)

--Label_OSB6_DMND						= Copy(Label_OSB6_SGL)
--Label_OSB6_DMND.value				= "DMND" .. ROTARY
--Label_OSB6_DMND.controllers			= {{"DSMS_profile_is_IAM"}, {"DSMS_profile_release_mode", 3}}
--Add(Label_OSB6_DMND)
--use_mipfilter(Label_OSB6_DMND)


addOSB_Box(6, {Label_OSB6_SGL, Label_OSB6_SGL_MAV, Label_OSB6_PRS,
				Label_OSB6_RIP_SGL, Label_OSB6_RIP_PRS})
add_osb_static_hint(6, _("Select Release Mode"))

Label_OSB7						= CreateElement "ceStringPoly"
Label_OSB7.name					= "LABEL_OSB7_NT"
Label_OSB7.alignment			= "RightCenter"
Label_OSB7.formats				= {"N/T" .. ROTARY, "NOSE" .. ROTARY, "TAIL" .. ROTARY, "N/T "}
Label_OSB7.material				= font_MFCD
Label_OSB7.stringdefs			= txt_labels_font
Label_OSB7.controllers			= {{"DSMS_profile_fuze_type", 0}}
Label_OSB7.UseBackground		= false
Label_OSB7.BackgroundMaterial	= MFCD_SOLID_BLACK
shift_button_pos(Label_OSB7,7,-1*OSB_label_spacing,0)
Add(Label_OSB7)
use_mipfilter(Label_OSB7)

--[[
Label_OSB7_NT						= CreateElement "ceStringPoly"
Label_OSB7_NT.name					= "LABEL_OSB7_NT"
Label_OSB7_NT.alignment				= "RightCenter"
Label_OSB7_NT.value					= "N/T" .. ROTARY
Label_OSB7_NT.material				= font_MFCD
Label_OSB7_NT.stringdefs			= txt_labels_font
Label_OSB7_NT.controllers			= {{"DSMS_profile_fuze_type", 0}}
Label_OSB7_NT.UseBackground			= false
Label_OSB7_NT.BackgroundMaterial	= MFCD_SOLID_BLACK
shift_button_pos(Label_OSB7_NT,7,-1*OSB_label_spacing,0)
Add(Label_OSB7_NT)
use_mipfilter(Label_OSB7_NT)

Label_OSB7_NOSE						= Copy(Label_OSB7_NT)
Label_OSB7_NOSE.value				= "NOSE" .. ROTARY
Label_OSB7_NOSE.controllers			= {{"DSMS_profile_fuze_type", 1}}
Add(Label_OSB7_NOSE)
use_mipfilter(Label_OSB7_NOSE)

Label_OSB7_TAIL						= Copy(Label_OSB7_NT)
Label_OSB7_TAIL.value				= "TAIL" .. ROTARY
Label_OSB7_TAIL.controllers			= {{"DSMS_profile_fuze_type", 2}}
Add(Label_OSB7_TAIL)
use_mipfilter(Label_OSB7_TAIL)
--]]

--[[
Label_OSB7_NT_IAM					= CreateElement "ceStringPoly"
Label_OSB7_NT_IAM.name				= "Label_OSB7_NT_IAM"
Label_OSB7_NT_IAM.alignment		= "RightCenter"
Label_OSB7_NT_IAM.value			= "N/T "
Label_OSB7_NT_IAM.material			= font_MFCD
Label_OSB7_NT_IAM.stringdefs		= txt_labels_font
Label_OSB7_NT_IAM.controllers		= {{"DSMS_profile_fuze_type_IAM", 0}}
Label_OSB7_NT_IAM.UseBackground	= false
Label_OSB7_NT_IAM.BackgroundMaterial= MFCD_SOLID_BLACK
shift_button_pos(Label_OSB7_NT_IAM,7,-1*OSB_label_spacing,0)
Add(Label_OSB7_NT_IAM)
use_mipfilter(Label_OSB7_NT_IAM)
--]]

--Label_OSB7_SAFE						= Copy(Label_OSB7_NT)
--Label_OSB7_SAFE.value				= "SAFE"
--Label_OSB7_SAFE.controllers			= {{"DSMS_profile_fuze_type_safe"}}
--Add(Label_OSB7_SAFE)
--use_mipfilter(Label_OSB7_SAFE)

--addOSB_Box(7, {Label_OSB7_NT, Label_OSB7_NOSE, Label_OSB7_TAIL, Label_OSB7_SAFE})
--addOSB_Box(7, {Label_OSB7_NT, Label_OSB7_NOSE, Label_OSB7_TAIL})

addOSB_Box(7, {Label_OSB7})
add_osb_hint_controllers(7, _("Select fuze type"), {{"DSMS_profile_fuze_type_avail"}})

Label_8								= CreateElement "ceStringPoly"
Label_8.name						= "label_8"
Label_8.alignment					= "RightCenter"
Label_8.value						= DATA_ENTRY
Label_8.material					= font_MFCD
Label_8.stringdefs					= txt_labels_font
Label_8.controllers					= {{"DSMS_profile_qty_avail"}}
Label_8.UseBackground				= false
Label_8.BackgroundMaterial			= MFCD_SOLID_BLACK
shift_button_pos(Label_8,8,-1*OSB_label_spacing,0)
Add(Label_8)
use_mipfilter(Label_8)

Label_8_text						= CreateElement "ceStringPoly"
Label_8_text.name					= "label_8_text"
Label_8_text.alignment				= "RightCenter"
Label_8_text.formats				= {"RIP QTY\n%d"}
Label_8_text.material				= font_MFCD
Label_8_text.stringdefs				= txt_labels_font
Label_8_text.UseBackground			= false
Label_8_text.BackgroundMaterial		= MFCD_SOLID_BLACK
Label_8_text.parent_element			= Label_8.name
Label_8_text.init_pos				= {-2*OSB_label_spacing,0,0}
Label_8_text.controllers			= {{"DSMS_profile_qty_avail"}, {"DSMS_profile_qty", 0}}
Add(Label_8_text)
use_mipfilter(Label_8_text)

addOSB_Box(8, {Label_8, Label_8_text})
add_osb_hint_controllers(8, _("Select Release Quantity"), {{"DSMS_profile_qty_avail"}})

Label_9								= CreateElement "ceStringPoly"
Label_9.name						= "label_9"
Label_9.alignment					= "RightCenter"
Label_9.value						= DATA_ENTRY
Label_9.material					= font_MFCD
Label_9.stringdefs					= txt_labels_font
Label_9.controllers					= {{"DSMS_profile_feet_avail"}}
Label_9.UseBackground				= false
Label_9.BackgroundMaterial			= MFCD_SOLID_BLACK
shift_button_pos(Label_9,9,-1*OSB_label_spacing,0)
Add(Label_9)
use_mipfilter(Label_9)

Label_9_text						= CreateElement "ceStringPoly"
Label_9_text.name					= "label_9_text"
Label_9_text.alignment				= "RightCenter"
Label_9_text.formats				= {"FT\n%d"}
Label_9_text.material				= font_MFCD
Label_9_text.stringdefs				= txt_labels_font
Label_9_text.UseBackground			= false
Label_9_text.BackgroundMaterial		= MFCD_SOLID_BLACK
Label_9_text.parent_element			= Label_9.name
Label_9_text.init_pos				= {-2*OSB_label_spacing,0,0}
Label_9_text.controllers			=  {{"DSMS_profile_feet_avail"}, {"DSMS_profile_feet", 0}}
Add(Label_9_text)
use_mipfilter(Label_9_text)

addOSB_Box(9, {Label_9, Label_9_text})
add_osb_hint_controllers(9, _("Select Release Interval"), {{"DSMS_profile_feet_avail"}})

Label_OSB10							= CreateElement "ceStringPoly"
Label_OSB10.name					= "LABEL_OSB10"
Label_OSB10.alignment				= "RightCenter"
Label_OSB10.value					= ROTARY
Label_OSB10.material				= font_MFCD
Label_OSB10.stringdefs				= txt_labels_font
Label_OSB10.stringdefs				= predefined_fonts[1]
Label_OSB10.controllers				= {{"DSMS_label_not_wpns_off"}, {"DSMS_use_ccrp_ccip_only"}}
Label_OSB10.UseBackground			= false
Label_OSB10.BackgroundMaterial		= MFCD_SOLID_BLACK
shift_button_pos(Label_OSB10,10,-OSB_label_spacing,0)
Add(Label_OSB10)
use_mipfilter(Label_OSB10)

Label_OSB10_text					= CreateElement "ceStringPoly"
Label_OSB10_text.name				= "LABEL_OSB10_text"
Label_OSB10_text.alignment			= "RightCenter"
Label_OSB10_text.value				= "MODE\nCCIP"
Label_OSB10_text.material			= font_MFCD
Label_OSB10_text.stringdefs			= txt_labels_font
Label_OSB10_text.UseBackground		= false
Label_OSB10_text.BackgroundMaterial	= MFCD_SOLID_BLACK
--Label_OSB10_text.parent_element     = Label_OSB10.name 
Label_OSB10_text.init_pos           = {-3*OSB_label_spacing,0,0}
Label_OSB10_text.controllers		= {{"DSMS_label_not_wpns_off"}, {"DSMS_profile_mode_ccip_rp",0}}
shift_button_pos(Label_OSB10_text,10,-OSB_label_spacing*3,0)
Add(Label_OSB10_text)
use_mipfilter(Label_OSB10_text)

Label_OSB10_text_2					= Copy(Label_OSB10_text)
Label_OSB10_text_2.value			= "MODE\nCCRP"
Label_OSB10_text_2.controllers		= {{"DSMS_label_not_wpns_off"}, {"DSMS_profile_mode_ccip_rp", 1}}
shift_button_pos(Label_OSB10_text_2,10,-OSB_label_spacing*3,0)
Add(Label_OSB10_text_2)

addOSB_Box(10, {Label_OSB10, Label_OSB10_text, Label_OSB10_text_2})
add_osb_hint_controllers(10, _("Select HUD Mode"), {{"DSMS_label_not_wpns_off"}})

Label_OSB16							= CreateElement "ceStringPoly"
Label_OSB16.name					= "Label_OSB16"
Label_OSB16.alignment				= "LeftCenter"
Label_OSB16.value					= BRANCH_L
Label_OSB16.material				= font_MFCD
Label_OSB16.stringdefs				= txt_labels_font
Label_OSB16.UseBackground			= false
Label_OSB16.BackgroundMaterial		= MFCD_SOLID_BLACK
Label_OSB16.controllers       		= {{"DSMS_label_not_wpns_off"}}
shift_button_pos(Label_OSB16,16,0,0)
Add(Label_OSB16)
use_mipfilter(Label_OSB16)

Label_OSB16_text					= CreateElement "ceStringPoly"
Label_OSB16_text.name				= "LABEL_OSB16_TEXT"
Label_OSB16_text.alignment			= "LeftCenter"
Label_OSB16_text.value				= "CHG\nSET"
Label_OSB16_text.material			= font_MFCD
Label_OSB16_text.stringdefs			= txt_labels_font
Label_OSB16_text.UseBackground		= false
Label_OSB16_text.BackgroundMaterial	= MFCD_SOLID_BLACK
Label_OSB16_text.parent_element     = Label_OSB16.name 
Label_OSB16_text.init_pos           = {2*OSB_label_spacing,0,0}
Label_OSB16_text.controllers        = {{"DSMS_label_not_wpns_off"}}
Add(Label_OSB16_text)
use_mipfilter(Label_OSB16_text)

addOSB_Box(16, {Label_OSB16, Label_OSB16_text})
add_osb_hint_controllers(16, _("Go to Profile Settings page"), {{"DSMS_label_not_wpns_off"}})

addOSB_Box(17)

Label_OSB18_symb						= CreateElement "ceStringPoly"
Label_OSB18_symb.name					= "Label_OSB18_symb"
Label_OSB18_symb.alignment				= "LeftCenter"
Label_OSB18_symb.value					= DATA_ENTRY
Label_OSB18_symb.material				= font_MFCD
Label_OSB18_symb.stringdefs				= txt_labels_font
Label_OSB18_symb.UseBackground			= false
--Label_OSB18_symb.controllers			= {{"DSMS_can_add_profile"}}
shift_button_pos(Label_OSB18_symb,18,0,0)
Add(Label_OSB18_symb)
use_mipfilter(Label_OSB18_symb)

Label_OSB18							= CreateElement "ceStringPoly"
Label_OSB18.name					= "Label_OSB18"
Label_OSB18.alignment				= "LeftCenter"
Label_OSB18.formats					= {"%s"}
Label_OSB18.material				= font_MFCD
Label_OSB18.stringdefs				= txt_labels_font
Label_OSB18.UseBackground			= true
Label_OSB18.BackgroundMaterial		= MFCD_SOLID_RED
--Label_OSB18.controllers				= {{"DSMS_can_add_profile"}, {"DSMS_new_profile_name", 0}}
Label_OSB18.controllers				= {{"DSMS_new_profile_name", 0}}
shift_button_pos(Label_OSB18,18,10,0)
Add(Label_OSB18)
use_mipfilter(Label_OSB18)

addOSB_Box(18, {Label_OSB18_symb, Label_OSB18})
add_osb_hint_controllers(18, _("Enter new profile name"), {{"DSMS_can_add_profile"}})

Scrollers = addScrollers(20, 19, 5,
	{{"DSMS_not_manual_profile"}},
	{{"DSMS_not_manual_profile"}})
add_osb_static_hint(19, _("Select next profile"))
add_osb_static_hint(20, _("Select previous profile"))

addOSB_Box(20, {Scrollers[3]})
addOSB_Box(19, {Scrollers[4]})

Profile_name						= CreateElement "ceStringPoly"
Profile_name.name					= "PROFILE_NAME"
Profile_name.alignment				= "LeftCenter"
Profile_name.material				= font_MFCD
Profile_name.stringdefs				= txt_labels_font
Profile_name.init_pos				= {OSB_positions[19][1]-15,(OSB_positions[19][2]+OSB_positions[20][2])/2,0}
Profile_name.UseBackground			= true
Profile_name.BackgroundMaterial		= MFCD_SOLID_BLACK
Profile_name.formats				= {"%s"}
Profile_name.controllers			= {{"DSMS_profile_name_nav_in_view", materials[MFCD_SOLID_BLACK][1], materials[MFCD_SOLID_BLACK][2], materials[MFCD_SOLID_BLACK][3]}}
SetLowerLeftCornerOrigin(Profile_name)
Add(Profile_name)
use_mipfilter(Profile_name) 

profile_control							= CreateElement "ceStringPoly"
profile_control.name					= "PROFILE_CONTROL"
profile_control.material				= font_MFCD
profile_control.alignment				= "CenterCenter"
profile_control.init_pos				= {160+267/2,max_pixels_count-127,0}
SetLowerLeftCornerOrigin(profile_control)
profile_control.stringdefs				= predefined_fonts[1]
profile_control.UseBackground			= false
profile_control.BackgroundMaterial		= MFCD_SOLID_BLACK
profile_control.value					= "PROFILE CONTROL"
Add(profile_control)
use_mipfilter(profile_control) 

