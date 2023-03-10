dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."config.lua")
dofile(LockOn_Options.script_path.."sounds.lua")

local gettext = require("i_18n")
_ = gettext.translate

cursor_mode = 
{ 
    CUMODE_CLICKABLE = 0,
    CUMODE_CLICKABLE_AND_CAMERA  = 1,
    CUMODE_CAMERA = 2,
};

clickable_mode_initial_status  	= cursor_mode.CUMODE_CLICKABLE

anim_speed_default_3_pos_thumb	= 24
anim_speed_default_2_pos_thumb	= 15
anim_speed_springloaded_thumb	= 24
anim_speed_multipos_thumb		= 2

function default_button(hint_,device_,command_,arg_,arg_val_,arg_lim_, message_)

	local   arg_val_ = arg_val_ or 1
	local   arg_lim_ = arg_lim_ or {0,1}
	local   message__ = true
	if message_ ~= nil then
		message__ = message_
	end

	return  {	
				class 				= {class_type.BTN, class_type.BTN},
				hint  				= hint_,
				device 				= device_,
				action 				= {command_, command_},
				stop_action 		= {command_, command_},
				arg 				= {arg_, arg_},
				arg_value			= {arg_val_, arg_val_}, 
				arg_lim 			= {arg_lim_, arg_lim_},
				use_release_message = {message__, message__},
				side				= {{BOX_SIDE_Y_bottom}, {BOX_SIDE_Y_bottom}},
				sound				= {{SOUND_SW4_OFF, SOUND_SW4_ON}}
			}
end

function action_button(hint_,device_,command1_,command2_,arg_,arg_val_,arg_lim_, message_)

	local button_ = default_button(hint_,device_,command1_,arg_,arg_val_,arg_lim_, message_)
	button_.stop_action = {command2_, command2_}
	return button_
end

function push_button_tumb(hint_,device_,command_,arg_)
	return  {	
				class 				= {class_type.TUMB, class_type.TUMB},
				hint  				= hint_,
				device 				= device_,
				action 				= {command_, command_},
				arg 				= {arg_, arg_},
				arg_value			= {1, 1}, 
				arg_lim 			= {{0,1}, {0,1}},
				updatable 			= true, 
				use_OBB 			= true,
				class_vr 			= {class_type.BTN_FIX},
				side				= {{BOX_SIDE_Y_bottom}},
				sound				= {{SOUND_SW4_ON, SOUND_SW4_OFF}}
			}
end

function default_2_position_tumb(hint_, device_, command_, arg_, arg_val_, arg_lim_, animation_speed_)

	local   arg_val_ = arg_val_ or {-1, 1}
	local   arg_lim_ = arg_lim_ or {{0,1},{0,1}}
	
	local	animation_speed_ = animation_speed_ or anim_speed_default_2_pos_thumb
	
	return  {	
				class 			= {class_type.TUMB,class_type.TUMB},
				hint  			= hint_,
				device 			= device_,
				action 			= {command_,command_},
				arg 	  		= {arg_,arg_},
				arg_value 		= arg_val_, 
				arg_lim   		= arg_lim_,
				updatable 		= true, 
				use_OBB 		= true,
				animated		= {true,true},
			    animation_speed	= {animation_speed_,animation_speed_},
				side			= {{BOX_SIDE_Z_top},{BOX_SIDE_Z_bottom}},
				sound			= {{SOUND_SW1}}
			}
end

function default_2_position_small_tumb(hint_, device_, command_, arg_, arg_val_, arg_lim_, animation_speed_)
    local	element = default_2_position_tumb(hint_, device_, command_, arg_, arg_val_, arg_lim_, animation_speed_)
	element.sound	= {{SOUND_SW3}}
	return  element
end

function default_2_position_cover(hint_, device_, command_, arg_)
	
	local element = default_2_position_tumb(hint_, device_, command_, arg_)
	element.side		= {{BOX_SIDE_Z_bottom},{BOX_SIDE_Y_bottom}}		
	element.sound		= {{SOUND_SW5_OPEN, SOUND_SW5_CLOSE}}
	return element
end

function default_2_position_cover_plastic(hint_, device_, command_, arg_)
    local	element = default_2_position_cover(hint_, device_, command_, arg_)
	element.sound	= {{SOUND_SW8_OPEN, SOUND_SW8_CLOSE}}
	return  element
end

function default_animated_lever(hint_,device_,command_,arg_,arg_val_,arg_lim_,animation_speed_,gain_, cycle_)
	local	animation_speed_	= animation_speed_ or 5
	local   gain_				= gain_ or 0.1
	local	cycled 	 			= true
	if cycle_ ~= nil then
		cycled 	 = cycle_ 
	end
	
	local	element				= default_2_position_tumb(hint_,device_,command_,arg_,arg_val_,arg_lim_)
	
	element.animated			= {true,true}
	element.animation_speed		= {animation_speed_, animation_speed_}
	element.gain 				= {gain_,gain_}
	element.cycle 				= cycled
	element.sound				= {{SOUND_SW7_UP, SOUND_SW7_DOWN}}

	return	element
end

function default_3_position_tumb(hint_,device_,command_,arg_,cycled_,inversed_, arg_val_, arg_lim_, animation_speed_)

	local side_	= {{BOX_SIDE_Z_top},{BOX_SIDE_Z_bottom}}
	local val_ 	=  1
	if inversed_ then
	      val_ = -1
		  side_	= {{BOX_SIDE_Z_bottom},{BOX_SIDE_Z_top}}
	end

	local   arg_val_ = arg_val_ or {-val_, val_}
	local   arg_lim_ = arg_lim_ or {{-1,1},{-1,1}}
	
	local	cycled 	 = false
	if cycled_ ~= nil then
		cycled 	 = cycled_ 
	end

	local	animation_speed_ = animation_speed_ or anim_speed_default_3_pos_thumb

	return  {	
				class 			= {class_type.TUMB,class_type.TUMB},
				hint  			= hint_,
				device 			= device_,
				action 			= {command_,command_},
				arg 	  		= {arg_,arg_},
				arg_value 		= arg_val_, 
				arg_lim   		= arg_lim_,
				updatable 		= true, 
				use_OBB 		= true,
				cycle       	= cycled,
				animated		= {true,true},
			    animation_speed	= {animation_speed_,animation_speed_},
				side			= side_,
				sound			= {{SOUND_SW1}}
			}
end

function default_3_position_small_tumb(hint_,device_,command_,arg_,cycled_,inversed_, arg_val_, arg_lim_, animation_speed_)
    local	element = default_3_position_tumb(hint_,device_,command_,arg_,cycled_,inversed_, arg_val_, arg_lim_, animation_speed_)
	element.sound	= {{SOUND_SW3}}
	return  element
end

function springloaded_3_pos_tumb(hint_,device_,command1_,command2_,arg_, arg_val_, val_min_,val_stop_,val_max_, animation_speed_)
	
	local	arg_val_ 				= arg_val_ or 1.0		
	local	val_min_				= val_min_ or -1.0
	local	val_stop_				= val_stop_ or 0.0
	local	val_max_				= val_max_ or 1.0

	local	animation_speed_ = animation_speed_ or anim_speed_springloaded_thumb
	
	return	{
				class				= {class_type.BTN,class_type.BTN},
				hint				= hint_,
				device				= device_,
				action				= {command1_,command2_},
				stop_action			= {command1_,command2_},
				arg					= {arg_,arg_},
				arg_value			= {-arg_val_,arg_val_},
				arg_lim				= {{val_min_,val_stop_},{val_stop_,val_max_}},
				stop_value 			= {val_stop_,val_stop_},	
				updatable			= true,
				--use_OBB				= true,
				use_release_message	= {true,true},
				animated			= {true,true},
			    animation_speed		= {animation_speed_,animation_speed_},
				sound				= {{SOUND_SW1_OFF, SOUND_SW1}, {SOUND_SW1, SOUND_SW1_OFF}},
				side				= {{BOX_SIDE_Z_top},{BOX_SIDE_Z_bottom}}
			}
end

function default_axis(hint_,device_,command_,arg_, default_, gain_,updatable_,relative_, cycled_,attach_left_,attach_right_)
	
	local relative = false
	if relative_ ~= nil then
		relative = relative_
	end

	local gain = gain_ or 0.1
	local cycled = cycled_ or false
	
	local default = default_ or 1
	return  {	
				class 		= {class_type.LEV},
				hint  		= hint_,
				device 		= device_,
				action 		= {command_},
				arg 	  	= {arg_},
				arg_value 	= {default}, 
				arg_lim   	= {{0,1}},
				updatable 	= {updatable_}, 
				use_OBB 	= true,
				gain		= {gain},
				relative    = {relative},  
				cycle		= cycled,
				side		= {{BOX_SIDE_X_top, BOX_SIDE_X_bottom, BOX_SIDE_Z_top, BOX_SIDE_Z_bottom}},
				attach_left	= attach_left_ or nil,
				attach_right= attach_right_ or nil,
				sound		= {{SOUND_SW6}}
			}
end

function default_axis_limited(hint_,device_,command_,arg_,gain_,updatable_,relative_, _arg_lim, cycled_,attach_left_,attach_right_)
	
	local updatable_ = updatable_ or false
	
	local relative = false
	if relative_ ~= nil then
		relative = relative_
	end
	
	local _arg_lim = _arg_lim or {0,1}
	local cycled = cycled_ or false

	local gain = gain_ or 0.1
	return  {	
				class 		= {class_type.LEV},
				hint  		= hint_,
				device 		= device_,
				action 		= {command_},
				arg 	  	= {arg_},
				arg_value 	= {1}, 
				arg_lim   	= {_arg_lim},
				updatable 	= {updatable_}, 
				use_OBB 	= false,
				gain		= {gain},
				relative    = {relative},  
				cycle		= cycled,
				side		= {{BOX_SIDE_X_top, BOX_SIDE_X_bottom, BOX_SIDE_Z_top, BOX_SIDE_Z_bottom}},
				attach_left	= attach_left_ or nil,
				attach_right= attach_right_ or nil,
				sound		= {{SOUND_SW6}}
			}
end


function axis_limited_1_side(hint_,device_,command_,arg_,gain_,updatable_, _arg_lim,attach_left_,attach_right_)
	local	element		= default_axis_limited(hint_,device_,command_,arg_,gain_,updatable_,nil,_arg_lim,attach_left_,attach_right_)
	element.side 		= {{BOX_SIDE_X_bottom}}
	return element
end


function multiposition_switch(hint_,device_,command_,arg_,count_,delta_,min_,animation_speed_,attach_left_,attach_right_)
    local min_   = min_ or 0
	local delta_ = delta_ or 0.5
	local delta_abs = math.abs(delta_)
	
	local element = {	
				class 		= {class_type.TUMB,class_type.TUMB},
				hint  		= hint_,
				device 		= device_,
				action 		= {command_,command_},
				arg 	  	= {arg_,arg_},
				arg_value 	= {-delta_,delta_}, 
				arg_lim   	= {{min_, min_ + delta_abs * (count_ - 1)},
							   {min_, min_ + delta_abs * (count_ - 1)}},
				updatable 	= true, 
				use_OBB 	= true,
				class_vr	= {class_type.MULTY_TUMB, class_type.MULTY_TUMB},
				side		= {{0},{BOX_SIDE_X_top, BOX_SIDE_X_bottom, BOX_SIDE_Z_top, BOX_SIDE_Z_bottom}},
				attach_left	= attach_left_,
				attach_right= attach_right_,
				cycle 		= false,
				sound		= {{SOUND_SW2}}
			}
	
	if animation_speed_ ~= nil then
		element.animated        = {true, true}
		element.animation_speed = {animation_speed_, animation_speed_}
	end
	
	return element
end

function multiposition_switch_1_side(hint_,device_,command_,arg_,count_,delta_,min_,animation_speed_,attach_left_,attach_right_)
	local	element		= multiposition_switch(hint_,device_,command_,arg_,count_,delta_,min_,animation_speed_,attach_left_,attach_right_)
	element.side 		= {{BOX_SIDE_X_bottom}}
	--element.relative	= {true, true}
	element.cycle 		= true
	element.sound		= {{SOUND_SW9}}
	
	return element
end


function multiposition_switch_intercom(hint_,device_,command_,arg_,count_,delta_,min_,attach_left_,attach_right_)
    local min_   = min_ or 0
	local delta_ = delta_ or 0.5
	local delta_abs = math.abs(delta_)
	return  {	
				class 		= {class_type.TUMB,class_type.TUMB},
				hint  		= hint_,
				device 		= device_,
				action 		= {command_,command_},
				arg 	  	= {arg_,arg_},
				arg_value 	= {delta_,-delta_}, 
				arg_lim   	= {{min_, min_ + delta_abs * (count_ - 1)},
							   {min_, min_ + delta_abs * (count_ - 1)}},
				animated        = {true,true},
			    animation_speed = {anim_speed_multipos_thumb, anim_speed_multipos_thumb},
				cycle       = false,
				updatable 	= true, 
				use_OBB 	= true,
				class_vr	= {class_type.MULTY_TUMB, class_type.MULTY_TUMB},
				side		= {{0},{BOX_SIDE_X_top, BOX_SIDE_X_bottom, BOX_SIDE_Z_top, BOX_SIDE_Z_bottom}},
				attach_left	= attach_left_,
				attach_right= attach_right_,
				sound		= {{SOUND_SW2}}
			}
end

function multiposition_switch_limited(hint_,device_,command_,arg_,count_,delta_,min_,animation_speed_,attach_left_,attach_right_)
    local min_   = min_ or 0
	local delta  = delta_ or 0.5
	local delta_abs = math.abs(delta_)
	
	local element = {	
				class 		= {class_type.TUMB,class_type.TUMB},
				hint  		= hint_,
				device 		= device_,
				action 		= {command_,command_},
				arg 	  	= {arg_,arg_},
				arg_value 	= {-delta_,delta_}, 
				arg_lim   	= {{min_, min_ + delta_abs * (count_ - 1)},
							   {min_, min_ + delta_abs * (count_ - 1)}},
				updatable 	= true, 
				use_OBB 	= true,
				cycle     	= false, 
				class_vr	= {class_type.MULTY_TUMB, class_type.MULTY_TUMB},
				side		= {{0},{BOX_SIDE_X_top, BOX_SIDE_X_bottom, BOX_SIDE_Z_top, BOX_SIDE_Z_bottom}},
				attach_left	= attach_left_,
				attach_right= attach_right_,
				sound		= {{SOUND_SW2}}
			}
			
	if animation_speed_ ~= nil then
		element.animated        = {true, true}
		element.animation_speed = {animation_speed_, animation_speed_}
	end
	
	return element
end

function multiposition_switch_limited_1_side(hint_,device_,command_,arg_,count_,delta_,min_,animation_speed_,attach_left_,attach_right_)
	local	element		= multiposition_switch_limited(hint_,device_,command_,arg_,count_,delta_,min_,animation_speed_,attach_left_,attach_right_)
	element.side = {{BOX_SIDE_X_bottom}}
	return element
end

function multiposition_switch_tumb(hint_,device_,command_,arg_,count_,delta_,min_,cycled_,animation_speed_)
    local min_   = min_ or 0
	local delta  = 0.5
	local delta_abs = math.abs(delta_)
	local cycled_ = cycled_ or false
	
	local animation_speed_ = animation_speed_ or anim_speed_multipos_thumb
	
	return  {	
				class 			= {class_type.TUMB,class_type.TUMB},
				hint  			= hint_,
				device 			= device_,
				action 			= {command_,command_},
				arg 	  		= {arg_,arg_},
				arg_value 		= {-delta_,delta_}, 
				arg_lim   		= {{min_, min_ + delta_abs * (count_ -1)},
								{min_, min_ + delta_abs * (count_ -1)}},
				updatable 		= true, 
				use_OBB 		= true,
				cycle     		= cycled_, 
				animated        = {true, true},
				animation_speed = {animation_speed_, animation_speed_},
				side			= {{BOX_SIDE_Z_top},{BOX_SIDE_Z_bottom}},
				sound			= {{SOUND_SW2}}
			}
end


function intercom_rotate_tumb(hint_, device_, command_1, command_2, arg_1, arg_2, attach_left_, attach_right_)
return {
			class			= {class_type.TUMB, class_type.TUMB, class_type.LEV},
			hint			= hint_,
			device			= device_,
			action			= {command_1, command_1, command_2},
			arg				= {arg_1, arg_1, arg_2},
			arg_value		= {-1, 1, 1},
			arg_lim			= {{0, 1}, {0, 1}, {0,1}},
			relative		= {false, false, false},
			updatable 		= false, 
			use_OBB 		= false,
			gain 			= {1.0, 1.0, 0.1},
			cycle 			= false,
			class_vr		= {class_type.BTN_FIX, nil, nil},
			side			= {{BOX_SIDE_Y_bottom},{0},{BOX_SIDE_X_top, BOX_SIDE_X_bottom, BOX_SIDE_Z_top, BOX_SIDE_Z_bottom}},
			attach_left		= attach_left_,
			attach_right	= attach_right_,
			sound			= {{SOUND_SW4_OFF, SOUND_SW4_ON}, {SOUND_SW4_OFF, SOUND_SW4_ON}, {SOUND_SW6}}
	}
