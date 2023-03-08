local DialogLoader				= require('DialogLoader')
local ListBoxItem				= require('ListBoxItem')
local GridHeaderCell			= require('GridHeaderCell')
local Static					= require('Static')
local HorzRangeIndicator		= require('HorzRangeIndicator')
local InputUtils				= require('Input.Utils')
local InputData					= require('Input.Data')
local Input						= require('Input')
local textutil					= require('textutil')
local AddComboDialog			= require('Input.AddComboDialog')
local ModifiersDialog			= require('Input.ModifiersDialog')
local AxesTuneDialog			= require('Input.AxesTuneDialog')
local ForceFeedbackTuneDialog	= require('Input.ForceFeedbackTuneDialog')
local MakeLayoutText			= require('Input.MakeLayoutText')
local MsgWindow					= require('MsgWindow')
local FileDialog				= require('FileDialog')
local FileDialogFilters			= require('FileDialogFilters')
local MeSettings				= require('MeSettings')
local UpdateManager				= require('UpdateManager')
local U 						= require('me_utilities')
local Gui						= require("dxgui")
local GuiWin					= require('dxguiWin')

setmetatable(Gui, {__index = GuiWin})

local Factory			= require('Factory')
local i18n				= require('i18n')

local _ = i18n.ptranslate

local cdata = {
	search					= _('Search...'),
	searchCategory			= '__search__',
	all						= _('All But Axis Commands'),
	axisCommands			= _('Axis Commands'),
	ok						= _('Ok'),
	yes						= _('YES'),
	no						= _('NO'),
	warning					= _('WARNING'),
	confirmClearAll			= _('Are you sure you want to clear all assignments for device\n"%s?"'),
	confirmClear			= _('Are you sure you want to clear all assignments for device\n"%s"\nin category "%s"?'),
	confirmClearSearch		= _('Are you sure you want to clear all assignments for device\n"%s"\nin selected commands?'),
	confirmDefaultAll		= _('Are you sure you want to reset all assignments for device\n"%s?"'),
	confirmDefault			= _('Are you sure you want to reset all assignments for device\n"%s"\nin category "%s"?'),
	confirmDefaultSearch	= _('Are you sure you want to reset all assignments for device\n"%s"\nin selected commands?'),
	confirmClearTotal		= _('Are you sure you want to clear all assignments for all devices\nfor aircraft:\n'),
	saveProfileAs			= _('Save profile as'),
	loadProfile				= _('Load profile'),
	profilesChaned			= _('Profiles:\n%s\nhave been changed.\nDo you want to save changes?'),
	noCommandAvailable		= _('No command available for this device'),
	commandNamesDuplicated	= _('Different actions have identical descriptions!'),
	
	disablePnp				= _('Disable hot plug'),
	enablePnp				= _('Enable hot plug'),
	disablePnpHint			= _('Press to deny automatic device detection.\nPress \'%s\' for manual detection.'),
	enablePnpHint			= _('Press to detect devices automatically'),
	wizard					= _('Controls Wizard'),
}

local actionColumnIndex 	= 0
local categoryColumnIndex 	= 1
local inputLayerName		= 'InputOptionsView'
local axisRangeValue		= 100
local staticWidgetPool = {
	widgets = {},
}
local modifiers_
local staticUiProfileWarning_

staticWidgetPool.newWidget = function()
	local widget = Static.new()
	
	widget.pool = staticWidgetPool
	
	return widget
end

local rangeIndicatorWidgetPool = {	
	widgets = {},
}

rangeIndicatorWidgetPool.newWidget = function()
	local widget = HorzRangeIndicator.new()
	
	widget:setRange(-axisRangeValue, axisRangeValue)
	widget.pool = rangeIndicatorWidgetPool
	
	return widget
end

local function getWidgetFromPool(widgetPool)
	if #widgetPool.widgets == 0 then
		return widgetPool.newWidget()
	else
		return table.remove(widgetPool.widgets)
	end
end

local function returnWidgetToPool(widget)
	widget:setEnabled(true)
	table.insert(widget.pool.widgets, widget)
end

local function getColumnDeviceName_(self, columnIndex)
	return self.deviceColumns_[columnIndex - categoryColumnIndex].deviceName
end

local function createDeviceColumns()
	-- первая колонка в таблице вставлена в редакторе
	local columns = {}
	local devices = InputUtils.getDevices()

	for i, deviceName in ipairs(devices) do
		table.insert(columns, {deviceName = deviceName, width = 200})
	end
	
	return columns
end

local function getDeviceColumnIndex_(self, deviceName)
	for i, deviceColumn in ipairs(self.deviceColumns_) do
		if deviceColumn.deviceName == deviceName then	
			return i + 1
		end
	end
end

local function getHeaderCellSkin_(self, selected)
	if selected then
		return self.gridHeaderCellSelectedSkin_
	else
		return self.gridHeaderCellSkin_
	end
end

-- удалим столбцы для отсутствующих(отключенных) устройств
local function clearRemovedDeviceColumns(self, deviceColumns)
	local grid = self.grid_
	
	for i = grid:getColumnCount(), categoryColumnIndex + 1, -1 do
		local headerCell = grid:getColumnHeader(i - 1)
		local deviceName = headerCell.deviceName
		local found = false
		
		for j, column in ipairs(deviceColumns) do
			if column.deviceName == deviceName then
				found = true
				
				break
			end
		end
		
		if not found then
			grid:clearColumn(i - 1)
		end
	end
end

local getDeviceDisabled_ = InputData.getDeviceDisabled

local function selectColumnHeader_(self, columnIndex)
	local grid = self.grid_
	local columnCount = grid:getColumnCount()

	for i = 0, columnCount - 1 do 
		if i > categoryColumnIndex then
			local headerCell		= grid:getColumnHeader(i)
			local deviceDisabled	= getDeviceDisabled_(headerCell.deviceName)
			local selected			= (columnIndex == i) and not deviceDisabled

			headerCell:setSkin(getHeaderCellSkin_(self, selected))
		end
	end
end

-- определены ниже
local activate_
local deactivate_
local selectCell_

local function setHeaderCellCallbacks_(self, headerCell)
	local view = self
	
	-- remove trailing and leading whitespace from string.
	-- http://en.wikipedia.org/wiki/Trim_(8programming)
	local trim = function(text)
		-- from PiL2 20.4
		return (string.gsub(text, '^%s*(.-)%s*$', '%1'))
	end
	
	headerCell:addMouseDoubleDownCallback(function()
		-- обработчики для переименования заголовка столбца с именем устройства
		local panel		= self.container_.panelRenameColumn
		local editBox	= panel.editBox
		
		local w, h 		= headerCell:getSize()
		local x, y 		= headerCell:widgetToWindow(0, 0)
		
		local wx, wy	= self.container_:windowToWidget(x, y)
		
		panel:setBounds(wx, wy, w, h) -- учитываем размер заголовка окна
		panel:setVisible(true)
		
		editBox:setText(headerCell.static:getText())
		editBox:setSelectionNew(0, 0, 0, -1)
		editBox:setFocused(true)
		
		headerCell:setVisible(false)
		deactivate_(view)
		
		local handled = false
		
		local renameDevice = function(text)
			local text = trim(editBox:getText())
			
			if '' == text then
				text = headerCell.deviceName
			end
			
			MeSettings.setDeviceName(headerCell.deviceName, text)
			
			headerCell.static:setText(text)
			panel:setVisible(false)
			headerCell:setVisible(true)
			activate_(view)
		end
		
		function editBox:onKeyDown(keyName, unicode)
			if keyName == 'return' then
				renameDevice(editBox:getText())
				handled = true
			elseif keyName == 'escape' then
				panel:setVisible(false)
				headerCell:setVisible(true)
				activate_(view)
				handled = true
			end
		end

		function editBox:onFocus(focused)
			if not handled and not focused then
				renameDevice(editBox:getText())
			end
			
			handled = false
		end
	end)
	
	headerCell:addMouseDownCallback(function()		
		selectCell_(self, headerCell.columnIndex, -1)
	end)
	
	headerCell.button:addChangeCallback(function()	
		local w, h 				= headerCell.button:getSize()
		local x, y 				= headerCell.button:widgetToWindow(0, h)
		local deviceDisabled	= getDeviceDisabled_(headerCell.deviceName)
		local menuDevice		= self.menuDevice_
		
		menuDevice.menuCheckItemDisabled:setState(deviceDisabled)
		
		menuDevice.menuItemClearCategory			:setEnabled(not deviceDisabled)
		menuDevice.menuItemResetCategoryToDefault	:setEnabled(not deviceDisabled)
		menuDevice.menuItemFFTune					:setEnabled(not deviceDisabled)
		menuDevice.menuItemSaveProfileAs			:setEnabled(not deviceDisabled)
		menuDevice.menuItemLoadProfile				:setEnabled(not deviceDisabled)
		menuDevice.menuItemMakeHtml					:setEnabled(not deviceDisabled)
		
		menuDevice:setPosition(x, y)
		menuDevice:setVisible(true)
	end)	
end

local function updateGridColumns_(self)
	local grid = self.grid_
	local prevColumnWidths = {}
	
	-- удаляем все столбцы до Категорий
	for i = grid:getColumnCount(), categoryColumnIndex + 2, -1 do
		local columnIndex = i - 1
		local headerCell = grid:getColumnHeader(columnIndex)
		
		prevColumnWidths[headerCell.deviceName] = grid:getColumnWidth(columnIndex)
		grid:clearColumn(columnIndex)
	end

	for i, column in ipairs(self.deviceColumns_) do
		local headerCell = self.gridHeaderCell_:clone()

		headerCell:setVisible(true)
		headerCell.static:setText(MeSettings.getDeviceName(column.deviceName))
		headerCell.columnIndex = i + 1
		headerCell.deviceName = column.deviceName
		headerCell.static:setTooltipText(column.deviceName)
		setHeaderCellCallbacks_(self, headerCell)
		
		local columnWidth = prevColumnWidths[column.deviceName] or column.width		
		grid:insertColumn(columnWidth, headerCell)		
	end
