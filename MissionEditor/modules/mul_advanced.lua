local base = _G

module('mul_advanced')

local require       = base.require

local i18n 				= require('i18n')
local Window 			= require('Window')
local DialogLoader      = require('DialogLoader')
local Gui               = require('dxgui')
local net               = require('net')
local ProductType		= require('me_ProductType') 

i18n.setup(_M)

cdata = 
{
    Connect             = _("Connect to server"),
    Kill                = _("Kill"),
    Role                = _("Role changing"),
    Takeoff             = _("Takeoff, landing "),
    Crash               = _("Crash"),
    Ejecting            = _("Ejecting"),
    Export              = _("allow_object_export"),
    PlayersExport       = _("Allow player export"),
    SensorsExport       = _("Allow sensor export"),
    Pause               = _("pause_on_load"),
    Cancel              = _("Cancel"),
    ok                  = _("Ok"),
    DETAILED_SETTINGS   = _("ADVANCED SETTINGS"),   
    PauseWithoutClients = _("Pause without clients"), 
    eventRole           = _("Role"),
    ResumeManual        = _("Resume manual"),
    ResumeOnLoad        = _("Resume on load"),
    ResumeWithClients   = _("Resume with clients"), 
	AllowChangeSkins	= _("Allow to change skins"), 
	AllowChangeNumber	= _("Allow to change tail number"), 
	pingAllowed			= _("Max Ping Allowed"),	
	show_chat_events	= _("Show chat events:"),
	permissions			= _("Permissions:"),
	AllowToScreenshot	= _("Allow to screenshot clients"),
	VoiceChatServer		= _("Allow voice chat"),
	AllowDynamicRadio	= _("Allow to use extra radio"),
	AllowTrialOnlyClients = _("Allow trial only clients"),
	passwordRed			= _("Password Red"),
	passwordBlue		= _("Password Blue"),	
	AllowPlayersPool	= _("Allow Players Pool"),
}

if ProductType.getType() == "LOFAC" then
    cdata.Pause               = _("pause_on_load-LOFAC")
end

local settingsServer 

function create()
    w, h = Gui.GetWindowSize()
    window = DialogLoader.spawnDialogFromFile("MissionEditor/modules/dialogs/mul_advanced.dlg", cdata)    

    main_panel              = window.main_panel
    pBox                    = main_panel.pBox
    btnOk                   = main_panel.btnOk
    btnCancel               = main_panel.btnCancel
    
 --   cbShowAll               = pBox.cbShowAll
    cbKill                  = pBox.cbKill
    cbTakeoff               = pBox.cbTakeoff
    cbCrash                 = pBox.cbCrash
    cbEjecting              = pBox.cbEjecting
    cbRole                  = pBox.cbEventRole
    cbExport                = pBox.cbExport   
    cbPlayersExport         = pBox.cbPlayersExport
    cbSensorsExport         = pBox.cbSensorsExport
	cbAllowChangeSkins     	= pBox.cbAllowChangeSkins
	cbAllowChangeNumber   	= pBox.cbAllowChangeNumber
	spPingAllowed			= pBox.spPingAllowed
	cbAllowToScreenshot		= pBox.cbAllowToScreenshot	
	cbVoiceChatServer		= pBox.cbVoiceChatServer
	cbAllowDynamicRadio		= pBox.cbAllowDynamicRadio
	cbAllowTrialOnlyClients = pBox.cbAllowTrialOnlyClients
	cbAllowPlayersPool		= pBox.cbAllowPlayersPool
    
    rbResumeManual          = pBox.rbResumeManual
    rbResumeOnLoad          = pBox.rbResumeOnLoad
    rbResumeWithClients     = pBox.rbResumeWithClients
	
	cbPasswordBlue			= pBox.cbPasswordBlue
	cbPasswordRed			= pBox.cbPasswordRed
	ePasswordBlue			= pBox.ePasswordBlue
	ePasswordRed			= pBox.ePasswordRed
	
	cbPasswordBlue.onChange	= onChange_cbPasswordBlue
	cbPasswordRed.onChange	= onChange_cbPasswordRed
	ePasswordBlue.onChange	= onChange_ePasswordBlue
	ePasswordRed.onChange	= onChange_ePasswordRed
    
    
 --   cbShowAll.onChange = onChange_cbShowAll
	cbVoiceChatServer.onChange = onChange_cbVoiceChatServer

    btnOk.onChange = onChange_btnOk
    btnCancel.onChange = onChange_btnCancel
    
    resize(w, h)
