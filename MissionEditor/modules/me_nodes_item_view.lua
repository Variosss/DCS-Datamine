local base = _G

module('me_nodes_item_view')

local U 				= base.require('me_utilities')
local CheckListBox 		= base.require('CheckListBox')
local Panel 			= base.require('Panel')
local NodesManager 		= base.require('me_nodes_manager')
local MGModule 			= base.require('me_generator')
local ListView 			= base.require('me_nodes_list_view')
local GDData 			= base.require('me_generator_dialog_data')
local Terrain 			= base.require('terrain')
local CheckListBoxItem  = base.require('CheckListBoxItem')
local DB 				= base.require('me_db_api')
local waitScreen		= base.require('me_wait_screen')

base.require('i18n').setup(_M)

local localData = {}
local battleNodeContainer
local redTemplNames, blueTemplNames

local function getAllowedTemplates(templates, coalition)
    local templatesNames = {}
    for i, templ in base.ipairs(templates) do
        if (templ.coalition == coalition) then
            base.table.insert(templatesNames, templ.name)
        end
    end
    return templatesNames;
end

local function fillTemplNamesWidgets(side)
    local sideTemplNames, namesWidget, templList
    if side == "red" then
        templList = localData.redTemplates
        sideTemplNames = redTemplNames
        namesWidget = battleNodeContainer.redList
    else
        templList = localData.blueTemplates
        sideTemplNames = blueTemplNames
        namesWidget = battleNodeContainer.blueList
    end
 
    U.fillCheckedList(templList, sideTemplNames, namesWidget)
end

local function updateTargetPoint(a_localData)
	local ind = U.find(a_localData.Tasks, "Ground Attack")
	if ind == nil then
		-- удаляем точку с карты и из данных если она есть
		if a_localData.targetPos then
			NodesManager.removeTargetPoint(a_localData.id)
			a_localData.targetPos = nil
		end
		
		ListView.showTargetPointsParams(false)		
	else
		if a_localData.targetPos == nil then
			a_localData.targetPos = {}
			a_localData.targetPos[1] = (a_localData.bluePos[1] + a_localData.redPos[1])/2
			a_localData.targetPos[2] = (a_localData.bluePos[2] + a_localData.redPos[2])/2
			NodesManager.addTargetPoint(a_localData)
		end
		ListView.showTargetPointsParams(true)
	end
end

local function updateTasks()
	battleNodeContainer.cblTasks:clear()
	
	for _tmp, v in base.pairs(DB.db.Units.Planes.Tasks) do
		local newItem = CheckListBoxItem.new(v.Name)	
		newItem.itemId = v.OldID
		local ind = U.find(localData.Tasks, v.OldID)
        newItem:setChecked(ind ~= nil)		
        battleNodeContainer.cblTasks:insertItem(newItem)
    end
	
	updateTargetPoint(localData)
end

local function selectTemplateItem(list, templId)
	local itemCounter = list:getItemCount() - 1
	
    for i = 0, itemCounter do
		local item = list:getItem(i)
		
        if item:getText() == templId then
            list:selectItem(item)
            break
        end
    end
end

local function onTemplateListChange(templates, coalition, item)
	if item:getChecked() then
		base.table.insert(templates, item:getText())
	else
        local ind = U.find(templates, item:getText())
		base.table.remove(templates, ind)
	end
    NodesManager.onItemViewChanged(localData)
end

local function onTasksListChange(tasks, item)
	if item:getChecked() then
		base.table.insert(tasks, item.itemId)
	else
        local ind = U.find(tasks, item.itemId)
		base.table.remove(tasks, ind)
	end
	updateTargetPoint(localData)
	NodesManager.onItemViewChanged(localData)
end

