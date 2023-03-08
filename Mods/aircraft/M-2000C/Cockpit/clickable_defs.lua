dofile(LockOn_Options.script_path.."sounds.lua")
math.randomseed(os.time())

cursor_mode =
{
    CUMODE_CLICKABLE = 0,
    CUMODE_CLICKABLE_AND_CAMERA  = 1,
    CUMODE_CAMERA = 2,
};

clickable_mode_initial_status  = cursor_mode.CUMODE_CLICKABLE
use_pointer_name			   = true
anim_speed_default = 35.0



function get_sound_pair(base)
	local prefix = base
	if base=="lever*" then
		prefix = "lever"..math.random(6)
	elseif base=="small*" then
		prefix = "small"..math.random(6)
	elseif base=="guard*" then
		prefix = "guard"..math.random(4)
	end
	
	if sound_id[prefix] ~= nil then
		return {sound_id[prefix], sound_id[prefix]}
	elseif (sound_id[prefix.."-off"] ~= nil) and (sound_id[prefix.."-on"] ~= nil) then
		return {sound_id[prefix.."-on"], sound_id[prefix.."-off"]}
	else
		return {}
	end

end




function fallback_nil (value , fallback)
    if value==nil then return fallback else return value end
end


--Push button sending 1 when pushed, 0 when released
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






function push_button(hint,device,command,arg, options)
	options = options or {}
	local use_release = fallback_nil(options.use_release, true) 
	local sound_pair 	= get_sound_pair(options.sound or "pca")

	local element = {}	
	element.class 				= {class_type.BTN}
	element.hint  				= hint
	element.device 				= device
	element.action 				= {command}
	element.stop_action 		= {command}
	element.arg 				= {arg}
	element.arg_value			= {1}
	element.arg_lim 			= {{0,1}}
	element.use_release_message = {use_release}
	element.sound 				= {sound_pair}
	
	if options.inverted then
		element.arg_value			= {0}
		element.stop_value  		= {1}
	end
	
	return element
end


--Push button sending 1 when pushed, nothing when released
function push_button_impl(hint,device,command,arg, options)
	options = options or {}
	options.use_release = false
	return push_button(hint,device,command,arg, options)
end





function lever_npos(n, hint, device, command, arg, options)
	options = options or {}
	local limits = options.limits or {0, 1}
	local delta = (limits[2]-limits[1])/(n-1)
	local sound_pair 	= get_sound_pair(options.sound or "lever*")
	local speed = options.speed or anim_speed_default
	
	
	element = {}
	element.class 			= {class_type.TUMB,class_type.TUMB}
	element.hint  			= hint
	element.device 			= device
	element.action 			= {command,command}
	element.arg 	  		= {arg,arg}
	element.arg_value 		= {-delta,delta}
	element.arg_lim   		= {limits, limits}
	element.updatable 		= true
	element.use_OBB 		= true
	element.cycle			= false
	element.sound 			= {sound_pair}
	element.animated		= {true,true}
	element.animation_speed	= {speed,speed}
	
	if options.inverted then
		element.arg_value 		= {delta,-delta}
	end
	
	return element
end


function lever_2pos(hint, device, command, arg, options)
	return lever_npos(2, hint, device, command, arg, options)
end



function lever_3pos(hint, device, command, arg, options)
	return lever_npos(3, hint, device, command, arg, options)
end




function switch_guard(hint, device, command, arg, options)
	options = options or {}
	
	local sound_pair 	= get_sound_pair(options.sound or "guard*")
	local speed = options.speed or anim_speed_default

	element = {}
	element.class 		= {class_type.TUMB,class_type.TUMB}
	element.hint  		= hint
	element.device 		= device
	element.action 		= {command,command}
	element.arg 	  	= {arg,arg}
	element.arg_value 	= {1,-1}
	element.arg_lim   	= {{0,1},{0,1}}
	element.updatable 	= true
	element.use_OBB 	= true
	element.animated = {true, true}
	element.animation_speed = {speed, speed}
	element.sound 		= {sound_pair}
	
	return element
