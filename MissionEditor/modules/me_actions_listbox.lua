local base = _G

--The module contains list box of actions those associated with waypoint of route
--Interface:
--	1. Create controls (called from me_route).
--	2. Set waypoint of route from me_route(called from me_route).
--	3. Update (called from me_route).
--	3. Select item by task(called from me_action_edit_panel).
--	4. Notification about item has changed (called from me_action_edit_panel).

module('me_actions_listbox')

local require = base.require
local pairs = base.pairs
local ipairs = base.ipairs
local table = base.table

local DialogLoader      = require('DialogLoader')
local ListBoxItem       = require('ListBoxItem')
local Skin				= require('Skin')
local actionEditPanel	= require('me_action_edit_panel')
local actionDB			= require('me_action_db')
local actionMapObjects	= require('me_action_map_objects')
local crutches 			= require('me_crutches')
local MsgWindow 		= require('MsgWindow')
local vehicle			= require("me_vehicle")
local mod_mission      	= require('me_mission')
local mod_dictionary    = require('dictionary')
local ProductType 		= require('me_ProductType') 

require('i18n').setup(_M)

local instances = {}
local listBoxItemSkin = Skin.listBoxItemNoPictureSkin()

local function selectListBoxItem(self, item)
	self.listBox:selectItem(item)
	self.listBox:setItemVisible(item)
	self.vdata.currentItemIndex = item and item.number
end

local function getItemOtherTasks(self, item)
	return item.wpt ~= nil and item.wpt.task.params.tasks or self.vdata.group.tasks
end

local function updateItemText(self, item)
	item:setText(actionDB.getTaskDescription(self.vdata.group, item.wpt, item.task)..(item.reference and ' -ref' or ''))
end

local function removeItem(self, item)

	local listBox = self.listBox
	local isCurrentItem = (item == self.listBox:getSelectedItem())
	
	if item ~= nil then
		local tasks = getItemOtherTasks(self, item)
		
		if tasks ~= nil then
			local task
			for k,v in base.pairs(tasks) do
				if v.number == item.task.number then
					task = v
				end
			end
			if actionDB.allowToEditAutoTasks or not task.auto then
				if item.task.id == "EmbarkToTransport" then
					mod_mission.onTasksRemoveFromOtherGroups(self.vdata.group) --для Embarking/Disembarking
				end
	
				for i = item.task.number + 1, #tasks do
					tasks[i].number = tasks[i].number - 1
					actionMapObjects.onTaskNumberChange(tasks[i])
				end
				
				actionMapObjects.onTaskRemove(task)
				table.remove(tasks, item.task.number)
				if item.wpt ~= nil and
					item.wpt ~= self.vdata.wpt then
					self.vdata.enrouteRefCount = self.vdata.enrouteRefCount - 1
				end				
				actionDB.onTaskRemove(self.vdata.group, item.wpt, item.task)
				listBox:removeItem(item)	
				
				local count = listBox:getItemCount()
				
				for i = item.number, count do
					local item = listBox:getItem(i - 1)
					item.number = item.number - 1
					actionMapObjects.onTaskNumberChange(item.task)
					updateItemText(self, item)
				end				
				if isCurrentItem then
					local nextItem = listBox:getItem(item.number - 1)					
					if nextItem then
						selectListBoxItem(self, nextItem)						
					else
						selectListBoxItem(self, listBox:getItem(count - 1))
					end
				end
				
				actionEditPanel.setItemCount(count)
				vehicle.groupUnitsTransportCheck(true)
				
				return true
			end
		end		
	end
	return false
end

local function removeCurrentItem(self)
	return removeItem(self, self.listBox:getSelectedItem())
end

--Show action edit panel это панель редактирования задачи
function showActionEditPanel(self, item)
	if item then
		self.vdata.editedItemNumber = item.number
		actionEditPanel.setActionsListBox(self)
		actionEditPanel.open(item.number, self.vdata.group, item.wpt, item.task)	

		actionEditPanel.show(true)
		self.buttonEdit:setState(true)
		
		self.vdata.handlers.onActionEditPanelShow()
	end
