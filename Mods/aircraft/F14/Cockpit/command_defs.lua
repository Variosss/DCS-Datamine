local start_command = 3000
local count = start_command
-- clickable/input commands
local function counter()
	count = count + 1
	return count
end

local start_command2 = 10100
local count2 = start_command2
-- global commands
local function counter2()
	count2 = count2 + 1
	return count2
end

Keys =
{
	Engine_Start	= 311,
	Engine_Stop		= 312,

}


device_commands =
{
    -- published fixed value commands from 10000 to 10099 for use by mission editor (action "X: Set command" in triggers), see proxy_device.lua
    -- (since these use fixed values, it's not necessary to rebuild Command.h after adding/changing values in this range)
    PROXY_Enable_ACM_guns_AA = 10000,
    PROXY_carrier_landing = 10001,
    PROXY_ground_landing = 10002,
    PROXY_case1_recovery = 10003,
    PROXY_pilot_VSL = 10004,
    PROXY_wings_swept = 10005,
    PROXY_a2g = 10006,
    PROXY_parkingbrake = 10007,
    PROXY_radarwow = 10008,
    PROXY_Jester_LANTIRN_inhibit_auto_designate = 10009,
    PROXY_Jester_silent = 10010,
    PROXY_Jester_pause = 10011,
    PROXY_Jester_LANTIRN_track_target_id = 10012,
    PROXY_Jester_LANTIRN_track_zone_id = 10013,
    PROXY_Jester_LANTIRN_designate = 10014,
    PROXY_Jester_tune_ARC_182_channel = 10015,
    PROXY_Jester_tune_TACAN_channel = 10016,
    PROXY_Jester_DEST_knob = 10017,
    PROXY_Jester_active_wpt_entry = 10018,
    PROXY_Jester_active_wpt_from_trigger_zone = 10019,
    PROXY_Jester_WCS = 10020,
    PROXY_Jester_RWR_BIT = 10021,
    PROXY_Jester_TID_range = 10022,
    PROXY_Jester_eject_RIO = 10023,
    PROXY_Jester_radar_track_target_id = 10024,
    PROXY_Jester_radar_drop_track = 10025,
    PROXY_Jester_wpn_station_state = 10026,
    PROXY_Jester_wpn_bomb_type_selector = 10027,
    PROXY_Jester_wpn_attk_mode = 10028,
    PROXY_Jester_wpn_dlvy_mode = 10029,
    PROXY_Jester_wpn_dlvy_optns_interval = 10030,
    PROXY_Jester_wpn_dlvy_optns_qty = 10031,
    PROXY_Jester_wpn_aa_launch = 10032,
    PROXY_Jester_radar_azimuth = 10033,
    PROXY_Jester_radar_elevation = 10034,
    PROXY_last_command_sentinel = 10099,

    -- hydraulics
    HYD_TRANSFER_PUMP_Switch = counter(),
    HYD_TRANSFER_PUMP_SwitchCover = counter(),
    HYD_EMERG_FLT_Switch = counter(),
    HYD_EMERG_FLT_SwitchCover = counter(),
    HYD_ISOL_Switch = counter(),
    HYD_HandPump = counter(),

    -- AICS
    INLET_RAMPS_LeftSwitch = counter(),
    INLET_RAMPS_RightSwitch = counter(),

    -- Electrics
    ELEC_MASTER_GEN_LeftSwitch = counter(),
    ELEC_MASTER_GEN_RightSwitch = counter(),
    ELEC_EMERG_GEN_SwitchCover = counter(),
    ELEC_EMERG_GEN_Switch = counter(),

    -- Gear, brakes, hook
    BRAKE_ParkingBrake = counter(),
    BRAKE_AntiSkidAndSpoilerBrake = counter(),
    NWS_Enable = counter(),
    GEAR_Handle = counter(),
    GEAR_DownLockOverride = counter(),

    GEAR_Toggle = counter(),
	GEAR_Strut = counter(),
    SPEEDBRAKE_ExtendRetract = counter(), -- also see SPEEDBRAKE_Toggle
    HOOK_Handle = counter(), -- also see HOOK_toggle
    HOOK_Handle_Emergency = counter(),
    
    CATAPULT_Salute = counter(),

    -- Wing sweep
    WINGSWEEP_AutoButton = counter(),
    WINGSWEEP_FwdButton = counter(),
    WINGSWEEP_AftButton = counter(),
    WINGSWEEP_BombButton = counter(),
    WINGSWEEP_EnableSwitch = counter(),
    WINGSWEEP_EmergencySweepCover = counter(),
    WINGSWEEP_EmergencyLeverExtended = counter(),
    WINGSWEEP_EmergencySweepLever = counter(),
    WINGSWEEP_EmergencySweepLeverFwd = counter(),
    WINGSWEEP_EmergencySweepLeverAft = counter(),

    -- AFCS
    AFCS_Stability_Pitch = counter(),
    AFCS_Stability_Roll = counter(),
    AFCS_Stability_Yaw = counter(),

    -- AP
    AP_Vector = counter(),
    AP_Altitude = counter(),
    AP_Heading = counter(),
    AP_Engage = counter(),
    AP_Engage_Toggle = counter(),

    --Clock
    CLOCK_Wind = counter(),
    CLOCK_Timer = counter(),

    -- Flaps
    FLAPS_Lever = counter(),

    -- Engine
    ENGINE_Throttle_Mode = counter(),
    ENGINE_Throttle_Mode_Toggle = counter(),
    ENGINE_Throttle_Temp = counter(),
    ENGINE_Mid_Compression_Bypass_Test = counter(),
    ENGINE_Probe_Anti_Ice = counter(),
    ENGINE_Air_Start = counter(),
    ENGINE_Crank = counter(),
    ENGINE_Left_Mode = counter(),
    ENGINE_Right_Mode = counter(),
    ENGINE_Asym_Limiter = counter(),
    ENGINE_Asym_LimiterCover = counter(),

	-- Master caution
	WLP_Master_Caution_Pilot = counter(),
	WLP_Master_Caution_RIO = counter(),
	
	MASTER_Reset = counter(),

    -- Fire
    FIRE_Bottle_Fire_L = counter(),
    FIRE_Bottle_Fire_R = counter(),

    -- Fuel system
    FUELSYSTEM_Shutoff_R = counter(),
    FUELSYSTEM_Shutoff_L = counter(),
    FUELSYSTEM_Fuel_Qty_Sel = counter(),
    FUELSYSTEM_Fuel_Feed_Cover = counter(),
    FUELSYSTEM_Fuel_Feed = counter(),
    FUELSYSTEM_WingExt_Trans = counter(),
    FUELSYSTEM_Dump = counter(),
    FUELSYSTEM_Refuel_Probe = counter(),
    FUELSYSTEM_Bingo_Knob = counter(),

    --Walkman
    WALKMAN_Play = counter(),
    WALKMAN_Stop = counter(),
    WALKMAN_FFWD = counter(),
    WALKMAN_FBWD = counter(),
    WALKMAN_VOLUP = counter(),
    WALKMAN_VOLDOWN = counter(),

	--BIT Panel
	BIT_Selector = counter(),
	BIT_SelectorPush = counter(),

    --Stick
    STICK_Bomb_Release = counter(),
    STICK_Weapon_Selector = counter(),
    STICK_Weapon_Selector_up = counter(),
    STICK_Weapon_Selector_down = counter(),
    STICK_Weapon_Selector_press = counter(),
    STICK_DLC_ManDec_Thumbwheel = counter(),
    STICK_DLC_Toggle_CountDisp = counter(),
    STICK_Autopilot_Ref_NWS_Toggle = counter(),
    STICK_Autopilot_Emergency_Disconnect = counter(),
    STICK_Trigger = counter(),
    STICK_Trigger_Detent = counter(),

    -- RIO HCU
    HCU_leftright = counter(),
    HCU_updown = counter(),
    HCU_halfaction = counter(),
    HCU_fullaction = counter(),
    HCU_DualTriggerAxisThresh = counter(),
    HCU_offset = counter(),
    HCU_MRL = counter(),
    HCU_IR_TV = counter(),
    HCU_RDR = counter(),
    HCU_DDD_cursor = counter(),
    HCU_TID_cursor = counter(),
    HCU_TVIR_enable = counter(),
    HCU_WCS_enable = counter(),
    HCU_key_updown = counter(),
    HCU_key_leftright = counter(),
    HCU_key_center = counter(),
    HCU_thumb = counter(), -- 1, 0, -1 for incr,stop,decr; see also HCU_thumb_axis and HCU_thumb_center

    -- RIO TID
    TID_nav_mode = counter();
    TID_nav_mode_inc = counter();
    TID_nav_mode_dec = counter();
    TID_dest_mode = counter();
    TID_dest_mode_inc = counter();
    TID_dest_mode_dec = counter();

    TID_mode_knob = counter(),
    TID_range_knob = counter(),
    TID_NON_ATTK = counter(),
    TID_JAM_STROBE = counter(),
    TID_DATA_LINK = counter(),
    TID_SYM_ELEM = counter(),
    TID_ALT_NUM = counter(),
    TID_RID_DSBL = counter(),
    TID_LAUNCH_ZONE = counter(),
    TID_VEL_VECTOR = counter(),
    TID_CLSN = counter(),
    TID_trackhold = counter(),
    TID_bright = counter(),
    TID_contrast = counter(),

    -- Throttle
    THROTTLE_CAGE_SEAM = counter(),
    THROTTLE_PLM = counter(),
    THROTTLE_Left_Throttle_CutOff = counter(),
    THROTTLE_Right_Throttle_CutOff = counter(),

    -- Weapons
    WEAP_Gun_Rate = counter(),
    WEAP_Gun_Elevation = counter(),
    WEAP_Gun_Ammo_adjust = counter(),
    WEAP_ACM_Cover = counter(),
    WEAP_ACM_Cover_Toggle = counter(),
    WEAP_Master_Arm_Cover = counter(),
    WEAP_Master_Arm = counter(),
    WEAP_Master_Arm_And_Cover = counter(),
    WEAP_ACM_Jettison = counter(),
    WEAP_SW_Cool = counter(),
    WEAP_MSL_Prep = counter(),
    WEAP_MSL_Mode = counter(),
    WEAP_Emer_Jettison = counter(),
    WEAP_Target_designate_up = counter(),
    WEAP_Target_designate_fwd = counter(),
    WEAP_Target_designate_down = counter(),
    -- RIO armament
    WEAP_Type_Wheel = counter(),
    WEAP_Interval_100s = counter(),
    WEAP_Interval_10s = counter(),
    WEAP_Quantity_10s = counter(),
    WEAP_Quantity_1s = counter(),
    WEAP_ATTK_Mode = counter(),
    WEAP_Elec_Fuse = counter(),
    WEAP_MSL_SPD_Gate = counter(),
    WEAP_Selective_Jett = counter(), -- see also WEAP_Selective_Jett_cover
    WEAP_Mech_Fuse = counter(),
    WEAP_Missile_Option = counter(),
    WEAP_Bomb_SinglePairs = counter(),
    WEAP_Bomb_StepRipple = counter(),
    WEAP_AG_Gun = counter(),
    WEAP_Jett_RackWeapons = counter(),
    WEAP_AA_Launch = counter(),
    WEAP_Next_launch = counter(),
    WEAP_Jett_Station1 = counter(),
    WEAP_Jett_LeftTank = counter(),
    WEAP_Jett_Station3 = counter(),
    WEAP_Jett_Station4 = counter(),
    WEAP_Jett_Station5 = counter(),
    WEAP_Jett_Station6 = counter(),
    WEAP_Jett_RightTank = counter(),
    WEAP_Jett_Station8 = counter(),

    -- Lights
    LIGHTS_Taxi = counter(),
    LIGHTS_RedFlood = counter(),
    LIGHTS_WhiteFlood = counter(),
    LIGHTS_PositionWings = counter(),
    LIGHTS_PositionTail = counter(),
    LIGHTS_PositionFlash = counter(),
    LIGHTS_AntiCol = counter(),
    LIGHTS_ACMPanel = counter(),
    LIGHTS_Instruments = counter(),
    LIGHTS_Console = counter(),
    LIGHTS_Formation = counter(),


    -- Cockpit mechanics
    CANOPY_Open = counter(),
    CANOPY_Toggle = counter(),
    CANOPY_Drop = counter(),
    EJECT_CMD_Lever = counter(),
    EJECT_ArmPilot = counter(),
    EJECT_ArmRIO = counter(),
    EJECT_ArmPilotToggle = counter(),
    EJECT_ArmRIOToggle = counter(),

    -- Environment
    PilotOxygenOn = counter(),
    RIOOxygenOn = counter(),
    CabinPressureDump = counter(),
    AirSourceRam = counter(),
    AirSourceOff = counter(),
    AirSourceLEng = counter(),
    AirSourceREng = counter(),
    AirSourceBoth = counter(),

    -- Datalink (more further down)
    DATALINK_Mode_Cycle = counter(),
    DATALINK_Mode_Up = counter(),
    DATALINK_Mode_Down = counter(),
    DATALINK_FreqHi_Up = counter(),
    DATALINK_FreqHi_Down = counter(),
    DATALINK_FreqMid_Up = counter(),
    DATALINK_FreqMid_Down = counter(),
    DATALINK_FreqLo_Up = counter(),
    DATALINK_FreqLo_Down = counter(),
    DATALINK_AddrHi_Up = counter(),
    DATALINK_AddrHi_Down = counter(),
    DATALINK_AddrLo_Up = counter(),
    DATALINK_AddrLo_Down = counter(),

    --AoASystem
    AoA_HookBypass = counter(),
    AoA_IndexerStrength = counter(),

    -- Displays control panel
    DISP_HUD_power = counter(),
    DISP_VDI_power = counter(),
    DISP_HSD_ECMD_power = counter(),
    DISP_mode_takeoff = counter(),
    DISP_mode_cruise = counter(),
    DISP_mode_air2air = counter(),
    DISP_mode_air2ground = counter(),
    DISP_mode_landing = counter(),
    DISP_mode_next = counter(),
    DISP_mode_prev = counter(),
    DISP_HUD_pitch_bright = counter(),
    DISP_VDI_display_mode = counter(),
    DISP_VDI_landing_mode = counter(),
    DISP_HUD_declutter = counter(),
    DISP_HUD_AWL_mode = counter(),

    -- HUD/VDI adjust
    VDIG_VDI_handle = counter(),
    VDIG_HUD_trim = counter(),
    VDIG_VSDI_trim = counter(),
    VDIG_VDI_contrast = counter(),
    VDIG_VSDI_bright = counter(),
    VDIG_HUD_bright = counter(),
    VDIG_VDI_filter = counter(),

    -- HSD
    HSD_Display_Mode_Cycle = counter(),
    HSD_Display_Mode_NAV = counter(),
    HSD_Display_Mode_TID = counter(),
    HSD_Display_Mode_ECM = counter(),
    HSD_ECM_Override = counter(),
    HSD_Knob_Brightness = counter(),
    HSD_Knob_Heading = counter(),
    HSD_Knob_Course = counter(),
    HSD_Btn_Test = counter(),
    HSD_Btn_BIT = counter(),

    -- ECM Display Indicator
    ECMD_Knob_Brightness = counter(),
    ECMD_Btn_Test = counter(),

    -- ECM Display Panel
    ECMD_Mode_Cycle = counter(),
    ECMD_Override_Cycle= counter(),
    ECMD_Corr_Cycle = counter(),
    ECMD_Data_ADF_Cycle = counter(),


    -- DECM
    DECM_Jam_Toggle = counter(),
    DECM_Mode_Knob = counter(),
    DECM_Vol_Knob = counter(),

    -- ALR-67 RWR Control Panel
	RWR_ALR67_Volume = counter(),
	RWR_ALR67_Volume_Step = counter(),
	RWR_DISPLAY_MODE = counter(),
	RWR_DISPLAY_TYPE = counter(),
	RWR_DISPLAY_TYPE_Step = counter(),
	RWR_POWER = counter(),
	RWR_POWER_Toggle = counter(),
	RWR_TEST_SWITCH = counter(),
	RWR_Brightness_Pilot = counter(),
	RWR_Brightness_RIO = counter(),
	RWR_Brightness_Pilot_Step = counter(),
	RWR_Brightness_RIO_Step = counter(),
	RWR_Show_Hide_2d_Display = counter(),
    --RCP67_Pwr_Switch = counter(),
    --RCP67_Display_Cycle = counter(),
    --RCP67_Mode_Switch = counter(),

    -- ALR-45/50 RWR Control Panel
    --RCP45_Power_Switch = counter(),
    --RCP45_AAA_Mode_Switch = counter(),

    -- AN/ALE-39
	CMDS_Master_Mode_SW = counter(),
	CMDS_Master_Mode_SW_Step = counter(),
    CMDS_Chaff_Oper_SW = counter(),
    CMDS_Flare_Oper_SW = counter(),
	CMDS_Jammer_Oper_SW = counter(),
    CMDS_Flare_Salvo_SW = counter(),
    CMDS_Flare_Mode_SW = counter(),
	CMDS_Flare_Mode_SW_Step = counter(),
	
	CMDS_Chaff_Counter_Control = counter(),
	CMDS_Chaff_Counter_Control_Step = counter(),
	CMDS_Flare_Counter_Control = counter(),
	CMDS_Flare_Counter_Control_Step = counter(),
	CMDS_Jammer_Counter_Control = counter(),
	CMDS_Jammer_Counter_Control_Step = counter(),

    CMDS_L10_Wheel = counter(),
	CMDS_L10_Wheel_Step = counter(),
    CMDS_L20_Wheel = counter(),
	CMDS_L20_Wheel_Step = counter(),
    CMDS_R10_Wheel = counter(),
	CMDS_R10_Wheel_Step = counter(),
    CMDS_R20_Wheel = counter(),
	CMDS_R20_Wheel_Step = counter(),
	
	CMDS_JAMR_Intv_1 = counter(),
	CMDS_JAMR_Intv_1_Step = counter(),
	CMDS_JAMR_Intv_10 = counter(),
	CMDS_JAMR_Intv_10_Step = counter(),
	CMDS_JAMR_Intv_100 = counter(),
	CMDS_JAMR_Intv_100_Step = counter(),
	CMDS_JAMR_Qty = counter(),
	CMDS_JAMR_Qty_Step = counter(),
	
	CMDS_Programmer_Reset = counter(),

    CMDS_Chaff_Burst_Qty_Wheel = counter(),
	CMDS_Chaff_Burst_Qty_Wheel_Step = counter(),
    CMDS_Chaff_Burst_Intv_Wheel = counter(),
	CMDS_Chaff_Burst_Intv_Wheel_Step = counter(),
    CMDS_Chaff_Salvo_Qty_Wheel = counter(),
	CMDS_Chaff_Salvo_Qty_Wheel_Step = counter(),
    CMDS_Chaff_Salvo_Intv_Wheel = counter(),
	CMDS_Chaff_Salvo_Intv_Wheel_Step = counter(),

    CMDS_Flare_Qty_Wheel = counter(),
	CMDS_Flare_Qty_Wheel_Step = counter(),
    CMDS_Flare_Intv_Wheel = counter(),
	CMDS_Flare_Intv_Wheel_Step = counter(),
	
	CMDS_RIO_Left_Grip_Hat_V = counter(),
	CMDS_RIO_Left_Grip_Hat_H = counter(),
	CMDS_RIO_Right_Grip_Hat_V = counter(),
	CMDS_RIO_Right_Grip_Hat_H = counter(),

    -- Nav System (all related panel switches/buttons/knobs)
    NAV_Btn_Steer_TCN = counter(),
    NAV_Btn_Steer_DEST = counter(),
    NAV_Btn_Steer_VEC = counter(),
    NAV_Btn_Steer_MAN = counter(),
    NAV_Btn_Steer_AWL_PCD = counter(),


    -- ARA63 Panel
    ARA63_Power_Switch = counter(),
	ARA63_Power_Switch_Toggle = counter(),
    ARA63_BIT_Btn = counter(),
    ARA63_Chnl_Knob = counter(),
	ARA63_Chnl_Knob_Step = counter(),


    -- TACAN CMD
    TACAN_CMD_Btn_Pilot = counter(),
    TACAN_CMD_Btn_RIO = counter(),

    -- TACAN Pilot control panel
    TACAN_Knob_Func_Pilot = counter(),
	TACAN_Knob_Func_STEP_Pilot = counter(),
    TACAN_Knob_Vol_Pilot = counter(),
	TACAN_Knob_Vol_STEP_Pilot = counter(),
    TACAN_Knob_Chnl_Tens_Pilot = counter(),
    TACAN_Knob_Chnl_Tens_Step_Pilot = counter(),
    TACAN_Knob_Chnl_Ones_Pilot = counter(),
    TACAN_Knob_Chnl_Ones_Step_Pilot = counter(),
    TACAN_Btn_BIT_Pilot = counter(),
    TACAN_Mode_Norm_Inv_Pilot = counter(),
    TACAN_Mode_X_Y_Pilot = counter(),
	TACAN_Mode_X_Y_TOGGLE_Pilot = counter(),

    -- TACAN RIO control panel
    TACAN_Knob_Func_RIO = counter(),
	TACAN_Knob_Func_STEP_RIO = counter(),
    TACAN_Knob_Vol_RIO = counter(),
	TACAN_Knob_Vol_STEP_RIO = counter(),
    TACAN_Knob_Chnl_Tens_RIO = counter(),
    TACAN_Knob_Chnl_Tens_Step_RIO = counter(),
    TACAN_Knob_Chnl_Ones_RIO = counter(),
    TACAN_Knob_Chnl_Ones_Step_RIO = counter(),
    TACAN_Btn_BIT_RIO = counter(),
    TACAN_Mode_Norm_Inv_RIO = counter(),
    TACAN_Mode_X_Y_RIO = counter(),
	TACAN_Mode_X_Y_TOGGLE_RIO = counter(),

    -- Radio
    RADIO_UHF_Remote_DISP_BRT_Pilot = counter(),
	RADIO_UHF_Remote_DISP_BRT_STEP_Pilot = counter(),
	RADIO_UHF_Remote_DISP_TEST_Pilot = counter(),
	RADIO_UHF_Remote_DISP_BRT_RIO = counter(),
	RADIO_UHF_Remote_DISP_BRT_STEP_RIO = counter(),
	RADIO_UHF_Remote_DISP_TEST_RIO = counter(),
    RADIO_VHF_Remote_DISP_BRT_Pilot = counter(),
	RADIO_VHF_Remote_DISP_BRT_STEP_Pilot = counter(),
	RADIO_VHF_Remote_DISP_TEST_Pilot = counter(),

    -- ARC 159 Pilot
    RADIO_UHF_VOL_Pilot = counter(),
	RADIO_UHF_VOL_STEP_Pilot = counter(),
	RADIO_UHF_VOL_RIO = counter(),
	RADIO_UHF_VOL_STEP_RIO = counter(),
    RADIO_UHF_BRT_Pilot = counter(),
	RADIO_UHF_BRT_STEP_Pilot = counter(),
    RADIO_UHF_SQL_Pilot = counter(),
	RADIO_UHF_SQL_TOGGLE_Pilot = counter(),
    RADIO_UHF_FREQ_HUNDRED_TEN_Pilot = counter(),
    RADIO_UHF_FREQ_UNIT_Pilot = counter(),
    RADIO_UHF_FREQ_TEHTH_Pilot = counter(),
    RADIO_UHF_FREQ_HUNDREDTH_Pilot = counter(),
    RADIO_UHF_FUNC_Pilot = counter(),
	RADIO_UHF_FUNC_STEP_Pilot = counter(),
    RADIO_UHF_CHAN_Pilot = counter(),
	RADIO_UHF_CHAN_STEP_Pilot = counter(),
    RADIO_UHF_FREQ_MODE_Pilot = counter(),
	RADIO_UHF_FREQ_MODE_STEP_Pilot = counter(),
    RADIO_UHF_READ_Pilot = counter(),
    RADIO_UHF_LOAD_Pilot = counter(),
    RADIO_UHF_TONE_Pilot = counter(),

    -- ICS
    RADIO_ICS_Vol_Pilot = counter(),
	RADIO_ICS_Vol_Step_Pilot = counter(),
    RADIO_ICS_Ampl_Pilot = counter(),
    RADIO_ICS_Func_Pilot = counter(),
    RADIO_ICS_Button_ICS_Pilot = counter(),
	RADIO_ICS_Button_UHF1_Pilot = counter(),
	RADIO_ICS_Button_UHF2_Pilot = counter(),
    RADIO_ICS_Vol_RIO = counter(),
	RADIO_ICS_Vol_Step_RIO = counter(),
    RADIO_ICS_Ampl_RIO = counter(),
    RADIO_ICS_Func_RIO = counter(),
    RADIO_ICS_Button_ICS_RIO = counter(),
	RADIO_ICS_Button_MIC_RIO = counter(),
    RADIO_ICS_ButtonAxisThresh_ICS_RIO = counter(),
	RADIO_ICS_ButtonAxisThresh_MIC_RIO = counter(),
	--RADIO_ICS_Vol_ALR45 = counter(), 			-- F-14A
	--RADIO_ICS_Vol_Step_ALR45 = counter(), 	-- F-14A
	--RADIO_ICS_Vol_ALR50 = counter(), 			-- F-14A
	--RADIO_ICS_Vol_Step_ALR50 = counter(), 	-- F-14A
	RADIO_ICS_Vol_ALR67_Pilot = counter(),
	RADIO_ICS_Vol_Step_ALR67_Pilot = counter(),
	RADIO_ICS_Vol_Sidewinder = counter(),
	RADIO_ICS_Vol_Step_Sidewinder = counter(),
	RADIO_ICS_XMTR_SEL_RIO = counter(),
	RADIO_ICS_XMTR_SEL_TOGGLE_RIO = counter(),

    -- ARC 182 RIO
    RADIO_VHF_VOL_RIO = counter(),
	RADIO_VHF_VOL_STEP_RIO = counter(),
	RADIO_VHF_VOL_PILOT = counter(),
	RADIO_VHF_VOL_STEP_PILOT = counter(),
    RADIO_VHF_BRT_RIO = counter(),
	RADIO_VHF_BRT_STEP_RIO = counter(),
    RADIO_VHF_SQL_RIO = counter(),
	RADIO_VHF_SQL_TOGGLE_RIO = counter(),
    RADIO_VHF_FREQ_HUNDRED_TEN_RIO = counter(),
    RADIO_VHF_FREQ_UNIT_RIO = counter(),
    RADIO_VHF_FREQ_TEHTH_RIO = counter(),
    RADIO_VHF_FREQ_HUNDREDTH_RIO = counter(),
    RADIO_VHF_FUNC_RIO = counter(),
	RADIO_VHF_FUNC_STEP_RIO = counter(),
    RADIO_VHF_CHAN_RIO = counter(),
	RADIO_VHF_CHAN_STEP_RIO = counter(),
    RADIO_VHF_FREQ_MODE_RIO = counter(),
	RADIO_VHF_FREQ_MODE_STEP_RIO = counter(),
    RADIO_VHF_FM_AM_RIO = counter(),
	RADIO_VHF_FM_AM_TOGGLE_RIO = counter(),
    RADIO_VHF_TOD_RIO = counter(),
    RADIO_VHF_NORM_AJ_RIO = counter(),
	
	-- KY-28
	RADIO_KY28_POWER_MODE = counter(),
	RADIO_KY28_POWER_MODE_TOGGLE = counter(),
	RADIO_KY28_RADIO_SELECTOR = counter(),
	RADIO_KY28_RADIO_SELECTOR_TOGGLE = counter(),
	RADIO_KY28_ZEROIZE = counter(),

    -- Spoiler Overrides
    SPOIL_Inboard_Override_Cover = counter(),
    SPOIL_Outboard_Override_Cover = counter(),
    SPOIL_Inboard_Override = counter(),
    SPOIL_Outboard_Override = counter(),
	
	-- AHRS / Compass
	AHRS_HDG_PushButton = counter(),
	AHRS_HDG_Rotate = counter(),
	AHRS_ModeSwitch = counter(),
	AHRS_ModeSwitch_STEP = counter(),
	AHRS_NorthSouth = counter(),
	AHRS_NorthSouth_TOGGLE = counter(),
	AHRS_LatCorrection = counter(),
	AHRS_LatCorrection_STEP = counter(),

    -- Radar
    RADAR_elevation_bars_change = counter(),
    RADAR_azimuth_scan_change = counter(),
    RADAR_elevation_bars_knob = counter(),
    RADAR_azimuth_scan_knob = counter(),
    RADAR_elevation_updown = counter(),
    RADAR_azimuth_leftright = counter(),
    RADAR_elevation_center_knob = counter(),
    RADAR_azimuth_center_knob = counter(),
    RADAR_VSL_switch = counter(),
    RADAR_stab_switch = counter(),
    RADAR_DDD_range_5 = counter(),
    RADAR_DDD_range_10 = counter(),
    RADAR_DDD_range_20 = counter(),
    RADAR_DDD_range_50 = counter(),
    RADAR_DDD_range_100 = counter(),
    RADAR_DDD_range_200 = counter(),
    RADAR_DDD_filter = counter(),
    RADAR_DDD_WCS_PSRCH = counter(),
    RADAR_DDD_WCS_TWSMAN = counter(),
    RADAR_DDD_WCS_TWSAUTO = counter(),
    RADAR_DDD_WCS_RWS = counter(),
    RADAR_DDD_WCS_PDSRCH = counter(),
    RADAR_DDD_WCS_PSTT = counter(),
    RADAR_DDD_WCS_PDSTT = counter(),
    RADAR_DDD_display_IFF = counter(),
    RADAR_DDD_display_IR = counter(),
    RADAR_DDD_display_radar = counter(),
    RADAR_DDD_aspect = counter(),
    RADAR_DDD_Vc_scale = counter(),
    RADAR_DDD_tgts = counter(),
    RADAR_DDD_MLC = counter(),
    RADAR_DDD_AGC = counter(),
    RADAR_DDD_paramp = counter(),
    RADAR_IR_gain = counter(),
    RADAR_IR_volume = counter(),
    RADAR_IR_threshold = counter(),
    RADAR_DDD_bright = counter(),
    RADAR_DDD_pulse_vid = counter(),
    RADAR_DDD_erase = counter(),
    RADAR_DDD_pulse_gain = counter(),
    RADAR_ACM_thresh = counter(),
    RADAR_jamjet = counter(),
    RADAR_PD_thresh_clutter = counter(),
    RADAR_PD_thresh_clear = counter(),

    --Radar Altimeter
    RADARALT_Knob = counter(),
    RADARALT_Test = counter(),

    --Altimeter
    ALTIMETER_Knob = counter(),
    ALTIMETER_Mode = counter(),
	
	-- Accelerometer
	ACCEL_Reset = counter(),

    --Rio altimeter
    RIOALTIMETER_Knob = counter(),
    RIOALTIMETER_Mode = counter(),


    --Airspeed indicator
    AIRSPEED_Knob = counter(),
    AIRSPEED_KnobSwitch = counter(),

    -- TCS
    TCS_toggle_FOV = counter(),
    TCS_FOV_button = counter(),
    TCS_ACQ_switch = counter(),
    TCS_Slave_switch = counter(),

	-- LANTIRN
	LANTIRN_TCS_Select = counter(),
	LANTIRN_TCS_Select_Toggle = counter(),
	LANTIRN_XAxis = counter(),
	LANTIRN_YAxis = counter(),
	LANTIRN_TriggerHalf = counter(),
	LANTIRN_TriggerFull = counter(),
	LANTIRN_LaserLatched = counter(),
	LANTIRN_Undesignate = counter(),
	LANTIRN_PointTrack = counter(),
	LANTIRN_AreaTrack = counter(),
	LANTIRN_QHUD_QADL = counter(),
	LANTIRN_QDES = counter(),
	LANTIRN_QSNO = counter(),
	LANTIRN_QWP_Minus = counter(),
	LANTIRN_QWP_Plus = counter(),
	LANTIRN_ToggleFOV = counter(),
	LANTIRN_ToggleWHOTBHOT = counter(),
	
	LANTIRN_S1Slider = counter(),
	LANTIRN_QHATLeft = counter(),
	
	LANTIRN_Laser_ARM = counter(),
	LANTIRN_Laser_ARM_Toggle = counter(),

    -- CAP
    CAP_button1 = counter(),
    CAP_button2 = counter(),
    CAP_button3 = counter(),
    CAP_button4 = counter(),
    CAP_button5 = counter(),
    CAP_button6 = counter(),
    CAP_button7 = counter(),
    CAP_button8 = counter(),
    CAP_button9 = counter(),
    CAP_button10 = counter(),
    CAP_tng_nbr = counter(),
    CAP_program_restart = counter(),
    CAP_category = counter(), -- see also CAP_category_cw/ccw further down
    CAP_clear = counter(),
    CAP_SW = counter(),
    CAP_NE = counter(),
    CAP_enter = counter(),
    CAP_BRG_0 = counter(),
    CAP_LAT_1 = counter(),
    CAP_NBR_2 = counter(),
    CAP_SPD_3 = counter(),
    CAP_ALT_4 = counter(),
    CAP_RNG_5 = counter(),
    CAP_LONG_6 = counter(),
    CAP_7 = counter(),
    CAP_HDG_8 = counter(),
    CAP_9 = counter(),

    CAP_BIT_DISP1 = counter2(),
    CAP_BIT_CMPTR2 = counter2(),
    CAP_BIT_AMCS3 = counter2(),
    CAP_BIT_MASMOAT4 = counter2(),
    CAP_BIT_FAULT = counter2(),
    CAP_BIT_RCVR5 = counter2(),
    CAP_BIT_XMTR6 = counter2(),
    CAP_BIT_ANTIR7 = counter2(),
    CAP_BIT_STT8 = counter2(),
    CAP_BIT_SPLNBR = counter2(),

    CAP_SPL_HOMEHELI = counter2(),
    CAP_SPL_IFT = counter2(),
    CAP_SPL_IP2TGT = counter2(),
    CAP_SPL_GSS = counter2(),
    CAP_SPL_A2G = counter2(),
    CAP_SPL_LD_TDRS = counter2(),
    CAP_SPL_BIT_MV_TGT = counter2(),
    CAP_SPL_OBC_BIT = counter2(),
    CAP_SPL_MAINT_DISP = counter2(),
    CAP_SPL_OBC_DISP = counter2(),

    CAP_NAV_OWNAC = counter2(),
    CAP_NAV_STORED_HDG = counter2(),
    CAP_NAV_TARPS_NAVFIX = counter2(),
    CAP_NAV_WIND_SPD_HDG = counter2(),
    CAP_NAV_TARPS = counter2(),
    CAP_NAV_TACAN_FIX = counter2(),
    CAP_NAV_RDR_FIX = counter2(),
    CAP_NAV_VIS_FIX = counter2(),
    CAP_NAV_FIX_ENABLE = counter2(),
    CAP_NAV_MAGVAR_HDG = counter2(),

    CAP_TAC_WP1 = counter2(),
    CAP_TAC_WP2 = counter2(),
    CAP_TAC_WP3 = counter2(),
    CAP_TAC_FIX = counter2(),
    CAP_TAC_IP = counter2(),
    CAP_TAC_HOME = counter2(),
    CAP_TAC_DEF = counter2(),
    CAP_TAC_HOST = counter2(),
    CAP_TAC_SURF = counter2(),
    CAP_TAC_PT2PT = counter2(),

    CAP_DL_WILCO = counter2(),
    CAP_DL_CANTCO = counter2(),
    CAP_DL_NAVGRID = counter2(),
    CAP_DL_TIDAVIA = counter2(),
    CAP_DL_FFNAV = counter2(),
    CAP_DL_POINT = counter2(),
    CAP_DL_ENGAGE = counter2(),
    CAP_DL_FLRP = counter2(),
    CAP_DL_AVIAACLS = counter2(),
    CAP_DL_FFAUTO_RSTT = counter2(),

    CAP_TGT_MANDATTK = counter2(),
    CAP_TGT_DONTATTK = counter2(),
    CAP_TGT_IFTAUXLAUNCH = counter2(),
    CAP_TGT_DATATRANS = counter2(),
    CAP_TGT_TESTTGT = counter2(),
    CAP_TGT_FRIEND = counter2(),
    CAP_TGT_UNKNOWN = counter2(),
    CAP_TGT_HOSTILE = counter2(),
    CAP_TGT_MULTITGT = counter2(),
    CAP_TGT_SYMDEL = counter2(),

    -- misc
    STDBYADI_uncage = counter(),
    STDBYADI_trim = counter(),
    STDBYADI_RIO_uncage = counter(),
    STDBYADI_RIO_trim = counter(),
    ACCEL_adjust = counter(),



    --Jester AI
    JESTER_ToggleMenu = counter(),
    JESTER_Command1 = counter(),
    JESTER_Command2 = counter(),
    JESTER_Command3 = counter(),
    JESTER_Command4 = counter(),
    JESTER_Command5 = counter(),
    JESTER_Command6 = counter(),
    JESTER_Command7 = counter(),
    JESTER_Command8 = counter(),
	JESTER_MenuHorizontal = counter(),
	JESTER_MenuVertical = counter(),
	JESTER_MenuDiag45 = counter(),
	JESTER_MenuDiag135 = counter(),
	
    JESTER_Spot = counter(),
    JESTER_Quiet = counter(),
    JESTER_EjectConfig = counter(),


    -- Jester nav
    JESTER_Steerpoint_SP1 = counter(),
    JESTER_Steerpoint_SP2 = counter(),
    JESTER_Steerpoint_SP3 = counter(),
    JESTER_Steerpoint_FP = counter(),
    JESTER_Steerpoint_IP = counter(),
    JESTER_Steerpoint_ST = counter(),
    JESTER_Steerpoint_HB = counter(),
    JESTER_Steerpoint_MAN = counter(),

    -- Jester WVR and BVR
    JESTER_VSL_High = counter(),
    JESTER_VSL_Low = counter(),
    JESTER_TogglePDorPStt = counter(),
    JESTER_BreakLock = counter(),
    JESTER_Range_Auto = counter(),
    JESTER_Range_25 = counter(),
    JESTER_Range_50 = counter(),
    JESTER_Range_100 = counter(),
    JESTER_Range_200 = counter(),
    JESTER_Range_400 = counter(),
    JESTER_Lock_Ahead = counter(),
    JESTER_Lock_Ahead_Enemy = counter(),
    JESTER_Lock_Ahead_Friendly = counter(),
    JESTER_Ground_Stabilize = counter(),
    JESTER_Aircraft_Stabilize = counter(),
    JESTER_Radar_TWS = counter(),
    JESTER_Radar_RWS = counter(),

    -- nav command
    Mission_WPT_Next = counter(),
    Mission_WPT_Prev = counter(),

    -- ground kneeboard Adjustment
    KNEEBOARD_Laser100 = counter(),
    KNEEBOARD_Laser10 = counter(),
    KNEEBOARD_Laser1 = counter(),
    KNEEBOARD_gunburst = counter(),
    KNEEBOARD_ky28adj = counter(),

    -- Datalink (more further up)
    DATALINK_antijam = counter(),
    DATALINK_freq_10s = counter(),
    DATALINK_freq_1s = counter(),
    DATALINK_freq_tenths = counter(),
    DATALINK_power = counter(),
    DATALINK_antenna_pos = counter(),
    DATALINK_reply = counter(),
    DATALINK_tac_cains = counter(),
    DATALINK_addr_hi = counter(),
    DATALINK_addr_lo = counter(),

	RADIO_KY28_ZEROIZE_COVER = counter(),
	RADIO_KY28_ZEROIZE_COVER_TOGGLE = counter(),
	RIO_KY_MODE = counter(),
	RIO_UHF_UPR_LWR = counter(),
	RIO_STORAGE_BOX = counter(),
	
    LIGHTS_RedFlood_RIO = counter(),
    LIGHTS_WhiteFlood_RIO = counter(),
    LIGHTS_Instruments_RIO = counter(),
    LIGHTS_Console_RIO = counter(),

    -- Recorder
    RECORD_power = counter(),
    RECORD_mode = counter(),
    RECORD_standby_lamp = counter(),
    RECORD_rec_lamp = counter(),
    RECORD_endoftape_lamp = counter(),
    RECORD_Knob_Reset = counter(),
    RECORD_minutes_hi = counter(),
    RECORD_minutes_med = counter(),
    RECORD_minutes_low = counter(),

    -- IFF
    IFF_audiolight_switch = counter(),
    IFF_M1_switch = counter(),
    IFF_M2_switch = counter(),
    IFF_M3A_switch = counter(),
    IFF_MC_switch = counter(),
    IFF_RAD_switch = counter(),
    IFF_ident_switch = counter(),
    IFF_M4_switch = counter(),
    IFF_code_knob = counter(),
    IFF_master_knob = counter(),
    IFF_test_button = counter(),
    IFF_reply_button = counter(),

    IFF_M3code_1s = counter(),
    IFF_M3code_10s = counter(),
    IFF_M3code_100s = counter(),
    IFF_M3code_1000s = counter(),
    IFF_M1code_1s = counter(),
    IFF_M1code_10s = counter(),

    HCU_POWER_RESET_BUTTON = counter(),
    HCU_LIGHT_TEST_BUTTON = counter(),

    GEAR_Handle_Emergency = counter(),

    WindShield_Air = counter(),
    Temperature = counter(),
    TempAutoMan = counter(),
    RamAir = counter(),
    
	--Airspeed indicator RIO
    AIRSPEED_Knob_RIO = counter(),
    AIRSPEED_KnobSwitch_RIO = counter(),
	
	-- Additional Lights commands
	LIGHTS_Exterior_Master_Switch = counter(),
	LIGHTS_Exterior_Master_Switch_Toggle = counter(),
    LIGHTS_Taxi_Toggle = counter(),
    LIGHTS_RedFlood_Toggle = counter(),
    LIGHTS_WhiteFlood_Toggle = counter(),
    LIGHTS_PositionWings_Toggle = counter(),
    LIGHTS_PositionTail_Toggle = counter(),
    LIGHTS_PositionFlash_Toggle = counter(),
    LIGHTS_AntiCol_Toggle = counter(),
    LIGHTS_ACMPanel_Step = counter(),
    LIGHTS_Instruments_Step = counter(),
    LIGHTS_Console_Step = counter(),
    LIGHTS_Formation_Step = counter(),
	AoA_HookBypass_Toggle = counter(),
	AoA_IndexerStrength_Step = counter(),

    WEAP_Selective_Jett_cover = counter(),

    JESTER_Check = counter(),
    JESTER_LoudAndClear = counter(),
	JESTER_Pause = counter(),

	GEAR_LaunchBarAbort = counter(),
	GEAR_LaunchBarAbortCover = counter(),

    RADAR_bypass_wow = counter(),

    RADAR_elevation_center = counter(),
    RADAR_azimuth_center = counter(),
    RADAR_azimuth_analog_adjust = counter(),
    RADAR_elevation_analog_adjust = counter(),
    HCU_thumb_axis = counter(), -- also HCU_thumb
    HCU_thumb_center = counter(),
    HCU_thumb_analog_adjust = counter(),

    AUTO_StartPilot = counter(),
	
	LANTIRN_GPSZero = counter(),
	TID_VideoExportToggle = counter(),

	LANTIRN_MasterMode = counter(),
    CCM_SPL = counter(),
    CCM_ALT_DIFF = counter(),
    CCM_VGS = counter(),

	LANTIRN_PowerMode = counter(),
	LANTIRN_IBIT = counter(),

    BEACON_power_switch = counter(),
    BEACON_ACLS_test_button = counter(),
    BEACON_mode_knob = counter(),

    LIQUID_cooling_switch = counter(),
	
	LANTIRN_XAxisKey = counter(),
	LANTIRN_YAxisKey = counter(),
	LANTIRN_MasterModeToggle= counter(),

    JESTER_EnableLandingCallouts = counter(),

	LANTIRN_TriggerAxis = counter(),
	LANTIRN_S4_XAxis = counter(),
	LANTIRN_S4_YAxis = counter(),
	LANTIRN_S3_XAxis = counter(),
	LANTIRN_S3_YAxis = counter(),
	LANTIRN_OPER_STBY_Toggle = counter(),
	LANTIRN_PowerMode_Toggle = counter(),
	
	LIGHTS_RedFlood_RIO_Toggle = counter(),
    LIGHTS_WhiteFlood_RIO_Toggle = counter(),
	LIGHTS_Instruments_RIO_Step = counter(),
    LIGHTS_Console_RIO_Step = counter(),


    RIO_CLOCK_Wind = counter(),
    RIO_CLOCK_Timer = counter(),

    RADAR_DDD_erase_axis = counter(),
    RADAR_DDD_pulse_gain_axis = counter(),

    HOOK_Toggle = counter(), -- also see HOOK_Handle
    SPEEDBRAKE_Toggle = counter(), -- also see SPEEDBRAKE_ExtendRetract

    STICK_ShowHide = counter(),
    STICK_ShowHideToggle = counter(),
	
	-- SRS radio commands
	RADIO_ICS_Button_ICS_Pilot_Export_Only = counter(),
	RADIO_ICS_Button_UHF1_Pilot_Export_Only = counter(),
	RADIO_ICS_Button_UHF2_Pilot_Export_Only = counter(),
    RADIO_ICS_Button_ICS_RIO_Export_Only = counter(),
	RADIO_ICS_Button_MIC_RIO_Export_Only = counter(),
    RADIO_ICS_ButtonAxisThresh_ICS_RIO_Export_Only = counter(),
	RADIO_ICS_ButtonAxisThresh_MIC_RIO_Export_Only = counter(),


	JESTER_CloseMenu = counter(),

    AFCS_Stability_Pitch_Toggle = counter(),
    AFCS_Stability_Roll_Toggle = counter(),
    AFCS_Stability_Yaw_Toggle = counter(),

    FLAPS_Lever_Axis = counter(),

    WALKMAN_Side = counter(),

    -- PDCP toggles
    DISP_VDI_power_toggle = counter(),
    DISP_VDI_display_mode_toggle = counter(),
    DISP_VDI_landing_mode_toggle = counter(),
    DISP_HUD_power_toggle = counter(),
    DISP_HUD_declutter_toggle = counter(),
    DISP_HUD_AWL_mode_toggle = counter(),
    DISP_HSD_ECMD_power_toggle = counter(),
    HSD_Display_Mode_Cycle_toggle = counter(),
    HSD_ECM_Override_toggle = counter(),

    -- autopilot toggles
    -- AP_Engage_Toggle already defined
    AP_Altitude_toggle = counter(),
    AP_Vector_toggle_offvec = counter(),
    AP_Vector_toggle_offacl = counter(),
    AP_Heading_toggle_offgt = counter(),
    AP_Heading_toggle_offon = counter(),

    LIGHTS_Instruments_Step_RIO = counter(),
    LIGHTS_Console_Step_RIO = counter(),

    CAP_category_cw = counter(), -- see also CAP_category further up
    CAP_category_ccw = counter(), -- see also CAP_category further up

    CARRIER_ballcall = counter(),
    TCS_Trim_az = counter(), -- command for the RIO cockpit knob
    TCS_Trim_el = counter(),
    TCS_Trim_az_axis = counter(), -- command for the bindable axis
    TCS_Trim_el_axis = counter(),
    TCS_Trim_az_adjust = counter(), -- command for the inc/dec bindable keys
    TCS_Trim_el_adjust = counter(),

	HUD_ShowHide = counter(),

    ENGINE_AfterBurner_Gate = counter(),
    ENGINE_Mid_Compression_Bypass_CB = counter(),
    ENGINE_Backup_Ignition = counter(),

    CANOPY_Drop_RIO = counter(),

    JESTER_LANTIRN_inhibit_auto_designate = counter(),
    JESTER_LANTIRN_track_target_id = counter(),
    JESTER_LANTIRN_track_zone_id = counter(),
    JESTER_LANTIRN_designate = counter(),

    BRAKE_AntiSkidAndSpoilerBrake_toggle = counter(),
    PilotOxygen_toggle = counter(),
    WINGSWEEP_EmergencySweepCover_toggle = counter(),
    ENGINE_Probe_Anti_Ice_toggle = counter(),
    ENGINE_Asym_LimiterCover_toggle = counter(),
    ENGINE_Asym_Limiter_toggle = counter(),
    HYD_TRANSFER_PUMP_Switch_toggle = counter(),
    HYD_TRANSFER_PUMP_SwitchCover_toggle = counter(),
    FUELSYSTEM_Fuel_Feed_Cover_toggle = counter(),
    FUELSYSTEM_Fuel_Feed_toggle = counter(),

    HSD_Knob_Brightness_axis = counter(),
    HSD_Knob_Heading_axis = counter(),
    HSD_Knob_Course_axis = counter(),
    RADIO_ICS_Vol_Pilot_axis = counter(),
    RADIO_ICS_Vol_RIO_axis = counter(),
    RADIO_ICS_Vol_Sidewinder_axis = counter(),
    RADIO_ICS_Vol_ALR67_Pilot_axis = counter(),
    RWR_ALR67_Volume_axis = counter(),
    RADIO_VHF_VOL_PILOT_axis = counter(),
    RADIO_VHF_VOL_RIO_axis = counter(),
    VDIG_HUD_bright_axis = counter(),
    VDIG_HUD_trim_axis = counter(),
    VDIG_VSDI_bright_axis = counter(),
    VDIG_VDI_contrast_axis = counter(),
    VDIG_VSDI_trim_axis = counter(),
    TACAN_Knob_Vol_Pilot_axis = counter(),
    TACAN_Knob_Vol_RIO_axis = counter(),
    HSD_Knob_Brightness_IncDec = counter(),
    VDIG_HUD_bright_step = counter(),
    VDIG_HUD_trim_step = counter(),
    VDIG_VSDI_bright_step = counter(),
    VDIG_VDI_contrast_step = counter(),
    VDIG_VSDI_trim_step = counter(),

    Jester_tune_ARC_182_channel = counter(),
    Jester_tune_TACAN_channel = counter(),

    DLC_mock_axis = counter(),  --unused
    Emergency_Wingsweep_axis = counter(),
    Emergency_Wingsweep_step = counter(),
    WEAP_ATTK_Mode_step = counter(),
    WEAP_Elec_Fuse_step = counter(),
    WEAP_MSL_SPD_Gate_step = counter(),
    TID_mode_knob_step = counter(),
    TID_range_knob_step = counter(),
    RADARALT_Knob_step = counter(),
    BIT_Selector_step = counter(),
    BIT_SelectorPush_toggle = counter(),
    VDIG_VDI_handle_toggle = counter(),
    WINGSWEEP_EmergencyLeverExtended_toggle = counter(),

    RADIO_ICS_Ampl_RIO_step = counter(),
    WEAP_Interval_10s_step = counter(),
    WEAP_Interval_100s_step = counter(),
    WEAP_Quantity_10s_step = counter(),
    WEAP_Quantity_1s_step = counter(),
    WEAP_Type_Wheel_step = counter(),
    RADAR_DDD_pulse_vid_step = counter(),
    RADAR_DDD_bright_step = counter(),
    RADAR_DDD_pulse_gain_step = counter(),
    RADAR_DDD_erase_step = counter(),
    TID_nav_mode_step = counter(),
    TID_dest_mode_step = counter(),
    TID_contrast_step = counter(),
    TID_bright_step = counter(),
    ECMD_Knob_Brightness_step = counter(),
    DECM_Mode_Knob_step = counter(),
    DECM_Vol_Knob_step = counter(),
    WEAP_Type_Wheel_axis = counter(),
    RADAR_DDD_pulse_vid_axis = counter(),
    RADAR_DDD_bright_axis = counter(),
    TID_contrast_axis = counter(),
    TID_bright_axis = counter(),
    ECMD_Knob_Brightness_axis = counter(),
    DECM_Vol_Knob_axis = counter(),
    --ENGINE_MCB_Test_Switch = counter(),

    Jester_DEST_knob = counter(),
    Jester_active_wpt_entry = counter(),
    Jester_active_wpt_from_trigger_zone = counter(),
    Jester_WCS = counter(),
    Jester_RWR_BIT = counter(),
    Jester_TID_range = counter(),
    Jester_eject_RIO = counter(),
    Jester_radar_track_target_id = counter(),
    Jester_radar_drop_track = counter(),
    Jester_wpn_station_state = counter(),
    Jester_wpn_bomb_type_selector = counter(),
    Jester_wpn_attk_mode = counter(),
    Jester_wpn_dlvy_mode = counter(),
    Jester_wpn_dlvy_optns_interval = counter(),
    Jester_wpn_dlvy_optns_qty = counter(),
    Jester_wpn_aa_launch = counter(),
    Jester_wpn_aa_launch = counter(),
    Jester_wpn_aa_launch = counter(),
    Jester_radar_azimuth = counter(),
    Jester_radar_elevation = counter(),
}
