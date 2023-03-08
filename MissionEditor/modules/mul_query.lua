local base = _G

module('mul_query')

local require = base.require
local table = base.table
local string = base.string
local print = base.print
local tonumber = base.tonumber
local floor = base.math.floor

local DialogLoader      = require('DialogLoader')
local Gui               = require('dxgui')
local ListBoxItem       = require('ListBoxItem')
local RPC               = require('RPC')
local net               = require('net')
local DCS               = require('DCS')

require('i18n').setup(_M)

cdata = {
    query           = _("Join requests:"),
    allow_selected  = _("ACCEPT"),
    deny_all        = _("DENY ALL"),
}

local listWantedToPlane = {} -- желающие присоединиться к ЛА игрока

local function parseUnitId(a_unitId)
    local pos = string.find(string.reverse(a_unitId), '_')
    if pos then
        local unitId = string.sub(a_unitId, 1, -pos -1)
        local place = string.sub(a_unitId,-pos+1)
        return true,unitId,place
    elseif tonumber(a_unitId) ~= nil and tonumber(a_unitId) == floor(tonumber(a_unitId)) then
		local unitId = a_unitId
		local place = 1
		return true,unitId,place
	end
    return false
end


function create()
    w, h = Gui.GetWindowSize()
    window = DialogLoader.spawnDialogFromFile("MissionEditor/modules/dialogs/mul_query.dlg", cdata)    
    window:setPosition(0, h/2)
    
    pQuery      = window.pQuery
    bAllowSelected = pQuery.bAllowSelected
    bDenyAll    = pQuery.bDenyAll
    lbPlayers   = pQuery.lbPlayers
        
    bAllowSelected.onChange = onChange_bAllowSelected
    bDenyAll.onChange = onChange_bDenyAll
    lbPlayers.onChange = onChange_lbPlayers
    
 
   --[[
    for k=0,9 do
        local newItem = ListBoxItem.new("Chizh")
        lbPlayers:insertItem(newItem)
    end]]

end


function show(b)
    if window == nil and b == false then
        return
    end

    if window == nil then
        create()
    end  
    
    window:setVisible(b)
end


function slotWanted(server_id, player_id, slot_id) -- у хозяина ЛА    
    local player_info = net.get_player_info(player_id)
	local old_success,newID,seat = parseUnitId(slot_id)
	local new_success,oldID = parseUnitId(player_info.slot)
	if newID == oldID then
		local seat_int = floor(tonumber(seat))
		if DCS.isHumanSeatAvailable(seat_int - 1) then
			RPC.sendEvent(net.get_server_id(), "slotGiven", player_id, net.get_player_info(net.get_my_player_id()).side, slot_id)
			local remaining = 0
			for k,v in base.pairs(listWantedToPlane) do
				if v.slot_id == slot_id then
					RPC.sendEvent(net.get_server_id(), "slotDenial", v.id)
				else
					remaining = remaining + 1
				end
			end
			if remaining == 0 then
				show(false)
			end
		end
	else
		listWantedToPlane[player_id] = {}
		listWantedToPlane[player_id].name       = player_info.name
		listWantedToPlane[player_id].id         = player_id
		listWantedToPlane[player_id].slot_id    = slot_id
		listWantedToPlane[player_id].side       = net.get_player_info(net.get_my_player_id()).side
	
		show(true)
	end
	updateLBWanted()
end

function updateLBWanted()
    if window == nil then
        return
    end  
    lbPlayers:clear()
 --[[    for k=0,9 do
        local newItem = ListBoxItem.new("Chizh")
        lbPlayers:insertItem(newItem)
    end]]
    for k,v in base.pairs(listWantedToPlane) do
        local newItem = ListBoxItem.new(v.name)
        newItem.id = v.id
        newItem.side = v.side
        newItem.slot_id = v.slot_id
        lbPlayers:insertItem(newItem)
    end
	if lbPlayers:getSelectedItem() == nil then
		bAllowSelected:setEnabled(false)
	else
		bAllowSelected:setEnabled(true)
	end
end

function onChange_lbPlayers()
	bAllowSelected:setEnabled(true)
end

local function is_empty(t)
    for k,v in base.pairs(t) do
        return false
    end
    return true
end

function onChange_bAllowSelected()
    local item = lbPlayers:getSelectedItem()
    if item then
        RPC.sendEvent(net.get_server_id(), "slotGiven", item.id, item.side, item.slot_id)
        -- очищаем все запросы
        listWantedToPlane[item.id] = nil
        for k,v in base.pairs(listWantedToPlane) do
			if v.slot_id == item.slot_id then
				RPC.sendEvent(net.get_server_id(), "slotDenial", v.id)
				listWantedToPlane[v.id] = nil
			end
        end
        updateLBWanted()
		if is_empty(listWantedToPlane) then
			show(false)
		end
    end
 
end

function onChange_bDenyAll()
    for k,v in base.pairs(listWantedToPlane) do
        RPC.sendEvent(net.get_server_id(), "slotDenial", v.id)            
    end
    listWantedToPlane = {}
    updateLBWanted()

    show(false)
end

function releaseSeatToMaster(player_id) 
    listWantedToPlane[player_id] = nil
    updateLBWanted()

	local noWanted = true
	for k,v in base.pairs(listWantedToPlane) do
		noWanted = false
	end
    if noWanted == true then
        show(false)
    end
end

