dofile(LockOn_Options.script_path.."MFCD/indicator/MFCD_useful_definitions.lua")
dofile(LockOn_Options.script_path.."MFCD/indicator/DSMS/MFCD_DSMS_useful_definitions.lua")

InventoryText							= CreateElement "ceStringPoly"
InventoryText.name						= "InventoryText"
InventoryText.material					= font_MFCD
InventoryText.alignment					= "CenterCenter"
InventoryText.init_pos					= {max_pixels_count/2,OSB_positions[20][2],0}
SetLowerLeftCornerOrigin(InventoryText)
InventoryText.stringdefs				= predefined_fonts[2]
InventoryText.UseBackground				= false
InventoryText.BackgroundMaterial		= MFCD_SOLID_BLACK
InventoryText.value						= "INVENTORY"
Add(InventoryText)
use_mipfilter(InventoryText) 

InventorySettingsText					= CreateElement "ceStringPoly"
InventorySettingsText.name				= "InventorySettingsText"
InventorySettingsText.material			= font_MFCD
InventorySettingsText.alignment			= "CenterCenter"
InventorySettingsText.init_pos			= {max_pixels_count/2,OSB_positions[20][2]-35,0}
SetLowerLeftCornerOrigin(InventorySettingsText)
InventorySettingsText.stringdefs		= predefined_fonts[2]
InventorySettingsText.UseBackground		= false
InventorySettingsText.BackgroundMaterial= MFCD_SOLID_BLACK
InventorySettingsText.value				= "SELECT"
Add(InventorySettingsText)
use_mipfilter(InventorySettingsText) 

AddInventoryTrainingLabel()

labels = {}

AddStatLabel()

AddRetLabel()
add_osb_static_hint(2, _("Return to Inventory Main page"))

labels[3]							= CreateElement "ceStringPoly"
labels[3].name						= "LABEL_OSB3"
labels[3].material					= font_MFCD
labels[3].UseBackground				= false
labels[3].BackgroundMaterial		= MFCD_SOLID_BLACK
labels[3].alignment					= "CenterTop"
labels[3].value						= "INV\nSTAT"
labels[3].stringdefs				= predefined_fonts[1]
shift_button_pos(labels[3], 3)
Add(labels[3])
use_mipfilter(labels[3])

labels3_symb						= CreateElement "ceStringPoly"
labels3_symb.name					= "labels3_symb"
labels3_symb.material				= font_MFCD
labels3_symb.UseBackground			= false
labels3_symb.BackgroundMaterial		= MFCD_SOLID_BLACK
labels3_symb.alignment				= "CenterTop"
labels3_symb.value					= SYS_ACTION
labels3_symb.stringdefs				= predefined_fonts[1]
labels3_symb.controllers			= {{"DSMS_inventory_can_home"}}
shift_button_pos(labels3_symb, 3, -20)
Add(labels3_symb)
use_mipfilter(labels3_symb)

addOSB_Box(3, {labels[3], labels3_symb})
add_osb_hint_controllers(3, _("Go to Inventory Status page"), {{"DSMS_inventory_can_home"}})

labels[4]							= CreateElement "ceStringPoly"
labels[4].name						= "LABEL_OSB4"
labels[4].material					= font_MFCD
labels[4].UseBackground				= false
labels[4].BackgroundMaterial		= MFCD_SOLID_BLACK
labels[4].alignment					= "CenterTop"
labels[4].value						= " HOME\nTER"
labels[4].stringdefs				= predefined_fonts[1]
shift_button_pos(labels[4], 4)
Add(labels[4])
use_mipfilter(labels[4])

addOSB_Box(4, {labels[4]})
add_osb_static_hint(4, _("Set TER Re-Homing, No function"))

labels[5]							= CreateElement "ceStringPoly"
labels[5].name						= "LABEL_OSB5"
labels[5].material					= font_MFCD
labels[5].UseBackground				= false
labels[5].BackgroundMaterial		= MFCD_SOLID_BLACK
labels[5].alignment					= "CenterTop"
labels[5].value						= "CLR\nSTA"
labels[5].stringdefs				= predefined_fonts[1]
shift_button_pos(labels[5], 5)
Add(labels[5])
use_mipfilter(labels[5])

