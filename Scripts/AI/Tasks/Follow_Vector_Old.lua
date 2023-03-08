Conditions = {
	IF_ON_VECTOR = 1,
	IF_OVER_START_POINT = 2,
	IF_OVER_DISTANCE = 3,
	IF_ON_TURN_START_POSITION = 4,
	IF_MINIMAL_ROLL = 5,
	IF_PLANE_AHEAD = 6
}	

ConditionActualityPeriods = {
	[Conditions.IF_ON_VECTOR] = 1.0,	
	[Conditions.IF_OVER_START_POINT] = 1.0,
	[Conditions.IF_OVER_DISTANCE] = 1.0,
	[Conditions.IF_ON_TURN_START_POSITION] = 1.0
}

States = {
	INIT = 1,
	FOLLOW_TO_FAR_POINT = 2,
	APPROACH_TO_VECTOR = 3,
	MOVING_ON_LINE = 4,
	MOVING_ON_LINE_WITHOUT_ROLL = 5,
	MID_AIR_COLLISION_AVOIDANCE = 6,
	FINAL = 7
}

InitState = States.INIT

FinishState = States.FINAL

Subtasks = {
	ALTITUDE_VELOCITY_HOLDING_ABOVE_AROUND_TERRAIN = 1,
	ALTITUDE_VELOCITY_HOLDING = 2,
	VELOCITY_HOLDING = 3,
	TURN_OPTIMAL_VELOCITY_HOLDING = 4,
	ALTITUDE_STABILIZING = 5,
	FOLLOW_TO_FAR_POINT = 6,
	APPROACH_TO_VECTOR = 7,
	MOVING_ON_LINE = 8,
	MID_AIR_COLLISION_AVOIDANCE = 9
}

SubtasksByState = {
	[States.FOLLOW_TO_FAR_POINT] = {Subtasks.ALTITUDE_VELOCITY_HOLDING_ABOVE_AROUND_TERRAIN, Subtasks.FOLLOW_TO_FAR_POINT},
	[States.APPROACH_TO_VECTOR] = {Subtasks.TURN_OPTIMAL_VELOCITY_HOLDING, Subtasks.ALTITUDE_STABILIZING, Subtasks.APPROACH_TO_VECTOR},
	[States.MOVING_ON_LINE] = {Subtasks.TURN_OPTIMAL_VELOCITY_HOLDING, Subtasks.ALTITUDE_STABILIZING, Subtasks.MOVING_ON_LINE},
	[States.MOVING_ON_LINE_WITHOUT_ROLL] = {Subtasks.ALTITUDE_VELOCITY_HOLDING, Subtasks.MOVING_ON_LINE},
	[States.FINAL] = {Subtasks.ALTITUDE_VELOCITY_HOLDING, Subtasks.MOVING_ON_LINE},
	[States.MID_AIR_COLLISION_AVOIDANCE] = {Subtasks.MID_AIR_COLLISION_AVOIDANCE}
}

FSM = {
	[States.INIT] = {
		{condition = {operator = "and", operands = {Conditions.IF_ON_VECTOR, Conditions.IF_OVER_DISTANCE}}, new_state = States.MOVING_ON_LINE},
		{condition = Conditions.IF_ON_TURN_START_POSITION, new_state = States.APPROACH_TO_VECTOR},
		{new_state = States.FOLLOW_TO_FAR_POINT}
	},
	[States.FOLLOW_TO_FAR_POINT] = {
		{condition = Conditions.IF_ON_TURN_START_POSITION, new_state = States.APPROACH_TO_VECTOR},
		{condition = Conditions.IF_ON_VECTOR, new_state = States.MOVING_ON_LINE},
		{condition = Conditions.IF_PLANE_AHEAD, new_state = States.MID_AIR_COLLISION_AVOIDANCE, action = 'PUSH' }
	},
	[States.APPROACH_TO_VECTOR] = {
		{condition = Conditions.IF_ON_VECTOR, new_state = States.MOVING_ON_LINE},		
		{condition = Conditions.IF_OVER_START_POINT, new_state = States.FOLLOW_TO_FAR_POINT},
		{condition = Conditions.IF_PLANE_AHEAD, new_state = States.MID_AIR_COLLISION_AVOIDANCE, action = 'PUSH' }
	},
	[States.MOVING_ON_LINE] = {		
		{condition = Conditions.IF_MINIMAL_ROLL, new_state = States.MOVING_ON_LINE_WITHOUT_ROLL},
		{condition = Conditions.IF_PLANE_AHEAD, new_state = States.MID_AIR_COLLISION_AVOIDANCE, action = 'PUSH' }
	},
	[States.MOVING_ON_LINE_WITHOUT_ROLL] = {		
		{condition = Conditions.IF_OVER_START_POINT, new_state = States.FINAL},
		{condition = Conditions.IF_PLANE_AHEAD, new_state = States.MID_AIR_COLLISION_AVOIDANCE, action = 'PUSH' }
	},
	[States.MID_AIR_COLLISION_AVOIDANCE] = {
		{condition = {operator = "not", operand = Conditions.IF_PLANE_AHEAD}, action = 'POP' }
	}
}