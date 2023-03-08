dofile(LockOn_Options.script_path.."MFCD/indicator/MFCD_useful_definitions.lua")
dofile(LockOn_Options.script_path.."materials.lua")
dofile(LockOn_Options.script_path.."MFCD/indicator/DSMS/MFCD_DSMS_useful_definitions.lua")

AddStatLabel()

AddRetLabel()
add_osb_static_hint(2, _("Return to Profile Control page"))

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

Label_OSB6							= CreateElement "ceStringPoly"
Label_OSB6.name						= "LABEL_OSB6"
Label_OSB6.alignment				= "CenterCenter"
Label_OSB6.value					= ROTARY
Label_OSB6.material					= font_MFCD
Label_OSB6.stringdefs				= txt_labels_font
Label_OSB6.stringdefs				= predefined_fonts[1]
Label_OSB6.controllers				= {{"DSMS_profile_settings_auto_ls"}}
Label_OSB6.UseBackground			= false
Label_OSB6.BackgroundMaterial		= MFCD_SOLID_BLACK
shift_button_pos(Label_OSB6,6)
Add(Label_OSB6)
use_mipfilter(Label_OSB6)

Label_OSB6_text						= CreateElement "ceStringPoly"
Label_OSB6_text.name				= "LABEL_OSB6_TEXT"
Label_OSB6_text.alignment			= "RightCenter"
Label_OSB6_text.formats				= {"AUTO LS\n%s"}
Label_OSB6_text.material			= font_MFCD
Label_OSB6_text.stringdefs			= predefined_fonts[1]
Label_OSB6_text.UseBackground		= false
Label_OSB6_text.BackgroundMaterial	= MFCD_SOLID_BLACK
Label_OSB6_text.parent_element		= Label_OSB6.name 
Label_OSB6_text.init_pos			= {-2*OSB_label_spacing,0,0}
Label_OSB6_text.controllers			= {{"DSMS_profile_settings_auto_ls"}, {"DSMS_profile_settings_auto_ls_data"}}
Add(Label_OSB6_text)
use_mipfilter(Label_OSB6_text)

addOSB_Box(6, {Label_OSB6, Label_OSB6_text})
add_osb_hint_controllers(6, _("Laser auto-fire window in seconds"), {{"DSMS_profile_settings_auto_ls"}})

--[[Label_OSB6_Symb						= CreateElement "ceStringPoly"
Label_OSB6_Symb.name				= "LABEL_OSB6_SYMB"
Label_OSB6_Symb.alignment			= "RightCenter"
Label_OSB6_Symb.value				= DATA_ENTRY
Label_OSB6_Symb.material			= font_MFCD
Label_OSB6_Symb.stringdefs			= txt_labels_font
Label_OSB6_Symb.UseBackground		= false
Label_OSB6_Symb.BackgroundMaterial	= MFCD_SOLID_BLACK
Label_OSB6_Symb.controllers			= {{"DSMS_profile_is_IAM"}}
shift_button_pos(Label_OSB6_Symb,6,-1*OSB_label_spacing,0)
Add(Label_OSB6_Symb)
use_mipfilter(Label_OSB6_Symb)

Label_OSB6_text1					= CreateElement "ceStringPoly"
Label_OSB6_text1.name				= "Label_OSB6"
Label_OSB6_text1.alignment			= "RightCenter"
Label_OSB6_text1.formats			= {"PATT AZ\n%d"}
Label_OSB6_text1.material			= font_MFCD
Label_OSB6_text1.stringdefs			= txt_labels_font
Label_OSB6_text1.UseBackground		= false
Label_OSB6_text1.BackgroundMaterial	= MFCD_SOLID_BLACK
Label_OSB6_text1.controllers		= {{"DSMS_profile_is_IAM", 0}, {"DSMS_profile_patt_az"}}
shift_button_pos(Label_OSB6_text1,6,-1*OSB_label_spacing-10,0)
Add(Label_OSB6_text1)
use_mipfilter(Label_OSB6_text1)

addOSB_Box(6, {Label_OSB6, Label_OSB6_text, Label_OSB6_Symb})]]
--add_osb_hint_controllers(6, _("Pattern azimuth, no function"), {{"DSMS_profile_is_IAM"}}) 


Label_OSB7							= CreateElement "ceStringPoly"
Label_OSB7.name						= "Label_OSB7"
Label_OSB7.alignment				= "CenterCenter"
Label_OSB7.value					= DATA_ENTRY
Label_OSB7.material					= font_MFCD
Label_OSB7.stringdefs				= predefined_fonts[1]
Label_OSB7.UseBackground			= false
Label_OSB7.BackgroundMaterial		= MFCD_SOLID_BLACK
Label_OSB7.controllers       		= {{"DSMS_profile_settings_rt"}}
shift_button_pos(Label_OSB7,7,-1*OSB_label_spacing,0)
Add(Label_OSB7)
use_mipfilter(Label_OSB7)

