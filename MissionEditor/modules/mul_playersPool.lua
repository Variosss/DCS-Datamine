local base = _G

module('mul_playersPool')

local require       = base.require
local pairs         = base.pairs
local table         = base.table
local math          = base.math
local loadfile      = base.loadfile
local setfenv       = base.setfenv
local string        = base.string
local assert        = base.assert
local io            = base.io
local loadstring    = base.loadstring
local print         = base.print
local os            = base.os

local i18n 				= require('i18n')
local Window 			= require('Window')
local U                 = require('me_utilities')
local MsgWindow         = require('MsgWindow')
local DialogLoader      = require('DialogLoader')
local net               = require('net')
local Static            = require('Static')
local Skin              = require('Skin')
local textutil          = require('textutil')
local lfs 				= require('lfs')
local Tools 			= require('tools')
local Gui               = require('dxgui')
local Kick              = require('mul_kick')
local Banned			= require('mul_banned')
local Unbanned			= require('mul_unbanned')
local DCS               = require('DCS')
local keys              = require('mul_keys')
local advGrid           = require('advGrid')
local SkinUtils			= require('SkinUtils')

i18n.setup(_M)

cdata = 
{
    playersPool         = _("PLAYERS POOL"),
    Callsign            = _("Callsign"),
    Ping                = _("Ping"),
    Score               = _("Score"),
    LA                  = _("A/C"),
    Unit                = _("Unit"),
    BoardNo             = _("Tac. No"),
    GroundTargets       = _("Ground"),
    Ships               = _("Ships"),
    Loss                = _("Loss"),
    KickPlayer          = _("Kick player"),
	Banned				= _("Ban Player"),
	Unbanned			= _("Ban List"),
}

local sortReverse = true
local rowHeight = 20
local myId = -1
local myInfo = {}
local curKeySort = 'name'
local curUnitId = nil
local slotByUnitId = {}
local allow_players_pool = true

-------------------------------------------------------------------------------
-- 
function create()
    w, h = Gui.GetWindowSize()
    window = DialogLoader.spawnDialogFromFile("MissionEditor/modules/dialogs/mul_playersPool.dlg", cdata)    
    local container = window.main_panel
 --   container:setBounds(parent:getBounds())
 
    local main_panel = window.main_panel
    
    pWork                   = main_panel.pWork
    pCenter                 = pWork.pCenter
    gridPool                = pCenter.gridPool
    pNoVisible              = pCenter.pNoVisible  
    btnClose                = pWork.btnClose
    btnKick                 = pWork.bKick
	btnBanned				= pWork.bBanned
	btnUnbanned				= pWork.bUnbanned
    
    gridPoolAdv = advGrid.new(gridPool)
    
    local count = gridPool:getColumnCount()
    
    skinSortUp      = pNoVisible.gridHeaderCellSortUp:getSkin()
    skinSortDown    = pNoVisible.gridHeaderCellSortDown:getSkin()
    skinNoSort      = pNoVisible.gridHeaderCellNoSort:getSkin()
    
    local KeysSort = 
    {
        "name", 
        "ping",
        "unitType",
        "num",
        "score",
        "ac",
        "units",
        "ships",
        "loss",
    }
    
    staticSkinGridServersAlignMiddle    = pNoVisible.sGridItemAlignMiddle:getSkin()
    staticSkinGridServersPadding        = pNoVisible.sGridItemPadding:getSkin()
    
    staticSkinGridServersAlignMiddleS   = pNoVisible.sGridItemAlignMiddleSelected:getSkin()
    
    SkinsHeaders = 
    {
        
        [1] = {
            skinSortUp      = pNoVisible.gridHeaderCellSortUpPadding:getSkin(),
            skinSortDown    = pNoVisible.gridHeaderCellSortDownPadding:getSkin(),
            skinNoSort      = pNoVisible.gridHeaderCellNoSortPadding:getSkin(),
        },
        [2] = {
            skinSortUp      = pNoVisible.gridHeaderCellSortUp:getSkin(),
            skinSortDown    = pNoVisible.gridHeaderCellSortDown:getSkin(),
            skinNoSort      = pNoVisible.gridHeaderCellNoSort:getSkin(),
        },    
    }
	
	for i = 0, count - 1 do
		local gridHeaderCell = gridPool:getColumnHeader(i)
        gridHeaderCell.KeySort = KeysSort[i+1]      
        
        gridHeaderCell:addChangeCallback(function(self)             
            if curKeySort == self.KeySort then
                sortReverse = not sortReverse
            else
                sortReverse = false
            end
            curKeySort = self.KeySort
            updateColumnHeaders()
            updateGrid()
        end	)
    end
    
    typesName =
    {
        my          = pNoVisible.sYellowText:getSkin(),
        red         = pNoVisible.sRedText:getSkin(),
        blue        = pNoVisible.sBlueText:getSkin(),
        sys         = pNoVisible.sWhiteText:getSkin(),
    }
    
    typesNameS =
    {
        my          = pNoVisible.sYellowTextSelected:getSkin(),
        red         = pNoVisible.sRedTextSelected:getSkin(),
        blue        = pNoVisible.sBlueTextSelected:getSkin(),
        sys         = pNoVisible.sWhiteTextSelected:getSkin(),
    }
    
    skinsForGrid =
    {
        all = {
            normal = staticSkinGridServersAlignMiddle,
            select = staticSkinGridServersAlignMiddleS,
            hover  = staticSkinGridServersAlignMiddle,
        },
        
        individual = {
            [0]= {
                ['func'] = function(a_cell, a_typeSkin) 
                    if a_typeSkin == 'select' then
                        return typesNameS[a_cell.skinType]
                    else
                        return typesName[a_cell.skinType]
                    end
                end
            }
            
        },
    }    
    
    gridPoolAdv:setSkins(skinsForGrid)
    
    resize(w, h)
    setupCallbacks()
    
    updateSlots()
	
    return window
