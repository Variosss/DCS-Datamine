local lfs = require('lfs')

shellFlag = true

function shellParse(str)

	if not shellFlag then
		return str
	end
	
	local i, j = string.find(str, '[%w_?]+%s*')
	
	if i == nil or j == nil then
		return str
	end
	
	local command = string.match(str, '([%w_?]+)%s*')
	if type(consoleCommands[command]) ~= 'function' then
		return str
	end
	--local command = string.sub(str, i, j)
	if command == '?' then
		command = 'help'
	end
	--print("command="..command.."\n")
	local params_str = string.sub(str, j)
	--print("params_str = \""..params_str.."\"\n")
	
	local params = {}
	local params_qty = 0
	
	local patterns = {
		{'[/-]*%a+=on',			'both',		'[/-]*(%a+)=(on)'},
		{'[/-]*%a+=off',		'both',		'[/-]*(%a+)=(off)'},
		{'[/-]*%a+="[^"/-]*"',	'both',		'[/-]*(%a+)="([^"/-]*)"'},
		{'[/-]*%a+=\'[^\'/-]*\'', 'both',	'[/-]*(%a+)=\'([^\'/-]*)\''},
		{'[/-]*%a+=%d+', 		'both',		'[/-]*(%a+)=(%d+)'},
		{'%s+on%s*',			'value',	'%s+(on)%s*'},
		{'%s+off%s*',			'value',	'%s+(off)%s*'},
		{'%s"[^"]*"',			'value',	'%s"([^"]*)"'},
		{'%s+%d+',				'value',	'%s+(%d+)'},
		{'%s+[^%s=/-]+',		'value',	'%s+([^%s=/-]+)'},
		{'[/-]*%a+',			'name',		'[/-]*(%a+)'}
	}
	local nameless_param_num = 0
	
	while params_str do
		--print("params_str="..(params_str or "").."\n")
		local min_first
		local min_last = 1
		local name, value
		--local pf
		for ip, p in pairs(patterns) do
			local first, last = string.find(params_str, p[1])
			if first and (not min_first or first < min_first) then
				--print('pattern found '..p[1])
				--pf = p
				if p[2] == 'both' and p[3] then
					name, value = string.match(params_str, p[3])
				elseif p[2] == 'name' then
					name = string.match(params_str, p[3])
					value = nil
				elseif p[2] == 'value' then
					name = nil
					value = string.match(params_str, p[3])
				end
				if type(value) == 'string' then
					value = '"'..string.gsub(value, '\\', '\\\\')..'"'
				end
				min_first = first
				min_last = last				
			end
		end
		if name or value then
			--print(pf[1].." "..pf[2].." founded in "..params_str.."\n")
			--print("name="..(name or "").." value = "..(value or "").."\n")
			if value == 'on' then
				value = 'true'
			elseif value == 'off' then
				value = 'false'
			end
			params_qty = params_qty + 1
			if name then
				if value then
					params[name] = value
				else
					params[name] = true
				end
			else
				nameless_param_num = nameless_param_num + 1
				params[tostring(nameless_param_num)] = value
			end
		else
			if string.find(params_str, '[(){}<>+-*/#.,+=]') then
				return str
			end
			break
		end
		params_str = string.sub(params_str, min_last + 1)
	end
	
	local code_str = 'consoleCommands:'..command..'('
	if params_qty > 0 then
		code_str = code_str..'{'
	end
	local par_counter = 0
	for pn, pv in pairs(params) do
		par_counter = par_counter + 1
		if par_counter > 1 then
			code_str = code_str..', '
		end
		if type(pv) == 'boolean' then
			code_str = code_str..'["'..pn..'"]'..' = '..tostring(pv)
		else
			code_str = code_str..'["'..pn..'"]'..' = '..pv
		end
	end
	if params_qty > 0 then
		code_str = code_str..'}'
	end
	code_str = code_str..')'
	
	return code_str
end

consoleCommands = {}

function consoleCommands:shell(params)
	if 	params and
		params['1'] ~= nil then
		shellFlag = params['1']
	else
		if shellFlag then
			console.out('Shell is on')
		else
			console.out('Shell is off')
		end
	end
end

function consoleCommands:help()
	console.out('DCS shell commands:')
	for ic, c in pairs(consoleCommands) do
		if type(c) == 'function' then
			console.out(ic)
		end
	end	
end

function consoleCommands:echo(params)
	if params["1"] ~= nil then
		console.out(params["1"])
	end
end

local function isFileExists(path)
	local attr = lfs.attributes(path)
	if attr ~= nil then
		return attr.mode == 'file'
	else
		return false
	end
end