Label_OSB7_text						= CreateElement "ceStringPoly"
Label_OSB7_text.name				= "Label_OSB7_text"
Label_OSB7_text.alignment			= "RightCenter"
Label_OSB7_text.formats				= {"RT\n%d"}
Label_OSB7_text.material			= font_MFCD
Label_OSB7_text.stringdefs			= predefined_fonts[1]
Label_OSB7_text.UseBackground		= false
Label_OSB7_text.BackgroundMaterial	= MFCD_SOLID_BLACK
Label_OSB7_text.parent_element		= Label_OSB7.name 
Label_OSB7_text.init_pos			= {-2*OSB_label_spacing,0,0}
Label_OSB7_text.controllers			= {{"DSMS_profile_settings_rt"}, {"DSMS_profile_settings_rt_data"}}
Add(Label_OSB7_text)
use_mipfilter(Label_OSB7_text)

addOSB_Box(7, {Label_OSB7, Label_OSB7_text})
add_osb_hint_controllers(7, _("Horizontal offset in mils"), {{"DSMS_profile_settings_rt"}})

--[[Label_OSB7_Symb						= CreateElement "ceStringPoly"
Label_OSB7_Symb.name				= "LABEL_OSB7_SYMB"
Label_OSB7_Symb.alignment			= "RightCenter"
Label_OSB7_Symb.value				= DATA_ENTRY
Label_OSB7_Symb.material			= font_MFCD
Label_OSB7_Symb.stringdefs			= txt_labels_font
Label_OSB7_Symb.UseBackground		= false
Label_OSB7_Symb.BackgroundMaterial	= MFCD_SOLID_BLACK
Label_OSB7_Symb.controllers			= {{"DSMS_profile_is_IAM"}}
shift_button_pos(Label_OSB7_Symb,7,-1*OSB_label_spacing,0)
Add(Label_OSB7_Symb)
use_mipfilter(Label_OSB7_Symb)

Label_OSB7_text1					= CreateElement "ceStringPoly"
Label_OSB7_text1.name				= "Label_OSB7_text1"
Label_OSB7_text1.alignment			= "RightCenter"
Label_OSB7_text1.formats			= {"IMP AZ\n%d"}
Label_OSB7_text1.material			= font_MFCD
Label_OSB7_text1.stringdefs			= txt_labels_font
Label_OSB7_text1.UseBackground		= false
Label_OSB7_text1.BackgroundMaterial	= MFCD_SOLID_BLACK
Label_OSB7_text1.controllers		= {{"DSMS_profile_is_IAM", 0}, {"DSMS_profile_imp_az"}}
shift_button_pos(Label_OSB7_text1,7,-1*OSB_label_spacing-10,0)
Add(Label_OSB7_text1)
use_mipfilter(Label_OSB7_text1)

addOSB_Box(7, {Label_OSB7, Label_OSB7_text, Label_OSB7_Symb, Label_OSB7_text1})
add_osb_hint_controllers(7, _("Impact azimuth, no function"), {{"DSMS_profile_is_IAM"}}) ]]


Label_OSB8							= CreateElement "ceStringPoly"
Label_OSB8.name						= "Label_OSB8"
Label_OSB8.alignment				= "CenterCenter"
Label_OSB8.value					= DATA_ENTRY
Label_OSB8.material					= font_MFCD
Label_OSB8.stringdefs				= predefined_fonts[1]
Label_OSB8.UseBackground			= false
Label_OSB8.BackgroundMaterial		= MFCD_SOLID_BLACK
Label_OSB8.controllers       		= {{"DSMS_profile_settings_up"}}
shift_button_pos(Label_OSB8,8,-1*OSB_label_spacing,0)
Add(Label_OSB8)
use_mipfilter(Label_OSB8)

Label_OSB8_text						= CreateElement "ceStringPoly"
Label_OSB8_text.name				= "Label_OSB8_text"
Label_OSB8_text.alignment			= "RightCenter"
Label_OSB8_text.formats				= {"UP\n%d"}
Label_OSB8_text.material			= font_MFCD
Label_OSB8_text.stringdefs			= predefined_fonts[1]
Label_OSB8_text.UseBackground		= false
Label_OSB8_text.BackgroundMaterial	= MFCD_SOLID_BLACK
Label_OSB8_text.parent_element		= Label_OSB8.name 
Label_OSB8_text.init_pos			= {-2*OSB_label_spacing,0,0}
Label_OSB8_text.controllers			= {{"DSMS_profile_settings_up"}, {"DSMS_profile_settings_up_data"}}
Add(Label_OSB8_text)
use_mipfilter(Label_OSB8_text)

addOSB_Box(8, {Label_OSB8, Label_OSB8_text})
add_osb_hint_controllers(8, _("Vertical offset in mils"), {{"DSMS_profile_settings_up"}})

