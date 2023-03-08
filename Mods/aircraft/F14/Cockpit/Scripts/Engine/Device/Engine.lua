local gettext = require("i_18n")
_ = gettext.translate


L_ENG_FIRE = 0
R_ENG_FIRE = 1
L_ENG_SEIZED = 2
R_ENG_SEIZED = 3
L_ENG_TURBINE_FAILURE = 4
R_ENG_TURBINE_FAILURE = 5
L_ENG_OIL_LEAK_SLOW = 6
R_ENG_OIL_LEAK_SLOW = 7
L_ENG_OIL_LEAK_MODERATE = 8
R_ENG_OIL_LEAK_MODERATE = 9
L_ENG_OIL_LEAK_SEVERE = 10
R_ENG_OIL_LEAK_SEVERE = 11
L_ENG_COMPRESSOR_STALL = 12
R_ENG_COMPRESSOR_STALL = 13
L_ENG_POP_STALL = 14
R_ENG_POP_STALL = 15
L_ENG_SUPERSONIC_INLET_BUZZ = 16
R_ENG_SUPERSONIC_INLET_BUZZ = 17
L_ENG_HPT_OVERSPEED = 18
R_ENG_HPT_OVERSPEED = 19
L_ENG_AFTC_PRI_FAILED = 20
R_ENG_AFTC_PRI_FAILED = 21
L_ENG_AICS_RAMP_FAIL_OPEN = 22
R_ENG_AICS_RAMP_FAIL_OPEN = 23
L_ENG_AICS_RAMP_FAIL_CLOSED = 24
R_ENG_AICS_RAMP_FAIL_CLOSED = 25
L_ENG_AICS_RAMP_FAIL_IN_POS = 26
R_ENG_AICS_RAMP_FAIL_IN_POS = 27
L_ENG_EXHAUST_NOZZLE_FAILURE = 28
R_ENG_EXHAUST_NOZZLE_FAILURE = 29