Label_OSB5_symbol					= Copy(labels[5])
Label_OSB5_symbol.value				= SYS_ACTION
Label_OSB5_symbol.controllers		= {{"DSMS_can_clear_station"}}
shift_button_pos(Label_OSB5_symbol, 5, -20)
Add(Label_OSB5_symbol)
use_mipfilter(Label_OSB5_symbol)

addOSB_Box(5, {labels[5], Label_OSB5_symbol})
add_osb_static_hint(5, _("Clear station"))

AddPylonName(0)

AddStationNumber()

AddWpnNameCount()

EmptyStatus								= CreateElement "ceStringPoly"
EmptyStatus.name						= "EmptyStatus"
EmptyStatus.material					= font_MFCD
EmptyStatus.init_pos					= {max_pixels_count/2,OSB_positions[10][2],0}
EmptyStatus.alignment					= "CenterCenter"
EmptyStatus.stringdefs					= txt_labels_font
EmptyStatus.controllers     			= {{"DSMS_inventory_station_detect_status"}, {"DSMS_inventory_error"}}
EmptyStatus.UseBackground				= true
EmptyStatus.BackgroundMaterial			= MFCD_SOLID_BLACK
EmptyStatus.formats 					= {"EMPTY", "MAVERICK DETECTED", "MAV LAU DETECTED", "LITENING DETECTED", "GBU-31 DETECTED",
											"GBU-38 DETECTED", "STORE DETECTED", "CBU-103 DETECTED", "CBU-105 DETECTED", "IAM DETECTED",
											"TGT POD DETECTED", "SNIPER DETECTED", "INVALID TGP DETECTED", "TER DETECTED", 
											"TER+STORE DETECTED", "TER ERROR"}
SetLowerLeftCornerOrigin(EmptyStatus)
Add(EmptyStatus)
use_mipfilter(EmptyStatus) 

CheckLoadout							= CreateElement "ceStringPoly"
CheckLoadout.name						= "EmptyStatus1"
CheckLoadout.material					= font_MFCD_BLACK
CheckLoadout.init_pos					= {max_pixels_count/2,OSB_positions[10][2]+20,0}
CheckLoadout.alignment					= "CenterCenter"
CheckLoadout.stringdefs					= txt_labels_font
CheckLoadout.value 						= "CHECK LOADOUT"
CheckLoadout.controllers     			= {{"DSMS_inventory_error_loadout"}}
CheckLoadout.UseBackground				= true
CheckLoadout.BackgroundMaterial			= MFCD_SOLID_RED
SetLowerLeftCornerOrigin(CheckLoadout)
Add(CheckLoadout)
use_mipfilter(CheckLoadout) 

Label_OSB6						= CreateElement "ceStringPoly"
Label_OSB6.name					= "LABEL_OSB6"
Label_OSB6.alignment			= "RightCenter"
Label_OSB6.value				= "BOMB" .. BRANCH_R
Label_OSB6.material				= font_MFCD
Label_OSB6.stringdefs			= txt_labels_font
Label_OSB6.controllers			= {{"DSMS_inventory_select_bomb"}}
Label_OSB6.UseBackground		= false
Label_OSB6.BackgroundMaterial	= MFCD_SOLID_BLACK
shift_button_pos(Label_OSB6,6,-1*OSB_label_spacing,0)
Add(Label_OSB6)
use_mipfilter(Label_OSB6)
addOSB_Box(6, {Label_OSB6})
add_osb_hint_controllers(6, _("Go to the Bomb Select page"), {{"DSMS_inventory_select_bomb"}})
--add_osb_hint_format_controllers(6, {"Update inventory on station %d"}, {{"DSMS_inventory_select_bomb"}, {"DSMS_inventory_select_hint"}})


