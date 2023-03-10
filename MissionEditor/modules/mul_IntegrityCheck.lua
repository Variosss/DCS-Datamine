local base = _G

module('mul_IntegrityCheck')

local require       = base.require

local i18n 				= require('i18n')
local Window 			= require('Window')
local DialogLoader      = require('DialogLoader')
local Gui               = require('dxgui')
local net               = require('net')

i18n.setup(_M)

cdata = 
{
	Cancel              	= _("Cancel"),
    ok                  	= _("Ok"),	
	SERVER_INTEGRITY_CHECK_SETTING = _("SERVER INTEGRITY CHECK SETTING"),	
	require_pure_textures 	= _("require pure textures"),
	require_pure_models 	= _("require pure models"),
	require_pure_clients 	= _("require pure clients"),
	require_pure_scripts 	= _("require pure scripts"),
}


local settingsServer 

function create()
    w, h = Gui.GetWindowSize()
    window = DialogLoader.spawnDialogFromFile("MissionEditor/modules/dialogs/mul_IntegrityCheck.dlg", cdata)    

    main_panel              = window.main_panel
    pBox                    = main_panel.pBox
    btnOk                   = main_panel.btnOk
    btnCancel               = main_panel.btnCancel
    
    cbTexture           	= pBox.cbTexture
    cbModels               	= pBox.cbModels
	cbScripts				= pBox.cbScripts
    cbClients              	= pBox.cbClients
 
    btnOk.onChange = onChange_btnOk
    btnCancel.onChange = onChange_btnCancel
	cbClients.onChange = onChange_cbClients
    
    resize(w, h)
end

function resize(w, h)
    window:setBounds(0, 0, w, h)
    
    wP, hP = main_panel:getSize()
    window.main_panel:setBounds((w-wP)/2, (h-hP)/2, wP, hP)
end    


function onChange_btnOk()
    updateSettings()
    show(false)
end

function onChange_btnCancel()
    show(false)
end

function onChange_cbClients()
	updateBtnEnabled()
end

function setSettings(a_settingsServer)
    settingsServer = a_settingsServer
end

function updateSettings()    
    settingsServer.require_pure_textures    	= cbTexture:getState()   
    settingsServer.require_pure_models      	= cbModels :getState()   
	settingsServer.require_pure_scripts			= cbScripts:getState()  
    settingsServer.require_pure_clients   		= cbClients:getState()   
end

function updatePanel()
    cbTexture:setState(settingsServer.require_pure_textures )   
    cbModels:setState(settingsServer.require_pure_models)
	cbScripts:setState(settingsServer.require_pure_scripts) 	
    cbClients:setState(settingsServer.require_pure_clients) 
	updateBtnEnabled()	
end

function updateBtnEnabled()
	cbModels:setEnabled(cbClients:getState())
	cbTexture:setEnabled(cbClients:getState())
	cbScripts:setEnabled(cbClients:getState())
end


function show(b)
    if window == nil then
        create()
    end

    if b then
        updatePanel()
    end   

    window:setVisible(b)    
end

function isVisible()
	if window then
		return window:getVisible()
	end
	return false
end