end

function default_button_axis(hint_, device_,command_1, command_2, arg_1, arg_2,attach_left_,attach_right_)
return {
			class		=	{class_type.BTN, class_type.LEV},
			hint		=	hint_,
			device		=	device_,
			action		=	{command_1, command_2},
			stop_action =   {command_1, 0},
			arg			=	{arg_1, arg_2},
			arg_value	= 	{1, 0.5},
			arg_lim		= 	{{0, 1}, {0,1}},
			animated        = {false,false},
			animation_speed = {0, 0.4},
			gain = {0, 0.1},
			relative	= 	{false, false},
			updatable 	= 	true, 
			use_OBB 	= 	true,
			use_release_message = {true, false},
			cycle = false,
			side		= {{BOX_SIDE_Y_bottom},{BOX_SIDE_X_top, BOX_SIDE_X_bottom, BOX_SIDE_Z_top, BOX_SIDE_Z_bottom}},
			attach_left	= attach_left_,
			attach_right= attach_right_,
			sound		= {{SOUND_SW4_ON, SOUND_SW4_OFF}, {SOUND_SW6}}
	}
end

-- TODO: to check animation, it doesn't work properly with the handling code
function electrically_held_switch(hint_, device_, command_on_, command_off_, arg_, animation_speed_)
	local animation_speed_ 		= animation_speed_ or anim_speed_default_2_pos_thumb
	
	return {class 		        = {class_type.BTN, class_type.BTN},
	        hint  		        = hint_,
	        device 		        = device_,
	        action 		        = {command_on_, command_on_},
			stop_action         = {command_off_, command_off_},
	        arg 	  	        = {arg_, arg_},
	        arg_value 	        = {1, 1},
			arg_lim   	        = {{0, 1}, {0, 1}},
	        updatable 	        = true,
	        use_release_message = {true},
			--animated        	= {true, true},
			animation_speed 	= {animation_speed_, animation_speed_},
			sound               = {{SOUND_SW3_OFF, SOUND_SW3}},
			side				= {{BOX_SIDE_Z_top, BOX_SIDE_Z_bottom}}
	       }
end

function default_button_tumb(hint_,device_,command1_,command2_,arg_,stop_val_,arg_value_,arg_lim_,animation_speed_)
	local	arg_value_		 = arg_value_ or {-1,1}
	local	arg_lim_		 = arg_lim_ or {{-1,0},{0,1}}
	
	local animation_speed_ 	 = animation_speed_ or anim_speed_default_3_pos_thumb
	
	return	{
				class				= {class_type.BTN,class_type.TUMB},
				hint				= hint_,
				device				= device_,
				action				= {command1_,command2_},
				stop_action			= {command1_,0},
				arg					= {arg_,arg_},
				arg_value			= arg_value_,
				arg_lim				= arg_lim_,
				stop_value			= stop_val_,
				updatable			= true,
				use_OBB				= true,
				use_release_message	= {true,false},
				animated        	= {true, true},
				animation_speed 	= {animation_speed_, animation_speed_},
				side				= {{BOX_SIDE_Z_top},{BOX_SIDE_Z_bottom}},
				sound 				= {{SOUND_SW3_OFF, SOUND_SW3}, {SOUND_SW3}}
			}
end								 

-- TODO: to add animation
function default_tumb_button(hint_,device_,command1_,command2_,arg_,stop_val_,arg_value_,arg_lim_)

	local	arg_value_		 = arg_value_ or {-1,1}
	local	arg_lim_		 = arg_lim_ or {{-1,0},{0,1}}
	
	return	{
				class				= {class_type.TUMB,class_type.BTN},
				hint				= hint_,
				device				= device_,
				action				= {command1_,command2_},
				stop_action			= {0,		 command2_},
				arg					= {arg_,arg_},
				arg_value			= arg_value_,
				stop_value			= stop_val_,
				arg_lim				= arg_lim_,
				updatable			= true,
				use_OBB				= true,
				use_release_message	= {false,true},
				side				= {{BOX_SIDE_Z_top},{BOX_SIDE_Z_bottom}},
				sound				= {{SOUND_SW1}, {SOUND_SW1, SOUND_SW1_OFF}}
			}
end

-- TODO: to add animation
function default_small_tumb_button(hint_,device_,command1_,command2_,arg_,stop_val_,arg_value_,arg_lim_)
	local element = default_tumb_button(hint_,device_,command1_,command2_,arg_,stop_val_,arg_value_,arg_lim_)
	element.sound = {{SOUND_SW3}, {SOUND_SW3_OFF, SOUND_SW3}}
	return element
end


-- A-10C
elements = {}

---------------------------------------------

MFCD_ADJ_Increase 	= device_commands.Button_21
MFCD_ADJ_Decrease 	= device_commands.Button_22
MFCD_ADJ_Stop 		= device_commands.Button_23

MFCD_DSP_Increase 	= device_commands.Button_24
MFCD_DSP_Decrease 	= device_commands.Button_25
MFCD_DSP_Stop 		= device_commands.Button_26

MFCD_BRT_Increase	= device_commands.Button_27
MFCD_BRT_Decrease 	= device_commands.Button_28
MFCD_BRT_Stop 		= device_commands.Button_29

MFCD_CON_Increase 	= device_commands.Button_30
MFCD_CON_Decrease 	= device_commands.Button_31
MFCD_CON_Stop 		= device_commands.Button_32

MFCD_SYM_Up			= device_commands.Button_33
MFCD_SYM_Dn			= device_commands.Button_34
MFCD_SYM_Stop		= device_commands.Button_35


-- Left MFCDI
elements["PNT-BTN-MFD-L-01"]		= default_button(_("OSB 1"),  devices.MFCD_LEFT, device_commands.Button_1,  300 )
elements["PNT-BTN-MFD-L-02"]		= default_button(_("OSB 2"),  devices.MFCD_LEFT, device_commands.Button_2,  301 )
elements["PNT-BTN-MFD-L-03"]		= default_button(_("OSB 3"),  devices.MFCD_LEFT, device_commands.Button_3,  302 )
elements["PNT-BTN-MFD-L-04"]		= default_button(_("OSB 4"),  devices.MFCD_LEFT, device_commands.Button_4,  303 )
elements["PNT-BTN-MFD-L-05"]		= default_button(_("OSB 5"),  devices.MFCD_LEFT, device_commands.Button_5,  304 )
elements["PNT-BTN-MFD-L-06"]		= default_button(_("OSB 6"),  devices.MFCD_LEFT, device_commands.Button_6,  305 )
elements["PNT-BTN-MFD-L-07"]		= default_button(_("OSB 7"),  devices.MFCD_LEFT, device_commands.Button_7,  306 )
elements["PNT-BTN-MFD-L-08"]		= default_button(_("OSB 8"),  devices.MFCD_LEFT, device_commands.Button_8,  307 )
elements["PNT-BTN-MFD-L-09"]		= default_button(_("OSB 9"),  devices.MFCD_LEFT, device_commands.Button_9,  308 )
elements["PNT-BTN-MFD-L-10"]		= default_button(_("OSB 10"), devices.MFCD_LEFT, device_commands.Button_10, 309 )
elements["PNT-BTN-MFD-L-11"]		= default_button(_("OSB 11"), devices.MFCD_LEFT, device_commands.Button_11, 310 )
elements["PNT-BTN-MFD-L-12"]		= default_button(_("OSB 12"), devices.MFCD_LEFT, device_commands.Button_12, 311 )
elements["PNT-BTN-MFD-L-13"]		= default_button(_("OSB 13"), devices.MFCD_LEFT, device_commands.Button_13, 312 )
elements["PNT-BTN-MFD-L-14"]		= default_button(_("OSB 14"), devices.MFCD_LEFT, device_commands.Button_14, 313 )
elements["PNT-BTN-MFD-L-15"]		= default_button(_("OSB 15"), devices.MFCD_LEFT, device_commands.Button_15, 314 )
elements["PNT-BTN-MFD-L-16"]		= default_button(_("OSB 16"), devices.MFCD_LEFT, device_commands.Button_16, 315 )
elements["PNT-BTN-MFD-L-17"]		= default_button(_("OSB 17"), devices.MFCD_LEFT, device_commands.Button_17, 316 )
elements["PNT-BTN-MFD-L-18"]		= default_button(_("OSB 18"), devices.MFCD_LEFT, device_commands.Button_18, 317 )
elements["PNT-BTN-MFD-L-19"]		= default_button(_("OSB 19"), devices.MFCD_LEFT, device_commands.Button_19, 318 )
elements["PNT-BTN-MFD-L-20"]		= default_button(_("OSB 20"), devices.MFCD_LEFT, device_commands.Button_20, 319 )
													 
elements["PNT-MFCD-L-ADJ-UP"]		= action_button(_("Moving Map Scale Adjust Increase"), devices.MFCD_LEFT, MFCD_ADJ_Increase, MFCD_ADJ_Stop, 320 )
elements["PNT-MFCD-L-ADJ-DN"]		= action_button(_("Moving Map Scale Adjust Decrease"), devices.MFCD_LEFT, MFCD_ADJ_Decrease, MFCD_ADJ_Stop, 320, -1, {-1.0, 0.0})
elements["PNT-MFCD-L-DSP-UP"]		= action_button(_("Increase Backlight Brightness"),    devices.MFCD_LEFT, MFCD_DSP_Increase, MFCD_DSP_Stop, 321                 )
elements["PNT-MFCD-L-DSP-DN"]		= action_button(_("Decrease Backlight Brightness"),    devices.MFCD_LEFT, MFCD_DSP_Decrease, MFCD_DSP_Stop, 321, -1, {-1.0, 0.0})
elements["PNT-MFD-L-BRT-UP"]		= action_button(_("Increase Brightness"), 			   devices.MFCD_LEFT, MFCD_BRT_Increase, MFCD_BRT_Stop, 322                 )
elements["PNT-MFD-L-BRT-DN"]		= action_button(_("Decrease Brightness"), 			   devices.MFCD_LEFT, MFCD_BRT_Decrease, MFCD_BRT_Stop, 322, -1, {-1.0, 0.0})
elements["PNT-MFD-L-CON-UP"]		= action_button(_("Increase Contrast"), 			   devices.MFCD_LEFT, MFCD_CON_Increase, MFCD_CON_Stop, 323                 )
elements["PNT-MFD-L-CON-DN"]		= action_button(_("Decrease Contrast"),				   devices.MFCD_LEFT, MFCD_CON_Decrease, MFCD_CON_Stop, 323, -1, {-1.0, 0.0})
elements["PNT-MFD-L-SYM-UP"]		= action_button(_("Increase Symbol Levels"), 		   devices.MFCD_LEFT, MFCD_SYM_Up,		 MFCD_SYM_Stop, 324                 )
elements["PNT-MFD-L-SYM-DN"]		= action_button(_("Decrease Symbol Levels"), 		   devices.MFCD_LEFT, MFCD_SYM_Dn,		 MFCD_SYM_Stop, 324, -1, {-1.0, 0.0})

elements["PNT-LVR-MFD-L"]			= multiposition_switch_tumb(_("DAY/NIGHT/OFF"), devices.MFCD_LEFT, device_commands.Button_36, 325, 3, -0.1)


---------------------------------------------
-- Right MFCDI
elements["PNT-BTN-MFD-R-01"]		= default_button(_("OSB 1"),  devices.MFCD_RIGHT, device_commands.Button_1,  326)
elements["PNT-BTN-MFD-R-02"]		= default_button(_("OSB 2"),  devices.MFCD_RIGHT, device_commands.Button_2,  327)
elements["PNT-BTN-MFD-R-03"]		= default_button(_("OSB 3"),  devices.MFCD_RIGHT, device_commands.Button_3,  328)
elements["PNT-BTN-MFD-R-04"]		= default_button(_("OSB 4"),  devices.MFCD_RIGHT, device_commands.Button_4,  329)
elements["PNT-BTN-MFD-R-05"]		= default_button(_("OSB 5"),  devices.MFCD_RIGHT, device_commands.Button_5,  330)
elements["PNT-BTN-MFD-R-06"]		= default_button(_("OSB 6"),  devices.MFCD_RIGHT, device_commands.Button_6,  331)
elements["PNT-BTN-MFD-R-07"]		= default_button(_("OSB 7"),  devices.MFCD_RIGHT, device_commands.Button_7,  332)
elements["PNT-BTN-MFD-R-08"]		= default_button(_("OSB 8"),  devices.MFCD_RIGHT, device_commands.Button_8,  333)
elements["PNT-BTN-MFD-R-09"]		= default_button(_("OSB 9"),  devices.MFCD_RIGHT, device_commands.Button_9,  334)
elements["PNT-BTN-MFD-R-10"]		= default_button(_("OSB 10"), devices.MFCD_RIGHT, device_commands.Button_10, 335)
elements["PNT-BTN-MFD-R-11"]		= default_button(_("OSB 11"), devices.MFCD_RIGHT, device_commands.Button_11, 336)
elements["PNT-BTN-MFD-R-12"]		= default_button(_("OSB 12"), devices.MFCD_RIGHT, device_commands.Button_12, 337)
elements["PNT-BTN-MFD-R-13"]		= default_button(_("OSB 13"), devices.MFCD_RIGHT, device_commands.Button_13, 338)
elements["PNT-BTN-MFD-R-14"]		= default_button(_("OSB 14"), devices.MFCD_RIGHT, device_commands.Button_14, 339)
elements["PNT-BTN-MFD-R-15"]		= default_button(_("OSB 15"), devices.MFCD_RIGHT, device_commands.Button_15, 340)
elements["PNT-BTN-MFD-R-16"]		= default_button(_("OSB 16"), devices.MFCD_RIGHT, device_commands.Button_16, 341)
elements["PNT-BTN-MFD-R-17"]		= default_button(_("OSB 17"), devices.MFCD_RIGHT, device_commands.Button_17, 342)
elements["PNT-BTN-MFD-R-18"]		= default_button(_("OSB 18"), devices.MFCD_RIGHT, device_commands.Button_18, 343)
elements["PNT-BTN-MFD-R-19"]		= default_button(_("OSB 19"), devices.MFCD_RIGHT, device_commands.Button_19, 344)
elements["PNT-BTN-MFD-R-20"]		= default_button(_("OSB 20"), devices.MFCD_RIGHT, device_commands.Button_20, 345)

elements["PNT-MFCD-R-ADJ-UP"]		= action_button(_("Moving Map Scale Adjust Increase"), devices.MFCD_RIGHT, MFCD_ADJ_Increase, MFCD_ADJ_Stop, 346)
elements["PNT-MFCD-R-ADJ-DN"]		= action_button(_("Moving Map Scale Adjust Decrease"), devices.MFCD_RIGHT, MFCD_ADJ_Decrease, MFCD_ADJ_Stop, 346, -1, {-1.0, 0.0})
elements["PNT-MFCD-R-DSP-UP"]		= action_button(_("Increase Backlight Brightness"),    devices.MFCD_RIGHT, MFCD_DSP_Increase, MFCD_DSP_Stop, 347)                
elements["PNT-MFCD-R-DSP-DN"]		= action_button(_("Decrease Backlight Brightness"),    devices.MFCD_RIGHT, MFCD_DSP_Decrease, MFCD_DSP_Stop, 347, -1, {-1.0, 0.0})
elements["PNT-MFD-R-BRT-UP"]		= action_button(_("Increase Brightness"), 			   devices.MFCD_RIGHT, MFCD_BRT_Increase, MFCD_BRT_Stop, 348)                
elements["PNT-MFD-R-BRT-DN"]		= action_button(_("Decrease Brightness"), 			   devices.MFCD_RIGHT, MFCD_BRT_Decrease, MFCD_BRT_Stop, 348, -1, {-1.0, 0.0})
elements["PNT-MFD-R-CON-UP"]		= action_button(_("Increase Contrast"), 			   devices.MFCD_RIGHT, MFCD_CON_Increase, MFCD_CON_Stop, 349)                
elements["PNT-MFD-R-CON-DN"]		= action_button(_("Decrease Contrast"), 			   devices.MFCD_RIGHT, MFCD_CON_Decrease, MFCD_CON_Stop, 349, -1, {-1.0, 0.0})
elements["PNT-MFD-R-SYM-UP"]		= action_button(_("Increase Symbol Levels"), 		   devices.MFCD_RIGHT, MFCD_SYM_Up, 	  MFCD_SYM_Stop, 350)                
elements["PNT-MFD-R-SYM-DN"]		= action_button(_("Decrease Symbol Levels"), 		   devices.MFCD_RIGHT, MFCD_SYM_Dn, 	  MFCD_SYM_Stop, 350, -1, {-1.0, 0.0})

elements["PNT-LVR-MFD-R"]			= multiposition_switch_tumb(_("DAY/NIGHT/OFF"), devices.MFCD_RIGHT, device_commands.Button_36, 351, 3, -0.1)