end

--Delete selected item if it has default type
local function checkAndRemoveItem(self, item)
	local selectedTask = item and item.task			
	if selectedTask ~= nil then	
		local actionId = actionDB.getActionIdByTask(selectedTask)
		local actionType = actionDB.actionsData[actionId].type
		if actionId == actionDB.actionTypeData[actionType].defaultActionId then				
			removeItem(self, item)	
			actionEditPanel.show(false)	
		end
	end	
end

--Hide action edit panel
local function hideActionEditPanel(self)
	self.vdata.editedItemNumber = nil
	checkAndRemoveItem(self, self.listBox:getSelectedItem())
	actionEditPanel.show(false)
	self.vdata.handlers.onActionEditPanelHide()
    self.buttonEdit:setState(false)
end

--List box items management
local yellowColor = '0xff00ffff'
local greenColor  = '0x00ff00ff'
local itemTextColor

local function getTaskColor(task)
	if not itemTextColor then
        itemTextColor = {
            [true] = { --valid
                [true]	= '0xffffffff', --manual
                [false] = '0xffffff80', --auto
            },
            [false] = { --invalid
                [true]	= '0xff5c5cff', --manual
                [false]	= '0xff5c5c80', --auto				
            }
        }
    end
    
	if task.valid == nil and actionDB.isNoFullTask(task) == true then
		return yellowColor
	else
		if base.__PRODUCT_ID__ == 2 and task.valid == nil 
			and actionDB.getActionDataByTask(task).type == actionDB.ActionType.ENROUTE_TASK then
			return greenColor
		end
		
		return itemTextColor[task.valid == nil][task.auto]
	end
end

local function updateItemColor(item)
	local color = getTaskColor(item.task)
    local states = listBoxItemSkin.skinData.states
    
    states.released[1].text.color = color
    states.released[2].text.color = color
    states.hover[1].text.color = color
    states.hover[2].text.color = color

	item:setSkin(listBoxItemSkin)
end

local function updateItem(self, item)
	updateItemText(self, item)
	updateItemColor(item)
end

local function updateCurrentItem(self)
	local curItem = self.listBox:getSelectedItem()
	if curItem ~= nil then
		updateItem(self, curItem)
	end
end

--Creating an empty combo task
local function createComboTask()
	return { id = 'ComboTask', params = { tasks = {} } }
end

local function getTasks(self)
	if self.vdata.wpt then
		self.vdata.wpt.task = self.vdata.wpt.task or createComboTask()
		return self.vdata.wpt.task.params.tasks
	else
		self.vdata.group.tasks = self.vdata.group.tasks or {}
		return self.vdata.group.tasks
	end
end

local function cloneTask(self, task)
    local newTask = {}
    base.U.recursiveCopyTable(newTask,task)
	
	if newTask.params and newTask.params.action and newTask.params.action.params
		and newTask.params.action.params.KeyDict_subtitle then
		local oldKey = newTask.params.action.params.KeyDict_subtitle		
		local text = newTask.params.action.params.subtitle
		mod_dictionary.textToME(newTask.params.action.params,'subtitle', mod_dictionary.getNewDictId("subtitle"))	
		mod_dictionary.setValueToDict(newTask.params.action.params.KeyDict_subtitle, text)
		newTask.params.action.params.subtitle = text
	end 
	
	if newTask.params and newTask.params.action and newTask.params.action.params
		and newTask.params.action.params.file and newTask.params.action.params.file ~= "" then
		local oldKey = newTask.params.action.params.file
		newTask.params.action.params.file = mod_dictionary.getNewResourceId("advancedFile")
		local fileName, path = mod_dictionary.getValueResource(oldKey)   
		mod_dictionary.setValueToResource(newTask.params.action.params.file, fileName, path, nil, true)	
	end 
	
			
    --base.U.traverseTable(newTask)
	local tasks
	if self.vdata.wpt then	
		tasks = self.vdata.wpt.task.params.tasks
	else
		tasks = self.vdata.group.tasks
	end
	
	local maxNumber = 0
	for k,v in base.pairs(tasks)do
		if v.number > maxNumber then
			maxNumber = v.number
		end
	end
   
	maxNumber = maxNumber + 1
	
    newTask.number = maxNumber
    if self.vdata.wpt then		
		table.insert(self.vdata.wpt.task.params.tasks,newTask)
	else
		table.insert(self.vdata.group.tasks,newTask)
	end
    actionEditPanel.setItemCount(self.listBox:getItemCount()+1)
