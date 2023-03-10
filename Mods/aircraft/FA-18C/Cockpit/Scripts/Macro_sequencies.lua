dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."devices.lua")

std_message_timeout = 15

----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
local	t_start	= 0.0
local	t_stop	= 0.0
local	dt		= 0.2
local	dt_mto	= 1.0
local	t_align	= 1.5 * 60.0 - 45.0
local	start_sequence_time	= 235.0 + t_align
local	stop_sequence_time	= 10.0	-- TODO: timeout

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

F18_AD_NO_FAILURE							= counter()
F18_AD_ERROR								= counter()

F18_AD_WING_FOLD_HANDLE_SET_SAME_AS_POS		= counter()

F18_AD_LEFT_THROTTLE_SET_TO_OFF				= counter()
F18_AD_RIGHT_THROTTLE_SET_TO_OFF			= counter()
F18_AD_LEFT_THROTTLE_AT_OFF					= counter()
F18_AD_RIGHT_THROTTLE_AT_OFF				= counter()
F18_AD_LEFT_THROTTLE_SET_TO_IDLE			= counter()
F18_AD_RIGHT_THROTTLE_SET_TO_IDLE			= counter()
F18_AD_LEFT_THROTTLE_AT_IDLE				= counter()
F18_AD_RIGHT_THROTTLE_AT_IDLE				= counter()
F18_AD_LEFT_THROTTLE_DOWN_TO_IDLE			= counter()
F18_AD_RIGHT_THROTTLE_DOWN_TO_IDLE			= counter()

F18_AD_APU_READY							= counter()
F18_AD_LEFT_ENG_IDLE_RPM					= counter()
F18_AD_RIGHT_ENG_IDLE_RPM					= counter()
F18_AD_LEFT_ENG_CHECK_IDLE					= counter()
F18_AD_RIGHT_ENG_CHECK_IDLE					= counter()
F18_AD_ENG_CRANK_SW_CHECK_OFF				= counter()
F18_AD_APU_VERIFY_OFF						= counter()

F18_AD_INS_ALIGN							= counter()
F18_AD_INS_STOR_HDG							= counter()
F18_AD_INS_CHECK_RDY						= counter()

F18_AD_HMD_BRT_KNOB							= counter()
F18_AD_HMD_ALIGN							= counter()

--
alert_messages = {}

alert_messages[F18_AD_ERROR]								= { message = _("FM MODEL ERROR"),									message_timeout = std_message_timeout}

alert_messages[F18_AD_WING_FOLD_HANDLE_SET_SAME_AS_POS]		= { message = _("WING_FOLD_HANDLE - SET SAME AS WING POSITION"),	message_timeout = std_message_timeout}

alert_messages[F18_AD_LEFT_THROTTLE_SET_TO_OFF]				= { message = _("LEFT THROTTLE - TO OFF"),							message_timeout = std_message_timeout}
alert_messages[F18_AD_RIGHT_THROTTLE_SET_TO_OFF]			= { message = _("RIGHT THROTTLE - TO OFF"),							message_timeout = std_message_timeout}
alert_messages[F18_AD_LEFT_THROTTLE_AT_OFF]					= { message = _("LEFT THROTTLE MUST BE AT STOP"),					message_timeout = std_message_timeout}
alert_messages[F18_AD_RIGHT_THROTTLE_AT_OFF]				= { message = _("RIGHT THROTTLE MUST BE AT STOP"),					message_timeout = std_message_timeout}
alert_messages[F18_AD_LEFT_THROTTLE_SET_TO_IDLE]			= { message = _("LEFT THROTTLE - TO IDLE"),							message_timeout = std_message_timeout}
alert_messages[F18_AD_RIGHT_THROTTLE_SET_TO_IDLE]			= { message = _("RIGHT THROTTLE - TO IDLE"),						message_timeout = std_message_timeout}
alert_messages[F18_AD_LEFT_THROTTLE_AT_IDLE]				= { message = _("LEFT THROTTLE MUST BE AT IDLE"),					message_timeout = std_message_timeout}
alert_messages[F18_AD_RIGHT_THROTTLE_AT_IDLE]				= { message = _("RIGHT THROTTLE MUST BE AT IDLE"),					message_timeout = std_message_timeout}
alert_messages[F18_AD_LEFT_THROTTLE_DOWN_TO_IDLE]			= { message = _("LEFT THROTTLE - TO IDLE"),							message_timeout = std_message_timeout}
alert_messages[F18_AD_RIGHT_THROTTLE_DOWN_TO_IDLE]			= { message = _("RIGHT THROTTLE - TO IDLE"),						message_timeout = std_message_timeout}

alert_messages[F18_AD_APU_READY]							= { message = _("READY LIGHT MUST BE ON WITHIN 30 SEC"),			message_timeout = std_message_timeout}
alert_messages[F18_AD_LEFT_ENG_IDLE_RPM]					= { message = _("LEFT ENGINE RPM FAILURE"),							message_timeout = std_message_timeout}
alert_messages[F18_AD_RIGHT_ENG_IDLE_RPM]					= { message = _("RIGHT ENGINE RPM FAILURE"),						message_timeout = std_message_timeout}
alert_messages[F18_AD_LEFT_ENG_CHECK_IDLE]					= { message = _("LEFT ENGINE PARAMETERS FAILURE"),					message_timeout = std_message_timeout}
alert_messages[F18_AD_RIGHT_ENG_CHECK_IDLE]					= { message = _("RIGHT ENGINE PARAMETERS FAILURE"),					message_timeout = std_message_timeout}
alert_messages[F18_AD_ENG_CRANK_SW_CHECK_OFF]				= { message = _("ENG CRANK SWITCH MUST BE IN OFF POSITION"),		message_timeout = std_message_timeout}
alert_messages[F18_AD_APU_VERIFY_OFF]						= { message = _("APU MUST BE OFF"),									message_timeout = std_message_timeout}

alert_messages[F18_AD_INS_ALIGN]							= { message = _("INS ERROR"),										message_timeout = std_message_timeout}
alert_messages[F18_AD_INS_STOR_HDG]							= { message = _("INS STOR HDG ALIGN UNAVAILABLE"),					message_timeout = std_message_timeout}
alert_messages[F18_AD_INS_CHECK_RDY]						= { message = _("INS ALIGNMENT ERROR"),								message_timeout = std_message_timeout}


