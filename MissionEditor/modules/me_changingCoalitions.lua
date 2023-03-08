local base = _G

module('me_changingCoalitions')

local require = base.require

local DialogLoader	    	= require('DialogLoader')
local ListBoxItem	    	= require('ListBoxItem')
local SkinUtils		    	= require('SkinUtils')
local Gui					= require('dxgui')
local TheatreOfWarData		= require('Mission.TheatreOfWarData')
local CoalitionController	= require('Mission.CoalitionController')
local MapWindow		    	= require('me_map_window')
local module_mission    	= require('me_mission')
local textutil		    	= require('textutil')


base.require('i18n').setup(_M)


local cdata = {
		title				= _('CHANGING COALITIONS'),
		neutrals			= _('NEUTRAL'),
		save				= _('SAVE'),
		ok					= _('OK'),
		reset				= _('RESET'),
		red					= _('RED'),
		blue				= _('BLUE'),
        CHOOSE_COALITION    = _('ASSIGN COUNTRIES TO COALITIONS'),
        resetCoalitions     = _('CLEAN COALITIONS'),
		PRESETS				= _('COALITION PRESETS'),
		UndoChanges			= _('UNDO CHANGES'),
		Cancel				= _('CANCEL'),
	}
	
	
local redCoalition_
local blueCoalition_
local neutralCoalition_

local redCoalitionOld
local blueCoalitionOld
local neutralCoalitionOld

local countryTbl = {}
local numUnits  = {}
local numGroups = {}


function create()
	window = DialogLoader.spawnDialogFromFile("./MissionEditor/modules/dialogs/me_coalitions_panel.dlg", cdata)	   
	
	main_panel = window.main_panel
	
	btnToRed                        = main_panel.btnToRed
    btnToNeutral                    = main_panel.btnToNeutral
    btnToBlue                       = main_panel.btnToBlue  
	listBoxNeutral_					= main_panel.listBoxNeutral
	listBoxRed_						= main_panel.listBoxRed
	listBoxBlue_					= main_panel.listBoxBlue
	buttonOk 						= main_panel.buttonOk  
	btnUndoChanges					= main_panel.btnUndoChanges
	btnCancel 						= main_panel.btnCancel
	btnClose						= main_panel.btnClose
	editBoxTheatreOfWarDescription_	= main_panel.editBoxMapDescription
    
	
	listBoxRed_.onChange        = onChange_listBoxRed
    listBoxNeutral_.onChange    = onChange_listBoxNeutral
    listBoxBlue_.onChange       = onChange_listBoxBlue
    btnToRed.onChange           = onChange_btnToRed
    btnToNeutral.onChange       = onChange_btnToNeutral
    btnToBlue.onChange          = onChange_btnToBlue  
	buttonOk.onChange 			= onChange_Ok
	btnUndoChanges.onChange 	= onChange_UndoChanges
	btnCancel.onChange 			= onChange_Cancel
	btnClose.onChange 			= onChange_Cancel
	
	window:addHotKeyCallback('return', onChange_Ok)
    window:addHotKeyCallback('escape', onChange_Cancel)
	
	listBoxRed_:addKeyDownCallback(lbRedKeyDown)
	listBoxNeutral_:addKeyDownCallback(lbNeutralKeyDown)
    listBoxBlue_:addKeyDownCallback(lbBlueKeyDown)
	
	
	main_panel.sMap:setVisible(false)
	main_panel.listBoxMaps:setVisible(false)
	main_panel.sPreset:setVisible(false)
	main_panel.clPresets:setVisible(false)
	main_panel.btnReset:setVisible(false)
	
	
	local w, h = Gui.GetWindowSize()
    window:setBounds(0, 0, w, h)
    main_panel:setBounds((w-1024)/2, (h-650)/2, 1024, 650)
	editBoxTheatreOfWarDescription_:setBounds(32, 176, 340,420)
	
	main_panelSkin_			= main_panel:getSkin()

	btnCancel = main_panel.btnCancel
	
	main_panel.bToNeutralsT:setVisible(false)
