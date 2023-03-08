dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."Hint_localizer.lua")

cursor_mode = 
{ 
    CUMODE_CLICKABLE = 0,
    CUMODE_CLICKABLE_AND_CAMERA  = 1,
    CUMODE_CAMERA = 2,
};

clickable_mode_initial_status  = cursor_mode.CUMODE_CLICKABLE

anim_speed_default_3_pos_thumb	= 24
anim_speed_default_2_pos_thumb	= 15
anim_speed_springloaded_thumb	= 24
anim_speed_multipos_thumb		= 2

direction                      = 1
cyclic_by_default              = false -- to cycle two-way thumblers or not by default
anim_speed_default			   = 16

--VR locals
local vr_side_LEV 	     = {{BOX_SIDE_X_top, BOX_SIDE_X_bottom, BOX_SIDE_Z_top, BOX_SIDE_Z_bottom}}
local vr_side_LEV_TUMB   = {{0},{BOX_SIDE_X_top, BOX_SIDE_X_bottom, BOX_SIDE_Z_top, BOX_SIDE_Z_bottom}}
local vr_side_BTN_LEV    = {{BOX_SIDE_Y_bottom},{BOX_SIDE_X_top, BOX_SIDE_X_bottom, BOX_SIDE_Z_top, BOX_SIDE_Z_bottom}}
local vr_side_CLOCK_LEV  = {{BOX_SIDE_Y_bottom},{BOX_SIDE_Y_top},{BOX_SIDE_X_top, BOX_SIDE_X_bottom, BOX_SIDE_Z_top, BOX_SIDE_Z_bottom}}
local vr_side_LEV_BTN    = {{BOX_SIDE_X_top, BOX_SIDE_X_bottom, BOX_SIDE_Z_top, BOX_SIDE_Z_bottom},{BOX_SIDE_Y_bottom}}
local vr_side_BTN		 = {{BOX_SIDE_Y_bottom}, {BOX_SIDE_Y_bottom}}
local vr_side_TUMB       = {{BOX_SIDE_Z_top},{BOX_SIDE_Z_bottom}}
local vr_side_TUMB_rev   = {{BOX_SIDE_Z_bottom},{BOX_SIDE_Z_top}}
local vr_side_TUMB_COVER = {{BOX_SIDE_Z_bottom},{BOX_SIDE_Y_bottom}}
local vr_side_TUMB_C_rev = {{BOX_SIDE_Y_bottom},{BOX_SIDE_Z_bottom}}

--VR class locals
local MULTY_TUMB  = {class_type.MULTY_TUMB, class_type.MULTY_TUMB}

function default_button(hint_, device_, command_, arg_, arg_val_, arg_lim_, release_message_)
	local arg_val_ = arg_val_ or 1
	local arg_lim_ = arg_lim_ or {0, 1}
	
	local release_message__ = release_message_ or false
	
	return  {	
		class 					= {class_type.BTN, class_type.BTN},
		hint  					= hint_,
		device 					= device_,
		action 					= {command_, command_},
		stop_action 			= {command_, command_},
		arg 					= {arg_, arg_},
		arg_value				= {arg_val_, arg_val_}, 
		arg_lim 				= {arg_lim_, arg_lim_},
		use_release_message 	= {release_message__, release_message__},
		side					= {{BOX_SIDE_Y_bottom}, {BOX_SIDE_Y_bottom}},
		sound		 			= {{SOUND_SW10_OFF, SOUND_SW10_ON}}
	}
end

function default_2_position_tumb(hint_, device_, command_, arg_, arg_val_, arg_lim_, inversed_, animation_speed_)
	local side_	= vr_side_TUMB
	if inversed_ then
		side_	= vr_side_TUMB_rev
	end
	
	local   arg_val_ = arg_val_ or {-direction*1.0, direction*1.0}
	local   arg_lim_ = arg_lim_ or {{0,1}, {0,1}}
	
	local	animation_speed_ 	= animation_speed_ or anim_speed_default_2_pos_thumb
	
	return  {	
		class 					= {class_type.TUMB,class_type.TUMB},
		hint  					= hint_,
		device 					= device_,
		action 					= {command_,command_},
		arg 	  				= {arg_,arg_},
		arg_value 				= arg_val_, 
		arg_lim   				= arg_lim_,
		updatable 				= true, 
		use_OBB 				= true,
		animated				= {true,true},
	    animation_speed			= {animation_speed_,animation_speed_},
		side					= side_,
		sound					= {{SOUND_SW1}}
	}
end

function default_3_position_tumb(hint_, device_, command_, arg_, cycled_, arg_val_, arg_lim_, inversed_, animation_speed_)

	local side_	= vr_side_TUMB
	local val_ 	= 1
	
	if inversed_ then
		side_	= vr_side_TUMB_rev
	end

	local arg_val_ = arg_val_ or {-direction*val_, direction*val_}
	local arg_lim_ = arg_lim_ or {{-1, 1}, {-1, 1}}
	
	local cycled = false
	if cycled_ ~= nil then
		cycled 	 = cycled_ 
	end

	local animation_speed_ = animation_speed_ or anim_speed_default_3_pos_thumb

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
			    animation_speed	= {animation_speed_, animation_speed_},
				side			= side_
			}
end

function multiposition_switch(hint_, device_, command_, arg_, count_,delta_, min_, animation_speed_, attach_left_, attach_right_)
    local min_   = min_ or 0
	local delta_ = delta_ or direction * 0.5
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
				side		= vr_side_LEV_TUMB,
				attach_left	= attach_left_,
				attach_right= attach_right_,
				cycle 		= false
			}
	
	if animation_speed_ ~= nil then
		element.animated        = {true, true}
		element.animation_speed = {animation_speed_, animation_speed_}
	end
	
	return element
end

function animated_guard_switch(hint_, device_, command_, arg_, arg_val_, arg_lim_, inversed_, animation_speed_)
	local arg_val_ 				= arg_val_ or {-direction*0.01, direction*0.01}
	local guard_sw 				= default_2_position_tumb(hint_, device_, command_, arg_, arg_val_, arg_lim_, false, animation_speed_)
	
	local side_	= vr_side_TUMB_COVER
	if inversed_ then
		side_	= vr_side_TUMB_C_rev
	end
	
	guard_sw.sound 				= {{SOUND_SW3_OPEN, SOUND_SW3_CLOSE}}
	guard_sw.side 				= side_
	
	return guard_sw
end

function default_axis(hint_, device_, command_, arg_, arg_value_, gain_, updatable_, relative_, cycled_, attach_left_, attach_right_)
	
	local relative = relative_ or false
	local gain = gain_ or 0.1
	local cycled = cycled_ or false
	local arg_value = arg_value_ or 1
	local updatable = updatable_ or false
	
	return  {	
				class 		= {class_type.LEV},
				hint  		= hint_,
				device 		= device_,
				action 		= {command_},
				arg 	  	= {arg_},
				arg_value 	= {arg_value}, 
				arg_lim   	= {{0,1}},
				updatable 	= {updatable}, 
				use_OBB 	= false, --true,
				gain		= {gain},
				relative    = {relative},  
				cycle		= cycled,
				side		= vr_side_LEV,
				attach_left	= attach_left_ or nil,
				attach_right= attach_right_ or nil,
			}
end


-- Ka-50
elements = {}

--------------------------------------------------------------------------------
-- CPT MECH
elements["GEAR-PTR"]						= default_2_position_tumb(LOCALIZE("Gear lever"), devices.CPT_MECH, device_commands.Button_1, 65, nil, nil, true)
elements["GEAR-PTR"].animated				= {false,false}
elements["GEAR-PTR"].sound					= {{SOUND_SW4_UP, SOUND_SW4_DOWN}}
	
local emergencyGearHint						= LOCALIZE("Main/Common hydraulics for emergency gear")
elements["AVAR-GEAR-PTR"]					= default_2_position_tumb(emergencyGearHint, devices.CPT_MECH, device_commands.Button_4, 66)
elements["AVAR-GEAR-COVER-PTR"]				= animated_guard_switch(emergencyGearHint, devices.CPT_MECH, device_commands.Button_5, 67, nil, nil, true)
	
elements["G--PTR"]							= default_button(LOCALIZE("Accelerometer reset"), devices.ACCELEROMETER, device_commands.Button_1, 572, nil, nil, true)

--------------------------------------------------------------------------------
-- SYSTEM CONTROLLER
elements["CSO-PTR"]							= default_button(LOCALIZE("Master caution push-light"), devices.SYST_CONTROLLER, device_commands.Button_1, 44, 0.2, {0.0, 0.2}, true)
elements["CONTROL-ALARM-PTR"]				= default_button(LOCALIZE("Lamps test"), devices.SYST_CONTROLLER, device_commands.Button_2, 45, nil, nil, true)
elements["MAIN-ROTOR-PTR"]					= default_button(LOCALIZE("Rotor RPM warning push-light"), devices.SYST_CONTROLLER, device_commands.Button_3, 46, 0.2, {0.0, 0.2})
elements["BKO-PTR"]							= default_2_position_tumb(LOCALIZE("MWS operation mode (not functional)"), devices.SYST_CONTROLLER, device_commands.Button_4, 49)

--------------------------------------------------------------------------------
-- Right Side Panel (Правый Боковой Пульт) 
-- ELECTRICS POWER
local DCgroundPowerHint						= LOCALIZE("DC ground power")
elements["ENERG-AER-RIT-PTR"]				= default_2_position_tumb(DCgroundPowerHint, devices.ELEC_INTERFACE, device_commands.Button_1, 262)
elements["ENERG-COVER-AER-RIT-PTR"]			= animated_guard_switch(DCgroundPowerHint, devices.ELEC_INTERFACE, device_commands.Button_2, 263)
	
local battery2_Hint							= LOCALIZE("Battery 2")
elements["ENERG-AKK2-PTR"]					= default_2_position_tumb(battery2_Hint, devices.ELEC_INTERFACE, device_commands.Button_3, 543)
elements["ENERG-COVER-AKK2-PTR"]			= animated_guard_switch(battery2_Hint, devices.ELEC_INTERFACE, device_commands.Button_4, 544)

local battery1_Hint							= LOCALIZE("Battery 1")
elements["ENERG-AKK1-PTR"]					= default_2_position_tumb(battery1_Hint, devices.ELEC_INTERFACE, device_commands.Button_5, 264)
elements["ENERG-COVER-AKK1-PTR"]			= animated_guard_switch(battery1_Hint, devices.ELEC_INTERFACE, device_commands.Button_6, 265)
	
