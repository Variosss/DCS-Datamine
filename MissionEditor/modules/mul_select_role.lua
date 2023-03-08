local base = _G

module('mul_select_role')

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
local Button			= require('Button')
local Gui               = require('dxgui')
local ListBoxItem       = require('ListBoxItem')
local Server_list       = require('mul_server_list')
local Chat		        = require('mul_chat')
local MeSettings	 	= require('MeSettings')
local FileDialog 		= require('FileDialog')
local FileDialogFilters	= require('FileDialogFilters')
local DCS               = require('DCS')
local PlayersPool       = require('mul_playersPool')
local BriefingDialog    = require('BriefingDialog')
local nickname          = require('mul_nickname')
local keys              = require('mul_keys')
local wait_query        = require('mul_wait_query')
local UC				= require('utils_common')
local waitScreen        = require('me_wait_screen')
local RPC               = require('RPC')
local query 			= require('mul_query')
local advGrid           = require('advGrid')
local Terrain 			= require('terrain')
local ProductType		= require('me_ProductType') 

i18n.setup(_M)

local locale = i18n.getLocale()
local rowHeight = 21
local passwords = {}
local passwordsById = {}
local passwordRed = nil
local passwordBlue = nil
local redPasswordHash = nil
local bluePasswordHash = nil

cdata = 
{
    Exit                = _("EXIT"),
    BLUECOALITION       = _("BLUE COALITION"),
    REDCOALITION        = _("RED COALITION"),
    Spectrators         = _("SPECTATORS"),
    BackToSpectrators   = _("BACK TO SPECTATORS"),
    Disconnect          = _("DISCONNECT"),
    PlayersPool         = _("PLAYERS POOL"),
    Chat                = _("CHAT"),
    Briefing            = _("BRIEFING"),
    mult_selectRole     = _("MULTIPLAYER - Select role"),
    
    group               = _("Group"),
    UnitType            = _("Unit Type"),
    Position            = _("Position"),
    Country             = _("Country"),
    Payload             = _("Airfield"),
    Player              = _("Player"),
    ChangeMission       = _("CHANGE MISSION"),
	passwordEnable      = _("Password enable"),
	Password			= _("Password:"),
	IncorrectPassword   = _("Incorrect password"),
	JoinRed          	= _("Join the Red coalition"),
	JoinBlue            = _("Join the Blue coalition"),
	Show				= _("Show"),
	Show_tooltip 		= _("Reveal coalition slots"),
}

if ProductType.getType() == "LOFAC" then
    cdata.UnitType    = _("Unit Type-LOFAC")
    cdata.Player      = _("Player-LOFAC")
end

local needCreateGrids = true
local MultySeatLAbyId = {}
local ship_by_type = nil
local curKeySort = 'groupName'
local sortReverse = false

local KeysSort = 
    {
		"password",
        "groupName", 
		"type",
        "not",
        "not",
        "not",
        "airdromeName",
        "not",
    }