--[[Label_OSB8_Symb						= CreateElement "ceStringPoly"
Label_OSB8_Symb.name				= "LABEL_OSB8_SYMB"
Label_OSB8_Symb.alignment			= "RightCenter"
Label_OSB8_Symb.value				= DATA_ENTRY
Label_OSB8_Symb.material			= font_MFCD
Label_OSB8_Symb.stringdefs			= txt_labels_font
Label_OSB8_Symb.UseBackground		= false
Label_OSB8_Symb.BackgroundMaterial	= MFCD_SOLID_BLACK
Label_OSB8_Symb.controllers			= {{"DSMS_profile_is_IAM"}}
shift_button_pos(Label_OSB8_Symb,8,-1*OSB_label_spacing,0)
Add(Label_OSB8_Symb)
use_mipfilter(Label_OSB8_Symb)

Label_OSB8_text1					= CreateElement "ceStringPoly"
Label_OSB8_text1.name				= "Label_OSB8_text1"
Label_OSB8_text1.alignment			= "RightCenter"
Label_OSB8_text1.formats			= {"IMP ANG\n%d"}
Label_OSB8_text1.material			= font_MFCD
Label_OSB8_text1.stringdefs			= txt_labels_font
Label_OSB8_text1.UseBackground		= false
Label_OSB8_text1.BackgroundMaterial	= MFCD_SOLID_BLACK
Label_OSB8_text1.controllers		= {{"DSMS_profile_is_IAM", 0}, {"DSMS_profile_imp_ang"}}
shift_button_pos(Label_OSB8_text1,8,-1*OSB_label_spacing-10,0)
Add(Label_OSB8_text1)
use_mipfilter(Label_OSB8_text1)

addOSB_Box(8, {Label_OSB8, Label_OSB8_text, Label_OSB8_Symb, Label_OSB8_text1})
add_osb_hint_controllers(8, _("Impact angle, no function"), {{"DSMS_profile_is_IAM"}})
]]


Label_OSB9							= CreateElement "ceStringPoly"
Label_OSB9.name						= "Label_OSB9"
Label_OSB9.alignment				= "CenterCenter"
Label_OSB9.value					= DATA_ENTRY
Label_OSB9.material					= font_MFCD
Label_OSB9.stringdefs				= predefined_fonts[1]
Label_OSB9.UseBackground			= false
Label_OSB9.BackgroundMaterial		= MFCD_SOLID_BLACK
Label_OSB9.controllers       		= {{"DSMS_profile_settings_eject"}}
shift_button_pos(Label_OSB9,9,-1*OSB_label_spacing,0)
Add(Label_OSB9)
use_mipfilter(Label_OSB9)

Label_OSB9_text						= CreateElement "ceStringPoly"
Label_OSB9_text.name				= "Label_OSB9_text"
Label_OSB9_text.alignment			= "RightCenter"
Label_OSB9_text.formats				= {"EJECT\n%d"}
Label_OSB9_text.material			= font_MFCD
Label_OSB9_text.stringdefs			= predefined_fonts[1]
Label_OSB9_text.UseBackground		= false
Label_OSB9_text.BackgroundMaterial	= MFCD_SOLID_BLACK
Label_OSB9_text.parent_element		= Label_OSB9.name 
Label_OSB9_text.init_pos			= {-2*OSB_label_spacing,0,0}
Label_OSB9_text.controllers			= {{"DSMS_profile_settings_eject"}, {"DSMS_profile_settings_eject_data"}}
Add(Label_OSB9_text)
use_mipfilter(Label_OSB9_text)

addOSB_Box(9, {Label_OSB9, Label_OSB9_text})
add_osb_hint_controllers(9, _("Ejection velocity in ft/sec"), {{"DSMS_profile_settings_eject"}})

Label_OSB10							= CreateElement "ceStringPoly"
Label_OSB10.name					= "Label_OSB10"
Label_OSB10.alignment				= "CenterCenter"
Label_OSB10.value					= DATA_ENTRY
Label_OSB10.material				= font_MFCD
Label_OSB10.stringdefs				= predefined_fonts[1]
Label_OSB10.UseBackground			= false
Label_OSB10.BackgroundMaterial		= MFCD_SOLID_BLACK
Label_OSB10.controllers       		= {{"DSMS_profile_settings_rack_del"}}
shift_button_pos(Label_OSB10,10,-1*OSB_label_spacing,0)
Add(Label_OSB10)
use_mipfilter(Label_OSB10)

Label_OSB10_text					= CreateElement "ceStringPoly"
Label_OSB10_text.name				= "Label_OSB10_text"
Label_OSB10_text.alignment			= "RightCenter"
Label_OSB10_text.formats			= {"RACK\n%.2f"}
Label_OSB10_text.material			= font_MFCD
Label_OSB10_text.stringdefs			= predefined_fonts[1]
Label_OSB10_text.UseBackground		= false
Label_OSB10_text.BackgroundMaterial	= MFCD_SOLID_BLACK
Label_OSB10_text.parent_element		= Label_OSB10.name 
Label_OSB10_text.init_pos			= {-2*OSB_label_spacing,0,0}
Label_OSB10_text.controllers		= {{"DSMS_profile_settings_rack_del"}, {"DSMS_profile_settings_rack_del_data"}}
Add(Label_OSB10_text)
use_mipfilter(Label_OSB10_text)

