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
InventorySettingsText.value				= "FLARE"
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
shift_button_pos(LabelQTY_LAU, 4, 0)
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
add_osb_static_hint(4, _("Select number of launchers on TER"))

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
Label_OSB10_symb.controllers				= {{"DSMS_inventory_load_sym"}}
shift_button_pos(Label_OSB10_symb,10,-1*OSB_label_spacing,0)
Add(Label_OSB10_symb)
use_mipfilter(Label_OSB10_symb)

addOSB_Box(10, {Label_OSB10_Symb, Label_OSB10})
add_osb_hint_controllers(10, _("Load Store on Symmetric Stations"), {{"DSMS_inventory_load_sym"}})

Label_OSB16_Symb						= CreateElement "ceStringPoly"
Label_OSB16_Symb.name					= "LABEL_OSB16_SYMB"
Label_OSB16_Symb.alignment				= "LeftCenter"
Label_OSB16_Symb.value					= ROTARY
Label_OSB16_Symb.material				= font_MFCD
Label_OSB16_Symb.stringdefs				= txt_labels_font
Label_OSB16_Symb.UseBackground			= false
Label_OSB16_Symb.BackgroundMaterial		= MFCD_SOLID_BLACK
Label_OSB16_Symb.controllers			= {{"DSMS_inventory_ffdist_avail"}}
shift_button_pos(Label_OSB16_Symb,16,1*OSB_label_spacing,0)
Add(Label_OSB16_Symb)
use_mipfilter(Label_OSB16_Symb)

Label_OSB16								= CreateElement "ceStringPoly"
Label_OSB16.name						= "Label_OSB16"
Label_OSB16.alignment					= "LeftCenter"
Label_OSB16.formats						= {"FF DIST\n%d"}
Label_OSB16.material					= font_MFCD
Label_OSB16.stringdefs					= txt_labels_font
Label_OSB16.controllers					= {{"DSMS_inventory_ffdist_avail"}, {"DSMS_inventory_ffdist", 0}}
Label_OSB16.UseBackground				= false
Label_OSB16.BackgroundMaterial			= MFCD_SOLID_BLACK
shift_button_pos(Label_OSB16,16,1*OSB_label_spacing+10,0)
Add(Label_OSB16)
use_mipfilter(Label_OSB16)

addOSB_Box(16, {Label_OSB16_Symb, Label_OSB16})
add_osb_hint_controllers(16, _("Feet flare will drop before parachute will open"), {{"DSMS_inventory_ffdist_avail"}})

Label_OSB17_Symb						= CreateElement "ceStringPoly"
Label_OSB17_Symb.name					= "LABEL_OSB17_SYMB"
Label_OSB17_Symb.alignment				= "LeftCenter"
Label_OSB17_Symb.value					= ROTARY
Label_OSB17_Symb.material				= font_MFCD
Label_OSB17_Symb.stringdefs				= txt_labels_font
Label_OSB17_Symb.UseBackground			= false
Label_OSB17_Symb.BackgroundMaterial		= MFCD_SOLID_BLACK
Label_OSB17_Symb.controllers			= {{"DSMS_inventory_ignition_avail"}}
shift_button_pos(Label_OSB17_Symb,17,1*OSB_label_spacing,0)
Add(Label_OSB17_Symb)
use_mipfilter(Label_OSB17_Symb)

Label_OSB17								= CreateElement "ceStringPoly"
Label_OSB17.name						= "Label_OSB17"
Label_OSB17.alignment					= "LeftCenter"
Label_OSB17.value						= "IGN DLY\n10"
Label_OSB17.material					= font_MFCD
Label_OSB17.stringdefs					= txt_labels_font
Label_OSB17.controllers					= {{"DSMS_inventory_ignition_avail"}, {"DSMS_inventory_ignition", 0}}
Label_OSB17.UseBackground				= false
Label_OSB17.BackgroundMaterial			= MFCD_SOLID_BLACK
shift_button_pos(Label_OSB17,17,1*OSB_label_spacing+10,0)
Add(Label_OSB17)
use_mipfilter(Label_OSB17)

