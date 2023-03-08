dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/MPD_page_defs.lua")
dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/MPD_AdvisoriesDefs.lua")

local MENU_label_controller = {{"MPD_MENU_labelOrSystemTime"}}
add_PB_label(18, {"MENU", nil, MENU_label_controller})

-- Cautions/Advisories
local CautionsInterchar = 9
local CautionsFont   = {fontScaleY_150, fontScaleX_150, CautionsInterchar * GetScale(), fontInterlineDflt150 * GetScale()}

local AdvisoriesInterchar = fontIntercharDflt120
local AdvisoriesFont = STROKE_FNT_DFLT_120

local CautionsAdvisoriesPlaceholder = addPlaceholder("CautionsAdvisoriesPlaceholder", {-450, -412}, nil, {{"MPD_CautionsAdvisoriesVisibilityAndPos", 500}})

local CautionsOriginShiftX = 10
local CautionsOriginShiftY = 46

local AdvisoriesPlaceholder = addPlaceholder("AdvisoriesPlaceholder", {0, 0}, CautionsAdvisoriesPlaceholder.name, {{"MPD_AdvisoriesShow"}})
local CautionsPlaceholder = addPlaceholder("CautionsPlaceholder", {CautionsOriginShiftX, CautionsOriginShiftY}, CautionsAdvisoriesPlaceholder.name)

local CautionsShiftX = 311
local CautionsShiftY = 52

local Cautions = {}