---------------------------------------------
-- CMSP
elements["PNT-BTN-CMSP-ARW1"]			= default_button(_("Edit Program Value"), 			devices.CMSP, device_commands.Button_1, 352, nil, nil, false)
elements["PNT-BTN-CMSP-ARW2"]			= default_button(_("Edit Program Value"), 			devices.CMSP, device_commands.Button_2, 353, nil, nil, false)
elements["PNT-BTN-CMSP-ARW3"]			= default_button(_("Edit Program Value"), 			devices.CMSP, device_commands.Button_3, 354, nil, nil, false)
elements["PNT-BTN-CMSP-ARW4"]			= default_button(_("Edit Program Value"), 			devices.CMSP, device_commands.Button_4, 355, nil, nil, false)
elements["PNT-BTN-CMSP-BRT-UP"]			= default_button(_("Cycle Program or Value Up"), 	devices.CMSP, device_commands.Button_5, 356, nil, nil, false)
elements["PNT-BTN-CMSP-BRT-DN"]			= default_button(_("Cycle Program or Value Down"), 	devices.CMSP, device_commands.Button_6, 356, -1, {-1.0, 0.0}, false)
elements["PNT-BTN-CMSP-RTN"]			= default_button(_("Save and Return Program"), 		devices.CMSP, device_commands.Button_7, 357, nil, nil, false)

elements["PNT-TMB-CMSP-JTSN"]			= default_2_position_tumb(_("Jettison Countermeasures"), devices.CMSP, device_commands.Button_8, 358)

elements["PNT-LEV-CMSP-BRT"]			= default_axis_limited(_("Adjust Display Brightness"), devices.CMSP, device_commands.Button_9, 359, 0.1, false, false, {0.15, 0.85}, nil, nil, {90,-45})

elements["PNT-TMB-CMSP-MWS"]  			= default_tumb_button(_("Missile Warning System (MWS). Left mouse - ON/OFF, Right mouse - MENU (No Function)"), 		  devices.CMSP, device_commands.Button_10, device_commands.Button_11, 360, {nil,0.1}, {-0.1, 0.2}, {{0, 0.1}, {0.1, 0.2}} )
elements["PNT-TMB-CMSP-JMR"]  			= default_tumb_button(_("Electronic Countermeasure Jammer (JMR). Left mouse - ON/OFF, Right mouse - MENU (No Function)"), devices.CMSP, device_commands.Button_12, device_commands.Button_13, 361, {nil,0.1}, {-0.1, 0.2}, {{0, 0.1}, {0.1, 0.2}} )
elements["PNT-TMB-CMSP-RWR"]  			= default_tumb_button(_("Radar Warning Receiver (RWR). Left mouse - ON/OFF, Right mouse - MENU"), 						  devices.CMSP, device_commands.Button_14, device_commands.Button_15, 362, {nil,0.1}, {-0.1, 0.2}, {{0, 0.1}, {0.1, 0.2}} )
elements["PNT-TMB-CMSP-DISP"]  			= default_tumb_button(_("Countermeasure Dispenser (DISP). Left mouse - ON/OFF, Right mouse - MENU"),					  devices.CMSP, device_commands.Button_16, device_commands.Button_17, 363, {nil,0.1}, {-0.1, 0.2}, {{0, 0.1}, {0.1, 0.2}} )

elements["PNT-LEV-CMSP-MODE"]			= multiposition_switch_limited(_("Master CMS Mode Select"), devices.CMSP, device_commands.Button_18, 364, 5, 0.1, nil, anim_speed_multipos_thumb, nil, {90,-45})


---------------------------------------------
-- CMSC
elements["PNT-BTN-RWR-JMR"]			= default_button(_("Select Jammer Program"), 							  devices.CMSC, device_commands.Button_1, 365, nil, nil, false)
elements["PNT-BTN-RWR-MWS"]			= default_button(_("Cycle Missile Warning System Programs. No function"), devices.CMSC, device_commands.Button_2, 366, nil, nil, false)
elements["PNT-BTN-RWR-PRI"]			= default_button(_("Toggle between 5 and 16 Priority Threats Displayed"), devices.CMSC, device_commands.Button_3, 369, nil, nil, false)
elements["PNT-BTN-RWR-SEP"]			= default_button(_("Separate RWR Symbols"), 							  devices.CMSC, device_commands.Button_4, 370, nil, nil, false)
elements["PNT-BTN-RWR-UNK"]			= default_button(_("Display Unknown Threats"), 							  devices.CMSC, device_commands.Button_5, 371, nil, nil, false)
elements["PNT-LEV-RWR-BRT"]			= default_axis_limited(_("Adjust Display Brightness"), devices.CMSC, device_commands.Button_6, 367, 0.1, false, false, {0.15, 0.85},nil,{135,-45},{45,-45})
elements["PNT-LEV-RWR-AUD"]			= default_axis_limited(_("Adjust RWR Volume"),		   devices.CMSC, device_commands.Button_7, 368, 0.1, false, false, {0.0, 1.0},nil,{135,-45},{45,-45})
--elements["EW-LGT-R1"]				= {class = {class_type.BTN}, hint = _("Missile Launch Alert. No function"), device = devices.CMSC, action = {device_commands.Button_8}, stop_action = {device_commands.Button_8}, arg = {0}, arg_value = {0.0}, arg_lim = {{0.0, 0.0}}, use_release_message = {false} }

---------------------------------------------
-- AHCP
elements["PNT-TMB-AHCP-MARM"]		= default_3_position_tumb(_("Master Arm"), 					devices.AHCP, device_commands.Button_1,  375, false, false, {-0.1,0.1}, {{0.0, 0.2},{0.0, 0.2}}, 2)
elements["PNT-TMB-AHCP-GUNPAC"]		= default_3_position_tumb(_("Gun Arm Mode"), 				devices.AHCP, device_commands.Button_2,  376, false, false, {-0.1,0.1}, {{0.0, 0.2},{0.0, 0.2}}, 2)
elements["PNT-TMB-AHCP-LARM"]		= default_3_position_tumb(_("Laser Arm"), 					devices.AHCP, device_commands.Button_3,  377, false, false, {-0.1,0.1}, {{0.0, 0.2},{0.0, 0.2}}, 2)
elements["PNT-TMB-AHCP-TGP"]		= default_2_position_tumb(_("Targeting Pod Power On/Off"),  devices.AHCP, device_commands.Button_4,  378)
elements["PNT-TMB-AHCP-ALT"]		= default_3_position_small_tumb(_("Altimeter Source"), 			devices.AHCP, device_commands.Button_5,  379, false, false, {-0.1,0.1}, {{0.0, 0.2},{0.0, 0.2}}, 2)
elements["PNT-TMB-AHCP-TIME"]		= default_2_position_small_tumb(_("Day/Night HUD Mode"), 			devices.AHCP, device_commands.Button_6,  380)
elements["PNT-TMB-AHCP-NORM"]		= default_2_position_small_tumb(_("NORM/Standby HUD Mode"), 		devices.AHCP, device_commands.Button_7,  381)
elements["PNT-TMB-AHCP-CICU"]		= default_2_position_tumb(_("Turn On/Off CICU"), 			devices.AHCP, device_commands.Button_8,  382)
elements["PNT-TMB-AHCP-JTRS"]		= default_2_position_tumb(_("JTRS Datalink On/Off)"), 		devices.AHCP, device_commands.Button_9,  383)
elements["PNT-TMB-AHCP-IFFCC"]		= default_3_position_tumb(_("Turn On/Off/Test IFFCC"), 		devices.AHCP, device_commands.Button_10, 384, false, false, {-0.1,0.1}, {{0.0, 0.2},{0.0, 0.2}}, 2)

-------------------------------------------
-- UFC

DATA_ToolTip = _("1. Change Menu/Display Data 2. Cycle between DTS and Hot Elevation (N/A) 3. Change HACK Time Interval 4. FUNC Mode: Alternate CDU PG rocker")
SEL_ToolTip  = _("1. HUD TEST: Navigate Menus 2. GUNS: Change Gun Reticle 3. CCIP/CCRP: Change Weapon Profile 4. AIR-to-AIR: Change Air Threat 5. FUNC Mode: Alternate CDU + Rocker")

elements["PNT-BTN-UFC-1"]			= default_button("", devices.UFC, device_commands.Button_1,  385 )
elements["PNT-BTN-UFC-2"]			= default_button("", devices.UFC, device_commands.Button_2,  386 )
elements["PNT-BTN-UFC-3"]			= default_button("", devices.UFC, device_commands.Button_3,  387 )
elements["PNT-BTN-UFC-4"]			= default_button("", devices.UFC, device_commands.Button_4,  388 )
elements["PNT-BTN-UFC-5"]			= default_button("", devices.UFC, device_commands.Button_5,  389 )
elements["PNT-BTN-UFC-6"]			= default_button("", devices.UFC, device_commands.Button_6,  390 )
elements["PNT-BTN-UFC-7"]			= default_button("", devices.UFC, device_commands.Button_7,  391 )
elements["PNT-BTN-UFC-8"]			= default_button("", devices.UFC, device_commands.Button_8,  392 )
elements["PNT-BTN-UFC-9"]			= default_button("", devices.UFC, device_commands.Button_9,  393 )
elements["PNT-BTN-UFC-0"]			= default_button("", devices.UFC, device_commands.Button_10, 395 )

elements["PNT-BTN-UFC-SPC"]			= default_button(_("Space"), 									devices.UFC, device_commands.Button_11, 396 )
elements["PNT-BTN-UFC-HACK"]		= default_button(_("Display Hack Time"), 						devices.UFC, device_commands.Button_12, 394, nil, nil, false )
elements["PNT-BTN-UFC-FUNC"]		= default_button(_("Select Function Mode"), 					devices.UFC, device_commands.Button_13, 397, nil, nil, false )
elements["PNT-BTN-UFC-LTR"]			= default_button(_("Select Letter Mode"), 						devices.UFC, device_commands.Button_14, 398, nil, nil, false )
elements["PNT-BTN-UFC-CLR"]			= default_button(_("Clear"), 									devices.UFC, device_commands.Button_15, 399 )
elements["PNT-BTN-UFC-ENT"]			= default_button(_("Enter"),									devices.UFC, device_commands.Button_16, 400, nil, nil, false )
elements["PNT-BTN-UFC-MK"]			= default_button(_("Create Overhead Mark Point"), 				devices.UFC, device_commands.Button_17, 401, nil, nil, false )
elements["PNT-BTN-UFC-ALT"]			= default_button(_("Display and Adjust Altitude Alert Values"), devices.UFC, device_commands.Button_18, 402 )
elements["PNT-BTN-UFC-STEER-UP"]	= default_button(_("Cycle Steerpoint/Waypoint"), 				devices.UFC, device_commands.Button_20, 405, nil, nil, false )
elements["PNT-BTN-UFC-STEER-DN"]	= default_button(( "Cycle Steerpoint/Waypoint"), 				devices.UFC, device_commands.Button_21, 405, -1, {-1.0, 0.0}, false )
elements["PNT-BTN-UFC-DATA-UP"]		= default_button(DATA_ToolTip, 									devices.UFC, device_commands.Button_22, 406 )
elements["PNT-BTN-UFC-DATA-DN"]		= default_button(DATA_ToolTip, 									devices.UFC, device_commands.Button_23, 406, -1, {-1.0, 0.0} )
elements["PNT-BTN-UFC-SEL-UP"]		= default_button(SEL_ToolTip,  									devices.UFC, device_commands.Button_24, 407 )
elements["PNT-BTN-UFC-SEL-DN"]		= default_button(SEL_ToolTip,  									devices.UFC, device_commands.Button_25, 407, -1, {-1.0, 0.0} )
elements["PNT-BTN-UFC-DEPR-UP"]		= default_button(_("Adjust Depressible Pipper"), 				devices.UFC, device_commands.Button_26, 408 )
elements["PNT-BTN-UFC-DEPR-DN"]		= default_button(_("Adjust Depressible Pipper"), 				devices.UFC, device_commands.Button_27, 408, -1, {-1.0, 0.0} )
elements["PNT-BTN-UFC-INTEN-RGT"]	= default_button(_("Adjust HUD Brightness (Hold rocker)"), 		devices.UFC, device_commands.Button_28, 409 )
elements["PNT-BTN-UFC-INTEN-LFT"]	= default_button(_("Adjust HUD Brightness (Hold rocker)"), 		devices.UFC, device_commands.Button_29, 409, -1, {-1.0, 0.0} )
elements["PNT-BTN-UFC-FWD"]			= default_button(_("Control VHF AM Radio"), 					devices.UFC, device_commands.Button_30, 531, -1, {-1.0, 0.0} )
elements["PNT-BTN-UFC-MID"]			= default_button(_("No function"), 				devices.UFC, device_commands.Button_31, 532, -1, {-1.0, 0.0} )
elements["PNT-BTN-UFC-AFT"]			= default_button(_("No Function"), 								devices.UFC, device_commands.Button_32, 533, nil, nil, false )
elements["PNT-BTN-UFC-ADD-4"]		= default_button(_("Toggle ARC-210 RT2 Status (long press)"), 								devices.UFC, device_commands.Button_33, 534, -1, {-1.0, 0.0})
elements["PNT-BTN-UFC-ADD-5"]		= default_button(_("No Function"), 								devices.UFC, device_commands.Button_34, 535, nil, nil, false )
elements["PNT-BTN-UFC-ADD-6"]		= default_button(_("No Function"), 								devices.UFC, device_commands.Button_35, 536, nil, nil, false )

---------------------------------------------
-- SYS_CONTROLLER
elements["PNT-BTN-UFC-MASTWARN"]	= default_button(_("Master Caution Light"),				devices.SYS_CONTROLLER, device_commands.Button_1, 403, nil, nil, false )
elements["PTR-LG-WRN-SILENCE"]		= default_button(_("Landing Gear Horn Silence Button"), devices.SYS_CONTROLLER, device_commands.Button_3, 127)
---------------------------------------------
-- CDU
elements["PNT-BTN-CDU-ARW-L1"]		= default_button(_("LSK 3L"), devices.CDU, device_commands.Button_1, 410, nil, nil, false )
elements["PNT-BTN-CDU-ARW-L2"]		= default_button(_("LSK 5L"), devices.CDU, device_commands.Button_2, 411, nil, nil, false )
elements["PNT-BTN-CDU-ARW-L3"]		= default_button(_("LSK 7L"), devices.CDU, device_commands.Button_3, 412, nil, nil, false )
elements["PNT-BTN-CDU-ARW-L4"]		= default_button(_("LSK 9L"), devices.CDU, device_commands.Button_4, 413, nil, nil, false )
elements["PNT-BTN-CDU-ARW-R1"]		= default_button(_("LSK 3R"), devices.CDU, device_commands.Button_5, 414, nil, nil, false )
elements["PNT-BTN-CDU-ARW-R2"]		= default_button(_("LSK 5R"), devices.CDU, device_commands.Button_6, 415, nil, nil, false )
elements["PNT-BTN-CDU-ARW-R3"]		= default_button(_("LSK 7R"), devices.CDU, device_commands.Button_7, 416, nil, nil, false )
elements["PNT-BTN-CDU-ARW-R4"]		= default_button(_("LSK 9R"), devices.CDU, device_commands.Button_8, 417, nil, nil, false )

elements["PNT-BTN-CDU-SYS"]			= default_button(_("Display System (SYS) Page"), 				devices.CDU, device_commands.Button_9,  418, nil, nil, false )
elements["PNT-BTN-CDU-NAV"]			= default_button(_("Display Navigation (NAV) Page"), 			devices.CDU, device_commands.Button_10, 419, nil, nil, false )
elements["PNT-BTN-CDU-WP"]			= default_button(_("Display Waypoint Menu (WP MENU) Page"), 	devices.CDU, device_commands.Button_11, 420, nil, nil, false )
elements["PNT-BTN-CDU-OSET"]		= default_button(_("Display Offset (OFFSET) Page"), 			devices.CDU, device_commands.Button_12, 421, nil, nil, false )
elements["PNT-BTN-CDU-FPM"]			= default_button(_("Display Flight Plan Menu (FPMENU) Page"), 	devices.CDU, device_commands.Button_13, 422, nil, nil, false )
elements["PNT-BTN-CDU-PREV"]		= default_button(_("Go to previous page"), 						devices.CDU, device_commands.Button_14, 423, nil, nil, false )

