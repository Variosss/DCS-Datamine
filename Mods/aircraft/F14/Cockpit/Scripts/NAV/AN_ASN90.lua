local gettext = require("i_18n")
_ = gettext.translate

IMU_FAILURE_TOTAL = 0
IMU_FAILURE_QUANTIZER = 1

Damage = { {Failure = IMU_FAILURE_TOTAL, Failure_name = "IMU_FAILURE_TOTAL", Failure_editor_name = _("IMU: Total"), Element = "AVX_WALL_LEFT_FRONT", Integrity_Treshold = 0.3, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*50},
   {Failure = IMU_FAILURE_QUANTIZER, Failure_name ="IMU_FAILURE_QUANTIZER", Failure_editor_name = _("IMU: Quantizer"), Element = "AVX_WALL_LEFT_FRONT", Integrity_Treshold = 0.7, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*50},
}

need_to_be_closed = true