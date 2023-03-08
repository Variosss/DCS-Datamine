local gettext = require("i_18n")
_ = gettext.translate

device_timer_dt		= 0.01

HYD_PUMP_1_FAIL_025 = 1
HYD_PUMP_1_FAIL_050 = 2
HYD_PUMP_1_FAIL_075 = 3
HYD_PUMP_1_FAIL_100 = 4
HYD_PUMP_2_FAIL_025 = 5
HYD_PUMP_2_FAIL_050 = 6
HYD_PUMP_2_FAIL_075 = 7
HYD_PUMP_2_FAIL_100 = 8
HYD_PUMP_3_FAIL_100 = 9

OIL_SYSTEM_FAIL_050 = 10
OIL_SYSTEM_FAIL_075 = 11
OIL_SYSTEM_FAIL_100 = 12

Damage = {	
	-- Hydraulic System
	{Failure = HYD_PUMP_1_FAIL_025,  Failure_name = "HYD_PUMP_1_FAIL_025",  Failure_editor_name = _("Hydraulic Pump 1 Failure 25%"),     Element = 71, Integrity_Treshold = 0.95, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
	{Failure = HYD_PUMP_1_FAIL_050,  Failure_name = "HYD_PUMP_1_FAIL_050",  Failure_editor_name = _("Hydraulic Pump 1 Failure 50%"),     Element = 71, Integrity_Treshold = 0.90, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
	{Failure = HYD_PUMP_1_FAIL_075,  Failure_name = "HYD_PUMP_1_FAIL_075",  Failure_editor_name = _("Hydraulic Pump 1 Failure 75%"),     Element = 71, Integrity_Treshold = 0.85, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
	{Failure = HYD_PUMP_1_FAIL_100,  Failure_name = "HYD_PUMP_1_FAIL_100",  Failure_editor_name = _("Hydraulic Pump 1 Failure 100%"),    Element = 71, Integrity_Treshold = 0.80, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
	{Failure = HYD_PUMP_2_FAIL_025,  Failure_name = "HYD_PUMP_2_FAIL_025",  Failure_editor_name = _("Hydraulic Pump 2 Failure 25%"),     Element = 72, Integrity_Treshold = 0.95, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
	{Failure = HYD_PUMP_2_FAIL_050,  Failure_name = "HYD_PUMP_2_FAIL_050",  Failure_editor_name = _("Hydraulic Pump 2 Failure 50%"),     Element = 72, Integrity_Treshold = 0.90, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
	{Failure = HYD_PUMP_2_FAIL_075,  Failure_name = "HYD_PUMP_2_FAIL_075",  Failure_editor_name = _("Hydraulic Pump 2 Failure 75%"),     Element = 72, Integrity_Treshold = 0.85, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
	{Failure = HYD_PUMP_2_FAIL_100,  Failure_name = "HYD_PUMP_2_FAIL_100",  Failure_editor_name = _("Hydraulic Pump 2 Failure 100%"),    Element = 72, Integrity_Treshold = 0.80, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
	{Failure = HYD_PUMP_3_FAIL_100,  Failure_name = "HYD_PUMP_3_FAIL_100",  Failure_editor_name = _("Hydraulic Emergency Pump Failure"), Element = 82, Integrity_Treshold = 0.70, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
	
	-- Oil System
	{Failure = OIL_SYSTEM_FAIL_050,  Failure_name = "OIL_SYSTEM_FAIL_050",  Failure_editor_name = _("Engine Oil System Leak Slow"),   Element = 11, Integrity_Treshold = 0.70, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
	{Failure = OIL_SYSTEM_FAIL_075,  Failure_name = "OIL_SYSTEM_FAIL_075",  Failure_editor_name = _("Engine Oil System Leak Fast"),   Element = 11, Integrity_Treshold = 0.60, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
	{Failure = OIL_SYSTEM_FAIL_100,  Failure_name = "OIL_SYSTEM_FAIL_100",  Failure_editor_name = _("Engine Oil System Failure"),     Element = 11, Integrity_Treshold = 0.65, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
	-- Fuel Pumps
	-- TODO
	-- Fuel Leaks
	-- TODO
}

need_to_be_closed = true
