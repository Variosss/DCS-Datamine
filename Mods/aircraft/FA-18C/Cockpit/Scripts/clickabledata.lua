dofile(LockOn_Options.script_path.."clickable_defs.lua")
dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."config.lua")
dofile(LockOn_Options.script_path.."sounds.lua")

local gettext = require("i_18n")
_ = gettext.translate


elements = {}

-- Control System
elements["pnt_345"]		= default_axis_limited(_("RUD TRIM Control"),						devices.CONTROL_INTERFACE, ctrl_commands.RudderTrim,	345, 0, 0.05, false, false, {-1, 1}, {-90, -135}, {-20, -45})
elements["pnt_346"]		= default_button(_("T/O TRIM Button"),								devices.CONTROL_INTERFACE, ctrl_commands.TOTrimSw,		346)
elements["pnt_349"]		= default_button(_("FCS RESET Button"),								devices.CONTROL_INTERFACE, ctrl_commands.ResetSw,		349)
elements["pnt_348"]		= default_red_cover(_("GAIN Switch Cover, OPEN/CLOSE"),				devices.CONTROL_INTERFACE, ctrl_commands.GainSwCover,	348)
elements["pnt_347"]		= default_2_position_tumb(_("GAIN Switch, NORM/ORIDE"),				devices.CONTROL_INTERFACE, ctrl_commands.GainSw,		347)
elements["pnt_234"]		= default_3_position_tumb(_("FLAP Switch, AUTO/HALF/FULL"),			devices.CONTROL_INTERFACE, ctrl_commands.FlapSw,		234)
elements["pnt_234"].animated	= {false,false}
elements["pnt_139"]		= default_red_cover(_("Spin Recovery Switch Cover, OPEN/CLOSE"),	devices.CONTROL_INTERFACE, ctrl_commands.SpinRecCover,	139)
elements["pnt_138"]		= default_2_position_tumb(_("Spin Recovery Switch, RCVY/NORM"),		devices.CONTROL_INTERFACE, ctrl_commands.SpinRec,		138)
elements["pnt_470"]		= default_button2(_("FCS BIT Switch"),								devices.CONTROL_INTERFACE, ctrl_commands.FcsBitSw,		470)
elements["pnt_295"]		= {
	class				= {class_type.TUMB, class_type.TUMB, class_type.LEV},
	hint				= _("Wing Fold Control Handle, (RMB)CW/(LMB)CCW/ (MW)PULL/STOW"),
	device				= devices.CONTROL_INTERFACE,
	action				= {ctrl_commands.WingFoldSelect, ctrl_commands.WingFoldSelect, ctrl_commands.WingFoldPull},
	arg					= {295, 295, 296},
	arg_value			= {-1, 1, 1},
	arg_lim				= {{-1,1}, {-1,1}, {0,1}},
	gain				= {1,1,-100},
	relative			= {false,false,false},
	updatable			= true,
	use_OBB				= false,
	cycle				= false,
	animated			= {true, true, true},
	animation_speed		= {anim_speed_default, anim_speed_default, anim_speed_default},
	sound				= {{SOUND_SW2}, {SOUND_SW2}, {SOUND_SW4_1}},
	class_vr		    = {nil, nil, class_type.BTN_FIX},
	side			    = {{BOX_SIDE_X_top},{BOX_SIDE_X_bottom},{BOX_SIDE_Y_bottom}}
}

elements["pnt_504"]		= default_movable_axis(_("Throttles Friction Adjusting Lever"), devices.CONTROL_INTERFACE, ctrl_commands.FrictionLever, 504, 1 )

-- Electric system
elements["pnt_404"]		= default_3_position_tumb(_("Battery Switch, ON/OFF/ORIDE"),				devices.ELEC_INTERFACE, elec_commands.BattSw,				404)
elements["pnt_402"]		= default_2_position_tumb(_("Left Generator Control Switch, NORM/OFF"),		devices.ELEC_INTERFACE, elec_commands.LGenSw,				402)
elements["pnt_403"]		= default_2_position_tumb(_("Right Generator Control Switch, NORM/OFF"),	devices.ELEC_INTERFACE, elec_commands.RGenSw,				403)
elements["pnt_379"]		= default_red_cover(_("Generator TIE Control Switch Cover, OPEN/CLOSE"),	devices.ELEC_INTERFACE, elec_commands.GenTieControlSwCover,	379)
elements["pnt_378"]		= default_2_position_tumb(_("Generator TIE Control Switch, NORM/RESET"),	devices.ELEC_INTERFACE, elec_commands.GenTieControlSw,		378)
elements["pnt_336"]		= default_button_tumb_v2(_("External Power Switch, RESET/NORM/OFF"),		devices.ELEC_INTERFACE, elec_commands.ExtPwrSw,	elec_commands.ExtPwrReset,	336)
elements["pnt_336"].sound = {{SOUND_SW1}, {SOUND_SW1, SOUND_SW1_OFF}}
elements["pnt_332"]		= springloaded_3_pos_tumb2(_("Ground Power Switch 1, A ON/AUTO/B ON"),		devices.ELEC_INTERFACE, elec_commands.GndPwr1SwB, elec_commands.GndPwr1SwA,	332)
elements["pnt_333"]		= springloaded_3_pos_tumb2(_("Ground Power Switch 2, A ON/AUTO/B ON"),		devices.ELEC_INTERFACE, elec_commands.GndPwr2SwB, elec_commands.GndPwr2SwA,	333)
elements["pnt_334"]		= springloaded_3_pos_tumb2(_("Ground Power Switch 3, A ON/AUTO/B ON"),		devices.ELEC_INTERFACE, elec_commands.GndPwr3SwB, elec_commands.GndPwr3SwA,	334)
elements["pnt_335"]		= springloaded_3_pos_tumb2(_("Ground Power Switch 4, A ON/AUTO/B ON"),		devices.ELEC_INTERFACE, elec_commands.GndPwr4SwB, elec_commands.GndPwr4SwA,	335)
-- Anti-Ice
elements["pnt_409"]	 	= springloaded_2_pos_tumb2(_("Pitot Heater Switch, ON/AUTO"),				devices.ELEC_INTERFACE, elec_commands.PitotHeater,			409)
elements["pnt_410"]		= default_3_position_tumb(_("Engine Anti-Ice Switch, ON/OFF/TEST"),			devices.ENGINES_INTERFACE, engines_commands.AntiIceSw,		410)
-- CB
elements["pnt_381"]		= default_CB_button(_("CB FCS CHAN 1, ON/OFF"),		devices.ELEC_INTERFACE, elec_commands.CB_FCS_CHAN1,		381)
elements["pnt_382"]		= default_CB_button(_("CB FCS CHAN 2, ON/OFF"),		devices.ELEC_INTERFACE, elec_commands.CB_FCS_CHAN2,		382)
elements["pnt_383"]		= default_CB_button(_("CB SPD BRK, ON/OFF"),		devices.ELEC_INTERFACE, elec_commands.CB_SPD_BRK,		383)
elements["pnt_384"]		= default_CB_button(_("CB LAUNCH BAR, ON/OFF"),		devices.ELEC_INTERFACE, elec_commands.CB_LAUNCH_BAR,	384)
elements["pnt_454"]		= default_CB_button(_("CB FCS CHAN 3, ON/OFF"),		devices.ELEC_INTERFACE, elec_commands.CB_FCS_CHAN3,		454)
elements["pnt_455"]		= default_CB_button(_("CB FCS CHAN 4, ON/OFF"),		devices.ELEC_INTERFACE, elec_commands.CB_FCS_CHAN4,		455)
elements["pnt_456"]		= default_CB_button(_("CB HOOK, ON/OFF"),			devices.ELEC_INTERFACE, elec_commands.CB_HOOK,			456)
elements["pnt_457"]		= default_CB_button(_("CB LG, ON/OFF"),				devices.ELEC_INTERFACE, elec_commands.CB_LG,			457)
--
elements["pnt_368"]		= springloaded_3_pos_tumb2(_("MC Switch, 1 OFF/NORM/2 OFF"),		devices.ELEC_INTERFACE, elec_commands.MC2OffSw, elec_commands.MC1OffSw, 368)

-- Power Plant
elements["pnt_375"]		= default_button2(_("APU Control Switch, ON/OFF"),	devices.ENGINES_INTERFACE, engines_commands.APU_ControlSw,	375)
elements["pnt_375"].updatable	= true
elements["pnt_377"]		= springloaded_3_pos_tumb2(_("Engine Crank Switch, LEFT/OFF/RIGHT"),							devices.ENGINES_INTERFACE, engines_commands.EngineCrankLSw, engines_commands.EngineCrankRSw, 377)
elements["pnt_331"]		= springloaded_3_pos_tumb2(_("Fire and Bleed Air Test Switch, (RMB) TEST A/(LMB) TEST B"),	devices.ENGINES_INTERFACE, engines_commands.FireTestBSw, engines_commands.FireTestASw,	331)

