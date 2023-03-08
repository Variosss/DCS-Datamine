local base = _G

module('MainMenuForm')

local require = base.require
local pairs = base.pairs
local ipairs = base.ipairs
local print = base.print
local math = base.math
local type = base.type
local tostring = base.tostring

local plPanel 				= require('plPanel')
local Tools 				= require('tools')
local panel_news 			= require('me_news')
local panel_infoPlugin 		= require('me_infoPlugin')
local DialogLoader			= require('DialogLoader')
local ImageSearchPath	 	= require('image_search_path')
local music			 		= require('me_music')
local lfs				 	= require('lfs')
local waitScreen			= require('me_wait_screen')
local MeSettings			= require('MeSettings')
local panel_campaign_editor	= require('me_campaign_editor')
local panel_campaign		= require('me_campaign')
local i18n 					= require('i18n')
local Button				= require('Button')
local panel_auth			= require('me_authorization')
local SkinUtils				= require('SkinUtils')
local gui					= require('dxgui')
local UpdateManager			= require('UpdateManager')
local progressBar 			= require('ProgressBarDialog')
local MsgWindow			    = require('MsgWindow')
local Analytics				= require("Analytics")
local net    				= require('net')
local ProductType 			= require('me_ProductType') 


i18n.setup(_M)

defaultSkinName = 'default'
userSkinName = 'user'
hDisclaimer = 20

local offlineMode = true
local bEnableTerrain = true
local realTimePrev = 0

cdata = {
		campaign			= _('CAMPAIGN'),
		campaignBuilder		= _('CAMPAIGN BUILDER'),
		editor				= _('MISSION EDITOR'),
		logbook				= _('LOGBOOK'),
		options				= _('OPTIONS-MainMenu', 'OPTIONS'),
		exit				= _('EXIT'),
		replay				= _('REPLAY-MainMenu', 'REPLAY'),
		encyclopedia		= _('ENCYCLOPEDIA'),
		training			= _('TRAINING'),
		mission				= _('MISSION'),	
		instantAction		= _('INSTANT ACTION'),	
		fastCreateMission	= _('CREATE FAST MISSION'),	
		multiplayer			= _('MULTIPLAYER'),
		plugins				= _('PLUGINS'),
		modulesmanager		= _('MODULE MANAGER'),
		login				= _('Log In'),
		logout				= _('Log Out'),
		logout_tooltip		= _("LOG OUT"),
		login_tooltip		= _("LOG IN"),
		disclaimer			= _("Disclaimer_info"),
		EnablingOfflineMode = _("OFFLINE MODE"), 
		DisablingOfflineMode = _("ONLINE MODE"),
	}

local function placeStaticButtonsBackground(clientWidth, clientHeight)
	staticButtonsBackground = window.staticButtonsBackground
	local w, h = staticButtonsBackground:getSize()
	
	staticButtonsBackground:setBounds(clientWidth - w, 0, w, clientHeight)
end

local function placeButtonsContainer(clientWidth, clientHeight)
	local buttonsContainer = window.buttonsContainer
	local w, h = buttonsContainer:getSize()
	
	buttonsContainer:setPosition((clientWidth - w+1), (clientHeight - h) / 2 + 55)
end

local function placeLogoEDStatic(client_w, client_h)
	local staticLogoED = window.staticLogoED
	local w, h = staticLogoED:getSize()
	
	staticLogoED:setPosition(client_w - w, client_h - h - 6)
end

local function placeLogoInjunStatic(client_w, client_h)
	local staticLogoInjun = window.staticLogoInjun
	local w, h = staticLogoInjun:getSize()
	local staticLogoED = window.staticLogoED
	local wED, hED = staticLogoED:getSize()
	
	staticLogoInjun:setPosition(client_w - w - wED-10, client_h - h - 35)
end

local function placeLogoCompStatic(client_w, client_h)
	local ww, hh = staticButtonsBackground:getSize()
	local staticLogoComp = window.staticLogoComp
	local w, h = staticLogoComp:getSize()
	staticLogoComp:setPosition(client_w - w - ww - 1, 0) 
end

