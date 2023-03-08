-- C-061K Inertial Navigation System

device_timer_dt = 0.012

-- g scalar
gs = 9.81

------------------------------------------------------
-- gyroscopes properties

-- constant errors
-- constant bias K
gyro_bias_K = 0.011
--gyro_bias_K = 0.0

-- dynamic errors
--
-- angular rate K
angular_rate_error_K = 150.0
--angular_rate_error_K = 0.0
-- acceleration K
acceleration_error_K = 0.01719
--acceleration_error_K = 0.0

-- bias correction limits
--sdf

------------------------------------------------------
-- gyro plaform properties

-- max angular rates (rad/sec)
w_K = {math.rad(180.0), math.rad(140.0), math.rad(140.0)}
--w_K = {math.rad(60.0), math.rad(60.0), math.rad(60.0)}

-- max angular accelerations (rad/sec^2)
--w_dt_K = {math.rad(1000.0), math.rad(1000.0), math.rad(1000.0)}
w_dt_K = {math.rad(900.0), math.rad(500.0), math.rad(500.0)}

gyro_platform_force_K = {10.0, 10.0, 10.0}
gyro_platform_damper_K = {0.0, 0.0, 0.0}

------------------------------------------------------
-- accelerometers

accelerometers_threshold = 0.0001 * gs
accelerometers_K_dyn = 0.95
accelerometers_a_max = 25.0 * gs
