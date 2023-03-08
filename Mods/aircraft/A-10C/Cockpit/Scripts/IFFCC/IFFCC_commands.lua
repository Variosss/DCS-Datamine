-- Page handler

-- Commands
-- the section is not intended for end-user editing
dofile(LockOn_Options.script_path.."command_defs.lua")

Events		= 	{"cockpit_release", "WeaponRearmFirstStep", "UnlimitedWeaponStationRestore"}

KeyCommands = { {command = Keys.PlanePickleOn , animation_data = {{direct_set = true,arg = 740,arg_increment =  1}}},
				{command = Keys.PlanePickleOff, animation_data = {{direct_set = true,arg = 740,arg_increment =  0}}},
				{command = Keys.PlaneModeBVR},
				{command = Keys.PlaneModeVS},
				{command = Keys.PlaneModeBore},
				{command = Keys.PlaneModeGround},
				{command = Keys.PlaneModeFI0},
				{command = Keys.PlaneModeCannon},
				{command = Keys.ChangeGunRateOfFire},
				{command = Keys.ChangeRippleQuantity},
				{command = Keys.ChangeRippleInterval},
				{command = Keys.ChangeRippleIntervalDown},
				{command = Keys.ChangeReleaseMode},
				{command = Keys.SwitchMasterArm},
				{command = Keys.PlaneLaunchPermissionOverride},
				{command = Keys.PlaneSalvoOnOff},
				{command = Keys.PlaneChangeWeapon},
				{command = Keys.PlaneCancelWeaponsDelivery},
				{command = Keys.Plane_HOTAS_TriggerSecondStage, animation_data = {{direct_set = true,arg = 808,arg_increment = 1}}},
				{command = Keys.Plane_HOTAS_TriggerFirstStage, animation_data = {{direct_set = true,arg = 808,arg_increment = 0.5}}},
				{command = Keys.Plane_HOTAS_TriggerSecondStage_Off, animation_data = {{direct_set = true,arg = 808,arg_increment = 0}}},
				{command = Keys.Plane_HOTAS_TriggerFirstStage_Off, animation_data = {{direct_set = true,arg = 808,arg_increment = 0}}},
			  }
