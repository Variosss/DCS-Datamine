dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/BIT/BIT_defs.lua")

add_PB_label(6, {"AUTO", nil, {{"MPD_BIT_MemoryInspectActive", 0}}})
add_PB_label(7, {"CONFIG", nil, {{"MPD_BIT_MemoryInspectActive", 0}}})
add_PB_label(8, {"SELBIT", nil, nil, {{"MPD_BIT_SEL_BIT_active"}}})

addStrokeText("BIT_FAILURES", "BIT FAILURES", STROKE_FNT_DFLT_200, "CenterCenter", {0, BIT_titlePosY})

local BIT_groupLineLen = 200

local BIT_EquipGroupsParams = {}
BIT_EquipGroupsParams[BIT_EquipGroups.NAV] 				= {PB = 1,  text = "NAV"}
BIT_EquipGroupsParams[BIT_EquipGroups.COMM] 			= {PB = 2,  text = "COMM"}
BIT_EquipGroupsParams[BIT_EquipGroups.STORES] 			= {PB = 3,  text = "STORES"}
BIT_EquipGroupsParams[BIT_EquipGroups.SENSORS] 			= {PB = 4,  text = "SENSORS"}
BIT_EquipGroupsParams[BIT_EquipGroups.FCS_MC] 			= {PB = 5,  text = "FCS-MC"}
BIT_EquipGroupsParams[BIT_EquipGroups.DISPLAYS] 		= {PB = 11, text = "DISPLAYS"}
BIT_EquipGroupsParams[BIT_EquipGroups.STATUS_MONITOR] 	= {PB = 12, text = "STATUS\nMONITOR"}
BIT_EquipGroupsParams[BIT_EquipGroups.EW] 				= {PB = 13, text = "EW"}

local function add_BIT_EquipmentGroup(name, group_idx)
	local group = BIT_EquipGroupsParams[group_idx]
	local offset
	if group.PB <= 5 then
		offset = 0
	else
		offset = -BIT_groupLineLen
	end
	
	local groupPosX = PB_positions[group.PB][1]
	local groupPosY = PB_positions[group.PB][2]
	
	addStrokeText("BIT_groupLabel_"..name, group.text, BIT_PageFont, "LeftBottom", {groupPosX + offset, groupPosY + BIT_groupInterLine})
	addStrokeLine("BIT_groupLine_"..name, BIT_groupLineLen, {groupPosX + offset - 3, groupPosY}, -90)
	addStrokeText("BIT_groupStatus_"..name, nil, BIT_PageFont, "LeftTop", {groupPosX + offset, groupPosY - BIT_groupInterLine},
		nil, {{"MPD_BIT_EquipGroupStatus", group_idx}}, BIT_StatMsgs)
end

add_BIT_EquipmentGroup("NAV", 				BIT_EquipGroups.NAV)
add_BIT_EquipmentGroup("COMM", 				BIT_EquipGroups.COMM)
add_BIT_EquipmentGroup("STORES", 			BIT_EquipGroups.STORES)
add_BIT_EquipmentGroup("SENSORS", 			BIT_EquipGroups.SENSORS)
add_BIT_EquipmentGroup("FCS_MC", 			BIT_EquipGroups.FCS_MC)
add_BIT_EquipmentGroup("DISPLAYS", 			BIT_EquipGroups.DISPLAYS)
add_BIT_EquipmentGroup("STATUS_MONITOR", 	BIT_EquipGroups.STATUS_MONITOR)
add_BIT_EquipmentGroup("EW", 				BIT_EquipGroups.EW)

local interm = {}
for k, v in pairs(EquipItems) do
	interm[v.idx + 1] = v.name
end

local BIT_TerminalsNames = {}
for _, v in ipairs(interm) do
	BIT_TerminalsNames[#BIT_TerminalsNames + 1] = v
end

local function add_BIT_failure(falure_pos)
	local posY = BIT_ItemPosY - ((glyphNominalHeight120 + BIT_ItemInterline) * (falure_pos - 1))
	addStrokeText("BIT_failure_name_"..falure_pos, nil, BIT_PageFont, "LeftCenter", {BIT_ItemNamePosX, posY}, nil, {{"MPD_BIT_FailureItem", falure_pos - 1}}, BIT_TerminalsNames)
	addStrokeText("BIT_failure_status_"..falure_pos, nil, BIT_PageFont, "LeftCenter", {BIT_ItemStatusPosX, posY}, nil, {{"MPD_BIT_FailureStatus", falure_pos - 1}}, BIT_StatMsgs)
end

local BIT_FAILURES_AT_ONE_PAGE = 17
for falure_pos = 1, BIT_FAILURES_AT_ONE_PAGE do
	add_BIT_failure(falure_pos)
end

add_PB_label(16, {"PAGE", nil, {{"MPD_BIT_PageLabel"}}})
