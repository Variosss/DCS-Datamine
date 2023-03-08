device_timer_dt		= 0.015

Acceleration_needle_min		  = -5.0
Acceleration_needle_max		  = 12.0
Acceleration_needle_J	      = 0.04 -- momentum of inertia
Acceleration_needle_D	      = 0.3 -- damping constant
Acceleration_needle_C	      = 10  -- spring force constant

AccelerometerResetValue       = 1.0 -- the target value for the pointers when the 'Reset' knob is pushed
AccelCageK                    = 22.0 * device_timer_dt; -- The cage speed coefficient for min/max achieved and accel pointers
AccelReturnK                  = 10.0 * device_timer_dt; -- The returning speed coefficient for min/max achieved and accel pointers


need_to_be_closed = true -- close lua state after initialization 