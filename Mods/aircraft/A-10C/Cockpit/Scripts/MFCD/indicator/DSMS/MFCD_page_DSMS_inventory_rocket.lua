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
InventorySettingsText.value				= "ROCKET"
Add(InventorySettingsText)
use_mipfilter(InventorySettingsText) 

AddInventoryTrainingLabel()

labels = {}

AddStatLabel()

AddRetLabel()
add_osb_static_hint(2, _("Return to Class Select page"))

addOSB_Box(3)

AddPylonName(1)

AddStationNumber()

AddWpnNameCount()

LabelQTY_LAU						= CreateElement "ceStringPoly"
LabelQTY_LAU.name					= "LabelQTY_LAU"
LabelQTY_LAU.material				= font_MFCD
LabelQTY_LAU.UseBackground			= false
LabelQTY_LAU.BackgroundMaterial		= MFCD_SOLID_BLACK
LabelQTY_LAU.alignment				= "CenterTop"
LabelQTY_LAU.formats				= {"LAU\n%d"}
LabelQTY_LAU.stringdefs				= predefined_fonts[1]
LabelQTY_LAU.controllers			= {{"DSMS_inventory_qty_lau", 0}}
shift_button_pos(LabelQTY_LAU, 4)
Add(LabelQTY_LAU)
use_mipfilter(LabelQTY_LAU)

LabelQTY_LAU_symb						= CreateElement "ceStringPoly"
LabelQTY_LAU_symb.name					= "LabelQTY_LAU_symb"
LabelQTY_LAU_symb.material				= font_MFCD
LabelQTY_LAU_symb.UseBackground			= false
LabelQTY_LAU_symb.BackgroundMaterial	= MFCD_SOLID_BLACK
LabelQTY_LAU_symb.alignment				= "CenterTop"
LabelQTY_LAU_symb.value					= DATA_ENTRY
LabelQTY_LAU_symb.stringdefs			= predefined_fonts[1]
LabelQTY_LAU_symb.controllers			= {{"DSMS_inventory_rocket_pylon", 1}}
shift_button_pos(LabelQTY_LAU_symb, 4, -23)
Add(LabelQTY_LAU_symb)
use_mipfilter(LabelQTY_LAU_symb)

addOSB_Box(4, {LabelQTY_LAU, LabelQTY_LAU_symb})
add_osb_static_hint(4, _("Select number of launchers per TER"))

OsbLabelQTY							= CreateElement "ceStringPoly"
OsbLabelQTY.name					= "OsbLabelQTY"
OsbLabelQTY.material				= font_MFCD
OsbLabelQTY.UseBackground			= false
OsbLabelQTY.BackgroundMaterial		= MFCD_SOLID_BLACK
OsbLabelQTY.alignment				= "CenterTop"
OsbLabelQTY.formats					= {"QTY\n%d"}
OsbLabelQTY.stringdefs				= predefined_fonts[1]
OsbLabelQTY.controllers				= {{"DSMS_inventory_temp_qty", 0}}
shift_button_pos(OsbLabelQTY, 5)
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
shift_button_pos(OsbLabelQTY_symb, 5, -23)
Add(OsbLabelQTY_symb)
use_mipfilter(OsbLabelQTY_symb)

addOSB_Box(5, {OsbLabelQTY, OsbLabelQTY_symb})
add_osb_static_hint(5, _("Number of store on TER"))

Label_OSB6_Symb						= CreateElement "ceStringPoly"
Label_OSB6_Symb.name				= "LABEL_OSB6_SYMB"
Label_OSB6_Symb.alignment			= "RightCenter"
Label_OSB6_Symb.value				= ROTARY
Label_OSB6_Symb.material			= font_MFCD
Label_OSB6_Symb.stringdefs			= txt_labels_font
Label_OSB6_Symb.UseBackground		= false
Label_OSB6_Symb.BackgroundMaterial	= MFCD_SOLID_BLACK
Label_OSB6_Symb.controllers			= {{"DSMS_inventory_ter_avail"}}
shift_button_pos(Label_OSB6_Symb,6,-1*OSB_label_spacing,0)
Add(Label_OSB6_Symb)
use_mipfilter(Label_OSB6_Symb)

