dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."config.lua")
dofile(LockOn_Options.script_path.."VR_config.lua")
dofile(LockOn_Options.script_path.."sounds.lua")

local gettext = require("i_18n")
_ = gettext.translate

cursor_mode = 
{ 
    CUMODE_CLICKABLE = 0,
    CUMODE_CLICKABLE_AND_CAMERA  = 1,
    CUMODE_CAMERA = 2,
};

clickable_mode_initial_status  = cursor_mode.CUMODE_CLICKABLE

function default_button(hint_,device_,command_,arg_,arg_val_,arg_lim_, use_vr_)

	local   arg_val_ = arg_val_ or 1
	local   arg_lim_ = arg_lim_ or {0,1}
	local	side = {}
	if use_vr_ == true then
		side = {{BOX_SIDE_Y_bottom}}
	end

	return  {	
				class 				= {class_type.BTN},
				hint  				= hint_,
				device 				= device_,
				action 				= {command_},
				stop_action 		= {command_},
				arg 				= {arg_},
				arg_value			= {arg_val_}, 
				arg_lim 			= {arg_lim_},
				use_release_message = {true},
				side				= side,
			}
end

function default_button2(hint_,device_,command_,arg_,arg_val_,arg_lim_)
	local element = default_button(hint_,device_,command_,arg_,arg_val_,arg_lim_)
	element.side = {{BOX_SIDE_Z_bottom}}
	return element
end

function radio_channel_button(hint_,device_,command_,arg_)
	return  {	
				class 				= {class_type.BTN},
				hint  				= hint_,
				device 				= device_,
				action 				= {command_},
				arg 				= {arg_},
				arg_value			= {1}, 
				arg_lim 			= {{0,1}},
				use_release_message = {true},
				sound 				= {{SOUND_BTN_1}},
				side				= {{BOX_SIDE_Y_bottom}},
			}
end

function default_1_position_tumb(hint_, device_, command_, arg_, arg_val_, arg_lim_, use_vr_)
	local   arg_val_ = arg_val_ or 1
	local   arg_lim_ = arg_lim_ or {0,1}
	local	side = {}
	if use_vr_ == true then
		side = {{BOX_SIDE_Y_bottom}}
	end
	return  {	
				class 		= {class_type.TUMB},
				hint  		= hint_,
				device 		= device_,
				action 		= {command_},
				arg 	  	= {arg_},
				arg_value 	= {arg_val_}, 
				arg_lim   	= {arg_lim_},
				updatable 	= true, 
				use_OBB 	= true,
				sound 		= {{SOUND_TUMB_1}},
				side		= side,
			}
end

function default_2_position_tumb(hint_, device_, command_, arg_)
	return  {	
				class 		= {class_type.TUMB,class_type.TUMB},
				hint  		= hint_,
				device 		= device_,
				action 		= {command_,command_},
				arg 	  	= {arg_,arg_},
				arg_value 	= {1,-1}, 
				arg_lim   	= {{0,1},{0,1}},
				updatable 	= true, 
				use_OBB 	= true,
				sound 		= {{SOUND_TUMB_1}},
				side 		= {{BOX_SIDE_Z_bottom}, {BOX_SIDE_Z_top}},
			}
end

function default_button_fix(hint_,device_,command_,arg_)
	local element = default_2_position_tumb(hint_,device_,command_,arg_)
	element.class_vr = {class_type.BTN_FIX}
	element.side = {{BOX_SIDE_Y_bottom}}
	return element
end

function default_cover(hint_, device_, command_, arg_)
	return  {	
				class 		= {class_type.TUMB,class_type.TUMB},
				hint  		= hint_,
				device 		= device_,
				action 		= {command_,command_},
				arg 	  	= {arg_,arg_},
				arg_value 	= {1,-1}, 
				arg_lim   	= {{0,1},{0,1}},
				updatable 	= true, 
				use_OBB 	= true,
				sound 		= {{SOUND_TUMB_1}},
				side 		= {{BOX_SIDE_Y_bottom}, {BOX_SIDE_Z_bottom}},
			}
end

function default_3_position_tumb(hint_,device_,command_,arg_,cycled_,inversed_)
	local cycled = true
	
	
	local val =  1
	local side = {{BOX_SIDE_Z_top},{BOX_SIDE_Z_bottom}}
    if inversed_ then
        val = -1
		side = {{BOX_SIDE_Z_bottom}, {BOX_SIDE_Z_top}}
    end
	
	if cycled_ ~= nil then
	   cycled = cycled_
	end
	return  {	
				class 		= {class_type.TUMB,class_type.TUMB},
				hint  		= hint_,
				device 		= device_,
				action 		= {command_,command_},
				arg 	  	= {arg_,arg_},
				arg_value 	= {-val,val}, 
				arg_lim   	= {{-1,1},{-1,1}},
				updatable 	= true, 
				use_OBB 	= true,
				cycle       = cycled,
				sound 		= {{SOUND_TUMB_1}},
				side		= side,
			}
end

function default_axis(hint_,device_,command_,arg_, default_, gain_,updatable_,relative_,cycle_,attach_left_,attach_right_)
	
	local default = default_ or 1
	local gain = gain_ or 0.1
	local updatable = updatable_ or false
	local relative  = relative_ or false
	local cycled  = cycle_ or false
	
	return  {	
				class 			= {class_type.LEV},
				hint  			= hint_,
				device 			= device_,
				action 			= {command_},
				arg 	  		= {arg_},
				arg_value 		= {default}, 
				arg_lim   		= {{0,1}},
				updatable 		= updatable, 
				use_OBB 		= true,
				gain			= {gain},
				relative    	= {relative}, 
				cycle			= cycled,
				side			= {{BOX_SIDE_X_top, BOX_SIDE_X_bottom, BOX_SIDE_Z_top, BOX_SIDE_Z_bottom}},
				attach_left		= attach_left_ or nil,
				attach_right	= attach_right_ or nil,	
			}
end

function default_movable_axis(hint_,device_,command_,arg_, gain_)
	
	local gain = gain_ or 0.1
	
	return  {	
				class 			= {class_type.MOVABLE_LEV,class_type.MOVABLE_LEV},
				hint  			= hint_,
				device 			= device_,
				action 			= {command_,command_},
				arg 	  		= {arg_,arg_},
				arg_value 		= {1,-1}, 
				arg_lim   		= {{0,1},{0,1}},
				updatable 		= true, 
				use_OBB 		= true,
				gain			= {gain,gain},
				side			= {{BOX_SIDE_Z_bottom},{BOX_SIDE_Z_top}},
			}
