local gettext = require("i_18n")
_ = gettext.translate


CADC_FAILURE_TOTAL = 0
CADC_PRESSURE_SENSOR_PROCESSOR = 1
CADC_WING_SWEEP_COMMAND_CHANNEL_1 = 2
CADC_WING_SWEEP_COMMAND_CHANNEL_2 = 3
CADC_MANEUVER_FLAP_COMMAND = 4
CADC_RUDDER_AUTHORITY_COMMAND = 5
CADC_STABILIZER_AUTHORITY_COMMAND = 6
CADC_ANGLE_OF_ATTACK_SIGNAL = 7
CADC_TOTAL_TEMPERATURE_SIGNAL = 8
CADC_WING_SWEEP_INDICATOR = 9
CADC_CSDC_CONNECTION = 10
CADC_TRANSIENT = 11

Damage = { 
{Failure = CADC_FAILURE_TOTAL, Failure_name = "CADC_FAILURE_TOTAL", Failure_editor_name = _("CADC: Total"), Element = "AVX_003", Integrity_Treshold = 0.0, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*1000},
{Failure = CADC_PRESSURE_SENSOR, Failure_name = "CADC_PRESSURE_SENSOR", Failure_editor_name = _("CADC: Pressure sensor"), Element = "AVX_003", Integrity_Treshold = 0.5, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*250},
{Failure = CADC_WING_SWEEP_COMMAND_CHANNEL_1, Failure_name = "CADC_WING_SWEEP_COMMAND_CHANNEL_1", Failure_editor_name = _("CADC: Wing Sweep Channel 1"), Element = "AVX_003", Integrity_Treshold = 0.5, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*250},
{Failure = CADC_WING_SWEEP_COMMAND_CHANNEL_2, Failure_name = "CADC_WING_SWEEP_COMMAND_CHANNEL_2", Failure_editor_name = _("CADC: Wing Sweep Channel 2"), Element = "AVX_003", Integrity_Treshold = 0.5, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*250},
{Failure = CADC_MANEUVER_FLAP_COMMAND, Failure_name = "CADC_MANEUVER_FLAP_COMMAND", Failure_editor_name = _("CADC: Maneuver Flap Command"), Element = "AVX_003", Integrity_Treshold = 0.5, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*250},
{Failure = CADC_RUDDER_AUTHORITY_COMMAND, Failure_name = "CADC_RUDDER_AUTHORITY_COMMAND", Failure_editor_name = _("CADC: Rudder Authority Command"), Element = "AVX_003", Integrity_Treshold = 0.5, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*250},
{Failure = CADC_STABILIZER_AUTHORITY_COMMAND, Failure_name = "CADC_STABILIZER_AUTHORITY_COMMAND", Failure_editor_name = _("CADC: Stabilizer Authority Command"), Element = "AVX_003", Integrity_Treshold = 0.5, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*250},
{Failure = CADC_ANGLE_OF_ATTACK_SIGNAL, Failure_name = "CADC_ANGLE_OF_ATTACK_SIGNAL", Failure_editor_name = _("CADC: Angle Of Attack Signal"), Element = "AVX_003", Integrity_Treshold = 0.5, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*250},
{Failure = CADC_TOTAL_TEMPERATURE_SIGNAL, Failure_name = "CADC_TOTAL_TEMPERATURE_SIGNAL", Failure_editor_name = _("CADC: Temperature Signal"), Element = "AVX_003", Integrity_Treshold = 0.5, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*250},
{Failure = CADC_WING_SWEEP_INDICATOR, Failure_name = "CADC_WING_SWEEP_INDICATOR", Failure_editor_name = _("CADC: Wing Sweep Indicator"), Element = "AVX_003", Integrity_Treshold = 0.5, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*250},
{Failure = CADC_CSDC_CONNECTION, Failure_name = "CADC_CSDC_CONNECTION", Failure_editor_name = _("CADC: Digital output to CSDC"), Element = "AVX_003", Integrity_Treshold = 0.5, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*250},
{Failure = CADC_TRANSIENT, Failure_name = "CADC_TRANSIENT", Failure_editor_name = _("CADC: Transient Failure"), Element = "AVX_003", Integrity_Treshold = 1.0, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*20}
   
}

need_to_be_closed = true -- close lua state after initialization 
