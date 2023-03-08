cursor_mode =
{ 
	CUMODE_CLICKABLE			= 0,
	CUMODE_CLICKABLE_AND_CAMERA	= 1,
	CUMODE_CAMERA				= 2,
};

clickable_mode_initial_status	= cursor_mode.CUMODE_CLICKABLE

direction						= 1
cyclic_by_default				= true -- to cycle two-way thumblers or not by default
anim_speed_default				= 16

IS_CYCLED		= true
NOT_CYCLED		= false

IS_INVERSED		= true
NOT_INVERSED	= false

IS_UPDATABLE	= true
NOT_UPDATABLE	= false

IS_RELATIVE		= true
NOT_RELATIVE	= false


local function button_prototype(hint_,device_,command_,arg_)
	return	{
				class				= {class_type.BTN},
				hint				= hint_,
				device				= device_,
				action				= {command_},
				stop_action			= {command_},
				arg					= {arg_},
				arg_value			= {1},
				arg_lim				= {{0,1}},
				use_release_message	= {true},
--				sound				= {}
				side				= {{BOX_SIDE_Y_bottom}}
			}
end

function short_way_button(hint_,device_,command_,arg_)
	local	button = button_prototype(hint_,device_,command_,arg_)
	button.sound = {{SOUND_SW4_OFF, SOUND_SW4_ON}, {SOUND_SW4_OFF, SOUND_SW4_ON}}
	return button
end

function mfd_button(hint_,device_,command_,arg_)
	local	button	= button_prototype(hint_,device_,command_,arg_)
	button.sound	= {{SOUND_SW4_OFF, SOUND_SW4_ON}, {SOUND_SW4_OFF, SOUND_SW4_ON}}
	return button
end

function default_button(hint_,device_,command_,arg_,animation_speed_)
	local	animation_speed_	= animation_speed_ or anim_speed_default
	local	button 				= button_prototype(hint_,device_,command_,arg_)
	button.animated				= {true}
	button.animation_speed		= {animation_speed_}
	button.sound				= {{SOUND_SW5_ON, SOUND_SW5_OFF}}
	return button
end

function default_2_position_tumb(hint_,device_,command_,arg_,animation_speed_)
	local	animation_speed_ = animation_speed_ or anim_speed_default
	return	{
				class			= {class_type.TUMB,class_type.TUMB},
				hint			= hint_,
				device			= device_,
				action			= {command_,command_},
				arg				= {arg_,arg_},
				arg_value		= {-1,1},
				arg_lim			= {{0,1},{0,1}},
				updatable		= true,
				use_OBB			= true,
				animated		= {true,true},
				animation_speed	= {animation_speed_,animation_speed_},
				sound			= {{SOUND_SW1}},
				side			= {{BOX_SIDE_Z_top},{BOX_SIDE_Z_bottom}}
			}
end

function default_2_position_tumb_small(hint_,device_,command_,arg_,animation_speed_)
	local	element	= default_2_position_tumb(hint_,device_,command_,arg_,animation_speed_)
	element.sound	= {{SOUND_SW3}}
	return element
end

function default_red_cover(hint_,device_,command_,arg_,animation_speed_)
	local	element	= default_2_position_tumb(hint_,device_,command_,arg_,animation_speed_)
	element.sound	= {{SOUND_SW6_OPEN, SOUND_SW6_CLOSE},{SOUND_SW6_OPEN, SOUND_SW6_CLOSE}}
	element.side	= {{BOX_SIDE_Z_top},{BOX_SIDE_Y_bottom}}
	return element
end

function default_3_position_tumb(hint_,device_,command_,arg_,cycled_,animation_speed_,inversed_,arg_value_,arg_limit_)
	local cycled = false
	if cycled_ ~= nil then
		cycled = cycled_
	end
	local	animation_speed_	= animation_speed_ or anim_speed_default
	local	arg_value			= arg_value_ or 1
	if inversed_ then
		arg_value = -arg_value
	end
	local	arg_limit			= arg_limit_ or {-1,1}
	return	{
				class			= {class_type.TUMB,class_type.TUMB},
				hint			= hint_,
				device			= device_,
				action			= {command_,command_},
				arg				= {arg_,arg_},
				arg_value		= {-arg_value, arg_value},
				arg_lim			= {arg_limit,arg_limit},
				updatable		= true,
				use_OBB			= true,
				cycle			= cycled,
				animated		= {true,true},
				animation_speed	= {animation_speed_,animation_speed_},
				sound			= {{SOUND_SW1}},
				side			= {{BOX_SIDE_Z_top},{BOX_SIDE_Z_bottom}}
			}
