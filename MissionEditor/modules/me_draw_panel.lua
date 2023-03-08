local DialogLoader	= require('DialogLoader')
local MapWindow 	= require('me_map_window')
local ColorSelector	= require('me_select_color')
local IconSelector	= require('me_select_icon')
local OptionsData	= require('Options.Data')
local toolbar 		= require('me_toolbar')
local BuddyWindow 	= require('BuddyWindow')
local SkinUtils 	= require('SkinUtils')
local i18n			= require('i18n')
local gui			= require('dxgui')
local mod_mission	= require('me_mission')
local UpdateManager	= require('UpdateManager')
local ProductType 	= require('me_ProductType') 

local window_
local w_
local colorSelector_
local windowColor_
local iconSelector_
local windowIcon_
local switchButtonSelect_
local panelProperties_
local propertyPanels_			= {}
local checkListBoxLayers_
local gridObjects_
local gridData_					= {}
local checkBoxGrid_
local staticGridCell_
local buttonGridChangeLayer_
local menuChangeLayer_
local menuRadioItem_
local checkBoxHiddenOnF10Map_
local currPrimitiveType_
local newObject_
local currObject_
local currLastMouseX_
local currLastMouseY_
local polygonFreeDragged_		= false
local selectionHandlersPool_	= {}
local selectionHandlers_		= {}
local selectionHandlerIndex_
local selectionHandlerResizeFile_ = '../draw/selection_handle.png'
local selectionHandlerRotateFile_ = '../draw/selection_handle_rotate.png'
local rotateObject_ 			= false
local lastMouseDownPos_			= {x = 0, y = 0}
local lastObjectToRotate_
local circleSides_ 				= 36
local distanceUnits_
local iconsFolder_ 				= './MissionEditor/data/NewMap/images/'
local iconInfos_
local layers_ = {
	{ name = 'Red'		, caption = _('RED'		), visible = true, objects = {}}, -- bottom
	{ name = 'Blue'		, caption = _('BLUE'	), visible = true, objects = {}},	
	{ name = 'Neutral'	, caption = _('NEUTRAL'	), visible = true, objects = {}},	
	{ name = 'Common'	, caption = _('Common'	), visible = true, objects = {}},	
	{ name = 'Author'	, caption = _('Author'	), visible = true, objects = {}}, -- top
}
local currLayerName_	= 'Author'

local roles_ = {
	'instructor',
}

local hiddenOnF10MapData_ = {}

local function hiddenDataReset(data)
	data.Instructor			= {Red = false, Blue = false, Neutral = false,}
	data.Pilot				= {Red = false, Blue = false, Neutral = false,}
	data.ForwardObserver	= {Red = false, Blue = false, Neutral = false,}
	data.ArtilleryCommander	= {Red = false, Blue = false, Neutral = false,}
	data.Observer			= {Red = false, Blue = false, Neutral = false,}
	data.Spectrator			= {Red = false, Blue = false, Neutral = false,}
end

hiddenDataReset(hiddenOnF10MapData_	)

-- primitive types		
local Primitive = {
	Line	= 'Line'	,
	Polygon	= 'Polygon'	,
	TextBox	= 'TextBox'	,
	Icon	= 'Icon'	,
}

local LineMode = {
	Segments	= 'segments',
	Segment		= 'segment'	,
	Free		= 'free'	,
}

local lineMode_ = LineMode.Segments

local PolygonMode = {
	Circle		= 'circle'	,
	Oval		= 'oval'	,
	Rect		= 'rect'	,
	Free		= 'free'	,
	Arrow		= 'arrow'	,
}

local polygonMode_	= PolygonMode.Circle
local lineMode_		= LineMode.Segments

local function lineStylesLoad()
	local result = {}
	local f, err = loadfile(iconsFolder_ .. 'draw/lines.lua')
	
	if f then
		local env = {
			_ = i18n.ptranslate,
		}
		
		setfenv(f, env)
		
		local ok, res = pcall(f)
		
		if ok then
			result = env.lineStyles
			
			for i, info in ipairs(result) do
				local w, h = gui.GetTextureSize(info.file)
				
				info.thickness = h
			end
		else
			print(res)
		end
	else
		print(err)
	end
	
	return result
end

local lineStyleInfos_	= lineStylesLoad()
local lineStyles_		= {}

for i, info in ipairs(lineStyleInfos_) do
	lineStyles_[info.style] = {
		name				= info.name		,
		file				= info.file		,
		thickness			= info.thickness,
		order				= i				,
	}				
end

local function lineGetNewPrimitiveThickness()
	local result = {}
	
	for i, info in ipairs(lineStyleInfos_) do
		result[info.style] = info.thickness
	end
		
	return result
end

local newPrimitiveInfo_ = {
	[Primitive.Line]	= {	
		name			= {formatString = 'Line-%d'		, counter = 0},
		thickness		= lineGetNewPrimitiveThickness(), -- зависит от style
		colorString		= '0xff0000ff', -- красный цвет
		style			= lineStyleInfos_[1].style,
		closed			= false,
	},
	[Primitive.Polygon]	= {
		name			= {formatString = 'Polygon-%d'	, counter = 0},
		thickness		= lineGetNewPrimitiveThickness(), -- зависит от style
		colorString		= '0xff0000ff', -- красный цвет
		style			= lineStyleInfos_[1].style,
		fillColorString	= '0xff000080', -- красный цвет
	},
	[Primitive.TextBox]	= {
		name			= {formatString = 'Text Box-%d'	, counter = 0},
		text			= 'New text box',
		fontSize		= 24,
		borderThickness	= 4,
		colorString		= '0x00ff00ff', -- зеленый цвет
		fillColorString	= '0xff000080', -- красный цвет
	},
	[Primitive.Icon]	= {
		name			= {formatString = 'Icon-%d'		, counter = 0},
		colorString		= '0xffffffff', -- белый цвет
		file			= '',
		scale			= 1,
	},	
}

local function parseColorString(colorString)
	local r
	local g
	local b
	local a
	
	local i = tonumber(colorString)

	if i then
		local f

		i, f = math.modf(i / 256)
		a = f * 256

		i, f = math.modf(i / 256)
		b = f * 256

		r, f = math.modf(i / 256)

		g = f * 256
	end

	return r, g, b, a
end

local function colorFromString(colorString)
	local r, g, b, a = parseColorString(colorString)
	
	return { r / 255, g / 255, b / 255, a / 255}
end


local function verifyName(a_name, a_excludeObj)
	for i, layer in ipairs(layers_) do
		for ii, obj in ipairs(layer.objects) do
			if obj.name == a_name and a_excludeObj ~= obj then
				return false
			end
		end
	end
	
	return true
end

local function layerFind(layerName)
	for i, layer in ipairs(layers_) do
		if layer.name == layerName then
			return layer
		end
	end
end

local function iconsFolderGet()
	if OptionsData.getDifficulty('iconsTheme') == 'nato' then
		return iconsFolder_ .. 'nato/'
	else
		return iconsFolder_ .. 'russian/'
	end
end

local function selectionHandlersRelease()
	local selectionHandler = table.remove(selectionHandlers_)
	
	while selectionHandler do
		MapWindow.removeDrawObject(selectionHandler.mapId)
		table.insert(selectionHandlersPool_, selectionHandler)
		
		selectionHandler = table.remove(selectionHandlers_)
	end
end

local function selectionHandleCreate(mapX, mapY)
	local mapData = {
		objectType = 'Icon'					,
		x = mapX							,
		y = mapY							,
		color = {1, 1, 1, 1}				,
		file = selectionHandlerResizeFile_	,
	}
	
	local mapId = MapWindow.createDrawObject(mapData)

	return {
		mapId = mapId, 
		mapData = mapData,
	}
end

local function selectionHandleGet(mapX, mapY)
	local selectionHandler = table.remove(selectionHandlersPool_)
	
	if not selectionHandler then
		selectionHandler = selectionHandleCreate(mapX, mapY)
	end
	
	return selectionHandler
end

local function selectionHandleUpdate(index, mapX, mapY)
	local selectionHandle = selectionHandlers_[index]
			
	if not selectionHandle then
		selectionHandle = selectionHandleGet(mapX, mapY)
		table.insert(selectionHandlers_, selectionHandle)
		MapWindow.addDrawObject(selectionHandle.mapId)		
	end
	
	selectionHandle.mapData.x = mapX
	selectionHandle.mapData.y = mapY
	
	if rotateObject_ then
		selectionHandle.mapData.file = selectionHandlerRotateFile_
	else
		selectionHandle.mapData.file = selectionHandlerResizeFile_
	end
	
	MapWindow.updateDrawObject(selectionHandle.mapId, selectionHandle.mapData)
end

local function lineUpdateSelectionHandles(line)
	local x = line.mapData.x
	local y = line.mapData.y
	
	for i, point in ipairs(line.mapData.points) do
		selectionHandleUpdate(i, x + point.x, y + point.y)
	end	
end

local function polygonCircleUpdateSelectionHandles(circle)
	local x = circle.mapData.x
	local y = circle.mapData.y
	local r = circle.radius
	
	selectionHandleUpdate(1, x + r	, y		) -- top
	selectionHandleUpdate(2, x		, y + r	) -- right
	selectionHandleUpdate(3, x - r	, y 	) -- bottom
	selectionHandleUpdate(4, x		, y - r	) -- left
end

local function polygonOvalUpdateSelectionHandles(oval)
	local x			= oval.mapData.x
	local y			= oval.mapData.y
	local r1		= oval.r1
	local r2		= oval.r2
	local angle		= (oval.mapData.angle / 180) * math.pi
	local sinAngle	= math.sin(angle)
	local cosAngle	= math.cos(angle)
	
	selectionHandleUpdate(1, x + r1 * cosAngle	, y + r1 * sinAngle	) -- top
	selectionHandleUpdate(2, x - r2 * sinAngle	, y + r2 * cosAngle	) -- right
	selectionHandleUpdate(3, x - r1 * cosAngle	, y - r1 * sinAngle	) -- bottom
	selectionHandleUpdate(4, x + r2 * sinAngle	, y - r2 * cosAngle	) -- left
end

local function polygonRectUpdateSelectionHandles(rect)
	local x 		= rect.mapData.x
	local y 		= rect.mapData.y
	local w_2		= math.abs(rect.width 	/ 2) -- halfWidth
	local h_2		= math.abs(rect.height 	/ 2) -- halfHeight
	local angle		= (rect.mapData.angle / 180) * math.pi
	local sinAngle	= math.sin(angle)
	local cosAngle	= math.cos(angle)
	
	selectionHandleUpdate(1, x + h_2 * cosAngle + w_2 * sinAngle, y - w_2 * cosAngle + h_2 * sinAngle) -- left top
	selectionHandleUpdate(2, x + h_2 * cosAngle - w_2 * sinAngle, y + w_2 * cosAngle + h_2 * sinAngle) -- right top
	selectionHandleUpdate(3, x - h_2 * cosAngle - w_2 * sinAngle, y + w_2 * cosAngle - h_2 * sinAngle) -- right bottom
	selectionHandleUpdate(4, x - h_2 * cosAngle + w_2 * sinAngle, y - w_2 * cosAngle - h_2 * sinAngle) -- left bottom
end

local function polygonFreeUpdateSelectionHandles(polygon)
	local x = polygon.mapData.x
	local y = polygon.mapData.y
	
	for i, point in ipairs(polygon.mapData.points) do
		selectionHandleUpdate(i, x + point.x, y + point.y)
	end	
end

local function polygonArrowUpdateSelectionHandles(polygon)
	local x 		= polygon.mapData.x
	local y 		= polygon.mapData.y
	local angle		= (polygon.mapData.angle / 180) * math.pi
	local sinAngle	= math.sin(angle)
	local cosAngle	= math.cos(angle)
	
	selectionHandleUpdate(1, x - polygon.length * sinAngle, y + polygon.length * cosAngle)
end

local function textBoxUpdateSelectionHandles(textBox)
	local x = textBox.mapData.x
	local y = textBox.mapData.y
	
	selectionHandleUpdate(1, x, y)
end

local function iconUpdateSelectionHandles(icon)
	local x = icon.mapData.x
	local y = icon.mapData.y
	
	selectionHandleUpdate(1, x, y)
end

local function selectionHandlesUpdate(object)
	if object.primitiveType == Primitive.Line then
		lineUpdateSelectionHandles(object)
	elseif object.primitiveType == Primitive.Polygon then
		if object.polygonMode == PolygonMode.Circle then
			polygonCircleUpdateSelectionHandles(object)
		elseif object.polygonMode == PolygonMode.Oval then
			polygonOvalUpdateSelectionHandles(object)			
		elseif object.polygonMode == PolygonMode.Rect then
			polygonRectUpdateSelectionHandles(object)
		elseif object.polygonMode == PolygonMode.Free then
			polygonFreeUpdateSelectionHandles(object)
		elseif object.polygonMode == PolygonMode.Arrow then
			polygonArrowUpdateSelectionHandles(object)			
		end
	elseif object.primitiveType == Primitive.TextBox then
		textBoxUpdateSelectionHandles(object)
	elseif object.primitiveType == Primitive.Icon then
		iconUpdateSelectionHandles(object)		
	end
end

local function objectFindGridRow(object)
	local rowIndex
	
	for i = 1, gridObjects_:getRowCount() do
		rowIndex = i - 1
		
		if gridObjects_:getCell(1, rowIndex).object == object then
		
			return rowIndex
		end
	end
end

local function objectUpdateName(object, newName, editBoxName)
	local name = newName
	local counter = 0
	
	while verifyName(name, object) ~= true do
		counter = counter + 1
		name = string.format(newName..'-%d', counter)
	end
	
	object.name = name
	editBoxName:setText(name)
	
	local rowIndex = objectFindGridRow(object)
	
	if rowIndex then
		gridObjects_:getCell(1, rowIndex):setText(name)
	end	
end

local function setEditBoxNameCallbacks(editBoxName)
	function editBoxName:onFocus(focused)
		if not focused then
			if currObject_ then
				objectUpdateName(currObject_, editBoxName:getText(), editBoxName)
			end
		end
	end
	
	function editBoxName:onKeyDown(key, unicode)
		if 'return' == key then
			if currObject_ then
				objectUpdateName(currObject_, editBoxName:getText(), editBoxName)
			end
		end
	end
end

local function lineSetPropertiesCallbacks(panelPropertiesLine)
	local comboListStyle = panelPropertiesLine.comboListStyle
	
	for i, info in pairs(lineStyleInfos_) do
		comboListStyle:newItem(info.name).style	= info.style
	end 
	
	local newPrimitiveInfo = newPrimitiveInfo_[Primitive.Line]

	function panelPropertiesLine.spinBoxThickness:onChange()
		local thickness = panelPropertiesLine.spinBoxThickness:getValue()
		
		if currObject_ then
			currObject_.mapData.thickness = thickness
			currObject_.thickness[currObject_.style] = thickness
			
			MapWindow.updateDrawObject(currObject_.mapId, currObject_.mapData)
		else
			newPrimitiveInfo.thickness[newPrimitiveInfo.style] = thickness
		end
	end
	
	setEditBoxNameCallbacks(panelPropertiesLine.editBoxName)
	
	function panelPropertiesLine.comboListStyle:onChange(item)
		if currObject_ then
			currObject_.style			= item.style
			currObject_.mapData.file	= lineStyles_[item.style].file
			
			local thickness = currObject_.thickness[item.style]
			
			if not thickness then
				thickness = newPrimitiveInfo.thickness[item.style]
				currObject_.thickness[item.style] = thickness
			end
			
			currObject_.mapData.thickness = thickness
			
			panelPropertiesLine.spinBoxThickness:setValue(thickness)
			
			MapWindow.updateDrawObject(currObject_.mapId, currObject_.mapData)
		else
			newPrimitiveInfo.style = item.style
			panelPropertiesLine.spinBoxThickness:setValue(newPrimitiveInfo.thickness[item.style])
		end
	end
	
	local buttonColor = panelPropertiesLine.buttonColor
	
	panelPropertiesLine.buttonColorSkin = buttonColor:getSkin()
	
	local function onColorChange(r, g, b, a)
		local colorString = string.format('0x%.2x%.2x%.2x%.2x', r, g, b, a)
		
		buttonColor:setSkin(SkinUtils.setButtonColor(colorString, panelPropertiesLine.buttonColorSkin))
		
		if currObject_ then
			currObject_.mapData.color	= colorFromString(colorString)
			currObject_.colorString		= colorString
			
			MapWindow.updateDrawObject(currObject_.mapId, currObject_.mapData)
		else
			newPrimitiveInfo.colorString = colorString
		end
	end
	
	function buttonColor:onChange()
		local bw, bh = buttonColor:getSize()
		local wx, wy = buttonColor:widgetToWindow(0, bh)
		local colorString
		
		if currObject_ then
			colorString = currObject_.colorString
		else
			colorString = newPrimitiveInfo.colorString
		end
		
		colorSelector_	:setCallback(onColorChange)
		colorSelector_	:setColor	(parseColorString(colorString))
		windowColor_	:setPosition(wx, wy)
		windowColor_	:setVisible	(true)
	end
	
	local checkBoxClosed = panelPropertiesLine.checkBoxClosed
	
	function checkBoxClosed:onChange()
		if currObject_ then
			currObject_.mapData.closed	= checkBoxClosed:getState()
			
			MapWindow.updateDrawObject(currObject_.mapId, currObject_.mapData)
		else
			newPrimitiveInfo.closed = checkBoxClosed:getState()
		end
	end
