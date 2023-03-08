local landing_gear_system = GetSelf()
local dev = GetSelf()

local update_time_step = 0.05
make_default_activity(update_time_step)

local sensor_data = get_base_data()
local Gear  = 68
local BrakeOn = 74
local BrakeOff = 75
print("LOADING LANDING GEAR SYSTEM")
--Creating local variables
local GEAR_COMMAND		=	0				-- COMMANDED GEAR POS 0=UP, 1=DOWN
local GEAR_STATE		=	0				-- ACTUALT GEAR POS 0=UP,1=DOWN
local NOSE_GEAR_POS 	= 	0
local RIGHT_GEAR_POS 	=   0
local LEFT_GEAR_POS		=   0
local HAS_STARTED		= 	0
local BRAKE_COMMAND		=	0
local BRAKE_STATE		=	0

dev:listen_command(Gear)
dev:listen_command(BrakeOn)
dev:listen_command(BrakeOff)

function SetCommand(command,value)			
	--print_message_to_user(string.format("New SetCommand Triggered %d gearstate %d", command, GEAR_STATE))
	--env.info(string.format("Command %f", command), true)
	
	-- if command == 3020 then  -- GEAR UP		
		-- GEAR_COMMAND = 0
		-- print_message_to_user("Gear Set to UP")
	-- end
	
	-- if command == 3019 then  -- GEAR DOWN		
		-- GEAR_COMMAND = 1
		-- print_message_to_user("Gear Set to DOWN")
	-- end
	if command == Gear then
		if (GEAR_COMMAND == 1) then
			GEAR_COMMAND = 0
			--print_message_to_user("Gear up")
		else
			GEAR_COMMAND = 1
			--print_message_to_user("Gear down")
		end
	end
	
	if command == BrakeOn then
		BRAKE_COMMAND = 1
	end
	if command == BrakeOff then
		BRAKE_COMMAND = 0
	end
	--print_message_to_user(string.format("Ending SetCommand Triggered %d gearstate %d", command, GEAR_STATE))
end
local p_gearstate = get_param_handle("GEARSTATE")
local fmparams = get_param_handle("FM_Params")
fmparams:set(string.format("%sGEARSTATE;",fmparams:get()))

function update()		
	p_gearstate:set(GEAR_STATE)
	--print_message_to_user(string.format("Update gearstate %d", GEAR_STATE))
	--env.info(string.format("Update!", 1), true)
	-- updates = updates + 1
	-- local pipe, _, _ = io.open("\\\\.\\pipe\\my_pipe", "r")
	-- if not pipe and connected_to_pipe then
		--print_message_to_user("error opening pipe")
	-- else
		-- connected_to_pipe = true
		-- for line in pipe:lines() do
		
			-- print_message_to_user(line)
		
		-- end
		-- local t = pipe:read(1024)
		-- print_message_to_user(string.format("C Update=%d Lua update=%d",t, updates))
		-- pipe:close()
		-- connected_to_pipe = false
		--print_message_to_user("success opening pipe")
	-- end

	--print_message_to_user(string.format("Pipe open!", GEAR_STATE))
	NOSE_GEAR_POS 	=  get_aircraft_draw_argument_value(0)
	RIGHT_GEAR_POS 	=  get_aircraft_draw_argument_value(3)
	LEFT_GEAR_POS 	=  get_aircraft_draw_argument_value(5)
	
	local FORCE_GEAR_DOWN = get_aircraft_draw_argument_value(610)
	if (FORCE_GEAR_DOWN == 1) then
		GEAR_COMMAND = 1
		set_aircraft_draw_argument_value(600,1)
		set_aircraft_draw_argument_value(610, 0)
	end
	
	--if GEAR_COMMAND == 1 then
	--	GEAR_STATE = 1
	--end
	
	--if GEAR_COMMAND == 0 then
	--	GEAR_STATE = 0
	--end
	
	
	-- if (sensor_data.getRadarAltitude() * 3.28084) < 500.0 then
		-- GEAR_STATE = 1
	-- end
	if (GEAR_COMMAND == 0 and GEAR_STATE > 0.05) then
		-- Raise gear in increments of 0.1
		GEAR_STATE = GEAR_STATE - 0.05
	else
		if (GEAR_COMMAND == 1 and GEAR_STATE < 0.95) then
			-- Lower gear in increment of 0.1
			GEAR_STATE = GEAR_STATE + 0.05
		end
	end
	
	
	--set_aircraft_draw_argument_value(0,GEAR_STATE)
	--set_aircraft_draw_argument_value(3,GEAR_STATE)
	--set_aircraft_draw_argument_value(5,GEAR_STATE)
	if (HAS_STARTED == 1) then
		set_aircraft_draw_argument_value(600,GEAR_COMMAND)
	else
		GEAR_COMMAND = get_aircraft_draw_argument_value(600)
		HAS_STARTED = 1
	end
	
	set_aircraft_draw_argument_value(601, BRAKE_COMMAND)
	
	set_aircraft_draw_argument_value(604, sensor_data.getWOW_NoseLandingGear())
	set_aircraft_draw_argument_value(605, sensor_data.getWOW_LeftMainLandingGear())
	set_aircraft_draw_argument_value(606, sensor_data.getWOW_RightMainLandingGear())
	
	 --if	sensor_data.getWOW_LeftMainLandingGear()==1 or
		-- sensor_data.getWOW_NoseLandingGear()==1 or
		-- sensor_data.getWOW_RightMainLandingGear()==1 then 
		-- print_message_to_user("TOUCHDOWN!")
	-- else
		-- print_message_to_user("FLYING")
	-- end
end


