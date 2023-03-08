
default_camera_angle = math.rad(90.0)
zooms				 = {0.1, 0.1}
h_axis_velocity      = math.rad(20.0)
v_axis_velocity      = math.rad(20.0)
zoom_axis_velocity   = 10

axis_use_velocity    = true

slew_velocity_base      = math.rad(0.3)       -- rad /sec
slew_acceleration_base  = math.rad(2)  -- rad /sqr sec

Damage = {{Element = 59}}

need_to_be_closed = true -- lua_state  will be closed in post_initialize()