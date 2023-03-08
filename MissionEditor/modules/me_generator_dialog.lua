local U						= require('me_utilities')
local DialogLoader			= require('DialogLoader')
local ComboList				= require('ComboList')
local Static				= require('Static')
local AutoBriefingModule	= require('me_autobriefing')
local NodesMap				= require('NodesMap')
local NodesManager			= require('me_nodes_manager')
local waitScreen			= require('me_wait_screen')
local GDData				= require('me_generator_dialog_data')
local me_modules_mediator	= require('me_modules_mediator')
local MainMenu				= require('MainMenu')
local Skin					= require('Skin')
local SkinUtils				= require('SkinUtils')
local TheatreOfWarData		= require('Mission.TheatreOfWarData')
local i18n					= require('i18n')
local autobriefingutils     = require('autobriefingutils')
local DB 					= require('me_db_api')
local ProductType 			= require('me_ProductType') 
local UpdateManager			= require('UpdateManager')

local base = _G

local _ = i18n.ptranslate

local gdWindow, splashScreen
local containerCommon, containerForces, containerPlace
local showedFrom
--TODO убрать curentTOW когда в комбобоксе можно будет получить текущий элемент
local currentTOW

local missionNotGeneratedMsg = _("MISSION WAS NOT GENERATED")
local noMissionLoadedMsg = _("No mission loaded")

local autoBriefingItemSkin
local autoBriefingScrollpane

if ProductType.getType() == "LOFAC" then
    missionNotGeneratedMsg = _("MISSION WAS NOT GENERATED-LOFAC")
    noMissionLoadedMsg = _("No mission loaded-LOFAC")
end

local function initForcesOptions()
	local offY = 43
	local rowOffset = 9
	local firstColX, secondColX, thirdColX = 5, 178, 399
	local rowIndex = 0
	local widgetHeight = 20
	local labelWidth, comboWidth = 155, 140

	local labelSkin = Skin.staticMissionGeneratorCaptionSkin()
	local comboSkin = Skin.comboListSkin_options()

	for i,v in base.pairs(GDData.getCompanyTypes()) do
		local curY = offY + rowIndex*(widgetHeight+rowOffset)
		local label = Static.new(v.name)

		label:setBounds(firstColX, curY+2, labelWidth, widgetHeight)
		containerForces:insertWidget(label)
		label:setSkin(labelSkin)

		local redCombo = ComboList:new()
		redCombo:setSkin(comboSkin)
		U.fillComboBoxFromTable(redCombo, GDData.getAmountLevels(), "name", "id")

		U.setComboboxValueById(redCombo, GDData.genParams().forces[v.id].red)

		redCombo:setBounds(secondColX, curY, comboWidth, widgetHeight)
		containerForces:insertWidget(redCombo)
		function redCombo:onChange(item)
			GDData.genParams().forces[v.id].red = item.itemId
		end

		local blueCombo = ComboList:new()
		blueCombo:setSkin(comboSkin)
		U.fillComboBoxFromTable(blueCombo, GDData.getAmountLevels(), "name", "id")

		U.setComboboxValueById(blueCombo, GDData.genParams().forces[v.id].blue)
		blueCombo:setBounds(thirdColX, curY, comboWidth, widgetHeight)
		containerForces:insertWidget(blueCombo)
		function blueCombo:onChange(item)
			GDData.genParams().forces[v.id].blue = item.itemId
		end

		rowIndex = rowIndex + 1
	end

	GDData.genParams().predefinedMission = 0
	GDData.genParams().wingmansCount = 0
	GDData.genParams().playerAltitude = 0
	GDData.genParams().nodeDistance = 0
	GDData.genParams().typeAttack = "head-on"
end

local show

local function onButtonFly() 
	local MGModule = base.require('me_generator')
    MGModule.reloadMission()
	AutoBriefingModule.returnToME = true
	AutoBriefingModule.show(true, 'mainmenu')
    show(false)
end

local function onButtonExit()
	show(false)
	reset()
	if showedFrom == 'editor' then
		if MapWindow.isEmptyME() ~= true then
			base.MapWindow.show(true)
		else
			base.MapWindow.showEmpty()
		end	
	elseif showedFrom == 'simplegenerator' then
		MainMenu.show(true)
		me_modules_mediator.get_me_simple_generator_dialog().show(true)
	else
		MainMenu.show(true)
	end
end

local function fillAutoBriefingWidget(text)
	local item = Static:new()

 	item:setText(text)
	item:setSkin(autoBriefingItemSkin)
	item:setBounds(10, 5, 378, 200)
    
	autoBriefingScrollpane:clear()
	autoBriefingScrollpane:insertWidget(item)
    item:setWrapping(true)
end

local enmGenStart, enmGenFinish, enmPercent = 0, 1, 2