----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
-- Start sequence
push_start_command(dt,		{message = _("AUTOSTART SEQUENCE IS RUNNING"),													message_timeout = start_sequence_time})
--
-- Before Entering Cockpit
push_start_command(dt,		{message = _("EJECTION SEAT SAFE/ARM HANDLE - SAFE"),											message_timeout = dt_mto})
push_start_command(dt,		{device = devices.CPT_MECHANICS,		action = cpt_commands.EjectionSeatSafeArmedHandle,		value = 1.0})
push_start_command(dt,		{message = _("EJECTION SEAT MANUAL OVERRIDE HANDLE - FULL DOWN"),								message_timeout = dt_mto})
push_start_command(dt,		{device = devices.CPT_MECHANICS,		action = cpt_commands.EjectionSeatManualOverrideHandle,	value = 0.0})
-- Interior Check
push_start_command(dt,		{message = _("HARNESS AND RUDDER PEDALS - SECURE/ADJUST"),										message_timeout = dt_mto})
push_start_command(dt,		{device = devices.CPT_MECHANICS,		action = cpt_commands.SoulderHarnessControlHandle,		value = 1.0})
push_start_command(dt,		{device = devices.CPT_MECHANICS,		action = cpt_commands.RudderPedalAdjustLever,			value = 0.0})
-- Left Console
push_start_command(dt,		{message = _("LEFT CONSOLE"),																	message_timeout = 13.0})
push_start_command(dt,		{message = _("CIRCUIT BREAKERS - IN"),															message_timeout = dt_mto})
push_start_command(dt,		{device = devices.ELEC_INTERFACE,		action = elec_commands.CB_FCS_CHAN1,					value = 0.0})
push_start_command(dt,		{device = devices.ELEC_INTERFACE,		action = elec_commands.CB_FCS_CHAN2,					value = 0.0})
push_start_command(dt,		{device = devices.ELEC_INTERFACE,		action = elec_commands.CB_SPD_BRK,						value = 0.0})
push_start_command(dt,		{device = devices.ELEC_INTERFACE,		action = elec_commands.CB_LAUNCH_BAR,					value = 0.0})
push_start_command(dt,		{message = _("MC AND HYD ISOL SWITCHES - NORM"),												message_timeout = dt_mto})
push_start_command(dt,		{device = devices.ELEC_INTERFACE,		action = elec_commands.MC1OffSw,						value = 0.0})
push_start_command(dt,		{device = devices.ELEC_INTERFACE,		action = elec_commands.MC2OffSw,						value = 0.0})
push_start_command(dt,		{device = devices.HYDRAULIC_INTERFACE,	action = hydro_commands.HydIsolSw,						value = 0.0})
-- OBOGS
push_start_command(dt,		{message = _("OBOGS CONTROL SWITCH - OFF"),														message_timeout = dt_mto})
push_start_command(dt,		{device = devices.OXYGEN_INTERFACE,		action = oxygen_commands.OBOGS_ControlSw,				value = 0.0})
push_start_command(dt,		{message = _("OXY FLOW KNOB - ON"),																message_timeout = dt_mto})
push_start_command(dt,		{device = devices.OXYGEN_INTERFACE,		action = oxygen_commands.OxyFlowControlValve,			value = 1.0})
-- Antenna
push_start_command(dt,		{message = _("COMM 1/IFF ANT SEL SWITCHES - AUTO/BOTH"),										message_timeout = dt_mto})
push_start_command(dt,		{device = devices.ANTENNA_SELECTOR,		action = antsel_commands.Comm1AntSelSw,					value = 0.0})
push_start_command(dt,		{device = devices.ANTENNA_SELECTOR,		action = antsel_commands.AntSelIFFSw,					value = 0.0})
-- Comm Panel
push_start_command(dt,		{message = _("COMM PANEL - SET"),																message_timeout = 2.0})
push_start_command(dt,		{message = _("RELAY, GUARD - OFF"),																message_timeout = dt_mto})
push_start_command(dt,		{device = devices.INTERCOM,				action = intercom_commands.COMM_RLY_Sw,					value = 0.0})
push_start_command(dt,		{device = devices.INTERCOM,				action = intercom_commands.G_XMT_Sw,					value = 0.0})
push_start_command(dt,		{message = _("ILS - UFC"),																		message_timeout = dt_mto})
push_start_command(dt,		{device = devices.INTERCOM,				action = intercom_commands.ILS_UFC_MAN_Sw,				value = 1.0})
push_start_command(dt,		{message = _("MASTER, MODE 4 AND CRYPTO SWITCHES - NORM/OFF/NORM"),								message_timeout = dt_mto})
push_start_command(dt,		{device = devices.INTERCOM,				action = intercom_commands.IFF_MasterSw,				value = 0.0})
push_start_command(dt,		{device = devices.INTERCOM,				action = intercom_commands.IFF_Mode4Sw,					value = -1.0})
push_start_command(dt,		{device = devices.INTERCOM,				action = intercom_commands.IFF_CryptoSw_Zero,			value = 0.0})
push_start_command(dt,		{device = devices.INTERCOM,				action = intercom_commands.IFF_CryptoSw_Hold,			value = 0.0})
--
push_start_command(dt,		{message = _("GEN TIE CONTROL SWITCH - NORM"),													message_timeout = dt_mto})
push_start_command(dt,		{device = devices.ELEC_INTERFACE,		action = elec_commands.GenTieControlSwCover,			value = 1.0})
push_start_command(dt,		{device = devices.ELEC_INTERFACE,		action = elec_commands.GenTieControlSw,					value = 0.0})
push_start_command(dt,		{device = devices.ELEC_INTERFACE,		action = elec_commands.GenTieControlSwCover,			value = 0.0})
push_start_command(dt,		{message = _("FCS GAIN SWITCH - NORM"),															message_timeout = dt_mto})
push_start_command(dt,		{device = devices.CONTROL_INTERFACE,	action = ctrl_commands.GainSwCover,						value = 1.0})
push_start_command(dt,		{device = devices.CONTROL_INTERFACE,	action = ctrl_commands.GainSw,							value = 0.0})
push_start_command(dt,		{device = devices.CONTROL_INTERFACE,	action = ctrl_commands.GainSwCover,						value = 0.0})
-- Fuel Panel
push_start_command(dt,		{message = _("PROBE SWITCH - RETRACT"),															message_timeout = dt_mto})
push_start_command(dt,		{device = devices.FUEL_INTERFACE,		action = fuel_commands.ProbeControlSw,					value = 0.0})
push_start_command(dt,		{message = _("EXT TANK SWITCHES - NORM"),														message_timeout = dt_mto})
push_start_command(dt,		{device = devices.FUEL_INTERFACE,		action = fuel_commands.ExtTanksWingSw,					value = 0.0})
push_start_command(dt,		{device = devices.FUEL_INTERFACE,		action = fuel_commands.ExtTanksCtrSw,					value = 0.0})
push_start_command(dt,		{message = _("DUMP SWITCH - OFF"),																message_timeout = dt_mto})
push_start_command(dt,		{device = devices.FUEL_INTERFACE,		action = fuel_commands.DumpSw,							value = 0.0})
push_start_command(dt,		{message = _("INTR WING SWITCH - NORM"),														message_timeout = dt_mto})
push_start_command(dt,		{device = devices.FUEL_INTERFACE,		action = fuel_commands.IntrWingInhibitSw,				value = 0.0})
--
push_start_command(dt,		{message = _("THROTTLES - OFF"),		check_condition = F18_AD_LEFT_THROTTLE_DOWN_TO_IDLE,	message_timeout = dt_mto})
push_start_command(dt,		{										check_condition = F18_AD_LEFT_THROTTLE_SET_TO_OFF})
push_start_command(dt,		{										check_condition = F18_AD_RIGHT_THROTTLE_DOWN_TO_IDLE})
push_start_command(dt,		{										check_condition = F18_AD_RIGHT_THROTTLE_SET_TO_OFF})
--
push_start_command(dt,		{message = _("PARK BRK HANDLE - SET"),															message_timeout = dt_mto})
push_start_command(dt,		{device = devices.GEAR_INTERFACE,		action = gear_commands.EmergParkHandleSelectPark,		value = 0.333})
push_start_command(dt,		{device = devices.GEAR_INTERFACE,		action = gear_commands.EmergParkHandleSelectPark,		value = 0.0})
push_start_command(dt,		{device = devices.GEAR_INTERFACE,		action = gear_commands.EmergParkHandleOnOff,			value = 0.1})
push_start_command(dt,		{device = devices.GEAR_INTERFACE,		action = gear_commands.EmergParkHandleSelectPark,		value = 0.333})
push_start_command(dt,		{device = devices.GEAR_INTERFACE,		action = gear_commands.EmergParkHandleSelectPark,		value = 0.0})
push_start_command(dt,		{device = devices.GEAR_INTERFACE,		action = gear_commands.EmergParkHandleOnOff,			value = -0.1})
--
push_start_command(dt,		{message = _("LDG/TAXI LIGHT SWITCH - OFF"),													message_timeout = dt_mto})
push_start_command(dt,		{device = devices.EXT_LIGHTS,			action = extlights_commands.LdgTaxi,					value = 0.0})
push_start_command(dt,		{message = _("ANTI SKID SWITCH - ON"),															message_timeout = dt_mto})
push_start_command(dt,		{device = devices.GEAR_INTERFACE,		action = gear_commands.AntiSkidSw,						value = 1.0})
push_start_command(dt,		{message = _("FLAP SWITCH - FULL"),																message_timeout = dt_mto})
push_start_command(dt,		{device = devices.CONTROL_INTERFACE,	action = ctrl_commands.FlapSw,							value = -1.0})
push_start_command(dt,		{message = _("SELECT JETT KNOB - SAFE"),														message_timeout = dt_mto})
push_start_command(dt,		{device = devices.SMS,					action = SMS_commands.SelJettLvr,						value = 0.0})
push_start_command(dt,		{message = _("LDG GEAR HANDLE - DN"),															message_timeout = dt_mto})
push_start_command(dt,		{device = devices.GEAR_INTERFACE,		action = gear_commands.GearHandle,						value = 0.0})
push_start_command(dt,		{message = _("CANOPY JETT HANDLE - FORWARD"),													message_timeout = dt_mto})
push_start_command(dt,		{device = devices.CPT_MECHANICS,		action = cpt_commands.CanopyJettLeverButton,			value = 1.0})
push_start_command(dt,		{device = devices.CPT_MECHANICS,		action = cpt_commands.CanopyJettLever,					value = 0.0})
push_start_command(dt,		{device = devices.CPT_MECHANICS,		action = cpt_commands.CanopyJettLeverButton,			value = 0.0})
-- Instrument Panel
push_start_command(dt,		{message = _("INSTRUMENT PANEL"),																message_timeout = 7.0})
push_start_command(dt,		{message = _("MASTER ARM SWITCH - SAFE"),														message_timeout = dt_mto})
push_start_command(dt,		{device = devices.SMS,					action = SMS_commands.MasterArmSw,						value = 0.0})
push_start_command(dt,		{message = _("FIRE AND APU FIRE WARNING LIGHTS - NOT PRESSED IN"),								message_timeout = dt_mto})
push_start_command(dt,		{device = devices.ENGINES_INTERFACE,	action = engines_commands.LENG_FireSwCover,				value = 1.0})
push_start_command(dt,		{device = devices.ENGINES_INTERFACE,	action = engines_commands.LENG_FireSw,					value = 0.0})
push_start_command(dt,		{device = devices.ENGINES_INTERFACE,	action = engines_commands.LENG_FireSwCover,				value = 0.0})
push_start_command(dt,		{device = devices.ENGINES_INTERFACE,	action = engines_commands.RENG_FireSwCover,				value = 1.0})
push_start_command(dt,		{device = devices.ENGINES_INTERFACE,	action = engines_commands.RENG_FireSw,					value = 0.0})
push_start_command(dt,		{device = devices.ENGINES_INTERFACE,	action = engines_commands.RENG_FireSwCover,				value = 0.0})
push_start_command(dt,		{device = devices.ENGINES_INTERFACE,	action = engines_commands.APU_FireSw,					value = 0.0})
push_start_command(dt,		{message = _("L(R) DDI, AMPCD, AND HUD KNOBS - OFF"),											message_timeout = dt_mto})
push_start_command(dt,		{device = devices.MDI_LEFT,				action = MDI_commands.MDI_off_night_day,				value = 0.0})
push_start_command(dt,		{device = devices.MDI_RIGHT,			action = MDI_commands.MDI_off_night_day,				value = 0.0})
push_start_command(dt,		{device = devices.HUD,					action = HUD_commands.HUD_SymbBrightCtrl,				value = 0.0})
push_start_command(dt,		{device = devices.AMPCD,				action = AMPCD_commands.AMPCD_off_brightness,			value = 0.0})
push_start_command(dt,		{message = _("ALTITUDE SOURCE - SELECT"),														message_timeout = dt_mto})
push_start_command(dt,		{device = devices.HUD,					action = HUD_commands.HUD_AltitudeSw,					value = 0.0})
push_start_command(dt,		{message = _("ATT SWITCH - AUTO"),																message_timeout = dt_mto})
push_start_command(dt,		{device = devices.HUD,					action = HUD_commands.HUD_AttitudeSelSw,				value = 0.0})
push_start_command(dt,		{message = _("COMM 1 AND 2 KNOBS - OFF"),														message_timeout = dt_mto})
push_start_command(dt,		{device = devices.UFC,					action = UFC_commands.Comm1Vol,							value = 0.0})
push_start_command(dt,		{device = devices.UFC,					action = UFC_commands.Comm2Vol,							value = 0.0})
push_start_command(dt,		{message = _("ADF SWITCH - OFF"),																message_timeout = dt_mto})
push_start_command(dt,		{device = devices.UFC,					action = UFC_commands.SwADF,							value = 0.0})
-- ECM Mode - OFF
-- TODO: ???
-- Dispenser select knob/dispenser switch - OFF
-- TODO: ???
push_start_command(dt,		{message = _("AUX REL SWITCH - NORM"),															message_timeout = dt_mto})
push_start_command(dt,		{device = devices.SMS,					action = SMS_commands.AuxRelSw,							value = 0.0})
push_start_command(dt,		{message = _("STANDBY ATTITUDE REFERENCE INDICATOR - CAGE/LOCK"),								message_timeout = dt_mto})
push_start_command(dt,		{device = devices.SAI,					action = sai_commands.SAI_pull,							value = 1.0})
push_start_command(dt,		{device = devices.SAI,					action = sai_commands.SAI_rotate,						value = 0.01})
push_start_command(dt,		{device = devices.SAI,					action = sai_commands.SAI_pull,							value = 0.0})
push_start_command(dt,		{message = _("IR COOL SWITCH - OFF"),															message_timeout = dt_mto})
push_start_command(dt,		{device = devices.SMS,					action = SMS_commands.IRCoolingSw,						value = 0.0})
push_start_command(dt,		{message = _("SPIN SWITCH - GUARD DOWN/OFF"),													message_timeout = dt_mto})
push_start_command(dt,		{device = devices.CONTROL_INTERFACE,	action = ctrl_commands.SpinRecCover,					value = 1.0})
push_start_command(dt,		{device = devices.CONTROL_INTERFACE,	action = ctrl_commands.SpinRec,							value = 0.0})
push_start_command(dt,		{device = devices.CONTROL_INTERFACE,	action = ctrl_commands.SpinRecCover,					value = 0.0})
-- Right Console
push_start_command(dt,		{message = _("RIGHT CONSOLE"),																	message_timeout = 10.0})
push_start_command(dt,		{message = _("CIRCUIT BREAKERS - IN"),															message_timeout = dt_mto})
push_start_command(dt,		{device = devices.ELEC_INTERFACE,		action = elec_commands.CB_FCS_CHAN3,					value = 0.0})
push_start_command(dt,		{device = devices.ELEC_INTERFACE,		action = elec_commands.CB_FCS_CHAN4,					value = 0.0})
push_start_command(dt,		{device = devices.ELEC_INTERFACE,		action = elec_commands.CB_HOOK,							value = 0.0})
push_start_command(dt,		{device = devices.ELEC_INTERFACE,		action = elec_commands.CB_LG,							value = 0.0})
push_start_command(dt,		{message = _("HOOK HANDLE - UP"),																message_timeout = dt_mto})
push_start_command(dt,		{device = devices.GEAR_INTERFACE,		action = gear_commands.HookHandle,						value = 1.0})
push_start_command(dt,		{message = _("WING FOLD HANDLE - SAME AS WING POSITION"),										message_timeout = dt_mto})
push_start_command(dt,		{device = devices.CONTROL_INTERFACE,	action = ctrl_commands.WingFoldPull,					value = 1.0})
push_start_command(dt,		{										check_condition = F18_AD_WING_FOLD_HANDLE_SET_SAME_AS_POS})
push_start_command(dt,		{device = devices.CONTROL_INTERFACE,	action = ctrl_commands.WingFoldPull,					value = 0.0})
push_start_command(dt,		{message = _("AV COOL SWITCH - NORM"),															message_timeout = dt_mto})
push_start_command(dt,		{device = devices.ECS_INTERFACE,		action = ECS_commands.AV_COOL_Sw,						value = 0.0})
push_start_command(dt,		{message = _("RADAR ALTIMETER - OFF"),															message_timeout = dt_mto})
for i = 0, 250, 1 do
	push_start_command(0.01,	{device = devices.ID2163A,				action = id2163a_commands.ID2163A_SetMinAlt,			value = -0.05})