Label_OSB17_1							= Copy(Label_OSB17)
Label_OSB17_1.value						= "IGN DLY\n15"
Label_OSB17_1.controllers				= {{"DSMS_inventory_ignition_avail"}, {"DSMS_inventory_ignition", 1}}
Add(Label_OSB17_1)
use_mipfilter(Label_OSB17_1)

Label_OSB17_2							= Copy(Label_OSB17)
Label_OSB17_2.value						= "IGN DLY\n20"
Label_OSB17_2.controllers				= {{"DSMS_inventory_ignition_avail"}, {"DSMS_inventory_ignition", 2}}
Add(Label_OSB17_2)
use_mipfilter(Label_OSB17_2)

Label_OSB17_3							= Copy(Label_OSB17)
Label_OSB17_3.value						= "IGN DLY\n25"
Label_OSB17_3.controllers				= {{"DSMS_inventory_ignition_avail"}, {"DSMS_inventory_ignition", 3}}
Add(Label_OSB17_3)
use_mipfilter(Label_OSB17_3)

Label_OSB17_4							= Copy(Label_OSB17)
Label_OSB17_4.value						= "IGN DLY\n30"
Label_OSB17_4.controllers				= {{"DSMS_inventory_ignition_avail"}, {"DSMS_inventory_ignition", 4}}
Add(Label_OSB17_4)
use_mipfilter(Label_OSB17_4)

addOSB_Box(17, {Label_OSB17_Symb, Label_OSB17, Label_OSB17_1, Label_OSB17_2, Label_OSB17_3, Label_OSB17_4})
add_osb_hint_controllers(17, _("Time in seconds for parachute to open"), {{"DSMS_inventory_ignition_avail"}})

Label_OSB18_Symb						= CreateElement "ceStringPoly"
Label_OSB18_Symb.name					= "LABEL_OSB18_SYMB"
Label_OSB18_Symb.alignment				= "LeftCenter"
Label_OSB18_Symb.value					= ROTARY
Label_OSB18_Symb.material				= font_MFCD
Label_OSB18_Symb.stringdefs				= txt_labels_font
Label_OSB18_Symb.UseBackground			= false
Label_OSB18_Symb.BackgroundMaterial		= MFCD_SOLID_BLACK
Label_OSB18_Symb.controllers			= {{"DSMS_inventory_eject_avail"}}
shift_button_pos(Label_OSB18_Symb,18,1*OSB_label_spacing,0)
Add(Label_OSB18_Symb)
use_mipfilter(Label_OSB18_Symb)

Label_OSB18								= CreateElement "ceStringPoly"
Label_OSB18.name						= "Label_OSB18"
Label_OSB18.alignment					= "LeftCenter"
Label_OSB18.value						= "EJECT\n5"
Label_OSB18.material					= font_MFCD
Label_OSB18.stringdefs					= txt_labels_font
Label_OSB18.controllers					= {{"DSMS_inventory_eject_avail"}, {"DSMS_inventory_eject", 0}}
Label_OSB18.UseBackground				= false
Label_OSB18.BackgroundMaterial			= MFCD_SOLID_BLACK
shift_button_pos(Label_OSB18,18,1*OSB_label_spacing+10,0)
Add(Label_OSB18)
use_mipfilter(Label_OSB18)

Label_OSB18_1							= Copy(Label_OSB18)
Label_OSB18_1.value						= "EJECT\n10"
Label_OSB18_1.controllers				= {{"DSMS_inventory_eject_avail"}, {"DSMS_inventory_eject", 1}}
Add(Label_OSB18_1)
use_mipfilter(Label_OSB18_1)

