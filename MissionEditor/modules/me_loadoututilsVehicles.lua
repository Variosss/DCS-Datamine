local base = _G

module('me_loadoututilsVehicles')

local require 	= base.require
local pairs 	= base.pairs
local ipairs 	= base.ipairs
local tonumber 	= base.tonumber
local table 	= base.table
local tostring 	= base.tostring
local string 	= base.string
local assert 	= base.assert
local print 	= base.print
local loadfile 	= base.loadfile

local SkinUtils 		= require('SkinUtils')
local Panel 			= require('Panel')
local DB 				= require('me_db_api')
local Static 			= require('Static')
local Menu 				= require('Menu')
local MenuItem 			= require('MenuItem')
local MenuSeparatorItem	= require('MenuSeparatorItem')
local MenuSubItem 		= require('MenuSubItem')
local Serializer 		= require('Serializer')
local ConfigHelper 		= require('ConfigHelper')
local UpdateManager 	= require('UpdateManager')
local lfs 				= require('lfs')
local TableUtils		= require('TableUtils')
local U 				= require('me_utilities')
local log      			= require('log')


require('i18n').setup(_M)

local gettext = require("i_18n")

local modifiedUnitType_
local translatedStrings_ = {}
local defaultPresetId = "Default"
local missionPresetId = "Mission"

cdata = 
{
	enter_payload_name 			= _('Enter payload name:'),
	new_payload 				= _('New Payload'),
	copy_ 						= _('Copy '),
	delete_payload 				= _('Delete payload '),
	delete_payload_from_task 	= _('Delete payload %s from task %s?'),
	payload_name_is_not_unique 	= _('Payload name is not unique!\nPayload %s is used.'),
	payload_name_is_not_valid 	= _('Payload name is not valid (empty or contains \' or ")!'),
	invalid_mission_payload		= _('Mission payload is not equal to any unit payload. Save mission payload?'), 
	save_payload 				= _('SAVE PAYLOAD'),
	error 						= _('ERROR'),
	remove 						= _('REMOVE'),
	export_payload_to_task 		= _('Export payload to task:'),
}

function translate(str)
	local result = translatedStrings_[str]
	
	if not result then
		result = gettext.dtranslate("payloads", str)
		translatedStrings_[str] = result
	end

	return result
end

function getDefaultPresetId()
    return defaultPresetId
end

function getMissionPresetId()
    return missionPresetId
end



function getPresetId(a_unit)
    local presetId
    
    if a_unit.ammo then
        local defAmmo = getAmmo(a_unit.type, defaultPresetId)
        local unitPayloads = getUnitPayloads(a_unit.type)
    
        for k, payload in base.pairs(unitPayloads) do            
            if TableUtils.compareTables(payload.ammo, defAmmo) == true then
                presetId = payload.name
            end
        end
        
        if presetId == nil then
            presetId = missionPresetId
        end
    else
        presetId = defaultPresetId
    end
    
    
    return presetId
end


local function loadUnitPayloads(a_filenames,a_dir)
    if lfs.attributes(a_dir) then
        for filename in lfs.dir(a_dir) do
            if filename ~= '.' and filename ~= '..' then
                a_filenames[filename] = filename
                unitPayloadsPaths[filename] = a_dir..'/'..filename
            end
        end
    end
end

function getAmmo(a_unitType, a_payloadId)
    if a_payloadId == defaultPresetId then
        return getAmmoUnitDef(a_unitType)
    end
    
    if unitsPayload[a_unitType] then
        for k,v in base.pairs(unitsPayload[a_unitType].payloads) do
            if v.name == a_payloadId then
                return v.ammo
            end
        end
    end
    return {} 
end

local function getTmplAmmoUnit(a_unit, a_unitIndex)
	for i = a_unitIndex-1, 1, -1 do
		if a_unit.boss.units[i].type == a_unit.type then
			return a_unit.boss.units[i].ammo
		end
	end
	for i = a_unitIndex+1, #a_unit.boss.units, 1 do
		if a_unit.boss.units[i].type == a_unit.type then
			return a_unit.boss.units[i].ammo
		end
	end
