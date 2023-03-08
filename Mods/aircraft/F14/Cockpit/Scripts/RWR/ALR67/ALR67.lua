local gettext = require("i_18n")
_ = gettext.translate

RWR_FAILURE_TOTAL = 0
RWR_FAILURE_CONTROL_BOX = 1
RWR_FAILURE_COMPUTER = 2
RWR_FAILURE_LOW_BAND = 3
RWR_FAILURE_QUAD45 = 4
RWR_FAILURE_QUAD135 = 5
RWR_FAILURE_QUAD225 = 6
RWR_FAILURE_QUAD315 = 7
RWR_FAILURE_MBE = 8
RWR_FAILURE_BLANKER = 9
RWR_FAILURE_DISPLAY_PILOT = 10
RWR_FAILURE_DISPLAY_RIO = 11

Damage = { {Failure = RWR_FAILURE_TOTAL, Failure_name = "RWR_FAILURE_TOTAL", Failure_editor_name = _("RWR: Total"), Element = "AVX_WALL_LEFT_REAR", Integrity_Treshold = 0.0, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*1000},
   {Failure = RWR_FAILURE_CONTROL_BOX, Failure_name = "RWR_FAILURE_CONTROL_BOX", Failure_editor_name = _("RWR: Control Box"), Element = "AVX_WALL_LEFT_REAR", Integrity_Treshold = 0.3, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*250},
   {Failure = RWR_FAILURE_COMPUTER, Failure_name = "RWR_FAILURE_COMPUTER", Failure_editor_name = _("RWR: Computer"), Element = "AVX_WALL_LEFT_REAR", Integrity_Treshold = 0.7, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*250},
   {Failure = RWR_FAILURE_LOW_BAND, Failure_name = "RWR_FAILURE_LOW_BAND", Failure_editor_name = _("RWR: Low Band Receiver/Antenna"), Element = "TCS", Integrity_Treshold = 0.7, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*250},
   {Failure = RWR_FAILURE_QUAD45, Failure_name = "RWR_FAILURE_QUAD45", Failure_editor_name = _("RWR: 45 Quad Receiver/Antenna"), Element = "RWR_NACELLE_R", Integrity_Treshold = 0.7, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*250},
   {Failure = RWR_FAILURE_QUAD135, Failure_name = "RWR_FAILURE_QUAD135", Failure_editor_name = _("RWR: 135 Quad Receiver/Antenna"), Element = "RWR_TAIL_R", Integrity_Treshold = 0.7, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*250},
   {Failure = RWR_FAILURE_QUAD225, Failure_name = "RWR_FAILURE_QUAD225", Failure_editor_name = _("RWR: 225 Quad Receiver/Antenna"), Element = "RWR_TAIL_L", Integrity_Treshold = 0.7, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*250},
   {Failure = RWR_FAILURE_QUAD315, Failure_name = "RWR_FAILURE_QUAD315", Failure_editor_name = _("RWR: 315 Quad Receiver/Antenna"), Element = "RWR_NACELLE_L", Integrity_Treshold = 0.7, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*250},
   {Failure = RWR_FAILURE_MBE, Failure_name = "RWR_FAILURE_MBE", Failure_editor_name = _("RWR: MBE BUS"), Element = "AVX_WALL_LEFT_REAR", Integrity_Treshold = 0.5, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*250},
   {Failure = RWR_FAILURE_BLANKER, Failure_name = "RWR_FAILURE_BLANKER", Failure_editor_name = _("RWR: Interference Blanker"), Element = "AVX_WALL_LEFT_REAR", Integrity_Treshold = 0.7, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*250},
   {Failure = RWR_FAILURE_DISPLAY_PILOT, Failure_name = "RWR_FAILURE_DISPLAY_PILOT", Failure_editor_name = _("RWR: Display Pilot"), Element = "DASHBOARD_PILOT", Integrity_Treshold = 0.5, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*250},
   {Failure = RWR_FAILURE_DISPLAY_RIO, Failure_name = "RWR_FAILURE_DISPLAY_RIO", Failure_editor_name = _("RWR: Display RIO"), Element = "DASHBOARD_RIO", Integrity_Treshold = 0.5, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*250},
}

need_to_be_closed = true -- close lua state after initialization 
