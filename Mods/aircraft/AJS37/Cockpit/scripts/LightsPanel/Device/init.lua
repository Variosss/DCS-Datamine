local gettext = require("i_18n")
_ = gettext.translate

Damage =
{
	{
		Failure = 2,
		Failure_name = "AC_BUS_FAILURE_TOTAL",
		Failure_editor_name = _(""),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},	
	
	{
		Failure = 3,
		Failure_name = "AC_BUS_PO7501_FAILURE",
		Failure_editor_name = _(""),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},	

	{
		Failure = 4,
		Failure_name = "AC_BUS_PO7502_FAILURE",
		Failure_editor_name = _(""),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},		
}
print "HEJ HEJ HEJ"
need_to_be_closed = true