end

local function objectUpdateSpinBoxAngle(angle, propertiesPanel)
	angle = math.floor(angle + 0.5)
	
	if angle < 0 then
		angle = 360 + angle
	end
	
	propertiesPanel.spinBoxAngle:setValue(angle)
end

 -- переопределена ниже
local polygonCircleRadiusUpdate
local polygonRectUpdateSize -- определена ниже
local polygonOvalUpdateSize -- определена ниже

local function polygonSetPropertiesCallbacks(panelPropertiesPolygon)
	local comboListStyle	= panelPropertiesPolygon.comboListStyle
	
	for i, info in pairs(lineStyleInfos_) do
		comboListStyle:newItem(info.name).style	= info.style
	end 
	
	local newPrimitiveInfo = newPrimitiveInfo_[Primitive.Polygon]

	function panelPropertiesPolygon.spinBoxThickness:onChange()
		local thickness = panelPropertiesPolygon.spinBoxThickness:getValue()
		
		if currObject_ then
			currObject_.mapData.thickness = thickness
			currObject_.thickness[currObject_.style] = thickness
			
			MapWindow.updateDrawObject(currObject_.mapId, currObject_.mapData)
		else
			newPrimitiveInfo.thickness[newPrimitiveInfo.style] = thickness
		end
	end
	
	setEditBoxNameCallbacks(panelPropertiesPolygon.editBoxName)
	
	function panelPropertiesPolygon.spinBoxAngle:onChange()
		local angle = panelPropertiesPolygon.spinBoxAngle:getValue()
		
		if angle == -1 then
			angle = 359
			self:setValue(angle)
		elseif angle == 360 then
			angle = 0
			self:setValue(angle)
		end
		
		if currObject_ then
			currObject_.mapData.angle = angle
			
			MapWindow.updateDrawObject(currObject_.mapId, currObject_.mapData)
			selectionHandlesUpdate(currObject_)
		end
	end
	
	function comboListStyle:onChange(item)
		if currObject_ then
			currObject_.style			= item.style
			currObject_.mapData.file	= lineStyles_[item.style].file
			
			local thickness = currObject_.thickness[item.style]
			
			if not thickness then
				thickness = newPrimitiveInfo.thickness[item.style]
				currObject_.thickness[item.style] = thickness
			end
			
			currObject_.mapData.thickness = thickness
			
			panelPropertiesPolygon.spinBoxThickness:setValue(thickness)
			
			MapWindow.updateDrawObject(currObject_.mapId, currObject_.mapData)
		else
			newPrimitiveInfo.style = item.style
			panelPropertiesPolygon.spinBoxThickness:setValue(newPrimitiveInfo.thickness[item.style])
		end
	end

	local buttonColor = panelPropertiesPolygon.buttonColor
	
	panelPropertiesPolygon.buttonColorSkin = buttonColor:getSkin()
	
	local function onColorChange(r, g, b, a)
		local colorString = string.format('0x%.2x%.2x%.2x%.2x', r, g, b, a)
		
		buttonColor:setSkin(SkinUtils.setButtonColor(colorString, panelPropertiesPolygon.buttonColorSkin))
		
		if currObject_ then
			currObject_.mapData.color	= colorFromString(colorString)
			currObject_.colorString		= colorString
			
			MapWindow.updateDrawObject(currObject_.mapId, currObject_.mapData)
		else
			newPrimitiveInfo.colorString = colorString
		end
	end
	
	function buttonColor:onChange()
		local bw, bh = buttonColor:getSize()
		local wx, wy = buttonColor:widgetToWindow(0, bh)
		local colorString
		
		if currObject_ then
			colorString = currObject_.colorString
		else
			colorString = newPrimitiveInfo.colorString
		end
		
		colorSelector_	:setCallback(onColorChange)
		colorSelector_	:setColor	(parseColorString(colorString))
		windowColor_	:setPosition(wx, wy)
		windowColor_	:setVisible	(true)
	end	
	
	local buttonFillColor = panelPropertiesPolygon.buttonFillColor
	
	panelPropertiesPolygon.buttonFillColorSkin = buttonFillColor:getSkin()
	
	local function onFillColorChange(r, g, b, a)
		local fillColorString = string.format('0x%.2x%.2x%.2x%.2x', r, g, b, a)
		
		buttonFillColor:setSkin(SkinUtils.setButtonColor(fillColorString, panelPropertiesPolygon.buttonFillColorSkin))
		
		if currObject_ then
			currObject_.fillColorString		= fillColorString
			currObject_.mapData.fillColor	= colorFromString(fillColorString)
			
			MapWindow.updateDrawObject(currObject_.mapId, currObject_.mapData)
		else
			newPrimitiveInfo.fillColorString = fillColorString
		end
	end
	
	function buttonFillColor:onChange()
		local bw, bh = buttonFillColor:getSize()
		local wx, wy = buttonFillColor:widgetToWindow(0, bh)
		local fillColorString
		
		if currObject_ then
			fillColorString = currObject_.fillColorString
		else
			fillColorString = newPrimitiveInfo.fillColorString
		end
		
		colorSelector_	:setCallback(onFillColorChange)
		colorSelector_	:setColor	(parseColorString(fillColorString))
		windowColor_	:setPosition(wx, wy)
		windowColor_	:setVisible	(true)
	end
	
	local spinBoxRadius = panelPropertiesPolygon.panelCircle.spinBoxRadius
	
	function spinBoxRadius:onChange()
		currObject_.radius = spinBoxRadius:getValue() / distanceUnits_.coeff
		
		polygonCircleRadiusUpdate	(currObject_)
		selectionHandlesUpdate		(currObject_)
	end
	
	local spinBoxWidth = panelPropertiesPolygon.panelRect.spinBoxWidth
	
	local sign = function(value)
		if value > 0 then
			return 1
		end
		
		if value < 0 then
			return -1
		end
		
		return 0
	end
	
	function spinBoxWidth:onChange()
		if currObject_.polygonMode == PolygonMode.Rect then
		
			currObject_.width = spinBoxWidth:getValue() / distanceUnits_.coeff 

			polygonRectUpdateSize(currObject_)
			
		elseif currObject_.polygonMode == PolygonMode.Oval then
		
			currObject_.r2 = (spinBoxWidth:getValue() / distanceUnits_.coeff) / 2
			
			polygonOvalUpdateSize(currObject_)
		end
		
		selectionHandlesUpdate(currObject_)
	end	
	
	local spinBoxHeight = panelPropertiesPolygon.panelRect.spinBoxHeight
	
	function spinBoxHeight:onChange()
		if currObject_.polygonMode == PolygonMode.Rect then
		
			currObject_.height = spinBoxHeight:getValue() / distanceUnits_.coeff
			
			polygonRectUpdateSize(currObject_)
			
		elseif currObject_.polygonMode == PolygonMode.Oval then
		
			currObject_.r1 = (spinBoxHeight:getValue() / distanceUnits_.coeff) / 2
			
			polygonOvalUpdateSize(currObject_)
		end
		
		selectionHandlesUpdate(currObject_)
	end
	
	panelPropertiesPolygon.panelCircle	.staticUnits:setText(distanceUnits_.name)
	panelPropertiesPolygon.panelRect	.staticUnits:setText(distanceUnits_.name)
end

local function textBoxSetPropertiesCallbacks(panelPropertiesTextBox)	
	local newPrimitiveInfo = newPrimitiveInfo_[Primitive.TextBox]
	
	function panelPropertiesTextBox.spinBoxThickness:onChange()
		local borderThickness = panelPropertiesTextBox.spinBoxThickness:getValue()
		
		if currObject_ then
			currObject_.mapData.borderThickness = borderThickness
			
			MapWindow.updateDrawObject(currObject_.mapId, currObject_.mapData)
		else
			newPrimitiveInfo.borderThickness = borderThickness
		end
	end
	
	function panelPropertiesTextBox.spinBoxFontSize:onChange()
		local fontSize = panelPropertiesTextBox.spinBoxFontSize:getValue()
		
		if currObject_ then
			currObject_.mapData.fontSize = fontSize
			
			MapWindow.updateDrawObject(currObject_.mapId, currObject_.mapData)
		else
			newPrimitiveInfo.fontSize = fontSize
		end
		
	end	

	setEditBoxNameCallbacks(panelPropertiesTextBox.editBoxName)
	
	function panelPropertiesTextBox.spinBoxAngle:onChange()
		local angle = panelPropertiesTextBox.spinBoxAngle:getValue()
		
		if angle == -1 then
			angle = 359
			self:setValue(angle)
		elseif angle == 360 then
			angle = 0
			self:setValue(angle)
		end	
		
		if currObject_ then
			currObject_.mapData.angle = angle
			
			MapWindow.updateDrawObject(currObject_.mapId, currObject_.mapData)
			selectionHandlesUpdate(currObject_)
		end
	end		
	
	local editBoxText = panelPropertiesTextBox.editBoxText
	
	function editBoxText:onFocus(focused)
		if not focused then
			if currObject_ then
				currObject_.mapData.text = editBoxText:getText()
				MapWindow.updateDrawObject(currObject_.mapId, currObject_.mapData)
			else
				newPrimitiveInfo.text = editBoxText:getText()
			end
		end
	end
	
	function editBoxText:onKeyDown(key, unicode)
		if 'return' == key then
			if currObject_ then
				currObject_.mapData.text = editBoxText:getText()
				MapWindow.updateDrawObject(currObject_.mapId, currObject_.mapData)
			else
				newPrimitiveInfo.text = editBoxText:getText()
			end
		end
	end	
	
	local buttonColor = panelPropertiesTextBox.buttonColor
	
	panelPropertiesTextBox.buttonColorSkin = buttonColor:getSkin()
	
	local function onColorChange(r, g, b, a)
		local colorString = string.format('0x%.2x%.2x%.2x%.2x', r, g, b, a)
		
		buttonColor:setSkin(SkinUtils.setButtonColor(colorString, panelPropertiesTextBox.buttonColorSkin))
		
		if currObject_ then
			currObject_.mapData.color	= {r / 255, g / 255, b / 255, a / 255}
			currObject_.colorString		= colorString
			
			MapWindow.updateDrawObject(currObject_.mapId, currObject_.mapData)
		else
			newPrimitiveInfo.colorString = colorString
		end
	end
	
	function buttonColor:onChange()
		local bw, bh = buttonColor:getSize()
		local wx, wy = buttonColor:widgetToWindow(0, bh)
		local colorString
		
		if currObject_ then
			colorString = currObject_.colorString
		else
			colorString = newPrimitiveInfo.colorString
		end
		
		colorSelector_	:setCallback(onColorChange)
		colorSelector_	:setColor	(parseColorString(colorString))
		windowColor_	:setPosition(wx, wy)
		windowColor_	:setVisible	(true)
	end	
	
	local buttonFillColor = panelPropertiesTextBox.buttonFillColor
	
	panelPropertiesTextBox.buttonFillColorSkin = buttonFillColor:getSkin()
	
	local function onFillColorChange(r, g, b, a)
		local fillColorString = string.format('0x%.2x%.2x%.2x%.2x', r, g, b, a)
		
		buttonFillColor:setSkin(SkinUtils.setButtonColor(fillColorString, panelPropertiesTextBox.buttonFillColorSkin))
		
		if currObject_ then
			currObject_.mapData.fillColor	= {r / 255, g / 255, b / 255, a / 255}
			currObject_.fillColorString		= fillColorString
			
			MapWindow.updateDrawObject(currObject_.mapId, currObject_.mapData)
		else
			newPrimitiveInfo.fillColorString = fillColorString
		end
	end
	
	function buttonFillColor:onChange()
		local bw, bh = buttonFillColor:getSize()
		local wx, wy = buttonFillColor:widgetToWindow(0, bh)
		local fillColorString
		
		if currObject_ then
			fillColorString = currObject_.fillColorString
		else
			fillColorString = newPrimitiveInfo.fillColorString
		end
		
		colorSelector_	:setCallback(onFillColorChange)
		colorSelector_	:setColor	(parseColorString(fillColorString))
		windowColor_	:setPosition(wx, wy)
		windowColor_	:setVisible	(true)
	end
end

local function iconInfosLoad()
	local result
	local f, err = loadfile(iconsFolder_ .. 'draw/icons.lua')
	
	if f then
		local env = {
			_ = i18n.ptranslate,
		}
		
		setfenv(f, env)
		
		local ok, res = pcall(f)
		
		if ok then
			result = res
		else
			print(res)
		end
	else
		print(err)
	end
	
	return result
end

local function iconSetPropertiesCallbacks(panelPropertiesIcon)	
	local newPrimitiveInfo = newPrimitiveInfo_[Primitive.Icon]
	
	setEditBoxNameCallbacks(panelPropertiesIcon.editBoxName)
	
	function panelPropertiesIcon.spinBoxAngle:onChange()
		local angle = panelPropertiesIcon.spinBoxAngle:getValue()
		
		if angle == -1 then
			angle = 359
			self:setValue(angle)
		elseif angle == 360 then
			angle = 0
			self:setValue(angle)
		end
		
		if currObject_ then
			currObject_.mapData.angle = angle
			
			MapWindow.updateDrawObject(currObject_.mapId, currObject_.mapData)
			selectionHandlesUpdate(currObject_)
		end
	end	
	
	local buttonColor = panelPropertiesIcon.buttonColor
	
	panelPropertiesIcon.buttonColorSkin = buttonColor:getSkin()
	
	local function onColorChange(r, g, b, a)
		local colorString = string.format('0x%.2x%.2x%.2x%.2x', r, g, b, a)
		
		buttonColor:setSkin(SkinUtils.setButtonColor(colorString, panelPropertiesIcon.buttonColorSkin))
		
		if currObject_ then
			currObject_.mapData.color	= {r / 255, g / 255, b / 255, a / 255}
			currObject_.colorString		= colorString
			
			MapWindow.updateDrawObject(currObject_.mapId, currObject_.mapData)
		else
			newPrimitiveInfo.colorString = colorString
		end
	end
	
	function buttonColor:onChange()
		local bw, bh = buttonColor:getSize()
		local wx, wy = buttonColor:widgetToWindow(0, bh)
		local colorString
		
		if currObject_ then
			colorString = currObject_.colorString
		else
			colorString = newPrimitiveInfo.colorString
		end
		
		colorSelector_	:setCallback(onColorChange)
		colorSelector_	:setColor	(parseColorString(colorString))
		windowColor_	:setPosition(wx, wy)
		windowColor_	:setVisible	(true)
	end	
	
	local buttonIcon	= panelPropertiesIcon.buttonIcon
	
	panelPropertiesIcon.buttonIconSkin = buttonIcon:getSkin()
	
	local function onIconChange(file)
		if currObject_ then
			currObject_.mapData.file = file
			
			MapWindow.updateDrawObject(currObject_.mapId, currObject_.mapData)
		else
			newPrimitiveInfo.file = file
		end
		
		panelPropertiesIcon.buttonIcon:setSkin(SkinUtils.setButtonPicture(iconsFolderGet() .. file, panelPropertiesIcon.buttonIconSkin))
	end

	function buttonIcon:onChange()
		local bw, bh = buttonIcon:getSize()
		local wx, wy = buttonIcon:widgetToWindow(0, bh)
		local file
		
		if currObject_ then
			file = currObject_.mapData.file
		else
			file = newPrimitiveInfo.file
		end
		
		iconSelector_	:setCallback(onIconChange)
		iconSelector_	:selectIcon	(file)
		windowIcon_		:setPosition(wx - 100, wy)
		windowIcon_		:setVisible	(true)
	end
	
	panelPropertiesIcon.scaleToItem = {}
	
	local addScaleItem = function(scale)
		local item	= panelPropertiesIcon.comboListScale:newItem(scale)
		
		item.scale	= scale
		panelPropertiesIcon.scaleToItem[scale] = item
		
		return item
	end
	
	addScaleItem(1)
	addScaleItem(2)
	addScaleItem(3)
	addScaleItem(4)
	addScaleItem(5)
	
	function panelPropertiesIcon.comboListScale:onChange(item)
		if currObject_ then
			currObject_.mapData.scale = item.scale
			
			MapWindow.updateDrawObject(currObject_.mapId, currObject_.mapData)
		else
			newPrimitiveInfo.scale = item.scale
		end
	end