end

local function fillComboListProfiles_(self)
	local names = InputData.getProfileNames()
	
	table.sort(names, function(name1, name2)
		return textutil.Utf8Compare(name1, name2)
	end)
	
	local comboListProfiles	= self.comboListProfiles_
	local uiProfileName		= InputData.getUiProfileName()

	for i, profileName in ipairs(names) do
		local item = ListBoxItem.new(profileName)

		item.profileName = profileName
		
		if profileName == uiProfileName then
			comboListProfiles:insertItem(item, 0) -- uiLayer делаем первым
		else
			comboListProfiles:insertItem(item)
		end
	end
end

local function fillCategoriesComboWidget(comboWidget, categories)
	comboWidget:clear()
	
	local item = ListBoxItem.new(cdata.search)
	
	item.category = cdata.searchCategory
	comboWidget:insertItem(item)
	
	item = ListBoxItem.new(cdata.all)
	item.category = cdata.all

	comboWidget:insertItem(item)
	comboWidget:selectItem(item)
	
	item = ListBoxItem.new(cdata.axisCommands)
	item.category = cdata.axisCommands
	
	comboWidget:insertItem(item)	
	
	for i, category in ipairs(categories) do
		item = ListBoxItem.new(category)
		item.category = category
		
		comboWidget:insertItem(item)
	end
end

local function fillComboListCategories_(self, profileName)
	local categories = InputData.getProfileCategoryNames(profileName)
	
	table.sort(categories, function(category1, category2)
		return textutil.Utf8Compare(category1, category2)
	end)
	
	fillCategoriesComboWidget(self.comboListCategory_, categories)
	fillCategoriesComboWidget(self.comboBoxCategory_, categories)
end

local function getCellSkin_(widget, valid, selected, noCommand)
	if noCommand then
		return widget.pool.noCommandSkin
	end
	
	if valid then
		if selected then
			return widget.pool.validSelectedSkin
		else
			return widget.pool.validNotSelectedSkin
		end
	else
		if selected then
			return widget.pool.invalidSelectedSkin
		else
			return widget.pool.invalidNotSelectedSkin
		end
	end
end

local deviceKeysAxes_ = {}

local function getKeyAxisPresented(name, deviceName)
	local deviceKeysAxes = deviceKeysAxes_[deviceName]
	
	if not deviceKeysAxes then
		deviceKeysAxes = {}
		
		for i, action in ipairs(InputUtils.getDeviceKeys(deviceName)) do
			deviceKeysAxes[action.name] = true
		end
		
		for i, action in ipairs(InputUtils.getDeviceAxes(deviceName)) do
			deviceKeysAxes[action.name] = true
		end
		
		deviceKeysAxes_[deviceName] = deviceKeysAxes
	end
	
	return deviceKeysAxes[name]
end

local function getComboPresented(combo, deviceName)
	if not getKeyAxisPresented(combo.key, deviceName) then
		return false
	end
	
	if combo.reformers then
		for i, reformer in ipairs(combo.reformers) do
			local modifier = modifiers_[reformer]
			
			if modifier then
				if not getKeyAxisPresented(modifier.key, modifier.deviceName) then
					return false
				end
			else
				return false
			end
		end
	end
	
	return true
end

local function assembleCombo(combos, deviceName)
	local strings	= {}
	local warnings	= {}

	if combos then
		for i, combo in ipairs(combos) do
			if getComboPresented(combo, deviceName) then
				table.insert(strings, InputUtils.createComboString(combo, deviceName))
				
				if combo.warnings then			
					table.insert(warnings, combo.warnings)		
				end
			end
		end
	end

	return table.concat(strings, '; '), table.concat(warnings, '\n')
end

local function getCombosAreValid(combos)
	local result = true

	if combos then
		for i, combo in ipairs(combos) do
			result = result and combo.valid
		end
	end

	return result
end

local function setCellSkin(cell, skin)
	if cell.skin ~= skin then
		cell.skin = skin
		cell:setSkin(skin)
	end	
end

local function getCommandTooltipCodes_(rowInfoCell)
	local result = ''

	if OPTIONS_ADD_COMMAND_CODES_TO_TOOLTIP then
		result = '('

		if rowInfoCell.cockpit_device_id ~= nil then	result = string.format('%s cockpit id: %s',	result,	tostring(rowInfoCell.cockpit_device_id))	end
		if rowInfoCell.down		then	result = string.format('%s down: %s',		result,	tostring(rowInfoCell.down))		end
		if rowInfoCell.pressed	then	result = string.format('%s pressed: %s',	result,	tostring(rowInfoCell.pressed))	end
		if rowInfoCell.action	then	result = string.format('%s action: %s',		result,	tostring(rowInfoCell.action))	end
		if rowInfoCell.up		then	result = string.format('%s up: %s', 		result,	tostring(rowInfoCell.up))		end

		result = string.format('%s)', result)
	end

	return result
end

local function setComboCell(widget, deviceName, rowInfo)
	local rowInfoCell		= rowInfo.cells[deviceName]
	local deviceDisabled	= getDeviceDisabled_(deviceName)
	
	widget:setEnabled(not rowInfoCell.disabled and not deviceDisabled)
	
	if rowInfoCell.text == '' and widget.isRangeIndicator then
		widget:setValueRange(0, 0)
	end
	
	widget:setText(rowInfoCell.text)
	widget:setTooltipText(string.format('%s%s', rowInfoCell.tooltip, getCommandTooltipCodes_(rowInfoCell)))		
	
	setCellSkin(widget, getCellSkin_(widget, rowInfoCell.valid, false, rowInfoCell.noCommand))
end

local function createComboCell_(columnIndex, deviceName, rowInfo)
	local widget
	local rowInfoCell = rowInfo.cells[deviceName]

	if 	rowInfo.isAxisCommand and 
		rowInfoCell.noCommand == false and
		Input.getJoystickDeviceTypeName() == InputUtils.getDeviceTypeName(deviceName)then 
		
		rowInfo.isRangeIndicator = true

		widget = getWidgetFromPool(rangeIndicatorWidgetPool)
		widget:setValueRange(0, 0)
		widget.isRangeIndicator = true
	else
		widget = getWidgetFromPool(staticWidgetPool)
	end
	
	rowInfo.widgets[columnIndex] = widget
	
	setComboCell(widget, deviceName, rowInfo)
end

local function updateActionCell_(rowInfo)
	local skin
	local widget = rowInfo.widgets[actionColumnIndex]
	local tooltipText
	
	if rowInfo.nameDuplicated then
		skin = staticWidgetPool.duplicatedCommandSkin
		tooltipText = cdata.commandNamesDuplicated
		
		if rowInfo.nameHint ~= rowInfo.name then
			tooltipText = tooltipText .. '\n' .. rowInfo.nameHint
		end		
	else
		skin = getCellSkin_(widget, rowInfo.valid, false, false)
		
		tooltipText = rowInfo.nameHint
	end
	
	widget:setTooltipText(tooltipText)
	widget:setText(rowInfo.name)
	setCellSkin(widget, skin)
end

local function createActionCell_(rowInfo)
	local widget = getWidgetFromPool(staticWidgetPool)
	
	rowInfo.widgets[actionColumnIndex] = widget
	
	updateActionCell_(rowInfo)
	
	local w, h = widget:calcSize()
	
	if h > rowHeight then
		rowInfo.rowHeight = rowHeight * 2
	else
		rowInfo.rowHeight = rowHeight
	end

	return widget
end

local function getCategoryText(category)
	if 'table' == type(category) then
		return table.concat(category, ', ')
	else
		return category
	end
end

local function updateCategoryCell_(rowInfo)
	local widget 		= rowInfo.widgets[categoryColumnIndex]
	local valid			= true
	local skin			= getCellSkin_(widget, valid, rowInfo.categorySelected)	
	
	widget:setText			(rowInfo.categoryText)
	widget:setTooltipText	(rowInfo.categoryHint)
	
	setCellSkin(widget, skin)
end

local function createCategoryCell_(rowInfo)
	local widget		= getWidgetFromPool(staticWidgetPool)
	
	rowInfo.widgets[categoryColumnIndex] = widget
	updateCategoryCell_(rowInfo)

	return widget
end

local function getCurrentCategory_(self)
	if cdata.all == self.currentCategory_ then
		return nil
	else
		return self.currentCategory_
	end
end

local function isAxisCommands_(self)
	return self.currentCategory_ == cdata.axisCommands
end

local function createRowWidgets(self, rowInfo, rowIndex)
	rowInfo.widgets = {}
	
	createActionCell_	(rowInfo)
	createCategoryCell_	(rowInfo)
	
	local devices = InputUtils.getDevices()
	
	for i, deviceName in ipairs(devices) do
		createComboCell_(categoryColumnIndex + i, deviceName, rowInfo)
	end
end

local function setRowInfoCommand(rowInfo, command)
	local cells = rowInfo.cells
	
	rowInfo.valid = command.valid
	
	for deviceName, combos in pairs(command.combos) do
		local combosCopy = U.copyTable(nil, combos)
		local filter
		
		for i, combo in ipairs(combosCopy) do
			if combo.key then
				-- у всех combo внутри combos filter должен быть один и тот же
				filter = combo.filter
				
				break
			end
		end
		
		local text, warnings = assembleCombo(combos, deviceName)
		local tooltip
		
		if warnings ~= '' then
			tooltip = text .. '\n' .. warnings
		else
			tooltip = text
		end
		
		cells[deviceName] = {
			hash		= command.hash,
			combos		= combosCopy,
			valid		= getCombosAreValid(combos),
			text		= text,
			tooltip		= tooltip,
			down		= command.down,
			pressed		= command.pressed,
			action		= command.action,
			cockpit_device_id = command.cockpit_device_id,
			filter		= filter,
			up			= command.up,
			disabled	= command.disabled,
			noCommand	= false,
		}
	end
end