local function placeLogoGameStatic(client_w, client_h)
	local staticGameLogo = window.staticGameLogo
	local w, h = staticGameLogo:getSize()
	staticGameLogo:setPosition(client_w - w - 18, 0) 
end

local function placeVersionStatic(client_w, client_h)
	local staticVersion = window.staticVersion
	local w, h = staticVersion:getSize()	
	
	staticVersion:setText(_('Version: ') .. base.START_PARAMS.version);
	staticVersion:setPosition(client_w - 124, client_h - 23) 
end

local function placeDisclaimer(client_w, client_h)
	local sDisclaimer = window.sDisclaimer
	local nw
	sDisclaimer:setSize(client_w-335,40)	
	nw, hDisclaimer = sDisclaimer:calcSize() 
	hDisclaimer = hDisclaimer + 7 -- +7 чтобы выровнить с версией
	sDisclaimer:setBounds(20, client_h - hDisclaimer,client_w-335,hDisclaimer) 
end

local function placeLogoBetaStatic(client_w, client_h)
	local staticLogoBeta = window.staticLogoBeta
	local w, h = staticLogoBeta:getSize()	
	
	staticLogoBeta:setPosition(client_w - 108, 140)
end

local function copyButtonsIntoModule()
	local buttonsContainer	= window.buttonsContainer
	
	buttonExit				= buttonsContainer.buttonExit
	buttonModulesManager	= window.buttonModulesManager
	buttonQuickMission		= buttonsContainer.buttonQuickMission
	buttonFastCreateMission	= buttonsContainer.buttonFastCreateMission
	buttonTraining			= buttonsContainer.buttonTraining
	buttonShowReplays		= buttonsContainer.buttonShowReplays
	buttonOpenMission		= buttonsContainer.buttonOpenMission
	buttonMissionEditor		= buttonsContainer.buttonMissionEditor
	buttonCampaignBuilder	= buttonsContainer.buttonCampaignBuilder
	buttonCampaign			= buttonsContainer.buttonCampaign
	buttonEncyclopedia		= buttonsContainer.buttonEncyclopedia
	buttonPilotLogbook		= buttonsContainer.buttonPilotLogbook
	buttonOptions			= window.buttonOptions	
	buttonMultiplayer		= buttonsContainer.buttonMultiplayer	 
	staticLogoBeta			= window.staticLogoBeta
end

function modeNoTerrain(b)
	bEnableTerrain = b
    if b == false then
        buttonQuickMission:setEnabled(false)
        buttonFastCreateMission:setEnabled(false)
        buttonTraining:setEnabled(false)
        buttonShowReplays:setEnabled(false)
        buttonOpenMission:setEnabled(false)
        buttonMissionEditor:setEnabled(false)
        buttonCampaignBuilder:setEnabled(false)
        buttonCampaign:setEnabled(false)
        buttonMultiplayer:setEnabled(false)
    else
        buttonQuickMission:setEnabled(true)
        buttonFastCreateMission:setEnabled(true)
        buttonTraining:setEnabled(true)
        buttonShowReplays:setEnabled(true)
        buttonOpenMission:setEnabled(true)
        buttonMissionEditor:setEnabled(true)
        buttonCampaignBuilder:setEnabled(true)
        buttonCampaign:setEnabled(true)
        buttonMultiplayer:setEnabled(true and (not(net.NO_SERVER and net.NO_CLIENT)))
    end
end

