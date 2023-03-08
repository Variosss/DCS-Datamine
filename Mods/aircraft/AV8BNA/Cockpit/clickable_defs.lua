cursor_mode =
{
    CUMODE_CLICKABLE = 0,
    CUMODE_CLICKABLE_AND_CAMERA  = 1,
    CUMODE_CAMERA = 2,
};

clickable_mode_initial_status  = cursor_mode.CUMODE_CLICKABLE
use_pointer_name			   = true
anim_speed_default = 10.0

function default_button(hint_,device_,command_,arg_,arg_val_,arg_lim_)

	local   arg_val_ = arg_val_ or 1
	local   arg_lim_ = arg_lim_ or {0,1}

	return  {
				class 				= {class_type.BTN},
				hint  				= hint_,
				device 				= device_,
				action 				= {command_},
				stop_action 		= {command_},
				arg 				= {arg_},
				arg_value			= {arg_val_},
				arg_lim 			= {arg_lim_},
				use_release_message = {true}
			}
end

function default_1_position_tumb(hint_, device_, command_, arg_, arg_val_, arg_lim_)
	local   arg_val_ = arg_val_ or 1
	local   arg_lim_ = arg_lim_ or {0,1}
	return  {
				class 		= {class_type.TUMB},
				hint  		= hint_,
				device 		= device_,
				action 		= {command_},
				arg 	  	= {arg_},
				arg_value 	= {arg_val_},
				arg_lim   	= {arg_lim_},
				updatable 	= true,
				use_OBB 	= true
			}
end

function default_1_position_tumb_animated(hint_, device_, command_, arg_, arg_val_, arg_lim_)
 element = default_1_position_tumb(hint_, device_, command_, arg_, arg_val_, arg_lim_)
 element.animated = {true}
 element.animation_speed = {anim_speed_default}
 return element
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
				use_OBB 	= true
			}
end

function default_2_position_tumb_animated(hint_, device_, command_, arg_, animation_speed_)
 element = default_2_position_tumb(hint_, device_, command_, arg_)
 
 local animation_ = animation_speed_ or anim_speed_default
 
 element.animated = {true}
 element.animation_speed = {animation_}
 return element
end

function default_3_position_tumb(hint_,device_,command_,arg_,cycled_,inversed_)
	local cycled = true

	local val =  1
	if inversed_ then
	      val = -1
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
				arg_value 	= {val,-val},
				arg_lim   	= {{-1,1},{-1,1}},
				updatable 	= true,
				use_OBB 	= true,
				cycle       = cycled
			}
end

function default_3_position_tumb_animated(hint_,device_,command_,arg_,cycled_,inversed_,animation_speed_)
    local element = default_3_position_tumb(hint_,device_,command_,arg_,cycled_,inversed_)
	local animation_speed_  = animation_speed_ or anim_speed_default
	element.animated		= {true,true}
	element.animation_speed	= {animation_speed_,animation_speed_}
	return element
end

function springloaded_3_pos_tumb(hint_, device_, command1_, command2_, arg_, val1_, val2_, val3_)
    local val1 = val1_ or 0.0
    local val2 = val2_ or 0.5
    local val3 = val3_ or 1.0
    return  {   
                class       = {class_type.BTN,class_type.BTN},
                hint        = hint_,
                device      = device_,
                action      = {command1_,command2_},
                stop_action = {command1_,command2_},
                arg         = {arg_,arg_},
                arg_value   = {val1,val3}, 
                arg_lim     = {{val1,val3},{val1,val2}},
                updatable   = true, 
                use_OBB     = true,
                use_release_message = {true,true},
            }
end

function springloaded_3_pos_tumb_inverted(hint_, device_, command1_, command2_, arg_, val1_, val2_, val3_)
    local val1 = val1_ or 0.0
    local val2 = val2_ or 0.5
    local val3 = val3_ or 1.0
    return  {   
                class       = {class_type.BTN,class_type.BTN},
                hint        = hint_,
                device      = device_,
                action      = {command1_,command2_},
                stop_action = {command1_,command2_},
                arg         = {arg_,arg_},
                arg_value   = {val3,val1}, 
                arg_lim     = {{val1,val3},{val1,val2}},
                updatable   = true, 
                use_OBB     = true,
                use_release_message = {true,true},
            }
end

function default_axis(hint_,device_,command_,arg_, default_, gain_,updatable_,relative_)

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
				cycle       = false,
			}
end

function default_axis_cycle(hint_,device_,command_, arg_, default_, gain_, updatable_, relative_)

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
				cycle     	= true,
			}
end

