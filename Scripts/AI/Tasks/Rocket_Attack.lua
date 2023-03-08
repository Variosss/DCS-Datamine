local check_LOS_before_dive = true

Conditions = {
	ON_DIVE_START_POSITION = 1,
	IF_TARGET_LOS_PRESENT = 2,
	ON_DIRECTION_TO_TARGET = 3,
	IF_MINIMAL_ROLL = 4,
	IF_LINE_RELEASE = 5,
	ON_AIMING_POSITION = 6,
	ON_FIRE_POSITION = 7,
	ON_BREAKAWAY_POSITION = 8,
	IF_SIGHT_READY = 9,
	IF_TARGET_DESTROYED = 10,
	IF_GROUND_PROXIMITY = 11,
	IF_MINIMAL_CLIMB = 12,
	ON_OVER_DISTANCE = 13,
	IF_DIVING_BEFORE_AIMING = 14,
	IF_TURN_TO_TARGET_IMPOSSIBLE = 15,
	IF_CAN_ATTACK_WITHOUT_BREAKAWAY = 16,
	IF_PLANE_AHEAD = 17
}

ConditionActualityPeriods = {}

States = {
	INIT = 1,
	APPROACHING = 2,
	MOVING_TO_TARGET_HOR = 3,
	MOVING_ON_TARGET = 4,	
	MOVING_ON_TARGET_AND_WAITING_FOR_SIGHT = 5,
	AIMING_DIR = 6,
	AIMING_AND_FIRING = 7,
	ALTITUDE_STABILIZING_AND_FIRING = 8,
	ALTITUDE_STABILIZING = 9,
	KEEP_AIMING_AFTER_FIRING = 10,
	MID_AIR_COLLISION_AVOIDANCE = 11,
	BREAKAWAY = 12
}

InitState = States.INIT

FinishState = States.BREAKAWAY

Subtasks = {
	ALTITUDE_VELOCITY_HOLDING = 1,
	ALTITUDE_STABILIZING = 2,
	VELOCITY_HOLDING = 3,
	MIN_VELOCITY_HOLDING = 4,
	ATTACK_COURSE_HOLDING = 5,
	APPROACHING = 6,
	MOVING_TO_TARGET_HOR = 7,
	MOVING_ON_TARGET = 8,
	MOVING_ON_TARGET_AND_SIGHT_ACTIVATION = 9,
	AIMING_DIR = 10,
	FIRING = 11,
	TIMER = 12,
	BREAKAWAY = 13
}

SubtaskStates = {
	[Subtasks.APPROACHING] = {
		FINAL = 7
	},
	[Subtasks.FIRING] = {
		RELEASE_IN_PROCESS = 2,
		RELEASE_FINISHED = 3
	},
	[Subtasks.TIMER] = {
		TIME_OVER = 3
	},
}

SubtasksByState = {
	[States.APPROACHING] = {Subtasks.APPROACHING},	
	[States.MOVING_TO_TARGET_HOR] = {Subtasks.ALTITUDE_VELOCITY_HOLDING, Subtasks.MOVING_TO_TARGET_HOR},
	[States.MOVING_ON_TARGET] = {Subtasks.VELOCITY_HOLDING, Subtasks.MOVING_ON_TARGET},
	[States.MOVING_ON_TARGET_AND_WAITING_FOR_SIGHT] = {Subtasks.VELOCITY_HOLDING, Subtasks.MOVING_ON_TARGET_AND_SIGHT_ACTIVATION},
	[States.AIMING_DIR] = {Subtasks.VELOCITY_HOLDING, Subtasks.AIMING_DIR},	
	[States.AIMING_AND_FIRING] = {Subtasks.VELOCITY_HOLDING, Subtasks.AIMING_DIR, Subtasks.FIRING},	
	[States.ALTITUDE_STABILIZING] = {Subtasks.VELOCITY_HOLDING, Subtasks.ATTACK_COURSE_HOLDING, Subtasks.ALTITUDE_STABILIZING},
	[States.ALTITUDE_STABILIZING_AND_FIRING] = {Subtasks.VELOCITY_HOLDING, Subtasks.ATTACK_COURSE_HOLDING, Subtasks.ALTITUDE_STABILIZING, Subtasks.FIRING},	
	[States.KEEP_AIMING_AFTER_FIRING] = {Subtasks.VELOCITY_HOLDING, Subtasks.TIMER},
	[States.BREAKAWAY] = {Subtasks.ALTITUDE_VELOCITY_HOLDING, Subtasks.BREAKAWAY},
	[States.MID_AIR_COLLISION_AVOIDANCE] = {Subtasks.MID_AIR_COLLISION_AVOIDANCE}
}