elements["RAMP-POWER-PTR"]					= default_2_position_tumb(LOCALIZE("AC ground power"), devices.ELEC_INTERFACE, device_commands.Button_7, 267)
elements["GEN-LEFT-PTR"]					= default_2_position_tumb(LOCALIZE("AC left generator"), devices.ELEC_INTERFACE, device_commands.Button_8, 268)
elements["GEN-RIGHT-PTR"]					= default_2_position_tumb(LOCALIZE("AC right generator"), devices.ELEC_INTERFACE, device_commands.Button_9, 269)
elements["CONVERTER-PTR"]					= default_3_position_tumb(LOCALIZE("DC/AC inverter"), devices.ELEC_INTERFACE, device_commands.Button_10, 270, false, {-direction*0.1, direction*0.1}, {{0.0, 0.2}, {0.0, 0.2}}, false, anim_speed_multipos_thumb)
	
-- FUEL SYSTEM	
elements["FUEL-PUMP-FRONT-PTR"]				= default_2_position_tumb(LOCALIZE("Forward fuel tank pumps"), devices.FUELSYS_INTERFACE, device_commands.Button_1, 271)
elements["FUEL-PUMP-BACK-PTR"]				= default_2_position_tumb(LOCALIZE("Rear fuel tank pumps"), devices.FUELSYS_INTERFACE, device_commands.Button_2, 272)
elements["FUEL-PUMP-INNER-PTR"]				= default_2_position_tumb(LOCALIZE("Inner external fuel tanks pumps"), devices.FUELSYS_INTERFACE, device_commands.Button_3, 273)
elements["FUEL-PUMP-OUTER-PTR"]				= default_2_position_tumb(LOCALIZE("Outer external fuel tanks pumps"), devices.FUELSYS_INTERFACE, device_commands.Button_4, 274)
elements["FUEL-METER-PTR"]					= default_2_position_tumb(LOCALIZE("Fuelmeter power"), devices.FUELSYS_INTERFACE, device_commands.Button_5, 275)

local leftEngFuelShutoffValve_Hint			= LOCALIZE("Left engine fuel shutoff valve")
elements["PAV-CRANE-ENGINE-LEFT-PTR"]		= default_2_position_tumb(leftEngFuelShutoffValve_Hint, devices.FUELSYS_INTERFACE, device_commands.Button_6, 276)
elements["PAV-CRANE-COVER-ENGINE-LEFT-PTR"]	= animated_guard_switch(leftEngFuelShutoffValve_Hint, devices.FUELSYS_INTERFACE, device_commands.Button_7, 277)

local rightEngFuelShutoffValve_Hint			= LOCALIZE("Right engine fuel shutoff valve")
elements["PAV-CRANE-ENGINE-RIGHT-PTR"]		= default_2_position_tumb(rightEngFuelShutoffValve_Hint, devices.FUELSYS_INTERFACE, device_commands.Button_8, 278)
elements["PAV-CRANE-COVER-ENGINE-RIGHT-PTR"] = animated_guard_switch(rightEngFuelShutoffValve_Hint, devices.FUELSYS_INTERFACE, device_commands.Button_9, 279)

local APU_FuelShutoffValve_Hint				= LOCALIZE("APU fuel shutoff valve")
elements["PAV-CRANE-VSU-PTR"]				= default_2_position_tumb(APU_FuelShutoffValve_Hint, devices.FUELSYS_INTERFACE, device_commands.Button_10, 280)
elements["PAV-CRANE-COVER-VSU-PTR"] 		= animated_guard_switch(APU_FuelShutoffValve_Hint, devices.FUELSYS_INTERFACE, device_commands.Button_11, 281)
	
local fuelCrossfeedValve_Hint				= LOCALIZE("Fuel crossfeed valve")
elements["PAV-CRANE-CYKLIZATION-PTR"]		= default_2_position_tumb(fuelCrossfeedValve_Hint, devices.FUELSYS_INTERFACE, device_commands.Button_12, 282)
elements["PAV-CRANE-COVER-CYKLIZATION-PTR"] = animated_guard_switch(fuelCrossfeedValve_Hint, devices.FUELSYS_INTERFACE, device_commands.Button_13, 283)

elements["CONTROL-OIL-PTR"]					= default_button(LOCALIZE("Fuel quantity indicator self test button"), devices.FUELSYS_INTERFACE, device_commands.Button_14, 616, nil, nil, true)

-- COMMS POWER
elements["COMM-PWR-AVSK-PTR"]				= default_2_position_tumb(LOCALIZE("Intercom"), devices.SPU_9, device_commands.Button_1, 284)
elements["COMM-PWR-UKV-1-PTR"]				= default_2_position_tumb(LOCALIZE("VHF-1 (R828) power switch"), devices.R_828, device_commands.Button_5, 285)
elements["COMM-PWR-UKV-2-PTR"]				= default_2_position_tumb(LOCALIZE("VHF-2 (R-800) power switch"), devices.R_800, device_commands.Button_11, 286)
elements["COMM-PWR-TLK-PTR"]				= default_2_position_tumb(LOCALIZE("Radio equipment datalink TLK power switch"), devices.DATALINK, device_commands.Button_17, 287)
elements["COMM-PWR-UKV-TLK-PTR"]			= default_2_position_tumb(LOCALIZE("Radio equipment datalink UHF TLK power switch"), devices.DATALINK, device_commands.Button_18, 288)
elements["COMM-PWR-SA-TLF-PTR"]				= default_2_position_tumb(LOCALIZE("Radio equipment datalink SA-TLF power switch"), 0, device_commands.Button_7, 289)
	
-- WEAPON SYS	
local weaponCtrlSys_Hint					= LOCALIZE("Weapons сontrol system")
elements["SUO-PTR"]							= default_2_position_tumb(weaponCtrlSys_Hint, devices.WEAP_INTERFACE, device_commands.Button_18, 547)
elements["SUO-COVER-PTR"] 					= animated_guard_switch(weaponCtrlSys_Hint, devices.WEAP_INTERFACE, device_commands.Button_19, 548, nil, nil, true)
	
-- EJECT SYSTEM	
elements["RIGHT-EMERG-SW1-PTR"]				= default_2_position_tumb(LOCALIZE("Ejecting system power 1"), devices.EJECT_SYS_INTERFACE, device_commands.Button_1, 214, nil, nil, true)
elements["RIGHT-EMERG-SW2-PTR"]				= default_2_position_tumb(LOCALIZE("Ejecting system power 2"), devices.EJECT_SYS_INTERFACE, device_commands.Button_2, 215, nil, nil, true)
elements["RIGHT-EMERG-SW3-PTR"]				= default_2_position_tumb(LOCALIZE("Ejecting system power 3"), devices.EJECT_SYS_INTERFACE, device_commands.Button_3, 216, nil, nil, true)

elements["RIGHT-COVER-EMERG-VACATION-PTR"] 	= animated_guard_switch(LOCALIZE("Ejecting system power"), devices.EJECT_SYS_INTERFACE, device_commands.Button_4, 217, {direction*0.01, -direction*0.01})
elements["RIGHT-COVER-EMERG-VACATION-PTR"].sound = {{SOUND_SW6}}

elements["CONTR-SAPROTATE-PTR"]				= multiposition_switch(LOCALIZE("Ejecting system circuit selector"), devices.EJECT_SYS_INTERFACE, device_commands.Button_5, 462, 7, direction * 0.1, 0, anim_speed_multipos_thumb, {90, -45}, {-40, -45})
elements["CONTR-SAPROTATE-PTR"].sound		= {{SOUND_SW2}}
elements["CONTR-SAP-PTR"]					= default_button(LOCALIZE("Ejecting system circuit test"), devices.EJECT_SYS_INTERFACE, device_commands.Button_6, 460, nil, nil, true)
	
-- HYDRAULICS	
local mainHydraulics_Hint					= LOCALIZE("Main hydraulics")
elements["HYDRO-PTR"]						= default_2_position_tumb(mainHydraulics_Hint, devices.HYDRO_SYS_INTERFACE, device_commands.Button_1, 220)
elements["HYDRO-COVER-PTR02"] 				= animated_guard_switch(mainHydraulics_Hint, devices.HYDRO_SYS_INTERFACE, device_commands.Button_2, 221, {direction*0.01, -direction*0.01})
	
-- IFF	
local IFF_power_Hint						= LOCALIZE("IFF power")
elements["SRO-PTR"]							= default_2_position_tumb(IFF_power_Hint, devices.IFF, device_commands.Button_1, 218)
elements["COVER-SRO-PTR"] 					= animated_guard_switch(IFF_power_Hint, devices.IFF, device_commands.Button_2, 219, {direction*0.01, -direction*0.01})

-- ENGINES
local leftEngineEEG_Hint					= LOCALIZE("EEG Left engine Electronic Engine Governor")
elements["ERD-LEFT-PTR"]					= default_2_position_tumb(leftEngineEEG_Hint, devices.ENGINE_INTERFACE, device_commands.Button_1, 290)
elements["ERD-LEFT-COVER-PTR"] 				= animated_guard_switch(leftEngineEEG_Hint, devices.ENGINE_INTERFACE, device_commands.Button_2, 291, {direction*0.01, -direction*0.01})
	
local rightEngineEEG_Hint					= LOCALIZE("EEG Right engine Electronic Engine Governor")
elements["ERD-RIGHT-PTR"]					= default_2_position_tumb(rightEngineEEG_Hint, devices.ENGINE_INTERFACE, device_commands.Button_3, 292)
elements["ERD-RIGHT-COVER-PTR"] 			= animated_guard_switch(rightEngineEEG_Hint, devices.ENGINE_INTERFACE, device_commands.Button_4, 293, {direction*0.01, -direction*0.01})
	
local EEG_gasGenTest_Hint					= LOCALIZE("EEG gas generator test – Operate switch")
elements["PAV-CRANE-VSU-PTR01"]				= default_2_position_tumb(EEG_gasGenTest_Hint, devices.ENGINE_INTERFACE, device_commands.Button_15, 294)
elements["PAV-CRANE-COVER-VSU-PTR01"]		= animated_guard_switch(EEG_gasGenTest_Hint, devices.ENGINE_INTERFACE, device_commands.Button_16, 569)

local EEG_powerTurbTest_Hint				= LOCALIZE("EEG power turbine channel 1 test – Operate – EEG power turbine channel 2 test, three-switch contactor")
elements["PAV-CRANE-VSU-PTR02"]				= default_3_position_tumb(EEG_powerTurbTest_Hint, devices.ENGINE_INTERFACE, device_commands.Button_17, 295, false, {-direction*0.1,direction*0.1}, {{0, 0.2},{0, 0.2}}, false, anim_speed_multipos_thumb)
elements["PAV-CRANE-COVER-VSU-PTR02"]		= animated_guard_switch(EEG_powerTurbTest_Hint, devices.ENGINE_INTERFACE, device_commands.Button_18, 570)
	
elements["RT-12-6-LEFT-PTR"]				= default_button(LOCALIZE("Left EGT control threshold governor button"), devices.ENGINE_INTERFACE, device_commands.Button_19, 457, nil, nil, true)
elements["RT-12-6-RIGHT-PTR"]				= default_button(LOCALIZE("Right EGT control threshold governor button"), devices.ENGINE_INTERFACE, device_commands.Button_20, 458, nil, nil, true)
elements["RT-12-6-IV-PTR"]					= default_button(LOCALIZE("Engines vibrations monitoring system control button"), devices.ENGINE_INTERFACE, device_commands.Button_21, 459, nil, nil, true)
	
