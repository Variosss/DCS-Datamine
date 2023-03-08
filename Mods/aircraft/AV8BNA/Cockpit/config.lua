args_initial_state = 
{
}

local hideStick = get_option_value("difficulty.hideStick","local")
if hideStick then 
	args_initial_state[999] = 1.0
end