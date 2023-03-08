local check_LOS_before_dive = true

Conditions = {
	IF_FIRE_AND_FORGET_MISSILE = 1,
	IF_MISSILE_NEED_LOS = 2,
	IF_TARGET_LOS_PRESENT = 3,
	IF_MINIMAL_ROLL = 4,
	IF_MINIMAL_CLIMB = 5,
	IF_TOO_CLOSE = 6,
	IF_ON_LAUNCH_DISTANCE = 7,
	IF_ON_BREAKAWAY_POSITION = 8,
	IF_TARGET_DESTROYED = 9,
	IF_TURN_TO_TARGET_IMPOSSIBLE = 10,
	IF_PLANE_AHEAD = 11
}

ConditionActualityPeriods = {}

States = {
	INIT = 1,
	APPROACHING = 2,
	MOVING_TO_TARGET_HOR = 3,	
	MOVING_TO_TARGET_HOR_AND_MISSILE_FIRING = 4,
	MOVING_TO_TARGET_HOR_AND_TARGET_ILLUMINATION = 5,
	MID_AIR_COLLISION_AVOIDANCE = 6,
	BREAKAWAY = 7
}

InitState = States.INIT

FinishState = States.BREAKAWAY

Subtasks = {
	APPROACHING = 1,
	ALTITUDE_VELOCITY_HOLDING = 2,
	MOVING_TO_TARGET_HOR = 3,
	MISSILE_FIRING = 4,	
	BREAKAWAY = 5
}

SubtaskStates = {
	[Subtasks.APPROACHING] = {
		FINAL = 7
	},
	[Subtasks.MISSILE_FIRING] = {
		LAUNCH_NOT_STARTED = 0,
		LAUNCH_IN_PROCESS = 1,
		LAUNCH_FINISHED = 2,
		LAST_MISSILE_IMPACT = 3
	},
}

SubtasksByState = {
	[States.APPROACHING] = {Subtasks.APPROACHING},
	[States.MOVING_TO_TARGET_HOR] = {Subtasks.ALTITUDE_VELOCITY_HOLDING, Subtasks.MOVING_TO_TARGET_HOR},
	[States.MOVING_TO_TARGET_HOR_AND_MISSILE_FIRING] = {Subtasks.ALTITUDE_VELOCITY_HOLDING, Subtasks.MOVING_TO_TARGET_HOR, Subtasks.MISSILE_FIRING},
	[States.MOVING_TO_TARGET_HOR_AND_TARGET_ILLUMINATION] = {Subtasks.ALTITUDE_VELOCITY_HOLDING, Subtasks.MOVING_TO_TARGET_HOR, Subtasks.MISSILE_FIRING},
	[States.BREAKAWAY] = {Subtasks.ALTITUDE_VELOCITY_HOLDING, Subtasks.BREAKAWAY},
	[States.MID_AIR_COLLISION_AVOIDANCE] = {Subtasks.MID_AIR_COLLISION_AVOIDANCE}
}

