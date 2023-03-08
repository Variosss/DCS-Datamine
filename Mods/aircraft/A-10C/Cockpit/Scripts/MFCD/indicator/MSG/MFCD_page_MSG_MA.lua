dofile(LockOn_Options.script_path.."MFCD//indicator//MSG//MFCD_page_MSG_definitions.lua")

Label_OSB2							= CreateElement "ceStringPoly"
Label_OSB2.name						= "Label_OSB2"
Label_OSB2.material					= font_MFCD
Label_OSB2.alignment				= "CenterTop"
Label_OSB2.value					= "MA"
Label_OSB2.stringdefs				= txt_labels_font
shift_button_pos(Label_OSB2, 2, 0)
Add(Label_OSB2)
use_mipfilter(Label_OSB2)

Label_OSB2_symb_MA					= CreateElement "ceStringPoly"
Label_OSB2_symb_MA.name				= "Label_OSB2_symb_MA"
Label_OSB2_symb_MA.alignment		= "LeftTop"
Label_OSB2_symb_MA.value			= ROTARY
Label_OSB2_symb_MA.material			= font_MFCD
Label_OSB2_symb_MA.stringdefs		= txt_labels_font
Label_OSB2_symb_MA.controllers		= {{"MSG_NoQuickLook"}}
Label_OSB2_symb_MA.parent_element	= Label_OSB2.name
Label_OSB2_symb_MA.init_pos			= {-22}
Add(Label_OSB2_symb_MA)
use_mipfilter(Label_OSB2_symb_MA)

addOSB_Box(2, {Label_OSB2, Label_OSB2_symb_MA})
add_osb_static_hint(2, _("Message type"))

add_dummy_boxes({3, 5})
add_dummy_boxes({7, 8, 9})
add_dummy_boxes({16, 17, 18})
