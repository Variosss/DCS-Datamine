
local MeSettings	= require('MeSettings')
local U                 = require('me_utilities')

local base = _G

local theatres_
local selectedTheatre_
local enableTheatresByName_ = {}


local function selectTheatreOfWar(theatreOfWarName, needSave)
	for i, theatre in ipairs(theatres_) do
		if theatre.name == theatreOfWarName then
			selectedTheatre_ = theatre	
            if needSave == true then
                MeSettings.setTheatreOfWar(theatreOfWarName)  
            end
			return true
		end
	end
    return false
end

local function verifyTheatreOfWar(theatreOfWarName)
    for i, theatre in ipairs(theatres_) do
		if theatre.name == theatreOfWarName then
            return true
		end
	end
    return false
end

local function load()
	theatres_ = base.theatres
    
    enableTheatresByName_ = {}
    for i, theatre in ipairs(theatres_) do
        enableTheatresByName_[theatre.name] = true
    end   
        
	selectedTheatre_ = theatres_[1]
    local theatreSett = MeSettings.getTheatreOfWar() 
    if theatreSett and selectTheatreOfWar(theatreSett) then
        print("Select TheatreOfWar: ",theatreSett)
 --   else
 --       selectTheatreOfWar('Caucasus')
    end
end

local function isEnableTheatre(a_name)
    return enableTheatresByName_[a_name] or false
end

local function verifyLeastOneTheatre()
    if theatres_[1] == nil then        
        return false
    end
    return true
end

local function getTheatresOfWar()
	local theatresOfWar = {}
	
	for i, theatre in ipairs(theatres_) do
        local theatreCopy = {}
        U.recursiveCopyTable(theatreCopy, theatre)
        table.insert(theatresOfWar, theatreCopy)		
	end
	
	return theatresOfWar
end

local function getTheatreOfWar(theatreOfWarName)
	for i, theatre in ipairs(theatres_) do
		if theatre.name == theatreOfWarName then
            local result = {}
            U.recursiveCopyTable(result, theatre)
			return result
		end
	end
end

local function getName()
	return selectedTheatre_.name
end

local function getImage()
	return selectedTheatre_.image
end

local function getLocalizedName(theatreOfWarName)
	for i, theatre in ipairs(theatres_) do
		if theatre.name == theatreOfWarName then
			return theatre.localizedName
		end
	end

	return theatreOfWarName
end

local function getMapFolder()
	return selectedTheatre_.folder
end

local function getTerrainConfig()    
    print("----getTerrainConfig===",selectedTheatre_.configFilename)
	return selectedTheatre_.configFilename
end


local function getBeaconsFile()
	return selectedTheatre_.beaconsFile
end

return {
	load					= load,
	getTheatresOfWar		= getTheatresOfWar,
	getTheatreOfWar			= getTheatreOfWar,
	
    isEnableTheatre         = isEnableTheatre,
	selectTheatreOfWar		= selectTheatreOfWar,
	getName					= getName,
	getImage				= getImage,
	getLocalizedName		= getLocalizedName,
	getMapFolder			= getMapFolder,
	getTerrainConfig		= getTerrainConfig,
	getBeaconsFile			= getBeaconsFile,
    verifyTheatreOfWar      = verifyTheatreOfWar,
    verifyLeastOneTheatre   = verifyLeastOneTheatre,
}