end

--Action validation
local function updateCurrentActionValid(self)
	if self.vdata.currentItemIndex then
		local currentItem = self.listBox:getItem(self.vdata.currentItemIndex - 1)
		local currentTask = currentItem and currentItem.task	
		
		if currentTask then
			local groupTask = crutches.taskToId(self.vdata.group.task) or 'Default'
			local oldValid = currentTask.valid
			
			currentTask.valid = actionDB.isActionValid(currentTask, self.vdata.group, self.vdata.wpt, groupTask)
			
			
			if (oldValid ~= nil) ~= (currentTask.valid ~= nil) then
				updateItem(self, currentItem)
			end
			
			return currentTask.valid
		end
	end
end

local actionValidDialog = nil

do

local cdata = {
	error					= _('ERROR'),
	ok						= _('OK'),
	cancel					= _('CANCEL'),
	continueQuestion		= _('Continue ?')
}

local function okCancelDialog(msg)
	local result = false
	local handler = MsgWindow.error(msg, cdata.error, cdata.ok, cdata.cancel)
	
	function handler:onChange(buttonText)
		result = (buttonText == cdata.ok)
	end
	
	handler:show()
	
	return result
end

actionValidDialog = function(self)
	local valid = updateCurrentActionValid(self)
	
	if valid ~= nil then		
		return okCancelDialog(valid..'\n'..cdata.continueQuestion)
	else
		return true
	end
end

end

--GUI handlers

local function listBoxOnChange(self, item, dblClick)
	local prevItem = self:getItem(self.parent.vdata.currentItemIndex - 1)
	checkAndRemoveItem(self.parent, prevItem)
	
	if self:getSelectedItem() == nil then
		hideActionEditPanel(self.parent)
	end	
	
	local curItem = self:getSelectedItem()
	
	if curItem then
		if actionEditPanel.isVisible() then
			if actionValidDialog(self.parent) then
				self.parent.vdata.currentItemIndex = curItem.number
				showActionEditPanel(self.parent, curItem)
			else			
				self:selectItem(self:getItem(self.parent.vdata.currentItemIndex - 1))
			end
		elseif dblClick then
			self.parent.vdata.currentItemIndex = curItem.number
			showActionEditPanel(self.parent, curItem)
		end
	end
    actionEditPanel.setItemCount(self:getItemCount())
end

--Buttons

--Add new item with default task to ListBox
local function addNewItem(self, number)
	--TASK
	local taskNumber = number - self.vdata.enrouteRefCount
	local newTask = actionDB.createDefaultTask(self.vdata.group, taskNumber)
	local tasks = getTasks(self)
	tasks[taskNumber] = newTask
	--ITEM
	local newTaskItem = ListBoxItem.new("New task")
	newTaskItem.task = newTask
	newTaskItem.number = number
	newTaskItem.wpt = self.vdata.wpt
	self.listBox:insertItem(newTaskItem, number - 1)
	updateItemText(self, newTaskItem)
	selectListBoxItem(self, newTaskItem)
	base.assert(self.listBox:getItem(number - 1).number == number)	
    actionEditPanel.setItemCount(self.listBox:getItemCount())

	return newTaskItem
