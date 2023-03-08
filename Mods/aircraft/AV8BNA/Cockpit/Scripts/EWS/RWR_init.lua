local gettext = require("i_18n")
_ = gettext.translate

device_timer_dt		= 0.01

eyes ={}

eyes[1] =
{
    position      = {x = -3.244,y =  -0.537, z = -4.339}, -- Wing Left
    orientation   = {azimuth  = math.rad(-45.0),elevation = -math.rad(0.0)},
    field_of_view = math.rad(120)
}

eyes[2] =
{
    position      = {x = -3.244, y = -0.537, z = 4.339}, -- Wing Right
    orientation   = {azimuth  = math.rad(45.0),elevation = -math.rad(0.0)},
    field_of_view = math.rad(120) 
}

eyes[3] =
{
    position      = {x = -9.119, y = 0.274, z = 0.128},  -- Tail Rear Left
    orientation   = {azimuth  = math.rad(-135.0),elevation = -math.rad(0.0)},
    field_of_view = math.rad(120) 
}
eyes[4] =
{
    position      = {x = -9.119, y = 0.274, z = -0.128},  -- Tail Rear Right
    orientation   = {azimuth  = math.rad(135.0),elevation = -math.rad(0.0)},
    field_of_view = math.rad(120) 
}
eyes[5] =
{
    position      = {x = 4.833, y = -0.401, z = 0.000},  					-- Nose tip (for ARM guidance purposes only)
    orientation   = {azimuth  = math.rad(0.0),elevation = -math.rad(0.0)},	-- No elevation, no azimuth; looks straight ahead
    field_of_view = math.rad(20) 											-- Very narrow FOV
}

RWR_FAILURE_SENSOR_TAIL_L	= 1
RWR_FAILURE_SENSOR_TAIL_R	= 2
RWR_FAILURE_SENSOR_LEFT		= 3
RWR_FAILURE_SENSOR_RIGHT	= 4
RWR_FAILURE_TOTAL			= 5

Damage = {	
	{Failure = RWR_FAILURE_SENSOR_TAIL_L,	Failure_name = "RWR_FAILURE_SENSOR_TAIL_L",	Failure_editor_name = _("RWR tail left sensor"),	Element = 55, Integrity_Treshold = 0.95, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
	{Failure = RWR_FAILURE_SENSOR_TAIL_R,	Failure_name = "RWR_FAILURE_SENSOR_TAIL_R",	Failure_editor_name = _("RWR tail right sensors"),	Element = 55, Integrity_Treshold = 0.90, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
	{Failure = RWR_FAILURE_SENSOR_LEFT,		Failure_name = "RWR_FAILURE_SENSOR_LEFT",	Failure_editor_name = _("RWR left wing sensor"),	Element = 23, Integrity_Treshold = 0.75, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
	{Failure = RWR_FAILURE_SENSOR_RIGHT,	Failure_name = "RWR_FAILURE_SENSOR_RIGHT",	Failure_editor_name = _("RWR right wing sensor"),	Element = 24, Integrity_Treshold = 0.75, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
	{Failure = RWR_FAILURE_TOTAL,			Failure_name = "RWR_FAILURE_TOTAL",			Failure_editor_name = _("RWR total failure"),		Element = 70, Integrity_Treshold = 0.80, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
}


need_to_be_closed = true
