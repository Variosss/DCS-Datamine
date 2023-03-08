local base = _G

module('me_templates_manager')

local S = base.require('Serializer')
local T = base.require('tools')
local U = base.require('me_utilities')
local Loader = base.require('DialogLoader')
local ListBox = base.require('ListBox')
local CheckListBox = base.require('CheckListBox')
local ListBoxItem = base.require('ListBoxItem')
local ComboBox = base.require('ComboBox')
local Panel = base.require('Panel')
local NodesMapView = base.require('me_nodes_map_view')
local NodesManager = base.require('me_nodes_manager')
local Toolbar = base.require('me_toolbar')
local GDData = base.require('me_generator_dialog_data')
local ConfigHelper = base.require('ConfigHelper')
local CoalitionController = base.require('Mission.CoalitionController')
local CoalitionUtils = base.require('Mission.CoalitionUtils')

base.require('i18n').setup(_M)
cdata = {
templatesEditor = _("TEMPLATE EDITOR"),
templates = _("TEMPLATES"),
add = _("ADD"),
rem = _("REMOVE"),
companies = _("COMPANIES"),
companyType = _("COMPANY TYPE"),
posMin = _("POS MIN"),
posMax = _("POS MAX"),
name = _("NAME"),
behavior = _("BEHAVIOR"),
isTarget = _("IS TARGET"),
isFromRunway = _("IS FROM RUNWAY"),
startPosition = _("START POSITION"),
platoons = _("PLATOONS"),
platoon = _("PLATOON"),
coalition = _("COALITION"),
companyStructure = _("COMPANY STRUCTURE"),
amount = _("AMOUNT"),
copy = _("COPY"),
playerZone = _("PLAYER ZONE"),
}

local sysTemplatesFilePath = "MissionEditor/data/MissionGenerator/GeneratorData/combattemplates.lua"
--local sysTemplatesFilePath = "MissionEditor/data/MissionGenerator/GeneratorData/combattemplates_v2.lua"
local templatesFileName = 'combattemplates'
local fixedDataPath 	= "MissionEditor/data/MissionGenerator/GeneratorData/others.lua"

local combatTemplates
local startPosNames, groundBehaviours, airBehaviours, amountLevels, companyTypes
local allGroups

local selectedTemplateItem
local selectedCompanyItem
local selectedCompanyStructItem

local templatesWindow
local templateContainer
local companyContainer
local platoonsContainer

local function isGroundCompany(compType)
    return compType == "Vehicles" or compType == "AAA" or compType == "SAM"
end

local function getNewGroundCompany(compType)
    return {name = "New"..compType.."Company", 
        pMin = {-1000, -1000}, 
        pMax = {0, 1000}, 
        combatCompany = {}, 
        behaviour = "gStay",
        isTarget = true,
        companyType = compType,
        startPositions = {"Column"}}
end

local function getNewAirCompany(compType)
    return {name = "New"..compType.."Company",
        pMin = {-1000, -1000},
        pMax = {0, 1000},
        combatCompany = {}, 
        companyType = compType,
        behaviour = "aAttackGround",
        isStartFromRunway = false}
end

local function getNewTempl()
    local defCompanies = {}
    for i,v in base.ipairs(companyTypes) do
        if isGroundCompany(v.id) then
            base.table.insert(defCompanies, getNewGroundCompany(v.id))
        else
            base.table.insert(defCompanies, getNewAirCompany(v.id))
        end
    end
    
    return {name = "NewTemplate", coalition = "red", companies = defCompanies, playerZone = { pMin = {-1000, -1000}, pMax = {0, 1000}}}
end

local function getNewCompany()
    return {amount = "Min", company = {}}
end

local function getNameListItem(data)
    local newItem = ListBoxItem.new(data.name)
    newItem.data = data
    return newItem
end

local function getCompanyListItem(comp)
    local newItem = ListBoxItem.new(comp.companyType..": "..comp.name)
    newItem.data = comp
    return newItem
end

local function addToNameList(data, dataTable, listWidget, itemCreator)
    if not itemCreator then itemCreator = getNameListItem end
    
    base.table.insert(dataTable, data)  
    local newItem = itemCreator(data)
    
    listWidget:insertItem(newItem)
    listWidget:onChange(newItem, false)
    listWidget:selectItem(newItem)
end

local function removeSelectedFromNameList(selectedItem, dataTable, listWidget)
    listWidget:removeItem(selectedItem)
    local ind = U.find(dataTable, selectedItem.data)
    base.table.remove(dataTable, ind)
