dofile(LockOn_Options.script_path.."../../Common/command_defs.lua")
dofile(LockOn_Options.script_path.."../../Common/devices.lua")
dofile(LockOn_Options.script_path.."../../Common/sounds_common.lua")

local gettext = require("i_18n")
_ = gettext.translate

cursor_mode = 
{ 
    CUMODE_CLICKABLE = 0,
    CUMODE_CLICKABLE_AND_CAMERA = 1,
    CUMODE_CAMERA = 2,
};

clickable_mode_initial_status  	= cursor_mode.CUMODE_CLICKABLE
use_pointer_name			   	= true
	
arm_length					   	= 5 --1.1
use_seat_assignments		   	= true

anim_speed_default			   	= 20
anim_speed_default_3_pos_th 	= 24
anim_speed_default_3_pos_mp 	= 10

sounds = 
{
	sound_silence    				= {{SOUND_SILENCE, SOUND_SILENCE},{SOUND_SILENCE, SOUND_SILENCE}},
	--sound_cover      				= {{SOUND_COVER}},
	sound_chute_lever				= {{SOUND_CHUTE_LEVER_DEPLOY, SOUND_CHUTE_LEVER_DETACH}, {SOUND_CHUTE_LEVER_DEPLOY, SOUND_CHUTE_LEVER_DETACH}},
	sound_AB_main_cock_sw_guard		= {{AB_MAIN_COCK_SW_GUARD_OPEN, AB_MAIN_COCK_SW_GUARD_CLOSE}, {AB_MAIN_COCK_SW_GUARD_OPEN, AB_MAIN_COCK_SW_GUARD_CLOSE}},
	sound_stick_uncouple_sw_guard	= {{STICK_UNCOUPLE_SW_GUARD_OPEN, STICK_UNCOUPLE_SW_GUARD_CLOSE}, {STICK_UNCOUPLE_SW_GUARD_OPEN, STICK_UNCOUPLE_SW_GUARD_CLOSE}},
	sound_gear_cover				= {{GEAR_COVER_OPEN, GEAR_COVER_CLOSE}, {GEAR_COVER_OPEN, GEAR_COVER_CLOSE}},
	sound_gear_lever				= {{SOUND_GEAR_LEVER_DOWN, SOUND_GEAR_LEVER_UP}, {SOUND_GEAR_LEVER_DOWN, SOUND_GEAR_LEVER_UP}},
	sound_start_button_cover		= {{START_BUTTON_COVER_OPEN, START_BUTTON_COVER_CLOSE}, {START_BUTTON_COVER_OPEN, START_BUTTON_COVER_CLOSE}},
	sound_jettison_cover			= {{SOUND_JETTISON_COVER_OPEN, SOUND_JETTISON_COVER_CLOSE}, {SOUND_JETTISON_COVER_OPEN, SOUND_JETTISON_COVER_CLOSE}},
	sound_arthur_sw					= {{SOUND_ARTHUR_SW_UP_DOWN, SOUND_ARTHUR_SW_MEDIUM}, {SOUND_ARTHUR_SW_UP_DOWN, SOUND_ARTHUR_SW_MEDIUM}},
	sound_radio_5W_sw				= {{SOUND_RADIO_5W_SW, SOUND_RADIO_5W_SW}, {SOUND_RADIO_5W_SW, SOUND_RADIO_5W_SW}},
	sound_pump_sw					= {{SOUND_PUMP_SW_ON, SOUND_PUMP_SW_OFF}, {SOUND_PUMP_SW_ON, SOUND_PUMP_SW_OFF}},
	sound_battery_sw				= {{SOUND_BATTERY_SW_ON, SOUND_BATTERY_SW_OFF}, {SOUND_BATTERY_SW_ON, SOUND_BATTERY_SW_OFF}},
	sound_feeder_tank_fus_sw		= {{SOUND_FEEDER_TANK_FUS_SW_N, SOUND_FEEDER_TANK_FUS_SW_F}, {SOUND_FEEDER_TANK_FUS_SW_N, SOUND_FEEDER_TANK_FUS_SW_F}},
	sound_crossfeed_sw				= {{SOUND_CROSSFEED_SW_O, SOUND_CROSSFEED_SW_F}, {SOUND_CROSSFEED_SW_O, SOUND_CROSSFEED_SW_F}},
	sound_warning_horn_sw			= {{SOUND_WARNING_HORN_SW_ON, SOUND_WARNING_HORN_SW_OFF}, {SOUND_WARNING_HORN_SW_ON, SOUND_WARNING_HORN_SW_OFF}},
	sound_CB						= {{SOUND_CB_UP, SOUND_CB_DOWN}, {SOUND_CB_UP, SOUND_CB_DOWN}},
	sound_SIL_sw					= {{SOUND_SIL_SW_ON, SOUND_SIL_SW_OFF}, {SOUND_SIL_SW_ON, SOUND_SIL_SW_OFF}},
	sound_ext_lights_sw				= {{SOUND_EXT_LIGHTS_SW_UP, SOUND_EXT_LIGHTS_SW_DOWN}, {SOUND_EXT_LIGHTS_SW_UP, SOUND_EXT_LIGHTS_SW_DOWN}},
	sound_flaps_lever				= {{SOUND_FLAPS_LEVER_DOWN, SOUND_FLAPS_LEVER_UP}, {SOUND_FLAPS_LEVER_DOWN, SOUND_FLAPS_LEVER_UP}},
	sound_sight_wheel				= {{SOUND_SIGHT_WHEEL_UP, SOUND_SIGHT_WHEEL_DOWN}, {SOUND_SIGHT_WHEEL_UP, SOUND_SIGHT_WHEEL_DOWN}},
	sound_radar_stick_select_sw		= {{SOUND_RADAR_STICK_SELECT_SW_L, SOUND_RADAR_STICK_SELECT_SW_R}, {SOUND_RADAR_STICK_SELECT_SW_L, SOUND_RADAR_STICK_SELECT_SW_R}},
	sound_omnibearing_sel_mode		= {{SOUND_OMNIBEARING_SEL_MODE_CCW, SOUND_OMNIBEARING_SEL_MODE_CW}, {SOUND_OMNIBEARING_SEL_MODE_CCW, SOUND_OMNIBEARING_SEL_MODE_CW}},
	sound_tacan_channel_sel			= {{SOUND_TACAN_CHANNEL_SEL_CW, SOUND_TACAN_CHANNEL_SEL_CCW}, {SOUND_TACAN_CHANNEL_SEL_CW, SOUND_TACAN_CHANNEL_SEL_CCW}},
	sound_iff_mode_sel_sw			= {{SOUND_IFF_MODE_SEL_SW, SOUND_IFF_MODE_SEL_SW}, {SOUND_IFF_MODE_SEL_SW, SOUND_IFF_MODE_SEL_SW}},
	sound_iff_M1_sw					= {{SOUND_IFF_M1_SW_UP, SOUND_IFF_M1_SW_DOWN}, {SOUND_IFF_M1_SW_UP, SOUND_IFF_M1_SW_DOWN}},
	sound_iff_ident_sw				= {{SOUND_IFF_IDENT_SW_UP, SOUND_IFF_IDENT_SW_DOWN}, {SOUND_IFF_IDENT_SW_UP, SOUND_IFF_IDENT_SW_DOWN}},
	sound_day_night_sel_sw			= {{SOUND_DAY_NIGHT_SEL_SW_CW, SOUND_DAY_NIGHT_SEL_SW_CCW}, {SOUND_DAY_NIGHT_SEL_SW_CW, SOUND_DAY_NIGHT_SEL_SW_CCW}},
	sound_channel_sel				= {{SOUND_CHANNEL_SEL_CW, SOUND_CHANNEL_SEL_CCW}, {SOUND_CHANNEL_SEL_CW, SOUND_CHANNEL_SEL_CCW}},
	sound_freq_sel					= {{SOUND_FREQ_SEL_UP, SOUND_FREQ_SEL_DOWN}, {SOUND_FREQ_SEL_UP, SOUND_FREQ_SEL_DOWN}},
	sound_IDN_mode_sel				= {{SOUND_IDN_MODE_SEL, SOUND_IDN_MODE_SEL}, {SOUND_IDN_MODE_SEL, SOUND_IDN_MODE_SEL}},
	sound_IDN_vect_add_sw			= {{SOUND_IDN_VECT_ADD_SW, SOUND_IDN_VECT_ADD_SW}, {SOUND_IDN_VECT_ADD_SW, SOUND_IDN_VECT_ADD_SW}},
	sound_rudder_trim_sw			= {{SOUND_RUDDER_TRIM_SW_LEFT, SOUND_RUDDER_TRIM_SW_CENTER}, {SOUND_RUDDER_TRIM_SW_CENTER, SOUND_RUDDER_TRIM_SW_RIGHT}},
	sound_souris_sw					= {{SOUND_SOURIS_SW_CENTER, SOUND_SOURIS_SW_DOWN}, {SOUND_SOURIS_SW_UP, SOUND_SOURIS_SW_CENTER}},
	sound_conv_sw					= {{SOUND_CONV_SW_CENTER, SOUND_CONV_SW_DOWN}, {SOUND_CONV_SW_UP, SOUND_CONV_SW_CENTER}},
	sound_iff_ident_sw				= {{SOUND_IFF_IDENT_SW_CENTER, SOUND_IFF_IDENT_SW_DOWN}, {SOUND_IFF_IDENT_SW_UP, SOUND_IFF_IDENT_SW_CENTER}},
	sound_souris_btn				= {{SOUND_SOURIS_BTN_OUT, SOUND_SOURIS_BTN_PRESS}, {SOUND_SOURIS_BTN_OUT, SOUND_SOURIS_BTN_PRESS}},
	sound_EFF_sw					= {{SOUND_EFF_SW_UP, SOUND_EFF_SW_DOWN}, {SOUND_EFF_SW_UP, SOUND_EFF_SW_DOWN}},
	sound_emerg_reg_lever			= {{SOUND_EMERG_REG_LEVER_BCK, SOUND_EMERG_REG_LEVER_BCK_CTR}, {SOUND_EMERG_REG_LEVER_FWRD_CTR, SOUND_EMERG_REG_LEVER_FWRD}},
	sound_IDN_add_tgt_sel			= {{SOUND_IDN_ADD_TGT_SEL, SOUND_IDN_ADD_TGT_SEL}, {SOUND_IDN_ADD_TGT_SEL, SOUND_IDN_ADD_TGT_SEL}},
	sound_oxy_mode_sel				= {{SOUND_OXY_MODE_SEL, SOUND_OXY_MODE_SEL}, {SOUND_OXY_MODE_SEL, SOUND_OXY_MODE_SEL}},
	sound_in_flight_relight			= {{SOUND_IN_FLIGHT_RELIGHT_FWRD, SOUND_IN_FLIGHT_RELIGHT_AFT}, {SOUND_IN_FLIGHT_RELIGHT_AFT, SOUND_IN_FLIGHT_RELIGHT_FWRD}},
	sound_throttle_cut_idle_sw		= {{SOUND_THROTTLE_CUT_IDLE_SW_UP, SOUND_THROTTLE_CUT_IDLE_SW_DOWN}, {SOUND_THROTTLE_CUT_IDLE_SW_DOWN, SOUND_THROTTLE_CUT_IDLE_SW_UP}},
	sound_radar_function_sel		= {{SOUND_RADAR_FUNCTION_SEL_CW, SOUND_RADAR_FUNCTION_SEL_CCW}, {SOUND_RADAR_FUNCTION_SEL_CW, SOUND_RADAR_FUNCTION_SEL_CCW}},
	sound_VOR_ILS_test_sel			= {{SOUND_VOR_ILS_TEST_SEL_OFF, SOUND_VOR_ILS_TEST_SEL_ON}, {SOUND_VOR_ILS_TEST_SEL_ON, SOUND_VOR_ILS_TEST_SEL_OFF}},
	sound_canopy_embrittle_ctrl		= {{SOUND_CANOPY_EMBRITTLE_CTRL_FWD, SOUND_CANOPY_EMBRITTLE_CTRL_AFT}, {SOUND_CANOPY_EMBRITTLE_CTRL_AFT, SOUND_CANOPY_EMBRITTLE_CTRL_FWD}},
	sound_RWR_T_test				= {{SOUND_RWR_T_TEST_CW, SOUND_RWR_T_TEST_CCW}, {SOUND_RWR_T_TEST_CW, SOUND_RWR_T_TEST_CCW}},
	sound_RWR_test					= {{SOUND_RWR_TEST_CENTER, SOUND_RWR_TEST_UP}, {SOUND_RWR_TEST_DOWN, SOUND_RWR_TEST_CENTER}},
	sound_canopy_seal_lever			= {{SOUND_CANOPY_SEAL_LEVER, SOUND_CANOPY_SEAL_LEVER}, {SOUND_CANOPY_SEAL_LEVER, SOUND_CANOPY_SEAL_LEVER}},
	sound_intercom_pushbutton		= {{SOUND_INTERCOM_PUSHBUTTON_IN, SOUND_INTERCOM_PUSHBUTTON_OUT}, {SOUND_INTERCOM_PUSHBUTTON_OUT, SOUND_INTERCOM_PUSHBUTTON_IN}},
	sound_emerg_gear_ext			= {{SOUND_EMERG_GEAR_EXT_OUT, SOUND_EMERG_GEAR_EXT_IN}, {SOUND_EMERG_GEAR_EXT_OUT, SOUND_EMERG_GEAR_EXT_IN}},
	sound_parking_brk				= {{SOUND_PARKING_BRK_OUT, SOUND_PARKING_BRK_IN}, {SOUND_PARKING_BRK_OUT, SOUND_PARKING_BRK_IN}},	
}

