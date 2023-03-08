-- Commands : not intended for end-user editing
Keys =
{
	iCommandPlaneWheelBrakeOn		= 74,
	iCommandPlaneWheelBrakeOff		= 75,
	
	iCommandPlaneThrustCommon		= 2004,

}

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

count = start_command
control_commands =
{
	DigitalBackup				= counter();
	AltFlaps					= counter();
	BitSw						= counter();
	FlcsReset					= counter();
	LeFlaps						= counter();
	TrimApDisc					= counter();
	RollTrim					= counter();
	PitchTrim					= counter();
	YawTrim						= counter();
	ManualPitchOverride			= counter();
	StoresConfig				= counter();
	ApPitchAtt					= counter();
	ApPitchAlt					= counter();
	ApRoll						= counter();
	AdvMode						= counter();
	ManualTfFlyup				= counter();
	ThrottleFriction			= counter();
	AB_DETENT					= counter();
	-- input commands
	DigitalBackup_ITER			= counter();
	AltFlaps_ITER				= counter();
	LeFlaps_ITER				= counter();
	TrimApDisc_ITER				= counter();
	RollTrim_ITER				= counter();
	RollTrim_AXIS				= counter();
	PitchTrim_ITER				= counter();
	PitchTrim_AXIS				= counter();
	YawTrim_ITER				= counter();
	YawTrim_AXIS				= counter();
	ManualPitchOverride_ITER	= counter();
	StoresConfig_ITER			= counter();
	ApPitchAtt_EXT				= counter();
	ApPitchAlt_EXT				= counter();
	ApRoll_ITER					= counter();
	AdvMode_ITER				= counter();
	ManualTfFlyup_ITER			= counter();
	ThrottleFriction_ITER		= counter();
}

-- Electric Interface
count = start_command
elec_commands =
{
	MainPwrSw				= counter();
	CautionResetBtn			= counter();
	FlcsPwrTestSwMAINT		= counter();
	FlcsPwrTestSwTEST		= counter();
	EPU_GEN_TestSw			= counter();
	ProbeHeatSw				= counter();
	ProbeHeatSwTEST			= counter();
	-- input commands
	MainPwrSw_ITER			= counter();
	FlcsPwrTestSw_ITER		= counter();
	EPU_GEN_TestSw_ITER		= counter();
	ProbeHeatSw_EXT			= counter();
	ProbeHeatSw_ITER		= counter();
}

count = start_command
fuel_commands =
{
	FuelMasterSw			= counter();
	FuelMasterSwCvr			= counter();
	ExtFuelTransferSw		= counter();
	EngineFeedSw			= counter();
	FuelQtySelSw			= counter();
	FuelQtySelSwTEST		= counter();
	TankInertingSw			= counter();
	AirRefuelSw				= counter();
	--input commands
	FuelMasterSw_ITER		= counter();
	FuelMasterSwCvr_ITER	= counter();
	ExtFuelTransferSw_ITER	= counter();
	EngineFeedSw_ITER		= counter();
	FuelQtySelSw_ITER		= counter();
	TankInertingSw_ITER		= counter();
	AirRefuelSw_ITER		= counter();
}

count = start_command
engine_commands =
{
	EpuSwCvrOn			= counter();
	EpuSwCvrOff			= counter();
	EpuSw				= counter();
	EngAntiIceSw		= counter();
	JfsSwStart1			= counter();
	JfsSwStart2			= counter();
	EngContSwCvr		= counter();
	EngContSw			= counter();
	MaxPowerSw			= counter();
	ABResetSwReset		= counter();
	ABResetSwEngData	= counter();
	FireOheatTestBtn	= counter();
	-- input commands
	EpuSwCvrOn_ITER		= counter();
	EpuSwCvrOff_ITER	= counter();
	EpuSw_ITER			= counter();
	EngAntiIceSw_ITER	= counter();
	EngContSwCvr_ITER	= counter();
	EngContSw_ITER		= counter();
	MaxPowerSw_ITER		= counter();
}

