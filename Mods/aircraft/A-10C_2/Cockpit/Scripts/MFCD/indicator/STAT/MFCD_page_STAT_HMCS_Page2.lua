dofile(LockOn_Options.script_path.."MFCD/indicator/MFCD_useful_definitions.lua")

-- PREV label

Label_OSB1_symbol						= CreateElement "ceStringPoly"
Label_OSB1_symbol.name					= "Label_OSB1_symbol"
Label_OSB1_symbol.alignment				= "CenterTop"
Label_OSB1_symbol.value					= BRANCH_L
Label_OSB1_symbol.material				= font_MFCD
Label_OSB1_symbol.stringdefs			= txt_labels_font
Label_OSB1_symbol.UseBackground			= false
Label_OSB1_symbol.BackgroundMaterial	= MFCD_SOLID_BLACK
shift_button_pos(Label_OSB1_symbol, 1, -27)
Add(Label_OSB1_symbol)
use_mipfilter(Label_OSB1_symbol)

Label_OSB1								= CreateElement "ceStringPoly"
Label_OSB1.name							= "LABEL_OSB1"
Label_OSB1.material						= font_MFCD
Label_OSB1.UseBackground				= false
Label_OSB1.BackgroundMaterial			= MFCD_SOLID_BLACK
Label_OSB1.alignment					= "CenterTop"
Label_OSB1.value						= "PREV"
Label_OSB1.stringdefs					= txt_labels_font
shift_button_pos(Label_OSB1, 1, 0)
Add(Label_OSB1)
use_mipfilter(Label_OSB1)

addOSB_Box(1, {Label_OSB1_symbol, Label_OSB1})
add_osb_static_hint(1, _("Return to HMCS Page 1"))

add_dummy_boxes({2, 3, 4, 5, 6})

-- OSB 7 - UNDO BORE
local Label_OSB7						= CreateElement "ceStringPoly"
Label_OSB7.name							= "HMCS_page2_label_OSB7"
Label_OSB7.alignment					= "RightCenter"
Label_OSB7.value						= SYS_ACTION
Label_OSB7.material						= font_MFCD
Label_OSB7.stringdefs					= txt_labels_font
shift_button_pos(Label_OSB7,7,2*OSB_label_spacing,0)
Add(Label_OSB7)
use_mipfilter(Label_OSB7)

local Label_OSB7_text					= CreateElement "ceStringPoly"
Label_OSB7_text.name					= "HMCS_page2_label_OSB7_text"
Label_OSB7_text.alignment				= "RightCenter"
Label_OSB7_text.material				= font_MFCD
Label_OSB7_text.value					= "UNDO\nBORE"
Label_OSB7_text.stringdefs				= txt_labels_font
Label_OSB7_text.parent_element      	= Label_OSB7.name 
Label_OSB7_text.init_pos            	= {-2*OSB_label_spacing,0,0}
Add(Label_OSB7_text)
use_mipfilter(Label_OSB7_text)

addOSB_Box(7, {Label_OSB7, Label_OSB7_text})
add_osb_static_hint(7, _("Undo boresight (no function)"))

addOSB_Box(8)

-- OSB 9 - UNDO OCCL
local Label_OSB9						= CreateElement "ceStringPoly"
Label_OSB9.name							= "HMCS_page2_label_OSB9"
Label_OSB9.alignment					= "RightCenter"
Label_OSB9.value						= SYS_ACTION
Label_OSB9.material						= font_MFCD
Label_OSB9.stringdefs					= txt_labels_font
shift_button_pos(Label_OSB9,9,2*OSB_label_spacing,0)
Add(Label_OSB9)
use_mipfilter(Label_OSB9)

local Label_OSB9_text					= CreateElement "ceStringPoly"
Label_OSB9_text.name					= "HMCS_page2_label_OSB9_text"
Label_OSB9_text.alignment				= "RightCenter"
Label_OSB9_text.material				= font_MFCD
Label_OSB9_text.value					= "UNDO\nOCCL"
Label_OSB9_text.stringdefs				= txt_labels_font
Label_OSB9_text.parent_element      	= Label_OSB9.name 
Label_OSB9_text.init_pos            	= {-2*OSB_label_spacing,0,0}
Add(Label_OSB9_text)
use_mipfilter(Label_OSB9_text)

