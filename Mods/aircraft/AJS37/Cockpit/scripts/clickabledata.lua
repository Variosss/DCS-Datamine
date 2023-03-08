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
use_pointer_name			   = true

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
				use_release_message = {true},
				sound = {{SOUND_BUTTON_DOWN},{SOUND_BUTTON_DOWN_DONE}}
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
---- Flipswitches ---------

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
				sound = {{SOUND_FLIPSWITCH_01_UP},{SOUND_FLIPSWITCH_01_DN}}
			}
end

function default_2_position_tumb_altsound01(hint_, device_, command_, arg_)
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
				sound = {{SOUND_FLIPSWITCH_01_DN},{SOUND_FLIPSWITCH_01_UP}}
			}
end

function default_2_position_tumb_flipcover(hint_, device_, command_, arg_)
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

				animated	= {true, true, false},
				animation_speed = {2, 2},

				sound = {{SOUND_FLIPCOVER},{SOUND_FLIPCOVER}}
			}
end

function default_2_position_tumb_buttonsound(hint_, device_, command_, arg_)
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
				sound = {{SOUND_BUTTON_FULL},{SOUND_FLIPSWITCH_01_UP}}
			}
end
---- Flipswitches ---------

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
				cycle       = cycled,
				sound = {{SOUND_FLIPSWITCH_01_UP},{SOUND_FLIPSWITCH_01_UP}}
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
				use_release_message = {true},
				sound = {{SOUND_FLIPSWITCH_01_UP},{SOUND_FLIPSWITCH_01_UP}}
			}
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

function default_axis_limited(hint_,device_,command_,arg_, default_, gain_, updatable_, relative_, cycle_, arg_lim_)

	local default = default_ or 0.5
	local arg_lim = arg_lim_ or {0,1}
	local gain = gain_ or 0.1
	local updatable = updatable_ or false
	local relative = relative_ or false


	return  {
				class 		= {class_type.LEV},
				hint  		= hint_,
				device 		= device_,
				action 		= {command_},
				arg 	  	= {arg_},
				arg_value 	= {default}, 
				arg_lim   	= {arg_lim},
				updatable 	= updatable, 
				use_OBB 	= false,
				gain		= {gain},
				relative    = {relative},
				cycle 	 	= cycle_ or false
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
				use_OBB 	= true,
				sound = {{SOUND_VALJARE_01},{SOUND_FLIPSWITCH_01_UP}}
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
				sound = {{SOUND_VALJARE_01},{SOUND_FLIPSWITCH_01_UP}}
			}
end

function multiposition_switch_limited_metallic(hint_,device_,command_,arg_,count_,delta_,inversed_,min_)
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
				sound = {{SOUND_VALJARE_02},{SOUND_VALJARE_02}}
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

elements = {}

--SWITCHOFF elements["POINTER"] = default_2_position_tumb(LOCALIZE("Test Command"),devices.TEST, device_commands.Button_1,444) -- 44 arg number

for i,o in pairs(elements) do
	if  o.class[1] == class_type.TUMB or 
	   (o.class[2]  and o.class[2] == class_type.TUMB) or
	   (o.class[3]  and o.class[3] == class_type.TUMB)  then
	   o.updatable = true
	   o.use_OBB   = true
	end
end

elements = {}

-- Cockpit Pointers 

-- Mirrors
elements["PNT_MIRROR_TOGGLE"] = default_2_position_tumb(_("Toggle Mirrors"),0, 1625,nil)
elements["PNT_MIRROR_TOGGLE_LEFT"] = default_2_position_tumb(_("Toggle Mirrors"),0, 1625,nil)
elements["PNT_MIRROR_TOGGLE_RIGHT"] = default_2_position_tumb(_("Toggle Mirrors"),0, 1625,nil)

--Gear Handle
elements["PNT_12"]	= default_animated_lever(_("Gear Handle") , devices.FLIGHTDATAUNIT, 3719, 12, 1.8)
elements["PNT_12"].sound = {{SOUND_GEAR_HANDLE},{SOUND_GEAR_HANDLE}}


