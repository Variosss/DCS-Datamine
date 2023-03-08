local gettext = require("i_18n")
_ = gettext.translate

device_timer_dt		= 0.5

-- MLWS sensors: A10C has four sensors - 2 on wings and 2 in tail
eyes ={}

eyes[1] =
{
    position      = {x = 0.0,y = 0.3,z =  8.8},
    orientation   = {azimuth  = math.rad(60),elevation = -math.rad(0.0)},
    field_of_view = math.rad(120) 
}
eyes[2] =
{
    position      = {x = 0.0,y = 0.3,z = -8.8},
    orientation   = {azimuth  = math.rad(-60),elevation = -math.rad(0.0)},
    field_of_view = math.rad(120) 
}
eyes[3] =
{
    position      = {x = -8.6,y = 0.25,z =  0.0},
    orientation   = {azimuth  = math.rad(180),elevation = -math.rad(0.0)},
    field_of_view = math.rad(120) 
}
eyes[4] =
{
    position      = {x = -8.4,y = -0.2,z =  0.0},
    orientation   = {azimuth  = math.rad(0),elevation = -math.rad(90.0)},
    field_of_view = math.rad(120) 
}
--[[
eyes[1] =
{
    position      = {x = 6.0,y = -0.75,z =  0.5},
    orientation   = {azimuth  = math.rad(45),elevation = -math.rad(22.5)},
    field_of_view = math.rad(90) 
}
eyes[2] =
{
    position      = {x = 6.0,y = -0.75,z = -0.5},
    orientation   = {azimuth  = math.rad(-45),elevation = -math.rad(22.5)},
    field_of_view = math.rad(90) 
}
eyes[3] =
{
    position      = {x = -5.5,y = 0.5,z =  0.5},
    orientation   = {azimuth  = math.rad(180 - 45),elevation = -math.rad(22.5)},
    field_of_view = math.rad(90) 
}

eyes[4] =
{
    position      = {x = -5.5,y = 0.5,z = -0.5},
    orientation   = {azimuth  = math.rad(-(180-45)),elevation = -math.rad(22.5)},
    field_of_view = math.rad(90) 
}
--]]

--  for voice messaging system
msg_MLWS = 
{
    _03_Low  = 0,
    _03_High = 1,		
    _06_Low  = 2,
    _06_High = 3,		
    _09_Low  = 4,
    _09_High = 5,		
    _12_Low  = 6,
    _12_High = 7
}

message_legth = 3.0
notify_delta  = 4.0


message_table = {} 

for i = 0,7 do message_table[i] = 46 + i end


need_to_be_closed = true -- close lua state after initialization 

AAR_47_FAILURE_SENSOR_RIGHT	= 0
AAR_47_FAILURE_SENSOR_LEFT	= 1
AAR_47_FAILURE_SENSOR_TAIL	= 2
AAR_47_FAILURE_SENSOR_BOTTOM	= 3
AAR_47_FAILURE_TOTAL		= 4

Damage = {	{Failure = AAR_47_FAILURE_SENSOR_RIGHT, Failure_name = "AAR_47_FAILURE_SENSOR_RIGHT", Failure_editor_name = _("AN/AAR-47 sensor right"),  Element = 24, Integrity_Treshold = 0.75, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
		{Failure = AAR_47_FAILURE_SENSOR_LEFT, Failure_name = "AAR_47_FAILURE_SENSOR_LEFT", Failure_editor_name = _("AN/AAR-47 sensor left"),  Element = 23, Integrity_Treshold = 0.75, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
		{Failure = AAR_47_FAILURE_SENSOR_TAIL, Failure_name = "AAR_47_FAILURE_SENSOR_TAIL", Failure_editor_name = _("AN/AAR-47 sensor tail"),  Element = 55, Integrity_Treshold = 0.5, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
		{Failure = AAR_47_FAILURE_SENSOR_BOTTOM, Failure_name = "AAR_47_FAILURE_SENSOR_BOTTOM", Failure_editor_name = _("AN/AAR-47 sensor bottom"),  Element = 55, Integrity_Treshold = 0.5, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
		{Failure = AAR_47_FAILURE_TOTAL, Failure_name = "AAR_47_FAILURE_TOTAL", Failure_editor_name = _("AN/AAR-47 total failure"),  Element = 5, Integrity_Treshold = 0.25, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300}}