end

local function checkIfItemAddingValid(self)
	if actionEditPanel.isVisible() then
		return actionValidDialog(self.parent)
	else
		updateCurrentActionValid(self.parent)
		return true
	end
end

local function buttonAddOnChange(self)
	if not checkIfItemAddingValid(self) then
		return
	end
	checkAndRemoveItem(self.parent, self.parent.listBox:getSelectedItem())
	local itemCount = self.parent.listBox:getItemCount() + 1
	local newTaskItem = addNewItem(self.parent, itemCount)
	self.parent.buttonEdit:setState(false)
	showActionEditPanel(self.parent, newTaskItem)
	actionEditPanel.setItemCount(itemCount)
end

local function buttonCloneOnChange(self)
    local curItem = self.parent.listBox:getSelectedItem()	
	if 	curItem and
		curItem.number > self.parent.vdata.enrouteRefCount and
		(actionDB.allowToEditAutoTasks or not curItem.task.auto) then
		local itemCount = self.parent.listBox:getItemCount()
		local tasks = getTasks(self.parent)

        local curItemIndex = curItem.number - 1
        local task = tasks[curItem.task.number]
        if task then
            cloneTask(self.parent, task)
            update(self.parent, true)
        end
    end            
end

local function buttonInsertOnChange(self)
	if not checkIfItemAddingValid(self) then
		return
	end
	
	local listBox = self.parent.listBox
	local curItem = listBox:getSelectedItem()
	if 	curItem and 
		curItem.number > self.parent.vdata.enrouteRefCount then
		local newItemIndex = curItem.number

		local tasks = getTasks(self.parent)
		if tasks then
			for i = #tasks, curItem.task.number, -1 do
				local curAction = tasks[i]
				curAction.number = curAction.number + 1
				tasks[i + 1] = curAction
			end
			
			local count = listBox:getItemCount()
			
			for i = newItemIndex, count do
				local item = listBox:getItem(i - 1)
				item.number = item.number + 1
				updateItemText(self.parent, item)
			end
		end
		
		local newTaskItem = addNewItem(self.parent, newItemIndex)
		self.parent.buttonEdit:setState(false)
		showActionEditPanel(self.parent, newTaskItem)
		actionEditPanel.setItemCount(listBox:getItemCount())
		
		checkAndRemoveItem(self.parent, curItem)
	end
end

local function toggleButtonEditOnChange(self)
	if self:getState() then
		local curItem = self.parent.listBox:getSelectedItem()
		if curItem then
			showActionEditPanel(self.parent, curItem)
		else
			self:setState(false)
		end
	else
		if actionValidDialog(self.parent) then
			hideActionEditPanel(self.parent)
		else
			self.parent.buttonEdit:setState(true)
		end
	end
end

local function buttonDelOnChange(self)
	if removeCurrentItem(self.parent) then
		hideActionEditPanel(self.parent)
	end
end

local function buttonUpOnChange(self)
	checkAndRemoveItem(self.parent, self.parent.listBox:getSelectedItem())
	local curItem = self.parent.listBox:getSelectedItem()		
	if 	curItem and
		curItem.number > self.parent.vdata.enrouteRefCount + 1 and
		curItem.number > 1 and
		(actionDB.allowToEditAutoTasks or not curItem.task.auto) then
		local curItemIndex = curItem.number - 1
		local prevItem = self.parent.listBox:getItem(curItemIndex - 1)
		local tasks = getTasks(self.parent)
		if actionDB.allowToEditAutoTasks or not prevItem.task.auto then
			tasks[curItem.task.number] = prevItem.task
			tasks[prevItem.task.number] = curItem.task
			curItem.task.number = curItem.task.number - 1
			prevItem.task.number = prevItem.task.number + 1
			local curItemAction = curItem.task
			curItem.task = prevItem.task
			prevItem.task = curItemAction
			updateItemText(self.parent, curItem)
			updateItemText(self.parent, prevItem)			
			selectListBoxItem(self.parent, prevItem)
			actionMapObjects.onTaskNumberChange(curItem.task)
			actionMapObjects.onTaskNumberChange(prevItem.task)
		end
	end		
