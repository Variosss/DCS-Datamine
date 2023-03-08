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
InventorySettingsText.value				= "MISCELLANEOUS"
Add(InventorySettingsText)
use_mipfilter(InventorySettingsText) 

AddInventoryTrainingLabel()

labels = {}

AddStatLabel()

AddRetLabel()
add_osb_static_hint(2, _("Return to Class Select page"))

add_dummy_boxes({3, 4, 5})

AddPylonName(1)

AddStationNumber()

AddWpnNameCount()

--[[
Label_OSB6_Symb						= CreateElement "ceStringPoly"
Label_OSB6_Symb.name				= "LABEL_OSB6_SYMB"
Label_OSB6_Symb.alignment			= "RightCenter"
Label_OSB6_Symb.value				= ROTARY
Label_OSB6_Symb.material			= font_MFCD
Label_OSB6_Symb.stringdefs			= txt_labels_font
Label_OSB6_Symb.UseBackground		= false
Label_OSB6_Symb.BackgroundMaterial	= MFCD_SOLID_BLACK
Label_OSB6_Symb.controllers			= {{"DSMS_inventory_travel_pod_loaded"}}
shift_button_pos(Label_OSB6_Symb,6,-1*OSB_label_spacing,0)
Add(Label_OSB6_Symb)
use_mipfilter(Label_OSB6_Symb)
--]]

Label_OSB6							= CreateElement "ceStringPoly"
Label_OSB6.name						= "Label_OSB6"
Label_OSB6.alignment				= "RightCenter"
Label_OSB6.value					= "MNT\nPYLON"
Label_OSB6.material					= font_MFCD
Label_OSB6.stringdefs				= txt_labels_font
Label_OSB6.UseBackground			= false
Label_OSB6.BackgroundMaterial		= MFCD_SOLID_BLACK
shift_button_pos(Label_OSB6,6,-1*OSB_label_spacing-10,0)
Add(Label_OSB6)
use_mipfilter(Label_OSB6)

addOSB_Box(6, {Label_OSB6_Symb, Label_OSB6})
add_osb_static_hint(6, _("Station type"))

add_dummy_boxes({7, 8})

Label_OSB9							= CreateElement "ceStringPoly"
Label_OSB9.name						= "LABEL_OSB9_SYMB"
Label_OSB9.alignment				= "RightCenter"
Label_OSB9.value					= "LOAD" .. SYS_ACTION
Label_OSB9.material					= font_MFCD
Label_OSB9.stringdefs				= txt_labels_font
Label_OSB9.UseBackground			= false
Label_OSB9.BackgroundMaterial		= MFCD_SOLID_BLACK
shift_button_pos(Label_OSB9,9,-1*OSB_label_spacing,0)
Add(Label_OSB9)
use_mipfilter(Label_OSB9)
addOSB_Box(9, {Label_OSB9})
add_osb_static_hint(9, _("Load store to station"))

Label_OSB10							= CreateElement "ceStringPoly"
Label_OSB10.name					= "LABEL_OSB10"
Label_OSB10.alignment				= "RightCenter"
Label_OSB10.value					= "LOAD\nSYM"
Label_OSB10.material				= font_MFCD
Label_OSB10.stringdefs				= txt_labels_font
Label_OSB10.UseBackground			= false
Label_OSB10.BackgroundMaterial		= MFCD_SOLID_BLACK
Label_OSB10.controllers				= {{"DSMS_inventory_load_sym"}}
shift_button_pos(Label_OSB10,10,-1*OSB_label_spacing-10,0)
Add(Label_OSB10)
use_mipfilter(Label_OSB10)

Label_OSB10_symb					= CreateElement "ceStringPoly"
Label_OSB10_symb.name				= "LABEL_OSB10_SYMB"
Label_OSB10_symb.alignment			= "RightCenter"
Label_OSB10_symb.value				= SYS_ACTION
Label_OSB10_symb.material			= font_MFCD
Label_OSB10_symb.stringdefs			= txt_labels_font
Label_OSB10_symb.UseBackground		= false
Label_OSB10_symb.BackgroundMaterial	= MFCD_SOLID_BLACK
Label_OSB10_symb.controllers		= {{"DSMS_inventory_load_sym"}}
shift_button_pos(Label_OSB10_symb,10,-1*OSB_label_spacing,0)
Add(Label_OSB10_symb)
use_mipfilter(Label_OSB10_symb)

