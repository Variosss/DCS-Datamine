dofile(LockOn_Options.script_path.."clickable_defs.lua")
dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."sounds.lua")
--dofile(LockOn_Options.script_path.."Hint_localizer.lua")

local gettext = require("i_18n")
_ = gettext.translate

cursor_mode =
{
	CUMODE_CLICKABLE				= 0,
	CUMODE_CLICKABLE_AND_CAMERA		= 1,
	CUMODE_CAMERA					= 2,
};

clickable_mode_initial_status	= cursor_mode.CUMODE_CLICKABLE
use_pointer_name				= true

direction						= 1
cyclic_by_default				= true -- to cycle two-way thumblers or not by default

elements = {}
-----------------------------------------------------------------------------------------------
--handbrakes
elements["ROTOR-BRAKE-PTR"]		= default_animated_lever(_("Rotor Brake"),			devices.ENGINE_INTERFACE,	engine_commands.LEVER_Rotor_Lock,			745,	2)
elements["ENG-BRAKE-LEFT-PTR"]	= default_animated_lever(_("Left Engine Stop"),		devices.ENGINE_INTERFACE,	engine_commands.LEVER_Left_Engine_Lock,		6, 		2)
elements["ENG-BRAKE-LEFT-PTR"].turn_box = {0,0,-90}
elements["ENG-BRAKE-RIGHT-PTR"]	= default_animated_lever(_("Right Engine Stop"),	devices.ENGINE_INTERFACE,	engine_commands.LEVER_Right_Engine_Lock,	7, 		2)
elements["ENG-BRAKE-RIGHT-PTR"].turn_box = {0,0,-90}
--elements["ROTOR-BRAKE-BTN-PTR"]		= default_2_position_tumb(_("Rotor Brake button"),	devices.ENGINE_INTERFACE,	engine_commands.LEVER_Rotor_Lock_button,	744)
--engine levers
elements["RRUD-LEFT-PTR"]		= default_axis(_("Left Engine Throttle"),	devices.ENGINE_INTERFACE,	engine_commands.CONTROL_LEFT_THROTTLE_CLICK,	5,		0,	0.05,	true,	true,	false)
elements["RRUD-LEFT-PTR"].turn_box = {0,0,-90}
elements["RRUD-RIGHT-PTR"]		= default_axis(_("Right Engine Throttle"),	devices.ENGINE_INTERFACE,	engine_commands.CONTROL_RIGHT_THROTTLE_CLICK,	4,		0,	0.05,	true,	true,	false)
elements["RRUD-RIGHT-PTR"].turn_box = {0,0,-90}
--correction
--elements["COLLECTIVE-CORR-PTR"]	= default_axis(_("Throttle"),				devices.ENGINE_INTERFACE,	engine_commands.CONTROL_CORRECTION,				1000,		0,	0.05,	true,	true,	false)
elements["COLLECTIVE-CORR-PTR"]	= {
			class		= {class_type.LEV, class_type.LEV},
			hint		= _("Collective (LMB press, hold and move) / Throttle (RMB press, hold and move)"),
			device		= devices.ENGINE_INTERFACE,
			action		= {engine_commands.COLLECTIVE, engine_commands.CONTROL_CORRECTION},
			stop_action = {engine_commands.COLLECTIVE, engine_commands.CONTROL_CORRECTION},
			arg			= {0, 0},
			arg_value	= {0.0, 0.0},
			arg_lim		= {{-1, 1}, {-1, 1}},
			gain		= {0.1, 0.1},
			relative	= {true, true},
			updatable 	= true, 
			use_OBB 	= true,
			use_release_message	= {false, false},
			cycle		= false,
			crew_member_access  = {0}
}

elements["OP-COLL-THROTTLE-PTR"]	= {
			class		= {class_type.LEV, class_type.LEV},
			hint		= _("Collective (LMB press, hold and move) / Throttle (RMB press, hold and move)"),
			device		= devices.ENGINE_INTERFACE,
			action		= {engine_commands.OP_COLLECTIVE, engine_commands.OP_CONTROL_CORRECTION},
			stop_action = {engine_commands.OP_COLLECTIVE, engine_commands.OP_CONTROL_CORRECTION},
			arg			= {0, 0},
			arg_value	= {0.0, 0.0},
			arg_lim		= {{-1, 1}, {-1, 1}},
			gain		= {0.1, 0.1},
			relative	= {true, true},
			updatable 	= true, 
			use_OBB 	= true,
			use_release_message	= {false, false},
			cycle		= false,
			crew_member_access  = {1}
}

elements["COLLECTIVE-GOV-PTR"]	= springloaded_3_pos_tumb(_("Readjust Free Turbine RPM, RIGHT/NEUTRAL/LEFT"),				devices.ENGINE_INTERFACE,		engine_commands.READJUST_DOWN,	engine_commands.READJUST_UP,	747)

--HydroInterface
elements["HYDRO-MAIN-SECOND-PTR"]				= default_2_position_tumb(_("Main/Auxiliary Hydraulic Switch, MAIN/AUXILIARY"),			devices.HYDRO_SYS_INTERFACE,	hydraulic_commands.MainHydro,	217)
elements["HYDRO-MAIN-SECOND-PTR"].turn_box = {0,0,180}
elements["LANDING-GEAR-MAIN-BACKUP-PTR"]		= default_2_position_tumb(_("Main/Reserve Gear Hydraulic Switch, MAIN/RESERVE"),		devices.HYDRO_SYS_INTERFACE,	hydraulic_commands.GearHydro,	219)
elements["LANDING-GEAR-MAIN-BACKUP-PTR"].turn_box = {0,0,180}
elements["HYDRO-BACKUP-OFF-PTR"]				= default_button(_("Auxiliary Disable Button"),											devices.HYDRO_SYS_INTERFACE,	hydraulic_commands.DisableAuxiliaryHydro,	213)
elements["HYDRO-MAIN-SECOND-COVER-PTR"]			= default_blue_cover(_("Main/Auxiliary Hydraulic Switch Cover, UP/DOWN"),				devices.HYDRO_SYS_INTERFACE,	hydraulic_commands.MainHydroCover,	216)
elements["HYDRO-MAIN-SECOND-COVER-PTR"].turn_box = {90,0,0}
elements["LANDING-GEAR-MAIN-BACKUP-COVER-PTR"]	= default_blue_cover(_("Main/Reserve Gear Hydraulic Switch Cover, UP/DOWN"),			devices.HYDRO_SYS_INTERFACE,	hydraulic_commands.GearHydroCover,	218)
elements["LANDING-GEAR-MAIN-BACKUP-COVER-PTR"].turn_box = {90,0,0}
elements["HYDRO-BACKUP-OFF-COVER-PTR"]			= default_blue_cover(_("Auxiliary Disable Button Cover, UP/DOWN"),						devices.HYDRO_SYS_INTERFACE,	hydraulic_commands.DisableAuxiliaryHydroCover,	215)
elements["HYDRO-BACKUP-OFF-COVER-PTR"].turn_box = {0,180,0}

--fix!
elements[" CONTROL-COVER-PRIORITY-PTR"]			= default_blue_cover(_("Control Assumed Switch Cover, UP/DOWN"),								devices.HYDRO_SYS_INTERFACE,	hydraulic_commands.Hydro_Damper_Switch_PCover,	47)
elements[" CONTROL-COVER-PRIORITY-PTR"].turn_box = {0,90,0}
elements["CONTROL-PRIORITY-PTR"]				= default_2_position_tumb(_("Control Assumed Switch, ON/OFF"),								devices.HYDRO_SYS_INTERFACE,	hydraulic_commands.Hydro_Damper_Switch_P,	48)
elements["CONTROL-PRIORITY-PTR"].turn_box = {-90,0,-90}
--fix!
elements["PEDAL-DAMPER-COVER-PTR-PTR"]				= default_blue_cover(_("Pedal Damper Cover, UP/DOWN"),								devices.HYDRO_SYS_INTERFACE,	hydraulic_commands.Hydro_Damper_PCover,	289)
elements["PEDAL-DAMPER-COVER-PTR-PTR"].turn_box = {0,180,0}
--fix!
elements["PEDAL-DAMPER-COVER-PTR"]					= default_2_position_tumb(_("Pedal Damper, ON/OFF"),								devices.HYDRO_SYS_INTERFACE,	hydraulic_commands.Hydro_Damper_P,	290)
elements["PEDAL-DAMPER-COVER-PTR"].turn_box = {0,180,0}
elements["PEDAL-DAMPER-OP-COVER-PTR"]			= default_blue_cover(_("Pedal Damper Cover, UP/DOWN"),									devices.HYDRO_SYS_INTERFACE,	hydraulic_commands.Hydro_Damper_OCover,	666, nil, 1)
elements["PEDAL-DAMPER-OP-COVER-PTR"].turn_box = {180,0,0}
elements["PEDAL-DAMPER-OP-PTR"]					= default_2_position_tumb(_("Pedal Damper, ON/OFF"),									devices.HYDRO_SYS_INTERFACE,	hydraulic_commands.Hydro_Damper_O,	667, nil, 1)


elements["LANDING-GEAR-LIGHTS-PTR"]				= default_2_position_tumb(_("Gear Indication Lights ON/OFF"),			devices.CPT_MECH,		cockpit_mechanics_commands.Command_CPT_MECH_Gear_Pilot_LightsOff,	224)
elements["LANDING-GEAR-LIGHTS-PTR"].turn_box = {0,180,0}
elements["LANDING-GEAR-LIGHTS-COVER-PTR"]		= default_blue_cover(_("Gear Indication Lights Cover UP/DOWN"),			devices.CPT_MECH,		cockpit_mechanics_commands.Command_CPT_MECH_Gear_Pilot_LightsOff_Cover,	223)
elements["LANDING-GEAR-LIGHTS-COVER-PTR"].turn_box = {-90,0,0}

--CockpitMechanics
elements["LANDING-GEAR-PTR"]				= default_animated_lever(_("Gear Lever, UP/DOWN"),											devices.CPT_MECH,					cockpit_mechanics_commands.Command_CPT_MECH_Gear_Pilot,		232, 	4)
elements["LANDING-GEAR-LOCK-PTR"]			= default_animated_lever(_("Gear Lever Lock, UP/DOWN"),										devices.CPT_MECH,					cockpit_mechanics_commands.Command_CPT_MECH_Gear_Pilot_Lock,	228,	6)
elements["LANDING-GEAR-LOCK-PTR"].sound		= {{SOUND_SW7_UP, SOUND_SW7_DOWN}}
elements["LANDING-GEAR-LOCK-PTR"].turn_box = {0,0,180}
elements["LANDING-GEAR-OP-PTR"]				= default_2_position_tumb(_("Operator Gear Switch, UP/DOWN"),								devices.CPT_MECH,					cockpit_mechanics_commands.Command_CPT_MECH_Gear_Operator,						677, nil, 1)
elements["LANDING-GEAR-OP-COVER-PTR"]		= default_blue_cover(_("Operator Gear Switch Cover, UP/DOWN"),								devices.CPT_MECH,					cockpit_mechanics_commands.Command_CPT_MECH_Gear_Operator_Cover,				676, nil, 1)
elements["LANDING-GEAR-OP-COVER-PTR"].turn_box = {180,0,0}
elements["LANDING-GEAR-EMER-PTR"]			= default_animated_lever(_("Emergency Gear Lever"),											devices.CPT_MECH,					cockpit_mechanics_commands.Command_CPT_MECH_EmeregencyGear,						827)
elements["LANDING-GEAR-EMER-PTR"].turn_box = {0,0,90}
elements["WIPER-SPRINKLER-PTR"]				= default_button(_("Window Sprayer Button"),												devices.CPT_MECH,					cockpit_mechanics_commands.Command_CPT_MECH_WindSprayerPilot,					384)
elements["WIPER-SPRINKLER-OP-PTR"]			= default_button(_("Operator Window Sprayer Button"),										devices.CPT_MECH,			        cockpit_mechanics_commands.Command_CPT_MECH_WindSprayerOperator,				680, nil, 1)
elements["COLLECTIVE-FRICT-PTR"]			= default_button(_("friction clutch of the collective"),									devices.CPT_MECH,					cockpit_mechanics_commands.Command_CPT_MECH_CollectiveStopper,					753)
elements["COLLECTIVE-FRICT-PTR"].updatable = true
elements["CLOCK-HEATING-OP-PTR"]			= default_2_position_tumb(_("Clock Heating Switch, ON/OFF"),							    devices.CPT_MECH,					cockpit_mechanics_commands.Command_CPT_MECH_ClockHeatCPG,						672, nil, 1)
elements["DUAS-V-HEATING-OP-PTR"]			= default_2_position_tumb(_("Heating DUAS, ON/OFF"),									    devices.CPT_MECH,					cockpit_mechanics_commands.Command_CPT_MECH_PitotTotalAndAoASideslip,			763, nil, 1)
elements["HEATER-CLOCK-PTR"]				= default_2_position_tumb(_("Clock Heating Switch, ON/OFF"),								devices.CPT_MECH,					cockpit_mechanics_commands.Command_CPT_MECH_ClockHeatPLT,			386)
elements["HEATER-PPD-LEFT-PTR"]				= default_2_position_tumb(_("Heating PPD Left, ON/OFF"),									devices.CPT_MECH,					cockpit_mechanics_commands.Command_CPT_MECH_PitotTotalLeft,			387)
elements["HEATER-PPD-RIGHT-PTR"]			= default_2_position_tumb(_("Heating PPD Right, ON/OFF"),									devices.CPT_MECH,					cockpit_mechanics_commands.Command_CPT_MECH_PitotTotalRight,		389)

--IntLightSystem
elements["LTG-COCKPIT-OP-PTR"]				= default_3_position_tumb(_("Operator Cabin Lighting Switch, WHITE/OFF/RED"),														devices.INT_LIGHTS_SYSTEM,	int_lights_commands.OperatorCabinLightingWhiteRed,				682, nil , nil, nil, nil, nil, 1)
elements["LTG-COCKPIT-PTR"]					= default_3_position_tumb(_("Pilot Cabin Lighting Switch, WHITE/OFF/RED"),															devices.INT_LIGHTS_SYSTEM,	int_lights_commands.PilotCabinLightingWhiteRed,					356)
elements["LTG-WHITE-PTR"]					= default_2_position_tumb(_("Cargo Lighting Switch, ON/OFF"),																		devices.INT_LIGHTS_SYSTEM,	int_lights_commands.CargoWhiteLightingOn,						354)
elements["LTG-WHITE-COVER-PTR"]				= default_blue_cover(_("Cargo Lighting Switch Cover, UP/DOWN"),																		devices.INT_LIGHTS_SYSTEM,	int_lights_commands.CargoWhiteLightingOn_COVER,					353)
elements["LTG-WHITE-COVER-PTR"].turn_box = {0,180,0}
elements["LTG-CARGO-PTR"]					= default_3_position_tumb(_("Cargo Lighting Switch, WHITE/OFF/BLUE"),																devices.INT_LIGHTS_SYSTEM,	int_lights_commands.CargoLightingWhiteBlue,						355)
--elements[""]					= default_2_position_tumb(_("Radio Bay Lighting Switch, ON/OFF"),																	devices.INT_LIGHTS_SYSTEM,	int_lights_commands.RadioBayLightning,							)
--elements[""]					= default_2_position_tumb(_("Tailboom Lighting Switch, ON/OFF"),																	devices.INT_LIGHTS_SYSTEM,	int_lights_commands.TailboomLightning,							)
elements["LAMP-CONTROL-PTR"]				= default_button(_("Test Warning Lights Button"),																					devices.INT_LIGHTS_SYSTEM,	int_lights_commands.TestLightsPilot,							363)
elements["LAMP-CONTROL-OP-PTR"]				= default_button(_("Test Warning Lights Button"),																					devices.INT_LIGHTS_SYSTEM,	int_lights_commands.TestLightsOperator,							681, nil, 1)
elements["DAY-NIGHT-PTR"]					= default_2_position_tumb(_("Day-Night Switch, DAY/NIGHT"),																			devices.INT_LIGHTS_SYSTEM,	int_lights_commands.DayNight,									362)    
elements["FLASHER-PTR"]						= default_2_position_tumb(_("Blinker Switch, ON/OFF"),																				devices.INT_LIGHTS_SYSTEM,	int_lights_commands.BlinkerSystem,								364)
elements["RED-LTG1-PTR"]					= multiposition_switch(_("Transformer 1 Group Of Red Lights Right And Pilot Panel, OFF/8V/9V/10V/11V/12V/13V/14V/16V/18V/20V"),		devices.INT_LIGHTS_SYSTEM,	int_lights_commands.RedLightsPilotInstrumentPanelRightPanel_1,	148,		11,		0.1, 		false,   0.0,	anim_speed_default,			false)
elements["RED-LTG1-PTR"].turn_box = {0,-30,0}
elements["RED-LTG2-PTR"]					= multiposition_switch(_("Transformer 2 Group Of Red Lights Right And Pilot Panel, OFF/8V/9V/10V/11V/12V/13V/14V/16V/18V/20V"),		devices.INT_LIGHTS_SYSTEM,	int_lights_commands.RedLightsPilotInstrumentPanelRightPanel_2,	147,		11,		0.1, 		false,   0.0,	anim_speed_default,			false)
elements["RED-LTG2-PTR"].turn_box = {0,-30,0}
elements["AUX-LTG-PTR"]						= default_2_position_tumb(_("Armament Panel Red Lights Switch, ON/OFF"),															devices.INT_LIGHTS_SYSTEM,	int_lights_commands.SpecialEquipmentPanelRedLights,				822)
elements["AUX-LTG-PTR"].turn_box = {-90,0,-90}
elements["RED-LTG4-PTR"]					= multiposition_switch(_("Transformer 1 Group Of Red Lights Left Pilot Panel, OFF/8V/9V/10V/11V/12V/13V/14V/16V/18V/20V"),			devices.INT_LIGHTS_SYSTEM,	int_lights_commands.RedLightsPilotLeftPanel_1,					820,		11,		0.1, 		false,   0.0,	anim_speed_default,			false)
elements["RED-LTG4-PTR"].turn_box = {-90,0,0}
elements["RED-LTG5-PTR"]					= multiposition_switch(_("Transformer 2 Group Of Red Lights Left Pilot Panel, OFF/8V/9V/10V/11V/12V/13V/14V/16V/18V/20V"),			devices.INT_LIGHTS_SYSTEM,	int_lights_commands.RedLightsPilotLeftPanel_2,					503,		11,		0.1, 		false,   0.0,	anim_speed_default,			false)
elements["RED-LTG5-PTR"].turn_box = {-90,0,0}
elements["RED-LTG1-OP-PTR"]					= multiposition_switch(_("Transformer 1 Group Of Red Lights Left And Operator Panel, OFF/8V/9V/10V/11V/12V/13V/14V/16V/18V/20V"),	devices.INT_LIGHTS_SYSTEM,	int_lights_commands.RedLightsOperatorPanel_1,					1013,		11,		0.1, 		false,   0.0,	anim_speed_default,			false, 1)
elements["RED-LTG1-OP-PTR"].turn_box = {0,-135,0}
elements["RED-LTG2-OP-PTR"]					= multiposition_switch(_("Transformer 2 Group Of Red Lights Left And Operator Panel, OFF/8V/9V/10V/11V/12V/13V/14V/16V/18V/20V"),	devices.INT_LIGHTS_SYSTEM,	int_lights_commands.RedLightsOperatorPanel_2,					1014,		11,		0.1, 		false,   0.0,	anim_speed_default,			false, 1)
elements["RED-LTG2-OP-PTR"].turn_box = {0,-135,0}
--elements[""]					= default_2_position_tumb(_("Operator Panel Lights Switch, ON/OFF"),																devices.INT_LIGHTS_SYSTEM,	int_lights_commands.OperatorPanelRedLights,						)
elements["RED-LTG3-PTR"]					= multiposition_switch(_("Builtin Red Lights Transformer, OFF/0.6V/1.2V/1.8V/2.4V/3V/3.6V/4.2V/4.8V/5.4V/6V"),						devices.INT_LIGHTS_SYSTEM,	int_lights_commands.RedLightsPilotBuiltInRedLights,				149,		11,		0.1, 		false,   0.0,	anim_speed_default,			false)
elements["RED-LTG3-PTR"].turn_box = {0,-30,0}