--------------------------------------------------
-- 
function create()
    w, h = Gui.GetWindowSize()
    window = DialogLoader.spawnDialogFromFile("MissionEditor/modules/dialogs/mul_select_role.dlg", cdata)    
    local container = window.main_panel
 --   container:setBounds(parent:getBounds())
    parent = parent
 
    local main_panel = window.main_panel
    
    pWork                   = main_panel.pWork
    pCenter                 = pWork.pCenter
    gridBlue                = pCenter.gridBlue
    gridRed                 = pCenter.gridRed
    pNoVisible              = pCenter.pNoVisible  
    pUp                     = main_panel.pUp
    pBtn                    = main_panel.pBtn
    btnClose                = pUp.btnClose
    btnExit                 = pBtn.btnExit
    sLoginNickname          = pCenter.sLoginNickname
    lbSpectrators           = pWork.lbSpectrators
    btnBackToSpectrators    = pWork.btnBackToSpectrators
    pRed                    = pCenter.pRed
    sRedCoalition           = pRed.sRedCoalition
    sBlueCoalition          = pCenter.sBlueCoalition
    btnDisconnect           = pBtn.btnDisconnect
    btnChangeMission        = pBtn.btnChangeMission
    btnPlayersPool          = pCenter.btnPlayersPool
    btnBriefing             = pBtn.btnBriefing
    sNameMission            = pBtn.sNameMission
    sNumPlayersRed          = pRed.sNumPlayersRed
    sNumPlayersBlue         = pCenter.sNumPlayersBlue
	ePassword				= pBtn.ePassword
	bJoinRed				= pRed.bJoinRed
	bJoinBlue				= pCenter.bJoinBlue
	pPassword				= main_panel.pPassword
	bCancelPassword			= pPassword.pBox.bCancel
	ePasswordCaol			= pPassword.pBox.ePasswordCaol
	bOkPassword				= pPassword.pBox.bOkPassword
   
    resize(w, h)
    
    gridBlueAdv = advGrid.new(gridBlue)
    gridRedAdv = advGrid.new(gridRed)
    
    setupCallbacks()
	
	staticSkinGridServersLock           = pNoVisible.sLock:getSkin()
    staticSkinGridServersLockNo         = pNoVisible.sLockNo:getSkin()
	staticSkinGridServersLockSel		= pNoVisible.sLockSel:getSkin()
	staticSkinGridServersLockNoSel		= pNoVisible.sLockNoSel:getSkin()
    
    skinGridItemAlignMiddle1 = pNoVisible.sGridItemAlignMiddle1:getSkin()
    skinGridItemPadding1 = pNoVisible.sGridItemPadding1:getSkin()
    
    skinGridItemAlignMiddle2 = pNoVisible.sGridItemAlignMiddle2:getSkin()
    skinGridItemPadding2 = pNoVisible.sGridItemPadding2:getSkin()
    
    skinGridItemAlignMiddleSel = pNoVisible.sGridItemAlignMiddleSel:getSkin()
    skinGridItemPaddingSel = pNoVisible.sGridItemPaddingSel:getSkin()
    
    skinGridItemAlignMiddleDis = pNoVisible.sGridItemAlignMiddleDis:getSkin()
    skinGridItemPaddingDis = pNoVisible.sGridItemPaddingDis:getSkin()
    
    skinGridItemAlignMiddleHover1 = pNoVisible.sGridItemAlignMiddleHover1:getSkin()
    skinGridItemAlignMiddleHover2 = pNoVisible.sGridItemAlignMiddleHover2:getSkin()
    
    skinGridItemPaddingHover1 = pNoVisible.sGridItemPaddingHover1:getSkin()
    skinGridItemPaddingHover2 = pNoVisible.sGridItemPaddingHover2:getSkin()
         
    SkinsStatic = 
    {
        [1] = {
            skinAlignMiddle     = skinGridItemAlignMiddle1,
            skinPadding         = skinGridItemPadding1,
            skinAlignMiddleHover= skinGridItemAlignMiddleHover1,
            skinPaddingHover    = skinGridItemPaddingHover1
        },
        [2] = { --выделенный свой
            skinAlignMiddle     = skinGridItemAlignMiddleSel,
            skinPadding         = skinGridItemPaddingSel,            
        }, 
        [3] = {
            skinAlignMiddle     = skinGridItemAlignMiddle2,
            skinPadding         = skinGridItemPadding2,
            skinAlignMiddleHover= skinGridItemAlignMiddleHover2,
            skinPaddingHover    = skinGridItemPaddingHover2
        },
        [4] = { -- здесь надо сделать серый текст
            skinAlignMiddle     = skinGridItemAlignMiddleDis,
            skinPadding         = skinGridItemPaddingDis,
        },
        
    }
    
    SkinsHeaders = 
    {
        [1] = {
            skinNoSort      = pNoVisible.gridHeaderCellNoSort:getSkin(),
			skinSortUp     	= pNoVisible.gridHeaderCellSortUp:getSkin(),
			skinSortDown  	= pNoVisible.gridHeaderCellSortDown:getSkin(),
        },
        [2] = {
            skinNoSort      = pNoVisible.gridHeaderCellNoSortPadding:getSkin(),
			skinSortUp      = pNoVisible.gridHeaderCellSortUpPadding:getSkin(),
			skinSortDown 	= pNoVisible.gridHeaderCellSortDownPadding:getSkin(),
        }        
    }
    
    skinsForGrid =
    {
        all = {
            ['func'] = function(a_cell, a_typeSkin)  
				if a_typeSkin == 'normal'then
					if a_cell.colNum == 1 then						
						if a_cell.data.password ~= nil then
							return staticSkinGridServersLock
						else
							return staticSkinGridServersLockNo
						end	
					end 
                    return a_cell.skin
                elseif a_typeSkin == 'select' then
					if a_cell.colNum == 1 then						
						if a_cell.data.password ~= nil then
							return staticSkinGridServersLockSel
						else
							return staticSkinGridServersLockNoSel							
						end	
					end 
                    return SkinsStatic[2].skinAlignMiddle  
                else -- hover
					if a_cell.colNum == 1 then						
						if a_cell.data.password ~= nil then
							return staticSkinGridServersLock
						else
							return staticSkinGridServersLockNo
						end	
					end

                    if SkinsStatic[a_cell.skinType].skinAlignMiddleHover then
                        if a_cell.colNum == 5 or a_cell.colNum == 6 then
                            return SkinsStatic[a_cell.skinType].skinAlignMiddleHover
                        else
                            return SkinsStatic[a_cell.skinType].skinPaddingHover
                        end
                    else
                        return a_cell.skin
                    end        
                end
            
            end
        },
    }
    
    gridBlueAdv:setSkins(skinsForGrid)
    gridRedAdv:setSkins(skinsForGrid)
	
	for k, grid in base.pairs({gridBlue,gridRed}) do
		for i = 0, 7 do
			local headerCell = grid:getColumnHeader(i)
			headerCell.KeySort = KeysSort[i+1]  

			
			headerCell:addChangeCallback(function(self) 
				if self.KeySort == 'not' then
					return
				end
				
				if curKeySort == self.KeySort then
					sortReverse = not sortReverse
				else
					sortReverse = false
				end
				curKeySort = self.KeySort

				updateColumnHeaders()
				needCreateGrids = true
				updateGrids()
			end	)		
		end 
	end	

    return window
