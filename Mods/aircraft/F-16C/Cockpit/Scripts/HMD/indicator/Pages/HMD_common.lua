dofile(LockOn_Options.script_path.."HMD/indicator/HMD_Page_defs.lua")
dofile(LockOn_Options.script_path.."Computers/MMC_Types.lua")

-- for debug purpose
--addStrokeCircle("HMD_FOV", DegToMil(10), {0,0}, autoBlank.name)
local declutterLvl2 = addPlaceholder("declutterLvl2", {0,0},autoBlank.name, {{"DeclutterLvl2"}})
local declutterLvl3 = addPlaceholder("declutterLvl3", {0,0},autoBlank.name, {{"DeclutterLvl3"}})


-- Normal Acceleration
addStrokeText("HMD_NormalAcceleration_Win5", "", STROKE_FNT_DFLT_150, "RightBottom", {-80, 12}, declutterLvl3.name, {{"HMD_G_Numerics"}})

-- Airspeed
local CAS_BoxWidth		= 36
local CAS_AltBoxHeight	= 13.5
addStrokeBox("HMD_CAS_box", CAS_BoxWidth, CAS_AltBoxHeight, "RightCenter", {-100.44, 0}, declutterLvl3.name)
addStrokeText("HMD_Airspeed", "", STROKE_FNT_DFLT_150, "RightCenter", {-101.94, 0}, declutterLvl3.name, {{"HMD_CAS_Numerics"}})

-- Altitude
local Alt_BoxWidth		= 45
addStrokeBox("HMD_Alt_box", Alt_BoxWidth, CAS_AltBoxHeight, "RightCenter", {145, 0}, declutterLvl2.name)
addStrokeText("HMD_Altitude", "", STROKE_FNT_DFLT_150, "RightCenter", {143.5, 0}, declutterLvl2.name, {{"HMD_Alt_Numerics", 3}})

-- HMD LOS Heading scale
local hdgScaleStep			= 28 * 2		-- 10 Degrees
local hdgScaleLongTickLen	= 5
local hdgScaleShortTickLen	= 3
local hdgScaleTextShiftY	= 2
local Px_PerOneDegree		= hdgScaleStep / 10
local hdgScaleY				= -124

-- HMD LOS Heading
local headNumPosY = hdgScaleY - hdgScaleShortTickLen
addStrokeBox("HMD_LOS_Heading_box", 32, 20, "CenterTop", {0, headNumPosY}, declutterLvl2.name)
addStrokeText("HMD_LOS_Heading", "", STROKE_FNT_DFLT_150, "CenterTop", {0, headNumPosY-hdgScaleTextShiftY -1.75}, declutterLvl2.name, {{"HMD_LOS_Heading_Numerics_F16"}})

-- HMD LOS Heading Scale
local los_hdgScaleOriginBlank = addPlaceholder("HMD_LOS_HdgScale_origin_blank", {0, hdgScaleY}, declutterLvl2.name)
local los_hdgScaleHorOriginLong  = addPlaceholder("HMD_LOS_HdgScaleHor_originLong",  {0, 0}, los_hdgScaleOriginBlank.name, {{"HMD_LOS_HdgScaleHorPos_F16",  0, Px_PerOneDegree}})
local los_hdgScaleHorOriginShort = addPlaceholder("HMD_LOS_HdgScaleHor_originShort", {0, 0}, los_hdgScaleOriginBlank.name, {{"HMD_LOS_HdgScaleHorPos_F16", -5, Px_PerOneDegree}})
for i = 1, 3 do
	local posX = hdgScaleStep * (i - 2) - hdgScaleStep / 2
	addStrokeLine("HMD_LOS_HdgTickLong_"..i,  hdgScaleLongTickLen,  {posX, -hdgScaleShortTickLen}, 0, los_hdgScaleHorOriginLong.name)
	addStrokeLine("HMD_LOS_HdgTickShort_"..i, hdgScaleShortTickLen, {posX, -hdgScaleShortTickLen}, 0, los_hdgScaleHorOriginShort.name)

	addStrokeText("HMD_LOS_Hdg_numerics_"..i, nil, STROKE_FNT_DFLT_125, "CenterTop", {posX, -hdgScaleShortTickLen - hdgScaleTextShiftY}, los_hdgScaleHorOriginLong.name, {{"HMD_LOS_HdgScaleText_F16", i}})
end
-- HMD LOS Heading index
addStrokeLine("HMD_LOS_HeadingScaleIndex", hdgScaleLongTickLen, {0, 2}, 0, los_hdgScaleOriginBlank.name)

