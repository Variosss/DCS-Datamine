dofile(LockOn_Options.script_path.."MFCD/indicator/MFCD_useful_definitions.lua")

SelectedNoteVShift	   = -115.0
SelectedNoteHShift	   = -45.0

SelectedKeyHShift 	   = 60.0
SelectedKeyVShift	   = -5.0	

SelectedKeyUndlShift   = -5
SelectNoteVOffset 	   = -27

TestNoteShift  		   = -5

TxtBezelVShift		   = 20
TxtBezelHShift		   = 0

SelectRockersVOffset   = -67
SelectRockersHOffset   = -25

RockersSymVOffset		= -25
RockersSymHOffset		= -90

RockersHOffset			= 30

add_attitude_reference_symbol()

Label_OSB18							= CreateElement "ceStringPoly"
Label_OSB18.name					= "Label_OSB18"
Label_OSB18.alignment				= "CenterCenter"
Label_OSB18.value					= SYS_ACTION
Label_OSB18.material				= font_MFCD
Label_OSB18.stringdefs				= txt_labels_font
Label_OSB18.UseBackground			= false
Label_OSB18.BackgroundMaterial		= MFCD_SOLID_BLACK
Label_OSB18.isdraw					= true	
shift_button_pos(Label_OSB18, 18, -OSB_label_spacing, 0)
Add(Label_OSB18)
use_mipfilter(Label_OSB18)

Label_OSB18_text					= CreateElement "ceStringPoly"
Label_OSB18_text.name				= "LABEL_OSB18_TEXT"
Label_OSB18_text.alignment			= "LeftCenter"
Label_OSB18_text.value				= "EXIT"
Label_OSB18_text.material			= font_MFCD
Label_OSB18_text.stringdefs			= txt_labels_font
Label_OSB18_text.UseBackground		= false
Label_OSB18_text.BackgroundMaterial	= MFCD_SOLID_BLACK
shift_button_pos(Label_OSB18_text, 18, OSB_label_spacing, 0)
Add(Label_OSB18_text)
use_mipfilter(Label_OSB18_text)

addOSB_Box(18, {Label_OSB18, Label_OSB18_text})
add_osb_hint_controllers(18, _("Leave key test"), nil)
--------------------------------------------------------------------------------------
txt_BEZEL						= CreateElement "ceStringPoly"
txt_BEZEL.name					= "txt_BEZEL"
txt_BEZEL.material				= font_MFCD
txt_BEZEL.alignment				= "CenterCenter"
txt_BEZEL.value					= "MFCD BEZEL\nKEY TEST"
txt_BEZEL.init_pos				= {max_pixels_count/2+TxtBezelHShift,OSB_positions[19][2]+TxtBezelVShift,0}
SetLowerLeftCornerOrigin(txt_BEZEL)
txt_BEZEL.stringdefs			= predefined_fonts[3]

Add(txt_BEZEL)
use_mipfilter(txt_BEZEL)

BEZEL_Undl					= CreateElement "ceStringPoly"
BEZEL_Undl.name				= "BEZEL_Undl"
BEZEL_Undl.alignment		= "CenterCenter"
BEZEL_Undl.value			= "__________\n________"
BEZEL_Undl.material			= font_MFCD
BEZEL_Undl.stringdefs		= predefined_fonts[3]
BEZEL_Undl.parent_element	= "txt_BEZEL"
Add(BEZEL_Undl)
use_mipfilter(BEZEL_Undl)
--------------------------------------------------------------------------------------
txt_Selected_Key					= CreateElement "ceStringPoly"
txt_Selected_Key.name 				= "txt_Selected_Key"
txt_Selected_Key.material			= font_MFCD
txt_Selected_Key.alignment  		= "CenterCenter"
txt_Selected_Key.value				= "SELECTED KEY:"
txt_Selected_Key.stringdefs			= predefined_fonts[1]
txt_Selected_Key.parent_element		= "txt_BEZEL"
txt_Selected_Key.isdraw				= true
txt_Selected_Key.init_pos			= {SelectedNoteHShift,SelectedNoteVShift,0}

Add(txt_Selected_Key)
use_mipfilter(txt_Selected_Key)

