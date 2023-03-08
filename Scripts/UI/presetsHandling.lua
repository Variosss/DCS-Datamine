local base = _G

module('presetsHandling')

--local TableUtils = require('TableUtils')
local U  = base.require('me_utilities')
local lfs = base.require('lfs')  
local Serializer	= base.require('Serializer')
 
local instByTypePresets = nil
local instByTypeRadios = {} -- только добавленные юзером
local presetsById = nil
local pathToSave = lfs.writedir() .. "Config\\DynamicRadios\\Presets\\"

local function copyTable(target, src)
	base.assert(target ~= src)
    if not target then
        target = {}
    end
	
    for i, v in base.pairs(src) do
        if base.type(v) == 'table' then
            if not target[i] then
                target[i] = {}
            end
            copyTable(target[i], v)
        else
            target[i] = v
        end
    end
	
    return target
end

function newPreset(preset_id, Name, basedOn)
	local res = {}
	
	if basedOn ~= nil and base.type(basedOn) == "table" then
		copyTable(res, basedOn)
		--TableUtils.recursiveCopyTable(basedOn, res)
	else
		-- Fill table with default values
	
		res.Name 				= Name	
		res.Ranges 				= { {minFreq = 225000000, maxFreq = 400000000, modulation = 0} } -- was taken from ARC-164
		res.Step 				= 1000
		res.Guards    			= { {freq = 243000000,  modulation = 0} }  -- was taken from ARC-164, guard for UHF
		res.Squelch   			= true
		res.Power 				= { {value = 10} }
		res.InnerNoise 			= 1.1561e-06
		res.FrequencyAccuracy 	= 1000
		res.BandWidth 			= 20000
		res.Channels 			= { }
		res.Encryption 			= { key = 1, enable = false, present = false }

		-- AGC
		res.InputSD 			= 50
		res.OutputSD 			= 5
		res.InputSLZ 			= 10
		res.RegulationTime 		= 0.25 -- not used

		-- AMD
		res.MinSearchTime 		= 0
		res.MaxSearchTime 		= 0
	end
	
	res.ID = preset_id
	
	
	return res
end

local function loadFromPath(a_path, a_nameTbl)
	local f, err = base.loadfile(a_path)

	if f then
		local env = {}
		
		base.setfenv(f, env)
		
		local ok, res = base.pcall(f)
		
		if ok then
			return env[a_nameTbl]
		end
	end
	
	return nil
end

function getUnitPresets(a_unitType)
	if instByTypePresets[a_unitType] then
		return copyTable(nil, instByTypePresets[a_unitType])
	else
		return {}
	end	
end

function addPresetToUnit(a_unitType, a_ID)	
	local preset = getPreset(a_ID)
	if preset then
		instByTypePresets[a_unitType] = instByTypePresets[a_unitType] or {}
		base.table.insert(instByTypePresets[a_unitType], preset)
		instByTypeRadios[a_unitType] = instByTypeRadios[a_unitType] or {}
		base.table.insert(instByTypeRadios[a_unitType], a_ID)
		savePresetsUnit(a_unitType)
	end	
end

function addNewPresetToUnit(a_unitType, a_ID, a_Name)
	local preset = newPreset(a_ID, a_Name)
	savePresetToFile(a_ID, preset)
	preset.type = "users"
	preset.file = a_ID
	presetsById[a_ID] = preset
	
	addPresetToUnit(a_unitType, a_ID)	
end

local function removeFromInstByTypePresets(a_unitType, a_ID)
	for k,v in base.pairs(instByTypePresets[a_unitType]) do
		if v.ID == a_ID then
			base.table.remove(instByTypePresets[a_unitType],k)
			return
		end
	end
end	

local function removeFromInstByTypeRadios(a_unitType, a_ID)
	for k,v in base.pairs(instByTypeRadios[a_unitType]) do
		if v == a_ID then
			base.table.remove(instByTypeRadios[a_unitType],k)
			return
		end
	end
end
	

function removePresetFromUnit(a_unitType, a_ID)
	removeFromInstByTypePresets(a_unitType, a_ID)
	removeFromInstByTypeRadios(a_unitType, a_ID)
	savePresetsUnit(a_unitType)
end

function isValidId(a_ID)
	if a_ID == nil then
		return false
	end
	local id = base.string.gsub(a_ID, "%s+", "")
	if id == "" then
		return false
	end	
	return presetsById[a_ID] == nil
end

function isValidAdd(a_unitType, a_ID)
	if instByTypePresets[a_unitType] then
		for k,v in base.pairs(instByTypePresets[a_unitType]) do
			if v.ID == a_ID then
				return false
			end
		end
	end
	
	return true
end

function loadAllPresets()
	presetsById = {}
	for filename in lfs.dir(lfs.currentdir() .. "Config\\DynamicRadios\\Presets") do
		if filename ~= '.' and filename ~= '..' then
			local res = loadFromPath(lfs.currentdir() .. "Config\\DynamicRadios\\Presets\\"..filename, "preset")
			if res then
				res.type = "notEditable"
				presetsById[res.ID] = res
			end
		end
	end

	for filename in lfs.dir(lfs.writedir() .. "Config\\DynamicRadios\\Presets") do
		if filename ~= '.' and filename ~= '..' then
			local res = loadFromPath(lfs.writedir() .. "Config\\DynamicRadios\\Presets\\"..filename, "preset")
			if res then
				res.type = "users"
				res.file = base.string.match(filename, '(.*)%..*$')
				presetsById[res.ID] = res
			end
		end
	end
	
	for k, v in base.pairs(presetsById) do
		for kk, channel in base.pairs(v.Channels) do
			if channel.number == nil then
				channel.number = kk
			end
		end
	end