end
push_start_command(dt,		{message = _("GEN SWITCHES - NORM"),															message_timeout = dt_mto})
push_start_command(dt,		{device = devices.ELEC_INTERFACE,		action = elec_commands.LGenSw,							value = 1.0})
push_start_command(dt,		{device = devices.ELEC_INTERFACE,		action = elec_commands.RGenSw,							value = 1.0})
push_start_command(dt,		{message = _("BATT SWITCH - OFF"),																message_timeout = dt_mto})
push_start_command(dt,		{device = devices.ELEC_INTERFACE,		action = elec_commands.BattSw,							value = 0.0})
-- ECS Panel
push_start_command(dt,		{message = _("ECS PANEL - SET"),																message_timeout = 3.0})
push_start_command(dt,		{message = _("MODE SWITCH - AUTO"),																message_timeout = dt_mto})
push_start_command(dt,		{device = devices.ECS_INTERFACE,		action = ECS_commands.ECSModeSw,						value = 1.0})
push_start_command(dt,		{message = _("CABIN TEMP KNOB - 10 O'CLOCK"),													message_timeout = dt_mto})
push_start_command(dt,		{device = devices.ECS_INTERFACE,		action = ECS_commands.CabinTemperatureRst,				value = 0.285})
push_start_command(dt,		{device = devices.ECS_INTERFACE,		action = ECS_commands.SuitTemperatureRst,				value = 0.285})
push_start_command(dt,		{message = _("CABIN PRESS SWITCH - NORM"),														message_timeout = dt_mto})
push_start_command(dt,		{device = devices.ECS_INTERFACE,		action = ECS_commands.CabinPressSw,						value = 1.0})
push_start_command(dt,		{message = _("BLEED AIR KNOB - NORM AND DOWN"),													message_timeout = dt_mto})
push_start_command(dt,		{device = devices.ECS_INTERFACE,		action = ECS_commands.BleedAirSw,						value = 0.2})
push_start_command(dt,		{device = devices.ECS_INTERFACE,		action = ECS_commands.BleedAirSwAugPull,				value = 0.0})
push_start_command(dt,		{message = _("ENG ANTI ICE SWITCH - OFF"),														message_timeout = dt_mto})
push_start_command(dt,		{device = devices.ENGINES_INTERFACE,	action = engines_commands.AntiIceSw,					value = 0.0})
push_start_command(dt,		{message = _("PITOT ANTI ICE SWITCH - AUTO"),													message_timeout = dt_mto})
push_start_command(dt,		{device = devices.ELEC_INTERFACE,		action = elec_commands.PitotHeater,						value = 0.0})
--
push_start_command(dt,		{message = _("DEFOG HANDLE - MID RANGE"),														message_timeout = dt_mto})
push_start_command(dt,		{device = devices.ECS_INTERFACE,		action = ECS_commands.DefogHandle,						value = 0.0})
push_start_command(dt,		{message = _("WINDSHIELD SWITCH - OFF"),														message_timeout = dt_mto})
push_start_command(dt,		{device = devices.ECS_INTERFACE,		action = ECS_commands.WindshieldSw,						value = 0.0})
-- Sensors
push_start_command(dt,		{message = _("SENSORS - OFF"),																	message_timeout = dt_mto})
push_start_command(dt,		{device = devices.RADAR,				action = RADAR_commands.RADAR_SwitchChange,				value = 0.0})
push_start_command(dt,		{device = devices.INS,					action = INS_commands.INS_SwitchChange,					value = 0.0})
-- TODO: FLIR switch - OFF
-- TODO: LTD/R switch - SAFE
-- TODO: LST/NFLR switch - OFF
-- Engine Start
push_start_command(dt,		{message = _("ENGINE START"),																	message_timeout = 138.0})
push_start_command(dt,		{message = _("BATT SWITCH - ON"),																message_timeout = dt_mto})
push_start_command(dt,		{device = devices.ELEC_INTERFACE,		action = elec_commands.BattSw,							value = 1.0})
push_start_command(dt,		{message = _("APU SWITCH - ON"),																message_timeout = dt_mto})
push_start_command(dt,		{device = devices.ENGINES_INTERFACE,	action = engines_commands.APU_ControlSw,				value = 1.0})
push_start_command(dt,		{device = devices.ENGINES_INTERFACE,	action = engines_commands.APU_ControlSw,				value = 0.0})
push_start_command(30.0,	{message = _("READY LIGHT - CHECK"),	check_condition = F18_AD_APU_READY})
push_start_command(dt,		{message = _("ENG CRANK SWITCH - R"),															message_timeout = dt_mto})
push_start_command(dt,		{										check_condition = F18_AD_RIGHT_THROTTLE_AT_OFF})
push_start_command(dt,		{device = devices.ENGINES_INTERFACE,	action = engines_commands.EngineCrankRSw,				value = 1.0})
push_start_command(dt,		{device = devices.ENGINES_INTERFACE,	action = engines_commands.EngineCrankRSw,				value = 0.0})
push_start_command(3.0,		{message = _("RIGHT THROTTLE - IDLE (15% RPM MINIMUM)"),										message_timeout = 10.0})
for i = 0, 50, 1 do
	push_start_command(0.2,		{										check_condition = F18_AD_RIGHT_THROTTLE_SET_TO_IDLE})
