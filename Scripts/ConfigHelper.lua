-- общий механизм доступа к конфигурационным файлам
-- хранит конфиги в пользовательской папке, учитывает текущую версию формата конфигурационного файла

module("ConfigHelper", package.seeall)

local lfs = require('lfs')
local Serializer = require('Serializer')

if not lfs.writedir then
	lfs.writedir = function() return './' end
end

local writeDir = lfs.writedir()
local writeDirME = writeDir .. 'MissionEditor/'
local unitPayloadsPath = './MissionEditor/data/scripts/UnitPayloads/'
local unitPayloadsVPath = './MissionEditor/data/scripts/UnitPayloadsVehicles/'
local writeDirUnitPayloads = writeDirME .. 'UnitPayloads/'
local writeDirUnitPayloadsV = writeDirME .. 'UnitPayloadsVehicles/'
local tempOptionsME
local checkIfWriteDirUnitPayloadsExists = true
local checkIfWriteDirUnitPayloadsVExists = true

local filesList = 
{
	['options.lua'] = {userPath = lfs.writedir() .. 'Config/', sysPath = './MissionEditor/data/scripts/', ver = nil},
	['layers.lua'] = {userPath = writeDirME, sysPath = nil, ver = nil},
	['templates.lua'] = {userPath = writeDirME, sysPath = './MissionEditor/data/scripts/', ver = nil},
	['gdoptions.lua'] = {userPath = writeDirME, sysPath = './MissionEditor/data/MissionGenerator/GeneratorData/', ver = 2},
	['combattemplates.lua'] = {userPath = writeDirME, sysPath = './MissionEditor/data/MissionGenerator/GeneratorData/', ver = 2},
}

function getUserFilePath(dir, filename, vesrion)
	if vesrion == nil then 
		return dir .. filename 
	end
	
	local name, ext = string.match(filename, '([_%w%.]*)(%.%a*)$')
	return dir .. name .. '.v' .. tostring(vesrion) .. ext
end

function chooseFilePath(userDirPath, userFileName, currentVer, fullSysPath)
	local userFileParh = getUserFilePath(userDirPath, userFileName, currentVer)
	local attributes = lfs.attributes(userFileParh)
	
	if attributes and attributes.mode == 'file' then
		return	userFileParh
	else	
		return fullSysPath
	end	
end

function getConfigWritePath(filename)
	local value = filesList[filename]
	
	return value and getUserFilePath(value.userPath, filename, value.ver)
end

function getSysFilePath(filename)
    local value = filesList[filename]
	
	if value then
		return value.sysPath and value.sysPath .. filename    
	end	
end

function getConfigReadPath(filename)
	local value = filesList[filename]
	
	if value then
		return chooseFilePath(value.userPath, filename, value.ver, value.sysPath and value.sysPath .. filename) 
	end
end

function getUnitPayloadsSysPath()
	return unitPayloadsPath
end

function getUnitPayloadsVSysPath()
	return unitPayloadsVPath
end

function getUnitPayloadsWritePath(filename)
	if checkIfWriteDirUnitPayloadsExists then
		if not lfs.attributes(writeDirUnitPayloads) then
			lfs.mkdir(writeDirUnitPayloads)
		end
		
		checkIfWriteDirUnitPayloadsExists = false
	end
	
	return writeDirUnitPayloads .. filename
end

function getUnitPayloadsVWritePath(filename)
	if checkIfWriteDirUnitPayloadsVExists then
		if not lfs.attributes(writeDirUnitPayloadsV) then
			lfs.mkdir(writeDirUnitPayloadsV)
		end
		
		checkIfWriteDirUnitPayloadsVExists = false
	end
	
	return writeDirUnitPayloadsV .. filename
end

function getWriteDirUnitPayloads()
    return writeDirUnitPayloads
end   

function getWriteDirUnitPayloadsV()
    return writeDirUnitPayloadsV
end   