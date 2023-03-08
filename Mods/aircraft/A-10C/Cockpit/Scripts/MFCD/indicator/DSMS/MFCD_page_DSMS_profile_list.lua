dofile(LockOn_Options.script_path.."MFCD/indicator/MFCD_useful_definitions.lua")
dofile(LockOn_Options.script_path.."materials.lua")
dofile(LockOn_Options.script_path.."MFCD/indicator/DSMS/MFCD_DSMS_useful_definitions.lua")

AddStatLabel()

addOSB_Box(2)

Label_OSB3							= CreateElement "ceStringPoly"
Label_OSB3.name						= "LABEL_OSB3"
Label_OSB3.material					= font_MFCD
Label_OSB3.UseBackground			= false
Label_OSB3.BackgroundMaterial		= MFCD_SOLID_BLACK
Label_OSB3.alignment				= "CenterTop"
Label_OSB3.value					= "VIEW\nPRO"
Label_OSB3.stringdefs				= predefined_fonts[1]
Label_OSB3.controllers				= {{"DSMS_label_not_wpns_off"}}
shift_button_pos(Label_OSB3, 3)
Add(Label_OSB3)
use_mipfilter(Label_OSB3)

Label_OSB3_symbol					= Copy(Label_OSB3)
Label_OSB3_symbol.value				= SYS_ACTION
shift_button_pos(Label_OSB3_symbol, 3, -30)
Add(Label_OSB3_symbol)
use_mipfilter(Label_OSB3_symbol)

addOSB_Box(3, {Label_OSB3, Label_OSB3_symbol})
add_osb_hint_controllers(3, _("Go to Profile Control page"), {{"DSMS_label_not_wpns_off"}})

addOSB_Box(4)

Label_OSB5							= CreateElement "ceStringPoly"
Label_OSB5.name						= "LABEL_OSB5"
Label_OSB5.material					= font_MFCD
Label_OSB5.UseBackground			= false
Label_OSB5.BackgroundMaterial		= MFCD_SOLID_BLACK
Label_OSB5.alignment				= "CenterTop"
Label_OSB5.value					= "CLR\nPRO"
Label_OSB5.stringdefs				= predefined_fonts[1]
Label_OSB5.controllers				= {{"DSMS_label_not_wpns_off"}, {"DSMS_can_clear"}}
shift_button_pos(Label_OSB5, 5)
Add(Label_OSB5)
use_mipfilter(Label_OSB5)

Label_OSB5_symbol					= Copy(Label_OSB5)
Label_OSB5_symbol.value				= SYS_ACTION
shift_button_pos(Label_OSB5_symbol, 5, -25)
Add(Label_OSB5_symbol)
use_mipfilter(Label_OSB5_symbol)

addOSB_Box(5, {Label_OSB5, Label_OSB5_symbol})
add_osb_hint_controllers(5, _("Clear selected profile"), {{"DSMS_label_not_wpns_off"}, {"DSMS_can_clear"}})

Scrollers_6_7 = addScrollers(6, 7, -5,
	{{"DSMS_can_move_profile_in_list"}},
	{{"DSMS_can_move_profile_in_list"}})
add_osb_hint_controllers(6, _("Move selected profile up in list"), {{"DSMS_can_move_profile_in_list"}})
add_osb_hint_controllers(7, _("Move selected profile down in list"), {{"DSMS_can_move_profile_in_list"}})

addOSB_Box(6, {Scrollers_6_7[3]})
addOSB_Box(7, {Scrollers_6_7[4]})
	
Label_Move							= CreateElement "ceStringPoly"
Label_Move.name						= "LABEL_MOVE"
Label_Move.material					= font_MFCD
Label_Move.UseBackground			= false
Label_Move.BackgroundMaterial		= MFCD_SOLID_BLACK
Label_Move.alignment				= "RightCenter"
Label_Move.value					= "MOVE"
Label_Move.stringdefs				= txt_labels_font
Label_Move.init_pos					= {OSB_positions[7][1]+15,(OSB_positions[7][2]+OSB_positions[6][2])/2,0}
Label_Move.controllers				= {{"DSMS_label_not_wpns_off"}}
SetLowerLeftCornerOrigin(Label_Move)
Add(Label_Move)
use_mipfilter(Label_Move)

addOSB_Box(8)