-- NAV SYSTEM	
elements["PNK-PTR"]							= default_2_position_tumb(LOCALIZE("Navigation system power"), devices.K041, device_commands.Button_1, 222)
elements["GYRO-MAG-MAN-HEADING-PTR"]		= default_3_position_tumb(LOCALIZE("Gyro/Mag/Manual heading"), devices.NAV_INTERFACE, device_commands.Button_1, 229, false, {direction*0.1,-direction*0.1}, {{0, 0.2},{0, 0.2}}, true, anim_speed_multipos_thumb)
elements["GYRO-MAG-MAN-HEADING-PTR"].action = {device_commands.Button_2, device_commands.Button_1}

--------------------------------------------------------------------------------
-- ABRIS Display (Дисплей АБРИС) 
elements["PTR_BTN-ABRIS-01"]				= default_button(LOCALIZE("ABRIS Pushbutton 1"), devices.ABRIS, device_commands.Button_1, 512)
elements["PTR_BTN-ABRIS-02"]				= default_button(LOCALIZE("ABRIS Pushbutton 2"), devices.ABRIS, device_commands.Button_2, 513)
elements["PTR_BTN-ABRIS-03"]				= default_button(LOCALIZE("ABRIS Pushbutton 3"), devices.ABRIS, device_commands.Button_3, 514)
elements["PTR_BTN-ABRIS-04"]				= default_button(LOCALIZE("ABRIS Pushbutton 4"), devices.ABRIS, device_commands.Button_4, 515)
elements["PTR_BTN-ABRIS-05"]				= default_button(LOCALIZE("ABRIS Pushbutton 5"), devices.ABRIS, device_commands.Button_5, 516)
elements["ABRIS_SHUNT_PTR"]   				= {class = {class_type.LEV, class_type.BTN}, hint = LOCALIZE("ABRIS Cursor сontrol (rot/push)"), device = devices.ABRIS, action = {device_commands.Button_6, device_commands.Button_7}, stop_action = {0, device_commands.Button_7}, is_repeatable = {}, arg = {518,523}, arg_value = {0.04,1}, arg_lim = {{0,1},{0,1}}, relative = {true, false}, gain = {0.25, 0}, side = vr_side_LEV_BTN, attach_right = {80, -70}}
elements["ABRIS_BRIGHTNESS_PTR"]			= default_axis(LOCALIZE("ABRIS Brightness"), devices.ABRIS, device_commands.Button_8, 517, 0.05)
elements["ABRIS-POWER_PTR"]   				= default_2_position_tumb(LOCALIZE("ABRIS Power"), devices.ABRIS, device_commands.Button_9, 130)

--------------------------------------------------------------------------------
-- HUD (ИЛС)
elements["PTR_HUD-BRIGHTNESS"]				= default_axis(LOCALIZE("HUD Brightness"), devices.HUD, device_commands.Button_1, 8, 0.05)
elements["PTR_HUD-TMB-SETKA02"] 			= default_3_position_tumb(LOCALIZE("HUD Modes Reticle/Night/Day"), devices.HUD, device_commands.Button_2, 9, nil, nil, nil, true, 7)
elements["PTR_HUD-TMB-SETKA02"].sound		= {{SOUND_SW2}}
elements["PTR-HUD-TEST"]					= default_button(LOCALIZE("HUD Test"), devices.HUD, device_commands.Button_3, 7, nil, nil, true)
	
elements["PTR_HUD-FILTER"]					= default_3_position_tumb(LOCALIZE("HUD Filter"), devices.HUD, device_commands.Button_4, 510, nil, nil, nil, true)
elements["PTR_HUD-FILTER"].animated			= {false, false} -- The lever is animated internally by HUD
elements["PTR_HUD-FILTER"].sound 			= {{SOUND_SW7_OFF, SOUND_SW7_ON}}

--------------------------------------------------------------------------------
-- PVI NAV Panel (ПВИ - Пульт Ввода и Индикации)
elements["PVI-0-PTR"]						= default_button(LOCALIZE("NAV '0' Btn"), devices.PVI, device_commands.Button_1, 312, 0.2, {0, 0.2})
elements["PVI-1-PTR"]						= default_button(LOCALIZE("NAV '1' Btn"), devices.PVI, device_commands.Button_2, 303, 0.2, {0, 0.2})
elements["PVI-2-PTR"]						= default_button(LOCALIZE("NAV '2' Btn"), devices.PVI, device_commands.Button_3, 304, 0.2, {0, 0.2})
elements["PVI-3-PTR"]						= default_button(LOCALIZE("NAV '3' Btn"), devices.PVI, device_commands.Button_4, 305, 0.2, {0, 0.2})
elements["PVI-4-PTR"]						= default_button(LOCALIZE("NAV '4' Btn"), devices.PVI, device_commands.Button_5, 306, 0.2, {0, 0.2})
elements["PVI-5-PTR"]						= default_button(LOCALIZE("NAV '5' Btn"), devices.PVI, device_commands.Button_6, 307, 0.2, {0, 0.2})
elements["PVI-6-PTR"]						= default_button(LOCALIZE("NAV '6' Btn"), devices.PVI, device_commands.Button_7, 308, 0.2, {0, 0.2})
elements["PVI-7-PTR"]						= default_button(LOCALIZE("NAV '7' Btn"), devices.PVI, device_commands.Button_8, 309, 0.2, {0, 0.2})
elements["PVI-8-PTR"]						= default_button(LOCALIZE("NAV '8' Btn"), devices.PVI, device_commands.Button_9, 310, 0.2, {0, 0.2})
elements["PVI-9-PTR"]						= default_button(LOCALIZE("NAV '9' Btn"), devices.PVI, device_commands.Button_10, 311, 0.2, {0, 0.2})
elements["PVI-PPM-PTR"]						= default_button(LOCALIZE("NAV Waypoints"), devices.PVI, device_commands.Button_11, 315, 0.2, {0, 0.2})
elements["PVI-PZ-PTR"]						= default_button(LOCALIZE("NAV Inflight INU Realignment"), devices.PVI, device_commands.Button_12, 519, 0.2, {0, 0.2})
elements["PVI-OP-PTR"]						= default_button(LOCALIZE("NAV Fixpoints"), devices.PVI, device_commands.Button_13, 316, 0.2, {0, 0.2})
elements["PVI-TB-PTR"]						= default_button(LOCALIZE("NAV Precise INU Alignment"), devices.PVI, device_commands.Button_14, 520, 0.2, {0, 0.2})
elements["PVI-AER-PTR"]						= default_button(LOCALIZE("NAV Airfields"), devices.PVI, device_commands.Button_15, 317, 0.2, {0, 0.2})
elements["PVI-HB-PTR"]						= default_button(LOCALIZE("NAV Normal INU Alignment"), devices.PVI, device_commands.Button_16, 521, 0.2, {0, 0.2})
elements["PVI-OT-PTR"]						= default_button(LOCALIZE("NAV Targets"), devices.PVI, device_commands.Button_17, 318, 0.2, {0, 0.2})
elements["PVI-ENTER-PTR"]					= default_button(LOCALIZE("NAV Enter"), devices.PVI, device_commands.Button_18, 313, 0.2, {0, 0.2})
elements["PVI-CANCEL-PTR"]					= default_button(LOCALIZE("NAV Cancel"), devices.PVI, device_commands.Button_19, 314, 0.2, {0, 0.2})
elements["PVI-KC-PTR"]						= default_button(LOCALIZE("NAV Initial Nav Pos"), devices.PVI, device_commands.Button_20, 522, 0.2, {0, 0.2})
elements["PVI-FILAMBDA-PTR"]				= default_button(LOCALIZE("NAV Self coordinates"), devices.PVI, device_commands.Button_21, 319, 0.2, {0, 0.2})
elements["PVI-FIZ-PTR"]						= default_button(LOCALIZE("NAV Course:Course Deviation/Time/Range to WPT"), devices.PVI, device_commands.Button_22, 320, 0.2, {0, 0.2})
elements["PVI-DU-PTR"]						= default_button(LOCALIZE("NAV Wind Heading/Speed"), devices.PVI, device_commands.Button_23, 321, 0.2, {0, 0.2})
elements["PVI-FII-PTR"]						= default_button(LOCALIZE("NAV True Heading/Time/Range to final WPT"), devices.PVI, device_commands.Button_24, 322, 0.2, {0, 0.2})
elements["PVI-ACDC-PTR"]					= default_button(LOCALIZE("NAV Bearing/Range to target"), devices.PVI, device_commands.Button_25, 323, 0.2, {0, 0.2})
	
elements["PVI-SWITCH-PTR"]					= multiposition_switch(LOCALIZE("NAV Master modes"), devices.PVI, device_commands.Button_26, 324, 7, direction * 0.1, 0, anim_speed_multipos_thumb, {-130, -45}, {100, -45})
elements["PVI-SWITCH-PTR"].action 			= {device_commands.Button_26, device_commands.Button_27}
elements["PVI-SWITCH-PTR"].sound			= {{SOUND_SW2}, {SOUND_SW2}}
	
elements["PVI_I251V_PTR"]					= default_2_position_tumb(LOCALIZE("NAV INU fixtaking method"), devices.PVI, device_commands.Button_28, 325)
elements["PVI_VCU_PTR"]						= default_2_position_tumb(LOCALIZE("NAV Datalink power"), devices.DATALINK, device_commands.Button_16, 326)
elements["PVI-BRIGHTNESS-PTR"]				= default_axis(LOCALIZE("NAV Brightness"), devices.PVI, device_commands.Button_29, 327, 0.001, 0.1, false, false, false, {-130, -45}, {110, -45})

--------------------------------------------------------------------------------
-- UV-26 CMD Control Panel (УВ-26 - Устройство Выброса ЛТЦ)
elements["UV26-BOARD-PTR"]					= default_3_position_tumb(LOCALIZE("CMD Select Left/Both/Right board flares dispensers"), devices.UV_26, device_commands.Button_1, 36, false, {-direction*0.1, direction*0.1}, {{0, 0.2}, {0, 0.2}}, true, 2)
elements["UV26-BOARD-PTR"].action 			= {device_commands.Button_1, device_commands.Button_2}
	
