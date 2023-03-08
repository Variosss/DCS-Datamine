dofile(LockOn_Options.script_path.."MFCD/indicator/MFCD_useful_definitions.lua")
dofile(LockOn_Options.script_path.."MFCD/indicator/DSMS/MFCD_DSMS_useful_definitions.lua")

AddMaverickPowerTimeLabel()

PageNameText							= CreateElement "ceStringPoly"
PageNameText.name						= "InventoryText"
PageNameText.material					= font_MFCD
PageNameText.alignment					= "CenterTop"
PageNameText.init_pos					= {max_pixels_count/2,(OSB_positions[20][2]+OSB_positions[19][2])/2+15,0}
SetLowerLeftCornerOrigin(PageNameText)
PageNameText.stringdefs					= predefined_fonts[3]
PageNameText.UseBackground				= false
PageNameText.BackgroundMaterial			= MFCD_SOLID_BLACK
PageNameText.value						= "MISSILE\nCONTROL"
Add(PageNameText)
use_mipfilter(PageNameText) 

labels = {}

AddStatLabel()

labels_2_symbol						= CreateElement "ceStringPoly"
labels_2_symbol.name				= "labels_2_symbol"
labels_2_symbol.material			= font_MFCD
labels_2_symbol.UseBackground		= false
labels_2_symbol.BackgroundMaterial	= MFCD_SOLID_BLACK
labels_2_symbol.alignment			= "CenterTop"
labels_2_symbol.stringdefs			= predefined_fonts[1]
labels_2_symbol.value				= SYS_ACTION
labels_2_symbol.controllers         = {{"DSMS_aim9_reject_is_applicable"}}
shift_button_pos(labels_2_symbol, 2, -27)
Add(labels_2_symbol)
use_mipfilter(labels_2_symbol)

labels_2_text						= CreateElement "ceStringPoly"
labels_2_text.name					= "labels_2_text"
labels_2_text.material				= font_MFCD
labels_2_text.UseBackground			= false
labels_2_text.BackgroundMaterial	= MFCD_SOLID_BLACK
labels_2_text.alignment				= "CenterTop"
labels_2_text.value					= "AIM9\nREJ"
labels_2_text.stringdefs			= predefined_fonts[1]
shift_button_pos(labels_2_text, 2)
Add(labels_2_text)
use_mipfilter(labels_2_text)

addOSB_Box(2, {labels_2_symbol, labels_2_text})
add_osb_static_hint(2, _("AIM-9 Reject"))

addOSB_Box(3)

labels_4_symbol						= CreateElement "ceStringPoly"
labels_4_symbol.name				= "labels_4_symbol"
labels_4_symbol.material			= font_MFCD
labels_4_symbol.UseBackground		= false
labels_4_symbol.BackgroundMaterial	= MFCD_SOLID_BLACK
labels_4_symbol.alignment			= "CenterTop"
labels_4_symbol.stringdefs			= predefined_fonts[1]
labels_4_symbol.value				= ROTARY
shift_button_pos(labels_4_symbol, 4, -20)
Add(labels_4_symbol)
use_mipfilter(labels_4_symbol)

labels_4_text						= CreateElement "ceStringPoly"
labels_4_text.name					= "labels_4_text"
labels_4_text.material				= font_MFCD
labels_4_text.UseBackground			= false
labels_4_text.BackgroundMaterial	= MFCD_SOLID_BLACK
labels_4_text.alignment				= "CenterTop"
labels_4_text.value					= "EO\nOFF"
labels_4_text.stringdefs			= predefined_fonts[1]
labels_4_text.controllers           = {{"maverick_power_on",-1}}
shift_button_pos(labels_4_text, 4)
Add(labels_4_text)
use_mipfilter(labels_4_text)

labels_4_text_2						= Copy(labels_4_text)
labels_4_text_2.value				= "EO\nON"
labels_4_text_2.controllers         = {{"maverick_power_on"}}
Add(labels_4_text_2)

addOSB_Box(4, {labels_4_symbol,labels_4_text,labels_4_text_2})
add_osb_static_hint(4, _("Cycle EO power to Maverick"))

Label_OSB5							= CreateElement "ceStringPoly"
Label_OSB5.name						= "Label_OSB5"
Label_OSB5.material					= font_MFCD
Label_OSB5.UseBackground			= false
Label_OSB5.BackgroundMaterial		= MFCD_SOLID_BLACK
Label_OSB5.alignment				= "CenterTop"
Label_OSB5.formats					= {ROTARY .. "MAN", ROTARY .. "LOC", ROTARY .. "TIME"}
Label_OSB5.stringdefs				= predefined_fonts[1]
Label_OSB5.controllers				= {{"DSMS_maverick_power_on_type"}}
shift_button_pos(Label_OSB5,5)
SetLowerLeftCornerOrigin(Label_OSB5)
Add(Label_OSB5)
use_mipfilter(Label_OSB5)

