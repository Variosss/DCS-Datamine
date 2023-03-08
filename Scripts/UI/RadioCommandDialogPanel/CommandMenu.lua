--Command menu and message log.
--Menu navigation is based on fsm:
--  state: current menu
--  input symbol: chosen command of current menu
--  output symbol: building new menu
--Menu item types: command, menus and menu building functions.
--Commands are represented as functors. Path to the command stores parameters to the command. When
--the command is chosen CommandMenu collects parameters from the path and passes them to the command.
--Item #11 - Back.
--Item #12 - Exit.
--Messages in the log have life time.

local base = _G

module('CommandMenu')

__index = base.getfenv()

local require 		= base.require
local fsm			= require('fsm')
local utils			= require('utils')

local gettext		= require('i_18n')
local _				= gettext.translate

local Gui           = require('dxgui')
local Static        = require('Static')
local Window        = require('Window')
local StaticList    = require('StaticList')
local StaticMenu    = require('StaticMenu')
local Panel         = require('Panel')
local Skin          = require('Skin')
local Size          = require('Size')
local DCS    		= require('DCS')
local HMD           = base.HMD

ON_OPEN = 0
ON_CLOSE = -1
ON_HOME = -2

ON_PREVIOUS = 11
ON_EXIT = 12


function getFontScale()
	local fontScale = DCS.getUserOptions().graphics.messagesFontScale or 1
	
	if HMD.isActive() then
		fontScale = fontScale * 1.75
	end
	
	return fontScale
end

function getMenuWidth()
	local fontScale = getFontScale()
	
	return 280 * fontScale
end

function getMenuHeight()
	local fontScale = getFontScale()
	
	return 400 * fontScale
end

function eventCallback(ptr, event, ...)
	local self = list[ptr]
	local handler = handlers[event]
	handler(self, ...)
end

function new(self, data, rootItem, width, height)
	local newCommandMenu = {}
	base.setmetatable(newCommandMenu, self)	
	self.__index = self
	newCommandMenu:init(data, rootItem, width, height)
	return newCommandMenu
end

