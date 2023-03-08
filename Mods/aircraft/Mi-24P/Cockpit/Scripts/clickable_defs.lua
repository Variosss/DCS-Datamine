cursor_mode = 
{ 
    CUMODE_CLICKABLE = 0,
    CUMODE_CLICKABLE_AND_CAMERA  = 1,
    CUMODE_CAMERA = 2,
};

clickable_mode_initial_status  = cursor_mode.CUMODE_CLICKABLE

direction						= 1
cyclic_by_default				= true -- to cycle two-way thumblers or not by default
anim_speed_default				= 16

function default_button(hint_,device_,command_,arg_,animation_speed_, crew)
	local	animation_speed_ = animation_speed_ or anim_speed_default
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
				animated			= {true},
			    animation_speed		= {animation_speed_},
				sound				= {{SOUND_SW5_ON, SOUND_SW5_OFF}},
				side				= {{BOX_SIDE_Y_bottom}},
				crew_member_access  = {crew or 0}
			}
end

function default_spring_button(hint_,device_,command_,arg_,arg_val_,arg_lim_, turn_box_, crew)

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
				use_release_message = {true},
				sound 				= {{SOUND_BTN_OFF,SOUND_BTN_ON}},
				side				= {{BOX_SIDE_Y_bottom}},
				turn_box			= turn_box_ or nil,
				crew_member_access  = {crew or 0}
			}
end

function default_square_button(hint_,device_,command_,arg_,turn_box_)
	local	element	= default_button(hint_,device_,command_,arg_,animation_speed_)
	element.sound	= {{SOUND_SW4_ON, SOUND_SW4_OFF}}
	return element
end


function default_tumb_button(hint_,device_,command_,arg_,animation_speed_, crew_)
	local	element	= default_button(hint_,device_,command_,arg_,animation_speed_,crew_)
	element.side	= {{BOX_SIDE_Z_bottom}}
	return element
end

function default_position_tumb(hint_, device_, command_, arg_, arg_val_, arg_lim_, turn_box_, crew)
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
				use_OBB 	= true,
				sound 		= {{SOUND_SW21}},
				class_vr 	= {class_type.BTN_FIX},
				side		= {{BOX_SIDE_Y_bottom}},
				turn_box	= turn_box_ or nil,
				crew_member_access  = {crew or 0}
			}
end

function default_1_position_tumb(hint_, device_, command_, arg_, animation_speed_, arg_val_, arg_lim_, crew)
	local	animation_speed_ = animation_speed_ or anim_speed_default
	local   arg_val_ = arg_val_ or 1
	local   arg_lim_ = arg_lim_ or {0, arg_val_}
	return  {	
				class 			= {class_type.TUMB},
				hint  			= hint_,
				device 			= device_,
				action 			= {command_},
				arg 	  		= {arg_},
				arg_value 		= {arg_val_}, 
				arg_lim   		= {arg_lim_},
				updatable 		= true, 
				use_OBB 		= true,
				animated		= {true},
			    animation_speed	= {animation_speed_},
				sound			= {{SOUND_SW1}},
				class_vr 		= {class_type.BTN_FIX},
				side			= {{BOX_SIDE_Y_bottom}},
				crew_member_access  = {crew or 0}
			}
end

function default_2_position_tumb(hint_,device_,command_,arg_,animation_speed_, crew)
	local	animation_speed_ = animation_speed_ or anim_speed_default
	return  {
				class			= {class_type.TUMB,class_type.TUMB},
				hint			= hint_,
				device			= device_,
				action			= {command_,command_},
				arg				= {arg_,arg_},
				arg_value		= {1,-1},
				arg_lim			= {{0,1},{0,1}},
				updatable		= true,
				use_OBB			= true,
				animated		= {true,true},
			    animation_speed	= {animation_speed_,animation_speed_},
				sound			= {{SOUND_SW1}},
				cycle			= true,
				side			= {{BOX_SIDE_Z_bottom},{BOX_SIDE_Z_top}},
				crew_member_access  = {crew or 0}
			}
end

function default_2_position_small_tumb(hint_,device_,command_,arg_,animation_speed_, crew)
    local	element = default_2_position_tumb(hint_,device_,command_,arg_,animation_speed_, crew)
	element.sound	= {{SOUND_SW21}}
	return  element
end

function default_2_position_flares_tumb(hint_,device_,command_,arg_,animation_speed_, crew)
    local	element = default_2_position_tumb(hint_,device_,command_,arg_,animation_speed_, crew)
	element.sound	= {{SOUND_SW19_PULL, SOUND_SW19_PUSH}}
	element.class_vr 	= {class_type.BTN_FIX}
	element.side		= {{BOX_SIDE_Y_bottom}}
	return  element
end