function selectParameter(default_val, from_param)
	local res 					= default_val
	
	if from_param ~= nil then
		res						= from_param
	end
	
	return res
end

function default_button(hint_, seat_, device_, command_, arg_, arg_val_, arg_lim_, release_message_, sound_, animated_, anim_speed_)
	local arg_val				= selectParameter(1, arg_val_)
	local arg_lim				= selectParameter({0, 1}, arg_lim_)
	local release_message		= selectParameter(true, release_message_)
	local animated				= selectParameter(false, animated_)
	local animation_speed		= selectParameter(anim_speed_default, anim_speed_)
	
	local res = {
		class 					= {class_type.BTN, class_type.BTN},
		hint  					= hint_,
		device 					= device_,
		action 					= {command_, command_},
		stop_action 			= {command_, command_},
		arg 					= {arg_, arg_},
		arg_value				= {arg_val, arg_val}, 
		arg_lim 				= {arg_lim, arg_lim},
		use_release_message 	= {release_message, release_message},
		sound               	= sound_,
		animated				= {animated, animated},
		animation_speed 		= {animation_speed, animation_speed},
		side					= {{BOX_SIDE_Y_bottom}, {BOX_SIDE_Y_bottom}},
	}
	
	if use_seat_assignments == true then
		res.crew_member_access 	= {seat_ or 0}
	end
	
	return res
end

-- 2 positions, springloaded to OFF (0.0) position, argument range 0..1, is mechanically or electrically retained in ON (1.0) position
function springloadedAndRetained_2pos_switch(hint_, seat_, device_, command_, release_command_, arg_, arg_val_, arg_lim_, sound_, animated_, anim_speed_)
	local res 					= default_button(hint_, seat_, device_, command_, arg_, arg_val_, arg_lim_, true, sound_, animated_, anim_speed_)
	res.stop_action 			= {release_command_, release_command_}
	res.updatable 				= true
	
	return res
end

function default_2_position_tumb(hint_, seat_, device_, command_, arg_, arg_val_, arg_lim_, cycled_, inversed_, sound_, animated_, anim_speed_)
	local dir 					= 1
	if inversed_ then
		dir 					= -1
	end
	
	local arg_val				= selectParameter(1, arg_val_)
	local arg_lim				= selectParameter({0, 1}, arg_lim_)
	local cycled				= selectParameter(true, cycled_)
	local animated				= selectParameter(true, animated_)
	local animation_speed		= selectParameter(anim_speed_default, anim_speed_)
	
	local res = {
		class 					= {class_type.TUMB, class_type.TUMB},
		hint  					= hint_,
		device 					= device_,
		action 					= {command_, command_},
		arg 	  				= {arg_, arg_},
		arg_value 				= {arg_val * dir, arg_val * -dir}, 
		arg_lim   				= {arg_lim, arg_lim},
		updatable 				= true,
		use_OBB 				= true,
		cycle       			= cycled,
		sound       			= sound_,
		animated				= {animated, animated},
		animation_speed 		= {animation_speed, animation_speed},
		side					= {{BOX_SIDE_Z_top},{BOX_SIDE_Z_bottom}},
	}
	
	if use_seat_assignments == true then
		res.crew_member_access 	= {seat_ or 0}
	end
	
	return res
end

function default_3_position_tumb(hint_, seat_, device_, command_, arg_, cycled_, inversed_, arg_val_, arg_lim_, sound_, anim_speed_)
	local arg_val				= selectParameter(1, arg_val_)
	local arg_lim				= selectParameter({-1, 1}, arg_lim_)
	
	local side_					= {{BOX_SIDE_Z_top},{BOX_SIDE_Z_bottom}}
	
	if inversed_ then
	    arg_val 				= -arg_val
	end
	
	local cycled				= selectParameter(false, cycled_)
	local animation_speed		= selectParameter(anim_speed_default_3_pos_th, anim_speed_)
	
	local res = {
		class 					= {class_type.TUMB, class_type.TUMB},
		hint  					= hint_,
		device 					= device_,
		action 					= {command_, command_},
		arg 	  				= {arg_, arg_},
		arg_value 				= {-arg_val, arg_val},
		arg_lim   				= {arg_lim, arg_lim},
		updatable 				= true, 
		use_OBB 				= true,
		cycle       			= cycled,
		sound       			= sound_,
		animated				= {true, true},
		animation_speed 		= {animation_speed, animation_speed},
		side					= side_,
	}
	
	if use_seat_assignments == true then
		res.crew_member_access 	= {seat_ or 0}
	end
	
	return res
end

function default_axis(hint_, seat_, device_, command_, arg_, arg_val_, gain_, updatable_, relative_, attach_left_, attach_right_, sound_)
	local arg_val				= selectParameter(1, arg_val_)
	local gain					= selectParameter(0.1, gain_)
	local updatable				= selectParameter(false, updatable_)
	local relative				= selectParameter(false, relative_)
	
	local res = {			
		class 					= {class_type.LEV},
		hint  					= hint_,
		device 					= device_,
		action 					= {command_},
		arg 	  				= {arg_},
		arg_value 				= {arg_val}, 
		arg_lim   				= {{0, 1}},
		updatable 				= updatable, 
		use_OBB 				= true,
		gain					= {gain},
		relative    			= {relative},
		side					= {{BOX_SIDE_X_top, BOX_SIDE_X_bottom, BOX_SIDE_Z_top, BOX_SIDE_Z_bottom}},
		attach_left				= attach_left_,
		attach_right			= attach_right_,
		sound       			= sound_,
	}
	
	if use_seat_assignments == true then
		res.crew_member_access 	= {seat_ or 0}
	end
	
	return res
end

function default_axis_limited(hint_, seat_, device_, command_, arg_, arg_val_, gain_, arg_lim_, updatable_, relative_, attach_left_, attach_right_)
	local arg_val				= selectParameter(1, arg_val_)
	local arg_lim				= selectParameter({0, 1}, arg_lim_)
	local gain					= selectParameter(0.1, gain_)
	local updatable				= selectParameter(false, updatable_)
	local relative				= selectParameter(false, relative_)
	
	local res = {		
		class 					= {class_type.LEV},
		hint  					= hint_,
		device 					= device_,
		action 					= {command_},
		arg 	  				= {arg_},
		arg_value 				= {arg_val}, 
		arg_lim   				= {arg_lim},
		updatable 				= updatable,
		use_OBB 				= true,
		gain					= {gain},
		relative    			= {relative},
		cycle					= false,
		side					= {{BOX_SIDE_X_top, BOX_SIDE_X_bottom, BOX_SIDE_Z_top, BOX_SIDE_Z_bottom}},
		attach_left				= attach_left_,
		attach_right			= attach_right_,
	}
	
	if use_seat_assignments == true then
		res.crew_member_access 	= {seat_ or 0}
	end
	
	return res
end

function default_movable_axis(hint_, seat_, device_, command_, arg_, arg_val_, gain_, updatable_, relative_, arg_lim_)
	local arg_val				= selectParameter(1, arg_val_)
	local arg_lim				= selectParameter({0, 1}, arg_lim_)
	local gain					= selectParameter(0.1, gain_)
	local updatable				= selectParameter(true, updatable_)
	local relative				= selectParameter(false, relative_)
	
	local res = {			
		class 					= {class_type.MOVABLE_LEV, class_type.MOVABLE_LEV},
		hint  					= hint_,
		device 					= device_,
		action 					= {command_, command_},
		arg 	  				= {arg_, arg_},
		arg_value 				= {-arg_val, arg_val}, 
		arg_lim   				= {arg_lim, arg_lim},
		updatable 				= updatable,
		use_OBB 				= true,
		gain					= {gain, gain},
		relative    			= {relative, relative},
		side					= {{BOX_SIDE_Z_top}, {BOX_SIDE_Z_bottom}},
	}
	
	if use_seat_assignments == true then
		res.crew_member_access 	= {seat_ or 0}
	end
	
	return res
end