addOSB_Box(9, {Label_OSB9, Label_OSB9_text})
add_osb_static_hint(9, _("Undo occlusion zone (no function)"))

add_dummy_boxes({10, 16})

-- OSB 17 - NEW OCCL ZONE
local Label_OSB17						= CreateElement "ceStringPoly"
Label_OSB17.name						= "HMCS_page2_label_OSB17"
Label_OSB17.alignment					= "LeftCenter"
Label_OSB17.value						= SYS_ACTION
Label_OSB17.material					= font_MFCD
Label_OSB17.stringdefs					= txt_labels_font
shift_button_pos(Label_OSB17,17,-2*OSB_label_spacing,0)
Add(Label_OSB17)
use_mipfilter(Label_OSB17)

local Label_OSB17_text					= CreateElement "ceStringPoly"
Label_OSB17_text.name					= "HMCS_page2_label_OSB17_text"
Label_OSB17_text.alignment				= "LeftCenter"
Label_OSB17_text.material				= font_MFCD
Label_OSB17_text.value					= "NEW OCCL\nZONE"
Label_OSB17_text.stringdefs				= txt_labels_font
Label_OSB17_text.parent_element      	= Label_OSB17.name
Label_OSB17_text.init_pos            	= {2*OSB_label_spacing + 2,0,0}
Add(Label_OSB17_text)
use_mipfilter(Label_OSB17_text)

addOSB_Box(17, {Label_OSB17, Label_OSB17_text})
add_osb_static_hint(17, "Create new occlusion zone (no function)")

addOSB_Box(18)

-- OSB 19 - FINE BORE
local Label_OSB19						= CreateElement "ceStringPoly"
Label_OSB19.name						= "HMCS_page2_label_OSB19"
Label_OSB19.alignment					= "LeftCenter"
Label_OSB19.value						= SYS_ACTION
Label_OSB19.material					= font_MFCD
Label_OSB19.stringdefs					= txt_labels_font
shift_button_pos(Label_OSB19,19,-2*OSB_label_spacing,0)
Add(Label_OSB19)
use_mipfilter(Label_OSB19)

local Label_OSB19_text					= CreateElement "ceStringPoly"
Label_OSB19_text.name					= "HMCS_page2_label_OSB19_text"
Label_OSB19_text.alignment				= "LeftCenter"
Label_OSB19_text.material				= font_MFCD
Label_OSB19_text.value					= "FINE\nBORE"
Label_OSB19_text.stringdefs				= txt_labels_font
Label_OSB19_text.parent_element      	= Label_OSB19.name
Label_OSB19_text.init_pos            	= {2*OSB_label_spacing + 2,0,0}
Add(Label_OSB19_text)
use_mipfilter(Label_OSB19_text)

addOSB_Box(19, {Label_OSB19, Label_OSB19_text})
add_osb_static_hint(19, "Fine boresight (no function)")

-- OSB 20 - COARSE BORE
local Label_OSB20						= CreateElement "ceStringPoly"
Label_OSB20.name						= "HMCS_page2_label_OSB20"
Label_OSB20.alignment					= "LeftCenter"
Label_OSB20.value						= SYS_ACTION
Label_OSB20.material					= font_MFCD
Label_OSB20.stringdefs					= txt_labels_font
shift_button_pos(Label_OSB20,20,-2*OSB_label_spacing,0)
Add(Label_OSB20)
use_mipfilter(Label_OSB20)

local Label_OSB20_text					= CreateElement "ceStringPoly"
Label_OSB20_text.name					= "HMCS_page2_label_OSB20_text"
Label_OSB20_text.alignment				= "LeftCenter"
Label_OSB20_text.material				= font_MFCD
Label_OSB20_text.value					= "COARSE\nBORE"
Label_OSB20_text.stringdefs				= txt_labels_font
Label_OSB20_text.parent_element      	= Label_OSB20.name
Label_OSB20_text.init_pos            	= {2*OSB_label_spacing + 2,0,0}
Add(Label_OSB20_text)
use_mipfilter(Label_OSB20_text)