end

function updateSlots()
    local redSlots = DCS.getAvailableSlots("red")
    local blueSlots = DCS.getAvailableSlots("blue")
  
    slotByUnitId = {}
    for k,v in base.pairs(redSlots) do
        slotByUnitId[v.unitId] = v
    end
    
    for k,v in base.pairs(blueSlots) do
        slotByUnitId[v.unitId] = v
    end
    
end
    
function resize(w, h)
  --  w = 1280
 --   h = 768
    window:setBounds(0, 0, w, h)
    window.main_panel:setBounds(0, 0, w, h)
    
    local gridW = 1280
    
    pWork:setBounds((w-1280)/2, h/2, gridW, h/2)
    
    pCenter:setBounds(0, 54, gridW, h/2-54)
    gridPool:setBounds(0, 0, gridW, h/2-54)

    gridPool:setColumnWidth(0, 298)   
    gridPool:setColumnWidth(1, 52)              
    gridPool:setColumnWidth(2, 320)     
    gridPool:setColumnWidth(3, 100)   
    gridPool:setColumnWidth(4, 100)  
    gridPool:setColumnWidth(5, 100)   
    gridPool:setColumnWidth(6, 100)   
    gridPool:setColumnWidth(7, 100)  
    gridPool:setColumnWidth(8, 100)  
    
end

function setupCallbacks()
    btnClose.onChange = onChange_btnClose
    btnKick.onChange = onChange_btnKick
	btnBanned.onChange = onChange_btnBanned
	btnUnbanned.onChange = onChange_btnUnbanned
    
    gridPool.onMouseDown = function(self, x, y, button)
        local col, row = gridPool:getMouseCursorColumnRow(x, y)

        if -1 < row then
            selectRow(row)
        end
    end
end 

function selectRow(row)
    local curRow = gridPool:getSelectedRow()

    local widget
    widget = gridPool:getCell(0, row)
    if widget and widget.data then
        curUnitId = widget.data.unit.id     
    end
        
    gridPool:selectRow(row)  
    verifyKick()    
end

function verifyKick()
	btnBanned:setVisible(false)
	btnUnbanned:setVisible(false)
	
    if curUnitId == myId or curUnitId == nil or DCS.isServer() ~= true  then
        btnKick:setVisible(false)
    else
        btnKick:setVisible(true)
		btnBanned:setVisible(true)
    end
	btnUnbanned:setVisible(true)
end

function onChange_btnClose()
    show(false)
end

function onChange_btnKick()
    Kick.show(true, curUnitId)
end

function onChange_btnBanned()
    Banned.show(true, curUnitId)
end

function onChange_btnUnbanned()
	Unbanned.show(true)
end

function show(b, a_showFon)
    if b == true and window == nil then
        create()
    end
    
    if window then
		if b then
			if window:getVisible() == false then
				DCS.lockAllMouseInput()
			end
		else
			if window:getVisible() == true then			
				DCS.unlockMouseInput()
			end	
		end	
		
        window:setVisible(b) 
        if a_showFon == true then
            window:setSkin(SkinUtils.setWindowPictureAlpha(1, window:getSkin()))
        else
            window:setSkin(SkinUtils.setWindowPictureAlpha(0, window:getSkin()))
        end
    end
    
    if b then
        verifyKick() 
        updateColumnHeaders()
        updateGrid()
    end   
	DCS.onShowDialog(b)
