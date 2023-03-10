local gettext = require("i_18n")
_ = gettext.translate

dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."draw_args.lua")

cursor_mode =
{
    CUMODE_CLICKABLE            = 0,
    CUMODE_CLICKABLE_AND_CAMERA = 1,
    CUMODE_CAMERA               = 2,
};

flipcover_animation_speed = 16

clickable_mode_initial_status = cursor_mode.CUMODE_CLICKABLE
use_pointer_name              = true
direction                     = 1
cyclic_by_default             = true -- to cycle two-way thumblers or not by default
pilot_only = {0}
pilot_and_rio = {0,1}
rio_only = {1}

function default_button(hint_,device_,command_,arg_,arg_val_,arg_lim_,crew_)
	local arg_val_ = arg_val_ or 1
	local arg_lim_ = arg_lim_ or {0,1}
    local crew = crew_ or pilot_and_rio
	return {
        class 				 = {class_type.BTN},
        hint 				 = hint_,
        device 				 = device_,
        action 				 = {command_},
        stop_action 		 = {command_},
        arg 				 = {arg_},
        arg_value			 = {arg_val_},
        arg_lim 			 = {arg_lim_},
        use_release_message = {true},
		
	    animated 	 = {true, true,false},
        animation_speed = {32, 32},
		crew_member_access  = crew,
		
		
        sound = {{SOUND_GENERICBUTTON1},{SOUND_BUTTONUP}}
	}


end

function default_cap_button(hint_,device_,command_,arg_,arg_val_,arg_lim_)
    local arg_val_ = arg_val_ or 1
    local arg_lim_ = arg_lim_ or {0,1}
    return {
        class                = {class_type.BTN},
        hint                 = hint_,
        device               = device_,
        action               = {command_},
        stop_action          = {command_},
        arg                  = {arg_},
        arg_value            = {arg_val_},
        arg_lim              = {arg_lim_},
        use_release_message = {true},
        
        animated     = {true, true,false},
        animation_speed = {32, 32},
        
        
        
        sound = {{SOUND_GENERICBUTTON1},{SOUND_BUTTONUP}}
    }

end

function default_button_big(hint_,device_,command_,arg_,arg_val_,arg_lim_,crew_)
	local arg_val_ = arg_val_ or 1
	local arg_lim_ = arg_lim_ or {0,1}
    local crew = crew_ or pilot_and_rio
	return {
        class 				 = {class_type.BTN},
        hint 				 = hint_,
        device 				 = device_,
        action 				 = {command_},
        stop_action 		 = {command_},
        arg 				 = {arg_},
        arg_value			 = {arg_val_},
        arg_lim 			 = {arg_lim_},
        use_release_message = {true},
        crew_member_access  = crew,
		
		animated 	 = {true, true,false},
        animation_speed = {32, 32},
		
        sound = {{SOUND_ACM_BUTTON_DN, SOUND_ACM_BUTTON_REL},{SOUND_ACM_BUTTON_DN, SOUND_ACM_BUTTON_REL}}
	}
end

function default_1_position_tumb(hint_, device_, command_, arg_, arg_val_, arg_lim_, crew_)
	local arg_val_ = arg_val_ or 1
	local arg_lim_ = arg_lim_ or {0,1}
    local crew = crew_ or pilot_and_rio
	return {
        class 		 = {class_type.TUMB},
        hint 		 = hint_,
        device 		 = device_,
        action 		 = {command_},
        arg 	 	 = {arg_},
        arg_value 	 = {arg_val_},
        arg_lim 	 = {arg_lim_},
        updatable 	 = true,
        crew_member_access  = crew,
        use_OBB 	 = true
	}
end

function default_2_position_tumb(hint_, device_, command_, arg_, crew_)
    local crew = crew_ or pilot_and_rio
	return {
        class 		 = {class_type.TUMB,class_type.TUMB},
        hint 		 = hint_,
        device 		 = device_,
        action 		 = {command_,command_},
        arg 	 	 = {arg_,arg_},
        arg_value 	 = {1,-1},
        arg_lim 	 = {{0,1},{0,1}},
        updatable 	 = true,
        use_OBB 	 = true,
        crew_member_access  = crew,
		
		animated 	 = {true, true,false},
        animation_speed = {19, 19},
		
        sound = {{SOUND_MAJOR_FLIPSWITCH},{SOUND_MAJOR_FLIPSWITCH}}
	}
end

-- for switches going -1 to 1 instead of 0 to 1
function alt_2_position_tumb(hint_, device_, command_, arg_)
	return {
        class 		 = {class_type.TUMB,class_type.TUMB},
        hint 		 = hint_,
        device 		 = device_,
        action 		 = {command_,command_},
        arg 	 	 = {arg_,arg_},
        arg_value 	 = {2,-2},
        arg_lim 	 = {{-1,1},{-1,1}},
        updatable 	 = true,
        use_OBB 	 = true,

		animated 	 = {true, true,false},
        animation_speed = {19, 19},

        sound = {{SOUND_MAJOR_FLIPSWITCH},{SOUND_MAJOR_FLIPSWITCH}}
	}
end

function default_displaybutton(hint_, device_, command_, arg_, crew_)
    local crew = crew_ or pilot_and_rio
	return {
        class 		 = {class_type.TUMB,class_type.TUMB},
        hint 		 = hint_,
        device 		 = device_,
        action 		 = {command_,command_},
        arg 	 	 = {arg_,arg_},
        arg_value 	 = {1,-1},
        arg_lim 	 = {{0,1},{0,1}},
        updatable 	 = true,
        use_OBB 	 = true,
		
		animated 	 = {true, true,false},
        animation_speed = {15, 15},
        crew_member_access  = crew,
		
        sound = {{SOUND_DISPLAY_BUTTONS},{SOUND_TINY_KNOB_BETTER}, {SOUND_DISPLAY_BUTTONS},{SOUND_TINY_KNOB_BETTER}}          
	}
end

function default_flipcover(hint_, device_, command_, arg_)
	return {
	
        class 		 = {class_type.TUMB,class_type.TUMB},
        hint 		 = hint_,
        device 		 = device_,
        action 		 = {command_,command_},
        arg 	 	 = {arg_,arg_},
        arg_value 	 = {1,-1},
        arg_lim 	 = {{0,1},{0,1}},
        updatable 	 = true,
        use_OBB 	 = true,
		
		animated 	 = {true, true,false},
        animation_speed = {14, 14},
		
        sound = {{SOUND_FLIPCOVER_CLOSE,SOUND_FLIPCOVER_OPEN},{SOUND_FLIPCOVER_CLOSE,SOUND_FLIPCOVER_OPEN}}
	}
end



function default_3_position_tumb(hint_,device_,command_,arg_,cycled_,inversed_,crew_)
	local cycled = true
	local val = 1
	if inversed_ then
        val = -1
	end
	if cycled_ ~= nil then
        cycled = cycled_
	end
    local crew = crew_ or pilot_and_rio
	return {
        class 		 = {class_type.TUMB,class_type.TUMB},
        hint 		 = hint_,
        device 		 = device_,
        action 		 = {command_,command_},
        arg 	 	 = {arg_,arg_},
        arg_value 	 = {val,-val},
        arg_lim 	 = {{-1,1},{-1,1}},
        updatable 	 = true,
        use_OBB 	 = true,
        cycle = cycled,
        crew_member_access  = crew,
		
		animated 	 = {true, true,false},
        animation_speed = {19, 19},
		
        sound = {{SOUND_MAJOR_FLIPSWITCH},{SOUND_MAJOR_FLIPSWITCH}}
	}
end

function default_axis_old(hint_,device_,command_,arg_, default_, gain_,updatable_,relative_)

	local default = default_ or 1
	local gain = gain_ or 0.1
	local updatable = updatable_ or false
	local relative  = relative_ or false

	return  {
        class 		= {class_type.LEV},
        hint  		= hint_,
        device 		= device_,
        action 		= {command_},
        arg 	  	= {arg_},
        arg_value 	= {default},
        arg_lim   	= {{0,1}},
        updatable 	= updatable,
        use_OBB 	= true,
        gain		= {gain},
        relative    = {relative},
	}
end

function default_axis(hint_,device_,command_,arg_, default_, gain_,updatable_,relative_,cycle_,crew_)
	local default = default_ or 1
	local gain = gain_ or 0.1
	local updatable = updatable_ or false
	local relative = relative_ or false
    local crew = crew_ or pilot_and_rio

	return {
        class 		 = {class_type.LEV},
        hint 		 = hint_,
        device 		 = device_,
        action 		 = {command_},
        arg 	 	 = {arg_},
        arg_value 	 = {default},
        arg_lim 	 = {{0,1}},
        updatable 	 = updatable,
        use_OBB 	 = false,
        gain		 = {gain},
        relative 	 = {relative},
        crew_member_access  = crew,
        cycle 	 	 =  cycle_ or false
	}
end

function default_movable_axis(hint_,device_,command_,arg_, default_, gain_,updatable_,relative_)
	local default = default_ or 1
	local gain = gain_ or 0.1
	local updatable = updatable_ or false
	local relative = relative_ or false

	return {
        class 		 = {class_type.MOVABLE_LEV},
        hint 		 = hint_,
        device 		 = device_,
        action 		 = {command_},
        arg 	 	 = {arg_},
        arg_value 	 = {default},
        arg_lim 	 = {{0,1}},
        updatable 	 = updatable,
        use_OBB 	 = true,
        gain		 = {gain},
        relative = {relative},
	}
end

function default_axis_limited(hint_,device_,command_,arg_, default_, gain_,updatable_,relative_, arg_lim_, cycle_)
	local relative = false
	local default = default_ or 0
	local updatable = updatable_ or false
	if relative_ ~= nil then
		relative = relative_
	end

	local cycle__ = false
	if cycle_ ~= nil then
		cycle__ = cycle_
	end

	local gain = gain_ or 0.1
	return {
        class 		 = {class_type.LEV},
        hint 		 = hint_,
        device 		 = device_,
        action 		 = {command_},
        arg 	 	 = {arg_},
        arg_value 	 = {default},
        arg_lim 	 = arg_lim_,
        updatable 	 = updatable,
        use_OBB 	 = false,
        gain		 = {gain},
        relative = {relative},
        cycle 	 	 =  cycle__
	}
end

function multiposition_switch(hint_,device_,command_,arg_,count_,delta_,inversed_, min_, crew_)
    local min_ = min_ or 0
	local delta_ = delta_ or 0.5
	local inversed = 1
	if inversed_ then
		inversed = -1
	end
    local crew = crew_ or pilot_and_rio
	return {
        class 		 = {class_type.TUMB,class_type.TUMB},
        hint 		 = hint_,
        device 		 = device_,
        action 		 = {command_,command_},
        arg 	 	 = {arg_,arg_},
        arg_value 	 = {-delta_ * inversed,delta_ * inversed},
        arg_lim 	 = {{min_, min_ + delta_ * (count_ -1)},
                        {min_, min_ + delta_ * (count_ -1)}},
        updatable 	 = true,
        use_OBB 	 = true,
        crew_member_access  = crew,
        sound = {{SOUND_MAJOR_FLIPSWITCH},{SOUND_MAJOR_FLIPSWITCH}}
	}
end

function multiposition_switch_springy(hint_,device_,command_,arg_,count_,delta_,inversed_, min_, crew_)
    local min_ = min_ or 0
	local delta_ = delta_ or 0.5
	local inversed = 1
	if inversed_ then
		inversed = -1
	end
    local crew = crew_ or pilot_and_rio
	return {
        class 		 = {class_type.TUMB,class_type.TUMB},
        hint 		 = hint_,
        device 		 = device_,
        action 		 = {command_,command_},
        arg 	 	 = {arg_,arg_},
        arg_value 	 = {-delta_ * inversed,delta_ * inversed},
        arg_lim 	 = {{min_, min_ + delta_ * (count_ -1)},
                        {min_, min_ + delta_ * (count_ -1)}},
        updatable 	 = true,
        use_OBB 	 = true,
        crew_member_access  = crew,
		
        sound = {{SOUND_SPRINGY2_KNOB},{SOUND_SPRINGY2_KNOB}}
	}
end

function multiposition_switch_limited(hint_,device_,command_,arg_,count_,delta_,inversed_,min_,crew_)
    local min_ = min_ or 0
	local delta_ = delta_ or 0.5
	local inversed = 1
	if inversed_ then
		inversed = -1
	end
    local crew = crew_ or pilot_and_rio
	return {
        class 		 = {class_type.TUMB,class_type.TUMB},
        hint 		 = hint_,
        device 		 = device_,
        action 		 = {command_,command_},
        arg 	 	 = {arg_,arg_},
        arg_value 	 = {-delta_ * inversed,delta_ * inversed},
        arg_lim 	 = {{min_, min_ + delta_ * (count_ -1)},
                        {min_, min_ + delta_ * (count_ -1)}},
        updatable 	 = true,
        use_OBB 	 = true,
        cycle 	 = false,
		
		animated 	 = {true, true},
        animation_speed = {4, 4},
        crew_member_access  = crew,
		
		
        sound = {{SOUND_MAJOR_FLIPSWITCH},{SOUND_MAJOR_FLIPSWITCH}}
	}
end

function multiposition_roller_limited(hint_,device_,command_,arg_,count_,inversed_,range_,crew_)
	local range = range_ or 1.0
	local delta_ = range / ( count_ - 1.0 )
	local inversed = 1
	if inversed_ then
		inversed = -1
	end
    local crew = crew_ or pilot_and_rio
	return {
        class 		 = {class_type.TUMB,class_type.TUMB},
        hint 		 = hint_,
        device 		 = device_,
        action 		 = {command_,command_},
        arg 	 	 = {arg_,arg_},
        arg_value 	 = {-delta_ * inversed,delta_ * inversed},
        arg_lim 	 = {{0, delta_ * (count_ -1)},
                        {0, delta_ * (count_ -1)}},
        updatable 	 = true,
        use_OBB 	 = true,
        cycle 	 = false,		
		animated 	 = {true, true},
        crew_member_access  = crew,
        animation_speed = {16.0/count_, 16.0/count_},		
        sound = {{SOUND_TINY_KNOB_BETTER},{SOUND_TINY_KNOB_BETTER}}
	}
end

function default_button_axis(hint_, device_,command_1, command_2, arg_1, arg_2, limit_1, limit_2)
	local limit_1_ = limit_1 or 1.0
	local limit_2_ = limit_2 or 1.0
    return {
        class		 = {class_type.BTN, class_type.LEV},
        hint		 = hint_,
        device		 = device_,
        action		 = {command_1, command_2},
        stop_action  = {command_1, 0},
        arg			 = {arg_1, arg_2},
        arg_value	 = {1, 0.5},
        arg_lim		 = {{0, limit_1_}, {0,limit_2_}},
        animated     = {false,true},
        animation_speed = {0, 0.9},
        gain         = {0, 0.5},
        relative	 = {false, false},
        updatable 	 = true,
        use_OBB 	 = true,
        use_release_message = {true, false}
	}
end

function default_animated_lever(hint_, device_, command_, arg_, animation_speed_,arg_lim_,crew_)
    local arg_lim__ = arg_lim_ or {0.0,1.0}
    local crew = crew_ or pilot_and_rio
    return {
        class = {class_type.TUMB, class_type.TUMB},
        hint 	 = hint_,
        device 	 = device_,
        action 	 = {command_, command_},
        arg 		 = {arg_, arg_},
        arg_value 	 = {1, 0},
        arg_lim 	 = {arg_lim__, arg_lim__},
        updatable = true,
        gain 		 = {0.1, 0.1},
        animated 	 = {true, true},
        animation_speed = {animation_speed_, 0},
        cycle = true,
        crew_member_access  = crew,
        sound = {{SOUND_WINGSWEEP_COVER_OPEN,SOUND_WINGSWEEP_COVER_CLOSE},{SOUND_WINGSWEEP_COVER_OPEN,SOUND_WINGSWEEP_COVER_CLOSE}}
    }
end

function default_button_tumb(hint_, device_, command1_, command2_, arg_)
	return {
        class 		 = {class_type.BTN,class_type.TUMB},
        hint 		 = hint_,
        device 		 = device_,
        action 		 = {command1_,command2_},
        stop_action  = {command1_,0},
        arg 	 	 = {arg_,arg_},
        arg_value 	 = {-1,1},
        arg_lim 	 = {{-1,0},{0,1}},
        updatable 	 = true,
        use_OBB 	 = true,
        use_release_message = {true,false}
	}
end

function default_springloaded_3pos_switch(hint_, device_, command1_, command2_, value1_, value2_, value3_, arg_)
--[[ command1_ - tumbler's up command,
	 command2_ - tumbler's down command
	 value1_ - tumbler's up position
	 value2_ - center position
	 value3_ - tumbler's down position
]]
	return	{
        class 		= {class_type.TUMB, class_type.TUMB},
        hint 		= hint_,
        device 		= device_,
        action 	= {command1_ ,	command2_},
        stop_action = {command1_, 	command2_},
        arg 		= {arg_,		arg_},
        stop_value 	= {value2_,			value2_},
        arg_value 	= {value1_, 	value3_},
        arg_lim 	= {{value1_, value2_}, {value3_, value2_}},
		
        use_release_message = {false, false}
    }
end

function default_springloaded_3pos_switch_tiny(hint_, device_, command1_, command2_, value1_, value2_, value3_, arg_)
--[[ command1_ - tumbler's up command,
	 command2_ - tumbler's down command
	 value1_ - tumbler's up position
	 value2_ - center position
	 value3_ - tumbler's down position
]]
	return	{
        class 		= {class_type.TUMB, class_type.TUMB},
        hint 		= hint_,
        device 		= device_,
        action 	= {command1_ ,	command2_},
        stop_action = {command1_, 	command2_},
        arg 		= {arg_,		arg_},
        stop_value 	= {value2_,			value2_},
        arg_value 	= {value1_, 	value3_},
        arg_lim 	= {{value1_, value2_}, {value3_, value2_}},
        use_release_message = {false, false},
		
		sound = {{SOUND_TINY_KNOB_BETTER},{SOUND_TINY_KNOB_BETTER}}
    }