end

local function buttonDownOnChange(self)
	checkAndRemoveItem(self.parent, self.parent.listBox:getSelectedItem())
	local curItem = self.parent.listBox:getSelectedItem()		
	if 	curItem and
		curItem.number > self.parent.vdata.enrouteRefCount and
		(actionDB.allowToEditAutoTasks or not curItem.task.auto) then
		local itemCount = self.parent.listBox:getItemCount()
		local tasks = getTasks(self.parent)
		if curItem.number < itemCount then
			local curItemIndex = curItem.number - 1
			local nextItem = self.parent.listBox:getItem(curItemIndex + 1)
			if actionDB.allowToEditAutoTasks or not nextItem.task.auto then
				tasks[curItem.task.number] = nextItem.task
				tasks[nextItem.task.number] = curItem.task
				curItem.task.number = curItem.task.number + 1
				nextItem.task.number = nextItem.task.number - 1
				local curItemAction = curItem.task
				curItem.task = nextItem.task
				nextItem.task = curItemAction
				updateItemText(self.parent, curItem)
				updateItemText(self.parent, nextItem)
				selectListBoxItem(self.parent, nextItem)
				actionMapObjects.onTaskNumberChange(curItem.task)
				actionMapObjects.onTaskNumberChange(nextItem.task)
			end
		end
	end
end


local function createGUI(tbl)
    local cdata = {
        add				= _('ADD'),
        insert			= _('INS'),
        edit			= _('EDIT'),
        del				= _('DEL'),
        up				= _('UP'),
        down			= _('DOWN'),
        clone           = _('CLONE'),
		actionListBoxToolTip	= _('List of actions.\nNote: actions will being performed in order they are enlisted!'),
		addToolTip				= _('Add new action at the end of the list'),
		insertToolTip			= _('Insert new action before the current action'),
		editToolTip				= _('Open current action'),
		deleteToolTip			= _('Delete current action'),
		upToolTip				= _('Move current action up the list'),
		downToolTip				= _('Move current action down the list'),
		cloneToolTip			= _('Clone current action'),
    }
    
	local dialog = DialogLoader.spawnDialogFromFile('MissionEditor/modules/dialogs/me_actions_listbox.dlg', cdata)
    local panel = dialog.panel
    
    dialog:removeWidget(panel)
    dialog:kill()
    
	local add = function(widget, parentTbl, field)
		parentTbl[field] = widget
		widget.parent = parentTbl
	end
    
	add(panel, tbl, 'panel')
	
	--Actions list box
	local listBox = panel.listBox

	add(listBox, tbl, 'listBox')
	listBox.onChange = listBoxOnChange

    --1. "Add" button. Adds new item to the end of the actions list		
    local buttonAdd = panel.buttonAdd
    add(buttonAdd, tbl, 'buttonAdd')
    buttonAdd.onChange = buttonAddOnChange

    --2. "INSERT" button. Inserts new item before the selected item of the actions list
    local buttonInsert = panel.buttonInsert
    add(buttonInsert, tbl, 'buttonInsert')
    buttonInsert.onChange = buttonInsertOnChange

    --3. "EDIT" button. Show and hide action edit panel for current item of the actions list.
    local toggleButtonEdit = panel.toggleButtonEdit
    add(toggleButtonEdit, tbl, 'buttonEdit')
    toggleButtonEdit.onChange = toggleButtonEditOnChange

    --4. "DEL" button. Deletes selected item
    local buttonDel = panel.buttonDel
    add(buttonDel, tbl, 'buttonDel')
    buttonDel.onChange = buttonDelOnChange

    --5. "UP" button. Swaps current and previous items
    local buttonUp = panel.buttonUp
    add(buttonUp, tbl, 'buttonUp')
    buttonUp.onChange = buttonUpOnChange

    --6. "DOWN" button. Swaps current and next items
    local buttonDown = panel.buttonDown
    add(buttonDown, tbl, 'buttonDown')
    buttonDown.onChange = buttonDownOnChange
    
    --6. "CLONE" button. 
    local buttonClone = panel.buttonClone
    add(buttonClone, tbl, 'buttonClone')
    buttonClone.onChange = buttonCloneOnChange
