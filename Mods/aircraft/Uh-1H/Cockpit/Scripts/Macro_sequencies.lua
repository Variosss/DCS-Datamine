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

alert_messages = {}
alert_messages[COLLECTIVE] 	= { message = _("SET THE COLLECTIVE STICK DOWN"), message_timeout = 10}
alert_messages[NO_FUEL] 	= { message = _("CHECK FUEL QUANTITY"), message_timeout = 10}
alert_messages[BATTERY_LOW] = { message = _("CHECK THE BATTERY"), message_timeout = 10}

push_start_command(2.0,{message = _("AUTOSTART SEQUENCE IS RUNNING"),message_timeout = std_message_timeout})

--RESET ENGINE START SW
push_start_command(0.1,{device = devices.ENGINE_INTERFACE,action = device_commands.Button_12,value = 0.0})
--push_start_command(delta_t_com,{action = 97,value = 1.0,message = _("RESET CONTROLS TO NULL"),message_timeout = std_message_timeout})

for i = 0.0, 4.0, 0.1 do
	--push_start_command(0.1,{action = 632})
end

--RESET CIRCUIT BREAKERS
for i = cb_start_cmd, cb_end_cmd, 1 do
	push_start_command(0.1,{device = devices.ELEC_INTERFACE, action = i, value  = 1.0})
end

--[[
AC Voltmeter Selector
--]]
push_start_command(delta_t_com,{device = devices.ELEC_INTERFACE,action = device_commands.Button_7,value = 0.1,
message = _("AC VOLTMETER - AC PHASE"),message_timeout = std_message_timeout})
--[[
Inverter
--]]
push_start_command(delta_t_com,{device = devices.ELEC_INTERFACE,action = device_commands.Button_8,value = 0.0,
message = _("INVERTER - OFF"),message_timeout = std_message_timeout})
--[[
Main generator switch cover
--]]
push_start_command(delta_t_com,{device = devices.ELEC_INTERFACE,action = device_commands.Button_19,value = 1.0,
message_timeout = std_message_timeout})
--[[
Main generator (Left button - ON/OFF. Right button RESET)
--]]
push_start_command(delta_t_com,{device = devices.ELEC_INTERFACE,action = device_commands.Button_2,value = -1.0,
message = _("MAIN GENERATOR - ON"),message_timeout = std_message_timeout})
push_start_command(0.5,{device = devices.ELEC_INTERFACE,action = device_commands.Button_19,value = 0.0})
--[[
DC Voltmeter Selector
--]]
push_start_command(delta_t_com,{device = devices.ELEC_INTERFACE,action = device_commands.Button_4,value = 0.3,
message = _("DC VOLTMETER - ESS BUS"),message_timeout = std_message_timeout})
--[[
Starter/Stdby GEN
--]]
push_start_command(delta_t_com,{device = devices.ELEC_INTERFACE,action = device_commands.Button_3,value = 1.0,
message = _("STARTER-GENERATOR - STARTER"),message_timeout = std_message_timeout})
--[[
Battery
--]]
push_start_command(delta_t_com,{device = devices.ELEC_INTERFACE,action = device_commands.Button_1,value = 0.0,
message = _("BATTERY - ON"),message_timeout = std_message_timeout})
push_start_command(0.1,{device = devices.ENGINE_INTERFACE,action = device_commands.Button_21,value = 0.0})
--[[
Rocket Pair
--]]
push_start_command(delta_t_com,{device = devices.WEAPON_SYS,action = device_commands.Button_11,value = 0.0,
message = _("ROCKET PAIRS - 0"),message_timeout = std_message_timeout})
--[[
Armed/Safe/Off
--]]
push_start_command(delta_t_com,{device = devices.WEAPON_SYS,action = device_commands.Button_8,value = -1.0,
message = _("MASTER ARM - OFF"),message_timeout = std_message_timeout})
--[[
Jetisson Cover
--]]
push_start_command(delta_t_com,{device = devices.WEAPON_SYS,action = device_commands.Button_13,value = -1.0,
message = _("JETTISON COVER - DOWN"),message_timeout = std_message_timeout})
--[[
Governor Emer/Auto
--]]
push_start_command(delta_t_com,{device = devices.ENGINE_INTERFACE,action = device_commands.Button_14,value = 1.0,
message = _("GOVERNOR - AUTO"),message_timeout = std_message_timeout})
--[[
De-Ice On/Off
--]]
push_start_command(delta_t_com,{device = devices.ENGINE_INTERFACE,action = device_commands.Button_2,value = 0.0,
message = _("DE-ICE - OFF"),message_timeout = std_message_timeout})
--[[
Main Fuel
--]]
push_start_command(delta_t_com,{device = devices.FUELSYS_INTERFACE,action = device_commands.Button_1,value = 1.0,
message = _("MAIN FUEL - ON"),message_timeout = std_message_timeout})
--[[
Reset/Test switch
--]]
push_start_command(delta_t_com,{device = devices.SYS_CONTROLLER,action = device_commands.Button_1,value = -1.0,
message = _("CAUTION PANEL LIGHTS TEST"),message_timeout = std_message_timeout})
push_start_command(delta_t_com,{device = devices.SYS_CONTROLLER,action = device_commands.Button_1,value = 0.0})
--[[
Hydro Control
--]]
push_start_command(delta_t_com,{device = devices.HYDRO_SYS_INTERFACE,action = device_commands.Button_3,value = 1.0,
message = _("HYDRAULIC CONTROL - ON"),message_timeout = std_message_timeout})
--[[
Force Trim
--]]
push_start_command(delta_t_com,{device = devices.HYDRO_SYS_INTERFACE,action = device_commands.Button_4,value = 1.0,
message = _("FORCE TRIM - ON"),message_timeout = std_message_timeout})
--[[
Chip Detector
--]]
push_start_command(delta_t_com,{device = devices.ENGINE_INTERFACE,action = device_commands.Button_13,value = 0.0,
message = _("CHIP DETECTOR - BOTH"),message_timeout = std_message_timeout})