end

elements = {}

-- hydraulics
elements["PNT_629"] = default_2_position_tumb(_("Hydraulic Transfer Pump Switch"), devices.HYDRAULICS, device_commands.HYD_TRANSFER_PUMP_Switch, cockpit_args.HYD_TRANSFER_PUMP_Switch, pilot_only)
elements["PNT_630"] = default_flipcover(_("Hydraulic Transfer Pump Switch Cover"), devices.HYDRAULICS, device_commands.HYD_TRANSFER_PUMP_SwitchCover, cockpit_args.HYD_TRANSFER_PUMP_SwitchCover)
elements["PNT_630"].crew_member_access = pilot_only
elements["PNT_631"] = default_2_position_tumb(_("Hydraulic Isolation Switch"), devices.HYDRAULICS, device_commands.HYD_ISOL_Switch, cockpit_args.HYD_ISOLATION_Switch, pilot_only)
elements["PNT_928"] = default_3_position_tumb(_("Hydraulic Emergency Flight Control Switch"), devices.HYDRAULICS, device_commands.HYD_EMERG_FLT_Switch, cockpit_args.HYD_EMERGENCY_FLT_Switch, false, false, pilot_only)
elements["PNT_8100"] = default_flipcover(_("Hydraulic Emergency Flight Control Switch Cover"), devices.HYDRAULICS, device_commands.HYD_EMERG_FLT_SwitchCover, cockpit_args.HYD_EMERGENCY_FLT_SwitchCover)
elements["PNT_8100"].crew_member_access = pilot_only
elements["PNT_632"] =   {
        class 				 = {class_type.TUMB},
        hint 				 = _("Hydraulic Hand Pump"),
        device 				 = devices.HYDRAULICS,
        action 				 = {device_commands.HYD_HandPump},
        stop_action 		 = {device_commands.HYD_HandPump},
        stop_value           = {0},
        arg 				 = {cockpit_args.HANDPUMP_DUMMY},
        arg_value			 = {1},
        arg_lim 			 = {{0,1}},
        use_release_message = {false},
        updatable 	 = false,   }

-- MASTER RESET
elements["PNT_1071"] = default_button(_("MASTER RESET"), devices.CADC, device_commands.MASTER_Reset, cockpit_args.MASTER_Reset, nil, nil, pilot_only)

-- AICS
elements["PNT_2100"] = default_2_position_tumb(_("Stow Inlet Ramps Left Switch"), devices.AICS, device_commands.INLET_RAMPS_LeftSwitch, cockpit_args.INLET_RAMPS_LeftSwitch, pilot_only)
elements["PNT_2101"] = default_2_position_tumb(_("Stow Inlet Ramps Right Switch"), devices.AICS, device_commands.INLET_RAMPS_RightSwitch, cockpit_args.INLET_RAMPS_RightSwitch, pilot_only)

-- Wing sweep
elements["PNT_317"] = default_animated_lever(_("Emergency Wing Sweep Handle Cover"), devices.WINGSWEEP, device_commands.WINGSWEEP_EmergencySweepCover, cockpit_args.WINGSWEEP_EmergencySweepCover, 3, {0.0,1.0}, pilot_only)
elements["PNT_317"].sound = {{SOUND_WINGSWEEP_COVER_OPEN,SOUND_WINGSWEEP_COVER_CLOSE},{SOUND_WINGSWEEP_COVER_OPEN,SOUND_WINGSWEEP_COVER_CLOSE}}

--elements["PNT_384"] = default_axis(_("Emergency Wing Sweep Handle"),devices.WINGSWEEP, device_commands.WINGSWEEP_EmergencySweepLever, cockpit_args.WINGSWEEP_EmergencySweepLever, 1.0, 0.1, true, false)


elements["PNT_384"] =              {
        class = {class_type.LEV, class_type.TUMB},
        hint = _("Emergency Wing Sweep Handle (Click to pop out)"),
        device = devices.WINGSWEEP,
        action = {device_commands.WINGSWEEP_EmergencySweepLever, device_commands.WINGSWEEP_EmergencyLeverExtended},
        --  stop_action = {device_commands.RADARALT_Test, 0},
        arg = {cockpit_args.WINGSWEEP_EmergencySweepLever, cockpit_args.Wingsweep_Lever_Popout},
        arg_value = {1.0, -1.0 },
        arg_lim = {{0, 1}, {0, 1}},
        relative = {false, false},
        gain = {0.1, 1.0, 0.5},
        use_release_message = {false, true},
        updatable = true,
        cycle 	=  {false,true},
        animated 	 = {false, true},
        animation_speed = {2.5, 2.5},
        crew_member_access = pilot_only,
        use_OBB = true }



--Radar altimeter

elements["PNT_308"] =              {
    class = {class_type.BTN, class_type.LEV},
    hint = _("Radar Altimeter Control Knob"),
    device = devices.RADARALTIMETER,
    action = {device_commands.RADARALT_Test, device_commands.RADARALT_Knob},
    stop_action = {device_commands.RADARALT_Test, 0},
    is_repeatable = {},
    arg = {cockpit_args.ALTI_Radar_KnobPush, cockpit_args.ALTI_Radar_Knob},
    arg_value = {1.0, 0.5 },
    arg_lim = {{0, 1}, {0, 1}},
    relative = {false,true},
    gain = {1.0, 0.5},
    use_release_message = {true, false},
    use_OBB = true }


-- Airspeed indicator
elements["PNT_310"] =              {
    class = {class_type.TUMB, class_type.LEV},
    hint = _("Airspeed Indicator Bug Knob"),
    device = devices.MACHANDAIRSPEED,
    action = {device_commands.AIRSPEED_KnobSwitch, device_commands.AIRSPEED_Knob},
    is_repeatable = {},
    arg = {cockpit_args.AIRSPD_KnobPush, cockpit_args.AIRSPD_Knob},
    arg_value = {1.0, 0.5 },
    arg_lim = {{0, 1}, {0, 1}},
    relative = {false,true},
    gain = {1.0, 0.5},
    use_release_message = {true, false},
    use_OBB = true }

    -- Airspeed indicator RIO bugs
elements["PNT_254"] =              {
    class = {class_type.TUMB, class_type.LEV},
    hint = _("Airspeed Indicator Bug Knob"),
    device = devices.MACHANDAIRSPEED,
    action = {device_commands.AIRSPEED_KnobSwitch_RIO, device_commands.AIRSPEED_Knob_RIO},
    is_repeatable = {},
    arg = {cockpit_args.AIRSPD_KnobPush_RIO, cockpit_args.AIRSPD_Knob_RIO},
    arg_value = {1.0, 0.5 },
    arg_lim = {{0, 1}, {0, 1}},
    relative = {false,true},
    gain = {1.0, 0.5},
    use_release_message = {true, false},
    use_OBB = true }




--Altimeter
elements["PNT_307"] = default_springloaded_3pos_switch(_("Altimeter Mode Switch"), devices.BAROALTIMETER, device_commands.ALTIMETER_Mode, device_commands.ALTIMETER_Mode, -1, 0, 1, cockpit_args.ALTI_RightKnob)
elements["PNT_306"] = default_axis(_("Altimeter Pressure Setting"), devices.BAROALTIMETER, device_commands.ALTIMETER_Knob, cockpit_args.ALTI_LeftKnob, 0, 0.5, false, true)

--RIO Altimeter
elements["PNT_20307"] = default_springloaded_3pos_switch(_("Altimeter Mode Switch"), devices.BAROALTIMETER, device_commands.RIOALTIMETER_Mode, device_commands.RIOALTIMETER_Mode, -1, 0, 1, cockpit_args.RIOALTI_RightKnob)
elements["PNT_20306"] = default_axis(_("Altimeter Pressure Setting"), devices.BAROALTIMETER, device_commands.RIOALTIMETER_Knob, cockpit_args.RIOALTI_LeftKnob, 0, 0.5, false, true)

--Gear
--elements["PNT_326"] = default_animated_lever(_("Landing Gear Lever"), devices.GEARHOOK, device_commands.GEAR_Handle, cockpit_args.GEAR_Handle, 1, {0.0,1.0})
--elements["PNT_326"].sound = {{SOUND_GEAR_HANDLE},{SOUND_GEAR_HANDLE}}
elements["PNT_326"] =              {
        class = {class_type.TUMB, class_type.TUMB},
        hint = _("Landing Gear Lever (RB emergency extend)"),
        device = devices.GEARHOOK,
        action = {device_commands.GEAR_Handle, device_commands.GEAR_Handle_Emergency },
        arg = {cockpit_args.GEAR_Handle, cockpit_args.GEAR_HandleEmergency},
        arg_value = {1.0, 1.0},
        arg_lim = {{0, 1}, {0, 1}},
        relative = {false, false, false},
        gain = {0.1, 1.0},
        use_release_message = {true, true},
        updatable = true,
        cycle   =  {false,true},
        animated     = {true, true},
        animation_speed = {1.5, 1.5},
        crew_member_access = pilot_only,
        sound = {{SOUND_HOLLOW_LEVER_OPEN,SOUND_HOLLOW_LEVER_CLOSE},{SOUND_HOLLOW_LEVER_OPEN,SOUND_HOLLOW_LEVER_CLOSE}},
        use_OBB = true }


--elements["PNT_1075"] = default_springloaded_3pos_switch(_("Nose Strut Compression Switch"),devices.GEARHOOK, device_commands.GEAR_Strut, device_commands.GEAR_Strut, -1,0,1, cockpit_args.GEAR_Strut)
elements["PNT_1075"] = default_3_position_tumb(_("Nose Strut Compression Switch"), devices.GEARHOOK, device_commands.GEAR_Strut, cockpit_args.GEAR_Strut, false, false, pilot_only)


elements["PNT_497"] = default_button(_("Launch Bar Abort"), devices.GEARHOOK, device_commands.GEAR_LaunchBarAbort, cockpit_args.GEAR_LaunchBarAbort)
elements["PNT_496"] = default_flipcover(_("Launch Bar Abort Switch Cover"), devices.GEARHOOK, device_commands.GEAR_LaunchBarAbortCover, cockpit_args.GEAR_LaunchBarAbortCover)



--Hook
--elements["PNT_238"] = default_animated_lever(_("Hook Lever"), devices.GEARHOOK, device_commands.HOOK_Handle, cockpit_args.HOOK_Handle, 1, {0.0,1.0})

elements["PNT_238"] =              {
        class = {class_type.TUMB, class_type.TUMB},
        hint = _("Hook Extension Handle (RB cycle emergency mode)"),
        device = devices.GEARHOOK,
        action = {device_commands.HOOK_Handle, device_commands.HOOK_Handle_Emergency },
        arg = {cockpit_args.HOOK_Handle, cockpit_args.HOOK_EmergencyDown},
        arg_value = {1.0, 1.0},
        arg_lim = {{0, 1}, {0, 1}},
        relative = {false, false, false},
        gain = {0.1, 1.0},
        use_release_message = {true, true},
        updatable = true,
        cycle 	=  {false,true},
        animated 	 = {true, true},
        animation_speed = {3.2, 3.2},
        crew_member_access = pilot_only,
        sound = {{SOUND_CLUNKY_LEVER1,SOUND_CLUNKY_LEVER1},{SOUND_CLUNKY_LEVER1,SOUND_CLUNKY_LEVER1}},
        use_OBB = true  }

-- Brakes
elements["PNT_1072"] = default_3_position_tumb(_("Anti-Skid Spoiler BK Switch"), devices.GEARHOOK, device_commands.BRAKE_AntiSkidAndSpoilerBrake, cockpit_args.BRAKE_AntiSkidAndSpoilerBrake, false, true, pilot_only)
elements["PNT_237"] = default_animated_lever(_("Parking Brake Handle"), devices.GEARHOOK, device_commands.BRAKE_ParkingBrake, cockpit_args.BRAKE_ParkingBrake, 3.5, {0.0,1.0}, pilot_only)
elements["PNT_237"].sound =  {{SOUND_WINGSWEEP_COVER_OPEN,SOUND_WINGSWEEP_COVER_CLOSE},{SOUND_WINGSWEEP_COVER_OPEN,SOUND_WINGSWEEP_COVER_CLOSE}}

elements["PNT_633"] = default_animated_lever(_("Gear Down Lock Override"), devices.GEARHOOK, device_commands.GEAR_DownLockOverride, cockpit_args.GR_DN_LOCK_ORIDE, 3.5, {0.0,1.0}, pilot_only)

-- SAS
elements["PNT_2106"] = default_2_position_tumb(_("AFCS Stability Augmentation - Pitch"), devices.AFCS, device_commands.AFCS_Stability_Pitch, cockpit_args.AFCS_Stability_Pitch, pilot_only)
elements["PNT_2107"] = default_2_position_tumb(_("AFCS Stability Augmentation - Roll"), devices.AFCS, device_commands.AFCS_Stability_Roll, cockpit_args.AFCS_Stability_Roll, pilot_only)
elements["PNT_2108"] = default_2_position_tumb(_("AFCS Stability Augmentation - Yaw"), devices.AFCS, device_commands.AFCS_Stability_Yaw, cockpit_args.AFCS_Stability_Yaw, pilot_only)

-- Autopilot
elements["PNT_2109"] = default_3_position_tumb(_("Autopilot - Vector / Automatic Carrier Landing"), devices.AFCS, device_commands.AP_Vector, cockpit_args.AP_Vector, false, true, pilot_only)
elements["PNT_2110"] = default_2_position_tumb(_("Autopilot - Altitude Hold"), devices.AFCS, device_commands.AP_Altitude, cockpit_args.AP_Altitude, pilot_only)
elements["PNT_2111"] = default_3_position_tumb(_("Autopilot - Heading / Ground Track"), devices.AFCS, device_commands.AP_Heading, cockpit_args.AP_Heading, false, true, pilot_only)
elements["PNT_2112"] = default_2_position_tumb(_("Autopilot - Engage"), devices.AFCS, device_commands.AP_Engage, cockpit_args.AP_Engage, pilot_only)
elements["PNT_2112"].arg_lim  = {{-1,1},{-1,1}}
elements["PNT_2112"].arg_value  = {2,-2}

-- Flaps
--elements["PNT_225"] = multiposition_switch(_("Flaps lever"),devices.FLAPS,device_commands.FLAPS_Lever,225,4,0.25, false)
elements["PNT_225"] = default_axis(_("Flaps Lever"), devices.FLAPS, device_commands.FLAPS_Lever, cockpit_args.FLAP_Lever, 1.0, 0.1, true, false, nil, pilot_only)


-- Engine
elements["PNT_THROT_L"] = default_2_position_tumb(_("Left Engine Fuel Cutoff"), devices.ENGINE, device_commands.THROTTLE_Left_Throttle_CutOff, 12300, pilot_only) --stupid high arg
elements["PNT_THROT_L"].sound = {{},{}}
elements["PNT_THROT_R"] = default_2_position_tumb(_("Right Engine Fuel Cutoff"), devices.ENGINE, device_commands.THROTTLE_Right_Throttle_CutOff, 12301, pilot_only)
elements["PNT_THROT_R"].sound = {{},{}}

elements["PNT_2104"] = default_3_position_tumb(_("Throttle Mode"), devices.ENGINE, device_commands.ENGINE_Throttle_Mode, cockpit_args.ENGINE_Throttle_Mode, false, true, pilot_only)
elements["PNT_2103"] = default_3_position_tumb(_("Throttle Temp"), devices.ENGINE, device_commands.ENGINE_Throttle_Temp, cockpit_args.ENGINE_Throttle_Temp, false, true, pilot_only)

--elements[""] = default_2_position_tumb(_("Mid compression bypass test"), devices.ENGINE, device_commands.ENGINE_Mid_Compression_Bypass_Test, 2108)
elements["PNT_941"] = default_3_position_tumb(_("Engine/Probe Anti-Ice"), devices.ENGINE, device_commands.ENGINE_Probe_Anti_Ice, cockpit_args.ENGINE_Probe_Anti_Ice, false ,true)


elements["PNT_2105"] = default_2_position_tumb(_("Engine Airstart"), devices.ENGINE, device_commands.ENGINE_Air_Start, cockpit_args.ENGINE_Air_Start)  -- temp since i dont have the right switches for B
--elements["PNT_2105"] = default_2_position_tumb(_("Engine Backup Ignition"), devices.ENGINE, device_commands.ENGINE_Backup_Ignition, cockpit_args.ENGINE_Backup_Ignition)
elements["PNT_2102"] = default_3_position_tumb(_("Engine Crank"), devices.ENGINE, device_commands.ENGINE_Crank, cockpit_args.ENGINE_Crank, false, false)
elements["PNT_16007"] = default_2_position_tumb(_("Left Engine Mode"), devices.ENGINE, device_commands.ENGINE_Left_Mode, cockpit_args.ENG_Mode_L, pilot_only)  -- temp since i dont have the right switches for B
elements["PNT_16008"] = default_2_position_tumb(_("Right Engine Mode"), devices.ENGINE, device_commands.ENGINE_Right_Mode, cockpit_args.ENG_Mode_R, pilot_only)  -- temp since i dont have the right switches for B
elements["PNT_MCB"] = default_2_position_tumb(_("Mid Compression Bypass Test"), devices.ENGINE, device_commands.ENGINE_Mid_Compression_Bypass_Test, cockpit_args.MCB_Panel_Switch, rio_only) 

