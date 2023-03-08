--[[Possible owner names:
	pilot_in_command( "pilot" in code and scripts), 
	copilot("copilot" in code and scripts)
--]]

--[[Possible panel names for exlcude and include arguments:
	STICK_PILOT, STICK_COPILOT, COLLECTIVE_PILOT, DEVIATION_INDICATOR, GMC,
	AAU32, AAU7, RADAR_ALTIMETER, FUEL_QUANTITY, CLOCK, ADI_PILOT, ADI_COPILOT,
	DG_SLAVE, VHF_ARC_134, UHF_ARC_51, INTERCOM, VHF_ARC_131, ADF_ARN_83,
	ARN_82, MARKER_BEACON, IFF, ENGINE_AND_MISCELANNEOOUS_PANEL, CAUTION_PANEL,
	DC_POWER_BREAKER_CONSOLE, OVERHEAD_CONSOLE, FIRE_PANEL, WEAPON_CONTROL,
	INTERVAL_CONTROL, AC_POWER_BREAKER_CONSOLE, PILOT_SIGHT, CHAFF_FLARE_PANEL,
	DOORS
	You also can use drawing arguments from a cockpit.
	example: include_arguments = {"OVERHEAD_CONSOLE", 1,2 };
--]]

overhead_group=
{
	owner = 'pilot_in_command';
	include_arguments = {"OVERHEAD_CONSOLE", "DC_POWER_BREAKER_CONSOLE",
						"AC_POWER_BREAKER_CONSOLE", "DOORS", 421};
	exclude_arguments = {};
};

pedestal_left_side = 
{
	owner = 'copilot';
	include_arguments = {"IFF",	"ARN_82", "VHF_ARC_134", "UHF_ARC_51",
							"INTERCOM", "INTERVAL_CONTROL", "WEAPON_CONTROL"};
	exclude_arguments = {};						
};

pedestal_right_side = 
{
	owner = 'pilot_in_command';
	include_arguments = {"VHF_ARC_131", "ADF_ARN_83", "ENGINE_AND_MISCELANNEOOUS_PANEL",
						"CAUTION_PANEL", "ENGINE_AND_MISCELANNEOOUS_PANEL", 
						"CHAFF_FLARE_PANEL"};
	exclude_arguments = {};
};

instrumental_panel_left_side =
{
	owner = 'copilot';
	include_arguments = {"AAU32", "ADI_COPILOT", "FLEX_SIGHT", "GUNPODS"};
	exclude_arguments = {};
};

instrumental_panel_right_side =
{
	owner = 'pilot_in_command';
	include_arguments = {"AAU7", "CLOCK", "MARKER_BEACON", "GMC", "DEVIATION_INDICATOR",
						"ADI_PILOT", "FIRE_PANEL",
						"RADAR_ALTIMETER", "DG_SLAVE", "FUEL_QUANTITY", "PILOT_SIGHT"};
	exclude_arguments = {};
};

controls_pilot = 
{
	owner = 'copilot';
	include_arguments = {"STICK_COPILOT", "HEAD_COPILOT"};
	exclude_arguments = {};	
};

controls_pilot_in_command = 
{
	owner = 'pilot_in_command';
	include_arguments = {"STICK_PILOT", "COLLECTIVE_PILOT", "HEAD_PILOT"};
	exclude_arguments = {};	
};

flight_control_essential = 
{
	owner = 'current_pilot';
	include_arguments = {"FLIGHT_CONTROL"};
	exclude_arguments = {};	
};

left_gunner_controls = 
{
	owner = 'left_gunner';
	include_arguments = {"LEFT_GUNNER"};
	exclude_arguments = {};	
}

right_gunner_controls = 
{
	owner = 'right_gunner';
	include_arguments = {"RIGHT_GUNNER"};
	exclude_arguments = {};	
}

need_to_be_closed = true -- lua_state  will be closed in post_initialize()