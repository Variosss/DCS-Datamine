local base = _G

module('me_targeting')

local require = base.require
local pairs = base.pairs
local ipairs = base.ipairs
local table = base.table
local tostring = base.tostring

local DialogLoader = require('DialogLoader')
local CheckListBoxItem = require('CheckListBoxItem')
local U = require('me_utilities')  -- Утилиты создания типовых виджетов
local MapWindow = require('me_map_window') -- Окно карты
local module_mission = require('me_mission')
local DB = require('me_db_api')
local panel_route = require('me_route')
local statusbar = require('me_statusbar')

require('i18n').setup(_M)

-- list of available categories
local categoriesList = {
    "Planes", "Helicopters", "Ships", "Vehicles", "Airfields",
    "Fortifications", "Buildings", "Point", "AFAC"
}

cdata = 
{
    target = _('TARGET'),
    of = _('OF'),
    name = _('NAME'),
    object = _('OBJECT'),
    radius = _('RADIUS'),
    add = _('ADD'),
    edit = _('EDIT'),
    del = _('DEL'),
    categories = _('TARGET CATEGORIES'),
    category_list = {
    _('Planes'),
    _('Helicopters'),
    _('Ships'),
    _('Ground vehicles'),
    _('Airfields'),
    _('Static objects'),
    _('Buildings'),
    _('Point'),
    _('AFAC'),
    },
}

--[[ Структура данных о целях в миссии
  route = {
    points = {
      ...,
      [i] = {
        ...,
        targets = {
          ...,
          [j] = {
            lat = ...,
            long = ...,
            radius = ...,
            categories = {
              '...',
              '...',
            },
            weapon_category = '...',
          },
          ...,
        },
      },
      ...,
    }
  }
--]]


-- Переменные загружаемые/сохраняемые данные 
vdata =
{ 
    target_max = 99,
    target_num = 0,
    target = {},
    targets = {},
    objects = {'POINT', 'UNIT', 'BUILDING',},
    object = 'POINT',
    coords = {x = 0, y = 0},
    radius = 1000, 
    categories = {
        [1] = false,
        [2] = false,
        [3] = false,
        [4] = false,
        [5] = false,
        [6] = false,
        [7] = false,
        [8] = false,
    },
}

-- make target selected
-- index == 0 сброс выделения
function selectTargetByIndex(index)
    if vdata.group then
        local wptIdx = panel_route.vdata.wpt.index
        local pnt = vdata.group.route.points[wptIdx]
        local color = vdata.group.boss.boss.selectGroupColor
        
        MapWindow.set_targets_color(pnt,  color)
        if index > 0 then 
            vdata.target = pnt.targets[index]
            local waypointColor = vdata.group.boss.boss.selectWaypointColor
            local route = vdata.group.mapObjects.route
            route.targets[wptIdx][index].currColor = waypointColor
            route.targetLines[wptIdx][index].currColor = waypointColor
            route.targetNumbers[wptIdx][index].currColor = waypointColor
        end
        
        module_mission.update_group_map_objects(vdata.group)
    end
end

function setTargetsColor(groupTargets)
    for k, waypointTargets in pairs(groupTargets) do
        for k, waypointTarget in pairs(waypointTargets) do
            waypointTarget.currColor = color
        end
    end
end

function selectTarget(target)
	if MapWindow.selectedGroup == nil then
		return
	end
    local group = MapWindow.selectedGroup
    
    if group then
        local groupRoute = group.mapObjects.route
        local groupRouteTargets = groupRoute.targets
        local groupRouteTargetLines = groupRoute.targetLines
        local groupRouteTargetNumbers = groupRoute.targetNumbers
        local color = group.boss.boss.selectGroupColor
        
        setTargetsColor(groupRouteTargets, color)
        setTargetsColor(groupRouteTargetLines, color)
        setTargetsColor(groupRouteTargetNumbers, color)
    end
    
    if target then
        local waypoint = target.boss
        local wptIdx = waypoint.index
        local group = MapWindow.selectedGroup
        local waypointColor = group.boss.boss.selectWaypointColor
        local route = group.mapObjects.route
        
        route.targets[wptIdx][target.index].currColor = waypointColor
        route.targetLines[wptIdx][target.index].currColor = waypointColor
        route.targetNumbers[wptIdx][target.index].currColor = waypointColor
    end
    
	if vdata.group then
		module_mission.update_group_map_objects(vdata.group)
	end
end 

-- returns name of category by
function getCategoryIdByName(categoryName)
    if not idxByCategory then
        idxByCategory = { }
        for i, v in pairs(categoriesList) do
            idxByCategory[v] = i
        end
    end
    return idxByCategory[categoryName]
end