--ExtLightsSystem
elements["TAXILIGHT-RETR-PTR"]				= default_3_position_tumb(_("LND LT Control-Off-Retract switch"),				devices.EXT_LIGHTS_SYSTEM,		ext_lights_commands.HeadlightControl,	208)
elements["TAXILIGHT-PTR"]					= default_2_position_tumb(_("Taxi LT Switch, ON/OFF"),							devices.EXT_LIGHTS_SYSTEM,		ext_lights_commands.PilotTaxiLight,		34)
elements["TAXILIGHT-OP-PTR"]				= default_2_position_tumb(_("Operator Taxi LT Switch, ON/OFF"),					devices.EXT_LIGHTS_SYSTEM,		ext_lights_commands.OperatorTaxiLight,	686, nil, 1)
elements["NAVLIGHT-BRIGHT-DIM-OFF-PTR"]		= default_3_position_tumb(_("Navigation Lights Switch, BRIGHT/OFF/DIM"),		devices.EXT_LIGHTS_SYSTEM,		ext_lights_commands.NavLtSwitch,	207)
elements["CODE-NAVLIGHT-PTR"]				= default_button(_("Navigation Lights Code Button"),							devices.EXT_LIGHTS_SYSTEM,		ext_lights_commands.NavCodeButton,	35)
elements["FORMATION-LIGHTS-PTR"]			= default_3_position_tumb(_("Formation Lights Switch, BRIGHT/OFF/DIM"),			devices.EXT_LIGHTS_SYSTEM,		ext_lights_commands.FormationLights,	414)
elements["ROTOR-LIGHTS-PTR"]				= default_2_position_tumb(_("Tip Lights Switch, ON/OFF"),						devices.EXT_LIGHTS_SYSTEM,		ext_lights_commands.TipLights,	415)
elements["STROBE-TAIL-PTR"]					= default_2_position_tumb(_("Strobe Light Switch, ON/OFF"),						devices.EXT_LIGHTS_SYSTEM,		ext_lights_commands.StrobeLight,	417)
elements["CONTROL-HEADLIGHT-OP-COVER-PTR"]	= default_blue_cover(_("LND Light Assumed Switch Cover, OPEN/CLOSE"),			devices.EXT_LIGHTS_SYSTEM,		ext_lights_commands.Headlight_Operator_Switch_PCover,	668, nil, 1)
elements["CONTROL-HEADLIGHT-OP-COVER-PTR"].turn_box = {0,0,180}
elements["CONTROL-HEADLIGHT-OP-PTR"]		= default_2_position_tumb(_("LND Light Assumed Switch, ON/OFF"),				devices.EXT_LIGHTS_SYSTEM,		ext_lights_commands.Headlight_Operator_Switch,	669, nil, 1)

--ECSystem
elements["CABIN-DEPRESS-PTR"]	= default_2_position_tumb(_("Cabin Unseal Switch, ON/OFF"),									devices.ECS_INTERFACE,			ecs_commands.CabinUnseal,			133)
elements["CABIN-DEPRESS-PTR"].turn_box = {-90,0,-90}
elements["AC-MODE-PTR"]			= default_3_position_tumb(_("Blowdown Conditioning Switch, CONDITIONING/OFF/BLOWDOWN"),		devices.ECS_INTERFACE,			ecs_commands.BlowdownConditioning,	134)
elements["AC-MODE-PTR"].turn_box = {-90,0,-90}
elements["AC-FILTER-PTR"]		= default_2_position_tumb(_("Filter Switch, ON/OFF"),										devices.ECS_INTERFACE,			ecs_commands.Filter,				143)
elements["AC-FILTER-PTR"].turn_box = {-90,0,-90}
elements["AC-HEATER1-MODE-PTR"]	= default_2_position_tumb(_("Heating Switch, HOT/NORMAL"),									devices.ECS_INTERFACE,			ecs_commands.Heating,				144)
elements["AC-HEATER1-MODE-PTR"].turn_box = {-90,0,-90}
elements["AC-HEATER2-MODE-PTR"]	= multiposition_switch(_("Automatic Hot Cold Switch, OFF/COLD/HOT/AUTO"),					devices.ECS_INTERFACE,			ecs_commands.AutomaticHotCold,		145,	4,	0.1,	false,	0.0,	anim_speed_default,	false)
elements["AC-HEATER2-MODE-PTR"].turn_box = {0,-120,0}
elements["AC-TEMP-KNOB-PTR"]	= multiposition_switch(_("Temperature Selector, 5/10/15/18/20/22/24/30/35/40/50"),			devices.ECS_INTERFACE,			ecs_commands.Temperature,			146,	11,	1/9,	false,	0.0,	anim_speed_default,	false)
elements["AC-TEMP-KNOB-PTR"].turn_box = {0,-30,0}
elements["WEAP-MISSILES-SIGHT-FAN-OP-PTR"]	= default_2_position_tumb(_("Sight Fan, ON/OFF"),								devices.ECS_INTERFACE,			ecs_commands.HeatingAirFlowSight,	774, nil, 1)

-- sealing cockpit open (close):
elements["CABIN-PRESS-VALVE-PTR"]= default_axis_limited(_("Sealing, OPEN/CLOSE"),	devices.ECS_INTERFACE,	ecs_commands.Sealing_valve, 516,	0,	0.1)

--PKP72M_interface		--TODO: arguments
elements["GYRO-SEL-PTR"]			= default_2_position_tumb(_("Gyrovertical Switch, 1/2"),									devices.PKP72M_INTERFACE,			pkp72m_interface_commands.GyroverticalSwitch,	12)
elements["GYRO-SEL-PTR"].turn_box = {0,0,-90}
elements["PKP-POWER-OP-PTR"]		= default_2_position_tumb(_("ADI Switch, ON/OFF"),											devices.PKP72M_INTERFACE,			pkp72m_interface_commands.PKP72MoperatorSwitch,	759, nil, 1)

--PKP72M_pilot			--TODO: arguments
elements["PKP-TEST-PTR"]			= default_button(_("Test ADI Button"),			devices.PKP72M_P,	pkp72m_commands.TestControl,	946)
elements["PKP-TEST-PTR"].turn_box = {-90,-90,0}
elements["PKP-INIT-PITCH-KNOB-PTR"]	= default_axis_limited(_("Pitch Trim Knob"),	devices.PKP72M_P,	pkp72m_commands.PitchTrimKnob,	941,		0,		0.02)
elements["PKP-INIT-PITCH-KNOB-PTR"].turn_box = {-90,-90,0}

--PKP72M_operator		--TODO: arguments
elements["PKP-TEST-OP-PTR"]			= default_button(_("Test ADI Button"),			devices.PKP72M_O,	pkp72m_commands.TestControl,    787, nil, 1)
elements["PKP-TEST-OP-PTR"].turn_box = {-90,-90,0}
elements["PKP-INIT-PITCH-KNOB-OP-PTR"]	= default_axis_limited(_("Pitch Trim Knob"),devices.PKP72M_O,	pkp72m_commands.PitchTrimKnob,  782,		0,		0.02, nil, nil, nil, nil, nil, 1)
elements["PKP-INIT-PITCH-KNOB-OP-PTR"].turn_box = {-90,-90,0}

--MGV1SU both
elements["GYRO1-CAGE-PTR"]		= default_button(_("Cage Gyro 1"),						devices.MGV1SU_1,	mgv1su_commands.CAGE,		10)
elements["GYRO1-CAGE-PTR"].turn_box = {90,0,-90}
elements["GYRO2-CAGE-PTR"]		= default_button(_("Cage Gyro 2"),						devices.MGV1SU_2,	mgv1su_commands.CAGE,		14)
elements["GYRO2-CAGE-PTR"].turn_box = {90,0,-90}
elements["MGV1-POWER-PTR"]		= default_2_position_tumb(_("Gyro 1 Power, ON/OFF"),	devices.MGV1SU_1,	mgv1su_commands.POWER,		369)
elements["MGV2-POWER-PTR"]		= default_2_position_tumb(_("Gyro 2 Power, ON/OFF"),	devices.MGV1SU_2,	mgv1su_commands.POWER,		368)

elements["GYRO-CAGE-OP-PTR"]	= default_button(_("Cage Gyro 2"),						devices.MGV1SU_2,	mgv1su_commands.CAGE_OP,	701, nil, 1)

elements["STICK-BRAKE-PTR"]	= stick_button(_("Wheel Brakes Handle"), devices.CPT_MECH, cockpit_mechanics_commands.Command_CPT_MECH_WheelBrake, 737)
elements["STICK-BRAKE-PTR"].updatable 	= true
elements["STICK-BRAKE-PTR"].crew_member_access  = {0}


elements["STICK-BRAKE-FIX-PTR"]	= default_2_position_tumb(_("Parking Brake Handle"), devices.CPT_MECH, cockpit_mechanics_commands.Command_CPT_MECH_ParkingBrake, 736)
elements["STICK-BRAKE-FIX-PTR"].updatable 	= true
elements["STICK-BRAKE-FIX-PTR"].use_OBB = true
elements["STICK-BRAKE-FIX-PTR"].side = {}

--UKT2					--TODO: arguments
elements["UKT-KNOB-PTR"]	= default_axis_limited(_("Pitch Trim Knob"),	devices.UKT_2,	ukt2_commands.PitchTrimKnob, 	951,		0,		0.02)
elements["UKT-KNOB-PTR"].turn_box = {-90,-90,0}

--Barometric Altimeter Pilot		--TODO: arguments
elements["ALTIMETER-KNOB-PTR"]	= default_axis(_("Baro Pressure Knob"),		devices.BAROALT_P,	baroaltimeter_commands.CMD_ADJUST_PRESSURE, 18, 1, 0.6, false, true, nil, nil)
elements["ALTIMETER-KNOB-PTR"].turn_box = {-90,-90,0}
--Barometric Altimeter Operator	
elements["ALTIMETER-KNOB-OP-PTR"] = default_axis(_("Operator Baro Pressure Knob"),		devices.BAROALT_O,	baroaltimeter_commands.CMD_ADJUST_PRESSURE, 788, 1, 0.6, false, true, nil, nil, nil, 1)
elements["ALTIMETER-KNOB-OP-PTR"].turn_box = {-90,-90,0}

--RMI2 pilot			--TODO: arguments
--elements[""]			= default_2_position_tumb(_("Mode Switch, ARK1"),											devices.RMI2_P,						rmi2_commands.MODE_LEFTSW,														)
elements["RMI-KUR-2-PTR"]	= default_2_position_tumb(_("Mode Switch, ZK/ARKU2"),	devices.RMI2_P,	rmi2_commands.MODE_RIGHTSW,	26)
elements["RMI-KUR-2-PTR"].turn_box = {-90,0,90}

--RMI2 operator			--TODO: arguments
--elements[""]			= default_2_position_tumb(_("Mode Switch, ARK1"),											devices.RMI2_O,						rmi2_commands.MODE_LEFTSW,														)
elements["ZK_ARK_U005"]	= default_2_position_tumb(_("Mode Switch, ZK/ARKU2"),	devices.RMI2_O,	rmi2_commands.MODE_RIGHTSW, 843, nil, 1)
elements["ZK_ARK_U005"].turn_box = {-90,-45,0}

---- CLOCK_pilot					--TODO: arguments
elements["CLOCK-LEFT-PTR"] = {
	class					= {class_type.BTN, class_type.BTN, class_type.LEV},
	hint					= _("Mech clock left lever"),
	device					= devices.CLOCK_P, 
	action					= {device_commands.Button_1, device_commands.Button_2, device_commands.Button_3},
	stop_action				= {device_commands.Button_1, device_commands.Button_2, 0},
	is_repeatable			= {},
	arg						= {57, 57, 58},
	arg_value				= {1.0, -1.0, 1.0},
	arg_lim					= {{0, 1}, {-1, 0}, {0, 1}},
	relative				= {false,false,true},
	gain					= {1.0, 1.0, 0.05},
	use_release_message		= {true, true, false},
	use_OBB					= true,
	sound					= {{SOUND_CLOCK_SW14_OFF,SOUND_CLOCK_SW16},{SOUND_CLOCK_SW14_ON,SOUND_CLOCK_SW14_OFF}, {SOUND_CLOCK_SW15}},
	side					= {{BOX_SIDE_Y_bottom},{BOX_SIDE_Y_top},{BOX_SIDE_X_top, BOX_SIDE_X_bottom, BOX_SIDE_Z_top, BOX_SIDE_Z_bottom}},
	attach_left				= {80,-45},
	turn_box				= {-90,-90,0},
	crew_member_access  = {0}
}

elements["CLOCK-RIGHT-PTR"] = {
	class					= {class_type.BTN, class_type.LEV},
	hint					= _("Mech clock right lever"),
	device					= devices.CLOCK_P,
	action					= {device_commands.Button_4, device_commands.Button_5},
	stop_action				= {device_commands.Button_4, 0},
	is_repeatable			= {},
	arg						= {59, 60},
	arg_value				= {1.0, 0.05},
	arg_lim					= {{0, 1}, {-0.15, 0.15}},
	gain					= {1.0, 1.2},
	use_release_message		= {true, false},
	use_OBB					= true,
	sound					= {{SOUND_CLOCK_SW14_OFF,SOUND_CLOCK_SW14_ON},{SOUND_CLOCK_SW13_ON,SOUND_CLOCK_SW13_OFF}},
	side					= {{BOX_SIDE_Y_bottom},{BOX_SIDE_X_top, BOX_SIDE_X_bottom, BOX_SIDE_Z_top, BOX_SIDE_Z_bottom}},
	attach_left				= {80,-45},
	turn_box				= {-90,-90,0},
	crew_member_access  = {0}
}

---- CLOCK_operator					--TODO: arguments
elements["CLOCK-LEFT-OP-PTR"] = {
    class = {class_type.BTN, class_type.BTN, class_type.LEV},
    hint = _("Mech clock left lever"),
    device = devices.CLOCK_O,
    action = {device_commands.Button_1, device_commands.Button_2, device_commands.Button_3},
    stop_action = {device_commands.Button_1, device_commands.Button_2, 0},
    is_repeatable = {},
    arg = {687, 687, 688},
    arg_value = {1.0, -1.0, 1.0},
    arg_lim = {{0, 1}, {-1, 0}, {0, 1}},
    relative = {false,false,true},
    gain = {1.0, 1.0, 0.05},
    use_release_message = {true, true, false},
    use_OBB = true,
    sound = {{SOUND_CLOCK_SW14_OFF,SOUND_CLOCK_SW16},{SOUND_CLOCK_SW14_ON,SOUND_CLOCK_SW14_OFF}, {SOUND_CLOCK_SW15}},
	side				= {{BOX_SIDE_Y_bottom},{BOX_SIDE_Y_top},{BOX_SIDE_X_top, BOX_SIDE_X_bottom, BOX_SIDE_Z_top, BOX_SIDE_Z_bottom}},
	crew_member_access  = {1}
}
--
elements["CLOCK-RIGHT-OP-PTR"] = {
    class = {class_type.BTN, class_type.LEV},
    hint = _("Mech clock right lever"),
    device = devices.CLOCK_O,
    action = {device_commands.Button_4, device_commands.Button_5},
    stop_action = {device_commands.Button_4, 0},
    is_repeatable = {},
    arg = {693, 694},
    arg_value = {1.0, 0.05},
    arg_lim = {{0, 1}, {-0.15, 0.15}},
    gain = {1.0, 1.2},
    use_release_message = {true, false},
    use_OBB = true,
    sound = {{SOUND_CLOCK_SW14_OFF,SOUND_CLOCK_SW14_ON},{SOUND_CLOCK_SW13_ON,SOUND_CLOCK_SW13_OFF}},
	side				= {{BOX_SIDE_Y_bottom},{BOX_SIDE_X_top, BOX_SIDE_X_bottom, BOX_SIDE_Z_top, BOX_SIDE_Z_bottom}},
	crew_member_access  = {1}
}

--electric interface
--DC
elements["BATT-RIGHT-PTR"]			=	default_2_position_tumb(_("Right Battery switch, ON/OFF"),			devices.ELEC_INTERFACE,		elec_commands.BatteryRight,					61)
elements["BATT-RIGHT-PTR"].turn_box = {-90,0,-90}
elements["RECT-LEFT-PTR"]			=	default_2_position_tumb(_("Left Rectifier switch, ON/OFF"),			devices.ELEC_INTERFACE,		elec_commands.RectifierLeft,				62)
elements["RECT-LEFT-PTR"].turn_box = {-90,0,-90}
elements["RECT-RIGHT-PTR"]			=	default_2_position_tumb(_("Right Rectifier switch, ON/OFF"),		devices.ELEC_INTERFACE,		elec_commands.RectifierRight,				65)
elements["RECT-RIGHT-PTR"].turn_box = {-90,0,-90}
elements["STARTER-GEN-PTR"]			=	default_2_position_tumb(_("APU Generator switch, ON/OFF"),			devices.ELEC_INTERFACE,		elec_commands.DCGenerator,					66)
elements["STARTER-GEN-PTR"].turn_box = {-90,0,-90}
elements["VOLT-DC-KNOB-PTR"]		=	multiposition_switch(_("DC Voltmeter knob"),						devices.ELEC_INTERFACE,		elec_commands.DCGangSwitcher,				69,	10, 1/10, false, 0, nil, false)
elements["VOLT-DC-KNOB-PTR"].turn_box = {0,-30,0}
elements["NET-TO-BATT-COVER-PTR"]	=	default_blue_cover(_("Network to Batteries cover, UP/DOWN"),		devices.ELEC_INTERFACE,		elec_commands.NetworkToBatteriesCover,		70)
elements["NET-TO-BATT-COVER-PTR"].turn_box = {0,90,0}
elements["NET-TO-BATT-PTR"]			=	default_2_position_tumb(_("Network to Batteries, ON/OFF"),			devices.ELEC_INTERFACE,		elec_commands.NetworkToBatteries,			71)
elements["NET-TO-BATT-PTR"].turn_box = {-90,0,-90}
elements["GROUND-DC-PTR"]			=	default_2_position_tumb(_("DC Ground Power, ON/OFF"),				devices.ELEC_INTERFACE,		elec_commands.DCGroundPower,				73)
elements["GROUND-DC-PTR"].turn_box = {-90,0,-90}
elements["BATT-HEATING-PTR"]		=	default_2_position_tumb(_("Battery Heating, ON/OFF"),				devices.ELEC_INTERFACE,		elec_commands.BatteryHeating,				74)
elements["BATT-HEATING-PTR"].turn_box = {-90,0,-90}
elements["BATT-LEFT-PTR"]			=	default_2_position_tumb(_("Left Battery switch, ON/OFF"),			devices.ELEC_INTERFACE,		elec_commands.BatteryLeft,					75)
elements["BATT-LEFT-PTR"].turn_box = {-90,0,-90}
--AC
elements["GEN-RIGHT-PTR"]			=	default_2_position_tumb(_("Right Generator switch, ON/OFF"),		devices.ELEC_INTERFACE,		elec_commands.ACGeneratorRight,				80)
elements["GEN-RIGHT-PTR"].turn_box = {-90,0,-90}
elements["TRANS115-PTR"]			=	default_3_position_tumb(_("AC Transformer 115v, MAIN/AUTO/BACKUP"),	devices.ELEC_INTERFACE,		elec_commands.Transformer115vMainBackup,	83)--, false, nil, false, 0.5, {0, 1})
elements["TRANS115-PTR"].turn_box = {-90,0,-90}
elements["TRANS36-PTR"]				=	default_3_position_tumb(_("AC Transformer 36v, MAIN/AUTO/BACKUP"),	devices.ELEC_INTERFACE,		elec_commands.Transformer36vMainBackup,		85)--, false, nil, false, 0.5, {0, 1})
elements["TRANS36-PTR"].turn_box = {-90,0,-90}
elements["GROUND-AC-PTR"]			=	default_2_position_tumb(_("AC Ground Power, ON/OFF"),				devices.ELEC_INTERFACE,		elec_commands.ACGroundPower,				87)
elements["GROUND-AC-PTR"].turn_box = {-90,0,-90}
elements["GROUND-RECT-COVER-PTR"]	=	default_blue_cover(_("AC Ground Check Cover, UP/DOWN"),				devices.ELEC_INTERFACE,		elec_commands.GroundCheckCover,				88)
elements["GROUND-RECT-COVER-PTR"].turn_box = {0,90,0}
elements["GROUND-RECT-PTR"]			=	default_2_position_tumb(_("AC Ground Check, ON/OFF"),				devices.ELEC_INTERFACE,		elec_commands.GroundCheck,					89)
elements["GROUND-RECT-PTR"].turn_box = {-90,0,-90}
elements["VOLT-AC-KNOB-PTR"]		=	multiposition_switch(_("AC Voltmeter knob"),						devices.ELEC_INTERFACE,		elec_commands.ACGangSwitcher,				91,	11, 1/10, false, 0, nil, false)
elements["VOLT-AC-KNOB-PTR"].turn_box = {0,180,0}
elements["INV115-COVER-PTR"]		=	default_blue_cover(_("Inverter PO-750A Cover, UP/DOWN"),			devices.ELEC_INTERFACE,		elec_commands.Rotary115vConverterCover,		97)
elements["INV115-COVER-PTR"].turn_box = {0,90,0}
elements["INV115-PTR"]				=	default_2_position_tumb(_("Inverter PO-750A, ON/OFF"),				devices.ELEC_INTERFACE,		elec_commands.Rotary115vConverter,			98)
elements["INV115-PTR"].turn_box = {-90,0,-90}
elements["INV36-COVER-PTR"]			=	default_blue_cover(_("Inverter PT-125Ts Cover, UP/DOWN"),			devices.ELEC_INTERFACE,		elec_commands.Rotary36vConverterCover,		99)
elements["INV36-COVER-PTR"].turn_box = {0,90,0}
elements["INV36-PTR"]				=	default_2_position_tumb(_("Inverter PT-125Ts, ON/OFF"),				devices.ELEC_INTERFACE,		elec_commands.Rotary36vConverter,			100)
elements["INV36-PTR"].turn_box = {-90,0,-90}
elements["GEN-LEFT-PTR"]			=	default_2_position_tumb(_("Left Generator switch, ON/OFF"),			devices.ELEC_INTERFACE,		elec_commands.ACGeneratorLeft,				101)
elements["GEN-LEFT-PTR"].turn_box = {-90,0,-90}
elements["TRANS-DIM-PTR"]			=	default_2_position_tumb(_("DIM Transformer switch, MAIN/BACKUP"),	devices.ELEC_INTERFACE,		elec_commands.Transformer36vDIMMainBackup,	196)
elements["TRANS-DIM-PTR"].turn_box = {-90,0,-90}