end

function default_axis_limited(hint_,device_,command_,arg_, default_, gain_,updatable_,relative_, arg_lim_,attach_left_,attach_right_)
	
	local relative = false
	local default = default_ or 0
	local updatable = updatable_ or false
	if relative_ ~= nil then
		relative = relative_
	end

	local gain = gain_ or 0.1
	return  {	
				class 			= {class_type.LEV},
				hint  			= hint_,
				device 			= device_,
				action 			= {command_},
				arg 	  		= {arg_},
				arg_value 		= {default}, 
				arg_lim   		= {arg_lim_},
				updatable 		= updatable, 
				use_OBB 		= false,
				gain			= {gain},
				relative    	= {relative},  
				cycle			= false,
				side			= {{BOX_SIDE_X_top, BOX_SIDE_X_bottom, BOX_SIDE_Z_top, BOX_SIDE_Z_bottom}},
				attach_left		= attach_left_ or nil,
				attach_right	= attach_right_ or nil,	
			}
end


function multiposition_switch(hint_,device_,command_,arg_,count_,delta_,inversed_, min_)
    local min_   = min_ or 0
	local delta_ = delta_ or 0.5
	
    local inversed = 1
	local side = {{BOX_SIDE_Z_top},{BOX_SIDE_Z_bottom}}
    if inversed_ then
        inversed = -1
		side = {{BOX_SIDE_Z_bottom}, {BOX_SIDE_Z_top}}
    end
	
	return  {	
				class 		= {class_type.TUMB,class_type.TUMB},
				hint  		= hint_,
				device 		= device_,
				action 		= {command_,command_},
				arg 	  	= {arg_,arg_},
				arg_value 	= {-delta_ * inversed,delta_ * inversed}, 
				arg_lim   	= {{min_, min_ + delta_ * (count_ -1)},
							   {min_, min_ + delta_ * (count_ -1)}},
				updatable 	= true, 
				use_OBB 	= true,
				sound 		= {{SOUND_TUMB_2}},
				side		= side,
			}
end

function multiposition_switch_limited(hint_,device_,command_,arg_,count_,delta_,inversed_,min_)
    local min_   = min_ or 0
	local delta_ = delta_ or 0.5
	
    local inversed = 1
	local side = {{BOX_SIDE_Z_top},{BOX_SIDE_Z_bottom}}
    if inversed_ then
        inversed = -1
		side = {{BOX_SIDE_Z_bottom}, {BOX_SIDE_Z_top}}
    end
	
	return  {	
				class 		= {class_type.TUMB,class_type.TUMB},
				hint  		= hint_,
				device 		= device_,
				action 		= {command_,command_},
				arg 	  	= {arg_,arg_},
				arg_value 	= {-delta_ * inversed,delta_ * inversed}, 
				arg_lim   	= {{min_, min_ + delta_ * (count_ -1)},
							   {min_, min_ + delta_ * (count_ -1)}},
				updatable 	= true, 
				use_OBB 	= true,
				cycle     	= false,
				side		= side,
			}
end

function default_button_axis(hint_, device_,command_1, command_2, arg_1, arg_2, limit_1, limit_2, attach_left_, attach_right_)
	local limit_1_   = limit_1 or 1.0
	local limit_2_   = limit_2 or 1.0
	return {
				class			= {class_type.BTN, class_type.LEV},
				hint			= hint_,
				device			= device_,
				action			= {command_1, command_2},
				stop_action 	= {command_1, 0},
				arg				= {arg_1, arg_2},
				arg_value		= {1, 0.5},
				arg_lim			= {{0, limit_1_}, {0,limit_2_}},
				gain 			= {0, 0.1},
				relative		= {false, false},
				updatable 		= true, 
				use_OBB 		= true,
				use_release_message = {true, false},
				cycle 			= false,
				side			= {{BOX_SIDE_Y_bottom},{BOX_SIDE_X_top, BOX_SIDE_X_bottom, BOX_SIDE_Z_top, BOX_SIDE_Z_bottom}},
				attach_left		= attach_left_ or nil,
				attach_right	= attach_right_ or nil,	
			}
end

function default_animated_lever(hint_, device_, command_, arg_, animation_speed_,arg_lim_,arg_value_)

	local arg_lim = arg_lim_ or {0.0,1.0}
	local arg_value = arg_value_ or 1.0
	return  {	
				class  		= {class_type.TUMB, class_type.TUMB},
				hint   		= hint_, 
				device 		= device_,
				action 		= {command_, command_},
				arg 		= {arg_, arg_},
				arg_value 	= {arg_value, -arg_value},
				arg_lim 	= {arg_lim, arg_lim},
				updatable  	= true, 
				gain 		= {0.1, 0.1},
				animated 	= {true, true},
				animation_speed = {animation_speed_, animation_speed_},
				side		= {{BOX_SIDE_Z_bottom},{BOX_SIDE_Z_top}},
			}
end

function default_button_tumb(hint_, device_, command1_, command2_, arg_)
	return  {	
				class 		= {class_type.BTN,class_type.TUMB},
				hint  		= hint_,
				device 		= device_,
				action 		= {command1_,command2_},
				stop_action = {command1_,0},
				arg 	  	= {arg_,arg_},
				arg_value 	= {-1,1}, 
				arg_lim   	= {{-1,0},{0,1}},
				updatable 	= true, 
				use_OBB 	= true,
				use_release_message = {true,false},
				side		= {{BOX_SIDE_Z_top},{BOX_SIDE_Z_bottom}},
			}
end

function triple_switch(hint_,device_,command_,arg_)
	
	return  {	
				class 		= {class_type.TUMB},
				hint  		= hint_,
				device 		= device_,
				action 		= {command_,command_,command_,command_},
				arg 	  	= {arg_,arg_,arg_,arg_},
				--				left		right		up 			senter	
				arg_value 	= {		0.1,		0.3,	   0.2, 	 -0.2}, 
				arg_lim   	= {	{0, 0.3},  {0, 0.3},  {0, 0.2},  {0, 0.2}},
				updatable 	= true, 
				use_OBB 	= true,
				sound 		= {{SOUND_TUMB_SMALL_DOWN,SOUND_TUMB_SMALL_UP},{SOUND_TUMB_SMALL_DOWN,SOUND_TUMB_SMALL_UP},{SOUND_TUMB_SMALL_DOWN,SOUND_TUMB_SMALL_UP},{SOUND_TUMB_SMALL_DOWN,SOUND_TUMB_SMALL_UP}},
				class_vr 	= {class_type.TUMB_4SIDE,class_type.TUMB_4SIDE,class_type.TUMB_4SIDE,class_type.TUMB_4SIDE},
				side		= {{BOX_SIDE_X_top},{BOX_SIDE_X_bottom},{BOX_SIDE_Z_bottom},{BOX_SIDE_Z_top}},
			}
