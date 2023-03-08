local DialogLoader				= require('DialogLoader')
local CheckListBoxItem			= require('CheckListBoxItem')
local textutil					= require('textutil')
local i18n						= require('i18n')
local MapWindow             	= require('me_map_window')

local _ = i18n.ptranslate

local initialBounds_
local checkListBox_
local itemIndices_
local controller_

local function setController(controller)
	controller_ = controller
end

local function fillCheckListBox(checkListBox)
	local layers = controller_.getSwitchableLayers()
	
	table.sort(layers, function(layer1, layer2)
		return textutil.Utf8Compare(layer1.localizedTitle, layer2.localizedTitle)
	end)
	
	itemIndices_ = {}
	
	for i, layer in ipairs(layers) do
		local item = CheckListBoxItem.new(layer.localizedTitle)
		
		item:setChecked(layer.visible)
		item.title = layer.title
		
		checkListBox:insertItem(item)
		itemIndices_[layer.title] = i - 1
	end
end

local function create_()
	local localization = {
		title		= _('MAP OPTIONS'),
		filter		= _('LAYERS FILTER'),
		ShowUnits	= _('SHOW UNITS'),
		HideUnits	= _('HIDE UNITS'),
		blue		= _('BLUE'),
		red			= _('RED'),
		neutrals	= _('NEUTRALS'),
	}
	
	window_ = DialogLoader.spawnDialogFromFile("./MissionEditor/modules/dialogs/MapLayerPanel.dlg", localization)
	
	if initialBounds_ then
		window_:setBounds(unpack(initialBounds_))
	end
	
	function window_:onClose()
		hide()
	end
	
	checkListBox_ 	= window_.checkListBox
	sShowUnits		= window_.sShowUnits
	cbBlue			= window_.cbBlue
	cbRed 			= window_.cbRed
	cbNeutrals		= window_.cbNeutrals
	sHideUnits		= window_.sHideUnits
	cbHideBlue		= window_.cbHideBlue
	cbHideRed 		= window_.cbHideRed
	cbHideNeutrals	= window_.cbHideNeutrals
	
	fillCheckListBox(checkListBox_)
	
	function checkListBox_:onItemChange()	
		local item		= self:getSelectedItem()
	
		controller_.setLayerVisible(item.title, item:getChecked())
	end
	
	function cbRed:onChange()
		MapWindow.set_bShowRed(self:getState())
		if self:getState() then
			cbHideRed:setState(false)
			MapWindow.set_bHideRed(false)
		end
	end	
	
	function cbBlue:onChange()
		MapWindow.set_bShowBlue(self:getState())
		if self:getState() then
			cbHideBlue:setState(false)
			MapWindow.set_bHideBlue(false)
		end
	end	
	
	function cbNeutrals:onChange()
		MapWindow.set_bShowNeutrals(self:getState())
		if self:getState() then
			cbHideNeutrals:setState(false)
			MapWindow.set_bHideNeutrals(false)
		end
	end	

	function cbHideRed:onChange()
		MapWindow.set_bHideRed(self:getState())
		if self:getState() then
			cbRed:setState(false)
			MapWindow.set_bShowRed(false)
		end
	end	
	
	function cbHideBlue:onChange()
		MapWindow.set_bHideBlue(self:getState())
		if self:getState() then
			cbBlue:setState(false)
			MapWindow.set_bShowBlue(false)
		end
	end	
	
	function cbHideNeutrals:onChange()
		MapWindow.set_bHideNeutrals(self:getState())
		if self:getState() then
			cbNeutrals:setState(false)
			MapWindow.set_bShowNeutrals(false)
		end
	end	
end

local function create(...)
	initialBounds_ = {...}
end

local function show()
	if not window_ then
		create_()
	end
	
	if not window_:getVisible() then
		window_:setVisible(true)
		
		controller_.onMapLayerPanelShow()
	end
	
	if _G.isPlannerMission() == true then
		sShowUnits:setVisible(false)
		cbBlue:setVisible(false)
		cbRed:setVisible(false)
		cbNeutrals:setVisible(false)
		sHideUnits:setVisible(false)
		cbHideBlue:setVisible(false)
		cbHideRed:setVisible(false)
		cbHideNeutrals:setVisible(false)
	else
		sShowUnits:setVisible(true)
		cbBlue:setVisible(true)
		cbRed:setVisible(true)
		cbNeutrals:setVisible(true)
		sHideUnits:setVisible(true)
		cbHideBlue:setVisible(true)
		cbHideRed:setVisible(true)
		cbHideNeutrals:setVisible(true)
	end
end

-- объ€влена выше
hide = function()
	if window_ then
		if window_:getVisible() then
			window_:setVisible(false)
			
			controller_.onMapLayerPanelHide()
		end	
	end
end
	
local function mapLayerVisibleChanged(layerTitle)
	if window_ then
		local itemIndex = itemIndices_[layerTitle]
		local item = checkListBox_:getItem(itemIndex)
		
		item:setChecked(controller_.getLayerVisible(layerTitle))
	end
end
	
return {
	setController			= setController,
	create					= create,
	show					= show,
	hide					= hide,
	mapLayerVisibleChanged	= mapLayerVisibleChanged,
}