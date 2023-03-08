dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."devices.lua")

-- timeouts and delays
std_message_timeout = 15

local	t_start	= 0.0
local	t_stop	= 0.0
local	dt		= 0.2
local	dt_mto	= 0.5
local	start_sequence_time	= 210.0
local	stop_sequence_time	= 60.0

--
start_sequence_full 	  = {}
stop_sequence_full		  = {}
cockpit_illumination_full = {}

function push_command(sequence, run_t, command)
	sequence[#sequence + 1] =  command
	sequence[#sequence]["time"] = run_t
end

function push_start_command(delta_t, command)
	t_start = t_start + delta_t
	push_command(start_sequence_full,t_start, command)
end

function push_stop_command(delta_t, command)
	t_stop = t_stop + delta_t
	push_command(stop_sequence_full,t_stop, command)
end

--
local count = 0
local function counter()
	count = count + 1
	return count
end

-- conditions
count = -1

F16_AD_NO_FAILURE				= counter()
F16_AD_ERROR					= counter()

F16_AD_THROTTLE_SET_TO_OFF		= counter()
F16_AD_THROTTLE_AT_OFF			= counter()
F16_AD_THROTTLE_SET_TO_IDLE		= counter()
F16_AD_THROTTLE_AT_IDLE			= counter()
F16_AD_THROTTLE_DOWN_TO_IDLE	= counter()

F16_AD_JFS_READY				= counter()
F16_AD_ENG_IDLE_RPM				= counter()
F16_AD_ENG_CHECK_IDLE			= counter()
F16_AD_JFS_VERIFY_OFF			= counter()

F16_AD_INS_CHECK_RDY			= counter()

F16_AD_LEFT_HDPT_CHECK_RDY		= counter()
F16_AD_RIGHT_HDPT_CHECK_RDY 	= counter()

F16_AD_HMCS_ALIGN				= counter()


--
alert_messages = {}

alert_messages[F16_AD_ERROR]					= { message = _("FM MODEL ERROR"),							message_timeout = std_message_timeout}

alert_messages[F16_AD_THROTTLE_SET_TO_OFF]		= { message = _("THROTTLE - TO OFF"),						message_timeout = std_message_timeout}
alert_messages[F16_AD_THROTTLE_AT_OFF]			= { message = _("THROTTLE MUST BE AT OFF"),					message_timeout = std_message_timeout}
alert_messages[F16_AD_THROTTLE_SET_TO_IDLE]		= { message = _("THROTTLE - TO IDLE"),						message_timeout = std_message_timeout}
alert_messages[F16_AD_THROTTLE_AT_IDLE]			= { message = _("THROTTLE MUST BE AT IDLE"),				message_timeout = std_message_timeout}
alert_messages[F16_AD_THROTTLE_DOWN_TO_IDLE]	= { message = _("THROTTLE - TO IDLE"),						message_timeout = std_message_timeout}

alert_messages[F16_AD_JFS_READY]				= { message = _("JFS RUN LIGHT MUST BE ON WITHIN 30 SEC"),	message_timeout = std_message_timeout}
alert_messages[F16_AD_ENG_IDLE_RPM]				= { message = _("ENGINE RPM FAILURE"),						message_timeout = std_message_timeout}
alert_messages[F16_AD_ENG_CHECK_IDLE]			= { message = _("ENGINE PARAMETERS FAILURE"),				message_timeout = std_message_timeout}
alert_messages[F16_AD_JFS_VERIFY_OFF]			= { message = _("JFS MUST BE OFF"),							message_timeout = std_message_timeout}

alert_messages[F16_AD_INS_CHECK_RDY]			= { message = _("INS NOT READY"),							message_timeout = std_message_timeout}

alert_messages[F16_AD_LEFT_HDPT_CHECK_RDY]		= { message = "",											message_timeout = std_message_timeout}
alert_messages[F16_AD_RIGHT_HDPT_CHECK_RDY]		= { message = "",											message_timeout = std_message_timeout}


----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
-- Start sequence
push_start_command(2.0,	{message = _("AUTOSTART SEQUENCE IS RUNNING"), message_timeout = start_sequence_time})
--

-- Before Entering Cockpit
push_start_command(dt,		{message = _("- EJECTION SAFETY LEVER - SAFE (UP)"),									message_timeout = dt_mto})
push_start_command(dt,		{device = devices.CPT_MECH,				action = cpt_commands.EjectionSafetyLever,		value = 0.0})
push_start_command(dt,		{message = _("- CANOPY JETTISON T-HANDLE - SECURE"),									message_timeout = dt_mto})
push_start_command(dt,		{device = devices.CPT_MECH,				action = cpt_commands.CanopyTHandle,			value = 0.0})
push_start_command(dt,		{message = _("- MAIN PWR SWITCH - OFF"),												message_timeout = dt_mto})
push_start_command(dt,		{device = devices.ELEC_INTERFACE,		action = elec_commands.MainPwrSw,				value = -1.0})
push_start_command(dt,		{message = _("- SPD BRK SWITCH - CENTER"),												message_timeout = dt_mto})
push_start_command(dt,		{device = devices.HOTAS,				action = hotas_commands.THROTTLE_SPEED_BRAKE,	value = 0.0})
push_start_command(dt,		{message = _("- FUEL MASTER SWITCH - MASTER (GUARD DOWN)"),								message_timeout = dt_mto})
push_start_command(dt,		{device = devices.FUEL_INTERFACE,		action = fuel_commands.FuelMasterSwCvr,			value = 1.0})
push_start_command(dt,		{device = devices.FUEL_INTERFACE,		action = fuel_commands.FuelMasterSw,			value = 0.0})
push_start_command(dt,		{device = devices.FUEL_INTERFACE,		action = fuel_commands.FuelMasterSwCvr,			value = 0.0})
push_start_command(dt,		{message = _("- ENG CONT SWITCH - PRI (GUARD DOWN)"),									message_timeout = dt_mto})
push_start_command(dt,		{device = devices.ENGINE_INTERFACE,		action = engine_commands.EngContSwCvr,			value = 1.0})
push_start_command(dt,		{device = devices.ENGINE_INTERFACE,		action = engine_commands.EngContSw,				value = 0.0})
push_start_command(dt,		{device = devices.ENGINE_INTERFACE,		action = engine_commands.EngContSwCvr,			value = 0.0})
push_start_command(dt,		{message = _("- COMM 1 MODE KNOB - SQL"),												message_timeout = dt_mto})
push_start_command(dt,		{device = devices.INTERCOM,				action = intercom_commands.COM1_ModeKnob,		value = 0.5})
push_start_command(dt,		{message = _("- COMM 2 MODE KNOB - SQL"),												message_timeout = dt_mto})
push_start_command(dt,		{device = devices.INTERCOM,				action = intercom_commands.COM2_ModeKnob,		value = 0.5})
-- All other knobs - CCW
push_start_command(dt,		{message = _("- ALT GEAR HANDLE - IN"),													message_timeout = dt_mto})
push_start_command(dt,		{device = devices.GEAR_INTERFACE,		action = gear_commands.AltGearHandle,			value = 0.0})
push_start_command(dt,		{message = _("- ALT FLAPS SWITCH - NORM"),												message_timeout = dt_mto})
push_start_command(dt,		{device = devices.CONTROL_INTERFACE,	action = control_commands.AltFlaps,				value = 0.0})
push_start_command(dt,		{message = _("- GND JETT ENABLE SWITCH - OFF"),											message_timeout = dt_mto})
push_start_command(dt,		{device = devices.MMC,					action = mmc_commands.GroundJett,				value = 0.0})
push_start_command(dt,		{message = _("- HOOK SWITCH - UP"),														message_timeout = dt_mto})
push_start_command(dt,		{device = devices.GEAR_INTERFACE,		action = gear_commands.HookSw,					value = 1.0})
-- ARMT CONSENT SWITCH - ARMT CONSENT (GUARD DOWN)
-- EJECTION MODE SEL HANDLE - SOLO
-- INTERIOR LIGHTING CONTROL PANEL - ALL KNOBS OFF
push_start_command(dt,		{message = _("- OXYGEN REGULATOR - ON AND NORM"),										message_timeout = dt_mto})
push_start_command(dt,		{device = devices.OXYGEN_INTERFACE,		action = oxygen_commands.SupplyLever,			value = 0.5})
push_start_command(dt,		{device = devices.OXYGEN_INTERFACE,		action = oxygen_commands.DiluterLever,			value = 0.0})
push_start_command(dt,		{device = devices.OXYGEN_INTERFACE,		action = oxygen_commands.EmergencyLever,		value = 0.0})
-- Interior Check
-- Left Console
push_start_command(dt,		{message = _("- PROBE HEAT SWITCH - OFF"),												message_timeout = dt_mto})
push_start_command(dt,		{device = devices.ELEC_INTERFACE,		action = elec_commands.ProbeHeatSw,				value = 0.0})
push_start_command(dt,		{message = _("- FLCS PWR TEST SWITCH - NORM"),											message_timeout = dt_mto})
push_start_command(dt,		{device = devices.ELEC_INTERFACE,		action = elec_commands.FlcsPwrTestSwMAINT,		value = 0.0})
push_start_command(dt,		{message = _("- DEFOG LEVER - MIDRANGE"),												message_timeout = dt_mto})
push_start_command(dt,		{device = devices.ECS_INTERFACE,		action = ecs_commands.DefogLever,				value = 0.5})
push_start_command(dt,		{message = _("- DIGITAL BACKUP SWITCH - OFF"),											message_timeout = dt_mto})
push_start_command(dt,		{device = devices.CONTROL_INTERFACE,	action = control_commands.DigitalBackup,		value = 0.0})
push_start_command(dt,		{message = _("- MANUAL TF FLY UP SWITCH - ENABLE"),										message_timeout = dt_mto})
push_start_command(dt,		{device = devices.CONTROL_INTERFACE,	action = control_commands.ManualTfFlyup,		value = 1.0})
push_start_command(dt,		{message = _("- LE FLAPS SWITCH - AUTO"),												message_timeout = dt_mto})
push_start_command(dt,		{device = devices.CONTROL_INTERFACE,	action = control_commands.LeFlaps,				value = 0.0})
push_start_command(dt,		{message = _("- BIT SWITCH - OFF"),														message_timeout = dt_mto})
push_start_command(dt,		{device = devices.CONTROL_INTERFACE,	action = control_commands.BitSw,				value = 0.0})
push_start_command(dt,		{message = _("- TRIM/AP DISC SWITCH - NORM"),											message_timeout = dt_mto})
push_start_command(dt,		{device = devices.CONTROL_INTERFACE,	action = control_commands.TrimApDisc,			value = 1.0})
push_start_command(dt,		{message = _("- ROLL, YAW, AND PITCH TRIM - CENTER"),									message_timeout = dt_mto})
push_start_command(dt,		{device = devices.CONTROL_INTERFACE,	action = control_commands.RollTrim,				value = 0.0})
push_start_command(dt,		{device = devices.CONTROL_INTERFACE,	action = control_commands.YawTrim,				value = 0.0})
push_start_command(dt,		{device = devices.CONTROL_INTERFACE,	action = control_commands.PitchTrim,			value = 0.0})
push_start_command(dt,		{message = _("- TANK INERTING SWITCH - OFF"),											message_timeout = dt_mto})
push_start_command(dt,		{device = devices.FUEL_INTERFACE,		action = fuel_commands.TankInertingSw,			value = 0.0})
push_start_command(dt,		{message = _("- ENG FEED KNOB - NORM"),													message_timeout = dt_mto})
push_start_command(dt,		{device = devices.FUEL_INTERFACE,		action = fuel_commands.EngineFeedSw,			value = 0.1})
push_start_command(dt,		{message = _("- AIR REFUEL SWITCH - CLOSE"),											message_timeout = dt_mto})
push_start_command(dt,		{device = devices.FUEL_INTERFACE,		action = fuel_commands.AirRefuelSw,				value = 0.0})
push_start_command(dt,		{message = _("- IFF MASTER KNOB - STBY"),												message_timeout = dt_mto})
push_start_command(dt,		{device = devices.IFF_CONTROL_PANEL,	action = iff_commands.MasterKnob,				value = 0.1})
push_start_command(dt,		{message = _("- C&I KNOB - BACKUP"),													message_timeout = dt_mto})
push_start_command(dt,		{device = devices.IFF_CONTROL_PANEL,	action = iff_commands.CNI_Knob,					value = 0.0})
push_start_command(dt,		{message = _("- MASTER LIGHT SWITCH - NORM"),											message_timeout = dt_mto})
push_start_command(dt,		{device = devices.EXTLIGHTS_SYSTEM,		action = extlights_commands.Master,				value = 0.4})
push_start_command(dt,		{message = _("- EPU SWITCH - NORM (GUARD DOWN)"),										message_timeout = dt_mto})
push_start_command(dt,		{device = devices.ENGINE_INTERFACE,		action = engine_commands.EpuSwCvrOn,			value = 1.0})
push_start_command(dt,		{device = devices.ENGINE_INTERFACE,		action = engine_commands.EpuSwCvrOff,			value = 1.0})
push_start_command(dt,		{device = devices.ENGINE_INTERFACE,		action = engine_commands.EpuSw,					value = 0.0})
push_start_command(dt,		{device = devices.ENGINE_INTERFACE,		action = engine_commands.EpuSwCvrOn,			value = 0.0})
push_start_command(dt,		{device = devices.ENGINE_INTERFACE,		action = engine_commands.EpuSwCvrOff,			value = 0.0})
-- AVTR POWER SWITCH - UNTHRD
-- ECM POWER - OFF
push_start_command(dt,		{message = _("- AB RESET SWITCH - NORM"),												message_timeout = dt_mto})
push_start_command(dt,		{device = devices.ENGINE_INTERFACE,		action = engine_commands.ABResetSwEngData,		value = 0.0})
push_start_command(dt,		{message = _("- JFS SWITCH - OFF"),														message_timeout = dt_mto})
push_start_command(dt,		{device = devices.ENGINE_INTERFACE,		action = engine_commands.JfsSwStart2,			value = 0.0})
push_start_command(dt,		{message = _("- UHF RADIO BACKUP CONTROL PANEL: FUNCTION KNOB - BOTH"),					message_timeout = dt_mto})
push_start_command(dt,		{device = devices.UHF_CONTROL_PANEL,	action = uhf_commands.FunctionKnob,				value = 0.2})

push_start_command(dt,		{message = _("- THROTTLE - OFF"),		check_condition = F16_AD_THROTTLE_DOWN_TO_IDLE,	message_timeout = dt_mto})
push_start_command(dt,		{										check_condition = F16_AD_THROTTLE_SET_TO_OFF,	message_timeout = dt_mto})
push_start_command(1.0,		{										check_condition = F16_AD_THROTTLE_AT_OFF,		message_timeout = dt_mto})

-- Left Auxiliary Console
push_start_command(dt,		{message = _("- CMDS SWITCHES - OFF"),													message_timeout = dt_mto})
push_start_command(dt,		{device = devices.CMDS,					action = cmds_commands.O1Exp,					value = 0.0})
push_start_command(dt,		{device = devices.CMDS,					action = cmds_commands.O2Exp,					value = 0.0})
push_start_command(dt,		{device = devices.CMDS,					action = cmds_commands.ChExp,					value = 0.0})
push_start_command(dt,		{device = devices.CMDS,					action = cmds_commands.FlExp,					value = 0.0})
push_start_command(dt,		{device = devices.CMDS,					action = cmds_commands.RwrSrc,					value = 0.0})
push_start_command(dt,		{device = devices.CMDS,					action = cmds_commands.JmrSrc,					value = 0.0})
push_start_command(dt,		{device = devices.CMDS,					action = cmds_commands.MwsSrc,					value = 0.0})
push_start_command(dt,		{device = devices.CMDS,					action = cmds_commands.Jett,					value = 0.0})
push_start_command(dt,		{message = _("- HMCS SYMBOLOGY INT POWER KNOB - OFF"),									message_timeout = dt_mto})
push_start_command(dt,		{device = devices.HMCS,					action = hmcs_commands.IntKnob,					value = 0.0})
push_start_command(dt,		{message = _("- LANDING TAXI LIGHTS SWITCH - OFF"),										message_timeout = dt_mto})
push_start_command(dt,		{device = devices.EXTLIGHTS_SYSTEM,		action = extlights_commands.LandingTaxi,		value = 0.0})
push_start_command(dt,		{message = _("- LG HANDLE - DN"),														message_timeout = dt_mto})
push_start_command(dt,		{device = devices.GEAR_INTERFACE,		action = gear_commands.LGHandle,				value = 0.0})
push_start_command(dt,		{message = _("- BRAKES CHANNEL SWITCH - CHAN 1"),										message_timeout = dt_mto})
push_start_command(dt,		{device = devices.GEAR_INTERFACE,		action = gear_commands.BrakesChannelSw,			value = 1.0})
push_start_command(dt,		{message = _("- ANTI-SKID SWITCH - ANTI-SKID"),											message_timeout = dt_mto})
push_start_command(dt,		{device = devices.GEAR_INTERFACE,		action = gear_commands.AntiSkidSw,				value = 0.0})
push_start_command(dt,		{message = _("- STORES CONFIG Switch, CAT III/CAT I"),									message_timeout = dt_mto})
push_start_command(dt,		{device = devices.CONTROL_INTERFACE,	action = control_commands.StoresConfig,			value = 1.0})
-- Instrument Panel
push_start_command(dt,		{message = _("- ROLL SWITCH - ATT HOLD"),												message_timeout = dt_mto})
push_start_command(dt,		{device = devices.CONTROL_INTERFACE,	action = control_commands.ApRoll,				value = 0.0})
push_start_command(dt,		{message = _("- PITCH SWITCH - A/P OFF"),												message_timeout = dt_mto})
push_start_command(dt,		{device = devices.CONTROL_INTERFACE,	action = control_commands.ApPitchAtt,			value = 0.0})
push_start_command(dt,		{message = _("- MASTER ARM SWITCH - OFF"),												message_timeout = dt_mto})
push_start_command(dt,		{device = devices.MMC,					action = mmc_commands.MasterArmSw,				value = 0.0})
push_start_command(dt,		{message = _("- LASER ARM SWITCH - OFF"),												message_timeout = dt_mto})
push_start_command(dt,		{device = devices.SMS,					action = sms_commands.LaserSw,					value = 0.0})
push_start_command(dt,		{message = _("- RF SWITCH - NORM"),														message_timeout = dt_mto})
push_start_command(dt,		{device = devices.UFC,					action = ufc_commands.RF_Sw,					value = 1.0})
push_start_command(dt,		{message = _("- FUEL QTY SEL KNOB - NORM"),												message_timeout = dt_mto})
push_start_command(dt,		{device = devices.FUEL_INTERFACE,		action = fuel_commands.FuelQtySelSw,			value = 0.1})
push_start_command(dt,		{message = _("- EXT FUEL TRANS SWITCH - NORM"),											message_timeout = dt_mto})
push_start_command(dt,		{device = devices.FUEL_INTERFACE,		action = fuel_commands.ExtFuelTransferSw,		value = 1.0})
-- Right Auxiliary Console
-- Right Console
push_start_command(dt,		{message = _("- SNSR PWR SWITCHES - OFF"),												message_timeout = dt_mto})
push_start_command(dt,		{device = devices.SMS,					action = sms_commands.LeftHDPT,					value = 0.0})
push_start_command(dt,		{device = devices.SMS,					action = sms_commands.RightHDPT,				value = 0.0})
push_start_command(dt,		{device = devices.FCR,					action = fcr_commands.PwrSw,					value = 0.0})
push_start_command(dt,		{device = devices.RALT,					action = ralt_commands.PwrSw,					value = -1.0})
-- NUCLEAR CONSENT SWITCH - OFF
push_start_command(dt,		{message = _("- PLAIN CIPHER SWITCH - PLAIN"),											message_timeout = dt_mto})
push_start_command(dt,		{device = devices.INTERCOM,				action = intercom_commands.PlainCipherSw,		value = 0.0})
push_start_command(dt,		{message = _("- ZEROIZE SWITCH - OFF"),													message_timeout = dt_mto})
push_start_command(dt,		{device = devices.INTERCOM,				action = intercom_commands.ZeroizeSwCvr,		value = 1.0})
push_start_command(dt,		{device = devices.INTERCOM,				action = intercom_commands.ZeroizeSw,			value = 0.0})
push_start_command(dt,		{device = devices.INTERCOM,				action = intercom_commands.ZeroizeSwCvr,		value = 0.0})
push_start_command(dt,		{message = _("- VOICE MESSAGE SWITCH - VOICE MESSAGE"),									message_timeout = dt_mto})
push_start_command(dt,		{device = devices.INTERCOM,				action = intercom_commands.VMS_InhibitSw,		value = 1.0})
push_start_command(dt,		{message = _("- TEMP KNOB - AUTO"),														message_timeout = dt_mto})
push_start_command(dt,		{device = devices.ECS_INTERFACE,		action = ecs_commands.TempKnob,					value = 0.2})
push_start_command(dt,		{message = _("- AIR SOURCE KNOB - NORM"),												message_timeout = dt_mto})
push_start_command(dt,		{device = devices.ECS_INTERFACE,		action = ecs_commands.AirSourceKnob,			value = 0.1})
-- SECURE VOICE POWER KNOB - OFF
push_start_command(dt,		{message = _("- AVIONICS POWER SWITCHES - OFF"),										message_timeout = dt_mto})
push_start_command(dt,		{device = devices.MMC,					action = ecs_commands.AirSourceKnob,			value = 0.0})
push_start_command(dt,		{device = devices.SMS,					action = sms_commands.StStaSw,					value = 0.0})
push_start_command(dt,		{device = devices.MMC,					action = mmc_commands.MFD,						value = 0.0})
push_start_command(dt,		{device = devices.UFC,					action = ufc_commands.UFC_Sw,					value = 0.0})
push_start_command(dt,		{device = devices.MAP,					action = map_commands.PwrSw,					value = 0.0})
push_start_command(dt,		{device = devices.GPS,					action = gps_commands.PwrSw,					value = 0.0})
push_start_command(dt,		{device = devices.IDM,					action = idm_commands.PwrSw,					value = 0.0})
push_start_command(dt,		{device = devices.INS,					action = ins_commands.ModeKnob,					value = 0.0})
push_start_command(dt,		{device = devices.MIDS,					action = mids_commands.PwrSw,					value = 0.1})
push_start_command(dt,		{message = _("- ANTI ICE SWITCH - AUTO"),												message_timeout = dt_mto})
push_start_command(dt,		{device = devices.ENGINE_INTERFACE,		action = engine_commands.EngAntiIceSw,			value = 0.0})
push_start_command(dt,		{message = _("- IFF ANT SEL SWITCH - NORM"),											message_timeout = dt_mto})
push_start_command(dt,		{device = devices.INTERCOM,				action = intercom_commands.IFF_AntSelSw,		value = 0.0})
push_start_command(dt,		{message = _("- UHF ANT SEL SWITCH - NORM"),											message_timeout = dt_mto})
push_start_command(dt,		{device = devices.INTERCOM,				action = intercom_commands.UHF_AntSelSw,		value = 0.0})
-- Before Starting Engine
push_start_command(dt,		{message = _("- SAI - CAGE"),															message_timeout = dt_mto})
push_start_command(dt,		{device = devices.SAI,					action = sai_commands.reference,				value = 0.5})
push_start_command(dt,		{device = devices.SAI,					action = sai_commands.cage,						value = 1.0})
push_start_command(dt,		{device = devices.SAI,					action = sai_commands.reference,				value = 0.625})
push_start_command(dt,		{device = devices.SAI,					action = sai_commands.cage,						value = 0.0})
push_start_command(dt,		{message = _("- MAIN PWR SWITCH - BATT"),												message_timeout = dt_mto})
push_start_command(dt,		{device = devices.ELEC_INTERFACE,		action = elec_commands.MainPwrSw,				value = 0.0})
push_start_command(dt,		{message = _("- FLCS PWR TEST SWITCH - TEST, CHECK, RELEASE"),							message_timeout = dt_mto})
push_start_command(1.0,		{device = devices.ELEC_INTERFACE,		action = elec_commands.FlcsPwrTestSwMAINT,		value = 1.0})
push_start_command(dt,		{device = devices.ELEC_INTERFACE,		action = elec_commands.FlcsPwrTestSwMAINT,		value = 0.0})
push_start_command(dt,		{message = _("- MAIN PWR SWITCH - MAIN PWR"),											message_timeout = dt_mto})
push_start_command(dt,		{device = devices.ELEC_INTERFACE,		action = elec_commands.MainPwrSw,				value = 1.0})
-- Starting Engine
push_start_command(dt,		{message = _("- JFS SWITCH - START 2"),													message_timeout = 17.0})
push_start_command(dt,		{device = devices.ENGINE_INTERFACE,		action = engine_commands.JfsSwStart2,			value = -1.0})
push_start_command(dt,		{device = devices.ENGINE_INTERFACE,		action = engine_commands.JfsSwStart2,			value = 0.0})

push_start_command(17.0,	{message = _("- JFS RUN LIGHT - CHECK"),				check_condition = F16_AD_JFS_READY,				message_timeout = dt_mto})
push_start_command(3.0,		{message = _("- THROTTLE - IDLE (20% RPM MINIMUM)"),													message_timeout = 35.0})
for i = 0, 15, 1 do
	push_start_command(1.0,		{													check_condition = F16_AD_THROTTLE_SET_TO_IDLE,	message_timeout = 0.0})
end
push_start_command(dt,		{														check_condition = F16_AD_THROTTLE_AT_IDLE,		message_timeout = dt_mto})
push_start_command(20.0,	{message = _("- JFS SWITCH - CONFIRM OFF"),				check_condition = F16_AD_JFS_VERIFY_OFF,		message_timeout = 5.0})
push_start_command(5.0,		{message = _("- ENGINE WARNING LIGHT - CONFIRM OFF"),	check_condition = F16_AD_ENG_IDLE_RPM,			message_timeout = 5.0})
push_start_command(5.0,		{message = _("- ENGINE AT IDLE - CHECK"),				check_condition = F16_AD_ENG_CHECK_IDLE,		message_timeout = dt_mto})

-- After Engine Start
-- FIRE & OHEAT DETECT BUTTON - TEST
push_start_command(dt,		{message = _("- MAL & IND LTS BUTTON - TEST"),											message_timeout = dt_mto})
push_start_command(dt,		{device = devices.CPTLIGHTS_SYSTEM,		action = cptlights_commands.MalIndLtsTest,		value = 1.0})
push_start_command(1.0,		{device = devices.CPTLIGHTS_SYSTEM,		action = cptlights_commands.MalIndLtsTest,		value = 0.0})
push_start_command(dt,		{message = _("- AVIONICS POWER PANEL - SET"),											message_timeout = 10.0})
push_start_command(dt,		{device = devices.MMC,					action = ecs_commands.AirSourceKnob,			value = 1.0})
push_start_command(dt,		{device = devices.SMS,					action = sms_commands.StStaSw,					value = 1.0})
push_start_command(dt,		{device = devices.MMC,					action = mmc_commands.MFD,						value = 1.0})
push_start_command(dt,		{device = devices.UFC,					action = ufc_commands.UFC_Sw,					value = 1.0})
-- push_start_command(dt,		{device = devices.MAP,					action = map_commands.PwrSw,					value = 1.0}) -- not used
push_start_command(dt,		{device = devices.GPS,					action = gps_commands.PwrSw,					value = 1.0})
push_start_command(dt,		{device = devices.IDM,					action = idm_commands.PwrSw,					value = 1.0})
push_start_command(10.0,	{device = devices.MIDS,					action = mids_commands.PwrSw,					value = 0.2})
push_start_command(dt,		{message = _("- INS - ALIGN"),															message_timeout = 5.0})
push_start_command(dt,		{device = devices.INS,					action = ins_commands.ModeKnob,					value = 0.2})
push_start_command(5.0,		{message = _("- INS - CONFIRM COORDINATES"),											message_timeout = dt_mto})
push_start_command(dt,		{device = devices.UFC,					action = ufc_commands.ENTR,						value = 1.0})
push_start_command(dt,		{device = devices.UFC,					action = ufc_commands.ENTR,						value = 0.0})
push_start_command(dt,		{device = devices.UFC,					action = ufc_commands.DCS_DOWN,					value = -1.0})
push_start_command(dt,		{device = devices.UFC,					action = ufc_commands.DCS_DOWN,					value = 0.0})
push_start_command(dt,		{device = devices.UFC,					action = ufc_commands.ENTR,						value = 1.0})
push_start_command(dt,		{device = devices.UFC,					action = ufc_commands.ENTR,						value = 0.0})
push_start_command(dt,		{message = _("- SNSR PWR PANEL - SET"),													message_timeout = dt_mto})
-- push_start_command(dt,		{device = devices.SMS,					action = sms_commands.LeftHDPT,					value = 1.0}) -- used only for TGP and HTS
-- push_start_command(dt,		{device = devices.SMS,					action = sms_commands.RightHDPT,				value = 1.0}) -- used only for TGP and HTS
push_start_command(dt,		{														check_condition = F16_AD_LEFT_HDPT_CHECK_RDY,		message_timeout = dt_mto})
push_start_command(dt,		{														check_condition = F16_AD_RIGHT_HDPT_CHECK_RDY,		message_timeout = dt_mto})
push_start_command(dt,		{device = devices.FCR,					action = fcr_commands.PwrSw,					value = 1.0})
push_start_command(dt,		{device = devices.RALT,					action = ralt_commands.PwrSw,					value = 1.0})
push_start_command(dt,		{message = _("- HMCS SYMBOLOGY INT POWER KNOB - INT"),									message_timeout = dt_mto})
push_start_command(dt,		{device = devices.HMCS,					action = hmcs_commands.IntKnob,					value = 0.8})
push_start_command(dt,		{message = _("- HUD"),																	message_timeout = dt_mto})
push_start_command(dt,		{device = devices.UFC,					action = ufc_commands.SYM_Knob,					value = 0.8})
push_start_command(dt,		{message = _("- C&I KNOB - UFC"),														message_timeout = dt_mto})
push_start_command(dt,		{device = devices.IFF_CONTROL_PANEL,	action = iff_commands.CNI_Knob,					value = 1.0})
-- FLCS BIT 
push_start_command(dt,		{message = _("- FLCS BIT - START"),														message_timeout = 5})
push_start_command(dt,		{device = devices.CONTROL_INTERFACE,	action = control_commands.BitSw,				value = 1.0})
push_start_command(50,		{device = devices.CONTROL_INTERFACE,	action = control_commands.BitSw,				value = 0.0})
push_start_command(dt,		{message = _("- FLCS BIT - FINISHED"),													message_timeout = dt_mto})
push_start_command(dt,		{message = _("- SAI - SET"),															message_timeout = dt_mto})
push_start_command(dt,		{device = devices.SAI,					action = sai_commands.reference,				value = 0.5})
--push_start_command(dt,		{device = devices.SAI,					action = sai_commands.cage,						value = 1.0})
--push_start_command(dt,		{device = devices.SAI,					action = sai_commands.cage,						value = 0.0})
push_start_command(dt,		{message = _("- FUEL QTY SEL KNOB - CHECK"),											message_timeout = 7.0})
push_start_command(dt,		{device = devices.FUEL_INTERFACE,		action = fuel_commands.FuelQtySelSw,			value = 0.0})
push_start_command(1.0,		{device = devices.FUEL_INTERFACE,		action = fuel_commands.FuelQtySelSw,			value = 0.1})
push_start_command(1.0,		{device = devices.FUEL_INTERFACE,		action = fuel_commands.FuelQtySelSw,			value = 0.2})
push_start_command(1.0,		{device = devices.FUEL_INTERFACE,		action = fuel_commands.FuelQtySelSw,			value = 0.3})
push_start_command(1.0,		{device = devices.FUEL_INTERFACE,		action = fuel_commands.FuelQtySelSw,			value = 0.4})
push_start_command(1.0,		{device = devices.FUEL_INTERFACE,		action = fuel_commands.FuelQtySelSw,			value = 0.5})
push_start_command(1.0,		{device = devices.FUEL_INTERFACE,		action = fuel_commands.FuelQtySelSw,			value = 0.1})
-- Before Taxi
push_start_command(dt,		{message = _("- CANOPY - CLOSE AND LOCK"),												message_timeout = 10.0})
push_start_command(dt,		{device = devices.CPT_MECH,		action = cpt_commands.CanopyHandle,						value = 0.0})
push_start_command(dt,		{device = devices.CPT_MECH,		action = cpt_commands.CanopySwitchClose,				value = -1.0})
push_start_command(8.0,		{device = devices.CPT_MECH,		action = cpt_commands.CanopySwitchClose,				value = 0.0})
push_start_command(dt,		{device = devices.CPT_MECH,		action = cpt_commands.CanopyHandle,						value = 1.0})
--HMCS Align
push_start_command(dt,		{message = _("- HMCS - ALIGN"),															message_timeout = 1 + dt_mto})
push_start_command(1.0,		{device = devices.hmcs_commands,		check_condition = F16_AD_HMCS_ALIGN})
-- INS Knob - NAV (not switched automatically)
--push_start_command(dt,		{message = _("- INS KNOB - NAV"),														message_timeout = dt_mto})
--push_start_command(dt,		{device = devices.INS,					action = ins_commands.ModeKnob,					value = 0.3})

-- Taxi
-- Before Takeoff
push_start_command(dt,		{message = _("- EJECTION SAFETY LEVER - ARM (DOWN)"),									message_timeout = dt_mto})
push_start_command(dt,		{device = devices.CPT_MECH,				action = cpt_commands.EjectionSafetyLever,		value = 1.0})

push_start_command(dt,		{message = _("- WAITING FOR INS ALIGN"),												message_timeout = 70.0})
push_start_command(70.0,	{message = _("- CHECK INS ALIGNMENT - READY"),			check_condition = F16_AD_INS_CHECK_RDY,			message_timeout = 5.0})

--
push_start_command(3.0,	{message = _("AUTOSTART COMPLETE"),message_timeout = std_message_timeout})
--


----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
-- Stop sequence
push_stop_command(2.0,	{message = _("AUTOSTOP SEQUENCE IS RUNNING"),	message_timeout = stop_sequence_time})
--

-- After Landing
push_stop_command(dt,		{message = _("- PROBE HEAT SWITCH - OFF"),												message_timeout = dt_mto})
push_stop_command(dt,		{device = devices.ELEC_INTERFACE,		action = elec_commands.ProbeHeatSw,				value = 0.0})
-- ECM POWER - OFF
push_stop_command(dt,		{message = _("- SPEEDBRAKES - CLOSE"),													message_timeout = dt_mto})
push_stop_command(dt,		{device = devices.HOTAS,				action = hotas_commands.THROTTLE_SPEED_BRAKE,	value = 1.0})
push_stop_command(1.5,		{device = devices.HOTAS,				action = hotas_commands.THROTTLE_SPEED_BRAKE,	value = 0.0})
push_stop_command(dt,		{message = _("- EJECTION SAFETY LEVER - SAFE (UP)"),									message_timeout = dt_mto})
push_stop_command(dt,		{device = devices.CPT_MECH,				action = cpt_commands.EjectionSafetyLever,		value = 0.0})
push_stop_command(dt,		{message = _("- IFF MASTER KNOB - STBY"),												message_timeout = dt_mto})
push_stop_command(dt,		{device = devices.IFF_CONTROL_PANEL,	action = iff_commands.MasterKnob,				value = 0.1})
push_stop_command(dt,		{message = _("- IFF M-4 CODE SWITCH - HOLD"),											message_timeout = dt_mto})
push_stop_command(dt,		{device = devices.IFF_CONTROL_PANEL,	action = iff_commands.M4CodeSw,					value = -1.0})
push_stop_command(dt,		{message = _("- CANOPY HANDLE - UP"),													message_timeout = dt_mto})
push_stop_command(dt,		{device = devices.CPT_MECH,		action = cpt_commands.CanopyHandle,						value = 0.0})

push_stop_command(dt,		{message = _("- ARMAMENT SWITCH - OFF, SAFE OR NORMAL"),								message_timeout = dt_mto})
push_stop_command(dt,		{device = devices.MMC,					action = mmc_commands.MasterArmSw,				value = 0.0})
push_stop_command(dt,		{device = devices.SMS,					action = sms_commands.LaserSw,					value = 0.0})
-- NUCLEAR CONSENT SWITCH - OFF
-- Prior to Engine Shutdown
push_stop_command(dt,		{message = _("- EPU SWITCH - OFF"),														message_timeout = dt_mto})
push_stop_command(dt,		{device = devices.ENGINE_INTERFACE,		action = engine_commands.EpuSwCvrOff,			value = 1.0})
push_stop_command(dt,		{device = devices.ENGINE_INTERFACE,		action = engine_commands.EpuSw,					value = -1.0})
-- AVTR POWER SWITCH - UNTHRD
push_stop_command(dt,		{message = _("- C&I KNOB - BACKUP"),													message_timeout = 5.0})
push_stop_command(dt,		{device = devices.IFF_CONTROL_PANEL,	action = iff_commands.CNI_Knob,					value = 0.0})
push_stop_command(5.0,		{message = _("- INS KNOB - OFF"),														message_timeout = dt_mto})
push_stop_command(dt,		{device = devices.INS,					action = ins_commands.ModeKnob,					value = 0.0})
push_stop_command(dt,		{message = _("- AVIONICS - OFF"),														message_timeout = 10.0})
push_stop_command(dt,		{device = devices.UFC,					action = ufc_commands.SYM_Knob,					value = 0.0})
push_stop_command(dt,		{device = devices.SMS,					action = sms_commands.LeftHDPT,					value = 0.0})
push_stop_command(dt,		{device = devices.SMS,					action = sms_commands.RightHDPT,				value = 0.0})
push_stop_command(dt,		{device = devices.FCR,					action = fcr_commands.PwrSw,					value = 0.0})
push_stop_command(dt,		{device = devices.RALT,					action = ralt_commands.PwrSw,					value = -1.0})
push_stop_command(dt,		{device = devices.MMC,					action = ecs_commands.AirSourceKnob,			value = 0.0})
push_stop_command(dt,		{device = devices.SMS,					action = sms_commands.StStaSw,					value = 0.0})
push_stop_command(dt,		{device = devices.MMC,					action = mmc_commands.MFD,						value = 0.0})
push_stop_command(dt,		{device = devices.UFC,					action = ufc_commands.UFC_Sw,					value = 0.0})
push_stop_command(dt,		{device = devices.MAP,					action = map_commands.PwrSw,					value = 0.0})
push_stop_command(dt,		{device = devices.GPS,					action = gps_commands.PwrSw,					value = 0.0})
push_stop_command(dt,		{device = devices.IDM,					action = idm_commands.PwrSw,					value = 0.0})
push_stop_command(dt,		{device = devices.HMCS,					action = hmcs_commands.IntKnob,					value = 0.0})
push_stop_command(dt,		{device = devices.INTERCOM,				action = intercom_commands.COM1_ModeKnob,		value = 0.0})
push_stop_command(dt,		{device = devices.INTERCOM,				action = intercom_commands.COM2_ModeKnob,		value = 0.0})
-- Engine Shutdown
push_stop_command(8.0,		{message = _("- THROTTLE - OFF"),		check_condition = F16_AD_THROTTLE_DOWN_TO_IDLE,	message_timeout = 21.0})
push_stop_command(dt,		{										check_condition = F16_AD_THROTTLE_SET_TO_OFF,	message_timeout = dt_mto})
push_stop_command(1.0,		{										check_condition = F16_AD_THROTTLE_AT_OFF,		message_timeout = dt_mto})
push_stop_command(20.0,		{message = _("- MAIN PWR SWITCH - OFF"),												message_timeout = dt_mto})
push_stop_command(dt,		{device = devices.ELEC_INTERFACE,		action = elec_commands.MainPwrSw,				value = -1.0})
push_stop_command(dt,		{message = _("- OXYGEN REGULATOR - ON AND NORM"),										message_timeout = dt_mto})
push_stop_command(dt,		{device = devices.OXYGEN_INTERFACE,		action = oxygen_commands.SupplyLever,			value = 0.5})
push_stop_command(dt,		{device = devices.OXYGEN_INTERFACE,		action = oxygen_commands.DiluterLever,			value = 0.0})
push_stop_command(dt,		{device = devices.OXYGEN_INTERFACE,		action = oxygen_commands.EmergencyLever,		value = 0.0})
push_stop_command(dt,		{message = _("- CANOPY - OPEN"),														message_timeout = 14.0})
push_stop_command(dt,		{device = devices.CPT_MECH,				action = cpt_commands.CanopySwitchOpen,			value = 1.0})
push_stop_command(14.0,		{device = devices.CPT_MECH,				action = cpt_commands.CanopySwitchOpen,			value = 0.0})

--
push_stop_command(3.0,	{message = _("AUTOSTOP COMPLETE"),	message_timeout = std_message_timeout})
--