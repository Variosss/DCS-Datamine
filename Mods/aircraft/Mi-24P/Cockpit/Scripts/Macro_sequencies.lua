dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."devices.lua")

std_message_timeout = 15

local t_start = 0.0
local t_stop = 0.0
local delta_t_com = 2.0

start_sequence_full = {}
stop_sequence_full = {}

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

NO_FUEL = 1
COLLECTIVE = 2
BATTERY_LOW	= 3
APU_START_FAULT = 4
FUEL_PUMP_FAUL = 5
LEFT_ENGINE_START_FAULT = 6
RIGHT_ENGINE_START_FAULT = 7

alert_messages = {}
alert_messages[COLLECTIVE] = { message = _("SET THE COLLECTIVE STICK DOWN"), message_timeout = 10}
alert_messages[NO_FUEL] = 	 { message = _("CHECK FUEL QUANTITY"), message_timeout = 10}
alert_messages[BATTERY_LOW] = { message = _("POWER SUPPLY FAULT. CHECK THE BATTERY"), message_timeout = 10}
alert_messages[APU_START_FAULT] = { message = _("AI-9 NOT READY TO START ENGINE"), message_timeout = 10}
alert_messages[FUEL_PUMP_FAUL] = { message = _("FEEDING FUEL TANK PUMP FAULT"), message_timeout = 10}
alert_messages[LEFT_ENGINE_START_FAULT] = { message = _("LEFT ENGINE START FAULT"), message_timeout = 10}
alert_messages[RIGHT_ENGINE_START_FAULT] = { message = _("RIGHT ENGINE START FAULT"), message_timeout = 10}

push_start_command(2.0,{message = _("AUTOSTART SEQUENCE IS RUNNING"),message_timeout = std_message_timeout})
push_start_command(1.0,{device = devices.CPT_MECH, action =  cockpit_mechanics_commands.Command_CPT_MECH_GENERAL_DOORS_CLOSE, value = 0.0})

push_start_command(0.1,{device = devices.ENGINE_INTERFACE,action = engine_commands.LEVER_Left_Engine_Lock, value = 0.0, message = _("LEFT ENGINE UNLOCK"),message_timeout = std_message_timeout})
push_start_command(2.0,{device = devices.ENGINE_INTERFACE,action = engine_commands.LEVER_Right_Engine_Lock, value = 0.0, message = _("RIGHT ENGINE UNLOCK"),message_timeout = std_message_timeout})
push_start_command(2.0,{device = devices.ENGINE_INTERFACE,action = engine_commands.LEVER_Rotor_Lock, value = 0.0, message = _("ROTOR BRAKE OFF"),message_timeout = std_message_timeout})

push_start_command(2.0,{action = Keys.iCommand_PlaneAUTDecreaseRegime})
push_start_command(0.1,{action = Keys.iCommand_PlaneAUTDecreaseRegime})
push_start_command(0.1,{action = Keys.iCommand_PlaneAUTIncreaseRegime,		message = _("ENGINES THROTTLES SET TO AUTO"),message_timeout = 10})
push_start_command(1.0,{action = Keys.iCommand_ThrottleDecrease,			message = _("CORRECTION SET TO LEFT"),message_timeout = 10})
push_start_command(1.0,{device = devices.ENGINE_INTERFACE, action = engine_commands.COLLECTIVE, value = -1.0, message = _("COLLECTIVE SET TO FULL DOWN"),message_timeout = 10})
--push_start_command(0.1,{device = devices.ENGINE_INTERFACE, action = engine_commands.Button_70, value = -1.0})
push_start_command(4.0,{action = Keys.iCommand_ThrottleStop})

