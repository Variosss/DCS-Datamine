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
InventorySettingsText.value				= "RACK"
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

Label_OSB6_Symb						= CreateElement "ceStringPoly"
Label_OSB6_Symb.name				= "LABEL_OSB6_SYMB"
Label_OSB6_Symb.alignment			= "RightCenter"
Label_OSB6_Symb.value				= ROTARY
Label_OSB6_Symb.material			= font_MFCD
Label_OSB6_Symb.stringdefs			= txt_labels_font
Label_OSB6_Symb.UseBackground		= false
Label_OSB6_Symb.BackgroundMaterial	= MFCD_SOLID_BLACK
Label_OSB6_Symb.controllers			= {{"DSMS_inventory_rack_dra_avail"}}
shift_button_pos(Label_OSB6_Symb,6,-1*OSB_label_spacing,0)
Add(Label_OSB6_Symb)
use_mipfilter(Label_OSB6_Symb)

Label_DRA							= CreateElement "ceStringPoly"
Label_DRA.name						= "Label_DRA"
Label_DRA.alignment					= "RightCenter"
Label_DRA.value						= "DRA"
Label_DRA.material					= font_MFCD
Label_DRA.stringdefs				= txt_labels_font
Label_DRA.controllers				= {{"DSMS_inventory_rack_dra_avail"}, {"DSMS_inventory_rack_dra", -1}}
Label_DRA.UseBackground				= false
Label_DRA.BackgroundMaterial		= MFCD_SOLID_BLACK
shift_button_pos(Label_DRA,6,-1*OSB_label_spacing-10,0)
Add(Label_DRA)
use_mipfilter(Label_DRA)

Label_I_LAU105							= Copy(Label_DRA)
Label_I_LAU105.value					= "DRA\nI LAU105"
Label_I_LAU105.controllers				= {{"DSMS_inventory_rack_dra_avail"}, {"DSMS_inventory_rack_dra", 1}}
Add(Label_I_LAU105)
use_mipfilter(Label_I_LAU105)

Label_0_LAU105							= Copy(Label_DRA)
Label_0_LAU105.value					= "DRA\n0 LAU105"
Label_0_LAU105.controllers				= {{"DSMS_inventory_rack_dra_avail"}, {"DSMS_inventory_rack_dra", 0}}
Add(Label_0_LAU105)
use_mipfilter(Label_0_LAU105)

Label_2_LAU105							= Copy(Label_DRA)
Label_2_LAU105.value					= "DRA\n2 LAU105"
Label_2_LAU105.controllers				= {{"DSMS_inventory_rack_dra_avail"}, {"DSMS_inventory_rack_dra", 2}}
Add(Label_2_LAU105)
use_mipfilter(Label_2_LAU105)

addOSB_Box(6, {Label_OSB6_Symb, Label_DRA, Label_I_LAU105, Label_0_LAU105, Label_2_LAU105})
add_osb_hint_controllers(6, _("Select empty carriage in station 1/11"), {{"DSMS_inventory_rack_dra_avail"}})

Label_OSB7							= CreateElement "ceStringPoly"
Label_OSB7.name						= "Label_OSB7"
Label_OSB7.alignment				= "RightCenter"
Label_OSB7.value					= ROTARY
Label_OSB7.material					= font_MFCD
Label_OSB7.stringdefs				= txt_labels_font
Label_OSB7.UseBackground			= false
Label_OSB7.BackgroundMaterial		= MFCD_SOLID_BLACK
Label_OSB7.controllers				= {{"DSMS_inventory_lau68_avail"}}
shift_button_pos(Label_OSB7,7,-1*OSB_label_spacing,0)
Add(Label_OSB7)
use_mipfilter(Label_OSB7)

Label_OSB7_1						= CreateElement "ceStringPoly"
Label_OSB7_1.name					= "Label_OSB7_1"
Label_OSB7_1.alignment				= "RightCenter"
Label_OSB7_1.value					= "LAU68"
Label_OSB7_1.material				= font_MFCD
Label_OSB7_1.stringdefs				= txt_labels_font
Label_OSB7_1.controllers			= {{"DSMS_inventory_lau68_avail"}, {"DSMS_inventory_lau68_type", 0}}
Label_OSB7_1.UseBackground			= false
Label_OSB7_1.BackgroundMaterial		= MFCD_SOLID_BLACK
shift_button_pos(Label_OSB7_1,7,-1*OSB_label_spacing-10,0)
Add(Label_OSB7_1)
use_mipfilter(Label_OSB7_1)

Label_OSB7_2						= Copy(Label_OSB7_1)
Label_OSB7_2.value					= "TER\n1 LAU68"
Label_OSB7_2.controllers			= {{"DSMS_inventory_lau68_avail"}, {"DSMS_inventory_lau68_type", 1}}
Add(Label_OSB7_2)
use_mipfilter(Label_OSB7_2)

Label_OSB7_3						= Copy(Label_OSB7_1)
Label_OSB7_3.value					= "TER\n2 LAU68"
Label_OSB7_3.controllers			= {{"DSMS_inventory_lau68_avail"}, {"DSMS_inventory_lau68_type", 2}}
Add(Label_OSB7_3)
use_mipfilter(Label_OSB7_3)

