-- Timer update time
device_timer_dt = 0.04

-- Time constant of pitch drum-servo motor feedback ctrl system
T_Pitch = 0.2 -- sec
-- Time constant of tracking frame-servo motor feedback ctrl system
T_Bank = 0.2 -- сек

need_to_be_closed = true -- lua_state  will be closed in post_initialize()