elements["Revhd-PTR"] = default_animated_lever(_("Reverser Handle") , devices.REVERSAL, device_commands.Button_1, 20, 2.5)
elements["Revhd-PTR"].sound = {{SOUND_EJECTION_ARM},{SOUND_EJECTION_ARM}}

elements["SPAK-PTR"] = default_2_position_tumb(_("SPAK"),devices.FLIGHTDATAUNIT,3301,401)
elements["ATT-PTR"]	= default_2_position_tumb(_("Attitude Hold"),devices.FLIGHTDATAUNIT,3302,402)
elements["HOJD-PTR"] = default_2_position_tumb(_("Altitude Hold"),devices.FLIGHTDATAUNIT,3303,403)
elements["PNT_464"]	= default_button(_("AFK 15 Deg Mode") , devices.FLIGHTDATAUNIT, 3402, -666)

elements["PNT_2003"]	= default_button(_("Roll Trim Reset / Centre") , devices.FLIGHTDATAUNIT, 3305, 2003)

elements["PNT_213"]	= default_2_position_tumb(_("Doppler Land/Sea Mode") , devices.DOPPLER, 3001, 213)


-- Datapanel rotary selector
elements["Datarot-PTR"] = multiposition_switch_limited(_("Datapanel Selector"), devices.NAVIGATIONPANEL, 3009, 200, 7, 0.1,false,0) 

elements["DatapanelINUT-PTR"] = default_2_position_tumb(_("IN/OUT Switch"),devices.NAVIGATIONPANEL, 3008,201)
elements["Datapanel00-PTR"] = default_button(_("Datapanel Key 0"), devices.NAVIGATION, 3020, 290)
elements["Datapanel01-PTR"] = default_button(_("Datapanel Key 1"), devices.NAVIGATION, 3021, 291)
elements["Datapanel02-PTR"] = default_button(_("Datapanel Key 2"), devices.NAVIGATION, 3022, 292)
elements["Datapanel03-PTR"] = default_button(_("Datapanel Key 3"), devices.NAVIGATION, 3023, 293)
elements["Datapanel04-PTR"] = default_button(_("Datapanel Key 4"), devices.NAVIGATION, 3024, 294)
elements["Datapanel05-PTR"] = default_button(_("Datapanel Key 5"), devices.NAVIGATION, 3025, 295)
elements["Datapanel06-PTR"] = default_button(_("Datapanel Key 6"), devices.NAVIGATION, 3026, 296)
elements["Datapanel07-PTR"] = default_button(_("Datapanel Key 7"), devices.NAVIGATION, 3027, 297)
elements["Datapanel08-PTR"] = default_button(_("Datapanel Key 8"), devices.NAVIGATION, 3028, 298)
elements["Datapanel09-PTR"] = default_button(_("Datapanel Key 9"), devices.NAVIGATION, 3029, 299)
elements["NavselB1-PTR"] = default_button(_("Navigation Selector Button B1"), devices.NAVIGATION, 3011, 271)
elements["NavselB2-PTR"] = default_button(_("Navigation Selector Button B2"), devices.NAVIGATION, 3012, 272)
elements["NavselB3-PTR"] = default_button(_("Navigation Selector Button B3"), devices.NAVIGATION, 3013, 273)
elements["NavselB4-PTR"] = default_button(_("Navigation Selector Button B4"), devices.NAVIGATION, 3014, 274)
elements["NavselB5-PTR"] = default_button(_("Navigation Selector Button B5"), devices.NAVIGATION, 3015, 275)
elements["NavselB6-PTR"] = default_button(_("Navigation Selector Button B6"), devices.NAVIGATION, 3016, 276)
elements["NavselB7-PTR"] = default_button(_("Navigation Selector Button B7"), devices.NAVIGATION, 3017, 277)
elements["NavselB8-PTR"] = default_button(_("Navigation Selector Button B8"), devices.NAVIGATION, 3018, 278)
elements["NavselB9-PTR"] = default_button(_("Navigation Selector Button B9"), devices.NAVIGATION, 3019, 279)
elements["NavselBX-PTR"] = default_button(_("Navigation Selector Button BX"), devices.NAVIGATION, 3010, 280)
elements["NavselLS-PTR"] = default_button(_("Navigation Selector Button LS"), devices.NAVIGATION, 3009, 270)
elements["NavselLMAL-PTR"] = default_button(_("Navigation Selector Button L MÅL"), devices.NAVIGATION, 3008, 281)
elements["TILSSLCT-PTR"] = multiposition_switch_limited(_("TILS Channel Selection"), devices.FLIGHTDATAUNIT, 3512, 282, 11, 0.1, false, 0)
elements["TILSSLCT-PTR"].sound = {{SOUND_VALJARE_03},{SOUND_VALJARE_03}}
elements["TILSmodeswitch-PTR"] = default_2_position_tumb(_("TILS Channel Layer Selection"), devices.FLIGHTDATAUNIT, 3511, 285)

