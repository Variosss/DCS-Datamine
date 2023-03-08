dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."devices.lua")
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

direction                      = 1
cyclic_by_default              = true -- to cycle two-way thumblers or not by default

function default_button(hint_,device_,command_,arg_,arg_val_,arg_lim_, use_rel_)

	local   arg_val = arg_val_ or 1
	local   arg_lim = arg_lim_ or {0,1}
	
	local   use_rel = true
	if use_rel_ ~= nil then
		use_rel = use_rel_
	end
	
	return  {	
				class 				= {class_type.BTN},
				hint  				= hint_,
				device 				= device_,
				action 				= {command_},
				stop_action 		= {command_},
				arg 				= {arg_},
				arg_value			= {arg_val}, 
				arg_lim 			= {arg_lim},
				use_release_message = {use_rel},
				side				= {{BOX_SIDE_Y_bottom}}
			}
end

function default_2_position_button(hint_, device_, command_, arg_)
	return  {	
				class 		= {class_type.TUMB,class_type.TUMB},
				hint  		= hint_,
				device 		= device_,
				action 		= {command_,command_},
				arg 	  	= {arg_,arg_},
				arg_value 	= {-1,1}, 
				arg_lim   	= {{0,1},{0,1}},
				updatable 	= true, 
				use_OBB 	= true,
				class_vr	= {0,class_type.BTN_FIX},
				side		= {{},{BOX_SIDE_Y_bottom}}
			}
end

function default_2_position_tumb(hint_, device_, command_, arg_)
	return  {	
				class 		= {class_type.TUMB,class_type.TUMB},
				hint  		= hint_,
				device 		= device_,
				action 		= {command_,command_},
				arg 	  	= {arg_,arg_},
				arg_value 	= {-1,1}, 
				arg_lim   	= {{0,1},{0,1}},
				updatable 	= true, 
				use_OBB 	= true,
				side		= {{BOX_SIDE_Z_top},{BOX_SIDE_Z_bottom}}
			}
end

function default_2_position_cover(hint_, device_, command_, arg_)
	return  {	
				class 		= {class_type.TUMB,class_type.TUMB},
				hint  		= hint_,
				device 		= device_,
				action 		= {command_,command_},
				arg 	  	= {arg_,arg_},
				arg_value 	= {-1,1}, 
				arg_lim   	= {{0,1},{0,1}},
				updatable 	= true, 
				use_OBB 	= true,
				class_vr	= {0,class_type.BTN_FIX},
				side		= {{},{BOX_SIDE_Y_bottom}}
			}
end

function default_3_position_tumb(hint_,device_,command_,arg_,cycled_,inversed_)
	local cycled = true
	
	local side = {{BOX_SIDE_Z_top},{BOX_SIDE_Z_bottom}}
	local val =  1
	if inversed_ then
	      val = -1
		  side = {{BOX_SIDE_Z_bottom},{BOX_SIDE_Z_top}}
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
				side		= side
			}
end

function default_axis(hint_,device_,command_,arg_, default_, gain_,updatable_,relative_,cycle_,attach_left_,attach_right_)
	
	local relative = false
	if relative_ ~= nil then
		relative = relative_
	end
	
	local cycle_ = cycle_ or false

	local gain = gain_ or 0.1
	local default = default_ or 1
	return  {	
				class 			= {class_type.LEV},
				hint  			= hint_,
				device 			= device_,
				action 			= {command_},
				arg 	  		= {arg_},
				arg_value 		= {default}, 
				arg_lim   		= {{0,1}},
				updatable 		= {updatable_}, 
				use_OBB 		= true,
				gain			= {gain},
				relative    	= {relative},  
				cycle  			= cycle_,
				side			= {{BOX_SIDE_X_top, BOX_SIDE_X_bottom, BOX_SIDE_Z_top, BOX_SIDE_Z_bottom}},
				attach_left		= attach_left_ or nil,
				attach_right	= attach_right_ or nil,
			}
end

function default_axis_limited(hint_,device_,command_,arg_,gain_,updatable_,relative_, _arg_lim,attach_left_,attach_right_)
	
	local relative = false
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
				arg_value 		= {1}, 
				arg_lim   		= {_arg_lim},
				updatable 		= {updatable_}, 
				use_OBB 		= false,
				gain			= {gain},
				relative    	= {relative},  
				cycle 			= false,
				side			= {{BOX_SIDE_X_top, BOX_SIDE_X_bottom, BOX_SIDE_Z_top, BOX_SIDE_Z_bottom}},
				attach_left		= attach_left_ or nil,
				attach_right	= attach_right_ or nil,
			}
end

function multiposition_switch(hint_,device_,command_,arg_,count_,delta_,min_,inverted_,attach_left_,attach_right_)
    local min_   = min_ or 0
	local delta_ = delta_ or 0.5
	local inverted_ = inverted_ or 1
	return  {	
				class 			= {class_type.TUMB,class_type.TUMB},
				hint  			= hint_,
				device 			= device_,
				action 			= {command_,command_},
				arg 	  		= {arg_,arg_},
				arg_value 		= {-inverted_*delta_,inverted_*delta_}, 
				arg_lim   		= {{min_, min_ + delta_ * (count_ -1)},
								{min_, min_ + delta_ * (count_ -1)}},
				updatable 		= true, 
				use_OBB 		= true,
				class_vr		= {class_type.MULTY_TUMB, class_type.MULTY_TUMB},
				side			= {{},{BOX_SIDE_X_top, BOX_SIDE_X_bottom, BOX_SIDE_Z_top, BOX_SIDE_Z_bottom}},
				attach_left		= attach_left_ or nil,
				attach_right	= attach_right_ or nil,
			}
end

function multiposition_switch_limited(hint_,device_,command_,arg_,count_,delta_,min_,attach_left_,attach_right_)--.Button_8,30,6,0.1,0.0,-1)
    local min_   = min_ or 0
	local delta_ = delta_ or 0.5
	return  {	
				class 		= {class_type.TUMB,class_type.TUMB},
				hint  		= hint_,
				device 		= device_,
				action 		= {command_,command_},
				arg 	  	= {arg_,arg_},
				arg_value 	= {-delta_,delta_}, 
				arg_lim   	= {{min_, min_ + delta_ * (count_ -1)},
							   {min_, min_ + delta_ * (count_ -1)}},
				updatable 	= true, 
				use_OBB 	= true,
				cycle     	= false, 
				class_vr	= {class_type.MULTY_TUMB, class_type.MULTY_TUMB},
				side		= {{},{BOX_SIDE_X_top, BOX_SIDE_X_bottom, BOX_SIDE_Z_top, BOX_SIDE_Z_bottom}},
				attach_left	= attach_left_ or nil,
				attach_right= attach_right_ or nil,
			}
end

function multiposition_tumb_limited(hint_,device_,command_,arg_,count_,delta_,min_)
    local min_   = min_ or 0
	local delta_ = delta_ or 0.5
	return  {	
				class 		= {class_type.TUMB,class_type.TUMB},
				hint  		= hint_,
				device 		= device_,
				action 		= {command_,command_},
				arg 	  	= {arg_,arg_},
				arg_value 	= {-delta_,delta_}, 
				arg_lim   	= {{min_, min_ + delta_ * (count_ -1)},
							   {min_, min_ + delta_ * (count_ -1)}},
				updatable 	= true, 
				use_OBB 	= true,
				cycle     	= false, 
				side		= {{BOX_SIDE_Z_top},{BOX_SIDE_Z_bottom}},
			}
end

function multiposition_switch_axis(hint_,device_,command_,arg_,default_,gain_,animated_,animation_speed_,relative_,cycle_,attach_left_,attach_right_)

	local animated_  = animated_ or false
	local animation_speed_ = animation_speed_ or 5
	local relative_ = relative_ or false
	local cycle_ = cycle_ or false
	local gain = gain_ or 0.1
	local default = default_ or 1
	return  {	
				class 			= {class_type.LEV},
				hint  			= hint_,
				device 			= device_,
				action 			= {command_},
				arg 	  		= {arg_},
				arg_value 		= {default_}, 
				arg_lim   		= {{0,1}},
				animated   		= {animated_},
				animation_speed = {animation_speed_},
				gain			= {gain_},
				relative    	= {relative_},  
				cycle  			= cycle_,
				class_vr		= {class_type.MULTY_TUMB},
				side			= {{BOX_SIDE_X_top, BOX_SIDE_X_bottom, BOX_SIDE_Z_top, BOX_SIDE_Z_bottom}},
				attach_left		= attach_left_ or nil,
				attach_right	= attach_right_ or nil,
			}
end

