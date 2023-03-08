--The module manages map objects associated with actions
--Interface:
--1. Creation target mark.
--2. Creation target mark linked to other map object.
--3. Showing target marks
--4. Deleting target marks on task deletion.

local base = _G

module('me_action_map_objects')

local MapWindow			= base.require('me_map_window')
local actionDB			= base.require('me_action_db')
local Terrain 			= base.require('terrain')
local AirdromeData		= base.require('Mission.AirdromeData')

local elements = {}

local function makeMarkName(group, wpt, task)
	return '  '..actionDB.getTaskDescriptionForMark(group, wpt, task)
end

mark = {
	set = function(elements, x, y, radius, group, wpt, task)
		wpt = wpt or (group and group.route.points[1])
		if wpt == nil then
			return
		end
		if elements.mark == nil then
			local index = wpt.targets and #wpt.targets + 1 or 1
			elements.mark = base.module_mission.insert_target(wpt, index, x, y, radius, makeMarkName(group, wpt, task))
			base.module_mission.update_group_map_objects(group)
		else
			MapWindow.move_target(elements.mark, x, y)
		end
		elements.mark.radius		= radius
		elements.mark.group			= group
		elements.mark.wptIndex		= wpt.index
		elements.mark.task			= task		
	end,
	move = function(elements, x, y)
		if elements.mark then
			MapWindow.move_target(elements.mark, x, y)
		end
	end,
	updateName = function(elements, group, wpt)
		if elements.mark then
			base.module_mission.set_target_name(elements.mark, makeMarkName(group, wpt, elements.mark.task))
		end
	end,
	remove = function(elements)
		if elements.mark then
			base.module_mission.remove_target(elements.mark)
			elements.mark = nil
		end
	end
}

targetMark = {
	set = function(elements, markTargetCont, group, wpt, task)
		wpt = wpt or (group and group.route.points[1])
		local target = nil
		if markTargetCont then
			target = markTargetCont:get()
		end	
		if	elements.mark then
			elements.markTargetCont = markTargetCont
			if target then
				MapWindow.move_target(	elements.mark,
										target.x,
										target.y)
			else
				base.module_mission.remove_target(elements.mark)
				elements.mark = nil
			end
		else
			if target and wpt then
				local index = wpt.targets and #wpt.targets + 1 or 1
				elements.mark 			= base.module_mission.insert_target(wpt, index, target.x, target.y, 0)
				elements.mark.group		= group
				elements.mark.wptIndex	= wpt.index
				elements.mark.task		= task
				elements.markTargetCont	= markTargetCont
				base.module_mission.update_group_map_objects(group)
				base.module_mission.update_group_map_objects(group)
				base.assert(group.mapObjects.route.targets[wpt.index][index] ~= nil)
			end
		end
	end,
	update = function(elements)
		if elements.mark then
			local target = elements.markTargetCont:get()
			if target then
				MapWindow.move_target(	elements.mark,
										elements.markTarget.x,
										elements.markTarget.y)
			else
				base.module_mission.remove_target(elements.mark)
				elements.mark = nil
			end
		end
	end,
	remove = function(elements)
		if elements.mark then
			base.module_mission.remove_target(elements.mark)
			elements.mark = nil		
		end
	end,
	unitById = {
		id = nil,
		new = function(self, id_)
			self.__index = self
			local newUnitById = {}		
			base.setmetatable(newUnitById, self)
			newUnitById.id = id_		
			return newUnitById
		end,
		get = function(self)
			return base.module_mission.unit_by_id[self.id]
		end
	},
	groupById = {
		id = nil,
		new = function(self, id_)
			self.__index = self
			local newGroupById = {}		
			base.setmetatable(newGroupById, self)
			newGroupById.id = id_		
			return newGroupById
		end,	
		get = function(self)
			return base.module_mission.group_by_id[self.id]
		end
	}	
}

function getMapElements(task)
	elements[task] = elements[task] or {}
	return elements[task]
end

local groupHandlers = {
	onShow = function(actionParams, elements, task, group, wpt)
		local targetGroup = base.module_mission.group_by_id[actionParams.groupId]
		if group and targetGroup then
			targetMark.set(elements, targetMark.groupById:new(targetGroup.groupId), group, wpt, task)
		else
			targetMark.remove(elements)
		end
	end,
	onRemove = function(actionParams, elements)
		targetMark.remove(elements)
	end
}

local unitHandlers = {
	onShow = function(actionParams, elements, task, group, wpt)
		local unit = base.module_mission.unit_by_id[actionParams.unitId]
		if unit then
			targetMark.set(elements, targetMark.unitById:new(unit.unitId), group, wpt, task)
		else
			targetMark.remove(elements)
		end
	end,		
	onRemove = function(actionParams, elements)
		targetMark.remove(elements)
	end
}

local bombingHandlers = {
	onShow = function(actionParams, elements, task, group, wpt)
		mark.set(elements, actionParams.x, actionParams.y, 0.0, group, wpt, task)
	end,
	onTaskNumberChange = function(actionParams, elements, task, group, wpt)
		mark.updateName(elements, group, wpt)
	end,
	onMoved = function()
		
	end,
	onRemove = function(actionParams, elements)
		if elements.mark then
			mark.remove(elements)
		end
	end
}