end

local function findInNameList(data, listWidget)
    if not data then 
		return nil 
	end
	
    local itemCounter = listWidget:getItemCount() - 1
	
    for i = 0, itemCounter do
		local item = listWidget:getItem(i)
		
        if item.data == data then 
			return item
		end
    end
	
    return nil
end

local function nameValuesCompare(v1, v2)
    return v1.name < v2.name
end

function initData()
  local fTempl = T.safeDoFile(ConfigHelper.getConfigReadPath('combattemplates.lua'))
  --local fTempl = T.safeDoFile(ConfigHelper.getConfigReadPath('combattemplates_v2.lua'))
  combatTemplates = (fTempl and fTempl.combatTemplates) or {}
  
  local fFixedData = T.safeDoFileWithRequire(fixedDataPath)
  groundBehaviours = (fFixedData and fFixedData.groundBehaviours) or {}
  airBehaviours = (fFixedData and fFixedData.airBehaviours) or {}
  amountLevels = (fFixedData and fFixedData.amountLevels) or {}
  companyTypes = (fFixedData and fFixedData.companyTypes) or {}
  
  local platoons = (fFixedData and fFixedData.platoons) or {}
  allGroups = {}
  for i, platoon in base.ipairs(platoons) do
    if allGroups[platoon.companyType] == nil then
        allGroups[platoon.companyType] = {}
    end
    base.table.insert(allGroups[platoon.companyType], platoon)
  end
  for compType, plats in base.pairs(allGroups) do
    base.table.sort(plats, nameValuesCompare)
  end
  
  local startPositions = (fFixedData and fFixedData.startPositions) or {}
  startPosNames = {}
  for name, value in base.pairs(startPositions) do
    base.table.insert(startPosNames, name)
  end
  
end

function isChanged()
  local fTempl = T.safeDoFile(ConfigHelper.getConfigReadPath('combattemplates.lua'))
  --local fTempl = T.safeDoFile(ConfigHelper.getConfigReadPath('combattemplates_v2.lua'))
  templatesFromFile = (fTempl and fTempl.combatTemplates) or {}
  return not U.compareTables(templatesFromFile, combatTemplates)
end

local function updateVisibleTemplate(templ)
    if NodesManager.currentNode() then
        NodesMapView.setTemplate(NodesManager.currentNode(), templ)
    end
end

function templates()
    return combatTemplates
end

function show(b)
    if b then 
		Toolbar.untoggle_all_except() 
	end
    
    NodesMapView.show(b)
    templatesWindow:setVisible(b)
end

local function fillNameList(dataList, listbox, itemCreator)
    listbox:clear()
    if not itemCreator then itemCreator = getNameListItem end
    for i, v in base.ipairs(dataList) do
        local newItem = itemCreator(v)
        listbox:insertItem(newItem, i)
    end
end

local function fillNameCombo(combobox, dataList)
    combobox:clear()
    for i, v in base.ipairs(dataList) do
      local item = ListBoxItem.new(v.name)
      
      item.data = v
      combobox:insertItem(item)
      
      if 1 == i then
        combobox:selectItem(item)
      end
    end
end

local function updateTemplate(templ)
    templateContainer.editboxTemplateName:setText(templ.name)
	CoalitionUtils.setComboListCoalition(templateContainer.comboboxTemplateCoalition, templ.coalition)
    fillNameList(templ.companies, templateContainer.listboxCompanies, getCompanyListItem)
    templateContainer.editboxPlayerMinX:setText(templ.playerZone.pMin[1])
    templateContainer.editboxPlayerMinY:setText(templ.playerZone.pMin[2])
    templateContainer.editboxPlayerMaxX:setText(templ.playerZone.pMax[1])
    templateContainer.editboxPlayerMaxY:setText(templ.playerZone.pMax[2])
end

local function updateCompanyListItem(item, data)
    item.data = data
    
    local platoonsCount = {}
    for i, plat in base.ipairs(data.company) do
        local count = platoonsCount[plat]
        platoonsCount[plat] = (count or 0) + 1
    end
    
    local text = data.amount..": "
    local textEmpty = true
    for platName, platCount in base.pairs(platoonsCount) do
        text = text..base.tostring(platCount).."x"..platName.." and "
        textEmpty = false
    end
    
    if not textEmpty then text = base.string.sub(text,1, -6) end
    item:setText(text)
    return item