function IFF_multiposition_spring_switch(hint_,device_,command1_, arg_)
	return  {	
				class 		= {class_type.BTN,class_type.BTN},
				hint  		= hint_,
				device 		= device_,
				action 		= {command1_ ,	command1_},
				stop_action = {command1_ , nil	},
				stop_value 	= {0.0,		   nil	},				
				arg 	  	= {arg_,arg_},
				arg_value 	= {-1,1}, 
				arg_lim   	= {{-1, 0},
							   {0, 1}},
				updatable 	= true, 
				use_release_message = {true,true},
				side		= {{BOX_SIDE_Z_top},{BOX_SIDE_Z_bottom}}
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
			cycle     	= false,
			side		= {{BOX_SIDE_Y_bottom},{BOX_SIDE_X_top, BOX_SIDE_X_bottom, BOX_SIDE_Z_top, BOX_SIDE_Z_bottom}},
			attach_left	= attach_left_ or nil,
			attach_right= attach_right_ or nil,
	}
end


function default_springloaded_switch(hint_, device_, command1_, command2_, value1_, value2_, value3_, arg_)
--[[ command1_ - tumbler's command,
	 command2_ - button's command
	 value1_ - tumbler's position
	 value2_ - center position
	 value3_ - button's position
]]
	return	{
				class 		= {class_type.TUMB, class_type.BTN},
				hint 		= hint_, 
				device 		= device_,
				action  	= {command1_ ,	command2_}, 
				stop_action = {0 , 	command2_}, 
				arg 		= {arg_,		arg_},
				stop_value 	= {nil,			value2_},
				arg_value 	= {value1_, 	value3_},
				arg_lim 	= {{value1_, value2_}, {value2_, value3_}}, 
				use_release_message = {false, false},
				side		= {{BOX_SIDE_Z_top},{BOX_SIDE_Z_bottom}}
			}
end

function default_springloaded_3pos_switch(hint_, device_, command1_, command2_, value1_, value2_, value3_, arg_)
--[[ command1_ - tumbler's command,
	 command2_ - button's command
	 value1_ - tumbler's position
	 value2_ - center position
	 value3_ - button's position
]]
	return	{
				class 		= {class_type.TUMB, class_type.TUMB},
				hint 		= hint_, 
				device 		= device_,
				action  	= {command1_ ,	command2_}, 
				stop_action = {command2_, 	command2_}, 
				arg 		= {arg_,		arg_},
				stop_value 	= {value2_,			value2_},
				arg_value 	= {value1_, 	value3_},
				arg_lim 	= {{value1_, value2_}, {value2_, value3_}}, 
				use_release_message = {false, false},
				class_vr	= {class_type.BTN,class_type.BTN},
				side		= {{BOX_SIDE_Z_top},{BOX_SIDE_Z_bottom}}
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
				use_OBB 	= true,
				class_vr	= {class_type.BTN_FIX},
				side		= {{BOX_SIDE_Y_bottom}}
			}
end

elements = {}

-----------------------------------------------------------------------------------------------
-- элементы управления кабины

-- Electrosystem
elements["BAT-SWITCHER-PTR"]			= default_2_position_tumb(_("Battery Switch, ON/OFF"), devices.ELEC_INTERFACE, device_commands.Button_1, 219)
elements["STARTER-GEN-SWITCHERr-PTR"]	= default_2_position_tumb(_("Starter/Stdby GEN Switch"), devices.ELEC_INTERFACE, device_commands.Button_3, 220)
elements["VM-SWITCHER-PTR"]				= multiposition_switch_limited(_("DC Voltmeter Selector"), devices.ELEC_INTERFACE, device_commands.Button_4, 218, 5, 0.1,0.0, {0,135}, {0,45})
elements["VM-SWITCHER-PTR"].turn_box = {180,0,0}
elements["NON-ESS-BUS-SWITCHERr-PTR"]	= default_2_position_tumb(_("Non-Essential Bus Switch, NORMAL/MANUAL"), devices.ELEC_INTERFACE, device_commands.Button_5, 221)
elements["PHASE-SWITCHER-PTR"]			= multiposition_switch_limited(_("AC Voltmeter Selector"), devices.ELEC_INTERFACE, device_commands.Button_7, 214, 3, 0.1,0.0, {0,135}, {0,45})
elements["PHASE-SWITCHER-PTR"].turn_box = {180,0,0}
elements["INVTR-SWITCHER-PTR"]			= default_3_position_tumb(_("Inverter Switch, MAIN/OFF/SPARE"), devices.ELEC_INTERFACE, device_commands.Button_8, 215, false, true)
elements["INVTR-SWITCHER-PTR"].sound = {{SOUND_INVERTER,SOUND_INVERTER},{SOUND_INVERTER,SOUND_INVERTER}}