function default_3_position_tumb(hint_,device_,command_,arg_,cycled_,animation_speed_,inversed_,arg_value_,arg_limit_, crew)
	local	animation_speed_ = animation_speed_ or anim_speed_default
	local	arg_value 		 = arg_value_ or 1
	local   side			 = {{BOX_SIDE_Z_top},{BOX_SIDE_Z_bottom}}
	if inversed_ then
		arg_value = -arg_value
		side			 = {{BOX_SIDE_Z_bottom},{BOX_SIDE_Z_top}}
	end
	local	arg_limit = arg_limit_ or {-1,1}
	return  {
				class 			= {class_type.TUMB,class_type.TUMB},
				hint  			= hint_,
				device 			= device_,
				action 			= {command_,command_},
				arg 	  		= {arg_,arg_},
				arg_value 		= {-arg_value, arg_value},
				arg_lim   		= {arg_limit,arg_limit},
				updatable 		= true,
				use_OBB 		= true,
				cycle       	= cycled_ or false,
				animated		= {true,true},
			    animation_speed	= {animation_speed_,animation_speed_},
				sound			= {{SOUND_SW1}},
				side			= side,
				crew_member_access  = {crew or 0}
			}
end

function triple_switch(hint_,device_,command_,arg_, crew)
	
	return  {	
				class 		= {class_type.TUMB,class_type.TUMB},
				hint  		= hint_,
				device 		= device_,
				action 		= {command_,command_,command_,command_},
				arg 	  	= {arg_,arg_,arg_,arg_},
				arg_value 	= {-0.1,0.1, 0.2, 0.3}, 
				arg_lim   	= {{0, 0.3},  {0, 0.3},  {0, 0.2},  {0, 0.3}},
				updatable 	= true, 
				use_OBB 	= true,
				sound 		= {{SOUND_SW2},{SOUND_SW2},{SOUND_SW2},{SOUND_SW2}},
				class_vr 	= {class_type.TUMB_4SIDE,class_type.TUMB_4SIDE,class_type.TUMB_4SIDE,class_type.TUMB_4SIDE},
				side		= {{BOX_SIDE_Z_top},{BOX_SIDE_Z_bottom},{BOX_SIDE_X_top},{BOX_SIDE_X_bottom}},
				crew_member_access  = {crew or 0}
			}
end

function multiposition_switch(hint_,device_,command_,arg_,count_,delta_,inversed_,min_,animation_speed_,cycled_, crew)
    local	min_   = min_ or 0
	local	delta_ = delta_ or 0.5
	
	local	inversed = 1
	local   side	 = {{BOX_SIDE_Z_top},{BOX_SIDE_Z_bottom}}
	if	inversed_ then
		inversed = -1
		side	 = {{BOX_SIDE_Z_bottom},{BOX_SIDE_Z_top}}
	end
	local	animation_speed_ = animation_speed_ or anim_speed_default
	return  {	
				class 			= {class_type.TUMB,class_type.TUMB},
				hint  			= hint_,
				device 			= device_,
				action 			= {command_,command_},
				arg 	  		= {arg_,arg_},
				arg_value 		= {-delta_ * inversed,delta_ * inversed}, 
				arg_lim   		= {{min_, min_ + delta_ * (count_ -1)},
								   {min_, min_ + delta_ * (count_ -1)}},
				updatable 		= true, 
				use_OBB 		= true,
				cycle       	= cycled_ or false,
				animated		= {true,true},
			    animation_speed	= {animation_speed_,animation_speed_},
				sound			= {{SOUND_SW2}},
				side			= side,
				crew_member_access  = {crew or 0}
			}
end

function default_button_tumb(hint_,device_,command1_,command2_,arg_,animation_speed_, crew)
	local	animation_speed_ = animation_speed_ or anim_speed_default
	return  {
				class			= {class_type.BTN,class_type.TUMB},
				hint			= hint_,
				device			= device_,
				action			= {command1_,command2_},
				stop_action		= {command1_,0},
				arg				= {arg_,arg_},
				arg_value		= {-1,1},
				arg_lim			= {{-1,0},{0,1}},
				updatable		= true,
				use_OBB			= true,
				use_release_message = {true,false},
				animated		= {true,true},
			    animation_speed	= {animation_speed_,animation_speed_},
				sound			= {{SOUND_SW1},{SOUND_SW1}},
				side			= {{BOX_SIDE_Z_top},{BOX_SIDE_Z_bottom}},
				crew_member_access  = {crew or 0}
			}
end

function springloaded_2_pos_tumb(hint_,device_,command_,arg_,animation_speed_, crew)
    local	element = default_2_position_tumb(hint_,device_,command_,arg_,animation_speed_, crew)
	element.class		= {class_type.BTN,class_type.BTN}
	element.stop_action = {command_, command_}
	element.arg_value	= {1,1}
--	element.sound		= {{SOUND_SW12_ON,SOUND_SW12_OFF},{SOUND_SW12_ON,SOUND_SW12_OFF}}
	return  element
end

