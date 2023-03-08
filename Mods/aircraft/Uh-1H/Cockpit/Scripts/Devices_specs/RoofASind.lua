local gettext = require("i_18n")
_ = gettext.translate

device_timer_dt		= 0.2

IAS_k1	= 3.0
IAS_k2  = 0.8

error_k	= 1.021

-- in m/s
MIN = 0.0
MAX = 77.167 -- 150 knots

IAS_pointer = {valmin = 0, valmax = 77.167, T1 = 0.267, T2 = 0.258, wmax = 0, bias = {{valmin = 0, valmax = 77.167, bias = 0.3}}}

ROOF_AIRSPEED_INDICATOR_FAILURE	= 0
Damage = {	
{Failure = ROOF_AIRSPEED_INDICATOR_FAILURE, Failure_name = "ROOF_AIRSPEED_INDICATOR_FAILURE", Failure_editor_name = _("Roof Airspeed Indicator failure"),  Element = 5, Integrity_Treshold = 0.2, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300}}

need_to_be_closed = true -- close lua state after initialization 