local zoneHandlers	= {
	onShow = function(actionParams, elements, task, group, wpt)
		mark.set(elements, actionParams.x, actionParams.y, actionParams.zoneRadius, group, wpt, task)
	end,
	onTaskNumberChange = function(actionParams, elements, task, group, wpt)
		mark.updateName(elements, group, wpt)
	end,
	onRemove = function(actionParams, elements)
		mark.remove(elements)
	end		
}

local handlers = {
	--Tasks
	[actionDB.ActionId.ATTACK_GROUP]		= groupHandlers,
	[actionDB.ActionId.ATTACK_UNIT]			= unitHandlers,
	[actionDB.ActionId.ATTACK_MAP_OBJECT] 	= bombingHandlers,
	[actionDB.ActionId.BOMBING]				= bombingHandlers,
	[actionDB.ActionId.BOMBING_RUNWAY] 		= {
		onShow = function(actionParams, elements, task, group, wpt)
			if actionParams.runwayId ~= nil then			
			local airdromes = AirdromeData.getTblOriginalAirdromes()
				local runway = airdromes[actionParams.runwayId]
				if runway then
					mark.set(elements, runway.reference_point.x, runway.reference_point.y, 0.0, group, wpt, task)
				else
					mark.remove(elements)
				end
			end
		end,
		onRemove = function(actionParams, elements)			
			mark.remove(elements)
		end
	},
	[actionDB.ActionId.LAND]				= bombingHandlers,
	[actionDB.ActionId.FAC_ATTACK_GROUP]	= groupHandlers,
	[actionDB.ActionId.FIRE_AT_POINT]		= bombingHandlers,
	[actionDB.ActionId.FOLLOW]				= groupHandlers,
	[actionDB.ActionId.ESCORT]				= groupHandlers,
	[actionDB.ActionId.EMBARK_TO_TRANSPORT]	= zoneHandlers,
	[actionDB.ActionId.EMBARKING]			= bombingHandlers,
	[actionDB.ActionId.DISEMBARKING]		= bombingHandlers,
    [actionDB.ActionId.CARPET_BOMBING]		= bombingHandlers,
	[actionDB.ActionId.WW2_BIG_FORMATION]	= groupHandlers,
	[actionDB.ActionId.GROUND_ESCORT]		= groupHandlers,
	[actionDB.ActionId.PARATROOPERS_DROP]	= bombingHandlers,
	[actionDB.ActionId.RECOVERY_TANKER]		= groupHandlers,
	--EnrouteTasks
	[actionDB.ActionId.ENGAGE_TARGETS_IN_ZONE] = {
		onShow = function(actionParams, elements, task, group, wpt)
			mark.set(elements, actionParams.x, actionParams.y, actionParams.zoneRadius, group, wpt, task)
		end,
		onTaskNumberChange = function(actionParams, elements, task, group, wpt)
			mark.updateName(elements, group, wpt)
		end,
		onRemove = function(actionParams, elements)
			mark.remove(elements)
		end		
	},
	[actionDB.ActionId.ENGAGE_GROUP]		= groupHandlers,
	[actionDB.ActionId.ENGAGE_UNIT]			= unitHandlers,
	[actionDB.ActionId.FAC_ENGAGE_GROUP]	= groupHandlers,	
	[actionDB.ActionId.SHIP_HOLD_POINT]		= groupHandlers,	
	[actionDB.ActionId.FIRE_AT_POINT]		= {
		onShow = function(actionParams, elements, task, group, wpt)
			mark.set(elements, actionParams.x, actionParams.y, task.params.zoneRadius or task.params.task.params.zoneRadius, group, wpt, task)
		end,
		onTaskNumberChange = function(actionParams, elements, task, group, wpt)
			mark.updateName(elements, group, wpt)
		end,		
		onRemove = function(actionParams, elements)
			if elements.mark then
				mark.remove(elements)
			end
		end
	},
	[actionDB.ActionId.CARGO_TRANSPORTATION] = {
		onRemove = function(actionParams, elements)
			if elements.mark then
				mark.remove(elements)
			end
		end	
	},
	
	[actionDB.ActionId.CARGO_TRANSPORTATION_PLANE] = {
		onRemove = function(actionParams, elements)
			if elements.mark then
				mark.remove(elements)
			end
		end	
	},
	
	[actionDB.ActionId.DETACH_TRAILER] = {
		onShow = function(actionParams, elements, task, group, wpt)
			mark.set(elements, actionParams.x, actionParams.y, 0.0, group, wpt, task)
		end,
		onTaskNumberChange = function(actionParams, elements, task, group, wpt)
			mark.updateName(elements, group, wpt)
		end,
		onMoved = function()
			
		end,
		onRemove = function(actionParams, elements)
			if elements.mark then
				mark.remove(elements)
			end
		end
	}	
}

local function callActionHandler(task, name, ...)
	local actionHandlers = handlers[actionDB.getActionIdByTask(task)]
	if actionHandlers then
		local handler = actionHandlers[name]
		if handler then
			local taskElements = elements[task]
			if taskElements then
				local actionParams = actionDB.getActionParams(task)
				handler(actionParams, taskElements, task, ...)
			end
		end
	end
end

function onTaskShow(group, wpt, task)
	elements[task] = elements[task] or {}
	base.assert(group == wpt.boss)
	callActionHandler(task, 'onShow', group, wpt)	
end

function onTaskRemove(task)
	callActionHandler(task, 'onRemove')
end

function onTaskNumberChange(task)
	callActionHandler(task, 'onTaskNumberChange')
end