local function createRowInfo(command, isAxisCommand, nameDuplicated)
	local rowInfo = {
		hash				= command.hash,
		name				= command.name,
		nameHint			= command.nameHint or command.name,
		category			= command.category,
		categoryText		= getCategoryText(command.category),
		categoryHint		= getCategoryText(command.categoryHint or command.category),
		categorySelected	= false,
		valid				= command.valid,
		cells				= {},
		isAxisCommand		= isAxisCommand,
		nameDuplicated		= nameDuplicated,
	}
	
	setRowInfoCommand(rowInfo, command)
	
	return rowInfo
end

local function createNoCommandRowInfos(rowInfos)
	local deviceList	= InputUtils.getDevices()

	for i, rowInfo in ipairs(rowInfos) do
		for i, deviceName in ipairs(deviceList) do
			local cells			= rowInfo.cells
			local rowInfoCell	= rowInfo.cells[deviceName]
			
			if not rowInfoCell then
				rowInfoCell = {
					combos		= {},
					valid		= false,
					text		= '',
					tooltip		= cdata.noCommandAvailable,
					disabled	= true,
					noCommand	= true,
				}
				
				cells[deviceName] = rowInfoCell
			end
		end
	end
end

local function getCommandNameIsDuplicated_(commandIndex, commands)
	local nextCommand = commands[commandIndex + 1]
	
	if nextCommand then
		if commands[commandIndex].name == nextCommand.name then
			return true
		end
	end
	
	local prevCommand = commands[commandIndex - 1]
	
	if prevCommand then
		if commands[commandIndex].name == prevCommand.name then
			return true
		end
	end
	
	return false
end

local function createRowInfos(commands, isAxisCommands)
	-- команды должны быть отсортированы по имени
	local result = {}
	
	for i, command in ipairs(commands) do
		local nameDuplicated = getCommandNameIsDuplicated_(i, commands)
		
		table.insert(result, createRowInfo(command, isAxisCommands, nameDuplicated))
	end
	
	createNoCommandRowInfos(result)

	return result
end

local function getCurrentProfileName(self)
	return self.currentProfileName_
end

local function getRowInfo_(self, rowIndex)
	if self.currentRowInfoIndices_ then
		return self.currentRowInfos_[self.currentRowInfoIndices_[rowIndex + 1]]
	else
		return self.currentRowInfos_[rowIndex + 1]
	end
end

local function getRowInfoCell_(self, rowIndex, deviceName)
	return getRowInfo_(self, rowIndex).cells[deviceName]
end

local function getCellIsValid_(self, columnIndex, rowInfo)
	local valid			= true
	local noCommand		= false

	if rowInfo then
		if actionColumnIndex == columnIndex then
			valid = rowInfo.valid
		elseif categoryColumnIndex == columnIndex then
			valid = rowInfo.valid
		else
			local deviceName = getColumnDeviceName_(self, columnIndex)

			if deviceName then
				local rowInfoCell = rowInfo.cells[deviceName]
				
				valid		= rowInfoCell.valid
				noCommand	= rowInfoCell.noCommand
			end
		end
	end

	return valid, noCommand
end

local function updateComboCell_(self, columnIndex, rowIndex)
	local rowInfo		= getRowInfo_(self, rowIndex)
	local deviceName	= getColumnDeviceName_(self, columnIndex)
	local widget		= rowInfo.widgets[columnIndex]
	
	setComboCell(widget, deviceName, rowInfo)
end

local function addGridRow(self, rowInfo, rowIndex, deviceCount)
	updateActionCell_(rowInfo)
	updateCategoryCell_(rowInfo)
	
	for i = 1, deviceCount do
		updateComboCell_(self, categoryColumnIndex + i, rowIndex)
	end
	
	local grid = self.grid_
	
	grid:insertRow(rowInfo.rowHeight)
	
	for i, widget in pairs(rowInfo.widgets) do -- <<-- pairs!!!
		grid:setCell(i, rowIndex, widget)
	end
end

local function updateGrid(self)
	local grid				= self.grid_
	local rowInfos			= self.currentRowInfos_
	local rowInfoIndices	= self.currentRowInfoIndices_
	
	grid:removeAllRows()
	
	local deviceCount = #InputUtils.getDevices()
	
	if rowInfoIndices then
		for i, rowInfoIndex in ipairs(rowInfoIndices) do
			local rowInfo = rowInfos[rowInfoIndex]
			
			addGridRow(self, rowInfo, i - 1, deviceCount)
		end
	else
		for i, rowInfo in ipairs(rowInfos) do
			addGridRow(self, rowInfo, i - 1, deviceCount)
		end
	end
--[[ растягивание столбцов девайсов	
	local columnsToStretch = {}

	for i, column in ipairs(self.deviceColumns_) do		
		table.insert(columnsToStretch, categoryColumnIndex + i)
	end
	
	grid:stretchColumns(columnsToStretch)	]]
end

local function getRowBelongsToCategory(category, rowInfo)
	local result = true
	
	if category then
		result = rowInfo.category == category
		
		if not result then
			if 'table' == type(rowInfo.category) then
				for i, categoryName in ipairs(rowInfo.category) do
					if categoryName == category then
						result = true
						
						break
					end
				end
			end
		end
	end
	
	return result
end

local function updateCurrentCommands_(self, profileName)
	local category = self.currentCategory_
	
	if 		cdata.all == category then
		self.currentRowInfos_ = self.keyRowInfos_
		self.currentRowInfoIndices_ = nil
		updateGrid(self)
	elseif	cdata.axisCommands == category then
		self.currentRowInfos_ = self.axisRowInfos_
		self.currentRowInfoIndices_ = nil		
		updateGrid(self)
	elseif	cdata.searchCategory == category then
		local searchString = self.comboBoxCategory_:getText()
	
		if not searchString or '' == searchString then
			self.currentRowInfos_ = self.keyRowInfos_
			self.currentRowInfoIndices_ = nil			
			updateGrid(self)
		else
			local Utf8FindNoCase = textutil.Utf8FindNoCase
			local rowInfoIndices = {}
			
			for i, rowInfo in ipairs(self.keyRowInfos_) do
				if 	Utf8FindNoCase(rowInfo.name			or '', searchString) or 
					Utf8FindNoCase(rowInfo.categoryText	or '', searchString) then
					
					table.insert(rowInfoIndices, i)
				end
			end
			
			self.currentRowInfos_ = self.keyRowInfos_
			self.currentRowInfoIndices_ = rowInfoIndices				
			
			updateGrid(self)
		end
	else
		local rowInfoIndices = {}
		
		for i, rowInfo in ipairs(self.keyRowInfos_) do
			if 	getRowBelongsToCategory(category, rowInfo) then
				table.insert(rowInfoIndices, i)
			end
		end
		
		self.currentRowInfos_ = self.keyRowInfos_
		self.currentRowInfoIndices_ = rowInfoIndices

		updateGrid(self)
	end	
end

local function getComboReformers(comboReformerNames)
	local reformers
	
	if comboReformerNames then
		reformers = {}
		
		for i, comboReformerName in ipairs(comboReformerNames) do
			local modifier = modifiers_[comboReformerName]
			
			if modifier then
				table.insert(reformers, {key = modifier.event, deviceId = modifier.deviceId})
			end	
		end
	end
	
	return reformers
end

local function createKeyInputInfos_(self, profileName)
	for i, rowInfo in ipairs(self.keyRowInfos_) do
		for deviceName, rowInfoCell in pairs(rowInfo.cells) do
			local deviceId	= Input.getDeviceId(deviceName)
			
			for j, combo in ipairs(rowInfoCell.combos) do
				if combo.valid then
					local key = combo.key
					
					if not InputUtils.getSkipDeviceEvent(key, deviceName) then
						local keyEvent = InputUtils.getInputEvent(key)
						local reformers = getComboReformers(combo.reformers)
						
						table.insert(self.inputInfos_, { 	name 		= rowInfo.name, 
															hash		= rowInfo.hash, 
															deviceId	= deviceId,
															deviceName 	= deviceName,})
						
						local inputInfoIndex	= #self.inputInfos_
						
						-- для того, чтобы индексы не смешивались с командами симулятора 
						-- и с командами слоя для устройств VR сделаем их отрицательными
						local down				= -inputInfoIndex
						local pressed			= nil
						local up				= nil
						
						Input.addKeyCombo(inputLayerName, keyEvent, deviceId, reformers, down, pressed, up)
					end
				end
			end
		end
	end
end

local function createAxisInputInfos_(self, profileName)
	local joystickDeviceTypeName = Input.getJoystickDeviceTypeName()
	
	for i, rowInfo in ipairs(self.axisRowInfos_) do
		for deviceName, rowInfoCell in pairs(rowInfo.cells) do
			if joystickDeviceTypeName == InputUtils.getDeviceTypeName(deviceName)then 
				local deviceId	= Input.getDeviceId(deviceName)
				
				for j, combo in ipairs(rowInfoCell.combos) do
					if combo.valid then
						local axis = combo.key
						
						if not InputUtils.getSkipDeviceEvent(axis, deviceName) then
							local axisEvent = InputUtils.getInputEvent(axis)
							local reformers = getComboReformers(combo.reformers)
							local filter	= combo.filter
							
							table.insert(self.inputInfos_, { 	name 		= rowInfo.name, 
																hash		= rowInfo.hash, 
																deviceId	= deviceId,
																deviceName 	= deviceName,
																filter		= filter,})
							
							local inputInfoIndex	= #self.inputInfos_

							-- для того, чтобы индексы не смешивались с командами симулятора 
							-- и с командами слоя для устройств VR сделаем их отрицательными
							local action			= -inputInfoIndex
							
							Input.addAxisCombo(inputLayerName, axisEvent, deviceId, reformers, action, filter)
						end
					end
				end
			end
		end
	end
end

local function createInputInfos_(self, profileName)
	self.inputInfos_ = {}
	createKeyInputInfos_(self, profileName)
	createAxisInputInfos_(self, profileName)
end

