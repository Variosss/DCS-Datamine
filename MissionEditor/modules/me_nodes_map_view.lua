local base = _G

module('me_nodes_map_view')

local require = base.require
local table = base.table
local math = base.math
local pairs = base.pairs
local ipairs = base.ipairs

local U = require('me_utilities')
local MapColor = require('MapColor')
local MapWindow = require('me_map_window')
local NewMapState = require('NewMapState')
local NodesManager = require('me_nodes_manager')
local TemplatesManager = require('me_templates_manager')

require('i18n').setup(_M)

local mapMarksStartId = 100000
local mapCompMarksStartId = {red = 200000, blue = 201000}
local mapMarksId = mapMarksStartId
local mapMarkByNode = {}
local markList = {} --удаления из markList не происходит т.к. id постоянно возрастают, без дублирования
local selectedNodeMark, selectedNode
local tempateMarks = {red = {}, blue = {}}
local visible = false

local function getMapMark(node, coalition)
    mapMarksId = mapMarksId + 1
    
    local id = mapMarksId
    local x, y, cltColor
    
    if coalition == "red" then
        x, y = node.redPos[1], node.redPos[2]
        cltColor = MapColor.red_node_unselected
    else
        x, y = node.bluePos[1], node.bluePos[2]
        cltColor = MapColor.blue_node_unselected
    end
    
    local classKey = "P_battleNodePos"
    local angle = 0
    local color = nil
    
    local mapMark = MapWindow.createDOT(classKey, id, x, y, angle, color)
    
    mapMark.currColor = cltColor
    mapMark.userObject = {id = node.id, clt = coalition}

    table.insert(markList, mapMarksId, mapMark) 
    
    return mapMark
end

local function getMapTargetMark(node)
	if NodesManager.isEnabledTargetPoint(node) == false then
		return
	end
    mapMarksId = mapMarksId + 1
    
    local id = mapMarksId
    local x, y, cltColor

	x, y = node.targetPos[1], node.targetPos[2]
	cltColor = MapColor.target_node_unselected

    local classKey = "P_battleNodePos"
    local angle = 0
    local color = nil
    
    local mapMark = MapWindow.createDOT(classKey, id, x, y, angle, color)
    
    mapMark.currColor = cltColor
    mapMark.userObject = {id = node.id, clt = coalition}

    table.insert(markList, mapMarksId, mapMark) 
    
    return mapMark
end

local function getCompanyPos(globMapP1, globMapP2, nodePos, enemyNodePos) 
    local dir = {enemyNodePos[1] - nodePos[1], enemyNodePos[2] - nodePos[2]}
    local dist = math.max(math.sqrt(dir[1]*dir[1] + dir[2]*dir[2]), 0.1)
    dir[1], dir[2] = dir[1]/dist, dir[2]/dist
    
    local localMapP = {globMapP1, globMapP2}
    local gPt, lPts = {}, {{}, {}}
    local minX, minY, maxX, maxY
    for i = 1, 2 do
        gPt[1], gPt[2] = localMapP[i].x, localMapP[i].y
        
        lPts[i][1] = (gPt[1] - nodePos[1])*dir[1] + (gPt[2] - nodePos[2])*dir[2]
        lPts[i][2] = (gPt[1] - nodePos[1])*(-dir[2]) + (gPt[2] - nodePos[2])*dir[1]
    end
    
    return {math.min(lPts[1][1], lPts[2][1]), math.min(lPts[1][2], lPts[2][2])},
                {math.max(lPts[1][1], lPts[2][1]), math.max(lPts[1][2], lPts[2][2])}
end

local function updateCompanyZonePos(mark, pMin, pMax, pos, enemyPos)
    mark.points = {}
    local rectPoints = {pMin, {pMax[1], pMin[2]}, pMax, {pMin[1], pMax[2]}}
    
    local dir = {enemyPos[1] - pos[1], enemyPos[2] - pos[2]}
    local dist = math.max(math.sqrt(dir[1]*dir[1] + dir[2]*dir[2]), 0.1)
    dir[1], dir[2] = dir[1]/dist, dir[2]/dist
    
    
    for i, p in ipairs(rectPoints) do
        local globP = {}
        globP[1] = pos[1] + p[1]*dir[1] - p[2]*dir[2]
        globP[2] = pos[2] + p[1]*dir[2] + p[2]*dir[1]
        
        local geoP = {}
        
        geoP.x, geoP.y = globP[1], globP[2]
        table.insert(mark.points, geoP)
    end
