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
InventorySettingsText.value				= "POD"
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

Label_OSB6						= CreateElement "ceStringPoly"
Label_OSB6.name					= "LABEL_OSB6"
Label_OSB6.alignment			= "RightCenter"
Label_OSB6.value				= "SNIPER" .. SYS_ACTION
Label_OSB6.material				= font_MFCD
Label_OSB6.stringdefs			= txt_labels_font
Label_OSB6.controllers			= {{"DSMS_inventory_litening_avail"}}
Label_OSB6.UseBackground		= false
Label_OSB6.BackgroundMaterial	= MFCD_SOLID_BLACK
shift_button_pos(Label_OSB6,6,-1*OSB_label_spacing,0)
Add(Label_OSB6)
use_mipfilter(Label_OSB6)
addOSB_Box(6, {Label_OSB6})
add_osb_hint_controllers(6, _("Select Sniper pod"), {{"DSMS_inventory_litening_avail"}})

Label_OSB7						= CreateElement "ceStringPoly"
Label_OSB7.name					= "LABEL_OSB7"
Label_OSB7.alignment			= "RightCenter"
Label_OSB7.value				= "LITENING" .. SYS_ACTION
Label_OSB7.material				= font_MFCD
Label_OSB7.stringdefs			= txt_labels_font
Label_OSB7.controllers			= {{"DSMS_inventory_litening_avail"}}
Label_OSB7.UseBackground		= false
Label_OSB7.BackgroundMaterial	= MFCD_SOLID_BLACK
shift_button_pos(Label_OSB7,7,-1*OSB_label_spacing,0)
Add(Label_OSB7)
use_mipfilter(Label_OSB7)
addOSB_Box(7, {Label_OSB7})
add_osb_hint_controllers(7, _("Select Litening II pod"), {{"DSMS_inventory_litening_avail"}})

add_dummy_boxes({8, 16})

Label_OSB17_Symb						= CreateElement "ceStringPoly"
Label_OSB17_Symb.name					= "LABEL_OSB17_SYMB"
Label_OSB17_Symb.alignment				= "LeftCenter"
Label_OSB17_Symb.value					= SYS_ACTION
Label_OSB17_Symb.material				= font_MFCD
Label_OSB17_Symb.stringdefs				= txt_labels_font
Label_OSB17_Symb.UseBackground			= false
Label_OSB17_Symb.BackgroundMaterial		= MFCD_SOLID_BLACK
Label_OSB17_Symb.controllers			= {{"DSMS_inventory_alq131_avail"}}
shift_button_pos(Label_OSB17_Symb,17,1*OSB_label_spacing,0)
Add(Label_OSB17_Symb)
use_mipfilter(Label_OSB17_Symb)

Label_ALQ131S							= CreateElement "ceStringPoly"
Label_ALQ131S.name						= "Label_ALQ131S"
Label_ALQ131S.alignment					= "LeftCenter"
Label_ALQ131S.value						= "ALQ-131\nSHALLOW"
Label_ALQ131S.material					= font_MFCD
Label_ALQ131S.stringdefs				= txt_labels_font
Label_ALQ131S.UseBackground				= false
Label_ALQ131S.BackgroundMaterial		= MFCD_SOLID_BLACK
Label_ALQ131S.controllers				= {{"DSMS_inventory_alq131_avail"}}
shift_button_pos(Label_ALQ131S,17,1*OSB_label_spacing+10,0)
Add(Label_ALQ131S)
use_mipfilter(Label_ALQ131S)

addOSB_Box(17, {Label_OSB17_Symb, Label_ALQ131S})
add_osb_hint_controllers(17, _("Select ALQ-131 shallow"), {{"DSMS_inventory_alq131_avail"}})

Label_OSB18_Symb						= CreateElement "ceStringPoly"
Label_OSB18_Symb.name					= "LABEL_OSB18_SYMB"
Label_OSB18_Symb.alignment				= "LeftCenter"
Label_OSB18_Symb.value					= SYS_ACTION
Label_OSB18_Symb.material				= font_MFCD
Label_OSB18_Symb.stringdefs				= txt_labels_font
Label_OSB18_Symb.UseBackground			= false
Label_OSB18_Symb.BackgroundMaterial		= MFCD_SOLID_BLACK
Label_OSB18_Symb.controllers			= {{"DSMS_inventory_alq131_avail"}}
shift_button_pos(Label_OSB18_Symb,18,1*OSB_label_spacing,0)
Add(Label_OSB18_Symb)
use_mipfilter(Label_OSB18_Symb)

