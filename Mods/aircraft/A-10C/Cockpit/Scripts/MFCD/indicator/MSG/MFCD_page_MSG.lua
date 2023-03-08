dofile(LockOn_Options.script_path.."MFCD//indicator//MSG//MFCD_page_MSG_definitions.lua")

-- NEW message
Label_OSB1							= CreateElement "ceStringPoly"
Label_OSB1.name						= "LABEL_OSB1"
Label_OSB1.material					= font_MFCD
Label_OSB1.alignment				= "LeftTop"
Label_OSB1.value					= "NEW"
--Label_OSB1.controllers				= {{"MSG_CurrentMsgStatusText"}}
Label_OSB1.stringdefs				= txt_labels_font
shift_button_pos(Label_OSB1, 1, -21)
Add(Label_OSB1)
use_mipfilter(Label_OSB1)

addOSB_Box(1, {Label_OSB1})
add_osb_static_hint(1, _("New message"))

Label_OSB1_inv					  = Copy(Label_OSB1)
Label_OSB1_inv.name			      = "Label_OSB1_inv"
Label_OSB1_inv.material		      = font_MFCD_BLACK
Label_OSB1_inv.UseBackground	  = true
Label_OSB1_inv.BackgroundMaterial = MFCD_SOLID_GREEN
Label_OSB1_inv.controllers		  = {
                                     {"MSG_CurrentMsgStatus", MsgStatus.PEND}
								    }
Add(Label_OSB1_inv)

-- RECEIVED MESSAGE
Label_OSB2							= CreateElement "ceStringPoly"
Label_OSB2.name						= "LABEL_OSB2"
Label_OSB2.material					= font_MFCD
Label_OSB2.alignment				= "LeftTop"
Label_OSB2.value					= "RCVD"
--Label_OSB1.controllers				= {{"MSG_CurrentMsgStatusText"}}
Label_OSB2.stringdefs				= txt_labels_font
shift_button_pos(Label_OSB2, 2, -21)
Add(Label_OSB2)
use_mipfilter(Label_OSB2)

addOSB_Box(2, {Label_OSB2})
add_osb_static_hint(2, _("Received messages"))

Label_OSB2_inv					  = Copy(Label_OSB2)
Label_OSB2_inv.name			      = "Label_OSB2_inv"
Label_OSB2_inv.material		      = font_MFCD_BLACK
Label_OSB2_inv.UseBackground	  = true
Label_OSB2_inv.BackgroundMaterial = MFCD_SOLID_GREEN
Label_OSB2_inv.controllers		  = {
                                     {"MSG_CurrentMsgStatus", MsgStatus.RCVD}
								    }
Add(Label_OSB2_inv)

--DELETE message (RCVD)
Label_OSB3_DEL							= CreateElement "ceStringPoly"
Label_OSB3_DEL.name						= "Label_OSB3_DEL"
Label_OSB3_DEL.material					= font_MFCD
Label_OSB3_DEL.alignment				= "CenterTop"
Label_OSB3_DEL.value					= SYS_ACTION.."DEL"
Label_OSB3_DEL.controllers				= {{"MSG_IsMessage", 1},
										{"MSG_CurrentMsgStatus", MsgStatus.RCVD}}
Label_OSB3_DEL.stringdefs				= txt_labels_font
shift_button_pos(Label_OSB3_DEL, 3, 0)
Add(Label_OSB3_DEL)
use_mipfilter(Label_OSB3_DEL)

-- CANCEL message (PEND)
Label_OSB3_CAN							= CreateElement "ceStringPoly"
Label_OSB3_CAN.name						= "Label_OSB3_CAN"
Label_OSB3_CAN.material					= font_MFCD
Label_OSB3_CAN.alignment				= "CenterTop"
Label_OSB3_CAN.value					= SYS_ACTION.."CAN"
Label_OSB3_CAN.controllers				= {--{"MSG_IsMessage", 1},
										{"MSG_CurrentMsgStatus", MsgStatus.PEND}}
