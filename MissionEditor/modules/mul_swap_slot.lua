local base = _G

module('mul_swap_slot')

local require = base.require
local table = base.table
local string = base.string
local print = base.print
local tostring = base.tostring
local pairs = base.pairs
local tonumber = base.tonumber
local floor = base.math.floor

local DialogLoader      = require('DialogLoader')
local Gui               = require('dxgui')
local net               = require('net')
local guiUpdateManager  = require('UpdateManager')

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

--[[
function try_swap_slot(num)
	local side, slotID = net.get_slot(net.get_my_player_id())
	local success,uintID,place = parseUnitId(slotID)
	if success and place ~= num then
		local new_slot = uintID .. "_" .. num
		local player_list = net.get_player_list()
		local busy = false
		local player_side = 0
		local player_slot = 0
		for i,another_player in pairs(player_list) do
			player_side, player_slot = net.get_slot(another_player)
			if side == player_side and new_slot == player_slot then
				busy = true
				break
			end
		end
		if not busy then
			net.set_slot(side, new_slot)
			return true
		else
			return false
		end
	else
		return false
	end
end
]]

function check_slot_free(num)
	local side, slotID = net.get_slot(net.get_my_player_id())
	local success,uintID,place = parseUnitId(slotID)
	if success and place ~= num then
		local new_slot = uintID .. "_" .. num
		local player_list = net.get_player_list()
		local player_side = 0
		local player_slot = 0
		for i,another_player in pairs(player_list) do
			player_side, player_slot = net.get_slot(another_player)
			if side == player_side and new_slot == player_slot then
				return false
			end
		end
		return true
	end
	return false
end

function try_swap_slot(num)
	local side, slotID = net.get_slot(net.get_my_player_id())
	local success,uintID,place = parseUnitId(slotID)
	if success and place ~= num then
		local new_slot = uintID .. "_" .. num
		net.set_slot(side, new_slot)
	end
end