end

function resize(w, h)

  --  w = 1280
 --   h = 768
    window:setBounds(0, 0, w, h)
    window.main_panel:setBounds(0, 0, w, h)
    
    local gridW = 1280
	
	pPassword:setPosition(0, 0)
	pPassword:setSize(w, h)
	pPassword.pBox:setPosition((w-500)/2, (h-170)/2)
    
    pWork:setBounds((w-1280)/2, 50, gridW, h - 50 - 50)
 
    pUp:setBounds((w-1280)/2, 0, 1280, 51)
    pBtn:setBounds((w-1280)/2, h-51, 1280, 51)
    
    local hCenter = h- 50 - 50
    lbSpectrators:setBounds(0, 61, 253, hCenter-61-67)    
    btnBackToSpectrators:setBounds(29, hCenter-58, 196, 59)
    
    pCenter:setBounds(254, 0, 1026, hCenter) 
    
    local hGrid = (hCenter - 80)/2 
    gridBlue:setBounds(-1, 41, 1028, hGrid) 
    
    pRed:setBounds(0, 40+hGrid, 1028, 41) 
    sBlueCoalition:setBounds(0, 0, 1028, 41)     
    sNumPlayersBlue:setBounds(280, 10, 230, 20) 
    
    gridRed:setBounds(-1, 81+hGrid, 1028, hGrid) 
    
    gridBlue:setColumnWidth(0, 19)   
    gridBlue:setColumnWidth(1, 261)
    gridBlue:setColumnWidth(2, 120)
    gridBlue:setColumnWidth(3, 120)
    gridBlue:setColumnWidth(4, 80)    
    gridBlue:setColumnWidth(5, 50)
    gridBlue:setColumnWidth(6, 205)
    gridBlue:setColumnWidth(7, 168)
    
	gridRed:setColumnWidth(0, 19)  
    gridRed:setColumnWidth(1, 261)
    gridRed:setColumnWidth(2, 120)
    gridRed:setColumnWidth(3, 120)
    gridRed:setColumnWidth(4, 80)    
    gridRed:setColumnWidth(5, 50)
    gridRed:setColumnWidth(6, 205)
    gridRed:setColumnWidth(7, 168)
      
end

function isRole(a_type)
    if base.check_plugin_available  
        and base.check_plugin_available("Combined Arms by Eagle Dynamics")
        and base.db 
        and base.db.roles
        and base.db.roles[a_type] then
        return true
    end
    return false
end

function isEnableAirdrome(a_type)
	if a_type then
		if ship_by_type == nil then
			ship_by_type = {}
			for i,v in pairs(base.db.Units.Ships.Ship) do
				ship_by_type[v.type] = v
			end
		end
		
		local unitDef = ship_by_type[a_type]
		if unitDef then
			if unitDef.PlayerInteractionLocked ~= true then
				return true
			end			
			return false
		end
	end
	return true
end

function isValidSlot(a_data)
	local a_type = a_data.type
	local a_helipadUnitType = a_data.helipadUnitType
		return (base.aircraftFlyableInPlugins[a_type] or isRole(a_type)) and isEnableAirdrome(a_helipadUnitType) and isMulticrewOkaySlot(a_data)
end	
    
function setupCallbacks()
    btnExit.onChange = onChange_btnExit
    btnClose.onChange = onChange_btnExit
    btnDisconnect.onChange = onChange_btnDisconnect
    btnChangeMission.onChange    = onChange_btnChangeMission
    btnPlayersPool.onChange    = onChange_btnPlayersPool
    btnBriefing.onChange    = onChange_btnBriefing
    btnBackToSpectrators.onChange = onChange_btnBackToSpectrators
	ePassword.onKeyDown = onKeyDown_ePassword
	bJoinRed.onChange = onChange_bJoinRed
	bJoinBlue.onChange = onChange_bJoinBlue
	bCancelPassword.onChange = onChange_bCancelPassword
	bOkPassword.onChange = onChange_bOkPassword
    
    
    gridRed.onMouseDown = function(self, x, y, button)
        if 1 ~= button then
            return
        end
       
        local col, row = gridRed:getMouseCursorColumnRow(x, y)

        if -1 < row then
            local widget = gridRed:getCell(0, row)
            if widget and widget.data then
                if isValidSlot(widget.data) then
                    setSlot(1,widget.data.unitId)
                    gridRedAdv:selectRow(row)                      
                end    
            end  
			updateGrids()
        end        
    end
    
    gridBlue.onMouseDown = function(self, x, y, button)
        if 1 ~= button then
            return
        end
        
        local col, row = gridBlue:getMouseCursorColumnRow(x, y)

        if -1 < row then
            local widget = gridBlue:getCell(0, row)
            if widget and widget.data then              
                if isValidSlot(widget.data) then
                    setSlot(2,widget.data.unitId)   
                    gridBlueAdv:selectRow(row)  
                end    
            end
			updateGrids()
        end        
    end