addOSB_Box(10, {Label_OSB10, Label_OSB10_text})
add_osb_hint_controllers(10, _("Rack delay in seconds"), {{"DSMS_profile_settings_rack_del"}})

Label_OSB16							= CreateElement "ceStringPoly"
Label_OSB16.name					= "Label_OSB16"
Label_OSB16.alignment				= "CenterCenter"
Label_OSB16.value					= DATA_ENTRY
Label_OSB16.material				= font_MFCD
Label_OSB16.stringdefs				= predefined_fonts[1]
Label_OSB16.UseBackground			= false
Label_OSB16.BackgroundMaterial		= MFCD_SOLID_BLACK
Label_OSB16.controllers       		= {{"DSMS_profile_settings_hot"}}
shift_button_pos(Label_OSB16,16,-OSB_label_spacing,0)
Add(Label_OSB16)
use_mipfilter(Label_OSB16)

Label_OSB16_text					= CreateElement "ceStringPoly"
Label_OSB16_text.name				= "LABEL_OSB16_TEXT"
Label_OSB16_text.alignment			= "LeftCenter"
Label_OSB16_text.formats			= {"HOT\n%d"}
Label_OSB16_text.material			= font_MFCD
Label_OSB16_text.stringdefs			= predefined_fonts[1]
Label_OSB16_text.UseBackground		= false
Label_OSB16_text.BackgroundMaterial	= MFCD_SOLID_BLACK
Label_OSB16_text.parent_element     = Label_OSB16.name 
Label_OSB16_text.init_pos           = {OSB_label_spacing,0,0}
Label_OSB16_text.controllers        = {{"DSMS_profile_settings_hot"}, {"DSMS_profile_settings_hot_data"}}
Add(Label_OSB16_text)
use_mipfilter(Label_OSB16_text)

Label_OSB16_1						= CreateElement "ceStringPoly"
Label_OSB16_1.name					= "LABEL_OSB16_1"
Label_OSB16_1.alignment				= "CenterCenter"
Label_OSB16_1.value					= ROTARY
Label_OSB16_1.material				= font_MFCD
Label_OSB16_1.stringdefs			= txt_labels_font
Label_OSB16_1.stringdefs			= predefined_fonts[1]
Label_OSB16_1.controllers			= {{"DSMS_profile_settings_soln"}}
Label_OSB16_1.UseBackground			= false
Label_OSB16_1.BackgroundMaterial	= MFCD_SOLID_BLACK
shift_button_pos(Label_OSB16_1,16,-OSB_label_spacing,0)
Add(Label_OSB16_1)
use_mipfilter(Label_OSB16_1)

Label_OSB16_1_text					= CreateElement "ceStringPoly"
Label_OSB16_1_text.name				= "LABEL_OSB16_1_TEXT"
Label_OSB16_1_text.alignment		= "LeftCenter"
Label_OSB16_1_text.formats			= {"SOLN\n%s"}
Label_OSB16_1_text.material			= font_MFCD
Label_OSB16_1_text.stringdefs		= predefined_fonts[1]
Label_OSB16_1_text.UseBackground	= false
Label_OSB16_1_text.BackgroundMaterial= MFCD_SOLID_BLACK
Label_OSB16_1_text.parent_element	= Label_OSB16_1.name 
Label_OSB16_1_text.init_pos			= {OSB_label_spacing,0,0}
Label_OSB16_1_text.controllers		= {{"DSMS_profile_settings_soln"}, {"DSMS_profile_settings_soln_data"}}
Add(Label_OSB16_1_text)
use_mipfilter(Label_OSB16_1_text)

Label_OSB16_2						= CreateElement "ceStringPoly"
Label_OSB16_2.name					= "Label_OSB16_2"
Label_OSB16_2.alignment				= "CenterCenter"
Label_OSB16_2.value					= DATA_ENTRY
Label_OSB16_2.material				= font_MFCD
Label_OSB16_2.stringdefs			= predefined_fonts[1]
Label_OSB16_2.UseBackground			= false
Label_OSB16_2.BackgroundMaterial	= MFCD_SOLID_BLACK
Label_OSB16_2.controllers       	= {{"DSMS_profile_settings_ld_tof"}}
shift_button_pos(Label_OSB16_2,16,-OSB_label_spacing,0)
Add(Label_OSB16_2)
use_mipfilter(Label_OSB16_2)

