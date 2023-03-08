local base = _G

module('me_managerModulesME')

local require	= base.require
local math		= base.math
local pairs		= base.pairs
local ipairs	= base.ipairs
local table		= base.table
local print		= base.print


local DialogLoader 			= require('DialogLoader')
local net    				= require('net')
local CoalitionUtils		= require('Mission.CoalitionUtils')
local CoalitionData			= require('Mission.CoalitionData')
local lfs 					= require('lfs')
local S 					= require('Serializer')
local CheckBox				= require('CheckBox')
local Static				= require('Static')
local ListBoxItem			= require('ListBoxItem')
local Button				= require('Button')
local UpdateManager			= require('UpdateManager')
local FileDialogFilters		= require('FileDialogFilters')
local FileDialog 			= require('FileDialog')
local SkinUtils				= require('SkinUtils')

modulesME = {}
moduleMainMenu = nil
addedFileDialogFilters = nil

--калбеки
callBack_getBriefing = nil
callBack_getEditorDBThreats = nil
callBack_getThreatsById = nil

--калбеки END


function init()
	modulesME = {}

	for k,module_ in pairs(base.plugins) do
        if module_.applied then
			if module_.callbacksME ~= nil then				
				print("---addmodulesME---", module_.id, module_.callbacksME.mainMenuME)
				
				if module_.callbacksME.mainMenuME == true then
					moduleMainMenu = module_.callbacksME
				else	
					modulesME[module_.id] = module_.callbacksME
				end
				
				if module_.callbacksME.init ~= nil then
					module_.callbacksME.init(meAPI, module_.dirName)
				end
				
				if callBack_getBriefing == nil and module_.callbacksME.getBriefing ~= nil then
					callBack_getBriefing = module_.callbacksME.getBriefing
				else
					print("Duplicate callback: SKIPPED in modul '"..module_.id.."': getBriefing")
				end
				
				if callBack_showEditorDBThreats == nil and module_.callbacksME.showEditorDBThreats ~= nil then
					callBack_showEditorDBThreats = module_.callbacksME.showEditorDBThreats
				else
					print("Duplicate callback: SKIPPED in modul '"..module_.id.."': showEditorDBThreats")
				end
				
				if module_.callbacksME.addFileDialogFilters ~= nil then
					addedFileDialogFilters = addedFileDialogFilters or {}
					local filter = module_.callbacksME.addFileDialogFilters					
					addedFileDialogFilters[module_.callbacksME.addFileDialogFilters.name] = module_.callbacksME.addFileDialogFilters.value	

					base.FileDialogFilters[filter.name] = function()
						return filter.value
					end						
				end
				
				if callBack_getThreatsById == nil and module_.callbacksME.getThreatsById ~= nil then
					callBack_getThreatsById = module_.callbacksME.getThreatsById
				end

			end	
			
			
		end
	end	
		
	JSON = (base.loadfile "Scripts/JSON.lua")()	
end

function createDialog(a_file, cdata)	
	local window = DialogLoader.spawnDialogFromFile(a_file, cdata)
	return window
end

function createMenu(a_mainMenu, a_newMenu)

end

--Калбеки
local function getBriefing()
	return callBack_getBriefing
end

local function loadDBThreats()
	local fileDB = lfs.writedir() .. 'MissionEditor/DBThreats.lua'
	local b = lfs.attributes(fileDB) 
    if not b or b.mode ~= 'file' then  
        return nil
    end
        
    local func, err = base.loadfile(fileDB)            
    if func then
        local env = {}		
        base.setfenv(func, env)
        local ok, err = base.pcall(func)
        if ok then
            return env
        else
            base.print("ERROR pcall: ", err, fileDB)
        end
    else
        base.print("ERROR loadfile: ", err, fileDB)
    end    
	
	return nil
end

local function saveDBThreats(a_tbl)
	local f = base.io.open(lfs.writedir() .. 'MissionEditor/DBThreats.lua', 'w')
    if f then
        local s = S.new(f)
        s:serialize_simple2('MCThreats', a_tbl)
        f:close()
    end
end

local function ExportToJSON(a_tbl, a_filterName, a_text )
	local path = lfs.writedir()
	local filters = {FileDialogFilters[a_filterName]()}				
	local filename = FileDialog.save(path, filters, a_text)				
	
	if filename then
		if a_tbl then
			local f, err = base.io.open(filename, 'w')
			
			if f then
				local serializer = S.new(f)
				local raw_json_text    = JSON:encode_pretty(a_tbl)		
				f:write(raw_json_text)
				f:close()
			else
				return false
			end 
		end
		
		return true
	end
end

local function ImportFromJSON(a_filterName, a_text )
	local path = lfs.writedir()
	local filters = {FileDialogFilters[a_filterName]()}				
	local filename = FileDialog.open(path, filters, a_text)	
	local result
	
	if filename then
		local file = base.io.open(filename, 'rb')
		if file then
			local s = file:read('*a')
			result = JSON:decode(s)
			file:close()
		end    
	end
	return result
end
--Калбеки End



meAPI = {
	["createDialog"] 		= createDialog,
	["createMenu"] 			= createMenu,
	["version"] 			= base.START_PARAMS.version,
	["net"] 				= net,
	["getBriefingPanel"] 	= getBriefingPanel,
	["CoalitionUtils"]		= CoalitionUtils,
	["CoalitionData"] 		= CoalitionData,
	["loadDBThreats"] 		= loadDBThreats,
	["saveDBThreats"] 		= saveDBThreats,
	["CheckBox"] 			= CheckBox,
	["Static"]  			= Static,
	["ListBoxItem"] 		= ListBoxItem,
	["Button"]  			= Button,
	["UpdateManager"]		= UpdateManager,
	["ExportToJSON"]  		= ExportToJSON,
	["ImportFromJSON"]  	= ImportFromJSON,
	["SkinUtils"]			= SkinUtils,
}