end 

local function parseUnitId(a_unitId)
    local pos = string.find(string.reverse(a_unitId), '_');        
    if pos then
        local unitId = string.sub(a_unitId, 1, -pos -1);
        local place = string.sub(a_unitId,-pos+1)
        return true,unitId,place
    end

    return false
end

function busyLA(a_unitId)
    local idMaster  = MultySeatLAbyId[a_unitId]     
    if idMaster and (idMaster ~= net.get_my_player_id()) then
        return true, idMaster
    end

    return false
end

function setSlot(a_side, a_unitId)
    print("---setSlot---",a_side, a_unitId)
    
    if playerIdBySlot[a_unitId] ~= nil then
        print("---slotbusy---")
        return
    end
 
    query.onChange_bDenyAll() -- отказываем всем на присоединение к ЛА
    
	local bBusyLA, idMaster = busyLA(a_unitId)
    if bBusyLA then
		local foo, newID = parseUnitId(a_unitId)
		local baz, oldAID = net.get_slot(net.get_my_player_id())
		local bar, oldID = parseUnitId(oldAID)
		if newID ~= oldID then 
			wait_query.show(true, idMaster)
		end
    end    

	local passwordCoal = nil
	if a_side == 1 then
		passwordCoal = passwordRed
	elseif a_side == 2 then
		passwordCoal = passwordBlue
	end
	
	--base.print("---dd--",a_side,a_unitId, passwordCoal, passwordsById[a_unitId])
    net.set_slot(a_side,a_unitId, passwordCoal, passwordsById[a_unitId])
end

function onChange_btnBackToSpectrators()
    query.onChange_bDenyAll() -- отказываем всем на присоединение к ЛА
    
    local my_info = net.get_player_info(net.get_my_player_id())
    if my_info.side ~= 0 then
        net.set_slot(0, "")
    end
end

function onKeyDown_ePassword(self, key, unicode)
	if 'return' == key then                      
		base.table.insert(passwords, self:getText())
		self:setText()
		
		needCreateGrids = true
		updateGrids()
	end
end

function onChange_bJoinRed()
	pPassword.pBox.sHeader:setText(cdata.JoinRed)
	ePasswordCaol:setText("")
	pPassword.type = "red"
	pPassword.pBox.pError:setVisible(false)
	pPassword:setVisible(true)
end

function onChange_bJoinBlue()
	pPassword.pBox.sHeader:setText(cdata.JoinBlue)
	ePasswordCaol:setText("")
	pPassword.type = "blue"
	pPassword.pBox.pError:setVisible(false)
	pPassword:setVisible(true)
end

function onChange_bCancelPassword()
	pPassword:setVisible(false)
end

function onChange_bOkPassword(self)
	local result = false
	if pPassword.type == "red" then 
		result = net.check_password(ePasswordCaol:getText(), redPasswordHash)		
		
		if result then 
			passwordRed = ePasswordCaol:getText()
			pPassword.pBox.pError:setVisible(false)
			pPassword:setVisible(false)
			needCreateGrids = true
			updateGrids()
		else
			pPassword.pBox.pError:setVisible(true)
		end		
	else
		result = net.check_password(ePasswordCaol:getText(), bluePasswordHash)

		if result then 
			passwordBlue = ePasswordCaol:getText()
			pPassword.pBox.pError:setVisible(false)
			pPassword:setVisible(false)
			needCreateGrids = true
			updateGrids()
		else
			pPassword.pBox.pError:setVisible(true)
		end	
	end	
end
    

function onPlayerChangeSlot(id)
    if window and window:getVisible() == true then
        updateGrids()
        updateSpectrators()
    end
end    

function onPlayerConnect(id)
    if window and window:getVisible() == true then
        updateGrids()
        updateSpectrators()
    end
end 

function onPlayerDisconnect(id)
    if window and window:getVisible() == true then
        updateGrids()
        updateSpectrators()
    end
end 

