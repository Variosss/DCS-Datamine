local check_LOS_before_dive = true

Conditions = {
	ON_DIVE_START_DISTANCE = 1,
	IF_TARGET_LOS_PRESENT = 2,
	ON_AIM_DISTANCE = 3,
	ON_FIRE_DISTANCE = 4,
	ON_BREAKAWAY_POSITION = 5,
	IF_NO_AMMO = 6,
	IF_TARGET_DESTROYED = 7,
	IF_GROUND_PROXIMITY = 8,
	IF_TURN_TO_TARGET_IMPOSSIBLE = 9,
	IF_CAN_ATTACK_WITHOUT_BREAKAWAY = 10,
	IF_PLANE_AHEAD = 11
}

ConditionActualityPeriods = {}

States = {
	INIT = 1,
	APPROACHING = 2,
	MOVING_TO_TARGET_HOR = 3,
	MOVING_ON_TARGET = 4,
	AIMING = 5,
	AIMING_AND_FIRING = 6,
	MID_AIR_COLLISION_AVOIDANCE = 7,
	BREAKAWAY = 8
}

InitState = States.INIT

FinishState = States.BREAKAWAY

Subtasks = {
	ALTITUDE_VELOCITY_HOLDING = 1,
	VELOCITY_HOLDING = 2,
	APPROACHING = 3,
	MOVING_TO_TARGET_HOR = 4,
	MOVING_ON_TARGET = 5,
	GUN_AIMING = 6,
	GUN_FIRING = 7,
	BREAKAWAY = 8,
	MID_AIR_COLLISION_AVOIDANCE = 9
}

SubtasksByState = {
	[States.APPROACHING] = {Subtasks.APPROACHING},
	[States.MOVING_TO_TARGET_HOR] = {Subtasks.ALTITUDE_VELOCITY_HOLDING, Subtasks.MOVING_TO_TARGET_HOR},
	[States.MOVING_ON_TARGET] = {Subtasks.VELOCITY_HOLDING, Subtasks.MOVING_ON_TARGET},
	[States.AIMING] = {Subtasks.VELOCITY_HOLDING, Subtasks.GUN_AIMING},
	[States.AIMING_AND_FIRING] = {Subtasks.VELOCITY_HOLDING, Subtasks.GUN_AIMING, Subtasks.GUN_FIRING},
	[States.BREAKAWAY] = {Subtasks.ALTITUDE_VELOCITY_HOLDING, Subtasks.BREAKAWAY},
	[States.MID_AIR_COLLISION_AVOIDANCE] = {Subtasks.MID_AIR_COLLISION_AVOIDANCE}
}

SubtaskStates = {
	[Subtasks.APPROACHING] = {
		FINAL = 7
	},
	[Subtasks.GUN_FIRING] = {
		FIRING_IN_PROCESS = 2,
		FIRING_FINISHED = 3
	}
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
		{condition = {Conditions.ON_DIVE_START_DISTANCE}, new_state = States.MOVING_ON_TARGET},
		{condition = Conditions.IF_PLANE_AHEAD, new_state = States.MID_AIR_COLLISION_AVOIDANCE, action = 'PUSH' },
		{condition = Conditions.IF_TARGET_DESTROYED, new_state = States.BREAKAWAY},
		{condition = Conditions.IF_TURN_TO_TARGET_IMPOSSIBLE, new_state = States.BREAKAWAY}
	},
	[States.MOVING_ON_TARGET] = {
		{condition = Conditions.ON_AIM_DISTANCE, new_state = States.AIMING},
		{condition = Conditions.IF_PLANE_AHEAD, new_state = States.MID_AIR_COLLISION_AVOIDANCE, action = 'PUSH' },
		{condition = Conditions.ON_BREAKAWAY_POSITION, new_state = States.BREAKAWAY},
		{condition = Conditions.IF_TARGET_DESTROYED, new_state = States.BREAKAWAY},
		{condition = Conditions.IF_TURN_TO_TARGET_IMPOSSIBLE, new_state = States.BREAKAWAY}
	},
	[States.AIMING] = {
		{condition = Conditions.ON_FIRE_DISTANCE, new_state = States.AIMING_AND_FIRING},
		{condition = Conditions.IF_PLANE_AHEAD, new_state = States.MID_AIR_COLLISION_AVOIDANCE, action = 'PUSH' },
		{condition = Conditions.ON_BREAKAWAY_POSITION, new_state = States.BREAKAWAY},		
		{condition = Conditions.IF_TARGET_DESTROYED, new_state = States.BREAKAWAY},
		{condition = Conditions.IF_TURN_TO_TARGET_IMPOSSIBLE, new_state = States.BREAKAWAY}		
	},
	[States.AIMING_AND_FIRING] = {
		{condition = Conditions.IF_PLANE_AHEAD, new_state = States.MID_AIR_COLLISION_AVOIDANCE, action = 'PUSH' },
		{condition = {operator = "or", operands = {{subtask = Subtasks.GUN_FIRING, status = SubtaskStates[Subtasks.GUN_FIRING].FIRING_FINISHED} ,Conditions.ON_BREAKAWAY_POSITION}}, new_state = States.BREAKAWAY},		
		{condition = Conditions.IF_NO_AMMO, new_state = States.BREAKAWAY},
		{condition = Conditions.ON_BREAKAWAY_POSITION, new_state = States.BREAKAWAY},
		{condition = Conditions.IF_TARGET_DESTROYED, new_state = States.BREAKAWAY},
		{condition = Conditions.IF_GROUND_PROXIMITY, new_state = States.BREAKAWAY},
		{condition = Conditions.IF_TURN_TO_TARGET_IMPOSSIBLE, new_state = States.BREAKAWAY}		
	},
	[States.MID_AIR_COLLISION_AVOIDANCE] = {
		{condition = Conditions.IF_TARGET_DESTROYED, new_state = States.BREAKAWAY},
		{condition = Conditions.ON_BREAKAWAY_POSITION, new_state = States.BREAKAWAY},
		{condition = {operator = "not", operand = Conditions.IF_PLANE_AHEAD}, action = 'POP' }
	}
}

if check_LOS_before_dive then
	FSM[States.MOVING_TO_TARGET_HOR][1] = {condition = {operator = "and", operands = {Conditions.ON_DIVE_START_DISTANCE, Conditions.IF_TARGET_LOS_PRESENT}}, new_state = States.MOVING_ON_TARGET}
end