end

local function fillCompanyList(company)
    local listbox = companyContainer.listboxCompanyStructure
    listbox:clear()
    for i, comp in base.ipairs(company) do
        local newItem = ListBoxItem.new()
        updateCompanyListItem(newItem, comp)
    
        listbox:insertItem(newItem, i)
    end
end

local function updateCompanyPart(comp)
    companyContainer.editboxName:setText(comp.name)
    companyContainer.editboxMinX:setText(comp.pMin[1])
    companyContainer.editboxMinY:setText(comp.pMin[2])
    companyContainer.editboxMaxX:setText(comp.pMax[1])
    companyContainer.editboxMaxX:setText(comp.pMax[1])
    companyContainer.editboxMaxY:setText(comp.pMax[2])
    fillCompanyList(comp.combatCompany)
 
    local groundComp = isGroundCompany(comp.companyType)
    companyContainer.checkboxIsTarget:setEnabled(groundComp)
    companyContainer.listboxStartPositions:setEnabled(groundComp)
    companyContainer.checkboxIsFromRunway:setEnabled(not groundComp)
	U.setComboboxValueById(companyContainer.comboboxCompType, comp.companyType)
    fillNameCombo(platoonsContainer.comboboxPlatoon, allGroups[comp.companyType])
    
	companyContainer.comboboxBehavior:clear() 
    if  groundComp then
	    U.fillComboBoxFromTable(companyContainer.comboboxBehavior, groundBehaviours, "name", "id")
        companyContainer.checkboxIsTarget:setState(comp.isTarget)
        companyContainer.checkboxIsFromRunway:setState(false)
        U.fillCheckedListId(comp.startPositions, startPosNames, companyContainer.listboxStartPositions)
    else
	    U.fillComboBoxFromTable(companyContainer.comboboxBehavior, airBehaviours, "name", "id")
        companyContainer.checkboxIsTarget:setState(false)
        companyContainer.checkboxIsFromRunway:setState(comp.isStartFromRunway)
        companyContainer.listboxStartPositions:clear()    
    end
	U.setComboboxValueById(companyContainer.comboboxBehavior, comp.behaviour)
end

local function updateCompany(data)
	U.setComboboxValueById(platoonsContainer.comboboxAmount, data.amount)
    
    platoonsContainer.listboxPlatoons:clear()
    for i,platoon in base.ipairs(data.company) do
        local newItem = ListBoxItem.new(platoon)
        platoonsContainer.listboxPlatoons:insertItem(newItem, i)	
    end
end

local function initTemplateContainer()
	local coalitionNames = {
		CoalitionController.blueCoalitionName(),
		CoalitionController.redCoalitionName(),
	}
	
	CoalitionUtils.fillComboListCoalition(templateContainer.comboboxTemplateCoalition, coalitionNames, function(coalitionName)
        selectedTemplateItem.data.coalition = coalitionName
        NodesMapView.removeTemplates()
        updateVisibleTemplate(selectedTemplateItem.data)
        NodesManager.onTemplatesChanged()
	end)
    
    --function templateContainer.editboxTemplateName:onChange(text)
	function templateContainer.editboxTemplateName:onChange()
		local text = templateContainer.editboxTemplateName:getText()
        selectedTemplateItem:setText(text)
        selectedTemplateItem.data.name = text
        NodesManager.onTemplatesChanged()
    end
    
    function templateContainer.buttonCompanyAdd:onChange()
        addToNameList(getNewGroundCompany("Vehicles"), selectedTemplateItem.data.companies, templateContainer.listboxCompanies, getCompanyListItem)
        updateVisibleTemplate(selectedTemplateItem.data)
    end

    function templateContainer.buttonCompanyCopy:onChange()
        if not selectedCompanyItem then return end
        local dataCopy = {}
        U.copyTable (dataCopy, selectedCompanyItem.data)
        addToNameList(dataCopy, selectedTemplateItem.data.companies, templateContainer.listboxCompanies, getCompanyListItem)
        updateVisibleTemplate(selectedTemplateItem.data)
    end
    
    function templateContainer.buttonCompanyRemove:onChange()
        if not selectedCompanyItem then return end
        removeSelectedFromNameList(selectedCompanyItem, selectedTemplateItem.data.companies, templateContainer.listboxCompanies)
        selectedCompanyItem = nil
        companyContainer:setVisible(false)
        platoonsContainer:setVisible(false)
        updateVisibleTemplate(selectedTemplateItem.data)
    end
    
    function templateContainer.editboxPlayerMinX:onChange(text)
        selectedTemplateItem.data.playerZone.pMin[1] = base.tonumber(text) or 0
        updateVisibleTemplate(selectedTemplateItem.data)
    end
    
    function templateContainer.editboxPlayerMinY:onChange(text)
        selectedTemplateItem.data.playerZone.pMin[2] = base.tonumber(text) or 0
        updateVisibleTemplate(selectedTemplateItem.data)
    end
    
    function templateContainer.editboxPlayerMaxX:onChange(text)
        selectedTemplateItem.data.playerZone.pMax[1] = base.tonumber(text) or 0
        updateVisibleTemplate(selectedTemplateItem.data)
    end
    
    function templateContainer.editboxPlayerMaxY:onChange(text)
        selectedTemplateItem.data.playerZone.pMax[2] = base.tonumber(text) or 0
        updateVisibleTemplate(selectedTemplateItem.data)
    end
    
    function templateContainer.listboxCompanies:onChange(item, dblClick)
		selectedCompanyItem = item
        updateCompanyPart(item.data)
        companyContainer:setVisible(true)
        platoonsContainer:setVisible(false)
	end