Label_OSB7						= CreateElement "ceStringPoly"
Label_OSB7.name					= "LABEL_OSB7"
Label_OSB7.alignment			= "RightCenter"
Label_OSB7.value				= "CBU" .. BRANCH_R
Label_OSB7.material				= font_MFCD
Label_OSB7.stringdefs			= txt_labels_font
Label_OSB7.controllers			= {{"DSMS_inventory_select_cbu"}}
Label_OSB7.UseBackground		= false
Label_OSB7.BackgroundMaterial	= MFCD_SOLID_BLACK
shift_button_pos(Label_OSB7,7,-1*OSB_label_spacing,0)
Add(Label_OSB7)
use_mipfilter(Label_OSB7)
addOSB_Box(7, {Label_OSB7})
add_osb_hint_controllers(7, _("Go to the CBU Select page"), {{"DSMS_inventory_select_cbu"}})
--add_osb_hint_format_controllers(7, {"Update inventory on station %d"}, {{"DSMS_inventory_select_cbu"}, {"DSMS_inventory_select_hint"}})

Label_OSB8						= CreateElement "ceStringPoly"
Label_OSB8.name					= "LABEL_OSB8"
Label_OSB8.alignment			= "RightCenter"
Label_OSB8.value				= "GBU" .. BRANCH_R
Label_OSB8.material				= font_MFCD
Label_OSB8.stringdefs			= txt_labels_font
Label_OSB8.controllers			= {{"DSMS_inventory_select_gbu"}}
Label_OSB8.UseBackground		= false
Label_OSB8.BackgroundMaterial	= MFCD_SOLID_BLACK
shift_button_pos(Label_OSB8,8,-1*OSB_label_spacing,0)
Add(Label_OSB8)
use_mipfilter(Label_OSB8)
addOSB_Box(8, {Label_OSB8})
add_osb_hint_controllers(8, _("Go to the GBU Select page"), {{"DSMS_inventory_select_gbu"}})
--add_osb_hint_format_controllers(8, {"Update inventory on station %d"}, {{"DSMS_inventory_select_gbu"}, {"DSMS_inventory_select_hint"}})

Label_OSB9						= CreateElement "ceStringPoly"
Label_OSB9.name					= "LABEL_OSB9"
Label_OSB9.alignment			= "RightCenter"
Label_OSB9.value				= "MISC" .. BRANCH_R
Label_OSB9.material				= font_MFCD
Label_OSB9.stringdefs			= txt_labels_font
Label_OSB9.controllers			= {{"DSMS_inventory_select_misc"}}
Label_OSB9.UseBackground		= false
Label_OSB9.BackgroundMaterial	= MFCD_SOLID_BLACK
shift_button_pos(Label_OSB9,9,-1*OSB_label_spacing,0)
Add(Label_OSB9)
use_mipfilter(Label_OSB9)
addOSB_Box(9, {Label_OSB9})
add_osb_hint_controllers(9, _("Go to the Misc. Stores page"), {{"DSMS_inventory_select_misc"}})
--add_osb_hint_format_controllers(9, {"Update inventory on station %d"}, {{"DSMS_inventory_select_misc"}, {"DSMS_inventory_select_hint"}})

addOSB_Box(10)

Label_OSB16							= CreateElement "ceStringPoly"
Label_OSB16.name					= "Label_OSB16"
Label_OSB16.alignment				= "LeftCenter"
Label_OSB16.value					= BRANCH_L .. "ROCKET"
Label_OSB16.material				= font_MFCD
Label_OSB16.stringdefs				= txt_labels_font
Label_OSB16.UseBackground			= false
Label_OSB16.BackgroundMaterial		= MFCD_SOLID_BLACK
Label_OSB16.controllers				= {{"DSMS_inventory_select_rocket"}}
shift_button_pos(Label_OSB16,16,0,0)
Add(Label_OSB16)
use_mipfilter(Label_OSB16)
addOSB_Box(16, {Label_OSB16})
add_osb_hint_controllers(16, _("Go to the Rocket Select page"), {{"DSMS_inventory_select_rocket"}})
--add_osb_hint_format_controllers(16, {"Update inventory on station %d"}, {{"DSMS_inventory_select_rocket"}, {"DSMS_inventory_select_hint"}})