function multiposition_switch(hint_, seat_, device_, command_, arg_, count_, delta_, cycled_, inversed_, min_, sound_, animated_, anim_speed_, attach_left_, attach_right_)
	local min__   				= selectParameter(0, min_)
	local delta 				= selectParameter(0.5, delta_)
	local cycled				= selectParameter(false, cycled_)
	local animated				= selectParameter(true, animated_)
	local animation_speed		= selectParameter(anim_speed_default_3_pos_mp, anim_speed_)
	
	local sign 					= 1
	if inversed_ == true then
		sign 					= -1
	end
		
	local res = {
		class 					= {class_type.TUMB,class_type.TUMB},
		hint  					= hint_,
		device 					= device_,
		action 					= {command_, command_},
		arg 	  				= {arg_, arg_},
		arg_value 				= {-delta * sign, delta * sign}, 
		arg_lim   				= {{min__, min__ + delta * (count_ - 1)}, {min__, min__ + delta * (count_ - 1)}},
		updatable 				= true, 
		use_OBB 				= true,
		cycle     				= cycled,
		sound       			= sound_,
		animated				= {animated, animated},
		animation_speed 		= {animation_speed, animation_speed},
		side					= {{0},{BOX_SIDE_X_top, BOX_SIDE_X_bottom, BOX_SIDE_Z_top, BOX_SIDE_Z_bottom}},
		attach_left				= attach_left_,
		attach_right			= attach_right_,
	}
	
	if use_seat_assignments == true then
		res.crew_member_access 	= {seat_ or 0}
	end
	
	return res
end

function multiposition_switch_cycled_relative(hint_, seat_, device_, command_, arg_, count_, delta_, inversed_, min_, sound_, animation_speed_, attach_left_, attach_right_)
	local element 				= multiposition_switch(hint_, seat_, device_, command_, arg_, count_, delta_, true, inversed_, min_, sound_, true, animation_speed_, attach_left_, attach_right_)
	element.relative 			= {true, true}
	--element.anim_close_ends	= {true, true}
    return element
end

function default_button_axis(hint_, seat_, device_, command_1_, command_2_, arg_1_, arg_2_, limit_1_, limit_2_, sound_, attach_left_, attach_right_)
	local limit_1				= selectParameter(1, limit_1_)
	local limit_2				= selectParameter(1, limit_2_)
	
	local res = {
		class					= {class_type.BTN, class_type.LEV},
		hint					= hint_,
		device					= device_,
		action					= {command_1_, command_2_},
		stop_action 			= {command_1_, 0},
		arg						= {arg_1_, arg_2_},
		arg_value				= {1, 0.5},
		arg_lim					= {{0, limit_1}, {0, limit_2}},
		--animated        		= {false, true},
		--animation_speed 		= {0, 0.4},
		gain 					= {0, 0.5},
		relative				= {false, false},
		--updatable 			= true,
		use_OBB 				= true,
		use_release_message 	= {true, false},
		cycle 					= false,
		sound       			= sound_,
		side					= {{BOX_SIDE_Y_bottom}, {BOX_SIDE_X_top, BOX_SIDE_X_bottom, BOX_SIDE_Z_top, BOX_SIDE_Z_bottom}},
		attach_left				= attach_left_,
		attach_right			= attach_right_,
	}
	
	if use_seat_assignments == true then
		res.crew_member_access 	= {seat_ or 0}
	end
	
	return res
end

function default_button_tumb(hint_, seat_, device_, command1_, command2_, arg_, inversed_, sound_, animated_, anim_speed_)
	local arg_lim_btn			= {-1, 0}
	local arg_lim_tumb          = {0, 1}
	local arg_val             	= {-1, 1}
	local side 					= {{BOX_SIDE_Z_top},{BOX_SIDE_Z_bottom}}
	
	if inversed_ == true then
		arg_lim_btn 			= {0, 1}
		arg_lim_tumb  			= {-1, 0}
		arg_val 				= {1, -1}
	end
	
	local animated 				= selectParameter(true, animated_)
	local animation_speed		= selectParameter(anim_speed_default, anim_speed_)
	
	local res = {
		class 					= {class_type.BTN, class_type.TUMB},
		hint  					= hint_,
		device 					= device_,
		action 					= {command1_,command2_},
		stop_action 			= {command1_, 0},
		arg 	  				= {arg_,arg_},
		arg_value 				= arg_val, 
		arg_lim   				= {arg_lim_btn, arg_lim_tumb},
		updatable 				= true, 
		use_OBB 				= true,
		cycle       			= true,
		use_release_message 	= {true, false},
		sound       			= sound_,
		animated				= {animated, animated},
		animation_speed 		= {animation_speed, animation_speed},
		size					= side,
	}
	
	if use_seat_assignments == true then
		res.crew_member_access 	= {seat_ or 0}
	end
	
	return res
end

function default_tumb_button(hint_, seat_, device_, command1_, command2_, arg_, inversed_, sound_, animated_, anim_speed_)
	
	local arg_lim_tumb          = {-1, 0}
	local arg_lim_btn			= {0, 1}
	local arg_val             	= {-1, 1}
	local side 					= {{BOX_SIDE_Z_top},{BOX_SIDE_Z_bottom}}
	
	if inversed_ == true then
		arg_lim_tumb  			= {0, 1}
		arg_lim_btn 			= {-1, 0}
		arg_val 				= {1, -1}
	end
	
	local animated 				= selectParameter(true, animated_)
	local animation_speed		= selectParameter(anim_speed_default, anim_speed_)
	
	local res = {
		class 					= {class_type.TUMB, class_type.BTN},
		hint  					= hint_,
		device 					= device_,
		action 					= {command1_, command2_},
		stop_action 			= {0, command2_},
		arg 	  				= {arg_,arg_},
		arg_value 				= arg_val, 
		arg_lim   				= {arg_lim_tumb, arg_lim_btn},
		--updatable				= true, 
		--use_OBB 				= true,
		cycle       			= true,
		use_release_message 	= {true, false},
		sound       			= sound_,
		animated				= {animated, animated},
		animation_speed 		= {animation_speed, animation_speed},
		size					= side,
	}
	
	if use_seat_assignments == true then
		res.crew_member_access 	= {seat_ or 0}
	end
	
	return res
end

-- 3 positions, springloaded to center, argument range -1..1, center position - 0
function springloaded_2pos_switch(hint_, seat_, device_, command1_, command2_, arg_, inversed_, anim_speed_, sound_)
	
	local arg_val				= {-1, 1}
	local arg_lim               = {{-1, 0}, {0, 1}}
	local side 					= {{BOX_SIDE_Z_top},{BOX_SIDE_Z_bottom}}
	
	if inversed_ == true then
		arg_val 				= {1, -1}
		arg_lim   				= {{0, 1}, {-1, 0}}
	end
	
	local animation_speed		= selectParameter(anim_speed_default_3_pos_th, anim_speed_)
	
	local res = {
		class 					= {class_type.BTN, class_type.BTN},
		hint  					= hint_,
		device 					= device_,
		action 					= {command1_, command2_},
		stop_action 			= {command1_, command2_},
		arg 	  				= {arg_, arg_},
		arg_value 				= arg_val, 
		arg_lim   				= arg_lim,
		--updatable				= true, 
		--use_OBB 				= true,
		use_release_message 	= {true, true},
		animated				= {true, true},
		animation_speed 		= {animation_speed, animation_speed},
		size					= side,
		sound       			= sound_,
	}

	if use_seat_assignments == true then
		res.crew_member_access 	= {seat_ or 0}
	end
	
	return res
end

function circuit_breaker(hint_, seat_, device_, command_, arg_, arg_val_, arg_lim_, cycled_, inversed_, sound_, animated_, anim_speed_)
	local element 				= default_2_position_tumb(hint_, seat_, device_, command_, arg_, arg_val_, arg_lim_, cycled_, inversed_, sound_, animated_, anim_speed_)
	element.side				= {{BOX_SIDE_Y_bottom}, {BOX_SIDE_Y_bottom}}
    return element
end

function guard_switch(hint_, seat_, device_, command_, arg_, inversed_, sound_, animated_, anim_speed_, attach_left_, attach_right_)
	local guard_sw 				= multiposition_switch(hint_, seat_, device_, command_, arg_, 2, 0.01, true, inversed_, 0, sound_, animated_, anim_speed_, attach_left_, attach_right_)
	guard_sw.arg_lim 			= {{0, 1}, {0, 1}}
	guard_sw.animation_speed 	= {15, 15}
	guard_sw.side				= {{BOX_SIDE_Z_bottom},{BOX_SIDE_Y_bottom}}
	return guard_sw
end

function intercom_rotate_tumb(hint_, seat_, device_, command_1, command_2, arg_1, arg_2, attach_left_, attach_right_, sound_)
	local res = {
		class					= {class_type.TUMB, class_type.TUMB, class_type.LEV},
		hint					= hint_,
		device					= device_,
		action					= {command_1, command_1, command_2},
		arg						= {arg_1, arg_1, arg_2},
		arg_value				= {1, 1, 1},
		arg_lim					= {{0, 1}, {0, 1}, {0,1}},
		--animated        		= {false,false,false},
		--animation_speed 		= {0, 0, 0.5},
		relative				= {false, false, false},
		updatable 				= false, 
		use_OBB 				= false,
		gain 					= {1.0, 1.0, 0.1},
		cycle 					= false,
		side					= {{BOX_SIDE_Y_bottom}, {BOX_SIDE_X_top, BOX_SIDE_X_bottom, BOX_SIDE_Z_top, BOX_SIDE_Z_bottom}},
		attach_left				= attach_left_,
		attach_right			= attach_right_,
		sound       			= sound_,		
	}
	
	if use_seat_assignments == true then
		res.crew_member_access  = {seat_ or 0}
	end
	
	return res
end

function standbyHorizonUncageAndPitchCtrlKnob(hint_, seat_, device_, command_1_, release_command_1_, command_2_, arg_1_, arg_2_, sound_, animated_, anim_speed_, attach_left_, attach_right_)
	
	local animated 				= selectParameter(true, animated_)
	local animation_speed		= selectParameter(anim_speed_default, anim_speed_)
	
	local res = {
		class					= {class_type.BTN, class_type.LEV},
		hint					= hint_,
		device					= device_,
		action					= {command_1_, command_2_},
		stop_action 			= {release_command_1_, 0},
		arg						= {arg_1_, arg_2_},
		arg_value				= {1, 0.5},
		arg_lim					= {{0, 1}, {0, 1}},
		animated        		= {animated, false},
		animation_speed 		= {animation_speed, 0},
		gain 					= {0, 0.5},
		relative				= {false, false},
		--updatable 			= true,
		use_OBB 				= true,
		use_release_message 	= {true, false},
		cycle 					= false,
		sound       			= sound_,
		side					= {{BOX_SIDE_Y_bottom}, {BOX_SIDE_X_top, BOX_SIDE_X_bottom, BOX_SIDE_Z_top, BOX_SIDE_Z_bottom}},
		attach_left				= attach_left_,
		attach_right			= attach_right_,
	}
	
	if use_seat_assignments == true then
		res.crew_member_access 	= {seat_ or 0}
	end
	
	return res
