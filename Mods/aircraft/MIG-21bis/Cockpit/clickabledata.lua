local gettext = require("i_18n")
_ = gettext.translate

dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."devices.lua")
--dofile(LockOn_Options.script_path.."Hint_localizer.lua") --/N/ check this file since the text in this script changed


cursor_mode = 
{ 
 CUMODE_CLICKABLE = 0,
 CUMODE_CLICKABLE_AND_CAMERA = 1,
 CUMODE_CAMERA = 2,
};

clickable_mode_initial_status = cursor_mode.CUMODE_CLICKABLE
use_pointer_name			 = true
direction = 1
cyclic_by_default = true -- to cycle two-way thumblers or not by default

function default_button(hint_,device_,command_,arg_,arg_val_,arg_lim_)
	local arg_val_ = arg_val_ or 1
	local arg_lim_ = arg_lim_ or {0,1}
	return {	
				class 				 = {class_type.BTN},
				hint 				 = hint_,
				device 				 = device_,
				action 				 = {command_},
				stop_action 		 = {command_},
				arg 				 = {arg_},
				arg_value			 = {arg_val_}, 
				arg_lim 			 = {arg_lim_},
				use_release_message = {true}
			}
end

function default_1_position_tumb(hint_, device_, command_, arg_, arg_val_, arg_lim_)
	local arg_val_ = arg_val_ or 1
	local arg_lim_ = arg_lim_ or {0,1}
	return {	
				class 		 = {class_type.TUMB},
				hint 		 = hint_,
				device 		 = device_,
				action 		 = {command_},
				arg 	 	 = {arg_},
				arg_value 	 = {arg_val_}, 
				arg_lim 	 = {arg_lim_},
				updatable 	 = true, 
				use_OBB 	 = true
			}
end

function default_2_position_tumb(hint_, device_, command_, arg_)
	return {	
				class 		 = {class_type.TUMB,class_type.TUMB},
				hint 		 = hint_,
				device 		 = device_,
				action 		 = {command_,command_},
				arg 	 	 = {arg_,arg_},
				arg_value 	 = {1,-1}, 
				arg_lim 	 = {{0,1},{0,1}},
				updatable 	 = true, 
				use_OBB 	 = true
			}
end

function default_3_position_tumb(hint_,device_,command_,arg_,cycled_,inversed_)
	local cycled = true
	
	local arg_value_ = {0.5, -0.5}
	
	local val = 1
	if inversed_ then
	 val = -1
	 arg_value_ = {-0.5, 0.5}
	end
	
	
	if cycled_ ~= nil then
	 cycled = cycled_
	end
	return {	
				class 		 = {class_type.TUMB,class_type.TUMB},
				hint 		 = hint_,
				device 		 = device_,
				--[[
				action 		 = {command_,command_},
				arg 	 	 = {arg_,arg_},
				arg_value 	 = {val,-val}, 
				arg_lim 	 = {{-1,1},{-1,1}},
				]]
				
				action 		 = {command_,command_},
				arg 	 	 = {arg_,arg_},		
				
				
				arg_value 	 = arg_value_,
				
				arg_lim 	 = {{0,1},{0,1}},

				
				updatable 	 = true, 
				use_OBB 	 = true,
				cycle = cycled
			}
end

function default_axis(hint_,device_,command_,arg_, default_, gain_,updatable_,relative_,cycle_)
	local default = default_ or 1
	local gain = gain_ or 0.1
	local updatable = updatable_ or false
	local relative = relative_ or false
	return {	
				class 		 = {class_type.LEV},
				hint 		 = hint_,
				device 		 = device_,
				action 		 = {command_},
				arg 	 	 = {arg_},
				arg_value 	 = {default}, 
				arg_lim 	 = {{0,1}},
				updatable 	 = updatable, --/N/ if it is attached to some movable object, like a button to a stick
				use_OBB 	 = false,
				gain		 = {gain},
				relative 	 = {relative}, 				
				cycle 	 	 =  cycle_ or false
			}
end

function default_axis_negative(hint_,device_,command_,arg_, default_, gain_,updatable_,relative_,cycle_)
	local default = default_ or -1.0
	local gain = gain_ or -0.1
	local updatable = updatable_ or false
	local relative = relative_ or false
	return {	
				class 		 = {class_type.LEV},
				hint 		 = hint_,
				device 		 = device_,
				action 		 = {command_},
				arg 	 	 = {arg_},
				arg_value 	 = {default}, 
				arg_lim 	 = {{-1.0,0.0}},--/N/
				updatable 	 = updatable, --/N/ if it is attached to some movable object, like a button to a stick
				use_OBB 	 = false,
				gain		 = {gain},
				relative 	 = {relative}, 				
				cycle 	 	 =  cycle_ or false
			}
end

-- Added full range axis to fix cockpit light knobs animation issue with mouse.  ..thx Joe!
function default_axis_full(hint_,device_,command_,arg_, default_, gain_,updatable_,relative_,cycle_)
    local default = default_ or -1.0
    local gain = gain_ or -0.1
    local updatable = updatable_ or false
    local relative = relative_ or false
    return {    
                class          = {class_type.LEV},
                hint          = hint_,
                device          = device_,
                action          = {command_},
                arg           = {arg_},
                arg_value      = {default}, 
                arg_lim      = {{-1.0,1.0}},--/N/
                updatable      = updatable, --/N/ if it is attached to some movable object, like a button to a stick
                use_OBB      = false,
                gain         = {gain},
                relative      = {relative},                 
                cycle           =  cycle_ or false
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

function multiposition_switch(hint_,device_,command_,arg_,count_,delta_,inversed_, min_)
 local min_ = min_ or 0
	local delta_ = delta_ or 0.5
	local inversed = 1
	if	inversed_ then
		inversed = -1
	end
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
				use_OBB 	 = true
			}
end

function multiposition_switch_limited(hint_,device_,command_,arg_,count_,delta_,inversed_,min_)
 local min_ = min_ or 0
	local delta_ = delta_ or 0.5
	local inversed = 1
	if	inversed_ then
		inversed = -1
	end
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
			}
end

function default_button_axis(hint_, device_,command_1, command_2, arg_1, arg_2, limit_1, limit_2)
	local limit_1_ = limit_1 or 1.0
	local limit_2_ = limit_2 or 1.0
return {
			class		 = 	{class_type.BTN, class_type.LEV},
			hint		 = 	hint_,
			device		 = 	device_,
			action		 = 	{command_1, command_2},
			stop_action = {command_1, 0},
			arg			 = 	{arg_1, arg_2},
			arg_value	 = 	{1, 0.5},
			arg_lim		 = 	{{0, limit_1_}, {0,limit_2_}},
			animated = {false,true},
			animation_speed = {0, 0.9},
			gain = {0, 0.5},
			relative	 = 	{false, false},
			updatable 	 = 	true, 
			use_OBB 	 = 	true,
			use_release_message = {true, false}
	}
end

function default_animated_lever(hint_, device_, command_, arg_, animation_speed_,arg_lim_)
local arg_lim__ = arg_lim_ or {0.0,1.0}
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
	cycle = true
}
end