-- ARM status - ARM, ILS, SIM, blank
addStrokeText("HMD_Arm_Status_Win3", "", STROKE_FNT_DFLT_150, "RightBottom", {-80, -40}, declutterLvl3.name, {{"HMD_Arm_Status_Win3"}}, {"", "ARM", "ILS", "SIM"})

-- Weapon release mode - Submode
addStrokeText("HMD_Submode_Win8", "", STROKE_FNT_DFLT_150, "RightBottom", {-80, -66}, autoBlank.name, {{"HMD_MasterMode_Win8"}}, AcftSubModeLbl)

-- Slant Range
addStrokeText("HMD_SlantRange_Win10", "", STROKE_FNT_DFLT_150, "LeftBottom", {80, -70}, autoBlank.name, {{"HMD_SlantRange_Win10"}})

-- WARN/NEW SPI window
addStrokeText("HMD_Warn_NewSpi_Win11", "", STROKE_FNT_DFLT_150, "CenterBottom", {-4.5, 43}, autoBlank.name, {{"HMD_Warn_Win11"}}, {"", "WARN", "NEW SPI"})

-- FUEL/SHOOT window
addStrokeText("HMD_Fuel_Shoot_Win12", "", STROKE_FNT_DFLT_150, "CenterBottom", {0, -38}, autoBlank.name, {{"HMD_FuelAdvisory_Win12"}}, {"", "FUEL", "SHOOT"})

-- Steerpoint data, ...
addStrokeText("HMD_StpTgtData_RangeNum_Win14", "", STROKE_FNT_DFLT_150, "LeftBottom", {80, -96}, declutterLvl2.name, {{"HMD_StpTgtData_RangeNum_Win14"}}, {"", "%03d>%03d", "%02d %1.1f", "%02d %3.0f"})
-- Fuel, Home bingo status, Trapped fuel - TRP FUEL, Ownship Bull's-Eye data
addStrokeText("HMD_Bullseye_Data_Win15", "", STROKE_FNT_DFLT_150, "RightBottom", {-80, -80}, autoBlank.name, {{"HMD_Bullseye_Data_Win15"}}, {"", "%03d  %03d", "FUEL", "FUEL %3d", "TRP FUEL"})

-- NO RAD window
addStrokeText("HMD_NoRad_Win19", "NO RAD", STROKE_FNT_DFLT_150, "CenterBottom", {0, 66}, autoBlank.name, {{"HMD_NoRad_Win19"}})

-- FCR
local acmBore = addStrokeSymbol("HMD_AcmBore", {"stroke_symbols_HMD", "acm-bore"}, "FromSet", {0, 0}, hmd_dacPosition.name, {{"HMD_FCR_AcmBore", RadToMil()}})

-- Target Designator Box (NAV and A/A mode)
local TD_box_root = addPlaceholder("HMD_AA_TD_boxRoot", {0, 0}, autoBlank.name, {{"HMD_AA_TD_BoxPos", RadToMil()}})
-- basic box
local HMD_TD_box = addStrokeSymbol("HMD_AA_TD_box",   {"stroke_symbols_HMD", "AA-TD-box"},	"FromSet", {0, 0}, TD_box_root.name, {{"HMD_AA_TD_BoxKind", 2}})
addStrokeText("HMD_AA_TD_altitude", "", STROKE_FNT_DFLT_150, "CenterTop", {0, -15.5}, HMD_TD_box.name, {{"HMD_AA_TD_Altitude"}})

-- Target Locator Line
addStrokeLine("HMD_TLL", 40, {0,0}, 0, hmd_dacPosition.name, {{"HMD_TargetLocatorLineDac"}})

-- Range scale
local dlzWidth = 6
local dlzRange = 74
local DLZ_root = addPlaceholder("HMD_AA_DLZ_root", {104, 35}, autoBlank.name, {{"HMD_AA_DLZ_Show"}})
local RangeScale_root = addPlaceholder("HMD_RangeScale_root", {0, 0}, DLZ_root.name)--, {{"HUD_RangeScale_Show"}})

addStrokeText("HMD_RangeScale", "", STROKE_FNT_DFLT_150, "CenterBottom", {3, dlzRange+3}, RangeScale_root.name, {{"HMD_RangeScale"}})
addStrokeLine("HMD_RangeScale_line", dlzWidth, {0, dlzRange}, -90, RangeScale_root.name)
addStrokeLine("HMD_AA_DLZ_zeroRange", dlzWidth, {0, 0}, -90, RangeScale_root.name)