end


elements = {}

-----------------------------------------------------------------
-- Pilot's stick hide/unhide
elements["PNT-34"]	= default_2_position_tumb(_("Hide Stick toggle"), 0, devices.MAIN, devCmds.Cmd1, 34, 1, {0, 1}, true, false, sounds.sound_silence, false)

----------------------------------------------------------------
-- Incidence test switch
elements["PNT-98"] = springloaded_2pos_switch(_("Incidence test switch"), 0, devices.MAIN, devCmds.Cmd11, devCmds.Cmd10, 98, nil, nil, sounds.sound_iff_ident_sw)

----------------------------------------------------------------
-- Flying aid and autopilot interlocks test display unit.

-- Flight control test restart button
elements["PNT-368"] = default_button(_("Flight control test restart button"), 0, devices.MAIN, devCmds.Cmd12, 368)
-- Flight control test switch guard
elements["PNT-369"] = guard_switch(_("Flight control test switch guard"), 0, devices.MAIN, devCmds.Cmd13, 369, false, sounds.sound_AB_main_cock_sw_guard)
-- Flight control test switch
elements["PNT-370"] = default_2_position_tumb(_("Flight control test switch"), 0, devices.MAIN, devCmds.Cmd14, 370, nil, nil, nil, nil, sounds.sound_warning_horn_sw)

----------------------------------------------------------------
-- Flight Control System controls

-- Servo reset button
elements["PNT-89"] = default_button(_("Servo reset button"), 0, devices.MAIN, devCmds.Cmd20, 89)
-- Stick uncouple switch
elements["PNT-97"] = default_2_position_tumb(_("Stick uncouple switch"), 0, devices.MAIN, devCmds.Cmd21, 97, nil, nil, nil, nil, sounds.sound_arthur_sw)
-- Stick uncouple switch guard
elements["PNT-95"] = guard_switch(_("Stick uncouple switch guard"), 0, devices.MAIN, devCmds.Cmd22, 95, true, sounds.sound_stick_uncouple_sw_guard)
-- ARTHUR selector switch guard
elements["PNT-94"] = guard_switch(_("ARTHUR selector switch guard"), 0, devices.MAIN, devCmds.Cmd23, 94, true, sounds.sound_stick_uncouple_sw_guard)
-- ARTHUR selector switch
elements["PNT-96"] = multiposition_switch(_("ARTHUR selector switch"), 0, devices.MAIN, devCmds.Cmd24, 96, 3, 0.5, false, true, 0, sounds.sound_arthur_sw, true, anim_speed_default_3_pos_mp)
-- Yaw/Anti-slip switch
elements["PNT-90"] = multiposition_switch(_("Yaw/Anti-slip switch"), 0, devices.MAIN, devCmds.Cmd25, 90, 3, 0.5, false, false, 0, sounds.sound_arthur_sw, true, anim_speed_default_3_pos_mp)
-- Pitch switch
elements["PNT-91"] = default_2_position_tumb(_("Pitch switch"), 0, devices.MAIN, devCmds.Cmd26, 91, 1, {0, 1}, true, true, sounds.sound_arthur_sw)
-- Rudder trim control switch
elements["PNT-406"] = springloaded_2pos_switch(_("Rudder trim control switch"), 0, devices.MAIN, devCmds.Cmd27, devCmds.Cmd28, 406, true, nil, sounds.sound_rudder_trim_sw)

-- Autopilot PA button
elements["PNT-974"] = default_button(_("Autopilot PA button"), 0, devices.MAIN, devCmds.Cmd35, 974)
-- Autopilot ALT button
elements["PNT-977"] = default_button(_("Autopilot ALT button"), 0, devices.MAIN, devCmds.Cmd36, 977)
-- Autopilot CAP button
elements["PNT-980"] = default_button(_("Autopilot CAP button"), 0, devices.MAIN, devCmds.Cmd37, 980)
-- Autopilot R button
elements["PNT-982"] = default_button(_("Autopilot R button"), 0, devices.MAIN, devCmds.Cmd38, 982)
-- Autopilot G button
elements["PNT-987"] = default_button(_("Autopilot G button"), 0, devices.MAIN, devCmds.Cmd39, 987)
-- Autopilot intensity control
elements["PNT-992"] = default_axis_limited(_("Autopilot intensity control"), 0, devices.MAIN, devCmds.Cmd41, 992)
-- Autopilot control and indicator unit test button
elements["PNT-973"] = default_button(_("Autopilot control and indicator unit test button"), 0, devices.MAIN, devCmds.Cmd42, 973)

----------------------------------------------------------------
-- Engine and fuel controls

-- Throttle idle detent

local cutIdleRange = 11.65 / 90.0

--[[
local cutIdleText = _("Move throttle cut/idle")
local cutIdleArg = 234

elements["PNT-234-1"] = default_2_position_tumb(cutIdleText, 0, devices.MAIN, devCmds.Cmd49, cutIdleArg, cutIdleRange, {0.0, cutIdleRange}, true, false, nil, false)
elements["PNT-234-2"] = default_2_position_tumb(cutIdleText, 0, devices.MAIN, devCmds.Cmd50, cutIdleArg, cutIdleRange, {0.0, cutIdleRange}, true, false, nil, false)
--]]

elements["PNT-234-1"] = default_2_position_tumb(_("Move throttle cut/idle"), 0, devices.MAIN, devCmds.Cmd49, 234, cutIdleRange, {0.0, cutIdleRange}, true, false, nil, true, 1)

-- Throttle cut/idle switch
elements["PNT-239"] = default_button(_("Throttle cut/idle switch"), 0, devices.MAIN, devCmds.Cmd51, 239, 1, {0, 1}, true, sounds.sound_throttle_cut_idle_sw, true)
-- Engine restart switch
elements["PNT-240"] = springloadedAndRetained_2pos_switch(_("In-flight relight control"), 0, devices.MAIN, devCmds.Cmd52, devCmds.Cmd53, 240, nil, nil, sounds.sound_in_flight_relight, true, 12)
-- Ignition/Ventilation selector switch - 'R/H', 'L/H', 'Ventil'
elements["PNT-376"] = default_3_position_tumb(_("Ignition/Ventilation selector switch"), 0, devices.MAIN, devCmds.Cmd54, 376, false, true, nil, nil, sounds.sound_arthur_sw)
-- Start button cover
elements["PNT-374"] = guard_switch(_("Start button cover"), 0, devices.MAIN, devCmds.Cmd55, 374, true, sounds.sound_start_button_cover)	
-- Start button
elements["PNT-375"] = default_button(_("Start button"), 0, devices.MAIN, devCmds.Cmd56, 375)
-- LP main cock switch guard
elements["PNT-380"] = guard_switch(_("LP main cock switch guard"), 0, devices.MAIN, devCmds.Cmd57, 380, false, sounds.sound_AB_main_cock_sw_guard)
-- LP main cock switch
elements["PNT-381"] = default_2_position_tumb(_("LP main cock switch"), 0, devices.MAIN, devCmds.Cmd58, 381, nil, nil, nil, nil, sounds.sound_pump_sw)
-- JPT emergency regulation switch
elements["PNT-396"] = default_2_position_tumb(_("JPT emergency regulation switch"), 0, devices.MAIN, devCmds.Cmd62, 396, nil, nil, nil, nil, sounds.sound_arthur_sw)
-- A/B main cock switch guard
elements["PNT-397"] = guard_switch(_("A/B main cock switch guard"), 0, devices.MAIN, devCmds.Cmd63, 397, true, sounds.sound_AB_main_cock_sw_guard)
-- A/B main cock switch
elements["PNT-398"] = default_2_position_tumb(_("A/B main cock switch"), 0, devices.MAIN, devCmds.Cmd64, 398, 1, {0, 1}, true, true, sounds.sound_warning_horn_sw)
-- Starting pump switch
elements["PNT-377"] = default_2_position_tumb(_("Starting pump switch"), 0, devices.MAIN, devCmds.Cmd65, 377, 1, {0, 1}, true, true, sounds.sound_pump_sw)
-- R/H LP pump switch
elements["PNT-378"] = default_2_position_tumb(_("R/H LP pump switch"), 0, devices.MAIN, devCmds.Cmd66, 378, 1, {0, 1}, true, true, sounds.sound_pump_sw)
-- L/H LP pump switch
elements["PNT-379"] = default_2_position_tumb(_("L/H LP pump switch"), 0, devices.MAIN, devCmds.Cmd67, 379, 1, {0, 1}, true, true, sounds.sound_pump_sw)
-- Shock-cone manual control switch
elements["PNT-754"] = springloaded_2pos_switch(_("Shock-cone manual control switch"), 0, devices.MAIN, devCmds.Cmd69, devCmds.Cmd68, 754, false, nil, sounds.sound_souris_sw)
-- Shock-cone pushbutton
elements["PNT-755"] = springloadedAndRetained_2pos_switch(_("Shock-cone pushbutton"), 0, devices.MAIN, devCmds.Cmd70, devCmds.Cmd71, 755, nil, nil, sounds.sound_souris_btn, true, 40)
-- Firing fuel dipper switch
elements["PNT-591"] = default_2_position_tumb(_("Firing fuel dipper switch"), 0, devices.MAIN, devCmds.Cmd72, 591, nil, nil, nil, nil, sounds.sound_warning_horn_sw)

----------------------------------------------------------------
-- Fuel quantity indicator

-- Feeder tank/Fuselage selector switch
elements["PNT-1144"] = default_2_position_tumb(_("Feeder tank/Fuselage selector switch"), 0, devices.MAIN, devCmds.Cmd75, 1144, 1, {0, 1}, true, true, sounds.sound_feeder_tank_fus_sw)
-- Fuel gauge test button
elements["PNT-1145"] = default_button(_("Fuel gauge test button"), 0, devices.MAIN, devCmds.Cmd76, 1145)

----------------------------------------------------------------
-- Jettisoning panel

-- Emergency jettison button guard
elements["PNT-966"] = guard_switch(_("Emergency jettison button guard"), 0, devices.MAIN, devCmds.Cmd77, 966, false, sounds.sound_jettison_cover)
-- Emergency jettison button
elements["PNT-967"] = default_button(_("Emergency jettison button"), 0, devices.MAIN, devCmds.Cmd78, 967)
-- Selective jettison button guard
elements["PNT-968"] = guard_switch(_("Selective jettison button guard"), 0, devices.MAIN, devCmds.Cmd79, 968, false, sounds.sound_jettison_cover)
-- Selective jettison button
elements["PNT-969"] = default_button(_("Selective jettison button"), 0, devices.MAIN, devCmds.Cmd80, 969)
-- Jettisoning selector switch
elements["PNT-970"] = multiposition_switch(_("Jettisoning selector switch"), 0, devices.MAIN, devCmds.Cmd81, 970, 3, 1, false, false, -1, sounds.sound_arthur_sw, true, anim_speed_default)