function init(templates)
    battleNodeContainer = ListView.getBattleNodeContainer()
    battleNodeContainer:setVisible(false)
    
    --FIXME: удалить
    -- это из-за неправильной конвертации тем
	local skin_redList = battleNodeContainer.redList:getSkin()
    local x, y, w, h = battleNodeContainer.redList:getBounds()
    battleNodeContainer:removeWidget(battleNodeContainer.redList)
    
    battleNodeContainer.redList = CheckListBox.new()
	battleNodeContainer.redList:setSkin(skin_redList)
    battleNodeContainer.redList:setBounds(x, y, w, h)
    battleNodeContainer:insertWidget(battleNodeContainer.redList)
    
	local skin_blueList = battleNodeContainer.blueList:getSkin()
    local x, y, w, h = battleNodeContainer.blueList:getBounds()
    battleNodeContainer:removeWidget(battleNodeContainer.blueList)
    
	
    battleNodeContainer.blueList = CheckListBox.new()
	battleNodeContainer.blueList:setSkin(skin_blueList)
    battleNodeContainer.blueList:setBounds(x, y, w, h)
    battleNodeContainer:insertWidget(battleNodeContainer.blueList)    
    
    function battleNodeContainer.redList:onItemChange()
		onTemplateListChange(localData.redTemplates, "red", self:getSelectedItem())
    end
    
	function battleNodeContainer.blueList:onItemChange()
        onTemplateListChange(localData.blueTemplates, "blue", self:getSelectedItem())
    end
	
	function battleNodeContainer.cblTasks:onItemChange()
		onTasksListChange(localData.Tasks, self:getSelectedItem())
	end  
	
	function battleNodeContainer.redList:onItemMouseUp()
		NodesManager.onTemplateSelectionChanged(self:getSelectedItem():getText(), "red")
	end
	
	function battleNodeContainer.blueList:onItemMouseUp()
		NodesManager.onTemplateSelectionChanged(self:getSelectedItem():getText(), "blue")
	end   

	function battleNodeContainer.nameBox:onChange()
		local text = battleNodeContainer.nameBox:getText()
        localData.name = text
        NodesManager.onItemViewNameChanged(localData)
    end
    
    function battleNodeContainer.editboxRX:onChange(text)
        localData.redPos[1] = base.tonumber(text) or 0
        NodesManager.onItemViewPosChanged(localData)
    end
    
    function battleNodeContainer.editboxRY:onChange(text)
        localData.redPos[2] = base.tonumber(text) or 0
        NodesManager.onItemViewPosChanged(localData)
    end
    
    function battleNodeContainer.editboxBX:onChange(text)
        localData.bluePos[1] = base.tonumber(text) or 0
        NodesManager.onItemViewPosChanged(localData)
    end
    
    function battleNodeContainer.editboxBY:onChange(text)
        localData.bluePos[2] = base.tonumber(text) or 0
        NodesManager.onItemViewPosChanged(localData)
    end
	
	function battleNodeContainer.eTargetX:onChange(text)
        localData.targetPos[1] = base.tonumber(battleNodeContainer.eTargetX:getText()) or 0
        NodesManager.onItemViewPosChanged(localData)
    end
    
    function battleNodeContainer.eTargetY:onChange(text)
        localData.targetPos[2] = base.tonumber(battleNodeContainer.eTargetY:getText()) or 0
        NodesManager.onItemViewPosChanged(localData)
    end

    function battleNodeContainer.buttonGenerate:onChange()
		waitScreen.showSplash(true, _("Generated:").."0%", true)
        local redTemplItem = battleNodeContainer.redList:getSelectedItem()
        local redTemplId = nil
        if redTemplItem ~= nil and redTemplItem:getChecked() then redTemplId = redTemplItem:getText() end
        
        local blueTemplItem = battleNodeContainer.blueList:getSelectedItem()
        local blueTemplId = nil
        if blueTemplItem ~= nil and blueTemplItem:getChecked() then blueTemplId = blueTemplItem:getText() end
        
        MGModule.generate(GDData.genParams(), true, Terrain.GetTerrainConfig('id'), {localData.id}, redTemplId, blueTemplId, endGenerate)			
    end
    
    redTemplNames = getAllowedTemplates(templates, "red")
    blueTemplNames = getAllowedTemplates(templates, "blue")
	
	fillTasks()
end


function endGenerate(returnCode, nodeId, error)
	local enmGenStart, enmGenFinish, enmPercent = 0, 1, 2
	if returnCode == enmGenFinish then
		base.MapWindow.show(true)
		waitScreen.showSplash(false)
	elseif returnCode == enmPercent then
		waitScreen.setText(_("Generated:")..base.tostring(base.math.floor(nodeId or 0))..'% - '..error)
	end
end

function fillTasks()
	battleNodeContainer.cblTasks:clear()
	
	for _tmp, v in base.pairs(DB.db.Units.Planes.Tasks) do
		local newItem = CheckListBoxItem.new(v.Name)	
		newItem.itemId = v.OldID		
        battleNodeContainer.cblTasks:insertItem(newItem)
    end
end

function selectTemplate(coalition, templId)
    if not templId then return end
    
    local listWidget
    if coalition == "red" then
        listWidget = battleNodeContainer.redList
    else
        listWidget = battleNodeContainer.blueList
    end
    
    selectTemplateItem(listWidget, templId)
end

function updatePositions(node)
    if localData.id == node.id and localData ~= node then
		U.recursiveCopyTable(localData, node)
	end
    
    battleNodeContainer.editboxRX:setText(localData.redPos[1])
    battleNodeContainer.editboxRY:setText(localData.redPos[2])
    battleNodeContainer.editboxBX:setText(localData.bluePos[1])
    battleNodeContainer.editboxBY:setText(localData.bluePos[2])
	if localData.targetPos then
		battleNodeContainer.eTargetX:setText(localData.targetPos[1])
		battleNodeContainer.eTargetY:setText(localData.targetPos[2])
	end
end

function update(node)
	if node ~= nil then
        localData = {}
        U.recursiveCopyTable(localData, node)
    end
    battleNodeContainer.nameBox:setText(localData.name)
    battleNodeContainer.editboxRX:setText(localData.redPos[1])
    battleNodeContainer.editboxRY:setText(localData.redPos[2])
    battleNodeContainer.editboxBX:setText(localData.bluePos[1])
    battleNodeContainer.editboxBY:setText(localData.bluePos[2])
	if localData.targetPos then
		battleNodeContainer.eTargetX:setText(localData.targetPos[1])
		battleNodeContainer.eTargetY:setText(localData.targetPos[2])
	end
    
    fillTemplNamesWidgets("red")
    fillTemplNamesWidgets("blue")
	
	localData.Tasks = localData.Tasks or {}
	
	updateTasks()
end

function show(b)
    battleNodeContainer:setVisible(b)
end

function uptatePossibleTemplates(templates)
    redTemplNames = getAllowedTemplates(templates, "red")
    blueTemplNames = getAllowedTemplates(templates, "blue")
end