elements["PNT_16005"] = default_2_position_tumb(_("Asymmetric Thrust Limiter Cover"), devices.ENGINE, device_commands.ENGINE_Asym_LimiterCover, cockpit_args.ASYM_Limiter_Flipcover)
elements["PNT_16006"] = default_2_position_tumb(_("Asymmetric Thrust Limiter"), devices.ENGINE, device_commands.ENGINE_Asym_Limiter, cockpit_args.ASYM_Limiter_Switch)

-- Fire system
elements["PNT_FIRE_EXT_SW_L"] = default_button(_("Fire Ext Bottle - Left"), devices.FIRE, device_commands.FIRE_Bottle_Fire_L, cockpit_args.Fire_Ext_Button_Left)
elements["PNT_FIRE_EXT_SW_L"].updatable = true
elements["PNT_FIRE_EXT_SW_R"] = default_button(_("Fire Ext Bottle - Right"), devices.FIRE, device_commands.FIRE_Bottle_Fire_R, cockpit_args.Fire_Ext_Button_Right)
elements["PNT_FIRE_EXT_SW_R"].updatable = true

-- Fuel system
elements["PNT_1044"] = default_animated_lever(_("Fuel Shutoff - Right"), devices.FUELSYSTEM, device_commands.FUELSYSTEM_Shutoff_R, cockpit_args.Fire_Ext_Handle_Right,6.0,{0.0,1.0},pilot_only)
elements["PNT_15081"] = default_animated_lever(_("Fuel Shutoff - Left"), devices.FUELSYSTEM, device_commands.FUELSYSTEM_Shutoff_L, cockpit_args.Fire_Ext_Handle_Left,6.0,{0.0,1.0},pilot_only)

--elements["PNT_1076"] = default_3_position_tumb(_("Fuel Qty Sel"), devices.FUELSYSTEM, device_commands.FUELSYSTEM_Fuel_Qty_Sel, 1076, false, false)

elements["PNT_1094"] = default_flipcover(_("Fuel Feed Cover"), devices.FUELSYSTEM, device_commands.FUELSYSTEM_Fuel_Feed_Cover, cockpit_args.FUELSYSTEM_Fuel_Feed_Cover)
elements["PNT_1094"].crew_member_access = pilot_only
elements["PNT_1095"] = default_3_position_tumb(_("Fuel Feed"), devices.FUELSYSTEM, device_commands.FUELSYSTEM_Fuel_Feed, cockpit_args.FUELSYSTEM_Fuel_Feed, false, false, pilot_only)

elements["PNT_1001"] = default_3_position_tumb(_("Wing/Ext Trans"), devices.FUELSYSTEM, device_commands.FUELSYSTEM_WingExt_Trans, cockpit_args.FUELSYSTEM_WingExt_Trans, false, true, pilot_only)
elements["PNT_1074"] = default_2_position_tumb(_("Fuel Dump"), devices.FUELSYSTEM, device_commands.FUELSYSTEM_Dump, cockpit_args.FUELSYSTEM_Dump, pilot_only)
elements["PNT_1073"] = default_3_position_tumb(_("Refuel Probe"), devices.FUELSYSTEM, device_commands.FUELSYSTEM_Refuel_Probe, cockpit_args.FUELSYSTEM_Refuel_Probe, false, true, pilot_only)

elements["PNT_1076"] = default_springloaded_3pos_switch(_("Fuel Quantity Selector"), devices.FUELSYSTEM, device_commands.FUELSYSTEM_Fuel_Qty_Sel, device_commands.FUELSYSTEM_Fuel_Qty_Sel, -1, 0, 1, cockpit_args.FUELSYSTEM_Fuel_Qty_Sel)
elements["PNT_1076"].crew_member_access = pilot_only
elements["PNT_1050"] = default_axis(_("BINGO Fuel Level Knob"), devices.FUELSYSTEM, device_commands.FUELSYSTEM_Bingo_Knob, cockpit_args.RIO_Adjust_Mirror, 1, 0.1, true, true)
-- Fuel system


-- Electrics
elements["PNT_937"] = default_3_position_tumb(_("Left Generator Switch"),devices.ELECTRICS, device_commands.ELEC_MASTER_GEN_LeftSwitch, cockpit_args.ELEC_MASTER_GEN_LeftSwitch, false, true, pilot_only)
elements["PNT_936"] = default_3_position_tumb(_("Right Generator Switch"),devices.ELECTRICS, device_commands.ELEC_MASTER_GEN_RightSwitch, cockpit_args.ELEC_MASTER_GEN_RightSwitch, false, true, pilot_only)
elements["PNT_927"] = default_flipcover(_("Emergency Generator Switch Cover"),devices.ELECTRICS, device_commands.ELEC_EMERG_GEN_SwitchCover, cockpit_args.ELEC_EMERG_GEN_SwitchCover)
elements["PNT_927"].crew_member_access = pilot_only
elements["PNT_926"] = default_2_position_tumb(_("Emergency Generator Switch"),devices.ELECTRICS, device_commands.ELEC_EMERG_GEN_Switch, cockpit_args.ELEC_EMERG_GEN_Switch, pilot_only)


--Cockpit mechanics
elements["PNT_224"] = default_animated_lever(_("Canopy Jettison"), devices.COCKPITMECHANICS, device_commands.CANOPY_Drop, cockpit_args.CANOPY_Jettison,5, {0.0,1.0})
elements["PNT_224"].sound = {{SOUND_GEAR_HANDLE, SOUND_AFK_HANDLE},{SOUND_GEAR_HANDLE, SOUND_AFK_HANDLE}}
elements["PNT_2051"] = default_animated_lever(_("RIO Canopy Jettison"), devices.COCKPITMECHANICS, device_commands.CANOPY_Drop_RIO, cockpit_args.RIO_Canopy_JETT,5, {0.0,1.0})
elements["PNT_2051"].sound = {{SOUND_GEAR_HANDLE, SOUND_AFK_HANDLE},{SOUND_GEAR_HANDLE, SOUND_AFK_HANDLE}}

elements["PNT_HUDCAM"] = default_2_position_tumb(_("Show/Hide HUD camera"),devices.COCKPITMECHANICS, device_commands.HUD_ShowHide, cockpit_args.HIDE_Guncam, pilot_only)

elements["PNT_2049"] = default_animated_lever(_("Ejection CMD Lever"), devices.COCKPITMECHANICS, device_commands.EJECT_CMD_Lever, cockpit_args.EJECT_CMD_Lever, 3, {0.0,1.0})
elements["PNT_2049"].sound = {{SOUND_WINGSWEEP_COVER_OPEN,SOUND_WINGSWEEP_COVER_CLOSE},{SOUND_WINGSWEEP_COVER_OPEN,SOUND_WINGSWEEP_COVER_CLOSE}}


elements["PNT_Seat_Safety"] = default_animated_lever(_("Ejection Seat Safety"), devices.COCKPITMECHANICS, device_commands.EJECT_ArmPilot, cockpit_args.Pilot_Seat_Safety,5, {0.0,1.0}, pilot_only)
elements["PNT_Seat_Safety"].sound = {{SOUND_METALLICCOVER, SOUND_METALLICCOVER},{SOUND_METALLICCOVER, SOUND_METALLICCOVER}}

elements["PNT_498"] = default_animated_lever(_("Ejection Seat Safety"), devices.COCKPITMECHANICS, device_commands.EJECT_ArmRIO, cockpit_args.RIO_SEAT_SAFETY,5, {0.0,1.0}, rio_only)
elements["PNT_498"].sound = {{SOUND_METALLICCOVER, SOUND_METALLICCOVER},{SOUND_METALLICCOVER, SOUND_METALLICCOVER}}


elements["PNT_122"] = default_animated_lever(_("Storage"), devices.COCKPITMECHANICS, device_commands.RIO_STORAGE_BOX, cockpit_args.RIO_STORAGE_BOX, 3, {0.0,1.0})
elements["PNT_122"].sound = {{SOUND_WINGSWEEP_COVER_OPEN,SOUND_WINGSWEEP_COVER_CLOSE},{SOUND_WINGSWEEP_COVER_OPEN,SOUND_WINGSWEEP_COVER_CLOSE}}


--Enivornment control
elements["PNT_8114"] = default_2_position_tumb(_("Pilot Oxygen On"),devices.COCKPITMECHANICS, device_commands.PilotOxygenOn, cockpit_args.ENVIRO_PilotOxygenOn, pilot_only)
elements["PNT_119"] = default_2_position_tumb(_("RIO Oxygen On"),devices.COCKPITMECHANICS, device_commands.RIOOxygenOn, cockpit_args.ENVIRO_RIOOxygenOn)
elements["PNT_939"] = default_2_position_tumb(_("Cabin Pressure Dump"),devices.COCKPITMECHANICS, device_commands.CabinPressureDump, cockpit_args.ENVIRO_CabinPressureDump, pilot_only)
elements["PNT_929"] = default_displaybutton(_("Air Source Ram"),devices.COCKPITMECHANICS, device_commands.AirSourceRam, cockpit_args.ENVIRO_AirSourceRam, pilot_only)
elements["PNT_933"] = default_displaybutton(_("Air Source Off"),devices.COCKPITMECHANICS, device_commands.AirSourceOff, cockpit_args.ENVIRO_AirSourceOff, pilot_only)
elements["PNT_930"] = default_displaybutton(_("Air Source Left Engine"),devices.COCKPITMECHANICS, device_commands.AirSourceLEng, cockpit_args.ENVIRO_AirSourceLEng, pilot_only)
elements["PNT_931"] = default_displaybutton(_("Air Source Right Engine"),devices.COCKPITMECHANICS, device_commands.AirSourceREng, cockpit_args.ENVIRO_AirSourceREng, pilot_only)
elements["PNT_932"] = default_displaybutton(_("Air Source Both Engines"),devices.COCKPITMECHANICS, device_commands.AirSourceBoth, cockpit_args.ENVIRO_AirSourceBoth, pilot_only)
elements["PNT_942"] = default_3_position_tumb(_("Wind Shield Air"), devices.COCKPITMECHANICS, device_commands.WindShield_Air, cockpit_args.WINDSHIELD_AIR, false ,true, pilot_only)
elements["PNT_950"] = multiposition_switch_limited(_("Temperature"), devices.COCKPITMECHANICS, device_commands.Temperature, cockpit_args.TEMPERATURE, 9, 0.125, false, 0)
elements["PNT_950"].sound = {{SOUND_SPRINGY2_KNOB},{SOUND_SPRINGY2_KNOB}}
elements["PNT_950"].crew_member_access = pilot_only

elements["PNT_940"] = default_2_position_tumb(_("Temp Auto / Man"),devices.COCKPITMECHANICS, device_commands.TempAutoMan, cockpit_args.TEMPMANAUTO, pilot_only)
elements["PNT_938"] = default_2_position_tumb(_("Ram Air"),devices.COCKPITMECHANICS, device_commands.RamAir, cockpit_args.RAMAIR, pilot_only)

--Movable Mirrors
elements["PNT_RIO_MIRROR_MOVE"] = default_axis(_("Adjust RIO Mirror"), devices.COCKPITMECHANICS, device_commands.Adjust_RIO_Mirror, cockpit_args.RIO_Adjust_Mirror, 0, 0.1, true, false)

elements["PNT_PILOT_MIRROR_MOVE_TOP"] = default_axis(_("Adjust Top Mirror"), devices.COCKPITMECHANICS, device_commands.Adjust_Pilot_Mirror_T, cockpit_args.Pilot_Adjust_Mirror_T, 0, 0.1, true, false)
elements["PNT_PILOT_MIRROR_MOVE_LEFT"] = default_axis(_("Adjust Right Mirror"), devices.COCKPITMECHANICS, device_commands.Adjust_Pilot_Mirror_L, cockpit_args.Pilot_Adjust_Mirror_L, 0, 0.1, true, false)
elements["PNT_PILOT_MIRROR_MOVE_RIGHT"] = default_axis(_("Adjust Left Mirror"), devices.COCKPITMECHANICS, device_commands.Adjust_Pilot_Mirror_R, cockpit_args.Pilot_Adjust_Mirror_R, 0, 0.1, true, false)


-- BIT panel
elements["PNT_934"] =              {
    class = {class_type.TUMB, class_type.TUMB},
    hint = _("Master Test Selector (LB to rotate, RB to pull/push)"),
    device = devices.BITPANEL,
    action = {device_commands.BIT_Selector, device_commands.BIT_SelectorPush},
    arg = {cockpit_args.BIT_Selector, cockpit_args.Master_test_knob_push },
    arg_value =  {1/11 , 1.0 },
    arg_lim = {{0, 10/11}, {0, 1}},
    relative = {false, false},
    use_release_message = {true, true},
    use_OBB = true,
    sound = {{SOUND_SPRINGY2_KNOB},{SOUND_SPRINGY2_KNOB}},
    cycle =  {false, true}
 }


--Light panel
elements["PNT_915"] = default_2_position_tumb(_("Hook Bypass"), devices.AOASYSTEM, device_commands.AoA_HookBypass, cockpit_args.AoA_HookBypass, pilot_only)
elements["PNT_918"] = default_2_position_tumb(_("Taxi Light"), devices.COCKPITMECHANICS, device_commands.LIGHTS_Taxi, cockpit_args.LIGHT_Taxi, pilot_only)
elements["PNT_924"] = default_3_position_tumb(_("Red Flood Light"), devices.COCKPITMECHANICS, device_commands.LIGHTS_RedFlood, cockpit_args.LIGHT_RedFloodSwitch, false, true, pilot_only)
elements["PNT_921"] = default_3_position_tumb(_("White Flood Light"), devices.COCKPITMECHANICS, device_commands.LIGHTS_WhiteFlood, cockpit_args.LIGHT_WhiteFloodSwitch, false, true, pilot_only)
elements["PNT_913_22"] = default_3_position_tumb(_("Position Lights Wing"), devices.COCKPITMECHANICS, device_commands.LIGHTS_PositionWings, cockpit_args.LIGHTS_PositionWings, false, true, pilot_only)
elements["PNT_916"] = default_3_position_tumb(_("Position Lights Tail"), devices.COCKPITMECHANICS, device_commands.LIGHTS_PositionTail, cockpit_args.LIGHTS_PositionTail, false, true, pilot_only)
elements["PNT_919"] = default_2_position_tumb(_("Position Lights Flash"), devices.COCKPITMECHANICS, device_commands.LIGHTS_PositionFlash, cockpit_args.LIGHTS_PositionFlash, pilot_only)
elements["PNT_923"] = default_2_position_tumb(_("Anti-Collision Lights"), devices.COCKPITMECHANICS, device_commands.LIGHTS_AntiCol, cockpit_args.LIGHTS_AntiCol, pilot_only)

elements["PNT_917"] = multiposition_switch_limited(_("AoA Indexer Light Intensity"), devices.AOASYSTEM, device_commands.AoA_IndexerStrength, cockpit_args.LIGHTS_INDEXER, 9, 0.125, false, 0, pilot_only)
elements["PNT_917"].sound = {{SOUND_SPRINGY2_KNOB},{SOUND_SPRINGY2_KNOB}}

elements["PNT_913"] = multiposition_switch_limited(_("ACM Panel Light Intensity"), devices.COCKPITMECHANICS, device_commands.LIGHTS_ACMPanel, cockpit_args.LIGHTS_ACM, 9, 0.125, false, 0, pilot_only)
elements["PNT_913"].sound = {{SOUND_SPRINGY2_KNOB},{SOUND_SPRINGY2_KNOB}}

elements["PNT_920"] = multiposition_switch_limited(_("Instrument Light Intensity"), devices.COCKPITMECHANICS, device_commands.LIGHTS_Instruments, cockpit_args.LIGHTS_INSTRUMENT, 9, 0.125, false, 0, pilot_only)
elements["PNT_920"].sound = {{SOUND_SPRINGY2_KNOB},{SOUND_SPRINGY2_KNOB}}

elements["PNT_922"] = multiposition_switch_limited(_("Console Light Intensity"), devices.COCKPITMECHANICS, device_commands.LIGHTS_Console, cockpit_args.LIGHTS_CONSOLE, 9, 0.125, false, 0, pilot_only)
elements["PNT_922"].sound = {{SOUND_SPRINGY2_KNOB},{SOUND_SPRINGY2_KNOB}}

elements["PNT_925"] = multiposition_switch_limited(_("Formation Light Intensity"), devices.COCKPITMECHANICS, device_commands.LIGHTS_Formation, cockpit_args.LIGHTS_FORMATION, 9, 0.125, false, 0, pilot_only)
elements["PNT_925"].sound = {{SOUND_SPRINGY2_KNOB},{SOUND_SPRINGY2_KNOB}}

--Light panel RIO
elements["PNT_194"] = default_3_position_tumb(_("Red Flood Light"), devices.COCKPITMECHANICS, device_commands.LIGHTS_RedFlood_RIO, cockpit_args.LIGHT_RedFloodSwitch_RIO, false, true)
elements["PNT_159"] = default_3_position_tumb(_("White Flood Light"), devices.COCKPITMECHANICS, device_commands.LIGHTS_WhiteFlood_RIO, cockpit_args.LIGHT_WhiteFloodSwitch_RIO, false, true)
elements["PNT_193"] = multiposition_switch_limited(_("Instrument Light Intensity"), devices.COCKPITMECHANICS, device_commands.LIGHTS_Instruments_RIO, cockpit_args.LIGHTS_INSTRUMENT_RIO, 9, 0.125, false, 0)
elements["PNT_193"].sound = {{SOUND_SPRINGY2_KNOB},{SOUND_SPRINGY2_KNOB}}
elements["PNT_192"] = multiposition_switch_limited(_("Console Light Intensity"), devices.COCKPITMECHANICS, device_commands.LIGHTS_Console_RIO, cockpit_args.LIGHTS_CONSOLE_RIO, 9, 0.125, false, 0)
elements["PNT_192"].sound = {{SOUND_SPRINGY2_KNOB},{SOUND_SPRINGY2_KNOB}}


