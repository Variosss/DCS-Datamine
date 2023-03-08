local DialogLoader		= require('DialogLoader')
local gettext			= require('i_18n')
local dxgui				= require('dxgui')
local ListBoxItem		= require('ListBoxItem')
local SkinUtils         = require('SkinUtils')
local Skin              = require('Skin')

local function _(text) 
	return gettext.dtranslate('simulator', text) 
end

local localization = {
	route_editor	= _('Route Editor'),
	create 			= _('Create'),
	select    		= _('Select'),
	remove			= _('Remove'),
	of				= _('of'),
	edit			= _('Edit'),
	ok				= _('OK'),
	first			= _('First'),
	next			= _('Next'),
	prev			= _('Prev'),
	last			= _('Last'),
	add_before		= _('Add Before'),
	add_after		= _('Add After'),
	delete			= _('Delete'),
	save			= _('Save'),
	hide			= _('Hide'),
}

local window_
local panelButtons_
local buttonCreate_
local buttonSelect_
local buttonRemove_
local panelNames_
local listBoxNames_
local panelPoints_
local panelPoint_
local editBoxN_
local staticPosCount_
local staticPX_
local staticPY_
local staticPZ_
local staticYaw_
local staticPitch_
local buttonEdit_
local buttonOK_
local buttonCancel_
local panelIter_
local buttonFirst_
local buttonNext_
local buttonPrev_
local buttonLast_
local panelAddDelete_
local buttonAddBefore_
local buttonAddAfter_
local buttonDelete_
local panelSave_
local buttonSave_
local buttonHide_

local routesCount = 0
--local routeIndex = 0
local routeSize = 0
local posIndex = 0
local selectedItem
 
-- CameraRoutes table initially defined in <USER_PROFILE>\Saved Games\DCS\Config\View\Routes\units\unit_type.lua
local function updateRouteItems(cam_num)
--	print('updateRouteItems()')
	listBoxNames_:clear()
	routesCount = 0
	if CameraRoutes ~= nil then
		for num,tbl in pairs(CameraRoutes) do
			if num == cam_num then				
				for k,v in ipairs(tbl) do 
					local listBoxItem = ListBoxItem.new(v.name)
					listBoxNames_:insertItem(listBoxItem)
					local item_index = listBoxNames_:getItemIndex(listBoxItem)
--					print("item_index: ", item_index, ", name: ", v.name)
					if item_index == 0 then
						listBoxNames_:selectItem(listBoxItem)
						selectedItem = listBoxItem						
					end
					routesCount = routesCount + 1
				end
			end
		end
--[[
		-- Don't call callbacks until updated routes have gotten in C++
		if routesCount > 0 then
			routeIndex = 0
			onButtonSelect(routeIndex)
		else
			routeIndex = -1
		end
--]]		
	else
--		print("CameraRoutes == nil")
	end
--	print('listBoxNames_:getItemCount() = ', listBoxNames_:getItemCount())
	local skin = listBoxNames_:getSkin()
	listBoxNames_:setSkin(SkinUtils.setWindowBkgColor(skin, 0x00000000))
---[[	
	window_:getLayout():updateSize()
	local w, h = window_:getSize()
	local headerHeight = window_:getSkin().skinData.params.headerHeight
	local _, panelButtonsHeight = panelButtons_:getSize()
	local _, panelNamesHeight = panelNames_:getSize()
	local _, panelPointsHeight = panelPoints_:getSize()
	local _, panelSaveHeight = panelSave_:getSize()
	window_:setSize(w, headerHeight + panelButtonsHeight + panelNamesHeight + panelPointsHeight + panelSaveHeight + 1)
--]]	
end

local function create()	
--	print('RouteEditorDialog.create()')
	window_ = DialogLoader.spawnDialogFromFile('./Scripts/UI/View/RouteEditorDialog.dlg', localization)
	window_:setPosition(200, 40)
	window_:setSkin(SkinUtils.setWindowBkgColor(window_:getSkin(), 0x000000A0))
	panelNames_ = window_.panelNames
	listBoxNames_ = panelNames_.listBoxNames
	listBoxNames_:clear()
	panelButtons_ = window_.panelButtons
	buttonCreate_ = window_.panelButtons.buttonCreate
	buttonSelect_ = window_.panelButtons.buttonSelect
	buttonRemove_ = window_.panelButtons.buttonRemove
	panelPoints_ = window_.panelPoints
	panelPoint_ = panelPoints_.panelPoint
	editBoxN_ = panelPoint_.editBoxN
	editBoxN_:setNumeric(true)
	staticPosCount_ = panelPoint_.staticPosCount
	staticPX_ = panelPoint_.staticPX
	staticPY_ = panelPoint_.staticPY
	staticPZ_ = panelPoint_.staticPZ
	staticYaw_ = panelPoint_.staticYaw
	staticPitch_ = panelPoint_.staticPitch
	buttonEdit_ = panelPoint_.buttonEdit
	buttonOK_ = panelPoint_.buttonOK
	buttonCancel_ = panelPoint_.buttonCancel
	panelIter_ = panelPoints_.panelIter
	buttonFirst_ = panelIter_.buttonFirst
	buttonNext_ = panelIter_.buttonNext
	buttonPrev_ = panelIter_.buttonPrev
	buttonLast_ = panelIter_.buttonLast
	panelAddDelete_ = panelPoints_.panelAddDelete
	buttonAddBefore_ = panelAddDelete_.buttonAddBefore
	buttonAddAfter_ = panelAddDelete_.buttonAddAfter
	buttonDelete_ = panelAddDelete_.buttonDelete
	panelSave_ = window_.panelSave
	buttonSave_ = panelSave_.buttonSave
	buttonHide_ = panelSave_.buttonHide
	
	-- updateRouteItems() -- called from C++
	
	function buttonCreate_:onChange()