end







function default_axis_cycle(hint, device, command, arg, default, gain, relative)

	local default = default or 1
	local gain = gain or 0.1
	local updatable = updatable or false
	local relative  = relative or false

	return  {
				class 		= {class_type.LEV},
				hint  		= hint,
				device 		= device,
				action 		= {command},
				arg 	  	= {arg},
				arg_value 	= {default},
				arg_lim   	= {{0,1}},
				updatable 	= true,
				use_OBB 	= true,
				gain		= {gain},
				relative    = {relative},
				cycle     	= true,
			}
end


function potentiometer(hint_,device_,command_,arg_, default_, gain_,updatable_,relative_, arg_lim_)

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
                cycle       = false,
			}
end

function clickable_pot(hint, device, axis_command, axis_arg, click_command, click_arg, options)

	options = options or {}
	local click_sound_pair 	= get_sound_pair(options.sound or "click1")
	local gain = options.gain or 0.5
	local limits = options.limits or {0,1}

	element = {}
	element.class 				= {class_type.BTN, class_type.BTN, class_type.LEV }
	element.hint				= hint
	element.device				= device
	element.action				= { click_command, click_command, axis_command }
	element.stop_action			= { click_command, click_command, nil }
	element.is_repeatable 		= { }
	element.arg 				= { click_arg, click_arg, axis_arg }
	element.arg_value 			= { 1, 1, 0}
	element.stop_value  		= { 0, 0, 0}         	
	element.arg_lim 			= { {0, 1}, {0, 1}, limits}
	element.gain 				= { 0, 0, gain}
	element.relative 			= {false, false, false}
	element.cycle 				= false
	element.use_release_message = { true, true, false }
	element.sound 				= {click_sound_pair, click_sound_pair, {}}
	element.use_OBB 			= true
	return element
end




function axis_limited_cycle(hint_,device_,command_,arg_, default_, gain_,updatable_,relative_, arg_lim_)

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


function default_animated_lever(hint, device, command, arg, options)
	
	options = options or {}
	local limits = options.limits or {0.0, 1.0}
	local delta = limits[2]-limits[1]
	local speed = options.speed or 5.0
	
	element = {}
	element.class			= {class_type.TUMB, class_type.TUMB}
	element.hint			= hint
	element.device			= device
	element.action			= {command, command}
	element.arg				= {arg, arg}
	element.arg_value		= {-delta, delta}
	element.arg_lim			= {limits, limits}
	element.updatable		= true
	element.use_OBB			= true
	element.gain			= {1,1}
	element.animated		= {true, true}
	element.animation_speed	= {speed, speed}
	element.cycle = true
	
	if options.sound then
		local sound_pair = get_sound_pair(options.sound)
		element.sound 			= {sound_pair}
	end
	
	return element
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

function auxadi_knob(hint, device, cmd1, cmd2, arg1, arg2)
	local sound_pair = get_sound_pair("auxadi")
	
	return {
		class 				= {class_type.BTN, class_type.BTN, class_type.LEV },
		hint				= hint, 
		device				= device,
		action				= { cmd1, cmd1, cmd2 },
		stop_action			= {cmds.Button_325, cmds.Button_325, nil }, 
		is_repeatable 		= {},
		arg 				= {arg1, arg1, arg2 },
		arg_value 			= {1,1,0},
		arg_lim 			= {{0, 1}, {0, 1}, {-1, 1}},
		gain 				= {0,0,0.4},
		relative 			= {false, false, false},
		cycle 				= false,
		use_release_message = { true, true, false },
		sound 				= {sound_pair, sound_pair, {}},
		use_OBB 			= true,
	}
end


function canopy_handle(hint, device, command, arg, gain, toggle_command)
	local element = {}
	element.class 		= {class_type.LEV, class_type.BTN}
	element.hint  		= hint
	element.device 		= device
	element.action 		= {command, toggle_command }
	element.arg 	  	= {arg}
	element.arg_value 	= {1,1}
	element.arg_lim   	= {{0,1}, {0,1}}
	element.gain		= {gain or 0.1, 0}
	element.updatable 	= true
	element.use_OBB 	= true
	element.relative    = {true, false}
	element.cycle     	= true
	return element
