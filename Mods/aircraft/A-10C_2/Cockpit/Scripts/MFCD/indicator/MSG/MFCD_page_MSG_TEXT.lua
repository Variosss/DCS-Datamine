dofile(LockOn_Options.script_path.."MFCD//indicator//MSG//MFCD_page_MSG_J28_2.lua")
--[[
Label_OSB2							= CreateElement "ceStringPoly"
Label_OSB2.name						= "Label_OSB2"
Label_OSB2.material					= font_MFCD
Label_OSB2.alignment				= "CenterTop"
Label_OSB2.value					= "TEXT"
Label_OSB2.stringdefs				= txt_labels_font
shift_button_pos(Label_OSB2, 2, 0)
Add(Label_OSB2)
use_mipfilter(Label_OSB2)


Label_OSB2_symb_TEXT				= CreateElement "ceStringPoly"
Label_OSB2_symb_TEXT.name			= "Label_OSB2_symb_TEXT"
Label_OSB2_symb_TEXT.alignment		= "LeftTop"
Label_OSB2_symb_TEXT.value			= ROTARY
Label_OSB2_symb_TEXT.material		= font_MFCD
Label_OSB2_symb_TEXT.stringdefs		= txt_labels_font
Label_OSB2_symb_TEXT.controllers	= {{"MSG_NoQuickLook"}}
Label_OSB2_symb_TEXT.parent_element = Label_OSB2.name
Label_OSB2_symb_TEXT.init_pos		= {-32}
Add(Label_OSB2_symb_TEXT)
use_mipfilter(Label_OSB2_symb_TEXT)

addOSB_Box(2, {Label_OSB2, Label_OSB2_symb_TEXT})
add_osb_static_hint(2, _("Message type"))



Label_OSB3_TN						= Copy(Label_OSB2)
Label_OSB3_TN.name					= "Label_OSB3_TN"
Label_OSB3_TN.value					= "TN"
Label_OSB3_TN.controllers			= {{"MSG_IsMessage", 1}, {"MSG_TEXT_DestType", 0}}
shift_button_pos(Label_OSB3_TN, 3, 0)
Add(Label_OSB3_TN)

Label_OSB3_TN_symb					= Copy(Label_OSB2_symb_TEXT)
Label_OSB3_TN_symb.name				= "Label_OSB3_TN_symb"
Label_OSB3_TN_symb.controllers		= {{"MSG_NoQuickLook"}}
Label_OSB3_TN_symb.parent_element   = Label_OSB3_TN.name
Label_OSB3_TN_symb.init_pos			= {-22}
Add(Label_OSB3_TN_symb)

Label_OSB3_NET						= Copy(Label_OSB2)
Label_OSB3_NET.name					= "Label_OSB3_NET"
Label_OSB3_NET.value				= "NET"
Label_OSB3_NET.controllers			= {{"MSG_IsMessage", 1}, {"MSG_TEXT_DestType", 1}}
shift_button_pos(Label_OSB3_NET, 3, 0)
Add(Label_OSB3_NET)

Label_OSB3_NET_symb					= Copy(Label_OSB2_symb_TEXT)
Label_OSB3_NET_symb.name			= "Label_OSB3_NET_symb"
Label_OSB3_NET_symb.controllers		= {{"MSG_NoQuickLook"}}
Label_OSB3_NET_symb.parent_element  = Label_OSB3_NET.name
Label_OSB3_NET_symb.init_pos		= {-26.5}
Add(Label_OSB3_NET_symb)

addOSB_Box(3, {Label_OSB3_TN, Label_OSB3_NET, Label_OSB3_TN_symb, Label_OSB3_NET_symb})
--add_osb_static_hint(3, _("Message type"))
--]]

--[[
Scrollers_9_10 = addScrollers(9, 10, -5,
	{{"MSG_NoQuickLook"}, {"MSG_IsMessage", 1}, {"MSG_MoreThanOnePages"}},
	{{"MSG_NoQuickLook"}, {"MSG_IsMessage", 1}, {"MSG_MoreThanOnePages"}})

add_osb_hint_controllers(9, _("Page navigation"),
	{{"MSG_NoQuickLook"}, {"MSG_IsMessage", 1}, {"MSG_MoreThanOnePages"}})
add_osb_hint_controllers(10, _("Page navigation"),
	{{"MSG_NoQuickLook"}, {"MSG_IsMessage", 1}, {"MSG_MoreThanOnePages"}})

addOSB_Box(9, {Scrollers_9_10[3]})
addOSB_Box(10, {Scrollers_9_10[4]})

PageNum				= CreateElement "ceStringPoly"
PageNum.name		= "PageNum"
PageNum.alignment	= "RightCenter"
PageNum.formats		= {"PAGE\n%d/%d"}
PageNum.material	= font_MFCD
PageNum.stringdefs	= txt_labels_font
PageNum.init_pos	= {OSB_positions[9][1]+13, (OSB_positions[9][2]+OSB_positions[10][2])/2}
PageNum.controllers	= {{"MSG_IsMessage", 1}, {"MSG_TextPagesNum"}}
Add(PageNum)
SetLowerLeftCornerOrigin(PageNum)
use_mipfilter(PageNum)
--]]

MSG_TextPlacer					= CreateElement "ceSimple"
MSG_TextPlacer.name				= "MSG_TextPlacer1"
MSG_TextPlacer.init_pos			= {120, 502}
SetLowerLeftCornerOrigin(MSG_TextPlacer)
Add(MSG_TextPlacer)

MSG_Text						= CreateElement "ceStringPoly"
MSG_Text.name					= "MSG_Text"
MSG_Text.alignment				= "LeftTop"
MSG_Text.material				= font_MFCD
MSG_Text.stringdefs				= txt_labels_font
MSG_Text.parent_element 		= MSG_TextPlacer.name
MSG_Text.init_pos				= {40, 0}
MSG_Text.controllers			= {{"MSG_IsMessage", 1}, {"MSG_TextContent"}}
Add(MSG_Text)
use_mipfilter(MSG_Text)
--[[
txt_CharRem						= CreateElement "ceStringPoly"
txt_CharRem.name				= "txt_CharRem"
txt_CharRem.material			= font_MFCD
txt_CharRem.alignment			= "LeftCenter"
txt_CharRem.init_pos			= {158, 114}
SetLowerLeftCornerOrigin(txt_CharRem)
txt_CharRem.stringdefs			= txt_labels_font
txt_CharRem.formats				= {"CHAR REM: %d"}
txt_CharRem.controllers			= {{"MSG_IsMessage", 1}, 
									{"MSG_CurrentMsgStatus", MsgStatus.PEND},
									{"MSG_CharsRemaining"}}
Add(txt_CharRem)
use_mipfilter(txt_CharRem) 
--]]

add_dummy_boxes({4, 5, 7, 8, 9, 10, 15, 16})