count = start_command
gear_commands =
{
	LGHandle				= counter();
	DownLockRelBtn			= counter();
	ParkingSw				= counter();
	AntiSkidSw				= counter();
	BrakesChannelSw			= counter();
	HookSw					= counter();
	HornSilencerBtn			= counter();
	AltGearHandle			= counter();
	AltGearResetBtn			= counter();
	-- input commands
	AntiSkidSw_EXT			= counter();
	BrakesChannelSw_ITER	= counter();
	HookSw_ITER				= counter();
	AltGearHandle_ITER		= counter();
}

count = start_command
oxygen_commands =
{
	SupplyLever				= counter();
	DiluterLever			= counter();
	EmergencyLever			= counter();
	EmergencyLeverTestMask	= counter();
	ObogsBitSw				= counter();
	-- input commands
	SupplyLever_ITER		= counter();
	DiluterLever_ITER		= counter();
	EmergencyLever_ITER		= counter();
}

count = start_command
cpt_commands =
{
	CanopyHandcrank						= counter();
	CanopySwitchOpen					= counter();
	CanopySwitchClose					= counter();
	CanopyHandle						= counter();
	CanopyTHandle						= counter();
	EjectionHandle						= counter();
	ShoulderHarnessKnob					= counter();
	EmergencyOxygenGreenRing			= counter();
	EjectionSafetyLever					= counter();
	RadioBeaconSwitch					= counter();
	SurvivalKitDeploymentSwitch			= counter();
	EmergencyManualChuteHandle			= counter();
	SeatAdjSwitchUp						= counter();
	SeatAdjSwitchDown					= counter();
	StickHide							= counter();
	-- input commands
	CanopyHandcrank_ITER				= counter();
	CanopySwitch_ITER					= counter();
	CanopyHandle_ITER					= counter();
	CanopyTHandle_ITER					= counter();
	ShoulderHarnessKnob_ITER			= counter();
	EjectionSafetyLever_ITER			= counter();
	RadioBeaconSwitch_ITER				= counter();
	SurvivalKitDeploymentSwitch_ITER	= counter();
	StickHide_EXT						= counter();
	
	SmokeDevice							= counter();
}

count = start_command
extlights_commands =
{
	AntiCollKn			= counter();
	PosFlash			= counter();
	PosWingTail			= counter();
	PosFus				= counter();
	FormKn				= counter();
	Master				= counter();
	AerialRefuel		= counter();
	LandingTaxi			= counter();
	-- input commands
	AntiCollKn_ITER		= counter();
	PosFlash_ITER		= counter();
	PosWingTail_ITER	= counter();
	PosFus_ITER			= counter();
	FormKn_ITER			= counter();
	FormKn_AXIS			= counter();
	Master_ITER			= counter();
	AerialRefuel_ITER	= counter();
	AerialRefuel_AXIS	= counter();
	LandingTaxi_ITER	= counter();
}

count = start_command
cptlights_commands = 
{
	MasterCaution			= counter();
	MalIndLtsTest			= counter();
	Consoles				= counter();
	IntsPnl					= counter();
	DataEntryDisplay		= counter();
	ConsolesFlood			= counter();
	InstPnlFlood			= counter();
	MalIndLtsBrt			= counter();
	MalIndLtsDim			= counter();
	IndBrtAoA				= counter();
	IndBrtAR				= counter();
	--input commands
	Consoles_EXT			= counter();
	Consoles_AXIS			= counter();
	IntsPnl_EXT				= counter();
	IntsPnl_AXIS			= counter();
	DataEntryDisplay_EXT	= counter();
	DataEntryDisplay_AXIS	= counter();
	ConsolesFlood_EXT		= counter();
	ConsolesFlood_AXIS		= counter();
	InstPnlFlood_EXT		= counter();
	InstPnlFlood_AXIS		= counter();
	UtilityBrt_ITER			= counter();
	UtilityBrt_AXIS			= counter();
	IndBrtAoA_ITER			= counter();
	IndBrtAoA_AXIS			= counter();
	IndBrtAR_ITER			= counter();
	IndBrtAR_AXIS			= counter();
}

