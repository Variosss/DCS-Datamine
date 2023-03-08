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
InventorySettingsText.value				= "MAVERICK"
Add(InventorySettingsText)
use_mipfilter(InventorySettingsText) 

AddInventoryTrainingLabel()

labels = {}

AddStatLabel()

AddRetLabel()
add_osb_static_hint(2, _("Return to Class Select page"))

addOSB_Box(3)

OsbLabelAGM							= CreateElement "ceStringPoly"
OsbLabelAGM.name					= "OsbLabelAGM"
OsbLabelAGM.material				= font_MFCD
OsbLabelAGM.UseBackground			= false
OsbLabelAGM.BackgroundMaterial		= MFCD_SOLID_BLACK
OsbLabelAGM.alignment				= "CenterTop"
OsbLabelAGM.value					= ROTARY .. "AGM"
OsbLabelAGM.stringdefs				= predefined_fonts[1]
OsbLabelAGM.controllers				= {{"DSMS_inventory_mav_agm", 1}}
shift_button_pos(OsbLabelAGM, 4)
Add(OsbLabelAGM)
use_mipfilter(OsbLabelAGM)

OsbLabelTGM							= Copy(OsbLabelAGM)
OsbLabelTGM.value					= ROTARY .. "TGM"
OsbLabelTGM.controllers				= {{"DSMS_inventory_mav_agm", 0}}
Add(OsbLabelTGM)
use_mipfilter(OsbLabelTGM)

addOSB_Box(4, {OsbLabelAGM, OsbLabelTGM})
add_osb_static_hint(4, _("Live or training type"))

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
OsbLabelQTY_symb.controllers			= {{"DSMS_inventory_mav_lau", 1}}
shift_button_pos(OsbLabelQTY_symb, 5, -23)
Add(OsbLabelQTY_symb)
use_mipfilter(OsbLabelQTY_symb)

addOSB_Box(5, {OsbLabelQTY, OsbLabelQTY_symb})
add_osb_static_hint(5, _("Number of store on launcher"))

AddPylonName(1)

AddStationNumber()

AddWpnNameCount()

Label_OSB6_AGM							= CreateElement "ceStringPoly"
Label_OSB6_AGM.name						= "Label_OSB6_AGM"
Label_OSB6_AGM.alignment				= "RightCenter"
Label_OSB6_AGM.value					= "AGM-65H" .. SYS_ACTION
Label_OSB6_AGM.material					= font_MFCD
Label_OSB6_AGM.stringdefs				= txt_labels_font
Label_OSB6_AGM.UseBackground			= false
Label_OSB6_AGM.BackgroundMaterial		= MFCD_SOLID_BLACK
Label_OSB6_AGM.controllers				= {{"DSMS_inventory_mav_agm", 1}}
shift_button_pos(Label_OSB6_AGM,6,-1*OSB_label_spacing,0)
Add(Label_OSB6_AGM)
use_mipfilter(Label_OSB6_AGM)

Label_OSB6_TGM							= Copy(Label_OSB6_AGM)
Label_OSB6_TGM.value					= "TGM-65H" .. SYS_ACTION
Label_OSB6_TGM.controllers				= {{"DSMS_inventory_mav_agm", 0}}
Add(Label_OSB6_TGM)
use_mipfilter(Label_OSB6_TGM)

addOSB_Box(6, {Label_OSB6_AGM, Label_OSB6_TGM})
add_osb_hint_format_controllers(6, {_("AGM-65H select"), _("TGM-65H select")}, {{"DSMS_inventory_mav_agm_hint"}})

Label_OSB7_AGM							= CreateElement "ceStringPoly"
Label_OSB7_AGM.name						= "Label_OSB7_AGM"
Label_OSB7_AGM.alignment				= "RightCenter"
Label_OSB7_AGM.value					= "AGM-65K" .. SYS_ACTION
Label_OSB7_AGM.material					= font_MFCD
Label_OSB7_AGM.stringdefs				= txt_labels_font
Label_OSB7_AGM.UseBackground			= false
Label_OSB7_AGM.BackgroundMaterial		= MFCD_SOLID_BLACK
Label_OSB7_AGM.controllers				= {{"DSMS_inventory_mav_agm", 1}}
shift_button_pos(Label_OSB7_AGM,7,-1*OSB_label_spacing,0)
Add(Label_OSB7_AGM)
use_mipfilter(Label_OSB7_AGM)

Label_OSB7_TGM							= Copy(Label_OSB7_AGM)
Label_OSB7_TGM.value					= "CATM-65K" .. SYS_ACTION
Label_OSB7_TGM.controllers				= {{"DSMS_inventory_mav_agm", 0}}
Add(Label_OSB7_TGM)
use_mipfilter(Label_OSB7_TGM)

addOSB_Box(7, {Label_OSB7_AGM, Label_OSB7_TGM})
add_osb_hint_format_controllers(7, {_("AGM-65K select"), _("CATM-65K select")}, {{"DSMS_inventory_mav_agm_hint"}})

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

Label_LAU117						= CreateElement "ceStringPoly"
Label_LAU117.name					= "Label_LAU117"
Label_LAU117.alignment				= "RightCenter"
Label_LAU117.value					= "LAUNCHER\nLAU117"
Label_LAU117.material				= font_MFCD
Label_LAU117.stringdefs				= txt_labels_font
Label_LAU117.controllers			= {{"DSMS_inventory_mav_lau", 0}}
Label_LAU117.UseBackground			= false
Label_LAU117.BackgroundMaterial		= MFCD_SOLID_BLACK
shift_button_pos(Label_LAU117,8,-1*OSB_label_spacing-10,0)
Add(Label_LAU117)
use_mipfilter(Label_LAU117)

