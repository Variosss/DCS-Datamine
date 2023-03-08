local base = _G

module('me_staticTemplate')

local require = base.require
local table = base.table
local math = base.math
local pairs = base.pairs
local ipairs = base.ipairs
local print = base.print
local tostring = base.tostring
local debug = base.debug

local mod_mission       = require('me_mission')
local U					= require('me_utilities')
local TheatreOfWarData	= require('Mission.TheatreOfWarData')
local me_db				= require('me_db_api')
local Tools  			= require('tools')
local MapWindow			= require('me_map_window')
local mod_dictionary    = require('dictionary')
local lfs 				= require('lfs')
local MsgWindow			= require('MsgWindow')
local i18n 				= require('i18n')
local FileDialogUtils	= require('FileDialogUtils')
local log     			= require('log')

i18n.setup(_M)

local um 
local staticTemplate
local oldToNew_GroupId = {}
local oldToNew_UnitId = {}

function unload_staticTemplate()
	local usedCustomForms = {}
	um = {	
			theatre  = TheatreOfWarData.getName(),
			coalition = {},
			requiredModules = {},
		}

	local tempCoalition = {}
	base.U.recursiveCopyTable(tempCoalition, mod_mission.mission.coalition)
	for i,v in pairs(tempCoalition) do
		local coal = 
		{
			name = v.name, 
			country = {},
		}
 	
		um.coalition[i] = coal
		for j,u in pairs(v.country) do
			local cant = {id = u.id, name = me_db.country_by_id[u.id].OldID }
						
			if u.plane then
				mod_mission.unload_air_groups(u, 'plane', cant, um)
			end
			if u.helicopter then
				mod_mission.unload_air_groups(u, 'helicopter', cant, um)
			end
			if u.ship then
				mod_mission.unload_nonair_groups(u, 'ship', cant, usedCustomForms,um)
			end
			if u.vehicle then
				mod_mission.unload_nonair_groups(u, 'vehicle', cant, usedCustomForms,um)
			end
			if u.static then
				mod_mission.unload_static_groups(u, 'static', cant,um)
			end
			if u.complex then
				mod_mission.unload_static_groups(u, 'complex', cant,um)
			end
			
			if cant.plane ~= nil 
				or cant.helicopter ~= nil  
				or cant.helicopter ~= nil  
				or cant.ship ~= nil  
				or cant.vehicle ~= nil  
				or cant.static ~= nil  
				or cant.complex ~= nil  then
				 
				coal.country[j] = cant				
			end
		end
    end
	um.customFormations = mod_mission.getCustomFormations(usedCustomForms)

	um.localization = mod_dictionary.getCopyDictionary()
end

function save(fullFileName, name, desc)
	unload_staticTemplate()
	
	um.name = name
	um.desc = desc
--  local path = MeSettings.getListMissionsPath()
--	local filters = {FileDialogFilters.listMissions()}
--  local fullFileName = FileDialog.save(path, filters, cdata.saveListMissions)
--	local fullFileName = "D:\\test.stm"
	
	local dirName = lfs.writedir().."StaticTemplate/"
	local a = lfs.attributes(dirName,'mode')
	if not a then
		lfs.mkdir(dirName)
	end
    
    if fullFileName then
        U.saveInFile(um, 'staticTemplate', fullFileName)
    end
end

function getInfo(fullFileName)
	local staticTemplate
	local info = {}
    
    if fullFileName then
       local tbl = Tools.safeDoFile(fullFileName, false)
		if (tbl and tbl.staticTemplate) then
			staticTemplate = tbl.staticTemplate
			info.name = staticTemplate.name
			info.desc = staticTemplate.desc
			info.theatre = staticTemplate.theatre
			info.fullFileName = fullFileName
			return true, info
		else
			return false, nil
		end 
    end
	return false, nil
end

local function findSuperimposedUnits(unit)	
	for tmp, misUnit in base.pairs(mod_mission.unit_by_id) do
		if misUnit.x + 1 > unit.x and misUnit.x - 1 < unit.x
			and misUnit.y + 1 > unit.y and misUnit.y - 1 < unit.y then
			local alt = unit.alt or U.getAltitude(unit.x, unit.y)
			local altMis = misUnit.alt or U.getAltitude(misUnit.x, misUnit.y)
			--base.print("---alt---",alt,misUnit.alt)
			if alt and altMis
				and altMis + 1 > alt and altMis - 1 < alt then
				return true, misUnit.name
			end		
		end	
	end
	return false			
end

function load(fullFileName)
	local staticTemplate
	
	oldToNew_GroupId = {}
	oldToNew_UnitId = {}
	local newGroupId = 1
	local newUnitId = 1
    
    if fullFileName then
        local tbl = Tools.safeDoFile(fullFileName, false)
		
		if not (tbl and tbl.staticTemplate) then
			base.print("---noload----")
			return
		else
			local shortFileName = FileDialogUtils.extractFilenameFromPath(fullFileName)
			log.write("LuaGUI", log.INFO, 'Loading Static Template: '..shortFileName)
		end
	   --проверяем размещение объектов в шаблоне и миссии

		staticTemplate = tbl.staticTemplate
		for k,v in base.pairs(staticTemplate.coalition) do		
			mod_mission.fixCountriesNames(v.country)			
			mod_mission.fixStaticCategories(v)
		end 
	 
		local numUnits = 0
		for i,cltn in base.pairs(staticTemplate.coalition) do		
			for i,v in base.pairs(cltn.country) do			
				local country = mod_mission.missionCountry[v.name]
				--base.print("---country---",country)
				if country then
					for k,w in base.pairs(mod_mission.group_types) do
					--print('creating category ---->',k,w);
						if v[w] and v[w].group then
							for j, group in base.ipairs(v[w].group) do
								
								-- меняем id группы и запоминаем соответствие
								oldToNew_GroupId[group.groupId] = newGroupId
								group.groupId = newGroupId
								newGroupId = newGroupId + 1
								
								for kk, unit in base.pairs(group.units) do	
									-- меняем id группы и запоминаем соответствие
									oldToNew_UnitId[unit.unitId] = newUnitId
									unit.unitId = newUnitId
									newUnitId = newUnitId + 1
									--base.print("--stempl---",unit.name,unit.x, unit.y)
									local bSuperimposed, nameUnit = findSuperimposedUnits(unit)
									if bSuperimposed == true then
										numUnits = numUnits + 1
										log.write("LuaGUI", log.INFO, 'Static Template Unit \"'..unit.name..'\" superimposes Mission Unit \"'..nameUnit.."\"")
										--base.print("---unitName--",unit.name)
									else
										--base.print("---Noooo--",unit.name)
									end	
								end
							end	
						end
					end				
				end	
			end
		end	
		
		if numUnits > 0 then
			msgWindowHandler_ = MsgWindow.warning(_("Superimposed units")..": "..numUnits.." ".."(See dcs.log for details)\n".._("continue?"), _('WARNING'), _('YES'), _('NO'))
        
			function msgWindowHandler_:onChange(buttonText)
				result = (buttonText == _('YES'))
				
				if result == true then
					mod_mission.createStaticTemplateObjects(staticTemplate, oldToNew_GroupId, oldToNew_UnitId)
				end
			end
			msgWindowHandler_:show()
			msgWindowHandler_ = nil
		else
			mod_mission.createStaticTemplateObjects(staticTemplate, oldToNew_GroupId, oldToNew_UnitId)
		end
    end
	mod_mission.fixTasks() 
	base.print("---loadStaticTemplate----",fullFileName)
end