count = start_command
hotas_commands =
{
	-- Stick
	STICK_NWS_AR_DISC_MSL_STEP		= counter();
	STICK_TRIMMER_UP				= counter();		-- Trimmer
	STICK_TRIMMER_DOWN				= counter();
	STICK_TRIMMER_LEFT				= counter();
	STICK_TRIMMER_RIGHT				= counter();
	STICK_DISP_MANAGE_UP			= counter();		-- Display Management Switch
	STICK_DISP_MANAGE_DOWN			= counter();
	STICK_DISP_MANAGE_LEFT			= counter();
	STICK_DISP_MANAGE_RIGHT			= counter();
	STICK_TGT_MANAGE_UP				= counter();		-- Target Management Switch
	STICK_TGT_MANAGE_DOWN			= counter();
	STICK_TGT_MANAGE_LEFT			= counter();
	STICK_TGT_MANAGE_RIGHT			= counter();
	STICK_CMS_MANAGE_FWD			= counter();		-- Countermeasures Management Switch
	STICK_CMS_MANAGE_AFT			= counter();
	STICK_CMS_MANAGE_LEFT			= counter();
	STICK_CMS_MANAGE_RIGHT			= counter();
	STICK_EXPAND_FOV				= counter();
	STICK_PADDLE					= counter();
	STICK_TRIGGER_1ST_DETENT		= counter();
	STICK_TRIGGER_2ND_DETENT		= counter();
	STICK_WEAPON_RELEASE			= counter();
	-- Throttle
	THROTTLE_CUTOFF_RELEASE			= counter();
	THROTTLE_TRANSMIT_FWD			= counter();		-- Transmit Switch
	THROTTLE_TRANSMIT_AFT			= counter();
	THROTTLE_TRANSMIT_LEFT			= counter();
	THROTTLE_TRANSMIT_RIGHT			= counter();
	THROTTLE_MAN_RNG				= counter();
	THROTTLE_UNCAGE					= counter();
	THROTTLE_DOG_FIGHT				= counter();
	THROTTLE_SPEED_BRAKE			= counter();
	THROTTLE_ANT_ELEV_AXIS			= counter();
	THROTTLE_ANT_ELEV_UP			= counter();
	THROTTLE_ANT_ELEV_DOWN			= counter();
	THROTTLE_RDR_CURSOR_FWD			= counter();		-- Radar Cursor Switch
	THROTTLE_RDR_CURSOR_AFT			= counter();
	THROTTLE_RDR_CURSOR_LEFT		= counter();
	THROTTLE_RDR_CURSOR_RIGHT		= counter();
	THROTTLE_ENABLE					= counter();
	-- input commands
--	THROTTLE_MAN_RNG_ITER			= counter();
--	THROTTLE_MAN_RNG_AXIS			= counter();
	THROTTLE_MAN_RNG_INC			= counter();
	THROTTLE_MAN_RNG_DEC			= counter();
	THROTTLE_DOG_FIGHT_ITER			= counter();
	THROTTLE_DOG_FIGHT_CYCL			= counter();
	THROTTLE_DOG_FIGHT_EXT			= counter();
	THROTTLE_SPEEDSPEED_BRAKE_EXT	= counter();
	THROTTLE_RDR_CURSOR_Y_AXIS		= counter();
	THROTTLE_RDR_CURSOR_X_AXIS		= counter();

	THROTTLE_TRANSMIT_FWD_VOIP		= counter();
	THROTTLE_TRANSMIT_AFT_VOIP		= counter();
}

count = start_command
ecs_commands =
{
	AirSourceKnob		= counter();
	TempKnob			= counter();
	DefogLever			= counter();
	-- input commands
	AirSourceKnob_ITER	= counter();
	TempKnob_ITER		= counter();
	TempKnob_AXIS		= counter();
	DefogLever_ITER		= counter();
	DefogLever_AXIS		= counter();
}