----------------------------------------------------------------
-- Fuel transfer, refuelling and indication

-- Fuel quantity reset thumbwheel
--elements["PNT-1150"] = default_button(_("Fuel quantity reset thumbwheel"), 0, devices.MAIN, devCmds.Cmd82, 1150, 1, {0, 1}, true, nil, true, 1)
elements["PNT-1150"] = default_axis(_("Fuel quantity reset thumbwheel"), 0, devices.MAIN, devCmds.Cmd82, 1150, 1, 0.1, false, true)
-- Crossfeed switch
elements["PNT-1151"] = default_2_position_tumb(_("Crossfeed switch"), 0, devices.MAIN, devCmds.Cmd83, 1151, nil, nil, nil, nil, sounds.sound_crossfeed_sw)
-- Emergency transfer switch
elements["PNT-1152"] = default_2_position_tumb(_("Emergency transfer switch"), 0, devices.MAIN, devCmds.Cmd84, 1152, nil, nil, nil, nil, sounds.sound_arthur_sw)
-- Fuel transfer sequence selector switch
elements["PNT-1153"] = default_2_position_tumb(_("Fuel transfer sequence selector switch"), 0, devices.MAIN, devCmds.Cmd85, 1153, nil, nil, nil, nil, sounds.sound_arthur_sw)
-- Fuel transfer indicator test
elements["PNT-1166"] = default_button(_("Fuel transfer indicator test"), 0, devices.MAIN, devCmds.Cmd86, 1166)

----------------------------------------------------------------
-- Radar control stick

-- Radar control stick elevation/altitude difference button
elements["PNT-259"] = default_button(_("Radar control stick elevation/altitude difference button"), 0, devices.MAIN, devCmds.Cmd100, 259)
-- Radar control stick scale selection
elements["PNT-258"] = multiposition_switch(_("Radar control stick scale selection"), 0, devices.MAIN, devCmds.Cmd101, 258, 4, 1/3, false, true, 0, sounds.sound_radar_stick_select_sw, true, 5)
-- Radar control stick scan selection
elements["PNT-257"] = multiposition_switch(_("Radar control stick scan selection"), 0, devices.MAIN, devCmds.Cmd103, 257, 3, 0.5, false, true, 0, sounds.sound_radar_stick_select_sw, true, 5)

----------------------------------------------------------------
-- Alternative PTT
elements["PNT-405"] = default_button(_("Alternative PTT"), 0, devices.MAIN, devCmds.Cmd120, 405)

----------------------------------------------------------------
-- High-lift devices

-- Slat/Flap lever
elements["PNT-248"] = multiposition_switch(_("Slat/Flap lever"), 0, devices.MAIN, devCmds.Cmd122, 248, 3, 0.5, false, true, 0, sounds.sound_flaps_lever, true, 3)
-- High-lift device selector switch
elements["PNT-399"] = multiposition_switch(_("High-lift device selector switch"), 0, devices.MAIN, devCmds.Cmd123, 399, 3, 1, false, false, -1, sounds.sound_arthur_sw, true, anim_speed_default)

----------------------------------------------------------------
-- Radio selector unit

-- MISS potentiometer
elements["PNT-306"] = default_axis_limited(_("MISS potentiometer"), 0, devices.MAIN, devCmds.Cmd124, 306)
-- TAC potentiometer
elements["PNT-307"] = default_axis_limited(_("TAC potentiometer"), 0, devices.MAIN, devCmds.Cmd126, 307)
-- VOR potentiometer
elements["PNT-308"] = default_axis_limited(_("VOR potentiometer"), 0, devices.MAIN, devCmds.Cmd128, 308)
-- "AMPLI 2-1" selector switch
elements["PNT-309"] = multiposition_switch(_("AMPLI 2-1 selector switch"), 0, devices.MAIN, devCmds.Cmd130, 309, 2, 1, true, false, 0, sounds.sound_omnibearing_sel_mode, true, anim_speed_default)

-- U + V pushbutton
elements["PNT-310"] = intercom_rotate_tumb(_("U + V pushbutton"), 0, devices.MAIN, devCmds.Cmd131, devCmds.Cmd132, 310, 311, nil, nil, sound_intercom_pushbutton)
-- U pushbutton
elements["PNT-313"] = intercom_rotate_tumb(_("U pushbutton"), 0, devices.MAIN, devCmds.Cmd134, devCmds.Cmd135, 313, 314, nil, nil, sound_intercom_pushbutton)
-- RAP + CME pushbutton
elements["PNT-316"] = intercom_rotate_tumb(_("RAP + CME pushbutton"), 0, devices.MAIN, devCmds.Cmd137, devCmds.Cmd138, 316, 317, nil, nil, sound_intercom_pushbutton)
-- MKR + TP pushbutton
elements["PNT-319"] = intercom_rotate_tumb(_("MKR + TP pushbutton"), 0, devices.MAIN, devCmds.Cmd140, devCmds.Cmd141, 319, 320, nil, nil, sound_intercom_pushbutton)

----------------------------------------------------------------
-- V/UHF radio control unit (TRT - TRAP 136)

-- Test selector switch
elements["PNT-272"] = multiposition_switch(_("Test selector switch"), 0, devices.MAIN, devCmds.Cmd145, 272, 3, 1, false, false, -1, sounds.sound_SIL_sw, true, anim_speed_default)
-- SIL switch
elements["PNT-273"] = default_2_position_tumb(_("SIL switch"), 0, devices.MAIN, devCmds.Cmd146, 273, nil, nil, nil, nil, sounds.sound_SIL_sw)
-- Frequency select thumbwheel - Hundreds
elements["PNT-274"] = multiposition_switch(_("Frequency select thumbwheel - Hundreds"), 0, devices.MAIN, devCmds.Cmd147, 274, 3, 0.1, false, false, 0.1, sounds.sound_freq_sel, true, 1)
-- Frequency select thumbwheel - Tens
elements["PNT-275"] = multiposition_switch_cycled_relative(_("Frequency select thumbwheel - Tens"), 0, devices.MAIN, devCmds.Cmd149, 275, 11, 0.1, false, 0, sounds.sound_freq_sel, 1)
-- Frequency select thumbwheel - Units
elements["PNT-276"] = multiposition_switch_cycled_relative(_("Frequency select thumbwheel - Units"), 0, devices.MAIN, devCmds.Cmd151, 276, 11, 0.1, false, 0, sounds.sound_freq_sel, 1)
-- Frequency select thumbwheel - Tenths
elements["PNT-277"] = multiposition_switch_cycled_relative(_("Frequency select thumbwheel - Tenths"), 0, devices.MAIN, devCmds.Cmd153, 277, 11, 0.1, false, 0, sounds.sound_freq_sel, 1)
-- Frequency select thumbwheel - Thousands
elements["PNT-278"] = multiposition_switch(_("Frequency select thumbwheel - Thousandths"), 0, devices.MAIN, devCmds.Cmd155, 278, 4, 0.333, false, false, 0, sounds.sound_freq_sel, true, 3.3)
-- Function selector
elements["PNT-280"] = multiposition_switch_cycled_relative(_("Function selector"), 0, devices.MAIN, devCmds.Cmd157, 280, 6, 0.2, false, 0, sounds.sound_omnibearing_sel_mode, 3)
-- 25W - 5W switch
elements["PNT-281"] = default_2_position_tumb(_("25W - 5W switch"), 0, devices.MAIN, devCmds.Cmd159, 281, nil, nil, nil, nil, sounds.sound_radio_5W_sw)
-- Frequency selector switch
elements["PNT-282"] = multiposition_switch(_("Frequency selector switch"), 0, devices.MAIN, devCmds.Cmd160, 282, 3, 0.5, false, false, 0, sounds.sound_omnibearing_sel_mode, true, 5)
-- Channel selector
do
	local channelsNumerics 			= {717, {0, 1}, 1}

	--elements["PNT-283"] = multiposition_switch(_("Channel selector"), 0, devices.MAIN, devCmds.Cmd162, 283, 21, 0.05, true)
	elements["PNT-283"] = {
		class  		 				= {class_type.LEV}, 
		hint   		 				= _("Channel selector"),
		device 		 				= devices.MAIN,
		action 		 				= {devCmds.Cmd162},
		arg 						= {283},
		arg_value 					= {0.1},
		arg_lim   					= {{0.0, 1.0}},
		relative					= {true},
		animated   					= {true},
		animation_speed 			= {0.7},
		gain 						= {0.1},
		slave_animation 			= {{slave = channelsNumerics}, {slave = channelsNumerics}},
		sound           			= sounds.sound_channel_sel
	}
end

----------------------------------------------------------------
-- Engine emergency regulation

-- Emergency regulation light
elements["PNT-354"] = default_button_axis(_("Emergency regulation light"), 0, devices.MAIN, devCmds.Cmd165, devCmds.Cmd166, 354, 355)
-- Emergency regulation switch guard
elements["PNT-357"] = guard_switch(_("Emergency regulation switch guard"), 0, devices.MAIN, devCmds.Cmd167, 357, false, sounds.sound_AB_main_cock_sw_guard)
-- Emergency regulation switch
elements["PNT-358"] = default_2_position_tumb(_("Emergency regulation switch"), 0, devices.MAIN, devCmds.Cmd168, 358, nil, nil, nil, nil, sounds.sound_arthur_sw)
-- Emergency regulation control lever
elements["PNT-359"] = springloaded_2pos_switch(_("Emergency regulation control lever"), 0, devices.MAIN, devCmds.Cmd170, devCmds.Cmd169, 359, false, 10, sounds.sound_emerg_reg_lever)

-- Brake chute control
elements["PNT-54"] = default_2_position_tumb(_("Brake chute control"), 0, devices.MAIN, devCmds.Cmd171, 54, 1, {0, 1}, true, true, sounds.sound_chute_lever, true, 2)

----------------------------------------------------------------
-- Canopy controls