Label_OSB6							= CreateElement "ceStringPoly"
Label_OSB6.name						= "Label_OSB6"
Label_OSB6.alignment				= "RightCenter"
Label_OSB6.value					= "MNT\nPYLON"
Label_OSB6.material					= font_MFCD
Label_OSB6.stringdefs				= txt_labels_font
Label_OSB6.UseBackground			= false
Label_OSB6.BackgroundMaterial		= MFCD_SOLID_BLACK
Label_OSB6.controllers				= {{"DSMS_inventory_rocket_pylon", 0}}
shift_button_pos(Label_OSB6,6,-1*OSB_label_spacing-10,0)
Add(Label_OSB6)
use_mipfilter(Label_OSB6)

Label_OSB6_1						= Copy(Label_OSB6)
Label_OSB6_1.value					= "MNT\nTER"
Label_OSB6_1.controllers			= {{"DSMS_inventory_rocket_pylon", 1}}
Add(Label_OSB6_1)
use_mipfilter(Label_OSB6_1)

addOSB_Box(6, {Label_OSB6_Symb, Label_OSB6, Label_OSB6_1})
add_osb_static_hint(6, _("Select launcher mounting"))

Label_OSB7_Symb						= CreateElement "ceStringPoly"
Label_OSB7_Symb.name				= "LABEL_OSB7_SYMB"
Label_OSB7_Symb.alignment			= "RightCenter"
Label_OSB7_Symb.value				= ROTARY
Label_OSB7_Symb.material			= font_MFCD
Label_OSB7_Symb.stringdefs			= txt_labels_font
Label_OSB7_Symb.UseBackground		= false
Label_OSB7_Symb.BackgroundMaterial	= MFCD_SOLID_BLACK
shift_button_pos(Label_OSB7_Symb,7,-1*OSB_label_spacing,0)
Add(Label_OSB7_Symb)
use_mipfilter(Label_OSB7_Symb)

Label_OSB7							= CreateElement "ceStringPoly"
Label_OSB7.name						= "Label_OSB7"
Label_OSB7.alignment				= "RightCenter"
Label_OSB7.value					= "MOTOR\nMK66"
Label_OSB7.material					= font_MFCD
Label_OSB7.stringdefs				= txt_labels_font
Label_OSB7.UseBackground			= false
Label_OSB7.BackgroundMaterial		= MFCD_SOLID_BLACK
Label_OSB7.controllers				= {{"DSMS_inventory_rocket_motor", 0}}
shift_button_pos(Label_OSB7,7,-1*OSB_label_spacing-10,0)
Add(Label_OSB7)
use_mipfilter(Label_OSB7)

Label_OSB7_1						= Copy(Label_OSB7)
Label_OSB7_1.value					= "MOTOR\nMK40"
Label_OSB7_1.controllers			= {{"DSMS_inventory_rocket_motor", 1}}
Add(Label_OSB7_1)
use_mipfilter(Label_OSB7_1)

addOSB_Box(7, {Label_OSB7_Symb, Label_OSB7, Label_OSB7_1})
add_osb_static_hint(7, _("Select motor type"))

Label_OSB8_Symb						= CreateElement "ceStringPoly"
Label_OSB8_Symb.name				= "LABEL_OSB8_SYMB"
Label_OSB8_Symb.alignment			= "RightCenter"
Label_OSB8_Symb.value				= ROTARY
Label_OSB8_Symb.material			= font_MFCD
Label_OSB8_Symb.stringdefs			= txt_labels_font
Label_OSB8_Symb.UseBackground		= false
Label_OSB8_Symb.BackgroundMaterial	= MFCD_SOLID_BLACK
shift_button_pos(Label_OSB8_Symb,8,-1*OSB_label_spacing,0)
Add(Label_OSB8_Symb)
use_mipfilter(Label_OSB8_Symb)

