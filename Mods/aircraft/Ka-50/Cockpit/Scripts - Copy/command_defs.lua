-- Commands : not intended for end-user editing

Keys =
{
	PlaneGear								= 68,
	PlaneFonar								= 71,
	PlaneSalvoOnOff							= 81,
	PlaneFire								= 84,
	PlaneFireOff							= 85,
	PlaneEOSOnOff							= 87,

	iCommandPlaneRadarLeft					= 88,
	iCommandPlaneRadarRight					= 89,
	iCommandPlaneRadarUp					= 90,
	iCommandPlaneRadarDown					= 91,
	iCommandPlaneRadarCenter				= 92,
	iCommandPlaneRadarStop					= 235,
				
   	PlaneTrimOn								= 957,
	PlaneTrimOff							= 958,
	PlaneTrimCancel							= 97,

	iCommandPlaneChangeLock					= 100,
	PlaneChangeWeapon						= 101,
	PlaneChangeWaypoint						= 102,
	PlaneZoomIn								= 103,
	PlaneZoomOut							= 104,
	PlaneModeNAV							= 105,
	PlaneModeBVR							= 106,
	PlaneModeVS								= 107,
	PlaneModeBore							= 108,
	PlaneModeHelmet							= 109,
	PlaneModeFI0							= 110,
	PlaneModeGround							= 111,
	PlaneModeGrid							= 112,
	PlaneModeCannon							= 113,

	iCommandSelecterLeft					= 139,
	iCommandSelecterRight					= 140,
	iCommandSelecterUp						= 141,
	iCommandSelecterDown					= 142,
    iCommandSelecterUpRight                 = 226,
    iCommandSelecterDownRight               = 227,
    iCommandSelecterDownLeft                = 228,
    iCommandSelecterUpLeft                  = 229,
    iCommandSelecterStop                    = 230,
       
    
    
	iCommandPlaneRadarChangeMode			= 285,
					
	iCommandRefusalTWS						= 143,
	
	PlaneBrightnessILS						= 156,
	PlaneLightsOnOff						= 175,
	PlaneHeadLightOnOff						= 328,
	PlaneHUDFilterOnOff						= 247,
	
	iCommandDecreaseRadarScanArea			= 262,
	iCommandIncreaseRadarScanArea			= 263,
	
	--[[ WARNING SYSTEM ]]--
	PlaneMasterCaution						= 252,
	
	PlaneScalesReject						= 253,
	PlaneBettyRepeat						= 254,
	ChangeGunRateOfFire						= 280,
	ChangeRippleQuantity					= 281,
	ChangeRippleInterval					= 282,
	SwitchMasterArm							= 283,
	ChangeReleaseMode						= 284,
	PlaneCockpitIllumination				= 300,
	ChangeRippleIntervalDown				= 308,
    
    EnginesStart = 309,		-- Запуск двигателей
    EnginesStop  = 310,		-- Выключение двигателей
    iCommandHelicopter_TC_RPM               =             820 ,
    iCommandHelicopter_TC_RPM_Cover         =             821 ,
    iCommandHelicopter_Engine_Temperature_Control_Cover = 823 ,
    iCommandHelicopter_Engine_Temperature_Control       = 822 ,


    
    
    
	PlaneLaunchPermissionOverride			= 349,
	PlanePickleOn							= 350,
	PlanePickleOff							= 351,
	
    
    
	--[[ UV-26 ]]--
	PlaneCMDDispence						= 364,
	PlaneCMDDispenceOff						= 365,
	PlaneCMDDispenceStop					= 366,
	PlaneCMDDispenceStopOff					= 367,
	PlaneCMDChangeRippleQuantity			= 368,
	PlaneCMDChangeRippleQuantityOff 		= 369,
	PlaneCMDChangeRippleInterval			= 370,
	PlaneCMDChangeRippleIntervalOff 		= 371,
	PlaneCMDChangeBurstAmount				= 372,
	PlaneCMDChangeBurstAmountOff			= 373,
	PlaneCMDCancelCurrentProgram			= 374,
	PlaneCMDCancelCurrentProgramOff 		= 375,
	PlaneCMDChangeBoard						= 376,
	PlaneCMDShowAmountOrProgram				= 377,
	
	--[[ PVR ]]--
	PlaneCancelWeaponsDelivery				= 378,
	
	--[[ WARNING SYSTEM ]]--
	PlaneMasterCautionOff					= 379,
	
	PlaneLaserRangerOnOff					= 392,
	PlaneIncreaseBase_Distance				= 412,
	PlaneDecreaseBase_Distance				= 413,
	PlaneStopBase_Distance					= 414,
	PlaneGearUp								= 430,
	PlaneGearDown							= 431,
	PlaneNightVisionGogglesOnOff			= 438,
	PlaneDesignate_CageOn					= 439,
	PlaneDesignate_CageOff					= 440,
	PlaneDesignate_CageOn_vertical			= 441,
	PlaneDesignate_CageOn_horizontal		= 442,
	
	--[[ DATALINK ]]--
	PlaneDLK_Target1						= 443,
	PlaneDLK_Target2						= 444,
	PlaneDLK_Target3						= 445,
	PlaneDLK_RefPoint						= 446,
	PlaneDLK_Wingman1						= 447,
	PlaneDLK_Wingman2						= 448,
	PlaneDLK_Wingman3						= 449,
	PlaneDLK_Wingman4						= 450,
	PlaneDLK_All							= 451,
	PlaneDLK_Erase							= 452,
	PlaneDLK_Ingress						= 453,
	PlaneDLK_SendMemory						= 454,
	
	--[[ PVI ]]--
	PlaneNavChangePanelModeRight			= 455,
	PlaneNavChangePanelModeLeft				= 456,
	PlaneNavSetFixtakingMode				= 457,
	PlaneNav_DLK_OnOff						= 458,
	PlaneNav_PB1							= 459,
	PlaneNav_PB2							= 460,
	PlaneNav_PB3							= 461,
	PlaneNav_PB4							= 462,
	PlaneNav_PB5							= 463,
	PlaneNav_PB6							= 464,
	PlaneNav_PB7							= 465,
	PlaneNav_PB8							= 466,
	PlaneNav_PB9							= 467,
	PlaneNav_PB0							= 468,
	PlaneNav_Steerpoints					= 469,
	PlaneNav_INU_realign					= 470,
	PlaneNav_POS_corrMode					= 471,
	PlaneNav_INU_precise_align				= 472,
	PlaneNav_Airfields						= 473,
	PlaneNav_INU_normal_align				= 474,
	PlaneNav_Targets						= 475,
	PlaneNav_Enter							= 476,
	PlaneNav_Cancel							= 477,
	PlaneNav_POS_init						= 478,
	PlaneNav_SelfCoord						= 479,
	PlaneNav_CourseTimeRange				= 480,
	PlaneNav_Wind							= 481,
	PlaneNav_THeadingTimeRangeF				= 482,
	PlaneNav_BearingRangeT					= 483,	
	PlaneCockpitIlluminationPanels			= 493,
	PlaneCockpitIlluminationGauges			= 494,	
	Plane_ABRIS_Power						= 495,
	Plane_ABRIS_BT_1						= 496,
	Plane_ABRIS_BT_2						= 497,
	Plane_ABRIS_BT_3						= 498,
	Plane_ABRIS_BT_4						= 499,
	Plane_ABRIS_BT_5						= 500,
	Plane_ABRIS_Axis_Increase				= 501,
	Plane_ABRIS_Axis_Decrease				= 502,
	Plane_ABRIS_Axis_Push					= 503,
	Plane_ABRIS_Brightness_Increase			= 504,
	Plane_ABRIS_Brightness_Decrease 		= 505,
	
	Plane_RouteMode							= 506,
	Plane_DescentMode						= 507,
	Plane_DescentModeOff					= 508,
	Plane_LockOn_start						= 509,
	Plane_LockOn_finish						= 510,
	
	Plane_SpotLight_left					= 511,
	Plane_SpotLight_right					= 512,
	Plane_SpotLight_up						= 513,
	Plane_SpotLight_down					= 514,
	Plane_SpotLight_vert_stop		    	= 515,
    Plane_SpotLight_hor_stop                = 380,	
	
	PlaneRotorTipLights						= 516,
	
	Plane_SpotSelect_switch					= 517,
	PlaneAntiCollisionLights				= 518,
	PlaneNavLights_CodeModeOn				= 519,
	PlaneNavLights_CodeModeOff				= 520,
	PlaneFormationLights					= 521,
	
	
	Plane_AutomaticTracking_Gunsight_switch = 524,
	Plane_K041_Power						= 525,
	Plane_AutomaticTurn						= 526,
	Plane_GroundMovingTarget				= 527,
	Plane_AirborneTarget					= 528,
	Plane_HeadOnAspect						= 529,
	Plane_ChangeDeliveryMode_right			= 530,
	Plane_ChangeDeliveryMode_left			= 531,

	Plane_WeaponMode_Manual_Auto			= 532,
	Plane_WeaponMode_switch					= 533,
	Plane_AmmoTypeSelect					= 534,
	Plane_FireRate							= 535,
	
	iCommandHelicopterHover             	= 537,
    iCommandHelicopterHover_up              = 385,		

    
    iCommandAutopilotEmergOFF_up            = 297,
	iCommandAutopilotEmergOFF				= 538,
	
	--ARK-25
	ADF_Homer_change						= 580,
	ADF_Channel_next						= 581,	
	ADF_Channel_prevous						= 582,
	ADF_Mode_change							= 583,
	ADF_Receiver_Mode_change				= 585,
	ADF_Volume_up							= 586,
	ADF_Volume_down							= 587,
	ADF_Test								= 588,
	
	iCommandHelicopter_PPR_button_K			= 590,
	iCommandHelicopter_PPR_button_H		    = 591,
	iCommandHelicopter_PPR_button_T			= 592,
	iCommandHelicopter_PPR_button_B			= 593,
	iCommandHelicopter_PPR_button_DIR   	= 594,
    
    iCommandHelicopter_PPR_button_K_up      = 301,
    iCommandHelicopter_PPR_button_H_up      = 302,
    iCommandHelicopter_PPR_button_T_up      = 303,
    iCommandHelicopter_PPR_button_B_up      = 304,
    iCommandHelicopter_PPR_button_DIR_up    = 305,
    
	PPR_BAR_RV								= 595,
	
	Selected_Engine_start 					= 596,
	Selected_Engine_stop					= 597,
	APU_stop								= 598,
	Engine_Select							= 599,
	Left_Engine_Break						= 600,
	Right_Engine_Break						= 601,
	Rotor_Break								= 605,
	
	R_800_1st_wheel_up						= 607,
	R_800_1st_wheel_down					= 608,
	R_800_2nd_wheel_up						= 609,
	R_800_2nd_wheel_down					= 610,
	R_800_3rd_wheel_up						= 611,
	R_800_3rd_wheel_down					= 612,
	R_800_4th_wheel_up						= 613,
	R_800_4th_wheel_down					= 614,
	R_800_Noise_Reductor_on_off				= 615,
	R_800_Modulation_change					= 616,
	R_800_50_100_switch						= 617,
	R_800_ADF_Sound_switch					= 618,
	R_800_Emergency_Radio					= 619,
	R_800_Test								= 620,
	R_800_Power_on_off						= 621,

	R_828_Channel_next						= 622,
	R_828_Channel_prevous					= 623,
	R_828_Noise_Reductor_on_off				= 624,
	R_828_ASU								= 625,
	R_828_volume_up							= 626,
	R_828_volume_down						= 627,
	R_828_Power_on_off						= 628,

	SPU9_SPU_9_on_off						= 629,
	SPU9_radio_change						= 630,

	NOP_netID_set							= 638,
	
	DLK_Self_ID_change						= 640,
	DLK_mode_change							= 641,
	
	GroundPowerDC							= 704,
	GroundPowerDC_Cover						= 705,
	
	PowerBattery1							= 706,
	PowerBattery1_Cover						= 707,
	
	PowerBattery2							= 708,
	PowerBattery2_Cover						= 709,
	
	GroundPowerAC							= 710,
	PowerGeneratorLeft						= 711,
	PowerGeneratorRight						= 712,
	ElectricalPowerInverter					= 713,
	
	DatalinkTLK								= 714,
	DatalinkUHF_TLK							= 715,

	DatalinkUHF_SA							= 716,

	FuelPumpsTankForward					= 717,
	FuelPumpsTankRear						= 718,
	FuelExternalPumpsTanksInner				= 719,
	FuelExternalPumpsTanksOuter				= 720,
	FuelmeterPower							= 721,
	
	LeftEngineFuelValveShutOff				= 722,
	LeftEngineFuelValveShutOffCover			= 723,
	
	RightEngineFuelValveShutOff				= 724,
	RightEngineFuelValveShutOffCover		= 725,
	
	APUFuelValveShutOff						= 726,
	APUFuelValveShutOffCover				= 727,
	
	FuelCrossfeedValve						= 728,
	FuelCrossfeedValveCover					= 729,

	EjectingSystemPower1					= 730,
	EjectingSystemPower1Cover				= 731,
	
	EjectingSystemPower2					= 732,
	EjectingSystemPower3					= 733,
	
	WeaponsControlSystem					= 734,
	WeaponsControlSystemCover				= 735,
	
	MainHydraulics							= 736,
	MainHydraulicsCover						= 737,
	
	IFF_Power								= 738,
	IFF_PowerCover							= 739,
	
	TargetingNavigationSystemsPower			= 740,

	ElectronicControlSystemLeftEngine		= 741,
	ElectronicControlSystemLeftEngineCover	= 742,
	
	ElectronicControlSystemRightEngine		= 743,
	ElectronicControlSystemRightEngineCover = 744,
	
	HeadingMethodSwitch						= 745,
	
	HUDBrightnessUp							= 746,
	HUDBrightnessDown						= 747,
	
	HUDTest									= 748,
	HUDTest_up								= 749,

	EmergencyGear							= 750,
	EmergencyGearCover						= 751,

	MechClock_LeftLever_Down				= 752,
	MechClock_LeftLever_Down_up				= 753,
	MechClock_LeftLever_Up					= 754,
	MechClock_LeftLever_TurnLeft			= 755,
	MechClock_LeftLever_TurnRight			= 756,
	MechClock_RightLever_Down				= 757,
	MechClock_RightLever_Down_up			= 758,
	MechClock_RightLever_Rotate_left		= 759,
	MechClock_RightLever_Rotate_right		= 760,

	BKOMode									= 761,
	LampsControl							= 762,
	RotorRPMHigh							= 763,

	HSI_CourseRotaryLeft					= 764,
	HSI_CourseRotaryRight					= 765,
	HSI_HeadingRotaryLeft					= 766,
	HSI_HeadingRotaryRight					= 767,
	HSI_Test								= 768,
	HSI_Test_up								= 769,
	HSI_SteeringSelection					= 770,

	ADI_ZeroPitchTrimLeft					= 771,
	ADI_ZeroPitchTrimRight					= 772,
	ADI_Test								= 773,
	ADI_Test_up								= 774,
	ADI_TestCover							= 775,

	RALT_DangerousAltitudeRotaryLeft		= 776,
	RALT_DangerousAltitudeRotaryRight		= 777,
	RALT_Test								= 778,
	RALT_Test_up							= 779,
	
	PlaneDLK_Target1_up						= 780,
	PlaneDLK_Target2_up						= 781,
	PlaneDLK_Target3_up						= 782,
	PlaneDLK_RefPoint_up					= 783,
	PlaneDLK_Wingman1_up					= 784,
	PlaneDLK_Wingman2_up					= 785,
	PlaneDLK_Wingman3_up					= 786,
	PlaneDLK_Wingman4_up					= 787,
	PlaneDLK_All_up							= 788,
	PlaneDLK_Erase_up						= 789,
	PlaneDLK_Ingress_up						= 790,
	PlaneDLK_SendMemory_up					= 791,

	ADF_Test_up								= 792,
	R_800_Test_up							= 793,
	R_828_ASU_up							= 794,	
	
	Plane_AutomaticTurn_up					= 795,
	Plane_GroundMovingTarget_up				= 796,
	Plane_AirborneTarget_up					= 797,
	Plane_HeadOnAspect_up					= 798,
	Plane_CancelWeaponsDelivery_up			= 799,
	
	LampsControl_up							= 800,
	RotorRPMHigh_up							= 801,
	
	Selected_Engine_start_up				= 802,
	Selected_Engine_stop_up					= 803,
	APU_stop_up								= 804,
	
	Plane_ABRIS_BT_1_up						= 805,
	Plane_ABRIS_BT_2_up						= 806,
	Plane_ABRIS_BT_3_up						= 807,
	Plane_ABRIS_BT_4_up						= 808,
	Plane_ABRIS_BT_5_up						= 809,
	Plane_ABRIS_Axis_Increase_up			= 810,
	Plane_ABRIS_Axis_Decrease_up			= 811,
	Plane_ABRIS_Axis_Push_up				= 812,
	
	PanelsIllumination						= 493,
	CockpitNightIllumination				= 300,
	
	ADIAHRIllumination						= 813,
	ControlPanelIllumination				= 814,
	CockpitIllumination						= 815,
	
	
	iCommandHelicopter_Engines_Anti_Icing_Dust_Protection_System = 819,
		
	SelectWeapon_Internal					= 824,
	SelectWeapon_External					= 825,
	SelectWeapon_ALL						= 826,
	SelectWeapon_AA							= 827,
    SelectWeapon_hor_up                     = 381,
    SelectWeapon_vert_up                    = 382,							

	
	SignalFlares_switch_OnOff				= 828,
	SignalFlares_GREEN						= 829,
	SignalFlares_RED						= 830,
	SignalFlares_WHITE						= 831,
	SignalFlares_YELLOW						= 832,
	
	GaugesIlluminationButtonDown			= 833,
	GaugesIlluminationButtonUp				= 834,
	
	EngineLaunchMethodSelect				= 838,
        
    iCommandPlane_Helmet_Brightess_Up		= 840,
    iCommandPlane_Helmet_Brightess_Down		= 841,
    iCommandPlane_I251_Brightness_Up		= 842,
    iCommandPlane_I251_Brightness_Down		= 843,
    iCommandPlane_I251_Contrast_Up			= 844,
    iCommandPlane_I251_Contrast_Down		= 845,
    iCommandPlane_I251_Background_WhiteBlack = 846,
    iCommandPlane_LaserCode_Next			= 847,
    iCommandPlane_LaserCode_Previous		= 848,
	    
    iCommandPlaneJettisonWeapons			= 82,
    iCommandPlaneJettisonFuelTanks			= 178,
    
    iCommandPlaneAUTIncreaseLeft			= 161,
    iCommandPlaneAUTDecreaseLeft			= 162,
    iCommandPlaneAUTIncreaseRight			= 163,
    iCommandPlaneAUTDecreaseRight			= 164,
    -- Запуск двигателей
    iCommandEnginesStart					= 309,
    -- Выключение двигателей
    iCommandEnginesStop						= 310,
	iCommandPlane_JettisonMode_explosion	= 850,
    iCommandPlane_ShowControls				= 851,
    
	FuelBypassValve							= 728,
	FuelBypassValveCover					= 729,

	iCommandPlane_ReadjustFreeTurbineRPM_Up	= 853,
	iCommandPlane_ReadjustFreeTurbineRPM_Down = 854,

	-- Easy radar
	iCommandAutoLockOnNearestAircraft		= 272,
	iCommandAutoLockOnCenterAircraft		= 273,
	iCommandAutoLockOnNextAircraft			= 274,
	iCommandAutoLockOnPreviousAircraft		= 275,
	iCommandAutoLockOnNearestSurfaceTarget	= 276,
	iCommandAutoLockOnCenterSurfaceTarget	= 277,
	iCommandAutoLockOnNextSurfaceTarget		= 278,
	iCommandAutoLockOnPreviousSurfaceTarget	= 279,
    iCommandEasyRadarOnOff					= 271,
    iCommandEasyRadarScaleUp				= 836,
	iCommandEasyRadarScaleOut				= 837,
    iCommandAutoLockOnClear                 = 384,

	-- Padlock
	iCommandPlaneLockPadlock				= 329,
	iCommandThreatMissilePadlock			= 258,
	iCommandAllMissilePadlock				= 259,
	iCommandPlaneUnlockPadlock				= 330,
    
    iCommandHelicopter_CollectiveStopper_Up   = 856,
    iCommandHelicopter_CollectiveStopper_Down = 857,
	
	
	iCommandPlaneJettisonFuelTanksUp = 170,	
    iCommandPlaneJettisonWeaponsUp   = 171,
    
    iCommandPlaneCockpitIllumination       = 300,
    iCommandPlaneCockpitIlluminationPanels = 493,
    iCommandPlaneCockpitIlluminationGauges = 494,
    iCommandCockpitShowPilotOnOff          = 835,
	
	iCommandPlaneNav_PB0				   = 459,
	iCommandPlaneNav_PB1				   = 460,
	iCommandPlaneNav_PB2				   = 461,
	iCommandPlaneNav_PB3				   = 462,
	iCommandPlaneNav_PB4				   = 463,
	iCommandPlaneNav_PB5				   = 464,
	iCommandPlaneNav_PB6				   = 465,
	iCommandPlaneNav_PB7				   = 466,
	iCommandPlaneNav_PB8				   = 467,
	iCommandPlaneNav_PB9				   = 468,
	
	iCommandPlaneNav_PB0_off			   = 858, 
	iCommandPlaneNav_PB1_off			   = 859,
	iCommandPlaneNav_PB2_off			   = 860,
	iCommandPlaneNav_PB3_off			   = 861,
	iCommandPlaneNav_PB4_off			   = 862,
	iCommandPlaneNav_PB5_off			   = 863,
	iCommandPlaneNav_PB6_off			   = 864,
	iCommandPlaneNav_PB7_off		       = 865,
	iCommandPlaneNav_PB8_off			   = 866,
	iCommandPlaneNav_PB9_off			   = 867,
	
	iCommandPlaneNav_Steerpoints           = 469,
	iCommandPlaneNav_INU_realign           = 470,
	iCommandPlaneNav_POS_corrMode          = 471, 
	iCommandPlaneNav_INU_precise_align     = 472,
	iCommandPlaneNav_Airfields             = 473,
	iCommandPlaneNav_INU_normal_align      = 474,
	iCommandPlaneNav_Targets               = 475,
	iCommandPlaneNav_Enter                 = 476,
	iCommandPlaneNav_Cancel                = 477,
	iCommandPlaneNav_POS_init              = 478,
	iCommandPlaneNav_SelfCoord             = 479,
	iCommandPlaneNav_CourseTimeRange       = 480,
	iCommandPlaneNav_Wind                  = 481,
	iCommandPlaneNav_THeadingTimeRangeF    = 482,
	iCommandPlaneNav_BearingRangeT         = 483,
	
	iCommandPlaneNav_Steerpoints_off       = 868,
	iCommandPlaneNav_INU_realign_off       = 869,
	iCommandPlaneNav_POS_corrMode_off      = 870,
	iCommandPlaneNav_INU_precise_align_off = 871,
	iCommandPlaneNav_Airfields_off         = 872,
	iCommandPlaneNav_INU_normal_align_off  = 873,
	iCommandPlaneNav_Targets_off           = 874,
	iCommandPlaneNav_Enter_off             = 875,
	iCommandPlaneNav_Cancel_off            = 876,
	iCommandPlaneNav_POS_init_off          = 877,
	iCommandPlaneNav_SelfCoord_off         = 878,
	iCommandPlaneNav_CourseTimeRange_off   = 879,
	iCommandPlaneNav_Wind_off              = 880,
	iCommandPlaneNav_THeadingTimeRangeF_off= 881,
	iCommandPlaneNav_BearingRangeT_off     = 882,
	
	
	iCommand_CPT_MECH_WindscreenWiper_Speed = 883,
	iCommand_Accel_Reset		            = 884,
	iCommand_LWS_Reset                      = 885,	
	iCommandLaserRangeModeSwitchCover       = 886,
	iCommandLaserRangeModeSwitch            = 887,
	iCommandLaserRangeReset					= 888,
	iCommand_AGR_Power                      = 889,
	iCommand_WEAP_INTERF_MasterSimulate     = 890,
	iCommand_CPT_MECH_VMG_HYDRO_EKRAN_Cover = 891,
	iCommand_CPT_MECH_VMG_HYDRO_EKRAN       = 892,
	iCommand_LWS_BIT_On                     = 893,
	iCommand_IlluminationInterf_Control_Panel_Illumination = 894,
	iCommand_LWS_Power                      = 895,
	iCommand_UV26_PowerCover                = 896,
	iCommand_UV26_Power                     = 897,
	iCommand_UV26_BITCover                  = 898,
	iCommand_UV26_BIT                       = 899,
	iCommand_C061K_power                    = 900,
    iCommand_C061K_heat                     = 901,
    iCommand_VMS_ALMAZ_UP_Check             = 902,
    iCommand_EjectInterface_Circuit_Test    = 903,
	iCommand_ENG_INTERF_Right_Engine_RT_12_6= 904,
    iCommand_ENG_INTERF_Left_Engine_RT_12_6 = 905,
    iCommand_ENG_INTERF_EngVibrDetectorBIT  = 906,
    iCommand_ENG_INTERF_TempIndTestwRunningEng = 907,
	iCommand_ENG_INTERF_TempIndTestwStoppedEng = 908,
	iCommand_FuelSysInterf_FuelQuantityIndTestOn=909,
	iCommandPitotAoAHeat                    = 910,
	iCommandPitotRam                        = 911,
	iCommandHelicopter_Rotor_Anti_Icing_Dust_Protection_System = 912,
	iCommand_VMS_ALMAZ_UP_EmergencyOn       = 913,
	iCommand_VMS_ALMAZ_UP_SpeechInfoOff     = 914,
	iCommand_VMS_ALMAZ_UP_Repeat            = 915,
	iCommand_SHKVAL_scan_vel_up             = 916,
	iCommand_SHKVAL_scan_vel_down           = 917,
	iCommand_SHKVAL_windscreen_wiper        = 918,
	iCommand_PVI_BRIGHTNESS_LEVER_up        = 919,
	iCommand_PVI_BRIGHTNESS_LEVER_down      = 920,
	iCommand_FireExting_LeftEngineExting    = 921,
    iCommand_FireExting_APUExting           = 922,
    iCommand_FireExting_RightEngineExting   = 923,
    iCommand_FireExting_VentilatorExting    = 924,
    iCommand_FireExting_ExtinguishersToDown = 925,
    iCommand_FireExting_ExtinguishersCover  = 926,
    iCommand_FireExting_Signals             = 927,
    iCommand_FireExting_Reservoirs          = 928,
    iCommand_FireExting_ReservoirsCover     = 929,
    iCommand_IlluminationInterf_Cockpit_Illumination = 930,
	iCommand_FireExting_TestGroups			= 931,
	iCommand_AGR_Test                       = 932,
	iCommand_AGR_Oriet                      = 933,
	iCommand_AGR_axis_left                  = 934,
	iCommand_AGR_axis_right                 = 935,
	iCommand_IlluminationInterf_Cockpit_Night_Illumination_brightness_up=936,
	iCommand_IlluminationInterf_Cockpit_Night_Illumination_brightness_down=937,
	iCommand_IlluminationInterf_Panels_Illumination_brightness_up=938,
    iCommand_IlluminationInterf_Panels_Illumination_brightness_down=939,
    iCommand_IlluminationInterf_ADI_AHR_Illumination_brightness_up=940,
    iCommand_IlluminationInterf_ADI_AHR_Illumination_brightness_down=941,
    iCommand_IlluminationInterf_Control_Panel_Illumination_brightness_up=942,
    iCommand_IlluminationInterf_Control_Panel_Illumination_brightness_down=943,
    iCommand_NAVINTERF_HeadingCourse         = 944,
    
    iCommandPlaneDLK_None                    = 945,
	iCommandPlaneDLK_None_up                 = 946,
	
	iCommandWeaponsBallisticSelectorRight   = 947,
	iCommandWeaponsBallisticSelectorLeft    = 948,
	
	iCommand_ZMS_3_MagVarRotaryRight = 949,
	iCommand_ZMS_3_MagVarRotaryLeft = 950,
	
	iCommand_EjectInterface_Circuit_SelectRight=951,
	iCommand_EjectInterface_Circuit_SelectLeft=952,
	
	iCommand_CPT_MECH_PitotSystemHeatTest=953,
	
	iCommand_FireDetectorsTest1stGroup=954,
	iCommand_FireDetectorsTest2ndGroup=955,
	iCommand_FireDetectorsTest3rdGroup=956,

	
	
   	iCommandAltimeterPressureIncrease = 316,
	iCommandAltimeterPressureDecrease = 317,
	iCommandAltimeterPressureStop = 318,

	SPU9_PTT_on = 1589,
	SPU9_PTT_off = 1590,
	
	
	-- analog commands
    
   	LeftEngineBrake_ByAxis					= 2099,
	RightEngineBrake_ByAxis					= 2100,
	RotorEngineBrake_ByAxis					= 2101,  
	PlaneRadarHorizontal 					= 2025,
	PlaneRadarVertical 						= 2026,
	PlaneRadarHorizontalAbs					= 2027,
	PlaneRadarVerticalAbs 					= 2028,
	PlaneMFDZoom 							= 2029,
	PlaneMFDZoomAbs							= 2030,
	PlaneSelecterHorizontal					= 2031,
	PlaneSelecterVertical 					= 2032,
	PlaneSelecterHorizontalAbs				= 2033,
	PlaneSelecterVerticalAbs				= 2034,
	PlaneBase_Distance 						= 2040,
	PlaneBase_DistanceAbs 					= 2041,
	
}