end

local function lineSelectMode(lineMode)	-- переопределена ниже (здесь определена для Function List Notepad++)
end

local function polygonSelectMode(polygonMode) -- переопределена ниже (здесь определена для Function List Notepad++)
end

local function setDistanceValue(meters, spinBox)
	local precision
	
	if meters < 10 then
		precision = 0.0001
	elseif meters < 1000 then
		precision = 0.001
	elseif meters < 10000 then	
		precision = 0.01
	elseif meters < 50000 then	
		precision = 0.1
	else
		precision = 1
	end

	local value = precision * math.floor((meters * distanceUnits_.coeff) / precision + 0.5)

	spinBox:setValue(value)
end

-- обновить свойства когда пользователь выбирает взаимодействует с объектом
local function updatePropertiesPanel(object)
	local primitiveType		= object.primitiveType
	local propertiesPanel	= propertyPanels_[primitiveType]
		
	if primitiveType == Primitive.Line then
		lineSelectMode(object.lineMode)
		propertiesPanel.checkBoxClosed:setState(object.mapData.closed == true)
	elseif primitiveType == Primitive.Polygon then
		polygonSelectMode(object.polygonMode)
		
		propertiesPanel.panelCircle	:setVisible(false)
		propertiesPanel.panelRect	:setVisible(false)
		
		if object.polygonMode == PolygonMode.Circle then
		
			propertiesPanel.panelCircle:setVisible(true)
			
			setDistanceValue(object.radius, propertiesPanel.panelCircle.spinBoxRadius)

		elseif object.polygonMode == PolygonMode.Oval then
				
			propertiesPanel.panelRect:setVisible(true)
			
			setDistanceValue(math.abs(object.r2 * 2	), propertiesPanel.panelRect.spinBoxWidth	)
			setDistanceValue(math.abs(object.r1 * 2	), propertiesPanel.panelRect.spinBoxHeight	)
			
		elseif object.polygonMode == PolygonMode.Rect then
		
			propertiesPanel.panelRect:setVisible(true)
			
			setDistanceValue(math.abs(object.width	), propertiesPanel.panelRect.spinBoxWidth	)
			setDistanceValue(math.abs(object.height	), propertiesPanel.panelRect.spinBoxHeight	)
		end
	end
end

local function lineFillPropertiesPanel(object, propertiesPanel)
	local nameEnabled		= false
	local name
	local thickness
	local colorString
	local style
	
	if object then
		nameEnabled	= true
		name		= object.name
		thickness	= object.mapData.thickness
		colorString	= object.colorString
		style		= object.style
		
		updatePropertiesPanel(object)
	else
		local info	= newPrimitiveInfo_[Primitive.Line]
		
		thickness	= info.thickness[info.style]
		colorString	= info.colorString
		style		= info.style
	end
	
	propertiesPanel.editBoxName		:setEnabled	(nameEnabled)
	propertiesPanel.editBoxName		:setText	(name)
	propertiesPanel.spinBoxThickness:setValue	(thickness)			
	propertiesPanel.buttonColor		:setSkin	(SkinUtils.setButtonColor(colorString, propertiesPanel.buttonColorSkin))
	
	local comboListStyle = propertiesPanel.comboListStyle
	
	comboListStyle:selectItem(comboListStyle:getItem(lineStyles_[style].order - 1))
end

local function polygonFillPropertiesPanel(object, propertiesPanel)
	local nameEnabled		= false
	local name
	local angleEnabled		= false
	local angle
	local thickness
	local colorString
	local fillColorString
	local style
	
	if object then
		nameEnabled		= true
		name			= object.name
		angleEnabled	= object.mapData.angle ~= nil
		angle			= object.mapData.angle or 0
		thickness		= object.mapData.thickness
		colorString		= object.colorString
		style			= object.style
		fillColorString	= object.fillColorString
		
		updatePropertiesPanel(object)
	else
		local info		= newPrimitiveInfo_[Primitive.Polygon]
		
		angle			= 0
		thickness		= info.thickness[info.style]
		colorString		= info.colorString
		style			= info.style
		fillColorString	= info.fillColorString
		
		propertiesPanel.panelCircle	:setVisible(false)
		propertiesPanel.panelRect	:setVisible(false)
	end
	
	propertiesPanel.editBoxName		:setEnabled	(nameEnabled)
	propertiesPanel.editBoxName		:setText	(name)
	propertiesPanel.spinBoxAngle	:setEnabled	(angleEnabled)
	objectUpdateSpinBoxAngle(angle, propertiesPanel)
	propertiesPanel.spinBoxThickness:setValue	(thickness)
	propertiesPanel.buttonColor		:setSkin	(SkinUtils.setButtonColor(colorString, propertiesPanel.buttonColorSkin))
	propertiesPanel.buttonFillColor	:setSkin	(SkinUtils.setButtonColor(fillColorString, propertiesPanel.buttonFillColorSkin))
	
	local comboListStyle = propertiesPanel.comboListStyle
	
	comboListStyle:selectItem(comboListStyle:getItem(lineStyles_[style].order - 1))
end

local function textBoxFillPropertiesPanel(object, propertiesPanel)
	local nameEnabled = false
	local name
	local angle
	local text
	local fontSize
	local borderThickness
	local colorString
	local fillColorString
	
	if object then
		nameEnabled		= true
		name			= object.name
		angle			= object.mapData.angle or 0
		text			= object.mapData.text
		fontSize		= object.mapData.fontSize
		borderThickness	= object.mapData.borderThickness
		colorString		= object.colorString
		fillColorString	= object.fillColorString
	else
		local info		= newPrimitiveInfo_[Primitive.TextBox]
		
		angle			= 0
		text			= info.text
		fontSize		= info.fontSize
		borderThickness	= info.borderThickness
		colorString		= info.colorString
		fillColorString	= info.fillColorString
	end
	
	propertiesPanel.editBoxName		:setEnabled	(nameEnabled)
	propertiesPanel.editBoxName		:setText	(name)
	objectUpdateSpinBoxAngle(angle, propertiesPanel)
	propertiesPanel.editBoxText		:setText	(text)		
	propertiesPanel.spinBoxFontSize	:setValue	(fontSize)
	propertiesPanel.spinBoxThickness:setValue	(borderThickness)			
	propertiesPanel.buttonColor		:setSkin	(SkinUtils.setButtonColor(colorString, propertiesPanel.buttonColorSkin))
	propertiesPanel.buttonFillColor	:setSkin	(SkinUtils.setButtonColor(fillColorString, propertiesPanel.buttonFillColorSkin))
end

local function iconFillPropertiesPanel(object, propertiesPanel)
	local nameEnabled = false
	local name
	local angle
	local colorString
	local file
	local scale
	
	if object then
		nameEnabled		= true
		name			= object.name
		angle			= object.mapData.angle or 0
		colorString		= object.colorString
		file			= object.mapData.file
		scale			= object.mapData.scale
	else
		local info		= newPrimitiveInfo_[Primitive.Icon]
	
		angle			= 0
		colorString		= info.colorString
		file			= info.file
		scale			= info.scale
	end
	
	propertiesPanel.editBoxName	:setEnabled	(nameEnabled)
	propertiesPanel.editBoxName	:setText	(name)
	objectUpdateSpinBoxAngle(angle, propertiesPanel)
	propertiesPanel.buttonColor	:setSkin	(SkinUtils.setButtonColor(colorString, propertiesPanel.buttonColorSkin))
	propertiesPanel.buttonIcon	:setSkin	(SkinUtils.setButtonPicture(iconsFolderGet() .. file, propertiesPanel.buttonIconSkin))
	propertiesPanel.comboListScale:selectItem(propertiesPanel.scaleToItem[scale])
end

-- обновить свойства когда пользователь выбирает другой объект
local function fillPropertiesPanel(object)
	local primitiveType
	
	if object then
		primitiveType = object.primitiveType
	else
		primitiveType = currPrimitiveType_
	end
	
	local propertiesPanel = propertyPanels_[primitiveType]

	if primitiveType == Primitive.Line then
		lineFillPropertiesPanel(object, propertiesPanel)		
	elseif primitiveType == Primitive.Polygon then
		polygonFillPropertiesPanel(object, propertiesPanel)
	elseif primitiveType == Primitive.TextBox then
		textBoxFillPropertiesPanel(object, propertiesPanel)
	elseif primitiveType == Primitive.Icon then
		iconFillPropertiesPanel(object, propertiesPanel)
	end
	
	return propertiesPanel
end

local function setPropertiesPanel(object)
	local prevPanel = panelProperties_:getWidget(0)
	
	if prevPanel then
		panelProperties_:removeWidget(prevPanel)
	end	
	
	if object then
		panelProperties_:insertWidget(fillPropertiesPanel(object))
	elseif currPrimitiveType_ then
		panelProperties_:insertWidget(fillPropertiesPanel())
	end	
end

local function objectSelect(object)
	if object ~= currObject_ then
		if currObject_ then
			selectionHandlersRelease()
			gridObjects_:selectRow()
		end
	end
	
	currObject_			= object
	rotateObject_		= false
	lastObjectToRotate_	= nil
	
	if object then
		if object.visible and layerFind(object.layerName).visible then
			selectionHandlesUpdate(object)
		end
		
		local rowIndex = objectFindGridRow(object)
		
		if rowIndex then
			gridObjects_:selectRow(rowIndex)
		end
	end
	
	setPropertiesPanel(object)
end

local function objectsUpdateVisibility()
	-- чтобы сохранить порядок объектов 
	-- сначала удаляем все объекты,
	-- а затем добавляем объекты в порядке создания
	-- добавление и удаление объектов это быстрая операция
	selectionHandlersRelease()
	
	MapWindow.removeAllDrawObjects()
	
	gridObjects_:removeAllRows()
	
	for i, layer in ipairs(layers_) do
		if layer.visible then
			for j, object in ipairs(layer.objects) do
				if object.visible then
					MapWindow.addDrawObject(object.mapId)
				end
				
				local rowIndex = 0
				
				gridObjects_:insertRow(nil, rowIndex)
				
				local data = gridData_[object]
				
				if data then
					gridObjects_:setCell(0, rowIndex, data.c0)
					gridObjects_:setCell(1, rowIndex, data.c1)
					gridObjects_:setCell(2, rowIndex, data.c2)
					gridObjects_:setCell(3, rowIndex, data.c3)
					gridObjects_:setCell(4, rowIndex, data.c4)
				end
			end
		end
	end
		
	objectSelect(currObject_)
end

local function gridDataAdd(object)	
	local checkBoxVisible = checkBoxGrid_:clone()
	
	checkBoxVisible:setState(object.visible)
	
	checkBoxVisible:addChangeCallback(function()
		object.visible = checkBoxVisible:getState()
		
		if object.visible then
			objectsUpdateVisibility()
			objectSelect(object)
		else
			selectionHandlersRelease()
			MapWindow.removeDrawObject(object.mapId)
		end
	end)
	
	local cellName = staticGridCell_:clone()
	
	cellName:setText(object.name)
	cellName.object = object
	
	local cellLayer = staticGridCell_:clone()
	
	cellLayer:setText(layerFind(object.layerName).caption)
	cellLayer.layerName = object.layerName
	
	local buttonChangeLayer = buttonGridChangeLayer_:clone()
	
	buttonChangeLayer:addChangeCallback(function()
		local w, h	= buttonChangeLayer:getSize()
		local x, y	= buttonChangeLayer:widgetToWindow(0, h)
		
		menuChangeLayer_.object = object
		menuChangeLayer_[object.layerName]:setState(true)
		menuChangeLayer_:setPosition(x, y)
		menuChangeLayer_:setVisible(true)
	end)
	
	local checkBoxVisibleOnPlanner = checkBoxGrid_:clone()
	
	checkBoxVisibleOnPlanner:setState(not object.hiddenOnPlanner)
	
	checkBoxVisibleOnPlanner:addChangeCallback(function()
		object.hiddenOnPlanner = not checkBoxVisibleOnPlanner:getState()
	end)
	
	gridData_[object] = {
		c0 = checkBoxVisible,
		c1 = cellName,
		c2 = cellLayer,
		c3 = buttonChangeLayer,
		c4 = checkBoxVisibleOnPlanner,
	}
end

local function objectAdd(object)
	local layer = layerFind(object.layerName)
	
	table.insert(layer.objects, object)
	
	gridDataAdd(object)
	objectsUpdateVisibility() -- объект может быть добавлен в слой под другими слоями
end

local function deleteMapObject(primitiveType, mapId)
	for i, layer in ipairs(layers_) do
		for j, object in ipairs(layer.objects) do
			if object.mapId == mapId then
				table.remove(layer.objects, j)
				
				MapWindow.deleteDrawObject(mapId)
				
				break
			end
		end
	end
end

local function objectDelete(object)
	deleteMapObject(object.primitiveType, object.mapId)

	local rowIndex = objectFindGridRow(object)
		
	if rowIndex then
		gridObjects_:clearRow(rowIndex)
	end
	
	gridData_[object] = nil
		
	objectSelect()
end

local function objectSelectNew()
	objectSelect(newObject_)
	
	switchButtonSelect_:setState(true)
	switchButtonSelect_:onChange() -- resets newObject_ to nil
end

local function deleteIncomleteNewObject()
	deleteMapObject(newObject_.primitiveType, newObject_.mapId)
	
	local info = newPrimitiveInfo_[newObject_.primitiveType]
	
	info.name.counter = info.name.counter - 1
	
	newObject_ = nil
	fillPropertiesPanel()
end

local function onDelete()
	if currPrimitiveType_ == nil and menuChangeLayer_:getVisible() == false then
		if currObject_ then
			objectDelete(currObject_)
		end
	end	
end

local function checkListBoxLayersUpdate(layerNameToSelect)
	checkListBoxLayers_:clear()
	
	for i, layer in ipairs(layers_) do
		local item = checkListBoxLayers_:newItem(layer.caption, 0) -- вставляем в начало
		
		item.layerName = layer.name
		item:setChecked(layer.visible)
		
		if layerNameToSelect == layer.name then
			checkListBoxLayers_:selectItem(item)
		end
	end
end

local function objectChangeLayer(object, layerName)
	local prevLayer = layerFind(object.layerName)
	
	for i, o in ipairs(prevLayer.objects) do
		if object == o then
			table.remove(prevLayer.objects, i)
			
			break
		end
	end
	
	local currLayer = layerFind(layerName)
	
	table.insert(currLayer.objects, object)

	object.layerName = layerName
	
	local data = gridData_[object]
	
	if data then
		data.c2:setText(currLayer.caption)
	end
	
	objectsUpdateVisibility()
end