local function onButtonGenerate()
	waitScreen.showMini(true, _("Generated:").."0%")
	UpdateManager.add(function()
		local MGModule = base.require('me_generator')
		if GDData.verifyCoalition() == false then
			errMsg = GDData.cdata.noCountryInCoalition
			endGenerate(enmGenFinish, -1, errMsg)
		else
			if cbHistorical:getState() == true then
				GDData.genParams().predefinedMission = 3 -- исторический
			else
				GDData.genParams().predefinedMission = 0
			end
						
			MGModule.generate(GDData.genParams(), false, GDData.genParams().theatreOfWar, containerPlace.nodesMap:getSelectedNodes(), nil, nil, endGenerate)			
		end
		return true
	end)	
end

function endGenerate(returnCode, nodeId, error)
	if returnCode == enmGenFinish then
		if nodeId ~= -1 then
			AutoBriefingModule.updateAutoBriefing()
			autobriefingutils.updateScrollPane(autoBriefingScrollpane, 490)            
			containerPlace.nodesMap:setMissionNode(nodeId)
			gdWindow.containerMain.containerBriefing.buttonEdit:setEnabled(true)
			btnFly:setEnabled(true)
		else
			fillAutoBriefingWidget(missionNotGeneratedMsg..'\n\n'..error)            
			btnFly:setEnabled(false)
		end

		waitScreen.showMini(false)
	elseif returnCode == enmPercent then
		waitScreen.setMiniText(_("Generated:")..tostring(base.math.floor(nodeId))..'%'--[[ - '..error]])
		waitScreen.setMiniValue(base.math.floor(nodeId))
	end
end

local function resetNodesMap(theatreOfWarName)
	local theatreOfWar = TheatreOfWarData.getTheatreOfWar(theatreOfWarName)
	if not theatreOfWar then 
		return 
	end

	local nodesMap = containerPlace.nodesMap

	nodesMap:setSkin(SkinUtils.setStaticPicture(theatreOfWar.nodesMapFile, nodesMap:getSkin()))
	nodesMap:setMapBorders(base.unpack(theatreOfWar.nodesMapBorders))
	nodesMap:updateNodes(filterByTasks(NodesManager.nodes(theatreOfWarName)))
end

function filterByTasks(a_nodes)
	local result = {}
	if a_nodes then
		for k, node in ipairs(a_nodes) do
			local selectedItem = containerCommon.comboboxTasks:getSelectedItem()

			if selectedItem == nil 
				or node.Tasks == nil 
				or (node.Tasks and #node.Tasks == 0)
				or U.find(node.Tasks, selectedItem and selectedItem.taskOldID) ~= nil then

				base.table.insert(result, node)
			end
		end
	end
	return result
end

function initPlaceOptions()
	local nodesMap = NodesMap.new()
	nodesMap:setBounds(47, 63, 545, 293)
	containerPlace:insertWidget(nodesMap)
	containerPlace.nodesMap = nodesMap
	resetNodesMap(GDData.genParams().theatreOfWar)
end

local function create()
    gdWindow = DialogLoader.spawnDialogFromFile('MissionEditor/modules/dialogs/me_gen_options.dlg', GDData.cdata)
    autoBriefingItemSkin = gdWindow.staticAutoBriefingItem:getSkin()
    
    w, h = Gui.GetWindowSize()
    gdWindow:setBounds(0, 0, w, h)


	splashScreen = DialogLoader.spawnDialogFromFile('MissionEditor/modules/dialogs/me_gen_splash_screen.dlg', GDData.cdata)
	splashScreen:centerWindow()

	local containerMain = gdWindow.containerMain
    btnCancel   = containerMain.btnCancel
    btnClose    = containerMain.btnClose
	btnFly      = containerMain.btnFly
    
    pNoVisible = gdWindow.pNoVisible
    
    autobriefingutils.setStaticSectionItemSkin(pNoVisible.staticSkinSectionItem:getSkin())
    autobriefingutils.setStaticSectionDataItemSkin(pNoVisible.staticSkinSectionDataItem:getSkin())
    autobriefingutils.setEditBoxSectionDataItemSkin(pNoVisible.editboxSkinSectionDataItem:getSkin())
    autobriefingutils.setStaticTitleItemSkin(pNoVisible.staticSkinTitleItem:getSkin())
    autobriefingutils.setStaticGridCellSkin(pNoVisible.staticGridCellSkin:getSkin())
    autobriefingutils.setGridSkin(pNoVisible.grid:getSkin())
    autobriefingutils.setGridHeaderSkin(pNoVisible.gridHeaderCell:getSkin())
    
    w, h = Gui.GetWindowSize()
    gdWindow:setBounds(0, 0, w, h)
    containerMain:setBounds((w-1280)/2, (h-768)/2, 1280, 768)

	containerCommon = containerMain.containerCommon
	containerForces = containerMain.containerForces
	containerPlace = containerMain.containerPlace
	autoBriefingScrollpane = containerMain.containerBriefing.autoBriefingScrollpane

	GDData.initCommonOptions(containerCommon)

	local cccurrentTOW = containerCommon.comboboxTheatreOfWar:getItem(0)
	if cccurrentTOW then
		containerCommon.comboboxTheatreOfWar:onChange(cccurrentTOW)
	end

	initForcesOptions()
	fillAutoBriefingWidget(noMissionLoadedMsg)
	initPlaceOptions()
	currentTOW = GDData.genParams().theatreOfWar
	
	gdWindow.containerMain.containerBriefing.buttonEdit:setEnabled(false)

	btnCancel.onChange = onButtonExit
    btnClose.onChange = onButtonExit
	btnFly.onChange = onButtonFly
	btnFly:setEnabled(false)
	containerMain.containerBriefing.buttonGenerate.onChange = onButtonGenerate

	gdWindow:addHotKeyCallback('escape', onButtonExit)
	gdWindow:addHotKeyCallback('return', function()
		if btnFly:getEnabled() then 
			onButtonFly() 
		end 
	end)
	
	function containerCommon.spinboxWingmanCount:onChange()
		--GDData.genParams().wingmansCount = containerCommon.spinboxWingmanCount:getValue()
		GDData.genParams().wingmansCount = self:getValue()
	end
	
	cbHistorical = containerCommon.cbHistorical
	
	function cbHistorical:onChange()
		if self:getState() == true then
			GDData.genParams().predefinedMission = 3 -- исторический
		else
			GDData.genParams().predefinedMission = 0
		end
		
		GDData.fillCountryCombobox(containerCommon.comboboxCountry)
		fillTasksCombobox(containerCommon.comboboxTasks, containerCommon)
	end

	function containerCommon.comboboxTheatreOfWar:onChange(item)
		GDData.genParams().theatreOfWar = item.itemId
		currentTOW = item.itemId
		resetNodesMap(item.itemId)
	end

	containerCommon.spinboxWingmanCount:setValue(GDData.genParams().wingmansCount)

	if GDData.genParams().predefinedMission == 3 then
		cbHistorical:setState(true)
	else	
		cbHistorical:setState(false)
	end	
		
	function containerMain.containerBriefing.buttonEdit:onChange()
		local MGModule = base.require('me_generator')
		MGModule.reloadMission()
		show(false)		
		TheatreOfWarData.selectTheatreOfWar(currentTOW)
		reset()
		MainMenu.showMissionEditor(true)
	end
	
	spinboxAltitude = U.createUnitSpinBox(containerCommon.text_alt, containerCommon.spinboxAltitude, U.altitudeUnits, containerCommon.spinboxAltitude:getRange())
	
	function containerCommon.spinboxAltitude:onChange()
		GDData.genParams().playerAltitude = spinboxAltitude:getValue()
	end
	spinboxAltitude:setValue(GDData.genParams().playerAltitude)
	
	spinboxDistance = U.createUnitSpinBox(containerCommon.text_dist, containerCommon.spinboxDistance, U.distanceUnits, containerCommon.spinboxDistance:getRange())
	
	function containerCommon.spinboxDistance:onChange()
		GDData.genParams().nodeDistance = spinboxDistance:getValue()
	end
	spinboxDistance:setValue(GDData.genParams().nodeDistance)
	
	function containerCommon.comboboxTypeAttack:onChange()
		GDData.genParams().typeAttack = containerCommon.comboboxTypeAttack:getSelectedItem().itemId
	end
	U.setComboboxValueById(containerCommon.comboboxTypeAttack, GDData.genParams().typeAttack)
	
	function containerCommon.comboboxAircraft:onChange(item)
		GDData.genParams().aircraft = item.itemId
		GDData.genParams().aircraftsType = item.aircraftType
		
		GDData.fillCountryCombobox(containerCommon.comboboxCountry)
		fillTasksCombobox(containerCommon.comboboxTasks, containerCommon)
	end

	function containerCommon.comboboxTasks:onChange()
		GDData.genParams().taskWorldID = containerCommon.comboboxTasks:getSelectedItem().taskWorldID
		
		if GDData.genParams().taskWorldID == 10 then --Intercept
			containerCommon.labelAltitude:setVisible(true)
			containerCommon.spinboxAltitude:setVisible(true)			
			containerCommon.text_alt:setVisible(true)
			containerCommon.labelDistance:setVisible(true)
			containerCommon.spinboxDistance:setVisible(true)
			containerCommon.text_dist:setVisible(true)
			containerCommon.labelTypeAttack:setVisible(true)
			containerCommon.comboboxTypeAttack:setVisible(true)
		else
			containerCommon.labelAltitude:setVisible(false)
			containerCommon.spinboxAltitude:setVisible(false)
			containerCommon.text_alt:setVisible(false)
			containerCommon.labelDistance:setVisible(false)
			containerCommon.spinboxDistance:setVisible(false)
			containerCommon.text_dist:setVisible(false)
			containerCommon.labelTypeAttack:setVisible(false)
			containerCommon.comboboxTypeAttack:setVisible(false)
			
			-- сборос параметров для задачи не "Intercept"
			containerCommon.spinboxDistance:setValue(0)
			containerCommon.spinboxAltitude:setValue(0)
			U.setComboboxValueById(containerCommon.comboboxTypeAttack, "head-on")
			GDData.genParams().typeAttack = containerCommon.comboboxTypeAttack:getSelectedItem().itemId
			GDData.genParams().playerAltitude = 0
			GDData.genParams().nodeDistance = 0
		end
		
		resetNodesMap(currentTOW)
	end
end

local function updateUnitSystem()
	local unitSystem = OptionsData.getUnits()
	
	spinboxAltitude:setUnitSystem(unitSystem)
	spinboxDistance:setUnitSystem(unitSystem)
end

local function updateSizeWidgets()

	local newAltW, newAltH = containerCommon.text_alt:calcSize() 
	local newDistW, newDistH = containerCommon.text_dist:calcSize() 

	containerCommon.spinboxAltitude:setSize(140 - newAltW - 5, 20)
	containerCommon.spinboxDistance:setSize(140 - newDistW - 5, 20)
end
	
function fillTasksCombobox(comboboxTasks, containerCommon)
	if comboboxTasks == nil then
		return
	end
	
	comboboxTasks:clear()

	local tasks = DB.getTasksByCountryAndPlane()
	local aircraft = GDData.genParams().aircraft
	local countryId = GDData.genParams().countryId
	
	local unit = DB.unit_by_type[aircraft]

	for _tmp, taskName in base.ipairs(tasks[countryId][aircraft]) do
		local item = ListBoxItem.new(taskName)
		item.taskWorldID = DB.getTaskWorldID(taskName) 
		item.taskOldID = DB.getTaskOldID(taskName) 		
		comboboxTasks:insertItem(item)
		if unit.DefaultTask and unit.DefaultTask.Name == taskName then
			defaultItem = item
		end
	end
	
	if defaultItem then
		comboboxTasks:selectItem(defaultItem)
	else
		comboboxTasks:selectItem(comboboxTasks:getItem(0))
	end
	
	GDData.genParams().taskWorldID = comboboxTasks:getSelectedItem().taskWorldID

	containerCommon.labelAltitude:setVisible(false)
	containerCommon.spinboxAltitude:setVisible(false)
	containerCommon.text_alt:setVisible(false)
	containerCommon.labelDistance:setVisible(false)
	containerCommon.spinboxDistance:setVisible(false)
	containerCommon.text_dist:setVisible(false)
	containerCommon.labelTypeAttack:setVisible(false)
	containerCommon.comboboxTypeAttack:setVisible(false)
	
	-- сборос параметров для задачи не "Intercept"
	containerCommon.spinboxDistance:setValue(0)
	containerCommon.spinboxAltitude:setValue(0)
	U.setComboboxValueById(containerCommon.comboboxTypeAttack, "head-on")
	GDData.genParams().typeAttack = containerCommon.comboboxTypeAttack:getSelectedItem().itemId
	GDData.genParams().playerAltitude = 0
	GDData.genParams().nodeDistance = 0
	
	resetNodesMap(currentTOW)
end

--ƒл€ вызова из вне, чтобы кнопка fly и карта всегда были согласованы с той миссией куда мы полетим
--TODO резетить воврем€
function reset()
	containerPlace.nodesMap:setMissionNode(-1)
	btnFly:setEnabled(false)
	gdWindow.containerMain.containerBriefing.buttonEdit:setEnabled(false)
	fillAutoBriefingWidget("") 
end

-- объявлена ранее
show = function(b, returnScreen)
    if (b == false) and (not gdWindow) then
        return
    end

	if not gdWindow then
		create()
	end

	if b then
        updateUnitSystem()
		updateSizeWidgets()
		showedFrom = returnScreen or showedFrom
		if not (GDData.genParams().theatreOfWar == currentTOW) then
			currentTOW = GDData.genParams().theatreOfWar
			resetNodesMap(GDData.genParams().theatreOfWar)
		end
		GDData.setWidgetValuesFromParams(containerCommon) 
		fillTasksCombobox(containerCommon.comboboxTasks, containerCommon)
		
		Analytics.pageview(Analytics.FastMissionAdvanced)
	end

	gdWindow:setVisible(b)
end

return {
	show = show,
}