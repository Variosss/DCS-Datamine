dofile(LockOn_Options.script_path.."MFCD//indicator//MSG//MFCD_page_MSG_J28_2.lua")

Label_OSB2							= CreateElement "ceStringPoly"
Label_OSB2.name						= "Label_OSB2"
Label_OSB2.material					= font_MFCD
Label_OSB2.alignment				= "CenterTop"
Label_OSB2.value					= "CAS"
Label_OSB2.stringdefs				= txt_labels_font
shift_button_pos(Label_OSB2, 2, 0)
Add(Label_OSB2)
use_mipfilter(Label_OSB2)

Label_OSB2_symb_CAS					= CreateElement "ceStringPoly"
Label_OSB2_symb_CAS.name			= "Label_OSB2_symb_CAS"
Label_OSB2_symb_CAS.alignment		= "LeftTop"
Label_OSB2_symb_CAS.value			= ROTARY
Label_OSB2_symb_CAS.material		= font_MFCD
Label_OSB2_symb_CAS.stringdefs		= txt_labels_font
Label_OSB2_symb_CAS.controllers		= {{"MSG_NoQuickLook"}}
Label_OSB2_symb_CAS.parent_element	= Label_OSB2.name
Label_OSB2_symb_CAS.init_pos		= {-26.5}
Add(Label_OSB2_symb_CAS)
use_mipfilter(Label_OSB2_symb_CAS)

addOSB_Box(2, {Label_OSB2, Label_OSB2_symb_CAS})
add_osb_static_hint(2, _("Message type"))

add_dummy_boxes({3})

Label_OSB9_IP							= CreateElement "ceStringPoly"
Label_OSB9_IP.name						= "Label_OSB9_IP"
Label_OSB9_IP.material					= font_MFCD
Label_OSB9_IP.alignment					= "RightCenter"
Label_OSB9_IP.value						= "IP"
Label_OSB9_IP.controllers				= {{"MSG_IsMessage", 1}}
Label_OSB9_IP.stringdefs				= txt_labels_font
shift_button_pos(Label_OSB9_IP, 9, -OSB_label_spacing, 0)
Add(Label_OSB9_IP)
use_mipfilter(Label_OSB9_IP)

Label_OSB9_symb_IP						= CreateElement "ceStringPoly"
Label_OSB9_symb_IP.name					= "Label_OSB9_symb_IP"
Label_OSB9_symb_IP.alignment			= "CenterCenter"
Label_OSB9_symb_IP.value				= DATA_ENTRY
Label_OSB9_symb_IP.material		        = font_MFCD
Label_OSB9_symb_IP.stringdefs		    = txt_labels_font
Label_OSB9_symb_IP.controllers			= {{"MSG_NoQuickLook"}}
Label_OSB9_symb_IP.parent_element 		= Label_OSB9_IP.name
Label_OSB9_symb_IP.init_pos				= {OSB_label_spacing}
Add(Label_OSB9_symb_IP)
use_mipfilter(Label_OSB9_symb_IP)

addOSB_Box(9, {Label_OSB9_IP, Label_OSB9_symb_IP})
--add_osb_static_hint(9, _("Message destination"))

Label_OSB10_TGT							= Copy(Label_OSB9_IP)
Label_OSB10_TGT.name					= "Label_OSB10_TGT"
Label_OSB10_TGT.value					= "TGT"
Label_OSB10_TGT.controllers				= {{"MSG_IsMessage", 1}}
shift_button_pos(Label_OSB10_TGT, 10, -OSB_label_spacing, 0)
Add(Label_OSB10_TGT)

Label_OSB10_symb_TGT					= Copy(Label_OSB9_symb_IP)
Label_OSB10_symb_TGT.name				= "Label_OSB10_symb_TGT"
Label_OSB10_symb_TGT.controllers		= {{"MSG_NoQuickLook"}}
Label_OSB10_symb_TGT.parent_element 	= Label_OSB10_TGT.name
Add(Label_OSB10_symb_TGT)

addOSB_Box(10, {Label_OSB10_TGT, Label_OSB10_symb_TGT})
--add_osb_static_hint(9, _("Message destination"))

Label_OSB17							= CreateElement "ceStringPoly"
Label_OSB17.name					= "Label_OSB17"
Label_OSB17.material				= font_MFCD
Label_OSB17.alignment				= "LeftCenter"
Label_OSB17.formats					= {"CC", "CC\n%s"}
Label_OSB17.controllers				= {{"MSG_IsMessage", 1}, {"MSG_MsgCopyTxt"}}
Label_OSB17.stringdefs				= txt_labels_font
shift_button_pos(Label_OSB17, 17, OSB_label_spacing, 0)
Add(Label_OSB17)
use_mipfilter(Label_OSB17)

Label_OSB17_symb					= CreateElement "ceStringPoly"
Label_OSB17_symb.name				= "Label_OSB17_symb"
Label_OSB17_symb.alignment			= "CenterCenter"
Label_OSB17_symb.value				= DATA_ENTRY
Label_OSB17_symb.material		    = font_MFCD
Label_OSB17_symb.stringdefs		    = txt_labels_font
Label_OSB17_symb.controllers		= {{"MSG_NoQuickLook"}}
Label_OSB17_symb.parent_element 	= Label_OSB17.name
Label_OSB17_symb.init_pos			= {-OSB_label_spacing}
Add(Label_OSB17_symb)
use_mipfilter(Label_OSB17_symb)

addOSB_Box(17, {Label_OSB17, Label_OSB17_symb})
--add_osb_static_hint(17, _("Message destination"))

MSG_TextPlacer					= CreateElement "ceSimple"
MSG_TextPlacer.name				= "MSG_TextPlacer1"
MSG_TextPlacer.init_pos			= {120, 502}
SetLowerLeftCornerOrigin(MSG_TextPlacer)
Add(MSG_TextPlacer)

MSG_TextNumerics				= CreateElement "ceStringPoly"
MSG_TextNumerics.name			= "MSG_TextNumerics"
MSG_TextNumerics.value			= 
"1:\n"..
"2:\n"..
"3:\n"..
"4:\n"..
"5:\n"..
"6:\n"..
"7:\n"..
"8:\n"..
"9:"
MSG_TextNumerics.alignment		= "LeftTop"
MSG_TextNumerics.material		= font_MFCD
MSG_TextNumerics.stringdefs		= txt_labels_font
MSG_TextNumerics.parent_element = MSG_TextPlacer.name
MSG_TextNumerics.init_pos		= {40, 0}
MSG_TextNumerics.controllers	= {{"MSG_IsMessage", 1}}
Add(MSG_TextNumerics)
use_mipfilter(MSG_TextNumerics)

MSG_TextCAS						= CreateElement "ceStringPoly"
MSG_TextCAS.name				= "MSG_TextCAS"
MSG_TextCAS.alignment			= "LeftTop"
MSG_TextCAS.material			= font_MFCD
MSG_TextCAS.stringdefs			= txt_labels_font
MSG_TextCAS.parent_element 		= MSG_TextPlacer.name
MSG_TextCAS.init_pos			= {40, 0}
MSG_TextCAS.controllers			= {{"MSG_IsMessage", 1}, {"MSG_TextContent"}}
Add(MSG_TextCAS)
use_mipfilter(MSG_TextCAS)
