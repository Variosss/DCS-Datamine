local DialogLoader			= require('DialogLoader')
local ListBoxItem			= require('ListBoxItem')
local CoalitionController	= require('Mission.CoalitionController')
local CoalitionUtils		= require('Mission.CoalitionUtils')
local textutil				= require('textutil')
local i18n					= require('i18n')
local ModulesMediator	    = require('Mission.ModulesMediator')
local U						= require('me_utilities')

local _ = i18n.ptranslate

local initialBounds_
local window_
local staticName_
local staticTowerFrequency_
local comboListCoalition_
local toggleButtonFullInfo_
local toggleButtonAddSupplier_
local buttonDeleteSupplier_
local listBoxSuppliers_
local controller_
local airdromeId_

local function setController(controller)
	controller_ = controller
end

local function create(...)
	initialBounds_ = {...}
end

local hide
local function create_()
	local localization = {
		title			= _('WAREHOUSE IN AIRPORT'),
		coalition		= _('Coalition'),
		name			= _('NAME'),
		fullInfo		= _('FULL INFO'),
		suppliers		= _('SUPPLIERS'),
		add				= _('ADD'),
		del				= _('DEL'),
		neutral			= _('NEUTRAL'),
		towerFrequency	= _('TOWER FREQUENCY'),
	}

	window_ = DialogLoader.spawnDialogFromFile('./MissionEditor/modules/dialogs/AirdromePanel.dlg', localization) 
	
	staticName_					= window_.staticName
	staticTowerFrequency_		= window_.staticTowerFrequency
	comboListCoalition_			= window_.comboListCoalition
	toggleButtonFullInfo_		= window_.toggleButtonFullInfo
	toggleButtonAddSupplier_	= window_.toggleButtonAddSupplier
	buttonDeleteSupplier_		= window_.buttonDeleteSupplier
	listBoxSuppliers_			= window_.listBoxSuppliers
	
	if initialBounds_ then
		window_:setBounds(unpack(initialBounds_))
		w_=initialBounds_[3]
	end
	
	function window_:onClose()
        controller_.onEndAddSupplier()
        toggleButtonAddSupplier_:setState(false)
        local mapController = ModulesMediator.getMapController()
        mapController.resetSelection()
	    hideWindow()
	end
	
	local coalitionNames = {
		CoalitionController.neutralCoalitionName(),
		CoalitionController.blueCoalitionName(),
		CoalitionController.redCoalitionName(),
	}
	
	CoalitionUtils.fillComboListCoalition(comboListCoalition_, coalitionNames, function(coalitionName)
		controller_.setAirdromeCoalition(airdromeId_, coalitionName)
	end)
	
	function toggleButtonFullInfo_:onChange()
		if controller_ then
			if self:getState() then
				controller_.showResourceManagerPanel()
			else
				controller_.hideResourceManagerPanel()
			end
		end
	end
	
	function toggleButtonAddSupplier_:onChange()
		if controller_ then
			if self:getState() then
				controller_.onBeginAddSupplier()
			else
				controller_.onEndAddSupplier()
			end
		end
	end
	
	function buttonDeleteSupplier_:onChange()
		if controller_ then
			local item = listBoxSuppliers_:getSelectedItem()
			
			if item then			
				controller_.removeAirdromeSupplier(item.supplierInfo.supplierId, item.supplierInfo.supplierType)
			end	
		end
    end
    
    function listBoxSuppliers_:onChange() 
        local item = listBoxSuppliers_:getSelectedItem()
        if item then
            controller_.setSelectedAirdromeSupplier(airdromeId_,item.supplierInfo)
        end
    end
end

local function updateStaticName(airdrome)
	staticName_:setText(airdrome:getName())
end

local function updateStaticTowerFrequency(airdrome)
	local frequencyList = airdrome:getFrequencyList()
	local text
	
	for i, frequency in ipairs(frequencyList) do
		local frequencyText = string.format("%.3f %s", frequency / 1000000, _('MHz'))
		
		if text then
			text = text .. ',\n' .. frequencyText
		else
			text = frequencyText
		end
	end
	
	staticTowerFrequency_:setText(text)
end

local function updateComboListCoalition(airdrome)
	CoalitionUtils.setComboListCoalition(comboListCoalition_, airdrome:getCoalitionName())
end

local function createSupplierListBoxItem(supplierInfo)
	local item = ListBoxItem.new(supplierInfo.displayName)
	
	item.supplierInfo = supplierInfo
	
	return item