end

local function updateTitlePos(titleMark, companyZone)
    local rectPnts = companyZone.points
    
    if #rectPnts ~= 4 then return end
    
    titleMark.x = (rectPnts[1].x + rectPnts[3].x) / 2
    titleMark.y = (rectPnts[1].y + rectPnts[3].y) / 2
end

local function getComapnyMark(pos, enemyPos, company, template, companyType)
    local marksTable = tempateMarks[template.coalition]
    local lid = mapCompMarksStartId[template.coalition] + #marksTable + 1
    if template.coalition == "red" then 
        templColor = MapColor.red_template
    else
        templColor = MapColor.blue_template
    end
    
    local classKey = 'S_companyPos'
    local id = lid
    local points = {}
    local color = nil
    local stencil = 3
    
    local companyZone = MapWindow.createSQR(classKey, id, points, color, stencil)
    
    companyZone.userObject = {templ = template, comp = company, compType = companyType}
    companyZone.currColor = templColor  

    updateCompanyZonePos(companyZone, company.pMin, company.pMax, pos, enemyPos)
	
    table.insert(marksTable, companyZone)
    table.insert(markList, lid, companyZone) 
    
    local compName = company.name or "Player squadron"
    
    local classKey = 'T_companyName'
    local id = lid+1
    local x = 0
    local y = 0
    local title = compName
    local color = nil
    local angle = 0
    
    local companyTitle = MapWindow.createTIT(classKey, id, x, y, title, color, angle)
    
    companyTitle.userObject = company

    updateTitlePos(companyTitle, companyZone)
    table.insert(marksTable, companyTitle)
    table.insert(markList, lid+1, companyTitle)
end

function init(nodes)
    MapWindow.removeUserObjects(markList)
	mapMarkByNode = {}
	markList = {} --удаления из markList не происходит т.к. id постоянно возрастают, без дублирования
	selectedNodeMark, selectedNode = nil, nil

	for i, node in ipairs(nodes) do
        local markRed = getMapMark(node, "red")
        local markBlue = getMapMark(node, "blue")		
		local markTarget = getMapTargetMark(node) -- вставляем маркер цели
        mapMarkByNode[node.id] = {markRed, markBlue, markTarget}
    end
end

function updatePosition(id, pos1, pos2, targetPos)
    local marks = mapMarkByNode[id]
    
    if marks == nil then return end
    
    marks[1].x = pos1[1]
    marks[1].y = pos1[2]

    marks[2].x  = pos2[1]
    marks[2].y  = pos2[2]	
	if targetPos then	
		marks[3].x  = targetPos[1]
		marks[3].y  = targetPos[2]
	end
    MapWindow.removeUserObjects(marks)
    MapWindow.addUserObjects(marks)
end

function addItem(node)
    local marks = {}
    local markRed = getMapMark(node, "red")
    local markBlue = getMapMark(node, "blue")
	local markTarget = getMapTargetMark(node) -- вставляем маркер цели
        
    table.insert(marks, markRed)
    table.insert(marks, markBlue)
	table.insert(marks, markTarget)
        
    mapMarkByNode[node.id] = marks
    
    MapWindow.addUserObjects(marks)
    selectItem(node.id, false)
	
end

function removeTargetPoint(id)
    local marks = mapMarkByNode[id]
    if marks ~=nil then
        MapWindow.removeUserObjects({marks[3]})
		if marks[3] then
			markList[marks[3].id] = nil
			marks[3] = nil
		end
		selectedNodeMark = nil
    end
end

function addTargetPoint(node)
	local marks = mapMarkByNode[node.id]
    if marks ~=nil and marks[3] == nil then
		local markTarget = getMapTargetMark(node)
		marks[3] = markTarget
		
		MapWindow.addUserObjects({marks[3]})
	end
end

function removeItem(id)	
    local marks = mapMarkByNode[id]
    if marks ~=nil then
        MapWindow.removeUserObjects(marks)
        mapMarkByNode[id] = nil
        selectedNode = nil
        selectedNodeMark = nil
        
        markList[marks[1].id] = nil
        markList[marks[2].id] = nil

		if marks[3] then
			markList[marks[3].id] = nil
		end
    end
