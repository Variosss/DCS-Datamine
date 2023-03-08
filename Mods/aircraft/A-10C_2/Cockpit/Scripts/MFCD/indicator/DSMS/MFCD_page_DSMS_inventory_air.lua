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
InventorySettingsText.value				= "AIR-AIR"
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

WpnNameCount0							= CreateElement "ceStringPoly"
WpnNameCount0.name						= "WpnNameCount"
WpnNameCount0.material					= font_MFCD
WpnNameCount0.init_pos					= {max_pixels_count/2,OSB_positions[20][2]-210,0}
WpnNameCount0.alignment					= "CenterCenter"
WpnNameCount0.stringdefs				= predefined_fonts[2]
WpnNameCount0.value 					= "2 AIM-9"
WpnNameCount0.controllers     			= {{"DSMS_inventory_air_name", 0}}
WpnNameCount0.UseBackground				= false
WpnNameCount0.BackgroundMaterial		= MFCD_SOLID_BLACK
SetLowerLeftCornerOrigin(WpnNameCount0)
Add(WpnNameCount0)
use_mipfilter(WpnNameCount0) 

WpnNameCount1							= Copy(WpnNameCount0)
WpnNameCount1.value						= "1 AIM-9"
WpnNameCount1.controllers				= {{"DSMS_inventory_air_name", 1}}
Add(WpnNameCount1)
use_mipfilter(WpnNameCount1)

WpnNameCount2							= Copy(WpnNameCount0)
WpnNameCount2.value						= "0 AIM-9"
WpnNameCount2.controllers				= {{"DSMS_inventory_air_name", 2}}
Add(WpnNameCount2)
use_mipfilter(WpnNameCount2)

WpnNameCount3							= Copy(WpnNameCount0)
WpnNameCount3.value						= "2 CAP-9"
WpnNameCount3.controllers				= {{"DSMS_inventory_air_name", 3}}
Add(WpnNameCount3)
use_mipfilter(WpnNameCount3)

WpnNameCount4							= Copy(WpnNameCount0)
WpnNameCount4.value						= "1 CAP-9"
WpnNameCount4.controllers				= {{"DSMS_inventory_air_name", 4}}
Add(WpnNameCount4)
use_mipfilter(WpnNameCount4)

WpnNameCount5							= Copy(WpnNameCount0)
WpnNameCount5.value						= "0 CAP-9"
WpnNameCount5.controllers				= {{"DSMS_inventory_air_name", 5}}
Add(WpnNameCount5)
use_mipfilter(WpnNameCount5)

WpnNameCount6							= Copy(WpnNameCount0)
WpnNameCount6.value						= "CATM-AIS"
WpnNameCount6.controllers				= {{"DSMS_inventory_air_name", 6}}
Add(WpnNameCount6)
use_mipfilter(WpnNameCount6)

WpnNameCount7							= Copy(WpnNameCount0)
WpnNameCount7.value						= "CATM-AIS"
WpnNameCount7.controllers				= {{"DSMS_inventory_air_name", 7}}
Add(WpnNameCount7)
use_mipfilter(WpnNameCount7)

WpnNameCount8							= Copy(WpnNameCount0)
WpnNameCount8.value						= "1 AIS POD"
WpnNameCount8.controllers				= {{"DSMS_inventory_air_name", 8}}
Add(WpnNameCount8)
use_mipfilter(WpnNameCount8)

WpnNameCount9							= Copy(WpnNameCount0)
WpnNameCount9.value						= "0 AIS POD"
WpnNameCount9.controllers				= {{"DSMS_inventory_air_name", 9}}
Add(WpnNameCount9)
use_mipfilter(WpnNameCount9)

add_dummy_boxes({6, 7, 8})

Label_OSB9							= CreateElement "ceStringPoly"
Label_OSB9.name						= "LABEL_OSB9"
Label_OSB9.alignment				= "RightCenter"
Label_OSB9.value					= "LOAD"
Label_OSB9.material					= font_MFCD
Label_OSB9.stringdefs				= txt_labels_font
Label_OSB9.UseBackground			= false
Label_OSB9.BackgroundMaterial		= MFCD_SOLID_BLACK
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
Label_OSB9_symb.controllers			= {{"DSMS_inventory_air_load"}}
shift_button_pos(Label_OSB9_symb,9,-1*OSB_label_spacing,0)
Add(Label_OSB9_symb)
use_mipfilter(Label_OSB9_symb)
addOSB_Box(9, {Label_OSB9, Label_OSB9_symb})
add_osb_static_hint(9, _("Load store to station"))

add_dummy_boxes({10, 16, 17, 18})

Label_OSB19_Symb						= CreateElement "ceStringPoly"
Label_OSB19_Symb.name					= "LABEL_OSB19_SYMB"
Label_OSB19_Symb.alignment				= "LeftCenter"
Label_OSB19_Symb.value					= ROTARY
Label_OSB19_Symb.material				= font_MFCD
Label_OSB19_Symb.stringdefs				= txt_labels_font
Label_OSB19_Symb.UseBackground			= false
Label_OSB19_Symb.BackgroundMaterial		= MFCD_SOLID_BLACK
Label_OSB19_Symb.controllers			= {{"DSMS_inventory_rack_dra_avail"}}
shift_button_pos(Label_OSB19_Symb,19,1*OSB_label_spacing,0)
Add(Label_OSB19_Symb)
use_mipfilter(Label_OSB19_Symb)