end

local function updateListBoxSuppliers(airdrome)
	listBoxSuppliers_:clear()
	
    local suppliersInfo = controller_.getAirdromeSuppliersInfo(airdrome:getAirdromeNumber())
	
	table.sort(suppliersInfo, function(supplierInfo1, supplierInfo2)
		return textutil.Utf8Compare(supplierInfo1.displayName, supplierInfo2.displayName)
	end)
    
    for i, supplierInfo in ipairs(suppliersInfo) do
        listBoxSuppliers_:insertItem(createSupplierListBoxItem(supplierInfo))
    end
end

local function updateWidgets(airdrome)
	updateStaticName(airdrome)
	updateStaticTowerFrequency(airdrome)
	updateComboListCoalition(airdrome)
	updateListBoxSuppliers(airdrome)
end

local function enableWidgets(enabled)
	comboListCoalition_			:setEnabled(enabled)
	toggleButtonAddSupplier_	:setEnabled(enabled)
	buttonDeleteSupplier_		:setEnabled(enabled)
end	

local function needUpdate()
	return window_ and window_:getVisible() and controller_
end

local function update(airdromeId)
	if needUpdate() then
		if airdromeId then
			local airdrome = controller_.getAirdrome(airdromeId)
			
			enableWidgets(true)
			updateWidgets(airdrome)
		else
			enableWidgets(false)
		end
	end	
end

local function setAirdromeId(airdromeId)
	airdromeId_ = airdromeId
	update(airdromeId)
end

local function getAirdromeId()
	return airdromeId_
end

local function show()
	if not window_ then
		create_()
	end
	
	if not window_:getVisible() then
		MapWindow.collapse(w_, 0)
		window_:setVisible(true)
		
		update(airdromeId_)
		
		if controller_ then
			controller_.onWarehousePanelShow()
		end		
	end
end

-- объявлена выше
hide = function()
	if window_ then
		if window_:getVisible() then
			hideWindow()		
		end	
	end	
end

function hideWindow()
	MapWindow.expand()
	window_:setVisible(false)
	
	toggleButtonFullInfo_:setState(false)
	toggleButtonAddSupplier_:setState(false)
	
	if controller_ then
		controller_.onWarehousePanelHide()
	end	
end

local function setPlannerMission(isPlanner)
	enableWidgets(not isPlanner)
end

local function getVisible()
	return window_ and window_:getVisible()
end

local function airdromeCoalitionChanged(airdromeId)
	if needUpdate() and airdromeId_ == airdromeId then
		local airdrome = controller_.getAirdrome(airdromeId)
		
		updateComboListCoalition(airdrome)
	end
end

local function airdromeSupplierAdded(airdromeId, supplierInfo)
	if needUpdate() and airdromeId_ == airdromeId then
		listBoxSuppliers_:insertItem(createSupplierListBoxItem(supplierInfo))        
	end
end

local function airdromeSupplierRemoved(airdromeId, supplierId, supplierType)
	if needUpdate() and airdromeId_ == airdromeId then
		local itemCount = listBoxSuppliers_:getItemCount()
		
		for i = 0, itemCount - 1 do
			local item = listBoxSuppliers_:getItem(i)
			
			if item.supplierInfo.supplierId == supplierId and item.supplierInfo.supplierType == supplierType then
				listBoxSuppliers_:removeItem(item)
				
				break
			end
		end
	end
end

local function onResourceManagerPanelShow()
	if needUpdate() then
		toggleButtonFullInfo_:setState(true)
	end	
end

local function onResourceManagerPanelHide()
	if needUpdate() then
		toggleButtonFullInfo_:setState(false)
	end	
end

return {
	setController				= setController,

	create						= create,
	show						= show,
	hide						= hide,
	setPlannerMission			= setPlannerMission,
	getVisible					= getVisible,

	setAirdromeId				= setAirdromeId,
	getAirdromeId				= getAirdromeId,
	
	airdromeCoalitionChanged	= airdromeCoalitionChanged,
	airdromeSupplierAdded		= airdromeSupplierAdded,
	airdromeSupplierRemoved		= airdromeSupplierRemoved,	
    setSelectedAirdromeSupplier = setSelectedAirdromeSupplier,

	onResourceManagerPanelShow	= onResourceManagerPanelShow,
	onResourceManagerPanelHide	= onResourceManagerPanelHide,
}