dofile(LockOn_Options.script_path.."MFCD/indicator/STAT/MFCD_STAT_definitions.lua")

add_dummy_boxes({2, 3, 4})

Label_OSB5						= CreateElement "ceStringPoly"
Label_OSB5.name					= "Label_OSB5"
Label_OSB5.material				= font_MFCD
Label_OSB5.UseBackground		= false
Label_OSB5.BackgroundMaterial	= MFCD_SOLID_BLACK
Label_OSB5.alignment			= "CenterTop"
Label_OSB5.value				= SYS_ACTION
Label_OSB5.stringdefs			= txt_labels_font
Label_OSB5.controllers			= {{"STAT_WsChkIsAvailable"}}
shift_button_pos(Label_OSB5, 5, -22)
Add(Label_OSB5)
use_mipfilter(Label_OSB5)

Label_OSB5_text						= CreateElement "ceStringPoly"
Label_OSB5_text.name				= "Label_OSB5_text"
Label_OSB5_text.material			= font_MFCD
Label_OSB5_text.UseBackground		= false
Label_OSB5_text.BackgroundMaterial	= MFCD_SOLID_BLACK
Label_OSB5_text.alignment			= "CenterTop"
Label_OSB5_text.value				= "WS\nCHK"
Label_OSB5_text.stringdefs			= txt_labels_font
shift_button_pos(Label_OSB5_text, 5, 0)
Add(Label_OSB5_text)
use_mipfilter(Label_OSB5_text)

addOSB_Box(5, {Label_OSB5, Label_OSB5_text})
add_osb_static_hint(5, _("Weapon station check (No function)"))

Label_OSB6						= CreateElement "ceStringPoly"
Label_OSB6.name					= "Label_OSB6"
Label_OSB6.alignment			= "CenterCenter"
Label_OSB6.value				= SYS_ACTION
Label_OSB6.material				= font_MFCD
Label_OSB6.stringdefs			= txt_labels_font
Label_OSB6.UseBackground		= false
Label_OSB6.BackgroundMaterial	= MFCD_SOLID_BLACK
Label_OSB6.controllers			= {{"STAT_ResetIsApplicable"},{"STAT_ActionIsAvailable"}}
shift_button_pos(Label_OSB6, 6, -OSB_label_spacing,0)
Add(Label_OSB6)
use_mipfilter(Label_OSB6)

Label_OSB6_text						= CreateElement "ceStringPoly"
Label_OSB6_text.name				= "Label_OSB6_text"
Label_OSB6_text.alignment			= "RightCenter"
Label_OSB6_text.value				= "RESET"
Label_OSB6_text.material			= font_MFCD
Label_OSB6_text.stringdefs			= txt_labels_font
Label_OSB6_text.UseBackground		= false
Label_OSB6_text.BackgroundMaterial	= MFCD_SOLID_BLACK
Label_OSB6_text.controllers      	= {{"STAT_ResetIsApplicable"}}
shift_button_pos(Label_OSB6_text, 6, -2*OSB_label_spacing, 0)
Add(Label_OSB6_text)
use_mipfilter(Label_OSB6_text)

addOSB_Box(6, {Label_OSB6, Label_OSB6_text})
add_osb_hint_controllers(6, _("Reset LRU (No function)"), {{"STAT_ResetIsApplicable"}})

Label_OSB7_symbol						= CreateElement "ceStringPoly"
Label_OSB7_symbol.name					= "Label_OSB7_symbol"
Label_OSB7_symbol.alignment				= "CenterCenter"
Label_OSB7_symbol.formats				= {ROTARY, "*"}
Label_OSB7_symbol.material				= font_MFCD
Label_OSB7_symbol.stringdefs			= txt_labels_font
Label_OSB7_symbol.UseBackground			= false
Label_OSB7_symbol.BackgroundMaterial	= MFCD_SOLID_BLACK
Label_OSB7_symbol.controllers			= {{"STAT_PwrOnOffIsApplicable"}, {"STAT_PwrOnOffIsAvailable"},
										   {"STAT_PwrOnOffOSB_Symbol"}}
shift_button_pos(Label_OSB7_symbol, 7, -1 * OSB_label_spacing,0)
Add(Label_OSB7_symbol)
use_mipfilter(Label_OSB7_symbol)

