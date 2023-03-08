module('DialogLoader', package.seeall)

WidgetParams = require('WidgetParams')
Skin = require('Skin')

WidgetParams.create()

local enableTest

function setEnableTest(enable)
	enableTest = enable
end

local nilValue = WidgetParams.getNilValue()

function replaceNilValue(table)
	for name, value in pairs(table) do
		if value == nilValue then
			table[name] = nil
		else
			if type(value) == 'table' then
				replaceNilValue(value)
			end
		end
	end

	return table
end

function loadFile(filename)
	local result
	local f, err = loadfile(filename)

	if f then
		local env = {}

		setfenv(f, env)
		
		local callResult, err = pcall(f)
		
		if callResult then
			result = env.dialog
		else
			print("Cannot load " .. filename .. ": " .. err)
		end
	else
		print("Cannot load " .. filename .. ": " .. err)
	end

	return result
end

-- локализация параметров производится только для функции setText()
function localizeParams(funcName, paramValue, localization)
	local result = paramValue
	
	if localization and ('setText' == funcName or 'setTooltipText' == funcName)then
		local textToLocalize = paramValue or ''
		
		-- имя локализованной строки должно начинаться со знака $
		local name = string.match(textToLocalize, "^%$(.*)")

		if name then
			local localizedParam = localization[name]

			if localizedParam then
				result = localizedParam
			end
		end
	else
		result = paramValue
	end

	return result
end

function setWidgetParams(widget, widgetTable, localization)
	local widgetInfo = WidgetParams.getWidgets()[widgetTable.type]

	for name, paramValue in pairs(widgetTable.params) do
		local widgetInfoParam = widgetInfo.params[name]

		if widgetInfoParam then
			local funcName = widgetInfoParam.set
			local setFunc = widget[funcName] or widgetInfoParam.setFunc

			if setFunc then
				setFunc(widget, localizeParams(funcName, paramValue, localization))
			end
		end
	end
end

function mergeSkins(skinsDestination, skinsSource)
	for widgetName, skinSource in pairs(skinsSource) do
		WidgetParams.merge(skinsDestination[widgetName], skinSource, true)
	end
end

function createSubSkins(skinsTable)
	local result

	if skinsTable then
		result = {}

		for widgetName, widgetSkin in pairs(skinsTable) do
			result[widgetName] = widgetSkin

			if widgetSkin.skinData.skins then
				local subSkins = createSubSkins(widgetSkin.skinData.skins)

				if subSkins then
					if result[widgetName] then
						mergeSkins(result[widgetName].skinData.skins, subSkins)
					end
				end
			end
		end
	end

	return result
end

function getSkinName(skinTable)
	local result

	if skinTable then
		local skinParams = skinTable.params

		if skinParams and skinParams.name then
			result = skinParams.name
		end
	end

	return result
end

function createSkin(skinTable)
	local result
	local skinName = getSkinName(skinTable)
	
	if skinName then
		result = Skin.getSkin(skinName)

		if result then
			WidgetParams.merge(result.skinData, skinTable, true)

			local skins = createSubSkins(skinTable.skins)

			if skins then
				mergeSkins(result.skinData.skins, skins)
			end

			replaceNilValue(result)
		end
	end

	return result
end

function getDefaultSkinName(widgetTypeName)
	return string.gsub(widgetTypeName, "%u?", string.lower, 1) .. "Skin"
end

function createDefaultSkin(widgetTypeName)
	local skinName = getDefaultSkinName(widgetTypeName)
 
	return Skin.getSkin(skinName)
end

function setSkinParams(widget, widgetTable)
	local skin = createSkin(widgetTable.skin)

	if not skin then
		skin = createDefaultSkin(widgetTable.type)
	end

	if skin then
		widget:setSkin(skin)
	end
end

function spawnChildren(widget, widgetTable, localization, parentResourceString)
	local childInfo = {}

	for childName, childTable in pairs(widgetTable.children or {}) do
		local child = spawnWidget(childName, childTable, localization, parentResourceString)

		-- child:setResourceString(parentResourceString .. '/' .. childName)
		child:setResourceString(childName)
		child:setName(childName)
		
		table.insert(childInfo, {child = child, childName = childName, childType = childTable.type})
	end

	local sortChildren = function(childInfo1, childInfo2)
		return childInfo1.child:getZIndex() < childInfo2.child:getZIndex()
	end

	table.sort(childInfo, sortChildren)

	local widgetInfo = WidgetParams.getWidgets()[widgetTable.type]
	local addChildFunc = widget[widgetInfo.addChildFuncName]
	
	for i, info in ipairs(childInfo) do
		widget[info.childName] = info.child

		if not (widgetTable.type == 'Window' and (info.childType == 'Menu' or info.childType == 'PieMenu')) then
			-- !!!Menu и PieMenu в окно добавлять не надо!!!
			addChildFunc(widget, info.child)
		end
	end
end

local function requireWidgetModule(widgetTable)
	local widgetType = widgetTable.type

	if 'Window' == widgetTable.type then 
		if widgetTable.params.offscreen then
			widgetType = 'OffscreenWindow'
		end
		
		if widgetTable.params.overlay then
			widgetType = 'OverlayWindow'
		end
		
		if widgetTable.params.modal then
			widgetType = 'ModalWindow'
		end	
		
		if widgetTable.params.buddy then
			widgetType = 'BuddyWindow'
		end	
	end

	local class = _G[widgetType]

	if not class then
		class = require(widgetType)
	end
	
	return class
end

function spawnWidget(widgetName, widgetTable, localization, parentResourceString)
	local result = requireWidgetModule(widgetTable).new()

	setSkinParams(result, widgetTable)
	setWidgetParams(result, widgetTable, localization)

	if enableTest then
		local widgetInfo = WidgetParams.getWidgets()[widgetTable.type]

		if widgetInfo.initFunc then
			widgetInfo.initFunc(result)
		end
	end

	spawnChildren(result, widgetTable, localization, parentResourceString)

	return result
end

function spawnDialogFromFile(filename, localization)
	local result
	local dialogTable = loadFile(filename)

	if dialogTable then
		result = spawnWidget('dialog', dialogTable, localization, filename)
		
		if result then
			result:setResourceString(filename)
		end
	end
	 
	return result
end

function loadDialogFromFile(filename, windowPtr)
	local dialogTable = loadFile(filename)

	if dialogTable then
		local class = requireWidgetModule(dialogTable)
		local prevNewWidgetFunction = class.newWidget
		
		-- новое окно создавать не нужно
		class.newWidget = function()
			return windowPtr
		end
		
		local dialog = class.new()
		
		class.newWidget = prevNewWidgetFunction
	
		local localization = nil
		local parentResourceString = filename
	
		setSkinParams(dialog, dialogTable)
		setWidgetParams(dialog, dialogTable, localization)
		
		dialog:setResourceString(filename)
		
		spawnChildren(dialog, dialogTable, localization, parentResourceString)
	end
end

local function getWidgetIsChild(parent, widget)
	local widgetCount = parent:getWidgetCount()
	
	for i = 0, widgetCount - 1 do
		if parent:getWidget(i) == widget then
			return true
		end
	end
	
	return false
end

function findWidgetByName(parent, name)
	return parent:findByName(name)
end