-- Hydraulic system
elements["pnt_369"]		= default_2_position_tumb(_("Hydraulic Isolate Override Switch, NORM/ORIDE"),	devices.HYDRAULIC_INTERFACE, hydro_commands.HydIsolSw,	369)

-- Gear system
elements["pnt_226"]		= LDG_Gear_Control_Handle(_("Landing Gear Control Handle, (RMB)UP/(LMB)DOWN/(MW)EMERGENCY DOWN"),	devices.GEAR_INTERFACE, gear_commands.GearHandle, 226, gear_commands.EmergDown, 228, 4.5)
elements["pnt_226"].sound	= {{SOUND_SW8_UP}, {SOUND_SW8_DOWN}, {SOUND_SW9}}
elements["pnt_229"]		= default_button(_("Down Lock Override Button - Push to unlock"),	devices.GEAR_INTERFACE, gear_commands.DownLockOverrideBtn,	229)
elements["pnt_238"]		= default_2_position_tumb(_("Anti Skid Switch, ON/OFF"),			devices.GEAR_INTERFACE, gear_commands.AntiSkidSw,			238)

elements["pnt_240"]		= {
	class				= {class_type.BTN, class_type.TUMB, class_type.LEV},
	hint				= _("Emergency/Parking Brake Handle, (LMB)Rotate Left/(RMB)Rotate Right/(MW)Pull-Stow"),
	device				= devices.GEAR_INTERFACE,
	action				= {gear_commands.EmergParkHandleSelectPark, gear_commands.EmergParkHandleSelectEmerg, gear_commands.EmergParkHandleOnOff},
	stop_action			= {gear_commands.EmergParkHandleSelectPark, 0, 0}, 
	arg					= {241, 241, 240},
	arg_value			= {0.333, -0.666, 1},
	arg_lim 			= {{0,0.999}, {0,0.999}, {0,1}},
	gain				= {1,1,1},
	relative			= {false,false,true},
	updatable 			= true,
	use_OBB 			= false,
	cycle				= false,
	animated			= {true, true, false},
	animation_speed		= {anim_speed_default * 0.7, anim_speed_default * 0.7, anim_speed_default},
	sound				= {{SOUND_SW4_2}, {SOUND_SW4_2}, {SOUND_SW4_1}},
	side			    = {{BOX_SIDE_Z_top},{BOX_SIDE_Z_bottom},{BOX_SIDE_Y_bottom}}
}

elements["pnt_233"]		= default_button2(_("Launch Bar Control Switch, EXTEND/RETRACT"),	devices.GEAR_INTERFACE, gear_commands.LaunchBarSw, 233, anim_speed_default)
elements["pnt_233"].updatable	= true
elements["pnt_293"]		= default_2_position_tumb(_("Arresting Hook Handle, UP/DOWN"),		devices.GEAR_INTERFACE, gear_commands.HookHandle,	293)
elements["pnt_293"].sound		= {{SOUND_SW8_UP,SOUND_SW8_DOWN}}
elements["pnt_293"].updatable	= true

-- Fuel system
elements["pnt_340"]		= default_2_position_tumb(_("Internal Wing Tank Fuel Control Switch, INHIBIT/NORM"),			devices.FUEL_INTERFACE, fuel_commands.IntrWingInhibitSw,	340)
elements["pnt_341"]		= default_3_position_tumb(_("Probe Control Switch, EXTEND/RETRACT/EMERG EXTD"),					devices.FUEL_INTERFACE, fuel_commands.ProbeControlSw,		341)
elements["pnt_344"]		= default_button2(_("Fuel Dump Switch, ON/OFF"),													devices.FUEL_INTERFACE, fuel_commands.DumpSw,				344, anim_speed_default)
elements["pnt_343"]		= default_3_position_tumb(_("External Centerline Tank Fuel Control Switch, STOP/NORM/ORIDE"),	devices.FUEL_INTERFACE, fuel_commands.ExtTanksCtrSw,		343)
elements["pnt_342"]		= default_3_position_tumb(_("External Wing Tanks Fuel Control Switch, STOP/NORM/ORIDE"),		devices.FUEL_INTERFACE, fuel_commands.ExtTanksWingSw,		342)

-- Cockpit Mechanics
elements["pnt_453"]		= springloaded_3_pos_tumb(_("Canopy Control Switch, OPEN/HOLD/CLOSE"),			devices.CPT_MECHANICS,	cpt_commands.CanopySwitchClose, cpt_commands.CanopySwitchOpen, 453)
elements["pnt_43"]		= default_button(_("Canopy Jettison Handle Unlock Button - Press to unlock"),	devices.CPT_MECHANICS,	cpt_commands.CanopyJettLeverButton,	43)
elements["pnt_43"].updatable		= true
elements["pnt_42"]		= default_2_position_tumb(_("Canopy Jettison Handle - Pull to jettison"),		devices.CPT_MECHANICS,	cpt_commands.CanopyJettLever, 		42)

elements["pnt_510"]		= default_button(_("Ejection Control Handle (3 times)"),						devices.CPT_MECHANICS,	cpt_commands.SeatEjectionControlHandle,			510)
elements["pnt_511"]		= default_2_position_tumb(_("Ejection Seat SAFE/ARMED Handle, SAFE/ARMED"),		devices.CPT_MECHANICS,	cpt_commands.EjectionSeatSafeArmedHandle,		511)
elements["pnt_511"].sound		= {{SOUND_SW14_UP,SOUND_SW14_DOWN}}
elements["pnt_512"]		= default_2_position_tumb(_("Ejection Seat Manual Override Handle, PULL/PUSH"),	devices.CPT_MECHANICS,	cpt_commands.EjectionSeatManualOverrideHandle,	512)
elements["pnt_512"].sound		= {{SOUND_SW14_UP,SOUND_SW14_DOWN}}
elements["pnt_513"]		= default_2_position_tumb(_("Shoulder Harness Control Handle, LOCK/UNLOCK"),	devices.CPT_MECHANICS,	cpt_commands.ShoulderHarnessControlHandle,		513)
elements["pnt_513"].sound		= {{SOUND_SW15_UP,SOUND_SW15_DOWN}}
elements["pnt_514"]		= springloaded_3_pos_tumb(_("Seat Height Adjustment Switch, UP/HOLD/DOWN"),		devices.CPT_MECHANICS,	cpt_commands.SeatHeightAdjustmentSwitchUp, cpt_commands.SeatHeightAdjustmentSwitchDn, 514)

elements["pnt_260"]		= default_button(_("Rudder Pedal Adjust Lever"),								devices.CPT_MECHANICS,	cpt_commands.RudderPedalAdjustLever,	260)
elements["pnt_575"]		= default_2_position_tumb(_("Hide Stick toggle"),								devices.CPT_MECHANICS,	cpt_commands.StickHide,					575)

--Mirrors
elements["pnt_497"]				= default_2_position_tumb(_("Toggle Mirrors"), 0, 3002, 0)
elements["pnt_497"].updatable	= true
elements["pnt_497"].side		= {{BOX_SIDE_Y_bottom},{BOX_SIDE_Z_bottom}}
elements["pnt_498"]				= default_2_position_tumb(_("Toggle Mirrors"), 0, 3003, 0)
elements["pnt_498"].updatable	= true
elements["pnt_498"].side		= {{BOX_SIDE_Y_bottom},{BOX_SIDE_Z_bottom}}
elements["pnt_499"]				= default_2_position_tumb(_("Toggle Mirrors"), 0, 3004, 0)
elements["pnt_499"].updatable	= true
elements["pnt_499"].side		= {{BOX_SIDE_Y_bottom},{BOX_SIDE_Z_bottom}}

-- Exterior Lights
elements["pnt_338"]		= default_axis_limited(_("POSITION Lights Dimmer Control"),			devices.EXT_LIGHTS,		extlights_commands.Position,	338, 0, 0.15, nil, nil, nil, {-90, -135}, {-90, -45})
elements["pnt_337"]		= default_axis_limited(_("FORMATION Lights Dimmer Control"),		devices.EXT_LIGHTS,		extlights_commands.Formation,	337, 0, 0.15, nil, nil, nil, {-90, -135}, {-90, -45})
elements["pnt_339"]		= default_3_position_tumb(_("STROBE Lights Switch, BRT/OFF/DIM"),	devices.EXT_LIGHTS,		extlights_commands.Strobe,		339)
elements["pnt_237"]		= default_2_position_tumb(_("LDG/TAXI LIGHT Switch, ON/OFF"),		devices.EXT_LIGHTS,		extlights_commands.LdgTaxi,		237)

