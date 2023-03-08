-- Commands : not intended for end-user editing

start_command   = 3000
local count = 0
local function counter()
	count = count + 1
	return count
end

count = start_command
device_commands = {}
for cmd_num = 1,70 do
	device_commands["Button_"..cmd_num] = counter()
end

-- HOTAS Interface
count = start_command
hotas_commands =
{
	-- stick
	STICK_TRIGGER_1ST_DETENT				= counter();
	STICK_TRIGGER_2ND_DETENT				= counter();
	STICK_WEAPON_RELEASE					= counter();
	STICK_RECCE_EVENT_MARK					= counter();
	STICK_SENSOR_CONTROL_FWD				= counter();
	STICK_SENSOR_CONTROL_AFT				= counter();
	STICK_SENSOR_CONTROL_LEFT				= counter();
	STICK_SENSOR_CONTROL_RIGHT				= counter();
	STICK_WEAPON_SELECT_FWD					= counter();
	STICK_WEAPON_SELECT_AFT					= counter();
	STICK_WEAPON_SELECT_IN					= counter();
	STICK_WEAPON_SELECT_DOWN				= counter();
	STICK_UNDESIGNATE						= counter();
	STICK_TRIMMER_UP						= counter();
	STICK_TRIMMER_DOWN						= counter();
	STICK_TRIMMER_LEFT						= counter();
	STICK_TRIMMER_RIGHT						= counter();
	STICK_PADDLE							= counter();

	-- throttle
	THROTTLE_DESIGNATOR_CONTROLLER_UP		= counter();
	THROTTLE_DESIGNATOR_CONTROLLER_DOWN		= counter();
	THROTTLE_DESIGNATOR_CONTROLLER_LEFT		= counter();
	THROTTLE_DESIGNATOR_CONTROLLER_RIGHT	= counter();
	THROTTLE_DESIGNATOR_CONTROLLER_DEPRESS	= counter();
	THROTTLE_ELEVATION_CONTROL_UP			= counter();
	THROTTLE_ELEVATION_CONTROL_DOWN			= counter();
	THROTTLE_ELEVATION_CONTROL_AXIS			= counter();
	THROTTLE_COMMS_COMM1					= counter();
	THROTTLE_COMMS_COMM2					= counter();
	THROTTLE_COMMS_MIDS_A					= counter();
	THROTTLE_COMMS_MIDS_B					= counter();
	THROTTLE_CAGE							= counter();
	THROTTLE_DISPENSE_FWD					= counter();
	THROTTLE_DISPENSE_AFT					= counter();
	THROTTLE_RAID_FOV						= counter();
	THROTTLE_SPEED_BRAKE					= counter();
	THROTTLE_SPEED_BRAKE_EXT				= counter();
	THROTTLE_ATC							= counter();
	THROTTLE_LEFT_FINGERLIFT_EXT			= counter();
	THROTTLE_RIGHT_FINGERLIFT_EXT			= counter();
	THROTTLE_BOTH_FINGERLIFT_EXT			= counter();
	THROTTLE_EXTERIOR_LIGHTS				= counter();
	THROTTLE_EXTERIOR_LIGHTS_EXT			= counter();
	THROTTLE_DESIGNATOR_CONTROLLER_VERT_AXIS	= counter();
	THROTTLE_DESIGNATOR_CONTROLLER_HOR_AXIS		= counter();

	-- additional
	STICK_SENSOR_CONTROL_DEPRESS			= counter();

	THROTTLE_COMMS_COMM1_VOIP				= counter();
	THROTTLE_COMMS_COMM2_VOIP				= counter();
	THROTTLE_COMMS_MIDS_A_VOIP				= counter();
	THROTTLE_COMMS_MIDS_B_VOIP				= counter();
}

-- Control Interface
count = start_command
ctrl_commands =
{
	RudderTrim			= counter();
	TOTrimSw			= counter();
	ResetSw				= counter();
	FcsBitSw			= counter();
	GainSwCover			= counter();
	GainSw				= counter();
	FlapSw				= counter();
	SpinRecCover		= counter();
	SpinRec				= counter();
	WingFoldPull		= counter();
	WingFoldSelect		= counter();
	FrictionLever		= counter();
	-- input commands
	RudderTrim_EXT		= counter();
	RudderTrim_AXIS		= counter();
	GainSwCover_EXT		= counter();
	GainSw_EXT			= counter();
	FlapSw_EXT			= counter();
	SpinRecCover_EXT	= counter();
	SpinRec_EXT			= counter();
	WingFoldPull_ITER	= counter();
	WingFoldSelect_ITER	= counter();
	FrictionLever_EXT	= counter();
	FrictionLever_AXIS	= counter();
	AB_DETENT			= counter();
}