function default_button_tumb(hint_, device_, command1_, command2_, arg_)
	return {	
				class 		 = {class_type.BTN,class_type.TUMB},
				hint 		 = hint_,
				device 		 = device_,
				action 		 = {command1_,command2_},
				stop_action = {command1_,0},
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


elements = {}

-- DC & AC buses & giro devices
elements["PNT_165"] = default_2_position_tumb(_("Battery On/Off"),devices.DC_BUS, device_commands.BatteryOn,165) 
elements["PNT_155"] = default_2_position_tumb(_("Battery Heat On/Off"),devices.DC_BUS, device_commands.BatteryHeat,155) 
elements["PNT_166"] = default_2_position_tumb(_("DC Generator On/Off"),devices.DC_BUS, device_commands.DCGenerator,166) 
elements["PNT_169"] = default_2_position_tumb(_("AC Generator On/Off"),devices.AC_BUS, device_commands.ACGenerator,169) 
elements["PNT_153"] = default_2_position_tumb(_("PO-750 Inverter #1 On/Off"),devices.AC_BUS, device_commands.PO7501,153) 
elements["PNT_154"] = default_2_position_tumb(_("PO-750 Inverter #2 On/Off"),devices.AC_BUS, device_commands.PO7502,154) 
elements["PNT_164"] = default_2_position_tumb(_("Emergency Inverter"),devices.AC_BUS, device_commands.EmergencyInverter,164)

-- GIRO
elements["PNT_162"] = default_2_position_tumb(_("Giro, NPP, SAU, RLS Signal, KPP Power On/Off"),devices.GYRO_DEVICES, device_commands.Giro1,162)
elements["PNT_163"] = default_2_position_tumb(_("DA-200 Signal, Giro, NPP, RLS, SAU Power On/Off"),devices.GYRO_DEVICES, device_commands.Giro2,163)

-- FUEL_PUMPS & FUEL_SYSTEM (merged)
elements["PNT_159"] = default_2_position_tumb(_("Fuel Tanks 3rd Group, Fuel Pump"),devices.FUEL_PUMPS, device_commands.Pump3,159)
elements["PNT_160"] = default_2_position_tumb(_("Fuel Tanks 1st Group, Fuel Pump"),devices.FUEL_PUMPS, device_commands.Pump1,160)
elements["PNT_161"] = default_2_position_tumb(_("Drain Fuel Tank, Fuel Pump"),devices.FUEL_PUMPS, device_commands.PumpRashod,161)
elements["PNT_274"] = default_axis(_("Fuel Quantity Set"),devices.FUEL_SYSTEM, device_commands.FuelQt,274, 0.0, 0.02, false, false, false)  -- true, false, false

-- ENGINE START DEVICE
elements["PNT_302"] = default_2_position_tumb(_("APU On/Off"),devices.ENGINE_START_DEVICE, device_commands.Zazig,302)
elements["PNT_288"] = default_2_position_tumb(_("Engine Cold / Normal Start"),devices.ENGINE_START_DEVICE, device_commands.HotStart,288)
elements["PNT_289"] = default_button(_("Start Engine"),devices.ENGINE_START_DEVICE, device_commands.StartButton,289)
elements["PNT_301"] = default_2_position_tumb(_("Engine Emergency Air Start"),devices.ENGINE_START_DEVICE, device_commands.AirStart,301)
elements["PNT_430"] = default_button(_("Engine Stop/Lock"),devices.ENGINE_START_DEVICE, device_commands.RUDStop_lock,616)

-- ACCELEROMETER
elements["PNT_228"] = default_button(_("Accelerometer Reset"),devices.ACCELEROMETER, device_commands.AccelReset,228) 

-- PITOT TUBES and related things that use dc bus for heating
elements["PNT_229"] = default_2_position_tumb(_("Pitot tube Selector Main/Emergency"),devices.PITOT_TUBES, device_commands.PitoSelect,229)
elements["PNT_279"] = default_2_position_tumb(_("Pitot tube/Periscope/Clock Heat"),devices.PITOT_TUBES, device_commands.PitoHeatMain,279)
elements["PNT_280"] = default_2_position_tumb(_("Secondary Pitot Tube Heat"),devices.PITOT_TUBES, device_commands.PitoHeatAux,280)

-- DA-200
elements["PNT_261"] = default_axis_limited(_("Variometer Set"),devices.DA_200, device_commands.DA200set,261, 0.0001, false, false, {-1.0, 1.0})
--elements["PNT_261"] = default_axis(_("Variometer Set"),devices.DA_200, device_commands.DA200set,261, 0.0001, false, false, false)

-- ENGINE
elements["PNT_308"] = default_2_position_tumb(_("Anti surge doors - Auto/Manual"),devices.ENGINE, device_commands.SurgeDoors,308)
elements["PNT_300"] = default_2_position_tumb(_("Afterburner/Maximum Off/On"),devices.ENGINE, device_commands.ForsMax,300)
elements["PNT_320"] = default_2_position_tumb(_("Emergency Afterburner Off/On"),devices.ENGINE, device_commands.Chr,320)

-- FIRE EXTINGUISHER
elements["PNT_303"] = default_2_position_tumb(_("Fire Extinguisher Off/On"),devices.FIRE_EXTINGUISHER, device_commands.PozarOborud,303)
elements["PNT_324"] = default_2_position_tumb(_("Fire Extinguisher Cover"),devices.FIRE_EXTINGUISHER, device_commands.PozarSafetyCover,324)
elements["PNT_325"] = default_button(_("Fire Extinguisher"),devices.FIRE_EXTINGUISHER, device_commands.Ognetushitel,325)

-- LIGHTS
--elements["PNT_152"] = default_axis(_("Cockpit Texts Back-light"),devices.LIGHTS, device_commands.TextBacklight_axis,612, 0.0, 0.1, true, false)
elements["PNT_152"] = default_axis_full(_("Cockpit Texts Back-light"),devices.LIGHTS, device_commands.TextBacklight_axis,612, -1.0, 0.1, true, false) -- Mike/ Fixed 3d animation and adjusted values here - 20200611

--elements["PNT_156"] = default_axis(_("Instruments Back-light"),devices.LIGHTS, device_commands.InstrumentsBacklight_axis,156, 0.0, 0.1, true, false) 
elements["PNT_156"] = default_axis_full(_("Instruments Back-light"),devices.LIGHTS, device_commands.InstrumentsBacklight_axis,156, -1.0, 0.1, true, false) -- Mike/ Fixed 3d animation and adjusted values here - 20200611

--elements["PNT_157"] = default_axis(_("Main Red Lights"),devices.LIGHTS, device_commands.RedLightsMain,157, 0.0, 0.1, true, false) 
elements["PNT_157"] = default_axis_negative(_("Main Red Lights"),devices.LIGHTS, device_commands.RedLightsMain,157, 0.0, -0.1, true, false) 

--elements["PNT_222"] = default_axis(_("Main White Lights"),devices.LIGHTS, device_commands.WhiteLightsMain,222, 0.0, 0.1, true, false)
elements["PNT_222"] = default_axis_limited(_("Main White Lights"),devices.LIGHTS, device_commands.WhiteLightsMain,222, 0.1, false, false, {0.0, 1.0})


elements["PNT_194"] = multiposition_switch(_("Navigation Lights Off/Min/Med/Max"),devices.LIGHTS, device_commands.NavLights,194,4, 0.33,true)

elements["PNT_323"] = multiposition_switch_limited(_("Landing Lights Off/Taxi/Land"),devices.LIGHTS, device_commands.LandingLights_mouse,323,3, 0.5,true)

-- LIGHTS WARNING
elements["PNT_195"] = default_button_axis(_("Check Warning Lights - Set Warning Light Day/Night"),devices.LIGHTS_WARNING, device_commands.CheckWarningLights10, device_commands.CheckWarningLights11, 369, 195, 1.0, 1.0) -- T4 **
elements["PNT_196"] = default_button_axis(_("Check Warning Lights - Set Warning Light Day/Night"),devices.LIGHTS_WARNING, device_commands.CheckWarningLights20, device_commands.CheckWarningLights21, 370, 196, 1.0, 1.0) -- T10 ** 
elements["PNT_273"] = default_button_axis(_("Check Warning Lights - Set Warning Light Day/Night"),devices.LIGHTS_WARNING, device_commands.CheckWarningLights30, device_commands.CheckWarningLights31, 371, 273, 1.0, 1.0) -- T4-2 **
elements["PNT_282"] = default_button_axis(_("Check Warning Lights - Set Warning Light Day/Night"),devices.LIGHTS_WARNING, device_commands.CheckWarningLights40, device_commands.CheckWarningLights41, 372, 282, 1.0, 1.0) -- T4-3 ** 
elements["PNT_283"] = default_button_axis(_("Check Warning Lights - Set Warning Light Day/Night"),devices.LIGHTS_WARNING, device_commands.CheckWarningLights50, device_commands.CheckWarningLights51, 373, 283, 1.0, 1.0) -- T10-2 ** 
elements["PNT_322"] = default_button_axis(_("Check Warning Lights - Set Warning Light Day/Night"),devices.LIGHTS_WARNING, device_commands.CheckWarningLights60, device_commands.CheckWarningLights61, 374, 322, 1.0, 1.0) -- PPS 
elements["PNT_255"] = default_button_axis(_("SORC"),devices.LIGHTS_WARNING, device_commands.SORC, device_commands.SORCNightDay, 255, 657, 1.0, 1.0)

-- Radio 
elements["PNT_173"] = default_2_position_tumb(_("Radio System On/Off"),devices.RADIO, device_commands.RadioOn,173)
elements["PNT_208"] = default_2_position_tumb(_("Radio / Compass"),devices.RADIO, device_commands.RadioCompassSound,208)
elements["PNT_209"] = default_2_position_tumb(_("Squelch On/Off"),devices.RADIO, device_commands.Squelch,209)
elements["PNT_210"] = default_axis(_("Radio Volume"),devices.RADIO, device_commands.RadioVolume,210, 0.0, 0.1, true, false)
elements["PNT_211"] = multiposition_switch(_("Radio Channel"),devices.RADIO, device_commands.RadioChannel, 211, 20, 0.05, true)
elements["PNT_315"] = default_button(_("Radio PTT"),devices.INTERCOM, device_commands.RadioINTERCOM,315)
elements["PNT_315"].updatable = true


-- ARK
elements["PNT_174"] = default_2_position_tumb(_("ARK On/Off"),devices.ARK, device_commands.ARKon,174)
elements["PNT_198"] = default_axis(_("ARK Sound"),devices.ARK, device_commands.ARKsound,198, 0.0, 0.1, true, false)
elements["PNT_212"] = default_button(_("ARK Change"),devices.ARK, device_commands.ARKpereklucenie,212)
elements["PNT_213"] = default_1_position_tumb(_("ARK 1"),devices.ARK, device_commands.ARKchannel,213, 0.0, {0.1,0.1})
elements["PNT_214"] = default_1_position_tumb(_("ARK 2"),devices.ARK, device_commands.ARKchannel,213, 0.0, {0.2,0.2})
elements["PNT_215"] = default_1_position_tumb(_("ARK 3"),devices.ARK, device_commands.ARKchannel,213, 0.0, {0.3,0.3})
elements["PNT_216"] = default_1_position_tumb(_("ARK 4"),devices.ARK, device_commands.ARKchannel,213, 0.0, {0.4,0.4})
elements["PNT_216"] = default_1_position_tumb(_("ARK 4"),devices.ARK, device_commands.ARKchannel,213, 0.0, {0.4,0.4})
elements["PNT_217"] = default_1_position_tumb(_("ARK 5"),devices.ARK, device_commands.ARKchannel,213, 0.0, {0.5,0.5})
elements["PNT_218"] = default_1_position_tumb(_("ARK 6"),devices.ARK, device_commands.ARKchannel,213, 0.0, {0.6,0.6})
elements["PNT_219"] = default_1_position_tumb(_("ARK 7"),devices.ARK, device_commands.ARKchannel,213, 0.0, {0.7,0.7})
elements["PNT_220"] = default_1_position_tumb(_("ARK 8"),devices.ARK, device_commands.ARKchannel,213, 0.0, {0.8,0.8})
elements["PNT_221"] = default_1_position_tumb(_("ARK 9"),devices.ARK, device_commands.ARKchannel,213, 0.0, {0.9,0.9})
elements["PNT_189"] = multiposition_switch_limited(_("ARK Zone"),devices.ARK, device_commands.ARKzone, 189, 8, 0.14, true)
elements["PNT_197"] = default_2_position_tumb(_("ARK Mode - Antenna / Compass"),devices.ARK, device_commands.ARKantenaCompass,197)
elements["PNT_254"] = default_2_position_tumb(_("Marker Far/Near"),devices.ARK, device_commands.ARKfarNear,254)

-- RSBN
elements["PNT_176"] = default_2_position_tumb(_("RSBN On/Off"),devices.RSBN, device_commands.RSBNon,176)
elements["PNT_240"] = multiposition_switch_limited(_("RSBN Mode Land/Navigation/Descend"),devices.RSBN, device_commands.RSBNmode,240,3,0.5,true)
elements["PNT_340"] = default_2_position_tumb(_("RSBN / ARK"),devices.RSBN, device_commands.RSBNARK, 340) 
elements["PNT_294"] = default_button(_("RSBN Identify"),devices.RSBN, device_commands.RSBNident,294)
elements["PNT_347"] = default_button(_("RSBN self-test"),devices.RSBN, device_commands.RSBNtest,347)

--RSBN Panel
elements["PNT_345"] = default_axis(_("RSBN Sound"),devices.RSBN, device_commands.RSBNsound,345, 0.0, 0.1, true, false) 
elements["PNT_349"] = multiposition_switch(_("RSBN Navigation"),devices.RSBN, device_commands.RSBNnav, 351, 100, 0.01, true) 
elements["PNT_350"] = multiposition_switch(_("PRMG Landing"),devices.RSBN, device_commands.RSBNland, 352, 100, 0.01, true) 
elements["PNT_366"] = default_button(_("RSBN Reset"),devices.RSBN, device_commands.RSBNreset,366) 

--/N/ need 3d implementation, arg. val. -1..0..1
elements["PNT_367"] = default_2_position_tumb(_("RSBN Bearing"),devices.RSBN, device_commands.RSBNbearing, 367) 
elements["PNT_368"] = default_2_position_tumb(_("RSBN Distance"),devices.RSBN, device_commands.RSBNfar, 368) 
--elements["PNT_367"] = default_springloaded_3pos_switch(_("RSBN Bearing"),devices.RSBN, device_commands.RSBNbearing,device_commands.RSBNbearing, 1.0, 0.5, 0.0, 367) 
--elements["PNT_368"] = default_springloaded_3pos_switch(_("RSBN Distance"),devices.RSBN, device_commands.RSBNfar,device_commands.RSBNfar, 1.0, 0.5, 0.0, 368) 


-- SAU
elements["PNT_179"] = default_2_position_tumb(_("SAU On/Off"),devices.SAU, device_commands.SAUon,179) 
elements["PNT_180"] = default_2_position_tumb(_("SAU Pitch On/Off"),devices.SAU, device_commands.SAUpitchOn,180) 
elements["PNT_343"] = default_button(_("SAU - Stabilize"),devices.SAU, device_commands.SAUstabil,343)
elements["PNT_376"] = default_button(_("SAU cancel current mode"),devices.SAU, device_commands.SAUcancel,376) -- stick
elements["PNT_376"].updatable = true
elements["PNT_377"] = default_button(_("SAU - Recovery"),devices.SAU, device_commands.SAUprivedenie,377) -- stick
elements["PNT_377"].updatable = true
elements["PNT_344"] = default_2_position_tumb(_("SAU Preset - Limit Altitude"),devices.SAU, device_commands.SAUlowAltOn,344)
elements["PNT_341"] = default_button(_("SAU - Landing - Command"),devices.SAU, device_commands.SAUlandingControlCommand, 341)
elements["PNT_342"] = default_button(_("SAU - Landing - Auto"),devices.SAU, device_commands.SAUlandingControlAuto, 342)
elements["PNT_348"] = default_button(_("SAU Reset/Off"),devices.SAU, device_commands.SAUresetOff,348)

-- SPO
elements["PNT_202"] = default_2_position_tumb(_("SPO-10 RWR On/Off"),devices.SPO, device_commands.SPOon,202)
elements["PNT_226"] = default_button(_("SPO-10 Test"),devices.SPO, device_commands.SPOtest,226)
elements["PNT_227"] = default_2_position_tumb(_("SPO-10 Night / Day"),devices.SPO, device_commands.SPOdayNight,227)
elements["PNT_225"] = default_axis(_("SPO-10 Volume"),devices.SPO, device_commands.SPOvolume,225, 0.0, 0.1, true, false)

-- SRZO IFF
elements["PNT_188"] = default_2_position_tumb(_("SRZO IFF Coder/Decoder On/Off"),devices.SRZO, device_commands.SRZOvopros,188)
elements["PNT_192"] = multiposition_switch(_("SRZO Codes"),devices.SRZO, device_commands.SRZOcodes, 192, 12, 0.08, true)
elements["PNT_346"] = default_2_position_tumb(_("IFF System 'Type 81' On/Off"),devices.SRZO, device_commands.SRZOon,346)
elements["PNT_190"] = default_2_position_tumb(_("Emergency Transmitter Cover"),devices.SRZO, device_commands.EmergTransmitSafetyCover,190)
elements["PNT_191"] = default_2_position_tumb(_("Emergency Transmitter On/Off"),devices.SRZO, device_commands.EmergTransmitOn,191)
elements["PNT_427"] = default_2_position_tumb(_("SRZO Self Destruct Cover"),devices.SRZO, device_commands.SRZODestrCover,427) 
elements["PNT_428"] = default_button(_("SRZO Self Destruct"),devices.SRZO, device_commands.SRZODestr,428)

-- SOD (increase radar signal for ATC radar, most likely won't be implemented)
elements["PNT_200"] = default_2_position_tumb(_("SOD IFF On/Off"),devices.SOD, device_commands.SODon,200)
elements["PNT_199"] = default_button(_("SOD Identify"),devices.SOD, device_commands.SODident,199)
elements["PNT_201"] = multiposition_switch_limited(_("SOD Wave Selector 3/1/2"),devices.SOD, device_commands.SODvolni,201,3, 0.5, true)
elements["PNT_204"] = multiposition_switch_limited(_("SOD Modes"),devices.SOD, device_commands.SODmode, 204, 5, 0.25, true)

-- RADAR
elements["PNT_205"] = multiposition_switch_limited(_("Radar Off/Prep/On"),devices.RADAR, device_commands.RADARon,205,3, 0.5,true)
elements["PNT_206"] = multiposition_switch_limited(_("Low Altitude Off/Comp/On"),devices.RADAR, device_commands.RADARlowAlt,206,3, 0.5,true) 
elements["PNT_207"] = default_2_position_tumb(_("Locked Beam On/Off"),devices.RADAR, device_commands.RADARfixBeam,207) 
elements["PNT_266"] = default_button(_("Radar Screen Magnetic Reset"),devices.RADAR, device_commands.RADARmgnStir,266) 
elements["PNT_330"] = default_button(_("Radar Interferes - Continues")	,devices.RADAR, device_commands.RADARjamCont,330) 
elements["PNT_331"] = default_button(_("Radar Interferes - Temporary"),devices.RADAR, device_commands.RADARjamTmp,331) 
elements["PNT_332"] = default_button(_("Radar Interferes - Passive")	,devices.RADAR, device_commands.RADARjamPass,332) 
elements["PNT_333"] = default_button(_("Radar Interferes - Weather"),devices.RADAR, device_commands.RADARjamMeteo,333) 
elements["PNT_334"] = default_button(_("Radar Interferes - IFF"),devices.RADAR, device_commands.RADARvopros,334) 
elements["PNT_335"] = default_button(_("Radar Interferes - Low Speed"),devices.RADAR, device_commands.RADARjamLowSpeed,335) 
elements["PNT_336"] = default_button(_("Radar Interferes - Self-test"),devices.RADAR, device_commands.RADARkontrol,336) 
elements["PNT_337"] = default_button(_("Radar Interferes - Reset"),devices.RADAR, device_commands.RADARreset,337) 
elements["PNT_378"] = default_button(_("Lock Target"),devices.RADAR, device_commands.Zahvat,378) -- stick
elements["PNT_378"].updatable = true -- stick
elements["PNT_432"] = default_axis(_("Radar Polar Filter"),devices.RADAR, device_commands.RADARFilter,623, 0.0, 0.1, true, false)

-- SPRD
elements["PNT_167"] = default_2_position_tumb(_("SPRD (RATO) System On/Off"),devices.SPRD, device_commands.SPRDstartOn,167)
elements["PNT_168"] = default_2_position_tumb(_("SPRD (RATO) Drop System On/Off"),devices.SPRD, device_commands.SPRDdropOn,168)
elements["PNT_252"] = default_2_position_tumb(_("SPRD (RATO) Start Cover"),devices.SPRD, device_commands.SPRDstartSafetyCover,252)
elements["PNT_253"] = default_button(_("SPRD (RATO) Start"),devices.SPRD, device_commands.SPRDstart,253)
elements["PNT_317"] = default_2_position_tumb(_("SPRD (RATO)t Drop Cover"),devices.SPRD, device_commands.SPRDdropSafetyCover,317)
elements["PNT_318"] = default_button(_("SPRD (RATO) Drop"),devices.SPRD, device_commands.SPRDdrop,318)

-- CONTROL SYSTEM ------------- subsystems --------------------------------------------
		-- SPS
elements["PNT_293"] = default_2_position_tumb(_("SPS System Off/On"),devices.SPS, device_commands.SPSon,293)
		-- ARU
elements["PNT_295"] = default_2_position_tumb(_("ARU System - Manual/Auto"),devices.ARU, device_commands.ARUmanAuto,295) --**
elements["PNT_296"]	= default_springloaded_3pos_switch(_("ARU System - Low Speed/Neutral/High Speed"), devices.ARU, device_commands.ARUhighSpeed, device_commands.ARUlowSpeed, 1, 0, -1, 296)				 
		-- Airbrake
elements["PNT_316"] = default_2_position_tumb(_("Airbrake - Out/In"),devices.AIRBRAKE, device_commands.Airbrakes,316)
		-- Gear brakes
elements["PNT_299"] = default_2_position_tumb(_("ABS Off/On"),devices.GEAR_BRAKES, device_commands.ABSon,299) --**
elements["PNT_238"] = default_2_position_tumb(_("Nosegear Brake Off/On"),devices.GEAR_BRAKES, device_commands.NosegearBrake,238)
elements["PNT_237"] = default_2_position_tumb(_("Emergency Brake"),devices.GEAR_BRAKES, device_commands.EmergBrakes,237)
		-- Gears
elements["PNT_326"] = default_2_position_tumb(_("Gear Handle Fixator"),devices.GEARS, device_commands.GearHandleFixator,326) --**
--elements["PNT_327"] = default_3_position_tumb(_("Gear Up/Neutral/Down"),devices.GEARS, device_commands.GearLever,327,false,false) 
elements["PNT_327"] = multiposition_switch_limited(_("Gear Up/Neutral/Down"),devices.GEARS, device_commands.GearLever,327,3,1.0,false,-1.0)--**

--elements["PNT_223"] = default_axis_limited(_("Main Gears Emergency Release Handle"),devices.GEARS, device_commands.EmergGearsMain,223, 0.2, false, false, {0.0, 1.0})
elements["PNT_223"] = default_axis(_("Main Gears Emergency Release Handle"),devices.GEARS, device_commands.EmergGearsMain,223, 0.2, false, false, false)
elements["PNT_281"] = default_2_position_tumb(_("Nose Gear Emergency Release Handle"),devices.GEARS, device_commands.EmergGearsNose,281)

		-- Flaps
elements["PNT_311"] = default_2_position_tumb(_("Flaps Neutral"),devices.FLAPS, device_commands.Flaps0,311)
elements["PNT_312"] = default_2_position_tumb(_("Flaps Take-Off"),devices.FLAPS, device_commands.Flaps25,312)
elements["PNT_313"] = default_2_position_tumb(_("Flaps Landing"),devices.FLAPS, device_commands.Flaps45,313)
elements["PNT_314"] = default_button(_("Flaps Reset buttons"),devices.FLAPS, device_commands.FlapsReset,314)
		-- Drag chute
elements["PNT_298"] = default_button(_("Release Drag Chute"),devices.CHUTE, device_commands.DragChute,298)
elements["PNT_304"] = default_2_position_tumb(_("Drop Drag Chute Cover"),devices.CHUTE, device_commands.DragChuteSafetyCover,304) 
elements["PNT_305"] = default_button(_("Drop Drag Chute"),devices.CHUTE, device_commands.DragChuteDisconnect,305)

--TRIMER
elements["PNT_172"] = default_2_position_tumb(_("Trimmer On/Off"),devices.TRIMER, device_commands.TrimmerOn,172)
elements["PNT_379"]	= default_springloaded_3pos_switch(_("Trimmer Pitch Up/Down"), devices.TRIMER, device_commands.TrimmerBtnUp, device_commands.TrimmerBtnDown, -1, 0, 1, 379) --stick
elements["PNT_379"].updatable = true

-- KONUS
elements["PNT_170"] = default_2_position_tumb(_("Nosecone On/Off"),devices.KONUS, device_commands.KonusOn,170)	
elements["PNT_309"] = default_2_position_tumb(_("Nosecone Control - Manual/Auto"),devices.KONUS, device_commands.KonusManAuto,309)
--elements["PNT_236"] = default_axis_limited(_("Nosecone manual position controller"),devices.KONUS, device_commands.KonusButton,236, 0.05, false, false, {0.0, 1.0})
elements["PNT_236"] = default_axis(_("Nosecone manual position controller"),devices.KONUS, device_commands.KonusButton,236, 0.05, false, false, false)
--default_axis(hint_,device_,command_,arg_, default_, gain_,updatable_,relative_,cycle_)


-- SOPLO
elements["PNT_291"] = default_2_position_tumb(_("Engine Nozzle 2 Position Emergency Control"),devices.SOPLO, device_commands.Soplo2xPoz,291) 

--MAIN_HYDRO and BUSTER_HYDRO == == == == == == == == == == == == == == == == == == == TEMPORARY MERGED == == == == == == == == == == == == == == == == == == == == == == 
elements["PNT_171"] = default_2_position_tumb(_("Emergency Hydraulic Pump On/Off"),devices.MAIN_HYDRO, device_commands.NR27on,171)
elements["PNT_319"] = default_2_position_tumb(_("Aileron Booster - Off/On"),devices.MAIN_HYDRO, device_commands.AileronBoosters,319)

--KPP
elements["PNT_177"] = default_2_position_tumb(_("KPP Main/Emergency"),devices.KPP, device_commands.KPPon,177) 
elements["PNT_259"] = default_button(_("KPP Cage"),devices.KPP, device_commands.KPParretir,259) 
elements["PNT_260"] = default_axis_limited(_("KPP Set"),devices.KPP, device_commands.KPPsetPitch,260, 0.0001, false, false, {-1.0, 1.0})


--IAS / TAS / KSI (NPP)
elements["PNT_178"] = default_2_position_tumb(_("NPP On/Off"),devices.KSI, device_commands.NPPon,178) 
elements["PNT_258"] = default_button(_("NPP Adjust"),devices.KSI, device_commands.NPPnastrojka,258) 
elements["PNT_263"] = default_axis(_("NPP Course set"),devices.KSI, device_commands.NPPsetCourse,263, 1.0, 0.1, false, true)

-- ALTIMETER and radioALTIMETER
elements["PNT_175"] = default_2_position_tumb(_("Radio Altimeter/Marker On/Off"),devices.RADIO_ALTIMETER, device_commands.RadioAltOn,175)
elements["PNT_284"] = multiposition_switch_limited(_("Dangerous Altitude Warning Set"),devices.RADIO_ALTIMETER, device_commands.DangerAltSelect, 284, 8, 0.14, true) 
elements["PNT_262"] = default_axis_limited(_("Altimeter pressure knob"),devices.ALTIMETER, device_commands.AltimeterPressure,262, 0, 0.02, false, false, {-1.0, 1.0}, false)

--[[
elements["PNT_262"] = { 
	class = {class_type.BTN, class_type.LEV}, 
	hint = _("Altimeter pressure knob"), 
	device = devices.ALTIMETER, 
	action = {device_commands.AltimeterPressureReset, device_commands.AltimeterPressure}, 
	stop_action = {device_commands.AltimeterPressureReset, 0}, 
	is_repeatable = {}, 
	arg = {653, 262}, 
	arg_value = {1.0, 0.02}, 
	arg_lim = {{0, 1}, {0, 1}},
	-- relative = {0, 1},
	gain = {1.0, 0.02}, 
	use_release_message = {true, false}, 
	use_OBB = true }
]]

--OXYGENE_SYSTEM
elements["PNT_285"] = default_2_position_tumb(_("Helmet Air Condition Off/On"),devices.OXYGENE_SYSTEM, device_commands.HelmetAirCondition,285)
elements["PNT_286"] = default_2_position_tumb(_("Emergency Oxygen Off/On"),devices.OXYGENE_SYSTEM, device_commands.EmergOxygene,286)
elements["PNT_287"] = default_2_position_tumb(_("Mixture/Oxygen"),devices.OXYGENE_SYSTEM, device_commands.MixtureOxygeneSelect,287)

--CANOPY
elements["PNT_328"] = default_2_position_tumb(_("Hermetize Canopy"),devices.CANOPY, device_commands.CanopyHermetHandle, 328)
elements["PNT_329"] = default_2_position_tumb(_("Secure Canopy"),devices.CANOPY, device_commands.CanopyLockHandle, 329)
elements["PNT_375"] = default_button(_("Canopy Open"),devices.CANOPY, device_commands.CanopyOpen, 375)
elements["PNT_385"] = default_button(_("Canopy Close"),devices.CANOPY, device_commands.CanopyClose, 385)
elements["PNT_239"] = default_button(_("Canopy Anti Ice"),devices.CANOPY, device_commands.CanopyAntiIce,239)
elements["PNT_224"] = default_2_position_tumb(_("Canopy Emergency Release Handle"),devices.CANOPY, device_commands.CanopyEmergRelease,224)
elements["PNT_431"] = default_animated_lever(_("Canopy Ventilation System"),devices.CANOPY, device_commands.CanopyVentSystem,649, 1.0)


-- ASP Gunsight
elements["PNT_186"] = default_2_position_tumb(_("ASP Optical sight On/Off"),devices.ASP, device_commands.ASPon,186)
elements["PNT_241"] = default_2_position_tumb(_("ASP Main Mode - Manual/Auto"),devices.ASP, device_commands.ASPmanAutoSelect,241)
elements["PNT_242"] = default_2_position_tumb(_("ASP Mode - Bombardment/Shooting"),devices.ASP, device_commands.ASPbombStrelbSelect,242)
elements["PNT_243"] = default_2_position_tumb(_("ASP Mode - Missiles-Rockets/Gun"),devices.ASP, device_commands.ASPmissileGunSelect,243)
elements["PNT_244"] = default_2_position_tumb(_("ASP Mode - Giro/Missile"),devices.ASP, device_commands.ASPssGiroSelect,244)
elements["PNT_249"] = default_2_position_tumb(_("Pipper On/Off"),devices.ASP, device_commands.ASPpipperOn,249)
elements["PNT_250"] = default_2_position_tumb(_("Fix net On/Off"),devices.ASP, device_commands.ASPnetOn,250)

elements["PNT_245"] = default_axis(_("Target Size"),devices.ASP, device_commands.ASPtargetSize_mouse,245, 0.0, 0.1, true, false) -- -0.05
elements["PNT_246"] = default_axis(_("Intercept Angle"),devices.ASP, device_commands.ASPinterceptAngle_mouse,246, 0.0, 0.1, true, false)
elements["PNT_247"] = default_axis(_("Scale Backlights control"),devices.ASP, device_commands.ASPscaleLight_mouse,247, 0.0, 0.1, true, false)
elements["PNT_248"] = default_axis(_("Pipper light control"),devices.ASP, device_commands.ASPpipperLight_mouse,248, 0.0, 0.1, true, false)
elements["PNT_251"] = default_axis(_("Fix Net light control"),devices.ASP, device_commands.ASPnetLight_mouse,251, 0.0, 0.1, true, false) 
elements["PNT_384"] = default_axis(_("TDC Range / Pipper Span control"),devices.ASP, device_commands.RUDoblog_axis_mouse,384, 0.0, 0.1, true, false, false)
--elements["PNT_384"].updatable = true -- stick
--[[ --/N/ doesn't help 
elements["PNT_245"] = default_axis_limited(_("Target Size"),devices.ASP, device_commands.ASPtargetSize,245, 0.0, 0.1, true, false, {0.0, 1.0}, false) -- -0.05
elements["PNT_246"] = default_axis_limited(_("Intercept Angle"),devices.ASP, device_commands.ASPinterceptAngle,246, 0.0, 0.1, true, false, {0.0, 1.0}, false)
elements["PNT_247"] = default_axis_limited(_("Scale Backlights control"),devices.ASP, device_commands.ASPscaleLight,247, 0.0, 0.1, true, false, {0.0, 1.0}, false)
elements["PNT_248"] = default_axis_limited(_("Pipper light control"),devices.ASP, device_commands.ASPpipperLight,248, 0.0, 0.1, true, false, {0.0, 1.0}, false)
elements["PNT_251"] = default_axis_limited(_("Fix Net light control"),devices.ASP, device_commands.ASPnetLight,251, 0.0, 0.1, true, false, {0.0, 1.0}, false) 
elements["PNT_384"] = default_axis_limited(_("TDC Range / Pipper Span control"),devices.ASP, device_commands.RUDoblog_axis,384, 0.0, 0.1, true, false, {0.0, 1.0}, false)
]]

-- WEAPON_CONTROL
elements["PNT_181"] = default_2_position_tumb(_("Missiles - Rockets Heat On/Off"),devices.WEAPON_CONTROL, device_commands.Obogrev,181)
elements["PNT_182"] = default_2_position_tumb(_("Missiles - Rockets Launch On/Off"),devices.WEAPON_CONTROL, device_commands.Pusk,182)
elements["PNT_183"] = default_2_position_tumb(_("Pylon 1-2 Power On/Off"),devices.WEAPON_CONTROL, device_commands.Pitanie12,183)
elements["PNT_184"] = default_2_position_tumb(_("Pylon 3-4 Power On/Off"),devices.WEAPON_CONTROL, device_commands.Pitanie34,184)
elements["PNT_185"] = default_2_position_tumb(_("GS-23 Gun On/Off"),devices.WEAPON_CONTROL, device_commands.GS23,185)
elements["PNT_187"] = default_2_position_tumb(_("Guncam On/Off"),devices.WEAPON_CONTROL, device_commands.FKP,187) 
elements["PNT_277"] = default_2_position_tumb(_("Tactical Drop Cover"),devices.WEAPON_CONTROL, device_commands.TaktSbrosSafetyCover,277) 
elements["PNT_278"] = default_2_position_tumb(_("Tactical Drop"),devices.WEAPON_CONTROL, device_commands.TaktSbros,278) 
elements["PNT_275"] = default_2_position_tumb(_("Emergency Missile/Rocket Launcher Cover"),devices.WEAPON_CONTROL, device_commands.AvarPuskSafetyCover,275)
elements["PNT_276"] = default_button(_("Emergency Missile/Rocket Launcher"),devices.WEAPON_CONTROL, device_commands.AvarPusk,276)
elements["PNT_256"] = default_2_position_tumb(_("Drop Wing Fuel Tanks Cover"),devices.WEAPON_CONTROL, device_commands.SbrosKrilBakovSafetyCover,256) 
elements["PNT_257"] = default_button(_("Drop Wing Fuel Tanks"),devices.WEAPON_CONTROL, device_commands.SbrosKrilBakov,257) 
elements["PNT_386"] = default_button(_("Drop Center Fuel Tank"),devices.WEAPON_CONTROL, device_commands.SbrosPodvBakov,386)
elements["PNT_386"].updatable = true -- stick 
elements["PNT_269"] = default_2_position_tumb(_("Drop Payload - Outer Pylons Cover"),devices.WEAPON_CONTROL, device_commands.SbrosVnesnSafetyCover,269) 
elements["PNT_270"] = default_button(_("Drop Payload - Outer Pylons"),devices.WEAPON_CONTROL, device_commands.SbrosVnesn,270) 
elements["PNT_271"] = default_2_position_tumb(_("Drop Payload - Inner Pylons Cover"),devices.WEAPON_CONTROL, device_commands.SbrosVnutrSafetyCover,271)
elements["PNT_272"] = default_button(_("Drop Payload - Inner Pylons"),devices.WEAPON_CONTROL, device_commands.SbrosVnutr,272) 
elements["PNT_230"] = default_2_position_tumb(_("Weapon Mode - Air/Ground"),devices.WEAPON_CONTROL, device_commands.ASPvozduhZemlja,230)
elements["PNT_231"] = multiposition_switch_limited(_("Weapon Mode - IR Missile/Neutral/SAR Missile"),devices.WEAPON_CONTROL, device_commands.ASPssNeutrRns,231,3,0.5,true) 
elements["PNT_232"] = default_button(_("Activate Gun Loading Pyro - 1"),devices.WEAPON_CONTROL, device_commands.ASPgunReload1,232)
elements["PNT_233"] = default_button(_("Activate Gun Loading Pyro - 2"),devices.WEAPON_CONTROL, device_commands.ASPgunReload2,233)
elements["PNT_234"] = default_button(_("Activate Gun Loading Pyro - 3"),devices.WEAPON_CONTROL, device_commands.ASPgunReload3,234)
elements["PNT_235"] = multiposition_switch(_("Weapon Selector"),devices.WEAPON_CONTROL, device_commands.ASPlauncherSelect, 235, 11, 0.10, true)
elements["PNT_297"] = default_axis(_("Missile Seeker Sound"),devices.WEAPON_CONTROL, device_commands.MissileSound,297, 0.0, 0.1, true, false)
elements["PNT_381"] = default_button(_("Fire Gun"),devices.WEAPON_CONTROL, device_commands.GunFireBtn,381) -- stick - virtual switch only
elements["PNT_381"].updatable = true -- stick 
elements["PNT_382"] = default_button(_("Release Weapon"),devices.WEAPON_CONTROL, device_commands.PuskBtn,382) -- stick 
elements["PNT_382"].updatable = true -- stick 
elements["PNT_383"] = default_2_position_tumb(_("Release Weapon Cover"),devices.WEAPON_CONTROL, device_commands.PuskBtnSafetyCover,383) -- stick 
elements["PNT_383"].updatable = true -- stick 

--HELMET_VISOR
elements["PNT_306"] = default_2_position_tumb(_("Helmet Heat - Manual/Auto"),devices.HELMET_VISOR, device_commands.HelmetHeatManAut,306)
elements["PNT_310"] = default_button(_("Helmet Quick Heat"),devices.HELMET_VISOR, device_commands.HelmetQuickHeat,310)
elements["PNT_369"] = default_2_position_tumb(_("Helmet visor - off/on."),devices.HELMET_VISOR, device_commands.HelmetVisor,369)

--AIR CONDITIONING
elements["PNT_292"] = multiposition_switch_limited(_("Cockpit Air Condition Off/Cold/Auto/Warm"),devices.HELMET_VISOR, device_commands.AirConditioningSelect,292,4, 0.33, true)

-- SARPP
elements["PNT_433"] = default_2_position_tumb(_("SARPP-12 Flight Data Recorder On/Off"),devices.SARPP, device_commands.SARPP,193)	

--avAChS
elements["PNT_264"] = { 
	class = {class_type.BTN, class_type.BTN, class_type.LEV}, 
	hint = _("Mech clock left lever"), 
	device = devices.avAChS, 
	action = {device_commands.AChSleftpush, device_commands.AChSleftpull, device_commands.AChSleftrotate}, 
	stop_action = {device_commands.AChSleftpush, device_commands.AChSleftpull, 0}, 
	is_repeatable = {}, 
	arg = {265, 265, 264}, 
	arg_value = {1.0, -1.0, 0.04}, 
	arg_lim = {{0, 1}, {-1, 0}, {0, 1}}, 
	relative = {false,false,true}, 
	gain = {1.0, 1.0, 0.4}, 
	use_release_message = {true, true, false}, 
	use_OBB = true }
	
elements["PNT_268"] = { 
	class = {class_type.BTN, class_type.LEV}, 
	hint = _("Mech clock right lever"), 
	device = devices.avAChS, 
	action = {device_commands.AChSrightpush, device_commands.AChSrightrotate}, 
	stop_action = {device_commands.AChSrightpush, 0}, 
	is_repeatable = {}, 
	arg = {268, 267}, 
	arg_value = {1.0, 0.05}, 
	arg_lim = {{0, 1}, {-0.15, 0.15}}
	--[[, relative = {0, 1}--]], 
	gain = {1.0, 1.2}, 
	use_release_message = {true, false}, 
	use_OBB = true }

--UNCLASSIFIED
--[[
elements["PNT_290"]	= default_springloaded_3pos_switch(_("Seat Height Down/Neutral/Up"), devices.UNCLASSIFIED, device_commands.SeatHeightup, device_commands.SeatHeightDown, 1, 0, -1, 290)
]]


-- Flight Control
elements["PNT_ENG_INC"] = default_button(_("Throttle Increase"),devices.CONTROL_SYSTEM, device_commands.ThrottleInc,624)
elements["PNT_ENG_DEC"] = default_button(_("Throttle Decrease"),devices.CONTROL_SYSTEM, device_commands.ThrottleDec,625)
elements["PNT_RUD_LEFT"] = default_button(_("Rudder Left"),devices.CONTROL_SYSTEM, device_commands.RudLeft,626)
elements["PNT_RUD_RIGHT"] = default_button(_("Rudder Right"),devices.CONTROL_SYSTEM, device_commands.RudRight,627)
elements["PNT_STICK_UP"] = default_button(_("Stick Up"),devices.CONTROL_SYSTEM, device_commands.StickUp,628)
elements["PNT_STICK_DOWN"] = default_button(_("Stick Down"),devices.CONTROL_SYSTEM, device_commands.StickDown,629)
elements["PNT_STICK_LEFT"] = default_button(_("Stick Left"),devices.CONTROL_SYSTEM, device_commands.StickLeft,630)
elements["PNT_STICK_RIGHT"] = default_button(_("Stick Right"),devices.CONTROL_SYSTEM, device_commands.StickRight,631)
elements["PNT_FF"] = default_button(_("Force Feedback On/Off"),devices.CONTROL_SYSTEM, device_commands.ForceFeedback,654)

--Dummy buttons/switches
elements["PNT_450"] = default_2_position_tumb(_("Radar emission - Cover"),devices.RADAR, device_commands.MislModeCover,632)	
elements["PNT_434"] = default_2_position_tumb(_("Radar emission - Combat/Training"),devices.RADAR, device_commands.MislModeActTrain,633)	
elements["PNT_435"] = default_axis(_("G-Suit Max/Min valve"),devices.UNCLASSIFIED, device_commands.GSuitMaxMin,634, 0.0, 0.1, true, false)
elements["PNT_436"] = default_2_position_tumb(_("Electric Bus Nr.1 - Cover"),devices.UNCLASSIFIED, device_commands.SinaNr1Cover,635)
elements["PNT_437"] = default_2_position_tumb(_("Electric Bus Nr.1"),devices.UNCLASSIFIED, device_commands.SinaNr1,636)	
elements["PNT_438"] = default_2_position_tumb(_("Electric Bus Nr.2"),devices.UNCLASSIFIED, device_commands.SinaNr2,637)	

elements["PNT_439"] = default_2_position_tumb(_("1.5 Mach Test Button - Cover"),devices.KONUS, device_commands.AirductTestCover,638)	
elements["PNT_440"] = default_button(_("1.5 Mach Test Button"),devices.KONUS, device_commands.AirductTest,639)	

elements["PNT_441"] = default_button(_("BU-45 Buster System Separation"),devices.UNCLASSIFIED, device_commands.BU45Buster,640)	
elements["PNT_151"] = default_button(_("SOD Control PBU-1"),devices.UNCLASSIFIED, device_commands.SODPBU1,642)	
elements["PNT_150"] = default_button(_("SOD Control PBU-2"),devices.UNCLASSIFIED, device_commands.SODPBU2,641)	
elements["PNT_442"] = default_button(_("Eject"),devices.UNCLASSIFIED, device_commands.EjectEjectEject,643)
elements["PNT_443"] = default_2_position_tumb(_("Ejection Seat Emergency Oxygen"),devices.UNCLASSIFIED, device_commands.EmerOxy,644)	
elements["PNT_444"] = default_2_position_tumb(_("UK-2M Mic Amplifier M/L"),devices.UNCLASSIFIED, device_commands.UK2MML,645)
elements["PNT_445"] = default_2_position_tumb(_("UK-2M Mic Amplifier GS/KM"),devices.UNCLASSIFIED, device_commands.UK2MGsKm,646)
elements["PNT_446"] = default_axis(_("Suit Ventilation"),devices.UNCLASSIFIED, device_commands.SuitVent,647, 0.0, 0.1, true, false)
elements["PNT_447"] = default_2_position_tumb(_("Harness Separation"),devices.UNCLASSIFIED, device_commands.Harness,648)
-- 649 already used for canopy vent system
elements["PNT_448"] = default_axis_limited(_("Harness Loose/Tight"),devices.UNCLASSIFIED, device_commands.HarnessLooseTight,650, 0.2, false, false, {0.0, 1.0})
elements["PNT_449"] = default_axis_limited(_("Throttle Fixation"),devices.UNCLASSIFIED, device_commands.RUDFixator,651, 0.2, false, false, {0.0, 1.0})

-- IAB PBK-3
elements["PNT_387"] = default_2_position_tumb(_("Emergency Jettison"),devices.NUKE_CONTROL, device_commands.IabAvarSbros,387)	
elements["PNT_387"].updatable = true										 
elements["PNT_388"] = default_2_position_tumb(_("Emergency Jettison Armed / Not Armed"),devices.NUKE_CONTROL, device_commands.IabAvarSbrosVzr,388)		
elements["PNT_388"].updatable = true
elements["PNT_389"] = default_2_position_tumb(_("Tactical Jettison"),devices.NUKE_CONTROL, device_commands.IabBoevojSbros,389)		
elements["PNT_389"].updatable = true
elements["PNT_390"] = default_2_position_tumb(_("Special AB / Missile-Rocket-Bombs-Cannon"),devices.NUKE_CONTROL, device_commands.IabSpecAb,390)		
elements["PNT_390"].updatable = true
elements["PNT_391"] = default_2_position_tumb(_("Brake Chute"),devices.NUKE_CONTROL, device_commands.IabTormoz,391)		
elements["PNT_391"].updatable = true
elements["PNT_392"] = default_2_position_tumb(_("Detonation Air / Ground"),devices.NUKE_CONTROL, device_commands.IabVozduh,392)		
elements["PNT_392"].updatable = true

-- SPS 141-100
elements["PNT_393"] = default_2_position_tumb(_("On / Off"),devices.SPS_CONTROL, device_commands.SPSOnOff,393)
elements["PNT_393"].updatable = true
elements["PNT_394"] = default_2_position_tumb(_("Transmit / Receive"),devices.SPS_CONTROL, device_commands.SPSTransmit,394)	
elements["PNT_394"].updatable = true
elements["PNT_395"] = default_2_position_tumb(_("Program I / II"),devices.SPS_CONTROL, device_commands.SPSProgram,395)	
elements["PNT_395"].updatable = true
elements["PNT_396"] = default_2_position_tumb(_("Continuous / Impulse" ),devices.SPS_CONTROL, device_commands.SPSContinous,396)	
elements["PNT_396"].updatable = true
elements["PNT_397"] = default_button(_("Test"),devices.SPS_CONTROL, device_commands.SPStest,397)	
elements["PNT_397"].updatable = true
elements["PNT_398"] = default_2_position_tumb(_("Dispenser Auto / Manual"),devices.SPS_CONTROL, device_commands.SPSDispense,398)
elements["PNT_398"].updatable = true
elements["PNT_399"] = multiposition_switch_limited(_("Off / Parallel / Full"),devices.SPS_CONTROL, device_commands.SPSOffParalFull,399,3, 0.5, true)	
elements["PNT_399"].updatable = true
elements["PNT_400"] = default_2_position_tumb(_("Manual Activation button - Cover"),devices.SPS_CONTROL, device_commands.SPSCover,400)
elements["PNT_400"].updatable = true
elements["PNT_401"] = default_button(_("Manual Activation button"),devices.SPS_CONTROL, device_commands.SPSPush,401)
elements["PNT_401"].updatable = true

---[[
-- GUV Control Box -/N/ GUV is useless, it's mostly anti-infantry weapon
elements["PNT_420"] = default_2_position_tumb(_("On / Off"),devices.WEAPON_CONTROL, device_commands.GUVOnOff,420) --/N/ returns 'Wrong connector name', check cockpit
elements["PNT_420"].updatable = true	
elements["PNT_421"] = default_2_position_tumb(_("MAIN GUN / UPK Guns"),devices.WEAPON_CONTROL, device_commands.GUVPodMain,421)	--/N/ returns 'Wrong connector name', check cockpit
elements["PNT_421"].updatable = true	
elements["PNT_422"] = default_button(_("LOAD 1"),devices.WEAPON_CONTROL, device_commands.GUVArm1,422,3,0.5,true) --/N/ returns 'Wrong connector name', check cockpit
elements["PNT_422"].updatable = true	
elements["PNT_425"] = default_button(_("LOAD 2"),devices.WEAPON_CONTROL, device_commands.GUVArm2,425)	--/N/ returns 'Wrong connector name', check cockpit
elements["PNT_425"].updatable = true	
elements["PNT_424"] = default_button(_("LOAD 3"),devices.WEAPON_CONTROL, device_commands.GUVArm3,424) --/N/ returns 'Wrong connector name', check cockpit
elements["PNT_424"].updatable = true	
--]]

for i,o in pairs(elements) do
	if o.class[1] == class_type.TUMB or 
	 (o.class[2] and o.class[2] == class_type.TUMB) or
	 (o.class[3] and o.class[3] == class_type.TUMB) then
	 o.updatable = true
	 o.use_OBB = true
	end
end