-- DISPLAY Panel: Power
elements["PNT_1010"] = default_2_position_tumb(_("VDI Power On/Off"),devices.VDI, device_commands.DISP_VDI_power, cockpit_args.DISP_VDI_power, pilot_only)
elements["PNT_1009"] = default_2_position_tumb(_("HUD Power On/Off"),devices.HUD, device_commands.DISP_HUD_power, cockpit_args.DISP_HUD_power, pilot_only)
elements["PNT_1008"] = default_2_position_tumb(_("HSD/ECMD Power On/Off"),devices.HSD, device_commands.DISP_HSD_ECMD_power, cockpit_args.DISP_HSD_ECMD_power, pilot_only)

-- DISPLAY Panel: Steer CMD
elements["PNT_1002"] = default_displaybutton(_("Navigation Steer Commands: TACAN"), devices.NAV_INTERFACE, device_commands.NAV_Btn_Steer_TCN, cockpit_args.NAV_Btn_Steer_TCN, pilot_only)
elements["PNT_1003"] = default_displaybutton(_("Navigation Steer Commands: Destination"), devices.NAV_INTERFACE, device_commands.NAV_Btn_Steer_DEST, cockpit_args.NAV_Btn_Steer_DEST, pilot_only)
elements["PNT_1004"] = default_displaybutton(_("Navigation Steer Commands: AWL PCD"), devices.NAV_INTERFACE, device_commands.NAV_Btn_Steer_AWL_PCD, cockpit_args.NAV_Btn_Steer_AWL_PCD, pilot_only)
elements["PNT_1005"] = default_displaybutton(_("Navigation Steer Commands: Vector"), devices.NAV_INTERFACE, device_commands.NAV_Btn_Steer_VEC, cockpit_args.NAV_Btn_Steer_VEC, pilot_only)
elements["PNT_1006"] = default_displaybutton(_("Navigation Steer Commands: Manual"), devices.NAV_INTERFACE, device_commands.NAV_Btn_Steer_MAN, cockpit_args.NAV_Btn_Steer_MAN, pilot_only)

-- DISPLAY Panel: HSD
elements["PNT_1016"] = default_2_position_tumb(_("HSD Display Mode"), devices.HSD, device_commands.HSD_Display_Mode_Cycle, cockpit_args.HSD_Display_Mode_Cycle, pilot_only)
elements["PNT_1017"] = default_2_position_tumb(_("HSD ECM Override"), devices.HSD, device_commands.HSD_ECM_Override, cockpit_args.HSD_ECM_Override, pilot_only)

-- HSD
elements["PNT_1039"] = default_axis(_("HSD Selected Heading"), devices.HSD, device_commands.HSD_Knob_Heading, cockpit_args.HSD_Knob_Heading, 0, 0.0194, false, true)
elements["PNT_1040"] = default_axis(_("HSD Selected Course"), devices.HSD, device_commands.HSD_Knob_Course, cockpit_args.HSD_Knob_Course, 0, 0.0194, false, true)
--elements["PNT_1040"] = default_axis_old(_("HSD Selected Course"), devices.HSD, device_commands.HSD_Knob_Course, cockpit_args.HSD_Knob_Course, 0, 0.05818, true, false, true)
elements["PNT_1043"] = default_axis(_("HSD Brightness"), devices.HSD, device_commands.HSD_Knob_Brightness, cockpit_args.HSD_Knob_Brightness, 0, 0.1, false, false)
elements["PNT_1041"] = default_button(_("HSD Test"), devices.HSD, device_commands.HSD_Btn_Test, cockpit_args.HSD_Test)


-- ECMD
elements["PNT_2023"] = default_axis(_("ECMD Brightness"), devices.ECMD, device_commands.ECMD_Knob_Brightness, cockpit_args.ECMD_Knob_Brightness, 0, 0.1, true, false)
elements["PNT_2024"] = default_button(_("ECMD Test"), devices.ECMD, device_commands.ECMD_Btn_Test, cockpit_args.ECMD_Btn_Test)
--elements["PNT_ECMD_KNOB"] = BIT button

-- ECMD Panel
--elements["PNT_189"] = default_2_position_tumb(_("ECM Display Mode"), devices.ECMD, device_commands.ECMD_Mode_Cycle, cockpit_args.ECMD_Mode_SW)
--elements["PNT_156"] = default_3_position_tumb(_("ECM Display Override"), devices.ECMD, device_commands.ECMD_Override_Cycle, cockpit_args.ECMD_Override_SW, false, false)
--elements["PNT_168"] = default_3_position_tumb(_("ECM Display Corr"), devices.ECMD, device_commands.ECMD_Corr_Cycle, cockpit_args.ECMD_Corr_SW, false, false)
--elements["PNT_190"] = default_3_position_tumb(_("ECM Display Data/ADF"), devices.ECMD, device_commands.ECMD_Data_ADF_Cycle, cockpit_args.ECMD_Data_ADF_SW, false, false)


-- TACAN CMD
elements["PNT_292"] = default_button(_("TACAN CMD Button"), devices.TACAN, device_commands.TACAN_CMD_Btn_Pilot, cockpit_args.PILOT_TACAN_Button)
elements["PNT_292"].crew_member_access = pilot_only
elements["PNT_135"] = default_button(_("TACAN CMD Button"), devices.TACAN, device_commands.TACAN_CMD_Btn_RIO, cockpit_args.TACAN_CMD_Btn_RIO)

-- TACAN Pilot Panel
elements["PNT_2041"] = multiposition_switch_limited(_("TACAN Mode"), devices.TACAN, device_commands.TACAN_Knob_Func_Pilot, cockpit_args.TACAN_Knob_Func_Pilot, 5, 0.25, false, nil, pilot_only)
elements["PNT_2036"] = default_axis(_("TACAN Volume"), devices.TACAN, device_commands.TACAN_Knob_Vol_Pilot, cockpit_args.TACAN_Knob_Vol_Pilot, 0, 0.1, false, false, nil, pilot_only)
elements["PNT_2042"] = default_2_position_tumb(_("TACAN Mode Normal/Inverse"), devices.TACAN, device_commands.TACAN_Mode_Norm_Inv_Pilot, cockpit_args.TACAN_Mode_Norm_Inv_Pilot, pilot_only)
elements["PNT_2042"].sound = {{SOUND_TINY_KNOB_BETTER},{SOUND_TINY_KNOB_BETTER}}
elements["PNT_2042"].arg_lim = {{-1,1},{-1,1}}
elements["PNT_2042"].arg_value = {2,-2}
elements["PNT_2043"] = default_2_position_tumb(_("TACAN Channel X/Y"), devices.TACAN, device_commands.TACAN_Mode_X_Y_Pilot, cockpit_args.TACAN_Mode_X_Y_Pilot)
elements["PNT_2043"].sound = {{SOUND_TINY_KNOB_BETTER},{SOUND_TINY_KNOB_BETTER}}
elements["PNT_2043"].arg_lim = {{-1,1},{-1,1}}
elements["PNT_2043"].arg_value = {2,-2}


elements["PNT_2115"] = default_button(_("TACAN BIT"), devices.TACAN, device_commands.TACAN_Btn_BIT_Pilot, cockpit_args.TACAN_Btn_BIT_Pilot)
elements["PNT_TACAN_OUTER_TWIST_PILOT"] = multiposition_switch_limited(_("TACAN Channel Wheel (Tens)"), devices.TACAN, device_commands.TACAN_Knob_Chnl_Tens_Pilot, cockpit_args.TACAN_Dial_Outer_Pilot, 13, 1/12, false, 0)
elements["PNT_TACAN_OUTER_TWIST_PILOT"].sound = {{SOUND_POSITION_KNOB},{SOUND_POSITION_KNOB}}

elements["PNT_TACAN_LEVER_PILOT"] = multiposition_switch_limited(_("TACAN Channel Lever (Ones)"), devices.TACAN, device_commands.TACAN_Knob_Chnl_Ones_Pilot, cockpit_args.TACAN_Dial_Inner_Pilot, 10, 1/9, false, 0)
elements["PNT_TACAN_LEVER_PILOT"].sound = {{SOUND_TACAN_SELECTOR_KNOB},{SOUND_TACAN_SELECTOR_KNOB}}
-- TACAN RIO Panel
elements["PNT_374"] = multiposition_switch_limited(_("TACAN Mode"), devices.TACAN, device_commands.TACAN_Knob_Func_RIO, cockpit_args.TACAN_Knob_Func_RIO, 5, 0.25, false)
elements["PNT_375"] = default_axis(_("TACAN Volume"), devices.TACAN, device_commands.TACAN_Knob_Vol_RIO, cockpit_args.TACAN_Knob_Vol_RIO, 0, 0.1, false, false)
elements["PNT_373"] = default_2_position_tumb(_("TACAN Mode Normal/Inverse"), devices.TACAN, device_commands.TACAN_Mode_Norm_Inv_RIO, cockpit_args.TACAN_Mode_Norm_Inv_RIO)
elements["PNT_372"] = default_2_position_tumb(_("TACAN Channel X/Y"), devices.TACAN, device_commands.TACAN_Mode_X_Y_RIO, cockpit_args.TACAN_Mode_X_Y_RIO)
elements["PNT_371"] = default_button(_("TACAN BIT"), devices.TACAN, device_commands.TACAN_Btn_BIT_RIO, cockpit_args.TACAN_Btn_BIT_RIO)
elements["PNT_TACAN_OUTER_TWIST_RIO"] = multiposition_switch_limited(_("TACAN Channel Wheel (Tens)"), devices.TACAN, device_commands.TACAN_Knob_Chnl_Tens_RIO, cockpit_args.TACAN_Dial_Outer_RIO, 13, 1/12, false, 0)
elements["PNT_TACAN_OUTER_TWIST_RIO"].sound = {{SOUND_POSITION_KNOB},{SOUND_POSITION_KNOB}}
elements["PNT_8890"] = multiposition_switch_limited(_("TACAN Channel Lever (Ones)"), devices.TACAN, device_commands.TACAN_Knob_Chnl_Ones_RIO, cockpit_args.TACAN_Dial_Inner_RIO, 10, 1/9, false, 0)
elements["PNT_8890"].sound = {{SOUND_TACAN_SELECTOR_KNOB},{SOUND_TACAN_SELECTOR_KNOB}}

-- AN/ARA-63 Panel
elements["PNT_910"] = default_2_position_tumb(_("AN/ARA-63 Power Switch"), devices.ILS, device_commands.ARA63_Power_Switch, cockpit_args.ARA63_Power_Switch, pilot_only)
elements["PNT_911"] = default_button(_("AN/ARA-63 BIT Button"), devices.ILS, device_commands.ARA63_BIT_Btn, cockpit_args.ARA63_BIT_Btn, nil, nil, pilot_only)
elements["PNT_912"] = multiposition_switch(_("AN/ARA-63 Channel Knob"), devices.ILS, device_commands.ARA63_Chnl_Knob, cockpit_args.ARA63_Chnl_Knob, 20, 1/19, false, 0, pilot_only)

-- Pilot TONE VOLUME panel
-- elements["PNT_2040"] = default_axis(_("ALR-45 Volume"), devices.ICS, device_commands.RADIO_ICS_Vol_ALR45, cockpit_args.RADIO_ICS_Vol_ALR45, 0, 0.1, false, false)
-- elements["PNT_2039"] = default_axis(_("ALR-50 Volume"), devices.ICS, device_commands.RADIO_ICS_Vol_ALR50, cockpit_args.RADIO_ICS_Vol_ALR50, 0, 0.1, false, false)
elements["PNT_2040"] = default_axis(_("ALR-67 Volume"), devices.ICS, device_commands.RADIO_ICS_Vol_ALR67_Pilot, cockpit_args.RADIO_ICS_Vol_ALR67_Pilot, 0, 0.1, false, false, nil, pilot_only)
elements["PNT_2039"] = default_axis(_("Sidewinder Volume"), devices.ICS, device_commands.RADIO_ICS_Vol_Sidewinder, cockpit_args.RADIO_ICS_Vol_Sidewinder, 0, 0.1, false, false, nil, pilot_only)

-- ICS Pilot
elements["PNT_2047"] = default_axis(_("ICS Volume"), devices.ICS, device_commands.RADIO_ICS_Vol_Pilot, cockpit_args.RADIO_ICS_Vol_Pilot, 0, 0.1, false, false, nil, pilot_only)
elements["PNT_2045"] = multiposition_switch_limited(_("ICS Amplifier Selector"), devices.ICS, device_commands.RADIO_ICS_Ampl_Pilot, cockpit_args.RADIO_ICS_Ampl_Pilot, 3, 0.5, false)
elements["PNT_2044"] = default_3_position_tumb(_("ICS Function Selector"), devices.ICS, device_commands.RADIO_ICS_Func_Pilot, cockpit_args.RADIO_ICS_Func_Pilot, false, true, pilot_only)

-- ICS RIO
elements["PNT_400"] = default_axis(_("ICS Volume"), devices.ICS, device_commands.RADIO_ICS_Vol_RIO, cockpit_args.RADIO_ICS_Vol_RIO, 0, 0.1, false, false)
elements["PNT_401"] = multiposition_switch_limited(_("ICS Amplifier Selector"), devices.ICS, device_commands.RADIO_ICS_Ampl_RIO, cockpit_args.RADIO_ICS_Ampl_RIO, 3, 0.5, false)
elements["PNT_402"] = default_3_position_tumb(_("ICS Function Selector"), devices.ICS, device_commands.RADIO_ICS_Func_RIO, cockpit_args.RADIO_ICS_Func_RIO, false, true)
elements["PNT_381"] = default_3_position_tumb(_("XMTR SEL Switch"), devices.ICS, device_commands.RADIO_ICS_XMTR_SEL_RIO, cockpit_args.RADIO_ICS_XMTR_SEL_RIO, false, true)
elements["PNT_380"] = default_2_position_tumb(_("V/UHF 2 ANT Switch"), devices.ICS, device_commands.RIO_UHF_UPR_LWR, cockpit_args.RIO_UHF_UPR_LWR, false, true)
elements["PNT_382"] = default_3_position_tumb(_("KY MODE Switch"), devices.ICS, device_commands.RIO_KY_MODE, cockpit_args.RIO_KY_MODE, false, true)

-- UHF ARC-159
elements["PNT_2033"] = multiposition_switch_limited(_("UHF ARC-159 Freq Mode"), devices.ARC159, device_commands.RADIO_UHF_FREQ_MODE_Pilot, cockpit_args.RADIO_UHF_FREQ_MODE_Pilot, 3, 0.5, true, nil, pilot_only)
elements["PNT_2033"].sound = {{SOUND_PLASTICY_KNOB},{SOUND_PLASTICY_KNOB}}
elements["PNT_2034"] = multiposition_switch_limited(_("UHF ARC-159 Function"), devices.ARC159, device_commands.RADIO_UHF_FUNC_Pilot, cockpit_args.RADIO_UHF_FUNC_Pilot, 4, 0.333333, false, nil, pilot_only)
elements["PNT_2034"].sound = {{SOUND_PLASTICY_KNOB},{SOUND_PLASTICY_KNOB}}
elements["PNT_2032"] = multiposition_switch_springy(_("UHF ARC-159 Preset Channel Selector"), devices.ARC159, device_commands.RADIO_UHF_CHAN_Pilot, cockpit_args.RADIO_UHF_CHAN_Pilot, 12, 0.0833333333, false, nil, pilot_only)

elements["PNT_2035"] = default_2_position_tumb(_("UHF ARC-159 Squelch Switch"), devices.ARC159, device_commands.RADIO_UHF_SQL_Pilot, cockpit_args.RADIO_UHF_SQL_Pilot,pilot_only)

elements["PNT_2030"] = default_springloaded_3pos_switch_tiny(_("UHF ARC-159 100MHz & 10MHz"), devices.ARC159, device_commands.RADIO_UHF_FREQ_HUNDRED_TEN_Pilot, device_commands.RADIO_UHF_FREQ_HUNDRED_TEN_Pilot, -1, 0, 1, cockpit_args.RADIO_UHF_FREQ_HUNDRED_TEN_Pilot)
elements["PNT_2030"].crew_member_access  = pilot_only
elements["PNT_2029"] = default_springloaded_3pos_switch_tiny(_("UHF ARC-159 1MHz"), devices.ARC159, device_commands.RADIO_UHF_FREQ_UNIT_Pilot, device_commands.RADIO_UHF_FREQ_UNIT_Pilot, -1, 0, 1, cockpit_args.RADIO_UHF_FREQ_UNIT_Pilot)
elements["PNT_2029"].crew_member_access  = pilot_only
elements["PNT_2028"] = default_springloaded_3pos_switch_tiny(_("UHF ARC-159 0.1MHz"), devices.ARC159, device_commands.RADIO_UHF_FREQ_TEHTH_Pilot, device_commands.RADIO_UHF_FREQ_TEHTH_Pilot, -1, 0, 1, cockpit_args.RADIO_UHF_FREQ_TEHTH_Pilot)
elements["PNT_2028"].crew_member_access  = pilot_only
elements["PNT_2026"] = default_springloaded_3pos_switch_tiny(_("UHF ARC-159 0.025MHz"), devices.ARC159, device_commands.RADIO_UHF_FREQ_HUNDREDTH_Pilot, device_commands.RADIO_UHF_FREQ_HUNDREDTH_Pilot, -1, 0, 1, cockpit_args.RADIO_UHF_FREQ_HUNDREDTH_Pilot)
elements["PNT_2026"].crew_member_access  = pilot_only

elements["PNT_8115"] = default_button(_("UHF ARC-159 Read"), devices.ARC159, device_commands.RADIO_UHF_READ_Pilot, cockpit_args.RADIO_UHF_READ_Pilot, nil, nil, pilot_only)
elements["PNT_8115"].sound = {{SOUND_TINY_KNOB_BETTER},{SOUND_TINY_KNOB_BETTER}}