Label_OSB17							= CreateElement "ceStringPoly"
Label_OSB17.name					= "Label_OSB17"
Label_OSB17.alignment				= "LeftCenter"
Label_OSB17.value					= BRANCH_L .. "FLARE"
Label_OSB17.material				= font_MFCD
Label_OSB17.stringdefs				= txt_labels_font
Label_OSB17.UseBackground			= false
Label_OSB17.BackgroundMaterial		= MFCD_SOLID_BLACK
Label_OSB17.controllers				= {{"DSMS_inventory_select_flare"}}
shift_button_pos(Label_OSB17,17,0,0)
Add(Label_OSB17)
use_mipfilter(Label_OSB17)
addOSB_Box(17, {Label_OSB17})
add_osb_hint_controllers(17, _("Go to the Flare Select page"), {{"DSMS_inventory_select_flare"}})
--add_osb_hint_format_controllers(17, {"Update inventory on station %d"}, {{"DSMS_inventory_select_flare"}, {"DSMS_inventory_select_hint"}})

Label_OSB18							= CreateElement "ceStringPoly"
Label_OSB18.name					= "Label_OSB18"
Label_OSB18.alignment				= "LeftCenter"
Label_OSB18.value					= BRANCH_L .. "MISSILE"
Label_OSB18.material				= font_MFCD
Label_OSB18.stringdefs				= txt_labels_font
Label_OSB18.UseBackground			= false
Label_OSB18.BackgroundMaterial		= MFCD_SOLID_BLACK
Label_OSB18.controllers				= {{"DSMS_inventory_select_missile"}}
shift_button_pos(Label_OSB18,18,0,0)
Add(Label_OSB18)
use_mipfilter(Label_OSB18)
addOSB_Box(18, {Label_OSB18})
add_osb_hint_controllers(18, _("Go to the Missile Select page"), {{"DSMS_inventory_select_missile"}})
--add_osb_hint_format_controllers(18, {"Update inventory on station %d"}, {{"DSMS_inventory_select_missile"}, {"DSMS_inventory_select_hint"}})

Label_OSB19							= CreateElement "ceStringPoly"
Label_OSB19.name					= "Label_OSB19"
Label_OSB19.alignment				= "LeftCenter"
Label_OSB19.value					= BRANCH_L .. "POD"
Label_OSB19.material				= font_MFCD
Label_OSB19.stringdefs				= txt_labels_font
Label_OSB19.UseBackground			= false
Label_OSB19.BackgroundMaterial		= MFCD_SOLID_BLACK
Label_OSB19.controllers				= {{"DSMS_inventory_select_pod"}}
shift_button_pos(Label_OSB19,19,0,0)
Add(Label_OSB19)
use_mipfilter(Label_OSB19)
addOSB_Box(19, {Label_OSB19})
add_osb_hint_controllers(19, _("Go to the POD Select page"), {{"DSMS_inventory_select_pod"}})
--add_osb_hint_format_controllers(19, {"Update inventory on station %d"}, {{"DSMS_inventory_select_pod"}, {"DSMS_inventory_select_hint"}})

Label_OSB20							= CreateElement "ceStringPoly"
Label_OSB20.name					= "Label_OSB20"
Label_OSB20.alignment				= "LeftCenter"
Label_OSB20.value					= BRANCH_L .. "RACK"
Label_OSB20.material				= font_MFCD
Label_OSB20.stringdefs				= txt_labels_font
Label_OSB20.UseBackground			= false
Label_OSB20.BackgroundMaterial		= MFCD_SOLID_BLACK
Label_OSB20.controllers				= {{"DSMS_inventory_select_rack"}}
shift_button_pos(Label_OSB20,20,0,0)
Add(Label_OSB20)
use_mipfilter(Label_OSB20)
addOSB_Box(20, {Label_OSB20})
add_osb_hint_controllers(20, _("Go to the Rack Select page"), {{"DSMS_inventory_select_rack"}})
--add_osb_hint_format_controllers(20, {"Update inventory on station %d"}, {{"DSMS_inventory_select_rack"}, {"DSMS_inventory_select_hint"}})

