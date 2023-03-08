local gettext = require("i_18n")
_ = gettext.translate

ADI_UNIT = 1
CK_UNIT = 2
DATACARTRIDGE = 3
RPMSENSOR = 4
EGTSENSOR = 5
EPRSENSOR = 6
TVDISPLAY = 7
MAINPITOT = 8
AOASENSOR = 9
ACCSENSOR = 10
FDU = 11
BCKPITOT = 12
BCKGYRO = 13
TEMPSENSOR = 14
HAW = 15
FR22RADIO = 16
FR22ANTENNA = 17
FR24RADIO = 18
FR24ANTENNA = 19
RADARALTUNIT = 20
RADARALTANT = 21
RADARASS = 22
RADARDISPL = 23
TAPEREC = 24
RB05ANT = 25
RB05ANT = 25
RWRANTLEFT = 26
RWRANTRIGHT = 27
RWRANTREAR = 28
RWRUNIT = 29
JAMMER = 30
CMDISP = 31
AUTOPILOT = 32
ELEVONOUTERLEFT = 33
ELEVONINNERLEFT = 34
ELEVONINNERRIGHT = 35
ELEVONOUTERRIGHT = 36
ELEVONSERVOUTERLEFT = 37
ELEVONSERVINNERLEFT = 38
ELEVONSERVINNERRIGHT = 39
ELEVONSERVOUTERRIGHT = 40
RUDDER = 41
RUDDERSERV = 42
CANARDFLAPLEFT = 43
CANARDFLAPRIGHT = 44
CANARDSERVOLEFT = 45
CANARDSERVORIGHT = 46
AIRBRAKE = 47
AIRBRAKESERVO = 48
HYDR1PUMP = 49
HYDR1ACC = 50
HYDR2PUMP = 51
HYDR2ACC = 52
HYDRRESERVPUMP = 53
OXYGEN = 54
MAINPOWER = 55
MAINGENERATOR = 56
BACKUPGENERATOR = 57
BATTERY = 58
IFF = 59
TILS = 60
COMPRESSOR = 62
BURNER = 63
TURBINE = 64
GTS = 65
AFK = 66
REVERSER = 67
FUELTANK2 = 68
FUELTANK3L = 69
FUELTANK3R = 70
FUELTANK1 = 71
FUELTANK4L = 72
FUELTANK5L = 73
FUELTANK4R = 74
FUELTANK5R = 75
HUDDISPLAY = 76
LANDINGGEARL = 77
LANDINGGEARR = 78

