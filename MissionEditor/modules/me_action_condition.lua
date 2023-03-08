local base = _G

module('me_action_condition')

local require = base.require

local DialogLoader		= require('DialogLoader')
local SpinWPT           = require('me_spin_wpt')
local U					= require('me_utilities')
local actionDB			= require('me_action_db')
local actionMapObjects	= require('me_action_map_objects')

base.require('i18n').setup(_M)

local cdata = {
	timeMore 	= _('TIME MORE'),
	isUserFlag 	= _('IS USER FLAG'),
	probability = _('PROBABILITY'),
	condition 	= _('CONDITION (LUA PREDICATE)'),
	duration 	= _('DURATION'),
	lastWaypoint = _('LAST WPT'),
	value	= _('IS'),
	userFlagIdToolTip = _('User flag ID'),
	userFlagValueToolTip = _('User flag value'),
	probabilityToolTip = _('Probability value')
}

local vdata = {
	condition = nil,
	handler = nil
}

conditionType = {
	TASK_START_CONDITION = 1,
	TASK_STOP_CONDITION = 2,
	ENROUTE_TASK_STOP_CONDITION = 3
}

function create(x, y, w, h)
	window = DialogLoader.spawnDialogFromFile('MissionEditor/modules/dialogs/action_condition_panel.dlg', cdata)
	window:setBounds(x, y, w, h)
	
	local boxX, boxY = window.staticPanelPlaceHolder:getPosition()
	
	window.panelActionCondition:setPosition(boxX, boxY)
	window.panelTaskStopCondition:setPosition(boxX, boxY)
	window.panelEnrouteTaskStopCondition:setPosition(boxX, boxY)
	
	boxes = {}
	boxes[conditionType.TASK_START_CONDITION] 			= createActionConditionBox(window.panelActionCondition)
	boxes[conditionType.TASK_STOP_CONDITION] 			= createTaskStopConditionBox(window.panelTaskStopCondition)
	boxes[conditionType.ENROUTE_TASK_STOP_CONDITION] 	= createEnrouteTaskStopConditionBox(window.panelEnrouteTaskStopCondition)
	
	box = nil
	
end

function createActionConditionBox(box)
	fillActionConditionBox(box)
	
	return box
end

function fillActionConditionBox(box)	
	--1. Time
	function box.timeCheckBox:onChange()
		box.timePanel:setEnabled(self:getState())
		if self:getState() then
			vdata.condition.time = box.timePanel:getTime() - base.module_mission.mission.start_time
		else
			vdata.condition.time = nil
		end
		vdata.handler.onConditionsChange()
	end
	
	local timePanel = U.create_time_panel()
	
	timePanel:setBounds(box.staticTimePanelPlaceHolder:getBounds())
	timePanel:setTime(30 * 60 + 0)
	
	function timePanel:onChange()
		vdata.condition.time = self:getTime() - base.module_mission.mission.start_time
	end	
	
	box:insertWidget(timePanel)
	box.timePanel = timePanel


	--2. User Flag	
	function box.userFlagCheckBox:onChange()
		box.userFlagEditBox:setEnabled(self:getState())
		box.userFlagValueCheckBox:setEnabled(self:getState())
		if self:getState() then
			vdata.condition.userFlag = box.userFlagEditBox:getText()
		else
			vdata.condition.userFlag = nil
		end
		vdata.handler.onConditionsChange()
	end
	
	function box.userFlagEditBox:onChange()
		vdata.condition.userFlag = self:getText()
	end	
		
	function box.userFlagValueCheckBox:onChange()
		vdata.condition.userFlagValue = self:getState()
	end
			
	--3. Probability
	function box.probabilityCheckBox:onChange()
		box.probabilitySpin:setEnabled(self:getState())
		if self:getState() then
			vdata.condition.probability = box.probabilitySpin:getValue()
		else
			vdata.condition.probability = nil
		end
		vdata.handler.onConditionsChange()
	end
	
	function box.probabilitySpin:onChange()
		vdata.condition.probability = self:getValue()
	end		
	
	--4-5. Condition
	function box.conditionCheckBox:onChange()
		box.conditionMemo:setEnabled(self:getState())
		if self:getState() then
			vdata.condition.condition = box.conditionMemo:getText()
		else
			vdata.condition.condition = nil
		end
		vdata.handler.onConditionsChange()
	end
	
	function box.conditionMemo:onChange()
		vdata.condition.condition = self:getText()
	end
	
	function box:open(condition)
		self.timeCheckBox:setState(condition.time ~= nil)
		self.timePanel:setEnabled(condition.time ~= nil)
		self.timePanel:setTime(condition.time and (base.module_mission.mission.start_time + condition.time) or base.module_mission.mission.start_time + (vdata.wpt and vdata.wpt.ETA or 0.0))
		self.userFlagCheckBox:setState(condition.userFlag ~= nil)
		self.userFlagEditBox:setEnabled(condition.userFlag ~= nil)
		self.userFlagEditBox:setText(condition.userFlag or "0")
		self.userFlagValueCheckBox:setEnabled(condition.userFlag ~= nil)
		self.userFlagValueCheckBox:setState(condition.userFlagValue == nil or condition.userFlagValue == true)
		self.probabilityCheckBox:setState(condition.probability ~= nil)
		self.probabilitySpin:setEnabled(condition.probability ~= nil)
		self.probabilitySpin:setValue(condition.probability or 100)
		self.conditionCheckBox:setState(condition.condition ~= nil)
		self.conditionMemo:setEnabled(condition.condition ~= nil)
		if condition.condition then
			self.conditionMemo:setText(condition.condition)
		else
			self.conditionMemo:setText()
		end
	end
