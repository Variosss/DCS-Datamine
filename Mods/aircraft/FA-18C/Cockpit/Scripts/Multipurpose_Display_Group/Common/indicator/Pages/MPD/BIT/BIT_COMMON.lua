dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/BIT/BIT_defs.lua")

add_PB_label(9, {"MI", nil, nil, {{"MPD_BIT_MemoryInspectActive", 1}}})
add_PB_label(10, "STOP")

local MemoryInspectArrowName = "MemoryInspectArrow"
local arrUp = addStrokeSymbol(MemoryInspectArrowName.."Up", {"stroke_symbols_MDI_AMPCD", "076-arrow-up"}, "CenterTop", {PB_positions[6][1], PB_positions[6][2]},
	nil, {{"MPD_BIT_MemoryInspectActive", 1}})
	
local arrDn = Copy(arrUp)
arrDn.name = MemoryInspectArrowName.."Dn"
arrDn.alignment = "CenterBottom"
arrDn.init_pos = {PB_positions[7][1], PB_positions[7][2]}
arrDn.init_rot = {180}
Add(arrDn)