local function setInputModifiers()
	Input.clearReformers(inputLayerName)
	
	for name, modifier in pairs(modifiers_) do
		local event = modifier.event

		if event then
			Input.addReformer(inputLayerName, modifier.event, modifier.deviceId, modifier.switch)
		end
	end
end

local function createInputLayer_(self, profileName)
	Input.deleteLayer(inputLayerName)
	Input.createLayer(inputLayerName)
	
	if self.isInputActive_ then
		Input.setTopLayer(inputLayerName)
	end
	
	setInputModifiers()
	createInputInfos_(self, profileName)
end

local function getCellComboEmpty_(self, columnIndex, rowIndex)
	local deviceName = getColumnDeviceName_(self, columnIndex)
	local rowInfoCell = getRowInfoCell_(self, rowIndex, deviceName)
	
	if rowInfoCell then
		local combos = rowInfoCell.combos
		
		if combos then
			return #combos == 0
		end
	end
		
	return true
end

local function getColumnDeviceTypeName_(self, columnIndex)
	local deviceName = getColumnDeviceName_(self, columnIndex)
	
	return InputUtils.getDeviceTypeName(deviceName)
end

local function enableButtons_(self)
	local columnSelected	= (nil ~= self.activeColumn_)
	local deviceName
	
	if columnSelected then
		deviceName		= getColumnDeviceName_(self, self.activeColumn_)	
		columnSelected	= not getDeviceDisabled_(deviceName)		
	end
	
	self.buttonLoadProfile_			:setEnabled(columnSelected)
	self.buttonSaveProfileAs_		:setEnabled(columnSelected)
	self.buttonClearCategory_		:setEnabled(columnSelected)
	self.buttonSetDefaultCategory_	:setEnabled(columnSelected)
	
	local cellSelected = (columnSelected and (nil ~= self.activeRow_))
	
	self.buttonDefault_			:setEnabled(cellSelected)
	self.buttonClear_			:setEnabled(cellSelected)
	self.buttonAdd_				:setEnabled(cellSelected)
	
	local enableButtonAxisTune = cellSelected and isAxisCommands_(self) and not getCellComboEmpty_(self, self.activeColumn_, self.activeRow_)
	
	self.buttonAxisTune_:setEnabled(enableButtonAxisTune)
	
	local enableButtonFFTune = columnSelected and 'joystick' == getColumnDeviceTypeName_(self, self.activeColumn_)
	
	if enableButtonFFTune then
		local profileName	= self:getCurrentProfileName()
		local ffSettings	= InputData.getProfileForceFeedbackSettings(profileName, deviceName)
		
		if ffSettings then
			enableButtonFFTune	= not ffSettings.ignore
		else	
			enableButtonFFTune = false
		end
	end
	
	self.buttonFFTune_:setEnabled(enableButtonFFTune)
	self.menuDevice_.menuItemFFTune:setEnabled(enableButtonFFTune)
end

local function setCellInactive_(self, columnIndex, rowIndex)
	if columnIndex and rowIndex then
		local cell				= self.grid_:getCell(columnIndex, rowIndex)
		local rowInfo			= getRowInfo_(self, rowIndex)		
		local valid, noCommand	= getCellIsValid_(self, columnIndex, rowInfo)
		local skin				= getCellSkin_(cell, valid, false, noCommand)
		local deviceName		= getColumnDeviceName_(self, columnIndex)
		local rowInfoCell		= getRowInfoCell_(self, rowIndex, deviceName)
		local deviceDisabled	= getDeviceDisabled_(deviceName)

		cell:setEnabled(not rowInfoCell.disabled and not deviceDisabled)
		setCellSkin(cell, skin)
		self.menu_:setVisible(false)
	end
end

local function setCellActive_(self, columnIndex, rowIndex)
	self.activeColumn_ = nil
	self.activeRow_ = nil

	if columnIndex and rowIndex then
		if columnIndex > categoryColumnIndex then
			self.activeColumn_ = columnIndex

			local cell = self.grid_:getCell(columnIndex, rowIndex)

			if cell then
				self.activeRow_ 	= rowIndex

				local rowInfo			= getRowInfo_(self, rowIndex)
				local valid, noCommand	= getCellIsValid_(self, columnIndex, rowInfo)
				local skin				= getCellSkin_(cell, valid, true, noCommand)
				local deviceName		= getColumnDeviceName_(self, columnIndex)
				local rowInfoCell		= getRowInfoCell_(self, rowIndex, deviceName)
				local deviceDisabled	= getDeviceDisabled_(deviceName)
				
				cell:setEnabled(not rowInfoCell.disabled and not deviceDisabled)
                
				setCellSkin(cell, skin)
			end
		end

		self.grid_:selectRow(rowIndex)
		selectColumnHeader_(self, columnIndex)
	end
	
	enableButtons_(self)
end

-- объявлена выше
function selectCell_(self, columnIndex, rowIndex)
	if columnIndex and rowIndex then
		setCellInactive_(self, self.activeColumn_, self.activeRow_)
		setCellActive_(self, columnIndex, rowIndex)
	end
end

local function showContextMenu_(self, x, y)
	if self.activeColumn_ and self.activeRow_ then
		local deviceName		= getColumnDeviceName_(self, self.activeColumn_)
		local deviceDisabled	= getDeviceDisabled_(deviceName)
		
		if not deviceDisabled then
			local rowInfoCell = getRowInfoCell_(self, self.activeRow_, deviceName)
			
			if rowInfoCell and not rowInfoCell.disabled and not rowInfoCell.noCommand then
				local enableAxisTuneItem = isAxisCommands_(self) and not getCellComboEmpty_(self, self.activeColumn_, self.activeRow_)
				
				self.menu_.menuItemTuneComboAxis:setEnabled(enableAxisTuneItem)
				self.menu_:setPosition(x, y)
				self.menu_:setVisible(true)
			end
		end
	end
end

local function resetActiveColumnAndRow_(self)
	setCellActive_(self)
	
	selectColumnHeader_(self)
	self.grid_:selectRow(-1)
	self.grid_:setVertScrollPosition(0)
end

local function createWidgets(self, rowInfos)
	local rowCount 	= #rowInfos
	local grid		= self.grid_
	
	for i, rowInfo in ipairs(rowInfos) do
		createRowWidgets(self, rowInfo, i - 1)
	end
end

local function releaseWidgets(rowInfos)
	for i, rowInfo in ipairs(rowInfos) do
		for j, widget in pairs(rowInfo.widgets) do -- <<-- pairs!!!
			returnWidgetToPool(widget)
		end
	end
end

local function createAxisRowInfos(self, profileName)
	local commands = InputData.getProfileAxisCommands(profileName)
	
	table.sort(commands, function(command1, command2)	
		return textutil.Utf8Compare(command1.name, command2.name)
	end)
	
	local isAxisCommands = true
	
	self.axisRowInfos_ = createRowInfos(commands, isAxisCommands)
end

local function createKeyRowInfos(self, profileName)
	local commands = InputData.getProfileKeyCommands(profileName)
	
	table.sort(commands, function(command1, command2)	
		return textutil.Utf8Compare(command1.name, command2.name)
	end)
	
	local isAxisCommands = false
	
	self.keyRowInfos_ = createRowInfos(commands, isAxisCommands)
end

local function showUiProfileWarning(self)
	local modified = {}
	local names = InputData.getProfileNames()
	
	table.sort(names, function(name1, name2)
		return textutil.Utf8Compare(name1, name2)
	end)
	
	local uiProfileName = InputData.getUiProfileName()
	
	for i, profileName in ipairs(names) do
		if profileName ~= uiProfileName then
			
			if InputData.getProfileModified(profileName) then
				table.insert(modified, profileName)
			end
		end
	end
	
	if #modified > 0 then
		if not staticUiProfileWarning_ then
			local dialog = DialogLoader.spawnDialogFromFile('./Scripts/Input/UiProfileWarning.dlg')
			staticUiProfileWarning_ = dialog.staticUiProfileWarning
			
			dialog:removeWidget(staticUiProfileWarning_)
			dialog:kill()
		end
		
		staticUiProfileWarning_:setText(string.format(_('If you change %s profile then all changes in profiles:\n\n%s\n\nwill be lost!'), uiProfileName, table.concat(modified, '\n')))
		staticUiProfileWarning_:setSize(staticUiProfileWarning_:calcSize())
		
		local window = self.container_:getRoot()
		local ww, wh = window:getSize()
		local sw, sh = staticUiProfileWarning_:getSize()
		
		staticUiProfileWarning_:setPosition((ww - sw) / 2, (wh - sh) / 2) -- по центру экрана
		window:insertOverlayWidget(staticUiProfileWarning_)
		
		local startTime = os.clock()
		local duration = 5 -- seconds
		
		-- hide warning after duration seconds
		UpdateManager.add(function()
			if (os.clock() - startTime) > duration then
				window:removeOverlayWidget(staticUiProfileWarning_)
				
				return true -- удаляем функцию из UpdateManager
			end
		end)
	end
end

local setCurrentCategory_
local function setCurrentProfileName(self, profileName)
	local count = self.comboListProfiles_:getItemCount()
	
	for i = 1, count do
		local item = self.comboListProfiles_:getItem(i - 1)
		
		if item.profileName == profileName then
			-- возвращаем все виджеты в пул
			self.grid_:removeAllRows()
			releaseWidgets(self.axisRowInfos_)
			releaseWidgets(self.keyRowInfos_)
			
			self.axisRowInfos_ = {}
			self.keyRowInfos_ = {}
			
			-- количество устройств между запусками может измениться
			self.deviceColumns_ = createDeviceColumns()
			updateGridColumns_(self)			
		
			self.currentProfileName_ = profileName
			self.comboListProfiles_:selectItem(item)
			
			modifiers_ = InputData.getProfileModifiers(profileName)
			
			createAxisRowInfos(self, profileName)
			createWidgets(self, self.axisRowInfos_)
			
			createKeyRowInfos(self, profileName)
			createWidgets(self, self.keyRowInfos_)
			
			createInputLayer_(self, profileName)
			
			fillComboListCategories_(self, profileName)
			self.currentCategory_ = nil
			setCurrentCategory_(self, cdata.all)

			if profileName == InputData.getUiProfileName() then
				showUiProfileWarning(self)
			end
			
			break
		end
	end	
