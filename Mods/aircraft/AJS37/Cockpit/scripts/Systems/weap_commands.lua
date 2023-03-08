-- Commands
-- the section is not intended for end-user editing
dofile(LockOn_Options.script_path.."command_defs.lua")

Events		= 	{"WeaponRearmFirstStep", "WeaponRearmComplete"}


KeyCommands =	{
				{command = Keys.PlaneFire, animation_data = {{direct_set = true,arg = 188,arg_increment = 1}}},
				{command = Keys.PlaneFireOff, animation_data = {{direct_set = true,arg = 188,arg_increment = 0}}},
				}
-- ^^^^^Has no effect