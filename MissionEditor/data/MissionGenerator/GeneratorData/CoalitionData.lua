local base = _G
--userDataDir			= lfs.writedir() .. 'MissionEditor/'
--local userDataDir = base.userDataDir

local lfs = require('lfs')  -- Lua File System
local userDataDir			= lfs.writedir() .. 'MissionEditor/'
local function copyTable(target, src)
	assert(target ~= src)
	
	if not target then
		target = {}
	end
	
	for i, v in pairs(src) do
		if type(v) == 'table' then
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


local coalitions_
local presets_ = {}
local idPreset_ = "dafault"
local defCoalition_



local dbCountries_
function getCountries()
	local countries = {}
	
	for i, country in ipairs(db.Countries) do
		countries[country.WorldID] = {
			name 		= country.Name, 
			flag 		= country.flag,
			flag_small  = country.flag_small,
            InternationalName = country.InternationalName,
			ShortName   = country.ShortName,
		}
	end
	
	return countries
end



local function getDbCountries()
	if not dbCountries_ then
		dbCountries_ = getCountries()
	end	
	
	return dbCountries_
end


local function getCountryNameById(countryId)
	return getDbCountries()[countryId].name
end

local function getCountryById(countryId)
	return getDbCountries()[countryId]
end

local function mergeCoalitions(defCoalition, userCoalitions)
    local result = {}
    
    function getCoalitionCountryUser(idCountryDef)
        for nameCoalitionUser, coalitionUser in pairs(userCoalitions) do
            for kk, idCountryUser in pairs(coalitionUser) do
                if (idCountryDef == idCountryUser) then
                    return nameCoalitionUser
                end
            end
        end
        return nil
    end
    
    for nameCoalitionDef, coalitionDef in pairs(defCoalition) do
        for kk, idCountryDef in pairs(coalitionDef) do
            nameCoalition = getCoalitionCountryUser(idCountryDef)
            if nameCoalition then
                result[nameCoalition] = result[nameCoalition] or {}
                table.insert(result[nameCoalition], idCountryDef)
            else
                result[nameCoalitionDef] = result[nameCoalitionDef] or {}
                table.insert(result[nameCoalitionDef], idCountryDef)
            end    
        end    
    end
    
    return result
end

local function loadPreset(a_file)
    local func, err = loadfile(a_file)    
    
    if func then
		local env = {  _ = _}		
		setfenv(func, env)
		func()		
        local preset = 
        { 
            coalitions = mergeCoalitions(defCoalition_, env.coalitions),
            name = env.name,
            id = env.id
        }
        presets_[env.id] = preset      
	else
		print(err)
	end    
end

local function loadPresets()
    presets_ = {}
    local dirName = './MissionEditor/data/scripts/PresetsCoalitions'
    for file in lfs.dir(dirName) do 
		local fullNameFile  = dirName .. '/' .. file
		local b = lfs.attributes(fullNameFile)
		
		if (b.mode == 'file') then
            loadPreset(fullNameFile)
		end
	end
end

local function getPresets()
    return copyTable(nil, presets_ or {})
end

