local base = _G

module('me_failures')

local require = base.require
local pairs = base.pairs
local tostring = base.tostring
local table = base.table
local print = base.print

local DialogLoader		= require('DialogLoader')
local Static			= require('Static')
local CheckBox			= require('CheckBox')
local U					= require('me_utilities')
local EditBox			= require('EditBox')
local Mission			= require('me_mission')
local panel_aircraft	= require('me_aircraft')
local me_db_api			= require('me_db_api')

local i18n = require('i18n')

i18n.setup(_M)


cdata = {
    failures = _('FAILURES'),
    device = _('DEVICE'),
    after = _('After(hh:mm)'),
    interval = _('Within(mm)'),
    rand = _('RAND'),
    probability = _('Probability(%)'),
    clear = _('CLEAR_failure','CLEAR'),
}

local x_
local y_
local w_
local h_
local window
local deviceColumnIndex_
local afterHoursColumnIndex_
local afterColonColumnIndex_
local afterMinutesColumnIndex_
local durationColumnIndex_
local probabilityColumnIndex_
local checkBoxSkin_
local editBoxSkin_
local spinBoxSkin_
local separatorSkin_

vdata 		 = { }
vdata_view	 = { }
rows  		 = { }
old_plane	 = nil
needReCreate = false

function create(x, y, w, h)
    x_ = x
    y_ = y
    w_ = w
    h_ = h
end

local function createGridColumns_()    
    grid:insertColumn(4)
    
    deviceColumnIndex_ = grid:getColumnCount()
    grid:insertColumn(330)
    
    afterHoursColumnIndex_ = grid:getColumnCount()
    grid:insertColumn(50)
    
    afterColonColumnIndex_ = grid:getColumnCount()
    grid:insertColumn(4)
    
    afterMinutesColumnIndex_ = grid:getColumnCount()
    grid:insertColumn(50)
    grid:insertColumn(8)
    
    durationColumnIndex_ = grid:getColumnCount()
    grid:insertColumn(50)
    grid:insertColumn(28)
    
    probabilityColumnIndex_ = grid:getColumnCount()
    grid:insertColumn(70)
end

local function create_()    
    window = DialogLoader.spawnDialogFromFile('MissionEditor/modules/dialogs/me_failures_panel.dlg', cdata)
    window:setBounds(x_, y_, w_, h_)

	local panelSkin = window.panelSkin
	
	checkBoxSkin_ = panelSkin.checkBox:getSkin()
	editBoxSkin_ = panelSkin.editBox:getSkin()
	spinBoxSkin_ = panelSkin.spinBox:getSkin()
	separatorSkin_ = panelSkin.staticSeparator:getSkin()
	
	local box = window.box
    local panelButtons = box.panelButtons
    
    grid = box.grid
    createGridColumns_()
    
    function panelButtons.buttonRandom:onChange()
        rand()
    end
    
    function panelButtons.buttonClear:onChange()
        clear()
    end
end

function show(b)
    if not window then
        create_()
    end
    
    if b == true and needReCreate == true then	
        create_failures_list()
        needReCreate = false
    end
    
	update()
	window:setVisible(b)
end

function change_player_plane(isLoad, loadUnitType)
	if (panel_aircraft.vdata ~= nil) then
		old_plane = panel_aircraft.vdata.type
		getData(isLoad, loadUnitType)		
        needReCreate = true
	end		
end

function cloneFailure(failure)
	local result = {}
	
	result.label = failure.label
	
	result.enable = failure.enable 
	if result.enable == nil then
		result.enable = false
	end
	
    result.hh = failure.hh or 0
    result.mm = failure.mm or 0 
    result.mmint = failure.mmint or 1
    result.prob = failure.prob or 100
	result.hidden = failure.hidden or nil
				
    return result
end

function getData(isLoad, loadUnitType)
	vdata = { }
	vdata_view = { }
	if (isLoad == false) then
		local unit = getUnitByType(panel_aircraft.vdata.type)
		if (unit ~= nil) then
            local unitFailures = unit.Failures
            
			if unitFailures then						
				for k, unitFailure in pairs(unitFailures) do
					vdata[unitFailure.id] = cloneFailure(unitFailure)
					table.insert(vdata_view, unitFailure)
				end						
			end
		end
	else
		local unit = getUnitByType(loadUnitType)
		if (unit ~= nil) then
            local unitFailures = unit.Failures
            
			if unitFailures then
                local missionFailures = Mission.mission.failures
                
				for k, unitFailure in pairs(unitFailures) do
                    local unitFailureId = unitFailure.id
                    
					if (missionFailures[unitFailureId] ~= nil) then
						vdata[unitFailureId] = missionFailures[unitFailureId]
						local tmpV = missionFailures[unitFailureId]
                        
						tmpV['id'] = unitFailureId
                        tmpV.label = unitFailure.label

						table.insert(vdata_view, tmpV)
					else
						vdata[unitFailureId] = cloneFailure(unitFailure)
						table.insert(vdata_view, unitFailure)
					end
				end	
			end
		end
	end