Label_OSB16_2_text					= CreateElement "ceStringPoly"
Label_OSB16_2_text.name				= "LABEL_OSB16_2_TEXT"
Label_OSB16_2_text.alignment		= "LeftCenter"
Label_OSB16_2_text.formats			= {"LD TOF\n%.1f"}
Label_OSB16_2_text.material			= font_MFCD
Label_OSB16_2_text.stringdefs		= predefined_fonts[1]
Label_OSB16_2_text.UseBackground	= false
Label_OSB16_2_text.BackgroundMaterial= MFCD_SOLID_BLACK
Label_OSB16_2_text.parent_element	= Label_OSB16_2.name 
Label_OSB16_2_text.init_pos			= {OSB_label_spacing,0,0}
Label_OSB16_2_text.controllers		= {{"DSMS_profile_settings_ld_tof"}, {"DSMS_profile_settings_ld_tof_data"}}
Add(Label_OSB16_2_text)
use_mipfilter(Label_OSB16_2_text)

addOSB_Box(16, {Label_OSB16, Label_OSB16_text, 
				Label_OSB16_1, Label_OSB16_1_text,
				Label_OSB16_2, Label_OSB16_2_text})
add_osb_hint_format_controllers(16, 
								{_("Desired height over target at mid-burn"), _("LGB solution"), _("Low Drag Time of Fall in seconds")}, 
								{{"DSMS_profile_settings_osb_16_hint"}})

Label_OSB17							= CreateElement "ceStringPoly"
Label_OSB17.name					= "Label_OSB17"
Label_OSB17.alignment				= "CenterCenter"
Label_OSB17.value					= DATA_ENTRY
Label_OSB17.material				= font_MFCD
Label_OSB17.stringdefs				= predefined_fonts[1]
Label_OSB17.UseBackground			= false
Label_OSB17.BackgroundMaterial		= MFCD_SOLID_BLACK
Label_OSB17.controllers       		= {{"DSMS_profile_settings_min_tof"}}
shift_button_pos(Label_OSB17,17,-OSB_label_spacing,0)
Add(Label_OSB17)
use_mipfilter(Label_OSB17)

Label_OSB17_text					= CreateElement "ceStringPoly"
Label_OSB17_text.name				= "LABEL_OSB17_TEXT"
Label_OSB17_text.alignment			= "LeftCenter"
Label_OSB17_text.formats			= {"MIN TOF\n%.1f"}
Label_OSB17_text.material			= font_MFCD
Label_OSB17_text.stringdefs			= predefined_fonts[1]
Label_OSB17_text.UseBackground		= false
Label_OSB17_text.BackgroundMaterial	= MFCD_SOLID_BLACK
Label_OSB17_text.parent_element     = Label_OSB17.name 
Label_OSB17_text.init_pos           = {OSB_label_spacing,0,0}
Label_OSB17_text.controllers        = {{"DSMS_profile_settings_min_tof"}, {"DSMS_profile_settings_min_tof_data"}}
Add(Label_OSB17_text)
use_mipfilter(Label_OSB17_text)

Label_OSB17_1						= CreateElement "ceStringPoly"
Label_OSB17_1.name					= "Label_OSB17_1"
Label_OSB17_1.alignment				= "CenterCenter"
Label_OSB17_1.value					= DATA_ENTRY
Label_OSB17_1.material				= font_MFCD
Label_OSB17_1.stringdefs			= predefined_fonts[1]
Label_OSB17_1.UseBackground			= false
Label_OSB17_1.BackgroundMaterial	= MFCD_SOLID_BLACK
Label_OSB17_1.controllers       	= {{"DSMS_profile_settings_ls_time"}}
shift_button_pos(Label_OSB17_1,17,-OSB_label_spacing,0)
Add(Label_OSB17_1)
use_mipfilter(Label_OSB17_1)

Label_OSB17_1_text					= CreateElement "ceStringPoly"
Label_OSB17_1_text.name				= "LABEL_OSB17_1_TEXT"
Label_OSB17_1_text.alignment		= "LeftCenter"
Label_OSB17_1_text.formats			= {"LS TIME\n%d"}
Label_OSB17_1_text.material			= font_MFCD
Label_OSB17_1_text.stringdefs		= predefined_fonts[1]
Label_OSB17_1_text.UseBackground	= false
Label_OSB17_1_text.BackgroundMaterial= MFCD_SOLID_BLACK
Label_OSB17_1_text.parent_element	= Label_OSB17_1.name 
Label_OSB17_1_text.init_pos			= {OSB_label_spacing,0,0}
Label_OSB17_1_text.controllers		= {{"DSMS_profile_settings_ls_time"}, {"DSMS_profile_settings_ls_time_data"}}
Add(Label_OSB17_1_text)
use_mipfilter(Label_OSB17_1_text)