Label_OSB18_2							= Copy(Label_OSB18)
Label_OSB18_2.value						= "EJECT\n15"
Label_OSB18_2.controllers				= {{"DSMS_inventory_eject_avail"}, {"DSMS_inventory_eject", 2}}
Add(Label_OSB18_2)
use_mipfilter(Label_OSB18_2)

Label_OSB18_3							= Copy(Label_OSB18)
Label_OSB18_3.value						= "EJECT\n20"
Label_OSB18_3.controllers				= {{"DSMS_inventory_eject_avail"}, {"DSMS_inventory_eject", 3}}
Add(Label_OSB18_3)
use_mipfilter(Label_OSB18_3)

Label_OSB18_4							= Copy(Label_OSB18)
Label_OSB18_4.value						= "EJECT\n25"
Label_OSB18_4.controllers				= {{"DSMS_inventory_eject_avail"}, {"DSMS_inventory_eject", 4}}
Add(Label_OSB18_4)
use_mipfilter(Label_OSB18_4)

Label_OSB18_5							= Copy(Label_OSB18)
Label_OSB18_5.value						= "EJECT\n30"
Label_OSB18_5.controllers				= {{"DSMS_inventory_eject_avail"}, {"DSMS_inventory_eject", 5}}
Add(Label_OSB18_5)
use_mipfilter(Label_OSB18_5)

addOSB_Box(18, {Label_OSB18_Symb, Label_OSB18, Label_OSB18_1, Label_OSB18_2, Label_OSB18_3, Label_OSB18_4, Label_OSB18_5})
add_osb_hint_controllers(18, _("Eject velocity"), {{"DSMS_inventory_eject_avail"}})

addOSB_Box(19)

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
LabelOSB200.value						= "LUU-1"
LabelOSB200.material					= font_MFCD
LabelOSB200.stringdefs					= txt_labels_font
LabelOSB200.controllers					= {{"DSMS_inventory_flare_name", 0}}
LabelOSB200.UseBackground				= false
LabelOSB200.BackgroundMaterial			= MFCD_SOLID_BLACK
shift_button_pos(LabelOSB200,20,1*OSB_label_spacing+10,0)
Add(LabelOSB200)
use_mipfilter(LabelOSB200)

LabelOSB201								= Copy(LabelOSB200)
LabelOSB201.value						= "LUU-5"
LabelOSB201.controllers					= {{"DSMS_inventory_flare_name", 1}}
Add(LabelOSB201)
use_mipfilter(LabelOSB201)

LabelOSB202								= Copy(LabelOSB200)
LabelOSB202.value						= "LUU-6"
LabelOSB202.controllers					= {{"DSMS_inventory_flare_name", 2}}
Add(LabelOSB202)
use_mipfilter(LabelOSB202)

LabelOSB203								= Copy(LabelOSB200)
LabelOSB203.value						= "LUU-19B"
LabelOSB203.controllers					= {{"DSMS_inventory_flare_name", 3}}
Add(LabelOSB203)
use_mipfilter(LabelOSB203)

LabelOSB204								= Copy(LabelOSB200)
LabelOSB204.value						= "LUU-2/B"
LabelOSB204.controllers					= {{"DSMS_inventory_flare_name", 4}}
Add(LabelOSB204)
use_mipfilter(LabelOSB204)

LabelOSB205								= Copy(LabelOSB200)
LabelOSB205.value						= "LUU-2A/B"
LabelOSB205.controllers					= {{"DSMS_inventory_flare_name", 5}}
Add(LabelOSB205)
use_mipfilter(LabelOSB205)

LabelOSB206								= Copy(LabelOSB200)
LabelOSB206.value						= "LUU-2B/B"
LabelOSB206.controllers					= {{"DSMS_inventory_flare_name", 6}}
Add(LabelOSB206)
use_mipfilter(LabelOSB206)

addOSB_Box(20, {Label_OSB20_Symb, LabelOSB200, LabelOSB201, LabelOSB202, LabelOSB203, LabelOSB204, LabelOSB205, LabelOSB206})
add_osb_static_hint(20, _("Select flare type"))
