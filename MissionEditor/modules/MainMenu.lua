local base = _G

module('MainMenu')

local require	= base.require
local print		= base.print

local Form                      = require('MainMenuForm')
local Encyclopedia              = require('me_encyclopedia')
local Gui                       = require('dxgui')
local Mission                   = require('me_mission')
local ComboBox                  = require('ComboBox')
local lfs                       = require('lfs')
local pan_quickstart            = require('me_quickstart')
local panel_generator_simple    = require('me_simple_generator_dialog')
local Tools                     = require('tools')
local panel_news                = require('me_news')
local OptionsDialog				= require('me_options')
local statusbar 				= require('me_statusbar')
local music						= require('me_music')
local sound						= require('sound')
local MeSettings				= require('MeSettings')
local panel_campaign_editor		= require('me_campaign_editor')
local panel_campaign			= require('me_campaign')
local TheatreOfWarData          = require('Mission.TheatreOfWarData')
local MsgWindow			        = require('MsgWindow')
local i18n 					    = require('i18n')
local panel_auth                = require('me_authorization')
local waitScreen				= require('me_wait_screen')
local DCS                       = require('DCS')
local modulesInfo  				= require('me_modulesInfo')
local optionsEditor 			= require('optionsEditor')
local MissionData				= require('Mission.Data')
local progressBar 				= require('ProgressBarDialog')
local Analytics					= require("Analytics")  
local modulesOffers				= require("me_modulesOffers")
local ProductType 				= require('me_ProductType')
local MapWindow					= require('me_map_window')
local managerModulesME 			= require('me_managerModulesME')

i18n.setup(_M)

function verifyLeastOneTheatre()
    bEnableTerrain = TheatreOfWarData.verifyLeastOneTheatre()
	
	if Form.modeNoTerrain then
		Form.modeNoTerrain(bEnableTerrain)
	end
    
    if bEnableTerrain == false and bNoMsgTerrain ~= true then
        local handler = MsgWindow.warning(_("Seems that you do not have any theatres installed. Please, check available on our Store."), _("WARNING"), _("GET TERRAIN"), _("NO, THANKS"))
            function handler:onChange(buttonText)
                if buttonText == _("GET TERRAIN") then 
					if (ProductType.getType() == "STEAM") then
						base.os.open_uri("http://store.steampowered.com/app/411891/DCS_NEVADA_Test_and_Training_Range_Map/")
					else
						base.os.open_uri("https://www.digitalcombatsimulator.com/en/shop/terrains/nttr_terrain/")
					end
                end
            end 
        handler:show() 
    end
    bNoMsgTerrain = true
end

function verifyLeastOneTheatreMCS()
    bEnableTerrain = TheatreOfWarData.verifyLeastOneTheatre()

    if bEnableTerrain == false then
        MsgWindow.warning(_("No terrain found."), _("WARNING"), _("EXIT")):show() 
		Gui.doQuit()  
		return false	
    end
	return true
end

function anonymousStatistic()
    if MeSettings.getPermissionToCollectStatistics() == nil then
        local handler = MsgWindow.question(_("We will collect anonymous usage data \nto improve the quality of your experience \nwhen you use our products.")..("\n\n"), _('HELP US IMPROVE OUR PRODUCTS'), _("DISAGREE"), _("AGREE"))
            function handler:onChange(buttonText)
                if buttonText == _("DISAGREE") then 
                    MeSettings.setPermissionToCollectStatistics(false)   
					optionsEditor.setOption("miscellaneous.collect_stat", false)	
                end
                
                if buttonText == _("AGREE") then 
                    MeSettings.setPermissionToCollectStatistics(true) 
					optionsEditor.setOption("miscellaneous.collect_stat", true)		
                end
            end 
        handler:show() 
    end
end

function showMissionEditorEmpty()
	closeInfo()
    show(false)
	MapWindow.closeNewMapView()
	MapWindow.showEmpty()
end
  
function showMissionEditor(noResetMission)
	closeInfo()
    show(false)
	
	if base.__PRODUCT_ID__ == 2 or ProductType.getType() == "LOFAC" then
		if verifyLeastOneTheatreMCS() == false then
			return
		end
	end
   
	local f = function()
		base.setPlannerMission(false)
		if noResetMission ~= true then
			if MapWindow.initTerrain(true, false, "ME", Mission.getDefaultDate()) == true then
				Mission.create_new_mission()
				MapWindow.show(true)				
			else
				show(true)
			end
		else
			MapWindow.show(true)	
		end	
	end

	progressBar.setUpdateFunction(f)