push_start_command(2.0,{message = _("THROTTLE - SET TO START"),message_timeout = std_message_timeout})

for i = 0.0, 20.0, 0.1 do
	push_start_command(0.05,{device = devices.ENGINE_INTERFACE,action = device_commands.Button_24,value = 0.0})
end
--[[
Engine Start
--]]
push_start_command(delta_t_com,{device = devices.ENGINE_INTERFACE,action = device_commands.Button_12,value = 1.0,
message = _("ENGINE START"),message_timeout = std_message_timeout})
push_start_command(40.0,{device = devices.ENGINE_INTERFACE,action = device_commands.Button_12,value = 0.0})
--[[
Inverter
--]]
push_start_command(delta_t_com,{device = devices.ELEC_INTERFACE,action = device_commands.Button_8,value = -1.0,
message = _("INVERTER MAIN - ON"),message_timeout = std_message_timeout})
--[[
Starter/Stdby GEN
--]]
push_start_command(delta_t_com,{device = devices.ELEC_INTERFACE,action = device_commands.Button_3,value = 0.0,
message = _("STARTER-GENERATOR - GENERATOR"),message_timeout = std_message_timeout})

push_start_command(2.0,{message = _("THROTTLE - SET TO FULL"),message_timeout = std_message_timeout})

for i = 0.0, 20.0, 0.1 do
	push_start_command(0.05,{device = devices.ENGINE_INTERFACE,action = device_commands.Button_25,value = 0.5})
end

push_start_command(delta_t_com,{device = devices.CPT_MECH,action = device_commands.Button_7,value = 0.0, message= _("CLOSING COCKPIT DOORS"),message_timeout = std_message_timeout})

push_start_command(delta_t_com,{device = devices.IFF,action = device_commands.Button_8,value = 0.1, message= _("IFF STBY"),message_timeout = std_message_timeout})

push_start_command(delta_t_com,{device = devices.RADAR_ALTIMETER, action = device_commands.Button_7,value = 1.0, message= _("RADAR ALTIMETER ON"),message_timeout = std_message_timeout})
push_start_command(delta_t_com,{device = devices.RADAR_ALTIMETER, action = device_commands.Button_2,value = 0.6, message= _("RADAR ALTIMETER LOW ALT"),message_timeout = std_message_timeout})
push_start_command(0,{device = devices.RADAR_ALTIMETER, action = device_commands.Button_2,value = 1.0})
push_start_command(0,{device = devices.RADAR_ALTIMETER, action = device_commands.Button_2,value = 0.8})