end

local function getPresetIdMod(a_id, a_modulId)
	return a_id.."("..a_modulId..")"
end

function loadModRadios()
	for i,plugin in base.ipairs(base.plugins) do
		if plugin.applied then
			local dir = plugin.dirName.."/VOIP_Radios"
			local tmpPresets = {} -- пресеты этого модуля с неизмененными id
			
			local b = lfs.attributes(dir)
			if b then
				local dirPresets = dir.."/Presets"
				local a = lfs.attributes(dirPresets)
				if a then
					for filename in lfs.dir(dirPresets) do
						if filename ~= '.' and filename ~= '..' then
							local res = loadFromPath(lfs.currentdir() .. dirPresets .. "/" .. filename, "preset")
							if res then
								res.Modul = true
								tmpPresets[res.ID] = res
								res.ID = getPresetIdMod(res.ID, plugin.id)
								presetsById[res.ID] = res					
							end
						end
					end
				end

				local dirInst = dir.."/Installations"
				a = lfs.attributes(dirInst)
				if a then
					for filename in lfs.dir(dirInst) do
						if lfs.attributes(dirInst.."/"..filename,'mode') == 'file' then	
							local typeUnit = base.string.match(filename, '(.*)%..*$')
							local res = loadFromPath(lfs.currentdir() .. dirInst .. "/" .. typeUnit .. ".lua", "radios")										
							if res then
								for k,id in base.ipairs(res) do
									local preset = tmpPresets[id] or getPreset(id)
									if preset then
										preset.type = "notRemovable"
										instByTypePresets[typeUnit] = instByTypePresets[typeUnit] or {}
										base.table.insert(instByTypePresets[typeUnit], preset)
									end
								end
							end
						end	
					end
				end	
			end
		end
	end	
end

function getPreset(a_id)
	if presetsById[a_id] then
		return copyTable(nil, presetsById[a_id])
	end
end

function getAllPresets()
	local result = {}
	if presetsById then
		for k,v in base.pairs(presetsById) do		
			base.table.insert(result,{name = v.Name, DisplayName = v.Name, ID = v.ID, preset = v})
		end
	end
	return result
end

function savePresetToFile(a_fileName, a_preset)
	local filename = pathToSave .. a_fileName .. ".lua"
	local preset = {}
	copyTable(preset, a_preset)
	presetsById[a_preset.ID] = {}
	copyTable(presetsById[a_preset.ID], preset)
 
	local file, err = base.io.open(filename, 'w')
	if file then
		local s = Serializer.new(file)				
		preset.ID = a_fileName
		preset.type = nil
		preset.file = nil
		s:serialize_simple('preset', preset)
		file:close()
	else
		base.print(base.string.format('Cannot save preset into file[%s]! Error %s', filename, err))
		return false
	end
	
	return true
end

function savePresetsUnit(unit_type)
	local pathToSave = lfs.writedir() .. "Config\\DynamicRadios\\Installations\\"
	local filename = pathToSave .. unit_type .. ".lua"
	local file, err = base.io.open(filename, 'w')
	
	local toSave = {}
	for k,v in base.ipairs(instByTypeRadios[unit_type]) do
		if presetsById[v] ~= nil and presetsById[v].Modul ~= true then
			base.table.insert(toSave, v)
		end
	end
	
	if file then
		local s = Serializer.new(file)
		s:serialize_simple('radios', toSave)
		file:close()
	else
		base.print(string.format('Cannot save radios into file[%s]! Error %s', filename, err))
		return false
	end
	
	return true
end
----------------------------------------------------



function init()
	if not lfs.dir(pathToSave)() then
		-- create 'DynamicRadios\\Presets' directory
		lfs.mkdir(pathToSave)
	end
	
	do
		local pathToSaveInstallations = lfs.writedir() .. "Config\\DynamicRadios\\Installations\\"
		if not lfs.dir(pathToSaveInstallations)() then
			-- create 'DynamicRadios\\Installations' directory
			lfs.mkdir(pathToSaveInstallations)
		end
	end
	
	loadAllPresets()
	
	instByTypePresets = {}
	local path = lfs.currentdir() .. "Config\\DynamicRadios\\Installations\\" 
	for filename in lfs.dir(path) do
		if lfs.attributes(path..filename,'mode') == 'file' then			
			local typeUnit = base.string.match(filename, '(.*)%..*$')
			local res = loadFromPath(lfs.currentdir() .. "Config\\DynamicRadios\\Installations\\" .. typeUnit .. ".lua", "radios")			
			if res then
				for k,id in base.ipairs(res) do
					local preset = getPreset(id)
					preset.type = "notRemovable"
					if preset then
						instByTypePresets[typeUnit] = instByTypePresets[typeUnit] or {}
						base.table.insert(instByTypePresets[typeUnit], preset)
					end
				end
			end
		end	
	end
	
	local path = lfs.writedir() .. "Config\\DynamicRadios\\Installations\\"
	for filename in lfs.dir(path) do
		if lfs.attributes(path..filename,'mode') == 'file' then			
			local typeUnit = base.string.match(filename, '(.*)%..*$')
			
			local res = loadFromPath(lfs.writedir() .. "Config\\DynamicRadios\\Installations\\" .. typeUnit .. ".lua", "radios")
			instByTypeRadios[typeUnit] = res
			if res then
				for k,id in base.ipairs(res) do
					local preset = getPreset(id)
					
					if preset and preset.Modul ~= true then
						instByTypePresets[typeUnit] = instByTypePresets[typeUnit] or {}
						base.table.insert(instByTypePresets[typeUnit], preset)
					end
				end
			end
		end	
	end
	
	if base.plugins then
		loadModRadios()
	end
end

init()



























