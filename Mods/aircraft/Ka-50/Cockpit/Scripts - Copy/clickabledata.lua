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

direction                      = 1
cyclic_by_default              = true -- to cycle two-way thumblers or not by default
anim_speed_default			   = 16

--VR locals
local vr_side_LEV 	     = {{BOX_SIDE_X_top, BOX_SIDE_X_bottom, BOX_SIDE_Z_top, BOX_SIDE_Z_bottom}}
local vr_side_LEV_TUMB   = {{0},{BOX_SIDE_X_top, BOX_SIDE_X_bottom, BOX_SIDE_Z_top, BOX_SIDE_Z_bottom}}
local vr_side_BTN_LEV    = {{BOX_SIDE_Y_bottom},{BOX_SIDE_X_top, BOX_SIDE_X_bottom, BOX_SIDE_Z_top, BOX_SIDE_Z_bottom}}
local vr_side_CLOCK_LEV  = {{BOX_SIDE_Y_bottom},{BOX_SIDE_Y_top},{BOX_SIDE_X_top, BOX_SIDE_X_bottom, BOX_SIDE_Z_top, BOX_SIDE_Z_bottom}}
local vr_side_LEV_BTN    = {{BOX_SIDE_X_top, BOX_SIDE_X_bottom, BOX_SIDE_Z_top, BOX_SIDE_Z_bottom},{BOX_SIDE_Y_bottom}}
local vr_side_BTN		 = {{BOX_SIDE_Y_bottom}}
local vr_side_TUMB       = {{BOX_SIDE_Z_top},{BOX_SIDE_Z_bottom}}
local vr_side_TUMB_rev   = {{BOX_SIDE_Z_bottom},{BOX_SIDE_Z_top}}
local vr_side_TUMB_COVER = {{BOX_SIDE_Z_bottom},{BOX_SIDE_Y_bottom}}
local vr_side_TUMB_C_rev = {{BOX_SIDE_Y_bottom},{BOX_SIDE_Z_bottom}}

--VR class locals
local MULTY_TUMB  = {class_type.MULTY_TUMB, class_type.MULTY_TUMB}

-- Ka-50
elements = {}

--------------------------------------------------------------------------------
-- CPT MECH
elements["GEAR-PTR"]			= {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("Gear lever"), device = devices.CPT_MECH, action = {device_commands.Button_1,device_commands.Button_1}, arg = {65,65}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0.0, 1.0},{0.0, 1.0}}, updatable = true, use_OBB = true, side = vr_side_TUMB_rev}
elements["GEAR-PTR"].sound		= {{SOUND_SW4_UP, SOUND_SW4_DOWN}}
elements["AVAR-GEAR-PTR"]		= {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("Main/Common hydraulics for emergency gear"), device = devices.CPT_MECH, action = {device_commands.Button_4,device_commands.Button_4}, arg = {66,66}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0.0, 1.0},{0.0, 1.0}}, use_OBB = true, updatable = true, side = vr_side_TUMB_rev}
elements["AVAR-GEAR-COVER-PTR"]	= {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("Main/Common hydraulics for emergency gear"), device = devices.CPT_MECH, action = {device_commands.Button_5,device_commands.Button_5}, arg = {67,67}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0.0, 1.0},{0.0, 1.0}}, use_OBB = true, updatable = true, side = vr_side_TUMB_C_rev}
elements["AVAR-GEAR-COVER-PTR"].sound = {{SOUND_SW3_CLOSE, SOUND_SW3_OPEN}}

elements["G--PTR"]				= {class = {class_type.BTN}, hint = LOCALIZE("Accelerometer reset"), device = devices.ACCELEROMETER, action = {device_commands.Button_1}, stop_action = {device_commands.Button_1}, arg = {572}, arg_value = {1.0}, arg_lim = {{0.0, 1.0}}, use_release_message = {true}, side = vr_side_BTN}

--------------------------------------------------------------------------------
-- SYSTEM CONTROLLER
elements["CSO-PTR"]   			= {class = {class_type.BTN}, hint = LOCALIZE("Master caution push-light"), device = devices.SYST_CONTROLLER, action = {device_commands.Button_1}, stop_action = {device_commands.Button_1}, arg = {44}, arg_value = {0.2}, arg_lim = {{0.0, 0.2}}, use_release_message = {true} , side = vr_side_BTN}
elements["CONTROL-ALARM-PTR"]	= {class = {class_type.BTN}, hint = LOCALIZE("Lamps test"), device = devices.SYST_CONTROLLER, action = {device_commands.Button_2},  stop_action = {device_commands.Button_2}, arg = {45}, arg_value = {1.0}, arg_lim = {{0.0, 1.0}}, use_release_message = {true} , side = vr_side_BTN}
elements["MAIN-ROTOR-PTR"]		= {class = {class_type.BTN}, hint = LOCALIZE("Rotor RPM warning push-light"), device = devices.SYST_CONTROLLER, action = {device_commands.Button_3}, stop_action = {device_commands.Button_3}, arg = {46}, arg_value = {0.2}, arg_lim = {{0.0, 0.2}} , side = vr_side_BTN}
elements["BKO-PTR"]				= {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("MWS operation mode (not functional)"), device = devices.SYST_CONTROLLER, action = {device_commands.Button_4,device_commands.Button_4}, arg = {49,49}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0.0, 1.0}, {0.0, 1.0}}, use_OBB = true, updatable = true, side = vr_side_TUMB}

--------------------------------------------------------------------------------
-- Right Side Panel (Правый Боковой Пульт) 
-- ELECTRICS POWER
elements["ENERG-AER-RIT-PTR"]		= {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("DC ground power"),		device = devices.ELEC_INTERFACE, action = {device_commands.Button_1,device_commands.Button_1},	arg = {262,262}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0, 1.0},{0, 1.0}}, use_OBB = true, updatable = true, side = vr_side_TUMB}
elements["ENERG-COVER-AER-RIT-PTR"]	= {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("DC ground power"),		device = devices.ELEC_INTERFACE, action = {device_commands.Button_2,device_commands.Button_2},	arg = {263,263}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0, 1.0},{0, 1.0}}, use_OBB = true, updatable = true, side = vr_side_TUMB_COVER}
elements["ENERG-COVER-AER-RIT-PTR"].sound = {{SOUND_SW3_CLOSE, SOUND_SW3_OPEN}}
elements["ENERG-AKK2-PTR"]			= {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("Battery 2"),			device = devices.ELEC_INTERFACE, action = {device_commands.Button_3,device_commands.Button_3},	arg = {543,543}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0, 1.0},{0, 1.0}}, use_OBB = true, updatable = true, side = vr_side_TUMB}
elements["ENERG-COVER-AKK2-PTR"]	= {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("Battery 2"),			device = devices.ELEC_INTERFACE, action = {device_commands.Button_4,device_commands.Button_4},	arg = {544,544}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0, 1.0},{0, 1.0}}, use_OBB = true, updatable = true, side = vr_side_TUMB_COVER}
elements["ENERG-COVER-AKK2-PTR"].sound = {{SOUND_SW3_CLOSE, SOUND_SW3_OPEN}}
elements["ENERG-AKK1-PTR"]			= {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("Battery 1"),			device = devices.ELEC_INTERFACE, action = {device_commands.Button_5,device_commands.Button_5},	arg = {264,264}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0, 1.0},{0, 1.0}}, use_OBB = true, updatable = true, side = vr_side_TUMB}
elements["ENERG-COVER-AKK1-PTR"]	= {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("Battery 1"),			device = devices.ELEC_INTERFACE, action = {device_commands.Button_6,device_commands.Button_6},	arg = {265,265}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0, 1.0},{0, 1.0}}, use_OBB = true, updatable = true, side = vr_side_TUMB_COVER}
elements["ENERG-COVER-AKK1-PTR"].sound = {{SOUND_SW3_CLOSE, SOUND_SW3_OPEN}}
elements["RAMP-POWER-PTR"]			= {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("AC ground power"),		device = devices.ELEC_INTERFACE, action = {device_commands.Button_7,device_commands.Button_7},	arg = {267,267}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0, 1},{0, 1}}, use_OBB = true, updatable = true, side = vr_side_TUMB}
elements["GEN-LEFT-PTR"]			= {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("AC left generator"),	device = devices.ELEC_INTERFACE, action = {device_commands.Button_8,device_commands.Button_8},	arg = {268,268}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0, 1},{0, 1}}, use_OBB = true, updatable = true, side = vr_side_TUMB}
elements["GEN-RIGHT-PTR"]			= {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("AC right generator"),  device = devices.ELEC_INTERFACE, action = {device_commands.Button_9,device_commands.Button_9},	arg = {269,269}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0, 1},{0,1}}, use_OBB = true, updatable = true, side = vr_side_TUMB}
elements["CONVERTER-PTR"]			= {class = {class_type.TUMB, class_type.TUMB}, hint = LOCALIZE("DC/AC inverter"), device = devices.ELEC_INTERFACE, action = {device_commands.Button_10, device_commands.Button_11}, arg = {270, 270}, arg_value = {-direction*0.1, direction*0.1}, arg_lim = {{0.0, 0.2}, {0.0, 0.2}}, use_OBB = true, updatable = true, side = vr_side_TUMB}

-- FUEL SYSTEM
elements["FUEL-PUMP-FRONT-PTR"]					= {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("Forward fuel tank pumps"),  device = devices.FUELSYS_INTERFACE, action = {device_commands.Button_1,device_commands.Button_1}, arg = {271,271}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0, 1},{0,1}}, use_OBB = true, updatable = true, side = vr_side_TUMB}
elements["FUEL-PUMP-BACK-PTR"]					= {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("Rear fuel tank pumps"),  device = devices.FUELSYS_INTERFACE, action = {device_commands.Button_2,device_commands.Button_2}, arg = {272,272}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0, 1},{0, 1}}, use_OBB = true, updatable = true, side = vr_side_TUMB}
elements["FUEL-PUMP-INNER-PTR"]					= {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("Inner external fuel tanks pumps"),  device = devices.FUELSYS_INTERFACE, action = {device_commands.Button_3,device_commands.Button_3}, arg = {273,273}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0, 1},{0, 1}}, use_OBB = true, updatable = true, side = vr_side_TUMB}
elements["FUEL-PUMP-OUTER-PTR"]					= {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("Outer external fuel tanks pumps"),  device = devices.FUELSYS_INTERFACE, action = {device_commands.Button_4,device_commands.Button_4}, arg = {274,274}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0, 1},{0, 1}}, use_OBB = true, updatable = true, side = vr_side_TUMB}
elements["FUEL-METER-PTR"]						= {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("Fuelmeter power"),  device = devices.FUELSYS_INTERFACE, action = {device_commands.Button_5,device_commands.Button_5}, arg = {275,275}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0, 1},{0,1}}, use_OBB = true, updatable = true, side = vr_side_TUMB}
elements["PAV-CRANE-ENGINE-LEFT-PTR"]			= {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("Left engine fuel shutoff valve"), device = devices.FUELSYS_INTERFACE, action = {device_commands.Button_6,device_commands.Button_6},	arg = {276,276}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0,1},{0,1}}, use_OBB = true, updatable = true, side = vr_side_TUMB}
elements["PAV-CRANE-COVER-ENGINE-LEFT-PTR"]		= {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("Left engine fuel shutoff valve"), device = devices.FUELSYS_INTERFACE, action = {device_commands.Button_7,device_commands.Button_7},	arg = {277,277}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0, 1},{0,1}}, use_OBB = true, updatable = true, side = vr_side_TUMB_COVER}
elements["PAV-CRANE-COVER-ENGINE-LEFT-PTR"].sound = {{SOUND_SW3_CLOSE, SOUND_SW3_OPEN}}
elements["PAV-CRANE-ENGINE-RIGHT-PTR"]			= {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("Right engine fuel shutoff valve"), device = devices.FUELSYS_INTERFACE, action = {device_commands.Button_8,device_commands.Button_8},	arg = {278,278}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0, 1},{0, 1}}, use_OBB = true, updatable = true, side = vr_side_TUMB}
elements["PAV-CRANE-COVER-ENGINE-RIGHT-PTR"]		= {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("Right engine fuel shutoff valve"), device = devices.FUELSYS_INTERFACE, action = {device_commands.Button_9,device_commands.Button_9},	arg = {279,279}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0, 1},{0,1}}, use_OBB = true, updatable = true, side = vr_side_TUMB_COVER}
elements["PAV-CRANE-COVER-ENGINE-RIGHT-PTR"].sound = {{SOUND_SW3_CLOSE, SOUND_SW3_OPEN}}
elements["PAV-CRANE-VSU-PTR"]					= {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("APU fuel shutoff valve"), device = devices.FUELSYS_INTERFACE, action = {device_commands.Button_10,device_commands.Button_10},	arg = {280,280}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0, 1},{0, 1}}, use_OBB = true, updatable = true, side = vr_side_TUMB}
elements["PAV-CRANE-COVER-VSU-PTR"]				= {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("APU fuel shutoff valve"), device = devices.FUELSYS_INTERFACE, action = {device_commands.Button_11,device_commands.Button_11},	arg = {281,281}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0, 1},{0, 1}}, use_OBB = true, updatable = true, side = vr_side_TUMB_COVER}
elements["PAV-CRANE-COVER-VSU-PTR"].sound = {{SOUND_SW3_CLOSE, SOUND_SW3_OPEN}}
elements["PAV-CRANE-CYKLIZATION-PTR"]			= {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("Fuel crossfeed valve"), device = devices.FUELSYS_INTERFACE, action = {device_commands.Button_12,device_commands.Button_12},	arg = {282,282}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0, 1},{0, 1}}, use_OBB = true, updatable = true, side = vr_side_TUMB}
elements["PAV-CRANE-COVER-CYKLIZATION-PTR"]		= {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("Fuel crossfeed valve"), device = devices.FUELSYS_INTERFACE, action = {device_commands.Button_13,device_commands.Button_13},	arg = {283,283}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0, 1},{0, 1}}, use_OBB = true, updatable = true, side = vr_side_TUMB_COVER}
elements["PAV-CRANE-COVER-CYKLIZATION-PTR"].sound = {{SOUND_SW3_CLOSE, SOUND_SW3_OPEN}}
elements["CONTROL-OIL-PTR"]						= {class = {class_type.BTN}, hint = LOCALIZE("Fuel quantity indicator self test button"), device = devices.FUELSYS_INTERFACE, action = {device_commands.Button_14}, stop_action = {device_commands.Button_14}, arg = {616}, arg_value = {1.0}, arg_lim = {{0, 1}}, use_release_message = {true}, side = vr_side_BTN}