end

function onPlayerChangeSlot(id)
    if window and window:getVisible() == true then
        updateGrid()
    end
end    

function onPlayerConnect(id)
    if window and window:getVisible() == true then
        updateGrid()
    end
end 

function onPlayerDisconnect(id)
    if window and window:getVisible() == true then
        updateGrid()
    end
end 



local function compTable(tab1, tab2)
    if base.type(tab1[curKeySort]) == "string" then
        if sortReverse then
            return textutil.Utf8Compare(tab2[curKeySort], tab1[curKeySort])
        end
        return textutil.Utf8Compare(tab1[curKeySort], tab2[curKeySort])
    elseif base.type(tab1[curKeySort]) == "boolean" then
        if sortReverse then
            return (base.tostring(tab1[curKeySort]) > base.tostring(tab2[curKeySort]))
        end
        return (base.tostring(tab1[curKeySort]) < base.tostring(tab2[curKeySort]))
    else
        if sortReverse then
            return (tab1[curKeySort] > tab2[curKeySort])
        end
        return (tab1[curKeySort] < tab2[curKeySort])
    end       
end


local function getColumnHeaderSkin(a_key, a_index)
    if a_index == 0 or a_index == 2 then
        groupSkin = 1
    else
        groupSkin = 2
    end
    
	if curKeySort == a_key then
		if sortReverse then
			return SkinsHeaders[groupSkin].skinSortDown
		else
			return SkinsHeaders[groupSkin].skinSortUp
		end
	else
		return SkinsHeaders[groupSkin].skinNoSort
	end
end

function updateColumnHeaders()
	local count = gridPool:getColumnCount()
	
	for i = 0, count - 1 do
		local gridHeaderCell = gridPool:getColumnHeader(i)
		
		if gridHeaderCell then
			local skin = getColumnHeaderSkin(gridHeaderCell.KeySort, i)
			
			if skin then
				gridHeaderCell:setSkin(skin)
			end
		end
	end
end

function update(a_serverlist,a_force) 

end


function updateGrid()
    if gridPool and window and window:getVisible() == true then
        gridPool:removeAllRows()
        
        data = getPlayersData()

        base.table.sort(data, compTable)
        rowIndex = 0
        
        for k,v in base.pairs(data) do
            insertRow(v)
            rowIndex = rowIndex +1
        end
       
        if selRow then
     --       selectRow(selRow)
        end
    end
end

local function parseCommander(a_com)
    local pos = string.find(string.reverse(a_com), '_');        
    if pos then
        local tmp = string.sub(a_com,1,-pos-1)            
        pos = string.find(string.reverse(tmp), '_');         
        if pos then
            return string.sub(tmp,1, -pos-1)   
        else
            return tmp
        end
    end

    return a_com
end

function getPlayersData()
    local players = net.get_player_list()
    base.U.traverseTable(players)
    local data = {}
    myId = net.get_my_player_id() 
    myInfo = net.get_player_info(myId)
    
    for k,playerId in base.pairs(players) do
        local player_info = net.get_player_info(playerId)
        --base.U.traverseTable(player_info)  

        local stat = net.get_stat(playerId)  
        --base.U.traverseTable(stat) 
        --base.print("----stat----")
            --[[
                get_stat(playerid) -> 
                { "ping" = .., }
                get_stat(playerid, stat_name) -> stat_value
                get_stat(playerid, stat_id) -> stat_value
                имена:
                        "ping",
                        "crash",
                        "car",
                        "plane",
                        "ship",
                        "score",
                        "land",
                        "eject",
                            ]]
        
    
       -- local t = DCS.getUnitType(playerId)
        if player_info.slot ~= "" and player_info.slot ~= nil then
            
            local displayName 
            local onboard_num

            if slotByUnitId[player_info.slot] then       
                -- displayName = DCS.getUnitTypeAttribute(slotByUnitId[player_info.slot].type,"displayName")
                displayName = keys.tabTr[slotByUnitId[player_info.slot].type] or keys.getDisplayName(slotByUnitId[player_info.slot].type)
                onboard_num = slotByUnitId[player_info.slot].onboard_num
            else                
                local commander = parseCommander(player_info.slot)
                displayName = keys.tabTr[commander] or commander
                onboard_num = ""
            end
             --displayName
            player_info.unitType = displayName 
            player_info.num = onboard_num
        else
            player_info.unitType = ""
            player_info.num = ""
        end
        
        player_info.score = stat.score
        player_info.ac = stat.plane
        player_info.units = stat.car
        player_info.ships = stat.ship
        player_info.loss = stat.crash 
        
        base.table.insert(data,player_info)
    end
     
    return data
