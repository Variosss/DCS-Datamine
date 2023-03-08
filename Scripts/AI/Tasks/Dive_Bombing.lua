HOR_AND_VER_AIMING = 1
AIMING_DIR = 2
ONLY_HOR_AIMING_AND_DIVING = 3

local dive_bombing_logic = ONLY_HOR_AIMING_AND_DIVING

Conditions = {
	ON_DIVE_START_POSITION = 1,
	ON_TARGET_DIVE_ANGLE = 2,
	ON_DIVE_ANGLE = 3,
	IF_MINIMAL_ROLL = 4,
	IF_LINE_RELEASE = 5,
	ON_RELEASE_POSITION = 6,
	ON_BREAKAWAY_POSITION = 7,
	IF_TARGET_DESTROYED = 8,
	IF_GROUND_PROXIMITY = 9,
	IF_MINIMAL_CLIMB = 10,
	ON_OVER_DISTANCE = 11,
	IF_DIVING_BEFORE_AIMING = 12,
	IF_TARGET_IN_SIGHT = 13,
	IF_HIGHER_THAN_TARGET = 14,
	IF_IMPACT_POINT_OVER_TARGET = 15,
	IF_TURN_TO_TARGET_IMPOSSIBLE = 16,
	IF_PLANE_AHEAD = 17
}

ConditionActualityPeriods = {}

States = {
	INIT = 1,
	APPROACHING = 2,
	HOR_AIMING = 3,
	DIVING = 4,
	AIMING = 5,
	AIMING_AND_BOMBING = 6,
	ALTITUDE_STABILIZING_AND_BOMBING = 7,
	ALTITUDE_STABILIZING = 8,
	MID_AIR_COLLISION_AVOIDANCE = 9,
	BREAKAWAY = 10
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
	HOR_AIMING = 7,
	DIVING = 8,
	KEEP_DIVING = 9,
	VER_AIMING = 10,
	VER_AIMING2 = 11,
	AIMING_DIR = 12,
	BOMBING = 13,
	BOMBING2 = 14,
	ZERO_ROLL_STABILIZING = 15,
	BREAKAWAY = 16,
	MID_AIR_COLLISION_AVOIDANCE = 17
}

SubtaskStates = {
	[Subtasks.APPROACHING] = {
		FINAL = 7
	},
	[Subtasks.BOMBING] = {
		RELEASE_IN_PROCESS = 2,
		RELEASE_FINISHED = 3
	},
	[Subtasks.BOMBING2] = {
		RELEASE_IN_PROCESS = 2,
		RELEASE_FINISHED = 3
	},
	[Subtasks.VER_AIMING2] = {
		TARGET_IN_SIGHT = 2
	}
}

SubtasksByState = {
	[States.APPROACHING] = {Subtasks.APPROACHING},	
	[States.HOR_AIMING] = {Subtasks.HOR_AIMING, Subtasks.ALTITUDE_VELOCITY_HOLDING},
	[States.DIVING] = {Subtasks.MIN_VELOCITY_HOLDING, Subtasks.HOR_AIMING, Subtasks.DIVING},
	[States.AIMING] = {Subtasks.MIN_VELOCITY_HOLDING, Subtasks.HOR_AIMING, Subtasks.VER_AIMING},
	[States.AIMING_AND_BOMBING] = {Subtasks.MIN_VELOCITY_HOLDING, Subtasks.HOR_AIMING, Subtasks.VER_AIMING, Subtasks.BOMBING},
	[States.ALTITUDE_STABILIZING] = {Subtasks.MIN_VELOCITY_HOLDING, Subtasks.ATTACK_COURSE_HOLDING, Subtasks.ALTITUDE_STABILIZING},
	[States.ALTITUDE_STABILIZING_AND_BOMBING] = {Subtasks.MIN_VELOCITY_HOLDING, Subtasks.ATTACK_COURSE_HOLDING, Subtasks.ALTITUDE_STABILIZING, Subtasks.BOMBING},	
	[States.BREAKAWAY] = {Subtasks.ALTITUDE_VELOCITY_HOLDING, Subtasks.BREAKAWAY},
	[States.MID_AIR_COLLISION_AVOIDANCE] = {Subtasks.MID_AIR_COLLISION_AVOIDANCE}
}