end

local function resetCompany(comp, compType)
    comp.combatCompany = {}
    comp.companyType = compType
    
    if isGroundCompany(compType) then
        comp.behaviour = "gStay"
        comp.isTarget = false
        comp.startPositions = {"Column"}
        comp.isStartFromRunway = nil
    else
        comp.isTarget = nil
        comp.startPositions = nil
        comp.behaviour = "aAttackGround"
        comp.isStartFromRunway = false
    end
end

local function initCompaniesContainer()
    U.fillComboBoxFromTable(companyContainer.comboboxCompType, companyTypes, "name", "id")
    
    --function companyContainer.editboxName:onChange(text)
	function companyContainer.editboxName:onChange()
		local text = companyContainer.editboxName:getText()
        selectedCompanyItem.data.name = text
        selectedCompanyItem:setText(selectedCompanyItem.data.companyType..": "..text)
        updateVisibleTemplate(selectedTemplateItem.data)
    end
    
    function companyContainer.editboxMinX:onChange(text)
        selectedCompanyItem.data.pMin[1] = base.tonumber(text) or 0
        updateVisibleTemplate(selectedTemplateItem.data)
    end
    
    function companyContainer.editboxMinY:onChange(text)
        selectedCompanyItem.data.pMin[2] = base.tonumber(text) or 0
        updateVisibleTemplate(selectedTemplateItem.data)
    end
    
    function companyContainer.editboxMaxX:onChange(text)
        selectedCompanyItem.data.pMax[1] = base.tonumber(text) or 0
        updateVisibleTemplate(selectedTemplateItem.data)
    end
    
    function companyContainer.editboxMaxY:onChange(text)
        selectedCompanyItem.data.pMax[2] = base.tonumber(text) or 0
        updateVisibleTemplate(selectedTemplateItem.data)
    end
    
    function companyContainer.comboboxCompType:onChange(item)
        resetCompany(selectedCompanyItem.data, item.itemId)
        updateCompanyPart(selectedCompanyItem.data)
        selectedCompanyItem:setText(selectedCompanyItem.data.companyType..": "..selectedCompanyItem.data.name)
        platoonsContainer:setVisible(false)
    end
    
    function companyContainer.comboboxBehavior:onChange(item)
		local isTarget = false
		if (item.itemId == 'gStay' or item.itemId == 'gJTAC' ) then
			isTarget = true
		end
		companyContainer.checkboxIsTarget:setState(isTarget)
        selectedCompanyItem.data.isTarget = isTarget
        selectedCompanyItem.data.behaviour = item.itemId
    end
    
    function companyContainer.checkboxIsTarget:onChange()
        selectedCompanyItem.data.isTarget = companyContainer.checkboxIsTarget:getState()
    end
    
    function companyContainer.checkboxIsFromRunway:onChange()
        selectedCompanyItem.data.isStartFromRunway = companyContainer.checkboxIsFromRunway:getState()
    end
    
    function companyContainer.listboxStartPositions:onItemChange()
		local item = self:getSelectedItem()
		if item then
			if item:getChecked() then
				base.table.insert(selectedCompanyItem.data.startPositions, item.itemId)
			else
				local ind = U.find(selectedCompanyItem.data.startPositions, item.itemId)
				base.table.remove(selectedCompanyItem.data.startPositions, ind)
			end    
		end
    end
    
    function companyContainer.listboxCompanyStructure:onChange(item, dblClick)
        selectedCompanyStructItem = item
        updateCompany(item.data)
        platoonsContainer:setVisible(true)
	end
    
    function companyContainer.buttonCompStructAdd:onChange()
        local newCompany = getNewCompany()
        base.table.insert(selectedCompanyItem.data.combatCompany, newCompany)

        local newItem = ListBoxItem.new()
        updateCompanyListItem(newItem, newCompany)
        companyContainer.listboxCompanyStructure:insertItem(newItem)
        companyContainer.listboxCompanyStructure:selectItem(newItem)
        companyContainer.listboxCompanyStructure:onChange(newItem, false)
	end
    
    function companyContainer.buttonCompStructCopy:onChange()
        if not selectedCompanyStructItem then return end
        local newCompany = {}
        U.copyTable (newCompany, selectedCompanyStructItem.data)  
        base.table.insert(selectedCompanyItem.data.combatCompany, newCompany)

        local newItem = ListBoxItem.new()
        updateCompanyListItem(newItem, newCompany)
        companyContainer.listboxCompanyStructure:insertItem(newItem)
        companyContainer.listboxCompanyStructure:selectItem(newItem)
        companyContainer.listboxCompanyStructure:onChange(newItem, false)
	end
    
    function companyContainer.buttonCompStructRemove:onChange()
        if not selectedCompanyStructItem then return end
        
        removeSelectedFromNameList(selectedCompanyStructItem, selectedCompanyItem.data.combatCompany, companyContainer.listboxCompanyStructure)
        selectedCompanyStructItem = nil
        platoonsContainer:setVisible(false)
    end
