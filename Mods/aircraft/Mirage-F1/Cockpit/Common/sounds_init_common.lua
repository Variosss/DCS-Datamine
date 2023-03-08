dofile(LockOn_Options.script_path.."../../Common/sounds_common.lua")

sounds = {}

sounds[SOUND_SILENCE]  					= {"Aircrafts/Mirage-F1/Cockpit/devices/click-silence"}
--sounds[SOUND_COVER]					= {"Aircrafts/C-101/Cockpit/cover-release"}
sounds[SOUND_CHUTE_LEVER_DEPLOY]		= {"Aircrafts/Mirage-F1/Cockpit/devices/left_wall/chute_control_lever_unfold_and_aft"}
sounds[SOUND_CHUTE_LEVER_DETACH]		= {"Aircrafts/Mirage-F1/Cockpit/devices/left_wall/chute_control_lever_forward_and_fold"}
sounds[AB_MAIN_COCK_SW_GUARD_OPEN]		= {"Aircrafts/Mirage-F1/Cockpit/devices/left_console/Coupe_feu_P.C_COVER_OPEN"}
sounds[AB_MAIN_COCK_SW_GUARD_CLOSE]		= {"Aircrafts/Mirage-F1/Cockpit/devices/left_console/Coupe_feu_P.C_COVER_CLOSE"}
sounds[STICK_UNCOUPLE_SW_GUARD_OPEN]	= {"Aircrafts/Mirage-F1/Cockpit/devices/left_main_panel_console/Cover_manche_open"}
sounds[STICK_UNCOUPLE_SW_GUARD_CLOSE]	= {"Aircrafts/Mirage-F1/Cockpit/devices/left_main_panel_console/Cover_manche_close"}
sounds[GEAR_COVER_OPEN]					= {"Aircrafts/Mirage-F1/Cockpit/devices/left_main_panel_console/Gear_cover_open"}
sounds[GEAR_COVER_CLOSE]				= {"Aircrafts/Mirage-F1/Cockpit/devices/left_main_panel_console/Gear_cover_close"}
sounds[SOUND_GEAR_LEVER_UP]				= {"Aircrafts/Mirage-F1/Cockpit/devices/left_main_panel_console/gear_lever_up"}
sounds[SOUND_GEAR_LEVER_DOWN]			= {"Aircrafts/Mirage-F1/Cockpit/devices/left_main_panel_console/gear_lever_down"}
sounds[START_BUTTON_COVER_OPEN]			= {"Aircrafts/Mirage-F1/Cockpit/devices/left_console/start_button_cover_open"}
sounds[START_BUTTON_COVER_CLOSE]		= {"Aircrafts/Mirage-F1/Cockpit/devices/left_console/start_button_cover_close"}
sounds[SOUND_JETTISON_COVER_OPEN]		= {"Aircrafts/Mirage-F1/Cockpit/devices/left_main_panel_console/jettison_cover_open"}
sounds[SOUND_JETTISON_COVER_CLOSE]		= {"Aircrafts/Mirage-F1/Cockpit/devices/left_main_panel_console/jettison_cover_close"}
sounds[SOUND_ARTHUR_SW_UP_DOWN]			= {"Aircrafts/Mirage-F1/Cockpit/devices/left_main_panel_console/arthur_switch_up_down"}
sounds[SOUND_ARTHUR_SW_MEDIUM]			= {"Aircrafts/Mirage-F1/Cockpit/devices/left_main_panel_console/arthur_switch_medium"}
sounds[SOUND_RADIO_5W_SW]				= {"Aircrafts/Mirage-F1/Cockpit/devices/left_console/RADIOS_5W_SWITCH"}
sounds[SOUND_PUMP_SW_ON]				= {"Aircrafts/Mirage-F1/Cockpit/devices/left_console/pump_sw_on"}
sounds[SOUND_PUMP_SW_OFF]				= {"Aircrafts/Mirage-F1/Cockpit/devices/left_console/pump_sw_off"}
sounds[SOUND_BATTERY_SW_ON]				= {"Aircrafts/Mirage-F1/Cockpit/devices/right_main_panel_console/battery_on"}
sounds[SOUND_BATTERY_SW_OFF]			= {"Aircrafts/Mirage-F1/Cockpit/devices/right_main_panel_console/battery_off"}
sounds[SOUND_FEEDER_TANK_FUS_SW_F]		= {"Aircrafts/Mirage-F1/Cockpit/devices/main_panel/feeder_tank_fus_sw_F"}
sounds[SOUND_FEEDER_TANK_FUS_SW_N]		= {"Aircrafts/Mirage-F1/Cockpit/devices/main_panel/feeder_tank_fus_sw_N"}
sounds[SOUND_CROSSFEED_SW_O]			= {"Aircrafts/Mirage-F1/Cockpit/devices/main_panel/crossfeed_sw_O"}
sounds[SOUND_CROSSFEED_SW_F]			= {"Aircrafts/Mirage-F1/Cockpit/devices/main_panel/crossfeed_sw_F"}
sounds[SOUND_WARNING_HORN_SW_ON]		= {"Aircrafts/Mirage-F1/Cockpit/devices/right_console/warning_horn_sw_on"}
sounds[SOUND_WARNING_HORN_SW_OFF]		= {"Aircrafts/Mirage-F1/Cockpit/devices/right_console/warning_horn_sw_off"}
sounds[SOUND_CB_UP]						= {"Aircrafts/Mirage-F1/Cockpit/devices/right_console/CB_UP"}
sounds[SOUND_CB_DOWN]					= {"Aircrafts/Mirage-F1/Cockpit/devices/right_console/CB_DOWN"}
sounds[SOUND_SIL_SW_ON]					= {"Aircrafts/Mirage-F1/Cockpit/devices/left_console/SIL_sw_on"}
sounds[SOUND_SIL_SW_OFF]				= {"Aircrafts/Mirage-F1/Cockpit/devices/left_console/SIL_sw_off"}
sounds[SOUND_EXT_LIGHTS_SW_UP]			= {"Aircrafts/Mirage-F1/Cockpit/devices/right_main_panel_console/Feux_up_Switch"}
sounds[SOUND_EXT_LIGHTS_SW_DOWN]		= {"Aircrafts/Mirage-F1/Cockpit/devices/right_main_panel_console/Feux_down_Switch"}
sounds[SOUND_FLAPS_LEVER_DOWN]			= {"Aircrafts/Mirage-F1/Cockpit/devices/left_console/Flaps_down"}
sounds[SOUND_FLAPS_LEVER_UP]			= {"Aircrafts/Mirage-F1/Cockpit/devices/left_console/Flaps_medium"}
sounds[SOUND_SIGHT_WHEEL_UP]			= {"Aircrafts/Mirage-F1/Cockpit/devices/main_panel/sight_wheel_up"}
sounds[SOUND_SIGHT_WHEEL_DOWN]			= {"Aircrafts/Mirage-F1/Cockpit/devices/main_panel/sight_wheel_down"}
sounds[SOUND_RADAR_STICK_SELECT_SW_R]	= {"Aircrafts/Mirage-F1/Cockpit/devices/left_console/radar_stick_select_sw_right"}
sounds[SOUND_RADAR_STICK_SELECT_SW_L]	= {"Aircrafts/Mirage-F1/Cockpit/devices/left_console/radar_stick_select_sw_left"}
sounds[SOUND_OMNIBEARING_SEL_MODE_CW]	= {"Aircrafts/Mirage-F1/Cockpit/devices/right_console/omnibearing_sel_mode_cw"}
sounds[SOUND_OMNIBEARING_SEL_MODE_CCW]	= {"Aircrafts/Mirage-F1/Cockpit/devices/right_console/omnibearing_sel_mode_ccw"}
sounds[SOUND_TACAN_CHANNEL_SEL_CW]		= {"Aircrafts/Mirage-F1/Cockpit/devices/right_console/tacan_channel_sel_cw"}
sounds[SOUND_TACAN_CHANNEL_SEL_CCW]		= {"Aircrafts/Mirage-F1/Cockpit/devices/right_console/tacan_channel_sel_ccw"}
sounds[SOUND_IFF_MODE_SEL_SW]			= {"Aircrafts/Mirage-F1/Cockpit/devices/IFF_panel/CODE_ROUND_MOVE"}
sounds[SOUND_IFF_M1_SW_UP]				= {"Aircrafts/Mirage-F1/Cockpit/devices/IFF_panel/M1_UP"}
sounds[SOUND_IFF_M1_SW_DOWN]			= {"Aircrafts/Mirage-F1/Cockpit/devices/IFF_panel/M1_DOWN"}
sounds[SOUND_IFF_IDENT_SW_UP]			= {"Aircrafts/Mirage-F1/Cockpit/devices/IFF_panel/IDENT_UP"}
sounds[SOUND_IFF_IDENT_SW_DOWN]			= {"Aircrafts/Mirage-F1/Cockpit/devices/IFF_panel/IDENT_DOWN"}
sounds[SOUND_DAY_NIGHT_SEL_SW_CCW]		= {"Aircrafts/Mirage-F1/Cockpit/devices/right_console/day-night_sel_sw_ccw"}
sounds[SOUND_DAY_NIGHT_SEL_SW_CW]		= {"Aircrafts/Mirage-F1/Cockpit/devices/right_console/day-night_sel_sw_cw"}
sounds[SOUND_CHANNEL_SEL_CCW]			= {"Aircrafts/Mirage-F1/Cockpit/devices/left_console/channel_sel_ccw"}
sounds[SOUND_CHANNEL_SEL_CW]			= {"Aircrafts/Mirage-F1/Cockpit/devices/left_console/channel_sel_cw"}
sounds[SOUND_FREQ_SEL_UP]				= {"Aircrafts/Mirage-F1/Cockpit/devices/left_console/freq_sel_up"}
sounds[SOUND_FREQ_SEL_DOWN]				= {"Aircrafts/Mirage-F1/Cockpit/devices/left_console/freq_sel_down"}
sounds[SOUND_IDN_MODE_SEL]				= {"Aircrafts/Mirage-F1/Cockpit/devices/main_panel/IDN_mode_sel"}
sounds[SOUND_IDN_VECT_ADD_SW]			= {"Aircrafts/Mirage-F1/Cockpit/devices/main_panel/IDN_vect_add_sw"}
sounds[SOUND_RUDDER_TRIM_SW_LEFT]		= {"Aircrafts/Mirage-F1/Cockpit/devices/left_console/trim_sw_left"}
sounds[SOUND_RUDDER_TRIM_SW_CENTER]		= {"Aircrafts/Mirage-F1/Cockpit/devices/left_console/trim_sw_center"}
sounds[SOUND_RUDDER_TRIM_SW_RIGHT]		= {"Aircrafts/Mirage-F1/Cockpit/devices/left_console/trim_sw_right"}
sounds[SOUND_SOURIS_SW_UP]				= {"Aircrafts/Mirage-F1/Cockpit/devices/main_panel/souris_sw_up"}
sounds[SOUND_SOURIS_SW_CENTER]			= {"Aircrafts/Mirage-F1/Cockpit/devices/main_panel/souris_sw_center"}
sounds[SOUND_SOURIS_SW_DOWN]			= {"Aircrafts/Mirage-F1/Cockpit/devices/main_panel/souris_sw_down"}
sounds[SOUND_CONV_SW_UP]				= {"Aircrafts/Mirage-F1/Cockpit/devices/right_main_panel_console/Conv_up_Switch"}
sounds[SOUND_CONV_SW_CENTER]			= {"Aircrafts/Mirage-F1/Cockpit/devices/right_main_panel_console/Conv_center_Switch"}
sounds[SOUND_CONV_SW_DOWN]				= {"Aircrafts/Mirage-F1/Cockpit/devices/right_main_panel_console/Conv_down_Switch"}
sounds[SOUND_IFF_IDENT_SW_UP]			= {"Aircrafts/Mirage-F1/Cockpit/devices/IFF_panel/ident_up"}
sounds[SOUND_IFF_IDENT_SW_CENTER]		= {"Aircrafts/Mirage-F1/Cockpit/devices/IFF_panel/ident_center"}
sounds[SOUND_IFF_IDENT_SW_DOWN]			= {"Aircrafts/Mirage-F1/Cockpit/devices/IFF_panel/ident_down"}
sounds[SOUND_SOURIS_BTN_OUT]			= {"Aircrafts/Mirage-F1/Cockpit/devices/main_panel/souris_button_out"}
sounds[SOUND_SOURIS_BTN_PRESS]			= {"Aircrafts/Mirage-F1/Cockpit/devices/main_panel/souris_button_press"}
sounds[SOUND_EFF_SW_UP]					= {"Aircrafts/Mirage-F1/Cockpit/devices/left_wall/EFF_sw_up"}
sounds[SOUND_EFF_SW_DOWN]				= {"Aircrafts/Mirage-F1/Cockpit/devices/left_wall/EFF_sw_down"}
sounds[SOUND_EMERG_REG_LEVER_BCK]		= {"Aircrafts/Mirage-F1/Cockpit/devices/left_console/emer_reg_bck"}
sounds[SOUND_EMERG_REG_LEVER_BCK_CTR]	= {"Aircrafts/Mirage-F1/Cockpit/devices/left_console/emer_reg_bck_ctr"}
sounds[SOUND_EMERG_REG_LEVER_FWRD_CTR]	= {"Aircrafts/Mirage-F1/Cockpit/devices/left_console/emer_reg_fwrd_ctr"}
sounds[SOUND_EMERG_REG_LEVER_FWRD]		= {"Aircrafts/Mirage-F1/Cockpit/devices/left_console/emer_reg_fwrd"}
sounds[SOUND_IDN_ADD_TGT_SEL]			= {"Aircrafts/Mirage-F1/Cockpit/devices/main_panel/IDN_add_tgt_sel"}
sounds[SOUND_OXY_MODE_SEL]				= {"Aircrafts/Mirage-F1/Cockpit/devices/seat/oxy_mode_sel"}
sounds[SOUND_IN_FLIGHT_RELIGHT_FWRD]	= {"Aircrafts/Mirage-F1/Cockpit/devices/left_console/in_flight_relight_fwrd"}
sounds[SOUND_IN_FLIGHT_RELIGHT_AFT]		= {"Aircrafts/Mirage-F1/Cockpit/devices/left_console/in_flight_relight_aft"}
sounds[SOUND_THROTTLE_CUT_IDLE_SW_UP]	= {"Aircrafts/Mirage-F1/Cockpit/devices/left_console/throttle_cut_idle_sw_up"}
sounds[SOUND_THROTTLE_CUT_IDLE_SW_DOWN]	= {"Aircrafts/Mirage-F1/Cockpit/devices/left_console/throttle_cut_idle_sw_down"}
sounds[SOUND_RADAR_FUNCTION_SEL_CW]		= {"Aircrafts/Mirage-F1/Cockpit/devices/main_panel/radar_function_sel_cw"}
sounds[SOUND_RADAR_FUNCTION_SEL_CCW]	= {"Aircrafts/Mirage-F1/Cockpit/devices/main_panel/radar_function_sel_ccw"}
sounds[SOUND_VOR_ILS_TEST_SEL_ON]		= {"Aircrafts/Mirage-F1/Cockpit/devices/right_console/VOR_ILS_test_sel_on"}
sounds[SOUND_VOR_ILS_TEST_SEL_OFF]		= {"Aircrafts/Mirage-F1/Cockpit/devices/right_console/VOR_ILS_test_sel_off"}
sounds[SOUND_CANOPY_EMBRITTLE_CTRL_FWD]	= {"Aircrafts/Mirage-F1/Cockpit/devices/left_wall/canopy_embrittle_fwd"}
sounds[SOUND_CANOPY_EMBRITTLE_CTRL_AFT]	= {"Aircrafts/Mirage-F1/Cockpit/devices/left_wall/canopy_embrittle_aft"}
sounds[SOUND_RWR_T_TEST_CW]				= {"Aircrafts/Mirage-F1/Cockpit/devices/main_panel/RWR_T_test_cw"}
sounds[SOUND_RWR_T_TEST_CCW]			= {"Aircrafts/Mirage-F1/Cockpit/devices/main_panel/RWR_T_test_ccw"}
sounds[SOUND_RWR_TEST_UP]				= {"Aircrafts/Mirage-F1/Cockpit/devices/main_panel/RWR_test_up"}
sounds[SOUND_RWR_TEST_CENTER]			= {"Aircrafts/Mirage-F1/Cockpit/devices/main_panel/RWR_test_center"}
sounds[SOUND_RWR_TEST_DOWN]				= {"Aircrafts/Mirage-F1/Cockpit/devices/main_panel/RWR_test_down"}
sounds[SOUND_CANOPY_SEAL_LEVER]			= {"Aircrafts/Mirage-F1/Cockpit/devices/right_wall/canopy_seal_lever"}
sounds[SOUND_INTERCOM_PUSHBUTTON_IN]	= {"Aircrafts/Mirage-F1/Cockpit/devices/left_console/intercom_pushbutton_in"}
sounds[SOUND_INTERCOM_PUSHBUTTON_OUT]	= {"Aircrafts/Mirage-F1/Cockpit/devices/left_console/intercom_pushbutton_out"}
sounds[SOUND_EMERG_GEAR_EXT_OUT]		= {"Aircrafts/Mirage-F1/Cockpit/devices/right_main_panel_console/emerg_gear_ext_out"}
sounds[SOUND_EMERG_GEAR_EXT_IN]			= {"Aircrafts/Mirage-F1/Cockpit/devices/right_main_panel_console/emerg_gear_ext_in"}
sounds[SOUND_PARKING_BRK_OUT]			= {"Aircrafts/Mirage-F1/Cockpit/devices/left_main_panel_console/prkng_brk_out"}
sounds[SOUND_PARKING_BRK_IN]			= {"Aircrafts/Mirage-F1/Cockpit/devices/left_main_panel_console/prkng_brk_in"}