local base = _G

module('mul_unbanned')

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
local Button			= require('Button')
local Static            = require('Static')
local Panel 			= require('Panel')
local CheckBox			= require('CheckBox')
local UpdateManager	    = require('UpdateManager')

i18n.setup(_M)


cdata = 
{
	BANNED				= _('BANNED'),
	Cancel           	= _('Cancel'),
	banned_until		= _('Banned until'),
	Users				= _('Users'),
	unbanSelected		= _('Unban selected'),
	Unbanned			= _('Unban player'),
	banned_from			= _('Banned from'),
	reason				= _('Reason'),
}


local id = nil
local bannedUsersCheckboxs = {}

-------------------------------------------------------------------------------
-- 
function create()
	window = DialogLoader.spawnDialogFromFile("MissionEditor/modules/dialogs/mul_unbanned.dlg", cdata)   

	window:centerWindow()
	

    btnCancel   = window.main_panel.pBox.btnCancel
	spPanel		= window.main_panel.pBox.spPanel
	eInfo		= window.main_panel.pBox.eInfo
	btnUnban	= window.main_panel.pBox.btnUnban
	
	
	
	pNoVisible  = window.pNoVisible

	staticSkin = pNoVisible.staticSkin:getSkin()
	btnSkin = pNoVisible.btnSkin:getSkin()
	cbSelectSkin = pNoVisible.cbSelect:getSkin()
	
	pUserSkin	= pNoVisible.pUserSkin:getSkin()
	
	btnCancel.onChange = onChange_btnCancel
	btnUnban.onChange = onChange_btnUnban
	
end

-------------------------------------------------------------------------------
--
function show(b, a_id)
	--base.print("-mul_unbanned-show---",b,a_id)
    if window == nil then
        create()
    end  
	
	if b then
		updateListBanned()
	end

    window:setVisible(b)  	
end

function updateListBanned()
	local list = net.banlist_get()
	--base.U.traverseTable(list)
	--base.print("---updateListBanned---")
	
	-- TEST
	--[[
		ucid
		ipaddr
		name
		reason
		banned_from
		banned_until
	--]]
	--[[
	list = {
	[1] = { ucid = 1,name = "11111", banned_until = 1541385563, banned_from =1532385563, reason = "1s111"},
	[2] = { ucid = 2,name = "22222", banned_until = 1542385563, banned_from = 1522385563, reason = "3s111"},
	[3] = { ucid = 3,name = "333333", banned_until = 1544385563, banned_from = 1512385563, reason = "4s111"},
	[4] = { ucid = 1,name = "11111", banned_until = 1541385563, banned_from =1532385563, reason = "1s111"},
	[5] = { ucid = 2,name = "22222", banned_until = 1542385563, banned_from = 1522385563, reason = "3s111"},
	[6] = { ucid = 3,name = "333333", banned_until = 1544385563, banned_from = 1512385563, reason = "4s111"},
	[7] = { ucid = 1,name = "11111", banned_until = 1541385563, banned_from =1532385563, reason = "1s111"},
	[8] = { ucid = 2,name = "22222", banned_until = 1542385563, banned_from = 1522385563, reason = "3s111"},
	[9] = { ucid = 3,name = "333333", banned_until = 1544385563, banned_from = 1512385563, reason = "4s111"},
	[10] = { ucid = 1,name = "11111", banned_until = 1541385563, banned_from =1532385563, reason = "1s111"},
	[11] = { ucid = 2,name = "22222", banned_until = 1542385563, banned_from = 1522385563, reason = "3s111"},
	[12] = { ucid = 3,name = "333333", banned_until = 1544385563, banned_from = 1512385563, reason = "4s111"},
	[13] = { ucid = 1,name = "11111", banned_until = 1541385563, banned_from =1532385563, reason = "1s111"},
	[14] = { ucid = 2,name = "22222", banned_until = 1542385563, banned_from = 1522385563, reason = "3s111"},
	[15] = { ucid = 3,name = "333333", banned_until = 1544385563, banned_from = 1512385563, reason = "4s111"},
	[16] = { ucid = 2,name = "22222", banned_until = 1542385563, banned_from = 1522385563, reason = "3s111"},
	[17] = { ucid = 3,name = "333333", banned_until = 1544385563, banned_from = 1512385563, reason = "4s111"},
	
	}
	--]]
	spPanel:clear()
	
	local rowIndex = 0
	local num = 0
	bannedUsersCheckboxs = {}
	
	if list == nil then
		return
	end
		
	for k,v in base.pairs(list) do
		createRow(v, num*20, 20)
		num = num + 1
	end
end

function onChange_btnCancel()
	show(false)
end

-- разбан всех выбранных
function onChange_btnUnban()
	for k, v in base.pairs(bannedUsersCheckboxs) do
		if v:getState() == true then
			--base.print("---onChange_btnUnban---",k)
			net.banlist_remove(k)
		end
	end
	updateListBanned()
	show(false)
end

function createRow(a_data, a_y, a_h)
	
	local pUserPanel
	pUserPanel = Panel.new()
	pUserPanel:setBounds(0,a_y,720,a_h)
	pUserPanel:setSkin(pUserSkin)
	spPanel:insertWidget(pUserPanel)
	
	local cbSelect = CheckBox.new()
	cbSelect:setSkin(cbSelectSkin)
    cbSelect:setBounds(20,0,20,20)	
	pUserPanel:insertWidget(cbSelect)
	
	local sNameUser = Static.new()
	sNameUser:setSkin(staticSkin)
    sNameUser:setBounds(60,0,300,20)
	sNameUser:setText(a_data.name)		
	pUserPanel:insertWidget(sNameUser)
	
	local sBannedUntil = Static.new()
	sBannedUntil:setSkin(staticSkin)
    sBannedUntil:setBounds(360,0,200,20)
	sBannedUntil:setText(base.os.date('%d-%b-%Y %H:%M', a_data.banned_until))		
	pUserPanel:insertWidget(sBannedUntil)
	
	local btnUnbanned = Button.new()
	btnUnbanned:setSkin(btnSkin)
    btnUnbanned:setBounds(560,0,180,20)
	btnUnbanned:setText(cdata.Unbanned)	
	btnUnbanned.data = a_data
	pUserPanel:insertWidget(btnUnbanned)
	btnUnbanned.onChange = function(self)
		--base.print("---btnUnbanned.onChange---",self.data.ucid)
		UpdateManager.add(function()
			net.banlist_remove(self.data.ucid)
			updateListBanned()			
			return true
		end)		
	end
	bannedUsersCheckboxs[a_data.ucid] = cbSelect
	
end