-- Создание и размещение виджетов
-- Префиксы названий виджетов: t - text, b - button, c - combo, sp - spin, sl - slider, e - edit, d - dial 
function create(x, y, w, h)
    window = DialogLoader.spawnDialogFromFile("MissionEditor/modules/dialogs/me_targeting_panel.dlg", cdata)
    window:setBounds(x, y, w, h)
    
    -- Бокс другого цвета для виджетов
    local box_w = w-U.offset_w*2
    local box_h = h-U.offset_h
    
    box = window.box
    box:setSize(box_w, box_h)

    sp_target = box.sp_target

    function sp_target:onChange()
        local index = self:getValue()
        selectTargetByIndex(index)
        update()
    end

    e_of = box.e_of
    
    e_name = box.e_name
    
    function e_name:onChange()
        local name = self:getText()
        module_mission.set_target_name(vdata.target, name)
    end

    -- Радиус в метрах
    sp_radius = box.sp_radius

    function sp_radius:onChange()
        vdata.radius = self:getValue()
        vdata.target.radius = vdata.radius
        module_mission.update_target_zone(vdata.target)
    end

    -- Чеклист фильтра категорий до конца бокса.
    -- Функция onf будет вызываться при изменении чекбоксов.
    function onf(i, b)
        vdata.categories[i] = b
        if vdata.target and vdata.target.categories then
            if b then
                table.insert(vdata.target.categories, categoriesList[i])
            else
                local j = 1

                while j <= #vdata.target.categories do
                    if vdata.target.categories[j] == categoriesList[i] then
                        table.remove(vdata.target.categories, j)
                    else
                        j = j + 1
                    end
                end
            end
        end
    end
    
    l_filter = box.l_filter
    
    for i, category in ipairs(cdata.category_list) do
        local item = CheckListBoxItem.new(category)
        item:setChecked(true)
        item.num = i
        l_filter:insertItem(item)
    end

    function l_filter:onChange(item)
        if item then
          onf(item.num, item:getChecked())
        end
    end
    
    -- Buttons --------------------------------------------
    b_add = box.b_add

    function b_add:onChange()
      if self:getState() then
        MapWindow.setState(MapWindow.getAddingTargetState())
        b_edit:setState(false)
      else
        MapWindow.setState(MapWindow.getPanState())
      end
    end

    b_edit = box.b_edit
    
    function b_edit:onChange()
      if self:getState() then
        MapWindow.setState(MapWindow.getPanState())
        b_add:setState(false)
      end
      
      statusbar.updateState()
    end

    b_del = box.b_del
    
    function b_del:onChange()
      if vdata.target then
        local group = vdata.target.boss.boss
        local targets = vdata.target.boss.targets
        module_mission.remove_target(vdata.target)
        vdata.target = vdata.target.boss.targets[vdata.target.index]
        if not vdata.target then
          vdata.target = targets[#targets]          
        end
        selectTarget(vdata.target)
        if vdata.target then
            update()
        else
            clearPanel()
            MapWindow.setState(MapWindow.getAddingTargetState())
            l_filter:setEnabled(false)
        end
      else 
            l_filter:setEnabled(false)
      end    
    end
    
    b_add:setState(true)  
end

-- returns true if selected target is valid for current waypoint
function isValidTarget()
    if not vdata.group then
        return false
    end
    
    if (not vdata.target) or (not vdata.target.boss) then
        return false
    end
    
    return vdata.target.boss == panel_route.vdata.wpt
end

-- Обновление значений виджетов после изменения таблицы vdata
function update(allowSwitchState)
    if window:isVisible() and b_add:getState() then 
        MapWindow.setState(MapWindow.getAddingTargetState())
    end
    local validTarget = isValidTarget()
    if not validTarget then
        vdata.target = nil
    end

    if vdata.group then
        setAllowedCategories(vdata.group)
        if not validTarget then
            local wpt = panel_route.vdata.wpt
            local pnt = vdata.group.route.points[wpt.index]
            if pnt.targets and (0 < #pnt.targets) then
                selectTargetByIndex(1)
            end
        end
    end
    if not vdata.target then
        sp_target:setRange(0, 0)
        sp_target:setValue(0)
        e_of:setText('0')
        e_name:setText('')
        sp_radius:setValue(0)
        setSafeMode(true, allowSwitchState)
        return
    end
    
    if vdata.target and vdata.target.boss then
        local wpt = vdata.target.boss
        if wpt then
            if wpt.targets then
                sp_target:setRange(1, #wpt.targets)
                sp_target:setValue(vdata.target.index)
                e_of:setText(tostring(#wpt.targets))
            end
        end
        if vdata.target.name then
            e_name:setText(vdata.target.name)
        else
            e_name:setText('')
        end
        if vdata.target.radius then
            sp_radius:setValue(vdata.target.radius)
        end
        if vdata.target.categories then
            local checks = { }
			local itemCounter = l_filter:getItemCount() - 1
			
            for i = 0, itemCounter do
				local item = l_filter:getItem(i)
				local itemNum = item.num
				
                item:setChecked(false)
                checks[categoriesList[itemNum]] = item
                vdata.categories[itemNum] = false 
            end

            for _tmp, v in pairs(vdata.target.categories) do
                if checks[v] then
                    checks[v]:setChecked(true)
                    vdata.categories[checks[v].num] = true
                end
            end
        else
			local itemCounter = l_filter:getItemCount() - 1
			
            for i = 0, itemCounter do
				local item = l_filter:getItem(i)
				
                item:setState(false)
                vdata.categories[item.num] = false
            end
        end
    end 
    local safeMode = (not vdata.target) or (not vdata.target.boss) or
          (not vdata.target.boss.targets) or (0 == #vdata.target.boss.targets)
    setSafeMode(safeMode, allowSwitchState)
end

function show(b)
    if not b then
        MapWindow.setState(MapWindow.getPanState())
    else
        update()
        if not window:isVisible() and MapWindow.selectedGroup then 
            if MapWindow.selectedGroup.route and MapWindow.selectedGroup.route.points then
                local wpt = panel_route.vdata.wpt
                
                if wpt then
                    if wpt.targets and (#wpt.targets > 0) then
                        b_add:setState(false)
                        b_edit:setState(true)                   
                        MapWindow.setState(MapWindow.getPanState())
                        selectTarget(vdata.target)
                    else
                        b_add:setState(true)
                        b_edit:setState(false)                   
                        MapWindow.setState(MapWindow.getAddingTargetState())
                    end                
                end
            end
        end
    end
    window:setVisible(b)
    statusbar.updateState()
end

function isVisible()
    return window:isVisible()
end

-- disable editing of target zone
function setSafeMode(enabled, allowSwitchState)
    local e = not enabled
    sp_target:setEnabled(e)
    e_of:setEnabled(e)
    e_name:setEnabled(e)
    sp_radius:setEnabled(e)
    l_filter:setEnabled(e)
    if enabled and allowSwitchState then
        b_add:setState(true)
        b_edit:setState(false)
    end
end

-- returns true if category was enabled
function isCategoryEnabled(category)
    if not vdata.target then
        return false
    end
    for _tmp, v in pairs(vdata.target.categories) do
        if category == v then
            return true
        end
    end
    return false
end

-- remove categories
function removeUnneededCategories(targets)
    if not vdata.target then
        return
    end

    local toRemove = { }
    for i, v in pairs(vdata.target.categories) do
        if targets[v] == nil then
            table.insert(toRemove, i)
        end
    end

    for i, v in pairs(toRemove) do
		table.remove(vdata.target.categories, v - i + 1)
    end
end

function setDefaultCategories()
    local task = vdata.group.task
    local targets = DB.db.Targets.Tasks[getTaskId(task)]
	
    for i, category in ipairs(cdata.category_list) do
		local categoryStatus = targets[category]
        
		if categoryStatus ~= nil then
			if categoryStatus then
				table.insert(vdata.target.categories, category)
			end
		end
	end
end

-- create list of checkbox items
function createCheckBoxes(checkListBox, targets)	
    for i, category in ipairs(cdata.category_list) do
        if targets[category] ~= nil then
            local item = CheckListBoxItem.new(category)
            local state = isCategoryEnabled(category)
            item:setChecked(state)
            vdata.categories[i] = state
            item.num = i
            checkListBox:insertItem(item)
        else
            vdata.categories[i] = false
        end
    end
end

-- returns name of task
function getTaskId(name)
    for _tmp, v in pairs(DB.db.Units.Planes.Tasks) do
        if v.Name == name then
            return v.WorldID
        end
    end
    return 1
end

-- returns true if unit has target filters
function hasTargets(type)
    return 'plane' == type or 'helicopter' == type
end

-- update categories list
function setAllowedCategories(group)
    local task = group.task
    local targets = DB.db.Targets.Tasks[getTaskId(task)]
    l_filter:clear()
    if targets and hasTargets(group.type) then
        createCheckBoxes(l_filter, targets)
    end
    removeUnneededCategories(targets)
end

function clearPanel()
    sp_target:setRange(0, 0)
    sp_target:setValue(0)
    e_of:setText('0')
    e_name:setText('')
    sp_radius:setValue(1)
	
    local itemCounter = l_filter:getItemCount() - 1
	
    for i = 0, itemCounter do 
        l_filter:getItem(i):setState(false)
    end
end 