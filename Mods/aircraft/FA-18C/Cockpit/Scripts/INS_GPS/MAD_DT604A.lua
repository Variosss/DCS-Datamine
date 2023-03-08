device_timer_dt		= 0.05

-- degrees
deviation = 
{
	0.0, 	 0.0,
	10.0, 	 0.0,
	20.0, 	 0.1,
	30.0, 	-0.03,
	40.0, 	 0.0,
	50.0, 	 0.0,
	60.0, 	 0.0,
	70.0, 	 0.2,
	80.0, 	 0.3,
	90.0, 	 0.1,
	100.0, 	-0.2,
	110.0, 	-0.13,
	120.0, 	-0.01,
	130.0, 	 0.0,
	140.0, 	 0.0,
	150.0, 	 0.0,
	160.0, 	 0.1,
	170.0, 	 0.18,
	180.0, 	 0.1,
	190.0, 	 0.003,
	200.0, 	 0.05,
	210.0, 	 0.0,
	220.0, 	 0.2,
	230.0, 	 0.3,
	240.0, 	 0.1,
	250.0, 	-0.2,
	260.0, 	-0.3,
	270.0, 	-0.14,
	280.0, 	 0.05,
	290.0, 	 0.0,
	300.0, 	 0.0,
	310.0, 	 0.0,
	320.0, 	-0.01,
	330.0, 	-0.19,
	340.0, 	 0.0,
	350.0, 	 0.0,
	360.0, 	 0.0
}

local scale = 1 -- no effect for now

i = 0
for k, v in pairs(deviation) do
	i = i + 1
	if math.fmod(i + 1.0, 2.0) > 0.0 then
		deviation[i] = deviation[i] * scale
	end
	
	-- to radians
	deviation[i] = math.rad(deviation[i])
end

-- gimbal limits (both pitch and bank)
max_pitch_bank = math.rad(10.5)

need_to_be_closed = true -- lua_state  will be closed in post_initialize()
