local base = _G
local ConfigHelper = require('ConfigHelper')
--local TableUtils	= require('TableUtils')
local loadfile = base.loadfile

local defaultUnitsPayloads
--local unitPayloadsFilenames


local function recursiveCopyTable(dest, source)
    local _tablesList = {}
    
    function copy(dest, source, tablesList)
        
        for sourceKey, sourceValue in pairs(source) do
            if type(sourceValue) == 'table' then
                if tablesList[sourceValue] == nil then
                    dest[sourceKey] = dest[sourceKey] or {}
                    tablesList[sourceValue] = dest[sourceKey]                    
                    copy(dest[sourceKey], sourceValue, tablesList)
                else
                    dest[sourceKey] = tablesList[sourceValue]
                end
            else
                dest[sourceKey] = sourceValue
            end
        end
    end
    
    copy(dest, source, _tablesList)

end


local function loadUnitPayloads(a_filenames,a_dir)
    if lfs.attributes(a_dir) then
        for filename in lfs.dir(a_dir) do
            if filename ~= '.' and filename ~= '..' then
                a_filenames[filename] = filename
                unitPayloadsPaths[filename] = a_dir..'/'..filename
                --base.print("----unitPayloadsPaths]",filename,unitPayloadsPaths[filename] )  
            end
        end
    end
end

function getUnitPayloadFileNames()
	local filenames = {}
	local unitPayloadsSysFolder = ConfigHelper.getUnitPayloadsSysPath()
    unitPayloadsPaths= {}
      
	--print("----unitPayloadsSysFolder=",unitPayloadsSysFolder,	writeDirUnitPayloads)
    loadUnitPayloads(filenames, unitPayloadsSysFolder) 
    
    for i,plugin in ipairs(base.plugins) do
		if plugin.applied then
            local dir = plugin.dirName.."/UnitPayloads"
            --print("---dir----",dir)
            loadUnitPayloads(filenames,dir) 
        end
    end    
   
	return filenames
end



local function loadPayloads()
	-- загрузка базы данных	
	local filenames = getUnitPayloadFileNames()
	
	defaultUnitsPayloads = {}
    unitsPayloads = {}
	--unitPayloadsFilenames = {}
    
	for i, filename in pairs(filenames) do

		local path = unitPayloadsPaths[filename]
		local f, err = loadfile(path)
		
		if f then
			local ok, res = base.pcall(f)
			if ok then
				local unitPayloads = res
				local unitType = unitPayloads.unitType or unitPayloads.name
				defaultUnitsPayloads[unitType] = unitPayloads
				--unitPayloadsFilenames[unitType] = filename
			else
				log.error('ERROR: loadPayloads_() failed to pcall "'..filename..'": '..res)
			end				              
		else
			print('Cannot load payloads!',filename,path, err)
		end
	end
    
    recursiveCopyTable(unitsPayloads, defaultUnitsPayloads)

	return unitsPayloads
end

unitsPayloads = loadPayloads()