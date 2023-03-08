

Keys =
{	
	Engine_Start	= 311,
	Engine_Stop		= 312,

}

start_command = 3000
device_commands =
{
	BatteryOn = start_command + 1,
	BatteryHeat = start_command + 2,
	DCGenerator = start_command + 3,
	
	ACGenerator = start_command + 4,
	PO7501 = start_command + 5,
	PO7502 = start_command + 6,
	EmergencyInverter = start_command + 7,
	
	Giro1 = start_command + 8,
	Giro2 = start_command + 9,
	
	Pump3 = start_command + 10,
	Pump1 = start_command + 11,
	PumpRashod = start_command + 12,
	FuelQt = start_command + 13,
	
	Zazig = start_command + 14,
	HotStart = start_command + 15,
	StartButton = start_command + 16,
	AirStart = start_command + 17,
	
	AccelReset = start_command + 18,
	
	PitoSelect = start_command + 19,
	PitoHeatMain = start_command + 20,
	PitoHeatAux = start_command + 21,

	SurgeDoors = start_command + 22,
	ForsMax = start_command + 23,
	Chr = start_command + 24,
	PozarOborud = start_command + 25,
	PozarSafetyCover = start_command + 26,
	Ognetushitel = start_command + 27,

	TextBacklight_kb_up = start_command + 28,
	InstrumentsBacklight_kb_up = start_command + 29,
	RedLightsMain_kb_up = start_command + 30,
	WhiteLightsMain_kb_up = start_command + 31,

	TextBacklight_kb_down = start_command + 328,
	InstrumentsBacklight_kb_down = start_command + 329,
	RedLightsMain_kb_down = start_command + 330,
	WhiteLightsMain_kb_down = start_command + 331,
	
	NavLights = start_command + 32,
	LandingLights = start_command + 33,
	LandingLights_mouse = start_command + 333,

	CheckWarningLights10 = start_command + 34,
		CheckWarningLights11 = start_command + 74,
	CheckWarningLights20 = start_command + 35,
		CheckWarningLights21 = start_command + 75,
	CheckWarningLights30 = start_command + 36,
		CheckWarningLights31 = start_command + 76,
	CheckWarningLights40 = start_command + 37,
		CheckWarningLights41 = start_command + 77,
	CheckWarningLights50 = start_command + 38,
		CheckWarningLights51 = start_command + 78,
	CheckWarningLights60 = start_command + 39,
		CheckWarningLights61 = start_command + 79,
	SORC = start_command + 40,
	
	RadioOn = start_command + 41,
	RadioCompassSound = start_command + 42,
	Squelch = start_command + 43,
	RadioVolume = start_command + 44,
	RadioChannel = start_command + 45,
	RadioINTERCOM = start_command + 46,
	
	RadioOn_kb = start_command + 441,
	RadioVolume_kb = start_command + 344,
	RadioChannel_kb = start_command + 345,
	
	ARKon = start_command + 47,
	ARKsound = start_command + 48,
	ARKpereklucenie = start_command + 49,
	ARKchannel = start_command + 50,
	ARKzone = start_command + 51,
	ARKantenaCompass = start_command + 52,
	ARKfarNear = start_command + 53,
	
	RSBNon = start_command + 54,
	RSBNmode = start_command + 55,
	RSBNARK = start_command + 56,
	RSBNident = start_command + 57,
	
	RSBNsound = start_command + 58,
	RSBNnav = start_command + 59,
	RSBNland = start_command + 60,
	
	RSBNnav_kb = start_command + 459,
	RSBNland_kb = start_command + 460,
	
	RSBNreset = start_command + 61,
	RSBNbearing = start_command + 62,
	RSBNfar = start_command + 63,
	RSBNtest = start_command + 80,
	RSBNmodeToggle = start_command + 81,

	SAUon = start_command + 64,
	SAUpitchOn = start_command + 65,
	SAUstabil = start_command + 66,
	SAUcancel = start_command + 67,
	SAUprivedenie = start_command + 68,
	SAUlowAltOn = start_command + 69,
	SAUlandingControlCommand = start_command + 70,
	SAUlandingControlAuto = start_command + 71,
	SAUresetOff = start_command + 72,
	AltimeterPressure = start_command	+	73,
	
	--=============== free 82 ==================
	
	SPOon = start_command + 83,
	SPOtest = start_command + 84,
	SPOdayNight = start_command + 85,
	SPOvolume = start_command + 86,
	
	SPOvolume_kb = start_command + 386,

	SRZOvopros = start_command + 87,
	SRZOcodes = start_command + 88,
	SRZOon = start_command + 89,
	
	SODon = start_command + 90,
	SODident = start_command + 91,
	SODvolni = start_command + 92,
	SODmode = start_command + 93,

	RADARon = start_command + 94,
	RADARlowAlt = start_command + 95,
	RADARfixBeam = start_command + 96,
	RADARmgnStir = start_command + 97,
	RADARjamCont = start_command + 98,
	RADARjamTmp = start_command + 99,
	RADARjamPass = start_command + 100,
	RADARjamMeteo	=	start_command	+	101,
	RADARvopros	=	start_command	+	102,
	RADARjamLowSpeed	=	start_command	+	103,
	RADARkontrol	=	start_command	+	104,
	RADARreset	=	start_command	+	105,

	SPRDstartOn	=	start_command	+	106,
	SPRDdropOn	=	start_command	+	107,
	SPRDstartSafetyCover	=	start_command	+	108,
	SPRDdropSafetyCover	=	start_command	+	109,
	SPRDstart	=	start_command	+	110,
	SPRDdrop	=	start_command	+	111,

	SPSon	=	start_command	+	112,

	ARUmanAuto	=	start_command	+	113,
	ARUlowSpeed	=	start_command	+	114,
	ARUhighSpeed	=	start_command	+	115,

	Airbrakes	=	start_command	+	116,
	
	ABSon	=	start_command	+	117,
	NosegearBrake	=	start_command	+	118,
	EmergBrakes	=	start_command	+	119,
	
	GearHandleFixator	=	start_command	+	120,
	GearLever	=	start_command	+	121,
	EmergGearsMain	=	start_command	+	122,
	EmergGearsNose	=	start_command	+	123,

	Flaps0	=	start_command	+	124,
	Flaps25	=	start_command	+	125,
	Flaps45	=	start_command	+	126,
	FlapsReset	=	start_command	+	127,
	
	DragChute	=	start_command	+	128,
	DragChuteSafetyCover	=	start_command	+	129,
	DragChuteDisconnect	=	start_command	+	130,
	
	TrimmerOn	=	start_command	+	131,
	TrimmerBtnUp =	start_command	+	132,

	KonusOn	=	start_command	+	133,
	KonusManAuto	=	start_command	+	134,
	KonusButton	=	start_command	+	135,
	
	Soplo2xPoz	=	start_command	+	136,
	
	NR27on	=	start_command	+	137,
	AileronBoosters	=	start_command	+	138,

	KPPon	=	start_command	+	139,
	KPParretir	=	start_command	+	140,
	KPPsetPitch	=	start_command	+	141,
	KPPsetPitch_kb	=	start_command	+	341,
	
	NPPon	=	start_command	+	142,
	NPPnastrojka	=	start_command	+	143,
	NPPsetCourse	=	start_command	+	144,

	
	RadioAltOn	=	start_command	+	145,
	DangerAltSelect	=	start_command	+	146,
 

	HelmetAirCondition	=	start_command	+	147,
	EmergOxygene	=	start_command	+	148,
	MixtureOxygeneSelect	=	start_command	+	149,
	
	CanopyHermetHandle	=	start_command	+	150,
	CanopyLockHandle	=	start_command	+	151,
	CanopyOpen	=	start_command	+	152,
	CanopyAntiIce	=	start_command	+	153,
	CanopyEmergRelease	=	start_command	+	154,

	ASPon	=	start_command	+	155,
	ASPmanAutoSelect	=	start_command	+	156,
	ASPbombStrelbSelect	=	start_command	+	157,
	ASPmissileGunSelect	=	start_command	+	158,
	ASPssGiroSelect	=	start_command	+	159,
	ASPpipperOn	=	start_command	+	160,
	ASPnetOn	=	start_command	+	161,
	ASPtargetSize	=	start_command	+	162,
	ASPtargetSize_mouse	=	start_command	+	662,
	ASPinterceptAngle	=	start_command	+	163,
	ASPinterceptAngle_mouse =	start_command	+	663,
	ASPscaleLight	=	start_command	+	164,
	ASPscaleLight_mouse	=	start_command	+	664,
	ASPpipperLight	=	start_command	+	165,
	ASPpipperLight_mouse	=	start_command	+	665,
	ASPnetLight	=	start_command	+	166,
	ASPnetLight_mouse	=	start_command	+	666,

	Obogrev	=	start_command	+	167,
	Pusk	=	start_command	+	168,
	Pitanie12	=	start_command	+	169,
	Pitanie34	=	start_command	+	170,
	GS23	=	start_command	+	171,
	FKP	=	start_command	+	172,
	TaktSbrosSafetyCover	=	start_command	+	173,
	TaktSbros	=	start_command	+	174,
	AvarPuskSafetyCover	=	start_command	+	175,
	AvarPusk	=	start_command	+	176,
	SbrosKrilBakovSafetyCover	=	start_command	+	177,
	SbrosKrilBakov	=	start_command	+	178,
	SbrosVnesnSafetyCover	=	start_command	+	179,
	SbrosVnesn	=	start_command	+	180,
	SbrosVnutrSafetyCover	=	start_command	+	181,
	SbrosVnutr	=	start_command	+	182,
	ASPvozduhZemlja	=	start_command	+	183,
	ASPssNeutrRns	=	start_command	+	184,
	ASPgunReload1	=	start_command	+	185,
	ASPgunReload2	=	start_command	+	186,
	ASPgunReload3	=	start_command	+	187,
	ASPlauncherSelect	=	start_command	+	188,
	MissileSound	=	start_command	+	189,
	Zahvat	=	start_command	+	190,
	GunFireBtn	=	start_command	+	191,
	PuskBtnSafetyCover	=	start_command	+	192,
	PuskBtn	=	start_command	+	193,
	CanopyClose =	start_command	+	194,
	SeatHeightup	=	start_command	+	195,
	SbrosPodvBakov	=	start_command	+	196,
	
	-- Nuke Box
	IabAvarSbros	=	start_command	+	197,
	IabAvarSbrosVzr	=	start_command	+	198,
	IabBoevojSbros	=	start_command	+	199,
	IabSpecAb	=	start_command	+	200,
	IabTormoz	=	start_command	+	201,
	IabVozduh	=	start_command	+	202,
	--
	
	DA200set	=	start_command	+	203,
	RUDoblog_kb_down	=	start_command	+	204,
	RUDoblog_kb_up	=	start_command	+	204 + 500,
	
	HelmetHeatManAut	=	start_command	+	205,
	HelmetQuickHeat	=	start_command	+	206,
	HelmetVisor	=	start_command	+	207,
	
	AirConditioningSelect	=	start_command	+	208,
	SARPP	=	start_command	+	209,
	
	EmergTransmitSafetyCover	=	start_command	+	210,
	EmergTransmitOn	=	start_command	+	211,
	SeatHeightDown	=	start_command	+	212,
	
	RUDoblog_axis	=	start_command	+	213,
	RUDoblog_axis_mouse = start_command	+	713,
	
	-- SPS Box
	SPSOnOff	=	start_command	+	214,
	SPSTransmit	=	start_command	+	215,
	SPSProgram	=	start_command	+	216,
	SPSContinous	=	start_command	+	217,
	SPStest	=	start_command	+	218,
	SPSDispense	=	start_command	+	219,
	SPSOffParalFull	=	start_command	+	220,
	SPSCover	=	start_command	+	221,
	SPSPush	=	start_command	+	222,
	--
	
	-- GUV Box
	GUVOnOff	=	start_command	+	223,
	GUVPodMain	=	start_command	+	224,
	GUVArm1	=	start_command	+	225,
	GUVArm2	=	start_command	+	226,
	GUVArm3	=	start_command	+	227,
	--
	
	GearBrakeHandle	=	start_command	+	228,
	SRZODestrCover	=	start_command	+	229,
	SRZODestr		=	start_command	+	230,
	
	TextBacklight_axis = start_command + 231,
	InstrumentsBacklight_axis = start_command + 232,
	RedLightsMain_axis = start_command + 233,
	WhiteLightsMain_axis = start_command + 234,
	
	mig21_autostart = start_command + 235,
	mig21_autostop = start_command + 236,
	
	-- 237 empty
	
	RUDStop_lock = start_command + 238,
	
	RADARFilter = start_command + 239,
	TrimmerBtnDown =	start_command	+	240,

	-- New KB control inputs
	ThrottleInc =	start_command	+	241,
	ThrottleDec =	start_command	+	242,
	RudLeft =	start_command	+	243,
	RudRight =	start_command	+	244,
	StickUp =	start_command	+	245,
	StickDown =	start_command	+	246,
	StickLeft =	start_command	+	247,
	StickRight =	start_command	+	248,
	
	-- Clock
	AChSleftpush 	=	start_command	+	249,
	AChSleftpull 	=	start_command	+	250,
	AChSleftrotate 	=	start_command	+	251,
	AChSrightpush 	=	start_command	+	252,
	AChSrightrotate =	start_command	+	253,
	
	-- Dummy
	MislModeCover		=	start_command	+	254,
	MislModeActTrain	=	start_command	+	255,
	GSuitMaxMin			=	start_command	+	256,
	SinaNr1Cover		=	start_command	+	257,
	SinaNr1				=	start_command	+	258,
	SinaNr2				=	start_command	+	259,
	AirductTestCover	=	start_command	+	260,
	AirductTest			=	start_command	+	261,
	BU45Buster			=	start_command	+	262,
	SODPBU1				=	start_command	+	263,
	SODPBU2				=	start_command	+	264,
	EjectEjectEject		=	start_command	+	265,
	EmerOxy				=	start_command	+	266,
	UK2MML				=	start_command	+	267,
	UK2MGsKm			=	start_command	+	268,
	SuitVent			=	start_command	+	269,
	Harness				=	start_command	+	270,
	CanopyVentSystem	=	start_command	+	272,
	HarnessLooseTight	=	start_command	+	273,
	RUDFixator			=	start_command	+	274,
	
	AltimeterPressureReset = start_command	+	275,
	ForceFeedback 		 = start_command	+	276,
	
	SORCNightDay		 = start_command	+	277,
	
	--/N/ ADD NEW INPUTS BY ADDING 200 - 400 FOR SEPARATION:
	
	--/N/ new, 10.05.2015.
	ASPtargetSize_kb	=	start_command	+	362,
	ASPinterceptAngle_kb	=	start_command	+	363,
	
	--/N/ new, 31.10.2015.
	AirStart_2pos = start_command + 417,
	SurgeDoors_2pos = start_command + 422,
	Chr_2pos = start_command + 424,
	
	SPRDstartSafetyCover_2pos	=	start_command	+	408,	
	SPRDdropSafetyCover_2pos	=	start_command	+	409,

	ASPmanAutoSelect_2pos = start_command + 356,
	ASPbombStrelbSelect_2pos = start_command + 357,
	ASPmissileGunSelect_2pos	=	start_command	+	358,
	ASPssGiroSelect_2pos	=	start_command	+	359,
	
	--/N/ 21.02.2016.
	AltimeterPressure_increase = start_command	+	370,
	AltimeterPressure_decrease = start_command	+	371,
	
	NPPsetCourse_kb	=	start_command	+	444,
	
	--/N/ mart 2017
	LandingLights_Landing = start_command + 433,
	LandingLights_Taxi = start_command + 432,
	LandingLights_Off = start_command + 431,
	
	WhiteLightsMain = start_command + 427,
	RedLightsMain = start_command + 428,
	
	--/N/ jun 2022
	Aileron_boosters_On = start_command + 450,
	Aileron_boosters_Off = start_command + 451,
Flaps_TO = start_command + 452,-- 0<>25 or Flaps Up<>Center (like on A-10C2) - --special for joystick
Flaps_LNDG = start_command + 453,-- 45<>25 or Flaps Down<>Center (like on A-10C) - --special for joystick
	Airbrakes_On = start_command + 454,
	Airbrakes_Off = start_command + 455,
Airbrakes_On_Off = start_command + 456,--special for joystick (optional)**
	Pylon_1_2_On = start_command + 457,
	Pylon_1_2_Off = start_command + 458,	
	GSh23_On = start_command + 461,
	GSh23_Off = start_command + 462,
	Missiles_Heat_On = start_command + 463,
	Missiles_Heat_Off = start_command + 464,
	Missiles_Rockets_Launch_On = start_command + 465,
	Missiles_Rockets_Launch_Off = start_command + 466,
	Pylon_3_4_On = start_command + 467,
	Pylon_3_4_Off = start_command + 468,
	
	
	
}
