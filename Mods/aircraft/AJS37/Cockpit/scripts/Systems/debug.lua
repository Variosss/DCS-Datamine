local dev = GetSelf()

local update_time_step = 0.05
make_default_activity(update_time_step)

local sensor_data = get_base_data()


local debugmsg = get_param_handle("DEBUGMESSAGE")
debugmsg:set("")




function update()
	local msg = debugmsg:get()
	if (msg ~= "") then
		print_message_to_user(msg)
		debugmsg:set("")
	end
end


