local gettext = require("i_18n")
_ = gettext.translate

AHRS_FAILURE_TOTAL = 0
AHRS_FAILURE_GYRO = 1
AHRS_FAILURE_MAD = 2

Damage = { {Failure = AHRS_FAILURE_TOTAL, Failure_name = "AHRS_FAILURE_TOTAL", Failure_editor_name = _("AHRS: Total"), Element = "AVX_WALL_RIGHT_FRONT", Integrity_Treshold = 0.3, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*1000},
   {Failure = AHRS_FAILURE_GYRO, Failure_name ="AHRS_FAILURE_GYRO", Failure_editor_name = _("AHRS: Gyro Platform"), Element = "AVX_WALL_RIGHT_FRONT", Integrity_Treshold = 0.7, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*100},
   {Failure = AHRS_FAILURE_MAD, Failure_name = "AHRS_FAILURE_MAD", Failure_editor_name = _("AHRS: Magnetic Azimuth Detector"), Element = "FIN_L_TOP", Integrity_Treshold = 0.8, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*250},
}

need_to_be_closed = true