end

local function findRow(self, searchFunc)
	local resultIndex
	local resultRowInfo
	
	for i, rowInfo in ipairs(self.currentRowInfos_) do
		if searchFunc(rowInfo) then
			resultIndex = i - 1
			resultRowInfo = rowInfo
			
			break
		end
	end
	
	if resultRowInfo and self.currentRowInfoIndices_ then
		-- resultRowInfo может отсутствовать среди видимых строк
		resultIndex = nil
		
		for i, rowInfoIndex in ipairs(self.currentRowInfoIndices_) do
			local rowInfo = self.currentRowInfos_[rowInfoIndex]
			
			if resultRowInfo == self.currentRowInfos_[rowInfoIndex] then
				resultIndex = i - 1
				
				break
			end
		end
	end
	
	return resultIndex, resultRowInfo
end

local function findCommandRow(self, commandHash)
	return findRow(self, function(rowInfo)
		return rowInfo.hash == commandHash
	end)
end

local function onProcessInput_(self)
	-- у нас есть еще все время включенный слой инпута для VR устройств
	-- сюда могут попадать команды от него
	local inputActions = Input.getInputActions()
	local isAxisCommands = isAxisCommands_(self)
	
	for i, inputAction in ipairs(inputActions) do
		local inputInfoIndex	= inputAction.action
		
		if inputInfoIndex < 0 then
			local inputInfo				= self.inputInfos_[-inputInfoIndex]
			
			-- эта проверка нужна поскольку при переключении самолета 
			-- сюда могут попадать команды джойстика от предыдущего самолета
			if inputInfo then 
				if inputAction.hasValue and isAxisCommands then				
					local columnIndex		= getDeviceColumnIndex_(self, inputInfo.deviceName)
					local rowIndex			= findCommandRow(self, inputInfo.hash)
					
					local rangeIndicator	= self.grid_:getCell(columnIndex, rowIndex)
					
					if inputInfo.filter and inputInfo.filter.slider then
						if inputInfo.filter.invert then
							rangeIndicator:setValueRange(inputAction.value * axisRangeValue, axisRangeValue)
						else
							rangeIndicator:setValueRange(-axisRangeValue, inputAction.value * axisRangeValue)
						end
					else
						local valueMin		= math.min(0, inputAction.value)
						local valueMax		= math.max(0, inputAction.value)
						
						rangeIndicator:setValueRange(valueMin * axisRangeValue, valueMax * axisRangeValue)
					end
				else
					local columnIndex		= getDeviceColumnIndex_(self, inputInfo.deviceName)
					local rowIndex			= findCommandRow(self, inputInfo.hash)
					
					if rowIndex then
						selectCell_(self, columnIndex, rowIndex)
						self.grid_:setRowVisible(rowIndex)

						break
					end
				end
			end
		end
	end
end

-- объявлена выше
function activate_(self)		
	Input.process()
	Input.setTopLayer(inputLayerName)
		
	if not self.isInputActive_ then
		self.isInputActive_ = true		
		
		self.onProcessInputFunc_ = function()
			onProcessInput_(self)
		end
		
		UpdateManager.add(self.onProcessInputFunc_)
	end
end

-- объявлена выше
function deactivate_(self)	
	if self.isInputActive_ then
		self.isInputActive_ = false
		Input.removeLayerFromStack(inputLayerName)
		UpdateManager.delete(self.onProcessInputFunc_)
		self.onProcessInputFunc_ = nil
	end
end

-- объявлена выше
function setCurrentCategory_(self, category)
	if self.currentCategory_ ~= category then
		local comboListCategory = self.comboListCategory_
		local count = comboListCategory:getItemCount()
		
		for i = 1, count do
			local item = comboListCategory:getItem(i - 1)
			
			if item.category == category then
				self.currentCategory_ = category
				comboListCategory:selectItem(item)
				
				local comboBoxCategory = self.comboBoxCategory_
				
				if item.category == cdata.searchCategory then
					deactivate_(self)
					
					comboBoxCategory:setText()
					comboBoxCategory:setVisible(true)
					comboBoxCategory:setFocused(true)
				else
					activate_(self)
					comboBoxCategory:setFocused(false)
					comboBoxCategory:setVisible(false)
				end
								
				updateCurrentCommands_(self, self:getCurrentProfileName())
				resetActiveColumnAndRow_(self)
				
				break
			end
		end
	end
end

local function updateActiveCell_(self)
	updateComboCell_(self, self.activeColumn_, self.activeRow_)
	selectCell_(self, self.activeColumn_, self.activeRow_)
end

local function findComboRow_(self, combo, deviceName)
	local comboHash = InputUtils.getComboHash(combo.key, combo.reformers)

	return findRow(self, function(rowInfo)
		local rowInfoCell = rowInfo.cells[deviceName]
	
		for i, rowCombo in ipairs(rowInfoCell.combos) do
			if comboHash == InputUtils.getComboHash(rowCombo.key, rowCombo.reformers) then
				return true
			end
		end
		
		return false
	end)
end

local function addCombo_(self)
	if self.activeColumn_ and self.activeRow_ then
		local deviceName		= getColumnDeviceName_(self, self.activeColumn_)
		
		local rowInfo = getRowInfo_(self, self.activeRow_)
		local rowInfoCell = getRowInfoCell_(self, self.activeRow_, deviceName)
		
		if rowInfoCell and not rowInfoCell.disabled and not rowInfoCell.noCommand then
			local isAxisCommands = isAxisCommands_(self)
			local profileName = self:getCurrentProfileName()

			deactivate_(self)
			
			local addComboDialog	= self.addComboDialog_
			
			if not addComboDialog then
				addComboDialog			= AddComboDialog.new()
				self.addComboDialog_	= addComboDialog
			end
			
			local combo = addComboDialog:show(rowInfo.name, isAxisCommands, deviceName, profileName)
			
			if combo then
				local command
				
				-- комбо могло принадлежать другой команде
				local prevComboCommand
				local prevComboRow, prevComboRowInfo = findComboRow_(self, combo, deviceName)
				
				if isAxisCommands then
					InputData.addComboToAxisCommand(profileName, rowInfo.hash, deviceName, combo)
					command = InputData.getProfileAxisCommand(profileName, rowInfo.hash)
					
					if prevComboRowInfo then
						prevComboCommand = InputData.getProfileAxisCommand(profileName, prevComboRowInfo.hash)
					end
				else
					InputData.addComboToKeyCommand(profileName, rowInfo.hash, deviceName, combo)
					command = InputData.getProfileKeyCommand(profileName, rowInfo.hash)
					
					if prevComboRowInfo then
						prevComboCommand = InputData.getProfileKeyCommand(profileName, prevComboRowInfo.hash)
					end	
				end				
				
				setRowInfoCommand(rowInfo, command)
				updateActiveCell_(self)
				updateActionCell_(rowInfo)
				updateCategoryCell_(rowInfo)
				
				if prevComboCommand then
					setRowInfoCommand(prevComboRowInfo, prevComboCommand)
					
					if prevComboRow then
						updateComboCell_(self, self.activeColumn_, prevComboRow)
						updateActionCell_(prevComboRowInfo)
						updateCategoryCell_(prevComboRowInfo)
					end	
				end
				
				createInputLayer_(self, profileName)
			end

			activate_(self)
		end
	end
end

local function removeCommandDeviceCombos_(self)
	if self.activeColumn_ and self.activeRow_ then
		local deviceName = getColumnDeviceName_(self, self.activeColumn_)
		local rowInfo = getRowInfo_(self, self.activeRow_)
		local rowInfoCell = getRowInfoCell_(self, self.activeRow_, deviceName)

		if rowInfoCell then
			local command
			local isAxisCommands	= isAxisCommands_(self)
			local profileName		= self:getCurrentProfileName()
			
			if isAxisCommands then
				InputData.removeAxisCommandCombos(profileName, rowInfo.hash, deviceName)
				command = InputData.getProfileAxisCommand(profileName, rowInfo.hash)
			else
				InputData.removeKeyCommandCombos(profileName, rowInfo.hash, deviceName)
				command = InputData.getProfileKeyCommand(profileName, rowInfo.hash)
			end
			
			setRowInfoCommand(rowInfo, command)
			
			-- нужно поменять значение в ячейке self.activeColumn_ and self.activeRow_
			-- и обновить слой инпута
			updateActionCell_(rowInfo)
			updateCategoryCell_(rowInfo)
			updateActiveCell_(self)
			createInputLayer_(self, profileName)	
		end
	end
end

local function clearAll_(self, profileNames)
	local deviceNames = InputUtils.getDevices()
	
	for i, profileName in ipairs(profileNames) do
		InputData.clearProfile(profileName, deviceNames)
	end
	
	InputData.saveChanges()
	
	-- сбрасываем загруженные профили и заново загружаем текущий
	InputData.unloadProfiles()	
	self:setCurrentProfileName(self:getCurrentProfileName())
end

local function onClearAll_(self)
	local message			= string.format(cdata.confirmClearTotal)
	local handler			= MsgWindow.question(message, cdata.warning, cdata.yes, cdata.no)
	local checkListBox		= self.checkListBox
	local checkBoxCheckAll	= self.checkBoxCheckAll
	
	checkBoxCheckAll:setState(false)
	handler:addWidget(checkBoxCheckAll)
	
	local count = checkListBox:getItemCount()
	
	if count == 0 then
		local names = InputData.getProfileNames()
		
		table.sort(names, function(name1, name2)
			return textutil.Utf8Compare(name1, name2)
		end)
		
		local uiProfileName = InputData.getUiProfileName()
		
		for i, profileName in ipairs(names) do
			
			if profileName ~= uiProfileName then
				local item = checkListBox:newItem(profileName)
				
				item:setTooltipText(profileName)
				item.profileName = profileName
			end
		end
	else
		for i = 1, count do
			checkListBox:getItem(i - 1):setChecked(false)
		end
	end
	
	handler:addWidget(checkListBox)

	local view = self

	function handler:onChange(buttonText)
		if buttonText == cdata.yes then
			local profileNames	= {}
			local count			= checkListBox:getItemCount()
			
			for i = 1, count do
				local item = checkListBox:getItem(i - 1)
				
				if item:getChecked() then
					table.insert(profileNames, item.profileName)
				end
			end
			
			if #profileNames > 0 then
				clearAll_(view, profileNames)
			end
		end
	end
	
	deactivate_(self)

	handler:show()
	
	handler:removeWidget(checkBoxCheckAll)
	handler:removeWidget(checkListBox)

	activate_(self)
