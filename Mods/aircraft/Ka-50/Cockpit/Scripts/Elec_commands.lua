-- Commands
-- the section is not intended for end-user editing
dofile(LockOn_Options.script_path.."command_defs.lua")
KeyCommands = {{command = Keys.GroundPowerDC},
			   {command = Keys.GroundPowerDC_Cover},
			   {command = Keys.PowerBattery1},
			   {command = Keys.PowerBattery1_Cover},
			   {command = Keys.PowerBattery2},
			   {command = Keys.PowerBattery2_Cover},
			   {command = Keys.GroundPowerAC},
			   {command = Keys.PowerGeneratorLeft},
			   {command = Keys.PowerGeneratorRight},
			   {command = Keys.ElectricalPowerInverter}
}
Events 		= {"GroundPowerOn", "GroundPowerOff"}