local dlzRangeCaret = addStrokeSymbol("HMD_AA_DLZ_TgtRange",   {"stroke_symbols_HMD", "AA-DLZ-range"},	"FromSet", {0, 0}, DLZ_root.name, {{"HMD_AA_DLZ_TgtRange"}})
addStrokeText("HMD_AA_DLZ_TgtClosureRate", "", STROKE_FNT_DFLT_150, "RightCenter", {-6, 0}, dlzRangeCaret.name, {{"HMD_AA_DLZ_TgtClosureRate"}})
addStrokeText("HMD_AA_AIM120_AF_Pole", "", STROKE_FNT_DFLT_150, "RightCenter", {-6, -13}, dlzRangeCaret.name, {{"HMD_AA_AIM120_AF_Pole"}})

-- RWR Symbol
local RWR_root = addPlaceholder("RWR_root", {-101.94, 50}, autoBlank.name, {{"HMD_RWR_Show"}})
	local RWR_Threat_Circle = addStrokeCircle("RWR_Threat_Circle", 17.5, {0,0}, RWR_root.name, {{"HMD_RWR_Circle_Pos"}}, {0, math.pi * 2 - 0.34})
		RWR_Threat_Circle.init_rot = {100}
	local RWR_Diamond_PH = addPlaceholder("RWR_Diamond_PH", {0,0}, RWR_root.name, {{"HMD_RWR_Diamond_Pos"}})
		local RWR_Threat_Diamond = addStrokeBox("RWR_Threat_Diamond", 6, 6, "CenterCenter", {0,22}, RWR_Diamond_PH.name, nil)
			RWR_Threat_Diamond.init_rot = {45}
	addStrokeText("RWR_Threat_Symbol", "", STROKE_FNT_DFLT_150, "CenterCenter", {0,0}, RWR_root.name, {{"HMD_RWR_Symbol"}})
	
-- Window 38 DL SPI message
local HMD_DL_DATA_PH = addPlaceholder("HMD_DL_DATA_PH", {0, -15}, autoBlank.name, {{"HMD_DL_Message_Win38"}})
	addStrokeText("HMD_DL_DATA_MKPT_NUMBER", "MKPT71", STROKE_FNT_DFLT_150, "CenterCenter", {0, 0}, HMD_DL_DATA_PH.name, {{"HMD_mkptNumber_Win38"}})
	addStrokeText("HMD_DL_DATA", "DATA", STROKE_FNT_DFLT_150, "CenterCenter", {0, -15}, HMD_DL_DATA_PH.name)

local PDLT_symbol_root = addPlaceholder("HMD_AA_PDLT_symbol_root", nil,  autoBlank.name, {{"HMD_AA_PDLT_symbol_position", RadToMil()}})
	addStrokeSymbol("HMD_PDLT_symbol", {"stroke_symbols_HMD", "pdlt_symbol"}, "FromSet", {0, 0}, PDLT_symbol_root.name)
	addStrokeText("HMD_PDLT_altitude", "00", STROKE_FNT_DFLT_100, "CenterCenter", {0, -17}, PDLT_symbol_root.name, {{"HMD_AA_PDLT_altitude"}})

local PDLT_TLL_symbol_root = addPlaceholder("HMD_AA_PDLT_TLL_symbol_root", {0,0}, autoBlank.name, {{"HMD_PDLT_TargetLocatorLinePosition"}, {"HMD_PDLT_TargetLocatorLineRotation"}})
	addStrokeSymbol("HMD_PDLT_TLL_symbol", {"stroke_symbols_HMD", "pdlt-TLL"}, "FromSet", {0, 0}, PDLT_TLL_symbol_root.name)
	
-- Pull up point (PUP)
local HMD_Pull_up_point = addStrokeCircle("HMD_Pull_up_point", 4, nil, autoBlank.name, {{"HMD_PUP_Symbol", RadToMil()}})

-- Offset aimpoint
for i = 1, 2 do 
	local HMD_OA_Sym_Root = addPlaceholder("HMD_OA_Sym_Root"..i, nil, autoBlank.name, {{"HMD_OA_Symbol", i, RadToMil()}})
		addStrokeLine("OA_line_1"..i, 6, {-3, -3.3}, -90, HMD_OA_Sym_Root.name)
		addStrokeLine("OA_line_2"..i, 10.44, {-3, -3.3}, -16.7, HMD_OA_Sym_Root.name)
		addStrokeLine("OA_line_3"..i, 10.44, {3, -3.3}, 16.7, HMD_OA_Sym_Root.name)
end