-- Upfront Controls (UFC) with Integrated Control Panel (ICP)
count = start_command
ufc_commands =
{
	UFC_Sw					= counter();

	DIG0_M_SEL				= counter();
	DIG1_T_ILS				= counter();
	DIG2_ALOW				= counter();
	DIG3					= counter();
	DIG4_STPT				= counter();
	DIG5_CRUS				= counter();
	DIG6_TIME				= counter();
	DIG7_MARK				= counter();
	DIG8_FIX				= counter();
	DIG9_A_CAL				= counter();

	COM1					= counter();
	COM2					= counter();
	IFF						= counter();
	LIST					= counter();

	ENTR					= counter();
	RCL						= counter();
	AA						= counter();
	AG						= counter();

	RET_DEPR_Knob			= counter();
	CONT_Knob				= counter();
	SYM_Knob				= counter();
	BRT_Knob				= counter();

	Wx						= counter();
	FLIR_INC				= counter();
	FLIR_DEC				= counter();
	FLIR_GAIN_Sw			= counter();

	DRIFT_CUTOUT			= counter();
	WARN_RESET				= counter();

	DED_INC					= counter();
	DED_DEC					= counter();
	DCS_RTN					= counter();
	DCS_SEQ					= counter();
	DCS_UP					= counter();
	DCS_DOWN				= counter();

	F_ACK					= counter();
	IFF_IDENT				= counter();
	RF_Sw					= counter();

	-- input commands
	UFC_Sw_ITER				= counter();

	SYM_Knob_ITER			= counter();
	SYM_Knob_AXIS			= counter();
	RET_DEPR_Knob_ITER		= counter();
	RET_DEPR_Knob_AXIS		= counter();
	BRT_Knob_ITER			= counter();
	BRT_Knob_AXIS			= counter();
	CONT_Knob_ITER			= counter();
	CONT_Knob_AXIS			= counter();
	FLIR_GAIN_Sw_ITER		= counter();
	DriftCO_WarnReset_ITER	= counter();
	RF_Sw_ITER				= counter();
}

-- Computers
count = start_command
mmc_commands = 
{
	MmcPwr				= counter();
	MasterArmSw			= counter();
	EmerStoresJett		= counter();
	GroundJett			= counter();
	AltRel				= counter();
	VvVah 				= counter();
	AttFpm				= counter();
	DedData				= counter();
	DeprRet				= counter();
	Spd					= counter();
	Alt					= counter();
	Brt					= counter();
	Test				= counter();
	MFD					= counter();
	-- input commands
	MmcPwr_ITER			= counter();
	MasterArmSw_ITER	= counter();
	MasterArmSw_EXT		= counter();
	GroundJett_ITER		= counter();
	VvVah_EXT			= counter();
	AttFpm_EXT			= counter();
	DedData_EXT			= counter();
	DeprRet_EXT			= counter();
	Spd_EXT				= counter();
	Alt_EXT				= counter();
	Brt_EXT				= counter();
	Test_EXT			= counter();
	MFD_ITER			= counter();
}

count = start_command
fcr_commands =
{
	PwrSw			= counter();
	-- input commands
	PwrSw_ITER		= counter();
}

count = start_command
ralt_commands =
{
	PwrSw			= counter();
	-- input commands
	PwrSw_ITER		= counter();
}

count = start_command
sms_commands = 
{
	StStaSw			= counter();
	LeftHDPT		= counter();
	RightHDPT		= counter();
	LaserSw			= counter();
	-- input commands
	StSta_ITER		= counter();
	LeftHDPT_ITER	= counter();
	RightHDPT_ITER	= counter();
	LaserSw_ITER	= counter();
	--
	ChangeLaserCode100	= counter();
	ChangeLaserCode10	= counter();
	ChangeLaserCode1	= counter();
}

-- Displays

-- HMCS
count = start_command
hmcs_commands =
{
	IntKnob				= counter();
	-- input commands
	IntKnob_ITER		= counter();
	IntKnob_AXIS		= counter();
}
-- Sensors ------------------------------
-- EWS ----------------------------------
-- RWR
count = start_command
rwr_commands =
{
	IntKnob			= counter();		-- Prime panel
	Handoff			= counter();
	Launch			= counter();
	Mode			= counter();
	UnknownShip		= counter();
	SysTest			= counter();
	TgtSep			= counter();
	BrtKnob			= counter();		-- Auxiliary panel
	Search			= counter();
	ActPwr			= counter();
	Power			= counter();
	Altitude		= counter();
	-- input commands
	IntKnob_ITER	= counter();
	IntKnob_AXIS	= counter();
	BrtKnob_ITER	= counter();
	BrtKnob_AXIS	= counter();
	Power_ITER		= counter();
}