-- Cockpit Lights
elements["pnt_413"]		= default_axis_limited(_("CONSOLES Lights Dimmer Control"),			devices.CPT_LIGHTS,		cptlights_commands.Consoles,	413, 0, 0.15, nil, nil, nil, {90, -135}, {90, -45})
elements["pnt_414"]		= default_axis_limited(_("INST PNL Dimmer Control"),				devices.CPT_LIGHTS,		cptlights_commands.InstPnl,		414, 0, 0.15, nil, nil, nil, {90, -135}, {90, -45})
elements["pnt_415"]		= default_axis_limited(_("FLOOD Light Dimmer Control"),				devices.CPT_LIGHTS,		cptlights_commands.Flood,		415, 0, 0.15, nil, nil, nil, {90, -135}, {90, -45})
elements["pnt_419"]		= default_3_position_tumb(_("MODE Switch, NVG/NITE/DAY"),			devices.CPT_LIGHTS,		cptlights_commands.ModeSw,		419)
elements["pnt_419"].use_OBB	= false
elements["pnt_418"]		= default_axis_limited(_("CHART Light Dimmer Control"),				devices.CPT_LIGHTS,		cptlights_commands.Chart,		418, 0, 0.15, nil, nil, nil, {90, -135}, {90, -45})
elements["pnt_417"]		= default_axis_limited(_("WARN/CAUTION Dimmer Control"),			devices.CPT_LIGHTS,		cptlights_commands.WarnCaution,	417, 0, 0.15, nil, nil, nil, {90, -135}, {90, -45})
elements["pnt_416"]		= springloaded_2_pos_tumb2(_("Lights Test Switch, TEST/OFF"),		devices.CPT_LIGHTS,		cptlights_commands.LtTestSw,	416)
elements["pnt_416"].use_OBB	= false
elements["pnt_14"]		= default_button(_("MASTER CAUTION Reset Button - Press to reset"),	devices.CPT_LIGHTS,		cptlights_commands.MasterCaution,	14, anim_speed_def_buttons * 1.2)
elements["pnt_239"]		= springloaded_2_pos_tumb2(_("HOOK BYPASS Switch, FIELD/CARRIER"),	devices.CPT_LIGHTS,		cptlights_commands.HookBypass,	239)

-- Oxygen System
elements["pnt_365"]		= default_2_position_tumb(_("OBOGS Control Switch, ON/OFF"),		devices.OXYGEN_INTERFACE,	oxygen_commands.OBOGS_ControlSw,		365)
elements["pnt_366"]		= default_axis_limited(_("OXY Flow Knob"),							devices.OXYGEN_INTERFACE,	oxygen_commands.OxyFlowControlValve,	366, 1.0, 0.5, false, false, {0,1})

-- ECS
elements["pnt_411"]		= multiposition_switch_cl(_("Bleed Air Knob, R OFF/NORM/L OFF/OFF"),				devices.ECS_INTERFACE, ECS_commands.BleedAirSw, 411, 4, 0.1, false, 0.0, anim_speed_default * 0.1, true, {90, -135}, {90, -45} )
elements["pnt_412"]		= default_button(_("Bleed Air Knob, AUG PULL"),										devices.ECS_INTERFACE, ECS_commands.BleedAirSwAugPull, 412)
elements["pnt_405"]		= default_3_position_tumb(_("ECS Mode Switch, AUTO/MAN/ OFF/RAM"),					devices.ECS_INTERFACE, ECS_commands.ECSModeSw, 405)
elements["pnt_408"]		= default_3_position_tumb(_("Cabin Pressure Switch, NORM/DUMP/ RAM/DUMP"),			devices.ECS_INTERFACE, ECS_commands.CabinPressSw, 408)

elements["pnt_451"]		= default_movable_axis(_("Defog Handle"), devices.ECS_INTERFACE, ECS_commands.DefogHandle, 451, 1, {-1,1})

elements["pnt_407"]		= default_axis_limited(_("Cabin Temperature Knob"),									devices.ECS_INTERFACE, ECS_commands.CabinTemperatureRst, 407, 0.0, 0.1, false, false, {0,1}, {0, -90}, {90, -45})
elements["pnt_406"]		= default_axis_limited(_("Suit Temperature Knob"),									devices.ECS_INTERFACE, ECS_commands.SuitTemperatureRst, 406, 0.0, 0.1, false, false, {0,1}, {0, -90}, {90, -45})
elements["pnt_297"]		= default_button2(_("AV COOL Switch, NORM/EMERG"),									devices.ECS_INTERFACE, ECS_commands.AV_COOL_Sw, 297)
elements["pnt_452"]		= default_3_position_tumb(_("Windshield Anti-Ice/Rain Switch, ANTI ICE/OFF/RAIN"),	devices.ECS_INTERFACE, ECS_commands.WindshieldSw, 452)
elements["pnt_505"]		= default_axis_limited(_("Left Louver"),											devices.ECS_INTERFACE, ECS_commands.LeftLouver, 505, 0.0, 0.1, false, false, {0,1})
elements["pnt_506"]		= default_axis_limited(_("Right Louver"),											devices.ECS_INTERFACE, ECS_commands.RightLouver, 506, 0.0, 0.1, false, false, {0,1})


-- HOTAS STICK
elements["pnt_475"]		= limit_button(_("Weapon Release Button"),								devices.HOTAS, hotas_commands.STICK_WEAPON_RELEASE, 			475)
--elements["pnt_476_1"]	= limit_button( _('Sensor Control Switch, Fwd'),						devices.HOTAS, hotas_commands.STICK_SENSOR_CONTROL_FWD, 		476, {0.0,0.2}, 0.2)
--elements["pnt_476_2"]	= limit_button( _('Sensor Control Switch, Aft'),						devices.HOTAS, hotas_commands.STICK_SENSOR_CONTROL_AFT, 		476, {0.0,0.4}, 0.4)
--elements["pnt_476_3"]	= limit_button( _('Sensor Control Switch, Left'),						devices.HOTAS, hotas_commands.STICK_SENSOR_CONTROL_LEFT, 		476, {0.0,0.1}, 0.1)
--elements["pnt_476_4"]	= limit_button( _('Sensor Control Switch, Right'),						devices.HOTAS, hotas_commands.STICK_SENSOR_CONTROL_RIGHT, 		476, {0.0,0.3}, 0.3)
elements["pnt_477"]		= limit_button(_('RECCE Event Mark Switch'),							devices.HOTAS, hotas_commands.STICK_RECCE_EVENT_MARK, 			477)
--elements["pnt_478_1"]	= limit_button(_('Trimmer Switch, PUSH(DESCEND)'),						devices.HOTAS, hotas_commands.STICK_TRIMMER_UP,		 			478, {0.0,0.2}, 0.2)
--elements["pnt_478_2"]	= limit_button(_('Trimmer Switch, PULL(CLIMB)'),						devices.HOTAS, hotas_commands.STICK_TRIMMER_DOWN,	 			478, {0.0,0.4}, 0.4)
--elements["pnt_478_3"]	= limit_button(_('Trimmer Switch, LEFT WING DOWN'),						devices.HOTAS, hotas_commands.STICK_TRIMMER_LEFT,	 			478, {0.0,0.1}, 0.1)
--elements["pnt_478_4"]	= limit_button(_('Trimmer Switch, RIGHT WING DOWN'),					devices.HOTAS, hotas_commands.STICK_TRIMMER_RIGHT,	 			478, {0.0,0.3}, 0.3)
--elements["pnt_479_1"]	= limit_button(_('Gun Trigger, FIRST DETENT)'),							devices.HOTAS, hotas_commands.STICK_TRIGGER_1ST_DETENT, 		479, {0.0,0.5}, 0.5)
--elements["pnt_479_2"]	= limit_button(_('Gun Trigger, SECOND DETENT (Press to shoot)'),		devices.HOTAS, hotas_commands.STICK_TRIGGER_2ND_DETENT, 		479, {0.0,1.0}, 1)
elements["pnt_482"]		= limit_button(_('Autopilot/Nosewheel Steering Disengage (Paddle) Switch'),	devices.HOTAS, hotas_commands.STICK_PADDLE, 				482)
--elements["pnt_481_1"]	= limit_button(_('Select Sparrow'),										devices.HOTAS, hotas_commands.STICK_WEAPON_SELECT_FWD, 			481, {0.0,0.2}, 0.2)
--elements["pnt_481_2"]	= limit_button(_('Select Gun'),											devices.HOTAS, hotas_commands.STICK_WEAPON_SELECT_AFT, 			481, {0.0,0.4}, 0.4)
--elements["pnt_481_3"]	= limit_button(_('Select AMRAAM'),										devices.HOTAS, hotas_commands.STICK_WEAPON_SELECT_IN,	 		481, {0.0,0.3}, 0.3)
--elements["pnt_481_4"]	= limit_button(_('Select Sidewinder'),									devices.HOTAS, hotas_commands.STICK_WEAPON_SELECT_DOWN, 		481, {0.0,0.1}, 0.1)
elements["pnt_480"]		= limit_button(_('Undesignate/Nose Wheel Steer Switch'),				devices.HOTAS, hotas_commands.STICK_UNDESIGNATE, 				480)