function onSimulationStart()
	needCreateGrids = true
    if window ~= nil then
        setNameMission(DCS.getMissionName())
    end   
	
	if DCS.isTrackPlaying() == false then
		local settings = net.get_server_settings()
		if settings.advanced then
			redPasswordHash = settings.advanced.redPasswordHash
			bluePasswordHash = settings.advanced.bluePasswordHash
		end
	end	
end

function onMissionLoadEnd()
	needCreateGrids = true	
end

function onChange_btnDisconnect() 
    base.START_PARAMS.returnScreen = 'multiplayer'
    waitScreen.setUpdateFunction(function()
		net.stop_game()
		show(false)
		UC.sleep(1000) 
    end)
end

function onChange_btnExit()
    base.START_PARAMS.returnScreen = ''
    net.stop_game()
    show(false)
end

function onChange_btnPlayersPool()
    PlayersPool.show(true)
end

function onChange_btnBriefing()
    local my_info = net.get_player_info(net.get_my_player_id())
    local opt = DCS.getMissionOptions()
    if not(opt and opt.difficulty.spectatorExternalViews == false 
       and my_info.side == 0)  then  
        show(false)
        local unit_type = DCS.getPlayerUnitType()
        if unit_type then DCS.preloadCockpit(unit_type) end
        BriefingDialog.show('Menu')  
    end
end

function onChange_btnChangeMission()
    local path = MeSettings.getMissionPath()
		
    local filters = {FileDialogFilters.mission(), FileDialogFilters.track()}
    local filename = FileDialog.open(path, filters, cdata.openMission)

    base.print("---filename=",filename)
    if filename then
        net.restart(filename)
    end
end

function show(b)
    if window == nil then
        create()
    end

    if b then
		base.START_PARAMS.returnScreen = 'multiplayer'
        updateColumnHeaders()
        updatePlayer()
        updateGrids()
        updateSpectrators()
        Chat.show(true)
        
        if DCS.isServer() == true then
            btnChangeMission:setVisible(true)
        else
            btnChangeMission:setVisible(false)
        end 
		
		if window:getVisible() == false then
			DCS.lockAllMouseInput()
		end

        setNameMission(DCS.getMissionName())
		
		if redPasswordHash ~= nil  then 
			bJoinRed:setVisible(true)
		else
			bJoinRed:setVisible(false)
		end
		
		if bluePasswordHash ~= nil then 
			bJoinBlue:setVisible(true)
		else
			bJoinBlue:setVisible(false)	
		end

    else
        if window:getVisible() == true then
            DCS.unlockMouseInput()
        end
    end   

    window:setVisible(b)    
end

function updatePlayer()
    playerName = nickname:getNickname()
    if playerName == nil then
        sLoginNickname:setText(cdata.Player) 
    else
        sLoginNickname:setText(playerName)  
    end
end


function updateSpectrators()
    local players = net.get_player_list()   
    lbSpectrators:clear()
    for k,playerId in base.pairs(players) do
        local player_info = net.get_player_info(playerId)
        if player_info.side == 0 then
            local newItem = ListBoxItem.new(player_info.name)
            lbSpectrators:insertItem(newItem)
        end
    end
end

function compareFunction(data1, data2)
	if curKeySort == "password" or curKeySort == 'groupName' or curKeySort == 'airdromeName' or curKeySort == 'countryName'
		or curKeySort == 'onboard_num' then
		if data1[curKeySort] == nil and data2[curKeySort] == nil then
			if data1.id == data2.id then
				return data1.multicrew_place < data2.multicrew_place 
			end
			return data1.id < data2.id 
		end
		
		if data1[curKeySort] == nil and data2[curKeySort] ~= nil then
			if sortReverse then
				return true
			end
			return false
		end
		
		if data1[curKeySort] ~= nil and data2[curKeySort] == nil then
			if sortReverse then
				return false
			end
			return true
		end
		
		if data1[curKeySort] == data2[curKeySort] then
			if data1.id == data2.id then
				return data1.multicrew_place < data2.multicrew_place 
			end
			return data1.id < data2.id 
		else
			if sortReverse then
				return textutil.Utf8Compare(data2[curKeySort], data1[curKeySort])
			end
			return textutil.Utf8Compare(data1[curKeySort], data2[curKeySort])
		end
	elseif curKeySort == 'player' then
		if data1['unitId'] == nil and data2['unitId'] == nil then
			if data1.id == data2.id then
				return data1.multicrew_place < data2.multicrew_place 
			end
			return data1.id < data2.id 
		end
		
		if data1['unitId'] == nil and data2['unitId'] ~= nil then
			if sortReverse then
				return true
			end
			return false
		end
		
		if data1['unitId'] ~= nil and data2['unitId'] == nil then
			if sortReverse then
				return false
			end
			return true
		end
		
		local kk1 = playerNameBySlot[data1.unitId] or ""
		local kk2 = playerNameBySlot[data2.unitId] or ""
		if kk1 == kk2 then
			if data1.id == data2.id then
				return data1.multicrew_place < data2.multicrew_place 
			end
			return data1.id < data2.id 
		else
			if sortReverse then
				return textutil.Utf8Compare(kk2, kk1)
			end
			
			return textutil.Utf8Compare(kk1, kk2)
		end
	elseif curKeySort == 'type' or curKeySort == 'role' then
		if data1[curKeySort] == nil and data2[curKeySort] == nil then
			if data1.id == data2.id then
				return data1.multicrew_place < data2.multicrew_place 
			end
			return data1.id < data2.id 
		end
		
		if data1[curKeySort] == nil and data2[curKeySort] ~= nil then
			if sortReverse then
				return true
			end
			return false
		end
		
		if data1[curKeySort] ~= nil and data2[curKeySort] == nil then
			if sortReverse then
				return false
			end
			return true
		end
		
		local kk1 = keys.tabTr[data1[curKeySort]] or keys.getDisplayName(data1[curKeySort])
		local kk2 = keys.tabTr[data2[curKeySort]] or keys.getDisplayName(data2[curKeySort])
		if kk1 == kk2 then
			if data1.id == data2.id then
				return data1.multicrew_place < data2.multicrew_place 
			end
			return data1.id < data2.id 
		else
			if sortReverse then
				return textutil.Utf8Compare(kk2, kk1)
			end
			
			return textutil.Utf8Compare(kk1, kk2)
		end
	end