if dive_bombing_logic == HOR_AND_VER_AIMING then
	SubtasksByState[States.DIVING] = {Subtasks.MIN_VELOCITY_HOLDING, Subtasks.HOR_AIMING, Subtasks.DIVING}
	local roll_stabilizing_while_diving = false
	if roll_stabilizing_while_diving then
		SubtasksByState[States.AIMING] = {Subtasks.MIN_VELOCITY_HOLDING, Subtasks.ZERO_ROLL_STABILIZING, Subtasks.VER_AIMING}
		SubtasksByState[States.AIMING_AND_BOMBING] = {Subtasks.MIN_VELOCITY_HOLDING, Subtasks.ZERO_ROLL_STABILIZING, Subtasks.VER_AIMING, Subtasks.BOMBING}
	else
		SubtasksByState[States.AIMING] = {Subtasks.MIN_VELOCITY_HOLDING, Subtasks.HOR_AIMING, Subtasks.VER_AIMING}
		SubtasksByState[States.AIMING_AND_BOMBING] = {Subtasks.MIN_VELOCITY_HOLDING, Subtasks.HOR_AIMING, Subtasks.VER_AIMING, Subtasks.BOMBING}
	end	
elseif dive_bombing_logic == AIMING_DIR then
	SubtasksByState[States.DIVING] = {Subtasks.MIN_VELOCITY_HOLDING, Subtasks.HOR_AIMING, Subtasks.DIVING}
	SubtasksByState[States.AIMING] = {Subtasks.MIN_VELOCITY_HOLDING, Subtasks.AIMING_DIR}
	SubtasksByState[States.AIMING_AND_BOMBING] = {Subtasks.MIN_VELOCITY_HOLDING, Subtasks.AIMING_DIR, Subtasks.BOMBING}
elseif dive_bombing_logic == ONLY_HOR_AIMING_AND_DIVING then
	local place_IP_behind_target = false
	if place_IP_behind_target then
		SubtasksByState[States.AIMING] = {Subtasks.MIN_VELOCITY_HOLDING, Subtasks.HOR_AIMING, Subtasks.VER_AIMING2}
		SubtasksByState[States.AIMING_AND_BOMBING] = {Subtasks.MIN_VELOCITY_HOLDING, Subtasks.HOR_AIMING, Subtasks.KEEP_DIVING, Subtasks.BOMBING2}
	else
		SubtasksByState[States.AIMING] = {Subtasks.VELOCITY_HOLDING, Subtasks.HOR_AIMING, Subtasks.DIVING}
		SubtasksByState[States.AIMING_AND_BOMBING] = {Subtasks.VELOCITY_HOLDING, Subtasks.HOR_AIMING, Subtasks.DIVING, Subtasks.BOMBING2}
	end
	SubtasksByState[States.ALTITUDE_STABILIZING_AND_BOMBING] = {Subtasks.VELOCITY_HOLDING, Subtasks.ATTACK_COURSE_HOLDING, Subtasks.ALTITUDE_STABILIZING, Subtasks.BOMBING2}
end