-- COMMS POWER
elements["COMM-PWR-AVSK-PTR"]		= {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("Intercom"), device = devices.SPU_9, action = {device_commands.Button_1,device_commands.Button_1}, arg = {284,284}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0, 1},{0, 1}}, use_OBB = true, updatable = true, side = vr_side_TUMB}
elements["COMM-PWR-UKV-1-PTR"]		= {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("VHF-1 (R828) power switch"), device = devices.R_828, action = {device_commands.Button_5,device_commands.Button_5}, arg = {285,285}, arg_value = {-direction*1.0,direction*1.0}, arg_lim =  {{0, 1},{0, 1}}, use_OBB = true, updatable = true, side = vr_side_TUMB}
elements["COMM-PWR-UKV-2-PTR"]		= {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("VHF-2 (R-800) power switch"), device = devices.R_800, action = {device_commands.Button_11,device_commands.Button_11}, arg = {286,286}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0, 1},{0, 1}}, use_OBB = true, updatable = true, side = vr_side_TUMB}
elements["COMM-PWR-TLK-PTR"]		= {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("Radio equipment datalink TLK power switch"), device = devices.DATALINK, action = {device_commands.Button_17,device_commands.Button_17}, arg = {287,287}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0, 1},{0, 1}}, use_OBB = true, updatable = true, side = vr_side_TUMB}
elements["COMM-PWR-UKV-TLK-PTR"]	= {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("Radio equipment datalink UHF TLK power switch"), device = devices.DATALINK, action = {device_commands.Button_18,device_commands.Button_18}, arg = {288,288}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0, 1},{0, 1}}, use_OBB = true, updatable = true, side = vr_side_TUMB}
elements["COMM-PWR-SA-TLF-PTR"]		= {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("Radio equipment datalink SA-TLF power switch"), device = 0, action = {device_commands.Button_7,device_commands.Button_7}, arg = {289,289}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0, 1},{0, 1}}, use_OBB = true, updatable = true, side = vr_side_TUMB}
-- WEAPON SYS
elements["SUO-PTR"]					= {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("Weapons сontrol system"),		device = devices.WEAP_INTERFACE, action = {device_commands.Button_18,device_commands.Button_18},	arg = {547,547}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0, 1.0},{0, 1.0}}, use_OBB = true , updatable = true, side = vr_side_TUMB}
elements["SUO-COVER-PTR"]			= {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("Weapons сontrol system"),		device = devices.WEAP_INTERFACE, action = {device_commands.Button_19,device_commands.Button_19},	arg = {548,548}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0, 1.0},{0, 1.0}}, use_OBB = true, updatable = true, side = vr_side_TUMB_C_rev}
elements["SUO-COVER-PTR"].sound = {{SOUND_SW3_CLOSE, SOUND_SW3_OPEN}}
-- EJECT SYSTEM
elements["RIGHT-EMERG-SW1-PTR"]				= {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("Ejecting system power 1"), device = devices.EJECT_SYS_INTERFACE, action = {device_commands.Button_1,device_commands.Button_1},	arg = {214,214}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0, 1.0},{0, 1.0}}, use_OBB = true, updatable = true, side = vr_side_TUMB_rev}
elements["RIGHT-EMERG-SW2-PTR"]				= {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("Ejecting system power 2"), device = devices.EJECT_SYS_INTERFACE, action = {device_commands.Button_2,device_commands.Button_2},	arg = {215,215}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0, 1.0},{0, 1.0}}, use_OBB = true, updatable = true, side = vr_side_TUMB_rev}
elements["RIGHT-EMERG-SW3-PTR"]				= {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("Ejecting system power 3"), device = devices.EJECT_SYS_INTERFACE, action = {device_commands.Button_3,device_commands.Button_3},	arg = {216,216}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0, 1.0},{0, 1.0}}, use_OBB = true, updatable = true, side = vr_side_TUMB_rev}
elements["RIGHT-COVER-EMERG-VACATION-PTR"]	= {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("Ejecting system power"), device = devices.EJECT_SYS_INTERFACE, action = {device_commands.Button_4,device_commands.Button_4},	arg = {217,217}, arg_value = {direction*1.0,-direction*1.0}, arg_lim = {{0, 1.0},{0, 1.0}}, use_OBB = true, updatable = true, side = vr_side_TUMB_COVER}
elements["RIGHT-COVER-EMERG-VACATION-PTR"].sound = {{SOUND_SW6}}
elements["CONTR-SAPROTATE-PTR"]				= {class = {class_type.TUMB, class_type.TUMB}, hint = LOCALIZE("Ejecting system circuit selector"), device = devices.EJECT_SYS_INTERFACE, action = {device_commands.Button_5, device_commands.Button_5}, arg = {462, 462}, arg_value = {-direction*0.1, direction*0.1}, arg_lim = {{0.0, 0.6}, {0, 0.6}}, class_vr = MULTY_TUMB, side = vr_side_LEV_TUMB, attach_left = {90, -45}, attach_right = {-40, -45}}
elements["CONTR-SAPROTATE-PTR"].sound	= {{SOUND_SW2}}
elements["CONTR-SAP-PTR"]   				= {class = {class_type.BTN},hint = LOCALIZE("Ejecting system circuit test"), device = devices.EJECT_SYS_INTERFACE, action = {device_commands.Button_6} ,stop_action = {device_commands.Button_6}, arg = {460}, arg_value = {1}, arg_lim = {{0,1}}, use_release_message = {true}, side = vr_side_BTN}
-- HYDRAULICS
elements["HYDRO-PTR"]			= {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("Main hydraulics"), device = devices.HYDRO_SYS_INTERFACE, action = {device_commands.Button_1,device_commands.Button_1}, arg = {220,220}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0.0, 1.0},{0.0, 1.0}}, use_OBB = true, updatable = true, side = vr_side_TUMB}
elements["HYDRO-COVER-PTR02"]	= {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("Main hydraulics"), device = devices.HYDRO_SYS_INTERFACE, action = {device_commands.Button_2,device_commands.Button_2},	arg = {221,221}, arg_value = {direction*1.0,-direction*1.0}, arg_lim = {{0.0, 1.0},{0.0, 1.0}}, use_OBB = true, updatable = true , side = vr_side_TUMB_COVER}
elements["HYDRO-COVER-PTR02"].sound = {{SOUND_SW3_CLOSE, SOUND_SW3_OPEN}}
-- IFF
elements["SRO-PTR"]				= {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("IFF power"), device = devices.IFF, action = {device_commands.Button_1,device_commands.Button_1}, arg = {218,218}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0.0, 1.0},{0.0,1.0}}, use_OBB = true, updatable = true, side = vr_side_TUMB}
elements["COVER-SRO-PTR"]		= {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("IFF power"), device = devices.IFF, action = {device_commands.Button_2,device_commands.Button_2}, arg = {219,219}, arg_value = {direction*1.0,-direction*1.0}, arg_lim = {{0.0, 1.0},{0.0, 1.0}}, use_OBB = true, updatable = true , side = vr_side_TUMB_COVER}
elements["COVER-SRO-PTR"].sound = {{SOUND_SW3_CLOSE, SOUND_SW3_OPEN}}
-- ENGINES
elements["ERD-LEFT-PTR"]		= {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("EEG Left engine Electronic Engine Governor"), device = devices.ENGINE_INTERFACE, action = {device_commands.Button_1,device_commands.Button_1}, arg = {290,290}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0, 1.0},{0, 1.0}}, use_OBB = true, updatable = true, side = vr_side_TUMB}
elements["ERD-LEFT-COVER-PTR"]	= {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("EEG Left engine Electronic Engine Governor"), device = devices.ENGINE_INTERFACE, action = {device_commands.Button_2,device_commands.Button_2}, arg = {291,291}, arg_value = {direction*1.0,-direction*1.0}, arg_lim = {{0, 1.0},{0, 1.0}}, use_OBB = true, updatable = true, side = vr_side_TUMB_COVER}
elements["ERD-LEFT-COVER-PTR"].sound = {{SOUND_SW3_CLOSE, SOUND_SW3_OPEN}}
elements["ERD-RIGHT-PTR"]		= {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("EEG Right engine Electronic Engine Governor"), device = devices.ENGINE_INTERFACE, action = {device_commands.Button_3,device_commands.Button_3}, arg = {292,292}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0, 1.0},{0, 1.0}}, use_OBB = true, updatable = true, side = vr_side_TUMB}
elements["ERD-RIGHT-COVER-PTR"]	= {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("EEG Right engine Electronic Engine Governor"), device = devices.ENGINE_INTERFACE, action = {device_commands.Button_4,device_commands.Button_4}, arg = {293,293}, arg_value = {direction*1.0,-direction*1.0}, arg_lim = {{0, 1.0},{0, 1.0}}, use_OBB = true, updatable = true , side = vr_side_TUMB_COVER}
elements["ERD-RIGHT-COVER-PTR"].sound = {{SOUND_SW3_CLOSE, SOUND_SW3_OPEN}}

elements["PAV-CRANE-VSU-PTR01"]		= {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("EEG gas generator test – Operate switch"), device = devices.ENGINE_INTERFACE, action = {device_commands.Button_15,device_commands.Button_15}, arg = {294,294}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0, 1.0},{0, 1.0}}, use_OBB = true, updatable = true, side = vr_side_TUMB}
elements["PAV-CRANE-COVER-VSU-PTR01"]	= {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("EEG gas generator test – Operate switch"), device = devices.ENGINE_INTERFACE, action = {device_commands.Button_16,device_commands.Button_16}, arg = {569,569}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0, 1.0},{0, 1.0}}, use_OBB = true, updatable = true, side = vr_side_TUMB_COVER}
elements["PAV-CRANE-COVER-VSU-PTR01"].sound = {{SOUND_SW3_CLOSE, SOUND_SW3_OPEN}}
elements["PAV-CRANE-VSU-PTR02"]		= {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("EEG power turbine channel 1 test – Operate – EEG power turbine channel 2 test, three-switch contactor"), device = devices.ENGINE_INTERFACE, action = {device_commands.Button_17,device_commands.Button_17}, arg = {295,295}, arg_value = {-direction*0.1,direction*0.1}, arg_lim = {{0, 0.2},{0, 0.2}}, use_OBB = true, updatable = true, side = vr_side_TUMB}
elements["PAV-CRANE-COVER-VSU-PTR02"]	= {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("EEG power turbine channel 1 test – Operate – EEG power turbine channel 2 test, three-switch contactor"), device = devices.ENGINE_INTERFACE, action = {device_commands.Button_18,device_commands.Button_18}, arg = {570,570}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0, 1.0},{0, 1.0}}, use_OBB = true, updatable = true , side = vr_side_TUMB_COVER}
elements["PAV-CRANE-COVER-VSU-PTR02"].sound = {{SOUND_SW3_CLOSE, SOUND_SW3_OPEN}}

elements["RT-12-6-LEFT-PTR"]	= {class = {class_type.BTN}, hint = LOCALIZE("Left EGT control threshold governor button"), device = devices.ENGINE_INTERFACE, action = {device_commands.Button_19}, stop_action = {device_commands.Button_19}, arg = {457}, arg_value = {1.0}, arg_lim = {{0.0, 1.0}}, use_release_message = {true}, side = vr_side_BTN}
elements["RT-12-6-RIGHT-PTR"]	= {class = {class_type.BTN}, hint = LOCALIZE("Right EGT control threshold governor button"), device = devices.ENGINE_INTERFACE, action = {device_commands.Button_20}, stop_action = {device_commands.Button_20}, arg = {458}, arg_value = {1.0}, arg_lim = {{0.0, 1.0}}, use_release_message = {true}, side = vr_side_BTN}
elements["RT-12-6-IV-PTR"]		= {class = {class_type.BTN}, hint = LOCALIZE("Engines vibrations monitoring system control button"), device = devices.ENGINE_INTERFACE, action = {device_commands.Button_21}, stop_action = {device_commands.Button_21}, arg = {459}, arg_value = {1.0}, arg_lim = {{0.0, 1.0}}, use_release_message = {true}, side = vr_side_BTN}
-- NAV SYSTEM
elements["PNK-PTR"]				= {class = {class_type.TUMB,class_type.TUMB},hint = LOCALIZE("Navigation system power"), device = devices.K041, action = {device_commands.Button_1,device_commands.Button_1}, arg = {222,222}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0, 1},{0, 1}}, use_OBB = true, updatable = true, side = vr_side_TUMB}
elements["GYRO-MAG-MAN-HEADING-PTR"]= {class = {class_type.TUMB, class_type.TUMB}, hint = LOCALIZE("Gyro/Mag/Manual heading"), device = devices.NAV_INTERFACE, action = {device_commands.Button_1, device_commands.Button_2}, arg = {229, 229}, arg_value = {-direction*0.1, direction*0.1}, arg_lim = {{0.0, 0.2}, {0, 0.2}}, use_OBB = true, updatable = true, side = vr_side_TUMB_rev}

--------------------------------------------------------------------------------
-- ABRIS Display (Дисплей АБРИС) 
elements["PTR_BTN-ABRIS-01"]   	= {class = {class_type.BTN},hint = LOCALIZE("ABRIS Pushbutton 1"),	device = devices.ABRIS, action = {device_commands.Button_1} ,stop_action = {device_commands.Button_1} ,is_repeatable = {},arg = {512},arg_value = {1},arg_lim = {{0,1}}, side = vr_side_BTN} -- start value 0.01 the same index for -2,-3,-4,-5,-6,-7,-8,-9,-RCL,-ENTR with increment 0.01
elements["PTR_BTN-ABRIS-02"]   	= {class = {class_type.BTN},hint = LOCALIZE("ABRIS Pushbutton 2"),	device = devices.ABRIS, action = {device_commands.Button_2} ,stop_action = {device_commands.Button_2} ,is_repeatable = {},arg = {513},arg_value = {1},arg_lim = {{0,1}}, side = vr_side_BTN}
elements["PTR_BTN-ABRIS-03"]   	= {class = {class_type.BTN}, hint = LOCALIZE("ABRIS Pushbutton 3"),	device = devices.ABRIS, action = {device_commands.Button_3} ,stop_action = {device_commands.Button_3} ,is_repeatable = {},arg = {514},arg_value = {1},arg_lim = {{0,1}}, side = vr_side_BTN}
elements["PTR_BTN-ABRIS-04"]   	= {class = {class_type.BTN},hint = LOCALIZE("ABRIS Pushbutton 4"),	device = devices.ABRIS, action = {device_commands.Button_4} ,stop_action = {device_commands.Button_4} ,is_repeatable = {},arg = {515},arg_value = {1},arg_lim = {{0,1}}, side = vr_side_BTN}
elements["PTR_BTN-ABRIS-05"]   	= {class = {class_type.BTN},hint = LOCALIZE("ABRIS Pushbutton 5"),	device = devices.ABRIS, action = {device_commands.Button_5} ,stop_action = {device_commands.Button_5} ,is_repeatable = {},arg = {516},arg_value = {1},arg_lim = {{0,1}}, side = vr_side_BTN}
elements["ABRIS_SHUNT_PTR"]   	= {class = {class_type.LEV, class_type.BTN},hint = LOCALIZE("ABRIS Cursor сontrol (rot/push)"), device = devices.ABRIS	,action = {device_commands.Button_6,device_commands.Button_7},stop_action = {0,device_commands.Button_7} ,is_repeatable = {} ,arg = {518,523},arg_value = {0.04,1},arg_lim = {{0,1},{0,1}},relative = {true,false},gain = {0.25,0}, side = vr_side_LEV_BTN, attach_right = {80, -70}}
elements["ABRIS_BRIGHTNESS_PTR"]= {class = {class_type.LEV}, hint = LOCALIZE("ABRIS Brightness"),		device = devices.ABRIS	,action = {device_commands.Button_8} ,arg = {517}    ,arg_value = {0.05} , gain = {0.1} ,arg_lim = {{0,1}},cycle = false, side = vr_side_LEV}
elements["ABRIS-POWER_PTR"]   	= {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("ABRIS Power"),			device = devices.ABRIS	,action = {device_commands.Button_9,device_commands.Button_9} , arg = {130,130}, arg_value = {-direction*1,direction*1.0}, arg_lim = {{0, 1},{0,1}}, use_OBB = true, updatable = true, side = vr_side_TUMB}

