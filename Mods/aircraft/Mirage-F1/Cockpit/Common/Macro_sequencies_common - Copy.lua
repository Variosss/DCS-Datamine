
dofile(LockOn_Options.script_path.."../../Common/command_defs.lua")
dofile(LockOn_Options.script_path.."../../Common/devices.lua")

std_message_timeout = 15

local t_start = 0.0
local t_stop = 0.0
local delta_t_com = 2.0

start_sequence_full	= {}
stop_sequence_full	= {}

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



-- conditions to be added if pre auto start conditions are desired ie Thrust lever closed values

count = -1
MIRAGE_F1_AD_COMMON				= counter();
MIRAGE_F1_AD_ENGINE_START_RPM		= counter();
MIRAGE_F1_AD_ENGINE_RPM			= counter();
MIRAGE_F1_AD_THROTTLE_SET_TO_STOP	= counter();
MIRAGE_F1_AD_THROTTLE_SET_TO_IDLE	= counter();
MIRAGE_F1_AD_THROTTLE_AT_STOP		= counter();
MIRAGE_F1_AD_THROTTLE_AT_IDLE		= counter();
MIRAGE_F1_AD_ERROR				= counter();
MIRAGE_F1_AD_GROUND_SUPPLY_ON		= counter();
MIRAGE_F1_AD_GROUND_SUPPLY_OFF	= counter();
MIRAGE_F1_AD_GROUND_SUPPLY_IS_ON	= counter();

--
alert_messages = {}
alert_messages[MIRAGE_F1_AD_COMMON]				= { message = _("MIRAGE F1 ERROR"), message_timeout = 10}
alert_messages[MIRAGE_F1_AD_ENGINE_START_RPM]		= { message = _("ENGINE START RPM FAILURE"), message_timeout = 10}
alert_messages[MIRAGE_F1_AD_ENGINE_RPM]			= { message = _("ENGINE RPM FAILURE"), message_timeout = 10}
alert_messages[MIRAGE_F1_AD_THROTTLE_SET_TO_STOP]	= { message = _("THROTTLE MUST BE AT IDLE"), message_timeout = 10}
alert_messages[MIRAGE_F1_AD_THROTTLE_SET_TO_IDLE]	= { message = _("THROTTLE MUST BE AT IDLE"), message_timeout = 10}
alert_messages[MIRAGE_F1_AD_THROTTLE_AT_STOP]		= { message = _("THROTTLE MUST BE AT STOP"), message_timeout = 10}
alert_messages[MIRAGE_F1_AD_THROTTLE_AT_IDLE]		= { message = _("THROTTLE MUST BE AT IDLE"), message_timeout = 10}
alert_messages[MIRAGE_F1_AD_ERROR]				= { message = _("FM MODEL ERROR"), message_timeout = 10}
alert_messages[MIRAGE_F1_AD_GROUND_SUPPLY_ON]		= { message = _("GROUND SUPPLY ON"), message_timeout = 10}
alert_messages[MIRAGE_F1_AD_GROUND_SUPPLY_OFF]	= { message = _("GROUND SUPPLY OFF"), message_timeout = 10}
alert_messages[MIRAGE_F1_AD_GROUND_SUPPLY_IS_ON]	= { message = _("NO GROUND ELECTRIC POWER"), message_timeout = 10}

----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
-- Start sequence