Label_OSB3_CAN.stringdefs				= txt_labels_font
shift_button_pos(Label_OSB3_CAN, 3, 0)
Add(Label_OSB3_CAN)
use_mipfilter(Label_OSB3_CAN)

addOSB_Box(3, {Label_OSB3_CAN, Label_OSB3_DEL})

add_osb_hint_format_controllers(3, {_("Cancel message"), _("Delete message")}, {{"MSG_CurrentMsgPendOrRecv_hint", MsgStatus.PEND, MsgStatus.RCVD}})


Scrollers_20_19 = addScrollers(20, 19, 5,
	{{"MSG_CurrentMsgStatus", MsgStatus.RCVD}, --[[{"MSG_IsMessage", 1},--]] {"MSG_MoreThanOneMessages"}},
	{{"MSG_CurrentMsgStatus", MsgStatus.RCVD}, --[[{"MSG_IsMessage", 1},--]] {"MSG_MoreThanOneMessages"}})

	
add_osb_hint_format_controllers(20, {_("Lines navigation"), _("Message navigation")}, 
{{"MSG_CurrentMsgPendOrRecvScrols_hint", MsgStatus.PEND, MsgStatus.RCVD}})

add_osb_hint_format_controllers(19, {_("Lines navigation"), _("Message navigation")}, 
{{"MSG_CurrentMsgPendOrRecvScrols_hint", MsgStatus.PEND, MsgStatus.RCVD}})


OSB_Box_20 = addOSB_Box(20, {Scrollers_20_19[3]})
OSB_Box_20.controllers = {{"MSG_CurrentMsgStatus", MsgStatus.RCVD}, {"pressed_OSB_status", 20 - 1, 1}}

OSB_Box_19 = addOSB_Box(19, {Scrollers_20_19[4]})
OSB_Box_19.controllers = {{"MSG_CurrentMsgStatus", MsgStatus.RCVD}, {"pressed_OSB_status", 19 - 1, 1}}

--MSG number
MSG_num				= CreateElement "ceStringPoly"
MSG_num.name		= "MSG_num"
MSG_num.alignment	= "LeftCenter"
MSG_num.formats		= {"MSG\nP/%d", "MSG\n%d/%d"}
MSG_num.material	= font_MFCD
MSG_num.stringdefs	= txt_labels_font
MSG_num.init_pos	= {OSB_positions[19][1]-10, (OSB_positions[19][2]+OSB_positions[20][2])/2}
MSG_num.controllers	= {{"MSG_CurrentMsgStatus", MsgStatus.RCVD}, {"MSG_IsMessage", 1}, {"MSG_MessagesNum"}}
Add(MSG_num)
SetLowerLeftCornerOrigin(MSG_num)
use_mipfilter(MSG_num)

-- NO MESSAGE
txt_NO_MESSAGE							= CreateElement "ceStringPoly"
txt_NO_MESSAGE.name						= "txt_NO_MESSAGE"
txt_NO_MESSAGE.material					= font_MFCD
txt_NO_MESSAGE.alignment				= "CenterCenter"
txt_NO_MESSAGE.init_pos					= {max_pixels_count/2, OSB_positions[19][2] + (OSB_positions[20][2] - OSB_positions[19][2]) * 0.5, 0}
SetLowerLeftCornerOrigin(txt_NO_MESSAGE)
txt_NO_MESSAGE.stringdefs				= predefined_fonts[4]
txt_NO_MESSAGE.value = "NO MESSAGE"
txt_NO_MESSAGE.controllers				= {{"MSG_CurrentMsgStatus", MsgStatus.RCVD}, {"MSG_IsMessage", 0}}
Add(txt_NO_MESSAGE)
use_mipfilter(txt_NO_MESSAGE) 

-- FROM
txt_From						= add_text_osb_position(18, "")
txt_From.formats				= {"FRM\n%s"}
txt_From.controllers			= {{"MSG_IsMessage", 1},
								   {"MSG_CurrentMsgStatus", MsgStatus.RCVD},
								   {"MSG_TransferDetails"}}

addConfirmation("MSG_Deletion", {{"MSG_ConfirmDeletionTxt"}}, ConfrmTxt_1, ConfrmBack)
