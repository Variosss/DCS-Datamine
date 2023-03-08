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
	-- Caution Light Panel
	FLCS_FAULT		= counter(),
	ENGINE_FAULT	= counter(),
	AVIONICS_FAULT	= counter(),
	SEAT_NOT_ARMED	= counter(),
	ELEC_SYS		= counter(),
	SEC				= counter(),
	EQUIP_HOT		= counter(),
	NWS_FAIL		= counter(),
	PROBE_HEAT		= counter(),
	FUEL_OIL_HOT	= counter(),
	RADAR_ALT		= counter(),
	ANTI_SKID		= counter(),
	CADC			= counter(),
	INLET_ICING		= counter(),
	IFF				= counter(),
	HOOK			= counter(),
	STORES_CONFIG	= counter(),
	OVERHEAT		= counter(),
	NUCLEAR			= counter(),
	OBOGS			= counter(),
	ATF_NOT_ENGAGED	= counter(),
	EEC				= counter(),
	CABIN_PRESS		= counter(),
	FWD_FUEL_LOW	= counter(),
	BUC				= counter(),
	AFT_FUEL_LOW	= counter(),
	-- Edge of glareshield
	MASTER_CAUTION	= counter(),
	TF_FAIL			= counter(),
	ENG_FIRE		= counter(),
	ENGINE			= counter(),
	HYD_OIL_PRESS	= counter(),
	FLCS			= counter(),
	DBU_ON			= counter(),
	TO_LDG_CONFIG	= counter(),
	CANOPY			= counter(),
	OXY_LOW			= counter(),
	-- AOA Indexer
	AOA_RED			= counter(),
	AOA_GREEN		= counter(),
	AOA_YELLOW		= counter(),
	-- LG Control Panel
	GEAR_NOSE		= counter(),
	GEAR_LEFT		= counter(),
	GEAR_RIGHT		= counter(),
	GEAR_WARNING	= counter(),
	-- AR Status/NWS Indicator
	RDY				= counter(),
	AR_NWS			= counter(),
	DISC			= counter(),
	--
	MARKER_BEACON	= counter(),
	-- Eng Control Panel
	JFS_RUN			= counter(),
	-- EPU Control Panel
	HYDRAZN			= counter(),
	AIR				= counter(),
	EPU				= counter(),
	-- Elec Control Panel
	FLCS_PMG		= counter(),
	MAIN_GEN		= counter(),
	STBY_GEN		= counter(),
	EPU_GEN			= counter(),
	EPU_PMG			= counter(),
	TO_FLCS			= counter(),
	FLCS_RLY		= counter(),
	ACFT_BATT_FAIL	= counter(),
	-- Advance Mode Switch
	ACTIVE			= counter(),
	STBY			= counter(),
	-- FLCP
	FL_RUN			= counter(),
	FL_FAIL			= counter(),
	-- Test Switch Panel
	FLCS_PWR_A		= counter(),
	FLCS_PWR_B		= counter(),
	FLCS_PWR_C		= counter(),
	FLCS_PWR_D		= counter(),
	--
	LIGHTS_MAX		= counter(),
}

function create_caution_lamp(arg_, param_) 
	return create_simple_lamp(arg_, controllers.WCILights, param_)
end

	-- Caution Light Panel
create_caution_lamp(630, CautionLights.FLCS_FAULT)
create_caution_lamp(631, CautionLights.ENGINE_FAULT)
create_caution_lamp(632, CautionLights.AVIONICS_FAULT)
create_caution_lamp(633, CautionLights.SEAT_NOT_ARMED)
create_caution_lamp(634, CautionLights.ELEC_SYS)
create_caution_lamp(635, CautionLights.SEC)
create_caution_lamp(636, CautionLights.EQUIP_HOT)
create_caution_lamp(637, CautionLights.NWS_FAIL)
create_caution_lamp(638, CautionLights.PROBE_HEAT)
create_caution_lamp(639, CautionLights.FUEL_OIL_HOT)
create_caution_lamp(640, CautionLights.RADAR_ALT)
create_caution_lamp(641, CautionLights.ANTI_SKID)
create_caution_lamp(642, CautionLights.CADC)
create_caution_lamp(643, CautionLights.INLET_ICING)
create_caution_lamp(644, CautionLights.IFF)
create_caution_lamp(645, CautionLights.HOOK)
create_caution_lamp(646, CautionLights.STORES_CONFIG)
create_caution_lamp(647, CautionLights.OVERHEAT)
create_caution_lamp(648, CautionLights.NUCLEAR)
create_caution_lamp(649, CautionLights.OBOGS)
create_caution_lamp(650, CautionLights.ATF_NOT_ENGAGED)
create_caution_lamp(651, CautionLights.EEC)
create_caution_lamp(652, CautionLights.LIGHTS_MAX)
create_caution_lamp(653, CautionLights.CABIN_PRESS)
create_caution_lamp(654, CautionLights.FWD_FUEL_LOW)
create_caution_lamp(655, CautionLights.BUC)
create_caution_lamp(656, CautionLights.LIGHTS_MAX)
create_caution_lamp(657, CautionLights.LIGHTS_MAX)
create_caution_lamp(658, CautionLights.AFT_FUEL_LOW)
create_caution_lamp(659, CautionLights.LIGHTS_MAX)
create_caution_lamp(660, CautionLights.LIGHTS_MAX)
create_caution_lamp(661, CautionLights.LIGHTS_MAX)
	-- Edge of glareshield
