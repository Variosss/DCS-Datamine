local base = _G

module('me_nodes_manager')

local require = base.require
local ipairs = base.ipairs
local pairs = base.pairs
local table = base.table

local U = require('me_utilities')
local T = require('tools')
local S = require('Serializer')
local ItemView = require('me_nodes_item_view')
local ListView = require('me_nodes_list_view')
local NodesMapView = require('me_nodes_map_view')
local MapWindow = require('me_map_window')
local Toolbar = require('me_toolbar')
local TemplatesManager = require('me_templates_manager')
local GDData = require('me_generator_dialog_data')
local ConfigHelper = require('ConfigHelper')
local TheatreOfWarData	= require('Mission.TheatreOfWarData')

require('i18n').setup(_M)

local nodesByTOW
local currentTOWId
local isInitialized = false
local selectedNode
local lvX, lvY, lvW, lvH
local lastNodeId = 0
local selectionHisrory = {}

local nodesFileVersion = 1
local function getUserNodesFileName(theatreOfWar)
	return 'nodes' .. theatreOfWar.name .. '.lua'
end

local function getNewNode()
    lastNodeId = lastNodeId + 1
    local pos = NodesMapView.cameraPos()
    return {redPos = {pos[1], pos[2] - 100}, bluePos = {pos[1], pos[2] + 100}, redTemplates = {}, blueTemplates = {}, Tasks = {}, name = "NewNode", id = lastNodeId}
end

local function getNewSelection()
    return {red = nil, blue = nil}
end

local function updateSelectedTemplates(node)
    local selection = selectionHisrory[node.id]
    if selection then
        NodesMapView.setTemplate(node, selection.red)
        NodesMapView.setTemplate(node, selection.blue)
        
        if selection.red then
            ItemView.selectTemplate("red", selection.red.name)
        end
        
        if selection.blue then
            ItemView.selectTemplate("blue", selection.blue.name)
        end
    end
end

local function clone(trg, src)
    trg.redPos = src.redPos
    trg.bluePos = src.bluePos
	trg.targetPos = src.targetPos
    trg.name = src.name
    trg.id = src.id
    trg.redTemplates = {}	
    U.copyTable(trg.redTemplates, src.redTemplates)
    trg.blueTemplates = {}
    U.copyTable(trg.blueTemplates, src.blueTemplates)
	trg.Tasks = {}
	U.copyTable(trg.Tasks, src.Tasks)
end

function initNodes()
  nodesByTOW = {}
  
  for i, theatreOfWar in ipairs(TheatreOfWarData.getTheatresOfWar()) do
	local f = T.safeDoFile(ConfigHelper.chooseFilePath(base.userDataDir, getUserNodesFileName(theatreOfWar), nodesFileVersion, theatreOfWar.nodesFile),false)
	
	local towNodes = (f and f.missionNodes) or {}
	nodesByTOW[theatreOfWar.name] = towNodes
  end
end

function resetViewsData(towId)
    if not isInitialized or currentTOWId == towId then return end
	
	local towNodes = nodes(towId)
	
    ItemView.show(false)
    ListView.fillList(towNodes)
    ListView.selectItem(nil)
    NodesMapView.init(towNodes)
	currentTOWId = towId
end

