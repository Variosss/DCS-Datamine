function create_simple_lamp(arg_, controller_, param_)
	local _lamp			= CreateGauge()
	_lamp.arg_number	= arg_
	_lamp.input			= {-1.0, 1.0}
	_lamp.output		= {-1.0, 1.0}
	_lamp.controller	= controller_
	if param_ ~= nil then
		_lamp.params 	= {param_}
	end
	return _lamp
end

local count = -1
local function counter()
	count = count + 1
	return count
end

-- Warning, Caution and Indicator Lights
CautionLights = 
{
	-- Caution Light Indicator Panel
	CPT_LTS_CK_SEAT					= counter(),
	CPT_LTS_APU_ACC					= counter(),
	CPT_LTS_BATT_SW					= counter(),
	CPT_LTS_FCS_HOT					= counter(),
	CPT_LTS_GEN_TIE					= counter(),
	CPT_LTS_SPARE_CTN1				= counter(),
	CPT_LTS_FUEL_LO					= counter(),
	CPT_LTS_FCES					= counter(),
	CPT_LTS_SPARE_CTN2				= counter(),
	CPT_LTS_L_GEN					= counter(),
	CPT_LTS_R_GEN					= counter(),
	CPT_LTS_SPARE_CTN3				= counter(),
	-- LH Advisory and Threat Warning Indicator Panel
	CPT_LTS_MASTER_CAUTION			= counter(),
	CPT_LTS_FIRE_LEFT				= counter(),
	CPT_LTS_GO						= counter(),
	CPT_LTS_NO_GO					= counter(),
	CPT_LTS_L_BLEED					= counter(),
	CPT_LTS_R_BLEED					= counter(),
	CPT_LTS_SPD_BRK					= counter(),
	CPT_LTS_STBY					= counter(),
	CPT_LTS_L_BAR_RED				= counter(),
	CPT_LTS_REC						= counter(),
	CPT_LTS_L_BAR_GREEN				= counter(),
	CPT_LTS_XMIT					= counter(),
	CPT_LTS_ASPJ_OH					= counter(),
	-- RH Advisory and Threat Warning Indicator Panel
	CPT_LTS_FIRE_APU				= counter(),
	CPT_LTS_FIRE_RIGHT				= counter(),
	CPT_LTS_RCDR_ON					= counter(),
	CPT_LTS_DISP					= counter(),
	CPT_LTS_SAM						= counter(),
	CPT_LTS_AI						= counter(),
	CPT_LTS_AAA						= counter(),
	CPT_LTS_CW						= counter(),
	CPT_LTS_SPARE_RH1				= counter(),
	CPT_LTS_SPARE_RH2				= counter(),
	CPT_LTS_SPARE_RH3				= counter(),
	CPT_LTS_SPARE_RH4				= counter(),
	CPT_LTS_SPARE_RH5				= counter(),
	-- Flaps, Landing Gear and Stores Indicator Panel
	CPT_LTS_CTR						= counter(),
	CPT_LTS_LI						= counter(),
	CPT_LTS_LO						= counter(),
	CPT_LTS_RI						= counter(),
	CPT_LTS_RO						= counter(),
	CPT_LTS_NOSE_GEAR				= counter(),
	CPT_LTS_LEFT_GEAR				= counter(),
	CPT_LTS_RIGHT_GEAR				= counter(),
	CPT_LTS_HALF_FLAPS				= counter(),
	CPT_LTS_FULL_FLAPS				= counter(),
	CPT_LTS_FLAPS					= counter(),
	-- Lock/Shoot Light Assy
	CPT_LTS_LOCK					= counter(),
	CPT_LTS_SHOOT					= counter(),
	CPT_LTS_SHOOT_STROBE			= counter(),
	-- Master Arm Control
	CPT_LTS_AA						= counter(),
	CPT_LTS_AG						= counter(),
	CPT_LTS_DISCH					= counter(),
	CPT_LTS_READY					= counter(),
	-- Arresting Hook Control Handle
	CPT_LTS_HOOK					= counter(),
	-- Landing Gear 
	CPT_LTS_LDG_GEAR_HANDLE			= counter(),
	-- APU Control Panel
	CPT_LTS_APU_READY				= counter(),
	-- ECM Control Panel Assy
	CPT_LTS_SEL						= counter(),
	-- Map Gain Control Panel Assy
	CPT_LTS_SPN						= counter(),
	-- Height Indicator
	CPT_LTS_LOW_ALT_WARN			= counter(),
	-- AMAC Control
	CautionLightsNumber				= counter(),
	CPT_LTS_AOA_HIGH				= counter(),
	CPT_LTS_AOA_CENTER				= counter(),
	CPT_LTS_AOA_LOW					= counter()
}