-- HOTAS THROTTLE
--elements["pnt_486_1"]	= limit_button(_('COMM Switch, COMM 1'),								devices.HOTAS, hotas_commands.THROTTLE_COMMS_COMM1,				486, {0.0,0.2}, 0.2)
--elements["pnt_486_2"]	= limit_button(_('COMM Switch, COMM 2'),								devices.HOTAS, hotas_commands.THROTTLE_COMMS_COMM2,				486, {0.0,0.4}, 0.4)
--elements["pnt_486_3"]	= limit_button(_('COMM Switch, MIDS A'),								devices.HOTAS, hotas_commands.THROTTLE_COMMS_MIDS_A,			486, {0.0,0.3}, 0.3)
--elements["pnt_486_4"]	= limit_button(_('COMM Switch, MIDS B'),								devices.HOTAS, hotas_commands.THROTTLE_COMMS_MIDS_B, 			486, {0.0,0.1}, 0.1)
--elements["pnt_487"]		= limit_button(_('Cage/Uncage Button'),									devices.HOTAS, hotas_commands.THROTTLE_CAGE, 					487)
--elements["pnt_488"]		= springloaded_3_pos_tumb(_('Dispense Switch, CHAFF/OFF/FLARE'),		devices.HOTAS, hotas_commands.THROTTLE_DISPENSE_FWD, hotas_commands.THROTTLE_DISPENSE_AFT, 313)
--elements["pnt_488_1"]	= limit_button(_('Dispense Switch, Forward(CHAFF)/Center(OFF)'),		devices.HOTAS, hotas_commands.THROTTLE_DISPENSE_FWD, 			488)
--elements["pnt_488_2"]	= limit_button(_('Dispense Switch, Aft(FLARE)/Center(OFF)'),			devices.HOTAS, hotas_commands.THROTTLE_DISPENSE_AFT, 			488, {-1.0,0.0}, -1.0)
--elements["pnt_489"]		= default_3_position_tumb(_('Speed Brake Switch, EXTEND/OFF/RETRACT'),	devices.HOTAS, hotas_commands.THROTTLE_SPEED_BRAKE,				489,	false, anim_speed_default, false)
--elements["pnt_489"].side = {}
--elements["pnt_490_1"]	= limit_button(_('Throttle Designator Controller, Up'),				devices.HOTAS, hotas_commands.THROTTLE_DESIGNATOR_CONTROLLER_UP,	  490, {0.0,0.2}, 0.2)
--elements["pnt_490_2"]	= limit_button(_('Throttle Designator Controller, Down'),				devices.HOTAS, hotas_commands.THROTTLE_DESIGNATOR_CONTROLLER_DOWN,	  490, {0.0,0.4}, 0.4)
--elements["pnt_490_3"]	= limit_button(_('Throttle Designator Controller, Left'),				devices.HOTAS, hotas_commands.THROTTLE_DESIGNATOR_CONTROLLER_LEFT,	  490, {0.0,0.3}, 0.3)
--elements["pnt_490_4"]	= limit_button(_('Throttle Designator Controller, Right'),				devices.HOTAS, hotas_commands.THROTTLE_DESIGNATOR_CONTROLLER_RIGHT,   490, {0.0,0.1}, 0.1)
--elements["pnt_491"]		= limit_button(_('ATC Engage/Disengage Switch'),						devices.HOTAS, hotas_commands.THROTTLE_ATC, 					491)
--elements["pnt_492"]		= limit_button(_('RAID/FLIR FOV Select Button'),						devices.HOTAS, hotas_commands.THROTTLE_RAID_FOV, 				492)
--elements["pnt_493"]		= default_axis_limited(_('Radar Elevation Control, Up'),					devices.HOTAS, hotas_commands.THROTTLE_ELEVATION_CONTROL_UP, 493, 0.0, 0.1, false, false, {0, 1})
elements["pnt_494"]		= default_2_position_tumb(_("Exterior Lights Switch, ON/OFF"),			devices.HOTAS, 	hotas_commands.THROTTLE_EXTERIOR_LIGHTS,		494)

-- Master Arm Panel
elements["pnt_458"]		= default_button(_("Master Mode Button, A/A"),							devices.SMS, SMS_commands.AA_MasterModeSw, 458)
elements["pnt_459"]		= default_button(_("Master Mode Button, A/G"),							devices.SMS, SMS_commands.AG_MasterModeSw, 459)
elements["pnt_49"]		= default_2_position_tumb(_("Master Arm Switch, ARM/SAFE"),				devices.SMS, SMS_commands.MasterArmSw, 49)
elements["pnt_50"]		= default_button(_("Emergency Jettison Button"),						devices.SMS, SMS_commands.EmerJettSw, 50)
elements["pnt_258"]		= default_2_position_tumb(_("Auxiliary Release Switch, ENABLE/NORM"),	devices.SMS, SMS_commands.AuxRelSw, 258)

elements["pnt_153"]		= push_button_tumb(_("Station Jettison Select Button, CENTER"),		devices.SMS, SMS_commands.JettStationCntrBtn, 153)
elements["pnt_153"].sound		= {{SOUND_SW5_ON, SOUND_SW5_OFF}}
elements["pnt_155"]		= push_button_tumb(_("Station Jettison Select Button, LEFT IN"),		devices.SMS, SMS_commands.JettStationLIBtn, 155)
elements["pnt_155"].sound		= {{SOUND_SW5_ON, SOUND_SW5_OFF}}
elements["pnt_157"]		= push_button_tumb(_("Station Jettison Select Button, LEFT OUT"),	devices.SMS, SMS_commands.JettStationLOBtn, 157)
elements["pnt_157"].sound		= {{SOUND_SW5_ON, SOUND_SW5_OFF}}
elements["pnt_159"]		= push_button_tumb(_("Station Jettison Select Button, RIGHT IN"),	devices.SMS, SMS_commands.JettStationRIBtn, 159)
elements["pnt_159"].sound		= {{SOUND_SW5_ON, SOUND_SW5_OFF}}
elements["pnt_161"]		= push_button_tumb(_("Station Jettison Select Button, RIGHT OUT"),	devices.SMS, SMS_commands.JettStationROBtn, 161)
elements["pnt_161"].sound		= {{SOUND_SW5_ON, SOUND_SW5_OFF}}
elements["pnt_235"]		= default_button(_("Selective Jettison Pushbutton"),					devices.SMS, SMS_commands.SelJettBtn, 235)
elements["pnt_235"].use_OBB = true
elements["pnt_236"]		= multiposition_switch(_("Selective Jettison Knob, L FUS MSL/SAFE/R FUS MSL/ RACK/LCHR /STORES"),	devices.SMS, SMS_commands.SelJettLvr, 236, 5, 0.1, false, -0.1, 1.5)
elements["pnt_236"].use_OBB = false

elements["pnt_135"]		= default_3_position_tumb(_("IR Cooling Switch, ORIDE/NORM/OFF"),			devices.SMS, SMS_commands.IRCoolingSw, 135, false, anim_speed_default, false, 0.1, {0, 0.2})

-- Fire Systems
elements["pnt_46"]		= default_button(_("Fire Extinguisher Pushbutton"),						devices.ENGINES_INTERFACE, engines_commands.FireExtghDischSw, 46)
elements["pnt_30"]		= push_button_tumb(_("APU Fire Warning/Extinguisher Light"),			devices.ENGINES_INTERFACE, engines_commands.APU_FireSw, 30)

elements["pnt_11"]		= default_double_tumb(_("Left Engine/AMAD Fire Warning/Extinguisher Light - (LMB) depress/(RMB) cover control"),	devices.ENGINES_INTERFACE, engines_commands.LENG_FireSw, engines_commands.LENG_FireSwCover, 11, 12)
elements["pnt_27"]		= default_double_tumb(_("Right Engine/AMAD Fire Warning/Extinguisher Light - (LMB) depress/(RMB) cover control"),	devices.ENGINES_INTERFACE, engines_commands.RENG_FireSw, engines_commands.RENG_FireSwCover, 27, 28)


