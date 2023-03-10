local base = _G

module('me_campaign')

-- Данный модуль реализует концепцию полудинамических кампаний,
-- предложенную Мэтом Вагнером.
-- Игра основывается на файле кампании, в котором описываются стадии кампании.
-- Стадия кампании состоит из перечня возможных миссий, из которых в игре выбирается 
-- случайным образом одна, в зависимости от результата предыдыщей стадии.
-- Для каждой миссии в файле кампании задается интервал вероятности для ее выбора.
-- Если миссия пройдена успешно (результат >= 0.5), то в игре производится переход на
-- следующую стадию кампании, иначе - на предыдущую. 
-- Если проиграна миссия из первой стадии кампании, то игра считается проигранной.
-- Если выиграна миссия из последней стадии кампании, то игра считается выигранной.
-- Игра может быть приостановлена между стадиями, история игры сохраняется в ее файле.
-- Любую игру можно переиграть с начала.
-- Каждый игрок имеет доступ только к своим играм.
-- Имя текущего игрока может быть переключено в Logbook.

local require 	= base.require
local tostring 	= base.tostring
local ipairs 	= base.ipairs
local pairs 	= base.pairs
local string 	= base.string
local print 	= base.print
local table 	= base.table

local Static 			= require('Static')
local U 				= require('me_utilities')
local MsgWindow 		= require('MsgWindow')
local LogbookModule 	= require('me_logbook')
local lfs 				= require('lfs')
local MissionModule 	= require('me_mission')
local AutoBriefingModule = require('me_autobriefing')
local i18n 				= require('i18n')
local CampaignEnd 		= require('me_campaign_end')
local SkinUtils 		= require('SkinUtils')
local MeSettings		= require('MeSettings')
local ListBoxItem		= require('ListBoxItem')
local textutil 			= require('textutil')
local UC			    = require('utils_common')
local TheatreOfWarData  = require('Mission.TheatreOfWarData')
local waitScreen        = require('me_wait_screen')
local DialogLoader		= require('DialogLoader')
local Gui               = require('dxgui')
local Analytics			= require("Analytics")
local log      			= require('log')
local ProductType 		= require('me_ProductType') 
local mod_dictionary    = require('dictionary')
local UpdateManager		= require('UpdateManager')
local panel_waitDsbweb  = require('me_waitDsbweb')

i18n.setup(_M)

local campaignDir = nil
local grid
local campaignEndForm_
local hashCampaignTerrains = {}
local dataStart = {}

cdata = {
	campaign = _('CAMPAIGN'),
	player = _('PLAYER'),
	game = _('GAME'),
	history = _('HISTORY'),
	mission = _('Mission Name'),
	campaign_name = _('Campaign Name'),
	rate = _('Rate %'),
	status = _('Status'),
	error = _('ERROR'),
	warning = _('WARNING'),
	invalid_game = _("Can't open game file"),
	ok = _('OK'),
	cancel = _('CANCEL'),
	resume = _('RESUME CAMPAIGN'),
	exit = _('EXIT'),
	next = _('NEXT'),
	restart_campaign = _('RESTART_CAMPAIGN'),
	win = _('Win'),
	defeat = _('Defeat'),
	inactive = _('Inactive'),
	run_on = _('Active'),
	restart = _('RESTART'),
	new_game = _('NEW GAME'),
	stg = _('STG'),
	stage = _('STAGE'),
	progress = _('Progress'),
	campaign_completed = _('Campaign successfully completed'),
	campaign_failed = _('Campaign failed'),
	mission_failed = _('Failed'),
	mission_succeeded = _('Success'),
	restart_warning = _('Are you sure you want to restart campaign?\n Whole history of your missions will be lost'),
	bad_campaign = _('Bad campaign, no mission can be chosen'),
	campaign_finished = _('Campaign finished, you need to chose another campaign\n or restart current campaign'),
	leftBtn = _('CANCEL'),
	rightBtn = _('NEXT'),
	middleBtn = _('RESTART\nCAMPAIGN'),
	campaign_description = _('Campaign Description'),
	missions = _('Missions'),
	select_campaign = _('SELECT CAMPAIGN'),
    Modules = _("Modules"),
    Campaigns = _("Campaigns"),
    Campaign_cap = _("CAMPAIGN"),
    Description = _("Description"),
	START		= _("PLAY AGAIN"),

	lastMissionFlown = _('Last Mission Flown'),
	campaignState = _('Campaign State'),
	missionsFlown = _('Missions Flown'),
	deathsInCampaign = _('Deaths in Campaign'),
	missionSuccessRate = _('Mission Success Rate'),
	airToGroundKills = _('Air to Ground Kills'),
	airToAirKills = _('Air to Air Kills'),
	campaignDetails = _('Campaign Details'),
	file_not_found = _('Mission file %s not found in "%s"'),
	emptyStage = _('Empty stage #%d found in "%s"'),
	user		= _('User'),
    Mycampaigns = _('My campaigns'),
	
	Active		= _('Active'),
	Success		= _('Success'),
	Failed		= _('Failed'),
	Skipped		= _('Skipped'),
	Draw		= _('Draw'),
	
	Skip		= _('SKIP'),
	HIDE		= _('HIDE'),
	SHOW		= _('SHOW'),
	Score		= _('Score'),
	Status		= _('Status'),
	Namemission = _('Mission Name'),
	noValidHistory = _('The developer "%s" has rebuilt the campaign completely and your progress cannot be restored, your progress is reset.')
}

local nameCellSkin
local nameCellSelSkin
local nameSelectedCellSkin
local statusCellSkin
local statusCellSelSkin
local statusSelectedCellSkin
local panelsHist = {} -- таблица всех прохождений миссий