end

function create()
	
	local key = {}
	
	local theInstance = { vdata = 
							{
								group = nil,
								wpt = nil,
								tasks = nil,
								editedItemNumber = nil,
								enrouteRefCount = 0,
								currentItemIndex = nil
							},
						}
	
	instances[key] = theInstance
	
	local theModule = base.getfenv()
	theModule.__index = theModule
	base.setmetatable(theInstance, theModule)
	
	createGUI(theInstance)
	
	return theInstance
end

function setHandlers(self, handlers)
	self.vdata.handlers = handlers
end

--Show/hide listbox
function show(self, b)
	if not b then
		hideActionEditPanel(self)
	end    
	self.panel:setVisible(b)
end

local function showTasksMapObjects(self)
	if base.MapWindow.isShowHidden(self.vdata.group) == true then
		for wptIndex, wpt in pairs(self.vdata.group.route.points) do
			if wpt.task then
				for subtaskIndex, subtask in pairs(wpt.task.params.tasks) do
					actionMapObjects.onTaskShow(self.vdata.group, wpt, subtask)
				end
			end
		end
		if self.vdata.group.tasks ~= nil then
			for subtaskIndex, subtask in pairs(self.vdata.group.tasks) do
				actionMapObjects.onTaskShow(self.vdata.group, self.vdata.group.route.points[1], subtask)
			end
		end
	end
end

--Set waypoint (with its own actions list)
function setWaypoint(self, wpt)
	if self.vdata.wpt ~= wpt then
		self.vdata.wpt = wpt
		showTasksMapObjects(self)
		hideActionEditPanel(self)
		update(self, false)
	end
end

function updateWaypoint(self)
	if actionEditPanel.isVisible() then
		showActionEditPanel(self, self.listBox:getSelectedItem())		
	end
end

--Set group and waypoint
function setGroupAndWpt(self, group, wpt)
	base.assert(group ~= nil)
	if self.vdata.group ~= group then
		self.vdata.group = group
		self.vdata.wpt = wpt
		showTasksMapObjects(self)
		hideActionEditPanel(self)
		update(self, false)
	end
end

--Set group
function setGroup(self, group)
	if self.vdata.group ~= group then
		hideActionEditPanel(self)
		self.vdata.group = group
		self.vdata.wpt = nil
		showTasksMapObjects(self)
		update(self, false)
	end
end

local function makeListItem(self, wpt, task, number, reference)
	local newItem = ListBoxItem.new(task.id)
	newItem.number = number
	newItem.task = task
	newItem.wpt = wpt
	newItem.reference = reference
	updateItem(self, newItem)
	return newItem
end

--Checks is the task a enroute active (stop conditions checking) task
local function isActiveEnrouteTask(task, curWptIndex)
	if actionDB.getActionDataByTask(task).type == actionDB.ActionType.ENROUTE_TASK then
		if task.id == 'ControlledTask' then
			if 	task.params.stopCondition and
				task.params.stopCondition.lastWaypoint and
				task.params.stopCondition.lastWaypoint < curWptIndex then
				return false
			end
		end
		return true
	end
	return false
end