addOSB_Box(5, {Label_OSB5})
add_osb_static_hint(5, _("Select automatic EO power mode"))

Label_OSB6							= CreateElement "ceStringPoly"
Label_OSB6.name						= "LABEL_OSB6"
Label_OSB6.alignment				= "RightCenter"
Label_OSB6.value					= ROTARY
Label_OSB6.material					= font_MFCD
Label_OSB6.stringdefs				= txt_labels_font
Label_OSB6.UseBackground			= false
Label_OSB6.BackgroundMaterial		= MFCD_SOLID_BLACK
Label_OSB6.controllers				= {{"mav_adjustment_is_avail", 1}}
shift_button_pos(Label_OSB6, 6)
Add(Label_OSB6)
use_mipfilter(Label_OSB6)

Label_OSB6_text						= CreateElement "ceStringPoly"
Label_OSB6_text.name				= "Label_OSB6_text"
Label_OSB6_text.alignment			= "RightCenter"
Label_OSB6_text.value				= "MAV ADJ\nON"
Label_OSB6_text.material			= font_MFCD
Label_OSB6_text.stringdefs			= txt_labels_font
Label_OSB6_text.UseBackground		= false
Label_OSB6_text.BackgroundMaterial	= MFCD_SOLID_BLACK
Label_OSB6_text.parent_element      = Label_OSB6.name 
Label_OSB6_text.init_pos            = {-2*OSB_label_spacing,0,0}
Label_OSB6_text.controllers			= {{"maverick_adjustment"}}
shift_button_pos(Label_OSB6_text, 6, -2 * OSB_label_spacing, 0)
Add(Label_OSB6_text)
use_mipfilter(Label_OSB6_text)

Label_OSB6_text_2					= Copy(Label_OSB6_text)
Label_OSB6_text_2.value				= "MAV ADJ\nOFF"
Label_OSB6_text_2.controllers		= {{"maverick_adjustment", -1}}
Add(Label_OSB6_text_2)

addOSB_Box(6, {Label_OSB6,Label_OSB6_text,Label_OSB6_text_2})
add_osb_static_hint(6, _("Cycle Maverick boresight adjust"))

Label_OSB7							= CreateElement "ceStringPoly"
Label_OSB7.name						= "Label_OSB7"
Label_OSB7.alignment				= "CenterCenter"
Label_OSB7.value					= DATA_ENTRY
Label_OSB7.material					= font_MFCD
Label_OSB7.stringdefs				= predefined_fonts[1]
Label_OSB7.UseBackground			= false
Label_OSB7.BackgroundMaterial		= MFCD_SOLID_BLACK
shift_button_pos(Label_OSB7,7,-1*OSB_label_spacing,0)
Add(Label_OSB7)
use_mipfilter(Label_OSB7)

Label_OSB7_text						= CreateElement "ceStringPoly"
Label_OSB7_text.name				= "Label_OSB7_text"
Label_OSB7_text.alignment			= "RightCenter"
Label_OSB7_text.formats				= {"BRG\n%03d"}
Label_OSB7_text.material			= font_MFCD
Label_OSB7_text.stringdefs			= predefined_fonts[1]
Label_OSB7_text.UseBackground		= false
Label_OSB7_text.BackgroundMaterial	= MFCD_SOLID_BLACK
Label_OSB7_text.parent_element		= Label_OSB7.name 
Label_OSB7_text.init_pos			= {-2*OSB_label_spacing,0,0}
Label_OSB7_text.controllers			= {{"DSMS_maverick_power_on_bearing"}}
Add(Label_OSB7_text)
use_mipfilter(Label_OSB7_text)

addOSB_Box(7, {Label_OSB7, Label_OSB7_text})
add_osb_static_hint(7, _("Enter auto EO power bearing"))

Label_OSB8							= CreateElement "ceStringPoly"
Label_OSB8.name						= "Label_OSB8"
Label_OSB8.alignment				= "CenterCenter"
Label_OSB8.value					= DATA_ENTRY
Label_OSB8.material					= font_MFCD
Label_OSB8.stringdefs				= predefined_fonts[1]
Label_OSB8.UseBackground			= false
Label_OSB8.BackgroundMaterial		= MFCD_SOLID_BLACK
shift_button_pos(Label_OSB8,8,-1*OSB_label_spacing,0)
Add(Label_OSB8)
use_mipfilter(Label_OSB8)

