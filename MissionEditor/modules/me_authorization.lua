local base = _G

module('me_authorization')

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
local MsgWindow			= require('MsgWindow')
local DcsWeb            = require('DcsWeb')
local panel_waitDsbweb  = require('me_waitDsbweb')
local lfs               = require('lfs')
local S 				= require('Serializer')
local Tools 			= require('tools')
local module_updater    = require('me_updater')
local optionsEditor 	= require('optionsEditor')
local dxgui			    = require('dxgui')
local log      			= require('log')

i18n.setup(_M)

cdata =
{
    IncorrectLoginOrPassword    = _("Incorrect login or password."),
    noInternet                  = _("No internet connection."),
    InternalServerError         = _("Internal Server Error."),
	OfflineModeError          	= _("Cannot exit offline mode. Ask for support."),
    serialConflict              = _("Invalid serial number."),
    authorization               = _("Authorization"),
    Login                       = _("Login"),
    Password                    = _("Password"),
    Savepassword                = _("Save password"),
    Cancel                      = _("OFFLINE"),
    Connect                     = _("CONNECTION"),
    Register                    = _("Register"),
    Restore                     = _("Forgot your password?"),
    LogintoDigital              = _("Connection to DCS"),
    autojoin                    = _("Auto Login"),
    ErrorLogin                  = _("Error Login"),
    DCSuser                     = _("DCS user"),
    Registration                = _("Registration"),
    error_email                 = _("This e-mail address already used"),
    error_login                 = _("User with this login already exists"),
    error_password              = _("Incorrect password confirmation"),
    error_code                  = _("Code is entered incorrectly"),
	error_verification          = _("Authentication failed. Login to website for verification, please."),

    Email                       = _("E-mail"),
    Repeatpassword              = _("Repeat password"),
    Typesymbols                 = _("Typesymbols"),
	Entering					= _("Entering..."),
}

local bCreated = false
local autojoin = nil
local bAuthSuccess = false
local Login = nil
local window
local offlineMode = false
local offline203 = false
local bInProcess = false

-------------------------------------------------------------------------------
-- 
function create()
    window = DialogLoader.spawnDialogFromFile('MissionEditor/modules/dialogs/login_dialog_new.dlg', cdata)
    
    local main_w = base.main_w
    local main_h = base.main_h
    
    local box = window.Box
    
    local win_w
    local win_h
    win_w, win_h = 350, 300   --box:getSize()
    
    window:setBounds(0, 0, main_w, main_h)
    box:setBounds((main_w - win_w)/2, (main_h - win_h)/2, 650, 650)
    
    bCancel         = box.bCancel
    tgiLogin        = box.tgiLogin
    tgiRegistration = box.tgiRegistration
    pLogin          = box.pLogin    
    eLogin          = pLogin.eLogin
    ePassword       = pLogin.ePassword
    bConnect        = pLogin.bConnect    
    bRestore        = pLogin.bRestore
  --  bRegister   = pLogin.bRegister
    cbSave          = pLogin.cbSave
    cbAutojoin      = pLogin.cbAutojoin
    sError          = pLogin.sError
    eError          = pLogin.eError
	sEntering		= pLogin.sEntering
	bRegistration	= pLogin.bRegistration

    pRegistration   = box.pRegistration
    
    pRegistration:setBounds(0, 92, 650, 650)
    sError:setVisible(false)
    eError:setVisible(false)
	sEntering:setVisible(false)
    
    
    cbAutojoin.onChange = cbAutojoin_onChange
    
    eLogin:addKeyUpCallback(keyUpCallback)
    ePassword:addKeyUpCallback(keyUpCallback)
 --   cbAutojoin:setVisible(false)
 
    tgiLogin.onShow         = onChange_tgiLogin
    tgiRegistration.onShow  = onChange_tgiRegistration
    
    bCancel.onChange = onChange_Cancel
    bConnect.onChange = onChange_Connect
    bRestore.onChange = onChange_Restore
	bRegistration.onChange = onChange_Registration
 --   bRegister.onChange = onChange_Register
 
    window:addHotKeyCallback('escape'	, onChange_Cancel)
    window:addHotKeyCallback('return'	, onChange_Connect)
    window:addHotKeyCallback('space'	, onKey_space)
    
    bCreated = true
end

-------------------------------------------------------------------------------
-- 
function getLogin()
	if base.__FINAL_VERSION__ then	
		return DcsWeb.get_username()
	end	
    return Login
end

-------------------------------------------------------------------------------
-- 
function isAutorization()
	if base.__FINAL_VERSION__ then	
		return DcsWeb.get_status('dcs:login') == 200 
	end
    return bAuthSuccess
end

-------------------------------------------------------------------------------
-- 
function keyUpCallback(self)
    sError:setVisible(false)
    eError:setVisible(false)
end

-------------------------------------------------------------------------------
-- 
function cbAutojoin_onChange(self)
    autojoin = cbAutojoin:getState()
	optionsEditor.setOption("miscellaneous.autologin", cbAutojoin:getState())	