function create(x, y, w, h)
	window = DialogLoader.spawnDialogFromFile('MissionEditor/modules/dialogs/me_main_menu.dlg', cdata)
	window:setBounds(x, y, w, h)

	local cx, cy, client_w, client_h = window:getClientRect()
	win_w, win_h =	client_w, client_h

	placeStaticButtonsBackground(client_w, client_h)	
	placeButtonsContainer(client_w, client_h)
	placeLogoEDStatic(client_w, client_h)
	placeLogoInjunStatic(client_w, client_h)
	placeLogoGameStatic(client_w, client_h)
	placeLogoCompStatic(client_w, client_h)
	placeVersionStatic(client_w, client_h)
	placeLogoBetaStatic(client_w, client_h)
	placeDisclaimer(client_w, client_h)
	copyButtonsIntoModule()
	
	if (ProductType.getOpt('enableModulesManager') == false) then
		buttonModulesManager:setVisible(false) -- отключение менеджера модулей
	end
	
	createPanelPlugins(client_w, client_h)
	
	pNews = panel_news.create(0, h-570-(h-768)/2, w, h)
	pInfo = panel_infoPlugin.create(0, 0, w, h);
	panel_infoPlugin.show(false)
	panel_infoPlugin.setPosition(300,300)
	
	-- панель новостей
	window:insertWidget(pNews)
	
	-- панель информации
	window:insertWidget(pInfo)
	
	bLoginLogout	= window.bLoginLogout
	sLogin			= window.sLogin
	sIndicator 		= window.sIndicator
	tbOfflineMode   = window.tbOfflineMode
	sOfflineTime    = window.sOfflineTime
	
	sLogin:setVisible(false)
	local nw,nh = bLoginLogout:calcSize()
	-- bLoginLogout:setText(cdata.logout)
	bLoginLogout:setTooltipText(cdata.logout_tooltip)
	local nw2,nh2 = bLoginLogout:calcSize()	 
	if nw2 > nw then
		nw = nw2
	end
	bLoginLogout:setSize(nw,30)
	
	if ProductType.getType() == "DCSPRO" or base.__PRODUCT_ID__ == 2 then
		bLoginLogout:setVisible(false)	
	end
	
	tbOfflineMode.onChange = onChange_tbOfflineMode
	
	if ProductType.getOpt('noOffline') == true then
		tbOfflineMode:setVisible(false)
	end
end

function setLoginData(a_bLoginState, a_sLoginText, a_sLoginVisible)
	bLoginLogout:setState(a_bLoginState)
	sLogin:setText(a_sLoginText)
	sLogin:setVisible(a_sLoginVisible)
	
	local nw = sLogin:calcSize()	
	window.sLogin:setSize(nw,20)	
end

function updateOfflineMode(a_offlineMode)
	if (ProductType.getType() ~= "STEAM") and (ProductType.getOpt('noOffline') ~= true) then
		tbOfflineMode:setVisible(true)
		buttonOptions:setPosition(544, 6)	
	else
		tbOfflineMode:setVisible(false)
		buttonOptions:setPosition(600, 6)			
	end
	
	offlineMode = a_offlineMode
	buttonMultiplayer:setEnabled(bEnableTerrain and not(net.NO_SERVER and net.NO_CLIENT ))
	tbOfflineMode:setState(a_offlineMode)
	
	if (a_offlineMode == true) then
		tbOfflineMode:setTooltipText(cdata.DisablingOfflineMode)
		sIndicator:setVisible(false)		
	else
		tbOfflineMode:setTooltipText(cdata.EnablingOfflineMode)
	end

	panel_news.updateOfflineMode(a_offlineMode)
	updateOfflineTimeWidget(true)
end

function updateOfflineTimeWidget(b)
	local offline203 = panel_auth.getOffline203()

	if b == true and offline203 == true and (ProductType.getType() ~= "STEAM")  then
		sOfflineTime:setVisible(true)
		local expires = panel_auth:getExpires()
		if expires then
			offlineTimeEnd = expires - base.os.time()
			realTimePrev = base.os.clock()
			sOfflineTime:setEnabled(true)
			sOfflineTime:setText("--/--:--:--")
			UpdateManager.add(updateOfflineTime)	
		else
			sOfflineTime:setText("00/00:00")
		end		
	else
		sOfflineTime:setVisible(false)
		UpdateManager.delete(updateOfflineTime)
	end
end


function updateOfflineTime()
	local realTime = base.os.clock()

	if realTimePrev then
		if realTime - realTimePrev >= 1 then
			offlineTimeEnd = offlineTimeEnd - realTime + realTimePrev
			realTimePrev = realTime

			local value = offlineTimeEnd
			local dd = base.math.floor(value / 86400)
			value = value - dd * 60*60*24
			local hh = base.math.floor(value / 3600)
			value = value - hh * 60*60
			local mm = base.math.floor(value / 60)
			value = value - mm *60
			local ss = base.math.floor(value)

			local dateStr = _("Time Left: ")..base.string.format("%2i/%02i:%02i:%02i", dd, hh, mm, ss)

			sOfflineTime:setText(dateStr)
			
			if value <= 0 then
				sOfflineTime:setEnabled(false)
				return true
			end
		end
	else
		realTimePrev = realTime
	end
