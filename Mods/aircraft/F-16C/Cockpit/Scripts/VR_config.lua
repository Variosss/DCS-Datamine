VR_capture = 
{
	stick = 
	{
		connector    = "STICK_HANDLE1",
		range_roll   = math.rad(30.0),
		range_pitch  = math.rad(30.0),
		
		exp_arg_a = 0.06,
		exp_arg_c_rate = 162,
		exp_dead_rate = math.rad(3.0),
		
		left_turn = {-50,0,-90},
		left_shift = {-0.02,-0.02,-0.08},
		
		right_turn = {0,10,90},
		right_shift = {-0.085,-0.035,0.035},
	},
	throttle = 
	{
		connector = "THROTTLE_HANDLE1",
		arg 		   = 755,
		
		left_turn = {-15,0,-15},
		left_shift = {-0.07,0.045,-0.03},
		
		right_turn = {50,0,10},
		right_shift = {-0.03,0.045,0.1},
		

	}
}