-- CMDS
count = start_command
cmds_commands =
{
	RwrSrc			= counter();
	JmrSrc			= counter();
	MwsSrc			= counter();
	Jett			= counter();
	O1Exp			= counter();
	O2Exp			= counter();
	ChExp			= counter();
	FlExp			= counter();
	Prgm			= counter();
	Mode			= counter();
	DispBtn			= counter();
	-- input commands
	RwrSrc_ITER		= counter();
	JmrSrc_ITER		= counter();
	MwsSrc_ITER		= counter();
	Jett_ITER		= counter();
	O1Exp_ITER		= counter();
	O2Exp_ITER		= counter();
	ChExp_ITER		= counter();
	FlExp_ITER		= counter();
	Prgm_ITER		= counter();
	Mode_ITER		= counter();
}

-- SAI
count = start_command
sai_commands =
{
	test			= counter();
	cage			= counter();
	reference		= counter();
	power			= counter();
	-- input commands
	reference_EXT	= counter();
	power_EXT		= counter();
	cage_EXT		= counter();
	reference_AXIS	= counter();
}

-- Intercom Panels
count = start_command
intercom_commands =
{
	COM1_PowerKnob			= counter();
	COM1_ModeKnob			= counter();
	COM2_PowerKnob			= counter();
	COM2_ModeKnob			= counter();
	SecureVoiceKnob			= counter();
	MSL_ToneKnob			= counter();
	TF_ToneKnob				= counter();
	THREAT_ToneKnob			= counter();
	ILS_PowerKnob			= counter();
	TACAN_Knob				= counter();
	INTERCOM_Knob			= counter();
	HotMicCipherSw			= counter();
	IFF_AntSelSw			= counter();
	UHF_AntSelSw			= counter();
	VMS_InhibitSw			= counter();
	PlainCipherSw			= counter();
	ZeroizeSwCvr			= counter();
	ZeroizeSw				= counter();
	--
	COM1_PowerKnob_ITER		= counter();
	COM1_PowerKnob_AXIS		= counter();
	COM1_ModeKnob_ITER		= counter();
	COM2_PowerKnob_ITER		= counter();
	COM2_PowerKnob_AXIS		= counter();
	COM2_ModeKnob_ITER		= counter();
	SecureVoiceKnob_ITER	= counter();
	SecureVoiceKnob_AXIS	= counter();
	MSL_ToneKnob_ITER		= counter();
	MSL_ToneKnob_AXIS		= counter();
	TF_ToneKnob_ITER		= counter();
	TF_ToneKnob_AXIS		= counter();
	THREAT_ToneKnob_ITER	= counter();
	THREAT_ToneKnob_AXIS	= counter();
	ILS_PowerKnob_ITER		= counter();
	ILS_PowerKnob_AXIS		= counter();
	TACAN_Knob_ITER			= counter();
	TACAN_Knob_AXIS			= counter();
	INTERCOM_Knob_ITER		= counter();
	INTERCOM_Knob_AXIS		= counter();
	HotMicCipherSw_ITER		= counter();
	IFF_AntSelSw_ITER		= counter();
	UHF_AntSelSw_ITER		= counter();
	VMS_InhibitSw_ITER		= counter();
	PlainCipherSw_ITER		= counter();
	ZeroizeSwCvr_ITER		= counter();
	ZeroizeSw_ITER			= counter();
}

-- UHF Control Panel
count = start_command
uhf_commands =
{
	ChannelKnob			= counter();
	FreqSelector100Mhz	= counter();
	FreqSelector10Mhz	= counter();
	FreqSelector1Mhz	= counter();
	FreqSelector01Mhz	= counter();
	FreqSelector0025Mhz	= counter();
	FreqModeKnob		= counter();
	FunctionKnob		= counter();
	TToneSw				= counter();
	SquelchSw			= counter();
	VolumeKnob			= counter();
	TestDisplayBtn		= counter();
	StatusBtn			= counter();
	AccessDoor			= counter();
	LoadBtn				= counter();
	ZeroSw				= counter();
	MnSq				= counter();
	GdSq				= counter();
	--
	FunctionKnob_ITER			= counter();
	FreqModeKnob_ITER			= counter();
	TToneSw_ITER				= counter();
	SquelchSw_ITER				= counter();
	VolumeKnob_ITER				= counter();
	VolumeKnob_AXIS				= counter();
	AccessDoor_ITER				= counter();
	ZeroSw_ITER					= counter();
	FreqSelector100Mhz_ITER		= counter();
}