--goddamn CBs
elements["CB-FRAME-RIGHT-1-PTR"]		=	default_button(_("All Right CBs ON"),	devices.ELEC_INTERFACE,	elec_commands.CB_FRAME_RIGHT,	632, anim_speed_default / 5)
elements["CB-FRAME-RIGHT-1-PTR"].sound = {{SOUND_SW1_FULL, SOUND_SW1_FULL_OFF}}
elements["CB-FRAME-LEFT-1-PTR"]			=	default_button(_("All Left CBs ON"),	devices.ELEC_INTERFACE,	elec_commands.CB_FRAME_LEFT,	601, anim_speed_default / 5)
elements["CB-FRAME-LEFT-1-PTR"].sound = {{SOUND_SW1_FULL, SOUND_SW1_FULL_OFF}}

elements["CB-RIGHT-CONTROL-FORCE-MECHANISM-PTR"]		= default_2_position_tumb(_("CB Control Force Grad, ON/OFF"),				devices.ELEC_INTERFACE,		elec_commands.CB_RIGHT_CONTROL_FORCE_MECHANISM,	602)
elements["CB-RIGHT-CONTROL-CLUTCH-PTR"]					= default_2_position_tumb(_("CB Collective Lever Lock, ON/OFF"),				devices.ELEC_INTERFACE,		elec_commands.CB_RIGHT_CONTROL_CLUTCH,	603)
elements["CB-RIGHT-ENGINE-TEMP-ADJUST-LEFT-PTR"]		= default_2_position_tumb(_("CB Temperature Control Left Governor RPM, ON/OFF"),				devices.ELEC_INTERFACE,		elec_commands.CB_RIGHT_ENGINE_TEMP_ADJUST_LEFT,	604)
elements["CB-RIGHT-ENGINE-TEMP-ADJUST-RIGHT-PTR"]		= default_2_position_tumb(_("CB Temperature Control Right Governor RPM, ON/OFF"),				devices.ELEC_INTERFACE,		elec_commands.CB_RIGHT_ENGINE_TEMP_ADJUST_RIGHT,	605)
elements["CB-RIGHT-ROTOR-RPM-ADJUST-PTR"]				= default_2_position_tumb(_("CB Rotor RPM Adjust, ON/OFF"),				devices.ELEC_INTERFACE,		elec_commands.CB_RIGHT_ROTOR_RPM_ADJUST,	606)
elements["CB-RIGHT-ARMAMENT-SIGNAL-PTR"]				= default_2_position_tumb(_("CB Signal, ON/OFF"),				devices.ELEC_INTERFACE,		elec_commands.CB_RIGHT_ARMAMENT_SIGNAL,	607)
elements["CB-RIGHT-ARMAMENT-CAMERA-SHUTTER-PTR"]		= default_2_position_tumb(_("CB Camera, ON/OFF"),				devices.ELEC_INTERFACE,		elec_commands.CB_RIGHT_ARMAMENT_CAMERA_SHUTTER,	608)
elements["CB-RIGHT-ARMAMENT-CONTROL-PTR"]				= default_2_position_tumb(_("CB Armament Control, ON/OFF"),				devices.ELEC_INTERFACE,		elec_commands.CB_RIGHT_ARMAMENT_CONTROL,	609)
elements["CB-RIGHT-ARMAMENT-CANNON-PTR"]				= default_2_position_tumb(_("CB Cannon, ON/OFF"),				devices.ELEC_INTERFACE,		elec_commands.CB_RIGHT_ARMAMENT_CANNON,	610)

elements["CB-RIGHT-FIRE-2-AUTO-PTR"]					= default_2_position_tumb(_("CB Squib-2 Auto Fire Protection, ON/OFF"),				devices.ELEC_INTERFACE,		elec_commands.CB_RIGHT_FIRE_2_AUTO,	611)
elements["CB-RIGHT-FIRE-2-MANUAL-PTR"]					= default_2_position_tumb(_("CB Squib-2 Manual Fire Protection, ON/OFF"),				devices.ELEC_INTERFACE,		elec_commands.CB_RIGHT_FIRE_2_MANUAL,	612)
elements["CB-RIGHT-EXT-STORES-TACTICAL-DROP-PTR"]		= default_2_position_tumb(_("CB External Stores Tactical Release, ON/OFF"),				devices.ELEC_INTERFACE,		elec_commands.CB_RIGHT_EXT_STORES_TACTICAL_DROP,	613)
elements["CB-RIGHT-EXT-STORES-LOCK-RELEASE-PTR"]		= default_2_position_tumb(_("CB External Stores Release Lock, ON/OFF"),				devices.ELEC_INTERFACE,		elec_commands.CB_RIGHT_EXT_STORES_LOCK_RELEASE,	614)
elements["CB-RIGHT-GEAR-EXTENT-HANDLE-BACKUP-PTR"]		= default_2_position_tumb(_("CB Landing Gear Valve, ON/OFF"),				devices.ELEC_INTERFACE,		elec_commands.CB_RIGHT_GEAR_EXTENT_HANDLE_BACKUP,	615)

elements["CB-RIGHT-LAUNCHER-DETACH-PTR"]				= default_2_position_tumb(_("CB Jettison Missile Rails, ON/OFF"),				devices.ELEC_INTERFACE,		elec_commands.CB_RIGHT_LAUNCHER_DETACH,	616)
elements["CB-RIGHT-BOMB-COMBAT-DROP-PTR"]				= default_2_position_tumb(_("CB Bombs Release, ON/OFF"),				devices.ELEC_INTERFACE,		elec_commands.CB_RIGHT_BOMB_COMBAT_DROP,	617)
elements["CB-RIGHT-CONNECTION-DISTRIBUTION-DEVICE-PTR"]	= default_2_position_tumb(_("CB Connection Distribution Device, ON/OFF"),				devices.ELEC_INTERFACE,		elec_commands.CB_RIGHT_CONNECTION_DISTRIBUTION_DEVICE,	618)
elements["CB-RIGHT-PILOT-AIM-PTR"]						= default_2_position_tumb(_("PILOT SIGHT CB, ON/OFF"),						devices.ELEC_INTERFACE,		elec_commands.CB_RIGHT_PILOT_AIM,	619)
elements["CB-RIGHT-DUAS-V-HEATING-PTR"]					= default_2_position_tumb(_("CB Air Data Computer Heating, ON/OFF"),				devices.ELEC_INTERFACE,		elec_commands.CB_RIGHT_DUAS_V_HEATING,	620)

elements["CB-RIGHT-EMERGENCY-DOOR-DETACH-PILOT-PTR"]	= default_2_position_tumb(_("CB Jettison Pilot´s Door, ON/OFF"),				devices.ELEC_INTERFACE,		elec_commands.CB_RIGHT_EMERGENCY_DOOR_DETACH_PILOT,	621)
elements["CB-RIGHT-EMERGENCY-DOOR-DETACH-OP-PTR"]		= default_2_position_tumb(_("CB Jettision Gunners Door, ON/OFF"),				devices.ELEC_INTERFACE,		elec_commands.CB_RIGHT_EMERGENCY_DOOR_DETACH_OP,	622)
elements["CB-RIGHT-CONDITIONER-CONTROL-PTR"]			= default_2_position_tumb(_("CB Air Conditioning, ON/OFF"),				devices.ELEC_INTERFACE,		elec_commands.CB_RIGHT_CONDITIONER_CONTROL,	623)
elements["CB-RIGHT-FUEL-METER-PTR"]						= default_2_position_tumb(_("CB Fuel Quantity Indication, ON/OFF"),				devices.ELEC_INTERFACE,		elec_commands.CB_RIGHT_FUEL_METER,	624)
elements["CB-RIGHT-VALVE-TANK-2-PTR"]					= default_2_position_tumb(_("CB Fuel Tank 2 Valve, ON/OFF"),				devices.ELEC_INTERFACE,		elec_commands.CB_RIGHT_VALVE_TANK_2,	625)
elements["CB-RIGHT-VALVE-FIRE-RIGHT-PTR"]				= default_2_position_tumb(_("CB Fuel Tank 2 Shutoff Valve, ON/OFF"),				devices.ELEC_INTERFACE,		elec_commands.CB_RIGHT_VALVE_FIRE_RIGHT,	626)
elements["CB-RIGHT-PUMP-TANK-2-PTR"]					= default_2_position_tumb(_("CB Fuel Pump 2, ON/OFF"),				devices.ELEC_INTERFACE,		elec_commands.CB_RIGHT_PUMP_TANK_2,	627)
elements["CB-RIGHT-PUMP-TANK-4-PTR"]					= default_2_position_tumb(_("CB Fuel Pump 4, ON/OFF"),				devices.ELEC_INTERFACE,		elec_commands.CB_RIGHT_PUMP_TANK_4,	628)
elements["CB-RIGHT-PILOT-SEAT-MECHANISM-PTR"]			= default_2_position_tumb(_("CB Pilot Seat Adjustment, ON/OFF"),				devices.ELEC_INTERFACE,		elec_commands.CB_RIGHT_PILOT_SEAT_MECHANISM,	629)
elements["CB-RIGHT-ANTIICE-ALARM-PTR"]					= default_2_position_tumb(_("CB Anti-Ice System - Warning, ON/OFF"),				devices.ELEC_INTERFACE,		elec_commands.CB_RIGHT_ANTIICE_ALARM,	630)
elements["CB-RIGHT-ANTIICE-CONTROL-PTR"]				= default_2_position_tumb(_("CB Anti-Ice System - Control, ON/OFF"),				devices.ELEC_INTERFACE,		elec_commands.CB_RIGHT_ANTIICE_CONTROL,	631)

elements["CB-LEFT-MISSILE-POWER-PTR"]				= default_2_position_tumb(_("CB Missile Power, ON/OFF"),				devices.ELEC_INTERFACE,		elec_commands.CB_LEFT_HOMING_MISSILE_POWER,		572)
elements["CB-LEFT-BOMB-EMERGENCY-DETACH-PTR"]		= default_2_position_tumb(_("CB Emergency Jettison, ON/OFF"),				devices.ELEC_INTERFACE,		elec_commands.CB_LEFT_BOMB_EMERGENCY_DETACH,	573)
elements["CB-LEFT-BOMB-EXPLOSION-PTR"]				= default_2_position_tumb(_("CB Bombs, ON/OFF"),				devices.ELEC_INTERFACE,		elec_commands.CB_LEFT_BOMB_EXPLOSION,			574)
elements["CB-LEFT-ROCKETS-PTR"]						= default_2_position_tumb(_("CB Rockets, ON/OFF"),				devices.ELEC_INTERFACE,		elec_commands.CB_LEFT_UNGUIDED_ROCKETS,			575)
elements["CB-LEFT-RADIOCOMPASS-HF-PTR"]				= default_2_position_tumb(_("CB ADF, ON/OFF"),				devices.ELEC_INTERFACE,		elec_commands.CB_LEFT_RADIOCOMPASS_HF,			576)

elements["CB-LEFT-PUMP-TANK-1-PTR"]					= default_2_position_tumb(_("CB Fuel Shutoff Valve, ON/OFF"),				devices.ELEC_INTERFACE,		elec_commands.CB_LEFT_PUMP_TANK_1,				577)
elements["CB-LEFT-PUMP-TANK-5-PTR"]					= default_2_position_tumb(_("CB Cross Feed Valve, ON/OFF"),				devices.ELEC_INTERFACE,		elec_commands.CB_LEFT_PUMP_TANK_5,				578)
elements["CB-LEFT-VALVE-TANK-1-PTR"]				= default_2_position_tumb(_("CB Tank 1 Valve, ON/OFF"),				devices.ELEC_INTERFACE,		elec_commands.CB_LEFT_VALVE_TANK_1,				579)
elements["CB-LEFT-VALVE-FIRE-LEFT-PTR"]				= default_2_position_tumb(_("CB Left Tank Fire Warning, ON/OFF"),				devices.ELEC_INTERFACE,		elec_commands.CB_LEFT_VALVE_FIRE_LEFT,			580)
elements["CB-LEFT-VALVE-SEPARATION-PTR"]			= default_2_position_tumb(_("CB Left Valve Separation, ON/OFF"),				devices.ELEC_INTERFACE,		elec_commands.CB_LEFT_VALVE_SEPARATION,			581)

elements["CB-LEFT-GLASS-SPRINKLER-PTR"]				= default_2_position_tumb(_("CB Windshield Spray, ON/OFF"),				devices.ELEC_INTERFACE,		elec_commands.CB_LEFT_GLASS_SPRINKLER,			582)
elements["CB-LEFT-GLASS-WIPER-OP-PTR"]				= default_2_position_tumb(_("CB Windshield Wiper Gunner, ON/OFF"),				devices.ELEC_INTERFACE,		elec_commands.CB_LEFT_GLASS_WIPER_OP,			583)
elements["CB-LEFT-GLASS-WIPER-PILOT-PTR"]			= default_2_position_tumb(_("CB Windshield Wiper Pilot, ON/OFF"),				devices.ELEC_INTERFACE,		elec_commands.CB_LEFT_GLASS_WIPER_PILOT,		584)
elements["CB-LEFT-SPEECH-INFORMER-PTR"]				= default_2_position_tumb(_("CB Audio Warning System, ON/OFF"),				devices.ELEC_INTERFACE,		elec_commands.CB_LEFT_SPEECH_INFORMER,			585)
elements["CB-LEFT-RECORDER-PARAMS-PTR"]				= default_2_position_tumb(_("CB Flight Recorder, ON/OFF"),				devices.ELEC_INTERFACE,		elec_commands.CB_LEFT_RECORDER_PARAMS,			586)

elements["CB-LEFT-FIRE-1-AUTO-PTR"]					= default_2_position_tumb(_("CB Fire Protection System - Auto, ON/OFF"),				devices.ELEC_INTERFACE,		elec_commands.CB_LEFT_FIRE_1_AUTO,				587)
elements["CB-LEFT-FIRE-1-MANUAL-PTR"]				= default_2_position_tumb(_("CB Fire Protection System - Manual, ON/OFF"),				devices.ELEC_INTERFACE,		elec_commands.CB_LEFT_FIRE_1_MANUAL,			588)
elements["CB-LEFT-FIRE-ALARM-PTR"]					= default_2_position_tumb(_("CB Fire Protection System Warning, ON/OFF"),				devices.ELEC_INTERFACE,		elec_commands.CB_LEFT_FIRE_ALARM,				589)

elements["CB-LEFT-EXT-CARGO-EMERGENCY-DROP-PTR"]	= default_2_position_tumb(_("CB External Cargo Emergency Jettison, ON/OFF"),				devices.ELEC_INTERFACE,		elec_commands.CB_LEFT_EXT_CARGO_EMERGENCY_DROP,	590)

elements["CB-LEFT-GEAR-EXTENT-HANDLE-PTR"]			= default_2_position_tumb(_("CB Landing Gear Extend / Retract, ON/OFF"),				devices.ELEC_INTERFACE,		elec_commands.CB_LEFT_GEAR_EXTENT_HANDLE,		591)
elements["CB-LEFT-GEAR-ALARM-PTR"]					= default_2_position_tumb(_("CB Landing Gear Warning, ON/OFF"),				devices.ELEC_INTERFACE,		elec_commands.CB_LEFT_GEAR_ALARM,				592)
elements["CB-LEFT-PT125TS-PTR"]						= default_2_position_tumb(_("CB Inverter, ON/OFF"),				devices.ELEC_INTERFACE,		elec_commands.CB_LEFT_PT125Ts,					593)
elements["CB-LEFT-AIRSPEED-SENSOR-PTR"]				= default_2_position_tumb(_("CB Air Speed Sensor, ON/OFF"),				devices.ELEC_INTERFACE,		elec_commands.CB_LEFT_AIRSPEED_SENSOR,			594)
elements["CB-LEFT-AUTOPILOT-ALARM-PTR"]				= default_2_position_tumb(_("CB AFCS Warn, ON/OFF"),				devices.ELEC_INTERFACE,		elec_commands.CB_LEFT_AUTOPILOT_ALARM,			595)

elements["CB-LEFT-STARTUP-BLOCK-PTR"]				= default_2_position_tumb(_("CB Auto Start System, ON/OFF"),				devices.ELEC_INTERFACE,		elec_commands.CB_LEFT_STARTUP_BLOCK,			596)
elements["CB-LEFT-STARTUP-IGNITION-PTR"]			= default_2_position_tumb(_("CB Igniter, ON/OFF"),				devices.ELEC_INTERFACE,		elec_commands.CB_LEFT_STARTUP_IGNITION,			597)
elements["CB-LEFT-BEACON-PTR"]						= default_2_position_tumb(_("CB Beacon Light, ON/OFF"),				devices.ELEC_INTERFACE,		elec_commands.CB_LEFT_BEACON,					598)
elements["CB-LEFT-HEADLIGHT-CONTROL-PTR"]			= default_2_position_tumb(_("CB Landing Light Control, ON/OFF"),				devices.ELEC_INTERFACE,		elec_commands.CB_LEFT_HEADLIGHT_CONTROL,		599)
elements["CB-LEFT-PILOTING-DEVICE-PTR"]				= default_2_position_tumb(_("CB Main Attitude Indicator, ON/OFF"),				devices.ELEC_INTERFACE,		elec_commands.CB_LEFT_PILOTING_DEVICE,			600)