if dive_bombing_logic == HOR_AND_VER_AIMING then
	FSM = {
		[States.INIT] = {
			{new_state = States.APPROACHING}
		},
		[States.APPROACHING] = {
			{condition = {subtask = Subtasks.APPROACHING, status = SubtaskStates[Subtasks.APPROACHING].FINAL}, new_state = States.HOR_AIMING},
			{condition = Conditions.IF_TARGET_DESTROYED, new_state = States.BREAKAWAY},
		},	
		[States.HOR_AIMING] = {
			{condition = {operator = "and", operands = {Conditions.IF_MINIMAL_ROLL, Conditions.ON_DIVE_START_POSITION, Conditions.IF_DIVING_BEFORE_AIMING}}, new_state = States.DIVING},
			{condition = {operator = "and", operands = {Conditions.IF_MINIMAL_ROLL, Conditions.ON_DIVE_START_POSITION, {operator = "not", operand = Conditions.IF_DIVING_BEFORE_AIMING}}}, new_state = States.AIMING},
			{condition = Conditions.IF_PLANE_AHEAD, new_state = States.MID_AIR_COLLISION_AVOIDANCE, action = 'PUSH' },
			{condition = Conditions.IF_TARGET_DESTROYED, new_state = States.BREAKAWAY}
		},
		[States.DIVING] = {
			{condition = Conditions.ON_TARGET_DIVE_ANGLE, new_state = States.AIMING},
			{condition = Conditions.IF_PLANE_AHEAD, new_state = States.MID_AIR_COLLISION_AVOIDANCE, action = 'PUSH' },
			{condition = Conditions.ON_BREAKAWAY_POSITION, new_state = States.BREAKAWAY},
			{condition = Conditions.IF_TARGET_DESTROYED, new_state = States.BREAKAWAY},
			{condition = Conditions.IF_TURN_TO_TARGET_IMPOSSIBLE, new_state = States.BREAKAWAY}
		},
		[States.AIMING] = {
			{condition = Conditions.ON_RELEASE_POSITION, new_state = States.AIMING_AND_BOMBING},
			{condition = Conditions.ON_BREAKAWAY_POSITION, new_state = States.ALTITUDE_STABILIZING},
			{condition = Conditions.IF_PLANE_AHEAD, new_state = States.MID_AIR_COLLISION_AVOIDANCE, action = 'PUSH' },
			{condition = Conditions.IF_TARGET_DESTROYED, new_state = States.BREAKAWAY},
			{condition = Conditions.IF_GROUND_PROXIMITY, new_state = States.BREAKAWAY},
			{condition = Conditions.IF_TURN_TO_TARGET_IMPOSSIBLE, new_state = States.BREAKAWAY}
		},
		[States.AIMING_AND_BOMBING] = {
			{condition = {operator = "and", operands = {Conditions.IF_LINE_RELEASE, {subtask = Subtasks.BOMBING, status = SubtaskStates[Subtasks.BOMBING].RELEASE_IN_PROCESS}}}, new_state = States.ALTITUDE_STABILIZING_AND_BOMBING},
			{condition = {operator = "or", operands = {{subtask = Subtasks.BOMBING, status = SubtaskStates[Subtasks.BOMBING].RELEASE_FINISHED}, Conditions.ON_BREAKAWAY_POSITION}},
							new_state = States.ALTITUDE_STABILIZING},
			{condition = Conditions.IF_PLANE_AHEAD, new_state = States.MID_AIR_COLLISION_AVOIDANCE, action = 'PUSH' },
			{condition = Conditions.IF_TARGET_DESTROYED, new_state = States.BREAKAWAY},
			{condition = Conditions.IF_GROUND_PROXIMITY, new_state = States.BREAKAWAY},
			{condition = Conditions.IF_TURN_TO_TARGET_IMPOSSIBLE, new_state = States.BREAKAWAY}
		},
		[States.ALTITUDE_STABILIZING_AND_BOMBING] = {
			{condition = {subtask = Subtasks.BOMBING, status = SubtaskStates[Subtasks.BOMBING].RELEASE_FINISHED}, new_state = States.ALTITUDE_STABILIZING},
			{condition = Conditions.ON_BREAKAWAY_POSITION, new_state = States.ALTITUDE_STABILIZING},
			{condition = Conditions.IF_PLANE_AHEAD, new_state = States.MID_AIR_COLLISION_AVOIDANCE, action = 'PUSH' },
			{condition = Conditions.IF_TARGET_DESTROYED, new_state = States.BREAKAWAY},
		},
		[States.ALTITUDE_STABILIZING] = {
			{condition = Conditions.IF_PLANE_AHEAD, new_state = States.MID_AIR_COLLISION_AVOIDANCE, action = 'PUSH' },
			{condition = Conditions.IF_MINIMAL_CLIMB, new_state = States.BREAKAWAY},
			{condition = Conditions.IF_TARGET_DESTROYED, new_state = States.BREAKAWAY}
		}
	}
