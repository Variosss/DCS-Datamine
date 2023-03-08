local DialogLoader	    = require('DialogLoader')
local ListBoxItem	    = require('ListBoxItem')
local SkinUtils		    = require('SkinUtils')
local textutil		    = require('textutil')
local i18n			    = require('i18n')
local MapWindow		    = require('me_map_window')
local MsgWindow		    = require('MsgWindow')
local module_mission    = require('me_mission')
local waitScreen	    = require('me_wait_screen')
local GDData            = require('me_generator_dialog_data')
local MissionData		= require('Mission.Data')
local progressBar 		= require('ProgressBarDialog')
local ProductType 		= require('me_ProductType')

local _ = i18n.ptranslate

local controller_
local window_
local listBoxNeutral_
local listBoxRed_
local listBoxBlue_
local listBoxTheatresOfWar_
local editBoxTheatreOfWarDescription_
local staticTheatreOfWarPicture_
local staticTheatreOfWarSkin_
local theatreOfWarName_
local theatresOfWar_
local redCoalition_
local blueCoalition_
local neutralCoalition_

local curListBox 	= nil
local curCoal    	= nil
local returnScreen 	= nil
local curTerrain	= nil -- тот что в игре до вызова панели

local function setController(controller)
	controller_ = controller
end

local function selectUserPreset() -- переключает комбобокс, но ничего не загружает
    clPresets:selectItem(clPresets:getItem(0))
	controller_.setIdPreset(controller_.getIdUserPreset()) 
end

local function selectTheatreOfWar(theatreOfWarName)
	for i, theatreOfWar in ipairs(theatresOfWar_) do
		if theatreOfWar.name == theatreOfWarName then
			listBoxTheatresOfWar_:selectItem(listBoxTheatresOfWar_:getItem(i - 1))
			editBoxTheatreOfWarDescription_:setText(theatreOfWar.description)
			staticTheatreOfWarPicture_:setSkin(SkinUtils.setScrollPanePicture(theatreOfWar.image, staticTheatreOfWarSkin_))
		end
	end
	
	theatreOfWarName_ = theatreOfWarName
end

local function fillTheatresOfWarListBox(theatresOfWar)
	for i, theatreOfWar in ipairs(theatresOfWar) do
		local item = ListBoxItem.new(theatreOfWar.localizedName)
		item.theatreOfWar = theatreOfWar
		
		listBoxTheatresOfWar_:insertItem(item)
	end
	
	function listBoxTheatresOfWar_:onItemMouseUp()
		local item = self:getSelectedItem()
		if item then
			selectTheatreOfWar(item.theatreOfWar.name)
		else
			selectTheatreOfWar(theatreOfWarName_)
		end	
	end
end

function cloneItem(item)
  local newItem = ListBoxItem.new(item:getText())
  local skin = item:getSkin()
  newItem.countryId = item.countryId
  
  newItem:setSkin(skin)  
  
  return newItem
end

local first, second, third 
if _G.__PRODUCT_ID__ == 2 then
	first 	= _('Combined Joint Task Forces Blue')
	second 	= _('Combined Joint Task Forces Red')
	third	= _("United Nations Peacekeepers")
end

local function compareCountryNames(countryId1, countryId2)
	local name1 = controller_.getCountryNameById(countryId1)
	local name2 = controller_.getCountryNameById(countryId2)
	
	if first then
		if name1 == first then
			return true
		end
		
		if name2 == first then
			return false
		end	
	end	
	
	if second then
		if name1 == second then
			return true
		end
		
		if name2 == second then
			return false
		end	
	end	
	
	if third then
		if name1 == third then
			return true
		end
		
		if name2 == third then
			return false
		end	
	end	
		
	return textutil.Utf8Compare(name1, name2)	
end



-- move country from one coalition to another
local function changeCoalition(fromListBox, fromCoalition, toListBox, toCoalition)
    local selectedItem = fromListBox:getSelectedItem()
    
    if selectedItem then
		local itemIndex = fromListBox:getItemIndex(selectedItem)
		local countryId = selectedItem.countryId
		
		local removeIndex
		for k,v in ipairs(fromCoalition) do
			if v == countryId then
				removeIndex= k
			end
		end
		if removeIndex then
			table.remove(fromCoalition, removeIndex)
		end
		
		table.insert(toCoalition, countryId)
		table.sort(toCoalition, compareCountryNames)
		
        local newItem = cloneItem(selectedItem)
		for i, id in ipairs(toCoalition) do
			if id == countryId then
				toListBox:insertItem(newItem , i - 1)
			end	
		end
		
		fromListBox:removeItem(selectedItem)

		if itemIndex > 0 then
			itemIndex = itemIndex - 1
		end
		
        toListBox:selectItem(newItem)
		--fromListBox:selectItem(fromListBox:getItem(itemIndex))
        selectUserPreset()
	end