-- Electrosystem circuit breakers
-------------------------------------------------------------------- Essential BUS. line 1------------------------------------------------------------------------
elements["IFF-API-PTR"]					= default_2_position_button(_("CB IFF APX 1 (N/F), ON/OFF"),			devices.ELEC_INTERFACE, cb_start_cmd, 285)
elements["IFF-APX-PTR"]					= default_2_position_button(_("CB IFF APX 2 (N/F), ON/OFF"),			devices.ELEC_INTERFACE, cb_start_cmd + 1, 287)
elements["PROX-WARN-PTR"]				= default_2_position_button(_("CB Prox. warn.(N/F), ON/OFF"),			devices.ELEC_INTERFACE, cb_start_cmd + 2, 289)
elements["MARKER-BEACON-PTR"]			= default_2_position_button(_("CB Marker beacon, ON/OFF"),				devices.ELEC_INTERFACE, cb_start_cmd + 3, 291)
elements["VHF-NAV-PTR"]					= default_2_position_button(_("CB VHF Nav. (ARN-82), ON/OFF"),			devices.ELEC_INTERFACE, cb_start_cmd + 4, 293)
elements["LF-NAV-PTR"]					= default_2_position_button(_("CB LF Nav. (ARN-83), ON/OFF"),			devices.ELEC_INTERFACE, cb_start_cmd + 5, 295)
elements["INTER-COM-CPLT-PTR"]			= default_2_position_button(_("CB Intercom CPLT(N/F), ON/OFF"),			devices.ELEC_INTERFACE, cb_start_cmd + 6, 297)
elements["INTER-COM-PLT-PTR"]			= default_2_position_button(_("CB Intercom PLT, ON/OFF"),				devices.ELEC_INTERFACE, cb_start_cmd + 7, 299)
elements["ARC-102-PTR"]					= default_2_position_button(_("CB ARC-102 HF Static INVTR(N/F), ON/OFF"),	devices.ELEC_INTERFACE, cb_start_cmd + 8, 349)
elements["HF-ANT-PTR"]					= default_2_position_button(_("CB HF ANT COUPLR(N/F), ON/OFF"),			devices.ELEC_INTERFACE, cb_start_cmd + 9, 351)
elements["HF-ARC-102-PTR"]				= default_2_position_button(_("CB HF ARC-102(N/F), ON/OFF"),			devices.ELEC_INTERFACE, cb_start_cmd + 10, 353)
elements["FM-ARC-54-PTR"]				= default_2_position_button(_("CB FM Radio, ON/OFF"),					devices.ELEC_INTERFACE, cb_start_cmd + 11, 355)
elements["UHF-ARC-51-PTR"]				= default_2_position_button(_("CB UHF Radio, ON/OFF"),					devices.ELEC_INTERFACE, cb_start_cmd + 12, 357)
elements["FM2-ARC-114-PTR"]				= default_2_position_button(_("CB FM 2 Radio(N/F), ON/OFF"),			devices.ELEC_INTERFACE, cb_start_cmd + 13, 359)
elements["VXFXCVR-COMM-PTR"]			= default_2_position_button(_("CB VHF AM Radio, ON/OFF"),				devices.ELEC_INTERFACE, cb_start_cmd + 14, 361)
-- here needs to be set for " ALTM APN 209"	
elements["PITOT-TUBE-PTR"]				= default_2_position_button(_("CB Pitot tube(N/F), ON/OFF"),			devices.ELEC_INTERFACE, cb_start_cmd + 16, 321)
-- here needs to be set for "PILOT 5 VOLT LIGHTS"
elements["RESCUE-CONT-PTR"]			    = default_2_position_button(_("CB Rescue hoist CTL(N/F), ON/OFF"),			devices.ELEC_INTERFACE, cb_start_cmd + 18, 345)
elements["RESCUE-CABLE-PTR"]			= default_2_position_button(_("CB Rescue hoist cable cutter N/F), ON/OFF"),	devices.ELEC_INTERFACE, cb_start_cmd + 19, 347)
----------------------------------------------------------------------------- Essential BUS. line 2----------------------------------------------------------------------
elements["WIND-SHIELD-CB-PTR"]			= default_2_position_button(_("CB Wind wiper CPLT, ON/OFF"),			devices.ELEC_INTERFACE, cb_start_cmd + 20, 301)
elements["WIND-SHIELD2-CB-PTR"]			= default_2_position_button(_("CB Wind wiper PLT, ON/OFF"),				devices.ELEC_INTERFACE, cb_start_cmd + 21, 303)
elements["K-Y20-PTR"]					= default_2_position_button(_("CB KY-28 voice security(N/F), ON/OFF"),	devices.ELEC_INTERFACE, cb_start_cmd + 22, 305)
elements["STARTER-RELAY-PTR"]			= default_2_position_button(_("CB Starter Relay(N/F), ON/OFF"),			devices.ELEC_INTERFACE, cb_start_cmd + 23, 403)
elements["SEARCH-LIGHT-PTR"]			= default_2_position_button(_("CB Search light power(N/F), ON/OFF"),	devices.ELEC_INTERFACE, cb_start_cmd + 24, 307)
elements["LDG-LIGHT-PTR"]				= default_2_position_button(_("CB Landing light power(N/F), ON/OFF"),	devices.ELEC_INTERFACE, cb_start_cmd + 25, 309)
elements["LDG-SEARCH-PTR"]				= default_2_position_button(_("CB Landing & Search light control(N/F), ON/OFF"),	devices.ELEC_INTERFACE, cb_start_cmd + 26, 311)
elements["ANTI-COLL-CB-PTR"]			= default_2_position_button(_("CB Anticollision light(N/F), ON/OFF"),	devices.ELEC_INTERFACE, cb_start_cmd + 27, 313)
elements["FUS-LIGHTS-PTR"]				= default_2_position_button(_("CB Fuselage lights(N/F), ON/OFF"),		devices.ELEC_INTERFACE, cb_start_cmd + 28, 363)
elements["NAV-LIGHTS-PTR"]				= default_2_position_button(_("CB Navigation lights(N/F), ON/OFF"),		devices.ELEC_INTERFACE, cb_start_cmd + 29, 365)
elements["DOME-LIGHTS-PTR"]				= default_2_position_button(_("CB Dome lights(N/F), ON/OFF"),			devices.ELEC_INTERFACE, cb_start_cmd + 30, 367)
elements["COCKPIT-LIGHTS-PTR"]			= default_2_position_button(_("CB Cockpit lights(N/F), ON/OFF"),		devices.ELEC_INTERFACE, cb_start_cmd + 31, 369)
elements["CAUTION-LIGHTS-PTR"]			= default_2_position_button(_("CB Caution lights(N/F), ON/OFF"),		devices.ELEC_INTERFACE, cb_start_cmd + 32, 371)
elements["CONSOLE-LIGHTS-PTR"]			= default_2_position_button(_("CB Console lights(N/F), ON/OFF"),		devices.ELEC_INTERFACE, cb_start_cmd + 33, 373)
elements["INST-PANEL-LIGHTS-PTR"]		= default_2_position_button(_("CB INST Panel lights(N/F), ON/OFF"),		devices.ELEC_INTERFACE, cb_start_cmd + 34, 375)
elements["INST-SEC-LIGHTS-PTR"]			= default_2_position_button(_("CB INST SEC lights(N/F), ON/OFF"),		devices.ELEC_INTERFACE, cb_start_cmd + 35, 377)
elements["OUTLET-VALVE-PTR"]			= default_2_position_button(_("CB Cabin heater (Outlet valve)(N/F), ON/OFF"),	devices.ELEC_INTERFACE, cb_start_cmd + 36, 323)
elements["AIR-VALVE-PTR"]				= default_2_position_button(_("CB Cabin heater (Air valve)(N/F), ON/OFF"),	devices.ELEC_INTERFACE, cb_start_cmd + 37, 325)
elements["RESCUE-POWER-PTR"]			= default_2_position_button(_("CB Rescue hoist PWR(N/F), ON/OFF"),		devices.ELEC_INTERFACE, cb_start_cmd + 38, 343)
------------------------------------------------------------------------- Essential BUS. line 3-----------------------------------------------------------------------
elements["RPM-WARN-PTR"]				= default_2_position_button(_("CB RPM Warning system(N/F), ON/OFF"),	devices.ELEC_INTERFACE, cb_start_cmd + 39, 327)
elements["ANTI-ICE-PTR"]				= default_2_position_button(_("CB Engine anti-ice(N/F), ON/OFF"),		devices.ELEC_INTERFACE, cb_start_cmd + 40, 329)
elements["FIRE-PTR"]					= default_2_position_button(_("CB Fire detector(N/F), ON/OFF"),			devices.ELEC_INTERFACE, cb_start_cmd + 41, 331)
elements["LH-FUEL-PTR"]					= default_2_position_button(_("CB LH fuel boost pump(N/F), ON/OFF"),	devices.ELEC_INTERFACE, cb_start_cmd + 42, 333)
elements["TURN-SLIP-PTR"]				= default_2_position_button(_("CB Turn & Slip indicator, ON/OFF"),		devices.ELEC_INTERFACE, cb_start_cmd + 43, 335)
elements["TEMP-IND-PTR"]				= default_2_position_button(_("CB TEMP indicator(N/F), ON/OFF"),		devices.ELEC_INTERFACE, cb_start_cmd + 44, 337)
elements["HYD-CONT-CB-PTR"]				= default_2_position_button(_("CB HYD Control(N/F), ON/OFF"),			devices.ELEC_INTERFACE, cb_start_cmd + 45, 339)
elements["FORCE-TRIM-CB-PTR"]			= default_2_position_button(_("CB FORCE Trim(N/F), ON/OFF"),			devices.ELEC_INTERFACE, cb_start_cmd + 47, 341)
elements["CARGO-HOOK-PTR"]			    = default_2_position_button(_("CB Cargo hook release(N/F), ON/OFF"),	devices.ELEC_INTERFACE, cb_start_cmd + 48, 379)
elements["EXT-STORES-PTR"]			    = default_2_position_button(_("CB EXT Stores jettison(N/F), ON/OFF"),	devices.ELEC_INTERFACE, cb_start_cmd + 49, 381)
elements["SPARE-INVTR-PTR"]				= default_2_position_button(_("CB Spare inverter PWR(N/F), ON/OFF"),	devices.ELEC_INTERFACE, cb_start_cmd + 50, 383)
elements["INVTR-PTR"]					= default_2_position_button(_("CB Inverter CTRL (N/F), ON/OFF"),		devices.ELEC_INTERFACE, cb_start_cmd + 51, 385)
elements["MAIN-INVTR-PTR"]				= default_2_position_button(_("CB Main inverter PWR(N/F), ON/OFF"),		devices.ELEC_INTERFACE, cb_start_cmd + 52, 387)
elements["GEN-BUS-PTR"]					= default_2_position_button(_("CB Generator & Bus Reset(N/F), ON/OFF"),	devices.ELEC_INTERFACE, cb_start_cmd + 53, 389)
elements["STBY-GEN-PTR"]				= default_2_position_button(_("CB STBY Generator Field(N/F), ON/OFF"),	devices.ELEC_INTERFACE, cb_start_cmd + 54, 391)
elements["GOV-CONT-PTR"]				= default_2_position_button(_("CB Governor Control(N/F), ON/OFF"),		devices.ELEC_INTERFACE, cb_start_cmd + 55, 393)
elements["IDLE-STOP-PTR"]				= default_2_position_button(_("CB IDLE Stop release(N/F), ON/OFF"),		devices.ELEC_INTERFACE, cb_start_cmd + 56, 395)
elements["RH-FUEL-PTR"]					= default_2_position_button(_("CB RH fuel boost pump(N/F), ON/OFF"),	devices.ELEC_INTERFACE, cb_start_cmd + 57, 397)
elements["FUEL-TRANS-PTR"]				= default_2_position_button(_("CB Fuel TRANS(N/F), ON/OFF"),			devices.ELEC_INTERFACE, cb_start_cmd + 58, 399)
elements["FUEL-VALVES-PTR"]				= default_2_position_button(_("CB Fuel valves(N/F), ON/OFF"),			devices.ELEC_INTERFACE, cb_start_cmd + 59, 401)
---------------------------------------------------------------------- Non Essential BUS-----------------------------------------------------------------------------
elements["HEATED-BLANKET-PTR"]			= default_2_position_button(_("CB Heated blanket 1(N/F), ON/OFF"),		devices.ELEC_INTERFACE, cb_start_cmd + 60, 315)
elements["HEATED-BLANKET2-PTR"]			= default_2_position_button(_("CB Heated blanket 2(N/F), ON/OFF"),		devices.ELEC_INTERFACE, cb_start_cmd + 61, 317)
elements["VOLT-METER-PTR"]				= default_2_position_button(_("CB Voltmeter Non Ess Bus(N/F), ON/OFF"),	devices.ELEC_INTERFACE, cb_start_cmd + 62, 319)
--------------------------------------------------------------------- other circuit breakers---------------------------------------------------------------------------
elements["IGNITER-SOL-PTR"]			    = default_2_position_button(_("CB Ignition system(N/F), ON/OFF"),		devices.ELEC_INTERFACE, cb_start_cmd + 64, 405)
----------------------------------------------------------------------AC BUS circuit breakers------------------------------------------------------------------------
elements["PILOT-ATTD1-PTR"]			    = default_2_position_button(_("CB Pilot ATTD1(N/F), ON/OFF"),			devices.ELEC_INTERFACE, cb_start_cmd + 65, 423)
elements["PILOT-ATTD2-PTR"]			    = default_2_position_button(_("CB Pilot ATTD2(N/F), ON/OFF"),			devices.ELEC_INTERFACE, cb_start_cmd + 66, 424)
elements["COPILOT-ATTD1-PTR"]			= default_2_position_button(_("CB Copilot ATTD1(N/F), ON/OFF"),			devices.ELEC_INTERFACE, cb_start_cmd + 67, 425)
elements["COPILOT-ATTD2--PTR"]			= default_2_position_button(_("CB Copilot ATTD2(N/F), ON/OFF"),			devices.ELEC_INTERFACE, cb_start_cmd + 68, 426)
elements["GYRO-CMPS-PTR"]			    = default_2_position_button(_("CB Gyro Cmps(N/F), ON/OFF"),				devices.ELEC_INTERFACE, cb_start_cmd + 69, 427)
elements["FUEL-QTY-PTR"]			    = default_2_position_button(_("CB Fuel Quantity(N/F), ON/OFF"),			devices.ELEC_INTERFACE, cb_start_cmd + 70, 428)
elements["TRANS-28V-PTR"]			    = default_2_position_button(_("CB 28V Trans(N/F), ON/OFF"),				devices.ELEC_INTERFACE, cb_start_cmd + 71, 429)
elements["FAIL-RELAY-PTR"]			    = default_2_position_button(_("CB Fail Relay(N/F), ON/OFF"),			devices.ELEC_INTERFACE, cb_start_cmd + 72, 430)
elements["PRESS-FUEL-PTR"]			    = default_2_position_button(_("CB Pressure Fuel(N/F), ON/OFF"),			devices.ELEC_INTERFACE, cb_start_cmd + 73, 431)
elements["PRESS-TORQ-PTR"]			    = default_2_position_button(_("CB Pressure Torque(N/F), ON/OFF"),		devices.ELEC_INTERFACE, cb_start_cmd + 74, 432)
elements["PRESS-XMSN-PTR"]			    = default_2_position_button(_("CB Pressure XMSN(N/F), ON/OFF"),			devices.ELEC_INTERFACE, cb_start_cmd + 75, 433)
elements["PRESS-ENG-PTR"]			    = default_2_position_button(_("CB Pressure Eng(N/F), ON/OFF"),			devices.ELEC_INTERFACE, cb_start_cmd + 76, 434)
elements["COURSE-IND-PTR"]			    = default_2_position_button(_("CB Course Ind(N/F), ON/OFF"),			devices.ELEC_INTERFACE, cb_start_cmd + 77, 435)