function startup_stage1()
	push_start_command(0.1,	{message = _("AUTOSTART SEQUENCE IS RUNNING"), message_timeout = std_message_timeout})
	
	push_start_command(0.1,	{device = devices.MAIN,	action = devCmds.Cmd250,	    value = 1.0, message = _("Battery - On")})
	
	push_start_command(0.1,	{device = devices.MAIN,	action = devCmds.Cmd287,	    value = 1.0, message = _("Warning Horn - On")})
	--  Master failure warning light RESET	
	push_start_command(0.1,	{device = devices.MAIN,	action = devCmds.Cmd265,	    value = 1.0})	


	push_start_command(0.1,	{device = devices.MAIN,	action = devCmds.Cmd362,	    value = 1.0, message = _("Oxygen - Check")})

	push_start_command(0.1,	{device = devices.MAIN,	action = devCmds.Cmd143,		value = 1.0, message = _("Master Arm Cover - Open")})
	push_start_command(0.1,	{device = devices.MAIN,	action = devCmds.Cmd144,		value = 0.5, message = _("Master Arm - Armed")})
	push_start_command(0.1,	{device = devices.MAIN,	action = devCmds.Cmd143,		value = 0.0, message = _("Master Arm Cover - Closed")})
	push_start_command(0.1,	{device = devices.MAIN,	action = devCmds.Cmd582,		value = 1.0, message = _("Matra R.550/Sidewinder Switch (MSL COOL) - ON")})
	push_start_command(0.1,	{device = devices.MAIN,	action = devCmds.Cmd140,	    value = 1.0, message = _("Ground Crew Intercom - Selected")})

	--- Cabin lighting rheostats - As required	
	push_start_command(0.1,	{device = devices.MAIN,	action = devCmds.Cmd319,	    value = 0.0})	
	push_start_command(0.0,	{device = devices.MAIN,	action = devCmds.Cmd320,	    value = 0.5})
	push_start_command(0.0,	{device = devices.MAIN,	action = devCmds.Cmd322,	    value = 0.5})
	push_start_command(0.0,	{device = devices.MAIN,	action = devCmds.Cmd324,	    value = 0.5})
	push_start_command(0.0,	{device = devices.MAIN,	action = devCmds.Cmd326,	    value = 0.5})	
	push_start_command(0.0,	{device = devices.MAIN,	action = devCmds.Cmd328,	    value = 0.5})
	push_start_command(0.0,	{device = devices.MAIN,	action = devCmds.Cmd330,	    value = 0.5})
	--- Emergency fuel transfer switch - Off	
	push_start_command(0.0,	{device = devices.MAIN,	action = devCmds.Cmd84,	    value = 0.0})
	--- JPT emergency regulation switch - Off	
	push_start_command(0.0,	{device = devices.MAIN,	action = devCmds.Cmd62,	    value = 0.0})
	--- A/B main cock switch - On (guarded)
	push_start_command(0.0,	{device = devices.MAIN,	action = devCmds.Cmd63,	    value = -0.1})	
	push_start_command(0.0,	{device = devices.MAIN,	action = devCmds.Cmd64,	    value = 0.0})
	--- In-flight relight control - Aft
	push_start_command(0.0,	{device = devices.MAIN,	action = devCmds.Cmd52,	    value = 0.0})
	--- Combat flap lever - In
	push_start_command(0.0,	{device = devices.MAIN,	action = devCmds.Cmd638,	    value = 0.0})	
	--- Anti-skid (SPAD) switch - On (guarded)
	push_start_command(0.0,	{device = devices.MAIN,	action = devCmds.Cmd194,	    value = 0.0})	
	push_start_command(0.0,	{device = devices.MAIN,	action = devCmds.Cmd195,	    value = 0.0})
	--- High-lift device selector switch - Off
	push_start_command(0.0,	{device = devices.MAIN,	action = devCmds.Cmd123,	    value = 0.0})
	--- Ignition/Ventilation selector switch - L/H or R/H	(R/H)
	push_start_command(0.0,	{device = devices.MAIN,	action = devCmds.Cmd53,	    value = 0.0})	
	--- Starting pump switch - Off
	push_start_command(0.0,	{device = devices.MAIN,	action = devCmds.Cmd65,	    value = 0.0})
	--- R/H LP pump switch - Off
	push_start_command(0.0,	{device = devices.MAIN,	action = devCmds.Cmd66,	    value = 0.0})	
	--- L/H LP pump switch - Off	
	push_start_command(0.0,	{device = devices.MAIN,	action = devCmds.Cmd67,	    value = 0.0})
	--- LP main cock switch - Closed (unguarded)
	push_start_command(0.0,	{device = devices.MAIN,	action = devCmds.Cmd56,	    value = 1.1})	
	push_start_command(0.1,	{device = devices.MAIN,	action = devCmds.Cmd57,	    value = 1.0})	
	--- Emergency regulation switch - Off (guarded)
	push_start_command(0.0,	{device = devices.MAIN,	action = devCmds.Cmd167,	    value = -0.1})	
	push_start_command(0.0,	{device = devices.MAIN,	action = devCmds.Cmd168,	    value = 0.0})
	--- Landing light control - Off
	push_start_command(0.0,	{device = devices.MAIN,	action = devCmds.Cmd310,	    value = 0.0})
	--- U/C control lever - Down
	push_start_command(0.0,	{device = devices.MAIN,	action = devCmds.Cmd191,	    value = 1.0})
	--- Yaw/Anti-slip switch - Anti-slip
	push_start_command(0.0,	{device = devices.MAIN,	action = devCmds.Cmd25,	    value = 1.0})	
	--- Pitch switch - On
	push_start_command(0.0,	{device = devices.MAIN,	action = devCmds.Cmd26,	    value = 1.0})
	--- ARTHUR selector switch-Auto (guarded)
	push_start_command(0.0,	{device = devices.MAIN,	action = devCmds.Cmd23,	    value = -0.1})	
	push_start_command(0.0,	{device = devices.MAIN,	action = devCmds.Cmd24,	    value = 0.0})
	--- Stick uncouple switch - Off (guarded)
	push_start_command(0.0,	{device = devices.MAIN,	action = devCmds.Cmd21,	    value = 0.0})	
	push_start_command(0.0,	{device = devices.MAIN,	action = devCmds.Cmd22,	    value = -0.1})
	--- Hydraulic pressure selector switch - 1 SERVOS 2
	push_start_command(0.0,	{device = devices.MAIN,	action = devCmds.Cmd200,	    value = 1.0})
	--- Brake chute control	- Forward
	push_start_command(0.0,	{device = devices.MAIN,	action = devCmds.Cmd171,	    value = 0.0})
	--- Canopy embrittle control - Aft
	push_start_command(0.0,	{device = devices.MAIN,	action = devCmds.Cmd173,	    value = 0.0})
	--- Shock-cone pushbutton - Depressed
	push_start_command(0.0,	{device = devices.MAIN,	action = devCmds.Cmd70,	    value = 1.0})
	--- Nose wheel steering switch - On (guarded)
	push_start_command(0.0,	{device = devices.MAIN,	action = devCmds.Cmd197,	    value = 0.0})
	push_start_command(0.0,	{device = devices.MAIN,	action = devCmds.Cmd198,	    value = 0.0})
	--- Nose wheel steering high sensitivity button	- Depressed
	push_start_command(0.0,	{device = devices.MAIN,	action = devCmds.Cmd196,	    value = 1.0})
	--- Armament control panel:
	--- Select pushbuttons - Released
	push_start_command(0.0,	{device = devices.MAIN,	action = devCmds.Cmd587,	    value = 0.0})
	push_start_command(0.0,	{device = devices.MAIN,	action = devCmds.Cmd588,	    value = 0.0})	
	push_start_command(0.0,	{device = devices.MAIN,	action = devCmds.Cmd589,	    value = 0.0})	
	push_start_command(0.0,	{device = devices.MAIN,	action = devCmds.Cmd590,	    value = 0.0})	
	push_start_command(0.0,	{device = devices.MAIN,	action = devCmds.Cmd591,	    value = 0.0})	
	push_start_command(0.0,	{device = devices.MAIN,	action = devCmds.Cmd592,	    value = 0.0})	
	push_start_command(0.0,	{device = devices.MAIN,	action = devCmds.Cmd593,	    value = 0.0})
	push_start_command(0.0,	{device = devices.MAIN,	action = devCmds.Cmd594,	    value = 0.0})
	--- Instantaneous/Delay/Safe selector switch - Safe
	push_start_command(0.0,	{device = devices.MAIN,	action = devCmds.Cmd586,	    value = 1.0})
	--- Emergency transfer switch - Off
	push_start_command(0.0,	{device = devices.MAIN,	action = devCmds.Cmd84,	    value = 0.0})
	--- Crossfeed switch
	push_start_command(0.0,	{device = devices.MAIN,	action = devCmds.Cmd83,	    value = 0.0})
	--- Emergency U/C handle - In and folder back
	push_start_command(0.0,	{device = devices.MAIN,	action = devCmds.Cmd199,	    value = 0.0})
	--- Alternator 1 and alternator 2 switches - On	
	push_start_command(0.0,	{device = devices.MAIN,	action = devCmds.Cmd251,	    value = 1.0})
	push_start_command(0.0,	{device = devices.MAIN,	action = devCmds.Cmd252,	    value = 1.0})
	--- Inverter selector switch - Auto
	push_start_command(0.0,	{device = devices.MAIN,	action = devCmds.Cmd254,	    value = 0.0})
	--- Canopy seal valve control lever	- Inflate (forward)
	push_start_command(0.0,	{device = devices.MAIN,	action = devCmds.Cmd175,	    value = 0.0})
	--- Ram air switch - Off (guarded)
	push_start_command(0.0,	{device = devices.MAIN,	action = devCmds.Cmd383,	    value = 0.0})
	-- Cabin temperature control rheostat - Auto
	push_start_command(0.0,	{device = devices.MAIN,	action = devCmds.Cmd377,	    value = 0.5})
	--- Emergency cold switch - Off
	push_start_command(0.0,	{device = devices.MAIN,	action = devCmds.Cmd375,	    value = 1.0})
	--- Auto/Manual selector switch - Auto
	push_start_command(0.0,	{device = devices.MAIN,	action = devCmds.Cmd379,	    value = 0.0})
	
	push_start_command(0.1,	{message = _("Cabin checks - Performed")})
	
	push_start_command(0.1,	{message = _("STARTING")})

	----- Starting

	push_start_command(0.1,	{device = devices.MAIN,	action = devCmds.Cmd178,	    value = 0.0, message = _("Canopy - Closed")})
	
	push_start_command(4.0,	{device = devices.MAIN,	action = devCmds.Cmd172,	    value = 0.0, message = _("Canopy lock control - Forward")})	
	
	--- LP main cock switch - Open
	push_start_command(0.1,	{device = devices.MAIN,	action = devCmds.Cmd57,	    value = 0.0, message = _("LP main cock switch - Open")})	
	push_start_command(0.0,	{device = devices.MAIN,	action = devCmds.Cmd56,	    value = -0.1})	

	push_start_command(0.1,	{device = devices.MAIN,	action = devCmds.Cmd67,	    value = 1.0, message = _("L/H LP pump switch - On")})

	push_start_command(0.1,	{device = devices.MAIN,	action = devCmds.Cmd66,	    value = 1.0, message = _("R/H LP pump switch - On")})	

	push_start_command(0.1,	{device = devices.MAIN,	action = devCmds.Cmd53,	    value = 1.0, message = _("Ignition/Ventilation selector switch - To the other plug")})
	
	push_start_command(0.1,	{device = devices.MAIN,	action = devCmds.Cmd54,	    value = 1.1, message = _("Start button cover - Open")})
	
	push_start_command(0.1,	{device = devices.MAIN,	action = devCmds.Cmd55,	    value = 1.0, message = _("Start button - Depress (for 1 sec approx.)")})
	push_start_command(1.2,	{device = devices.MAIN,	action = devCmds.Cmd55,	    value = 0.0})
	
	push_start_command(0.1,	{device = devices.MAIN,	action = devCmds.Cmd54,	    value = -0.1})	
	
	push_start_command(29.0,	{message = _("AFTER START CHECKS")})

	----- After start checks

	push_start_command(0.1,	{device = devices.MAIN,	action = devCmds.Cmd123,	    value = 1.0, message = _("High-lift device selector switch - Normal")})	

	push_start_command(0.1,	{device = devices.MAIN,	action = devCmds.Cmd638,	    value = 0.0, message = _("Combat flap lever - In")})
	
	push_start_command(0.1,	{device = devices.MAIN,	action = devCmds.Cmd459,	    value = 1.0, message = _("UHF radio - On")})
	
	push_start_command(0.1,	{device = devices.MAIN,	action = devCmds.Cmd122,	    value = 1.0, message = _("Slat/Flap lever - Full aft")})

	push_start_command(0.1,	{device = devices.MAIN,	action = devCmds.Cmd157,	    value = 1.0, message = _("V/UHF radio - On")})
	
	push_start_command(0.1,	{device = devices.MAIN,	action = devCmds.Cmd159,	    value = 1.0, message = _("25W - 5W switch - 5W")})
	
	push_start_command(0.1,	{device = devices.MAIN,	action = devCmds.Cmd255,	    value = -1.0, message = _("Inverter selector switch - Reset")})
	push_start_command(0.5,	{device = devices.MAIN,	action = devCmds.Cmd255,	    value = 0.0})	
	
	push_start_command(3.0,	{device = devices.MAIN,	action = devCmds.Cmd20,	    value = 1.0, message = _("Servos - Reset")})
	push_start_command(0.1,	{device = devices.MAIN,	action = devCmds.Cmd20,	    value = 0.0})
	
	push_start_command(0.1,	{device = devices.MAIN,	action = devCmds.Cmd540,	    value = 0.3333, message = _("IFF - Sby")})

	push_start_command(0.1,	{device = devices.MAIN,	action = devCmds.Cmd555,	    value = -1.0, message = _("Navigation indicator - As required")})
	
	push_start_command(0.1,	{device = devices.MAIN,	action = devCmds.Cmd230,	    value = 1.0, message = _("Standby horizon switch - On")})
	
	push_start_command(0.1,	{device = devices.MAIN,	action = devCmds.Cmd201,	    value = 1.0, message = _("Electro-pump switch - On")})
	
	push_start_command(0.1,	{device = devices.MAIN,	action = devCmds.Cmd213,	    value = 1.0, message = _("Probe heater switch - On")})
	
	push_start_command(0.1,	{device = devices.MAIN,	action = devCmds.Cmd443,	    value = 1.0, message = _("Radar detector switch - On")})
	
	push_start_command(0.1,	{device = devices.MAIN,	action = devCmds.Cmd580,	    value = 0.5, message = _("Sight selector - On")})
	
	push_start_command(0.1,	{device = devices.MAIN,	action = devCmds.Cmd613,	    value = 1, message = _("Radar selector - Standby")})
	
	push_start_command(0.1,	{device = devices.MAIN,	action = devCmds.Cmd236,	    value = 0.333, message = _("Heading and vertical reference system control switch - Gm")})

	push_start_command(0.1,	{device = devices.MAIN,	action = devCmds.Cmd238,	    value = 1.0, message = _("Emergency gyromagnetic compass switch - On")})
	
	push_start_command(0.1,	{device = devices.MAIN,	action = devCmds.Cmd337,	    value = 0.666, message = _("TACAN - Rec")})
	
	push_start_command(0.1,	{device = devices.MAIN,	action = devCmds.Cmd340,	    value = 1.0, message = _("VOR/ILS - On")})

	push_start_command(0.1,	{device = devices.MAIN,	action = devCmds.Cmd376,	    value = 1.0, message = _("Air conditioning - On")})
	
	push_start_command(0.1,	{device = devices.MAIN,	action = devCmds.Cmd234,	    value = 1.0, message = _("Standby horizon - Uncage")})
	push_start_command(0.5,	{device = devices.MAIN,	action = devCmds.Cmd234,	    value = 0.0})
	push_start_command(0.5,	{device = devices.MAIN,	action = devCmds.Cmd235,	    value = 0.5})	
	