function springloaded_3_pos_tumb(hint_,device_,command1_,command2_,arg_,animation_speed_,val1_,val2_,val3_, crew)
	local	animation_speed_ = animation_speed_ or anim_speed_default
	local	val1 = val1_ or -1.0
	local	val2 = val2_ or 0.0
	local	val3 = val3_ or 1.0
	return  {
				class			= {class_type.BTN,class_type.BTN},
				hint			= hint_,
				device			= device_,
				action			= {command1_,command2_},
				stop_action		= {command1_,command2_},
				arg				= {arg_,arg_},
				arg_value		= {val1,val3},
				arg_lim			= {{val1,val2},{val2,val3}},
				updatable		= true,
				use_OBB			= true,
				use_release_message = {true,true},
				animated		= {true,true},
			    animation_speed	= {animation_speed_,animation_speed_},
				sound			= {{SOUND_SW1}, {SOUND_SW1}},
				side			= {{BOX_SIDE_Z_top},{BOX_SIDE_Z_bottom}},
				crew_member_access  = {crew or 0}
			}
end

function default_animated_lever(hint_,device_,command_,arg_,animation_speed_,arg_lim_, crew)
	local	animation_speed_ = animation_speed_ or 3
	local	arg_lim__ = arg_lim_ or {0.0,1.0}
	
    local	element = default_2_position_tumb(hint_,device_,command_,arg_,animation_speed_, crew)
	element.arg_value		= {1, 0}
	element.animation_speed	= {animation_speed_, 0}
	element.sound			= {{SOUND_SW8_UP, SOUND_SW8_DOWN}}
	--element.class_vr		= {class_type.MOVABLE_LEV,class_type.MOVABLE_LEV}
	element.side			= {{BOX_SIDE_Z_bottom},{BOX_SIDE_Z_top}}
	return	element
end

function default_axis(hint_,device_,command_,arg_, default_, gain_,updatable_,relative_,cycled_, attach_left_, attach_right_, crew)
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
				cycle 		= cycled_ or false,
				sound		= {{SOUND_SW6}},
				side		= {{BOX_SIDE_X_top, BOX_SIDE_X_bottom, BOX_SIDE_Z_top, BOX_SIDE_Z_bottom}},
				attach_left	= attach_left_ or nil,
				attach_right= attach_right_ or nil,
				crew_member_access  = {crew or 0}
			}
end

function default_axis_limited(hint_,device_,command_,arg_,default_,gain_,updatable_,relative_,arg_lim_, attach_left_, attach_right_, crew)
	local	default = default_ or 0
	local	updatable = updatable_ or false
	local	relative  = relative_ or false
	local	cycled_ = false
	local	arg_lim = arg_lim_ or {0,1}

	local	element = default_axis(hint_,device_,command_,arg_,default,gain_,updatable,relative,cycled_, attach_left_, attach_right_, crew)
	element.arg_lim   	= {arg_lim}
	element.use_OBB 	= false
	return element
end

--CB
function default_CB_button(hint_,device_,command_,arg_, crew)
	local	animation_speed_ = 10
    local	element = default_2_position_tumb(hint_,device_,command_,arg_,animation_speed_, crew)
	element.arg_value		= {1, 0}
	element.animation_speed	= {10, 0}
--	element.sound	= {{SOUND_SW8_ON,SOUND_SW8_OFF}}
	return	element
end

function default_blue_cover(hint_,device_,command_,arg_,animation_speed_, crew)
	local	animation_speed_ = animation_speed_ or anim_speed_default
	local 	new_element = default_2_position_tumb(hint_,device_,command_,arg_,animation_speed_, crew)
	new_element.sound = {{SOUND_SW3_OPEN, SOUND_SW3_CLOSE}}
	new_element.side  = {{BOX_SIDE_Z_top},{BOX_SIDE_Y_bottom}}
	return  new_element
end

function radio_wheel_1(hint_,device_,command1_,arg_, arg_value_, arg_lim_, slave_, crew)

	arg_value_ = arg_value_ or {-0.1, 0.1}
	slave_ = slave_ or {}
	arg_lim_ = arg_lim_ or {0,1}
	side 	= {{BOX_SIDE_Z_top},{BOX_SIDE_Z_bottom}}
	if arg_value_[1] > 0 then
		side 	= {{BOX_SIDE_Z_bottom},{BOX_SIDE_Z_top}}	
	end
	
	return  {
			 class  		 = {class_type.TUMB,class_type.TUMB}, 
			 hint   		 = hint_,
			 device 		 = device_,
			 action 		 = {command1_ ,command1_}, 
			 arg 			 = {arg_,arg_},
			 arg_value 		 = arg_value_,
			 arg_lim   		 = {arg_lim_,arg_lim_},
			 relative		 = {true,true},
			 animated        = {true,true},
			 animation_speed = {0.7, 0.7},
			 slave_animation = {{slave = slave_},{slave = slave_}},
			 side			 = side,
			 sound			 = {{SOUND_SW2}},
			 crew_member_access  = {crew or 0}
			}
end

function stick_button(hint_,device_,command_,arg_)

	return  {	
				class 				= {class_type.BTN},
				hint  				= hint_,
				device 				= device_,
				action 				= {command_},
				stop_action 		= {command_},
				arg 				= {arg_},
				arg_value			= {1}, 
				arg_lim 			= {{0,1}},
				use_release_message = {true},
				sound 				= {{SOUND_BTN_OFF,SOUND_BTN_ON}},
			}
end