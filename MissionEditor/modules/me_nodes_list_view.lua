local base = _G

module('me_nodes_list_view')

local U = base.require('me_utilities')
local Loader = base.require('DialogLoader')
local ListBox = base.require('ListBox')
local ListBoxItem = base.require('ListBoxItem')
local Panel = base.require('Panel')
local NodesManager = base.require('me_nodes_manager')
local Window = base.require('Window')
local Gui = base.require('dxgui')

base.require('i18n').setup(_M)

local selectedNode
local nodeListWindow

cdata = {
missionNodes = _("MISSION NODES"),
nodeList = _("NODE LIST"),
rem = _("REMOVE"),
add = _("ADD"),
name = _("NAME"),
posRed = _("RED"),
posBlue = _("BLUE"),
redTemplates = _("RED TEMPLATES"),
blueTemplates = _("BLUE TEMPLATES"),
x = _("X"),
y = _("Y"),
generate = _("GENERATE"),
Tasks = _("TASKS"),
Target = _("Target"),
posTarget  = _("Target point"),
}

function init(x, y, w, h)
    nodeListWindow = Loader.spawnDialogFromFile('MissionEditor/modules/dialogs/me_nodes.dlg', cdata)
    
    local pw, ph = nodeListWindow:getSize()
	local contX, contY = nodeListWindow.container:getPosition()

	local main_w, main_h = Gui.GetWindowSize()

    nodeListWindow:setBounds(w - pw, y, pw, main_h-U.top_toolbar_h-U.bottom_toolbar_h)
	nodeListWindow.container:setSize(pw-5, main_h-U.top_toolbar_h-U.bottom_toolbar_h - contY-30-10)
    
    function nodeListWindow:onClose()
        NodesManager.show(false)
    end
    
    function nodeListWindow.buttonRemove:onChange()
        if (selectedNode == nil) then return end
        local id = selectedNode.id
        nodeListWindow.nodesList:removeItem(selectedNode)
        selectedNode = nil
        
        NodesManager.onListViewRemove(id)
    end

    function nodeListWindow.buttonAdd:onChange()
        NodesManager.onListViewAdd()
    end
    
    function nodeListWindow.nodesList:onChange(item, dblClick)
        selectedNode = item;
        NodesManager.onListViewSelectionChanged(item.id, dblClick)
	end
end

function showTargetPointsParams(b)
	nodeListWindow.container.targetLabel:setVisible(b)
	nodeListWindow.container.posTargetLabel:setVisible(b)
	nodeListWindow.container.xTLabel:setVisible(b)
	nodeListWindow.container.eTargetX:setVisible(b)
	nodeListWindow.container.yTLabel:setVisible(b)
	nodeListWindow.container.eTargetY:setVisible(b)
	
	nodeListWindow.container:updateWidgetsBounds() 
end		

function selectItem(id)
	local nodesList = nodeListWindow.nodesList
	
    if id == nil then 
        nodesList:selectItem(nil) 
        selectedNode = nil
    end
    
    local itemCounter = nodesList:getItemCount() - 1
	
    for i = 0, itemCounter do
		local item = nodesList:getItem(i)
		
        if item.id == id then 
            nodesList:selectItem(item)
            selectedNode = item
            return
        end
    end
end

function addItem(node)
    local newItem = ListBoxItem.new(node.name)
    newItem.id = node.id
    nodeListWindow.nodesList:insertItem(newItem)
    nodeListWindow.nodesList:selectItem(newItem)
    selectedNode = newItem
end

function show(b)
    nodeListWindow:setVisible(b)
end

function isVisible()
    return nodeListWindow:isVisible()
end

function fillList(nodes)
    nodeListWindow.nodesList:clear()
    for i, node in base.ipairs(nodes) do
        local newItem = ListBoxItem.new(node.name)
        newItem.id = node.id
        nodeListWindow.nodesList:insertItem(newItem, i)			
    end
end

function updateItemName(id, newName)
    --TODO при сегодн€шней реализации работает
    --но лучше переделать - поиск элемента по id и setText найденному элементу
    if selectedNode ~= nil then 
        selectedNode:setText(newName)
    end
end

function getBattleNodeContainer()
    return nodeListWindow.container
end