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
	axisCommands			= _('Axis Commands'),
	ok						= _('Ok'),
	yes						= _('YES'),
	no						= _('NO'),
	warning					= _('WARNING'),
	confirmClearAll			= _('Are you sure you want to clear all assignments for device\n"%s?"'),
	confirmClear			= _('Are you sure you want to clear all assignments for device\n"%s"\nin category "%s"?'),
	confirmClearCategory	= _('Are you sure you want to clear all assignments in category "%s"?\nfor devices:\n'),
	confirmRestoreCategory	= _('Are you sure you want to restore all assignments in category "%s"?\nfor devices:\n'),
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
	commandsSearch			= _('Commands search'),
	
	disablePnp				= _('Disable hot plug'),
	enablePnp				= _('Enable hot plug'),
	disablePnpHint			= _('Press to deny automatic device detection.\nPress \'%s\' for manual detection.'),
	enablePnpHint			= _('Press to detect devices automatically'),
}

local commandColumnIndex_ 		= 0
local inputLayerName_			= 'InputOptionsView'
local axisRangeValue_			= 100
local panelCategoryCell_
local checkBox_
local lastComboHash_
local comboRowInfoCounter_
local rowHeight_
local modifiers_

local staticWidgetPool = {
	widgets = {},
}

local function getWidgetFromPool(widgetPool)
	local widget
	
	if #widgetPool.widgets == 0 then
		widget = widgetPool.createWidget()
		widget.pool = widgetPool
		
		function widget:returnToPool()
			widgetPool:returnWidget(self)
		end
	else
		widget = table.remove(widgetPool.widgets)
	end
	
	return widget
end

local function returnWidgetToPool(widgetPool, widget)
	table.insert(widgetPool.widgets, widget)
end

function staticWidgetPool:createWidget()
	return Static.new()
end

function staticWidgetPool:getWidget()
	return getWidgetFromPool(self)
end

function staticWidgetPool:returnWidget(widget)
	widget:setEnabled(true)
	returnWidgetToPool(self, widget)
end

local rangeIndicatorWidgetPool = {	
	widgets = {},
}

function rangeIndicatorWidgetPool:createWidget()
	local widget = HorzRangeIndicator.new()
	
	widget:setRange(-axisRangeValue_, axisRangeValue_)
	
	return widget
end

function rangeIndicatorWidgetPool:getWidget()
	getWidgetFromPool(self)
end

function rangeIndicatorWidgetPool:returnWidget(widget)
	returnWidgetToPool(self, widget)
end

local categoryWidgetPool = {
	widgets = {},
}

function categoryWidgetPool:createWidget()
	local widget = panelCategoryCell_:clone()
	
	widget:setVisible(true)
	
	return widget
end

function categoryWidgetPool:getWidget()
	getWidgetFromPool(self)
end

function categoryWidgetPool:returnWidget(widget)
	widget.toggleButton					:removeChangeCallback(widget.toggleButtonCallback)
	widget.buttonClearCategory			:removeChangeCallback(widget.buttonClearCategoryCallback)
	widget.buttonResetCategoryToDefault	:removeChangeCallback(widget.buttonResetCategoryToDefaultCallback)
	
	returnWidgetToPool(self, widget)
end

local function getColumnDeviceName(self, columnIndex)
	return self.deviceColumns_[columnIndex - commandColumnIndex_].deviceName
end

local function createDeviceColumns()
	-- первая колонка в таблице вставлена в редакторе
	local columns = {}
	local devices = InputUtils.getDevices()

	for i, deviceName in ipairs(devices) do
		table.insert(columns, {	deviceName = deviceName, 
								visibleName = MeSettings.getDeviceName(deviceName),
								width = 200})
	end
	
	return columns
end

local function getDeviceColumnIndex(self, deviceName)
	for i, deviceColumn in ipairs(self.deviceColumns_) do
		if deviceColumn.deviceName == deviceName then	
			return i + commandColumnIndex_
		end
	end
end

local function getHeaderCellSkin(self, selected)
	if selected then
		return self.gridHeaderCellSelectedSkin_
	else
		return self.gridHeaderCellSkin_
	end
end

local getDeviceDisabled = InputData.getDeviceDisabled

local function selectColumnHeader(self, columnIndex)
	local grid = self.grid_
	local columnCount = grid:getColumnCount()

	for i = 0, columnCount - 1 do 
		if i > commandColumnIndex_ then
			local headerCell		= grid:getColumnHeader(i)
			local deviceDisabled	= getDeviceDisabled(headerCell.deviceName)
			local selected			= (columnIndex == i) and not deviceDisabled

			headerCell:setSkin(getHeaderCellSkin(self, selected))
		end
	end
end

-- определены ниже
local activateInput
local deactivateInput
local selectCell

-- remove trailing and leading whitespace from string.
-- http://en.wikipedia.org/wiki/Trim_(8programming)
local trim = function(text)
	-- from PiL2 20.4
	return (string.gsub(text, '^%s*(.-)%s*$', '%1'))
end

local function setHeaderCellCallbacks(self, headerCell, column)
	local view = self
	
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
		deactivateInput(view)
		
		local handled = false
		
		local renameDevice = function(text)
			local text = trim(editBox:getText())
			
			if '' == text then
				text = headerCell.deviceName
			end
			
			MeSettings.setDeviceName(headerCell.deviceName, text)
			column.visibleName = text
			
			headerCell.static:setText(text)
			panel:setVisible(false)
			headerCell:setVisible(true)
			activateInput(view)
		end
		
		function editBox:onKeyDown(keyName, unicode)
			if keyName == 'return' then
				renameDevice(editBox:getText())
				handled = true
			elseif keyName == 'escape' then
				panel:setVisible(false)
				headerCell:setVisible(true)
				activateInput(view)
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
		selectCell(self, headerCell.columnIndex, -1)
	end)
	
	headerCell.button:addChangeCallback(function()	
		local w, h				= headerCell.button:getSize()
		local x, y				= headerCell.button:widgetToWindow(0, h)
		local deviceName		= headerCell.deviceName
		local deviceDisabled	= getDeviceDisabled(deviceName)
		
		local enableFFTune = ('joystick' == InputUtils.getDeviceTypeName(deviceName))
		
		if enableFFTune then
			local profileName	= self:getCurrentProfileName()
			local ffSettings	= InputData.getProfileForceFeedbackSettings(profileName, deviceName)
			
			if ffSettings then
				enableFFTune	= not ffSettings.ignore
			else	
				enableFFTune = false
			end
		end

		local menuDevice = self.menuDevice_
		
		menuDevice.menuCheckItemDisabled:setState(deviceDisabled)

		menuDevice.menuItemFFTune:setEnabled(enableFFTune and not deviceDisabled)

		menuDevice.menuItemClearAll			:setEnabled(not deviceDisabled)
		menuDevice.menuItemResetAll			:setEnabled(not deviceDisabled)
		menuDevice.menuItemSaveProfileAs	:setEnabled(not deviceDisabled)
		menuDevice.menuItemLoadProfile		:setEnabled(not deviceDisabled)
		menuDevice.menuItemMakeHtml			:setEnabled(not deviceDisabled)

		menuDevice:setPosition(x, y)
		menuDevice:setVisible(true)
	end)	
end