--fuel interface
elements["FEED-TANK-1-PTR"]				=	default_2_position_tumb(_("Feed Tank 1 Valve Switch, OPEN/CLOSE"),		devices.FUELSYS_INTERFACE,	fuel_commands.ValveTank1,					392)
elements["FEED-TANK-2-PTR"]				=	default_2_position_tumb(_("Feed Tank 2 Valve Switch, OPEN/CLOSE"),		devices.FUELSYS_INTERFACE,	fuel_commands.ValveTank2,					394)
elements["FIRE-VALVE-LEFT-COVER-PTR"]	=	default_blue_cover(_("Left Engine Fire Valve Cover, UP/DOWN"),			devices.FUELSYS_INTERFACE,	fuel_commands.ValveLeftEngineCover,			396)
elements["FIRE-VALVE-LEFT-COVER-PTR"].turn_box = {0,0,180}
elements["FIRE-VALVE-LEFT-PTR"]			=	default_2_position_tumb(_("Left Engine Fire Valve, OPEN/CLOSE"),		devices.FUELSYS_INTERFACE,	fuel_commands.ValveLeftEngine,				397)
elements["FIRE-VALVE-RIGHT-COVER-PTR"]	=	default_blue_cover(_("Right Engine Fire Valve Cover, UP/DOWN"),			devices.FUELSYS_INTERFACE,	fuel_commands.ValveRightEngineCover,		399)
elements["FIRE-VALVE-RIGHT-COVER-PTR"].turn_box = {0,0,180}
elements["FIRE-VALVE-RIGHT-PTR"]		=	default_2_position_tumb(_("Right Engine Fire Valve, OPEN/CLOSE"),		devices.FUELSYS_INTERFACE,	fuel_commands.ValveRightEngine,				400)
elements["FUEL-DELIM-PTR"]				=	default_2_position_tumb(_("Fuel Delimiter Valve, OPEN/CLOSE"),			devices.FUELSYS_INTERFACE,	fuel_commands.ValveDelimiter,				402)
elements["EXT-TANKS-PTR"]				=	default_2_position_tumb(_("External Tanks, OPEN/CLOSE"),				devices.FUELSYS_INTERFACE,	fuel_commands.ExtTank,						411)
elements["EXT-TANKS-PTR"].turn_box = {180,0,0}
elements["TANK-4-PTR"]					=	default_2_position_tumb(_("Tank 4 Pump, ON/OFF"),						devices.FUELSYS_INTERFACE,	fuel_commands.Tank4Pump,					404)
elements["TANK-5-PTR"]					=	default_2_position_tumb(_("Tank 5 Pump, ON/OFF"),						devices.FUELSYS_INTERFACE,	fuel_commands.Tank5Pump,					406)
elements["TANK-1-PTR"]					=	default_2_position_tumb(_("Tank 1 Pump, ON/OFF"),						devices.FUELSYS_INTERFACE,	fuel_commands.Tank1Pump,					408)
elements["TANK-2-PTR"]					=	default_2_position_tumb(_("Tank 2 Pump, ON/OFF"),						devices.FUELSYS_INTERFACE,	fuel_commands.Tank2Pump,					410)
elements["FUEL-METER-H-BUTTON-PTR"]		=	default_button(_("Fuel meter test low"),								devices.FUELSYS_INTERFACE,	fuel_commands.FuelMeterButtonH,				524)
elements["FUEL-METER-H-BUTTON-PTR"].turn_box = {180,0,-90}
elements["FUEL-METER-P-BUTTON-PTR"]		=	default_button(_("Fuel meter test high"),								devices.FUELSYS_INTERFACE,	fuel_commands.FuelMeterButtonP,				526)
elements["FUEL-METER-P-BUTTON-PTR"].turn_box = {180,0,-90}
elements["FUEL-METER-KNOB-PTR"]			=	multiposition_switch(_("Select tank for fuel meter"),					devices.FUELSYS_INTERFACE,	fuel_commands.FuelMeter,					191,	7, 1/6, false, 0, nil, false)
elements["FUEL-METER-KNOB-PTR"].turn_box = {0,-90,0}

--engine startup panel
elements["APU-START-PTR"]				= default_button(_("APU Start"),	devices.ENGINE_INTERFACE,	engine_commands.STARTUP_APU_StartUp, 307)
elements["APU-STOP-PTR"]				= default_button(_("APU Stop"),	devices.ENGINE_INTERFACE,	engine_commands.STARTUP_APU_Stop, 311)
elements["APU-FALSE-CRANK-START-PTR"]	= default_3_position_tumb(_("APU Launch Method START/CRANK/FALSE"),	devices.ENGINE_INTERFACE,	engine_commands.STARTUP_APU_Launch_Method,	313)
elements["ENG-START-PTR"]				= default_button(_("Engine Start"), devices.ENGINE_INTERFACE,	engine_commands.STARTUP_Engine_StartUp, 314)
elements["ENG-ABORT-PTR"]				= default_button(_("Engine Interrupt Start"), devices.ENGINE_INTERFACE,	engine_commands.STARTUP_Engine_InterruptStartUp, 318)
elements["ENG-LEFT-RIGHT-PTR"]			= default_2_position_tumb(_("Engine Select RIGHT/LEFT"), devices.ENGINE_INTERFACE,	engine_commands.STARTUP_Engine_Select, 320)
elements["ENG-CRANK-START-PTR"]			= default_2_position_tumb(_("Engine Launch Method START/CRANK"), devices.ENGINE_INTERFACE,	engine_commands.STARTUP_Engine_Launch_Method, 321)

--antidust
elements["DEDUST-OFF-COVER-PTR"]		= default_blue_cover(_("Antidust ON Cover, UP/DOWN"),			devices.ENGINE_INTERFACE,		engine_commands.ANTIDUST_On_COVER,	514)
elements["DEDUST-OFF-COVER-PTR"].turn_box = {0,180,-90}
elements["DEDUST-OFF-PTR"]				= default_2_position_tumb(_("Antidust ON/OFF"), devices.ENGINE_INTERFACE,	engine_commands.ANTIDUST_On, 796)
--antiice
elements["ROTOR-DEICER-AUTO-MAN-PTR"]		= default_2_position_tumb(_("AntiIce AUTO/MANUAL"), devices.ANTI_ICE_INTERFACE,	AntiIceSys_commands.ANTIICE_ManAuto, 109)
elements["ROTOR-DEICER-AUTO-MAN-PTR"].turn_box = {-90,0,-90}
elements["ROTOR-DEICER-OFF-PTR"]			= default_button(_("AntiIce OFF"), devices.ANTI_ICE_INTERFACE,	AntiIceSys_commands.ANTIICE_Off, 110)
elements["ROTOR-DEICER-OFF-PTR"].turn_box = {-90,0,-90}
elements["LEFT-ENG-HEATING-PTR"]			= default_2_position_tumb(_("Left Engine AntiIce ON/OFF"), devices.ANTI_ICE_INTERFACE,	AntiIceSys_commands.ANTIICE_LeftEng, 113)
elements["LEFT-ENG-HEATING-PTR"].turn_box = {-90,0,-90}
elements["RIGHT-ENG-HEATING-PTR"]			= default_2_position_tumb(_("Right Engine AntiIce ON/OFF"), devices.ANTI_ICE_INTERFACE,	AntiIceSys_commands.ANTIICE_RightEng, 112)
elements["RIGHT-ENG-HEATING-PTR"].turn_box = {-90,0,-90}
elements["WINDSHIELD-DEICER-PTR"]			= default_3_position_tumb(_("Windshield Antiice LOW/OFF/HIGH"),	devices.ANTI_ICE_INTERFACE,	AntiIceSys_commands.ANTIICE_GLAZING_P,	111)
elements["WINDSHIELD-DEICER-PTR"].turn_box = {-90,0,-90}
elements["WINDSHIELD-DEICER-OP-PTR"]		= default_3_position_tumb(_("Windshield Antiice LOW/OFF/HIGH"),	devices.ANTI_ICE_INTERFACE,	AntiIceSys_commands.ANTIICE_GLAZING_O,	675, nil, nil, nil, nil, nil, 1)
elements["DEICER-KNOB-PTR"]					= multiposition_switch(_("AC Voltmeter knob"),	devices.ANTI_ICE_INTERFACE,		AntiIceSys_commands.ANTIICE_Ammeter, 114,	11, 0.1, false, 0, nil, false)
elements["DEICER-KNOB-PTR"].turn_box = {0,-30,0}
--engine termometer control
elements["ENG-TEMP-SENSOR-CONTROL-COLD-PTR"]		= default_button(_("Engine Termometer control COLD"), devices.ENGINE_INTERFACE,	engine_commands.IA6_COLD, 194)
elements["ENG-TEMP-SENSOR-CONTROL-COLD-PTR"].turn_box = {-90,0,-90}
elements["ENG-TEMP-SENSOR-CONTROL-HOT-PTR"]			= default_button(_("Engine Termometer control HOT"), devices.ENGINE_INTERFACE,	engine_commands.IA6_HOT, 195)
elements["ENG-TEMP-SENSOR-CONTROL-HOT-PTR"].turn_box = {-90,0,-90}

--autopilot
--light
elements["SAU-BRIGHT-DIM-PTR"]			= default_2_position_tumb(_("Buttons Lighting BRIGHT/DIM"),	devices.AUTOPILOT,	autopilot_commands.Lighting,	267)
elements["SAU-BRIGHT-DIM-PTR"].turn_box = {180,0,0}
--channels
elements["SAU-H-ON-PTR"]				= default_square_button(_("Autopilot H Channel ON"),	devices.AUTOPILOT,	autopilot_commands.ButtonHon,	237)
elements["SAU-H-OFF-PTR"]				= default_square_button(_("Autopilot H Channel OFF"),	devices.AUTOPILOT,	autopilot_commands.ButtonHoff,	236)
elements["SAU-K-ON-PTR"]				= default_button(_("Autopilot K Channel ON"),	devices.AUTOPILOT,	autopilot_commands.ButtonKon,	243)
elements["SAU-K-OFF-PTR"]				= default_button(_("Autopilot K Channel OFF"),	devices.AUTOPILOT,	autopilot_commands.ButtonKoff,	242)
elements["SAU-T-ON-PTR"]				= default_square_button(_("Autopilot T Channel ON"),	devices.AUTOPILOT,	autopilot_commands.ButtonTon,	249)
elements["SAU-T-OFF-PTR"]				= default_square_button(_("Autopilot T Channel OFF"),	devices.AUTOPILOT,	autopilot_commands.ButtonToff,	248)
elements["SAU-B-ON-PTR"]				= default_button(_("Autopilot B Channel ON"),	devices.AUTOPILOT,	autopilot_commands.ButtonBon,	255)
elements["SAU-B-OFF-PTR"]				= default_button(_("Autopilot B Channel OFF"),	devices.AUTOPILOT,	autopilot_commands.ButtonBoff,	254)
--knobs
elements["SAU-H-KNOB-PTR"]				= default_axis(_("Autopilot H Channel Delta Correction"),	devices.AUTOPILOT,	autopilot_commands.DeltaH,	234,	0,	0.1,	false,	true,	true)
elements["SAU-K-KNOB-PTR"]				= default_axis(_("Autopilot K Channel Delta Correction"),	devices.AUTOPILOT,	autopilot_commands.DeltaK,	240,	0,	0.1,	false,	true,	true)
elements["SAU-T-KNOB-PTR"]				= default_axis(_("Autopilot T Channel Delta Correction"),	devices.AUTOPILOT,	autopilot_commands.DeltaT,	246,	0,	0.1,	false,	true,	true)
--modes
elements["SAU-HEIGHT-ON-PTR"]			= default_square_button(_("Autopilot Altitude Mode ON"),			devices.AUTOPILOT,	autopilot_commands.HeightOn,		258)
elements["SAU-HEIGHT-OFF-PTR"]			= default_square_button(_("Autopilot Altitude Mode OFF"),			devices.AUTOPILOT,	autopilot_commands.HeightOff,		257)
elements["SAU-HOVER-ON-PTR"]			= default_square_button(_("Autopilot Hover Mode ON"),				devices.AUTOPILOT,	autopilot_commands.HoverOn,			259)
elements["SAU-ROUTE-ON-PTR"]			= default_square_button(_("Autopilot Route Mode ON"),				devices.AUTOPILOT,	autopilot_commands.RouteOn,			261)
elements["SAU-HOVER-ROUTE-OFF-PTR"]		= default_square_button(_("Autopilot Route and Hover Modes OFF"),	devices.AUTOPILOT,	autopilot_commands.RouteHoverOff,	260)

elements["SAU-AZ-PTR"]					= default_axis(_("Autopilot Route Azimuth"),	devices.AUTOPILOT,	autopilot_commands.RouteAngle,	262, 0, 1.0 / 6.0, false, true, true)

elements["SAU-SPEED-ON-PTR"]			= default_button(_("Autopilot Speed Stabilization ON"),			devices.AUTOPILOT,	autopilot_commands.SpeedOn,		268)
elements["SAU-SPEED-OFF-PTR"]			= default_button(_("Autopilot Speed Stabilization OFF"),		devices.AUTOPILOT,	autopilot_commands.SpeedOff,	269)

elements["SAU-B-SWITCH-PTR"]			= springloaded_3_pos_tumb(_("Autopilot Altitude Control"),	devices.AUTOPILOT,	autopilot_commands.ControlDown,	autopilot_commands.ControlUp,	253,	nil,	nil,	nil,	nil)
elements["SAU-B-SWITCH-PTR"].turn_box = {180,0,0}
elements["STICK-TRIMMER-PTR"]	= stick_button(_("Autopilot Trimmer Button")					, devices.AUTOPILOT, autopilot_commands.Trimmer, 742)
elements["STICK-TRIMMER-PTR"].updatable = true
elements["STICK-TRIMMER-PTR"].sound = {{SOUND_TRIM_OFF, SOUND_TRIM_ON}}

elements["OP-STICK-TRIMMER-PTR"]	= stick_button(_("Autopilot Trimmer Button")					, devices.AUTOPILOT, autopilot_commands.TrimmerMULT, 855)
elements["OP-STICK-TRIMMER-PTR"].updatable = true
elements["OP-STICK-TRIMMER-PTR"].sound = {{SOUND_TRIM_OFF, SOUND_TRIM_ON}}


--SPUU
elements["SPUU-ON-OFF-PTR"]			= default_2_position_tumb(_("SPUU Power ON/OFF"),	devices.SPUU_52,	spuu_commands.On_Off,	270)
elements["SPUU-ON-OFF-PTR"].turn_box = {180,0,0}
elements["SPUU-ON-OFF-PTR"].turn_box = {180,0,0}
elements["SPUU-OFF-PTR"]			= default_position_tumb(_("SPUU OFF (that's a button but acts like a switch)"),	devices.SPUU_52,	spuu_commands.button_off,	275)
elements["SPUU-OFF-PTR"].sound		= {{SOUND_SW4_ON, SOUND_SW4_OFF}}
elements["SPUU-CONTROL-PTR"]		= springloaded_3_pos_tumb(_("SPUU Control Switch P/NONE/T"),	devices.SPUU_52,	spuu_commands.switchDown,	spuu_commands.switchUp,	277,	nil,	nil,	nil,	nil)
elements["SPUU-CONTROL-PTR"].turn_box = {180,180,0}
elements["SPUU-KNOB-PTR"]			= default_axis(_("SPUU Adjustment Knob"),	devices.SPUU_52,	spuu_commands.control,	276, 1, 0.2 * 5 / 6, true, false, false)







-----------------------------------------------------------------------------------------------------------------------
--fire extinguisher
--buttons
elements["FIRE-1-L-ENG-PTR"]	= default_button(_("Extinguish Left Engine 1"),		devices.FIRE_EXTING_INTERFACE,	fire_commands.ExtingiushLE1,	502)
elements["FIRE-2-L-ENG-PTR"]	= default_button(_("Extinguish Left Engine 2"),		devices.FIRE_EXTING_INTERFACE,	fire_commands.ExtingiushLE2,	504)
elements["FIRE-1-R-ENG-PTR"]	= default_button(_("Extinguish Right Engine 1"),	devices.FIRE_EXTING_INTERFACE,	fire_commands.ExtingiushRE1,	498)
elements["FIRE-2-R-ENG-PTR"]	= default_button(_("Extinguish Right Engine 2"),	devices.FIRE_EXTING_INTERFACE,	fire_commands.ExtingiushRE2,	500)
elements["FIRE-1-APU-PTR"]		= default_button(_("Extinguish APU 1"),				devices.FIRE_EXTING_INTERFACE,	fire_commands.ExtingiushAPU1,	494)
elements["FIRE-2-APU-PTR"]		= default_button(_("Extinguish APU 2"),				devices.FIRE_EXTING_INTERFACE,	fire_commands.ExtingiushAPU2,	496)
elements["FIRE-1-REDUCER-PTR"]	= default_button(_("Extinguish Gearbox 1"),			devices.FIRE_EXTING_INTERFACE,	fire_commands.ExtingiushMRED1,	490)
elements["FIRE-2-REDUCER-PTR"]	= default_button(_("Extinguish Gearbox 2"),			devices.FIRE_EXTING_INTERFACE,	fire_commands.ExtingiushMRED2,	492)
elements["FIRE-ALARM-OFF-PTR"]	= default_button(_("Turn Off Fire Signal Button"),	devices.FIRE_EXTING_INTERFACE,	fire_commands.DisableAlarm,		488)
--switches
elements["EXTINGUISH-CONTROL-PTR"]		= default_2_position_tumb(_("Extinguisher Control Switch EXING/CNTRL"),	devices.FIRE_EXTING_INTERFACE,	fire_commands.SensorControl, 482)
elements["FIRE-SENSOR-CHANNEL-PTR1"]	= triple_switch(_("Fire Extinguisher Sensor Cnannel OFF/1/2/3"),	devices.FIRE_EXTING_INTERFACE,	fire_commands.SensorGroup, 484)
elements["FIRE-SENSOR-CHANNEL-PTR1"].crew_member_access  = {0}
elements["FIRE-PYRO-CHANNEL-PTR"]		= springloaded_3_pos_tumb(_("Fire Extinguisher Squib Control"),	devices.FIRE_EXTING_INTERFACE,	fire_commands.Pyro1,	fire_commands.Pyro2,	486,	nil,	nil,	nil,	nil)
elements["FIRE-POWER-PTR"]				= default_2_position_tumb(_("Fire Extinguisher Power ON/OFF"),	devices.FIRE_EXTING_INTERFACE,	fire_commands.Power, 487)