end

function create(x, y, w, h)
	x_ = x
	y_ = y
	w_ = w
	h_ = h
	
	base.print("--managerModulesME.moduleMainMenu--",managerModulesME.moduleMainMenu)
	if managerModulesME.moduleMainMenu then 
		Form = managerModulesME.moduleMainMenu
	end
	
	
	Form.create(x, y, w, h)
	Form.setupCallBacks(tblCallbacks)

	if Form.setLogoVisible then
		if (base.__BETA_VERSION__ == true) then			
			Form.setLogoVisible(true)
		else
			Form.setLogoVisible(false)			
		end
	end	
end

function setAutorization(result)
	if result == true then
		if Form.setLoginData then
			Form.setLoginData(false, panel_auth.getLogin(), true)
		end
	else
		if Form.setLoginData then
			Form.setLoginData(true, "", false)
		end
	end
		
	if Form.updateOfflineMode then	
		Form.updateOfflineMode(panel_auth.getOfflineMode())
	end
	
	if Form.pNews then
		panel_news:updateNews()
	end
	
	base.menubar.setAutorization()
	base.panel_openfile.updateStartServer()
end

function onShowOptions()
	closeInfo()
	show(false)
	
	local listener = {
		onOk = function()
			if 	OptionsDialog.getScreenSettingsChanged() or 
--				OptionsDialog.getDeferredShadingChanged() or
				OptionsDialog.getEnableVRChanged() --or
				--OptionsDialog.getLanguageChanged() 
													then	
				
				base.restartME()
                return
			end           
			
			if OptionsDialog.getIconsThemeChanged() then
				MapWindow.onIconsThemeChange()
			end
			
			if 	OptionsDialog.getCoordSettingsChanged() or 
				OptionsDialog.getUnitsSettingsChanged() or
				OptionsDialog.getDatumChanged()	then
				
				statusbar.updateOptions()
			end
			
			show(true) 
		end,
		
		onCancel = function()
			show(true) 
		end,
		
		onSoundSetting = function(name, value)
			if name == 'music' then
				music.setMusicVolume(value)
			elseif name == 'gui' then
				music.setEffectsVolume(value)
			elseif (name == 'voice_chat' or 
					name == 'voice_chat_output' or 
					name == 'voice_chat_input') then
				sound.updateVoiceChatSettings{ [name] = value }					
			end
			sound.updateSettings{ [name] = value }
		end,
		
		setWallpaper = Form.setWallpaper or (function() end),
	}
	
	OptionsDialog.show(listener)
end

function onShowPilotLogbook()
	closeInfo()
    show(false)	
    waitScreen.setUpdateFunction(function()
		base.panel_logbook.show(true)
    end)
end
  
function onShowEncyclopedia()
	closeInfo()
    show(false)

    waitScreen.setUpdateFunction(function()
		base.panel_enc.show(true)
    end)
end
  
function onShowCampaign()
	closeInfo()
    show(false)
    waitScreen.setUpdateFunction(function()
		panel_campaign.show(true)
    end)
end

function onShowCampaignBuilder()
	closeInfo()
    show(false)
	
    waitScreen.setUpdateFunction(function()
		panel_campaign_editor.show(true)
    end)
end

function onShowMissionEditor()  
	closeInfo()
	base.openMainMenu = false
	if Mission.missionCreated ~= true then
		showMissionEditorEmpty()
	else	
		Mission.missionCreated = false
		showMissionEditor()
	end
end  

function onShowModulesManager()
	closeInfo()
    show(false)
	
    base.panel_modulesmanager.show(true)
end  
  
function onShowOpenMission()
	closeInfo()
	base.openMainMenu = false
	base.panel_openfile.vdata.type = '*.miz'
	base.panel_openfile.caller = 'mainmenu'
	waitScreen.setUpdateFunction(function()
		base.panel_openfile.show(true, 'mainmenu', false)
	end)
end  
  
function onShowTraining()
	closeInfo()
	show(false)
	waitScreen.setUpdateFunction(function()
		base.panel_training.show(true)
	end)
end
  