--------------------------------------------------------------------------------
-- HUD (ИЛС)
elements["PTR_HUD-BRIGHTNESS"]  = { class = {class_type.LEV}, hint = LOCALIZE("HUD Brightness"), device = devices.HUD, action = {device_commands.Button_1}, arg = {8}, arg_value = {0.05}, arg_lim = {{0.0, 1.0}} ,cycle = false, side = vr_side_LEV}
elements["PTR_HUD-TMB-SETKA02"] = { class = {class_type.TUMB, class_type.TUMB}, hint = LOCALIZE("HUD Modes Reticle/Night/Day"), device = devices.HUD, action = {device_commands.Button_2, device_commands.Button_2}, arg = {9, 9}, arg_value = {-direction*1.0, direction*1.0}, arg_lim = {{-1,1}, {-1,1}}, side = {{BOX_SIDE_Z_bottom},{BOX_SIDE_X_top}}}
elements["PTR_HUD-TMB-SETKA02"].sound	= {{SOUND_SW2}}
elements["PTR-HUD-TEST"]		= { class = {class_type.BTN}, hint = LOCALIZE("HUD Test"), device = devices.HUD, action = {device_commands.Button_3},  stop_action = {device_commands.Button_3}, arg = {7}, arg_value = {1.0}, arg_lim = {{0.0, 1.0}},use_release_message = {true}, side = vr_side_BTN}
elements["PTR_HUD-FILTER"]		= { class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("HUD Filter"), device = devices.HUD, action = {device_commands.Button_4,device_commands.Button_4}, arg = {510,510}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0.0, 1.0},{0.0, 1.0}}, updatable = true, use_OBB = true , side = vr_side_TUMB_rev}
elements["PTR_HUD-FILTER"].sound = {{SOUND_SW7_OFF, SOUND_SW7_ON}}

--------------------------------------------------------------------------------
-- PVI NAV Panel (ПВИ - Пульт Ввода и Индикации)
elements["PVI-0-PTR"]			= {class = {class_type.BTN}, hint = LOCALIZE("NAV '0' Btn"), device = devices.PVI, action = {device_commands.Button_1},  stop_action = {device_commands.Button_1},  arg = {312}, arg_value = {0.2}, arg_lim = {{0.0, 0.2}}, use_OBB = false, side = vr_side_BTN}
elements["PVI-1-PTR"]			= {class = {class_type.BTN}, hint = LOCALIZE("NAV '1' Btn"), device = devices.PVI, action = {device_commands.Button_2},  stop_action = {device_commands.Button_2},  arg = {303}, arg_value = {0.2}, arg_lim = {{0.0, 0.2}}, use_OBB = false, side = vr_side_BTN}
elements["PVI-2-PTR"]			= {class = {class_type.BTN}, hint = LOCALIZE("NAV '2' Btn"), device = devices.PVI, action = {device_commands.Button_3},  stop_action = {device_commands.Button_3},  arg = {304}, arg_value = {0.2}, arg_lim = {{0.0, 0.2}}, use_OBB = false, side = vr_side_BTN}
elements["PVI-3-PTR"]			= {class = {class_type.BTN}, hint = LOCALIZE("NAV '3' Btn"), device = devices.PVI, action = {device_commands.Button_4},  stop_action = {device_commands.Button_4},  arg = {305}, arg_value = {0.2}, arg_lim = {{0.0, 0.2}}, use_OBB = false, side = vr_side_BTN}
elements["PVI-4-PTR"]			= {class = {class_type.BTN}, hint = LOCALIZE("NAV '4' Btn"), device = devices.PVI, action = {device_commands.Button_5},  stop_action = {device_commands.Button_5},  arg = {306}, arg_value = {0.2}, arg_lim = {{0.0, 0.2}}, use_OBB = false, side = vr_side_BTN}
elements["PVI-5-PTR"]			= {class = {class_type.BTN}, hint = LOCALIZE("NAV '5' Btn"), device = devices.PVI, action = {device_commands.Button_6},  stop_action = {device_commands.Button_6},  arg = {307}, arg_value = {0.2}, arg_lim = {{0.0, 0.2}}, use_OBB = false, side = vr_side_BTN}
elements["PVI-6-PTR"]			= {class = {class_type.BTN}, hint = LOCALIZE("NAV '6' Btn"), device = devices.PVI, action = {device_commands.Button_7},  stop_action = {device_commands.Button_7},  arg = {308}, arg_value = {0.2}, arg_lim = {{0.0, 0.2}}, use_OBB = false, side = vr_side_BTN}
elements["PVI-7-PTR"]			= {class = {class_type.BTN}, hint = LOCALIZE("NAV '7' Btn"), device = devices.PVI, action = {device_commands.Button_8},  stop_action = {device_commands.Button_8},  arg = {309}, arg_value = {0.2}, arg_lim = {{0.0, 0.2}}, use_OBB = false, side = vr_side_BTN}
elements["PVI-8-PTR"]			= {class = {class_type.BTN}, hint = LOCALIZE("NAV '8' Btn"), device = devices.PVI, action = {device_commands.Button_9},  stop_action = {device_commands.Button_9},  arg = {310}, arg_value = {0.2}, arg_lim = {{0.0, 0.2}}, use_OBB = false, side = vr_side_BTN}
elements["PVI-9-PTR"]			= {class = {class_type.BTN}, hint = LOCALIZE("NAV '9' Btn"), device = devices.PVI, action = {device_commands.Button_10}, stop_action = {device_commands.Button_10}, arg = {311}, arg_value = {0.2}, arg_lim = {{0.0, 0.2}}, use_OBB = false, side = vr_side_BTN}
elements["PVI-PPM-PTR"]			= {class = {class_type.BTN}, hint = LOCALIZE("NAV Waypoints"), device = devices.PVI, action = {device_commands.Button_11}, stop_action = {device_commands.Button_11}, arg = {315}, arg_value = {0.2}, arg_lim = {{0.0, 0.2}}, use_OBB = false, side = vr_side_BTN}
elements["PVI-PZ-PTR"]			= {class = {class_type.BTN}, hint = LOCALIZE("NAV Inflight INU Realignment"), device = devices.PVI, action = {device_commands.Button_12}, stop_action = {device_commands.Button_12}, arg = {519}, arg_value = {0.2}, arg_lim = {{0.0, 0.2}}, use_OBB = false, side = vr_side_BTN}
elements["PVI-OP-PTR"]			= {class = {class_type.BTN}, hint = LOCALIZE("NAV Fixpoints"), device = devices.PVI, action = {device_commands.Button_13}, stop_action = {device_commands.Button_13}, arg = {316}, arg_value = {0.2}, arg_lim = {{0.0, 0.2}}, use_OBB = false, side = vr_side_BTN}
elements["PVI-TB-PTR"]			= {class = {class_type.BTN}, hint = LOCALIZE("NAV Precise INU Alignment"), device = devices.PVI, action = {device_commands.Button_14}, stop_action = {device_commands.Button_14}, arg = {520}, arg_value = {0.2}, arg_lim = {{0.0, 0.2}}, use_OBB = false, side = vr_side_BTN}
elements["PVI-AER-PTR"]			= {class = {class_type.BTN}, hint = LOCALIZE("NAV Airfields"), device = devices.PVI, action = {device_commands.Button_15}, stop_action = {device_commands.Button_15}, arg = {317}, arg_value = {0.2}, arg_lim = {{0.0, 0.2}}, use_OBB = false, side = vr_side_BTN}
elements["PVI-HB-PTR"]			= {class = {class_type.BTN}, hint = LOCALIZE("NAV Normal INU Alignment"),  device = devices.PVI, action = {device_commands.Button_16}, stop_action = {device_commands.Button_16}, arg = {521}, arg_value = {0.2}, arg_lim = {{0.0, 0.2}}, use_OBB = false, side = vr_side_BTN}
elements["PVI-OT-PTR"]			= {class = {class_type.BTN}, hint = LOCALIZE("NAV Targets"), device = devices.PVI, action = {device_commands.Button_17}, stop_action = {device_commands.Button_17}, arg = {318}, arg_value = {0.2}, arg_lim = {{0.0, 0.2}}, use_OBB = false, side = vr_side_BTN}
elements["PVI-ENTER-PTR"]		= {class = {class_type.BTN}, hint = LOCALIZE("NAV Enter"), device = devices.PVI, action = {device_commands.Button_18}, stop_action = {device_commands.Button_18}, arg = {313}, arg_value = {0.2}, arg_lim = {{0.0, 0.2}}, use_OBB = false, side = vr_side_BTN}
elements["PVI-CANCEL-PTR"]		= {class = {class_type.BTN}, hint = LOCALIZE("NAV Cancel"), device = devices.PVI, action = {device_commands.Button_19}, stop_action = {device_commands.Button_19}, arg = {314}, arg_value = {0.2}, arg_lim = {{0.0, 0.2}}, use_OBB = false, side = vr_side_BTN}
elements["PVI-KC-PTR"]			= {class = {class_type.BTN}, hint = LOCALIZE("NAV Initial Nav Pos"), device = devices.PVI, action = {device_commands.Button_20}, stop_action = {device_commands.Button_20}, arg = {522}, arg_value = {0.2}, arg_lim = {{0.0, 0.2}}, use_OBB = false, side = vr_side_BTN}
elements["PVI-FILAMBDA-PTR"]	= {class = {class_type.BTN}, hint = LOCALIZE("NAV Self coordinates"), device = devices.PVI, action = {device_commands.Button_21}, stop_action = {device_commands.Button_21}, arg = {319}, arg_value = {0.2}, arg_lim = {{0.0, 0.2}}, use_OBB = false, side = vr_side_BTN}
elements["PVI-FIZ-PTR"]			= {class = {class_type.BTN}, hint = LOCALIZE("NAV Course:Course Deviation/Time/Range to WPT"), device = devices.PVI, action = {device_commands.Button_22}, stop_action = {device_commands.Button_22}, arg = {320}, arg_value = {0.2}, arg_lim = {{0.0, 0.2}}, use_OBB = false, side = vr_side_BTN}
elements["PVI-DU-PTR"]			= {class = {class_type.BTN}, hint = LOCALIZE("NAV Wind Heading/Speed"), device = devices.PVI, action = {device_commands.Button_23}, stop_action = {device_commands.Button_23}, arg = {321}, arg_value = {0.2}, arg_lim = {{0.0, 0.2}}, use_OBB = false, side = vr_side_BTN}
elements["PVI-FII-PTR"]			= {class = {class_type.BTN}, hint = LOCALIZE("NAV True Heading/Time/Range to final WPT"),  device = devices.PVI, action = {device_commands.Button_24}, stop_action = {device_commands.Button_24}, arg = {322}, arg_value = {0.2}, arg_lim = {{0.0, 0.2}}, use_OBB = false, side = vr_side_BTN}
elements["PVI-ACDC-PTR"]		= {class = {class_type.BTN}, hint = LOCALIZE("NAV Bearing/Range to target"), device = devices.PVI, action = {device_commands.Button_25}, stop_action = {device_commands.Button_25}, arg = {323}, arg_value = {0.2}, arg_lim = {{0.0, 0.2}}, use_OBB = false, side = vr_side_BTN}
elements["PVI-SWITCH-PTR"]		= {class = {class_type.TUMB, class_type.TUMB}, hint  = LOCALIZE("NAV Master modes"), device = devices.PVI, action = {device_commands.Button_26, device_commands.Button_27}, arg = {324, 324}, arg_value = {-direction*0.1, direction*0.1}, arg_lim = {{0.0, 0.6}, {0.0, 0.6}}, use_OBB = false, class_vr = MULTY_TUMB, side = vr_side_LEV_TUMB, attach_left = {-130, -45}, attach_right = {100, -45}}
elements["PVI-SWITCH-PTR"].sound	= {{SOUND_SW2}, {SOUND_SW2}}
elements["PVI_I251V_PTR"]		= {class = {class_type.TUMB, class_type.TUMB}, hint = LOCALIZE("NAV INU fixtaking method"),  device = devices.PVI, action = {device_commands.Button_28,device_commands.Button_28}, arg = {325,325}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0.0, 1.0},{0.0, 1.0}}, use_OBB = false, updatable = true, side = vr_side_TUMB}
elements["PVI_VCU_PTR"]			= {class = {class_type.TUMB, class_type.TUMB}, hint = LOCALIZE("NAV Datalink power"),  device = devices.DATALINK, action = {device_commands.Button_16,device_commands.Button_16}, arg = {326,326}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0.0, 1.0},{0.0,1.0}}, use_OBB = false, updatable = true, side = vr_side_TUMB}
elements["PVI-BRIGHTNESS-PTR"]	= {class = {class_type.LEV}, hint  = LOCALIZE("NAV Brightness"),  device = devices.PVI, action = {device_commands.Button_29}, arg = {327}, arg_value = {0.001}, arg_lim = {{0.0, 1.0}}, gain = {0.1}, use_OBB = false,cycle = false, side = vr_side_LEV, attach_left = {-130, -45}, attach_right = {110, -45}}

--------------------------------------------------------------------------------
-- UV-26 CMD Control Panel (УВ-26 - Устройство Выброса ЛТЦ)
elements["UV26-BOARD-PTR"]		= {class = {class_type.TUMB, class_type.TUMB}, hint = LOCALIZE("CMD Select Left/Both/Right board flares dispensers"),  device = devices.UV_26, action = {device_commands.Button_1, device_commands.Button_2}, arg = {36, 36}, arg_value = {-direction*0.1, direction*0.1}, arg_lim = {{0, 0.2}, {0, 0.2}}, use_OBB = true, updatable = true, side = vr_side_TUMB_rev}
elements["UV26-PROGR-PTR"]		= {class = {class_type.TUMB, class_type.TUMB}, hint = LOCALIZE("CMD Amount flares counter/Programming"),  device = devices.UV_26, action = {device_commands.Button_3,device_commands.Button_3}, arg = {37,37}, arg_value = {-direction*0.1,direction*0.1}, arg_lim = {{0, 0.1},{0, 0.1}}, use_OBB = true, updatable = true, side = vr_side_TUMB_rev}
elements["UV26-SERIES-PTR"]		= {class = {class_type.BTN}, hint = LOCALIZE("CMD Num of sequences"),  device = devices.UV_26, action = {device_commands.Button_4}, stop_action = {device_commands.Button_4}, is_repeatable = {}, arg = {38}, arg_value = {1.0}, arg_lim = {{0, 1}}, use_OBB = false, side = vr_side_BTN}
elements["UV26-BURST-PTR"]		= {class = {class_type.BTN}, hint = LOCALIZE("CMD Num in sequence"),  device = devices.UV_26, action = {device_commands.Button_5}, stop_action = {device_commands.Button_5}, is_repeatable = {}, arg = {39}, arg_value = {1.0}, arg_lim = {{0, 1}}, use_OBB = false, side = vr_side_BTN}
elements["UV26-INTERVAL-PTR"]	= {class = {class_type.BTN}, hint = LOCALIZE("CMD Dispense interval"),  device = devices.UV_26, action = {device_commands.Button_6}, stop_action = {device_commands.Button_6}, is_repeatable = {}, arg = {41}, arg_value = {1.0}, arg_lim = {{0, 1}}, use_OBB = false, side = vr_side_BTN}
elements["UV26-START-PTR"]		= {class = {class_type.BTN}, hint = LOCALIZE("CMD Start dispense"),  device = devices.UV_26, action = {device_commands.Button_7}, stop_action = {device_commands.Button_7}, is_repeatable = {}, arg = {43}, arg_value = {1.0}, arg_lim = {{0, 1}}, use_OBB = false, side = vr_side_BTN}
elements["UV26-CANCELPRG-PTR"]	= {class = {class_type.BTN}, hint = LOCALIZE("CMD Reset to default program"),  device = devices.UV_26, action = {device_commands.Button_8}, stop_action = {device_commands.Button_8}, is_repeatable = {}, arg = {42}, arg_value = {1.0}, arg_lim = {{0, 1}}, use_OBB = false, side = vr_side_BTN}
elements["UV26-STOP-PTR"]		= {class = {class_type.BTN}, hint = LOCALIZE("CMD Stop dispense"),  device = devices.UV_26, action = {device_commands.Button_9}, stop_action = {device_commands.Button_9}, is_repeatable = {}, arg = {40}, arg_value = {1.0}, arg_lim = {{0, 1}}, use_OBB = false, side = vr_side_BTN}
-- UV-26 related (REAR PANEL)
elements["UV26-POWER-PTR"]		= {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("CMD Power"),  device = devices.UV_26, action = {device_commands.Button_10,device_commands.Button_10}, arg = {496,496}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0, 1.0},{0, 1.0}}, use_OBB = true, updatable = true, side = vr_side_TUMB}
elements["UV26-POWER-COVER-PTR"]= {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("CMD Power"),  device = devices.UV_26, action = {device_commands.Button_12,device_commands.Button_12}, arg = {497,497}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0, 1.0},{0, 1.0}}, use_OBB = true, updatable = true, side = vr_side_TUMB_COVER}
elements["UV26-POWER-COVER-PTR"].sound = {{SOUND_SW3_CLOSE, SOUND_SW3_OPEN}}
elements["UV26-TEST-PTR"]		= {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("CMD BIT"),  device = devices.UV_26, action = {device_commands.Button_11,device_commands.Button_11}, arg = {498,498}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0, 1.0},{0, 1.0}}, use_OBB = true, updatable = true, side = vr_side_TUMB}
elements["UV26-TEST-COVER-PTR"] = {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("CMD BIT"),  device = devices.UV_26, action = {device_commands.Button_13,device_commands.Button_13}, arg = {499,499}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0, 1.0},{0, 1.0}}, use_OBB = true, updatable = true, side = vr_side_TUMB_COVER}
elements["UV26-TEST-COVER-PTR"].sound = {{SOUND_SW3_CLOSE, SOUND_SW3_OPEN}}

