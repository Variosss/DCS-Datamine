local DialogLoader		= require('DialogLoader')
local MsgWindow			= require('MsgWindow')
local ListBoxItem		= require('ListBoxItem')
local Serializer		= require('Serializer')
local UpdateManager		= require('UpdateManager')
local FileDialogFilters	= require('FileDialogFilters')
local FileDialogUtils	= require('FileDialogUtils')
local dxgui				= require('dxgui')
local gettext			= require('i_18n')
local lfs				= require('lfs')

local function _(text, dText) 
    local newText = gettext.translate(text)
	
    if newText == text and dText then
        return dText
    end
	
	return newText
end

local enableTest_
local window_
local virtualW_
local virtualH_
local monitors_
local panelView_
local panelVirtualScreen_
local panelMonitor_
local panelViewport_
local editBoxName_
local editBoxFilename_
local editBoxDescription_
local editBoxLua_
local comboBoxResolution_
local gridProperties_
local gridViewports_
local staticProperty_
local spinBoxProperty_
local checkBoxProperty_
local staticFilenameValid_
local staticFilenameInvalid_
local staticViewportInvalid_
local menuOpen_
local predefinedMenuOpen_
local menuItem_
local menuSeparatorItem_
local menuSubItemPredefined_
local menuItemPool_
local viewports_
local currViewport_
local propertyList_
local relativeValues_
local mouseResizeCursorPushed_
local gridRowHeight_ = 20
local newDocumentCounter_ = 1
local currFilenameWarningCallback_
local currViewportWarningCallback_
local userFolder_ = lfs.writedir() .. 'Config\\MonitorSetup\\'
local openedFilename_ 

-- mouse cursor shapes from \Projects\Visualizer\Include\MouseCursorShape.h
local MOUSE_CURSOR_ = {
	SIZE_ALL	= 37,
	SIZE_NESW	= 38,
	SIZE_NS		= 39,
	SIZE_NWSE	= 40,
	SIZE_WE		= 41,
}

local ResizeType = {
	NONE			= 0,
	LEFT			= 1,
	RIGHT			= 2,
	TOP				= 3,
	BOTTOM			= 4,
	LEFT_TOP		= 5,
	RIGHT_TOP		= 6,
	LEFT_BOTTOM		= 7,
	RIGHT_BOTTOM	= 8,
	DRAG			= 9,
}

local resizeInfo_ = {
	mouseDownPosition	= {},
	initialPosition		= {},
	initialSize			= {},
	type				= ResizeType.NONE,
}

local resizeCursors_ = {
	[ResizeType.LEFT			] = MOUSE_CURSOR_.SIZE_WE	,
	[ResizeType.RIGHT			] = MOUSE_CURSOR_.SIZE_WE	,
	[ResizeType.TOP				] = MOUSE_CURSOR_.SIZE_NS	,
	[ResizeType.BOTTOM			] = MOUSE_CURSOR_.SIZE_NS	,
	[ResizeType.LEFT_TOP		] = MOUSE_CURSOR_.SIZE_NWSE	,
	[ResizeType.RIGHT_TOP		] = MOUSE_CURSOR_.SIZE_NESW	,
	[ResizeType.LEFT_BOTTOM		] = MOUSE_CURSOR_.SIZE_NESW	,
	[ResizeType.RIGHT_BOTTOM	] = MOUSE_CURSOR_.SIZE_NWSE	,
	[ResizeType.DRAG			] = MOUSE_CURSOR_.SIZE_ALL	,
}

local function checkModified()
	for i, viewport in ipairs(viewports_) do
		for name, data in pairs(viewport.data) do
			if data.modified then
				return true
			end
		end
	end
	
	return false
end

local function resetModified()
	for i, viewport in ipairs(viewports_) do
		for name, data in pairs(viewport.data) do
			data.initialValue = data.value
			data.modified = false
		end
	end
end

local function getViewportIndex(viewport)
	for i, v in ipairs(viewports_) do
		if v == viewport then
			return i
		end	
	end
end

local function getViewportNameExists(name)
	for i, viewport in ipairs(viewports_) do
		if viewport.data.name.value == name then
			return true
		end
	end
end

local function createUpdateCallback(widget, appearDuration, showDuration, disappearDuration)
	local totalDuration	= appearDuration + showDuration + disappearDuration
	local startTime		= os.clock()
	
	dxgui.EnableHighSpeedUpdate(true)
	
	widget:setVisible	(true)
	widget:setOpacity	(0)	
	
	return function()
		local currTime = os.clock()
		local delta = currTime - startTime
		
		if delta > totalDuration then
			widget:setOpacity(1)
			widget:setVisible(false)
			
			dxgui.EnableHighSpeedUpdate(false)
			
			return true						
		end
		
		if delta < appearDuration then
			widget:setOpacity(delta / appearDuration)
		end
		
		if delta > appearDuration + showDuration then
			widget:setOpacity(1 - (delta - (appearDuration + showDuration)) / disappearDuration)
		end
	end
end

local function showFilenameWarning(widget)
	local appearDuration	= 0.3
	local showDuration		= 1
	local disappearDuration	= 1

	-- to avoid flickering on multiple call showFilenameWarning()
	UpdateManager.delete(currFilenameWarningCallback_)
	
	currFilenameWarningCallback_ = createUpdateCallback(widget, appearDuration, showDuration, disappearDuration)
	
	UpdateManager.add(currFilenameWarningCallback_)
end

local function showViewportWarning(widget)
	local appearDuration	= 0.3
	local showDuration		= 1
	local disappearDuration	= 1

	-- to avoid flickering on multiple call showFilenameWarning()
	UpdateManager.delete(currViewportWarningCallback_)
	
	currViewportWarningCallback_ = createUpdateCallback(widget, appearDuration, showDuration, disappearDuration)
	
	UpdateManager.add(currViewportWarningCallback_)
