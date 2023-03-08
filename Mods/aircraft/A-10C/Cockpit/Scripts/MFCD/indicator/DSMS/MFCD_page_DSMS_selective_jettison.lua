dofile(LockOn_Options.script_path.."MFCD/indicator/MFCD_useful_definitions.lua")
dofile(LockOn_Options.script_path.."MFCD/indicator/DSMS/MFCD_DSMS_useful_definitions.lua")

AddMaverickPowerTimeLabel()

PageNameText							= CreateElement "ceStringPoly"
PageNameText.name						= "InventoryText"
PageNameText.material					= font_MFCD
PageNameText.alignment					= "CenterTop"
PageNameText.init_pos					= {max_pixels_count/2,(OSB_positions[20][2]+OSB_positions[19][2])/2+15,0}
SetLowerLeftCornerOrigin(PageNameText)
PageNameText.stringdefs					= predefined_fonts[3]
PageNameText.UseBackground				= false
PageNameText.BackgroundMaterial			= MFCD_SOLID_BLACK
PageNameText.value						= "SELECTIVE\nJETTISON"
Add(PageNameText)
use_mipfilter(PageNameText) 

labels = {}

AddStatLabel()

addOSB_Box(2)

OsbLabel4SAFE							= CreateElement "ceStringPoly"
OsbLabel4SAFE.name						= "OsbLabel4SAFE"
OsbLabel4SAFE.material					= font_MFCD
OsbLabel4SAFE.UseBackground				= false
OsbLabel4SAFE.BackgroundMaterial		= MFCD_SOLID_BLACK
OsbLabel4SAFE.alignment					= "CenterTop"
OsbLabel4SAFE.value						= ROTARY .. "SAFE"
OsbLabel4SAFE.stringdefs				= predefined_fonts[1]
OsbLabel4SAFE.controllers				= {{"DSMS_inventory_SJ_fuze", 0}}
shift_button_pos(OsbLabel4SAFE, 4)
Add(OsbLabel4SAFE)
use_mipfilter(OsbLabel4SAFE)

OsbLabel4NOSE							= Copy(OsbLabel4SAFE)
OsbLabel4NOSE.value						= ROTARY .. "NOSE"
OsbLabel4NOSE.controllers				= {{"DSMS_inventory_SJ_fuze", 1}}
Add(OsbLabel4NOSE)
use_mipfilter(OsbLabel4NOSE)

OsbLabel4TAIL							= Copy(OsbLabel4SAFE)
OsbLabel4TAIL.value						= ROTARY .. "TAIL"
OsbLabel4TAIL.controllers				= {{"DSMS_inventory_SJ_fuze", 2}}
Add(OsbLabel4TAIL)
use_mipfilter(OsbLabel4TAIL)

OsbLabel4NT								= Copy(OsbLabel4SAFE)
OsbLabel4NT.value						= ROTARY .. "N/T"
OsbLabel4NT.controllers					= {{"DSMS_inventory_SJ_fuze", 3}}
Add(OsbLabel4NT)
use_mipfilter(OsbLabel4NT)

addOSB_Box(4, {OsbLabel4SAFE, OsbLabel4NOSE, OsbLabel4TAIL, OsbLabel4NT})
add_osb_static_hint(4, _("Select Jettison Weapon fuze"))

OsbLabel5STR							= CreateElement "ceStringPoly"
OsbLabel5STR.name						= "OsbLabel5STR"
OsbLabel5STR.material					= font_MFCD
OsbLabel5STR.UseBackground				= false
OsbLabel5STR.BackgroundMaterial			= MFCD_SOLID_BLACK
OsbLabel5STR.alignment					= "CenterTop"
OsbLabel5STR.value						= ROTARY .. "STR"
OsbLabel5STR.stringdefs					= predefined_fonts[1]
OsbLabel5STR.controllers				= {{"DSMS_inventory_SJ_mode", 0}}
shift_button_pos(OsbLabel5STR, 5)
Add(OsbLabel5STR)
use_mipfilter(OsbLabel5STR)

