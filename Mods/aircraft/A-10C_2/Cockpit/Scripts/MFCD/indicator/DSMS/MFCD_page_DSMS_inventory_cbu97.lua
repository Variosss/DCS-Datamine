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
InventorySettingsText.value				= "CBU-97"
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

add_dummy_boxes({16, 17})

Label_OSB18							= CreateElement "ceStringPoly"
Label_OSB18.name					= "Label_OSB18"
Label_OSB18.alignment				= "LeftCenter"
Label_OSB18.value					= ROTARY
Label_OSB18.material				= font_MFCD
Label_OSB18.stringdefs				= txt_labels_font
Label_OSB18.UseBackground			= false
Label_OSB18.BackgroundMaterial		= MFCD_SOLID_BLACK
Label_OSB18.controllers				= {{"DSMS_inventory_hof_avail"}}
shift_button_pos(Label_OSB18,18,1*OSB_label_spacing,0)
Add(Label_OSB18)
use_mipfilter(Label_OSB18)

Label_OSB18_type					= CreateElement "ceStringPoly"
Label_OSB18_type.name				= "Label_OSB18_type"
Label_OSB18_type.alignment			= "LeftCenter"
Label_OSB18_type.formats			= {"HOF\n%s"}
Label_OSB18_type.material			= font_MFCD
Label_OSB18_type.stringdefs			= txt_labels_font
Label_OSB18_type.UseBackground		= false
Label_OSB18_type.BackgroundMaterial	= MFCD_SOLID_BLACK
Label_OSB18_type.controllers		= {{"DSMS_inventory_hof_avail"}, {"DSMS_inventory_hof", 0}}
shift_button_pos(Label_OSB18_type,18,1*OSB_label_spacing+10,0)
Add(Label_OSB18_type)
use_mipfilter(Label_OSB18_type)

addOSB_Box(18, {Label_OSB18, Label_OSB18_type})
add_osb_hint_controllers(18, _("CBU height of function setting"), {{"DSMS_inventory_hof_avail"}})

Label_OSB19							= CreateElement "ceStringPoly"
Label_OSB19.name					= "Label_OSB19"
Label_OSB19.alignment				= "LeftCenter"
Label_OSB19.value					= ROTARY
Label_OSB19.material				= font_MFCD
Label_OSB19.stringdefs				= txt_labels_font
Label_OSB19.UseBackground			= false
Label_OSB19.BackgroundMaterial		= MFCD_SOLID_BLACK
shift_button_pos(Label_OSB19,19,1*OSB_label_spacing,0)
Add(Label_OSB19)
use_mipfilter(Label_OSB19)

Label_OSB19_type					= CreateElement "ceStringPoly"
Label_OSB19_type.name				= "Label_OSB19_type"
Label_OSB19_type.alignment			= "LeftCenter"
Label_OSB19_type.formats			= {"FNC TIME\n%s"}
Label_OSB19_type.material			= font_MFCD
Label_OSB19_type.stringdefs			= txt_labels_font
Label_OSB19_type.UseBackground		= false
Label_OSB19_type.BackgroundMaterial	= MFCD_SOLID_BLACK
Label_OSB19_type.controllers		= {{"DSMS_inventory_func_time", 0}}
shift_button_pos(Label_OSB19_type,19,1*OSB_label_spacing+10,0)
Add(Label_OSB19_type)
use_mipfilter(Label_OSB19_type)

addOSB_Box(19, {Label_OSB19, Label_OSB19_type})
add_osb_static_hint(19, _("CBU function time setting"))

Label_OSB20							= CreateElement "ceStringPoly"
Label_OSB20.name					= "Label_OSB20"
Label_OSB20.alignment				= "LeftCenter"
Label_OSB20.value					= ROTARY
Label_OSB20.material				= font_MFCD
Label_OSB20.stringdefs				= txt_labels_font
Label_OSB20.UseBackground			= false
Label_OSB20.BackgroundMaterial		= MFCD_SOLID_BLACK
shift_button_pos(Label_OSB20,20,1*OSB_label_spacing,0)
Add(Label_OSB20)
use_mipfilter(Label_OSB20)

Label_OSB20_type					= CreateElement "ceStringPoly"
Label_OSB20_type.name				= "Label_OSB20_type"
Label_OSB20_type.alignment			= "LeftCenter"
Label_OSB20_type.value	 			= "FZU39\nYES"
Label_OSB20_type.material			= font_MFCD
Label_OSB20_type.stringdefs			= txt_labels_font
Label_OSB20_type.UseBackground		= false
Label_OSB20_type.BackgroundMaterial	= MFCD_SOLID_BLACK
Label_OSB20_type.controllers		= {{"DSMS_inventory_fzu39", 0}}
shift_button_pos(Label_OSB20_type,20,1*OSB_label_spacing+10,0)
Add(Label_OSB20_type)
use_mipfilter(Label_OSB20_type)

Label_OSB20_1						= Copy(Label_OSB20_type)
Label_OSB20_1.value					= "FZU39\nNO"
Label_OSB20_1.controllers			= {{"DSMS_inventory_fzu39", 1}}
Add(Label_OSB20_1)
use_mipfilter(Label_OSB20_1)

addOSB_Box(20, {Label_OSB20, Label_OSB20_type, Label_OSB20_1})
add_osb_static_hint(20, _("FZU-39 radar proximity fuze installed?"))