push_start_command(0.1,{device = devices.ELEC_INTERFACE,action =  elec_commands.BatteryRight, value = 1.0})
push_start_command(0.1,{device = devices.ELEC_INTERFACE,action =  elec_commands.BatteryLeft, value = 1.0})
push_start_command(0.1,{device = devices.ELEC_INTERFACE,action =  elec_commands.DCGangSwitcher, value = 0.22})
push_start_command(0.1,{device = devices.ELEC_INTERFACE,action =  elec_commands.Rotary115vConverterCover, value = 1.0})
push_start_command(0.1,{device = devices.ELEC_INTERFACE,action =  elec_commands.Rotary115vConverter, value = 1.0})
push_start_command(1.0,{device = devices.ELEC_INTERFACE,action =  elec_commands.CB_FRAME_LEFT, value = 1.0})
push_start_command(1.0,{device = devices.ELEC_INTERFACE,action =  elec_commands.CB_FRAME_LEFT, value = 0.0})
push_start_command(1.0,{device = devices.ELEC_INTERFACE,action =  elec_commands.CB_FRAME_RIGHT, value = 1.0})
push_start_command(1.0,{device = devices.ELEC_INTERFACE,action =  elec_commands.CB_FRAME_RIGHT, value = 0.0})
push_start_command(0.1,{device = devices.ELEC_INTERFACE,action =  elec_commands.NetworkToBatteriesCover, value = 1.0})
push_start_command(0.1,{device = devices.ELEC_INTERFACE,action =  elec_commands.NetworkToBatteries, value = 1.0})
--push_start_command(0.1,{device = devices.ELEC_INTERFACE,action =  elec_commands.GroundCheckCover, value = 1.0})
--push_start_command(0.1,{device = devices.ELEC_INTERFACE,action =  elec_commands.GroundCheck, value = 1.0})
-- hydro system
push_start_command(0.1,{device = devices.HYDRO_SYS_INTERFACE,action =  hydraulic_commands.MainHydro, value = 1.0})
--push_start_command(0.1,{device = devices.HYDRO_SYS_INTERFACE,action =  hydraulic_commands.DisableAuxiliaryHydro_EXT, value = 1.0})
push_start_command(1.0,{device = devices.ECS_INTERFACE,action =  ecs_commands.Sealing_valve, value = 0.0, message = _("DOORS SEALED"), message_timeout = std_message_timeout})
push_start_command(1.0,{device = devices.ECS_INTERFACE,action =  ecs_commands.CabinUnseal, value = 1.0})
push_start_command(1.0,{device = devices.ECS_INTERFACE,action =  ecs_commands.BlowdownConditioning, value = 1.0})
--fuel system
push_start_command(0.1,{device = devices.FUELSYS_INTERFACE,action =  fuel_commands.ValveTank1, value = 1.0})
push_start_command(0.1,{device = devices.FUELSYS_INTERFACE,action =  fuel_commands.ValveTank2, value = 1.0})
push_start_command(0.1,{device = devices.FUELSYS_INTERFACE,action =  fuel_commands.ValveLeftEngineCover, value = 1.0})
push_start_command(0.1,{device = devices.FUELSYS_INTERFACE,action =  fuel_commands.ValveRightEngineCover, value = 1.0})
push_start_command(0.1,{device = devices.FUELSYS_INTERFACE,action =  fuel_commands.ValveLeftEngine, value = 1.0})
push_start_command(0.1,{device = devices.FUELSYS_INTERFACE,action =  fuel_commands.ValveRightEngine, value = 1.0})
--push_start_command(0.1,{device = devices.FUELSYS_INTERFACE,action =  fuel_commands.ValveDelimiter, value = 1.0})
push_start_command(0.1,{device = devices.FUELSYS_INTERFACE,action =  fuel_commands.Tank1Pump, value = 1.0})
push_start_command(0.1,{device = devices.FUELSYS_INTERFACE,action =  fuel_commands.Tank2Pump, value = 1.0})
push_start_command(0.1,{device = devices.FUELSYS_INTERFACE,action =  fuel_commands.Tank4Pump, value = 1.0})
push_start_command(0.1,{device = devices.FUELSYS_INTERFACE,action =  fuel_commands.Tank5Pump, value = 1.0})
push_start_command(0.1,{device = devices.FUELSYS_INTERFACE,action =  fuel_commands.ValveLeftEngineCover, value = 0.0})
push_start_command(0.1,{device = devices.FUELSYS_INTERFACE,action =  fuel_commands.ValveRightEngineCover, value = 0.0})

