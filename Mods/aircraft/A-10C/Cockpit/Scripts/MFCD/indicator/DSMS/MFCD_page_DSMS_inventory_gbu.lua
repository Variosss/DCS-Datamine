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
InventorySettingsText.value				= "GBU"
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

add_osb_static_hint(17, _("Go to the GBU-38 page"))
add_osb_static_hint(18, _("Go to the GBU-31 page"))
add_osb_static_hint(19, _("Go to the GBU-12 page"))
add_osb_static_hint(20, _("Go to the GBU-10 page"))

add_dummy_boxes({6, 7, 8, 9, 10, 16})

Label_OSB17							= CreateElement "ceStringPoly"
Label_OSB17.name					= "Label_OSB17"
Label_OSB17.alignment				= "LeftCenter"
Label_OSB17.value					= BRANCH_L .. "GBU-38"
Label_OSB17.material				= font_MFCD
Label_OSB17.stringdefs				= txt_labels_font
Label_OSB17.UseBackground			= false
Label_OSB17.BackgroundMaterial		= MFCD_SOLID_BLACK
Label_OSB17.controllers				= {{"DSMS_inventory_select_gbu_gbu38"}}
shift_button_pos(Label_OSB17,17,0,0)
Add(Label_OSB17)
use_mipfilter(Label_OSB17)
addOSB_Box(17, {Label_OSB17})

Label_OSB18							= CreateElement "ceStringPoly"
Label_OSB18.name					= "Label_OSB18"
Label_OSB18.alignment				= "LeftCenter"
Label_OSB18.value					= BRANCH_L .. "GBU-31"
Label_OSB18.material				= font_MFCD
Label_OSB18.stringdefs				= txt_labels_font
Label_OSB18.UseBackground			= false
Label_OSB18.BackgroundMaterial		= MFCD_SOLID_BLACK
Label_OSB18.controllers				= {{"DSMS_inventory_select_gbu_gbu31"}}
shift_button_pos(Label_OSB18,18,0,0)
Add(Label_OSB18)
use_mipfilter(Label_OSB18)
addOSB_Box(18, {Label_OSB18})

Label_OSB19							= CreateElement "ceStringPoly"
Label_OSB19.name					= "Label_OSB19"
Label_OSB19.alignment				= "LeftCenter"
Label_OSB19.value					= BRANCH_L .. "GBU-12"
Label_OSB19.material				= font_MFCD
Label_OSB19.stringdefs				= txt_labels_font
Label_OSB19.UseBackground			= false
Label_OSB19.BackgroundMaterial		= MFCD_SOLID_BLACK
Label_OSB19.controllers				= {{"DSMS_inventory_select_gbu_gbu12"}}
shift_button_pos(Label_OSB19,19,0,0)
Add(Label_OSB19)
use_mipfilter(Label_OSB19)
addOSB_Box(19, {Label_OSB19})

Label_OSB20							= CreateElement "ceStringPoly"
Label_OSB20.name					= "Label_OSB20"
Label_OSB20.alignment				= "LeftCenter"
Label_OSB20.value					= BRANCH_L .. "GBU-10"
Label_OSB20.material				= font_MFCD
Label_OSB20.stringdefs				= txt_labels_font
Label_OSB20.UseBackground			= false
Label_OSB20.BackgroundMaterial		= MFCD_SOLID_BLACK
Label_OSB20.controllers				= {{"DSMS_inventory_select_gbu_gbu10"}}
shift_button_pos(Label_OSB20,20,0,0)
Add(Label_OSB20)
use_mipfilter(Label_OSB20)
addOSB_Box(20, {Label_OSB20})