--------------------------------------------------------------------------------
-- DATALINK
-- Datalink Control Panel
elements["PRC-SEND-PTR"]		= {class = {class_type.BTN}, hint = LOCALIZE("DLNK Send/Memory"),			device = devices.DATALINK, action = {device_commands.Button_1}, stop_action = {device_commands.Button_1}, arg = {159}, arg_value = {0.2}, arg_lim = {{0, 0.2}}, use_release_message = {true}, side = vr_side_BTN}
elements["PRC-ESCAPE-PTR"]		= {class = {class_type.BTN}, hint = LOCALIZE("DLNK Ingress to target"),	device = devices.DATALINK, action = {device_commands.Button_2}, stop_action = {device_commands.Button_2}, arg = {150}, arg_value = {0.2}, arg_lim = {{0, 0.2}}, side = vr_side_BTN}
elements["PRC-ERASE-PTR"]		= {class = {class_type.BTN}, hint = LOCALIZE("DLNK Erase"),				device = devices.DATALINK, action = {device_commands.Button_3}, stop_action = {device_commands.Button_3}, arg = {161}, arg_value = {0.2}, arg_lim = {{0, 0.2}}, use_release_message = {true}, side = vr_side_BTN}
elements["PRC-CLEAN-PTR"]		= {class = {class_type.BTN}, hint = LOCALIZE("N/A"),						device = devices.DATALINK, action = {device_commands.Button_4}, stop_action = {device_commands.Button_4}, arg = {15}, arg_value = {0.2}, arg_lim = {{0, 0.2}}, side = vr_side_BTN}
elements["PRC-WINGMAN-ALL-PTR"]	= {class = {class_type.BTN}, hint = LOCALIZE("DLNK to ALL"),				device = devices.DATALINK, action = {device_commands.Button_5}, stop_action = {device_commands.Button_5}, arg = {16}, arg_value = {0.2}, arg_lim = {{0, 0.2}}, side = vr_side_BTN}
elements["PRC-WINGMAN-1-PTR"]	= {class = {class_type.BTN}, hint = LOCALIZE("DLNK to Wingman 1"),		device = devices.DATALINK, action = {device_commands.Button_6}, stop_action = {device_commands.Button_6}, arg = {17}, arg_value = {0.2}, arg_lim = {{0, 0.2}}, side = vr_side_BTN}
elements["PRC-WINGMAN-2-PTR"]	= {class = {class_type.BTN}, hint = LOCALIZE("DLNK to Wingman 2"),		device = devices.DATALINK, action = {device_commands.Button_7}, stop_action = {device_commands.Button_7}, arg = {18}, arg_value = {0.2}, arg_lim = {{0, 0.2}}, side = vr_side_BTN}
elements["PRC-WINGMAN-3-PTR"]	= {class = {class_type.BTN}, hint = LOCALIZE("DLNK to Wingman 3"),		device = devices.DATALINK, action = {device_commands.Button_8}, stop_action = {device_commands.Button_8}, arg = {19}, arg_value = {0.2}, arg_lim = {{0, 0.2}}, side = vr_side_BTN}
elements["PRC-WINGMAN-4-PTR"]	= {class = {class_type.BTN}, hint = LOCALIZE("DLNK to Wingman 4"),		device = devices.DATALINK, action = {device_commands.Button_9}, stop_action = {device_commands.Button_9}, arg = {20}, arg_value = {0.2}, arg_lim = {{0, 0.2}}, side = vr_side_BTN}
elements["PRC-TARGET-1-PTR"]	= {class = {class_type.BTN}, hint = LOCALIZE("DLNK Target #1/Vehicle"),	device = devices.DATALINK, action = {device_commands.Button_10}, stop_action = {device_commands.Button_10}, arg = {21}, arg_value = {0.2}, arg_lim = {{0, 0.2}}, side = vr_side_BTN}
elements["PRC-TARGET-2-PTR"]	= {class = {class_type.BTN}, hint = LOCALIZE("DLNK Target #2/SAM"),		device = devices.DATALINK, action = {device_commands.Button_11}, stop_action = {device_commands.Button_11}, arg = {22}, arg_value = {0.2}, arg_lim = {{0, 0.2}}, side = vr_side_BTN}
elements["PRC-TARGET-3-PTR"]	= {class = {class_type.BTN}, hint = LOCALIZE("DLNK Target #3/Other Type"), device = devices.DATALINK, action = {device_commands.Button_12}, stop_action = {device_commands.Button_12}, arg = {23}, arg_value = {0.2}, arg_lim = {{0, 0.2}}, side = vr_side_BTN}
elements["PRC-TARGET-POINT-PTR"]= {class = {class_type.BTN}, hint = LOCALIZE("DLNK Ingress point"),		device = devices.DATALINK, action = {device_commands.Button_13}, stop_action = {device_commands.Button_13}, arg = {50}, arg_value = {0.2}, arg_lim = {{0, 0.2}}, side = vr_side_BTN}
-- Datalink Mode Controls
elements["DTLK-SELF-ID-PTR"]	= {class = {class_type.TUMB, class_type.TUMB}, hint = LOCALIZE("Datalink self ID"), device = devices.DATALINK, action = {device_commands.Button_14, device_commands.Button_14}, arg = {328, 328}, arg_value = {-direction*0.1, direction*0.1}, arg_lim = {{0.0, 0.3}, {0.0, 0.3}}, class_vr = MULTY_TUMB, side = vr_side_LEV_TUMB, attach_left = {-130, -45}, attach_right = {110, -45}}
elements["DTLK-SELF-ID-PTR"].sound	= {{SOUND_SW2}}
elements["DTLK-MASTER-MODES-PTR"]	= {class = {class_type.TUMB, class_type.TUMB}, hint = LOCALIZE("Datalink Master mode"), device = devices.DATALINK, action = {device_commands.Button_15, device_commands.Button_15}, arg = {329, 329}, arg_value = {-direction*0.1, direction*0.1}, arg_lim = {{0.0, 0.3}, {0.0, 0.3}}, class_vr = MULTY_TUMB, side = vr_side_LEV_TUMB, attach_left = {-130, -45}, attach_right = {120, -45}}
elements["DTLK-MASTER-MODES-PTR"].sound	= {{SOUND_SW2}}

--------------------------------------------------------------------------------
-- PUI-800 Weapons Control Panel (ПУИ-800 Пульт Управления и Индикации)
elements["MASTER-ARM-PTR"]			= {class = {class_type.TUMB, class_type.TUMB}, hint = LOCALIZE("Master Arm"),  				 device = devices.WEAP_INTERFACE, action = {device_commands.Button_1,device_commands.Button_1}, stop_action = {}, arg = {387,387}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0.0, 1.0},{0.0, 1.0}}, use_OBB = true, updatable = true, side = vr_side_TUMB}
elements["PUI800-AVARSTART-PTR"]	= {class = {class_type.BTN},  hint = LOCALIZE("Not implemented"), 							 device = devices.WEAP_INTERFACE, action = {device_commands.Button_2}, stop_action = {device_commands.Button_2}, is_repeatable = {}, arg = {401}, arg_value = {1.0}, arg_lim = {{0.0, 1.0}} , side = vr_side_BTN}
elements["PUI800-AVARCHOP-PTR"]		= {class = {class_type.BTN},  hint = LOCALIZE("External stores jettison"),  							 device = devices.WEAP_INTERFACE, action = {device_commands.Button_3}, stop_action = {device_commands.Button_3}, is_repeatable = {}, arg = {402}, arg_value = {1.0}, arg_lim = {{0.0, 1.0}} , side = vr_side_BTN}
elements["MASTER-EXPLODE-PTR"]		= {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("Jettison arm mode - arm fuse/disarm fuse"),  							 device = devices.WEAP_INTERFACE, action = {device_commands.Button_22,device_commands.Button_22}, stop_action = {}, arg = {396,396}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0.0, 1.0},{0.0, 1.0}}, use_OBB = true, updatable = true, side = vr_side_TUMB}
elements["PUI800-AUTO-PTR"]			= {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("Manual/Auto weapon system control switch"),  							 device = devices.WEAP_INTERFACE, action = {device_commands.Button_5,device_commands.Button_5}, stop_action = {}, arg = {403,403}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0.0, 1.0},{0.0, 1.0}}, use_OBB = true, updatable = true, side = vr_side_TUMB}
elements["PUI800-OFBR-PTR"]			= {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("Cannon round selector switch HE/AP"),  device = devices.WEAP_INTERFACE, action = {device_commands.Button_6,device_commands.Button_6}, stop_action = {}, arg = {399,399}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0.0, 1.0},{0.0, 1.0}}, use_OBB = true, updatable = true, side = vr_side_TUMB}
elements["SR-PTR"]					= {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("Weapon mode switch - Burst Length"),  				 device = devices.WEAP_INTERFACE, action = {device_commands.Button_4,device_commands.Button_4} , stop_action = {}, arg = {400,400}, arg_value = {-direction*0.1,direction*0.1}, arg_lim = {{0.0, 0.2},{0.0, 0.2}}, use_OBB = true, updatable = true, side = vr_side_TUMB}
elements["MT-PTR"]					= {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("Cannon rate of fire setting"),  				     device = devices.WEAP_INTERFACE, action = {device_commands.Button_20,device_commands.Button_20}, stop_action = {}, arg = {398,398}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0.0, 1.0},{0.0, 1.0}}, use_OBB = true, updatable = true, side = vr_side_TUMB}
elements["MASTER-UNLOAD-PTR"]       = {class = {class_type.BTN} , hint = LOCALIZE("Expedite emergency ATGM launch"),  							 device = devices.WEAP_INTERFACE, action = {device_commands.Button_21}, stop_action = {device_commands.Button_21}, arg = {397}, arg_value = {1.0}, arg_lim = {{0.0, 1.0}}, use_release_message = {true}, use_OBB = true, updatable = true, side = {{BOX_SIDE_Z_bottom}}}

--------------------------------------------------------------------------------
-- PUR Weapons Aux Panel (ПУР Пульт Управления Режимом)
-- SHKVAL
elements["PUR-BACKGROUND-PTR"]	= {class = {class_type.TUMB, class_type.TUMB}, hint = LOCALIZE("IT-23 Black-White indication switch"), device = devices.SHKVAL, action = {device_commands.Button_1,device_commands.Button_1}, stop_action = {}, arg = {404,404}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0.0, 1.0},{0.0, 1.0}}, use_OBB = true, updatable = true, side = vr_side_TUMB_rev}
elements["PUR-LIGHTIT-PTR"]		= {class = {class_type.LEV}, hint = LOCALIZE("IT-23 display brightness"), device = devices.SHKVAL, action = {device_commands.Button_2}, arg = {406}, arg_value = {0.05}, arg_lim = {{0.0, 1.0}},gain = {0.1},cycle = false, side = vr_side_LEV}
elements["PUR-CONTRAST-PTR"]	= {class = {class_type.LEV}, hint = LOCALIZE("IT-23 display contrast"), device = devices.SHKVAL, action = {device_commands.Button_3}, arg = {407}, arg_value = {0.05}, arg_lim = {{0.0, 1.0}},gain = {0.1},cycle = false, side = vr_side_LEV}
elements["PUR-TR-PTR"]			= {class = {class_type.TUMB, class_type.TUMB}, hint = LOCALIZE("N/A"), device = devices.SHKVAL, action = {device_commands.Button_4,device_commands.Button_4}, stop_action = {}, arg = {410,410}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0.0, 1.0},{0.0, 1.0}}, use_OBB = true, updatable = true, side = vr_side_TUMB}
elements["PUR-SF-PTR"]			= {class = {class_type.TUMB, class_type.TUMB}, hint = LOCALIZE("SHKVAL Optics adjustment"), device = devices.SHKVAL, action = {device_commands.Button_5, device_commands.Button_5}, arg = {411, 411}, arg_value = {-direction*0.1, direction*0.1}, arg_lim = {{0.0, 0.7}, {0.0, 0.7}}, class_vr = MULTY_TUMB, side = vr_side_LEV_TUMB}
elements["PUR-SF-PTR"].sound	= {{SOUND_SW2}}
-- HELMET
elements["PUR-LIGHTNVU-PTR"]	= { class = {class_type.LEV}, hint = LOCALIZE("Helmet device brightness"), device = devices.HELMET, action = {device_commands.Button_1}, arg = {405}, arg_value = {0.05}, arg_lim = {{0.0, 1.0}}, gain = {0.1},cycle = false, side = vr_side_LEV}
-- WEAPON SYSTEM
elements["PUR-LIT-PTR"]			= {class = {class_type.TUMB, class_type.TUMB}, hint = LOCALIZE("Laser code selector"), device = devices.WEAP_INTERFACE, action = {device_commands.Button_7,device_commands.Button_7}, arg = {408, 408}, arg_value = {-direction*0.1, direction*0.1}, arg_lim = {{0.0, 0.2}, {0.0, 0.2}}, class_vr = MULTY_TUMB, side = vr_side_LEV_TUMB}
elements["PUR-LIT-PTR"].sound	= {{SOUND_SW2}}
-- MISC
elements["PUR-OGR-INF-PTR"]		= {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("HUD/TV declutter switch"),  device = devices.MISC_SYSTEMS_INTERFACE, action = {device_commands.Button_1,device_commands.Button_1}, stop_action = {}, arg = {409,409}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0.0, 1.0},{0.0, 1.0}}, use_OBB = true, updatable = true, side = vr_side_TUMB}

elements["ALTIMETER-BARO-PTR"]	= { class = {class_type.LEV}, hint = LOCALIZE("Baro pressure QFE knob"), device = devices.MISC_SYSTEMS_INTERFACE, action = {device_commands.Button_5}, arg = {90}, arg_value = {0.001}, arg_lim = {{0, 1}}, relative = {false}, gain = {0.01} ,cycle = false, side = vr_side_LEV}

