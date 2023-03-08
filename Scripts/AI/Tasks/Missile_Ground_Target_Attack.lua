local check_LOS_before_dive = true

--local check_dive_need = false

Conditions = {
	IF_FIRE_AND_FORGET_MISSILE = 1,
	IF_MISSILE_NEED_LOS = 2,
	IF_DIVE_NEED = 3,
	IF_CAN_DIVE = 4,
	IF_TARGET_LOS_PRESENT = 5,
	IF_ON_DIVE_START_POSITION = 6,
	IF_TARGET_ELEVATION_TOO_SMALL = 7,
	IF_MINIMAL_ROLL = 8,
	IF_MINIMAL_CLIMB = 9,
	IF_TOO_CLOSE = 10,
	IF_ON_LAUNCH_DISTANCE = 11,
	IF_ON_LAUNCH_DISTANCE_AFTER_DIVE_ON_TIME = 12,
	IF_TARGET_IN_MISSILE_ANGLES = 13,
	IF_TARGET_IN_MISSILE_ANGLES_IN_HOR_FLIGHT_AFTER_DIVE_ON_TIME = 14,
	IF_TARGET_IN_ANGLES = 15,
	IF_ON_BREAKAWAY_POSITION = 16,
	IF_TARGET_DESTROYED = 17,
	IF_TURN_TO_TARGET_IMPOSSIBLE = 18,
	IF_CAN_ATTACK_WITHOUT_BREAKAWAY = 19,
	IF_PLANE_AHEAD = 20
}

ConditionActualityPeriods = {}

States = {
	INIT = 1,
	APPROACHING = 2,
	MOVING_TO_TARGET_HOR = 3,
	MOVING_ON_TARGET = 4,
	MOVING_TO_TARGET_HOR_AND_MISSILE_FIRING = 5,
	MOVING_ON_TARGET_AND_MISSILE_FIRING = 6,
	MOVING_TO_TARGET_HOR_AND_TARGET_ILLUMINATION = 7,
	MOVING_ON_TARGET_AND_TARGET_ILLUMINATION = 8,
	WAITING_AFTER_LAUNCH = 9,
	MID_AIR_COLLISION_AVOIDANCE = 10,
	BREAKAWAY = 11
}

InitState = States.INIT

FinishState = States.BREAKAWAY

Subtasks = {
	APPROACHING = 1,
	ALTITUDE_VELOCITY_HOLDING = 2,
	VELOCITY_HOLDING = 3,	
	MOVING_TO_TARGET_HOR = 4,
	MOVING_ON_TARGET = 5,
	MISSILE_FIRING = 6,
	TIMER = 7,
	BREAKAWAY = 8,
	MID_AIR_COLLISION_AVOIDANCE = 9
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
	[Subtasks.TIMER] = {
		TIME_OVER = 3
	}
}