elements["MTR-PTR"]	= default_2_position_tumb(_("Pitot Heater Switch, ON/OFF"), devices.ELEC_INTERFACE, device_commands.Button_16, 238)
elements["MTR-PTR"].turn_box = {0,180,0}

elements["MAIN-GEN-SWITCHER-PTR"]	= default_springloaded_switch(_("Main generator Switch (Left button - ON/OFF. Right button RESET)"), devices.ELEC_INTERFACE, device_commands.Button_2,device_commands.Button_2, -1, 0, 1, 216)
elements["MAIN-GEN-SWITCHER-COVER-PTR"]	= default_2_position_cover(_("Main generator switch cover, OPEN/CLOSE"), devices.ELEC_INTERFACE, device_commands.Button_19, 217)

---------------------------UH-1H

elements["RESET-TEST-SWITCH-PTR"]	= default_springloaded_3pos_switch(_("Reset/Test switch"), devices.SYS_CONTROLLER, device_commands.Button_1, device_commands.Button_1, -1, 0, 1, 111)
elements["BRIGHT-DIM-SWITCH-PTR"]	= default_springloaded_3pos_switch(_("Bright/Dim switch"), devices.SYS_CONTROLLER, device_commands.Button_2, device_commands.Button_2, -1, 0, 1, 112)

-- Fuel system
elements["FUEL-PTR"]					= default_2_position_tumb(_("Main Fuel Switch, ON/OFF") , devices.FUELSYS_INTERFACE, device_commands.Button_1, 81)
elements["FUEL-GAUGE-PTR"]				= default_button(_("Test Fuel Gauge Button - Push to Test") , devices.FUELSYS_INTERFACE, device_commands.Button_2, 240)

--Transponder APX-72
elements["CODE-PTR"]					= IFF_multiposition_spring_switch(_("Code Knob"), devices.IFF, device_commands.Button_7,58)
elements["MASTER-CONTROL-PTR"]			= multiposition_switch_limited(_("Master Knob, OFF/STBY/LOW/NORM/EMER"), devices.IFF, device_commands.Button_8, 59, 5, 0.1)
elements["OUT-(AUDIO-LIGHT)-PTR"]		= default_3_position_tumb(_("Audio/light Switch") ,devices.IFF,device_commands.Button_9,60, false, true)
--arg_lim   	= {{-1,1},{-1,1}},

elements["TEST-M-1-PTR"]				= default_springloaded_switch(_("Test M-1 Switch") ,devices.IFF,device_commands.Button_10,device_commands.Button_10,-1,0,1,61)
elements["TEST-M-2-PTR"]				= default_springloaded_switch(_("Test M-2 Switch") ,devices.IFF,device_commands.Button_11,device_commands.Button_11,-1,0,1,62)
elements["TEST-M-3A-PTR"]				= default_springloaded_switch(_("Test M-3A Switch") ,devices.IFF,device_commands.Button_12,device_commands.Button_12,-1,0,1,63)
elements["TEST-M-3C-PTR"]				= default_springloaded_switch(_("Test M-C Switch") ,devices.IFF,device_commands.Button_13,device_commands.Button_13,-1,0,1,64)

elements["RAD-TEST-MON-SWITCH-PTR"]		= default_springloaded_switch(_("RAD Switch, TEST/MON") ,devices.IFF,device_commands.Button_14,device_commands.Button_14,-1,0,1,65)
elements["IDENT-MIC SWITCH-PTR"]		= default_springloaded_switch(_("Ident/Mic Switch") ,devices.IFF,device_commands.Button_15,device_commands.Button_15,-1,0,1,66)

elements["MODE-4-SWITCH-PTR"]			= default_2_position_tumb(_("IFF On/Out Switch") ,devices.IFF,device_commands.Button_16,67)

elements["MODE-1-WHEEL-1-WINDOW-PTR"]		= multiposition_switch(_("MODE1-WHEEL1") ,devices.IFF,device_commands.Button_1,68,4,0.33)
elements["MODE-1-WHEEL-2-WINDOW-PTR"]		= multiposition_switch(_("MODE1-WHEEL2") ,devices.IFF,device_commands.Button_2,69,8,0.11)

elements["MODE-3A-WHEEL-1-WINDOW-PTR"]		= multiposition_switch(_("MODE3A-WHEEL1"),devices.IFF,device_commands.Button_3,70,8,0.11)
elements["MODE-3A-WHEEL-2-WINDOW-PTR"]		= multiposition_switch(_("MODE3A-WHEEL2"),devices.IFF,device_commands.Button_4,71,8,0.11)
elements["MODE-3A-WHEEL-3-WINDOW-PTR"]		= multiposition_switch(_("MODE3A-WHEEL3"),devices.IFF,device_commands.Button_5,72,8,0.11)
elements["MODE-3A-WHEEL-4-WINDOW-PTR"]		= multiposition_switch(_("MODE3A-WHEEL4"),devices.IFF,device_commands.Button_6,73,8,0.11)

elements["REPLY-LIGHT-PTR"]		= default_button_axis(_("Reply Button"),devices.IFF,device_commands.Button_17,device_commands.Button_20,74,78)
elements["TEST-LIGHT-PTR"]		= default_button_axis(_("Test Button"),devices.IFF,device_commands.Button_18,device_commands.Button_21,75,79)

elements["WINDING/ADJUSTMENT-KNOB-PULL/PUSH-PTR"] = { 
	class = {class_type.BTN, class_type.LEV}, 
	hint = _("Winding/Adjustment Clock"), 
	device = devices.CLOCK, 
	action = {device_commands.Button_1, device_commands.Button_2},
	stop_action = {device_commands.Button_1,  0}, 
	is_repeatable = {}, 
	arg = {131, 130}, 
	arg_value = {1.0, 0.04}, 
	arg_lim = {{0, 1},  {0, 1}}, 
	relative = {false,true}, 
	gain = {1.0,  0.4}, 
	use_release_message = {true, false}, 
	use_OBB = true,
	class_vr = {class_type.BTN_FIX,0},
	side = {{BOX_SIDE_Y_bottom},{BOX_SIDE_X_top, BOX_SIDE_X_bottom, BOX_SIDE_Z_top, BOX_SIDE_Z_bottom}}
}