-----------------------------------------------------------------------------------------------
--weapons
--stick button
elements["STICK-RS-COVER-PTR"]	= default_blue_cover(_("Fire Weapons Cover"),		devices.WEAP_SYS,	weapon_commands.Pilot_RUV_FIRE_Cvr,	740)
elements["STICK-RS-COVER-PTR"].updatable = true
elements["STICK-RS-PTR"]	= default_button(_("Fire Weapons"),		devices.WEAP_SYS,	weapon_commands.Pilot_RUV_FIRE,	741)
elements["STICK-RS-PTR"].updatable = true
elements["OP-STICK-RS-COVER-PTR"]	= default_blue_cover(_("Fire Weapons Cover"),		devices.WEAP_SYS,	weapon_commands.Operator_RUV_FIRE_Cvr,	853, nil, 1)
elements["OP-STICK-RS-COVER-PTR"].updatable = true
elements["OP-STICK-RS-COVER-PTR"].side = {}
elements["OP-STICK-RS-PTR"]	= default_button(_("Fire Weapons"),		devices.WEAP_SYS,	weapon_commands.Operator_RUV_FIRE_OPERATOR,	187, nil, 1)
elements["OP-STICK-RS-PTR"].updatable = true
elements["OP-STICK-RS-PTR"].side = {}
--PUVL
elements["ARMAMENT-POWER-OP-PTR"]				= default_2_position_tumb(_("Main Weapon Safe Switch"),			devices.WEAP_SYS,	weapon_commands.Operator_SWITCHER_SAFE_WEAP,	673, nil, 1)
elements["ARMAMENT-POWER-OP-PTR"].sound			= {{SOUND_SW17}}
elements["WEAP-BURST-LENGTH-PTR"]				= default_3_position_tumb(_("Burst Length SHORT/MED/LONG"),		devices.WEAP_SYS,	weapon_commands.Pilot_NPU_CHAIN,				521)
elements["WEAP-127-LEFT-RELOAD-PTR"]			= triple_switch(_("Reload Left Gondola"),						devices.WEAP_SYS,	weapon_commands.Pilot_RELOAD_LEFT,				522)
elements["WEAP-127-RIGHT-RELOAD-PTR"]			= triple_switch(_("Reload Right Gondola"),						devices.WEAP_SYS,	weapon_commands.Pilot_RELOAD_RIGHT,				527)
elements["WEAP-SIGHT-CONTROL-ON-OFF-PTR"]		= default_2_position_tumb(_("Weapon Camera ON/OFF"),			devices.WEAP_SYS,	weapon_commands.Pilot_FKP_CAMERA,				530)

elements["WEAP-SELECT-KNOB-PTR"]				= multiposition_switch(_("Select Weapon"),						devices.WEAP_SYS,	weapon_commands.Pilot_SWITCHER_OFF_GM_URS_NPU,	523,	9,	0.1)
elements["WEAP-SELECT-KNOB-PTR"].turn_box = {180,90,0}
elements["WEAP-ROCKET-SELECT-PTR"]				= default_3_position_tumb(_("Select Rockets LEFT/BOTH/RIGHT"),	devices.WEAP_SYS,	weapon_commands.Pilot_BOTH_LEFT_RIGHT,			531)
elements["WEAP-ROCKET-SELECT-PTR"].turn_box = {180,0,-90}

elements["WEAP-ON-OFF-PTR"]						= default_2_position_tumb(_("Weapon Control ON/OFF"),			devices.WEAP_SYS,	weapon_commands.Pilot_SWITCHER_FIRE_CONTROL,	551)
elements["WEAP-CANNON-PACE-PTR"]				= default_2_position_tumb(_("Cannon Fire Rate SLOW/FAST"),		devices.WEAP_SYS,	weapon_commands.Pilot_TEMP_NPU30,				550)
elements["WEAP-NPU-RELOAD-PTR"]					= default_button(_("Reload Cannon"),							devices.WEAP_SYS,	weapon_commands.Pilot_RELOAD_NPU30,				549)
elements["WEAP-NPU-RELOAD-PTR"].turn_box = {90,0,-90}
elements["WEAP-KMG-INTERRUPT-PTR"]				= default_button(_("Stop container"),							devices.WEAP_SYS,	weapon_commands.Pilot_STOP_KMG,					547)
elements["WEAP-KMG-INTERRUPT-PTR"].turn_box = {90,0,-90}

elements["WEAP-JETTISON-EXPLOSION-PTR"]			= default_2_position_tumb(_("Explosion on Jettison ON/OFF"),	devices.WEAP_SYS,	weapon_commands.Pilot_EMERG_EXPLODE,			546)
elements["WEAP-JETTISON-EXPLOSION-COVER-PTR"]	= default_blue_cover(_("Explosion on Jettison Cover, UP/DOWN"),	devices.WEAP_SYS,	weapon_commands.Pilot_EMERG_EXPLODE_COVER,		545)
elements["WEAP-JETTISON-SPECIAL-PTR"]			= default_tumb_button(_("Jettison Pylons ON/OFF"),				devices.WEAP_SYS,	weapon_commands.Pilot_EMERG_RELEASE,			542)
elements["WEAP-JETTISON-SPECIAL-COVER-PTR"]		= default_blue_cover(_("Jettison Pylons Cover, UP/DOWN"),		devices.WEAP_SYS,	weapon_commands.Pilot_EMERG_RELEASE_COVER,		541)
elements["WEAP-JETTISON-LAUNCHER-PTR"]			= default_tumb_button(_("Jettison Launcher ON/OFF"),			devices.WEAP_SYS,	weapon_commands.Pilot_EMERG_RELEASE_PU,			538)
elements["WEAP-JETTISON-LAUNCHER-COVER-PTR"]	= default_blue_cover(_("Jettison Launcher Cover, UP/DOWN"),		devices.WEAP_SYS,	weapon_commands.Pilot_EMERG_RELEASE_PU_COVER,	537)
elements["WEAP-PUS-ENGAGEMENT-PTR"]				= default_button(_("Arm Rockets"),								devices.WEAP_SYS,	weapon_commands.Pilot_PUS_ARMING,				536)
elements["WEAP-PUS-ENGAGEMENT-PTR"].turn_box = {90,0,-90}


elements["WEAP-SELECT-KNOB-OP-PTR"]				= multiposition_switch(_("Select Weapon"),						devices.WEAP_SYS,	weapon_commands.Operator_SWITCHER_WEAP_TYPE_AB,	709,	5,	0.1, nil, nil, nil, nil, 1)
elements["WEAP-SELECT-KNOB-OP-PTR"].turn_box = {0,120,0}

elements["WEAP-JETTISON-OP-COVER-PTR"]			= default_blue_cover(_("Emergency Jettison Cover, UP/DOWN"),	devices.WEAP_SYS,	weapon_commands.Operator_EMERG_RELEASE_OPERATOR_Cvr,	141, nil, 1)
elements["WEAP-JETTISON-OP-COVER-PTR"].turn_box = {0,0,180}
elements["WEAP-JETTISON-OP-PTR"]				= default_button(_("Emergency Jettison"),						devices.WEAP_SYS,	weapon_commands.Operator_EMERG_RELEASE_OPERATOR,		142, nil, 1)
elements["WEAP-BOMBS-BLOCKS-OP-COVER-PTR"]		= default_blue_cover(_("Bombs/Blocks Mode Cover, UP/DOWN"),		devices.WEAP_SYS,	weapon_commands.Operator_SWITCHER_BOMB_BLOCK_BOMB_Cvr,	699, nil, 1)
elements["WEAP-BOMBS-BLOCKS-OP-COVER-PTR"].turn_box = {0,0,180}
elements["WEAP-BOMBS-BLOCKS-OP-PTR"]			= default_3_position_tumb(_("Bombs/Blocks Mode"),				devices.WEAP_SYS,	weapon_commands.Operator_SWITCHER_BOMB_BLOCK_BOMB,		700, false, nil, nil, nil, nil, 1)
elements["WEAP-JETTISON-EXPLOSION-OP-COVER-PTR"]= default_blue_cover(_("Explosion on Jettison Cover, UP/DOWN"),	devices.WEAP_SYS,	weapon_commands.Operator_EMERG_EXPLODE_OPERATOR_Cvr,	714, nil, 1)
elements["WEAP-JETTISON-EXPLOSION-OP-COVER-PTR"].turn_box = {0,0,180}
elements["WEAP-JETTISON-EXPLOSION-OP-PTR"]		= default_2_position_tumb(_("Explosion on Jettison"),			devices.WEAP_SYS,	weapon_commands.Operator_EMERG_EXPLODE_OPERATOR,		715, nil, 1)
elements["WEAP-PRIORITY-OP-COVER-PTR"]			= default_blue_cover(_("Weapon Control Cover, UP/DOWN"),		devices.WEAP_SYS,	weapon_commands.Operator_CONTROL_On_ME_OPERATOR_Cvr,	712, nil, 1)
elements["WEAP-PRIORITY-OP-COVER-PTR"].turn_box = {0,0,180}
elements["WEAP-PRIORITY-OP-PTR"]				= default_2_position_tumb(_("Weapon Control"),					devices.WEAP_SYS,	weapon_commands.Operator_SWITCHER_CONTROL_On_ME_OPERATOR,713, nil, 1)

elements["WEAP-JETTISON-SPECIAL-OP-PTR"]		= default_2_position_tumb(_("Jettison Launcher ON/OFF"),		devices.WEAP_SYS,	weapon_commands.Operator_EMERGE_RELEASE_PU_OPERATOR,	765, nil, 1)
elements["WEAP-JETTISON-SPECIAL-OP-COVER-PTR"]	= default_blue_cover(_("Jettison Launcher Cover, UP/DOWN"),		devices.WEAP_SYS,	weapon_commands.Operator_EMERG_RELEASE_PU_OPERATOR_Cvr,	764, nil, 1)
elements["WEAP-JETTISON-SPECIAL-OP-COVER-PTR"].turn_box = {0,0,180}

elements["WEAP-BURST-LENGTH-OP-PTR"]			= default_3_position_tumb(_("Burst Length SHORT/MED/LONG"),		devices.WEAP_SYS,	weapon_commands.Operator_CHAIN_LENGTH_SHORT_MED_LONG, 	770, false, nil, nil, nil, nil, 1)
elements["WEAP-CANNON-PACE-OP-PTR"]				= default_2_position_tumb(_("Cannon Fire Rate SLOW/FAST"),		devices.WEAP_SYS,	weapon_commands.Operator_OPERATOR_RATE_MORE, 	772, nil, 1)
elements["WEAP-MISSILES-POWER-OP-PTR"]			= default_2_position_tumb(_("Missiles Power"),					devices.WEAP_SYS,	weapon_commands.Operator_URS_POWER, 			773, nil, 1)
elements["WEAP-JETTISON-TEST-OP-PTR"]			= default_button(_("Release Check PU"),							devices.WEAP_SYS,	weapon_commands.Operator_CHECK_RELEASE_PU, 		768, nil, 1)
elements["WEAP-DISTR-CONTROL-OP-PTR"]			= default_3_position_tumb(_("CHECK1-WORK-CHECK2"),				devices.WEAP_SYS,	weapon_commands.Operator_CHECK1_WORK_CHECK2, 	762, false, nil, nil, nil, nil, 1)
elements["WEAP-NPU-RELOAD-OP-PTR"]				= default_button(_("Reload Cannon"),							devices.WEAP_SYS,	weapon_commands.Operator_RELOAD_NPU30,			769, nil, 1)

elements["SHSCHO-POWER-PTR"]					= default_2_position_tumb(_("SCHO Power"),						devices.WEAP_SYS,	weapon_commands.Operator_POWER_SHO_SWITCHER, 	955, nil, 1)
elements["SHSCHO-CHECK-PTR"]				 	= default_button(_("SCHO Lamps Check"),							devices.WEAP_SYS,	weapon_commands.Operator_CHECK_LAMPS_9C475,		956, nil, 1)
elements["SHSCHO-KNOB-PTR"]						= multiposition_switch(_("Select Station"),						devices.WEAP_SYS,	weapon_commands.Operator_SWITCHER_LAUNCH_STATION,	963,	9,	0.1, nil, nil, nil, nil, 1)
elements["SHSCHO-KNOB-PTR"].turn_box = {0,30,0}


elements["WEAP-KMG-COMMENCE-OP-PTR"]			= default_button(_("Start container"),							devices.WEAP_SYS,	weapon_commands.Operator_START_KMG,		711, nil, 1)
elements["WEAP-KMG-INTERRUPT-OP-PTR"]			= default_button(_("Stop container"),							devices.WEAP_SYS,	weapon_commands.Operator_STOP_KMG,		710, nil, 1)


elements["PK-PN-POWER-PTR"]						= default_2_position_tumb(_("Sight Power Switch"),				devices.I9K113,	i9K113_commands.Command_POWER_PN, 			885, nil, 1)
elements["PK-LIGHT-PTR"]						= default_2_position_tumb(_("Backlight"),						devices.I9K113,	i9K113_commands.Command_9k113_Backlight, 	884, nil, 1)
elements["PK-OBSERVE-PTR"]						= default_2_position_tumb(_("OBSERVE"),							devices.I9K113,	i9K113_commands.Command_NABL, 				886, nil, 1)
elements["PK-DIAPH-PTR"]						= default_2_position_tumb(_("DIAFR Open"),						devices.I9K113,	i9K113_commands.Command_DIAFR_OTKR, 		887, nil, 1)
elements["PK-LOCK-PTR"]							= default_2_position_tumb(_("LOCK ARU"),						devices.I9K113,	i9K113_commands.Command_OTKL_BLOCK_ARU, 	912, nil, 1)
elements["PK-SSP-PTR"]							= default_2_position_tumb(_("SSP On"),							devices.I9K113,	i9K113_commands.Command_SSP_VKL, 			913, nil, 1)
elements["PK-IMIT-GENER-PTR"]					= default_2_position_tumb(_("GENERATOR-IMIT"),					devices.I9K113,	i9K113_commands.Command_GENER_EMIT, 		910, nil, 1)
elements["PK-CHECK-PTR"]						= default_3_position_tumb(_("CHECK2-NEUTR-CHECK1"),				devices.I9K113,	i9K113_commands.Command_KONTR_T1_B9_KONTR_T2, 	905, false, nil, nil, nil, nil, 1)
elements["WEAP-JETTISON-SPECIAL-OP-COVER-PTR002"]= default_2_position_tumb(_("WORK-CHECK"),						devices.I9K113,	i9K113_commands.Command_WORK_CONTROL, 		903, nil, 1)
elements["WEAP-JETTISON-SPECIAL-OP-COVER-PTR002"].turn_box = {0,110,0}
elements["PK-LAUNCH-PTR"]						= default_button(_("Start PM"),									devices.I9K113,	i9K113_commands.Command_START_PM, 			911, nil, 1)
elements["PK-LAUNCH-PTR"].turn_box = {0,0,-90}
elements["PK-WORK-CHECK-PTR"]					= multiposition_switch(_("BVK Set"),							devices.I9K113,	i9K113_commands.Command_VHOD_BVK_KV,		899,	5,	0.1, nil, nil, nil, nil, 1)
elements["PK-WORK-CHECK-PTR"].turn_box = {0,135,0}
elements["PK-HEATING-PTR"]						= default_2_position_tumb(_("Sight Heating"),					devices.I9K113,	i9K113_commands.Command_Heat_O, 			890, nil, 1)

elements["OP-SIGHT-SCOPE-PTR"]					= default_2_position_tumb(_("Zoom In-Out"),						devices.I9K113,	i9K113_commands.Command_ZOOM,				871, nil, 1)
elements["OP-SIGHT-SCOPE-PTR"].sound			= {{SOUND_SW18_ON, SOUND_SW18_OFF}}
elements["OP-SIGHT-ORANGE-PTR"]					= default_2_position_tumb(_("Orange Filter"),					devices.I9K113,	i9K113_commands.Command_OS,					872, nil, 1)
elements["OP-SIGHT-ORANGE-PTR"].sound			= {{SOUND_SW18_ON, SOUND_SW18_OFF}}
elements["OP-SIGHT-ORANGE-PTR"].turn_box = {90,0,0}
elements["OP-SIGHT-ANTILASER-PTR"]				= default_2_position_tumb(_("Laser Filter"),					devices.I9K113,	i9K113_commands.Command_SES,				873, nil, 1)
elements["OP-SIGHT-ANTILASER-PTR"].sound		= {{SOUND_SW18_ON, SOUND_SW18_OFF}}
elements["OP-SIGHT-ANTILASER-PTR"].side = {{BOX_SIDE_Z_bottom},{BOX_SIDE_Y_bottom}}

elements["WEAP-MISSILES-SIGHT-HEATING-OP-PTR"]	= default_2_position_tumb(_("Sight Doors"),						devices.I9K113,	i9K113_commands.Command_STVORKI, 			775, nil, 1)

elements["L166V-SWITCH-PTR"]					= default_3_position_tumb(_("Lamps Check"),						devices.I9K113,	i9K113_commands.Command_CHECK_LAMPS, 		870, false, nil, nil, nil, nil, 1)


elements["SHTV-CHECK-VALUE-PTR"]				= default_2_position_tumb(_("Switcher 0 - 0.4"),				devices.I9K113,	i9K113_commands.Command_0_04, 				933, nil, 1)
elements["SHTV-IN-OUT-PTR"]						= default_2_position_tumb(_("Switcher IN-OUT"),					devices.I9K113,	i9K113_commands.Command_SWITCHER_IN_OUT, 	934, nil, 1)
elements["SHTV-CODE-PTR"]						= default_2_position_tumb(_("Switcher CODE1-CODE2"),			devices.I9K113,	i9K113_commands.Command_COD1_COD2, 			935, nil, 1)
elements["SHTV-CHECK-PTR"]						= default_button(_("Checking"),									devices.I9K113,	i9K113_commands.Command_CHECKING, 			931, nil, 1)
elements["SHTV-CHECK-PTR"].turn_box = {0,0,-90}
elements["SHTV-CHECK-PTR"].sound				= {{SOUND_SW20_ON, SOUND_SW20_OFF}}
elements["SHTV-HIGH-K-PTR"]						= default_button(_("High K"),									devices.I9K113,	i9K113_commands.Command_HIGH_K, 			875, nil, 1)
elements["SHTV-HIGH-K-PTR"].turn_box = {0,0,-90}
elements["SHTV-HIGH-K-PTR"].sound				= {{SOUND_SW20_ON, SOUND_SW20_OFF}}
elements["SHTV-LAMP-CHECK-PTR"]					= default_button(_("Display Lamps Check"),						devices.I9K113,	i9K113_commands.Command_TABLO, 				932, nil, 1)
elements["SHTV-LAMP-CHECK-PTR"].turn_box = {0,0,-90}
elements["SHTV-LAMP-CHECK-PTR"].sound			= {{SOUND_SW20_ON, SOUND_SW20_OFF}}

elements["OP-AIM-RESET-RAD-PTR"]				= default_button(_("Radiation Reset"),							devices.I9K113,	i9K113_commands.Command_RadiationReset,		882, nil, 1)
elements["OP-AIM-RESET-RAD-PTR"].turn_box = {0,0,-90}

-----------------------------------------------------------------------------------------------
--asp pilot sight
--sight body
elements["SIGHT-MAN-AUTO-PTR"]						= default_2_position_tumb(_("Sight mode MANUAL/AUTO"),				devices.ASP_17V,	asp_commands.Manual_Auto,		553)
elements["SIGHT-MAN-AUTO-PTR"].arg_value			= {0.5,-0.5}
elements["SIGHT-MAN-AUTO-PTR"].arg_lim				= {{0,0.5},{0,0.5}}
elements["SIGHT-SYNC-UNSYNC-PTR"]					= default_2_position_tumb(_("Sight mode SYNC/ASYNC"),				devices.ASP_17V,	asp_commands.Sync_Async,		554)
elements["SIGHT-SYNC-UNSYNC-PTR"].arg_value			= {0.5,-0.5}
elements["SIGHT-SYNC-UNSYNC-PTR"].arg_lim			= {{0,0.5},{0,0.5}}
elements["SIGHT-VERT-KNOB-PTR"]						= default_axis(_("Sight Crosshair Vertical Adjustment"),			devices.ASP_17V,	asp_commands.Elevation_Delta,	556,	0,	0.0125,	false,	false,	false)
elements["SIGHT-BASE-KNOB-PTR"]						= default_axis(_("Sight Base and Range Adjustment"),				devices.ASP_17V,	asp_commands.Base_Range,		557,	0,	0.05,	false,	false,	false)
elements["SIGHT-BASE-KNOB-PTR"].turn_box = {180,0,0}
elements["SIGHT-CROSSHAIR-BRIGHNTNESS-KNOB-PTR"]	= default_axis(_("Sight Crosshair Brightness Adjustment"),			devices.ASP_17V,	asp_commands.Brightness_PM,		564,	0,	0.05,	false,	false,	false)
elements["SIGHT-HOR-KNOB-PTR"]						= default_axis(_("Sight Crosshair Horizontal Adjustment"),			devices.ASP_17V,	asp_commands.Azimuth_Delta,		566,	0,	0.0125,	false,	false,	false)
elements["SIGHT-GRID-BRIGHNTNESS-KNOB-PTR"]			= default_axis(_("Sight Grid Brightness Adjustment"),				devices.ASP_17V,	asp_commands.Brightness_NS,		567,	0,	0.05,	false,	false,	false)
elements["SIGHT-CROSSHAIR-BACKUP-PTR"]				= default_2_position_small_tumb(_("Sight Crosshair Lamp MAIN/BACKUP"),	devices.ASP_17V,	asp_commands.Backup_Light_PM,	568)
elements["SIGHT-GRID-BACKUP-PTR"]					= default_2_position_small_tumb(_("Sight Grid Lamp MAIN/BACKUP"),			devices.ASP_17V,	asp_commands.Backup_Light_NS,	569)
elements["SIGHT-CONTROL-PTR"]						= default_button(_("Sight Check"),								devices.ASP_17V,	asp_commands.Control,			570)

