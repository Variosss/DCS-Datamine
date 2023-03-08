local gettext = require("i_18n")
_ = gettext.translate

TACAN_FAILURE_TOTAL = 0
TACAN_FAILURE_TRANSMITTER = 1
TACAN_FAILURE_RECEIVER = 2

Damage = { {Failure = TACAN_FAILURE_TOTAL, Failure_name = "TACAN_FAILURE_TOTAL", Failure_editor_name = _("TACAN: Total"), Element = "AVX_001", Integrity_Treshold = 0.0, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*250},
   {Failure = TACAN_FAILURE_TRANSMITTER, Failure_name ="TACAN_FAILURE_TRANSMITTER", Failure_editor_name = _("TACAN: Transmitter"), Element = "AVX_001", Integrity_Treshold = 0.8, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*250},
   {Failure = TACAN_FAILURE_RECEIVER, Failure_name = "TACAN_FAILURE_RECEIVER", Failure_editor_name = _("TACAN: Receiver"), Element = "AVX_001", Integrity_Treshold = 0.5, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*250},
}

need_to_be_closed = true