Label_OSB17_2						= CreateElement "ceStringPoly"
Label_OSB17_2.name					= "Label_OSB17_2"
Label_OSB17_2.alignment				= "CenterCenter"
Label_OSB17_2.value					= DATA_ENTRY
Label_OSB17_2.material				= font_MFCD
Label_OSB17_2.stringdefs			= predefined_fonts[1]
Label_OSB17_2.UseBackground			= false
Label_OSB17_2.BackgroundMaterial	= MFCD_SOLID_BLACK
Label_OSB17_2.controllers       	= {{"DSMS_profile_settings_hd_tof"}}
shift_button_pos(Label_OSB17_2,17,-OSB_label_spacing,0)
Add(Label_OSB17_2)
use_mipfilter(Label_OSB17_2)

Label_OSB17_2_text					= CreateElement "ceStringPoly"
Label_OSB17_2_text.name				= "LABEL_OSB17_2_TEXT"
Label_OSB17_2_text.alignment		= "LeftCenter"
Label_OSB17_2_text.formats			= {"HD TOF\n%.1f"}
Label_OSB17_2_text.material			= font_MFCD
Label_OSB17_2_text.stringdefs		= predefined_fonts[1]
Label_OSB17_2_text.UseBackground	= false
Label_OSB17_2_text.BackgroundMaterial= MFCD_SOLID_BLACK
Label_OSB17_2_text.parent_element	= Label_OSB17_2.name 
Label_OSB17_2_text.init_pos			= {OSB_label_spacing,0,0}
Label_OSB17_2_text.controllers		= {{"DSMS_profile_settings_hd_tof"}, {"DSMS_profile_settings_hd_tof_data"}}
Add(Label_OSB17_2_text)
use_mipfilter(Label_OSB17_2_text)

Label_OSB17_3						= CreateElement "ceStringPoly"
Label_OSB17_3.name					= "Label_OSB17_3"
Label_OSB17_3.alignment				= "CenterCenter"
Label_OSB17_3.value					= DATA_ENTRY
Label_OSB17_3.material				= font_MFCD
Label_OSB17_3.stringdefs			= predefined_fonts[1]
Label_OSB17_3.UseBackground			= false
Label_OSB17_3.BackgroundMaterial	= MFCD_SOLID_BLACK
Label_OSB17_3.controllers       	= {{"DSMS_profile_settings_drag"}}
shift_button_pos(Label_OSB17_3,17,-OSB_label_spacing,0)
Add(Label_OSB17_3)
use_mipfilter(Label_OSB17_3)

Label_OSB17_3_text					= CreateElement "ceStringPoly"
Label_OSB17_3_text.name				= "LABEL_OSB17_3_TEXT"
Label_OSB17_3_text.alignment		= "LeftCenter"
Label_OSB17_3_text.formats			= {"DRAG\n%.1f"}
Label_OSB17_3_text.material			= font_MFCD
Label_OSB17_3_text.stringdefs		= predefined_fonts[1]
Label_OSB17_3_text.UseBackground	= false
Label_OSB17_3_text.BackgroundMaterial= MFCD_SOLID_BLACK
Label_OSB17_3_text.parent_element	= Label_OSB17_3.name 
Label_OSB17_3_text.init_pos			= {OSB_label_spacing,0,0}
Label_OSB17_3_text.controllers		= {{"DSMS_profile_settings_drag"}, {"DSMS_profile_settings_drag_data"}}
Add(Label_OSB17_3_text)
use_mipfilter(Label_OSB17_3_text)

addOSB_Box(17, {Label_OSB17, Label_OSB17_text, 
				Label_OSB17_1, Label_OSB17_1_text,
				Label_OSB17_2, Label_OSB17_2_text,
				Label_OSB17_3, Label_OSB17_3_text})
add_osb_hint_format_controllers(17, 
								{_("Minimum time of flight in seconds"), _("Laser on time seconds remaining"), _("High Drag Time of Fall Time in seconds"), _("Drag (No function)")}, 
								{{"DSMS_profile_settings_osb_17_hint"}})

Label_OSB18							= CreateElement "ceStringPoly"
Label_OSB18.name					= "Label_OSB18"
Label_OSB18.alignment				= "CenterCenter"
Label_OSB18.value					= DATA_ENTRY
Label_OSB18.material				= font_MFCD
Label_OSB18.stringdefs				= predefined_fonts[1]
Label_OSB18.UseBackground			= false
Label_OSB18.BackgroundMaterial		= MFCD_SOLID_BLACK
Label_OSB18.controllers       		= {{"DSMS_profile_settings_min_alt"}}
shift_button_pos(Label_OSB18,18,-OSB_label_spacing,0)
Add(Label_OSB18)
use_mipfilter(Label_OSB18)

