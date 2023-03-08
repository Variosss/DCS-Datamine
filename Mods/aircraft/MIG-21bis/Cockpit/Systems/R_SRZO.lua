local count_ = 1

function count()
	count_ = count_ + 1
	return count_
end

eyes ={}
-- SRZO sensors: two sensors - frontal and rear hemisphere
eyes[count()] =
{
    position      = {x = 0.0,y = 0.0, z = 0.0},
    orientation   = {azimuth  = math.rad(0.0),elevation = math.rad(0.0)},
    field_of_view = math.rad(180)
}

eyes[count()] =
{
    position      = {x = 0.0,y = 0.0, z = 0.0},
    orientation   = {azimuth  = math.rad(180.0),elevation = math.rad(0.0)},
    field_of_view = math.rad(180)
}

need_to_be_closed = true