Label_ALQ131D							= CreateElement "ceStringPoly"
Label_ALQ131D.name						= "Label_ALQ131D"
Label_ALQ131D.alignment					= "LeftCenter"
Label_ALQ131D.value						= "ALQ-131\nDEEP"
Label_ALQ131D.material					= font_MFCD
Label_ALQ131D.stringdefs				= txt_labels_font
Label_ALQ131D.UseBackground				= false
Label_ALQ131D.BackgroundMaterial		= MFCD_SOLID_BLACK
Label_ALQ131D.controllers				= {{"DSMS_inventory_alq131_avail"}}
shift_button_pos(Label_ALQ131D,18,1*OSB_label_spacing+10,0)
Add(Label_ALQ131D)
use_mipfilter(Label_ALQ131D)

addOSB_Box(18, {Label_OSB18_Symb, Label_ALQ131D})
add_osb_hint_controllers(18, _("Select ALQ-131 deep"), {{"DSMS_inventory_alq131_avail"}})

Label_OSB19_Symb						= CreateElement "ceStringPoly"
Label_OSB19_Symb.name					= "LABEL_OSB19_SYMB"
Label_OSB19_Symb.alignment				= "LeftCenter"
Label_OSB19_Symb.value					= SYS_ACTION
Label_OSB19_Symb.material				= font_MFCD
Label_OSB19_Symb.stringdefs				= txt_labels_font
Label_OSB19_Symb.UseBackground			= false
Label_OSB19_Symb.BackgroundMaterial		= MFCD_SOLID_BLACK
Label_OSB19_Symb.controllers			= {{"DSMS_inventory_alq184_avail"}}
shift_button_pos(Label_OSB19_Symb,19,1*OSB_label_spacing,0)
Add(Label_OSB19_Symb)
use_mipfilter(Label_OSB19_Symb)

Label_ALQ184S							= CreateElement "ceStringPoly"
Label_ALQ184S.name						= "Label_ALQ184S"
Label_ALQ184S.alignment					= "LeftCenter"
Label_ALQ184S.value						= "ALQ-184\nSHORT"
Label_ALQ184S.material					= font_MFCD
Label_ALQ184S.stringdefs				= txt_labels_font
Label_ALQ184S.UseBackground				= false
Label_ALQ184S.BackgroundMaterial		= MFCD_SOLID_BLACK
Label_ALQ184S.controllers				= {{"DSMS_inventory_alq184_avail"}}
shift_button_pos(Label_ALQ184S,19,1*OSB_label_spacing+10,0)
Add(Label_ALQ184S)
use_mipfilter(Label_ALQ184S)

addOSB_Box(19, {Label_OSB19_Symb, Label_ALQ184S})
add_osb_hint_controllers(19, _("Select ALQ-184 short"), {{"DSMS_inventory_alq184_avail"}})

Label_OSB20_Symb						= CreateElement "ceStringPoly"
Label_OSB20_Symb.name					= "LABEL_OSB20_SYMB"
Label_OSB20_Symb.alignment				= "LeftCenter"
Label_OSB20_Symb.value					= SYS_ACTION
Label_OSB20_Symb.material				= font_MFCD
Label_OSB20_Symb.stringdefs				= txt_labels_font
Label_OSB20_Symb.UseBackground			= false
Label_OSB20_Symb.BackgroundMaterial		= MFCD_SOLID_BLACK
Label_OSB20_Symb.controllers			= {{"DSMS_inventory_alq184_avail"}}
shift_button_pos(Label_OSB20_Symb,20,1*OSB_label_spacing,0)
Add(Label_OSB20_Symb)
use_mipfilter(Label_OSB20_Symb)

Label_ALQ184L							= CreateElement "ceStringPoly"
Label_ALQ184L.name						= "Label_ALQ184L"
Label_ALQ184L.alignment					= "LeftCenter"
Label_ALQ184L.value						= "ALQ-184\nLONG"
Label_ALQ184L.material					= font_MFCD
Label_ALQ184L.stringdefs				= txt_labels_font
Label_ALQ184L.UseBackground				= false
Label_ALQ184L.BackgroundMaterial		= MFCD_SOLID_BLACK
Label_ALQ184L.controllers				= {{"DSMS_inventory_alq184_avail"}}
shift_button_pos(Label_ALQ184L,20,1*OSB_label_spacing+10,0)
Add(Label_ALQ184L)
use_mipfilter(Label_ALQ184L)

addOSB_Box(20, {Label_OSB20_Symb, Label_ALQ184L})
add_osb_hint_controllers(20, _("Select ALQ-184 long"), {{"DSMS_inventory_alq184_avail"}})

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
add_osb_static_hint(9,_("Load store to station"))

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