end

function triple_switch2(hint_,device_,command_,arg_)
	
	return  {	
				class 		= {class_type.TUMB},
				hint  		= hint_,
				device 		= device_,
				action 		= {command_,command_,command_,command_},
				arg 	  	= {arg_,arg_,arg_,arg_},
				--				  right		   left        up		senter	
				arg_value 	= {		0.1,		0.2,	   0.3, 	 -0.3}, 
				arg_lim   	= {	{0, 0.3},  {0, 0.2},  {0, 0.3},  {0, 0.3}},
				updatable 	= true, 
				use_OBB 	= true,
				sound 		= {{SOUND_TUMB_SMALL_DOWN,SOUND_TUMB_SMALL_UP},{SOUND_TUMB_SMALL_DOWN,SOUND_TUMB_SMALL_UP},{SOUND_TUMB_SMALL_DOWN,SOUND_TUMB_SMALL_UP},{SOUND_TUMB_SMALL_DOWN,SOUND_TUMB_SMALL_UP}},
				class_vr 	= {class_type.TUMB_4SIDE,class_type.TUMB_4SIDE,class_type.TUMB_4SIDE,class_type.TUMB_4SIDE},
				side		= {{BOX_SIDE_X_bottom},{BOX_SIDE_X_top},{BOX_SIDE_Z_bottom},{BOX_SIDE_Z_top}},
			}
end


-- TF-51D
elements = {}

--Right Swich Panel
elements["pnt_102"] = default_2_position_tumb(_("Generator Disconnect"),devices.RIGHT_SWITCH_PANEL, device_commands.Button_3,102)
elements["pnt_102_1"] = default_1_position_tumb(_("Generator Connect") ,devices.RIGHT_SWITCH_PANEL,device_commands.Button_13,102,1,{1,1})
elements["pnt_102_0"] = default_1_position_tumb(_("Generator Disconnect") ,devices.RIGHT_SWITCH_PANEL,device_commands.Button_13,102,0,{0,0})

elements["pnt_103"] = default_2_position_tumb(_("Battery Disconnect"),devices.RIGHT_SWITCH_PANEL, device_commands.Button_1,103)
elements["pnt_103_1"] = default_1_position_tumb(_("Battery Connect") ,devices.RIGHT_SWITCH_PANEL,device_commands.Button_12,103,1,{1,1})
elements["pnt_103_0"] = default_1_position_tumb(_("Battery Disconnect") ,devices.RIGHT_SWITCH_PANEL,device_commands.Button_12,103,0,{0,0})

elements["pnt_104"] = default_2_position_tumb(_("Gun Heating"),devices.RIGHT_SWITCH_PANEL, device_commands.Button_19,104)
elements["pnt_104_1"] = default_1_position_tumb(_("Gun Heating On") ,devices.RIGHT_SWITCH_PANEL,device_commands.Button_26,104,1,{1,1})
elements["pnt_104_0"] = default_1_position_tumb(_("Gun Heating Off") ,devices.RIGHT_SWITCH_PANEL,device_commands.Button_26,104,0,{0,0})

elements["pnt_105"] = default_2_position_tumb(_("Pitot Heating"),devices.RIGHT_SWITCH_PANEL, device_commands.Button_5,105)
elements["pnt_105_1"] = default_1_position_tumb(_("Pitot Heating On") ,devices.RIGHT_SWITCH_PANEL,device_commands.Button_14,105,1,{1,1})
elements["pnt_105_0"] = default_1_position_tumb(_("Pitot Heating Off") ,devices.RIGHT_SWITCH_PANEL,device_commands.Button_14,105,0,{0,0})

elements["pnt_106"]	= default_3_position_tumb(_("Wing Position Lights Bright/Off/Dim") ,devices.RIGHT_SWITCH_PANEL,device_commands.Button_8,106,false)
elements["pnt_106_1"] = default_1_position_tumb(_("Wing Position Lights Bright/Off") ,devices.RIGHT_SWITCH_PANEL,device_commands.Button_15,106,1,{0,1})
elements["pnt_106_0"] = default_1_position_tumb(_("Wing Position Lights Dim/Off") ,devices.RIGHT_SWITCH_PANEL,device_commands.Button_15,106,-1,{-1,0})

elements["pnt_107"]	= default_3_position_tumb(_("Tail Position Lights Bright/Off/Dim") ,devices.RIGHT_SWITCH_PANEL,device_commands.Button_9,107,false)
elements["pnt_107_1"] = default_1_position_tumb(_("Tail Position Lights Bright/Off") ,devices.RIGHT_SWITCH_PANEL,device_commands.Button_16,107,1,{0,1})
elements["pnt_107_0"] = default_1_position_tumb(_("Tail Position Lights Dim/Off") ,devices.RIGHT_SWITCH_PANEL,device_commands.Button_16,107,-1,{-1,0})

elements["pnt_108"]	= default_3_position_tumb(_("Red Recognition Light Key/Off/Steady") ,devices.RIGHT_SWITCH_PANEL,device_commands.Button_21,108,false, true)
elements["pnt_108_0"] = default_1_position_tumb(_("Red Recognition Light Steady/Off") ,devices.RIGHT_SWITCH_PANEL,device_commands.Button_27,108,1,{0,1})
elements["pnt_108_1"] = default_1_position_tumb(_("Red Recognition Light Key/Off") ,devices.RIGHT_SWITCH_PANEL,device_commands.Button_27,108,-1,{-1,0})

elements["pnt_109"]	= default_3_position_tumb(_("Green Recognition Light Key/Off/Steady") ,devices.RIGHT_SWITCH_PANEL,device_commands.Button_22,109,false, true)
elements["pnt_109_0"] = default_1_position_tumb(_("Green Recognition Light Steady/Off") ,devices.RIGHT_SWITCH_PANEL,device_commands.Button_28,109,1,{0,1})
elements["pnt_109_1"] = default_1_position_tumb(_("Green Recognition Light Key/Off") ,devices.RIGHT_SWITCH_PANEL,device_commands.Button_28,109,-1,{-1,0})