-- Multipurpose Display Group -----------
-- Head-Up Display
elements["pnt_140"]		= default_3_position_tumb(_("HUD Symbology Reject Switch, NORM/REJ 1/REJ 2"),		devices.HUD, HUD_commands.HUD_SymbRejectSw, 140, false, anim_speed_default, false, 0.1, {0, 0.2})
elements["pnt_141"]		= default_axis_limited(_("HUD Symbology Brightness Control Knob"),					devices.HUD, HUD_commands.HUD_SymbBrightCtrl, 141, 0.0, 0.1, false, false, {0, 1})
elements["pnt_142"]		= default_2_position_tumb(_("HUD Symbology Brightness Selector Knob, DAY/NIGHT"),	devices.HUD, HUD_commands.HUD_SymbBrightSelKnob, 142)
elements["pnt_143"]		= default_axis_limited(_("Black Level Control Knob"),								devices.HUD, HUD_commands.HUD_BlackLevelCtrl, 143, 0.0, 0.1, false, false, {0, 1})
elements["pnt_144"]		= default_3_position_tumb(_("HUD Video Control Switch, W/B /VID/OFF"),				devices.HUD, HUD_commands.HUD_VideoCtrlSw, 144, false, anim_speed_default, false, 0.1, {0, 0.2})
elements["pnt_145"]		= default_axis_limited(_("Balance Control Knob"),									devices.HUD, HUD_commands.HUD_BalanceCtrl, 145, 0.0, 0.1, false, false, {0, 1})
elements["pnt_146"]		= default_axis_limited(_("AOA Indexer Control Knob"),								devices.HUD, HUD_commands.HUD_AoA_IndexerCtrl, 146, 0.0, 0.1, false, false, {0, 1})
elements["pnt_147"]		= default_2_position_tumb(_("Altitude Switch, BARO/RDR"),							devices.HUD, HUD_commands.HUD_AltitudeSw, 147)
elements["pnt_148"]		= default_3_position_tumb(_("Attitude Selector Switch, INS/AUTO/STBY"),				devices.HUD, HUD_commands.HUD_AttitudeSelSw, 148)

-- Left MDI
elements["pnt_51"]		= default_3_position_tumb(_("Left MDI Brightness Selector Knob, OFF/NIGHT/DAY"),	devices.MDI_LEFT, MDI_commands.MDI_off_night_day, 51, false, anim_speed_default, false, 0.1, {0, 0.2})
elements["pnt_52"]		= default_axis_limited(_("Left MDI Brightness Control Knob"),						devices.MDI_LEFT, MDI_commands.MDI_brightness, 52, 0.0, 0.1, false, false, {0, 1}, {90,-45} )
elements["pnt_53"]		= default_axis_limited(_("Left MDI Contrast Control Knob"),							devices.MDI_LEFT, MDI_commands.MDI_contrast, 53, 0.0, 0.1, false, false, {0, 1})
elements["pnt_54"]		= short_way_button(_("Left MDI PB 1"),												devices.MDI_LEFT, MDI_commands.MDI_PB_1, 54)
elements["pnt_55"]		= short_way_button(_("Left MDI PB 2"),												devices.MDI_LEFT, MDI_commands.MDI_PB_2, 55)
elements["pnt_56"]		= short_way_button(_("Left MDI PB 3"),												devices.MDI_LEFT, MDI_commands.MDI_PB_3, 56)
elements["pnt_57"]		= short_way_button(_("Left MDI PB 4"),												devices.MDI_LEFT, MDI_commands.MDI_PB_4, 57)
elements["pnt_58"]		= short_way_button(_("Left MDI PB 5"),												devices.MDI_LEFT, MDI_commands.MDI_PB_5, 58)
elements["pnt_59"]		= short_way_button(_("Left MDI PB 6"),												devices.MDI_LEFT, MDI_commands.MDI_PB_6, 59)
elements["pnt_60"]		= short_way_button(_("Left MDI PB 7"),												devices.MDI_LEFT, MDI_commands.MDI_PB_7, 60)
elements["pnt_61"]		= short_way_button(_("Left MDI PB 8"),												devices.MDI_LEFT, MDI_commands.MDI_PB_8, 61)
elements["pnt_62"]		= short_way_button(_("Left MDI PB 9"),												devices.MDI_LEFT, MDI_commands.MDI_PB_9, 62)
elements["pnt_63"]		= short_way_button(_("Left MDI PB 10"),												devices.MDI_LEFT, MDI_commands.MDI_PB_10, 63)
elements["pnt_64"]		= short_way_button(_("Left MDI PB 11"),												devices.MDI_LEFT, MDI_commands.MDI_PB_11, 64)
elements["pnt_65"]		= short_way_button(_("Left MDI PB 12"),												devices.MDI_LEFT, MDI_commands.MDI_PB_12, 65)
elements["pnt_66"]		= short_way_button(_("Left MDI PB 13"),												devices.MDI_LEFT, MDI_commands.MDI_PB_13, 66)
elements["pnt_67"]		= short_way_button(_("Left MDI PB 14"),												devices.MDI_LEFT, MDI_commands.MDI_PB_14, 67)
elements["pnt_68"]		= short_way_button(_("Left MDI PB 15"),												devices.MDI_LEFT, MDI_commands.MDI_PB_15, 68)
elements["pnt_69"]		= short_way_button(_("Left MDI PB 16"),												devices.MDI_LEFT, MDI_commands.MDI_PB_16, 69)
elements["pnt_70"]		= short_way_button(_("Left MDI PB 17"),												devices.MDI_LEFT, MDI_commands.MDI_PB_17, 70)
elements["pnt_72"]		= short_way_button(_("Left MDI PB 18"),												devices.MDI_LEFT, MDI_commands.MDI_PB_18, 72)
elements["pnt_73"]		= short_way_button(_("Left MDI PB 19"),												devices.MDI_LEFT, MDI_commands.MDI_PB_19, 73)
elements["pnt_75"]		= short_way_button(_("Left MDI PB 20"),												devices.MDI_LEFT, MDI_commands.MDI_PB_20, 75)

elements["pnt_312"]		= springloaded_3_pos_tumb2(_("Heading Set Switch"),									devices.MDI_LEFT, MDI_commands.MDI_Left_HDG_Negative, MDI_commands.MDI_Left_HDG_Positive, 312)
elements["pnt_313"]		= springloaded_3_pos_tumb(_("Course Set Switch"),									devices.MDI_LEFT, MDI_commands.MDI_Left_CRS_Negative, MDI_commands.MDI_Left_CRS_Positive, 313)

-- Right MDI
elements["pnt_76"]		= default_3_position_tumb(_("Right MDI Brightness Selector Knob, OFF/NIGHT/DAY"),	devices.MDI_RIGHT, MDI_commands.MDI_off_night_day, 76, false, anim_speed_default, false, 0.1, {0, 0.2})
elements["pnt_77"]		= default_axis_limited(_("Right MDI Brightness Control Knob"),						devices.MDI_RIGHT, MDI_commands.MDI_brightness, 77, 0.0, 0.1, false, false, {0, 1})
elements["pnt_78"]		= default_axis_limited(_("Right MDI Contrast Control Knob"),						devices.MDI_RIGHT, MDI_commands.MDI_contrast, 78, 0.0, 0.1, false, false, {0, 1}, nil, {90, -45})
elements["pnt_79"]		= short_way_button(_("Right MDI PB 1"),												devices.MDI_RIGHT, MDI_commands.MDI_PB_1, 79)
elements["pnt_80"]		= short_way_button(_("Right MDI PB 2"),												devices.MDI_RIGHT, MDI_commands.MDI_PB_2, 80)
elements["pnt_81"]		= short_way_button(_("Right MDI PB 3"),												devices.MDI_RIGHT, MDI_commands.MDI_PB_3, 81)
elements["pnt_82"]		= short_way_button(_("Right MDI PB 4"),												devices.MDI_RIGHT, MDI_commands.MDI_PB_4, 82)
elements["pnt_83"]		= short_way_button(_("Right MDI PB 5"),												devices.MDI_RIGHT, MDI_commands.MDI_PB_5, 83)
elements["pnt_84"]		= short_way_button(_("Right MDI PB 6"),												devices.MDI_RIGHT, MDI_commands.MDI_PB_6, 84)
elements["pnt_85"]		= short_way_button(_("Right MDI PB 7"),												devices.MDI_RIGHT, MDI_commands.MDI_PB_7, 85)
elements["pnt_86"]		= short_way_button(_("Right MDI PB 8"),												devices.MDI_RIGHT, MDI_commands.MDI_PB_8, 86)
elements["pnt_87"]		= short_way_button(_("Right MDI PB 9"),												devices.MDI_RIGHT, MDI_commands.MDI_PB_9, 87)
elements["pnt_88"]		= short_way_button(_("Right MDI PB 10"),											devices.MDI_RIGHT, MDI_commands.MDI_PB_10, 88)
elements["pnt_89"]		= short_way_button(_("Right MDI PB 11"),											devices.MDI_RIGHT, MDI_commands.MDI_PB_11, 89)
elements["pnt_90"]		= short_way_button(_("Right MDI PB 12"),											devices.MDI_RIGHT, MDI_commands.MDI_PB_12, 90)
elements["pnt_91"]		= short_way_button(_("Right MDI PB 13"),											devices.MDI_RIGHT, MDI_commands.MDI_PB_13, 91)
elements["pnt_92"]		= short_way_button(_("Right MDI PB 14"),											devices.MDI_RIGHT, MDI_commands.MDI_PB_14, 92)
elements["pnt_93"]		= short_way_button(_("Right MDI PB 15"),											devices.MDI_RIGHT, MDI_commands.MDI_PB_15, 93)
elements["pnt_94"]		= short_way_button(_("Right MDI PB 16"),											devices.MDI_RIGHT, MDI_commands.MDI_PB_16, 94)
elements["pnt_95"]		= short_way_button(_("Right MDI PB 17"),											devices.MDI_RIGHT, MDI_commands.MDI_PB_17, 95)
elements["pnt_96"]		= short_way_button(_("Right MDI PB 18"),											devices.MDI_RIGHT, MDI_commands.MDI_PB_18, 96)
elements["pnt_97"]		= short_way_button(_("Right MDI PB 19"),											devices.MDI_RIGHT, MDI_commands.MDI_PB_19, 97)
elements["pnt_98"]		= short_way_button(_("Right MDI PB 20"),											devices.MDI_RIGHT, MDI_commands.MDI_PB_20, 98)
	