elements["PNT-BTN-CDU-1"]			= default_button("", devices.CDU, device_commands.Button_15, 425 )
elements["PNT-BTN-CDU-2"]			= default_button("", devices.CDU, device_commands.Button_16, 426 )
elements["PNT-BTN-CDU-3"]			= default_button("", devices.CDU, device_commands.Button_17, 427 )
elements["PNT-BTN-CDU-4"]			= default_button("", devices.CDU, device_commands.Button_18, 428 )
elements["PNT-BTN-CDU-5"]			= default_button("", devices.CDU, device_commands.Button_19, 429 )
elements["PNT-BTN-CDU-6"]			= default_button("", devices.CDU, device_commands.Button_20, 430 )
elements["PNT-BTN-CDU-7"]			= default_button("", devices.CDU, device_commands.Button_21, 431 )
elements["PNT-BTN-CDU-8"]			= default_button("", devices.CDU, device_commands.Button_22, 432 )
elements["PNT-BTN-CDU-9"]			= default_button("", devices.CDU, device_commands.Button_23, 433 )
elements["PNT-BTN-CDU-0"]			= default_button("", devices.CDU, device_commands.Button_24, 434 )
elements["PNT-BTN-CDU-PNT"]			= default_button("", devices.CDU, device_commands.Button_25, 435 )
elements["PNT-BTN-CDU-SLASH"]		= default_button("", devices.CDU, device_commands.Button_26, 436 )
elements["PNT-BTN-CDU-A"]			= default_button("", devices.CDU, device_commands.Button_27, 437 )
elements["PNT-BTN-CDU-B"]			= default_button("", devices.CDU, device_commands.Button_28, 438 )
elements["PNT-BTN-CDU-C"]			= default_button("", devices.CDU, device_commands.Button_29, 439 )
elements["PNT-BTN-CDU-D"]			= default_button("", devices.CDU, device_commands.Button_30, 440 )
elements["PNT-BTN-CDU-E"]			= default_button("", devices.CDU, device_commands.Button_31, 441 )
elements["PNT-BTN-CDU-F"]			= default_button("", devices.CDU, device_commands.Button_32, 442 )
elements["PNT-BTN-CDU-G"]			= default_button("", devices.CDU, device_commands.Button_33, 443 )
elements["PNT-BTN-CDU-H"]			= default_button("", devices.CDU, device_commands.Button_34, 444 )
elements["PNT-BTN-CDU-I"]			= default_button("", devices.CDU, device_commands.Button_35, 445 )
elements["PNT-BTN-CDU-J"]			= default_button("", devices.CDU, device_commands.Button_36, 446 )
elements["PNT-BTN-CDU-K"]			= default_button("", devices.CDU, device_commands.Button_37, 447 )
elements["PNT-BTN-CDU-L"]			= default_button("", devices.CDU, device_commands.Button_38, 448 )
elements["PNT-BTN-CDU-M"]			= default_button("", devices.CDU, device_commands.Button_39, 449 )
elements["PNT-BTN-CDU-N"]			= default_button("", devices.CDU, device_commands.Button_40, 450 )
elements["PNT-BTN-CDU-O"]			= default_button("", devices.CDU, device_commands.Button_41, 451 )
elements["PNT-BTN-CDU-P"]			= default_button("", devices.CDU, device_commands.Button_42, 452 )
elements["PNT-BTN-CDU-Q"]			= default_button("", devices.CDU, device_commands.Button_43, 453 )
elements["PNT-BTN-CDU-R"]			= default_button("", devices.CDU, device_commands.Button_44, 454 )
elements["PNT-BTN-CDU-S"]			= default_button("", devices.CDU, device_commands.Button_45, 455 )
elements["PNT-BTN-CDU-T"]			= default_button("", devices.CDU, device_commands.Button_46, 456 )
elements["PNT-BTN-CDU-U"]			= default_button("", devices.CDU, device_commands.Button_47, 457 )
elements["PNT-BTN-CDU-V"]			= default_button("", devices.CDU, device_commands.Button_48, 458 )
elements["PNT-BTN-CDU-W"]			= default_button("", devices.CDU, device_commands.Button_49, 459 )
elements["PNT-BTN-CDU-X"]			= default_button("", devices.CDU, device_commands.Button_50, 460 )
elements["PNT-BTN-CDU-Y"]			= default_button("", devices.CDU, device_commands.Button_51, 461 )
elements["PNT-BTN-CDU-Z"]			= default_button("", devices.CDU, device_commands.Button_52, 462 )

elements["PNT-BTN-CDU-V1"]			= default_button(_("No function"), 										  devices.CDU, device_commands.Button_53, 464, nil, nil, false )
elements["PNT-BTN-CDU-V2"]			= default_button(_("No function"), 										  devices.CDU, device_commands.Button_54, 465, nil, nil, false )
elements["PNT-BTN-CDU-MK"]			= default_button(_("Create Overhead Mark Point"), 						  devices.CDU, device_commands.Button_55, 466, nil, nil, false )
elements["PNT-BTN-CDU-BCK"]			= default_button(_("Erase Single Character. Hold for repeated erase"),	  devices.CDU, device_commands.Button_56, 467 )
elements["PNT-BTN-CDU-SPC"]			= default_button(_("Insert Space Into Scratchpad"),						  devices.CDU, device_commands.Button_57, 468 )
elements["PNT-BTN-CDU-CLR"]			= default_button(_("Erase Entire Scratchpad"),							  devices.CDU, device_commands.Button_58, 470, nil, nil, false )
elements["PNT-BTN-CDU-FA"]			= default_button(_("Fault Acknowledge/Clear Fault Display"),			  devices.CDU, device_commands.Button_59, 471, nil, nil, false )
elements["PNT-BTN-CDU-DIMBRT-L"]	= default_button(_("Decrease Display Brightness"),	  					  devices.CDU, device_commands.Button_60, 424, -1, {-1.0, 0.0}, false )
elements["PNT-BTN-CDU-DIMBRT-R"]	= default_button(_("Increase Display Brightness"),	  				      devices.CDU, device_commands.Button_61, 424, nil, nil, false )
elements["PNT-BTN-CDU-PG-UP"]		= default_button(_("Page Up To Additional Pages When Available"),		  devices.CDU, device_commands.Button_62, 463, nil, nil, false )
elements["PNT-BTN-CDU-PG-DN"]		= default_button(_("Page Down To Additional Pages When Available"),		  devices.CDU, device_commands.Button_63, 463, -1, {-1.0, 0.0}, false )
elements["PNT-BTN-CDU-BLANC-L"]		= default_button(_("Scroll Waypoint Names During Search"),				  devices.CDU, device_commands.Button_64, 469, -1, {-1.0, 0.0}, false )
elements["PNT-BTN-CDU-BLANC-R"]		= default_button(_("Scroll Waypoint Names During Search"),				  devices.CDU, device_commands.Button_65, 469, nil, nil, false )
elements["PNT-BTN-CDU-PLUS"]		= default_button(_("Increment/Decrement Data Indicated With +/- Symbol"), devices.CDU, device_commands.Button_66, 472, nil, nil, false )
elements["PNT-BTN-CDU-MINUS"]		= default_button(_("Increment/Decrement Data Indicated With +/- Symbol"), devices.CDU, device_commands.Button_67, 472, -1, {-1.0, 0.0}, false )

---------------------------------------------
-- AAP

elements["PNT-TMB-STEER-SPRING-LD-SWITCH"]	= springloaded_3_pos_tumb(		_("Toggle Steerpoint"), 					 devices.AAP, device_commands.Button_3, device_commands.Button_2, 474 )
elements["PNT-LVR-STEER-PT-SEL-SWITCH"]		= multiposition_switch_limited( _("Use Steerpoint From Active Flight Plan"), devices.AAP, device_commands.Button_1, 473, 3, 0.1, nil, anim_speed_multipos_thumb, {120, -135}, {60,-45} )
elements["PNT-LEV-PAGE-SEL-SWITCH"]			= multiposition_switch_limited( _("CDU Page Select"), 						 devices.AAP, device_commands.Button_4, 475, 4, 0.1, nil, anim_speed_multipos_thumb, {90, -135}, {90,-45} )
elements["PTR-TMB-CDU-SWITCH"]				= default_2_position_tumb(		_("CDU Power On/Off"), 						 devices.AAP, device_commands.Button_5, 476 )
elements["PTR-TMB-EGI-SWITCH"]				= default_2_position_tumb(		_("EGI Power On/Off"), 						 devices.AAP, device_commands.Button_6, 477 )

---------------------------------------------
-- Digital Clock
elements["PNT-LVR-WATCH-SET"]		= default_button(_("Toggle Clock and Elapsed Time Modes"), devices.DIGITAL_CLOCK, device_commands.Button_1, 68, nil, nil, true )
elements["PNT-LVR-WATCH-CTRL"]		= default_button(_("Start, Stop and Reset Elapsed Timer"), devices.DIGITAL_CLOCK, device_commands.Button_2, 69, nil, nil, true )

---------------------------------------------
-- Fuel System Control Panel
elements["PTR-FSCP-EXT-TANKS-WING"] 	= default_2_position_small_tumb(_("External Wing Tanks Boost Pumps"), 	   devices.FUEL_SYSTEM, device_commands.Button_1,  106 )
elements["PTR-FSCP-EXT-TANKS-FUS"]		= default_2_position_small_tumb(_("External Fuselage Tank Boost Pump"), 	   devices.FUEL_SYSTEM, device_commands.Button_2,  107 )
elements["PTR-FSCP-TK-GATE"]			= default_2_position_small_tumb(_("Tank Gate"), 							   devices.FUEL_SYSTEM, device_commands.Button_3,  108 )
elements["PTR-FSCP-CROSS-FEED"]			= default_2_position_small_tumb(_("Cross Feed"), 							   devices.FUEL_SYSTEM, device_commands.Button_4,  109 )
elements["PTR-FSCP-BOOST-PUMPS-WING-L"]	= default_2_position_small_tumb(_("Boost Pumps Left Wing"), 				   devices.FUEL_SYSTEM, device_commands.Button_5,  110 )
elements["PTR-FSCP-BOOST-PUMPS-WING-R"]	= default_2_position_small_tumb(_("Boost Pumps Right Wing"), 				   devices.FUEL_SYSTEM, device_commands.Button_6,  111 )
elements["PTR-FSCP-BOOST-PUMPS-MAIN-L"]	= default_2_position_small_tumb(_("Boost Pumps Main Fuselage Left"), 		   devices.FUEL_SYSTEM, device_commands.Button_7,  112 )
elements["PTR-FSCP-BOOST-PUMPS-MAIN-R"]	= default_2_position_small_tumb(_("Boost Pumps Main Fuselage Right"), 	   devices.FUEL_SYSTEM, device_commands.Button_8,  113 )
elements["PTR-FSCP-SIG-AMPL"]			= default_2_position_small_tumb(_("Signal Amplifier Norm/Override"), 		   devices.FUEL_SYSTEM, device_commands.Button_9,  114 )
elements["PTR-FSCP-LINE-CHECK"]			= default_button(		  _("Line Check"), 							   devices.FUEL_SYSTEM, device_commands.Button_10, 115 )
elements["PTR-FSCP-FILLDISABLE-WING-L"]	= push_button_tumb(		  _("Fill Disable Wing Left"),  			   devices.FUEL_SYSTEM, device_commands.Button_12, 117 )
elements["PTR-FSCP-FILLDISABLE-WING-R"]	= push_button_tumb(		  _("Fill Disable Wing Right"), 			   devices.FUEL_SYSTEM, device_commands.Button_13, 118 )
elements["PTR-FSCP-FILLDISABLE-MAIN-L"]	= push_button_tumb(		  _("Fill Disable Main Left"),  			   devices.FUEL_SYSTEM, device_commands.Button_14, 119 )
elements["PTR-FSCP-FILLDISABLE-MAIN-R"]	= push_button_tumb(		  _("Fill Disable Main Right"), 			   devices.FUEL_SYSTEM, device_commands.Button_15, 120 )
elements["PTR-FSCP-RCVR-LEVER"]			= default_animated_lever( _("Aerial Refueling Slipway Control Lever"), devices.FUEL_SYSTEM, device_commands.Button_16, 121 )

---------------------------------------------
--Fuel Quantity Indicator and Selector
elements["PTR-FQIS-SELECT"]			= multiposition_switch_limited(_("Fuel display selector"), devices.FUEL_SYSTEM, device_commands.Button_17, 645, 5, 0.1, nil, anim_speed_multipos_thumb, nil, {0, -90} )
elements["PTR-FQIS-TEST"]			= default_button(			   _("Fuel Gauge Test"),	   devices.FUEL_SYSTEM, device_commands.Button_18, 646 )


-----------------------------------------
-- Engine System and Throttle panel
elements["PTR-FUEL-FLOW-L"] 			= default_2_position_small_tumb(  _("Left Engine Fuel Flow Control"),  devices.ENGINE_SYSTEM, device_commands.Button_1, 122, nil, nil, false )
elements["PTR-FUEL-FLOW-R"]				= default_2_position_small_tumb(  _("Right Engine Fuel Flow Control"), devices.ENGINE_SYSTEM, device_commands.Button_2, 123, nil, nil, false )
elements["PTR-APU-START"]				= default_2_position_small_tumb(  _("APU On/Off"),					 devices.ENGINE_SYSTEM, device_commands.Button_5, 126, nil, nil, false )
elements["PTR-ENGINE-OPER-L"]			= default_tumb_button(_("Engine Operate Left"), 			 devices.ENGINE_SYSTEM, device_commands.Button_3 ,device_commands.Button_7, 124 )
elements["PTR-ENGINE-OPER-R"]			= default_tumb_button(_("Engine Operate Right"), 			 devices.ENGINE_SYSTEM, device_commands.Button_4 ,device_commands.Button_8, 125 )
elements["PTR-THROTTLE-FRICTION"]		= axis_limited_1_side(		_("Throttle Friction Control"),		 devices.ENGINE_SYSTEM, device_commands.Button_6, 128, 0.1, true)

elements["PTR-TEMS-DATA"]				= default_button(_("TEMS DATA"),devices.ENGINE_SYSTEM,device_commands.Button_9,652)

-------------------------------------------
-- LASTE Control Panel 
elements["PTR-LCP-AUTOPILOT-PATH-ALT"]	= default_3_position_tumb(	_("Autopilot Mode Select Switch"),    devices.AUTOPILOT,  device_commands.Button_1,  132)
elements["PTR-LCP-AUTOPILOT-ENGAGE"]	= default_button(			_("Autopilot Engage/Disengage"), 	  devices.AUTOPILOT,  device_commands.Button_2,  131, nil, nil, false )
elements["PTR-LCP-EAC"]                 = electrically_held_switch( _("EAC On/Off"), 					  devices.AUTOPILOT,  device_commands.Button_26, device_commands.Button_27, 129) 
elements["PTR-LCP-RDRALTM"]				= default_2_position_tumb(	_("Radar Altimeter Normal/Disabled"), devices.AN_APN_194, device_commands.Button_1,  130)


-------------------------------------------
--STABILITY AUGMENTATION SYSTEM PANEL
elements["PTR-SASP-YAW-SASENGAGE-L"]    = electrically_held_switch(_("Yaw SAS Engage left"), devices.AUTOPILOT, device_commands.Button_3, device_commands.Button_4, 185)
elements["PTR-SASP-YAW-SASENGAGE-R"]    = electrically_held_switch(_("Yaw SAS Engage right"), devices.AUTOPILOT, device_commands.Button_5, device_commands.Button_6, 186)
elements["PTR-SASP-PITCH-SASENGAGE-L"]  = electrically_held_switch(_("Pitch SAS Engage left"), devices.AUTOPILOT, device_commands.Button_7, device_commands.Button_8, 187)
elements["PTR-SASP-PITCH-SASENGAGE-R"]  = electrically_held_switch(_("Pitch SAS Engage right"), devices.AUTOPILOT, device_commands.Button_9, device_commands.Button_10, 188)
elements["PTR-SASP-MONITOR-TEST"]		= springloaded_3_pos_tumb(_("Monitor Test Left/Right"), devices.AUTOPILOT, device_commands.Button_11, device_commands.Button_33, 189 )
elements["PTR-SASP-TO-TRIM"]			= default_button(_("Set Takeoff Trim"), devices.AUTOPILOT, device_commands.Button_12, 190 )

elements["PTR-SASP-YAW-TRIM"]			= {
	class 				= {class_type.BTN, class_type.LEV}, 
	hint 				= _("Yaw Trim"),
	device 				= devices.AUTOPILOT, 
	action 				= {device_commands.Button_14, device_commands.Button_13}, 
	arg 				= {192, 192}, 
	arg_value 			= {0, 0.0}, 
	arg_lim 			= {{0, 0}, {-1, 1}}, 
	gain				= {0, 0.1}, 
	use_release_message = {true, false}, 
	cycle 				= false,
	side				= {{BOX_SIDE_Y_bottom},{BOX_SIDE_X_top, BOX_SIDE_X_bottom, BOX_SIDE_Z_top, BOX_SIDE_Z_bottom}},
	animated			= {true, false},
	animation_speed		= {10, 0},
	attach_left			= {-90, -135},
	attach_right		= {-70, -45},
	sound				= {{SOUND_SW6}, {SOUND_SW6}},
	}


-------------------------------------------
--Emergency Flight Control Panel						
elements["PTR-EFCP-SPDBK-EMER-RETR"]		 = default_2_position_tumb(_("Speed Brake Emergency Retract"), 			 devices.AUTOPILOT, device_commands.Button_15, 174 )
elements["PTR-EFCP-PTCHROLL-TRIM"]			 = default_2_position_small_tumb(_("Pitch/Roll Trim Norm/Emergency Override"), devices.AUTOPILOT, device_commands.Button_16, 175 )

