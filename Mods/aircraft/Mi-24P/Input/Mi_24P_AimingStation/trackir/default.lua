local cockpit = folder.."../../../Cockpit/Scripts/"
dofile(cockpit.."devices.lua")
dofile(cockpit.."command_defs.lua")

return {
axisCommands = {
-- TrackIR axes
{combos = {{key = 'TRACKIR_PITCH'}},	action = i9K113_commands.Command_TRACKIR_SIGHT_UP_DOWN_AXIS		, cockpit_device_id = devices.I9K113,	name = _('Head Tracker : Pitch')},
{combos = {{key = 'TRACKIR_YAW'}},  	action = i9K113_commands.Command_TRACKIR_SIGHT_LEFT_RIGHT_AXIS	, cockpit_device_id = devices.I9K113,	name = _('Head Tracker : Yaw')},
{combos = {{key = 'TRACKIR_ROLL'}}, 	action = i9K113_commands.Command_TRACKIR_SIGHT_ROLL_AXIS		, cockpit_device_id = devices.I9K113,	name = _('Head Tracker : Roll')},
{combos = {{key = 'TRACKIR_X'}}, 		action = i9K113_commands.Command_TRACKIR_SIGHT_X_AXIS			, cockpit_device_id = devices.I9K113,	name = _('Head Tracker : Right/Left')},
{combos = {{key = 'TRACKIR_Y'}}, 		action = i9K113_commands.Command_TRACKIR_SIGHT_Y_AXIS			, cockpit_device_id = devices.I9K113,	name = _('Head Tracker : Up/Down')},
{combos = {{key = 'TRACKIR_Z'}}, 		action = i9K113_commands.Command_TRACKIR_SIGHT_Z_AXIS			, cockpit_device_id = devices.I9K113,	name = _('Head Tracker : Forward/Backward')},
},
}