elements["UV26-PROGR-PTR"]					= default_2_position_tumb(LOCALIZE("CMD Amount flares counter/Programming"), devices.UV_26, device_commands.Button_3, 37, {-direction*0.1,direction*0.1}, {{0, 0.1},{0, 0.1}}, true, 2)
elements["UV26-SERIES-PTR"]					= default_button(LOCALIZE("CMD Num of sequences"), devices.UV_26, device_commands.Button_4, 38)
elements["UV26-BURST-PTR"]					= default_button(LOCALIZE("CMD Num in sequence"), devices.UV_26, device_commands.Button_5, 39)
elements["UV26-INTERVAL-PTR"]				= default_button(LOCALIZE("CMD Dispense interval"), devices.UV_26, device_commands.Button_6, 41)
elements["UV26-START-PTR"]					= default_button(LOCALIZE("CMD Start dispense"), devices.UV_26, device_commands.Button_7, 43)
elements["UV26-CANCELPRG-PTR"]				= default_button(LOCALIZE("CMD Reset to default program"), devices.UV_26, device_commands.Button_8, 42)
elements["UV26-STOP-PTR"]					= default_button(LOCALIZE("CMD Stop dispense"), devices.UV_26, device_commands.Button_9, 40)
	
-- UV-26 related (REAR PANEL)	
local CMD_powerHint							= LOCALIZE("CMD Power")
elements["UV26-POWER-PTR"]					= default_2_position_tumb(CMD_powerHint, devices.UV_26, device_commands.Button_10, 496)
elements["UV26-POWER-COVER-PTR"]			= animated_guard_switch(CMD_powerHint, devices.UV_26, device_commands.Button_12, 497)
	
local CMD_BIT_Hint							= LOCALIZE("CMD BIT")
elements["UV26-TEST-PTR"]					= default_2_position_tumb(CMD_BIT_Hint, devices.UV_26, device_commands.Button_11, 498)
elements["UV26-TEST-COVER-PTR"]				= animated_guard_switch(CMD_BIT_Hint, devices.UV_26, device_commands.Button_13, 499)

--------------------------------------------------------------------------------
-- DATALINK
-- Datalink Control Panel
elements["PRC-SEND-PTR"]					= default_button(LOCALIZE("DLNK Send/Memory"), devices.DATALINK, device_commands.Button_1, 159, 0.2, {0, 0.2}, true)
elements["PRC-ESCAPE-PTR"]					= default_button(LOCALIZE("DLNK Ingress to target"), devices.DATALINK, device_commands.Button_2, 150, 0.2, {0, 0.2})
elements["PRC-ERASE-PTR"]					= default_button(LOCALIZE("DLNK Erase"), devices.DATALINK, device_commands.Button_3, 161, 0.2, {0, 0.2}, true)
elements["PRC-CLEAN-PTR"]					= default_button(LOCALIZE("N/A"), devices.DATALINK, device_commands.Button_4, 15, 0.2, {0, 0.2})
elements["PRC-WINGMAN-ALL-PTR"]				= default_button(LOCALIZE("DLNK to ALL"), devices.DATALINK, device_commands.Button_5, 16, 0.2, {0, 0.2})
elements["PRC-WINGMAN-1-PTR"]				= default_button(LOCALIZE("DLNK to Wingman 1"), devices.DATALINK, device_commands.Button_6, 17, 0.2, {0, 0.2})
elements["PRC-WINGMAN-2-PTR"]				= default_button(LOCALIZE("DLNK to Wingman 2"), devices.DATALINK, device_commands.Button_7, 18, 0.2, {0, 0.2})
elements["PRC-WINGMAN-3-PTR"]				= default_button(LOCALIZE("DLNK to Wingman 3"), devices.DATALINK, device_commands.Button_8, 19, 0.2, {0, 0.2})
elements["PRC-WINGMAN-4-PTR"]				= default_button(LOCALIZE("DLNK to Wingman 4"), devices.DATALINK, device_commands.Button_9, 20, 0.2, {0, 0.2})
elements["PRC-TARGET-1-PTR"]				= default_button(LOCALIZE("DLNK Target #1/Vehicle"), devices.DATALINK, device_commands.Button_10, 21, 0.2, {0, 0.2})
elements["PRC-TARGET-2-PTR"]				= default_button(LOCALIZE("DLNK Target #2/SAM"), devices.DATALINK, device_commands.Button_11, 22, 0.2, {0, 0.2})
elements["PRC-TARGET-3-PTR"]				= default_button(LOCALIZE("DLNK Target #3/Other Type"), devices.DATALINK, device_commands.Button_12, 23, 0.2, {0, 0.2})
elements["PRC-TARGET-POINT-PTR"]			= default_button(LOCALIZE("DLNK Ingress point"), devices.DATALINK, device_commands.Button_13, 50, 0.2, {0, 0.2})
	
-- Datalink Mode Controls	
elements["DTLK-SELF-ID-PTR"]				= multiposition_switch(LOCALIZE("Datalink self ID"), devices.DATALINK, device_commands.Button_14, 328, 4, direction*0.1, 0, anim_speed_multipos_thumb, {-130, -45}, {110, -45})
elements["DTLK-SELF-ID-PTR"].sound			= {{SOUND_SW2}}
	
elements["DTLK-MASTER-MODES-PTR"]			= multiposition_switch(LOCALIZE("Datalink Master mode"), devices.DATALINK, device_commands.Button_15, 329, 4, direction*0.1, 0, anim_speed_multipos_thumb, {-130, -45}, {120, -45})
elements["DTLK-MASTER-MODES-PTR"].sound		= {{SOUND_SW2}}

--------------------------------------------------------------------------------
-- PUI-800 Weapons Control Panel (ПУИ-800 Пульт Управления и Индикации)
elements["MASTER-ARM-PTR"]					= default_2_position_tumb(LOCALIZE("Master Arm"), devices.WEAP_INTERFACE, device_commands.Button_1, 387)
elements["PUI800-AVARSTART-PTR"]			= default_button(LOCALIZE("Not implemented"), devices.WEAP_INTERFACE, device_commands.Button_2, 401)
elements["PUI800-AVARCHOP-PTR"]				= default_button(LOCALIZE("External stores jettison"), devices.WEAP_INTERFACE, device_commands.Button_3, 402)
elements["MASTER-EXPLODE-PTR"]				= default_2_position_tumb(LOCALIZE("Jettison arm mode - arm fuse/disarm fuse"), devices.WEAP_INTERFACE, device_commands.Button_22, 396)
elements["PUI800-AUTO-PTR"]					= default_2_position_tumb(LOCALIZE("Manual/Auto weapon system control switch"), devices.WEAP_INTERFACE, device_commands.Button_5, 403)
elements["PUI800-OFBR-PTR"]					= default_2_position_tumb(LOCALIZE("Cannon round selector switch HE/AP"), devices.WEAP_INTERFACE, device_commands.Button_6, 399)
elements["SR-PTR"]							= default_3_position_tumb(LOCALIZE("Weapon mode switch - Burst Length"), devices.WEAP_INTERFACE, device_commands.Button_4, 400, false, {-direction*0.1,direction*0.1}, {{0.0, 0.2}, {0.0, 0.2}}, false, 2)
elements["MT-PTR"]							= default_2_position_tumb(LOCALIZE("Cannon rate of fire setting"), devices.WEAP_INTERFACE, device_commands.Button_20, 398)
	
elements["MASTER-UNLOAD-PTR"]       		= default_button(LOCALIZE("Expedite emergency ATGM launch"), devices.WEAP_INTERFACE, device_commands.Button_21, 397, nil, nil, true)
elements["MASTER-UNLOAD-PTR"].side			= {{BOX_SIDE_Z_bottom}, {BOX_SIDE_Z_bottom}}
elements["MASTER-UNLOAD-PTR"].animated		= {true, true}
elements["MASTER-UNLOAD-PTR"].animation_speed = {anim_speed_default_2_pos_thumb, anim_speed_default_2_pos_thumb}

--------------------------------------------------------------------------------
-- PUR Weapons Aux Panel (ПУР Пульт Управления Режимом)
-- SHKVAL
elements["PUR-BACKGROUND-PTR"]				= default_2_position_tumb(LOCALIZE("IT-23 Black-White indication switch"), devices.SHKVAL, device_commands.Button_1, 404, nil, nil, true)
elements["PUR-LIGHTIT-PTR"]					= default_axis(LOCALIZE("IT-23 display brightness"), devices.SHKVAL, device_commands.Button_2, 406, 0.05)
elements["PUR-CONTRAST-PTR"]				= default_axis(LOCALIZE("IT-23 display contrast"), devices.SHKVAL, device_commands.Button_3, 407, 0.05)
elements["PUR-TR-PTR"]						= default_2_position_tumb(LOCALIZE("N/A"), devices.SHKVAL, device_commands.Button_4, 410)
	
elements["PUR-SF-PTR"]						= multiposition_switch(LOCALIZE("SHKVAL Optics adjustment"), devices.SHKVAL, device_commands.Button_5, 411, 8, direction*0.1, 0, anim_speed_multipos_thumb)
elements["PUR-SF-PTR"].sound				= {{SOUND_SW2}}
	
-- HELMET			
elements["PUR-LIGHTNVU-PTR"]				= default_axis(LOCALIZE("Helmet device brightness"), devices.HELMET, device_commands.Button_1, 405, 0.05)
		
-- WEAPON SYSTEM			
elements["PUR-LIT-PTR"]						= multiposition_switch(LOCALIZE("Laser code selector"), devices.WEAP_INTERFACE, device_commands.Button_7, 408, 3, direction*0.1, 0, anim_speed_multipos_thumb)
elements["PUR-LIT-PTR"].sound				= {{SOUND_SW2}}
	
-- MISC			
elements["PUR-OGR-INF-PTR"]					= default_2_position_tumb(LOCALIZE("HUD/TV declutter switch"), devices.MISC_SYSTEMS_INTERFACE, device_commands.Button_1, 409)
elements["ALTIMETER-BARO-PTR"]				= default_axis(LOCALIZE("Baro pressure QFE knob"), devices.MISC_SYSTEMS_INTERFACE, device_commands.Button_5, 90, 0.001)

--------------------------------------------------------------------------------
-- Auxiliary panel - Preflight Set and Check Panel (ППК - Пульт Подготовки и Контроля)
elements["PPK-BBTZ-PTR"]					= multiposition_switch(LOCALIZE("ATGM Temperature selector"), devices.PPK, device_commands.Button_1, 483, 11, direction * 0.1, 0, anim_speed_multipos_thumb, {90, -45}, {-90, -45})
elements["PPK-BBTZ-PTR"].sound				= {{SOUND_SW2}}
	
elements["PPK-NRAKS-PTR"]					= multiposition_switch(LOCALIZE("Unguided rocket and gun pods ballistics data settings selector"), devices.WEAP_INTERFACE, device_commands.Button_23, 484, 11, direction * 0.1, 0, anim_speed_multipos_thumb, {90, -45}, {-90, -45})
elements["PPK-NRAKS-PTR"].sound				= {{SOUND_SW2}}
	
elements["PPK-RNP-PTR"]						= multiposition_switch(LOCALIZE("Systems BIT selector"), devices.PPK, device_commands.Button_3, 485, 9, direction * 0.1, 0, anim_speed_multipos_thumb, {90, -45}, {-90, -45})
elements["PPK-RNP-PTR"].sound				= {{SOUND_SW2}}
	
