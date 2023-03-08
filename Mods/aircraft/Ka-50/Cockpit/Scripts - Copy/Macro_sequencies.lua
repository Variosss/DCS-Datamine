dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."devices.lua")

local t_start = 0.0
local t_stop = 0.0
local dt = 0.2 -- Default interval between commands in the stack.
local dt_mto = 10.0 -- Default message timeout time.
local start_sequence_time = 2 * 60 + 45 -- Startup time
--local stop_sequence_time = 10.0 -- TODO: timeout

local apu_start_time = 20
local left_engine_start_time = 40
local right_engine_start_time = 50

start_sequence_full = {}
stop_sequence_full = {}
cockpit_illumination_full = {}

function push_command(sequence, run_t, command)
	sequence[#sequence + 1] = command
	sequence[#sequence]["time"] = run_t
end

function push_start_command(delta_t, command)
	t_start = t_start + delta_t
	push_command(start_sequence_full, t_start, command)
end

function push_stop_command(delta_t, command)
	t_stop = t_stop + delta_t
	push_command(stop_sequence_full, t_stop, command)
end

local count = 0
local function counter()
	count = count + 1
	return count
end

-- NOTES:
-- "device = " refers to the device name and index number in devices.lua.
-- "action = " refers to the number of the button in clickabledata.lua plus 3000.  So Button_1 in clickabledata.lua is "action = 3001", Button_2 is "action = 3002", etc.  You can use the key name given in command_defs.lua (for instance "action = Keys.iCommand_VMS_ALMAZ_UP_EmergencyOn"), but there is no easy way to connect a key name to a button number as they aren't explicitly linked in the files as is the case with later modules.
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
push_start_command(0, {message = _("HAVOC'S QUICK AUTOSTART SEQUENCE IS RUNNING (2m45s)"), message_timeout = start_sequence_time})
push_start_command(0, {message = _("MAKE SURE YOUR COLLECTIVE IS FULLY DOWN!"), message_timeout = 30})

push_start_command(dt, {message = _("Cockpit door - Close"), message_timeout = dt_mto})
push_start_command(dt, {action = 71}) -- NOTE: No device, and I'm not sure where the action is defined, but this does work.

push_start_command(dt, {message = _("Voice message system (Betty) - On"), message_timeout = dt_mto})
push_start_command(dt, {device = devices.VMS, action = 3002, value = 1.0})

push_start_command(dt, {message = _("Battery 1 - On"), message_timeout = dt_mto})
push_start_command(dt, {device = devices.ELEC_INTERFACE, action = 3006, value = 0.0}) -- Cover toggle
push_start_command(dt, {device = devices.ELEC_INTERFACE, action = 3005, value = 1.0}) -- Switch
push_start_command(dt, {device = devices.ELEC_INTERFACE, action = 3006, value = 0.0}) -- Cover toggle
push_start_command(dt, {message = _("Battery 2 - On"), message_timeout = dt_mto})
push_start_command(dt, {device = devices.ELEC_INTERFACE, action = 3004, value = 0.0}) -- Cover toggle
push_start_command(dt, {device = devices.ELEC_INTERFACE, action = 3003, value = 1.0}) -- Switch
push_start_command(dt, {device = devices.ELEC_INTERFACE, action = 3004, value = 0.0}) -- Cover toggle

-- ABRIS power, turn on as soon as possible so it finishes booting up by the time we're done.
push_start_command(dt, {message = _("ABRIS power - On"), message_timeout = dt_mto})
push_start_command(dt, {device = devices.ABRIS, action = 3009, value = 1.0})

-- Right wall radio switches:
push_start_command(dt, {message = _("Fuel gauge power - On"), message_timeout = dt_mto})
push_start_command(dt, {device = devices.FUELSYS_INTERFACE, action = 3005, value = 1.0})
push_start_command(dt, {message = _("Intercom (SPU-9) power - On"), message_timeout = dt_mto})
push_start_command(dt, {device = devices.SPU_9, action = 3001, value = 1.0})
push_start_command(dt, {message = _("VHF-1 (R-828) power - On"), message_timeout = dt_mto})
push_start_command(dt, {device = devices.R_828, action = 3005, value = 1.0})
push_start_command(dt, {message = _("VHF-2 (R-800) power - On"), message_timeout = dt_mto})
push_start_command(dt, {device = devices.R_800, action = 3011, value = 1.0})
push_start_command(dt, {message = _("Datalink radio (TLK) power - On"), message_timeout = dt_mto})
push_start_command(dt, {device = devices.DATALINK, action = 3017, value = 1.0})
push_start_command(dt, {message = _("VHF-TLK power - On"), message_timeout = dt_mto})
push_start_command(dt, {device = devices.DATALINK, action = 3018, value = 1.0})
-- NOTE: SA-TLF switch has no function in game.

-- Various avionics systems
push_start_command(dt, {message = _("K-041 targeting-navigation system power - On"), message_timeout = dt_mto}) -- Left console in front of collective
push_start_command(dt, {device = devices.K041, action = 3002, value = 1.0})
push_start_command(dt, {message = _("EKRAN HYD TRANS PWR switch - AUTO BASE"), message_timeout = dt_mto}) -- Right rear wall, black guarded switch
push_start_command(dt, {device = devices.CPT_MECH, action = 3003, value = 1.0}) -- Cover open (starts open on cold start, but force close in case autostart is used again)
push_start_command(dt, {device = devices.CPT_MECH, action = 3002, value = 0.0}) -- Switch
push_start_command(dt, {device = devices.CPT_MECH, action = 3003, value = 0.0}) -- Cover close
push_start_command(dt, {message = _("INU power - On"), message_timeout = dt_mto}) -- Right rear wall
push_start_command(dt, {device = devices.C061K, action = 3001, value = 1.0})
push_start_command(dt, {message = _("UV-26 countermeasures dispenser (CMD) power - On"), message_timeout = dt_mto}) -- Right rear wall, black guarded switch
push_start_command(dt, {device = devices.UV_26, action = 3012, value = 1.0}) -- Cover open
push_start_command(dt, {device = devices.UV_26, action = 3010, value = 1.0}) -- Switch
push_start_command(dt, {device = devices.UV_26, action = 3012, value = 0.0}) -- Cover close
push_start_command(dt, {message = _("L-140 laser warning (LWS) power - On"), message_timeout = dt_mto}) -- Right rear wall
push_start_command(dt, {device = devices.LASER_WARNING_SYSTEM, action = 3002, value = 1.0})
push_start_command(dt, {message = _("SAI power - On"), message_timeout = dt_mto}) -- Right wall
push_start_command(dt, {device = devices.STBY_ADI, action = 3004, value = 1.0})
push_start_command(dt, {message = _("Fire extinguishers - On"), message_timeout = dt_mto}) -- Right wall upper row, black guarded switch
push_start_command(dt, {device = devices.FIRE_EXTING_INTERFACE, action = 3007, value = 1.0}) -- Cover open
push_start_command(dt, {device = devices.FIRE_EXTING_INTERFACE, action = 3006, value = 0.2}) -- Switch
push_start_command(dt, {device = devices.FIRE_EXTING_INTERFACE, action = 3007, value = 0.0}) -- Cover close

push_start_command(dt, {message = _("APU fuel shut-off valve - On"), message_timeout = dt_mto})
push_start_command(dt, {device = devices.FUELSYS_INTERFACE, action = 3011, value = 1.0}) -- Cover toggle
push_start_command(dt, {device = devices.FUELSYS_INTERFACE, action = 3010, value = 1.0}) -- Switch
push_start_command(dt, {message = _("Forward fuel tank pump - On"), message_timeout = dt_mto})
push_start_command(dt, {device = devices.FUELSYS_INTERFACE, action = 3001, value = 1.0})
push_start_command(dt, {message = _("Aft fuel tank pump - On"), message_timeout = dt_mto})
push_start_command(dt, {device = devices.FUELSYS_INTERFACE, action = 3002, value = 1.0})

push_start_command(dt, {message = _("Master Caution Light - Reset"), message_timeout = dt_mto})
push_start_command(dt, {device = devices.SYST_CONTROLLER, action = 3001, value = 0.2}) -- Press
push_start_command(dt, {device = devices.SYST_CONTROLLER, action = 3001, value = 0.0}) -- Release

-- APU start
push_start_command(dt, {message = _("Engine selector switch - APU"), message_timeout = dt_mto})
push_start_command(dt, {device = devices.ENGINE_INTERFACE, action = 3008, value = 0.0})
push_start_command(dt, {message = _("APU - Starting (20s)"), message_timeout = 20})
push_start_command(dt, {device = devices.ENGINE_INTERFACE, action = 3005, value = 1.0}) -- Press
push_start_command(dt, {device = devices.ENGINE_INTERFACE, action = 3005, value = 0.0}) -- Release
push_start_command(20, {message = _("APU started"), message_timeout = dt_mto})

-- Prepare for engine start
push_start_command(dt, {message = _("Rotor brake - Off"), message_timeout = dt_mto})
push_start_command(dt, {device = devices.ENGINE_INTERFACE, action = 3011, value = 0.0})
push_start_command(dt, {message = _("Left engine fuel shut-off switch - On"), message_timeout = dt_mto})
push_start_command(dt, {device = devices.FUELSYS_INTERFACE, action = 3007, value = 0.0}) -- Cover toggle
push_start_command(dt, {device = devices.FUELSYS_INTERFACE, action = 3006, value = 1.0}) -- Switch
push_start_command(dt, {device = devices.FUELSYS_INTERFACE, action = 3007, value = 0.0}) -- Cover toggle
push_start_command(dt, {message = _("Right engine fuel shut-off switch - On"), message_timeout = dt_mto})
push_start_command(dt, {device = devices.FUELSYS_INTERFACE, action = 3009, value = 0.0}) -- Cover toggle
push_start_command(dt, {device = devices.FUELSYS_INTERFACE, action = 3008, value = 1.0}) -- Switch
push_start_command(dt, {device = devices.FUELSYS_INTERFACE, action = 3009, value = 0.0}) -- Cover toggle
push_start_command(dt, {message = _("Left engine EEG - On"), message_timeout = dt_mto})
push_start_command(dt, {device = devices.ENGINE_INTERFACE, action = 3002, value = 1.0}) -- Cover open
push_start_command(dt, {device = devices.ENGINE_INTERFACE, action = 3001, value = 1.0}) -- Switch
push_start_command(dt, {device = devices.ENGINE_INTERFACE, action = 3002, value = 0.0}) -- Cover close
push_start_command(dt, {message = _("Right engine EEG - On"), message_timeout = dt_mto})
push_start_command(dt, {device = devices.ENGINE_INTERFACE, action = 3004, value = 1.0}) -- Cover open
push_start_command(dt, {device = devices.ENGINE_INTERFACE, action = 3003, value = 1.0}) -- Switch
push_start_command(dt, {device = devices.ENGINE_INTERFACE, action = 3004, value = 0.0}) -- Cover close

-- Left engine start
push_start_command(dt, {message = _("Engine selector switch - Left engine"), message_timeout = dt_mto})
push_start_command(dt, {device = devices.ENGINE_INTERFACE, action = 3008, value = 0.1})
push_start_command(dt, {message = _("Left engine - Starting (50s)"), message_timeout = 50})
push_start_command(dt, {device = devices.ENGINE_INTERFACE, action = 3005, value = 1.0}) -- Press
push_start_command(dt, {device = devices.ENGINE_INTERFACE, action = 3005, value = 0.0}) -- Release
push_start_command(15, {message = _("Left engine at 20% RPM: cut-off valve - Open"), message_timeout = dt_mto})
push_start_command(dt, {device = devices.ENGINE_INTERFACE, action = 3009, value = 1.0})
push_start_command(35, {message = _("Left engine - Started"), message_timeout = dt_mto})

-- Right engine start
push_start_command(dt, {message = _("Engine selector switch - Right engine"), message_timeout = dt_mto})
push_start_command(dt, {device = devices.ENGINE_INTERFACE, action = 3008, value = 0.2})
push_start_command(dt, {message = _("Right engine - Starting (50s)"), message_timeout = 50})
push_start_command(dt, {device = devices.ENGINE_INTERFACE, action = 3005, value = 1.0}) -- Press
push_start_command(dt, {device = devices.ENGINE_INTERFACE, action = 3005, value = 0.0}) -- Release
push_start_command(15, {message = _("Right engine at 20% RPM: cut-off valve - Open"), message_timeout = dt_mto})
push_start_command(dt, {device = devices.ENGINE_INTERFACE, action = 3010, value = 1.0})
push_start_command(35, {message = _("Right engine - Started"), message_timeout = dt_mto})

push_start_command(dt, {message = _("APU - Stop"), message_timeout = dt_mto})
push_start_command(dt, {device = devices.ENGINE_INTERFACE, action = 3007, value = 1.0})
push_start_command(dt, {device = devices.ENGINE_INTERFACE, action = 3007, value = 0.0})
push_start_command(dt, {message = _("APU fuel shut-off valve - Off"), message_timeout = dt_mto})
push_start_command(dt, {device = devices.FUELSYS_INTERFACE, action = 3010, value = 0.0}) -- Switch
push_start_command(dt, {device = devices.FUELSYS_INTERFACE, action = 3011, value = 0.0}) -- Cover toggle

push_start_command(dt, {message = _("Left and right throttles - Auto (10s)"), message_timeout = 10})
push_start_command(dt, {action = 66}) -- NOTE: No device, and I'm not sure where the action is defined, but this does work.
push_start_command(dt, {action = 66}) -- Needs two "presses" to get to Auto.
push_start_command(10.0, {message = _("Engines - spooled up"), message_timeout = dt_mto})

push_start_command(dt, {message = _("Left AC generator - On"), message_timeout = dt_mto})
push_start_command(dt, {device = devices.ELEC_INTERFACE, action = 3008, value = 1.0})
push_start_command(dt, {message = _("Right AC generator - On"), message_timeout = dt_mto})
push_start_command(dt, {device = devices.ELEC_INTERFACE, action = 3009, value = 1.0})
push_start_command(dt, {message = _("Engine anti-ice/dust protection - As needed"), message_timeout = dt_mto})
push_start_command(dt, {device = devices.ENGINE_INTERFACE, action = 3014, value = 0.0})

-- PVI and datalink, right console forward
push_start_command(dt, {message = _("PVI NAV master mode knob - On"), message_timeout = dt_mto})
--push_start_command(dt, {device = devices.PVI, action = 3027, value = 0.0}) -- OFF
--push_start_command(dt, {device = devices.PVI, action = 3027, value = 0.1}) -- CHECK
--push_start_command(dt, {device = devices.PVI, action = 3027, value = 0.2}) -- ENT
push_start_command(dt, {device = devices.PVI, action = 3027, value = 0.3}) -- OPER
push_start_command(dt, {message = _("PVI NAV datalink power - On"), message_timeout = dt_mto})
push_start_command(dt, {device = devices.DATALINK, action = 3016, value = 1.0})
push_start_command(dt, {message = _("Datalink master mode knob - WINGM"), message_timeout = dt_mto})
--push_start_command(dt, {device = devices.DATALINK, action = 3015, value = 0.0}) -- OFF
--push_start_command(dt, {device = devices.DATALINK, action = 3015, value = 0.1}) -- REC
push_start_command(dt, {device = devices.DATALINK, action = 3015, value = 0.2}) -- WINGM
--push_start_command(dt, {device = devices.DATALINK, action = 3015, value = 0.3}) -- COM

push_start_command(dt, {message = _("Ejection system - On"), message_timeout = dt_mto})
push_start_command(dt, {device = devices.EJECT_SYS_INTERFACE, action = 3004, value = 1.0}) -- Cover open
push_start_command(dt, {device = devices.EJECT_SYS_INTERFACE, action = 3001, value = 0.0}) -- Switch 1
push_start_command(dt, {device = devices.EJECT_SYS_INTERFACE, action = 3002, value = 0.0}) -- Switch 2
push_start_command(dt, {device = devices.EJECT_SYS_INTERFACE, action = 3003, value = 0.0}) -- Switch 3
push_start_command(dt, {device = devices.EJECT_SYS_INTERFACE, action = 3004, value = 0.0}) -- Cover close

push_start_command(dt, {message = _("Weapons control system power - On"), message_timeout = dt_mto}) -- Right wall lower row, next to ejection system switches
push_start_command(dt, {device = devices.WEAP_INTERFACE, action = 3019, value = 1.0}) -- Cover open
push_start_command(dt, {device = devices.WEAP_INTERFACE, action = 3018, value = 1.0}) -- Switch
push_start_command(dt, {device = devices.WEAP_INTERFACE, action = 3019, value = 0.0}) -- Cover close

-- Lights, uncomment as needed
--push_start_command(dt, {message = _("Anticollision beacon - On"), message_timeout = dt_mto})
--push_start_command(dt, {device = devices.NAVLIGHT_SYSTEM, action = 3003, value = 1.0})
--push_start_command(dt, {message = _("Blade tip lights - On"), message_timeout = dt_mto})
--push_start_command(dt, {device = devices.NAVLIGHT_SYSTEM, action = 3001, value = 1.0})
--push_start_command(dt, {message = _("Formation lights - "), message_timeout = dt_mto})
--push_start_command(dt, {device = devices.NAVLIGHT_SYSTEM, action = 3002, value = 0.0}) -- Off (center switch position)
--push_start_command(dt, {device = devices.NAVLIGHT_SYSTEM, action = 3002, value = 0.1}) -- 10%
--push_start_command(dt, {device = devices.NAVLIGHT_SYSTEM, action = 3002, value = 0.2}) -- 30%
--push_start_command(dt, {device = devices.NAVLIGHT_SYSTEM, action = 3002, value = 0.3}) -- 100%
--push_start_command(dt, {message = _("Nav lights - On"), message_timeout = dt_mto}) -- Front upper canopy frame, left side
--push_start_command(dt, {device = devices.NAVLIGHT_SYSTEM, action = 3004, value = 0.0}) -- Off (center switch position)
--push_start_command(dt, {device = devices.NAVLIGHT_SYSTEM, action = 3004, value = 0.1}) -- 10%
--push_start_command(dt, {device = devices.NAVLIGHT_SYSTEM, action = 3004, value = 0.2}) -- 30%
--push_start_command(dt, {device = devices.NAVLIGHT_SYSTEM, action = 3004, value = 0.3}) -- 100%

-- Autopilot buttons
push_start_command(dt, {message = _("Autopilot bank hold - On"), message_timeout = dt_mto})
push_start_command(dt, {device = devices.AUTOPILOT, action = 3001, value = 1.0})
push_start_command(dt, {device = devices.AUTOPILOT, action = 3001, value = 0.0})
push_start_command(dt, {message = _("Autopilot pitch hold - On"), message_timeout = dt_mto})
push_start_command(dt, {device = devices.AUTOPILOT, action = 3003, value = 1.0})
push_start_command(dt, {device = devices.AUTOPILOT, action = 3003, value = 0.0})
push_start_command(dt, {message = _("Autopilot heading hold - On"), message_timeout = dt_mto})
push_start_command(dt, {device = devices.AUTOPILOT, action = 3002, value = 1.0})
push_start_command(dt, {device = devices.AUTOPILOT, action = 3002, value = 0.0})

push_start_command(dt, {message = _("IFF power - On"), message_timeout = dt_mto})
push_start_command(dt, {device = devices.IFF, action = 3002, value = 1.0}) -- Cover open
push_start_command(dt, {device = devices.IFF, action = 3001, value = 1.0}) -- Switch
push_start_command(dt, {device = devices.IFF, action = 3002, value = 0.0}) -- Cover close
push_start_command(dt, {message = _("SAI - Uncage and center"), message_timeout = dt_mto})
push_start_command(dt, {device = devices.STBY_ADI, action = 3003, value = -0.03})
push_start_command(dt, {device = devices.STBY_ADI, action = 3003, value = -0.03})
push_start_command(dt, {device = devices.STBY_ADI, action = 3003, value = -0.03})
push_start_command(dt, {device = devices.STBY_ADI, action = 3003, value = -0.03})
push_start_command(dt, {device = devices.STBY_ADI, action = 3003, value = -0.03})
push_start_command(dt, {device = devices.STBY_ADI, action = 3003, value = -0.09})
push_start_command(dt, {device = devices.STBY_ADI, action = 3003, value = -0.03})
push_start_command(dt, {device = devices.STBY_ADI, action = 3003, value = 0.03})
push_start_command(dt, {device = devices.STBY_ADI, action = 3003, value = 0.03})
push_start_command(dt, {device = devices.STBY_ADI, action = 3003, value = 0.03})

-- Default startup done, doing post-startup tasks.
push_start_command(dt, {message = _("Laser rangefinder - Arm"), message_timeout = dt_mto})
push_start_command(dt, {device = LASERRANGER, action = 3001, value = 1.0})
push_start_command(dt, {message = _("Master Arm - Arm"), message_timeout = dt_mto})
push_start_command(dt, {device = devices.WEAP_INTERFACE, action = 3001, value = 1.0})
push_start_command(dt, {message = _("Man/Auto weapon - Man"), message_timeout = dt_mto})
push_start_command(dt, {device = devices.WEAP_INTERFACE, action = 3005, value = 1.0})
push_start_command(dt, {message = _("UV-26 Dispenser - Both sides"), message_timeout = dt_mto})
push_start_command(dt, {device = devices.UV_26, action = 3001, value = 0.1}) -- Switch to middle
push_start_command(dt, {message = _("UV-26 Program - Reset (to default program 110)"), message_timeout = dt_mto})
push_start_command(dt, {device = devices.UV_26, action = 3008, value = 1.0}) -- Press
push_start_command(dt, {device = devices.UV_26, action = 3008, value = 0.0}) -- Release
push_start_command(dt, {message = _("UV-26 Num of sequences - 4"), message_timeout = dt_mto})
push_start_command(dt, {device = devices.UV_26, action = 3004, value = 1.0}) -- Press
push_start_command(dt, {device = devices.UV_26, action = 3004, value = 0.0}) -- Release
push_start_command(dt, {device = devices.UV_26, action = 3004, value = 1.0}) -- Press
push_start_command(dt, {device = devices.UV_26, action = 3004, value = 0.0}) -- Release
push_start_command(dt, {device = devices.UV_26, action = 3004, value = 1.0}) -- Press
push_start_command(dt, {device = devices.UV_26, action = 3004, value = 0.0}) -- Release
push_start_command(dt, {message = _("UV-26 Dispense interval - 1 SEC"), message_timeout = dt_mto})
push_start_command(dt, {device = devices.UV_26, action = 3006, value = 1.0}) -- Press
push_start_command(dt, {device = devices.UV_26, action = 3006, value = 0.0}) -- Release
--
push_start_command(dt, {message = _("HAVOC'S AUTOSTART COMPLETE"), message_timeout = 60.0})
push_start_command(dt, {message = _("Manual steps remaining:"), message_timeout = 60})
push_start_command(dt, {message = _("Lights ... As needed"), message_timeout = 60})
push_start_command(dt, {message = _("Radios ... As needed"), message_timeout = 60})
push_start_command(dt, {message = _("Unguided weapon pylon ballistic knob (middle knob on right rear wall) ... As needed (see manual p.169 or Chuck's p.126)"), message_timeout = 60})
push_start_command(dt, {message = _("Baro altitude ... As needed"), message_timeout = 60})



-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
push_stop_command(dt, {message = ("HAVOC'S QUICK AUTOSTOP SEQUENCE IS RUNNING (0m43s)"), message_timeout = 43})

push_stop_command(dt, {message = _("Laser rangefinder - Safe"), message_timeout = dt_mto})
push_stop_command(dt, {device = LASERRANGER, action = 3001, value = 0.0})
push_stop_command(dt, {message = _("Master Arm - Safe"), message_timeout = dt_mto})
push_stop_command(dt, {device = devices.WEAP_INTERFACE, action = 3001, value = 0.0})
push_stop_command(dt, {message = _("Man/Auto weapon - Auto"), message_timeout = dt_mto})
push_stop_command(dt, {device = devices.WEAP_INTERFACE, action = 3005, value = 0.0})

push_stop_command(dt, {message = _("SAI - Cage"), message_timeout = dt_mto})
push_stop_command(dt, {device = devices.STBY_ADI, action = 3002, value = -1.0})
push_stop_command(dt, {device = devices.STBY_ADI, action = 3003, value = 0.09})
push_stop_command(dt, {device = devices.STBY_ADI, action = 3002, value = 0.0})

push_stop_command(dt, {message = _("IFF power - Off"), message_timeout = dt_mto})
push_stop_command(dt, {device = devices.IFF, action = 3002, value = 1.0}) -- Cover open
push_stop_command(dt, {device = devices.IFF, action = 3001, value = 0.0}) -- Switch
push_stop_command(dt, {device = devices.IFF, action = 3002, value = 0.0}) -- Cover close

push_stop_command(dt, {message = _("Weapons control system power - Off"), message_timeout = dt_mto}) -- Right wall lower row, next to ejection system switches
push_stop_command(dt, {device = devices.WEAP_INTERFACE, action = 3019, value = 1.0}) -- Cover open
push_stop_command(dt, {device = devices.WEAP_INTERFACE, action = 3018, value = 0.0}) -- Switch
push_stop_command(dt, {device = devices.WEAP_INTERFACE, action = 3019, value = 0.0}) -- Cover close

push_stop_command(dt, {message = _("Ejection system - Off"), message_timeout = dt_mto})
push_stop_command(dt, {device = devices.EJECT_SYS_INTERFACE, action = 3004, value = 1.0}) -- Cover open
push_stop_command(dt, {device = devices.EJECT_SYS_INTERFACE, action = 3001, value = 1.0}) -- Switch 1
push_stop_command(dt, {device = devices.EJECT_SYS_INTERFACE, action = 3002, value = 1.0}) -- Switch 2
push_stop_command(dt, {device = devices.EJECT_SYS_INTERFACE, action = 3003, value = 1.0}) -- Switch 3
push_stop_command(dt, {device = devices.EJECT_SYS_INTERFACE, action = 3004, value = 0.0}) -- Cover close

push_stop_command(dt, {message = _("Datalink master mode knob - Off"), message_timeout = dt_mto})
push_stop_command(dt, {device = devices.DATALINK, action = 3015, value = 0.0}) -- OFF
push_stop_command(dt, {message = _("PVI NAV datalink power - Off"), message_timeout = dt_mto})
push_stop_command(dt, {device = devices.DATALINK, action = 3016, value = 0.0})
push_stop_command(dt, {message = _("PVI NAV master mode knob - Off"), message_timeout = dt_mto})
push_stop_command(dt, {device = devices.PVI, action = 3027, value = 0.0}) -- OFF

-- Engine shutdown
push_stop_command(dt, {message = _("Left AC generator - Off"), message_timeout = dt_mto})
push_stop_command(dt, {device = devices.ELEC_INTERFACE, action = 3008, value = 0.0})
push_stop_command(dt, {message = _("Right AC generator - Off"), message_timeout = dt_mto})
push_stop_command(dt, {device = devices.ELEC_INTERFACE, action = 3009, value = 0.0})

push_stop_command(dt, {message = _("Left and right throttles - Idle (10s)"), message_timeout = 10})
push_stop_command(dt, {action = 67}) -- NOTE: No device, and I'm not sure where the action is defined, but this does work.
push_stop_command(dt, {action = 67}) -- Needs two "presses" to get to Auto.
push_stop_command(10.0, {message = _("Engines - spooled down"), message_timeout = dt_mto})

push_stop_command(dt, {message = _("Right engine cut-off valve - Close"), message_timeout = dt_mto})
push_stop_command(dt, {device = devices.ENGINE_INTERFACE, action = 3010, value = 0.0})
push_stop_command(dt, {message = _("Right engine EEG - Off"), message_timeout = dt_mto})
push_stop_command(dt, {device = devices.ENGINE_INTERFACE, action = 3004, value = 1.0}) -- Cover open
push_stop_command(dt, {device = devices.ENGINE_INTERFACE, action = 3003, value = 0.0}) -- Switch
push_stop_command(dt, {device = devices.ENGINE_INTERFACE, action = 3004, value = 0.0}) -- Cover close
push_stop_command(dt, {message = _("Right engine fuel shut-off switch - Off"), message_timeout = dt_mto})
push_stop_command(dt, {device = devices.FUELSYS_INTERFACE, action = 3009, value = 0.0}) -- Cover toggle
push_stop_command(dt, {device = devices.FUELSYS_INTERFACE, action = 3008, value = 0.0}) -- Switch
push_stop_command(dt, {device = devices.FUELSYS_INTERFACE, action = 3009, value = 0.0}) -- Cover toggle

push_stop_command(dt, {message = _("Left engine cut-off valve - Close"), message_timeout = dt_mto})
push_stop_command(dt, {device = devices.ENGINE_INTERFACE, action = 3009, value = 0.0})
push_stop_command(dt, {message = _("Left engine EEG - Off"), message_timeout = dt_mto})
push_stop_command(dt, {device = devices.ENGINE_INTERFACE, action = 3002, value = 1.0}) -- Cover open
push_stop_command(dt, {device = devices.ENGINE_INTERFACE, action = 3001, value = 0.0}) -- Switch
push_stop_command(dt, {device = devices.ENGINE_INTERFACE, action = 3002, value = 0.0}) -- Cover close
push_stop_command(dt, {message = _("Left engine fuel shut-off switch - Off"), message_timeout = dt_mto})
push_stop_command(dt, {device = devices.FUELSYS_INTERFACE, action = 3007, value = 0.0}) -- Cover toggle
push_stop_command(dt, {device = devices.FUELSYS_INTERFACE, action = 3006, value = 0.0}) -- Switch
push_stop_command(dt, {device = devices.FUELSYS_INTERFACE, action = 3007, value = 0.0}) -- Cover toggle

push_stop_command(dt, {message = _("Forward fuel tank pump - Off"), message_timeout = dt_mto})
push_stop_command(dt, {device = devices.FUELSYS_INTERFACE, action = 3001, value = 0.0})
push_stop_command(dt, {message = _("Aft fuel tank pump - Off"), message_timeout = dt_mto})
push_stop_command(dt, {device = devices.FUELSYS_INTERFACE, action = 3002, value = 0.0})

push_stop_command(dt, {message = _("K-041 targeting-navigation system power - Off"), message_timeout = dt_mto}) -- Left console in front of collective
push_stop_command(dt, {device = devices.K041, action = 3002, value = 0.0})
push_stop_command(dt, {message = _("EKRAN HYD TRANS PWR switch - Off"), message_timeout = dt_mto}) -- Right rear wall, black guarded switch
push_stop_command(dt, {device = devices.CPT_MECH, action = 3003, value = 1.0}) -- Cover open (starts open on cold start, but force close in case autostart is used again)
push_stop_command(dt, {device = devices.CPT_MECH, action = 3002, value = 1.0}) -- Switch
push_stop_command(dt, {device = devices.CPT_MECH, action = 3003, value = 0.0}) -- Cover close
push_stop_command(dt, {message = _("INU power - Off"), message_timeout = dt_mto}) -- Right rear wall
push_stop_command(dt, {device = devices.C061K, action = 3001, value = 0.0})
push_stop_command(dt, {message = _("UV-26 countermeasures dispenser (CMD) power - Off"), message_timeout = dt_mto}) -- Right rear wall, black guarded switch
push_stop_command(dt, {device = devices.UV_26, action = 3012, value = 1.0}) -- Cover open
push_stop_command(dt, {device = devices.UV_26, action = 3010, value = 0.0}) -- Switch
push_stop_command(dt, {device = devices.UV_26, action = 3012, value = 0.0}) -- Cover close
push_stop_command(dt, {message = _("L-140 laser warning (LWS) power - Off"), message_timeout = dt_mto}) -- Right rear wall
push_stop_command(dt, {device = devices.LASER_WARNING_SYSTEM, action = 3002, value = 0.0})
push_stop_command(dt, {message = _("SAI power - Off"), message_timeout = dt_mto}) -- Right wall
push_stop_command(dt, {device = devices.STBY_ADI, action = 3004, value = 0.0})
push_stop_command(dt, {message = _("Fire extinguishers - Off"), message_timeout = dt_mto}) -- Right wall upper row, black guarded switch
push_stop_command(dt, {device = devices.FIRE_EXTING_INTERFACE, action = 3007, value = 1.0}) -- Cover open
push_stop_command(dt, {device = devices.FIRE_EXTING_INTERFACE, action = 3006, value = 0.1}) -- Switch
push_stop_command(dt, {device = devices.FIRE_EXTING_INTERFACE, action = 3007, value = 0.0}) -- Cover close

-- Right wall radio switches:
push_stop_command(dt, {message = _("Fuel gauge power - Off"), message_timeout = dt_mto})
push_stop_command(dt, {device = devices.FUELSYS_INTERFACE, action = 3005, value = 0.0})
push_stop_command(dt, {message = _("Intercom (SPU-9) power - Off"), message_timeout = dt_mto})
push_stop_command(dt, {device = devices.SPU_9, action = 3001, value = 0.0})
push_stop_command(dt, {message = _("VHF-1 (R-828) power - Off"), message_timeout = dt_mto})
push_stop_command(dt, {device = devices.R_828, action = 3005, value = 0.0})
push_stop_command(dt, {message = _("VHF-2 (R-800) power - Off"), message_timeout = dt_mto})
push_stop_command(dt, {device = devices.R_800, action = 3011, value = 0.0})
push_stop_command(dt, {message = _("Datalink radio (TLK) power - Off"), message_timeout = dt_mto})
push_stop_command(dt, {device = devices.DATALINK, action = 3017, value = 0.0})
push_stop_command(dt, {message = _("VHF-TLK power - Off"), message_timeout = dt_mto})
push_stop_command(dt, {device = devices.DATALINK, action = 3018, value = 0.0})
-- NOTE: SA-TLF switch has no function in game.

-- ABRIS power
push_stop_command(dt, {message = _("ABRIS power - Off"), message_timeout = dt_mto})
push_stop_command(dt, {device = devices.ABRIS, action = 3009, value = 0.0})

push_stop_command(dt, {message = _("Battery 1 - Off"), message_timeout = dt_mto})
push_stop_command(dt, {device = devices.ELEC_INTERFACE, action = 3006, value = 0.0}) -- Cover toggle
push_stop_command(dt, {device = devices.ELEC_INTERFACE, action = 3005, value = 0.0}) -- Switch
push_stop_command(dt, {device = devices.ELEC_INTERFACE, action = 3006, value = 0.0}) -- Cover toggle
push_stop_command(dt, {message = _("Battery 2 - Off"), message_timeout = dt_mto})
push_stop_command(dt, {device = devices.ELEC_INTERFACE, action = 3004, value = 0.0}) -- Cover toggle
push_stop_command(dt, {device = devices.ELEC_INTERFACE, action = 3003, value = 0.0}) -- Switch
push_stop_command(dt, {device = devices.ELEC_INTERFACE, action = 3004, value = 0.0}) -- Cover toggle

push_stop_command(dt, {message = _("Voice message system (Betty) - Off"), message_timeout = dt_mto})
push_stop_command(dt, {device = devices.VMS, action = 3002, value = 0.0})

-- Wait for the rotor speed to decrease
push_stop_command(dt, {message = _("Wait for rotor to slow to 30%"), message_timeout = dt_mto})
push_stop_command(10, {message = _("Rotor at 30%: rotor brake - On"), message_timeout = dt_mto})
push_stop_command(dt, {device = devices.ENGINE_INTERFACE, action = 3011, value = 0.0})

push_stop_command(dt, {message = _("Cockpit door - Open"), message_timeout = dt_mto})
push_stop_command(dt, {action = 71, value  = 0.0}) -- NOTE: No device, and I'm not sure where the action is defined, but this does work.

push_stop_command(dt, {message = ("HAVOC'S QUICK AUTOSTOP COMPLETE"), message_timeout = 60.0})
