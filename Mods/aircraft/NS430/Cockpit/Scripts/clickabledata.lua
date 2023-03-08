dofile(LockOn_Options.script_path .. "command_defs.lua")
dofile(LockOn_Options.script_path .. "devices.lua")
dofile(LockOn_Options.script_path .. "sounds.lua")

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

elements = {}

elements["PWR-VOL_PUSH-SQ"] = -- knob C
{			class		=	{class_type.BTN, class_type.LEV},
			hint		=	_("COM Power/Volume"),
			device		=	devices.GNS430,
			action		=	{device_commands.Button_1, device_commands.Button_2},
			stop_action =  	{device_commands.Button_30, 0},
			arg			=	{1, 0},
			arg_value	= 	{1, 0.5},
			arg_lim		= 	{{0,1}, {0,1}},
			gain 		= 	{0, 0.1},
			relative	= 	{false, false},
			updatable 	= 	{true, false},
			use_OBB 	= 	{true, false},
			use_release_message = 	{true, false},
			cycle     	= 	false,
			side		= {{BOX_SIDE_Y_bottom},	{BOX_SIDE_X_top, BOX_SIDE_X_bottom, BOX_SIDE_Z_top, BOX_SIDE_Z_bottom}},
			turn_box	= {180,0,90},
	        sound       = {{SOUND_BUTTON_ON, SOUND_BUTTON_OFF}}, knob
}



elements["VOL_PUSH-ID"] =  -- knob V
{			class		=	{class_type.BTN, class_type.LEV},
			hint		=	_("VLOC volume"),
			device		=	devices.GNS430,
			action		=	{device_commands.Button_4, device_commands.Button_5},
			stop_action 	=   	{device_commands.Button_31, 0},
			arg		=	{3, 2},
			arg_value	= 	{1, 0.5},
			arg_lim		= 	{{0, 1}, {0,1}},
			gain 		= 	{0, 0.1},
			relative	= 	{false, false},
			updatable 	= 	{true, false}, 
			use_OBB 	= 	{true, false},
			use_release_message = 	{true, false},
			cycle     	= 	false,
			side		= {{BOX_SIDE_Y_bottom},	{BOX_SIDE_X_top, BOX_SIDE_X_bottom, BOX_SIDE_Z_top, BOX_SIDE_Z_bottom}},
			turn_box	= {180,0,90},
			sound       = {{SOUND_BUTTON_ON, SOUND_BUTTON_OFF}},
}

elements["BIG_LEFT_BTN"]= {
			class 		= 	{class_type.LEV},
			hint  		= 	_("Big left knob"),
			device 		= 	devices.GNS430,
			action 		= 	{device_commands.Button_7},
			stop_action 	= 	{0},
			arg 	  	= 	{4},
			arg_value 	= 	{0.5}, 
			arg_lim   	= 	{{0,1}},
			animated        = 	{false},
			animation_speed = 	{0.4},
			gain		= 	{-0.1},
			relative   	= 	{true},
			updatable 	= 	true, 
			use_OBB 	= 	true,
			use_release_message = 	{false},
			cycle       	= 	false,
			side		= {{BOX_SIDE_X_top, BOX_SIDE_X_bottom, BOX_SIDE_Z_top, BOX_SIDE_Z_bottom}},
			turn_box	= {180,0,-90},
			sound       = {{ROTATION}},
}

elements["SMALL_LEFT_BTN"] = 
{			class		=	{class_type.BTN, class_type.LEV},
			hint		=	_("Small left knob"),
			device		=	devices.GNS430,
			action		=	{device_commands.Button_9, device_commands.Button_10},
			stop_action 	=   	{device_commands.Button_32, 0},
			arg		=	{5, 6},
			arg_value	= 	{1, 0.5},
			arg_lim		= 	{{0, 1}, {0,1}},
			gain 		= 	{0, 0.1},
			relative	= 	{false, true},
			updatable 	= 	true, 
			use_OBB 	= 	true,
			use_release_message = 	{true, false},
			cycle     	= 	false,
			side		= {{BOX_SIDE_Y_bottom},	{BOX_SIDE_X_top, BOX_SIDE_X_bottom, BOX_SIDE_Z_top, BOX_SIDE_Z_bottom}},
			turn_box	= {180,0,90},
			sound		= {{SOUND_BTN_PUSH_OFF, SOUND_BTN_PUSH_ON},{ROTATION}},
}