elements["PNT_2031"] = default_axis(_("UHF ARC-159 Volume Pilot"), devices.ARC159, device_commands.RADIO_UHF_VOL_Pilot, cockpit_args.RADIO_UHF_VOL_Pilot, 0, 0.1, false, false, nil, pilot_only)
elements["PNT_383"] = default_axis(_("UHF ARC-159 Volume RIO"), devices.ARC159, device_commands.RADIO_UHF_VOL_RIO, cockpit_args.RADIO_UHF_VOL_RIO, 0, 0.1, false, false)
elements["PNT_2027"] = default_axis(_("UHF ARC-159 Display Brightness"), devices.ARC159, device_commands.RADIO_UHF_BRT_Pilot, cockpit_args.RADIO_UHF_BRT_Pilot, 0, 0.1, false, false, nil, pilot_only)

elements["PNT_16009"] = default_button(_("UHF ARC-159 Load"), devices.ARC159, device_commands.RADIO_UHF_LOAD_Pilot, cockpit_args.RADIO_UHF_LOAD_Pilot, nil, nil, pilot_only)
elements["PNT_16010"] = default_button(_("UHF ARC-159 Tone"), devices.ARC159, device_commands.RADIO_UHF_TONE_Pilot, cockpit_args.RADIO_UHF_TONE_Pilot, nil, nil, pilot_only)

-- UHF ARC-159 End


-- VHF/UHF ARC-182
elements["PNT_RIO_UHF_OUTER"] = multiposition_switch_limited(_("VHF/UHF ARC-182 Freq Mode"), devices.ARC182, device_commands.RADIO_VHF_FREQ_MODE_RIO, cockpit_args.RADIO_VHF_FREQ_MODE_RIO, 6, 0.2, false)
elements["PNT_358"] = multiposition_switch_limited(_("VHF/UHF ARC-182 MODE"), devices.ARC182, device_commands.RADIO_VHF_FUNC_RIO, cockpit_args.RADIO_VHF_FUNC_RIO, 5, 0.25, false)
elements["PNT_352"] = multiposition_switch(_("VHF/UHF ARC-182 Preset Channel Selector"), devices.ARC182, device_commands.RADIO_VHF_CHAN_RIO, cockpit_args.RADIO_VHF_CHAN_RIO, 12, 0.0833333333, false)
elements["PNT_359"] = default_2_position_tumb(_("VHF/UHF ARC-182 FM/AM Switch"), devices.ARC182, device_commands.RADIO_VHF_FM_AM_RIO, cockpit_args.RADIO_VHF_FM_AM_RIO)

elements["PNT_351"] = default_2_position_tumb(_("VHF/UHF ARC-182 Squelch Switch"), devices.ARC182, device_commands.RADIO_VHF_SQL_RIO, cockpit_args.RADIO_VHF_SQL_RIO)

elements["PNT_354"] = default_springloaded_3pos_switch(_("VHF/UHF ARC-182 100MHz & 10MHz"), devices.ARC182, device_commands.RADIO_VHF_FREQ_HUNDRED_TEN_RIO, device_commands.RADIO_VHF_FREQ_HUNDRED_TEN_RIO, -1, 0, 1, cockpit_args.RADIO_VHF_FREQ_HUNDRED_TEN_RIO)
elements["PNT_355"] = default_springloaded_3pos_switch(_("VHF/UHF ARC-182 1MHz"), devices.ARC182, device_commands.RADIO_VHF_FREQ_UNIT_RIO, device_commands.RADIO_VHF_FREQ_UNIT_RIO, -1, 0, 1, cockpit_args.RADIO_VHF_FREQ_UNIT_RIO)
elements["PNT_356"] = default_springloaded_3pos_switch(_("VHF/UHF ARC-182 0.1MHz"), devices.ARC182, device_commands.RADIO_VHF_FREQ_TEHTH_RIO, device_commands.RADIO_VHF_FREQ_TEHTH_RIO, -1, 0, 1, cockpit_args.RADIO_VHF_FREQ_TEHTH_RIO)
elements["PNT_357"] = default_springloaded_3pos_switch(_("VHF/UHF ARC-182 0.025MHz"), devices.ARC182, device_commands.RADIO_VHF_FREQ_HUNDREDTH_RIO, device_commands.RADIO_VHF_FREQ_HUNDREDTH_RIO, -1, 0, 1, cockpit_args.RADIO_VHF_FREQ_HUNDREDTH_RIO)

elements["PNT_350"] = default_axis(_("VHF/UHF ARC-182 Volume RIO"), devices.ARC182, device_commands.RADIO_VHF_VOL_RIO, cockpit_args.RADIO_VHF_VOL_RIO, 0, 0.1, false, false)
elements["PNT_2038"] = default_axis(_("VHF/UHF ARC-182 Volume Pilot"), devices.ARC182, device_commands.RADIO_VHF_VOL_PILOT, cockpit_args.RADIO_VHF_VOL_PILOT, 0, 0.1, false, false, nil, pilot_only)
elements["PNT_360"] = default_axis(_("VHF/UHF ARC-182 Display Brightness"), devices.ARC182, device_commands.RADIO_VHF_BRT_RIO, cockpit_args.RADIO_VHF_BRT_RIO, 0, 0.1, false, false)
-- VHF/UHF ARC-182 End

-- KY-28
elements["PNT_116"] = multiposition_switch_limited(_("KY-28 Power Mode"), devices.ICS, device_commands.RADIO_KY28_POWER_MODE, cockpit_args.RADIO_KY28_POWER_MODE, 3, 0.5, false)
elements["PNT_116"].sound = {{SOUND_POSITION_KNOB},{SOUND_POSITION_KNOB}}
elements["PNT_115"] = multiposition_switch_limited(_("KY-28 Radio Selector"), devices.ICS, device_commands.RADIO_KY28_RADIO_SELECTOR, cockpit_args.RADIO_KY28_RADIO_SELECTOR, 3, 0.5, true)
elements["PNT_115"].sound = {{SOUND_POSITION_KNOB},{SOUND_POSITION_KNOB}}
elements["PNT_150"] = default_flipcover(_("KY-28 ZEROIZE Cover"), devices.ICS, device_commands.RADIO_KY28_ZEROIZE_COVER, cockpit_args.RADIO_KY28_ZEROIZE_COVER)
elements["PNT_361"] = default_button(_("KY-28 ZEROIZE"), devices.ICS, device_commands.RADIO_KY28_ZEROIZE, cockpit_args.RADIO_KY28_ZEROIZE)


-- UHF/VHF/UHF Pilot/RIO Remote Display
elements["PNT_1031"] = default_axis(_("UHF Radio Remote Display Brightness"), devices.ARC159, device_commands.RADIO_UHF_Remote_DISP_BRT_Pilot, cockpit_args.RADIO_UHF_Remote_DISP_BRT_Pilot, 1.0, 0.1, true, false, nil, pilot_only)
elements["PNT_406"] = default_axis(_("UHF Radio Remote Display Brightness"), devices.ARC159, device_commands.RADIO_UHF_Remote_DISP_BRT_RIO, cockpit_args.RIO_UHF_REMOTE_DIM, 1.0, 0.1, true, false)
elements["PNT_1030"] = default_axis(_("VHF/UHF Radio Remote Display Brightness"), devices.ARC182, device_commands.RADIO_VHF_Remote_DISP_BRT_Pilot, cockpit_args.RADIO_VHF_Remote_DISP_BRT_Pilot, 1.0, 0.1, true, false, nil, pilot_only)
elements["UHF_BIT_TEST"] = default_button(_("UHF Radio Remote Display Test"), devices.ARC159, device_commands.RADIO_UHF_Remote_DISP_TEST_Pilot, cockpit_args.UHF_Test_Button_Pilot)
elements["UHF_BIT_TEST"].crew_member_access = pilot_only
elements["PNT_405"] = default_button(_("UHF Radio Remote Display Test"), devices.ARC159, device_commands.RADIO_UHF_Remote_DISP_TEST_RIO, cockpit_args.RIO_UHF_REMOTE_TEST)
elements["VHF_BIT_TEST"] = default_button(_("VHF/UHF Radio Remote Display Test"), devices.ARC182, device_commands.RADIO_VHF_Remote_DISP_TEST_Pilot, cockpit_args.VHF_Test_Button_Pilot)
elements["VHF_BIT_TEST"].crew_member_access = pilot_only
-- End UHF/VHF/UHF Pilot/RIO Remote Display



-- DECM Panel
elements["PNT_151"] = multiposition_switch_limited(_("DECM ALQ-100 Power/Mode"), devices.DECM, device_commands.DECM_Mode_Knob, cockpit_args.DECM_Mode_Knob, 6, 0.2, false)
elements["PNT_9950"] = default_axis(_("DECM ALQ-100 Volume"), devices.DECM, device_commands.DECM_Vol_Knob, cockpit_args.DECM_Vol_Knob, 0, 0.1, false, false)

-- RWR Control Panel ALR-67
elements["PNT_16011"] = default_axis(_("AN/ALR-67 Display Brightness"), devices.RWR, device_commands.RWR_Brightness_Pilot, cockpit_args.RWR_Brightness_Pilot, 1.0, 0.1, true, false)
elements["PNT_376"] = default_axis(_("AN/ALR-67 Display Brightness"), devices.RWR, device_commands.RWR_Brightness_RIO, cockpit_args.RWR_Brightness_RIO, 1.0, 0.1, true, false)
elements["PNT_2136"] = multiposition_switch_limited(_("AN/ALR-67 Display Type"), devices.RWR, device_commands.RWR_DISPLAY_TYPE, cockpit_args.ALR67_RIO_RWR_DISPLAY_TYPE, 5, 0.25, false)
elements["PNT_2136"].sound = {{SOUND_TACAN_SELECTOR_KNOB},{SOUND_TACAN_SELECTOR_KNOB}}

elements["PNT_2137"] = default_springloaded_3pos_switch(_("AN/ALR-67 Mode"), devices.RWR, device_commands.RWR_DISPLAY_MODE, device_commands.RWR_DISPLAY_MODE, -1, 0, 1, cockpit_args.ALR67_RIO_RWR_MODE)
elements["PNT_2140"] = default_springloaded_3pos_switch(_("AN/ALR-67 Test"), devices.RWR, device_commands.RWR_TEST_SWITCH, device_commands.RWR_TEST_SWITCH, -1, 0, 1, cockpit_args.ALR67_RIO_RWR_TEST)
elements["PNT_2139"] = default_2_position_tumb(_("AN/ALR-67 Power"), devices.RWR, device_commands.RWR_POWER, cockpit_args.ALR67_RIO_RWR_PWR)
elements["PNT_2138"] = default_axis(_("AN/ALR-67 Volume"), devices.ICS, device_commands.RWR_ALR67_Volume, cockpit_args.ALR67_RIO_RWR_VOL, 1.0, 0.1, true, false)

-- AN/ALE-39 Mode Panel
elements["PNT_390"] = default_3_position_tumb(_("AN/ALE-37 Power/Mode"), devices.COUNTERMEASURES, device_commands.CMDS_Master_Mode_SW, cockpit_args.CMDS_Master_Mode_SW, false, true)
elements["PNT_389"] = default_springloaded_3pos_switch(_("AN/ALE-37 Chaff Dispense"), devices.COUNTERMEASURES, device_commands.CMDS_Chaff_Oper_SW, device_commands.CMDS_Chaff_Oper_SW, -1, 0, 1, cockpit_args.CMDS_Chaff_Oper_SW)
elements["PNT_388"] = default_springloaded_3pos_switch(_("AN/ALE-37 Flare Dispense"), devices.COUNTERMEASURES, device_commands.CMDS_Flare_Oper_SW, device_commands.CMDS_Flare_Oper_SW, -1, 0, 1, cockpit_args.CMDS_Flare_Oper_SW)
elements["PNT_387"] = default_springloaded_3pos_switch(_("AN/ALE-37 Jammer Dispense"), devices.COUNTERMEASURES, device_commands.CMDS_Jammer_Oper_SW, device_commands.CMDS_Jammer_Oper_SW, -1, 0, 1, cockpit_args.CMDS_Jammer_Oper_SW)
elements["PNT_398"] = default_3_position_tumb(_("AN/ALE-37 Flare Mode"), devices.COUNTERMEASURES, device_commands.CMDS_Flare_Mode_SW, cockpit_args.CMDS_Flare_Mode_SW, false, true)
elements["PNT_391"] = default_button(_("AN/ALE-37 Flare Salvo"), devices.COUNTERMEASURES, device_commands.CMDS_Flare_Salvo_SW, cockpit_args.CMDS_Flare_Salvo_SW)

elements["PNT_386"] = default_axis(_("AN/ALE-37 Chaff Counter"),devices.COUNTERMEASURES, device_commands.CMDS_Chaff_Counter_Control, cockpit_args.CMDS_Chaff_Counter_Control, 1.0, 1.0, false, true)
elements["PNT_385"] = default_axis(_("AN/ALE-37 Flare Counter"),devices.COUNTERMEASURES, device_commands.CMDS_Flare_Counter_Control, cockpit_args.CMDS_Flare_Counter_Control, 1.0, 1.0, false, true)
elements["PNT_399"] = default_axis(_("AN/ALE-37 Jammer Counter"),devices.COUNTERMEASURES, device_commands.CMDS_Jammer_Counter_Control, cockpit_args.CMDS_Jammer_Counter_Control, 1.0, 1.0, false, true)

-- AN/ALE-39 Program Panel
elements["PNT_206"] = multiposition_roller_limited(_("AN/ALE-37 L10 Load Type"), devices.COUNTERMEASURES, device_commands.CMDS_L10_Wheel, cockpit_args.CMDS_L10_Wheel, 3, false)
elements["PNT_207"] = multiposition_roller_limited(_("AN/ALE-37 L20 Load Type"), devices.COUNTERMEASURES, device_commands.CMDS_L20_Wheel, cockpit_args.CMDS_L20_Wheel, 3, false)
elements["PNT_209"] = multiposition_roller_limited(_("AN/ALE-37 R10 Load Type"), devices.COUNTERMEASURES, device_commands.CMDS_R10_Wheel, cockpit_args.CMDS_R10_Wheel, 3, false)
elements["PNT_208"] = multiposition_roller_limited(_("AN/ALE-37 R20 Load Type"), devices.COUNTERMEASURES, device_commands.CMDS_R20_Wheel, cockpit_args.CMDS_R20_Wheel, 3, false)

elements["PNT_214"] = multiposition_roller_limited(_("AN/ALE-37 Chaff Burst Quantity"), devices.COUNTERMEASURES, device_commands.CMDS_Chaff_Burst_Qty_Wheel, cockpit_args.CMDS_Chaff_Burst_Qty_Wheel, 6, false)
elements["PNT_215"] = multiposition_roller_limited(_("AN/ALE-37 Chaff Burst Interval"), devices.COUNTERMEASURES, device_commands.CMDS_Chaff_Burst_Intv_Wheel, cockpit_args.CMDS_Chaff_Burst_Intv_Wheel, 6, false)

elements["PNT_203"] = multiposition_roller_limited(_("AN/ALE-37 Chaff Salvo Quantity"), devices.COUNTERMEASURES, device_commands.CMDS_Chaff_Salvo_Qty_Wheel, cockpit_args.CMDS_Chaff_Salvo_Qty_Wheel, 7, false)
elements["PNT_202"] = multiposition_roller_limited(_("AN/ALE-37 Chaff Salvo Interval"), devices.COUNTERMEASURES, device_commands.CMDS_Chaff_Salvo_Intv_Wheel, cockpit_args.CMDS_Chaff_Salvo_Intv_Wheel, 5, false)

elements["PNT_205"] = multiposition_roller_limited(_("AN/ALE-37 Flare Quantity"), devices.COUNTERMEASURES, device_commands.CMDS_Flare_Qty_Wheel, cockpit_args.CMDS_Flare_Qty_Wheel, 6, false)
elements["PNT_210"] = multiposition_roller_limited(_("AN/ALE-37 Flare Interval"), devices.COUNTERMEASURES, device_commands.CMDS_Flare_Intv_Wheel, cockpit_args.CMDS_Flare_Intv_Wheel, 5, false)

elements["PNT_204"] = multiposition_roller_limited(_("AN/ALE-37 Jammer Quantity"), devices.COUNTERMEASURES, device_commands.CMDS_JAMR_Qty, cockpit_args.CMDS_JAMR_Qty, 4, false)
elements["PNT_211"] = multiposition_roller_limited(_("AN/ALE-37 Jammer Interval Units"), devices.COUNTERMEASURES, device_commands.CMDS_JAMR_Intv_1, cockpit_args.CMDS_JAMR_Intv_1, 10, false)
elements["PNT_212"] = multiposition_roller_limited(_("AN/ALE-37 Jammer Interval Tens"), devices.COUNTERMEASURES, device_commands.CMDS_JAMR_Intv_10, cockpit_args.CMDS_JAMR_Intv_10, 10, false)
elements["PNT_213"] = multiposition_roller_limited(_("AN/ALE-37 Jammer Interval Hundreds"), devices.COUNTERMEASURES, device_commands.CMDS_JAMR_Intv_100, cockpit_args.CMDS_JAMR_Intv_100, 10, false)

elements["PNT_216"] = default_button(_("AN/ALE-37 Programmer Reset"), devices.COUNTERMEASURES, device_commands.CMDS_Programmer_Reset, cockpit_args.CMDS_Programmer_Reset)

