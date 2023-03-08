dofile(LockOn_Options.script_path.."TEWS/indicator/RWR_ALR67_Common_definitions.lua")
dofile(LockOn_Options.script_path.."HMD/indicator/HMD_Page_defs.lua")

function addEwSymbols()
	local HMD_ewPlaceholder = addPlaceholder("HMD_ewPlaceholder", {0, 0}, autoBlank.name, {{"HMD_EW_Show"}})

	local function addHmdAzimuthLine(number)
		addVarLenStrokeLine("HMD_EW_AzimuthLine"..string.format("%d", number), 10, nil, nil, "HMD_EW_ThreatPlacer"..string.format("%d", number), {{"HMD_EW_AzimuthLine", number, 0}})
	end

	local function addHmdAzimuthDashedLine(number)
		addVarLenStrokeLine("HMD_EW_AzimuthDashedLine"..string.format("%d", number), 10, nil, nil, "HMD_EW_ThreatPlacer"..string.format("%d", number), {{"HMD_EW_AzimuthLine", number, 1}}, true, 23, 7)
	end

	--addEwHmdParent()
	for i = 1, 6 do
		local num = i-1
		AddThreatPlacer("HMD_EW", num, "HMD_ewPlaceholder", false, DegToDI(9.5))
		AddThreatSymbol("HMD_EW", STROKE_FNT_DFLT_120, num)
		
		addHmdAzimuthLine(num)
		addHmdAzimuthDashedLine(num)
	end
end

function addMidsSymbols()
	local HMD_DL_root = addPlaceholder("HMD_DL_root", {0, 0}, autoBlank.name, {{"HMD_DL_Show"}})

	local radius = MilToDI(11.6)
	local textX = MilToDI(12)
	local textY = MilToDI(12)

	for i = 1, 7 do
		local num = i-1
		local HMD_DL_Element_root = addPlaceholder("HMD_DL_Element_root"..i, {0, 0}, HMD_DL_root.name, {{"HMD_DL_Element", num, RadToDI()}})
		--
		local HAFU_TYPE = 
		{
			NONE = 0,
			UNKNOWN = 1,
			FRIENDLY = 2,
			HOSTILE = 3,
			AMBIGUOUS = 4
		}

		-- Members
		local HMD_Members_root = addPlaceholder("HMD_Members_root_"..i, {0, 0}, HMD_DL_Element_root.name, {{"HMD_Members", num}})
		addStrokeCircle("HMD_Members_"..i, radius,  {0, 0}, HMD_Members_root.name, noController)

		-- Closest Friend
		local HMD_ClosestFrnd_root = addPlaceholder("HMD_ClosestFrnd_root"..i, {0, 0}, HMD_DL_Element_root.name, {{"HMD_ClosestFrnd", num}})
		addStrokeCircle("HMD_ClosestFrnd_"..i, radius,  {0, 0}, HMD_ClosestFrnd_root.name, noController)
		
		-- Donors
		local HMD_Donors_root = addPlaceholder("HMD_Donors_root"..i, {0, 0}, HMD_DL_Element_root.name, {{"HMD_Donors", num}})
		addStrokeCircle("HMD_Donors_"..i, radius,  {0, 0}, HMD_Donors_root.name, noController)
		
		-- Others
		local HMD_Others_root = addPlaceholder("HMD_Others_root"..i, {0, 0}, HMD_DL_Element_root.name, {{"HMD_Others", num}})
		-- Center dot
		addStrokeCircle("FF_Circle_Center"..i, 1, nil, HMD_Others_root.name)
		-- Onboard
		addStrokeSymbol("HMD_Others_OnBoard_Friendly"..i, {"stroke_symbols_MDI_AMPCD", "SA-FF-Friendly"}, "FromSet", nil, HMD_Others_root.name, {{"HMD_OnboardSymb", num, HAFU_TYPE.FRIENDLY}})
		addStrokeSymbol("HMD_Others_OnBoard_Hostile"..i, {"stroke_symbols_MDI_AMPCD", "SA-FF-Hostile"}, "FromSet", nil, HMD_Others_root.name, {{"HMD_OnboardSymb", num, HAFU_TYPE.HOSTILE}})
		addStrokeSymbol("HMD_Others_OnBoard_Unknown"..i, {"stroke_symbols_MDI_AMPCD", "SA-FF-Unknown"}, "FromSet", nil, HMD_Others_root.name, {{"HMD_OnboardSymb", num, HAFU_TYPE.UNKNOWN}})
		addStrokeSymbol("HMD_Others_OnBoard_Ambiguous"..i, {"stroke_symbols_MDI_AMPCD", "SA-FF-Unknown"}, "FromSet", nil, HMD_Others_root.name, {{"HMD_OnboardSymb", num, HAFU_TYPE.AMBIGUOUS}})
		local HMD_offboard_root = addPlaceholder("HMD_Offboard_root"..i, {0, 0}, HMD_Others_root.name, {{"HMD_OnboardSymb", num, HAFU_TYPE.NONE}})
		-- Offboard
		local symbol
		symbol = addStrokeSymbol("HMD_Others_OffBoard_Friendly"..i, {"stroke_symbols_MDI_AMPCD", "SA-FF-Friendly"}, "FromSet", nil, HMD_offboard_root.name, {{"HMD_OffboardSymb", num, HAFU_TYPE.FRIENDLY}})
		symbol.init_rot = {180}
		symbol = addStrokeSymbol("HMD_Others_OffBoard_Hostile"..i, {"stroke_symbols_MDI_AMPCD", "SA-FF-Hostile"}, "FromSet", nil, HMD_offboard_root.name, {{"HMD_OffboardSymb", num, HAFU_TYPE.HOSTILE}})
		symbol.init_rot = {180}
		symbol = addStrokeSymbol("HMD_Others_OffBoard_Unknown"..i, {"stroke_symbols_MDI_AMPCD", "SA-FF-Unknown"}, "FromSet", nil, HMD_offboard_root.name, {{"HMD_OffboardSymb", num, HAFU_TYPE.UNKNOWN}})
		symbol.init_rot = {180}
		symbol = addStrokeSymbol("HMD_Others_OffBoard_Ambiguous"..i, {"stroke_symbols_MDI_AMPCD", "SA-FF-Unknown"}, "FromSet", nil, HMD_offboard_root.name, {{"HMD_OffboardSymb", num, HAFU_TYPE.AMBIGUOUS}})
		symbol.init_rot = {180}

		-- Mids Info
		local HMD_TrackInfo_root = addPlaceholder("HMD_TrackInfo_root"..i, {0, 0}, HMD_DL_Element_root.name, {{"HMD_TrackInfo", num}})
		addStrokeText("HMD_TrackInfo_ID"..i, nil, STROKE_FNT_DFLT_100, "LeftCenter", {textX, textY}, HMD_TrackInfo_root.name, {{"HMD_TrackInfo_ID", num}})
		addStrokeText("HMD_TrackInfo_Range"..i, nil, STROKE_FNT_DFLT_100, "LeftCenter", {textX, -textY}, HMD_TrackInfo_root.name, {{"HMD_TrackInfo_Range", num}}, {"%3.1f"})
	end
end
