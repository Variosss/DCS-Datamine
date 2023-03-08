dofile(LockOn_Options.script_path.."command_defs.lua")

KeyCommands = {{command = Keys.PlaneModeHelmet},
			   {command = Keys.PlaneNightVisionGogglesOnOff},
               {command = Keys.iCommandPlane_Helmet_Brightess_Up,arg = 405, arg_increment = 0.05, arg_lim = {0,1}},
               {command = Keys.iCommandPlane_Helmet_Brightess_Down,arg = 405, arg_increment = -0.05, arg_lim = {0,1}},
              }
