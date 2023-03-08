dofile(LockOn_Options.script_path.."TEWS/indicator/RWR_ALR67_Common_definitions.lua")
dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/MPD_page_defs.lua")

local HUD_ewPlaceholder = addPlaceholder("HUD_ewPlaceholder", {0, 0}, nil, {{"HUD_EW_Show"}})

local function addHudAzimuthLine(number)
	addVarLenStrokeLine("HUD_EW_AzimuthLine"..string.format("%d", number), 10, nil, nil, "HUD_EW_ThreatPlacer"..string.format("%d", number), {{"HUD_EW_AzimuthLine", number, 0}})
end

local function addHudAzimuthDashedLine(number)
	addVarLenStrokeLine("HUD_EW_AzimuthDashedLine"..string.format("%d", number), 10, nil, nil, "HUD_EW_ThreatPlacer"..string.format("%d", number), {{"HUD_EW_AzimuthLine", number, 1}}, true, 23, 7)
end

--addEwHudParent()
for i = 1, 6 do
	local num = i-1
	AddThreatPlacer("HUD_EW", num, "HUD_ewPlaceholder", false)
	AddThreatSymbol("HUD_EW", STROKE_FNT_DFLT_120, num)
	
	AddSttSpecialSymbol("HUD_EW", "stroke_symbols_MDI_AMPCD", num, -20)
	AddBoatHarmSymbols("HUD_EW", "stroke_symbols_MDI_AMPCD", num, -14, nil)
	
	addHudAzimuthLine(num)
	addHudAzimuthDashedLine(num)
end