Label_OSB7_4						= Copy(Label_OSB7_1)
Label_OSB7_4.value					= "TER\n3 LAU68"
Label_OSB7_4.controllers			= {{"DSMS_inventory_lau68_avail"}, {"DSMS_inventory_lau68_type", 3}}
Add(Label_OSB7_4)
use_mipfilter(Label_OSB7_4)

addOSB_Box(7, {Label_OSB7, Label_OSB7_1, Label_OSB7_2, Label_OSB7_3, Label_OSB7_4})
add_osb_hint_controllers(7, _("Rocket launcher carrier selection"), {{"DSMS_inventory_lau68_avail"}})

Label_OSB8							= CreateElement "ceStringPoly"
Label_OSB8.name						= "Label_OSB8"
Label_OSB8.alignment				= "RightCenter"
Label_OSB8.value					= ROTARY
Label_OSB8.material					= font_MFCD
Label_OSB8.stringdefs				= txt_labels_font
Label_OSB8.UseBackground			= false
Label_OSB8.BackgroundMaterial		= MFCD_SOLID_BLACK
Label_OSB8.controllers				= {{"DSMS_inventory_lau131_avail"}}
shift_button_pos(Label_OSB8,8,-1*OSB_label_spacing,0)
Add(Label_OSB8)
use_mipfilter(Label_OSB8)

Label_OSB8_1						= CreateElement "ceStringPoly"
Label_OSB8_1.name					= "Label_OSB8_1"
Label_OSB8_1.alignment				= "RightCenter"
Label_OSB8_1.value					= "LAU131"
Label_OSB8_1.material				= font_MFCD
Label_OSB8_1.stringdefs				= txt_labels_font
Label_OSB8_1.controllers			= {{"DSMS_inventory_lau131_avail"}, {"DSMS_inventory_lau131_type", 0}}
Label_OSB8_1.UseBackground			= false
Label_OSB8_1.BackgroundMaterial		= MFCD_SOLID_BLACK
shift_button_pos(Label_OSB8_1,8,-1*OSB_label_spacing-10,0)
Add(Label_OSB8_1)
use_mipfilter(Label_OSB8_1)

Label_OSB8_2						= Copy(Label_OSB8_1)
Label_OSB8_2.value					= "TER\n1 LAU131"
Label_OSB8_2.controllers			= {{"DSMS_inventory_lau131_avail"}, {"DSMS_inventory_lau131_type", 1}}
Add(Label_OSB8_2)
use_mipfilter(Label_OSB8_2)

Label_OSB8_3						= Copy(Label_OSB8_1)
Label_OSB8_3.value					= "TER\n2 LAU131"
Label_OSB8_3.controllers			= {{"DSMS_inventory_lau131_avail"}, {"DSMS_inventory_lau131_type", 2}}
Add(Label_OSB8_3)
use_mipfilter(Label_OSB8_3)

Label_OSB8_4						= Copy(Label_OSB8_1)
Label_OSB8_4.value					= "TER\n3 LAU131"
Label_OSB8_4.controllers			= {{"DSMS_inventory_lau131_avail"}, {"DSMS_inventory_lau131_type", 3}}
Add(Label_OSB8_4)
use_mipfilter(Label_OSB8_4)

addOSB_Box(8, {Label_OSB8, Label_OSB8_1, Label_OSB8_2, Label_OSB8_3, Label_OSB8_4})
add_osb_hint_controllers(8, _("Rocket launcher carrier selection"), {{"DSMS_inventory_lau131_avail"}})

Label_OSB9						= CreateElement "ceStringPoly"
Label_OSB9.name					= "LABEL_OSB9"
Label_OSB9.alignment			= "RightCenter"
Label_OSB9.value				= "LOAD"
Label_OSB9.material				= font_MFCD
Label_OSB9.stringdefs			= txt_labels_font
Label_OSB9.UseBackground		= false
Label_OSB9.BackgroundMaterial	= MFCD_SOLID_BLACK
shift_button_pos(Label_OSB9,9,-1*OSB_label_spacing-10,0)
Add(Label_OSB9)
use_mipfilter(Label_OSB9)

Label_OSB9_symb						= CreateElement "ceStringPoly"
Label_OSB9_symb.name				= "LABEL_OSB9_SYMB"
Label_OSB9_symb.alignment			= "RightCenter"
Label_OSB9_symb.value				= SYS_ACTION
Label_OSB9_symb.material			= font_MFCD
Label_OSB9_symb.stringdefs			= txt_labels_font
Label_OSB9_symb.UseBackground		= false
Label_OSB9_symb.BackgroundMaterial	= MFCD_SOLID_BLACK
Label_OSB9_symb.controllers			= {{"DSMS_inventory_modified"}}
shift_button_pos(Label_OSB9_symb,9,-1*OSB_label_spacing,0)
Add(Label_OSB9_symb)
use_mipfilter(Label_OSB9_symb)
addOSB_Box(9, {Label_OSB9, Label_OSB9_symb})
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
Label_OSB10_symb.controllers		= {{"DSMS_inventory_modified"}, {"DSMS_inventory_load_sym"}}
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
Label_OSB16.controllers				= {{"DSMS_inventory_suu25_avail"}}
shift_button_pos(Label_OSB16,16,1*OSB_label_spacing,0)
Add(Label_OSB16)
use_mipfilter(Label_OSB16)