--------------------------------------------------------------------------------
-- Auxiliary panel - Preflight Set and Check Panel (ППК - Пульт Подготовки и Контроля)
elements["PPK-BBTZ-PTR"]		= {class = {class_type.TUMB, class_type.TUMB}, hint = LOCALIZE("ATGM Temperature selector"), device = devices.PPK, action = {device_commands.Button_1, device_commands.Button_1}, arg = {483, 483}, arg_value = {-direction*0.1, direction*0.1}, arg_lim = {{0, 1.0}, {0, 1.0}}, class_vr = MULTY_TUMB, side = vr_side_LEV_TUMB, attach_left = {90, -45}, attach_right = {-90, -45}}
elements["PPK-BBTZ-PTR"].sound	= {{SOUND_SW2}}
elements["PPK-NRAKS-PTR"]		= {class = {class_type.TUMB, class_type.TUMB}, hint = LOCALIZE("Unguided rocket and gun pods ballistics data settings selector"), device = devices.WEAP_INTERFACE, action = {device_commands.Button_23, device_commands.Button_23}, arg = {484, 484}, arg_value = {-direction*0.1, direction*0.1},cycle = false, arg_lim = {{0, 1.0}, {0, 1.0}}, class_vr = MULTY_TUMB, side = vr_side_LEV_TUMB, attach_left = {90, -45}, attach_right = {-90, -45}}
elements["PPK-NRAKS-PTR"].sound	= {{SOUND_SW2}}
elements["PPK-RNP-PTR"]			= {class = {class_type.TUMB, class_type.TUMB}, hint = LOCALIZE("Systems BIT selector"), device = devices.PPK, action = {device_commands.Button_3, device_commands.Button_3}, arg = {485, 485}, arg_value = {-direction*0.1, direction*0.1}, arg_lim = {{0, 0.8}, {0, 0.8}}, class_vr = MULTY_TUMB, side = vr_side_LEV_TUMB, attach_left = {90, -45}, attach_right = {-90, -45}}
elements["PPK-RNP-PTR"].sound	= {{SOUND_SW2}}
elements["KCVM-PTR"]			= {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("Control computers BIT switch"),  device = devices.PPK, action = {device_commands.Button_4,device_commands.Button_4}, arg = {486,486}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0, 1},{0, 1}}, use_OBB = true, updatable = true, side = vr_side_TUMB}
elements["AKS-PTR"]				= {class = {class_type.BTN} , hint = LOCALIZE("Self test system push-button"), device = devices.PPK, action = {device_commands.Button_7}, stop_action = {device_commands.Button_7}, is_repeatable = {}, arg = {489}, arg_value = {1.0}, arg_lim = {{0, 1}}, side = vr_side_BTN}
elements["VnK-PTR"]				= {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("Emergency INU alignment switch"),  device = devices.PPK, action = {device_commands.Button_8,device_commands.Button_8}, arg = {490,490}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0, 1},{0, 1}}, use_OBB = true, updatable = true, side = vr_side_TUMB}
elements["ROPE-PTR"]			= {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("Stabilisation and indication of hanger cable switch"),  device = devices.PPK, action = {device_commands.Button_9,device_commands.Button_9}, arg = {491,491}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0, 1},{0, 1}}, use_OBB = true, updatable = true, side = vr_side_TUMB}
elements["FKP-PTR"]				= {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("Video Tape Recorder switch"),  device = devices.PPK, action = {device_commands.Button_10,device_commands.Button_10}, arg = {492,492}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0, 1},{0, 1}}, use_OBB = true, updatable = true, side = vr_side_TUMB}

elements["IKV-PTR"]				= {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("INU Power switch"),  device = devices.C061K, action = {device_commands.Button_1, device_commands.Button_1}, arg = {487,487}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0, 1},{0, 1}}, use_OBB = true, updatable = true, side = vr_side_TUMB}
elements["HEAT_IKV-PTR"]		= {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("INU Heater switch"),  device = devices.C061K, action = {device_commands.Button_2, device_commands.Button_2}, arg = {488,488}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0, 1},{0, 1}}, use_OBB = true, updatable = true, side = vr_side_TUMB}

elements["P-CONTR-VMG-HYDRO-PTR"]		= {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("Power plant, hydraulics, EKRAN self-test systems switch"), device = devices.CPT_MECH, action = {device_commands.Button_2,device_commands.Button_2}, arg = {452,452}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0, 1.0},{0, 1.0}}, use_OBB = true, updatable = true, side = vr_side_TUMB}
elements["P-CONTR-VMG-HYDRO-COVER-PTR"]	= {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("Power plant, hydraulics, EKRAN self-test systems switch"), device = devices.CPT_MECH, action = {device_commands.Button_3,device_commands.Button_3}, arg = {453,453}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0, 1.0},{0, 1.0}}, use_OBB = true, updatable = true , side = vr_side_TUMB_COVER}
elements["P-CONTR-VMG-HYDRO-COVER-PTR"].sound = {{SOUND_SW3_CLOSE, SOUND_SW3_OPEN}}

--------------------------------------------------------------------------------
-- PPR - Autopilot Control Panel (ППР - Пульт Пилотажных Режимов)
-- AUTOPILOT
elements["PPR-K-PTR01"]			= {class = {class_type.BTN}, hint = LOCALIZE("Autopilot Bank hold"),  device = devices.AUTOPILOT, action = {device_commands.Button_1}, stop_action = {device_commands.Button_1}, is_repeatable = {}, arg = {330}, arg_value = {1.0}, arg_lim = {{0, 1}}, side = vr_side_BTN}
elements["PPR-N-PTR03"]			= {class = {class_type.BTN}, hint = LOCALIZE("Autopilot Heading hold"),  device = devices.AUTOPILOT, action = {device_commands.Button_2}, stop_action = {device_commands.Button_2}, is_repeatable = {}, arg = {332}, arg_value = {1.0}, arg_lim = {{0, 1}}, side = vr_side_BTN}
elements["PPR-T-PTR02"]			= {class = {class_type.BTN}, hint = LOCALIZE("Autopilot Pitch hold"),  device = devices.AUTOPILOT, action = {device_commands.Button_3}, stop_action = {device_commands.Button_3}, is_repeatable = {}, arg = {331}, arg_value = {1.0}, arg_lim = {{0, 1}}, side = vr_side_BTN}
elements["PPR-V-PTR04"]			= {class = {class_type.BTN}, hint = LOCALIZE("Autopilot Altitude hold"),  device = devices.AUTOPILOT, action = {device_commands.Button_4}, stop_action = {device_commands.Button_4}, is_repeatable = {}, arg = {333}, arg_value = {1.0}, arg_lim = {{0, 1}}, side = vr_side_BTN}
elements["PPR-DIRUPR-PTR05"]	= {class = {class_type.BTN}, hint = LOCALIZE("Autopilot Director control"),  device = devices.AUTOPILOT, action = {device_commands.Button_5}, stop_action = {device_commands.Button_5}, is_repeatable = {}, arg = {334}, arg_value = {1.0}, arg_lim = {{0, 1}}, side = vr_side_BTN}
elements["BAR-RV-PTR"]			= {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("Autopilot BARO/RALT altitude hold mode"),  device = devices.AUTOPILOT, action = {device_commands.Button_6,device_commands.Button_6}, stop_action = {}, arg = {335,335},cycle = false, arg_value = {-direction*0.5,direction*0.5}, arg_lim = {{0.0, 1.0},{0.0, 1.0}}, use_OBB = true, updatable = true, side = vr_side_TUMB_rev}
-- NAV SYSTEM
elements["ZK-LZP-PTR"]			= {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("Autopilot Desired heading - Desired track"),  device = devices.NAV_INTERFACE, action = {device_commands.Button_3,device_commands.Button_3}, stop_action = {}, arg = {336,336}, arg_value = { -direction*0.5,direction*0.5}, arg_lim = {{0.0, 1.0},{0.0, 1.0}}, use_OBB = true, updatable = true, side = vr_side_TUMB_rev}

--------------------------------------------------------------------------------
-- CLOCK (часы)
elements["CLOCK-LEFT-LEVER-PTR"] = { class = {class_type.BTN, class_type.BTN, class_type.LEV}, hint = LOCALIZE("Mech clock left lever"), device = devices.CLOCK, action = {device_commands.Button_1, device_commands.Button_2, device_commands.Button_3}, stop_action = {device_commands.Button_1, device_commands.Button_2, 0}, is_repeatable = {}, arg = {76, 76, 511}, arg_value = {1.0, -1.0, 0.04}, arg_lim = {{0, 1}, {-1, 0}, {0, 1}}, relative = {false,false,true}, gain = {1.0, 1.0, 0.4}, use_release_message = {true, true, false}, use_OBB = true, side = vr_side_CLOCK_LEV, attach_left = {0, -110} }
elements["CLOCK-LEFT-LEVER-PTR"].sound = {{SOUND_SW9_OFF, SOUND_SW9_ON}, {SOUND_SW9_OFF, SOUND_SW9_ON}, {SOUND_SW9_ROTATE_1}}
elements["CLOCK-RIGHT-LEVER-PTR"] = { class = {class_type.BTN, class_type.LEV}, hint = LOCALIZE("Mech clock right lever"), device = devices.CLOCK, action = {device_commands.Button_4, device_commands.Button_5}, stop_action = {device_commands.Button_4, 0}, is_repeatable = {}, arg = {77, 525}, arg_value = {1.0, 0.05}, arg_lim = {{0, 1}, {-0.15, 0.15}}--[[, relative = {0, 1}--]], gain = {1.0, 1.2}, use_release_message = {true, false}, use_OBB = true, class_vr = {class_type.BTN_FIX,class_type.LEV}, side = vr_side_BTN_LEV, attach_left = {0, -110}}
elements["CLOCK-RIGHT-LEVER-PTR"].sound = {{SOUND_SW9_ON, SOUND_SW9_OFF}, {SOUND_SW9_ROTATE_2}}

--------------------------------------------------------------------------------
-- OVERHEAD PANEL
elements["ANO-PTR"]  			  = {
	class = {class_type.TUMB,class_type.BTN}, 
	hint = LOCALIZE("Navigation Lights 10\% / 30\% / 100\% / Off"),
	device = devices.NAVLIGHT_SYSTEM, 
	action = {device_commands.Button_4,device_commands.Button_5,device_commands.Button_4,device_commands.Button_4},  
	stop_action = {0,device_commands.Button_4,0,0},
	arg = {146,146,146,146}, 
	arg_value = {0.1,0.4,0.2,0.3}, 
	arg_lim = {{0, 0.3},{0, 0.4},{0, 0.2},{0, 0.3}}, 
	use_release_message = {false,true,false,false}, 
	use_OBB = true, 
	updatable = true, 
	class_vr = {class_type.TUMB_4SIDE,class_type.TUMB_4SIDE,class_type.TUMB_4SIDE,class_type.TUMB_4SIDE},
	side = {{BOX_SIDE_X_top}, {BOX_SIDE_Z_bottom}, {BOX_SIDE_X_bottom}, {BOX_SIDE_Z_top} }
}

elements["WINDSCREEN-WIPER-PTR"]  = {
	class = {class_type.TUMB,class_type.BTN}, 
	hint = LOCALIZE("Windshield wiper switch"), 
	device = devices.CPT_MECH, 
	action = {device_commands.Button_6, device_commands.Button_7,device_commands.Button_6,device_commands.Button_6}, 
	stop_action = {0, device_commands.Button_7,0,0}, 
	arg = {147,147,147,147}, 
	arg_value = {0.1,0.4,0.2,0.3}, 
	arg_lim = {{0.0, 0.3}, {0.0, 0.4},{0.0, 0.2},{0.0, 0.3}}, 
	use_release_message = {false,true,false,false}, 
	use_OBB = true, 
	updatable = true,
	class_vr = {class_type.TUMB_4SIDE,class_type.TUMB_4SIDE,class_type.TUMB_4SIDE,class_type.TUMB_4SIDE},
	side = {{BOX_SIDE_Z_top}, {BOX_SIDE_Z_bottom}, {BOX_SIDE_X_top}, {BOX_SIDE_X_bottom} }
}
	
elements["FEEDING-OZH-PTR"]		= {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("Windshield washer fluid switch"),  device = 0, action = {device_commands.Button_8,device_commands.Button_8}, arg = {148,148}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0, 1},{0, 1}}, use_OBB = true, updatable = true,cycle = false, side = vr_side_TUMB}
elements["BRIGHTNESS-PTR"]		= {class = {class_type.LEV}, hint = LOCALIZE("Brightness"),  device = 0, action = {device_commands.Button_9},arg = {126}, arg_value = {0.04}, arg_lim = {{0, 1}}, side = vr_side_LEV}
elements["PPD-DUAS-PTR"]		= {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("Pitot static port and AoA sensors heat switch"),  device = devices.CPT_MECH, action = {device_commands.Button_8, device_commands.Button_8}, arg = {539,539}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0, 1},{0, 1}}, use_OBB = true, updatable = true, side = vr_side_TUMB}
elements["PVD-CLOCK-PTR"]		= {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("Pitot ram air and clock heat switch"),  device = devices.CPT_MECH, action = {device_commands.Button_9, device_commands.Button_9}, arg = {151,151}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0, 1},{0, 1}}, use_OBB = true, updatable = true, side = vr_side_TUMB}
elements["POS-ROTORS-PTR"]      = {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("Rotor de-icing system switch"), device = devices.ENGINE_INTERFACE, action = {device_commands.Button_13,device_commands.Button_13}, arg = {153,153}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0.0, 1.0}, {0.0, 1.0}}, use_OBB = true, updatable = true, side = vr_side_TUMB}
elements["POS-ENGINE-PZU-PTR"]  = {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("Engines de-icing / dust-protection systems switch"), device = devices.ENGINE_INTERFACE, action = {device_commands.Button_14,device_commands.Button_14}, arg = {154,154}, arg_value = {-direction*0.5,direction*0.5}, arg_lim = {{0.0, 1.0}, {0.0, 1.0}}, use_OBB = true, updatable = true, side = vr_side_TUMB}
elements["KONTR-PVD-PTR"]		= {class = {class_type.BTN}, hint = LOCALIZE("Pitot heat system test"),  device = devices.CPT_MECH, action = {device_commands.Button_10}, stop_action = {device_commands.Button_10}, arg = {156}, arg_value = {1.0}, arg_lim = {{0, 1}}, use_OBB = true, updatable = false, use_release_message = {true}, side = vr_side_BTN}

--------------------------------------------------------------------------------
-- HSI (ПНП)
elements["ROTARY-ZPU-PTR"]		= { class = {class_type.LEV}, hint = LOCALIZE("HSI Commanded course rotary"), device = devices.HSI, action = {device_commands.Button_1}, stop_action = {0}, is_repeatable = {}, arg = {126}, arg_value = {0.001}, arg_lim = {{0, 1}}, relative = {true}, gain = {0.1} , side = vr_side_LEV}
elements["ROTARY-ZK-PTR"]		= { class = {class_type.LEV}, hint = LOCALIZE("HSI Commanded heading rotary"), device = devices.HSI, action = {device_commands.Button_2}, stop_action = {0}, is_repeatable = {}, arg = {129}, arg_value = {0.001}, arg_lim = {{0, 1}}, relative = {true}, gain = {0.1} , side = vr_side_LEV}
elements["TEST-PNP-PTR03"]		= { class = {class_type.BTN}, hint = LOCALIZE("HSI test"), device = devices.HSI, action = {device_commands.Button_3}, stop_action = {device_commands.Button_3}, is_repeatable = {}, arg = {113}, arg_value = {1.0}, arg_lim = {{0, 1}}, use_release_message = {true} , side = vr_side_BTN}
-- HSI related
elements["ZPU-ZK-PTR"]			= { class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("HSI Desired track angle - Desired heading, Auto - Manual"),  device = devices.HSI, action = {device_commands.Button_4,device_commands.Button_4}, arg = {54,54}, arg_value =  {-direction*1.0,direction*1.0}, arg_lim = {{0, 1},{0, 1}}, use_OBB = true, updatable = true, side = vr_side_TUMB}

--------------------------------------------------------------------------------
-- ADI (ИКП)
elements["IKP-TANGAGE-PTR"]		= { class = {class_type.LEV}, hint = LOCALIZE("ADI Zero pitch trim"), device = devices.ADI, action = {device_commands.Button_1}, arg = {105}, arg_value = {0.002}, arg_lim = {{-1, 1}}, cycle = true, gain = {0.2}, side = vr_side_LEV, attach_right = {80, -45}}
--elements["PTR_HUD-BRIGHTNESS"]  = { class = {class_type.LEV}, hint = LOCALIZE("HUD Brightness"), device = devices.HUD, action = {device_commands.Button_1}, arg = {8}, arg_value = {0.05}, arg_lim = {{0.0, 1.0}} , side = vr_side_LEV}