function default_movable_axis(hint_,device_,command_,arg_, default_, gain_,updatable_,relative_)

	local default = default_ or 1
	local gain = gain_ or 0.1
	local updatable = updatable_ or false
	local relative  = relative_ or false

	return  {
				class 		= {class_type.MOVABLE_LEV},
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

function default_axis_limited(hint_,device_,command_,arg_,default_,gain_,updatable_,relative_,arg_lim_)
	local	default = default_ or 0
	local	updatable = updatable_ or false
	local	relative  = relative_ or false
	local	cycled_ = false
	local	arg_lim = arg_lim_ or {0,1}

	local	element = default_axis(hint_,device_,command_,arg_,default,gain_,updatable,relative)
	element.arg_lim   	= {arg_lim}
	element.use_OBB 	= false
	return element
end



function default_axis_limited_cycle(hint_,device_,command_,arg_, default_, gain_, updatable_, relative_, arg_lim_)

	local relative = false
	local default = default_ or 0
	local updatable = updatable_ or false
	if relative_ ~= nil then
		relative = relative_
	end

	local gain = gain_ or 0.1
	return  {
				class 		= {class_type.LEV},
				hint  		= hint_,
				device 		= device_,
				action 		= {command_},
				arg 	  	= {arg_},
				arg_value 	= {default},
				arg_lim   	= {arg_lim_},
				updatable 	= updatable,
				use_OBB 	= false,
				gain		= {gain},
				relative    = {relative},
                cycle       = true,
			}
end

function multiposition_switch(hint_,device_,command_,arg_,count_,delta_,inversed_, min_)
    local min_   = min_ or 0
	local delta_ = delta_ or 0.5

	local inversed = 1
	if	inversed_ then
		inversed = -1
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
				use_OBB 	= true
			}
end

function multiposition_switch_limited(hint_,device_,command_,arg_,count_,delta_,inversed_,min_)
    local min_   = min_ or 0
	local delta_ = delta_ or 0.5

	local inversed = 1
	if	inversed_ then
		inversed = -1
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
			}
end

function multiposition_switch_limited_animated(hint_,device_,command_,arg_,count_,delta_,inversed_,min_,animation_speed_)
    local element = multiposition_switch_limited(hint_,device_,command_,arg_,count_,delta_,inversed_,min_)
	local animation_speed_  = animation_speed_ or anim_speed_default
	element.animated		= {true,true}
	element.animation_speed	= {animation_speed_/count_,animation_speed_/count_}
	return element
end

function default_button_axis(hint_, device_,command_1, command_2, arg_1, arg_2, limit_1, limit_2)
	local limit_1_   = limit_1 or 1.0
	local limit_2_   = limit_2 or 1.0
return {
			class		=	{class_type.BTN, class_type.LEV},
			hint		=	hint_,
			device		=	device_,
			action		=	{command_1, command_2},
			stop_action =   {command_1, 0},
			arg			=	{arg_1, arg_2},
			arg_value	= 	{1, 0.5},
			arg_lim		= 	{{0, limit_1_}, {0,limit_2_}},
			animated        = {false,true},
			animation_speed = {0, 0.4},
			gain = {0, 0.1},
			relative	= 	{false, false},
			updatable 	= 	true,
			use_OBB 	= 	true,
			use_release_message = {true, false}
	}
end

function default_animated_lever(hint_, device_, command_, arg_, animation_speed_,arg_lim_)
local arg_lim__ = arg_lim_ or {0.0,1.0}
return  {
	class  = {class_type.TUMB, class_type.TUMB},
	hint   	= hint_,
	device 	= device_,
	action 	= {command_, command_},
	arg 		= {arg_, arg_},
	arg_value 	= {1, 0},
	arg_lim 	= {arg_lim__, arg_lim__},
	updatable  = true,
	gain 		= {0.1, 0.1},
	animated 	= {true, true},
	animation_speed = {animation_speed_, 0},
	cycle = true
}
end

function default_multiposition_animated_lever(hint_,device_,command_,arg_,count_,delta_,inversed_,min_,animation_speed_)
    local min_   = min_ or 0
	local delta_ = delta_ or 0.5

	local inversed = 1
	if	inversed_ then
		inversed = -1
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
				gain 		= {0.1, 0.1},
				animated 	= {true, true},
				animation_speed = {animation_speed_, 0},
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
				use_release_message = {true,false}
			}
end

function default_tumb_button(hint_, device_, command1_, command2_, arg_)
	return  {
				class 		= {class_type.TUMB, class_type.BTN},
				hint  		= hint_,
				device 		= device_,
				action 		= {command1_,command2_},
				stop_action = {0, command2_},
				arg 	  	= {arg_,arg_},
				arg_value 	= {-1, 1},
				arg_lim   	= {{-1,0},{0,1}},
				updatable 	= true,
				use_OBB 	= true,
				use_release_message = {false,true}
			}