elements["KCVM-PTR"]						= default_2_position_tumb(LOCALIZE("Control computers BIT switch"), devices.PPK, device_commands.Button_4, 486)
elements["AKS-PTR"]							= default_button(LOCALIZE("Self test system push-button"), devices.PPK, device_commands.Button_7, 489)
elements["VnK-PTR"]							= default_2_position_tumb(LOCALIZE("Emergency INU alignment switch"), devices.PPK, device_commands.Button_8, 490)
elements["ROPE-PTR"]						= default_2_position_tumb(LOCALIZE("Stabilisation and indication of hanger cable switch"), devices.PPK, device_commands.Button_9, 491)
elements["FKP-PTR"]							= default_2_position_tumb(LOCALIZE("Video Tape Recorder switch"), devices.PPK, device_commands.Button_10, 492)
elements["IKV-PTR"]							= default_2_position_tumb(LOCALIZE("INU Power switch"), devices.C061K, device_commands.Button_1, 487)
elements["HEAT_IKV-PTR"]					= default_2_position_tumb(LOCALIZE("INU Heater switch"), devices.C061K, device_commands.Button_2, 488)
	
local VMG_HydroEkranTstHint					= LOCALIZE("Power plant, hydraulics, EKRAN self-test systems switch")
elements["P-CONTR-VMG-HYDRO-PTR"]			= default_2_position_tumb(VMG_HydroEkranTstHint, devices.CPT_MECH, device_commands.Button_2, 452)
elements["P-CONTR-VMG-HYDRO-COVER-PTR"]		= animated_guard_switch(VMG_HydroEkranTstHint, devices.CPT_MECH, device_commands.Button_3, 453)

--------------------------------------------------------------------------------
-- PPR - Autopilot Control Panel (ППР - Пульт Пилотажных Режимов)
-- AUTOPILOT
elements["PPR-K-PTR01"]						= default_button(LOCALIZE("Autopilot Bank hold"), devices.AUTOPILOT, device_commands.Button_1, 330)
elements["PPR-N-PTR03"]						= default_button(LOCALIZE("Autopilot Heading hold"), devices.AUTOPILOT, device_commands.Button_2, 332)
elements["PPR-T-PTR02"]						= default_button(LOCALIZE("Autopilot Pitch hold"), devices.AUTOPILOT, device_commands.Button_3, 331)
elements["PPR-V-PTR04"]						= default_button(LOCALIZE("Autopilot Altitude hold"), devices.AUTOPILOT, device_commands.Button_4, 333)
elements["PPR-DIRUPR-PTR05"]				= default_button(LOCALIZE("Autopilot Director control"), devices.AUTOPILOT, device_commands.Button_5, 334)
elements["BAR-RV-PTR"]						= default_3_position_tumb(LOCALIZE("Autopilot BARO/RALT altitude hold mode"), devices.AUTOPILOT, device_commands.Button_6, 335, false, {-direction*0.5,direction*0.5}, {{0.0, 1.0},{0.0, 1.0}}, true, 10)
-- NAV SYSTEM	
elements["ZK-LZP-PTR"]						= default_3_position_tumb(LOCALIZE("Autopilot Desired heading - Desired track"), devices.NAV_INTERFACE, device_commands.Button_3, 336, false, {-direction*0.5,direction*0.5}, {{0.0, 1.0},{0.0, 1.0}}, true, 10)

--------------------------------------------------------------------------------
-- CLOCK (часы)
elements["CLOCK-LEFT-LEVER-PTR"] 			= { class = {class_type.BTN, class_type.BTN, class_type.LEV}, hint = LOCALIZE("Mech clock left lever"), device = devices.CLOCK, action = {device_commands.Button_1, device_commands.Button_2, device_commands.Button_3}, stop_action = {device_commands.Button_1, device_commands.Button_2, 0}, is_repeatable = {}, arg = {76, 76, 511}, arg_value = {1.0, -1.0, 0.04}, arg_lim = {{0, 1}, {-1, 0}, {0, 1}}, relative = {false,false,true}, gain = {1.0, 1.0, 0.4}, use_release_message = {true, true, false}, use_OBB = true, side = vr_side_CLOCK_LEV, attach_left = {0, -110} }
elements["CLOCK-LEFT-LEVER-PTR"].sound 		= {{SOUND_SW9_OFF, SOUND_SW9_ON}, {SOUND_SW9_OFF, SOUND_SW9_ON}, {SOUND_SW9_ROTATE_1}}
elements["CLOCK-RIGHT-LEVER-PTR"] 			= { class = {class_type.BTN, class_type.LEV}, hint = LOCALIZE("Mech clock right lever"), device = devices.CLOCK, action = {device_commands.Button_4, device_commands.Button_5}, stop_action = {device_commands.Button_4, 0}, is_repeatable = {}, arg = {77, 525}, arg_value = {1.0, 0.05}, arg_lim = {{0, 1}, {-0.15, 0.15}}--[[, relative = {0, 1}--]], gain = {1.0, 1.2}, use_release_message = {true, false}, use_OBB = true, class_vr = {class_type.BTN_FIX,class_type.LEV}, side = vr_side_BTN_LEV, attach_left = {0, -110}}
elements["CLOCK-RIGHT-LEVER-PTR"].sound 	= {{SOUND_SW9_ON, SOUND_SW9_OFF}, {SOUND_SW9_ROTATE_2}}

--------------------------------------------------------------------------------
-- OVERHEAD PANEL
elements["ANO-PTR"] = {
	class 					= {class_type.TUMB,class_type.BTN},
	hint 					= LOCALIZE("Navigation Lights 10\% / 30\% / 100\% / Off"),
	device 					= devices.NAVLIGHT_SYSTEM, 
	action 					= {device_commands.Button_4,device_commands.Button_5,device_commands.Button_4,device_commands.Button_4},  
	stop_action 			= {0,device_commands.Button_4,0,0},
	arg 					= {146,146,146,146}, 
	arg_value 				= {0.1,0.4,0.2,0.3}, 
	arg_lim 				= {{0, 0.3},{0, 0.4},{0, 0.2},{0, 0.3}}, 
	use_release_message 	= {false,true,false,false}, 
	use_OBB 				= true, 
	updatable 				= true, 
	class_vr 				= {class_type.TUMB_4SIDE,class_type.TUMB_4SIDE,class_type.TUMB_4SIDE,class_type.TUMB_4SIDE},
	side 					= {{BOX_SIDE_X_top}, {BOX_SIDE_Z_bottom}, {BOX_SIDE_X_bottom}, {BOX_SIDE_Z_top} },
}

elements["WINDSCREEN-WIPER-PTR"] = {
	class 					= {class_type.TUMB,class_type.BTN}, 
	hint 					= LOCALIZE("Windshield wiper switch"), 
	device 					= devices.CPT_MECH, 
	action 					= {device_commands.Button_6, device_commands.Button_7,device_commands.Button_6,device_commands.Button_6}, 
	stop_action 			= {0, device_commands.Button_7,0,0}, 
	arg 					= {147,147,147,147}, 
	arg_value 				= {0.1,0.4,0.2,0.3}, 
	arg_lim 				= {{0.0, 0.3}, {0.0, 0.4},{0.0, 0.2},{0.0, 0.3}}, 
	use_release_message 	= {false,true,false,false}, 
	use_OBB 				= true, 
	updatable 				= true,
	class_vr 				= {class_type.TUMB_4SIDE,class_type.TUMB_4SIDE,class_type.TUMB_4SIDE,class_type.TUMB_4SIDE},
	side 					= {{BOX_SIDE_Z_top}, {BOX_SIDE_Z_bottom}, {BOX_SIDE_X_top}, {BOX_SIDE_X_bottom} },
}
	
elements["FEEDING-OZH-PTR"]					= default_2_position_tumb(LOCALIZE("Windshield washer fluid switch"), 0, device_commands.Button_8, 148)
elements["BRIGHTNESS-PTR"]					= default_axis(LOCALIZE("Warning Lights Brightness"), devices.SYST_CONTROLLER, device_commands.Button_5, 149, 0.001, 0.1)
elements["PPD-DUAS-PTR"]					= default_2_position_tumb(LOCALIZE("Pitot static port and AoA sensors heat switch"), devices.CPT_MECH, device_commands.Button_8, 539)
elements["PVD-CLOCK-PTR"]					= default_2_position_tumb(LOCALIZE("Pitot ram air and clock heat switch"), devices.CPT_MECH, device_commands.Button_9, 151)
elements["POS-ROTORS-PTR"]      			= default_2_position_tumb(LOCALIZE("Rotor de-icing system switch"), devices.ENGINE_INTERFACE, device_commands.Button_13, 153)
elements["POS-ENGINE-PZU-PTR"]  			= default_3_position_tumb(LOCALIZE("Engines de-icing / dust-protection systems switch"), devices.ENGINE_INTERFACE, device_commands.Button_14, 154, false, {-direction*0.5,direction*0.5}, {{0.0, 1.0},{0.0, 1.0}}, false, 10)
elements["KONTR-PVD-PTR"]					= default_button(LOCALIZE("Pitot heat system test"), devices.CPT_MECH, device_commands.Button_10, 156, nil, nil, true)

--------------------------------------------------------------------------------
-- HSI (ПНП)
elements["ROTARY-ZPU-PTR"]					= default_axis(LOCALIZE("HSI Commanded course rotary"), devices.HSI, device_commands.Button_1, 126, 0.001, 0.1, false, true)
elements["ROTARY-ZK-PTR"]					= default_axis(LOCALIZE("HSI Commanded heading rotary"), devices.HSI, device_commands.Button_2, 129, 0.001, 0.1, false, true)
elements["TEST-PNP-PTR03"]					= default_button(LOCALIZE("HSI test"), devices.HSI, device_commands.Button_3, 113, nil, nil, true)
-- HSI related			
elements["ZPU-ZK-PTR"]						= default_2_position_tumb(LOCALIZE("HSI Desired track angle - Desired heading, Auto - Manual"), devices.HSI, device_commands.Button_4, 54)

--------------------------------------------------------------------------------
-- ADI (ИКП)
elements["IKP-TANGAGE-PTR"]					= default_axis(LOCALIZE("ADI Zero pitch trim"), devices.ADI, device_commands.Button_1, 105, 0.002, 0.2, false, false, false, nil, {80, -45})
elements["IKP-TANGAGE-PTR"].arg_lim 		= {{-1, 1}}
	
elements["TEST-COVER-IKP-PTR"]				= default_2_position_tumb(LOCALIZE("ADI Test"), devices.ADI, device_commands.Button_2, 550)
elements["TEST-COVER-IKP-PTR"].side 		= {{BOX_SIDE_Y_bottom}, {BOX_SIDE_Z_top}}
		
