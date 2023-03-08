local padlock_id = 101 
if    devices then
  	  padlock_id = devices.PADLOCK or 101
end

if LockOn_Options.flight.padlock then
	creators[padlock_id] 		= {"avPadlock", LockOn_Options.common_script_path.."PADLOCK/PADLOCK_device.lua"}
	indicators[#indicators + 1] = {"ccPadlock", LockOn_Options.common_script_path.."PADLOCK/PADLOCK_indicator.lua",padlock_id,{{},{sx_l = 1.0,sw = 0.1,sh = 0.1}}}
end
