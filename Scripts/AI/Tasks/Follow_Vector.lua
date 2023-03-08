local find_shortest_path = false

Conditions = {
	IF_ON_DIRECTION_TO_LEFT_TURN_CIRCLE = 1,
	IF_ON_DIRECTION_TO_RIGHT_TURN_CIRCLE = 2,	
	IF_LEFT_FINAL_CIRCLE_WAY_SHORTER = 3,	
	IF_NEAR_VECTOR_START = 4,
	IF_ON_VECTOR = 5,
	IF_PLANE_AHEAD = 6
}	

ConditionActualityPeriods = {
	[Conditions.IF_ON_DIRECTION_TO_LEFT_TURN_CIRCLE] = 0.2,
	[Conditions.IF_ON_DIRECTION_TO_RIGHT_TURN_CIRCLE] = 0.2,
	[Conditions.IF_LEFT_FINAL_CIRCLE_WAY_SHORTER] = 1.0,
	[Conditions.IF_NEAR_VECTOR_START] = 0.3,
	[Conditions.IF_ON_VECTOR] = 0.5,
}

States = {
	INIT = 1,
	FIRST_TURN = 2,
	FIRST_TURN_LEFT_FINAL_TURN_MISSED = 3,
	FIRST_TURN_RIGHT_FINAL_TURN_MISSED = 4,
	LEFT_FINAL_TURN = 5,
	RIGHT_FINAL_TURN = 6,
	NEAR_VECTOR_START = 7,
	MOVING_ON_LINE = 8,
	MID_AIR_COLLISION_AVOIDANCE = 9
}

InitState = States.INIT

FinishState = States.MOVING_ON_LINE

Subtasks = {
	ALTITUDE_VELOCITY_HOLDING_ABOVE_AROUND_TERRAIN = 1,
	FIRST_TURN = 2,
	LEFT_FINAL_TURN = 3,
	RIGHT_FINAL_TURN = 4,	
	FOLLOW_TO_FAR_POINT = 5,
	OLD_FOLLOW_LINE_PROCEDURE = 6,
	MOVING_ON_LINE = 7,
	MID_AIR_COLLISION_AVOIDANCE = 8
}

SubtasksByState = {
	[States.FIRST_TURN] = {Subtasks.ALTITUDE_VELOCITY_HOLDING_ABOVE_AROUND_TERRAIN, Subtasks.FIRST_TURN},
	[States.FIRST_TURN_LEFT_FINAL_TURN_MISSED] = {Subtasks.ALTITUDE_VELOCITY_HOLDING_ABOVE_AROUND_TERRAIN, Subtasks.FIRST_TURN},
	[States.FIRST_TURN_RIGHT_FINAL_TURN_MISSED] = {Subtasks.ALTITUDE_VELOCITY_HOLDING_ABOVE_AROUND_TERRAIN, Subtasks.FIRST_TURN},
	[States.LEFT_FINAL_TURN] = {Subtasks.ALTITUDE_VELOCITY_HOLDING_ABOVE_AROUND_TERRAIN, Subtasks.LEFT_FINAL_TURN},
	[States.RIGHT_FINAL_TURN] = {Subtasks.ALTITUDE_VELOCITY_HOLDING_ABOVE_AROUND_TERRAIN, Subtasks.RIGHT_FINAL_TURN},
	[States.NEAR_VECTOR_START] = {Subtasks.ALTITUDE_VELOCITY_HOLDING_ABOVE_AROUND_TERRAIN, Subtasks.MOVING_ON_LINE},
	[States.MOVING_ON_LINE] = {Subtasks.ALTITUDE_VELOCITY_HOLDING_ABOVE_AROUND_TERRAIN, Subtasks.MOVING_ON_LINE},
	[States.MID_AIR_COLLISION_AVOIDANCE] = {Subtasks.MID_AIR_COLLISION_AVOIDANCE}
}