elements["warnpanelcheck-PTR"] = default_button(_("Warning Panel Light Test"), devices.ERRORPANEL, 3002, 344)
elements["Kontroll-PTR"] = default_button(_("Indicator System Test"), devices.ERRORPANEL, 3004, 315)
elements["PNT_175"] = default_button(_("Max G Reset"), devices.FLIGHTDATAUNIT, 3722, -666)


elements["Antikljus-PTR"] = default_2_position_tumb(_("Anti Collision Lights"), devices.LIGHTS, 3001,250)
elements["Lanternljus-PTR"] = default_3_position_tumb(_("Navigation Lights"), devices.LIGHTS, 3002,251)
elements["Formljus-PTR"] = default_2_position_tumb(_("Formation Lights"), devices.LIGHTS, 3003,252)
elements["Ledljus-PTR"] = default_2_position_tumb(_("Position Lights"), devices.LIGHTS, 3004,253)
elements["PNT_254"] = multiposition_switch_limited(_("Position Lights Brightness"), devices.LIGHTS, 3005, 254, 3, 0.1,false,0) 

elements["PNT_3554"] = default_3_position_tumb(_("Taxi/Landing Lights"), devices.LIGHTS, 3009,3554)
elements["PNT_3555"] = default_2_position_tumb(_("Emergency Lights"), devices.LIGHTS, 3010,3555)

elements["PNT_392"] = default_axis_limited(_("Panel Lights"), devices.LIGHTS, 3006, 392, 0, 0.1, false, false, nil)
elements["PNT_393"] = default_axis_limited(_("Flood Lights"), devices.LIGHTS, 3007, 393, 0, 0.1, false, false, nil)
elements["PNT_394"] = default_axis_limited(_("Instrument Lights"), devices.LIGHTS, 3008, 394, 0, 0.1)


-- Engine panel
elements["StartS-PTR"] = default_2_position_tumb(_("Start System"), devices.ENGINEPANEL, 3001,206)

elements["LTKran-PTR"] = default_2_position_tumb_altsound01(_("Low-pressure Fuel Valve"), devices.ENGINEPANEL, 3002,204)

elements["HTK-PTR"] = default_2_position_tumb(_("High-pressure Fuel Valve"), devices.ENGINEPANEL, 3004,202)
elements["HTK-PTR"].sound = {{},{}}

elements["TandS-PTR"] = default_2_position_tumb_altsound01(_("Ignition System"), devices.ENGINEPANEL, 3003,205)
elements["Deice-PTR"] = default_2_position_tumb(_("Engine De-Ice"), devices.ENGINEPANEL, 3099,310)
elements["Backupgen-PTR"] = default_2_position_tumb(_("Backup Generator"), devices.ELECTRICSYSTEM, 3003,312)
elements["Seatsafe-PTR"] = default_animated_lever(_("Ejection Seat Arm"), devices.FLIGHTDATAUNIT, 3405,21,1.5)
elements["Seatsafe-PTR"].sound = {{SOUND_EJECTION_ARM},{SOUND_EJECTION_DISARM}}
elements["PNT_SEAT_ADJ"] = default_2_way_spring_switch(_("Seat Height Adjustment"), devices.FLIGHTDATAUNIT, 3404, 212)


elements["Aterstart-PTR"] = default_button(_("Restart"), devices.ENGINEPANEL, 3401,208)
elements["HuvudS-PTR"] = default_2_position_tumb(_("Main Electric Power"), devices.ELECTRICSYSTEM, 3001,203)