elements["WEAP-DISTR-POWER-OP-PTR"]					= default_2_position_tumb(_("USR power"),							devices.ASP_17V,	asp_commands.USR,				761, nil, 1)
elements["WEAP-DISTR-CONTROL-OP-PTR"]				= default_3_position_tumb(_("USR check"),							devices.ASP_17V,	asp_commands.USR_check,			762, nil, nil, nil, nil, nil, 1)

elements["ILS-ADJUST-HANDLE-PTR"] = {
	class					= {class_type.TUMB, 	  class_type.LEV,					   0, 					   0},
	hint					= _("Sight reflector control"),
	device					= devices.ASP_17V,
	action					= {asp_commands.Reflector_Fix, asp_commands.Reflector_Move, asp_commands.Reflector_Fix, asp_commands.Reflector_Move},
	is_repeatable			= {false,						   false, 			   false, 				   false},
	cycle					= {false,						   false, 			   false, 				   false},
	arg						= {1005, 			 			    1006,				1005, 		 			1006},
	arg_value				= {-1, 							     -0.1,		   		   1, 		 			 0.1},
	arg_lim					= {{0.0, 1.0},				  {0.0, 1.0}, 		  {0.0, 1.0}, 			  {0.0, 1.0}},
	gain					= {1.0,			 				   -0.01,		   		 1.0, 				    0.01},
	use_release_message		= {false,				 		   false, 			   false, 				   false},
	use_OBB					= true,             
	relative				= {false, 				 		   false, 			   false,				   false},
	updatable				= true,             
	class_vr				= {class_type.TUMB, 	 class_type.TUMB,	 class_type.TUMB, 		 class_type.TUMB},
	side					= {{BOX_SIDE_X_top}, {BOX_SIDE_Z_bottom},{BOX_SIDE_X_bottom},	  	{BOX_SIDE_Z_top}},
	crew_member_access  	= {0}
}

--elements["BRAKE-LEVEL-OP-PTR"] = default_axis_limited(_("PKI reflector control"), devices.PKV, pki_commands.Reflector_Move, 846, 0.0, 0.05, nil, nil, nil, nil, nil, 1)

elements["SIGHT-OP-BRIGHTNESS-PTR"]	= default_axis(_("PKI Brightness Adjustment"),	devices.PKV, pki_commands.Brightness, 136,	0,	0.05,	false,	false,	false, nil, nil, 1)

elements["BRAKE-LEVEL-OP-PTR"] = {
	class					= {class_type.TUMB, class_type.LEV, 0},
	hint					= _("PKI control"),
	device					= devices.PKV,
	action					= {pki_commands.Lock_Unlock, pki_commands.Reflector_Move, pki_commands.Reflector_Move},
	is_repeatable			= {false, 				false, 				    false},
	cycle					= {false, 				false, 				    false},
	arg						= {15, 					846, 					  846},
	arg_value				= {0.0, 				0.0, 					  0.0},
	arg_lim					= {{0.0, 1.0}, 			{0.0, 1.0}, 	   {0.0, 1.0}},
	gain					= {1.0, 				-0.01,				  	-0.01},
	use_release_message		= {false, 				false,				  	false},
	use_OBB					= true,
	relative				= {false, 				false,				  	false},
	updatable				= true,
	class_vr				= {class_type.BTN_FIX,  class_type.MOVABLE_LEV, class_type.MOVABLE_LEV},
	side					= {{BOX_SIDE_Y_bottom}, {BOX_SIDE_X_top}, 		{BOX_SIDE_X_bottom}},
	crew_member_access  = {1}
}
elements["BRAKE-LEVEL-OP-PTR"].updatable				= true

--PUVL
elements["WEAP-DIST-MAN-AUTO-PTR"]					= default_2_position_tumb(_("Sight distance MANUAL/AUTO"),			devices.ASP_17V,	asp_commands.Range_Auto_Manual,	515)
elements["WEAP-SIGHT-ON-PFF-PTR"]					= default_2_position_tumb(_("Sight Power ON/OFF"),					devices.ASP_17V,	asp_commands.Power,				529)
elements["WEAP-SIGHT-RESET-PTR"]					= default_button(_("Sight Reset Crosshair"),						devices.ASP_17V,	asp_commands.Sight_Null,		528)
elements["WEAP-SIGHT-RESET-PTR"].turn_box = {90,0,-90}
elements["WEAP-SIGHT-DIST-PTR"]						= default_axis(_("Sight Range Adjustment"),							devices.ASP_17V,	asp_commands.Range_Value,		552,	0,	0.05,	false,	false,	false)
elements["WEAP-SIGHT-DIST-PTR"].turn_box = {-90,-90,0}

--R60 control
elements["R60-POWER-PTR"]				= default_2_position_tumb(_("R60 Power"),				devices.R60_INTERFACE,	R60_commands.Power_OnOff,	1033)
elements["R60-AIR-PTR"]					= default_2_position_tumb(_("Fuse selector"),			devices.R60_INTERFACE,	R60_commands.NC_VC,	1034)
elements["PU-SELECT-PTR"]				= multiposition_switch(_("Active missile selector"),	devices.R60_INTERFACE,	R60_commands.StationSelector,	1032,	5,	0.1)



--USB-1-2A
elements["ROUNDS-KNOB-1"]				= default_axis(_("Counter Adjustment 1"),	devices.WEAP_SYS,	weapon_commands.Pilot_Counter1,		719,	0,	0.1,	false,	true,	true)
elements["ROUNDS-KNOB-2"]				= default_axis(_("Counter Adjustment 2"),	devices.WEAP_SYS,	weapon_commands.Pilot_Counter2,		723,	0,	0.1,	false,	true,	true)
elements["ROUNDS-KNOB-3"]				= default_axis(_("Counter Adjustment 3"),	devices.WEAP_SYS,	weapon_commands.Pilot_Counter3,		727,	0,	0.1,	false,	true,	true)
elements["ROUNDS-KNOB-4"]				= default_axis(_("Counter Adjustment 4"),	devices.WEAP_SYS,	weapon_commands.Pilot_Counter4,		731,	0,	0.1,	false,	true,	true)
elements["ROUNDS-KNOB-5"]				= default_axis(_("Counter Adjustment 5"),	devices.WEAP_SYS,	weapon_commands.Pilot_Counter5,		735,	0,	0.1,	false,	true,	true)


--ASO-2V
elements["ASO2V-RESET-PTR"]				= default_button(_("Launch Countermeasures"),			devices.ASO_2V,	avASO_2V_commands.ASO_2V_Release, 968, nil, 1)
elements["ASO2V-RESET-PTR"].turn_box = {0,0,-90}
elements["ASO2V-SETS-PTR"]				= triple_switch(_("Set I/II/III"),	devices.ASO_2V,	avASO_2V_commands.ASO_2V_Set_I_II_III,	971, 1)
elements["ASO2V-SETS-PTR"].turn_box = {0,-120,180}
elements["ASO2V-INTERV-PTR"]			= default_2_position_tumb(_("Interval"), 	devices.ASO_2V,	avASO_2V_commands.ASO_2V_Interval_2_4, 1008, nil, 1)
elements["ASO2V-INTERV-PTR"].turn_box = {0,90,0}
elements["ASO2V-SERIES-PTR"]			= default_2_position_tumb(_("Serie"), 		devices.ASO_2V,	avASO_2V_commands.ASO_2V_Series_4_16, 965, nil, 1)
elements["ASO2V-SERIES-PTR"].turn_box = {0,90,0}
elements["ASO2V-LEFT-PTR"]				= default_2_position_tumb(_("Left Side"), 	devices.ASO_2V,	avASO_2V_commands.ASO_2V_Left, 969, nil, 1)
elements["ASO2V-RIGHT-PTR"]				= default_2_position_tumb(_("Right Side"), 	devices.ASO_2V,	avASO_2V_commands.ASO_2V_Right, 970, nil, 1)
elements["ASO-ON-PTR"]					= default_button(_("Pilot Launch Snars"),	devices.ASO_2V,	avASO_2V_commands.ASO_2V_Release_Pilot, 847)

--SPO-10
elements["GFORCE-RESET-PTR001"]			= default_button(_("Check RWR"),					devices.SPO_10,	SPO_commands.Command_SPO_CHECK,	990)
elements["MAPDISPLAY-VERT-PTR001"]		= default_2_position_tumb(_("RWR DAY/NIGHT"),		devices.SPO_10,	SPO_commands.Command_DAY_NIGHT,	989)
elements["SIRENA-POWER-PTR"]			= default_2_position_tumb(_("RWR Power"),			devices.SPO_10,	SPO_commands.Command_SPO_POWER,	366)
elements["SIRENA-SIGNAL-PTR"]			= default_2_position_tumb(_("RWR Signal"),			devices.SPO_10,	SPO_commands.Command_SPO_SIGNAL,365)

--ZK (pod oknom)
elements["RMI-COURSE-KNOB-PTR"]	= default_axis(_("Course setter"),			devices.GREBEN,	greben_commands.ZK,	858,	0,	0.5,	true,	true,	true)
elements["RMI-COURSE-KNOB-PTR"].turn_box = {-90,-90,0}
--GREBEN
elements["GREBEN-ON-PFF-PTR"]	= default_2_position_tumb(_("Greben' ON/OFF"),				devices.GREBEN,	greben_commands.POWER,		367)
elements["GREBEN-MATCH-PTR"]	= default_button(_("Greben Match"),							devices.GREBEN,	greben_commands.MATCH,		450)
elements["GREBEN-SETUP-PTR"]	= default_2_position_tumb(_("Greben' mode SETUP/OPER"),		devices.GREBEN,	greben_commands.SETUP_OPER,	451)
elements["GREBEN-SETUP-PTR"].turn_box = {0,180,0}
elements["GREBEN-MODE-PTR"]		= default_3_position_tumb(_("Greben' mode ZK/GPK/MK"),		devices.GREBEN,	greben_commands.MODE,		449)
elements["GREBEN-LATITUDE-PTR"]	= default_axis(_("Greben Set Latitude"),					devices.GREBEN,	greben_commands.LATITUDE,	448,	0,	-2/3,	true,	true,	true)

elements["KM2-CONTR-BUTTON-PTR"]= default_button(_("KM-2 Test button"),					devices.KM_2, avKM_2_commands.TEST, 645, nil, 1)
elements["KM2-KNOB-PTR"]		= default_axis(_("KM-2 set magnetic declination "),		devices.KM_2, avKM_2_commands.MagneticDeclRotary, 647, 0, 0.1,	true,	true,	true, nil, nil, 1)
elements["KM2-KNOB-PTR"].turn_box = {180,0,0}

--DISS
elements["DISS-ON-OFF-PTR"]			= default_2_position_tumb(_("DISS-15D ON/OFF"),						devices.DISS_15,	diss_commands.POWER,					371)
elements["DVS-DISS-PTR"]			= default_2_position_tumb(_("Airspeed to DISS ON/OFF"),				devices.DISS_15,	diss_commands.DVS,						370)
elements["PTR-DISS-BTN-OFF"]		= default_square_button(_("DISS coordinates OFF"),					devices.DISS_15,	diss_commands.COORD_OFF,				818)
elements["PTR-DISS-BTN-OFF"].turn_box = {-90,0,-90}
elements["PTR-DISS-BTN-ON"]			= default_square_button(_("DISS coordinates ON"),					devices.DISS_15,	diss_commands.COORD_ON,					819)
elements["PTR-DISS-BTN-ON"].turn_box = {-90,0,-90}
elements["PTR-DISS-BTN-MINUS"]		= default_square_button(_("DISS decrease map angle"),				devices.DISS_15,	diss_commands.COORD_DEC_MAP_ANGLE,		815)
elements["PTR-DISS-BTN-MINUS"].turn_box = {-90,0,-90}
elements["PTR-DISS-BTN-PLUS"]		= default_square_button(_("DISS increase map angle"),				devices.DISS_15,	diss_commands.COORD_INC_MAP_ANGLE,		816)
elements["PTR-DISS-BTN-PLUS"].turn_box = {-90,0,-90}
elements["PTR-DISS-BTN-N"]			= default_square_button(_("DISS decrease path"),					devices.DISS_15,	diss_commands.COORD_DEC_PATH_KM,		809)
elements["PTR-DISS-BTN-N"].turn_box = {-90,0,-90}
elements["PTR-DISS-BTN-V"]			= default_square_button(_("DISS increase path"),					devices.DISS_15,	diss_commands.COORD_INC_PATH_KM,		810)
elements["PTR-DISS-BTN-V"].turn_box = {-90,0,-90}
elements["PTR-DISS-BTN-TOLE"]		= default_square_button(_("DISS decrease deviation"),				devices.DISS_15,	diss_commands.COORD_DEC_DEVIATION_KM,	803)
elements["PTR-DISS-BTN-TOLE"].turn_box = {-90,0,-90}
elements["PTR-DISS-BTN-TORI"]		= default_square_button(_("DISS increase deviation"),				devices.DISS_15,	diss_commands.COORD_INC_DEVIATION_KM,	804)
elements["PTR-DISS-BTN-TORI"].turn_box = {-90,0,-90}
elements["DRIFT-R-K-PTR"]			= default_2_position_tumb(_("DISS Mode WORK/CHECK"),				devices.DISS_15,	diss_commands.W_CHECK_WORK,				797)
elements["DRIFT-R-K-PTR"].turn_box = {-90,-90,0}
elements["DRIFT-S-M-PTR"]			= default_2_position_tumb(_("DISS Mode LAND/SEA"),					devices.DISS_15,	diss_commands.W_LAND_SEA,				798)
elements["DRIFT-S-M-PTR"].turn_box = {-90,-90,0}
elements["DISS-SELECTOR-KNOB-PTR"]	= multiposition_switch(_("DISS select mode IDK/IDK/IDK/MEM/OPER"),	devices.DISS_15,	diss_commands.CHECK_SWITCH,				826,	5,	0.1)
elements["DISS-SELECTOR-KNOB-PTR"].turn_box = {-90,0,0}
--MAP DISPLAY
elements["MAP-LIGHT-PTR"]			= default_3_position_tumb(_("Map Highlight  BRIGHT/OFF/DIM"),		devices.MAP_DISPLAY,	map_display_commands.Lights,		192)
elements["MAP-LIGHT-PTR"].turn_box = {-90,0,-90}
elements["MAPDISPLAY-HOR-PTR"]		= default_axis(_("Set the horizontall position of the helicopter on the Map "),	devices.MAP_DISPLAY,	map_display_commands.HorAdj,		983, 0,	0.05, false, true, nil, nil)
elements["MAPDISPLAY-VERT-PTR"]		= default_axis(_("Set the vertical position of the helicopter on the Map "),	devices.MAP_DISPLAY,	map_display_commands.VertAdj,		291, 0,	0.05, false, true, nil, nil)
elements["MAPDISPLAY-POWER-PTR"]	= default_2_position_tumb(_("Map Power ON/OFF"),					devices.MAP_DISPLAY,	map_display_commands.Power,				984)
elements["MAPDISPLAY-POWER-PTR"].turn_box = {0,180,0}
elements["MAPDISPLAY-SCALE-PTR"]	= default_2_position_tumb(_("Map Scale Selector"),				devices.MAP_DISPLAY,	map_display_commands.Scale,				985)
elements["MAPDISPLAY-SCALE-PTR"].turn_box = {0,180,0}

--one valvy thing
elements["STATIC-VALVE-PTR"]					= default_3_position_tumb(_("Static valve sensor select LEFT/BOTH/RIGHT"),	devices.FM_PROXY,	fmproxy_commands.STATIC_SYS_MODE,	520)
elements["STATIC-VALVE-PTR"].animation_speed	= {4,4}
elements["STATIC-VALVE-PTR"].turn_box = {0,90,0}

--ARC-15
elements["ARC-VOLUME-PTR"]				= default_axis(				_("ARC-15 Volume"),						devices.ARC_15_PANEL_P,	arc15_commands.VOLUME,			459,	0,	0.05,	false,	false,	false)
elements["ARC-MODULATED-PTR"]			= default_2_position_small_tumb(	_("ARC-15 TLF/TLG"),					devices.ARC_15_PANEL_P,	arc15_commands.TLF_TLG,			460)
elements["ARC-MODULATED-PTR"].turn_box = {0,180,0}
elements["ARC-MODE-PTR"]				= multiposition_switch(		_("ARC-15 mode OFF/COMPASS/ANT/FRAME"),	devices.ARC_15_PANEL_P,	arc15_commands.MODE,			463,	4,	0.115)
elements["ARC-MODE-PTR"].turn_box = {0,135,0}
elements["ARC-CH1-OUT-KNOB"]			= multiposition_switch(		_("ARC-15 Left Frequency"),				devices.ARC_15_PANEL_P,	arc15_commands.BACKUP_100KHz,	467,	18,	1/17)
elements["ARC-CH1-OUT-KNOB"].sound		= {{SOUND_SW9_1}}
elements["ARC-CH1-CENTER-PTR"]			= multiposition_switch(		_("ARC-15 Left Frequency"),				devices.ARC_15_PANEL_P,	arc15_commands.BACKUP_10KHz,	468,	10,	1/9)
elements["ARC-CH1-CENTER-PTR"].sound	= {{SOUND_SW9_2}}
elements["ARC-CH1-CENTER-PTR"].turn_box = {90,90,0}
elements["ARC-CH1-IN-PTR"]				= multiposition_switch(		_("ARC-15 Left Frequency"),				devices.ARC_15_PANEL_P,	arc15_commands.BACKUP_1KHz,		469,	20,	1/20)
elements["ARC-CH1-IN-PTR"].sound		= {{SOUND_SW9_3}}
elements["ARC-CH2-OUT-KNOB"]			= multiposition_switch(		_("ARC-15 Right Frequency"),			devices.ARC_15_PANEL_P,	arc15_commands.PRIMARY_100KHz,	464,	18,	1/17)
elements["ARC-CH2-OUT-KNOB"].sound		= {{SOUND_SW9_1}}
elements["ARC-CH2-CENTER-PTR"]			= multiposition_switch(		_("ARC-15 Right Frequency"),			devices.ARC_15_PANEL_P,	arc15_commands.PRIMARY_10KHz,	465,	10,	1/9)
elements["ARC-CH2-CENTER-PTR"].sound	= {{SOUND_SW9_2}}
elements["ARC-CH2-CENTER-PTR"].turn_box = {90,90,0}
elements["ARC-CH2-IN-PTR"]				= multiposition_switch(		_("ARC-15 Right Frequency"),			devices.ARC_15_PANEL_P,	arc15_commands.PRIMARY_1KHz,	466,	20,	1/20)
elements["ARC-CH2-IN-PTR"].sound		= {{SOUND_SW9_3}}
elements["ARC-FRAME-PTR"]				= default_button(			_("ARC-15 Loop Button"),				devices.ARC_15_PANEL_P,	arc15_commands.LOOP,			458)
elements["ARC-CHANNEL-PTR"]				= default_2_position_small_tumb(	_("ARC-15 1/2"),				devices.ARC_15_PANEL_P,	arc15_commands.DIAL_SELECT,		462)
elements["ARC-CHANNEL-PTR"].turn_box = {0,180,0}
elements["ARC-AUTH-PTR"]				= default_button(			_("ARC-15 Control Button"),				devices.ARC_15_PANEL_P,	arc15_commands.CONTROL,			461)