elements["PTR-EFCP-TRIM-NOSEUP"]			 = action_button(_("Trim Emergency Nose Up"), 		  devices.AUTOPILOT, device_commands.Button_17, device_commands.Button_25, 176, 0.3, {0,0.3} )
elements["PTR-EFCP-TRIM-RWINGDN"]			 = action_button(_("Trim Emergency Right Wing Down"), devices.AUTOPILOT, device_commands.Button_18, device_commands.Button_25, 176, 0.2, {0,0.2} )
elements["PTR-EFCP-TRIM-NOSEDN"]			 = action_button(_("Trim Emergency Nose Down"), 	  devices.AUTOPILOT, device_commands.Button_19, device_commands.Button_25, 176, 0.1, {0,0.1} )
elements["PTR-EFCP-TRIM-LWINGDN"]			 = action_button(_("Trim Emergency Left Wing Down"),  devices.AUTOPILOT, device_commands.Button_20, device_commands.Button_25, 176, 0.4, {0,0.4} )

elements["PTR-EFCP-AILERON-EMER-DISENGAGE"]  = default_3_position_tumb(_("Aileron Emergency Disengage"),  devices.AUTOPILOT, device_commands.Button_21, 177)
elements["PTR-EFCP-ELEVATOR-EMER-DISENGAGE"] = default_3_position_tumb(_("Elevator Emergency Disengage"), devices.AUTOPILOT, device_commands.Button_22, 180)

elements["PTR-EFCP-FLAP-EMER-RETR"] 		 = default_2_position_tumb(_("Flaps Emergency Retract"),						devices.AUTOPILOT, device_commands.Button_23, 183 )
elements["PTR-EFCP-MRFCS"] 					 = default_2_position_tumb(_("Manual Reversion Flight Control System (MRFCS)"), devices.AUTOPILOT, device_commands.Button_24, 184 )

-------------------------------------------
--Electrical Power Panel
elements["PTR-EPP-APU-GEN-PWR"] = default_2_position_tumb(_("APU Generator On/Off"), 	 devices.ELEC_INTERFACE, device_commands.Button_1, 241 )
elements["PTR-EPP-INVERTER"] 	= default_button_tumb(	  _("Inverter Switch"), 		 devices.ELEC_INTERFACE, device_commands.Button_55, device_commands.Button_2, 242)
--elements["PTR-EPP-EMER-FLOOD"] 	= {class = {class_type.TUMB,class_type.TUMB}, hint  = _("Emergency Flood"), device = devices.ELEC_INTERFACE, action = {device_commands.Button_3, device_commands.Button_3}, arg = {243,243}, arg_value = {-1,1}, arg_lim = {{0,1},{0,1}},updatable = true}
elements["PTR-EPP-AC-GEN-PWR-L"]= default_2_position_small_tumb(_("Left AC Generator Power"),  devices.ELEC_INTERFACE, device_commands.Button_4, 244 )
elements["PTR-EPP-AC-GEN-PWR-R"]= default_2_position_small_tumb(_("Right AC generator Power"), devices.ELEC_INTERFACE, device_commands.Button_5, 245 )
elements["PTR-EPP-BATTERY-PWR"] = default_2_position_small_tumb(_("Battery Power"), 			 devices.ELEC_INTERFACE, device_commands.Button_6, 246 )
elements["PTR-EPP-EMER-FLOOD"] 	= default_2_position_tumb(_("Emergency Flood Light"), 	 devices.LIGHT_SYSTEM,   device_commands.Button_7, 243 )

-------------------------------------------
-- CPT MECH
elements["PNT-LNDGEAR"]				= default_2_position_tumb(_("Landing Gear Lever"), devices.CPT_MECH, device_commands.Button_1, 716, {1, -1} )
elements["PNT-LNDGEAR"].animated	= {false, false}
elements["PTR-DOWNLOCK-OVERRIDE"]	= default_button(_("Downlock Override"), devices.CPT_MECH, device_commands.Button_3, 651)
elements["PTR-FLAPS"]				= default_3_position_tumb(_("Flap Setting"), devices.CPT_MECH, device_commands.Button_2, 773, false, false, {0.5, -0.5}, {{0,1},{0,1}}, 12)

elements["PTR-ANTI-SKID"]           = electrically_held_switch(_("Anti Skid"), devices.AUTOPILOT, device_commands.Button_28, device_commands.Button_29, 654)
elements["PTR-ANTI-SKID"].sound		= {{SOUND_SW3_OFF, SOUND_SW3}}
								  
-------------------------------------------
-- Navigation Mode Select Panel
elements["PTR-NMSP-HARS"]		=  default_button(_("HARS Backup Navigation Mode")		,devices.NMSP,device_commands.Button_1,605)
elements["PTR-NMSP-EGI"]		=  default_button(_("EGI Navigation Mode")		,devices.NMSP,device_commands.Button_2,607)
elements["PTR-NMSP-TISL"]		=  default_button(_("TISL No Function")		,devices.NMSP,device_commands.Button_3,609)
elements["PTR-NMSP-STARTPT"]	=  default_button(_("STEERPT Mode")  ,devices.NMSP,device_commands.Button_4,611)
elements["PTR-NMSP-ANCHR"]		=  default_button(_("ANCHR Mode")	,devices.NMSP,device_commands.Button_5,613)
elements["PTR-NMSP-TCN"]		=  default_button(_("TCN Mode")		,devices.NMSP,device_commands.Button_6,615)
elements["PTR-NMSP-ILS"]		=  default_button(_("ILS Mode")		,devices.NMSP,device_commands.Button_7,617)
elements["PTR-NMSP-ABLE-STOW"]	=  default_2_position_small_tumb(_("ABLE-STOW ADI Localizer Bar"),devices.NMSP,device_commands.Button_8,621)

-----------------------------------------
-- Emergency Jettison Button
elements["PTR-EXT-STORES-JETT"]		= default_button(_("Emergency Jettison External Stores"),devices.IFFCC,device_commands.Button_1,101)

-----------------------------------------
-- ALCP
elements["PTR-ALCP-SIGLIGHTS-LAMP-TEST"] =  default_button(_("Test Cockpit Indication Lights"),devices.SYS_CONTROLLER,device_commands.Button_2,197)

-----------------------------------------
-- Armament Ground Safety Override Switch
elements["PTR-ARMGS-COVER"]	=  default_2_position_cover(_("Arm Ground Safety Override Cover"),devices.IFFCC,device_commands.Button_2,709)
elements["PTR-ARMGS-OVERRIDE-SWITCH"]	=  default_2_position_small_tumb(_("Arm Ground Safety Override Switch"),devices.IFFCC,device_commands.Button_3,710)

function default_springloaded_switch(hint_, device_, command1_, command2_, value1_, value2_, value3_, arg_, animation_speed_)
	local animation_speed_ 	 		= animation_speed_ or anim_speed_default_3_pos_thumb

	return	{
				class 				= {class_type.TUMB, class_type.BTN},
				hint 				= hint_, 
				device 				= device_,
				action  			= {command1_ ,	command2_}, 
				stop_action 		= {0 , 	command2_}, 
				arg 				= {arg_,		arg_},
				stop_value 			= {nil,			value2_},
				arg_value 			= {value1_, 	value3_},
				arg_lim 			= {{value1_, value2_}, {value2_, value3_}}, 
				use_release_message = {false, false},
				animated			= {true, true},
			    animation_speed		= {animation_speed_,animation_speed_},
				side				= {{BOX_SIDE_Z_top},{BOX_SIDE_Z_bottom}},
				sound				= {{SOUND_SW3}, {SOUND_SW3, SOUND_SW3_OFF}}
			}
end


function IFF_multiposition_spring_switch(hint_,device_,command1_, arg_)
	return  {	
				class 				= {class_type.BTN,class_type.BTN},
				hint  				= hint_,
				device 				= device_,
				action 				= {command1_ ,	command1_},
				stop_action 		= {command1_ , nil	},
				stop_value 			= {0.0,		   nil	},				
				arg 	  			= {arg_,arg_},
				arg_value 			= {-0.1,0.1}, 
				arg_lim   			= {{0, 0.3}, {0, 0.3}},
				--updatable 		= true, 
				use_release_message = {true,true},
				animated			= {true, true},
			    animation_speed		= {anim_speed_multipos_thumb, anim_speed_multipos_thumb},
				side				= {{BOX_SIDE_Z_top},{BOX_SIDE_Z_bottom}}
			}
end

-----------------------------------------
--IFF
elements["PTR-IFFCP-CODE"]				= IFF_multiposition_spring_switch(_("Code"), devices.IFF, device_commands.Button_7,199)
elements["PTR-IFFCP-CODE"].sound		= {{SOUND_SW2}}
elements["PTR-IFFCP-MASTER"]			= multiposition_switch(_("Master"), devices.IFF, device_commands.Button_8, 200, 5, 0.1, nil, anim_speed_multipos_thumb, {-70, -135}, {-110,-45})
elements["PTR-IFFCP-OUT-AUDIO-LIGHT"]	= default_3_position_small_tumb(_("Audio/light") ,devices.IFF,device_commands.Button_9,201)
elements["PTR-IFFCP-TEST-M-1"]			= default_springloaded_switch(_("Test M-1") ,devices.IFF,device_commands.Button_41,device_commands.Button_10,-1,0,1,202)
elements["PTR-IFFCP-TEST-M-2"]			= default_springloaded_switch(_("Test M-2") ,devices.IFF,device_commands.Button_42,device_commands.Button_11,-1,0,1,203)
elements["PTR-IFFCP-TEST-M-3A"]			= default_springloaded_switch(_("Test M-3A") ,devices.IFF,device_commands.Button_43,device_commands.Button_12,-1,0,1,204)
elements["PTR-IFFCP-TEST-M-C"]			= default_springloaded_switch(_("Test M-C") ,devices.IFF,device_commands.Button_44,device_commands.Button_13,-1,0,1,205)
elements["PTR-IFFCP-RADTEST"]			= default_springloaded_switch(_("RAD Test/Mon") ,devices.IFF,device_commands.Button_45,device_commands.Button_14,-1,0,1,206)
elements["PTR-IFFCP-MIC-IDENT"]			= default_springloaded_switch(_("Ident/Mic") ,devices.IFF,device_commands.Button_46,device_commands.Button_15,-1,0,1,207)
elements["PTR-IFFCP-MIC-IDENT"].sound	= {{SOUND_SW1}, {SOUND_SW1, SOUND_SW1_OFF}}
elements["PTR-IFFCP-ON-OUT"]			= default_2_position_tumb(_("IFF On/Out") ,devices.IFF,device_commands.Button_16,208)

-- TODO: correct cycled animation
elements["PTR-IFFCP-MODE1-WHEEL1"]		= multiposition_switch_1_side(_("MODE1-WHEEL1") ,devices.IFF,device_commands.Button_1,209,8,0.1, nil, nil, {135, 0}, {-135, 0})
elements["PTR-IFFCP-MODE1-WHEEL2"]		= multiposition_switch_1_side(_("MODE1-WHEEL2") ,devices.IFF,device_commands.Button_2,210,4,0.1, nil, nil, {135, 0}, {-135, 0})

-- TODO: correct cycled animation
elements["PTR-IFFCP-MODE3A-WHEEL1"]		= multiposition_switch_1_side(_("MODE3A-WHEEL1"),devices.IFF,device_commands.Button_3,211,8,0.1, nil, nil, {135, 0}, {-135, 0})
elements["PTR-IFFCP-MODE3A-WHEEL2"]		= multiposition_switch_1_side(_("MODE3A-WHEEL2"),devices.IFF,device_commands.Button_4,212,8,0.1, nil, nil, {135, 0}, {-135, 0})
elements["PTR-IFFCP-MODE3A-WHEEL3"]		= multiposition_switch_1_side(_("MODE3A-WHEEL3"),devices.IFF,device_commands.Button_5,213,8,0.1, nil, nil, {135, 0}, {-135, 0})
elements["PTR-IFFCP-MODE3A-WHEEL4"]		= multiposition_switch_1_side(_("MODE3A-WHEEL4"),devices.IFF,device_commands.Button_6,214,8,0.1, nil, nil, {135, 0}, {-135, 0})

elements["PTR-BTN-PANIFF-REPLY"]		= default_button_axis(_("Reply test"),devices.IFF,device_commands.Button_17,device_commands.Button_20,795,900)
elements["PTR-BTN-PANIFF-TEST"]			= default_button_axis(_("Test test"),devices.IFF,device_commands.Button_18,device_commands.Button_21,796,901)

------------------------------------------
--Oxygen System Control Panel						
--elements["PTR-OXYGENCP-EMERGENCY"]			= default_3_position_tumb(_("Oxygen Flow Emergency/Normal/Test Mask"), devices.OXYGEN_SYSTEM, device_commands.Button_3, 601)

----------------------------------------
-- TEST MASK position is spring-loaded
elements["PTR-OXYGENCP-EMERGENCY"]			= default_button_tumb(_("Oxygen Flow Emergency/Normal/Test Mask"), devices.OXYGEN_SYSTEM, device_commands.Button_4, device_commands.Button_3, 601)
elements["PTR-OXYGENCP-EMERGENCY"].sound	= {{SOUND_SW1_OFF, SOUND_SW1}, {SOUND_SW1}}
elements["PTR-OXYGENCP-OXYGEN-DILUTER"]		= default_2_position_tumb(_("Oxygen Normal/100%"), devices.OXYGEN_SYSTEM, device_commands.Button_2, 602)
elements["PTR-OXYGENCP-SUPPLY"]				= default_2_position_tumb(_("Oxygen Supply On/Off"), devices.OXYGEN_SYSTEM, device_commands.Button_1, 603)

------------------------------------------
--Environment Control Panel
elements["PTR-ENVCP-OXY-TEST"]					= default_button(_("Oxygen Indicator Test"),devices.ENVIRONMENT_SYSTEM,device_commands.Button_1,275)
elements["PTR-ENVCP-WINDSHIELD-DEFOG"]			= default_2_position_small_tumb(_("Windshield Defog/Deice"),devices.ENVIRONMENT_SYSTEM,device_commands.Button_2,276)
elements["PTR-ENVCP-CANOPY-DEFOG"]				= default_axis(_("Canopy Defog"),devices.ENVIRONMENT_SYSTEM,device_commands.Button_3,277,0.0,nil,nil,nil,nil,{70, -135},{90,-45})
elements["PTR-ENVCP-WINDSHIELD-RREMOVE-WASH"]	= default_3_position_small_tumb(_("Windshield Rain Removal/Wash"),devices.ENVIRONMENT_SYSTEM,device_commands.Button_4,278)
elements["PTR-ENVCP-PITOT-HEAT"]				= default_2_position_small_tumb(_("Pitot Heater"),devices.ENVIRONMENT_SYSTEM,device_commands.Button_5,279)
elements["PTR-ENVCP-BLEED-AIR"]					= default_2_position_tumb(_("Bleed Air") ,devices.ENVIRONMENT_SYSTEM,device_commands.Button_6,280)
elements["PTR-ENVCP-TEMP-PRESS"]				= default_3_position_small_tumb(_("Temperature/Pressure Control"),devices.ENVIRONMENT_SYSTEM,device_commands.Button_7,282, false, false, {1, -1}, {{-1,1},{-1,1}}, anim_speed_default_3_pos_thumb)
elements["PTR-ENVCP-MAIN-AIR-SUPPLY"]			= default_2_position_tumb(_("Main Air Supply") ,devices.ENVIRONMENT_SYSTEM,device_commands.Button_8,283)
elements["PTR-ENVCP-FLOW-LEVEL"]				= default_axis(_("Flow Level Control"),devices.ENVIRONMENT_SYSTEM,device_commands.Button_9,284,0.0,nil,nil,nil,nil,{70, -135},{90,-45})
elements["PTR-ENVCP-TEM-LEVEL"]					= default_axis(_("Temp Level Control"),devices.ENVIRONMENT_SYSTEM,device_commands.Button_13,286,0.0,nil,nil,nil,nil,{70, -135},{90,-45})

elements["PTR-ENVCP-CABIN-AIR-COND-OPER"]		= {
	class 				= {class_type.TUMB,class_type.TUMB}, 
	hint 				= _("Air Conditioner MAN/AUTO"), 
	device 				= devices.ENVIRONMENT_SYSTEM, 
	action 				= {device_commands.Button_10,device_commands.Button_10}, 
	arg 				= {285,285}, 
	arg_value 			= {-0.1,0.1}, 
	arg_lim 			= {{0.0, 0.1},{0.0, 0.1}},
	updatable 			= true, 
	animated			= {true, true},
	animation_speed		= {anim_speed_multipos_thumb, anim_speed_multipos_thumb},
	side				= {{BOX_SIDE_Z_top},{BOX_SIDE_Z_bottom}},
	sound				= {{SOUND_SW3}}
}
elements["PTR-ENVCP-CABIN-AIR-COND-OPER-COLD"]	= default_button(_("Air Conditioner to COLD"),devices.ENVIRONMENT_SYSTEM,device_commands.Button_11,285,0.2,{0,0.2})
elements["PTR-ENVCP-CABIN-AIR-COND-OPER-HOT"]	= default_button(_("Air Conditioner to HOT") ,devices.ENVIRONMENT_SYSTEM,device_commands.Button_12,285,0.3,{0,0.3})

