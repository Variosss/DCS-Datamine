local gettext = require("i_18n")
_ = gettext.translate

-- Remote magnetic compass
device_timer_dt = 0.02
	
pointersBias = {{valmin = 0, valmax = math.rad(360.0), bias = math.rad(1.0)}} -- radians
heading = {T1 = 0.95, T2 = 0.316, wmax = 0, bias = pointersBias}
commanded_course = {isLagElement = true, T1 = 0.3, bias = ptrsBias}
knob = commanded_course
knobK = 5

-- radians
deviation = 
{
	0.0, 1.3,
	10.0, 0.9,
	20.0, 0.4,
	30.0, -0.03,
	40.0, -0.35,
	50.0, -0.25,
	60.0, 0.0,
	70.0, 0.4,
	80.0, 0.7,
	90.0, 0.65,
	100.0, 0.05,
	110.0, -0.6,
	120.0, -1.05,
	130.0, -0.98,
	140.0, -0.2,
	150.0, 1.0,
	160.0, 2.3,
	170.0, 3.15,
	180.0, 3.35,
	190.0, 2.95,
	200.0, 2.55,
	210.0, 2.0,
	220.0, 1.2,
	230.0, 0.7,
	240.0, 0.2,
	250.0, -0.2,
	260.0, -0.4,
	270.0, -0.15,
	280.0, 0.15,
	290.0, 0.4,
	300.0, 0.55,
	310.0, 0.35,
	320.0, -0.4,
	330.0, -1.25,
	340.0, -1.9,
	350.0, -0.85,
	360.0, 1.3
}

K_deviation = 0.74627 -- 2.5 degrees max

i = 0
for k, v in pairs(deviation) do
	i = i+1
	if math.fmod(i + 1.0, 2.0) > 0.0 then
		deviation[i] = deviation[i] * K_deviation
	end
	
	-- to radians
	deviation[i] = math.rad(deviation[i])
end

ElecConsumerParams = {1.5, false, 15, 17}

COMPASS_NO_TORQUE 			= 0 
COMPASS_ERRATIC_OPERATION 	= 1 
COMPASS_POINTER_PULLS 		= 2 
COMPASS_ERRATIC_INDIACATON 	= 3
	
Damage = {	
	{Failure = COMPASS_NO_TORQUE, Failure_name = "COMPASS_NO_TORQUE", Failure_editor_name = _("Mag compass. Inverter isn't operating"),  Element = 3, Integrity_Treshold = 0.1, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
	{Failure = COMPASS_ERRATIC_OPERATION, Failure_name = "COMPASS_ERRATIC_OPERATION", Failure_editor_name = _("Mag compass. Wires shorted or open. Erratic operation"),  Element = 3, Integrity_Treshold = 0.05, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
	{Failure = COMPASS_POINTER_PULLS, Failure_name = "COMPASS_POINTER_PULLS", Failure_editor_name = _("Mag compass. Wires shorted or open. Pointer pulls"),  Element = 3, Integrity_Treshold = 0.05, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
	{Failure = COMPASS_ERRATIC_INDIACATON, Failure_name = "COMPASS_ERRATIC_INDIACATON", Failure_editor_name = _("Mag compass. Pointer is loose"),  Element = 3, Integrity_Treshold = 0.2, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
}

need_to_be_closed = true -- lua_state  will be closed in post_initialize()