end

function fillListMultySeatLA(a_redSlots, a_blueSlots )
    MultySeatLAbyId = {}  -- [slot_id] = id плеера сидящего в другом слоте
    for k,v in base.pairs(a_redSlots) do
        local res,unitId = parseUnitId(v.unitId)
        if res == true then
            MultySeatLAbyId[v.unitId] = playerIdBySlot[unitId]
            MultySeatLAbyId[unitId] = playerIdBySlot[v.unitId]  --первый пилот
        end
    end
    
    for k,v in base.pairs(a_blueSlots) do
        local res,unitId = parseUnitId(v.unitId)
        if res == true then
            MultySeatLAbyId[v.unitId] = playerIdBySlot[unitId]
            MultySeatLAbyId[unitId] = playerIdBySlot[v.unitId] --первый пилот
        end
    end
    
    --base.U.traverseTable(MultySeatLAbyId)
   -- base.print("---MultySeatLAbyId----")
end

local function getAirdromeName(a_data)
	local airdromeName
	if a_data.type == a_data.role then
        airdromeName = ""
    elseif a_data.action then
        if a_data.action == 'From Ground Area' then
            airdromeName = _('Ground')
        end
        if a_data.action == 'From Ground Area Hot' then
            airdromeName = _('Ground') 
        end
    elseif a_data.airdromeId then
		if airdromes[a_data.airdromeId].display_name then
			airdromeName = _(airdromes[a_data.airdromeId].display_name) 
		else
			airdromeName = airdromes[a_data.airdromeId].names[locale] or airdromes[a_data.airdromeId].names['en']
		end        
	end
	return a_data.helipadName or airdromeName or _("Air")
end

function check_password(a_unitId, a_hashed_password)
	local result = false
	for k, plain_password in base.pairs(passwords) do
		local bCheck = net.check_password(plain_password, a_hashed_password)
		if bCheck then
			passwordsById[a_unitId] = plain_password
		end
		result = result or bCheck
	end
	return result
end

function updateGrids()
    local redSlotsTMP = DCS.getAvailableSlots("red")
    local blueSlotsTMP = DCS.getAvailableSlots("blue")
	
    airdromes = Terrain.GetTerrainConfig("Airdromes")
 
    local redSlots = {}
    local blueSlots = {}
    
    for k,v in base.pairs(redSlotsTMP) do
		v.airdromeName = getAirdromeName(v)
		local tmp, id = parseUnitId(v.unitId)	
		v.id = id or v.unitId
		
		if passwordRed ~= nil or redPasswordHash == nil then 
			if v.password == nil or check_password(v.unitId, v.password) == true then
				base.table.insert(redSlots, v)
			end	
		end
    end

    for k,v in base.pairs(blueSlotsTMP) do
		v.airdromeName = getAirdromeName(v)
		local tmp, id = parseUnitId(v.unitId)	
		v.id = id or v.unitId
		
		if passwordBlue ~= nil or bluePasswordHash == nil then 
			if v.password == nil or check_password(v.unitId, v.password) == true then
				base.table.insert(blueSlots, v)
			end
		end	
    end
    
	
    base.table.sort(redSlots, compareFunction)
    base.table.sort(blueSlots, compareFunction)
	