elements["ARC-OP-VOLUME-PTR"]			= default_axis(				_("ARC-15 Volume"),						devices.ARC_15_PANEL_O,	arc15_commands.VOLUME,			634,	0,	0.05,	false,	false,	false, nil, nil, 1)
elements["ARC-OP-MODULATED-PTR"]		= default_2_position_small_tumb(	_("ARC-15 TLF/TLG"),					devices.ARC_15_PANEL_O,	arc15_commands.TLF_TLG,			635, nil, 1)
elements["ARC-OP-MODULATED-PTR"].turn_box = {0,180,0}
elements["ARC-OP-MODE-PTR"]				= multiposition_switch(		_("ARC-15 mode OFF/COMPASS/ANT/FRAME"),	devices.ARC_15_PANEL_O,	arc15_commands.MODE,			638,	4,	0.115, nil, nil, nil, nil, 1)
elements["ARC-OP-MODE-PTR"].turn_box = {0,145,0}
elements["ARC-OP-CH2-OUT-KNOB"]			= multiposition_switch(		_("ARC-15 Left Frequency"),				devices.ARC_15_PANEL_O,	arc15_commands.BACKUP_100KHz,	639,	18,	1/17, nil, nil, nil, nil, 1)
elements["ARC-OP-CH2-OUT-KNOB"].sound	= {{SOUND_SW9_1}}
elements["ARC-OP-CH2-CENTER-PTR"]		= multiposition_switch(		_("ARC-15 Left Frequency"),				devices.ARC_15_PANEL_O,	arc15_commands.BACKUP_10KHz,	640,	10,	1/9, nil, nil, nil, nil, 1)
elements["ARC-OP-CH2-CENTER-PTR"].sound	= {{SOUND_SW9_2}}
elements["ARC-OP-CH2-CENTER-PTR"].turn_box = {0,-90,0}
elements["ARC-OP-CH2-IN-PTR"]			= multiposition_switch(		_("ARC-15 Left Frequency"),				devices.ARC_15_PANEL_O,	arc15_commands.BACKUP_1KHz,		641,	20,	1/20, nil, nil, nil, nil, 1)
elements["ARC-OP-CH2-IN-PTR"].sound		= {{SOUND_SW9_3}}
elements["ARC-OP-CH1-OUT-KNOB"]			= multiposition_switch(		_("ARC-15 Right Frequency"),			devices.ARC_15_PANEL_O,	arc15_commands.PRIMARY_100KHz,	642,	18,	1/17, nil, nil, nil, nil, 1)
elements["ARC-OP-CH1-OUT-KNOB"].sound	= {{SOUND_SW9_1}}
elements["ARC-OP-CH1-CENTER-PTR"]		= multiposition_switch(		_("ARC-15 Right Frequency"),			devices.ARC_15_PANEL_O,	arc15_commands.PRIMARY_10KHz,	643,	10,	1/9, nil, nil, nil, nil, 1)
elements["ARC-OP-CH1-CENTER-PTR"].sound	= {{SOUND_SW9_2}}
elements["ARC-OP-CH1-CENTER-PTR"].turn_box = {90,-90,0}
elements["ARC-OP-CH1-IN-PTR"]			= multiposition_switch(		_("ARC-15 Right Frequency"),			devices.ARC_15_PANEL_O,	arc15_commands.PRIMARY_1KHz,	644,	20,	1/20, nil, nil, nil, nil, 1)
elements["ARC-OP-CH1-IN-PTR"].sound		= {{SOUND_SW9_3}}
elements["ARC-OP-FRAME-PTR"]			= default_button(			_("ARC-15 Loop Button"),				devices.ARC_15_PANEL_O,	arc15_commands.LOOP,			633, nil, 1)
elements["ARC-OP-CHANNEL-PTR"]			= default_2_position_small_tumb(	_("ARC-15 1/2"),				devices.ARC_15_PANEL_O,	arc15_commands.DIAL_SELECT,		637, nil, 1)
elements["ARC-OP-CHANNEL-PTR"].turn_box = {0,180,0}
elements["ARC-OP-AUTH-PTR"]				= default_button(			_("ARC-15 Control Button"),				devices.ARC_15_PANEL_O,	arc15_commands.CONTROL,			636, nil, 1)


--R863
elements["R863-ON-OFF-PTR"]			= default_2_position_tumb(	_("R-863 ON/OFF"),						devices.R_863,	r863_commands.POWER,		375)
elements["R863-MODULATION-PTR"]		= default_2_position_tumb(	_("R-863 FM/AM"),						devices.R_863,	r863_commands.AM_FM,		506)
elements["R863-AP-PTR"]				= default_2_position_tumb(	_("R-863 Emergency Receiver ON/OFF"),	devices.R_863,	r863_commands.EMERG_RCV,	507)
elements["R863-AP-PTR"].turn_box = {0,180,0}
elements["R863-RK-PTR"]				= default_2_position_tumb(	_("R-863 ARC-UD ON/OFF"),				devices.R_863,	r863_commands.ARC,			509)
elements["R863-RK-PTR"].turn_box = {0,180,0}
elements["R863-PSH-PTR"]			= default_2_position_tumb(	_("R-863 Squelch ON/OFF"),				devices.R_863,	r863_commands.SQUELCH,		510)
elements["R863-PSH-PTR"].turn_box = {0,180,0}
elements["R863-VOLUME-KNOB-PTR"]	= default_axis(				_("R-863 Volume"),						devices.R_863,	r863_commands.VOLUME,		511,	0,	0.05,	false,	false,	false)
elements["R863-CHANNEL-PTR"]		= multiposition_switch(		_("R-863 Channel Select"),				devices.R_863,	r863_commands.CHANNEL_SEL,	513,	20,	1/20)

--Jadro 1I
elements["JADRO-ON-OFF-PTR"] 		= default_2_position_tumb(	_("Jadro-1I ON/OFF"),			devices.JADRO_1I,	jadro_commands.POWER,		374)
elements["JADRO-MODULATION-PTR"] 	= multiposition_switch(		_("Jadro-1I Mode OFF/AM/OM"),	devices.JADRO_1I,	jadro_commands.MODE,		438,	3,	0.1)
elements["JADRO-MODULATION-PTR"].turn_box = {0,45,0}
elements["JADRO-VOLUME-PTR"]		= default_axis(				_("Jadro-1I Volume"),			devices.JADRO_1I,	jadro_commands.VOLUME,		426,	0,	0.05,	false,	false,	false)
elements["JADRO-PSH-PTR"]			= default_axis(				_("Jadro-1I Squelch"),			devices.JADRO_1I,	jadro_commands.SQUELCH,		421,	0,	0.05,	false,	false,	false)
elements["JADRO-CONTROL-PTR"]		= default_button(			_("Jadro-1I Test"),				devices.JADRO_1I,	jadro_commands.CTL,			423)
elements["JADRO-001-PTR"]			= radio_wheel_1(			_("Jadro-1I Frequency"),		devices.JADRO_1I,	jadro_commands.FREQ_1MHZ,	437,	{-0.1, 0.1}, {0,1},{434,{0.0,1.0}, 1.0,slave = {435,{0.0,1.0},1.0,master_lim = {0.9,1.0}}})
elements["JADRO-01-PTR"]			= radio_wheel_1(			_("Jadro-1I Frequency"),		devices.JADRO_1I,	jadro_commands.FREQ_100KHZ,	436,	{-0.1, 0.1}, {0,1},{433,{0.0,1.0}})
elements["JADRO-1-PTR"]				= radio_wheel_1(			_("Jadro-1I Frequency"),		devices.JADRO_1I,	jadro_commands.FREQ_10KHZ,	429,	{-0.1, 0.1}, {0,1},{432,{0.0,1.0}})
elements["JADRO-10-PTR"]			= radio_wheel_1(			_("Jadro-1I Frequency"),		devices.JADRO_1I,	jadro_commands.FREQ_1KHZ,	428,	{-0.1, 0.1}, {0,1},{431,{0.0,1.0}})
elements["JADRO-100-PTR"]			= radio_wheel_1(			_("Jadro-1I Frequency"),		devices.JADRO_1I,	jadro_commands.FREQ_100HZ,	427,	{-0.1, 0.1}, {0,1},{430,{0.0,1.0}})

--Eucalypt_M24 (R828)
elements["R828-ON-OFF-PTR"]		= default_2_position_tumb(	_("R-828 ON/OFF"),			devices.EUCALYPT_M24,	eucalypt_commands.POWER_ON_OFF2,			373)
elements["EUCAL-CHANNEL-PTR"]	= multiposition_switch(		_("R-828 Channel Select"),	devices.EUCALYPT_M24,	eucalypt_commands.CHANNEL_CHANGE,			337,	10,	0.1)
elements["EUCAL-VOLUME-PTR"]	= default_axis(				_("R-828 Volume"),			devices.EUCALYPT_M24,	eucalypt_commands.VOLUME_CHANGE,			339,	0,	0.05,	false,	false,	false)
elements["EUCAL-ASY-PTR"]		= default_button(			_("R-828 ASU"),				devices.EUCALYPT_M24,	eucalypt_commands.ASU,						340)
elements["EUCAL-PSH-PTR"]		= default_2_position_small_tumb(	_("R-828 Squelch ON/OFF"),	devices.EUCALYPT_M24,	eucalypt_commands.NOISE_REDUCTOR_ON_OFF2,	341)

--R852
elements["R852-VOLUME-KNOB-PTR"]	= default_axis(			_("R-852 Volume"),			devices.R_852,	r852_commands.VOLUME,	517,	0,	0.05,	false,	false,	false)
elements["R852-CHANNEL-PTR"]		= multiposition_switch(	_("R-852 Channel Select"),	devices.R_852,	r852_commands.CHANNEL,	518,	4,	0.1)


--radar altimeter
elements["RAD-ALT-ON-OFF-PTR"]		= default_2_position_tumb(_("RV-5 ON/OFF"),						devices.RADAR_ALTIMETER,	ralt_commands.POWER,					372)
elements["RADAR-ALTIMETER-KNOB-PTR"] = {
	class					= {class_type.BTN, class_type.LEV},
	hint					= _("Radar altimeter adjust and test"),
	device					= devices.RADAR_ALTIMETER,
	action					= {ralt_commands.TEST, ralt_commands.ROTARY},
	stop_action				= {ralt_commands.TEST, 0},
	is_repeatable			= {},
	arg						= {31, 30},
	arg_value				= {1.0, 0.05},
	arg_lim					= {{0.0, 1.0}, {0.0, 1.0}},
	gain					= {1.0, 0.05},
	use_release_message		= {true, false},
	use_OBB					= true,
	relative				= {nil, true},
	sound					= {{SOUND_SW5_ON,SOUND_SW5_OFF},{SOUND_SW6,SOUND_SW6}},
	side					= {{BOX_SIDE_Y_bottom},{BOX_SIDE_X_top, BOX_SIDE_X_bottom, BOX_SIDE_Z_top, BOX_SIDE_Z_bottom}},
	--attach_left				= {80,-45},
	turn_box				= {-90,-90,0},
	crew_member_access  = {0}
}
--Accelerometer
elements["GFORCE-RESET-PTR"] = default_button(_("Accelerometer Reset Button - Push to reset"), devices.G_Meter, G_Meter_commands.Command_AccelReset, 947)
elements["GFORCE-RESET-PTR"].turn_box = {-90,-90,0}

--ARK U2
elements["ARC-U2-ON-OFF-PTR"] = default_2_position_tumb(_("ARC-U2 switcher On/Off"), devices.ARC_U2, ARC_U2_commands.CMD_ARC_U2_ON_OFF, 324)
--elements["ARC-U2-FRAME-PTR"] = default_3_position_tumb(_("ARC-U2 switcher L–RAMKA-P"), devices.ARC_U2, ARC_U2_commands.CMD_ARC_U2_FRAME, 325)
elements["ARC-U2-FRAME-PTR"] = springloaded_3_pos_tumb(_("ARC-U2 switcher L–RAMKA-P"), devices.ARC_U2, ARC_U2_commands.CMD_ARC_U2_FRAME_LEFT, ARC_U2_commands.CMD_ARC_U2_FRAME_RIGHT, 325, anim_speed_default * 1.5)
elements["ARC-U2-FRAME-PTR"].turn_box = {0,180,0}
elements["ARC-U2-SENS-PTR"] = default_2_position_tumb(_("ARC-U2 switcher sensitivity B-M"), devices.ARC_U2, ARC_U2_commands.CMD_ARC_U2_SENS, 326)
elements["ARC-U2-COMPASS-CONNECT-PTR"] = default_3_position_tumb(_("ARC-U2 switcher COMPASS R-852–RADIOLINK–COMPASS R-828"), devices.ARC_U2, ARC_U2_commands.CMD_ARC_U2_COMPASS_CONNECT, 327)
elements["ARC-U2-COMPASS-CONNECT-PTR"].turn_box = {0,180,0}

-- SPU-8 PILOT
elements["SPU8-NET-PTR"] = default_2_position_tumb(_("Network 1/2 Switch (N/F)"), devices.SPU_8, SPU_8_Mi24_commands.CMD_SPU8_P_NETWORK, 452)
elements["SPU8-NET-PTR"].turn_box = {0,180,0}
elements["SPU8-RADIO-VOL-KNOB-PTR"]	= default_axis_limited(_("SPU-8 Radio Volume Knob"), devices.SPU_8, SPU_8_Mi24_commands.CMD_SPU8_P_RADIO_VOLUME, 453, 0.0, 0.05)
elements["SPU8-CV-PTR"]	= default_button(_("Circular Call Button (N/F)"), devices.SPU_8, SPU_8_Mi24_commands.CMD_SPU8_P_CIRC_FLOW, 454)
elements["SPU8-MODE-PTR"] = multiposition_switch(_("Radio Source Selector Switch, R-863/NF/JADRO-1A/R-828(Eucalypt)/ARC-15/ARC-U2"), devices.SPU_8, SPU_8_Mi24_commands.CMD_SPU8_P_MODE, 455, 6, 1/5)
elements["SPU8-MODE-PTR"].turn_box = {0,180,0}
elements["SPU8-EXT-PTR"] = default_2_position_tumb(	_("Radio/ICS Switch"), devices.SPU_8, SPU_8_Mi24_commands.CMD_SPU8_P_ICS_RADIO, 456)
elements["SPU8-EXT-PTR"].turn_box = {0,180,0}
elements["SPU8-VOLUME-PTR"]	= default_axis_limited(_("SPU-8 Volume Knob"), devices.SPU_8, SPU_8_Mi24_commands.CMD_SPU8_P_MAIN_VOLUME, 457, 0.0, 0.05)
elements["STICK-PTT-PTR"]	= {	
	class 				= {class_type.BTN, class_type.BTN},
	hint  				= _("Trigger Button, RADIO(LMB)/ICS(RMB)"),
	device 				= devices.SPU_8,
	action 				= {SPU_8_Mi24_commands.CMD_SPU8_TRIGGER_P, SPU_8_Mi24_commands.CMD_SPU8_TRIGGER_P},
	stop_action 		= {SPU_8_Mi24_commands.CMD_SPU8_TRIGGER_P, SPU_8_Mi24_commands.CMD_SPU8_TRIGGER_P},
	arg 				= {738, 738},
	arg_value			= {1.0, 0.5}, 
	arg_lim 			= {{0.0, 1.0}, {0.0, 0.5}},
	updatable			= true,
	use_release_message = {true},
	crew_member_access  = {0}
}

elements["SPU8-1-ON-OFF-PTR"] = default_2_position_tumb(_("Switch SPU-8 NET-1 ON/OFF"),	devices.SPU_8,	SPU_8_Mi24_commands.CMD_SPU8_NETWORK_1,	376)
elements["SPU8-2-ON-OFF-PTR"] = default_2_position_tumb(_("Switch SPU-8 NET-2 ON/OFF"),	devices.SPU_8,	SPU_8_Mi24_commands.CMD_SPU8_NETWORK_2,	377)

-- SPU-8 OPERATOR
elements["SPU8-OP-NET-PTR"] = default_2_position_tumb(_("Network 1/2 Switch (N/F)"), devices.SPU_8, SPU_8_Mi24_commands.CMD_SPU8_O_NETWORK, 656, nil, 1)
elements["SPU8-OP-NET-PTR"].turn_box = {0,180,0}
elements["SPU8-OP-RADIO-VOL-KNOB-PTR"] = default_axis_limited(_("SPU-8 Radio Volume Knob"), devices.SPU_8, SPU_8_Mi24_commands.CMD_SPU8_O_RADIO_VOLUME, 657, 0.0, 0.05, nil, nil, nil, nil, nil, 1)
elements["SPU8-OP-CV-PTR"]	= default_button(_("Circular Call Button (N/F)"), devices.SPU_8, SPU_8_Mi24_commands.CMD_SPU8_O_CIRC_FLOW, 658, nil, 1)
elements["SPU8-OP-MODE-PTR"] = multiposition_switch(_("Radio Source Selector Switch, R-863/NF/JADRO-1A/R-828(Eucalypt)/ARC-15/ARC-U2"), devices.SPU_8, SPU_8_Mi24_commands.CMD_SPU8_O_MODE, 659,  6, 1/5, nil, nil, nil, nil, 1)
elements["SPU8-OP-MODE-PTR"].turn_box = {0,180,0}
elements["SPU8-OP-EXT-PTR"] = default_2_position_tumb(_("Radio/ICS Switch"), devices.SPU_8, SPU_8_Mi24_commands.CMD_SPU8_O_ICS_RADIO, 660, nil, 1)
elements["SPU8-OP-EXT-PTR"].turn_box = {0,180,0}
elements["SPU8-OP-VOLUME-PTR"]	= default_axis_limited(_("SPU-8 Volume Knob"), devices.SPU_8, SPU_8_Mi24_commands.CMD_SPU8_O_MAIN_VOLUME, 661, 0.0, 0.05, nil, nil, nil, nil, nil, 1)
elements["SPU8-OP-PTR"]	= default_2_position_tumb(_("SPU-8 Intercom Power ON/OFF"),	devices.SPU_8,	SPU_8_Mi24_commands.CMD_SPU8_O_ICS,	664, nil, 1)
elements["OP-STICK-PTT-PTR"] = {	
	class 				= {class_type.BTN, class_type.BTN},
	hint  				= _("Trigger Button, RADIO(LMB)/ICS(RMB)"),
	device 				= devices.SPU_8,
	action 				= {SPU_8_Mi24_commands.CMD_SPU8_TRIGGER_O, SPU_8_Mi24_commands.CMD_SPU8_TRIGGER_O},
	stop_action 		= {SPU_8_Mi24_commands.CMD_SPU8_TRIGGER_O, SPU_8_Mi24_commands.CMD_SPU8_TRIGGER_O},
	arg 				= {856, 856},
	arg_value			= {1.0, 0.5}, 
	arg_lim 			= {{0.0, 1.0}, {0.0, 0.5}},
	updatable			= true,
	use_release_message = {true},
	crew_member_access  = {1}
}