Label_DRA							= CreateElement "ceStringPoly"
Label_DRA.name						= "Label_DRA"
Label_DRA.alignment					= "LeftCenter"
Label_DRA.value						= "DRA"
Label_DRA.material					= font_MFCD
Label_DRA.stringdefs				= txt_labels_font
Label_DRA.controllers				= {{"DSMS_inventory_rack_dra_avail"}, {"DSMS_inventory_rack_dra", -1}}
Label_DRA.UseBackground				= false
Label_DRA.BackgroundMaterial		= MFCD_SOLID_BLACK
shift_button_pos(Label_DRA,19,1*OSB_label_spacing+10,0)
Add(Label_DRA)
use_mipfilter(Label_DRA)

Label_I_LAU105							= Copy(Label_DRA)
Label_I_LAU105.value					= "DRA\n1 LAU105"
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

addOSB_Box(19, {Label_OSB19_Symb, Label_DRA, Label_I_LAU105, Label_0_LAU105, Label_2_LAU105})
add_osb_static_hint(19, _("Dual rail adapter"))

Label_OSB20_Symb						= CreateElement "ceStringPoly"
Label_OSB20_Symb.name					= "LABEL_OSB20_SYMB"
Label_OSB20_Symb.alignment				= "LeftCenter"
Label_OSB20_Symb.value					= ROTARY
Label_OSB20_Symb.material				= font_MFCD
Label_OSB20_Symb.stringdefs				= txt_labels_font
Label_OSB20_Symb.UseBackground			= false
Label_OSB20_Symb.BackgroundMaterial		= MFCD_SOLID_BLACK
Label_OSB20_Symb.controllers			= {{"DSMS_inventory_rack_dra_avail"}}
shift_button_pos(Label_OSB20_Symb,20,1*OSB_label_spacing,0)
Add(Label_OSB20_Symb)
use_mipfilter(Label_OSB20_Symb)

LabelOSB200								= CreateElement "ceStringPoly"
LabelOSB200.name						= "LabelOSB200"
LabelOSB200.alignment					= "LeftCenter"
LabelOSB200.value						= "2 AIM-9"
LabelOSB200.material					= font_MFCD
LabelOSB200.stringdefs					= txt_labels_font
LabelOSB200.controllers					= {{"DSMS_inventory_air_name", 0}}
LabelOSB200.UseBackground				= false
LabelOSB200.BackgroundMaterial			= MFCD_SOLID_BLACK
shift_button_pos(LabelOSB200,20,1*OSB_label_spacing+10,0)
Add(LabelOSB200)
use_mipfilter(LabelOSB200)

LabelOSB201								= Copy(LabelOSB200)
LabelOSB201.value						= "1 AIM-9"
LabelOSB201.controllers					= {{"DSMS_inventory_air_name", 1}}
Add(LabelOSB201)
use_mipfilter(LabelOSB201)

LabelOSB202								= Copy(LabelOSB200)
LabelOSB202.value						= "0 AIM-9"
LabelOSB202.controllers					= {{"DSMS_inventory_air_name", 2}}
Add(LabelOSB202)
use_mipfilter(LabelOSB202)

LabelOSB203								= Copy(LabelOSB200)
LabelOSB203.value						= "2 CAP-9"
LabelOSB203.controllers					= {{"DSMS_inventory_air_name", 3}}
Add(LabelOSB203)
use_mipfilter(LabelOSB203)

LabelOSB204								= Copy(LabelOSB200)
LabelOSB204.value						= "1 CAP-9"
LabelOSB204.controllers					= {{"DSMS_inventory_air_name", 4}}
Add(LabelOSB204)
use_mipfilter(LabelOSB204)

LabelOSB205								= Copy(LabelOSB200)
LabelOSB205.value						= "0 CAP-9"
LabelOSB205.controllers					= {{"DSMS_inventory_air_name", 5}}
Add(LabelOSB205)
use_mipfilter(LabelOSB205)

LabelOSB206								= Copy(LabelOSB200)
LabelOSB206.value						= "1 CA-AIS"
LabelOSB206.controllers					= {{"DSMS_inventory_air_name", 6}}
Add(LabelOSB206)
use_mipfilter(LabelOSB206)

LabelOSB207								= Copy(LabelOSB200)
LabelOSB207.value						= "0 CA-AIS"
LabelOSB207.controllers					= {{"DSMS_inventory_air_name", 7}}
Add(LabelOSB207)
use_mipfilter(LabelOSB207)

LabelOSB208								= Copy(LabelOSB200)
LabelOSB208.value						= "1 AIS"
LabelOSB208.controllers					= {{"DSMS_inventory_air_name", 8}}
Add(LabelOSB208)
use_mipfilter(LabelOSB208)

LabelOSB209								= Copy(LabelOSB200)
LabelOSB209.value						= "0 AIS"
LabelOSB209.controllers					= {{"DSMS_inventory_air_name", 9}}
Add(LabelOSB209)
use_mipfilter(LabelOSB209)

addOSB_Box(20, {Label_OSB20_Symb, LabelOSB200, LabelOSB201, LabelOSB202, LabelOSB203, LabelOSB204, LabelOSB205, LabelOSB206, LabelOSB207, LabelOSB208, LabelOSB209})
add_osb_static_hint(20, _("Select AIR-AIR stores"))