Damage =
{
	{
		Failure = ADI_UNIT,
		Failure_name = "ADI_UNIT",
		Failure_editor_name = _("Flight Attitude Unit"),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},		
	{
		Failure = CK_UNIT,
		Failure_name = "CK_UNIT",
		Failure_editor_name = _("Central computer Unit"),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},		
	{
		Failure = DATACARTRIDGE,
		Failure_name = "DATACARTRIDGE",
		Failure_editor_name = _("Central computer datacartridge"),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},			
		{
		Failure = RPMSENSOR,
		Failure_name = "RPMSENSOR",
		Failure_editor_name = _(""),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},		
	{
		Failure = EGTSENSOR,
		Failure_name = "EGTSENSOR",
		Failure_editor_name = _(""),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},	
	{
		Failure = EPRSENSOR,
		Failure_name = "EPRSENSOR",
		Failure_editor_name = _(""),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},	
		{
		Failure = TVDISPLAY,
		Failure_name = "TVDISPLAY",
		Failure_editor_name = _(""),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},		
	{
		Failure = MAINPITOT,
		Failure_name = "MAINPITOT",
		Failure_editor_name = _("Main pitot"),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},				
	{
		Failure = AOASENSOR,
		Failure_name = "AOASENSOR",
		Failure_editor_name = _("AoA sensor"),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},			
	{
		Failure = ACCSENSOR,
		Failure_name = "ACCSENSOR",
		Failure_editor_name = _("Acc sensor"),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},		
	{
		Failure = FDU,
		Failure_name = "FDU",
		Failure_editor_name = _("FlightDataUnit"),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},		
	{
		Failure = BCKPITOT,
		Failure_name = "BCKPITOT",
		Failure_editor_name = _("Backup pitot"),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},			
	{
		Failure = BCKGYRO,
		Failure_name = "BCKGYRO",
		Failure_editor_name = _("Backup gyro"),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},				
	{
		Failure = TEMPSENSOR,
		Failure_name = "TEMPSENSOR",
		Failure_editor_name = _("Temp sensor"),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},				
	{
		Failure = HAW,
		Failure_name = "HAW",
		Failure_editor_name = _("Temp sensor"),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},			
{
		Failure = FR22RADIO,
		Failure_name = "FR22RADIO",
		Failure_editor_name = _("FR22"),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},	
	{
		Failure = FR22ANTENNA,
		Failure_name = "FR22ANTENNA",
		Failure_editor_name = _("FR22ANTENNA"),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},	
	{
		Failure = FR24RADIO,
		Failure_name = "FR24RADIO",
		Failure_editor_name = _("FR24"),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},	
	{
		Failure = FR24ANTENNA,
		Failure_name = "FR24ANTENNA",
		Failure_editor_name = _("FR24ANTENNA"),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},		
		{
		Failure = RADARALTUNIT,
		Failure_name = "RADARALTUNIT",
		Failure_editor_name = _("RADARALTUNIT"),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},	
	{
		Failure = RADARALTANT,
		Failure_name = "RADARALTANT",
		Failure_editor_name = _("RADARALTANT"),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},	
		{
		Failure = RADARASS,
		Failure_name = "RADARASS",
		Failure_editor_name = _("RADARASS"),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},	
	{
		Failure = RADARDISPL,
		Failure_name = "RADARDISPL",
		Failure_editor_name = _("RADARDISPL"),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},	
	{
		Failure = TAPEREC,
		Failure_name = "TAPEREC",
		Failure_editor_name = _("Tape recorder"),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},		
	{
		Failure = RB05ANT,
		Failure_name = "RB05ANT",
		Failure_editor_name = _("Rb05 Antenna"),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},		
	{
		Failure = RWRANTLEFT,
		Failure_name = "RWRANTLEFT",
		Failure_editor_name = _("RWRANTLEFT"),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},	
	{
		Failure = RWRANTRIGHT,
		Failure_name = "RWRANTRIGHT",
		Failure_editor_name = _("RWRANTRIGHT"),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},	
	{
		Failure = RWRANTREAR,
		Failure_name = "RWRANTREAR",
		Failure_editor_name = _("RWRANTREAR"),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},	
	{
		Failure = RWRUNIT,
		Failure_name = "RWRUNIT",
		Failure_editor_name = _("RWRUNIT"),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},	
	{
		Failure = JAMMER,
		Failure_name = "JAMMER",
		Failure_editor_name = _("JAMMER"),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},			
	{
		Failure = CMDISP,
		Failure_name = "CMDISP",
		Failure_editor_name = _("CMDISP"),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},			
	{
		Failure = AUTOPILOT,
		Failure_name = "AUTOPILOT",
		Failure_editor_name = _("AUTOPILOT"),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},			
	{
		Failure = ELEVONOUTERLEFT,
		Failure_name = "ELEVONOUTERLEFT",
		Failure_editor_name = _("ELEVONOUTERLEFT"),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},			
	{
		Failure = ELEVONINNERLEFT,
		Failure_name = "ELEVONINNERLEFT",
		Failure_editor_name = _("ELEVONINNERLEFT"),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},			
	{
		Failure = ELEVONINNERRIGHT,
		Failure_name = "ELEVONINNERRIGHT",
		Failure_editor_name = _("ELEVONINNERRIGHT"),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},			
	{
		Failure = ELEVONOUTERRIGHT,
		Failure_name = "ELEVONOUTERRIGHT",
		Failure_editor_name = _("ELEVONOUTERRIGHT"),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},			
	{
		Failure = ELEVONSERVOUTERLEFT,
		Failure_name = "ELEVONSERVOUTERLEFT",
		Failure_editor_name = _("ELEVONSERVOUTERLEFT"),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},			
	{
		Failure = ELEVONSERVINNERLEFT,
		Failure_name = "ELEVONSERVINNERLEFT",
		Failure_editor_name = _("ELEVONSERVINNERLEFT"),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},			
	{
		Failure = ELEVONSERVINNERRIGHT,
		Failure_name = "ELEVONSERVINNERRIGHT",
		Failure_editor_name = _("ELEVONSERVINNERRIGHT"),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},			
	{
		Failure = ELEVONSERVOUTERRIGHT,
		Failure_name = "ELEVONSERVOUTERRIGHT",
		Failure_editor_name = _("ELEVONSERVOUTERRIGHT"),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},			
	{
		Failure = RUDDER,
		Failure_name = "RUDDER",
		Failure_editor_name = _("RUDDER"),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},			
	{
		Failure = RUDDERSERV,
		Failure_name = "RUDDERSERV",
		Failure_editor_name = _("RUDDERSERV"),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},			
	{
		Failure = CANARDFLAPLEFT,
		Failure_name = "CANARDFLAPLEFT",
		Failure_editor_name = _("CANARDFLAPLEFT"),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},			
	{
		Failure = CANARDFLAPRIGHT,
		Failure_name = "CANARDFLAPRIGHT",
		Failure_editor_name = _("CANARDFLAPRIGHT"),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},			
	{
		Failure = CANARDSERVOLEFT,
		Failure_name = "CANARDSERVOLEFT",
		Failure_editor_name = _("CANARDSERVOLEFT"),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},			
	{
		Failure = CANARDSERVORIGHT,
		Failure_name = "CANARDSERVORIGHT",
		Failure_editor_name = _("CANARDSERVORIGHT"),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},				
	{
		Failure = AIRBRAKE,
		Failure_name = "AIRBRAKE",
		Failure_editor_name = _("Airbrake surfaces"),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},				
	{
		Failure = AIRBRAKESERVO,
		Failure_name = "AIRBRAKESERVO",
		Failure_editor_name = _("Airbrake servo"),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},				
	{
		Failure = HYDR1PUMP,
		Failure_name = "HYDR1PUMP",
		Failure_editor_name = _("Hydraulic pump System 1"),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},				
	{
		Failure = HYDR1ACC,
		Failure_name = "HYDR1ACC",
		Failure_editor_name = _("Hydraulic accumulator System 1"),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},				
	{
		Failure = HYDR2PUMP,
		Failure_name = "HYDR2PUMP",
		Failure_editor_name = _("Hydraulic pump System 2"),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},				
	{
		Failure = HYDR2ACC,
		Failure_name = "HYDR2ACC",
		Failure_editor_name = _("Hydraulic accumulator System 2"),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},				
	{
		Failure = HYDRRESERVPUMP,
		Failure_name = "HYDRRESERVPUMP",
		Failure_editor_name = _("Hydraulic pump Reserve"),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},				
	{
		Failure = OXYGEN,
		Failure_name = "OXYGEN",
		Failure_editor_name = _("Oxygen bottle"),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},			
	{
		Failure = MAINPOWER,
		Failure_name = "MAINPOWER",
		Failure_editor_name = _("Main power"),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},			
	{
		Failure = MAINGENERATOR,
		Failure_name = "MAINGENERATOR",
		Failure_editor_name = _("Main generator"),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},			
	{
		Failure = BACKUPGENERATOR,
		Failure_name = "BACKUPGENERATOR",
		Failure_editor_name = _("Backup generator"),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},			
	{
		Failure = BATTERY,
		Failure_name = "BATTERY",
		Failure_editor_name = _("Battery"),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},			
	{
		Failure = IFF,
		Failure_name = "IFF",
		Failure_editor_name = _("IFF"),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},			
	{
		Failure = TILS,
		Failure_name = "TILS",
		Failure_editor_name = _("TILS"),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},			
	{
		Failure = COMPRESSOR,
		Failure_name = "COMPRESSOR",
		Failure_editor_name = _("Engine fan and compressor stage"),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},			
	{
		Failure = BURNER,
		Failure_name = "BURNER",
		Failure_editor_name = _("Engine burner stage"),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},			
	{
		Failure = TURBINE,
		Failure_name = "TURBINE",
		Failure_editor_name = _("Engine turbine stage"),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},			
	{
		Failure = GTS,
		Failure_name = "GTS",
		Failure_editor_name = _("Engine starter (GTS)"),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},			
	{
		Failure = AFK,
		Failure_name = "AFK",
		Failure_editor_name = _("Auto-thrust (AFK)"),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},			
	{
		Failure = REVERSER,
		Failure_name = "REVERSER",
		Failure_editor_name = _("Thrust reverser"),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},			
	{
		Failure = FUELTANK2,
		Failure_name = "FUELTANK2",
		Failure_editor_name = _("Fuel tank 2"),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},			
	{
		Failure = FUELTANK3L,
		Failure_name = "FUELTANK3L",
		Failure_editor_name = _("Fuel tank 3L"),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},			
	{
		Failure = FUELTANK3R,
		Failure_name = "FUELTANK3R",
		Failure_editor_name = _("Fuel tank 3R"),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},			
	{
		Failure = FUELTANK1,
		Failure_name = "FUELTANK1",
		Failure_editor_name = _("Fuel tank 1"),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},			
	{
		Failure = FUELTANK4L,
		Failure_name = "FUELTANK4L",
		Failure_editor_name = _("Fuel tank 4L"),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},			
	{
		Failure = FUELTANK5L,
		Failure_name = "FUELTANK5L",
		Failure_editor_name = _("Fuel tank 5L"),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},			
	{
		Failure = FUELTANK4R,
		Failure_name = "FUELTANK4R",
		Failure_editor_name = _("Fuel tank 4R"),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},		
	{
		Failure = FUELTANK5R,
		Failure_name = "FUELTANK5R",
		Failure_editor_name = _("Fuel tank 5R"),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},		
	{
		Failure = HUDDISPLAY,
		Failure_name = "HUDDISPLAY",
		Failure_editor_name = _("EP08 Head Up Display"),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},
	{
    	Failure = LANDINGGEARL,
    	Failure_name = "LANDINGGEARL",
    	Failure_editor_name = _("Left landing Gear"),
    	Element = 4,
    	Integrity_Treshold = 0.0,
    	Slope_param = 10.0,
    	work_time_to_fail_probability = 0.5,
    	work_time_to_fail = 3600*3000
    },
    {
    	Failure = LANDINGGEARR,
    	Failure_name = "LANDINGGEARR",
    	Failure_editor_name = _("Right landing Gear"),
    	Element = 5,
    	Integrity_Treshold = 0.0,
    	Slope_param = 10.0,
    	work_time_to_fail = 3600*3000
    },
}

need_to_be_closed = true