Label_OSB7							= CreateElement "ceStringPoly"
Label_OSB7.name						= "Label_OSB7"
Label_OSB7.alignment				= "RightCenter"
Label_OSB7.formats					= {"PWR\nOFF", "PWR\nON"}
Label_OSB7.material					= font_MFCD
Label_OSB7.stringdefs				= txt_labels_font
Label_OSB7.UseBackground			= false
Label_OSB7.BackgroundMaterial		= MFCD_SOLID_BLACK
Label_OSB7.controllers				= {{"STAT_PwrOnOffIsApplicable"}, {"STAT_PwrOnOffLabel"}}
shift_button_pos(Label_OSB7, 7, -3 * OSB_label_spacing,0)
Add(Label_OSB7)
use_mipfilter(Label_OSB7)

addOSB_Box(7, {Label_OSB7_symbol, Label_OSB7})
add_osb_hint_controllers(7, _("LRU power On/Off"), {{"STAT_PwrOnOffIsApplicable"}})

Label_OSB8							= CreateElement "ceStringPoly"
Label_OSB8.name						= "Label_OSB8"
Label_OSB8.alignment				= "CenterCenter"
Label_OSB8.value					= DATA_ENTRY
Label_OSB8.material					= font_MFCD
Label_OSB8.stringdefs				= txt_labels_font
Label_OSB8.UseBackground			= false
Label_OSB8.BackgroundMaterial		= MFCD_SOLID_BLACK
Label_OSB8.controllers       		= {{"STAT_Current_LRU", LRU_HOTAS_THRTL}}
shift_button_pos(Label_OSB8, 8, -1 * OSB_label_spacing, 0)
Add(Label_OSB8)
use_mipfilter(Label_OSB8)

Label_OSB8_text						= CreateElement "ceStringPoly"
Label_OSB8_text.name				= "Label_OSB8_text"
Label_OSB8_text.alignment			= "RightCenter"
Label_OSB8_text.formats				= {"SLEW\n%.1f"}
Label_OSB8_text.material			= font_MFCD
Label_OSB8_text.stringdefs			= txt_labels_font
Label_OSB8_text.UseBackground		= false
Label_OSB8_text.BackgroundMaterial	= MFCD_SOLID_BLACK
Label_OSB8_text.parent_element		= Label_OSB8.name 
Label_OSB8_text.init_pos			= {-2 * OSB_label_spacing, 0, 0}
Label_OSB8_text.controllers			= {{"STAT_THRTL_SlewValue"}}
Add(Label_OSB8_text)
use_mipfilter(Label_OSB8_text)

addOSB_Box(8, {Label_OSB8, Label_OSB8_text})
add_osb_hint_controllers(8, _("Adjust Rate of Throttle Slew Switch"), {{"STAT_Current_LRU", LRU_HOTAS_THRTL}})
addOSB_Box(9)

Label_OSB10_symbol							= CreateElement "ceStringPoly"
Label_OSB10_symbol.name						= "Label_OSB10_symbol"
Label_OSB10_symbol.alignment				= "CenterCenter"
Label_OSB10_symbol.value					= ROTARY
Label_OSB10_symbol.material					= font_MFCD
Label_OSB10_symbol.stringdefs				= txt_labels_font
Label_OSB10_symbol.UseBackground			= false
Label_OSB10_symbol.BackgroundMaterial		= MFCD_SOLID_BLACK
Label_OSB10_symbol.controllers				= {{"STAT_StandardMFL", LRU_CDU, 0}}
shift_button_pos(Label_OSB10_symbol, 10, -1*OSB_label_spacing,0)
Add(Label_OSB10_symbol)
use_mipfilter(Label_OSB10_symbol)

Label_OSB10						= CreateElement "ceStringPoly"
Label_OSB10.name				= "Label_OSB10"
Label_OSB10.alignment			= "RightCenter"
Label_OSB10.value				= "MFL\nFLT-1"
Label_OSB10.material			= font_MFCD
Label_OSB10.stringdefs			= txt_labels_font
Label_OSB10.UseBackground		= false
Label_OSB10.BackgroundMaterial	= MFCD_SOLID_BLACK
Label_OSB10.parent_element		= Label_OSB10_symbol.name 
Label_OSB10.init_pos			= {-2 * OSB_label_spacing,0,0}
Add(Label_OSB10)
use_mipfilter(Label_OSB10)

addOSB_Box(10, {Label_OSB10_symbol, Label_OSB10})
add_osb_hint_controllers(10, _("Select Previous Maintenance Fault Log (No Function)"), {{"STAT_StandardMFL", LRU_CDU, 0}})

add_dummy_boxes({16, 17})

