dofile(LockOn_Options.script_path.."TEWS/indicator/RWR_ALR67_Common_definitions.lua")
dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/MPD_page_defs.lua")

-------------------------------------- RWR ---------------------------------------
local function addMainPageParent()
	local placer		= CreateElement "ceSimple"
	placer.name			= "MainPageParent"
	placer.controllers	= {{"MPD_EW_ALR_MainPageParent"}}
	Add(placer)
end

local function addBitPageParent()
	local placer		= CreateElement "ceSimple"
	placer.name			= "BitPageParent"
	placer.controllers	= {{"MPD_EW_ALR_BitPageParent"}}
	Add(placer)
end

addMainPageParent()
addBitPageParent()

addStrokeSymbol("EW_aircraft", {"stroke_symbols_MDI_AMPCD", "136-aircraft"}, "FromSet", {0, 0}, "MainPageParent")

-- 
local prioritySetting = addStrokeText("MPD_EW_ALR_PrioritySetting", "NORM",  STROKE_FNT_DFLT_120, "LeftCenter", {-430,-330}, "MainPageParent", {{"MPD_EW_ALR_PrioritySetting"}})
prioritySetting.formats = {	"",
							"NORM",
							"AI",
							"AAA",
							"UNK",
							"FRND"}

addStrokeText("MPD_EW_ALR_OffsetEnabled", 	"OFFSET",STROKE_FNT_DFLT_120, "LeftCenter", {-430,-360}, "MainPageParent", {{"MPD_EW_ALR_OffsetMode"}})
addStrokeText("MPD_EW_ALR_LimitEnabled", 	"LIMIT", STROKE_FNT_DFLT_120, "LeftCenter", {-430,-390}, "MainPageParent", {{"MPD_EW_ALR_LimitMode"}})


----------------------------- RWR Threats -----------------------------
local function addAzimuthLine(number)
	addVarLenStrokeLine("MPD_EW_ALR_AzimuthLine"..string.format("%d", number), 10, nil, nil, "MPD_EW_ALR_ThreatFlasher"..string.format("%d", number), {{"MPD_EW_ALR_AzimuthLine", number}})
end

for i = 1, 16 do
	local num = i-1
	AddThreatPlacer("MPD_EW_ALR", num, "MainPageParent", true)
	AddThreatSymbol("MPD_EW_ALR", STROKE_FNT_DFLT_120, num)
	AddBoatHarmSymbols("MPD_EW_ALR", "stroke_symbols_MDI_AMPCD", num, -14, nil)
	AddSpecialSymbols("MPD_EW_ALR", "stroke_symbols_MDI_AMPCD", num, -20, 20, 5, 0)
	AddSttSpecialSymbol("MPD_EW_ALR", "stroke_symbols_MDI_AMPCD", num, -20)
	
	addAzimuthLine(num)
end

----------------------------- RWR BIT ---------------------------------
-- BIT Page 1
AddBitPage1Fixed("MPD_EW_ALR", STROKE_FNT_DFLT_200, {0, 348}, {0, -348}, 348, "BitPageParent")
AddBitPage1ReceiverFail("MPD_EW_ALR", STROKE_FNT_DFLT_200, 64, 260, "BitPageParent")

AlrBitPage1Fails[ALR_BIT1_FAIL_CI].pos = {0, 176}
AlrBitPage1Fails[ALR_BIT1_FAIL_SR].pos = {0, 88}
AlrBitPage1Fails[ALR_BIT1_FAIL_AN].pos = {0, 0}
AlrBitPage1Fails[ALR_BIT1_FAIL_IA].pos = {0, -88}
AlrBitPage1Fails[ALR_BIT1_FAIL_TO].pos = {0, -176}

AddBitPage1Fails(ALR_BIT1_FAIL_CI, "MPD_EW_ALR", STROKE_FNT_DFLT_200, "BitPageParent")
AddBitPage1Fails(ALR_BIT1_FAIL_SR, "MPD_EW_ALR", STROKE_FNT_DFLT_200, "BitPageParent")
AddBitPage1Fails(ALR_BIT1_FAIL_AN, "MPD_EW_ALR", STROKE_FNT_DFLT_200, "BitPageParent")
AddBitPage1Fails(ALR_BIT1_FAIL_IA, "MPD_EW_ALR", STROKE_FNT_DFLT_200, "BitPageParent")
AddBitPage1Fails(ALR_BIT1_FAIL_TO, "MPD_EW_ALR", STROKE_FNT_DFLT_200, "BitPageParent")

-- BIT Page 2
AddBitPage2Fails("MPD_EW_ALR", STROKE_FNT_DFLT_200, STROKE_FNT_DFLT_200, {0, 160}, {0, -160}, "BitPageParent")

-- BIT Page 3, 4, 5, 6
AddBitFixedFormatText("MPD_EW_ALR", STROKE_FNT_DFLT_200, {0, 0})

-- BIT Page 6
-- TODO: add symbols

-- BIT Page 7

-- BIT Page 8


----------------------------- Menu ------------------------------------
add_PB_label(14, {"HUD", 	nil, {{"MPD_EW_ALR67_Option_show"}}, {{"MPD_EW_ALR67_HUD_Box"}}})
