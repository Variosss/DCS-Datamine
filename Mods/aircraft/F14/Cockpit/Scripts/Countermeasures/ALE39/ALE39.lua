local gettext = require("i_18n")
_ = gettext.translate

CMS_FAILURE_PROGRAMMER = 0
CMS_FAILURE_LEFT_DISPENSER = 1
CMS_FAILURE_RIGHT_DISPENSER = 2


Damage = { {Failure = CMS_FAILURE_PROGRAMMER, Failure_name = "CMS_FAILURE_PROGRAMMER", Failure_editor_name = _("Countermeasures: Programmer"), Element = "AVX_WALL_RIGHT_REAR", Integrity_Treshold = 0.0, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*250},
   {Failure = CMS_FAILURE_LEFT_DISPENSER, Failure_name = "CMS_FAILURE_LEFT_DISPENSER", Failure_editor_name = _("Countermeasures: Left Dispenser"), Element = "COUNTERMEASURES", Integrity_Treshold = 0.75, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*50},
   {Failure = CMS_FAILURE_RIGHT_DISPENSER, Failure_name = "CMS_FAILURE_RIGHT_DISPENSER", Failure_editor_name = _("Countermeasures: Right Dispenser"), Element = "COUNTERMEASURES", Integrity_Treshold = 0.5, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*50},
}

need_to_be_closed = true -- close lua state after initialization 