Label_OSB18							= CreateElement "ceStringPoly"
Label_OSB18.name					= "Label_OSB18"
Label_OSB18.alignment				= "CenterCenter"
Label_OSB18.value					= SYS_ACTION
Label_OSB18.material				= font_MFCD
Label_OSB18.stringdefs				= txt_labels_font
Label_OSB18.UseBackground			= false
Label_OSB18.BackgroundMaterial		= MFCD_SOLID_BLACK
Label_OSB18.controllers       		= {{"STAT_TestIsApplicable"}, {"STAT_ActionIsAvailable"}}
shift_button_pos(Label_OSB18, 18, -OSB_label_spacing, 0)
Add(Label_OSB18)
use_mipfilter(Label_OSB18)

Label_OSB18_text					= CreateElement "ceStringPoly"
Label_OSB18_text.name				= "LABEL_OSB18_TEXT"
Label_OSB18_text.alignment			= "LeftCenter"
Label_OSB18_text.value				= "TEST"
Label_OSB18_text.material			= font_MFCD
Label_OSB18_text.stringdefs			= txt_labels_font
Label_OSB18_text.UseBackground		= false
Label_OSB18_text.BackgroundMaterial	= MFCD_SOLID_BLACK
Label_OSB18_text.controllers      	= {{"STAT_TestIsApplicable"}}
shift_button_pos(Label_OSB18_text, 18, OSB_label_spacing, 0)
Add(Label_OSB18_text)
use_mipfilter(Label_OSB18_text)

addOSB_Box(18, {Label_OSB18, Label_OSB18_text})
add_osb_hint_controllers(18, _("Test LRU"), {{"STAT_TestIsApplicable"}})

Scrollers = addScrollers(20, 19, 5)
add_osb_static_hint(19, _("Cycle LRU/SRU Selection Down"))
add_osb_static_hint(20, _("Cycle LRU/SRU Selection Up"))

addOSB_Box(20, {Scrollers[3]})
addOSB_Box(19, {Scrollers[4]})

local function addLRU_Name(tbl, CursorPos, Value, Ctrlrs)
	tbl[CursorPos]				= CreateElement "ceStringPoly"
	tbl[CursorPos].alignment	= "LeftCenter"
	tbl[CursorPos].value		= tostring(Value)
	tbl[CursorPos].material		= font_MFCD
	tbl[CursorPos].stringdefs	= txt_labels_font
	tbl[CursorPos].init_pos		= {OSB_positions[19][1]-15,(OSB_positions[19][2]+OSB_positions[20][2])/2,0}
	tbl[CursorPos].controllers	= Ctrlrs
	Add(tbl[CursorPos])
	SetLowerLeftCornerOrigin(tbl[CursorPos])
	use_mipfilter(tbl[CursorPos])
end

Current_LRU_namesStatic = {}
for i = LRU_ALL, LRU_CICU_ALM do
	addLRU_Name(Current_LRU_namesStatic, i, LRU_names2[i], {{"STAT_Current_LRU", i}})
end

Current_LRU_namesDyn1 = {}
Current_LRU_namesDyn2 = {}
for i = LRU_1760_3, LRU_1760_9 do
	addLRU_Name(Current_LRU_namesDyn1, i, LRU_names2[i], {{"STAT_Current_LRU", i}, 
		{"STAT_LRU_State", i, STATUS_NA + STATUS_NC} })
	addLRU_Name(Current_LRU_namesDyn2, i, "JDAM"..LRU_stations[i], {{"STAT_Current_LRU", i},
		{"STAT_LRU_State", i, STATUS_OFF + STATUS_VALID + STATUS_INIT + STATUS_FAIL + STATUS_TEST + STATUS_DEGR} })
end

for i = LRU_TGP, LRU_EPLRS do
	addLRU_Name(Current_LRU_namesStatic, i, LRU_names2[i], {{"STAT_Current_LRU", i}})
end


Cursor						= CreateElement "ceStringPoly"
Cursor.name					= "SELECTED_ARROW"
Cursor.material				= font_MFCD
Cursor.UseBackground		= false
Cursor.BackgroundMaterial	= MFCD_SOLID_BLACK
Cursor.alignment			= "RightCenter"
Cursor.init_pos				= {TblCenterX - TblHalfWidth - 15, TblHdrTxtY - TblRowHeight,0}
Cursor.value				= BRANCH_L
Cursor.stringdefs			= predefined_fonts[2]
Cursor.controllers			= {{"STAT_Cursor", TblRowHeight}}
SetLowerLeftCornerOrigin(Cursor)
Add(Cursor)
use_mipfilter(Cursor)

