dofile(LockOn_Options.script_path.."MFCD/indicator/MFCD_useful_definitions.lua")

TxtHOTASVShift		   = 20
TxtHOTASHShift		   = 0

CaptionVShift	   = -90.0
CaptionHShift	   = -225.0

ActionVShift	   = -170.0

Label_OSB18							= CreateElement "ceStringPoly"
Label_OSB18.name					= "Label_OSB18"
Label_OSB18.alignment				= "CenterCenter"
Label_OSB18.value					= SYS_ACTION
Label_OSB18.material				= font_MFCD
Label_OSB18.stringdefs				= txt_labels_font
Label_OSB18.UseBackground			= false
Label_OSB18.BackgroundMaterial		= MFCD_SOLID_BLACK
Label_OSB18.controllers				= {{"Hotas_Test_Page",0}}
shift_button_pos(Label_OSB18, 18, -OSB_label_spacing, 0)
Add(Label_OSB18)
use_mipfilter(Label_OSB18)

Label_OSB18_text					= CreateElement "ceStringPoly"
Label_OSB18_text.name				= "LABEL_OSB18_TEXT"
Label_OSB18_text.alignment			= "LeftCenter"
Label_OSB18_text.value				= "ABORT"
Label_OSB18_text.material			= font_MFCD
Label_OSB18_text.stringdefs			= txt_labels_font
Label_OSB18_text.UseBackground		= false
Label_OSB18_text.BackgroundMaterial	= MFCD_SOLID_BLACK
Label_OSB18_text.controllers		= {{"Hotas_Test_Page",0}}

shift_button_pos(Label_OSB18_text, 18, OSB_label_spacing, 0)
Add(Label_OSB18_text)
use_mipfilter(Label_OSB18_text)

addOSB_Box(18, {Label_OSB18, Label_OSB18_text})
add_osb_hint_controllers(18, _("Abort HOTAS test"), nil)
--------------------------------------------------------------------------------------
Label_OSB17							= CreateElement "ceStringPoly"
Label_OSB17.name					= "Label_OSB17"
Label_OSB17.alignment				= "CenterCenter"
Label_OSB17.value					= SYS_ACTION
Label_OSB17.material				= font_MFCD
Label_OSB17.stringdefs				= txt_labels_font
Label_OSB17.UseBackground			= false
Label_OSB17.BackgroundMaterial		= MFCD_SOLID_BLACK
Label_OSB17.controllers				= {{"Hotas_Test_Page",0}}
shift_button_pos(Label_OSB17, 17, -OSB_label_spacing, 0)
Add(Label_OSB17)
use_mipfilter(Label_OSB17)

Label_OSB17_text					= CreateElement "ceStringPoly"
Label_OSB17_text.name				= "Label_OSB17_text"
Label_OSB17_text.alignment			= "LeftCenter"
Label_OSB17_text.value				= "FAULT"
Label_OSB17_text.material			= font_MFCD
Label_OSB17_text.stringdefs			= txt_labels_font
Label_OSB17_text.UseBackground		= false
Label_OSB17_text.BackgroundMaterial	= MFCD_SOLID_BLACK
Label_OSB17_text.controllers		= {{"Hotas_Test_Page",0}}

shift_button_pos(Label_OSB17_text, 17, OSB_label_spacing, 0)
Add(Label_OSB17_text)
use_mipfilter(Label_OSB17_text)

addOSB_Box(17, {Label_OSB17, Label_OSB17_text})
add_osb_hint_controllers(17, _("Fault HOTAS test"), nil)
--------------------------------------------------------------------------------------
Label_OSB16							= CreateElement "ceStringPoly"
Label_OSB16.name					= "Label_OSB16"
Label_OSB16.alignment				= "CenterCenter"
Label_OSB16.value					= ""
Label_OSB16.material				= font_MFCD
Label_OSB16.stringdefs				= txt_labels_font
Label_OSB16.UseBackground			= false
Label_OSB16.BackgroundMaterial		= MFCD_SOLID_BLACK
Label_OSB16.controllers				= {{"Hotas_Test_Page",0}}
shift_button_pos(Label_OSB16, 16, -OSB_label_spacing, 0)
Add(Label_OSB16)
use_mipfilter(Label_OSB16)

Label_OSB16_text					= CreateElement "ceStringPoly"
Label_OSB16_text.name				= "Label_OSB16_text"
Label_OSB16_text.alignment			= "LeftCenter"
Label_OSB16_text.value				= "CAL"
Label_OSB16_text.material			= font_MFCD
Label_OSB16_text.stringdefs			= txt_labels_font
Label_OSB16_text.UseBackground		= false
Label_OSB16_text.BackgroundMaterial	= MFCD_SOLID_BLACK
Label_OSB16_text.controllers		= {{"Hotas_Test_Page",0}}

shift_button_pos(Label_OSB16_text, 16, OSB_label_spacing, 0)
Add(Label_OSB16_text)
use_mipfilter(Label_OSB16_text)

addOSB_Box(16, {Label_OSB16, Label_OSB16_text})
add_osb_hint_controllers(16, _("CAL HOTAS test"), nil)
--------------------------------------------------------------------------------------
txt_HOTAS						= CreateElement "ceStringPoly"
txt_HOTAS.name					= "txt_HOTAS"
txt_HOTAS.material				= font_MFCD
txt_HOTAS.alignment				= "CenterCenter"
txt_HOTAS.value					= "HOTAS SWITCH\nTEST"
txt_HOTAS.init_pos				= {max_pixels_count/2+TxtHOTASHShift,OSB_positions[19][2]+TxtHOTASVShift,0}
SetLowerLeftCornerOrigin(txt_HOTAS)
txt_HOTAS.stringdefs			= predefined_fonts[3]