Damage = {
{Failure = L_ENG_FIRE, Failure_name = "L_ENG_FIRE", Failure_editor_name = _("Left Engine: Fire"), Element = "AVX_003", Integrity_Treshold = 0.0, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*5000},
{Failure = R_ENG_FIRE, Failure_name = "R_ENG_FIRE", Failure_editor_name = _("Right Engine: Fire"), Element = "AVX_003", Integrity_Treshold = 0.0, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*5000},
{Failure = L_ENG_SEIZED, Failure_name = "L_ENG_SEIZED", Failure_editor_name = _("Left Engine: Main Spool Seizure"), Element = "AVX_003", Integrity_Treshold = 0.5, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*5000},
{Failure = R_ENG_SEIZED, Failure_name = "R_ENG_SEIZED", Failure_editor_name = _("Right Engine: Main Spool Seizure"), Element = "AVX_003", Integrity_Treshold = 0.5, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*5000},
{Failure = L_ENG_TURBINE_FAILURE, Failure_name = "L_ENG_TURBINE_FAILURE", Failure_editor_name = _("Left Engine: Turbine Failed"), Element = "AVX_003", Integrity_Treshold = 0.5, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*5000},
{Failure = R_ENG_TURBINE_FAILURE, Failure_name = "R_ENG_TURBINE_FAILURE", Failure_editor_name = _("Right Engine: Turbine Failed"), Element = "AVX_003", Integrity_Treshold = 0.5, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*5000},
{Failure = L_ENG_OIL_LEAK_SLOW, Failure_name = "L_ENG_OIL_LEAK_SLOW", Failure_editor_name = _("Left Engine: Slow Oil Leak (1 hr)"), Element = "AVX_003", Integrity_Treshold = 0.5, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*5000},
{Failure = R_ENG_OIL_LEAK_SLOW, Failure_name = "R_ENG_OIL_LEAK_SLOW", Failure_editor_name = _("Right Engine: Slow Oil Leak (1 hr)"), Element = "AVX_003", Integrity_Treshold = 0.5, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*5000},
{Failure = L_ENG_OIL_LEAK_MODERATE, Failure_name = "L_ENG_OIL_LEAK_MODERATE", Failure_editor_name = _("Left Engine: Moderate Oil Leak (30 min)"), Element = "AVX_003", Integrity_Treshold = 0.5, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*5000},
{Failure = R_ENG_OIL_LEAK_MODERATE, Failure_name = "R_ENG_OIL_LEAK_MODERATE", Failure_editor_name = _("Right Engine: Moderate Oil Leak (30 min)"), Element = "AVX_003", Integrity_Treshold = 0.5, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*5000},
{Failure = L_ENG_OIL_LEAK_SEVERE, Failure_name = "L_ENG_OIL_LEAK_SEVERE", Failure_editor_name = _("Left Engine: Severe Oil Leak (2 min)"), Element = "AVX_003", Integrity_Treshold = 0.5, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*5000},
{Failure = R_ENG_OIL_LEAK_SEVERE, Failure_name = "R_ENG_OIL_LEAK_SEVERE", Failure_editor_name = _("Right Engine: Severe Oil Leak (2 min)"), Element = "AVX_003", Integrity_Treshold = 0.5, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*5000},
{Failure = L_ENG_COMPRESSOR_STALL, Failure_name = "L_ENG_COMPRESSOR_STALL", Failure_editor_name = _("Left Engine: Compressor Stall"), Element = "AVX_003", Integrity_Treshold = 0.5, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*5000},
{Failure = R_ENG_COMPRESSOR_STALL, Failure_name = "R_ENG_COMPRESSOR_STALL", Failure_editor_name = _("Right Engine: Compressor Stall"), Element = "AVX_003", Integrity_Treshold = 0.5, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*5000},
{Failure = L_ENG_POP_STALL, Failure_name = "L_ENG_POP_STALL", Failure_editor_name = _("Left Engine: Pop Stall"), Element = "AVX_003", Integrity_Treshold = 0.5, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*1000},
{Failure = R_ENG_POP_STALL, Failure_name = "R_ENG_POP_STALL", Failure_editor_name = _("Right Engine: Pop Stall"), Element = "AVX_003", Integrity_Treshold = 0.5, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*1000},
--{Failure = L_ENG_SUPERSONIC_INLET_BUZZ, Failure_name = "L_ENG_SUPERSONIC_INLET_BUZZ", Failure_editor_name = _("Left Engine: Supersonic Inlet Buzz"), Element = "AVX_003", Integrity_Treshold = 0.5, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*5000},
--{Failure = R_ENG_SUPERSONIC_INLET_BUZZ, Failure_name = "R_ENG_SUPERSONIC_INLET_BUZZ", Failure_editor_name = _("Right Engine: Supersonic Inlet Buzz"), Element = "AVX_003", Integrity_Treshold = 0.5, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*5000},
{Failure = L_ENG_HPT_OVERSPEED, Failure_name = "L_ENG_HPT_OVERSPEED", Failure_editor_name = _("Left Engine: Turbine Overspeed"), Element = "AVX_003", Integrity_Treshold = 0.5, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*5000},
{Failure = R_ENG_HPT_OVERSPEED, Failure_name = "R_ENG_HPT_OVERSPEED", Failure_editor_name = _("Right Engine: Turbine Overspeed"), Element = "AVX_003", Integrity_Treshold = 0.5, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*5000},
{Failure = L_ENG_AFTC_PRI_FAILED, Failure_name = "L_ENG_AFTC_PRI_FAILED", Failure_editor_name = _("Left Engine: AFTC Failure"), Element = "AVX_003", Integrity_Treshold = 0.5, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*3000},
{Failure = R_ENG_AFTC_PRI_FAILED, Failure_name = "R_ENG_AFTC_PRI_FAILED", Failure_editor_name = _("Right Engine: AFTC Failure"), Element = "AVX_003", Integrity_Treshold = 0.5, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*3000},
{Failure = L_ENG_AICS_RAMP_FAIL_OPEN, Failure_name = "L_ENG_AICS_RAMP_FAIL_OPEN", Failure_editor_name = _("Left Engine: AICS Ramp Fail Open"), Element = "AVX_003", Integrity_Treshold = 1.0, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*5000},
{Failure = R_ENG_AICS_RAMP_FAIL_OPEN, Failure_name = "R_ENG_AICS_RAMP_FAIL_OPEN", Failure_editor_name = _("Right Engine: AICS Ramp Fail Open"), Element = "AVX_003", Integrity_Treshold = 1.0, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*5000},
{Failure = L_ENG_AICS_RAMP_FAIL_CLOSED, Failure_name = "L_ENG_AICS_RAMP_FAIL_CLOSED", Failure_editor_name = _("Left Engine: AICS Ramp Fail Closed"), Element = "AVX_003", Integrity_Treshold = 1.0, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*5000},
{Failure = R_ENG_AICS_RAMP_FAIL_CLOSED, Failure_name = "R_ENG_AICS_RAMP_FAIL_CLOSED", Failure_editor_name = _("Right Engine: AICS Ramp Fail Closed"), Element = "AVX_003", Integrity_Treshold = 1.0, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*5000},
{Failure = L_ENG_AICS_RAMP_FAIL_IN_POS, Failure_name = "L_ENG_AICS_RAMP_FAIL_IN_POS", Failure_editor_name = _("Left Engine: AICS Ramp Fail In Position"), Element = "AVX_003", Integrity_Treshold = 1.0, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*3000},
{Failure = R_ENG_AICS_RAMP_FAIL_IN_POS, Failure_name = "R_ENG_AICS_RAMP_FAIL_IN_POS", Failure_editor_name = _("Right Engine: AICS Ramp Fail In Position"), Element = "AVX_003", Integrity_Treshold = 1.0, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*3000},
{Failure = L_ENG_EXHAUST_NOZZLE_FAILURE, Failure_name = "L_ENG_EXHAUST_NOZZLE_FAILURE", Failure_editor_name = _("Left Engine: Exhaust Nozzle Failure"), Element = "AVX_003", Integrity_Treshold = 1.0, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*4000},
{Failure = R_ENG_EXHAUST_NOZZLE_FAILURE, Failure_name = "R_ENG_EXHAUST_NOZZLE_FAILURE", Failure_editor_name = _("Right Engine: Exhaust Nozzle Failure"), Element = "AVX_003", Integrity_Treshold = 1.0, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*4000},
}

need_to_be_closed = true -- close lua state after initialization 
