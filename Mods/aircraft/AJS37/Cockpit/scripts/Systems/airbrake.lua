local landing_gear_system = GetSelf()
local dev = GetSelf()

local update_time_step = 0.05
make_default_activity(update_time_step)

local sensor_data = get_base_data()
local Airbrake  = 73 --iCommandPlaneFlaps 72, IcommandPlaneGear 68
--local ExtendRetractHoldAB = 3001
local AirbrakeOutDown = 3001
local AirbrakeOutUp = 3002
local AirbrakeInDown = 3003


print("LOADING AIR BRAKE SYSTEM")
--Creating local variables

local BRAKE_COMMAND		=	0				-- 0=OFF,1=ON
local FORCE_OUT = 0

dev:listen_command(Airbrake)
--dev:listen_command(ExtendRetractHoldAB)
dev:listen_command(AirbrakeOut)
dev:listen_command(AirbrakeIn)



function SetCommand(command,value)		
		local IsSet = false
	--print_message_to_user(string.format("New SetCommand Triggered %d reversal state %d", command, REVERSAL_STATE))
	--env.info(string.format("Command %f", command), true)
	
	-- if command == 3020 then  -- GEAR UP		
		-- GEAR_COMMAND = 0
		-- print_message_to_user("Gear Set to UP")
	-- end
	
	-- if command == 3019 then  -- GEAR DOWN		
		-- GEAR_COMMAND = 1
		-- print_message_to_user("Gear Set to DOWN")
	-- end
	local GEAR_COMMAND = get_aircraft_draw_argument_value(0)
	if (command == AirbrakeOutDown) then
		FORCE_OUT = 1
		BRAKE_COMMAND = 1
		IsSet = true
	end
	if (command == AirbrakeOutUp and IsSet == false) then
		FORCE_OUT = 0
		IsSet = true
	end
	if (command == AirbrakeIn and IsSet == false) then
		FORCE_OUT = 0
		BRAKE_COMMAND = 0
		IsSet = true
	end
	if (command == Airbrake and GEAR_COMMAND == 0 and IsSet == false)  then
		--print_message_to_user(string.format("MACH: %d", sensor_data.getMachNumber()));
		if (BRAKE_COMMAND == 1) then
			BRAKE_COMMAND = 0
			--print_message_to_user("Air-brake retracting");
			FORCE_OUT = 0
			IsSet = true
		elseif (sensor_data.getMachNumber() < 0.92) then -- Unable to extend >M0.92
			BRAKE_COMMAND = 1
			--print_message_to_user("Air-brake extending");
			FORCE_OUT = 0
			IsSet = true
		end
	end
	if (command == Airbrake and BRAKE_COMMAND == 0 and (GEAR_COMMAND == 1 or sensor_data.getMachNumber() > 0.92) and IsSet == false) then
		FORCE_OUT = 1
		BRAKE_COMMAND = 1
		IsSet = true
	end
	if (command == Airbrake and BRAKE_COMMAND == 1 and FORCE_OUT == 1 and IsSet == false) then
		BRAKE_COMMAND = 0
		FORCE_OUT = 0
		IsSet = true
	end
	if (command ==ExtendRetractHoldAB) then
		print_message_to_use("SIGNAL!")
	end
	--print_message_to_user(string.format("Ending SetCommand Triggered %d re %d", command, GEAR_STATE))
end

function update()
	local GEAR_COMMAND = get_aircraft_draw_argument_value(0)	
	if (GEAR_COMMAND == 1 and BRAKE_COMMAND == 1 and FORCE_OUT == 0) then
		BRAKE_COMMAND = 0
		print_message_to_user("Air-brake retracting");
	end
	if (sensor_data.getMachNumber() > 0.92 and BRAKE_COMMAND == 1 and FORCE_OUT == 0) then
		BRAKE_COMMAND = 0
		print_message_to_user("Air-brake retracting");
	end
	set_aircraft_draw_argument_value(509, BRAKE_COMMAND)
	
end