end
push_start_command(40.0,	{										check_condition = F18_AD_RIGHT_ENG_IDLE_RPM})
push_start_command(dt,		{message = _("L(R) DDI, AMPCD, HUD, AND UFC AVIONICS, AND RADAR ALTIMETER - ON"),				message_timeout = 1.0})
push_start_command(dt,		{device = devices.MDI_LEFT,				action = MDI_commands.MDI_off_night_day,				value = 0.2})
push_start_command(dt,		{device = devices.MDI_RIGHT,			action = MDI_commands.MDI_off_night_day,				value = 0.2})
push_start_command(dt,		{device = devices.HUD,					action = HUD_commands.HUD_SymbBrightCtrl,				value = 0.85})
push_start_command(dt,		{device = devices.AMPCD,				action = AMPCD_commands.AMPCD_off_brightness,			value = 0.85})
push_start_command(dt,		{device = devices.UFC,					action = UFC_commands.BrtDim,							value = 0.85})
for i = 0, 20, 1 do
	push_start_command(0.01,	{device = devices.ID2163A,				action = id2163a_commands.ID2163A_SetMinAlt,			value = 0.05})
end
push_start_command(dt,		{message = _("HMD SWITCH - ON"),																message_timeout = 1.0 + dt_mto})
push_start_command(0.5, 	{										check_condition = F18_AD_HMD_BRT_KNOB})												 
push_start_command(dt,		{message = _("IFEI - CHECK"),																	message_timeout = dt_mto})
push_start_command(dt,		{										check_condition = F18_AD_RIGHT_ENG_CHECK_IDLE})
push_start_command(dt,		{message = _("BLEED AIR KNOB - CYCLE THRU OFF TO NORM"),										message_timeout = dt_mto})
push_start_command(dt,		{device = devices.ECS_INTERFACE,		action = ECS_commands.BleedAirSw,						value = 0.3})
push_start_command(dt,		{device = devices.ECS_INTERFACE,		action = ECS_commands.BleedAirSw,						value = 0.0})
push_start_command(dt,		{device = devices.ECS_INTERFACE,		action = ECS_commands.BleedAirSw,						value = 0.1})
push_start_command(dt,		{device = devices.ECS_INTERFACE,		action = ECS_commands.BleedAirSw,						value = 0.2})
push_start_command(dt,		{message = _("WARNING AND CAUTION LIGHTS - TEST"),												message_timeout = dt_mto})
push_start_command(dt,		{device = devices.CPT_LIGHTS,			action = cptlights_commands.LtTestSw,					value = 1.0})
push_start_command(dt,		{device = devices.CPT_LIGHTS,			action = cptlights_commands.LtTestSw,					value = 0.0})
push_start_command(dt,		{message = _("ENG CRANK SWITCH - L"),															message_timeout = dt_mto})
push_start_command(dt,		{										check_condition = F18_AD_LEFT_THROTTLE_AT_OFF})
push_start_command(dt,		{device = devices.ENGINES_INTERFACE,	action = engines_commands.EngineCrankLSw,				value = -1.0})
push_start_command(dt,		{device = devices.ENGINES_INTERFACE,	action = engines_commands.EngineCrankLSw,				value = 0.0})
push_start_command(3.0,		{message = _("LEFT THROTTLE - IDLE (15% RPM MINIMUM)"),											message_timeout = 10.0})
for i = 0, 50, 1 do
	push_start_command(0.2,		{										check_condition = F18_AD_LEFT_THROTTLE_SET_TO_IDLE})
