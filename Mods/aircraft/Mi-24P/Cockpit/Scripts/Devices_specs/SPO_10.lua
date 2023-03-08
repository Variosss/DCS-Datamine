
device_timer_dt     = 0.2
MaxThreats          = 16
EmitterLiveTime     = 0.3
EmitterSoundTime    = 0.5

RWR_detection_coeff = 0.85

-- RWR sensors
eyes ={}

eyes[1] =
{
    position      = {x = 3.65,y = -0.07,z =  0.0},
    orientation   = {azimuth  = math.rad(0),elevation = math.rad(0.0)},
    field_of_view = math.rad(120) 
}
eyes[2] =
{
    position      = {x = -3.65,y = -0.07,z = 0.0},
    orientation   = {azimuth  = math.rad(180),elevation = math.rad(0.0)},
    field_of_view = math.rad(120) 
}
eyes[3] =
{
    position      = {x = 0.0,y = 1.37,z =  -1.6},
    orientation   = {azimuth  = math.rad(270),elevation = math.rad(0.0)},
    field_of_view = math.rad(120) 
}
eyes[4] =
{
    position      = {x = 0.0,y = 1.37,z = 1.6},
    orientation   = {azimuth  = math.rad(90),elevation = math.rad(0.0)},
    field_of_view = math.rad(120) 
}


need_to_be_closed = true -- lua_state  will be closed in post_initialize()