-- IFF
elements["DEV6201-CODE-PTR"] = multiposition_switch(_("IFF Transponder Mode Selector Switch, AUTO/KD/+-15/KP"), devices.IFF, IFF_6201_commands.CMD_IFF_Mode_Sw, 334, 4, 1/3)
elements["DEV6201-CODE-PTR"].turn_box = {0,135,0}
elements["DEV6201-MAIN-BACKUP-PTR"]	= default_2_position_small_tumb(_("IFF Transponder Device Selector Switch, WORK/RESERVE"), devices.IFF, IFF_6201_commands.CMD_IFF_Device_Sw, 336)
elements["DEV6201-NOT-USED-PTR"] = default_2_position_small_tumb(_("IFF Transponder Device Mode Switch, 1/2"), devices.IFF, IFF_6201_commands.CMD_IFF_1_2, 332)
elements["DEV6201-ERASE-COVER-PTR"]	= default_blue_cover(_("IFF Transponder Erase Button Cover, OPEN/CLOSE"), devices.IFF, IFF_6201_commands.CMD_IFF_Erase_BtnCover, 328)
elements["DEV6201-ERASE-COVER-PTR"].turn_box = {0,180,0}
elements["DEV6201-ERASE-PTR"] = default_button(_("IFF Transponder Erase Button - Push to erase"), devices.IFF, IFF_6201_commands.CMD_IFF_Erase_Btn, 329)
elements["DEV6201-SOS-COVER-PTR"] = default_blue_cover(_("IFF Transponder Disaster Switch Cover, OPEN/CLOSE"), devices.IFF, IFF_6201_commands.CMD_IFF_Disaster_SwCover, 330)
elements["DEV6201-SOS-COVER-PTR"].turn_box = {0,180,0}
elements["DEV6201-SOS-PTR"]	= default_2_position_small_tumb(_("IFF Transponder Disaster Switch, ON/OFF"), devices.IFF, IFF_6201_commands.CMD_IFF_Disaster_Sw, 331)
elements["DEV6201-POWER-PTR"]	= default_2_position_tumb(_("IFF Transponder Power Switch, ON/OFF"), devices.IFF, IFF_6201_commands.CMD_IFF_Power_Sw, 383)
-- Recorder MC 61
elements["RECORDER-POWER-PTR"]	= default_2_position_tumb(_("Recorder MC 61 Power Switch, ON/OFF"),	devices.Recorder_MC61, RecorderMC61_commands.CMD_Power, 378)
elements["RECORDER-MODE-PTR"] = default_2_position_tumb(_("Recorder MC 61 AUTO/WORK"), devices.Recorder_MC61, RecorderMC61_commands.CMD_Auto_Work, 1007)
elements["RECORDER-LTG-KNOB-PTR"] = default_axis_limited(_("Recorder MC 61 Brightness Knob"), devices.Recorder_MC61, RecorderMC61_commands.CMD_LightRst, 381, 0.0, 0.1)
elements["RECORDER-SOURCE-PTR"] = default_2_position_tumb(_("Laryngophone Switch, ON/OFF"), devices.Recorder_MC61, RecorderMC61_commands.CMD_Laryngophone, 1012)
-- RI-65
elements["SPEECH-OFF-PTR"]	= default_button(_("RI-65 OFF Button"), devices.VMS	, RI65_commands.CMD_RI_Mi24_Off, 359)
elements["SPEECH-CHECK-PTR"] = default_button(_("RI-65 Check Button"), devices.VMS	, RI65_commands.CMD_RI_Mi24_Check, 360)
elements["SPEECH-REPEAT-PTR"] = default_button(_("RI-65 Repeat Button"), devices.VMS	, RI65_commands.CMD_RI_Mi24_Repeat, 361)
-- pilot door
elements["CANOPY-HANDLE-SAFETY-PTR"] = default_button(_("Pilot Door Safety Lock Button"), devices.CPT_MECH, cockpit_mechanics_commands.Command_CPT_MECH_PilotDoor_Safety_Lock_Button, 189)
elements["CANOPY-HANDLE-PTR"] = default_animated_lever(_("Pilot Door Safety Lock, OPEN/CLOSE"), devices.CPT_MECH, cockpit_mechanics_commands.Command_CPT_MECH_PilotDoor_Lock, 8, 2)
elements["CANOPY-HANDLE-PTR"].turn_box = {0,180,0}
-- operator canopy
elements["CANOPY-HANDLE-OP-PTR"] = default_animated_lever(_("Operator Lock Canopy, OPEN/CLOSE"), devices.CPT_MECH, cockpit_mechanics_commands.Command_CPT_MECH_Canopy, 848, 2, nil, 1)
elements["CANOPY-HANDLE-OP-PTR"].turn_box = {0,-90,0}
-- wiper pilot mode
elements["WIPER-MODE-PTR-OFF"]		= default_position_tumb(_("Windscreen Wiper Control Switch, OFF"),		devices.CPT_MECH, cockpit_mechanics_commands.Command_CPT_MECH_PILOT_MODE_WIPER, 418, 0.00, {0.00, 0.00}, {0,0,0})
elements["WIPER-MODE-PTR-START"]	= default_position_tumb(_("Windscreen Wiper Control Switch, START"),	devices.CPT_MECH, cockpit_mechanics_commands.Command_CPT_MECH_PILOT_MODE_WIPER, 418, 0.05, {0.05, 0.05}, {0,0,0})
elements["WIPER-MODE-PTR-RESET"]	= default_spring_button(_("Windscreen Wiper Control Switch, RESET"),	devices.CPT_MECH, cockpit_mechanics_commands.Command_CPT_MECH_PILOT_MODE_WIPER, 418, 0.35, {0.00, 0.35}, {0,0,0})
elements["WIPER-MODE-PTR-LOWSPEED"]	= default_position_tumb(_("Windscreen Wiper Control Switch, SPEED 1"),	devices.CPT_MECH, cockpit_mechanics_commands.Command_CPT_MECH_PILOT_MODE_WIPER, 418, 0.15, {0.15, 0.15}, {0,0,0})
elements["WIPER-MODE-PTR-HISPEED"]	= default_position_tumb(_("Windscreen Wiper Control Switch, SPEED 2"),	devices.CPT_MECH, cockpit_mechanics_commands.Command_CPT_MECH_PILOT_MODE_WIPER, 418, 0.25, {0.25, 0.25}, {0,0,0})



-- wiper operator mode
elements["WIPER-MODE-OP-PTR-OFF"]		= default_position_tumb(_("Windscreen Wiper Control Switch, OFF"),		devices.CPT_MECH, cockpit_mechanics_commands.Command_CPT_MECH_OPERATOR_MODE_WIPER, 674, 0.00, {0.00, 0.00}, {0,0,0}, 1)
elements["WIPER-MODE-OP-PTR-START"]		= default_position_tumb(_("Windscreen Wiper Control Switch, START"),	devices.CPT_MECH, cockpit_mechanics_commands.Command_CPT_MECH_OPERATOR_MODE_WIPER, 674, 0.05, {0.05, 0.05}, {0,0,0}, 1)
elements["WIPER-MODE-OP-PTR-RESET"]		= default_spring_button(_("Windscreen Wiper Control Switch, RESET"),	devices.CPT_MECH, cockpit_mechanics_commands.Command_CPT_MECH_OPERATOR_MODE_WIPER, 674, 0.35, {0.00, 0.35}, {0,0,0}, 1)
elements["WIPER-MODE-OP-PTR-LOWSPEED"]	= default_position_tumb(_("Windscreen Wiper Control Switch, SPEED 1"),	devices.CPT_MECH, cockpit_mechanics_commands.Command_CPT_MECH_OPERATOR_MODE_WIPER, 674, 0.15, {0.15, 0.15}, {0,0,0}, 1)
elements["WIPER-MODE-OP-PTR-HISPEED"]	= default_position_tumb(_("Windscreen Wiper Control Switch, SPEED 2"),	devices.CPT_MECH, cockpit_mechanics_commands.Command_CPT_MECH_OPERATOR_MODE_WIPER, 674, 0.25, {0.25, 0.25}, {0,0,0}, 1)

elements["CONTROL-TRIMMER-OP-PTR"]	= default_2_position_tumb(_("Autopilot Trimmer for yourself "),	devices.CPT_MECH,	cockpit_mechanics_commands.Trimmer_myself,	671, nil, 1)
elements["CONTROL-TRIMMER-OP-COVER-PTR"] = default_blue_cover(_("Autopilot Trimmer for yourself Switch Cover, UP/DOWN"),				devices.CPT_MECH,	cockpit_mechanics_commands.Trimmer_myself_cover,	670, nil, 1)
elements["CONTROL-TRIMMER-OP-COVER-PTR"].turn_box = {0,0,180}

-- fan pilot on-off
elements["FAN-PTR"]	= default_2_position_tumb(_("Pilot Fan, ON/OFF"),	devices.CPT_MECH,	cockpit_mechanics_commands.Command_CPT_MECH_FAN_PILOT, 420)
-- fan operator on-off
elements["FAN-OP-PTR"]= default_2_position_tumb(_("Operator Fan, ON/OFF"),	devices.CPT_MECH,	cockpit_mechanics_commands.Command_CPT_MECH_FAN_OPERATOR, 665, nil, 1)
-- Cockpit elements hide/show:
elements["PTR-STICK-HIDE-974"]		= default_2_position_tumb(_("Hide Stick toggle"),	devices.CPT_MECH,	cockpit_mechanics_commands.Command_CPT_MECH_Elements_Hide,					974)

-- External Cargo Equipment
elements["COLLECTIVE-CARGO-TACT-COVER-PTR"] = default_blue_cover(_("Tactical Cargo Release Button Cover, OPEN/CLOSE"), devices.EXT_CARGO_EQUIPMENT, ext_cargo_equipment_commands.CMD_TacticalReleaseBtn_Cover, 751)
elements["COLLECTIVE-CARGO-TACT-COVER-PTR"].updatable = true
elements["COLLECTIVE-CARGO-TACT-COVER-PTR"].side = {}
elements["COLLECTIVE-CARGO-TACT-PTR"]	= default_button(_("Tactical Cargo Release Button - Push to release"), devices.EXT_CARGO_EQUIPMENT, ext_cargo_equipment_commands.CMD_TacticalReleaseBtn, 752)
elements["COLLECTIVE-CARGO-TACT-PTR"].updatable = true
elements["COLLECTIVE-CARGO-EMER-COVER-PTR"]	= default_blue_cover(_("Emergency Cargo Release Button Cover, OPEN/CLOSE"), devices.EXT_CARGO_EQUIPMENT, ext_cargo_equipment_commands.CMD_EmergencyReleaseBtn_Cover, 748)
elements["COLLECTIVE-CARGO-EMER-COVER-PTR"].side = {}
elements["COLLECTIVE-CARGO-EMER-COVER-PTR"].updatable = true
elements["COLLECTIVE-CARGO-EMER-PTR"]	= default_button(_("Emergency Cargo Release Button - Push to release"), devices.EXT_CARGO_EQUIPMENT, ext_cargo_equipment_commands.CMD_EmergencyReleaseBtn, 749)
elements["COLLECTIVE-CARGO-EMER-PTR"].updatable = true
elements["COLLECTIVE-CARGO-EMER-PTR"].side = {}
elements["EXTCARGO-AUTOLOCK-PTR"]	= default_2_position_tumb(_("External Cargo Automatic Dropping, ON/OFF"), devices.EXT_CARGO_EQUIPMENT, ext_cargo_equipment_commands.CMD_AutoReleaseSw, 199)
elements["EXTCARGO-AUTOLOCK-PTR"].turn_box = {-90,0,-90}
elements["EXTCARGO-EXT-RETR-PTR"]	= default_2_position_tumb(_("External Cargo Remove Release, ON/OFF"), devices.EXT_CARGO_EQUIPMENT, ext_cargo_equipment_commands.CMD_RemoveRelease, 198)
elements["EXTCARGO-EXT-RETR-PTR"].turn_box = {-90,0,-90}
elements["OP-COLL-CARGO-DROP-COVER-PTR"]	= default_blue_cover(_("Emergency Cargo Release Button Cover, OPEN/CLOSE"), devices.EXT_CARGO_EQUIPMENT, ext_cargo_equipment_commands.CMD_OperatorEmergencyReleaseBtn_Cover, 862, nil, 1)
elements["OP-COLL-CARGO-DROP-COVER-PTR"].updatable = true
elements["OP-COLL-CARGO-DROP-COVER-PTR"].side = {}
elements["OP-COLL-CARGO-DROP-PTR"]	= default_button(_("Emergency Cargo Release Button - Push to release"), devices.EXT_CARGO_EQUIPMENT, ext_cargo_equipment_commands.CMD_OperatorEmergencyReleaseBtn, 863, nil, 1)
elements["OP-COLL-CARGO-DROP-PTR"].side = {}

-- SARPP
elements["SARPP-MAN-AUTO-OFF-PTR"]	= default_3_position_tumb(_("SARPP-12 Mode Switch, MANUAL/AUTO"),	devices.SARPP12I1, SARPP_commands.CMD_Mode, 357)

-- Signal Flares
elements["FLARE-TOP-POWER-PTR"]		= default_2_position_tumb(_("Signal Flares Cassette 1 Power Switch, ON/OFF"), devices.SIGNAL_FLARES, signal_flares_commands.CMD_Cassette1_Power,       343)
elements["FLARE-TOP-POWER-PTR"].turn_box = {0,180,0}
elements["FLARE-TOP-RED-PTR"]		= default_2_position_flares_tumb(_("Signal Flares Cassette 1 Launch Red Button")	, devices.SIGNAL_FLARES, signal_flares_commands.CMD_drop_Cassette1_RED,    344)
elements["FLARE-TOP-GREEN-PTR"]		= default_2_position_flares_tumb(_("Signal Flares Cassette 1 Launch Green Button")	, devices.SIGNAL_FLARES, signal_flares_commands.CMD_drop_Cassette1_GREEN,  345)
elements["FLARE-TOP-YELLOW-PTR"]	= default_2_position_flares_tumb(_("Signal Flares Cassette 1 Launch Yellow Button"), devices.SIGNAL_FLARES, signal_flares_commands.CMD_drop_Cassette1_YELLOW, 346)
elements["FLARE-TOP-WHITE-PTR"]		= default_2_position_flares_tumb(_("Signal Flares Cassette 1 Launch White Button")	, devices.SIGNAL_FLARES, signal_flares_commands.CMD_drop_Cassette1_WHITE,  347)
elements["FLARE-BOTTOM-POWER-PTR"]	= default_2_position_tumb(_("Signal Flares Cassette 2 Power Switch, ON/OFF"), devices.SIGNAL_FLARES, signal_flares_commands.CMD_Cassette2_Power,       352)
elements["FLARE-BOTTOM-POWER-PTR"].turn_box = {0,180,0}
elements["FLARE-BOTTOM-WHITE-PTR"]	= default_2_position_flares_tumb(_("Signal Flares Cassette 2 Launch Red Button")	, devices.SIGNAL_FLARES, signal_flares_commands.CMD_drop_Cassette2_RED,    351)
elements["FLARE-BOTTOM-YELLOW-PTR"]	= default_2_position_flares_tumb(_("Signal Flares Cassette 2 Launch Green Button")	, devices.SIGNAL_FLARES, signal_flares_commands.CMD_drop_Cassette2_GREEN, 350)
elements["FLARE-BOTTOM-GREEN-PTR"]	= default_2_position_flares_tumb(_("Signal Flares Cassette 2 Launch Yellow Button"), devices.SIGNAL_FLARES, signal_flares_commands.CMD_drop_Cassette2_YELLOW,  349)
elements["FLARE-BOTTOM-RED-PTR"]	= default_2_position_flares_tumb(_("Signal Flares Cassette 2 Launch White Button")	, devices.SIGNAL_FLARES, signal_flares_commands.CMD_drop_Cassette2_WHITE,  348)


-- Operator Stick Engagement
elements["OP-COLL-ENGAGE-PTR"]	= default_button(_("Engage Stick"), devices.HELPER_AI, helperai_commands.EngageOperatorStickLever, 865, nil, 1)
elements["OP-COLL-ENGAGE-PTR"].updatable = true
elements["OP-COLL-ENGAGE-PTR"].turn_box = {90,0,0}
elements["OP-STICK-DISENGAGE-COVER-PTR"]	= default_blue_cover(_("Disengage Stick Cover"), devices.HELPER_AI, helperai_commands.DisengageOperatorStickButtonCover, 857, nil, 1)
elements["OP-STICK-DISENGAGE-COVER-PTR"].updatable = true
elements["OP-STICK-DISENGAGE-COVER-PTR"].side = {}
elements["OP-STICK-DISENGAGE-PTR"]	= default_button(_("Disengage Stick")	, devices.HELPER_AI, helperai_commands.DisengageOperatorStickButton,  859, nil, 1)
elements["OP-STICK-DISENGAGE-PTR"].updatable = true
elements["OP-STICK-DISENGAGE-PTR"].side = {}

--
elements["EASTER_PILOT"]		= default_button(_("Cockpit Fan - Touch")	, devices.CPT_MECH, cockpit_mechanics_commands.Command_CPT_MECH_TouchFanPLT, 0)
elements["EASTER_PILOT"].sound	= {}
elements["EASTER_PILOT"].turn_box = {-90,0,0}
elements["EASTER_OP"]			= default_button(_("Cockpit Fan - Touch")	, devices.CPT_MECH, cockpit_mechanics_commands.Command_CPT_MECH_TouchFanCPG, 0, nil, 1)
elements["EASTER_OP"].sound		= {}
elements["EASTER_OP"].turn_box = {-90,0,0}

--Timers
elements["TIMIR-LEFT-OP-PTR_2-9_5"] = {
	class					= {class_type.TUMB, class_type.LEV},
	hint					= _("Left timer control"),
	device					= devices.TIMER,
	action					= {timers_commands.CMD_Timer_Left_Up_Down, timers_commands.CMD_Timer_Left_Rot},
	is_repeatable			= {false, false},
	cycle					= {false, false},
	arg						= {1015, 1016},
	arg_value				= {0.0, 0.0},
	arg_lim					= {{0.0, 1.0}, {0.0, 1.0}},
	gain					= {1.0, 0.066},
	use_release_message		= {false, false},
	use_OBB					= true,
	relative				= {false, false},
	class_vr 				= {class_type.BTN_FIX},
	side					= {{BOX_SIDE_Y_bottom},{BOX_SIDE_X_top, BOX_SIDE_X_bottom, BOX_SIDE_Z_top, BOX_SIDE_Z_bottom}},
	crew_member_access  = {1}
}

elements["TIMIR-LEFT-OP-PTR_8-38"] = {
	class					= {class_type.TUMB, class_type.LEV},
	hint					= _("Right timer control"),
	device					= devices.TIMER,
	action					= {timers_commands.CMD_Timer_Right_Up_Down, timers_commands.CMD_Timer_Right_Rot},
	is_repeatable			= {false, false},
	cycle					= {false, false},
	arg						= {1019, 1020},
	arg_value				= {0.0, 0.0},
	arg_lim					= {{0.0, 1.0}, {0.0, 1.0}},
	gain					= {1.0, 0.066},
	use_release_message		= {false, false},
	use_OBB					= true,
	relative				= {false, false},
	class_vr 				= {class_type.BTN_FIX},
	side					= {{BOX_SIDE_Y_bottom},{BOX_SIDE_X_top, BOX_SIDE_X_bottom, BOX_SIDE_Z_top, BOX_SIDE_Z_bottom}},
	crew_member_access  = {1}
}

elements["TIMIR-SECONDS-OP-PTR"]	= default_3_position_tumb(_("Active timer select"),				devices.TIMER, timers_commands.CMD_Timer_Left_Right, 	1017, nil , nil, nil, 0.5, {0,1}, 1)
elements["TIMIR-COUNTING-OP-PTR"]	= default_2_position_tumb(_("Active timer start/stop"), 		devices.TIMER, timers_commands.CMD_Timer_On_Off, 		1018, nil, 1)