create_caution_lamp(117, CautionLights.MASTER_CAUTION)
create_caution_lamp(121, CautionLights.TF_FAIL)
create_caution_lamp(126, CautionLights.ENG_FIRE)
create_caution_lamp(127, CautionLights.ENGINE)
create_caution_lamp(129, CautionLights.HYD_OIL_PRESS)
create_caution_lamp(130, CautionLights.FLCS)
create_caution_lamp(131, CautionLights.DBU_ON)
create_caution_lamp(133, CautionLights.TO_LDG_CONFIG)
create_caution_lamp(134, CautionLights.CANOPY)
create_caution_lamp(135, CautionLights.OXY_LOW)
	-- AOA Indexer
create_caution_lamp(110, CautionLights.AOA_RED)
create_caution_lamp(111, CautionLights.AOA_GREEN)
create_caution_lamp(112, CautionLights.AOA_YELLOW)
	-- LG Control Panel
create_caution_lamp(350, CautionLights.GEAR_NOSE)
create_caution_lamp(351, CautionLights.GEAR_LEFT)
create_caution_lamp(352, CautionLights.GEAR_RIGHT)
create_caution_lamp(369, CautionLights.GEAR_WARNING)
	-- AR Status/NWS Indicator
create_caution_lamp(113, CautionLights.RDY)
create_caution_lamp(114, CautionLights.AR_NWS)
create_caution_lamp(115, CautionLights.DISC)
	--
create_caution_lamp(157, CautionLights.MARKER_BEACON)
	-- Eng Control Panel
create_caution_lamp(446, CautionLights.JFS_RUN)
	-- EPU Control Panel
create_caution_lamp(524, CautionLights.HYDRAZN)
create_caution_lamp(523, CautionLights.AIR)
create_caution_lamp(526, CautionLights.EPU)
	-- Elec Control Panel
create_caution_lamp(513, CautionLights.FLCS_PMG)
create_caution_lamp(512, CautionLights.MAIN_GEN)
create_caution_lamp(515, CautionLights.STBY_GEN)
create_caution_lamp(517, CautionLights.EPU_GEN)
create_caution_lamp(516, CautionLights.EPU_PMG)
create_caution_lamp(519, CautionLights.TO_FLCS)
create_caution_lamp(518, CautionLights.FLCS_RLY)
create_caution_lamp(521, CautionLights.ACFT_BATT_FAIL)
	-- Advance Mode Switch
create_caution_lamp(106, CautionLights.ACTIVE)
create_caution_lamp(107, CautionLights.STBY)
	-- FLCP
create_caution_lamp(570, CautionLights.FL_RUN)
create_caution_lamp(571, CautionLights.FL_FAIL)
	-- Test Switch Panel
create_caution_lamp(581, CautionLights.FLCS_PWR_A)
create_caution_lamp(582, CautionLights.FLCS_PWR_B)
create_caution_lamp(583, CautionLights.FLCS_PWR_C)
create_caution_lamp(584, CautionLights.FLCS_PWR_D)

-- RWR button lights
count = -1
RWRLights = 
{
	POWER			= counter(),
	SHIP_UNKNOWN	= counter(),
	SHIP_U			= counter(),
	SYSTEST_ON		= counter(),
	SYSTEST			= counter(),
	TGTSEP_UP		= counter(),
	TGTSEP_DOWN		= counter(),
	ALT				= counter(),
	ALT_LOW			= counter(),
	HANDOFF_UP		= counter(),
	HANDOFF_H		= counter(),
	SEARCH			= counter(),
	MODE_OPEN		= counter(),
	MODE_PRI		= counter(),
	--
	ACTIVITY		= counter(),
	ACT_POWER		= counter(),
	MSL_LAUNCH		= counter(),
}
function create_rwr_lights(arg_, flag) 
	local _lamp	= create_simple_lamp(arg_, controllers.rwrLights)
	_lamp.params 	= {flag}
	return _lamp