end

function reset()
	vdata = {}
	vdata_view	 = { }
	create_failures_list()
	needReCreate = true
end

function create_failures_list()	
    if grid then
        grid:clearRows()	
        
        rows = { }
        local tabOrder = 1

        for k, v in pairs(vdata_view) do
			if v.hidden ~= true then
				local row = { }				
				
				row.cb, row.hh, row.mm, row.mmint, row.prob = fill_row(v.label, v.id, tabOrder)		
				
				tabOrder = tabOrder + 10
				rows[v.id] = row
			end	
        end
    end
end

function load_mission(unitType)
	old_plane = unitType
	panel_aircraft.vdata.type = unitType
	change_player_plane(true, unitType)
	update()
end

-- Вызывается после изменения таблицы vdata из данных миссии.
function update()
    for k, v in pairs(rows) do
        local id = k   
        local data = vdata[id]
        if data then
            v.cb:setState(data.enable)
            v.hh:setText(tostring(data.hh))
            v.mm:setText(tostring(data.mm))
            v.mmint:setText(tostring(data.mmint))
            v.prob:setValue(data.prob)
        end
    end
end


function clear()	
    for _k, v in pairs(vdata) do
        v.enable = false
        v.hh = 0
        v.mm = 0
        v.mmint = 1
        v.prob = 100
    end
    
    update()
end


function rand()
	U.randomseed()
    for _k, v in pairs(vdata) do
        v.enable 	= U.random(0, 1) == 1
        v.hh 		= U.random(0, 1)
        v.mm 		= U.random(0, 59)
        v.mmint 	= U.random(1, 59)
        v.prob 		= U.random(0, 100)
    end

    update()
end


function fill_row(label, name, tabOrder)
    local data = vdata[name]
    local rowIndex = grid:getRowCount()
    local rowHeight = 20    
    
    grid:insertRow(rowHeight)
    
    local cb_dev = CheckBox.new(label)
	
    cb_dev:setTabOrder(tabOrder) 
	cb_dev:setSkin(checkBoxSkin_)
    cb_dev:setState(data.enable)
    cb_dev:setTooltipText(label)
    
    grid:setCell(deviceColumnIndex_, rowIndex, cb_dev)
    
    function cb_dev:onChange()
        vdata[name].enable = self:getState()
    end
  
    local e_hh = EditBox.new(tostring(data.hh))
	
    e_hh:setTabOrder(tabOrder+1) 
	e_hh:setSkin(editBoxSkin_)
    e_hh:setNumber(true)

    grid:setCell(afterHoursColumnIndex_, rowIndex, e_hh)
    
    function e_hh:onChange()
        local num = U.editBoxNumericRestriction(self, 0, 23)
        vdata[name].hh = num
    end
    
	local staticSeparator = Static.new(':')
	
	staticSeparator:setSkin(separatorSkin_)
    grid:setCell(afterColonColumnIndex_, rowIndex, staticSeparator)    
    
    local e_mm = EditBox.new(tostring(data.mm))
	
    e_mm:setTabOrder(tabOrder+2) 
	e_mm:setSkin(editBoxSkin_)
    e_mm:setNumber(true)

    grid:setCell(afterMinutesColumnIndex_, rowIndex, e_mm)
    
    function e_mm:onChange()
        local num = U.editBoxNumericRestriction(self, 0, 59)
        vdata[name].mm = num
    end
    
    local e_mmint = EditBox.new(tostring(data.mmint))
	
    e_mmint:setTabOrder(tabOrder+3) 
	e_mmint:setSkin(editBoxSkin_)
    e_mmint:setNumber(true)

    grid:setCell(durationColumnIndex_, rowIndex, e_mmint)    
    
    function e_mmint:onChange()
        local num = U.editBoxNumericRestriction(self, 1, 24*60)
        vdata[name].mmint = base.tonumber(num)
    end
    
    local sp_prob = U.create_spin(0,100,1,data.prob)
    
    sp_prob:setTabOrder(tabOrder+4) 
	sp_prob:setSkin(spinBoxSkin_)
    grid:setCell(probabilityColumnIndex_, rowIndex, sp_prob)
    
    function sp_prob:onChange()
        vdata[name].prob = self:getValue()
    end
    
    return cb_dev, e_hh, e_mm, e_mmint, sp_prob
end

-- возвращает юнит по его имени
function getUnitByType(type)
  local result = nil
  -- сначала ищем в самолетах
  for _tmp, unit in pairs(me_db_api.db.Units.Planes.Plane) do
    if type == unit.type then
      result = unit
      break
    end
  end
  
  if not result then
    -- если не нашли в самолетах, ищем в вертолетах    
    for _tmp, unit in pairs(me_db_api.db.Units.Helicopters.Helicopter) do
        if type == unit.type then
            result = unit
            break
        end
    end    
  end
  
  return result
end

function isVisible()
	return window and window:isVisible()
end