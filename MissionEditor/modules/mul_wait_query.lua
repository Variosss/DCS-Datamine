local base = _G

module('mul_wait_query')

local require = base.require
local table = base.table
local string = base.string
local print = base.print

local DialogLoader      = require('DialogLoader')
local Gui               = require('dxgui')
local RPC               = require('RPC')
local net               = require('net')
local UpdateManager		= require('UpdateManager')

require('i18n').setup(_M)

cdata = {
    Wait        = _("Pending request to"),
    cancel		= _('Cancel'),
}

function create()
    w, h = Gui.GetWindowSize()
    window = DialogLoader.spawnDialogFromFile("MissionEditor/modules/dialogs/mul_wait_query.dlg", cdata)    
    window:setBounds(0, 0, w, h)
    
    pBox = window.pBox
    bCancel = pBox.bCancel
	sWait = pBox.sWait
	sNick = pBox.sNick
    
    bCancel.onChange = onChange_bCancel
    
    local boxW,boxH = pBox:getSize()
    pBox:setPosition((w-boxW)/2, (h-boxH)/2)
end


function show(b, a_idMaster)
    if window == nil and b == false then
        return
    end
    
    if window == nil then
        create()
    end  
	
	if b then
		if a_idMaster ~= nil then 
			local player_info = net.get_player_info(a_idMaster)	
			sNick:setText((player_info and player_info.name) or "")
		else	
			sNick:setText(" ")
		end
	end
    
    window:setVisible(b)
end

function onChange_bCancel()
    RPC.sendEvent(net.get_server_id(), "releaseSeat", net.get_my_player_id())
    show(false)
end

function slotGivenToPlayer(playerMaster_id)
	show(false)	
	show_infoPanel("Given", playerMaster_id)
end

function slotDenialToPlayer(playerMaster_id)
    show(false)
	show_infoPanel("Denial", playerMaster_id)
end

function onPlayerChangeSlot(id)

end

local function load_infoPanel()
	infoPanel = DialogLoader.spawnDialogFromFile("MissionEditor/modules/dialogs/mul_query_infoPanel.dlg", cdata)    
	infoPanel:centerWindow()
	sText = infoPanel.sText
	infoPanel:setVisible(false)
end

function update_infoPanel()
	if not infoPanel then	
		return true
	end

	local t = base.os.clock()
	
	if t - infoPanel.time_on > 5 then
		infoPanel:setVisible(false)
		return true
	end
	return false
end

function show_infoPanel(a_type, playerMaster_id)
	if not infoPanel then
		load_infoPanel()
	end
	
	local player_info = net.get_player_info(playerMaster_id)
	local name = (player_info and player_info.name) or _("UNKNOWN")
	
	if a_type == "Given" then
		sText:setText(_("Access granted\nby").." "..name)
	elseif a_type == "Denial" then
		sText:setText(_("From").." "..name..":\n".._("DENIED"))
	end
	
	infoPanel.time_on = base.os.clock()
	infoPanel:setVisible(true)
	UpdateManager.add(update_infoPanel)	
end