-- Electric Interface
count = start_command
elec_commands =
{
	BattSw					= counter();
	LGenSw					= counter();
	RGenSw					= counter();
	ExtPwrSw				= counter();
	ExtPwrReset				= counter();
	GenTieControlSw			= counter();
	GenTieControlSwCover	= counter();
	GndPwr1SwA				= counter();
	GndPwr1SwB				= counter();
	GndPwr2SwA				= counter();
	GndPwr2SwB				= counter();
	GndPwr3SwA				= counter();
	GndPwr3SwB				= counter();
	GndPwr4SwA				= counter();
	GndPwr4SwB				= counter();
	PitotHeater				= counter();
	-- CB
	CB_FCS_CHAN1			= counter();
	CB_FCS_CHAN2			= counter();
	CB_SPD_BRK				= counter();
	CB_LAUNCH_BAR			= counter();
	CB_FCS_CHAN3			= counter();
	CB_FCS_CHAN4			= counter();
	CB_HOOK					= counter();
	CB_LG					= counter();
	--
	MC1OffSw				= counter();
	MC2OffSw				= counter();

	-- input commands
	BattSw_EXT					= counter();
	LGenSw_EXT					= counter();
	RGenSw_EXT					= counter();
	ExtPwrSw_EXT				= counter();
	ExtPwrReset_EXT				= counter();
	GenTieControlSw_EXT			= counter();
	GenTieControlSwCover_EXT	= counter();
	GndPwr1SwA_EXT				= counter();
	GndPwr1SwB_EXT				= counter();
	GndPwr2SwA_EXT				= counter();
	GndPwr2SwB_EXT				= counter();
	GndPwr3SwA_EXT				= counter();
	GndPwr3SwB_EXT				= counter();
	GndPwr4SwA_EXT				= counter();
	GndPwr4SwB_EXT				= counter();
	--
	CB_FCS_CHAN1_EXT			= counter();
	CB_FCS_CHAN2_EXT			= counter();
	CB_SPD_BRK_EXT				= counter();
	CB_LAUNCH_BAR_EXT			= counter();
	CB_FCS_CHAN3_EXT			= counter();
	CB_FCS_CHAN4_EXT			= counter();
	CB_HOOK_EXT					= counter();
	CB_LG_EXT					= counter();
	--
	MC1OffSw_EXT				= counter();
	MC2OffSw_EXT				= counter();

}

-- Hydro Interface
count = start_command
hydro_commands =
{
	HydIsolSw		= counter();

	-- input commands
	HydIsolSw_EXT	= counter();
}

-- Gear Interface
count = start_command
gear_commands =
{
	GearHandle					= counter();
	EmergDown					= counter();
	DownLockOverrideBtn			= counter();
	AntiSkidSw					= counter();
	EmergParkHandleOnOff		= counter();
	EmergParkHandleSelectPark	= counter();
	EmergParkHandleSelectEmerg	= counter();
	LaunchBarSw					= counter();
	HookHandle					= counter();
	-- input commands
	AntiSkidSw_EXT				= counter();
	EmergParkHandleOnOff_EXT	= counter();
	EmergParkHandleSelect_EXT	= counter();
	HookHandle_EXT				= counter();
	LaunchBarSw_EXT				= counter();
}

-- Fuel Interface
count = start_command
fuel_commands =
{
	IntrWingInhibitSw		= counter();
	ProbeControlSw			= counter();
	DumpSw					= counter();
	ExtTanksCtrSw			= counter();
	ExtTanksWingSw			= counter();
	--input commands
	IntrWingInhibitSw_EXT	= counter();
	ProbeControlSw_EXT		= counter();
	ExtTanksCtrSw_EXT		= counter();
	ExtTanksWingSw_EXT		= counter();
}