elements["TEST-IKP-PTR"]					= default_button(LOCALIZE("ADI Test"), devices.ADI, device_commands.Button_3, 110, nil, nil, true)

--------------------------------------------------------------------------------
-- STANDBY ADI (AGR-81)
elements["RES-AGD-PTR"] 					= {class = {class_type.BTN, class_type.BTN, class_type.LEV}, hint = LOCALIZE("Standby Attitude Indicator Cage/control test handle"), device = devices.STBY_ADI, action = {device_commands.Button_1, device_commands.Button_2, device_commands.Button_3}, stop_action = {device_commands.Button_1, device_commands.Button_2, 0}, is_repeatable = {}, arg = {141, 141, 597}, arg_value = {1.0, -1.0, 1.0}, arg_lim = {{0, 1}, {-1, 0}, {0, 1}}, relative = {false,false,true}, gain = {1.0, 1.0, 0.2}, use_release_message = {true, true, false}, use_OBB = true , side = vr_side_CLOCK_LEV, attach_right = {80, -45}}
elements["RES-AG-PTR"]						= default_2_position_tumb(LOCALIZE("Standby Attitude Indicator power switch"), devices.STBY_ADI, device_commands.Button_4, 230)

--------------------------------------------------------------------------------
-- RADIOALTIMETER
elements["ROTARY-DANGEROUS-HIGHT-PTR"] 		= default_axis(LOCALIZE("Dangerous RALT set rotary"), devices.RADAR_ALTIMETER, device_commands.Button_1, 91, 0.1, 0.1, false, true)
elements["TEST-RADIO-HIGHT-PTR"]	   		= default_button(LOCALIZE("Radar altimeter test"), devices.RADAR_ALTIMETER, device_commands.Button_2, 96, nil, nil, true)

--------------------------------------------------------------------------------
-- PVR (ПВР - Пульт Выбора Режимов К-041)
-- WEAPONS
elements["PVR-DRILL-PTR"]					= default_2_position_tumb(LOCALIZE("Training mode"), devices.WEAP_INTERFACE, device_commands.Button_9, 432)
elements["PVR-ADV-PTR"]						= default_button(LOCALIZE("Automatic turn on target mode"), devices.WEAP_INTERFACE, device_commands.Button_10, 437)
elements["PVR-VC-PTR"]						= default_button(LOCALIZE("Airborne Target"), devices.WEAP_INTERFACE, device_commands.Button_11, 438)
elements["PVR-PPS-PTR"]						= default_button(LOCALIZE("Forward hemisphere (head-on) air target aspect"), devices.WEAP_INTERFACE, device_commands.Button_12, 439)
elements["PVR-NPC-PTR"]						= default_button(LOCALIZE("Ground moving target"), devices.WEAP_INTERFACE, device_commands.Button_13, 440)
	
elements["PVR-MODE-PTR"]					= multiposition_switch(LOCALIZE("Weapon system mode selector"), devices.WEAP_INTERFACE, device_commands.Button_14, 431, 5, direction * 0.1, 0, anim_speed_multipos_thumb, {0, -110})
elements["PVR-MODE-PTR"].action 			= {device_commands.Button_14, device_commands.Button_15}
elements["PVR-MODE-PTR"].sound				= {{SOUND_SW2}, {SOUND_SW2}}
	
elements["PVR-RESET-PTR"]					= default_button(LOCALIZE("Targeting mode reset"), devices.WEAP_INTERFACE, device_commands.Button_16, 441, nil, nil, true)
elements["PVR-AS-PM-PTR"]					= default_2_position_tumb(LOCALIZE("Automatic Tracking / gun sight"), devices.WEAP_INTERFACE, device_commands.Button_17, 436)
-- K041			
elements["K-041-PTR"]						= default_2_position_tumb(LOCALIZE("K-041 Targeting-navigation system power switch"), devices.K041, device_commands.Button_2, 433)
-- LASERRANGER			
elements["PVR-IZL-PTR"]						= default_2_position_tumb(LOCALIZE("Laser standby ON/OFF switch"), devices.LASERRANGER, device_commands.Button_1, 435)
-- HELMET			
elements["PVR-OBZ-PTR"]						= default_2_position_tumb(LOCALIZE("Helmet-mounted sight system power switch"), devices.HELMET, device_commands.Button_2, 434)
elements["PVR-OBZ-PTR"].sound				= {{SOUND_SW1}}
	
-- SHKVAL			
elements["V-SCAN-PTR"]						= multiposition_switch(LOCALIZE("Shkval scan rate"), devices.SHKVAL, device_commands.Button_6, 301, 8, direction * 0.1, 0, anim_speed_multipos_thumb, {-130, -45}, {110, -45})
elements["V-SCAN-PTR"].sound				= {{SOUND_SW2}}

--------------------------------------------------------------------------------

-- Laser ranger (front panel)
local laserModeSwitchHint					= LOCALIZE("Laser rangefinder / designator - mode switch")
elements["LDP-LD-PTR"]						= default_2_position_tumb(laserModeSwitchHint, devices.LASERRANGER, device_commands.Button_3, 56, nil, nil, true)
elements["LD-LDP-COVER-PTR"]				= animated_guard_switch(laserModeSwitchHint, devices.LASERRANGER, device_commands.Button_2, 57)
elements["CHOP-LDP-PTR"]					= default_button(LOCALIZE("Laser designator reset"), devices.LASERRANGER, device_commands.Button_4, 55)
	
-- Laser Warning System (Л-140)	
elements["L-140-RESET-PTR"]					= default_button(LOCALIZE("LWS Reset button"), devices.LASER_WARNING_SYSTEM, device_commands.Button_1, 35)
elements["L140-SWITCH"]						= default_2_position_tumb(LOCALIZE("LWS Power switch"), devices.LASER_WARNING_SYSTEM, device_commands.Button_2, 583)
	
elements["L140-CNOB"]						= default_button(LOCALIZE("LWS self-test button"), devices.LASER_WARNING_SYSTEM, device_commands.Button_3, 584)
elements["L140-CNOB"].stop_action 			= {device_commands.Button_4, device_commands.Button_4}

-----------------------------------------------------------------------------------
-- Engines Start-Up Control Panel
elements["START-PANEL-START-PTR"]			= default_button(LOCALIZE("Start-up selected engine button"), devices.ENGINE_INTERFACE, device_commands.Button_5, 412, nil, nil, true)
elements["START-PANEL-STOP-START-PTR"] 		= default_button(LOCALIZE("Interrupt start-up button"), devices.ENGINE_INTERFACE, device_commands.Button_6, 413, nil, nil, true)
elements["START-PANEL-STOP-START-PTR01"] 	= default_button(LOCALIZE("Stop APU button"), devices.ENGINE_INTERFACE, device_commands.Button_7, 414, nil, nil, true)

elements["START-PANEL-ROLLING-PTR"]  		= default_3_position_tumb(LOCALIZE("Engine Startup/Crank/False Start selector"), devices.ENGINE_INTERFACE, device_commands.Button_12, 415, false, {direction*0.1,-direction*0.1}, {{0.0, 0.2},{0.0, 0.2}}, true, 2)
elements["START-PANEL-ROLLING-PTR"].sound 	= {{SOUND_SW1}}

elements["START-ENGINE-SELECTOR-PTR"] = {
	class 					= {class_type.TUMB, class_type.TUMB},
	hint 					= LOCALIZE("Engine selector"), 
	device 					= devices.ENGINE_INTERFACE, 
	action 					= {device_commands.Button_8,  device_commands.Button_8, device_commands.Button_8, device_commands.Button_8}, 
	arg 					= {416, 416, 416, 416}, 
	arg_value 				= {0.1, -0.1, 0.2, 0.3},
	arg_lim 				= {{0.0, 0.3}, {0.0, 0.3}, {0.0, 0.2}, {0.0, 0.3}}, 
	use_OBB 				= true, 
	updatable 				= true, 
	class_vr 				= {class_type.TUMB_4SIDE, class_type.TUMB_4SIDE, class_type.TUMB_4SIDE, class_type.TUMB_4SIDE},
	side 					= {{BOX_SIDE_X_top}, {BOX_SIDE_Z_top}, {BOX_SIDE_X_bottom}, {BOX_SIDE_Z_bottom}},
}

elements["EMERGENCY-BRAKE ENGINE-LEFT-PTR"] = default_2_position_tumb(LOCALIZE("Left engine cut-off valve"), devices.ENGINE_INTERFACE, device_commands.Button_9, 554, nil, nil, true)
elements["EMERGENCY-BRAKE ENGINE-LEFT-PTR"].animated = {false, false}
elements["EMERGENCY-BRAKE ENGINE-LEFT-PTR"].sound = {{SOUND_SW4_DOWN, SOUND_SW4_UP}}

elements["EMERGENCY-BRAKE ENGINE-RIGHT-PTR"] = default_2_position_tumb(LOCALIZE("Right engine cut-off valve"), devices.ENGINE_INTERFACE, device_commands.Button_10, 555, nil, nil, true)
elements["EMERGENCY-BRAKE ENGINE-RIGHT-PTR"].animated = {false, false}
elements["EMERGENCY-BRAKE ENGINE-RIGHT-PTR"].sound = {{SOUND_SW4_DOWN, SOUND_SW4_UP}}

elements["BRAKE-ROTOR-LOW-PTR01"]			= default_2_position_tumb(LOCALIZE("Rotor brake"), devices.ENGINE_INTERFACE, device_commands.Button_11, 556, nil, nil, true, 7)
elements["BRAKE-ROTOR-LOW-PTR01"].sound 	= {{SOUND_SW4_UP, SOUND_SW4_DOWN}}
	
elements["CONTROL-TEMP-WORK-PTR"]	 		= default_button(LOCALIZE("Running engines exhaust gas temperature indicator test button"), devices.ENGINE_INTERFACE, device_commands.Button_22, 131, nil, nil, true)
elements["CONTROL-TEMP-NOTWORK-PTR"] 		= default_button(LOCALIZE("Stopped engines exhaust gas temperature indicator test button"), devices.ENGINE_INTERFACE, device_commands.Button_23, 132, nil, nil, true)