end


-- remove trailing and leading whitespace from string.
-- http://en.wikipedia.org/wiki/Trim_(8programming)
local function trim (text)
	-- from PiL2 20.4
	return (string.gsub(text, '^%s*(.-)%s*$', '%1'))
end

local function setSpinBoxRange(spinBox, relative)	
	if relative then
		spinBox:setFormatString('%.1f%%') -- добавляем знак % позади числа
		spinBox:setAcceptDecimalPoint(true)
		spinBox:setRange(-1000, 1000)
		spinBox:setStep(0.1)
		spinBox:setPageStep(1)
	else
		spinBox:setFormatString()
		spinBox:setAcceptDecimalPoint(false)
		spinBox:setRange(-100000, 100000)
		spinBox:setStep(1)
		spinBox:setPageStep(10)
	end
end

local function magiclines(s)
	-- from here: https://stackoverflow.com/a/19329565
	if s:sub(-1) ~= '\n' then 
		s = s .. '\n'
	end
        
	return s:gmatch('(.-)\n')
end

local function updateLua(prevName, newName)
	local strings = {}
	
	for line in magiclines(editBoxLua_:getText()) do
		local s1, s2 = string.match(line, '^%s*(.*)%s*=%s*(.*)%s*')
		
		if s1 and s2 then
			if s2 == prevName then
				s2 = newName
			end
			
			table.insert(strings, string.format('%s= %s', s1, s2))
		end
	end
	
	editBoxLua_:setText(table.concat(strings, '\n'))
end

local function createCameraNameString(name)
	if tonumber(name) then
		return 'Viewports[' .. name .. ']'
	else
		return 'Viewports[' .. string.format('%q', name) .. ']'
	end
end

local function placeWarningStatic(widget, static)
	-- widget - это виджет, к которому привязан static
	-- поскольку widget и static находятся в разных контейнерах,
	-- то позицию static нужно устанавливать через оконные координаты
	local w, h		= widget:getSize()
	local x, y		= widget:widgetToWindow(0, h)
	local dx, dy	= static:windowToWidget(x, y)
	local sx, sy 	= static:getPosition()
	
	static:setBounds(sx + dx, sy + dy, w, h)
end

local function showError(text, widget)

	placeWarningStatic(widget, staticViewportInvalid_)
	staticViewportInvalid_:setText(text)
	
	local w, h = staticViewportInvalid_:calcSize()
	
	staticViewportInvalid_:setSize(w, h)
	showViewportWarning(staticViewportInvalid_)
end

local function getMfdNameValid(name)
	local str = string.match(name, '[%a][%w_]*') -- первая буква и только английские буквы и цифры и подчеркивание
	local result = (str == name)
	
	if not result then
		showError(_('MFD name must contain english letters, numbers and _ only. Start with a letter.'), propertyList_[1].editBox)
	end
	
	return result
end

local function Property(key)
	return {
		key = key,

		Caption = function(self, text)
			self.caption = staticProperty_:clone()
			self.caption:setText(text)
			self.caption:setVisible(true)
			
			return self
		end,
		
		Number = function(self, relative)
			local spinBox = spinBoxProperty_:clone()
			
			spinBox:setVisible(true)
			
			setSpinBoxRange(spinBox, relative)
			
			spinBox:addChangeCallback(function()				
				if currViewport_ then
					local data = currViewport_.data[self.key]
					
					if data.relative then
						data:Change(spinBox:getValue() / 100)
					else
						data:Change(spinBox:getValue())
					end
					
					currViewport_:updateSize()
				end
			end)
			
			if relative then
				local relativeCheckBox = checkBoxProperty_:clone()

				relativeCheckBox:setVisible(true)
				relativeCheckBox:setState(relative)
				
				relativeCheckBox:addChangeCallback(function()
					if currViewport_ then
						local relative	= relativeCheckBox:getState()
						local data		= currViewport_.data[self.key]
						
						data.relative = relative
						
						setSpinBoxRange(spinBox, relative)
						
						if relative then
							-- data.value = math.floor((data.value / relativeValues_[data.relativeTo]) * 100 + 0.5)
							data:Change(data.value / relativeValues_[data.relativeTo])
							spinBox:setValue(data.value * 100)
						else
							-- data.value = math.floor((data.value / 100) * relativeValues_[data.relativeTo] + 0.5)
							data:Change(data.value * relativeValues_[data.relativeTo])
							spinBox:setValue(data.value)
						end
						
						currViewport_:updateSize()
					end
				end)

				self.relativeCheckBox = relativeCheckBox
			end
			
			self.spinBox = spinBox
			
			return self
		end,

		Text = function(self, text)
			local editBox = editBoxProperty_:clone()
			
			editBox:setVisible(true)
			editBox:setText(text)

			local onEditBoxChange = function()
				
				if editBox.changed then
					local text = trim(editBox:getText())
					
					if '' == text then
						showError(_('Viewport name cannot be empty!'), editBox)
						editBox:setText(currViewport_.data[self.key].value)
					else
						if currViewport_ then
							local data = currViewport_.data[self.key]
							
							if getViewportNameExists(text) and text ~= data.value then
								showError(string.format(_('Viewport name [%s] already exists!'), text), editBox)
								editBox:setText(currViewport_.data[self.key].value)
							else
								local valid = true
								local mfd	= currViewport_.data['mfd'].value
								
								if mfd then
									if not getMfdNameValid(text) then
										editBox:setText(currViewport_.data[self.key].value)
										
										valid = false
									end
								end
								
								if valid then
									if self.key == 'name' then
										if mfd then
											updateLua(data.value, text)
										else
											updateLua(createCameraNameString(data.value), createCameraNameString(text))
										end	
									end

									data:Change(text)
									currViewport_.widget:setText(text)
									editBox:setText(text)
									
									local i = getViewportIndex(currViewport_)
									
									gridViewports_:getCell(0, i - 1):setText(text)
								end
							end
						end
					end
					
					editBox.changed = false
				end
			end

			editBox:addChangeCallback(function()
				editBox.changed = true
			end)

			editBox:addKeyDownCallback(function(widget, keyName, unicode)
				if 'return' == keyName then
					onEditBoxChange()
				end
			end)

			editBox:addFocusCallback(function(widget)
				if not editBox:getFocused() then
					onEditBoxChange()
				end
			end)
			
			self.editBox = editBox

			return self
		end,
		
		Check = function(self)
			local checkBox = checkBoxProperty_:clone()

			checkBox:setVisible(true)
			
			checkBox:addChangeCallback(function()
				local value	= checkBox:getState()
				
				if value then
					local name	= currViewport_.data['name'].value
					
					if not getMfdNameValid(name) then
						checkBox:setState(false)
						
						return
					end
				end	
				
				if currViewport_ then
					local data = currViewport_.data[self.key]
					
					data:Change(checkBox:getState())
				end
			end)
			
			self.checkBox = checkBox
			
			return self
		end,
		
		SetData = function(self, data)
			if		data.type == 'text' then
				self.editBox:setText(data.value)
			elseif	data.type == 'check' then
				self.checkBox:setState(data.value)
			elseif	data.type == 'number' then
				if data.relativeTo then
					setSpinBoxRange(self.spinBox, data.relative)
					
					if data.relative then
						self.spinBox:setValue(data.value * 100)
						self.relativeCheckBox:setState(true)
					else
						self.spinBox:setValue(data.value)
						self.relativeCheckBox:setState(false)
					end
				else
					self.spinBox:setValue(data.value)
				end
			end
		end,
	}