elements["Gen-PTR"] = default_2_position_tumb(_("Generator"), devices.ELECTRICSYSTEM, 3002,207)
elements["Skede-PTR"] = multiposition_switch_limited(_("Master Mode Selector"), devices.FLIGHTDATAUNIT, 3107, 209, 7, 0.1666666667,false,0)

elements["MasterC-PTR"]	= default_button(_("Master Caution Reset"),devices.ERRORPANEL,3001,446)
elements["SlavSI-PTR"] = default_2_position_tumb_altsound01(_("Slav SI"), devices.FLIGHTDATAUNIT, 3201, 323)
elements["HojdSI-PTR"] = default_2_position_tumb(_("HÖJD CISI"), devices.FLIGHTDATAUNIT, 3097, 324)

elements["SnabbresM-PTR"] = default_button(_("Snabbresning"), devices.FLIGHTDATAUNIT, 3091, 0)
elements["PNT_123"] = default_button(_("Backup ADI Cage"), devices.FLIGHTDATAUNIT, 3720, -666)
elements["PNT_126"] = default_axis_limited(_("Backup Altimeter Setting"),devices.FLIGHTDATAUNIT, 3721, 0, 0.001, 0.1, false, true)

elements["Tippvax-PTR"] = default_2_position_tumb(_("Pitch Gear Automatic/Landing"), devices.FLIGHTDATAUNIT, 3210, 311)

-- Countermeasure panel
elements["U22sel1-PTR"] = multiposition_switch_limited_metallic(_("Jammer Operation Mode Selector"), devices.COUNTERMEASURE, 3024, 317, 5, 0.1,false,0)
elements["U22sel2-PTR"] = multiposition_switch_limited_metallic(_("Jammer Band Selector"), devices.COUNTERMEASURE, 3025, 318, 5, 0.1,false,0) 
elements["KBsel1-PTR"] = multiposition_switch_limited_metallic(_("Countermeasure Operation Mode Selector"), devices.COUNTERMEASURE, 3026, 319, 5, 0.1,false,0) 
elements["KBsel2-PTR"] = multiposition_switch_limited_metallic(_("Countermeasure Streak Mode Selector"), devices.COUNTERMEASURE, 3027, 320, 2, 0.1,false,0) 
elements["App27-PTR"] = multiposition_switch_limited_metallic(_("Radarwarning Indication Selector"), devices.RWR, 3004, 321, 3, 0.1,false,0) 
elements["KBsel3-PTR"] = multiposition_switch_limited_metallic(_("Countermeasure Chaff/Flares Selector"), devices.COUNTERMEASURE, 3028, 322, 3, 0.1,false,0) 


-- Oxygen
elements["PNT_176"] = default_2_position_tumb(_("Oxygen Lever"), devices.FLIGHTDATAUNIT, 3718, 176)
elements["PNT_176"].sound={{SOUND_OXYGEN},{SOUND_OXYGEN}}

-- Canopy
elements["PNT_9"] = default_3_position_tumb(_("Canopy Open/Close"), devices.FLIGHTDATAUNIT, 3406, 9, false, false)
elements["PNT_9"].sound={{SOUND_CANOPY},{SOUND_CANOPY}}

--elements["PNT_9"].updatable = true
elements["PNT_210"]	= default_button(_("Canopy Jettison") , devices.FLIGHTDATAUNIT, 3407, 210)


elements["Manbreg-PTR"] = default_2_position_tumb(_("Manual Fuel Regulator"), devices.ENGINEPANEL, 3007,316)

elements["PNT_212"] = default_button(_("Roll Centering"), devices.FLIGHTDATAUNIT, 3305, 212)
elements["PNT_390"] = default_2_way_spring_switch(_("Emergency Roll Trim"), devices.FLIGHTDATAUNIT, 3716,390,true,true)
elements["PNT_389"] = default_2_way_spring_switch(_("Emergency Pitch Trim"), devices.FLIGHTDATAUNIT, 3717,389,false,false)
elements["PNT_388"] = default_2_way_spring_switch(_("Emergency Yaw Trim"), devices.FLIGHTDATAUNIT, 3918,388,true,true)

elements["Abfuelvalve-PTR"] = default_2_position_tumb_altsound01(_("Manual Afterburner Fuel Regulator"), devices.ENGINEPANEL, 3006,313)