end

local function setDefaultCommandDeviceCombos_(self, rowInfo, rowIndex, profileName, deviceName)
	-- если комбо из дефолтной команды назначены в другие команды, 
	-- то их нужно оттуда удалить
	local isAxisCommands	= isAxisCommands_(self)
	local defaultCommand
	
	if isAxisCommands then
		defaultCommand = InputData.getDefaultAxisCommand(profileName, rowInfo.hash)
	else
		defaultCommand = InputData.getDefaultKeyCommand(profileName, rowInfo.hash)
	end
	
	local prevComboRowInfos = {}
	local combos = defaultCommand.combos[deviceName]
	
	if combos then 
		for i, combo in ipairs(combos) do
			local comboRowIndex, comboRowInfo = findComboRow_(self, combo, deviceName)
			
			if comboRowInfo then
				if comboRowInfo.hash ~= rowInfo.hash then
					table.insert(prevComboRowInfos, {rowIndex = comboRowIndex, rowInfo = comboRowInfo})
				end
			end
		end
	end
	
	local command
	
	if isAxisCommands then
		InputData.setDefaultAxisCommandCombos(profileName, rowInfo.hash, deviceName)
		command = InputData.getProfileAxisCommand(profileName, rowInfo.hash)
	else
		InputData.setDefaultKeyCommandCombos(profileName, rowInfo.hash, deviceName)
		command = InputData.getProfileKeyCommand(profileName, rowInfo.hash)
	end
	
	setRowInfoCommand(rowInfo, command)
	updateComboCell_(self, self.activeColumn_, rowIndex)
	updateActionCell_(rowInfo)
	
	for i, prevComboRowInfo in pairs(prevComboRowInfos) do
		local prevCommand
		
		if isAxisCommands then
			prevCommand = InputData.getProfileAxisCommand(profileName, prevComboRowInfo.rowInfo.hash)
		else
			prevCommand = InputData.getProfileKeyCommand(profileName, prevComboRowInfo.rowInfo.hash)
		end				
		
		setRowInfoCommand(prevComboRowInfo.rowInfo, prevCommand)
		
		if prevComboRowInfo.rowIndex then
			updateComboCell_(self, self.activeColumn_, prevComboRowInfo.rowIndex)
			updateActionCell_(prevComboRowInfo.rowInfo)
			updateCategoryCell_(prevComboRowInfo.rowInfo)
		end	
	end
end

local function onDefaultCommandDeviceCombos_(self)
	if self.activeColumn_ and self.activeRow_ then
		local deviceName	= getColumnDeviceName_(self, self.activeColumn_)
		local rowInfo		= getRowInfo_(self, self.activeRow_)
		local rowInfoCell	= rowInfo.cells[deviceName]
		
		if rowInfoCell then
			local profileName		= self:getCurrentProfileName()
			
			setDefaultCommandDeviceCombos_(self, rowInfo, self.activeRow_, profileName, deviceName)
			
			-- нужно поменять значение в ячейке self.activeColumn_ and self.activeRow_
			-- и обновить слой инпута
			updateActionCell_(rowInfo)
			updateCategoryCell_(rowInfo)
			updateActiveCell_(self)
			
			createInputLayer_(self, profileName)
		end
	end
end

local function processCurrentRowInfos(self, func)
	if self.currentRowInfoIndices_ then
		for i, rowInfoIndex in ipairs(self.currentRowInfoIndices_) do
			local rowInfo = self.currentRowInfos_[rowInfoIndex]
			
			func(rowInfo, i - 1)
		end
	else
		for i, rowInfo in ipairs(self.currentRowInfos_) do
			func(rowInfo, i - 1)
		end
	end
end

local function setModifiers_(self)
	deactivate_(self)
	
	local profileName = self:getCurrentProfileName()
	local modifiersDialog = ModifiersDialog.new()
	local modifiers = modifiersDialog:show(profileName)
	
	if modifiers then
		InputData.setProfileModifiers(profileName, modifiers)

		self:setCurrentProfileName(profileName)
	end
	
	modifiersDialog:kill()
	
	activate_(self)
end

local function tuneAxes_(self)
	if self.activeColumn_ and self.activeRow_ then
		local deviceName	= getColumnDeviceName_(self, self.activeColumn_)
		local rowInfo		= getRowInfo_(self, self.activeRow_)
		local rowInfoCell	= getRowInfoCell_(self, self.activeRow_, deviceName)
		
		if rowInfoCell then
			deactivate_(self)
			
			local axesTuneDialog = AxesTuneDialog.new()
			local filters = axesTuneDialog:show(rowInfoCell.combos, deviceName)
			
			if filters then
				local profileName = self:getCurrentProfileName()
				
				InputData.setAxisCommandComboFilter(profileName, rowInfo.hash, deviceName, filters)
				InputData.setAxisComboFilters(rowInfoCell.combos, filters)
				
				local command = InputData.getProfileAxisCommand(profileName, rowInfo.hash)
				
				setRowInfoCommand(rowInfo, command)
				
				-- нужно поменять значение в ячейке self.activeColumn_ and self.activeRow_
				-- и обновить слой инпута
				updateActiveCell_(self)
				createInputLayer_(self, profileName)
			end
			
			axesTuneDialog:kill()
			
			activate_(self)
		end
	end
end

local function tuneForceFeedback_(self)
	if self.activeColumn_ then
		local deviceName = getColumnDeviceName_(self, self.activeColumn_)
		local deviceTypeName = InputUtils.getDeviceTypeName(deviceName)
		
		if 'joystick' == deviceTypeName then
			local profileName = self:getCurrentProfileName()
			local settings = InputData.getProfileForceFeedbackSettings(profileName, deviceName)
			
			deactivate_(self)
			
			local forceFeedbackTuneDialog = ForceFeedbackTuneDialog.new()
			local result = forceFeedbackTuneDialog:show(settings)
			
			if result then
				InputData.setProfileForceFeedbackSettings(profileName, deviceName, result)
			end
			
			forceFeedbackTuneDialog:kill()
			
			activate_(self)
		end
	end
end

local function clearCategory_(self, deviceName)
	local isAxisCommands = isAxisCommands_(self)
	local profileName = self:getCurrentProfileName()
	
	processCurrentRowInfos(self, function(rowInfo, rowIndex)
		local command
		
		if isAxisCommands then
			InputData.removeAxisCommandCombos(profileName, rowInfo.hash, deviceName)
			command = InputData.getProfileAxisCommand(profileName, rowInfo.hash)
		else
			InputData.removeKeyCommandCombos(profileName, rowInfo.hash, deviceName)
			command = InputData.getProfileKeyCommand(profileName, rowInfo.hash)
		end
		
		setRowInfoCommand(rowInfo, command)
		
		updateActionCell_(rowInfo)
		updateCategoryCell_(rowInfo)
		updateComboCell_(self, self.activeColumn_, rowIndex)
	end)
	
	resetActiveColumnAndRow_(self)
	createInputLayer_(self, profileName)
end

local function onClearCategory_(self)
	if self.activeColumn_ then
		local deviceName = getColumnDeviceName_(self, self.activeColumn_)
		local category = getCurrentCategory_(self)
		local message
		
		if category then
			if category == cdata.searchCategory then
				message = string.format(cdata.confirmClearSearch, deviceName)
			else
				message = string.format(cdata.confirmClear, deviceName, category)
			end
		else
			message = string.format(cdata.confirmClearAll, deviceName)
		end

		local handler = MsgWindow.question(message, cdata.warning, cdata.yes, cdata.no)
		local view = self

		function handler:onChange(buttonText)
			if buttonText == cdata.yes then
				clearCategory_(view, deviceName)
			end
		end

		deactivate_(self)

		handler:show()

		activate_(self)
	end
end

local function setDefaultCategory_(self, deviceName)
	local profileName = self:getCurrentProfileName()
	local isAxisCommands = isAxisCommands_(self)
	
	if isAxisCommands_(self) then		
		processCurrentRowInfos(self, function(rowInfo, rowIndex)
			InputData.setDefaultAxisCommandCombos(profileName, rowInfo.hash, deviceName)
		end)
	else		
		processCurrentRowInfos(self, function(rowInfo, rowIndex)
			InputData.setDefaultKeyCommandCombos(profileName, rowInfo.hash, deviceName)
		end)
	end

	processCurrentRowInfos(self, function(rowInfo, rowIndex)
		setDefaultCommandDeviceCombos_(self, rowInfo, rowIndex, profileName, deviceName)
	end)

	resetActiveColumnAndRow_(self)
	createInputLayer_(self, profileName)
end

local function onDefaultCategory_(self)
	if self.activeColumn_ then
		local deviceName = getColumnDeviceName_(self, self.activeColumn_)
		local category = getCurrentCategory_(self)
		local message
		
		if category then
			if category == cdata.searchCategory then				
				message = string.format(cdata.confirmDefaultSearch, deviceName)
			else
				message = string.format(cdata.confirmDefault, deviceName, category)
			end
		else
			message = string.format(cdata.confirmDefaultAll, deviceName)
		end

		local handler = MsgWindow.question(message, cdata.warning, cdata.yes, cdata.no)
		local view = self

		function handler:onChange(buttonText)
			if buttonText == cdata.yes then
				setDefaultCategory_(view, deviceName)
			end
		end

		deactivate_(self)

		handler:show()

		activate_(self)
	end