elements["C"] =
{			class 				= {class_type.BTN},
			hint  				= _("COM flip-flop"),
			device 				= devices.GNS430,
			action 				= {device_commands.Button_12},
			stop_action 		= {device_commands.Button_33},
			arg 				= {7},
			arg_value			= {1}, 
			arg_lim 			= {{0,1}},
			use_release_message = {true},
			side				= {{BOX_SIDE_Y_bottom}},
			turn_box			= {180,0,90},
			sound       		= {{SOUND_BUTTON_OFF, SOUND_BUTTON_ON}},
}

elements["V"] =
{			class 				= {class_type.BTN},
			hint  				= _("VLOC flip-flop"),
			device 				= devices.GNS430,
			action 				= {device_commands.Button_13},
			stop_action 		= {device_commands.Button_34},
			arg 				= {8},
			arg_value			= {1}, 
			arg_lim 			= {{0,1}},
			use_release_message = {true},
			side				= {{BOX_SIDE_Y_bottom}},
			turn_box			= {180,0,90},
			sound       		= {{SOUND_BUTTON_OFF, SOUND_BUTTON_ON}},
}

elements["CDI"] =
{			class 				= {class_type.BTN},
			hint  				= _("CDI"),
			device 				= devices.GNS430,
			action 				= {device_commands.Button_14},
			stop_action 		= {device_commands.Button_35},
			arg 				= {9},
			arg_value			= {1}, 
			arg_lim 			= {{0,1}},
			use_release_message = {true},
			side				= {{BOX_SIDE_Y_bottom}},
			turn_box			= {180,0,90},
	        sound               = {{SOUND_BUTTON_OFF, SOUND_BUTTON_ON}},
}

elements["OBS"] =
{			class 				= {class_type.BTN},
			hint  				= _("OBS"),
			device 				= devices.GNS430,
			action 				= {device_commands.Button_15},
			stop_action 		= {device_commands.Button_36},
			arg 				= {10},
			arg_value			= {1}, 
			arg_lim 			= {{0,1}},
			use_release_message = {true},
			side				= {{BOX_SIDE_Y_bottom}},
			turn_box			= {180,0,90},
			sound       		= {{SOUND_BUTTON_OFF, SOUND_BUTTON_ON}},
}

elements["MSG"] =
{			class 				= {class_type.BTN},
			hint  				= _("MSG"),
			device 				= devices.GNS430,
			action 				= {device_commands.Button_16},
			stop_action 		= {device_commands.Button_37},
			arg 				= {11},
			arg_value			= {1}, 
			arg_lim 			= {{0,1}},
			use_release_message = {true},
			side				= {{BOX_SIDE_Y_bottom}},
			turn_box			= {180,0,90},
			sound      			= {{SOUND_BUTTON_OFF, SOUND_BUTTON_ON}},
}

elements["FPL"] =
{			class 				= {class_type.BTN},
			hint  				= _("FPL"),
			device 				= devices.GNS430,
			action 				= {device_commands.Button_17},
			stop_action 		= {device_commands.Button_38},
			arg 				= {12},
			arg_value			= {1}, 
			arg_lim 			= {{0,1}},
			use_release_message = {true},
			side				= {{BOX_SIDE_Y_bottom}},
			turn_box			= {180,0,90},
			sound       		= {{SOUND_BUTTON_OFF, SOUND_BUTTON_ON}},
}

elements["PROC"] =
{			class 				= {class_type.BTN},
			hint  				= _("PROC"),
			device 				= devices.GNS430,
			action 				= {device_commands.Button_18},
			stop_action 		= {device_commands.Button_39},
			arg 				= {13},
			arg_value			= {1}, 
			arg_lim 			= {{0,1}},
			use_release_message = {true},
			side				= {{BOX_SIDE_Y_bottom}},
			turn_box			= {180,0,90},
			sound       		= {{SOUND_BUTTON_OFF, SOUND_BUTTON_ON}},
}

elements["RNG_UP"] =
{			class 				= {class_type.BTN},
			hint  				= _("RNG-UP"),
			device 				= devices.GNS430,
			action 				= {device_commands.Button_19},
			stop_action 		= {device_commands.Button_40},
			arg 				= {14},
			arg_value			= {-1}, 
			arg_lim 			= {{-1,0}},
			use_release_message = {true},
			side				= {{BOX_SIDE_Y_bottom}},
			turn_box			= {180,0,90},
			sound       		= {{SOUND_BUTTON_ON, SOUND_BUTTON_OFF}},
}