elements["PNT_11"] = default_button(_("HUD Reflector Glass Position"), devices.FLIGHTDATAUNIT, 3401, 11, 1)
elements["PNT_11"].sound = {{SOUND_HUDTOGGLE},{SOUND_HUDTOGGLE}}

elements["PNT_180"] = default_axis_limited(_("HUD Brightness Knob"), devices.FLIGHTDATAUNIT, 3409, 9999, 1, 0.1, false, false, nil)
																			

elements["PNT_13"] = default_animated_lever(_("AFK Lever"), devices.ENGINEPANEL, 3304, 13, 3.0)
elements["PNT_13"].sound = {{SOUND_AFK_HANDLE},{SOUND_AFK_HANDLE}}

elements["PNT_464"] = default_button(_("AFK Mode 3"), devices.FLIGHTDATAUNIT, 3402, -666)

elements["PNT_22"] = default_animated_lever(_("Parking Brake"), devices.FLIGHTDATAUNIT, 3408,22, 4.5)
elements["PNT_22"].sound = {{SOUND_EJECTION_ARM},{SOUND_EJECTION_ARM}}

elements["PNT_AirspeedIndexer"] = default_axis_limited(_("Airspeed Indexer"),devices.FLIGHTDATAUNIT,3410,104, 0, 0.1,false,false)

--elements["PNT_171"] = multiposition_switch("Radio Setting Knob Inner Left",devices.FR22,3003,171,30,1,1)

elements["PNT_171"] = default_axis(_("Radio Manual Frequency Setting Knob Outer Left"),devices.FR22,3004,171, 0, 1,false,true)--default_3_position_tumb("Radio setting knob Inner left",devices.FR22,3003,171)
elements["PNT_172"] = default_axis(_("Radio Manual Frequency Setting Knob Inner Left"),devices.FR22,3003,172, 0, 1,false,true)--#hb_iw these being limited knobs would make the code much more simple, but would require refactor or a radio class
elements["PNT_173"] = default_axis(_("Radio Manual Frequency Setting Knob Outer Right"),devices.FR22,3006,173, 0, 1,false,true)
elements["PNT_174"] = default_axis(_("Radio Manual Frequency Setting Knob Inner Right"),devices.FR22,3005,174, 0, 1,false,true)
elements["PNT_170"] = default_2_position_tumb(_("Radio Manual Frequency Setting Modulation"), devices.FR22,3014,170)


elements["PNT_372"] = default_button(_("Flight 0"), devices.FR22,3210,372)
elements["PNT_373"] = default_button(_("Flight 1"), devices.FR22,3211,373)
elements["PNT_374"] = default_button(_("Flight 2"), devices.FR22,3212,374)
elements["PNT_375"] = default_button(_("Flight 3"), devices.FR22,3213,375)
elements["PNT_376"] = default_button(_("Flight 4"), devices.FR22,3214,376)
elements["PNT_377"] = default_button(_("Flight 5"), devices.FR22,3215,377)
elements["PNT_378"] = default_button(_("Flight 6"), devices.FR22,3216,378)
elements["PNT_379"] = default_button(_("Flight 7"), devices.FR22,3217,379)
elements["PNT_380"] = default_button(_("Flight 8"), devices.FR22,3218,380)
elements["PNT_381"] = default_button(_("Flight 9"), devices.FR22,3219,381)
elements["PNT_362"] = default_button(_("Channel H"), devices.FR22,3200,362)
elements["PNT_363"] = default_button(_("Special 1"), devices.FR22,3201,363)
elements["PNT_364"] = default_button(_("Special 2"), devices.FR22,3202,364)
elements["PNT_365"] = default_button(_("Special 3"), devices.FR22,3203,365)
elements["PNT_366"] = default_button(_("Minus"), devices.FR22,3204,366)
elements["PNT_367"] = default_button(_("Channel A/G"), devices.FR22,3205,367)
elements["PNT_368"] = default_button(_("Channel B"), devices.FR22,3206,368)
elements["PNT_369"] = default_button(_("Channel C/F"), devices.FR22,3207,369)
elements["PNT_370"] = default_button(_("Channel C2"), devices.FR22,3208,370)
elements["PNT_371"] = default_button(_("Channel D/E"), devices.FR22,3209,371)