local function addCaution(str)
	Cautions[#Cautions + 1] = str
end

-- Priority cautions
addCaution("DEBUG")      -- should be never displayed
addCaution("AIL OFF")
addCaution("CAUT DEGD")
addCaution("DEL ON")
addCaution("FCS")
addCaution("FLAPS OFF")
addCaution("FLAP SCHED")
addCaution("HYD 1A")
addCaution("HYD 1B")
addCaution("HYD 2A")
addCaution("HYD 2B")
addCaution("INS ATT")
addCaution("INS VEL")
addCaution("L AMAD")
addCaution("R AMAD")
addCaution("L AMAD PR")
addCaution("R AMAD PR")
addCaution("MECH ON")
addCaution("RUD OFF")
addCaution("NAV VVEL")
-- Non-priority cautions
addCaution("AIR DATA")
addCaution("ANTI SKID")
addCaution("AOA DEGD")
addCaution("APU ACCUM")
addCaution("ASPJ AMP")
addCaution("ASPJ DEGD")
addCaution("ASPJ HI B")
addCaution("ASPJ LO B")
addCaution("ASPJ OVRHT")
addCaution("ASPJ RPTF")
addCaution("ATAR OVRHT")
addCaution("AUTO PILOT")
addCaution("AV AIR DGD")
addCaution("AV AIR HOT")
addCaution("E BATT LO")
addCaution("U BATT LO")
addCaution("BATT SW")
addCaution("BINGO")
addCaution("BRK ACCUM")
addCaution("CANOPY")
addCaution("  CG")
addCaution("CHECK TRIM")
addCaution("CNI")
addCaution("CK FLAPS")
addCaution("CHECK SEAT")
addCaution("DFIR OVRHT")
addCaution("DFIRS GONE")
addCaution("DL OVRHT")
addCaution("DTR1 COLD")
addCaution("DTR2 COLD")
addCaution("DTR1 SHTDN")
addCaution("DTR2 SHTDN")
addCaution("DUMP OPEN")
addCaution("ENG MATCH")
addCaution("ERASE FAIL")
addCaution("EXT TANK")
addCaution("EXT XFER")
addCaution("FC AIR DAT")
addCaution("FCS HOT")
addCaution("FLIR OVRHT")
addCaution("NFLR OVRHT")
addCaution("FUEL LO")
addCaution("FUEL XFER")
addCaution("GPS")
addCaution("GPS DEGD")
addCaution("GUN GAS")
addCaution("G-LIM OVRD")
addCaution("G-LIM 7.5G")
addCaution("HAND CNTRL")
addCaution("HOME FUEL")
addCaution("IFF 4")
addCaution("IFFAI")
addCaution("IFF OVRHT")
addCaution("INLET ICE")
addCaution("INS DEGD")
addCaution("LADDER")
addCaution("L ATS")
addCaution("R ATS")
addCaution("L BLD OFF")
addCaution("R BLD OFF")
addCaution("L BOOST LO")
addCaution("R BOOST LO")
addCaution("L DUCT DR")
addCaution("R DUCT DR")
addCaution("L EGT HIGH")
addCaution("R EGT HIGH")
addCaution("L FLAMEOUT")
addCaution("R FLAMEOUT")
addCaution("L FUEL HOT")
addCaution("R FUEL HOT")
addCaution("L GEN")
addCaution("R GEN")
addCaution("L IN TEMP")
addCaution("R IN TEMP")
addCaution("L OIL PR")
addCaution("R OIL PR")
addCaution("L OVRSPD")
addCaution("R OVRSPD")
addCaution("L PITOT HT")
addCaution("R PITOT HT")
addCaution("L STALL")
addCaution("R STALL")
addCaution("MC CONFIG")
addCaution("MC 1")
addCaution("MC 2")
addCaution("MDL LOAD")
addCaution("MIDS OVRHT")
addCaution("MU LOAD")
addCaution("NAV FAIL")
addCaution("NAV HVEL")
addCaution("NWS")
addCaution("OBOGS DEGD")
addCaution("OCS")
addCaution("OXY LO")
addCaution("PARK BRAKE")
addCaution("POS/ADC")
addCaution("PROBE UNLK")
addCaution("RACK UNCPL")
addCaution("R-LIM OFF")
addCaution("S/W CONFIG")
addCaution("TANK PRESS")
addCaution("TK PRES LO")
addCaution("TK PRES HI")
addCaution("VEL")
addCaution("VOICE/AUR")
addCaution("WDSHLD HOT")
addCaution("WING UNLK")
			
for raw = 0, 6 do
	for column = 0, 2 do
		addStrokeText("Caution_"..raw.."_"..column, nil, CautionsFont, "LeftBottom",
			{CautionsShiftX * (column),  CautionsShiftY * (raw)}, -- position
			 CautionsPlaceholder.name, {{"MPD_CautionText", raw, column}}, -- parent, controllers
			 Cautions -- formats
			)
	end
end

addStrokeText("AdvisoriesLine", nil, AdvisoriesFont, "LeftBottom", nil, AdvisoriesPlaceholder.name, {{"MPD_AdvisoriesLine"}},{"ADV-%s%s%s%s%s%s%s", "ADV-"})

for place = 0, 6 do
	add_X_Over("advisory_X_Over_"..place, 82, 24, {0, glyphNominalHeight120 / 2}, AdvisoriesPlaceholder.name, {{"MPD_Advisory_X", place, glyphNominalWidth120, AdvisoriesInterchar}})
end

if disableCautAdvMasks ~= true then
	local AdvisoriesLineMaskGapX = 4
	local AdvisoriesLineMaskGapAssymetryY = 4 -- 4 DIs shorter at the bottom
	local AdvisoriesLineMaskGapY = (CautionsOriginShiftY - glyphNominalHeight120) / 2 - AdvisoriesLineMaskGapAssymetryY
	local AdvisoriesTotalSymbolsNum = 4 + 6 * 7
	local AdvisoriesLineMaskHeight = glyphNominalHeight120 + AdvisoriesLineMaskGapY * 2
	local AdvisoriesLineMaskWidth  = AdvisoriesTotalSymbolsNum * (glyphNominalWidth120 + AdvisoriesInterchar) - AdvisoriesInterchar + AdvisoriesLineMaskGapX * 2

	local AdvisoriesMaskVertices = {{0, AdvisoriesLineMaskHeight},
									{AdvisoriesLineMaskWidth, AdvisoriesLineMaskHeight},
									{AdvisoriesLineMaskWidth, 0},
									{0, 0}}
									
	local Advisories_mask = openMaskArea(0, "Advisories_mask_open1", AdvisoriesMaskVertices, {0, 1, 2, 0, 2, 3},
		{-AdvisoriesLineMaskGapX, -(AdvisoriesLineMaskGapY - AdvisoriesLineMaskGapAssymetryY)}, AdvisoriesPlaceholder.name)
	Advisories_mask.material  = "MASK_MATERIAL_2"

	local Advisories_mask2 = Copy(Advisories_mask)
	Advisories_mask2.name  = "Advisories_mask_open2"
	Advisories_mask2.level = DEFAULT_LEVEL + 1
	Add(Advisories_mask2)

	local CautionsLineMaskGapX = 4
	local CautionsLineMaskGapY = (CautionsShiftY - glyphNominalHeight150) / 2
	local CautionsLineMaskHeight = glyphNominalHeight150 + CautionsLineMaskGapY * 2
	local CautionsLineMaskWidth  = CautionsShiftX * 2 + CautionsInterchar * 9 + glyphNominalWidth150 * 10 + CautionsLineMaskGapX * 2

	local CautionsMaskVertices 	= {{0, CautionsLineMaskHeight},
								   {CautionsLineMaskWidth, CautionsLineMaskHeight},
								   {CautionsLineMaskWidth, 0},
								   {0, 0}}
								   
	for maskNum = 0, 6 do
		local posShiftY = maskNum * CautionsLineMaskHeight
		local Cautions_mask = openMaskArea(0, "Cautions_mask_open_"..maskNum, CautionsMaskVertices, {0, 1, 2, 0, 2, 3}, {-CautionsLineMaskGapX, -CautionsLineMaskGapY + posShiftY},
			CautionsPlaceholder.name, {{"MPD_CautionMaskVisibility", maskNum}})

		local Cautions_mask2 = Copy(Cautions_mask)
		Cautions_mask2.name  = "Cautions_mask_open2_"..maskNum
		Cautions_mask2.level = DEFAULT_LEVEL + 1
		Add(Cautions_mask2)
	end
end
