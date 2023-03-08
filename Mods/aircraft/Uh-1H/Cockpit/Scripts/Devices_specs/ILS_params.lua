dofile(LockOn_Options.common_script_path..'Radio.lua')

local gettext = require("i_18n")
_ = gettext.translate


innerNoise = getInnerNoise(3.0E-6, 10.0)
localizerMinSignal = 40E-6 --190E-6 --V/m
glideslopeMinSignal = 1.5E-3 --V/m
markerMinSignal = 1.1E-3; --V/m

ILS_FAILURE_TOTAL			= 0
ILS_FAILURE_ANT_LOCALIZER	= 1
ILS_FAILURE_ANT_GLIDESLOPE	= 2
ILS_FAILURE_ANT_MARKER		= 3
	
Damage = {	{Failure = ILS_FAILURE_TOTAL, Failure_name = "ILS_FAILURE_TOTAL", Failure_editor_name = _("ILS: total failure"),  Element = 2, Integrity_Treshold = 0.25, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
		{Failure = ILS_FAILURE_ANT_LOCALIZER, Failure_name = "ILS_FAILURE_ANT_LOCALIZER", Failure_editor_name = _("ILS: localizer channel failure"),  Element = 1, Integrity_Treshold = 0.1, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
		{Failure = ILS_FAILURE_ANT_GLIDESLOPE, Failure_name = "ILS_FAILURE_ANT_GLIDESLOPE", Failure_editor_name = _("ILS: glideslope channel failure"),  Element = 1, Integrity_Treshold = 0.2, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
		{Failure = ILS_FAILURE_ANT_MARKER, Failure_name = "ILS_FAILURE_ANT_MARKER", Failure_editor_name = _("ILS: marker antenna failure"),  Element = 0, Integrity_Treshold = 0.75, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300}}

need_to_be_closed = true -- lua_state  will be closed in post_initialize()