-- Canopy lock control (animated via code)
elements["PNT-55"] = default_2_position_tumb(_("Canopy lock control"), 0, devices.MAIN, devCmds.Cmd172, 55, 1, {0, 1}, true, true, nil, false)
-- Canopy embrittle control
elements["PNT-56"] = default_button(_("Canopy embrittle control"), 0, devices.MAIN, devCmds.Cmd173, 56, 1, {0, 1}, true, sounds.sound_canopy_embrittle_ctrl, true, 4)
-- Canopy hinged handle (animated via code)
elements["PNT-3"] = default_2_position_tumb(_("Canopy hinged handle"), 0, devices.MAIN, devCmds.Cmd174, 3, 1, {0, 1}, true, true, nil, false)
-- Canopy seal valve control lever
elements["PNT-233"] = default_2_position_tumb(_("Canopy seal valve control lever"), 0, devices.MAIN, devCmds.Cmd175, 233, 1, {0, 1}, true, false, sounds.sound_canopy_seal_lever, true, 4)
-- Mirrors
elements["PNT-2"] = default_2_position_tumb(_("Mirrors"), 0, devices.MAIN, devCmds.Cmd176, 2, 1, {0, 1}, true, true, nil, true, 2)
elements["PNT-2-L"] = default_2_position_tumb(_("Mirrors"), 0, devices.MAIN, devCmds.Cmd177, 2, 1, {0, 1}, true, true, nil, true, 2)
-- Canopy handle (animated via code)
elements["PNT-1-L"] = default_2_position_tumb(_("Canopy open/close"), 0, devices.MAIN, devCmds.Cmd178, 1, 1, {0, 1}, true, true, nil, false)
elements["PNT-1-R"] = default_2_position_tumb(_("Canopy open/close"), 0, devices.MAIN, devCmds.Cmd179, 1, 1, {0, 1}, true, true, nil, false)

----------------------------------------------------------------
-- Undercarriage, nose wheel steering, brake and anti-skid

-- U/C safety lever
elements["PNT-85"] = guard_switch(_("U/C safety lever"), 0, devices.MAIN, devCmds.Cmd190, 85, true, sounds.sound_gear_cover)
-- U/C control lever
elements["PNT-86"] = default_2_position_tumb(_("U/C control lever"), 0, devices.MAIN, devCmds.Cmd191, 86, 1, {0, 1}, true, true, sounds.sound_gear_lever, true, 4)
-- Anti-retraction override button
elements["PNT-87"] = default_button(_("Anti-retraction override button"), 0, devices.MAIN, devCmds.Cmd192, 87)
-- Emergency/Parking brake handle
elements["PNT-84"] = default_2_position_tumb(_("Emergency/Parking brake handle"), 0, devices.MAIN, devCmds.Cmd193, 84, 1, {0, 1}, true, true, sounds.sound_parking_brk, true, 2)
-- Anti-skid (SPAD) switch guard
elements["PNT-402"] = guard_switch(_("Anti-skid (SPAD) switch guard"), 0, devices.MAIN, devCmds.Cmd194, 402, true, sounds.sound_stick_uncouple_sw_guard)
-- Anti-skid (SPAD) switch
elements["PNT-403"] = default_2_position_tumb(_("Anti-skid (SPAD) switch"), 0, devices.MAIN, devCmds.Cmd195, 403, 1, {0, 1}, true, true, sounds.sound_pump_sw)
-- Nose wheel steering high sensitivity button
elements["PNT-756"] = springloadedAndRetained_2pos_switch(_("Nose wheel steering high sensitivity button"), 0, devices.MAIN, devCmds.Cmd196, devCmds.Cmd197, 756, nil, nil, sounds.sound_souris_btn, true, 40)
-- Nose wheel steering switch guard
elements["PNT-757"] = guard_switch(_("Nose wheel steering switch guard"), 0, devices.MAIN, devCmds.Cmd198, 757, true, sounds.sound_stick_uncouple_sw_guard)
-- Nose wheel steering switch
elements["PNT-758"] = default_2_position_tumb(_("Nose wheel steering switch"), 0, devices.MAIN, devCmds.Cmd199, 758, 1, {0, 1}, true, true, sounds.sound_arthur_sw)
-- Emergency U/C handle
elements["PNT-107"] = multiposition_switch(_("Emergency U/C handle"), 0, devices.MAIN, devCmds.Cmd200, 107, 3, 0.5, false, false, 0, sounds.sound_emerg_gear_ext, true, 1)

----------------------------------------------------------------
-- Hydraulic system controls

-- Hydraulic pressure selector switch
elements["PNT-88"] = default_2_position_tumb(_("Hydraulic pressure selector switch"), 0, devices.MAIN, devCmds.Cmd201, 88, nil, nil, nil, nil, sounds.sound_SIL_sw)
-- Electro-pump switch
elements["PNT-475"] = default_2_position_tumb(_("Electro-pump switch"), 0, devices.MAIN, devCmds.Cmd202, 475, nil, nil, nil, nil, sounds.sound_warning_horn_sw)

----------------------------------------------------------------
-- Air data system and miscellaneous instrument controls 

----------------------------------------------------------------
-- Clock

-- Chronometer starting control and clock winding/setting knob
elements["PNT-67"] = default_button_axis(_("Chronometer starting control and clock winding/setting knob"), 0, devices.MAIN, devCmds.Cmd210, devCmds.Cmd211, 232, 67)
-- Clock winding/setting lever
elements["PNT-231"] = default_2_position_tumb(_("Clock winding/setting lever"), 0, devices.MAIN, devCmds.Cmd212, 231, nil, nil, nil, nil, sounds.sound_SIL_sw)

----------------------------------------------------------------
-- Incidence indicator

-- Incidence indicator lighting rheostat
elements["PNT-201"] = default_axis_limited(_("Incidence indicator lighting rheostat"), 0, devices.MAIN, devCmds.Cmd213, 201)

----------------------------------------------------------------
-- Air data instrument controls

-- Mach/Airspeed indicator reference airspeed knob
elements["PNT-1270"] = default_axis_limited(_("Mach/Airspeed indicator reference airspeed knob"), 0, devices.MAIN, devCmds.Cmd218, 1270)
-- Slaved altimeter barometric pressure setting knob
elements["PNT-1053"] = default_axis(_("Slaved altimeter barometric pressure setting knob"), 0, devices.MAIN, devCmds.Cmd220, 1053, 1, 0.1, false, true)

-- Standby altimeter barometric pressure setting knob
elements["PNT-1072"] = default_axis(_("Standby altimeter barometric pressure setting knob"), 0, devices.MAIN, devCmds.Cmd222, 1072, 1, 0.1, false, true)
-- Probe heater switch
elements["PNT-477"] = default_2_position_tumb(_("Probe heater switch"), 0, devices.MAIN, devCmds.Cmd224, 477, nil, nil, nil, nil, sounds.sound_warning_horn_sw)

----------------------------------------------------------------
-- Heading and vertical reference system and standby horizon controls

-- Standby horizon switch
elements["PNT-474"] = default_2_position_tumb(_("Standby horizon switch"), 0, devices.MAIN, devCmds.Cmd230, 474, nil, nil, nil, nil, sounds.sound_warning_horn_sw)
-- Spherical indicator day/night selector switch
elements["PNT-1116"] = default_axis_limited(_("Spherical indicator day/night selector switch"), 0, devices.MAIN, devCmds.Cmd231, 1116)
-- Spherical indicator pole setting and marker beacon light test
elements["PNT-1117"] = default_button_axis(_("Spherical indicator pole setting and marker beacon light test"), 0, devices.MAIN, devCmds.Cmd232, devCmds.Cmd233, 202, 1117)
-- Standby horizon uncage and aircraft model control
elements["PNT-1132"] = standbyHorizonUncageAndPitchCtrlKnob(_("Standby horizon uncage and aircraft model control"), 0, devices.MAIN, devCmds.Cmd234, devCmds.Cmd235, devCmds.Cmd236, 1132, 1133, nil, true, 40)

----------------------------------------------------------------
-- Heading control unit

-- Heading and vertical reference system control switch
elements["PNT-537"] = multiposition_switch(_("Heading and vertical reference system control switch"), 0, devices.MAIN, devCmds.Cmd237, 537, 4, 0.3333, false, false, 0, sounds.sound_omnibearing_sel_mode, true, 5) 
-- Emergency gyromagnetic compass switch
elements["PNT-538"] = default_2_position_tumb(_("Emergency gyromagnetic compass switch"), 0, devices.MAIN, devCmds.Cmd239, 538, nil, nil, nil, nil, sounds.sound_warning_horn_sw)
-- Heading control unit erection button
elements["PNT-540"] = default_button(_("Heading control unit erection button"), 0, devices.MAIN, devCmds.Cmd240, 540)

----------------------------------------------------------------
-- Electrical system controls

-- Battery switch
elements["PNT-113"] = default_2_position_tumb(_("Battery switch"), 0, devices.MAIN, devCmds.Cmd250, 113, nil, nil, nil, nil, sounds.sound_battery_sw)
-- Alternator 1 switch
elements["PNT-114"] = default_2_position_tumb(_("Alternator 1 switch"), 0, devices.MAIN, devCmds.Cmd251, 114, nil, nil, nil, nil, sounds.sound_battery_sw)
-- Alternator 2 switch
elements["PNT-115"] = default_2_position_tumb(_("Alternator 2 switch"), 0, devices.MAIN, devCmds.Cmd252, 115, nil, nil, nil, nil, sounds.sound_battery_sw)
-- TR reset button
elements["PNT-116"] = default_button(_("TR reset button"), 0, devices.MAIN, devCmds.Cmd253, 116)
-- Inverter selector switch
elements["PNT-117"] = default_button_tumb(_("Inverter selector switch"), 0, devices.MAIN, devCmds.Cmd255, devCmds.Cmd254, 117, nil, sounds.sound_conv_sw)

----------------------------------------------------------------
-- Warning lights

-- Master failure warning light
elements["PNT-920"] = default_button(_("Master failure warning light"), 0, devices.MAIN, devCmds.Cmd265, 920)
-- Combat flaps light
elements["PNT-956"] = default_button_axis(_("Combat flaps light"), 0, devices.MAIN, devCmds.Cmd266, devCmds.Cmd267, 956, 957)
-- U/C light
elements["PNT-928"] = default_button(_("U/C light"), 0, devices.MAIN, devCmds.Cmd269, 928)
-- Nose wheel steering light
elements["PNT-950"] = default_button_axis(_("Nose wheel steering light"), 0, devices.MAIN, devCmds.Cmd270, devCmds.Cmd271, 950, 951)
-- Airbrake light
elements["PNT-944"] = default_button_axis(_("Airbrake light"), 0, devices.MAIN, devCmds.Cmd273, devCmds.Cmd274, 944, 945)
-- Limit warning light + Horn
elements["PNT-932"] = default_button(_("Limit warning light + Horn"), 0, devices.MAIN, devCmds.Cmd276, 932)
-- Fire warning light (ENG/AB) + Horn
elements["PNT-940"] = default_button(_("Fire warning light (ENG/AB) + Horn"), 0, devices.MAIN, devCmds.Cmd277, 940)
-- A/B INJ light
elements["PNT-1029"] = default_button(_("A/B INJ light"), 0, devices.MAIN, devCmds.Cmd278, 1029)
-- A/B ON light
elements["PNT-1031"] = default_button(_("A/B ON light"), 0, devices.MAIN, devCmds.Cmd279, 1031)
-- A/B SRL light
elements["PNT-1033"] = default_button(_("A/B SRL light"), 0, devices.MAIN, devCmds.Cmd280, 1033)
-- Standby receptacle light
elements["PNT-92"] = default_button_axis(_("Standby receptacle light"), 0, devices.MAIN, devCmds.Cmd281, devCmds.Cmd282, 92, 93)
-- Configuration indicator test button
elements["PNT-1082"] = default_button(_("Configuration indicator test button"), 0, devices.MAIN, devCmds.Cmd284, 1082)
-- Failure warning panel T test button
elements["PNT-118"] = default_button(_("Failure warning panel T test button"), 0, devices.MAIN, devCmds.Cmd285, 118)
-- Failure warning panel O2 test button
elements["PNT-119"] = default_button(_("Failure warning panel O2 test button"), 0, devices.MAIN, devCmds.Cmd286, 119)
-- Warning horn switch
elements["PNT-476"] = default_2_position_tumb(_("Warning horn switch"), 0, devices.MAIN, devCmds.Cmd287, 476, nil, nil, nil, nil, sounds.sound_warning_horn_sw)
-- (C + M or SW) R light
elements["PNT-197"] = default_button_axis(_("(C + M or SW) R light"), 0, devices.MAIN, devCmds.Cmd294, devCmds.Cmd295, 197, 198)
-- Cannons too hot light
elements["PNT-108"] = default_button_axis(_("Cannons too hot light"), 0, devices.MAIN, devCmds.Cmd297, devCmds.Cmd298, 108, 109)