--	base.U.traverseTable(redSlots)
--    base.U.traverseTable(blueSlots)
--   base.print("---curKeySort----",curKeySort)
--    base.print("-------gggslots-----")

    myId = net.get_my_player_id() 
 
    local players = net.get_player_list()
    playerNameBySlot = {}
    playerIdBySlot = {}
    local numPlayersBlue = 0 
    local numPlayersRed = 0 
    for k,playerId in base.pairs(players) do
        local player_info = net.get_player_info(playerId)
        --base.U.traverseTable(player_info)
        if player_info.slot ~= "" then
            playerNameBySlot[player_info.slot] = player_info.name
            playerIdBySlot[player_info.slot] = player_info.id
        end
        
        if player_info.side == 2 then
            numPlayersBlue = numPlayersBlue + 1
        end
        
        if player_info.side == 1 then
            numPlayersRed = numPlayersRed + 1
        end
    end
    
    sNumPlayersBlue:setText(numPlayersBlue.." ".._("players"))
    sNumPlayersRed:setText(numPlayersRed.." ".._("players"))
    
    fillListMultySeatLA(redSlots,blueSlots)
  
    if needCreateGrids == true then
        tblRows = {}
        createGrid(gridRed, redSlots)
        createGrid(gridBlue, blueSlots)
    else
        updateGrid(redSlots)
        updateGrid(blueSlots)
    end
end

function updateGrid(a_data)
	rowType = 1
    for n,slot in base.pairs(a_data) do
		if rowType > 3 then
			rowType = 1
		end
		if slot.multicrew_place > 1 then
			rowType = oldRowType
		end
		local is_valid = isValidSlot(slot)
        local cells = tblRows[slot.unitId] --- unitId - на самом деле slotId
		local skinType
		
		if playerIdBySlot[slot.unitId] == myId then
			skinType = 2
        elseif isValidSlot(slot) then        
			skinType = rowType  
		else
			skinType = 4 
		end   
				
        for k, cell in base.pairs(cells) do
            if k == 8 then
                cell:setText(playerNameBySlot[slot.unitId] or "")
            end
			cell.skinType = skinType
            local skin 
            if k == 5 or k == 6 then
                skin = SkinsStatic[skinType].skinAlignMiddle
            elseif k == 1 then
				skin = cell.skin
				if cell.colNum == 1 then						
					if cell.data.password ~= nil then
						if skinType == 2 then
							skin = staticSkinGridServersLockSel
						else
							skin = staticSkinGridServersLock
						end
					else
						if skinType == 2 then
							skin = staticSkinGridServersLockNoSel
						else
							skin = staticSkinGridServersLockNo
						end						
					end	
				end
			else
                skin = SkinsStatic[skinType].skinPadding 
            end
            cell:setSkin(skin)
			cell.skin = skin
        end
		oldRowType = rowType
		rowType = rowType + 2
    end    
end

function createGrid(a_grid, a_data)
    a_grid:removeAllRows()    
    local rowIndex = 0
    rowType = 1
    for k,data in base.pairs(a_data) do
        insertRow(a_grid,data,rowIndex)
        rowIndex = rowIndex +1
    end
    needCreateGrids = false
end

