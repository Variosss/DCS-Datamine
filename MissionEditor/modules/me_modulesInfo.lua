local base = _G

module('me_modulesInfo')

local require       = base.require
local pairs         = base.pairs
local ipairs        = base.ipairs
local table         = base.table
local math          = base.math
local loadfile      = base.loadfile
local setfenv       = base.setfenv
local string        = base.string
local assert        = base.assert
local io            = base.io
local loadstring    = base.loadstring
local print         = base.print
local os            = base.os

local log      			= require('log')
local panel_waitDsbweb  = require('me_waitDsbweb')
local DcsWeb 			= require('DcsWeb')
local panel_news        = require('me_news')
local Tools 			= require('tools')
local lfs 				= require('lfs')
local S 				= require('Serializer')
local panel_auth		= require('me_authorization')
local i18n 				= require('i18n')
local ProductType 		= require('me_ProductType') 


i18n.setup(_M)

cdata =
{

}

local tmpModules = nil
local mod_by_updateid = {}  
local camp_by_updateid = {}    
local terrain_by_updateid = {}  
local modul_by_modulId = {}

local installModul_by_updateId = {}
local callbacks = {}
local bUpdating = false
local callbackEndUpdating
local bEndUpdating = false

IdenticalModules =
{
	["A-10C"] 		= {"A-10C_ru"},
	["A-10C_ru"] 	= {"A-10C"},
	["KA-50bs1"] 	= {"KA-50bs1_ru","KA-50_ru","KA-50"},
	["KA-50_ru"] 	= {"KA-50bs1","KA-50","KA-50bs1_ru"},
	["KA-50"] 		= {"KA-50bs1","KA-50_ru","KA-50bs1_ru"},
	["KA-50bs1_ru"] = {"KA-50bs1","KA-50_ru","KA-50"},
}

substitutionNameByModulId =   -- для случая когда id модуля не соответствует желаемому видеть
{
	["WWII Armour and Technics"] = _("WWII Assets Pack"),
}

function init()
    loadData()
	
	for i, v in ipairs(base.plugins) do
		if v.update_id then
			installModul_by_updateId[v.update_id] = v
		end
	end
end

-------------------------------------------------------------------------------
-- 
function loadData()
	bUpdating = true
	bEndUpdating = false
    DcsWeb.send_request('dcs:modules', "")
    panel_waitDsbweb.startWait(verifyStatusModules, loadDataEnd)    
end

-------------------------------------------------------------------------------
-- 
function saveInFile(a_table, a_nameTable, a_path)	 
    local f,err = io.open(a_path, 'w')
    if f then
        local sr = S.new(f) 
        sr:serialize_simple2(a_nameTable, a_table)
        f:close()
	else
		log.error('ERROR: save modules failed: '..err)		
    end
end

-------------------------------------------------------------------------------
-- 
function loadDataEnd()	
    tmpModules = nil
	ModulesNew = {}
    ModulesNew.DLC = {}
	ModulesOld = {}
    
	if panel_auth.getOfflineMode() ~= true then
		local mods_data = DcsWeb.get_data('dcs:modules')
		if statusModules >= 400 then
			base.print("ERROR DcsWeb.get_data('dcs:modules') ",mods_data, statusModules)
		else
			tmpModules = loadDataServer(tmpModules, mods_data) 
		end
	end	
     
	-- читаем старый файл
    local DLC = Tools.safeDoFile(lfs.writedir() .. 'MissionEditor/modules.lua')
   
    if DLC then
        if DLC.DLC then
            ModulesOld = DLC
        else
            ModulesOld.DLC = {}
            ModulesOld.DLC.moduls = DLC.moduls
            ModulesOld.DLC.campaigns = DLC.campaigns
			ModulesOld.DLC.bundles = DLC.bundles
			ModulesOld.DLC.offers = DLC.offers
        end
    end 
    
	if (not tmpModules) then
		if panel_auth.getOfflineMode() ~= true then
			print("error loading data modules")
		else
			print("offline, not loading data modules")
		end	
		ModulesNew = ModulesOld	 
		--base.U.traverseTable(ModulesNew,2)
	else		
		setfenv(tmpModules, ModulesNew.DLC);
		tmpModules()
		
		saveInFile(ModulesNew.DLC, 'DLC', lfs.writedir() .. 'MissionEditor/modules.lua')
	end  

	if (ModulesNew == nil) or (ModulesNew.DLC == nil) or (ModulesNew.DLC.moduls == nil) then
		endUpdate()	
	else
		loadImages(ModulesNew.DLC.moduls)
	end
	
end

function endUpdate()
	bUpdating = false
	fillDataTbl()
	bEndUpdating = true
	
	for k,fun in base.pairs(callbacks) do
		fun()	
	end
		
	if callbackEndUpdating then
		callbackEndUpdating()
		callbackEndUpdating = nil
	end
	
	base.panel_openfile.updateWaitingPanels()
end

function isEndUpdating()
	return bEndUpdating
end