push_start_command(delta_t_com,{device = devices.RADAR_ALTIMETER, action = device_commands.Button_3,value = 1.0, message= _("RADAR ALTIMETER HIGH ALT"),message_timeout = std_message_timeout})
push_start_command(0,{device = devices.RADAR_ALTIMETER, action = device_commands.Button_3,value = 1.0})
push_start_command(0,{device = devices.RADAR_ALTIMETER, action = device_commands.Button_3,value = 1.0})
push_start_command(0,{device = devices.RADAR_ALTIMETER, action = device_commands.Button_3,value = 1.0})
push_start_command(0,{device = devices.RADAR_ALTIMETER, action = device_commands.Button_3,value = 1.0})
push_start_command(0,{device = devices.RADAR_ALTIMETER, action = device_commands.Button_3,value = 0.5})



push_start_command(25.0,{message = _("AUTOSTART COMPLETE"),message_timeout = std_message_timeout})

---------------------------------
--- Stop sequence
push_stop_command(2.0,{message = _("AUTOSTOP SEQUENCE IS RUNNING"),message_timeout = std_message_timeout})

--RESET ENGINE START SW
push_stop_command(0.1,{device = devices.ENGINE_INTERFACE,action = device_commands.Button_12,value = 0.0})

--push_stop_command(delta_t_com,{action = 97, value = 1.0, message = _("RESET CONTROLS TO NULL"),message_timeout = std_message_timeout})	
for i = 0.0, 4.0, 0.1 do
	--push_stop_command(0.1,{action = 632})
end

push_stop_command(2.0,{message = _("THROTTLE - SET TO OFF"),message_timeout = std_message_timeout})

push_stop_command(0.1,{device = devices.ENGINE_INTERFACE,action = device_commands.Button_27,value = 1.0})

for i = 0.0, 20.0, 0.1 do
	push_stop_command(0.1,{device = devices.ENGINE_INTERFACE,action = device_commands.Button_25,value = -0.5})
end

push_stop_command(0.1,{device = devices.ENGINE_INTERFACE,action = device_commands.Button_27,value = 0.0})


--[[
Force Trim
--]]
push_stop_command(delta_t_com,{device = devices.HYDRO_SYS_INTERFACE,action = device_commands.Button_4,value = 0.0,
message = _("FORCE TRIM - OFF"),message_timeout = std_message_timeout})
--[[
Starter/Stdby GEN
--]]
push_stop_command(delta_t_com,{device = devices.ELEC_INTERFACE,action = device_commands.Button_3,value = 1.0,
message = _("STARTER-GENERATOR - STARTER"),message_timeout = std_message_timeout})
--[[
Main Fuel
--]]
push_stop_command(delta_t_com,{device = devices.FUELSYS_INTERFACE,action = device_commands.Button_1,value = 0.0,
message = _("MAIN FUEL - OFF"),message_timeout = std_message_timeout})
push_stop_command(0.1,{device = devices.ENGINE_INTERFACE,action = device_commands.Button_21,value = 0.0})
--[[
Inverter
--]]
push_stop_command(delta_t_com,{device = devices.ELEC_INTERFACE,action = device_commands.Button_8,value = 0.0,
message = _("INVERTER - OFF"),message_timeout = std_message_timeout})
--[[
Main generator OFF
--]]
push_stop_command(0.5,{device = devices.ELEC_INTERFACE,action = device_commands.Button_19,value = 1.0})
push_stop_command(delta_t_com,{device = devices.ELEC_INTERFACE,action = device_commands.Button_2,value = 0.0,
message = _("MAIN GENERATOR - OFF"),message_timeout = std_message_timeout})
push_stop_command(0.5,{device = devices.ELEC_INTERFACE,action = device_commands.Button_19,value = 0.0})
--[[
Pitot Heater
--]]
push_stop_command(delta_t_com,{device = devices.ELEC_INTERFACE,action = device_commands.Button_16,value = 0.0,
message = _("PITOT HEATER - OFF"),message_timeout = std_message_timeout})
--[[
Battery
--]]
push_stop_command(delta_t_com,{device = devices.ELEC_INTERFACE,action = device_commands.Button_1,value = 1.0,
message = _("BATTERY - OFF"),message_timeout = std_message_timeout})
--[[
Hydro Control
--]]
push_stop_command(delta_t_com,{device = devices.HYDRO_SYS_INTERFACE,action = device_commands.Button_3,value = 0.0,
message = _("HYDRO CONTROL - OFF"),message_timeout = std_message_timeout})

push_stop_command(delta_t_com,{device = devices.CPT_MECH,action = device_commands.Button_7,value = 1.0, message= _("OPENING COCKPIT DOORS"),message_timeout = std_message_timeout})

push_stop_command(5.0,{message = _("AUTOSTOP COMPLETE"),message_timeout = std_message_timeout})