Label_OSB9							= CreateElement "ceStringPoly"
Label_OSB9.name						= "LABEL_OSB9"
Label_OSB9.alignment				= "RightCenter"
Label_OSB9.value					= ROTARY
Label_OSB9.material					= font_MFCD
Label_OSB9.stringdefs				= txt_labels_font
Label_OSB9.controllers				= {{"DSMS_swap_HUD_rotary_status_visible"}}
Label_OSB9.UseBackground			= false
Label_OSB9.BackgroundMaterial		= MFCD_SOLID_BLACK
shift_button_pos(Label_OSB9,9,-OSB_label_spacing,0)
Add(Label_OSB9)
use_mipfilter(Label_OSB9)

Label_OSB9_text						= CreateElement "ceStringPoly"
Label_OSB9_text.name				= "LABEL_OSB9_text"
Label_OSB9_text.alignment			= "RightCenter"
Label_OSB9_text.value				= "PRO\nON"
Label_OSB9_text.material			= font_MFCD
Label_OSB9_text.stringdefs			= txt_labels_font
Label_OSB9_text.UseBackground		= false
Label_OSB9_text.BackgroundMaterial	= MFCD_SOLID_BLACK
Label_OSB9_text.parent_element      = Label_OSB9.name 
Label_OSB9_text.init_pos            = {-2*OSB_label_spacing,0,0}
Label_OSB9_text.controllers			= {{"DSMS_swap_HUD_rotary_status_visible"}, {"DSMS_swap_HUD_rotary_status_on", 0}}
Add(Label_OSB9_text)
use_mipfilter(Label_OSB9_text)

Label_OSB9_text_2					= Copy(Label_OSB9_text)
Label_OSB9_text_2.value				= "PRO\nOFF"
Label_OSB9_text_2.controllers		= {{"DSMS_swap_HUD_rotary_status_visible"}, {"DSMS_swap_HUD_rotary_status_on", 1}}
Add(Label_OSB9_text_2)

addOSB_Box(9, {Label_OSB9, Label_OSB9_text, Label_OSB9_text_2})
add_osb_hint_format_controllers(9, {_("Remove profile from HUD rotary"), _("Add profile to HUD rotary")}, {{"DSMS_swap_HUD_rotary_status_visible"}, {"DSMS_swap_HUD_rotary_status_hint"}})

add_dummy_boxes({10, 16})

Label_OSB17							= CreateElement "ceStringPoly"
Label_OSB17.name					= "Label_OSB17"
Label_OSB17.alignment				= "CenterCenter"
Label_OSB17.value					= SYS_ACTION
Label_OSB17.material				= font_MFCD
Label_OSB17.stringdefs				= txt_labels_font
Label_OSB17.UseBackground			= false
Label_OSB17.BackgroundMaterial		= MFCD_SOLID_BLACK
Label_OSB17.controllers       		= {{"DSMS_activate_profile"}}
shift_button_pos(Label_OSB17,17,-OSB_label_spacing,0)
Add(Label_OSB17)
use_mipfilter(Label_OSB17)

Label_OSB17_text					= CreateElement "ceStringPoly"
Label_OSB17_text.name				= "LABEL_OSB17_TEXT"
Label_OSB17_text.alignment			= "LeftCenter"
Label_OSB17_text.value				= "ACT\nPRO"
Label_OSB17_text.material			= font_MFCD
Label_OSB17_text.stringdefs			= txt_labels_font
Label_OSB17_text.UseBackground		= false
Label_OSB17_text.BackgroundMaterial	= MFCD_SOLID_BLACK
Label_OSB17_text.parent_element     = Label_OSB17.name 
Label_OSB17_text.init_pos           = {OSB_label_spacing,0,0}
Label_OSB17_text.controllers        = {{"DSMS_activate_profile"}}
Add(Label_OSB17_text)
use_mipfilter(Label_OSB17_text)

addOSB_Box(17, {Label_OSB17, Label_OSB17_text})
add_osb_hint_controllers(17, _("Make active profile"), {{"DSMS_activate_profile"}})

addOSB_Box(18)

Scrollers_20_19 = addScrollers(20, 19, 5)
add_osb_static_hint(19, _("Select next profile"))
add_osb_static_hint(20, _("Select previous profile"))

addOSB_Box(20, {Scrollers_20_19[3]})
addOSB_Box(19, {Scrollers_20_19[4]})