function getModulDisplayNameByModulId(a_ModulId)
    if modul_by_modulId[a_ModulId] then
        return modul_by_modulId[a_ModulId].title_mm
    end
    
    return substitutionNameByModulId[a_ModulId] or a_ModulId
end

function getModulShortNameByModulId(a_ModulId)
    if modul_by_modulId[a_ModulId] then
        return modul_by_modulId[a_ModulId].shortName
    end
    
    return a_ModulId
end

function getModulBlinkByModulId(a_ModulId)
    if modul_by_modulId[a_ModulId] then
        return modul_by_modulId[a_ModulId].blink
    end
    
    return nil
end

function getModulByModulId(a_ModulId)
    if modul_by_modulId[a_ModulId] then
        return modul_by_modulId[a_ModulId]
    end
    
    return nil
end

function setCallback(a_fun)
	base.table.insert(callbacks,a_fun)
end

local function verifyInstallIdenticalModules(a_update_id)
	local result = nil
	if IdenticalModules[a_update_id] ~= nil then
		for k,v in base.pairs(IdenticalModules[a_update_id]) do
			if installModul_by_updateId[v] ~= nil then
				result = true
			end
		end
	end
	
	return result
end

function isHave(a_id)
	local modul = getModulById(a_id)
	if modul then
		return modul.have == "1"
	end
	return false
end

function getNumPurchasedModules()
	local result = 0
	for k,v in base.pairs(mod_by_updateid) do		
		if v.have == "1" and installModul_by_updateId[v.update_id] == nil and verifyInstallIdenticalModules(v.update_id) == nil then
			result = result + 1
		end
	end
	
	for k,v in base.pairs(camp_by_updateid) do		
		if v.have == "1" and installModul_by_updateId[v.update_id] == nil then
			result = result + 1
		end
	end
	
	for k,v in base.pairs(terrain_by_updateid) do		
		if v.have == "1" and installModul_by_updateId[v.update_id] == nil then
			result = result + 1
		end
	end
	
	return result
end


function getModulById(a_id)
    return modul_by_modulId[a_id]
end

function getUpdateId(a_id)
	local modul = modul_by_modulId[a_id]
	if modul then
		return modul.update_id
	end
	return nil
end

function getBlink(a_id)
	if (ProductType.getType() == "STEAM") then
		return "http://store.steampowered.com/app/223750"
	end	
	local modul = modul_by_modulId[a_id]
	if modul then
		return modul.blink
	end
	return nil
end

function getModulByUpdateId(a_id)
    return mod_by_updateid[a_id]
end

function getCampById(a_id)
    return camp_by_updateid[a_id]
end

function getTerrainById(a_id)
    return terrain_by_updateid[a_id]
end

function fillDataTbl()
    ModulesNew.DLC.campaigns = ModulesNew.DLC.campaigns or {}
    
    if (ModulesNew  and ModulesNew.DLC and ModulesNew.DLC.moduls) then
        for k,v in base.pairs(ModulesNew.DLC.moduls) do
            mod_by_updateid[v.update_id] = v 
            if v.modulId then
                modul_by_modulId[v.modulId] = v
			--else
			--	base.print("ERROR: no modulId in "..(v.title_mm or v.update_id or "non"))
            end            
        end
    end   
    
    if (ModulesNew  and ModulesNew.DLC and ModulesNew.DLC.campaigns) then
        for k,v in base.pairs(ModulesNew.DLC.campaigns) do
            camp_by_updateid[v.update_id] = v 
            if v.modulId then
                modul_by_modulId[v.modulId] = v
			--else
			--	base.print("ERROR: no modulId in "..(v.title_mm or v.update_id or "non"))	
            end    
        end
    end 
    
    if (ModulesNew  and ModulesNew.DLC and ModulesNew.DLC.terrains) then
        for k,v in base.pairs(ModulesNew.DLC.terrains) do
            terrain_by_updateid[v.update_id] = v
            if v.modulId then
                modul_by_modulId[v.modulId] = v
			--else
			--	base.print("ERROR: no modulId in "..(v.title_mm or v.update_id or "non"))	
            end    
        end
    end 
end


function isErrorLoad()
    return (not tmpModules)
end

-------------------------------------------------------------------------------
-- 
function verifyStatusModules()
    statusModules = DcsWeb.get_status('dcs:modules')
    
    if statusModules ~= 102 then                      
        return true, statusModules     
    end
    return false
end

-------------------------------------------------------------------------------
-- 
function getModulIDS(a_updateId)
    for kk,section in pairs({"moduls","campaigns","terrains"}) do
        if ModulesNew.DLC[section] then
            for k,v in pairs(ModulesNew.DLC[section]) do	                
                if (v.update_id == a_updateId) then
                    local result = {}
                    base.U.recursiveCopyTable(result, v)
                    return result
                end
            end
        end
    end    

    return nil
end