-- Cockpit Mechanics
count = start_command
cpt_commands =
{
	CanopySwitchOpen					= counter();
	CanopySwitchClose					= counter();
	CanopyJettLever						= counter();
	CanopyJettLeverButton				= counter();
	StaticSourceSelect					= counter();
	EjectionSeatSafeArmedHandle			= counter();
	EjectionSeatManualOverrideHandle	= counter();
	SeatEjectionControlHandle			= counter();
	ShoulderHarnessControlHandle		= counter();
	SeatHeightAdjustmentSwitchUp		= counter();
	SeatHeightAdjustmentSwitchDn		= counter();
	RudderPedalAdjustLever				= counter();
	StickHide							= counter();
	-- input commands
	CanopyJettLever_EXT						= counter();
	StaticSourceSelect_EXT					= counter();
	EjectionSeatManualOverrideHandle_EXT	= counter();
	ShoulderHarnessControlHandle_EXT		= counter();
	StickHide_EXT							= counter();
	--
	SmokeDevice							= counter();
}

-- Exterior Lights
count = start_command
extlights_commands =
{
	Position			= counter();
	Formation			= counter();
	Strobe				= counter();
	LdgTaxi				= counter();
	-- input commands
	Position_EXT		= counter();
	Position_AXIS		= counter();
	Formation_EXT		= counter();
	Formation_AXIS		= counter();
	Strobe_EXT			= counter();
	LdgTaxi_EXT			= counter();
}

-- Cockpit Lights
count = start_command
cptlights_commands =
{
	Consoles			= counter();
	InstPnl				= counter();
	Flood				= counter();
	ModeSw				= counter();
	Chart				= counter();
	WarnCaution			= counter();
	LtTestSw			= counter();
	MasterCaution		= counter();
	HookBypass			= counter();
	-- input commands
	Consoles_EXT		= counter();
	Consoles_AXIS		= counter();
	InstPnl_EXT			= counter();
	InstPnl_AXIS		= counter();
	Flood_EXT			= counter();
	Flood_AXIS			= counter();
	ModeSw_EXT			= counter();
	Chart_EXT			= counter();
	Chart_AXIS			= counter();
	UtilityBtn_EXT		= counter();
	UtilityBrt_EXT		= counter();
	UtilityBrt_AXIS		= counter();
	WarnCaution_EXT		= counter();
	WarnCaution_AXIS	= counter();
	LtTestSw_EXT		= counter();
	HookBypass_EXT		= counter();
}

-- Oxygen System
count = start_command
oxygen_commands =
{
	OBOGS_ControlSw				= counter();
	OxyFlowControlValve			= counter();
	-- input commands
	OBOGS_ControlSw_EXT			= counter();
	OxyFlowControlValve_EXT		= counter();
	OxyFlowControlValve_AXIS	= counter();
}

-- ECS
count = start_command
ECS_commands =
{
	BleedAirSw					= counter();
	BleedAirSwAugPull			= counter();
	ECSModeSw					= counter();
	CabinPressSw				= counter();
	DefogHandle					= counter();
	CabinTemperatureRst			= counter();
	SuitTemperatureRst			= counter();
	AV_COOL_Sw					= counter();
	WindshieldSw				= counter();
	LeftLouver					= counter();
	RightLouver					= counter();
	-- input commands
	BleedAirSw_EXT				= counter();
	ECSModeSw_EXT				= counter();
	CabinPressSw_EXT			= counter();
	DefogHandle_EXT				= counter();
	DefogHandle_AXIS			= counter();
	CabinTemperatureRst_EXT		= counter();
	CabinTemperatureRst_AXIS	= counter();
	SuitTemperatureRst_EXT		= counter();
	SuitTemperatureRst_AXIS		= counter();
	WindshieldSw_ITER			= counter();
	LeftLouver_ITER				= counter();
	LeftLouver_AXIS				= counter();
	RightLouver_ITER			= counter();
	RightLouver_AXIS			= counter();
}