function init(self, data, rootItem, parent)
	local fontScale = getFontScale()	
	local fontSize			= 12 * fontScale
	local fontSizeCaption	= 15 * fontScale
	local menuCaptionHeight	= 20 * fontScale
	
	local menuWidth = getMenuWidth()
		
	self.level = 0 --Current menu level
	self.path = {} --Current menu path
	self.removeMessageActions = {}
	self.funcRef = nil
	self.tableCB = nil
	
	local x, y, width, height = parent:getBounds()
	
	local containerSkin = {}
	local container = Panel.new('CommandMenu.container')
	do
		container:setSkin(containerSkin)
		container:setBounds(0, 0, width, height)
		self.container = container
	end
	
	local font = 'DejaVuLGCSansMono.ttf'
	local textSkin = Skin.staticSkin()
	textSkin.skinData.params.textWrapping = true
	
	local skinText = textSkin.skinData.states.released[1].text
	
	skinText.font = font
	skinText.fontSize = fontSize
	skinText.color = '0xffffffff'
	skinText.shadowColor = '0x000000ff'
	skinText.shadowOffset = Size.new(1, 1)

	do
		local menuPanel = Panel.new('CommandMenu.menuPanel')
		menuPanel:setSkin(containerSkin)
		local w = width - menuWidth
		menuPanel:setBounds(w, 0, menuWidth, height)
		container:insertWidget(menuPanel)
		self.menuPanel = menuPanel
		
		do
			local menuCaption = Static.new('CommandMenu.menuCaption')
			menuCaption:setSkin(textSkin)
			local menuCaptionSkin = menuCaption:getSkin()
			local skinText = menuCaptionSkin.skinData.states.released[1].text
			
			skinText.fontSize = fontSizeCaption
			skinText.color = '0xffffffff'
			skinText.shadowColor = '0x000000ff'
			skinText.shadowOffset = Size.new(1, 1)
			
			menuCaption:setSkin(menuCaptionSkin)
			menuCaption:setBounds(0, 0, menuWidth, menuCaptionHeight)
			menuPanel:insertWidget(menuCaption)
			self.menuCaption = menuCaption
		end
		
		do
			local additionalStatic = Static.new('')
			additionalStatic:setSkin(textSkin)
			local AdiditionalMenuSkin = additionalStatic:getSkin()
			local skinText = AdiditionalMenuSkin.skinData.states.released[1].text
			
			skinText.fontSize = fontSizeCaption
			skinText.color = '0xffffffff'
			skinText.shadowColor = '0x000000ff'
			skinText.shadowOffset = Size.new(1, 1)
			
			additionalStatic:setSkin(AdiditionalMenuSkin)
			additionalStatic:setBounds(0, 200, menuWidth, menuCaptionHeight)
			self.menuPanel:insertWidget(additionalStatic)
			self.additionalStatic = additionalStatic
			additionalStatic:setVisible(false)
			
			self.additionalStaticSetText = function(text)
				self.additionalStatic:setText(text)
		
				local count = self.commandMenu.staticList:getItemCount()
				local y = self.commandMenu.staticList:getItemsHeight(count)
			
				local w, h = self.additionalStatic:calcSize()
				local wCap, hCap = self.menuCaption:calcSize()		
			
				self.additionalStatic:setBounds(0, y + hCap*2, w, h)
				
				self.additionalStatic:setVisible(true)
			end
			
			self.additionalStaticHide = function()		
				self.additionalStatic:setVisible(false)
			end
			
			self.additionalStaticUpdatePosition = function()		
				local count = self.commandMenu.staticList:getItemCount()
				local y = self.commandMenu.staticList:getItemsHeight(count)
			
				local w, h = self.additionalStatic:calcSize()
				local wCap, hCap = self.menuCaption:calcSize()		
			
				self.additionalStatic:setBounds(0, y + hCap*2, w, h)
			end
		end
		
		do
			local menuHeight = height - menuCaptionHeight
			local skin = {
				container = containerSkin,
				item = textSkin
			}
			local commandMenu = StaticMenu.new('CommandMenu.commandMenu', 0, menuCaptionHeight, menuWidth, menuHeight, 12, skin, self)
			menuPanel:insertWidget(commandMenu:getContainer())
			self.commandMenu = commandMenu
		end
	end
	self.menuPanel:setVisible(false)
	
	if data then
		self:setData(data, rootItem)
	end
	
	return self.container
end

function setData(self, data, rootItem)
	--self.data = data
	local fsmData = {}
	self.fsmData = fsmData
	self:buildFsmData(fsmData, data, rootItem)
	self.fsm = fsm:new(fsmData, self.onSymbol, self, 'menu')
end

function buildFsmData(self, fsmData, data, rootItem)
	--base.print('CommandDialog.buildFsmData()'..base.tostring(rootItem))
	self.fsmData = fsmData
	self.rootItem = rootItem
	local mainMenu = rootItem.submenu or rootItem:getSubmenu()
	fsmData.init_state = 'Closed'
	fsmData.transitions = {
		['Closed'] = {
			[ON_OPEN] = {
				outSymbol = function(self)	
					self:clearMenu()
					--base.print('buildFsmData ON_OPEN')
					self:enterMenu_(rootItem)
				end,
				newState = mainMenu.name,
				stackOption = fsm.PUSH_TO_STACK
			},
		}
	}
	fsmData.initStateFreeTransitions = {
		[ON_HOME] = {
			outSymbol = function(self)
				self:clearMenu()
				--base.print('buildFsmData ON_HOME')
				self:enterMenu_(rootItem)
			end,
			newState = mainMenu.name,
			stackOption = fsm.PUSH_TO_STACK,
		},
		[ON_CLOSE] = {
			outSymbol = self.closeMenu_,
			newState = 'Closed'
		},
	}
	if self.rootItem.submenu ~= nil then
		self:buildMenuFsm_(fsmData.transitions, self.rootItem.name, self.rootItem.submenu)
	end
end

