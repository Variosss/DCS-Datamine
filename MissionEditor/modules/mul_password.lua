local base = _G

module('mul_password')

local require       	= base.require
local pairs         	= base.pairs
local table         	= base.table
local math          	= base.math
local loadfile      	= base.loadfile
local setfenv       	= base.setfenv
local string        	= base.string
local assert        	= base.assert
local io            	= base.io
local loadstring    	= base.loadstring
local print         	= base.print
local os            	= base.os

local i18n 				= require('i18n')
local U                 = require('me_utilities')
local DialogLoader      = require('DialogLoader')
local net               = require('net')
local UpdateManager	    = require('UpdateManager')
local TheatreOfWarData  = require('Mission.TheatreOfWarData')
local MsgWindow         = require('MsgWindow')
local modulesInfo       = require('me_modulesInfo')

i18n.setup(_M)

cdata =
{
    Password                    = _("Password"),
    Connection_to_server        = _("Connection to server"),
    IPURL                       = _("IP/URL"),
    IncorrectPassword           = _("Incorrect password"),
}

local bCreated = false
local window
local serverName
local serverAdvanced

-------------------------------------------------------------------------------
-- 
function create()
    window = DialogLoader.spawnDialogFromFile('MissionEditor/modules/dialogs/mul_password.dlg', cdata)

    local main_w = base.main_w
    local main_h = base.main_h
    
    local box = window.Box
    btnOk       = box.btnOk
    ePassword   = box.ePassword
    eIP         = box.eIP
    bCancel     = box.bCancel
    pError      = box.pError
    
    local win_w
    local win_h
    win_w, win_h = box:getSize()
    
    window:setBounds(0, 0, main_w, main_h)
    box:setBounds((main_w - win_w)/2, (main_h - win_h)/2, win_w, win_h)
    
    btnOk.onChange = onChange_btnOk
    bCancel.onChange = onChange_bCancel
    
    ePassword:addKeyDownCallback(keyDownCallback)
    
    window:addHotKeyCallback('return'	, onChange_btnOk)

    bCreated = true
end

-------------------------------------------------------------------------------
-- 
function onChange_btnOk()  
	if onlyConnect == true then
		pError:setVisible(false)
		if callback then
			if callback(eIP:getText() ,ePassword:getText(), serverName, serverAdvanced) == true then
				--show(false)
			else
				pError:setVisible(true)
			end
		else	
			show(false)
		end
	else
		addrServer = net.serverinfo_request(eIP:getText())
		startGetServInfo()
	end	
end

function startGetServInfo()
    UpdateManager.add(getServerInfo)
end

function endGetServInfo()
    UpdateManager.delete(getServerInfo)
 
	if infoServer == nil then
		MsgWindow.warning(_('Address unavailable'),  _('WARNING'), 'OK'):show()	
        return
    end 
	
	if infoServer.status == "offline" then
		MsgWindow.warning(_('Server offline'),  _('WARNING'), 'OK'):show()	
        return
    end 
	
    local password = ePassword:getText()
    if infoServer.password == false then
        password = ""
    end   
	
	local text = _("Joining to server requires installation and activation of next modules:")
	local listRequiredModulesText
	
    if not(infoServer.theatre == nil 
       or (infoServer.theatre and TheatreOfWarData.isEnableTheatre(infoServer.theatre) == true))  then
		listRequiredModulesText = (listRequiredModulesText or text).."\n- ".._(infoServer.theatre)
    end  
	
	if infoServer.requiredModules then
        for k,v in base.pairs(infoServer.requiredModules) do
            if (base.enableModules[v] ~= true) then
				listRequiredModulesText = (listRequiredModulesText or text).."\n- "..modulesInfo.getModulDisplayNameByModulId(v)
            end
        end
    end

	if listRequiredModulesText ~= nil then
		MsgWindow.warning(listRequiredModulesText,  _('WARNING'), 'OK'):show()				
	else
		if callback then
			local res, type = callback(addrServer ,password, infoServer.name, infoServer.advanced)
			if res == true then
				--show(false)
			elseif type ~= 'screenshots' then
				pError:setVisible(true)
			end
		else	
			show(false)
		end
	end
end

function getServerInfo()
    infoServer = net.serverinfo_get(addrServer) 

    --base.U.traverseTable(infoServer)
	--if infoServer then
	--	base.print("---infoServer---",addrServer, infoServer.status,infoServer.requiredModules)
	--end
    
    if (infoServer == nil) or (infoServer and infoServer.status ~= 'pending') then
        endGetServInfo()
    end
end

function keyDownCallback(self)
    pError:setVisible(false)
end

-------------------------------------------------------------------------------
-- 
function onChange_bCancel()
    show(false)
end

-------------------------------------------------------------------------------
-- 
function show(b, a_onlyConnect) 
    if bCreated == false then
        create()
    end
	
	onlyConnect = a_onlyConnect

    if b == true then
        ePassword:setText("")        
        ePassword:setFocused(true)
        pError:setVisible(false)
    end
    
    window:setVisible(b)
end    

-------------------------------------------------------------------------------
-- 
function setCallback(a_callback, a_serverName, a_advanced)
    callback = a_callback
	serverName = a_serverName
	serverAdvanced = a_advanced
end

-------------------------------------------------------------------------------
-- 
function setReadOnlyIP(a_readOnly)
    eIP:setReadOnly(a_readOnly)
end

-------------------------------------------------------------------------------
-- 
function setIp(a_ip)
    eIP:setText(a_ip)
end

function setPassword(a_password)
    ePassword:setText(a_password)
end

function isVisible()
	if window then
		return window:getVisible()
	end
	return false	
end

function showIncorrectPassword()
	pError:setVisible(true)
end