end

function default_3_position_tumb_small(hint_,device_,command_,arg_,cycled_,animation_speed_,inversed_,arg_value_,arg_limit_)
	local	element	= default_3_position_tumb(hint_,device_,command_,arg_,cycled_,animation_speed_,inversed_,arg_value_,arg_limit_)
	element.sound	= {{SOUND_SW3}}
	return element
end

function multiposition_switch(hint_,device_,command_,arg_,count_,delta_,inversed_,min_,animation_speed_,cycled_,attach_left_,attach_right_)
	local	min_	= min_ or 0
	local	delta_	= delta_ or 0.5

	local	inversed = 1
	if	inversed_ then
		inversed = -1
	end
	local	animation_speed_ = animation_speed_ or anim_speed_default
	local	cycled = true
	if cycled_ ~= nil then
		cycled = cycled_
	end	
	return	{	
				class			= {class_type.TUMB,class_type.TUMB},
				hint			= hint_,
				device			= device_,
				action			= {command_,command_},
				arg				= {arg_,arg_},
				arg_value		= {-delta_ * inversed,delta_ * inversed},
				arg_lim			= {	{min_, min_ + delta_ * (count_ -1)},
									{min_, min_ + delta_ * (count_ -1)}},
				updatable		= true,
				use_OBB			= true,
				cycle			= cycled,
				animated		= {true,true},
				animation_speed	= {animation_speed_,animation_speed_},
				sound			= {{SOUND_SW2}},
				class_vr		= {class_type.MULTY_TUMB, class_type.MULTY_TUMB},
				side			= {{0},{BOX_SIDE_X_top, BOX_SIDE_X_bottom, BOX_SIDE_Z_top, BOX_SIDE_Z_bottom}},
				attach_left		= attach_left_ or nil,
				attach_right	= attach_right_ or nil,
			}
end

function multiposition_switch_tumb(hint_,device_,command_,arg_,count_,delta_,inversed_,min_,animation_speed_,attach_left_,attach_right_)
	local	min_	= min_ or 0
	local	delta_	= delta_ or 0.5

	local	inversed = 1
	if	inversed_ then
		inversed = -1
	end
	local	animation_speed_ = animation_speed_ or anim_speed_default

	return	{	
				class			= {class_type.TUMB,class_type.TUMB},
				hint			= hint_,
				device			= device_,
				action			= {command_,command_},
				arg				= {arg_,arg_},
				arg_value		= {-delta_ * inversed,delta_ * inversed},
				arg_lim			= {	{min_, min_ + delta_ * (count_ -1)},
									{min_, min_ + delta_ * (count_ -1)}},
				updatable		= true,
				use_OBB			= true,
				cycle			= false,
				animated		= {true,true},
				animation_speed	= {animation_speed_,animation_speed_},
				sound			= {{SOUND_SW2}},
				side			= {{BOX_SIDE_Z_top},{BOX_SIDE_Z_bottom}},
				attach_left		= attach_left_ or nil,
				attach_right	= attach_right_ or nil,
			}
end

function default_button_tumb(hint_,device_,command1_,command2_,arg_,animation_speed_)
	local	animation_speed_ = animation_speed_ or anim_speed_default
	return	{
				class				= {class_type.BTN,class_type.TUMB},
				hint				= hint_,
				device				= device_,
				action				= {command1_,command2_},
				stop_action			= {command1_,0},
				arg					= {arg_,arg_},
				arg_value			= {-1,1},
				arg_lim				= {{-1,0},{0,1}},
				updatable			= true,
				use_OBB				= true,
				use_release_message	= {true,false},
				animated			= {true,true},
				animation_speed		= {animation_speed_,animation_speed_},
				sound				= {{SOUND_SW1},{SOUND_SW1}},
				side				= {{BOX_SIDE_Z_top},{BOX_SIDE_Z_bottom}}
			}
end

