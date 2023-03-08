dofile(LockOn_Options.script_path.."HMD/indicator/HMD_Page_defs.lua")

-- TDC dot
addDot("HMD_TDC_dot", 1.5, {0,0}, autoBlank.name, {{"HMD_TDC_to_HMD"}})

-- AG reticle
local HMD_AgReticle = addPlaceholder("HMD_AG_RETICLE", nil, autoBlank.name, {{"HMD_TDC_to_HMD"}, {"HMD_AG_RETICLE"}})

-- tic marks
local gunRktReticleRadius  	= MilToDI(25)  -- 50 mils
local gunRktReticleTickLen = 18
for i = 0, 11 do
	local posAngle = math.rad(i * 30)
	addStrokeLine("GunRkt_tick"..i * 30, gunRktReticleTickLen, {gunRktReticleRadius * math.sin(posAngle), gunRktReticleRadius * math.cos(posAngle)}, i * -30, HMD_AgReticle.name)
end

-- AG cross
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

-- Designated waypoint marker
local HMD_TD_Diamond_root = addPlaceholder("HMD_TD_Diamond_root", nil, autoBlank.name, {{"HMD_DesignatedWaypointMarkerShow", RadToDI()}})
addStrokeSymbol("HMD_TargetDesignateDiamond_Marker", {"stroke_symbols_HUD", "115-TD-Symbol"}, "FromSet", nil, HMD_TD_Diamond_root.name, {{"HMD_DesignatedWaypointMarkerType", 0}}, 1.5)
addStrokeSymbol("HMD_SegmentDiamond_Marker", {"stroke_symbols_HUD", "Segment-Diamond_NO_DOT"}, "FromSet", nil, HMD_TD_Diamond_root.name, {{"HMD_DesignatedWaypointMarkerType", 1}}, 1.5)
addDot("HMD_TD_Diamond_dot", 1.5, nil, HMD_TD_Diamond_root.name, {{"HMD_TDC_assignedDisplay"}})


local rightWindowsBlockPos_Y  = 70
local rightWindowsBlockStep_Y = 30
addStrokeText("HMD_JDAM_TYPE", "J-84", STROKE_FNT_DFLT_120, "LeftCenter", {280, rightWindowsBlockPos_Y-rightWindowsBlockStep_Y * 2}, autoBlank.name, {{"HMD_JDAM_TYPE"}})
add_X_Over("AG_JDAM_Not_Ready_X", 70, 26, {30, 0}, "HMD_JDAM_TYPE", {{"HMD_AG_JDAM_NotReadyX"}})
addStrokeText("HUD_JDAM_MISSION_MODE", "TOO", STROKE_FNT_DFLT_120, "LeftCenter", {380, rightWindowsBlockPos_Y-rightWindowsBlockStep_Y * 2}, autoBlank.name, {{"HMD_MISSION_TYPE"}})