------------------------------------------
--Circuit Breaker Panel
elements["PTR-CBP-AILERON-DISC-L"]			= push_button_tumb(_("AILERON DISC L"), devices.ELEC_INTERFACE, device_commands.Button_7, 666)
elements["PTR-CBP-AILERON-DISC-R"]			= push_button_tumb(_("AILERON DISC R"), devices.ELEC_INTERFACE, device_commands.Button_8, 667)
elements["PTR-CBP-SPS-RUDDER-AUTH-LIM"]		= push_button_tumb(_("SPS & RUDDER AUTH LIMIT"), devices.ELEC_INTERFACE, device_commands.Button_9, 668)
elements["PTR-CBP-ELEVATION-DISC-L"]		= push_button_tumb(_("ELEVATION DISC L"), devices.ELEC_INTERFACE, device_commands.Button_10, 669)
elements["PTR-CBP-ELEVATION-DISC-R"]		= push_button_tumb(_("ELEVATION DISC R"), devices.ELEC_INTERFACE, device_commands.Button_11, 670)
elements["PTR-CBP-AILERON-TAB-L"]			= push_button_tumb(_("AILERON TAB L"), devices.ELEC_INTERFACE, device_commands.Button_12, 671)
elements["PTR-CBP-AILERON-TAB-R"]			= push_button_tumb(_("AILERON TAB R"), devices.ELEC_INTERFACE, device_commands.Button_13, 672)
elements["PTR-CBP-EMER-FLAP"]				= push_button_tumb(_("EMER FLAP"), devices.ELEC_INTERFACE, device_commands.Button_14, 673)
elements["PTR-CBP-EMER-TRIM"]				= push_button_tumb(_("EMER TRIM"), devices.ELEC_INTERFACE, device_commands.Button_15, 674)
elements["PTR-CBP-LAND-GEAR"]				= push_button_tumb(_("LAND GEAR"), devices.ELEC_INTERFACE, device_commands.Button_16, 675)
elements["PTR-CBP-ENGINE-START-L"]			= push_button_tumb(_("ENGINE START L"), devices.ELEC_INTERFACE, device_commands.Button_17, 676)
elements["PTR-CBP-ENGINE-START-R"]			= push_button_tumb(_("ENGINE START R"), devices.ELEC_INTERFACE, device_commands.Button_18, 677)
elements["PTR-CBP-APU-CONT"]				= push_button_tumb(_("APU CONT"), devices.ELEC_INTERFACE, device_commands.Button_19, 678)
elements["PTR-CBP-ANG-IGNITOR-1"]			= push_button_tumb(_("ENG IGNITOR L/R-1"), devices.ELEC_INTERFACE, device_commands.Button_20, 679)
elements["PTR-CBP-ANG-IGNITOR-2"]			= push_button_tumb(_("ENG IGNITOR L/R-2"), devices.ELEC_INTERFACE, device_commands.Button_21, 680)
elements["PTR-CBP-EMER-FUEL-SHUTOFF-ENG-L"]	= push_button_tumb(_("EMER FUEL SHUTOFF ENG L"), devices.ELEC_INTERFACE, device_commands.Button_22, 681)
elements["PTR-CBP-EMER-FUEL-SHUTOFF-ENG-R"]	= push_button_tumb(_("EMER FUEL SHUTOFF ENG R"), devices.ELEC_INTERFACE, device_commands.Button_23, 682)
elements["PTR-CBP-DC-FUEL-PUMP"]			= push_button_tumb(_("DC FUEL PUMP"), devices.ELEC_INTERFACE, device_commands.Button_24, 683)
elements["PTR-CBP-BLEED-AIR-CONT-L"]		= push_button_tumb(_("BLEED AIR CONT L"), devices.ELEC_INTERFACE, device_commands.Button_25, 684)
elements["PTR-CBP-BLEED-AIR-CONT-R"]		= push_button_tumb(_("BLEED AIR CONT R"), devices.ELEC_INTERFACE, device_commands.Button_26, 685)
elements["PTR-CBP-EXT-STORES-JETT-1"]		= push_button_tumb(_("EXT STORES JETT 1"), devices.ELEC_INTERFACE, device_commands.Button_27, 686)
elements["PTR-CBP-EXT-STORES-JETT-2"]		= push_button_tumb(_("EXT STORES JETT 2"), devices.ELEC_INTERFACE, device_commands.Button_28, 687)
elements["PTR-CBP-STBY-ATT-IND"]			= push_button_tumb(_("STBY ATT IND"), devices.ELEC_INTERFACE, device_commands.Button_29, 688)
elements["PTR-CBP-MASTER-CAUT"]				= push_button_tumb(_("MASTER CAUT"), devices.ELEC_INTERFACE, device_commands.Button_30, 689)
elements["PTR-CBP-PITOT-HEAT-AC"]			= push_button_tumb(_("PITOT HEAT AC"), devices.ELEC_INTERFACE, device_commands.Button_31, 690)
elements["PTR-CBP-IFF"]						= push_button_tumb(_("IFF"), devices.ELEC_INTERFACE, device_commands.Button_32, 691)
elements["PTR-CBP-UHF-COMM"]				= push_button_tumb(_("UHF COMM"), devices.ELEC_INTERFACE, device_commands.Button_33, 692)
elements["PTR-CBP-INTER-COMM"]				= push_button_tumb(_("INTER COMM"), devices.ELEC_INTERFACE, device_commands.Button_34, 693)
elements["PTR-CBP-GENERATOR-CONT-L"]		= push_button_tumb(_("GENERATOR CONT L"), devices.ELEC_INTERFACE, device_commands.Button_35, 694)
elements["PTR-CBP-GENERATOR-CONT-R"]		= push_button_tumb(_("GENERATOR CONT R"), devices.ELEC_INTERFACE, device_commands.Button_36, 695)
elements["PTR-CBP-CONVERTER-L"]				= push_button_tumb(_("CONVERTER L"), devices.ELEC_INTERFACE, device_commands.Button_37, 696)
elements["PTR-CBP-AUX-ESS-BUS-0A"]			= push_button_tumb(_("AUX ESS BUS 0A"), devices.ELEC_INTERFACE, device_commands.Button_38, 697)
elements["PTR-CBP-AUX-ESS-BUS-0B"]			= push_button_tumb(_("AUX ESS BUS 0B"), devices.ELEC_INTERFACE, device_commands.Button_39, 698)
elements["PTR-CBP-AUX-ESS-BUS-0C"]			= push_button_tumb(_("AUX ESS BUS 0C"), devices.ELEC_INTERFACE, device_commands.Button_40, 699)
elements["PTR-CBP-BATTERY-BUS-TRANS"]		= push_button_tumb(_("BATTERY BUS TRANS"), devices.ELEC_INTERFACE, device_commands.Button_41, 700)
elements["PTR-CBP-INVERTER-PWR"]			= push_button_tumb(_("INVERTER PWR"), devices.ELEC_INTERFACE, device_commands.Button_42, 701)
elements["PTR-CBP-INVERTER-CONT"]			= push_button_tumb(_("INVERTER CONT"), devices.ELEC_INTERFACE, device_commands.Button_43, 702)
elements["PTR-CBP-AUX-ESS-BUS-TIE"]			= push_button_tumb(_("AUX ESS BUS TIE"), devices.ELEC_INTERFACE, device_commands.Button_44, 703)

------------------------------------------
--AAU-34/A
elements["PNT-ALT-LEVR-L"] = default_axis(_("Set Pressure"),devices.FM_PROXY, device_commands.Button_1, 62, 0.04, 1, false, true)
elements["PNT-ALT-LEVR-R"] = springloaded_3_pos_tumb(_("ELECT/PNEU"), devices.AAU34, device_commands.Button_2, device_commands.Button_1, 60, 1, -1 , 0 , 1 )

------------------------------------------
--Light System Control Panel

elements["PTR-LGHTCP-POSITION"]			= default_3_position_small_tumb(_("Position Lights, FLASH/OFF/STEADY"), devices.LIGHT_SYSTEM, device_commands.Button_8, 287)
elements["PTR-LGHTCP-FORMATION"]		= default_axis(_("Formation Lights"), devices.LIGHT_SYSTEM, device_commands.Button_9, 288, nil, nil, nil, nil, nil, {70, -135},{90,-45})
elements["PTR-LGHTCP-ANTICOLLISION"]    = electrically_held_switch(_("Anticollision Lights"), devices.LIGHT_SYSTEM, device_commands.Button_10, device_commands.Button_11, 289)
elements["PTR-LGHTCP-ENG-INST"]			= default_axis(_("Engine Instruments Lights"), devices.LIGHT_SYSTEM, device_commands.Button_1, 290, nil, nil, nil, nil, nil, {70, -135},{90,-45})
elements["PTR-LGHTCP-NOSE-ILLUM"]		= default_2_position_small_tumb(_("Nose Illumination"), devices.LIGHT_SYSTEM, device_commands.Button_12, 291)
elements["PTR-LGHTCP-FLIGHT-INST"]		= default_axis(_("Flight Instruments Lights"), devices.LIGHT_SYSTEM, device_commands.Button_2, 292, nil, nil, nil, nil, nil, {70, -135},{180,-45})
elements["PTR-LGHTCP-AUX-INST"]			= default_axis(_("Auxiliary Instruments Lights"), devices.LIGHT_SYSTEM, device_commands.Button_3, 293, nil, nil, nil, nil, nil, {70, -135},{140,-45})
elements["PTR-LGHTCP-SIGNAL-LTS"]		= default_2_position_small_tumb(_("Signal Lights"), devices.LIGHT_SYSTEM, device_commands.Button_13, 294)
elements["PTR-LGHTCP-ACCEL-COMP"]		= default_2_position_small_tumb(_("Accelerometer & Compass Lights"), devices.LIGHT_SYSTEM,device_commands.Button_4, 295)
elements["PTR-LGHTCP-FLOOD"]			= default_axis(_("Flood Light"), devices.LIGHT_SYSTEM, device_commands.Button_5, 296, nil, nil, nil, nil, nil, {70, -135},{180,-55})
elements["PTR-LGHTCP-CONSOLE"]			= default_axis(_("Console Light"), devices.LIGHT_SYSTEM, device_commands.Button_6, 297, nil, nil, nil, nil, nil, {70, -135},{180,-45})
elements["PTR-LIGHTS-LAND"]				= default_3_position_tumb(_("Land Taxi Lights"), devices.LIGHT_SYSTEM, device_commands.Button_14, 655, false, false, {-0.1,0.1}, {{0,0.2},{0,0.2}}, 2)
elements["PTR-ALCP-RSIL"]				= default_axis(_("Refuel Status Indexer Lights"), devices.LIGHT_SYSTEM, device_commands.Button_15, 193, 0.0, nil, nil, nil, nil, {80, -45})
elements["PTR-ALCP-WPNSTA"]				= default_axis(_("Weapon Station Lights. No function"), devices.LIGHT_SYSTEM, device_commands.Button_16, 195, 0.0, nil, nil, nil, nil, {90, -45}) -- No function in A-10C
elements["PTR-ALCP-NVIS-LTS"]			= default_3_position_tumb(_("Nightvision Lights"), devices.LIGHT_SYSTEM, device_commands.Button_17, 194, false, false, {-0.1,0.1}, {{0,0.2},{0,0.2}}, 2)
elements["PTR-FSCP-RCVR-LT"]			= default_axis(_("Refueling Lighting Dial")	 ,devices.LIGHT_SYSTEM, device_commands.Button_18, 116, 0.0, nil, nil, nil, nil, {90, -45})
elements["PTR-ALCP-HARSSAS"]			= default_2_position_tumb(_("HARS-SAS Override/NORM"), devices.AUTOPILOT,device_commands.Button_31, 196)
elements["PTR-ALCP-FDBAL-TEST"] 		= default_button(_("Fire Detect Bleed Air Test"), devices.SYS_CONTROLLER, device_commands.Button_4, 198,1, {0,1})

------------------------------------------
--Fire Extinguishers Panel
elements["PTR-FIRE-LENG-PULL"]			= default_2_position_tumb(_("Left Engine Fire T-Handle")			,devices.FIRE_SYSTEM,device_commands.Button_1,102)
elements["PTR-FIRE-LENG-PULL"].side		= {{BOX_SIDE_Y_bottom},{BOX_SIDE_Y_top}}	
elements["PTR-FIRE-LENG-PULL"].sound 	= {{SOUND_SW10_DOWN}}
elements["PTR-FIRE-APU-PULL"]			= default_2_position_tumb(_("APU Fire T-Handle")		 			,devices.FIRE_SYSTEM,device_commands.Button_2,103)
elements["PTR-FIRE-APU-PULL"].sound 	= {{SOUND_SW10_DOWN}}
elements["PTR-FIRE-RENG-PULL"]			= default_2_position_tumb(_("Right Engine Fire T-Handle")			,devices.FIRE_SYSTEM,device_commands.Button_3,104)
elements["PTR-FIRE-RENG-PULL"].sound 	= {{SOUND_SW10_DOWN}}
elements["PTR-FIRE-EXTING-DISCH"]		= default_3_position_small_tumb(_("Fire Extinguishing Agent Discharge")	,devices.FIRE_SYSTEM,device_commands.Button_4,105, false, true, {-1, 1}, {{-1,1},{-1,1}}, anim_speed_default_3_pos_thumb)

------------------------------------------
--Horizontal Situation Indicator
elements["PNT-LVR-HSI-HDG"]				= default_axis(_("Heading Set Knob"),devices.HSI, device_commands.Button_1, 45, 1.0, 0.1, false, true)
elements["PNT-LVR-HSI-CRS"]				= default_axis(_("Course Set Knob"), devices.HSI, device_commands.Button_2, 44, 1.0, 0.1, false, true)

------------------------------------------
--Attitude Direction Indicator
elements["PNT-LVR-ADI-KNOB"]			= default_axis_limited(_("ADI Pitch Trim Knob"), devices.ADI, device_commands.Button_1, 22, 0.1, false, false, {-0.5, 0.5})

------------------------------------------
--Standby Attitude Indicator
elements["PNT-LVR-SAI-CAGE"] = 				{ 
	class = {class_type.BTN, class_type.LEV}, 
	hint = _("Cage Standby Attitude Indicator. Hold Right Mouse Button and rotate Scroll Wheel to uncage"), 
	device = devices.SAI, 
	action = {device_commands.Button_2, device_commands.Button_3}, 
	stop_action = {device_commands.Button_2, 0}, 
	is_repeatable = {}, 
	arg = {67, 66}, 
	arg_value = {1.0, 1 }, 
	arg_lim = {{0, 1}, {-1, 1}}, 
	relative = {false,false}, 
	gain = {1.0, 0.5}, 
	use_release_message = {true, false}, 
	use_OBB = true,
	cycle = false,
	class_vr = {class_type.BTN_FIX,	nil},
	side = {{BOX_SIDE_Y_bottom},{BOX_SIDE_X_top,BOX_SIDE_X_bottom,BOX_SIDE_Z_top,BOX_SIDE_Z_bottom}},
	sound = {{SOUND_SW3_OFF, SOUND_SW3}, {SOUND_SW6}}
	}
	
------------------------------------------
--TACAN
elements["PTR-TACAN-CHANNEL-SELECTOR-1"] = {
	class  		 	= {          class_type.LEV,                      nil}, 
	hint   		 	= _("Channel Selector (Tens). Rotate mouse wheel to select"),
	device 		 	= devices.TACAN_CTRL_PANEL,
	action 		 	= {device_commands.Button_1, device_commands.Button_1}, 
	arg 			= {                     256,                      256},
	arg_value 		= {                     0.1,                     -0.1},
	arg_lim   		= {              {0.0, 1.0},               {0.0, 1.0}},
	relative		= {                    true,                     true},
	animated   		= {                    true,                     true},
	animation_speed = {                     0.7,                      0.7},
	gain 			= {                     0.1,                      0.1},
	sound 			= {				{SOUND_SW9},			  {SOUND_SW9}},
	class_vr		= {         class_type.TUMB,          class_type.TUMB},
	side			= {     {BOX_SIDE_Z_bottom},         {BOX_SIDE_Z_top}},
	attach_left		= {120, -135},
	attach_right	= {60, -45},
}
elements["PTR-TACAN-CHANNEL-SELECTOR-2"] = {
	class  		 	= {			class_type.TUMB,          class_type.TUMB,           class_type.LEV,                      nil},
	hint   		 	= _("Channel Selector (Ones) / X/Y Mode. Right mouse click to select X/Y. Rotate mouse wheel to make channel selection"),
	device 		 	= devices.TACAN_CTRL_PANEL,
	action 		 	= {device_commands.Button_3, device_commands.Button_3, device_commands.Button_2, device_commands.Button_2},
	arg 			= {                     258,                      258,                      257,                      257},
	arg_value 		= {                    -1.0,                      1.0,                      0.1,                     -0.1},
	arg_lim   		= {              {0.0, 1.0},               {0.0, 1.0},               {0.0, 1.0},               {0.0, 1.0}},
	relative		= {                   false,                    false,                     true,                     true},
	animated   		= {                    true,                     true,                     true,                     true},
	animation_speed = {                    10.0,                     10.0,                      0.7,                      0.7},
	gain 			= {                     1.0,                      1.0,                      0.1,                      0.1},
	sound 			= {				{SOUND_SW9},		 	  {SOUND_SW9},				{SOUND_SW9},			  {SOUND_SW9}},
	class_vr		= {                     nil,                      nil,          class_type.TUMB,          class_type.TUMB},
	side			= {        {BOX_SIDE_X_top},      {BOX_SIDE_X_bottom},      {BOX_SIDE_Z_bottom},         {BOX_SIDE_Z_top}},
	attach_left		= {90, -135},
	attach_right	= {90, -45},
}