function create_caution_lamp(arg_, param_) 
	return create_simple_lamp(arg_, controllers.WCALights, param_)
end

-- Caution Light Indicator Panel
create_caution_lamp(298,	CautionLights.CPT_LTS_CK_SEAT)
create_caution_lamp(299,	CautionLights.CPT_LTS_APU_ACC)
create_caution_lamp(300,	CautionLights.CPT_LTS_BATT_SW)
create_caution_lamp(301,	CautionLights.CPT_LTS_FCS_HOT)
create_caution_lamp(302,	CautionLights.CPT_LTS_GEN_TIE)
create_caution_lamp(303,	CautionLights.CPT_LTS_SPARE_CTN1)
create_caution_lamp(304,	CautionLights.CPT_LTS_FUEL_LO)
create_caution_lamp(305,	CautionLights.CPT_LTS_FCES)
create_caution_lamp(306,	CautionLights.CPT_LTS_SPARE_CTN2)
create_caution_lamp(307,	CautionLights.CPT_LTS_L_GEN)
create_caution_lamp(308,	CautionLights.CPT_LTS_R_GEN)
create_caution_lamp(309,	CautionLights.CPT_LTS_SPARE_CTN3)
-- LH Advisory and Threat Warning Indicator Panel
create_caution_lamp(13,		CautionLights.CPT_LTS_MASTER_CAUTION)
create_caution_lamp(10,		CautionLights.CPT_LTS_FIRE_LEFT)
create_caution_lamp(15,		CautionLights.CPT_LTS_GO)
create_caution_lamp(16,		CautionLights.CPT_LTS_NO_GO)
create_caution_lamp(17,		CautionLights.CPT_LTS_L_BLEED)
create_caution_lamp(18,		CautionLights.CPT_LTS_R_BLEED)
create_caution_lamp(19,		CautionLights.CPT_LTS_SPD_BRK)
create_caution_lamp(20,		CautionLights.CPT_LTS_STBY)
create_caution_lamp(21,		CautionLights.CPT_LTS_L_BAR_RED)
create_caution_lamp(22,		CautionLights.CPT_LTS_REC)
create_caution_lamp(23,		CautionLights.CPT_LTS_L_BAR_GREEN)
create_caution_lamp(24,		CautionLights.CPT_LTS_XMIT)
create_caution_lamp(25,		CautionLights.CPT_LTS_ASPJ_OH)
-- RH Advisory and Threat Warning Indicator Panel
create_caution_lamp(29,		CautionLights.CPT_LTS_FIRE_APU)
create_caution_lamp(26,		CautionLights.CPT_LTS_FIRE_RIGHT)
create_caution_lamp(31,		CautionLights.CPT_LTS_RCDR_ON)
create_caution_lamp(32,		CautionLights.CPT_LTS_DISP)
create_caution_lamp(38,		CautionLights.CPT_LTS_SAM)
create_caution_lamp(39,		CautionLights.CPT_LTS_AI)
create_caution_lamp(40,		CautionLights.CPT_LTS_AAA)
create_caution_lamp(41,		CautionLights.CPT_LTS_CW)
create_caution_lamp(33,		CautionLights.CPT_LTS_SPARE_RH1)
create_caution_lamp(34,		CautionLights.CPT_LTS_SPARE_RH2)
create_caution_lamp(35,		CautionLights.CPT_LTS_SPARE_RH3)
create_caution_lamp(36,		CautionLights.CPT_LTS_SPARE_RH4)
create_caution_lamp(37,		CautionLights.CPT_LTS_SPARE_RH5)
-- Flaps, Landing Gear and Stores Indicator Panel
create_caution_lamp(152,	CautionLights.CPT_LTS_CTR)
create_caution_lamp(154,	CautionLights.CPT_LTS_LI)
create_caution_lamp(156,	CautionLights.CPT_LTS_LO)
create_caution_lamp(158,	CautionLights.CPT_LTS_RI)
create_caution_lamp(160,	CautionLights.CPT_LTS_RO)
create_caution_lamp(166,	CautionLights.CPT_LTS_NOSE_GEAR)
create_caution_lamp(165,	CautionLights.CPT_LTS_LEFT_GEAR)
create_caution_lamp(167,	CautionLights.CPT_LTS_RIGHT_GEAR)
create_caution_lamp(163,	CautionLights.CPT_LTS_HALF_FLAPS)
create_caution_lamp(164,	CautionLights.CPT_LTS_FULL_FLAPS)
create_caution_lamp(162,	CautionLights.CPT_LTS_FLAPS)
-- Lock/Shoot Light Assy
create_caution_lamp(1,		CautionLights.CPT_LTS_LOCK)
create_caution_lamp(2,		CautionLights.CPT_LTS_SHOOT)
create_caution_lamp(3,		CautionLights.CPT_LTS_SHOOT_STROBE)
-- Master Arm Control
create_caution_lamp(47,		CautionLights.CPT_LTS_AA)
create_caution_lamp(48,		CautionLights.CPT_LTS_AG)
create_caution_lamp(45,		CautionLights.CPT_LTS_DISCH)
create_caution_lamp(44,		CautionLights.CPT_LTS_READY)
-- Arresting Hook Control Handle
create_caution_lamp(294,	CautionLights.CPT_LTS_HOOK)
-- Landing Gear 
create_caution_lamp(227, CautionLights.CPT_LTS_LDG_GEAR_HANDLE)
-- APU Control Panel
create_caution_lamp(376,	CautionLights.CPT_LTS_APU_READY)
-- ECM Control Panel Assy
--create_caution_lamp(CautionLights.CPT_LTS_SEL)
-- Map Gain Control Panel Assy
create_caution_lamp(137,	CautionLights.CPT_LTS_SPN)
-- Height Indicator
create_caution_lamp(290,	CautionLights.CPT_LTS_LOW_ALT_WARN)
-- AoA Indexer Lights
create_caution_lamp(4,		CautionLights.CPT_LTS_AOA_HIGH)
create_caution_lamp(5,		CautionLights.CPT_LTS_AOA_CENTER)
create_caution_lamp(6,		CautionLights.CPT_LTS_AOA_LOW)

