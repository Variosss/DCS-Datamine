dofile(LockOn_Options.script_path.."command_defs.lua")

KeyCommands = 	{
				 {command = Keys.SPU9_SPU_9_on_off},
				 {command = Keys.SPU9_radio_change},
				 {command = Keys.SPU9_PTT_on},
				 {command = Keys.SPU9_PTT_off},
				}
Events		= 	{"LinkNOPtoNet", "UnlinkNOPfromNet", "OnNewNetHelicopter"}