end

local function NewData(type, value, relativeTo)
	return {
		type			= type,
		value			= value,
		initialValue	= value,
		relative		= relativeTo ~= nil,
		relativeTo		= relativeTo,
		modified		= false,
		Change			= function(self, newValue)
							self.value 		= newValue
							self.modified 	= (self.value ~= self.initialValue)
		end,
	}
end

local function changeValue(data, newValue)
	if data.relative then
		data:Change(newValue / relativeValues_[data.relativeTo])
	else
		data:Change(newValue)
	end
end

local function getAbsValue(data)
	if data.relative then
		return data.value * relativeValues_[data.relativeTo]
	else
		return data.value
	end
end

local function fillViewportInfo(viewport)
	local absX = getAbsValue(viewport.data.x)
	local absY = getAbsValue(viewport.data.y)
	local absW = getAbsValue(viewport.data.width)
	local absH = getAbsValue(viewport.data.height)
		
	viewport.widget.staticInfo:setText(string.format('x = %d\ny = %d\nw = %d\nh = %d', absX, absY, absW, absH))	
end

local function Viewport(name)
	return {
		data = {
			name	= NewData('text'	, name						),
			x		= NewData('number'	, 0		, 'screen.width'	),
			y		= NewData('number'	, 0		, 'screen.height'	),
			width	= NewData('number'	, 1		, 'screen.width'	),
			height	= NewData('number'	, 1		, 'screen.height'	),
			aspect	= NewData('number'	, 1		, 'screen.aspect'	),
			viewDx	= NewData('number'	, 0							),
			viewDy	= NewData('number'	, 0							),
			mfd		= NewData('check'	, false						),
		},
		
		widget	= panelViewport_:clone(),

		updateSize	= function(self)
			local panelX, panelY, panelW, panelH = panelVirtualScreen_:getBounds()
			
			local absX = getAbsValue(self.data.x)
			local absY = getAbsValue(self.data.y)
			local absW = getAbsValue(self.data.width)
			local absH = getAbsValue(self.data.height)
			
			local x = (absX	/ virtualW_) * panelW + panelX
			local y = (absY	/ virtualH_) * panelH + panelY
			local w = (absW	/ virtualW_) * panelW
			local h = (absH / virtualH_) * panelH
			
			self.widget:setBounds(x, y, w, h)
			
			fillViewportInfo(self)
		end,
	}
end

local function fillPropertiesGrid(viewport)
	if viewport then
		gridProperties_:setEnabled(true)
		
		for i, property in ipairs(propertyList_) do
			property:SetData(viewport.data[property.key])
		end
		
		fillViewportInfo(viewport)
	else
		gridProperties_:setEnabled(false)
	end
end

local function selectViewport(viewport)
	if viewport ~= currViewport_ then
		currViewport_ = viewport
		
		local rowIndex = getViewportIndex(viewport) - 1
		
		gridViewports_:selectRow	(rowIndex)
		gridViewports_:setRowVisible(rowIndex)
		
		fillPropertiesGrid(viewport)
	end
end

local function updateViewportData(viewport, changeX, changeY, changeW, changeH)
	local panelX, panelY, panelW, panelH = panelVirtualScreen_:getBounds()
	local x, y, w, h = viewport.widget:getBounds()

	if changeX then
		changeValue(viewport.data.x, math.floor(((x - panelX) / panelW) * virtualW_))
	end
	
	if changeY then
		changeValue(viewport.data.y, math.floor(((y - panelY) / panelH) * virtualH_))
	end
	
	if changeW then
		changeValue(viewport.data.width, math.floor((w / panelW) * virtualW_))
	end	
	
	if changeH then
		changeValue(viewport.data.height, math.floor((h / panelH) * virtualH_))
	end
	
	fillPropertiesGrid(viewport)
end

