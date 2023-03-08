Conditions = {
	IF_SPECIAL_PSI_USE = 1,
	IF_ALTITUDE_WILL_BE_REACHED = 2,
	IF_OVER_TARGET = 3,
	IF_OVER_DISTANCE_AFTER_TURN_ON = 4,
	IF_ON_APPROACH_COURSE = 5,
	IF_ON_APPROACH_PATH = 6,
	IF_MINIMAL_ROLL = 7,
	IF_TURN_ON_TARGET_IMPOSSIBLE = 8, -- = !(IF_OVER_DISTANCE_AFTER_TURN_ON(distance = 0))
	IF_PLANE_AHEAD = 9,
	IF_JDAM_ATTACK = 10
}

DefaultConditionActualityPeriod = 1.0

ConditionActualityPeriods = {
	[Conditions.IF_SPECIAL_PSI_USE] = -1.0,
	[Conditions.IF_ALTITUDE_WILL_BE_REACHED] = 2.0,
	[Conditions.IF_OVER_TARGET] = 1.0,
	[Conditions.IF_OVER_DISTANCE_AFTER_TURN_ON] = 1.0,
	[Conditions.IF_ON_APPROACH_COURSE] = 0.1,
	[Conditions.IF_ON_APPROACH_PATH] = 0.2,
	[Conditions.IF_TURN_ON_TARGET_IMPOSSIBLE] = 1.0,
}

States = {
	INIT = 1,
	FOLLOW_VECTOR = 2,
	FOLLOW_VECTOR_RESTART = 3,
	BREAKAWAY = 4,
	MOVING_TO = 5,
	MID_AIR_COLLISION_AVOIDANCE = 6,
	FINAL = 7
}

InitState = States.INIT

FinishState = States.FINAL

Subtasks = {
	ALTITUDE_VELOCITY_HOLDING_ABOVE_TERRAIN = 1,
	ALTITUDE_VELOCITY_HOLDING = 2,
	VELOCITY_HOLDING = 3,
	TURN_OPTIMAL_VELOCITY_HOLDING = 4,
	ALTITUDE_STABILIZING = 5,
	FOLLOW_VECTOR = 6,
	FOLLOW_VECTOR_OLD = 7,
	BREAKAWAY = 8,
	MOVING_TO = 9,
	MID_AIR_COLLISION_AVOIDANCE = 10
}

SubtasksByState = {
	[States.FOLLOW_VECTOR] = {Subtasks.FOLLOW_VECTOR},
	[States.BREAKAWAY] = {Subtasks.ALTITUDE_VELOCITY_HOLDING_ABOVE_TERRAIN, Subtasks.BREAKAWAY},
	[States.MOVING_TO] = {Subtasks.TURN_OPTIMAL_VELOCITY_HOLDING, Subtasks.ALTITUDE_STABILIZING, Subtasks.MOVING_TO},
	[States.FINAL] = {Subtasks.ALTITUDE_VELOCITY_HOLDING, Subtasks.MOVING_TO},
	[States.MID_AIR_COLLISION_AVOIDANCE] = {Subtasks.MID_AIR_COLLISION_AVOIDANCE}
}

local use_old_follow_vector_procedure = true

if use_old_follow_vector_procedure then
	SubtasksByState[States.FOLLOW_VECTOR] = {Subtasks.FOLLOW_VECTOR_OLD}
end

SubtaskStates = {
	[Subtasks.FOLLOW_VECTOR] = {
		NEAR_VECTOR_START = 7
	},
	[Subtasks.FOLLOW_VECTOR_OLD] = {
		APPROACH_TO_VECTOR = 3,
		MOVING_ON_LINE = 4,
		MOVING_ON_LINE_WITHOUT_ROLL = 5,
		FINAL = 7
	}
}

DefaultPassCheckPeriod = 1.0

