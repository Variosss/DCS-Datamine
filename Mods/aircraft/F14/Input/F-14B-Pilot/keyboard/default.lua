local cockpit = folder.."../../../Cockpit/"
local f14input = folder.."../../../Input/"
dofile(cockpit.."devices.lua")
dofile(cockpit.."command_defs.lua")
dofile(f14input.."utils.lua")


local res = external_profile("Config/Input/Aircrafts/common_keyboard_binding.lua")
local res2 = external_profile(f14input.."F-14B/keyboard/default.lua")
join_override(res.keyCommands, res2.keyCommands)
join_override(res.keyCommands,{

-- auto
{combos = {{key = 'Home', reformers = {'LWin'}}}, down = device_commands.AUTO_StartPilot, cockpit_device_id=devices.AUTO, value_down = 1, name = _('Auto Start'),		category = _('Cheat')},


--************** Engine and fuel *********************************************************************
{combos = {{key = 'T', reformers = {'LCtrl'}}},	down = device_commands.ENGINE_Throttle_Mode_Toggle, cockpit_device_id=devices.ENGINE, value_down = 1, name = _('Toggle Auto Throttle'), category = _('Engine Control Panel')},
{down = device_commands.ENGINE_Throttle_Mode, 		cockpit_device_id = devices.ENGINE, value_down = -1, name = _('Throttle Mode MAN'), category = { _('Throttle')}},
{down = device_commands.ENGINE_Throttle_Mode, 		cockpit_device_id = devices.ENGINE, value_down = 0, name = _('Throttle Mode BOOST'), category = { _('Throttle')}},
{down = device_commands.ENGINE_Throttle_Mode, 		cockpit_device_id = devices.ENGINE, value_down = 1, name = _('Throttle Mode AUTO'), category = { _('Throttle')}},
{down = device_commands.ENGINE_Throttle_Mode,     up = device_commands.ENGINE_Throttle_Mode, value_down = -1, value_up = 0, cockpit_device_id = devices.ENGINE, name = _('Throttle Mode MAN else BOOST'), category = _('Throttle')},
{down = device_commands.ENGINE_Throttle_Mode,     up = device_commands.ENGINE_Throttle_Mode, value_down = 1, value_up = 0, cockpit_device_id = devices.ENGINE, name = _('Throttle Mode AUTO else BOOST'), category = _('Throttle')},
{down = device_commands.ENGINE_AfterBurner_Gate,     up = device_commands.ENGINE_AfterBurner_Gate, value_down = 1, value_up = 0, cockpit_device_id = devices.ENGINE, name = _('Afterburner Gate'), category = _('Throttle')},
{down = device_commands.ENGINE_Mid_Compression_Bypass_CB,     up = device_commands.ENGINE_Mid_Compression_Bypass_CB, value_down = 1, value_up = 0, cockpit_device_id = devices.ENGINE, name = _('Mid Compression Bypass CB Pull - TF30 only'), category = _('Engine Control Panel')},
{down = device_commands.FIRE_Bottle_Fire_L,     up = device_commands.FIRE_Bottle_Fire_L , value_down = 0, value_up = 1, cockpit_device_id = devices.FIRE, name = _('Left Engine Fire Agent Discharge'), category = _('Firewall')},
{down = device_commands.FIRE_Bottle_Fire_R,     up = device_commands.FIRE_Bottle_Fire_R , value_down = 0, value_up = 1, cockpit_device_id = devices.FIRE, name = _('Right Engine Fire Agent Discharge'), category = _('Firewall')},

{down = device_commands.ENGINE_Crank, cockpit_device_id=devices.ENGINE, value_down = 1, name = _('Crank Left Engine'), category = _('Engine Control Panel')},
{down = device_commands.ENGINE_Crank, cockpit_device_id=devices.ENGINE, value_down = -1, name = _('Crank Right Engine'), category = _('Engine Control Panel')},

{down = device_commands.FUELSYSTEM_WingExt_Trans,     up = device_commands.FUELSYSTEM_WingExt_Trans, value_down = 1, value_up = 0, cockpit_device_id=devices.FUELSYSTEM, name = _('Wing/External Transfer Oride, else Auto'), category = _('Fuelsystem Control Panel')},
{down = device_commands.FUELSYSTEM_WingExt_Trans,     up = device_commands.FUELSYSTEM_WingExt_Trans, value_down = -1, value_up = 0, cockpit_device_id=devices.FUELSYSTEM, name = _('Wing/External Transfer Off, else Auto'), category = _('Fuelsystem Control Panel')},
{down = device_commands.FUELSYSTEM_WingExt_Trans, cockpit_device_id=devices.FUELSYSTEM, value_down = 1, name = _('Wing/External Transfer Oride'), category = _('Fuelsystem Control Panel')},
{down = device_commands.FUELSYSTEM_WingExt_Trans, cockpit_device_id=devices.FUELSYSTEM, value_down = 0, name = _('Wing/External Transfer Auto'), category = _('Fuelsystem Control Panel')},
{down = device_commands.FUELSYSTEM_WingExt_Trans, cockpit_device_id=devices.FUELSYSTEM, value_down = -1, name = _('Wing/External Transfer Off'), category = _('Fuelsystem Control Panel')},

{down = device_commands.FUELSYSTEM_Dump,     up = device_commands.FUELSYSTEM_Dump, value_down = 1, value_up = -1, cockpit_device_id=devices.FUELSYSTEM, name = _('Fueldump Dump, else Off'), category = _('Fuelsystem Control Panel')},
{down = device_commands.FUELSYSTEM_Dump,     up = device_commands.FUELSYSTEM_Dump, value_down = -1, value_up = 1, cockpit_device_id=devices.FUELSYSTEM, name = _('Fueldump Off, else Dump'), category = _('Fuelsystem Control Panel')},
{down = device_commands.FUELSYSTEM_Dump, cockpit_device_id=devices.FUELSYSTEM, value_down = -1, name = _('Fueldump Off'), category = _('Fuelsystem Control Panel')},
{down = device_commands.FUELSYSTEM_Dump, cockpit_device_id=devices.FUELSYSTEM, value_down = 1, name = _('Fueldump Dump'), category = _('Fuelsystem Control Panel')},

{down = device_commands.FUELSYSTEM_Refuel_Probe,     up = device_commands.FUELSYSTEM_Refuel_Probe, value_down = 1, value_up = -1, cockpit_device_id=devices.FUELSYSTEM, name = _('Refuel Probe extend & Refuel All, else Retract Probe'), category = _('Fuelsystem Control Panel')},
{down = device_commands.FUELSYSTEM_Refuel_Probe,     up = device_commands.FUELSYSTEM_Refuel_Probe, value_down = 0, value_up = -1, cockpit_device_id=devices.FUELSYSTEM, name = _('Refuel Probe extend & Refuel Fuselage, else Retract Probe'), category = _('Fuelsystem Control Panel')},
{down = device_commands.FUELSYSTEM_Refuel_Probe,     up = device_commands.FUELSYSTEM_Refuel_Probe, value_down = 1, value_up = 0, cockpit_device_id=devices.FUELSYSTEM, name = _('Refuel Probe extend & Refuel All, else Refuel Fuselage'), category = _('Fuelsystem Control Panel')},
{down = device_commands.FUELSYSTEM_Refuel_Probe,     up = device_commands.FUELSYSTEM_Refuel_Probe, value_down = -1, value_up = 0, cockpit_device_id=devices.FUELSYSTEM, name = _('Refuel Probe retract, else extend & Refuel Fuselage'), category = _('Fuelsystem Control Panel')},
{down = device_commands.FUELSYSTEM_Refuel_Probe, cockpit_device_id=devices.FUELSYSTEM, value_down = 1, name = _('Refuel Probe extend, Refuel All'), category = _('Fuelsystem Control Panel')},
{down = device_commands.FUELSYSTEM_Refuel_Probe, cockpit_device_id=devices.FUELSYSTEM, value_down = 0, name = _('Refuel Probe extend, Refuel Fuselage'), category = _('Fuelsystem Control Panel')},
{down = device_commands.FUELSYSTEM_Refuel_Probe, cockpit_device_id=devices.FUELSYSTEM, value_down = -1, name = _('Refuel Probe Retract'), category = _('Fuelsystem Control Panel')},

{down = device_commands.FUELSYSTEM_Fuel_Qty_Sel,     up = device_commands.FUELSYSTEM_Fuel_Qty_Sel, value_down = 1, value_up = 0, cockpit_device_id=devices.FUELSYSTEM, name = _('QTY Select Wing, else Feed'), category = _('Fuelsystem Control Panel')},
{down = device_commands.FUELSYSTEM_Fuel_Qty_Sel,     up = device_commands.FUELSYSTEM_Fuel_Qty_Sel, value_down = -1, value_up = 0, cockpit_device_id=devices.FUELSYSTEM, name = _('QTY select External, else Feed'), category = _('Fuelsystem Control Panel')},

{down = device_commands.MASTER_Reset,     up = device_commands.MASTER_Reset, value_down = 1, value_up = 0, cockpit_device_id=devices.CADC, name = _('MASTER RESET'), category = _('Flight Control')},
{combos = {{key = 'Q',reformers={'LCtrl'}}}, down = device_commands.GEAR_Strut, value_down = 1, cockpit_device_id=devices.GEARHOOK, name = _('Nose strut extend'), category = _('Flight Control')},
{combos = {{key = 'A',reformers={'LCtrl'}}}, down = device_commands.GEAR_Strut, value_down = -1, cockpit_device_id=devices.GEARHOOK, name = _('Nose strut kneel'), category = _('Flight Control')},
{down = device_commands.GEAR_Strut, value_down = 0, cockpit_device_id=devices.GEARHOOK, name = _('Nose strut off'), category = _('Flight Control')},

{down = device_commands.PilotOxygenOn, 		cockpit_device_id = devices.COCKPITMECHANICS, value_down = 0, name = _('Pilot Oxygen OFF'), category = { _('Left sidewall')}},
{down = device_commands.PilotOxygenOn, 		cockpit_device_id = devices.COCKPITMECHANICS, value_down = 1, name = _('Pilot Oxygen ON'), category = { _('Left sidewall')}},
{down = device_commands.PilotOxygenOn,     up = device_commands.PilotOxygenOn, value_down = 1, value_up = 0, cockpit_device_id = devices.COCKPITMECHANICS, name = _('Pilot Oxygen ON, else OFF'), category = _('Left sidewall')},
{down = device_commands.PilotOxygen_toggle, 		cockpit_device_id = devices.COCKPITMECHANICS, value_down = 1, name = _('Pilot Oxygen Toggle'), category = { _('Left sidewall')}},

{down = device_commands.WINGSWEEP_EmergencySweepCover, 		cockpit_device_id = devices.WINGSWEEP, value_down = 0, name = _('Emergency Wing Sweep Handle Cover CLOSE'), category = { _('Throttle')}},
{down = device_commands.WINGSWEEP_EmergencySweepCover, 		cockpit_device_id = devices.WINGSWEEP, value_down = 1, name = _('Emergency Wing Sweep Handle Cover OPEN'), category = { _('Throttle')}},
{down = device_commands.WINGSWEEP_EmergencySweepCover,     up = device_commands.WINGSWEEP_EmergencySweepCover, value_down = 1, value_up = 0, cockpit_device_id = devices.WINGSWEEP, name = _('Emergency Wing Sweep Handle Cover OPEN else CLOSED'), category = _('Throttle')},
{down = device_commands.WINGSWEEP_EmergencySweepCover_toggle, 		cockpit_device_id = devices.WINGSWEEP, value_down = 1, name = _('Emergency Wing Sweep Handle Cover Toggle'), category = { _('Throttle')}},
{pressed = device_commands.Emergency_Wingsweep_step, cockpit_device_id=devices.WINGSWEEP, value_pressed = 0.01, value_up = 0, name = _('Emergency Wing Sweep Handle move Fwd'), category = _('Throttle')},
{pressed = device_commands.Emergency_Wingsweep_step, cockpit_device_id=devices.WINGSWEEP, value_pressed = -0.01, value_up = 0, name = _('Emergency Wing Sweep Handle move Aft'), category = _('Throttle')},
{down = device_commands.WINGSWEEP_EmergencyLeverExtended, cockpit_device_id=devices.WINGSWEEP, value_down = 1.0, name = _('Emergency Wing Sweep Handle Pull'), category = _('Throttle')},
{down = device_commands.WINGSWEEP_EmergencyLeverExtended, cockpit_device_id=devices.WINGSWEEP, value_down = 0.0, name = _('Emergency Wing Sweep Handle Push'), category = _('Throttle')},
{down = device_commands.WINGSWEEP_EmergencyLeverExtended, up = device_commands.WINGSWEEP_EmergencyLeverExtended, cockpit_device_id=devices.WINGSWEEP, value_down = 1.0, value_up = 0.0, name = _('Emergency Wing Sweep Handle Pulled else Pushed'), category = _('Throttle')},
{down = device_commands.WINGSWEEP_EmergencyLeverExtended, up = device_commands.WINGSWEEP_EmergencyLeverExtended, cockpit_device_id=devices.WINGSWEEP, value_down = 0.0, value_up = 1.0, name = _('Emergency Wing Sweep Handle Pushed else Pulled'), category = _('Throttle')},
{down = device_commands.WINGSWEEP_EmergencyLeverExtended_toggle, cockpit_device_id=devices.WINGSWEEP, value_down = 1.0, name = _('Emergency Wing Sweep Handle Pushed/ Pulled toggle'), category = _('Throttle')},

{down = device_commands.ENGINE_Probe_Anti_Ice, 		cockpit_device_id = devices.ENGINE, value_down = -1, name = _('Eng/Probe Anti Ice OFF'), category = { _('External Environment')}},
{down = device_commands.ENGINE_Probe_Anti_Ice, 		cockpit_device_id = devices.ENGINE, value_down = 0, name = _('Eng/Probe Anti Ice AUTO'), category = { _('External Environment')}},
{down = device_commands.ENGINE_Probe_Anti_Ice, 		cockpit_device_id = devices.ENGINE, value_down = 1, name = _('Eng/Probe Anti Ice ORIDE'), category = { _('External Environment')}},
{down = device_commands.ENGINE_Probe_Anti_Ice,     up = device_commands.ENGINE_Probe_Anti_Ice, value_down = -1, value_up = 0, cockpit_device_id = devices.ENGINE, name = _('Eng/Probe Anti Ice OFF, else AUTO'), category = _('External Environment')},
{down = device_commands.ENGINE_Probe_Anti_Ice,     up = device_commands.ENGINE_Probe_Anti_Ice, value_down = 1, value_up = 0, cockpit_device_id = devices.ENGINE, name = _('Eng/Probe Anti Ice ORIDE, else AUTO'), category = _('External Environment')},
{down = device_commands.ENGINE_Probe_Anti_Ice_toggle, 		cockpit_device_id = devices.ENGINE, value_down = 1, name = _('Eng/Probe Anti Ice Toggle'), category = { _('External Environment')}},

{down = device_commands.ENGINE_Asym_LimiterCover, 		cockpit_device_id = devices.ENGINE, value_down = 0, name = _('Asymmetric Thrust Limiter Cover CLOSE'), category = { _('Engine Control Panel')}},
{down = device_commands.ENGINE_Asym_LimiterCover, 		cockpit_device_id = devices.ENGINE, value_down = 1, name = _('Asymmetric Thrust Limiter Cover OPEN'), category = { _('Engine Control Panel')}},
{down = device_commands.ENGINE_Asym_LimiterCover,     up = device_commands.ENGINE_Asym_LimiterCover, value_down = 1, value_up = 0, cockpit_device_id = devices.ENGINE, name = _('Asymmetric Thrust Limiter Cover OPEN else CLOSED'), category = _('Engine Control Panel')},
{down = device_commands.ENGINE_Asym_LimiterCover_toggle, 		cockpit_device_id = devices.ENGINE, value_down = 1, name = _('Asymmetric Thrust Limiter Cover Toggle'), category = { _('Engine Control Panel')}},
{down = device_commands.ENGINE_Asym_Limiter, 		cockpit_device_id = devices.ENGINE, value_down = 0, name = _('Asymmetric Thrust Limiter ON'), category = { _('Engine Control Panel')}},
{down = device_commands.ENGINE_Asym_Limiter, 		cockpit_device_id = devices.ENGINE, value_down = 1, name = _('Asymmetric Thrust Limiter OFF'), category = { _('Engine Control Panel')}},
{down = device_commands.ENGINE_Asym_Limiter,     up = device_commands.ENGINE_Asym_Limiter, value_down = 1, value_up = 0, cockpit_device_id = devices.ENGINE, name = _('Asymmetric Thrust Limiter OFF else ON'), category = _('Engine Control Panel')},
{down = device_commands.ENGINE_Asym_Limiter_toggle, 		cockpit_device_id = devices.ENGINE, value_down = 1, name = _('Asymmetric Thrust Limiter Toggle'), category = { _('Engine Control Panel')}},

{down = device_commands.HYD_TRANSFER_PUMP_Switch, 		cockpit_device_id = devices.HYDRAULICS, value_down = 0, name = _('Hydraulic Transfer Pump Switch NORMAL'), category = { _('Right Sidewall')}},
{down = device_commands.HYD_TRANSFER_PUMP_Switch, 		cockpit_device_id = devices.HYDRAULICS, value_down = 1, name = _('Hydraulic Transfer Pump Switch SHUTOFF'), category = { _('Right Sidewall')}},
{down = device_commands.HYD_TRANSFER_PUMP_Switch,     up = device_commands.HYD_TRANSFER_PUMP_Switch, value_down = 1, value_up = 0, cockpit_device_id = devices.HYDRAULICS, name = _('Hydraulic Transfer Pump Switch SHUTOFF else NORMAL'), category = _('Right Sidewall')},
{down = device_commands.HYD_TRANSFER_PUMP_Switch_toggle, 		cockpit_device_id = devices.HYDRAULICS, value_down = 1, name = _('Hydraulic Transfer Pump Switch Toggle'), category = { _('Right Sidewall')}},
{down = device_commands.HYD_HandPump,     up = device_commands.HYD_HandPump, value_down = 1, value_up = 0, cockpit_device_id = devices.HYDRAULICS, name = _('Hydraulic Hand Pump'), category = _('Cockpit Mechanics')},

{down = device_commands.HYD_TRANSFER_PUMP_SwitchCover, 		cockpit_device_id = devices.HYDRAULICS, value_down = 0, name = _('Hydraulic Transfer Pump Switch Cover CLOSE'), category = { _('Right Sidewall')}},
{down = device_commands.HYD_TRANSFER_PUMP_SwitchCover, 		cockpit_device_id = devices.HYDRAULICS, value_down = 1, name = _('Hydraulic Transfer Pump Switch Cover OPEN'), category = { _('Right Sidewall')}},
{down = device_commands.HYD_TRANSFER_PUMP_SwitchCover,     up = device_commands.HYD_TRANSFER_PUMP_SwitchCover, value_down = 1, value_up = 0, cockpit_device_id = devices.HYDRAULICS, name = _('Hydraulic Transfer Pump Switch Cover OPEN else CLOSE'), category = _('Right Sidewall')},
{down = device_commands.HYD_TRANSFER_PUMP_SwitchCover_toggle, 		cockpit_device_id = devices.HYDRAULICS, value_down = 1, name = _('Hydraulic Transfer Pump Switch Cover Toggle'), category = { _('Right Sidewall')}},

{down = device_commands.BIT_Selector_step, 		cockpit_device_id = devices.BITPANEL, value_down = 1, name = _('Master Test Selector CW'), category = { _('Right Sidewall')}},
{down = device_commands.BIT_Selector_step, 		cockpit_device_id = devices.BITPANEL, value_down = -1, name = _('Master Test Selector CCW'), category = { _('Right Sidewall')}},
{down = device_commands.BIT_Selector, 		cockpit_device_id = devices.BITPANEL, value_down = 0.0, name = _('Master Test Selector: OFF'), category = { _('Right Sidewall')}},
{down = device_commands.BIT_Selector, 		cockpit_device_id = devices.BITPANEL, value_down = 1.0/11.0, name = _('Master Test Selector: LTS'), category = { _('Right Sidewall')}},
{down = device_commands.BIT_Selector, 		cockpit_device_id = devices.BITPANEL, value_down = 2.0/11.0, name = _('Master Test Selector: FIRE DET/EXT'), category = { _('Right Sidewall')}},
{down = device_commands.BIT_Selector, 		cockpit_device_id = devices.BITPANEL, value_down = 3.0/11.0, name = _('Master Test Selector: INST'), category = { _('Right Sidewall')}},
{down = device_commands.BIT_Selector, 		cockpit_device_id = devices.BITPANEL, value_down = 4.0/11.0, name = _('Master Test Selector: OBC'), category = { _('Right Sidewall')}},
{down = device_commands.BIT_Selector, 		cockpit_device_id = devices.BITPANEL, value_down = 5.0/11.0, name = _('Master Test Selector: EMERG GEN'), category = { _('Right Sidewall')}},
{down = device_commands.BIT_Selector, 		cockpit_device_id = devices.BITPANEL, value_down = 6.0/11.0, name = _('Master Test Selector: WG SWP'), category = { _('Right Sidewall')}},
{down = device_commands.BIT_Selector, 		cockpit_device_id = devices.BITPANEL, value_down = 7.0/11.0, name = _('Master Test Selector: FLTGR DW'), category = { _('Right Sidewall')}},
{down = device_commands.BIT_Selector, 		cockpit_device_id = devices.BITPANEL, value_down = 8.0/11.0, name = _('Master Test Selector: FLTGR UP'), category = { _('Right Sidewall')}},
{down = device_commands.BIT_Selector, 		cockpit_device_id = devices.BITPANEL, value_down = 9.0/11.0, name = _('Master Test Selector: D/L RAD'), category = { _('Right Sidewall')}},
{down = device_commands.BIT_Selector, 		cockpit_device_id = devices.BITPANEL, value_down = 10.0/11.0, name = _('Master Test Selector: STICK SW'), category = { _('Right Sidewall')}},
{down = device_commands.BIT_SelectorPush, up = device_commands.BIT_SelectorPush, 		cockpit_device_id = devices.BITPANEL, value_down = 1.0, value_up = 0.0, name = _('Master Test Selector PULLED else PUSHED'), category = { _('Right Sidewall')}},
{down = device_commands.BIT_SelectorPush_toggle,	cockpit_device_id = devices.BITPANEL, value_down = 1.0, name = _('Master Test Selector push/pull toggle'), category = { _('Right Sidewall')}},

{down = device_commands.FUELSYSTEM_Fuel_Feed_Cover, 		cockpit_device_id = devices.FUELSYSTEM, value_down = 0, name = _('Fuel Feed Cover CLOSE'), category = { _('Fuelsystem Control Panel')}},
{down = device_commands.FUELSYSTEM_Fuel_Feed_Cover, 		cockpit_device_id = devices.FUELSYSTEM, value_down = 1, name = _('Fuel Feed Cover OPEN'), category = { _('Fuelsystem Control Panel')}},
{down = device_commands.FUELSYSTEM_Fuel_Feed_Cover,     up = device_commands.FUELSYSTEM_Fuel_Feed_Cover, value_down = 1, value_up = 0, cockpit_device_id = devices.FUELSYSTEM, name = _('Fuel Feed Cover OPEN else CLOSE'), category = _('Fuelsystem Control Panel')},
{down = device_commands.FUELSYSTEM_Fuel_Feed_Cover_toggle, 		cockpit_device_id = devices.FUELSYSTEM, value_down = 1.0, name = _('Fuel Feed Cover Toggle'), category = { _('Fuelsystem Control Panel')}},
{down = device_commands.FUELSYSTEM_Fuel_Feed, 		cockpit_device_id = devices.FUELSYSTEM, value_down = -1, name = _('Fuel Feed AFT'), category = { _('Fuelsystem Control Panel')}},
{down = device_commands.FUELSYSTEM_Fuel_Feed, 		cockpit_device_id = devices.FUELSYSTEM, value_down = 0, name = _('Fuel Feed NORM'), category = { _('Fuelsystem Control Panel')}},
{down = device_commands.FUELSYSTEM_Fuel_Feed, 		cockpit_device_id = devices.FUELSYSTEM, value_down = 1, name = _('Fuel Feed FWD'), category = { _('Fuelsystem Control Panel')}},
{down = device_commands.FUELSYSTEM_Fuel_Feed,     up = device_commands.FUELSYSTEM_Fuel_Feed, value_down = 1, value_up = 0, cockpit_device_id = devices.FUELSYSTEM, name = _('Fuel Feed FWD else NORM'), category = _('Fuelsystem Control Panel')},
{down = device_commands.FUELSYSTEM_Fuel_Feed,     up = device_commands.FUELSYSTEM_Fuel_Feed, value_down = -1, value_up = 0, cockpit_device_id = devices.FUELSYSTEM, name = _('Fuel Feed AFT else NORM'), category = _('Fuelsystem Control Panel')},
{down = device_commands.FUELSYSTEM_Fuel_Feed_toggle, 		cockpit_device_id = devices.FUELSYSTEM, value_down = 1, name = _('Fuel Feed Toggle'), category = { _('Fuelsystem Control Panel')}},
{pressed = device_commands.FUELSYSTEM_Bingo_Knob, cockpit_device_id=devices.FUELSYSTEM, value_pressed = 0.02, value_up = 0, name = _('BINGO Fuel Level Knob Inc'), category = _('Fuelsystem Control Panel')},
{pressed = device_commands.FUELSYSTEM_Bingo_Knob, cockpit_device_id=devices.FUELSYSTEM, value_pressed = -0.02, value_up = 0, name = _('BINGO Fuel Level Knob Dec'), category = _('Fuelsystem Control Panel')},

--******************* Flight Control *****************************************************************

-- Flight Control
{combos = {{key = 'Up'}},									pressed = iCommandPlaneUpStart, name = _('Aircraft Pitch Down'), category = _('Flight Control')},
{combos = {{key = 'Down'}},									pressed = iCommandPlaneDownStart, name = _('Aircraft Pitch Up'), category = _('Flight Control')},
{combos = {{key = 'Left'}}, down = iCommandPlaneLeftStart, up = iCommandPlaneLeftStop, name = _('Aircraft Bank Left'), category = _('Flight Control')},
{combos = {{key = 'Right'}}, down = iCommandPlaneRightStart, up = iCommandPlaneRightStop, name = _('Aircraft Bank Right'), category = _('Flight Control')},
{combos = {{key = 'Z'}}, down = iCommandPlaneLeftRudderStart, up = iCommandPlaneLeftRudderStop, name = _('Aircraft Rudder Left'), category = _('Flight Control')},
{combos = {{key = 'X'}}, down = iCommandPlaneRightRudderStart, up = iCommandPlaneRightRudderStop, name = _('Aircraft Rudder Right'), category = _('Flight Control')},

{combos = {{key = 'U'}}, down = iCommandPlaneShipTakeOff, name = _('Catapult Hook up'), category = _('Flight Control')},
{combos = {{key = 'U',reformers={'LShift'}}}, down=device_commands.CATAPULT_Salute, 	cockpit_device_id=devices.GEARHOOK, value_down=1.0, name = _('Catapult Salute'), category = _('Flight Control')},

{combos = {{key = 'Num+'}},									pressed = iCommandThrottleIncrease, up = iCommandThrottle1Stop, name = _('Throttle Up'), category = _('Flight Control')},
{combos = {{key = 'Num-'}},									pressed = iCommandThrottleDecrease, up = iCommandThrottle1Stop, name = _('Throttle Down'), category = _('Flight Control')},


{combos = {{key = ';', reformers = {'RCtrl'}}}, up=iCommandPlaneTrimPitch, pressed=iCommandPlaneTrimPitch, value_up=0.0, value_pressed=1.0,	name=_('Trim Pitch Up'),			 category = _('Flight Control')},
{combos = {{key = '.', reformers = {'RCtrl'}}}, up=iCommandPlaneTrimPitch, pressed=iCommandPlaneTrimPitch, value_up=0.0, value_pressed=-1.0,	name=_('Trim Pitch Down'),			 category = _('Flight Control')},
{combos = {{key = ',', reformers = {'RCtrl'}}}, up=iCommandPlaneTrimRoll, pressed=iCommandPlaneTrimRoll, value_up=0.0, value_pressed=-1.0,	name=_('Trim Roll Left Wing Down'), category = _('Flight Control')},
{combos = {{key = '/', reformers = {'RCtrl'}}}, up=iCommandPlaneTrimRoll, pressed=iCommandPlaneTrimRoll, value_up=0.0, value_pressed=1.0,		name=_('Trim Roll Right Wing Down'),category = _('Flight Control')},
{combos = {{key = 'Z', reformers = {'RCtrl'}}}, up=iCommandPlaneTrimRudder, pressed=iCommandPlaneTrimRudder, value_up=0.0, value_pressed=-1.0,name=_('Trim Rudder Left'),		 category = _('Flight Control')},
{combos = {{key = 'X', reformers = {'RCtrl'}}}, up=iCommandPlaneTrimRudder, pressed=iCommandPlaneTrimRudder, value_up=0.0, value_pressed=1.0,	name=_('Trim Rudder Right'),		 category = _('Flight Control')},

-- SAS
{down = device_commands.AFCS_Stability_Pitch,     up = device_commands.AFCS_Stability_Pitch, value_down = 1, value_up = -1, cockpit_device_id=devices.AFCS, name = _('AFCS Pitch Stabilisation On, else Off'), category = _('AFCS Control Panel')},
{down = device_commands.AFCS_Stability_Pitch,     up = device_commands.AFCS_Stability_Pitch, value_down = -1, value_up = 1, cockpit_device_id=devices.AFCS, name = _('AFCS Pitch Stabilisation Off, else On'), category = _('AFCS Control Panel')},
{down = device_commands.AFCS_Stability_Pitch, cockpit_device_id=devices.AFCS, value_down = 1, name = _('AFCS Pitch Stabilisation On'), category = _('AFCS Control Panel')},
{down = device_commands.AFCS_Stability_Pitch, cockpit_device_id=devices.AFCS, value_down = -1, name = _('AFCS Pitch Stabilisation Off'), category = _('AFCS Control Panel')},
{down = device_commands.AFCS_Stability_Pitch_Toggle, cockpit_device_id=devices.AFCS, value_down = 1, name = _('AFCS Pitch Stabilisation Toggle'), category = _('AFCS Control Panel')},

{down = device_commands.AFCS_Stability_Roll,     up = device_commands.AFCS_Stability_Roll, value_down = 1, value_up = -1, cockpit_device_id=devices.AFCS, name = _('AFCS Roll Stabilisation On, else Off'), category = _('AFCS Control Panel')},
{down = device_commands.AFCS_Stability_Roll,     up = device_commands.AFCS_Stability_Roll, value_down = -1, value_up = 1, cockpit_device_id=devices.AFCS, name = _('AFCS Roll Stabilisation Off, else On'), category = _('AFCS Control Panel')},
{down = device_commands.AFCS_Stability_Roll, cockpit_device_id=devices.AFCS, value_down = 1, name = _('AFCS Roll Stabilisation On'), category = _('AFCS Control Panel')},
{down = device_commands.AFCS_Stability_Roll, cockpit_device_id=devices.AFCS, value_down = -1, name = _('AFCS Roll Stabilisation Off'), category = _('AFCS Control Panel')},
{down = device_commands.AFCS_Stability_Roll_Toggle, cockpit_device_id=devices.AFCS, value_down = 1, name = _('AFCS Roll Stabilisation Toggle'), category = _('AFCS Control Panel')},

{down = device_commands.AFCS_Stability_Yaw,     up = device_commands.AFCS_Stability_Yaw, value_down = 1, value_up = -1, cockpit_device_id=devices.AFCS, name = _('AFCS Yaw Stabilisation On, else Off'), category = _('AFCS Control Panel')},
{down = device_commands.AFCS_Stability_Yaw,     up = device_commands.AFCS_Stability_Yaw, value_down = -1, value_up = 1, cockpit_device_id=devices.AFCS, name = _('AFCS Yaw Stabilisation Off, else On'), category = _('AFCS Control Panel')},
{down = device_commands.AFCS_Stability_Yaw, cockpit_device_id=devices.AFCS, value_down = 1, name = _('AFCS Yaw Stabilisation On'), category = _('AFCS Control Panel')},
{down = device_commands.AFCS_Stability_Yaw, cockpit_device_id=devices.AFCS, value_down = -1, name = _('AFCS Yaw Stabilisation Off'), category = _('AFCS Control Panel')},
{down = device_commands.AFCS_Stability_Yaw_Toggle, cockpit_device_id=devices.AFCS, value_down = 1, name = _('AFCS Yaw Stabilisation Toggle'), category = _('AFCS Control Panel')},

-- Autopilot
{down = device_commands.AP_Vector,     up = device_commands.AP_Vector, value_down = 1, value_up = 0, cockpit_device_id=devices.AFCS, name = _('Autopilot Vector VEC/PCD, else Off'), category = _('AFCS Control Panel')},
{down = device_commands.AP_Vector,     up = device_commands.AP_Vector, value_down = -1, value_up = 0, cockpit_device_id=devices.AFCS, name = _('Autopilot Vector ACL, else Off'), category = _('AFCS Control Panel')},
{down = device_commands.AP_Vector, cockpit_device_id=devices.AFCS, value_down = 1, name = _('Autopilot Vector VEC/PCD'), category = _('AFCS Control Panel')},
{down = device_commands.AP_Vector, cockpit_device_id=devices.AFCS, value_down = 0, name = _('Autopilot Vector Off'), category = _('AFCS Control Panel')},
{down = device_commands.AP_Vector, cockpit_device_id=devices.AFCS, value_down = -1, name = _('Autopilot Vector ACL'), category = _('AFCS Control Panel')},
{down = device_commands.AP_Vector_toggle_offvec, cockpit_device_id=devices.AFCS, value_down = 1, name = _('Autopilot Vector Toggle VEC/PCD'), category = _('AFCS Control Panel')},
{down = device_commands.AP_Vector_toggle_offacl, cockpit_device_id=devices.AFCS, value_down = 1, name = _('Autopilot Vector Toggle ACL'), category = _('AFCS Control Panel')},

{down = device_commands.AP_Altitude,     up = device_commands.AP_Altitude, value_down = 1, value_up = -1, cockpit_device_id=devices.AFCS, name = _('Altitude Hold On, else Off'), category = _('AFCS Control Panel')},
{down = device_commands.AP_Altitude,     up = device_commands.AP_Altitude, value_down = -1, value_up = 1, cockpit_device_id=devices.AFCS, name = _('Altitude Hold Off, else On'), category = _('AFCS Control Panel')},
{down = device_commands.AP_Altitude, cockpit_device_id=devices.AFCS, value_down = 1, name = _('Altitude Hold On'), category = _('AFCS Control Panel')},
{down = device_commands.AP_Altitude, cockpit_device_id=devices.AFCS, value_down = -1, name = _('Altitude Hold Off'), category = _('AFCS Control Panel')},
{down = device_commands.AP_Altitude_toggle, cockpit_device_id=devices.AFCS, value_down = 1, name = _('Altitude Hold Toggle'), category = _('AFCS Control Panel')},

{down = device_commands.AP_Heading,     up = device_commands.AP_Heading, value_down = 1, value_up = 0, cockpit_device_id=devices.AFCS, name = _('Heading Hold On, else Off'), category = _('AFCS Control Panel')},
{down = device_commands.AP_Heading,     up = device_commands.AP_Heading, value_down = -1, value_up = 0, cockpit_device_id=devices.AFCS, name = _('Heading Hold GT, else Off'), category = _('AFCS Control Panel')},
{down = device_commands.AP_Heading, cockpit_device_id=devices.AFCS, value_down = 1, name = _('Heading Hold On'), category = _('AFCS Control Panel')},
{down = device_commands.AP_Heading, cockpit_device_id=devices.AFCS, value_down = 0, name = _('Heading Hold Off'), category = _('AFCS Control Panel')},
{down = device_commands.AP_Heading, cockpit_device_id=devices.AFCS, value_down = -1, name = _('Heading Hold GT'), category = _('AFCS Control Panel')},
--{down = device_commands.AP_Heading_toggle_offgt, cockpit_device_id=devices.AFCS, value_down = 1, name = _('Autopilot Heading Toggle GT'), category = _('AFCS Control Panel')},
{down = device_commands.AP_Heading_toggle_offon, cockpit_device_id=devices.AFCS, value_down = 1, name = _('Autopilot Heading Toggle On'), category = _('AFCS Control Panel')},

{down = device_commands.AP_Engage,     up = device_commands.AP_Engage, value_down = 1, value_up = -1, cockpit_device_id=devices.AFCS, name = _('Autopilot On, else Off'), category = _('AFCS Control Panel')},
{down = device_commands.AP_Engage,     up = device_commands.AP_Engage, value_down = -1, value_up = 1, cockpit_device_id=devices.AFCS, name = _('Autopilot Off, else On'), category = _('AFCS Control Panel')},
{down = device_commands.AP_Engage, cockpit_device_id=devices.AFCS, value_down = 1, name = _('Autopilot On'), category = _('AFCS Control Panel')},
{down = device_commands.AP_Engage, cockpit_device_id=devices.AFCS, value_down = -1, name = _('Autopilot Off'), category = _('AFCS Control Panel')},
{ combos = {{key = 'A', reformers = {'LAlt'}}}, down=device_commands.AP_Engage_Toggle, cockpit_device_id=devices.AFCS, value_down=0.0, name=_('Autopilot toggle'),	 category=_('AFCS Control Panel')},

-- HOTAS
{ combos = {{key = 'Space', reformers = {'RAlt'}}}, up=device_commands.STICK_Bomb_Release, 				down=device_commands.STICK_Bomb_Release, 	cockpit_device_id=devices.HOTAS, value_up=0.0, value_down=1.0, 	name=_('Store Release'),	 category=_('Stick')},
{ up=device_commands.STICK_Trigger_Detent, 				down=device_commands.STICK_Trigger_Detent, 	cockpit_device_id=devices.HOTAS, value_up=0.0, value_down=1.0, 	name=_('Trigger First Detent'),	 category=_('Stick')},
{ combos = {{key = 'Space'}}, up=device_commands.STICK_Trigger, 					down=device_commands.STICK_Trigger,		 	cockpit_device_id=devices.HOTAS, value_up=0.0, value_down=1.0, 	name=_('Trigger'),	 category=_('Stick')},
{ up=device_commands.STICK_Weapon_Selector_up, 		down=device_commands.STICK_Weapon_Selector_up,		 	cockpit_device_id=devices.HOTAS, value_up=0.0, value_down=1.0, 	name=_('Weapon Selector up'),	 category=_('Stick')},
{ up=device_commands.STICK_Weapon_Selector_down, 	down=device_commands.STICK_Weapon_Selector_down,		 	cockpit_device_id=devices.HOTAS, value_up=0.0, value_down=1.0, 	name=_('Weapon Selector down'),	 category=_('Stick')},
{ up=device_commands.STICK_Weapon_Selector_press, 	down=device_commands.STICK_Weapon_Selector_press,		 	cockpit_device_id=devices.HOTAS, value_up=0.0, value_down=1.0, 	name=_('Weapon Selector press'),	 category=_('Stick')},
{ down=device_commands.STICK_Weapon_Selector, 		cockpit_device_id=devices.WEAPONS, value_down=1.0, 	name=_('Weapon Selector Gun'),	 category=_('Stick')},
{ down=device_commands.STICK_Weapon_Selector, 		cockpit_device_id=devices.WEAPONS, value_down=0.5, 	name=_('Weapon Selector Sparrow or Phoenix Missiles'),	 category=_('Stick')},
{ down=device_commands.STICK_Weapon_Selector, 		cockpit_device_id=devices.WEAPONS, value_down=-0.5, 	name=_('Weapon Selector Sidewinder Missiles'),	 category=_('Stick')},
{ down=device_commands.STICK_Weapon_Selector, 		cockpit_device_id=devices.WEAPONS, value_down=-1.0,	name=_('Weapon Selector Off'),	 category=_('Stick')},
{ up=device_commands.STICK_DLC_ManDec_Thumbwheel,  		pressed=device_commands.STICK_DLC_ManDec_Thumbwheel, 	cockpit_device_id=devices.HOTAS, value_pressed=1.0,  value_up=0,	name=_('DLC Thumbwheel Forward'), 	 category=_('Stick')},
{ up=device_commands.STICK_DLC_ManDec_Thumbwheel,   	pressed=device_commands.STICK_DLC_ManDec_Thumbwheel, 	cockpit_device_id=devices.HOTAS, value_pressed=-1.0, value_up=0,	name=_('DLC Thumbwheel Aft'),	 category=_('Stick')},
{ down=device_commands.STICK_DLC_Toggle_CountDisp,up=device_commands.STICK_DLC_Toggle_CountDisp, 	cockpit_device_id=devices.HOTAS, value_down=1.0,value_up=0.0,		name=_('DLC Toggle / Countermeasure Dispense'),	 category=_('Stick')},
{ down=device_commands.STICK_Autopilot_Emergency_Disconnect, up=device_commands.STICK_Autopilot_Emergency_Disconnect,	cockpit_device_id=devices.AFCS, value_down=1.0,value_up=0.0, 	name=_('Autopilot Emergency Disconnect Paddle'),	 category=_('Stick')},
{ combos = {{key = 'N'}}, down=device_commands.STICK_Autopilot_Ref_NWS_Toggle, up=device_commands.STICK_Autopilot_Ref_NWS_Toggle,	cockpit_device_id=devices.HOTAS, value_down=1.0,value_up=0.0,		name=_('Autopilot Reference / Nosewheel Steering Toggle'),	 category=_('Stick')},

{ up=device_commands.THROTTLE_CAGE_SEAM, down=device_commands.THROTTLE_CAGE_SEAM, cockpit_device_id=devices.HOTAS, value_up=0.0, value_down=1.0, name=_('CAGE-SEAM button'),	 category=_('Throttle')},
{ up=device_commands.THROTTLE_PLM, down=device_commands.THROTTLE_PLM, cockpit_device_id=devices.HOTAS, value_up=0.0, value_down=1.0, name=_('PLM button'),	 category=_('Throttle')},

{ down=device_commands.LIGHTS_Exterior_Master_Switch, cockpit_device_id=devices.COCKPITMECHANICS, value_down=0.0, name=_('Exterior Lights Master Switch OFF'),	 category=_('Throttle')},
{ down=device_commands.LIGHTS_Exterior_Master_Switch, cockpit_device_id=devices.COCKPITMECHANICS, value_down=1.0, name=_('Exterior Lights Master Switch ON'),	 category=_('Throttle')},
{ down=device_commands.LIGHTS_Exterior_Master_Switch_Toggle, cockpit_device_id=devices.COCKPITMECHANICS, value_down=1.0, value_up=0.0, name=_('Exterior Lights Master Switch Toggle'),	 category=_('Throttle')},
{ down=device_commands.LIGHTS_Exterior_Master_Switch, up=device_commands.LIGHTS_Exterior_Master_Switch, cockpit_device_id=devices.COCKPITMECHANICS, value_down=1.0, value_up=0.0, name=_('Exterior Lights Master Switch ON (pressed) / OFF (released)'),	 category=_('Throttle')},

{ up=device_commands.WINGSWEEP_AutoButton, down=device_commands.WINGSWEEP_AutoButton, cockpit_device_id=devices.WINGSWEEP, value_up=0.0, value_down=1.0, name=_('Wing Sweep Auto Mode'),	 category=_('Throttle')},
{ up=device_commands.WINGSWEEP_FwdButton, down=device_commands.WINGSWEEP_FwdButton, cockpit_device_id=devices.WINGSWEEP, value_up=0.0, value_down=1.0, name=_('Wing Sweep Forward'),	 category=_('Throttle')},
{ up=device_commands.WINGSWEEP_AftButton, down=device_commands.WINGSWEEP_AftButton, cockpit_device_id=devices.WINGSWEEP, value_up=0.0, value_down=1.0, name=_('Wing Sweep Aft'),	 category=_('Throttle')},
{ up=device_commands.WINGSWEEP_BombButton, down=device_commands.WINGSWEEP_BombButton, cockpit_device_id=devices.WINGSWEEP, value_up=0.0, value_down=1.0, name=_('Wing Sweep Bomb Mode'),	 category=_('Throttle')},

{cockpit_device_id=devices.ENGINE, down = device_commands.THROTTLE_Left_Throttle_CutOff , up = device_commands.THROTTLE_Left_Throttle_CutOff, value_up=0.0, value_down=1.0,  name = _('Left Engine Cutoff'), category = _('Throttle')},
{cockpit_device_id=devices.ENGINE, down = device_commands.THROTTLE_Right_Throttle_CutOff, up = device_commands.THROTTLE_Right_Throttle_CutOff, value_up=0.0, value_down=1.0, name = _('Right Engine Cutoff'), category = _('Throttle')},

-- pilot display control panel
{ combos={{key='1',reformers={'LShift'}}}, down=device_commands.DISP_mode_takeoff, cockpit_device_id=devices.HUD, value_down=1.0, name=_('Display mode takeoff'), category=_('PDCP')},
{ combos={{key='2',reformers={'LShift'}}}, down=device_commands.DISP_mode_cruise, cockpit_device_id=devices.HUD, value_down=1.0, name=_('Display mode cruise'), category=_('PDCP')},
{ combos={{key='3',reformers={'LShift'}}}, down=device_commands.DISP_mode_air2air, cockpit_device_id=devices.HUD, value_down=1.0, name=_('Display mode air to air'), category=_('PDCP')},
{ combos={{key='4',reformers={'LShift'}}}, down=device_commands.DISP_mode_air2ground, cockpit_device_id=devices.HUD, value_down=1.0, name=_('Display mode air to ground'), category=_('PDCP')},
{ combos={{key='5',reformers={'LShift'}}}, down=device_commands.DISP_mode_landing, cockpit_device_id=devices.HUD, value_down=1.0, name=_('Display mode landing'), category=_('PDCP')},
{ down=device_commands.DISP_mode_next, cockpit_device_id=devices.HUD, value_down=1.0, name=_('Display mode next'), category=_('PDCP')},
{ down=device_commands.DISP_mode_prev, cockpit_device_id=devices.HUD, value_down=1.0, name=_('Display mode previous'), category=_('PDCP')},

{down = device_commands.DISP_VDI_power,     up = device_commands.DISP_VDI_power, value_down = 1, value_up = 0, cockpit_device_id=devices.VDI, name = _('VDI Power On, else Off'), category = _('PDCP')},
{down = device_commands.DISP_VDI_power,     up = device_commands.DISP_VDI_power, value_down = 0, value_up = 1, cockpit_device_id=devices.VDI, name = _('VDI Power Off, else On'), category = _('PDCP')},
{down = device_commands.DISP_VDI_power, cockpit_device_id=devices.VDI, value_down = 1, name = _('VDI Power On'), category = _('PDCP')},
{down = device_commands.DISP_VDI_power, cockpit_device_id=devices.VDI, value_down = 0, name = _('VDI Power Off'), category = _('PDCP')},
{down = device_commands.DISP_VDI_power_toggle, cockpit_device_id=devices.VDI, value_down = 1, name = _('VDI Power Toggle'), category = _('PDCP')},

{down = device_commands.DISP_VDI_display_mode,     up = device_commands.DISP_VDI_display_mode, value_down = 1, value_up = 0, cockpit_device_id=devices.VDI, name = _('VDI Mode TV, else Norm'), category = _('PDCP')},
{down = device_commands.DISP_VDI_display_mode,     up = device_commands.DISP_VDI_display_mode, value_down = 0, value_up = 1, cockpit_device_id=devices.VDI, name = _('VDI Mode Norm, else TV'), category = _('PDCP')},
{down = device_commands.DISP_VDI_display_mode, cockpit_device_id=devices.VDI, value_down = 1, name = _('VDI Mode TV'), category = _('PDCP')},
{down = device_commands.DISP_VDI_display_mode, cockpit_device_id=devices.VDI, value_down = 0, name = _('VDI Mode Norm'), category = _('PDCP')},
{down = device_commands.DISP_VDI_display_mode_toggle, cockpit_device_id=devices.VDI, value_down = 1, name = _('VDI Mode Toggle'), category = _('PDCP')},

{down = device_commands.DISP_VDI_landing_mode,     up = device_commands.DISP_VDI_landing_mode, value_down = 1, value_up = 0, cockpit_device_id=devices.VDI, name = _('VDI AWL ILS, else ACL'), category = _('PDCP')},
{down = device_commands.DISP_VDI_landing_mode,     up = device_commands.DISP_VDI_landing_mode, value_down = 0, value_up = 1, cockpit_device_id=devices.VDI, name = _('VDI AWL ACL, else ILS'), category = _('PDCP')},
{down = device_commands.DISP_VDI_landing_mode, cockpit_device_id=devices.VDI, value_down = 1, name = _('VDI AWL ILS'), category = _('PDCP')},
{down = device_commands.DISP_VDI_landing_mode, cockpit_device_id=devices.VDI, value_down = 0, name = _('VDI AWL ACL'), category = _('PDCP')},
{down = device_commands.DISP_VDI_landing_mode_toggle, cockpit_device_id=devices.VDI, value_down = 1, name = _('VDI ACL/ILS Toggle'), category = _('PDCP')},

{pressed = device_commands.VDIG_VSDI_bright_step, cockpit_device_id=devices.VDI, value_pressed = 0.01, value_up = 0, name = _('VDI Screen Brightness Knob Inc'), category = _('PDCP')},
{pressed = device_commands.VDIG_VSDI_bright_step, cockpit_device_id=devices.VDI, value_pressed = -0.01, value_up = 0, name = _('VDI Screen Brightness Knob Dec'), category = _('PDCP')},
{pressed = device_commands.VDIG_VDI_contrast_step, cockpit_device_id=devices.VDI, value_pressed = 0.01, value_up = 0, name = _('VDI Screen Contrast Inc'), category = _('PDCP')},
{pressed = device_commands.VDIG_VDI_contrast_step, cockpit_device_id=devices.VDI, value_pressed = -0.01, value_up = 0, name = _('VDI Screen Contrast Dec'), category = _('PDCP')},
{pressed = device_commands.VDIG_VSDI_trim_step, cockpit_device_id=devices.VDI, value_pressed = 0.004, value_up = 0, name = _('VDI Trim Inc'), category = _('PDCP')},
{pressed = device_commands.VDIG_VSDI_trim_step, cockpit_device_id=devices.VDI, value_pressed = -0.004, value_up = 0, name = _('VDI Trim Dec'), category = _('PDCP')},

{down = device_commands.DISP_HUD_power,     up = device_commands.DISP_HUD_power, value_down = 1, value_up = 0, cockpit_device_id=devices.HUD, name = _('HUD Power On, else Off'), category = _('PDCP')},
{down = device_commands.DISP_HUD_power,     up = device_commands.DISP_HUD_power, value_down = 0, value_up = 1, cockpit_device_id=devices.HUD, name = _('HUD Power Off, else On'), category = _('PDCP')},
{down = device_commands.DISP_HUD_power, cockpit_device_id=devices.HUD, value_down = 1, name = _('HUD Power On'), category = _('PDCP')},
{down = device_commands.DISP_HUD_power, cockpit_device_id=devices.HUD, value_down = 0, name = _('HUD Power Off'), category = _('PDCP')},
{down = device_commands.DISP_HUD_power_toggle, cockpit_device_id=devices.HUD, value_down = 1, name = _('HUD Power Toggle'), category = _('PDCP')},

{down = device_commands.DISP_HUD_declutter,     up = device_commands.DISP_HUD_declutter, value_down = 1, value_up = 0, cockpit_device_id=devices.HUD, name = _('HUD Declutter On, else Off'), category = _('PDCP')},
{down = device_commands.DISP_HUD_declutter,     up = device_commands.DISP_HUD_declutter, value_down = 0, value_up = 1, cockpit_device_id=devices.HUD, name = _('HUD Declutter Off, else On'), category = _('PDCP')},
{down = device_commands.DISP_HUD_declutter, cockpit_device_id=devices.HUD, value_down = 1, name = _('HUD Declutter On'), category = _('PDCP')},
{down = device_commands.DISP_HUD_declutter, cockpit_device_id=devices.HUD, value_down = 0, name = _('HUD Declutter Off'), category = _('PDCP')},
{down = device_commands.DISP_HUD_declutter_toggle, cockpit_device_id=devices.HUD, value_down = 1, name = _('HUD Declutter Toggle'), category = _('PDCP')},

{down = device_commands.DISP_HUD_AWL_mode,     up = device_commands.DISP_HUD_AWL_mode, value_down = 1, value_up = 0, cockpit_device_id=devices.HUD, name = _('HUD AWL ILS, else ACL'), category = _('PDCP')},
{down = device_commands.DISP_HUD_AWL_mode,     up = device_commands.DISP_HUD_AWL_mode, value_down = 0, value_up = 1, cockpit_device_id=devices.HUD, name = _('HUD AWL ACL, else ILS'), category = _('PDCP')},
{down = device_commands.DISP_HUD_AWL_mode, cockpit_device_id=devices.HUD, value_down = 1, name = _('HUD AWL ILS'), category = _('PDCP')},
{down = device_commands.DISP_HUD_AWL_mode, cockpit_device_id=devices.HUD, value_down = 0, name = _('HUD AWL ACL'), category = _('PDCP')},
{down = device_commands.DISP_HUD_AWL_mode_toggle, cockpit_device_id=devices.HUD, value_down = 1, name = _('HUD ACL/ILS Toggle'), category = _('PDCP')},

{pressed = device_commands.VDIG_HUD_bright_step, cockpit_device_id=devices.HUD, value_pressed = 0.01, value_up = 0, name = _('HUD Brightness Knob Inc'), category = _('PDCP')},
{pressed = device_commands.VDIG_HUD_bright_step, cockpit_device_id=devices.HUD, value_pressed = -0.01, value_up = 0, name = _('HUD Brightness Knob Dec'), category = _('PDCP')},
{pressed = device_commands.VDIG_HUD_trim_step, cockpit_device_id=devices.HUD, value_pressed = 0.002, value_up = 0, name = _('HUD Trim Inc'), category = _('PDCP')},
{pressed = device_commands.VDIG_HUD_trim_step, cockpit_device_id=devices.HUD, value_pressed = -0.002, value_up = 0, name = _('HUD Trim Dec'), category = _('PDCP')},

{down = device_commands.VDIG_VDI_handle, up = device_commands.VDIG_VDI_handle, cockpit_device_id=devices.HUD, value_down = 1.0, value_up = 0.0, name = _('HUD Filter pulled else pushed'), category = _('PDCP')},
{down = device_commands.VDIG_VDI_handle_toggle, cockpit_device_id=devices.HUD, value_down = 1.0, name = _('HUD Filter toggle'), category = _('PDCP')},

{down = device_commands.DISP_HSD_ECMD_power,     up = device_commands.DISP_HSD_ECMD_power, value_down = 1, value_up = 0, cockpit_device_id=devices.HSD, name = _('HSD/ECM Power On, else Off'), category = _('PDCP')},
{down = device_commands.DISP_HSD_ECMD_power,     up = device_commands.DISP_HSD_ECMD_power, value_down = 0, value_up = 1, cockpit_device_id=devices.HSD, name = _('HSD/ECM Power Off, else On'), category = _('PDCP')},
{down = device_commands.DISP_HSD_ECMD_power, cockpit_device_id=devices.HSD, value_down = 1, name = _('HSD/ECM Power On'), category = _('PDCP')},
{down = device_commands.DISP_HSD_ECMD_power, cockpit_device_id=devices.HSD, value_down = 0, name = _('HSD/ECM Power Off'), category = _('PDCP')},
{down = device_commands.DISP_HSD_ECMD_power_toggle, cockpit_device_id=devices.HSD, value_down = 1, name = _('HSD/ECM Power Toggle'), category = _('PDCP')},

{down = device_commands.HSD_Display_Mode_Cycle,     up = device_commands.HSD_Display_Mode_Cycle, value_down = 1, value_up = 0, cockpit_device_id=devices.HSD, name = _('HSD Mode NAV, else TID'), category = _('PDCP')},
{down = device_commands.HSD_Display_Mode_Cycle,     up = device_commands.HSD_Display_Mode_Cycle, value_down = 0, value_up = 1, cockpit_device_id=devices.HSD, name = _('HSD Mode TID, else NAV'), category = _('PDCP')},
{down = device_commands.HSD_Display_Mode_Cycle, cockpit_device_id=devices.HSD, value_down = 1, name = _('HSD Mode NAV'), category = _('PDCP')},
{down = device_commands.HSD_Display_Mode_Cycle, cockpit_device_id=devices.HSD, value_down = 0, name = _('HSD Mode TID'), category = _('PDCP')},
{down = device_commands.HSD_Display_Mode_Cycle_toggle, cockpit_device_id=devices.HSD, value_down = 1, name = _('HSD mode Toggle'), category = _('PDCP')},

{pressed = device_commands.HSD_Knob_Course, cockpit_device_id=devices.HSD, value_pressed = 0.001, value_up = 0, name = _('HSD Course Knob Inc'), category = _('PDCP')},
{pressed = device_commands.HSD_Knob_Course, cockpit_device_id=devices.HSD, value_pressed = -0.001, value_up = 0, name = _('HSD Course Knob Dec'), category = _('PDCP')},
{pressed = device_commands.HSD_Knob_Heading, cockpit_device_id=devices.HSD, value_pressed = 0.0015, value_up = 0, name = _('HSD Heading Knob Inc'), category = _('PDCP')},
{pressed = device_commands.HSD_Knob_Heading, cockpit_device_id=devices.HSD, value_pressed = -0.0015, value_up = 0, name = _('HSD Heading Knob Dec'), category = _('PDCP')},
{pressed = device_commands.HSD_Knob_Brightness_IncDec, cockpit_device_id=devices.HSD, value_pressed = 0.01, value_up = 0, name = _('HSD Brightness Knob Inc'), category = _('PDCP')},
{pressed = device_commands.HSD_Knob_Brightness_IncDec, cockpit_device_id=devices.HSD, value_pressed = -0.01, value_up = 0, name = _('HSD Brightness Knob Dec'), category = _('PDCP')},

{down = device_commands.HSD_ECM_Override,     up = device_commands.HSD_ECM_Override, value_down = 1, value_up = 0, cockpit_device_id=devices.HSD, name = _('HSD ECM Override On, else Off'), category = _('PDCP')},
{down = device_commands.HSD_ECM_Override,     up = device_commands.HSD_ECM_Override, value_down = 0, value_up = 1, cockpit_device_id=devices.HSD, name = _('HSD ECM Override Off, else On'), category = _('PDCP')},
{down = device_commands.HSD_ECM_Override, cockpit_device_id=devices.HSD, value_down = 1, name = _('HSD ECM Override On'), category = _('PDCP')},
{down = device_commands.HSD_ECM_Override, cockpit_device_id=devices.HSD, value_down = 0, name = _('HSD ECM Override Off'), category = _('PDCP')},
{down = device_commands.HSD_ECM_Override_toggle, cockpit_device_id=devices.HSD, value_down = 0, name = _('HSD ECM Override Toggle'), category = _('PDCP')},

{down = device_commands.HSD_Btn_Test, up = device_commands.HSD_Btn_Test, cockpit_device_id=devices.HSD, value_down = 1.0, value_up = 0.0, name = _('HSD Test Button'), category = _('PDCP')},

{down = device_commands.NAV_Btn_Steer_TCN,     up = device_commands.NAV_Btn_Steer_TCN, value_down = 1, value_up = 0, cockpit_device_id=devices.NAV_INTERFACE, name = _('STEER CMD TACAN'), category = _('PDCP')},
{down = device_commands.NAV_Btn_Steer_DEST,     up = device_commands.NAV_Btn_Steer_DEST, value_down = 1, value_up = 0, cockpit_device_id=devices.NAV_INTERFACE, name = _('STEER CMD Destination'), category = _('PDCP')},
{down = device_commands.NAV_Btn_Steer_AWL_PCD,     up = device_commands.NAV_Btn_Steer_AWL_PCD, value_down = 1, value_up = 0, cockpit_device_id=devices.NAV_INTERFACE, name = _('STEER CMD AWL/PCD'), category = _('PDCP')},
{down = device_commands.NAV_Btn_Steer_VEC,     up = device_commands.NAV_Btn_Steer_VEC, value_down = 1, value_up = 0, cockpit_device_id=devices.NAV_INTERFACE, name = _('STEER CMD VEC'), category = _('PDCP')},
{down = device_commands.NAV_Btn_Steer_MAN,     up = device_commands.NAV_Btn_Steer_MAN, value_down = 1, value_up = 0, cockpit_device_id=devices.NAV_INTERFACE, name = _('STEER CMD MAN'), category = _('PDCP')},

-- Master WLP_Master_Caution_RIO
{combos = {{key = 'M', reformers = {'LAlt'}}} , 			down=device_commands.WLP_Master_Caution_Pilot, 	up=device_commands.WLP_Master_Caution_Pilot, cockpit_device_id=devices.WARNINGLIGHTS, value_down=1.0, value_up=0.0, name = _('Master Caution Reset'), category = _('ACM Panel')},
{ down=device_commands.WEAP_ACM_Cover_Toggle, cockpit_device_id=devices.WEAPONS, value_down=1.0, name=_('ACM cover toggle'), category=_('ACM Panel')},
{ down=device_commands.WEAP_ACM_Cover, cockpit_device_id=devices.WEAPONS, value_down=1.0, name=_('ACM cover open'), category=_('ACM Panel')},
{ down=device_commands.WEAP_ACM_Cover, cockpit_device_id=devices.WEAPONS, value_down=0.0, name=_('ACM cover close'), category=_('ACM Panel')},


-- Trimmer


-- Airbrake
{combos={{key='B',reformers={'LCtrl'}}},			up=device_commands.SPEEDBRAKE_ExtendRetract, pressed=device_commands.SPEEDBRAKE_ExtendRetract, 	cockpit_device_id=devices.GEARHOOK, value_up=0.0, value_pressed=1.0, 	name=_('Speed brake extend'),category=_('Gears, brakes, and hook')},
{combos={{key='B',reformers={'LShift'}}},			up=device_commands.SPEEDBRAKE_ExtendRetract, pressed=device_commands.SPEEDBRAKE_ExtendRetract, 	cockpit_device_id=devices.GEARHOOK, value_up=0.0, value_pressed=-1.0,	name=_('Speed brake retract'),category=_('Gears, brakes, and hook')},
{combos={{key='B'}}, down=device_commands.SPEEDBRAKE_Toggle, 	cockpit_device_id=devices.GEARHOOK, value_down=1.0,	name=_('Speed brake toggle'),category=_('Gears, brakes, and hook')},

-- parking brake
{up=device_commands.BRAKE_ParkingBrake, down=device_commands.BRAKE_ParkingBrake, 	cockpit_device_id=devices.GEARHOOK, value_up=1.0, value_down=0.0,	name=_('Parking brake enabled, else disabed'),category=_('Gears, brakes, and hook')},
{combos = {{key = 'P',	reformers = {'RCtrl'}}}, down=device_commands.BRAKE_ParkingBrake, 	cockpit_device_id=devices.GEARHOOK, value_down=0.0,	name=_('Parking brake pull'),category=_('Gears, brakes, and hook')},
{combos = {{key = 'P',	reformers = {'RAlt'}}}, down=device_commands.BRAKE_ParkingBrake, 	cockpit_device_id=devices.GEARHOOK, value_down=1.0,	name=_('Parking brake stow'),category=_('Gears, brakes, and hook')},

-- Flaps
{combos = {{key = 'F'}}, 									down=device_commands.FLAPS_Lever, 	cockpit_device_id=devices.FLAPS, value_down=0.0, name = _('Flaps Down'), category = _('Flight Control')},
{combos = {{key = 'F', reformers = {'LShift'}}} , 			down=device_commands.FLAPS_Lever, 	cockpit_device_id=devices.FLAPS, value_down=1.0, name = _('Flaps Up'), category = _('Flight Control')},
{combos = {{key = 'F', reformers = {'LCtrl'}}}, 			down=device_commands.FLAPS_Lever, 	cockpit_device_id=devices.FLAPS, value_down=-1, name = _('Emergency Flaps Down'), category = _('Flight Control')},
{combos = {{key = 'F', reformers = {'LCtrl','LShift'}}} , 	down=device_commands.FLAPS_Lever, 	cockpit_device_id=devices.FLAPS, value_down=2.0, name = _('Emergency Flaps Up'), category = _('Flight Control')},

-- ACM Panel
{ down=device_commands.WEAP_Master_Arm_Cover, cockpit_device_id=devices.WEAPONS, value_down=-1.0, name=_('Master arm cover toggle'), category=_('ACM Panel')},
{ down=device_commands.WEAP_Master_Arm_Cover, cockpit_device_id=devices.WEAPONS, value_down=1.0, name=_('Master arm cover open'), category=_('ACM Panel')},
{ down=device_commands.WEAP_Master_Arm_Cover, cockpit_device_id=devices.WEAPONS, value_down=0.0, name=_('Master arm cover close'), category=_('ACM Panel')},
{ down=device_commands.WEAP_Master_Arm_And_Cover, cockpit_device_id=devices.WEAPONS, value_down=1.0, name=_('Master arm on and cover open'), category=_('ACM Panel')},
{ down=device_commands.WEAP_Master_Arm_And_Cover, cockpit_device_id=devices.WEAPONS, value_down=0.0, name=_('Master arm off and cover close'), category=_('ACM Panel')},
{down = device_commands.WEAP_Master_Arm_And_Cover,     up = device_commands.WEAP_Master_Arm_And_Cover, value_down = 1, value_up = 0, cockpit_device_id=devices.WEAPONS, name = _('Master Arm On and Cover Open, else Safe and Closed'), category = _('ACM Panel')},
{down = device_commands.WEAP_Master_Arm_And_Cover,     up = device_commands.WEAP_Master_Arm_And_Cover, value_down = 0, value_up = 1, cockpit_device_id=devices.WEAPONS, name = _('Master Arm Safe and Cover Closed, else Open and Armed'), category = _('ACM Panel')},

{down = device_commands.WEAP_ACM_Cover,     up = device_commands.WEAP_ACM_Cover, value_down = 1, value_up = 0, cockpit_device_id=devices.WEAPONS, name = _('ACM Cover Open, else Closed'), category = _('ACM Panel')},
{down = device_commands.WEAP_ACM_Cover,     up = device_commands.WEAP_ACM_Cover, value_down = 0, value_up = 1, cockpit_device_id=devices.WEAPONS, name = _('ACM Cover Closed, else Open'), category = _('ACM Panel')},

{ combos = {{key = 'W', reformers = {'LCtrl'}}}, down=device_commands.WEAP_Emer_Jettison, up=device_commands.WEAP_Emer_Jettison, cockpit_device_id=devices.WEAPONS, value_down=1.0, value_up=0.0, name=_('Emergency Jettison'), category=_('Weapons')},
{ down=device_commands.WEAP_ACM_Jettison, up=device_commands.WEAP_ACM_Jettison, cockpit_device_id=devices.WEAPONS, value_down=1.0, value_up=0.0, name=_('ACM Jettison'), category=_('ACM Panel')},
{ down=device_commands.WEAP_MSL_Mode, up=device_commands.WEAP_MSL_Mode, cockpit_device_id=devices.WEAPONS, value_down=1.0, value_up=0.0, name=_('Missile mode toggle'), category=_('ACM Panel')},
{ down=device_commands.WEAP_Gun_Rate, up=device_commands.WEAP_Gun_Rate, cockpit_device_id=devices.WEAPONS, value_down=1.0, value_up=0.0, name=_('Gun rate toggle'), category=_('ACM Panel')},
{ down=device_commands.WEAP_SW_Cool, up=device_commands.WEAP_SW_Cool, cockpit_device_id=devices.WEAPONS, value_down=1.0, value_up=0.0, name=_('AIM-9 cooling toggle'), category=_('ACM Panel')},
{ down=device_commands.WEAP_MSL_Prep, up=device_commands.WEAP_MSL_Prep, cockpit_device_id=devices.WEAPONS, value_down=1.0, value_up=0.0, name=_('Missile prepare toggle'), category=_('ACM Panel')},

{ down=device_commands.WEAP_Master_Arm, cockpit_device_id=devices.WEAPONS, value_down=-1.0, name=_('Master arm on'), category=_('ACM Panel')},
{ down=device_commands.WEAP_Master_Arm, cockpit_device_id=devices.WEAPONS, value_down=0.0, name=_('Master arm off'), category=_('ACM Panel')},
{ down=device_commands.WEAP_Master_Arm, cockpit_device_id=devices.WEAPONS, value_down=1.0, name=_('Master arm training'), category=_('ACM Panel')},

{ down=device_commands.WEAP_Target_designate_up, up=device_commands.WEAP_Target_designate_up, cockpit_device_id=devices.WEAPONS, value_down=1.0, value_up=0.0, name=_('Target designate up / VSL HI'), category=_('Left sidewall')},
{ down=device_commands.WEAP_Target_designate_fwd, up=device_commands.WEAP_Target_designate_fwd, cockpit_device_id=devices.WEAPONS, value_down=1.0, value_up=0.0, name=_('Target designate fwd / PAL'), category=_('Left sidewall')},
{ down=device_commands.WEAP_Target_designate_down, up=device_commands.WEAP_Target_designate_down, cockpit_device_id=devices.WEAPONS, value_down=1.0, value_up=0.0, name=_('Target designate down / VSL LO'), category=_('Left sidewall')},





--************************************* Jester AI  ******************************************************************

--Menu
{combos = {{key = 'A'}},		 cockpit_device_id=devices.JESTERAI, up =device_commands.JESTER_ToggleMenu ,down=device_commands.JESTER_ToggleMenu, value_up=-1.0, value_down=1.0,	name=_('Toggle Menu'),	 category=_('Jester AI')},
{combos = {{key = '1',reformers={'LCtrl'}}},		 cockpit_device_id=devices.JESTERAI, down=device_commands.JESTER_Command1, value_down=1.0,	name=_('Command 1'),	 category=_('Jester AI')},
{combos = {{key = '2',reformers={'LCtrl'}}},		 cockpit_device_id=devices.JESTERAI, down=device_commands.JESTER_Command2, value_down=1.0,	name=_('Command 2'),	 category=_('Jester AI')},
{combos = {{key = '3',reformers={'LCtrl'}}},		 cockpit_device_id=devices.JESTERAI, down=device_commands.JESTER_Command3, value_down=1.0,	name=_('Command 3'),	 category=_('Jester AI')},
{combos = {{key = '4',reformers={'LCtrl'}}},		 cockpit_device_id=devices.JESTERAI, down=device_commands.JESTER_Command4, value_down=1.0,	name=_('Command 4'),	 category=_('Jester AI')},
{combos = {{key = '5',reformers={'LCtrl'}}},		 cockpit_device_id=devices.JESTERAI, down=device_commands.JESTER_Command5, value_down=1.0,	name=_('Command 5'),	 category=_('Jester AI')},
{combos = {{key = '6',reformers={'LCtrl'}}},		 cockpit_device_id=devices.JESTERAI, down=device_commands.JESTER_Command6, value_down=1.0,	name=_('Command 6'),	 category=_('Jester AI')},
{combos = {{key = '7',reformers={'LCtrl'}}},		 cockpit_device_id=devices.JESTERAI, down=device_commands.JESTER_Command7, value_down=1.0,	name=_('Command 7'),	 category=_('Jester AI')},
{combos = {{key = '8',reformers={'LCtrl'}}},		 cockpit_device_id=devices.JESTERAI, down=device_commands.JESTER_Command8, value_down=1.0,	name=_('Command 8'),	 category=_('Jester AI')},
{cockpit_device_id=devices.JESTERAI, down=device_commands.JESTER_MenuHorizontal, up=device_commands.JESTER_MenuHorizontal, value_down=-1.0, value_up=0.0, name=_('Jester Menu Left'),	 category=_('Jester AI')},
{cockpit_device_id=devices.JESTERAI, down=device_commands.JESTER_MenuHorizontal, up=device_commands.JESTER_MenuHorizontal, value_down=1.0, value_up=0.0, name=_('Jester Menu Right'),	 category=_('Jester AI')},
{cockpit_device_id=devices.JESTERAI, down=device_commands.JESTER_MenuVertical, up=device_commands.JESTER_MenuVertical, value_down=1.0, value_up=0.0, name=_('Jester Menu Up'),	 category=_('Jester AI')},
{cockpit_device_id=devices.JESTERAI, down=device_commands.JESTER_MenuVertical, up=device_commands.JESTER_MenuVertical, value_down=-1.0, value_up=0.0, name=_('Jester Menu Down'),	 category=_('Jester AI')},
{cockpit_device_id=devices.JESTERAI, down=device_commands.JESTER_MenuDiag45, up=device_commands.JESTER_MenuDiag45, value_down=-1.0, value_up=0.0, name=_('Jester Menu Down Left'),	 category=_('Jester AI')},
{cockpit_device_id=devices.JESTERAI, down=device_commands.JESTER_MenuDiag45, up=device_commands.JESTER_MenuDiag45, value_down=1.0, value_up=0.0, name=_('Jester Menu Up Right'),	 category=_('Jester AI')},
{cockpit_device_id=devices.JESTERAI, down=device_commands.JESTER_MenuDiag135, up=device_commands.JESTER_MenuDiag135, value_down=1.0, value_up=0.0, name=_('Jester Menu Down Right'),	 category=_('Jester AI')},
{cockpit_device_id=devices.JESTERAI, down=device_commands.JESTER_MenuDiag135, up=device_commands.JESTER_MenuDiag135, value_down=-1.0, value_up=0.0, name=_('Jester Menu Up Left'),	 category=_('Jester AI')},
{cockpit_device_id=devices.JESTERAI, down=device_commands.JESTER_Check, value_down=1.0,  name=_('Check'),	 category=_('Jester AI')},
{cockpit_device_id=devices.JESTERAI, down=device_commands.JESTER_LoudAndClear, value_down=1.0, name=_('Loud and Clear'),	 category=_('Jester AI')},
{combos = {{key = 'A',reformers={'LShift'}}},		cockpit_device_id=devices.JESTERAI, down=device_commands.JESTER_CloseMenu, value_down=1.0,  name=_('Close Menu'),	 category=_('Jester AI')},

-- Nav related commands
{ cockpit_device_id=devices.JESTERAI, down=device_commands.JESTER_Steerpoint_SP1, value_down=1.0,	name=_('Nav - Set Steerpoint SP 1'),	 category=_('Jester AI')},
{ cockpit_device_id=devices.JESTERAI, down=device_commands.JESTER_Steerpoint_SP2, value_down=1.0,	name=_('Nav - Set Steerpoint SP 2'),	 category=_('Jester AI')},
{ cockpit_device_id=devices.JESTERAI, down=device_commands.JESTER_Steerpoint_SP3, value_down=1.0,	name=_('Nav - Set Steerpoint SP 3'),	 category=_('Jester AI')},
{ cockpit_device_id=devices.JESTERAI, down=device_commands.JESTER_Steerpoint_FP , value_down=1.0,	name=_('Nav - Set Steerpoint Fixed Point'),	 category=_('Jester AI')},
{ cockpit_device_id=devices.JESTERAI, down=device_commands.JESTER_Steerpoint_IP , value_down=1.0,	name=_('Nav - Set Steerpoint Initial Point'),	 category=_('Jester AI')},
{ cockpit_device_id=devices.JESTERAI, down=device_commands.JESTER_Steerpoint_ST , value_down=1.0,	name=_('Nav - Set Steerpoint Surface Target'),	 category=_('Jester AI')},
{ cockpit_device_id=devices.JESTERAI, down=device_commands.JESTER_Steerpoint_HB , value_down=1.0,	name=_('Nav - Set Steerpoint Home Base'),	 category=_('Jester AI')},
{ cockpit_device_id=devices.JESTERAI, down=device_commands.JESTER_Steerpoint_MAN, value_down=1.0,	name=_('Nav - Set Steerpoint Man'),	 category=_('Jester AI')},

-- Radar related Commands
{ cockpit_device_id=devices.JESTERAI, down=device_commands.JESTER_VSL_High , value_down=1.0,	name=_('Radar - VSL High'),	 category=_('Jester AI')},
{ cockpit_device_id=devices.JESTERAI, down=device_commands.JESTER_VSL_Low, value_down=1.0,	name=_('Radar - VSL Low'),	 category=_('Jester AI')},
{ cockpit_device_id=devices.JESTERAI, down=device_commands.JESTER_TogglePDorPStt, value_down=1.0,	name=_('Radar - Toggle PD-STT or P-STT'),	 category=_('Jester AI')},
{ cockpit_device_id=devices.JESTERAI, down=device_commands.JESTER_BreakLock, value_down=1.0,	name=_('Radar - Break Lock'),	 category=_('Jester AI')},
{ cockpit_device_id=devices.JESTERAI, down=device_commands.JESTER_Range_Auto, value_down=1.0,	name=_('Radar - Range Auto'),	 category=_('Jester AI')},
{ cockpit_device_id=devices.JESTERAI, down=device_commands.JESTER_Range_25 , value_down=1.0,	name=_('Radar - Range 25'),	     category=_('Jester AI')},
{ cockpit_device_id=devices.JESTERAI, down=device_commands.JESTER_Range_50 , value_down=1.0,	name=_('Radar - Range 50'),	     category=_('Jester AI')},
{ cockpit_device_id=devices.JESTERAI, down=device_commands.JESTER_Range_100, value_down=1.0,	name=_('Radar - Range 100'),	 category=_('Jester AI')},
{ cockpit_device_id=devices.JESTERAI, down=device_commands.JESTER_Range_200, value_down=1.0,	name=_('Radar - Range 200'),	 category=_('Jester AI')},
{ cockpit_device_id=devices.JESTERAI, down=device_commands.JESTER_Range_400, value_down=1.0,	name=_('Radar - Range 400'),	 category=_('Jester AI')},
{ cockpit_device_id=devices.JESTERAI, down=device_commands.JESTER_Lock_Ahead, value_down=1.0,	name=_('Radar - STT Lock Ahead'),	 category=_('Jester AI')},
{ cockpit_device_id=devices.JESTERAI, down=device_commands.JESTER_Lock_Ahead_Enemy, value_down=1.0,	name=_('Radar - STT Lock Enemy Ahead'),	 category=_('Jester AI')},
{ cockpit_device_id=devices.JESTERAI, down=device_commands.JESTER_Lock_Ahead_Friendly, value_down=1.0,	name=_('Radar - STT Lock Friendly Ahead'),	 category=_('Jester AI')},
{ cockpit_device_id=devices.JESTERAI, down=device_commands.JESTER_Ground_Stabilize, value_down=1.0,	name=_('Radar - Ground Stabilize'),	 category=_('Jester AI')},
{ cockpit_device_id=devices.JESTERAI, down=device_commands.JESTER_Aircraft_Stabilize, value_down=1.0,	name=_('Radar - Aircraft Stabilize'),	 category=_('Jester AI')},
{ cockpit_device_id=devices.JESTERAI, down=device_commands.JESTER_Radar_TWS, value_down=1.0,	name=_('Radar - TWS Mode'),	 category=_('Jester AI')},
{ cockpit_device_id=devices.JESTERAI, down=device_commands.JESTER_Radar_RWS, value_down=1.0,	name=_('Radar - RWS Mode'),	 category=_('Jester AI')},









--************************************* GEARS, G. Brakes and Drag chute  ******************************************************************

-- Gears
--{combos={{key='G'}}, 								down=device_commands.GEAR_Handle, 	cockpit_device_id=devices.GEARHOOK, value_down=1.0,	name='Gear Toggle',			category='Gears, brakes, and hook'},
{combos={{key='G',reformers={'LCtrl'}}},			down=device_commands.GEAR_Handle, 	cockpit_device_id=devices.GEARHOOK, value_down=1.0, 	name=_('Gears Down'),			 category=_('Gears, brakes, and hook')},
{combos={{key='G',reformers={'LShift'}}},			down=device_commands.GEAR_Handle, 	cockpit_device_id=devices.GEARHOOK, value_down=0,		name=_('Gears Up'),			 category=_('Gears, brakes, and hook')},
{combos={{key='G',reformers={'LCtrl','LShift'}}},	down=device_commands.GEAR_Handle,	cockpit_device_id=devices.GEARHOOK,	value_down=-1.0,	name=_('Gear Emergency Extend'),category=_('Gears, brakes, and hook')},
{combos={{key='G'}},								down=device_commands.GEAR_Toggle, 	cockpit_device_id=devices.GEARHOOK, value_down=0,		name=_('Gears Toggle'),			 category=_('Gears, brakes, and hook')},

{down = device_commands.GEAR_Handle,     up = device_commands.GEAR_Handle, value_down = 1, value_up = 0, cockpit_device_id=devices.GEARHOOK, name = _('Gear Down, else Up'), category = _('Gears, brakes, and hook')},
{down = device_commands.GEAR_Handle,     up = device_commands.GEAR_Handle, value_down = 0, value_up = 1, cockpit_device_id=devices.GEARHOOK, name = _('Gear Up, else Down'), category = _('Gears, brakes, and hook')},

--Hook
{combos={{key='H',reformers={'LCtrl'}}},			down=device_commands.HOOK_Handle,cockpit_device_id=devices.GEARHOOK,	value_down=1.0,	name=_('Hook Extend'),category=_('Gears, brakes, and hook')},
{combos={{key='H',reformers={'LShift'}}},			down=device_commands.HOOK_Handle,cockpit_device_id=devices.GEARHOOK,	value_down=0,	name=_('Hook Retract'),category=_('Gears, brakes, and hook')},
{combos={{key='H'}}, down=device_commands.HOOK_Toggle,cockpit_device_id=devices.GEARHOOK,	value_down=1.0,	name=_('Hook Toggle'),category=_('Gears, brakes, and hook')},
{down = device_commands.HOOK_Handle,     up = device_commands.HOOK_Handle, value_down = 1, value_up = 0, cockpit_device_id=devices.GEARHOOK, name = _('Hook Extend, else Retract'), category = _('Gears, brakes, and hook')},
{down = device_commands.HOOK_Handle,     up = device_commands.HOOK_Handle, value_down = 0, value_up = 1, cockpit_device_id=devices.GEARHOOK, name = _('Hook Retract, else Extend'), category = _('Gears, brakes, and hook')},


-- Wheel brake
{combos={{key='W'}},			up=iCommandWheelBrake, pressed=iCommandWheelBrake, 			 value_up=-1.0, value_pressed=1.0,	name=_('Wheel Brake both'),  category=_('Gears, brakes, and hook')},
{								up=iCommandLeftWheelBrake, pressed=iCommandLeftWheelBrake, 	 value_up=-1.0, value_pressed=1.0,	name=_('Wheel Brake Left'),  category=_('Gears, brakes, and hook')},
{								up=iCommandRightWheelBrake, pressed=iCommandRightWheelBrake, value_up=-1.0, value_pressed=1.0,	name=_('Wheel Brake Right'), category=_('Gears, brakes, and hook')},



{down = device_commands.BRAKE_AntiSkidAndSpoilerBrake, cockpit_device_id=devices.GEARHOOK, value_down = 1,  name = _('Antiskid & Spoiler BK - Both'), category = _('Gears, brakes, and hook')},
{down = device_commands.BRAKE_AntiSkidAndSpoilerBrake, cockpit_device_id=devices.GEARHOOK, value_down = 0,  name = _('Antiskid & Spoiler BK - Off'), category = _('Gears, brakes, and hook')},
{down = device_commands.BRAKE_AntiSkidAndSpoilerBrake, cockpit_device_id=devices.GEARHOOK, value_down = -1, name = _('Antiskid & Spoiler BK - Spoiler Only'), category = _('Gears, brakes, and hook')},
{down = device_commands.BRAKE_AntiSkidAndSpoilerBrake, up = device_commands.BRAKE_AntiSkidAndSpoilerBrake, value_down = -1, value_up = 0, cockpit_device_id=devices.GEARHOOK, name = _('Anti Skid Spoiler BK Switch Spoiler BK, else OFF'), category = _('Gears, brakes, and hook')},
{down = device_commands.BRAKE_AntiSkidAndSpoilerBrake, up = device_commands.BRAKE_AntiSkidAndSpoilerBrake, value_down = 1, value_up = 0, cockpit_device_id=devices.GEARHOOK, name = _('Anti Skid Spoiler BK Switch BOTH, else OFF'), category = _('Gears, brakes, and hook')},
{down = device_commands.BRAKE_AntiSkidAndSpoilerBrake_toggle, value_down = 1, cockpit_device_id=devices.GEARHOOK, name = _('Antiskid & Spoiler BK - Toggle'), category = _('Gears, brakes, and hook')},


--*************** RWR *****************************
{pressed = device_commands.RWR_Brightness_Pilot_Step, cockpit_device_id = devices.RWR, value_pressed = 1.0, value_up = 0, name = _('RWR Brightness Pilot Inc'), category = _('RWR')},
{pressed = device_commands.RWR_Brightness_Pilot_Step, cockpit_device_id = devices.RWR, value_pressed = -1.0, value_up = 0, name = _('RWR Brightness Pilot Dec'), category = _('RWR')},

--*************** Nav Wpt *********************
{combos = {{key = '`', reformers = {'LCtrl'}}}, down = device_commands.Mission_WPT_Next, cockpit_device_id=devices.NAV_INTERFACE, value_down = 1, value_up = 0, name = _('Next Waypoint'), category = _('Navigation')},
{combos = {{key = '`', reformers = {'LShift'}}}, down = device_commands.Mission_WPT_Prev, cockpit_device_id=devices.NAV_INTERFACE, value_down = 1, value_up = 0, name = _('Previous Waypoint'), category = _('Navigation')},


--**************************************--
---Cockpit mechanics
{combos = {{key='E',reformers={'LShift'}}}, down = device_commands.EJECT_ArmPilotToggle, cockpit_device_id=devices.COCKPITMECHANICS, value_down = -1, name = _('Toggle Arm Ejection Seat'), category = _('Cockpit Mechanics')},

{combos = {{key='Back'}}, down = device_commands.STICK_ShowHideToggle, cockpit_device_id=devices.COCKPITMECHANICS, value_down = 1, name = _('Control Stick Show/Hide'), category = _('Cheat')},
{down = device_commands.STICK_ShowHide, cockpit_device_id=devices.COCKPITMECHANICS, value_down = 0, name = _('Control Stick Show'), category = _('Cheat')},
{down = device_commands.STICK_ShowHide, cockpit_device_id=devices.COCKPITMECHANICS, value_down = 1, name = _('Control Stick Hide'), category = _('Cheat')},
{down = device_commands.STICK_ShowHide, up = device_commands.STICK_ShowHide, cockpit_device_id=devices.COCKPITMECHANICS, value_down = 0, value_up = 1, name = _('Control Stick Show, else Hide'), category = _('Cheat')},

--***************************************** Lights *************************************************************
{ down=device_commands.LIGHTS_PositionWings, cockpit_device_id=devices.COCKPITMECHANICS, value_down=0.0, name=_('Lights Position Wing OFF'),	 category=_('Lights')},
{ down=device_commands.LIGHTS_PositionWings, cockpit_device_id=devices.COCKPITMECHANICS, value_down=1.0, name=_('Lights Position Wing BRT'),	 category=_('Lights')},
{ down=device_commands.LIGHTS_PositionWings, cockpit_device_id=devices.COCKPITMECHANICS, value_down=-1.0, name=_('Lights Position Wing DIM'),	 category=_('Lights')},
{ down=device_commands.LIGHTS_PositionWings_Toggle, cockpit_device_id=devices.COCKPITMECHANICS, value_down=1.0, value_up=0.0, name=_('Lights Position Wing Toggle'),	 category=_('Lights')},
{ down=device_commands.LIGHTS_PositionTail, cockpit_device_id=devices.COCKPITMECHANICS, value_down=0.0, name=_('Lights Position Tail OFF'),	 category=_('Lights')},
{ down=device_commands.LIGHTS_PositionTail, cockpit_device_id=devices.COCKPITMECHANICS, value_down=1.0, name=_('Lights Position Tail BRT'),	 category=_('Lights')},
{ down=device_commands.LIGHTS_PositionTail, cockpit_device_id=devices.COCKPITMECHANICS, value_down=-1.0, name=_('Lights Position Tail DIM'),	 category=_('Lights')},
{ down=device_commands.LIGHTS_PositionTail_Toggle, cockpit_device_id=devices.COCKPITMECHANICS, value_down=1.0, value_up=0.0, name=_('Lights Position Tail Toggle'),	 category=_('Lights')},
{ down=device_commands.LIGHTS_PositionFlash, cockpit_device_id=devices.COCKPITMECHANICS, value_down=0.0, name=_('Lights Position STEADY'),	 category=_('Lights')},
{ down=device_commands.LIGHTS_PositionFlash, cockpit_device_id=devices.COCKPITMECHANICS, value_down=1.0, name=_('Lights Position FLASH'),	 category=_('Lights')},
{ down=device_commands.LIGHTS_PositionFlash_Toggle, cockpit_device_id=devices.COCKPITMECHANICS, value_down=1.0, value_up=0.0, name=_('Lights Position FLASH/STEADY Toggle'),	 category=_('Lights')},
{ down=device_commands.LIGHTS_AntiCol, cockpit_device_id=devices.COCKPITMECHANICS, value_down=0.0, name=_('Lights Anti Collision OFF'),	 category=_('Lights')},
{ down=device_commands.LIGHTS_AntiCol, cockpit_device_id=devices.COCKPITMECHANICS, value_down=1.0, name=_('Lights Anti Collision ON'),	 category=_('Lights')},
{ down=device_commands.LIGHTS_AntiCol_Toggle, cockpit_device_id=devices.COCKPITMECHANICS, value_down=1.0, value_up=0.0, name=_('Lights Anti Collision Toggle'),	 category=_('Lights')},
{ down=device_commands.AoA_HookBypass, cockpit_device_id=devices.AOASYSTEM, value_down=0.0, name=_('Lights Hook Bypass CARRIER'),	 category=_('Lights')},
{ down=device_commands.AoA_HookBypass, cockpit_device_id=devices.AOASYSTEM, value_down=1.0, name=_('Lights Hook Bypass FIELD'),	 category=_('Lights')},
{ down=device_commands.AoA_HookBypass_Toggle, cockpit_device_id=devices.AOASYSTEM, value_down=1.0, value_up=0.0, name=_('Lights Hook Bypass Toggle'),	 category=_('Lights')},
{ down=device_commands.LIGHTS_Taxi, cockpit_device_id=devices.COCKPITMECHANICS, value_down=0.0, name=_('Lights Taxi OFF'),	 category=_('Lights')},
{ down=device_commands.LIGHTS_Taxi, cockpit_device_id=devices.COCKPITMECHANICS, value_down=1.0, name=_('Lights Taxi ON'),	 category=_('Lights')},
{ down=device_commands.LIGHTS_Taxi_Toggle, cockpit_device_id=devices.COCKPITMECHANICS, value_down=1.0, value_up=0.0, name=_('Lights Taxi Toggle'),	 category=_('Lights')},
{ down=device_commands.LIGHTS_WhiteFlood, cockpit_device_id=devices.COCKPITMECHANICS, value_down=0.0, name=_('Lights White Flood OFF'),	 category=_('Lights')},
{ down=device_commands.LIGHTS_WhiteFlood, cockpit_device_id=devices.COCKPITMECHANICS, value_down=1.0, name=_('Lights White Flood BRT'),	 category=_('Lights')},
{ down=device_commands.LIGHTS_WhiteFlood, cockpit_device_id=devices.COCKPITMECHANICS, value_down=-1.0, name=_('Lights White Flood DIM'),	 category=_('Lights')},
{ down=device_commands.LIGHTS_WhiteFlood_Toggle, cockpit_device_id=devices.COCKPITMECHANICS, value_down=1.0, value_up=0.0, name=_('Lights White Flood Toggle'),	 category=_('Lights')},
{ down=device_commands.LIGHTS_RedFlood, cockpit_device_id=devices.COCKPITMECHANICS, value_down=0.0, name=_('Lights Red Flood OFF'),	 category=_('Lights')},
{ down=device_commands.LIGHTS_RedFlood, cockpit_device_id=devices.COCKPITMECHANICS, value_down=1.0, name=_('Lights Red Flood BRT'),	 category=_('Lights')},
{ down=device_commands.LIGHTS_RedFlood, cockpit_device_id=devices.COCKPITMECHANICS, value_down=-1.0, name=_('Lights Red Flood DIM'),	 category=_('Lights')},
{ down=device_commands.LIGHTS_RedFlood_Toggle, cockpit_device_id=devices.COCKPITMECHANICS, value_down=1.0, value_up=0.0, name=_('Lights Red Flood Toggle'),	 category=_('Lights')},
{ down=device_commands.LIGHTS_ACMPanel_Step, cockpit_device_id=devices.COCKPITMECHANICS, value_down=1, value_up=0, name = _('Lights ACM Brightnes Up'), category = _('Lights')},
{ down=device_commands.LIGHTS_ACMPanel_Step, cockpit_device_id=devices.COCKPITMECHANICS, value_down=-1, value_up=0, name = _('Lights ACM Brightnes Down'), category = _('Lights')},
{ down=device_commands.AoA_IndexerStrength_Step, cockpit_device_id=devices.AOASYSTEM, value_down=1, value_up=0, name = _('Lights Indexer Brightnes Up'), category = _('Lights')},
{ down=device_commands.AoA_IndexerStrength_Step, cockpit_device_id=devices.AOASYSTEM, value_down=-1, value_up=0, name = _('Lights Indexer Brightnes Down'), category = _('Lights')},
{ down=device_commands.LIGHTS_Instruments_Step, cockpit_device_id=devices.COCKPITMECHANICS, value_down=1, value_up=0, name = _('Lights Instrument Brightnes Up'), category = _('Lights')},
{ down=device_commands.LIGHTS_Instruments_Step, cockpit_device_id=devices.COCKPITMECHANICS, value_down=-1, value_up=0, name = _('Lights Instrument Brightnes Down'), category = _('Lights')},
{ down=device_commands.LIGHTS_Console_Step, cockpit_device_id=devices.COCKPITMECHANICS, value_down=1, value_up=0, name = _('Lights Console Brightnes Up'), category = _('Lights')},
{ down=device_commands.LIGHTS_Console_Step, cockpit_device_id=devices.COCKPITMECHANICS, value_down=-1, value_up=0, name = _('Lights Console Brightnes Down'), category = _('Lights')},
{ down=device_commands.LIGHTS_Formation_Step, cockpit_device_id=devices.COCKPITMECHANICS, value_down=1, value_up=0, name = _('Lights Formation Brightnes Up'), category = _('Lights')},
{ down=device_commands.LIGHTS_Formation_Step, cockpit_device_id=devices.COCKPITMECHANICS, value_down=-1, value_up=0, name = _('Lights Formation Brightnes Down'), category = _('Lights')},

--***************************************** Radio *************************************************************
{combos = {{key = '\\', reformers = {'RAlt'}}}, down = device_commands.RADIO_ICS_Button_UHF1_Pilot, up = device_commands.RADIO_ICS_Button_UHF1_Pilot, cockpit_device_id = devices.ICS, value_down = 1, value_up = 0, name = _('Mic Button UHF1 (ARC-159)'), category = _('Radio')},
{combos = {{key = '\\', reformers = {'RCtrl'}}}, down = device_commands.RADIO_ICS_Button_UHF2_Pilot, up = device_commands.RADIO_ICS_Button_UHF2_Pilot, cockpit_device_id = devices.ICS, value_down = 1, value_up = 0, name = _('Mic Button UHF2 (ARC-182)'), category = _('Radio')},
{combos = {{key = '\\', reformers = {'RShift'}}},down=device_commands.RADIO_ICS_Button_ICS_Pilot, up=device_commands.RADIO_ICS_Button_ICS_Pilot, cockpit_device_id=devices.ICS, value_down=1.0, value_up=0.0, name=_('Mic Button ICS'), category=_('Radio')},

{down = device_commands.RADIO_ICS_Button_UHF1_Pilot_Export_Only, up = device_commands.RADIO_ICS_Button_UHF1_Pilot_Export_Only, cockpit_device_id = devices.ICS, value_down = 1, value_up = 0, name = _('Mic Button UHF1 (ARC-159) - SRS or VoIP Only / No Menu'), category = _('Radio')},
{down = device_commands.RADIO_ICS_Button_UHF2_Pilot_Export_Only, up = device_commands.RADIO_ICS_Button_UHF2_Pilot_Export_Only, cockpit_device_id = devices.ICS, value_down = 1, value_up = 0, name = _('Mic Button UHF2 (ARC-182) - SRS or VoIP Only / No Menu'), category = _('Radio')},
{down=device_commands.RADIO_ICS_Button_ICS_Pilot_Export_Only, up=device_commands.RADIO_ICS_Button_ICS_Pilot_Export_Only, cockpit_device_id=devices.ICS, value_down=1.0, value_up=0.0, name=_('Mic Button ICS - SRS or VoIP Only / No Menu'), category=_('Radio')},
-- ARC-159
{pressed = device_commands.RADIO_UHF_VOL_STEP_Pilot, cockpit_device_id = devices.ARC159, value_pressed = 1.0, value_up = 0, name = _('UHF ARC-159 Volume Pilot Inc'), category = _('Radio')},
{pressed = device_commands.RADIO_UHF_VOL_STEP_Pilot, cockpit_device_id = devices.ARC159, value_pressed = -1.0, value_up = 0, name = _('UHF ARC-159 Volume Pilot Dec'), category = _('Radio')},
{down = device_commands.RADIO_UHF_SQL_TOGGLE_Pilot, cockpit_device_id = devices.ARC159, value_down = 1, value_up = 0, name = _('UHF ARC-159 Squelch Toggle'), category = _('Radio')},
{down = device_commands.RADIO_UHF_SQL_Pilot, cockpit_device_id = devices.ARC159, value_down = 1, name = _('UHF ARC-159 Squelch SQL'), category = _('Radio')},
{down = device_commands.RADIO_UHF_SQL_Pilot, cockpit_device_id = devices.ARC159, value_down = 0, name = _('UHF ARC-159 Squelch OFF'), category = _('Radio')},
{down = device_commands.RADIO_UHF_FREQ_HUNDRED_TEN_Pilot, up = device_commands.RADIO_UHF_FREQ_HUNDRED_TEN_Pilot, cockpit_device_id = devices.ARC159, value_down = 1, value_up = 0, name = _('UHF ARC-159 10 MHz Switch Up'), category = _('Radio')},
{down = device_commands.RADIO_UHF_FREQ_HUNDRED_TEN_Pilot, up = device_commands.RADIO_UHF_FREQ_HUNDRED_TEN_Pilot, cockpit_device_id = devices.ARC159, value_down = -1, value_up = 0, name = _('UHF ARC-159 10 MHz Switch Down'), category = _('Radio')},
{down = device_commands.RADIO_UHF_FREQ_UNIT_Pilot, up = device_commands.RADIO_UHF_FREQ_UNIT_Pilot, cockpit_device_id = devices.ARC159, value_down = 1, value_up = 0, name = _('UHF ARC-159 1 MHz Switch Up'), category = _('Radio')},
{down = device_commands.RADIO_UHF_FREQ_UNIT_Pilot, up = device_commands.RADIO_UHF_FREQ_UNIT_Pilot, cockpit_device_id = devices.ARC159, value_down = -1, value_up = 0, name = _('UHF ARC-159 1 MHz Switch Down'), category = _('Radio')},
{down = device_commands.RADIO_UHF_FREQ_TEHTH_Pilot, up = device_commands.RADIO_UHF_FREQ_TEHTH_Pilot, cockpit_device_id = devices.ARC159, value_down = 1, value_up = 0, name = _('UHF ARC-159 0.1 MHz Switch Up'), category = _('Radio')},
{down = device_commands.RADIO_UHF_FREQ_TEHTH_Pilot, up = device_commands.RADIO_UHF_FREQ_TEHTH_Pilot, cockpit_device_id = devices.ARC159, value_down = -1, value_up = 0, name = _('UHF ARC-159 0.1 MHz Switch Down'), category = _('Radio')},
{down = device_commands.RADIO_UHF_FREQ_HUNDREDTH_Pilot, up = device_commands.RADIO_UHF_FREQ_HUNDREDTH_Pilot, cockpit_device_id = devices.ARC159, value_down = 1, value_up = 0, name = _('UHF ARC-159 0.025 MHz Switch Up'), category = _('Radio')},
{down = device_commands.RADIO_UHF_FREQ_HUNDREDTH_Pilot, up = device_commands.RADIO_UHF_FREQ_HUNDREDTH_Pilot, cockpit_device_id = devices.ARC159, value_down = -1, value_up = 0, name = _('UHF ARC-159 0.025 MHz Switch Down'), category = _('Radio')},
{pressed = device_commands.RADIO_UHF_BRT_STEP_Pilot, cockpit_device_id = devices.ARC159, value_pressed = 1.0, value_up = 0, name = _('UHF ARC-159 BRT Inc'), category = _('Radio')},
{pressed = device_commands.RADIO_UHF_BRT_STEP_Pilot, cockpit_device_id = devices.ARC159, value_pressed = -1.0, value_up = 0, name = _('UHF ARC-159 BRT Dec'), category = _('Radio')},
{pressed = device_commands.RADIO_UHF_Remote_DISP_BRT_STEP_Pilot, cockpit_device_id = devices.ARC159, value_pressed = 1.0, value_up = 0, name = _('UHF ARC-159 Remote BRT Inc'), category = _('Radio')},
{pressed = device_commands.RADIO_UHF_Remote_DISP_BRT_STEP_Pilot, cockpit_device_id = devices.ARC159, value_pressed = -1.0, value_up = 0, name = _('UHF ARC-159 Remote BRT Dec'), category = _('Radio')},
{down = device_commands.RADIO_UHF_Remote_DISP_TEST_Pilot, up = device_commands.RADIO_UHF_Remote_DISP_TEST_Pilot, cockpit_device_id = devices.ARC159, value_down = 1.0, value_up = 0,name = _('UHF ARC-159 Remote TEST'), category = _('Radio')},
{down = device_commands.RADIO_UHF_FUNC_Pilot, cockpit_device_id = devices.ARC159, value_down = 0.0, name = _('UHF ARC-159 Function OFF'), category = _('Radio')},
{down = device_commands.RADIO_UHF_FUNC_Pilot, cockpit_device_id = devices.ARC159, value_down = 1.0/3.0, name = _('UHF ARC-159 Function MAIN'), category = _('Radio')},
{down = device_commands.RADIO_UHF_FUNC_Pilot, cockpit_device_id = devices.ARC159, value_down = 2.0/3.0, name = _('UHF ARC-159 Function BOTH'), category = _('Radio')},
{down = device_commands.RADIO_UHF_FUNC_Pilot, cockpit_device_id = devices.ARC159, value_down = 1.0, name = _('UHF ARC-159 Function ADF'), category = _('Radio')},
{down = device_commands.RADIO_UHF_FUNC_STEP_Pilot, cockpit_device_id = devices.ARC159, value_down = 1, value_up = 0, name = _('UHF ARC-159 Function Inc'), category = _('Radio')},
{down = device_commands.RADIO_UHF_FUNC_STEP_Pilot, cockpit_device_id = devices.ARC159, value_down = -1, value_up = 0, name = _('UHF ARC-159 Function Dec'), category = _('Radio')},
{down = device_commands.RADIO_UHF_FREQ_MODE_Pilot, cockpit_device_id = devices.ARC159, value_down = 1.0, name = _('UHF ARC-159 Mode GUARD'), category = _('Radio')},
{down = device_commands.RADIO_UHF_FREQ_MODE_Pilot, cockpit_device_id = devices.ARC159, value_down = 0.5, name = _('UHF ARC-159 Mode MANUAL'), category = _('Radio')},
{down = device_commands.RADIO_UHF_FREQ_MODE_Pilot, cockpit_device_id = devices.ARC159, value_down = 0.0, name = _('UHF ARC-159 Mode PRESET'), category = _('Radio')},
{down = device_commands.RADIO_UHF_READ_Pilot, up = device_commands.RADIO_UHF_READ_Pilot, cockpit_device_id = devices.ARC159, value_down = 1.0, value_up = 0,name = _('UHF ARC-159 READ'), category = _('Radio')},
{down = device_commands.RADIO_UHF_LOAD_Pilot, cockpit_device_id = devices.ARC159, value_down = 1.0, value_up = 0,name = _('UHF ARC-159 LOAD'), category = _('Radio')},
{down = device_commands.RADIO_UHF_TONE_Pilot, up = device_commands.RADIO_UHF_TONE_Pilot, cockpit_device_id = devices.ARC159, value_down = 1.0, value_up = 0,name = _('UHF ARC-159 TONE'), category = _('Radio')},
{down = device_commands.RADIO_UHF_FREQ_MODE_STEP_Pilot, cockpit_device_id = devices.ARC159, value_down = 1, value_up = 0, name = _('UHF ARC-159 Mode Inc'), category = _('Radio')},
{down = device_commands.RADIO_UHF_FREQ_MODE_STEP_Pilot, cockpit_device_id = devices.ARC159, value_down = -1, value_up = 0, name = _('UHF ARC-159 Mode Dec'), category = _('Radio')},
{down = device_commands.RADIO_UHF_CHAN_STEP_Pilot, cockpit_device_id = devices.ARC159, value_down = 1, value_up = 0, name = _('UHF ARC-159 CHAN SEL Inc'), category = _('Radio')},
{down = device_commands.RADIO_UHF_CHAN_STEP_Pilot, cockpit_device_id = devices.ARC159, value_down = -1, value_up = 0, name = _('UHF ARC-159 CHAN SEL Dec'), category = _('Radio')},

-- ARC-182
{pressed = device_commands.RADIO_VHF_VOL_STEP_PILOT, cockpit_device_id = devices.ARC182, value_pressed = 1.0, value_up = 0, name = _('VHF/UHF ARC-182 Volume Pilot Inc'), category = _('Radio')},
{pressed = device_commands.RADIO_VHF_VOL_STEP_PILOT, cockpit_device_id = devices.ARC182, value_pressed = -1.0, value_up = 0, name = _('VHF/UHF ARC-182 Volume Pilot Dec'), category = _('Radio')},
{pressed = device_commands.RADIO_VHF_Remote_DISP_BRT_STEP_Pilot, cockpit_device_id = devices.ARC182, value_pressed = 1.0, value_up = 0, name = _('VHF/UHF ARC-182 Remote BRT Inc'), category = _('Radio')},
{pressed = device_commands.RADIO_VHF_Remote_DISP_BRT_STEP_Pilot, cockpit_device_id = devices.ARC182, value_pressed = -1.0, value_up = 0, name = _('VHF/UHF ARC-182 Remote BRT Dec'), category = _('Radio')},
{down = device_commands.RADIO_VHF_Remote_DISP_TEST_Pilot, up = device_commands.RADIO_VHF_Remote_DISP_TEST_Pilot, cockpit_device_id = devices.ARC182, value_down = 1.0, value_up = 0,name = _('VHF/UHF ARC-182 Remote TEST'), category = _('Radio')},

-- ICS
{pressed = device_commands.RADIO_ICS_Vol_Step_Pilot, cockpit_device_id = devices.ICS, value_pressed = 1.0, value_up = 0, name = _('ICS Volume Inc'), category = _('Radio')},
{pressed = device_commands.RADIO_ICS_Vol_Step_Pilot, cockpit_device_id = devices.ICS, value_pressed = -1.0, value_up = 0, name = _('ICS Volume Dec'), category = _('Radio')},
{down = device_commands.RADIO_ICS_Ampl_Pilot, cockpit_device_id = devices.ICS, value_down = 0, name = _('ICS Amplifier B/U'), category = _('Radio')},
{down = device_commands.RADIO_ICS_Ampl_Pilot, cockpit_device_id = devices.ICS, value_down = 0.5, name = _('ICS Amplifier NORM'), category = _('Radio')},
{down = device_commands.RADIO_ICS_Ampl_Pilot, cockpit_device_id = devices.ICS, value_down = 1, name = _('ICS Amplifier EMER'), category = _('Radio')},
{down = device_commands.RADIO_ICS_Func_Pilot, cockpit_device_id = devices.ICS, value_down = -1, name = _('ICS Function COLD MIC'), category = _('Radio')},
{down = device_commands.RADIO_ICS_Func_Pilot, cockpit_device_id = devices.ICS, value_down = 0, name = _('ICS Function HOT MIC'), category = _('Radio')},
{down = device_commands.RADIO_ICS_Func_Pilot, cockpit_device_id = devices.ICS, value_down = 1, name = _('ICS Function RADIO OVERRIDE'), category = _('Radio')},

-- TONE
--{pressed = device_commands.RADIO_ICS_Vol_Step_ALR45, cockpit_device_id = devices.ICS, value_pressed = 1.0, value_up = 0, name = _('ALR-45 Volume Inc'), category = _('Radio')},
--{pressed = device_commands.RADIO_ICS_Vol_Step_ALR45, cockpit_device_id = devices.ICS, value_pressed = -1.0, value_up = 0, name = _('ALR-45 Volume Dec'), category = _('Radio')},
--{pressed = device_commands.RADIO_ICS_Vol_Step_ALR50, cockpit_device_id = devices.ICS, value_pressed = 1.0, value_up = 0, name = _('ALR-50 Volume Inc'), category = _('Radio')},
--{pressed = device_commands.RADIO_ICS_Vol_Step_ALR50, cockpit_device_id = devices.ICS, value_pressed = -1.0, value_up = 0, name = _('ALR-50 Volume Dec'), category = _('Radio')},
{pressed = device_commands.RADIO_ICS_Vol_Step_ALR67_Pilot, cockpit_device_id = devices.ICS, value_pressed = 1.0, value_up = 0, name = _('ALR-67 Volume Inc'), category = _('Radio')},
{pressed = device_commands.RADIO_ICS_Vol_Step_ALR67_Pilot, cockpit_device_id = devices.ICS, value_pressed = -1.0, value_up = 0, name = _('ALR-67 Volume Dec'), category = _('Radio')},
{pressed = device_commands.RADIO_ICS_Vol_Step_Sidewinder, cockpit_device_id = devices.ICS, value_pressed = 1.0, value_up = 0, name = _('Sidewinder Volume Inc'), category = _('Radio')},
{pressed = device_commands.RADIO_ICS_Vol_Step_Sidewinder, cockpit_device_id = devices.ICS, value_pressed = -1.0, value_up = 0, name = _('Sidewinder Volume Dec'), category = _('Radio')},

-- TACAN
{down = device_commands.TACAN_Knob_Func_Pilot, cockpit_device_id = devices.TACAN, value_down = 0.0/4.0, name = _('TACAN Function OFF'), category = _('TACAN')},
{down = device_commands.TACAN_Knob_Func_Pilot, cockpit_device_id = devices.TACAN, value_down = 1.0/4.0, name = _('TACAN Function REC'), category = _('TACAN')},
{down = device_commands.TACAN_Knob_Func_Pilot, cockpit_device_id = devices.TACAN, value_down = 2.0/4.0, name = _('TACAN Function T/R'), category = _('TACAN')},
{down = device_commands.TACAN_Knob_Func_Pilot, cockpit_device_id = devices.TACAN, value_down = 3.0/4.0, name = _('TACAN Function A/A'), category = _('TACAN')},
{down = device_commands.TACAN_Knob_Func_Pilot, cockpit_device_id = devices.TACAN, value_down = 4.0/4.0, name = _('TACAN Function BCN'), category = _('TACAN')},
{down = device_commands.TACAN_Knob_Func_STEP_Pilot, cockpit_device_id = devices.TACAN, value_down = 1, value_up = 0, name = _('TACAN Function Inc'), category = _('TACAN')},
{down = device_commands.TACAN_Knob_Func_STEP_Pilot, cockpit_device_id = devices.TACAN, value_down = -1, value_up = 0, name = _('TACAN Function Dec'), category = _('TACAN')},
{down = device_commands.TACAN_Knob_Chnl_Tens_Step_Pilot, cockpit_device_id = devices.TACAN, value_down = 1, value_up = 0, name = _('TACAN Channel 10 Inc'), category = _('TACAN')},
{down = device_commands.TACAN_Knob_Chnl_Tens_Step_Pilot, cockpit_device_id = devices.TACAN, value_down = -1, value_up = 0, name = _('TACAN Channel 10 Dec'), category = _('TACAN')},
{down = device_commands.TACAN_Knob_Chnl_Ones_Step_Pilot, cockpit_device_id = devices.TACAN, value_down = 1, value_up = 0, name = _('TACAN Channel 1 Inc'), category = _('TACAN')},
{down = device_commands.TACAN_Knob_Chnl_Ones_Step_Pilot, cockpit_device_id = devices.TACAN, value_down = -1, value_up = 0, name = _('TACAN Channel 1 Dec'), category = _('TACAN')},
{down = device_commands.TACAN_Mode_X_Y_Pilot, cockpit_device_id = devices.TACAN, value_down = -1, name = _('TACAN MODE X'), category = _('TACAN')},
{down = device_commands.TACAN_Mode_X_Y_Pilot, cockpit_device_id = devices.TACAN, value_down = 1, name = _('TACAN MODE Y'), category = _('TACAN')},
{down = device_commands.TACAN_Mode_X_Y_TOGGLE_Pilot, cockpit_device_id = devices.TACAN, value_down = 1, value_up = 0, name = _('TACAN MODE X/Y Toggle'), category = _('TACAN')},
{down = device_commands.TACAN_Btn_BIT_Pilot, up = device_commands.TACAN_Btn_BIT_Pilot, cockpit_device_id = devices.TACAN, value_down = 1, value_up = 0, name = _('TACAN BIT Button'), category = _('TACAN')},
{down = device_commands.TACAN_CMD_Btn_Pilot, up = device_commands.TACAN_CMD_Btn_Pilot, cockpit_device_id = devices.TACAN, value_down = 1, value_up = 0, name = _('TACAN CMD Button'), category = _('TACAN')},
{pressed = device_commands.TACAN_Knob_Vol_STEP_Pilot, cockpit_device_id = devices.TACAN, value_pressed = 1.0, value_up = 0, name = _('TACAN Volume Inc'), category = _('TACAN')},
{pressed = device_commands.TACAN_Knob_Vol_STEP_Pilot, cockpit_device_id = devices.TACAN, value_pressed = -1.0, value_up = 0, name = _('TACAN Volume Dec'), category = _('TACAN')},

-- ILS
{down = device_commands.ARA63_Power_Switch, cockpit_device_id = devices.ILS, value_down = 1, name = _('ILS Power ON'), category = _('ILS')},
{down = device_commands.ARA63_Power_Switch, cockpit_device_id = devices.ILS, value_down = 0, name = _('ILS Power OFF'), category = _('ILS')},
{down = device_commands.ARA63_Power_Switch_Toggle, cockpit_device_id = devices.ILS, value_down = 1, value_up = 0, name = _('ILS Power Toggle'), category = _('ILS')},
{down = device_commands.ARA63_BIT_Btn, up = device_commands.ARA63_BIT_Btn, cockpit_device_id = devices.ILS, value_down = 1, value_up = 0, name = _('ILS BIT pushbutton'), category = _('ILS')},
{down = device_commands.ARA63_Chnl_Knob_Step, cockpit_device_id = devices.ILS, value_down = 1, value_up = 0, name = _('ILS Channel Inc'), category = _('ILS')},
{down = device_commands.ARA63_Chnl_Knob_Step, cockpit_device_id = devices.ILS, value_down = -1, value_up = 0, name = _('ILS Channel Dec'), category = _('ILS')},

-- COMPASS / AHRS
{down = device_commands.AHRS_HDG_PushButton, up = device_commands.AHRS_HDG_PushButton, cockpit_device_id = devices.AHRS, value_down = 1, value_up = 0, name = _('Compas HDG pushbutton'), category = _('Compass')},
{down = device_commands.AHRS_ModeSwitch, cockpit_device_id = devices.AHRS, value_down = 1.0, name = _('Compass Mode DG'), category = _('Compass')},
{down = device_commands.AHRS_ModeSwitch, cockpit_device_id = devices.AHRS, value_down = 0.0, name = _('Compass Mode SLAVED'), category = _('Compass')},
{down = device_commands.AHRS_ModeSwitch, cockpit_device_id = devices.AHRS, value_down = -1.0, name = _('Compass Mode COMP'), category = _('Compass')},
{down = device_commands.AHRS_ModeSwitch_STEP, cockpit_device_id = devices.AHRS, value_down = 1, value_up = 0, name = _('Compass Mode Inc'), category = _('Compass')},
{down = device_commands.AHRS_ModeSwitch_STEP, cockpit_device_id = devices.AHRS, value_down = -1, value_up = 0, name = _('Compass Mode Dec'), category = _('Compass')},
{down = device_commands.AHRS_NorthSouth_TOGGLE, cockpit_device_id = devices.AHRS, value_down = 1, value_up = 0, name = _('Compass N-S Hemisphere Switch Toggle'), category = _('Compass')},
{down = device_commands.AHRS_NorthSouth, cockpit_device_id = devices.AHRS, value_down = 1, name = _('Compass N-S Hemisphere Switch: South'), category = _('Compass')},
{down = device_commands.AHRS_NorthSouth, cockpit_device_id = devices.AHRS, value_down = -1, name = _('Compass N-S Hemisphere Switch: North'), category = _('Compass')},
{pressed = device_commands.AHRS_LatCorrection_STEP, cockpit_device_id = devices.AHRS, value_pressed = 1.0, value_up = 0, name = _('Compass LAT Correction Inc'), category = _('Compass')},
{pressed = device_commands.AHRS_LatCorrection_STEP, cockpit_device_id = devices.AHRS, value_pressed = -1.0, value_up = 0, name = _('Compass LAT Correction Dec'), category = _('Compass')},

-- Pilot Instruments
{pressed = device_commands.RADARALT_Knob_step, cockpit_device_id=devices.RADARALTIMETER, value_pressed = 0.03, value_up = 0, name = _('Radar Altimeter Control Knob +'), category = _('Instruments')},
{pressed = device_commands.RADARALT_Knob_step, cockpit_device_id=devices.RADARALTIMETER, value_pressed = -0.03, value_up = 0, name = _('Radar Altimeter Control Knob -'), category = _('Instruments')},
{down = device_commands.RADARALT_Test, up = device_commands.RADARALT_Test, cockpit_device_id=devices.RADARALTIMETER, value_down = 1, value_up = 0, name = _('Radar Altimeter Test'), category = _('Instruments')},
--
{down = device_commands.TID_VideoExportToggle, cockpit_device_id = devices.TID, value_down = 1, name = _('Video Export Toggle'), category = _('Other')},
-- end of key command
})

return res
