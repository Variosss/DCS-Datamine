local base = _G

local DCS = require('DCS')
local net = require('net')
local VoiceChat = require("VoiceChat")

local function parseUnitId(a_unitId)
    local pos = string.find(string.reverse(a_unitId), '_');        
    if pos then
        local unitId = string.sub(a_unitId, 1, -pos -1);
        local place = string.sub(a_unitId,-pos+1)
        return true,unitId,place
    end

    return false
end

function onPlayerChangeSlot(id)
	if ((DCS.isMultiplayer() == true) and (DCS.isTrackPlaying() ~= true)) then
		if (id == net.get_my_player_id()) then
			local playerInfo = net.get_player_info(id)
			local res,unitId = parseUnitId(playerInfo.slot)
			if res == false then
				unitId = playerInfo.slot
			end
			--base.U.traverseTable(playerInfo)
			VoiceChat.changeSlot(playerInfo.side, unitId)
		end
	end 
end

local voiceChatCallbacks = {}
voiceChatCallbacks.onPlayerChangeSlot = onPlayerChangeSlot
DCS.setUserCallbacks(voiceChatCallbacks)