--Select item and open action edit panel
local function selectItem_(self, itemNumber)
	local item = self.listBox:getItem(itemNumber - 1)
	selectListBoxItem(self, item)
	if actionEditPanel.isVisible() then
		showActionEditPanel(self, item)
		actionEditPanel.setItemCount(self.listBox:getItemCount())
	end
	return item
end

--Selects item of task
local function selectItemByTask(self, task)
	local listBox = self.listBox
	local counter = listBox:getItemCount() - 1
	
	for i = 0, counter  do
		local item = listBox:getItem(i)
		
		if item.task == task then
			return selectItem_(self, item.number)
		end
	end
end

--Rebuild list box
function update(self, saveSelected)
	local selectedItem = self.listBox:getSelectedItem()
	local selectedTask = selectedItem and selectedItem.task
	self.listBox:clear()
	
	local itemNumber = 0
	if self.vdata.wpt ~= nil then		
		--active enroute tasks of all previous waypoint		
		for wptIndex = 1, self.vdata.wpt.index - 1 do
			local prevWpt = self.vdata.group.route.points[wptIndex]
			if prevWpt.task then
				for taskNum, task in ipairs(prevWpt.task.params.tasks) do
					if isActiveEnrouteTask(task, self.vdata.wpt.index) then
						itemNumber = itemNumber + 1
						self.listBox:insertItem(makeListItem(self, prevWpt, task, itemNumber, true))
					end
				end
			end
		end
		self.vdata.enrouteRefCount = itemNumber
	end
	--local tasks
	local tasks = getTasks(self)
	for taskIndex, task in ipairs(tasks) do
		itemNumber = itemNumber + 1
		self.listBox:insertItem(makeListItem(self, self.vdata.wpt, task, itemNumber, false))
	end
	if saveSelected and selectedTask then
		selectItemByTask(self, selectedTask)
	else
		selectListBoxItem(self, self.listBox:getItem(0))
	end
	
	if self.listBox:getSelectedItem() == nil then
		hideActionEditPanel(self)
	end	
end

--Selects item of task
function selectItemByTaskAndOpenPanel(self, task)
	local item = selectItemByTask(self, task)
	if item ~= nil then    
		showActionEditPanel(self, item)
        return true
    else  
        return false
	end
end

--Select item and open action edit panel with task verification
function selectItem(self, itemNumber)
	if actionValidDialog(self) then
		return selectItem_(self, itemNumber)
	else
		return self.listBox:getSelectedItem()
	end
end

--Notification about item has changed in action edit panel
function onActionChange(self)
	local item = self.listBox:getItem(self.vdata.editedItemNumber - 1)
	if item ~= nil then
		updateItem(self, item)
	end
end

function onGroupTaskChange(self)
	actionEditPanel.onGroupTaskChange()
	update(self, true)
end

function onUnitTypeChange(self)
	actionEditPanel.onUnitTypeChange()
	update(self, true)
end

function onCloseAttempt(self)
	updateCurrentActionValid(self)
end

function onMapUnitSelected(self, unit)
	if actionEditPanel.onMapUnitSelected(unit) then
		updateCurrentItem(self)
		return true
	end
	return false
end

function onTargetMoved(self, x, y)
	if actionEditPanel.onTargetMoved(x, y) then
		updateCurrentItem(self)
		return true
	end
	return false
end

function removeItemByTask(self, task)
	local item = selectItemByTask(self, task)
	if item ~= nil then        
		removeItem(self, item)
        return true
    else  
        return false
	end
end

function showActionEditPanelForCurItem(self)
	local curItem = self.listBox:getSelectedItem()
	
	if curItem then
		if actionEditPanel.isVisible() then
			if actionValidDialog(self) then
				self.vdata.currentItemIndex = curItem.number
				showActionEditPanel(self, curItem)
			else			
				self.listBox:selectItem(self.listBox:getItem(self.vdata.currentItemIndex - 1))
			end
		else
			self.vdata.currentItemIndex = curItem.number
			showActionEditPanel(self, curItem)
		end
	end
end