-- AMPCD
elements["pnt_203"]		= default_axis_limited(_("AMPCD Off/Brightness Control Knob"),			devices.AMPCD, AMPCD_commands.AMPCD_off_brightness, 203, 0.0, 0.1, false, false, {0, 1})
elements["pnt_177_2"]	= AMPCD_switch_positive(_("AMPCD Night/Day Brightness Selector, DAY"),	devices.AMPCD, AMPCD_commands.AMPCD_nite_day_DAY, 177)
elements["pnt_177_1"]	= AMPCD_switch_negative(_("AMPCD Night/Day Brightness Selector, NGT"),	devices.AMPCD, AMPCD_commands.AMPCD_nite_day_NGT, 177)
elements["pnt_179_2"]	= AMPCD_switch_positive(_("AMPCD Symbology Control Switch, UP"),		devices.AMPCD, AMPCD_commands.AMPCD_symbology_UP, 179)
elements["pnt_179_1"]	= AMPCD_switch_negative(_("AMPCD Symbology Control Switch, DOWN"),		devices.AMPCD, AMPCD_commands.AMPCD_symbology_DOWN, 179)
elements["pnt_182_2"]	= AMPCD_switch_positive(_("AMPCD Contrast Control Switch, UP"),			devices.AMPCD, AMPCD_commands.AMPCD_contrast_UP, 182)
elements["pnt_182_1"]	= AMPCD_switch_negative(_("AMPCD Contrast Control Switch, DOWN"),		devices.AMPCD, AMPCD_commands.AMPCD_contrast_DOWN, 182)
elements["pnt_180_2"]	= AMPCD_switch_positive(_("AMPCD Gain Control Switch, UP"),				devices.AMPCD, AMPCD_commands.AMPCD_gain_UP, 180)
elements["pnt_180_1"]	= AMPCD_switch_negative(_("AMPCD Gain Control Switch, DOWN"),			devices.AMPCD, AMPCD_commands.AMPCD_gain_DOWN, 180)
elements["pnt_183"]		= short_way_button(_("AMPCD PB 1"),										devices.AMPCD, AMPCD_commands.AMPCD_PB_1, 183)
elements["pnt_184"]		= short_way_button(_("AMPCD PB 2"),										devices.AMPCD, AMPCD_commands.AMPCD_PB_2, 184)
elements["pnt_185"]		= short_way_button(_("AMPCD PB 3"),										devices.AMPCD, AMPCD_commands.AMPCD_PB_3, 185)
elements["pnt_186"]		= short_way_button(_("AMPCD PB 4"),										devices.AMPCD, AMPCD_commands.AMPCD_PB_4, 186)
elements["pnt_187"]		= short_way_button(_("AMPCD PB 5"),										devices.AMPCD, AMPCD_commands.AMPCD_PB_5, 187)
elements["pnt_188"]		= short_way_button(_("AMPCD PB 6"),										devices.AMPCD, AMPCD_commands.AMPCD_PB_6, 188)
elements["pnt_189"]		= short_way_button(_("AMPCD PB 7"),										devices.AMPCD, AMPCD_commands.AMPCD_PB_7, 189)
elements["pnt_190"]		= short_way_button(_("AMPCD PB 8"),										devices.AMPCD, AMPCD_commands.AMPCD_PB_8, 190)
elements["pnt_191"]		= short_way_button(_("AMPCD PB 9"),										devices.AMPCD, AMPCD_commands.AMPCD_PB_9, 191)
elements["pnt_192"]		= short_way_button(_("AMPCD PB 10"),									devices.AMPCD, AMPCD_commands.AMPCD_PB_10, 192)
elements["pnt_193"]		= short_way_button(_("AMPCD PB 11"),									devices.AMPCD, AMPCD_commands.AMPCD_PB_11, 193)
elements["pnt_194"]		= short_way_button(_("AMPCD PB 12"),									devices.AMPCD, AMPCD_commands.AMPCD_PB_12, 194)
elements["pnt_195"]		= short_way_button(_("AMPCD PB 13"),									devices.AMPCD, AMPCD_commands.AMPCD_PB_13, 195)
elements["pnt_196"]		= short_way_button(_("AMPCD PB 14"),									devices.AMPCD, AMPCD_commands.AMPCD_PB_14, 196)
elements["pnt_197"]		= short_way_button(_("AMPCD PB 15"),									devices.AMPCD, AMPCD_commands.AMPCD_PB_15, 197)
elements["pnt_198"]		= short_way_button(_("AMPCD PB 16"),									devices.AMPCD, AMPCD_commands.AMPCD_PB_16, 198)
elements["pnt_199"]		= short_way_button(_("AMPCD PB 17"),									devices.AMPCD, AMPCD_commands.AMPCD_PB_17, 199)
elements["pnt_200"]		= short_way_button(_("AMPCD PB 18"),									devices.AMPCD, AMPCD_commands.AMPCD_PB_18, 200)
elements["pnt_201"]		= short_way_button(_("AMPCD PB 19"),									devices.AMPCD, AMPCD_commands.AMPCD_PB_19, 201)
elements["pnt_202"]		= short_way_button(_("AMPCD PB 20"),									devices.AMPCD, AMPCD_commands.AMPCD_PB_20, 202)


-- Instruments --------------------------
-- Standby Pressure Altimeter AAU-52/A
elements["pnt_224"]		= default_axis(_("AAU-52 Altimeter Pressure Setting Knob"), devices.AAU52, aau52_commands.AAU52_ClkCmd_ZeroSetting, 224, 0.04, 0.2, false, true, nil, {0,-120}, {0,-60})
-- Radar Altimeter Height Indicator
elements["pnt_291"]		= default_button_axis_extended(_("Push to Test Switch, (LMB) activate BIT checks/(MW) rotate clockwise to apply power and set low altitude index pointer"), devices.ID2163A, id2163a_commands.ID2163A_PushToTest, id2163a_commands.ID2163A_SetMinAlt, 292, 291, 0.1, true, nil, {30, -145}, {0,-60})
elements["pnt_291"].sound = {{SOUND_SW12}}
--Standby Attitude Indicator
elements["pnt_213"] =
{
	class				= {class_type.BTN, class_type.LEV},
	hint				= _("SAI Cage Knob, (LMB) Pull to cage (hold RMB and rotate MW to uncage)/(MW) Adjust miniature airplane"),
	device				= devices.SAI,
	action				= {sai_commands.SAI_pull, sai_commands.SAI_rotate},
	stop_action			= {sai_commands.SAI_pull, 0},
	is_repeatable		= {},
	arg					= {213, 214},
	arg_value			= {1.0, 0.5},
	arg_lim				= {{0, 1}, {0, 1}},
	relative			= {false, true},
	gain				= {1.0, 0.1},
	use_release_message	= {true, false},
	sound				= {{SOUND_SW12}},
	use_OBB			    = true,
	class_vr		    = {class_type.BTN_FIX, nil},
	side			    = {{BOX_SIDE_Y_bottom},{BOX_SIDE_X_top, BOX_SIDE_X_bottom, BOX_SIDE_Z_top, BOX_SIDE_Z_bottom}},
	attach_left			= {0, -120},
	attach_right		= {45, -60},
}
elements["pnt_215"]	= default_button(_("SAI Test Button - Push to test"),	devices.SAI, sai_commands.SAI_test, 215)