end

-------------------------------------------------------------------------------
-- 
function onChange_tgiLogin(self)
    pLogin:setVisible(true)
    pRegistration:setVisible(false)
end

-------------------------------------------------------------------------------
-- 
function onChange_tgiRegistration(self)
    pLogin:setVisible(false)
    pRegistration:setVisible(true)
end


-------------------------------------------------------------------------------
-- 
function show(b, a_callbackSetAuth) 	
    callbackSetAuth = a_callbackSetAuth
    if bCreated == false then
        create()
    end
        
    if b == true then
        local saveLogin = {
            master_login = DcsWeb.get_username(),
            master_password = DcsWeb.get_password()
        }
        cbSave:setState(DcsWeb.get_savepw())     
        if (saveLogin ~= nil) then
            if (saveLogin.master_login ~= nil) and (saveLogin.master_login ~= "") then
                eLogin:setText(saveLogin.master_login)                
                if (saveLogin.master_password ~= nil) and (saveLogin.master_password ~= "") then
                    ePassword:setText(saveLogin.master_password)                                        
                    autojoin = loadAutojoin()  
                    cbAutojoin:setState(autojoin)      
                else  
                    ePassword:setText("")         
                end
            else
                eLogin:setText("")
                ePassword:setText("")     
            end
        else
            eLogin:setText("")
            ePassword:setText("")    
        end
    end
    window:setVisible(b)
end


-------------------------------------------------------------------------------
-- 
function openAutorization(a_callbackSetAuth)
		local status = DcsWeb.get_status('dcs:login')		
		offline203 = false
		if status == 200 then
			bAuthSuccess = true
			Login = DcsWeb.get_username()
			offlineMode = false
			if a_callbackSetAuth then
				a_callbackSetAuth(true)
			end    
			return
		end
		
		if  status == 0 then
			if autojoin == nil then
				autojoin = loadAutojoin()      
			end               
			if autojoin == true then
				callbackSetAuth = a_callbackSetAuth
				silentAutorization()
			else
				show(true,a_callbackSetAuth)
			end
		elseif status == 203 then
			offlineMode = true
			offline203 = true
		
			if a_callbackSetAuth then
				a_callbackSetAuth(false)
			end			
		else	
			offlineMode = true
			if a_callbackSetAuth then
				a_callbackSetAuth(false)
			end	
		end
end

-------------------------------------------------------------------------------
-- 
function silentAutorization()
    local saveLogin = {
        master_login = DcsWeb.get_username(),
        master_password = DcsWeb.get_password()
    }
    if (saveLogin ~= nil) 
        and (saveLogin.master_login ~= nil) and (saveLogin.master_password ~= nil)
        and (saveLogin.master_login ~= "") and (saveLogin.master_password ~= "") then
        
        Login = saveLogin.master_login       
        autorization(saveLogin.master_login, saveLogin.master_password, true)
    else
        bAuthSuccess = false
		optionsEditor.setOption("miscellaneous.autologin", false)		
		offlineMode = true
        if callbackSetAuth then
            callbackSetAuth(false)
        end
    end        
end

-------------------------------------------------------------------------------
-- 
function onKey_space()   
    if cbSave:getFocused() == true then
        cbSave:setState(not cbSave:getState())
    end
    
    if cbAutojoin:getFocused() == true then
        cbAutojoin:setState(not cbAutojoin:getState())
        cbSave:setState(not cbSave:getState())
    end  
end

-------------------------------------------------------------------------------
-- 
function onChange_Connect()    
    Login = nil
      
    Login           =   eLogin:getText()
    local Password  =   ePassword:getText()
    local SavePW    =   cbSave:getState()
    
    local res = autorization(Login, Password, SavePW)
end

-------------------------------------------------------------------------------
-- 
function autorization(a_login, a_password, b_savepw)
    if bCreated == false then
        create()
    end

	if bInProcess == false then
		bInProcess = true
		sEntering:setVisible(true)
		DcsWeb.send_request('dcs:login', { username = a_login, password = a_password, savepw = base.tostring(b_savepw)--[[, savepw = b_savepw]]})
		panel_waitDsbweb.startWait(verifyStatusLogin, end_autorization)
	end
end

-------------------------------------------------------------------------------
-- 
function loadAutojoin()
	local autologin = optionsEditor.getOption("miscellaneous.autologin")
    return autologin or false
end

-------------------------------------------------------------------------------
--
function saveAutojoin(a_autojoin)	 
    local f, err = io.open(lfs.writedir() .. 'MissionEditor/optionsLogin.lua', 'w')
    if f then
        local sr = S.new(f) 
        sr:serialize_simple2('optionsLogin', {autojoin = a_autojoin})
        f:close()
	else
		log.error('ERROR: saveAutojoin failed: '..err)	
    end
end

-------------------------------------------------------------------------------
-- 
function verifyStatusLogin()
    local status = DcsWeb.get_status('dcs:login')

    if status ~= 102 then                      
        return true, status     
    end
    return false