end

rwr_Search			= create_rwr_lights(396, RWRLights.SEARCH)
rwr_Activity		= create_rwr_lights(398, RWRLights.ACTIVITY)
rwr_ActPower		= create_rwr_lights(423, RWRLights.ACT_POWER)
rwr_Alt_Low			= create_rwr_lights(400, RWRLights.ALT_LOW)
rwr_Alt				= create_rwr_lights(424, RWRLights.ALT)
rwr_Power			= create_rwr_lights(402, RWRLights.POWER)
rwr_Hand_Up			= create_rwr_lights(142, RWRLights.HANDOFF_UP)
rwr_Hand_H			= create_rwr_lights(136, RWRLights.HANDOFF_H)
rwr_Launch			= create_rwr_lights(144, RWRLights.MSL_LAUNCH)
rwr_Mode_Pri		= create_rwr_lights(146, RWRLights.MODE_PRI)
rwr_Mode_Open		= create_rwr_lights(137, RWRLights.MODE_OPEN)
rwr_Ship_U			= create_rwr_lights(153, RWRLights.SHIP_U)
rwr_Ship_unkn		= create_rwr_lights(148, RWRLights.SHIP_UNKNOWN)
rwr_Sys_On			= create_rwr_lights(154, RWRLights.SYSTEST_ON)
rwr_Sys				= create_rwr_lights(150, RWRLights.SYSTEST)
rwr_Sep_Up			= create_rwr_lights(152, RWRLights.TGTSEP_UP)
rwr_Sep_Down		= create_rwr_lights(138, RWRLights.TGTSEP_DOWN)
-- Brightness 792
brtRwrLights 		= create_simple_lamp(792, controllers.brtRwrLights)

-- CMDS lights
count = -1
-- For enumeration - see avRWR_IC_F5
CmdsLights = 
{
		NO_GO	= counter(),
		GO		= counter(),
		DISP	= counter(),
		RDY		= counter(),
}
function create_cmds_lights(arg_, flag) 
	local _lamp	= create_simple_lamp(arg_, controllers.cmdsLights)
	_lamp.params 	= {flag}
	return _lamp
end
cmds_nogo	= create_cmds_lights(370, CmdsLights.NO_GO)
cmds_go		= create_cmds_lights(372, CmdsLights.GO)
cmds_disp	= create_cmds_lights(376, CmdsLights.DISP)
cmds_rdy	= create_cmds_lights(379, CmdsLights.RDY)

BrightnessCMDS	= create_simple_lamp(789, controllers.BrightnessCMDS)

-- Interior lighting
count = -1
InternalLights = 
{
	Consoles_lt			= counter(),
	InstPnl_lt			= counter(),
	DeDisplay_lt		= counter(),
	PflDisplay_lt		= counter(),
	ConsolesFlood_lt	= counter(),
	InstPnlFlood_lt		= counter(),
	UtilityFlash_lt		= counter(),	-- flashlight
}
function create_int_lights(arg_, param_) 
	return create_simple_lamp(arg_, controllers.internalLights, param_)
end

Consoles_lt			= create_int_lights(788, InternalLights.Consoles_lt)
InstPnl_lt			= create_int_lights(787, InternalLights.InstPnl_lt)
ConsolesFlood_lt	= create_int_lights(790, InternalLights.ConsolesFlood_lt)
InstPnlFlood_lt		= create_int_lights(791, InternalLights.InstPnlFlood_lt)

BrightnessWCI		= create_simple_lamp(793, controllers.BrightnessWCI)