end
	
function createPanelPlugins(client_w,client_h)
	local locale = i18n.getLocale()
	plData = {}
	if (base.plugins ~= nil) then	
		for i, plugin in ipairs(base.plugins) do
			if plugin.Skins ~= nil and plugin.applied == true then
				for pluginSkinName, pluginSkin in pairs(plugin.Skins) do	
					local data 			= {}
					data.name 			= pluginSkin.name
					data.dirSkins		= plugin.dirName.."/"..pluginSkin.dir
					data.dirRoot		= plugin.dirName
					data.version 		= plugin.version
					data.creditsFile 	= plugin.creditsFile
					data.state 			= plugin.state
					data.id			 	= plugin.id
					data.infoWaitScreen = plugin.infoWaitScreen	
					data.displayName	= plugin.displayName or plugin.localizedName or ""
					if plugin.linkBuy then						
						data.linkBuy 	= plugin.linkBuy[ProductType.getType()]
						if data.linkBuy and (ProductType.getType() == "ED") then
							if (locale =='ru' or locale == 'de'
                                or locale == 'cn' or locale == 'fr') then                                
                                data.linkBuy = base.string.gsub(data.linkBuy, '/en/shop/', '/'..locale..'/shop/')
							end
						end
					end
					data.info 		= plugin.info or plugin.description or ""
					local name = plugin.id .. pluginSkinName
					data.fullName = name
					
					plData[name] = { data = data }
				end
			end
		end
		
		pluginPanel = plPanel.new()
		
		local panel = pluginPanel:create(20, client_h - 175-hDisclaimer, client_w-40-292, 170, plData, callbackPL, "main", closeInfo);

		window:insertWidget(panel)
	end	
	
	local defaultData = {}
	defaultData.dirSkins	= "./MissionEditor/images/"
	plData[defaultSkinName] = { data = defaultData }
	
	local userData = {}
	userData.dirSkins	= lfs.writedir() .. "MissionEditor/themes/main/"
	userData.dirRoot	= lfs.writedir() .. "MissionEditor/themes/main"
	plData[userSkinName] ={ data = userData }
end

function callbackPL(a_data, a_coord)
	openInfo(a_data, a_coord)
end

function openInfo(a_data, a_coord)
	panel_infoPlugin.setPosition(a_coord.x-78, a_coord.y-258) 
	panel_infoPlugin.show(true)
	a_data.setWallpaper	= setWallpaper
	panel_infoPlugin.setData(a_data)
end

function closeInfo()
	panel_infoPlugin.show(false)
end

function setWallpaper(a_id)
	if (a_id == nil) or (plData[a_id] == nil) then
		a_id = defaultSkinName
	end
	
	local data = nil
	data = plData[a_id].data

	setMusic(data.dirRoot, data.dirSkins)
	waitScreen.setText(data.infoWaitScreen)
	progressBar.setTextStatic(data.infoWaitScreen)
	setSkin(data.dirSkins)
	MeSettings.setMainMenuSkinName(data.fullName or a_id)
end		
		
function setMusic(a_dir, a_dirSkins)
	local fileIn	= "EditorMusic/Default MainMenuIn.ogg"
	local fileLoop	= "EditorMusic/Default MainMenuLoop.ogg"	

	function setPathMusic(a_Path, a_fileIn, a_fileLoop)
		if (a_Path ~= nil) then
			local fileInNew	= a_Path.."/EditorMusic/MainMenuIn.ogg"
			local fileLoopNew	= a_Path.."/EditorMusic/MainMenuLoop.ogg"

			local a = lfs.attributes(fileInNew)
			local d = lfs.attributes(fileLoopNew)	

			if (a and (a.mode == 'file') and 
				d and (d.mode == 'file')) then		
				a_fileIn	= fileInNew
				a_fileLoop	= fileLoopNew 
			end
		end
	
		return a_fileIn, a_fileLoop
	end
	
	if (a_dir ~= nil) then
		fileIn, fileLoop = setPathMusic(a_dir.."/Sounds", fileIn, fileLoop)	
	end

	fileIn, fileLoop = setPathMusic(a_dirSkins, fileIn, fileLoop)	
	
	local playList = 
	{
		fileIn,
		fileLoop
	}
	music.stop()
	music.start(playList) 