Label_OSB8_text						= CreateElement "ceStringPoly"
Label_OSB8_text.name				= "Label_OSB8_text"
Label_OSB8_text.alignment			= "RightCenter"
Label_OSB8_text.formats				= {"RNG\n%3d"}
Label_OSB8_text.material			= font_MFCD
Label_OSB8_text.stringdefs			= predefined_fonts[1]
Label_OSB8_text.UseBackground		= false
Label_OSB8_text.BackgroundMaterial	= MFCD_SOLID_BLACK
Label_OSB8_text.parent_element		= Label_OSB8.name 
Label_OSB8_text.init_pos			= {-2*OSB_label_spacing,0,0}
Label_OSB8_text.controllers			= {{"DSMS_maverick_power_on_range"}}
Add(Label_OSB8_text)
use_mipfilter(Label_OSB8_text)

addOSB_Box(8, {Label_OSB8, Label_OSB8_text})
add_osb_static_hint(8, _("Enter auto EO power range"))

Label_OSB9							= CreateElement "ceStringPoly"
Label_OSB9.name						= "Label_OSB9"
Label_OSB9.alignment				= "CenterCenter"
Label_OSB9.value					= INC_DEC
Label_OSB9.material					= font_MFCD
Label_OSB9.stringdefs				= predefined_fonts[1]
Label_OSB9.UseBackground			= false
Label_OSB9.BackgroundMaterial		= MFCD_SOLID_BLACK
Label_OSB9.controllers				= {{"DSMS_missile_ctrl_inc_dec_active", 0}}
shift_button_pos(Label_OSB9, 9, -1 * OSB_label_spacing, 0)
Add(Label_OSB9)
use_mipfilter(Label_OSB9)

Label_OSB9_inverse						= CreateElement "ceStringPoly"
Label_OSB9_inverse.name					= "Label_OSB9_inverse"
Label_OSB9_inverse.alignment			= "CenterCenter"
Label_OSB9_inverse.value				= INC_DEC
Label_OSB9_inverse.material				= font_MFCD_BLACK
Label_OSB9_inverse.stringdefs			= predefined_fonts[1]
Label_OSB9_inverse.UseBackground		= true
Label_OSB9_inverse.BackgroundMaterial	= MFCD_SOLID_GREEN
Label_OSB9_inverse.controllers			= {{"DSMS_missile_ctrl_inc_dec_active", 1}}
shift_button_pos(Label_OSB9_inverse, 9, -1 * OSB_label_spacing, 0)
Add(Label_OSB9_inverse)
use_mipfilter(Label_OSB9_inverse)

Label_OSB9_text						= CreateElement "ceStringPoly"
Label_OSB9_text.name				= "Label_OSB9_text"
Label_OSB9_text.alignment			= "RightCenter"
Label_OSB9_text.formats				= {"WYPT\n%d"}
--Label_OSB9_text.value				= "WYPT\n0"
Label_OSB9_text.material			= font_MFCD
Label_OSB9_text.stringdefs			= predefined_fonts[1]
Label_OSB9_text.UseBackground		= false
Label_OSB9_text.BackgroundMaterial	= MFCD_SOLID_BLACK
Label_OSB9_text.controllers			= {{"DSMS_maverick_power_on_wpt_num"}}
shift_button_pos(Label_OSB9_text, 9, -3 * OSB_label_spacing, 0)
Add(Label_OSB9_text)
use_mipfilter(Label_OSB9_text)

addOSB_Box(9, {Label_OSB9, Label_OSB9_text, Label_OSB9_inverse})
add_osb_static_hint(9, _("Enter auto EO power waypoint"))

Label_OSB10							= CreateElement "ceStringPoly"
Label_OSB10.name					= "Label_OSB10"
Label_OSB10.alignment				= "CenterCenter"
Label_OSB10.value					= DATA_ENTRY
Label_OSB10.material				= font_MFCD
Label_OSB10.stringdefs				= predefined_fonts[1]
Label_OSB10.UseBackground			= false
Label_OSB10.BackgroundMaterial		= MFCD_SOLID_BLACK
shift_button_pos(Label_OSB10,10,-1*OSB_label_spacing,0)
Add(Label_OSB10)
use_mipfilter(Label_OSB10)

