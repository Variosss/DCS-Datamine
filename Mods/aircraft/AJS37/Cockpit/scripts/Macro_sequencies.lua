dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."devices.lua")

std_message_timeout = 15

local t_start = 0.0
local t_stop = 0.0
local delta_t_com = 2.0

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



----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
-- Start sequence
push_start_command(1.0,	{message = _("AUTOSTART SEQUENCE IS RUNNING"), message_timeout = 115.0})
--

push_start_command(1.0,	{device = devices.ELECTRICSYSTEM,			action = 3001,	value = 0.0, message = _("Main power (HUVUDSTRÖM) OFF")})
push_start_command(1.0,	{device = devices.ENGINEPANEL,				action = 3002,	value = 0.0, message = _("Low-pressure fuel valve (LT-KRAN) OFF")})


push_start_command(1.0,	{device = devices.ELECTRICSYSTEM,			action = 3002,	value = 0.0, message = _("Generator OFF")})
push_start_command(1.0,	{device = devices.ENGINEPANEL,				action = 3004,	value = 0.0, message = _("High-pressure fuel valve (HT-KRAN) OFF")})
push_start_command(1.0,	{device = devices.FLIGHTDATAUNIT,			action = 3101,	value = 1.0, message = _("Master mode BER")})


push_start_command(2.0,	{message = _("Startup"), message_timeout = std_message_timeout})


push_start_command(1.0,	{device = devices.ELECTRICSYSTEM,			action = 3001,	value = 1.0, message = _("Main power (HUVUDSTRÖM) ON")})
push_start_command(1.0,	{device = devices.ENGINEPANEL,				action = 3002,	value = 1.0, message = _("Low-pressure fuel valve (LT-KRAN) ON")})
push_start_command(1.0,	{device = devices.ERRORPANEL,				action = 3001,	value = 1.0, message = _("Cancel Master caution alarm")})
push_start_command(2.0,	{device = devices.LIGHTS,					action = 3008,	value = 1.0, message = _("Instrument lights")})
push_start_command(1.0,	{device = devices.LIGHTS,					action = 3006,	value = 1.0, message = _("Panel lights")})
push_start_command(4.0,	{device = devices.FLIGHTDATAUNIT,			action = 3406,	value = 1.0, message = _("Close Canopy")})

push_start_command(5.0,	{message = _("Engine start"),	message_timeout = std_message_timeout})
push_start_command(1.0,	{device = devices.ELECTRICSYSTEM,			action = 3002,	value = 1.0, message = _("Generator ON")})
push_start_command(1.0,	{device = devices.ENGINEPANEL,				action = 3004,	value = 1.0, message = _("High-pressure fuel valve (HT-KRAN) ON")})
push_start_command(1.0,	{device = devices.ENGINEPANEL,				action = 3001,	value = 1.0, message = _("Engine Start switch ON")})


push_start_command(33.0,	{message = _("Engine started, waiting for systems to power up"),	message_timeout = std_message_timeout})

push_start_command(3.0,	{device = devices.FLIGHTDATAUNIT,				action = 3718,	value = 1.0, message = _("Oxygen / Suit air valve (SYRGAS) ON")})

push_start_command(25.0,	{message = _("LOADING DATA CARTRIDGE"),message_timeout = std_message_timeout})
push_start_command(1.0,	{device = devices.ENGINEPANEL,					action = 3925,	value = 1.0, message = _("Data Cartridge INSERT")})
push_start_command(2.0,	{device = devices.NAVIGATIONPANEL,				action = 3009,	value = 0.5, message = _("Data selector to REF/LOLA")})
push_start_command(2.0,	{device = devices.NAVIGATIONPANEL,				action = 3008,	value = 1.0, message = _("In / Out selector to IN")})
push_start_command(1.0,	{device = devices.NAVIGATION,					action = 3029,	value = 1.0, message = _("9099")})
push_start_command(1.0,	{device = devices.NAVIGATION,					action = 3020,	value = 1.0, message = _("")})
push_start_command(1.0,	{device = devices.NAVIGATION,					action = 3029,	value = 1.0, message = _("")})
push_start_command(1.0,	{device = devices.NAVIGATION,					action = 3029,	value = 1.0, message = _("")})
push_start_command(1.0,	{device = devices.NAVIGATION,					action = 3009,	value = 1.0, message = _("Enter LS")})
push_start_command(10.0,{device = devices.NAVIGATIONPANEL,				action = 3008,	value = 0.0, message = _("In / Out selector to Out")})
push_start_command(1.0,	{device = devices.NAVIGATIONPANEL,				action = 3009,	value = 0.6, message = _("Data selector to AKT/POS")})

push_start_command(1.0, {message = _("DATA CARTRIDGE LOADED"),message_timeout = std_message_timeout})

push_start_command(1.0,	{device = devices.FLIGHTDATAUNIT,					action = 3405,	value = 1.0, message = _("Ejection seat ARM")})
push_start_command(1.0,	{device = devices.FLIGHTDATAUNIT,					action = 3102,	value = 1.0, message = _("Master mode NAV")})
push_start_command(1.0,	{device = devices.FLIGHTDATAUNIT,					action = 3408,	value = 0.0, message = _("Parking brake OFF")})
push_start_command(3.0,	 {message = _("AUTOSTART COMPLETE"),message_timeout = std_message_timeout})
--




----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
-- Stop sequence
push_stop_command(2.0,	{message = _("AUTOSTOP SEQUENCE IS RUNNING"),	message_timeout = 28.0})
push_stop_command(1.0,	{device = devices.FLIGHTDATAUNIT,			action = 3101,	value = 1.0, message = _("Master mode BER")})
push_stop_command(2.0,	{device = devices.FLIGHTDATAUNIT,			action = 3718,	value = 0.0, message = _("Oxygen / Suit air valve (SYRGAS) OFF")})
--
push_stop_command(1.0,	{device = devices.ELECTRICSYSTEM,			action = 3002,	value = 0.0, message = _("Generator OFF")})
push_stop_command(2.0,	{device = devices.LIGHTS,					action = 3008,	value = 0.0, message = _("Instrument lights")})
push_stop_command(1.0,	{device = devices.LIGHTS,					action = 3006,	value = 0.0, message = _("Panel lights")})

push_stop_command(2.0,	{device = devices.ENGINEPANEL,				action = 3004,	value = 1.0, message = _("High-pressure fuel valve (HT-KRAN) OFF")})
push_stop_command(10.0,	{device = devices.ENGINEPANEL,			action = 3002,	value = 0.0, message = _("Low-pressure fuel valve (LT-KRAN) OFF")})
push_stop_command(1.0,	{device = devices.ELECTRICSYSTEM,			action = 3001,	value = 0.0, message = _("Main power (HUVUDSTRÖM) OFF")})
push_stop_command(1.0,	{device = devices.FLIGHTDATAUNIT,			action = 3405,	value = 0.0, message = _("Ejection seat DISARM")})
push_stop_command(5.0,	{device = devices.FLIGHTDATAUNIT,			action = 3406,	value = -1.0, message = _("Open Canopy")})
push_stop_command(1.0,	{device = devices.ENGINEPANEL,					action = 3925,	value = 0.0, message = _("Data Cartridge remove")})

push_stop_command(3.0,	{message = _("AUTOSTOP COMPLETE"),	message_timeout = std_message_timeout})
--