local function getResizeType(widget, cursorX, cursorY)
	local sx, sy	= widget:widgetToWindow(0, 0)
	local w, h		= widget:getSize()
	
	if cursorX < sx + 10 then
		-- left border
		if cursorY < sy + 10 then
			-- top border
			return ResizeType.LEFT_TOP
		end
		
		if cursorY > sy + h - 10 then
			-- bottom border
			return ResizeType.LEFT_BOTTOM
		end
		
		-- left border
		return ResizeType.LEFT
	end
	
	if cursorX > sx + w - 10 then
		-- right border
		if cursorY < sy + 10 then
			-- top border
			return ResizeType.RIGHT_TOP
		end
		
		if cursorY > sy + h - 10 then
			-- bottom border
			return ResizeType.RIGHT_BOTTOM
		end
		
		-- right border
		return ResizeType.RIGHT
	end
	
	if cursorY < sy + 10 then
		-- top border
		return ResizeType.TOP
	end
	
	if cursorY > sy + h - 10 then
		-- bottom border
		return ResizeType.BOTTOM
	end
		
	return ResizeType.DRAG
end

local function createViewportWidgetCallbacks(viewport)
	viewport.widget:addMouseDownCallback(function(self, x, y, button)
		if button == 1 then
			-- чтобы правильно работала потеря фокуса в editBox 
			-- свойства заполняем на следующкем кадре
			UpdateManager.add(function()
				selectViewport(viewport)
				
				resizeInfo_.mouseDownPosition.x,
				resizeInfo_.mouseDownPosition.y	= x, y
				
				resizeInfo_.initialPosition.x,
				resizeInfo_.initialPosition.y		= viewport.widget:getPosition()
				
				resizeInfo_.initialSize.x,
				resizeInfo_.initialSize.y			= viewport.widget:getSize()
				
				resizeInfo_.type					= getResizeType(self, x, y)
				
				viewport.widget:captureMouse()
				
				return true -- удаляем функцию из UpdateManager
			end)
		end
	end)
	
	viewport.widget:addMouseUpCallback(function(self, x, y, button)
		if button == 1 then
			resizeInfo_.type = ResizeType.NONE
			
			viewport.widget:releaseMouse()
		end
	end)
	
	viewport.widget:addMouseMoveCallback(function(self, x, y)
		local resizeType = resizeInfo_.type
		local changeX = false
		local changeY = false
		local changeW = false
		local changeH = false
		
		if resizeType > ResizeType.NONE then
			local dx = x - resizeInfo_.mouseDownPosition.x
			local dy = y - resizeInfo_.mouseDownPosition.y
			
			if 		resizeType == ResizeType.LEFT then
				self:setPosition(resizeInfo_.initialPosition.x + dx, resizeInfo_.initialPosition.y)
				self:setSize	(resizeInfo_.initialSize.x - dx, resizeInfo_.initialSize.y)
				changeX = true
				changeW = true
			elseif 	resizeType == ResizeType.RIGHT then
				self:setSize	(resizeInfo_.initialSize.x + dx, resizeInfo_.initialSize.y)
				changeW = true
			elseif 	resizeType == ResizeType.TOP then
				self:setPosition(resizeInfo_.initialPosition.x, resizeInfo_.initialPosition.y + dy)
				self:setSize	(resizeInfo_.initialSize.x, resizeInfo_.initialSize.y - dy	)
				changeY = true
				changeH = true
			elseif 	resizeType == ResizeType.BOTTOM then
				self:setSize	(resizeInfo_.initialSize.x, resizeInfo_.initialSize.y + dy)	
				changeH = true
			elseif 	resizeType == ResizeType.LEFT_TOP then
				self:setPosition(resizeInfo_.initialPosition.x + dx, resizeInfo_.initialPosition.y + dy)
				self:setSize	(resizeInfo_.initialSize.x - dx, resizeInfo_.initialSize.y - dy)
				changeX = true
				changeY = true
				changeW = true
				changeH = true
			elseif 	resizeType == ResizeType.RIGHT_TOP then
				self:setPosition(resizeInfo_.initialPosition.x, resizeInfo_.initialPosition.y + dy)
				self:setSize	(resizeInfo_.initialSize.x + dx, resizeInfo_.initialSize.y - dy)
				changeY = true
				changeW = true
				changeH = true				
			elseif 	resizeType == ResizeType.LEFT_BOTTOM then
				self:setPosition(resizeInfo_.initialPosition.x + dx, resizeInfo_.initialPosition.y)
				self:setSize	(resizeInfo_.initialSize.x - dx, resizeInfo_.initialSize.y + dy)
				changeX = true
				changeW = true
				changeH = true						
			elseif 	resizeType == ResizeType.RIGHT_BOTTOM then
				self:setSize	(resizeInfo_.initialSize.x + dx, resizeInfo_.initialSize.y + dy)
				changeW = true
				changeH = true					
			else
				self:setPosition(resizeInfo_.initialPosition.x + dx, resizeInfo_.initialPosition.y + dy)
				changeX = true
				changeY = true
			end
			
			updateViewportData(viewport, changeX, changeY, changeW, changeH)
		else
			if mouseResizeCursorPushed_ then
				local resizeType = getResizeType(self, x, y)
				local newCursor = resizeCursors_[resizeType]
				
				if newCursor ~= mouseResizeCursorPushed_ then
					window_:popMouseCursor()
					mouseResizeCursorPushed_ = newCursor
					window_:pushMouseCursor(mouseResizeCursorPushed_)
				end
			else
				local sx, sy	= self:widgetToWindow(0, 0)
				local w, h		= self:getSize()
				local resizeType = getResizeType(self, x, y)
				
				mouseResizeCursorPushed_ = resizeCursors_[resizeType]
				window_:pushMouseCursor(mouseResizeCursorPushed_)
			end	
		end
	end)

	viewport.widget:addMouseLeaveCallback(function()
		if mouseResizeCursorPushed_ then
			window_:popMouseCursor()
			mouseResizeCursorPushed_ = nil
		end
	end)