end

function createTaskStopConditionBox(box)
	fillTaskStopConditionBox(box)
	
	return box
end

function fillTaskStopConditionBox(box)
	fillActionConditionBox(box)
	
	box.probabilityCheckBox:setEnabled(false)

	--6. Duration
	function box.durationCheckBox:onChange()
		box.durationPanel:setEnabled(self:getState())
		if self:getState() then
			vdata.condition.duration = box.durationPanel:getTime()
		else
			vdata.condition.duration = nil
		end
		vdata.handler.onConditionsChange()
	end
	
	local durationPanel = U.create_time_panel()
	
	durationPanel:setBounds(box.staticDurationPanelPlaceHolder:getBounds())
	durationPanel:setTime(30 * 60 + 0)

	function durationPanel:onChange()
		vdata.condition.duration = self:getTime()
	end
	
	box:insertWidget(durationPanel)
	box.durationPanel = durationPanel
	
	function box:open(condition)
		boxes[conditionType.TASK_START_CONDITION].open(self, condition)
		self.timePanel:setTime(condition.time and (base.module_mission.mission.start_time + condition.time) or base.module_mission.mission.start_time + (vdata.wpt and vdata.wpt.ETA or 0.0) + 15 * 60)
		self.durationCheckBox:setState(condition.duration ~= nil)
		self.durationPanel:setEnabled(condition.duration ~= nil)
		self.durationPanel:setTime(condition.duration or 15 * 60)
	end
end

function createEnrouteTaskStopConditionBox(box)
	fillEnrouteTaskStopConditionBox(box)
	
	return box
end