end

function setDefaultAmmoToUnit(a_unit, a_unitIndex)
	local unitType = a_unit.type	
	
	local tmplAmmo = getTmplAmmoUnit(a_unit, a_unitIndex)
	if tmplAmmo then
		a_unit.ammo = {}
		U.recursiveCopyTable(a_unit.ammo, tmplAmmo) 
	else
		local ammoDef,ammoDefByStwID = getAmmoUnitDef(unitType)
		a_unit.ammo = nil
		
		if ammoDef then
			a_unit.ammo = {}
			U.recursiveCopyTable(a_unit.ammo, ammoDef) 
		end	
	end
end

function getAmmoUnitDef(unitType)
    local unitDef = DB.unit_by_type[unitType]
    local result
    local ammoByStwID
    
    if unitDef and unitDef.WS then        
        for k,WS in base.pairs(unitDef.WS) do
            if base.type(WS) == 'table' and WS.LN then
                for kk,LN in base.pairs(WS.LN) do
                    if LN.PL then
                        for kkk,PL in base.pairs(LN.PL) do
                            if PL.virtualStwID ~= nil then
                                result = result or {}
                                result.WS = result.WS or {}
                                result.WS[k] = result.WS[k] or {}
                                result.WS[k].LN = result.WS[k].LN or{}
                                result.WS[k].LN[kk] = result.WS[k].LN[kk] or {}
                                result.WS[k].LN[kk].PL = result.WS[k].LN[kk].PL or {}
                                result.WS[k].LN[kk].PL[kkk] = result.WS[k].LN[kk].PL[kkk] or {}
                                result.WS[k].LN[kk].PL[kkk].ammo_capacity 	= PL.ammo_capacity
                                result.WS[k].LN[kk].PL[kkk].virtualStwID 	= PL.virtualStwID
                                result.WS[k].LN[kk].PL[kkk].name 			= PL.display_shell_name or PL.name_ammunition or PL.shell_name[1]
                                
                                ammoByStwID = ammoByStwID or {}
                                ammoByStwID[PL.virtualStwID] = ammoByStwID[PL.virtualStwID] or {} 
                                local name = PL.display_shell_name or PL.name_ammunition or PL.shell_name[1]
                                ammoByStwID[PL.virtualStwID][kk] = ammoByStwID[PL.virtualStwID][kk] or {}
                                ammoByStwID[PL.virtualStwID][kk].ammo_capacity 	= PL.ammo_capacity
                                ammoByStwID[PL.virtualStwID][kk].keyWS 			= k
                                ammoByStwID[PL.virtualStwID][kk].keyLN 			= kk
                                ammoByStwID[PL.virtualStwID][kk].keyPL 			= kkk
								ammoByStwID[PL.virtualStwID][kk].name  			= name                             
                            end
                        end
                    end
                end
            end
        end
    end

    return result, ammoByStwID
end

function getUnitPayloads(unitType)
	local unit = unitsPayload[unitType]
	
	if not unit then 
		unit = 	{ 
			name  	 = unitType,
			unitType = unitType,
			payloads = {}
		}
		unitsPayload[unitType] = unit
	end
	
	return unit.payloads
end

function getPayloadNamePresented(unitType, payloadName)
	local payloads = getUnitPayloads(unitType)

	for i, payload in ipairs(payloads) do
		local currPayloadName = payload.name
		
		if payloadName == currPayloadName then
			return true
		end
		
		local translatedPayloadName = translate(payloadName)
			
		if translatedPayloadName == currPayloadName then
			return true
		end
		
		local translatedCurrPayloadName = translate(currPayloadName)
		
		if payloadName == translatedCurrPayloadName then
			return true
		end
				
		if translatedPayloadName == translatedCurrPayloadName then
			return true
		end
	end

	return false
end