ProfileColor={}
for i=1, 15 do
	ProfileColor[i]						= CreateElement "ceMeshPoly"
	ProfileColor[i].name				= "PROFILE_COLOR"..i
	ProfileColor[i].material			= MFCD_SOLID_GREEN
	ProfileColor[i].primitivetype   	= "triangles"
	ProfileColor[i].init_pos			= {130,0,0}
	ProfileColor[i].vertices        	= {{0, DSMS_InitPosY+DSMS_StringHeight*(15-i)}, 
											{0, DSMS_InitPosY+DSMS_StringHeight*(16-i)}, 
											{310, DSMS_InitPosY+DSMS_StringHeight*(16-i)},
											{310, DSMS_InitPosY+DSMS_StringHeight*(15-i)}}
	ProfileColor[i].indices	        	= box_ind
	ProfileColor[i].controllers			= {{"DSMS_table_line_color", i}}
	ProfileColor[i].isdraw				= false
	SetLowerLeftCornerOrigin(ProfileColor[i])
	Add(ProfileColor[i])
	use_mipfilter(ProfileColor[i])
end

TableHUD_RotaryStatus={}
for i=1, 15 do
	TableHUD_RotaryStatus[i]					= CreateElement "ceStringPoly"
	TableHUD_RotaryStatus[i].name				= "TABLE_ROTARY"..i
	TableHUD_RotaryStatus[i].material			= font_MFCD
	TableHUD_RotaryStatus[i].UseBackground		= false
	TableHUD_RotaryStatus[i].alignment			= "LeftCenter"
	TableHUD_RotaryStatus[i].init_pos			= {390,DSMS_InitPosY-DSMS_StringHeight/2+DSMS_StringHeight*(16-i),0}
	TableHUD_RotaryStatus[i].formats			= {"ON", "OFF", "---"}
	TableHUD_RotaryStatus[i].controllers		= {{"DSMS_profile_HUD_rotary_status", i}}
	TableHUD_RotaryStatus[i].stringdefs			= txt_labels_font
	SetLowerLeftCornerOrigin(TableHUD_RotaryStatus[i])
	Add(TableHUD_RotaryStatus[i])
	use_mipfilter(TableHUD_RotaryStatus[i])
end

TableWpnName={}
for i=1, 15 do
	TableWpnName[i]						= CreateElement "ceStringPoly"
	TableWpnName[i].name				= "TABLE_WPN"..i
	TableWpnName[i].material			= font_MFCD
	TableWpnName[i].UseBackground		= false
	TableWpnName[i].alignment			= "LeftCenter"
	TableWpnName[i].init_pos			= {270,DSMS_InitPosY-DSMS_StringHeight/2+DSMS_StringHeight*(16-i),0}
	TableWpnName[i].controllers			= {{"DSMS_profile_wpn_name", i}}
	TableWpnName[i].stringdefs			= predefined_fonts[1]
	SetLowerLeftCornerOrigin(TableWpnName[i])
	Add(TableWpnName[i])
	use_mipfilter(TableWpnName[i])
end

TableNames={}
for i=1, 15 do
	TableNames[i]						= CreateElement "ceStringPoly"
	TableNames[i].name					= "TABLE_NAMES"..i
	TableNames[i].material				= font_MFCD
	TableNames[i].UseBackground			= false
	TableNames[i].alignment				= "LeftCenter"
	TableNames[i].init_pos				= {145,DSMS_InitPosY-DSMS_StringHeight/2+DSMS_StringHeight*(16-i),0}
	TableNames[i].controllers			= {{"DSMS_table_names", i}}
	TableNames[i].stringdefs			= predefined_fonts[1]
	SetLowerLeftCornerOrigin(TableNames[i])
	Add(TableNames[i])
	use_mipfilter(TableNames[i])
end

TableBorder					= line_2_pixel({{0, DSMS_InitPosY},
											{0, max_pixels_count-76}, 
											{310, max_pixels_count-76}, 
											{310, DSMS_InitPosY},
											{0, DSMS_InitPosY}}, MFCD_GREEN)
TableBorder.init_pos	    = {130,0,0}
SetLowerLeftCornerOrigin(TableBorder)

TableHorLines={}
for i=1, 15 do
	TableHorLines[i]				= line_2_pixel({{0, DSMS_InitPosY+i*DSMS_StringHeight},
													{310, DSMS_InitPosY+i*DSMS_StringHeight}}, MFCD_GREEN)
	TableHorLines[i].init_pos	    = {130,0,0}
	SetLowerLeftCornerOrigin(TableHorLines[i])
end

TableVertLines={}

TableVertLines[1]				= line_2_pixel({{250, DSMS_InitPosY},
												{250, DSMS_InitPosY+15*DSMS_StringHeight}}, MFCD_GREEN)
TableVertLines[1].init_pos	    = {0,0,0}
SetLowerLeftCornerOrigin(TableVertLines[1])

