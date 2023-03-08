local gettext = require("i_18n")
_ = gettext.translate

-- meters
primerMotorSndPos = {x = 0.5, y = -0.5, z = 0}

SUPERCHARGER_LIGHT			= 0
SUPERCHARGER_WIRE			= 1
SUPERCHARGER_SOLENOID		= 2
OIL_DILUTION_SOLENOID 		= 3
OIL_DILUTION_WIRE			= 4
BOOSTER_COIL				= 5

Damage = {	
	{Failure = SUPERCHARGER_LIGHT, Failure_name = "SUPERCHARGER_LIGHT", Failure_editor_name = _("Supercharger light burned out"),  Element = 3, Integrity_Treshold = 0.05, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
	{Failure = SUPERCHARGER_WIRE, Failure_name = "SUPERCHARGER_WIRE", Failure_editor_name = _("Supercharger wiring fault"),  Element = 3, Integrity_Treshold = 0.05, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
	{Failure = SUPERCHARGER_SOLENOID, Failure_name = "SUPERCHARGER_SOLENOID", Failure_editor_name = _("Supercharger solenoid fault"),  Element = 11, Integrity_Treshold = 0.1, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
	{Failure = OIL_DILUTION_SOLENOID, Failure_name = "OIL_DILUTION_SOLENOID", Failure_editor_name = _("Oil dilution solenoid fault"),  Element = 11, Integrity_Treshold = 0.1, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
	{Failure = OIL_DILUTION_WIRE, Failure_name = "OIL_DILUTION_WIRE", Failure_editor_name = _("Oil dilution wiring fault"),  Element = 3, Integrity_Treshold = 0.05, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
	{Failure = BOOSTER_COIL, Failure_name = "BOOSTER_COIL", Failure_editor_name = _("Booster coil fault"),  Element = -1, Integrity_Treshold = 0, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},

}

ElecConsumerParamsBlowerLamp = {0.5, true}

need_to_be_closed = true -- close lua state after initialization 
