
eyes ={}
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
