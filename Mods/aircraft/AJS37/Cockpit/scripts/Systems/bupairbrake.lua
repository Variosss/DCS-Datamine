local landing_gear_system = GetSelf()
local dev = GetSelf()

local update_time_step = 0.05
make_default_activity(update_time_step)

local sensor_data = get_base_data()
local Airbrake  = 73 --iCommandPlaneFlaps 72, IcommandPlaneGear 68

print("LOADING AIR BRAKE SYSTEM")
--Creating local variables

local BRAKE_COMMAND		=	0				-- 0=OFF,1=ON

dev:listen_command(Airbrake)


function SetCommand(command,value)			
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
	if (command == Airbrake and GEAR_COMMAND == 0)  then
		--print_message_to_user(string.format("MACH: %d", sensor_data.getMachNumber()));
		if (BRAKE_COMMAND == 1) then
			BRAKE_COMMAND = 0
			print_message_to_user("Air-brake retracting");
		elseif (sensor_data.getMachNumber() < 0.92) then -- Unable to extend >M0.92
			BRAKE_COMMAND = 1
			print_message_to_user("Air-brake extending");
		end
	end

	--print_message_to_user(string.format("Ending SetCommand Triggered %d re %d", command, GEAR_STATE))
end

function update()
	local GEAR_COMMAND = get_aircraft_draw_argument_value(182)	
	if (GEAR_COMMAND == 1 and BRAKE_COMMAND == 1) then
		BRAKE_COMMAND = 0
		print_message_to_user("Air-brake retracting");
	end
	set_aircraft_draw_argument_value(509, BRAKE_COMMAND)
	
end