end

function default_tumb_button_inv(hint_, device_, command1_, command2_, arg_)
	return  {
				class 		= {class_type.BTN, class_type.TUMB},
				hint  		= hint_,
				device 		= device_,
				action 		= {command1_,command2_},
				stop_action = {command1_, 0},
				arg 	  	= {arg_,arg_},
				arg_value 	= {-1, 1},
				arg_lim   	= {{-1,0},{0,1}},
				updatable 	= true,
				use_OBB 	= true,
				use_release_message = {true, false}
			}
end

function default_button_lever(hint_, device_, command1_, command2_, arg1_, arg2_, gain_)
-- This functions allows a knob to rotate and to be pressed
	local delta_gain = gain_ or 0.1
	
	return {
		class				= {class_type.BTN, class_type.LEV}, 
		hint				= hint_, 
		device				= device_, 
		action				= {command1_, command2_}, 
		stop_action			= {command1_, command2_}, 
		is_repeatable		= {}, 
		arg					= {arg1_, arg2_}, 
		arg_value			= {1.0, 0.0}, 
		arg_lim				= {{0.0, 1.0}, {-1.0, 1.0}}, 
		relative			= {false, false},
		gain				= {1.0, delta_gain}, 
		use_release_message	= {true, false}, 
		use_OBB				= true,
		animated			= {false, false},
		animation_speed		= {anim_speed_default,0},
		cycle				= false,
	}
end

function default_tumb_lever(hint_, device_, command1_, command2_, arg1_, arg2_, gain_)
	local delta_gain = gain_ or 0.1
	
	return {
		class				= {class_type.TUMB, class_type.LEV}, 
		hint				= hint_, 
		device				= device_, 
		action				= {command1_, command2_}, 
		is_repeatable		= {}, 
		arg					= {arg1_, arg2_}, 
		arg_value			= {1, 0.0}, 
		arg_lim				= {{0, 1}, {-1.0, 1.0}}, 
		updatable 			= {true, false},
		relative			= {false, false},
		gain				= {1, delta_gain}, 
		use_release_message	= {false, false}, 
		use_OBB				= true,
		animated			= {false, false},
		animation_speed		= {anim_speed_default,0},
		cycle				= false,
	}
end

function default_button_lever_cycled(hint_, device_, command1_, command2_, arg1_, arg2_, gain_)
-- This functions allows a knob to rotate (cycled) and to be pressed
	local delta_gain = gain_ or 0.1
	
	return {
		class				= {class_type.BTN, class_type.LEV}, 
		hint				= hint_, 
		device				= device_, 
		action				= {command1_, command2_}, 
		stop_action			= {command1_, command2_}, 
		is_repeatable		= {}, 
		arg					= {arg1_, arg2_}, 
		arg_value			= {1.0, 0.0}, 
		arg_lim				= {{0.0, 1.0}, {0.0, 1.0}}, 
		relative			= {false, true},
		gain				= {1.0, delta_gain}, 
		use_release_message	= {true, false}, 
		use_OBB				= true,
		animated			= {false, false},
		animation_speed		= {anim_speed_default,0},
		cycle				= {false, true}
	}
end

function FCS_Tumb(hint_, device_, command1_, command2_, arg_)
	return  {
				class 		= {class_type.TUMB,class_type.TUMB},
				hint  		= hint_,
				device 		= device_,
				action 		= {command1_,command2_},
				arg 	  	= {arg_, arg_},
				arg_value 	= {-0.5,0.5},
				arg_lim   	= {{0,1},{0,1}},
				cycle = false
			}
end

function default_basic_Lever(hint_, device_, command1_, arg_)
	return	{
				class 		= {class_type.LEV,class_type.LEV},
				hint  		= hint_,
				device 		= device_,
				action 		= {command1_ ,	command1_},
				arg 		= {arg_,arg_},
				arg_value	= {0.05},
				arg_lim 	= {{0.0, 1.0}}
			}
end

function default_2_way_spring_switch(hint_, device_, command1_, arg_, inversed_)

	local inversed = 1
	if	inversed_ then
		inversed = -1
	end

	return	{
				class		= {class_type.BTN, class_type.BTN},
				hint  		= hint_,
				device 		= device_,
				action 		= {command1_,command1_},
				stop_action = {command1_,command1_},
				arg 		= {arg_, arg_},
				arg_value	= {1.0*inversed, -1.0*inversed},
				arg_lim 	= {{0.0, 1.0}, {-1.0, 0.0}},
				use_release_message = {true}
			}