-- ППС:
push_start_command(0.1,{device = devices.FIRE_EXTING_INTERFACE, action =  fire_commands.Power, value = 1.0, message = _("EXTINGUISHING"), message_timeout = std_message_timeout})
push_start_command(1.0,{device = devices.FIRE_EXTING_INTERFACE, action =  fire_commands.SensorControl, value = 1.0})
push_start_command(0.1,{device = devices.FIRE_EXTING_INTERFACE, action =  fire_commands.Pyro1, value = 1.0})
push_start_command(1.0,{device = devices.FIRE_EXTING_INTERFACE, action =  fire_commands.Pyro1, value = 0.0})
push_start_command(0.1,{device = devices.FIRE_EXTING_INTERFACE, action =  fire_commands.Pyro2, value = 1.0})
push_start_command(1.0,{device = devices.FIRE_EXTING_INTERFACE, action =  fire_commands.Pyro2, value = 0.0})

--панель запуска двигателей
push_start_command(0.1,{device = devices.ENGINE_INTERFACE,action =  engine_commands.STARTUP_APU_Launch_Method, value = -1.0, check_condition = FUEL_PUMP_FAUL})
push_start_command(0.1,{device = devices.ENGINE_INTERFACE,action =  engine_commands.STARTUP_APU_StartUp, value = 1.0, message = _("APU START"), message_timeout = std_message_timeout})
push_start_command(1.0,{device = devices.ENGINE_INTERFACE,action =  engine_commands.STARTUP_APU_StartUp, value = 0.0})

push_start_command(25.0,{device = devices.ENGINE_INTERFACE,action =  engine_commands.STARTUP_Engine_Launch_Method, value = 0.0, check_condition = APU_START_FAULT})
push_start_command(0.1,{device = devices.ENGINE_INTERFACE,action =  engine_commands.STARTUP_Engine_Select, value =  1.0, check_condition = COLLECTIVE})
push_start_command(0.1,{device = devices.ENGINE_INTERFACE,action =  engine_commands.STARTUP_Engine_StartUp, value = 1.0, message = _("LEFT ENGINE START"), message_timeout = std_message_timeout})
push_start_command(1.0,{device = devices.ENGINE_INTERFACE,action =  engine_commands.STARTUP_Engine_StartUp, value = 0.0})

push_start_command(55.0,{device = devices.ENGINE_INTERFACE,action =  engine_commands.STARTUP_Engine_Select, value = 0.0, check_condition = LEFT_ENGINE_START_FAULT})
push_start_command(0.1,{device = devices.ENGINE_INTERFACE,action =  engine_commands.STARTUP_Engine_StartUp, value = 1.0, message = _("RIGHT ENGINE START"), message_timeout = std_message_timeout})
push_start_command(1.0,{device = devices.ENGINE_INTERFACE,action =  engine_commands.STARTUP_Engine_StartUp, value = 0.0})

push_start_command(55.0,{action = Keys.iCommand_ThrottleIncrease,message = _("CORRECTION SET TO RIGHT"),message_timeout = 10, check_condition = RIGHT_ENGINE_START_FAULT})
push_start_command(4.0,{action = Keys.iCommand_ThrottleStop})