SubtasksByState = {
	[States.APPROACHING] = {Subtasks.APPROACHING},
	[States.MOVING_TO_TARGET_HOR] = {Subtasks.ALTITUDE_VELOCITY_HOLDING, Subtasks.MOVING_TO_TARGET_HOR},
	[States.MOVING_ON_TARGET] = {Subtasks.VELOCITY_HOLDING, Subtasks.MOVING_ON_TARGET},
	[States.MOVING_TO_TARGET_HOR_AND_MISSILE_FIRING] = {Subtasks.ALTITUDE_VELOCITY_HOLDING, Subtasks.MOVING_TO_TARGET_HOR, Subtasks.MISSILE_FIRING},
	[States.MOVING_ON_TARGET_AND_MISSILE_FIRING] = {Subtasks.VELOCITY_HOLDING, Subtasks.MOVING_ON_TARGET, Subtasks.MISSILE_FIRING},
	[States.MOVING_TO_TARGET_HOR_AND_TARGET_ILLUMINATION] = {Subtasks.ALTITUDE_VELOCITY_HOLDING, Subtasks.MOVING_TO_TARGET_HOR, Subtasks.MISSILE_FIRING},
	[States.MOVING_ON_TARGET_AND_TARGET_ILLUMINATION] = {Subtasks.VELOCITY_HOLDING, Subtasks.MOVING_ON_TARGET, Subtasks.MISSILE_FIRING},
	[States.WAITING_AFTER_LAUNCH] = {Subtasks.VELOCITY_HOLDING, Subtasks.MOVING_TO_TARGET_HOR, Subtasks.TIMER},
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
		--dive start
		{condition = {operator = "and", operands = {Conditions.IF_MINIMAL_ROLL, Conditions.IF_CAN_DIVE, Conditions.IF_DIVE_NEED, Conditions.IF_ON_DIVE_START_POSITION} }, new_state = States.MOVING_ON_TARGET},		
		{condition = {operator = "and", operands = {Conditions.IF_MINIMAL_ROLL, Conditions.IF_CAN_DIVE, {operator = "not", operand = Conditions.IF_DIVE_NEED}, Conditions.IF_ON_LAUNCH_DISTANCE_AFTER_DIVE_ON_TIME, {operator = "not", operand = Conditions.IF_TARGET_IN_MISSILE_ANGLES_IN_HOR_FLIGHT_AFTER_DIVE_ON_TIME} } }, new_state = States.MOVING_ON_TARGET},
		{condition = {operator = "and", operands = {Conditions.IF_MINIMAL_ROLL, Conditions.IF_CAN_DIVE, {operator = "not", operand = Conditions.IF_DIVE_NEED}, Conditions.IF_TARGET_ELEVATION_TOO_SMALL}}, new_state = States.MOVING_ON_TARGET},
		--launch in horizontal flight
		{condition = {operator = "and", operands = {Conditions.IF_MINIMAL_ROLL, Conditions.IF_MINIMAL_CLIMB, {operator = "not", operand = Conditions.IF_DIVE_NEED}, Conditions.IF_ON_LAUNCH_DISTANCE_AFTER_DIVE_ON_TIME, Conditions.IF_TARGET_IN_MISSILE_ANGLES_IN_HOR_FLIGHT_AFTER_DIVE_ON_TIME }}, new_state = States.MOVING_TO_TARGET_HOR_AND_MISSILE_FIRING},
		--Mid-air collision avoidance
		{condition = Conditions.IF_PLANE_AHEAD, new_state = States.MID_AIR_COLLISION_AVOIDANCE, action = 'PUSH' },
		--breakaway
		{condition = Conditions.IF_TOO_CLOSE, new_state = States.BREAKAWAY},
		{condition = Conditions.IF_TARGET_DESTROYED, new_state = States.BREAKAWAY},
		{condition = Conditions.IF_TURN_TO_TARGET_IMPOSSIBLE, new_state = States.BREAKAWAY}
	},
	[States.MOVING_ON_TARGET] = {
		{condition = {operator = "and", operands = {Conditions.IF_MINIMAL_ROLL, Conditions.IF_ON_LAUNCH_DISTANCE, Conditions.IF_TARGET_IN_MISSILE_ANGLES, Conditions.IF_TARGET_IN_ANGLES}}, new_state = States.MOVING_ON_TARGET_AND_MISSILE_FIRING},
		--Mid-air collision avoidance
		{condition = Conditions.IF_PLANE_AHEAD, new_state = States.MID_AIR_COLLISION_AVOIDANCE, action = 'PUSH' },
		--breakaway
		{condition = Conditions.IF_TOO_CLOSE, new_state = States.BREAKAWAY},
		{condition = Conditions.IF_TARGET_DESTROYED, new_state = States.BREAKAWAY},
		{condition = Conditions.IF_ON_BREAKAWAY_POSITION, new_state = States.BREAKAWAY},
		{condition = Conditions.IF_TURN_TO_TARGET_IMPOSSIBLE, new_state = States.BREAKAWAY}
	},
	[States.MOVING_TO_TARGET_HOR_AND_MISSILE_FIRING] = {
		--dive start
		{condition = {operator = "and", operands = {{subtask = Subtasks.MISSILE_FIRING, status = SubtaskStates[Subtasks.MISSILE_FIRING].LAUNCH_NOT_STARTED}, Conditions.IF_CAN_DIVE, Conditions.IF_MINIMAL_ROLL, {operator = "not", operand = Conditions.IF_TARGET_IN_MISSILE_ANGLES_IN_HOR_FLIGHT_AFTER_DIVE_ON_TIME} } }, new_state = States.MOVING_ON_TARGET},
		{condition = {operator = "and", operands = {Conditions.IF_CAN_DIVE, Conditions.IF_MINIMAL_ROLL, {operator = "not", operand = Conditions.IF_TARGET_IN_MISSILE_ANGLES_IN_HOR_FLIGHT_AFTER_DIVE_ON_TIME} } }, new_state = States.MOVING_ON_TARGET_AND_MISSILE_FIRING},
		--dive start
		{condition = {operator = "and", operands = {{subtask = Subtasks.MISSILE_FIRING, status = SubtaskStates[Subtasks.MISSILE_FIRING].LAUNCH_NOT_STARTED}, Conditions.IF_CAN_DIVE, Conditions.IF_MINIMAL_ROLL, Conditions.IF_TARGET_ELEVATION_TOO_SMALL } }, new_state = States.MOVING_ON_TARGET},
		{condition = {operator = "and", operands = {Conditions.IF_CAN_DIVE, Conditions.IF_MINIMAL_ROLL, Conditions.IF_TARGET_ELEVATION_TOO_SMALL } }, new_state = States.MOVING_ON_TARGET_AND_MISSILE_FIRING},			
		--after launch
		{condition = {operator = "and", operands = {{operator = "not", operand = Conditions.IF_FIRE_AND_FORGET_MISSILE}, {subtask = Subtasks.MISSILE_FIRING, status = SubtaskStates[Subtasks.MISSILE_FIRING].LAUNCH_FINISHED}}}, new_state = States.MOVING_TO_TARGET_HOR_AND_TARGET_ILLUMINATION},
		{condition = {operator = "and", operands = {Conditions.IF_FIRE_AND_FORGET_MISSILE, {subtask = Subtasks.MISSILE_FIRING, status = SubtaskStates[Subtasks.MISSILE_FIRING].LAUNCH_FINISHED}}}, new_state = States.WAITING_AFTER_LAUNCH},
		--Mid-air collision avoidance
		{condition = Conditions.IF_PLANE_AHEAD, new_state = States.MID_AIR_COLLISION_AVOIDANCE, action = 'PUSH' },
		--breakaway
		{condition = {operator = "and", operands = {Conditions.IF_TOO_CLOSE, {subtask = Subtasks.MISSILE_FIRING, status = SubtaskStates[Subtasks.MISSILE_FIRING].LAUNCH_NOT_STARTED}}}, new_state = States.BREAKAWAY},
		{condition = {operator = "and", operands = {Conditions.IF_TOO_CLOSE, {operator = "not", operand = Conditions.IF_FIRE_AND_FORGET_MISSILE}, {subtask = Subtasks.MISSILE_FIRING, status = SubtaskStates[Subtasks.MISSILE_FIRING].LAUNCH_IN_PROCESS}}}, new_state = States.MOVING_TO_TARGET_HOR_AND_TARGET_ILLUMINATION},		
		{condition = Conditions.IF_TARGET_DESTROYED, new_state = States.BREAKAWAY},
		[10] = {condition = Conditions.IF_ON_BREAKAWAY_POSITION, new_state = States.BREAKAWAY},
		[11] = {condition = Conditions.IF_TURN_TO_TARGET_IMPOSSIBLE, new_state = States.BREAKAWAY}
	},
	[States.MOVING_ON_TARGET_AND_MISSILE_FIRING] = {
		--after launch
		{condition = {operator = "and", operands = {{operator = "not", operand = Conditions.IF_FIRE_AND_FORGET_MISSILE}, {subtask = Subtasks.MISSILE_FIRING, status = SubtaskStates[Subtasks.MISSILE_FIRING].LAUNCH_FINISHED}}}, new_state = States.MOVING_ON_TARGET_AND_TARGET_ILLUMINATION},
		{condition = {operator = "and", operands = {Conditions.IF_FIRE_AND_FORGET_MISSILE, {subtask = Subtasks.MISSILE_FIRING, status = SubtaskStates[Subtasks.MISSILE_FIRING].LAUNCH_FINISHED}}}, new_state = States.WAITING_AFTER_LAUNCH},
		--Mid-air collision avoidance
		{condition = Conditions.IF_PLANE_AHEAD, new_state = States.MID_AIR_COLLISION_AVOIDANCE, action = 'PUSH' },		
		--breakaway
		{condition = {operator = "and", operands = {Conditions.IF_TOO_CLOSE, {subtask = Subtasks.MISSILE_FIRING, status = SubtaskStates[Subtasks.MISSILE_FIRING].LAUNCH_NOT_STARTED}}}, new_state = States.BREAKAWAY},
		{condition = {operator = "and", operands = {Conditions.IF_TOO_CLOSE, {operator = "not", operand = Conditions.IF_FIRE_AND_FORGET_MISSILE}, {subtask = Subtasks.MISSILE_FIRING, status = SubtaskStates[Subtasks.MISSILE_FIRING].LAUNCH_IN_PROCESS}}}, new_state = States.MOVING_ON_TARGET_AND_TARGET_ILLUMINATION},		
		{condition = Conditions.IF_TARGET_DESTROYED, new_state = States.BREAKAWAY},
		{condition = Conditions.IF_ON_BREAKAWAY_POSITION, new_state = States.BREAKAWAY},
		{condition = Conditions.IF_TURN_TO_TARGET_IMPOSSIBLE, new_state = States.BREAKAWAY}
	},
	[States.MOVING_TO_TARGET_HOR_AND_TARGET_ILLUMINATION] = {
		--dive start
		{condition = {operator = "and", operands = {Conditions.IF_CAN_DIVE, Conditions.IF_MINIMAL_ROLL, {operator = "not", operand = Conditions.IF_TARGET_IN_MISSILE_ANGLES_IN_HOR_FLIGHT_AFTER_DIVE_ON_TIME} } }, new_state = States.MOVING_ON_TARGET_AND_TARGET_ILLUMINATION},
		{condition = {operator = "and", operands = {Conditions.IF_MINIMAL_ROLL, Conditions.IF_CAN_DIVE, {operator = "not", operand = Conditions.IF_DIVE_NEED}, Conditions.IF_TARGET_ELEVATION_TOO_SMALL}}, new_state = States.MOVING_ON_TARGET_AND_TARGET_ILLUMINATION},
		--Mid-air collision avoidance
		{condition = Conditions.IF_PLANE_AHEAD, new_state = States.MID_AIR_COLLISION_AVOIDANCE, action = 'PUSH' },		
		--breakaway
		{condition = {subtask = Subtasks.MISSILE_FIRING, status = SubtaskStates[Subtasks.MISSILE_FIRING].LAST_MISSILE_IMPACT}, new_state = States.BREAKAWAY},
		{condition = Conditions.IF_TARGET_DESTROYED, new_state = States.BREAKAWAY},
		{condition = Conditions.IF_ON_BREAKAWAY_POSITION, new_state = States.BREAKAWAY},
		{condition = Conditions.IF_TURN_TO_TARGET_IMPOSSIBLE, new_state = States.BREAKAWAY}
	},
	[States.MOVING_ON_TARGET_AND_TARGET_ILLUMINATION] = {
		--Mid-air collision avoidance
		{condition = Conditions.IF_PLANE_AHEAD, new_state = States.MID_AIR_COLLISION_AVOIDANCE, action = 'PUSH' },	
		--breakaway
		{condition = {subtask = Subtasks.MISSILE_FIRING, status = SubtaskStates[Subtasks.MISSILE_FIRING].LAST_MISSILE_IMPACT}, new_state = States.BREAKAWAY},
		{condition = Conditions.IF_TARGET_DESTROYED, new_state = States.BREAKAWAY},
		{condition = Conditions.IF_ON_BREAKAWAY_POSITION, new_state = States.BREAKAWAY},
		{condition = Conditions.IF_TURN_TO_TARGET_IMPOSSIBLE, new_state = States.BREAKAWAY}
	},
	[States.WAITING_AFTER_LAUNCH] = {
		--Mid-air collision avoidance
		{condition = Conditions.IF_PLANE_AHEAD, new_state = States.MID_AIR_COLLISION_AVOIDANCE, action = 'PUSH' },
		{condition = {subtask = Subtasks.TIMER, status = SubtaskStates[Subtasks.TIMER].TIME_OVER}, new_state = States.BREAKAWAY}
	},
	[States.MID_AIR_COLLISION_AVOIDANCE] = {
		{condition = Conditions.IF_TARGET_DESTROYED, new_state = States.BREAKAWAY},
		{condition = {operator = "not", operand = Conditions.IF_PLANE_AHEAD}, action = 'POP' }
	}
}