elements["RNG_DOWN"] =
{			class 				= {class_type.BTN},
			hint  				= _("RNG-DOWN"),
			device 				= devices.GNS430,
			action 				= {device_commands.Button_20},
			stop_action 		= {device_commands.Button_41},
			arg 				= {14},
			arg_value			= {1}, 
			arg_lim 			= {{0,1}},
			use_release_message = {true},
			side				= {{BOX_SIDE_Y_bottom}},
			turn_box			= {180,0,90},
			sound       		= {{SOUND_BUTTON_OFF, SOUND_BUTTON_ON}},
}

elements["DIRECT-TO"] =
{			class 				= {class_type.BTN},
			hint  				= _("DIRECT-TO"),
			device 				= devices.GNS430,
			action 				= {device_commands.Button_21},
			stop_action 		= {device_commands.Button_42},
			arg 				= {15},
			arg_value			= {1}, 
			arg_lim 			= {{0,1}},
			use_release_message = {true},
			side				= {{BOX_SIDE_Y_bottom}},
			turn_box			= {180,0,90},
			sound       		= {{SOUND_BUTTON_OFF, SOUND_BUTTON_ON}},
}

elements["MENU"] =
{			class 				= {class_type.BTN},
			hint  				= _("MENU"),
			device 				= devices.GNS430,
			action 				= {device_commands.Button_22},
			stop_action 		= {device_commands.Button_43},
			arg 				= {16},
			arg_value			= {1}, 
			arg_lim 			= {{0,1}},
			use_release_message = {true},
			side				= {{BOX_SIDE_Y_bottom}},
			turn_box			= {180,0,90},
			sound       		= {{SOUND_BUTTON_OFF, SOUND_BUTTON_ON}},
}

elements["CLR"] =
{			class 				= {class_type.BTN},
			hint  				= _("CLR"),
			device 				= devices.GNS430,
			action 				= {device_commands.Button_23},
			stop_action 		= {device_commands.Button_44},
			arg 				= {17},
			arg_value			= {1}, 
			arg_lim 			= {{0,1}},
			use_release_message = {true},
			side				= {{BOX_SIDE_Y_bottom}},
			turn_box			= {180,0,90},
			sound       		= {{SOUND_BUTTON_OFF, SOUND_BUTTON_ON}},
}

elements["ENT"] =
{			class 				= {class_type.BTN},
			hint  				= _("ENT"),
			device 				= devices.GNS430,
			action 				= {device_commands.Button_24},
			stop_action 		= {device_commands.Button_45},
			arg 				= {18},
			arg_value			= {1}, 
			arg_lim 			= {{0,1}},
			use_release_message = {true},
			side				= {{BOX_SIDE_Y_bottom}},
			turn_box			= {180,0,90},
			sound       		= {{SOUND_BUTTON_OFF, SOUND_BUTTON_ON}},
}

elements["BIG_RIGHT_BTN"]= {
			class 		= {class_type.LEV},
			hint  		= _("Big right knob"),
			device 		= devices.GNS430,
			action 		= {device_commands.Button_25},
			stop_action 	= {0},
			arg 	  	= {19},
			arg_value 	= {0.5}, 
			arg_lim   	= {{0,1}},
			animated        = {false},
			animation_speed = {0.4},
			updatable 	= true, 
			use_OBB 	= true,
			gain		= {-0.1},
			relative    	= {true},
			use_release_message = {false},
			cycle       = false,
			side		= {{BOX_SIDE_X_top, BOX_SIDE_X_bottom, BOX_SIDE_Z_top, BOX_SIDE_Z_bottom}},
			turn_box	= {180,0,-90},
			sound       = {{ROTATION}},
}

elements["SMALL_RIGHT_BTN"] = 
{			class		=	{class_type.BTN, class_type.LEV},
			hint		=	_("Small right knob"),
			device		=	devices.GNS430,
			action		=	{device_commands.Button_27, device_commands.Button_28},
			stop_action 	=   	{device_commands.Button_46, 0},
			arg		=	{20, 21},
			arg_value	= 	{1, 0.5},
			arg_lim		= 	{{0, 1}, {0,1}},
			animated        = 	{false,false},
			animation_speed = 	{0, 0.4},
			gain 		= 	{0, 0.1},
			relative	= 	{false, true},
			updatable 	= 	true, 
			use_OBB 	= 	true,
			use_release_message = {true, false},
			cycle     	= false,
			side		= {{BOX_SIDE_Y_bottom},	{BOX_SIDE_X_top, BOX_SIDE_X_bottom, BOX_SIDE_Z_top, BOX_SIDE_Z_bottom}},
			turn_box	= {180,0,90},
			sound		= {{SOUND_BTN_PUSH_OFF, SOUND_BTN_PUSH_ON},{ROTATION}},
}