-- BIP button
elements["PNT-1081"] = default_button(_("BIP button"), 0, devices.MAIN, devCmds.Cmd300, 1081)

----------------------------------------------------------------
-- Exterior lighting

-- Landing light control
elements["PNT-353"] = multiposition_switch(_("Landing light control"), 0, devices.MAIN, devCmds.Cmd310, 353, 3, 0.5, nil, nil, nil, sounds.sound_ext_lights_sw)
-- Formation light control
elements["PNT-112"] = multiposition_switch(_("Formation light control"), 0, devices.MAIN, devCmds.Cmd311, 112, 3, 0.5, nil, nil, nil, sounds.sound_ext_lights_sw)
-- Navigation light control
elements["PNT-111"] = multiposition_switch(_("Navigation light control"), 0, devices.MAIN, devCmds.Cmd312, 111, 3, 0.5, nil, nil, nil, sounds.sound_ext_lights_sw)
-- Search light control
elements["PNT-479"] = default_2_position_tumb(_("Search light control"), 0, devices.MAIN, devCmds.Cmd313, 479, nil, nil, nil, nil, sounds.sound_warning_horn_sw)

----------------------------------------------------------------
-- Cabin lighting

-- Miscellaneous instrument lighting switch
elements["PNT-470"] = multiposition_switch(_("Miscellaneous instrument lighting switch"), 0, devices.MAIN, devCmds.Cmd314, 470, 2, 1, false, true, nil, sounds.sound_feeder_tank_fus_sw)
-- Map light rheostat
elements["PNT-66"] = default_axis_limited(_("Map light rheostat"), 0, devices.MAIN, devCmds.Cmd315, 66)
-- Miscellaneous instrument integral lighting rheostat
elements["PNT-68"] = default_axis_limited(_("Miscellaneous instrument integral lighting rheostat"), 0, devices.MAIN, devCmds.Cmd317, 68)

----------------------------------------------------------------
-- Lighting control unit

-- Day/Night selector switch
elements["PNT-382"] = multiposition_switch(_("Day/Night selector switch"), 0, devices.MAIN, devCmds.Cmd319, 382, 2, 1, true, false, 0, sounds.sound_day_night_sel_sw, true, anim_speed_default)
-- Light and panel lighting rheostat
elements["PNT-383"] = default_axis_limited(_("Light and panel lighting rheostat"), 0, devices.MAIN, devCmds.Cmd320, 383)
-- Ultraviolet lighting rheostat
elements["PNT-384"] = default_axis_limited(_("Ultraviolet lighting rheostat"), 0, devices.MAIN, devCmds.Cmd322, 384)
-- Dual instrument panel lighting rheostat (Floodlights)
elements["PNT-385"] = default_axis_limited(_("Dual instrument panel lighting rheostat (Floodlights)"), 0, devices.MAIN, devCmds.Cmd324, 385)
-- Dual instrument panel lighting rheostat (Integral)
elements["PNT-386"] = default_axis_limited(_("Dual instrument panel lighting rheostat (Integral)"), 0, devices.MAIN, devCmds.Cmd326, 386)
-- Dual console and pedestal lighting rheostat (Floodlights)
elements["PNT-387"] = default_axis_limited(_("Dual console and pedestal lighting rheostat (Floodlights)"), 0, devices.MAIN, devCmds.Cmd328, 387)
-- Dual console and pedestal lighting rheostat (Integral)
elements["PNT-388"] = default_axis_limited(_("Dual console and pedestal lighting rheostat (Integral)"), 0, devices.MAIN, devCmds.Cmd330, 388)

----------------------------------------------------------------
-- Radionavigation

----------------------------------------------------------------
-- TACAN control box

-- TACAN test button
elements["PNT-480"] = default_button(_("TACAN test button"), 0, devices.MAIN, devCmds.Cmd349, 480)
-- TACAN X/Y mode selector
elements["PNT-485"] = multiposition_switch(_("TACAN X/Y mode selector"), 0, devices.MAIN, devCmds.Cmd335, 485, 2, 1, true, nil, nil, sounds.sound_omnibearing_sel_mode)
-- TACAN frequency hundreds and tens selector
--elements["PNT-486"] = multiposition_switch(_("TACAN frequency hundreds and tens selector"), 0, devices.MAIN, devCmds.Cmd336, 486, 14, 1/14, true, true, 0, nil, true, 1.5)
elements["PNT-486"] = {
	class  		 				= {class_type.LEV}, 
	hint   		 				= _("TACAN frequency hundreds and tens selector"),
	device 		 				= devices.MAIN,
	action 		 				= {devCmds.Cmd336}, 
	arg 						= {486},
	arg_value 					= {0.1},
	arg_lim   					= {{0.0, 1.0}},
	relative					= {true},
	animated   					= {true},
	animation_speed 			= {0.7},
	gain 						= {0.1},
	sound           			= sounds.sound_tacan_channel_sel
}
-- TACAN mode selector
elements["PNT-487"] = multiposition_switch(_("TACAN mode selector"), 0, devices.MAIN, devCmds.Cmd337, 487, 4, 0.3333, false, true, 0, sounds.sound_omnibearing_sel_mode, true, 6)
-- TACAN frequency units selector
--elements["PNT-488"] = multiposition_switch(_("TACAN frequency units selector"), 0, devices.MAIN, devCmds.Cmd339, 488, 10, 0.1, true, true, 0, nil, true, 1.5)
elements["PNT-488"] = {
	class  		 				= {class_type.LEV}, 
	hint   		 				= _("TACAN frequency units selector"),
	device 		 				= devices.MAIN,
	action 		 				= {devCmds.Cmd339}, 
	arg 						= {488},
	arg_value 					= {0.1},
	arg_lim   					= {{0.0, 1.0}},
	relative					= {true},
	animated   					= {true},
	animation_speed 			= {0.7},
	gain 						= {0.1},
	sound           			= sounds.sound_tacan_channel_sel
}

----------------------------------------------------------------
-- VOR/ILS control box

-- VOR-ILS control unit ON/OFF selector
elements["PNT-503"] = multiposition_switch(_("VOR-ILS control unit ON/OFF selector"), 0, devices.MAIN, devCmds.Cmd340, 503, 2, 1, true, nil, nil, sounds.sound_omnibearing_sel_mode)
-- VOR-ILS control unit MHz frequency selector
--elements["PNT-504"] = default_axis_limited(_("VOR-ILS control unit MHz frequency selector"), 0, devices.MAIN, devCmds.Cmd341, 504)
elements["PNT-504"] = {
	class  		 				= {class_type.LEV}, 
	hint   		 				= _("VOR/ILS control unit MHz frequency selector"),
	device 		 				= devices.MAIN,
	action 		 				= {devCmds.Cmd341}, 
	arg 						= {504},
	arg_value 					= {0.1},
	arg_lim   					= {{0.0, 1.0}},
	relative					= {true},
	animated   					= {true},
	animation_speed 			= {0.7},
	gain 						= {0.1},
	sound           			= sounds.sound_tacan_channel_sel
}
-- VOR-ILS control unit test selector
elements["PNT-505"] = springloaded_2pos_switch(_("VOR-ILS control unit test selector"), 0, devices.MAIN, devCmds.Cmd343, devCmds.Cmd342, 505, false, nil, sounds.sound_VOR_ILS_test_sel)
-- VOR-ILS control unit kHz frequency selector
--elements["PNT-506"] = default_axis_limited(_("VOR/ILS control unit kHz frequency selector"), 0, devices.MAIN, devCmds.Cmd344, 506)
elements["PNT-506"] = {
	class  		 				= {class_type.LEV}, 
	hint   		 				= _("VOR/ILS control unit kHz frequency selector"),
	device 		 				= devices.MAIN,
	action 		 				= {devCmds.Cmd344}, 
	arg 						= {506},
	arg_value 					= {0.1},
	arg_lim   					= {{0.0, 1.0}},
	relative					= {true},
	animated   					= {true},
	animation_speed 			= {0.7},
	gain 						= {0.1},
	sound           			= sounds.sound_tacan_channel_sel
}

----------------------------------------------------------------
-- Omnibearing and VOR/ILS-TAC selector box

-- Omnibearing selector
--elements["PNT-545"] = default_axis_limited(_("Omnibearing selector"), 0, devices.MAIN, devCmds.Cmd345, 545)
elements["PNT-545"] = default_axis(_("Omnibearing selector"), 0, devices.MAIN, devCmds.Cmd345, 545, 1, -0.1, false, true)
-- VOR/ILS-OFF-TACAN selector
elements["PNT-544"] = multiposition_switch(_("VOR-ILS/OFF/TACAN selector"), 0, devices.MAIN, devCmds.Cmd346, 544, 3, 0.5, false, true, 0, sounds.sound_omnibearing_sel_mode, true, 6)

-- Heading selection knob
elements["PNT-547"] = default_axis(_("Heading selection knob"), 0, devices.MAIN, devCmds.Cmd348, 547, 1, -0.1, false, true)

----------------------------------------------------------------
-- Oxygen system