--elements["PNT_386"] = multiposition_switch_limited(_("FR22 Mode selector"), devices.FR22, 3110, 386, 7, 0.1,false,0)
--elements["PNT_361"] = multiposition_switch_limited(_("Base selector"), devices.FR22, 3230, 361, 100, 1.1,false,0) -- 84 bases + every 6 is "ALLMÄN"
--elements["PNT_360"] = multiposition_switch_limited(_("Group selector"), devices.FR22, 3307, 360, 42, 1,false,0)

elements["PNT_386"] = default_3_position_tumb(_("FR24 Mode Selector"),devices.FR22,3110,-666,false,false)
elements["PNT_386"].sound = {{SOUND_VALJARE_02}, {SOUND_VALJARE_02}}
elements["PNT_2002"] = default_3_position_tumb(_("Base Selector"),devices.FR22,3230,-666,false,false)
elements["PNT_360"] = default_3_position_tumb(_("Group Selector"),devices.FR22,3307,-666,false,false)

--{down = 3011, value_down = 1.0, cockpit_device_id = devices.FR22, name = 'FR22 Push-to-talk', category = 'Radios'},
elements["PNT_382"]   = default_button(_("Ground Intercom"), devices.FR22,3011,382)

elements["PNT_385"] = default_axis_limited(_("Radio Volume"),devices.FR22, 3112, 385, 0.01, 0.1, false, false)

-- Weapons system

-- trigger safety bracket
elements["Mastersafe-PTR"] = default_2_position_tumb(_("Trigger Safety Bracket"), devices.WEAPON_SYSTEM, 3300, 8)

elements["WepEmRCvr-PTR"] = default_2_position_tumb_flipcover(_("Weapon Emergency Release Cover"), devices.WEAPON_SYSTEM, 3302, 260)
	elements["WepEmR-PTR"] = default_button(_("Weapon Emergency Release Button"), devices.WEAPON_SYSTEM, 3303, 261)
elements["XTCVR-PTR"] = default_2_position_tumb_flipcover(_("External Tank Release Cover"), devices.WEAPON_SYSTEM, 3402, 262)
elements["XTREL-PTR"] = default_button(_("External Tank Release Button"), devices.WEAPON_SYSTEM, 3320, 263)

-- Bypass firing circuit
elements["GroundSafetyCvr-PTR"] = default_2_position_tumb_flipcover(_("Bypass Firing Circuit Cover"), devices.WEAPON_SYSTEM, 3308, 309)
elements["PNT_397"] = default_button(_("Bypass Firing Circuit Button"), devices.WEAPON_SYSTEM, 3309, 397)

-- Weapon selector knob -- J/A Valjare -- 264
elements["WepSEL-PTR"] = multiposition_switch_limited(_("Weapon Selector Knob - J/A Valjare"), devices.WEAPON_SYSTEM, 3304, 264, 6, 0.1, false, 0) -- HACK / 2.0
elements["WepSEL-PTR"].sound = {{SOUND_VALJARE_03},{SOUND_VALJARE_03}}

-- Weapon interval selector mode knob -- Siktningvaljare
elements["WepINT-PTR"] = multiposition_switch_limited(_("Weapon Interval Selector Mode Knob - Siktningvaljare"), devices.WEAPON_SYSTEM, 3305, 265, 11, 0.1, true, 0)
elements["WepINT-PTR"].sound = {{SOUND_VALJARE_03},{SOUND_VALJARE_03}}

-- Weapon release mode switch -- Fallsattmkopplare
elements["WepRelmode-PTR"] = default_2_position_tumb(_("Weapon Release Mode Switch - Fallsattomkopplare"), devices.WEAPON_SYSTEM, 3306, 266)
-- Rb04 release mode switch -- MALVAL/PREP
elements["Rb04tgt-PTR"] = default_2_position_tumb(_("RB-04/RB-15/BK Release Mode Switch - MALVAL/PREP"), devices.WEAPON_SYSTEM, 3307, 267)

