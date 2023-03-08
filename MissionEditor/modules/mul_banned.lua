local base = _G



module('mul_banned')

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
local DialogLoader      = require('DialogLoader')
local net               = require('net')


i18n.setup(_M)


cdata = 
{
	BanReason        	= _('Ban reason'),
	BanDuration      	= _('Ban duration'),
	Month            	= _('Month'),
	Week           	 	= _('Week'),
	Day           	 	= _('Day'),
	Hour           	 	= _('Hour'),
	Cancel           	= _('Cancel'),
	Ban           	 	= _('Ban'),
	BanForever          = _('Ban forever'),
	Caption				= _('Banned user'),
}

local id = nil

-------------------------------------------------------------------------------
-- 
function create()
	window = DialogLoader.spawnDialogFromFile("MissionEditor/modules/dialogs/mul_banned.dlg", cdata)   

	window:centerWindow()
	
	pBox  			= window.main_panel.pBox
	btnBan      	= window.main_panel.btnBan
    btnCancel   	= window.main_panel.btnCancel
	
	sCaption		= pBox.sCaption
	spMonth			= pBox.spMonth
	spWeek			= pBox.spWeek
	spDay			= pBox.spDay
	spHour			= pBox.spHour
	cbBanForever	= pBox.cbBanForever
	eBanReason		= pBox.eBanReason
	
	
	btnCancel.onChange = onChange_btnCancel
    btnBan.onChange = onChange_btnBan
end

-------------------------------------------------------------------------------
--
function show(b, a_id)
	--base.print("--mul_banned, show---",b,a_id)
    if window == nil then
        create()
    end  
	
	if b then
		id = a_id
		if id then
			local player_info = net.get_player_info(id)
			--base.print("-player_info---",player_info)
			sCaption:setText(cdata.Caption.." - "..player_info.name)
		end
		eBanReason:setText()
		spMonth:setValue(0)
		spWeek:setValue(0)
		spDay:setValue(0)
		spHour:setValue(1)
		cbBanForever:setState(false)
	end

    window:setVisible(b)  	
end

function onChange_btnCancel()
	show(false)
end

function onChange_btnBan()
	if id then
		local ban_period = spHour:getValue() * 60 * 60 + spDay:getValue() * 24 * 60 * 60 + spWeek:getValue() * 7 * 24 * 60 * 60 + spMonth:getValue() * 31 * 24 * 60 * 60
		
		if cbBanForever:getState() == true then
			ban_period = 16293600000
		end
		--base.print("--ban_period--",id,ban_period, eBanReason:getText())
		net.banlist_add(id, ban_period, eBanReason:getText())
	end
	show(false)
end