end

local function initPlatoonsContainer()
    U.fillComboBoxFromTable(platoonsContainer.comboboxAmount, amountLevels, "name", "id")
    
    function platoonsContainer.comboboxAmount:onChange(item)
        selectedCompanyStructItem.data.amount = item.itemId
        updateCompanyListItem(selectedCompanyStructItem, selectedCompanyStructItem.data)
    end
    
    function platoonsContainer.listboxPlatoons:onChange(item, dblClick)
        platoonsContainer.comboboxPlatoon:setText(item:getText())
    end
    
    function platoonsContainer.buttonPlatoonsAdd:onChange()
        local newCompany = platoonsContainer.comboboxPlatoon:getText()
        if newCompany == "" then return end
        
        local newCompanyItem = ListBoxItem.new(newCompany)
        platoonsContainer.listboxPlatoons:insertItem(newCompanyItem)
        platoonsContainer.listboxPlatoons:selectItem(newCompanyItem)
        
        base.table.insert(selectedCompanyStructItem.data.company, newCompany)
        updateCompanyListItem(selectedCompanyStructItem, selectedCompanyStructItem.data)
    end
    
    function platoonsContainer.buttonPlatoonsRemove:onChange()
        local selectedPlatoonItem = platoonsContainer.listboxPlatoons:getSelectedItem()
        if not selectedPlatoonItem then return end

        local ind = U.find(selectedCompanyStructItem.data.company, selectedPlatoonItem:getText())
        base.table.remove(selectedCompanyStructItem.data.company, ind)

        platoonsContainer.listboxPlatoons:removeItem(selectedPlatoonItem)        
        updateCompanyListItem(selectedCompanyStructItem, selectedCompanyStructItem.data)
    end
    
    function platoonsContainer.comboboxPlatoon:onChange(item)
        local selectedPlatoonItem = platoonsContainer.listboxPlatoons:getSelectedItem()
        if not selectedPlatoonItem then return end
       
        selectedPlatoonItem:setText(platoonsContainer.comboboxPlatoon:getText())
        local ind = U.find(selectedCompanyStructItem.data.company, selectedPlatoonItem:getText())
        base.table.remove(selectedCompanyStructItem.data.company, ind)
        base.table.insert(selectedCompanyStructItem.data.company, platoonsContainer.comboboxPlatoon:getText())
        updateCompanyListItem(selectedCompanyStructItem, selectedCompanyStructItem.data)
    end
end

