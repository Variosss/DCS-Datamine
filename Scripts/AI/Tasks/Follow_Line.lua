Conditions = {
	IF_XTE_TOO_BIG = 1,
	IF_TURN_SOLUTION_PRESENT = 2,
	IF_ON_LINE = 3,
	IF_PLANE_AHEAD = 4
}

ConditionActualityPeriods = {}

States = {
	INIT = 1,
	MOVING_ACROSS_LINE_FAR = 2,
	MOVING_ACROSS_LINE_NEAR = 3,
	ON_TURN = 4,
	MOVING_ON_LINE = 5,
	MID_AIR_COLLISION_AVOIDANCE = 6
}

InitState = States.INIT

FinishState = States.MOVING_ON_LINE

Subtasks = {
	ALTITUDE_VELOCITY_HOLDING_ABOVE_AROUND_TERRAIN = 1,
	MOVING_ACROSS_LINE = 2,
	TURN = 3,
	MOVING_ON_LINE = 4,
	MID_AIR_COLLISION_AVOIDANCE = 5
}

SubtasksByState = {
	[States.MOVING_ACROSS_LINE_FAR] = {Subtasks.ALTITUDE_VELOCITY_HOLDING_ABOVE_AROUND_TERRAIN, Subtasks.MOVING_ACROSS_LINE},
	[States.MOVING_ACROSS_LINE_NEAR] = {Subtasks.ALTITUDE_VELOCITY_HOLDING_ABOVE_AROUND_TERRAIN, Subtasks.MOVING_ACROSS_LINE},
	[States.ON_TURN] = {Subtasks.ALTITUDE_VELOCITY_HOLDING_ABOVE_AROUND_TERRAIN, Subtasks.TURN},
	[States.MOVING_ON_LINE] = {Subtasks.ALTITUDE_VELOCITY_HOLDING_ABOVE_AROUND_TERRAIN, Subtasks.MOVING_ON_LINE},
	[States.MID_AIR_COLLISION_AVOIDANCE] = {Subtasks.MID_AIR_COLLISION_AVOIDANCE}
}

FSM = {
	[States.INIT] = {
		[1] = {new_state = States.MOVING_ACROSS_LINE_FAR, actions = {}}
	},
	[States.MOVING_ACROSS_LINE_FAR] = {
		{condition = {operator = "not", operand = Conditions.IF_XTE_TOO_BIG}, new_state = States.MOVING_ACROSS_LINE_NEAR},
		{condition = Conditions.IF_PLANE_AHEAD, new_state = States.MID_AIR_COLLISION_AVOIDANCE, action = 'PUSH' }
	},
	[States.MOVING_ACROSS_LINE_NEAR] = {
		{condition = Conditions.IF_ON_LINE, new_state = States.MOVING_ON_LINE},
		{condition = Conditions.IF_TURN_SOLUTION_PRESENT, new_state = States.ON_TURN},
		{condition = Conditions.IF_XTE_TOO_BIG, new_state = States.MOVING_ACROSS_LINE_FAR},
		{condition = Conditions.IF_PLANE_AHEAD, new_state = States.MID_AIR_COLLISION_AVOIDANCE, action = 'PUSH' }
	},
	[States.ON_TURN] = {
		{condition = Conditions.IF_ON_LINE, new_state = States.MOVING_ON_LINE},
		{condition = Conditions.IF_PLANE_AHEAD, new_state = States.MID_AIR_COLLISION_AVOIDANCE, action = 'PUSH' },
	},
	[States.MOVING_ON_LINE] = {
		{condition = {operator = "not", operand = Conditions.IF_ON_LINE}, new_state = States.MOVING_ACROSS_LINE_NEAR},
		{condition = Conditions.IF_PLANE_AHEAD, new_state = States.MID_AIR_COLLISION_AVOIDANCE, action = 'PUSH' },
	},
	[States.MID_AIR_COLLISION_AVOIDANCE] = {
		{condition = {operator = "not", operand = Conditions.IF_PLANE_AHEAD}, action = 'POP' }
	}
}