dofile(LockOn_Options.script_path.."MFCD/indicator/MFCD_useful_definitions.lua")
dofile(LockOn_Options.script_path.."MFCD/indicator/DSMS/MFCD_DSMS_useful_definitions.lua")

AddInventoryText()

InventorySettingsText					= CreateElement "ceStringPoly"
InventorySettingsText.name				= "InventorySettingsText"
InventorySettingsText.material			= font_MFCD
InventorySettingsText.alignment			= "CenterCenter"
InventorySettingsText.init_pos			= {max_pixels_count/2,OSB_positions[20][2],0}
SetLowerLeftCornerOrigin(InventorySettingsText)
InventorySettingsText.stringdefs		= predefined_fonts[2]
InventorySettingsText.UseBackground		= false
InventorySettingsText.BackgroundMaterial= MFCD_SOLID_BLACK
InventorySettingsText.value				= "CBU"
Add(InventorySettingsText)
use_mipfilter(InventorySettingsText) 

AddInventoryTrainingLabel()

labels = {}

AddStatLabel()

AddRetLabel()
add_osb_static_hint(2, _("Return to Inventory Select page"))

add_dummy_boxes({3, 4, 5})

AddPylonName(0)

AddStationNumber()

AddWpnNameCount()

add_osb_static_hint(6, _("Go to the CBU-103 page"))
add_osb_static_hint(7, _("Go to the CBU-104 page"))
add_osb_static_hint(8, _("Go to the CBU-105 page"))
add_osb_static_hint(18, _("Go to the CBU-97 page"))
add_osb_static_hint(19, _("Go to the CBU-89 page"))
add_osb_static_hint(20, _("Go to the CBU-87 page"))

Label_OSB6						= CreateElement "ceStringPoly"
Label_OSB6.name					= "LABEL_OSB6"
Label_OSB6.alignment			= "RightCenter"
Label_OSB6.value				= "CBU-103" .. BRANCH_R
Label_OSB6.material				= font_MFCD
Label_OSB6.stringdefs			= txt_labels_font
Label_OSB6.controllers			= {{"DSMS_inventory_select_cbu103"}}
Label_OSB6.UseBackground		= false
Label_OSB6.BackgroundMaterial	= MFCD_SOLID_BLACK
shift_button_pos(Label_OSB6,6,-1*OSB_label_spacing,0)
Add(Label_OSB6)
use_mipfilter(Label_OSB6)
addOSB_Box(6, {Label_OSB6})

Label_OSB7						= CreateElement "ceStringPoly"
Label_OSB7.name					= "LABEL_OSB7"
Label_OSB7.alignment			= "RightCenter"
Label_OSB7.value				= "CBU-104" .. BRANCH_R
Label_OSB7.material				= font_MFCD
Label_OSB7.stringdefs			= txt_labels_font
Label_OSB7.controllers			= {{"DSMS_inventory_select_cbu104"}}
Label_OSB7.UseBackground		= false
Label_OSB7.BackgroundMaterial	= MFCD_SOLID_BLACK
shift_button_pos(Label_OSB7,7,-1*OSB_label_spacing,0)
Add(Label_OSB7)
use_mipfilter(Label_OSB7)
addOSB_Box(7, {Label_OSB7})

Label_OSB8						= CreateElement "ceStringPoly"
Label_OSB8.name					= "LABEL_OSB8"
Label_OSB8.alignment			= "RightCenter"
Label_OSB8.value				= "CBU-105" .. BRANCH_R
Label_OSB8.material				= font_MFCD
Label_OSB8.stringdefs			= txt_labels_font
Label_OSB8.controllers			= {{"DSMS_inventory_select_cbu105"}}
Label_OSB8.UseBackground		= false
Label_OSB8.BackgroundMaterial	= MFCD_SOLID_BLACK
shift_button_pos(Label_OSB8,8,-1*OSB_label_spacing,0)
Add(Label_OSB8)
use_mipfilter(Label_OSB8)
addOSB_Box(8, {Label_OSB8})

add_dummy_boxes({9, 10, 16, 17})

Label_OSB18							= CreateElement "ceStringPoly"
Label_OSB18.name					= "Label_OSB18"
Label_OSB18.alignment				= "LeftCenter"
Label_OSB18.value					= BRANCH_L .. "CBU-97"
Label_OSB18.material				= font_MFCD
Label_OSB18.stringdefs				= txt_labels_font
Label_OSB18.UseBackground			= false
Label_OSB18.BackgroundMaterial		= MFCD_SOLID_BLACK
--Label_OSB18.controllers				= {{"DSMS_inventory_select_bomb_mk84"}}
shift_button_pos(Label_OSB18,18,0,0)
Add(Label_OSB18)
use_mipfilter(Label_OSB18)
addOSB_Box(18, {Label_OSB18})

Label_OSB19							= CreateElement "ceStringPoly"
Label_OSB19.name					= "Label_OSB19"
Label_OSB19.alignment				= "LeftCenter"
Label_OSB19.value					= BRANCH_L .. "CBU-89"
Label_OSB19.material				= font_MFCD
Label_OSB19.stringdefs				= txt_labels_font
Label_OSB19.UseBackground			= false
Label_OSB19.BackgroundMaterial		= MFCD_SOLID_BLACK
--Label_OSB19.controllers				= {{"DSMS_inventory_select_bomb_mk82air"}}
shift_button_pos(Label_OSB19,19,0,0)
Add(Label_OSB19)
use_mipfilter(Label_OSB19)
addOSB_Box(19, {Label_OSB19})

Label_OSB20							= CreateElement "ceStringPoly"
Label_OSB20.name					= "Label_OSB20"
Label_OSB20.alignment				= "LeftCenter"
Label_OSB20.value					= BRANCH_L .. "CBU-87"
Label_OSB20.material				= font_MFCD
Label_OSB20.stringdefs				= txt_labels_font
Label_OSB20.UseBackground			= false
Label_OSB20.BackgroundMaterial		= MFCD_SOLID_BLACK
--Label_OSB20.controllers				= {{"DSMS_inventory_select_bomb_mk82"}}
shift_button_pos(Label_OSB20,20,0,0)
Add(Label_OSB20)
use_mipfilter(Label_OSB20)
addOSB_Box(20, {Label_OSB20})