function init(x, y, w, h)
    templatesWindow = Loader.spawnDialogFromFile("MissionEditor/modules/dialogs/me_gen_templates.dlg", cdata)

    local pw, ph = templatesWindow:getSize()
    
    templatesWindow:setBounds(w - pw, y, pw, h)
    
    templateContainer = templatesWindow.containerTemplate
    companyContainer = templatesWindow.containerCompany
    platoonsContainer = templatesWindow.containerPlatoons
    
    templateContainer:setVisible(false)
    companyContainer:setVisible(false)
    platoonsContainer:setVisible(false)

    initTemplateContainer()
    initCompaniesContainer()
    initPlatoonsContainer()
    
    function templatesWindow:onClose()
        show(false)
    end
    
    function templatesWindow.listboxTemplates:onChange(item, dblClick)
		selectedTemplateItem = item
        updateTemplate(item.data)
        updateVisibleTemplate(selectedTemplateItem.data)
        templateContainer:setVisible(true)
        companyContainer:setVisible(false)
        platoonsContainer:setVisible(false)
	end
    
    function templatesWindow.buttonTemplatesAdd:onChange()
        addToNameList(getNewTempl(), combatTemplates, templatesWindow.listboxTemplates)
        NodesManager.onTemplatesChanged()
    end
    
    function templatesWindow.buttonTemplatesCopy:onChange()
        if not selectedTemplateItem then return end
        local dataCopy = {}
        U.copyTable (dataCopy, selectedTemplateItem.data)
        addToNameList(dataCopy, combatTemplates, templatesWindow.listboxTemplates)
        NodesManager.onTemplatesChanged()
    end
    
    function templatesWindow.buttonTemplatesRemove:onChange()
        if not selectedTemplateItem then return end
        
        removeSelectedFromNameList(selectedTemplateItem, combatTemplates, templatesWindow.listboxTemplates)
        selectedTemplateItem = nil
        templateContainer:setVisible(false)
        companyContainer:setVisible(false)
        platoonsContainer:setVisible(false)
        NodesManager.onTemplatesChanged()
    end
    
    fillNameList(combatTemplates, templatesWindow.listboxTemplates)
end

function saveTamplates()
	U.saveUserData(ConfigHelper.getConfigWritePath('combattemplates.lua'), {combatTemplates = combatTemplates})
	--U.saveUserData(ConfigHelper.getConfigWritePath('combattemplates_v2.lua'), {combatTemplates = combatTemplates})
end

function onMapViewSelectionChanged(templ, company, companyType)
	local listboxTemplates = templatesWindow.listboxTemplates
	
    selectedTemplateItem = findInNameList(templ, listboxTemplates)
    listboxTemplates:selectItem(selectedTemplateItem)
	listboxTemplates:setItemVisible(selectedTemplateItem)
	
    if not selectedTemplateItem then
        templateContainer:setVisible(false)
        companyContainer:setVisible(false)
        platoonsContainer:setVisible(false)
        return
    end
    updateTemplate(templ)
    templateContainer:setVisible(true)
    
    if companyType == "playerZone" then return end
    
    selectedCompanyItem = findInNameList(company, templateContainer.listboxCompanies)
    templateContainer.listboxCompanies:selectItem(selectedCompanyItem)
    templateContainer.listboxCompanies:selectItem(nil) 
    
    if not selectedCompanyItem then
        companyContainer:setVisible(false)
        platoonsContainer:setVisible(false)
        return
    end
    
    updateCompanyPart(company)
    companyContainer:setVisible(true)
    platoonsContainer:setVisible(false)
end

function onMapViewPosChanged(templ, company, companyType, pMin, pMax)
    if companyType == "playerZone" and selectedTemplateItem~= nil then
        templ.playerZone.pMin = pMin
        templ.playerZone.pMax = pMax
        templateContainer.editboxPlayerMinX:setText(pMin[1])
        templateContainer.editboxPlayerMinY:setText(pMin[2])
        templateContainer.editboxPlayerMaxX:setText(pMax[1])
        templateContainer.editboxPlayerMaxY:setText(pMax[2])
        return
    end
    
    if selectedTemplateItem and selectedCompanyItem and selectedTemplateItem.data == templ and selectedCompanyItem.data == company then
        company.pMin = pMin
        company.pMax = pMax
        
        companyContainer.editboxMinX:setText(pMin[1])
        companyContainer.editboxMinY:setText(pMin[2])
        companyContainer.editboxMaxX:setText(pMax[1])
        companyContainer.editboxMaxY:setText(pMax[2])
    end
end