end

function selectItem(id, setMapPos)
    if selectedNode then
        selectedNode[1].currColor = MapColor.red_node_unselected 
        selectedNode[2].currColor = MapColor.blue_node_unselected
		if selectedNode[3] then
			selectedNode[3].currColor = MapColor.target_node_unselected
		end
        MapWindow.removeUserObjects(selectedNode)
        MapWindow.addUserObjects(selectedNode)
    end
    
    local marks
    
    if id then
        marks = mapMarkByNode[id]
        marks[1].currColor = MapColor.red_node_selected 
        marks[2].currColor = MapColor.blue_node_selected
		if marks[3] then
			marks[3].currColor = MapColor.target_node_selected
		end
        MapWindow.removeUserObjects(marks)
        MapWindow.addUserObjects(marks)
        
        if setMapPos then
            MapWindow.setCamera((marks[1].x + marks[2].x)/2, (marks[1].y + marks[2].y)/2)
        end
    end
    selectedNode = marks
end

function setTemplate(node, templ)
    if not templ then return end
  
    local pos, enemyPos
    if (templ.coalition == "red") then
        pos, enemyPos = node.redPos, node.bluePos
    else
        pos, enemyPos = node.bluePos, node.redPos
    end
    
    MapWindow.removeUserObjects(tempateMarks[templ.coalition])
    
    for i,v in pairs(tempateMarks[templ.coalition]) do markList[v.id]=nil end
    tempateMarks[templ.coalition] = {}
    for i,v in ipairs(templ.companies) do
        getComapnyMark(pos, enemyPos, v, templ, "company")
    end
    
    getComapnyMark(pos, enemyPos, templ.playerZone, templ, "playerZone")
    
    MapWindow.addUserObjects(tempateMarks[templ.coalition])
end

local function changeSideTemplPos(marks, pos, enemyPos)
    MapWindow.removeUserObjects(marks)
    for i = 1, #marks - 1, 2 do
        local comp = marks[i].userObject.comp
        updateCompanyZonePos(marks[i], comp.pMin, comp.pMax, pos, enemyPos)
        updateTitlePos(marks[i+1], marks[i])
    end
    MapWindow.addUserObjects(marks)  
end

function changeTemplatePos(node)
    if not node or not selectedNodeMark or node.id ~= selectedNodeMark.userObject.id then return end
    changeSideTemplPos(tempateMarks.red, node.redPos, node.bluePos)
    changeSideTemplPos(tempateMarks.blue, node.bluePos, node.redPos)
end

function removeTemplates()
    for i,v in pairs(tempateMarks.red) do markList[v.id] = nil end
    for i,v in pairs(tempateMarks.blue) do markList[v.id] = nil end
    
    MapWindow.removeUserObjects(tempateMarks.red)
    MapWindow.removeUserObjects(tempateMarks.blue)
    tempateMarks.red = {}
    tempateMarks.blue = {}
end

local function handleLeftMouseDown(x, y)
    local mapX, mapY = MapWindow.getMapPoint(x, y)
    local mapX2, mapY2 = MapWindow.getMapPoint(x+10, y)
    radius = mapY2 - mapY
    
    local nearestNode, nearestTemplate
    local objects = MapWindow.findUserObjects(mapX, mapY, radius)
    for i,v in ipairs(objects) do
		if markList[v] then
			if v > mapMarksStartId and v < mapCompMarksStartId.red then 
				nearestNode = markList[v]
				break
			elseif v > mapCompMarksStartId.red then
				local companyMarkId = v
				if v % 2 == 0 then companyMarkId = v-1 end
				nearestTemplate = markList[companyMarkId]
				break
			end
		end
    end
    
    if nearestTemplate then
        local moveableCorners = nil
        local minDist = radius
        local points = nearestTemplate.points
        for i, p in ipairs(points) do
            local dx, dy = p.x-mapX, p.y-mapY
            local dist = math.sqrt(dx*dx+dy*dy)
            if (dist < minDist) then
                local nextCorner = (i + 1) % 4 + 1
                moveableCorners = 
                {
                    {x = points[i].x, y = points[i].y},
                    {x = points[nextCorner].x, y = points[nextCorner].y}
                }
                
                minDist = dist
            end
        end

        selectedNodeMark = nil
        selectedTemplateMark = 
        {
            companyMark = nearestTemplate, 
            textMark = markList[nearestTemplate.id+1], 
            startPoint = {mapX, mapY},
            moveableCorners = moveableCorners
        }
        
        TemplatesManager.onMapViewSelectionChanged(nearestTemplate.userObject.templ, nearestTemplate.userObject.comp, nearestTemplate.userObject.compType)
        return
    end
    
    selectedTemplateMark = nil
    if nearestNode then
        selectItem(nearestNode.userObject.id, false)
        selectedNodeMark = nearestNode
        NodesManager.onMapViewSelectionChanged(nearestNode.userObject.id)
        return
    end
    
    selectedNodeMark = nil