elements["pnt_110"]	= default_3_position_tumb(_("Amber Recognition Light Key/Off/Steady") ,devices.RIGHT_SWITCH_PANEL,device_commands.Button_23,110,false, true)
elements["pnt_110_0"] = default_1_position_tumb(_("Amber Recognition Light Steady/Off") ,devices.RIGHT_SWITCH_PANEL,device_commands.Button_29,110,1,{0,1})
elements["pnt_110_1"] = default_1_position_tumb(_("Amber Recognition Light Key/Off") ,devices.RIGHT_SWITCH_PANEL,device_commands.Button_29,110,-1,{-1,0})

elements["pnt_111"] = default_button(_("Recognition Lights Key"),devices.RIGHT_SWITCH_PANEL, device_commands.Button_24,111, nil, nil, true)
elements["pnt_112"] = default_button(_("Circuit Protectors Reset"),devices.RIGHT_SWITCH_PANEL, device_commands.Button_25,112, nil, nil, true)

elements["pnt_100"] = default_axis(_("Right Fluorescent Light"),devices.RIGHT_SWITCH_PANEL, device_commands.Button_7, 100, 0.0, 0.1, false, false, nil, {0,-120})
elements["pnt_90"] = default_axis(_("Left Fluorescent Light"),devices.LIGHT_SYSTEM, device_commands.Button_2, 90, 0.0, 0.1, false, false, nil, nil, {80,-45})

--Flight Instrument panel
elements["pnt_3"] = default_axis(_("Course Set"),devices.REMOTE_COMPASS, device_commands.Button_1, 3, 1.0, 0.1, false, true, nil, {125,-45}, {45,-45})
elements["pnt_13"] = default_button_axis(_("Heading Set/Cage"),devices.DIRECTIONAL_GYRO, device_commands.Button_3, device_commands.Button_1, 179, 13,1.0,1.0)
elements["pnt_13"].relative = {false,true}
elements["pnt_13"].animated  = {false,false}
elements["pnt_13"].gain  = {0,0.02}

elements["pnt_17"] = default_axis(_("Pitch Adjustment"),devices.ARTIFICIAL_HORIZON, device_commands.Button_2, 17, 1.0, 0.1, false, false)
elements["pnt_18"] = default_button_axis(_("Cage"),devices.ARTIFICIAL_HORIZON, device_commands.Button_1, device_commands.Button_3, 19, 18, 1.0,0.14)
elements["pnt_18"].class_vr = {class_type.BTN_FIX}

elements["pnt_7"] = { 
	class = {class_type.BTN, class_type.LEV}, 
	hint = _("Winding/Adjustment Clock"), 
	device = devices.CLOCK, 
	action = {device_commands.Button_1, device_commands.Button_2},
	stop_action = {device_commands.Button_1,  0}, 
	is_repeatable = {}, 
	arg = {8, 7}, 
	arg_value = {1.0, 0.04}, 
	arg_lim = {{0, 1},  {0, 1}}, 
	relative = {false,true}, 
	gain = {1.0,  0.1}, 
	use_release_message = {true, false}, 
	use_OBB = true,
	side			= {{BOX_SIDE_Y_bottom},{BOX_SIDE_X_top, BOX_SIDE_X_bottom, BOX_SIDE_Z_top, BOX_SIDE_Z_bottom}},
	attach_left		= {135,-45},
	attach_right	= {45,-45},	
}

elements["pnt_26"] = default_axis(_("Set Pressure"),devices.ALTIMETER, device_commands.Button_1, 26, 1.0, 0.4, false, true, nil, {70,-60})

--SCR-522A Control panel 

elements["pnt_117"] = radio_channel_button(_("Radio ON/OFF"),		devices.VHF_RADIO, device_commands.Button_1,117)
elements["pnt_118"] = radio_channel_button(_("A Channel Activate"), devices.VHF_RADIO, device_commands.Button_2,118)
elements["pnt_119"] = radio_channel_button(_("B Channel Activate"), devices.VHF_RADIO, device_commands.Button_3,119)
elements["pnt_120"] = radio_channel_button(_("C Channel Activate"), devices.VHF_RADIO, device_commands.Button_4,120)
elements["pnt_121"] = radio_channel_button(_("D Channel Activate"), devices.VHF_RADIO, device_commands.Button_5,121)

elements["pnt_127"] = default_2_position_tumb(_("Radio Lights Dimmer"),devices.VHF_RADIO, device_commands.Button_6, 127)
elements["pnt_116"] = default_axis(_("Radio Audio Volume "),devices.VHF_RADIO, device_commands.Button_15, 116, 1.0, 0.1, false, false, nil, {0,-120})

elements["pnt_44"]	= default_button(_("Microphone On"),devices.CPT_MECH,device_commands.Button_1,44)
elements["pnt_44"].updatable = true


elements["pnt_129"] = default_2_position_tumb(_("Switch Locking Lever"),devices.VHF_RADIO, device_commands.Button_17, 129)

elements["pnt_128_-1"] = default_button(_("Radio Mode Transmit") ,devices.VHF_RADIO,device_commands.Button_20,128,-1,{-1.0,0.0})
elements["pnt_128_0"] = default_1_position_tumb(_("Radio Mode Receive") ,devices.VHF_RADIO,device_commands.Button_21,128,0.0,{0.0,0.0})
elements["pnt_128_1"] = default_1_position_tumb(_("Radio Mode Remote") ,devices.VHF_RADIO,device_commands.Button_21,128,1.0,{1.0,1.0})

elements["pnt_128"] = {	
	class 		= {class_type.BTN,class_type.TUMB},
	hint  		= _("Radio Mode"),
	device 		= devices.VHF_RADIO,
	action 		= {device_commands.Button_8,device_commands.Button_7, device_commands.Button_8,device_commands.Button_7},
	stop_action = {device_commands.Button_8,0						, device_commands.Button_8,0},
	arg 	  	= {128,128											,128,128},
	arg_value 	= {-1,1												,-2,2}, 
	arg_lim   	= {{-1,0},{0,1}										,{-2,0},{-1,1}},
	updatable 	= true, 
	use_OBB 	= true,
	use_release_message = {true,false								,true,false},
	sound 		= {{SOUND_TUMB_1}},
	class_vr	= {nil,nil											,class_type.BTN,class_type.TUMB},
	side		= {{},{}											,{BOX_SIDE_Z_top},{BOX_SIDE_Z_bottom}},
}

--Front Switch Box
elements["pnt_71"] 		= default_axis(_("Cockpit Lights"),devices.FRONT_SWITCH_BOX, device_commands.Button_1, 71, 1.0, 0.1, false, false)