Label_OSB18_text					= CreateElement "ceStringPoly"
Label_OSB18_text.name				= "LABEL_OSB18_TEXT"
Label_OSB18_text.alignment			= "LeftCenter"
Label_OSB18_text.formats			= {"MIN ALT\n%d"}
Label_OSB18_text.material			= font_MFCD
Label_OSB18_text.stringdefs			= predefined_fonts[1]
Label_OSB18_text.UseBackground		= false
Label_OSB18_text.BackgroundMaterial	= MFCD_SOLID_BLACK
Label_OSB18_text.parent_element     = Label_OSB18.name 
Label_OSB18_text.init_pos           = {OSB_label_spacing,0,0}
Label_OSB18_text.controllers        = {{"DSMS_profile_settings_min_alt"}, {"DSMS_profile_settings_min_alt_data"}}
Add(Label_OSB18_text)
use_mipfilter(Label_OSB18_text)

addOSB_Box(18, {Label_OSB18, Label_OSB18_text})
add_osb_hint_controllers(18, _("Minimum altitude"), {{"DSMS_profile_settings_min_alt"}})

Label_OSB19							= CreateElement "ceStringPoly"
Label_OSB19.name					= "Label_OSB19"
Label_OSB19.alignment				= "CenterCenter"
Label_OSB19.value					= DATA_ENTRY
Label_OSB19.material				= font_MFCD
Label_OSB19.stringdefs				= predefined_fonts[1]
Label_OSB19.UseBackground			= false
Label_OSB19.BackgroundMaterial		= MFCD_SOLID_BLACK
Label_OSB19.controllers       		= {{"DSMS_profile_settings_des_tof"}}
shift_button_pos(Label_OSB19,19,-OSB_label_spacing,0)
Add(Label_OSB19)
use_mipfilter(Label_OSB19)

Label_OSB19_text					= CreateElement "ceStringPoly"
Label_OSB19_text.name				= "LABEL_OSB19_TEXT"
Label_OSB19_text.alignment			= "LeftCenter"
Label_OSB19_text.formats			= {"DES TOF\n%.1f"}
Label_OSB19_text.material			= font_MFCD
Label_OSB19_text.stringdefs			= predefined_fonts[1]
Label_OSB19_text.UseBackground		= false
Label_OSB19_text.BackgroundMaterial	= MFCD_SOLID_BLACK
Label_OSB19_text.parent_element     = Label_OSB19.name 
Label_OSB19_text.init_pos           = {OSB_label_spacing,0,0}
Label_OSB19_text.controllers        = {{"DSMS_profile_settings_des_tof"}, {"DSMS_profile_settings_des_tof_data"}}
Add(Label_OSB19_text)
use_mipfilter(Label_OSB19_text)


--[[Label_OSB19_1_txt					 = CreateElement "ceStringPoly"
Label_OSB19_1_txt.name				 = "LABEL_OSB19_1_TXT"
Label_OSB19_1_txt.alignment			 = "LeftBottom"
Label_OSB19_1_txt.formats			 = {"SPI", "%s"}
Label_OSB19_1_txt.material			 = font_MFCD
Label_OSB19_1_txt.stringdefs		 = predefined_fonts[1]
Label_OSB19_1_txt.UseBackground		 = false
Label_OSB19_1_txt.BackgroundMaterial = MFCD_SOLID_BLACK
Label_OSB19_1_txt.controllers		 = {{"DSMS_profile_is_IAM"}, {"DSMS_profile_IAM_target_name"}}
shift_button_pos(Label_OSB19_1_txt,19,-OSB_label_spacing*2,12)
Add(Label_OSB19_1_txt)
use_mipfilter(Label_OSB19_1_txt)

Label_OSB19_1_text					= CreateElement "ceStringPoly"
Label_OSB19_1_text.name				= "LABEL_OSB19_1_TEXT"
Label_OSB19_1_text.alignment		= "LeftCenter"
Label_OSB19_1_text.value			= DATA_ENTRY.."WYPT ID"
Label_OSB19_1_text.material			= font_MFCD
Label_OSB19_1_text.stringdefs		= predefined_fonts[1]
Label_OSB19_1_text.UseBackground	= false
Label_OSB19_1_text.BackgroundMaterial= MFCD_SOLID_BLACK
Label_OSB19_1_text.controllers		= {{"DSMS_profile_is_IAM"}}
shift_button_pos(Label_OSB19_1_text,19,-OSB_label_spacing*2,0)
Add(Label_OSB19_1_text)
use_mipfilter(Label_OSB19_1_text)
]]
addOSB_Box(19, {Label_OSB19})
--[[add_osb_hint_format_controllers(19, 
								{"Desired time of fall", "IAM target entry"}, 
								{{"DSMS_profile_settings_osb_19_hint"}})]]
add_osb_hint_controllers(19, _("Desired time of fall"), {{"DSMS_profile_settings_des_tof"}})

Label_OSB20							= CreateElement "ceStringPoly"
Label_OSB20.name					= "LABEL_OSB20"
Label_OSB20.alignment				= "CenterCenter"
Label_OSB20.value					= ROTARY
Label_OSB20.material				= font_MFCD
Label_OSB20.stringdefs				= txt_labels_font
Label_OSB20.stringdefs				= predefined_fonts[1]
Label_OSB20.controllers				= {{"DSMS_profile_settings_esc_mnvr"}}
Label_OSB20.UseBackground			= false
Label_OSB20.BackgroundMaterial		= MFCD_SOLID_BLACK
shift_button_pos(Label_OSB20,20,0,0)
Add(Label_OSB20)
use_mipfilter(Label_OSB20)