end

local function makeHtml_(self)
	local folder = MakeLayoutText.makeHtml(self:getCurrentProfileName(), InputUtils.getDevices())
	
	if folder then
		os.execute(string.format('explorer %s', folder))
	end
end

local function setDeviceDisabled_(self, disabled)
	if self.activeColumn_ then
		local deviceName = getColumnDeviceName_(self, self.activeColumn_)
		
		InputData.setDeviceDisabled(deviceName, disabled)
		
		updateGrid			(self)
		selectColumnHeader_	(self, self.activeColumn_)
		enableButtons_		(self)
	end
end

local function loadDeviceProfile_(self)
	if self.activeColumn_ then
		local path = MeSettings.getOptionsPath()
		local filters = {FileDialogFilters.input(), FileDialogFilters.all()}
		
		deactivate_(self)
		
		local filename = FileDialog.open(path, filters, cdata.loadProfile, 'input')
		
		if filename then
			MeSettings.setOptionsPath(filename)
			
			local deviceName = getColumnDeviceName_(self, self.activeColumn_)
			local profileName = self:getCurrentProfileName()
			
			InputData.loadDeviceProfile(profileName, deviceName, filename)
			
			self:setCurrentProfileName(profileName)
		end
		
		activate_(self)
	end
end

local function saveDeviceProfile_(self)
	if self.activeColumn_ then
		local path = MeSettings.getOptionsPath()
		local filters = {FileDialogFilters.input(), FileDialogFilters.all()}
		
		deactivate_(self)
		
		local filename = FileDialog.save(path, filters, cdata.saveProfileAs, 'input')
		
		if filename then
			MeSettings.setOptionsPath(filename)
			
			local deviceName = getColumnDeviceName_(self, self.activeColumn_)
			local profileName = self:getCurrentProfileName()
			
			InputData.saveDeviceProfile(profileName, deviceName, filename)
		end
		
		activate_(self)
	end
end

local function loadContainerFromResources()
	local localization = {
		action						= _('Action'),
		category					= _('Category'),
		setDefault					= _('Set Default'),
		ok							= _('Ok'),
		saveDeviceProfile			= _("SAVE DEVICE PROFILE"),
		ffTune						= _("FF TUNE"),
		ffTune_menu					= _("menu-FF TUNE"),
		axisTune					= _("AXIS TUNE"),
		axisAssign					= _("AXIS ASSIGN"),
		layer						= _("Layer"),
		clear						= _("CLEAR"),
		default						= _("DEFAULT"),
		category					= _("Category"),
		clearCategory				= _("Clear category"),
		clearAll					= _("Clear all"),
		saveProfileAs				= _("Save profile as"),
		saveProfileAs_menu			= _("menu-Save profile as"),
		loadProfile					= _("Load profile"),
		loadProfile_menu			= _("menu-Load profile"),
		disabled					= _("Disabled"),
		disabled_menu				= _("menu-Disabled"),
		modifiers					= _("MODIFIERS"),
		add							= _("Add"),
		addCombo					= _("Add combo"),
		tuneComboAxis				= _("Tune combo axis"),
		clearCombo					= _("Clear combo"),
		resetComboToDefault			= _("Reset combo to default"),
		clearComboCategory			= _("Clear combo category"),
		resetCategoryToDefault		= _("Reset category to default"),
		clearAllCategories			= _('Clear all categories'),
		resetAllCategoriesToDefault	= _('Reset all categories to default'),		
		makeHtml					= _("MAKE HTML"),
		makeHtml_menu				= _("menu-MAKE HTML"),
		foldableView				= _('Foldable view'),
		checkAll					= _('Check all'),
		rescanDevices				= _('Rescan devices'),
		
	}
	
	cdata.disablePnpHint = string.format(cdata.disablePnpHint, localization.rescanDevices)
	
	local window	= DialogLoader.spawnDialogFromFile('./Scripts/Input/View.dlg', localization)
	local container	= window.containerMain.containerControls
	
	container.menu = window.menu
	container.menuDevice = window.menuDevice
	window.containerMain:removeWidget(container)
	window:removeWidget(window.menu)
	window:removeWidget(window.menuDevice)
	window:kill()
	
	return container
end

local function getContainer(self)
	return self.container_
end

