local DialogLoader	= require('DialogLoader')
local Factory		= require('Factory'		)

local function callbackStub(file)
	print('~~~callbackStub', file)
end

local function createSwitchButtonSkin(self, file)
	local states = self.switchButtonSkin.skinData.states

	states.released	[1].picture.file = file
	states.released	[2].picture.file = file
	states.hover	[1].picture.file = file
	states.hover	[2].picture.file = file	
	states.pressed	[1].picture.file = file
	states.pressed	[2].picture.file = file
	
	return self.switchButtonSkin
end

local function construct(self)
	local localization	= {}
	local window		= DialogLoader.spawnDialogFromFile('MissionEditor/modules/dialogs/me_select_icon.dlg', localization)
	
	self.panel			= window.panel
	
	window:removeWidget(window.panel)
	
	self.switchButtonCell = window.panel.switchButtonCell
	window.panel:removeWidget(window.panel.switchButtonCell)
	
	self.switchButtonSkin = self.switchButtonCell:getSkin()
	
	window:kill()
end

local function getPanel(self)
	return self.panel
end

local function setIcons(self, folder, iconInfos)
	local grid	= self.panel.grid
	
	grid:clearRows()
	
	local fileToCell		= {} -- для быстрого поиска ячеек по имени файла
	local switchButtonCell	= self.switchButtonCell
	local columnCount		= grid:getColumnCount()
	local columnCounter		= columnCount
	local rowCounter		= -1
	
	for i, iconInfo in ipairs(iconInfos) do
		-- iconInfo.file - имя иконки, будет передано в калбек
		-- iconInfo.hint - всплывающая подсказка
		if columnCounter == columnCount then
			columnCounter = 0
			rowCounter = rowCounter + 1
			grid:insertRow()
		end
		
		local cell = switchButtonCell:clone()
		
		fileToCell[iconInfo.file] = cell
		
		cell:addChangeCallback(function()
			self.callback(iconInfo.file)
		end)
		
		cell:setSkin(createSwitchButtonSkin(self, folder .. iconInfo.file))
		cell:setTooltipText(iconInfo.hint)
		
		grid:setCell(columnCounter, rowCounter, cell)
		columnCounter = columnCounter + 1
	end
	
	self.fileToCell = fileToCell
end

local function selectIcon(self, file)
	local cell = self.fileToCell[file]
	
	if cell then
		cell:setState(true)
	end
end

local function setCallback(self, callback)
	self.callback = callback or callbackStub
end

return Factory.createClass({
	construct	= construct,
	getPanel	= getPanel,
	setIcons	= setIcons,
	selectIcon	= selectIcon,
	setCallback	= setCallback,
})