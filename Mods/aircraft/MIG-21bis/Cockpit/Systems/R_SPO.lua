local count_ = 1

function count()
	count_ = count_ + 1
	return count_
end

-- RWR sensors: four sensors - 2 on wing and 2 in tail
eyes ={}
eyes[count()] =
{
    position      = {x = -0.4,y = 0.0, z = 2.35},
    orientation   = {azimuth  = math.rad(45),elevation = math.rad(0.0)},
    field_of_view = math.rad(100) --120
}

eyes[count()] =
{
    position      = {x = -0.4,y = 0.0, z = -2.35},
    orientation   = {azimuth  = math.rad(-45),elevation = math.rad(0.0)},
    field_of_view = math.rad(100) --120
}

eyes[count()] =
{
    position      = {x = -4.75,y = 1.8,z =  0.18},
    orientation   = {azimuth  = math.rad(135),elevation = math.rad(0.0)},
    field_of_view = math.rad(100) 
}
eyes[count()] =
{
    position      = {x = -4.75,y = 1.8,z =  -0.18},
    orientation   = {azimuth  = math.rad(-135),elevation = math.rad(0.0)},
    field_of_view = math.rad(100) 
}

need_to_be_closed = true