push_start_command(10.0,{message = _("TURN ON GENERATORS"),message_timeout = std_message_timeout})
push_start_command(0.1,{device = devices.ELEC_INTERFACE,action = elec_commands.ACGeneratorLeft, value = 1.0})
push_start_command(0.1,{device = devices.ELEC_INTERFACE,action = elec_commands.ACGeneratorRight, value = 1.0})
push_start_command(0.1,{device = devices.ELEC_INTERFACE,action =  elec_commands.Transformer115vMainBackup, value = 1.0})
push_start_command(0.1,{device = devices.ELEC_INTERFACE,action =  elec_commands.Transformer36vMainBackup, value = 1.0})
push_start_command(0.1,{device = devices.ELEC_INTERFACE,action = elec_commands.RectifierLeft, value = 1.0, message = _("VU left"), message_timeout = std_message_timeout})
push_start_command(0.1,{device = devices.ELEC_INTERFACE,action = elec_commands.RectifierRight, value = 1.0, message = _("VU right"), message_timeout = std_message_timeout})
push_start_command(0.1,{device = devices.ELEC_INTERFACE,action = elec_commands.ACGangSwitcher, value = 0.5})
--push_start_command(0.1,{device = devices.ELEC_INTERFACE,action =  elec_commands.GroundCheckCover, value = 0.0})
--push_start_command(0.1,{device = devices.ELEC_INTERFACE,action =  elec_commands.GroundCheck, value = 0.0})
push_start_command(0.1,{device = devices.ELEC_INTERFACE,action =  elec_commands.Rotary115vConverterCover, value = 0.0})
push_start_command(0.1,{device = devices.ELEC_INTERFACE,action =  elec_commands.Rotary115vConverter, value = 0.0})

push_start_command(1.0,{device = devices.ENGINE_INTERFACE,action =  engine_commands.STARTUP_APU_Stop, value = 1.0, message = _("APU STOP"), message_timeout = std_message_timeout})

push_start_command(0.1,{device = devices.ELEC_INTERFACE,action =  elec_commands.NetworkToBatteriesCover, value = 0.0})
push_start_command(0.1,{device = devices.ELEC_INTERFACE,action =  elec_commands.NetworkToBatteries, value = 0.0})

--Left Panel
push_start_command(1.0,{device = devices.SPUU_52, action =  spuu_commands.On_Off, value = 1.0, message = _("SPUU-52"), message_timeout = std_message_timeout})
push_start_command(1.0,{device = devices.RADAR_ALTIMETER, action =  ralt_commands.POWER, value = 1.0, message = _("RADAR ALTIMETER"), message_timeout = std_message_timeout})
 
--Right Panel
push_start_command(1.0,{device = devices.DISS_15, action =  diss_commands.POWER, value = 1.0, message = _("DISS-15"), message_timeout = std_message_timeout})
push_start_command(1.0,{device = devices.MGV1SU_1, action =  mgv1su_commands.POWER, value = 1.0, message = _("MGV1-1"), message_timeout = std_message_timeout})
push_start_command(1.0,{device = devices.MGV1SU_2, action =  mgv1su_commands.POWER, value = 1.0, message = _("MGV1-2"), message_timeout = std_message_timeout})
push_start_command(1.0,{device = devices.MGV1SU_1, action =  mgv1su_commands.CAGE, value = 1.0})
push_start_command(1.0,{device = devices.MGV1SU_2, action =  mgv1su_commands.CAGE, value = 1.0})
push_start_command(1.0,{device = devices.GREBEN, action =  greben_commands.POWER, value = 1.0, message = _("GREBEN"), message_timeout = std_message_timeout})
--push_start_command(1.0,{device = devices.KM_2, action =  avKM_2_commands.calc_magn_var, value = 1.0, message = _("set magnetic declination on KM-2"), message_timeout = std_message_timeout})
push_start_command(1.0,{device = devices.SPU_8, action =  SPU_8_Mi24_commands.CMD_SPU8_NETWORK_1, value = 1.0, message = _("SPU-8 NETWORK 1"), message_timeout = std_message_timeout})
push_start_command(1.0,{device = devices.SPU_8, action =  SPU_8_Mi24_commands.CMD_SPU8_NETWORK_2, value = 1.0, message = _("SPU-8 NETWORK 2"), message_timeout = std_message_timeout})
push_start_command(1.0,{device = devices.JADRO_1I, action =  jadro_commands.POWER, value = 1.0, message = _("JADRO-1A"), message_timeout = std_message_timeout})
push_start_command(1.0,{device = devices.EUCALYPT_M24, action =  eucalypt_commands.POWER_ON_OFF2, value = 1.0, message = _("R-828"), message_timeout = std_message_timeout})
push_start_command(1.0,{device = devices.R_863, action =  r863_commands.POWER, value = 1.0, message = _("R-863"), message_timeout = std_message_timeout})
--[[
FLASHER
--]]
push_start_command(1.0,{device = devices.INT_LIGHTS_SYSTEM, action =  int_lights_commands.BlinkerSystem, value = 1.0, message = _("FLASHER"), message_timeout = std_message_timeout})