elseif dive_bombing_logic == AIMING_DIR then
	FSM = {
		[States.INIT] = {
			{new_state = States.APPROACHING}
		},
		[States.APPROACHING] = {
			{condition = {subtask = Subtasks.APPROACHING, status = SubtaskStates[Subtasks.APPROACHING].FINAL}, new_state = States.HOR_AIMING},
			{condition = Conditions.IF_PLANE_AHEAD, new_state = States.MID_AIR_COLLISION_AVOIDANCE, action = 'PUSH' },
			{condition = Conditions.IF_TARGET_DESTROYED, new_state = States.BREAKAWAY}
		},	
		[States.HOR_AIMING] = {
			{condition = {operator = "and", operands = {Conditions.IF_MINIMAL_ROLL, Conditions.ON_DIVE_START_POSITION, Conditions.IF_DIVING_BEFORE_AIMING}}, new_state = States.DIVING},
			{condition = {operator = "and", operands = {Conditions.IF_MINIMAL_ROLL, Conditions.ON_DIVE_START_POSITION, {operator = "not", operand = Conditions.IF_DIVING_BEFORE_AIMING}}}, new_state = States.AIMING},
			{condition = Conditions.IF_PLANE_AHEAD, new_state = States.MID_AIR_COLLISION_AVOIDANCE, action = 'PUSH' },
			{condition = Conditions.IF_TARGET_DESTROYED, new_state = States.BREAKAWAY}
		},
		[States.AIMING] = {
			{condition = Conditions.ON_RELEASE_POSITION, new_state = States.AIMING_AND_BOMBING},
			{condition = Conditions.ON_BREAKAWAY_POSITION, new_state = States.ALTITUDE_STABILIZING},
			{condition = Conditions.IF_PLANE_AHEAD, new_state = States.MID_AIR_COLLISION_AVOIDANCE, action = 'PUSH' },
			{condition = Conditions.IF_TARGET_DESTROYED, new_state = States.BREAKAWAY},
			{condition = Conditions.IF_GROUND_PROXIMITY, new_state = States.BREAKAWAY}	
		},
		[States.AIMING_AND_BOMBING] = {
			{	condition = {operator = "and", operands = {Conditions.IF_LINE_RELEASE, {subtask = Subtasks.BOMBING, status = SubtaskStates[Subtasks.BOMBING].RELEASE_IN_PROCESS}}}, new_state = States.ALTITUDE_STABILIZING_AND_BOMBING},
			{ condition = {operator = "or", operands = {{subtask = Subtasks.BOMBING, status = SubtaskStates[Subtasks.BOMBING].RELEASE_FINISHED}, Conditions.ON_BREAKAWAY_POSITION}},
					new_state = States.ALTITUDE_STABILIZING},
			{condition = Conditions.IF_PLANE_AHEAD, new_state = States.MID_AIR_COLLISION_AVOIDANCE, action = 'PUSH' },
			{condition = Conditions.IF_TARGET_DESTROYED, new_state = States.BREAKAWAY},
			{condition = Conditions.IF_GROUND_PROXIMITY, new_state = States.BREAKAWAY}
		},
		[States.ALTITUDE_STABILIZING_AND_BOMBING] = {
			{condition = {subtask = Subtasks.BOMBING, status = SubtaskStates[Subtasks.BOMBING].RELEASE_FINISHED}, new_state = States.ALTITUDE_STABILIZING},
			{condition = Conditions.ON_BREAKAWAY_POSITION, new_state = States.ALTITUDE_STABILIZING},
			{condition = Conditions.IF_PLANE_AHEAD, new_state = States.MID_AIR_COLLISION_AVOIDANCE, action = 'PUSH' },
			{condition = Conditions.IF_TARGET_DESTROYED, new_state = States.BREAKAWAY}
		},
		[States.ALTITUDE_STABILIZING] = {
		{condition = Conditions.IF_PLANE_AHEAD, new_state = States.MID_AIR_COLLISION_AVOIDANCE, action = 'PUSH' },
			{condition = Conditions.IF_MINIMAL_CLIMB, new_state = States.BREAKAWAY},
			{condition = Conditions.IF_TARGET_DESTROYED, new_state = States.BREAKAWAY}
		}
	}