Label_LAU88							= Copy(Label_LAU117)
Label_LAU88.value					= "LAUNCHER\nLAU88"
Label_LAU88.controllers				= {{"DSMS_inventory_mav_lau", 1}}
Add(Label_LAU88)
use_mipfilter(Label_LAU88)

addOSB_Box(8, {Label_OSB8_Symb, Label_LAU117, Label_LAU88})
add_osb_static_hint(8, _("Launcher type"))

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

addOSB_Box(10, {Label_OSB10, Label_OSB10_symb})
add_osb_static_hint(10, _("Load Store on Symmetric Stations"))

addOSB_Box(16)

Label_OSB17_AGM							= CreateElement "ceStringPoly"
Label_OSB17_AGM.name					= "Label_OSB17_AGM"
Label_OSB17_AGM.alignment				= "LeftCenter"
Label_OSB17_AGM.value					= SYS_ACTION .. "AGM-65G"
Label_OSB17_AGM.material				= font_MFCD
Label_OSB17_AGM.stringdefs				= txt_labels_font
Label_OSB17_AGM.UseBackground			= false
Label_OSB17_AGM.BackgroundMaterial		= MFCD_SOLID_BLACK
Label_OSB17_AGM.controllers				= {{"DSMS_inventory_mav_agm", 1}}
shift_button_pos(Label_OSB17_AGM,17,1*OSB_label_spacing,0)
Add(Label_OSB17_AGM)
use_mipfilter(Label_OSB17_AGM)

Label_OSB17_TGM							= Copy(Label_OSB17_AGM)
Label_OSB17_TGM.value					= SYS_ACTION .. "TGM-65G"
Label_OSB17_TGM.controllers				= {{"DSMS_inventory_mav_agm", 0}}
Add(Label_OSB17_TGM)
use_mipfilter(Label_OSB17_TGM)

addOSB_Box(17, {Label_OSB17_AGM, Label_OSB17_TGM})
add_osb_hint_format_controllers(17, {"AGM-65G select", "TGM-65G select"}, {{"DSMS_inventory_mav_agm_hint"}})

Label_OSB18_AGM							= CreateElement "ceStringPoly"
Label_OSB18_AGM.name					= "Label_OSB18_AGM"
Label_OSB18_AGM.alignment				= "LeftCenter"
Label_OSB18_AGM.value					= SYS_ACTION .. "AGM-65D"
Label_OSB18_AGM.material				= font_MFCD
Label_OSB18_AGM.stringdefs				= txt_labels_font
Label_OSB18_AGM.UseBackground			= false
Label_OSB18_AGM.BackgroundMaterial		= MFCD_SOLID_BLACK
Label_OSB18_AGM.controllers				= {{"DSMS_inventory_mav_agm", 1}}
shift_button_pos(Label_OSB18_AGM,18,1*OSB_label_spacing,0)
Add(Label_OSB18_AGM)
use_mipfilter(Label_OSB18_AGM)

Label_OSB18_TGM							= Copy(Label_OSB18_AGM)
Label_OSB18_TGM.value					= SYS_ACTION .. "TGM-65D"
Label_OSB18_TGM.controllers				= {{"DSMS_inventory_mav_agm", 0}}
Add(Label_OSB18_TGM)
use_mipfilter(Label_OSB18_TGM)

addOSB_Box(18, {Label_OSB18_AGM, Label_OSB18_TGM})
add_osb_hint_format_controllers(18, {_("AGM-65D select"), _("TGM-65D select")}, {{"DSMS_inventory_mav_agm_hint"}})

Label_OSB19_AGM							= CreateElement "ceStringPoly"
Label_OSB19_AGM.name					= "Label_OSB19_AGM"
Label_OSB19_AGM.alignment				= "LeftCenter"
Label_OSB19_AGM.value					= SYS_ACTION .. "AGM-65B"
Label_OSB19_AGM.material				= font_MFCD
Label_OSB19_AGM.stringdefs				= txt_labels_font
Label_OSB19_AGM.UseBackground			= false
Label_OSB19_AGM.BackgroundMaterial		= MFCD_SOLID_BLACK
Label_OSB19_AGM.controllers				= {{"DSMS_inventory_mav_agm", 1}}
shift_button_pos(Label_OSB19_AGM,19,1*OSB_label_spacing,0)
Add(Label_OSB19_AGM)
use_mipfilter(Label_OSB19_AGM)

Label_OSB19_TGM							= Copy(Label_OSB19_AGM)
Label_OSB19_TGM.value					= SYS_ACTION .. "TGM-65B"
Label_OSB19_TGM.controllers				= {{"DSMS_inventory_mav_agm", 0}}
Add(Label_OSB19_TGM)
use_mipfilter(Label_OSB19_TGM)

addOSB_Box(19, {Label_OSB19_AGM, Label_OSB19_TGM})
add_osb_hint_format_controllers(19, {_("AGM-65B select"), _("TGM-65B select")}, {{"DSMS_inventory_mav_agm_hint"}})

addOSB_Box(20)
