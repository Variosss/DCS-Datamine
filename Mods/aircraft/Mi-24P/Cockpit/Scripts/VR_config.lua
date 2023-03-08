VR_capture = 
{
	stick = 
	{
		range_roll  = math.rad(10),
		range_pitch = math.rad(9.5),
		
		left_turn = {0,10,-90},
		left_shift = {-0.08,-0.01,-0.035},
		
		right_turn = {0,10,90},
		right_shift = {-0.085,-0.01,0.035},
	},
	collective_left = 
	{
		arg 		 = 3,
		send_command = 2087, --collective
		connector    = "THROTTLE_HANDLE1",
		
		left_turn = {75,-10,-5},
		left_shift = {-0.025,0.05,0.07},
		
		right_turn = {110,10,-5},
		right_shift = {0.03,0.025,0.085},
	},
	collective_right = 
	{
		arg 		 = 3,
		send_command = 2087,--collective
		connector    = "THROTTLE_HANDLE2",
		
		left_turn = {75,-10,-5},
		left_shift = {-0.025,0.05,0.07},
		
		right_turn = {110,10,-5},
		right_shift = {0.03,0.025,0.085},
	},
}