elements["THROTTLE-1-PTR"] =  default_axis_limited(_("Throttle"), devices.ENGINE_INTERFACE, device_commands.Button_24, 250, -0.1, true, false, {-1.0, 0.4})
elements["ENGINE-BTN-1-PTR"]		= default_2_position_tumb(_("Throttle Stop Switch, ON/OFF") , devices.ENGINE_INTERFACE, device_commands.Button_27, 206)
elements["ENGINE-BTN-1-PTR"].updatable = true
--copilot
elements["THROTTLE-2-PTR"] =  default_axis_limited(_("Throttle Copilot"), devices.ENGINE_INTERFACE, device_commands.Button_30, 250, -0.1, true, false, {-1.0, 0.4})
--elements["ENGINE-BTN-2-PTR"]		= default_2_position_tumb(_("Throttle Stop Switch Copilot, ON/OFF") , devices.ENGINE_INTERFACE, device_commands.Button_31, 213)
--elements["ENGINE-BTN-2-PTR"].updatable = true

elements["DE-ICE-PTR"]					= default_2_position_tumb(_("De-Ice Switch, ON/OFF") , devices.ENGINE_INTERFACE, device_commands.Button_2, 84)
elements["LOW-RPM-PTR"]					= default_2_position_tumb(_("Low RPM Warning Switch, AUDIO/OFF") , devices.ENGINE_INTERFACE, device_commands.Button_21, 80)
elements["CHIP-DET-PTR"]				= default_springloaded_3pos_switch(_("Chip Detector Switch, LMB - Tail Rotor / RMB - XMSN") , devices.ENGINE_INTERFACE, device_commands.Button_13, device_commands.Button_13, -1, 0, 1, 86)
elements["GOV-PTR"]						= default_2_position_tumb(_("Governor Switch, EMER/AUTO") , devices.ENGINE_INTERFACE, device_commands.Button_14, 85)
elements["HYD-CONT-PTR"]				= default_2_position_tumb(_("Hydraulic Control Switch, ON/OFF") , devices.HYDRO_SYS_INTERFACE, device_commands.Button_3, 90)
elements["FORCE-TRIM-PTR"]				= default_2_position_tumb(_("Force Trim Switch, ON/OFF") , devices.HYDRO_SYS_INTERFACE, device_commands.Button_4, 89)

elements["GOV-RPM-1-PTR"] 				= default_springloaded_3pos_switch(_("Governor RPM Switch, Decrease/Increase"), devices.ENGINE_INTERFACE, device_commands.Button_15,device_commands.Button_15, -1, 0, 1, 203)
--copilot
elements["GOV-RPM-2-PTR"] 				= default_springloaded_3pos_switch(_("Governor RPM Switch Copilot, Decrease/Increase"), devices.ENGINE_INTERFACE, device_commands.Button_29,device_commands.Button_29, -1, 0, 1, 210)

elements["FIRE-DETECTOR-PTR"]			= default_button(_("Fire Detector Test Button - Push to test") , devices.ENGINE_INTERFACE, device_commands.Button_23, 278)

--Copilot's attutude indicator
elements["CAGING-KNOB-ROTATION-PTR"] = 
{ 
	class = {class_type.BTN}, 
	hint = _("Cage Copilot's Attitude Indicator - Pull to cage"), 
	device = devices.ADI_OPERATOR, 
	action = {device_commands.Button_1}, 
	stop_action = {device_commands.Button_1}, 
	arg = {140}, 
	arg_value = {1.0}, 
	arg_lim = {{0, 1.0}}, 
	relative = {false}, 
	gain = {1.0}, 
	use_release_message = {true}, 
	use_OBB = true,
	side = {{BOX_SIDE_Y_bottom}}
}
	
elements["PITCH-ADJUSTMENT-PTR"]	= default_axis(_("Attitude Indicator Pitch Trim Knob"), devices.ADI_OPERATOR, device_commands.Button_2, 146, 0,0.1, false, false)

--Pilot's Attitude indicator
elements["PILOT-ATT-ROLL-ADJ-KNOB-PTR"]	= default_axis(_("Attitude Indicator Pitch Trim Knob"), devices.ADI_PILOT, device_commands.Button_1, 145, 0,0.1, false, false, true)
elements["PILOT-ATT-PITCH-ADJ-KNOB-PTR"]= default_axis(_("Attitude Indicator Roll Trim Knob"), devices.ADI_PILOT, device_commands.Button_2, 144, 0,0.1, false, false, true,{135, -45}, {45,-45})

--Copilot's altimeter
elements["SET-PRESSURE-KNOB-PTR"]  		= default_axis(_("Pressure Adjustment Knob"), devices.AAU32, device_commands.Button_1, 172, 0, 0.2, false, true)

--Pilot's altimeter
elements["PILOT-ALT-SET-KNOB-PTR"]  	= default_axis(_("Pressure Adjustment Knob"), devices.AAU7, device_commands.Button_1, 181, 0, 0.4, false, true)

--ARC-134
elements["COMMUNICATION-TEST-SWITCH-PTR"]	= default_button(_("Comm Test Button - Push to test") , devices.VHF_ARC_134, device_commands.Button_2, 6)
elements["COMMUNICATION-TEST-SWITCH-PTR"].turn_box = {180,90,0}
elements["MHZ-SELECTOR-PTR"] = {
	class = {class_type.TUMB, class_type.TUMB, class_type.LEV},
	hint = _("Frequency MHz / Power. Right mouse click to cycle power. Rotate mouse wheel to change frequency value"),
	device = devices.VHF_ARC_134,
	action = {device_commands.Button_1, device_commands.Button_1, device_commands.Button_4},
	arg = {5, 5, 7},
	arg_value = {-0.1, 0.1, 0.1},
	arg_lim = {{0.8, 1.0}, {0.8, 1.0}, {0.0, 1.0}},
	relative = {false, false, true},
	animated   = {false, false, true},
	animation_speed = {0.0, 0.0, 0.7},
	gain = {0.05, 0.05, -0.1},
	--cycle = false,
	sound = {{},{},{SOUND_ROTARY,SOUND_ROTARY}},
	class_vr = {0,0, class_type.MULTY_TUMB},
	side = {{BOX_SIDE_Z_bottom},{BOX_SIDE_Z_top},{BOX_SIDE_X_top, BOX_SIDE_X_bottom}}
}

elements["KHZ-SELECTOR-PTR"] = {
	class = {class_type.TUMB, class_type.TUMB, class_type.LEV},
	hint = _("Frequency kHz / Volume. Rotate mouse wheel to change frequency value. Left or Right click to adjust volume"),
	device = devices.VHF_ARC_134,
	action = {device_commands.Button_3, device_commands.Button_3, device_commands.Button_5},
	arg = {9, 9, 8},
	arg_value = {-0.1, 0.1, 0.1},
	arg_lim = {{0.0, 0.65}, {0.0, 0.65}, {0.0, 1.0}},
	relative = {false, false, true},
	animated   = {true, true, true},
	animation_speed = {0.7, 0.7, 0.7},
	gain = {0.05, 0.05, -0.1},
	--cycle = false,
	sound = {{},{},{SOUND_ROTARY,SOUND_ROTARY}},
	class_vr = {0,0, class_type.MULTY_TUMB},
	side = {{BOX_SIDE_Z_bottom},{BOX_SIDE_Z_top},{BOX_SIDE_X_top, BOX_SIDE_X_bottom}}
}

--Intercom Control Panel
elements["SDP-VOLUME-CONTROL-PTR"]  = default_axis_limited(_("Intercom Volume Knob"),devices.INTERCOM,device_commands.Button_7,29,-0.1,true,false,{0.3,1.0}, {0,120}, {0,60})
elements["SDP-VOLUME-CONTROL-PTR"].turn_box = {180,0,0}
elements["RECEIVER-1-PTR"]			= default_2_position_tumb(_("VHF FM Radio Receiver Switch, ON/OFF") , devices.INTERCOM, device_commands.Button_1, 23)
elements["RECEIVER-2-PTR"]			= default_2_position_tumb(_("UHF Radio Receiver Switch, ON/OFF") , devices.INTERCOM, device_commands.Button_2, 24)
elements["RECEIVER-3-PTR"]			= default_2_position_tumb(_("VHF AM Radio Receiver Switch, ON/OFF") , devices.INTERCOM, device_commands.Button_3, 25)
elements["RECEIVER-4-PTR"]			= default_2_position_tumb(_("Receiver 4 N/F Switch, ON/OFF") , devices.INTERCOM, device_commands.Button_4, 26)
elements["RECEIVER-INT-PTR"]		= default_2_position_tumb(_("INT Receiver Switch, ON/OFF") , devices.INTERCOM, device_commands.Button_5, 27)
elements["RECEIVER-NAV-PTR"]		= default_2_position_tumb(_("Receiver NAV Switch, ON/OFF") , devices.INTERCOM, device_commands.Button_6, 28)
elements["TRANSMIT-INTERPHONE-SWITCH-PTR"]	= multiposition_switch_limited(_("Intercom Mode (PVT - hot line; INT - interphone; 1 - VHF FM transmitter; 2 - UHF transmitter; 3 - VHF AM transmitter; 4 - Not used)"),devices.INTERCOM,device_commands.Button_8,30,6,0.1,0.0, {0,120}, {0,60})
elements["TRANSMIT-INTERPHONE-SWITCH-PTR"].turn_box = {180,0,0}

