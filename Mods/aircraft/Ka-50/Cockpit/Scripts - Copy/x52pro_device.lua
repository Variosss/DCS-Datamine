dofile(LockOn_Options.script_path.."devices.lua")
coroutines  = {}

function CoroutineResume(index,time_)
local  routine = coroutines[index]
if     routine            == nil or 
       routine.next_event == nil then return false end
local  ret,t   = routine:next_event(time_) if ret == false then coroutines[index] = nil end
return ret,t
end


package.path  = package.path..";.\\Config\\Export\\?.lua"..";.\\Scripts\\X52Pro\\?.lua"

local x52 = require('X52Pro')

function  on_device_change(device,added)
    dbg_print("device right way added\n")
	if  added then
        x52.direct_output.devices[device] = x52.DirectOutputDevice(device)
        local dev  = x52.direct_output.devices[device]
		local page = dev:new_page("first",true)
              page:set_string(0,"RULLEZ!!!!");
              page:set_string(1,"SAITEK");
              page:set_string(2,"DCS:BS");
              page:set_led(LED_COMPLEX_FIRE_A,LED_RED);
	else
        table.remove(x52.direct_output.devices,device)
	end
end

function  on_soft_button (device,action)
    local dev  = x52.direct_output.devices[device]
end

function  on_page_change (device,page,activate)
    local dev  = x52.direct_output.devices[device]
end


function post_initialize()
  x52.initialize()
end

function SetCommand(self_id,command,value)

end

function CockpitEvent(event,params)

end

function release()
  for i,o in pairs(coroutines) do
		if coroutines[i] ~= nil then
		   coroutines[i]:kill_me();
		   coroutines[i]  = nil 
		end
  end
  x52.deinitialize()
end