end

function show(b)
	if window == nil then
		create()
	end
	
	if b then
		main_panel:setSkin(SkinUtils.setScrollPanePicture(TheatreOfWarData.getImage(), main_panelSkin_))
		fillNumUnits()
		onReset()
		selectUserPreset()
	end
	
	window:setVisible(b)
end

function selectUserPreset() 
	CoalitionController.setIdPreset(CoalitionController.getIdUserPreset()) 
end

local function compareCountryNames(countryId1, countryId2)
	local name1 = CoalitionController.getCountryNameById(countryId1)
	local name2 = CoalitionController.getCountryNameById(countryId2)
	
	return textutil.Utf8Compare(name1, name2)	
end

function fillNumUnits()
	numUnits  = {}
	numGroups = {}
	
	for k,coal in base.pairs(module_mission.mission.coalition) do
		for kk,vv in base.pairs(coal) do
			for kkk,country in base.pairs(coal.country) do
				numGroups[country.id] = 0
				numUnits[country.id] = 0
				for kkkk,grType in base.pairs({"helicopter","ship","plane","vehicle","static"}) do
					if country[grType] and country[grType].group then					
						numGroups[country.id] = numGroups[country.id] + #country[grType].group
						for kkkkk, group in base.pairs(country[grType].group) do
							numUnits[country.id] = numUnits[country.id] + #group.units
						end	
					end
				end			
			end
		end
	
	end
	
end

function updateLog()
	local txt = ""
	
	local function firstToUpper(str)
		return (str:gsub("^%l", base.string.upper))
	end

	local function addLog(a_coalOld, a_coalNew, a_country)
		txt = txt..a_country.name.._(' is switching from ').. _(firstToUpper(a_coalOld)) .. _(' to ') .. _(firstToUpper(a_coalNew)) .. '\n' 
		txt = txt..'  - ' .. (numUnits[a_country.id] or 0) .." ".. _('units in') .." ".. (numGroups[a_country.id] or 0) .." ".. _('groups will').." ".._('switch teams').. '\n\n'
	end
	
	for k, id in base.pairs(redCoalition_) do
		if countryTbl[id].boss ~= module_mission.mission.coalition.red then
			addLog(countryTbl[id].boss.name, module_mission.mission.coalition.red.name, countryTbl[id])	
		end
	end
	
	for k, id in base.pairs(blueCoalition_) do
		if countryTbl[id].boss ~= module_mission.mission.coalition.blue then
			addLog(countryTbl[id].boss.name, module_mission.mission.coalition.blue.name, countryTbl[id])	
		end
	end
	
	for k, id in base.pairs(neutralCoalition_) do
		if countryTbl[id].boss ~= module_mission.mission.coalition.neutrals then
			addLog(countryTbl[id].boss.name, module_mission.mission.coalition.neutrals.name, countryTbl[id])	
		end
	end
	editBoxTheatreOfWarDescription_:setText(txt)
end

function onReset()
	updateCoalitions()
	
	fillListBox(listBoxRed_,		redCoalition_)
	fillListBox(listBoxBlue_,		blueCoalition_)
	fillListBox(listBoxNeutral_,	neutralCoalition_)
	
	redCoalitionOld = {}
	blueCoalitionOld = {}
	neutralCoalitionOld = {}
	
	editBoxTheatreOfWarDescription_:setText("")
	
	base.U.recursiveCopyTable(redCoalitionOld, redCoalition_)
	base.U.recursiveCopyTable(blueCoalitionOld, blueCoalition_)
	base.U.recursiveCopyTable(neutralCoalitionOld, neutralCoalition_)

	fillCountryTbl()	
end

function fillCountryTbl()	
	countryTbl = {}
	for k,v in base.pairs(module_mission.mission.coalition.red.country) do
		countryTbl[v.id] = v
	end
	for k,v in base.pairs(module_mission.mission.coalition.blue.country) do
		countryTbl[v.id] = v
	end
	for k,v in base.pairs(module_mission.mission.coalition.neutrals.country) do
		countryTbl[v.id] = v
	end
