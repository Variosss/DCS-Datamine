local gettext = require("i_18n")
_ = gettext.translate

device_timer_dt		= 0.01

eyes ={}

eyes[1] =
{
    position      = {x = -4.40, y =  -0.385, z = -3.358}, -- Wing Left Forward
    orientation   = {azimuth  = math.rad(-45),elevation = -math.rad(30)},
    field_of_view = math.rad(90)
}
eyes[2] =
{
    position      = {x = -4.40, y =  -0.385, z = -3.358}, -- Wing Left Center
    orientation   = {azimuth  = math.rad(-90),elevation = -math.rad(30)},
    field_of_view = math.rad(90)
}
eyes[3] =
{
    position      = {x = -4.40, y =  -0.385, z = -3.358}, -- Wing Left Back
    orientation   = {azimuth  = math.rad(-135),elevation = -math.rad(30)},
    field_of_view = math.rad(90) 
}
eyes[4] =
{
    position      = {x = -4.40, y = -0.385, z = 3.358}, -- Wing Right Forward
    orientation   = {azimuth  = math.rad(45),elevation = -math.rad(30)},
    field_of_view = math.rad(90)
}
eyes[5] =
{
    position      = {x = -4.40, y = -0.385, z = 3.358}, -- Wing Right Forward
    orientation   = {azimuth  = math.rad(90),elevation = -math.rad(30)},
    field_of_view = math.rad(90)
}
eyes[6] =
{
    position      = {x = -4.40, y = -0.385, z = 3.358}, -- Wing Right Back
    orientation   = {azimuth  = math.rad(135),elevation = -math.rad(30)},
    field_of_view = math.rad(90) 
}

message_legth = 3.0
notify_delta  = 4.0

message_table = {} 

for i = 0,7 do message_table[i] = 46 + i end

angular_velocity_threshold = 100000

need_to_be_closed = true