-- IFF panel
elements["PNT_308"] = default_2_position_tumb(_("IFF Power"), devices.ENGINEPANEL, 3000,308)
elements["PNT_308"] = multiposition_switch_limited(_("IFF Code"), devices.ENGINEPANEL, 3000, 309, 11, 0.1,false,0)

-- CB Circuit breakers
elements["PNT_302"] = default_2_position_tumb(_("CB Autopilot SA"), devices.ENGINEPANEL, 3905,302)
elements["PNT_303"] = default_2_position_tumb(_("CB High Alpha Warning"), devices.ENGINEPANEL, 3906,303)
elements["PNT_304"] = default_2_position_tumb(_("CB Trim System"), devices.ENGINEPANEL, 3907,304)
elements["PNT_305"] = default_2_position_tumb(_("CB CI/SI"), devices.ENGINEPANEL, 3908,305)
elements["PNT_306"] = default_2_position_tumb(_("CB Ejection System"), devices.ENGINEPANEL, 3909,306)
elements["PNT_307"] = default_2_position_tumb(_("CB CB Engine"), devices.ENGINEPANEL, 3910, 307)
--Radar

elements["PNT_212"] = multiposition_switch_limited(_("Anti Jamming Mode (AS) Selector"), devices.RADAR, 3208, 217, 8, 0.1,false,0) 
elements["PNT_214"] = default_2_position_tumb_altsound01(_("Lin/Log Radar Gain Switch"), devices.RADAR, 3209, 214)
elements["PNT_218"] = default_2_position_tumb(_("Pulse Normal/Short Switch"), devices.RADAR, 3328, 218)
elements["PNT_216"] = default_2_position_tumb_altsound01(_("Passive Recce On/Off Switch"), devices.RADAR, 3350, 216)
elements["PNT_391"] = default_axis_limited(_("Radar Brightness"),devices.RADAR, 3923, 391, 0.001, 0.1, false, false)
elements["PNT_RADAR_MKR"] = default_axis_limited(_("Radar Gain (MKR)"),devices.RADAR, 3325, 152, 0.6, 0.1, false, false)
elements["PNT_RADAR_MEM"] = default_button(_("Radar Memory Mode"), devices.RADAR, 3212, 153)
elements["PNT_215"] = default_3_position_tumb(_("Radar Mode Selector"), devices.NAVIGATIONPANEL, 3002, 215)
elements["PNT_RADARRANGE"] = default_2_way_spring_switch(_("Radar Range Selector"), devices.RADAR, 3323, 156)
elements["PNT_RADAR_SCAN"] = default_axis_limited(_("Radar Antenna Elevation"),devices.RADAR, 3641, 154, 0.0, 0.1, false, false, nil, {-1, 1})
elements["PNT_RADAR_TERRAVOIDANCE"] = default_button(_("Radar Terrain Avoidance Mode"), devices.RADAR, 3213, 155)
-- Cabin air


-- Var
elements["PNT_286"] = default_axis_limited(_("Windscreen De-Ice"),devices.ENGINEPANEL, 3912, 286, 0.001, 0.1, false, false) --inop in code
elements["PNT_675"] = default_axis_limited(_("Maintenance Testing Mode"),devices.ENGINEPANEL, 3913, 675, 0.001, 0.1, false, false) --inop in code, should be multi-pos?
elements["PNT_1006"] = default_2_position_tumb_altsound01(_("Radar/EL Maintenance Test"), devices.RADAR, 3914, 1006)

elements["PNT_EP13_RIGHT"] = default_axis_limited(_("EP-13 Brightness"), devices.WEAPON_SYSTEM, 3318, 6901, 0.1)
elements["PNT_EP13_LEFT"] = default_axis_limited(_("EP-13 Contrast"), devices.WEAPON_SYSTEM, 3319, 6902, 0.1)
elements["PNT_EP13_RIGHT"].default = 0.5
elements["PNT_EP13_LEFT"].default = 0.5
elements["PNT_RadarFilter"] = default_axis_limited(_("CI filter"), devices.RADAR, 3801, 6905, 0.5, 0.2, false, false, nil, {-1,1})

--elements["PNT_1201"] = default_axis_limited(_("Magnetic Declination Adjustment"),devices.ENGINEPANEL, 3915, 1201, 0.001, false, false, 1)

