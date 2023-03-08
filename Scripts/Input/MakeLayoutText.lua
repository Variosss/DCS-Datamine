local gettext			= require('i_18n')
local textutil			= require('textutil')
local lfs				= require('lfs')
local InputData			= require('Input.Data')
local InputUtils		= require('Input.Utils')

local function makeFolder_(profileName)
	local unitName	= InputData.getProfileUnitName(profileName)
	local folder	= lfs.writedir() .. 'InputLayoutsTxt\\' .. unitName
	
	lfs.mkdir(folder)
	
	return folder
end

local function localizeInputString_(s)
	if s and s ~= '' then 
		return gettext.dtranslate('input', s) 
	end
	
	return ''
end

local function getComboString_(combo)
	local tbl = {}

	if combo.reformers then
		for i, reformer in pairs(combo.reformers) do
			table.insert(tbl, reformer)
		end
	end
	
	table.sort(tbl)
	
	if combo.key then
		table.insert(tbl, combo.key)
	end			

	return table.concat(tbl, ' - ')
end

local function getCombosString_(combos, emptyValue)
	if combos then
		local tbl = {}
		
		for i, combo in pairs(combos) do
			table.insert(tbl, getComboString_(combo))
		end
		
		return table.concat(tbl, '; ')
	end
end

local function getCategoryString(categories)
	if categories then
		if type(categories) == 'table' then
			local tbl = {}
			
			for i, category in ipairs(categories) do
				table.insert(tbl, localizeInputString_(category))
			end
			
			return table.concat(tbl, '; ')
		
		else
			return localizeInputString_(categories)
		end
	else
		return ''
	end
end

local function getCommandString_(command, deviceName, formatString, emptyComboValue)
	local combos			= command.combos or {}
	local combosString		= getCombosString_(combos[deviceName]) or emptyComboValue
	local commandName		= localizeInputString_(command.name)
	local commandCategory	= getCategoryString(command.category)
	local commandHash		= command.hash

	return string.format(formatString, combosString, commandName, commandCategory, commandHash)
end

local function writeTxtCommands_(commands, deviceName, file)
	local formatString = '%s\t%s\t%s\t%s\n'
	local emptyComboValue = 'EMPTY'
	
	table.sort(commands, function(command1, command2)
		local name1 = localizeInputString_(command1.name)
		local name2 = localizeInputString_(command2.name)
		
		return textutil.Utf8Compare(name1, name2)
	end)
	
	for i, command in ipairs(commands) do
		file:write(getCommandString_(command, deviceName, formatString, emptyComboValue))
	end
end

local function compareCommandName_(command1, command2)
	local name1 = localizeInputString_(command1.name)
	local name2 = localizeInputString_(command2.name)
	
	return textutil.Utf8Compare(name1, name2)
end

local function getProfileKeyCommands_(profileName)
	local commands = InputData.getProfileKeyCommands(profileName)
	
	table.sort(commands, compareCommandName_)
	
	for i, command in ipairs(commands) do
		command.hash = InputUtils.getKeyCommandHash(command)
	end
	
	return commands
end

local function getProfileAxisCommands_(profileName)
	local commands = InputData.getProfileAxisCommands(profileName)
	
	table.sort(commands, compareCommandName_)
	
	for i, command in ipairs(commands) do
		command.hash = InputUtils.getAxisCommandHash(command)
	end
	
	return commands
end

local function makeTxt(profileName, deviceNames)
	local folder = makeFolder_(profileName)
	local filenameFormatString = folder .. '/%s.txt'

	for i, deviceName in ipairs(deviceNames) do
		local filename = string.format(filenameFormatString, deviceName)
		local file = io.open(filename, 'w')

		if file then
			writeTxtCommands_(getProfileKeyCommands_(profileName), deviceName, file)
			writeTxtCommands_(getProfileAxisCommands_(profileName), deviceName, file)

			file:close()
		end
	end
	
	return folder
end

local function writeHtmlCommands_(commands, deviceName, file)
	local emptyComboValue	= ''
	local formatString		= 
[[
        <tr>
          <td>%s</td>
          <td>%s</td>
          <td>%s</td>
          <td>%s</td>
        </tr>
]]

	for i, command in ipairs(commands) do
		file:write(getCommandString_(command, deviceName, formatString, emptyComboValue))
	end
end

local function makeHtml(profileName, deviceNames)
	local folder = makeFolder_(profileName)
	local css = lfs.realpath('./Scripts/Input/layout.css')
	
	for i, deviceName in ipairs(deviceNames) do
		local filename = string.format(folder .. '/%s.html', deviceName)
		local file = io.open(filename, 'w')

		if file then
			file:write(string.format([[
<head>
  <link href="%s" rel="stylesheet">
</head>
<section>
  <h1>%s</h1>
    <table >
        <tr>
          <th>Combos</th>
          <th>Command</th>
          <th>Category</th>
          <th>Hash</th>
        </tr>
]], css, deviceName))

			writeHtmlCommands_(getProfileKeyCommands_(profileName), deviceName, file)
			writeHtmlCommands_(getProfileAxisCommands_(profileName), deviceName, file)
			
			file:write([[
    </table>
</section>
]])
		end
	end
	
	return folder
end

return {
	makeTxt		= makeTxt,
	makeHtml	= makeHtml,
}