end

function fillListBox(listBox, coalition)	
	listBox:clear()
	
	base.table.sort(coalition, compareCountryNames)
	
	for i, countryId in base.ipairs(coalition) do
		local countryName = CoalitionController.getCountryNameById(countryId)
		local item = ListBoxItem.new(countryName)
		
		-- сначала добавляем итем в список,
		-- чтобы итем получил скин из скина списка		
		listBox:insertItem(item)
		item.countryId = countryId
		
		item:setSkin(SkinUtils.setListBoxItemPicture(CoalitionController.getCountryById(countryId).flag_small, item:getSkin()))
	end
end

function updateCoalitions()
	redCoalition_		= CoalitionController.getRedCoalition()
	blueCoalition_		= CoalitionController.getBlueCoalition()
	neutralCoalition_	= CoalitionController.getNeutralCoalition()
end

function rebuildCountries()
	for k, id in base.pairs(redCoalition_) do
		if countryTbl[id].boss ~= module_mission.mission.coalition.red then
			module_mission.moveCountryToCoalition(countryTbl[id], module_mission.mission.coalition.red)
		end
	end
	
	for k, id in base.pairs(blueCoalition_) do
		if countryTbl[id].boss ~= module_mission.mission.coalition.blue then
			module_mission.moveCountryToCoalition(countryTbl[id], module_mission.mission.coalition.blue)
		end
	end
	
	for k, id in base.pairs(neutralCoalition_) do
		if countryTbl[id].boss ~= module_mission.mission.coalition.neutrals then
			module_mission.moveCountryToCoalition(countryTbl[id], module_mission.mission.coalition.neutrals)
		end
	end
	
	
end

function onChange_Ok()
	if buttonOk:getEnabled() == true then		
		startME()				
	end	
end

function onChange_Cancel()
	onChange_UndoChanges()
	startME()
end

function onChange_UndoChanges()
	onReset()
	updateLog()
	updateEnabledOk()
end

function startME() 
	CoalitionController.setCoalitions(redCoalition_, blueCoalition_, neutralCoalition_)
	rebuildCountries()
	module_mission.update_groups_colors() 
	window:setVisible(false)	
	MapWindow.show(true)
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

function updateEnabledOk()
    if #redCoalition_ > 0 or #blueCoalition_ > 0 then
        buttonOk:setEnabled(true)
    else
        buttonOk:setEnabled(false)
    end
	updateLog()
end

function cloneItem(item)
  local newItem = ListBoxItem.new(item:getText())
  local skin = item:getSkin()
  newItem.countryId = item.countryId
  
  newItem:setSkin(skin)  
  
  return newItem
end

-- move country from one coalition to another
function changeCoalition(fromListBox, fromCoalition, toListBox, toCoalition)
    local selectedItem = fromListBox:getSelectedItem()
    
    if selectedItem then
		local itemIndex = fromListBox:getItemIndex(selectedItem)
		local countryId = selectedItem.countryId
		
		local removeIndex
		for k,v in base.ipairs(fromCoalition) do
			if v == countryId then
				removeIndex= k
			end
		end
		if removeIndex then
			base.table.remove(fromCoalition, removeIndex)
		end
		base.table.insert(toCoalition, countryId)
		base.table.sort(toCoalition, compareCountryNames)
		
        local newItem = cloneItem(selectedItem)
		for i, id in base.ipairs(toCoalition) do
			if id == countryId then
				toListBox:insertItem(newItem , i - 1)
			end	
		end
		
		fromListBox:removeItem(selectedItem)

		if itemIndex > 0 then
			itemIndex = itemIndex - 1
		end
		
        toListBox:selectItem(newItem)
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

function isVisible()
	if window then
		return window:getVisible()
	end
	return false
end





