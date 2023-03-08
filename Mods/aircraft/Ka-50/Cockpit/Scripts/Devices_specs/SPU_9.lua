local gettext = require("i_18n")
_ = gettext.translate

GUI = {
	interphone = {
		interphone = true,
		displayName = _("Interphone")
	}
}

SPU_FAILURE = 0
Damage = {	{Failure = SPU_FAILURE, Failure_name = "SPU_FAILURE", Failure_editor_name = _("SPU failure"), Element = 3, Slope_param = 1}, 
			{Failure = SPU_FAILURE, Failure_name = "SPU_FAILURE", Failure_editor_name = _("SPU failure"), Element = 4, Slope_param = 2.5}, 
			{Failure = SPU_FAILURE, Failure_name = "SPU_FAILURE", Failure_editor_name = _("SPU failure"), Element = 5}}
