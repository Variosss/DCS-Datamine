device_timer_dt = 0.01 -- seconds

J = 0.001 -- Gyro moment of inertia (N * m * sec^2)
D = 0.17  -- Damper constant (N * m * sec)
C = 6.0   -- Spring constant (N * m)
H = 1.0   -- Gyro angular momentum (N * m * sec)

MaxInput  = math.rad(120.0) -- 1 / sec
Sensivity = 0.000049 -- 1 / sec
ScaleBias = 5 -- percents

InitRotX  = 0
InitRotZ  = math.rad(-90)