TableVertLines[2]				= line_2_pixel({{378, DSMS_InitPosY},
												{378, DSMS_InitPosY+15*DSMS_StringHeight}}, MFCD_GREEN)
TableVertLines[2].init_pos	    = {0,0,0}
SetLowerLeftCornerOrigin(TableVertLines[2])

Label_PROFILES							= CreateElement "ceStringPoly"
Label_PROFILES.name						= "LABEL_PROFILES"
Label_PROFILES.material					= font_MFCD
Label_PROFILES.UseBackground			= false
Label_PROFILES.BackgroundMaterial		= MFCD_SOLID_BLACK
Label_PROFILES.alignment				= "CenterTop"
Label_PROFILES.init_pos					= {max_pixels_count/2,DSMS_InitPosY+18*DSMS_StringHeight,0}
Label_PROFILES.value					= "PROFILES"
Label_PROFILES.stringdefs				= predefined_fonts[1]
SetLowerLeftCornerOrigin(Label_PROFILES)
Add(Label_PROFILES)
use_mipfilter(Label_PROFILES)

training_label							= CreateElement "ceStringPoly"
training_label.name						= "TRAINING_LABEL"
training_label.material					= font_MFCD_BLUE
training_label.alignment				= "CenterBottom"
training_label.init_pos					= {370,max_pixels_count-145,0}
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

SelectedArrow						= CreateElement "ceStringPoly"
SelectedArrow.name					= "SELECTED_ARROW"
SelectedArrow.material				= font_MFCD
SelectedArrow.UseBackground			= false
SelectedArrow.BackgroundMaterial	= MFCD_SOLID_BLACK
SelectedArrow.alignment				= "RightCenter"
SelectedArrow.init_pos				= {120,DSMS_InitPosY-DSMS_StringHeight/2+DSMS_StringHeight*15,0}
SelectedArrow.value					= BRANCH_L
SelectedArrow.stringdefs			= predefined_fonts[3]
SelectedArrow.controllers			= {{"DSMS_selected_arrow", DSMS_StringHeight}}
SetLowerLeftCornerOrigin(SelectedArrow)
Add(SelectedArrow)
use_mipfilter(SelectedArrow)

Profile_name						= CreateElement "ceStringPoly"
Profile_name.name					= "PROFILE_NAME"
Profile_name.material				= font_MFCD
Profile_name.alignment				= "LeftCenter"
Profile_name.init_pos				= {OSB_positions[19][1]-15,(OSB_positions[19][2]+OSB_positions[20][2])/2,0}
Profile_name.stringdefs				= txt_labels_font
Profile_name.UseBackground			= true
Profile_name.BackgroundMaterial		= MFCD_SOLID_BLACK
Profile_name.formats				= {"%s"}
Profile_name.controllers			= {{"DSMS_profile_name_navigation", materials[MFCD_SOLID_BLACK][1], materials[MFCD_SOLID_BLACK][2], materials[MFCD_SOLID_BLACK][3]}}
SetLowerLeftCornerOrigin(Profile_name)
Add(Profile_name)
use_mipfilter(Profile_name) 

ManualProfile_name						= CreateElement "ceStringPoly"
ManualProfile_name.name					= "ManualProfile_name"
ManualProfile_name.material				= font_MFCD
ManualProfile_name.alignment			= "CenterBottom"
ManualProfile_name.init_pos				= {200,max_pixels_count-145,0}
ManualProfile_name.stringdefs			= txt_labels_font
ManualProfile_name.UseBackground		= true
ManualProfile_name.BackgroundMaterial	= MFCD_SOLID_BLACK
ManualProfile_name.formats				= {"%s"}
ManualProfile_name.controllers			= {{"DSMS_manual_profile_name"}}
SetLowerLeftCornerOrigin(ManualProfile_name)
Add(ManualProfile_name)
use_mipfilter(ManualProfile_name) 

addTableScrollBar(171, DSMS_InitPosY + (DSMS_StringHeight * 15 / 2) - max_pixels_count / 2, 312,
	{{"DSMS_scroll_bar_visible"}, {"DSMS_scroll_bar_pos", 0, 312}},
    {{"DSMS_scroll_bar_visible"}, {"DSMS_scroll_up_visible"}},
    {{"DSMS_scroll_bar_visible"}, {"DSMS_cursor_at_last_item", 0}},
    nil)


local ConfrmTxt  = " PRESS CLR PRO AGAIN \n" ..
                   " TO CONFIRM DELETION "

addConfirmation("CONFIRM_DELETION_TEXT", {{"DSMS_delete_profile_label"}}, ConfrmTxt)
