
function copyTable(src, target)
    if not target then
       target = {}
    end
	
    for i, v in pairs(src) do
        if type(v) == 'table' then
            if not target[i] then
                target[i] = {}
            end
			copyTable(v, target[i])
        else
            target[i] = v
        end
    end
	
    return target
end

function isKeyboard(deviceName)
	return deviceName == 'Keyboard'
end

function isJoystick(deviceName)
	return deviceName ~= 'Keyboard' and deviceName ~= 'Mouse'
end

function addInputEntryKeyCmn(commands, deviceName, defs, keyb_combos, joy_combos)
	local res = {}
	
	copyTable(defs, res)
	
	if isKeyboard(deviceName) then
		res.combos = keyb_combos
	elseif isJoystick(deviceName) then
		res.combos = joy_combos
	end
	
	commands[#commands + 1] = res
end

function addInputEntryAxisCmn(commands, deviceName, defs, combos)
	if isJoystick(deviceName) then
		local res = {}
	
		copyTable(defs, res)
		res.combos = combos
		commands[#commands + 1] = res
	end
end