-- INS
elements["PNT_50"] = multiposition_switch_limited(_("Navigation Mode"), devices.INS, device_commands.TID_nav_mode, cockpit_args.TID_nav_mode, 7, 0.1666667, false)
elements["PNT_50"].sound = {{SOUND_POSITION_KNOB},{SOUND_POSITION_KNOB}}
elements["PNT_51"] = multiposition_switch_limited(_("Destination Mode"), devices.NAV_INTERFACE, device_commands.TID_dest_mode, cockpit_args.TID_dest_mode, 8, 0.142857, false) -- 1/7
elements["PNT_51"].sound = {{SOUND_POSITION_KNOB},{SOUND_POSITION_KNOB}}
-- AHRS / compass
elements["PNT_904"] = {
	class = {class_type.BTN, class_type.LEV},
	hint = _("Compass HDG Slave Knob/nPush (Left Mouse Button) and rotate (Right Mouse Button)"),
	device = devices.AHRS,
	action = {device_commands.AHRS_HDG_PushButton, device_commands.AHRS_HDG_Rotate},
	arg = {cockpit_args.AHRS_HDG_PushButton, cockpit_args.AHRS_HDG_Rotate },
	arg_value = {1.0, 1.0},
	arg_lim = {{0.0, 1.0}, {-1.0, 1.0} },
	relative = {false, false},
	gain = {2.5, 0.08 },
	use_release_message = {true, true},
	updatable = true,
	cycle 	=  {true, false},
	animated 	 = {false, false},
	animation_speed = {0.0, 0.0},
	stop_action = {device_commands.AHRS_HDG_PushButton, 0},
	stop_value 	= {0.0,	0.0},
    crew_member_access = pilot_only,
	use_OBB = true }

elements["PNT_905"] = default_3_position_tumb(_("Compass Mode"), devices.AHRS, device_commands.AHRS_ModeSwitch, cockpit_args.AHRS_ModeSwitch, false, true)
elements["PNT_905"].sound = {{SOUND_SPRINGY2_KNOB},{SOUND_SPRINGY2_KNOB}}


elements["PNT_906"] = alt_2_position_tumb(_("Compass N-S Hemisphere"), devices.AHRS, device_commands.AHRS_NorthSouth, cockpit_args.AHRS_NorthSouth)
elements["PNT_909"] = default_axis(_("Compass LAT Correction"), devices.AHRS, device_commands.AHRS_LatCorrection, cockpit_args.AHRS_LatCorrection, 0, 0.011, false, false)