Add(txt_HOTAS)
use_mipfilter(txt_HOTAS)

HOTAS_Undl					= CreateElement "ceStringPoly"
HOTAS_Undl.name				= "HOTAS_Undl"
HOTAS_Undl.alignment		= "CenterCenter"
HOTAS_Undl.value			= "____________\n____"
HOTAS_Undl.material			= font_MFCD
HOTAS_Undl.stringdefs		= predefined_fonts[3]
HOTAS_Undl.parent_element	= "txt_HOTAS"
Add(HOTAS_Undl)
use_mipfilter(HOTAS_Undl)
------------------------------------------------------------------
txt_HOTAS_caption				= CreateElement "ceStringPoly"
txt_HOTAS_caption.name			= "txt_HOTAS_caption"
txt_HOTAS_caption.material		= font_MFCD
txt_HOTAS_caption.alignment		= "LeftTop"
txt_HOTAS_caption.value			= "WARNING\nONE OF THE FOLLOWING ERRORS DETECTED:\n"..
"  1.ARMED CONDITION DETECTED\n"..
"     -PLACE MASTER ARM SWITCH IN SAFE\n"..
"     -PLACE ARM GND SAFETY SWITCH IN SAFE\n"..
"  2.CICU FAILURE DETECTED\n"..
"	  -PERFORM CICU TROUBLESHOOTING\n\n"..
"HOTAS TESTING WILL BE ABORTED\nPRESS ANY OSB TO CONTINUE"
txt_HOTAS_caption.parent_element = "txt_HOTAS"
txt_HOTAS_caption.init_pos		= {CaptionHShift,CaptionVShift,0}
txt_HOTAS_caption.stringdefs	= predefined_fonts[1]
txt_HOTAS_caption.controllers	= {{"Hotas_Test_Page",1}}

Add(txt_HOTAS_caption)
use_mipfilter(txt_HOTAS_caption)
---------------------------------------------------------------------
-- Actions

txt_action				= CreateElement "ceStringPoly"
txt_action.name			= "txt_action"
txt_action.material		= font_MFCD
txt_action.alignment	= "CenterTop"
txt_action.parent_element = "txt_HOTAS"
txt_action.formats		= {
						   "STICK: PRESS DMS SW FWD", 
						   "STICK: PRESS DMS SW AFT",
						   "STICK: PRESS DMS SW LEFT",
						   "STICK: PRESS DMS SW RIGHT",
						   "STICK: PRESS TMS SW FWD",
						   "STICK: PRESS TMS SW AFT",
						   "STICK: PRESS TMS SW LEFT",
						   "STICK: PRESS TMS SW RIGHT",
						   "STICK: PRESS CMS SW FWD",
						   "STICK: PRESS CMS SW AFT",
						   "STICK: PRESS CMS SW LEFT",
						   "STICK: PRESS CMS SW RIGHT",
						   "STICK: PRESS WRB SW",
						   "STICK: PRESS TRIM SW UP",
						   "STICK: PRESS TRIM SW DOWN",
						   "STICK: PRESS TRIM SW LEFT",
						   "STICK: PRESS TRIM SW RIGHT",
						   "STICK: PRESS TRIGGER FS SW",
						   "STICK: PRESS TRIGGER SS SW",
						   "STICK: PRESS NWS SW",
						   "STICK: PRESS MMCB SW",
						   --throttle
						   "THROTTLE: PRESS MIC SW FWD",
						   "THROTTLE: PRESS MIC SW AFT",
						   "THROTTLE: PRESS MIC SW UP",
						   "THROTTLE: PRESS MIC SW DOWN",
						   "THROTTLE: PRESS SB SW FWD",
						   "THROTTLE: PRESS SB SW AFT",
						   "THROTTLE: PRESS BS SW FWD",
						   "THROTTLE: PRESS BS SW AFT",
						   "THROTTLE: PRESS CH SW FWD",
						   "THROTTLE: PRESS CH SW AFT",
						   "THROTTLE: PRESS PINKY SW FWD",
						   "THROTTLE: PRESS PINKY SW AFT",
						   "THROTTLE: PRESS LTB SW",
						  -- "THROTTLE: PRESS SLEEW SW FWD",
						  -- "THROTTLE: PRESS SLEEW SW AFT",
						  -- "THROTTLE: PRESS SLEEW SW LEFT",
						  -- "THROTTLE: PRESS SLEEW SW RIGHT",
						   "THROTTLE: PRESS COOLIE SW FWD",
						   "THROTTLE: PRESS COOLIE SW AFT",
						   "THROTTLE: PRESS COOLIE SW LEFT",
						   "THROTTLE: PRESS COOLIE SW RIGHT",
						   --AHCP
						   "AHCP: TOGGLE LASER ARM",
						   "AHCP: TOGGLE LASER TRAIN",
						   "AHCP: TOGGLE LASER SAFE",
						   "AHCP: TOGGLE TGP ON",
						   "AHCP: TOGGLE TGP OFF",
						   "AHCP: TOGGLE JTRS ON",
						   "AHCP: TOGGLE JTRS OFF",
						   }
txt_action.controllers	= {{"Hotas_Test_Page",0},{"Hotas_Test_Action"}}
txt_action.init_pos		= {0,ActionVShift,0}
txt_action.stringdefs	= predefined_fonts[1]

Add(txt_action)
use_mipfilter(txt_action)

