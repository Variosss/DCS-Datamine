gauges = {
	currtime_hours	= {
		arg_number		= 115,
		input			= {0.0, 12.0},
		output			= {0.0, 1.0},
	},
	currtime_minutes = {
		arg_number	= 116,
		input		= {0.0, 60.0},
		output		= {0.0, 1.0},
	},
	currtime_seconds = {
		arg_number	= 117,
		input		= {0.0, 60.0},
		output		= {0.0, 1.0},
	},
	flight_time_meter_status = {
		arg_number	= 118,
		input		= {0.0, 0.2},
		output		= {0.0, 0.2},
	},
	flight_hours	= {
		arg_number		= 119,
		input			= {0.0, 12.0},
		output			= {0.0, 1.0},
	},
	flight_minutes = {
		arg_number		= 120,
		input			= {0.0, 60.0},
		output			= {0.0, 1.0},
	},
	seconds_meter_time_minutes = {
		arg_number		= 121,
		input			= {0.0, 30.0},
		output			= {0.0, 1.0},
	},
	seconds_meter_time_seconds = {
		arg_number		= 122,
		input			= {0.0, 30.0},
		output			= {0.0, 1.0},
	},
}


local dev = GetSelf()
dev:listen_command(MechClock_LeftLever_Down)
dev:listen_command(MechClock_LeftLever_Down_up)
dev:listen_command(MechClock_LeftLever_Up)
dev:listen_command(MechClock_LeftLever_TurnLeft)
dev:listen_command(MechClock_LeftLever_TurnRight)
dev:listen_command(MechClock_RightLever_Down)
dev:listen_command(MechClock_RightLever_Down_up)
dev:listen_command(MechClock_RightLever_Rotate_left)
dev:listen_command(MechClock_RightLever_Rotate_right)

need_to_be_closed = true