end

function resize(w, h)
    window:setBounds(0, 0, w, h)
    
    wP, hP = main_panel:getSize()
    window.main_panel:setBounds((w-wP)/2, (h-hP)/2, wP, hP)
end    
    --[[
function onChange_cbShowAll()   
    updateCB()
end

function updateCB()
    if cbShowAll:getState() == true then
        cbKill:setEnabled(true)
        cbRole:setEnabled(true)
        cbTakeoff:setEnabled(true)
        cbCrash:setEnabled(true)
        cbEjecting:setEnabled(true)
    else
        cbKill:setEnabled(false)
        cbRole:setEnabled(false)
        cbTakeoff:setEnabled(false)
        cbCrash:setEnabled(false)
        cbEjecting:setEnabled(false)
    end
end    ]]

function onChange_cbVoiceChatServer()
	if cbVoiceChatServer:getState() == true then
		cbAllowDynamicRadio:setEnabled(true)
	else
		cbAllowDynamicRadio:setEnabled(false)
	end
end

function onChange_btnOk()
    updateSettings()
    show(false)
end

function onChange_btnCancel()
    show(false)
end

function setSettings(a_settingsServer)
    settingsServer = a_settingsServer
	--base.U.traverseTable(a_settingsServer)
	--base.print("---setSettings---")
end

function updateSettings()    
  --  settingsServer.advanced.disable_events          = not cbShowAll:getState()  
    settingsServer.advanced.event_Kill              = cbKill:getState()   
    settingsServer.advanced.event_Role              = cbRole :getState()   
    settingsServer.advanced.event_Takeoff           = cbTakeoff:getState()   
    settingsServer.advanced.event_Crash             = cbCrash:getState()   
    settingsServer.advanced.event_Ejecting          = cbEjecting:getState()   
    settingsServer.advanced.allow_object_export     = cbExport:getState()   
    settingsServer.advanced.allow_ownship_export    = cbPlayersExport:getState()  
    settingsServer.advanced.allow_sensor_export     = cbSensorsExport:getState() 
	settingsServer.advanced.allow_change_skin    	= cbAllowChangeSkins:getState() 
	settingsServer.advanced.allow_change_tailno    	= cbAllowChangeNumber:getState() 	
	settingsServer.advanced.maxPing    				= spPingAllowed:getValue()
	settingsServer.advanced.server_can_screenshot  	= cbAllowToScreenshot:getState() 
	settingsServer.advanced.voice_chat_server		= cbVoiceChatServer:getState() 
	settingsServer.advanced.allow_dynamic_radio 	= cbAllowDynamicRadio:getState() 
	settingsServer.advanced.allow_trial_only_clients= cbAllowTrialOnlyClients:getState() 
	settingsServer.advanced.allow_players_pool 		= cbAllowPlayersPool:getState() 
 
    if rbResumeManual:getState() == true then
        settingsServer.advanced.resume_mode = net.RESUME_MANUAL 
    elseif rbResumeOnLoad:getState() == true then
        settingsServer.advanced.resume_mode = net.RESUME_ON_LOAD
    else
        settingsServer.advanced.resume_mode = net.RESUME_WITH_CLIENTS
    end
    
	if cbPasswordBlue:getState() then
		-- меняется при вводе
	else
		settingsServer.advanced.bluePasswordHash  = nil
	end
	
	if cbPasswordRed:getState() then
		-- меняется при вводе
	else
		settingsServer.advanced.redPasswordHash  = nil
	end