function default_tumb_button(hint_,device_,command1_,command2_,arg_,animation_speed_)
	local	animation_speed_ = animation_speed_ or anim_speed_default
	return	{
				class				= {class_type.TUMB,class_type.BTN},
				hint				= hint_,
				device				= device_,
				action				= {command1_,command2_},
				stop_action			= {0,		 command2_},
				arg					= {arg_,arg_},
				arg_value			= {-1,1},
				arg_lim				= {{-1,0},{0,1}},
				updatable			= true,
				use_OBB				= true,
				use_release_message	= {false,true},
				animated			= {true,true},
				animation_speed		= {animation_speed_,animation_speed_},
				sound				= {{SOUND_SW1},{SOUND_SW1}},
				side				= {{BOX_SIDE_Z_top},{BOX_SIDE_Z_bottom}}
			}
end

function springloaded_2_pos_tumb(hint_,device_,command_,arg_,animation_speed_)
	local	element		= default_2_position_tumb(hint_,device_,command_,arg_,animation_speed_)
	element.class		= {class_type.BTN,class_type.BTN}
	element.stop_action	= {command_, command_}
	element.arg_value	= {1,1}
	element.sound		= {{SOUND_SW1, SOUND_SW1_OFF}, {SOUND_SW1, SOUND_SW1_OFF}}
	return element
end

function springloaded_2_pos_tumb_small(hint_,device_,command_,arg_,animation_speed_)
	local	element	= springloaded_2_pos_tumb(hint_,device_,command_,arg_,animation_speed_)
	element.sound	= {{SOUND_SW3, SOUND_SW3_OFF}, {SOUND_SW3, SOUND_SW3_OFF}}
	element.side	= {{},{BOX_SIDE_Z_bottom}}
	return element
end

function springloaded_3_pos_tumb(hint_,device_,command1_,command2_,arg_,animation_speed_,val1_,val2_,val3_)
	local	animation_speed_	= animation_speed_ or anim_speed_default
	local	val1				= val1_ or -1.0
	local	val2				= val2_ or 0.0
	local	val3				= val3_ or 1.0
	return	{
				class				= {class_type.BTN,class_type.BTN},
				hint				= hint_,
				device				= device_,
				action				= {command1_,command2_},
				stop_action			= {command1_,command2_},
				arg					= {arg_,arg_},
				arg_value			= {val1,val3},
				arg_lim				= {{val1,val2},{val2,val3}},
				updatable			= true,
				use_OBB				= true,
				use_release_message	= {true,true},
				animated			= {true,true},
				animation_speed		= {animation_speed_,animation_speed_},
				sound				= {{SOUND_SW1_OFF, SOUND_SW1}, {SOUND_SW1, SOUND_SW1_OFF}},
				side				= {{BOX_SIDE_Z_top},{BOX_SIDE_Z_bottom}}
			}
end

function springloaded_3_pos_tumb_small(hint_,device_,command1_,command2_,arg_,animation_speed_,val1_,val2_,val3_)
	local	element	= springloaded_3_pos_tumb(hint_,device_,command1_,command2_,arg_,animation_speed_,val1_,val2_,val3_)
	element.sound	= {{SOUND_SW3_OFF, SOUND_SW3}, {SOUND_SW3, SOUND_SW3_OFF}}
	return element
end

function default_animated_lever(hint_,device_,command_,arg_,animation_speed_,arg_lim_)
	local	animation_speed_	= animation_speed_ or 3
	local	arg_lim__			= arg_lim_ or {0.0,1.0}
	local	element				= default_2_position_tumb(hint_,device_,command_,arg_,animation_speed_)
	element.arg_value			= {1, 0}
	element.animation_speed		= {animation_speed_, 0}
	element.sound				= {{SOUND_SW8_DOWN,SOUND_SW8_UP}}
	return	element
end

function default_axis(hint_,device_,command_,arg_, default_, gain_,updatable_,relative_,cycled_,attach_left_,attach_right_)
	local	default		= default_ or 1
	local	gain		= gain_ or 0.1
	local	updatable	= updatable_ or false
	local	relative	= relative_ or false
	return	{
				class		= {class_type.LEV},
				hint		= hint_,
				device		= device_,
				action		= {command_},
				arg			= {arg_},
				arg_value	= {default},
				arg_lim		= {{0,1}},
				updatable	= updatable,
				use_OBB		= true,
				gain		= {gain},
				relative	= {relative},
				cycle		= cycled_ or false,
				sound		= {{SOUND_SW10}},
				attach_left	= attach_left_ or nil,
				attach_right= attach_right_ or nil,
				side		= {{BOX_SIDE_X_top, BOX_SIDE_X_bottom, BOX_SIDE_Z_top, BOX_SIDE_Z_bottom}}
			}
