-- Commands : not intended for end-user editing

start_command   = 3000
local count = 0
local function counter()
	count = count + 1
	return count
end


Keys =
{
	iCommand_PlaneAUTIncreaseRegime			= 66,
	iCommand_PlaneAUTDecreaseRegime			= 67,
	
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
	iCommand_CPT_MECH_AccelReset            = 884,
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

	iCommand_ThrottleIncrease = 1032,
	iCommand_ThrottleDecrease = 1033,
	iCommand_ThrottleStop = 1034,
	
	
   	iCommandAltimeterPressureIncrease = 316,
	iCommandAltimeterPressureDecrease = 317,
	iCommandAltimeterPressureStop = 318,
	
	iCommandPlane_APU_Start					=	1055,
    iCommandPlane_APU_Off					=	1056,
	
	
	-- analog commands
    
   	LeftEngineBrake_ByAxis					= 2098,
	RightEngineBrake_ByAxis					= 2099,
	RotorEngineBrake_ByAxis					= 2100,
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

count = start_command
device_commands = {}
for cmd_num = 1,120 do
	device_commands["Button_"..cmd_num] = counter()
end

cb_start_cmd = device_commands.Button_31
cb_end_cmd = cb_start_cmd + 63

count = start_command
elec_commands = 
{
	ACGroundPower							= counter();
	ACGroundPowerEXT						= counter();
	ACGroundPowerITER						= counter();
	ACGeneratorLeft							= counter();
	ACGeneratorLeftEXT						= counter();
	ACGeneratorLeftITER						= counter();
	ACGeneratorRight						= counter();
	ACGeneratorRightEXT						= counter();
	ACGeneratorRightITER					= counter();
	Transformer115vMainBackup				= counter();
	Transformer115vMainBackupEXT			= counter();
	Transformer115vMainBackupITER			= counter();
	Transformer36vMainBackup				= counter();
	Transformer36vMainBackupEXT				= counter();
	Transformer36vMainBackupITER			= counter();
	GroundCheck								= counter();
	GroundCheckEXT							= counter();
	GroundCheckITER							= counter();
	Rotary115vConverter						= counter();
	Rotary115vConverterEXT					= counter();
	Rotary115vConverterITER					= counter();
	Rotary36vConverter						= counter();
	Rotary36vConverterEXT					= counter();
	Rotary36vConverterITER					= counter();
	ACGangSwitcher							= counter();
	ACGangSwitcherEXT						= counter();
	ACGangSwitcherITER						= counter();

	Transformer36vDIMMainBackup				= counter();
	Transformer36vDIMMainBackupEXT			= counter();
	Transformer36vDIMMainBackupITER			= counter();

	DCGroundPower							= counter();
	DCGroundPowerEXT						= counter();
	DCGroundPowerITER						= counter();
	BatteryLeft								= counter();
	BatteryLeftEXT							= counter();
	BatteryLeftITER							= counter();
	BatteryRight							= counter();
	BatteryRightEXT							= counter();
	BatteryRightITER						= counter();
	RectifierLeft							= counter();
	RectifierLeftEXT						= counter();
	RectifierLeftITER						= counter();
	RectifierRight							= counter();
	RectifierRightEXT						= counter();
	RectifierRightITER						= counter();
	DCGenerator								= counter();
	DCGeneratorEXT							= counter();
	DCGeneratorITER							= counter();
	BatteryHeating							= counter();
	BatteryHeatingEXT						= counter();
	BatteryHeatingITER						= counter();
	NetworkToBatteries						= counter();
	NetworkToBatteriesEXT					= counter();
	NetworkToBatteriesITER					= counter();
	DCGangSwitcher							= counter();
	DCGangSwitcherEXT						= counter();
	DCGangSwitcherITER						= counter();
	
	GroundCheckCover						= counter();
	GroundCheckCoverEXT						= counter();
	GroundCheckCoverITER					= counter();
	Rotary115vConverterCover				= counter();
	Rotary115vConverterCoverEXT				= counter();
	Rotary115vConverterCoverITER			= counter();
	Rotary36vConverterCover					= counter();
	Rotary36vConverterCoverEXT				= counter();
	Rotary36vConverterCoverITER				= counter();
	NetworkToBatteriesCover					= counter();
	NetworkToBatteriesCoverEXT				= counter();
	NetworkToBatteriesCoverITER				= counter();
	
	CB_FRAME_LEFT							= counter();
	CB_FRAME_LEFT_EXT						= counter();
	CB_FRAME_RIGHT							= counter();
	CB_FRAME_RIGHT_EXT						= counter();
	
	CB_RIGHT_CONTROL_FORCE_MECHANISM		= counter();
	CB_RIGHT_CONTROL_CLUTCH					= counter();
	CB_RIGHT_ENGINE_TEMP_ADJUST_LEFT		= counter();
	CB_RIGHT_ENGINE_TEMP_ADJUST_RIGHT		= counter();
	CB_RIGHT_ROTOR_RPM_ADJUST				= counter();
	CB_RIGHT_ARMAMENT_SIGNAL				= counter();
	CB_RIGHT_ARMAMENT_CAMERA_SHUTTER		= counter();
	CB_RIGHT_ARMAMENT_CONTROL				= counter();
	CB_RIGHT_ARMAMENT_CANNON				= counter();
	
	CB_RIGHT_FIRE_2_AUTO					= counter();
	CB_RIGHT_FIRE_2_MANUAL					= counter();
	CB_RIGHT_EXT_STORES_TACTICAL_DROP		= counter();
	CB_RIGHT_EXT_STORES_LOCK_RELEASE		= counter();
	CB_RIGHT_GEAR_EXTENT_HANDLE_BACKUP		= counter();
	
	CB_RIGHT_LAUNCHER_DETACH				= counter();
	CB_RIGHT_BOMB_COMBAT_DROP				= counter();
	CB_RIGHT_CONNECTION_DISTRIBUTION_DEVICE	= counter();
	CB_RIGHT_PILOT_AIM						= counter();
	CB_RIGHT_DUAS_V_HEATING					= counter();
	
	CB_RIGHT_EMERGENCY_DOOR_DETACH_PILOT	= counter();
	CB_RIGHT_EMERGENCY_DOOR_DETACH_OP		= counter();
	CB_RIGHT_CONDITIONER_CONTROL			= counter();
	CB_RIGHT_FUEL_METER						= counter();
	CB_RIGHT_VALVE_TANK_2					= counter();
	CB_RIGHT_VALVE_FIRE_RIGHT				= counter();
	CB_RIGHT_PUMP_TANK_2					= counter();
	CB_RIGHT_PUMP_TANK_4					= counter();
	CB_RIGHT_PILOT_SEAT_MECHANISM			= counter();
	CB_RIGHT_ANTIICE_ALARM					= counter();
	CB_RIGHT_ANTIICE_CONTROL				= counter();

	CB_LEFT_HOMING_MISSILE_POWER 			= counter();
	CB_LEFT_BOMB_EMERGENCY_DETACH			= counter();
	CB_LEFT_BOMB_EXPLOSION					= counter();
	CB_LEFT_UNGUIDED_ROCKETS				= counter();
	CB_LEFT_RADIOCOMPASS_HF					= counter();
		
	CB_LEFT_PUMP_TANK_1						= counter();
	CB_LEFT_PUMP_TANK_5						= counter();
	CB_LEFT_VALVE_TANK_1					= counter();
	CB_LEFT_VALVE_FIRE_LEFT					= counter();
	CB_LEFT_VALVE_SEPARATION				= counter();
		
	CB_LEFT_GLASS_SPRINKLER					= counter();
	CB_LEFT_GLASS_WIPER_OP					= counter();
	CB_LEFT_GLASS_WIPER_PILOT				= counter();
	CB_LEFT_SPEECH_INFORMER					= counter();
	CB_LEFT_RECORDER_PARAMS					= counter();
		
	CB_LEFT_FIRE_1_AUTO						= counter();
	CB_LEFT_FIRE_1_MANUAL					= counter();
	CB_LEFT_FIRE_ALARM						= counter();
		
	CB_LEFT_EXT_CARGO_EMERGENCY_DROP		= counter();
		
	CB_LEFT_GEAR_EXTENT_HANDLE				= counter();
	CB_LEFT_GEAR_ALARM						= counter();
	CB_LEFT_PT125Ts							= counter();
	CB_LEFT_AIRSPEED_SENSOR					= counter();
	CB_LEFT_AUTOPILOT_ALARM					= counter();
		
	CB_LEFT_STARTUP_BLOCK					= counter();
	CB_LEFT_STARTUP_IGNITION				= counter();
	CB_LEFT_BEACON							= counter();
	CB_LEFT_HEADLIGHT_CONTROL				= counter();
	CB_LEFT_PILOTING_DEVICE					= counter();
}

count = start_command
fire_commands =
{
--buttons
	ExtingiushLE1               = counter();
	ExtingiushLE2               = counter();
	ExtingiushRE1               = counter();
	ExtingiushRE2               = counter();
	ExtingiushAPU1              = counter();
	ExtingiushAPU2              = counter();
	ExtingiushMRED1             = counter();
	ExtingiushMRED2             = counter();
	DisableAlarm                = counter();
	SensorControl               = counter();
	Pyro1                       = counter();
	Pyro2                       = counter();
	SensorGroup                 = counter();
	Power                       = counter();
	ExtingiushLE1EXT            = counter();
	ExtingiushLE2EXT            = counter();
	ExtingiushRE1EXT            = counter();
	ExtingiushRE2EXT            = counter();
	ExtingiushAPU1EXT           = counter();
	ExtingiushAPU2EXT           = counter();
	ExtingiushMRED1EXT          = counter();
	ExtingiushMRED2EXT          = counter();
	DisableAlarmEXT             = counter();
	SensorControlEXT            = counter();
	SensorControlITER           = counter();
	PyroEXT                     = counter();
	SensorGroupEXT              = counter();
	SensorGroupITER             = counter();
	PowerEXT                    = counter();
	PowerITER                   = counter();
}
count = start_command
fuel_commands =
{
	Tank1Pump 					= counter();
	Tank1PumpEXT 				= counter();
	Tank1PumpITER 				= counter();
	Tank2Pump 					= counter();
	Tank2PumpEXT 				= counter();
	Tank2PumpITER 				= counter();
	Tank4Pump					= counter();
	Tank4PumpEXT				= counter();
	Tank4PumpITER				= counter();
	Tank5Pump					= counter();
	Tank5PumpEXT				= counter();
	Tank5PumpITER				= counter();
	ExtTank						= counter();
	ExtTankEXT					= counter();
	ExtTankITER					= counter();
	ValveLeftEngine				= counter();
	ValveLeftEngineEXT			= counter();
	ValveLeftEngineITER			= counter();
	ValveLeftEngineCover		= counter();
	ValveLeftEngineCoverEXT		= counter();
	ValveLeftEngineCoverITER	= counter();
	ValveRightEngine			= counter();
	ValveRightEngineEXT			= counter();
	ValveRightEngineITER		= counter();
	ValveRightEngineCover		= counter();
	ValveRightEngineCoverEXT	= counter();
	ValveRightEngineCoverITER	= counter();
	ValveDelimiter				= counter();
	ValveDelimiterEXT			= counter();
	ValveDelimiterITER			= counter();
	ValveTank1					= counter();
	ValveTank1EXT				= counter();
	ValveTank1ITER				= counter();
	ValveTank2					= counter();
	ValveTank2EXT				= counter();
	ValveTank2ITER				= counter();
	FuelMeter					= counter();
	FuelMeterEXT				= counter();
	FuelMeterITER				= counter();
	FuelMeterButtonH			= counter();
	FuelMeterButtonHEXT			= counter();
	FuelMeterButtonP			= counter();
	FuelMeterButtonPEXT			= counter();
}


count = start_command
hydraulic_commands =
{
	MainHydro						= counter();
	MainHydroCover					= counter();
	GearHydro						= counter();
	GearHydroCover					= counter();
	DisableAuxiliaryHydro			= counter();
	DisableAuxiliaryHydroCover		= counter();
	Hydro_Damper_P					= counter();
	Hydro_Damper_PCover				= counter();
	Hydro_Damper_O					= counter();
	Hydro_Damper_OCover				= counter();
	Hydro_Damper_Switch_P			= counter();
	Hydro_Damper_Switch_PCover		= counter();
	OperatorButton					= counter();
	SightStationDoorsInternal	    = counter();
	SightStationDoorsExternal	    = counter();
	MainHydro_EXT					= counter();
	MainHydro_ITER					= counter();
	MainHydroCover_EXT				= counter();
	MainHydroCover_ITER				= counter();
	GearHydro_EXT					= counter();
	GearHydro_ITER					= counter();
	GearHydroCover_EXT				= counter();
	GearHydroCover_ITER				= counter();
	DisableAuxiliaryHydro_EXT		= counter();
	DisableAuxiliaryHydroCover_EXT	= counter();
	DisableAuxiliaryHydroCover_ITER	= counter();
	Hydro_Damper_EXT				= counter();
	Hydro_Damper_ITER				= counter();
	Hydro_DamperCover_EXT			= counter();
	Hydro_DamperCover_ITER			= counter();
	Hydro_Damper_Switch_P_EXT		= counter();
	Hydro_Damper_Switch_P_ITER		= counter();
	Hydro_Damper_Switch_PCover_EXT	= counter();
	Hydro_Damper_Switch_PCover_ITER	= counter();
	OperatorButton_EXT				= counter();
}

count = start_command
cockpit_mechanics_commands =
{
	Command_CPT_MECH_Gear_Pilot								= counter();
	Command_CPT_MECH_Gear_Pilot_Lock						= counter();
	Command_CPT_MECH_Gear_Pilot_LightsOff					= counter();
	Command_CPT_MECH_Gear_Pilot_LightsOff_Cover				= counter();
	Command_CPT_MECH_Gear_Operator							= counter();
	Command_CPT_MECH_Gear_Operator_Cover					= counter();
	Command_CPT_MECH_EmeregencyGear							= counter();
	Command_CPT_MECH_VMG_HYDRO_EKRAN						= counter();
	Command_CPT_MECH_VMG_HYDRO_EKRAN_Cover					= counter();
	Command_CPT_MECH_WindscreenWiper_Speed					= counter();
	Command_CPT_MECH_WindscreenWiper_Retract				= counter();
	Command_CPT_MECH_PitotTotalAndAoASideslip				= counter();
	Command_CPT_MECH_PitotStaticAndClock					= counter();
	Command_CPT_MECH_PitotSystemHeatTest					= counter();
	Command_CPT_MECH_WindSprayerPilot						= counter();
	Command_CPT_MECH_WindSprayerOperator					= counter();
	Command_CPT_MECH_PilotDoor_Lock							= counter();
	Command_CPT_MECH_PilotDoor_Safety_Lock_Button			= counter();
	Command_CPT_MECH_Canopy									= counter();
	Command_CPT_MECH_PILOT_MODE_WIPER						= counter();
	Command_CPT_MECH_OPERATOR_MODE_WIPER					= counter();
	Command_CPT_MECH_LeftMainDoor							= counter();
	Command_CPT_MECH_RightMainDoor							= counter();
	Command_CPT_MECH_FAN_PILOT								= counter();
	Command_CPT_MECH_FAN_OPERATOR							= counter();
	Command_CPT_MECH_WheelBrake								= counter();
	Command_CPT_MECH_ParkingBrake							= counter();
	Command_CPT_MECH_CollectiveStopper						= counter();
	Command_CPT_MECH_TouchFanPLT							= counter();
	Command_CPT_MECH_TouchFanCPG							= counter();
	Command_CPT_MECH_Elements_Hide							= counter();
	Command_CPT_MECH_WindSprayerEXT							= counter();
	Command_CPT_MECH_Door_EXT								= counter();
	Command_CPT_MECH_PILOT_MODE_WIPER_EXT					= counter();
	Command_CPT_MECH_OPERATOR_MODE_WIPER_EXT				= counter();
	Command_CPT_MECH_FAN_PILOT_EXT							= counter();
	Command_CPT_MECH_FAN_OPERATOR_EXT						= counter();
	Command_CPT_MECH_Elements_Hide_EXT						= counter();
	Command_CPT_MECH_GENERAL_DOORS_CLOSE					= counter();
	Trimmer_myself											= counter();
	Trimmer_myself_cover									= counter();
	Command_CPT_MECH_ParkingBrake_EXT						= counter();
	Command_CPT_MECH_PitotTotalLeft							= counter();
	Command_CPT_MECH_PitotTotalLeft_ITER					= counter();
	Command_CPT_MECH_PitotTotalRight						= counter();
	Command_CPT_MECH_PitotTotalRight_ITER					= counter();
	Command_CPT_MECH_ClockHeatPLT							= counter();
	Command_CPT_MECH_ClockHeatCPG							= counter();
	Command_CPT_MECH_ClockHeat_EXT							= counter();
	Command_CPT_MECH_ClockHeat_ITER							= counter();
}

count = start_command
int_lights_commands =
{
	--cabin lights
	OperatorCabinLightingWhiteRed					= counter();
	PilotCabinLightingWhiteRed						= counter();
    CargoWhiteLightingOn							= counter();
	CargoWhiteLightingOn_COVER						= counter();
    CargoLightingWhiteBlue							= counter();
    RadioBayLightning								= counter();
    TailboomLightning								= counter();
    --warning lights
    TestLightsPilot									= counter();
    TestLightsOperator								= counter();
    DayNight										= counter();
    BlinkerSystem									= counter();
    --red lights
    RedLightsPilotInstrumentPanelRightPanel_1		= counter();
    RedLightsPilotInstrumentPanelRightPanel_2		= counter();
    SpecialEquipmentPanelRedLights					= counter();
    RedLightsPilotLeftPanel_1						= counter();
    RedLightsPilotLeftPanel_2						= counter();
    RedLightsOperatorPanel_1						= counter();
    RedLightsOperatorPanel_2						= counter();
    OperatorPanelRedLights							= counter();
    RedLightsPilotBuiltInRedLights					= counter();
	TestLights_EXT									= counter();
	DayNight_EXT									= counter();
    BlinkerSystem_EXT								= counter();
    DayNight_ITER									= counter();
    BlinkerSystem_ITER								= counter();
	CabinLightingWhiteRed_EXT						= counter();
    CargoWhiteLightingOn_EXT						= counter();
	CargoWhiteLightingOn_COVER_EXT					= counter();
    CargoLightingWhiteBlue_EXT						= counter();
    CabinLightingWhiteRed_ITER						= counter();
    CargoWhiteLightingOn_ITER						= counter();
	CargoWhiteLightingOn_COVER_ITER					= counter();
    CargoLightingWhiteBlue_ITER						= counter();
    RedLightsPilotInstrumentPanelRightPanel_1_ITER	= counter();
    RedLightsPilotInstrumentPanelRightPanel_2_ITER	= counter();
    SpecialEquipmentPanelRedLights_ITER				= counter();
    RedLightsPilotLeftPanel_1_ITER					= counter();
    RedLightsPilotLeftPanel_2_ITER					= counter();
    RedLightsOperatorPanel_1_ITER					= counter();
    RedLightsOperatorPanel_2_ITER					= counter();
    OperatorPanelRedLights_ITER						= counter();
    RedLightsPilotBuiltInRedLights_ITER				= counter();
    RedLightsPilotInstrumentPanelRightPanel_1_EXT	= counter();
    RedLightsPilotInstrumentPanelRightPanel_2_EXT	= counter();
    SpecialEquipmentPanelRedLights_EXT				= counter();
    RedLightsPilotLeftPanel_1_EXT					= counter();
    RedLightsPilotLeftPanel_2_EXT					= counter();
    RedLightsOperatorPanel_1_EXT					= counter();
    RedLightsOperatorPanel_2_EXT					= counter();
    OperatorPanelRedLights_EXT						= counter();
    RedLightsPilotBuiltInRedLights_EXT				= counter();
}

count = start_command
autopilot_commands =
{
	ButtonKon			= counter();
	ButtonKonEXT		= counter();
	ButtonKoff			= counter();
	ButtonKoffEXT		= counter();
	ButtonHon			= counter();
	ButtonHonEXT		= counter();
	ButtonHoff			= counter();
	ButtonHoffEXT		= counter();
	ButtonTon			= counter();
	ButtonTonEXT		= counter();
	ButtonToff			= counter();
	ButtonToffEXT		= counter();
	ButtonBon			= counter();
	ButtonBonEXT		= counter();
	ButtonBoff			= counter();
	ButtonBoffEXT		= counter();
	ControlUp			= counter();
	ControlUpEXT		= counter();
	ControlDown			= counter();
	ControlDownEXT		= counter();
	DeltaK				= counter();
	DeltaKAXIS			= counter();
	DeltaH				= counter();
	DeltaHAXIS			= counter();
	DeltaT				= counter();
	DeltaTAXIS			= counter();
	Trimmer				= counter();
	TrimmerMULT			= counter();
	RudderSignal		= counter();
	RouteAngle			= counter();
	RouteAngleAXIS		= counter();
	HeightOn			= counter();
	HeightOnEXT			= counter();
	HeightOff			= counter();
	HeightOffEXT		= counter();
	HoverOn				= counter();
	HoverOnEXT			= counter();
	RouteOn				= counter();
	RouteOnEXT			= counter();
	RouteHoverOff		= counter();
	RouteHoverOffEXT	= counter();
	SpeedOn				= counter();
	SpeedOnEXT			= counter();
	SpeedOff			= counter();
	SpeedOffEXT			= counter();
	AutopilotOff		= counter();
	AutopilotOffOP		= counter();
	AutopilotOffEXT		= counter();
	Friction			= counter();
	FrictionEXT			= counter();
	Lighting 			= counter() + 19;
	LightingEXT			= counter() + 19;
}

count = start_command
spuu_commands =
{
	button_off		= counter();
	button_off_EXT	= counter();
	control			= counter();
	control_AXIS	= counter();
	control_ITER	= counter();
	switchUp		= counter();
	switchDown		= counter();
	switchUp_EXT	= counter();
	switchDown_EXT	= counter();
	On_Off			= counter();
	On_Off_EXT		= counter();
	On_Off_ITER		= counter();
}

count = start_command
ecs_commands =
{
	CabinUnseal                			= counter();
	BlowdownConditioning       			= counter();
	Filter                     			= counter();
	Heating                    			= counter();
	AutomaticHotCold           			= counter();
	Temperature                			= counter();
	HeatingAirFlowSight					= counter(),
	Sealing_valve						= counter(),
	CabinUnseal_ITER           			= counter();
	CabinUnseal_EXT            			= counter();
	BlowdownConditioning_ITER  			= counter();
	BlowdownConditioning_EXT   			= counter();
	Filter_ITER                			= counter();
	Filter_EXT                 			= counter();
	Heating_ITER               			= counter();
	Heating_EXT                			= counter();
	AutomaticHotCold_ITER      			= counter();
	AutomaticHotCold_EXT       			= counter();
	Temperature_ITER           			= counter();
	Temperature_EXT           			= counter();
	HeatingAirFlowSight_Ext 			= counter();
	Sealing_valve_EXT					= counter();
}

count = start_command
pkp72m_commands =
{
PitchTrimKnob                			= counter();
TestControl                  			= counter();
PitchTrimKnob_ITER           			= counter();
}

count = start_command
mgv1su_commands = 
{
	CAGE		= counter();
	CAGE_EXT	= counter();
	CAGE_OP		= counter();
	POWER		= counter();
	POWER_EXT	= counter();
	POWER_ITER	= counter();
	
}

count = start_command
pkp72m_interface_commands =
{
GyroverticalSwitch                 		= counter();
PKP72MoperatorSwitch               		= counter();
PitchTrimKnob_ITER                 		= counter();
PitchTrimKnob_AXIS                 		= counter();
TestControl_EXT                    		= counter();
GyroverticalSwitch_EXT             		= counter();
GyroverticalSwitch_ITER            		= counter();
PKP72MoperatorSwitch_EXT           		= counter();
PKP72MoperatorSwitch_ITER          		= counter();
}

count = start_command
ukt2_commands =
{
PitchTrimKnob                			= counter();
PitchTrimKnob_ITER                  	= counter();
PitchTrimKnob_AXIS           			= counter();
}

count = start_command
headwrapper_commands = 
{
	PilotSeat                			= counter();
	OpSeat                				= counter();
	LGunnerSeat							= counter();
	RGunnerSeat							= counter();
	TrackIR_OnOff						= counter();
}

count = start_command
helperai_commands = 
{
	ShowMenu							= counter();
	Right								= counter();
	Left								= counter();
	Up									= counter();
	Down								= counter();
	ToggleSubtitles_EXT					= counter();
	Deprecated2							= counter();
	MainWeapSwitch						= counter();
	SelectTarget						= counter();
	UnselectTarget						= counter();
	
	EngageOperatorStickLever			= counter();
	DisengageOperatorStickButton		= counter();
	DisengageOperatorStickButtonCover	= counter();
	
	HeliControlEXT						= counter();
	
	Select_or_fireEXT					= counter();
	
	ShootIn_EXT							= counter();
	LineUp_EXT							= counter();
	UTurn_EXT							= counter();
	CycleMissile_EXT					= counter();
	
}

count = start_command
baroaltimeter_commands =
{
CMD_ADJUST_PRESSURE        				= counter();
CMD_ADJUST_PRESSURE_EXT    				= counter();
}

count = start_command
rmi2_commands =
{
MODE_LEFTSW                 			= counter();
MODE_RIGHTSW                			= counter();
MODE_LEFTSW_ITER                 		= counter();
MODE_LEFTSW_EXT                  		= counter();
MODE_RIGHTSW_ITER                		= counter();
MODE_RIGHTSW_EXT                 		= counter();
}

count = start_command
ext_lights_commands =
{
PilotTaxiLight                         = counter();
OperatorTaxiLight                      = counter();
NavLtSwitch                            = counter();
NavCodeButton                          = counter();
FormationLights                        = counter();
TipLights                              = counter();
StrobeLight                            = counter();
HeadlightControl 				   	   = counter();
HeadLightPilotControl                  = counter();
HeadLightOperatorControl			   = counter();
Headlight_Operator_Switch			   = counter();
Headlight_Operator_Switch_PCover	   = counter();
TaxiLight_EXT                          = counter();
TaxiLight_ITER                         = counter();
NavLtSwitch_EXT                        = counter();
NavCodeButton_EXT                      = counter();
NavLtSwitch_ITER                       = counter();
FormationLights_EXT                    = counter();
FormationLights_ITER                   = counter();
TipLights_EXT                          = counter();
TipLights_ITER                         = counter();
StrobeLight_EXT                        = counter();
StrobeLight_ITER                       = counter();
Headlight_Operator_Switch_PCover_EXT   = counter();
Headlight_Operator_Switch_PCover_ITER  = counter();
HeadLightPilotControl_EXT 			   = counter();
HeadLightOperatorControl_EXT           = counter();
}

count = start_command
map_display_commands =
{
Scale                                 = counter();
ScaleEXT                              = counter();
ScaleITER                             = counter();
VertAdj                               = counter();
VertAdjEXT                            = counter();
HorAdj                                = counter();
HorAdjEXT                             = counter();
Power                                 = counter();
PowerEXT                              = counter();
PowerITER                             = counter();
Lights								  = counter();
Lights_EXT							  = counter();
}

count = start_command
engine_commands = --OMG this sucks a lot
{
	--hidden
	HIDDEN_EEC_LEFT						= counter();
	HIDDEN_EEC_RIGHT					= counter();
	--Axes
	CONTROL_CORRECTION					= counter();
	COLLECTIVE							= counter();
	CONTROL_LEFT_THROTTLE				= counter();
	CONTROL_LEFT_THROTTLE_CLICK			= counter();
	CONTROL_RIGHT_THROTTLE				= counter();
	CONTROL_RIGHT_THROTTLE_CLICK		= counter();
	--Levers
	LEVER_Left_Engine_Lock				= counter();
	LEVER_Right_Engine_Lock				= counter();
	LEVER_Rotor_Lock					= counter();
		--Startup APU
	STARTUP_APU_StartUp					= counter();
	STARTUP_APU_Stop					= counter();
	STARTUP_APU_Launch_Method			= counter();
	--Startup Engines
	STARTUP_Engine_StartUp				= counter();
	STARTUP_Engine_Select				= counter();
	STARTUP_Engine_InterruptStartUp		= counter();
	STARTUP_Engine_Launch_Method		= counter();
	--RPM Readjust
	READJUST_UP							= counter();
	READJUST_DOWN						= counter();
	--AntiDust
	ANTIDUST_On							= counter();
	ANTIDUST_On_COVER					= counter();
		--IA-6 control
	IA6_COLD							= counter();
	IA6_HOT								= counter();
	
	CONTROL_CORRECTION_ITER				= counter();
	CONTROL_LEFT_THROTTLE_ITER			= counter();
	CONTROL_RIGHT_THROTTLE_ITER			= counter();
	END_THROTTLES_ITER					= counter();
	LEVER_Left_Engine_Lock_EXT			= counter();
	LEVER_Left_Engine_Lock_ITER			= counter();
	LEVER_Right_Engine_Lock_EXT			= counter();
	LEVER_Right_Engine_Lock_ITER		= counter();
	LEVER_Rotor_Lock_EXT				= counter();
	LEVER_Rotor_Lock_ITER				= counter();
	STARTUP_APU_StartUp_EXT				= counter();
	STARTUP_APU_Stop_EXT				= counter();
	STARTUP_APU_Launch_Method_EXT		= counter();
	STARTUP_APU_Launch_Method_ITER		= counter();
	STARTUP_Engine_StartUp_EXT			= counter();
	STARTUP_Engine_Select_EXT			= counter();
	STARTUP_Engine_Select_ITER			= counter();
	STARTUP_Engine_InterruptStartUp_EXT	= counter();
	STARTUP_Engine_Launch_Method_EXT	= counter();
	STARTUP_Engine_Launch_Method_ITER	= counter();
	READJUST_UP_EXT						= counter();
	READJUST_DOWN_EXT					= counter();
	ANTIDUST_On_EXT						= counter();
	ANTIDUST_On_ITER					= counter();
	ANTIDUST_On_COVER_EXT				= counter();
	ANTIDUST_On_COVER_ITER				= counter();
	IA6_COLD_EXT						= counter();
	IA6_HOT_EXT							= counter();
	--the rest is in the doubt zone
	INTERF_TC_RPM						= counter();
	INTERF_Engine_Temperature_Control	= counter();

	Left_Engine_RT_12_6					= counter();
	Right_Engine_RT_12_6				= counter();
	EngVibrDetectorBIT					= counter();

	TempIndTestwRunningEng				= counter();
	TempIndTestwStoppedEng				= counter();

	--EEC
	CheckPT1							= counter();
	CheckPT2							= counter();
	ER_LEFT								= counter();
	ER_RIGHT							= counter();
	CONTROL								= counter();
	FaultEnginesLeft					= counter();
	FaultEnginesRight					= counter();
	-----------------------------------------------------
	Surge_LeftEngine					= counter();
	Surge_RightEngine					= counter();
	Shave_MainReductor					= counter();
	OilPress_LeftEngine					= counter();
	OilPress_RightEngine				= counter();
	Shave_LeftEngine					= counter();
	Shave_RightEngine					= counter();
	GasTemperature_LeftEngine			= counter();
	GasTemperature_RightEngine			= counter();
	Fault_LeftEngine					= counter();
	Fault_RightEngine					= counter();
	Fault_BothEngines					= counter();
	SAR_1_2_NV95						= counter();
	SAR_1_NV103							= counter();
	SAR_1_NV95							= counter();
	SAR_2_NV103							= counter();
	SAR_2_NV95							= counter();
	SAR_Hovering_flight_glide			= counter();
	Vibration_LeftEngine				= counter();
	Vibration_RightEngine				= counter();
	ERD_LeftEngine						= counter();
	ERD_RightEngine						= counter();
	FiltersLoaded						= counter();

	OP_CONTROL_CORRECTION				= counter();
	OP_COLLECTIVE						= counter();
}
count = start_command
weapon_commands = 
{
	--no operator yet
	Pilot_RUV_FIRE							= counter();
	Pilot_RUV_FIRE_Cvr						= counter();
	Pilot_NPU_CHAIN							= counter();
	Pilot_RELOAD_LEFT						= counter();
	Pilot_RELOAD_RIGHT						= counter();
	Pilot_FKP_CAMERA						= counter();

	Pilot_SWITCHER_OFF_GM_URS_NPU			= counter();
	Pilot_BOTH_LEFT_RIGHT					= counter();
	
	Pilot_SWITCHER_FIRE_CONTROL				= counter();
	Pilot_TEMP_NPU30						= counter();
	Pilot_RELOAD_NPU30						= counter();
	Pilot_STOP_KMG							= counter();

	Pilot_EMERG_EXPLODE						= counter();
	Pilot_EMERG_EXPLODE_COVER				= counter();
	Pilot_EMERG_RELEASE						= counter();
	Pilot_EMERG_RELEASE_COVER				= counter();
	Pilot_EMERG_RELEASE_PU					= counter();
	Pilot_EMERG_RELEASE_PU_COVER			= counter();
	Pilot_PUS_ARMING						= counter();
	
	Operator_SWITCHER_SAFE_WEAP				= counter(),
	Operator_RUV_FIRE_OPERATOR				= counter(),
	Operator_RUV_FIRE_Cvr					= counter();
	Operator_SWITCHER_CONTROL_On_ME_OPERATOR= counter(),
	Operator_EMERG_EXPLODE_OPERATOR			= counter(),
	Operator_EMERG_RELEASE_OPERATOR			= counter(),
	Operator_CHAIN_LENGTH_SHORT_MED_LONG	= counter(),
	Operator_SWITCHER_WEAP_TYPE_AB			= counter(),
	Operator_URS_POWER						= counter(),
	Operator_CHECK1_WORK_CHECK2				= counter(),
	Operator_POWER_SHO_SWITCHER				= counter(),
	Operator_CHECK_RELEASE_PU				= counter(),
	Operator_EMERGE_RELEASE_PU_OPERATOR		= counter(),
	Operator_SWITCHER_BOMB_BLOCK_BOMB		= counter(),
	Operator_RESET_RADIATION				= counter(),
	Operator_CHECK_LAMPS_9C475				= counter(),
	Operator_LAUNCH_URS						= counter(),
	Operator_OPERATOR_RATE_MORE				= counter(),
	Operator_SWITCHER_LAUNCH_STATION		= counter(),
	Operator_RELOAD_NPU30					= counter();
	
	Operator_CONTROL_On_ME_OPERATOR_Cvr 	= counter(),
	Operator_EMERG_EXPLODE_OPERATOR_Cvr		= counter(),
	Operator_EMERG_RELEASE_OPERATOR_Cvr		= counter(),
	Operator_SWITCHER_BOMB_BLOCK_BOMB_Cvr	= counter(),
	Operator_EMERG_RELEASE_PU_OPERATOR_Cvr	= counter(),
	
	Operator_START_KMG						= counter(),
	Operator_STOP_KMG						= counter(),
	
	Pilot_RELOAD_NPU30_Ext					= counter(),
	Pilot_STOP_KMG_Ext						= counter(),
	Pilot_PUS_ARMING_Ext					= counter(),
	
	SWITCHER_SAFE_WEAP_Ext 					= counter(),
	SWITCHER_CONTROL_On_ME_OPERATOR_Up_Ext	= counter(),
	SWITCHER_CONTROL_On_ME_OPERATOR_Down_Ext = counter(),
	EMERG_EXPLODE_OPERATOR_Ext 				= counter(),
	EMERG_RELEASE_OPERATOR_Ext 				= counter(),
	CHAIN_LENGTH_SHORT_MED_LONG_Ext 		= counter(),
	SWITCHER_WEAP_TYPE_AB_Ext 				= counter(),
	URS_POWER_Ext 							= counter(),
	CHECK1_WORK_CHECK2_Ext 					= counter(),
	POWER_SHO_SWITCHER_Ext 					= counter(),
	CHECK_RELEASE_PU_Ext 					= counter(),
	EMERGE_RELEASE_PU_OPERATOR_Ext 			= counter(),
	SWITCHER_BOMB_BLOCK_BOMB_Ext 			= counter(),
	RESET_RADIATION_Ext 					= counter(),
	CHECK_LAMPS_9C475_Ext 					= counter(),
	OPERATOR_RATE_MORE_Ext 					= counter(),
	SWITCHER_LAUNCH_STATION_Ext 			= counter(),
	RELOAD_NPU30_Ext 						= counter(),

	CONTROL_On_ME_OPERATOR_Cvr_Up_Ext		= counter(),
	CONTROL_On_ME_OPERATOR_Cvr_Down_Ext		= counter(),
	EMERG_EXPLODE_OPERATOR_Cvr_Ext 			= counter(),
	EMERG_RELEASE_OPERATOR_Cvr_Ext 			= counter(),
	SWITCHER_BOMB_BLOCK_BOMB_Cvr_Ext 		= counter(),
	EMERG_RELEASE_PU_OPERATOR_Cvr_Ext 		= counter(),
	
	Pilot_NPU_CHAIN_Ext						= counter(),
	Pilot_RELOAD_LEFT_Ext					= counter(),
	Pilot_RELOAD_RIGHT_Ext					= counter(),
	Pilot_FKP_CAMERA_Ext					= counter(),

	Pilot_SWITCHER_OFF_GM_URS_NPU_Ext		= counter(),
	Pilot_SWITCHER_OFF_GM_URS_NPU_Iter		= counter(),
	Pilot_BOTH_LEFT_RIGHT_Ext				= counter(),

	Pilot_SWITCHER_FIRE_CONTROL_UP_Ext		= counter(),
	Pilot_SWITCHER_FIRE_CONTROL_DOWN_Ext	= counter(),
	Pilot_TEMP_NPU30_Ext					= counter(),

	Pilot_EMERG_EXPLODE_Ext					= counter(),
	Pilot_EMERG_EXPLODE_COVER_Ext			= counter(),
	Pilot_EMERG_RELEASE_Ext					= counter(),
	Pilot_EMERG_RELEASE_COVER_Ext			= counter(),
	Pilot_EMERG_RELEASE_PU_Ext				= counter(),
	Pilot_EMERG_RELEASE_PU_COVER_Ext		= counter(),
	
	Operator_START_KMG_Ext					= counter(),
	Operator_STOP_KMG_Ext					= counter(),
	
	Pilot_Counter1							= counter(),
	Pilot_Counter2							= counter(),
	Pilot_Counter3							= counter(),
	Pilot_Counter4							= counter(),
	Pilot_Counter5							= counter(),

	Pilot_Counter1_Inc						= counter(),
	Pilot_Counter2_Inc						= counter(),
	Pilot_Counter3_Inc						= counter(),
	Pilot_Counter4_Inc						= counter(),
	Pilot_Counter5_Inc						= counter(),
	Pilot_RUV_FIRE_Cvr_Ext					= counter(),
	
	Pilot_SWITCHER_FIRE_CONTROL_Ext			= counter(),
	

	Gunner_SIGHT_UP_DOWN_AXIS				= counter(),
	Gunner_SIGHT_LEFT_RIGHT_AXIS			= counter(),
	Gunner_WS_CMD_HAngle					= counter(),
	Gunner_WS_CMD_VAngle					= counter(),
	
	CMD_GAI_CTL_SHOW						= counter(),
	CMD_Show_Gunners_Panel					= counter(),
	CMD_GAI_CTL_GUNNER						= counter(),
	SWITCHER_WEAP_TYPE_AB_Iter				= counter(),
}

count = start_command
i9K113_commands =
{
	Command_POWER_PN						= counter(),
	Command_NABL							= counter(),
	Command_DIAFR_OTKR						= counter(),
	Command_OTKL_BLOCK_ARU					= counter(),
	Command_SSP_VKL							= counter(),
	Command_GENER_EMIT						= counter(),
	Command_KONTR_T1_B9_KONTR_T2			= counter(),
	Command_WORK_CONTROL					= counter(),
	Command_VHOD_BVK_KV						= counter(),
	Command_START_PM						= counter(),
	Command_CHECK_LAMPS						= counter(),

	Command_SWITCHER_IN_OUT					= counter(),
	Command_COD1_COD2						= counter(),
	Command_0_04							= counter(),
	Command_CHECKING						= counter(),
	Command_HIGH_K							= counter(),
	Command_TABLO							= counter(),

	Command_STVORKI							= counter(),

	Command_VertPos							= counter(),
	Command_HorizPos						= counter(),

	Command_ZOOM							= counter(),
	Command_OS								= counter(),
	Command_SES								= counter(),

	Command_BRIGHTNESS						= counter(),

	Command_SIGHT_UP_DOWN_AXIS				= counter(),
	Command_SIGHT_LEFT_RIGHT_AXIS			= counter(),
	Command_SIGHT_ZOOM						= counter(),
	Command_Aiming							= counter(),
	Command_RadiationReset					= counter(),

	Command_POWER_PN_Ext					= counter(),
	Command_NABL_Ext						= counter(),
	Command_DIAFR_OTKR_Ext					= counter(),
	Command_OTKL_BLOCK_ARU_Ext				= counter(),
	Command_SSP_VKL_Ext						= counter(),
	Command_GENER_EMIT_Ext					= counter(),
	Command_KONTR_T1_B9_KONTR_T2_Ext		= counter(),
	Command_WORK_CONTROL_Ext				= counter(),
	Command_VHOD_BVK_KV_Ext					= counter(),
	Command_START_PM_Ext					= counter(),
	Command_CHECK_LAMPS_Ext					= counter(),
	Command_SWITCHER_IN_OUT_Ext				= counter(),
	Command_COD1_COD2_Ext					= counter(),
	Command_0_04_Ext						= counter(),
	Command_CHECKING_Ext					= counter(),
	Command_HIGH_K_Ext						= counter(),
	Command_TABLO_Ext						= counter(),
	Command_STVORKI_Ext						= counter(),
	Command_VertPos_Ext						= counter(),
	Command_HorizPos_Ext					= counter(),
	Command_ZOOM_Ext						= counter(),
	Command_OS_Ext							= counter(),
	Command_SES_Ext							= counter(),
	Command_BRIGHTNESS_Ext					= counter(),
	Command_Hint_Ext						= counter(),
	Command_StickPark_Ext					= counter(),
	Command_RadiationReset_Ext				= counter(),

	Command_SIGHT_UP_DOWN_JOY_AXIS			= counter(),
	Command_SIGHT_LEFT_RIGHT_JOY_AXIS		= counter(),

	Command_SteeringHelper_Ext				= counter(),

	Command_Intern_SIGHT_UP_DOWN_AI_AXIS	= counter(),
	Command_Intern_SIGHT_LEFT_RIGHT_AI_AXIS	= counter(),

	Command_9k113_Backlight					= counter(),
	Command_9k113_Backlight_Ext				= counter(),

	Command_Heat_O							= counter(),
	Command_Heat_O_Ext						= counter(),

	Command_NABL_Iter						= counter(),

	Command_TRACKIR_SIGHT_UP_DOWN_AXIS		= counter(),
	Command_TRACKIR_SIGHT_LEFT_RIGHT_AXIS	= counter(),
	Command_TRACKIR_SIGHT_ROLL_AXIS			= counter(),
	Command_TRACKIR_SIGHT_X_AXIS			= counter(),
	Command_TRACKIR_SIGHT_Y_AXIS			= counter(),
	Command_TRACKIR_SIGHT_Z_AXIS			= counter(),	
};

count = start_command
SPO_commands = 
{
		Command_SPO_POWER 	= counter();
		Command_SPO_SIGNAL	= counter();
		Command_DAY_NIGHT	= counter();
		Command_SPO_CHECK	= counter();

		Command_SPO_POWER_Ext	= counter();
		Command_SPO_SIGNAL_Ext	= counter();
		Command_DAY_NIGHT_Ext	= counter();
};

count = start_command
asp_commands = 
{
	Manual_Auto					= counter();
	Sync_Async					= counter();
	Range_Auto_Manual			= counter();
	Range_Value					= counter();
	Elevation_Delta				= counter();
	Azimuth_Delta				= counter();
	Sight_Null					= counter();
	Base_Range					= counter();
	Control						= counter();
	Brightness_NS				= counter();
	Brightness_PM				= counter();
    Backup_Light_NS				= counter();
	Backup_Light_PM				= counter();
	Power						= counter();
	USR							= counter();
	USR_check					= counter();
	
	
	Manual_Auto_EXT				= counter();
	Manual_Auto_ITER			= counter();
	Sync_Async_EXT				= counter();
	Sync_Async_ITER				= counter();
	Range_Auto_Manual_EXT		= counter();
	Range_Auto_Manual_ITER		= counter();
	Range_Value_EXT				= counter();
	Range_Value_AXIS			= counter();
	Elevation_Delta_EXT			= counter();
	Elevation_Delta_AXIS		= counter();
	Azimuth_Delta_EXT			= counter();
	Azimuth_Delta_AXIS			= counter();
	Sight_Null_EXT				= counter();
	Base_Range_EXT				= counter();
	Base_Range_AXIS				= counter();
	Control_EXT					= counter();
	Brightness_NS_EXT			= counter();
	Brightness_NS_AXIS			= counter();
	Brightness_PM_EXT			= counter();
	Brightness_PM_AXIS			= counter();
	Backup_Light_NS_EXT			= counter();
	Backup_Light_NS_ITER		= counter();
	Backup_Light_PM_EXT			= counter();
	Backup_Light_PM_ITER		= counter();
	Power_EXT					= counter();
	Power_ITER					= counter();
	USR_EXT						= counter();
	USR_check_EXT				= counter();

	Reflector_Fix				= counter();
	Reflector_Move				= counter();
	Reflector_Fix_EXT			= counter();
	Reflector_Move_Up_EXT		= counter();
	Reflector_Move_Down_EXT		= counter();
	USR_ITER					= counter();
	Reflector_Fix_ITER			= counter();
}

count = start_command
avASO_2V_commands =
{
	ASO_2V_Interval_2_4 	= counter(),
	ASO_2V_Series_4_16 		= counter(),
	ASO_2V_Release 			= counter(),
	ASO_2V_Left 			= counter(),
	ASO_2V_Right 			= counter(),
	ASO_2V_Set_I_II_III 	= counter(),
	ASO_2V_Release_Pilot	= counter(),
	
	ASO_2V_Interval_2_4_Ext = counter(),
	ASO_2V_Series_4_16_Ext 	= counter(),
	ASO_2V_Left_Ext			= counter(),
	ASO_2V_Right_Ext		= counter(),
	ASO_2V_Set_I_II_III_Ext	= counter(),
	ASO_2V_Release_Ext		= counter(),
	ASO_2V_Release_Pilot_Ext	= counter(),
};

count = start_command
greben_commands =
{
	POWER			= counter();
	POWER_EXT		= counter();
	POWER_ITER		= counter();
	LATITUDE		= counter();
	LATITUDE_EXT	= counter();
	LATITUDE_AXIS	= counter();
	MATCH			= counter();
	MATCH_EXT		= counter();
	MODE			= counter();
	MODE_EXT		= counter();
	MODE_ITER		= counter();
	SETUP_OPER		= counter();
	SETUP_OPER_EXT	= counter();
	SETUP_OPER_ITER	= counter();
	ZK				= counter();
	ZK_ITER			= counter();
}

count = start_command
avKM_2_commands =
{		
	MagneticDeclRotary		= counter();
	TEST					= counter();
	MagneticDeclRotary_EXT	= counter();
	TEST_EXT				= counter();
	calc_magn_var			= counter();
}

count = start_command
diss_commands =
{
	POWER						= counter();
	DVS							= counter();
	COORD_OFF					= counter();
	COORD_ON					= counter();
	COORD_DEC_MAP_ANGLE			= counter();
	COORD_INC_MAP_ANGLE			= counter();
	COORD_DEC_PATH_KM			= counter();
	COORD_INC_PATH_KM			= counter();
	COORD_DEC_DEVIATION_KM		= counter();
	COORD_INC_DEVIATION_KM		= counter();
	W_CHECK_WORK				= counter();
	W_LAND_SEA					= counter();
	CHECK_SWITCH				= counter();
	POWER_EXT					= counter();
	POWER_ITER					= counter();
	DVS_EXT						= counter();
	DVS_ITER					= counter();
	COORD_OFF_EXT				= counter();
	COORD_ON_EXT				= counter();
	COORD_DEC_MAP_ANGLE_EXT		= counter();
	COORD_INC_MAP_ANGLE_EXT		= counter();
	COORD_DEC_PATH_KM_EXT		= counter();
	COORD_INC_PATH_KM_EXT		= counter();
	COORD_DEC_DEVIATION_KM_EXT	= counter();
	COORD_INC_DEVIATION_KM_EXT	= counter();
	W_CHECK_WORK_EXT			= counter();
	W_CHECK_WORK_ITER			= counter();
	W_LAND_SEA_EXT				= counter();
	W_LAND_SEA_ITER				= counter();
	CHECK_SWITCH_EXT			= counter();
	CHECK_SWITCH_ITER			= counter();
}

count = start_command
fmproxy_commands = --kekeke
{
	STATIC_SYS_MODE			= counter();
	STATIC_SYS_MODE_EXT     = counter();
    STATIC_SYS_MODE_ITER    = counter();
}

count = start_command
ralt_commands = 
{
	ROTARY			= counter();
	TEST			= counter();
	POWER			= counter();
	POWER_EXT		= counter();
	POWER_ITER		= counter();
	ROTARY_EXT		= counter();
	TEST_EXT		= counter();
}

count = start_command
arc15_commands =
{
	VOLUME				= counter();
	TLF_TLG				= counter();
	MODE				= counter();
	BACKUP_100KHz		= counter();
	BACKUP_10KHz		= counter();
	BACKUP_1KHz			= counter();
	PRIMARY_100KHz		= counter();
	PRIMARY_10KHz		= counter();
	PRIMARY_1KHz		= counter();
	LOOP				= counter();
	DIAL_SELECT			= counter();
	CONTROL				= counter();
	VOLUME_EXT			= counter();
	TLF_TLG_EXT			= counter();
	TLF_TLG_ITER		= counter();
	MODE_EXT			= counter();
	BACKUP_100KHz_EXT	= counter();
	BACKUP_10KHz_EXT	= counter();
	BACKUP_1KHz_EXT		= counter();
	PRIMARY_100KHz_EXT	= counter();
	PRIMARY_10KHz_EXT	= counter();
	PRIMARY_1KHz_EXT	= counter();
	LOOP_EXT			= counter();
	DIAL_SELECT_EXT		= counter();
	DIAL_SELECT_ITER	= counter();
	CONTROL_EXT			= counter();
}

count = start_command
r863_commands = 
{
	POWER				= counter();
	POWER_EXT			= counter();
	POWER_ITER			= counter();
	AM_FM				= counter();
	AM_FM_EXT			= counter();
	AM_FM_ITER			= counter();
	CHANNEL_SEL			= counter();
	CHANNEL_SEL_ITER	= counter();
	SQUELCH				= counter();
	SQUELCH_EXT			= counter();
	SQUELCH_ITER		= counter();
	VOLUME				= counter();
	VOLUME_AXIS			= counter();
	VOLUME_ITER			= counter();
	EMERG_RCV			= counter();
	EMERG_RCV_EXT		= counter();
	EMERG_RCV_ITER		= counter();
	ARC					= counter();
	ARC_EXT				= counter();
	ARC_ITER			= counter();
}

count = start_command
jadro_commands = 
{
	MODE				= counter();
	MODE_EXT			= counter();
	MODE_ITER			= counter();
	FREQ_1MHZ			= counter();
	FREQ_1MHZ_EXT		= counter();
	FREQ_1MHZ_ITER		= counter();
	FREQ_100KHZ			= counter();
	FREQ_100KHZ_EXT		= counter();
	FREQ_100KHZ_ITER	= counter();
	FREQ_10KHZ			= counter();
	FREQ_10KHZ_EXT		= counter();
	FREQ_10KHZ_ITER		= counter();
	FREQ_1KHZ			= counter();
	FREQ_1KHZ_EXT		= counter();
	FREQ_1KHZ_ITER		= counter();
	FREQ_100HZ			= counter();
	FREQ_100HZ_EXT		= counter();
	FREQ_100HZ_ITER		= counter();
	VOLUME				= counter();
	VOLUME_AXIS			= counter();
	VOLUME_ITER			= counter();
	SQUELCH				= counter();
	SQUELCH_AXIS		= counter();
	SQUELCH_ITER		= counter();
	CTL					= counter();
	CTL_EXT				= counter();
	POWER				= counter();
	POWER_EXT			= counter();
	POWER_ITER			= counter();
}

count = start_command
eucalypt_commands = 
{
	CHANNEL_CHANGE				= counter();
    VOLUME_CHANGE				= counter();
    ASU							= counter();
    NOISE_REDUCTOR_ON_OFF2		= counter();
    POWER_ON_OFF2				= counter();
	CHANNEL_CHANGE_EXT			= counter();
    CHANNEL_CHANGE_ITER			= counter();
    VOLUME_CHANGE_AXIS			= counter();
    VOLUME_CHANGE_ITER			= counter();
    ASU_EXT						= counter();
    NOISE_REDUCTOR_ON_OFF2_EXT	= counter();
    NOISE_REDUCTOR_ON_OFF2_ITER	= counter();
    POWER_ON_OFF2_EXT			= counter();
    POWER_ON_OFF2_ITER			= counter();
}

count = start_command
r852_commands = 
{
	CHANNEL			= counter();
	CHANNEL_EXT		= counter();
	CHANNEL_ITER	= counter();
	VOLUME			= counter();
	VOLUME_EXT		= counter();
	VOLUME_AXIS		= counter();
}

count = start_command
G_Meter_commands = 
{
	Command_AccelReset	= counter();
	Command_AccelReset_EXT = counter();
}

count = start_command
ARC_U2_commands = 
{
	CMD_ARC_U2_ON_OFF 				= counter();
	CMD_ARC_U2_FRAME_LEFT			= counter();
	CMD_ARC_U2_FRAME_RIGHT			= counter();
	CMD_ARC_U2_SENS					= counter();
	CMD_ARC_U2_COMPASS_CONNECT		= counter();
	CMD_ARC_U2_ON_OFF_EXT 			= counter();
	CMD_ARC_U2_FRAME_EXT_LEFT		= counter();
	CMD_ARC_U2_FRAME_EXT_RIGHT		= counter();
	CMD_ARC_U2_SENS_EXT				= counter();
	CMD_ARC_U2_COMPASS_CONNECT_EXT	= counter();
}

count = start_command
SPU_8_Mi24_commands = 
{
	CMD_SPU8_P_MAIN_VOLUME 		= counter();
	CMD_SPU8_P_RADIO_VOLUME		= counter();
	CMD_SPU8_P_MODE				= counter();
	CMD_SPU8_P_ICS_RADIO		= counter();
	CMD_SPU8_P_TRIGGER			= counter();
	CMD_SPU8_P_LARING			= counter();
	CMD_SPU8_P_NETWORK			= counter();
	CMD_SPU8_P_CIRC_FLOW		= counter();
	CMD_SPU8_O_MAIN_VOLUME		= counter();
	CMD_SPU8_O_RADIO_VOLUME		= counter();
	CMD_SPU8_O_MODE				= counter();
	CMD_SPU8_O_ICS_RADIO		= counter();
	CMD_SPU8_O_NETWORK			= counter();
	CMD_SPU8_O_CIRC_FLOW		= counter();
	CMD_SPU8_O_ICS				= counter();
	CMD_SPU8_NETWORK			= counter();
	CMD_SPU8_NETWORK_1			= counter();
	CMD_SPU8_NETWORK_2			= counter();
	CMD_SPU8_MAIN_VOLUME_EXT	= counter();
	CMD_SPU8_RADIO_VOLUME_EXT	= counter();
	CMD_SPU8_MODE_EXT			= counter();
	CMD_SPU8_ICS_RADIO_EXT		= counter();
	CMD_SPU8_NETWORK_EXT		= counter();
	CMD_SPU8_TRIGGER_P			= counter();
	CMD_SPU8_TRIGGER_O			= counter();
	CMD_SPU8_TRIGGER_EXT		= counter();
	CMD_SPU8_O_ICS_EXT			= counter();
	CMD_SPU8_MODE_ITER			= counter();
	CMD_SPU8_ICS_RADIO_ITER		= counter();
	CMD_SPU8_NETWORK_ITER		= counter();
}

count = start_command
IFF_6201_commands = 
{
	CMD_IFF_Mode_Sw 			= counter();
	CMD_IFF_Device_Sw			= counter();
	CMD_IFF_1_2					= counter();
	CMD_IFF_Erase_BtnCover		= counter();
	CMD_IFF_Erase_Btn			= counter();
	CMD_IFF_Disaster_SwCover	= counter();
	CMD_IFF_Disaster_Sw			= counter();
	CMD_IFF_Power_Sw			= counter();
	CMD_IFF_Mode_Sw_EXT			= counter();
	CMD_IFF_Device_Sw_EXT		= counter();
	CMD_IFF_1_2_EXT				= counter();
	CMD_IFF_Erase_BtnCover_EXT	= counter();
	CMD_IFF_Disaster_SwCover_EXT= counter();
	CMD_IFF_Disaster_Sw_EXT		= counter();
	CMD_IFF_Power_Sw_EXT		= counter();
}

count = start_command
RecorderMC61_commands = 
{
	CMD_Power         = counter();
	CMD_Auto_Work     = counter();
	CMD_LightRst      = counter();
	CMD_Laryngophone  = counter();
	CMD_Power_EXT	  = counter();
	CMD_Auto_Work_EXT = counter();
	CMD_LightRst_EXT  = counter();
	CMD_Laryngophone_EXT  = counter();
}

count = start_command
RI65_commands = 
{
	CMD_RI_Mi24_Off      		= counter();
	CMD_RI_Mi24_Check  	 		= counter();
	CMD_RI_Mi24_Repeat   		= counter();
	Command_RI_Mi24_Off_EXT 	= counter();
	Command_RI_Mi24_Check_EXT 	= counter();
	Command_RI_Mi24_Repeat_EXT 	= counter();
}

count = start_command
AntiIceSys_commands = 
{
	--AntiIce
	ANTIICE_ManAuto						= counter();
	ANTIICE_Off							= counter();
	ANTIICE_LeftEng						= counter();
	ANTIICE_RightEng					= counter();
	ANTIICE_GLAZING_P					= counter();
	ANTIICE_GLAZING_O					= counter();
	ANTIICE_Ammeter						= counter();
	ANTIICE_ManAuto_EXT					= counter();
	ANTIICE_ManAuto_ITER				= counter();
	ANTIICE_Off_EXT						= counter();
	ANTIICE_LeftEng_EXT					= counter();
	ANTIICE_LeftEng_ITER				= counter();
	ANTIICE_RightEng_EXT				= counter();
	ANTIICE_RightEng_ITER				= counter();
	ANTIICE_GLAZING_P_EXT				= counter();
	ANTIICE_GLAZING_P_ITER				= counter();
	ANTIICE_GLAZING_O_EXT				= counter();
	ANTIICE_GLAZING_O_ITER				= counter();
	ANTIICE_Ammeter_EXT					= counter();
	ANTIICE_Ammeter_ITER				= counter();
}

count = start_command
ext_cargo_equipment_commands =
{
	CMD_TacticalReleaseBtn						= counter();
	CMD_TacticalReleaseBtn_Cover				= counter();
	CMD_EmergencyReleaseBtn						= counter();
	CMD_EmergencyReleaseBtn_Cover				= counter();
	CMD_OperatorEmergencyReleaseBtn				= counter();
	CMD_OperatorEmergencyReleaseBtn_Cover		= counter();
	CMD_AutoReleaseSw							= counter();
	CMD_RemoveRelease 							= counter();
	-- input commands
	CMD_TacticalReleaseBtn_EXT					= counter();
	CMD_TacticalReleaseBtn_Cover_EXT			= counter();
	CMD_TacticalReleaseBtn_Cover_ITER			= counter();
	CMD_EmergencyReleaseBtn_EXT					= counter();
	CMD_EmergencyReleaseBtn_Cover_EXT			= counter();
	CMD_EmergencyReleaseBtn_Cover_ITER			= counter();
	CMD_OperatorEmergencyReleaseBtn_EXT			= counter();
	CMD_OperatorEmergencyReleaseBtn_Cover_EXT	= counter();
	CMD_OperatorEmergencyReleaseBtn_Cover_ITER	= counter();
	CMD_AutoReleaseSw_EXT						= counter();
	CMD_AutoReleaseSw_ITER						= counter();
	CMD_RemoveRelease_EXT						= counter();
	CMD_RemoveRelease_ITER						= counter();
	CMD_EmergReleaseBtn_EXT						= counter();
	CMD_EmergReleaseBtnCover_EXT				= counter();
	CMD_EmergReleaseBtnCover_ITER				= counter();
}

count = start_command
SARPP_commands = 
{
	CMD_Mode  = counter();
}

count = start_command
signal_flares_commands = 
{
	CMD_Cassette1_Power 			= counter();
	CMD_drop_Cassette1_GREEN		= counter();
	CMD_drop_Cassette1_RED			= counter();
	CMD_drop_Cassette1_WHITE		= counter();
	CMD_drop_Cassette1_YELLOW		= counter();
	CMD_Cassette2_Power				= counter();
	CMD_drop_Cassette2_GREEN		= counter();
	CMD_drop_Cassette2_RED			= counter();
	CMD_drop_Cassette2_WHITE		= counter();
	CMD_drop_Cassette2_YELLOW		= counter();
	CMD_Cassette1_Power_EXT			= counter();
	CMD_drop_Cassette1_GREEN_EXT	= counter();
	CMD_drop_Cassette1_RED_EXT		= counter();
	CMD_drop_Cassette1_WHITE_EXT	= counter();
	CMD_drop_Cassette1_YELLOW_EXT	= counter();
	CMD_Cassette2_Power_EXT			= counter();
	CMD_drop_Cassette2_GREEN_EXT	= counter();
	CMD_drop_Cassette2_RED_EXT		= counter();
	CMD_drop_Cassette2_WHITE_EXT	= counter();
	CMD_drop_Cassette2_YELLOW_EXT	= counter();
}

count = start_command

timers_commands = 
{
	CMD_Timer_On_Off 			= counter(),
	CMD_Timer_Left_Right 		= counter(),
	CMD_Timer_Left_Up_Down 		= counter(),
	CMD_Timer_Left_Rot 			= counter(),
	CMD_Timer_Right_Up_Down 	= counter(),
	CMD_Timer_Right_Rot 		= counter(),
	CMD_Timer_On_Off_Ext		= counter(),
	CMD_Timer_Left_Right_Ext	= counter(),
	CMD_Timer_Left_Up_Down_Ext	= counter(),
	CMD_Timer_Left_Rot_Ext		= counter(),
	CMD_Timer_Right_Up_Down_Ext	= counter(),
	CMD_Timer_Right_Rot_Ext		= counter(),
}

count = start_command
pki_commands =
{
	Reflector_Move 				= counter(),
	Reflector_Move_Up_Down_EXT	= counter(),
	Reflector_Move_Up_Down_Axis	= counter(),
	Brightness					= counter(),
	Brightness_EXT				= counter(),
	Lock_Unlock					= counter(),
	Lock_Unlock_EXT				= counter(),
}

count = start_command
R60_commands =
{
	Power_OnOff 				= counter(),
	NC_VC						= counter(),
	StationSelector 			= counter(),
	
	Power_OnOff_Ext 			= counter(),
	NC_VC_Ext					= counter(),
	StationSelector_Ext 		= counter(),
}