local function construct(self, container, a_w, a_h)
	self.lastRowIndex_ 					= 0
	self.isInputActive_					= false
	
	self.keyRowInfos_					= {}
	self.axisRowInfos_					= {}
	
	local container = container or loadContainerFromResources()

	self.container_						= container
	self.menu_							= container.menu
	self.menuDevice_					= container.menuDevice
	
	-- будет использован в окне "Удалить всё"
	self.checkListBox					= container.checkListBox
	container:removeWidget(self.checkListBox)
	
	-- будет использован в окне "Удалить всё"
	self.checkBoxCheckAll				= container.checkBoxCheckAll
	container:removeWidget(self.checkBoxCheckAll)
	
	self.comboListProfiles_				= container.comboListAircraft
	self.comboListCategory_				= container.comboListCategory
	self.comboBoxCategory_				= container.comboBoxCategory
	
	-- если выбрана категория "Поиск", то поверх comboListCategory_ отображается comboBoxCategory_,
	-- в который можно вводить текст. Иначе comboBoxCategory_ скрывается.
	self.comboBoxCategory_:setBounds(self.comboListCategory_:getBounds())
	
	self.grid_							= container.scrollgrid
	self.checkBoxFoldableView_			= DialogLoader.findWidgetByName(container, "checkBoxFoldableView"		)
	self.buttonClear_					= DialogLoader.findWidgetByName(container, 'buttonClear'				)
	self.buttonClearAll_				= DialogLoader.findWidgetByName(container, 'buttonClearAll'				)
	self.buttonDefault_					= DialogLoader.findWidgetByName(container, 'buttonDefault'				)
	self.buttonAdd_						= DialogLoader.findWidgetByName(container, 'buttonAdd'					)
	self.buttonLoadProfile_				= DialogLoader.findWidgetByName(container, 'buttonLoadProfile'			)
	self.buttonSaveProfileAs_			= DialogLoader.findWidgetByName(container, 'buttonSaveProfileAs'		)
	self.buttonClearCategory_			= DialogLoader.findWidgetByName(container, 'buttonClearCategory'		)
	self.buttonSetDefaultCategory_		= DialogLoader.findWidgetByName(container, 'buttonSetDefaultCategory'	)
	self.buttonAxisTune_				= DialogLoader.findWidgetByName(container, 'buttonAxisTune'				)
	self.buttonFFTune_					= DialogLoader.findWidgetByName(container, 'buttonFFTune'				)
	self.toggleButtonDisablePnP_		= DialogLoader.findWidgetByName(container, 'toggleButtonDisablePnP'		)
	self.buttonRescanDevices_			= DialogLoader.findWidgetByName(container, 'buttonRescanDevices'		)
	self.buttonWizard_					= DialogLoader.findWidgetByName(container, 'buttonWizard'				)
	
	self.gridHeaderCell_				= container.gridHeaderCell
	self.gridHeaderCellSkin_			= container.gridHeaderCell			:getSkin()
	self.gridHeaderCellSelectedSkin_	= container.gridHeaderCellSelected	:getSkin()
	
	staticWidgetPool.validSelectedSkin					= container.staticCellValidSelected					:getSkin()
	staticWidgetPool.validNotSelectedSkin				= container.staticCellValidNotSelected				:getSkin()
	staticWidgetPool.invalidSelectedSkin				= container.staticCellInvalidSelected				:getSkin()
	staticWidgetPool.invalidNotSelectedSkin				= container.staticCellInvalidNotSelected			:getSkin()
	staticWidgetPool.noCommandSkin						= container.staticCellNoCommand						:getSkin()
	staticWidgetPool.duplicatedCommandSkin				= container.staticCellDuplicatedCommand				:getSkin()
	
	rangeIndicatorWidgetPool.validSelectedSkin			= container.rangeIndicatorCellValidSelected			:getSkin()
	rangeIndicatorWidgetPool.validNotSelectedSkin		= container.rangeIndicatorCellValidNotSelected		:getSkin()
	rangeIndicatorWidgetPool.invalidSelectedSkin		= container.rangeIndicatorCellInvalidSelected		:getSkin()
	rangeIndicatorWidgetPool.invalidNotSelectedSkin		= container.rangeIndicatorCellInvalidNotSelected	:getSkin()	
				
	container.panelRenameColumn.editBox:setTooltipText(_('Press Enter to confirm\nPress Esc to cancel\nClear text to restore'))

	rowHeight = self.grid_:getSkin().skinData.params.rowHeight
	
	self.container_:setSize(a_w, a_h)
	self.container_.panelTop:setSize(a_w-554, 28)	
	self.container_.panelBottom:setPosition((a_w-1223)/2, a_h-35)
	self.container_.staticDown:setBounds(0, a_h-40, a_w, 40)
	self.grid_:setBounds(0, 41, a_w, a_h-80)
	
	self.comboListProfiles_:addChangeCallback(function()
		local item = self.comboListProfiles_:getSelectedItem()
		
		if self:getCurrentProfileName() ~= item.profileName then
			self:setCurrentProfileName(item.profileName)
		end
	end)
	
	self.comboBoxCategory_:addChangeListBoxCallback(function()
		local item = self.comboBoxCategory_:getSelectedItem()
				
		setCurrentCategory_(self, item.category)
	end)
	
	self.comboListCategory_:addChangeCallback(function()
		local item = self.comboListCategory_:getSelectedItem()
				
		setCurrentCategory_(self, item.category)
	end)	
	
	self.comboBoxCategory_:addKeyDownCallback(function(comboBox, keyName, unicode)
		if 'return' == keyName or 'escape' == keyName then
			self.grid_:setFocused(true)
		end
	end)
	
	self.comboBoxCategory_:addChangeEditBoxCallback(function()
		updateCurrentCommands_(self, self:getCurrentProfileName())
		resetActiveColumnAndRow_(self)
	end)
	
	self.comboBoxCategory_:addFocusCallback(function()
		if self.comboBoxCategory_:getFocused() then
			deactivate_(self)
		else
			activate_(self)
		end
	end)
	
	self.grid_:addMouseDownCallback(function(grid, x, y, button)
		if 1 == button then	
			local columnIndex, rowIndex = grid:getMouseCursorColumnRow(x, y)

			if -1 < columnIndex and -1 < rowIndex then
				if columnIndex > categoryColumnIndex then
					local deviceName		= getColumnDeviceName_(self, columnIndex)
					local deviceDisabled	= getDeviceDisabled_(deviceName)
					
					if not deviceDisabled then
						selectCell_(self, columnIndex, rowIndex)
					end
				else	
					selectCell_(self, columnIndex, rowIndex)
				end	
			end
		end
	end)

	self.grid_:addMouseDoubleDownCallback(function(grid, x, y, button)
		if 1 == button then
			local columnIndex, rowIndex = grid:getMouseCursorColumnRow(x, y)

			if columnIndex > categoryColumnIndex and -1 < rowIndex then
				local deviceName		= getColumnDeviceName_(self, columnIndex)
				local deviceDisabled	= getDeviceDisabled_(deviceName)
					
				if not deviceDisabled then
					selectCell_(self, columnIndex, rowIndex)
					addCombo_(self)
				end
			end
		end
	end)
	
	self.grid_:addMouseUpCallback(function(grid, x, y, button)
		if 3 == button then
			local columnIndex, rowIndex = grid:getMouseCursorColumnRow(x, y)
			
			if -1 < columnIndex and -1 < rowIndex then
				selectCell_(self, columnIndex, rowIndex)
				showContextMenu_(self, x, y)
			end
		end
	end)
	
	self.grid_:addMouseWheelCallback(function(grid, x, y, clicks)
		self.menu_:setVisible(false)
	end)
	
	self.buttonClear_:addChangeCallback(function()
		removeCommandDeviceCombos_(self)
	end)
	
	self.buttonClearAll_:addChangeCallback(function()
		onClearAll_(self)
	end)
	
	self.buttonDefault_:addChangeCallback(function()
		onDefaultCommandDeviceCombos_(self)
	end)
	
	self.buttonAdd_:addChangeCallback(function()
		addCombo_(self)
	end)
	
	local buttonShowAxisCommands = DialogLoader.findWidgetByName(container, 'buttonShowAxisCommands')
	
	buttonShowAxisCommands:addChangeCallback(function()
		setCurrentCategory_(self, cdata.axisCommands)
	end)
	
	local buttonModifiers = DialogLoader.findWidgetByName(container, 'buttonModifiers')
	
	buttonModifiers:addChangeCallback(function()
		setModifiers_(self)
	end)
	
	self.buttonAxisTune_:addChangeCallback(function()
		tuneAxes_(self)
	end)
	
	self.buttonFFTune_:addChangeCallback(function()
		tuneForceFeedback_(self)
	end)
	
	self.buttonClearCategory_:addChangeCallback(function()
		onClearCategory_(self)
	end)
	
	self.buttonSetDefaultCategory_:addChangeCallback(function()
		onDefaultCategory_(self)
	end)
	
	local buttonMakeHtml = DialogLoader.findWidgetByName(container, 'buttonMakeHtml')
	
	buttonMakeHtml:addChangeCallback(function()
		makeHtml_(self)
	end)
	
	self.buttonLoadProfile_:addChangeCallback(function()
		loadDeviceProfile_(self)
	end)

	self.buttonSaveProfileAs_:addChangeCallback(function()
		saveDeviceProfile_(self)
	end)
	
	self.menu_:addChangeCallback(function()
		local item = self.menu_:getSelectedItem()
		
		if		item == self.menu_.menuItemAddCombo then
			addCombo_(self)
		elseif	item == self.menu_.menuItemTuneComboAxis then
			tuneAxes_(self)
		elseif	item == self.menu_.menuItemClearCombo then
			removeCommandDeviceCombos_(self)
		elseif	item == self.menu_.menuItemResetComboToDefault then
			onDefaultCommandDeviceCombos_(self)
		end
	end)
	
	self.menuDevice_:addChangeCallback(function()
		local item = self.menuDevice_:getSelectedItem()
		
		if		item == self.menuDevice_.menuItemClearCategory then
			onClearCategory_(self)
		elseif	item == self.menuDevice_.menuItemResetCategoryToDefault then
			onDefaultCategory_(self)
		elseif	item == self.menuDevice_.menuItemFFTune then
			tuneForceFeedback_(self)		
		elseif	item == self.menuDevice_.menuItemSaveProfileAs then
			saveDeviceProfile_(self)
		elseif	item == self.menuDevice_.menuItemLoadProfile then
			loadDeviceProfile_(self)
		elseif	item == self.menuDevice_.menuCheckItemDisabled then
			setDeviceDisabled_(self, self.menuDevice_.menuCheckItemDisabled:getState())
		elseif	item == self.menuDevice_.menuItemMakeHtml then
			makeHtml_(self)
		end
	end)
	
	fillComboListProfiles_(self)
	
	self.checkBoxFoldableView_:addChangeCallback(function()
		if self.switchToFoldableViewFunc_ then
			self.switchToFoldableViewFunc_()
		end	
	end)
	
	self.checkBoxCheckAll:addChangeCallback(function()
		local checked	= self.checkBoxCheckAll:getState()
		local count		= self.checkListBox:getItemCount()
		
		for i = 1, count do
			self.checkListBox:getItem(i - 1):setChecked(checked)
		end
	end)
	
	local pnpDisabled				= Input.getPnPDisabled()
	local toggleButtonDisablePnP	= self.toggleButtonDisablePnP_
	
	local updateToggleButtonDisablePnP = function()
		local pnpDisabled = toggleButtonDisablePnP:getState()
		
		if pnpDisabled then
			toggleButtonDisablePnP:setText(cdata.enablePnp)
			toggleButtonDisablePnP:setTooltipText(cdata.enablePnpHint)
		else
			toggleButtonDisablePnP:setText(cdata.disablePnp)
			toggleButtonDisablePnP:setTooltipText(cdata.disablePnpHint)
		end
		
		Input.setPnPDisabled(pnpDisabled)
	end
	
	toggleButtonDisablePnP:setState(pnpDisabled)
	
	updateToggleButtonDisablePnP()
	
	toggleButtonDisablePnP:addChangeCallback(function()
		updateToggleButtonDisablePnP()
	end)
	
	function self.buttonRescanDevices_:onChange()
		Input.rescanDevices()
	end
	
	self.buttonWizard_:addChangeCallback(function()
		deactivate_(self)
		
		require('Input.Wizard').show(getCurrentProfileName(self))
		
		activate_(self)
	end)
end

local function onDeviceChange(self, deviceName, plugged)
	-- какое-то устройство было подключено или отключено
	-- сохраним изменения и перезагрузим профили
	local changedProfileNames = {}
	
	for i, profileName in ipairs(InputData.getProfileNames()) do
		if InputData.getProfileChanged(profileName) then
			table.insert(changedProfileNames, profileName)
		end
	end
	
	if #changedProfileNames > 0 then
		local message = string.format(cdata.profilesChaned, table.concat(changedProfileNames, '\n'))
		local handler = MsgWindow.question(message, cdata.warning, cdata.yes, cdata.no)

		function handler:onChange(buttonText)
			if buttonText == cdata.yes then
				InputData.saveChanges()	
			end
		end

		deactivate_(self)

		handler:show()

		activate_(self)
	end
	
	-- сбрасываем загруженные профили и заново загружаем текущий
	InputData.unloadProfiles()	
	self:setCurrentProfileName(self:getCurrentProfileName())
end

local onDeviceChangeCallback

local function activate(self)
	self.checkBoxFoldableView_:setState(false)
	
	Gui.EnableHighSpeedUpdate(true)
	
	onDeviceChangeCallback = function(deviceName, plugged)
		onDeviceChange(self, deviceName, plugged)
	end
	
	Input.addDeviceChangeCallback(onDeviceChangeCallback)
	
	Input.activate(true)
	Input.ignoreUiLayer(true)
	Input.process()
	self.inputLayerStack_ = Input.getLayerStack()
	Input.clearLayerStack()
	activate_(self)
end

local function deactivate(self)
	Gui.EnableHighSpeedUpdate(false)
	
	Input.ignoreUiLayer(false)
	Input.removeDeviceChangeCallback(onDeviceChangeCallback)
	
	if self.inputLayerStack_ then
		Input.setLayerStack(self.inputLayerStack_)
		self.inputLayerStack_ = nil
	end	
	
	deactivate_(self)
end

local function getCurrentDeviceName(self)
	if self.activeColumn_ then
		return getColumnDeviceName_(self, self.activeColumn_)
	end	
end

local function setFoldableViewFunc(self, func)
	self.switchToFoldableViewFunc_ = func
end

local function selectCommand(self, commandHash, isAxis)
	self.grid_:selectRow(-1)
	
	if commandHash then
		if isAxis then
			setCurrentCategory_(self, cdata.axisCommands)
		else
			setCurrentCategory_(self, cdata.all)
		end
		
		for i, rowInfo in ipairs(self.currentRowInfos_) do
			if rowInfo.hash == commandHash then
				local rowIndex = i - 1
				
				self.grid_:selectRow	(rowIndex)
				self.grid_:setRowVisible(rowIndex)
				
				break
			end
		end
	end
end

return Factory.createClass({
	construct				= construct,
	getContainer			= getContainer,
	activate				= activate,
	deactivate				= deactivate,
	getCurrentProfileName	= getCurrentProfileName,
	setCurrentProfileName	= setCurrentProfileName,
	getCurrentDeviceName	= getCurrentDeviceName, -- используется в Utils/Input/CreateDefaultDeviceLayout.lua
	setFoldableViewFunc		= setFoldableViewFunc, -- функция переключения в foldable view
	selectCommand			= selectCommand,
})