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
	camera_route_player	= _('Camera Route Player'),
	predefined			= _('Predefined'),
	user_defined		= _('User Defined'),
	route 				= _('Route'),
	route_length    	= _('Route Length'),
	speed				= _('Speed'),
}

local window_
local panelRadio_
local radioButtonPredefined_
local radioButtonUserDefined_
local panelTop_
local comboBoxRoute_
local staticDistance_
local editBoxSpeed_
local panelBottom_
local buttonBegin_
local buttonForward_
local buttonStop_
local buttonCancel_
local buttonBackward_
local buttonEnd_
local horzProgressBarDistance_

-- CameraRoutes table initially defined in <USER_PROFILE>\Saved Games\DCS\Config\View\Routes\units\unit_type.lua
local function updateRouteItems(cam_num)
--	print('updateRouteItems()')
	comboBoxRoute_:removeAllItems()
--	local index = 1
	if CameraRoutes ~= nil then
		for n,tbl in pairs(CameraRoutes) do
			if n == cam_num then				
				for k,v in ipairs(tbl) do 
					local listBoxItem = ListBoxItem.new(v.name)
--					listBoxItem.index = index
					comboBoxRoute_:insertItem(listBoxItem)
					local item_index = comboBoxRoute_:getItemIndex(listBoxItem)
--					print("item_index: ", item_index, ", name:", v.name)
					if item_index == 0 then
						selectedItem = listBoxItem
						comboBoxRoute_:selectItem(selectedItem)
						comboBoxRoute_:setText(v.name)
--						print("selected item_index: ", item_index, ", name:", v.name)
					end
--					index = index + 1
				end
			end
		end
--[[
		-- Don't call callbacks until updated routes have gotten in C++
		if selectedItem ~= nil then
			onComboBoxRoute(comboBoxRoute_:getItemIndex(selectedItem))
		end
--]]		
	else
--		print("CameraRoutes == nil")
	end
--	print('comboBoxRoute_:getItemCount() = ', comboBoxRoute_:getItemCount())
end

local function create()	
--	print('RoutePlayerDialog.create()')
	window_ = DialogLoader.spawnDialogFromFile('./Scripts/UI/View/RoutePlayerDialog.dlg', localization)
--	print('window_:getBounds()', window_:getBounds())
--	window_:setText(localization.camera_route_player)
	window_:setPosition(0, 40)
--	print('window_:getBounds()', window_:getBounds())
	window_:setSkin(SkinUtils.setWindowBkgColor(window_:getSkin(), 0x000000A0))
	panelRadio_ = window_.panelRadio
	radioButtonPredefined_ = panelRadio_.radioButtonPredefined
	radioButtonUserDefined_ = panelRadio_.radioButtonUserDefined	
	panelTop_ = window_.panelTop
	comboBoxRoute_ = panelTop_.comboBoxRoute
	staticDistance_ = panelTop_.staticDistance
	editBoxSpeed_ = panelTop_.editBoxSpeed
	editBoxSpeed_:setNumeric(true)
	editBoxSpeed_:setAcceptDecimalPoint(true)
	panelBottom_ = window_.panelBottom
	buttonBegin_ = panelBottom_.buttonBegin
	buttonForward_ = panelBottom_.buttonForward
	buttonStop_ = panelBottom_.buttonStop
	buttonCancel_ = panelBottom_.buttonCancel
	buttonBackward_ = panelBottom_.buttonBackward
	buttonEnd_ = panelBottom_.buttonEnd
	horzProgressBarDistance_ = panelBottom_.horzProgressBarDistance
	
	-- updateRouteItems() -- called from C++
	
	function radioButtonPredefined_:onChange()
--		print('radioButtonPredefined_:onChange()')
		local state = radioButtonPredefined_:getState()
		onRadioButtonPredefined(state)
	end
	
	function radioButtonUserDefined_:onChange()
--		print('radioButtonUserDefined_:onChange()')
		local state = radioButtonUserDefined_:getState()
		onRadioButtonUserDefined(state)
	end
	
	function comboBoxRoute_:onChange()
--		print('comboBoxRoute_:onChange()')
		local selectedItem = comboBoxRoute_:getSelectedItem()
		if selectedItem ~= nil then
			local item_index = comboBoxRoute_:getItemIndex(selectedItem)	
			local name = selectedItem:getText()
--			print('Selected item index:', item_index, ', name: ', name);
			onComboBoxRoute(item_index)
		end
	end
	
	function editBoxSpeed_:onChange()
--		print('editBoxSpeed_:onChange()')
		local text = editBoxSpeed_:getText()
--		print('text: ', text)
		local speed = tonumber(text)
		if speed ~= nil then
			onEditBoxSpeed(speed)
		end		 
	end
	
	function buttonBegin_:onChange()
--		print('buttonBegin_:onChange()')
		onButtonBegin()
	end
	
	function buttonForward_:onChange()
--		print('buttonForward_:onChange()')
		onButtonForward()
	end

	function buttonStop_:onChange()
--		print('buttonForward_:onChange()')
		onButtonStop()
	end

	function buttonCancel_:onChange()
--		print('buttonForward_:onChange()')
		onButtonCancel()
	end

	function buttonBackward_:onChange()
--		print('buttonForward_:onChange()')
		onButtonBackward()
	end
	
	function buttonEnd_:onChange()
--		print('buttonForward_:onChange()')
		onButtonEnd()
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
--	print("selectRoute(), item_index = ", item_index)
	comboBoxRoute_:selectItem(comboBoxRoute_:getItem(item_index))
	comboBoxRoute_:setText(comboBoxRoute_:getItem(item_index):getText())
end

local function setStaticDistance(dist)
	staticDistance_:setText(string.format("%.2f", dist))
end

local function setEditBoxSpeed(speed)
	editBoxSpeed_:setText(string.format("%.2f", speed))
end

local function setHorzProgressBarDistance(dist, value)	-- value %
--	print(string.format("setHorzProgressBarDistance(%.2f, %d)", dist, value))
	horzProgressBarDistance_:setValue(value)
	horzProgressBarDistance_:setText(string.format("%.2f (%d%%)", dist, value))	
end

local function setRadioButtonPredefined(state)
	radioButtonPredefined_:setState(state)
end

local function setRadioButtonUserDefined(state)
	radioButtonUserDefined_:setState(state)
end

return {
	create								= create,
	kill								= kill,
	show								= show,
	hide								= hide,
	getWindow							= getWindow,
	updateRouteItems					= updateRouteItems,
	selectRoute							= selectRoute,
	setStaticDistance					= setStaticDistance,
	setEditBoxSpeed						= setEditBoxSpeed,
	setHorzProgressBarDistance			= setHorzProgressBarDistance,
	setRadioButtonPredefined			= setRadioButtonPredefined,
	setRadioButtonUserDefined			= setRadioButtonUserDefined,
}