elements["PNT_1200"] = default_2_position_tumb_flipcover(_("Magnetic Declination Cover"), devices.FLIGHTDATAUNIT, 3742, 1200)

elements["PNT_396"] = default_axis_limited(_("Drysuit Ventilation Adjustment"),devices.ENGINEPANEL, 3917, 396, 0.5, 0.1, false, false) --inop in code
elements["PNT_395"] = default_2_position_tumb(_("Ignition Coils"), devices.ENGINEPANEL, 3918, 395)

elements["PNT_DME_TILL_FRAN"] = default_2_position_tumb(_("DME Selector"), devices.ENGINEPANEL, 3919, 1206)

elements["PNT_1203"] = default_2_position_tumb(_("IFF/Transponder Power"), devices.ENGINEPANEL, 3920, 1203)
elements["PNT_1204"] = default_2_position_tumb(_("IFF Channel Selector"), devices.ENGINEPANEL, 3921, 1204)

elements["PNT_1205"]   = default_button(_("IFF Identification"), devices.RADAR, 3922, 1205)

elements["RHMtill-PTR"] = default_2_position_tumb_altsound01(_("Radar Altimeter Power"), devices.RADARALT, 3002, 283)

elements["PNT_384"] = default_3_position_tumb(_("Flight Recorder"), devices.ENGINEPANEL, 3924, 384, false, false)

elements["PNT_DATA"] = default_animated_lever(_("Insert/Remove Data Cartridge"), devices.ENGINEPANEL, 3925, 4200, 1.5)

elements["PNT_DATA"].sound = {{SOUND_DATACARTRIDGE}, {SOUND_DATACARTRIDGE}}

elements["RENSACVR-PTR"] = default_animated_lever(_("Rensa Button Cover"), devices.NAVIGATIONPANEL, 3101, 300, 2.0)
elements["RENSA-PTR"] = default_button(_("CK37 Rensa (Clear)"), devices.NAVIGATIONPANEL, 3001, 301)

--
elements["PNT_398"] = default_animated_lever(_("Cabin Air Valve"), devices.ENGINEPANEL, 3000, 398, 1.5)

elements["PNT_493"] = default_animated_lever(_("Autopilot Yaw Trim Cover"), devices.FLIGHTDATAUNIT, 3741, 493, 1.0)

--elements["PNT_211"] = default_axis_limited(_("Autopilot Yaw Trim"), devices.ENGINEPANEL, 3927, 211, 1.0)


elements["PNT_400"]   = default_button(_("Missile Select Button"), devices.ENGINEPANEL, 3000,400)
elements["PNT_399"] = default_axis_limited(_("Master Volume / Sidewinder Tone"),devices.RWR, 3006, 399, 1, 0.1, false, false)

elements["PNT_1201"] = default_axis_limited(_("Magnetic Declination Correction"),devices.FLIGHTDATAUNIT, 3724, 1201, 0.0, 0.2, false, false, nil, {-1,1})
elements["PNT_211"] = default_axis_limited(_("Autopilot Yaw Trim"),devices.FLIGHTDATAUNIT, 3732, 211, 0.0, 0.1, false, false, nil, {-1,1})

elements["PNT_CLOCK_RIGHT001"] = default_axis_limited(_("Clock Setting"),devices.FLIGHTDATAUNIT, 3801, 135, 1.0, 0.1, false, true)
elements["PNT_CLOCK_RIGHT"] = default_button(_("Stopwatch Start/Stop/Reset"),devices.FLIGHTDATAUNIT, 3802, 0)

-- Altimeter
elements["AltsetL-PTR"] =              {
    class = {class_type.TUMB, class_type.LEV},
    hint = _("Altimeter Knob"),
    device = devices.FLIGHTDATAUNIT,
    action = {3715, 3306},
    is_repeatable = {},
    arg = {119, 123}, --arg 2009 for rotation in the future
    arg_value = {0.0, 0.5},
    arg_lim = {{0, 1}, {0, 1}},
    relative = {false,true},
    gain = {1.0, 0.1},
    use_release_message = {true, false},
    use_OBB = true }


-- Load autogenerated clickables
dofile(LockOn_Options.script_path.."clickables.lua")
