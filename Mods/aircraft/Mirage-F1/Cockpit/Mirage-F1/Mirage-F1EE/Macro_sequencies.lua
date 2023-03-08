dofile(LockOn_Options.script_path.."../../Common/Macro_sequencies_common.lua")

function startup_INS_EE()
    push_start_command(1.0,	{device = devices.MAIN,	action = devCmds.Cmd681,	value = 0.875, message = _("Modes selector - VEI")})
	push_start_command(1.0,	{device = devices.MAIN,	action = devCmds.Cmd681,	value = 0.25, message = _("Modes selector - ALN")})	
	push_start_command(1.0,	{device = devices.MAIN,	action = devCmds.Cmd680,	value = 0.0, message = _("Parameters selector - POS")})	
	push_start_command(1.0,	{device = devices.MAIN,	action = devCmds.Cmd682,	value = 0.0, message = _("Waypoints selecting wheel - Waypoint 1")})
	push_start_command(1.0,	{device = devices.MAIN,	action = devCmds.Cmd695,	value = 1.0, message = _("INS * pushbutton - Depress")})
	push_start_command(0.2,	{device = devices.MAIN,	action = devCmds.Cmd695,	value = 0.0})	
	push_start_command(1.0,	{device = devices.MAIN,	action = devCmds.Cmd680,	value = 0.4, message = _("Parameters selector - STS")})
	push_start_command(1.0,{message = _("WAIT FOR INS ALIGNMENT..."),message_timeout = 387})
	push_start_command(387.0,{})
	push_start_command(1.0,	{device = devices.MAIN,	action = devCmds.Cmd681,	value = 0.125, message = _("Modes selector - NAV")})
	push_start_command(1.0,	{device = devices.MAIN,	action = devCmds.Cmd680,	value = 0.3, message = _("Parameters selector - VS/RT")})
end

startup_stage1()
startup_INS_EE()
startup_complete()

shut_down()