-- Need to add this to confirm that servos reset correctly (after C.AERO advisory goes off)
	push_start_command(7.0,	{device = devices.MAIN,	action = devCmds.Cmd20,	    value = 1.0})	
	push_start_command(0.5,	{device = devices.MAIN,	action = devCmds.Cmd20,	    value = 0.0})	
	push_start_command(0.1,	{device = devices.MAIN,	action = devCmds.Cmd193,	    value = 1.0, message = _("Parking brake - Set")})
	push_start_command(1.0,{message = _("AUTOSTART COMPLETE"),message_timeout = std_message_timeout})
	
end

function shut_down()
	push_stop_command(2.0,{message = _("AUTOSTOP SEQUENCE IS RUNNING"),message_timeout = std_message_timeout})
	
	push_stop_command(1.0,	{device = devices.MAIN,	action = devCmds.Cmd459,	    value = -1.0, message = _("UHF radio - On")})

	push_stop_command(1.0,	{device = devices.MAIN,	action = devCmds.Cmd157,	    value = -1.0, message = _("V/UHF radio - On")})
	
	push_stop_command(1.0,	{device = devices.MAIN,	action = devCmds.Cmd130,	    value = -1.0, message = _("AMPLI 2-1 selector switch - 1")})
	
	push_stop_command(1.0,	{device = devices.MAIN,	action = devCmds.Cmd190,	    value = -1.0, message = _("U/C safety lever - Closed")})
	
	push_stop_command(1.0,	{device = devices.MAIN,	action = devCmds.Cmd234,	    value = 1.0, message = _("Standby horizon - Cage")})
	push_stop_command(0.5,	{device = devices.MAIN,	action = devCmds.Cmd235,	    value = 1.0})
	push_stop_command(0.5,	{device = devices.MAIN,	action = devCmds.Cmd234,	    value = 0.0})
	
	push_stop_command(1.0,	{device = devices.MAIN,	action = devCmds.Cmd555,	    value = 1.0, message = _("Navigation indicator - Off")})
	push_stop_command(0.2,	{device = devices.MAIN,	action = devCmds.Cmd555,	    value = 1.0})
	push_stop_command(0.2,	{device = devices.MAIN,	action = devCmds.Cmd555,	    value = 1.0})
	
	push_stop_command(1.0,	{device = devices.MAIN,	action = devCmds.Cmd230,	    value = 0.0, message = _("Standby horizon switch - Off")})
	
	push_stop_command(1.0,	{device = devices.MAIN,	action = devCmds.Cmd201,	    value = 0.0, message = _("Electro-pump switch - Off")})
	
	push_stop_command(1.0,	{device = devices.MAIN,	action = devCmds.Cmd287,	    value = 0.0, message = _("Warning Horn - Off")})	

	push_stop_command(1.0,	{device = devices.MAIN,	action = devCmds.Cmd213,	    value = 0.0, message = _("Probe heater switch - Off")})
	
	push_stop_command(1.0,	{device = devices.MAIN,	action = devCmds.Cmd443,	    value = 0.0, message = _("Radar detector switch - Off")})
	
	push_stop_command(1.0,	{device = devices.MAIN,	action = devCmds.Cmd313,	    value = 0.0, message = _("Search light control - Off")})

	push_stop_command(1.0,	{device = devices.MAIN,	action = devCmds.Cmd580,	    value = 0.0, message = _("Sight selector - Off")})
	
	push_stop_command(1.0,	{device = devices.MAIN,	action = devCmds.Cmd613,	    value = 0.0, message = _("Radar selector - Off")})

	push_stop_command(1.0,	{device = devices.MAIN,	action = devCmds.Cmd587,	    value = 0.0, message = _("Armament control panel pushbutton selectors - Released")})
	push_stop_command(0.2,	{device = devices.MAIN,	action = devCmds.Cmd588,	    value = 0.0})	
	push_stop_command(0.2,	{device = devices.MAIN,	action = devCmds.Cmd589,	    value = 0.0})	
	push_stop_command(0.2,	{device = devices.MAIN,	action = devCmds.Cmd590,	    value = 0.0})	
	push_stop_command(0.2,	{device = devices.MAIN,	action = devCmds.Cmd591,	    value = 0.0})	
	push_stop_command(0.2,	{device = devices.MAIN,	action = devCmds.Cmd592,	    value = 0.0})	
	push_stop_command(0.2,	{device = devices.MAIN,	action = devCmds.Cmd593,	    value = 0.0})
	push_stop_command(0.2,	{device = devices.MAIN,	action = devCmds.Cmd594,	    value = 0.0})
	
	push_stop_command(1.0,	{device = devices.MAIN,	action = devCmds.Cmd236,	    value = 0.0, message = _("Heading and vertical reference system control switch - Off")})

	push_stop_command(1.0,	{device = devices.MAIN,	action = devCmds.Cmd238,	    value = 0.0, message = _("Emergency gyromagnetic compass switch - Off")})
	
	push_stop_command(1.0,	{device = devices.MAIN,	action = devCmds.Cmd340,	    value = 1.0, message = _("VOR/ILS - Off")})
	
	push_stop_command(1.0,	{device = devices.MAIN,	action = devCmds.Cmd376,	    value = 0.0, message = _("Air conditioning - Off")})
	
	push_stop_command(1.0,	{device = devices.MAIN,	action = devCmds.Cmd51,	    value = 1.0, message = _("Throttle cut/idle switch - Stop")})
	push_stop_command(0.5,	{device = devices.MAIN,	action = devCmds.Cmd51,	    value = 0.0})
	
	push_stop_command(1.0,	{device = devices.MAIN,	action = devCmds.Cmd67,	    value = 0.0, message = _("L/H LP pump switch - Off")})

	push_stop_command(1.0,	{device = devices.MAIN,	action = devCmds.Cmd66,	    value = 0.0, message = _("R/H LP pump switch - Off")})
	
	push_stop_command(1.0,	{device = devices.MAIN,	action = devCmds.Cmd65,	    value = 0.0, message = _("Starting pump switch - Off")})

	push_stop_command(1.0,	{device = devices.MAIN,	action = devCmds.Cmd56,	    value = 1.1})
	push_stop_command(1.0,	{device = devices.MAIN,	action = devCmds.Cmd57,	    value = 1.0, message = _("LP main cock switch - Off")})	

	push_stop_command(1.0,	{device = devices.MAIN,	action = devCmds.Cmd250,	    value = 0.0, message = _("Battery - Off")})
	
	push_stop_command(4.0,	{device = devices.MAIN,	action = devCmds.Cmd172,	    value = 1.0, message = _("Canopy lock control - Aft")})		
	
	push_stop_command(1.0,	{device = devices.MAIN,	action = devCmds.Cmd178,	    value = 1.0, message = _("Canopy - Open")})
	
	push_stop_command(3.0,{message = _("AUTOSTOP COMPLETE"),message_timeout = std_message_timeout})	

end	