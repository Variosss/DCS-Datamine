local base = _G

module('optionsEditor')

local ConfigHelper	= base.require('ConfigHelper')
local Serializer	= base.require('Serializer')
local TableUtils	= base.require('TableUtils')
local lfs 			= base.require('lfs')


local options = {}

local function loadOptionsFromFile(filename, noError)
	local options_
	local func, err = base.loadfile(filename)
    
	if func then
		local env = {}
		base.setfenv(func, env)
		local ok, res = base.pcall(func)
		if not ok then
			log.error('ERROR: loadOptionsFromFile() failed to pcall "'..filename..'": '..res)
			return
		end
		
		options_ = env.options
	else
		if noError ~= true then
			base.print(err)
		end
	end
	
	return options_
end

function loadOptions()
	local func, err = base.loadfile(ConfigHelper.getConfigReadPath('options.lua'))

	if func then
		local env = {}
		base.setfenv(func, env)
		func()		
		options = env.options
	else
		base.print(err)
	end
	
	local product_options = loadOptionsFromFile('./Config/product_options.lua', true)	
	if product_options and lfs.attributes(ConfigHelper.getConfigWritePath('options.lua')) == nil then
		options = TableUtils.mergeTablesOptions(options, product_options)
	end	
end

function saveOptions()
	if options then
		local file, err = base.io.open(ConfigHelper.getConfigWritePath('options.lua'), 'w')
		
		if file then
			local s = Serializer.new(file)
			s:serialize_sorted('options', options)
			file:close()
		else
			base.print(err)
		end
	end
end

function getOption(a_opt)
	loadOptions()
	return TableUtils.getTableValue(options,a_opt)
end

function setOption(a_opt, a_value)
	loadOptions()
	TableUtils.setTableValue(options, a_opt, a_value, true)
	saveOptions()
end