end


function canopy_lever(hint, device, command, arg)
	element = {}
	element.class 			= {class_type.BTN,class_type.BTN}
	element.hint  			= hint
	element.device 			= device
	element.action 			= {command,command}
	element.arg 	  		= {arg,arg}
	element.arg_value 		= {-1, 1}
	element.arg_lim 		= {-1, 1}
	element.updatable 		= true
	element.use_OBB 		= true
	element.use_release_message = {true,true}
	element.stop_action		= {command,command}
	element.stop_value  	= {0, 0}         	
	return element
end




function lever_mon_off_mon(hint, device, command, arg, options)
	options = options or {}
	
	local limits = options.limits or {-1, 1}
	local middle = (limits[1]+limits[2])*0.5
	local sound_pair = get_sound_pair(options.sound or "click2")

	
	if not options.inverted then
		local t = limits[2]
		limits[2] = limits[1]
		limits[1] = t
	end
	
	local element = {}
	element.class		= {class_type.BTN, class_type.BTN}
	element.hint  		= hint
	element.device 		= device
	element.action 		= {command,command}
	element.stop_action = {command,command}
	element.arg 		= {arg, arg}
	element.arg_value	= {limits[2], limits[1]}
	element.stop_value  = {middle, middle}                                
	element.use_OBB		= true
	element.updatable	= true
	element.use_release_message = {true, true}
	element.sound 		= {sound_pair}
	
	return element
end


function default_1_way_spring_switch(hint_, device_, command1_, arg_, values_)

	if values_ == nil or values_ == false then
		values_ = {0,1}
	elseif values_== true then
		values_ = {1,0}
	end
	
	return	{
				class		= {class_type.BTN},
				hint  		= hint_,
				device 		= device_,
				action 		= {command1_},
				stop_action = {command1_},
				arg 		= {arg_},
				arg_value	= {values_[2]},
				stop_value  = {values_[1]},
				use_OBB		= true,
				updatable	= true,
				use_release_message = {true}
			}
end




function knob_limited(hint, device, command,arg, n, options)
	options = options or {}
	
	local limits = options.limits or {0, 0.1*(n-1)}
	local delta = (limits[2]-limits[1])/(n-1)
	local sound_pair = get_sound_pair(options.sound or "click2")

	
	if options.inverted then
		delta = -delta
	end
	
	local element = {}
	element.class 			= {class_type.TUMB,class_type.TUMB}
	element.hint  			= hint
	element.device 			= device
	element.action 			= {command,command}
	element.arg 	  		= {arg,arg}
	element.arg_value 		= {-delta,delta}
	element.arg_lim   		= {limits, limits}
	element.updatable 		= true
	element.use_OBB 		= true
	element.cycle			= false
	element.sound 			= {sound_pair}
	
	if options.speed then
		element.animated		= {true,true}
		element.animation_speed	= {options.speed, options.speed}
	end
	
	return element
end


function knob_free(hint, device, command, arg, count, delta, options)
	options = options or {}	
	
    local minv 			= options.min or 0
	local sound_pair 	= get_sound_pair(options.sound or "knob")
	local delta			= delta or 0.1
	
	local element = {}
	element.class 		= {class_type.TUMB,class_type.TUMB}
	element.hint  		= hint
	element.device 		= device
	element.action 		= {command,command}
	element.arg 	  	= {arg,arg}
	element.arg_value 	= {-delta,delta}
	element.arg_lim   	= {{minv, minv + delta * (count-1)}, {minv, minv + delta * (count-1)}}
	element.updatable 	= true
	element.use_OBB 	= true
	element.cycle     	= true
	element.sound 		= {sound_pair}
	
	if options.inverted then
		element.arg_value 		= {delta,-delta}
	end
	
	return element
end