Label_OSB8							= CreateElement "ceStringPoly"
Label_OSB8.name						= "Label_OSB8"
Label_OSB8.alignment				= "RightCenter"
Label_OSB8.value					= "LAUNCHER\nLAU131"
Label_OSB8.material					= font_MFCD
Label_OSB8.stringdefs				= txt_labels_font
Label_OSB8.UseBackground			= false
Label_OSB8.BackgroundMaterial		= MFCD_SOLID_BLACK
Label_OSB8.controllers				= {{"DSMS_inventory_rocket_lau", 0}}
shift_button_pos(Label_OSB8,8,-1*OSB_label_spacing-10,0)
Add(Label_OSB8)
use_mipfilter(Label_OSB8)

Label_OSB8_1						= Copy(Label_OSB8)
Label_OSB8_1.value					= "LAUNCHER\nLAU68"
Label_OSB8_1.controllers			= {{"DSMS_inventory_rocket_lau", 1}}
Add(Label_OSB8_1)
use_mipfilter(Label_OSB8_1)

addOSB_Box(8, {Label_OSB8_Symb, Label_OSB8, Label_OSB8_1})
add_osb_static_hint(8, _("Select launcher type"))

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
Label_OSB10_symb.controllers				= {{"DSMS_inventory_load_sym"}}
shift_button_pos(Label_OSB10_symb,10,-1*OSB_label_spacing,0)
Add(Label_OSB10_symb)
use_mipfilter(Label_OSB10_symb)

addOSB_Box(10, {Label_OSB10_Symb, Label_OSB10})
add_osb_hint_controllers(10, _("Load Store on Symmetric Stations"), {{"DSMS_inventory_load_sym"}})

add_dummy_boxes({16, 17, 18})

Label_OSB19_Symb						= CreateElement "ceStringPoly"
Label_OSB19_Symb.name					= "LABEL_OSB19_SYMB"
Label_OSB19_Symb.alignment				= "LeftCenter"
Label_OSB19_Symb.value					= ROTARY
Label_OSB19_Symb.material				= font_MFCD
Label_OSB19_Symb.stringdefs				= txt_labels_font
Label_OSB19_Symb.UseBackground			= false
Label_OSB19_Symb.BackgroundMaterial		= MFCD_SOLID_BLACK
shift_button_pos(Label_OSB19_Symb,19,1*OSB_label_spacing,0)
Add(Label_OSB19_Symb)
use_mipfilter(Label_OSB19_Symb)

Label_OSB19								= CreateElement "ceStringPoly"
Label_OSB19.name						= "Label_OSB19"
Label_OSB19.alignment					= "LeftCenter"
Label_OSB19.value						= "POD SET\nSINGLE"
Label_OSB19.material					= font_MFCD
Label_OSB19.stringdefs					= txt_labels_font
Label_OSB19.controllers					= {{"DSMS_inventory_rocket_pod_set", 0}}
Label_OSB19.UseBackground				= false
Label_OSB19.BackgroundMaterial			= MFCD_SOLID_BLACK
shift_button_pos(Label_OSB19,19,1*OSB_label_spacing+10,0)
Add(Label_OSB19)
use_mipfilter(Label_OSB19)

Label_OSB19_1							= Copy(Label_OSB19)
Label_OSB19_1.value						= "POD SET\nDOUBLE"
Label_OSB19_1.controllers				= {{"DSMS_inventory_rocket_pod_set", 1}}
Add(Label_OSB19_1)
use_mipfilter(Label_OSB19_1)

addOSB_Box(19, {Label_OSB19_Symb, Label_OSB19, Label_OSB19_1})
add_osb_static_hint(19, _("Select single or double fire"))