TblHdrTxt_LRU					= CreateElement "ceStringPoly"
TblHdrTxt_LRU.name				= "TblHdrTxt_LRU"
TblHdrTxt_LRU.alignment			= "CenterCenter"
TblHdrTxt_LRU.value				= "LRU"
TblHdrTxt_LRU.material			= font_MFCD
TblHdrTxt_LRU.stringdefs		= predefined_fonts[1]
TblHdrTxt_LRU.init_pos			= {TblCenterX - TblHdrTxtOffsetX, TblHdrTxtY, 0}
Add(TblHdrTxt_LRU)
SetLowerLeftCornerOrigin(TblHdrTxt_LRU)
use_mipfilter(TblHdrTxt_LRU)

TblHdrTxt_STAT					= CreateElement "ceStringPoly"
TblHdrTxt_STAT.name				= "TblHdrTxt_STAT"
TblHdrTxt_STAT.alignment		= "CenterCenter"
TblHdrTxt_STAT.value			= "STAT"
TblHdrTxt_STAT.material			= font_MFCD
TblHdrTxt_STAT.stringdefs		= predefined_fonts[1]
TblHdrTxt_STAT.init_pos			= {TblCenterX, TblHdrTxtY, 0}
Add(TblHdrTxt_STAT)
SetLowerLeftCornerOrigin(TblHdrTxt_STAT)
use_mipfilter(TblHdrTxt_STAT)

TblHdrTxt_TEST					= CreateElement "ceStringPoly"
TblHdrTxt_TEST.name				= "TblHdrTxt_TEST"
TblHdrTxt_TEST.alignment		= "CenterCenter"
TblHdrTxt_TEST.value			= "TEST"
TblHdrTxt_TEST.material			= font_MFCD
TblHdrTxt_TEST.stringdefs		= predefined_fonts[1]
TblHdrTxt_TEST.init_pos			= {TblCenterX + TblHdrTxtOffsetX, TblHdrTxtY, 0}
Add(TblHdrTxt_TEST)
SetLowerLeftCornerOrigin(TblHdrTxt_TEST)
use_mipfilter(TblHdrTxt_TEST)

FaultLogHeader					= CreateElement "ceStringPoly"
FaultLogHeader.name				= "FaultLogHeader"
FaultLogHeader.alignment		= "LeftTop"
FaultLogHeader.value			= "MAINT FAULT LOG DISPLAY"
FaultLogHeader.material			= font_MFCD
FaultLogHeader.stringdefs		= predefined_fonts[1]
SetFaultLogPlacerAsParent(FaultLogHeader)
Add(FaultLogHeader)
use_mipfilter(FaultLogHeader)

FaultLogHeaderUndl					= CreateElement "ceStringPoly"
FaultLogHeaderUndl.name				= "FaultLogHeaderUndl"
FaultLogHeaderUndl.alignment		= "LeftTop"
FaultLogHeaderUndl.value			= "_______________________"
FaultLogHeaderUndl.material			= font_MFCD
FaultLogHeaderUndl.stringdefs		= predefined_fonts[1]
SetFaultLogPlacerAsParent(FaultLogHeaderUndl)
Add(FaultLogHeaderUndl)
use_mipfilter(FaultLogHeaderUndl)

MFL_Empty						= CreateElement "ceStringPoly"
MFL_Empty.name					= "MFL_Empty"
MFL_Empty.alignment				= "LeftTop"
MFL_Empty.value					= "MFL EMPTY"
MFL_Empty.material				= font_MFCD
MFL_Empty.stringdefs			= predefined_fonts[1]
SetFaultLogPlacerAsParent(MFL_Empty)
MFL_Empty.init_pos				= {0, -MFL_StringOffset, 0}
MFL_Empty.controllers			= {{"STAT_StandardMFL", LRU_CDU, 0}}
Add(MFL_Empty)
use_mipfilter(MFL_Empty)

MFL_NotAvail					= CreateElement "ceStringPoly"
MFL_NotAvail.name				= "MFL_NotAvail"
MFL_NotAvail.alignment			= "LeftTop"
MFL_NotAvail.value				= "MFL NOT AVAILABLE"
MFL_NotAvail.material			= font_MFCD
MFL_NotAvail.stringdefs			= predefined_fonts[1]
SetFaultLogPlacerAsParent(MFL_NotAvail)
MFL_NotAvail.init_pos			= {0, -MFL_StringOffset, 0}
MFL_NotAvail.controllers		= {{"STAT_StandardMFL", LRU_CDU, 1}}
Add(MFL_NotAvail)
use_mipfilter(MFL_NotAvail)
