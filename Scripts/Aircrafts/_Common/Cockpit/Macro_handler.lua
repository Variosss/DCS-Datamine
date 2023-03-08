gettext = require("i_18n")
_ = gettext.translate

local  illumination        = 300
local iCommandEnginesStart = 309 --Запуск двигателей
local iCommandEnginesStop  = 310 --Остановка двигателей

local dev = GetSelf()

-- subscribe 
dev:listen_command(illumination)
dev:listen_command(iCommandEnginesStart)
dev:listen_command(iCommandEnginesStop)

local coroutines  = {}
local start_order = 1;
local stop_order  = 2;
local illum_order = 3
local check_list_order = 4

function CoroutineResume(index,time_)
local  routine = coroutines[index]
if     routine            == nil or routine.next_event == nil then return false end
local  ret,t   = routine:next_event(time_) 
if     ret == false then
       coroutines[index] = nil
end
return ret,t
end

local defalut_message = { message = _("AUTOSTART STOPPED"), message_timeout = 10}

function print_autostart_fault(condition_id)
				
	if(condition_id <= #alert_messages) then
		print_message_to_user(alert_messages[condition_id].message,alert_messages[condition_id].message_timeout)
	end
	
	print_message_to_user(defalut_message.message,defalut_message.message_timeout)
end

function sequence_handler(routine,t)
    local stage          = routine.stage or 1
	if  routine.sequence == nil or 
	   #routine.sequence == 0   then
        return false
    end
    local  current_time = routine.sequence[stage].time
    while  math.abs(routine.sequence[stage].time - current_time) < 0.001 do
	   local data = routine.sequence[stage]
	   
		local result = 0
		if  data.check_condition ~= nil then 
			result = dev:check_autostart_condition(data.check_condition)
		end
	   
		if  result ~= 0 then
			print_autostart_fault(result)
			return false
		end
	   
	   if not track_is_reading() and data.action ~= nil then
	   
			dispatch_action(data.device,
							data.action,
							data.value)	
	   end
	   
	   if  data.message ~= nil then
	   	   print_message_to_user(data.message,
								 data.message_timeout)
	   end
	   
       stage = stage + 1
       if stage > #routine.sequence then
          return false
       end 
    end
    routine.stage = stage
    local   dt = routine.sequence[routine.stage].time - routine.sequence[routine.stage - 1].time
    return  true, t + dt
end

function checklist_schedule(list)
    local chk = coroutines[check_list_order]
	if  chk ~= nil then
		chk:kill_me()
		chk = nil
	end
	chk 		   = coroutine_create(check_list_order)
	chk.list 	   = list
	chk.next_event = function (routine,t)
		if not update_checklist(routine.list) then
			return false
		end
		return true, t + 0.5
	end
	chk:start(0.3)
	coroutines[check_list_order] = chk
end

function check_routine(n_routine,sequence)
	if coroutines[n_routine] ~= nil then
		coroutines[n_routine]:kill_me()
		coroutines[n_routine]  = nil
	else
		coroutines[n_routine]  = coroutine_create(n_routine)
		coroutines[n_routine].next_event = sequence_handler
		coroutines[n_routine].stage      = nil 
		coroutines[n_routine].sequence   = sequence
		coroutines[n_routine]:start(0.3)
	end
end

function kill_routine(n_routine)
    if coroutines[n_routine] ~= nil then
       coroutines[n_routine]:kill_me()
       coroutines[n_routine]  = nil
    end
end

function SetCommand(command,value)
	if command == iCommandEnginesStart then	
		if start_sequence_heavy == nil then
		   start_sequence_heavy = start_sequence_full
		end
		local result = 0
		if  dev.check_autostart_condition ~= nil then
		    result = dev:check_autostart_condition(0)
		end
		if  result == 0 then 
			kill_routine(stop_order)
			check_routine(start_order,start_sequence_heavy)
		else
			print_autostart_fault(result)
		end
		
	elseif command == iCommandEnginesStop then
        kill_routine(start_order)
        check_routine(stop_order,stop_sequence_full)
	elseif command == illumination then
		if cockpit_illumination_full then
			check_routine(illum_order,cockpit_illumination_full)
		end
    end
end

function post_initialize()

end

function CockpitEvent(event,params)

end

function on_state_close()
  for i,o in pairs(coroutines) do
		if coroutines[i] ~= nil then
		   coroutines[i]:kill_me();
		   coroutines[i] = nil 
		end
  end
end



--[[ 
local checklist_item = 
{
	description  = "",
	guide_target = "",
	done_check   = false,
	ready 		 = false
	check 		 = function (self)  
		return false
	end
}
--]]


function MAKE_CHECKLIST_ITEM(
	desc,
	target_for_pressing,
	check_routine)
	return 	{
	description   = desc,
	guide_target  = target_for_pressing,
	check 		  = check_routine or function (self) return true end
	}
end

function update_checklist(list)
	if  list == nil then 
		return false
	end
	local guide_target = nil
	for i,item in ipairs(list) do
		if not guide_target then
			item.ready = item.done_check or item:check()
			if not item.ready then
				guide_target = item.guide_target
				break
			end
		else
			item.ready = false
		end
	end
	if  not guide_target then
		a_cockpit_remove_highlight(100)
	elseif list.highlight ~= guide_target then
		a_cockpit_highlight(100,guide_target)
	end
	list.highlight = guide_target 
	return list.highlight ~= nil
end

local f, errorMsg = loadfile(LockOn_Options.script_path.."Macro_sequencies.lua")
if f then
	f()
else
	print(errorMsg)
end