local function loadDefaultCoalitions()    
    local userCoalitions = {}
    defCoalition_ = {}
	local func, err = loadfile(userDataDir .. 'default_coalitions.lua')
    
    if func then
		local env = {}
		
		setfenv(func, env)
		func()
		
		userCoalitions = env.coalitions
	else
		print(err)
	end

	func, err = loadfile('./MissionEditor/data/scripts/default_coalitions.lua')

    if func then
		local env = {}
		
		setfenv(func, env)
		func()
		
		defCoalition_ = env.coalitions
	else
		print(err)
	end
    
    if defCoalition_.neutrals == nil then
	   defCoalition_.neutrals = {}
	end
    
    local united_nations_list = getDbCountries()
	
	local find_country = function (lst,country) 
		for i,o in pairs(lst) do
			if country == o then 
				return true
			end
		end
		return false
	end
	
	for i,o in pairs(united_nations_list) do
		if not find_country(defCoalition_.red,i) and 
		   not find_country(defCoalition_.blue,i) and
		   not find_country(defCoalition_.neutrals,i) then
		   defCoalition_.neutrals[#defCoalition_.neutrals + 1] = i
		end  
	end
    
    loadPresets()
	return mergeCoalitions(defCoalition_, userCoalitions)
end

local function redCoalitionName()
	return 'red'
end

local function blueCoalitionName()
	return 'blue'
end

local function neutralCoalitionName()
	return 'neutrals'
end


local function getIdUserPreset()
    return "Custom"
end

local function setDefaultCoalitions()
	coalitions_ = loadDefaultCoalitions()
    idPreset_ = getIdUserPreset()
end

local function getDefaultCoalitions()
	return loadDefaultCoalitions()
end

local function getCoalitions_()
	if not coalitions_ then
		coalitions_ = loadDefaultCoalitions()
	end
	
	return coalitions_
end

local function setIdPreset(id)
    idPreset_ = id
end

local function getRedCoalition()
    if idPreset_ == getIdUserPreset() then
        return copyTable(nil, getCoalitions_()[redCoalitionName()] or {})
    else
        return copyTable(nil, presets_[idPreset_].coalitions[redCoalitionName()] or {})
    end    
end

local function getBlueCoalition()
    if idPreset_ == getIdUserPreset() then
        return copyTable(nil, getCoalitions_()[blueCoalitionName()] or {})
    else
        return copyTable(nil, presets_[idPreset_].coalitions[blueCoalitionName()] or {})
    end     
end

local function getNeutralCoalition()
    if idPreset_ == getIdUserPreset() then
        return copyTable(nil, getCoalitions_()[neutralCoalitionName()] or {})
    else
        return copyTable(nil, presets_[idPreset_].coalitions[neutralCoalitionName()] or {})
    end 
end

local function setCoalitions(redCoalition, blueCoalition, neutralCoalition)
	coalitions_ = {
		[redCoalitionName()]		= copyTable(nil, redCoalition),
		[blueCoalitionName()]		= copyTable(nil, blueCoalition),
		[neutralCoalitionName()]	= copyTable(nil, neutralCoalition),
	}
	
	onChangeCoalitions()
end

local function getCoalitions()
	return {
		[redCoalitionName()]		= getRedCoalition(),
		[blueCoalitionName()]		= getBlueCoalition(),
		[neutralCoalitionName()]	= getNeutralCoalition(),
	}
end


local function getCoalitionByContryId(a_id)
	for i, countryId in ipairs(getRedCoalition()) do
		if a_id == countryId then
			return redCoalitionName()
		end
	end
	
	for i, countryId in ipairs(getBlueCoalition()) do
		if a_id == countryId then
			return blueCoalitionName()
		end
	end
	
	for i, countryId in ipairs(getNeutralCoalition()) do
		if a_id == countryId then
			return neutralCoalitionName()
		end
	end
end



local def_coalitions = {}
coalitions = {}

function Init()
end

--function Init()

	setDefaultCoalitions()

	def_coalitions.blue = getBlueCoalition()
	def_coalitions.red = getRedCoalition()
	def_coalitions.neutrals = getNeutralCoalition()

	local cltProb = 0
	for k, coalition in pairs({"red", "blue", "neutrals"}) do 
		coalitions[coalition] = {}  
		if def_coalitions[coalition] then
			for kk,countryId in pairs(def_coalitions[coalition]) do
				if coalition == "neutrals" then 
					cltProb = 0
				else
					cltProb = 1
				end
				table.insert(coalitions[coalition],{name = getCountryById(countryId).InternationalName,cltProbability = cltProb})
			end
		end
	end
--end

function getDefaultCoalitions_new()
	local cltProb = 0
	for k, coalition in pairs({"red", "blue", "neutrals"}) do 
		coalitions[coalition] = {}  
		if def_coalitions[coalition] then
			for kk,countryId in pairs(def_coalitions[coalition]) do
				if coalition == "neutrals" then 
					cltProb = 0
				else
					cltProb = 1
				end
				table.insert(coalitions[coalition],{name = getCountryById(countryId).InternationalName,cltProbability = cltProb})
			end
		end
	end
	--return coalitions
end

function getCoalitionById(id)

	coalitions = {}

	if id == 'default' then
		return getDefaultCoalitions_new()
	end

	local presets = getPresets()    
    for i, preset in pairs(presets) do
        if preset.id == id then
			--coalitions.coalitions = preset.coalitions
			local cltProb = 0
			for k, coalition in pairs({"red", "blue", "neutrals"}) do 
				coalitions[coalition] = {}  
				if preset.coalitions[coalition] then
					for kk,countryId in pairs(preset.coalitions[coalition]) do
						if coalition == "neutrals" then 
							cltProb = 0
						else
							cltProb = 1
						end
						table.insert(coalitions[coalition],{name = getCountryById(countryId).InternationalName,cltProbability = cltProb})
					end
				end
			end
		end
    end
	--return coalitions
end

function getCoalitionsByPreset(id)
	
	if id == 'default' then
		return def_coalitions
	end

	local presets = getPresets()    
    for i, preset in pairs(presets) do
        if preset.id == id then
			return preset.coalitions
		end
	end

	return loadDefaultCoalitions()
end