local gettext = require("i_18n")
_ = gettext.translate

device_timer_dt = 0.015
momentCoeff = 0.0003

--T1 = 0.033, T2 = 0.075
manifoldPressureGauge      = {valmin = 10, valmax = 75, T1 = 0.033, T2 = 0.07, wmax = 0,
	bias = {{valmin = 10, valmax = 75, bias = 0.1}},
	angles = {{val = 10, angle = math.rad(106)}, {val = 75, angle = math.rad(-238.5)}},
	momentCoeff = momentCoeff}
	
RPM_Gauge                  = {valmin = 0, valmax = 4500, T1 = 0.033, T2 = 0.07, wmax = 0,
	bias = {{valmin = 0, valmax = 4500, bias = 0.1}},
	angles = {{val = 0, angle = math.rad(150)}, {val = 4500, angle = math.rad(-150)}},
	momentCoeff = momentCoeff}

SuctionGauge               = {valmin = 0, valmax = 10, T1 = 0.15, T2 = 0.12, wmax = 0,
	bias = {{valmin = 0, valmax = 10, bias = 0.01}},
	angles = {{val = 0, angle = math.rad(165)}, {val = 10, angle = math.rad(-165)}},
	momentCoeff = momentCoeff}

AirCoolantTemperatureGauge = {valmin = -80, valmax = 150, T1 = 0.225, T2 = 0.112, wmax = 0,
	bias = {{valmin = -80, valmax = 150, bias = 0.5}},
	angles = {{val = -80, angle = math.rad(80)}, {val = 150, angle = math.rad(-73.95)}},
	momentCoeff = momentCoeff}

CarbAirTemperatureGauge    = AirCoolantTemperatureGauge
CoolantTemperatureGauge    = AirCoolantTemperatureGauge

OilTemperatureGauge        = {valmin = 0, valmax = 100, T1 = 0.17, T2 = 0.14, wmax = 0,
	bias = {{valmin = 0, valmax = 100, bias = 0.5}},
	angles = {{val = 0, angle = math.rad(90)}, {val = 100, angle = math.rad(-90)}},
	momentCoeff = momentCoeff}

OilPressureGauge           = {valmin = 0, valmax = 200, T1 = 0.08, T2 = 0.09, wmax = 0,
	bias = {{valmin = 0, valmax = 200, bias = 0.5}},
	angles = {{val = 0, angle = math.rad(180)}, {val = 200, angle = 0}},
	momentCoeff = momentCoeff}

ElecConsumerParamsTemperatureGauge = {3, true, 3, 5}

PUMP_SEPARATOR_CLOGGED			 = 0
PUMP_RELIEF_VALVE_SCREEN_CLOGGED = 1
PUMP_RELIEF_VALVE_LEAKS			 = 2
PUMP_FAILS						 = 3
MANIFOLD_SHIFT					 = 4	
MANIFOLD_LINE_LEAK				 = 5
COOLANT_RADIATOR_WIRING			 = 6
COOLANT_RADIATOR_MOTOR			 = 7
OIL_RADIATOR_WIRING				 = 8
OIL_RADIATOR_MOTOR			 	 = 9
TACH_BREAK_CIRCUIT				 = 10
TACH_BREAK_IN_INDICATOR			 = 11
TACH_POOR_CONNECTION			 = 12
TACH_RESISTANCE_ADJ				 = 13

COOLANT_BREAK_BULB				 = 14
COOLANT_BROKEN_WIRES			 = 15
COOLANT_DEFECTIVE_IND			 = 16
COOLANT_POOR_CONNTECT			 = 17
COOLANT_SHORT_CIRCUIT			 = 18

CARBAIR_BREAK_POWER				= 19
CARBAIR_BREAK_GROUND			= 20
CARBAIR_SHORT_CIRCUIT			= 21
CARBAIR_SHORT_CIRCUIT_LEADS		= 22
CARBAIR_GND_LEAD				= 23
CARBAIR_SHORT_CIRCUIT_BLB		= 24

CARBAIR_BREAK_LEADS				= 25
CARBAIR_OPEN_CIRCUIT_BLB		= 26