elements["pnt_66_0"] 	= default_1_position_tumb(_("Ignition Off"), devices.FRONT_SWITCH_BOX, device_commands.Button_5, 66, 0, {0,0})
elements["pnt_66_1"] 	= default_1_position_tumb(_("Ignition Right"), devices.FRONT_SWITCH_BOX, device_commands.Button_5, 66, 0, {0.1,0.1})
elements["pnt_66_2"] 	= default_1_position_tumb(_("Ignition Left"), devices.FRONT_SWITCH_BOX, device_commands.Button_5, 66, 0, {0.2,0.2})
elements["pnt_66_3"] 	= default_1_position_tumb(_("Ignition Both"), devices.FRONT_SWITCH_BOX, device_commands.Button_5, 66, 0, {0.3,0.3} )
elements["CLK_VAR2_pnt_66"]	= multiposition_switch_limited(_("Ignition"), devices.FRONT_SWITCH_BOX, device_commands.Button_2, 66, 4, 0.1,true)
elements["CLK_VAR2_pnt_66"].sound = {{SOUND_TUMB_2}}

elements["CLK_VAR2_pnt_67"]	= default_3_position_tumb(_("Gun control") ,devices.FRONT_SWITCH_BOX,device_commands.Button_7,67,false,true )
elements["pnt_67_1"]	= default_1_position_tumb(_("Gun And Camera On") ,devices.FRONT_SWITCH_BOX,device_commands.Button_12,67,1,{1,1} )
elements["pnt_67_0"]	= default_1_position_tumb(_("Gun And Camera Off") ,devices.FRONT_SWITCH_BOX,device_commands.Button_12,67,0,{0,0} )
elements["pnt_67_-1"]	= default_1_position_tumb(_("Camera On") ,devices.FRONT_SWITCH_BOX,device_commands.Button_12,67,-1,{-1,-1} )

elements["pnt_72"]		= default_button(_("Silence Landing Gear Warning Horn Cut Off"),devices.FRONT_SWITCH_BOX,device_commands.Button_8,72, nil, nil, true)

elements["pnt_69_1"] = default_1_position_tumb(_("Left Chemical Release"),devices.FRONT_SWITCH_BOX, device_commands.Button_13, 69, 1, {1,1} )
elements["pnt_69_0"] = default_1_position_tumb(_("Left Bomb Arm Off"),devices.FRONT_SWITCH_BOX, device_commands.Button_13, 69, 0, {0,0} )
elements["pnt_69_-1"] = default_1_position_tumb(_("Left Bomb Arm On"),devices.FRONT_SWITCH_BOX, device_commands.Button_13, 69, -1, {-1,-1} )
elements["CLK_VAR2_pnt_69"]	= default_3_position_tumb(_("Left Bomb Arm/Chemical") ,devices.FRONT_SWITCH_BOX,device_commands.Button_9,69,false,true )

elements["pnt_70_1"] = default_1_position_tumb(_("Right Chemical Release"),devices.FRONT_SWITCH_BOX, device_commands.Button_14, 70, 1, {1,1} )
elements["pnt_70_0"] = default_1_position_tumb(_("Right Bomb Arm Off"),devices.FRONT_SWITCH_BOX, device_commands.Button_14, 70, 0, {0,0} )
elements["pnt_70_-1"] = default_1_position_tumb(_("Right Bomb Arm On"),devices.FRONT_SWITCH_BOX, device_commands.Button_14, 70, -1, {-1,-1} )
elements["CLK_VAR2_pnt_70"]	= default_3_position_tumb(_("Right Bomb Arm/Chemical") ,devices.FRONT_SWITCH_BOX,device_commands.Button_10,70,false,true )

elements["pnt_68_0"] = default_1_position_tumb(_("Bombs and Rockets Safe"),devices.FRONT_SWITCH_BOX, device_commands.Button_15, 68, 0, {0,0} )
elements["pnt_68_1"] = default_1_position_tumb(_("Bombs Train Release"),devices.FRONT_SWITCH_BOX, device_commands.Button_15, 68, 0.1, {0.1,0.1} )
elements["pnt_68_2"] = default_1_position_tumb(_("Bombs Both Release"),devices.FRONT_SWITCH_BOX, device_commands.Button_15, 68, 0.2, {0.2,0.2} )
elements["pnt_68_3"] = default_1_position_tumb(_("Rockets Arm"),devices.FRONT_SWITCH_BOX, device_commands.Button_15, 68, 0.3, {0.3,0.3} )
elements["CLK_VAR2_pnt_68"]	= triple_switch2(_("Release Mode"), devices.FRONT_SWITCH_BOX, device_commands.Button_11, 68 )

--Engine Control Panel
elements["pnt_58"] = default_cover(_("Supercharger Switch Cover"),devices.ENGINE_CONTROL_PANEL, device_commands.Button_2,58 )
elements["pnt_58"].sound = {{SOUND_COVER_CLOSE, SOUND_COVER_OPEN}}

elements["pnt_57"] = {	
				class 		= {class_type.TUMB,class_type.BTN},
				hint  		= _("Supercharger Switch"),
				device 		= devices.ENGINE_CONTROL_PANEL,
				action 		= {device_commands.Button_2,device_commands.Button_2},
				stop_action = {0,device_commands.Button_2},
				arg 	  	= {58,58},
				arg_value 	= {-0.1,0.1}, 
				arg_lim   	= {{0,0.1},{0.1,0.2}},
				updatable 	= true, 
				use_OBB 	= true,
				use_release_message = {false,true},
			}

elements["pnt_57_0"] = default_1_position_tumb(_("Supercharger AUTO"), devices.ENGINE_CONTROL_PANEL, device_commands.Button_1, 57, 0, {0,0}, true)
elements["pnt_57_1"] = default_1_position_tumb(_("Supercharger LOW"), devices.ENGINE_CONTROL_PANEL, device_commands.Button_1, 57, 0.1, {0.1,0.1}, true)
elements["pnt_57_2"] = default_button(_("Supercharger HIGH"),devices.ENGINE_CONTROL_PANEL, device_commands.Button_1,57,0.2,{0.1,0.2}, true)



elements["pnt_60"]	= default_button(_("High Blower Lamp Test "),devices.ENGINE_CONTROL_PANEL,device_commands.Button_4,60, nil, nil, true)

elements["pnt_61_1"] = default_1_position_tumb(_("Fuel Booster On"),devices.ENGINE_CONTROL_PANEL, device_commands.Button_12,61,1,{1,1} )
elements["pnt_61_0"] = default_1_position_tumb(_("Fuel Booster Off"),devices.ENGINE_CONTROL_PANEL, device_commands.Button_12,61,0,{0,0} )
elements["pnt_61"] = default_2_position_tumb(_("Fuel Booster On/Off"),devices.ENGINE_CONTROL_PANEL, device_commands.Button_5,61 )

