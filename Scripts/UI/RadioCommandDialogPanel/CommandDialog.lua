--Dynamic Command Menu + message log used in dialogs.
--Menu content is depended on dialog stage. 
--Command Dialog is organized as fsm (self.dialogFsm).

local base = _G

module('CommandDialog')

__index = base.getfenv()

local gettext = base.require("i_18n")
local _ = gettext.translate

local CommandMenu = base.require('CommandMenu')
local fsm = base.require('fsm')
local utils = base.require('utils')

ON_PARENT_MENU = 13

base.setmetatable(base.getfenv(), CommandMenu)

menusFsmData = {}

function new(self, caption, data, action, parameters, color, parent, parentMenu)
	local newCommandDialog = {}
	base.setmetatable(newCommandDialog, self)	
	--self.__index = self
	newCommandDialog:init(caption, data, action, parameters, color, parent, parentMenu)
	return newCommandDialog
end

function makeDialogTermination()
	return { finish = true }
end

function makeStageTransition(menu, newStage, pushToStack)
	return { 	menu 		= menu,
				newStage	= newStage,
				pushToStack = pushToStack }
end

function makeStageReturn(to)
	return { returnTo = to or 1}
end

function init(self, caption, data, action, parameters, color, parent, parentMenu)
	--command menu
	self.parentMenu = parentMenu
	local container = CommandMenu.init(self, nil, nil, parent)
	self.caption = caption
	--action before each command
	self.action = action
	--constant parameters for all commands
	self.parameters = parameters
	self.color = color
	--dialog fsm	
	self.dialogFsmData = {}
	self.dialogFsmData.init_state = 'Closed'

	self.dialogFsmData.transitions = {}
	self.dialogFsmData.on_state_enter = {}
	for stage, menu in base.pairs(data.menus) do
		self.dialogFsmData.on_state_enter[stage] = function()
			self:buildStageMenu_(data, { name = menu.name, submenu = menu })
		end
	end
	for oldStage, transitions in base.pairs(data.stages) do
		self.dialogFsmData.transitions[oldStage] = {}
		for event, action in base.pairs(transitions) do
			if 	action.menu then
				local stackOption = nil
				if action.pushToStack then
					stackOption = fsm.PUSH_TO_STACK
				end			
				self.dialogFsmData.transitions[oldStage][event] = {
					outSymbol = nil,
					newState = action.newStage,
					stackOption = stackOption
				}
			elseif 	action.finish then
				self.dialogFsmData.transitions[oldStage][event] = {
					outSymbol = function(self)
						self.lastAction = self.OnEventResult.FINISHED
					end,
					newState = 'Closed'
				}
			elseif action.returnTo then
				self.dialogFsmData.transitions[oldStage][event] = {
					outSymbol = nil,
					newState = 'Closed',
					stackOption = fsm.POP_FROM_STACK,
					stackDepth = action.returnTo
				}
			else
				self.dialogFsmData.transitions[oldStage][event] = {
					outSymbol = nil,
					newState = nil
				}
			end
		end
	end	
	self.dialogFsm = fsm:new(self.dialogFsmData, self.onDialogFsmSymbol, self, 'dialog')
	return container
end

OnEventResult = {
	NONE			= 1,
	MENU_CHANGED	= 2,
	FINISHED		= 3
}

function buildStageMenu_(self, data, menu)
	--base.print('new menu '..menu.name)
	local newMenuFsmData = self.menusFsmData[menu]
	if newMenuFsmData then
		self.mainMenu = menu
	else
		newMenuFsmData = {}
		self:buildFsmData(newMenuFsmData, data.menus, menu)
		self.menusFsmData[menu] = newMenuFsmData
	end
	if self.fsm then
		self.fsm.data = newMenuFsmData
		self.fsm:reset()
	else
		--base.print('new fsm for '..menu.name)
		self.fsm = fsm:new(newMenuFsmData, self.onSymbol, self, 'menu '..menu.name)
	end
	self.lastAction = self.OnEventResult.MENU_CHANGED
	--base.print('before self:setMainMenu()')
	self:setMainMenu()
	--base.print('after self:setMainMenu()')
end

function buildMenu_(self, menu)
	CommandMenu.buildMenu_(self, menu)
	self.commandMenu:setItem(11, _('F11. Parent Menu'), '0xffffffff')
	self.menuItemCommands[11] = ON_PARENT_MENU
end

function buildMenuFsm_(self, transitions, item_name, submenu)	
	CommandMenu.buildMenuFsm_(self, transitions, item_name, submenu)
	transitions[item_name][ON_PARENT_MENU] = {
		outSymbol = function(self)
			if self.handler and
				self.handler.switchToDialog	then
				self.handler:switchToDialog(self.parentMenu)
			end
		end,
		newState = nil
	}
end

function release(self)
	CommandMenu.release(self)
	self.dialogFsm:reset()
end

--The command has been chosen: collect parameters an call the command
function onCommand(self, command, parameters)
	if self.action then
		self.action()
	end
	if self.parameters then
		for parIndex, parameter in base.pairs(self.parameters) do
			base.table.insert(parameters, parameter)
		end
	end
	CommandMenu.onCommand(self, command, parameters)
end

--The event that may change the dialog stage
function onEvent(self, event)
	self.lastAction = self.OnEventResult.NONE
	self.dialogFsm:onSymbol(event)
	return self.lastAction
end

function onDialogFsmSymbol(self, outputSymbol)
	if outputSymbol then
		outputSymbol(self)
	end
end