function insertRow(a_grid,a_data, a_rowIndex)
    a_grid:insertRow(rowHeight)
    if rowType > 3 then
        rowType = 1
    end
    
	--[[
    if a_data.role == 'pilot2' then
       rowType = oldRowType
    end
	]]
	
	if a_data.multicrew_place > 1 then
       rowType = oldRowType
    end
	
    local skinType
    if isValidSlot(a_data) then        
        skinType = rowType  
    else
        skinType = 4 
    end    
    
    local cells = {}
   local cell
	------1
	cell = Static.new()
	cell.data = a_data
	cell.skinType = skinType
	if a_data.password ~= nil then 
        tooltipsPas = cdata.passwordEnable
        cell:setSkin(staticSkinGridServersLock)
		cell.skin = staticSkinGridServersLock
    else
        cell:setSkin(staticSkinGridServersLockNo)
		cell.skin = staticSkinGridServersLockNo
    end
   
    cell:setTooltipText(tooltipsPas)
    cell.colNum = 1
	base.table.insert(cells,cell)
    a_grid:setCell(0, a_rowIndex, cell)
   
    ------2
    cell = Static.new() 
    cell.data = a_data
    cell.skinType = skinType
    cell:setSkin(SkinsStatic[skinType].skinPadding)  
    cell.skin = SkinsStatic[skinType].skinPadding 
    cell.colNum = 2
	
	if a_data.multicrew_place > 1 then
        cell:setText("")
    else
        cell:setText(a_data.groupName)
    end
	
    base.table.insert(cells,cell)
    a_grid:setCell(1, a_rowIndex, cell)

    ------3
    cell = Static.new()
    cell.data = a_data
    cell.skinType = skinType
    cell:setSkin(SkinsStatic[skinType].skinPadding)
    cell.skin = SkinsStatic[skinType].skinPadding 
    cell.colNum = 3
	

	
	if a_data.multicrew_place > 1 then
        cell:setText("")
    else
        cell:setText(keys.tabTr[a_data.type] or keys.getDisplayName(a_data.type))  
    end
		
    base.table.insert(cells,cell)  
 --   local tooltipsPas = cdata.passwordDisable      
 --   cell:setTooltipText(tooltipsPas)
    a_grid:setCell(2, a_rowIndex, cell)
    
    ------4
    cell = Static.new()
    cell.data = a_data
    cell.skinType = skinType
    cell:setSkin(SkinsStatic[skinType].skinPadding)
    cell.skin = SkinsStatic[skinType].skinPadding 
    cell:setText(keys.tabTr[a_data.role] or a_data.role)
    cell.colNum = 4
    a_grid:setCell(3, a_rowIndex, cell)
    base.table.insert(cells,cell)
    
    ------5
    cell = Static.new()
    cell.data = a_data
    cell.skinType = skinType
    cell:setSkin(SkinsStatic[skinType].skinAlignMiddle)
    cell.skin = SkinsStatic[skinType].skinAlignMiddle
    cell.colNum = 5
    cell:setText(keys.tabCountries[a_data.countryName] or a_data.countryName)
    a_grid:setCell(4, a_rowIndex, cell)
    base.table.insert(cells,cell)
    
    ------6
    cell = Static.new()
    cell.data = a_data
    cell.skinType = skinType
    cell:setSkin(SkinsStatic[skinType].skinAlignMiddle)
    cell.skin = SkinsStatic[skinType].skinAlignMiddle
    cell.colNum = 6
    cell:setText(a_data.onboard_num)
    a_grid:setCell(5, a_rowIndex, cell)
    base.table.insert(cells,cell)
    
    ------7
    cell = Static.new()
    cell.data = a_data
    cell.skinType = skinType
    cell:setSkin(SkinsStatic[skinType].skinPadding)
    cell.skin = SkinsStatic[skinType].skinPadding  
    cell.colNum = 7
	
	if a_data.airdromeId and a_data.parking_id then
		cell:setText(a_data.airdromeName.." - "..a_data.parking_id) 
	else
		cell:setText(a_data.airdromeName) 
	end

    a_grid:setCell(6, a_rowIndex, cell)
    base.table.insert(cells,cell)
    
    ------8
    cell = Static.new()
    cell.data = a_data
    cell.skinType = skinType
    cell:setSkin(SkinsStatic[skinType].skinPadding)
    cell.skin = SkinsStatic[skinType].skinPadding 
    cell:setText(playerNameBySlot[a_data.unitId] or "")
    cell.colNum = 8
    a_grid:setCell(7, a_rowIndex, cell) 
    base.table.insert(cells,cell)    
    tblRows[a_data.unitId] = cells --- unitId - на самом деле slotId 
    oldRowType = rowType
    rowType = rowType + 2
         
end

function update(a_serverlist,a_force) 

end

function updateColumnHeaders()
    updateColumnHeader(gridBlue)
    updateColumnHeader(gridRed)
end

local function getColumnHeaderSkin(a_key, a_index)
    if a_index == 3 or a_index == 4 then
        groupSkin = 1
    else
        groupSkin = 2
    end
	
	local skinKey = 'skinNoSort'
	if curKeySort == a_key then
		if sortReverse then
			skinKey = 'skinSortDown'
		else
			skinKey = 'skinSortUp'
		end
	end
    
	return SkinsHeaders[groupSkin][skinKey]
end

function updateColumnHeader(a_grid)
    local count = a_grid:getColumnCount()
	
	for i = 1, count - 1 do
		local gridHeaderCell = a_grid:getColumnHeader(i)
		
		if gridHeaderCell then
			local skin = getColumnHeaderSkin(gridHeaderCell.KeySort, i)
			
			if skin then
				gridHeaderCell:setSkin(skin)
			end
		end
	end
end

function getVisible()
    if window then
        return window:getVisible()
    end
    return false    
end

function setNameMission(a_text)
    sNameMission:setText(_("Mission")..": "..a_text)
end 

function onEsc()
    local my_info = net.get_player_info(net.get_my_player_id())
    local opt = DCS.getMissionOptions()
    if not(opt and opt.difficulty.spectatorExternalViews == false 
       and my_info.side == 0)  then  
        net.spawn_player()
        show(false)
        DCS.setViewPause(false)
    end
end

function isMulticrewOkaySlot(a_data)
	local multicrew_place = a_data.multicrew_place
	if not multicrew_place or multicrew_place == 1 then return true end
	local res, unit_id, nope = parseUnitId(a_data.unitId)
	if not res then return true end
	local player_name = playerNameBySlot[unit_id]
	if not player_name or player_name == "" or player_name == playerName then return false end
	return true
end

function resetPasswords()
	passwordRed = nil
	passwordBlue = nil
	passwords = {}
	passwordsById = {}
end