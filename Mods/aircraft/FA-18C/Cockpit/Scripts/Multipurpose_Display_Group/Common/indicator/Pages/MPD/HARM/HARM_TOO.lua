dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/MPD_page_defs.lua")
dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/HARM/HARM_Utils.lua")

-- TDC Priority Marker
local TD_DiamondPlaceholder = addPlaceholder("TD_DiamondPlaceholder", {400, 450}, nil, {{"TDC_assignedDisplay"}})
addStrokeSymbol("TargetDesignateDiamond_Marker", {"stroke_symbols_HUD", "115-TD-Symbol"}, "FromSet", nil, TD_DiamondPlaceholder.name)
addDot("TD_Diamond_dot", 1.5, nil, TD_DiamondPlaceholder.name)

--
addStrokeText("MPD_HARM_class_TOO", "", STROKE_FNT_DFLT_120, "RightCenter", {450, 307}, nil, {{"MPD_HARM_Class"}}, HARM_Classes)

local lineL 	= 40
local linePos	= lineL * 0.5
addStrokeLine("MPD_HARM_TOO_LineL1", lineL, {-450, 0}, -90)
addStrokeLine("MPD_HARM_TOO_LineL2", lineL, {-450, -linePos}, 0)
addStrokeLine("MPD_HARM_TOO_LineU1", lineL, {-20, 450}, -90)
addStrokeLine("MPD_HARM_TOO_LineU2", lineL, {0, 450}, 180)
addStrokeLine("MPD_HARM_TOO_LineR1", lineL, {450, 0}, 90)
addStrokeLine("MPD_HARM_TOO_LineR2", lineL, {450, -linePos}, 0)
addStrokeLine("MPD_HARM_TOO_LineD1", lineL, {-linePos, -450}, -90)
addStrokeLine("MPD_HARM_TOO_LineD2", lineL, {0, -450}, 0)

local function addCentralCross()
	local dAngle	= 90
	local dAngleRad	= math.rad(dAngle)
	for i = 0, 1 do
		addStrokeLine("MPD_HARM_TOO_CROSS"..i, lineL, {linePos * math.sin(dAngleRad * i), -linePos * math.cos(dAngleRad * i)}, dAngle * i)
	end
end
addCentralCross()

local leftArrow  = addStrokeSymbol("MPD_HARM_OutOfFoc_Left",  {"stroke_symbols_MDI_AMPCD", "124-arrow-up"}, "RightCenter", {-420, 60}, nil, {{"MPD_HARM_OutOfFov_Arrow", 0}})
leftArrow.init_rot = {90}
local rightArrow = addStrokeSymbol("MPD_HARM_OutOfFoc_Right", {"stroke_symbols_MDI_AMPCD", "124-arrow-up"}, "LeftCenter", { 430, 60}, nil, {{"MPD_HARM_OutOfFov_Arrow", 1}})
rightArrow.init_rot = {270}

for i = 1, 15 do
	local num = i-1

	local placer		= CreateElement "ceSimple"
	placer.name			= "MPD_HARM_SymbolPlacer"..num
	placer.controllers	= {{"MPD_HARM_ThreatPos", num}}
	Add(placer)
	
	addStrokeText("MPD_HARM_Symbol"..num, "", STROKE_FNT_DFLT_120, "CenterCenter", nil, placer.name, {{"MPD_HARM_ThreatSymbol", num}})

	addStrokeSymbol("MPD_HARM_SpecialSymbolsSquare"..num, 	{"stroke_symbols_MDI_AMPCD", "harm-too-target"},"CenterCenter",
					{0,0}, placer.name, {{"MPD_HARM_SpecialSymbols", num, 0}})
					
	addStrokeSymbol("MPD_HARM_SpecialSymbolsBoat"..num, 	{"stroke_symbols_MDI_AMPCD", "rwr-stt"},  "CenterCenter",
					{0,-14}, placer.name, {{"MPD_HARM_SpecialSymbols", num, 1}})
					
	addStrokeLine("MPD_HARM_SpecialSymbolsLocked"..num, 36, {-18, 17}, -90, placer.name, {{"MPD_HARM_SpecialSymbols", num, 2}})

	addStrokeText("MPD_HARM_SpecialSymbolsFriendly"..i, "F", STROKE_FNT_DFLT_120, "CenterCenter", {-26, 0}, placer.name, {{"MPD_HARM_SpecialSymbols", num, 3}})
	addStrokeText("MPD_HARM_SpecialSymbolsHoff"..i, "H-OFF", STROKE_FNT_DFLT_100, "CenterCenter", {0, 36}, placer.name, {{"MPD_HARM_SpecialSymbols", num, 4}})

end


-------------------------------------- Menu --------------------------------------
add_PB_label(11, "CLASS")

add_PB_label(15, "RSET")
add_PB_label(17, {"SCAN", nil, nil, {{"MPD_HARM_SCAN_Box"}}})
add_PB_label(19, {"LIMIT", nil, nil, {{"MPD_HARM_LIMIT_Box"}}})