end
push_start_command(40.0,	{										check_condition = F18_AD_LEFT_ENG_IDLE_RPM})
push_start_command(dt,		{message = _("ENG CRANK SWITCH - CHECK OFF"),													message_timeout = 10.0})
push_start_command(dt,		{										check_condition = F18_AD_ENG_CRANK_SW_CHECK_OFF})
push_start_command(dt,		{message = _("IFEI - CHECK"),																	message_timeout = dt_mto})
push_start_command(dt,		{										check_condition = F18_AD_LEFT_ENG_CHECK_IDLE})
-- Before Taxi
push_start_command(dt,		{message = _("BEFORE TAXI"),																	message_timeout = 75.0 + t_align})
											 -- 
push_start_command(dt,		{message = _("INS KNOB - ALIGN"),																message_timeout = dt_mto})
push_start_command(dt,		{										check_condition = F18_AD_INS_ALIGN})
push_start_command(1.0,		{message = _("INS - SELECT STOR HDG ALIGN"),													message_timeout = dt_mto})
-- try set STOR HDG
for i = 0, 7, 1 do
	push_start_command(0.3,		{										check_condition = F18_AD_INS_STOR_HDG})
end
--
push_start_command(dt,		{message = _("RADAR KNOB - OPR"),																message_timeout = dt_mto})
push_start_command(dt,		{device = devices.RADAR,				action = RADAR_commands.RADAR_SwitchChange,				value = 0.2})
push_start_command(dt,		{message = _("FCS RESET BUTTON - PUSH"),														message_timeout = dt_mto})
push_start_command(dt,		{device = devices.CONTROL_INTERFACE,	action = ctrl_commands.ResetSw,							value = 1.0})
push_start_command(dt,		{device = devices.CONTROL_INTERFACE,	action = ctrl_commands.ResetSw,							value = 0.0})
push_start_command(dt,		{message = _("FLAP SWITCH - AUTO"),																message_timeout = dt_mto})
push_start_command(dt,		{device = devices.CONTROL_INTERFACE,	action = ctrl_commands.FlapSw,							value = 1.0})
push_start_command(dt,		{message = _("FCS RESET BUTTON AND PADDLE SWITCH - ACTUATE SIMULTANEOUSLY"),					message_timeout = dt_mto})
push_start_command(dt,		{device = devices.HOTAS,				action = hotas_commands.STICK_PADDLE,					value = 1.0})
push_start_command(dt,		{device = devices.CONTROL_INTERFACE,	action = ctrl_commands.ResetSw,							value = 1.0})
push_start_command(dt,		{device = devices.CONTROL_INTERFACE,	action = ctrl_commands.ResetSw,							value = 0.0})
push_start_command(dt,		{device = devices.HOTAS,				action = hotas_commands.STICK_PADDLE,					value = 0.0})
push_start_command(dt,		{message = _("FLAP SWITCH - HALF"),																message_timeout = dt_mto})
push_start_command(dt,		{device = devices.CONTROL_INTERFACE,	action = ctrl_commands.FlapSw,							value = 0.0})
push_start_command(dt,		{message = _("FCS INITIATED BIT - PERFORM"),													message_timeout = dt_mto})
-- TODO: ???
push_start_command(dt,		{message = _("TRIM - CHECK"),																	message_timeout = dt_mto})
-- TODO: ???
push_start_command(dt,		{message = _("T/O TRIM BUTTON - PRESS UNTIL TRIM ADVISORY DISPLAYED"),							message_timeout = dt_mto})
push_start_command(dt,		{device = devices.CONTROL_INTERFACE,	action = ctrl_commands.TOTrimSw,						value = 1.0})
-- TODO: check condition
push_start_command(dt,		{device = devices.CONTROL_INTERFACE,	action = ctrl_commands.TOTrimSw,						value = 0.0})
push_start_command(dt,		{message = _("PROBE, SPEEDBRAKE, LAUNCH BAR SWITCHES, HOOK HANDLE AND PITOT HEAT - CYCLE"),		message_timeout = 54.0})
push_start_command(dt,		{device = devices.FUEL_INTERFACE,		action = fuel_commands.ProbeControlSw,					value = 1.0})
push_start_command(6.0,		{device = devices.FUEL_INTERFACE,		action = fuel_commands.ProbeControlSw,					value = 0.0})
push_start_command(6.0,		{device = devices.HOTAS,				action = hotas_commands.THROTTLE_SPEED_BRAKE,			value = -1.0})
push_start_command(3.0,		{device = devices.HOTAS,				action = hotas_commands.THROTTLE_SPEED_BRAKE,			value = 1.0})
push_start_command(3.0,		{device = devices.HOTAS,				action = hotas_commands.THROTTLE_SPEED_BRAKE,			value = 0.0})
push_start_command(dt,		{device = devices.GEAR_INTERFACE,		action = gear_commands.LaunchBarSw,						value = 1.0})
push_start_command(dt,		{device = devices.GEAR_INTERFACE,		action = gear_commands.LaunchBarSw,						value = 0.0})
push_start_command(3.0,		{device = devices.GEAR_INTERFACE,		action = gear_commands.LaunchBarSw,						value = 1.0})
push_start_command(dt,		{device = devices.GEAR_INTERFACE,		action = gear_commands.LaunchBarSw,						value = 0.0})
push_start_command(3.0,		{device = devices.GEAR_INTERFACE,		action = gear_commands.HookHandle,						value = 0.0})
push_start_command(4.0,		{device = devices.GEAR_INTERFACE,		action = gear_commands.HookHandle,						value = 1.0})
push_start_command(5.0,		{device = devices.ELEC_INTERFACE,		action = elec_commands.PitotHeater,						value = 1.0})
push_start_command(dt,		{device = devices.ELEC_INTERFACE,		action = elec_commands.PitotHeater,						value = 0.0})
push_start_command(dt,		{device = devices.ELEC_INTERFACE,		action = elec_commands.PitotHeater,						value = 1.0})
push_start_command(dt,		{device = devices.ELEC_INTERFACE,		action = elec_commands.PitotHeater,						value = 0.0})
push_start_command(20.0,	{message = _("APU - VERIFY OFF"),																message_timeout = dt_mto})
push_start_command(dt,		{										check_condition = F18_AD_APU_VERIFY_OFF})
push_start_command(dt,		{message = _("STANDBY ATTITUDE REFERENCE INDICATOR - UNCAGE"),									message_timeout = dt_mto})
push_start_command(dt,		{device = devices.SAI,					action = sai_commands.SAI_rotate,						value = -0.01})
push_start_command(dt,		{message = _("ATT SWITCH - STBY"),																message_timeout = dt_mto})
push_start_command(dt,		{device = devices.HUD,					action = HUD_commands.HUD_AttitudeSelSw,				value = -1.0})
push_start_command(dt,		{message = _("ATT SWITCH - AUTO"),																message_timeout = dt_mto})
push_start_command(dt,		{device = devices.HUD,					action = HUD_commands.HUD_AttitudeSelSw,				value = 0.0})
push_start_command(dt,		{message = _("OBOGS CONTROL SWITCH - ON"),														message_timeout = dt_mto})
push_start_command(dt,		{device = devices.OXYGEN_INTERFACE,		action = oxygen_commands.OBOGS_ControlSw,				value = 1.0})
push_start_command(dt,		{message = _("CANOPY - CLOSE"),																	message_timeout = dt_mto})
push_start_command(dt,		{device = devices.CPT_MECHANICS,		action = cpt_commands.CanopySwitchClose,				value = -1.0})
push_start_command(8.0,		{device = devices.CPT_MECHANICS,		action = cpt_commands.CanopySwitchClose,				value = 0.0})
push_start_command(dt,		{message = _("HMD - ALIGN"),																	message_timeout = 1 + dt_mto})
push_start_command(1.0, 	{										check_condition = F18_AD_HMD_ALIGN})
--
push_start_command(dt,		{message = _("WAITING FOR INS ALIGN"),															message_timeout = t_align})
push_start_command(t_align,	{message = _("CHECK INS ALIGNMENT - READY"),		check_condition = F18_AD_INS_CHECK_RDY,		message_timeout = dt_mto})
--
push_start_command(dt,		{message = _("PARK BRK HANDLE - FULLY STOWED"),													message_timeout = dt_mto})
push_start_command(dt,		{device = devices.GEAR_INTERFACE,		action = gear_commands.EmergParkHandleSelectPark,		value = 0.333})
push_start_command(dt,		{device = devices.GEAR_INTERFACE,		action = gear_commands.EmergParkHandleSelectPark,		value = 0.0})
push_start_command(dt,		{device = devices.GEAR_INTERFACE,		action = gear_commands.EmergParkHandleSelectEmerg,		value = -0.666})
--
push_start_command(dt,		{message = _("EJECTION SEAT SAFE/ARM HANDLE - ARM"),											message_timeout = dt_mto})
push_start_command(dt,		{device = devices.CPT_MECHANICS,		action = cpt_commands.EjectionSeatSafeArmedHandle,		value = 0.0})
--
push_start_command(dt,		{message = _("COMM 1 AND 2 KNOBS - ON"),														message_timeout = dt_mto})
push_start_command(dt,		{device = devices.UFC,					action = UFC_commands.Comm1Vol,							value = 0.8})
push_start_command(dt,		{device = devices.UFC,					action = UFC_commands.Comm2Vol,							value = 0.8})
--
push_start_command(dt,		{message = _("INS KNOB - NAV"),																	message_timeout = dt_mto})
push_start_command(dt,		{device = devices.INS,					action = INS_commands.INS_SwitchChange,					value = 0.3})