--		print('buttonCreate_:onChange()')
		onButtonCreate()
	end
	
	function buttonSelect_:onChange()
--		print('buttonSelect_:onChange()')
		local selectedItem = listBoxNames_:getSelectedItem()
		if selectedItem ~= nil then
			local item_index = listBoxNames_:getItemIndex(selectedItem)
--			print('Selected item index:', index, ", name: ", selectedItem:getText());
			onButtonSelect(item_index)
		end
	end

	function listBoxNames_:onItemMouseDoubleClick()
--		print('listBoxNames_:onItemMouseDoubleClick()')
		local selectedItem = listBoxNames_:getSelectedItem()
		if selectedItem ~= nil then
			local item_index = listBoxNames_:getItemIndex(selectedItem)
--			print('Selected item index:', item_index, ", name: ", selectedItem:getText());
			onButtonSelect(item_index)
		end
	end
	
	function buttonRemove_:onChange()
--		print('buttonRemove_:onChange()')
		local selectedItem = listBoxNames_:getSelectedItem()
		if selectedItem ~= nil then
			local item_index = listBoxNames_:getItemIndex(selectedItem)
--			print('Removing item index:', item_index, ", name: ", selectedItem:getText());
			onButtonRemove(item_index)
		end
	end
		
	function buttonEdit_:onChange()
--		print('buttonEdit_:onChange()')
		local n = tonumber(editBoxN_:getText())
		onButtonEdit(n)
	end
	
	function buttonOK_:onChange()
--		print('buttonOK_:onChange()')
		onButtonOK()
	end

	function buttonCancel_:onChange()
--		print('buttonCancel_:onChange()')
		onButtonCancel()
	end
	
	function editBoxN_:onChange()
--		print('buttonEdit_:onChange()')
		local n = tonumber(editBoxN_:getText())
		onEditBoxN(n)
	end
	
	function buttonFirst_:onChange()
--		print('buttonFirst_:onChange()')
		local n = 1
		editBoxN_:setText(string.format("%d", n))
		onButtonFirst()
	end
	
	function buttonNext_:onChange()
--		print('buttonNext_:onChange()')
		onButtonNext()
	end
	
	function buttonPrev_:onChange()
--		print('buttonPrev_:onChange()')
		onButtonPrev()
	end
	
	function buttonLast_:onChange()
--		print('buttonLast_:onChange()')
		onButtonLast()
	end
	
	function buttonAddBefore_:onChange()
--		print('buttonAddBefore_:onChange()')
		onButtonAddBefore()
	end
	
	function buttonAddAfter_:onChange()
--		print('buttonAddAfter_:onChange()')
		onButtonAddAfter()
	end
	
	function buttonDelete_:onChange()
--		print('buttonDelete_:onChange()')
		onButtonDelete()
	end
	
	function buttonSave_:onChange()
--		print('buttonSave_:onChange()')
		onButtonSave()
	end

	function buttonHide_:onChange()
--		print('buttonHide_:onChange()')
		onButtonHide()
	end
	
end

local function kill()
	window_:kill()
	window_ = nil
end

local function show()
	window_:setVisible(true)
end

local function hide()
	window_:setVisible(false)
end

local function getWindow()
	return window_.widget
end

local function selectRoute(item_index)
	listBoxNames_:selectItem(listBoxNames_:getItem(item_index))
end

local function setPosition(i, x, y, z, yaw, pitch)
	editBoxN_:setText(string.format("%d", i))
	staticPX_:setText(string.format("%.2f", x))
	staticPY_:setText(string.format("%.2f", y))
	staticPZ_:setText(string.format("%.2f", z))
	staticYaw_:setText(string.format("%.2f", yaw))
	staticPitch_:setText(string.format("%.2f", pitch))
end

local function setPosCount(count)
	staticPosCount_:setText(string.format("%d", count))
	if count < 1 then
		setPosition(0, 0.0, 0.0, 0.0, 0.0, 0.0)
	end
end


return {
	create								= create,
	kill								= kill,
	show								= show,
	hide								= hide,
	getWindow							= getWindow,
	updateRouteItems					= updateRouteItems,
	selectRoute							= selectRoute,
	setPosCount							= setPosCount,
	setPosition							= setPosition,
}