elseif dive_bombing_logic == ONLY_HOR_AIMING_AND_DIVING then
	FSM = {
		[States.INIT] = {
			{new_state = States.APPROACHING}
		},
		[States.APPROACHING] = {
			{condition = {operator = "and", operands = {  {subtask = Subtasks.APPROACHING, status = SubtaskStates[Subtasks.APPROACHING].FINAL}, Conditions.IF_HIGHER_THAN_TARGET }}, new_state = States.HOR_AIMING},
			{condition = Conditions.IF_PLANE_AHEAD, new_state = States.MID_AIR_COLLISION_AVOIDANCE, action = 'PUSH' },
			{condition = Conditions.IF_TARGET_DESTROYED, new_state = States.BREAKAWAY}
		},	
		[States.HOR_AIMING] = {
			{condition = {operator = "and", operands = {Conditions.IF_MINIMAL_ROLL, Conditions.ON_DIVE_START_POSITION}}, new_state = States.AIMING},
			{condition = Conditions.IF_PLANE_AHEAD, new_state = States.MID_AIR_COLLISION_AVOIDANCE, action = 'PUSH' },
			{condition = Conditions.IF_TARGET_DESTROYED, new_state = States.BREAKAWAY}
		},
		[States.AIMING] = {
			{condition = Conditions.ON_DIVE_ANGLE, new_state = States.AIMING_AND_BOMBING},
			{condition = Conditions.IF_PLANE_AHEAD, new_state = States.MID_AIR_COLLISION_AVOIDANCE, action = 'PUSH' },
			{condition = Conditions.IF_TARGET_DESTROYED, new_state = States.BREAKAWAY},
			--{condition = Conditions.IF_IMPACT_POINT_OVER_TARGET, new_state = States.BREAKAWAY},
			{condition = Conditions.IF_TURN_TO_TARGET_IMPOSSIBLE, new_state = States.BREAKAWAY}			
		},
		[States.AIMING_AND_BOMBING] = {
			{ condition = {operator = "and", operands = {Conditions.IF_LINE_RELEASE, {subtask = Subtasks.BOMBING2, status = SubtaskStates[Subtasks.BOMBING2].RELEASE_IN_PROCESS}}}, new_state = States.ALTITUDE_STABILIZING_AND_BOMBING},
			{ 	condition = {operator = "or", operands = {{subtask = Subtasks.BOMBING2, status = SubtaskStates[Subtasks.BOMBING2].RELEASE_FINISHED}, Conditions.ON_BREAKAWAY_POSITION}},
				new_state = States.ALTITUDE_STABILIZING},
			{condition = Conditions.IF_PLANE_AHEAD, new_state = States.MID_AIR_COLLISION_AVOIDANCE, action = 'PUSH' },
			{condition = Conditions.IF_TARGET_DESTROYED, new_state = States.BREAKAWAY},
			{condition = Conditions.IF_TURN_TO_TARGET_IMPOSSIBLE, new_state = States.BREAKAWAY}
		},
		[States.ALTITUDE_STABILIZING_AND_BOMBING] = {
			{condition = {subtask = Subtasks.BOMBING2, status = SubtaskStates[Subtasks.BOMBING2].RELEASE_FINISHED}, new_state = States.ALTITUDE_STABILIZING},
			{condition = Conditions.ON_BREAKAWAY_POSITION, new_state = States.ALTITUDE_STABILIZING},
			{condition = Conditions.IF_PLANE_AHEAD, new_state = States.MID_AIR_COLLISION_AVOIDANCE, action = 'PUSH' },
			{condition = Conditions.IF_TARGET_DESTROYED, new_state = States.BREAKAWAY},
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
end
