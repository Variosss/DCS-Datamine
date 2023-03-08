local cockpit = folder.."../../../Cockpit/Scripts/"
dofile(cockpit.."devices.lua")
dofile(cockpit.."command_defs.lua")

return {
										
keyCommands = {
										
--Helper AI
{up = helperai_commands.ShowMenu, 	down = helperai_commands.ShowMenu, 	cockpit_device_id = devices.HELPER_AI, value_up = 0, value_down = 1,	name = _('Hide Menu'),	category = {_('Helper AI Commands')}},
{up = helperai_commands.Right, 		down = helperai_commands.Right, 	cockpit_device_id = devices.HELPER_AI, value_up = 0, value_down = 1,	name = _('Menu Right'),	category = {_('Helper AI Commands')}},
{up = helperai_commands.Left, 		down = helperai_commands.Left, 		cockpit_device_id = devices.HELPER_AI, value_up = 0, value_down = 1,	name = _('Menu Left'),	category = {_('Helper AI Commands')}},
{up = helperai_commands.Up,			down = helperai_commands.Up,		cockpit_device_id = devices.HELPER_AI, value_up = 0, value_down = 1,	name = _('Menu Up'),	category = {_('Helper AI Commands')}},
{up = helperai_commands.Down,		down = helperai_commands.Down,		cockpit_device_id = devices.HELPER_AI, value_up = 0, value_down = 1,	name = _('Menu Down'),	category = {_('Helper AI Commands')}},

}

}

