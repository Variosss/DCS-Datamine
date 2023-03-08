VR_capture = 
{
	stick = 
	{
		range_roll   = math.rad(15.0),
		range_pitch  = math.rad(6.0),
		
		left_turn = {0,0,-110},
		left_shift = {0.05,0,0.01},
		
		right_turn = {0,0,-110},
		right_shift = {0.05,0,-0.01},
	},
	throttle = 
	{
		connector = "THROTTLE_HANDLE",
		arg = 5,
		
		left_turn = {0,0,90},
		left_shift = {0.0,0.0,0.025},
		
		right_turn = {180,0,0},
		right_shift = {0,0.0,0.025},
	},
}