h_axis_velocity      = math.rad(20.0)
v_axis_velocity      = math.rad(10.0)
zoom_axis_velocity   = 100

-- в градусах углы доворота
rotate_x	= 0.0
rotate_y	= 0.0
rotate_z	= 0.0

axis_use_velocity    = true
Slew_dead_zone = 0.003

slew_velocity_base      = math.rad(20.0)       -- rad /sec
slew_acceleration_base  = math.rad(0.0)  -- rad /sqr sec

min_slew_velocity = math.rad(0.07)

camera_x = 5.1
camera_y = -1.38 
camera_z = 0.44

kb_targeting_acc = 25.0--8.0 higher value - lower sensitivity ...19.03.2021было 20
mouse_targeting_sensivity = 1.5--0.66 было 25.03.....2.0 lower value - lower sensitivity 19.03.2021было 1.0
joystick_targeting_sensivity = 0.5--0.2 было 25.03.....0.5 было 19.03.2021. 2.0 lower value - lower sensitivity

ShakingFilterAng = 0.1 --degrees/sec 19.03.2021 было 0.8... 0.2 - уже сильно лучше!
SightWithCockpitView = false

SightControl = {valmin = -1, valmax = 1, dvalue = 11}

render_debug_info = true

need_to_be_closed = true -- lua_state  will be closed in post_initialize()