end

-- TODO: сделать для этого модуля отдельный NewMapState
function onMouseDown(self, x, y, button)
    if 1 == button then
        handleLeftMouseDown(x,y);
    end
end

local function getPositionsFromMapNode(myClt)
    local mapNodePos, mapEnemyNodePos
    
    if myClt == "red" then
        mapNodePos = {selectedNode[1].x, selectedNode[1].y}
        mapEnemyNodePos = {selectedNode[2].x, selectedNode[2].y} 
    else
        mapNodePos = {selectedNode[2].x, selectedNode[2].y}
        mapEnemyNodePos = {selectedNode[1].x, selectedNode[1].y} 
    end
    
    return mapNodePos, mapEnemyNodePos
end

function onMouseDrag(self, dx, dy, button, x, y)
    if button == 1 and selectedNodeMark then
        local mapX, mapY = MapWindow.getMapPoint(x, y)
        selectedNodeMark.x = mapX
        selectedNodeMark.y = mapY
        MapWindow.removeUserObjects({selectedNodeMark})
        MapWindow.addUserObjects({selectedNodeMark})
        
        local rx, ry = mapX, mapY
        NodesManager.onMapViewPosChanged(selectedNodeMark.userObject.id, selectedNodeMark.userObject.clt, {rx, ry})
    
    elseif button == 1 and selectedTemplateMark then
        local mapX, mapY = MapWindow.getMapPoint(x, y)
        local startX = selectedTemplateMark.startPoint[1]
        local startY = selectedTemplateMark.startPoint[2]
        selectedTemplateMark.startPoint = {mapX, mapY}
        
        local companyMark = selectedTemplateMark.companyMark
        local dx, dy = mapX - startX, mapY - startY
        
        local points = companyMark.points
        local rectPnt1, rectPnt2
        if selectedTemplateMark.moveableCorners then
            rectPnt1 = selectedTemplateMark.moveableCorners[1]
            rectPnt1.x = rectPnt1.x + dx
            rectPnt1.y = rectPnt1.y + dy
            rectPnt2 = selectedTemplateMark.moveableCorners[2]
        else
            rectPnt1 = {x = points[1].x+dx, y = points[1].y+dy}
            rectPnt2 = {x = points[3].x+dx, y = points[3].y+dy}
        end
        
        local nodePos, enemyNodePos = getPositionsFromMapNode(companyMark.userObject.templ.coalition, selectedNode)
        
        local pMin, pMax = getCompanyPos(rectPnt1, rectPnt2, nodePos, enemyNodePos)
        updateCompanyZonePos(companyMark, pMin, pMax, nodePos, enemyNodePos)
        
        local textMark = selectedTemplateMark.textMark
        updateTitlePos(textMark, companyMark)
        
        MapWindow.removeUserObjects({companyMark, textMark})
        MapWindow.addUserObjects({companyMark, textMark})
        
        TemplatesManager.onMapViewPosChanged(companyMark.userObject.templ, companyMark.userObject.comp, companyMark.userObject.compType, pMin, pMax)
    end
    
    NewMapState.onMouseDrag(self, dx, dy, button, x, y)
end

function cameraPos()
    local x, y = MapWindow.getCamera()
    return {x, y}
end

function show(b)
    if b == visible then return end
    
    if b then
        MapWindow.unselectAll()
        MapWindow.setState(MapWindow.getNodesState())
        visible = true
    
        local objs = {}
        for i, v in pairs(markList) do 
			table.insert(objs, v) 
		end
        MapWindow.addUserObjects(objs)
    else
        MapWindow.setState(MapWindow.getPanState())
        visible = false
        
        MapWindow.removeUserObjects(markList)
    end
end