end

local function addViewport(name)
	local viewport = Viewport(name)
	
	viewport.widget:setVisible(true)
	viewport.widget:setText(name)
	panelView_:insertWidget(viewport.widget)
	viewport:updateSize()
	
	createViewportWidgetCallbacks(viewport)
	
	local cell = staticProperty_:clone()
	
	cell:setVisible(true)
	cell:setText(name)
	
	gridViewports_:insertRow(gridRowHeight_)
	gridViewports_:setCell(0, #viewports_, cell)	

	table.insert(viewports_, viewport)
	
	selectViewport(viewport)
	
	return viewport
end

local function removeViewport(name)
	for i, viewport in ipairs(viewports_) do
		if viewport.data.name.value == name then		
			viewport.widget:destroy()
			table.remove(viewports_, i)
			
			gridViewports_:clearRow(i - 1)
			
			break
		end
	end
end

local function clearViewports()
	if viewports_ then
		for i, viewport in ipairs(viewports_) do
			viewport.widget:destroy()
		end
		
		gridViewports_:clearRows()
	end
	
	viewports_			= {}
	currViewport_		= nil	
end

local function newDocument()
	clearViewports()
	
	editBoxFilename_	:setText('viewport' .. newDocumentCounter_ .. '.lua')
	editBoxName_		:setText('Viewport ' .. newDocumentCounter_)
	editBoxDescription_	:setText('New viewport')
	editBoxLua_			:setText()
	
	newDocumentCounter_ = newDocumentCounter_ + 1
	
	addViewport('Center')
	
	openedFilename_ = nil
end

local function openDocument(path)		
	if path then
		local func, err = loadfile(path)
		
		if func then
			-- FIXME: взять из настроек 
			-- local OptionsData = require('Options.Data')
			
			local env = {
				screen = {
					width	= 1280,			-- OptionsData.getGraphics('width'),
					height	= 800,			-- OptionsData.getGraphics('height'),		
					aspect	= 1280 / 800,	-- OptionsData.getGraphics('aspect'),
				}
			}
			
			setfenv(func, env)
			
			local res, err = pcall(func)
			
			if res then
				-- нужно понять значения в полях viewport абсолютные или относительные	
				-- заменим значения в таблице screen на какие-нибудь другие
				-- а потом сравним с исходной таблицей
				local env2 = {
					screen = {
						width	= -1,
						height	= -1,
						aspect	= -1,
					}
				}
				
				setfenv(func, env2)
				
				local res2, err2 = pcall(func)
				
				if res2 then
					clearViewports()
					
					editBoxFilename_	:setText(FileDialogUtils.extractFilenameFromPath(path))
					editBoxName_		:setText(env.name)
					editBoxDescription_	:setText(env.Description)
					
					local add = function(name, viewport, env2Tbl, mfd)
						local newViewport = addViewport(name)
						
						for key, value in pairs(viewport) do
							if newViewport.data[key] then
								newViewport.data[key].relative	= (value ~= env2Tbl[name][key])
								
								local data = newViewport.data[key]
								
								data.initialValue = value
								
								changeValue(data, value)
							end
						end
						
						local data = newViewport.data['mfd']
						
						data.initialValue = mfd
						
						changeValue(newViewport.data['mfd'], mfd)
						newViewport:updateSize()
						fillPropertiesGrid(newViewport)
					end
					
					local processedTables = {} -- чтобы избежать добавления ссылок на таблицы
					
					if env.Viewports then
						for name, viewport in pairs(env.Viewports) do
							processedTables[viewport] = createCameraNameString(name)
							
							add(name, viewport, env2.Viewports)
						end
					end
					
					-- сначала обрабатываем все таблицы у которых есть в названии _MFCD
					for name, value in pairs(env) do
						if type(value) == 'table' and string.match(name, '.*_MFCD') and not processedTables[value] then
							processedTables[value] = name
							
							if value.x and value.y and value.width and value.height then
								add(name, value, env2, true)
							end
						end
					end
					
					-- затем все остальные
					for name, value in pairs(env) do
						if type(value) == 'table' and not processedTables[value] then
							processedTables[value] = name
							
							if value.x and value.y and value.width and value.height then
								add(name, value, env2, true)
							end
						end
					end
					
					-- обрабатываем переменные, которые являются ссылками на таблицы
					local strings = {}
					
					for name, value in pairs(env) do
						local viewportName = processedTables[value]
						
						if viewportName and name ~= viewportName then
							table.insert(strings, string.format('%s = %s', name, viewportName))
						end
					end
					
					editBoxLua_:setText(table.concat(strings, '\n'))
					
					local viewport = viewports_[1]
					
					if viewport then
						selectViewport(viewport)
					end
					
					resetModified()
				else
					print(err2)
				end
			else
				print(err)
			end
		else
			print(err)
		end
	end
end

local function convertDataToString(data)
	if data.relativeTo then
		if data.relative then
			return string.format('%s * %f', data.relativeTo, data.value)
		end
	end
	
	return tostring(data.value)
end

local function viewportToString(viewport, tabs)
	local data = viewport.data
	local text = ''
			
	text = text .. '    x       = '	.. convertDataToString(data.x		) .. ',\n'
	text = text .. '    y       = '	.. convertDataToString(data.y		) .. ',\n'
	text = text .. '    width   = '	.. convertDataToString(data.width	) .. ',\n'
	text = text .. '    height  = '	.. convertDataToString(data.height	) .. ',\n'
	text = text .. '    viewDx  = '	.. convertDataToString(data.viewDx	) .. ',\n'
	text = text .. '    viewDy  = '	.. convertDataToString(data.viewDy	) .. ',\n'
	text = text .. '    aspect  = '	.. convertDataToString(data.aspect	) .. ',\n'
	
	return text
end

local function checkFilename()
	local result
	local text = trim(editBoxFilename_:getText())
			
	if text == '' then
		staticFilenameInvalid_:setText('File name cannot be empty!')
		showFilenameWarning(staticFilenameInvalid_)
	elseif FileDialogUtils.getFilenameContainsProhibitedSymbols(text) then
		staticFilenameInvalid_:setText('File name contains prohibited symbols!')
		showFilenameWarning(staticFilenameInvalid_)		
	else
		result = text
	end
	
	return result
end

local function saveDocument()
	local filename = checkFilename()
	
	if not filename then
		return false
	end
	
	local fullPath = userFolder_ .. filename
	
	-- защита от перезаписи
	if not openedFilename_ or openedFilename_ ~= fullPath then
		-- это новый файл
		local attr = lfs.attributes(fullPath)
		
		if attr then
			-- файл с таким именем уже существует
			local handler = MsgWindow.warning(	_('File already exists on disk, do you wish to overwrite file?'), 
												_('Warning'), 
												_('Yes'), 
												_('No'))
			 
			function handler:onChange(buttonText)
				if buttonText == _('No') then
					filename = nil
				end
			end

			handler:show()
		end
	end
	
	if not filename then
		return false
	end
	
	local result	= true
	local cameras	= {}
	local mfds		= {}
	
	for i, viewport in ipairs(viewports_) do
		local data = viewport.data
		
		if data.mfd.value then
			table.insert(mfds, {name = data.name.value, text = viewportToString(viewport)})
		else
			table.insert(cameras, {name = data.name.value, text = viewportToString(viewport)})
		end
	end
	
	lfs.mkdir(userFolder_)
	
	local file, err = io.open(fullPath, 'w')
	
	if file then
		local serializer = Serializer.new(file)
		
		file:write(string.format("name = '%s'\n", editBoxName_:getText()))
		file:write(string.format("Description = '%s'\n", editBoxDescription_:getText()))

		if #cameras > 0 then
			file:write('\nViewports = {}\n')
			
			for i, camera in ipairs(cameras) do
				file:write(createCameraNameString(camera.name) .. ' = {\n')
				file:write(camera.text)
				file:write('}\n')
			end
		end
		
		if #mfds > 0 then
			file:write('\n')
			
			for i, mfd in ipairs(mfds) do
				file:write(mfd.name .. ' = {\n')
				file:write(mfd.text)
				file:write('}\n')
			end
			
			file:write('\n')
		end
		
		file:write(editBoxLua_:getText())
		
		file:close()
		
		staticFilenameValid_:setText('Stored in ' .. fullPath)
		
		local w, h 		= staticFilenameValid_:calcSize()
		local ew, eh 	= editBoxFilename_:getSize()
		
		staticFilenameValid_:setSize(math.max(w, ew), eh)
		
		showFilenameWarning(staticFilenameValid_)
		openedFilename_ = fullPath
		resetModified()
	else
		MsgWindow.error(_('Unable to save file!\nError:') .. err, _('Error'), _('Ok')):show()
		result = false
	end

	return result
end

local function setPanelVirtualScreenBounds()
	local viewX, viewY, viewW, viewH = panelView_:getBounds()
	local panelW
	local panelH
	
	if virtualW_ > virtualH_ then
		panelW = viewW * 0.8
		
		local aspect = virtualH_ / virtualW_
		
		panelH = panelW * aspect
	else
		panelH = viewH * 0.8
		
		local aspect = virtualW_ / virtualH_
		
		panelW = panelH * aspect		
	end
	
	panelVirtualScreen_:setSize(panelW, panelH)
	panelView_:getLayout():updateSize()
	panelView_:setLayout()
end

local function placeMonitorPanels()
	local panelW, panelH = panelVirtualScreen_:getSize()
	
	for i, monitor in ipairs(monitors_) do
		local monitorW = monitor.x2 - monitor.x1
		local monitorH = monitor.y2 - monitor.y1
		
		local panel
		
		if i == 1 then
			panel = panelMonitor_
		else
			panel = panelMonitor_:clone()
			panelVirtualScreen_:insertWidget(panel)
		end
		
		panel.staticResolution:setText(monitorW .. 'x' .. monitorH)
		
		panel:setText(i)
		panel:setPosition	((monitor.x1	/ virtualW_) * panelW, (monitor.y1	/ virtualH_) * panelH)
		panel:setSize		((monitorW		/ virtualW_) * panelW, (monitorH	/ virtualH_) * panelH)
	end
end

local function initPropertiesGrid()
	propertyList_ = {
		Property('name'		):Caption(_('Name'		))	:Text('Center'	),
		Property('mfd'		):Caption('MFD'			)	:Check(false	),
		Property('x'		):Caption('X'			)	:Number(true	), 
		Property('y'		):Caption('Y'			)	:Number(true	), 	
		Property('width'	):Caption(_('Width'		))	:Number(true	), 
		Property('height'	):Caption(_('Height'	))	:Number(true	), 
		Property('viewDx'	):Caption(_('View Dx'	))	:Number(false	),
		Property('viewDy'	):Caption(_('View Dy'	))	:Number(false	),
		Property('aspect'	):Caption(_('Aspect'	))	:Number(true	),
	}
	
	for i, property in ipairs(propertyList_) do
		gridProperties_:insertRow(gridRowHeight_)
		gridProperties_:setCell(0, i - 1, property.caption)
		gridProperties_:setCell(1, i - 1, property.spinBox or property.editBox or property.checkBox)
		gridProperties_:setCell(2, i - 1, property.relativeCheckBox)
	end
end

local function normalizeMonitorCoords()
	-- у мониторов могут быть отрицательные координаты,
	-- в зависимости от того, какой монитор назначен первым в настройках Windows 
	-- и их взаимного расположения
	local minX = 1e06
	local minY = 1e06
	
	for i, monitor in ipairs(monitors_) do
		minX = math.min(minX, monitor.x1)
		minY = math.min(minY, monitor.y1)
	end	
	
	for i, monitor in ipairs(monitors_) do
		monitor.x1 = monitor.x1 - minX
		monitor.y1 = monitor.y1 - minY
		monitor.x2 = monitor.x2 - minX
		monitor.y2 = monitor.y2 - minY
	end		
end
	
local function saveChangesAndContinue()
	-- возвращает true если пользователь сохранил/отменил изменения
	-- и можно создать/открыть новый документ
	local result = true
	
	if checkModified() then
		local handler = MsgWindow.warning(_('Save changes?'), _('Warning'), _('Yes'), _('No'), _('Cancel'))
		 
		function handler:onChange(buttonText)
			if buttonText == _('Yes') then
				result = saveDocument()
			elseif buttonText == _('No') then
				result = true
			elseif buttonText == _('Cancel') then
				result = false
			end
		end

		handler:show()			
	end
	
	return result
end
	
local function fillOpenMenu()
	if not predefinedMenuOpen_ then
		predefinedMenuOpen_ = menuOpen_:clone()
		
		local predefinedDirName = './Config/MonitorSetup/'
		
		for file in lfs.dir(predefinedDirName) do 
			local fullNameFile  = predefinedDirName .. '/' .. file
			local attr = lfs.attributes(fullNameFile)
			
			if attr.mode == 'file' then
				local item = menuItem_:clone()
				
				item:setText(file)
				item.file = fullNameFile
				
				predefinedMenuOpen_:insertItem(item)
			end
		end
		
		menuOpen_:addChangeCallback(function()
			if saveChangesAndContinue() then	
				local filename = menuOpen_:getSelectedItem().file
				
				openDocument(filename)
				
				openedFilename_ = filename
			end	
		end)
		
		predefinedMenuOpen_:addChangeCallback(function()
			if saveChangesAndContinue() then
				openDocument(predefinedMenuOpen_:getSelectedItem().file)
				openedFilename_ = nil
			end	
		end)

		menuSubItemPredefined_:setSubmenu(predefinedMenuOpen_)
		
		menuItemPool_ = {}
	end
	
	menuOpen_:removeAllItems()
	
	local poolIndex = 1
	
	for file in lfs.dir(userFolder_) do 
		local fullNameFile  = userFolder_ .. '/' .. file
		local attr = lfs.attributes(fullNameFile)
		
		if attr.mode == 'file' then
			local item = menuItemPool_[poolIndex]
			
			if not item then
				item = menuItem_:clone()
				menuItemPool_[poolIndex] = item
			end
			
			item:setText(file)
			item.file = fullNameFile
			
			menuOpen_:insertItem(item)
			poolIndex = poolIndex + 1
		end
	end
	
	menuOpen_:insertItem(menuSeparatorItem_		)
	menuOpen_:insertItem(menuSubItemPredefined_	)
end

local function create()
	local localization = {
		new					= _('New'							),
		open				= _('Open'							),
		save				= _('Save'							),
		add					= _('Add'							),
		remove				= _('Remove'						),
		close				= _('Close window'					),
		property			= _('Property'						),
		value				= _('Value'							),
		viewport			= _('Viewport'						),
		predefined			= _('Predefined'					),
		viewportEditor		= _('Viewport Editor'				),
		fileName			= _('File name'						),
		name				= _('Name'						),
		description			= _('Description'					),
		additionalLuaCode	= _('Additional Lua code'			),
		resolution			= _('Resolution'					),
		openUserFolder		= _('Open user folder in Explorer'	),
	}
	
	window_					= DialogLoader.spawnDialogFromFile('Scripts/UI/ViewportEditor.dlg', localization)
	
	if enableTest_ then
		window_:setLockFlow(false)
	end
	
	-- center container inside window
	local containerMain 	= DialogLoader.findWidgetByName(window_, 'containerMain'			)
    local w, h 				= dxgui.GetWindowSize()  
    local cw, ch 			= containerMain:getSize()
	
    window_:setBounds(0, 0, w, h)
    containerMain:setPosition((w - cw) / 2, (h - ch) / 2)
	
	panelView_				= DialogLoader.findWidgetByName(window_, 'panelView'				)
	panelVirtualScreen_		= DialogLoader.findWidgetByName(window_, 'panelVirtualScreen'		)
	panelMonitor_			= DialogLoader.findWidgetByName(window_, 'panelMonitor'				)
	panelViewport_			= DialogLoader.findWidgetByName(window_, 'panelViewport'			)
	editBoxName_			= DialogLoader.findWidgetByName(window_, 'editBoxName'				)
	editBoxFilename_		= DialogLoader.findWidgetByName(window_, 'editBoxFilename'			)
	editBoxDescription_		= DialogLoader.findWidgetByName(window_, 'editBoxDescription'		)
	editBoxLua_				= DialogLoader.findWidgetByName(window_, 'editBoxLua'				)
	comboBoxResolution_		= DialogLoader.findWidgetByName(window_, 'comboBoxResolution'		)
	gridProperties_			= DialogLoader.findWidgetByName(window_, 'gridProperties'			)
	gridViewports_			= DialogLoader.findWidgetByName(window_, 'gridViewports'			)
	staticProperty_			= DialogLoader.findWidgetByName(window_, 'staticProperty'			)
	spinBoxProperty_		= DialogLoader.findWidgetByName(window_, 'spinBoxProperty'			)
	checkBoxProperty_		= DialogLoader.findWidgetByName(window_, 'checkBoxProperty'			)
	editBoxProperty_		= DialogLoader.findWidgetByName(window_, 'editBoxProperty'			)
	staticViewportInvalid_	= DialogLoader.findWidgetByName(window_, 'staticViewportInvalid'	)
	staticFilenameValid_	= DialogLoader.findWidgetByName(window_, 'staticFilenameValid'		)
	staticFilenameInvalid_	= DialogLoader.findWidgetByName(window_, 'staticFilenameInvalid'	)

	placeWarningStatic(editBoxFilename_, staticFilenameInvalid_)
	placeWarningStatic(editBoxFilename_, staticFilenameValid_)
	
	menuOpen_				= window_.menuOpen
	menuItem_ 				= DialogLoader.findWidgetByName(menuOpen_, 'menuItem'				)
	menuSeparatorItem_ 		= DialogLoader.findWidgetByName(menuOpen_, 'menuSeparatorItem'		)
	menuSubItemPredefined_	= DialogLoader.findWidgetByName(menuOpen_, 'menuSubItemPredefined'	)
	
	menuOpen_:removeAllItems()
	
	virtualW_, virtualH_ = dxgui.GetVirtualScreenSize()
	
	panelView_:setText(virtualW_ .. 'x' .. virtualH_)
		
	setPanelVirtualScreenBounds()
	
	monitors_ = dxgui.GetVirtualMonitors()
	
	normalizeMonitorCoords()
	placeMonitorPanels()
	
	initPropertiesGrid()
	
	local buttonClose = DialogLoader.findWidgetByName(window_, 'buttonClose')
	
	function buttonClose:onChange()
		if saveChangesAndContinue() then
			window_:close()
		end
	end
	
	local buttonNew = DialogLoader.findWidgetByName(window_, 'buttonNew')
	
	function buttonNew:onChange()
		if saveChangesAndContinue() then
			newDocument()
		end
	end
	
	local buttonOpen = DialogLoader.findWidgetByName(window_, 'buttonOpen')
	
	function buttonOpen:onChange()
		local w, h = buttonOpen:getSize()
		local x, y = buttonOpen:widgetToWindow(0, h)
		
		fillOpenMenu()	
		
		menuOpen_:setPosition(x, y)
		menuOpen_:setVisible(true)
	end	
	
	local buttonSave = DialogLoader.findWidgetByName(window_, 'buttonSave')
	
	buttonSave:setTooltipText(string.format(_('User files stored in %s'), lfs.writedir()))
	
	function buttonSave:onChange()
		saveDocument()
	end
	
	local buttonOpenFolder = DialogLoader.findWidgetByName(window_, 'buttonOpenFolder')
	
	function buttonOpenFolder:onChange()
		os.execute(string.format('explorer %s', userFolder_))
	end
	
	local buttonAddViewport = DialogLoader.findWidgetByName(window_, 'buttonAddViewport')
	local nameCounter = 0
	
	function buttonAddViewport:onChange()
		while true do
			nameCounter = nameCounter + 1
			local name = 'Viewport' .. nameCounter
			
			if not getViewportNameExists(name) then
				addViewport(name)
				
				break
			end
		end
	end
	
	local buttonRemoveViewport = DialogLoader.findWidgetByName(window_, 'buttonRemoveViewport')
	
	function buttonRemoveViewport:onChange()
		if currViewport_ and #viewports_ > 1 then 
			removeViewport(currViewport_.data.name.value)
			selectViewport(viewports_[1])
		end	
	end
	
	local gridMouseDownCallback = function(widget, x, y, button)
		if button == 1 then
			local column, row = gridViewports_:getMouseCursorColumnRow(x, y)
				
			if row > -1 then
				selectViewport(viewports_[row + 1])
			end
		end
	end
	
	gridViewports_:addMouseDownCallback			(gridMouseDownCallback)
	gridViewports_:addMouseDoubleDownCallback	(gridMouseDownCallback)
	
	for i, videoMode in ipairs(dxgui.GetVideoModes()) do
		local width		= videoMode[1]
		local height	= videoMode[2]
		local item		= ListBoxItem.new(width .. 'x' .. height)
		
		item.width		= width
		item.height		= height
		
		comboBoxResolution_:insertItem(item)
	end
	
	local parseResolutionString = function(text)
		-- ожидаем два целых числа, разделенных латинскими 'x' или 'X'
		local width, height = string.match(text, '(%d+)[xX](%d+)')
		local valuesAreValid = false
		
		if width and height then
			width = tonumber(width)
			height = tonumber(height)
			
			if width >= 1024 and height >= 768 then
				valuesAreValid = true
			end
		end
		
		return valuesAreValid, width, height
	end
	
	function comboBoxResolution_:onChangeListBox()
		local item = self:getSelectedItem()
		
		relativeValues_	= {
			['screen.width'	]	= item.width,
			['screen.height']	= item.height,
			['screen.aspect']	= item.width / item.height,
		}
		
		for i, viewport in ipairs(viewports_) do
			viewport:updateSize()
		end
	end
end

local function getCurrentGraphicsOptions()
	if enableTest_ then
		return 1280, 800, 1280 / 800
	end
	
	local OptionsData	= require('Options.Data')
	local width			= OptionsData.getGraphics('width'	)
	local height		= OptionsData.getGraphics('height'	)
	local aspect		= OptionsData.getGraphics('aspect'	)
	
	return width, height, aspect
end

local function show()
	if not window_ then
		create()
	end
	
	local width, height, aspect = getCurrentGraphicsOptions()
	
	relativeValues_	= {
		['screen.width'	] = width	,
		['screen.height'] = height	,
		['screen.aspect'] = aspect	,
	}
	
	comboBoxResolution_:setText(width .. 'x' .. height)
	newDocument()
	
	window_:setVisible(true)
end

local function enableTest()
	enableTest_ = true
	
	if window_ then
		window_:setLockFlow(false)
	end
end

return {
	show		= show,
	enableTest	= enableTest,
}