function knob_encoder(hint, device, command, arg, count, options)

	options = options or {}	
	local sound_pair 	= get_sound_pair(options.sound or "knob")

	local delta = 1.0/count
	if options.inverted then
		delta 		= -delta
	end
	
	local element = {}
	element.class 		= {class_type.TUMB,class_type.TUMB, class_type.LEV}
	element.hint  		= hint
	element.device 		= device
	element.action 		= {command,command, command}
	element.arg 	  	= {arg,arg, arg}
	element.arg_value 	= {-delta, delta, 0}
	element.arg_lim   	= {{0, 1}, {0, 1}, {0, 1}}
	element.gain		= {0,0,delta*6.66829466}	--WTF value to get accurate mouse wheel increments
	element.relative	= { true, true, true }
	element.updatable 	= true
	element.use_OBB 	= true
	element.cycle     	= true
	element.sound 		= {sound_pair, sound_pair, sound_pair}
	
	return element
end



function knob_encoder_with_ring(hint, device, ring_command, knob_command, ring_arg, knob_arg, ring_n, knob_n, ring_options, knob_options)
	local element = knob_limited(hint, device, ring_command, ring_arg, ring_n, ring_options)
	local encoder = knob_encoder(hint, device, knob_command, knob_arg, knob_n, knob_options)
	
	element.class[3] 	 = class_type.LEV
	element.action[3]	 = knob_command
	element.arg[3]	  	 = knob_arg
	element.arg_value[3] = 0
	element.arg_lim[3]   = {-10, 10}
	element.gain		 = {0, 0, (1.0/knob_n)*6.66829466}
	element.sound[3]	 = encoder.sound[3]
	
	if ring_options.spring then
		element.class[1] = class_type.BTN
		element.class[2] = class_type.BTN
		element.use_release_message = { true, true, false }
		element.arg_value[1] 		= element.arg_lim[1][1]
		element.arg_value[2] 		= element.arg_lim[1][2]
		element.stop_action			= { ring_command, ring_command, nil }
		element.stop_value  		= { ring_options.spring, ring_options.spring, 0}   
	end
	
	return element
end


function dtc_cartridge(hint, device, plug_command, plug_arg, choose_command, plug_options)
	plug_options = plug_options or {}
	plug_options.limits = plug_options.limits or {-1, 1}
	plug_options.inverted = (plug_options.inverted == nil or plug_options.inverted == false)
	knob_options = {sound="mip-swap"}

	return knob_encoder_with_ring(hint, device, plug_command, choose_command, plug_arg, nil, 3, 10, plug_options, knob_options)
end



function thumbwheel(hint, device, command,arg, n, options)
	options = options or {}
	
	local cycle = n==10
	local delta = options.delta or 0.1
	local sound_pair 	= get_sound_pair(options.sound or "bingo")
	local gain = delta*6.66829466
	
	local limits = {0, delta*(n-1)}
	
	if cycle then
		limits_mw = {0, delta*n}
	else
		limits_mw = limits
	end
	
	if options.inverted then
		delta = -delta
		gain = -gain
	end
	

		
	
	local element = {}
	element.class 			= {class_type.TUMB,class_type.TUMB,class_type.LEV}
	element.hint  			= hint
	element.device 			= device
	element.action 			= {command,command,command}
	element.arg 	  		= {arg,arg,arg}
	element.arg_value 		= {-delta,delta,0}
	element.arg_lim   		= {limits,limits,limits_mw}
	element.gain		 	= {0, 0, gain}
	element.updatable 		= true
	element.use_OBB 		= true
	element.cycle			= cycle
	element.sound 			= {sound_pair}
	return element
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

function multiposition_switch_spring_animated(hint_, device_, command_1, command_2, arg_, inversed_, min_, animation_speed_)
    local element = multiposition_switch_spring(hint_, device_, command_1, command_2, arg_, inversed_, min_)
	local animation_speed_  = animation_speed_ or anim_speed_default
	element.animated		= {true,true}
	element.animation_speed	= {animation_speed_,animation_speed_}
	return element
end


