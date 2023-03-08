local gettext = require("i_18n")
_ = gettext.translate

-- Locations
NOSE_AVIONICS		= 0
AVIONICS_BAY_1		= 76
AVIONICS_BAY_2		= 77
AVIONICS_BAY_3		= 78
AVIONICS_BAY_4		= 73
AVIONICS_BAY_5		= 74
AVIONICS_BAY_6		= 70
DMT_BLACKBOX		= 68
FLIR_BLACKBOX		= 65
STATION_1			= 86
STATION_2			= 87
STATION_3			= 79
STATION_4			= 80
STATION_5			= 81
STATION_6			= 88
STATION_7			= 89
STRAKE_LEFT			= 13
STRAKE_RIGHT		= 14
RADIO_ANT_TOP		= 39
RADIO_ANT_BOTTOM	= 58

--Devices Failures
DEV_SMS_FAIL		= 1		-- Avionics Bay 6 - Bottom
DEV_FLIR_FAIL		= 2		-- Nose Avionics Bay
DEV_DMT_FAIL		= 3		-- Nose Avionics Bay
DEV_TACTS_FAIL		= 4
DEV_MSC_FAIL		= 5		-- Avionics Bay 2 - Bottom
DEV_ATHS_FAIL		= 6
DEV_CMDS_FAIL		= 7
DEV_SAAHS_FAIL		= 8
DEV_GPS_FAIL		= 9
DEV_COM1_FAIL		= 10	-- Avionics Bay 1 - Bottom
DEV_COM2_FAIL		= 11	-- Avionics Bay 4 - Bottom
DEV_DCBUS_FAIL		= 12
DEV_HUD_FAIL		= 13
DEV_MPCDL_FAIL		= 14
DEV_MPCDR_FAIL		= 15
DEV_INS_FAIL_VEL	= 16	-- Avionics Bay 4 - Top
DEV_INS_FAIL_HDG	= 17	-- Avionics Bay 4 - Top
DEV_INS_FAIL_ATT	= 18	-- Avionics Bay 4 - Top
DEV_ADC_FAIL		= 19	-- Avionics Bay 3 - Top
DEV_EMS_FAIL		= 20
DEV_IGV_FAIL		= 21
DEV_DSS_FAIL		= 22
DEV_DVMS_FAIL		= 23	-- Avionics Bay 2 - Top
DEV_ACNIP_FAIL		= 24
DEV_AWLS_FAIL		= 25
DEV_BCN_FAIL		= 26
DEV_CNIDC_FAIL		= 27
DEV_RALT_FAIL		= 28
DEV_TCN_FAIL		= 29	-- Avionics Bay 1 - Top
DEV_IFF_FAIL		= 30
DEV_ARBS_FAIL		= 31	-- Nose Avionics Bay
WPN_STA_1			= 32
WPN_STA_2			= 33
WPN_STA_3			= 34
WPN_STA_4			= 35
WPN_STA_5			= 36
WPN_STA_6			= 37
WPN_STA_7			= 38
WPN_STRK_L			= 39
WPN_STRK_R			= 40
WPN_STA_1_DEST		= 41
WPN_STA_2_DEST		= 42
WPN_STA_3_DEST		= 43
WPN_STA_4_DEST		= 44
WPN_STA_5_DEST		= 45
WPN_STA_6_DEST		= 46
WPN_STA_7_DEST		= 47
WPN_STRK_L_DEST		= 48
WPN_STRK_R_DEST		= 49
ANT_RADIO_TOP		= 50
ANT_RADIO_BOTTM		= 51
ANT_TACAN			= 52
ANT_GPS				= 53
ANT_AWLS			= 54

