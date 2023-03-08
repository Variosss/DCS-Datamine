device_timer_dt = 0.075

drift_rate_max = 2.5/3600.0 					-- [deg/sec]
readiness_time = 20								-- acceleration time, [sec]
Drift = 1.0 / 3600.0 * device_timer_dt			-- maximum out value, [deg/sec]
BringSpeed = 2.0 * device_timer_dt 				-- normal correction speed, [deg/sec]
ArretirSpeed = 15.0 * device_timer_dt			--[degrees/sec]
RotSpeedInc =	1.0/(readiness_time)			-- rotor acceleration speed, [deg/sec]
RotSpeedDec =  1.0/(readiness_time) / 2.0		-- rotor out speed , [deg/sec]
	
start_delay 			= 70.0 --[sec]

LatitudeScale = { -- {Latitude, Model Arg Value}
{0.0, 0.0},
{10.0, 0.128},
{20.0, 0.250},
{30.0, 0.364},
{40.0, 0.466},
{50.0, 0.556},
{60.0, 0.631},	
{70.0, 0.683},
{80.0, 0.717}}

need_to_be_closed = true -- lua_state  will be closed in post_initialize()