-- ECM panel
count = -1
ECM_Button_Lights = 
{
	Btn_1_S 			= counter(),
	Btn_1_A 			= counter(),
	Btn_1_F 			= counter(),
	Btn_1_T 			= counter(),
	Btn_2_S 			= counter(),
	Btn_2_A 			= counter(),
	Btn_2_F 			= counter(),
	Btn_2_T 			= counter(),
	Btn_3_S 			= counter(),
	Btn_3_A 			= counter(),
	Btn_3_F 			= counter(),
	Btn_3_T 			= counter(),
	Btn_4_S 			= counter(),
	Btn_4_A 			= counter(),
	Btn_4_F 			= counter(),
	Btn_4_T 			= counter(),
	Btn_5_S 			= counter(),
	Btn_5_A 			= counter(),
	Btn_5_F 			= counter(),
	Btn_5_T 			= counter(),
	Btn_6_S 			= counter(),
	Btn_6_A 			= counter(),
	Btn_6_F 			= counter(),
	Btn_6_T 			= counter(),
	Btn_FRM_S 			= counter(),
	Btn_FRM_A 			= counter(),
	Btn_FRM_F 			= counter(),
	Btn_FRM_T 			= counter(),
	Btn_SPL_S 			= counter(),
	Btn_SPL_A 			= counter(),
	Btn_SPL_F 			= counter(),
	Btn_SPL_T 			= counter(),
}
function create_ECM_Button_lights(arg_, param_) 
	return create_simple_lamp(arg_, controllers.ECM_Button_Lights, param_)
end
ECM_Light 		= create_simple_lamp(102, controllers.ECM_Light)
Btn_1_S			= create_ECM_Button_lights(461, ECM_Button_Lights.Btn_1_S)
Btn_1_A			= create_ECM_Button_lights(462, ECM_Button_Lights.Btn_1_A)
Btn_1_F			= create_ECM_Button_lights(463, ECM_Button_Lights.Btn_1_F)
Btn_1_T			= create_ECM_Button_lights(464, ECM_Button_Lights.Btn_1_T)
Btn_2_S			= create_ECM_Button_lights(466, ECM_Button_Lights.Btn_2_S)
Btn_2_A			= create_ECM_Button_lights(467, ECM_Button_Lights.Btn_2_A)
Btn_2_F			= create_ECM_Button_lights(468, ECM_Button_Lights.Btn_2_F)
Btn_2_T			= create_ECM_Button_lights(469, ECM_Button_Lights.Btn_2_T)
Btn_3_S			= create_ECM_Button_lights(471, ECM_Button_Lights.Btn_3_S)
Btn_3_A			= create_ECM_Button_lights(472, ECM_Button_Lights.Btn_3_A)
Btn_3_F			= create_ECM_Button_lights(473, ECM_Button_Lights.Btn_3_F)
Btn_3_T			= create_ECM_Button_lights(474, ECM_Button_Lights.Btn_3_T)
Btn_4_S			= create_ECM_Button_lights(476, ECM_Button_Lights.Btn_4_S)
Btn_4_A			= create_ECM_Button_lights(477, ECM_Button_Lights.Btn_4_A)
Btn_4_F			= create_ECM_Button_lights(478, ECM_Button_Lights.Btn_4_F)
Btn_4_T			= create_ECM_Button_lights(479, ECM_Button_Lights.Btn_4_T)
Btn_5_S			= create_ECM_Button_lights(481, ECM_Button_Lights.Btn_5_S)
Btn_5_A			= create_ECM_Button_lights(482, ECM_Button_Lights.Btn_5_A)
Btn_5_F			= create_ECM_Button_lights(483, ECM_Button_Lights.Btn_5_F)
Btn_5_T			= create_ECM_Button_lights(484, ECM_Button_Lights.Btn_5_T)
Btn_6_S			= create_ECM_Button_lights(486, ECM_Button_Lights.Btn_6_S)
Btn_6_A			= create_ECM_Button_lights(487, ECM_Button_Lights.Btn_6_A)
Btn_6_F			= create_ECM_Button_lights(488, ECM_Button_Lights.Btn_6_F)
Btn_6_T			= create_ECM_Button_lights(489, ECM_Button_Lights.Btn_6_T)
Btn_FRM_S		= create_ECM_Button_lights(491, ECM_Button_Lights.Btn_FRM_S)
Btn_FRM_A		= create_ECM_Button_lights(492, ECM_Button_Lights.Btn_FRM_A)
Btn_FRM_F		= create_ECM_Button_lights(493, ECM_Button_Lights.Btn_FRM_F)
Btn_FRM_T		= create_ECM_Button_lights(494, ECM_Button_Lights.Btn_FRM_T)
Btn_SPL_S		= create_ECM_Button_lights(496, ECM_Button_Lights.Btn_SPL_S)
Btn_SPL_A		= create_ECM_Button_lights(497, ECM_Button_Lights.Btn_SPL_A)
Btn_SPL_F		= create_ECM_Button_lights(498, ECM_Button_Lights.Btn_SPL_F)
Btn_SPL_T		= create_ECM_Button_lights(499, ECM_Button_Lights.Btn_SPL_T)
BrightnessECM	= create_simple_lamp(803, controllers.ECM_Brightness)