elements["PTR-TACAN-TEST"]	= default_button(_("Test TACAN Signal on HSI"),	devices.TACAN_CTRL_PANEL, device_commands.Button_4, 259, 1, {0, 1})
elements["PTR-TACAN-VOL"]	= default_axis(_("Signal Volume"),				devices.TACAN_CTRL_PANEL, device_commands.Button_5, 261, nil, nil, nil, nil, nil, {90, -135}, {90, -45} )
elements["PTR-TACAN-MODE"]	= multiposition_switch(_("Mode Dial"),			devices.TACAN_CTRL_PANEL, device_commands.Button_6, 262, 5, 0.1, nil, anim_speed_multipos_thumb, {90, -135}, {90, -45} )

------------------------------------------
--STALL 
elements["PTR-STALLWCP-STALL"] 				= default_axis(_("Stall Volume"), devices.STALL, device_commands.Button_1, 704, nil, nil, nil, nil, nil, {-90, -90}, {-90, -45} )
elements["PTR-STALLWCP-PEAK"] 				= default_axis(_("Peak Volume"), devices.STALL, device_commands.Button_2, 705, nil, nil, nil, nil, nil, {-90, -90}, {-90, -45} )


------------------------------------------
--ILS
elements["PTR-ILSCP-PWR"] = {
	class 			= {			class_type.TUMB, 		  class_type.TUMB, 			   class_type.LEV},
	hint 			= _("ILS Frequency MHz / Power. Right mouse click to cycle power. Rotate mouse wheel to change frequency value"),
	device 			= devices.ILS,
	action 			= {device_commands.Button_1, device_commands.Button_1,   device_commands.Button_2},
	arg 			= {						247, 					  247, 						  248},
	arg_value 		= {						 -1, 						1, 						  0.1},
	arg_lim 		= { 			 {0.0, 1.0}, 			   {0.0, 1.0},				   {0.0, 0.3}},
	relative 		= {					  false,					false, 					    false},
	animated   		= {					  false,					false,					     true},
	animation_speed = {						0.0,					  0.0,						  0.5},
	gain 			= {						1.0, 					  1.0,						  0.1},
	cycle 			= false,
	sound 			= {{SOUND_SW9},{SOUND_SW9},{SOUND_SW9}},
	class_vr		= {	     class_type.BTN_FIX,					  nil,	    class_type.MULTY_TUMB},
	side 			= {		{BOX_SIDE_Y_bottom},					   {},{BOX_SIDE_X_top,BOX_SIDE_X_bottom,BOX_SIDE_Z_top,BOX_SIDE_Z_bottom}},
	attach_left		= {120, -135},
	attach_right	= {60, -45},
}

elements["PTR-ILSCP-VOL"] = {
	class 			= {			class_type.TUMB, 		  class_type.TUMB,				 class_type.LEV},
	hint 			= _("ILS Frequency kHz / Volume. Rotate mouse wheel to change frequency value. Left or Right click and hold while moving mouse to adjust volume "),
	device 			= devices.ILS,
	action 			= {device_commands.Button_5, device_commands.Button_4,     device_commands.Button_3},
	arg				= {						250, 					  250, 							249},
	arg_value 		= {					   -0.1, 					  0.1, 						   0.05},
	arg_lim 		= {				 {0.0, 1.0}, 			   {0.0, 1.0}, 				 	 {0.0, 0.9}},
	relative 		= {					  false, 					false, 					  	  false},
	animated   		= {					   true, 					 true, 					   	   true},
	animation_speed = {						0.7, 					  0.7, 							0.5},
	gain			= {					   0.05, 					 0.05, 							0.1},
	cycle 			= false,
	sound 			= {{SOUND_SW9},{SOUND_SW9},{SOUND_SW9}},
	class_vr		= {	     				nil,	class_type.MULTY_TUMB,	      class_type.MULTY_TUMB},
	side 			= {						 {},	  {BOX_SIDE_X_top,BOX_SIDE_X_bottom},{BOX_SIDE_Z_top,BOX_SIDE_Z_bottom}},
	attach_left		= {90, -135},
	attach_right	= {90, -45},
}

--------------------------------------------
--UHF Raido
elements["PTR-ANARC164-CHANNEL-SELECTOR"] 	= multiposition_switch_tumb(_("Preset Channel Selector"), devices.UHF_RADIO, device_commands.Button_1, 161, 20, 0.05, 0, false, 1)
elements["PTR-ANARC164-100MHZ-SELECTOR"] 	= multiposition_switch_tumb(_("100 MHz Selector") , devices.UHF_RADIO, device_commands.Button_2, 162, 3, 0.1)
elements["PTR-ANARC164-10MHZ-SELECTOR"] 	= multiposition_switch_tumb(_("10 MHz Selector"), devices.UHF_RADIO, device_commands.Button_3, 163, 10, 0.1)
elements["PTR-ANARC164-1MHZ-SELECTOR"] 		= multiposition_switch_tumb(_("1 MHz Selector"), devices.UHF_RADIO, device_commands.Button_4, 164, 10, 0.1)
elements["PTR-ANARC164-0.1MHZ-SELECTOR"] 	= multiposition_switch_tumb(_("0.1 MHz Selector"), devices.UHF_RADIO, device_commands.Button_5, 165, 10, 0.1)
elements["PTR-ANARC164-0.025MHZ-SELECTOR"] 	= multiposition_switch_tumb(_("0.025 MHz Selector"), devices.UHF_RADIO, device_commands.Button_6, 166, 4, 0.1)

elements["PTR-ANARC164-FREQMODE"] = multiposition_switch(_("Frequency Mode Dial") , devices.UHF_RADIO, device_commands.Button_7, 167, 3, 0.1, nil, anim_speed_multipos_thumb, {-70, -135}, {-120, -45})
elements["PTR-ANARC164-FUNCTION"] = multiposition_switch(_("Function Dial") , devices.UHF_RADIO, device_commands.Button_8, 168, 4, 0.1, nil, anim_speed_multipos_thumb, {-90, -135}, {-90, -45})
elements["PTR-ANARC164-T-TONE"]	= {class = {class_type.BTN,class_type.BTN}, hint  = _("T-Tone"), device = devices.UHF_RADIO, action = {device_commands.Button_9 ,device_commands.Button_9}, stop_action = {device_commands.Button_9,device_commands.Button_9}, arg = {169,169}, arg_value = {-1,1}, arg_lim = {{-1, 0},{0, 1}}, use_release_message = {true, true}, sound = {{SOUND_SW3, SOUND_SW3_OFF}}}
elements["PTR-ANARC164-SQUELCH"] = default_2_position_small_tumb(_("Squelch"), devices.UHF_RADIO, device_commands.Button_10, 170)
elements["PTR-ANARC164-VOLUME"] = default_axis(_("Volume"), devices.UHF_RADIO, device_commands.Button_11, 171, nil, nil, nil, nil, nil, {-90, -135}, {-110, -45})
elements["PTR-ANARC164-TEST-DISPLAY"] = default_button(_("Test Display"), devices.UHF_RADIO, device_commands.Button_12, 172, 1, {0, 1})
elements["PTR-ANARC164-STATUS"] = default_button(_("Status"), devices.UHF_RADIO, device_commands.Button_13, 173, 1, {0, 1})
elements["PTR-ANARC164-LOAD"] = default_button(_("Load button"), devices.UHF_RADIO, device_commands.Button_15, 735, 1, {0, 1})
elements["PTR-ANARC164-COVER"]		= 	{class  	= {class_type.TUMB,class_type.TUMB},
										 hint   	= _("Cover"), 
										 device 	= devices.UHF_RADIO,
										 action 	= {device_commands.Button_14,device_commands.Button_14},
										 arg 		= {734,734},
										 arg_value 	= {1,-1},
										 arg_lim 	= {{0,1},{0,1}},
										 updatable  = true, 
										 gain 		= {0.1,0.1},
										 animated 	= {true,true},
										 animation_speed = {5.5,5.5},
										 cycle 		= true,
										 side		= {{BOX_SIDE_Y_bottom},{BOX_SIDE_Z_bottom}},
										 sound		= {{SOUND_SW8_OPEN, SOUND_SW8_CLOSE}}
										 }		

function radio_wheel(hint_,device_,command1_,command2_,arg_, arg_value_, slave_)

	arg_value_ = arg_value_ or {-0.1, 0.1}
	slave_ = slave_ or {}
	
	return  {
			 class  		 = {class_type.TUMB,class_type.TUMB}, 
			 hint   		 = hint_,
			 device 		 = device_,
			 action 		 = {command1_ ,command2_}, 
			 arg 			 = {arg_,arg_},
			 arg_value 		 = arg_value_,
			 arg_lim   		 = {{0,1},{0,1}},
			 relative		 = {true,true},
			 animated        = {true,true},
			 animation_speed = {0.5, 0.5},
			 slave_animation = {{slave = slave_},{slave = slave_}},
			 side			 = {{BOX_SIDE_Z_top},{BOX_SIDE_Z_bottom}},
			 sound			 = {{SOUND_SW9}, {SOUND_SW9}}
			}
end

------------------------------------------
-- VHF AM Radio

if ARC_210_ENABLED then
--------------------------------------------------------------------					 
 --ARC-210
elements["VHFUHF1P"] = multiposition_switch_limited(_("ARC-210, master switch") , devices.VHF_AM_RADIO, device_commands.Button_43, 551, 7, 0.1, nil, anim_speed_multipos_thumb, {135, -45}, {20, -55})
elements["VHFUHF2P"] = default_axis(_("ARC-210, channel select knob") , devices.VHF_AM_RADIO, device_commands.Button_27, 552, 1.0, 0.1, false, true)
elements["VHFUHF3P"] = multiposition_switch_limited(_("ARC-210, secondary switch") , devices.VHF_AM_RADIO, device_commands.Button_44, 553, 7, 0.1, nil, anim_speed_multipos_thumb, {135, -45}, {20, -55})

elements["VHFUHF4P"] 	= multiposition_switch_tumb(_("ARC-210, 100 MHz Selector") , devices.VHF_AM_RADIO, device_commands.Button_25, 554, 4, 0.1)
elements["VHFUHF5P"] 	= multiposition_switch_tumb(_("ARC-210, 10 MHz Selector"), devices.VHF_AM_RADIO, device_commands.Button_23, 555, 10, 0.1)
elements["VHFUHF6P"] 	= multiposition_switch_tumb(_("ARC-210, 1 MHz Selector"), devices.VHF_AM_RADIO, device_commands.Button_21, 556, 10, 0.1)
elements["VHFUHF7P"] 	= multiposition_switch_tumb(_("ARC-210, 100 KHz Selector"), devices.VHF_AM_RADIO, device_commands.Button_19, 557, 10, 0.1)
elements["VHFUHF8P"] 	= multiposition_switch_tumb(_("ARC-210, 25  KHz Selector"), devices.VHF_AM_RADIO, device_commands.Button_17, 558, 4, 0.1)

elements["VHFUHF9P"]  = default_button(_("ARC-210, Enter, No function") , devices.VHF_AM_RADIO, device_commands.Button_14, 573)
elements["VHFUHF10P"] = default_button(_("ARC-210, Offset frequency") , devices.VHF_AM_RADIO, device_commands.Button_13, 572)
elements["VHFUHF11P"] = default_button(_("ARC-210, Transmit / receive function toggle") , devices.VHF_AM_RADIO, device_commands.Button_12, 571)
elements["VHFUHF12P"] = default_button(_("ARC-210, Amplitude modulation / frequency modulation select") , devices.VHF_AM_RADIO, device_commands.Button_11, 570)
elements["VHFUHF13P"] = default_button(_("ARC-210, Menu pages") , devices.VHF_AM_RADIO, device_commands.Button_10, 569)

elements["VHFUHF14P"] = push_button_tumb(_("ARC-210, Squelch on/off") , devices.VHF_AM_RADIO, device_commands.Button_15, 568)

elements["VHFUHF15P"] = default_button(_("ARC-210, Select receiver - transmitter, No function") , devices.VHF_AM_RADIO, device_commands.Button_4, 567)
elements["VHFUHF16P"] = default_button(_("ARC-210, Global positioning system, No function") , devices.VHF_AM_RADIO, device_commands.Button_3, 566)
elements["VHFUHF17P"] = default_button(_("ARC-210, Time of day receive, No function") , devices.VHF_AM_RADIO, device_commands.Button_2, 565)
elements["VHFUHF18P"] = default_button(_("ARC-210, Time of day send, No function") , devices.VHF_AM_RADIO, device_commands.Button_1, 564)
elements["VHFUHF19P"] = default_button(_("ARC-210, upper FSK") , devices.VHF_AM_RADIO, device_commands.Button_5, 563)
elements["VHFUHF20P"] = default_button(_("ARC-210, middle FSK") , devices.VHF_AM_RADIO, device_commands.Button_6, 562)
elements["VHFUHF21P"] = default_button(_("ARC-210, lower FSK") , devices.VHF_AM_RADIO, device_commands.Button_7, 561)

elements["VHFUHF22P"] = default_button(_("ARC-210, brightness increase") , devices.VHF_AM_RADIO, device_commands.Button_8, 560)
elements["VHFUHF23P"] = default_button(_("ARC-210, brightness decrease") , devices.VHF_AM_RADIO, device_commands.Button_9, 559)

else
-- ARC-186
elements["PTR-ANARC186-VHFAM-PRESET"] = multiposition_switch_1_side(_("Preset Channel Selector"), devices.VHF_AM_RADIO, device_commands.Button_1, 137, 20, -0.01000001, nil, 0.1, {-135, 45}, {160, 0} )
elements["PTR-ANARC186-VHFAM-PRESET"].arg_value = {-0.01, 0.01}
elements["PTR-ANARC186-VHFAM-PRESET"].arg_lim = {{0, 0.2}, {0, 0.2}}
elements["PTR-ANARC186-VHFAM-PRESET"].relative = {true, true}
elements["PTR-ANARC186-VHFAM-PRESET"].turn_box = {0,-90,90}


elements["PTR-ANARC186-VHFAM-MODE"] 			= multiposition_switch_tumb(_("Frequency Mode Dial") , devices.VHF_AM_RADIO, device_commands.Button_3, 138, 3, 0.1)
elements["PTR-ANARC186-VHFAM-FREQEMER-CONTROL"] = multiposition_switch_limited(_("Frequency Selection Dial") , devices.VHF_AM_RADIO, device_commands.Button_4, 135, 4, 0.1, nil, anim_speed_multipos_thumb, {135, -45}, {20, -55})
elements["PTR-ANARC186-VHFAM-VOLUME"]			= default_axis(_("Volume"), devices.VHF_AM_RADIO, device_commands.Button_5, 133, nil, nil, nil, nil, nil, {135, -45}, {45, -45})
elements["PTR-ANARC186-VHFAM-LOAD"]			 	= default_button(_("Load"), devices.VHF_AM_RADIO, device_commands.Button_6, 136, 1, {0, 1})

elements["PTR-ANARC186-VHFAM-SQUELCH"] = default_small_tumb_button(_("Squelch / TONE"),	devices.VHF_AM_RADIO, device_commands.Button_7, device_commands.Button_8, 134)
elements["PTR-ANARC186-VHFAM-SQUELCH"].turn_box = {0,90,0}

elements["PTR-ANARC186-VHFAM-FREQ-1"] = radio_wheel(_("Frequency Selector the 1nd"), devices.VHF_AM_RADIO, device_commands.Button_9, device_commands.Button_10, 139,{-0.1, 0.1}, {143,{0.125,0.775},0.5})
elements["PTR-ANARC186-VHFAM-FREQ-2"] = radio_wheel(_("Frequency Selector the 2nd"), devices.VHF_AM_RADIO, device_commands.Button_11, device_commands.Button_12, 140,{-0.1, 0.1}, {144,{0.0,1.0},1.0})
elements["PTR-ANARC186-VHFAM-FREQ-3"] = radio_wheel(_("Frequency Selector the 3rd"), devices.VHF_AM_RADIO, device_commands.Button_13, device_commands.Button_14, 141,{-0.1, 0.1}, {145,{0.0,1.0},1.0})
elements["PTR-ANARC186-VHFAM-FREQ-4"] = radio_wheel(_("Frequency Selector the 4th"), devices.VHF_AM_RADIO, device_commands.Button_15, device_commands.Button_16, 142,{-0.25, 0.25}, {146,{0.0,1.0},1.0})
end