function fillEnrouteTaskStopConditionBox(box)
	fillTaskStopConditionBox(box)
	
	--7. Last waypoiny
	function box.lastWaypointCheckBox:onChange()
		box.lastWaypointSpin:setEnabled(self:getState())
		if self:getState() then
			vdata.condition.lastWaypoint = box.lastWaypointSpin:getCurIndex()
		else
			vdata.condition.lastWaypoint = nil
		end
		vdata.handler.onConditionsChange()
	end

    box.lastWaypointSpin = SpinWPT.new()
    local con_wpt = box.lastWaypointSpin:create(box.staticSpinWptPlaceHolder:getBounds())
    box:insertWidget(con_wpt)
    function box.lastWaypointSpin:onChange()
		vdata.condition.lastWaypoint = self:getCurIndex()
	end
	
	function box:open(condition)
		boxes[conditionType.TASK_STOP_CONDITION].open(self, condition)		
		self.lastWaypointCheckBox:setState(condition.lastWaypoint ~= nil and #vdata.group.route.points > 1)
		
		self.lastWaypointCheckBox:setEnabled(#vdata.group.route.points > 1)
		self.lastWaypointSpin:setEnabled(condition.lastWaypoint ~= nil and #vdata.group.route.points > 1)
		local nextWaypointIndex 
		if vdata.wpt then
			if (vdata.wpt.index + 1) <= #vdata.group.route.points then
				nextWaypointIndex = vdata.wpt.index + 1
			end
		else
			if 2 <= #vdata.group.route.points then
				nextWaypointIndex = 2
			end
		end

		if nextWaypointIndex then
			self.lastWaypointSpin:setWPT(nextWaypointIndex, #vdata.group.route.points, vdata.group.boss.name, nextWaypointIndex)
		else
			self.lastWaypointSpin:clear()
			condition.lastWaypoint = nil
			self.lastWaypointCheckBox:setState(false)
			self.lastWaypointCheckBox:setEnabled(false)
		end
		
		if condition.lastWaypoint ~= nil then
			if  #vdata.group.route.points < condition.lastWaypoint then
				self.lastWaypointSpin:setCurIndex(nextWaypointIndex)
				self.lastWaypointCheckBox:setState(false)
				condition.lastWaypoint = self.lastWaypointSpin:getCurIndex()
			else
				self.lastWaypointSpin:setCurIndex(condition.lastWaypoint)
			end	
		else
			if nextWaypointIndex then
				self.lastWaypointSpin:setCurIndex(nextWaypointIndex)
			end	
		end
		
		self.lastWaypointCheckBox:onChange()		
	end	
end

function show(b, condition)
	window:setVisible(b)
end

function open(condition, handler, conditionType, wpt, group)

	vdata.condition = condition
	vdata.handler = handler
	vdata.group = group
	vdata.wpt = wpt
	if box then
		box:setVisible(false)
	end
	box = boxes[conditionType]
	base.assert(box ~= nil)
	box:open(condition)
	box:setVisible(true)
	show(true)
end

function close()
	show(false)
end

-- для внешнего вызова при изменении числа waypoints
function correctWaypointsInActions(a_group, a_isAdd, a_index)
	

	if a_group.route and a_group.route.points then
		for k,point in base.pairs(a_group.route.points) do
			if point.task and point.task.params and point.task.params.tasks then
				local toRemove = {}
				for kk, task in base.pairs(point.task.params.tasks) do				
					if task.params and task.params.stopCondition and task.params.stopCondition.lastWaypoint then
						if a_isAdd then
							if a_index <= task.params.stopCondition.lastWaypoint then
								task.params.stopCondition.lastWaypoint = task.params.stopCondition.lastWaypoint + 1
							end
						else							
							if a_index < task.params.stopCondition.lastWaypoint then
								task.params.stopCondition.lastWaypoint = task.params.stopCondition.lastWaypoint - 1
							elseif a_index == task.params.stopCondition.lastWaypoint then
								if a_index <= #a_group.route.points then
									task.params.stopCondition.lastWaypoint = a_index
								else
									task.params.stopCondition.lastWaypoint = nil
									--удаляем ControlledTask если в нем ничего не остается
									if task.id == 'ControlledTask' then
										if task.params.condition and
											not actionDB.isStartConditionDefined(task.params.condition) then
											task.params.condition = nil
										end
										if task.params.stopCondition and
											not actionDB.isStopConditionDefined(task.params.stopCondition) then
											task.params.stopCondition = nil
										end
										if task.params.condition == nil and task.params.stopCondition == nil then
											task.id = task.params.task.id
											task.params = task.params.task.params
										end
									end
								end
							end	
						end						
					end
					
					if task.params and task.params.action and task.params.action.id == 'SwitchWaypoint' then
						local params = task.params.action.params 
						if a_isAdd then
							if a_index <= params.goToWaypointIndex then
								params.goToWaypointIndex = params.goToWaypointIndex + 1
							end
							if a_index <= params.fromWaypointIndex then
								params.fromWaypointIndex = params.fromWaypointIndex + 1
							end
						else
							if a_index <= params.goToWaypointIndex then
								params.goToWaypointIndex = params.goToWaypointIndex - 1
							end
							if a_index <= params.fromWaypointIndex then
								params.fromWaypointIndex = params.fromWaypointIndex - 1
							end
						end
						
						if params.goToWaypointIndex == params.fromWaypointIndex then
							-- удаляем задачу
							base.table.insert(toRemove,kk)
						end
					end
				end			
				
				for i = #toRemove, 1, -1 do								
					actionMapObjects.onTaskRemove(a_group.route.points[k].task.params.tasks[toRemove[i]])
					local tmp = a_group.route.points[k].task.params.tasks[toRemove[i]]
					base.table.remove(a_group.route.points[k].task.params.tasks, toRemove[i])
					actionDB.onTaskRemove(a_group, point, tmp)			
				end

				for kk, task in base.pairs(point.task.params.tasks) do
					task.number = kk
				end
			end
		end
	end	
end