end

function setSkin(a_dir)
	if (a_dir ~= nil) then
		local pathMarker = '$'
		
		if ImageSearchPath.getTopPathMarker() == pathMarker then
			-- если на вершине стека путей находится путь,
			-- установленный ранее другим плагином,
			-- то выталкиваем его
			ImageSearchPath.popPath()
		end
		
		ImageSearchPath.pushPath(a_dir .. "/ME/", pathMarker)
		
		-- перерисовка текстур в виджетах
		window:setSkin(window:getSkin())
		window.staticGameLogo:setSkin(window.staticGameLogo:getSkin())		-- 'MainMenulogo.png'
		window.staticLogoComp:setSkin(window.staticLogoComp:getSkin()) -- логотип для UH-1H		
	end	
end

function changeOfflineModeOn()
	updateOfflineMode(panel_auth.getOfflineMode())
	tbOfflineMode:setEnabled(true)
end

function changeOfflineModeOff(a_result)
	updateOfflineMode(panel_auth.getOfflineMode())
	tbOfflineMode:setEnabled(true)
	if a_result == true then
		base.restartME()
	end
end

function onChange_tbOfflineMode()
	closeInfo()
	if (tbOfflineMode:getState() == true) then
		local result = false
		local handler = MsgWindow.warning(_("You are about switching to OFFLINE MODE. All network services incl. \nMultiplayer game, Module Manager, News etc. will be unavailable. \nYou can enable ONLINE MODE again ONLY from this computer. \n\nPlease confirm OFFLINE MODE\n"), _("WARNING"), _("YES"), _("CANCEL"))
		function handler:onChange(buttonText)
			result = (buttonText == _("YES"))
		end 
		handler:show() 
		
		if result == true then
			tbOfflineMode:setEnabled(false)
			panel_auth.setOfflineMode(true, changeOfflineModeOn)
			Analytics.report_lycense_mode(Analytics.LicenseMode.Offline)
		else
			tbOfflineMode:setState(false)	
		end
	else
		tbOfflineMode:setEnabled(false)
		panel_auth.setOfflineMode(false, changeOfflineModeOff)	
		Analytics.report_lycense_mode(Analytics.LicenseMode.online)
	end
end

function setLogoVisible(a_bVisible)
	staticLogoBeta:setVisible(a_bVisible)
end

function isCreate()
	return window ~= nil
end

function setVisible(a_bVisible)
	window:setVisible(a_bVisible)
end

function setIndicatorMM(a_bVisible, a_iValue)
	sIndicator:setVisible(a_bVisible)
	
	if a_iValue ~= nil then
		sIndicator:setText(a_iValue)
	end
end

function setupCallBacks(a_tblCallbacks)
	buttonExit.onChange					= a_tblCallbacks.onExit
	buttonMultiplayer.onChange 			= a_tblCallbacks.onMultiplayer
	buttonOptions.onChange 				= a_tblCallbacks.onOptions
	buttonPilotLogbook.onChange 		= a_tblCallbacks.onPilotLogbook
	buttonEncyclopedia.onChange 		= a_tblCallbacks.onEncyclopedia
	buttonCampaign.onChange 			= a_tblCallbacks.onCampaign
	buttonFastCreateMission.onChange 	= a_tblCallbacks.onFastCreateMission
	buttonCampaignBuilder.onChange 		= a_tblCallbacks.onCampaignBuilder
	buttonMissionEditor.onChange 		= a_tblCallbacks.onMissionEditor
	buttonModulesManager.onChange 		= a_tblCallbacks.onModulesManager
	buttonOpenMission.onChange 			= a_tblCallbacks.onOpenMission
	buttonTraining.onChange 			= a_tblCallbacks.onTraining
	buttonShowReplays.onChange 			= a_tblCallbacks.onReplays
	buttonQuickMission.onChange 		= a_tblCallbacks.onQuickMission
	bLoginLogout.onChange 				= a_tblCallbacks.onbLoginLogout
end