-- Integrated Fuel/Engine Indicator (IFEI)
elements["pnt_168"]	= short_way_button(_("IFEI Mode Button"),			devices.IFEI, IFEI_commands.IFEI_BTN_MODE,			168)
elements["pnt_169"]	= short_way_button(_("IFEI QTY Button"),			devices.IFEI, IFEI_commands.IFEI_BTN_QTY,			169)
elements["pnt_170"]	= short_way_button(_("IFEI Up Arrow Button"),		devices.IFEI, IFEI_commands.IFEI_BTN_UP_ARROW,		170)
elements["pnt_171"]	= short_way_button(_("IFEI Down Arrow Button"),		devices.IFEI, IFEI_commands.IFEI_BTN_DOWN_ARROW,	171)
elements["pnt_172"]	= short_way_button(_("IFEI ZONE Button"),			devices.IFEI, IFEI_commands.IFEI_BTN_ZONE,			172)
elements["pnt_173"]	= short_way_button(_("IFEI ET Button"),				devices.IFEI, IFEI_commands.IFEI_BTN_ET,			173)
elements["pnt_174"]	= default_axis(_("IFEI Brightness Control Knob"),	devices.IFEI, IFEI_commands.IFEI_Brightness,		174, 0.5, 0.1, nil, nil, nil, {0, -90})

-- Sensor panel
elements["pnt_440"]	= multiposition_switch_with_pull(_("RADAR Switch (MW to pull), OFF/STBY/OPR/EMERG(PULL)"),
	devices.RADAR, RADAR_commands.RADAR_SwitchChange, 440, 4, 0.1, false, 0, 1.5, false, RADAR_commands.RADAR_SwitchPull, 0, {90, -135}, {90, -45})
-- OLD
local INS_sw = multiposition_switch_cl(_("INS Switch, OFF/CV/GND/NAV/IFA/GYRO/GB/TEST"), devices.INS, INS_commands.INS_SwitchChange, 443, 8, 0.1, false, 0, 1.5, true, {90, -135}, {110, -45})
INS_sw.animated		= {false,false} -- TEMP
elements["pnt_443"]	= INS_sw
-- NEW - still buggy
--elements["pnt_443"]	= multiposition_switch_cl(_("INS switch"), devices.INS, INS_commands.INS_SwitchChange, 443, 9, 0.1, false, -0.1, 1.5, true)

-- UFC
elements["pnt_128"]		= short_way_button(_("UFC Function Selector Pushbutton, A/P"),			devices.UFC, UFC_commands.FuncSwAP,		128)
elements["pnt_129"]		= short_way_button(_("UFC Function Selector Pushbutton, IFF"),			devices.UFC, UFC_commands.FuncSwIFF,	129)
elements["pnt_130"]		= short_way_button(_("UFC Function Selector Pushbutton, TCN"),			devices.UFC, UFC_commands.FuncSwTCN,	130)
elements["pnt_131"]		= short_way_button(_("UFC Function Selector Pushbutton, ILS"),			devices.UFC, UFC_commands.FuncSwILS,	131)
elements["pnt_132"]		= short_way_button(_("UFC Function Selector Pushbutton, D/L"),			devices.UFC, UFC_commands.FuncSwDL,		132)
elements["pnt_133"]		= short_way_button(_("UFC Function Selector Pushbutton, BCN"),			devices.UFC, UFC_commands.FuncSwBCN,	133)
elements["pnt_134"]		= short_way_button(_("UFC Function Selector Pushbutton, ON/OFF"),		devices.UFC, UFC_commands.FuncSwOnOff,	134)
elements["pnt_100"]		= short_way_button(_("UFC Option Select Pushbutton 1"),					devices.UFC, UFC_commands.OptSw1,		100)
elements["pnt_101"]		= short_way_button(_("UFC Option Select Pushbutton 2"),					devices.UFC, UFC_commands.OptSw2,		101)
elements["pnt_102"]		= short_way_button(_("UFC Option Select Pushbutton 3"),					devices.UFC, UFC_commands.OptSw3,		102)
elements["pnt_103"]		= short_way_button(_("UFC Option Select Pushbutton 4"),					devices.UFC, UFC_commands.OptSw4,		103)
elements["pnt_106"]		= short_way_button(_("UFC Option Select Pushbutton 5"),					devices.UFC, UFC_commands.OptSw5,		106)
elements["pnt_111"]		= short_way_button(_("UFC Keyboard Pushbutton, 1"),						devices.UFC, UFC_commands.KbdSw1,		111)
elements["pnt_112"]		= short_way_button(_("UFC Keyboard Pushbutton, 2"),						devices.UFC, UFC_commands.KbdSw2,		112)
elements["pnt_113"]		= short_way_button(_("UFC Keyboard Pushbutton, 3"),						devices.UFC, UFC_commands.KbdSw3,		113)
elements["pnt_114"]		= short_way_button(_("UFC Keyboard Pushbutton, 4"),						devices.UFC, UFC_commands.KbdSw4,		114)
elements["pnt_115"]		= short_way_button(_("UFC Keyboard Pushbutton, 5"),						devices.UFC, UFC_commands.KbdSw5,		115)
elements["pnt_116"]		= short_way_button(_("UFC Keyboard Pushbutton, 6"),						devices.UFC, UFC_commands.KbdSw6,		116)
elements["pnt_117"]		= short_way_button(_("UFC Keyboard Pushbutton, 7"),						devices.UFC, UFC_commands.KbdSw7,		117)
elements["pnt_118"]		= short_way_button(_("UFC Keyboard Pushbutton, 8"),						devices.UFC, UFC_commands.KbdSw8,		118)
elements["pnt_119"]		= short_way_button(_("UFC Keyboard Pushbutton, 9"),						devices.UFC, UFC_commands.KbdSw9,		119)
elements["pnt_120"]		= short_way_button(_("UFC Keyboard Pushbutton, 0"),						devices.UFC, UFC_commands.KbdSw0,		120)
elements["pnt_47_121"]	= short_way_button(_("UFC Keyboard Pushbutton, CLR"),					devices.UFC, UFC_commands.KbdSwCLR,		121)
elements["pnt_47_122"]	= short_way_button(_("UFC Keyboard Pushbutton, ENT"),					devices.UFC, UFC_commands.KbdSwENT,		122)
elements["pnt_99"]		= short_way_button(_("UFC I/P Pushbutton"),								devices.UFC, UFC_commands.SwIP,			99)
elements["pnt_110"]		= short_way_button(_("UFC Emission Control Pushbutton"),				devices.UFC, UFC_commands.SwEMCON,		110)
elements["pnt_107"]		= default_3_position_tumb(_("UFC ADF Function Select Switch, 1/OFF/2"), devices.UFC, UFC_commands.SwADF,		107,	false, anim_speed_default, false)
elements["pnt_108"]		= default_axis_limited(_("UFC COMM 1 Volume Control Knob"),				devices.UFC, UFC_commands.Comm1Vol,		108,	0.0, 0.1, false, false, {0,1})
elements["pnt_123"]		= default_axis_limited(_("UFC COMM 2 Volume Control Knob"),				devices.UFC, UFC_commands.Comm2Vol,		123,	0.0, 0.1, false, false, {0,1})
elements["pnt_109"]		= default_axis_limited(_("UFC Brightness Control Knob"),				devices.UFC, UFC_commands.BrtDim,		109,	0.0, 0.1, false, false, {0,1})
elements["pnt_124"]		= default_button_axis_tumb(_("UFC COMM 1 Channel Selector Knob"),	devices.UFC, UFC_commands.Comm1Fcn,	UFC_commands.Comm1Ch,	125, 124,	0.2, true, anim_speed_default, true)
elements["pnt_124"].sound	= {{SOUND_SW12}}
elements["pnt_126"]		= default_button_axis_tumb(_("UFC COMM 2 Channel Selector Knob"),	devices.UFC, UFC_commands.Comm2Fcn,	UFC_commands.Comm2Ch,	127, 126,	0.2, true, anim_speed_default, false)
elements["pnt_126"].sound	= {{SOUND_SW12}}

-- intercom
elements["pnt_357"]		= default_axis_limited(_("VOX Volume Control Knob"),							devices.INTERCOM, intercom_commands.VOX_Volume,		357,	0.0, 0.1, false, false, {0,1})
elements["pnt_358"]		= default_axis_limited(_("ICS Volume Control Knob"),							devices.INTERCOM, intercom_commands.ICS_Volume,		358,	0.0, 0.1, false, false, {0,1})
elements["pnt_359"]		= default_axis_limited(_("RWR Volume Control Knob"),							devices.INTERCOM, intercom_commands.RWR_Volume,		359,	0.0, 0.1, false, false, {0,1})
elements["pnt_360"]		= default_axis_limited(_("WPN Volume Control Knob"),							devices.INTERCOM, intercom_commands.WPN_Volume,		360,	0.0, 0.1, false, false, {0,1})
elements["pnt_361"]		= default_axis_limited(_("MIDS B Volume Control Knob"),							devices.INTERCOM, intercom_commands.MIDS_B_Volume,	361,	0.0, 0.1, false, false, {0,1})
elements["pnt_362"]		= default_axis_limited(_("MIDS A Volume Control Knob"),							devices.INTERCOM, intercom_commands.MIDS_A_Volume,	362,	0.0, 0.1, false, false, {0,1})
elements["pnt_363"]		= default_axis_limited(_("TACAN Volume Control Knob"),							devices.INTERCOM, intercom_commands.TCN_Volume,		363,	0.0, 0.1, false, false, {0,1})
elements["pnt_364"]		= default_axis_limited(_("AUX Volume Control Knob"),							devices.INTERCOM, intercom_commands.AUX_Volume,		364,	0.0, 0.1, false, false, {0,1})
elements["pnt_350"]		= default_3_position_tumb(_("Comm Relay Switch, CIPHER/OFF/PLAIN"),				devices.INTERCOM, intercom_commands.COMM_RLY_Sw,	350,	false, anim_speed_default, false)
elements["pnt_351"]		= default_3_position_tumb(_("COMM G XMT Switch, COMM 1/OFF/COMM 2"),			devices.INTERCOM, intercom_commands.G_XMT_Sw,		351,	false, anim_speed_default, false)