-- IFF Control Panel
count = start_command
iff_commands =
{
	CNI_Knob 			= counter();
	MasterKnob			= counter();
	M4CodeSw			= counter();
	M4ReplySw			= counter();
	M4MonitorSw			= counter();
	EnableSw			= counter();
	M1M3Selector1_Inc	= counter();
	M1M3Selector1_Dec	= counter();
	M1M3Selector2_Inc	= counter();
	M1M3Selector2_Dec	= counter();
	M1M3Selector3_Inc	= counter();
	M1M3Selector3_Dec	= counter();
	M1M3Selector4_Inc	= counter();
	M1M3Selector4_Dec	= counter();

	-- input commands
	CNI_Knob_ITER		= counter();
	MasterKnob_ITER		= counter();
	M4CodeSw_ITER		= counter();
	M4ReplySw_ITER		= counter();
	M4MonitorSw_ITER	= counter();
	EnableSw_ITER		= counter();
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
	KY58_Volume_ITER		= counter();
	KY58_Volume_AXIS		= counter();
}

-- MFD buttons
count = start_command
mfd_commands = {}
for i = 1, 20 do
	mfd_commands["OSB_" .. i] 		= counter();	-- OSB - option select button
end
mfd_commands["GAIN_Rocker_UP"] 		= counter();
mfd_commands["GAIN_Rocker_DOWN"] 	= counter();
mfd_commands["SYM_Rocker_UP"] 		= counter();
mfd_commands["SYM_Rocker_DOWN"] 	= counter();
mfd_commands["CON_Rocker_UP"] 		= counter();
mfd_commands["CON_Rocker_DOWN"] 	= counter();
mfd_commands["BRT_Rocker_UP"] 		= counter();
mfd_commands["BRT_Rocker_DOWN"] 	= counter();
-- TODO other MFD buttons


--
count = start_command
ami_commands =
{
	SettingKnob		= counter();
}

count = start_command
ehsi_commands =
{
	ModeBtn			= counter();
	LeftKnob		= counter();
	LeftKnobBtn		= counter();
	RightKnob		= counter();
	RightKnobBtn	= counter();
}

-- Clock
count = start_command
clock_commands =
{
	CLOCK_left_lev_up		= counter();
	CLOCK_left_lev_rotate	= counter();
	CLOCK_right_lev_down	= counter();
}

-- Altimeter
count = start_command
alt_commands =
{
	PNEU		= counter();
	ELEC		= counter();
	ZERO		= counter();
}

-- MIDS
count = start_command
mids_commands =
{
	PwrSw		= counter();
	--
	PwrSw_ITER	= counter();
}

-- INS
count = start_command
ins_commands =
{
	ModeKnob		= counter();
	--
	ModeKnob_ITER	= counter();
}

-- GPS
count = start_command
gps_commands =
{
	PwrSw		= counter();
	--
	PwrSw_ITER	= counter();
}

-- IDM
count = start_command
idm_commands =
{
	PwrSw		= counter();
	--
	PwrSw_ITER	= counter();
}

-- MAP
count = start_command
map_commands =
{
	PwrSw		= counter();
	--
	PwrSw_ITER	= counter();
}

-- ECM
count = start_command
ecm_commands =
{
	PwrSw		= counter();
	XmitSw		= counter();
	DimRotary	= counter();
	ResetBtn	= counter();
	BitBtn		= counter();
	OneBtn		= counter();
	TwoBtn		= counter();
	ThreeBtn	= counter();
	FourBtn		= counter();
	FiveBtn		= counter();
	SixBtn		= counter();
	FrmBtn		= counter();
	SplBtn		= counter();
	-- input
	PwrSw_ITER		= counter();
	XmitSw_ITER		= counter();
	DimRotary_ITER	= counter();
	DimRotary_AXIS	= counter();
	OneBtn_ITER		= counter();
	TwoBtn_ITER		= counter();
	ThreeBtn_ITER	= counter();
	FourBtn_ITER	= counter();
	FiveBtn_ITER	= counter();
	SixBtn_ITER		= counter();
	FrmBtn_ITER		= counter();
	SplBtn_ITER		= counter();
}