-- Internal Lights
count = -1
-- For enumeration - see avCptLightsSystem_F18.h
InternalLights = 
{
	Console_lt		= counter(),
	Flood_lt		= counter(),
	NvgFlood_lt		= counter(),
	EmerInstr_lt	= counter(),
	EngInstFlood_lt	= counter(),
	Instrument_lt	= counter(),
	StbyCompass_lt	= counter(),
	Utility_lt		= counter(),
	Chart_lt		= counter(),
}
function create_int_lights(arg_, param_) 
	return create_simple_lamp(arg_, controllers.internalLights, param_)
end

Console_lt			= create_int_lights(460, InternalLights.Console_lt)
Flood_lt			= create_int_lights(461, InternalLights.Flood_lt)
NvgFlood_lt			= create_int_lights(462, InternalLights.NvgFlood_lt)
EmerInstr_lt		= create_int_lights(464, InternalLights.EmerInstr_lt)			-- Floodlights 2
EngInstFlood_lt		= create_int_lights(465, InternalLights.EngInstFlood_lt)
Instrument_lt		= create_int_lights(466, InternalLights.Instrument_lt)
StbyCompass_lt		= create_int_lights(467, InternalLights.StbyCompass_lt)
--Utility_lt			= create_int_lights(810, InternalLights.Utility_lt)
Chart_lt			= create_int_lights(463, InternalLights.Chart_lt)

function create_wca_brightness(arg_, param_) 
	return create_simple_lamp(arg_, controllers.WCAGroupLightness, param_)
end

create_wca_brightness(521, 0)
create_wca_brightness(522, 1)
create_wca_brightness(523, 2)

-- IFEI
IFEI_lt				= create_simple_lamp(468, controllers.IfeiLights, 0)
IFEI_buttons_lt		= create_simple_lamp(469, controllers.IfeiLights, 1)

-- RWR
Lower_lt			= create_simple_lamp(276, controllers.RWR_LowerLt)
Limit_lt			= create_simple_lamp(273, controllers.RWR_LimitLt)
Display_lt			= create_simple_lamp(274, controllers.RWR_LowerLt)
--SpecialEn_lt		= create_simple_lamp(270, controllers.RWR_LowerLt)
Special_lt			= create_simple_lamp(271, controllers.RWR_LowerLt)
Enable_lt			= create_simple_lamp(267, controllers.RWR_EnableLt)
Offset_lt			= create_simple_lamp(268, controllers.RWR_LowerLt)
Fail_lt				= create_simple_lamp(264, controllers.RWR_FailLt)
Bit_lt				= create_simple_lamp(265, controllers.RWR_LowerLt)
RwrLightsBrightness = create_simple_lamp(520, controllers.RWR_LowerLt)

-- CMDS
ecmJett				= create_simple_lamp(516, controllers.CMDS_JettLt)