end

function default_2_way_spring_switch_animated(hint_, device_, command1_, arg_, inversed_,animation_speed_)
    local element = default_2_way_spring_switch(hint_, device_, command1_, arg_, inversed_)
	local animation_speed_  = animation_speed_ or anim_speed_default
	element.animated		= {true,true}
	element.animation_speed	= {animation_speed_,animation_speed_}
	return element
end

function default_multiposition_knob(hint_,device_,command_,arg_,count_,delta_,inversed_,min_)
    local min_   = min_ or 0
	local delta_ = delta_ or 0.5

	local inversed = 1
	if	inversed_ then
		inversed = -1
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
				cycle     	= true,
			}
end

function intercom_rotate_tumb(hint_, device_,command_1, command_2, arg_1, arg_2)
return {
			class		=	{class_type.TUMB, class_type.TUMB, class_type.LEV},
			hint		=	hint_,
			device		=	device_,
			action		=	{command_1, command_1, command_2},
			arg			=	{arg_1, arg_1, arg_2},
			arg_value	= 	{1, -1, 1},
			arg_lim		= 	{{0, 1}, {0, 1}, {0,1}},
			--animated        = {false,false,false},
			--animation_speed = {0, 0, 0.5},
			relative	= 	{false, false, false},
			updatable 	= 	false, 
			use_OBB 	= 	false,
			gain 		=   {1.0, 1.0, 0.1},
			cycle 		=   false,
	}
end

function multiposition_switch_spring(hint_, device_, command_1, command_2, arg_, inversed_, min_)
    local min_   = min_ or 0
	local inversed = 1
	
	if	inversed_ then
		inversed = -1
	end
	
	return {
			class		= {class_type.TUMB,class_type.BTN},
			hint  		= hint_,
			device 		= device_,
			action		= {command_1 ,command_2},
			arg			= {arg_, arg_},
			stop_action	= {0, command_2},
			arg_value	= {0,1},
			arg_lim		= {{0.0, 0.5},{0.5, 1.0}},
			use_release_message = {false,true},
	}
end

function default_animated_lever(hint_, device_, command_, arg_, animation_speed_,arg_lim_)
local arg_lim__ = arg_lim_ or {0.0,1.0}
return  {
	class  = {class_type.TUMB, class_type.TUMB},
	hint   	= hint_,
	device 	= device_,
	action 	= {command_, command_},
	arg 		= {arg_, arg_},
	arg_value 	= {1, 0},
	arg_lim 	= {arg_lim__, arg_lim__},
	updatable  = true,
	gain 		= {0.1, 0.1},
	animated 	= {true, true},
	animation_speed = {animation_speed_, 0},
	cycle = true
}
end

-- New buttons
local function button_prototype(hint_,device_,command_,arg_)
	return  {
				class				= {class_type.BTN},
				hint				= hint_,
				device				= device_,
				action				= {command_},
				stop_action 		= {command_},
				arg					= {arg_},
				arg_value			= {1},
				arg_lim 			= {{0,1}},
				use_release_message	= {true},
				sound				= {{SOUND_SW5_ON, SOUND_SW5_OFF}}
			}
end


function AMPCD_switch_positive(hint_,device_,command_,arg_)
	return button_prototype(hint_, device_, command_, arg_)
end

function AMPCD_switch_negative(hint_,device_,command_,arg_)
	local button = button_prototype(hint_, device_, command_, arg_)
	button.arg_value	= {-1}
	button.arg_lim 		= {{-1, 0}}
	return button
end

function LDG_Gear_Control_Handle(hint_,device_,command_,arg_,command2_,arg2_,animation_speed_)
	local	animation_speed_ = animation_speed_ or anim_speed_default
	return  {
				class 			= {class_type.TUMB,class_type.TUMB,class_type.LEV},
				hint  			= hint_,
				device 			= device_,
				action 			= {command_,command_, command2_},
				arg 	  		= {arg_,arg_,arg2_},
				arg_value 		= {-1.0, 1.0, 1.0},
				arg_lim   		= {{0, 1.0},
								   {0, 1.0},
								   {0, 1.0}},
				gain			= {1,1,-1},
				relative		= {false,false,true},
				updatable 		= true,
				use_OBB 		= true,
				cycle			= true,
				animated		= {true,true,false},
			    animation_speed	= {animation_speed_,animation_speed_,0},
				class_vr 		= {nil,nil,class_type.BTN_FIX},
				side			= {{BOX_SIDE_Z_top, BOX_SIDE_X_bottom},{BOX_SIDE_Z_bottom,BOX_SIDE_X_top},{BOX_SIDE_Y_bottom}}
			}
end