addOSB_Box(10, {Label_OSB10, Label_OSB10_symb})
add_osb_hint_controllers(10, _("Load Store on Symmetric Stations"), {{"DSMS_inventory_load_sym"}})

add_dummy_boxes({16, 17})

Label_OSB18							= CreateElement "ceStringPoly"
Label_OSB18.name					= "Label_OSB18"
Label_OSB18.alignment				= "LeftCenter"
Label_OSB18.value					= SYS_ACTION .. "TK-600"
Label_OSB18.material				= font_MFCD
Label_OSB18.stringdefs				= txt_labels_font
Label_OSB18.UseBackground			= false
Label_OSB18.BackgroundMaterial		= MFCD_SOLID_BLACK
Label_OSB18.controllers				= {{"DSMS_inventory_tk600"}}
shift_button_pos(Label_OSB18,18,1*OSB_label_spacing,0)
Add(Label_OSB18)
use_mipfilter(Label_OSB18)
addOSB_Box(18, {Label_OSB18})
add_osb_hint_controllers(18, _("TK-600 fuel tank select"), {{"DSMS_inventory_tk600"}})

Label_OSB19							= CreateElement "ceStringPoly"
Label_OSB19.name					= "Label_OSB19"
Label_OSB19.alignment				= "LeftCenter"
Label_OSB19.value					= SYS_ACTION
Label_OSB19.material				= font_MFCD
Label_OSB19.stringdefs				= txt_labels_font
Label_OSB19.UseBackground			= false
Label_OSB19.BackgroundMaterial		= MFCD_SOLID_BLACK
Label_OSB19.controllers				= {{"DSMS_inventory_travel_pod"}}
shift_button_pos(Label_OSB19,19,1*OSB_label_spacing,0)
Add(Label_OSB19)
use_mipfilter(Label_OSB19)

Label_OSB19_pod						= CreateElement "ceStringPoly"
Label_OSB19_pod.name				= "Label_OSB19_pod"
Label_OSB19_pod.alignment			= "LeftCenter"
Label_OSB19_pod.value				= "TRAVEL\nPOD"
Label_OSB19_pod.material			= font_MFCD
Label_OSB19_pod.stringdefs			= txt_labels_font
Label_OSB19_pod.UseBackground		= false
Label_OSB19_pod.BackgroundMaterial	= MFCD_SOLID_BLACK
Label_OSB19_pod.controllers			= {{"DSMS_inventory_travel_pod"}}
shift_button_pos(Label_OSB19_pod,19,1*OSB_label_spacing+10,0)
Add(Label_OSB19_pod)
use_mipfilter(Label_OSB19_pod)

addOSB_Box(19, {Label_OSB19, Label_OSB19_pod})
add_osb_hint_controllers(19, _("Travel pod select"), {{"DSMS_inventory_travel_pod"}})

Label_OSB20							= CreateElement "ceStringPoly"
Label_OSB20.name					= "Label_OSB20"
Label_OSB20.alignment				= "LeftCenter"
Label_OSB20.value					= SYS_ACTION .. "CTU-2A"
Label_OSB20.material				= font_MFCD
Label_OSB20.stringdefs				= txt_labels_font
Label_OSB20.UseBackground			= false
Label_OSB20.BackgroundMaterial		= MFCD_SOLID_BLACK
Label_OSB20.controllers				= {{"DSMS_inventory_ctu2a"}}
shift_button_pos(Label_OSB20,20,1*OSB_label_spacing,0)
Add(Label_OSB20)
use_mipfilter(Label_OSB20)
addOSB_Box(20, {Label_OSB20})
add_osb_hint_controllers(20, _("CTU-2A select"), {{"DSMS_inventory_ctu2a"}})