--
push_start_command(3.0,	{message = _("AUTOSTART COMPLETE"),message_timeout = std_message_timeout})
--




----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
-- Stop sequence
push_stop_command(2.0,	{message = _("AUTOSTOP SEQUENCE IS RUNNING"),	message_timeout = stop_sequence_time})
--

push_stop_command(dt,		{message = _("EJECTION SEAT SAFE/ARM HANDLE - SAFE"),											message_timeout = dt_mto})
push_stop_command(dt,		{device = devices.CPT_MECHANICS,		action = cpt_commands.EjectionSeatSafeArmedHandle,		value = 1.0})
push_stop_command(dt,		{message = _("LDG GEAR HANDLE - DN"),															message_timeout = dt_mto})
push_stop_command(dt,		{device = devices.GEAR_INTERFACE,		action = gear_commands.GearHandle,						value = 0.0})
push_stop_command(dt,		{message = _("FLAP SWITCH - AUTO"),																message_timeout = dt_mto})
push_stop_command(dt,		{device = devices.CONTROL_INTERFACE,	action = ctrl_commands.FlapSw,							value = 1.0})
push_stop_command(dt,		{message = _("T/O TRIM BUTTON - PRESS UNTIL TRIM ADVISORY DISPLAYED"),							message_timeout = dt_mto})
push_stop_command(dt,		{device = devices.CONTROL_INTERFACE,	action = ctrl_commands.TOTrimSw,						value = 1.0})
-- TODO: check condition
push_stop_command(dt,		{device = devices.CONTROL_INTERFACE,	action = ctrl_commands.TOTrimSw,						value = 0.0})
push_stop_command(dt,		{message = _("PARK BRK HANDLE - SET"),															message_timeout = dt_mto})
push_stop_command(dt,		{device = devices.GEAR_INTERFACE,		action = gear_commands.EmergParkHandleSelectPark,		value = 0.333})
push_stop_command(dt,		{device = devices.GEAR_INTERFACE,		action = gear_commands.EmergParkHandleSelectPark,		value = 0.0})
push_stop_command(dt,		{device = devices.GEAR_INTERFACE,		action = gear_commands.EmergParkHandleOnOff,			value = 0.1})
push_stop_command(dt,		{device = devices.GEAR_INTERFACE,		action = gear_commands.EmergParkHandleSelectPark,		value = 0.333})
push_stop_command(dt,		{device = devices.GEAR_INTERFACE,		action = gear_commands.EmergParkHandleSelectPark,		value = 0.0})
push_stop_command(dt,		{device = devices.GEAR_INTERFACE,		action = gear_commands.EmergParkHandleOnOff,			value = -0.1})
push_stop_command(dt,		{message = _("INS KNOB - OFF"),																	message_timeout = dt_mto})
push_stop_command(dt,		{device = devices.INS,					action = INS_commands.INS_SwitchChange,					value = 0.0})
push_stop_command(dt,		{message = _("STANDBY ATTITUDE REFERENCE INDICATOR - CAGE/LOCK"),								message_timeout = dt_mto})
push_stop_command(dt,		{device = devices.SAI,					action = sai_commands.SAI_pull,							value = 1.0})
push_stop_command(dt,		{device = devices.SAI,					action = sai_commands.SAI_rotate,						value = 0.01})
push_stop_command(dt,		{device = devices.SAI,					action = sai_commands.SAI_pull,							value = 0.0})
push_stop_command(dt,		{message = _("SENSORS, RADAR, AVIONICS AND VTRS - OFF"),										message_timeout = dt_mto})
-- TODO: sensors ???
push_stop_command(dt,		{device = devices.RADAR,				action = RADAR_commands.RADAR_SwitchChange,				value = 0.0})
-- TODO: avionics and vtrs ???
push_stop_command(dt,		{message = _("COMM 1 AND 2 KNOBS - OFF"),														message_timeout = dt_mto})
push_stop_command(dt,		{device = devices.UFC,					action = UFC_commands.Comm1Vol,							value = 0.0})
push_stop_command(dt,		{device = devices.UFC,					action = UFC_commands.Comm2Vol,							value = 0.0})
push_stop_command(dt,		{message = _("EXT AND INT LT KNOBS - OFF"),														message_timeout = dt_mto})
push_stop_command(dt,		{device = devices.EXT_LIGHTS,			action = extlights_commands.Formation,					value = 0.0})
push_stop_command(dt,		{device = devices.EXT_LIGHTS,			action = extlights_commands.Position,					value = 0.0})
push_stop_command(dt,		{device = devices.EXT_LIGHTS,			action = extlights_commands.Strobe,						value = 0.0})
push_stop_command(dt,		{device = devices.EXT_LIGHTS,			action = extlights_commands.LdgTaxi,					value = 0.0})
push_stop_command(dt,		{device = devices.CPT_LIGHTS,			action = cptlights_commands.Consoles,					value = 0.0})
push_stop_command(dt,		{device = devices.CPT_LIGHTS,			action = cptlights_commands.InstPnl,					value = 0.0})
push_stop_command(dt,		{device = devices.CPT_LIGHTS,			action = cptlights_commands.Flood,						value = 0.0})
push_stop_command(dt,		{device = devices.CPT_LIGHTS,			action = cptlights_commands.Chart,						value = 0.0})
--
push_stop_command(dt,		{message = _("CANOPY - OPEN"),																	message_timeout = dt_mto})
push_stop_command(dt,		{device = devices.CPT_MECHANICS,		action = cpt_commands.CanopySwitchOpen,					value = 1.0})
push_stop_command(dt,		{device = devices.CPT_MECHANICS,		action = cpt_commands.CanopySwitchOpen,					value = 0.0})
-- Engine Shutdown
push_stop_command(dt,		{message = _("NOSEWHEEL STEERING - DISENGAGE"),													message_timeout = dt_mto})
push_stop_command(dt,		{device = devices.HOTAS,				action = hotas_commands.STICK_PADDLE,					value = 1.0})
push_stop_command(dt,		{device = devices.HOTAS,				action = hotas_commands.STICK_PADDLE,					value = 0.0})
push_stop_command(dt,		{message = _("FLAP SWITCH - FULL"),																message_timeout = dt_mto})
push_stop_command(dt,		{device = devices.CONTROL_INTERFACE,	action = ctrl_commands.FlapSw,							value = -1.0})
push_stop_command(dt,		{message = _("THROTTLE - OFF"),			check_condition = F18_AD_LEFT_THROTTLE_DOWN_TO_IDLE,	message_timeout = dt_mto})
push_stop_command(dt,		{										check_condition = F18_AD_LEFT_THROTTLE_SET_TO_OFF})
push_stop_command(dt,		{message = _("L(R) DDI, AMPCD, HUD AND HMD KNOBS - OFF"),											message_timeout = dt_mto})
push_stop_command(dt,		{device = devices.MDI_LEFT,				action = MDI_commands.MDI_off_night_day,				value = 0.0})
push_stop_command(dt,		{device = devices.MDI_RIGHT,			action = MDI_commands.MDI_off_night_day,				value = 0.0})
push_stop_command(dt,		{device = devices.HUD,					action = HUD_commands.HUD_SymbBrightCtrl,				value = 0.0})
push_stop_command(dt, 		{device = devices.HMD_INTERFACE, 		action = hmd_commands.BrtKnob, 							value = 0.0})
push_stop_command(dt,		{device = devices.AMPCD,				action = AMPCD_commands.AMPCD_off_brightness,			value = 0.0})
push_stop_command(dt,		{message = _("THROTTLE - OFF"),			check_condition = F18_AD_RIGHT_THROTTLE_DOWN_TO_IDLE})
push_stop_command(dt,		{										check_condition = F18_AD_RIGHT_THROTTLE_SET_TO_OFF})
push_stop_command(dt,		{message = _("BATT SWITCH - OFF"),																message_timeout = dt_mto})
push_stop_command(dt,		{device = devices.ELEC_INTERFACE,		action = elec_commands.BattSw,							value = 0.0})


--
push_stop_command(3.0,	{message = _("AUTOSTOP COMPLETE"),	message_timeout = std_message_timeout})
--