local function create(x, y, w, h)
	local localization = {
		title				= _('Draw panel'),
		properties			= _('Type'),
		name				= _('Name'),
		color				= _('Color'),
		fill				= _('Fill'),
		thickness			= _('Thickness'),
		style				= _('Style'),
		closed				= _('Closed'),
		select				= _('Select'),
		line				= _('Line'),
		lineHint			= _('Draw lines and polylines'),
		segment				= _('Segment'),
		segments			= _('Segments'),
		polygon				= _('Polygon'),
		polygonHint			= _('Draw circles, rectangles, arrows, etc...'),
		circle				= _('Disk'),
		oval				= _('Oval'),
		rect				= _('Rect'),
		arrow				= _('Arrow'),
		free				= _('Free'),
		radius				= _('Radius'),
		width				= _('Width'),
		height				= _('Height'),
		angle				= _('Angle'),
		textBox				= _('Text Box'),
		textBoxHint			= _('Draw text labels'),
		text				= _('Text'),
		fontSize			= _('Font Size'),
		icon				= _('Icon'),
		scale				= _('Scale'),
		layers				= _('Layers'),
		objects				= _('Figures'),
		changeLayer			= _('Change Layer'),
		visibleOnPlanner	= _('Visible On Planner'),
		hiddenOnF10Map		= _('Hidden On F10 Map'),
		Red					= _('RED'),
		Blue				= _('BLUE'),
		Neutral				= _('NEUTRAL'),
		instructor			= _('GAME MASTER'),
		pilot				= _('PILOT'),
		forwardObserver		= _('FORWARD OBSERVER'),
		artilleryCommander	= _('TACTICAL CMDR'),
		observer			= _('OBSERVER'),
		spectrator			= _('SPECTATOR'),  
		ShowHide			= _('Show/Hide'), 
		SelectedLayer		= _('Binding Layer'), 
		iconHint			= _('Select icons and signs to place on the map'), 
	}
	
	if _G.__PRODUCT_ID__ == 2 then
        localization.instructor   = _("SUPERVISOR")
    end
	
	window_ = DialogLoader.spawnDialogFromFile('MissionEditor/modules/dialogs/me_draw_panel.dlg', localization)
	window_:setBounds(x, y, w, h)
	window_:addHotKeyCallback('delete', onDelete)
	w_ = w
	
	spBox		= window_.spBox	
	panelHidden = spBox.panelHidden
	
	spBox:setBounds(0, 0, w, h-30)
	
	local U				= require('me_utilities')
	local OptionsData	= require('Options.Data')
	
	distanceUnits_		= U.distanceUnits[OptionsData.getUnits()]
	
	function window_:onClose()
		toolbar.untoggle_all_except()
		onClose()	
	end
	
	colorSelector_		= ColorSelector.new()
	windowColor_		= BuddyWindow.new()
						
	local colorPanel	= colorSelector_:getPanel()
	
	windowColor_:setBuddyWidget	(colorPanel)
	windowColor_:insertWidget	(colorPanel)
	windowColor_:setSize		(colorPanel:getSize())
	
	windowColor_:addKeyDownCallback(function(self, key, unicode)
		if 	'escape' == key or 
			'return' == key then
			windowColor_:setVisible(false)
			
			return true -- чтобы по escape не закрывалась панель рисования
		end
	end)
	
	iconSelector_	= IconSelector.new()
	iconInfos_		= iconInfosLoad()
	
	if iconInfos_ then		
		iconSelector_:setIcons(iconsFolderGet(), iconInfos_)
		newPrimitiveInfo_[Primitive.Icon].file = iconInfos_[1].file
	end	
	
	windowIcon_			= BuddyWindow.new()
	
	local iconPanel		= iconSelector_:getPanel()
	
	windowIcon_:setBuddyWidget	(iconPanel)
	windowIcon_:insertWidget	(iconPanel)
	windowIcon_:setSize			(iconPanel:getSize())
	
	windowIcon_:addKeyDownCallback(function(self, key, unicode)
		if 	'escape' == key or 
			'return' == key then
			windowIcon_:setVisible(false)
			
			return true -- чтобы по escape не закрывалась панель рисования
		end
	end)	
	
	panelProperties_					= DialogLoader.findWidgetByName(window_, 'panelProperties'			)
	checkListBoxLayers_					= DialogLoader.findWidgetByName(window_, 'checkListBoxLayers'		)
	gridObjects_						= DialogLoader.findWidgetByName(window_, 'gridObjects'				)
	
	checkBoxGrid_						= DialogLoader.findWidgetByName(window_, 'checkBoxGrid'				)
	window_:removeWidget(checkBoxGrid_)
	staticGridCell_						= DialogLoader.findWidgetByName(window_, 'staticGridCell'			)
	window_:removeWidget(staticGridCell_)	
	buttonGridChangeLayer_				= DialogLoader.findWidgetByName(window_, 'buttonGridChangeLayer'	)
	window_:removeWidget(buttonGridChangeLayer_)	
	menuRadioItem_						= DialogLoader.findWidgetByName(window_, 'menuRadioItem'			)
	window_:removeWidget(menuRadioItem_)
	menuChangeLayer_					= window_.menuChangeLayer
	
	function menuChangeLayer_:onChange(item)
		objectChangeLayer(menuChangeLayer_.object, item.layerName)
	end
	
	local panelPropertiesLine 			= DialogLoader.findWidgetByName(window_, 'panelPropertiesLine'		)
	local panelPropertiesPolygon 		= DialogLoader.findWidgetByName(window_, 'panelPropertiesPolygon'	)
	local panelPropertiesTextBox		= DialogLoader.findWidgetByName(window_, 'panelPropertiesTextBox'	)
	local panelPropertiesIcon			= DialogLoader.findWidgetByName(window_, 'panelPropertiesIcon'		)
	local placeholder 					= panelPropertiesPolygon.staticPlaceholder
	
	panelPropertiesPolygon.panelCircle	:setPosition(placeholder:getPosition())
	panelPropertiesPolygon.panelRect	:setPosition(placeholder:getPosition())
	
	propertyPanels_[Primitive.Line		] = panelPropertiesLine
	propertyPanels_[Primitive.Polygon	] = panelPropertiesPolygon
	propertyPanels_[Primitive.TextBox	] = panelPropertiesTextBox
	propertyPanels_[Primitive.Icon		] = panelPropertiesIcon
		
	lineSetPropertiesCallbacks(panelPropertiesLine)
	panelPropertiesLine:setPosition(0, 0)
	
	polygonSetPropertiesCallbacks(panelPropertiesPolygon)
	panelPropertiesPolygon:setPosition(0, 0)
	
	textBoxSetPropertiesCallbacks(panelPropertiesTextBox)
	panelPropertiesTextBox:setPosition(0, 0)
	
	iconSetPropertiesCallbacks(panelPropertiesIcon)
	panelPropertiesIcon:setPosition(0, 0)

	window_:removeWidget(panelPropertiesLine	)
	window_:removeWidget(panelPropertiesPolygon	)
	window_:removeWidget(panelPropertiesTextBox	)
	window_:removeWidget(panelPropertiesIcon	)
	
	switchButtonSelect_			= DialogLoader.findWidgetByName(window_, 'switchButtonSelect'	)
	
	local switchButtonLine 		= DialogLoader.findWidgetByName(window_, 'switchButtonLine'		)
	local switchButtonPolygon 	= DialogLoader.findWidgetByName(window_, 'switchButtonPolygon'	)
	local switchButtonTextBox 	= DialogLoader.findWidgetByName(window_, 'switchButtonTextBox'	)
	local switchButtonIcon 		= DialogLoader.findWidgetByName(window_, 'switchButtonIcon'		)
	
	function switchButtonSelect_:onChange()
		currPrimitiveType_	= nil
		newObject_			= nil
	end
	
	function switchButtonLine:onChange()
		currPrimitiveType_ = Primitive.Line
		objectSelect()
	end
	
	function switchButtonPolygon:onChange()
		currPrimitiveType_ = Primitive.Polygon
		objectSelect()
	end
	
	function switchButtonTextBox:onChange()
		currPrimitiveType_ = Primitive.TextBox
		objectSelect()
	end
	
	function switchButtonIcon:onChange()
		currPrimitiveType_ = Primitive.Icon
		objectSelect()	
	end
	
	local switchButtonLineSegments	= DialogLoader.findWidgetByName(panelPropertiesLine, 'switchButtonLineSegments'	)
	local switchButtonLineSegment	= DialogLoader.findWidgetByName(panelPropertiesLine, 'switchButtonLineSegment'	)
	local switchButtonLineFree		= DialogLoader.findWidgetByName(panelPropertiesLine, 'switchButtonLineFree'		)
		
	lineSelectMode = function(lineMode) -- объявлена выше
		switchButtonLineSegments:setState(lineMode == LineMode.Segments	)
		switchButtonLineSegment	:setState(lineMode == LineMode.Segment	)
		switchButtonLineFree	:setState(lineMode == LineMode.Free		)		
	end
	
	lineSelectMode(lineMode_)
	
	function switchButtonLineSegments:onChange()
		lineMode_ = LineMode.Segments
	end
	
	function switchButtonLineSegment:onChange()
		lineMode_ = LineMode.Segment
	end
	
	function switchButtonLineFree:onChange()
		lineMode_ = LineMode.Free
	end
	
	local switchButtonPolygonCircle	= DialogLoader.findWidgetByName(panelPropertiesPolygon, 'switchButtonPolygonCircle'	)
	local switchButtonPolygonOval	= DialogLoader.findWidgetByName(panelPropertiesPolygon, 'switchButtonPolygonOval'	)
	local switchButtonPolygonRect	= DialogLoader.findWidgetByName(panelPropertiesPolygon, 'switchButtonPolygonRect'	)
	local switchButtonPolygonFree	= DialogLoader.findWidgetByName(panelPropertiesPolygon, 'switchButtonPolygonFree'	)
	local switchButtonPolygonArrow	= DialogLoader.findWidgetByName(panelPropertiesPolygon, 'switchButtonPolygonArrow'	)
	
	polygonSelectMode = function(polygonMode) -- объявлена выше
		switchButtonPolygonCircle	:setState(polygonMode == PolygonMode.Circle	)
		switchButtonPolygonOval		:setState(polygonMode == PolygonMode.Oval	)
		switchButtonPolygonRect		:setState(polygonMode == PolygonMode.Rect	)
		switchButtonPolygonFree		:setState(polygonMode == PolygonMode.Free	)
		switchButtonPolygonArrow	:setState(polygonMode == PolygonMode.Arrow	)
	end
	
	polygonSelectMode(polygonMode_)
	
	function switchButtonPolygonCircle:onChange()
		polygonMode_ = PolygonMode.Circle
	end
	
	function switchButtonPolygonOval:onChange()
		polygonMode_ = PolygonMode.Oval
	end	
	
	function switchButtonPolygonRect:onChange()
		polygonMode_ = PolygonMode.Rect
	end
	
	function switchButtonPolygonFree:onChange()
		polygonMode_ = PolygonMode.Free
	end	
	
	function switchButtonPolygonArrow:onChange()
		polygonMode_ = PolygonMode.Arrow
	end
	
	local buttonLayerUp		= DialogLoader.findWidgetByName(window_, 'buttonLayerUp'	)
	local buttonLayerDown	= DialogLoader.findWidgetByName(window_, 'buttonLayerDown'	)
	
	-- слои в checkListBoxLayers_ расположены в обратном порядке
	function buttonLayerUp:onChange()
		local item = checkListBoxLayers_:getSelectedItem()
		
		if item then
			local count			= #layers_
			local index			= checkListBoxLayers_:getItemIndex(item)
			local layerIndex	= count - index
			
			if layerIndex < count then
				local layer = table.remove(layers_, layerIndex)
				
				table.insert(layers_, layerIndex + 1, layer)
				
				checkListBoxLayersUpdate(currLayerName_)
				objectsUpdateVisibility()
			end
		end
	end
	
	function buttonLayerDown:onChange()
		local item = checkListBoxLayers_:getSelectedItem()
		
		if item then
			local count			= #layers_
			local index			= checkListBoxLayers_:getItemIndex(item)
			local layerIndex	= count - index
			
			if layerIndex > 1 then
				local layer = table.remove(layers_, layerIndex)
				
				table.insert(layers_, layerIndex - 1, layer)
				
				checkListBoxLayersUpdate(currLayerName_)
				objectsUpdateVisibility()
			end
		end
	end	
	
	function checkListBoxLayers_:onSelectionChange() -- выбранный элемент списка изменили клавишами вверх/вниз
		local item = checkListBoxLayers_:getSelectedItem()
		
		if item then
			currLayerName_ = item.layerName
		end
	end
	
	function checkListBoxLayers_:onItemMouseDown()
		local item = checkListBoxLayers_:getSelectedItem()
		
		if item then
			currLayerName_ = item.layerName
		end	
	end
	
	function checkListBoxLayers_:onItemChange()
		local item	= checkListBoxLayers_:getSelectedItem()
		local layer	= layerFind(item.layerName)
		
		layer.visible = item:getChecked()
		objectsUpdateVisibility()
	end
	
	local createLayerMenuItem = function(layer)
		local item = menuRadioItem_:clone()
		
		item:setText(layer.caption)
		item.layerName = layer.name
		
		menuChangeLayer_:insertItem(item, 0)
		menuChangeLayer_[layer.name] = item
		
		return item
	end
	
	for i, layer in ipairs(layers_) do
		createLayerMenuItem(layer)
	end
	
	function gridObjects_:onMouseDown(x, y, button)
		if 1 == button then
			local colIndex, rowIndex = gridObjects_:getMouseCursorColumnRow(x, y)
			
			if -1 < colIndex and -1 < rowIndex then
			
				gridObjects_:selectRow(rowIndex)				

				local cell = self:getCell(1, rowIndex)

				if cell then
					objectSelect(cell.object)
				else
					objectSelect()
				end
			end
		end
	end
	
	local buttonObjectFirst	= DialogLoader.findWidgetByName(window_, 'buttonObjectFirst')
	local buttonObjectUp	= DialogLoader.findWidgetByName(window_, 'buttonObjectUp'	)
	local buttonObjectDown	= DialogLoader.findWidgetByName(window_, 'buttonObjectDown'	)
	local buttonObjectLast	= DialogLoader.findWidgetByName(window_, 'buttonObjectLast'	)
	
	function buttonObjectFirst:onChange()
		if currObject_ then
			local layer = layerFind(currObject_.layerName)
			
			for i, object in ipairs(layer.objects) do
				if object == currObject_ then
					table.remove(layer.objects, i)
					table.insert(layer.objects, object)

					objectsUpdateVisibility()
					-- обновить grid
					
					break
				end
			end
		end
	end
	
	function buttonObjectUp:onChange()
		if currObject_ then
			local layer = layerFind(currObject_.layerName)
			
			for i, object in ipairs(layer.objects) do
				if object == currObject_ then
					if i < #layer.objects then
						table.remove(layer.objects, i)
						table.insert(layer.objects, i + 1, object)

						objectsUpdateVisibility()
						-- обновить grid
					end
					
					break	
				end
			end
		end	
	end
	
	function buttonObjectDown:onChange()
		if currObject_ then
			local layer = layerFind(currObject_.layerName)
			
			for i, object in ipairs(layer.objects) do
				if object == currObject_ then
					if i > 1 then
						table.remove(layer.objects, i)
						table.insert(layer.objects, i - 1, object)

						objectsUpdateVisibility()
						-- обновить grid
					end
					
					break	
				end
			end
		end	
	end
	
	function buttonObjectLast:onChange()
		if currObject_ then
			local layer = layerFind(currObject_.layerName)
			
			for i, object in ipairs(layer.objects) do
				if object == currObject_ then
					table.remove(layer.objects, i)
					table.insert(layer.objects, 1, object)

					objectsUpdateVisibility()
					-- обновить grid
					
					break
				end
			end
		end
	end

	function onChange_checkBox(self)
		hiddenOnF10MapData_[self.role][self.coalition] = self:getState()				
	end
	
	local panelHiddenFill = function(hiddenData)
		for role, data in pairs(hiddenData) do
			local panel = panelHidden.panelRoles['panel' .. role]
			
			for coalition, value in pairs(data) do
				local checkBox = DialogLoader.findWidgetByName(panel, 'checkBox' .. coalition)
				
				checkBox.role = role
				checkBox.coalition = coalition
				checkBox:setState(value)
				
				checkBox.onChange = onChange_checkBox
			end
		end
	end
	
	local buttonHiddenOnF10Map	= DialogLoader.findWidgetByName(window_, 'buttonHiddenOnF10Map')
	
	function buttonHiddenOnF10Map:onChange()
		panelHiddenFill(hiddenOnF10MapData_)
		
		panelHidden:setPosition(10, 740)
		panelHidden:setVisible(not panelHidden:getVisible())
		spBox:updateWidgetsBounds()
		
		UpdateManager.add(function()
			local minValue, maxValue =  spBox:getVertScrollRange()
			spBox:setVertScrollValue(maxValue)
			return true
		end)		
	end
end