IGNITION_NO_OUTPUT 				= 27
IGNITION_TERM_CONNECT 			= 28

STARTER_WIRING					= 29
STARTER_RELAY					= 30
STARTER_SOLENOID				= 31

Damage = {	
	{Failure = PUMP_SEPARATOR_CLOGGED, Failure_name = "PUMP_SEPARATOR_CLOGGED", Failure_editor_name = _("Vacuum pump. Separator clogged"),  Element = -1, Integrity_Treshold = 0.1, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
	{Failure = PUMP_RELIEF_VALVE_SCREEN_CLOGGED, Failure_name = "PUMP_RELIEF_VALVE_SCREEN_CLOGGED", Failure_editor_name = _("Vacuum pump. Relief valve screen clogged"),  Element = -1, Integrity_Treshold = 0.1, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
	{Failure = PUMP_RELIEF_VALVE_LEAKS, Failure_name = "PUMP_RELIEF_VALVE_LEAKS", Failure_editor_name = _("Vacuum pump. Suction relief valve leaks"),  Element = -1, Integrity_Treshold = 0.1, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
	{Failure = PUMP_FAILS, Failure_name = "PUMP_FAILS", Failure_editor_name = _("Vacuum pump fails"),  Element = 1, Integrity_Treshold = 0.2, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
	{Failure = MANIFOLD_SHIFT, Failure_name = "MANIFOLD_SHIFT", Failure_editor_name = _("Manifold ind. pointer shifted"),  Element = -1, Integrity_Treshold = 0.1, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
	{Failure = MANIFOLD_LINE_LEAK, Failure_name = "MANIFOLD_LINE_LEAK", Failure_editor_name = _("Manifold ind. line leak"),  Element = 3, Integrity_Treshold = 0.1, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
	
	{Failure = COOLANT_RADIATOR_WIRING, Failure_name = "COOLANT_RADIATOR_WIRING", Failure_editor_name = _("No volt. at coolant radiator flap"),  Element = 9, Integrity_Treshold = 0.05, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
	{Failure = COOLANT_RADIATOR_MOTOR, Failure_name = "COOLANT_RADIATOR_MOTOR", Failure_editor_name = _("Coolant radiator flap motor fault"),  Element = 82, Integrity_Treshold = 0.1, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},

	{Failure = OIL_RADIATOR_WIRING, Failure_name = "OIL_RADIATOR_WIRING", Failure_editor_name = _("No volt. at oil radiator flap"),  Element = 9, Integrity_Treshold = 0.05, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
	{Failure = OIL_RADIATOR_MOTOR, Failure_name = "OIL_RADIATOR_MOTOR", Failure_editor_name = _("Oil radiator flap motor fault"),  Element = 82, Integrity_Treshold = 0.1, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},

	{Failure = TACH_BREAK_CIRCUIT, Failure_name = "TACH_BREAK_CIRCUIT", Failure_editor_name = _("Tachometer circuit break"),  Element = 3, Integrity_Treshold = 0.1, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
	{Failure = TACH_BREAK_IN_INDICATOR, Failure_name = "TACH_BREAK_IN_INDICATOR", Failure_editor_name = _("Tachometer indicator break"),  Element = 3, Integrity_Treshold = 0.1, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
	{Failure = TACH_POOR_CONNECTION, Failure_name = "TACH_POOR_CONNECTION", Failure_editor_name = _("Tachometer poor connection"),  Element = 3, Integrity_Treshold = 0.05, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
	{Failure = TACH_RESISTANCE_ADJ, Failure_name = "TACH_RESISTANCE_ADJ", Failure_editor_name = _("Tachometer indicator adjustment fault"),  Element = -1, Integrity_Treshold = 0.1, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},

	{Failure = COOLANT_BREAK_BULB, Failure_name = "COOLANT_BREAK_BULB", Failure_editor_name = _("Coolant ind. bulb fault"),  Element = -1, Integrity_Treshold = 0.1, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
	{Failure = COOLANT_BROKEN_WIRES, Failure_name = "COOLANT_BROKEN_WIRES", Failure_editor_name = _("Coolant ind. wires broken"),  Element = 3, Integrity_Treshold = 0.1, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
	{Failure = COOLANT_DEFECTIVE_IND, Failure_name = "COOLANT_DEFECTIVE_IND", Failure_editor_name = _("Coolant ind. defective"),  Element = -1, Integrity_Treshold = 0.1, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
	{Failure = COOLANT_POOR_CONNTECT, Failure_name = "COOLANT_POOR_CONNTECT", Failure_editor_name = _("Coolant ind. poor connection"),  Element = -1, Integrity_Treshold = 0.1, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
	{Failure = COOLANT_SHORT_CIRCUIT, Failure_name = "COOLANT_SHORT_CIRCUIT", Failure_editor_name = _("Coolant ind. short circuit"),  Element = -1, Integrity_Treshold = 0.1, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},

	{Failure = CARBAIR_BREAK_POWER, Failure_name = "CARBAIR_BREAK_POWER", Failure_editor_name = _("Carb. air ind. pwr lead fault"),  Element = 3, Integrity_Treshold = 0.1, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
	{Failure = CARBAIR_BREAK_GROUND, Failure_name = "CARBAIR_BREAK_GROUND", Failure_editor_name = _("Carb. air ind. gnd lead fault"),  Element = 3, Integrity_Treshold = 0.1, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
	{Failure = CARBAIR_SHORT_CIRCUIT, Failure_name = "CARBAIR_SHORT_CIRCUIT", Failure_editor_name = _("Carb. air ind. open or short circuit"),  Element = -1, Integrity_Treshold = 0.1, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},

	{Failure = CARBAIR_SHORT_CIRCUIT_LEADS, Failure_name = "CARBAIR_SHORT_CIRCUIT_LEADS", Failure_editor_name = _("Carb. air ind. short circuit in leads"),  Element = -1, Integrity_Treshold = 0.1, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
	{Failure = CARBAIR_GND_LEAD, Failure_name = "CARBAIR_GND_LEAD", Failure_editor_name = _("Carb. air ind. gnd in leads"),  Element = -1, Integrity_Treshold = 0.1, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
	{Failure = CARBAIR_SHORT_CIRCUIT_BLB, Failure_name = "CARBAIR_SHORT_CIRCUIT_BLB", Failure_editor_name = _("Carb. air ind. bulb short circuit"),  Element = -1, Integrity_Treshold = 0.1, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},

	{Failure = CARBAIR_BREAK_LEADS, Failure_name = "CARBAIR_BREAK_LEADS", Failure_editor_name = _("Carb. air ind. breaks in leads"),  Element = 3, Integrity_Treshold = 0.1, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
	{Failure = CARBAIR_OPEN_CIRCUIT_BLB, Failure_name = "CARBAIR_OPEN_CIRCUIT_BLB", Failure_editor_name = _("Carb. air ind. open circuit in bulb"),  Element = -1, Integrity_Treshold = 0.1, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},

	{Failure = IGNITION_NO_OUTPUT, Failure_name = "IGNITION_NO_OUTPUT", Failure_editor_name = _("Ignition condenser burned out"),  Element = -1, Integrity_Treshold = 0.1, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
	{Failure = IGNITION_TERM_CONNECT, Failure_name = "IGNITION_TERM_CONNECT", Failure_editor_name = _("Ignition terminal connection fault"),  Element = -1, Integrity_Treshold = 0.1, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},

	{Failure = STARTER_WIRING, Failure_name = "STARTER_WIRING", Failure_editor_name = _("Starter wiring fault"),  Element = -1, Integrity_Treshold = 0.1, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
	{Failure = STARTER_RELAY, Failure_name = "STARTER_RELAY", Failure_editor_name = _("Starter relay fault"),  Element = -1, Integrity_Treshold = 0.1, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
	{Failure = STARTER_SOLENOID, Failure_name = "STARTER_SOLENOID", Failure_editor_name = _("Starter solenoid fault"),  Element = -1, Integrity_Treshold = 0.1, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
}

need_to_be_closed = true -- close lua state after initialization 
