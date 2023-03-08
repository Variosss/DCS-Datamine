-- Commands
-- the section is not intended for end-user editing
dofile(LockOn_Options.script_path.."command_defs.lua")

KeyCommands =	{{command = Keys.PlaneTrimOff},
				 {command = Keys.PlaneTrimOn},
				 {command = Keys.PlaneTrimCancel},
				 {command = Keys.iCommandAutopilotEmergOFF},
				 {command = Keys.iCommandAutopilotEmergOFF_up},
}

need_to_be_closed = true -- close lua state after initialization 