end

local function fillListBox(listBox, coalition)	
	listBox:clear()
	
	table.sort(coalition, compareCountryNames)
	
	for i, countryId in ipairs(coalition) do
		local country = controller_.getCountryById(countryId)
		
		if country.hide ~= true then
			local item = ListBoxItem.new(country.name)
			
			-- сначала добавляем итем в список,
			-- чтобы итем получил скин из скина списка		
			listBox:insertItem(item)
			item.countryId = countryId
			
			item:setSkin(SkinUtils.setListBoxItemPicture(controller_.getCountryById(countryId).flag_small, item:getSkin()))
		end
	end
end

local function updateCoalitions()
	redCoalition_		= controller_.getRedCoalition()
	blueCoalition_		= controller_.getBlueCoalition()
	neutralCoalition_	= controller_.getNeutralCoalition()	
end

local function addUserPreset()
    local item = ListBoxItem.new(_("Custom"))
		
	item.name = _("Custom")
    item.id = controller_.getIdUserPreset() 
		
	clPresets:insertItem(item)
        
	clPresets:selectItem(item) 
    controller_.setIdPreset(controller_.getIdUserPreset())
end

local function fillPresets()
    local presets = controller_.getPresets()
    clPresets:clear()
    
    addUserPreset()
    
    for k, preset in pairs(presets) do
        local item = ListBoxItem.new(preset.name)
		
		item.name = preset.name
        item.id = preset.id
		
		clPresets:insertItem(item)
    end
end

local function onReset()
    fillPresets()
	updateCoalitions()
	
	fillListBox(listBoxRed_,		redCoalition_)
	fillListBox(listBoxBlue_,		blueCoalition_)
	fillListBox(listBoxNeutral_,	neutralCoalition_)
end

local function onChange_clPresets(self)
    local item = self:getSelectedItem()
    
    if item then 
        controller_.setIdPreset(item.id)
        updateCoalitions()
        fillListBox(listBoxRed_,		redCoalition_)
        fillListBox(listBoxBlue_,		blueCoalition_)
        fillListBox(listBoxNeutral_,	neutralCoalition_)
        updateEnabledOk()
    end
end