push_start_command(1.0,{device = devices.GREBEN, action =  greben_commands.SETUP_OPER, value = 1.0})
push_start_command(1.0,{device = devices.GREBEN, action =  greben_commands.MODE, value = 0.0})
push_start_command(1.0,{device = devices.MGV1SU_1, action =  mgv1su_commands.CAGE, value = 0.0})
push_start_command(1.0,{device = devices.MGV1SU_2, action =  mgv1su_commands.CAGE, value = 0.0})

push_start_command(1.0,{device = devices.AUTOPILOT, action =  autopilot_commands.ButtonKon, value = 1.0, message = _("AUTOPILOT ROLL CHANNEL"), message_timeout = std_message_timeout})
push_start_command(1.0,{device = devices.AUTOPILOT, action =  autopilot_commands.ButtonKon, value = 0.0})
push_start_command(1.0,{device = devices.AUTOPILOT, action =  autopilot_commands.ButtonTon, value = 1.0, message = _("AUTOPILOT PITCH CHANNEL"), message_timeout = std_message_timeout})
push_start_command(1.0,{device = devices.AUTOPILOT, action =  autopilot_commands.ButtonTon, value = 0.0})

push_start_command(5.0,{message = _("AUTOSTART COMPLETE"),message_timeout = std_message_timeout})

---------------------------------
--- Stop sequence
push_stop_command(2.0,{message = _("AUTOSTOP SEQUENCE IS RUNNING"),message_timeout = std_message_timeout})

push_stop_command(1.0,{device = devices.INT_LIGHTS_SYSTEM, action =  int_lights_commands.BlinkerSystem, value = 0.0, message = _("FLASHER"), message_timeout = std_message_timeout})
push_stop_command(1.0,{device = devices.SPUU_52, action =  spuu_commands.On_Off, value = 0.0, message = _("SPUU-52"), message_timeout = std_message_timeout})
push_stop_command(1.0,{device = devices.RADAR_ALTIMETER, action =  ralt_commands.POWER, value = 0.0, message = _("RADAR ALTIMETER"), message_timeout = std_message_timeout})
push_stop_command(1.0,{device = devices.DISS_15, action =  diss_commands.POWER, value = 0.0, message = _("DISS-15"), message_timeout = std_message_timeout})
push_stop_command(1.0,{device = devices.MGV1SU_1, action =  mgv1su_commands.POWER, value = 0.0, message = _("MGV1-1"), message_timeout = std_message_timeout})
push_stop_command(1.0,{device = devices.MGV1SU_2, action =  mgv1su_commands.POWER, value = 0.0, message = _("MGV1-2"), message_timeout = std_message_timeout})
push_stop_command(1.0,{device = devices.GREBEN, action =  greben_commands.POWER, value = 0.0, message = _("GREBEN"), message_timeout = std_message_timeout})
push_stop_command(1.0,{device = devices.SPU_8, action =  SPU_8_Mi24_commands.CMD_SPU8_NETWORK_1, value = 0.0, message = _("SPU-8 NETWORK 1"), message_timeout = std_message_timeout})
push_stop_command(1.0,{device = devices.SPU_8, action =  SPU_8_Mi24_commands.CMD_SPU8_NETWORK_2, value = 0.0, message = _("SPU-8 NETWORK 2"), message_timeout = std_message_timeout})
push_stop_command(1.0,{device = devices.JADRO_1I, action =  jadro_commands.POWER, value = 0.0, message = _("JADRO-1A"), message_timeout = std_message_timeout})
push_stop_command(1.0,{device = devices.EUCALYPT_M24, action =  eucalypt_commands.POWER_ON_OFF2, value = 0.0, message = _("R-828"), message_timeout = std_message_timeout})
push_stop_command(1.0,{device = devices.R_863, action =  r863_commands.POWER, value = 0.0, message = _("R-863"), message_timeout = std_message_timeout})

