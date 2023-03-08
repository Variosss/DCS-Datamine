dofile(LockOn_Options.script_path.."command_defs.lua")

function post_initialize()
local 	fscp  = GetSelf() 
		
		fscp:performClickableAction(device_commands.Button_16,1);
end

fuelQuantityPointer = {valmin = 0, valmax = 6000, T1 = 0.9, T2 = 0.224, bias = {{valmin = 0, valmax = 6000, bias = 0.5}}}
fuelQuantityDigitalCounter = {valmin = 0, valmax = 99999, T1 = 0.45, T2 = 0.158, bias = {{valmin = 0, valmax = 99999, bias = 0.5}}}

need_to_be_closed = true -- close lua state after initialization 