elements["RADIO/ICS-1-PTR"] = multiposition_switch(_("Radio/ICS Switch") , devices.INTERCOM, device_commands.Button_9, 194, 3, 0.5)
elements["RADIO/ICS-1-PTR"].side = {}

--ARC 51BX UHF Raido multiposition_switch_axis(hint_,device_,command_,arg_,default_,gain_,animated_,animation_speed_,relative_,cycle_)
elements["PRESET-CHANNEL-PTR"] 		= multiposition_switch_limited(_("Preset Channel Selector"), devices.UHF_ARC_51, device_commands.Button_1, 16,20,0.05)
elements["10-MHZ-CONTROL-PTR"] 		= multiposition_switch_axis(_("10 MHz Selector"), devices.UHF_ARC_51, device_commands.Button_2, 18, 1, 0.1, true, 0.7,true, true, {0,120}, {0,60})
elements["10-MHZ-CONTROL-PTR"].turn_box = {180,0,0}
elements["1-MHZ-CONTROL-PTR"] 		= multiposition_switch_axis(_("1 MHz Selector"), devices.UHF_ARC_51, device_commands.Button_3, 19, 1, 0.1, true, 0.7,true, true, {0,120}, {0,60})
elements["1-MHZ-CONTROL-PTR"].turn_box = {180,0,0}
elements["0.05-MHZ-CONTROL-PTR"] 	= multiposition_switch_axis(_("50 kHz Selector"), devices.UHF_ARC_51, device_commands.Button_4, 20, 1, 0.1, true, 0.7,true, true, {0,120}, {0,60})
elements["0.05-MHZ-CONTROL-PTR"].turn_box = {180,0,0}

elements["MODE-SELECT-SWITCH-PTR"] 	   = multiposition_switch_limited(_("Frequency Mode Dial") , devices.UHF_ARC_51, device_commands.Button_5, 15, 3, 0.1)
elements["FUNCTION-SELECT-SWITCH-PTR"] = multiposition_switch_limited(_("Function Dial") , devices.UHF_ARC_51, device_commands.Button_6, 17, 4, 0.1)
elements["SQ-DISABLE-SWITCH-PTR"]	   = default_2_position_tumb(_("Squelch Disable Switch, ON/OFF"), devices.UHF_ARC_51, device_commands.Button_7, 22)
elements["UHF-VOLUME-CONTROL-PTR"] 	   = default_axis(_("Volume Knob"), devices.UHF_ARC_51, device_commands.Button_8, 21,1.0,0.1)

--VHF ARC 131
elements["FREQUENCY-SELECTOR-1-PTR"]	= multiposition_tumb_limited(_("Frequency Tens MHz Selector") , devices.VHF_ARC_131, device_commands.Button_1, 31, 5, 0.1,0.3)
elements["FREQUENCY-SELECTOR-2-PTR"]	= multiposition_tumb_limited(_("Frequency Ones MHz Selector") , devices.VHF_ARC_131, device_commands.Button_2, 32, 10, 0.1)
elements["FREQUENCY-SELECTOR-3-PTR"] 	= multiposition_tumb_limited(_("Frequency Decimals MHz Selector") , devices.VHF_ARC_131, device_commands.Button_3, 33, 10, 0.1)
elements["FREQUENCY-SELECTOR-4-PTR"] 	= multiposition_tumb_limited(_("Frequency Hundredths MHz Selector") , devices.VHF_ARC_131, device_commands.Button_4, 34, 2, 0.1)
elements["MODE-SWITCH-PTR"] 			= multiposition_switch_limited(_("Mode Switch, OFF/TR/RETRAN(N/F)/HOME(N/F)") , devices.VHF_ARC_131, device_commands.Button_7, 35, 4, 0.1)
elements["SQUELCH-SWITCH-PTR"] 			= multiposition_switch_limited(_("Squelch Mode Switch, DIS/CARR/TONE") , devices.VHF_ARC_131, device_commands.Button_5, 36, 3, 0.1)
elements["VOLUME-CONTROL-PTR"]  		= default_axis_limited(_("Volume Knob"),devices.VHF_ARC_131,device_commands.Button_6,37,-0.1,true,false,{0.3,1.0}, {0,120}, {0,60})
elements["VOLUME-CONTROL-PTR"].turn_box = {180,0,0}

--ARN-82
elements["WHOLE-MHZ-SELECTOR-KNOB-PTR"] = {
	class = {class_type.TUMB, class_type.TUMB, class_type.LEV},
	hint = _("Frequency MHz / Power. Right mouse click to cycle power. Rotate mouse wheel to change frequency value"),
	device = devices.ARN_82,
	action = {device_commands.Button_3, device_commands.Button_3, device_commands.Button_1},
	arg = {51, 51, 52},
	arg_value = {-0.1, 0.1, 0.1},
	arg_lim = {{0.8, 1.0}, {0.8, 1.0}, {0.0, 1.0}},
	relative = {false, false, true},
	animated   = {false, false, true},
	animation_speed = {0.0, 0.0, 0.7},
	gain = {0.05, 0.05, -0.1},
	--cycle = false,
	sound = {{},{},{SOUND_ROTARY,SOUND_ROTARY}},
	turn_box = {180,0,0},
	class_vr = {0,0, class_type.MULTY_TUMB},
	side = {{BOX_SIDE_Z_bottom},{BOX_SIDE_Z_top},{BOX_SIDE_X_top, BOX_SIDE_X_bottom}},
	attach_left	= {0,120},
	attach_right= {0,30},
}

elements["FRACTIONAL-MHZ-SELECTOR-KNOB-KNOB-PTR"] = {
	class = {class_type.TUMB, class_type.TUMB, class_type.LEV},
	hint = _("Frequency kHz / Volume. Rotate mouse wheel to change frequency value. Left or Right click to adjust volume"),
	device = devices.ARN_82,
	action = {device_commands.Button_4, device_commands.Button_4, device_commands.Button_2},
	arg = {54, 54, 53},
	arg_value = {-0.1, 0.1, 0.1},
	arg_lim = {{0.0, 0.65}, {0.0, 0.65}, {0.0, 1.0}},
	relative = {false, false, true},
	animated   = {true, true, true},
	animation_speed = {0.7, 0.7, 0.7},
	gain = {0.05, 0.05, -0.1},
	--cycle = false,
	sound = {{},{},{SOUND_ROTARY,SOUND_ROTARY}},
	turn_box = {180,0,0},
	class_vr = {0,0, class_type.MULTY_TUMB},
	side = {{BOX_SIDE_Z_bottom},{BOX_SIDE_Z_top},{BOX_SIDE_X_top, BOX_SIDE_X_bottom}},
	attach_left	= {0,120},
	attach_right= {0,30},
}


--Marker beakon
elements["VOLUME-OFF-INCR-CONTROL-PTR"]  	=  default_axis_limited(_("Marker Beacon Knob, ON/OFF/Volume"), devices.MARKER_BEACON, device_commands.Button_1, 57, 0.1,false,false, {0, 1})
elements["SENSING-SWITCH-PTR"]  			=  default_2_position_tumb(_("Marker Beacon Sensing Switch, HIGH/LOW"), devices.MARKER_BEACON, device_commands.Button_2, 55)

-- AN/ARN-83
elements["LOOP-L-R-SWITCH-PTR"]	=  {	
				class 		= {class_type.BTN,class_type.BTN},
				hint  		= _("ADF Loop Antenna Speed Switch, L/R"),
				device 		= devices.ADF_ARN_83,
				action 		= {device_commands.Button_5 ,	device_commands.Button_5},
				stop_action = {device_commands.Button_5 ,   device_commands.Button_5},
				stop_value 	= {0.2,0.2},				
				arg 	  	= {42,42},
				arg_value 	= {0.1,0.3}, 
				arg_lim   	= {{0.2, 0.1},
							   {0.2, 0.3}},
				updatable 	= true, 
				--use_OBB 	= true,
				use_release_message = {true,true},
				side = {{BOX_SIDE_X_top}, {BOX_SIDE_X_bottom}}
			}

elements["LOOP-L-PTR"]  = default_1_position_tumb(_("Loop Left Hight Speed") ,devices.ADF_ARN_83,device_commands.Button_5,42,0.0,{0.0,0.0})
elements["LOOP-L1-PTR"]	= default_button(_("Loop Left Low Speed") , devices.ADF_ARN_83, device_commands.Button_5, 42,0.1,{0.2,0.1})
elements["LOOP-O-PTR"]  = default_1_position_tumb(_("Loop Off") ,devices.ADF_ARN_83,device_commands.Button_5,42,0.2,{0.2,0.2})
elements["LOOP-R1-PTR"]	= default_button(_("Loop Right Low Speed") , devices.ADF_ARN_83, device_commands.Button_5, 42,0.3,{0.2,0.3})
elements["LOOP-R-PTR"]  = default_1_position_tumb(_("Loop Right Hight Speed") ,devices.ADF_ARN_83,device_commands.Button_5,42,0.4,{0.4,0.4})