function getUnitPayloadFileNames()
	local filenames = {}
	local unitPayloadsSysFolder = ConfigHelper.getUnitPayloadsVSysPath()
    unitPayloadsPaths= {}
      
    loadUnitPayloads(filenames, unitPayloadsSysFolder) 
    
    for i,plugin in ipairs(base.plugins) do
		if plugin.applied then
            local dir = plugin.dirName.."/UnitPayloadsVehicles"
            loadUnitPayloads(filenames,dir) 
        end
    end       
   
	return filenames
end

function filterDefault(a_ammo, a_type)
	local ammoDef,ammoDefByStwID = getAmmoUnitDef(a_type)
	
	if a_ammo and a_ammo.WS and ammoDef and ammoDef.WS then        
        for k,WS in base.pairs(a_ammo.WS) do
            if base.type(WS) == 'table' and WS.LN and ammoDef.WS[k] and ammoDef.WS[k].LN then
                for kk,LN in base.pairs(WS.LN) do
                    if LN.PL and ammoDef.WS[k].LN[kk].PL then
                        for kkk,PL in base.pairs(LN.PL) do                           
                            if PL.ammo_capacity ~= nil 
                                and ammoDef.WS[k].LN[kk].PL[kkk] and ammoDef.WS[k].LN[kk].PL[kkk].ammo_capacity ~= nil
                                and ammoDef.WS[k].LN[kk].PL[kkk].ammo_capacity ~= PL.ammo_capacity then
                                
								return a_ammo
                            end
                        end
                    end
                end
            end
        end
    end
	
	return nil
end

function createPayloadTable(payloadName)
	return {
		name = payloadName,
        ammo = {},
	}
end

function addPayload(unitType, payloadName)
	local payload
	local payloads = getUnitPayloads(unitType)
	
	if payloads then
		payload = createPayloadTable(payloadName)
		table.insert(payloads, payload)
		
		local ammoDef,ammoDefByStwID = getAmmoUnitDef(unitType)
		TableUtils.recursiveCopyTable(payload.ammo, ammoDef) 
		
		setModified(unitType)
	end

	return payload
end

function setModified(unitType)
	modifiedUnitType_ = unitType
	UpdateManager.add(save)
end

function save()
	if modifiedUnitType_ then
		saveUnitPayloads(modifiedUnitType_)
		modifiedUnitType_ = nil
		
		-- удаляем себя из UpdateManager
		return true
	end
end

function saveUnitPayloads(unitType)
	local filename = unitPayloadsFilename[unitType] or unitType..".lua"
    local savedPayload = {}
    TableUtils.recursiveCopyTable(savedPayload, unitsPayload[unitType])
    
    local defaultUnitPayload = baseUnitsPayload[unitType]  
    
    local removePay ={}    
    local removeTab ={}
    for k,payload in base.pairs(savedPayload.payloads) do  
        if defaultUnitPayload ~= nil then
            for kk, defPayload in base.pairs(defaultUnitPayload.payloads) do            
                if payload.name == defPayload.name then                    
                    if TableUtils.compareTables(payload,defPayload) == true then
                        base.table.insert(removeTab,k)
                    end
                end
            end
        end
    end
    
    for i = #removeTab, 1, -1 do
        base.table.remove(savedPayload.payloads, removeTab[i]) 
    end
    
    if #savedPayload.payloads == 0 then
        local path = ConfigHelper.getUnitPayloadsVWritePath(filename)   
        base.os.remove(path) 
        return    
    end
	
	if filename then		
		local path = ConfigHelper.getUnitPayloadsVWritePath(filename)
		local file, err = base.io.open(path, 'w')
		
		if file then
			file:write('local ')
			local s = Serializer.new(file)
			s:serialize_sorted('unitPayloads', savedPayload)
			file:write('return unitPayloads\n')
			file:close()
		else
			print('Cannot save payload!', err)
		end
	end
end

