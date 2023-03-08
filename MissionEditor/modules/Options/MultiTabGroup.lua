local DialogLoader		= require('DialogLoader')
local Factory			= require('Factory')
local TabGroupItem		= require('TabGroupItem')

local function getResourceFilename(self)
	return './MissionEditor/modules/dialogs/me_plugin_tabs.dlg'
end

local function loadFromResource(self)
	local window = DialogLoader.spawnDialogFromFile(self:getResourceFilename())
	local container = window.panelTabsAndButtons
	
	self.tabSkin_ = window.tabGroupItem:getSkin()
	self.tabsContainer_ = container.panelTabs
	self.buttonPrev_ = container.buttonPrev
	self.buttonNext_ = container.buttonNext
	
	window:removeWidget(container)
	window:kill()
	
	self.container_ = container
end

local function updateVisibleTabs(self)
	local tabsContainer = self.tabsContainer_
	local buttonPrev = self.buttonPrev_
	local buttonNext = self.buttonNext_
	local tabGroupItems = self.tabGroupItems_
	local buttonPrevX, buttonPrevY = buttonPrev:getPosition()
	
	tabsContainer:removeAllWidgets()
	buttonPrev:setEnabled(self.tabOffset_ > 0)
	buttonNext:setEnabled(false)
	
	for i = 1 + self.tabOffset_, #tabGroupItems do
		local tabGroupItem = tabGroupItems[i]
		
		tabsContainer:insertWidget(tabGroupItem)
		tabsContainer:getLayout():updateSize()
		
		local x, y, w, h = tabGroupItem:getBounds()
		
		if x + w > buttonPrevX then
			tabsContainer:removeWidget(tabGroupItem)
			buttonNext:setEnabled(true)
			
			break
		end
	end
end

local function construct(self, plugins)
	self.tabOffset_ = 0
	self.tabGroupItems_ = {}
	loadFromResource(self)
	
	local multiTabGroup = self
	
	function self.buttonPrev_:onChange()
		if multiTabGroup.tabOffset_ > 0 then
			multiTabGroup.tabOffset_ = multiTabGroup.tabOffset_ - 1
			updateVisibleTabs(multiTabGroup)
		end
	end
	
	function self.buttonNext_:onChange()
		multiTabGroup.tabOffset_ = multiTabGroup.tabOffset_ + 1
		updateVisibleTabs(multiTabGroup)
	end	
end

local function getContainer(self)
	return self.container_
end

local function setBounds(self, x, y, w, h)
	self:setPosition(x, y)
	self:setSize(w, h)
end

local function setPosition(self, x, y)
	self.container_:setPosition(x, y)
end

local function setSize(self, w, h)
	self.container_:setSize(w, h)
	updateVisibleTabs(self)
end

-- для единообразия с api остального gui индексы начинаются с 0
local function insertTab(self, text, skin, index)
	local id = self.tabIdCounter_
	local tabGroupItem = TabGroupItem.new(text)
	
	tabGroupItem:setSkin(skin or self.tabSkin_)
	
	local multiTabGroup = self
	
	function tabGroupItem:onShow()
		multiTabGroup:onShowTab(self)
		
		for i, item in ipairs(multiTabGroup.tabGroupItems_) do
			if item:getState() and item ~= self then
				item:setState(false)
				item:onHide()
			end
		end
	end

	function tabGroupItem:onHide()
		multiTabGroup:onHideTab(self)
	end
	
	if index then
		table.insert(self.tabGroupItems_, index + 1, tabGroupItem)
	else
		table.insert(self.tabGroupItems_, tabGroupItem)
	end
	
	updateVisibleTabs(self)
	
	return tabGroupItem
end

-- для единообразия с api остального gui индексы начинаются с 0
local function removeTab(self, index)
	table.remove(self.tabGroupItems_, index + 1)
	
	if self.tabOffset_ > 0 and index <= self.tabOffset_ then
		-- удаляем закладку перед первой видимой закладкой
		self.tabOffset_ = self.tabOffset_ - 1
	end	
	
	updateVisibleTabs(self)
end

-- для единообразия с api остального gui индексы начинаются с 0
local function getTab(self, index)
	return self.tabGroupItems_[index + 1]
end

local function getTabCount(self)
	return #self.tabGroupItems_
end

local function clear(self)
	self.tabsContainer_:removeAllWidgets()
	self.tabOffset_ = 0
	
	for i, tabGroupItem in ipairs(self.tabGroupItems_) do
		tabGroupItem:destroy()
	end
	
	self.tabGroupItems_ = {}
end

local function getTab(self, index)
	return self.tabGroupItems_[index + 1]
end

local function getSelectedTab(self)
	for i, item in ipairs(self.tabGroupItems_) do
		if item:getState() then
			return item
		end
	end
end

local function onShowTab(tab)
end

local function onHideTab(tab)
end

return Factory.createClass({
	construct 				= construct,
	getResourceFilename		= getResourceFilename,
	getContainer			= getContainer,
	setBounds				= setBounds,
	setPosition				= setPosition,
	setSize					= setSize,
	insertTab				= insertTab,
	removeTab				= removeTab,
	getTabCount				= getTabCount,
	clear					= clear,
	getTab					= getTab,
	getSelectedTab			= getSelectedTab,
	onShowTab				= onShowTab,
	onHideTab				= onHideTab,
})