Selected_Key_Undl				= CreateElement "ceStringPoly"
Selected_Key_Undl.name			= "Selected_Key_Undl"
Selected_Key_Undl.alignment		= "CenterBottom"
Selected_Key_Undl.value			= "____________"
Selected_Key_Undl.material			= font_MFCD
Selected_Key_Undl.stringdefs		= predefined_fonts[1]
Selected_Key_Undl.init_pos		= {SelectedNoteHShift+SelectedKeyUndlShift,-4,0}
Add(Selected_Key_Undl)
use_mipfilter(Selected_Key_Undl)

Selected_Key				= CreateElement "ceStringPoly"
Selected_Key.name 			= "Selected_Key"
Selected_Key.material		= font_MFCD
Selected_Key.formats		= {"NONE", "OSB1", "OSB2", "OSB3", "OSB4", "OSB5", "OSB6", "OSB7", "OSB8", "OSB9", "OSB10",
							"OSB11", "OSB12", "OSB13", "OSB14", "OSB15", "OSB16", "OSB17", "OSB18", "OSB19", "OSB20",}
Selected_Key.controllers	= {{"Key_Test_OSB_controller"}}
Selected_Key.stringdefs		= predefined_fonts[1]
Selected_Key.alignment  	= "CenterBottom"
Selected_Key.init_pos		= {SelectedKeyHShift,SelectedKeyVShift,0}

Add(Selected_Key)
use_mipfilter(Selected_Key)

----------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
Message_Selected_Key			= CreateElement "ceStringPoly"
Message_Selected_Key.name 		= "Message_Selected_Key"
Message_Selected_Key.material	= font_MFCD
Message_Selected_Key.alignment  = "CenterCenter"
Message_Selected_Key.value		= "SELECT ALL BEZEL KEYS\nVERIFY CORRECT DESCRIPTION"
Message_Selected_Key.stringdefs	= predefined_fonts[1]
Message_Selected_Key.isdraw				= true
Message_Selected_Key.init_pos			= {TestNoteShift,SelectNoteVOffset,0}

Add(Message_Selected_Key)
use_mipfilter(Message_Selected_Key)
-------------------------------------------------------------------------------------------
txt_Selected_Rockers			= CreateElement "ceStringPoly"
txt_Selected_Rockers.name 		= "txt_Selected_Rockers"
txt_Selected_Rockers.material	= font_MFCD
txt_Selected_Rockers.alignment  = "CenterCenter"
txt_Selected_Rockers.value		= "SELECTED ROCKERS:"
txt_Selected_Rockers.stringdefs	= predefined_fonts[1]
txt_Selected_Rockers.isdraw				= true
txt_Selected_Rockers.init_pos			= {SelectRockersHOffset,SelectRockersVOffset,0}

Add(txt_Selected_Rockers)
use_mipfilter(txt_Selected_Rockers)
-------------------------------------------------------------------------------------------
function add_rock_pos (name, h_pos, v_pos )
	rock_sym				= CreateElement "ceStringPoly"
	rock_sym.name			= "rock_sym"..name
	rock_sym.material		= font_MFCD
	rock_sym.alignment 		= "CenterCenter"
	rock_sym.value			= "*"
	rock_sym.stringdefs		= predefined_fonts[1]
	rock_sym.controllers	= {{"Key_Test_Rock_controller",h_pos*10+v_pos}}
	rock_sym.parent_element 	= "txt_Selected_Rockers"
	rock_sym.init_pos			= {RockersSymHOffset + (h_pos-1)*125 ,RockersSymVOffset*v_pos,0}

	Add(rock_sym)
	use_mipfilter(rock_sym)
	
	rock_txt				= CreateElement "ceStringPoly"
	rock_txt.name			= "rock_txt"..name
	rock_txt.material		= font_MFCD
	rock_txt.alignment 		= "CenterCenter"
	rock_txt.value			= name
	rock_txt.stringdefs		= predefined_fonts[1]
	rock_txt.isdraw			= true
	rock_txt.parent_element 	= "txt_Selected_Rockers"
	rock_txt.init_pos			= {RockersSymHOffset+RockersHOffset+(h_pos-1)*125 ,RockersSymVOffset*v_pos,0}

	Add(rock_txt)
	use_mipfilter(rock_txt)
end

add_rock_pos("ADJ+",1,1)
add_rock_pos("ADJ-",1,2)
add_rock_pos("CON+",1,3)
add_rock_pos("CON-",1,4)

add_rock_pos("DSP+",2,1)
add_rock_pos("DSP-",2,2)
add_rock_pos("BRT+",2,3)
add_rock_pos("BRT-",2,4)
add_rock_pos("SYM+",2,5)
add_rock_pos("SYM-",2,6)