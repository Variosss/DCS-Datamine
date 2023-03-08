local cockpit = folder.."../../Cockpit/Scripts/"
dofile(cockpit.."devices.lua")
dofile(cockpit.."command_defs.lua")

---------------------------------------------------------------------
local MAXIMUN_DEVICE_AMOUNT_IN_CONTEXT = 256
local plugin_index = 1
local dev_index_inplugin = devices.GNS430

local device_id = MAXIMUN_DEVICE_AMOUNT_IN_CONTEXT * plugin_index + dev_index_inplugin

---------------------------------------------------------------------
local keyCommands = { 
{down = iCommandViewPopupNavDisplay, name = _('Close Look to NS430 On Off'), category = _('Views')},
-- iCommand_COM_push
{down = device_commands.Button_1, up = device_commands.Button_30, cockpit_device_id = device_id, value_down = 1, value_up = 0, name = _('Power/COM Volume knob push'), category = _('NS Device')},

-- iCommand_power_volume_axis
{pressed = device_commands.Button_3, cockpit_device_id = device_id, value_pressed = 0.5, name = _('Power/COM Volume knob Increase'), category = _('NS Device')},
{pressed = device_commands.Button_3, cockpit_device_id = device_id, value_pressed = -0.5, name = _('Power/COM Volume knob Decrease'), category = _('NS Device')},

-- iCommand_vloc_push
{down = device_commands.Button_4, up = device_commands.Button_31, cockpit_device_id = device_id, value_down = 1, value_up = 0, name = _('VLOC knob push'), category = _('NS Device')},

-- iCommand_vloc_volume_axis
{pressed = device_commands.Button_6, cockpit_device_id = device_id, value_pressed = 0.5, name = _('VLOC Volume knob Increase'), category = _('NS Device')},
{pressed = device_commands.Button_6, cockpit_device_id = device_id, value_pressed = -0.5, name = _('VLOC Volume knob Decrease'), category = _('NS Device')},

-- iCommand_left_big_axis
{pressed = device_commands.Button_8, cockpit_device_id = device_id, value_pressed = 0.5, name = _('Left big knob Increase'), category = _('NS Device')},
{pressed = device_commands.Button_8, cockpit_device_id = device_id, value_pressed = -0.5, name = _('Left big knob Decrease'), category = _('NS Device')},

-- iCommand_left_small_push
{down = device_commands.Button_9, up = device_commands.Button_32, cockpit_device_id = device_id, value_down = 1, value_up = 0, name = _('Left small knob push'), category = _('NS Device')},

-- iCommand_left_small_axis
{pressed = device_commands.Button_11, cockpit_device_id = device_id, value_pressed = 0.5, name = _('Left small knob Increase'), category = _('NS Device')},
{pressed = device_commands.Button_11, cockpit_device_id = device_id, value_pressed = -0.5, name = _('Left small knob Decrease'), category = _('NS Device')},

-- iCommand_com_flip_flop_push
{down = device_commands.Button_12, up = device_commands.Button_33, cockpit_device_id = device_id, value_down = 1, value_up = 0, name = _('COM flip-flop'), category = _('NS Device')},

-- iCommand_vloc_flip_flop_push
{down = device_commands.Button_13, up = device_commands.Button_34, cockpit_device_id = device_id, value_down = 1, value_up = 0, name = _('VLOC flip-flop'), category = _('NS Device')},

-- iCommand_cdi_push
{down = device_commands.Button_14, up = device_commands.Button_35, cockpit_device_id = device_id, value_down = 1, value_up = 0, name = _('CDI'), category = _('NS Device')},

-- iCommand_obs_push
{down = device_commands.Button_15, up = device_commands.Button_36, cockpit_device_id = device_id, value_down = 1, value_up = 0, name = _('OBS'), category = _('NS Device')},

-- iCommand_msg_push
{down = device_commands.Button_16, up = device_commands.Button_37, cockpit_device_id = device_id, value_down = 1, value_up = 0, name = _('MSG'), category = _('NS Device')},

-- iCommand_fpl_push
{down = device_commands.Button_17, up = device_commands.Button_38, cockpit_device_id = device_id, value_down = 1, value_up = 0, name = _('FPL'), category = _('NS Device')},

-- iCommand_proc_push
{down = device_commands.Button_18, up = device_commands.Button_39, cockpit_device_id = device_id, value_down = 1, value_up = 0, name = _('PROC'), category = _('NS Device')},

-- iCommand_rng_up_push
{down = device_commands.Button_19, up = device_commands.Button_40, cockpit_device_id = device_id, value_down = -1, value_up = 0, name = _('RNG-UP'), category = _('NS Device')},

-- iCommand_rng_down_push
{down = device_commands.Button_20, up = device_commands.Button_41, cockpit_device_id = device_id, value_down = 1, value_up = 0, name = _('RNG-DOWN'), category = _('NS Device')},

-- iCommand_direct_to_push
{down = device_commands.Button_21, up = device_commands.Button_42, cockpit_device_id = device_id, value_down = 1, value_up = 0, name = _('DIRECT-TO'), category = _('NS Device')},

-- iCommand_menu_push
{down = device_commands.Button_22, up = device_commands.Button_43, cockpit_device_id = device_id, value_down = 1, value_up = 0, name = _('MENU'), category = _('NS Device')},

-- iCommand_clr_push
{down = device_commands.Button_23, up = device_commands.Button_44, cockpit_device_id = device_id, value_down = 1, value_up = 0, name = _('CLR'), category = _('NS Device')},

-- iCommand_ent_push
{down = device_commands.Button_24, up = device_commands.Button_45, cockpit_device_id = device_id, value_down = 1, value_up = 0, name = _('ENT'), category = _('NS Device')},

-- iCommand_right_big_axis
{pressed = device_commands.Button_26, cockpit_device_id = device_id, value_pressed = 0.5, name = _('Right big knob Increase'), category = _('NS Device')},
{pressed = device_commands.Button_26, cockpit_device_id = device_id, value_pressed = -0.5, name = _('Right big knob Decrease'), category = _('NS Device')},

-- iCommand_right_small_push
{down = device_commands.Button_27, up = device_commands.Button_46, cockpit_device_id = device_id, value_down = 1, value_up = 0, name = _('Right small knob push'), category = _('NS Device')},

-- iCommand_right_small_axis
{pressed = device_commands.Button_29, cockpit_device_id = device_id, value_pressed = 0.5, name = _('Right small knob Increase'), category = _('NS Device')},
{pressed = device_commands.Button_29, cockpit_device_id = device_id, value_pressed = -0.5, name = _('Right small knob Decrease'), category = _('NS Device')},

}
---------------------joystick axes-----------------------------------
local axisCommands = {

{action = device_commands.Button_47, cockpit_device_id = device_id, name = _('Power/COM Volume knob')},
{action = device_commands.Button_48, cockpit_device_id = device_id, name = _('VLOC Volume knob')},

}
---------------------------------------------------------------------
return {
	forceFeedback = {ignore = true},
  	keyCommands   = keyCommands,
	axisCommands  = axisCommands,
}