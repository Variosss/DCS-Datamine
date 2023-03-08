device_timer_dt = 0.0625

arg_values = 
{
	value	= {0.0,	1.0,	2.0,	3.0 , 4.0},
	arg		= {0.0,	0.05,	0.15,	0.25, 0.35}
}

doorElement = {valmin = 0, valmax = 1, dvalue = 0.5}
wiper = {valmin = 0, valmax = 1, dvalue = 1.5}

ElecConsumerWiperParams = 
{
	20.0, 			-- load DC current wiper actuator, [A]
	true,
	10.0,			-- DC voltage value after which the wiper actuator is off, [V]
	15.0, 			-- DC voltage value after which the wiper actuator is on, [V]
	27.0			-- nominal DC voltage value wiper actuator, [V]
}

wiper_sounds_settings = 
{
	pitch = {1.0, 3.0, 2.0, 1.0, 1.0}	
}

local ratio_gauge_liner = 25;
local WiperSpeedFactor = 2.0 / 60.0;								-- actuator wiper speed , [step/sec] 
WiperSpeed0 = WiperSpeedFactor * 90.0 * ratio_gauge_liner;			-- the number of double steps of the electric cleaner drive during start-up (corresponds to the "START" mode) , [step/min] 
WiperSpeed1 = WiperSpeedFactor * 60.0 * ratio_gauge_liner;			-- number of double steps of the actuator wiper  (mode 1SPEED), [step/min] 
WiperSpeed2 = WiperSpeedFactor * 30.0 * ratio_gauge_liner;			-- number of double steps of the actuator wiper (mode 2SPEED), [step/min] 

ElecConsumerFanParams = 
{
	15.0, 			-- load DC current fan, [Watt]
	true,
	6.0,			-- DC voltage value after which the fan is off, [V]
	12.0, 			-- DC voltage value after which the fan is on, [V]
	26.0			-- nominal DC voltage value fan, [V]
}

Fan_Speed = 10.0		
Fan_SpinUpTime = 1.0	-- [sec]
Fan_SpinDownTime = 4.0 	-- [sec]

ElecConsumerParamsTrimmer			= {1.0, true, 2.0, 3.0, 28.0}

need_to_be_closed = true -- lua_state  will be closed in post_initialize()