local function updateGridColumns(self)
	local grid = self.grid_
	local prevColumnWidths = {}
	
	-- удаляем все столбцы до первого
	for i = grid:getColumnCount(), commandColumnIndex_ + 2, -1 do
		local columnIndex = i - 1
		local headerCell = grid:getColumnHeader(columnIndex)
		
		prevColumnWidths[headerCell.deviceName] = grid:getColumnWidth(columnIndex)
		grid:clearColumn(columnIndex)
	end

	for i, column in ipairs(self.deviceColumns_) do
		local headerCell = self.gridHeaderCell_:clone()

		headerCell:setVisible(true)
		headerCell.static:setText(column.visibleName)
		headerCell.columnIndex = i
		headerCell.deviceName = column.deviceName
		headerCell.static:setTooltipText(column.deviceName)
		setHeaderCellCallbacks(self, headerCell, column)
		
		local columnWidth = prevColumnWidths[column.deviceName] or column.width
		
		grid:insertColumn(columnWidth, headerCell)
	end
end

local function fillComboListProfiles(self)
	local names = InputData.getProfileNames()
	
	table.sort(names, function(name1, name2)
		return textutil.Utf8Compare(name1, name2)
	end)
	
	local comboListProfiles	= self.comboListProfiles_
	local uiLayerName		= InputData.getUiProfileName()

	for i, profileName in ipairs(names) do
		local item = ListBoxItem.new(profileName)

		item.profileName = profileName
		
		if profileName == uiLayerName then
			comboListProfiles:insertItem(item, 0) -- uiLayer делаем первым
		else
			comboListProfiles:insertItem(item)
		end
	end
end

local function getCellSkin(widget, valid, selected, noCommand)
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

local function getCommandTooltipCodes(rowInfoCell)
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
	local deviceDisabled	= getDeviceDisabled(deviceName)
	
	widget:setEnabled(not rowInfoCell.disabled and not deviceDisabled)
	
	if rowInfoCell.text == '' and widget.isRangeIndicator then
		widget:setValueRange(0, 0)
	end
	
	widget:setText(rowInfoCell.text)
	widget:setTooltipText(string.format('%s%s', rowInfoCell.tooltip, getCommandTooltipCodes(rowInfoCell)))		
	
	setCellSkin(widget, getCellSkin(widget, rowInfoCell.valid, false, rowInfoCell.noCommand))
end

local function createComboCell(columnIndex, deviceName, rowInfo)
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

local function updateCategoryValid(self, rowInfo)
	local categoryName = rowInfo.category
	
	for i, category in ipairs(self.categories_) do
		if category.name == categoryName then
			local showWarning = false
			
			if rowInfo.valid then
				-- проверяем все команды категории
				for i, rowInfo in ipairs(category.rowInfos) do
					if not rowInfo.valid then
						showWarning = true
					
						break
					end
				end
			else
				-- если команда невалидная то категория невалидная
				showWarning = true
			end

			category.widget.staticWarning:setVisible(showWarning)
			
			break
		end
	end
end

local function updateCommandCell(rowInfo)
	local skin
	local widget = rowInfo.widgets[commandColumnIndex_]
	local tooltipText
	
	if rowInfo.nameDuplicated then
		skin = staticWidgetPool.duplicatedCommandSkin
		
		tooltipText = cdata.commandNamesDuplicated
		
		if rowInfo.nameHint ~= rowInfo.name then
			tooltipText = tooltipText .. '\n' .. rowInfo.nameHint
		end
	else
		skin = getCellSkin(widget, rowInfo.valid, false, false)
		
		tooltipText = rowInfo.nameHint
	end
	
	widget:setTooltipText(tooltipText)
	widget:setText(rowInfo.name)	
	setCellSkin(widget, skin)
end

local function createCommandCell(rowInfo)
	local widget = getWidgetFromPool(staticWidgetPool)
	
	rowInfo.widgets[commandColumnIndex_] = widget
	
	updateCommandCell(rowInfo)
	
	local w, h = widget:calcSize()
	
	if h > rowHeight_ then
		rowInfo.rowHeight = rowHeight_ * 2
	else
		rowInfo.rowHeight = rowHeight_
	end
end

local function createRowWidgets(self, rowInfo, rowIndex)
	rowInfo.widgets = {}
	
	createCommandCell(rowInfo)
	
	local devices = InputUtils.getDevices()
	
	for i, deviceName in ipairs(devices) do
		createComboCell(commandColumnIndex_ + i, deviceName, rowInfo)
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