end

function default_axis_limited(hint_,device_,command_,arg_,default_,gain_,updatable_,relative_,arg_lim_,attach_left_,attach_right_)
	local	default		= default_ or 0
	local	updatable	= updatable_ or false
	local	relative	= relative_ or false
	local	cycled_		= false
	local	arg_lim		= arg_lim_ or {0,1}

	local	element		= default_axis(hint_,device_,command_,arg_,default,gain_,updatable,relative,cycled_,attach_left_,attach_right_)
	element.arg_lim		= {arg_lim}
	element.use_OBB		= false
	return element
end

function default_axis_limited_1_side(hint_,device_,command_,arg_,default_,gain_,updatable_,relative_,arg_lim_,attach_left_,attach_right_)
	local	element		= default_axis_limited(hint_,device_,command_,arg_,default_,gain_,updatable_,relative_,arg_lim_,attach_left_,attach_right_)
	element.side = {{BOX_SIDE_X_bottom}}
	return element
end

function default_trimmer_button(hint_,device_,command_,arg_,value_,animation_speed_)
	local	element	= default_button(hint_,device_,command_,arg_,animation_speed_)
	local	value	= value_ or 1
	local	lim_min	= 0
	local	lim_max	= value
	if value < 0 then
		lim_min = value
		lim_max = 0
	end
	element.arg_value	= {value}
	element.arg_lim		= {{lim_min,lim_max}}
	element.animated	= {false}
	element.updatable	= true
	return element
end

function default_button_axis(hint_,device_,command1_,command2_,arg1_,arg2_,animation_speed_,attach_left_,attach_right_)
	local	animation_speed_ = animation_speed_ or anim_speed_default
	return	{
				class				= {class_type.BTN,		class_type.LEV},
				hint				= hint_,
				device				= device_,
				action				= {command1_,			command2_},
				stop_action			= {command1_,			0},
				use_release_message	= {true,				false},
				arg					= {arg1_,				arg2_},
				gain				= {1.0,					0.2},
				relative			= {false,				false},
				arg_value			= {1,					1},
				arg_lim				= {{0, 1},				{0, 1}},
				animated			= {true,				false},
				animation_speed		= {animation_speed_,	0.0},
				sound				= {{SOUND_SW1},			{SOUND_SW10}},
				updatable			= true,
				use_OBB				= true,
				attach_left			= attach_left_ or nil,
				attach_right		= attach_right_ or nil,
				side				= {{BOX_SIDE_Y_bottom},{BOX_SIDE_X_top, BOX_SIDE_X_bottom, BOX_SIDE_Z_top, BOX_SIDE_Z_bottom}}
			}
end

-- added just for conventional naming
function Rocker_switch_positive(hint_,device_,command_,arg_)
	return short_way_button(hint_, device_, command_, arg_)
end

function Rocker_switch_negative(hint_,device_,command_,arg_)
	local button = short_way_button(hint_, device_, command_, arg_)
	button.arg_value	= {-1}
	button.arg_lim		= {{-1, 0}}
	return button
end

function default_button_knob(hint_,device_,command1_,command2_,arg1_,arg2_,animation_speed_,attach_left_,attach_right_)
	local	animation_speed_ = animation_speed_ or anim_speed_default
	return
	{
		class				= {class_type.BTN,		class_type.LEV},
		hint				= hint_,
		device				= device_,
		action				= {command1_,			command2_},
		stop_action			= {command1_,			0},
		use_release_message	= {true,				false},
		arg					= {arg1_,				arg2_},
		gain				= {1.0,					0.2},
		relative			= {false,				true},
		arg_value			= {1,					1},
		arg_lim				= {{0, 1},				{0, 1}},
		animated			= {true,				false},
		animation_speed		= {animation_speed_,	0.0},
		sound				= {{SOUND_SW1},			{SOUND_SW10}},
		updatable			= true,
		use_OBB				= true,
		attach_left			= attach_left_ or nil,
		attach_right		= attach_right_ or nil,
		side				= {{BOX_SIDE_Y_bottom},{BOX_SIDE_X_top, BOX_SIDE_X_bottom, BOX_SIDE_Z_top, BOX_SIDE_Z_bottom}}
	}
end
