-- Radar Altimeter (A-036)
local gettext = require("i_18n")
_ = gettext.translate


device_pos = {-2.2, -0.68, 0.0}

max_alt = 850

raltPointer = {valmin = 0, valmax = max_alt, T1 = 0.75, T2 = 0.316, wmax = 0, bias = {{valmin = 0, valmax = max_alt, bias = 0.1}}}
warnFlag = {valmin = 0, valmax = 1, dvalue = 11}

distance_lim = 700.0
distance_lim_precise = 800.0

ElecConsumerParamsWarningLight = {0.5, true}

TOTAL_FAILURE	= 0

Damage = { {Failure = TOTAL_FAILURE, Failure_name = "RADAR_ALT_TOTAL_FAILURE", Failure_editor_name = _("Radar altimeter fail"),  Element = 58, Integrity_Treshold = 0.3, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300}}

--aircraft specific parameter
gauge_lookup_table = 
{
	value	= {0.0,	10,		20,		30,		40,		50,		60,		70,		80, 	90, 	100,	200,	300,	400,	500,	600,	700},
	arg		= {0.0,	0.0417,	0.0845,	0.127,	0.169,	0.212,	0.255,	0.298,	0.341,	0.381,	0.428,	0.497,	0.565,	0.634,	0.701,	0.769,	0.836}
}

warningFlag = {valmin = 0, valmax = 1, dvalue = 11}
warning_alt = 750

need_to_be_closed = true -- lua_state  will be closed in post_initialize()