--push_stop_command(0.1,{device = devices.EXT_LIGHTS_SYSTEM,action =  ext_lights_commands.NavLtSwitch, value = 0.0})
--push_stop_command(0.1,{device = devices.EXT_LIGHTS_SYSTEM,action =  ext_lights_commands.FormationLights, value = 0.0})
--push_stop_command(0.1,{device = devices.EXT_LIGHTS_SYSTEM,action =  ext_lights_commands.TipLights, value = 0.0})
--push_stop_command(0.1,{device = devices.EXT_LIGHTS_SYSTEM,action =  ext_lights_commands.StrobeLight, value = 0.0})

push_stop_command(0.1,{device = devices.ELEC_INTERFACE,action = elec_commands.ACGeneratorLeft, value = 0.0, message = _("GENERATORS OFF"), message_timeout = std_message_timeout})
push_stop_command(0.1,{device = devices.ELEC_INTERFACE,action = elec_commands.ACGeneratorRight, value = 0.0})
push_stop_command(0.1,{device = devices.ELEC_INTERFACE,action = elec_commands.Transformer115vMainBackup, value = 0.0})
push_stop_command(0.1,{device = devices.ELEC_INTERFACE,action = elec_commands.Transformer36vMainBackup, value = 0.0})
push_stop_command(0.1,{device = devices.ELEC_INTERFACE,action = elec_commands.RectifierLeft, value = 0.0, message = _("VU left OFF"), message_timeout = std_message_timeout})
push_stop_command(0.1,{device = devices.ELEC_INTERFACE,action = elec_commands.RectifierRight, value = 0.0, message = _("VU right OFF"), message_timeout = std_message_timeout})
push_stop_command(0.1,{device = devices.ELEC_INTERFACE,action = elec_commands.Rotary115vConverter, value = 0.0, message = _("PO-750 NEUTRAL"), message_timeout = std_message_timeout})
push_stop_command(0.1,{device = devices.ELEC_INTERFACE,action = elec_commands.Rotary36vConverter , value = 0.0, message = _("PT-125 NEUTRAL"), message_timeout = std_message_timeout})
push_stop_command(0.1,{device = devices.ELEC_INTERFACE,action = elec_commands.ACGangSwitcher, value = 0.0})

push_stop_command(0.1,{action = Keys.iCommand_ThrottleDecrease,message = _("CORRECTION SET TO LEFT"),message_timeout = 10})
push_stop_command(4.0,{action = Keys.iCommand_ThrottleStop})

push_stop_command(5.0,{device = devices.ENGINE_INTERFACE,action = engine_commands.LEVER_Left_Engine_Lock, value = 1.0, message = _("LEFT ENGINE STOP"),message_timeout = std_message_timeout})
push_stop_command(2.0,{device = devices.ENGINE_INTERFACE,action = engine_commands.LEVER_Right_Engine_Lock, value = 1.0, message = _("RIGHT ENGINE STOP"),message_timeout = std_message_timeout})