addOSB_Box(20, {Label_OSB20, Label_OSB20_text})
add_osb_static_hint(20, "Coarse boresight (no function)")

local text_HMCS_BORESIGHT				= CreateElement "ceStringPoly"
text_HMCS_BORESIGHT.name				= "HMCS_page2_text_BORESIGHT"
text_HMCS_BORESIGHT.material			= font_MFCD
text_HMCS_BORESIGHT.alignment			= "CenterBottom"
text_HMCS_BORESIGHT.value				= "BORESIGHT"
text_HMCS_BORESIGHT.stringdefs			= predefined_fonts[2]
shift_button_pos(text_HMCS_BORESIGHT,20)
text_HMCS_BORESIGHT.init_pos			= {max_pixels_count / 2, text_HMCS_BORESIGHT.init_pos[2] - 5, 0}
Add(text_HMCS_BORESIGHT)
use_mipfilter(text_HMCS_BORESIGHT)

local boresightTextPosX = -73
local boresightTextPosY = -30
local boresightTextSpacing = 25

local boresight_AZ_text					= CreateElement "ceStringPoly"
boresight_AZ_text.name					= "HMCS_page2_boresight_AZ_text"
boresight_AZ_text.alignment				= "LeftCenter"
boresight_AZ_text.material				= font_MFCD
boresight_AZ_text.value					= "AZ: 0.015"
boresight_AZ_text.stringdefs			= predefined_fonts[1]
boresight_AZ_text.parent_element      	= text_HMCS_BORESIGHT.name
boresight_AZ_text.init_pos            	= {boresightTextPosX, boresightTextPosY, 0}
Add(boresight_AZ_text)
use_mipfilter(boresight_AZ_text)

local boresight_EL_text					= CreateElement "ceStringPoly"
boresight_EL_text.name					= "HMCS_page2_boresight_EL_text"
boresight_EL_text.alignment				= "LeftCenter"
boresight_EL_text.material				= font_MFCD
boresight_EL_text.value					= "EL: 0.000"
boresight_EL_text.stringdefs			= predefined_fonts[1]
boresight_EL_text.parent_element      	= text_HMCS_BORESIGHT.name
boresight_EL_text.init_pos            	= {boresightTextPosX, boresightTextPosY - boresightTextSpacing, 0}
Add(boresight_EL_text)
use_mipfilter(boresight_EL_text)

local boresight_ROLL_text				= CreateElement "ceStringPoly"
boresight_ROLL_text.name				= "HMCS_page2_boresight_ROLL_text"
boresight_ROLL_text.alignment			= "LeftCenter"
boresight_ROLL_text.material			= font_MFCD
boresight_ROLL_text.value				= "ROLL: 0.030"
boresight_ROLL_text.stringdefs			= predefined_fonts[1]
boresight_ROLL_text.parent_element      = text_HMCS_BORESIGHT.name
boresight_ROLL_text.init_pos            = {boresightTextPosX, boresightTextPosY - boresightTextSpacing * 2, 0}
Add(boresight_ROLL_text)
use_mipfilter(boresight_ROLL_text)

local boresight_MOUNT_text				= CreateElement "ceStringPoly"
boresight_MOUNT_text.name				= "HMCS_page2_boresight_MOUNT_text"
boresight_MOUNT_text.alignment			= "LeftCenter"
boresight_MOUNT_text.material			= font_MFCD
boresight_MOUNT_text.value				= "MOUNT: 6.005"
boresight_MOUNT_text.stringdefs			= predefined_fonts[1]
boresight_MOUNT_text.parent_element     = text_HMCS_BORESIGHT.name
boresight_MOUNT_text.init_pos           = {boresightTextPosX, boresightTextPosY - boresightTextSpacing * 3, 0}
Add(boresight_MOUNT_text)
use_mipfilter(boresight_MOUNT_text)
