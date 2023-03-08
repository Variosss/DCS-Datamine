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
InventorySettingsText.value				= "BDU-33"
Add(InventorySettingsText)
use_mipfilter(InventorySettingsText) 

AddInventoryTrainingLabel()

labels = {}

AddStatLabel()

AddRetLabel()
add_osb_static_hint(2, _("Return to Class Select page"))

add_dummy_boxes({3, 4})

AddPylonName(1)

AddStationNumber()

AddWpnNameCount()

OsbLabelQTY							= CreateElement "ceStringPoly"
OsbLabelQTY.name					= "OsbLabelQTY"
OsbLabelQTY.material				= font_MFCD
OsbLabelQTY.UseBackground			= false
OsbLabelQTY.BackgroundMaterial		= MFCD_SOLID_BLACK
OsbLabelQTY.alignment				= "CenterTop"
OsbLabelQTY.formats					= {"QTY\n%d"}
OsbLabelQTY.stringdefs				= predefined_fonts[1]
OsbLabelQTY.controllers				= {{"DSMS_inventory_temp_qty", 0}}
shift_button_pos(OsbLabelQTY, 5, 0)
Add(OsbLabelQTY)
use_mipfilter(OsbLabelQTY)

OsbLabelQTY_symb						= CreateElement "ceStringPoly"
OsbLabelQTY_symb.name					= "OsbLabelQTY_symb"
OsbLabelQTY_symb.material				= font_MFCD
OsbLabelQTY_symb.UseBackground			= false
OsbLabelQTY_symb.BackgroundMaterial		= MFCD_SOLID_BLACK
OsbLabelQTY_symb.alignment				= "CenterTop"
OsbLabelQTY_symb.value					= DATA_ENTRY
OsbLabelQTY_symb.stringdefs				= predefined_fonts[1]
--OsbLabelQTY_symb.controllers			= {{"DSMS_inventory_mav_lau", 1}}
shift_button_pos(OsbLabelQTY_symb, 5, -23)
Add(OsbLabelQTY_symb)
use_mipfilter(OsbLabelQTY_symb)

addOSB_Box(5, {OsbLabelQTY, OsbLabelQTY_symb})
add_osb_static_hint(5,_("Number of store on TER"))

add_dummy_boxes({6, 7, 8})

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

Label_OSB16							= CreateElement "ceStringPoly"
Label_OSB16.name					= "Label_OSB16"
Label_OSB16.alignment				= "LeftCenter"
Label_OSB16.value					= ROTARY
Label_OSB16.material				= font_MFCD
Label_OSB16.stringdefs				= txt_labels_font
Label_OSB16.UseBackground			= false
Label_OSB16.BackgroundMaterial		= MFCD_SOLID_BLACK
--Label_OSB16.controllers				= {{"DSMS_inventory_travel_pod"}}
shift_button_pos(Label_OSB16,16,1*OSB_label_spacing,0)
Add(Label_OSB16)
use_mipfilter(Label_OSB16)

Label_OSB16_pod						= CreateElement "ceStringPoly"
Label_OSB16_pod.name				= "Label_OSB16_pod"
Label_OSB16_pod.alignment			= "LeftCenter"
Label_OSB16_pod.value				= "SERIES\nD/B"
Label_OSB16_pod.material			= font_MFCD
Label_OSB16_pod.stringdefs			= txt_labels_font
Label_OSB16_pod.UseBackground		= false
Label_OSB16_pod.BackgroundMaterial	= MFCD_SOLID_BLACK
--Label_OSB16_pod.controllers			= {{"DSMS_inventory_travel_pod"}}
shift_button_pos(Label_OSB16_pod,16,1*OSB_label_spacing+10,0)
Add(Label_OSB16_pod)
use_mipfilter(Label_OSB16_pod)

addOSB_Box(16, {Label_OSB16, Label_OSB16_pod})
add_osb_static_hint(16, _("Select store series"))

add_dummy_boxes({17, 18, 19, 20})
