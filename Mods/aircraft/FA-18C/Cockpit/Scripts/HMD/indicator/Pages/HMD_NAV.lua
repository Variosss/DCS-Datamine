dofile(LockOn_Options.script_path.."HMD/indicator/HMD_Page_defs.lua")

-- TDC dot
addDot("HMD_TDC_dot", 1.5, {0,0}, autoBlank.name, {{"HMD_TDC_to_HMD"}})

local HMD_cross_lineLength = MilToDI(8)
local HMD_AgCross_root = addPlaceholder("HMD_AgCross_root", nil, autoBlank.name, {{"HMD_AG_CROSS"}})
local function addAgCross()
	local linePos	= MilToDI(3)
	local dAngle	= 90
	local dAngleRad	= math.rad(dAngle)
	for i = 0, 3 do
		addStrokeLine("HMD_AG_CROSS_"..i, HMD_cross_lineLength, {linePos * math.sin(dAngleRad * i), linePos * math.cos(dAngleRad * i)}, -dAngle * i, HMD_AgCross_root.name)
	end
end
addAgCross()

local HMD_TD_Diamond_root = addPlaceholder("HMD_TD_Diamond_root", nil, autoBlank.name, {{"HMD_DesignatedWaypointMarkerShow", RadToDI()}})
addStrokeSymbol("HMD_TargetDesignateDiamond_Marker", {"stroke_symbols_HUD", "115-TD-Symbol"}, "FromSet", nil, HMD_TD_Diamond_root.name, {{"HMD_DesignatedWaypointMarkerType", 0}}, 1.5)
addStrokeSymbol("HMD_SegmentDiamond_Marker", {"stroke_symbols_HUD", "Segment-Diamond_NO_DOT"}, "FromSet", nil, HMD_TD_Diamond_root.name, {{"HMD_DesignatedWaypointMarkerType", 1}}, 1.5)
addDot("HMD_TD_Diamond_dot", 1.5, nil, HMD_TD_Diamond_root.name, {{"HMD_TDC_assignedDisplay"}})