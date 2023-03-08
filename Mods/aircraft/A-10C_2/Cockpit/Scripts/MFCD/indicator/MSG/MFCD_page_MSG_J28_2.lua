dofile(LockOn_Options.script_path.."MFCD//indicator//MSG//MFCD_page_MSG_definitions.lua")

--Enter text
Label_OSB6							= add_text_osb_position(6, "MOD\nTEXT")
Label_OSB6.controllers				= {{"MSG_CurrentMsgStatus", MsgStatus.PEND},
                                       --{"MSG_IsMessage", 1}
									   }

Label_OSB6_symb						= add_OSB_label(6, DATA_ENTRY)
Label_OSB6_symb.controllers			= {{"MSG_CurrentMsgStatus", MsgStatus.PEND}, {"MSG_ModText_Avail"}}

addOSB_Box(6, {Label_OSB6, Label_OSB6_symb})
add_osb_hint_controllers(6, _("Enter text"),
	{{"MSG_CurrentMsgStatus", MsgStatus.PEND}})

--Line scrollers
Scrollers_19_20 = addScrollers(20, 19, 5,
	{{"MSG_CurrentMsgStatus", MsgStatus.PEND}, {"MSG_MoreThanOneLines"}},
	{{"MSG_CurrentMsgStatus", MsgStatus.PEND}, {"MSG_MoreThanOneLines"}}
	)

OSB_Box_20 = addOSB_Box(20, {Scrollers_19_20[3]})
OSB_Box_20.controllers = {{"MSG_CurrentMsgStatus", MsgStatus.PEND}, {"pressed_OSB_status", 20 - 1, 1}}

OSB_Box_19 = addOSB_Box(19, {Scrollers_19_20[4]})
OSB_Box_19.controllers = {{"MSG_CurrentMsgStatus", MsgStatus.PEND}, {"pressed_OSB_status", 19 - 1, 1}}

LineTxt				= CreateElement "ceStringPoly"
LineTxt.name		= "LineTxt"
LineTxt.alignment	= "LeftCenter"
LineTxt.value		= "LINE"
LineTxt.material	= font_MFCD
LineTxt.stringdefs	= txt_labels_font
LineTxt.init_pos	= {OSB_positions[20][1]-13, (OSB_positions[20][2]+OSB_positions[19][2])/2}
LineTxt.controllers	= {{"MSG_CurrentMsgStatus", MsgStatus.PEND}
                       --{"MSG_IsMessage", 1}
					   }
Add(LineTxt)
SetLowerLeftCornerOrigin(LineTxt)
use_mipfilter(LineTxt)

--SEND MSG action
Label_OSB17_NEW						= add_text_osb_position(17, "SEND\nMSG")
Label_OSB17_NEW.controllers			= {{"MSG_CurrentMsgStatus", MsgStatus.PEND}}

Label_OSB17_symb_NEW					= add_OSB_label(17, SYS_ACTION)
Label_OSB17_symb_NEW.controllers		= {{"MSG_CurrentMsgStatus", MsgStatus.PEND}}

addOSB_Box(17, {Label_OSB17_NEW, Label_OSB17_symb_NEW})
add_osb_hint_controllers(17, _("Send message"),
	{{"MSG_CurrentMsgStatus", MsgStatus.PEND}})

--Destination
Label_OSB18							= add_text_osb_position(18, "")
Label_OSB18.formats					= {"TO", "TO\n%s"}
Label_OSB18.controllers				= {--{"MSG_IsMessage", 1},
                                       {"MSG_CurrentMsgStatus", MsgStatus.PEND},
                                       {"MSG_MsgDestinationTxt"}}

Label_OSB18_symb					= add_OSB_label(18, DATA_ENTRY)
Label_OSB18_symb.controllers		= {{"MSG_CurrentMsgStatus", MsgStatus.PEND}}

addOSB_Box(18, {Label_OSB18, Label_OSB18_symb})
add_osb_hint_controllers(18, _("Message destination"),
	{{"MSG_CurrentMsgStatus", MsgStatus.PEND}})

--Cursor
MSG_TextPlacer					= CreateElement "ceSimple"
MSG_TextPlacer.name				= "MSG_TextPlacer"
MSG_TextPlacer.init_pos			= {120, 502}
SetLowerLeftCornerOrigin(MSG_TextPlacer)
Add(MSG_TextPlacer)

Cursor							= CreateElement "ceStringPoly"
Cursor.name						= "SELECTED_ARROW"
Cursor.material					= font_MFCD
Cursor.alignment				= "RightCenter"
Cursor.parent_element 			= MSG_TextPlacer.name
Cursor.init_pos					= {10, -12}
Cursor.value					= BRANCH_L
Cursor.stringdefs				= predefined_fonts[2]
Cursor.controllers				= {{"MSG_IsMessage", 1}, 
                                   {"MSG_Cursor", 23.4}}
Add(Cursor)
use_mipfilter(Cursor)
