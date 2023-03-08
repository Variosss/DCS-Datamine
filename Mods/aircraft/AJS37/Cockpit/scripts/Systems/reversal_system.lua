local landing_gear_system = GetSelf()
local dev = GetSelf()

local update_time_step = 0.05
make_default_activity(update_time_step)

local sensor_data = get_base_data()
local Reversal  = 3001 -- 76 --iCommandPlaneParachute

print("LOADING REVERSAL SYSTEM")
--Creating local variables
local REVERSAL_COMMAND		=	0				-- COMMANDED REVERSAL POS 0=OFF, 1=ON
local REVERSAL_STATE		=	0				-- ACTUAL REVERSAL POS 0=OFF,1=ON


dev:listen_command(Reversal)


function SetCommand(command,value)			
	if command == Reversal then
		if (REVERSAL_COMMAND == 1) then
			--print_message_to_user("Reversal disengaged")
			REVERSAL_COMMAND = 0
		else
			--print_message_to_user("Reversal engaged")
			REVERSAL_COMMAND = 1
		end
	end

	--print_message_to_user(string.format("Ending SetCommand Triggered %d re %d", command, GEAR_STATE))
end

function update()		

	set_aircraft_draw_argument_value(602, REVERSAL_COMMAND)
	
end


