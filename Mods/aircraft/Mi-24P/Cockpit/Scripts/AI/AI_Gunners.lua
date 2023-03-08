dofile(LockOn_Options.script_path.."AI/AI_Side_Gunner.lua")
dofile("Scripts/Database/wsTypes.lua")

LEFT_GUNNER_SEAT = 2
RIGHT_GUNNER_SEAT = 3

AI_gunners = {}
AI_manager = {
	--> decrease priority
	targets_priority = { 
	{wsType_Air},
	{wsType_Ground,wsType_SAM, wsType_Miss},
	{wsType_Ground,wsType_SAM},
	{wsType_Ground,wsType_Tank}, 
	}
}

left_gunner_position =  {
	
	coord = {2.6,-1.29, -0.4},
	connector = "Gunner_Point1",
	--Field of view related to aircraft
	FOV = { 
		azimuth = {math.rad(-148.0), math.rad(-20.0)},
		elevation = {math.rad(-40), math.rad(10.0)}
	}
}

left_controller = fill_side_controller(6,0,{math.rad(-24.5), math.rad(40.0)},{math.rad(-40.0), math.rad(10.0)})
left_state_matrix = fill_side_state_matrix(0,{0,6},{452,6})
left_g_states = fill_side_states(0, {0,6}, {423,6}, {424,6}, {452,6},{50,6},50)

AI_gunners[LEFT_GUNNER_SEAT] = add_gunner(left_gunner_position,left_controller,0.04,S_WAIT,left_g_states,left_state_matrix)


right_gunner_position =  {
	
	coord = {2.6,-1.29, 0.4},
	connector = "Gunner_Point",
	--Field of view related to aircraft
	FOV = { 
		azimuth = {math.rad(20.0), math.rad(148.0)},
		elevation = {math.rad(-40), math.rad(10.0)}
	}
}

right_controller = fill_side_controller(7,0,{math.rad(-40.0), math.rad(25.0)},{math.rad(-40.0), math.rad(10.0)})
right_state_matrix = fill_side_state_matrix(0,{0,7},{452,7})
right_g_states = fill_side_states(0, {0,7}, {423,7}, {424,7}, {452,7},{50,7},50)

AI_gunners[RIGHT_GUNNER_SEAT] = add_gunner(right_gunner_position,right_controller,0.04,S_WAIT,right_g_states,right_state_matrix)