count = start_command
engines_commands =
{
	APU_ControlSw				= counter();
	EngineCrankLSw				= counter();
	EngineCrankRSw				= counter();
	LAMADDecouplerHandle		= counter();
	RAMADDecouplerHandle		= counter();
	--
	FireTestASw					= counter();
	FireTestBSw					= counter();
	--
	FireExtghDischSw			= counter();
	APU_FireSw					= counter();
	LENG_FireSw					= counter();
	RENG_FireSw					= counter();
	LENG_FireSwCover			= counter();
	RENG_FireSwCover			= counter();
	--
	AntiIceSw					= counter();
	-- input commands
	EngineCrankLSw_EXT			= counter();
	EngineCrankRSw_EXT			= counter();
	APU_FireSw_ITER				= counter();
	LENG_FireSw_ITER			= counter();
	RENG_FireSw_ITER			= counter();
	LENG_FireSwCover_ITER		= counter();
	RENG_FireSwCover_ITER		= counter();
	AntiIceSw_ITER				= counter();
	APU_ControlSw_TM_WARTHOG	= counter();
}

-- Instruments --------------------------
-- Altimeter AAU-52/A
count = start_command
aau52_commands =
{
	AAU52_ClkCmd_ZeroSetting	= counter();
}

-- Radio altimeter ID-2163/A
count = start_command
id2163a_commands =
{
	ID2163A_PushToTest		= counter();
	ID2163A_SetMinAlt		= counter();
	-- input commands
}

-- Radio altimeter ID-2163/A
count = start_command
sai_commands =
{
	SAI_test			= counter();
	SAI_pull			= counter();
	SAI_rotate			= counter();
	SAI_Power			= counter();
	SAI_Rotate_EXT		= counter();
	SAI_Power_EXT		= counter();
	SAI_CAGE_EXT		= counter();
}

count = start_command
SMS_commands =
{
	-- Master Arm Panel
	AA_MasterModeSw         = counter();
	AG_MasterModeSw         = counter();
	MasterArmSw				= counter();
	EmerJettSw				= counter();
	JettStationCntrBtn		= counter();
	JettStationLIBtn		= counter();
	JettStationLOBtn		= counter();
	JettStationRIBtn		= counter();
	JettStationROBtn		= counter();
	SelJettBtn				= counter();
	SelJettLvr				= counter();
	AuxRelSw				= counter();
	IRCoolingSw				= counter();
	-- input commands
	MasterArmSw_EXT			= counter();
	SelJettLvr_ITER			= counter();
	AuxRelSw_ITER			= counter();
	IRCoolingSw_ITER		= counter();
	JettStationCntrBtn_ITER	= counter();
	JettStationLIBtn_ITER	= counter();
	JettStationLOBtn_ITER	= counter();
	JettStationRIBtn_ITER	= counter();
	JettStationROBtn_ITER	= counter();
}

-- Multipurpose Display Group -----------
-- Head-Up Display
count = start_command
HUD_commands =
{
	HUD_SymbRejectSw			= counter();
	HUD_SymbBrightCtrl			= counter();
	HUD_SymbBrightSelKnob		= counter();
	HUD_BlackLevelCtrl			= counter();
	HUD_VideoCtrlSw				= counter();
	HUD_BalanceCtrl				= counter();
	HUD_AoA_IndexerCtrl			= counter();
	HUD_AltitudeSw				= counter();
	HUD_AttitudeSelSw			= counter();
	-- input commands
	HUD_SymbRejectSw_ITER		= counter();
	HUD_SymbBrightCtrl_ITER		= counter();
	HUD_SymbBrightCtrl_AXIS		= counter();
	HUD_SymbBrightSelKnob_ITER	= counter();
	HUD_BlackLevelCtrl_ITER		= counter();
	HUD_BlackLevelCtrl_AXIS		= counter();
	HUD_VideoCtrlSw_ITER		= counter();
	HUD_BalanceCtrl_ITER		= counter();
	HUD_BalanceCtrl_AXIS		= counter();
	HUD_AoA_IndexerCtrl_ITER	= counter();
	HUD_AoA_IndexerCtrl_AXIS	= counter();
	HUD_AltitudeSw_ITER			= counter();
	HUD_AttitudeSelSw_ITER		= counter();
}

-- Left/Right MDI
count = start_command
MDI_commands =
{
	MDI_off_night_day   = counter();
	MDI_brightness      = counter();
	MDI_contrast        = counter();
	MDI_Left_HDG_Positive = counter();
	MDI_Left_HDG_Negative = counter();
	MDI_Left_CRS_Positive = counter();
	MDI_Left_CRS_Negative = counter();
}
-- input commands
count = start_command + 40
MDI_commands["MDI_off_night_day_ITER"]	= counter()
MDI_commands["MDI_brightness_ITER"]		= counter()
MDI_commands["MDI_brightness_AXIS"]		= counter()
MDI_commands["MDI_contrast_ITER"]		= counter()
MDI_commands["MDI_contrast_AXIS"]		= counter()


