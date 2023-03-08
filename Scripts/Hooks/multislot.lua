local RPC               = require('RPC')
local net               = require('net')

local listWanted	 	= {}
local MultySeatLAbyId 	= {}


local function parseUnitId(a_unitId)
    local pos = string.find(string.reverse(a_unitId), '_');        
    if pos then
        local unitId = string.sub(a_unitId, 1, -pos -1);
        local place = string.sub(a_unitId,-pos+1)
        return true,unitId,place
    end

    return false
end

function RPC.method.slotGiven(playerMaster_id, player_id, side, slot_id)
    if DCS.isTrackPlaying() == true then
        return
    end
    print("------- RPC.method.slotGiven------",playerMaster_id, player_id, side, slot_id)
    if isEnablePlayerTryChangeSlot(player_id,playerMaster_id) then
        print("-------force_player_slot---",player_id, side, slot_id)
		local old_side,old_slot = net.get_slot(player_id)
		local success1,old_LA,old_Seat = parseUnitId(old_slot)
		local success2,new_LA,new_Seat = parseUnitId(slot_id)
        net.force_player_slot(player_id, side, slot_id)
		if old_LA ~= new_LA then
			RPC.sendEvent(player_id, "slotGivenToPlayer", playerMaster_id)
		end
    end
end

function RPC.method.slotDenial(playerMaster_id, player_id)
    if DCS.isTrackPlaying() == true then
        return
    end
    print("------- RPC.method.slotDenial------",playerMaster_id, player_id)

	if listWanted[player_id] then
        listWanted[player_id] = nil
        RPC.sendEvent(player_id, "slotDenialToPlayer", playerMaster_id)
    end 
end

function RPC.method.releaseSeat(playerMaster_id, player_id)
    if DCS.isTrackPlaying() == true then
        return
    end
    print("------- RPC.method.releaseSeat------",playerMaster_id, player_id)    

	if listWanted[player_id] then
        RPC.sendEvent(listWanted[player_id],"releaseSeatToMaster", player_id)
        listWanted[player_id] = nil
    end
end

function onPlayerTryChangeSlot(player_id, side, slot_id)
    print("---onPlayerTryChangeSlot-----",player_id, side, slot_id)
	updateData()
	--если одноместный то сажаем,  если многоместный то запрос
    local playerMaster = getPlayerMaster(slot_id)
    if playerMaster and playerMaster ~= player_id then
        listWanted[player_id] = playerMaster
        print("---RPC.sendEvent()",playerMaster, "slotWanted", player_id, slot_id)
        RPC.sendEvent(playerMaster, "slotWanted", player_id, slot_id)
        return false
    else
        return true
    end
end


function isEnablePlayerTryChangeSlot(player_id, playerMaster_id)
    --U.traverseTable(listWanted)
    print("---isEnablePlayerTryChangeSlot--true-",player_id, playerMaster_id,listWanted[player_id])
    if listWanted[player_id] and listWanted[player_id] == playerMaster_id then
        print("---isEnablePlayerTryChangeSlot--true-",player_id)
        return true
    end
    return false
end

function onSimulationStart()
    print("------- onSimulationStart--ссс----")
	listWanted = {}
end


function updateData()
    local redSlots = DCS.getAvailableSlots("red")
    local blueSlots = DCS.getAvailableSlots("blue")
 
    local players = net.get_player_list()
    playerIdBySlot = {}

    for k,playerId in pairs(players) do
        local player_info = net.get_player_info(playerId)
        --U.traverseTable(player_info)
        if player_info.slot ~= "" then
            playerIdBySlot[player_info.slot] = player_info.id
        end
    end

    MultySeatLAbyId = {}  -- [slot_id] = id плеера сидящего в другом слоте
    for k,v in pairs(redSlots) do
        local res,unitId = parseUnitId(v.unitId)
        if res == true then
            MultySeatLAbyId[v.unitId] = playerIdBySlot[unitId]
            MultySeatLAbyId[unitId] = playerIdBySlot[v.unitId]  --первый пилот
        end
    end
    
    for k,v in pairs(blueSlots) do
        local res,unitId = parseUnitId(v.unitId)
        if res == true then
            MultySeatLAbyId[v.unitId] = playerIdBySlot[unitId]
            MultySeatLAbyId[unitId] = playerIdBySlot[v.unitId] --первый пилот
        end
    end
end	


function getPlayerMaster(a_unitId)
    return MultySeatLAbyId[a_unitId]
end





local hooks = {}
hooks.onSimulationStart = onSimulationStart
hooks.onPlayerTryChangeSlot = onPlayerTryChangeSlot
DCS.setUserCallbacks(hooks)