start_command   = 3000
device_commands =
{
	Button_1  = start_command + 1;
	Button_2  = start_command + 2;
	Button_3  = start_command + 3;
	Button_4  = start_command + 4;
	Button_5  = start_command + 5;
	Button_6  = start_command + 6;
	Button_7  = start_command + 7;
	Button_8  = start_command + 8;
	Button_9  = start_command + 9;
	Button_10 = start_command + 10;
	Button_11 = start_command + 11;
	Button_12 = start_command + 12;
	Button_13 = start_command + 13;
	Button_14 = start_command + 14;
	Button_15 = start_command + 15;
	Button_16 = start_command + 16;
	Button_17 = start_command + 17;
	Button_18 = start_command + 18;
	Button_19 = start_command + 19;
	Button_20 = start_command + 20;
	Button_21 = start_command + 21;
	Button_22 = start_command + 22;
	Button_23 = start_command + 23;
	Button_24 = start_command + 24;
	Button_25 = start_command + 25;
	Button_26 = start_command + 26;
	Button_27 = start_command + 27;
	Button_28 = start_command + 28;
	Button_29 = start_command + 29;
	Button_30 = start_command + 30;
	Button_31 = start_command + 31;
	Button_32 = start_command + 32;
	Button_33 = start_command + 33;
	Button_34 = start_command + 34;
	Button_35 = start_command + 35;
	Button_36 = start_command + 36;
	Button_37 = start_command + 37;
	Button_38 = start_command + 38;
	Button_39 = start_command + 39;
	Button_40 = start_command + 40;
	Button_41 = start_command + 41;
	Button_42 = start_command + 42;
	Button_43 = start_command + 43;
	Button_44 = start_command + 44;
	Button_45 = start_command + 45;
	Button_46 = start_command + 46;
	Button_47 = start_command + 47;
	Button_48 = start_command + 48;
	Button_49 = start_command + 49;
	Button_50 = start_command + 50;
}