Label_OSB16_1							= CreateElement "ceStringPoly"
Label_OSB16_1.name						= "Label_OSB16_1"
Label_OSB16_1.alignment					= "LeftCenter"
Label_OSB16_1.value						= "SUU25"
Label_OSB16_1.material					= font_MFCD
Label_OSB16_1.stringdefs				= txt_labels_font
Label_OSB16_1.UseBackground				= false
Label_OSB16_1.BackgroundMaterial		= MFCD_SOLID_BLACK
Label_OSB16_1.controllers				= {{"DSMS_inventory_suu25_avail"}, {"DSMS_inventory_suu25_type", 0}}
shift_button_pos(Label_OSB16_1,16,1*OSB_label_spacing+10,0)
Add(Label_OSB16_1)
use_mipfilter(Label_OSB16_1)

Label_OSB16_2							= Copy(Label_OSB16_1)
Label_OSB16_2.value						= "TER\n1 SUU25"
Label_OSB16_2.controllers				= {{"DSMS_inventory_suu25_avail"}, {"DSMS_inventory_suu25_type", 1}}
Add(Label_OSB16_2)
use_mipfilter(Label_OSB16_2)

Label_OSB16_3							= Copy(Label_OSB16_1)
Label_OSB16_3.value						= "TER\n2 SUU25"
Label_OSB16_3.controllers				= {{"DSMS_inventory_suu25_avail"}, {"DSMS_inventory_suu25_type", 2}}
Add(Label_OSB16_3)
use_mipfilter(Label_OSB16_3)

Label_OSB16_4							= Copy(Label_OSB16_1)
Label_OSB16_4.value						= "TER\n3 SUU25"
Label_OSB16_4.controllers				= {{"DSMS_inventory_suu25_avail"}, {"DSMS_inventory_suu25_type", 3}}
Add(Label_OSB16_4)
use_mipfilter(Label_OSB16_4)

addOSB_Box(16, {Label_OSB16, Label_OSB16_1, Label_OSB16_2, Label_OSB16_3, Label_OSB16_4})
add_osb_hint_controllers(16, _("Flare dispenser carrier selection"), {{"DSMS_inventory_suu25_avail"}})


addOSB_Box(17)

Label_OSB18							= CreateElement "ceStringPoly"
Label_OSB18.name					= "Label_OSB18"
Label_OSB18.alignment				= "LeftCenter"
Label_OSB18.value					= SYS_ACTION .. "LAU-88"
Label_OSB18.material				= font_MFCD
Label_OSB18.stringdefs				= txt_labels_font
Label_OSB18.UseBackground			= false
Label_OSB18.BackgroundMaterial		= MFCD_SOLID_BLACK
Label_OSB18.controllers				= {{"DSMS_inventory_lau88_avail"}}
shift_button_pos(Label_OSB18,18,1*OSB_label_spacing,0)
Add(Label_OSB18)
use_mipfilter(Label_OSB18)
addOSB_Box(18, {Label_OSB18})
add_osb_hint_controllers(18, _("Select LAU-88"), {{"DSMS_inventory_lau88_avail"}})

Label_OSB19							= CreateElement "ceStringPoly"
Label_OSB19.name					= "Label_OSB19"
Label_OSB19.alignment				= "LeftCenter"
Label_OSB19.value					= SYS_ACTION .. "LAU-117"
Label_OSB19.material				= font_MFCD
Label_OSB19.stringdefs				= txt_labels_font
Label_OSB19.UseBackground			= false
Label_OSB19.BackgroundMaterial		= MFCD_SOLID_BLACK
Label_OSB19.controllers				= {{"DSMS_inventory_lau117_avail"}}
shift_button_pos(Label_OSB19,19,1*OSB_label_spacing,0)
Add(Label_OSB19)
use_mipfilter(Label_OSB19)
addOSB_Box(19, {Label_OSB19})
add_osb_hint_controllers(19, _("Select LAU-117"), {{"DSMS_inventory_lau117_avail"}})

Label_OSB20							= CreateElement "ceStringPoly"
Label_OSB20.name					= "Label_OSB20"
Label_OSB20.alignment				= "LeftCenter"
Label_OSB20.value					= SYS_ACTION .. "TER"
Label_OSB20.material				= font_MFCD
Label_OSB20.stringdefs				= txt_labels_font
Label_OSB20.UseBackground			= false
Label_OSB20.BackgroundMaterial		= MFCD_SOLID_BLACK
Label_OSB20.controllers				= {{"DSMS_inventory_ter_avail"}}
shift_button_pos(Label_OSB20,20,1*OSB_label_spacing,0)
Add(Label_OSB20)
use_mipfilter(Label_OSB20)
addOSB_Box(20, {Label_OSB20})
add_osb_hint_controllers(20, _("Select TER"), {{"DSMS_inventory_ter_avail"}})