Label_OSB10_text					= CreateElement "ceStringPoly"
Label_OSB10_text.name				= "Label_OSB10_text"
Label_OSB10_text.alignment			= "RightCenter"
--Label_OSB10_text.formats				= {"WYPT\n%d"}
Label_OSB10_text.formats			= {"TIME\n%02d:%02d:%02d"}
Label_OSB10_text.material			= font_MFCD
Label_OSB10_text.stringdefs			= predefined_fonts[1]
Label_OSB10_text.UseBackground		= false
Label_OSB10_text.BackgroundMaterial	= MFCD_SOLID_BLACK
Label_OSB10_text.parent_element		= Label_OSB10.name 
Label_OSB10_text.init_pos			= {-2*OSB_label_spacing,0,0}
Label_OSB10_text.controllers     	= {{"DSMS_maverick_power_on_time",0}}
--Label_OSB10_text.controllers			= {{"DSMS_maverick_power_on_range"}}
Add(Label_OSB10_text)
use_mipfilter(Label_OSB10_text)

addOSB_Box(10, {Label_OSB10, Label_OSB10_text})
add_osb_static_hint(10, _("Enter auto EO power time"))

add_dummy_boxes({16, 17, 18})

Label_OSB19							= CreateElement "ceStringPoly"
Label_OSB19.name					= "Label_OSB19"
Label_OSB19.alignment				= "CenterCenter"
Label_OSB19.value					= ROTARY
Label_OSB19.material				= font_MFCD
Label_OSB19.stringdefs				= predefined_fonts[1]
Label_OSB19.UseBackground			= false
Label_OSB19.BackgroundMaterial		= MFCD_SOLID_BLACK
shift_button_pos(Label_OSB19,19,-OSB_label_spacing,0)
Add(Label_OSB19)
use_mipfilter(Label_OSB19)

Label_OSB19_text					= CreateElement "ceStringPoly"
Label_OSB19_text.name				= "LABEL_OSB19_TEXT"
Label_OSB19_text.alignment			= "LeftCenter"
Label_OSB19_text.formats			= {"AIM9\nOFF", "AIM9\nCOOL", "AIM9\nSELECT"}
--Label_OSB19_text.value				= "AIM9\nOFF"
Label_OSB19_text.material			= font_MFCD
Label_OSB19_text.stringdefs			= predefined_fonts[1]
Label_OSB19_text.UseBackground		= false
Label_OSB19_text.BackgroundMaterial	= MFCD_SOLID_BLACK
Label_OSB19_text.parent_element     = Label_OSB19.name 
Label_OSB19_text.init_pos           = {OSB_label_spacing,0,0}
Label_OSB19_text.controllers        = {{"DSMS_sidewinder_status"}}
Add(Label_OSB19_text)
use_mipfilter(Label_OSB19_text)

addOSB_Box(19, {Label_OSB19, Label_OSB19_text})
add_osb_static_hint(19, _("Cycle AIM-9 functions"))

Label_OSB20							= CreateElement "ceStringPoly"
Label_OSB20.name					= "Label_OSB20"
Label_OSB20.alignment				= "CenterCenter"
Label_OSB20.value					= ROTARY
Label_OSB20.material				= font_MFCD
Label_OSB20.stringdefs				= predefined_fonts[1]
Label_OSB20.UseBackground			= false
Label_OSB20.BackgroundMaterial		= MFCD_SOLID_BLACK
shift_button_pos(Label_OSB20, 20, -OSB_label_spacing, 0)
Label_OSB20.controllers				= {{"DSMS_sidewinder_is_adj_applicable"}}
Add(Label_OSB20)
use_mipfilter(Label_OSB20)

Label_OSB20_text					= CreateElement "ceStringPoly"
Label_OSB20_text.name				= "LABEL_OSB20_TEXT"
Label_OSB20_text.alignment			= "LeftCenter"
Label_OSB20_text.formats			= {"AIM9 ADJ\nOFF", "AIM9 ADJ\nON"}
Label_OSB20_text.material			= font_MFCD
Label_OSB20_text.stringdefs			= predefined_fonts[1]
Label_OSB20_text.UseBackground		= false
Label_OSB20_text.BackgroundMaterial	= MFCD_SOLID_BLACK
shift_button_pos(Label_OSB20_text, 20, 0, 0)
Label_OSB20_text.controllers        = {{"DSMS_sidewinder_adj"}}
Add(Label_OSB20_text)
use_mipfilter(Label_OSB20_text)

addOSB_Box(20, {Label_OSB20, Label_OSB20_text})
add_osb_static_hint(20, _("Cycle AIM-9 boresight function"))