-- AMPCD
count = start_command
AMPCD_commands =
{
	AMPCD_off_brightness = counter();
	AMPCD_nite_day_DAY   = counter();
	AMPCD_nite_day_NGT   = counter();
	AMPCD_symbology_UP   = counter();
	AMPCD_symbology_DOWN = counter();
	AMPCD_contrast_UP    = counter();
	AMPCD_contrast_DOWN  = counter();
	AMPCD_gain_UP    	 = counter();
	AMPCD_gain_DOWN  	 = counter();
}
-- input commands
count = start_command + 40
AMPCD_commands["AMPCD_off_brightness_ITER"]	= counter()
AMPCD_commands["AMPCD_off_brightness_AXIS"]	= counter()


-- MDI/AMPCD Pushbuttons
count = start_command + 10
-- Pushbuttons are numbered clockwise from the lowest button at the left side
for PB_num = 1, 20 do
	local PB_command = counter()
	MDI_commands["MDI_PB_"..PB_num] = PB_command
	AMPCD_commands["AMPCD_PB_"..PB_num] = PB_command
end

-- Integrated Fuel/Engine Indicator (IFEI)
count = start_command
IFEI_commands =
{
	IFEI_BTN_MODE			= counter();
	IFEI_BTN_QTY			= counter();
	IFEI_BTN_UP_ARROW		= counter();
	IFEI_BTN_DOWN_ARROW		= counter();
	IFEI_BTN_ZONE			= counter();
	IFEI_BTN_ET				= counter();
	IFEI_Brightness			= counter();
	-- input commands
	IFEI_Brightness_EXT		= counter();
	IFEI_Brightness_AXIS	= counter();
}

-- Clock
count = start_command
clock_commands =
{
	CLOCK_left_lev_up		= counter();
	CLOCK_left_lev_rotate	= counter();
	CLOCK_right_lev_down	= counter();
}

-- UFC
count = start_command
UFC_commands =
{
	FuncSwAP	= counter();
	FuncSwIFF	= counter();
	FuncSwTCN	= counter();
	FuncSwILS	= counter();
	FuncSwDL	= counter();
	FuncSwBCN	= counter();
	FuncSwOnOff	= counter();
	Comm1Fcn	= counter();
	Comm2Fcn	= counter();
	--
	OptSw1		= counter();
	OptSw2		= counter();
	OptSw3		= counter();
	OptSw4		= counter();
	OptSw5		= counter();
	--
	SwIP		= counter();
	SwADF		= counter();
	SwEMCON		= counter();
	--
	KbdSw0		= counter();
	KbdSw1		= counter();
	KbdSw2		= counter();
	KbdSw3		= counter();
	KbdSw4		= counter();
	KbdSw5		= counter();
	KbdSw6		= counter();
	KbdSw7		= counter();
	KbdSw8		= counter();
	KbdSw9		= counter();
	KbdSwCLR	= counter();
	KbdSwENT	= counter();
	--
	Comm1Vol	= counter();
	Comm2Vol	= counter();
	BrtDim		= counter();
	Comm1Ch		= counter();
	Comm2Ch		= counter();
	--

	-- input commands
	SwADF_EXT		= counter();
	Comm1Vol_ITER	= counter();
	Comm1Vol_AXIS	= counter();
	Comm2Vol_ITER	= counter();
	Comm2Vol_AXIS	= counter();
	BrtDim_ITER		= counter();
	BrtDim_AXIS		= counter();
}

-- Radar
count = start_command
RADAR_commands =
{
	RADAR_SwitchChange		= counter();
	RADAR_SwitchPull		= counter();
	-- input commands
	RADAR_SwitchChange_ITER	= counter();
	RADAR_SwitchPull_ITER	= counter();
}

-- INS
count = start_command
INS_commands =
{
	INS_SwitchChange		= counter();
	-- input commands
	INS_SwitchChange_ITER	= counter();
}