elements["pnt_356"]		= default_2_position_tumb(_("IFF Master Switch, EMER/NORM"),					devices.INTERCOM, intercom_commands.IFF_MasterSw,	356)
elements["pnt_355"]		= default_3_position_tumb(_("IFF Mode 4 Switch, DIS/AUD /DIS/OFF"),				devices.INTERCOM, intercom_commands.IFF_Mode4Sw,	355,	false, anim_speed_default, false)
elements["pnt_354"]		= springloaded_3_pos_tumb2(_("CRYPTO Switch, HOLD/NORM/ZERO"),					devices.INTERCOM, intercom_commands.IFF_CryptoSw_Zero, intercom_commands.IFF_CryptoSw_Hold,	354,	anim_speed_default)

elements["pnt_353"]		= default_2_position_tumb(_("ILS UFC/MAN Switch, UFC/MAN"),						devices.INTERCOM, intercom_commands.ILS_UFC_MAN_Sw,	353)
elements["pnt_352"]		= multiposition_switch(_("ILS Channel Selector Switch"),						devices.INTERCOM, intercom_commands.ILS_ChannelSelector,	352, 20, 0.05, false, 0.0, anim_speed_default * 0.05, false)

elements["pnt_444"]		= multiposition_switch(_("KY-58 Mode Select Knob, P/C/LD/RV"),					devices.KY58, ky58_commands.KY58_ModeSw,			444, 4, 0.1, false, 0.0, anim_speed_default * 0.1, false, {90, -135}, {90, -45})
elements["pnt_445"]		= default_axis_limited(_("KY-58 Volume Control Knob"),							devices.KY58, ky58_commands.KY58_Volume,			445, 0.0, 0.1, false, false, {0,1}, {90, -135}, {90, -45})
elements["pnt_446"]		= multiposition_switch(_("KY-58 Fill Select Knob, Z 1-5/1/2/3/4/5/6/Z ALL"),	devices.KY58, ky58_commands.KY58_FillSw,			446, 8, 0.1, false, 0.0, anim_speed_default * 0.1, false, {90, -135}, {110, -45})
elements["pnt_447"]		= multiposition_switch(_("KY-58 Power Select Knob, OFF/ON/TD"),					devices.KY58, ky58_commands.KY58_PowerSw,			447, 3, 0.1, false, 0.0, anim_speed_default * 0.1, false, {90, -135}, {110, -45})

elements["pnt_230"]		= default_button(_("Warning Tone Silence Button - Push to silence"),			devices.INTERCOM, intercom_commands.WarnToneSilBtn, 230)

-- antenna selector
elements["pnt_373"]		= default_3_position_tumb(_("COMM 1 Antenna Selector Switch, UPPER/AUTO/LOWER"),	devices.ANTENNA_SELECTOR, antsel_commands.Comm1AntSelSw,	373,	false, anim_speed_default, false)
elements["pnt_374"]		= default_3_position_tumb(_("IFF Antenna Selector Switch, UPPER/BOTH/LOWER"),		devices.ANTENNA_SELECTOR, antsel_commands.AntSelIFFSw,		374,	false, anim_speed_default, false)

-- RWR
elements["pnt_277"]		= default_2_position_tumb(_("ALR-67 POWER Pushbutton"),							devices.RWR, rwr_commands.Power, 277)
elements["pnt_275"]		= short_way_button(_("ALR-67 DISPLAY Pushbutton"),								devices.RWR, rwr_commands.Display, 275)
elements["pnt_272"]		= short_way_button(_("ALR-67 SPECIAL Pushbutton"),								devices.RWR, rwr_commands.Special, 272)
elements["pnt_269"]		= short_way_button(_("ALR-67 OFFSET Pushbutton"),								devices.RWR, rwr_commands.Offset, 269)
elements["pnt_266"]		= short_way_button(_("ALR-67 BIT Pushbutton"),									devices.RWR, rwr_commands.Bit, 266)
elements["pnt_263"]		= default_axis_limited(_("ALR-67 DMR Control Knob"),							devices.RWR, rwr_commands.DmrControl, 263, 0.0, 0.1, false, false, {0,1})
elements["pnt_262"]		= default_axis_limited(_("ALR-67 AUDIO Control Knob (no function)"),			0, 3130, 262, 0.0, 0.1, false, false, {0,1})
elements["pnt_261"]		= multiposition_switch(_("ALR-67 DIS TYPE Switch, N/I/A/U/F"),					devices.RWR, rwr_commands.DisType, 261, 5, 0.1, false, 0.0, anim_speed_default * 0.1, false)
elements["pnt_216"]		= default_axis_limited(_("RWR Intensity Knob"),									devices.RWR, rwr_commands.IntControl, 216, 0.0, 0.1, false, false, {0,1}, nil, {90,-60})

-- CMDS
elements["pnt_380"]		= default_button(_("Dispense Button - Push to dispense flares and chaff"),	devices.CMDS, cmds_commands.EcmDisp, 380)
elements["pnt_517"]		= default_3_position_tumb(_("DISPENSER Switch, BYPASS/ON/OFF"),				devices.CMDS, cmds_commands.Dispenser, 517, false, anim_speed_default, false, 0.1, {0.0, 0.2})
elements["pnt_515"]		= push_button_tumb(_("ECM JETT JETT SEL Button - Push to jettison"),		devices.CMDS, cmds_commands.EcmJett, 515)

-- ICMCP
elements["pnt_248"]		= multiposition_switch(_("ECM Mode Switch, XMIT/REC/BIT/STBY/OFF"),		devices.ASPJ, ASPJ_commands.ASPJ_SwitchChange, 248, 5, 0.1, false, 0.0, anim_speed_default * 0.1, false)

-- Targeting Pod, FLIR
elements["pnt_439"]		= default_3_position_tumb(_("FLIR Switch, ON/STBY/OFF"),		devices.TGP_INTERFACE, tgp_commands.Flir, 439)--, false, anim_speed_default * 0.5, false, 0.5, {0,1})
elements["pnt_441"]		= springloaded_2_pos_tumb(_("LTD/R Switch, ARM/SAFE"),			devices.TGP_INTERFACE, tgp_commands.LtdrArm, 441)--, false, anim_speed_default * 0.5, false, 0.5, {0,1})
elements["pnt_442"]		= default_2_position_tumb(_("LST/NFLR Switch, ON/OFF"),			devices.TGP_INTERFACE, tgp_commands.Lst, 442)

-- Helmet
elements["pnt_136"]		= default_axis_limited(_("HMD OFF/BRT Knob"),								devices.HMD_INTERFACE, hmd_commands.BrtKnob, 136, 0.0, 0.1, false, false, {0,0.75}, nil, {110, -45})


-- TODO list
elements["pnt_507"]		= default_2_position_tumb(_("NUC WPN Switch, ENABLE/DISABLE (no function)"),		0, 3100, 507)

elements["pnt_175"]		= default_3_position_tumb(_("Selector Switch, HMD/LDDI/RDDI"),					0, 3104, 175)
elements["pnt_176"]		= default_3_position_tumb(_("Selector Switch, HUD/LDIR/RDDI"),					0, 3105, 176)
elements["pnt_314"]		= default_3_position_tumb(_("Mode Selector Switch, MAN/OFF/AUTO"),				0, 3106, 314)

elements["pnt_07"]		= default_button(_("HUD Video BIT Initiate Pushbutton - Push to initiate BIT"),	0, 3107, 7)


elements["pnt_315"]		= default_button(_("Left Video Sensor BIT Initiate Pushbutton - Push to initiate BIT"),		0, 3127, 315)
elements["pnt_315"].updatable	= true
elements["pnt_318"]		= default_button(_("Right Video Sensor BIT Initiate Pushbutton - Push to initiate BIT"),	0, 3128, 318)
elements["pnt_318"].updatable	= true