FSM = {
	[States.INIT] = {
		{condition = Conditions.IF_CAN_ATTACK_WITHOUT_BREAKAWAY, new_state = States.MOVING_TO_TARGET_HOR},
		{new_state = States.APPROACHING}
	},
	[States.APPROACHING] = {
		{condition = {subtask = Subtasks.APPROACHING, status = SubtaskStates[Subtasks.APPROACHING].FINAL}, new_state = States.MOVING_TO_TARGET_HOR},
		{condition = Conditions.IF_TARGET_DESTROYED, new_state = States.BREAKAWAY}
	},
	[States.MOVING_TO_TARGET_HOR] = {
		{condition = {operator = "and", operands = {Conditions.IF_MINIMAL_ROLL, Conditions.IF_DIVING_BEFORE_AIMING, Conditions.ON_DIVE_START_POSITION}}, new_state = States.MOVING_ON_TARGET},
		{condition = {operator = "and", operands = {Conditions.IF_MINIMAL_ROLL, {operator = "not", operand = Conditions.IF_DIVING_BEFORE_AIMING}, Conditions.ON_DIVE_START_POSITION}}, new_state = States.AIMING_DIR},
		{condition = Conditions.IF_PLANE_AHEAD, new_state = States.MID_AIR_COLLISION_AVOIDANCE, action = 'PUSH' },
		{condition = Conditions.IF_TARGET_DESTROYED, new_state = States.BREAKAWAY},
		{condition = Conditions.IF_TURN_TO_TARGET_IMPOSSIBLE, new_state = States.BREAKAWAY}
	},
	[States.MOVING_ON_TARGET] = {
		{condition = {operator = "and", operands = {Conditions.ON_DIRECTION_TO_TARGET, Conditions.ON_AIMING_POSITION}}, new_state = States.MOVING_ON_TARGET_AND_WAITING_FOR_SIGHT},
		{condition = Conditions.IF_PLANE_AHEAD, new_state = States.MID_AIR_COLLISION_AVOIDANCE, action = 'PUSH' },
		{condition = Conditions.ON_BREAKAWAY_POSITION, new_state = States.BREAKAWAY},
		{condition = Conditions.IF_TARGET_DESTROYED, new_state = States.BREAKAWAY},
		{condition = Conditions.IF_TURN_TO_TARGET_IMPOSSIBLE, new_state = States.BREAKAWAY}
	},
	[States.MOVING_ON_TARGET_AND_WAITING_FOR_SIGHT] = {
		{condition = Conditions.IF_SIGHT_READY, new_state = States.AIMING_DIR},
		{condition = Conditions.IF_PLANE_AHEAD, new_state = States.MID_AIR_COLLISION_AVOIDANCE, action = 'PUSH' },
		{condition = Conditions.ON_BREAKAWAY_POSITION, new_state = States.BREAKAWAY},
		{condition = Conditions.IF_TARGET_DESTROYED, new_state = States.BREAKAWAY},
		{condition = Conditions.IF_TURN_TO_TARGET_IMPOSSIBLE, new_state = States.BREAKAWAY}
	},
	[States.AIMING_DIR] = {
		{condition = Conditions.ON_FIRE_POSITION, new_state = States.AIMING_AND_FIRING},
		{condition = Conditions.IF_PLANE_AHEAD, new_state = States.MID_AIR_COLLISION_AVOIDANCE, action = 'PUSH' },
		{condition = Conditions.ON_BREAKAWAY_POSITION, new_state = States.BREAKAWAY},
		{condition = Conditions.IF_TARGET_DESTROYED, new_state = States.BREAKAWAY},
		{condition = Conditions.IF_TURN_TO_TARGET_IMPOSSIBLE, new_state = States.BREAKAWAY}
	},
	[States.AIMING_AND_FIRING] = {
		{condition = {operator = "and", operands = {Conditions.IF_LINE_RELEASE, {subtask = Subtasks.FIRING, status = SubtaskStates[Subtasks.FIRING].RELEASE_IN_PROCESS}}}, new_state = States.BREAKAWAY},
		{condition = {subtask = Subtasks.FIRING, status = SubtaskStates[Subtasks.FIRING].RELEASE_FINISHED}, new_state = States.KEEP_AIMING_AFTER_FIRING},
		{condition = Conditions.IF_PLANE_AHEAD, new_state = States.MID_AIR_COLLISION_AVOIDANCE, action = 'PUSH' },
		{condition = Conditions.ON_BREAKAWAY_POSITION, new_state = States.BREAKAWAY},
		{condition = Conditions.IF_TARGET_DESTROYED, new_state = States.BREAKAWAY},
		{condition = Conditions.IF_GROUND_PROXIMITY, new_state = States.BREAKAWAY},
		{condition = Conditions.IF_TURN_TO_TARGET_IMPOSSIBLE, new_state = States.BREAKAWAY}
	},
	[States.KEEP_AIMING_AFTER_FIRING] = {
		{condition = Conditions.IF_PLANE_AHEAD, new_state = States.MID_AIR_COLLISION_AVOIDANCE, action = 'PUSH' },
		{condition = {subtask = Subtasks.TIMER, status = SubtaskStates[Subtasks.TIMER].TIME_OVER}, new_state = States.BREAKAWAY},
		{condition = Conditions.ON_BREAKAWAY_POSITION, new_state = States.BREAKAWAY},
		{condition = Conditions.IF_TARGET_DESTROYED, new_state = States.BREAKAWAY},
		{condition = Conditions.IF_TURN_TO_TARGET_IMPOSSIBLE, new_state = States.BREAKAWAY}
	},
	[States.ALTITUDE_STABILIZING_AND_FIRING] = {
		{condition = Conditions.IF_PLANE_AHEAD, new_state = States.MID_AIR_COLLISION_AVOIDANCE, action = 'PUSH' },
		{condition = {subtask = Subtasks.FIRING, status = SubtaskStates[Subtasks.FIRING].RELEASE_FINISHED}, new_state = States.BREAKAWAY},
		{condition = Conditions.ON_BREAKAWAY_POSITION, new_state = States.BREAKAWAY},
		{condition = Conditions.IF_TARGET_DESTROYED, new_state = States.BREAKAWAY},
		{condition = Conditions.IF_GROUND_PROXIMITY, new_state = States.BREAKAWAY},
	},
	[States.ALTITUDE_STABILIZING] = {
		{condition = Conditions.IF_PLANE_AHEAD, new_state = States.MID_AIR_COLLISION_AVOIDANCE, action = 'PUSH' },
		{condition = Conditions.IF_MINIMAL_CLIMB, new_state = States.BREAKAWAY},
		{condition = Conditions.IF_TARGET_DESTROYED, new_state = States.BREAKAWAY}
	},
	[States.MID_AIR_COLLISION_AVOIDANCE] = {
		{condition = Conditions.IF_TARGET_DESTROYED, new_state = States.BREAKAWAY},
		{condition = {operator = "not", operand = Conditions.IF_PLANE_AHEAD}, action = 'POP' }
	}
}

