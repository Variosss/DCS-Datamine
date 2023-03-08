Conditions = {
	IF_NEAR_MIDDLE_POINT = 1
}

ConditionActualityPeriods = {}

States = {
	INIT = 1,
	FOLLOW_1ST_CIRCLE_NEAR = 2,
	FOLLOW_1ST_CIRCLE_FAR = 3,
	FOLLOW_2ND_CIRCLE_NEAR = 4,
	FOLLOW_2ND_CIRCLE_FAR = 5
}

InitState = States.INIT

Subtasks = {
	BEGIN_ALTITUDE_HOLD = 1,
	BEGIN_FOLLOW_1ST_CIRCLE = 2,
	BEGIN_FOLLOW_2ND_CIRCLE = 3
}

SubtasksByState = {
	[States.FOLLOW_1ST_CIRCLE_NEAR] = {Subtasks.BEGIN_ALTITUDE_HOLD, Subtasks.BEGIN_FOLLOW_1ST_CIRCLE},
	[States.FOLLOW_1ST_CIRCLE_FAR] = {Subtasks.BEGIN_ALTITUDE_HOLD, Subtasks.BEGIN_FOLLOW_1ST_CIRCLE},
	[States.FOLLOW_2ND_CIRCLE_NEAR] = {Subtasks.BEGIN_ALTITUDE_HOLD, Subtasks.BEGIN_FOLLOW_2ND_CIRCLE},
	[States.FOLLOW_2ND_CIRCLE_FAR] = {Subtasks.BEGIN_ALTITUDE_HOLD, Subtasks.BEGIN_FOLLOW_2ND_CIRCLE}
}

FSM = {
	[States.INIT] = {
		{new_state = States.FOLLOW_1ST_CIRCLE_NEAR}
	},
	[States.FOLLOW_1ST_CIRCLE_NEAR] = {
		{condition = {operator = "not", operand = Conditions.IF_NEAR_MIDDLE_POINT}, new_state = States.FOLLOW_1ST_CIRCLE_FAR}
	},
	[States.FOLLOW_1ST_CIRCLE_FAR] = {
		{condition = Conditions.IF_NEAR_MIDDLE_POINT, new_state = States.FOLLOW_2ND_CIRCLE_NEAR}
	},
	[States.FOLLOW_2ND_CIRCLE_NEAR] = {
		{condition = {operator = "not", operand = Conditions.IF_NEAR_MIDDLE_POINT}, new_state = States.FOLLOW_2ND_CIRCLE_FAR}
	},
	[States.FOLLOW_2ND_CIRCLE_FAR] = {
		{condition = Conditions.IF_NEAR_MIDDLE_POINT, new_state = States.FOLLOW_1ST_CIRCLE_NEAR}
	}
}