function mergeUserPayloads()
    local filenames = {}
    local usersUnitsPayload ={}
    local dir = ConfigHelper.getWriteDirUnitPayloadsV()

    if lfs.attributes(dir) then
        for filename in lfs.dir(dir) do
            if filename ~= '.' and filename ~= '..' then
                local path = dir..'/'..filename
                local f, err = loadfile(path)
                
                if f then
					local ok, res = base.pcall(f)
					if ok then
						local unitPayloads = res
						local unitType = unitPayloads.unitType or unitPayloads.name
						usersUnitsPayload[unitType] = unitPayloads   
					else
						log.error('ERROR: mergeUserPayloads() failed to pcall "'..filename..'": '..res)
					end	        
                else
                    print('Cannot load user payload!',path, err)
                end                
            end
        end
    end
    
    for unitType,userPayload in base.pairs(usersUnitsPayload) do
        local unitPayload = unitsPayload[unitType]     
        local enableInDB = (DB.unit_by_type[unitType] ~= nil)  
        if enableInDB == true then
            if unitPayload == nil then
                unitPayload = {}
                unitPayload.unitType 	= unitType
                unitPayload.name 		= unitType
                unitPayload.tasks 		= {}
                unitPayload.payloads 	= {}
                unitsPayload[unitType] 	= unitPayload
                local copyPayload = {}
                TableUtils.recursiveCopyTable(copyPayload, unitsPayload[unitType])
                baseUnitsPayload[unitType] = copyPayload
            end
            for kk,payloadU in base.pairs(userPayload.payloads) do
                local enable = false
                for k,payloadD in base.pairs(unitPayload.payloads) do
                    if payloadD.name == payloadU.name then
                        unitPayload.payloads[k] = {}
                        TableUtils.recursiveCopyTable(unitPayload.payloads[k], userPayload.payloads[kk])
                        enable = true
                    end
                end
                if enable == false then 
                    local copyPayload ={}
                    TableUtils.recursiveCopyTable(copyPayload, userPayload.payloads[kk])
                    base.table.insert(unitPayload.payloads, copyPayload)
                end
            end 
        else
            print("ERROR user puyload no in DB",unitType)
        end    
    end
end

function copyPayload(a_UnitType, a_newId, a_payloadId)
    local payloads = getUnitPayloads(a_UnitType)
        if payloads then
        local payload = addPayload(a_UnitType, a_newId)
        local ammo = getAmmo(a_UnitType, a_payloadId)
        U.recursiveCopyTable(payload.ammo, ammo)
        return true
    end
end


local function loadPayloads()
	-- загрузка базы данных	
	local unitPayloadsFolder = ConfigHelper.getUnitPayloadsVSysPath()
	local filenames = getUnitPayloadFileNames()
	
	baseUnitsPayload = {} -- записанное в самой игре
    unitsPayload = {}
	unitPayloadsFilename = {}
    
	for i, filename in pairs(filenames) do
		local path = unitPayloadsPaths[filename] 
		local f, err = loadfile(path)
		
		if f then
			local ok, res = base.pcall(f)
			if ok then
				local unitPayloads = res
				local unitType = unitPayloads.unitType
				baseUnitsPayload[unitType] = unitPayloads
				unitPayloadsFilename[unitType] = filename 
			else
				log.error('ERROR: loadPayloads() failed to pcall "'..filename..'": '..res)
			end		              
		else
			print('Cannot load payloads!',filename,path, err)
		end
	end
    
    TableUtils.recursiveCopyTable(unitsPayload, baseUnitsPayload)

    -- мержим в загруженные дефолтные юзерские
    mergeUserPayloads()
end

function findPayloadByName(payloads, payloadId)	
	if payloads then
		for i, payload in ipairs(payloads) do
			if payloadId == payload.name then
				return payload, i
			end
		end	
	end
end

function deletePayload(unitType, payloadId)
	local payloads = getUnitPayloads(unitType)
	
	if payloads then
		local payload, payloadIndex = findPayloadByName(payloads, payloadId)
		
		if payload then
			table.remove(payloads, payloadIndex)
			setModified(unitType)
		end
        
	end
end

function renamePayload(unitType, payloadName, newPayloadName)
	local payloads = getUnitPayloads(unitType)
	local payload = findPayloadByName(payloads, payloadName)
	
	if payload then
		payload.name = newPayloadName
		setModified(unitType)
		return true
	end
	return false
end

function init_()
    loadPayloads()
end