-- intercom
count = start_command
intercom_commands =
{
	CommSw					= counter();
	VOX_Volume				= counter();
	ICS_Volume				= counter();
	RWR_Volume				= counter();
	WPN_Volume				= counter();
	MIDS_A_Volume			= counter();
	MIDS_B_Volume			= counter();
	TCN_Volume				= counter();
	AUX_Volume				= counter();
	COMM_RLY_Sw				= counter();
	G_XMT_Sw				= counter();
	IFF_MasterSw			= counter();
	IFF_Mode4Sw				= counter();
	IFF_CryptoSw_Zero		= counter();
	IFF_CryptoSw_Hold		= counter();
	ILS_UFC_MAN_Sw			= counter();
	ILS_ChannelSelector		= counter();
	WarnToneSilBtn			= counter();

	-- input commands
	VOX_Volume_EXT			= counter();
	VOX_Volume_AXIS			= counter();
	ICS_Volume_EXT			= counter();
	ICS_Volume_AXIS			= counter();
	RWR_Volume_EXT			= counter();
	RWR_Volume_AXIS			= counter();
	WPN_Volume_EXT			= counter();
	WPN_Volume_AXIS			= counter();
	MIDS_A_Volume_EXT		= counter();
	MIDS_A_Volume_AXIS		= counter();
	MIDS_B_Volume_EXT		= counter();
	MIDS_B_Volume_AXIS		= counter();
	TCN_Volume_EXT			= counter();
	TCN_Volume_AXIS			= counter();
	AUX_Volume_EXT			= counter();
	AUX_Volume_AXIS			= counter();
	COMM_RLY_Sw_EXT			= counter();
	G_XMT_Sw_EXT			= counter();
	IFF_MasterSw_EXT		= counter();
	IFF_Mode4Sw_EXT			= counter();
	ILS_UFC_MAN_Sw_EXT		= counter();
	ILS_ChannelSelector_EXT	= counter();

	--
	MsgHornetBall_EXT		= counter();
}

-- KY-58
count = start_command
ky58_commands =
{
	KY58_ModeSw				= counter();
	KY58_FillSw				= counter();
	KY58_FillSw_Pull		= counter();
	KY58_PowerSw			= counter();
	KY58_Volume				= counter();

	-- input commands
	KY58_ModeSw_ITER		= counter();
	KY58_FillSw_ITER		= counter();
	KY58_PowerSw_ITER		= counter();
	KY58_Volume_EXT			= counter();
	KY58_Volume_AXIS		= counter();
}

-- antenna selector
count = start_command
antsel_commands =
{
	Comm1AntSelSw			= counter();
	AntSelIFFSw				= counter();

	-- input commands
	Comm1AntSelSw_EXT		= counter();
	AntSelIFFSw_EXT			= counter();
}

-- RWR
count = start_command
rwr_commands =
{
	Power			= counter();
	Display			= counter();
	Special			= counter();
	Offset			= counter();
	Bit				= counter();
	DmrControl		= counter();
	DisType			= counter();
	IntControl		= counter();
	-- input commands
	DmrControl_ITER		= counter();
	DmrControl_AXIS		= counter();
	DisType_ITER		= counter();
	IntControl_ITER		= counter();
	IntControl_AXIS		= counter();
	Power_EXT			= counter();
}

-- CMDS
count = start_command
cmds_commands =
{
	Dispenser			= counter();
	EcmDisp				= counter();
	EcmJett				= counter();
	-- input commands
	Dispenser_EXT		= counter();
	EcmJett_EXT			= counter();
}

-- ASPJ
count = start_command
ASPJ_commands =
{
	ASPJ_SwitchChange		= counter();
	-- input commands
	ASPJ_SwitchChange_ITER	= counter();
}

-- Targeting Pod
count = start_command
tgp_commands =
{
	Flir				= counter();
	LtdrArm				= counter();
	Lst					= counter();
	-- input commands
	Flir_ITER			= counter();
	LtdrArm_EXT			= counter();
	LtdrArm_ITER		= counter();
	Lst_ITER			= counter();
}

-- HMD
count = start_command
hmd_commands =
{
	BrtKnob				= counter();
	-- input commands
	BrtKnob_ITER		= counter();
	BrtKnob_AXIS		= counter();
	AutoStartAlignment	= counter();
}