elements["TEST-COVER-IKP-PTR"]	= { class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("ADI Test"), device = devices.ADI, action = {device_commands.Button_2,device_commands.Button_2}, arg = {550,550}, arg_value = {direction*1.0,-direction*1.0}, arg_lim = {{0, 1.0},{0, 1.0}}, use_OBB = true, updatable = true , side = {{BOX_SIDE_Y_bottom},{BOX_SIDE_Z_top}}}
elements["TEST-IKP-PTR"]		= { class = {class_type.BTN}, hint = LOCALIZE("ADI Test"), device = devices.ADI, action = {device_commands.Button_3}, stop_action = {device_commands.Button_3}, is_repeatable = {}, arg = {110}, arg_value = {1.0}, arg_lim = {{0, 1}}, use_release_message = {true} , side = vr_side_BTN}

--------------------------------------------------------------------------------
-- STANDBY ADI (AGR-81)
elements["RES-AGD-PTR"] = { class = {class_type.BTN, class_type.BTN, class_type.LEV}, hint = LOCALIZE("Standby Attitude Indicator Cage/control test handle"), device = devices.STBY_ADI, action = {device_commands.Button_1, device_commands.Button_2, device_commands.Button_3}, stop_action = {device_commands.Button_1, device_commands.Button_2, 0}, is_repeatable = {}, arg = {141, 141, 597}, arg_value = {1.0, -1.0, 1.0}, arg_lim = {{0, 1}, {-1, 0}, {0, 1}}, relative = {false,false,true}, gain = {1.0, 1.0, 0.2}, use_release_message = {true, true, false}, use_OBB = true , side = vr_side_CLOCK_LEV, attach_right = {80, -45}}
elements["RES-AG-PTR"]	= { class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("Standby Attitude Indicator power switch"), device = devices.STBY_ADI, action = {device_commands.Button_4,device_commands.Button_4}, arg = {230,230}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0, 1},{0, 1}}, use_OBB = true, updatable = true , side = vr_side_TUMB}


--------------------------------------------------------------------------------
-- RADIOALTIMETER
elements["ROTARY-DANGEROUS-HIGHT-PTR"] = { class = {class_type.LEV}, hint = LOCALIZE("Dangerous RALT set rotary"), device = devices.RADAR_ALTIMETER, action = {device_commands.Button_1}, arg = {91}, arg_value = {0.1}, arg_lim = {{0, 1}}, relative = {true}, gain = {0.1} , side = vr_side_LEV}
elements["TEST-RADIO-HIGHT-PTR"]	   = { class = {class_type.BTN}, hint = LOCALIZE("Radar altimeter test"), device = devices.RADAR_ALTIMETER, action = {device_commands.Button_2}, stop_action = {device_commands.Button_2}, is_repeatable = {}, arg = {96}, arg_value = {1.0}, arg_lim = {{0, 1}}, use_release_message = {true} , side = vr_side_BTN}

--------------------------------------------------------------------------------
-- PVR (ПВР - Пульт Выбора Режимов К-041)
-- WEAPONS
elements["PVR-DRILL-PTR"]		= { class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("Training mode"),						device = devices.WEAP_INTERFACE, action = {device_commands.Button_9,device_commands.Button_9},  arg = {432,432}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0.0, 1.0},{0.0, 1.0}}, use_OBB = true, updatable = true, side = vr_side_TUMB}
elements["PVR-ADV-PTR"]			= { class = {class_type.BTN}, hint = LOCALIZE("Automatic turn on target mode"),						device = devices.WEAP_INTERFACE, action = {device_commands.Button_10}, stop_action = {device_commands.Button_10}, arg = {437}, arg_value = {1.0}, arg_lim = {{0.0, 1.0}}, side = vr_side_BTN}
elements["PVR-VC-PTR"]			= { class = {class_type.BTN}, hint = LOCALIZE("Airborne Target"),							device = devices.WEAP_INTERFACE, action = {device_commands.Button_11}, stop_action = {device_commands.Button_11}, arg = {438}, arg_value = {1.0}, arg_lim = {{0.0, 1.0}}, side = vr_side_BTN}
elements["PVR-PPS-PTR"]			= { class = {class_type.BTN}, hint = LOCALIZE("Forward hemisphere (head-on) air target aspect"),					device = devices.WEAP_INTERFACE, action = {device_commands.Button_12}, stop_action = {device_commands.Button_12},  arg = {439}, arg_value = {1.0}, arg_lim = {{0.0, 1.0}}, side = vr_side_BTN}
elements["PVR-NPC-PTR"]			= { class = {class_type.BTN}, hint = LOCALIZE("Ground moving target"),					device = devices.WEAP_INTERFACE, action = {device_commands.Button_13}, stop_action = {device_commands.Button_13},  arg = {440}, arg_value = {1.0}, arg_lim = {{0.0, 1.0}}, side = vr_side_BTN}
elements["PVR-MODE-PTR"]		= { class = {class_type.TUMB, class_type.TUMB}, hint = LOCALIZE("Weapon system mode selector"),				device = devices.WEAP_INTERFACE, action = {device_commands.Button_14, device_commands.Button_15},  arg = {431, 431}, arg_value = {-direction*0.1, direction*0.1}, arg_lim = {{0.0, 0.4}, {0.0, 0.4}}, class_vr = MULTY_TUMB, side = vr_side_LEV_TUMB, attach_left = {0, -110}}
elements["PVR-MODE-PTR"].sound	= {{SOUND_SW2}, {SOUND_SW2}}
elements["PVR-RESET-PTR"]		= { class = {class_type.BTN} , hint = LOCALIZE("Targeting mode reset"),								device = devices.WEAP_INTERFACE, action = {device_commands.Button_16}, stop_action = {device_commands.Button_16}, is_repeatable = {}, arg = {441}, arg_value = {1.0}, arg_lim = {{0.0, 1.0}}, use_release_message = {true} , side = vr_side_BTN}
elements["PVR-AS-PM-PTR"]		= { class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("Automatic Tracking / gun sight"),	device = devices.WEAP_INTERFACE, action = {device_commands.Button_17,device_commands.Button_17}, arg = {436,436}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0.0, 1.0},{0.0, 1.0}}, use_OBB = true, updatable = true, side = vr_side_TUMB}
elements["PVR-AS-PM-PTR"].sound	= {{SOUND_SW1}}
-- K041
elements["K-041-PTR"]			= { class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("K-041 Targeting-navigation system power switch"),						device = devices.K041, action = {device_commands.Button_2,device_commands.Button_2},  arg = {433,433}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0.0, 1.0},{0.0, 1.0}}, use_OBB = true, updatable = true, side = vr_side_TUMB}
-- LASERRANGER
elements["PVR-IZL-PTR"]			= { class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("Laser standby ON/OFF switch"),				device = devices.LASERRANGER   , action = {device_commands.Button_1,device_commands.Button_1}, arg = {435,435}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0, 1},{0, 1}}, use_OBB = true, updatable = true, side = vr_side_TUMB}
-- HELMET
elements["PVR-OBZ-PTR"]			= { class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("Helmet-mounted sight system power switch"),						device = devices.HELMET        , action = {device_commands.Button_2,device_commands.Button_2}, arg = {434,434}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0, 1},{0, 1}}, use_OBB = true, updatable = true, side = vr_side_TUMB}
elements["PVR-OBZ-PTR"].sound	= {{SOUND_SW1}}

-- SHKVAL
elements["V-SCAN-PTR"]			= { class = {class_type.TUMB, class_type.TUMB}, hint = LOCALIZE("Shkval scan rate"), device = devices.SHKVAL, action = {device_commands.Button_6, device_commands.Button_6}, arg = {301, 301}, arg_value = {-direction*0.1, direction*0.1}, arg_lim = {{0, 0.7},{0, 0.7}} , class_vr = MULTY_TUMB, side = vr_side_LEV_TUMB, attach_left = {-130, -45}, attach_right = {110, -45}}
elements["V-SCAN-PTR"].sound	= {{SOUND_SW2}}

--------------------------------------------------------------------------------

--laser ranger ( front panel)
elements["LD-LDP-COVER-PTR"]		= { class = {class_type.TUMB, class_type.TUMB}, hint = LOCALIZE("Laser rangefinder / designator - mode switch"),device = devices.LASERRANGER   , action = {device_commands.Button_2,device_commands.Button_2}, arg = {57,57}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0, 1},{0, 1}}, use_OBB = true, updatable = true, side = vr_side_TUMB_COVER}
elements["LD-LDP-COVER-PTR"].sound = {{SOUND_SW3_CLOSE, SOUND_SW3_OPEN}}
elements["LDP-LD-PTR"]				= { class = {class_type.TUMB, class_type.TUMB}, hint = LOCALIZE("Laser rangefinder / designator - mode switch")	   ,device = devices.LASERRANGER   , action = {device_commands.Button_3,device_commands.Button_3}, arg = {56,56}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0, 1},{0, 1}}, use_OBB = true, updatable = true, side = vr_side_TUMB_rev}
elements["CHOP-LDP-PTR"]			= { class = {class_type.BTN}, hint = LOCALIZE("Laser designator reset")				   ,device = devices.LASERRANGER   , action = {device_commands.Button_4},stop_action = {device_commands.Button_4}, arg = {55}, arg_value = {1.0}, arg_lim = {{0, 1}} , side = vr_side_BTN}

-- Laser Warning System (Л-140)
elements["L-140-RESET-PTR"]			= { class = {class_type.BTN}, hint = LOCALIZE("LWS Reset button"),			device = devices.LASER_WARNING_SYSTEM, action = {device_commands.Button_1}, stop_action = {device_commands.Button_1}, arg = {35}, arg_value = {1.0}, arg_lim = {{0.0, 1.0}} , side = vr_side_BTN}
elements["L140-SWITCH"]				= { class = {class_type.TUMB, class_type.TUMB}, hint = LOCALIZE("LWS Power switch"),		device = devices.LASER_WARNING_SYSTEM, action = {device_commands.Button_2,device_commands.Button_2}, arg = {583,583}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0, 1},{0, 1}}, use_OBB = true, updatable = true, side = vr_side_TUMB}
elements["L140-CNOB"]				= { class = {class_type.BTN}, hint = LOCALIZE("LWS self-test button"),	device = devices.LASER_WARNING_SYSTEM, action = {device_commands.Button_3}, stop_action = {device_commands.Button_4}, arg = {584}, arg_value = {1.0}, arg_lim = {{0.0, 1.0}} , side = vr_side_BTN}

-----------------------------------------------------------------------------------
-- Engines Start-Up Control Panel
elements["START-PANEL-START-PTR"]	= {class = {class_type.BTN}, hint = LOCALIZE("Start-up selected engine button"), device = devices.ENGINE_INTERFACE, action = {device_commands.Button_5}, stop_action = {device_commands.Button_5}, arg = {412}, arg_value = {1.0}, arg_lim = {{0, 1}}, use_release_message = {true}, side = vr_side_BTN}
elements["START-PANEL-STOP-START-PTR"] = {class = {class_type.BTN}, hint = LOCALIZE("Interrupt start-up button"), device = devices.ENGINE_INTERFACE, action = {device_commands.Button_6}, stop_action = {device_commands.Button_6}, arg = {413}, arg_value = {1.0}, arg_lim = {{0, 1}}, use_release_message = {true}, side = vr_side_BTN}
elements["START-PANEL-STOP-START-PTR01"] = {class = {class_type.BTN}, hint = LOCALIZE("Stop APU button"), device = devices.ENGINE_INTERFACE, action = {device_commands.Button_7}, stop_action = {device_commands.Button_7}, arg = {414}, arg_value = {1.0}, arg_lim = {{0, 1}}, use_release_message = {true}, side = vr_side_BTN}

elements["START-PANEL-ROLLING-PTR"]  = {class = {class_type.TUMB, class_type.TUMB}, hint = LOCALIZE("Engine Startup/Crank/False Start selector"), device = devices.ENGINE_INTERFACE, action = {device_commands.Button_12, device_commands.Button_12}, arg = {415, 415}, arg_value = {-direction*0.1, direction*0.1}, arg_lim = {{0.0, 0.2}, {0.0, 0.2}}, use_OBB = true, updatable = true, side = vr_side_TUMB_rev}
elements["START-PANEL-ROLLING-PTR"].sound	= {{SOUND_SW1}}

elements["START-ENGINE-SELECTOR-PTR"]  = {
	class = {class_type.TUMB, class_type.TUMB},
	hint = LOCALIZE("Engine selector"), 
	device = devices.ENGINE_INTERFACE, 
	action = {device_commands.Button_8,  device_commands.Button_8, device_commands.Button_8, device_commands.Button_8}, 
	arg = {416, 416, 416, 416}, 
	arg_value = {0.1, -0.1, 0.2, 0.3},
	arg_lim = {{0.0, 0.3}, {0.0, 0.3}, {0.0, 0.2}, {0.0, 0.3}}, 
	use_OBB = true, 
	updatable = true, 
	class_vr = {class_type.TUMB_4SIDE,class_type.TUMB_4SIDE,class_type.TUMB_4SIDE,class_type.TUMB_4SIDE},
	side = {{BOX_SIDE_X_top}, {BOX_SIDE_Z_top}, {BOX_SIDE_X_bottom}, {BOX_SIDE_Z_bottom} }
 }

elements["EMERGENCY-BRAKE ENGINE-LEFT-PTR"]  = { class = {class_type.TUMB, class_type.TUMB}, hint = LOCALIZE("Left engine cut-off valve"),	device = devices.ENGINE_INTERFACE, action = {device_commands.Button_9,device_commands.Button_9}, arg = {554,554}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0.0, 1.0},{0.0, 1.0}}, updatable = true, use_OBB = true, side = vr_side_TUMB_rev}
elements["EMERGENCY-BRAKE ENGINE-LEFT-PTR"].sound		= {{SOUND_SW4_DOWN, SOUND_SW4_UP}}
elements["EMERGENCY-BRAKE ENGINE-RIGHT-PTR"] = { class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("Right engine cut-off valve"),	device = devices.ENGINE_INTERFACE, action = {device_commands.Button_10,device_commands.Button_10}, arg = {555,55}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0.0, 1.0},{0.0, 1.0}}, updatable = true, use_OBB = true, side = vr_side_TUMB_rev}
elements["EMERGENCY-BRAKE ENGINE-RIGHT-PTR"].sound		= {{SOUND_SW4_DOWN, SOUND_SW4_UP}}
elements["BRAKE-ROTOR-LOW-PTR01"]	= { class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("Rotor brake"),	device = devices.ENGINE_INTERFACE, action = {device_commands.Button_11,device_commands.Button_11}, arg = {556,556}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0.0, 1.0},{0.0, 1.0}}, updatable = true, use_OBB = true, side = vr_side_TUMB_rev}

elements["CONTROL-TEMP-WORK-PTR"]	 = {class = {class_type.BTN}, hint = LOCALIZE("Running engines exhaust gas temperature indicator test button"), device = devices.ENGINE_INTERFACE, action = {device_commands.Button_22}, stop_action = {device_commands.Button_22}, arg = {131}, arg_value = {1.0}, arg_lim = {{0, 1.0}}, use_release_message = {true}, side = vr_side_BTN}
elements["CONTROL-TEMP-NOTWORK-PTR"] = {class = {class_type.BTN}, hint = LOCALIZE("Stopped engines exhaust gas temperature indicator test button"), device = devices.ENGINE_INTERFACE, action = {device_commands.Button_23}, stop_action = {device_commands.Button_23}, arg = {132}, arg_value = {1.0}, arg_lim = {{0, 1.0}}, use_release_message = {true}, side = vr_side_BTN}