-- Copied temp so easy to copy: (I'm lazy, sue me)
--elements["PNT_926"] = default_2_position_tumb(_("EMERG GEN switch"),devices.ELECTRICS, device_commands.EMERG_GEN_Switch, 926)
--elements["PNT_1073"] = default_3_position_tumb(_("Refuel Probe"), devices.FUELSYSTEM, device_commands.FUELSYSTEM_Refuel_Probe, 1073, false, false)

-- Spoiler Overrides
elements["PNT_902"] = default_2_position_tumb(_("Inboard Spoiler Override Cover"),devices.ELECTRICS, device_commands.SPOIL_Inboard_Override_Cover, cockpit_args.SPOIL_Inboard_Override_Cover, pilot_only)
elements["PNT_903"] = default_2_position_tumb(_("Outboard Spoiler Override Cover"),devices.ELECTRICS, device_commands.SPOIL_Outboard_Override_Cover, cockpit_args.SPOIL_Outboard_Override_Cover, pilot_only)
elements["PNT_908"] = default_2_position_tumb(_("Inboard Spoiler Override"),devices.ELECTRICS, device_commands.SPOIL_Inboard_Override, cockpit_args.SPOIL_Inboard_Override, pilot_only)
elements["PNT_907"] = default_2_position_tumb(_("Outboard Spoiler Override"),devices.ELECTRICS, device_commands.SPOIL_Outboard_Override, cockpit_args.SPOIL_Outboard_Override, pilot_only)

-- Gun Elevation
elements["PNT_1000"] = default_axis(_("Gun Elevation Lead Adjustment"),devices.WEAPONS, device_commands.WEAP_Gun_Elevation, cockpit_args.WEAP_Gun_Elevation, 1.0, 0.1, true, true, nil, pilot_only)

elements["PNT_1022"] = default_axis(_("Gun Ammunition Counter Adjustment"),devices.WEAPONS, device_commands.WEAP_Gun_Ammo_adjust, cockpit_args.WEAP_Gun_Ammo_adjust, 1.0, 0.1, true, true, nil, pilot_only)

-- DISPLAY Panel


elements["PNT_1007"] = default_axis(_("HUD Pitch Ladder Brightness"),devices.HUD, device_commands.DISP_HUD_pitch_bright, cockpit_args.DISP_HUD_pitch_bright, 1.0, 0.1, true, false, nil, pilot_only)
elements["PNT_1019"] = default_2_position_tumb(_("VDI Display Mode"),devices.VDI, device_commands.DISP_VDI_display_mode, cockpit_args.DISP_VDI_display_mode, pilot_only)
elements["PNT_1018"] = default_2_position_tumb(_("VDI Landing Mode"),devices.VDI, device_commands.DISP_VDI_landing_mode, cockpit_args.DISP_VDI_landing_mode, pilot_only)
elements["PNT_1021"] = default_2_position_tumb(_("HUD De-clutter On/Off"),devices.HUD, device_commands.DISP_HUD_declutter, cockpit_args.DISP_HUD_declutter, pilot_only)
elements["PNT_1020"] = default_2_position_tumb(_("HUD AWL Mode"),devices.HUD, device_commands.DISP_HUD_AWL_mode, cockpit_args.DISP_HUD_AWL_mode, pilot_only)

elements["PNT_1015"] = default_displaybutton(_("HUD Take-Off Mode"),devices.HUD, device_commands.DISP_mode_takeoff, cockpit_args.DISP_mode_takeoff, pilot_only)
elements["PNT_1014"] = default_displaybutton(_("HUD Cruise Mode"),devices.HUD, device_commands.DISP_mode_cruise, cockpit_args.DISP_mode_cruise, pilot_only)
elements["PNT_1013"] = default_displaybutton(_("HUD Air-to-Air Mode"),devices.HUD, device_commands.DISP_mode_air2air, cockpit_args.DISP_mode_air2air, pilot_only)
elements["PNT_1012"] = default_displaybutton(_("HUD Air-to-Ground Mode"),devices.HUD, device_commands.DISP_mode_air2ground, cockpit_args.DISP_mode_air2ground, pilot_only)
elements["PNT_1011"] = default_displaybutton(_("HUD Landing Mode"),devices.HUD, device_commands.DISP_mode_landing, cockpit_args.DISP_mode_landing, pilot_only)

--DISPLAY End


--Stdby ADI Pilot
elements["PNT_1032"] =    {
    class = {class_type.TUMB, class_type.LEV},
    hint = _("Standby ADI Knob"),
    device = devices.STDBYAI,
    action = {device_commands.STDBYADI_uncage, device_commands.STDBYADI_trim},
    is_repeatable = {},
    arg = {cockpit_args.STDBY_ADI_Push, nil}, --cockpit_args.STDBY_ADI_Twist
    arg_value = {1.0, 0.5 },
    arg_lim = {{0, 1}, {0, 1}},
    relative = {false,true},
    updatable 	= false,
    gain = {1.0, 0.25},
    use_release_message = {true, false},
    use_OBB = true,
    sound = {{SOUND_MAJOR_FLIPSWITCH},{nil}}
}

elements["PNT_RIO_STBY_ADI_PULL"] = {
    class = {class_type.TUMB, class_type.LEV},
    hint = _("Standby ADI Knob"),
    device = devices.STDBYAI,
    action = {device_commands.STDBYADI_RIO_uncage, device_commands.STDBYADI_RIO_trim},
    is_repeatable = {},
    arg = {cockpit_args.STDBYADI_RIO_uncage, nil}, --cockpit_args.STDBYADI_RIO_trim
    arg_value = {1.0, 0.5 },
    arg_lim = {{0, 1}, {0, 1}},
    relative = {false,true},
    updatable 	= false,
    gain = {1.0, 0.25},
    use_release_message = {true, false},
    use_OBB = true ,
    sound = {{SOUND_MAJOR_FLIPSWITCH},{nil}}
}



elements["PNT_228"] = default_button(_("Accelerometer Reset"),devices.ACCELEROMETER, device_commands.ACCEL_Reset, cockpit_args.ACCEL_Reset)

--VDI & HUD Indicator controls
elements["PNT_1033"] = default_animated_lever(_("HUD filter"), devices.HUD, device_commands.VDIG_VDI_handle, cockpit_args.VDIG_VDI_handle,8,{0.0,1.0})
elements["PNT_1033"].sound = {{SOUND_HOLLOW_LEVER_OPEN,SOUND_HOLLOW_LEVER_CLOSE},{SOUND_HOLLOW_LEVER_OPEN,SOUND_HOLLOW_LEVER_CLOSE}}

elements["PNT_1034"] = default_axis(_("HUD Trim"),devices.HUD, device_commands.VDIG_HUD_trim, cockpit_args.VDIG_HUD_trim, 1.0, 0.1, true, false, nil, pilot_only)
elements["PNT_1035"] = default_axis(_("VDI Trim"),devices.VDI, device_commands.VDIG_VSDI_trim, cockpit_args.VDIG_VSDI_trim, 1.0, 0.1, true, false, nil, pilot_only)
elements["PNT_1038"] = default_axis(_("VDI Screen Contrast"),devices.VDI, device_commands.VDIG_VDI_contrast, cockpit_args.VDIG_VDI_contrast, 1.0, 0.1, true, false, nil, pilot_only)
elements["PNT_1036"] = default_axis(_("VDI Screen Brightness"),devices.VDI, device_commands.VDIG_VSDI_bright, cockpit_args.VDIG_VSDI_bright, 1.0, 0.1, true, false, nil, pilot_only)
elements["PNT_1037"] = default_axis(_("HUD Brightness"),devices.HUD, device_commands.VDIG_HUD_bright, cockpit_args.VDIG_HUD_bright, 1.0, 0.1, true, false, nil, pilot_only)
elements["PNT_VDI"] = default_button(_("VDI filter"),devices.VDI, device_commands.VDIG_VDI_filter, -1)
elements["PNT_VDI"].crew_member_access = pilot_only
elements["PNT_VDI"].sound = {{SOUND_DATACARTRIDGE,SOUND_DATACARTRIDGE},{SOUND_DATACARTRIDGE,SOUND_DATACARTRIDGE}}

-- Under HUD / Master Arm / Gun/Weapons Panel
elements["PNT_1046"] = default_animated_lever(_("Master Arm Cover"), devices.WEAPONS, device_commands.WEAP_Master_Arm_Cover, cockpit_args.WEAP_Master_Arm_Cover,8,{0.0,1.0}, pilot_only)
elements["PNT_1046"].sound = {{SOUND_ACM_FLIPCOVER_OPEN,SOUND_ACM_FLIPCOVER_CLOSE},{SOUND_ACM_FLIPCOVER_OPEN,SOUND_ACM_FLIPCOVER_CLOSE}}
elements["PNT_1047"] = default_3_position_tumb(_("Master Arm Switch"),devices.WEAPONS, device_commands.WEAP_Master_Arm, cockpit_args.WEAP_Master_Arm, false, false, pilot_only)

elements["PNT_1049"] = default_animated_lever(_("ACM Cover"), devices.WEAPONS, device_commands.WEAP_ACM_Cover, cockpit_args.WEAP_ACM_Cover,9,{0.0,1.0}, pilot_only) --function default_animated_lever(hint_, device_, command_, arg_, animation_speed_,arg_lim_)

elements["PNT_1049"].sound = {{SOUND_ACM_FLIPCOVER_OPEN,SOUND_ACM_FLIPCOVER_CLOSE},{SOUND_ACM_FLIPCOVER_OPEN,SOUND_ACM_FLIPCOVER_CLOSE}}

elements["PNT_1048"] = default_button(_("ACM Jettison"),devices.WEAPONS, device_commands.WEAP_ACM_Jettison, cockpit_args.WEAP_ACM_Jettison)
elements["PNT_1048"].crew_member_access = pilot_only

elements["PNT_9199"] = default_button(_("Master Caution Reset"),devices.WARNINGLIGHTS, device_commands.WLP_Master_Caution_Pilot, cockpit_args.WEAP_Master_Caution_Button)
elements["PNT_9199"].crew_member_access = pilot_only

elements["PNT_GUN_RATE"] = default_button_big(_("Gun rate"),devices.WEAPONS, device_commands.WEAP_Gun_Rate, cockpit_args.WEAP_GunRateButton, nil, nil, pilot_only)
elements["PNT_SW_COOL"] = default_button_big(_("Sidewinder cool"),devices.WEAPONS, device_commands.WEAP_SW_Cool, cockpit_args.WEAP_SWCoolButton, nil, nil, pilot_only)
elements["PNT_MSL_PREP"] = default_button_big(_("Missile prepare"),devices.WEAPONS, device_commands.WEAP_MSL_Prep, cockpit_args.WEAP_MSLPrepButton, nil, nil, pilot_only)
elements["PNT_MSL_MODE"] = default_button_big(_("Missile mode"),devices.WEAPONS, device_commands.WEAP_MSL_Mode, cockpit_args.WEAP_ModeSTPButton, nil, nil, pilot_only)
elements["PNT_239"] = default_button_big(_("Emergency stores jettison"),devices.WEAPONS, device_commands.WEAP_Emer_Jettison, cockpit_args.WEAP_Emer_Jettison, nil, nil, pilot_only)

elements["PNT_1051"] = default_axis(_("Clock Wind"), devices.CLOCK, device_commands.CLOCK_Wind, cockpit_args.CLOCK_Wind, 0.5, 0.3, true, true, true)
elements["PNT_CLOCK_RESET"] = default_button(_("Clock Timer Start/Stop/Reset"),devices.CLOCK,device_commands.CLOCK_Timer, cockpit_args.CLOCK_Timer,1)

elements["PNT_1052"] = default_axis(_("Clock Wind"), devices.CLOCK, device_commands.RIO_CLOCK_Wind, cockpit_args.RIO_CLOCK_Wind, 0.5, 0.3, true, true, true)
elements["PNT_1053"] = default_button(_("Clock Timer Start/Stop/Reset"),devices.CLOCK,device_commands.RIO_CLOCK_Timer, cockpit_args.RIO_CLOCK_Timer,1)


-- RIO TID
elements["PNT_2005"] = multiposition_switch_limited(_("TID Mode"), devices.TID, device_commands.TID_mode_knob, cockpit_args.TID_mode_knob, 4, 0.33333, false)
elements["PNT_2005"].sound = {{SOUND_PLASTICY_KNOB},{SOUND_PLASTICY_KNOB}}
elements["PNT_2006"] = multiposition_switch_limited(_("TID Range"), devices.TID, device_commands.TID_range_knob, cockpit_args.TID_range_knob, 5, 0.5, false, -1.0)
elements["PNT_2006"].sound = {{SOUND_PLASTICY_KNOB},{SOUND_PLASTICY_KNOB}}
elements["PNT_226"] = default_button(_("TID Non attack"), devices.TID, device_commands.TID_NON_ATTK, cockpit_args.TID_NON_ATTK)
elements["PNT_1118"] = default_button(_("TID Jam strobe"), devices.TID, device_commands.TID_JAM_STROBE, cockpit_args.TID_JAM_STROBE)
elements["PNT_1117"] = default_button(_("TID Data link"), devices.TID, device_commands.TID_DATA_LINK, cockpit_args.TID_DATA_LINK)
elements["PNT_1116"] = default_button(_("TID Sym Elem"), devices.TID, device_commands.TID_SYM_ELEM, cockpit_args.TID_SYM_ELEM)
elements["PNT_1115"] = default_button(_("TID Alt num"), devices.TID, device_commands.TID_ALT_NUM, cockpit_args.TID_ALT_NUM)
elements["PNT_2004"] = default_button(_("TID Reject Image Device disable (no function)"), devices.TID, device_commands.TID_RID_DSBL, cockpit_args.TID_RID_DSBL)
elements["PNT_2113"] = default_button(_("TID Launch zone"), devices.TID, device_commands.TID_LAUNCH_ZONE, cockpit_args.TID_LAUNCH_ZONE)
elements["PNT_2114"] = default_button(_("TID Velocity vector"), devices.TID, device_commands.TID_VEL_VECTOR, cockpit_args.TID_VEL_VECTOR)
elements["PNT_52"] = default_button(_("collision steering"), devices.TID, device_commands.TID_CLSN, cockpit_args.TID_CLSN)
elements["PNT_53"] = default_button(_("TID track hold"), devices.TID, device_commands.TID_trackhold, cockpit_args.TID_trackhold)
elements["PNT_48"] = default_axis(_("TID Brightness"),devices.TID, device_commands.TID_bright, cockpit_args.TID_bright, 1.0, 0.1, true, false)
elements["PNT_49"] = default_axis(_("TID Contrast"),devices.TID, device_commands.TID_contrast, cockpit_args.TID_contrast, 1.0, 0.1, true, false)

-- RIO HCU
elements["PNT_2007"] = default_2_position_tumb(_("HCU TCS mode"),devices.HCU, device_commands.HCU_IR_TV, cockpit_args.HCU_IR_TV)
elements["PNT_2008"] = default_2_position_tumb(_("HCU radar mode"),devices.HCU, device_commands.HCU_RDR, cockpit_args.HCU_RDR)
elements["PNT_2009"] = default_2_position_tumb(_("HCU DDD mode"),devices.HCU, device_commands.HCU_DDD_cursor, cockpit_args.HCU_DDD_cursor)
elements["PNT_2010"] = default_2_position_tumb(_("HCU TID mode"),devices.HCU, device_commands.HCU_TID_cursor, cockpit_args.HCU_TID_cursor)
elements["PNT_2011"] = default_3_position_tumb(_("TV/IR switch"), devices.TCS, device_commands.HCU_TVIR_enable, cockpit_args.HCU_TVIR_enable, false, true)
elements["PNT_2012"] = default_3_position_tumb(_("WCS switch"), devices.RADAR, device_commands.HCU_WCS_enable, cockpit_args.HCU_WCS_enable, false, true)
elements["PNT_2013"] = default_button(_("Power reset"), devices.RADAR, device_commands.HCU_POWER_RESET_BUTTON, cockpit_args.HCU_POWER_RESET_BUTTON)
elements["PNT_2014"] = default_button(_("Light test"), devices.RADAR, device_commands.HCU_LIGHT_TEST_BUTTON, cockpit_args.HCU_LIGHT_TEST_BUTTON)

-- RIO DDD
elements["PNT_40"] = default_button(_("RADAR 5 NM"), devices.RADAR, device_commands.RADAR_DDD_range_5, cockpit_args.RADAR_DDD_range_5)
elements["PNT_41"] = default_button(_("RADAR 10 NM"), devices.RADAR, device_commands.RADAR_DDD_range_10, cockpit_args.RADAR_DDD_range_10)
elements["PNT_42"] = default_button(_("RADAR 20 NM"), devices.RADAR, device_commands.RADAR_DDD_range_20, cockpit_args.RADAR_DDD_range_20)
elements["PNT_43"] = default_button(_("RADAR 50 NM"), devices.RADAR, device_commands.RADAR_DDD_range_50, cockpit_args.RADAR_DDD_range_50)
elements["PNT_44"] = default_button(_("RADAR 100 NM"), devices.RADAR, device_commands.RADAR_DDD_range_100, cockpit_args.RADAR_DDD_range_100)
elements["PNT_45"] = default_button(_("RADAR 200 NM"), devices.RADAR, device_commands.RADAR_DDD_range_200, cockpit_args.RADAR_DDD_range_200)
elements["PNT_DDD_CENTRw"] = default_button(_("DDD filter"),devices.RADAR, device_commands.RADAR_DDD_filter, -1)





elements["PNT_10"] = default_button(_("RADAR pulse search"), devices.RADAR, device_commands.RADAR_DDD_WCS_PSRCH, cockpit_args.RADAR_DDD_WCS_PSRCH)
elements["PNT_10"].sound = {{SOUND_GENERICBUTTON1, SOUND_ACM_BUTTON_REL},{SOUND_GENERICBUTTON1, SOUND_ACM_BUTTON_REL}}

elements["PNT_11"] = default_button(_("RADAR track while scan manual"), devices.RADAR, device_commands.RADAR_DDD_WCS_TWSMAN, cockpit_args.RADAR_DDD_WCS_TWSMAN)
elements["PNT_11"].sound = {{SOUND_GENERICBUTTON2, SOUND_ACM_BUTTON_REL},{SOUND_GENERICBUTTON1, SOUND_ACM_BUTTON_REL}}

elements["PNT_12"] = default_button(_("RADAR track while scan auto"), devices.RADAR, device_commands.RADAR_DDD_WCS_TWSAUTO, cockpit_args.RADAR_DDD_WCS_TWSAUTO)
elements["PNT_12"].sound = {{SOUND_GENERICBUTTON2, SOUND_ACM_BUTTON_REL},{SOUND_GENERICBUTTON1, SOUND_ACM_BUTTON_REL}}

elements["PNT_13"] = default_button(_("RADAR range while scan"), devices.RADAR, device_commands.RADAR_DDD_WCS_RWS, cockpit_args.RADAR_DDD_WCS_RWS)
elements["PNT_13"].sound = {{SOUND_GENERICBUTTON1, SOUND_ACM_BUTTON_REL},{SOUND_GENERICBUTTON1, SOUND_ACM_BUTTON_REL}}

elements["PNT_14"] = default_button(_("RADAR pulse doppler search"), devices.RADAR, device_commands.RADAR_DDD_WCS_PDSRCH, cockpit_args.RADAR_DDD_WCS_PDSRCH)
elements["PNT_14"].sound = {{SOUND_GENERICBUTTON2, SOUND_ACM_BUTTON_REL},{SOUND_GENERICBUTTON1, SOUND_ACM_BUTTON_REL}}

elements["PNT_15"] = default_button(_("RADAR pulse single target track"), devices.RADAR, device_commands.RADAR_DDD_WCS_PSTT, cockpit_args.RADAR_DDD_WCS_PSTT)
elements["PNT_15"].sound = {{SOUND_GENERICBUTTON1, SOUND_ACM_BUTTON_REL},{SOUND_GENERICBUTTON1, SOUND_ACM_BUTTON_REL}}

elements["PNT_9916"] = default_button(_("RADAR pulse doppler single target track"), devices.RADAR, device_commands.RADAR_DDD_WCS_PDSTT, cockpit_args.RADAR_DDD_WCS_PDSTT)
elements["PNT_9916"].sound = {{SOUND_GENERICBUTTON2, SOUND_ACM_BUTTON_REL},{SOUND_GENERICBUTTON1, SOUND_ACM_BUTTON_REL}}

elements["PNT_17"] = default_button(_("DDD Interrogate Friend or Foe"), devices.RADAR, device_commands.RADAR_DDD_display_IFF, cockpit_args.RADAR_DDD_display_IFF)
elements["PNT_17"].sound = {{SOUND_GENERICBUTTON2, SOUND_ACM_BUTTON_REL},{SOUND_GENERICBUTTON1, SOUND_ACM_BUTTON_REL}}

elements["PNT_18"] = default_button(_("DDD Infrared (no function)"), devices.RADAR, device_commands.RADAR_DDD_display_IR, cockpit_args.RADAR_DDD_display_IR)
elements["PNT_18"].sound = {{SOUND_GENERICBUTTON1, SOUND_ACM_BUTTON_REL},{SOUND_GENERICBUTTON1, SOUND_ACM_BUTTON_REL}}

elements["PNT_19"] = default_button(_("DDD RADAR"), devices.RADAR, device_commands.RADAR_DDD_display_radar, cockpit_args.RADAR_DDD_display_radar)
elements["PNT_19"].sound = {{SOUND_GENERICBUTTON1, SOUND_ACM_BUTTON_REL},{SOUND_GENERICBUTTON1, SOUND_ACM_BUTTON_REL}}

elements["PNT_1812"] = default_button(_("CCM SPL (no function)"), devices.RADAR, device_commands.CCM_SPL, cockpit_args.CCM_SPL)
elements["PNT_1812"].sound = {{SOUND_GENERICBUTTON1, SOUND_ACM_BUTTON_REL},{SOUND_GENERICBUTTON1, SOUND_ACM_BUTTON_REL}}

elements["PNT_1813"] = default_button(_("CCM ALT DIFF (no function)"), devices.RADAR, device_commands.CCM_ALT_DIFF, cockpit_args.CCM_ALT_DIFF)
elements["PNT_1813"].sound = {{SOUND_GENERICBUTTON1, SOUND_ACM_BUTTON_REL},{SOUND_GENERICBUTTON1, SOUND_ACM_BUTTON_REL}}

elements["PNT_1814"] = default_button(_("CCM VGS (no function)"), devices.RADAR, device_commands.CCM_VGS, cockpit_args.CCM_VGS)
elements["PNT_1814"].sound = {{SOUND_GENERICBUTTON1, SOUND_ACM_BUTTON_REL},{SOUND_GENERICBUTTON1, SOUND_ACM_BUTTON_REL}}

elements["PNT_20"] = default_axis(_("IR gain (no function)"),devices.RADAR, device_commands.RADAR_IR_gain, cockpit_args.RADAR_IR_gain, 0.5)
elements["PNT_21"] = default_axis(_("IR volume (no function)"),devices.RADAR, device_commands.RADAR_IR_volume, cockpit_args.RADAR_IR_volume, 0.5)
elements["PNT_22"] = default_axis(_("IR threshold (no function)"),devices.RADAR, device_commands.RADAR_IR_threshold, cockpit_args.RADAR_IR_threshold, 0.5)
elements["PNT_23"] = default_axis(_("Brightness"),devices.RADAR, device_commands.RADAR_DDD_bright, cockpit_args.RADAR_DDD_bright, 0.5)
elements["PNT_24"] = default_axis(_("Pulse video"),devices.RADAR, device_commands.RADAR_DDD_pulse_vid, cockpit_args.RADAR_DDD_pulse_vid, 0.5)
elements["PNT_25"] = default_axis(_("Erase"),devices.RADAR, device_commands.RADAR_DDD_erase, cockpit_args.RADAR_DDD_erase, 0.5)
elements["PNT_26"] = default_axis(_("Pulse gain"),devices.RADAR, device_commands.RADAR_DDD_pulse_gain, cockpit_args.RADAR_DDD_pulse_gain, 0.5)
elements["PNT_27"] = default_axis(_("ACM threshold (no function)"),devices.RADAR, device_commands.RADAR_ACM_thresh, cockpit_args.RADAR_ACM_thresh, 0.5)
elements["PNT_28"] = default_axis(_("JAM/JET (no function)"),devices.RADAR, device_commands.RADAR_jamjet, cockpit_args.RADAR_jamjet, 0.5)
elements["PNT_29"] = default_axis(_("PD threshold clutter (no function)"),devices.RADAR, device_commands.RADAR_PD_thresh_clutter, cockpit_args.RADAR_PD_thresh_clutter, 0.5)
elements["PNT_30"] = default_axis(_("PD threshold clear (no function)"),devices.RADAR, device_commands.RADAR_PD_thresh_clear, cockpit_args.RADAR_PD_thresh_clear, 0.5)
elements["PNT_34"] = default_3_position_tumb(_("Aspect"), devices.RADAR, device_commands.RADAR_DDD_aspect, cockpit_args.RADAR_DDD_aspect, false)
elements["PNT_35"] = default_3_position_tumb(_("Closing Velocity scale"), devices.RADAR, device_commands.RADAR_DDD_Vc_scale, cockpit_args.RADAR_DDD_Vc_scale, false)
elements["PNT_36"] = default_3_position_tumb(_("Target size"), devices.RADAR, device_commands.RADAR_DDD_tgts, cockpit_args.RADAR_DDD_tgts, false)
elements["PNT_37"] = default_3_position_tumb(_("Main Lobe Clutter filter"), devices.RADAR, device_commands.RADAR_DDD_MLC, cockpit_args.RADAR_DDD_MLC, false)
elements["PNT_38"] = default_2_position_tumb(_("Automatic Gain Control (no function)"), devices.RADAR, device_commands.RADAR_DDD_AGC, cockpit_args.RADAR_DDD_AGC)
elements["PNT_38"].arg_lim  = {{-1,1},{-1,1}}
elements["PNT_38"].arg_value  = {2,-2}
elements["PNT_3900"] = default_2_position_tumb(_("Parametric amplifier (no function)"), devices.RADAR, device_commands.RADAR_DDD_paramp, cockpit_args.RADAR_DDD_paramp)
elements["PNT_3900"].arg_lim  = {{-1,1},{-1,1}}
elements["PNT_3900"].arg_value  = {2,-2}
-- RIO RADAR panel
elements["PNT_79"] = multiposition_switch_limited(_("Radar elevation scan"), devices.RADAR, device_commands.RADAR_elevation_bars_knob, cockpit_args.RADAR_elevation_bars_knob, 4, 0.33333, false)
elements["PNT_80"] = multiposition_switch_limited(_("Radar azimuth scan"), devices.RADAR, device_commands.RADAR_azimuth_scan_knob, cockpit_args.RADAR_azimuth_scan_knob, 4, 0.33333, false)
elements["PNT_81"] = default_axis(_("Radar elevation center"),devices.RADAR, device_commands.RADAR_elevation_center_knob, cockpit_args.RADAR_elevation_center_knob, 0.0)
elements["PNT_81"].arg_lim  = {{-1,1},{-1,1}}
--elements["PNT_81"].arg_value  = {2,-2}
elements["PNT_82"] = default_axis(_("Radar azimuth center"),devices.RADAR, device_commands.RADAR_azimuth_center_knob, cockpit_args.RADAR_azimuth_center_knob, 0.0)
elements["PNT_82"].arg_lim  = {{-1,1},{-1,1}}
elements["PNT_83"] = default_2_position_tumb(_("Stabilize"),devices.RADAR, device_commands.RADAR_stab_switch, cockpit_args.RADAR_stab_switch)
elements["PNT_84"] = default_springloaded_3pos_switch(_("VSL switch"), devices.RADAR, device_commands.RADAR_VSL_switch, device_commands.RADAR_VSL_switch, -1, 0, 1, cockpit_args.RADAR_VSL_switch)

--
-- RIO TCS controls
elements["PNT_85"] = default_axis(_("TCS Trim azimuth"),devices.TCS, device_commands.TCS_Trim_az, cockpit_args.TCS_Trim_az, 0.0)
elements["PNT_86"] = default_axis(_("TCS Trim elevation"),devices.TCS, device_commands.TCS_Trim_el, cockpit_args.TCS_Trim_el, 0.0)
elements["PNT_87"] = default_3_position_tumb(_("TCS Acquisition"), devices.TCS, device_commands.TCS_ACQ_switch, cockpit_args.TCS_ACQ_switch, false, true)
elements["PNT_88"] = default_2_position_tumb(_("TCS FOV"),devices.TCS, device_commands.TCS_FOV_button, cockpit_args.TCS_FOV_button)
elements["PNT_88"].arg_lim  = {{-1,1},{-1,1}}
elements["PNT_88"].arg_value  = {2,-2}
elements["PNT_89"] = default_3_position_tumb(_("TCS Slave"), devices.TCS, device_commands.TCS_Slave_switch, cockpit_args.TCS_Slave_switch, false, true)
elements["PNT_90"] = default_3_position_tumb(_("Record power (no function)"), devices.TCS, device_commands.RECORD_power, cockpit_args.RECORD_power, false, true)
elements["PNT_91"] = multiposition_switch_limited(_("Record mode (no function)"), devices.TCS, device_commands.RECORD_mode, cockpit_args.RECORD_mode, 5, 1.0/4.0, false)
elements["PNT_16016"] = default_axis(_("Record reset (no function)"), devices.TCS, device_commands.RECORD_Knob_Reset, cockpit_args.RECORD_Knob_Reset, 1.0, 0.1, true, true)

-- RIO armament panel
elements["PNT_59"] = multiposition_switch_limited(_("Weapon type wheel"), devices.WEAPONS, device_commands.WEAP_Type_Wheel, cockpit_args.WEAP_Type_Wheel, 44, 1.0/43.0, false)
elements["PNT_59"].sound = {{SOUND_SPRINGY2_KNOB},{SOUND_SPRINGY2_KNOB}}



elements["PNT_59"].animated = {true, true}
elements["PNT_59"].animation_speed = {0.4, 0.4}
elements["PNT_9960"] = multiposition_roller_limited(_("Weapon Interval x10ms"), devices.WEAPONS, device_commands.WEAP_Interval_10s, cockpit_args.WEAP_Interval_10s, 10, false)
elements["PNT_9961"] = multiposition_roller_limited(_("Weapon Interval x100ms"), devices.WEAPONS, device_commands.WEAP_Interval_100s, cockpit_args.WEAP_Interval_100s, 10, false)
elements["PNT_9962"] = multiposition_roller_limited(_("Weapon Quantity 10s"), devices.WEAPONS, device_commands.WEAP_Quantity_10s, cockpit_args.WEAP_Quantity_10s, 10, false)
elements["PNT_9962"].arg_lim = {{0,0.3333}}
elements["PNT_9963"] = multiposition_roller_limited(_("Weapon Quantity 1s"), devices.WEAPONS, device_commands.WEAP_Quantity_1s, cockpit_args.WEAP_Quantity_1s, 10, false)

elements["PNT_2022"] = multiposition_switch_limited(_("Attack mode"), devices.WEAPONS, device_commands.WEAP_ATTK_Mode, cockpit_args.WEAP_ATTK_Mode, 5, 0.25, false)
elements["PNT_2022"].sound = {{SOUND_PLASTICY_KNOB},{SOUND_PLASTICY_KNOB}}
elements["PNT_58"] = multiposition_switch_limited(_("Elec fuse"), devices.WEAPONS, device_commands.WEAP_Elec_Fuse, cockpit_args.WEAP_Elec_Fuse, 5, 0.25, false)
elements["PNT_58"].sound = {{SOUND_PLASTICY_KNOB},{SOUND_PLASTICY_KNOB}}
elements["PNT_72"] = multiposition_switch_limited(_("Missile speed gate"), devices.WEAPONS, device_commands.WEAP_MSL_SPD_Gate, cockpit_args.WEAP_MSL_SPD_Gate, 6, 0.2, false)
elements["PNT_72"].sound = {{SOUND_PLASTICY_KNOB},{SOUND_PLASTICY_KNOB}}
elements["PNT_78"] = default_springloaded_3pos_switch(_("Selective jettison"), devices.WEAPONS, device_commands.WEAP_Selective_Jett, device_commands.WEAP_Selective_Jett, -1, 0, 1, cockpit_args.WEAP_Selective_Jett)
elements["PNT_1069"] = default_animated_lever(_("Jettison aux guard"), devices.WEAPONS, device_commands.WEAP_Selective_Jett_cover, cockpit_args.SEL_JETT_GUARD,8,{0.0,1.0})
elements["PNT_63"] = default_3_position_tumb(_("Mech fuse"), devices.WEAPONS, device_commands.WEAP_Mech_Fuse, cockpit_args.WEAP_Mech_Fuse, false)
elements["PNT_75"] = default_3_position_tumb(_("Missile option"), devices.WEAPONS, device_commands.WEAP_Missile_Option, cockpit_args.WEAP_Missile_Option, false)

elements["PNT_60"] = default_2_position_tumb(_("Bomb single/pairs"),devices.WEAPONS, device_commands.WEAP_Bomb_SinglePairs, cockpit_args.WEAP_Bomb_SinglePairs)
elements["PNT_61"] = default_2_position_tumb(_("Bomb step/ripple"),devices.WEAPONS, device_commands.WEAP_Bomb_StepRipple, cockpit_args.WEAP_Bomb_StepRipple)
elements["PNT_62"] = default_2_position_tumb(_("A/G gun mode"),devices.WEAPONS, device_commands.WEAP_AG_Gun, cockpit_args.WEAP_AG_Gun)
elements["PNT_66"] = default_2_position_tumb(_("Jettison racks/weapons"),devices.WEAPONS, device_commands.WEAP_Jett_RackWeapons, cockpit_args.WEAP_Jett_RackWeapons)
elements["PNT_73"] = default_2_position_tumb(_("Jettison left tank"),devices.WEAPONS, device_commands.WEAP_Jett_LeftTank, cockpit_args.WEAP_Jett_LeftTank)
elements["PNT_67"] = default_2_position_tumb(_("Jettison right tank"),devices.WEAPONS, device_commands.WEAP_Jett_RightTank, cockpit_args.WEAP_Jett_RightTank)
elements["PNT_68"] = default_3_position_tumb(_("Jettison station 1"),devices.WEAPONS, device_commands.WEAP_Jett_Station1, cockpit_args.WEAP_Jett_Station1)
elements["PNT_65"] = default_2_position_tumb(_("Jettison station 3"),devices.WEAPONS, device_commands.WEAP_Jett_Station3, cockpit_args.WEAP_Jett_Station3)
elements["PNT_69"] = default_2_position_tumb(_("Jettison station 4"),devices.WEAPONS, device_commands.WEAP_Jett_Station4, cockpit_args.WEAP_Jett_Station4)
elements["PNT_70"] = default_2_position_tumb(_("Jettison station 5"),devices.WEAPONS, device_commands.WEAP_Jett_Station5, cockpit_args.WEAP_Jett_Station5)
elements["PNT_64"] = default_2_position_tumb(_("Jettison station 6"),devices.WEAPONS, device_commands.WEAP_Jett_Station6, cockpit_args.WEAP_Jett_Station6)
elements["PNT_71"] = default_3_position_tumb(_("Jettison station 8"),devices.WEAPONS, device_commands.WEAP_Jett_Station8, cockpit_args.WEAP_Jett_Station8)

elements["PNT_74"] = default_button(_("A/A Launch"), devices.WEAPONS, device_commands.WEAP_AA_Launch, cockpit_args.WEAP_AA_Launch)
elements["PNT_9964"] = default_button(_("Next Launch"), devices.TID, device_commands.WEAP_Next_launch, cockpit_args.WEAP_Next_launch)


-- Computer Address Panel (CAP)
elements["PNT_98"] = multiposition_switch_limited(_("CAP category"), devices.CAP, device_commands.CAP_category, cockpit_args.CAP_category, 6, 0.2, false)
elements["PNT_98"].sound = {{SOUND_PLASTICY_KNOB},{SOUND_PLASTICY_KNOB}}


elements["PNT_98"].animated = {true, true}
elements["PNT_98"].animation_speed = {1, 1}

elements["PNT_123"] = default_button(_("CAP btn 4"), devices.CAP, device_commands.CAP_button4, cockpit_args.CAP_button4)
elements["PNT_123"].sound = {{SOUND_GENERICBUTTON1, SOUND_TINY_KNOB_BETTER},{SOUND_GENERICBUTTON1, SOUND_TINY_KNOB_BETTER }}

elements["PNT_124"] = default_button(_("CAP btn 5"), devices.CAP, device_commands.CAP_button5, cockpit_args.CAP_button5)
elements["PNT_124"].sound = {{SOUND_GENERICBUTTON1, SOUND_TINY_KNOB_BETTER},{SOUND_GENERICBUTTON1, SOUND_TINY_KNOB_BETTER }}

elements["PNT_125"] = default_button(_("CAP btn 3"), devices.CAP, device_commands.CAP_button3, cockpit_args.CAP_button3)
elements["PNT_125"].sound = {{SOUND_GENERICBUTTON1, SOUND_TINY_KNOB_BETTER},{SOUND_GENERICBUTTON1, SOUND_TINY_KNOB_BETTER }}

elements["PNT_126"] = default_button(_("CAP btn 2"), devices.CAP, device_commands.CAP_button2, cockpit_args.CAP_button2)
elements["PNT_126"].sound = {{SOUND_GENERICBUTTON2, SOUND_TINY_KNOB_BETTER},{SOUND_GENERICBUTTON1, SOUND_TINY_KNOB_BETTER }}

elements["PNT_127"] = default_button(_("CAP btn 1"), devices.CAP, device_commands.CAP_button1, cockpit_args.CAP_button1)
elements["PNT_127"].sound = {{SOUND_GENERICBUTTON1, SOUND_TINY_KNOB_BETTER},{SOUND_GENERICBUTTON1, SOUND_TINY_KNOB_BETTER }}

elements["PNT_128"] = default_button(_("CAP TNG NBR"), devices.CAP, device_commands.CAP_tng_nbr, cockpit_args.CAP_tng_nbr)

elements["PNT_129"] = default_button(_("CAP btn 10"), devices.CAP, device_commands.CAP_button10, cockpit_args.CAP_button10)
elements["PNT_129"].sound = {{SOUND_GENERICBUTTON2, SOUND_TINY_KNOB_BETTER},{SOUND_GENERICBUTTON1, SOUND_TINY_KNOB_BETTER }}

elements["PNT_130"] = default_button(_("CAP btn 9"), devices.CAP, device_commands.CAP_button9, cockpit_args.CAP_button9)
elements["PNT_130"].sound = {{SOUND_GENERICBUTTON1, SOUND_TINY_KNOB_BETTER},{SOUND_GENERICBUTTON1, SOUND_TINY_KNOB_BETTER }}

elements["PNT_131"] = default_button(_("CAP btn 8"), devices.CAP, device_commands.CAP_button8, cockpit_args.CAP_button8)
elements["PNT_131"].sound = {{SOUND_GENERICBUTTON2, SOUND_TINY_KNOB_BETTER},{SOUND_GENERICBUTTON1, SOUND_TINY_KNOB_BETTER }}

elements["PNT_132"] = default_button(_("CAP btn 7"), devices.CAP, device_commands.CAP_button7, cockpit_args.CAP_button7)
elements["PNT_132"].sound = {{SOUND_GENERICBUTTON1, SOUND_TINY_KNOB_BETTER},{SOUND_GENERICBUTTON1, SOUND_TINY_KNOB_BETTER }}

elements["PNT_133"] = default_button(_("CAP btn 6"), devices.CAP, device_commands.CAP_button6, cockpit_args.CAP_button6)
elements["PNT_133"].sound = {{SOUND_GENERICBUTTON1, SOUND_TINY_KNOB_BETTER},{SOUND_GENERICBUTTON1, SOUND_TINY_KNOB_BETTER }}

elements["PNT_134"] = default_button(_("CAP PGM RSTRT"), devices.CAP, device_commands.CAP_program_restart, cockpit_args.CAP_program_restart)

elements["PNT_136"] = default_cap_button(_("CAP LONG 6"), devices.CAP, device_commands.CAP_LONG_6, cockpit_args.CAP_LONG_6)
elements["PNT_136"].sound = {{SOUND_GENERICBUTTON1, SOUND_BUTTONUP},{SOUND_GENERICBUTTON1, SOUND_BUTTONUP}}

elements["PNT_137"] = default_cap_button(_("CAP LAT 1"), devices.CAP, device_commands.CAP_LAT_1, cockpit_args.CAP_LAT_1)
elements["PNT_138"] = default_cap_button(_("CAP NBR 2"), devices.CAP, device_commands.CAP_NBR_2, cockpit_args.CAP_NBR_2)
elements["PNT_139"] = default_cap_button(_("CAP 7"), devices.CAP, device_commands.CAP_7, cockpit_args.CAP_7)
elements["PNT_140"] = default_cap_button(_("CAP HDG 8"), devices.CAP, device_commands.CAP_HDG_8, cockpit_args.CAP_HDG_8)
elements["PNT_141"] = default_cap_button(_("CAP SPD 3"), devices.CAP, device_commands.CAP_SPD_3, cockpit_args.CAP_SPD_3)
elements["PNT_143"] = default_cap_button(_("CAP ALT 4"), devices.CAP, device_commands.CAP_ALT_4, cockpit_args.CAP_ALT_4)
elements["PNT_142"] = default_cap_button(_("CAP 9"), devices.CAP, device_commands.CAP_9, cockpit_args.CAP_9)
elements["PNT_144"] = default_cap_button(_("CAP BRG 0"), devices.CAP, device_commands.CAP_BRG_0, cockpit_args.CAP_BRG_0)
elements["PNT_145"] = default_cap_button(_("CAP RNG 5"), devices.CAP, device_commands.CAP_RNG_5, cockpit_args.CAP_RNG_5)
elements["PNT_146"] = default_cap_button(_("CAP N+E"), devices.CAP, device_commands.CAP_NE, cockpit_args.CAP_NE)
elements["PNT_147"] = default_cap_button(_("CAP S-W"), devices.CAP, device_commands.CAP_SW, cockpit_args.CAP_SW)
elements["PNT_148"] = default_cap_button(_("CAP clear"), devices.CAP, device_commands.CAP_clear, cockpit_args.CAP_clear)
elements["PNT_149"] = default_cap_button(_("CAP enter"), devices.CAP, device_commands.CAP_enter, cockpit_args.CAP_enter)

-- datalink
elements["PNT_413"] = default_3_position_tumb(_("Datalink Power"), devices.DATALINK, device_commands.DATALINK_power, cockpit_args.DATALINK_ON_OFF_SW, false, true)
elements["PNT_175"] = default_2_position_tumb(_("Datalink Antenna (no function)"), devices.DATALINK, device_commands.DATALINK_antenna_pos, cockpit_args.DATALINK_Antenna)
elements["PNT_176"] = default_2_position_tumb(_("Datalink Reply (no function)"), devices.DATALINK, device_commands.DATALINK_reply, cockpit_args.DATALINK_Reply)
elements["PNT_177"] = default_2_position_tumb(_("Datalink CAINS/TAC"), devices.DATALINK, device_commands.DATALINK_tac_cains, cockpit_args.DATALINK_Cains)
elements["PNT_191"] = default_3_position_tumb(_("Datalink Antijam (no function)"), devices.DATALINK, device_commands.DATALINK_antijam, cockpit_args.DATALINK_antijam, false, true)
elements["PNT_196"] = multiposition_roller_limited(_("Datalink freq 10MHz"), devices.DATALINK, device_commands.DATALINK_freq_10s, cockpit_args.DATALINK_freq_10s, 10, false)
--elements["PNT_196"].cycle=true
elements["PNT_195"] = multiposition_roller_limited(_("Datalink freq 1MHz"), devices.DATALINK, device_commands.DATALINK_freq_1s, cockpit_args.DATALINK_freq_1s, 10, false)
--elements["PNT_195"].cycle=true
elements["PNT_197"] = multiposition_roller_limited(_("Datalink freq 100kHz"), devices.DATALINK, device_commands.DATALINK_freq_tenths, cockpit_args.DATALINK_freq_tenths, 10, false)
--elements["PNT_197"].cycle=true
elements["PNT_222"] = multiposition_roller_limited(_("Datalink address high"), devices.DATALINK, device_commands.DATALINK_addr_hi, cockpit_args.DATALINK_addr_hi, 10, false)
--elements["PNT_222"].cycle=true
elements["PNT_223"] = multiposition_roller_limited(_("Datalink address low"), devices.DATALINK, device_commands.DATALINK_addr_lo, cockpit_args.DATALINK_addr_lo, 10, false)
--elements["PNT_223"].cycle=true
elements["PNT_118"] = multiposition_switch_limited(_("Beacon mode"), devices.DATALINK, device_commands.BEACON_mode_knob, cockpit_args.BEACON_mode_knob, 7, 0.166667, false)
elements["PNT_117"] = default_button(_("ACLS test"), devices.DATALINK, device_commands.BEACON_ACLS_test_button, cockpit_args.BEACON_ACLS_test_button)
elements["PNT_117"].updatable = true
elements["PNT_96"] = default_3_position_tumb(_("Beacon Power"), devices.DATALINK, device_commands.BEACON_power_switch, cockpit_args.BEACON_power_switch, false, true)

-- IFF panel
elements["PNT_161"] = default_3_position_tumb(_("IFF audio/light (no function)"), devices.IFF, device_commands.IFF_audiolight_switch, cockpit_args.IFF_audiolight_switch, false, false)
elements["PNT_162"] = default_3_position_tumb(_("IFF M1 (no function)"), devices.IFF, device_commands.IFF_M1_switch, cockpit_args.IFF_M1_switch, false, false)
elements["PNT_163"] = default_3_position_tumb(_("IFF M2 (no function)"), devices.IFF, device_commands.IFF_M2_switch, cockpit_args.IFF_M2_switch, false, false)
elements["PNT_164"] = default_3_position_tumb(_("IFF M3/A (no function)"), devices.IFF, device_commands.IFF_M3A_switch, cockpit_args.IFF_M3A_switch, false, false)
elements["PNT_165"] = default_3_position_tumb(_("IFF MC (no function)"), devices.IFF, device_commands.IFF_MC_switch, cockpit_args.IFF_MC_switch, false, false)
elements["PNT_166"] = default_3_position_tumb(_("IFF RAD (no function)"), devices.IFF, device_commands.IFF_RAD_switch, cockpit_args.IFF_RAD_switch, false, false)
elements["PNT_167"] = default_3_position_tumb(_("IFF Ident (no function)"), devices.IFF, device_commands.IFF_ident_switch, cockpit_args.IFF_ident_switch, false, false)
elements["PNT_181"] = default_2_position_tumb(_("IFF M4 (no function)"), devices.IFF, device_commands.IFF_M4_switch, cockpit_args.IFF_M4_switch)
elements["PNT_183"] = multiposition_switch_limited(_("IFF code (no function)"), devices.IFF, device_commands.IFF_code_knob, cockpit_args.IFF_code_knob, 4, 1.0/3.0, false)
elements["PNT_184"] = multiposition_switch_limited(_("IFF master (no function)"), devices.IFF, device_commands.IFF_master_knob, cockpit_args.IFF_master_knob, 5, 1.0/4.0, false)
elements["PNT_185"] = default_button(_("IFF test (no function)"), devices.IFF, device_commands.IFF_test_button, cockpit_args.IFF_test_button)
elements["PNT_186"] = default_button(_("IFF reply (no function)"), devices.IFF, device_commands.IFF_reply_button, cockpit_args.IFF_reply_button)

elements["PNT_2262"] = multiposition_roller_limited(_("IFF M3 code ---x (no function)"), devices.IFF, device_commands.IFF_M3code_1s, cockpit_args.IFF_M3code_1s, 8, false, 0.77777)
--elements["PNT_2262"].cycle = true
elements["PNT_2261"] = multiposition_roller_limited(_("IFF M3 code --x- (no function)"), devices.IFF, device_commands.IFF_M3code_10s, cockpit_args.IFF_M3code_10s, 8, false, 0.77777)
--elements["PNT_2261"].cycle = true
elements["PNT_198"] = multiposition_roller_limited(_("IFF M3 code -x-- (no function)"), devices.IFF, device_commands.IFF_M3code_100s, cockpit_args.IFF_M3code_100s, 8, false, 0.77777)
--elements["PNT_198"].cycle = true
elements["PNT_199"] = multiposition_roller_limited(_("IFF M3 code x--- (no function)"), devices.IFF, device_commands.IFF_M3code_1000s, cockpit_args.IFF_M3code_1000s, 8, false, 0.77777)
--elements["PNT_199"].cycle = true
elements["PNT_200"] = multiposition_roller_limited(_("IFF M1 code -x (no function)"), devices.IFF, device_commands.IFF_M1code_1s, cockpit_args.IFF_M1code_1s, 4, false, 0.33333)
--elements["PNT_200"].cycle = true
elements["PNT_201"] = multiposition_roller_limited(_("IFF M1 code x- (no function)"), devices.IFF, device_commands.IFF_M1code_10s, cockpit_args.IFF_M1code_10s, 8, false, 0.77777)
--elements["PNT_201"].cycle = true

-- LIQUID cooling
elements["PNT_95"] = default_3_position_tumb(_("Liquid cooling"), devices.RADAR, device_commands.LIQUID_cooling_switch, cockpit_args.LIQUID_cooling_switch, false, true)

-- LANTIRN
elements["PNT_667"] = multiposition_switch_limited(_("LANTIRN Power"), devices.LANTIRN, device_commands.LANTIRN_PowerMode, cockpit_args.LANTIRN_RotaryKnob, 3, 1.0/2.0, false)
elements["PNT_668"] = default_2_position_tumb(_("LANTIRN Laser Arm Switch"), devices.LANTIRN, device_commands.LANTIRN_Laser_ARM, cockpit_args.LANTIRN_Laser)
elements["PNT_670"] = default_button(_("Video Output Toggle (TCS/LANTIRN)"), devices.TID, device_commands.LANTIRN_TCS_Select_Toggle, cockpit_args.LANTIRN_Video)
elements["PNT_670"].updatable = true
elements["PNT_669"] = default_button(_("LANTIRN Operate Mode (Unstow)"), devices.LANTIRN, device_commands.LANTIRN_OPER_STBY_Toggle, cockpit_args.LANTIRN_MODE)
elements["PNT_669"].updatable = true
elements["PNT_671"] = default_button(_("LANTIRN IBIT"), devices.LANTIRN, device_commands.LANTIRN_IBIT, cockpit_args.LANTIRN_Button)
elements["PNT_671"].updatable = true


for i,o in pairs(elements) do
	if o.class[1] == class_type.TUMB or
	 (o.class[2] and o.class[2] == class_type.TUMB) or
	 (o.class[3] and o.class[3] == class_type.TUMB) then
	 o.updatable = true
	 o.use_OBB = true
	end
end