elements["BFO-SWITCH-PTR"] 					= default_2_position_tumb(_("BFO Switch (N/F), BFO/OFF"), devices.ADF_ARN_83, device_commands.Button_6, 41)
elements["BFO-SWITCH-PTR"].turn_box = {0,90,0}

elements["GAIN-CONTROL-PTR"] = {
	class = {class_type.TUMB, class_type.TUMB, class_type.LEV},
	hint = _("Gain control / Mode. Right mouse click to cycle mode. Rotate mouse wheel to adjust gain"),
	device = devices.ADF_ARN_83,
	action = {device_commands.Button_1, device_commands.Button_1, device_commands.Button_4},
	arg = {43, 43, 44},
	arg_value = {-0.1, 0.1, 0.1},
	arg_lim = {{0.0, 0.3}, {0.0, 0.3}, {0.0, 1.0}},
	relative = {false, false, false},
	animated   = {false, false, false},
	animation_speed = {0.0, 0.0, 0.0},
	gain = {0.1, 0.1, -0.1},
	--cycle = false,
	turn_box = {180,0,0},
	side = {{BOX_SIDE_Z_bottom},{BOX_SIDE_Z_top},{BOX_SIDE_X_top, BOX_SIDE_X_bottom}},
	attach_left	= {0,120},
	attach_right= {0,30},
}

elements["TUNE-CONTROL-PTR"] = {
	class = {class_type.TUMB, class_type.TUMB, class_type.LEV},
	hint = _("Tune control / Band selection. Right mouse click to select a band. Rotate mouse wheel to adjust tune"),
	device = devices.ADF_ARN_83,
	action = {device_commands.Button_2, device_commands.Button_2, device_commands.Button_3},
	arg = {38, 38, 39},
	arg_value = {-1, 1, -0.1},
	arg_lim = {{-1, 1}, {-1, 1}, {0.0, 1.0}},
	relative = {false, false, true},
	animated   = {true, true, false},
	animation_speed = {4.0, 4.0, 0.0},
	gain = {1, 1, -0.05},
	--cycle = false,
	side = {{BOX_SIDE_Z_bottom},{BOX_SIDE_Z_top},{BOX_SIDE_X_top, BOX_SIDE_X_bottom}}
}

--Nav lights
elements["NVG-POSITION-LTS-PTR"]			= multiposition_switch_limited(_("Navigation Lights Switch, OFF/1/2/3/4/BRT") , devices.NAVLIGHT_SYSTEM, device_commands.Button_1, 222, 6, 0.1)
elements["STEADY-OFF-FLASH-PTR"]			= default_3_position_tumb(_("Position Lights Switch, STEADY/OFF/FLASH") , devices.NAVLIGHT_SYSTEM, device_commands.Button_2, 223, true, true)
elements["DIM-BRIGHT-PTR"] 					= default_2_position_tumb(_("Position Lights Switch, DIM/BRIGHT"), devices.NAVLIGHT_SYSTEM, device_commands.Button_3, 224)
elements["DIM-BRIGHT-PTR"].turn_box = {0,180,0}
elements["ANTI-COLL-PTR"] 					= default_2_position_tumb(_("Anti-Collision Lights Switch, ON/OFF"), devices.NAVLIGHT_SYSTEM, device_commands.Button_4, 225)
elements["ANTI-COLL-PTR"].turn_box = {0,180,0}
elements["LDG-LT-1-PTR"] 					= default_2_position_tumb(_("Landing Light Switch, ON/OFF"), devices.NAVLIGHT_SYSTEM, device_commands.Button_5, 202)
elements["SL-ON-OFF-STOW-1-PTR"] 			= default_3_position_tumb(_("Search Light Switch, ON/OFF/STOW"), devices.NAVLIGHT_SYSTEM, device_commands.Button_6, 201, true, true)
elements["LDG-LT-2-1-PTR"] 					= default_3_position_tumb(_("Landing Light Control Switch, EXT/OFF/RETR"), devices.NAVLIGHT_SYSTEM, device_commands.Button_7, 205, true, true)

--Light System
elements["CONSOLE-PTR"] 					= default_axis_limited(_("Overhead Console Panel Lights Brightness Rheostat"), devices.NAVLIGHT_SYSTEM, device_commands.Button_15, 230, 0.2, true, false, {0.0, 1.0})
elements["PED-PTR"]		 					= default_axis_limited(_("Pedestal Lights Brightness Rheostat"), devices.NAVLIGHT_SYSTEM, device_commands.Button_16, 231, 0.2, true, false, {0.0, 1.0})
elements["SEC-PTR"] 						= default_axis_limited(_("Secondary Instrument Lights Brightness Rheostat"), devices.NAVLIGHT_SYSTEM, device_commands.Button_17, 232, 0.2, true, false, {0.0, 1.0})
elements["ENGINE-PTR"] 						= default_axis_limited(_("Engine Instrument Lights Brightness Rheostat"), devices.NAVLIGHT_SYSTEM, device_commands.Button_18, 233, 0.2, true, false, {0.0, 1.0})
elements["COPILOT-PTR"] 					= default_axis_limited(_("Copilot Instrument Lights Brightness Rheostat"), devices.NAVLIGHT_SYSTEM, device_commands.Button_19, 234, 0.2, true, false, {0.0, 1.0})
elements["PILOT-PTR"] 						= default_axis_limited(_("Pilot Instrument Lights Brightness Rheostat"), devices.NAVLIGHT_SYSTEM, device_commands.Button_20, 235, 0.2, true, false, {0.0, 1.0})
elements["FWD-PTR"] 						= default_3_position_tumb(_("Dome Light Switch, WHITE/OFF/GREEN"), devices.NAVLIGHT_SYSTEM, device_commands.Button_21, 226, true, true)

elements["BLEND-AIR-PTR"]				= multiposition_switch_limited(_("Bleed Air Switch, OFF/1/2/3/4") , devices.HEATING_SYSTEM, device_commands.Button_1, 236, 5, 0.1)

-- GCI(ID-998/ASN)
elements["HDG-SET-PTR"]	 	= default_axis(_("Heading Set Knob"),devices.GMCS, device_commands.Button_3, 163, 1.0, 0.1, false, true)
elements["HDG-SYNC-PTR"] 	= default_axis(_("Compass Synchronizing Knob"),devices.GMCS, device_commands.Button_5, 161, 1.0, 0.05, false, true)
elements["ADF-VOR-PTR"]	 	= default_2_position_tumb(_("ADF/VOR Control Switch")	,devices.GMCS,device_commands.Button_4,164)
elements["DG-SLAVE-PTR"]	= default_2_position_tumb(_("Gyro Mode Switch, DG/Slave"), devices.GMCS, device_commands.Button_2, 241)

elements["CDI-OBS-PTR"] = default_axis(_("Course Select Knob"),devices.COURSE_IND, device_commands.Button_1, 155, 1.0, 0.1, false, true)

--weapon system
elements["ARMED-SWITCH-PTR"]			= default_3_position_tumb(_("Armament Switch, ARMED/SAFE/OFF"), devices.WEAPON_SYS, device_commands.Button_8, 252, true, true)
elements["LRGUN-SWITCH-PTR"]			= default_3_position_tumb(_("Gun Selector Switch, LEFT/ALL/RIGHT"), devices.WEAPON_SYS, device_commands.Button_9, 253, true, true)
elements["762-SWITCH-PTR"]				= default_3_position_tumb(_("Armament Selector Switch, 7.62/2.75/40"), devices.WEAPON_SYS, device_commands.Button_10, 256, true, true)
elements["RKT-PAIR-PTR"]				= multiposition_switch_limited(_("Rocket Pair Selector Switch") , devices.WEAPON_SYS, device_commands.Button_11, 257, 8, 0.1)
elements["RKT-RESET-PTR"]				= default_button(_("Rocket Reset Button - Push to reset") , devices.WEAPON_SYS, device_commands.Button_12, 258)
elements["JETT-COVER-PTR"]				= default_2_position_cover(_("Jettison Switch Cover, OPEN/CLOSE"), devices.WEAPON_SYS, device_commands.Button_13, 259)
elements["JETT-SWITCH-PTR"]				= default_button(_("Jettison Switch"), devices.WEAPON_SYS, device_commands.Button_14, 260)
elements["JETT-SWITCH-PTR"].side = {{BOX_SIDE_Z_bottom}}