function buildMenuFsm_(self, transitions, item_name, submenu)
	
	transitions[item_name] = {}
	local nCount = #submenu.items
	for item_index, item in base.pairs(submenu.items) do
		if item.submenu then--есть подменю - строю подменю
			transitions[item_name][item_index] =
			{
				outSymbol = function(self)
					self:enterMenu_(item)
				end,
				newState = item_name..'.'..item.name,
				stackOption = fsm.PUSH_TO_STACK
			}
			self:buildMenuFsm_(transitions, item_name..'.'..item.name, item.submenu)
		elseif item.getSubmenu then
			transitions[item_name][item_index] =
			{
				outSymbol = function(self)
					local submenu = item:getSubmenu()
					self:buildMenuFsm_(transitions, item_name..'.'..item.name, submenu)
					self:enterMenu_(item)
				end,
				newState = item_name..'.'..item.name,
				stackOption = fsm.PUSH_TO_STACK
			}
		else
			transitions[item_name][item_index] =
			{
				outSymbol = function(self)
					self:selectCommand_(item)
				end,
				newState = 'Closed'
			}
		end			
	end

	transitions[item_name][ON_PREVIOUS] = {
		outSymbol = function(self)
			self:popMenuItem_()
			local top = self.path[#self.path]
			if top.submenu then
				--base.print('popMenuItem_() '..top.submenu.name)
				self:buildMenu_(top.submenu)
			elseif top.getSubmenu then
				local submenu = top:getSubmenu()
				self:buildMenuFsm_(transitions, top.name, submenu)
				self:buildMenu_(submenu)
			end
		end,
		newState = nil,
		stackOption = fsm.POP_FROM_STACK
	}
	
	transitions[item_name][ON_EXIT] = {
		outSymbol = self.closeMenu_,
		newState = 'Closed',
		stackOption = fsm.CLEAR_STACK
	}
end

function buildMenuFsm(self, menu_item)
	self:buildMenuFsm_(self.fsmData.transitions, menu_item)
end

function setHandler(self, handler)
	self.handler = handler
end

function release(self)
	--base.print('release')
	fsm:reset()
	
	if self.funcRef ~= nil then
		base.timer.removeFunction(self.funcRef)
		self.funcRef = nil
	end
	
	base.assert(self.container ~= nil)
	self.container:destroy()
	self.container = nil
		self.menuPanel = nil
			self.menuCaption = nil
			self.commandMenu = nil
end

local function onMenuShowHide(self, prev, cur)
	--base.print('onMenuShoHide '..base.tostring(cur))
	if self.handler then
		if not prev and cur then
			self.handler:onMenuShow(self)
		elseif prev and not cur then
			self.handler:onMenuHide(self)
		end
	end
end

function toggle(self, on)
	--base.print('toggle('..base.tostring(on)..')')
	onMenuShowHide(self, self:isMenuVisible(), on and self.menuPanel:isVisible())
	self.container:setVisible(on)
	return self.container:isVisible()
end

function toggleMenu(self, on)
	--base.print('toggleMenu('..base.tostring(on)..')')
	onMenuShowHide(self, self:isMenuVisible(), self.container:isVisible() and on)
	self.menuPanel:setVisible(on)
	return self.menuPanel:isVisible()
end

function isMenuVisible(self)
	--base.print('isVisible()')
	return self.container:getVisible() and self.menuPanel:isVisible()
end

function pushMenuItem_(self, menu_item)
	--base.print('pushMenuItem_')
	base.table.insert(self.path, menu_item)
	self.receiver = menu_item.receiver
	self.level = self.level + 1
end

function popMenuItem_(self)
	--base.print('popMenuItem_')
	local top = self.path[#self.path]
	base.table.remove(self.path)
	self.receiver = nil
	self.level = self.level - 1
	return top
end

function getItemColor(self, item)
	--base.print('item.name = '..item.name)
	--base.print('item.color = '..base.tostring(item.color))
	if item.color then
		return item.color:get()
	else
		for index = #self.path, 1, -1 do
			local parentColor = self.path[index].color
			if parentColor ~= nil then
				return parentColor:get()
			end
		end
		return nil
	end
end

function makeGuiColor(color)
	return base.string.format('0x%xff', color)
end

function buildMenu_(self, menu)
	self.menu = menu
	
	local fullCaption = self.caption ~= nil and self.caption..'. ' or ''	
	if self.level > 1 then
		fullCaption = fullCaption..base.tostring(self.level)..'. '
	end
	for submenu_index, submenu_item in base.pairs(self.path) do
		if submenu_index > 1 then
			fullCaption = fullCaption..'. '..submenu_item.name
		else
			fullCaption = fullCaption..submenu_item.name
		end
	end
	self:setCaption(fullCaption)
	
	self.commandMenu:clear()	
	self.menuItemCommands = {}
	local count = #menu.items
	--base.print('menu name:'..menu.name)
	--base.print('count items:'..base.tostring(count))
	for index, item in base.pairs(menu.items) do
		--base.print('item.name = '..item.name)
		if item.condition == nil or item.condition:check() then
			local item_name = item.name
			if item.submenu or item.getSubmenu then
				item_name = item_name..'...'
			else
				--item_name = item_name..'.'
			end
			
			if item.isDialogOpened ~= nil and item.isDialogOpened() then
				item_name = item_name..'>>'
			end
			
			local color = self:getItemColor(item) or (menu.color and menu.color:get()) or (self.color and self.color:get()) or utils.COLOR.WHITE
			self.commandMenu:setItem(index, 'F'..index..'. '..item_name, makeGuiColor(color))
			self.menuItemCommands[index] = index
		end
	end	
	if self.level > 1 then
		self.commandMenu:setItem(11, _('F11. Previous Menu'), '0xffffffff')
		self.menuItemCommands[11] = ON_PREVIOUS
	end
	self.commandMenu:setItem(12, _('F12. Exit'), '0xffffffff')
	self.menuItemCommands[12] = ON_EXIT
		
end

function enterMenu_(self, menuItem)
	--base.print('enterMenu_'..base.tostring(menuItem)..menuItem.name)
	self:pushMenuItem_(menuItem)
	self:buildMenu_(menuItem.submenu or menuItem:getSubmenu())
	if menuItem.onEnterMenu then
		if self.tableCB then
			self.tableCB.onLeaveMenu(self)
		end
		local x,y,z,w = self.menuPanel:getBounds()
		menuItem.onEnterMenu(menuItem, self)
		self.tableCB = menuItem
	else
		if self.tableCB then
			self.tableCB.onLeaveMenu(self)
			self.tableCB = nil
		end
	end
end

function setMainMenu(self)
	--base.print('setMainMenu')
	if self.rootItem ~= nil and self.rootItem.getSubmenu ~= nil then
		self:buildMenuFsm_(self.fsmData.transitions, self.rootItem.name, self.rootItem:getSubmenu())
	end
	
	if self.fsm ~= nil then
		self.fsm:onSymbol(ON_HOME)
	end
	--base.print('mainMenu.name = '..base.tostring(self.rootItem.name))
	--base.print('fsm.state = '..base.tostring(self.fsm.state))
end

local function findMenuItemByName(menu, name)
	for menuItemIndex, menuItem in base.pairs(menu.items) do
		if menuItem.name == name then
			return menuItem
		end
	end
	return nil
end

function updateCurrentMenu_(self)
	--base.print('updateCurrentMenu_: self.menu = '..base.tostring(self.menu)..') rootItem = '..base.tostring(self.rootItem))
	self:buildMenu_(self.menu)
end

function updateMenu(self)
	--base.print('updateMenu')
	if self.rootItem.getSubmenu ~= nil then
		self:buildMenuFsm_(self.fsmData.transitions, self.rootItem.name, self.rootItem:getSubmenu())
	end
	
	local oldPath = self.path	
	self.path = {}
	--Restoring menu
	local menuItem = self.rootItem
	for oldItemIndex, oldItem in base.pairs(oldPath) do
		if oldItemIndex > 1 then
			menuItem = findMenuItemByName(menuItem.submenu or menuItem:getSubmenu(), oldItem.name)
		end	
		if menuItem ~= nil then
			base.table.insert(self.path, menuItem)
			if menuItem.submenu == nil then
				if menuItem.getSubmenu ~= nil then
					self.menu = menuItem:getSubmenu()
				end
			else
				self.menu = menuItem.submenu
			end
			fsm.state = menuItem.name
		else
			break
		end
	end
	
	self:buildMenu_(self.menu)
end

function selectCommand_(self, menu_item)
	--base.print('selectCommand_ '..base.tostring(menu_item))
	base.table.insert(self.path, menu_item)
	self.level = self.level + 1
	self:performCommands()
end

function selectMenuItem(self, menu_item_num)
	--base.print('CommandMenu.selectMenuItem('..base.tostring(menu_item_num)..')')
	if self.menuItemCommands then
		local inputSymbol = self.menuItemCommands[menu_item_num]
		
		--base.print('inputSymbol = '..base.tostring(inputSymbol))
		--base.print('before: fsm.state = '..base.tostring(self.fsm.state))
		if inputSymbol then
			self.fsm:onSymbol(inputSymbol)
		end
	end
	--base.print('selectMenuItem will see self.handler')
	if 	self.handler then 
		--base.print('self.handler exist')
		if 	self.handler.onDialogMenuItem then
			--base.print('onDialogMenuItem')		
			self.handler:onDialogMenuItem(menu_item_num)
		end
	end
	if self.tableCB and self.tableCB.marker and self.menu.marker and self.tableCB.marker ~= self.menu.marker then
		self.tableCB.onLeaveMenu(self)
		self.tableCB = nil
	else
		if self.tableCB and self.tableCB.updatePosition then
			self.tableCB.updatePosition(self)
		end
	end
	--base.print('after: fsm.state = '..base.tostring(self.fsm.state))
end

function performCommands(self)
	local parameters = {}
	for path_index, path_item in base.pairs(self.path) do
		if path_item.command then
			self:onCommand(path_item.command, parameters)
			parameters = {}
		end	
		if path_item.parameter then
			base.table.insert(parameters, path_item.parameter)
		elseif path_item.parameters then
			for par_index, par_item in base.pairs(path_item.parameters) do
				base.table.insert(parameters, par_item)
			end
		end
	end
end

function onCommand(self, command, parameters)	
	--base.print('CommandMenu.onCommand()'..base.tostring(command))
	self:closeMenu_()
	if command then
		if 	self.handler and
			self.handler.onDialogCommand then
			self.handler:onDialogCommand(self, command, parameters)
		end
	end
end

function setCaption(self, caption)
	local menuWidth = getMenuWidth()
	
	self.menuCaption:setText(caption)
	
	local captionWidth, captionHeight = self.menuCaption:calcSize()
	
	self.menuCaption:setBounds(0, 0, menuWidth, captionHeight)
	
	local menuWidth, menuHeight = self.commandMenu:getContainer():getSize()
	
	self.commandMenu:getContainer():setBounds(0, captionHeight + 5, menuWidth, menuHeight)
	
	if 	self.handler and
		self.handler.onDialogSetCaption then
		self.handler:onDialogSetCaption(self, caption)
	end
end

function clearMenu(self)
	--base.print('clearMenu')
	self.path = {}
	self.level = 0
	self.commandMenu:clear()
	self:setCaption('')
end

function closeMenu_(self) 
	--base.print('closeMenu count'..base.tostring(#self.path))
	self:setMainMenu()
	self:toggleMenu(false)
    if 	self.handler then 
        self.handler:banMouse(false)
    end
end

local addTimeStamp = false

local function getTimeStr(timeSec)
	return base.string.format('[%02d:%02d:%02d]', utils.getTime(timeSec))
end


--fsm handler
	
function onSymbol(self, outputSymbol)
	if outputSymbol then
		outputSymbol(self)
	end
end

--C++ event handlers

function onMenuItem(self, menu_item_num)
	self:selectMenuItem(menu_item_num)
end

function onMenuToggle(self, on)
	--base.print('CommandMenu.onMenuToggle('..base.tostring(on)..')')
	if self.fsm then
		if on then
			self.fsm:onSymbol(ON_OPEN)
		else
			self.fsm:onSymbol(ON_CLOSE)
		end
	end
	if 	self.handler and
		self.handler.onDialogToggle then
		self.handler:onDialogToggle(on)
	end
	return true
end



function getContainer(self)
	return self.container
end

list = {}

handlers = {
	['onMenuItem'] 		= onMenuItem,
	['onMenuToggle']	= onMenuToggle,
}