local function create_()
	local localization = {
		title				= _('NEW MISSION SETTINGS'),
		maps				= _('CHOOSE MAP'),
		neutrals			= _('NEUTRAL'),
		save				= _('SAVE'),
		ok					= _('OK'),
		reset				= _('RESET'),
		red					= _('RED'),
		blue				= _('BLUE'),
        CHOOSE_COALITION    = _('ASSIGN COUNTRIES TO COALITIONS'),
        resetCoalitions     = _('CLEAN COALITIONS'),
		PRESETS				= _('COALITION PRESETS'),
	}
	
	local window = DialogLoader.spawnDialogFromFile("./MissionEditor/modules/dialogs/me_coalitions_panel.dlg", localization)	   
	
    main_panel                      = window.main_panel
	listBoxNeutral_					= main_panel.listBoxNeutral
	listBoxRed_						= main_panel.listBoxRed
	listBoxBlue_					= main_panel.listBoxBlue
	listBoxTheatresOfWar_			= main_panel.listBoxMaps
	editBoxTheatreOfWarDescription_	= main_panel.editBoxMapDescription
	staticTheatreOfWarPicture_		= main_panel
    btnToRed                        = main_panel.btnToRed
    btnToNeutral                    = main_panel.btnToNeutral
    btnToBlue                       = main_panel.btnToBlue       
    clPresets                       = main_panel.clPresets
	sPreset							= main_panel.sPreset
	bToNeutralsT					= main_panel.bToNeutralsT
    
	staticTheatreOfWarSkin_			= main_panel:getSkin()
	
	theatresOfWar_		= controller_.getTheatresOfWar()
	theatreOfWarName_	= controller_.getSelectedTheatreOfWarName()
	
	fillTheatresOfWarListBox(theatresOfWar_)
	selectTheatreOfWar(theatreOfWarName_)	

    listBoxRed_.onChange        = onChange_listBoxRed
    listBoxNeutral_.onChange    = onChange_listBoxNeutral
    listBoxBlue_.onChange       = onChange_listBoxBlue
    btnToRed.onChange           = onChange_btnToRed
    btnToNeutral.onChange       = onChange_btnToNeutral
	bToNeutralsT.onChange       = onChange_btnToNeutral
    btnToBlue.onChange          = onChange_btnToBlue  

    buttonOk = window.main_panel.buttonOk   
	buttonSave = window.main_panel.buttonSave
    
	window.main_panel.btnCancel:setVisible(false)
	window.main_panel.btnUndoChanges:setVisible(false)
	
    local w, h = Gui.GetWindowSize()
    window:setBounds(0, 0, w, h)
    main_panel:setBounds((w-1024)/2, (h-650)/2, 1024, 650)
	
	if _G.__PRODUCT_ID__ == 2 then		
		btnToRed:setPosition(610,136)
		btnToBlue:setPosition(755,136)
		bToNeutralsT:setVisible(true)
		btnToNeutral:setVisible(false)
	else	
		bToNeutralsT:setVisible(false)
		btnToNeutral:setVisible(true)
	end
    
    function window.main_panel.buttonSave:onChange()
		controller_.saveDefaultCoalitions(redCoalition_, blueCoalition_, neutralCoalition_)
		controller_.setDefaultCoalitions()
        
        GDData.initData()
	end
    
    window.main_panel.btnReset.onChange = allToNeutral
    
    function initTerr()
        if MapWindow.initTerrain(false, false, "ME", module_mission.getDefaultDate()) == true then
            window:setVisible(false)
        else
            MsgWindow.error(_("error initialization terrain"), _('ERROR'), 'OK'):show()
        end 
        
		module_mission.create_new_mission(true)			
		MapWindow.show(true)
		
        return true
    end
	
	buttonOk.onChange = onChange_Ok
	window.main_panel.btnClose.onChange = onChange_Escape
    
    window:addHotKeyCallback('return', onChange_Ok)
    window:addHotKeyCallback('escape', onChange_Escape)

    clPresets.onChange = onChange_clPresets

	listBoxRed_:addKeyDownCallback(lbRedKeyDown)
	listBoxNeutral_:addKeyDownCallback(lbNeutralKeyDown)
    listBoxBlue_:addKeyDownCallback(lbBlueKeyDown)
		
	
	return window
end

function lbRedKeyDown(self, keyName, unicode)
	if keyName == 'left' then		
		return true
	end
	if keyName == 'right' then
		--переносим в нейтралы
		local selectItem = self:getSelectedItem()
        if selectItem then
			local index = self:getItemIndex(selectItem)
			changeCoalition(self, curCoal, listBoxNeutral_, neutralCoalition_)
            onChange_listBoxRed()
			if self:getItemCount() > 0 then
				if (index - 1) >= 0 then 
					self:selectItem(self:getItem(index - 1))
				else
					self:selectItem(self:getItem(index))
				end
			end
            updateEnabledOk()
        end
		return true
	end

end

function lbNeutralKeyDown(self, keyName, unicode)
	if keyName == 'left' then		
		--переносим в красные
		local selectItem = self:getSelectedItem()
        if selectItem then
			local index = self:getItemIndex(selectItem)
            changeCoalition(self, curCoal, listBoxRed_, redCoalition_)
            onChange_listBoxNeutral()
			if self:getItemCount() > 0 then
				if (index - 1) >= 0 then 
					self:selectItem(self:getItem(index - 1))
				else
					self:selectItem(self:getItem(index))
				end
			end
            updateEnabledOk()
        end
		return true
	end
	if keyName == 'right' then
		--переносим в синии
		local selectItem = self:getSelectedItem()
        if selectItem then
			local index = self:getItemIndex(selectItem)
            changeCoalition(self, curCoal, listBoxBlue_, blueCoalition_)
            onChange_listBoxNeutral()
			if self:getItemCount() > 0 then
				if (index - 1) >= 0 then 
					self:selectItem(self:getItem(index - 1))
				else
					self:selectItem(self:getItem(index))
				end
			end
            updateEnabledOk()
        end
		return true
	end
end