-- Oxygen test button (T button)
elements["PNT-517"] = default_button(_("Oxygen test button (T button)"), 0, devices.MAIN, devCmds.Cmd360, 517)
-- Pilot oxygen test button
elements["PNT-519"] = default_button(_("Pilot oxygen test button"), 0, devices.MAIN, devCmds.Cmd361, 519)
-- "N-100%-EMG" mode selector switch
elements["PNT-709"] = multiposition_switch(_("N-100%-EMG mode selector switch"), 0, devices.MAIN, devCmds.Cmd362, 709, 3, 0.5, false, false, nil, sounds.sound_oxy_mode_sel)
-- Oxygen overpressure button
elements["PNT-710"] = default_button(_("Oxygen overpressure button"), 0, devices.MAIN, devCmds.Cmd363, 710)
-- Anti-g connection cover
elements["PNT-712"] = default_button(_("Anti-g connection cover"), 0, devices.MAIN, devCmds.Cmd364, 712)
-- Anti-g test button
elements["PNT-713"] = default_button(_("Anti-g test button"), 0, devices.MAIN, devCmds.Cmd365, 713)
-- Anti-g valve cock
elements["PNT-714"] = default_2_position_tumb(_("Anti-g valve cock"), 0, devices.MAIN, devCmds.Cmd366, 714, 1, {0, 1}, true, true)

----------------------------------------------------------------
-- Air conditioning system

-- Emergency cold switch
elements["PNT-524"] = default_2_position_tumb(_("Emergency cold switch"), 0, devices.MAIN, devCmds.Cmd375, 524, nil, nil, nil, nil, sounds.sound_warning_horn_sw)
-- Master valve control switch
elements["PNT-525"] = default_2_position_tumb(_("Master valve control switch"), 0, devices.MAIN, devCmds.Cmd376, 525, nil, nil, nil, nil, sounds.sound_warning_horn_sw)
-- Temperature control rheostat
elements["PNT-527"] = default_axis_limited(_("Temperature control rheostat"), 0, devices.MAIN, devCmds.Cmd377, 527)
-- Auto/Manual selector switch
elements["PNT-529"] = default_2_position_tumb(_("Auto/Manual selector switch"), 0, devices.MAIN, devCmds.Cmd379, 529, 1, {0, 1}, true, true, sounds.sound_warning_horn_sw)
-- Hot/Cold selector switch
elements["PNT-530"] = springloaded_2pos_switch(_("Hot/Cold selector switch"), 0, devices.MAIN, devCmds.Cmd381, devCmds.Cmd380, 530, true, nil, sounds.sound_iff_ident_sw)
-- Ram air switch guard
elements["PNT-410"] = guard_switch(_("Ram air switch guard"), 0, devices.MAIN, devCmds.Cmd382, 410, true, sounds.sound_AB_main_cock_sw_guard)
-- Ram air switch
elements["PNT-411"] = default_2_position_tumb(_("Ram air switch"), 0, devices.MAIN, devCmds.Cmd383, 411, 1, {0, 1}, true, true, sounds.sound_warning_horn_sw)
-- Demist switch
elements["PNT-412"] = default_2_position_tumb(_("Demist switch"), 0, devices.MAIN, devCmds.Cmd384, 412, nil, nil, nil, nil, sounds.sound_arthur_sw)

----------------------------------------------------------------
-- Circuit breaker box

-- Gyro control unit power supply
elements["PNT-548"] = circuit_breaker(_("Gyro control unit power supply"), 0, devices.MAIN, devCmds.Cmd395, 548, nil, nil, nil, nil, sounds.sound_CB)
-- High-lift device servo unit power supply
elements["PNT-550"] = circuit_breaker(_("High-lift device servo unit power supply"), 0, devices.MAIN, devCmds.Cmd396, 550, nil, nil, nil, nil, sounds.sound_CB)
-- Indicator and failure detector power supply
elements["PNT-552"] = circuit_breaker(_("Indicator and failure detector power supply"), 0, devices.MAIN, devCmds.Cmd397, 552, nil, nil, nil, nil, sounds.sound_CB)
-- Inverter transfer unit power supply and control
elements["PNT-554"] = circuit_breaker(_("Inverter transfer unit power supply and control"), 0, devices.MAIN, devCmds.Cmd398, 554, nil, nil, nil, nil, sounds.sound_CB)
-- Dual hydraulic pressure gauge power supply
elements["PNT-556"] = circuit_breaker(_("Dual hydraulic pressure gauge power supply"), 0, devices.MAIN, devCmds.Cmd399, 556, nil, nil, nil, nil, sounds.sound_CB)
-- Gun firing trigger power supply
elements["PNT-558"] = circuit_breaker(_("Gun firing trigger power supply"), 0, devices.MAIN, devCmds.Cmd400, 558, nil, nil, nil, nil, sounds.sound_CB)
-- LP cock power supply
elements["PNT-560"] = circuit_breaker(_("LP cock power supply"), 0, devices.MAIN, devCmds.Cmd401, 560, nil, nil, nil, nil, sounds.sound_CB)
-- Electro-pump relay power supply
elements["PNT-562"] = circuit_breaker(_("Electro-pump relay power supply"), 0, devices.MAIN, devCmds.Cmd402, 562, nil, nil, nil, nil, sounds.sound_CB)
-- Flight refuelling system power supply
elements["PNT-564"] = circuit_breaker(_("Flight refuelling system power supply"), 0, devices.MAIN, devCmds.Cmd403, 564, nil, nil, nil, nil, sounds.sound_CB)
-- Cabin pressurization system power supply
elements["PNT-566"] = circuit_breaker(_("Cabin pressurization system power supply"), 0, devices.MAIN, devCmds.Cmd404, 566, nil, nil, nil, nil, sounds.sound_CB)
-- Inverter 28 V power supply
elements["PNT-568"] = circuit_breaker(_("Inverter 28 V power supply"), 0, devices.MAIN, devCmds.Cmd405, 568, nil, nil, nil, nil, sounds.sound_CB)
-- U/C normal operation power supply
elements["PNT-570"] = circuit_breaker(_("U/C normal operation power supply"), 0, devices.MAIN, devCmds.Cmd406, 570, nil, nil, nil, nil, sounds.sound_CB)
-- V/UHF power supply
elements["PNT-572"] = circuit_breaker(_("V/UHF power supply"), 0, devices.MAIN, devCmds.Cmd407, 572, nil, nil, nil, nil, sounds.sound_CB)
-- Starter and sequencing system power supply
elements["PNT-574"] = circuit_breaker(_("Starter and sequencing system power supply"), 0, devices.MAIN, devCmds.Cmd408, 574, nil, nil, nil, nil, sounds.sound_CB)
-- Refuelling probe control power supply
elements["PNT-576"] = circuit_breaker(_("Refuelling probe control power supply"), 0, devices.MAIN, devCmds.Cmd409, 576, nil, nil, nil, nil, sounds.sound_CB)
-- Manual trim control power supply
elements["PNT-578"] = circuit_breaker(_("Manual trim control power supply"), 0, devices.MAIN, devCmds.Cmd410, 578, nil, nil, nil, nil, sounds.sound_CB)
-- Valve position repeater, control valve and ground mode power supply
elements["PNT-580"] = circuit_breaker(_("Valve position repeater, control valve and ground mode power supply"), 0, devices.MAIN, devCmds.Cmd411, 580, nil, nil, nil, nil, sounds.sound_CB)
-- Failure warning panel and master failure warning light power supply
elements["PNT-582"] = circuit_breaker(_("Failure warning panel and master failure warning light power supply"), 0, devices.MAIN, devCmds.Cmd412, 582, nil, nil, nil, nil, sounds.sound_CB)
-- Configuration indicator (U/C section) and U/C warning light power supply
elements["PNT-584"] = circuit_breaker(_("Configuration indicator (U/C section) and U/C warning light power supply"), 0, devices.MAIN, devCmds.Cmd413, 584, nil, nil, nil, nil, sounds.sound_CB)
-- IFF power supply
elements["PNT-586"] = circuit_breaker(_("IFF power supply"), 0, devices.MAIN, devCmds.Cmd414, 586, nil, nil, nil, nil, sounds.sound_CB)
-- Emergency regulation system and control lever power supply
elements["PNT-588"] = circuit_breaker(_("Emergency regulation system and control lever power supply"), 0, devices.MAIN, devCmds.Cmd415, 588, nil, nil, nil, nil, sounds.sound_CB)

----------------------------------------------------------------
-- Ejection seat

-- Seat height adjustment control
elements["PNT-11"] = springloaded_2pos_switch(_("Seat height adjustment control"), 0, devices.MAIN, devCmds.Cmd431, devCmds.Cmd430, 11, false, nil, sounds.sound_iff_ident_sw)
-- Face blind firing handle
elements["PNT-13"] = default_button(_("Face blind firing handle"), 0, devices.MAIN, devCmds.Cmd432, 13)
elements["PNT-13-R"] = default_button(_("Face blind firing handle"), 0, devices.MAIN, devCmds.Cmd433, 13)
-- Alternative firing handle
elements["PNT-14"] = default_button(_("Alternative firing handle"), 0, devices.MAIN, devCmds.Cmd434, 14)
elements["PNT-14-L"] = default_button(_("Alternative firing handle"), 0, devices.MAIN, devCmds.Cmd435, 14)
elements["PNT-14-R"] = default_button(_("Alternative firing handle"), 0, devices.MAIN, devCmds.Cmd436, 14)
-- Ejection handle safety pin
elements["PNT-1316"] = default_axis_limited(_("Ejection handle safety pin"),0,devices.MAIN,devCmds.Cmd650, 1316)

----------------------------------------------------------------
-- Chaff and flares dispenser ALE 40 control unit

-- Chaff/flares selector switch
elements["PNT-208"] = multiposition_switch(_("Chaff/flares selector switch"), 0, devices.MAIN, devCmds.Cmd437, 208, 3, 0.5, nil, nil, nil, sounds.sound_SIL_sw)
-- Program selector switch
elements["PNT-209"] = multiposition_switch(_("Program selector switch"), 0, devices.MAIN, devCmds.Cmd438, 209, 4, 0.3333, false, false, 0, sounds.sound_omnibearing_sel_mode, true, 4)
-- Chaff counter reset button
elements["PNT-212"] = default_button(_("Chaff counter reset button"), 0, devices.MAIN, devCmds.Cmd440, 212)
-- Flares counter reset button
elements["PNT-215"] = default_button(_("Flares counter reset button"), 0, devices.MAIN, devCmds.Cmd441, 215)
-- Emergency jettisoning switch (TO DO AS PUSH-BUTTON)
elements["PNT-216"] = default_2_position_tumb(_("Emergency jettisoning switch"), 0, devices.MAIN, devCmds.Cmd442, 216, nil, nil, nil, nil, sounds.sound_pump_sw)

----------------------------------------------------------------
-- Radar detector switch
elements["PNT-478"] = default_2_position_tumb(_("Radar detector switch"), 0, devices.MAIN, devCmds.Cmd443, 478, nil, nil, nil, nil, sounds.sound_warning_horn_sw)

---- Chaff and flares release button
elements["PNT-708"] = default_button(_("Chaff/flares release button"), 0, devices.MAIN, devCmds.Cmd444, 708)