push_stop_command(0.1,{device = devices.FUELSYS_INTERFACE,action =  fuel_commands.ValveTank1, value = 0.0})
push_stop_command(0.1,{device = devices.FUELSYS_INTERFACE,action =  fuel_commands.ValveTank2, value = 0.0})
push_stop_command(0.1,{device = devices.FUELSYS_INTERFACE,action =  fuel_commands.ValveLeftEngineCover, value = 1.0})
push_stop_command(0.1,{device = devices.FUELSYS_INTERFACE,action =  fuel_commands.ValveRightEngineCover, value = 1.0})
push_stop_command(0.1,{device = devices.FUELSYS_INTERFACE,action =  fuel_commands.ValveLeftEngine, value = 0.0})
push_stop_command(0.1,{device = devices.FUELSYS_INTERFACE,action =  fuel_commands.ValveRightEngine, value = 0.0})
push_stop_command(0.1,{device = devices.FUELSYS_INTERFACE,action =  fuel_commands.ValveDelimiter, value = 0.0})
push_stop_command(0.1,{device = devices.FUELSYS_INTERFACE,action =  fuel_commands.Tank1Pump, value = 0.0})
push_stop_command(0.1,{device = devices.FUELSYS_INTERFACE,action =  fuel_commands.Tank2Pump, value = 0.0})
push_stop_command(0.1,{device = devices.FUELSYS_INTERFACE,action =  fuel_commands.Tank4Pump, value = 0.0})
push_stop_command(0.1,{device = devices.FUELSYS_INTERFACE,action =  fuel_commands.Tank5Pump, value = 0.0})

for i = elec_commands.CB_LEFT_HOMING_MISSILE_POWER, elec_commands.CB_LEFT_HOMING_MISSILE_POWER+28, 1 do
	push_stop_command(0.1,{device = devices.ELEC_INTERFACE,action =  i, value = 0.0})
end

for i = elec_commands.CB_RIGHT_CONTROL_FORCE_MECHANISM, elec_commands.CB_RIGHT_CONTROL_FORCE_MECHANISM+29, 1 do
	push_stop_command(0.1,{device = devices.ELEC_INTERFACE,action =  i, value = 0.0})
end

push_stop_command(65.0,{device = devices.ENGINE_INTERFACE,action = engine_commands.LEVER_Rotor_Lock, value = 1.0, message = _("ROTOR BRAKE ON"),message_timeout = std_message_timeout})
push_stop_command(1.0,{device = devices.ECS_INTERFACE, action =  ecs_commands.Sealing_valve, value = 1.0})
push_stop_command(1.0,{device = devices.ECS_INTERFACE, action =  ecs_commands.CabinUnseal, value = 1.0})
push_stop_command(0.1,{device = devices.ELEC_INTERFACE,action =  elec_commands.BatteryRight, value = 0.0, message = _("BATTERIES OFF"), message_timeout = std_message_timeout})
push_stop_command(0.1,{device = devices.ELEC_INTERFACE,action =  elec_commands.BatteryLeft, value = 0.0})
push_stop_command(0.1,{device = devices.ELEC_INTERFACE,action =  elec_commands.NetworkToBatteriesCover, value = 0.0})
push_stop_command(0.1,{device = devices.ELEC_INTERFACE,action =  elec_commands.NetworkToBatteries, value = 0.0})
push_stop_command(0.1,{device = devices.ELEC_INTERFACE,action =  elec_commands.DCGangSwitcher, value = 0.0})
push_stop_command(1.0,{device = devices.ELEC_INTERFACE,action =  elec_commands.CB_FRAME_LEFT, value = 0.0})
push_stop_command(1.0,{device = devices.ELEC_INTERFACE,action =  elec_commands.CB_FRAME_RIGHT, value = 0.0})

push_stop_command(1.0,{message = _("AUTOSTOP COMPLETE"),message_timeout = std_message_timeout})