end

function updatePanel()
 --   cbShowAll:setState(not settingsServer.advanced.disable_events )  
    cbKill:setState(settingsServer.advanced.event_Kill )   
    cbRole:setState(settingsServer.advanced.event_Role)   
    cbTakeoff:setState(settingsServer.advanced.event_Takeoff)   
    cbCrash:setState(settingsServer.advanced.event_Crash)   
    cbEjecting:setState(settingsServer.advanced.event_Ejecting)   
    cbExport:setState(settingsServer.advanced.allow_object_export)  
    cbPlayersExport:setState(settingsServer.advanced.allow_ownship_export)  
    cbSensorsExport:setState(settingsServer.advanced.allow_sensor_export) 
	cbAllowChangeSkins:setState(settingsServer.advanced.allow_change_skin) 	
	cbAllowChangeNumber:setState(settingsServer.advanced.allow_change_tailno) 
	spPingAllowed:setValue(settingsServer.advanced.maxPing or 0)
	cbAllowToScreenshot:setState(settingsServer.advanced.server_can_screenshot) 
	cbVoiceChatServer:setState(settingsServer.advanced.voice_chat_server) 
	cbAllowDynamicRadio:setState(settingsServer.advanced.allow_dynamic_radio) 
	cbAllowTrialOnlyClients:setState(settingsServer.advanced.allow_trial_only_clients) 
	cbAllowPlayersPool:setState(settingsServer.advanced.allow_players_pool) 

    if settingsServer.advanced.resume_mode == net.RESUME_MANUAL  then
        rbResumeManual:setState(true)
        rbResumeOnLoad:setState(false)
        rbResumeWithClients:setState(false)
    elseif settingsServer.advanced.resume_mode == net.RESUME_ON_LOAD then
        rbResumeManual:setState(false)
        rbResumeOnLoad:setState(true)
        rbResumeWithClients:setState(false)
    else
        rbResumeManual:setState(false)
        rbResumeOnLoad:setState(false)
        rbResumeWithClients:setState(true)
    end

	if settingsServer.advanced.bluePasswordHash ~= nil then
		cbPasswordBlue:setState(true)
		ePasswordBlue:setEnabled(true)
		ePasswordBlue:setText("*****")
	else
		cbPasswordBlue:setState(false)
		ePasswordBlue:setEnabled(false)
		ePasswordBlue:setText("")
	end
	
	if settingsServer.advanced.redPasswordHash ~= nil then
		cbPasswordRed:setState(true)
		ePasswordRed:setEnabled(true)
		ePasswordRed:setText("*****")
	else
		cbPasswordRed:setState(false)
		ePasswordRed:setEnabled(false)
		ePasswordRed:setText("")
	end
end

function show(b)
    if window == nil then
        create()
    end

    if b then
        updatePanel()
        --updateCB()
    end   

    window:setVisible(b)    
end

-------------------------------------------------------------------------------
function onChange_cbPasswordRed(self)
	if self:getState() then
		ePasswordRed:setEnabled(true)	
		ePasswordRed:setText("")			
	else
		ePasswordRed:setEnabled(false)	
		ePasswordRed:setText("")
	end	
end

-------------------------------------------------------------------------------
function onChange_cbPasswordBlue(self)
	if self:getState() then
		ePasswordBlue:setEnabled(true)	
		ePasswordBlue:setText("")			
	else
		ePasswordBlue:setEnabled(false)	
		ePasswordBlue:setText("")
	end	
end

function onChange_ePasswordBlue()
	settingsServer.advanced.bluePasswordHash = net.hash_password(ePasswordBlue:getText())
end

function onChange_ePasswordRed()
	settingsServer.advanced.redPasswordHash = net.hash_password(ePasswordRed:getText())
end
