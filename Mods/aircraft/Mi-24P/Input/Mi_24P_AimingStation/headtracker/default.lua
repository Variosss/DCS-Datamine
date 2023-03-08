local cockpit = folder.."../../../Cockpit/Scripts/"
dofile(cockpit.."devices.lua")
dofile(cockpit.."command_defs.lua")

return {

axisCommands = {
-- headtracker axes
{combos = {{key = 'HEADTRACKER_PITCH'}},	action = i9K113_commands.Command_TRACKIR_SIGHT_UP_DOWN_AXIS		, cockpit_device_id = devices.I9K113,	name = _('Head Tracker : Pitch')},
{combos = {{key = 'HEADTRACKER_YAW'}}, 		action = i9K113_commands.Command_TRACKIR_SIGHT_LEFT_RIGHT_AXIS	, cockpit_device_id = devices.I9K113,	name = _('Head Tracker : Yaw')},
{combos = {{key = 'HEADTRACKER_X'}}, 		action = i9K113_commands.Command_TRACKIR_SIGHT_X_AXIS			, cockpit_device_id = devices.I9K113,	name = _('Head Tracker : Right/Left')},
{combos = {{key = 'HEADTRACKER_Y'}}, 		action = i9K113_commands.Command_TRACKIR_SIGHT_Y_AXIS			, cockpit_device_id = devices.I9K113,	name = _('Head Tracker : Up/Down')},
{combos = {{key = 'HEADTRACKER_Z'}}, 		action = i9K113_commands.Command_TRACKIR_SIGHT_Z_AXIS			, cockpit_device_id = devices.I9K113,	name = _('Head Tracker : Forward/Backward')},
{combos = {{key = 'HEADTRACKER_ROLL'}},		action = i9K113_commands.Command_TRACKIR_SIGHT_ROLL_AXIS		, cockpit_device_id = devices.I9K113,	name = _('Head Tracker : Roll')},
},
}