end

-------------------------------------------------------------------------------
-- 
function end_autorization(status)
	bInProcess = false
	sEntering:setVisible(false)

    if (status == 200) then
        bAuthSuccess = true
		offlineMode = false
        if callbackSetAuth then
            callbackSetAuth(true)
        end
        show(false)        
    else
        optionsEditor.setOption("miscellaneous.autologin", false)	
        bAuthSuccess = false
		offlineMode = true
        if callbackSetAuth then
            callbackSetAuth(false)
        end
        if sError then
            sError:setVisible(true)
            eError:setVisible(true)
            eError:setText("") 

            if status == 503 then
                sError:setText(cdata.noInternet)
            elseif status == 500 then
                sError:setText(cdata.InternalServerError)
            elseif status == 409 then               
                sError:setText(cdata.OfflineModeError)
			elseif status == 412 then               
                sError:setText(cdata.error_verification)	
			else
                sError:setText(cdata.IncorrectLoginOrPassword)	
            end
        end
    end     
end

-------------------------------------------------------------------------------
-- 
function logout(a_callbackSetAuth) 
    callbackSetAuth = a_callbackSetAuth

	optionsEditor.setOption("miscellaneous.autologin", false)	
    panel_waitDsbweb.show(true)
    DcsWeb.send_request('dcs:logout')

    panel_waitDsbweb.startWait(verifyStatusLogout, end_logout)
end


-------------------------------------------------------------------------------
-- 
function verifyStatusLogout()
    local status = DcsWeb.get_status('dcs:logout')
    
    if status ~= 102 then                      
        return true, status     
    end
    return false
end

-------------------------------------------------------------------------------
-- 
function end_logout(status)
    if (status == 200) then
        Login = nil
        bAuthSuccess = false

        local res = DcsWeb.logout()        
        if callbackSetAuth then
            callbackSetAuth(false)
        end
    else

        MsgWindow.error(_("Error logout"), _("LOGOUT"), 'OK'):show()
    end 
end

-------------------------------------------------------------------------------
-- 
function onChange_Cancel()
	DcsWeb.login_cancelled()
    if callbackSetAuth then
        callbackSetAuth(false)
    end
    --logout()
    show(false)
end


-------------------------------------------------------------------------------
-- 
function onChange_Registration()
	local url = DcsWeb.make_auth_url('dcs:signup_url')
    os.open_uri(url)
end

-------------------------------------------------------------------------------
-- 
function onChange_Restore()
    local url = DcsWeb.make_auth_url('dcs:restore_url')
    os.open_uri(url)
	dxgui.MinimizeWindow()
end

-------------------------------------------------------------------------------
-- 
function onChange_Register()
    local url = DcsWeb.make_auth_url('dcs:signup_url')
    os.open_uri(url)
	dxgui.MinimizeWindow()
end

-------------------------------------------------------------------------------
-- 
function getOfflineMode()
	return offlineMode
end	

-------------------------------------------------------------------------------
-- 
function getOffline203()
	return offline203
end	

-------------------------------------------------------------------------------
-- 
function getExpires()
	return DcsWeb.get_data("dcs:expires")
end	


-------------------------------------------------------------------------------
-- 
function setOfflineMode(a_offlineMode, a_callbackSetOffline)
	
	callbackSetOffline = a_callbackSetOffline
	
	if a_offlineMode == true then
		DcsWeb.send_request('dcs:offline:enter')
		panel_waitDsbweb.startWait(verify_dcsOfflineEnter, end_dcsOfflineEnter)
	else
		DcsWeb.send_request('dcs:offline:leave')
		panel_waitDsbweb.startWait(verify_dcsOfflineLeave, end_dcsOfflineLeave)
	end
end

-------------------------------------------------------------------------------
-- 
function verify_dcsOfflineEnter()
	local status = DcsWeb.get_status('dcs:offline:enter')

    if status ~= 102 then                      
        return true, status     
    end
    return false
end

-------------------------------------------------------------------------------
-- 
function verify_dcsOfflineLeave()
	local status = DcsWeb.get_status('dcs:offline:leave')

    if status ~= 102 then   
		return true, status   
    end
    return false
end
	
-------------------------------------------------------------------------------
-- 
function end_dcsOfflineEnter(status)
	if status == 200 then
		offlineMode = true
	else
		offlineMode = false
		MsgWindow.error(_("Can't enter offline mode: error").." "..status..".", _("OFFLINE"), 'OK'):show()
	end
	if callbackSetOffline then
		callbackSetOffline()
	end
end	
	
-------------------------------------------------------------------------------
-- 
function end_dcsOfflineLeave(status)
	if status == 200 then
		offlineMode = false
	else
		offlineMode = true
		MsgWindow.error(_("Can't leave offline mode: error").." "..status..".", _("OFFLINE"), 'OK'):show()
	end
	
	if callbackSetOffline then
		callbackSetOffline(status == 200)
	end
end	

	
	
	