function lbBlueKeyDown(self, keyName, unicode)
	if keyName == 'left' then
		--переносим в нейтралы
		local selectItem = self:getSelectedItem()
        if selectItem then
			local index = self:getItemIndex(selectItem)
			changeCoalition(self, curCoal, listBoxNeutral_, neutralCoalition_)
            onChange_listBoxBlue()
			if self:getItemCount() > 0 then
				if (index - 1) >= 0 then 
					self:selectItem(self:getItem(index - 1))
				else
					self:selectItem(self:getItem(index))
				end
			end
            updateEnabledOk()
        end
		return true
	end
	if keyName == 'right' then		
		return true
	end
end

function startME()
	controller_.selectTheatreOfWar(theatreOfWarName_, true)   
	controller_.setCoalitions(redCoalition_, blueCoalition_, neutralCoalition_)

	progressBar.setUpdateFunction(initTerr)		
end
	
function onChange_Ok()
	if buttonOk:getEnabled() == true then
		startME()
	end	
end
	
function onChange_Escape()
	onReset()
	updateEnabledOk()
	theatreOfWarName_ = curTerrain or theatreOfWarName_
	if returnScreen == "MissionEditor" then
		startME()
	else
		window_:setVisible(false)
	end	
end

local function isVisible()
	if window_ then
		return window_:getVisible()
	end
	return false
end

local function show(a_returnScreen, a_curTerrain)
	if not window_ then
		window_ = create_()
	end
	
	returnScreen 	= a_returnScreen
	curTerrain 		= a_curTerrain
	
	onReset()
	
	window_:setVisible(true)
end

local function close()
	if window_ then
		window_:close()
	end
end

function onChange_listBoxRed()
    listBoxNeutral_:selectItem()
    listBoxBlue_:selectItem()
    btnToRed:setEnabled(false)
    btnToNeutral:setEnabled(true)
    btnToBlue:setEnabled(true)
    curListBox = listBoxRed_
    curCoal = redCoalition_
end

function onChange_listBoxNeutral()
    listBoxBlue_:selectItem()
    listBoxRed_:selectItem()
    btnToRed:setEnabled(true)
    btnToNeutral:setEnabled(false)
    btnToBlue:setEnabled(true)
    curListBox = listBoxNeutral_
    curCoal = neutralCoalition_
end

function onChange_listBoxBlue()
    listBoxNeutral_:selectItem()
    listBoxRed_:selectItem()
    btnToRed:setEnabled(true)
    btnToNeutral:setEnabled(true)
    btnToBlue:setEnabled(false)
    curListBox = listBoxBlue_
    curCoal = blueCoalition_
end

function allToNeutral()
    for k, countryId in pairs(redCoalition_) do
        table.insert(neutralCoalition_, countryId)
    end
    redCoalition_ = {}
    
    for k, countryId in pairs(blueCoalition_) do
        table.insert(neutralCoalition_, countryId)
    end
    blueCoalition_ = {}

	table.sort(neutralCoalition_, compareCountryNames)
    
    fillListBox(listBoxRed_,		redCoalition_)
    fillListBox(listBoxBlue_,		blueCoalition_)
    fillListBox(listBoxNeutral_,	neutralCoalition_)
    updateEnabledOk()
    selectUserPreset()
end

function updateEnabledOk()
    if #redCoalition_ > 0 or #blueCoalition_ > 0 then
        buttonOk:setEnabled(true)
		buttonSave:setEnabled(true)
    else
        buttonOk:setEnabled(false)
		buttonSave:setEnabled(false)
    end
end

function onChange_btnToRed()
    if curListBox then
        local selectItem = curListBox:getSelectedItem()
        if selectItem then
            changeCoalition(curListBox, curCoal, listBoxRed_, redCoalition_)
            onChange_listBoxRed()
            updateEnabledOk()
        end
    end
end

function onChange_btnToNeutral()
    if curListBox then
        local selectItem = curListBox:getSelectedItem()
        if selectItem then
            changeCoalition(curListBox, curCoal, listBoxNeutral_, neutralCoalition_)
            onChange_listBoxNeutral()
            updateEnabledOk()
        end
    end
end

function onChange_btnToBlue()
    if curListBox then
        local selectItem = curListBox:getSelectedItem()
        if selectItem then
            changeCoalition(curListBox, curCoal, listBoxBlue_, blueCoalition_)
            onChange_listBoxBlue()
            updateEnabledOk()
        end
    end
end



return {
	setController				= setController,
	create						= create,
	show						= show,
	close						= close,
	setVehicleGroupId			= setVehicleGroupId,
	getVehicleGroupId			= getVehicleGroupId,
	vehicleGroupNameChanged		= vehicleGroupNameChanged,
	isVisible					= isVisible,	
}