-- DISS-15 Doppler Navigation System

device_timer_dt = 0.0625 -- seconds
device_pos = {-4.61, -0.34, 0.0}

time_to_power_up = 150.0 -- seconds
time_to_wave_search = 5.0 -- seconds

l0 = 0.0175 -- wave length (meters)
min_doppler_frequency = 3.0
max_doppler_frequency = 10000.0 --4000.0

beam_side_angle = math.rad(30.0); -- radians
beam_elev = math.rad(30.0); -- radians
		
min_beam_travel = 4.0 -- meters
max_beam_travel = 4170.0 -- meters

wave_angleK = 9.25 -- dimentionless

max_drift_angle = math.rad(46.0) -- radians
max_pitch_bank = math.rad(30.0) -- radians

max_pitch	= math.rad(7.0)		-- radians
max_bank	= math.rad(30.0)	-- radians

Damage = {{Element = 55}, {Element = 58}}

calc_pos_change_speed = {init = 0.0, acc = 0.0, maximum = 0.0}

w = 25 / 3.6  -- m/s

seaSpeedDif = 3.2		-- change in ground speed when driving over water

needle_hover_Wx = {valmin = -w, valmax = 2*w, T1 = 0.9, T2 = 0.316, wmax = 0, bias = {{valmin = -w, valmax = 2*w, bias = 0.005}}}
needle_hover_Wy = {valmin = -10, valmax = 10, T1 = 0.9, T2 = 0.316, wmax = 0, bias = {{valmin = -10, valmax = 10, bias = 0.005}}}
needle_hover_Wz = {valmin = -w, valmax = w, T1 = 0.9, T2 = 0.316, wmax = 0, bias = {{valmin = -w, valmax = w, bias = 0.005}}}
needle_drift_angle = {valmin = -max_drift_angle, valmax = max_drift_angle, T1 = 0.9, T2 = 0.316, wmax = 0, bias = {{valmin = -max_drift_angle, valmax = max_drift_angle, bias = 0.005}}}

Ex_ratio = (l0 / 4.0) / (math.cos(beam_side_angle) * math.sin(beam_elev))
Ey_ratio = (l0 / 4.0) /  math.cos(beam_elev) 
Ez_ratio = (l0 / 4.0) / (math.sin(beam_side_angle) * math.sin(beam_elev))

ElecConsumerParamsDC = 
{
	2.0, 			-- load DC current DISS-15, [A]
	true,
	19.0,			-- DC voltage value after which the DISS-15 is off, [V]
	22.0, 			-- DC voltage value after which the DISS-15 is on, [V]
	27.0			-- nominal DC voltage value DISS-15, [V]
 }

ElecConsumerParamsAC = 
{
	1.0, 			-- load AC current ARK U2, [A]
	true,
	100.0,			-- AC voltage value after which the DISS-15 is off, [V]
	110.0, 			-- AC voltage value after which the DISS-15 is on, [V]
	115.0			-- nominal AC voltage value DISS-15, [V]
 }
 
need_to_be_closed = true -- lua_state  will be closed in post_initialize()