elements["pnt_62_1"] = default_button(_("Oil Dilute Activate"),devices.ENGINE_CONTROL_PANEL, device_commands.Button_7,62)
elements["pnt_62_1"].sound = {{SOUND_TUMB_1_OFF, SOUND_TUMB_1}}
elements["pnt_62"] = default_button2(_("Oil Dilute Activate"),devices.ENGINE_CONTROL_PANEL, device_commands.Button_13,62)

elements["pnt_63"] = default_button2(_("Starter Activate"),devices.ENGINE_CONTROL_PANEL, device_commands.Button_8,63)
elements["pnt_63"].sound = {{SOUND_TUMB_1_OFF, SOUND_TUMB_1}}
elements["pnt_64"] = default_cover(_("Starter Switch Cover"),devices.ENGINE_CONTROL_PANEL, device_commands.Button_9,64 )
elements["pnt_64"].sound = {{SOUND_COVER_CLOSE, SOUND_COVER_OPEN}}

elements["pnt_65_1"] = default_button(_("Primer Activate"),devices.ENGINE_CONTROL_PANEL, device_commands.Button_14,65)
elements["pnt_65"] = default_button2(_("Primer Activate"),devices.ENGINE_CONTROL_PANEL, device_commands.Button_11,65)
elements["pnt_65"].sound = {{SOUND_TUMB_1_OFF, SOUND_TUMB_1}}

--Oxygen Regulator
elements["pnt_131"] = default_2_position_tumb(_("Auto-Mix On-Off"),devices.OXYGEN_SYSTEM, device_commands.Button_3,131 )	

elements["pnt_130"]	= default_animated_lever(_("Oxygen Emergency By-pass"),devices.OXYGEN_SYSTEM, device_commands.Button_1,130,0.6,{0, 0.5},0.5 )					 

--Fuel system
elements["pnt_85_4"] = default_1_position_tumb(_("Select Right Combat Tank"), devices.FUEL_SYSTEM, device_commands.Button_4, 85, 0.0, {0.0,0.0} )
elements["pnt_85_1"] = default_1_position_tumb(_("Select Left Main Tank"), devices.FUEL_SYSTEM, device_commands.Button_4, 85, 0.1, {0.1,0.1} )
elements["pnt_85_2"] = default_1_position_tumb(_("Select Fuselage Tank"), devices.FUEL_SYSTEM, device_commands.Button_4, 85, 0.2, {0.2,0.2} )
elements["pnt_85_3"] = default_1_position_tumb(_("Select Right Main Tank"), devices.FUEL_SYSTEM, device_commands.Button_4, 85, 0.3, {0.3,0.3} )
elements["pnt_85_0"] = default_1_position_tumb(_("Select Left Combat Tank"), devices.FUEL_SYSTEM, device_commands.Button_4, 85, 0.4, {0.4,0.4} )
elements["CLK_VAR2_pnt_85"]	= multiposition_switch(_("Fuel Selector Valve"), devices.FUEL_SYSTEM, device_commands.Button_1, 85, 5, 0.1,true)

elements["pnt_86"] = default_animated_lever(_("Fuel Shut-Off Valve"),devices.FUEL_SYSTEM, device_commands.Button_2,86,3.5 )	
elements["pnt_86"].sound = {{SOUND_FUEL_SHUTOFF_ON},{SOUND_FUEL_SHUTOFF_OFF}}

elements["pnt_86_1"] = default_1_position_tumb(_("Fuel Shut-Off Valve On"),devices.FUEL_SYSTEM, device_commands.Button_5,86,1,{1,1} )
elements["pnt_86_0"] = default_1_position_tumb(_("Fuel Shut-Off Valve Off"),devices.FUEL_SYSTEM, device_commands.Button_5,86,0,{0,0} )
							
--AN/APS-13
elements["pnt_114"] = default_2_position_tumb(_("Tail Warning Radar Power"),devices.TAIL_WARNING_RADAR, device_commands.Button_1,114 )
elements["pnt_114_1"] = default_1_position_tumb(_("Tail Warning Radar Power On"),devices.TAIL_WARNING_RADAR, device_commands.Button_7,114,1,{1,1} )
elements["pnt_114_0"] = default_1_position_tumb(_("Tail Warning Radar Power Off"),devices.TAIL_WARNING_RADAR, device_commands.Button_7,114,0,{0,0} )
elements["pnt_115"]	= default_button2(_("Tail Warning Radar Test"),devices.TAIL_WARNING_RADAR,device_commands.Button_3,115)
elements["pnt_115"].sound = {{SOUND_TUMB_1_OFF, SOUND_TUMB_1}}
elements["pnt_115_1"] = default_button(_("Tail Warning Radar Test"),devices.TAIL_WARNING_RADAR,device_commands.Button_8,115)
elements["pnt_113"] = default_axis(_("Tail Warning Radar Light Control"),devices.TAIL_WARNING_RADAR, device_commands.Button_4, 113, 1.0, 0.1, false, false, nil, {0,-120})

-------------
elements["pnt_79"] = default_animated_lever(_("Hydraulic Release Knob"),devices.HYDRAULIC_SYSTEM, device_commands.Button_1,79,5.0)

elements["pnt_94"] = multiposition_switch_limited(_("Flaps Control Handle"),devices.CONTROL_SYSTEM, device_commands.Button_2, 94, 6, 0.2)
								
elements["pnt_150"] = default_2_position_tumb(_("Landing Gear Control Handle"),devices.CONTROL_SYSTEM, device_commands.Button_3,150 )
elements["pnt_151"] = default_2_position_tumb(_("Landing Gear Control Handle"),devices.CONTROL_SYSTEM, device_commands.Button_3,150 )

elements["pnt_84"] = default_button(_("Parking Brake Handle"),devices.CONTROL_SYSTEM, device_commands.Button_5,84, nil, nil, true)		
elements["pnt_84"].use_release_message = true

elements["pnt_81"]	= default_button(_("Safe Landing Gear Light Test"),devices.CONTROL_SYSTEM,device_commands.Button_18,81, nil, nil, true)
elements["pnt_83"]	= default_button(_("Unsafe Landing Gear Light Test"),devices.CONTROL_SYSTEM,device_commands.Button_7,83, nil, nil, true)