--sighting station
elements["SIGHT-BRIGHT-SWITCHER-PTR"] = default_axis(_("Sighting Station Intensity Knob"),devices.FLEX_SIGHT, device_commands.Button_1, 281, 1.0, 0.1, false, false)
elements["SIGHT-BRIGHT-SWITCHER-PTR"].updatable = true
elements["SIGHT-TUMB-PTR"]			  = default_3_position_tumb(_("Sighting Station Lamp Switch, BACKUP/OFF/MAIN"), devices.FLEX_SIGHT, device_commands.Button_3, 408,false,true)
elements["SIGHT-TUMB-PTR"].turn_box = {0,90,0}

elements["PILOT-SIGHT-POS-PTR"] = default_1_position_tumb(_("Pilot Sight, Armed/Safe"), devices.PILOT_SIGHT, device_commands.Button_5, 438, 1, {0,1})
elements["PILOT-SIGHT-SWITCH-PTR"] = default_2_position_tumb(_("Pilot Sight Switch, ON/OFF"), devices.PILOT_SIGHT, device_commands.Button_6, 439)
elements["PILOT-SIGHT-SWITCH-PTR"].turn_box = {-90,0,0}
elements["PILOT-SIGHT-BRIGHT-PTR"] = default_axis(_("Pilot Sighting Station Intensity Knob"),devices.PILOT_SIGHT, device_commands.Button_1, 440, 0.0, 0.1, false, false, nil,{90,0},{30,0})
elements["PILOT-SIGHT-BRIGHT-PTR"].updatable = true
elements["PILOT-SIGHT-SCALE-PTR"] 	= default_axis_limited(_("Sight Elevation Knob"), devices.PILOT_SIGHT, device_commands.Button_3, 441, 0.1, true, false, {-1.0, 1.0},{90,0},{0,90})
elements["PILOT-SIGHT-SCALE-PTR"].updatable = true

--- Windshield Wipers
elements["WIPER PILOT-BOTH-COPILOT-PTR"]	= default_3_position_tumb(_("Wiper Selector Switch, PILOT/BOTH/COPILOT"), devices.CPT_MECH, device_commands.Button_2, 227, true, true)
elements["WIPERS-PTR"]						= IFF_multiposition_spring_switch(_("Wipers Speed Switch, PARK/OFF/LOW/MED/HIGH"), devices.CPT_MECH, device_commands.Button_1,229)
 --multiposition_switch(_("Wipers Speed") , devices.CPT_MECH, device_commands.Button_1, 229, 5, 0.1)

--- Stick
elements["FORCE-TRIM-1-PTR"] = default_button(_("Force Trim Button") , devices.CONTROL_SYSTEM, device_commands.Button_1, 189)
elements["FORCE-TRIM-1-PTR"].updatable = true
elements["FORCE-TRIM-1-PTR"].side = {}
elements["FORCE-TRIM-2-PTR"] = default_button(_("Force Trim Button") , devices.CONTROL_SYSTEM, device_commands.Button_2, 193)
elements["FORCE-TRIM-2-PTR"].updatable = true
elements["FORCE-TRIM-2-PTR"].side = {}

--Cargo Equipment
elements["CARGO-RELEASE-1-PTR"]	= default_button(_("Cargo Release Pilot"), devices.EXT_CARGO_EQUIPMENT, device_commands.Button_1, 195,1,{0,1})
elements["CARGO-RELEASE-1-PTR"].updatable = true
elements["CARGO-RELEASE-1-PTR"].side = {}
elements["CARGO-RELEASE-2-PTR"]	= default_button(_("Cargo Release CoPilot"), devices.EXT_CARGO_EQUIPMENT, device_commands.Button_2, 198,1,{0,1})
elements["CARGO-RELEASE-2-PTR"].updatable = true
elements["CARGO-RELEASE-2-PTR"].side = {}
elements["CARGO-REL-PTR"]	= default_2_position_tumb(_("Cargo Safety"), devices.EXT_CARGO_EQUIPMENT, device_commands.Button_3,228)
elements["CARGO-REL-PTR"].updatable = true


elements["RIPPLE-FIRE-COVER-PTR"]	    = default_2_position_cover(_("Ripple Fire Cover, OPEN/CLOSE"), devices.XM_130, device_commands.Button_1, 450)
elements["RIPPLE-FIRE-PTR"]			    = default_2_position_tumb(_("Ripple Fire Switch, ON/OFF"), devices.XM_130, device_commands.Button_2, 451)
elements["CHAFF-ARM-SWITCH-PTR"]	    = default_2_position_tumb(_("ARM Switch, SAFE/ARM"), devices.XM_130, device_commands.Button_5, 456)
elements["PGRM-SWITCH-PTR"]			    = default_2_position_tumb(_("Chaff Mode Switch, MAN/PGRM"), devices.XM_130, device_commands.Button_9, 459)
elements["FLARE-DISP-PTR"] 				= default_button(_("Flare Dispense Button - Push to dispense") , devices.XM_130, device_commands.Button_6, 464)
elements["CHAFF-ARM-TEST-PTR"] 			= default_button(_("Armed Lamp Test Button - Push to test") , devices.XM_130, device_commands.Button_10, 457)

elements["FLARE-PTR"] = { 
	class = {class_type.BTN, class_type.LEV}, 
	hint = _("Flare counter Reset. Rotate mouse wheel to set Number"), 
	device = devices.XM_130, 
	action = {device_commands.Button_3, device_commands.Button_4},
	stop_action = {device_commands.Button_3,  0}, 
	is_repeatable = {}, 
	arg = {453, 452}, 
	arg_value = {1.0, 0.0}, 
	arg_lim = {{0, 1},  {0, 1}}, 
	relative = {false,true}, 
	gain = {1.0,  -0.2}, 
	use_release_message = {true, false}, 
	use_OBB = true,
	class_vr = {0, class_type.MULTY_TUMB},
	side = {{BOX_SIDE_Y_bottom},{BOX_SIDE_X_top, BOX_SIDE_X_bottom, BOX_SIDE_Z_top, BOX_SIDE_Z_bottom}}	
}

elements["CHAFF-PTR"] = { 
	class = {class_type.BTN, class_type.LEV}, 
	hint = _("Chaff counter Reset. Rotate mouse wheel to set Number"), 
	device = devices.XM_130, 
	action = {device_commands.Button_7, device_commands.Button_8},
	stop_action = {device_commands.Button_7,  0}, 
	is_repeatable = {}, 
	arg = {455, 454}, 
	arg_value = {1.0, 0.0}, 
	arg_lim = {{0, 1},  {0, 1}}, 
	relative = {false,true}, 
	gain = {1.0,  -0.2}, 
	use_release_message = {true, false}, 
	use_OBB = true,
	class_vr = {0, class_type.MULTY_TUMB},
	side = {{BOX_SIDE_Y_bottom},{BOX_SIDE_X_top, BOX_SIDE_X_bottom, BOX_SIDE_Z_top, BOX_SIDE_Z_bottom}}
}


--Radar Altimeter
elements["RADAR-ALT-PTR"] = default_2_position_tumb(_("Radar Altimeter Power Switch, ON/OFF"), devices.RADAR_ALTIMETER, device_commands.Button_7, 449)

elements["PITCH-LO-ALT-PTR"] = default_axis(_("Low Altitude Setting Knob"),devices.RADAR_ALTIMETER, device_commands.Button_2, 445, 1.0, 0.1, false, true)

elements["PITCH-HI-ALT-PTR"] = { 
	class = {class_type.BTN, class_type.LEV}, 
	hint = _("Test / Hight Set. Left mouse click to Test. Rotate mouse wheel to set Hight"), 
	device = devices.RADAR_ALTIMETER, 
	action = {device_commands.Button_1, device_commands.Button_3},
	stop_action = {device_commands.Button_1,  0}, 
	is_repeatable = {}, 
	arg = {446, 448}, 
	arg_value = {1.0, 0.0}, 
	arg_lim = {{0, 1},  {0, 1}}, 
	relative = {false,true}, 
	gain = {1.0,  0.2}, 
	use_release_message = {true, false}, 
	use_OBB = true,
	turn_box = {-90,0,0},
	side = {{BOX_SIDE_Y_bottom},{BOX_SIDE_X_top, BOX_SIDE_X_bottom, BOX_SIDE_Z_top, BOX_SIDE_Z_bottom}}
}

for i,o in pairs(elements) do
	if  o.class[1] == class_type.TUMB or 
	   (o.class[2]  and o.class[2] == class_type.TUMB) or
	   (o.class[3]  and o.class[3] == class_type.TUMB)  then
	   o.updatable = true
	   o.use_OBB   = true
	end
end

elements["DOOR_L-PTR"]				= default_button(_("Open Left Door") , devices.CPT_MECH, device_commands.Button_5, 419, 1, {0,1}, false)
elements["DOOR_L-PTR"].updatable = true
elements["DOOR_R-PTR"]				= default_button(_("Open Right Door") , devices.CPT_MECH, device_commands.Button_6, 421, 1, {0,1}, false)
elements["DOOR_R-PTR"].updatable = true