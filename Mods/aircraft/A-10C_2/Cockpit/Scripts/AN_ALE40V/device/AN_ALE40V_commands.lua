-- Page handler

-- Commands
-- the section is not intended for end-user editing
dofile(LockOn_Options.script_path.."command_defs.lua")
	
KeyCommands = {	 {command = Keys.PlaneDropSnarOnce},
				 {command = Keys.PlaneDropSnarOnceOff}
			  }

Events		= 	{"initChaffFlarePayload"}
