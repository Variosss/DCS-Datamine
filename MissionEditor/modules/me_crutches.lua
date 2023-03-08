local base = _G

module('me_crutches')

-- this file should be empty... in theory
-- practice is little different

local require = base.require

local me_db_api		= require('me_db_api')
local i18n			= require('i18n')
local ProductType 	= require('me_ProductType') 
i18n.setup(_M)


-- localized skills names
local skillsNames = {_('Average'), _('Good'), _('High'), _('Excellent'), 
        _('Random'), _('Client'), _('Player') }
		
local skillsNamesAir = {_('Rookie'), _('Trained'), _('Veteran'), _('Ace'), 
        _('Random'), _('Client'), _('Player') }
        
if ProductType.getType() == "LOFAC" then
    skillsNamesAir = {_('Average'), _('Good'), _('High'), _('Excellent'), 
    _('Random'), _('Client'), _('Player-LOFAC') }
end

-- skills ids
local skillsIds = {'Average', 'Good', 'High', 'Excellent', 'Random', 'Client', 
        'Player' }

local defaultSkillIndex
local clientSkillIndex
local playerSkillIndex

for ids_i = 1, #skillsIds do
	if skillsIds[ids_i] == 'High' then
		defaultSkillIndex = ids_i
	elseif skillsIds[ids_i] == 'Client' then
		clientSkillIndex = ids_i
	elseif skillsIds[ids_i] == 'Player' then
		playerSkillIndex = ids_i
	end
end

-- list of static categories names
local staticCategoriesNames = { 'Planes', 'Helicopters', 'Ships', 
                'Ground vehicles', 'Structures', 'Heliports', 'Warehouses', 'Cargos', 
                'Ground vehicles', 'Ground vehicles', 'Ground vehicles', 'Ground vehicles', 
                'Ground vehicles', 'Ground vehicles', 'Grass Airfields', 'LTAvehicles', 'WWII structures', 'MissilesSS',
				'Effects','Airfield and deck equipment','Animal', 'Personnel'}

-- list of static categories IDs
local staticCategoriesIds = { 'Planes', 'Helicopters', 'Ships', 
                'Ground vehicles', 'Fortifications', 'Heliports', 'Warehouses', 'Cargos',
                'Air Defence', 'Armor', 'Artillery', 'Civilians', 'Infantry', 'Unarmed', 'GrassAirfields', 'LTAvehicles',
				'WWII structures', 'MissilesSS' , 'Effects', 'ADEquipment','Animal', 'Personnel'}
				
local staticCategories = 
{
	['Plane'] 			= 'Planes',
	['Helicopter'] 		= 'Helicopters',
	['Ship'] 			= 'Ships',
	['Fortification'] 	= 'Fortifications',
	['Heliport'] 		= 'Heliports',
	['GrassAirfield'] 	= 'GrassAirfields',
	['Warehouse'] 		= 'Warehouses',
	['Cargo'] 			= 'Cargos',
	['LTAvehicle'] 		= 'LTAvehicles',
	['WWIIstructure'] 	= 'WWII structures',
	['Effect'] 			= 'Effects',
	['Animal'] 			= 'Animal',
	['Personnel']		= 'Personnel',
	['ADEquipment'] 	= 'ADEquipment',
	['MissilesSS'] 		= 'MissilesSS',
	['Unarmed'] 		= 'Unarmed',
	['Infantry'] 		= 'Infantry',
	['Artillery'] 		= 'Artillery',
	['Armor'] 			= 'Armor',
	['Air Defence'] 	= 'Air Defence',
	
}

function getStaticCategoryByUnitcategory(a_category)
	return staticCategories[a_category]
end

function nameToIndex(a_name)
	if indexByName == nil then
		indexByName = {}
		for index,v in base.ipairs(skillsNames) do
			indexByName[v] = index	
		end
		
		for index,v in base.ipairs(skillsNamesAir) do
			indexByName[v] = index
		end		
	end
	return indexByName[a_name]
end


-- convert skill name to skill ID
function skillToId(skill)
    if not skillByName then
        skillByName = { }
        local cnt = #skillsNames
        for i = 1, cnt do
            skillByName[skillsNames[i]] = skillsIds[i]
        end
    end
    return skillByName[skill]
end

function skillToIdAir(skill)
    if not skillByNameAir then
        skillByNameAir = { }
        local cnt = #skillsNamesAir
        for i = 1, cnt do
            skillByNameAir[skillsNamesAir[i]] = skillsIds[i]
        end
    end
    return skillByNameAir[skill]