-----------------------------------------------------------------------------------
--Radio switcher
elements["RADIO-RATE-PTR"]  = {class = {class_type.TUMB, class_type.TUMB}, hint = LOCALIZE("SPU-9 Radio communicator selector"), device = devices.SPU_9, action = {device_commands.Button_2, device_commands.Button_2}, arg = {428, 428}, arg_value = {-direction*0.11, direction*0.11}, arg_lim = {{0.0, 0.33}, {0.0, 0.33}}, class_vr = MULTY_TUMB, side = vr_side_LEV_TUMB, attach_left = {0, -110}}
elements["RADIO-RATE-PTR"].sound	= {{SOUND_SW2}}
--elements["RADIO-RESET-PTR"]  = {class = {class_type.BTN}, hint = LOCALIZE("Radio Communicator Reset", device = devices.SPU_9, action = {device_commands.Button_3}, stop_action = {device_commands.Button_3}, arg = {429}, arg_value = {1.0}, arg_lim = {{0.0, 1.0}}}
--elements["RADIO-COVER-RESET-PTR"]  = {class = {class_type.TUMB}, hint = LOCALIZE("Radio Communicator Reset Cover", device = devices.SPU_9, action = {device_commands.Button_4}, arg = {430}, arg_value = {1.0}, arg_lim = {{0.0, 1.0}}, updatable = true, use_OBB = true}

------------------------------------------------------------------------------------
-- Fire Extinguishers Control Panel
elements["PUI800-AVARCHOP-PTR01"]	= {class = {class_type.BTN}, hint = LOCALIZE("Left engine extinguisher"), device = devices.FIRE_EXTING_INTERFACE, action = {device_commands.Button_1}, stop_action = {device_commands.Button_1}, arg = {236}, arg_value = {1.0}, arg_lim = {{0, 1}}, use_release_message = {true} , side = vr_side_BTN}
elements["PUI800-AVARCHOP-PTR02"]	= {class = {class_type.BTN}, hint = LOCALIZE("APU extinguisher"), device = devices.FIRE_EXTING_INTERFACE, action = {device_commands.Button_2}, stop_action = {device_commands.Button_2}, arg = {238}, arg_value = {1.0}, arg_lim = {{0, 1}}, use_release_message = {true} , side = vr_side_BTN}
elements["PUI800-AVARCHOP-PTR03"]	= {class = {class_type.BTN}, hint = LOCALIZE("Right engine extinguisher"), device = devices.FIRE_EXTING_INTERFACE, action = {device_commands.Button_3}, stop_action = {device_commands.Button_3}, arg = {240}, arg_value = {1.0}, arg_lim = {{0, 1}}, use_release_message = {true} , side = vr_side_BTN}
elements["PUI800-AVARCHOP-PTR04"]	= {class = {class_type.BTN}, hint = LOCALIZE("Ventilator extinguisher"), device = devices.FIRE_EXTING_INTERFACE, action = {device_commands.Button_4}, stop_action = {device_commands.Button_4}, arg = {242}, arg_value = {1.0}, arg_lim = {{0, 1}}, use_release_message = {true} , side = vr_side_BTN}
elements["FIREEXT-PTR"]				= {class = {class_type.TUMB, class_type.TUMB}, hint = LOCALIZE("Fire extinguisher Work – Off – Test switch"), device = devices.FIRE_EXTING_INTERFACE, action = {device_commands.Button_5, device_commands.Button_6}, arg = {248, 248}, arg_value = {-direction*0.1, direction*0.1}, arg_lim = {{0.0, 0.2}, {0, 0.2}}, use_OBB = true, updatable = true, side = vr_side_TUMB}
elements["FIREEXT-COVER-PTR"]		= {class = {class_type.TUMB, class_type.TUMB}, hint = LOCALIZE("Fire extinguisher Work – Off – Test switch"), device = devices.FIRE_EXTING_INTERFACE, action = {device_commands.Button_7,device_commands.Button_7}, arg = {249,249}, arg_value = {direction*1.0,-direction*1.0}, arg_lim = {{0.0, 1.0},{0.0, 1.0}}, use_OBB = true, updatable = true , side = vr_side_TUMB_COVER}
elements["FIREEXT-COVER-PTR"].sound = {{SOUND_SW3_CLOSE, SOUND_SW3_OPEN}}
elements["FIREEXT-INDICATION-PTR"]	= {class = {class_type.TUMB, class_type.TUMB}, hint = LOCALIZE("Fire signaling"), device = devices.FIRE_EXTING_INTERFACE, action = {device_commands.Button_8, device_commands.Button_8}, arg = {250,250}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0.0, 1.0},{0.0, 1.0}}, use_OBB = true, updatable = true, side = vr_side_TUMB}
elements["BALOONS-PTR"]				= {class = {class_type.TUMB, class_type.TUMB}, hint = LOCALIZE("Fire extinguisher First (Auto) / Second (Manual) selector"), device = devices.FIRE_EXTING_INTERFACE, action = {device_commands.Button_9, device_commands.Button_9}, arg = {246,246}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0.0, 1.0},{0.0, 1.0}}, use_OBB = true, updatable = true, side = vr_side_TUMB}
elements["BALOONS-COVER-PTR"]		= {class = {class_type.TUMB, class_type.TUMB}, hint = LOCALIZE("Fire extinguisher First (Auto) / Second (Manual) selector"), device = devices.FIRE_EXTING_INTERFACE, action = {device_commands.Button_10, device_commands.Button_10}, arg = {247,247}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0.0, 1.0},{0.0, 1.0}}, use_OBB = true, updatable = true , side = vr_side_TUMB_COVER}
elements["BALOONS-COVER-PTR"].sound = {{SOUND_SW3_CLOSE, SOUND_SW3_OPEN}}
--elements["EXTING-GROUPS-CTRL"]		= {class = {class_type.TUMB, class_type.TUMB}, hint = LOCALIZE("1st/2nd/3rd fire warning sensors groups BIT selector"), device = devices.FIRE_EXTING_INTERFACE, action = {device_commands.Button_11, device_commands.Button_12}, arg = {251, 251}, arg_value = {-direction*0.1, direction*0.1}, arg_lim = {{0.0, 0.3}, {0, 0.3}}, use_OBB = true, updatable = true}
elements["EXTING-GROUPS-CTRL-01"]	= {class = {class_type.BTN}, hint = LOCALIZE("1st fire warning sensors group BIT"), device = devices.FIRE_EXTING_INTERFACE, action = {device_commands.Button_11}, stop_action = {device_commands.Button_11}, arg = {251}, arg_value = {0.1}, arg_lim = {{0, 0.1}}, use_OBB = false, updatable = false, use_release_message = {true}, side = vr_side_BTN}
elements["EXTING-GROUPS-CTRL-02"]	= {class = {class_type.BTN}, hint = LOCALIZE("2nd fire warning sensors group BIT"), device = devices.FIRE_EXTING_INTERFACE, action = {device_commands.Button_12}, stop_action = {device_commands.Button_12}, arg = {251}, arg_value = {0.2}, arg_lim = {{0, 0.2}}, use_OBB = false, updatable = false, use_release_message = {true}, side = vr_side_BTN}
elements["EXTING-GROUPS-CTRL-03"]	= {class = {class_type.BTN}, hint = LOCALIZE("3rd fire warning sensors group BIT"), device = devices.FIRE_EXTING_INTERFACE, action = {device_commands.Button_13}, stop_action = {device_commands.Button_13}, arg = {251}, arg_value = {0.3}, arg_lim = {{0, 0.3}}, use_OBB = false, updatable = false, use_release_message = {true}, side = vr_side_BTN}

------------------------------------------------------------------------------------
-- Misc. systems
elements["REDUCTOR-PTR"]			= {class = {class_type.BTN, class_type.BTN}, hint = LOCALIZE("Reducing gear box oil pressure indication selector"), device = devices.ENGINE_INTERFACE, action = {device_commands.Button_24, device_commands.Button_24}, stop_action = {device_commands.Button_25, device_commands.Button_25}, arg = {258, 258}, arg_value = {-direction*0.1, direction*0.1}, arg_lim = {{0.0, 0.1}, {0.1, 0.2}}, use_OBB = true, updatable = true, use_release_message = {true, true}, side = vr_side_TUMB_rev}
elements["HANGER-PTR"]				= {class = {class_type.TUMB, class_type.TUMB}, hint = LOCALIZE("Sling load Auto/Manual"), device = devices.MISC_SYSTEMS_INTERFACE, action = {device_commands.Button_4,device_commands.Button_4}, arg = {259,259}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0.0, 1.0},{0.0, 1.0}}, use_OBB = true, updatable = true, side = vr_side_TUMB}

------------------------------------------------------------------------------------
-- ALMAZ system
elements["SPEECH-INFO-OFF-PTR01"]	= {class = {class_type.BTN}, hint = LOCALIZE("Voice message system messages off"), device = devices.VMS, action = {device_commands.Button_1}, stop_action = {device_commands.Button_1}, arg = {384}, arg_value = {1.0}, arg_lim = {{0, 1}} , side = vr_side_BTN}
elements["SPEECH-INFO-AVAR-PTR"]	= {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("Voice message system emergency on"), device = devices.VMS, action = {device_commands.Button_2,device_commands.Button_2}, arg = {386,386}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0.0, 1.0},{0.0, 1.0}}, use_OBB = true, updatable = true , side = vr_side_TUMB}
elements["SPEECH-INFO-RETRY-PTR"]	= {class = {class_type.BTN}, hint = LOCALIZE("Voice message system messages repeat"), device = devices.VMS, action = {device_commands.Button_3}, stop_action = {device_commands.Button_3}, arg = {385}, arg_value = {1.0}, arg_lim = {{0, 1}} , side = vr_side_BTN}
elements["SPEECH-BIT-PTR"]			= {class = {class_type.BTN}, hint = LOCALIZE("Voice message system check"), device = devices.VMS, action = {device_commands.Button_4}, stop_action = {device_commands.Button_4}, arg = {442}, arg_value = {1.0}, arg_lim = {{0, 1}} , side = vr_side_BTN}

-- Lighting
elements["DESK-PTR"]				= { class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("Lighting cockpit panel switch"), device = devices.ILLUMINATION_INTERFACE, action = {device_commands.Button_1,device_commands.Button_1}, arg = {300,300}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0, 1},{0, 1}}, use_OBB = true, updatable = true, side = vr_side_TUMB}
elements["DEVICES-PTR"]				= { class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("Lighting night vision cockpit switch"), device = devices.ILLUMINATION_INTERFACE, action = {device_commands.Button_7,device_commands.Button_7}, arg = {299,299}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0, 1},{0, 1}}, use_OBB = true, updatable = true, side = vr_side_TUMB}
elements["AGR-PKP-PTR"]				= { class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("Lighting ADI and SAI switch"), device = devices.ILLUMINATION_INTERFACE, action = {device_commands.Button_3,device_commands.Button_3}, arg = {298,298}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0, 1},{0, 1}}, use_OBB = true, updatable = true, side = vr_side_TUMB}
elements["P-CONTR-ILLUM-PTR"]		= { class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("Lighting auxiliary panel switch"), device = devices.ILLUMINATION_INTERFACE, action = {device_commands.Button_5,device_commands.Button_5}, arg = {450,450}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0, 1},{0, 1}}, use_OBB = true, updatable = true, side = vr_side_TUMB}
elements["LAMP-PTR"]				= { class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("Lighting cockpit interior lamp switch"), device = devices.ILLUMINATION_INTERFACE, action = {device_commands.Button_9,device_commands.Button_9}, arg = {1001,1001}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0, 1},{0, 1}}, use_OBB = true, updatable = true, side = vr_side_TUMB}
elements["P-CONTR-BRIGHT-PTR"]		= {class = {class_type.LEV}, hint = LOCALIZE("Lighting auxiliary panel brightness knob"),	device = devices.ILLUMINATION_INTERFACE	,action = {device_commands.Button_6} ,arg = {451} ,arg_value = {0.1}  ,arg_lim = {{0.0 ,1.0}},cycle = false, side = vr_side_LEV, attach_left = {110, -45}, attach_right = {-90, -45}}
elements["BRIGHT-DEV-PTR"]			= {class = {class_type.LEV}, hint = LOCALIZE("Lighting night vision cockpit brightness knob"),	device = devices.ILLUMINATION_INTERFACE	,action = {device_commands.Button_8} ,arg = {507} ,arg_value = {0.1}  ,arg_lim = {{0.0 ,1.0}},cycle = false, side = vr_side_LEV, attach_left = {90, -50}, attach_right = {-90, -55}}
elements["BRIGHT-LEFT-RIGHT-PTR"]	= {class = {class_type.LEV}, hint = LOCALIZE("Lighting cockpit panel brightness knob"),	device = devices.ILLUMINATION_INTERFACE	,action = {device_commands.Button_2} ,arg = {593} ,arg_value = {0.1}  ,arg_lim = {{0.0 ,1.0}},cycle = false, side = vr_side_LEV, attach_left = {90, -50}, attach_right = {-90, -55}}
elements["BRIGHT-AGR-PKP-PTR"]		= {class = {class_type.LEV}, hint = LOCALIZE("Lighting HSI and ADI brightness knob"),	device = devices.ILLUMINATION_INTERFACE	,action = {device_commands.Button_4} ,arg = {508} ,arg_value = {0.1}  ,arg_lim = {{0.0 ,1.0}},cycle = false, side = vr_side_LEV, attach_left = {90, -50}, attach_right = {-90, -55}}

-- Outside illumination
elements["LANDING LIGHTS-DIR-LIGHT-PTR"]   = {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("Light landing-search. On/Retraction/Off"), device = devices.SPOTLIGHT_SYSTEM, action = {device_commands.Button_1,device_commands.Button_1}, arg = {382,382}, arg_value = {-direction*0.5,direction*0.5}, arg_lim = {{0.0, 1.0},{0.0, 1.0}}, use_OBB = true, updatable = true, side = vr_side_TUMB}
elements["LANDING LIGHTS-DIR-LIGHT-PTR"].sound = {{SOUND_SW1}}
elements["LANDING LIGHTS-BASE-RESERV-PTR"] = {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("Lights landing-search change. Main/Reserved"), device = devices.SPOTLIGHT_SYSTEM, action = {device_commands.Button_2,device_commands.Button_2}, arg = {383,383}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{ 0.0, 1.0},{ 0.0, 1.0}}, use_OBB = true, updatable = true, side = vr_side_TUMB_rev}
elements["CONTUR-LIGHT-PTR"]  			   = {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("Tip Lights"), device = devices.NAVLIGHT_SYSTEM, action = {device_commands.Button_1,device_commands.Button_1}, arg = {296,296}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0, 1.0},{0, 1.0}}, use_OBB = true, updatable = true, side = vr_side_TUMB}
elements["FLASHER-PTR"]  			       = {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("Anticollision Light"), device = devices.NAVLIGHT_SYSTEM, action = {device_commands.Button_3,device_commands.Button_3}, arg = {228,228}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0, 1.0},{0, 1.0}}, use_OBB = true, updatable = true, side = vr_side_TUMB}
elements["FORMATION-PTR"]  			       = {
	class = {class_type.TUMB,class_type.TUMB}, 
	hint = LOCALIZE("Formation Lights"), 
	device = devices.NAVLIGHT_SYSTEM, 
	action = {device_commands.Button_2,device_commands.Button_2,device_commands.Button_2,device_commands.Button_2}, 
	arg = {297,297,297,297}, 
	arg_value = {-0.1,0.1,0.2,0.3}, 
	arg_lim = {{0, 0.3},{0, 0.3},{0, 0.2},{0, 0.3}}, 
	use_OBB = true, 
	updatable = true, 
	class_vr = {class_type.TUMB_4SIDE,class_type.TUMB_4SIDE,class_type.TUMB_4SIDE,class_type.TUMB_4SIDE},
	side = {{BOX_SIDE_Z_bottom}, {BOX_SIDE_X_top}, {BOX_SIDE_X_bottom}, {BOX_SIDE_Z_top} }
}