FSM = {
	[States.INIT] = {
		{new_state = States.FIRST_TURN}
	},
	[States.FIRST_TURN] = {
		{condition = Conditions.IF_ON_DIRECTION_TO_LEFT_TURN_CIRCLE, new_state = States.LEFT_FINAL_TURN},
		{condition = Conditions.IF_ON_DIRECTION_TO_RIGHT_TURN_CIRCLE, new_state = States.RIGHT_FINAL_TURN},
		{condition = Conditions.IF_PLANE_AHEAD, new_state = States.MID_AIR_COLLISION_AVOIDANCE, action = 'PUSH' }
	},
	[States.LEFT_FINAL_TURN] = {
		{condition = {operator = "and", operands = {Conditions.IF_NEAR_VECTOR_START, Conditions.IF_ON_VECTOR}}, new_state = States.NEAR_VECTOR_START},
		{condition = Conditions.IF_PLANE_AHEAD, new_state = States.MID_AIR_COLLISION_AVOIDANCE, action = 'PUSH' }
	},
	[States.RIGHT_FINAL_TURN] = {
		{condition = {operator = "and", operands = {Conditions.IF_NEAR_VECTOR_START, Conditions.IF_ON_VECTOR}}, new_state = States.NEAR_VECTOR_START},
		{condition = Conditions.IF_PLANE_AHEAD, new_state = States.MID_AIR_COLLISION_AVOIDANCE, action = 'PUSH' }
	},
	[States.NEAR_VECTOR_START] = {
		{condition = {operator = "not", operand = Conditions.IF_NEAR_VECTOR_START}, new_state = States.MOVING_ON_LINE},
		{condition = {operator = "not", operand = Conditions.IF_ON_VECTOR}, new_state = States.FIRST_TURN},
		{condition = Conditions.IF_PLANE_AHEAD, new_state = States.MID_AIR_COLLISION_AVOIDANCE, action = 'PUSH' }
	},
	[States.MOVING_ON_LINE] = {
		{condition = {operator = "not", operand = Conditions.IF_ON_VECTOR}, new_state = States.FIRST_TURN},
		{condition = Conditions.IF_PLANE_AHEAD, new_state = States.MID_AIR_COLLISION_AVOIDANCE, action = 'PUSH' }
	},
	[States.MID_AIR_COLLISION_AVOIDANCE] = {
		{condition = {operator = "not", operand = Conditions.IF_PLANE_AHEAD}, action = 'POP' }
	}
}

if find_shortest_path then
	FSM[States.FIRST_TURN] = {
		{condition = {operator = "and", operands = {Conditions.IF_ON_DIRECTION_TO_LEFT_TURN_CIRCLE, Conditions.IF_LEFT_FINAL_CIRCLE_WAY_SHORTER}}, new_state = States.LEFT_FINAL_TURN},
		{condition = {operator = "and", operands = {Conditions.IF_ON_DIRECTION_TO_LEFT_TURN_CIRCLE, {operator = "not", operand = Conditions.IF_LEFT_FINAL_CIRCLE_WAY_SHORTER}}}, new_state = States.FIRST_TURN_LEFT_FINAL_TURN_MISSED},
		{condition = {operator = "and", operands = {Conditions.IF_ON_DIRECTION_TO_RIGHT_TURN_CIRCLE, {operator = "not", operand = Conditions.IF_LEFT_FINAL_CIRCLE_WAY_SHORTER}}}, new_state = States.RIGHT_FINAL_TURN},
		{condition = {operator = "and", operands = {Conditions.IF_ON_DIRECTION_TO_RIGHT_TURN_CIRCLE, Conditions.IF_LEFT_FINAL_CIRCLE_WAY_SHORTER}}, new_state = States.FIRST_TURN_RIGHT_FINAL_TURN_MISSED},
		{condition = Conditions.IF_PLANE_AHEAD, new_state = States.MID_AIR_COLLISION_AVOIDANCE, action = 'PUSH' }
	}
	FSM[States.FIRST_TURN_LEFT_FINAL_TURN_MISSED] = {
		{condition = Conditions.IF_ON_DIRECTION_TO_RIGHT_TURN_CIRCLE, new_state = States.RIGHT_FINAL_TURN},
		{condition = Conditions.IF_PLANE_AHEAD, new_state = States.MID_AIR_COLLISION_AVOIDANCE, action = 'PUSH' }
	}
	FSM[States.FIRST_TURN_RIGHT_FINAL_TURN_MISSED] = {
		{condition = Conditions.IF_ON_DIRECTION_TO_LEFT_TURN_CIRCLE, new_state = States.LEFT_FINAL_TURN},
		{condition = Conditions.IF_PLANE_AHEAD, new_state = States.MID_AIR_COLLISION_AVOIDANCE, action = 'PUSH' }
	}
end
