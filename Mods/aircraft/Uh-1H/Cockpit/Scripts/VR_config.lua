
VR_capture = 
{
	stick = 
	{
		range_roll   = math.rad(15.0),
		range_pitch  = math.rad(12.0),
		
		left_turn = {180,10,-90},
		left_shift = {0.08,-0.02,0.03},
		
		right_turn = {180,10,90},
		right_shift = {0.08,-0.01,-0.03},
	},
	throttle_left = 
	{
		arg = 207,
		send_command = 2087, --collective
		connector    = "THROTTLE_HANDLE2",
		
		left_turn = {-150,10,-90},
		left_shift = {0.09,-0.02,0.0},
		
		right_turn = {-150,-10,-90},
		right_shift = {0.09,0.01,0.0},
	},
	throttle_right = 
	{
		arg 		 = 200,
		send_command = 2087,--collective
		connector    = "THROTTLE_HANDLE1",
		
		left_turn = {-150,10,-90},
		left_shift = {0.09,-0.02,0.0},
		
		right_turn = {-150,-10,-90},
		right_shift = {0.09,0.01,0.0},
	},
}