if check_LOS_before_dive then
	FSM[States.MOVING_TO_TARGET_HOR][1] = {condition = {operator = "and", operands = {Conditions.IF_MINIMAL_ROLL, Conditions.IF_CAN_DIVE, Conditions.IF_DIVE_NEED, Conditions.IF_ON_DIVE_START_POSITION, {operator = "or", operands = {{operator = "not", operand = Conditions.IF_MISSILE_NEED_LOS}, {operator = "or", operands = {{operator = "not", operand = Conditions.IF_MISSILE_NEED_LOS}, Conditions.IF_TARGET_LOS_PRESENT}} }} } }, new_state = States.MOVING_ON_TARGET}
	FSM[States.MOVING_TO_TARGET_HOR][2] = {condition = {operator = "and", operands = {Conditions.IF_MINIMAL_ROLL, Conditions.IF_CAN_DIVE, {operator = "not", operand = Conditions.IF_DIVE_NEED}, Conditions.IF_ON_LAUNCH_DISTANCE_AFTER_DIVE_ON_TIME, {operator = "not", operand = Conditions.IF_TARGET_IN_MISSILE_ANGLES_IN_HOR_FLIGHT_AFTER_DIVE_ON_TIME}, {operator = "or", operands = {{operator = "not", operand = Conditions.IF_MISSILE_NEED_LOS}, Conditions.IF_TARGET_LOS_PRESENT}} } }, new_state = States.MOVING_ON_TARGET}
	FSM[States.MOVING_TO_TARGET_HOR][3] = {condition = {operator = "and", operands = {Conditions.IF_MINIMAL_ROLL, Conditions.IF_CAN_DIVE, {operator = "not", operand = Conditions.IF_DIVE_NEED}, Conditions.IF_TARGET_ELEVATION_TOO_SMALL, {operator = "or", operands = {{operator = "not", operand = Conditions.IF_MISSILE_NEED_LOS}, Conditions.IF_TARGET_LOS_PRESENT}}}}, new_state = States.MOVING_ON_TARGET}
	FSM[States.MOVING_TO_TARGET_HOR][4] = {condition = {operator = "and", operands = {Conditions.IF_MINIMAL_ROLL, Conditions.IF_MINIMAL_CLIMB, {operator = "not", operand = Conditions.IF_DIVE_NEED}, Conditions.IF_ON_LAUNCH_DISTANCE_AFTER_DIVE_ON_TIME, Conditions.IF_TARGET_IN_MISSILE_ANGLES_IN_HOR_FLIGHT_AFTER_DIVE_ON_TIME, {operator = "or", operands = {{operator = "not", operand = Conditions.IF_MISSILE_NEED_LOS}, Conditions.IF_TARGET_LOS_PRESENT}}}}, new_state = States.MOVING_TO_TARGET_HOR_AND_MISSILE_FIRING}
	--
	FSM[States.MOVING_TO_TARGET_HOR_AND_MISSILE_FIRING][1] = {condition = {operator = "and", operands = {{subtask = Subtasks.MISSILE_FIRING, status = SubtaskStates[Subtasks.MISSILE_FIRING].LAUNCH_NOT_STARTED}, Conditions.IF_CAN_DIVE, Conditions.IF_MINIMAL_ROLL, {operator = "not", operand = Conditions.IF_TARGET_IN_MISSILE_ANGLES_IN_HOR_FLIGHT_AFTER_DIVE_ON_TIME}, {operator = "or", operands = {{operator = "not", operand = Conditions.IF_MISSILE_NEED_LOS}, Conditions.IF_TARGET_LOS_PRESENT} }} }, new_state = States.MOVING_ON_TARGET}
	FSM[States.MOVING_TO_TARGET_HOR_AND_MISSILE_FIRING][2] = {condition = {operator = "and", operands = {Conditions.IF_CAN_DIVE, Conditions.IF_MINIMAL_ROLL, {operator = "not", operand = Conditions.IF_TARGET_IN_MISSILE_ANGLES_IN_HOR_FLIGHT_AFTER_DIVE_ON_TIME}, {operator = "or", operands = {{operator = "not", operand = Conditions.IF_MISSILE_NEED_LOS}, Conditions.IF_TARGET_LOS_PRESENT} } }}, new_state = States.MOVING_ON_TARGET_AND_MISSILE_FIRING}
	FSM[States.MOVING_TO_TARGET_HOR_AND_MISSILE_FIRING][3] = {condition = {operator = "and", operands = {{subtask = Subtasks.MISSILE_FIRING, status = SubtaskStates[Subtasks.MISSILE_FIRING].LAUNCH_NOT_STARTED}, Conditions.IF_CAN_DIVE, Conditions.IF_MINIMAL_ROLL, Conditions.IF_TARGET_ELEVATION_TOO_SMALL, {operator = "or", operands = {{operator = "not", operand = Conditions.IF_MISSILE_NEED_LOS}, Conditions.IF_TARGET_LOS_PRESENT} } } }, new_state = States.MOVING_ON_TARGET}
	FSM[States.MOVING_TO_TARGET_HOR_AND_MISSILE_FIRING][4] = {condition = {operator = "and", operands = {Conditions.IF_CAN_DIVE, Conditions.IF_MINIMAL_ROLL, Conditions.IF_TARGET_ELEVATION_TOO_SMALL, {operator = "or", operands = {{operator = "not", operand = Conditions.IF_MISSILE_NEED_LOS}, Conditions.IF_TARGET_LOS_PRESENT} } } }, new_state = States.MOVING_ON_TARGET_AND_MISSILE_FIRING}
	--
	FSM[States.MOVING_TO_TARGET_HOR_AND_TARGET_ILLUMINATION][1] = {condition = {operator = "and", operands = {Conditions.IF_CAN_DIVE, Conditions.IF_MINIMAL_ROLL, {operator = "not", operand = Conditions.IF_TARGET_IN_MISSILE_ANGLES_IN_HOR_FLIGHT_AFTER_DIVE_ON_TIME}, {operator = "or", operands = {{operator = "not", operand = Conditions.IF_MISSILE_NEED_LOS}, Conditions.IF_TARGET_LOS_PRESENT}} } }, new_state = States.MOVING_ON_TARGET_AND_TARGET_ILLUMINATION}
	FSM[States.MOVING_TO_TARGET_HOR_AND_TARGET_ILLUMINATION][2] = {condition = {operator = "and", operands = {Conditions.IF_MINIMAL_ROLL, Conditions.IF_CAN_DIVE, {operator = "not", operand = Conditions.IF_DIVE_NEED}, Conditions.IF_TARGET_ELEVATION_TOO_SMALL, {operator = "or", operands = {{operator = "not", operand = Conditions.IF_MISSILE_NEED_LOS}, Conditions.IF_TARGET_LOS_PRESENT}}}}, new_state = States.MOVING_ON_TARGET_AND_TARGET_ILLUMINATION}
end