function onShowReplays()
	closeInfo()
	show(false)

	waitScreen.setUpdateFunction(function()
		base.panel_openfile.show(true, 'mainmenu', true)
	end)
end  
  
function onShowQuickMission() 
	closeInfo()
	base.openMainMenu = false
	pan_quickstart.show()
end 

function onShowFastCreateMission()
	closeInfo()
	base.openMainMenu = false
    panel_generator_simple.show(true)
end 

function onChange_bLoginLogout(self)
	base.openMainMenu = false
	if self:getState() == false then			
	
	else
		Form.setLoginData(true, "", false)
	end
	panel_auth.logout()
	base.restartME()
end

function onChange_bDBThreats(self)
	base.openMainMenu = false
	if managerModulesME.callBack_showEditorDBThreats ~= nil then
		managerModulesME.callBack_showEditorDBThreats(x_, y_, w_, h_)
	end
end
  
tblCallbacks = {
	onExit = function()
		base.START_PARAMS.command = '--quit'
		Gui.doQuit()
	end,
	
	onMultiplayer = function()
		closeInfo()
		base.openMainMenu = false
		if base.__FINAL_VERSION__  or panel_auth.isAutorization() == true then
			base.START_PARAMS.missionPath = ""
			base.panel_server_list.show(true)
			show(false)
		else
			panel_auth.show(true, endAutorization) 
		end 
	end,
	
	onOptions 			= onShowOptions,
	onPilotLogbook 		= onShowPilotLogbook,
	onEncyclopedia		= onShowEncyclopedia,
	onCampaign			= onShowCampaign,
	onFastCreateMission	= onShowFastCreateMission,
	onCampaignBuilder	= onShowCampaignBuilder,
	onMissionEditor		= onShowMissionEditor,
	onModulesManager	= onShowModulesManager,
	onOpenMission		= onShowOpenMission,
	onTraining			= onShowTraining,
	onReplays			= onShowReplays,
	onQuickMission		= onShowQuickMission,
	onbLoginLogout 		= onChange_bLoginLogout,
	onbDBThreats		= onChange_bDBThreats
}


function show(b, noAnalytics)
    if Form.isCreate == nil or Form.isCreate() == false then
        return
    end
    
	if Form.pNews then
		panel_news.show(b)
	end
	
	if Form.setVisible then
		Form.setVisible(b)
	end
    
    if b then	
		base.openMainMenu = true
		if noAnalytics ~= true then
			Analytics.pageview(Analytics.MainMenu)
		end
		if base.__PRODUCT_ID__ ~= 2 and ProductType.getType() ~= "LOFAC" then
			anonymousStatistic() 
		else
			MeSettings.setPermissionToCollectStatistics(false)   
			optionsEditor.setOption("miscellaneous.collect_stat", false)
		end	
		UpdateIndicatorMM()
		
		if panel_auth.getOfflineMode() ~= true and modulesInfo.isEndUpdating() == true then
			modulesOffers.show(true)
		end
	else
		base.openMainMenu = false
    end
	if Form.updateOfflineTimeWidget then
		Form.updateOfflineTimeWidget(b)
	end
	
	if b then 
		verifyLeastOneTheatre()
	end	
end

function callbackMainMenu()
	UpdateIndicatorMM()
	
	if panel_auth.getOfflineMode() ~= true then
		modulesOffers.show(true)
	end
end

function UpdateIndicatorMM()
	if Form.setIndicatorMM then
		if panel_auth.getOfflineMode() == true then
			Form.setIndicatorMM(false, nil)
			return
		end
		
		local num = modulesInfo.getNumPurchasedModules()
		
		if num > 0 and (ProductType.getOpt('enableModulesManager') == true) then
			Form.setIndicatorMM(true, num)
		else
			Form.setIndicatorMM(false, nil)
		end
	end
end

function closeInfo()
	if Form.closeInfo then
		Form.closeInfo()
	end
end

function setLastWallpaper()
	if Form.setWallpaper then
		Form.setWallpaper(MeSettings.getMainMenuSkinName())
	end
end

local function endAutorization(a_result)    
    if a_result == true then
		base.START_PARAMS.missionPath = ""
        base.panel_server_list.show(true)
        show(false)
    end  
    setAutorization(a_result)    
end



function setWallpaper(a_data)
	if Form.setWallpaper then
		Form.setWallpaper(a_data)
	end
end



