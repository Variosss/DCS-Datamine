local gettext = require("i_18n")
_ = gettext.translate

device_timer_dt		= 0.04

Barometric_k1 = 3.0

Barometric_k2 = 0.8

-- replace silence horn button from ELEC_INTERFACE to SYS_CONTROLLER and handling according name
-- remove blink for lamp in systemController 

CADC_FAILURE_TEMPERATURE	= 0
CADC_FAILURE_MACH			= 1
CADC_FAILURE_TAS			= 2
CADC_FAILURE_IAS			= 3
CADC_FAILURE_BARO_ALT		= 4
CADC_FAILURE_PRESSURE_ALT	= 5
CADC_FAILURE_DYNAMIC		= 6
CADC_FAILURE_STATIC			= 7
CADC_FAILURE_TOTAL			= 8
Damage = {	{Failure = CADC_FAILURE_TEMPERATURE, Failure_name = "CADC_FAILURE_TEMPERATURE", Failure_editor_name = _("CADC temperature sensor"),  Element = 1000, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
		{Failure = CADC_FAILURE_MACH, Failure_name = "CADC_FAILURE_MACH", Failure_editor_name = _("CADC Mach sensor"),  Element = 1000, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
		{Failure = CADC_FAILURE_TAS, Failure_name = "CADC_FAILURE_TAS", Failure_editor_name = _("CADC TAS sensor"),  Element = 1000, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
		{Failure = CADC_FAILURE_IAS, Failure_name = "CADC_FAILURE_IAS", Failure_editor_name = _("CADC IAS sensor"),  Element = 1000, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
		{Failure = CADC_FAILURE_BARO_ALT, Failure_name = "CADC_FAILURE_BARO_ALT", Failure_editor_name = _("CADC baro altitude sensor"),  Element = 1000, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
		{Failure = CADC_FAILURE_PRESSURE_ALT, Failure_name = "CADC_FAILURE_PRESSURE_ALT", Failure_editor_name = _("CADC pressure altitude sensor"),  Element = 1000, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
		{Failure = CADC_FAILURE_DYNAMIC, Failure_name = "CADC_FAILURE_DYNAMIC", Failure_editor_name = _("CADC dynamic pressure sensor"),  Element = 1000, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
		{Failure = CADC_FAILURE_STATIC, Failure_name = "CADC_FAILURE_STATIC", Failure_editor_name = _("CADC static pressure sensor"),  Element = 1000, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
		{Failure = CADC_FAILURE_TOTAL, Failure_name = "CADC_FAILURE_TOTAL", Failure_editor_name = _("CADC total failure"),  Element = 10, Integrity_Treshold = 0.0, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300}}
 
need_to_be_closed = true -- close lua state after initialization 