Label_OSB20_Symb						= CreateElement "ceStringPoly"
Label_OSB20_Symb.name					= "LABEL_OSB20_SYMB"
Label_OSB20_Symb.alignment				= "LeftCenter"
Label_OSB20_Symb.value					= ROTARY
Label_OSB20_Symb.material				= font_MFCD
Label_OSB20_Symb.stringdefs				= txt_labels_font
Label_OSB20_Symb.UseBackground			= false
Label_OSB20_Symb.BackgroundMaterial		= MFCD_SOLID_BLACK
shift_button_pos(Label_OSB20_Symb,20,1*OSB_label_spacing,0)
Add(Label_OSB20_Symb)
use_mipfilter(Label_OSB20_Symb)

LabelOSB200								= CreateElement "ceStringPoly"
LabelOSB200.name						= "LabelOSB200"
LabelOSB200.alignment					= "LeftCenter"
LabelOSB200.value						= "M-151\nPMI"
LabelOSB200.material					= font_MFCD
LabelOSB200.stringdefs					= txt_labels_font
LabelOSB200.controllers					= {{"DSMS_inventory_rocket_name", HYDRA_70_M151}}
LabelOSB200.UseBackground				= false
LabelOSB200.BackgroundMaterial			= MFCD_SOLID_BLACK
shift_button_pos(LabelOSB200,20,1*OSB_label_spacing+10,0)
Add(LabelOSB200)
use_mipfilter(LabelOSB200)

LabelOSB201								= Copy(LabelOSB200)
LabelOSB201.value						= "M-156\nWP"
LabelOSB201.controllers					= {{"DSMS_inventory_rocket_name", HYDRA_70_M156}}
Add(LabelOSB201)
use_mipfilter(LabelOSB201)

LabelOSB202								= Copy(LabelOSB200)
LabelOSB202.value						= "WTU-1/B\nTP"
LabelOSB202.controllers					= {{"DSMS_inventory_rocket_name", HYDRA_70_WTU1B}}
Add(LabelOSB202)
use_mipfilter(LabelOSB202)

LabelOSB203								= Copy(LabelOSB200)
LabelOSB203.value						= "M-257\nILLUM"
LabelOSB203.controllers					= {{"DSMS_inventory_rocket_name", HYDRA_70_M257}}
Add(LabelOSB203)
use_mipfilter(LabelOSB203)

LabelOSB204								= Copy(LabelOSB200)
LabelOSB204.value						= "M-278\nIR ILLUM"
LabelOSB204.controllers					= {{"DSMS_inventory_rocket_name", HYDRA_70_M278}}
Add(LabelOSB204)
use_mipfilter(LabelOSB204)

LabelOSB205								= Copy(LabelOSB200)
LabelOSB205.value						= "M-274\nSMOKE"
LabelOSB205.controllers					= {{"DSMS_inventory_rocket_name", HYDRA_70_M274}}
Add(LabelOSB205)
use_mipfilter(LabelOSB205)

LabelOSB206								= Copy(LabelOSB200)
LabelOSB206.value						= "MK-1\nTP"
LabelOSB206.controllers					= {{"DSMS_inventory_rocket_name", HYDRA_70_MK1}}
Add(LabelOSB206)
use_mipfilter(LabelOSB206)

LabelOSB207								= Copy(LabelOSB200)
LabelOSB207.value						= "MK-5\nHEAT"
LabelOSB207.controllers					= {{"DSMS_inventory_rocket_name", HYDRA_70_MK5}}
Add(LabelOSB207)
use_mipfilter(LabelOSB207)

LabelOSB208								= Copy(LabelOSB200)
LabelOSB208.value						= "MK-61\nTP"
LabelOSB208.controllers					= {{"DSMS_inventory_rocket_name", HYDRA_70_MK61}}
Add(LabelOSB208)
use_mipfilter(LabelOSB208)

addOSB_Box(20, {Label_OSB20_Symb, LabelOSB200, LabelOSB201, LabelOSB202, LabelOSB203, LabelOSB204, LabelOSB205, LabelOSB206, LabelOSB207, LabelOSB208})
add_osb_static_hint(20, _("Select warhead type"))
