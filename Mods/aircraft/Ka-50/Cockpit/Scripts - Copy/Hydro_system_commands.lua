dofile(LockOn_Options.script_path.."command_defs.lua")
KeyCommands = 	{{command = Keys.MainHydraulics},
				 {command = Keys.MainHydraulicsCover}
				} 
Events		= 	{"EnableTurboGear", "DisableTurboGear"}