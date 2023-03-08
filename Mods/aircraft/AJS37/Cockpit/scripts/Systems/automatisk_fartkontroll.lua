local landing_gear_system = GetSelf()
local dev = GetSelf()

local update_time_step = 0.05
make_default_activity(update_time_step)

local sensor_data = get_base_data()
local AFK  = 63 --iCommandPlaneAUTOnOff 

print("LOADING AUTOMATISK FARTKONTROLL")
--Creating local variables
local AFK_COMMAND		=	0				-- 0=OFF, 1=ON
local AFK_STATE		=	0				-- 0=OFF,1=ON


dev:listen_command(AFK)


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
	if command == AFK then
		if (AFK_COMMAND == 1) then
			AFK_COMMAND = 0
			set_aircraft_draw_argument_value(607, AFK_COMMAND)
			print_message_to_user("AFK disengaged");
		else
			AFK_COMMAND = 1
			set_aircraft_draw_argument_value(607, AFK_COMMAND)
			print_message_to_user("AFK engaged");
		end
	end

	--print_message_to_user(string.format("Ending SetCommand Triggered %d re %d", command, GEAR_STATE))
end

function update()		

	
end