Damage =
{
	--Avionics Bay 1
	{
		Failure = DEV_TCN_FAIL,
		Failure_name = "TCN_FAILURE_TOTAL",
		Failure_editor_name = _("TACAN Receiver Failure"),
		Element = AVIONICS_BAY_1,
		Integrity_Treshold = 0.95,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},
	
	{
		Failure = DEV_COM1_FAIL,
		Failure_name = "COM1_FAILURE_TOTAL",
		Failure_editor_name = _("Radio 1 Failure"),
		Element = AVIONICS_BAY_1,
		Integrity_Treshold = 0.90,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},
	
	--Avionics Bay 2
	{
		Failure = DEV_DVMS_FAIL,
		Failure_name = "DVMS_FAILURE_TOTAL",
		Failure_editor_name = _("Moving Map Controller Failure"),
		Element = AVIONICS_BAY_2,
		Integrity_Treshold = 0.95,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},
	
	{
		Failure = DEV_MSC_FAIL,
		Failure_name = "MSC_FAILURE_TOTAL",
		Failure_editor_name = _("Mission Systems Computer Failure"),
		Element = AVIONICS_BAY_2,
		Integrity_Treshold = 0.90,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},
	
	--Avionics Bay 3
	{
		Failure = DEV_ADC_FAIL,
		Failure_name = "ADC_FAILURE_TOTAL",
		Failure_editor_name = _("Air Data Computer Failure"),
		Element = AVIONICS_BAY_3,
		Integrity_Treshold = 0.90,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},
	
	
	--Avionics Bay 4
	{
		Failure = DEV_INS_FAIL_VEL,
		Failure_name = "INS_FAILURE_VELOCITY",
		Failure_editor_name = _("INS Velocity Failure"),
		Element = AVIONICS_BAY_4,
		Integrity_Treshold = 0.94,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},
	
	{
		Failure = DEV_INS_FAIL_HDG,
		Failure_name = "INS_FAILURE_HEADING",
		Failure_editor_name = _("INS Heading Failure"),
		Element = AVIONICS_BAY_4,
		Integrity_Treshold = 0.89,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},
	
	{
		Failure = DEV_INS_FAIL_ATT,
		Failure_name = "INS_FAILURE_ATTITUDE",
		Failure_editor_name = _("INS Attitude Failure"),
		Element = AVIONICS_BAY_4,
		Integrity_Treshold = 0.84,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},
	
	{
		Failure = DEV_COM2_FAIL,
		Failure_name = "COM2_FAILURE_TOTAL",
		Failure_editor_name = _("Radio 2 Failure"),
		Element = AVIONICS_BAY_4,
		Integrity_Treshold = 0.90,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},
	
	--Avionics Bay 5
	
	--Avionics Bay 6
	{
		Failure = DEV_SMS_FAIL,
		Failure_name = "SMS_FAILURE_TOTAL",
		Failure_editor_name = _("SMS Controller Failure"),
		Element = AVIONICS_BAY_6,
		Integrity_Treshold = 0.90,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},
		
	--Nose Tip
	{
		Failure = DEV_DMT_FAIL,
		Failure_name = "DMT_FAILURE_TOTAL",
		Failure_editor_name = _("DMT Camera Failure"),
		Element = NOSE_AVIONICS,
		Integrity_Treshold = 0.85,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},
	
	{
		Failure = DEV_ARBS_FAIL,
		Failure_name = "ARBS_FAILURE_TOTAL",
		Failure_editor_name = _("ARBS Failure"),
		Element = DMT_BLACKBOX,
		Integrity_Treshold = 0.90,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},
	
	{
		Failure = DEV_FLIR_FAIL,
		Failure_name = "FLIR_FAILURE_TOTAL",
		Failure_editor_name = _("NAVFLIR Failure"),
		Element = FLIR_BLACKBOX,
		Integrity_Treshold = 0.90,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},
	
	-- Antennas
	{
		Failure = ANT_RADIO_TOP,
		Failure_name = "RADIO_1_ANTENNA",
		Failure_editor_name = _("Radio 1 Antenna Destroyed"),
		Element = RADIO_ANT_TOP,
		Integrity_Treshold = 0.50,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},
	
	{
		Failure = ANT_RADIO_BOTTM,
		Failure_name = "RADIO_2_ANTENNA",
		Failure_editor_name = _("Radio 2 Antenna Destroyed"),
		Element = RADIO_ANT_BOTTOM,
		Integrity_Treshold = 0.50,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},
	
	
	-- Weapons Stations
	{
		Failure = WPN_STA_1,
		Failure_name = "STATION_1_FAILURE",
		Failure_editor_name = _("Station 1 Failure"),
		Element = STATION_1,
		Integrity_Treshold = 0.95,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},
	
	{
		Failure = WPN_STA_2,
		Failure_name = "STATION_2_FAILURE",
		Failure_editor_name = _("Station 2 Failure"),
		Element = STATION_2,
		Integrity_Treshold = 0.95,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},
	
	{
		Failure = WPN_STA_3,
		Failure_name = "STATION_3_FAILURE",
		Failure_editor_name = _("Station 3 Failure"),
		Element = STATION_3,
		Integrity_Treshold = 0.95,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},
	
	{
		Failure = WPN_STA_4,
		Failure_name = "STATION_4_FAILURE",
		Failure_editor_name = _("Station 4 Failure"),
		Element = STATION_4,
		Integrity_Treshold = 0.95,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},
	
	{
		Failure = WPN_STA_5,
		Failure_name = "STATION_5_FAILURE",
		Failure_editor_name = _("Station 5 Failure"),
		Element = STATION_5,
		Integrity_Treshold = 0.95,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},
	
	{
		Failure = WPN_STA_6,
		Failure_name = "STATION_6_FAILURE",
		Failure_editor_name = _("Station 6 Failure"),
		Element = STATION_6,
		Integrity_Treshold = 0.95,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},
	
	{
		Failure = WPN_STA_7,
		Failure_name = "STATION_7_FAILURE",
		Failure_editor_name = _("Station 7 Failure"),
		Element = STATION_7,
		Integrity_Treshold = 0.95,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},
	
	{
		Failure = WPN_STRK_L,
		Failure_name = "STRAKE_LEFT_FAILURE",
		Failure_editor_name = _("Gun Pod Left Failure"),
		Element = STRAKE_LEFT,
		Integrity_Treshold = 0.95,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},
	
	{
		Failure = WPN_STRK_R,
		Failure_name = "STRAKE_RIGHT_FAILURE",
		Failure_editor_name = _("Gun Pod Right Failure"),
		Element = STRAKE_RIGHT,
		Integrity_Treshold = 0.95,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},
	
	{
		Failure = WPN_STA_1_DEST,
		Failure_name = "STATION_1_DESTRUCTION",
		Failure_editor_name = _("Station 1 Destruction"),
		Element = STATION_1,
		Integrity_Treshold = 0.04,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},
	
	{
		Failure = WPN_STA_2_DEST,
		Failure_name = "STATION_2_DESTRUCTION",
		Failure_editor_name = _("Station 2 Destruction"),
		Element = STATION_2,
		Integrity_Treshold = 0.04,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},
	
	{
		Failure = WPN_STA_3_DEST,
		Failure_name = "STATION_3_DESTRUCTION",
		Failure_editor_name = _("Station 3 Destruction"),
		Element = STATION_3_DEST,
		Integrity_Treshold = 0.04,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},
	
	{
		Failure = WPN_STA_4_DEST,
		Failure_name = "STATION_4_DESTRUCTION",
		Failure_editor_name = _("Station 4 Destruction"),
		Element = STATION_4,
		Integrity_Treshold = 0.04,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},
	
	{
		Failure = WPN_STA_5_DEST,
		Failure_name = "STATION_5_DESTRUCTION",
		Failure_editor_name = _("Station 5 Destruction"),
		Element = STATION_5,
		Integrity_Treshold = 0.04,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},
	
	{
		Failure = WPN_STA_6_DEST,
		Failure_name = "STATION_6_DESTRUCTION",
		Failure_editor_name = _("Station 6 Destruction"),
		Element = STATION_6,
		Integrity_Treshold = 0.04,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},
	
	{
		Failure = WPN_STA_7_DEST,
		Failure_name = "STATION_7_DESTRUCTION",
		Failure_editor_name = _("Station 7 Destruction"),
		Element = STATION_7,
		Integrity_Treshold = 0.04,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},
	
	{
		Failure = WPN_STRK_L_DEST,
		Failure_name = "STRAKE_LEFT_DESTRUCTION",
		Failure_editor_name = _("Gun Pod Left Destruction"),
		Element = STRAKE_LEFT,
		Integrity_Treshold = 0.04,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},
	
	{
		Failure = WPN_STRK_R_DEST,
		Failure_name = "STRAKE_RIGHT_DESTRUCTION",
		Failure_editor_name = _("Gun Pod Right Destruction"),
		Element = STRAKE_RIGHT,
		Integrity_Treshold = 0.04,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},
	
}

need_to_be_closed = true