local function checkPath(path)
	if 	string.find(path, '.') and
		isFileExists(path) then
		return path
	elseif isFileExists(path..'.miz') then
		return path..'.miz'
	elseif isFileExists(path..'.trk') then
		return path..'.trk'
	else
		return nil
	end
end

local function findFile(path, dir)
	local foundPath = checkPath(dir..'/'..path)
	if foundPath ~= nil then
		return foundPath
	end
	local iter, dir_obj = lfs.dir(dir)
	local item = iter(dir_obj)
	while item ~= nil do
		if item ~= '.' and item ~= '..' then
			local itemPath = dir..'/'..item
			local attr = lfs.attributes(itemPath)
			if attr.mode == 'directory' then	
				local foundPath	= findFile(path, itemPath)
				if foundPath ~= nil then
					return foundPath
				end
			end
		end
		item = iter(dir_obj)
	end
end

local dirs = {
	'Missions',
	'Mods',
	lfs.writedir()..'/Missions',
	lfs.writedir()..'/Tracks'
}

local function findMission(mission)
	local path = checkPath(mission)
	if path ~= nil then
		return path
	else
		for number, parent_path in pairs(dirs) do
			path = findFile(mission, parent_path)
			if path then
				return path
			end
		end
	end
end

function consoleCommands:load(params)
	if params then
		local mission = params['1'] or params.mission
		if mission then
			local path = findMission(mission)
			if path then
				if env.load(path) then
					console.out('\"'..path..'\" loaded.')
					return true
				end
			end
			console.out('Can\'t load \"'..mission..'\".')
		else
			console.out('error: file name missed')
		end
	else
		console.out('error: file name missed')
	end
	return false
end

function consoleCommands:net(params)
	if params and type(params['1']) == 'boolean' then
		local on = params['1']
		env.setModeMP(on)
		--[[
		if on then
			console.out('Net GUI switched on')
		else
			console.out('Net GUI switched off')
		end
		--]]
	else
		console.out('Error: on/off parameter missed')
	end
end

function consoleCommands:start(params)
	if params and
		(params['1'] or params.mission) then
		if self:load(params) then
			console.out("Starting simulation...")
			env.start()
		end
	else
		console.out("Starting simulation...")
		env.start()
	end	
end

function consoleCommands:restart()
	env.restart()
	console.out("Restarting simulation...")
end

function consoleCommands:stop()
	env.stop()
	console.out("Stopping simulation...")
end

function consoleCommands:server(params)
	if params then		
		local mission = params['1'] or params.mission
		if mission ~= nil then
			local path = findMission(mission)
			if path ~= nil then
				console.out("Starting server...")
				env.startServer(path)
				return
			end
		end		
	end
	console.out("Mission not found")
end

function consoleCommands:reload_database()
	console.out("Reloading database...")
	env.reloadDatabase()
	console.out('console.out(\'Database reloaded\')')
end

function consoleCommands:mission(params)
	local missionName = env.getMissionName()
	if missionName then
		console.out('Current mission is \"'..missionName..'\"')
	else
		console.out('No mission loaded')
	end
end

function consoleCommands:misspath(params)
	if params ~= nil and params['1'] ~= nil then
		self.mission_path = params['1']
		console.out('Mission path \"'..self.mission_path..'\"')
	else
		if self.mission_path ~= nil then
			console.out('Mission path \"'..self.mission_path..'\"')
		else
			console.out('No mission path')
		end
	end
end

function consoleCommands:trackpath(params)
	if params ~= nil and params['1'] ~= nil then
		self.track_path = params['1']
		console.out('Track path \"'..self.track_path..'\"')
	else
		if self.track_path ~= nil then
			console.out('Track path \"'..self.track_path..'\"')
		else
			console.out('No track path')
		end
	end
end

function consoleCommands:exit()
	env.exit()
end

function consoleCommands:console_switch(params)
	if params["1"] ~= nil then
		console.toggle(params["1"])
	end
end

function consoleCommands:echo(params)
	console.out(params["1"])
end

function consoleCommands:cls()
	console.clear();
end

function consoleCommands:clearhist()
	console.clearHistory();
end

function consoleCommands:acceleration(params)
	if params ~= nil then
		timer.setAcc(params["1"])
		console.out('Model time acceleration changed to '..params["1"]..'.')
	else
		console.out('Model time acceleration is '..timer.getAcc()..'.')
	end		
end

function consoleCommands:pause(params)
	if params and params['1'] then
		timer.setPause(params['1'])
		if timer.getPause() then
			console.out("Model time paused.")
		else
			console.out("Model time resumed.")
		end
	else
		if timer.getPause() then
			console.out("Model time on pause.")
		else
			console.out("Model time marches on.")
		end
	end
end