function onReloadTerrain(towId)
	local towNodes = nodes(towId)
	selectionHisrory = {}
	for i,v in ipairs(towNodes) do
		selectionHisrory[v.id] = getNewSelection()
	end
	lastNodeId  = (#towNodes > 0 and towNodes[#towNodes].id) or 0
	
	resetViewsData(towId)
end

function removeTargetPoint(id)
    NodesMapView.removeTargetPoint(id)
end

function addTargetPoint(node)
    NodesMapView.addTargetPoint(node)
end

local function findByProp(nodes, propValue, prop)
    for i, v in ipairs(nodes) do
        if v[prop] == propValue then return i end
    end
    return nil
end

function isChanged()
  if not nodesByTOW then 
    return false 
  end
  
  for i, theatreOfWar in ipairs(TheatreOfWarData.getTheatresOfWar()) do
	local f = T.safeDoFile(ConfigHelper.chooseFilePath(base.userDataDir, getUserNodesFileName(theatreOfWar), nodesFileVersion, theatreOfWar.nodesFile))
	local nodesFromFile = (f and f.missionNodes) or {}
	
	if not U.compareTables(nodesFromFile, nodesByTOW[theatreOfWar.name]) then
		return true 
	end
  end
  
  return false
end

function saveNodes()
	for i, theatreOfWar in ipairs(TheatreOfWarData.getTheatresOfWar()) do
		U.saveUserData(ConfigHelper.getUserFilePath(base.userDataDir, getUserNodesFileName(theatreOfWar), nodesFileVersion), {missionNodes = nodesByTOW[theatreOfWar.name]})
	end
end
    
function onListViewAdd()
    local node = getNewNode()
    selectionHisrory[node.id] = getNewSelection()
	
	local towNodes = nodes(currentTOWId)
    table.insert(towNodes, node)
	
    selectedNode = node
    ListView.addItem(selectedNode)
    NodesMapView.addItem(selectedNode)
    NodesMapView.removeTemplates()
    ItemView.update(selectedNode)
    ItemView.show(true)
end

function onListViewRemove(id)
	local towNodes = nodes(currentTOWId)
    table.remove(towNodes, findByProp(towNodes, id, "id"))
    --TODO  удалять selectionItem
    selectedNode = nil
    NodesMapView.removeItem(id)
    NodesMapView.removeTemplates()
    ItemView.show(false)
end

function onListViewSelectionChanged(id, setMapPos)
    NodesMapView.removeTemplates()
	local towNodes = nodes(currentTOWId)
    selectedNode = towNodes[findByProp(towNodes, id, "id")]
    if selectedNode == nil then
        ItemView.show(false)
        NodesMapView.selectItem(nil, false)
    else
        ItemView.update(selectedNode)
        ItemView.show(true)
        NodesMapView.selectItem(selectedNode.id, setMapPos)
        updateSelectedTemplates(selectedNode)
    end
end

function onMapViewSelectionChanged(id)
    if (id == nil and selectedNode == nil) or (selectedNode ~= nil and id == selectedNode.id) then return end
    
    NodesMapView.removeTemplates()
	local towNodes = nodes(currentTOWId)
    selectedNode = towNodes[findByProp(towNodes, id, "id")]
    if selectedNode == nil then
        ItemView.show(false)
        ListView.selectItem(nil)
    else
        ListView.selectItem(selectedNode.id)
        ItemView.update(selectedNode)
        ItemView.show(true)
        updateSelectedTemplates(selectedNode)
    end
end

function onItemViewChanged(data)
	clone(selectedNode, data)
end

function onItemViewPosChanged(data)
    NodesMapView.updatePosition(data.id, data.redPos, data.bluePos, data.targetPos)
    NodesMapView.changeTemplatePos(data)
    selectedNode.redPos, selectedNode.bluePos, selectedNode.targetPos = data.redPos, data.bluePos, data.targetPos
end

function show(b)
    if not isInitialized then 
		base.print('Not initialized!') 
		return 
	end
    
    if b then 
        Toolbar.untoggle_all_except() 
    end
    
    ListView.show(b)
    NodesMapView.show(b)
end

function isVisible()
    return ListView.isVisible()
end

function onItemViewNameChanged(data)
	ListView.updateItemName(data.id, data.name)
    selectedNode.name = data.name
end

function onMapViewPosChanged(id, coalition, pos)
    if coalition == "red" then
        selectedNode.redPos = pos
    elseif coalition == "blue" then 
        selectedNode.bluePos = pos
	else
		selectedNode.targetPos = pos
    end
    NodesMapView.changeTemplatePos(selectedNode)
    ItemView.updatePositions(selectedNode)
end

function onTemplateSelectionChanged(templId, coalition)
    local templ
    local combatTemplates = TemplatesManager.templates()
    if templId ~= nil then
        templ = combatTemplates[findByProp(combatTemplates, templId, "name")]
    end
    NodesMapView.setTemplate(selectedNode, templ)
    selectionHisrory[selectedNode.id][coalition] = templ
end

function initViews()
    if isInitialized then return end
   
    ListView.init(lvX, lvY, lvW, lvH)
    ItemView.init(TemplatesManager.templates())
    
    isInitialized = true
end

function setParams(x, y, w, h)
    lvX, lvY, lvW, lvH = x, y, w, h
end

function nodes(towId)
    return nodesByTOW[towId] or {}
end

function currentNode()
    return selectedNode
end


local function updateNodesTemplates(combatTemplates)
    local function consistName(namesTable, name)
        for i,v in ipairs(namesTable) do
            if v.name == name then return true end
        end
        return false
    end
    
    local  function removeNonExistentTemplates(templList)
        for j, templ in ipairs(templList) do
            if not consistName(combatTemplates, templ) then
                table.remove(templList, j)
            end
        end    
    end

	for i, towNodes in pairs(nodesByTOW) do
		for j, v in ipairs(towNodes) do
			removeNonExistentTemplates(v.redTemplates)
			removeNonExistentTemplates(v.blueTemplates)
		end
	end
end

function onTemplatesChanged()
    local combatTemplates = TemplatesManager.templates()
    updateNodesTemplates(combatTemplates)
    ItemView.uptatePossibleTemplates(combatTemplates)
    if selectedNode ~= nil then
        ItemView.update(selectedNode)
    end
end

function isEnabledTargetPoint(a_localData)
	if a_localData.Tasks then
		local ind = U.find(a_localData.Tasks, "Ground Attack")
		if ind ~= nil then
			return true
		end
	end
	return false
end