FSM = {
	[States.INIT] = {
		{new_state = States.APPROACHING}
	},
	[States.APPROACHING] = {
		{condition = Conditions.IF_TOO_CLOSE, new_state = States.BREAKAWAY},
		{condition = {subtask = Subtasks.APPROACHING, status = SubtaskStates[Subtasks.APPROACHING].FINAL}, new_state = States.MOVING_TO_TARGET_HOR},
		{condition = Conditions.IF_TARGET_DESTROYED, new_state = States.BREAKAWAY}
	},
	[States.MOVING_TO_TARGET_HOR] = {
		--launch in horizontal flight
		{condition = {operator = "and", operands = {Conditions.IF_MINIMAL_ROLL, Conditions.IF_MINIMAL_CLIMB, Conditions.IF_ON_LAUNCH_DISTANCE}}, new_state = States.MOVING_TO_TARGET_HOR_AND_MISSILE_FIRING},
		--Mid-air collision avoidance
		{condition = Conditions.IF_PLANE_AHEAD, new_state = States.MID_AIR_COLLISION_AVOIDANCE, action = 'PUSH' },
		--breakaway
		{condition = Conditions.IF_TOO_CLOSE, new_state = States.BREAKAWAY},
		{condition = Conditions.IF_TARGET_DESTROYED, new_state = States.BREAKAWAY},
		{condition = Conditions.IF_ON_BREAKAWAY_POSITION, new_state = States.BREAKAWAY},
		{condition = Conditions.IF_TURN_TO_TARGET_IMPOSSIBLE, new_state = States.BREAKAWAY}
	},
	[States.MOVING_TO_TARGET_HOR_AND_MISSILE_FIRING] = {
		--after launch
		{condition = {operator = "and", operands = {{operator = "not", operand = Conditions.IF_FIRE_AND_FORGET_MISSILE}, {subtask = Subtasks.MISSILE_FIRING, status = SubtaskStates[Subtasks.MISSILE_FIRING].LAUNCH_FINISHED}}}, new_state = States.MOVING_TO_TARGET_HOR_AND_TARGET_ILLUMINATION},
		{condition = {operator = "and", operands = {Conditions.IF_FIRE_AND_FORGET_MISSILE, {subtask = Subtasks.MISSILE_FIRING, status = SubtaskStates[Subtasks.MISSILE_FIRING].LAUNCH_FINISHED}}}, new_state = States.BREAKAWAY},
		--Mid-air collision avoidance
		{condition = Conditions.IF_PLANE_AHEAD, new_state = States.MID_AIR_COLLISION_AVOIDANCE, action = 'PUSH' },		
		--breakaway
		{condition = Conditions.IF_TOO_CLOSE, new_state = States.BREAKAWAY},
		{condition = {operator = "and", operands = {Conditions.IF_TOO_CLOSE, {subtask = Subtasks.MISSILE_FIRING, status = SubtaskStates[Subtasks.MISSILE_FIRING].LAUNCH_NOT_STARTED}}}, new_state = States.BREAKAWAY},
		{condition = {operator = "and", operands = {Conditions.IF_TOO_CLOSE, {operator = "not", operand = Conditions.IF_FIRE_AND_FORGET_MISSILE}, {subtask = Subtasks.MISSILE_FIRING, status = SubtaskStates[Subtasks.MISSILE_FIRING].LAUNCH_IN_PROCESS}}}, new_state = States.MOVING_TO_TARGET_HOR_AND_TARGET_ILLUMINATION},		
		{condition = Conditions.IF_TARGET_DESTROYED, new_state = States.BREAKAWAY},
		{condition = Conditions.IF_ON_BREAKAWAY_POSITION, new_state = States.BREAKAWAY},
		{condition = Conditions.IF_TURN_TO_TARGET_IMPOSSIBLE, new_state = States.BREAKAWAY}
	},
	[States.MOVING_TO_TARGET_HOR_AND_TARGET_ILLUMINATION] = {
		--Mid-air collision avoidance
		{condition = Conditions.IF_PLANE_AHEAD, new_state = States.MID_AIR_COLLISION_AVOIDANCE, action = 'PUSH' },	
		--breakaway
		{condition = {subtask = Subtasks.MISSILE_FIRING, status = SubtaskStates[Subtasks.MISSILE_FIRING].LAST_MISSILE_IMPACT}, new_state = States.BREAKAWAY},
		{condition = Conditions.IF_TARGET_DESTROYED, new_state = States.BREAKAWAY},
		{condition = Conditions.IF_ON_BREAKAWAY_POSITION, new_state = States.BREAKAWAY},
		{condition = Conditions.IF_TURN_TO_TARGET_IMPOSSIBLE, new_state = States.BREAKAWAY}
	},
	[States.MID_AIR_COLLISION_AVOIDANCE] = {
		{condition = Conditions.IF_TARGET_DESTROYED, new_state = States.BREAKAWAY},
		{condition = {operator = "not", operand = Conditions.IF_PLANE_AHEAD}, action = 'POP' }
	}
}

if check_LOS_before_dive then
	FSM[States.MOVING_TO_TARGET_HOR][1] = {condition = {operator = "and", operands = {Conditions.IF_MINIMAL_ROLL, Conditions.IF_ON_LAUNCH_DISTANCE, {operator = "or", operands = {{operator = "not", operand = Conditions.IF_MISSILE_NEED_LOS}, Conditions.IF_TARGET_LOS_PRESENT}}}}, new_state = States.MOVING_TO_TARGET_HOR_AND_MISSILE_FIRING}
end