FSM = {
	[States.INIT] = {
		{condition = {operator = "and", operands = {	{operator = "not", operand = Conditions.IF_SPECIAL_PSI_USE},
															Conditions.IF_OVER_DISTANCE_AFTER_TURN_ON, Conditions.IF_ALTITUDE_WILL_BE_REACHED,Conditions.IF_JDAM_ATTACK}}, new_state = States.MOVING_TO},
		{condition = {operator = "and", operands = {Conditions.IF_SPECIAL_PSI_USE, {operator = "not", operand = Conditions.IF_ALTITUDE_WILL_BE_REACHED}}}, new_state = States.BREAKAWAY},
		{condition = Conditions.IF_SPECIAL_PSI_USE, new_state = States.FOLLOW_VECTOR},
		{condition = Conditions.IF_PLANE_AHEAD, new_state = States.MID_AIR_COLLISION_AVOIDANCE, action = 'PUSH' },
		{condition = {operator = "not", operand = Conditions.IF_SPECIAL_PSI_USE}, new_state = States.BREAKAWAY}
	},
	[States.BREAKAWAY] = {
		{condition = {operator = "and", operands = {	{operator = "not", operand = Conditions.IF_SPECIAL_PSI_USE},
															Conditions.IF_OVER_DISTANCE_AFTER_TURN_ON, Conditions.IF_ALTITUDE_WILL_BE_REACHED}}, new_state = States.MOVING_TO, period = 2.5},
		{condition = {operator = "and", operands = {Conditions.IF_SPECIAL_PSI_USE, Conditions.IF_ALTITUDE_WILL_BE_REACHED}}, new_state = States.FOLLOW_VECTOR, period = 2.5},
		{condition = Conditions.IF_PLANE_AHEAD, new_state = States.MID_AIR_COLLISION_AVOIDANCE, action = 'PUSH' },
	},
	[States.FOLLOW_VECTOR] = {
		{condition = {operator = "and", operands = {Conditions.IF_ON_APPROACH_PATH, Conditions.IF_MINIMAL_ROLL}}, new_state = States.FINAL, period = 2.0},
		{condition = {subtask = Subtasks.FOLLOW_VECTOR, status = SubtaskStates[Subtasks.FOLLOW_VECTOR].NEAR_VECTOR_START}, new_state = States.FINAL, period = 0.5}
	},
	[States.MOVING_TO] = {
		{condition = {operator = "and", operands = {Conditions.IF_ON_APPROACH_COURSE, Conditions.IF_MINIMAL_ROLL}}, new_state = States.FINAL, period = 1.0},
		{condition = Conditions.IF_OVER_TARGET, new_state = States.BREAKAWAY, period = 1.0},
		{condition = Conditions.IF_TURN_ON_TARGET_IMPOSSIBLE, new_state = States.BREAKAWAY, period = 1.0},
		{condition = Conditions.IF_PLANE_AHEAD, new_state = States.MID_AIR_COLLISION_AVOIDANCE, action = 'PUSH'},
	},
	[States.MID_AIR_COLLISION_AVOIDANCE] = {
		{condition = {operator = "not", operand = Conditions.IF_PLANE_AHEAD}, action = 'POP'}
	}
}

if use_old_follow_vector_procedure then
	FSM[States.FOLLOW_VECTOR] = {
		{condition = {operator = "and", operands = {Conditions.IF_ON_APPROACH_PATH, Conditions.IF_MINIMAL_ROLL}}, new_state = States.FINAL, period = 2.0},
		{condition = {operator = "and", operands = {
				{subtask = Subtasks.FOLLOW_VECTOR_OLD, status = {SubtaskStates[Subtasks.FOLLOW_VECTOR_OLD].APPROACH_TO_VECTOR, SubtaskStates[Subtasks.FOLLOW_VECTOR_OLD].MOVING_ON_LINE, SubtaskStates[Subtasks.FOLLOW_VECTOR_OLD].MOVING_ON_LINE_WITHOUT_ROLL, SubtaskStates[Subtasks.FOLLOW_VECTOR_OLD].FINAL}}, Conditions.IF_OVER_TARGET}}, new_state = States.FOLLOW_VECTOR_RESTART}
	}
	FSM[States.FOLLOW_VECTOR_RESTART] = {
		{new_state = States.FOLLOW_VECTOR, period = 0.05},
		{condition = Conditions.IF_PLANE_AHEAD, new_state = States.MID_AIR_COLLISION_AVOIDANCE, action = 'PUSH' }
	}
	FSM[States.FINAL] = {
		{condition = {operator = "and", operands = {
			{subtask = Subtasks.FOLLOW_VECTOR_OLD, status = {SubtaskStates[Subtasks.FOLLOW_VECTOR_OLD].APPROACH_TO_VECTOR, SubtaskStates[Subtasks.FOLLOW_VECTOR_OLD].MOVING_ON_LINE, SubtaskStates[Subtasks.FOLLOW_VECTOR_OLD].FINAL}}, Conditions.IF_OVER_TARGET}}, new_state = States.FOLLOW_VECTOR_RESTART},
		{condition = Conditions.IF_PLANE_AHEAD, new_state = States.MID_AIR_COLLISION_AVOIDANCE, action = 'PUSH' }
	}
end
