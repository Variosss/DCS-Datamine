device_timer_dt = 0.0625

leftDoor = {valmin = 0, valmax = 1, dvalue = 0.5}
collectiveStopper = {valmin = 0, valmax = 1, dvalue = 8}
gunTrigger = {valmin = -1, valmax = 1, dvalue = 6}
missileTrigger = {valmin = -1, valmax = 1, dvalue = 6}
windscreenWiper = {valmin = 0, valmax = 1, dvalue = 1.5}
 
windscreen_wiper_external_arg = 13
wiper_speed_1                 = 3.0;
wiper_speed_2                 = 1.0;
wiper_speed_start             = 5.0;

need_to_be_closed = true -- lua_state  will be closed in post_initialize()