function onClose()
	objectSelect()
	MapWindow.setState(MapWindow.getPanState())
	
	mod_mission.mission.drawings = saveToMission()   
	MapWindow.expand()
end		

local function cancelDrawingLine(line)
	local points = line.mapData.points
	
	if #points > 2 then
		-- удаляем последнюю точку
		table.remove(points)
		
		MapWindow.updateDrawObject(line.mapId, line.mapData)
	else
		deleteMapObject(line.primitiveType, line.mapId)
	end
end

local function show(b)	
	if b then
		if window_:getVisible() == false then
			MapWindow.collapse(w_, 0)
		end
	elseif window_:getVisible() then
		if newObject_ then
			if newObject_.primitiveType == Primitive.Line then
				cancelDrawingLine(newObject_)
			end
			
			newObject_ = nil
		end
		
		onClose()
	end
	
	window_:setVisible(b)
end


local function createNewPrimitiveName(primitiveType)
	local info = newPrimitiveInfo_[primitiveType]

	info.name.counter = info.name.counter + 1
	local name = string.format(info.name.formatString, info.name.counter)
	
	while verifyName(name) ~= true do
		info.name.counter = info.name.counter + 1
		name = string.format(info.name.formatString, info.name.counter)
	end
	
	return name
end

local function lineSegmentOnMouseMove(x, y)
	local mapX, mapY	= MapWindow.getMapPoint(x, y)
	local points		= newObject_.mapData.points
	local pointEnd		= points[#points] -- последняя точка
	
	pointEnd.x			= mapX - newObject_.mapData.x
	pointEnd.y			= mapY - newObject_.mapData.y
	
	MapWindow.updateDrawObject(newObject_.mapId, newObject_.mapData)
end

local function lineSegmentsOnMouseMove(x, y)
	lineSegmentOnMouseMove(x, y)
end

local function polygonFreeOnMouseMove(x, y)
	local mapX, mapY	= MapWindow.getMapPoint(x, y)
	local points		= newObject_.mapData.points
	local pointEnd		= points[#points - 1] -- предпоследняя точка
	
	pointEnd.x			= mapX - newObject_.mapData.x
	pointEnd.y			= mapY - newObject_.mapData.y
	
	MapWindow.updateDrawObject(newObject_.mapId, newObject_.mapData)
end

local function onMouseMove(x, y)
	if newObject_ then
		if currPrimitiveType_ == Primitive.Line then
			if lineMode_ == LineMode.Segment then
				lineSegmentOnMouseMove(x, y)
			elseif	lineMode_ == LineMode.Segments then
				lineSegmentsOnMouseMove(x, y)
			end
		elseif	currPrimitiveType_ == Primitive.Polygon then
			if polygonMode_ == PolygonMode.Free then
				polygonFreeOnMouseMove(x, y)
			end
		end	
	end
end

local function lineFreeOnMouseDown(x, y)
	local mapX, mapY		= MapWindow.getMapPoint(x, y)
	local newPrimitiveInfo	= newPrimitiveInfo_[Primitive.Line]
	local colorString		= newPrimitiveInfo.colorString
	local style				= newPrimitiveInfo.style
	
	local mapData = {
		objectType			= 'Polyline'						,
		points				= {{x = 0, y = 0}}					,
		thickness			= newPrimitiveInfo.thickness[style]	,
		closed				= newPrimitiveInfo.closed			,
		color				= colorFromString(colorString)		,
		file				= lineStyles_[style].file			,
		x 					= mapX								,
		y 					= mapY								,
	}
	
	local line = {
		primitiveType		= Primitive.Line				,
		lineMode			= LineMode.Free					,
		name				= createNewPrimitiveName(Primitive.Line),
		mapId				= MapWindow.createDrawObject(mapData),
		mapData				= mapData						,
		colorString			= colorString					,
		thickness			= {[style] = newPrimitiveInfo.thickness[style]}, -- сохраняем толщину для каждого типа линии
		style				= style							,
		visible				= true							,
		layerName			= currLayerName_				,
	}
	
	objectAdd(line)
	
	currLastMouseX_ = x
	currLastMouseY_ = y
	
	return line
end

local function lineSegmentOnMouseDown(x, y)
	local line = lineFreeOnMouseDown(x, y)
	
	line.lineMode = LineMode.Segment
	
	return line
end

local function lineSegmentsOnMouseDown(x, y)
	local line = lineFreeOnMouseDown(x, y)

	line.lineMode = LineMode.Segments
	
	table.insert(line.mapData.points, {x = 0, y = 0})
	
	return line
end

local function polygonCircleOnMouseDown(x, y)
	local mapX, mapY	= MapWindow.getMapPoint(x, y)
	local points 		= {}
	
	for i = 0, circleSides_ do
		table.insert(points, {x = 0, y = 0})
	end

	local newPrimitiveInfo	= newPrimitiveInfo_[Primitive.Polygon]
	local colorString		= newPrimitiveInfo.colorString
	local fillColorString	= newPrimitiveInfo.fillColorString
	local style				= newPrimitiveInfo.style
	local mapData			= {
		objectType			= 'Polygon'								,
		points				= points								,
		thickness			= newPrimitiveInfo.thickness[style]		,
		color				= colorFromString(colorString		)	,
		fillColor			= colorFromString(fillColorString	)	,
		file				= lineStyles_[style].file				,
		x 					= mapX									,
		y 					= mapY									,
	}
	
	local circle = {
		primitiveType		= Primitive.Polygon						,
		polygonMode			= PolygonMode.Circle					,
		name				= createNewPrimitiveName(Primitive.Polygon),
		mapId				= MapWindow.createDrawObject(mapData)	,
		mapData				= mapData								,
		colorString			= colorString							,
		fillColorString		= fillColorString						,
		style				= style									,
		thickness			= {[style] = newPrimitiveInfo.thickness[style]}, -- сохраняем толщину для каждого типа линии
		radius				= 0										,
		visible				= true									,
		layerName			= currLayerName_						,
	}
	
	objectAdd(circle)
	
	return circle
end

local function polygonOvalMakePoints(r1, r2, points)
	if not points then
		points = {}
		
		for i = 0, circleSides_ do
			table.insert(points, {x = 0, y = 0})
		end
	end
	
	local da	= 2 * math.pi / circleSides_
	local sin	= math.sin
	local cos	= math.cos

	for i, point in ipairs(points) do
		local angle = da * (i - 1)
		
		point.x = r1 * sin(angle)
		point.y = r2 * cos(angle)
	end
	
	return points
end

local function polygonOvalOnMouseDown(x, y)
	local mapX, mapY	= MapWindow.getMapPoint(x, y)

	local newPrimitiveInfo	= newPrimitiveInfo_[Primitive.Polygon]
	local colorString		= newPrimitiveInfo.colorString
	local fillColorString	= newPrimitiveInfo.fillColorString
	local style				= newPrimitiveInfo.style
	local mapData			= {
		objectType			= 'Polygon'								,
		points				= polygonOvalMakePoints(0, 0)			,
		thickness			= newPrimitiveInfo.thickness[style]		,
		color				= colorFromString(colorString		)	,
		fillColor			= colorFromString(fillColorString	)	,
		file				= lineStyles_[style].file			,
		x 					= mapX									,
		y 					= mapY									,
		angle 				= 0										,
	}
	
	local oval = {
		primitiveType		= Primitive.Polygon						,
		polygonMode			= PolygonMode.Oval						,
		name				= createNewPrimitiveName(Primitive.Polygon),
		mapId				= MapWindow.createDrawObject(mapData)	,
		mapData				= mapData								,
		colorString			= colorString							,
		fillColorString		= fillColorString						,
		style				= style									,
		thickness			= {[style] = newPrimitiveInfo.thickness[style]}, -- сохраняем толщину для каждого типа линии
		r1					= 100										,
		r2					= 100										,
		visible				= true									,
		layerName			= currLayerName_						,
	}
	
	objectAdd(oval)
	
	return oval
end

local function polygonRectOnMouseDown(x, y)
	local mapX, mapY		= MapWindow.getMapPoint(x, y)
	local points			= {}
	
	for i = 1, 5 do
		table.insert(points, {x = 0, y = 0})
	end
	
	local newPrimitiveInfo	= newPrimitiveInfo_[Primitive.Polygon]
	local colorString		= newPrimitiveInfo.colorString
	local fillColorString	= newPrimitiveInfo.fillColorString
	local style				= newPrimitiveInfo.style
	local mapData			= {
		objectType			= 'Polygon'							,
		points				= points							,
		thickness			= newPrimitiveInfo.thickness[style]	,
		color				= colorFromString(colorString)		,
		fillColor			= colorFromString(fillColorString)	,
		file				= lineStyles_[style].file		,
		x 					= mapX								,
		y 					= mapY								,
		angle				= 0									,
	}
	
	local rect = {
		primitiveType		= Primitive.Polygon					,
		polygonMode			= PolygonMode.Rect					,
		name				= createNewPrimitiveName(Primitive.Polygon),
		mapId				= MapWindow.createDrawObject(mapData),
		mapData				= mapData							,
		colorString			= colorString						,
		fillColorString		= fillColorString					,
		style				= style								,
		thickness			= {[style] = newPrimitiveInfo.thickness[style]}, -- сохраняем толщину для каждого типа линии
		width				= 0									,
		height				= 0									,
		startX				= mapX								,
		startY				= mapY								,
		visible				= true								,
		layerName			= currLayerName_					,
	}
	
	objectAdd(rect)
	
	return rect
end

local function polygonFreeOnMouseDown(x, y)
	local mapX, mapY		= MapWindow.getMapPoint(x, y)
	
	local newPrimitiveInfo	= newPrimitiveInfo_[Primitive.Polygon]
	local colorString		= newPrimitiveInfo.colorString
	local fillColorString	= newPrimitiveInfo.fillColorString
	local style				= newPrimitiveInfo.style
	local mapData			= {
		objectType			= 'Polygon'							,
		points				= {{x = 0, y = 0}, {x = 0, y = 0}, {x = 0, y = 0}},
		thickness			= newPrimitiveInfo.thickness[style]	,
		color				= colorFromString(colorString)		,
		fillColor			= colorFromString(fillColorString)	,
		file				= lineStyles_[style].file		,
		x 					= mapX								,
		y 					= mapY								,
	}
	
	local polygon = {
		primitiveType		= Primitive.Polygon					,
		polygonMode			= PolygonMode.Free					,
		name				= createNewPrimitiveName(Primitive.Polygon),
		mapId				= MapWindow.createDrawObject(mapData),
		mapData				= mapData							,
		colorString			= colorString						,
		fillColorString		= fillColorString					,
		style				= style								,
		thickness			= {[style] = newPrimitiveInfo.thickness[style]}, -- сохраняем толщину для каждого типа линии
		visible				= true								,
		layerName			= currLayerName_					,
	}
	
	objectAdd(polygon)
	
	currLastMouseX_ = x
	currLastMouseY_ = y
	polygonFreeDragged_ = false
	
	return polygon
end

local function polygonArrowMakePoints(length, points)
	if not points then
		points = {}
	
		for i = 1, 8 do
			table.insert(points, {x = 0, y = 0})
		end
	end
	--  . 
	-- /|\ X
	--  |
	--  |_____________\ Y
	--                /
	local halfLegHeight 	= length / 8
	local headLength		= length / 3
	local legLength			= length - headLength
	local halfHeadHeight	= length / 3
	
	points[1].x = 0 + halfLegHeight
	points[1].y = 0
	
	points[2].x = 0 + halfLegHeight
	points[2].y = 0 + legLength
	
	points[3].x = 0 + halfHeadHeight
	points[3].y = 0 + legLength
	
	points[4].x = 0
	points[4].y = 0 + length
	
	points[5].x = 0 - halfHeadHeight
	points[5].y = 0 + legLength
	
	points[6].x = 0 - halfLegHeight
	points[6].y = 0 + legLength	
	
	points[7].x = 0 - halfLegHeight
	points[7].y = 0

	points[8].x = points[1].x
	points[8].y = points[1].y
	
	return points
end

local function polygonArrowOnMouseDown(x, y)
	local mapX, mapY		= MapWindow.getMapPoint(x, y)
	local newPrimitiveInfo	= newPrimitiveInfo_[Primitive.Polygon]
	local colorString		= newPrimitiveInfo.colorString
	local fillColorString	= newPrimitiveInfo.fillColorString
	local style				= newPrimitiveInfo.style
	local mapData			= {
		objectType			= 'Polygon'							,
		points				= polygonArrowMakePoints(0)			,
		thickness			= newPrimitiveInfo.thickness[style]	,
		color				= colorFromString(colorString)		,
		fillColor			= colorFromString(fillColorString)	,
		file				= lineStyles_[style].file		,
		x 					= mapX								,
		y 					= mapY								,
		angle				= 0									,
	}
	
	local polygon = {
		primitiveType		= Primitive.Polygon					,
		polygonMode			= PolygonMode.Arrow					,
		name				= createNewPrimitiveName(Primitive.Polygon),
		mapId				= MapWindow.createDrawObject(mapData),
		mapData				= mapData							,
		colorString			= colorString						,
		fillColorString		= fillColorString					,
		style				= style								,
		thickness			= {[style] = newPrimitiveInfo.thickness[style]}, -- сохраняем толщину для каждого типа линии
		visible				= true								,
		layerName			= currLayerName_					,
		length				= 0									,
	}
	
	objectAdd(polygon)
	
	return polygon
end

local function polygonRectMakePoints(height, width, points)
	if not points then
		points = {}
		
		for i = 1, 5 do
			table.insert(points, {x = 0, y = 0})
		end
	end
	-- делаем точки относительно центра прямоугольника
	local h_2	= height / 2
	local w_2	= width	 / 2
	
	-- left top
	points[1].x =  h_2
	points[1].y = -w_2
	
	-- right top
	points[2].x =  h_2
	points[2].y =  w_2
	
	-- right bottom
	points[3].x = -h_2
	points[3].y =  w_2
	
	-- left bottom
	points[4].x = -h_2
	points[4].y = -w_2

	points[5].x = points[1].x
	points[5].y = points[1].y
	
	return points
end

local function textBoxOnMouseDown(x, y)
	local mapX, mapY		= MapWindow.getMapPoint(x, y)
	local newPrimitiveInfo	= newPrimitiveInfo_[Primitive.TextBox]
	local colorString		= newPrimitiveInfo.colorString
	local fillColorString	= newPrimitiveInfo.fillColorString
	local borderThickness	=  newPrimitiveInfo.borderThickness
	
	local mapData = {
		objectType			= Primitive.TextBox					,
		x					= mapX								,
		y					= mapY								,
		angle				= 0									,
		color				= colorFromString(colorString)		,
		text				= newPrimitiveInfo.text				,
		font				= 'DejaVuLGCSansCondensed.ttf'		,
		fontSize			= newPrimitiveInfo.fontSize			,
		fillColor			= colorFromString(fillColorString)	,
		borderThickness		= borderThickness					,
	}
	
	local textBox = {
		primitiveType		= Primitive.TextBox					,
		name				= createNewPrimitiveName(Primitive.TextBox),
		mapId				= MapWindow.createDrawObject(mapData),
		mapData				= mapData							,
		colorString			= colorString						,
		fillColorString		= fillColorString					,
		visible				= true								,
		layerName			= currLayerName_					,
	}
	
	objectAdd(textBox)
	
	return textBox
end

local function iconOnMouseDown(x, y)
	local mapX, mapY		= MapWindow.getMapPoint(x, y)
	local newPrimitiveInfo	= newPrimitiveInfo_[Primitive.Icon]
	local colorString		= newPrimitiveInfo.colorString
	local file				= newPrimitiveInfo.file
	local scale				= newPrimitiveInfo.scale
	
	local mapData = {
		objectType			= Primitive.Icon				,
		x					= mapX							,
		y					= mapY							,
		angle				= 0								,
		color				= colorFromString(colorString)	,
		file				= file							,
		scale				= scale							,
	}
	
	local icon = {
		primitiveType		= Primitive.Icon				,
		name				= createNewPrimitiveName(Primitive.Icon),
		file				= file							,
		mapId				= MapWindow.createDrawObject(mapData),
		mapData				= mapData						,
		colorString			= colorString					,
		visible				= true							,
		layerName			= currLayerName_				,
	}
	
	objectAdd(icon)
	
	return icon
end

local function objectGetRotatable(object)
	if object.primitiveType == Primitive.TextBox then
		return true
	end
	
	if object.primitiveType == Primitive.Icon then
		return true
	end	
	
	if object.primitiveType == Primitive.Polygon then
		return 	currObject_.polygonMode == PolygonMode.Oval or 
				currObject_.polygonMode == PolygonMode.Rect
	end
	
	return false
end

local function onMouseDown(x, y, button)
	if 1 == button then
		lastMouseDownPos_.x = x
		lastMouseDownPos_.y = y
		
		if currPrimitiveType_ == Primitive.Line then
			if not newObject_ then
				if lineMode_ == LineMode.Free		then
					newObject_ = lineFreeOnMouseDown(x, y)
				elseif lineMode_ == LineMode.Segment	then
					newObject_ = lineSegmentOnMouseDown(x, y)
				elseif lineMode_ == LineMode.Segments	then
					newObject_ = lineSegmentsOnMouseDown(x, y)
				end
				
				setPropertiesPanel(newObject_)
			end
		elseif 	currPrimitiveType_ == Primitive.Polygon then
			if not newObject_ then
				if polygonMode_ == PolygonMode.Circle then
					newObject_ = polygonCircleOnMouseDown(x, y)
				elseif polygonMode_ == PolygonMode.Oval then
					newObject_ = polygonOvalOnMouseDown(x, y)					
				elseif polygonMode_ == PolygonMode.Rect then
					newObject_ = polygonRectOnMouseDown(x, y)
				elseif polygonMode_ == PolygonMode.Free then
					newObject_ = polygonFreeOnMouseDown(x, y)
				elseif polygonMode_ == PolygonMode.Arrow then
					newObject_ = polygonArrowOnMouseDown(x, y)
				end
				
				setPropertiesPanel(newObject_)
			end
		elseif	currPrimitiveType_ == Primitive.TextBox then
			newObject_ = textBoxOnMouseDown(x, y)
			setPropertiesPanel(newObject_)
		elseif	currPrimitiveType_ == Primitive.Icon then
			newObject_ = iconOnMouseDown(x, y)
			setPropertiesPanel(newObject_)			
		else
			-- выбираем объект на карте
			local mapX, mapY	= MapWindow.getMapPoint(x, y)
			local radius		= MapWindow.getMapSize(0, 10)
			local mapIds		= MapWindow.findDrawObjects(mapX, mapY, radius)
			
			selectionHandlerIndex_	= nil
			
			-- если есть выбранный объект,
			-- то вначале ищем среди хендлеров выбранного объекта
			if currObject_ then
				for i = #mapIds, 1, -1 do
					local mapId = mapIds[i]
					
					for j, selectionHandler in ipairs(selectionHandlers_) do
						if selectionHandler.mapId == mapId then
							selectionHandlerIndex_ = j
							
							break
						end	
					end
					
					if selectionHandlerIndex_ then
						break
					end
				end
				
				if not selectionHandlerIndex_ then
					for i = #mapIds, 1, -1 do
						local mapId = mapIds[i]
						
						if mapId == currObject_.mapId then
							selectionHandlerIndex_ = 0
							
							break
						end
					end
				end
			end

			if selectionHandlerIndex_ then
				if objectGetRotatable(currObject_) then
					local mapX, mapY	= MapWindow.getMapPoint(x, y)
					local x1			= mapX - currObject_.mapData.x
					local y1			= mapY - currObject_.mapData.y	
					local mouseAngle	= math.atan2(y1, x1) - math.pi / 2
					
					currObject_.initialAngle = mouseAngle * 180 / math.pi - currObject_.mapData.angle -- нужно только для TextBox и Icon
				end
			else
				-- если хендлеров нет, то выбираем новый объект
				local foundObject
				
				for i = #mapIds, 1, -1 do	
					local mapId = mapIds[i]
					
					for j, layer in ipairs(layers_) do
						for k = #layer.objects ,1, -1 do
							local object = layer.objects[k]
								
							if object.mapId == mapId then
							
								foundObject = object
								selectionHandlerIndex_ = 0
								
								break
							end								
						end
					end
					
					if foundObject then
						break
					end
				end

				objectSelect(foundObject)
			end
		end
	end
end

local function lineSegmentsOnMouseUp(x, y)
	local mapX, mapY	= MapWindow.getMapPoint(x, y)
	local pointX		= mapX - newObject_.mapData.x
	local pointY		= mapY - newObject_.mapData.y
	local points		= newObject_.mapData.points
	
	-- добавляем новую точку, 
	-- чтобы при движении мыши было видно последний отрезок
	table.insert(points, {x = pointX, y = pointY})
	
	local count = #points
	
	if count > 3 then
		if 	pointX == points[count - 1].x and 
			pointX == points[count - 2].x and
			pointY == points[count - 1].y and 
			pointY == points[count - 2].y then
			
			-- удаляем последнюю точку
			table.remove(points)
			
			-- в начале и конце линии точки могут дублироваться
			if 	points[1].x == points[2].x and
				points[1].y == points[2].y then
				
				table.remove(points, 1)
			end
			
			count = #points
			
			if points[count] and points[count - 1] then
				if 	points[count].x == points[count - 1].x and
					points[count].y == points[count - 1].y then
					
					table.remove(points)
				end
			end
			
			if #points > 1 then
				MapWindow.updateDrawObject(newObject_.mapId, newObject_.mapData)
				
				-- начинаем новую линию
				objectSelectNew()
			else
				deleteIncomleteNewObject()
			end
		end	
	end
end

local function lineSegmentOnMouseUp(x, y)
	local points = newObject_.mapData.points
	
	if not points[2] or	(	points[1].x == points[2].x and
							points[1].y == points[2].y) then
		deleteIncomleteNewObject()
	else
		objectSelectNew()
	end
end

local function lineFreeOnMouseUp(x, y)
	local points = newObject_.mapData.points
	
	if not points[2] then
		deleteIncomleteNewObject()
	else	
		objectSelectNew()
	end
end

local function polygonFreeOnMouseUp(x, y)
	local mapX, mapY	= MapWindow.getMapPoint(x, y)
	local pointX		= mapX - newObject_.mapData.x
	local pointY		= mapY - newObject_.mapData.y
	local points		= newObject_.mapData.points
	
	-- добавляем новую точку перед последней точкой, 
	local count = #points
	
	table.insert(points, count - 1, {x = pointX, y = pointY})
	
	count = count + 1
	
	if count > 4 then
		-- если три последние точки одинаковые, 
		-- то заканчиваем полигон
		if(	pointX == points[count - 1].x and
			pointY == points[count - 1].y and
			pointX == points[count - 2].x and
			pointY == points[count - 2].y and
			pointX == points[count - 3].x and
			pointY == points[count - 3].y) or polygonFreeDragged_ then
			
			table.remove(points, count - 1)
			table.remove(points, count - 2)
			
			-- первая и вторая точки могут совпадать
			if 	points[1].x == points[2].x and
				points[1].y == points[2].y then
				
				table.remove(points, 1)
			end	
			
			if #points == 3 then
				deleteIncomleteNewObject()
			else			
				MapWindow.updateDrawObject(newObject_.mapId, newObject_.mapData)
				objectSelectNew()
			end
		else
			MapWindow.updateDrawObject(newObject_.mapId, newObject_.mapData)			
		end	
	end
end

local function onMouseUp(x, y, button)
	if 1 == button then
		if currPrimitiveType_ == Primitive.Line then
			if lineMode_ == LineMode.Free then
				lineFreeOnMouseUp()
			elseif lineMode_ == LineMode.Segment then
				lineSegmentOnMouseUp(x, y)
			elseif lineMode_ == LineMode.Segments then
				lineSegmentsOnMouseUp(x, y)
			end
		elseif currPrimitiveType_ == Primitive.Polygon then
			if polygonMode_ == PolygonMode.Free then
				polygonFreeOnMouseUp(x, y)
			else
				objectSelectNew()
			end
		elseif currPrimitiveType_ == Primitive.TextBox then
			objectSelectNew()
		elseif currPrimitiveType_ == Primitive.Icon then
			objectSelectNew()			
		end
		
		if	lastMouseDownPos_.x == x and
			lastMouseDownPos_.y == y then
			
			if lastObjectToRotate_ then
				-- если selectionHandlerIndex_ == 0, то ткнули в текущий объект,
				-- иначе ткнули в какой-то из хендлеров объекта
				if lastObjectToRotate_ == currObject_ and selectionHandlerIndex_ == 0 then
					-- мышой вращаем только прямоугольники, овалы и текст
					
					if objectGetRotatable(currObject_) then							
						rotateObject_ = not rotateObject_
						selectionHandlesUpdate(currObject_)
					end
				end
			else
				lastObjectToRotate_ = currObject_
			end
		end	
	end
end

local function lineFreeNewOnMouseDrag(x, y)
	local mapX, mapY	= MapWindow.getMapPoint(x, y)
	local points		= newObject_.mapData.points
	local pointX		= mapX - newObject_.mapData.x
	local pointY		= mapY - newObject_.mapData.y
	
	if (x - currLastMouseX_) * (x - currLastMouseX_) + (y - currLastMouseY_) * (y - currLastMouseY_) > 10 * 10 then
		-- курсор сдвинули относительно последней позиции больше чем на 10 пикселей
		-- добавим точку к линии
		local point = {
			x = pointX,
			y = pointY,
		}
		
		table.insert(points, point)
		
		MapWindow.updateDrawObject(newObject_.mapId, newObject_.mapData)
		
		currLastMouseX_ = x
		currLastMouseY_ = y
	else
		local pointEnd = points[#points] -- последняя точка
		
		pointEnd.x = pointX
		pointEnd.y = pointY
		
		MapWindow.updateDrawObject(newObject_.mapId, newObject_.mapData)
	end
end

local function lineSegmentNewOnMouseDrag(x, y)
	local mapX, mapY	= MapWindow.getMapPoint(x, y)
	local points		= newObject_.mapData.points
	local pointX		= mapX - newObject_.mapData.x
	local pointY		= mapY - newObject_.mapData.y
	local pointEnd		= points[2]
				
	if pointEnd then
		pointEnd.x = pointX
		pointEnd.y = pointY
	else	
		pointEnd = {
			x = pointX,
			y = pointY,
		}
		
		table.insert(points, pointEnd)
	end
	
	MapWindow.updateDrawObject(newObject_.mapId, newObject_.mapData)
end

local function lineSegmentsNewOnMouseDrag(x, y)
	local mapX, mapY	= MapWindow.getMapPoint(x, y)
	local points		= newObject_.mapData.points
	local pointX		= mapX - newObject_.mapData.x
	local pointY		= mapY - newObject_.mapData.y
	local pointEnd		= points[#points]
				
	if pointEnd then
		pointEnd.x = pointX
		pointEnd.y = pointY
	else	
		pointEnd = {
			x = pointX,
			y = pointY,
		}
		
		table.insert(points, pointEnd)
	end
	
	MapWindow.updateDrawObject(newObject_.mapId, newObject_.mapData)
end

local function polygonCircleMakePoints(radius, points)
	if not points then
		points = {}
		
		for i = 0, circleSides_ do
			table.insert(points, {x = 0, y = 0})
		end
	end
	
	local da	= 2 * math.pi / circleSides_
	local sin	= math.sin
	local cos	= math.cos

	for i, point in ipairs(points) do
		local angle = da * (i - 1)
		
		point.x = radius * sin(angle)
		point.y = radius * cos(angle)
	end
	
	return points
end

function polygonCircleRadiusUpdate(circle) -- объявлена выше	
	polygonCircleMakePoints(circle.radius, circle.mapData.points)
	
	MapWindow.updateDrawObject(circle.mapId	, circle.mapData)
end

local function polygonCircleNewOnMouseDrag(x, y)
	local mapX, mapY	= MapWindow.getMapPoint(x, y)
	local dx 			= mapX - newObject_.mapData.x
	local dy 			= mapY - newObject_.mapData.y
	local radius		= math.sqrt(dx * dx + dy * dy)
	
	newObject_.radius	= radius
	
	polygonCircleRadiusUpdate	(newObject_)
	updatePropertiesPanel		(newObject_)
end

-- объявлена выше
function polygonOvalUpdateSize(oval)
	polygonOvalMakePoints(oval.r1, oval.r2, oval.mapData.points)
	
	MapWindow.updateDrawObject(oval.mapId, oval.mapData)
end

local function polygonOvalNewOnMouseDrag(x, y)
	local mapX, mapY	= MapWindow.getMapPoint(x, y)
	
	newObject_.r2		= math.abs(mapY - newObject_.mapData.y)
	newObject_.r1		= math.abs(mapX - newObject_.mapData.x)
	
	polygonOvalUpdateSize(newObject_)
	updatePropertiesPanel(newObject_)
end

-- объявлена выше
function polygonRectUpdateSize(rect)
	polygonRectMakePoints(rect.height, rect.width, rect.mapData.points)
	
	MapWindow.updateDrawObject(rect.mapId, rect.mapData)
end

local function polygonRectNewOnMouseDrag(x, y)
	local mapX, mapY	= MapWindow.getMapPoint(x, y)
	local rect			= newObject_
	local deltaH		= mapX - rect.startX
	local deltaW		= mapY - rect.startY
		
	rect.width			= math.abs(deltaW)
	rect.height			= math.abs(deltaH)
		
	rect.mapData.x		= rect.startX + deltaH / 2
	rect.mapData.y		= rect.startY + deltaW / 2
	
	polygonRectUpdateSize(rect)
	updatePropertiesPanel(rect)
end

local function polygonFreeNewOnMouseDrag(x, y)
	local mapX, mapY	= MapWindow.getMapPoint(x, y)
	local points		= newObject_.mapData.points
	local pointX		= mapX - newObject_.mapData.x
	local pointY		= mapY - newObject_.mapData.y
	
	if (x - currLastMouseX_) * (x - currLastMouseX_) + (y - currLastMouseY_) * (y - currLastMouseY_) > 10 * 10 then
		-- курсор сдвинули относительно последней позиции больше чем на 10 пикселей
		-- добавим точку к линии
		local point = {
			x = pointX,
			y = pointY,
		}
		
		table.insert(points, #points - 1, point)
		
		MapWindow.updateDrawObject(newObject_.mapId, newObject_.mapData)
		
		currLastMouseX_ = x
		currLastMouseY_ = y
	else
		local pointEnd = points[#points - 1] -- последняя точка
		
		pointEnd.x = pointX
		pointEnd.y = pointY
		
		MapWindow.updateDrawObject(newObject_.mapId, newObject_.mapData)
	end
	
	polygonFreeDragged_ = true
end

local function polygonArrowNewOnMouseDrag(x, y)
	local mapX, mapY	= MapWindow.getMapPoint(x, y)
	local deltaX		= mapX - newObject_.mapData.x
	local deltaY		= mapY - newObject_.mapData.y
	
	newObject_.mapData.angle	= -math.atan2(deltaX, deltaY) * 180 / math.pi
	newObject_.length			=  math.sqrt(deltaX * deltaX + deltaY * deltaY)
	
	polygonArrowMakePoints(newObject_.length, newObject_.mapData.points)
	objectUpdateSpinBoxAngle(newObject_.mapData.angle, propertyPanels_[newObject_.primitiveType])

	MapWindow.updateDrawObject(newObject_.mapId, newObject_.mapData)	
end

local function textBoxNewOnMouseDrag(x, y)
	local mapX, mapY	= MapWindow.getMapPoint(x, y)
	
	newObject_.mapData.x = mapX
	newObject_.mapData.y = mapY
	
	MapWindow.updateDrawObject(newObject_.mapId, newObject_.mapData)	
end

local function iconNewOnMouseDrag(x, y)
	local mapX, mapY	= MapWindow.getMapPoint(x, y)
	
	newObject_.mapData.x = mapX
	newObject_.mapData.y = mapY
	
	MapWindow.updateDrawObject(newObject_.mapId, newObject_.mapData)	
end

local function lineCurrOnMouseDrag(x, y, dx, dy)
	local mapX	, mapY	= MapWindow.getMapPoint(x, y)
	local mapDx	, mapDy	= MapWindow.getMapSize(dx, dy, true)

	if selectionHandlerIndex_ == 0 then
		-- перемещаем линию целиком
		local x = currObject_.mapData.x + mapDx
		local y = currObject_.mapData.y + mapDy
		
		currObject_.mapData.x = x
		currObject_.mapData.y = y
		
		MapWindow.updateDrawObject(currObject_.mapId, {x = x, y = y})
		
		selectionHandlesUpdate(currObject_)
	else
		-- линию схватили за хэндл
		-- изменяем только одну точку линии
		local point				= currObject_.mapData.points[selectionHandlerIndex_]
		local selectionHandler	= selectionHandlers_		[selectionHandlerIndex_]
		
		point.x = point.x + mapDx
		point.y = point.y + mapDy
		
		selectionHandler.mapData.x = currObject_.mapData.x + point.x
		selectionHandler.mapData.y = currObject_.mapData.y + point.y
		
		MapWindow.updateDrawObject(currObject_		.mapId	, currObject_		.mapData)
		MapWindow.updateDrawObject(selectionHandler.mapId	, selectionHandler	.mapData)
	end
end

local function polygonCircleCurrOnMouseDrag(x, y)
	-- круг схватили за хэндл
	-- изменяем радиус круга
	local mapX, mapY	= MapWindow.getMapPoint(x, y)
	local dx 			= mapX - currObject_.mapData.x
	local dy 			= mapY - currObject_.mapData.y
	local radius 		= math.sqrt(dx * dx + dy * dy)
	
	currObject_.radius 	= radius
	
	polygonCircleRadiusUpdate	(currObject_)
	selectionHandlesUpdate		(currObject_)
	updatePropertiesPanel		(currObject_)
end

local function polygonOvalCurrResize(x, y)
	-- овал схватили за хэндл
	-- изменяем радиусы овала
	local mapX, mapY	= MapWindow.getMapPoint(x, y)
	local r1			= currObject_.r1
	local r2			= currObject_.r2	
	local angle			= (currObject_.mapData.angle / 180) * math.pi
	local x1			= mapX - currObject_.mapData.x
	local y1			= mapY - currObject_.mapData.y
	
	if selectionHandlerIndex_ == 1 then -- top
		local x2 = r1 * math.cos(angle)
		local y2 = r1 * math.sin(angle)
		
		-- ищем проекцию вектора (x1, y1) на вектор (x2, y2)
		local scalar	= x1 * x2 + y1 * y2
		local proj		= scalar / r1

		currObject_.r1	= math.abs(proj)		
	elseif selectionHandlerIndex_ == 2 then -- right
		
		local x2 = -r2 * math.sin(angle)
		local y2 =  r2 * math.cos(angle)
		
		-- ищем проекцию вектора (x1, y1) на вектор (x2, y2)
		local scalar	= x1 * x2 + y1 * y2
		local proj		= scalar / r2

		currObject_.r2	= math.abs(proj)
	elseif selectionHandlerIndex_ == 3 then -- bottom
		local x2 = -r1 * math.cos(angle)
		local y2 = -r1 * math.sin(angle)
		
		-- ищем проекцию вектора (x1, y1) на вектор (x2, y2)
		local scalar	= x1 * x2 + y1 * y2
		local proj		= scalar / r1

		currObject_.r1	= math.abs(proj)
	elseif selectionHandlerIndex_ == 4 then -- left
		local x2 =  r2 * math.sin(angle)
		local y2 = -r2 * math.cos(angle)
		
		-- ищем проекцию вектора (x1, y1) на вектор (x2, y2)
		local scalar	= x1 * x2 + y1 * y2
		local proj		= scalar / r2
		
		currObject_.r2	= math.abs(proj)
	end
	
	if currObject_.r1 <= 0 then
		currObject_.r1 = 0.001
	end
	
	if currObject_.r2 <= 0 then
		currObject_.r2 = 0.001
	end
	
	polygonOvalUpdateSize	(currObject_)
	selectionHandlesUpdate	(currObject_)
	updatePropertiesPanel	(currObject_)
end

local function polygonOvalCurrRotate(x, y)
	-- овал схватили за хэндл
	-- поворачиваем овал
	local mapX, mapY	= MapWindow.getMapPoint(x, y)
	-- вектор из центра прямоугольника к курсору
	local x1			= mapX - currObject_.mapData.x
	local y1			= mapY - currObject_.mapData.y	
	local mouseAngle	= math.atan2(y1, x1)
	local initialAngle
	
	if selectionHandlerIndex_ == 1 then -- top
		initialAngle = 0
	elseif selectionHandlerIndex_ == 2 then -- right
		initialAngle = math.pi / 2
	elseif selectionHandlerIndex_ == 3 then -- bottom
		initialAngle = math.pi
	elseif selectionHandlerIndex_ == 4 then -- left
		initialAngle = math.pi * 3 / 2
	end
	
	currObject_.mapData.angle = (mouseAngle - initialAngle) * 180 / math.pi
	selectionHandlesUpdate		(currObject_)
	MapWindow.updateDrawObject	(currObject_.mapId, currObject_.mapData)
	objectUpdateSpinBoxAngle	(currObject_.mapData.angle, propertyPanels_[currObject_.primitiveType])		
end

local function polygonOvalCurrOnMouseDrag(x, y)
	if rotateObject_ then
		polygonOvalCurrRotate(x, y)
	else
		polygonOvalCurrResize(x, y)
	end	
end

local function polygonRectCurrResize(x, y)
	-- прямоугольник схватили за хэндл
	-- изменяем размер прямоугольника
	local mapX, mapY	= MapWindow.getMapPoint(x, y)	
	local w_2			= math.abs(currObject_.width	/ 2) -- halfWidth
	local h_2			= math.abs(currObject_.height	/ 2) -- halfHeight
	local angle			= (currObject_.mapData.angle	/ 180) * math.pi
	-- центр прямоугольника
	local cx 			= currObject_.mapData.x
	local cy 			= currObject_.mapData.y	
	-- вектор из центра прямоугольника к курсору
	local x1			= mapX - cx
	local y1			= mapY - cy
	local sinAngle		= math.sin(angle)
	local cosAngle		= math.cos(angle)
	-- переводим вектор в систему координат повернутого прямоугольника
	local x11			= x1 * cosAngle + y1 * sinAngle
	local y11			= y1 * cosAngle - x1 * sinAngle
	-- смещение центра прямоугольника
	local deltaCx
	local deltaCy

	if selectionHandlerIndex_ == 1 then -- left top
		deltaCx				= (x11 - h_2) / 2
		deltaCy				= (y11 + w_2) / 2
		
		currObject_.height	= x11 + h_2
		currObject_.width	= w_2 - y11
	elseif selectionHandlerIndex_ == 2 then -- right top
		deltaCx				= (x11 - h_2) / 2
		deltaCy				= (y11 - w_2) / 2

		currObject_.height	= x11 + h_2
		currObject_.width	= y11 + w_2
	elseif selectionHandlerIndex_ == 3 then -- right bottom
		deltaCx				= (x11 + h_2) / 2
		deltaCy				= (y11 - w_2) / 2
		
		currObject_.height	= h_2 - x11
		currObject_.width	= y11 + w_2
	elseif selectionHandlerIndex_ == 4 then -- left bottom
		deltaCx				= (x11 + h_2) / 2
		deltaCy				= (y11 + w_2) / 2
		
		currObject_.height	= h_2 - x11
		currObject_.width	= w_2 - y11
	end
	
	currObject_.mapData.x	= cx + deltaCx * cosAngle - deltaCy * sinAngle
	currObject_.mapData.y	= cy + deltaCy * cosAngle + deltaCx * sinAngle
	
	polygonRectUpdateSize	(currObject_)
	selectionHandlesUpdate	(currObject_)
	updatePropertiesPanel	(currObject_)
end

local function polygonRectCurrRotate(x, y)
	-- прямоугольник схватили за хэндл
	-- поворачиваем прямоугольник
	local mapX, mapY	= MapWindow.getMapPoint(x, y)	
	local w_2			= math.abs(currObject_.width	/ 2) -- halfWidth
	local h_2			= math.abs(currObject_.height	/ 2) -- halfHeight
	-- вектор из центра прямоугольника к курсору
	local x1			= mapX - currObject_.mapData.x
	local y1			= mapY - currObject_.mapData.y	
	local mouseAngle	= math.atan2(y1, x1)
	local initialAngle
	
	if selectionHandlerIndex_ == 1 then -- left top
		initialAngle = math.atan2(-w_2, h_2)		
	elseif selectionHandlerIndex_ == 2 then -- right top
		initialAngle = math.atan2(w_2, h_2)
	elseif selectionHandlerIndex_ == 3 then -- right bottom
		initialAngle = math.atan2(w_2, -h_2)
	elseif selectionHandlerIndex_ == 4 then -- left bottom
		initialAngle = math.atan2(-w_2, -h_2)		
	end
	
	currObject_.mapData.angle = (mouseAngle - initialAngle) * 180 / math.pi
	selectionHandlesUpdate		(currObject_)
	MapWindow.updateDrawObject	(currObject_.mapId, currObject_.mapData)
	objectUpdateSpinBoxAngle	(currObject_.mapData.angle, propertyPanels_[currObject_.primitiveType])	
end

local function polygonRectCurrOnMouseDrag(x, y)
	if rotateObject_ then
		polygonRectCurrRotate(x, y)
	else
		polygonRectCurrResize(x, y)
	end
end

local function polygonFreeCurrOnMouseDrag(dx, dy)
	-- полигон схватили за хэндл
	-- изменяем только одну точку полигона
	local mapDx	, mapDy	= MapWindow.getMapSize(dx, dy, true)
	
	local points = currObject_.mapData.points
	local movePointAndHandler 	= function(index)
		local point				= points			[index]
		local selectionHandler	= selectionHandlers_[index]		

		point.x = point.x + mapDx
		point.y = point.y + mapDy
		
		selectionHandler.mapData.x = currObject_.mapData.x + point.x
		selectionHandler.mapData.y = currObject_.mapData.y + point.y
		
		MapWindow.updateDrawObject(selectionHandler.mapId, selectionHandler.mapData)
	end
	
	movePointAndHandler(selectionHandlerIndex_)
	
	-- если это первая и последняя точки,
	-- то их нужно двигать вместе
	local pointCount = #points
	
	if selectionHandlerIndex_ == 1 then
		movePointAndHandler(pointCount)
	elseif selectionHandlerIndex_ == pointCount then
		movePointAndHandler(1)
	end
	
	MapWindow.updateDrawObject(currObject_.mapId, currObject_.mapData)
end

local function polygonArrowCurrOnMouseDrag(x, y)
	local mapX, mapY	= MapWindow.getMapPoint(x, y)
	local deltaX		= mapX - currObject_.mapData.x
	local deltaY		= mapY - currObject_.mapData.y
	local length		= math.sqrt(deltaX * deltaX + deltaY * deltaY)
	
	currObject_.length	= length
	currObject_.mapData.angle = -math.atan2(deltaX, deltaY) * 180 / math.pi

	polygonArrowUpdateSelectionHandles(currObject_)
	polygonArrowMakePoints(length, currObject_.mapData.points)
	objectUpdateSpinBoxAngle(currObject_.mapData.angle, propertyPanels_[currObject_.primitiveType])
	
	MapWindow.updateDrawObject(currObject_.mapId, currObject_.mapData)
end

local function polygonCurrOnMouseDrag(x, y, dx, dy)
	if selectionHandlerIndex_ == 0 then		
		local mapX, mapY	= MapWindow.getMapPoint(x, y)
		
		currObject_.mapData.x = mapX
		currObject_.mapData.y = mapY

		MapWindow.updateDrawObject(currObject_.mapId, {x = mapX, y = mapY}) -- обновляем только позицию
		selectionHandlesUpdate(currObject_)
	else		
		if currObject_.polygonMode == PolygonMode.Circle then
			polygonCircleCurrOnMouseDrag(x, y)
		elseif currObject_.polygonMode == PolygonMode.Oval then
			polygonOvalCurrOnMouseDrag(x, y)
		elseif currObject_.polygonMode == PolygonMode.Rect then
			polygonRectCurrOnMouseDrag(x, y)
		elseif 	currObject_.polygonMode == PolygonMode.Free then
			polygonFreeCurrOnMouseDrag(dx, dy)
		elseif 	currObject_.polygonMode == PolygonMode.Arrow then
			polygonArrowCurrOnMouseDrag(x, y)			
		end
	end
end

local function textBoxCurrMove(dx, dy)
	-- перемещаем TextBox целиком
	local mapDx, mapDy	= MapWindow.getMapSize(dx, dy, true)
	local mapX			= currObject_.mapData.x + mapDx
	local mapY			= currObject_.mapData.y + mapDy
	
	currObject_.mapData.x = mapX
	currObject_.mapData.y = mapY
	
	MapWindow.updateDrawObject(currObject_.mapId, {x = mapX, y = mapY}) -- обновляем только позицию
	
	selectionHandlesUpdate(currObject_)	
end

local function textBoxCurrRotate(x, y)
	-- поворачиваем TextBox
	local mapX, mapY	= MapWindow.getMapPoint(x, y)
	-- вектор из позиции текста к курсору
	local x1			= mapX - currObject_.mapData.x
	local y1			= mapY - currObject_.mapData.y	
	local mouseAngle	= math.atan2(y1, x1) - math.pi / 2
	
	currObject_.mapData.angle = (mouseAngle * 180 / math.pi) - currObject_.initialAngle
	MapWindow.updateDrawObject	(currObject_.mapId,  {angle = currObject_.mapData.angle}) -- обновляем только угол
	objectUpdateSpinBoxAngle	(currObject_.mapData.angle, propertyPanels_[currObject_.primitiveType])		
end

local function textBoxCurrOnMouseDrag(x, y, dx, dy)
	if rotateObject_ then
		textBoxCurrRotate(x, y)
	else
		textBoxCurrMove(dx, dy)
	end
end

local function iconCurrMove(dx, dy)
	-- перемещаем Icon целиком
	local mapDx, mapDy	= MapWindow.getMapSize(dx, dy, true)
	local mapX			= currObject_.mapData.x + mapDx
	local mapY			= currObject_.mapData.y + mapDy
	
	currObject_.mapData.x = mapX
	currObject_.mapData.y = mapY
	
	MapWindow.updateDrawObject(currObject_.mapId, {x = mapX, y = mapY}) -- обновляем только позицию
	
	selectionHandlesUpdate(currObject_)	
end

local function iconCurrRotate(x, y)
	-- поворачиваем Icon
	local mapX, mapY	= MapWindow.getMapPoint(x, y)
	-- вектор из позиции текста к курсору
	local x1			= mapX - currObject_.mapData.x
	local y1			= mapY - currObject_.mapData.y	
	local mouseAngle	= math.atan2(y1, x1) - math.pi / 2
	
	currObject_.mapData.angle = (mouseAngle * 180 / math.pi) - currObject_.initialAngle
	MapWindow.updateDrawObject	(currObject_.mapId,  {angle = currObject_.mapData.angle}) -- обновляем только угол
	objectUpdateSpinBoxAngle	(currObject_.mapData.angle, propertyPanels_[currObject_.primitiveType])	
end

local function iconCurrOnMouseDrag(x, y, dx, dy)
	if rotateObject_ then
		iconCurrRotate(x, y)
	else
		iconCurrMove(dx, dy)
	end
end

local function moveObject(a_object, mapX, mapY, mapDx, mapDy)
	if a_object then
		local x = a_object.mapData.x + mapDx
		local y = a_object.mapData.y + mapDy
		a_object.mapData.x = mapX
		a_object.mapData.y = mapY
		
		MapWindow.updateDrawObject(a_object.mapId, {x = x, y = y})
		selectionHandlesUpdate(a_object)
	end
end

local function onMouseDrag(dx, dy, button, x, y)	
	if 1 == button then
		if currPrimitiveType_ == Primitive.Line then
			if lineMode_ == LineMode.Free		then
				lineFreeNewOnMouseDrag(x, y)
			elseif lineMode_ == LineMode.Segment	then
				lineSegmentNewOnMouseDrag(x, y)
			elseif lineMode_ == LineMode.Segments	then
				lineSegmentsNewOnMouseDrag(x, y)
			end
		elseif 	currPrimitiveType_ == Primitive.Polygon then		
			if polygonMode_ == PolygonMode.Circle then
				polygonCircleNewOnMouseDrag(x, y)
			elseif polygonMode_ == PolygonMode.Oval then
				polygonOvalNewOnMouseDrag(x, y)				
			elseif polygonMode_ == PolygonMode.Rect then
				polygonRectNewOnMouseDrag(x, y)
			elseif polygonMode_ == PolygonMode.Free then
				polygonFreeNewOnMouseDrag(x, y)
			elseif polygonMode_ == PolygonMode.Arrow then
				polygonArrowNewOnMouseDrag(x, y)				
			end
		elseif 	currPrimitiveType_ == Primitive.TextBox then
			textBoxNewOnMouseDrag(x, y)
		elseif 	currPrimitiveType_ == Primitive.Icon then
			iconNewOnMouseDrag(x, y)			
		else
			if currObject_ then
				local mapX	, mapY	= MapWindow.getMapPoint(x, y)
				local mapDx	, mapDy	= MapWindow.getMapSize(dx, dy, true)
				
				if currObject_.primitiveType == Primitive.Line then
					lineCurrOnMouseDrag(x, y, dx, dy)
				elseif 	currObject_.primitiveType == Primitive.Polygon then
					polygonCurrOnMouseDrag(x, y, dx, dy)
				elseif 	currObject_.primitiveType == Primitive.TextBox then
					textBoxCurrOnMouseDrag(x, y, dx, dy)
				elseif 	currObject_.primitiveType == Primitive.Icon then
					iconCurrOnMouseDrag(x, y, dx, dy)			
				end
			end
		end
	end
end

local function reset()
	for primitiveType, info in pairs(newPrimitiveInfo_) do
		info.counter = 0
	end
	
	MapWindow.clearDrawObjects()	
	
	gridObjects_:clearRows()
	gridData_ = {}
	
	objectSelect()
	
	selectionHandlersPool_	= {}
	selectionHandlers_		= {}
	selectionHandlerIndex_	= nil
	
	for i, layer in ipairs(layers_) do
		layer.visible = true
		layer.objects = {}
	end
	
	currLayerName_ = 'Author'
	
	hiddenDataReset(hiddenOnF10MapData_	)
end

local loader = function()
	return {
		new = function(self, object)
			self.name				= object.name						
			self.colorString		= object.colorString						
			self.visible			= object.visible				
			self.layerName			= object.layerName	
			self.hiddenOnPlanner	= object.hiddenOnPlanner	
			self.mapData			= {
				color				= colorFromString(object.colorString),
				x 					= object.mapX,
				y 					= object.mapY,
			}				
		
			return self
		end,
		add = function(self, name, value)
			self[name] = value
			
			return self
		end,	
		addMapData = function(self, name, value)
			self.mapData[name] = value
			
			return self
		end,		
		stop = function(self)
			self.mapId	= MapWindow.createDrawObject(self.mapData)
			
			self.new		= nil
			self.add		= nil
			self.addMapData	= nil
			self.stop		= nil
			
			objectAdd(self)
			
			return self
		end
	}
end

local function lineLoad(object)
	loader()
		:new(object)
		:addMapData	('objectType'		, 'Polyline'							)
		:addMapData	('points'			, object.points							)
		:addMapData	('closed'			, object.closed							)
		:addMapData	('thickness'		, object.thickness						)
		:addMapData	('file'				, lineStyles_[object.style].file		)
		:add		('primitiveType'	, Primitive.Line						)
		:add		('lineMode'			, object.lineMode						)
		:add		('style'			, object.style							)
		:add		('thickness'		, {[object.style] = object.thickness}	)
		:stop()
end

local function polygonCircleLoad(object)
	loader()
		:new(object)
		:addMapData	('objectType'		, 'Polygon'									)
		:addMapData	('points'			, polygonCircleMakePoints(object.radius)	)
		:addMapData	('fillColor'		, colorFromString(object.fillColorString)	)
		:addMapData	('thickness'		, object.thickness							)
		:addMapData	('file'				, lineStyles_[object.style].file			)
		:add		('primitiveType'	, Primitive.Polygon							)
		:add		('polygonMode'		, PolygonMode.Circle						)
		:add		('fillColorString'	, object.fillColorString					)
		:add		('style'			, object.style								)
		:add		('thickness'		, {[object.style] = object.thickness}		)
		:add		('radius'			, object.radius								)
		:stop()
end

local function polygonOvalLoad(object)
	loader()
		:new(object)
		:addMapData	('objectType'		, 'Polygon'									)
		:addMapData	('points'			, polygonOvalMakePoints(object.r1, object.r2))
		:addMapData	('fillColor'		, colorFromString(object.fillColorString)	)
		:addMapData	('thickness'		, object.thickness							)
		:addMapData	('file'				, lineStyles_[object.style].file			)
		:addMapData	('angle'			, object.angle								)
		:add		('primitiveType'	, Primitive.Polygon							)
		:add		('polygonMode'		, PolygonMode.Oval							)
		:add		('fillColorString'	, object.fillColorString					)
		:add		('style'			, object.style								)
		:add		('thickness'		, {[object.style] = object.thickness}		)
		:add		('r1'				, object.r1									)
		:add		('r2'				, object.r2									)
		:stop()
end

local function polygonRectLoad(object)
	loader()
		:new(object)
		:addMapData	('objectType'		, 'Polygon'									)
		:addMapData	('points'			, polygonRectMakePoints(object.height, object.width))
		:addMapData	('fillColor'		, colorFromString(object.fillColorString)	)
		:addMapData	('thickness'		, object.thickness							)
		:addMapData	('file'				, lineStyles_[object.style].file			)
		:addMapData	('angle'			, object.angle								)
		:add		('primitiveType'	, Primitive.Polygon							)
		:add		('polygonMode'		, PolygonMode.Rect							)
		:add		('fillColorString'	, object.fillColorString					)
		:add		('style'			, object.style								)
		:add		('thickness'		, {[object.style] = object.thickness}		)
		:add		('width'			, object.width								)
		:add		('height'			, object.height								)
		:stop()
end

local function polygonFreeLoad(object)
	loader()
		:new(object)
		:addMapData	('objectType'		, 'Polygon'									)
		:addMapData	('points'			, object.points								)
		:addMapData	('fillColor'		, colorFromString(object.fillColorString)	)
		:addMapData	('thickness'		, object.thickness							)
		:addMapData	('file'				, lineStyles_[object.style].file			)
		:add		('primitiveType'	, Primitive.Polygon							)
		:add		('polygonMode'		, PolygonMode.Free							)
		:add		('fillColorString'	, object.fillColorString					)
		:add		('style'			, object.style								)
		:add		('thickness'		, {[object.style] = object.thickness}		)
		:stop()
end

local function polygonArrowLoad(object)
	loader()
		:new(object)
		:addMapData	('objectType'		, 'Polygon'									)
		:addMapData	('points'			, polygonArrowMakePoints(object.length)		)
		:addMapData	('fillColor'		, colorFromString(object.fillColorString)	)
		:addMapData	('thickness'		, object.thickness							)
		:addMapData	('file'				, lineStyles_[object.style].file			)
		:addMapData	('angle'			, object.angle								)
		:add		('primitiveType'	, Primitive.Polygon							)
		:add		('polygonMode'		, PolygonMode.Arrow							)
		:add		('fillColorString'	, object.fillColorString					)
		:add		('style'			, object.style								)
		:add		('length'			, object.length								)
		:add		('thickness'		, {[object.style] = object.thickness}		)
		:stop()
end

local function textBoxLoad(object)
	loader()
		:new(object)
		:addMapData	('objectType'		, 'TextBox'									)
		:addMapData	('fillColor'		, colorFromString(object.fillColorString)	)
		:addMapData	('borderThickness'	, object.borderThickness					)
		:addMapData	('text'				, object.text								)
		:addMapData	('font'				, object.font								)
		:addMapData	('fontSize'			, object.fontSize							)
		:addMapData	('angle'			, object.angle								)
		:add		('primitiveType'	, Primitive.TextBox							)
		:add		('fillColorString'	, object.fillColorString					)
		:stop()
end

local function iconLoad(object)
	loader()
		:new(object)
		:addMapData	('objectType'		, 'Icon'			)
		:addMapData	('angle'			, object.angle		)
		:addMapData	('scale'			, object.scale		)
		:addMapData	('file'				, object.file		)
		:add		('primitiveType'	, Primitive.Icon	)
		:stop()
end

local function objectLoad(object)
	local primitiveType = object.primitiveType
	
	if primitiveType == Primitive.Line then
		lineLoad(object)
	elseif primitiveType == Primitive.Polygon then
		if object.polygonMode == PolygonMode.Circle then
			polygonCircleLoad(object)
		elseif object.polygonMode == PolygonMode.Oval then
			polygonOvalLoad(object)			
		elseif object.polygonMode == PolygonMode.Rect then
			polygonRectLoad(object)		
		elseif object.polygonMode == PolygonMode.Free then
			polygonFreeLoad(object)		
		elseif object.polygonMode == PolygonMode.Arrow then
			polygonArrowLoad(object)
		end
	elseif primitiveType == Primitive.TextBox then
		textBoxLoad(object)
	elseif primitiveType == Primitive.Icon then
		iconLoad(object)		
	end
end

local function loadFromMission(data)
	reset()
		
	if data and data.options then
	
		local loadHiddenData = function(missionData, hiddenData)
			if missionData then
				for role, data in pairs(hiddenData) do
					local missionRole = missionData[role]
					
					if missionRole then
						for coalition, value in pairs(data) do
							if missionRole[coalition] then
								data[coalition] = true
							else
								data[coalition] = false
							end
						end
					end
				end
			end
		end
		
		loadHiddenData(data.options.hiddenOnF10Map, hiddenOnF10MapData_)
		
		local isPlanner =  isPlannerMission()

		for i, layerIn in pairs(data.layers) do
			local layer = layerFind(layerIn.name)
			
			layer.visible = layerIn.visible
			layer.order = i
	
			for i, object in ipairs(layerIn.objects) do
				if not(object.hiddenOnPlanner and isPlanner) then
					objectLoad(object)
				end
			end
		end
		
		table.sort(layers_, function(layer1, layer2)
			return layer1.order < layer2.order
		end)
	end
	
	checkListBoxLayersUpdate(currLayerName_)
end

local function saver()
	return {
		new = function(self, object)
			self.primitiveType		= object.primitiveType	
			self.name				= object.name			
			self.colorString		= object.colorString	
			self.mapX				= object.mapData.x		
			self.mapY				= object.mapData.y		
			self.visible			= object.visible		
			self.layerName			= object.layerName		
			self.hiddenOnPlanner	= object.hiddenOnPlanner
		
			return self
		end,
		add = function(self, name, value)
			self[name] = value
			
			return self
		end,
		stop = function(self)
			self.new	= nil
			self.add	= nil
			self.stop	= nil
			
			return self
		end
	}
end

local function lineSave(object)
	return saver()
			:new(object)
			:add('lineMode'	, object.lineMode			)
			:add('style'	, object.style				)
			:add('closed'	, object.mapData.closed		)
			:add('thickness', object.mapData.thickness	)
			:add('points'	, object.mapData.points		)
			:stop()
end

local function polygonCircleSave(object)
	return saver()
			:new(object)
			:add('polygonMode'		, object.polygonMode		)
			:add('style'			, object.style				)
			:add('thickness'		, object.mapData.thickness	)
			:add('radius'			, object.radius				)
			:add('fillColorString'	, object.fillColorString	)
			:stop()
end

local function polygonOvalSave(object)
	return saver()
			:new(object)
			:add('polygonMode'		, object.polygonMode		)
			:add('style'			, object.style				)
			:add('thickness'		, object.mapData.thickness	)
			:add('r1'				, object.r1					)
			:add('r2'				, object.r2					)
			:add('angle'			, object.mapData.angle		)
			:add('fillColorString'	, object.fillColorString	)
			:stop()
end

local function polygonRectSave(object)
	return saver()
			:new(object)
			:add('polygonMode'		, object.polygonMode		)
			:add('style'			, object.style				)
			:add('thickness'		, object.mapData.thickness	)
			:add('width'			, object.width				)
			:add('height'			, object.height				)
			:add('angle'			, object.mapData.angle		)
			:add('fillColorString'	, object.fillColorString	)
			:stop()
end

local function polygonFreeSave(object)
	return saver()
			:new(object)
			:add('polygonMode'		, object.polygonMode		)
			:add('style'			, object.style				)
			:add('points'			, object.mapData.points		)
			:add('thickness'		, object.mapData.thickness	)
			:add('fillColorString'	, object.fillColorString	)
			:stop()
end

local function polygonArrowSave(object)
	return saver()
			:new(object)
			:add('polygonMode'		, object.polygonMode		)
			:add('style'			, object.style				)
			:add('points'			, object.mapData.points		)
			:add('thickness'		, object.mapData.thickness	)
			:add('angle'			, object.mapData.angle		)
			:add('length'			, object.length				)
			:add('fillColorString'	, object.fillColorString	)
			:stop()
end

local function textBoxSave(object)	
	return saver()
			:new(object)
			:add('angle'			, object.mapData.angle			)
			:add('text'				, object.mapData.text			)
			:add('font'				, object.mapData.font			)
			:add('fontSize'			, object.mapData.fontSize		)
			:add('borderThickness'	, object.mapData.borderThickness)
			:add('fillColorString'	, object.fillColorString		)
			:stop()
end

local function iconSave(object)
	return saver()
			:new(object)
			:add('angle'			, object.mapData.angle			)
			:add('file'				, object.mapData.file			)
			:add('scale'			, object.mapData.scale			)
			:stop()
end

local function objectSave(object)
	local primitiveType = object.primitiveType
	
	if primitiveType == Primitive.Line then
		return lineSave(object)
	elseif primitiveType == Primitive.Polygon then	
		if object.polygonMode == PolygonMode.Circle then
			return polygonCircleSave(object)
		elseif object.polygonMode == PolygonMode.Oval then
			return polygonOvalSave(object)			
		elseif object.polygonMode == PolygonMode.Rect then
			return polygonRectSave(object)		
		elseif object.polygonMode == PolygonMode.Free then
			return polygonFreeSave(object)		
		elseif object.polygonMode == PolygonMode.Arrow then
			return polygonArrowSave(object)
		end
	elseif primitiveType == Primitive.TextBox then		
		return textBoxSave(object)	
	elseif primitiveType == Primitive.Icon then		
		return iconSave(object)
	end
end

function saveToMission()	
	local layersOut = {}
	
	for i, layer in ipairs(layers_) do
		local objectsOut = {}
		
		for j, object in ipairs(layer.objects) do
			table.insert(objectsOut, objectSave(object))
		end
		
		table.insert(layersOut, {name = layer.name, visible = layer.visible, objects = objectsOut})
		
	end
	
	local optionsOut = {
		hiddenOnF10Map	= hiddenOnF10MapData_,
	}
	
	return {
		layers	= layersOut,
		options = optionsOut,
	}
end

local function onIconsThemeChange()
	local panelPropertiesIcon = propertyPanels_[Primitive.Icon]	
	local file
	
	if currObject_ and currObject_.primitiveType == Primitive.Icon then
		file = currObject_.mapData.file
	else
		file = newPrimitiveInfo_[Primitive.Icon].file
	end

	local iconFolders = iconsFolderGet()

	panelPropertiesIcon.buttonIcon:setSkin(SkinUtils.setButtonPicture(iconFolders .. file, panelPropertiesIcon.buttonIconSkin))
	
	if iconInfos_ then		
		iconSelector_:setIcons(iconFolders, iconInfos_)
		iconSelector_:selectIcon(file)
	end	
end

local function getCurrObject()
	return currObject_
end

local function copyObjToCoord(a_object, x, y, dx, dy)
	local newObject = {}
	U.recursiveCopyTable(newObject, a_object)

	local name = newObject.name
	local counter = 0
	
	while verifyName(name, object) ~= true do
		counter = counter + 1
		name = string.format(newObject.name..'-%d', counter)
	end
	
	newObject.name = name

	newObject.mapId	= MapWindow.createDrawObject(newObject.mapData)
	objectAdd(newObject)
	
	moveObject(newObject, x, y, dx, dy)
end

return {
	create				= create,
	show				= show,
	loadFromMission		= loadFromMission,
	saveToMission		= saveToMission,
	onMouseMove			= onMouseMove,
	onMouseDown			= onMouseDown,
	onMouseUp			= onMouseUp,
	onMouseDrag			= onMouseDrag,
	onIconsThemeChange	= onIconsThemeChange,
	getCurrObject		= getCurrObject,
	copyObjToCoord		= copyObjToCoord,
}