--elements["LANDING LIGHTS-BASE-RESERV-PTR"] = {class = {class_type.TUMB}, hint = LOCALIZE("Spot Light Selection", device = devices.SPOTLIGHT_SYSTEM, action = {device_commands.Button_2}, arg = {383}, arg_value = {1.0}, arg_lim = {{ 0.0, 1.0}}}

-- SHKVAL windscreen wiper
elements["WIPER-PTR"]	                    = {class = {class_type.BTN}, hint = LOCALIZE("SHKVAL windscreen wiper"), device = devices.SHKVAL, action = {device_commands.Button_7}, stop_action = {device_commands.Button_7}, arg = {224}, arg_value = {1.0}, arg_lim = {{0, 1}} , side = vr_side_BTN}

-------------------------------------------------------------------------------------
--ARK-22
elements["IANDING LIGHTS-DIR-LIGHT-PTR01"]  = {class = {class_type.TUMB, class_type.TUMB}, hint = LOCALIZE("ADF Inner-Auto-Outer NDB switch"), device = devices.ARK_22, action = {device_commands.Button_3, device_commands.Button_3}, arg = {381, 381}, arg_value = {-direction*0.5, direction*0.5}, arg_lim = {{0.0, 1.0}, {0.0, 1.0}}, use_OBB = true, updatable = true, side = vr_side_TUMB}
elements["IANDING LIGHTS-DIR-LIGHT-PTR01"].sound = {{SOUND_SW1}}
elements["VARK-VOLUME-PTR01"]		        = {class = {class_type.TUMB, class_type.TUMB}, hint = LOCALIZE("ADF channel switch"), device = devices.ARK_22, action = {device_commands.Button_1, device_commands.Button_2}, arg = {357, 357}, arg_value = {-direction*0.1, direction*0.1}, arg_lim = {{0.0, 0.9}, {0.0, 0.9}}, class_vr = MULTY_TUMB, side = vr_side_LEV_TUMB, attach_left = {-130, -45}, attach_right = {130, -45}}
elements["TLF-TLG-PTR01"]				    = {class = {class_type.TUMB, class_type.TUMB}, hint = LOCALIZE("COMPASS-ANTENNA modes"), device = devices.ARK_22, action = {device_commands.Button_4,device_commands.Button_4},  arg = {356,356}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0.0, 1.0},{0.0, 1.0}}, use_OBB = true, updatable = true, side = vr_side_TUMB_rev}
elements["TLF-TLG-PTR01"].sound = {{SOUND_SW1}}
elements["TLF-TLG-PTR"]			     	    = {class = {class_type.TUMB, class_type.TUMB}, hint = LOCALIZE("TLF-TLG modes"), device = devices.ARK_22, action = {device_commands.Button_5,device_commands.Button_5},  arg = {354,354}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0.0, 1.0},{0.0, 1.0}}, use_OBB = true, updatable = true, side = vr_side_TUMB_rev}
elements["TLF-TLG-PTR"].sound = {{SOUND_SW1}}
elements["VARK-VOLUME-PTR"]				    = {class = {class_type.LEV}, hint = LOCALIZE("ADF Volume"),	device = devices.ARK_22	,action = {device_commands.Button_6} ,arg = {353}, arg_value = {0.05}, arg_lim = {{0.0 ,1.0}}, gain = {0.1},cycle = false, side = vr_side_LEV, attach_left = {-110, -45}, attach_right = {100, -45}}
elements["ARK-CONTROL-PTR"]					= {class = {class_type.BTN}, hint = LOCALIZE("ADF Test"), device = devices.ARK_22, action = {device_commands.Button_7},  stop_action = {device_commands.Button_7},  is_repeatable = {}, arg = {355}, arg_value = {1.0}, arg_lim = {{0.0, 1.0}}, use_release_message = {true}, side = vr_side_BTN}

-----------------------------------------------------------------------------------------
--R-800
elements["START-PANEL-CONTROL-PTR"]			= {class = {class_type.BTN}, hint = LOCALIZE("R-800 (VHF-2) BIT button"), device = devices.R_800, action = {device_commands.Button_1},  stop_action = {device_commands.Button_1},  is_repeatable = {}, arg = {418}, arg_value = {1.0}, arg_lim = {{0.0, 1.0}}, use_release_message = {true}, side = vr_side_BTN}
elements["CONTR-RADIO-CHM-AM-PTR"]		    = {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("R-800 (VHF-2) AM-FM toggle switch"), device = devices.R_800, action = {device_commands.Button_2,device_commands.Button_2},  arg = {417,417}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0.0, 1.0},{0.0, 1.0}}, use_OBB = true, updatable = true, side = vr_side_TUMB}
elements["CONTR-RADIO-CHM-AM-PTR"].sound	= {{SOUND_SW1}}
elements["CONTR-RADIO-AP-PTR"]				= {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("R-800 (VHF-2) Emergency receiver"), device = devices.R_800, action = {device_commands.Button_3,device_commands.Button_3},  arg = {421,421}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0.0, 1.0},{0.0, 1.0}}, use_OBB = true, updatable = true, side = vr_side_TUMB}
elements["CONTR-RADIO-AP-PTR"].sound		= {{SOUND_SW1}}
elements["CONTR-RADIO-ARK-PTR"]				= {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("R-800 (VHF-2) ADF switch"), device = devices.R_800, action = {device_commands.Button_4,device_commands.Button_4},  arg = {422,422}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0.0, 1.0},{0.0, 1.0}}, use_OBB = true, updatable = true, side = vr_side_TUMB}
elements["CONTR-RADIO-ARK-PTR"].sound		= {{SOUND_SW1}}
elements["CONTR-RADIO-50-100-PTR01"]		= {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("R-800 (VHF-2) Data transfer rate switch"), device = devices.R_800, action = {device_commands.Button_5,device_commands.Button_5},  arg = {420,420}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0.0, 1.0},{0.0, 1.0}}, use_OBB = true, updatable = true, side = vr_side_TUMB}
elements["CONTR-RADIO-50-100-PTR01"].sound	= {{SOUND_SW1}}
elements["CONTR-RADIO-PSH-PTR"]				= {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("R-800 (VHF-2) Squelch"), device = devices.R_800, action = {device_commands.Button_6,device_commands.Button_6},  arg = {423,423}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0.0, 1.0},{0.0, 1.0}}, use_OBB = true, updatable = true, side = vr_side_TUMB}
elements["CONTR-RADIO-PSH-PTR"].sound		= {{SOUND_SW1}}
-- Frequency rotaries

elements["CONTROLLER-FREQ-1-PTR"]   = {class = {class_type.BTN, class_type.BTN}, hint = LOCALIZE("R-800 (VHF-2) 1st rotary"), device = devices.R_800, action = {device_commands.Button_7, device_commands.Button_7}, arg = {-1, -1}, arg_value = {-1.0, 1.0}, arg_lim = {{-1.0, 1.0}, {-1.0, 1.0}}, side = {{BOX_SIDE_Z_top},{BOX_SIDE_X_top}}}
elements["CONTROLLER-FREQ-1-PTR"].sound		= {{SOUND_SW5}}
elements["CONTROLLER-FREQ-2-PTR"]   = {class = {class_type.BTN, class_type.BTN}, hint = LOCALIZE("R-800 (VHF-2) 2nd rotary"), device = devices.R_800, action = {device_commands.Button_8, device_commands.Button_8}, arg = {-1, -1}, arg_value = {-1.0, 1.0}, arg_lim = {{-1.0, 1.0}, {-1.0, 1.0}}, side = {{BOX_SIDE_Z_top},{BOX_SIDE_X_top}}}
elements["CONTROLLER-FREQ-2-PTR"].sound		= {{SOUND_SW5}}
elements["CONTROLLER-FREQ-3-PTR"]   = {class = {class_type.BTN, class_type.BTN}, hint = LOCALIZE("R-800 (VHF-2) 3rd rotary"), device = devices.R_800, action = {device_commands.Button_9, device_commands.Button_9}, arg = {-1, -1}, arg_value = {-1.0, 1.0}, arg_lim = {{-1.0, 1.0}, {-1.0, 1.0}}, side = {{BOX_SIDE_Z_top},{BOX_SIDE_X_top}}}
elements["CONTROLLER-FREQ-3-PTR"].sound		= {{SOUND_SW5}}
elements["CONTROLLER-FREQ-4-PTR"]	= {class = {class_type.BTN, class_type.BTN}, hint = LOCALIZE("R-800 (VHF-2) 4th rotary"), device = devices.R_800, action = {device_commands.Button_10, device_commands.Button_10}, arg = {-1, -1}, arg_value = {-1.0, 1.0},  arg_lim = {{-1.0, 1.0}, {-1.0, 1.0}}, side = {{BOX_SIDE_Z_top},{BOX_SIDE_X_top}}}
elements["CONTROLLER-FREQ-4-PTR"].sound		= {{SOUND_SW5}}

-------------------------------------------------------------------------------------------
--R-828
elements["CHANNEL-PTR"]  			= {class = {class_type.TUMB, class_type.TUMB}, hint = LOCALIZE("R-828 (VHF-1) Radio channel selector"), device = devices.R_828, action = {device_commands.Button_1, device_commands.Button_1}, arg = {371, 371}, arg_value = {-direction*0.1, direction*0.1}, arg_lim = {{0.0, 0.9}, {0.0, 0.9}}, class_vr = MULTY_TUMB, side = vr_side_LEV_TUMB, attach_left = {-110, -45}, attach_right = {110, -60}}
elements["CHANNEL-PTR"].sound	= {{SOUND_SW2}}
elements["RADIO-VOLUME-PTR"]  		= {class = {class_type.LEV}, hint = LOCALIZE("R-828 (VHF-1) Radio Volume"), device = devices.R_828, action = {device_commands.Button_2}, arg = {372}, arg_value = {0.05}, arg_lim = {{0.0, 1.0}}, gain = {0.1},cycle = false, side = vr_side_LEV, attach_left = {-130, -45}, attach_right = {130, -45}}
elements["ASU-PTR"] 				= {class = {class_type.BTN}, hint = LOCALIZE("R-828 (VHF-1) Tuner button"), device = devices.R_828, action = {device_commands.Button_3},  stop_action = {device_commands.Button_3},  is_repeatable = {}, arg = {373}, arg_value = {1.0}, arg_lim = {{0.0, 1.0}}, use_release_message = {true}, side = vr_side_BTN}
elements["RADIO-PSH-SWITCH-PTR"]  	= {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("R-828 (VHF-1) Squelch"), device = devices.R_828, action = {device_commands.Button_4,device_commands.Button_4}, arg = {374,374}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0.0, 1.0},{0.0, 1.0}}, use_OBB = false, updatable = true, side = vr_side_TUMB}
elements["RADIO-PSH-SWITCH-PTR"].sound = {{SOUND_SW1}}

--------------------------------------------------------------------------------------------
-- Signal Flares
elements["SIGNAL-FLARE-1-PTR"] = {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("Signal flare red"), device = devices.SIGNAL_FLARE_DISPENSER, action = {device_commands.Button_2,device_commands.Button_2},arg = {376,376}, arg_value = {direction*1.0,-direction*1.0}, arg_lim = {{0.0, 1.0},{0.0, 1.0}}, class_vr = {class_type.BTN_FIX}, side = {{BOX_SIDE_Y_bottom}}}
elements["SIGNAL-FLARE-1-PTR"].sound = {{SOUND_SW8_OFF, SOUND_SW8_ON}}
elements["SIGNAL-FLARE-2-PTR"] = {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("Signal flare green"), device = devices.SIGNAL_FLARE_DISPENSER, action = {device_commands.Button_1,device_commands.Button_1},arg = {377,377}, arg_value = {direction*1.0,-direction*1.0}, arg_lim = {{0.0, 1.0},{0.0, 1.0}}, class_vr = {class_type.BTN_FIX}, side = {{BOX_SIDE_Y_bottom}}}
elements["SIGNAL-FLARE-2-PTR"].sound = {{SOUND_SW8_OFF, SOUND_SW8_ON}}
elements["SIGNAL-FLARE-3-PTR"] = {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("Signal flare white"), device = devices.SIGNAL_FLARE_DISPENSER, action = {device_commands.Button_3,device_commands.Button_3},arg = {378,378}, arg_value = {direction*1.0,-direction*1.0}, arg_lim = {{0.0, 1.0},{0.0, 1.0}}, class_vr = {class_type.BTN_FIX}, side = {{BOX_SIDE_Y_bottom}}}
elements["SIGNAL-FLARE-3-PTR"].sound = {{SOUND_SW8_OFF, SOUND_SW8_ON}}
elements["SIGNAL-FLARE-4-PTR"] = {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("Signal flare yellow"), device = devices.SIGNAL_FLARE_DISPENSER, action = {device_commands.Button_4,device_commands.Button_4},arg = {379,379}, arg_value = {direction*1.0,-direction*1.0}, arg_lim = {{0.0, 1.0},{0.0, 1.0}}, class_vr = {class_type.BTN_FIX}, side = {{BOX_SIDE_Y_bottom}}}
elements["SIGNAL-FLARE-4-PTR"].sound = {{SOUND_SW8_OFF, SOUND_SW8_ON}}
elements["SIGNAL-FLARE-SWITCH-PTR"] = {class = {class_type.TUMB, class_type.TUMB}, hint = LOCALIZE("Signal flare system power"), device = devices.SIGNAL_FLARE_DISPENSER, action = {device_commands.Button_5,device_commands.Button_5}, arg = {380,380}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0.0, 1.0},{0.0, 1.0}}, use_OBB = false, updatable = true, side = vr_side_TUMB}

--------------------------------------------------------------------------------------------
-- PShK_7 (Latitude Entry Panel)
elements["LATITUDE-PTR"] = {class = {class_type.LEV}, hint = LOCALIZE("Latitude selection rotaty"), device = devices.PShK_7, action = {device_commands.Button_1}, arg = {340}, arg_value = {0.12}, arg_lim = {{0, 1}}, relative = {true}, gain = {0.2}, side = vr_side_LEV, attach_left = {-130, -45}, attach_right = {130, -45}}
elements["N-S-PTR"]	= {class = {class_type.TUMB,class_type.TUMB}, hint = LOCALIZE("North/South latitude selection"), device = devices.PShK_7, action = {device_commands.Button_2,device_commands.Button_2}, arg = {341,341}, arg_value = {-direction*1.0,direction*1.0}, arg_lim = {{0, 1},{0, 1}}, use_OBB = true, updatable = true, side = vr_side_TUMB_rev}

--------------------------------------------------------------------------------------------
-- ZMS_3 (Magnetic Variation Entry Panel)
elements["DCLIN-PTR"] = {class = {class_type.LEV}, hint = LOCALIZE("Magnetic variation selection rotaty"), device = devices.ZMS_3, action = {device_commands.Button_1}, arg = {338}, arg_value = {0.12}, arg_lim = {{0, 1}}, relative = {true}, gain = {0.2}, side = vr_side_LEV, attach_left = {-110, -45}, attach_right = {100, -45}}



elements["STICK_VISIBILITY"] = {class = {class_type.TUMB}, hint = LOCALIZE("Hide Stick toggle"), device = devices.CPT_MECH, action = {device_commands.Button_11}, arg = {1005}, arg_value = {1}, arg_lim = {{0, 1}},cycle = true}


for n, el in pairs(elements) do
    if el.class[1] ~= nil and
       el.class[2] ~= nil and
       el.class[1] == class_type.TUMB and
       el.class[2] == class_type.TUMB then
       el.cycle    =  cyclic_by_default
    end
end
elements["PAV-CRANE-VSU-PTR02"].cycle = false
elements["PTR_HUD-FILTER"].cycle = false
--elements["EMERGENCY-BRAKE ENGINE-LEFT-PTR"].cycle = false
--elements["EMERGENCY-BRAKE ENGINE-RIGHT-PTR"].cycle = false