--Detrola receiver
elements["pnt_137"] = default_axis(_("Detrola Frequency Selector"),devices.DETROLA, device_commands.Button_4, 137, 0.0, 0.01, true, false, nil, {160,-45}, {20,-45} )
elements["pnt_138"] = default_axis(_("Detrola Volume"),devices.DETROLA, device_commands.Button_1, 138, 0.0, 0.3, true, false)

--canopy
elements["pnt_147"] = default_movable_axis(_("Canopy Hand Crank"),devices.CPT_MECH, device_commands.Button_2, 147, 0.4)
elements["pnt_147"].side = {}
elements["pnt_149"] = default_2_position_tumb(_("Canopy Emergency Release Handle"),devices.CPT_MECH, device_commands.Button_3,149 )
elements["pnt_147_1"] = default_axis(_("Canopy Hand Crank"),devices.CPT_MECH, device_commands.Button_8, 147, 0.0, -4.0, true, true, nil, {180,45}, {0,45})

--AN/ARA-8
elements["pnt_152"] = multiposition_switch_limited(_("Homing Adapter Mode Switch"),   devices.HOMING_ADAPTER, device_commands.Button_1, 152, 3, 0.1)
elements["pnt_153"] = default_2_position_tumb(     _("Homing Adapter CW/MCW Switch"), devices.HOMING_ADAPTER, device_commands.Button_4, 153)

--SCR-695
elements["pnt_140"] = default_2_position_tumb(_("IFF Power On/Off"),devices.IFF, device_commands.Button_1,140 )
elements["pnt_140_1"] = default_1_position_tumb(_("IFF Power On"), devices.IFF, device_commands.Button_14, 140, 1, {1,1} )
elements["pnt_140_0"] = default_1_position_tumb(_("IFF Power Off"), devices.IFF, device_commands.Button_14, 140, 0.0, {0.0,0.0} )

elements["pnt_143"] = default_2_position_tumb(_("IFF Distress Signal"),devices.IFF, device_commands.Button_5,143 )
elements["pnt_143_1"] = default_1_position_tumb(_("IFF Distress Signal On"), devices.IFF, device_commands.Button_15, 143, 1, {1,1} )
elements["pnt_143_0"] = default_1_position_tumb(_("IFF Distress Signal Off"), devices.IFF, device_commands.Button_15, 143, 0.0, {0.0,0.0} )

elements["pnt_142"]	= default_button_fix(_("IFF Detonator Circuit On/Off"),devices.IFF,device_commands.Button_4,142)
elements["pnt_145"]	= default_button(_("IFF Detonator Left"),devices.IFF,device_commands.Button_7,145, nil, nil, {0,0,0}, true)
elements["pnt_146"]	= default_button(_("IFF Detonator Right"),devices.IFF,device_commands.Button_8,146, nil, nil, {0,0,0}, true)

elements["pnt_141_-1"] = default_1_position_tumb(_("IFF TIME"), devices.IFF, device_commands.Button_17, 141, -1, {-1.0,-1.0} )
elements["pnt_141_0"] = default_1_position_tumb(_("IFF OFF"), devices.IFF, device_commands.Button_17, 141, 0, {0.0,0.0} )
elements["pnt_141_1"] = default_1_position_tumb(_("IFF ON"), devices.IFF, device_commands.Button_17, 141, 1, {1.0,1.0} )
elements["pnt_141"]	= default_3_position_tumb(_("IFF TIME/OFF/ON") ,devices.IFF,device_commands.Button_3,141,false,true )

elements["pnt_139_1"] = default_1_position_tumb(_("IFF CODE 1"), devices.IFF, device_commands.Button_16, 139, 0.0, {0.0,0.0} )
elements["pnt_139_2"] = default_1_position_tumb(_("IFF CODE 2"), devices.IFF, device_commands.Button_16, 139, 0.0, {0.1,0.1} )
elements["pnt_139_3"] = default_1_position_tumb(_("IFF CODE 3"), devices.IFF, device_commands.Button_16, 139, 0.0, {0.2,0.2} )
elements["pnt_139_4"] = default_1_position_tumb(_("IFF CODE 4"), devices.IFF, device_commands.Button_16, 139, 0.0, {0.3,0.3} )
elements["pnt_139_5"] = default_1_position_tumb(_("IFF CODE 5"), devices.IFF, device_commands.Button_16, 139, 0.0, {0.4,0.4} )
elements["pnt_139_6"] = default_1_position_tumb(_("IFF CODE 6"), devices.IFF, device_commands.Button_16, 139, 0.0, {0.5,0.5} )
elements["pnt_139"]	= multiposition_switch_limited(_("IFF Code Selector"), devices.IFF, device_commands.Button_2, 139, 6, 0.1)

--Trimmers
elements["pnt_91"] = default_axis_limited(_("Aileron Trim"),devices.CONTROL_SYSTEM, device_commands.Button_8, 91, 0.0, 0.1/5.0, false, true,{-1,1}, {135,-20}, {60,-20})
elements["pnt_91"].sound = {{SOUND_TRIM}}
elements["pnt_92"] = default_axis_limited(_("Elevator Trim"),devices.CONTROL_SYSTEM, device_commands.Button_9, 92, 0.0, 0.1/10.0, false, true,{-1,1}, {-135,-30})
elements["pnt_92"].sound = {{SOUND_TRIM}}
elements["pnt_93"] = default_axis_limited(_("Rudder Trim"),devices.CONTROL_SYSTEM, device_commands.Button_10, 93, 0.0, 0.1/5.0, false, true,{-1,1}, {135,-20}, {60,-20})
elements["pnt_93"].sound = {{SOUND_TRIM}}

elements["pnt_132"] = default_animated_lever(_("Left Payload Salvo"),devices.WEAPON_CONTROL, device_commands.Button_3,132,4.0)
elements["pnt_133"] = default_animated_lever(_("Right Payload Salvo"),devices.WEAPON_CONTROL, device_commands.Button_4,133,3.0)

elements["pnt_157"] = default_axis(_("Defroster"),devices.ENVIRONMENT_SYSTEM, device_commands.Button_1, 157, 0.0, 0.1, true, false, nil, {-120,-30}, {-80,-30} )
elements["pnt_158"] = default_movable_axis(_("Cold Air"),devices.ENVIRONMENT_SYSTEM, device_commands.Button_2, 158, 0.1)
elements["pnt_159"] = default_axis(_("Hot Air"),devices.ENVIRONMENT_SYSTEM, device_commands.Button_3, 159, 0.0, 0.1, true, false, nil, {-80,-30}, {-45,-30} )

