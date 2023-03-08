local gettext = require("i_18n")
_ = gettext.translate

Damage = {
	{Failure = DEFA_TOTAL_DAMAGE,
	 Failure_name = "DEFA_TOTAL_DAMAGE",
	 Failure_editor_name = "DEFA set total failure",
	 Element = 7,
	 Integrity_Treshold = 0.3,
	 work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*3
	},
}

need_to_be_closed = true
