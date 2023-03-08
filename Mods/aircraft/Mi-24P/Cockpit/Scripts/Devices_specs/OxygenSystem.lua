--local gettext = require("i_18n")
--_ = gettext.translate

BreathCyclesPerMinuteFwd = 20.0
BreathCyclesPerMinuteAft = 20.0
BreathingOutLongerInPercentFromBreathingInFwd = 40.0
BreathingOutLongerInPercentFromBreathingInAft = 40.0

OxygenVolume = {valmin = 0.0, valmax = 10.0, T1 = 0.225, T2 = 0.112, bias = {{valmin = 0.0, valmax = 10.0, bias = 0.1}}}
Blinker = {valmin = 0.0, valmax = 1.0, dvalue = 5.0}

O2_Starvation_limit_Fwd = 11000.0
StarvDeathTime_Fwd = 300.0
O2_Starvation_limit_Aft = 11000.0
StarvDeathTime_Aft = 300.0

OXYGEN_FAILURE_TOTAL	= 0
--[[
Damage = {
	{Failure = OXYGEN_FAILURE_TOTAL, Failure_name = "oxy_FAILURE_TOTAL", Failure_editor_name = _("Oxygen System: Total Failure"),  Element = 4, Integrity_Treshold = 0.4, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300}
}
]]--
device_timer_dt = 0.02
need_to_be_closed = true -- close lua state after initialization