local function createRowInfo(command, category, nameDuplicated)	
	local rowInfo = {
		hash				= command.hash,
		name				= command.name,
		name				= command.name,
		nameHint			= command.nameHint or command.name,
		category			= category,
		inSearchResults		= true,
		valid				= command.valid,
		cells				= {},
		isAxisCommand		= category == cdata.axisCommands,
		nameDuplicated		= nameDuplicated,
		rowIndex			= -1
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

local function getCommandNameIsDuplicated(commandIndex, commands)
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
	
	if isAxisCommands then
		for i, command in ipairs(commands) do
			local nameDuplicated = getCommandNameIsDuplicated(i, commands)
			
			table.insert(result, createRowInfo(command, cdata.axisCommands, nameDuplicated))
		end
	else
		for i, command in ipairs(commands) do
			local nameDuplicated = getCommandNameIsDuplicated(i, commands)
			
			if type(command.category) == 'table' then
				for j, categoryName in ipairs(command.category) do
					table.insert(result, createRowInfo(command, categoryName, nameDuplicated))	
				end
			else
				table.insert(result, createRowInfo(command, command.category, nameDuplicated))
			end	
		end	
	end
	
	createNoCommandRowInfos(result)

	return result
end

local function getCurrentProfileName(self)
	return self.currentProfileName_
end

local function findRowInfo(self, rowIndex)
	for i, category in ipairs(self.categories_) do	
		for j, rowInfo in ipairs(category.rowInfos) do
			if rowInfo.rowIndex == rowIndex then
				return rowInfo
			end
		end
	end
end

local function getRowInfoCell(self, rowIndex, deviceName)
	local rowInfo =  findRowInfo(self, rowIndex)
	
	return rowInfo.cells[deviceName]
end

local function getCellIsValid(self, columnIndex, rowInfo)
	local valid			= true
	local noCommand		= false

	if rowInfo then
		if commandColumnIndex_ == columnIndex then
			valid = rowInfo.valid
		else
			local deviceName = getColumnDeviceName(self, columnIndex)

			if deviceName then
				local rowInfoCell = rowInfo.cells[deviceName]
				
				valid		= rowInfoCell.valid
				noCommand	= rowInfoCell.noCommand
			end
		end
	end

	return valid, noCommand
end

local function updateComboCell(self, columnIndex, rowIndex)
	local rowInfo		= findRowInfo(self, rowIndex)
	local deviceName	= getColumnDeviceName(self, columnIndex)
	local widget		= rowInfo.widgets[columnIndex]
	
	setComboCell(widget, deviceName, rowInfo)
end

local function updateRowInfos(self, column, command)
	local hash = command.hash
	
	for i, category in ipairs(self.categories_) do	
		for j, rowInfo in ipairs(category.rowInfos) do
			if rowInfo.hash == hash then
				setRowInfoCommand(rowInfo, command)
				updateComboCell(self, column, rowInfo.rowIndex)
			end
		end
	end
end

local function collapseCategory(self, category)
	if category.expanded then
		local grid = self.grid_
		
		grid:setRowHeight(category.rowIndex, rowHeight_)
		
		for j, rowInfo in ipairs(category.rowInfos) do
			grid:setRowHeight(rowInfo.rowIndex, 0)
		end

		category.widget.toggleButton:setState(false)
		category.expanded = false
	end
end

local function expandCategory(self, category)
	if not category.expanded then
		local grid = self.grid_

		category.expanded = true
		
		local visible = false

		for i, rowInfo in ipairs(category.rowInfos) do
			if rowInfo.inSearchResults then
				grid:setRowHeight(rowInfo.rowIndex, rowInfo.rowHeight)
				visible = true
			end
		end
		
		if visible then
			grid:setRowHeight(category.rowIndex, rowHeight_)
		else
			grid:setRowHeight(category.rowIndex, 0)
		end
		
		category.widget.toggleButton:setState(true)
	end
end

local function updateSearchResults(self)
	local searchString = trim(self.editBoxSearch_:getText())
	
	if not searchString or '' == searchString then
		for i, category in ipairs(self.categories_) do
			collapseCategory(self, category)
			
			for i, rowInfo in ipairs(category.rowInfos) do
				rowInfo.inSearchResults = true
			end
			
			expandCategory(self, category)
		end
		
		self.panelSearch_:setText(cdata.commandsSearch)
	else
		local Utf8FindNoCase = textutil.Utf8FindNoCase
		
		for i, category in ipairs(self.categories_) do	
			collapseCategory(self, category)
			
			for i, rowInfo in ipairs(category.rowInfos) do
				rowInfo.inSearchResults = Utf8FindNoCase(rowInfo.name, searchString)
			end
			
			expandCategory(self, category)
		end
		
		self.panelSearch_:setText()
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

local function createKeyInputInfos(self, category)
	for i, rowInfo in ipairs(category.rowInfos) do
		for deviceName, rowInfoCell in pairs(rowInfo.cells) do
			local deviceId		= Input.getDeviceId(deviceName)
			local deviceColumn	= getDeviceColumnIndex(self, deviceName)
			
			for j, combo in ipairs(rowInfoCell.combos) do
				if combo.valid then
					local key = combo.key
					local comboHash = InputUtils.getComboHash(key, combo.reformers)
					
					if not InputUtils.getSkipDeviceEvent(key, deviceName) then
						local keyEvent = InputUtils.getInputEvent(key)
						local reformers = getComboReformers(combo.reformers)
						
						-- команда может входить в несколько категорий,
						-- соответственно строка с командой может повторяться в нескольких категориях
						-- если такое комбо уже присутствует в inputInfos_,
						-- то добавляем rowInfo в существующее inputInfo
						local found = false
						
						for k, inputInfo in ipairs(self.inputInfos_) do
							found = (inputInfo.comboHash == comboHash and inputInfo.deviceColumn == deviceColumn)
							
							if found then
								table.insert(inputInfo.rowInfos, rowInfo)
								
								break
							end
						end
						
						if not found then
							table.insert(self.inputInfos_, {comboHash			= comboHash,
															deviceColumn		= deviceColumn,
															rowInfos 			= {rowInfo},
															})
							
							local inputInfoIndex	= #self.inputInfos_
							
							-- для того, чтобы индексы не смешивались с командами симулятора 
							-- и с командами слоя для устройств VR сделаем их отрицательными
							local down				= -inputInfoIndex
							local pressed			= nil
							local up				= nil
							
							Input.addKeyCombo(inputLayerName_, keyEvent, deviceId, reformers, down, pressed, up)
						end
					end
				end
			end
		end
	end
end

local function createAxisInputInfos(self, category)
	local joystickDeviceTypeName = Input.getJoystickDeviceTypeName()
	
	for i, rowInfo in ipairs(category.rowInfos) do
		for deviceName, rowInfoCell in pairs(rowInfo.cells) do
			if joystickDeviceTypeName == InputUtils.getDeviceTypeName(deviceName)then 
				local deviceId		= Input.getDeviceId(deviceName)
				local deviceColumn	= getDeviceColumnIndex(self, deviceName)
				
				for j, combo in ipairs(rowInfoCell.combos) do
					if combo.valid then
						local axis = combo.key
						
						if not InputUtils.getSkipDeviceEvent(axis, deviceName) then
							local axisEvent = InputUtils.getInputEvent(axis)
							local reformers = getComboReformers(combo.reformers)
							local filter	= combo.filter
							
							table.insert(self.inputInfos_, { 	category		= category,
																rowInfo 		= rowInfo,
																deviceColumn	= deviceColumn,
																filter			= filter,})
							
							local inputInfoIndex	= #self.inputInfos_

							-- для того, чтобы индексы не смешивались с командами симулятора 
							-- и с командами слоя для устройств VR сделаем их отрицательными
							local action			= -inputInfoIndex
							
							Input.addAxisCombo(inputLayerName_, axisEvent, deviceId, reformers, action, filter)
						end
					end
				end
			end
		end
	end
end

local function createInputInfos(self)
	self.inputInfos_ = {}
	
	for i, category in ipairs(self.categories_) do
		if category.name == cdata.axisCommands then
			createAxisInputInfos(self, category)
		else
			createKeyInputInfos(self, category)
		end
	end
end

local function setInputModifiers()
	Input.clearReformers(inputLayerName_)
	
	for name, modifier in pairs(modifiers_) do
		local event = modifier.event

		if event then
			Input.addReformer(inputLayerName_, modifier.event, modifier.deviceId, modifier.switch)
		end
	end
end

local function createInputLayer(self, profileName)
	Input.deleteLayer(inputLayerName_)
	Input.createLayer(inputLayerName_)
	
	if self.isInputActive_ then
		Input.setTopLayer(inputLayerName_)
	end
	
	setInputModifiers()
	createInputInfos(self)
end

local function getCellComboEmpty(self, columnIndex, rowIndex)
	local deviceName = getColumnDeviceName(self, columnIndex)
	local rowInfoCell = getRowInfoCell(self, rowIndex, deviceName)
	
	if rowInfoCell then
		local combos = rowInfoCell.combos
		
		if combos then
			return #combos == 0
		end
	end
		
	return true
end

local function setCellInactive(self, columnIndex, rowIndex)
	if columnIndex and rowIndex then
		local cell				= self.grid_:getCell(columnIndex, rowIndex)
		local rowInfo			= findRowInfo(self, rowIndex)		
		local valid, noCommand	= getCellIsValid(self, columnIndex, rowInfo)
		local skin				= getCellSkin(cell, valid, false, noCommand)
		local deviceName		= getColumnDeviceName(self, columnIndex)
		local rowInfoCell		= getRowInfoCell(self, rowIndex, deviceName)
		local deviceDisabled	= getDeviceDisabled(deviceName)

		cell:setEnabled(not rowInfoCell.disabled and not deviceDisabled)
		setCellSkin(cell, skin)
		self.menu_:setVisible(false)
	end
end

local function setCellActive(self, columnIndex, rowIndex)
	self.activeColumn_	= nil
	self.activeRow_		= nil

	if columnIndex and rowIndex then
		if columnIndex > commandColumnIndex_ then
			self.activeColumn_ = columnIndex

			local cell = self.grid_:getCell(columnIndex, rowIndex)

			if cell then
				self.activeRow_ 		= rowIndex

				local rowInfo			= findRowInfo(self, rowIndex)
				local valid, noCommand	= getCellIsValid(self, columnIndex, rowInfo)
				local skin				= getCellSkin(cell, valid, true, noCommand)
				local deviceName		= getColumnDeviceName(self, columnIndex)
				local rowInfoCell		= getRowInfoCell(self, rowIndex, deviceName)
				local deviceDisabled	= getDeviceDisabled(deviceName)
				
				cell:setEnabled(not rowInfoCell.disabled and not deviceDisabled)
                
				setCellSkin(cell, skin)
			end
		end

		self.grid_:selectRow(rowIndex)
		selectColumnHeader(self, columnIndex)
	end
end

-- объявлена выше
function selectCell(self, columnIndex, rowIndex)
	if columnIndex and rowIndex then
		setCellInactive(self, self.activeColumn_, self.activeRow_)
		setCellActive(self, columnIndex, rowIndex)
	end
end

local function showContextMenu(self, x, y)
	if self.activeColumn_ and self.activeRow_ then
		local deviceName		= getColumnDeviceName(self, self.activeColumn_)
		local deviceDisabled	= getDeviceDisabled(deviceName)
		
		if not deviceDisabled then
			local rowInfo		= findRowInfo(self, self.activeRow_)		
			local rowInfoCell	= rowInfo.cells[deviceName]
			
			if rowInfoCell and not rowInfoCell.disabled and not rowInfoCell.noCommand then
				local enableAxisTuneItem = rowInfo.isAxisCommand and not getCellComboEmpty(self, self.activeColumn_, self.activeRow_)
				
				self.menu_.menuItemTuneComboAxis:setEnabled(enableAxisTuneItem)
				self.menu_:setPosition(x, y)
				self.menu_:setVisible(true)
			end
		end
	end
end

local function resetActiveColumnAndRow(self)
	setCellInactive(self, self.activeColumn_, self.activeRow_)
	setCellActive(self)

	selectColumnHeader(self)
	self.grid_:selectRow(-1)
	self.grid_:setVertScrollPosition(0)
end

local function createWidgets(self, rowInfos)	
	for i, rowInfo in ipairs(rowInfos) do
		createRowWidgets(self, rowInfo, i - 1)
	end
end

local function releaseWidgets(rowInfos)
	for i, rowInfo in ipairs(rowInfos) do
		for j, widget in pairs(rowInfo.widgets) do -- <<-- pairs!!!
			widget:returnToPool()
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

local function clearCategory(self, category, devices)
	local profileName		= self:getCurrentProfileName()
	
	for j, rowInfo in ipairs(category.rowInfos) do
		for i, deviceName in ipairs(devices) do
			local columnIndex = getDeviceColumnIndex(self, deviceName)
			local command
			
			if rowInfo.isAxisCommand then				
				InputData.removeAxisCommandCombos(profileName, rowInfo.hash, deviceName)
				command = InputData.getProfileAxisCommand(profileName, rowInfo.hash)
			else
				InputData.removeKeyCommandCombos(profileName, rowInfo.hash, deviceName)
				command = InputData.getProfileKeyCommand(profileName, rowInfo.hash)
			end
			
			setRowInfoCommand(rowInfo, command)
			updateComboCell(self, columnIndex, rowInfo.rowIndex)
		end
		
		updateCommandCell(rowInfo)
	end
	
	category.widget.staticWarning:setVisible(false)
	resetActiveColumnAndRow(self)
	createInputLayer(self, profileName)
end

local function onClearCategory(self, category)
	local message = string.format(cdata.confirmClearCategory, category.name)
	
	local handler = MsgWindow.question(message, cdata.warning, cdata.yes, cdata.no)
	local checkBoxes = {}
	
	for i, column in ipairs(self.deviceColumns_) do
		local checkBox = checkBox_:clone()
		
		checkBox:setVisible(true)
		checkBox:setText(column.visibleName)
		checkBox:setTooltipText(column.deviceName)
		checkBox.deviceName = column.deviceName
		
		table.insert(checkBoxes, checkBox)
		
		handler:addWidget(checkBox)
	end	

	local view = self

	function handler:onChange(buttonText)
		if buttonText == cdata.yes then
			local devices = {}
			
			for i, checkBox in ipairs(checkBoxes) do
				if checkBox:getState() then
					table.insert(devices, checkBox.deviceName)
				end
			end
			
			if #devices > 0 then
				clearCategory(view, category, devices)
			end
		end
	end
	
	deactivateInput(self)

	handler:show()

	activateInput(self)
end

local function clearAllCategories(self, deviceName)
	local profileName	= self:getCurrentProfileName()
	local columnIndex	= getDeviceColumnIndex(self, deviceName)
	
	for i, category in ipairs(self.categories_) do
		for j, rowInfo in ipairs(category.rowInfos) do
			local command
			
			if rowInfo.isAxisCommand then				
				InputData.removeAxisCommandCombos(profileName, rowInfo.hash, deviceName)
				command = InputData.getProfileAxisCommand(profileName, rowInfo.hash)
			else
				InputData.removeKeyCommandCombos(profileName, rowInfo.hash, deviceName)
				command = InputData.getProfileKeyCommand(profileName, rowInfo.hash)
			end
			
			setRowInfoCommand(rowInfo, command)
			updateCommandCell(rowInfo)			
			updateComboCell(self, columnIndex, rowInfo.rowIndex)
		end
		
		category.widget.staticWarning:setVisible(false)
	end
	
	resetActiveColumnAndRow(self)
	createInputLayer(self, profileName)
end

local function onClearAllCategories(self, deviceName)
	if self.activeColumn_ then
		local deviceName = getColumnDeviceName(self, self.activeColumn_)
		local message = string.format(cdata.confirmClearAll, deviceName)
		local handler = MsgWindow.question(message, cdata.warning, cdata.yes, cdata.no)
		
		local view = self

		function handler:onChange(buttonText)
			if buttonText == cdata.yes then
				clearAllCategories(view, deviceName)
			end
		end
		
		deactivateInput(self)

		handler:show()

		activateInput(self)
	end	
end

local function findComboRowInfo(self, combo, deviceName)
	local comboHash = InputUtils.getComboHash(combo.key, combo.reformers)
	
	for i, category in ipairs(self.categories_) do
		for j, rowInfo in ipairs(category.rowInfos) do
			local rowInfoCell = rowInfo.cells[deviceName]
		
			for k, rowCombo in ipairs(rowInfoCell.combos) do
				if comboHash == InputUtils.getComboHash(rowCombo.key, rowCombo.reformers) then
					return rowInfo
				end
			end
		end
	end
end

local function resetComboToDefault(self, rowInfo, profileName, deviceName)
	local deviceColumn = getDeviceColumnIndex(self, deviceName)

	-- если комбо из дефолтной команды назначены в другие команды, 
	-- то их нужно оттуда удалить
	local defaultCommand	
	
	if rowInfo.isAxisCommand then
		defaultCommand = InputData.getDefaultAxisCommand(profileName, rowInfo.hash)
	else
		defaultCommand = InputData.getDefaultKeyCommand(profileName, rowInfo.hash)
	end
	
	local prevComboRowInfos = {}
	local combos = defaultCommand.combos[deviceName]
	
	if combos then 
		for i, combo in ipairs(combos) do
			local comboRowInfo = findComboRowInfo(self, combo, deviceName)
			
			if comboRowInfo then
				if comboRowInfo.hash ~= rowInfo.hash then
					table.insert(prevComboRowInfos, comboRowInfo)
				end
			end
		end
	end
	
	local command
	
	if rowInfo.isAxisCommand then
		InputData.setDefaultAxisCommandCombos(profileName, rowInfo.hash, deviceName)
		command = InputData.getProfileAxisCommand(profileName, rowInfo.hash)
	else
		InputData.setDefaultKeyCommandCombos(profileName, rowInfo.hash, deviceName)
		command = InputData.getProfileKeyCommand(profileName, rowInfo.hash)
	end
	
	updateRowInfos(self, deviceColumn, command)
	updateCommandCell(rowInfo)
	updateCategoryValid(self, rowInfo)
	
	for i, prevComboRowInfo in ipairs(prevComboRowInfos) do
		local prevCommand
		
		if prevComboRowInfo.isAxisCommand then
			prevCommand = InputData.getProfileAxisCommand(profileName, prevComboRowInfo.hash)
		else
			prevCommand = InputData.getProfileKeyCommand(profileName, prevComboRowInfo.hash)
		end				
		
		updateRowInfos(self, deviceColumn, prevCommand)
		updateCommandCell(prevComboRowInfo)
		updateCategoryValid(self, prevComboRowInfo)
	end
end

local function resetAllCategories(self, deviceName)
	local profileName		= self:getCurrentProfileName()
	
	for i, category in ipairs(self.categories_) do		
		for i, rowInfo in ipairs(category.rowInfos) do
			resetComboToDefault(self, rowInfo, profileName, deviceName)
		end
	end	

	resetActiveColumnAndRow(self)
	createInputLayer(self, profileName)
end

local function onResetAllCategories(self)
	if self.activeColumn_ then
		local deviceName = getColumnDeviceName(self, self.activeColumn_)
		local message = string.format(cdata.confirmDefaultAll, deviceName)
		local handler = MsgWindow.question(message, cdata.warning, cdata.yes, cdata.no)
		
		local view = self

		function handler:onChange(buttonText)
			if buttonText == cdata.yes then
				resetAllCategories(view, deviceName)
			end
		end
		
		deactivateInput(self)

		handler:show()

		activateInput(self)
	end	
end

local function resetCategoryToDefault(self, category, devices)
	local profileName = self:getCurrentProfileName()
	
	for i, rowInfo in ipairs(category.rowInfos) do
		for j, deviceName in ipairs(devices) do
			resetComboToDefault(self, rowInfo, profileName, deviceName)
		end
	end

	resetActiveColumnAndRow(self)
	createInputLayer(self, profileName)
end

local function onResetCategoryToDefault(self, category)
	local message = string.format(cdata.confirmRestoreCategory, category.name)
	
	local handler = MsgWindow.question(message, cdata.warning, cdata.yes, cdata.no)
	local checkBoxes = {}
	
	for i, column in ipairs(self.deviceColumns_) do
		local checkBox = checkBox_:clone()
		
		checkBox:setVisible(true)
		checkBox:setText(column.visibleName)
		checkBox:setTooltipText(column.deviceName)
		checkBox.deviceName = column.deviceName
		
		table.insert(checkBoxes, checkBox)
		
		handler:addWidget(checkBox)
	end	

	local view = self

	function handler:onChange(buttonText)
		if buttonText == cdata.yes then
			local devices = {}
			
			for i, checkBox in ipairs(checkBoxes) do
				if checkBox:getState() then
					table.insert(devices, checkBox.deviceName)
				end
			end
			
			if #devices > 0 then
				resetCategoryToDefault(view, category, devices)
			end
		end
	end
	
	deactivateInput(self)

	handler:show()

	activateInput(self)
end

local function createCategoryWidget(self, category)
	local categoryPanel	= getWidgetFromPool(categoryWidgetPool)
	local toggleButton	= categoryPanel.toggleButton
	
	toggleButton:setState(false)
	
	toggleButton:setText(category.name)
	categoryPanel.toggleButtonCallback = function()			
		if toggleButton:getState() then
			expandCategory(self, category)
		else
			collapseCategory(self, category)
		end
	end
	
	toggleButton:addChangeCallback(categoryPanel.toggleButtonCallback)
	
	local buttonClearCategory = categoryPanel.buttonClearCategory
	
	categoryPanel.buttonClearCategoryCallback = function()
		onClearCategory(self, category)
	end
	
	buttonClearCategory:addChangeCallback(categoryPanel.buttonClearCategoryCallback)
	
	categoryPanel.buttonResetCategoryToDefaultCallback = function()
		onResetCategoryToDefault(self, category)
	end
	
	categoryPanel.buttonResetCategoryToDefault:addChangeCallback(categoryPanel.buttonResetCategoryToDefaultCallback)
	
	category.widget = categoryPanel
	
	return categoryPanel
end

local function fillGrid(self)
	local grid			= self.grid_
	local rowCounter	= 0
	
	for i, category in ipairs(self.categories_) do
		grid:insertRow(rowHeight_)

		local categoryPanel = createCategoryWidget(self, category)

		grid:setCell(commandColumnIndex_, rowCounter, categoryPanel)
		
		rowCounter = rowCounter + 1
		
		local categoryValid = true
		
		for j, rowInfo in ipairs(category.rowInfos) do
			updateCommandCell(rowInfo)
			
			categoryValid = categoryValid and rowInfo.valid
			
			for k, deviceColumn in ipairs(self.deviceColumns_) do
				local columnIndex 	= commandColumnIndex_ + k
				local widget		= rowInfo.widgets[columnIndex]
				
				setComboCell(widget, deviceColumn.deviceName, rowInfo)
			end
			
			grid:insertRow(0)
			
			for k, widget in pairs(rowInfo.widgets) do -- <<-- pairs!!!
				grid:setCell(k, rowCounter, widget)
			end
			
			rowCounter = rowCounter + 1
		end
		
		category.widget.staticWarning:setVisible(not categoryValid)
	end
--[[ растягивание столбцов девайсов		
	local columnsToStretch = {}

	for i, column in ipairs(self.deviceColumns_) do		
		table.insert(columnsToStretch, commandColumnIndex_ + i)
	end
	
	grid:stretchColumns(columnsToStretch)	]]
end

local function createProfileCategories(self, profileName)
	local categories = InputData.getProfileCategoryNames(profileName)

	table.sort(categories, function(category1, category2)
		return textutil.Utf8Compare(category1, category2)
	end)
	
	local rowCounter = 0
	
	self.categories_ = {}
	
	-- осевые команды вставляем в начало списка категорий
	if #self.axisRowInfos_ > 0 then
		table.insert(self.categories_, {name		= cdata.axisCommands,
										expanded	= false, 
										rowInfos	= self.axisRowInfos_,
										rowIndex 	= rowCounter})
		rowCounter = rowCounter + 1
		
		for j, axisRowInfo in ipairs(self.axisRowInfos_) do
			axisRowInfo.rowIndex = rowCounter
			rowCounter = rowCounter + 1
		end
	end								
	
	for i, name in ipairs(categories) do
		local rowInfos = {}
		
		table.insert(self.categories_, {name		= name, 
										expanded	= false, 
										rowInfos	= rowInfos,
										rowIndex 	= rowCounter})
		rowCounter = rowCounter + 1
		
		for j, keyRowInfo in ipairs(self.keyRowInfos_) do
			if name == keyRowInfo.category then
				keyRowInfo.rowIndex = rowCounter
				rowCounter = rowCounter + 1
				table.insert(rowInfos, keyRowInfo)
			end
		end		
	end
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

local function setCurrentProfileName(self, profileName)
	local count = self.comboListProfiles_:getItemCount()
	
	for i = 1, count do
		local item = self.comboListProfiles_:getItem(i - 1)
		
		if item.profileName == profileName then
			resetActiveColumnAndRow(self)
			
			-- возвращаем все виджеты в пул
			self.grid_:removeAllRows()

			releaseWidgets(self.axisRowInfos_)
			releaseWidgets(self.keyRowInfos_)
			
			for i, category in ipairs(self.categories_) do
				category.widget:returnToPool()
			end			
			
			self.axisRowInfos_	= {}
			self.keyRowInfos_	= {}
			
			-- количество устройств между запусками может измениться
			self.deviceColumns_ = createDeviceColumns()
			updateGridColumns(self)
			
			modifiers_ = InputData.getProfileModifiers(profileName)
		
			self.currentProfileName_ = profileName
			self.comboListProfiles_:selectItem(item)
			
			createKeyRowInfos(self, profileName)
			createWidgets(self, self.keyRowInfos_)			
			
			createAxisRowInfos(self, profileName)
			createWidgets(self, self.axisRowInfos_)

			createProfileCategories(self, profileName)
			fillGrid(self)
			
			createInputLayer(self, profileName)
			
			if profileName == InputData.getUiProfileName() then
				showUiProfileWarning(self)
			end
			
			break
		end
	end
end

local function processAxis(self, value, inputInfo)
	if self.categories_[1].expanded then
		local rowInfo = inputInfo.rowInfo
		
		if rowInfo and rowInfo.inSearchResults then
			local rangeIndicator = self.grid_:getCell(inputInfo.deviceColumn, rowInfo.rowIndex)
			
			if inputInfo.filter and inputInfo.filter.slider then
				if inputInfo.filter.invert then
					rangeIndicator:setValueRange(value * axisRangeValue_, axisRangeValue_)
				else
					rangeIndicator:setValueRange(-axisRangeValue_, value * axisRangeValue_)
				end
			else
				local valueMin		= math.min(0, value)
				local valueMax		= math.max(0, value)
				
				rangeIndicator:setValueRange(valueMin * axisRangeValue_, valueMax * axisRangeValue_)
			end
		end
	end
end

local function processKey(self, inputInfo)
	local result = false
	
	-- если несколько раз подряд нажимать комбинацию,
	-- то последовательно будут перебираться все команды во всех категориях
	if inputInfo.comboHash == lastComboHash_ then
		comboRowInfoCounter_ = comboRowInfoCounter_ + 1
	else
		lastComboHash_ = inputInfo.comboHash
		comboRowInfoCounter_ = 1
	end
	
	local rowInfo = inputInfo.rowInfos[comboRowInfoCounter_]
					
	if not rowInfo then
		comboRowInfoCounter_ = 1
		rowInfo = inputInfo.rowInfos[1]
	end
	
	if rowInfo.inSearchResults then
		for i, category in ipairs(self.categories_) do
			if category.name == rowInfo.category then
				expandCategory(self, category)
				
				break
			end
		end

		setCellInactive(self, self.activeColumn_, self.activeRow_)
		setCellActive(self, inputInfo.deviceColumn, rowInfo.rowIndex)
		
		self.grid_:setRowVisible(rowInfo.rowIndex)

		result = true
	end
	
	return result
end

local function onProcessInput(self)
	-- у нас есть еще все время включенный слой инпута для VR устройств
	-- сюда могут попадать команды от него
	local inputActions = Input.getInputActions()
	
	-- чтобы не дублировались кнопочные команды
	Input.clearInputActions()
	
	for i, inputAction in ipairs(inputActions) do
		local inputInfoIndex = inputAction.action
		
		if inputInfoIndex < 0 then
			local inputInfo = self.inputInfos_[-inputInfoIndex]
			
			-- эта проверка нужна поскольку при переключении самолета 
			-- сюда могут попадать команды джойстика от предыдущего самолета
			if inputInfo then 
				if inputAction.hasValue then
					processAxis(self, inputAction.value, inputInfo)
				else
					if processKey(self, inputInfo) then
						break
					end
				end
			end
		end
	end
end

-- объявлена выше
function activateInput(self)		
	Input.process()
	Input.setTopLayer(inputLayerName_)
		
	if not self.isInputActive_ then
		self.isInputActive_ = true		
		
		self.onProcessInputFunc_ = function()
			onProcessInput(self)
		end
		
		UpdateManager.add(self.onProcessInputFunc_)
	end
end

-- объявлена выше
function deactivateInput(self)	
	if self.isInputActive_ then
		self.isInputActive_ = false
		Input.removeLayerFromStack(inputLayerName_)
		UpdateManager.delete(self.onProcessInputFunc_)
		self.onProcessInputFunc_ = nil
	end
end

local function updateActiveCell(self)
	updateComboCell(self, self.activeColumn_, self.activeRow_)
	selectCell(self, self.activeColumn_, self.activeRow_)
end

local function addCombo(self)
	if self.activeColumn_ and self.activeRow_ then
		local deviceName = getColumnDeviceName(self, self.activeColumn_)
		local rowInfo = findRowInfo(self, self.activeRow_)
		local rowInfoCell = getRowInfoCell(self, self.activeRow_, deviceName)
		
		if rowInfoCell and not rowInfoCell.disabled and not rowInfoCell.noCommand then
			local profileName = self:getCurrentProfileName()

			deactivateInput(self)
			
			local addComboDialog	= self.addComboDialog_
			
			if not addComboDialog then
				addComboDialog			= AddComboDialog.new()
				self.addComboDialog_	= addComboDialog
			end
			
			local combo					= addComboDialog:show(rowInfo.name, rowInfo.isAxisCommand, deviceName, profileName)
			
			if combo then
				local command
				
				-- комбо могло принадлежать другой команде
				local prevComboCommand
				local prevComboRowInfo = findComboRowInfo(self, combo, deviceName)
				
				if rowInfo.isAxisCommand then
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

				updateRowInfos(self, self.activeColumn_, command)
				updateActiveCell(self)
				updateCommandCell(rowInfo)
				updateCategoryValid(self, rowInfo)

				if prevComboCommand then
					updateRowInfos(self, self.activeColumn_, prevComboCommand)
					updateCommandCell(prevComboRowInfo)
					updateCategoryValid(self, prevComboRowInfo)
				end
				
				createInputLayer(self, profileName)
			end

			activateInput(self)
		end
	end
end

local function removeCommandDeviceCombos(self)
	if self.activeColumn_ and self.activeRow_ then
		local deviceName	= getColumnDeviceName(self, self.activeColumn_)
		local rowInfo		= findRowInfo(self, self.activeRow_)
		local rowInfoCell	= getRowInfoCell(self, self.activeRow_, deviceName)

		if rowInfoCell then
			local command
			local profileName		= self:getCurrentProfileName()
			
			if rowInfo.isAxisCommand then
				InputData.removeAxisCommandCombos(profileName, rowInfo.hash, deviceName)
				command = InputData.getProfileAxisCommand(profileName, rowInfo.hash)
			else
				InputData.removeKeyCommandCombos(profileName, rowInfo.hash, deviceName)
				command = InputData.getProfileKeyCommand(profileName, rowInfo.hash)
			end
			
			updateRowInfos(self, self.activeColumn_, command)
			updateCommandCell(rowInfo)
			updateCategoryValid(self, rowInfo)
			
			-- нужно поменять значение в ячейке self.activeColumn_ and self.activeRow_
			-- и обновить слой инпута
			updateActiveCell(self)
			createInputLayer(self, profileName)	
		end
	end
end

local function onResetComboToDefault(self)
	if self.activeColumn_ and self.activeRow_ then
		local deviceName	= getColumnDeviceName(self, self.activeColumn_)
		local rowInfo		= findRowInfo(self, self.activeRow_)
		local rowInfoCell	= rowInfo.cells[deviceName]
		
		if rowInfoCell then
			local profileName		= self:getCurrentProfileName()
			
			resetComboToDefault(self, rowInfo, profileName, deviceName)
			
			-- нужно поменять значение в ячейке self.activeColumn_ and self.activeRow_
			-- и обновить слой инпута
			updateActiveCell(self)
			createInputLayer(self, profileName)
		end
	end
end

local function setModifiers(self)
	deactivateInput(self)
	
	local profileName = self:getCurrentProfileName()
	local modifiersDialog = ModifiersDialog.new()
	local modifiers = modifiersDialog:show(profileName)
	
	if modifiers then
		InputData.setProfileModifiers(profileName, modifiers)

		self:setCurrentProfileName(profileName)
	end
	
	modifiersDialog:kill()
	
	activateInput(self)
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

local function onClearAll(self)
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
		
		local uiLayerName = InputData.getUiProfileName()
		
		for i, profileName in ipairs(names) do
			
			if profileName ~= uiLayerName then
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
	
	deactivateInput(self)

	handler:show()
	
	handler:removeWidget(checkBoxCheckAll)
	handler:removeWidget(checkListBox)

	activateInput(self)
end

local function tuneAxes(self)
	if self.activeColumn_ and self.activeRow_ then
		local deviceName	= getColumnDeviceName(self, self.activeColumn_)
		local rowInfo		= findRowInfo(self, self.activeRow_)
		local rowInfoCell	= getRowInfoCell(self, self.activeRow_, deviceName)
		
		if rowInfoCell then
			deactivateInput(self)
			
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
				updateActiveCell(self)
				createInputLayer(self, profileName)
			end
			
			axesTuneDialog:kill()
			
			activateInput(self)
		end
	end
end

local function tuneForceFeedback(self)
	if self.activeColumn_ then
		local deviceName = getColumnDeviceName(self, self.activeColumn_)
		local deviceTypeName = InputUtils.getDeviceTypeName(deviceName)
		
		if 'joystick' == deviceTypeName then
			local profileName = self:getCurrentProfileName()
			local settings = InputData.getProfileForceFeedbackSettings(profileName, deviceName)
			
			deactivateInput(self)
			
			local forceFeedbackTuneDialog = ForceFeedbackTuneDialog.new()
			local result = forceFeedbackTuneDialog:show(settings)
			
			if result then
				InputData.setProfileForceFeedbackSettings(profileName, deviceName, result)
			end
			
			forceFeedbackTuneDialog:kill()
			
			activateInput(self)
		end
	end
end

local function makeHtml(self)
	local folder = MakeLayoutText.makeHtml(self:getCurrentProfileName(), InputUtils.getDevices())
	
	if folder then
		os.execute(string.format('explorer %s', folder))
	end
end

local function setDeviceDisabled(self, disabled)
	if self.activeColumn_ then
		local deviceName = getColumnDeviceName(self, self.activeColumn_)
		
		InputData.setDeviceDisabled(deviceName, disabled)
		
		for i, category in ipairs(self.categories_) do	
			for j, rowInfo in ipairs(category.rowInfos) do
				updateComboCell(self, self.activeColumn_, rowInfo.rowIndex)
			end
		end
		
		selectColumnHeader(self, self.activeColumn_)
	end
end

local function loadDeviceProfile(self)
	if self.activeColumn_ then
		local path = MeSettings.getOptionsPath()
		local filters = {FileDialogFilters.input(), FileDialogFilters.all()}
		
		deactivateInput(self)
		
		local filename = FileDialog.open(path, filters, cdata.loadProfile, 'input')
		
		if filename then
			MeSettings.setOptionsPath(filename)
			
			local deviceName = getColumnDeviceName(self, self.activeColumn_)
			local profileName = self:getCurrentProfileName()
			
			InputData.loadDeviceProfile(profileName, deviceName, filename)
			
			self:setCurrentProfileName(profileName)
		end
		
		activateInput(self)
	end
end

local function saveDeviceProfile(self)
	if self.activeColumn_ then
		local path = MeSettings.getOptionsPath()
		local filters = {FileDialogFilters.input(), FileDialogFilters.all()}
		
		deactivateInput(self)
		
		local filename = FileDialog.save(path, filters, cdata.saveProfileAs, 'input')
		
		if filename then
			MeSettings.setOptionsPath(filename)
			
			local deviceName = getColumnDeviceName(self, self.activeColumn_)
			local profileName = self:getCurrentProfileName()
			
			InputData.saveDeviceProfile(profileName, deviceName, filename)
		end
		
		activateInput(self)
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
		saveProfileAs				= _("Save profile as..."),
		saveProfileAs_menu			= _("menu-Save profile as..."),
		loadProfile					= _("Load profile..."),
		loadProfile_menu			= _("menu-Load profile..."),
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
		disabled					= _('Disabled'),
		disabled_menu				= _('menu-Disabled'),
		makeHtml					= _("MAKE HTML"),
		makeHtml_menu				= _("menu-MAKE HTML"),
		commandsSearch				= cdata.commandsSearch,
		foldableView				= _('Foldable view'),
		expandAllCategories			= _('Expand all categories'),
		collapseAllCategories		= _('Collapse all categories'),
		collapseAllCategories		= _('Collapse all categories'),
		rescanDevices				= _('Rescan devices'),
	}
	
	cdata.disablePnpHint = string.format(cdata.disablePnpHint, localization.rescanDevices)
	
	local window	= DialogLoader.spawnDialogFromFile('./Scripts/Input/FoldableView.dlg', localization)
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
	self.categories_					= {}
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
	self.panelSearch_					= DialogLoader.findWidgetByName(container, "panelSearch")
	self.editBoxSearch_					= DialogLoader.findWidgetByName(container, "editBoxSearch")
	
	self.grid_							= container.scrollgrid
	self.checkBoxFoldableView_			= DialogLoader.findWidgetByName(container, "checkBoxFoldableView")

	self.gridHeaderCell_				= container.gridHeaderCell
	self.gridHeaderCellSkin_			= container.gridHeaderCell			:getSkin()
	self.gridHeaderCellSelectedSkin_	= container.gridHeaderCellSelected	:getSkin()
	
	panelCategoryCell_					= container.panelCategory
	checkBox_							= container.checkBox
	
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

	rowHeight_ = self.grid_:getSkin().skinData.params.rowHeight
	
	self.container_:setBounds(0,0, a_w, a_h)	
	self.grid_:setBounds(0, 41, a_w, a_h-40)
	
	self.comboListProfiles_:addChangeCallback(function()
		local item = self.comboListProfiles_:getSelectedItem()
		
		if self:getCurrentProfileName() ~= item.profileName then
			self:setCurrentProfileName(item.profileName)
		end
	end)
		
	self.grid_:addMouseDownCallback(function(grid, x, y, button)
		if 1 == button then	
			local columnIndex, rowIndex = grid:getMouseCursorColumnRow(x, y)

			if -1 < columnIndex and -1 < rowIndex then
				if columnIndex > commandColumnIndex_ then
					local deviceName		= getColumnDeviceName(self, columnIndex)
					local deviceDisabled	= getDeviceDisabled(deviceName)
					
					if not deviceDisabled then
						selectCell(self, columnIndex, rowIndex)
					end
				else
					selectCell(self, columnIndex, rowIndex)
				end
			end
		end
	end)

	self.grid_:addMouseDoubleDownCallback(function(grid, x, y, button)
		if 1 == button then
			local columnIndex, rowIndex = grid:getMouseCursorColumnRow(x, y)

			if commandColumnIndex_ < columnIndex and -1 < rowIndex then
				local deviceName		= getColumnDeviceName(self, columnIndex)
				local deviceDisabled	= getDeviceDisabled(deviceName)
				
				if not deviceDisabled then
					selectCell(self, columnIndex, rowIndex)
					addCombo(self)
				end
			end
		end
	end)
	
	self.grid_:addMouseUpCallback(function(grid, x, y, button)
		if 3 == button then
			local columnIndex, rowIndex = grid:getMouseCursorColumnRow(x, y)
			
			if -1 < columnIndex and -1 < rowIndex then
				selectCell(self, columnIndex, rowIndex)
				showContextMenu(self, x, y)
			end
		end
	end)
	
	self.grid_:addMouseWheelCallback(function(grid, x, y, clicks)
		self.menu_:setVisible(false)
	end)
	
	local buttonClearSearch = DialogLoader.findWidgetByName(container, "buttonClearSearch")
	
	buttonClearSearch:addChangeCallback(function()
		self.editBoxSearch_:setText()
		updateSearchResults(self)
		self.grid_:setFocused(true)
	end)
	
	self.editBoxSearch_:addKeyDownCallback(function(comboBox, keyName, unicode)
		if 'return' == keyName or 'escape' == keyName then
			self.grid_:setFocused(true)
		end
	end)
	
	self.editBoxSearch_:addChangeCallback(function()
		resetActiveColumnAndRow(self)
		updateSearchResults(self)
	end)
	
	self.editBoxSearch_:addFocusCallback(function()
		if self.editBoxSearch_:getFocused() then
			deactivateInput(self)
		else
			activateInput(self)
		end
	end)
	
	container.buttonModifiers:addChangeCallback(function()
		setModifiers(self)
	end)
	
	container.buttonClearAll:addChangeCallback(function()
		onClearAll(self)
	end)
	
	self.checkBoxCheckAll:addChangeCallback(function()
		local checked	= self.checkBoxCheckAll:getState()
		local count		= self.checkListBox:getItemCount()
		
		for i = 1, count do
			self.checkListBox:getItem(i - 1):setChecked(checked)
		end
	end)
	
	local pnpDisabled = Input.getPnPDisabled()
	local toggleButtonDisablePnP = container.toggleButtonDisablePnP
	
	local updateToggleButtonDisablePnP = function()
		local pnpDisabled	= toggleButtonDisablePnP:getState()
		
		if pnpDisabled then
			toggleButtonDisablePnP:setText			(cdata.enablePnp		)
			toggleButtonDisablePnP:setTooltipText	(cdata.enablePnpHint	)
		else
			toggleButtonDisablePnP:setText			(cdata.disablePnp		)
			toggleButtonDisablePnP:setTooltipText	(cdata.disablePnpHint	)
		end
		
		Input.setPnPDisabled(pnpDisabled)
	end
	
	toggleButtonDisablePnP:setState(pnpDisabled)
	updateToggleButtonDisablePnP()
	
	toggleButtonDisablePnP:addChangeCallback(function()
		updateToggleButtonDisablePnP()
	end)
	
	function container.buttonRescanDevices:onChange()
		Input.rescanDevices()
	end
	
	self.menu_:addChangeCallback(function()
		local item = self.menu_:getSelectedItem()
		
		if		item == self.menu_.menuItemAddCombo then
			addCombo(self)
		elseif	item == self.menu_.menuItemTuneComboAxis then
			tuneAxes(self)
		elseif	item == self.menu_.menuItemClearCombo then
			removeCommandDeviceCombos(self)
		elseif	item == self.menu_.menuItemResetComboToDefault then
			onResetComboToDefault(self)
		end
	end)
	
	self.menuDevice_:addChangeCallback(function()
		local item = self.menuDevice_:getSelectedItem()
		
		if		item == self.menuDevice_.menuItemFFTune then
			tuneForceFeedback(self)		
		elseif	item == self.menuDevice_.menuItemSaveProfileAs then
			saveDeviceProfile(self)	
		elseif	item == self.menuDevice_.menuItemClearAll then
			onClearAllCategories(self)
		elseif	item == self.menuDevice_.menuItemResetAll then
			onResetAllCategories(self)	
		elseif	item == self.menuDevice_.menuItemLoadProfile then
			loadDeviceProfile(self)
		elseif	item == self.menuDevice_.menuCheckItemDisabled then
			setDeviceDisabled(self, self.menuDevice_.menuCheckItemDisabled:getState())
		elseif	item == self.menuDevice_.menuItemMakeHtml then
			makeHtml(self)
		end
	end)
	
	local buttonCollapseAll = DialogLoader.findWidgetByName(container, "buttonCollapseAll")
	
	buttonCollapseAll:addChangeCallback(function()
		resetActiveColumnAndRow(self)
		
		for i, category in ipairs(self.categories_) do
			collapseCategory(self, category)
		end
		
		buttonCollapseAll:setFocused(false)
	end)
	
	local buttonExpandAll = DialogLoader.findWidgetByName(container, "buttonExpandAll")
	
	buttonExpandAll:addChangeCallback(function()
		resetActiveColumnAndRow(self)
		
		for i, category in ipairs(self.categories_) do
			expandCategory(self, category)
		end

		buttonExpandAll:setFocused(false)
	end)
	
	fillComboListProfiles(self)
	
	self.checkBoxFoldableView_:addChangeCallback(function()
		if self.switchToClassicViewFunc then
			self.switchToClassicViewFunc()
		end	
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

		deactivateInput(self)

		handler:show()

		activateInput(self)
	end
	
	-- сбрасываем загруженные профили и заново загружаем текущий
	InputData.unloadProfiles()	
	self:setCurrentProfileName(self:getCurrentProfileName())
end

local onDeviceChangeCallback

local function activate(self)
	self.checkBoxFoldableView_:setState(true)
	
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
	activateInput(self)
end

local function deactivate(self)
	Gui.EnableHighSpeedUpdate(false)
	
	Input.ignoreUiLayer(false)
	Input.removeDeviceChangeCallback(onDeviceChangeCallback)
	
	if self.inputLayerStack_ then
		Input.setLayerStack(self.inputLayerStack_)
		self.inputLayerStack_ = nil
	end	
	
	deactivateInput(self)
end

local function getCurrentDeviceName(self)
	if self.activeColumn_ then
		return getColumnDeviceName(self, self.activeColumn_)
	end	
end

local function setClassicViewFunc(self, func)
	self.switchToClassicViewFunc = func
end

local function selectCommand(self, commandHash, isAxis)
	for i, category in ipairs(self.categories_) do
		for j, rowInfo in ipairs(category.rowInfos) do
			if rowInfo.hash == commandHash then
				expandCategory(self, category)
				
				self.grid_:selectRow	(rowInfo.rowIndex)
				self.grid_:setRowVisible(rowInfo.rowIndex)
				
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
	setClassicViewFunc		= setClassicViewFunc, -- функция переключения в foldable view
	selectCommand			= selectCommand,
})	