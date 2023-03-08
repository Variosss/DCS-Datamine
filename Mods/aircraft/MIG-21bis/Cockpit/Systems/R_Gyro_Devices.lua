local gettext = require("i_18n")
_ = gettext.translate

Damage =
{
	{
		Failure = 6,--/N/ was 2, which belong to AC bus
		Failure_name = "GYROS_FAILURE_TOTAL",
		Failure_editor_name = _(""),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},	
}

need_to_be_closed = true