-------------------------------------------------------------------------------
--
function loadImage(k, v, needLoad, dirName)
    if (v.image and v.image ~= "") then      
        local ind = string.find(string.reverse(v.image), '/');
        local fileName = string.sub(v.image, -ind +1, -1);
        
        local a = lfs.attributes(dirName,'mode')
        if not a then
            --print('creating dir: ', dirName)
            lfs.mkdir(dirName);
        end;
                        
        v.imageLocal = dirName..fileName
        
        a = lfs.attributes(v.imageLocal,'mode')
        local sizeF = lfs.attributes(v.imageLocal, 'size')  
        local image_size = base.tonumber(v.image_size) 		
        if (not a) or (image_size and (sizeF ~= image_size)) then
            needLoad = true
        end;

        if (needLoad == true) then  
            local nameItem = 'image'..(v.update_id or v.code)
            DcsWeb.send_request(v.image,"", nameItem)
            imagesStatusTbl[nameItem] = {} 
            imagesStatusTbl[nameItem].status = false    
            imagesStatusTbl[nameItem].imageLocal = v.imageLocal     
            imagesStatusTbl[nameItem].key = k    
            imagesStatusTbl[nameItem].image_size = image_size                 
        end   
    end
end

-------------------------------------------------------------------------------
--
function verifyLoadImage()
    local result = true
    for k,v in base.pairs(imagesStatusTbl) do
        if (v.status == false) then			
            local status = DcsWeb.get_status(k)  
            if status ~= 102 then
                imagesStatusTbl[k].status = status
            end
            result = false
        end    
    end
    return result
end

-------------------------------------------------------------------------------
--
function end_loadImage()
    for k,v in base.pairs(imagesStatusTbl) do		
        if v.status ~= false then
            local response = DcsWeb.get_data(k)
            if v.status >= 400 then
                log.error("ERROR DcsWeb.get_data() "..response)
            else   		
                local f, err = io.open(v.imageLocal,'w+')
                f:write(response)
                f:close()
            end
        end
        a = lfs.attributes(v.imageLocal,'mode')
        sizeF = lfs.attributes(v.imageLocal, 'size') 
        
        if (not a) or (v.image_size and (sizeF ~= v.image_size)) then
            for kk,section in pairs({"moduls","campaigns","terrains"}) do
                if ModulesNew.DLC[section] and ModulesNew.DLC[section][v.key] then
                    ModulesNew.DLC[section][v.key].imageLocal = "./dxgui/skins/skinME/images/Unknown.png"
                end
            end            
        end;
    end

	endUpdate()
end


-------------------------------------------------------------------------------
--
function loadImages(a_image)	
	local locale =i18n.getLocale()
	local imageData 	= {}
	local imageHeader 	= {}
	local imageFull		= nil
    
    imagesStatusTbl = {}
	
	local dirName = lfs.writedir().."ImagesShop\\"	
	local a = lfs.attributes(dirName,'mode')
	if not a then
		lfs.mkdir(dirName);
	end;
	
    for kk,section in pairs({"moduls", "campaigns", "terrains", "bundles", "offers"}) do
        if ModulesNew.DLC[section] then
            for k,v in pairs(ModulesNew.DLC[section]) do	
                
                local needLoad = true
                if ModulesOld and ModulesOld.DLC and ModulesOld.DLC[section]then
                    for _key, _modul in pairs(ModulesOld.DLC[section]) do	
							
                        if (_modul.update_id == v.update_id) then
							--base.print("---date--",v.update_id, _modul.date == v.date,_modul.date,v.date)
							if (_modul.date == v.date) then
								needLoad = false
							end
                        end
                    end
                end
                
                --print("v.image=",v.image, needLoad)				
                loadImage(k, v, needLoad, dirName)        
            end
        end
    end
    
  --  panel_waitDsbweb.show(true)
    panel_waitDsbweb.startWait(verifyLoadImage, end_loadImage)   
end

function isUpdating()
	return bUpdating
end

function addCallbackEndUpdating(a_callbackEndUpdating)
	callbackEndUpdating = a_callbackEndUpdating
end
			

-------------------------------------------------------------------------------
-- 
function loadDataServer(tmpModules, mods_data)
	-- вывод входящей строки в файл ,modules222.lua
	function saveInFile2(a_table, fName)	 
			local f,err = io.open(lfs.writedir() .. 'MissionEditor/'..fName..'.lua', 'w')
			if f then
				local sr = S.new(f) 
				sr:serialize_simple2('modules', a_table)
				f:close()
				--print("******************************")
			else
				print("ERROR: save error in mods_data failed",err)
			end
			--print("*///////////////////*******")
		end       
			
	--saveInFile2(mods_data, 'modules222')
	mods_data = string.gsub(mods_data, "\\\"", "\"")
	mods_data = panel_news.findTags(mods_data)
	--saveInFile2(mods_data, 'modules2221')
	
	if (mods_data ~= '') then
		tmpModules, errStr = loadstring(mods_data);
        if tmpModules == nil then
            saveInFile2(mods_data, 'modules222')
            print("---errStr=",errStr)
        end
	end
	
	return tmpModules
end

function getModulesNew()
    return ModulesNew
end