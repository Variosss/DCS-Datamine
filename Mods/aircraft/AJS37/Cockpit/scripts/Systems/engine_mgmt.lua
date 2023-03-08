local dev = GetSelf()

local update_time_step = 0.05
make_default_activity(update_time_step)

local sensor_data = get_base_data()
-- Key Commands --
local LTKRAN = 3040 -- Fuelpump
local HTKRAN = 3041 -- Throttle off
local STARTERSWITCH = 3042 -- Starter switch
local STARTERSWITCHRELEASED = 3043 -- Released starter switch
dev:listen_command(LTKRAN)
dev:listen_command(HTKRAN)
dev:listen_command(STARTERSWITCH)
dev:listen_command(STARTERSWITCHRELEASED)

local enginemgmt = get_param_handle("ENGINE_MGMT")
local starterswitch_param = get_param_handle("STARTERSWITCH")
enginemgmt:set(0)
starterswitch_param:set(0)




function SetCommand(command,value)		
	if command==LTKRAN then
		enginemgmt:set(1)
		print("LTKRAN")
	end
	if command==HTKRAN then
		enginemgmt:set(2)
		print("HTKRAN")
	end
	if command==STARTERSWITCH then
		starterswitch_param:set(1)
		print("STARTER")
	end
	if command==STARTERSWITCHRELEASED then
		starterswitch_param:set(0)
		print("STARTER RELEASED")
	end
end

function update()
	
end