OsbLabel5RACK							= Copy(OsbLabel5STR)
OsbLabel5RACK.value						= ROTARY .. "RACK"
OsbLabel5RACK.controllers				= {{"DSMS_inventory_SJ_mode", 1}}
Add(OsbLabel5RACK)
use_mipfilter(OsbLabel5RACK)

OsbLabel5MSL							= Copy(OsbLabel5STR)
OsbLabel5MSL.value						= ROTARY .. "MSL"
OsbLabel5MSL.controllers				= {{"DSMS_inventory_SJ_mode", 2}}
Add(OsbLabel5MSL)
use_mipfilter(OsbLabel5MSL)

addOSB_Box(5, {OsbLabel5STR, OsbLabel5RACK, OsbLabel5MSL})
add_osb_static_hint(5, _("Select Jettison Mode"))

Labels = {}
for i = 0,3 do
	Labels[i]							= CreateElement "ceStringPoly"
	if i == 0 then 
	Labels[i].material					= font_MFCD 
	else
	Labels[i].material					= font_MFCD_RED 
	end
	Labels[i].alignment					= "CenterTop"
	Labels[i].stringdefs				= predefined_fonts[3]
	Labels[i].init_pos					= {max_pixels_count/2, (OSB_positions[7][2]+OSB_positions[8][2])/2,0}
	Labels[i].controllers				= {{"DSMS_inventory_SJ_fuze", i}}
	Add(Labels[i])
	SetLowerLeftCornerOrigin(Labels[i])
	use_mipfilter(Labels[i])
end

Labels[0].value = "SAFE"
Labels[1].value = "NOSE ARM"
Labels[2].value = "TAIL ARM"
Labels[3].value = "ARMED"

-------------------------------
--[[
LabelSAFE  		= lbl(font_MFCD)
LabelSAFE.value = "SAFE" 
LabelSAFE.init_pos		= {max_pixels_count/2, (OSB_positions[7][2]+OSB_positions[8][2])/2,0}
LabelSAFE.controllers	= {{"DSMS_inventory_SJ_fuze", 0}}


LabelNOSE							= Copy(LabelSAFE)
LabelNOSE.value						= "NOSE"
LabelNOSE.material					= font_MFCD_RED
LabelNOSE.controllers				= {{"DSMS_inventory_SJ_fuze", 1}}
Add(LabelNOSE)
use_mipfilter(LabelNOSE)

LabelTAIL							= Copy(LabelSAFE)
LabelTAIL.value						= "TAIL"
LabelTAIL.material					= font_MFCD_RED
LabelTAIL.controllers				= {{"DSMS_inventory_SJ_fuze", 2}}
Add(LabelTAIL)
use_mipfilter(LabelTAIL)

LabelNT								= Copy(LabelSAFE)
LabelNT.value						= "N/T"
LabelNT.material					= font_MFCD_RED
LabelNT.controllers					= {{"DSMS_inventory_SJ_fuze", 3}}
Add(LabelNT)
use_mipfilter(LabelNT)
--]]
-----------------------
add_osb_static_hint(2+1, _("Select jettison of station 6"))

add_osb_static_hint(5+1, _("Select jettison of station 7") )
add_osb_static_hint(6+1, _("Select jettison of station 8") )
add_osb_static_hint(7+1, _("Select jettison of station 9") )
add_osb_static_hint(8+1, _("Select jettison of station 10"))
add_osb_static_hint(9+1, _("Select jettison of station 11"))

add_osb_static_hint(15+1, _("Select jettison of station 1"))
add_osb_static_hint(16+1, _("Select jettison of station 2"))
add_osb_static_hint(17+1, _("Select jettison of station 3"))
add_osb_static_hint(18+1, _("Select jettison of station 4"))
add_osb_static_hint(19+1, _("Select jettison of station 5"))