local curCLSID = -1
local rowLast

campaigns = {}
campaignsByPath = {}
local dataMissions = {}

function getActiveCampaign()
	return activeCampaign
end

function setActiveCampaign(campaign)
	activeCampaign = campaign
    if activeCampaign ~= nil then
        btnRestart:setEnabled(true)
		selectCampaign(campaign)
    else
        btnRestart:setEnabled(false)
    end
end 

local function create_()
	window = DialogLoader.spawnDialogFromFile('MissionEditor/modules/dialogs/campaign_dialog.dlg', cdata)
	
	containerMain 	= window.containerMain
    middlePanel 	= containerMain.middlePanel
    footerPanel   	= containerMain.footerPanel
    headPanel   	= containerMain.headPanel

	grid = middlePanel.scrollgridCampaigns
    
    windowSkin = window:getSkin()
	
	pNoVisible				= window.pNoVisible
    btnCancel               = footerPanel.btnCancel
 	btnOk                   = footerPanel.btnOk
    btnClose                = headPanel.btnClose
    btnRestart              = footerPanel.btnRestart
    staticPicture           = middlePanel.containerCampaignDescription.widgetCampaignPicture
    sDescription            = middlePanel.containerCampaignDescription.sCampaignDescriptionText
    spCampaignDescription   = middlePanel.containerCampaignDescription
    listModuls              = middlePanel.listModuls
	tbDeploy				= middlePanel.containerCampaignDetails.tbDeploy
	pMissions				= middlePanel.containerCampaignDetails.pMissions
	pMis					= pNoVisible.pMis
	pDown					= middlePanel.containerCampaignDetails.pDown
	pHeader					= pNoVisible.pHeader
    
	pMisSkin				= pMis:getSkin()	
	pMisSelSkin				= pNoVisible.pMisSel:getSkin()	
    nameCellSkin            = pNoVisible.staticNameCell:getSkin()	
	statusCellSkin          = pNoVisible.staticStatusCell:getSkin()
    nameHoverCellSkin    	= window.staticNameCellHover:getSkin()
    nameSelectedCellSkin    = pNoVisible.staticNameSelectedCell:getSkin()
	statusHoverCellSkin  	= window.staticStatusCellHover:getSkin()
	statusSelectedCellSkin  = pNoVisible.staticStatusSelectedCell:getSkin()
    nameCellSelSkin         = window.staticNameCellHover:getSkin()	
	statusCellSelSkin       = window.staticStatusCellHover:getSkin()
	
	sStatusActiveSkin	= pNoVisible.sStatusActive:getSkin()
	sStatusSuccessSkin	= pNoVisible.sStatusSuccess:getSkin()
	sStatusFailedSkin	= pNoVisible.sStatusFailed:getSkin()
	sStatusSkippedSkin	= pNoVisible.sStatusSkipped:getSkin()
	sStatusDrawSkin		= pNoVisible.sStatusDraw:getSkin()
	

	-- это должны быть два разных скина!
	staticPictureDefaultSkin = staticPicture:getSkin()
	staticPictureSkin = staticPicture:getSkin()
    staticPicture:setSkin(SkinUtils.setStaticPicture("", staticPictureSkin)) 


	setupCallbacks(window)
    
    listBoxModulItemSkin = pNoVisible.listBoxModulItem:getSkin()    
     
    resize()
    
    local game = LogbookModule.getCurrentGame()
	
	if game then      
		setActiveCampaign(campaignsByPath[textutil.Utf8ToLowerCase(game.campaign)])
	else
		setActiveCampaign(campaigns[1])
	end
	
	tbDeploy.onChange = onChange_tbDeploy
	tbDeploy:setState(true)
    
    loadBoughtCampaigns()
    fillModulesCombo()	    
end

function resize()
    w, h = Gui.GetWindowSize()
    
    window:setBounds(0, 0, w, h)
    containerMain:setBounds((w-1280)/2, (h-768)/2, 1280, 768)
    
end