end    

function insertRow(v)
    gridPool:insertRow(rowHeight)
        
    local ind = rowIndex%2

   -- listRows[v.address] = {}
    local cell

    ------1
  --  cell = Static.new()
    cell = Static.new()
    cell.data = {unit = v, row = rowIndex} 
    
    local skinM
    local skinType
    
    base.print("---side---",myInfo.side,v.side)
    if myId == v.id then
        skinM = typesName.my 
        skinType = 'my' 
    elseif v.side == 0 then
        skinM = typesName.sys 
        skinType = 'sys'       
    elseif v.side == 1 then
        skinM = typesName.red
        skinType = 'red'     
    else 
        skinM = typesName.blue
        skinType = 'blue' 
    end
        
    cell:setSkin(skinM)    
    cell:setText(v.name)
    cell.skinType = skinType
    gridPool:setCell(0, rowIndex, cell)
  --  listRows[v.address][0] = cell
    
    ------2
    cell = Static.new()
    cell:setText(v.ping)
    cell:setSkin(staticSkinGridServersAlignMiddle)
 --   cell:setTooltipText(tooltipsPas)
    gridPool:setCell(1, rowIndex, cell)
 --   listRows[v.address][1] = cell
    
    ------3
    cell = Static.new()
    cell:setSkin(staticSkinGridServersAlignMiddle)
	if allow_players_pool == true then
		cell:setText(v.unitType)
	else	
		cell:setText("")
	end
    gridPool:setCell(2, rowIndex, cell)
--    listRows[v.address][2] = cell
    
    ------4
    cell = Static.new()
    cell:setSkin(staticSkinGridServersAlignMiddle)
	if allow_players_pool == true then
		cell:setText(v.num)
	else	
		cell:setText("")
	end   
  --  cell:setTooltipText(v.serverName)
    gridPool:setCell(3, rowIndex, cell)
 --   listRows[v.address][3] = cell
    
    ------5
    cell = Static.new()
    cell:setSkin(staticSkinGridServersAlignMiddle)
	if allow_players_pool == true then
		cell:setText(v.score) 
	else	
		cell:setText("")
	end    
--    cell:setTooltipText(v.map)
    gridPool:setCell(4, rowIndex, cell)
 --   listRows[v.address][4] = cell
    
    ------6
    cell = Static.new()
    cell:setSkin(staticSkinGridServersAlignMiddle)
	if allow_players_pool == true then
		cell:setText(v.ac) 
	else	
		cell:setText("")
	end
    
 --   cell:setTooltipText(v.missionName)
    gridPool:setCell(5, rowIndex, cell)
 --   listRows[v.address][5] = cell
    
    ------7
    cell = Static.new()
    cell:setSkin(staticSkinGridServersAlignMiddle)
	cell = Static.new()
    cell:setSkin(staticSkinGridServersAlignMiddle)
	if allow_players_pool == true then
		cell:setText(v.units)
	else	
		cell:setText("")
	end   
    gridPool:setCell(6, rowIndex, cell)
 --   listRows[v.address][6] = cell
     
    ------8
    cell = Static.new()
    cell:setSkin(staticSkinGridServersAlignMiddle)
	if allow_players_pool == true then
		cell:setText(v.ships)
	else	
		cell:setText("")
	end     
    gridPool:setCell(7, rowIndex, cell)
--    listRows[v.address][7] = cell
    
    ------9
    cell = Static.new()
    cell:setSkin(staticSkinGridServersAlignMiddle)
	if allow_players_pool == true then
		cell:setText(v.loss)
	else	
		cell:setText("")
	end 
    
    gridPool:setCell(8, rowIndex, cell)
--    listRows[v.address][7] = cell
end


function onChange_btnExit() 
    show(false)
end

function isVisible()
    if not window or window:getVisible() == false then
        return false
    end
    return true
end

function onSimulationStart()
	if DCS.isTrackPlaying() == false then
		local settings = net.get_server_settings()
		if settings.advanced and settings.advanced.allow_players_pool ~= nil then
			allow_players_pool = settings.advanced.allow_players_pool 
		end
	end
end
