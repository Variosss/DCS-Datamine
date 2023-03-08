local base = _G

module('mul_controlRequest')

local require = base.require
local table = base.table
local string = base.string
local print = base.print

local DialogLoader      = require('DialogLoader')
local Gui               = require('dxgui')
local net               = require('net')
local guiUpdateManager  = require('UpdateManager')
local DCS				= require('DCS')

require('i18n').setup(_M)

cdata = {

    allow   = _("Allow"),
    deny    = _("Deny"),
}

local listWantedToPlane = {} -- желающие присоединиться к ЛА игрока
local playerName

function create()
    local w, h = Gui.GetWindowSize()
    window = DialogLoader.spawnDialogFromFile("MissionEditor/modules/dialogs/mul_controlRequest.dlg", cdata)    
    window:centerWindow()
    window:setPosition(0, h/2)
	
    pQuery      = window.pQuery
    bAllow      = pQuery.bAllow
    bDeny       = pQuery.bDeny
    sQuery      = pQuery.sQuery
        
    bAllow.onChange = onChange_bAllow
    bDeny.onChange = onChange_bDeny
end


local function getPlayerName(a_player)
	if not a_player then 
		return _("someone")   
	end
    local player_info = net.get_player_info(a_player)
    if not player_info then
		return _("someone")   
	end
	return player_info.name or base.tostring(id)
end


function show(b, a_player) --a_player - id  игрока или имя
    if b == true then
		if  not window then
			create()
		end  
        sQuery:setText(getPlayerName(a_player).." ".._("Requests control."))
    end
	if  window then
		window:setVisible(b)
	end
end


function onChange_bAllow()
	if feedback then	
	   feedback(true)
	end
    show(false)
end

function onChange_bDeny()
	if feedback then	
	   feedback(false)
	end
    show(false)
end

local info_take_control_window 
local info_take_control_request_window 
local info_crew_member_attach 

local popup_autohide = function(dlg)

	dlg.time_on = base.os.clock()
    dlg:setVisible(true)
	
	guiUpdateManager.add(function()
	
		if not dlg or 
		   not dlg:getVisible() then	
			return true
		end

		local t = base.os.clock()
		
		if t - dlg.time_on > 4.0 then
			dlg:setVisible(false)
			return true
		end
		return false
	end)	
end

local function hideControlRequest(a_player)
	local wnd = info_take_control_request_window
	if  wnd and 
		wnd:getVisible() then
		
		if  a_player ~= nil then
			if  wnd.a_player == nil or  
				wnd.a_player ~= a_player then 
				return
			end
		end
		
		wnd:setVisible(false)
		wnd.a_player = nil
	end
end


local function load_info_take_control(dy)
	local info = DialogLoader.spawnDialogFromFile("MissionEditor/modules/dialogs/mul_info_take_control.dlg", cdata)    
	local w, h = Gui.GetWindowSize()
	info:centerWindow()
	info:setVisible(false)
	local x,y = info:getPosition()
	
	local dy = dy or 0
	
	local wd,hd = info:getSize()
	
	info:setPosition(x, h/4 + (hd + 8) * dy)
	return info
end

function showRequestControlTo(a_player)
	if not info_take_control_request_window then
		   info_take_control_request_window = load_info_take_control()    
   	end
	
	if not info_take_control_request_window then 
		base.error("no info_take_control_request_window")
		return
	end
	info_take_control_request_window:setVisible(true)
	info_take_control_request_window.a_player = a_player
	info_take_control_request_window.info:setText(_("Requested Control From").." "..getPlayerName(a_player))
	
	guiUpdateManager.add(function ()
		if not info_take_control_request_window or 
		   not info_take_control_request_window:getVisible() then
			return true
		end
		
		if 	DCS.getSimulatorMode() ~= 4 then --dModeWork
			hideControlRequest()
			return true
		end
		return false
	end)
	
end


function onAttach(a_player,role,attach)
	if not info_crew_member_attach then
		info_crew_member_attach = load_info_take_control(-1)    
   	end

	if attach then
		if net.get_my_player_id() == a_player then
			info_crew_member_attach.info:setText(_("You've joined the crew as ")..role)
		else
			info_crew_member_attach.info:setText(getPlayerName(a_player) .." ".. _("has joined the crew as ")..role)
		end		
	elseif net.get_my_player_id() == a_player then
		info_crew_member_attach.info:setText(_("You have left the crew"))
		hideControlRequest()
	else
		info_crew_member_attach.info:setText(getPlayerName(a_player) ..", "..role.. _(', has left the crew'))
		hideControlRequest(a_player)
	end

	popup_autohide(info_crew_member_attach)
end

function onHaveControl(a_player)
	if not info_take_control_window then
		info_take_control_window = load_info_take_control()    
   	end
	
	if not info_take_control_window then 
		base.error("no info_take_control_window")
		return
	end
	
	hideControlRequest()
	
	if net.get_my_player_id() == a_player then
		info_take_control_window.info:setText(_("You Have Control"))
	else
		info_take_control_window.info:setText(getPlayerName(a_player) .. " ".._("Has Control"))
	end	
	
	
	popup_autohide(info_take_control_window)
end