function loadBoughtCampaigns()
    boughtCampaign = {}
    local locale = i18n.getLocale()
    
    for i, plugin in ipairs(base.plugins) do
        if plugin._loader_info and plugin._loader_info.type == "campaign" then  
            local dirName = plugin.dirName
            local fullCampName = plugin.dirName.."/"..locale            
            local a = lfs.attributes(fullCampName)
            if (not a or a.mode ~= 'directory') then
                fullCampName = dirName.."/EN"
                a = lfs.attributes(fullCampName)
            end
            
            if not(a and a.mode == 'directory') then 
                fullCampName = dirName
            end

            for fileName in lfs.dir(fullCampName) do
                local fullName = fullCampName .. '/' .. fileName 
                local a = lfs.attributes(fullName)
                if (a.mode == 'file') and (string.sub(fileName,-4,-1) == '.cmp') then
                    local fname = fullName
                    local c = loadCampaign(fname, doNotReportErrors)

                    if c ~= nil then
                        c.path = base.string.gsub(fullName, '\\', '/')
                        c.file = base.string.gsub(fileName, '\\', '/') 
                        c.dir = base.string.gsub(fullCampName, '\\', '/') 
						c.developerName = plugin.developerName or "Unknown"
                        table.insert(campaigns, c)
                        campaignsByPath[textutil.Utf8ToLowerCase(c.path)] = c
                        if c.necessaryUnits then
                            for k,type in base.pairs(c.necessaryUnits) do
                                if base.aircraftFlyableInPlugins[type] then
                                    modulId = base.aircraftFlyableInPlugins[type]
                                    boughtCampaign[modulId] = boughtCampaign[modulId] or {}
                                    boughtCampaign[modulId][#boughtCampaign[modulId]+1] = c
                                end
                            end
                        end
						
						if plugin.forModules then
							for k,modulId in base.pairs(plugin.forModules) do
								boughtCampaign[modulId] = boughtCampaign[modulId] or {}
                                boughtCampaign[modulId][#boughtCampaign[modulId]+1] = c
							end
						end
                    end
                end
            end
        end
    end
 
end


function getActiveCampaignMission()
	local game = LogbookModule.getGame(getActiveCampaign())
	if not game then 
		game = createNewGame()
	end
	if #game.history > 0 then
		local missionFile = game.history[#game.history].mission
		return missionFile
	else
		local missionFile = game.history[#game.history].mission
		return missionFile
	end
end

function restartCampaign()
	local activeCampaign = getActiveCampaign()
    if activeCampaign ~= nil then
        createNewGame(activeCampaign)
    end
end

function update()    

	fillCampaignsGrid()
	updateCampaignDescription()
	updateStatistics() 

	local camp = getActiveCampaign()
	local enable = camp ~= nil

	btnOk:setEnabled(enable)
--	form:getMiddleButton():setEnabled(enable)
end

local function findCampaigns(dirName, a_modulId, a_developerName)
    if dirName then
        for f in lfs.dir(dirName) do
            local fullName = dirName .. '/' .. f 
            local a = lfs.attributes(fullName)
            
            if a then
                if (a.mode == 'directory') and (f ~= '.') and (f~='..') and (f~='.svn')then 
                    loadDir(fullName, a_modulId, nil, a_developerName)
                elseif (a.mode == 'file') and (string.sub(f,-4,-1) == '.cmp') then
                    local fname = fullName
                    local c = loadCampaign(fname)
                    
                    if c ~= nil then
                        c.path = base.string.gsub(fullName, '\\', '/')
                        c.file = base.string.gsub(f, '\\', '/')
                        c.dir = base.string.gsub(dirName, '\\', '/')
						c.developerName = a_developerName or "Unknown"
						if modul and modul.developerName then
							c.developerName = modul.developerName
						end
                        table.insert(campaigns, c)
                        campaignsByPath[textutil.Utf8ToLowerCase(c.path)] = c
                    end
                end
            end
        end
    end
end
-- Сформировать список файлов кампаний.
function loadDir(dirName, a_modulId, dirMulty, a_developerName)
	findCampaigns(dirName, a_modulId, a_developerName)
	findCampaigns(dirMulty, a_modulId, a_developerName)
	
	-- добавляем покупные
	if boughtCampaign[a_modulId] then
		for k,c in base.pairs(boughtCampaign[a_modulId]) do
			if campaignsByPath[textutil.Utf8ToLowerCase(c.path)] == nil then
				table.insert(campaigns,c)
				campaignsByPath[textutil.Utf8ToLowerCase(c.path)] = c
			end
		end
	end
end

-- 
function refreshCampaigns()
	curCLSID, rowLast = MeSettings.getLastCampaign()
	
	curCLSID = curCLSID or -1

	local firstCampaignData = nil
	local data = {}

	for i=0,listModuls:getItemCount()-1 do
        local item = listModuls:getItem(i)
        if item then
            if firstCampaignData == nil then
                firstCampaignData 		    = {}
                firstCampaignData.dir 	    = item.dir
                firstCampaignData.dirMulty 	= item.dirMulty
                firstCampaignData.CLSID     = item.CLSID
                firstCampaignData.item      = item
            end

            if (item.CLSID == curCLSID) then
                data.dir        = item.dir
                data.dirMulty   = item.dirMulty
                data.item       = item
            end
        end    
	end

    if (firstCampaignData ~= nil) then
        if (data.dir == nil and data.dirMulty == nil and data.item == nil) then
            data.dir        = firstCampaignData.dir
            data.dirMulty   = firstCampaignData.dirMulty
            curCLSID        = firstCampaignData.CLSID
            data.item       = firstCampaignData.item
        end

        if (data.item ~= nil) then
            listModuls:selectItem(data.item)
            listModuls:setItemVisible(data.item)
            local campaignDir
            if data.dir then
                campaignDir = data.dir
            end
            campaigns = {}
            campaignsByPath = {}
            loadDir(campaignDir,data.item.modulId,data.dirMulty, data.item.developerName)
        end
    end
end

function fillCampaignsGrid()
	if not window then 
		return 
	end

	grid:clearRows()

	table.sort(campaigns, 
		function(p1,p2)	 
			if (p1~= nil) and (p2~= nil) then
				if p1.name == p2.name then
					return p1.path < p2.path 
				else
					return p1.name < p2.name 
				end
			else
				return false
			end
		end)

	local rowHeight = 18

	for i, campaign in ipairs(campaigns) do
		local rowIndex = i - 1

		grid:insertRow(rowHeight)

		local nameSkin
		local statusSkin

		if campaign == getActiveCampaign() then 
			grid:selectRow(rowIndex)
		end

        local locale = i18n.getLocale()
        local nameCell = Static.new((campaign["name_"..locale] or campaign.name)) --debug .." --- "..(campaign.developerName or "  111"))
        nameCell:setSkin(nameCellSkin)
        grid:setCell(0, rowIndex, nameCell)
        nameCell.data = {row = rowIndex, campaign = campaign, enable = campaign.enable}
		if campaign.theatre then
			nameCell:setTooltipText(_("Missing module")..": "..campaign.theatre)
		end
		nameCell:setEnabled(campaign.enable)

        local statusCell = Static.new(cdata.inactive)
        statusCell:setSkin(statusCellSkin)

        grid:setCell(1, rowIndex, statusCell)
        statusCell.data = {row = rowIndex, campaign = campaign}
		statusCell:setEnabled(campaign.enable)

        local game = LogbookModule.getGame(campaign)
		
        if game then
            local lastMisInd = getLastMissionIndex(game)
            if lastMisInd >= 1 then 				
                statusCell:setText(game.status)
            end
        end

	end
end

function selectRow(rowIndex)
	local nameCell = grid:getCell(0, rowIndex) 

	if nameCell and nameCell.data.enable then
		local statusCell = grid:getCell(1, rowIndex)

		statusCell:setSkin(statusSelectedCellSkin)
		grid:selectRow(rowIndex)
    else
        setActiveCampaign(nil)
        sDescription:setText("")
        sDescription:setSize(273,20)
        spCampaignDescription:updateWidgetsBounds()
        staticPicture:setSkin(SkinUtils.setStaticPicture("", staticPictureSkin)) 
        updateStatistics()
	end
end 

function selectCampaign(campaign)
	for i = 0, grid:getRowCount() - 1 do
		local w = grid:getCell(0, i)

		if w.data.campaign == campaign then
			selectRow(i)
			return
		end
	end

	selectRow(0)
end

function onListModulsChange(self, item)  
    curCLSID = item.CLSID
    
    campaigns = {}
	campaignsByPath = {}
	loadDir(item.dir, item.modulId, item.dirMulty, item.developerName)

	update()
	selectRow(0)
	rowLast = 0
	local cell = grid:getCell(0, 0)
	if cell then
		onChangeCampaign(cell)
	end

	update()
end

function addItemTolistModuls(plugin,misPath, multyLangCamp)
    local pathPl 
    if misPath or multyLangCamp or boughtCampaign[plugin.id] then
        pathPl = nil
        for pluginSkinName, pluginSkin in pairs(plugin.Skins) do	
                pathPl = plugin.dirName.."/"..pluginSkin.dir                    
        end 
        local listItem = ListBoxItem.new(_(plugin.shortName)) --debug .."("..plugin.developerName..")")  
        if misPath then    
            listItem.dir = base.string.gsub(misPath, '\\', '/')
        end
        if multyLangCamp then
            listItem.dirMulty = base.string.gsub(multyLangCamp, '\\', '/')
        end
        listItem.CLSID = plugin.id
        listItem:setSkin(listBoxModulItemSkin)
        listItem.modulId = plugin.id
		listItem.developerName = plugin.developerName
        if pathPl then
            local SkinItem = listItem:getSkin()
            local filename = pathPl..'\\icon-38x38.png'	
            if lfs.attributes(filename)	== nil then
                filename = 'dxgui\\skins\\skinME\\images\\default-38x38.png'
            end
            SkinItem.skinData.states.released[1].picture.file = filename
            SkinItem.skinData.states.released[2].picture.file = filename
            SkinItem.skinData.states.hover[1].picture.file = filename
            SkinItem.skinData.states.hover[2].picture.file = filename
            listItem:setSkin(SkinItem)
        end
        listModuls:insertItem(listItem)
    end 
end

function fillModulesCombo()	
    listModuls:clear()

    local locale = i18n.getLocale()
    
    local dirQuser
	path = base.userFiles.userCampaignPath
	dirQuser = i18n.getLocalizedDirName(path)

	if (dirQuser == nil) or (dirQuser..'/' == path ) or (dirQuser == path ) then
		if (base.__FINAL_VERSION__) then
			dirQuser = base.userFiles.userCampaignPath
		else
			dirQuser = i18n.getLocalizedDirName(base.userFiles.userCampaignPath)
		end 
	end

	local listItem = ListBoxItem.new(cdata.Mycampaigns)            
    listItem.dir = base.string.gsub(dirQuser, '\\', '/')
    listItem.dirMulty = path.."MultiLang"
    listItem.CLSID = "UserCLSID"
    listItem:setSkin(listBoxModulItemSkin)
    local SkinItem = listItem:getSkin()
    local filename = 'dxgui\\skins\\skinME\\images\\campaign\\My campaigns - icon.png'
    SkinItem.skinData.states.released[1].picture.file = filename
    SkinItem.skinData.states.released[2].picture.file = filename
    SkinItem.skinData.states.hover[1].picture.file = filename
    SkinItem.skinData.states.hover[2].picture.file = filename
    listItem:setSkin(SkinItem)
    listModuls:insertItem(listItem)

	local tmpPlugins 
	for index, plugin in pairs(base.plugins) do
		tmpPlugins = tmpPlugins or {}
		base.table.insert(tmpPlugins,plugin) 
	end
	
	if tmpPlugins then
		base.table.sort(tmpPlugins, base.U.compTableShortName)
		for k, plugin in ipairs(tmpPlugins) do
			local pluginName = plugin.id
			if plugin.Skins ~= nil and plugin.applied == true then
				local misPath = nil
				----------------
				local pluginMissions = plugin.Missions
				if pluginMissions and base.type(pluginMissions) == "table" then
					for missionName, mission in pairs(pluginMissions) do
						local name = pluginName .. missionName
						local multyLangCamp
						if lfs.attributes(plugin.dirName.."/Missions/Campaigns") ~= nil then
							multyLangCamp = plugin.dirName.."/Missions/Campaigns"
						end    
						
						local dir = plugin.dirName.."/Missions/"..locale.."/Campaigns"
						local dirEN = plugin.dirName.."/Missions/EN/Campaigns"
						local a, err 		= lfs.attributes(dir)
						local aEN, errEN 	= lfs.attributes(dirEN)
						if a and (a.mode == 'directory') then
							misPath = dir
						else
							if aEN and (aEN.mode == 'directory') then
								misPath = dirEN
							end
						end
						addItemTolistModuls(plugin, misPath, multyLangCamp)
					end
				end          
			end    
		end       
	end	
end
 
local function updateWindowPicture()
	window:setSkin(windowSkin)
end

function returnFromAutobrief()
	dataStart = {}
	show(true)
end

-- показать окно
function show(b, a_returnScreen)
	if b then
		if not window then
			create_()
		end
		
		returnScreen = a_returnScreen
		refreshCampaigns()
		update() 

		if (rowLast) then
			local cell = grid:getCell(0, rowLast)
			
			if cell then
				onChangeCampaign(cell)
			end
		end
		
		updateWindowPicture()
		Analytics.pageview(Analytics.Campaign)
	end

	if window then
		window:setVisible(b)
	end
end

function showError(text)
	MsgWindow.error(text, cdata.error, cdata.ok):show()
end

function isFileExist(fullPath)
	local attr = lfs.attributes(fullPath)

	if not attr then
		return false
	else
		if 'file' == attr.mode then
			return true
		else
			return false
		end
	end
end


function checkCampaignIntegrity(campaign, doNotReportErrors)
	for stageNumber, stage in pairs(campaign.stages) do 
		if #stage.missions < 1 then
			if not doNotReportErrors then 
				showError(string.format(cdata.emptyStage, stageNumber, campaign.fullPath))
			end
			
			return false
		end
		for missionNumber, mission in ipairs(stage.missions) do
			local fullPath = campaign.directory .. mission.file
			mission.fullpath = fullPath
			if not isFileExist(fullPath) then
				if not doNotReportErrors then 
					showError(string.format(cdata.file_not_found, fullPath, campaign.fullPath))
				end
				
				return false
			end
		end
	end
	
	return true
end

local function verifyTheatres(campaign)
    for stageNumber, stage in pairs(campaign.stages) do 
		for missionNumber, mission in ipairs(stage.missions) do
			local fullPath = campaign.directory .. '/' .. mission.file
            if hashCampaignTerrains[fullPath] and hashCampaignTerrains[fullPath][1] then
                return hashCampaignTerrains[fullPath][1], hashCampaignTerrains[fullPath][2]
            end
			
			local theatre = UC.getNameTheatre(fullPath)
            hashCampaignTerrains[fullPath] = {TheatreOfWarData.isEnableTheatre(theatre), theatre}
            if hashCampaignTerrains[fullPath][1] == false then				
                return false, theatre
            end
		end
	end
    return true
end

function loadCampaign(campaignPath, doNotReportErrors)
	local path = campaignPath
	local env = {}
	local file = base.io.open(path, 'rb')
	if file then
		file:close()
		local f = base.assert(base.loadfile(path))
		
		if f then
			base.setfenv(f, env)
			local ok, res = base.pcall(f)
			if not ok then
				log.error('ERROR: loadCampaign() failed to pcall "'..path..'": '..res)
				return
			end
			
			local campaign = env.campaign
			local revStr = string.reverse(path)
			local ind = string.find(revStr, '/')
			local campaignDir = string.reverse(string.sub(revStr, ind))
			
            local localeU = string.upper(i18n.getLocale())
    
            campaign.name            = campaign["name_"..localeU] or campaign["name_EN"] or campaign.name
            campaign.description     = campaign["description_"..localeU] or campaign["description_EN"] or campaign.description
            campaign.picture         = campaign["picture_"..localeU] or campaign["picture_EN"] or campaign.picture
            campaign.pictureFailed   = campaign["pictureFailed_"..localeU] or campaign["pictureFailed_EN"] or campaign.pictureFailed
            campaign.pictureSuccess  = campaign["pictureSuccess_"..localeU] or campaign["pictureSuccess_EN"] or campaign.pictureSuccess

    
			campaign.directory = campaignDir
			campaign.fullPath = campaignPath
			if checkCampaignIntegrity(campaign, doNotReportErrors) then
				campaign.enable, campaign.theatre = verifyTheatres(campaign)
                return campaign
			else
				return
			end
		end
	end
end

-- создание новой игры (кампании)
function createNewGame(campaign)
	local game = LogbookModule.createNewGame(campaign)
	
	-- Создать стартовую стадию.
	local nextStage = {
		stage = campaign.startStage, 
	}
	-- список миссий на данном этапе кампании
	local missions = campaign.stages[campaign.startStage].missions 
	-- случайным образом выбираем стартовую миссию
	local startMissions = {}
	for i=1,#missions do
		local mission = missions[i]
		if 100 == mission.interval[2] then
			table.insert(startMissions, mission)
		end
	end
	if #startMissions <1 then
		print('No missions with right bound equal to 100 found, choosing first mission')
		if missions[1] then
			nextStage.mission = missions[1].file
		else
			print(cdata.bad_campaign)
		end
	else
		U.randomseed()
		local rnd = U.random(#startMissions)
		nextStage.mission = startMissions[rnd].file
	end

	table.insert(game.history, nextStage)
	LogbookModule.save()
	
	return game
end

local function getCampaignEndForm()
	if not campaignEndForm_ then
		campaignEndForm_ = CampaignEnd.new()
	end
	
	return campaignEndForm_
end

-- выбор следующей миссии кампании
function chooseNextMission(game, campaign)
	local lastGameResults = game.history[#game.history] -- результаты последней миссиии
	local result = lastGameResults.result 
	local newStageIndex -- номер новой ступени
	local newMissionName = '' -- имя новой миссиии
	
	function setCampaignStatus(game)
		local player = LogbookModule.playerByName[LogbookModule.logbook.currentPlayerName] -- данные игрока
		
		for i = 1,#player.games do
			local _game = player.games[i]
			if _game == currentGame then
				_game.status = game.status
				return
			end
		end
	end

	-- просматриваем все уровни кампании чтобы определить на каком из них мы только что были
	for i = 1,#campaign.stages do 
		if i == lastGameResults.stage then 
			-- нашли уровень	
			if result > 50 or lastGameResults.skipped == true then 
				newStageIndex = i + 1 -- переход на более высокий уровень
				game.status = cdata.run_on 
				if newStageIndex > #campaign.stages then -- кампания выиграна
					game.status = cdata.win 
					setCampaignStatus(game)
					getCampaignEndForm():show(true, campaign)
					break
				end
				print('Moving up to ', newStageIndex)
			elseif result == 50 then
				newStageIndex = i
				game.status = cdata.run_on 
				print('Staying at the same stage', newStageIndex)
			else 
				newStageIndex = i - 1 -- переход на более низкий
				--result = result*2 -- нормируем к единичному интервалу
				print('Moving down to', newStageIndex)
				game.status = cdata.run_on 
				if newStageIndex < 1 then -- кампания проиграна
					game.status = cdata.defeat 
					setCampaignStatus(game)
					getCampaignEndForm():show(false, campaign)
					break
				end
			end

			-- миссии следующей ступени
			local missions = campaign.stages[newStageIndex].missions
			local chosenMissions = {}-- отобранные миссии
			-- выбираем подходящие под результат миссии
			for j = 1,#missions do 
				local interval = missions[j].interval
				
				if (interval[1] <= result) and (result <= interval[2]) then
					table.insert(chosenMissions, missions[j])
				end
			end

			if #chosenMissions == 0 then
				print('error: no mission chosen')
				return
			end
			
			-- если отобранных миссий больше одной, то разыгрываем миссию
			local index = 0
			U.randomseed()
			
			if #chosenMissions > 1 then 
				local rnd = U.random(1, #chosenMissions)
				index = base.math.ceil(rnd)
			else 
				index = 1
			end

			newMissionName = chosenMissions[index].file -- название новой миссии
			
			-- создаем новый пункт в истории
			local historyItem = {}
			historyItem.stage = newStageIndex
			historyItem.mission = newMissionName
			table.insert(game.history, historyItem)
		end
	end
	
	LogbookModule.updateCampMissCount()
	LogbookModule.save()
end

-- установка обработчиков
function setupCallbacks(window)
    btnRestart.onChange = onRestartCampaign -- обработчик диалога рестарта кампании
	btnOk.onChange = onButtonNext                  
    btnClose.onChange = onButtonExit
    btnCancel.onChange = onButtonExit  
    
    listModuls.onChange = onListModulsChange
    
	window:addHotKeyCallback('escape', onButtonExit)
	window:addHotKeyCallback('return', onButtonNext)
	
	function grid:onMouseDown(x, y, button)
		if 1 == button then
			local col
			col, rowLast = self:getMouseCursorColumnRow(x, y)
			if -1 < col and -1 < rowLast then
				self:selectRow(rowLast)				

				local cell = self:getCell(col, rowLast)

				if cell then
					onChangeCampaign(cell)
				end
			end
		end
	end
    
	function grid:onMouseDoubleClick(x, y, button)
		if 1 == button then
			local col
			col, rowLast = self:getMouseCursorColumnRow(x, y)
			if -1 < col and -1 < rowLast then
				self:selectRow(rowLast)

				local cell = self:getCell(col, rowLast)

				if cell then
					onChangeCampaign(cell)
					onButtonNext()
				end
			end
		end
	end
	
	grid:addHoverRowCallback(function(grid, currHoveredRow, prevHoveredRow)
		if -1 < prevHoveredRow then
			unSelectRowMove(prevHoveredRow)
		end
		
		if -1 < currHoveredRow then
			selectRowMove(currHoveredRow)
		end	
	end)	
	
	grid:addSelectRowCallback(function(grid, currSelectedRow, prevSelectedRow)
		local cell = grid:getCell(0, currSelectedRow)

		if cell then
			onChangeCampaign(cell)
		end
	end)	
end

function unSelectRowMove(rowIndex)
    local nameCellLast = grid:getCell(0, rowIndex)
    
    if nameCellLast then
		nameCellLast:setSkin(nameCellSkin)

		local statusCell = grid:getCell(1, rowIndex)
		statusCell:setSkin(statusCellSkin)
	end
end

function selectRowMove(rowIndex)
	local nameCell = grid:getCell(0, rowIndex)    

	if nameCell and grid:getSelectedRow() ~= rowIndex then
		nameCell:setSkin(nameCellSelSkin)

		local statusCell = grid:getCell(1, rowIndex)
		statusCell:setSkin(statusCellSelSkin)
	end
end 

-- обработчик кнопки Exit
function onButtonExit()
	show(false)
	if (returnScreen == 'editor') or base.__PRODUCT_ID__ == 2 then		
		if base.MapWindow.isEmptyME() ~= true then
			base.MapWindow.show(true)
		else
			base.MapWindow.showEmpty(true)
		end	
	else		
		base.mmw.show(true)
	end
end

-- обработчик, получающий результат прохождения миссиии
function onReceiveMissionResults() 
    if not window then
		create_()
	end 
    loadBoughtCampaigns()	
	fillModulesCombo()
	refreshCampaigns()
	
	local game = LogbookModule.getCurrentGame()
	local campaign = campaignsByPath[textutil.Utf8ToLowerCase(game.campaign)]

	if game then
		if (game.history[#game.history].result ~= nil) and (game.status ~= cdata.win) then
			chooseNextMission(game, campaign)
		end
	else
		game = createNewGame(campaign)
	end
	
	if not window then
		create_()
	end
	
	update()
end

-- обработчик кнопки Next
function onButtonNext()
	local activeCampaign = getActiveCampaign()
	local game = LogbookModule.getGame(activeCampaign)
	if not game then
		game = createNewGame(activeCampaign)
		LogbookModule.save()
	end
	if (game.status ~= cdata.defeat) and (game.status ~= cdata.win)then
		local missionFileName = getActiveCampaignMission()
		local missionPath = activeCampaign.dir .. '/' .. missionFileName
		
		panel_waitDsbweb.setUpdateFunction(function()				
			if MissionModule.load(missionPath) == true then
				game.status = cdata.run_on
				LogbookModule.setCurrentGame(activeCampaign)
				LogbookModule.save()
				--saveInFile(curCLSID)
				
				-- FIXME: нужно хранить не индекс строки, а имя кампании
				--base.print("---curCLSID, rowLast----",curCLSID, rowLast)
				MeSettings.setLastCampaign(curCLSID, rowLast)

				base.START_PARAMS.campaignPath = activeCampaign.path
				AutoBriefingModule.returnToME = true
				AutoBriefingModule.setDoSave(true)
				AutoBriefingModule.show(true, 'campaign')
				show(false)
			end
		end)	
	else
		MsgWindow.warning(cdata.campaign_finished, cdata.message, cdata.ok):show()
	end
end

-- обработчик кнопки Restart Campaign
function onRestartCampaign()
	-- вывод диалога подтверждения рестарта
	local handler = MsgWindow.question(cdata.restart_warning, cdata.message, cdata.ok, cdata.cancel)
	
	function handler:onChange(buttonText)
		if buttonText == cdata.ok then 
			restartCampaign()
			update()
		end
	end
	
	handler:show()
end

function onChangeCampaign(cell)
	setActiveCampaign(cell.data.campaign)
	updateCampaignDescription()
	updateStatistics() 

	local camp = getActiveCampaign()
	local enable = camp ~= nil

	btnOk:setEnabled(enable)
end

function getLastMissionIndex(game)
	local lastMissionIndex
	local missionCount = #game.history
	
	if missionCount > 0 then
		if game.history[missionCount].result then
			lastMissionIndex = missionCount
		else
			lastMissionIndex = missionCount - 1
		end
	else
		lastMissionIndex = 0
	end
	
	return lastMissionIndex
end 

function updateStatistics()
	if not window then return end
	
	panel_waitDsbweb.show(true)	
	UpdateManager.add(function()			
		local missionsFlown
		local missionsFlown
		local lastMissionFlown
		local totalResult
		local missionSuccessRate
		local aaKills = 0
		local agKills = 0
		local deathsCount = 0
		local status
		
		local activeCampaign = getActiveCampaign()
		local game = LogbookModule.getGame(activeCampaign)

		updateReStart(game, activeCampaign)

		if game then		
			lastMissionIndex = getLastMissionIndex(game)

			if lastMissionIndex < 1 then
				missionsFlown = ''
				lastMissionFlown = ''
				totalResult = 0
				missionSuccessRate = 0
				aaKills = 0
				agKills = 0
				deathsCount = 0
				status = cdata.inactive
			else
				missionsFlown = lastMissionIndex
				local lastMission = game.history[lastMissionIndex]
				lastMissionFlown = lastMission.datetime

				totalResult = 0
				for i = 1,lastMissionIndex do
					if game.history[i].skipped == true then 
						totalResult = totalResult + 0
					else
						totalResult = totalResult + game.history[i].result
					end
					aaKills = aaKills + game.history[i].aaKills
					agKills = agKills + game.history[i].agKills
					deathsCount = deathsCount + game.history[i].deathsCount
				end
				missionSuccessRate = base.math.ceil(totalResult/lastMissionIndex)
				status = game.status
			end
		else
			missionsFlown = ''
			lastMissionFlown = ''
			totalResult = 0
			missionSuccessRate = 0
			aaKills = 0
			agKills = 0
			deathsCount = 0
			lastMissionIndex = 0
			status = cdata.inactive
		end
		local cont = middlePanel.containerCampaignDetails	
		cont.widgetLastMissionFlown:setText(lastMissionFlown)
		cont.widgetMissionsFlown:setText(tostring(lastMissionIndex))
		
		cont.pDown.widgetDeathsInCampaign:setText(tostring(deathsCount))
		cont.pDown.widgetMissionSuccessRate:setText(missionSuccessRate)
		cont.pDown.widgetAirToGroundKills:setText(tostring(agKills))
		cont.pDown.widgetAirToAirKills:setText(tostring(aaKills))
		
		if tbDeploy:getState() == true then
			pMissions:setVisible(true)				
		else
			pMissions:setVisible(false)
			cont.pDown:setBounds(0, 93, 641, 130)
		end
		cont:updateWidgetsBounds()
		
		panel_waitDsbweb.show(false)
	return true
	end)
end

function updateCampaignDescription()
	if not window then return end

	local camp = getActiveCampaign()

	if not camp then 
		return 
	end
	
    local locale = i18n.getLocale()
	sDescription:setText(camp["description_"..locale] or camp.description)
    local nw, nh = sDescription:calcSize() 
    sDescription:setSize(273, nh+20)
    
    spCampaignDescription:updateWidgetsBounds()

    local picture = camp["picture_"..locale] or camp.picture
	if picture and (picture ~= '') then
		local filename = camp.dir .. '/' .. picture
		staticPicture:setSkin(SkinUtils.setStaticPicture(filename, staticPictureSkin))        
	else 
		staticPicture:setSkin(staticPictureDefaultSkin)
	end
    
    local wP,hP = staticPicture:calcSize()
    staticPicture:setSize(130 * wP/hP,130)
end

function onChange_tbDeploy(self)
	if self:getState() == true then
		self:setText(cdata.HIDE)
	else
		self:setText(cdata.SHOW)
	end
	updateStatistics() 
end

function updateReStart(a_game, a_camp)
	if tbDeploy:getState() == true  then
		panelsHist = {}
		pMissions:clear()
		local offsetY = 0

		if a_game and a_camp then
			if dataMissions[a_game.campaign] == nil then
				dataMissions[a_game.campaign] = dataMissions[a_game.campaign] or {}	
				for k,stage in base.ipairs(a_camp.stages) do
					for kk, mission in base.ipairs(stage.missions) do
						local dataTmp =  mod_dictionary.getCampaignData(mission.fullpath, i18n.getLocale())	
						local sortie
						local descriptionText
						if dataTmp then
							descriptionText = dataTmp.descriptionText or ""
							
							if dataTmp.sortie and dataTmp.sortie ~= "" then 
								sortie = dataTmp.sortie
							else
								sortie =  mission.file
							end
						else
							descriptionText = ""
							sortie =  mission.file
						end

						dataMissions[a_game.campaign][mission.file] =  {sortie = sortie, descriptionText = descriptionText, fullpath = mission.fullpath} 
					end
				end
			end
		
			if a_game.history then	
				local bValid = true
				for k,v in base.ipairs(a_game.history) do	
					if dataMissions[a_game.campaign][v.mission] == nil then
						--файлы кампании изменены
						bValid = false
					end
				end

				if bValid == true then
					offsetY = fillHistory(a_game, a_camp, offsetY)
				else
					--сообщение и стирание прогресса кампании
					local text = base.string.format(cdata.noValidHistory, a_camp.developerName)			
					local msgWindowHandler_ = MsgWindow.warning(text, cdata.warning, cdata.ok)

					function msgWindowHandler_:onChange(buttonText)
						panel_waitDsbweb.setUpdateFunction(function()	
							restartCampaign()
							update()
						end)
					end

					msgWindowHandler_:show()
					msgWindowHandler_ = nil
				end
			end
		end
		
		pMissions:setBounds(0, 93, 641, offsetY) 
		pDown:setBounds(0, 93+ offsetY, 641, 130)
	end
end

function fillHistory(a_game, a_camp, offsetY)
	local pHeader = pHeader:clone()
	pHeader:setPosition(0, offsetY)
	offsetY = offsetY + 30
	pMissions:insertWidget(pHeader)
	
	for k,v in base.ipairs(a_game.history) do	
		local pHist = pMis:clone()
		pHist:setPosition(0, offsetY)
		pHist:setVisible(true)
		pHist.bSkip:setVisible(false)
		pMissions:insertWidget(pHist)	
		panelsHist[k] = pHist
		
		pHist.bName:setText(dataMissions[a_game.campaign][v.mission].sortie)
		pHist.bName.key = k
		pHist.bName.descriptionText = dataMissions[a_game.campaign][v.mission].descriptionText
		pHist.bName:addChangeCallback(function(self)
				for k,v in base.pairs(panelsHist) do
					v:setSkin(pMisSkin)	
				end
				panelsHist[k]:setSkin(pMisSelSkin)
				
				sDescription:setText(self.descriptionText)
				local nw, nh = sDescription:calcSize() 
				sDescription:setSize(273, nh+20)
				
				spCampaignDescription:updateWidgetsBounds()
			end)
		
		if v.result then
			pHist.bStart.fullpath = dataMissions[a_game.campaign][v.mission].fullpath
			pHist.bStart.index = k
			pHist.bStart:setVisible(true)
			
			pHist.bStart:addChangeCallback(function(self)
				local missionPath = self.fullpath
				panel_waitDsbweb.setUpdateFunction(function()	
					if MissionModule.load(missionPath) == true then
						local activeCampaign = getActiveCampaign()
						LogbookModule.setCurrentGame(activeCampaign)
						LogbookModule.save()

						dataStart = {
							reStartFile = missionPath,
							index = self.index
						}
						
						-- FIXME: нужно хранить не индекс строки, а имя кампании
						--base.print("---curCLSID, rowLast----",curCLSID, rowLast)
						MeSettings.setLastCampaign(curCLSID, rowLast)

						base.START_PARAMS.campaignPath = activeCampaign.path
						AutoBriefingModule.returnToME = true
						AutoBriefingModule.setDoSave(true)
						AutoBriefingModule.show(true, 'campaign')
						show(false)
					end
				end)	
			end)
			
			if v.skipped == true then 
				pHist.sStatus:setSkin(sStatusSkippedSkin)
				pHist.sStatus:setText(cdata.Skipped)
			elseif v.result == 50 then
				pHist.sStatus:setSkin(sStatusDrawSkin)
				pHist.sStatus:setText(cdata.Draw)							
			elseif v.result < 50 then
				pHist.sStatus:setSkin(sStatusFailedSkin)
				pHist.sStatus:setText(cdata.Failed)
			else
				pHist.sStatus:setSkin(sStatusSuccessSkin)
				pHist.sStatus:setText(cdata.Success)
			end
			
			if v.skipped == true then 
				pHist.sScore:setText(0)
			else
				pHist.sScore:setText(v.result)
			end
		else
			pHist.bStart:setVisible(false)
			pHist.bSkip:setVisible(true)
			pHist.sStatus:setSkin(sStatusActiveSkin)
			pHist.sStatus:setText(cdata.Active)
			
			pHist.bSkip:addChangeCallback(function(self)
				panel_waitDsbweb.setUpdateFunction(function()	
					LogbookModule.skipMission(a_game, a_camp)								
					update()
				end)	
			end)
			
			pHist.sScore:setText("")
		end	
		offsetY = offsetY + 30
	end
	return offsetY
end

function getDataStart()
	return dataStart
end

function setDataStart(a_dataStart)
	dataStart = a_dataStart
end

function clearDataStart()
	dataStart = {}
end