end


-- convert skill ID to skill name
function idToSkill(id)
    if not skillById then
        skillById = { }
        local cnt = #skillsNames
        for i = 1, cnt do
            skillById[skillsIds[i]] = skillsNames[i]
        end
    end
    return skillById[id]
end

function idToSkillAir(id)
    if not skillByIdAir then
        skillByIdAir = { }
        local cnt = #skillsNamesAir
        for i = 1, cnt do
            skillByIdAir[skillsIds[i]] = skillsNamesAir[i]
        end
    end
    return skillByIdAir[id] or id
end


-- returns names of skills
function getSkillsNames(includeHuman, includeClient)
    if not includeHuman then
		botSkillsNames = {}
		for i = 1, #skillsNames do
			if (i ~= playerSkillIndex) and ((i ~= clientSkillIndex) or (includeClient == true)) then
				base.table.insert(botSkillsNames, skillsNames[i])
			end
		end
		
		return botSkillsNames
    else
        return skillsNames
    end
end

function getSkillsNamesAir(includeHuman, includeClient)
    if not includeHuman then
		botSkillsNamesAir = {}
		for i = 1, #skillsNamesAir do
			if (i ~= playerSkillIndex) and ((i ~= clientSkillIndex) or (includeClient == true)) then
				base.table.insert(botSkillsNamesAir, skillsNamesAir[i])
			end
		end
		
		return botSkillsNamesAir
    else
        return skillsNamesAir
    end
end

-- convert task name to old task ID
function taskToId(taskName)
    if not taskByName then
        taskByName = { }
        for _tmp, v in base.pairs(me_db_api.db.Units.Planes.Tasks) do
            taskByName[v.Name] = v
        end
    end
    local task = taskByName[taskName]
    if not task then
        return taskName
    else
        return task.OldID
    end
end

-- convert old task ID to task name
function idToTask(oldTaskId)
    if not taskByOldId then
        taskByOldId = { }
        for _tmp, v in base.pairs(me_db_api.db.Units.Planes.Tasks) do
            taskByOldId[v.OldID] = v
        end
    end
    local task = taskByOldId[oldTaskId]
    if not task then
        return oldTaskId
    else
        return task.Name
    end
end

-- create lookup tables for static categories
function createStaticIndices()
    staticCategoryByName = { }
    staticNameByCategory = { }
    for i, v in base.pairs(staticCategoriesIds) do
        local name = _(staticCategoriesNames[i])
        staticCategoryByName[name] = v
        staticNameByCategory[v] = name
    end
end

-- convert localized static category name to category ID
function staticCategoryNameToId(categoryName)
    if not staticCategoryByName then
        createStaticIndices()
    end
    local id = staticCategoryByName[categoryName]
    if not id then
        return categoryName
    else
        return id
    end
end

-- convert localized static category ID to category name
function staticCategoryIdToName(categoryId)
    if not staticCategoryByName then
        createStaticIndices()
    end
    local name = staticNameByCategory[categoryId]
    if not name then
        return categoryId
    else
        return name
    end
end

-- convert old structure names to the new ones
function fixStaticStructureType(typeFromMission)
	local newType = structureTypeConvertionPairs[typeFromMission]
	if newType then 
		return newType
	else
		return typeFromMission
	end
end

-- convert old unit name to the new one
function fixUnitType(typeFromMission)
	local newType = unitTypeConvertionPairs[typeFromMission]
	if newType then 
		return newType
	else
		return typeFromMission
	end
end

--возвращает имя скила "игрок"
function getPlayerSkill()
    return skillsNamesAir[playerSkillIndex]
end
		
--возвращает имя скила "клиент"
function getClientSkill()
    return skillsNamesAir[clientSkillIndex]
end

--возвращает имя скила "по умолчанию"
function getDefaultSkill()
	return skillsNames[defaultSkillIndex]
end

function getDefaultSkillAir()
	return skillsNamesAir[defaultSkillIndex]
end

--возвращает id скила "игрок"
function getPlayerSkillId()
    return skillsIds[playerSkillIndex]
end

--возвращает id скила "клиент"
function getClientSkillId()
    return skillsIds[clientSkillIndex]
end

function getBotInGroup(group)
	local bBotInGroup = false
	for k,v in base.pairs(group.units) do
		if v.skill ~= getPlayerSkill() and v.skill ~= getClientSkill() then
			bBotInGroup = true
		end
	end
	return bBotInGroup
end