local height_stabilizing_on_final = false

if height_stabilizing_on_final then
	FSM[States.AIMING_DIR][2] = {condition = Conditions.ON_BREAKAWAY_POSITION, new_state = States.ALTITUDE_STABILIZING}
	FSM[States.AIMING_AND_FIRING][3] =  {condition = Conditions.ON_BREAKAWAY_POSITION, new_state = States.ALTITUDE_STABILIZING}
	FSM[States.KEEP_AIMING_AFTER_FIRING][1] = {condition = {subtask = Subtasks.TIMER, status = SubtaskStates[Subtasks.TIMER].TIME_OVER}, new_state = States.ALTITUDE_STABILIZING}
	FSM[States.KEEP_AIMING_AFTER_FIRING][2] = {condition = Conditions.ON_BREAKAWAY_POSITION, new_state = States.ALTITUDE_STABILIZING}
	FSM[States.ALTITUDE_STABILIZING_AND_FIRING][1] = {condition = {subtask = Subtasks.FIRING, status = SubtaskStates[Subtasks.FIRING].RELEASE_FINISHED}, new_state = States.ALTITUDE_STABILIZING}
	FSM[States.ALTITUDE_STABILIZING_AND_FIRING][2] = {condition = Conditions.ON_BREAKAWAY_POSITION, new_state = States.ALTITUDE_STABILIZING}
end

if check_LOS_before_dive then
	FSM[States.MOVING_TO_TARGET_HOR][1] = {condition = {operator = "and", operands = {Conditions.IF_MINIMAL_ROLL, Conditions.IF_DIVING_BEFORE_AIMING, Conditions.ON_DIVE_START_POSITION, Conditions.IF_TARGET_LOS_PRESENT}}, new_state = States.MOVING_ON_TARGET}
	FSM[States.MOVING_TO_TARGET_HOR][2] = {condition = {operator = "and", operands = {Conditions.IF_MINIMAL_ROLL, {operator = "not", operand = Conditions.IF_DIVING_BEFORE_AIMING}, Conditions.ON_DIVE_START_POSITION, Conditions.IF_TARGET_LOS_PRESENT}}, new_state = States.AIMING_DIR}
end