elements["pnt_89"] = default_2_position_tumb(_("Landing Light On/Off"),devices.LIGHT_SYSTEM, device_commands.Button_3,89 )
elements["pnt_89_1"] = default_1_position_tumb(_("Landing Light On"),devices.LIGHT_SYSTEM, device_commands.Button_7,89,1,{1,1} )
elements["pnt_89_0"] = default_1_position_tumb(_("Landing Light Off"),devices.LIGHT_SYSTEM, device_commands.Button_7,89,0,{0,0} )

elements["pnt_168"] = default_cover(_("Coolant Control Cover"),devices.ENGINE_SYSTEM, device_commands.Button_3,168 )
elements["pnt_168"].sound = {{SOUND_COVER_CLOSE, SOUND_COVER_OPEN}}

elements["pnt_87"] = triple_switch(_("Coolant Control"),devices.ENGINE_SYSTEM, device_commands.Button_1,87)

elements["pnt_87_0"] = default_button(_("Close Coolant Control"),devices.ENGINE_SYSTEM, device_commands.Button_1,87,0.1,{0.0,0.1} )
elements["pnt_87_0"].sound = {{SOUND_TUMB_1}}
elements["pnt_87_1"] = default_1_position_tumb(_("Automatic Coolant Control"),devices.ENGINE_SYSTEM, device_commands.Button_1, 87, 0.2, {0.0,0.2} )
elements["pnt_87_2"] = default_button(_("Open Coolant Control"),devices.ENGINE_SYSTEM, device_commands.Button_1, 87, 0.3, {0.0,0.3} )

elements["pnt_169"] = default_cover(_("Oil Control Cover"),devices.ENGINE_SYSTEM, device_commands.Button_4,169 )
elements["pnt_169"].sound = {{SOUND_COVER_CLOSE, SOUND_COVER_OPEN}}

elements["pnt_88"] = triple_switch(_("Coolant Control"),devices.ENGINE_SYSTEM, device_commands.Button_2,88)

elements["pnt_88_0"] = default_button(_("Close Oil Control"),devices.ENGINE_SYSTEM, device_commands.Button_2, 88, 0.1, {0.0,0.1} )
elements["pnt_88_0"].sound = {{SOUND_TUMB_1}}
elements["pnt_88_1"] = default_1_position_tumb(_("Automatic Oil Control"),devices.ENGINE_SYSTEM, device_commands.Button_2, 88, 0.2, {0.0,0.2} )
elements["pnt_88_2"] = default_button(_("Open Oil Control"),devices.ENGINE_SYSTEM, device_commands.Button_2, 88, 0.3, {0.0,0.3} )

elements["pnt_134"] = default_movable_axis(_("Carburetor Cold Air Control"),devices.ENGINE_SYSTEM, device_commands.Button_7, 134, 0.1)
elements["pnt_135"] = default_movable_axis(_("Carburetor Warm Air Control"),devices.ENGINE_SYSTEM, device_commands.Button_27, 135, 0.1)

elements["pnt_47"]	= multiposition_switch(_("Mixture Control Select IDLE CUT OFF/RUN/EMERGENCY FULL RICH"), devices.ENGINE_SYSTEM, device_commands.Button_11, 47, 3, 0.1)
elements["pnt_47"].sound = {{SOUND_LEVER_UP, SOUND_LEVER_DOWN}}
elements["pnt_47_0"] = default_1_position_tumb(_("Mixture IDLE"), devices.ENGINE_SYSTEM, device_commands.Button_19, 47, 0.0, {0.0,0.0} )
elements["pnt_47_1"] = default_1_position_tumb(_("Mixture RUN"), devices.ENGINE_SYSTEM, device_commands.Button_19, 47, 0.0, {0.1,0.1} )
elements["pnt_47_2"] = default_1_position_tumb(_("Mixture EMERGENCY FULL RICH"), devices.ENGINE_SYSTEM, device_commands.Button_19, 47, 0.0, {0.2,0.2} )

elements["pnt_43"] 			  = default_movable_axis(_("Throttle"),devices.ENGINE_SYSTEM, device_commands.Button_21, 43, 0.1)
if VR_device ~= nil and VR_device.pnt_43 ~= nil then
	elements["pnt_43"].VR_capture = VR_device.pnt_43
else
	elements["pnt_43"].VR_capture = {}
end
elements["pnt_43"].side = {}

elements["pnt_46"] = default_movable_axis(_("Propeller RPM"),devices.ENGINE_SYSTEM, device_commands.Button_22, 46, 0.1)

elements["pnt_173"] =  {	
				class 		= {class_type.BTN,class_type.BTN},
				hint  		= _("Surface Control Lock Plunger. Left Button - Lock Stick in the Forward Position', Right Button - Lock Stick in the Neutral Position"),
				device 		= devices.CONTROL_SYSTEM,
				action 		= {device_commands.Button_15,device_commands.Button_16},
				stop_action = {device_commands.Button_15,device_commands.Button_16},
				arg 	  	= {173,173},
				arg_value 	= {-1.0,1.0}, 
				arg_lim   	= {{0,1},{0,1}},
				updatable 	= true, 
				use_OBB 	= true,
				sound       = {{},{}},
				use_release_message = {true,true},
				side		= {{BOX_SIDE_Z_top},{BOX_SIDE_Z_bottom}},
			}

elements["pnt_48"] = default_axis(_("Lock Throttle"),devices.ENGINE_SYSTEM, device_commands.Button_12,48, 0.0, 0.2, true, false)
elements["pnt_49"] = default_axis(_("Lock Propeller & Mixture"),devices.ENGINE_SYSTEM, device_commands.Button_14,49, 0.0, 0.2, true, false)
	
elements["pnt_176"] = default_button(_("G-meter reset"),devices.ACCELEROMETER, device_commands.Button_1, 176, 0.6, {0.0,0.6}, true)
	
elements["pnt_183"] = {class  		= {class_type.TUMB,class_type.TUMB},
					   hint  		= _("Mirror"), 
					   device 		= 0,
					   action		= {device_commands.Button_1, device_commands.Button_1},
					   arg	  		= {183, 183},
					   arg_value 	= {1, -1},
					   arg_lim   	= {{0,1},{0,1}},
					   updatable  	= true, 
					   cycle	  	= true,
					   side			= {{BOX_SIDE_Z_bottom},{BOX_SIDE_Z_top}},
					  }

					   ------------------------------------------------------------------					 
for i,o in pairs(elements) do
	if  o.class[1] == class_type.TUMB or 
	   (o.class[2]  and o.class[2] == class_type.TUMB) or
	   (o.class[3]  and o.class[3] == class_type.TUMB)  then
	   o.updatable = true
	   o.use_OBB   = true
	end
end