Label_OSB20_text					= CreateElement "ceStringPoly"
Label_OSB20_text.name				= "LABEL_OSB20_TEXT"
Label_OSB20_text.alignment			= "LeftCenter"
Label_OSB20_text.formats			= {"SEM\n%s"}
Label_OSB20_text.material			= font_MFCD
Label_OSB20_text.stringdefs			= predefined_fonts[1]
Label_OSB20_text.UseBackground		= false
Label_OSB20_text.BackgroundMaterial	= MFCD_SOLID_BLACK
Label_OSB20_text.parent_element     = Label_OSB20.name 
Label_OSB20_text.init_pos           = {OSB_label_spacing,0,0}
Label_OSB20_text.controllers        = {{"DSMS_profile_settings_esc_mnvr"}, {"DSMS_profile_settings_esc_mnvr_data"}}
Add(Label_OSB20_text)
use_mipfilter(Label_OSB20_text)

--[[Label_OSB20_1_txt					= CreateElement "ceStringPoly"
Label_OSB20_1_txt.name				= "LABEL_OSB20_1_TXT"
Label_OSB20_1_txt.alignment			= "LeftBottom"
Label_OSB20_1_txt.value				= "TARGET"
Label_OSB20_1_txt.material			= font_MFCD
Label_OSB20_1_txt.stringdefs		= predefined_fonts[1]
Label_OSB20_1_txt.UseBackground		= false
Label_OSB20_1_txt.BackgroundMaterial= MFCD_SOLID_BLACK
Label_OSB20_1_txt.controllers		= {{"DSMS_profile_is_IAM"}}
shift_button_pos(Label_OSB20_1_txt,20,-OSB_label_spacing*2,12)
Add(Label_OSB20_1_txt)
use_mipfilter(Label_OSB20_1_txt)

Label_OSB20_1_text					= CreateElement "ceStringPoly"
Label_OSB20_1_text.name				= "LABEL_OSB20_1_TEXT"
Label_OSB20_1_text.alignment		= "LeftCenter"
Label_OSB20_1_text.formats			= {INC_DEC .. "%s"}
Label_OSB20_1_text.material			= font_MFCD
Label_OSB20_1_text.stringdefs		= predefined_fonts[1]
Label_OSB20_1_text.UseBackground	= false
Label_OSB20_1_text.BackgroundMaterial= MFCD_SOLID_BLACK
Label_OSB20_1_text.controllers		= {{"DSMS_profile_is_IAM"}, {"DSMS_profile_IAM_target_id"}}
shift_button_pos(Label_OSB20_1_text,20,-OSB_label_spacing*2,0)
Add(Label_OSB20_1_text)
use_mipfilter(Label_OSB20_1_text)]]

addOSB_Box(20, {Label_OSB20, Label_OSB20_text})
--add_osb_hint_controllers(20, _("Safe escape maneuver select"), {{"DSMS_profile_settings_esc_mnvr"}})
add_osb_hint_format_controllers(20, 
								{_("Safe escape maneuver select"), _("IAM ID")}, 
								{{"DSMS_profile_settings_osb_20_hint"}})
Profile_name							= CreateElement "ceStringPoly"
Profile_name.name						= "PROFILE_NAME"
Profile_name.material					= font_MFCD
Profile_name.alignment					= "LeftBottom"
Profile_name.init_pos					= {165, max_pixels_count-80, 0}
Profile_name.stringdefs					= predefined_fonts[1]
Profile_name.UseBackground				= true
Profile_name.BackgroundMaterial			= MFCD_SOLID_BLACK
Profile_name.formats					= {"%s"}
Profile_name.controllers				= {{"DSMS_profile_name_nav_in_view", materials[MFCD_SOLID_BLACK][1], materials[MFCD_SOLID_BLACK][2], materials[MFCD_SOLID_BLACK][3]}}
SetLowerLeftCornerOrigin(Profile_name)
Add(Profile_name)
use_mipfilter(Profile_name)

profile_settings						= CreateElement "ceStringPoly"
profile_settings.name					= "PROFILE_SETTINGS"
profile_settings.material				= font_MFCD
profile_settings.alignment				= "CenterCenter"
profile_settings.init_pos				= {160+267/2, max_pixels_count-127, 0}
SetLowerLeftCornerOrigin(profile_settings)
profile_settings.stringdefs				= predefined_fonts[1]
profile_settings.UseBackground			= false
profile_settings.BackgroundMaterial		= MFCD_SOLID_BLACK
profile_settings.value					= "PROFILE SETTINGS"
Add(profile_settings)
use_mipfilter(profile_settings)

