dofile(LockOn_Options.script_path.."command_defs.lua")
KeyCommands = 	{{command = Keys.PlaneLightsOnOff},
				 {command = Keys.PlaneAntiCollisionLights},
				 {command = Keys.Plane_SpotLight_left, --[[animation_data = {{direct_set = true,arg = 204,arg_increment = 0.3}}]]},
				 {command = Keys.Plane_SpotLight_right, --[[animation_data = {{direct_set = true,arg = 204,arg_increment = 0.4}}]]},
				 {command = Keys.Plane_SpotLight_up, --[[animation_data = {{direct_set = true,arg = 204,arg_increment = 0.2}}]]},
				 {command = Keys.Plane_SpotLight_down, --[[animation_data = {{direct_set = true,arg = 204,arg_increment = 0.1}}]]},
				 {command = Keys.Plane_SpotLight_stop, --[[animation_data = {{direct_set = true,arg = 204,arg_increment = 0.0}}]]},
				} 