------------------------------------------
-- VHF FM Radio
elements["PTR-ANARC186-VHFFM-PRESET"] = multiposition_switch_1_side(_("Preset Channel Selector"), devices.VHF_FM_RADIO, device_commands.Button_1, 151, 20, -0.01000001, nil, 0.1,  {-135, 45}, {0, -135} )
elements["PTR-ANARC186-VHFFM-PRESET"].arg_value = {-0.01, 0.01}
elements["PTR-ANARC186-VHFFM-PRESET"].arg_lim = {{0, 0.2}, {0, 0.2}}
elements["PTR-ANARC186-VHFFM-PRESET"].relative = {true, true}

elements["PTR-ANARC186-VHFFM-MODE"] 			= multiposition_switch_tumb(_("Frequency Mode Dial") , devices.VHF_FM_RADIO, device_commands.Button_3, 152, 3, 0.1)
elements["PTR-ANARC186-VHFFM-FREQEMER-CONTROL"] = multiposition_switch_limited(_("Frequency Selection Dial") , devices.VHF_FM_RADIO, device_commands.Button_4, 149, 4, 0.1, nil, anim_speed_multipos_thumb, {-90, -135}, {-90, -45})
elements["PTR-ANARC186-VHFFM-VOLUME"] 			= default_axis(_("Volume"), devices.VHF_FM_RADIO, device_commands.Button_5, 147, nil, nil, nil, nil, nil, {-90, -135}, {-90, -45})
elements["PTR-ANARC186-VHFFM-LOAD"] 			= default_button(_("Load"), devices.VHF_FM_RADIO, device_commands.Button_6, 150, 1, {0, 1})

elements["PTR-ANARC186-VHFFM-SQUELCH"] = default_small_tumb_button(_("Squelch / TONE"),devices.VHF_FM_RADIO,device_commands.Button_7, device_commands.Button_8, 148)

elements["PTR-ANARC186-VHFFM-FREQ-1"] = radio_wheel(_("Frequency Selector the 1nd"), devices.VHF_FM_RADIO, device_commands.Button_9, device_commands.Button_10, 153,{-0.1, 0.1}, {157,{0.125,0.775},0.5})
elements["PTR-ANARC186-VHFFM-FREQ-2"] = radio_wheel(_("Frequency Selector the 2nd"), devices.VHF_FM_RADIO, device_commands.Button_11, device_commands.Button_12, 154,{-0.1, 0.1}, {158,{0.0,1.0},1.0})
elements["PTR-ANARC186-VHFFM-FREQ-3"] = radio_wheel(_("Frequency Selector the 3rd"), devices.VHF_FM_RADIO, device_commands.Button_13, device_commands.Button_14, 155,{-0.1, 0.1}, {159,{0.0,1.0},1.0})
elements["PTR-ANARC186-VHFFM-FREQ-4"] = radio_wheel(_("Frequency Selector the 4th"), devices.VHF_FM_RADIO, device_commands.Button_15, device_commands.Button_16, 156,{-0.25, 0.25}, {160,{0.0,1.0},1.0})

---------------------------------------------------------------------------------------

elements["PTR-SEAT-ADJBUTTON"] 				= springloaded_3_pos_tumb(_("Seat Height Adjustment"), devices.CPT_MECH,device_commands.Button_5,device_commands.Button_4,770)
elements["PTR-SEAT-ADJBUTTON"].sound		= {{SOUND_SW3, SOUND_SW3_OFF}, {SOUND_SW3_OFF, SOUND_SW3}}
elements["PTR-SEAT-ADJBUTTON"].arg_value 	= {1, -1}
elements["PTR-SEAT-ADJBUTTON"].arg_lim 		= {{0, 1}, {-1, 0}}
elements["PTR-SEAT-ADJBUTTON"].stop_value 	= {0, 0}

elements["PTR-CANOPY-OPEN"] 		= default_button_tumb(_("Canopy Open/Hold/Close") ,devices.CPT_MECH,device_commands.Button_6,device_commands.Button_7, 712, {0.5,nil}, {-0.5, 0.5}, {{0,0.5}, {0.5, 1.0}}, 12)
elements["PTR-CANOPY-OPEN"].sound	= {{SOUND_SW1_OFF, SOUND_SW1}, {SOUND_SW1}}

elements["PTR-EMER-BRKARM"]			= 	{class  	= {class_type.TUMB, class_type.TUMB},
										 hint   	= _("Emergency Brake"), 
										 device 	= devices.AUTOPILOT,
										 action 	= {device_commands.Button_30, device_commands.Button_30},
										 arg 		= {772, 772},
										 arg_value 	= {-1, 1},
										 arg_lim 	= {{0, 1}, {0, 1}},
										 updatable  = true, 
										 gain 		= {0.1, 0.1},
										 animated 	= {true, true},
										 animation_speed = {12.0, 12.0},
										 cycle 		= true,
										 side		= {{BOX_SIDE_Y_bottom},{BOX_SIDE_Y_top}},
										 sound		= {{SOUND_SW7_UP, SOUND_SW7_DOWN}}
}							 
						 
-------------------------------------------------------------------
--Inercom Panel

elements["PTR-INTERCOM-INT"]	= intercom_rotate_tumb(_("INT Switch"),devices.INTERCOM,device_commands.Button_1,device_commands.Button_2, 222, 221)
elements["PTR-INTERCOM-FM"]		= intercom_rotate_tumb(_("FM Switch"),devices.INTERCOM,device_commands.Button_3,device_commands.Button_4, 224, 223)
elements["PTR-INTERCOM-VHF"]	= intercom_rotate_tumb(_("VHF Switch"),devices.INTERCOM,device_commands.Button_5,device_commands.Button_6, 226, 225)
elements["PTR-INTERCOM-UHF"]	= intercom_rotate_tumb(_("UHF Switch"),devices.INTERCOM,device_commands.Button_7,device_commands.Button_8, 228, 227)
elements["PTR-INTERCOM-AIM"]	= intercom_rotate_tumb(_("AIM Switch"),devices.INTERCOM,device_commands.Button_9,device_commands.Button_10, 230, 229)
elements["PTR-INTERCOM-IFF"]	= intercom_rotate_tumb(_("IFF Switch"),devices.INTERCOM,device_commands.Button_11,device_commands.Button_12, 232, 231)
elements["PTR-INTERCOM-ILS"]	= intercom_rotate_tumb(_("ILS Switch"),devices.INTERCOM,device_commands.Button_13,device_commands.Button_14, 234, 233)
elements["PTR-INTERCOM-TCN"]	= intercom_rotate_tumb(_("TCN Switch"),devices.INTERCOM,device_commands.Button_15,device_commands.Button_16, 236, 235)
elements["PTR-INTERCOM-HM"]		= push_button_tumb(_("HM Switch"),devices.INTERCOM,device_commands.Button_17,237)
elements["PTR-INTERCOM-VOL"]	= default_axis(_("Intercom volume"),devices.INTERCOM,device_commands.Button_18,238, nil, nil, nil, nil, nil, {-90, -90}, {-90, -45})
elements["PTR-INTERCOM-MODE"] 	= multiposition_switch_intercom(_("Selector switch") , devices.INTERCOM, device_commands.Button_19, 239, 5, 0.1, nil, {-90, -90}, {-90, -45})
elements["PTR-INTERCOM-CALL"] 	= default_button(_("Call button"), devices.INTERCOM, device_commands.Button_20, 240,1, {0,1})

------------------------------------------------------------------	

------------------------------------------------------------------
--HARS
elements["PTR-HARS-FAST-ERECT"]	 		= default_button(_("HARS Fast Erect"), devices.HARS, device_commands.Button_1, 711, 1, {0, 1})		 
elements["PTR-HARS-CP-SLAVE"]	 		= default_2_position_tumb(_("HARS SLAVE-DG mode"),devices.HARS,device_commands.Button_2, 270)
elements["PTR-HARS-CP-N-S"]	 			= default_2_position_small_tumb(_("HARS N/S toggle switch"),devices.HARS,device_commands.Button_3, 273)
elements["PTR-HARS-CP-MAG-VAR"]			= default_3_position_small_tumb(_("HARS MAG VAR"), devices.HARS, device_commands.Button_4, 272)
elements["PTR-HARS-CP-LATITUDE"] 		= default_axis(_("HARS Latitude Dial")	 ,devices.HARS,device_commands.Button_5, 271, 0.0, nil, nil, nil, nil, {90, -135}, {90, -80} )
elements["PTR-HARS-CP-PUSH-TO-SYNC"]	= default_button_axis(_("HARS Push-To-Sync"),devices.HARS, device_commands.Button_6,device_commands.Button_7, 267, 268, {120, -135}, {60, -80} )
			
------------------------------------------------------------------
-- Secure Voice Comms Panel
elements["PTR-ZEROIZE-COVER"]		= default_2_position_cover(_("Zeroise Cover"),devices.KY_58,device_commands.Button_1,778)
elements["PTR-ZEROIZE-SWITCH"]		= default_2_position_small_tumb(_("Zeroise Switch"),devices.KY_58,device_commands.Button_2,779)
elements["PTR-DELAY-SWITCH"]		= default_2_position_tumb(_("Delay Switch"),devices.KY_58,device_commands.Button_3,780)
elements["PTR-LVR-PANKY58-PLAIN"]   = multiposition_switch_tumb(_("C/RAD switch") , devices.KY_58, device_commands.Button_4, 781, 3, 0.1)
elements["PTR-LVR-PANKY58-1TO5"]   	= multiposition_switch_tumb(_("Full switch") , devices.KY_58, device_commands.Button_5, 782, 6, 0.1)
elements["PTR-LVR-PANKY58-MODE"]   	= multiposition_switch_tumb(_("Mode switch") , devices.KY_58, device_commands.Button_6, 783, 3, 0.1)
elements["PTR-TMB-PANKY58-POWER"]   = default_2_position_tumb(_("Power switch") , devices.KY_58, device_commands.Button_7, 784)

------------------------------------------------------------------
-- Auxiliary Landing Gear Handle						
elements["PTR-ARM-DWNC-L"]	= 	{class  	= {class_type.TUMB, class_type.TUMB},
										 hint   	= _("Auxiliary Landing Gear Handle"), 
										 device 	= devices.CPT_MECH,
										 action 	= {device_commands.Button_8, device_commands.Button_8},
										 arg 		= {718, 718},
										 arg_value 	= {-1, 1},
										 arg_lim 	= {{0, 1}, {0, 1}},
										 updatable  = true, 
										 gain 		= {0.1, 0.1},
										 animated 	= {true, true},
										 animation_speed = {15, 15},
										 side		= {{BOX_SIDE_Y_bottom},{BOX_SIDE_Y_top}},
										 sound		= {{SOUND_SW10_DOWN}}
										 }
										 
elements["PTR-BTN-ARM-DWNC-L"]  = push_button_tumb(_("Auxiliary Landing Gear Handle Lock button") , devices.CPT_MECH, device_commands.Button_9, 722)

------------------------------------------------------------------
-- Arm Seat Handle
elements["PTR-ARM-SEAT-HANDLE"]   = default_2_position_tumb(_("Seat Arm Handle") , devices.CPT_MECH, device_commands.Button_10, 733, {-1, 1}, {{0,1},{0,1}}, 10)
elements["PTR-ARM-SEAT-HANDLE"].sound = {{SOUND_SW10_UP, SOUND_SW10_DOWN}}
elements["PTR-ARM-SEAT-HANDLE"].side = {{BOX_SIDE_Y_bottom},{BOX_SIDE_Y_top}}
------------------------------------------------------------------
-- Extend boarding ladder button
elements["BOARD-LADDER-COVER-PTR"]   = 	default_2_position_cover_plastic(_("Extend boarding ladder cover") , devices.CPT_MECH, device_commands.Button_11, 787)
elements["BOARD-LADDER-BUTTON-PTR"]	 =  default_button(_("Extend boarding ladder button"), devices.CPT_MECH, device_commands.Button_12, 788)	 

------------------------------------------------------------------
-- Accelerometer
elements["ACCEL_KNOB_PTR"]	 =  default_button(_("Push to set"), devices.ACCELEROMETER, device_commands.Button_1, 904)	 

-----------------------------------------------------------------
-- DVADR Remote Control Panel
elements["DVADR-RC-FUNC-CONTROL-SW-PTR"] = default_3_position_small_tumb(_("Function control toggle switch") , devices.DVADR, device_commands.Button_1, 789, false, false, {-0.1,0.1}, {{0,0.2},{0,0.2}}, 2)
elements["DVADR-VIDEO-SW-PTR"]   		 = default_3_position_small_tumb(_("Video selector toggle switch (N/A)") , devices.DVADR, device_commands.Button_2, 790, false, false, {0.1,-0.1}, {{0,0.2},{0,0.2}}, 2)

-----------------------------------------------------------------
-- Anti-G suit valve test button
elements["ANTI-G-VALVE-PTR"]	 =  default_button(_("Anti-G suit valve test button"), devices.ENVIRONMENT_SYSTEM, device_commands.Button_14, 776)	

-----------------------------------------------------------------
-- Internal canopy actuator disengage lever
elements["CANOPY-DISENGAGE-LEVER-PTR"]	= default_animated_lever(_("Internal canopy actuator disengage lever"), devices.CPT_MECH,device_commands.Button_13, 777, nil, nil, 6.5)

-----------------------------------------------------------------
-- Pilot's stick hide/unhide
elements["stick_visibility_PNT"]		= default_2_position_tumb(_("Hide Stick toggle"), devices.CPT_MECH, device_commands.Button_16, 999)
elements["stick_visibility_PNT"].animated = {false, false}

-----------------------------------------------------------------
-- Canopy jettison lever						
elements["PTR-CNP-JETTARM"]	= 	{class  	= {class_type.TUMB, class_type.TUMB},
										 hint   	= _("Canopy jettison lever"), 
										 device 	= devices.CPT_MECH,
										 action 	= {device_commands.Button_14, device_commands.Button_14},
										 arg 		= {785, 785},
										 arg_value 	= {1, -1},
										 arg_lim 	= {{0, 1}, {0, 1}},
										 updatable  = true, 
										 gain 		= {0.1, 0.1},
										 animated 	= {true, true},
										 animation_speed = {15, 15},
										 side		= {{BOX_SIDE_Y_bottom},{BOX_SIDE_Y_top}},
										 sound		= {{SOUND_SW7_UP, SOUND_SW7_DOWN}}
										 }										

elements["PTR-CNP-JETT-BTN"]  = push_button_tumb(_("Canopy Jettison Lever Unlock Button") , devices.CPT_MECH, device_commands.Button_15, 786)
elements["PTR-CNP-JETT-BTN"].sound = {{SOUND_SW3_OFF, SOUND_SW3}}

-----------------------------------------------------------------
-- Antenna Select Panel						
elements["PTR-ANTSP-IFF"] = default_3_position_tumb(		_("IFF antenna switch") , devices.IFF, 		 device_commands.Button_19, 706, false, false, {-0.5,0.5}, {{0,1.0},{0,1.0}}, 12)
elements["PTR-ANTSP-UHF"] = default_3_position_small_tumb(		_("UHF antenna switch") , devices.UHF_RADIO, device_commands.Button_16, 707, false, false, {-0.5,0.5}, {{0,1.0},{0,1.0}}, 12)
elements["PTR-ANTSP-EGI-HQ-TOD"] = default_2_position_tumb( _("EGI HQ TOD") 		, devices.UHF_RADIO, device_commands.Button_17, 708)		
									
----------------------------------------
-- RWR
elements["PNT-LVR-RWR"]	= default_axis_limited(_("Adjust Display Brightness"), devices.AN_ALR69V, device_commands.Button_1, 16, 0.1, false, false, {0.15, 0.85}, nil, {135, -45}, {45,-45})


--Mirrors
elements["PNT-MIRROR-LEFT"]  = default_2_position_tumb(_("Toggle Mirrors"),0,3001,719)
elements["PNT-MIRROR-LEFT"].side = {{BOX_SIDE_Y_bottom},{BOX_SIDE_Z_bottom}}
elements["PNT-MIRROR-LEFT"].animated = {false, false}
elements["PNT-MIRROR-LEFT"].sound = {{SOUND_SW11_UP, SOUND_SW11_DOWN}}
elements["PNT-MIRROR-FRONT"] = default_2_position_tumb(_("Toggle Mirrors"),0,3001,719)
elements["PNT-MIRROR-FRONT"].side = {{BOX_SIDE_Y_bottom},{BOX_SIDE_Z_bottom}}
elements["PNT-MIRROR-FRONT"].animated = {false, false}
elements["PNT-MIRROR-FRONT"].sound = {{SOUND_SW11_UP, SOUND_SW11_DOWN}}
elements["PNT-MIRROR-RIGHT"] = default_2_position_tumb(_("Toggle Mirrors"),0,3001,719)
elements["PNT-MIRROR-RIGHT"].side = {{BOX_SIDE_Y_bottom},{BOX_SIDE_Z_bottom}}
elements["PNT-MIRROR-RIGHT"].animated = {false, false}
elements["PNT-MIRROR-RIGHT"].sound = {{SOUND_SW11_UP, SOUND_SW11_DOWN}}

----------------------------------------
-- Scorpion HMCS
elements["HVI_switch_point"] = default_3_position_tumb(_("Scorpion HMCS Power"), devices.SCORPION_HMCS, device_commands.Button_1, 550)