-----------------------------------------------------------------------------------
--Radio switcher
elements["RADIO-RATE-PTR"]  				= multiposition_switch(LOCALIZE("SPU-9 Radio communicator selector"), devices.SPU_9, device_commands.Button_2, 428, 4, direction * 0.11, 0, anim_speed_multipos_thumb, {0, -110})
elements["RADIO-RATE-PTR"].sound			= {{SOUND_SW2}}
--elements["RADIO-RESET-PTR"]  = {class = {class_type.BTN}, hint = LOCALIZE("Radio Communicator Reset", device = devices.SPU_9, action = {device_commands.Button_3}, stop_action = {device_commands.Button_3}, arg = {429}, arg_value = {1.0}, arg_lim = {{0.0, 1.0}}}
--elements["RADIO-COVER-RESET-PTR"]  = {class = {class_type.TUMB}, hint = LOCALIZE("Radio Communicator Reset Cover", device = devices.SPU_9, action = {device_commands.Button_4}, arg = {430}, arg_value = {1.0}, arg_lim = {{0.0, 1.0}}, updatable = true, use_OBB = true}

------------------------------------------------------------------------------------
-- Fire Extinguishers Control Panel
elements["PUI800-AVARCHOP-PTR01"]			= default_button(LOCALIZE("Left engine extinguisher"), devices.FIRE_EXTING_INTERFACE, device_commands.Button_1, 236, nil, nil, true)
elements["PUI800-AVARCHOP-PTR02"]			= default_button(LOCALIZE("APU extinguisher"), devices.FIRE_EXTING_INTERFACE, device_commands.Button_2, 238, nil, nil, true)
elements["PUI800-AVARCHOP-PTR03"]			= default_button(LOCALIZE("Right engine extinguisher"), devices.FIRE_EXTING_INTERFACE, device_commands.Button_3, 240, nil, nil, true)
elements["PUI800-AVARCHOP-PTR04"]			= default_button(LOCALIZE("Ventilator extinguisher"), devices.FIRE_EXTING_INTERFACE, device_commands.Button_4, 242, nil, nil, true)
	
local fireExtingSwHint						= LOCALIZE("Fire extinguisher Work – Off – Test switch")
elements["FIREEXT-PTR"]						= default_3_position_tumb(fireExtingSwHint, devices.FIRE_EXTING_INTERFACE, device_commands.Button_5, 248, false, {-direction*0.1, direction*0.1}, {{0.0, 0.2}, {0, 0.2}}, false, anim_speed_multipos_thumb)
elements["FIREEXT-PTR"].action 				= {device_commands.Button_5, device_commands.Button_6}
elements["FIREEXT-COVER-PTR"]				= animated_guard_switch(fireExtingSwHint, devices.FIRE_EXTING_INTERFACE, device_commands.Button_7, 249)
	
elements["FIREEXT-INDICATION-PTR"]			= default_2_position_tumb(LOCALIZE("Fire signaling"), devices.FIRE_EXTING_INTERFACE, device_commands.Button_8, 250)
	
local fireExtingSelHint						= LOCALIZE("Fire extinguisher First (Auto) / Second (Manual) selector")
elements["BALOONS-PTR"]						= default_2_position_tumb(fireExtingSelHint, devices.FIRE_EXTING_INTERFACE, device_commands.Button_9, 246)
elements["BALOONS-COVER-PTR"]				= animated_guard_switch(fireExtingSelHint, devices.FIRE_EXTING_INTERFACE, device_commands.Button_10, 247)
	
--elements["EXTING-GROUPS-CTRL"]			= {class = {class_type.TUMB, class_type.TUMB}, hint = LOCALIZE("1st/2nd/3rd fire warning sensors groups BIT selector"), device = devices.FIRE_EXTING_INTERFACE, action = {device_commands.Button_11, device_commands.Button_12}, arg = {251, 251}, arg_value = {-direction*0.1, direction*0.1}, arg_lim = {{0.0, 0.3}, {0, 0.3}}, use_OBB = true, updatable = true}
elements["EXTING-GROUPS-CTRL-01"]			= default_button(LOCALIZE("1st fire warning sensors group BIT"), devices.FIRE_EXTING_INTERFACE, device_commands.Button_11, 251, 0.1, {0, 0.1}, true)
elements["EXTING-GROUPS-CTRL-02"]			= default_button(LOCALIZE("2nd fire warning sensors group BIT"), devices.FIRE_EXTING_INTERFACE, device_commands.Button_12, 251, 0.2, {0, 0.2}, true)
elements["EXTING-GROUPS-CTRL-03"]			= default_button(LOCALIZE("3rd fire warning sensors group BIT"), devices.FIRE_EXTING_INTERFACE, device_commands.Button_13, 251, 0.3, {0, 0.3}, true)

------------------------------------------------------------------------------------
-- Misc. systems
elements["REDUCTOR-PTR"] = 
	{class = {class_type.BTN, class_type.BTN}, hint = LOCALIZE("Reducing gear box oil pressure indication selector"), device = devices.ENGINE_INTERFACE,
	action = {device_commands.Button_24, device_commands.Button_25}, stop_action = {device_commands.Button_24, device_commands.Button_25},
	arg = {258, 258}, arg_value = {-direction*1, direction*1}, arg_lim = {{-1, 0}, {0, 1}}, use_OBB = true, updatable = true, use_release_message = {true, true},
	animated = {true, true}, animation_speed = {anim_speed_default_3_pos_thumb, anim_speed_default_3_pos_thumb}, side = vr_side_TUMB_rev}
				
elements["HANGER-PTR"]						= default_2_position_tumb(LOCALIZE("Sling load Auto/Manual"), devices.MISC_SYSTEMS_INTERFACE, device_commands.Button_4, 259)

------------------------------------------------------------------------------------
-- ALMAZ system
elements["SPEECH-INFO-OFF-PTR01"]			= default_button(LOCALIZE("Voice message system messages off"), devices.VMS, device_commands.Button_1, 384)
elements["SPEECH-INFO-AVAR-PTR"]			= default_2_position_tumb(LOCALIZE("Voice message system emergency on"), devices.VMS, device_commands.Button_2, 386)
elements["SPEECH-INFO-RETRY-PTR"]			= default_button(LOCALIZE("Voice message system messages repeat"), devices.VMS, device_commands.Button_3, 385)
elements["SPEECH-BIT-PTR"]					= default_button(LOCALIZE("Voice message system check"), devices.VMS, device_commands.Button_4, 442)
	
-- Lighting	
elements["DESK-PTR"]						= default_2_position_tumb(LOCALIZE("Lighting cockpit panel switch"), devices.ILLUMINATION_INTERFACE, device_commands.Button_1, 300)
elements["DEVICES-PTR"]						= default_2_position_tumb(LOCALIZE("Lighting night vision cockpit switch"), devices.ILLUMINATION_INTERFACE, device_commands.Button_7, 299)
elements["AGR-PKP-PTR"]						= default_2_position_tumb(LOCALIZE("Lighting ADI and SAI switch"), devices.ILLUMINATION_INTERFACE, device_commands.Button_3, 298)
elements["P-CONTR-ILLUM-PTR"]				= default_2_position_tumb(LOCALIZE("Lighting auxiliary panel switch"), devices.ILLUMINATION_INTERFACE, device_commands.Button_5, 450)
elements["LAMP-PTR"]						= default_2_position_tumb(LOCALIZE("Lighting cockpit interior lamp switch"), devices.ILLUMINATION_INTERFACE, device_commands.Button_9, 1001)
elements["P-CONTR-BRIGHT-PTR"]				= default_axis(LOCALIZE("Lighting auxiliary panel brightness knob"), devices.ILLUMINATION_INTERFACE, device_commands.Button_6, 451, 0.1, 0.1, false, false, false, {110, -45}, {-90, -45})
elements["BRIGHT-DEV-PTR"]					= default_axis(LOCALIZE("Lighting night vision cockpit brightness knob"), devices.ILLUMINATION_INTERFACE, device_commands.Button_8, 507, 0.1, 0.1, false, false, false, {90, -50}, {-90, -55})
elements["BRIGHT-LEFT-RIGHT-PTR"]			= default_axis(LOCALIZE("Lighting cockpit panel brightness knob"), devices.ILLUMINATION_INTERFACE, device_commands.Button_2, 593, 0.1, 0.1, false, false, false, {90, -50}, {-90, -55})
elements["BRIGHT-AGR-PKP-PTR"]				= default_axis(LOCALIZE("Lighting HSI and ADI brightness knob"), devices.ILLUMINATION_INTERFACE, device_commands.Button_4, 508, 0.1, 0.1, false, false, false, {90, -50}, {-90, -55})

-- Outside illumination
elements["LANDING LIGHTS-DIR-LIGHT-PTR"] 	= default_3_position_tumb(LOCALIZE("Light landing-search. On/Retraction/Off"), devices.SPOTLIGHT_SYSTEM, device_commands.Button_1, 382, false, {-direction*0.5, direction*0.5}, {{0.0, 1.0}, {0.0, 1.0}}, false, 12)
elements["LANDING LIGHTS-DIR-LIGHT-PTR"].sound = {{SOUND_SW1}}

elements["LANDING LIGHTS-BASE-RESERV-PTR"] 	= default_2_position_tumb(LOCALIZE("Lights landing-search change. Main/Reserved"), devices.SPOTLIGHT_SYSTEM, device_commands.Button_2, 383, nil, nil, true)
	
elements["CONTUR-LIGHT-PTR"]  				= default_2_position_tumb(LOCALIZE("Tip Lights"), devices.NAVLIGHT_SYSTEM, device_commands.Button_1, 296)
elements["FLASHER-PTR"]  			    	= default_2_position_tumb(LOCALIZE("Anticollision Light"), devices.NAVLIGHT_SYSTEM, device_commands.Button_3, 228)
	
elements["FORMATION-PTR"] = {
	class 					= {class_type.TUMB,class_type.TUMB}, 
	hint 					= LOCALIZE("Formation Lights"), 
	device 					= devices.NAVLIGHT_SYSTEM, 
	action 					= {device_commands.Button_2,device_commands.Button_2,device_commands.Button_2,device_commands.Button_2}, 
	arg 					= {297,297,297,297}, 
	arg_value 				= {-0.1,0.1,0.2,0.3}, 
	arg_lim 				= {{0, 0.3},{0, 0.3},{0, 0.2},{0, 0.3}}, 
	use_OBB 				= true, 
	updatable 				= true, 
	class_vr 				= {class_type.TUMB_4SIDE,class_type.TUMB_4SIDE,class_type.TUMB_4SIDE,class_type.TUMB_4SIDE},
	side 					= {{BOX_SIDE_Z_bottom}, {BOX_SIDE_X_top}, {BOX_SIDE_X_bottom}, {BOX_SIDE_Z_top} }
}
	
-- SHKVAL windscreen wiper
elements["WIPER-PTR"]	                    = default_button(LOCALIZE("SHKVAL windscreen wiper"), devices.SHKVAL, device_commands.Button_7, 224, nil, nil, true)

-------------------------------------------------------------------------------------
--ARK-22
elements["IANDING LIGHTS-DIR-LIGHT-PTR01"]  = default_3_position_tumb(LOCALIZE("ADF Inner-Auto-Outer NDB switch"), devices.ARK_22, device_commands.Button_3, 381, false, {-direction*0.5, direction*0.5}, {{0.0, 1.0}, {0.0, 1.0}}, false, 12)
elements["IANDING LIGHTS-DIR-LIGHT-PTR01"].sound = {{SOUND_SW1}}

elements["VARK-VOLUME-PTR01"]		        = multiposition_switch(LOCALIZE("ADF channel switch"), devices.ARK_22, device_commands.Button_1, 357, 10, direction * 0.1, 0, nil, {-130, -45}, {130, -45})
elements["VARK-VOLUME-PTR01"].action 		= {device_commands.Button_1, device_commands.Button_2}
elements["VARK-VOLUME-PTR01"].cycle 		= true

elements["TLF-TLG-PTR01"]				    = default_2_position_tumb(LOCALIZE("COMPASS-ANTENNA modes"), devices.ARK_22, device_commands.Button_4, 356, nil, nil, true)
elements["TLF-TLG-PTR01"].sound = {{SOUND_SW1}}

elements["TLF-TLG-PTR"]			     	    = default_2_position_tumb(LOCALIZE("TLF-TLG modes"), devices.ARK_22, device_commands.Button_5, 354, nil, nil, true)
elements["TLF-TLG-PTR"].sound = {{SOUND_SW1}}

elements["VARK-VOLUME-PTR"]				    = default_axis(LOCALIZE("ADF Volume"), devices.ARK_22, device_commands.Button_6, 353, 0.05, 0.1, false, false, false, {-110, -45}, {100, -45})
elements["ARK-CONTROL-PTR"]					= default_button(LOCALIZE("ADF Test"), devices.ARK_22, device_commands.Button_7, 355, nil, nil, true)

-----------------------------------------------------------------------------------------
--R-800
elements["START-PANEL-CONTROL-PTR"]			= default_button(LOCALIZE("R-800 (VHF-2) BIT button"), devices.R_800, device_commands.Button_1, 418, nil, nil, true)
	
elements["CONTR-RADIO-CHM-AM-PTR"]		    = default_2_position_tumb(LOCALIZE("R-800 (VHF-2) AM-FM toggle switch"), devices.R_800, device_commands.Button_2, 417)
elements["CONTR-RADIO-CHM-AM-PTR"].sound	= {{SOUND_SW1}}

elements["CONTR-RADIO-AP-PTR"]				= default_2_position_tumb(LOCALIZE("R-800 (VHF-2) Emergency receiver"), devices.R_800, device_commands.Button_3, 421)
elements["CONTR-RADIO-AP-PTR"].sound		= {{SOUND_SW1}}

elements["CONTR-RADIO-ARK-PTR"]				= default_2_position_tumb(LOCALIZE("R-800 (VHF-2) ADF switch"), devices.R_800, device_commands.Button_4, 422)
elements["CONTR-RADIO-ARK-PTR"].sound		= {{SOUND_SW1}}

elements["CONTR-RADIO-50-100-PTR01"]		= default_2_position_tumb(LOCALIZE("R-800 (VHF-2) Data transfer rate switch"), devices.R_800, device_commands.Button_5, 420)
elements["CONTR-RADIO-50-100-PTR01"].sound	= {{SOUND_SW1}}

elements["CONTR-RADIO-PSH-PTR"]				= default_2_position_tumb(LOCALIZE("R-800 (VHF-2) Squelch"), devices.R_800, device_commands.Button_6, 423)
elements["CONTR-RADIO-PSH-PTR"].sound		= {{SOUND_SW1}}

-- Frequency rotaries
elements["CONTROLLER-FREQ-1-PTR"]   		= {class = {class_type.BTN, class_type.BTN}, hint = LOCALIZE("R-800 (VHF-2) 1st rotary"), device = devices.R_800, action = {device_commands.Button_7, device_commands.Button_7}, arg = {-1, -1}, arg_value = {-1.0, 1.0}, arg_lim = {{-1.0, 1.0}, {-1.0, 1.0}}, side = {{BOX_SIDE_Z_top},{BOX_SIDE_X_top}}}
elements["CONTROLLER-FREQ-1-PTR"].sound		= {{SOUND_SW5}}
elements["CONTROLLER-FREQ-2-PTR"]   		= {class = {class_type.BTN, class_type.BTN}, hint = LOCALIZE("R-800 (VHF-2) 2nd rotary"), device = devices.R_800, action = {device_commands.Button_8, device_commands.Button_8}, arg = {-1, -1}, arg_value = {-1.0, 1.0}, arg_lim = {{-1.0, 1.0}, {-1.0, 1.0}}, side = {{BOX_SIDE_Z_top},{BOX_SIDE_X_top}}}
elements["CONTROLLER-FREQ-2-PTR"].sound		= {{SOUND_SW5}}
elements["CONTROLLER-FREQ-3-PTR"]   		= {class = {class_type.BTN, class_type.BTN}, hint = LOCALIZE("R-800 (VHF-2) 3rd rotary"), device = devices.R_800, action = {device_commands.Button_9, device_commands.Button_9}, arg = {-1, -1}, arg_value = {-1.0, 1.0}, arg_lim = {{-1.0, 1.0}, {-1.0, 1.0}}, side = {{BOX_SIDE_Z_top},{BOX_SIDE_X_top}}}
elements["CONTROLLER-FREQ-3-PTR"].sound		= {{SOUND_SW5}}
elements["CONTROLLER-FREQ-4-PTR"]			= {class = {class_type.BTN, class_type.BTN}, hint = LOCALIZE("R-800 (VHF-2) 4th rotary"), device = devices.R_800, action = {device_commands.Button_10, device_commands.Button_10}, arg = {-1, -1}, arg_value = {-1.0, 1.0},  arg_lim = {{-1.0, 1.0}, {-1.0, 1.0}}, side = {{BOX_SIDE_Z_top},{BOX_SIDE_X_top}}}
elements["CONTROLLER-FREQ-4-PTR"].sound		= {{SOUND_SW5}}

-------------------------------------------------------------------------------------------
--R-828
elements["CHANNEL-PTR"]  					= multiposition_switch(LOCALIZE("R-828 (VHF-1) Radio channel selector"), devices.R_828, device_commands.Button_1, 371, 10, direction * 0.1, 0, nil, {-110, -45}, {110, -60})
elements["CHANNEL-PTR"].sound				= {{SOUND_SW2}}
elements["CHANNEL-PTR"].cycle 				= true

elements["RADIO-VOLUME-PTR"]  				= default_axis(LOCALIZE("R-828 (VHF-1) Radio Volume"), devices.R_828, device_commands.Button_2, 372, 0.05, 0.1, false, false, false, {-130, -45}, {130, -45})
elements["ASU-PTR"] 						= default_button(LOCALIZE("R-828 (VHF-1) Tuner button"), devices.R_828, device_commands.Button_3, 373, nil, nil, true)

elements["RADIO-PSH-SWITCH-PTR"]  			= default_2_position_tumb(LOCALIZE("R-828 (VHF-1) Squelch"), devices.R_828, device_commands.Button_4, 374)
elements["RADIO-PSH-SWITCH-PTR"].sound 		= {{SOUND_SW1}}

--------------------------------------------------------------------------------------------
-- Signal Flares
local signalFlareBtnAnimSpeed				= 20

elements["SIGNAL-FLARE-1-PTR"] 				= default_2_position_tumb(LOCALIZE("Signal flare red"), devices.SIGNAL_FLARE_DISPENSER, device_commands.Button_2, 376, nil, nil, false, signalFlareBtnAnimSpeed)
elements["SIGNAL-FLARE-1-PTR"].class_vr 	= {class_type.BTN_FIX}
elements["SIGNAL-FLARE-1-PTR"].side 		= {{BOX_SIDE_Y_bottom}}
elements["SIGNAL-FLARE-1-PTR"].sound 		= {{SOUND_SW8_OFF, SOUND_SW8_ON}}

elements["SIGNAL-FLARE-2-PTR"] 				= default_2_position_tumb(LOCALIZE("Signal flare green"), devices.SIGNAL_FLARE_DISPENSER, device_commands.Button_1, 377, nil, nil, false, signalFlareBtnAnimSpeed)
elements["SIGNAL-FLARE-2-PTR"].class_vr 	= {class_type.BTN_FIX}
elements["SIGNAL-FLARE-2-PTR"].side 		= {{BOX_SIDE_Y_bottom}}
elements["SIGNAL-FLARE-2-PTR"].sound 		= {{SOUND_SW8_OFF, SOUND_SW8_ON}}

elements["SIGNAL-FLARE-3-PTR"] 				= default_2_position_tumb(LOCALIZE("Signal flare white"), devices.SIGNAL_FLARE_DISPENSER, device_commands.Button_3, 378, nil, nil, false, signalFlareBtnAnimSpeed)
elements["SIGNAL-FLARE-3-PTR"].class_vr 	= {class_type.BTN_FIX}
elements["SIGNAL-FLARE-3-PTR"].side 		= {{BOX_SIDE_Y_bottom}}
elements["SIGNAL-FLARE-3-PTR"].sound 		= {{SOUND_SW8_OFF, SOUND_SW8_ON}}

elements["SIGNAL-FLARE-4-PTR"] 				= default_2_position_tumb(LOCALIZE("Signal flare yellow"), devices.SIGNAL_FLARE_DISPENSER, device_commands.Button_4, 379, nil, nil, false, signalFlareBtnAnimSpeed)
elements["SIGNAL-FLARE-4-PTR"].class_vr 	= {class_type.BTN_FIX}
elements["SIGNAL-FLARE-4-PTR"].side 		= {{BOX_SIDE_Y_bottom}}
elements["SIGNAL-FLARE-4-PTR"].sound 		= {{SOUND_SW8_OFF, SOUND_SW8_ON}}

elements["SIGNAL-FLARE-SWITCH-PTR"] 		= default_2_position_tumb(LOCALIZE("Signal flare system power"), devices.SIGNAL_FLARE_DISPENSER, device_commands.Button_5, 380)

--------------------------------------------------------------------------------------------
-- PShK_7 (Latitude Entry Panel)
elements["LATITUDE-PTR"] 					= default_axis(LOCALIZE("Latitude selection rotaty"), devices.PShK_7, device_commands.Button_1, 340, 0.12, 0.2, false, true, false, {-130, -45}, {130, -45})
elements["N-S-PTR"]							= default_2_position_tumb(LOCALIZE("North/South latitude selection"), devices.PShK_7, device_commands.Button_2, 341, nil, nil, true)

--------------------------------------------------------------------------------------------
-- ZMS_3 (Magnetic Variation Entry Panel)
elements["DCLIN-PTR"] 						= default_axis(LOCALIZE("Magnetic variation selection rotaty"), devices.ZMS_3, device_commands.Button_1, 338, 0.12, 0.2, false, true, false, {-110, -45}, {100, -45})

elements["STICK_VISIBILITY"] 				= default_2_position_tumb(LOCALIZE("Hide Stick toggle"), devices.CPT_MECH, device_commands.Button_11, 1005)

if cyclic_by_default == true then
	for n, el in pairs(elements) do
		if el.class[1] ~= nil and
		   el.class[2] ~= nil and
		   el.class[1] == class_type.TUMB and
		   el.class[2] == class_type.TUMB then
		   el.cycle = true
		end
	end
end
