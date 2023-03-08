VR_capture = 
{
	stick = 
	{
		range_roll  =  math.rad(15),
		range_pitch =  math.rad(15),
		
		left_turn = {-90,10,-90},
		left_shift = {0.04,-0.015,-0.075},
		
		right_turn = {-90,10,90},
		right_shift = {-0.03,-0.015,-0.075},
	},

	collective = 
	{
		arg 		 = 104,
		send_command = 2087,--collective
		connector    = "TROTTLE_HANDLE",
		
		left_turn = {90,20,0},
		left_shift = {-0.02,0.01,0.09},
		
		right_turn = {90,20,0},
		right_shift = {-0.02,0.01,0.09},
	},
}
