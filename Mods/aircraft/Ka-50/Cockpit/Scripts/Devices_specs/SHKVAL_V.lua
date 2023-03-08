local gettext = require("i_18n")
_ = gettext.translate

default_camera_angle = (math.rad(23.0))/7
zooms				 = {1,23/7}
delta_frame          = (1.0/(23.0/7.0))/13
h_axis_velocity      = math.rad(20.0)
v_axis_velocity      = math.rad(20.0)
zoom_axis_velocity   = 10

axis_use_velocity    = true

slew_velocity_base      = math.rad(0.3)       -- rad /sec
slew_acceleration_base  = math.rad(2)  -- rad /sqr sec

scan_velocity        = {
math.rad(0.25),
math.rad(0.5),
math.rad(0.75),
math.rad(1.0),
math.rad(1.5),
math.rad(2.0),
math.rad(2.5),
math.rad(3.0)
}

windscreenWiper = {valmin = 0, valmax = 1, dvalue = 1.5}

SHKVAL_FAILURE = 0
Damage = {{Failure = SHKVAL_FAILURE, Failure_name = "SHKVAL_FAILURE", Failure_editor_name = _("Shkval failure"), Element = 59}}
		  
need_to_be_closed = true -- lua_state  will be closed in post_initialize()