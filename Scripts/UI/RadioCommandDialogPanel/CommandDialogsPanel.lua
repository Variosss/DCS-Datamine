--Base implementation of Command Dialogs Panel. Not depended on DCS objects.
--Panel contains Main Command Menu and may contain several Dialog Command Menus.
--Each time only one menu is visible. To indicate all open menus tab sheet bar is in the upper side of the screen.

--Configuration of the Main Command menu is stored in:
--./Scripts/UI/RadioCommandDialogPanel/Config/*.lua
--./Mods/%ModeType%/%ModeName%/comm.lua

--Configuration of Command Dialogs is stored in:
--./Scripts/UI/RadioCommandDialogPanel/Config/Common/*.lua

--Command Dialogs are opened by trigger events.
--Command Dialogs changes their stage on events.
--Command Dialogs are closed when finish stage is reached.
--CommandDialogsPanel passes messages to the Main Command Menu and to the corresponded Command Dialog.

local base = _G

module('CommandDialogsPanel')

__index = base.getfenv()

local require = base.require
local pairs = base.pairs
local table = base.table
local print = base.print
local tostring = base.tostring
local setmetatable = base.setmetatable

local DialogLoader	= require('DialogLoader')
local CommandMenu	= require('CommandMenu')
local CommandDialog	= require('CommandDialog')
local fsm			= require('fsm')
local list			= require('list')
local utils			= require('utils')
local Gui			= require('dxgui')
local TabSheetBar	= require('TabSheetBar')
local DCS           = require('DCS')
local HMD           = base.HMD

commandDialogIts = {} --map of iterators
dialogsList = nil
curDialogIt = nil --iterator in dialogsList
dialogsState = {}

toggled = false
showMenu = false

local captionsMax = 5
local captionPrev = 6
local captionNext = 7

function TERMINATE()
	return { 	finish = true,
				newStage = 'Closed' }
end

function TO_STAGE(tbl, dialogName, stageName, stackOption_, depth_)
	return { 	menu 		= tbl.dialogs[dialogName].menus[stageName],
				newStage 	= stageName,
				stackOption = stackOption_,
				depth 		= depth_ }
end

--private:

local function setCurDialogIt_(self, curDialogIt)
	base.assert(curDialogIt ~= nil)			
	self.curDialogIt = curDialogIt
	local tabIndex = self.curDialogIt.element_.index
	self.tabSheetBar:setCurrentTabIndex(tabIndex)
end

function toggleDialog_(self, dialog, on)
	dialog:toggle(on)
	dialog:toggleMenu(self.showMenu)
	return on
end

local function openDialog_(self, dialog)
	if 	dialog and
		self:toggleDialog_(dialog, true) then
		--print(tostring(self.dialogsState[dialog]))
		if self.dialogsState[dialog] == nil then
			dialog:setMainMenu()
		else
			dialog:updateMenu()
		end
		self.dialogsState[dialog] = true
	end
end

local function closeDialog_(self, dialog)
	if self:toggleDialog_(dialog, false) then
		self.dialogsState[dialog] = false
	end
end

local function switchToDialog_(self, dialogIt)
	if dialogIt ~= self.curDialogIt then
		if self.curDialogIt then
			closeDialog_(self, self.curDialogIt.element_)
		end
		openDialog_(self, dialogIt.element_)
		setCurDialogIt_(self, dialogIt)
	end
end

local function getNextDialog_(self)
	local itStart = self.curDialogIt
	local itNext = itStart
	repeat
		itNext = itNext.next_ or self.dialogsList.head
	until itNext.element_:isAvailable() or itNext == itStart
	base.assert(itNext ~= nil)
	return itNext
end

local function getDialogNameFor_(self, senderId)
	local dialogs = self.commandDialogIts[senderId]
	if dialogs ~= nil then
		for dialogName, dialogIt in pairs(dialogs) do
			return dialogName
		end
	end
end

local function closeTabSheetBarFunc(self, time)
	self.tabSheetBar:getContainer():setVisible(false)
	self.tabSheetBarFuncRef = nil
	return nil
end

local function showTabSheetBar(self)
	self.tabSheetBar:getContainer():setVisible(true)
	local disappearTime = base.timer.getTime() + 3.0
	if self.tabSheetBarFuncRef == nil then
		self.tabSheetBarFuncRef = base.timer.scheduleFunction(closeTabSheetBarFunc, self, disappearTime)
	else
		base.timer.setFunctionTime(self.tabSheetBarFuncRef, disappearTime)
	end
end

local function closeTabSheetBar(self)
	self.tabSheetBar:getContainer():setVisible(false)
	if self.tabSheetBarFuncRef ~= nil then
		base.timer.removeFunction(self.tabSheetBarFuncRef)
		self.tabSheetBarFuncRef = nil
	end
end

local function updateVisible_(self)
--print('self.commonCommandMenuIt.element_:isLogEmpty() = '..tostring(self.commonCommandMenuIt.element_:isLogEmpty()))
--[[
	self.window:setVisible(	self.dialogsList:get_size() > 1 or
							self.commonCommandMenuIt.element_:isMenuVisible() or
							not self.commonCommandMenuIt.element_:isLogEmpty())
--]]
end

--public:

function new(self, menus, rootItem, dialogsData)
	local newCommandDialogsPanel = {}
	setmetatable(newCommandDialogsPanel, self)
	if dialogsData_ then
		newCommandDialogsPanel:initialize(menus, rootItem, dialogsData, self)
	end
	return newCommandDialogsPanel
end

function initialize(self, menus, rootItem, dialogsData, parent)
	
	--print('CommandDialogsPanel.initialize()')
	local heightMenu = 0    
	local menuWidth = CommandMenu.getMenuWidth()
	--UI
	do
		local screenWidth, screenHeight = Gui.GetWindowSize()	
		local height = CommandMenu.getMenuHeight()
		local window = DialogLoader.spawnDialogFromFile('Scripts/UI/RadioCommandDialogPanel/CommandDialogsPanel.dlg')
		window:setBounds(screenWidth - menuWidth, 0, menuWidth, height)
		self.window = window
		
		do
			local skin = {
				container = window.container:getSkin(),
				item = window.btnItem:getSkin(), --window.staticItem:getSkin(),
				selectedItem = window.staticItemSelected:getSkin(),
				arrows = window.staticArrow:getSkin(),
				spacing = 10,
                window = window:getSkin(),
			}
			
			local fontScale = CommandMenu.getFontScale()
			local upperBarHeight = 25 * fontScale
			local tabSheetBar = TabSheetBar.new()
			tabSheetBar:setSkin(skin)
			tabSheetBar:setBounds(0, 0, screenWidth - menuWidth, upperBarHeight)
			tabSheetBar:addTab('')
			tabSheetBar:getContainer():setVisible(false)		
			self.tabSheetBar = tabSheetBar
			
			local mainCaption = window.mainCaption
            local mainCaptionSkin = mainCaption:getSkin()
			local fontSize = 15
			
			mainCaptionSkin.skinData.states.released[1].text.fontSize = fontSize
			mainCaption:setSkin(mainCaptionSkin)			
			
			mainCaption:setBounds(0, 0, menuWidth, upperBarHeight)
			self.mainCaption = mainCaption
			
			local container = window.container
           
		    heightMenu = height - upperBarHeight;
		    
			container:setBounds(0, upperBarHeight, menuWidth, height - upperBarHeight)
			self.container = container
		end
	end	
	--print('CommandDialogsPanel.initialize()')
	self.dialogsData = dialogsData
	local commonCommandMenu = CommandMenu:new(menus, rootItem, self.container)
	self.container:insertWidget(commonCommandMenu:getContainer())
	commonCommandMenu.index = 1
	commonCommandMenu:setHandler(self)
	function commonCommandMenu:isAvailable()
		return true
	end
	--openDialog_(self, commonCommandMenu)
	self.dialogsList = list:new()
	self.commonCommandMenuIt = self.dialogsList:push_back(commonCommandMenu)
	self.curDialogIt = self.commonCommandMenuIt
	updateVisible_(self)
	return heightMenu
end

function clear(self)
	for curSenderID, dialogIts in pairs(self.commandDialogIts) do
		for dialogName, dialogIt in pairs(dialogIts) do
			closeDialog_(self, dialogIt.element_)
			dialogsState[dialogIt.element_] = nil
			self.dialogsList:erase(dialogIt)
			self.container:removeWidget(dialogIt.element_:getContainer())
			dialogIt.element_:release()
		end
	end
	closeTabSheetBar(self)
	self.commandDialogIts = {}
	setCurDialogIt_(self, self.commonCommandMenuIt)
	updateVisible_(self)
end

function release(self)
	--print('CommandDialogsPanel.release()')
	self:clear()
	--UI
	self.container:removeWidget(self.commonCommandMenuIt.element_:getContainer())	
	self.commonCommandMenuIt.element_:release()
	self.commonCommandMenuIt = nil
	self.tabSheetBar:destroy()
	self.tabSheetBar = nil
	self.mainCaption = nil
	self.container = nil
	self.window:kill()
	self.window = nil
	
	self.commandDialogIts = {}
	self.dialogsList = nil
	self.curDialogIt = nil
	self.dialogsState = {}

	self.showMenu = false
end

function toggle(self, on)
	self.toggled = on
	self.dialogsState[self.curDialogIt.element_] = nil
	if on then
		openDialog_(self, self.curDialogIt.element_)
	else
		closeDialog_(self, self.curDialogIt.element_)
	end
end

function updateCurrentMenu(self)
	--if self.curDialogIt then
		if self.curDialogIt.element_.receiver and self.curDialogIt.element_.receiver:checkUnit() == nil then
			--base.print('CommanddialogPanel.updateCurrentMenu('..base.tostring(self.curDialogIt.element_.receiver)..')')
			self.curDialogIt.element_:updateCurrentMenu_(self)
		end
	--end
end

function setShowMenu(self, on)
	local menuVisibilityChanged = self.curDialogIt.element_:isMenuVisible() ~= on

	self.showMenu = on
	if on and
		not self.curDialogIt.element_:isAvailable() then
		switchToDialog_(self, getNextDialog_(self))
	end

	self:toggleDialog_(self.curDialogIt.element_, self.dialogsState[self.curDialogIt.element_] or false)

	if menuVisibilityChanged then
		self.curDialogIt.element_:setMainMenu()
	end
	

	updateVisible_(self)
end

function isMenuVisible(self)
	return self.curDialogIt.element_:isMenuVisible()
end

function setMainCaption(self, text)
	self.mainCaption:setText(text)
end

function getDialogFor(self, senderId)
	local dialogName = getDialogNameFor_(self, senderId)
	if dialogName ~= nil then
		return self.commandDialogIts[senderId][dialogName]
	end
end

function switchToDialogFor(self, senderId)
	switchToDialog_(self, self:getDialogFor(senderId))
end

function releaseDialog(self, senderId, dialogName)
	local dialogIt = self.commandDialogIts[senderId][dialogName]
	base.assert(dialogIt ~= nil)
	
	do
		self.tabSheetBar:removeTab(dialogIt.element_.index)
		if self.tabSheetBar:getTabCount() < 2 then
			closeTabSheetBar(self)
		end
		local nextDialogIt = dialogIt.next_
		while nextDialogIt ~= nil do
			nextDialogIt.element_.index = nextDialogIt.element_.index - 1
			nextDialogIt = nextDialogIt.next_
		end
	end

	local nextDialogIt = self.curDialogIt	
	closeDialog_(self, dialogIt.element_)
	self.container:removeWidget(dialogIt.element_:getContainer())
	dialogIt.element_:release()
	if dialogIt == self.curDialogIt then
		nextDialogIt = getNextDialog_(self)
		self.curDialogIt = nil
		self.showMenu = false
	end
	self.dialogsList:erase(dialogIt)
	self.commandDialogIts[senderId][dialogName] = nil
	if nextDialogIt ~= self.curDialogIt then
		switchToDialog_(self, nextDialogIt)
	end
	updateVisible_(self)
end

function closeSenderDialogs(self, senderId)
	local dialogName = getDialogNameFor_(self, senderId)
	while dialogName ~= nil do
		self:releaseDialog(senderId, dialogName)
		dialogName = getDialogNameFor_(self, senderId)
	end
end

innerFsms = {}

function addFsm(self, senderId, name, data)
	innerFsms[senderId] = innerFsms[senderId] or {}
	local handler = {
		handle = function(recepient, symbol)
			--print('commandDialogsPanel:onEvent() from '..name)
			recepient.commandDialogsPanel:onEvent(symbol, senderId)
		end,
		commandDialogsPanel = self
	}
	innerFsms[senderId][name] = innerFsms[senderId][name] or fsm:new(data, handler.handle, handler, name)
	table.insert(innerFsms, newFsm)
end

--public:

DialogStartTrigger = {
	new = function(self, commandDialogsPanelIn, dialogIn)
		local newTrigger = {}
		newTrigger.commandDialogsPanel = commandDialogsPanelIn
		newTrigger.dialog = dialogIn
		self.__index = self
		setmetatable(newTrigger, self)
		return newTrigger
	end,
	run = function(self, senderId)
		--base.print('start dialog '..self.dialog.name)
		self.commandDialogsPanel:openDialog(self.dialog, senderId, nil)
	end
}

StartFSMTrigger = {
	new = function(self, commandDialogsPanelIn, fsmNameIn, fsmDataIn)
		local newTrigger = {}
		newTrigger.commandDialogsPanel = commandDialogsPanelIn
		newTrigger.fsmName = fsmNameIn
		newTrigger.fsmData = fsmDataIn
		self.__index = self
		setmetatable(newTrigger, self)	
		return newTrigger
	end,
	run = function(self, senderId)
		--print('start fsm '..self.fsmName..' for sender '..tostring(senderId))
		self.commandDialogsPanel:addFsm(senderId, self.fsmName, self.fsmData)
	end
}

--Handles events to open/close Command Dialogs
function onEvent(self, event, senderId, receiverId, receiverAsRecepient)
	--print('event = '..tostring(event))
	--print('senderId = '..tostring(senderId))
	local trigger = self.dialogsData.triggers[event]
	if trigger then
		trigger:run(receiverAsRecepient and receiverId or senderId)
	end
	local dialogToSwitchTo = nil
	local dialogsToRelease = {}
	for recepientId, dialogs in pairs(self.commandDialogIts) do
		if senderId == recepientId or receiverId == recepientId then
			for dialogName, dialogIt in pairs(dialogs) do
				--print('dialog['..tostring(recepientId)..']['..tostring(dialogName)..']:onEvent('..tostring(event)..')')
				--print('dialog.dialogFsm.state='..dialogIt.element_.dialogFsm.state)
				local result = dialogIt.element_:onEvent(event)
				--print('dialog.dialogFsm.state='..dialogIt.element_.dialogFsm.state)
				if result == CommandDialog.OnEventResult.MENU_CHANGED then
					--print('result == CommandDialog.OnEventResult.MENU_CHANGED')
					--print('onEvent '..tostring(event))
					if 	dialogToSwitchTo == nil and
						dialogIt.element_:isAvailable() then
						dialogToSwitchTo = dialogIt
					end
				elseif result == CommandDialog.OnEventResult.FINISHED then
					--print('result == CommandDialog.OnEventResult.FINISHED')
					--dialog
					table.insert(dialogsToRelease, { recepientId = recepientId, dialogName = dialogName })
					--self:releaseDialog(recepientId, dialogName)
				end
			end
		end
	end
	for dialogToReleaseIndex, dialogToRelease in pairs(dialogsToRelease) do
		self:releaseDialog(dialogToRelease.recepientId, dialogToRelease.dialogName)
	end
	if dialogToSwitchTo ~= nil then
		switchToDialog_(self, dialogToSwitchTo)
	end
	for senderId, senderFsms in pairs(self.innerFsms) do
		for theFsmName, theFsm in pairs(senderFsms) do
			--print('fsm '..theFsmName..' on event '..tostring(event))
			theFsm:onSymbol(event)
		end
	end
end

function openDialog(self, dialog, senderId, action, color)

	-- ATC return nil for communicator if is no towers on the field
	if not senderId then 
		return nil
	end

	if 	self.commandDialogIts[senderId] and 
		self.commandDialogIts[senderId][dialog.name] then
		--print('openDialog exist '..dialog.name)
		--return self.commandDialogIts[senderId][dialog.name]
		return nil
	else
		self.commandDialogIts[senderId] = self.commandDialogIts[senderId] or {}
		--dialog
		local senderName = self.getSenderName(senderId)
		local dialogCaption = (senderName ~= nil and senderName..'. ' or '')..dialog.name
		local newDialog = CommandDialog:new(dialogCaption, dialog, action, {[1] = senderId}, color, self.container, self.commonCommandMenuIt)
		self.container:insertWidget(newDialog:getContainer())
		newDialog.index = self.dialogsList:get_size() + 1
		newDialog:setHandler(self)				
		self.commandDialogIts[senderId][dialog.name] = self.dialogsList:push_back(newDialog)
		self.tabSheetBar:addTab(dialog.name)
		if self.tabSheetBar:getTabCount() > 1 then
			showTabSheetBar(self)
		end
		updateVisible_(self)
		--print('openDialog created '..dialog.name)
		return newDialog
	end
end

function switchToMainMenu(self)
	if self.tabSheetBar:getTabCount() > 1 then
		showTabSheetBar(self)
	end
	switchToDialog_(self, self.commonCommandMenuIt)
end

function switchToNextDialog(self)
	local wasVisible = self.tabSheetBar:getContainer():isVisible()
	if self.tabSheetBar:getTabCount() > 1 then
		showTabSheetBar(self)
	end
	if wasVisible then
		switchToDialog_(self, getNextDialog_(self))
	end
end

function selectMenuItem(self, num)
	self.curDialogIt.element_:selectMenuItem(num)
end

function onDialogsMsgStart_(self, objectId, msg, color)
	local dialogItToSwitch = nil
	if objectId ~= nil then
		local dialogIts = self.commandDialogIts[objectId]
		if dialogIts then
			for dialogName, dialogIt in pairs(dialogIts) do
				if dialogItToSwitch == nil then
					dialogItToSwitch = dialogIt
				end
			end
		end
	end
	return dialogItToSwitch
end

function onDialogsMsgFinish_(self, objectId, msg)
	local dialogItToSwitch = nil
	if objectId ~= nil then
		local dialogIts = self.commandDialogIts[objectId]
		if dialogIts then
			for dialogName, dialogIt in pairs(dialogIts) do
				if dialogItToSwitch == nil then
					dialogItToSwitch = dialogIt
				end
			end
		end
	end
	return dialogItToSwitch
end

function onMsgStart(self, senderId, receiverId, msg, color)
	local dialogItToSwitch = 	self:onDialogsMsgStart_(senderId, msg, color) or
								self:onDialogsMsgStart_(receiverId, msg, color) or
								self.commonCommandMenuIt
	if 	not self.tabSheetBar:getContainer():isVisible() or
		dialogItToSwitch.element_ ~= self.commonCommandMenuIt.element_ then
		switchToDialog_(self, dialogItToSwitch)
	end
	updateVisible_(self)
end

function onMsgFinish(self, senderId, receiverId, msg)
	self:onDialogsMsgFinish_(senderId, msg)
	self:onDialogsMsgFinish_(receiverId, msg)
end

--CommandMenus & CommandDialogs events handlers

function onDialogSetCaption(self, dialog, caption)
	self.tabSheetBar:setTabText(dialog.index, caption)
end

function onDialogToggle(self, dialog, on)
end

function onDialogCommand(self, dialog)
end

function onCommandMenuEmpty(self, menu)
	updateVisible_(self)
end

function switchToDialog(self, dialog)
	switchToDialog_(self, self.commonCommandMenuIt)
end