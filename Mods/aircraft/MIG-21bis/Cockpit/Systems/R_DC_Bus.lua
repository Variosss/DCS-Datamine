local gettext = require("i_18n")
_ = gettext.translate

Damage =
{
	{
		Failure = 0, -- /N/ failure nbr 0-100
		Failure_name = "DC_BUS_FAILURE_TOTAL", -- /N/ variable name, used in C++ code
		Failure_editor_name = _(""), -- /N/ failure name in GUI
		Element = 0, -- /N/ 3D element, if damaged will cause the failure (100% damage has Argument value = 1). Damage element numbers are in MiG-21.lua as commented parameter. (We use names, not of element nbr.) Element numbers and damage level defaults by Eagle in \Scripts\Aircrafts\_Common\damage.lua; these values appear too low in tests.
		Integrity_Treshold = 0.0,  --/N/ vague. Assumed: equipment integrity in relation to 3D part damage. If >  0, 3D part can be 100% damaged, while equipment still might work.
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5, --/N/ if not customized in editor...
		work_time_to_fail = 3600*300 --/N/ if not customized in editor...
	},	

	{
		Failure = 1,
		Failure_name = "DC_BUS_GENERATOR_FAILURE",
		Failure_editor_name = _(""),
		Element = 0,
		Integrity_Treshold = 0.0,
		Slope_param = 10.0,
		work_time_to_fail_probability = 0.5,
		work_time_to_fail = 3600*300
	},	
}

need_to_be_closed = true