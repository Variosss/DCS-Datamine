local base = _G

--local testServerList = true

module('mul_server_list')

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
local Static            = require('Static')
local Skin              = require('Skin')
local textutil          = require('textutil')
local lfs 				= require('lfs')
local Tools 			= require('tools')
local Button			= require('Button')
local Select_role		= require('mul_select_role')
local UpdateManager	    = require('UpdateManager')
local ToggleButton      = require('ToggleButton')
local Create_server     = require('mul_create_server')
local PasswordPanel     = require('mul_password')
local waitScreen        = require('me_wait_screen')
local MeSettings		= require('MeSettings')
local music             = require('me_music')
local nickname          = require('mul_nickname')
local keys              = require('mul_keys')
local Chat		        = require('mul_chat')
local TheatreOfWarData  = require('Mission.TheatreOfWarData')
local DCS				= require('DCS')
local listIC            = require('mul_listIntegrityCheck')
local MsgWindow			= require('MsgWindow')
local advGrid           = require('advGrid')
local modulesInfo       = require('me_modulesInfo')
local DcsWeb 			= require('DcsWeb')
local ListBoxItem		= require('ListBoxItem')
local mod_updater       = require('me_updater')
local Analytics			= require("Analytics")
local optionsEditor 	= require('optionsEditor')
local Gui               = require('dxgui')
local SkinUtils		    = require('SkinUtils')
local ProductType		= require('me_ProductType') 
local managerModulesME  = require('me_managerModulesME')

i18n.setup(_M)

cdata = 
{
    ServerList          = _("SERVER LIST"),
    ServerDesc          = _("SERVER DESCRIPTION"),
    MissionDesc         = _("MISSION DESCRIPTION"),
    GameTime            = _("Elapsed time"),
    Pas                 = _("Pas"),
    Address             = _("Address"),
    
 --   NumberofPlayers     = _("NumberofPlayers", "Players"),
    MissionName         = _("Mission Name"),
    ServerIp            = _("ServerIp"),
    SelectedServerInfo  = _("SelectedServerInfo"),
    ServerName          = _("Server Name"),
    Ping                = _("Ping"),
	Region				= _("Region"),
    NumPlayers          = _("Players"),
    passwordDisable     = _("Password disable"),
    passwordEnable      = _("Password enable"),
    integrityCheckFailure = _("Integrity check failure"),
    integrityCheckPassed  = _("Integrity check passed"),
    integrityCheckDisable = _("Integrity check disabled"),
    integrityCheckEnable  = _("Integrity check enabled"),
	trialDisable     	= _("Trial-only clients are not allowed"),
	trialEnable     	= _("Trial-only clients are allowed"),
    Lock                = _("Lock"),
    RemovefromFavorites = _("Remove from Favorites"),
    AddtoFavorites      = _("Add to Favorites"),
    Required            = _("Required"),   
    
    multiplayer         = _("MULTIPLAYER"),
    Exit                = _("EXIT"),
    BattleMatch         = _("BATTLEMATCH"),
    CreateServer        = _("NEW SERVER"),
    Join                = _("JOIN"),
    ConnectbyIP         = _("CONNECT BY IP"),   
    map                 = _("ServerList_Map","Map"),
    engaged_blue        = _("UNENGAGED BLUE"),
    engaged_red         = _("UNENGAGED RED"),
    
    cockpitVisualRM     = _('cockpitVisualRM', 'CPT VISUAL RECON'),
    easyFlight          = _('easyFlight', 'EASY FLIGHT'),
    padlock             = _('padlock', 'PADLOCK'),
    radio               = _('radio', 'RADIO ASSIST'),
    miniHUD             = _('miniHUD', "MINI HUD"),
    geffect             = _('geffect', 'G-EFFECT'),
    optionsView         = _('optionsView', 'OPTIONS VIEW'),
    externalViews       = _('externalViews', 'EXTERNAL VIEWS'),
    easyCommunication   = _('easyCommunication', 'EASY COMMUNICATION'),
	unrestrictedSATNAV 	= _('Unrestricted SATNAV'),
    fuel                = _('fuel', 'UNLIMITED FUEL'),
    weapons             = _('weapons', 'UNLIMITED WEAPONS'),
    labels              = _('labels', 'LABELS'),
    
    yes                 = _('yes_mul', 'yes'),
    no                  = _('no_mul', 'no'),
    optview_onlymap     = _('map only'),
    optview_allies      = _('fog of war'),
    optview_onlyallies  = _('allies only'),
    optview_myaircraft  = _('my a/c'),
    optview_all         = _('all'),
    none                = _('none'),
	Loading				= _('Loading...'),
    reduced             = _('reduced'),
    realistic           = _('realistic'),
    
    off                 = _('off_mul','Off'),
    small               = _('small_mul','Small'),
    medium              = _('medium_mul','Medium'),
    large               = _('large_mul','Large'),
    DataExport          = _("Permissions"),
	IntegrityCheck      = _("Integrity Check"),
	require_pure_textures	= "-- ".._("require pure textures"),
	require_pure_models 	= "-- ".._("require pure models"),
	require_pure_scripts	= "-- ".._("require pure scripts"),
	require_pure_clients	= _("require pure clients"),
    
    allow_object_export = _("allow_object_export"),
    allow_sensor_export = _("Allow sensor export"),
    allow_ownship_export= _("Allow player export"),
	
	allow_change_skin	= _("Allow to change skins"), 
	allow_change_tailno	= _("Changing Tail Number"),  -- название сокращено чтобы помещалось
	server_can_screenshot = _("Allow to screenshot clients"),
	voice_chat_server 	= _("Allow voice chat"),
	allow_players_pool	= _("Allow Players Pool"),
    
    password            = _('Password'),
    protect             = _('Protect'),
	trial				= _('Allow trial-only clients'),
    psform              = _('Players from'),
    pingFilter          = _('Ping <='),
    to                  = _('to_mul', 'to'),
    map                 = _('Map_serverlist', 'Map'),
    Search              = _('Search server...'),
    saveFilter          = _('Save filter'),

    ESV_tooltip         = _('Show only matched with my DLCs/Show All'),	
	
	Overlays				= _('Overlays'), 
	cockpitStatusBarAllowed	= _("Cockpit Status Bar"),
	RBDAI					= _('Battle Damage Assessment'),	
	wakeTurbulence			= _('Wake turbulence'),
	localTxt				= _("local"),
	MisTime					= _("Time in mission"),
	FavoritesOnly			= _("Favorites Only"),
}

if ProductType.getType() == "LOFAC" then
    cdata.MissionDesc   = _("MISSION DESCRIPTION-LOFAC")
    cdata.MissionName   = _("Mission Name-LOFAC")
end

local status = "offline"
local listServers = {}
local curKeySort = 'favorite'
local rowHeight = 20
local curServer = nil
local sortReverse = false
--local needUpdateSlots = true
local serverList = {}

local listRows = {}
local favoritesList = {}
local passwordsList = {}
local server_addr 
local password
local filesIntegrityCheck
local bEnableStartVisible = true
local requiredModulesButton = {}
local listMaps = {}
local listRegions = {}
local isStarting = false
local refreshAnimationStartTime
local refreshAnimationSpeed = 180 -- 180 degree per second
local serverListUpdateComplete = false
local refreshGridStartTime = 0

-------------------------------------------------------------------------------
-- 
function create(x, y, w, h)
    nickname.create(w, h)
    
    winW = w
    
    loadFavorite()
	loadPasswords()
    window = DialogLoader.spawnDialogFromFile("MissionEditor/modules/dialogs/mul_server_list.dlg", cdata)    
    local container = window.main_panel
    window:addHotKeyCallback('F5', onChange_btnRefresh)
	window:addHotKeyCallback('escape', onChange_btnExit)
 
    local main_panel = window.main_panel
    
    pWork                   = main_panel.pWork
    serverGrid              = pWork.pCenter.serverGrid
    pRight                  = pWork.pRight
    pCenter                 = pWork.pCenter
    pBottom                 = pWork.pBottom
    pBtn                    = main_panel.pBtn
    pUp                     = main_panel.pUp
	sFon					= pCenter.sFon
    btnClose                = pUp.btnClose
    sDCSMulti               = pUp.sDCSMulti
    pNoVisible              = pCenter.pNoVisible   
    btnRefresh              = pCenter.btnRefresh
    staticRefresh           = pCenter.staticRefresh
    btnExit                 = pBtn.btnExit
    btnBattleMatch          = pBtn.btnBattleMatch
    btnCreateServer         = pBtn.btnCreateServer
    btnJoin                 = pBtn.btnJoin
    pSlots                  = pBottom.pSlots
    sLoginNickname          = pCenter.sLoginNickname
    btnConnectbyIP          = pCenter.btnConnectbyIP
    sServerDesc             = pBottom.pDesc.sServerDesc
    eServerDesc             = pBottom.pDesc.eServerDesc
    sCaptMisDesc            = pBottom.pDesc.sCaptMisDesc
    eMisDesc                = pBottom.pDesc.eMisDesc
    eInfoIp                 = pBottom.pDesc.eInfoIp
    pOptions                = pBottom.pOptions
    sRequired               = pBottom.pDesc.sRequired
    btnNickname             = pCenter.btnNickname
    sServersPlayers         = pCenter.sServersPlayers
    btnIntegrityCheck       = pCenter.btnIntegrityCheck
    btnIntegrityCheckNo     = pCenter.btnIntegrityCheckNo
    tbtnEnableStartVisible  = pCenter.tbtnEnableStartVisible
	pFilter					= pCenter.pFilter
    clPassword              = pCenter.pFilter.clPassword
    clProtect               = pCenter.pFilter.clProtect
    ePsform                 = pCenter.pFilter.ePsform
    ePsformEnd              = pCenter.pFilter.ePsformEnd
    ePing                   = pCenter.pFilter.ePing   
    clMap                   = pCenter.pFilter.clMap
	clRegion				= pCenter.pFilter.clRegion
    eSearch                 = pCenter.pFilter.eSearch   
	cbFavoritesOnly			= pCenter.pFilter.cbFavoritesOnly	
    clSelectfilter          = pCenter.pFilter.clSelectfilter
    btnSave                 = pCenter.pFilter.btnSave
	sVersion				= pUp.sVersion
    
    fillComboListsFilter()
    
    btnClose.onChange               = onChange_btnExit
    btnRefresh.onChange             = onChange_btnRefresh
    btnExit.onChange                = onChange_btnExit
    btnConnectbyIP.onChange         = onChange_btnConnectbyIP
    btnNickname.onChange            = onChange_btnNickname
    btnIntegrityCheck.onChange      = onChange_btnIntegrityCheck
    btnIntegrityCheckNo.onChange    = onChange_btnIntegrityCheckNo
    tbtnEnableStartVisible.onChange = onChange_tbtnEnableStartVisible
    clPassword.onChange             = onChange_UpdateServerList          
    clProtect.onChange              = onChange_UpdateServerList 
    clMap.onChange                  = onChange_UpdateServerList  
	clRegion.onChange               = onChange_UpdateServerList  
    eSearch.onChange                = onChange_UpdateServerList 
    ePing.onChange                  = onChange_UpdateServerList 
    ePsform.onChange                = onChange_UpdateServerList 
    ePsformEnd.onChange             = onChange_UpdateServerList 
	cbFavoritesOnly.onChange        = onChange_UpdateServerList

    staticSkinSlots                     = pNoVisible.sSlots:getSkin()
    staticSkinSlotsItem                 = pNoVisible.sSlotsItem:getSkin()
    staticSkinGridServersLock           = pNoVisible.sLock:getSkin()
    staticSkinGridServersLockNo         = pNoVisible.sLockNo:getSkin()
    
    staticSkinGridServersIC             = pNoVisible.sIntegrityCheck:getSkin()
    staticSkinGridServersICNo           = pNoVisible.sIntegrityCheckNo:getSkin()
    
	staticNotAllowedPing				= pNoVisible.staticNotAllowedPing:getSkin()
    staticSkinGridServersAlignMiddle    = pNoVisible.sGridItemAlignMiddle:getSkin()
    staticSkinGridServersPadding        = pNoVisible.sGridItemPadding:getSkin()    
    staticSkinGridServersAlignMiddleS    = pNoVisible.sGridItemAlignMiddleSelected:getSkin()
    staticSkinGridServersPaddingS        = pNoVisible.sGridItemPaddingSelected:getSkin()    
    staticSkinGridServersAlignMiddleH    = pNoVisible.sGridItemAlignMiddleHover:getSkin()
    staticSkinGridServersPaddingH        = pNoVisible.sGridItemPaddingHover:getSkin()
    staticSkinGridServersAlignMiddleDis = pNoVisible.sGridItemAlignMiddleDis:getSkin()
	staticSkinGridItemFlag				= pNoVisible.sGridItemFlag:getSkin()
	staticSkinGridItemFlagSel			= pNoVisible.sGridItemFlagSel:getSkin()
    
    
    btnSkinStar = pNoVisible.btnStar:getSkin()
    
    local gridHeaderCell = serverGrid:getColumnHeader(0)
	gridHeaderCell:setSkin(pNoVisible.gridHeaderStar:getSkin())
    
    gridHeaderCell = serverGrid:getColumnHeader(1)
	gridHeaderCell:setSkin(pNoVisible.gridHeaderLock:getSkin())
    
    gridHeaderCell = serverGrid:getColumnHeader(2)
	gridHeaderCell:setSkin(pNoVisible.gridHeaderIntegrityCheck:getSkin())
	
	gridHeaderCell = serverGrid:getColumnHeader(3)
	gridHeaderCell:setSkin(pNoVisible.gridHeaderTrial:getSkin())

    local count = serverGrid:getColumnCount()
    
    bRequiredTextSkin = pNoVisible.bRequiredText:getSkin()
    
    skinSortUp      = pNoVisible.gridHeaderCellSortUp:getSkin()
    skinSortDown    = pNoVisible.gridHeaderCellSortDown:getSkin()
    skinNoSort      = pNoVisible.gridHeaderCellNoSort:getSkin()
    
    skinOptionsText = pNoVisible.sOptions:getSkin()
    skinOptionsValue= pNoVisible.sOptValue:getSkin()
    
    local KeysSort = 
    {
        "favorite", 
        "password",
        "require_pure_clients",
		"allow_trial_only_clients",
        "ping",
		"geoCountryName", -- flag
        "name",
        "theatre",
        "miz",
        "numPlayers",
        "gameTime",
		"localTime"
    }
    
    SkinsHeaders = 
    {
        [1] = {
            skinSortUp      = pNoVisible.gridHeaderCellSortUp:getSkin(),
            skinSortDown    = pNoVisible.gridHeaderCellSortDown:getSkin(),
            skinNoSort      = pNoVisible.gridHeaderCellNoSort:getSkin(),
        },
        [2] = {
            skinSortUp      = pNoVisible.gridHeaderCellSortUpPadding:getSkin(),
            skinSortDown    = pNoVisible.gridHeaderCellSortDownPadding:getSkin(),
            skinNoSort      = pNoVisible.gridHeaderCellNoSortPadding:getSkin(),
        }        
    }
	
	for i = 0, count - 1 do
		local gridHeaderCell = serverGrid:getColumnHeader(i)
        gridHeaderCell.KeySort = KeysSort[i+1]  
		gridHeaderCell:setDraggable(false)
        
        gridHeaderCell:addChangeCallback(function(self)        
            if curKeySort == self.KeySort then
                sortReverse = not sortReverse
            else
                sortReverse = false
            end
            curKeySort = self.KeySort
            local tmpList = {}
            base.U.recursiveCopyTable(tmpList,listServers)
            update(tmpList, true)
        end	)
    end
    
    for i = 0, 20 do
        addRequiredModulesButton()      
    end
    
    resize(x, y, w, h)
    serverGridAdv = advGrid.new(serverGrid)
    setupCallbacks()
    
    eServerDesc:setText("")
    eMisDesc:setText("")
    updateDesc()
    eInfoIp:setText("")

    --создаем панель с опциями    
    createOptionsPanel()   
    
    skinsForGrid =
    {
        all = {
            ['func'] = function(a_cell, a_typeSkin) 
                if a_typeSkin == 'normal' then
                    if a_cell.enableStart == true then   
						if a_cell.notAllowedPing == true then
							return staticNotAllowedPing 
						else	
							return staticSkinGridServersAlignMiddle 
						end
                    else                        
                        return staticSkinGridServersAlignMiddleDis 
                    end
                end
                if a_typeSkin == 'select' then
					if a_cell.notAllowedPing == true then
						return staticNotAllowedPing 
					else
						return staticSkinGridServersAlignMiddleS
					end	
                end
                
                if a_typeSkin == 'hover' then
					if a_cell.notAllowedPing == true then
						return staticNotAllowedPing 
					else
						return staticSkinGridServersAlignMiddleH
					end	
                end
            end
        
        },
        
        individual = {
            [0]= {
                ['func'] = function(a_cell, a_typeSkin)  
                    if a_cell.data.server.favorite == true then 
                        if a_typeSkin == 'select' then
                            return pNoVisible.btnStarSelected:getSkin()
                        else
                            return btnSkinStar
                        end
                    else
                        if a_typeSkin == 'select' then
                            return pNoVisible.btnStarSelected:getSkin()
                        else
                            return btnSkinStar
                        end
                    end 
                end
            },
            [1]= {
                ['func'] = function(a_cell, a_typeSkin)  
                    if a_cell.password == true then 
                        if a_typeSkin == 'select' then
                            return pNoVisible.sLockSelected:getSkin()
                        else
                            return staticSkinGridServersLock
                        end
                    else
                        if a_typeSkin == 'select' then
                            return pNoVisible.sLockNoSelected:getSkin()
                        else
                            return staticSkinGridServersLockNo
                        end
                    end 
                end
            },
            [2]= {
                ['func'] = function(a_cell, a_typeSkin)  
                    if a_cell.require_pure_clients == true then 
                        if a_typeSkin == 'select' then
                            return pNoVisible.sIntegrityCheckSelected:getSkin()
                        else
                            return staticSkinGridServersIC
                        end
                    else
                        if a_typeSkin == 'select' then
                            return pNoVisible.sIntegrityCheckNoSelected:getSkin()
                        else
                            return staticSkinGridServersICNo
                        end
                    end 
                end
            },
			[3]= {
                ['func'] = function(a_cell, a_typeSkin)  
                    if a_cell.allow_trial_only_clients == true then
						if a_typeSkin == 'select' then
                            return pNoVisible.sITrialSelected:getSkin()
                        else
                            return pNoVisible.sTrial:getSkin()
                        end
                    else
                        if a_typeSkin == 'select' then
                            return pNoVisible.sTrialNoSelected:getSkin()
                        else
                            return pNoVisible.sTrialNo:getSkin()
                        end
                    end 
                end
            },
			[5]= {
                ['func'] = function(a_cell, a_typeSkin)  
					if a_cell.geoCountry then
						if a_typeSkin == 'select' then
                            a_cell:setSkin(staticSkinGridItemFlagSel)
                        else
                            a_cell:setSkin(staticSkinGridItemFlag)
                        end
						return SkinUtils.setStaticPicture("dxgui\\skins\\skinME\\images\\Flags\\"..a_cell.geoCountry..".png", a_cell:getSkin())
					else
						if a_typeSkin == 'select' then
                            return pNoVisible.sLockNoSelected:getSkin()
                        else
                            return staticSkinGridServersLockNo
                        end
					end
                end
            },
        
        },
    }
    
    serverGridAdv:setSkins(skinsForGrid)	
	
	eSearch:addFocusCallback(function(self, x, y, button)
		if self:getFocused() == true and cdata.Search == self:getText() then		
			self:setText("")
		end
	end)
	
    return window
end

function addRequiredModulesButton()
	local widgetNew = Button.new()
	widgetNew:setSkin(bRequiredTextSkin) 
	base.table.insert(requiredModulesButton, widgetNew)   
end

function fillComboListYesNoAny(a_comboList)
    local item = ListBoxItem.new(_("Any"))
    item.type = "any"    
    a_comboList:insertItem(item)
    a_comboList:selectItem(item)
    
    item = ListBoxItem.new(_("Yes"))
    item.type = true    
    a_comboList:insertItem(item)
    
    item = ListBoxItem.new(_("No"))
    item.type = false    
    a_comboList:insertItem(item)
    
end

function fillComboListsFilter()    
    fillComboListYesNoAny(clPassword)
    fillComboListYesNoAny(clProtect)    
end

function createOption(a_name, a_type)
    local sTmpStatic = Static.new()
    sTmpStatic:setSkin(skinOptionsText)
    sTmpStatic:setText(cdata[a_name]..":")
    nw,nh = sTmpStatic:calcSize() 
    sTmpStatic:setBounds(8,hOffset,nw,20)
    pOptions:insertWidget(sTmpStatic)
    
    tblOptions[a_name] = Static.new()
    tblOptions[a_name].type = a_type
    tblOptions[a_name]:setSkin(skinOptionsValue)
    tblOptions[a_name]:setBounds(nw+8,hOffset,30,20)    
    pOptions:insertWidget(tblOptions[a_name])
    
    hOffset = hOffset + 17
end

function createCaption(a_text)
    hOffset = hOffset + 10
    local sTmpStatic = Static.new()
    sTmpStatic:setSkin(skinOptionsText)
    sTmpStatic:setText(cdata[a_text])
    nw,nh = sTmpStatic:calcSize() 
    sTmpStatic:setBounds(8,hOffset,nw,20)
    pOptions:insertWidget(sTmpStatic)
    hOffset = hOffset + 17
end

function createOptionsPanel()
    local nw,nh
    
    tblOptions = {}
    hOffset = 20
            -- "mopt" опции миссии 
    createOption("cockpitVisualRM", "mopt")
    createOption("easyFlight", "mopt")
	createOption("padlock", "mopt")
    createOption("radio", "mopt")
	createOption("unrestrictedSATNAV", "mopt")
    createOption("miniHUD", "mopt")
    createOption("geffect", "mopt")
    createOption("optionsView", "mopt")
    createOption("externalViews", "mopt")
    createOption("easyCommunication", "mopt")
    createOption("fuel", "mopt")
    createOption("weapons", "mopt")
    createOption("labels", "mopt")	
	createOption("wakeTurbulence", "mopt")
    
	createCaption("IntegrityCheck")
	createOption("require_pure_clients", "sopt")	
	createOption("require_pure_textures", "sopt")
    createOption("require_pure_models", "sopt")
	createOption("require_pure_scripts", "sopt")
    	
    createCaption("DataExport")
            -- "sopt" опции сервера 
    createOption("allow_object_export", "sopt")
    createOption("allow_sensor_export", "sopt")
    createOption("allow_ownship_export", "sopt")
	createOption("allow_change_skin", "sopt")
	createOption("allow_change_tailno", "sopt")
	createOption("server_can_screenshot", "sopt")
	createOption("voice_chat_server", "sopt")
	createOption("allow_players_pool", "sopt")
	
	createCaption("Overlays")	
	createOption("RBDAI", "mopt")
	createOption("cockpitStatusBarAllowed", "mopt")
	
end

local function startRefreshButtonAnimation()
	-- запускаем анимацию
	
	Gui.EnableHighSpeedUpdate(true)
	
	btnRefresh:setEnabled(false)
	staticRefresh:setVisible(true)
	staticRefresh:setAngle(0)
	
	refreshAnimationStartTime = os.clock()
	serverListUpdateComplete = false
	
	local prevAngle = 0
	
	UpdateManager.add(function()
		local deltaTime = os.clock() - refreshAnimationStartTime
		local angle = base.math.fmod(refreshAnimationSpeed * deltaTime, 360)

		staticRefresh:setAngle(-angle)
		
		if serverListUpdateComplete then
			-- нужно завершить анимацию
			
			if angle < prevAngle then -- переход через 0
				btnRefresh:setEnabled(true)  
				staticRefresh:setVisible(false)
				
				Gui.EnableHighSpeedUpdate(false)
				
				return true
			end
		end
		
		prevAngle = angle
	end)
end

function getNewServerList()
	-- очищаем список серверов
	-- запускаем опрос их получения
	
--	isStarting проверяется перед этой функцией
	isStarting = true
	UpdateManager.add(function()
		endUpdate()
		idSearch = net.serverlist_search()
		serverList = {}
	--	base.print("--- serverlist_search---",   idSearch)

	
		startUpdate()			
		-- удаляем себя из UpdateManager
		return true
	end)
		
	startRefreshButtonAnimation()   
end

function convertValue(a_value)
    local result = a_value
    if base.type(a_value) == 'boolean' then 
        if a_value == true then
            result = cdata.yes 
        else
            result = cdata.no
        end
    else
        if a_value == "" then
            result = cdata['off']
        else    
            result = cdata[a_value] or a_value
        end    
    end
    return result
end

function updateOptions(a_dataServer)
    if a_dataServer == nil or a_dataServer.opts == nil then
        for k,widgetO in base.pairs(tblOptions) do
            widgetO:setText("")
        end
    else
        for k,widgetO in base.pairs(tblOptions) do
            if widgetO.type == "sopt" then					
				if a_dataServer.advanced[k] ~= nil then
					widgetO:setText(convertValue(a_dataServer.advanced[k]))
				else	
					widgetO:setText(convertValue(a_dataServer[k]))
				end
            else
				local tmpData = a_dataServer.opts[k] 
				local suffix = ""
				if tmpData == nil then
					tmpData = optionsEditor.getOption("difficulty."..k)
					suffix = " ("..cdata.localTxt..")"
				end
				if k == 'labels' then
					local text 
					if tmpData == 0 or tmpData == false then
						text = _('None')
					elseif tmpData == 1 or tmpData == true then
						text = _('Full')
					elseif tmpData == 2 then
						text = _('Abbreviated')
					elseif tmpData == 3 then
						text = _('Dot only')
					elseif tmpData == 4 then
						text = _('Dot neutral')
					else
						text = _('Unknown')
					end
					widgetO:setText(text..suffix)	
				else
					base.print("--tmpData--",k,tmpData,convertValue(tmpData))
					widgetO:setText(convertValue(tmpData)..suffix)
				end
            end
            local nw,nh = widgetO:calcSize() 
            widgetO:setSize(nw,20)    
        end
    end
end

function startUpdate()
  --  needUpdateSlots = false
--  base.print("---startUpdate---")
    updateSlots({})--очищаем
    clMap:clear()
	clRegion:clear()
    listMaps = {}
	listRegions = {}
    addItemFilterMaps(_("Any"),"any", true)
	addItemFilterRegions(_("Any"),"any", true)
	addItemFilterRegions(_("No region"),"", false)
	updateDesc()
    
    UpdateManager.add(updateServerList)
    serverGridAdv:setHoverEnable(false)
	eInfoIp:setEnabled(false)
	eServerDesc:setEnabled(false)
	eMisDesc:setEnabled(false)
end

function endUpdate()
    UpdateManager.delete(updateServerList)
	
  --  needUpdateSlots = true
	
  --  if base.__FINAL_VERSION__ == false then    
  --      base.U.traverseTable(serverList,3)
  --      base.print("---serverList---",serverList)
  --  end
	if serverList ~= nil then
		update(serverList)
		updateColumnHeaders()		
	end

	serverGridAdv:setHoverEnable(true)    
	eInfoIp:setEnabled(true)
	eServerDesc:setEnabled(true)
	eMisDesc:setEnabled(true)	 
end

function updateServerList()
    local newServerList
	
	oldId = idSearch
    newServerList, idSearch  = net.serverlist_get(idSearch)
	
-- base.U.traverseTable(newServerList)
-- base.print("---updateServerList---",idSearch,newServerList)     
    
    if newServerList == nil then 
        endUpdate()
		serverListUpdateComplete = true
		isStarting = false	 
    else
        --base.print("---newServerList---",#newServerList)
       
       --TEST
        if testServerList == true then
            newServerList = serverListTEST
			
			if ttt then
				newServerList[24] = nil
			end
			ttt = 12
        end
        --мержим изменения в основной список
        for k,v in base.pairs(newServerList) do
            serverList[v.address] = v
			
			if v.theatre == nil then
				v.theatre = "Loading..."
            end
			
            addItemFilterMaps(_(v.theatre), v.theatre)				
			
			v.localTime = (v.gameTime or 0) + (v.start_time or 0)
			
			if v.geoContinent and v.geoContinent ~= "" then
				addItemFilterRegions(keys.tabContinentCodes[v.geoContinent], v.geoContinent)
			end
        end
    end
    
	local time = os.clock()
    if serverList ~= nil and (time - refreshGridStartTime) > 1 then
		update(serverList)  
		refreshGridStartTime = time	
    end
end

function Quit(a_stop_network)
    endUpdate()
    net.serverlist_reset()
    if a_stop_network ~= false then
        net.stop_network()
    end
    show(false)
end

function resize(x, y, w, h)
    window:setBounds(0, 0, w, h)
    window.main_panel:setBounds(0, 0, w, h)
    
    local gridW = 1280
	if w >= 1482 then
		gridW = 1482
	end
	local delta = gridW-1280
    
    pWork:setBounds((w-gridW)/2, 50, gridW, h - 50 - 50)


    local serverGridH = h - 215 - h * 0.33  
    pCenter:setBounds(0, 0, gridW, serverGridH+115)
    serverGrid:setBounds(0, 115, gridW, serverGridH)
    
    local bottomPanelH = h * 0.33 
    pBottom:setBounds(0, 115 + serverGridH, gridW, bottomPanelH)
    
    pBottom.pDesc:setBounds(0, 0, 363, bottomPanelH)
    
    updateDesc()
    
    pBottom.pSlots:setBounds(363, 0, 651, bottomPanelH)
    
    pBottom.pOptions:setBounds(1014, 0, 266+delta, bottomPanelH)
	btnClose:setPosition(gridW-27, 0)
	btnJoin:setPosition(gridW-195, 10)
	
	pFilter:setSize(gridW, 74)
    
    pBtn:setBounds((w-gridW)/2, h-51, gridW, 51)
    pUp:setBounds((w-gridW)/2, 0, gridW, 51)
	sFon:setSize(gridW, 42)
	btnNickname:setPosition(gridW-33, 9) 
	sLoginNickname:setPosition(gridW-216, 9) 
    
    
    serverGrid:setColumnWidth(0, 19)   
    serverGrid:setColumnWidth(1, 18)  
    serverGrid:setColumnWidth(2, 18)  
	serverGrid:setColumnWidth(3, 18)    	
    serverGrid:setColumnWidth(4, 61) 
	serverGrid:setColumnWidth(5, 32)  --flag
    serverGrid:setColumnWidth(6, 381)   
    serverGrid:setColumnWidth(7, 170)  
    serverGrid:setColumnWidth(8, 376)   
    serverGrid:setColumnWidth(9, 76)   
    serverGrid:setColumnWidth(10, 115)  
    serverGrid:setColumnWidth(11, 115) --Local time 
end

function onChange_UpdateServerList()
    if serverList ~=nil then
        update(serverList)               
    end
end

function updateDesc(a_server)

    local offsetY = 45
    
    for k,static in base.pairs(requiredModulesButton) do
        static:setVisible(false)
    end
      
    if a_server then
        eServerDesc:setText(a_server.desc or "")  
        eMisDesc:setText(a_server.descMis or "")     
        eInfoIp:setText(curServer)
                     
        local requiredModules = a_server.requiredModulesTbl
        if #requiredModules > 0 then
            sRequired:setVisible(true)
			offsetY = offsetY + 10 
			
			local addBtnNum = #requiredModules - #requiredModulesButton
			if addBtnNum > 0 then
				for i = 1, addBtnNum do
					addRequiredModulesButton() 
				end	
			end 

            for k,v in base.ipairs(requiredModules) do
                requiredModulesButton[k]:setText(modulesInfo.getModulDisplayNameByModulId(v))
                requiredModulesButton[k]:setBounds(0,offsetY, 363, 20)
                requiredModulesButton[k]:setVisible(true) 
                requiredModulesButton[k].blink = modulesInfo.getBlink(v)
                requiredModulesButton[k].onChange = function(self)
                    if self.blink then
                        local url = DcsWeb.make_auth_url(self.blink)
                        os.open_uri(url)
                    end
                end
                pBottom.pDesc:insertWidget(requiredModulesButton[k])
                offsetY = offsetY + 20       
            end
			offsetY = offsetY + 10 
        else
            sRequired:setVisible(false)
        end
    else
        eServerDesc:setText("")  
        eMisDesc:setText("")     
        eInfoIp:setText("") 
        sRequired:setVisible(false)    
    end

    sServerDesc:setBounds(0, offsetY, 315, nh) 
    local nw,nh = eServerDesc:calcSize()
    eServerDesc:setBounds(0, offsetY+20, 315, nh)     
    sCaptMisDesc:setBounds(0, offsetY+33+nh, 363, 20)
    local nw2,nh2 = eMisDesc:calcSize()
    eMisDesc:setBounds(0, offsetY+nh+56, 315, nh2+50)
    pBottom.pDesc:updateWidgetsBounds()
end

function setupCallbacks()
    serverGrid.onMouseDown = function(self, x, y, button)
        local col, row = serverGrid:getMouseCursorColumnRow(x, y)

        if -1 < row then
            selectRow(row)
        end
    end

    function serverGrid:onMouseDoubleClick(x, y, button)
		onChange_btnJoin()
    end  
    
    sLoginNickname:addMouseUpCallback(function(self, x, y, button)
        onChange_btnNickname()        
    end)
  
    btnJoin.onChange = onChange_btnJoin
    btnCreateServer.onChange = onChange_btnCreateServer
end 

function selectRow(row)
    local curRow = serverGrid:getSelectedRow()
    local widget
    widget = serverGrid:getCell(0, row)
    if widget and widget.data then       
        curServer = widget.data.server.address  
        eServerDesc:setText(widget.data.server.desc or "")  
        eMisDesc:setText(widget.data.server.descMis or "")  
        updateDesc(widget.data.server)    
        eInfoIp:setText(curServer)
        updateOptions(widget.data.server)
        updateSlots(widget.data.server)  
		if widget.data.server.enableStart == false then
			btnJoin:setEnabled(false)
		else
			btnJoin:setEnabled(true)
		end	
    end
        
    serverGridAdv:selectRow(row)    
end

function loadFavorite()
    local tbl = Tools.safeDoFile(lfs.writedir() .. 'MissionEditor/favorites.lua', false)
    if (tbl and tbl.favorites) then
        favoritesList = tbl.favorites
    end      
end

function saveFavorite()
    U.saveInFile(favoritesList, 'favorites', lfs.writedir() .. 'MissionEditor/favorites.lua')	
end

function loadPasswords()
	local tbl = Tools.safeDoFile(lfs.writedir() .. 'MissionEditor/serversPasswords.lua', false)
    if (tbl and tbl.passwordsList) then
        passwordsList = tbl.passwordsList
    end      
end

function savePasswords()
    U.saveInFile(passwordsList, 'passwordsList', lfs.writedir() .. 'MissionEditor/serversPasswords.lua')	
end

function addtoFavorites(a_row)
    if a_row > -1 then
        local widget = serverGrid:getCell(0, a_row)  
        favoritesList[widget.data.server.address] = true
        widget.data.server.favorite = true
        saveFavorite()
    end    
end

function removefromFavorites(a_row)
    if a_row > -1 then
        local widget = serverGrid:getCell(0, a_row)  
        favoritesList[widget.data.server.address] = nil
        widget.data.server.favorite = false
        saveFavorite()
    end 
end    

local function parseUnitId(a_unitId)
    local pos = base.string.find(a_unitId, '_')
    if pos then
        local unitId = base.string.sub(a_unitId,1,pos-1)
        local place = base.string.sub(a_unitId,pos+1)
        return true,unitId,place
    end

    return false
end

function updateSlots(a_data)
	pSlots:clear()
	
 --   if needUpdateSlots == false then
 --       return
 --   end

    if base.type(a_data) == 'table' then 
	--base.U.traverseTable(a_data.slots)
    --base.print("---updateSlots--")
        fillListSlots(a_data)
    end     
end

local function compareSlotsByType(left, right)
	if (keys.tabTr[left[1]] or keys.getDisplayName(left[1])) == (keys.tabTr[right[1]] or keys.getDisplayName(right[1])) then
		if right[2] == nil or right[2][1] == nil then
			return false
		end
		if (left[2] == nil and right[2] ~= nil) or (left[2][1] == nil and right[2][1] ~= nil) then
			return true
		end

		return (textutil.Utf8Compare(left[2][1].pilotName, (right[2][1].pilotName)))
	else
		return (keys.tabTr[left[1]] or keys.getDisplayName(left[1])) < (keys.tabTr[right[1]] or keys.getDisplayName(right[1]))
	end
end	

function fillCoalitionSlots(a_title, a_coalSlots, a_offsetX, a_engagedTxt)
	local emptySlots = {}
    local emptySlotsSort = {}
    
    local item = Static.new()
    --item:setText(a_title)
	local itemCount = 0
    item:setBounds(a_offsetX,9,231,20)
    item:setSkin(staticSkinSlots)
    pSlots:insertWidget(item)
    
    if a_coalSlots then
        local offsetY = 25
        for k,v in base.ipairs(a_coalSlots) do
            local unit_type = v[1]
            if unit_type then
                if v[2] then
					local pilotName = ""
					for kk,vv in base.pairs(v[2]) do
						if vv.crew_index == 0 then
							pilotName = vv.pilotName or _("none")
						end
					end
					
					local item = Static.new() 
					item:setText((keys.tabTr[unit_type] or keys.getDisplayName(unit_type))..": ")
					local tmpW, tmpH = item:calcSize()
					local tmpY = offsetY
					item:setSkin(staticSkinSlotsItem)
					item:setBounds(a_offsetX,offsetY,231,20)
					pSlots:insertWidget(item)
					itemCount = itemCount + 1
					offsetY = offsetY + 20
					
					for kk,vv in base.pairs(v[2]) do
						if vv.crew_index == 0 then
							local item = Static.new() 
							item:setText(vv.pilotName or _("none"))	
							item:setSkin(staticSkinSlotsItem)
							item:setBounds(a_offsetX + tmpW,tmpY,231,20)
							pSlots:insertWidget(item)
						else
							local item = Static.new() 
							item:setText(vv.pilotName or _("none"))	
							item:setSkin(staticSkinSlotsItem)
							item:setBounds(a_offsetX + tmpW,offsetY,231,20)
							pSlots:insertWidget(item)
							offsetY = offsetY + 20
						end
					end
				else
					if emptySlots[unit_type] == nil then
						base.table.insert(emptySlotsSort, unit_type)
					end
					emptySlots[unit_type] = (emptySlots[unit_type] or 0) + 1                    
				end
            end
        end
        offsetY = offsetY + 20
        local item = Static.new()
        item:setText(a_engagedTxt)
        item:setBounds(a_offsetX,offsetY,231,20)
        item:setSkin(staticSkinSlots)
        offsetY = offsetY + 20
        pSlots:insertWidget(item)
        
        for k,v in base.ipairs(emptySlotsSort) do
            local item = Static.new()
            item:setText((keys.tabTr[v] or keys.getDisplayName(v))..": "..emptySlots[v])
            item:setSkin(staticSkinSlotsItem)
            item:setBounds(a_offsetX,offsetY,231,20)
            offsetY = offsetY + 20
            pSlots:insertWidget(item)
        end
    end
	item:setText(a_title .. " (" .. itemCount ..")")
end
    
function fillListSlots(a_data)
    if a_data.slots == nil then
        return
    end

    base.table.sort(a_data.slots.blue, compareSlotsByType)
    base.table.sort(a_data.slots.red, compareSlotsByType)
     
	fillCoalitionSlots(_("Blue coalition"), a_data.slots.blue, 8, cdata.engaged_blue )
	fillCoalitionSlots(_("Red coalition"), a_data.slots.red, 231, cdata.engaged_red)
    
    offsetY = 0
    local item = Static.new()
    item:setText(_("SPECTATORS"))
    item:setBounds(490,9,130,20)
    item:setSkin(staticSkinSlots)

    pSlots:insertWidget(item)
    
    fillSpectators(a_data)
        
    pSlots:updateWidgetsBounds()
end

function fillSpectators(a_data)
    if a_data.specs == nil then
        return
    end   
    
    local offsetY = 25
    for k,player_name in base.pairs(a_data.specs) do
        local item = Static.new()
        item:setText(player_name)
        item:setSkin(staticSkinSlotsItem)
        item:setBounds(490,offsetY,200,20)
        offsetY = offsetY + 20
        pSlots:insertWidget(item)    
    end
end

function clearInfoServer()
    eServerDesc:setText("")
    eMisDesc:setText("")
    updateDesc()
    updateOptions()
    eInfoIp:setText("")
    pSlots:clear() 
end

function updateInfoServer()
	if isStarting == false then
		eServerDesc:setText("")
		eMisDesc:setText("")
		updateDesc()
		updateOptions()
		eInfoIp:setText("")
		updateColumnHeaders()
		updatePlayer()
		getNewServerList()  
	end
end

function updateIntegrityCheck()
    filesIntegrityCheck = DCS.getTaintedFiles()
    
   -- base.U.traverseTable(filesIntegrityCheck)
   -- base.print("---filesIntegrityCheck---")
    
    if filesIntegrityCheck and #filesIntegrityCheck > 0 then
        btnIntegrityCheckNo:setVisible(true)
        btnIntegrityCheck:setVisible(false)
    else
        btnIntegrityCheckNo:setVisible(false)
        btnIntegrityCheck:setVisible(true)
    end
end

function show(b)
    if b then 
		base.MapWindow.resetMapTerrain()
		eSearch:setText(cdata.Search)
        updateInfoServer()
        updateIntegrityCheck()	
		local w,h = sDCSMulti:calcSize()	
		sVersion:setText(base.START_PARAMS.version)
		sVersion:setPosition(w+50, 8)
	else
		if PasswordPanel.isVisible() then
			PasswordPanel.show(false) 
		end	
    end   

    window:setVisible(b)  
		
	if b and net.NO_CLIENT == true  then
		onChange_btnCreateServer()
	end	
	
	if net.NO_SERVER == true then
		btnCreateServer:setVisible(false)
	else
		btnCreateServer:setVisible(true)
	end
end

function updatePlayer()
    playerName = nickname:getNickname()
    if playerName == nil or playerName == "" then
        nickname.show(true, updatePlayer)
    else
        sLoginNickname:setText(playerName)  
    end

 --   local w,h = sLoginNickname:calcSize()
 --   sLoginNickname:setBounds(1280 - w-15, 5, w, 30)
 --   btnNickname:setBounds(1280 - w - 42, 10,23,20)   
end

local function compTable(tab1, tab2)
  -- недоступные снизу
  --  if tab1.enableStart ~= tab2.enableStart then
  --      return (base.tostring(tab1.enableStart) > base.tostring(tab2.enableStart))
  --  end

    if base.type(tab1[curKeySort]) == "string" then
        if (base.tostring(tab1[curKeySort]) == base.tostring(tab2[curKeySort])) then            
            return textutil.Utf8Compare(tab1['name'], tab2['name'])
        end
        if sortReverse then
            return textutil.Utf8Compare(tab2[curKeySort], tab1[curKeySort])
        end
        return textutil.Utf8Compare(tab1[curKeySort], tab2[curKeySort])
    elseif base.type(tab1[curKeySort]) == "boolean" then
        if (base.tostring(tab1[curKeySort]) == base.tostring(tab2[curKeySort])) then            
            return textutil.Utf8Compare(tab1['name'], tab2['name'])
        end
        if sortReverse then
            return (base.tostring(tab1[curKeySort]) < base.tostring(tab2[curKeySort]))
        end
        return (base.tostring(tab1[curKeySort]) > base.tostring(tab2[curKeySort]))
    else
        if (base.tostring(tab1[curKeySort]) == base.tostring(tab2[curKeySort])) then            
            return textutil.Utf8Compare(tab1['name'], tab2['name'])
        end
        if sortReverse then
            return (tab1[curKeySort] > tab2[curKeySort])
        end

        return (tab1[curKeySort] < tab2[curKeySort])
    end       
end


local function getColumnHeaderSkin(a_key, a_index)
    groupSkin = 2

	if curKeySort == a_key then
		if sortReverse then
			return SkinsHeaders[groupSkin].skinSortDown
		else
			return SkinsHeaders[groupSkin].skinSortUp
		end
	else
		return SkinsHeaders[groupSkin].skinNoSort
	end
end

function updateColumnHeaders()
	local count = serverGrid:getColumnCount()
	
	for i = 4, count - 1 do
		local gridHeaderCell = serverGrid:getColumnHeader(i)
		
		if gridHeaderCell then
			local skin = getColumnHeaderSkin(gridHeaderCell.KeySort, i)
			
			if skin then
				gridHeaderCell:setSkin(skin)
			end
		end
	end
end

function getRequiredModules(a_server)
    local listRequiredModules = {}
    if TheatreOfWarData.isEnableTheatre(a_server.theatre) ~= true then
        --добавляем в список id земли
        base.table.insert(listRequiredModules, a_server.theatre)
    end
    
    if a_server.requiredModules then
        for k,v in base.pairs(a_server.requiredModules) do
            if (base.enableModules[v] ~= true) then
                base.table.insert(listRequiredModules, v)
            end
        end
    end
    return listRequiredModules
end

function addItemFilterMaps(a_name, a_type, a_needSelect)
    if listMaps[a_type] == nil then
        local item = ListBoxItem.new(a_name)
        item.type = a_type   
        clMap:insertItem(item)
        if a_needSelect then
            clMap:selectItem(item)
        end
        listMaps[a_type] = true    
    end            
end

function addItemFilterRegions(a_name, a_type, a_needSelect)
    if listRegions[a_type] == nil then
        local item = ListBoxItem.new(a_name)
        item.type = a_type   
        clRegion:insertItem(item)
        if a_needSelect then
            clRegion:selectItem(item)
        end
        listRegions[a_type] = true    
    end            
end

function fillFilterMaps(a_listMaps)
    clMap:clear()
    
    local item = ListBoxItem.new(_("Any"))
    item.type = "any"    
    clMap:insertItem(item)
    clMap:selectItem(item)
        
    for k,v in base.pairs(a_listMaps) do
        item = ListBoxItem.new(_(v))
        item.type = v
        clMap:insertItem(item)
    end
end

function filtration(a_server)
    local result = true
    
	local bFavoritesOnly = cbFavoritesOnly:getState()
	if bFavoritesOnly == true and a_server.favorite ~= true then
        result = false
    end
	
    local item = clMap:getSelectedItem()
    if item and item.type ~= "any" and item.type ~= a_server.theatre then
        result = false
    end
	
	local item = clRegion:getSelectedItem()
    if item and item.type ~= "any" and item.type ~= a_server.geoContinent then
        result = false
    end
    
    item = clPassword:getSelectedItem()
    if item and item.type ~= "any" and item.type ~= a_server.password then
        result = false
    end
    
    item = clProtect:getSelectedItem()
    if item and item.type ~= "any" and item.type ~= a_server.require_pure_clients then
        result = false
    end
    
    local findText = eSearch:getText()
    if a_server.name and findText and findText ~= "" and findText ~= cdata.Search and not (base.string.find(base.string.upper(a_server.name), base.string.upper(findText))) then
        result = false
    end
    
    local pingText = ePing:getText()
    if pingText and pingText ~= "" then
        local ping = base.tonumber(pingText)
        if ping and ping < (a_server.ping * 1000) then
            result = false
        end
    end
    
    local ePsformText       = ePsform:getText()
    local ePsformEndText    = ePsformEnd:getText()
    local Psform = 0
    local PsformEnd = 99999
    if ePsformText and ePsformText ~= "" then
        Psform = base.tonumber(ePsformText)
    end    
    if ePsformEndText and ePsformEndText ~= "" then
        PsformEnd = base.tonumber(ePsformEndText)
    end
    
    if not (Psform <= a_server.numPlayers and PsformEnd >= a_server.numPlayers) then
        result = false
    end

    return result
end

function update(a_serverlist) 
---base.print("----------------------------------")
--    base.U.traverseTable(a_serverlist)
--    base.print(a_serverlist)
--    base.print("-------------------------4---------")

    listServers = {}
	
    for k,v in base.pairs(a_serverlist) do       
        if (v.status == 'online') and (v.name ~= nil) then
            v.requiredModulesTbl = getRequiredModules(v)
            if #v.requiredModulesTbl == 0 then
                v.enableStart = true 
            else
                v.enableStart = false  
            end
			
			if v.advanced and v.advanced.allow_trial_only_clients == true then
				v.allow_trial_only_clients = true
			else	
				v.allow_trial_only_clients = false
			end 	
			
			v.geoContinent = v.geoContinent or ""
			v.geoCountry = v.geoCountry or ""
			v.geoCountryName = keys.tabCountryCodes[v.geoCountry] or ""
            
			if favoritesList[v.address] == true then
				v.favorite = true
			else
				v.favorite = false
			end
		
            if (bEnableStartVisible == true or v.enableStart == true) and filtration(v) then
                table.insert(listServers,v)
            end
        end
    end

    --updateNumplayers
    local numS = 0
    local numP = 0
    for k,server in base.pairs(listServers) do
        numS = numS + 1        
        if server.numPlayers then
            numP = numP + server.numPlayers
        end
    end
	
    sServersPlayers:setText(string.format(_("SERVERS/PLAYERS:").." %s/%s",numS,numP))
    
	updateGrid()
    updateColumnHeaders()

    
    --[[
    
                        ping = 0
00011.701 UNKNOWN ?:     numPlayers = 0
00011.701 UNKNOWN ?:     password = false
00011.701 UNKNOWN ?:     desc = ''
00011.701 UNKNOWN ?:     miz = ''
00011.701 UNKNOWN ?:     address = '91.210.252.84:10308'
00011.701 UNKNOWN ?:     status = 'pending'
00011.701 UNKNOWN ?:     name = ''
00011.701 UNKNOWN ?:     gameTime = 0
00011.701 UNKNOWN ?:     maxPlayers = 0]]
end


function updateGrid()
    rowIndex = 0;
    local curRow = serverGrid:getVertScrollPosition()
    serverGrid:removeAllRows()
    
    local selRow = nil
	
	if listServers and  listServers[1] then
        base.table.sort(listServers, compTable)
    end
    
    for k,v in base.pairs(listServers) do
        if v.status == 'online' then 
            if listRows[v.address] == nil then
                insertRow(v)
            else
                updateRow(v)
            end
            
            if curServer and (v.address == curServer) then
                selRow = rowIndex
            end
            rowIndex = rowIndex +1
        end
    end
   
    serverGridAdv:updateSkins()
    
    if selRow then
        selectRow(selRow)        
    end
    
    serverGrid:setVertScrollPosition(curRow)
end

function updateRow(v)

    serverGrid:insertRow(rowHeight)
      
    local ind = rowIndex%2

    local cell
    local numCol = 0
    
    local enableStart = v.enableStart

    ------1
    cell = listRows[v.address][numCol]
    cell.data = {server = v, row = rowIndex, favorite = v.favorite}
    cell:setSkin(btnSkinStar) 
    cell:setState(v.favorite)     
    serverGrid:setCell(numCol, rowIndex, cell)
    numCol = numCol + 1
    
    ------2
    cell = listRows[v.address][numCol]
    cell.password = v.password
    local tooltipsPas = cdata.passwordDisable
    if v.password == true then 
        tooltipsPas = cdata.passwordEnable
        cell:setSkin(staticSkinGridServersLock)
    else
        cell:setSkin(staticSkinGridServersLockNo)
    end      
    cell:setTooltipText(tooltipsPas)
    serverGrid:setCell(numCol, rowIndex, cell)
    numCol = numCol + 1
    
    ------3
    cell = listRows[v.address][numCol]
    cell.require_pure_clients = false
    local tooltipsPas = cdata.integrityCheckDisable
    if v.require_pure_clients == true then 
        tooltipsPas = cdata.integrityCheckEnable
        cell.require_pure_clients = true
        cell:setSkin(staticSkinGridServersIC)
    else
        cell:setSkin(staticSkinGridServersICNo)
    end      
    cell:setTooltipText(tooltipsPas)
    serverGrid:setCell(numCol, rowIndex, cell)
    numCol = numCol + 1
	
	------4
    cell = listRows[v.address][numCol]
    cell.allow_trial_only_clients = false
    local tooltipsTrial = cdata.trialDisable
    if v.allow_trial_only_clients == true then 
        tooltipsTrial = cdata.trialEnable
        cell.allow_trial_only_clients = true
        cell:setSkin(staticSkinGridServersIC)
    else
        cell:setSkin(staticSkinGridServersICNo)
    end      
    cell:setTooltipText(tooltipsTrial)
    serverGrid:setCell(numCol, rowIndex, cell)
    numCol = numCol + 1
    
    ------5
    cell = listRows[v.address][numCol]
--    cell:setSkin(staticSkinGridServersAlignMiddle)
	local ping = base.math.ceil(v.ping*1000)
    cell:setText(ping)
	if v.advanced and v.advanced.maxPing and v.advanced.maxPing > 0 and ping > v.advanced.maxPing then
		cell.notAllowedPing = true
	else
		cell.notAllowedPing = false
	end
	
    cell.enableStart = enableStart
    serverGrid:setCell(numCol, rowIndex, cell)
    numCol = numCol + 1
	
	------6 flag
	cell = listRows[v.address][numCol]
	cell:setSkin(staticSkinGridItemFlag)
	if v.geoCountry then
		cell:setSkin(SkinUtils.setStaticPicture("dxgui\\skins\\skinME\\images\\Flags\\"..v.geoCountry..".png", cell:getSkin()))
	end
	cell.geoCountry = v.geoCountry
	cell.geoCountryName = v.geoCountryName
	cell:setTooltipText(cell.geoCountryName)
    serverGrid:setCell(numCol, rowIndex, cell)
    numCol = numCol + 1
	
    ------7  name
    cell = listRows[v.address][numCol]
    cell.enableStart = enableStart
    if v.status == 'offline' then             
        cell:setText(v.address)
    else
        cell:setText(v.name)
    end 
    cell:setTooltipText(v.name)
    serverGrid:setCell(numCol, rowIndex, cell)
    numCol = numCol + 1
    
    ------8
    cell = listRows[v.address][numCol]
--    cell:setSkin(staticSkinGridServersAlignMiddle)
    cell:setText(_(v.theatre or "none")) 
    cell:setTooltipText(_(v.theatre or "none"))
    cell.enableStart = enableStart
    serverGrid:setCell(numCol, rowIndex, cell)
    numCol = numCol + 1
    
    ------9
    cell = listRows[v.address][numCol]
--    cell:setSkin(staticSkinGridServersAlignMiddle)
    cell:setText(v.miz) 
    cell:setTooltipText(v.miz)
    cell.enableStart = enableStart
    serverGrid:setCell(numCol, rowIndex, cell)
    numCol = numCol + 1
    
    ------10
    cell = listRows[v.address][numCol]
--    cell:setSkin(staticSkinGridServersAlignMiddle)
    cell:setText(v.numPlayers.."/"..v.maxPlayers)
    cell.enableStart = enableStart
    serverGrid:setCell(numCol, rowIndex, cell)
    numCol = numCol + 1
     
    ------11 
    cell = listRows[v.address][numCol]
--    cell:setSkin(staticSkinGridServersAlignMiddle)
    cell.enableStart = enableStart
    local dd, hh, mm, ss = base.U.timeToDHMS(v.gameTime)
    cell:setText(string.format("%2i/%i:%02i:%02i", dd, hh, mm, ss))
    serverGrid:setCell(numCol, rowIndex, cell)
    numCol = numCol + 1
	
	------12 
    cell = listRows[v.address][numCol]
--    cell:setSkin(staticSkinGridServersAlignMiddle)
    cell.enableStart = enableStart
	local dd, hh, mm, ss = base.U.timeToDHMS(v.localTime)
	cell:setText(string.format("%i:%02i", hh, mm))
    serverGrid:setCell(numCol, rowIndex, cell)
    numCol = numCol + 1
end

function insertRow(v)
    serverGrid:insertRow(rowHeight)
        
    local ind = rowIndex%2

    listRows[v.address] = {}
    local cell
    local numCol = 0 
    
    local enableStart = v.enableStart    
    
    ------1
  --  cell = Static.new()
    cell = ToggleButton.new()
    cell.data = {server = v, row = rowIndex, favorite = v.favorite} 
    cell:setSkin(btnSkinStar)    
    cell:setState(v.favorite) 
    cell.onChange = function(self)
        selectRow(self.data.row)
        
        if self.data.favorite == true then
            removefromFavorites(self.data.row)
			self.data.favorite = false
        else
            addtoFavorites(self.data.row)
			self.data.favorite = true
        end    
    end
    serverGrid:setCell(numCol, rowIndex, cell)
    listRows[v.address][numCol] = cell
    numCol = numCol + 1
    
    ------2
    cell = Static.new()
    cell.password = v.password
    local tooltipsPas = cdata.passwordDisable
    if v.password == true then 
        tooltipsPas = cdata.passwordEnable
        cell:setSkin(staticSkinGridServersLock)
    else
        cell:setSkin(staticSkinGridServersLockNo)
    end
      
    cell:setTooltipText(tooltipsPas)
    serverGrid:setCell(numCol, rowIndex, cell)
    listRows[v.address][numCol] = cell
    numCol = numCol + 1
    
    ------3
    cell = Static.new()
    cell.require_pure_clients = false
    local tooltipsPas = cdata.integrityCheckDisable
    if v.require_pure_clients == true then 
        tooltipsPas = cdata.integrityCheckEnable
        cell:setSkin(staticSkinGridServersIC)
        cell.require_pure_clients = true
    else
        cell:setSkin(staticSkinGridServersICNo)
    end     
    cell:setTooltipText(tooltipsPas)
    serverGrid:setCell(numCol, rowIndex, cell)
    listRows[v.address][numCol] = cell
    numCol = numCol + 1
    
	------4
	cell = Static.new()
    cell.allow_trial_only_clients = false
    local tooltipsPas = cdata.trialDisable
    if v.allow_trial_only_clients == true then 
        tooltipsPas = cdata.trialEnable
        cell:setSkin(staticSkinGridServersIC)
        cell.allow_trial_only_clients = true
    else
        cell:setSkin(staticSkinGridServersICNo)
    end     
    cell:setTooltipText(tooltipsPas)
    serverGrid:setCell(numCol, rowIndex, cell)
    listRows[v.address][numCol] = cell
    numCol = numCol + 1
	
    ------5
    cell = Static.new()
 --   cell:setSkin(staticSkinGridServersAlignMiddle)
	local ping = base.math.ceil(v.ping*1000)
    cell:setText(ping)
	if v.advanced and v.advanced.maxPing and v.advanced.maxPing > 0 and ping > v.advanced.maxPing then
		cell.notAllowedPing = true
	else
		cell.notAllowedPing = false
	end
    cell.enableStart = enableStart
    serverGrid:setCell(numCol, rowIndex, cell)
    listRows[v.address][numCol] = cell
    numCol = numCol + 1
	
	------6 flag
	cell = Static.new()
	cell:setSkin(staticSkinGridItemFlag)
	if v.geoCountry then
		cell:setSkin(SkinUtils.setStaticPicture("dxgui\\skins\\skinME\\images\\Flags\\"..v.geoCountry..".png", cell:getSkin()))
	end
	cell.geoCountry = v.geoCountry
	cell.geoCountryName = v.geoCountryName
	cell:setTooltipText(cell.geoCountryName)
    listRows[v.address][numCol] = cell
    numCol = numCol + 1
	
    ------7   name
    cell = Static.new()
--    cell:setSkin(staticSkinGridServersAlignMiddle)
    cell:setWrapping(false)
    cell:setText(v.name)    
    cell:setTooltipText(v.name)
    cell.enableStart = enableStart
    serverGrid:setCell(numCol, rowIndex, cell)
    listRows[v.address][numCol] = cell
    numCol = numCol + 1
    
    ------8
    cell = Static.new()
 --   cell:setSkin(staticSkinGridServersAlignMiddle)
    cell:setText(_(v.theatre or "none")) 
    cell:setWrapping(false)
    cell:setTooltipText(_(v.theatre or "none"))
    cell.enableStart = enableStart
    serverGrid:setCell(numCol, rowIndex, cell)
    listRows[v.address][numCol] = cell
    numCol = numCol + 1
    
    ------9
    cell = Static.new()
 --   cell:setSkin(staticSkinGridServersAlignMiddle)
    cell:setText(v.miz) 
    cell:setWrapping(false)
    cell:setTooltipText(v.miz)
    cell.enableStart = enableStart
    serverGrid:setCell(numCol, rowIndex, cell)
    listRows[v.address][numCol] = cell
    numCol = numCol + 1
    
    ------10
    cell = Static.new()
--    cell:setSkin(staticSkinGridServersAlignMiddle)
    cell:setText(v.numPlayers.."/"..v.maxPlayers)
    cell.enableStart = enableStart
    serverGrid:setCell(numCol, rowIndex, cell)
    listRows[v.address][numCol] = cell
    numCol = numCol + 1
     
    ------11
    cell = Static.new()
--    cell:setSkin(staticSkinGridServersAlignMiddle)
    local dd, hh, mm, ss = base.U.timeToDHMS(v.gameTime)
    cell:setText(string.format("%2i/%i:%02i:%02i", dd, hh, mm, ss))
    cell.enableStart = enableStart    
    serverGrid:setCell(numCol, rowIndex, cell)
    listRows[v.address][numCol] = cell
    numCol = numCol + 1
	
	------12
    cell = Static.new()
--    cell:setSkin(staticSkinGridServersAlignMiddle)
	local dd, hh, mm, ss = base.U.timeToDHMS(v.localTime)
	cell:setText(string.format("%i:%02i", hh, mm))
    cell.enableStart = enableStart    
    serverGrid:setCell(numCol, rowIndex, cell)
    listRows[v.address][numCol] = cell
    numCol = numCol + 1
end

function getAddress()
--base.print("-----curServer=",curServer)
    return curServer
end

function onChange_btnRefresh()
--base.print("---onChange_btnRefresh()---")  
	if isStarting == false then
		clearInfoServer()
		getNewServerList()
	end
end

function onChange_btnExit()
	endUpdate()
	serverListUpdateComplete = true
	isStarting = false	
		
    if ProductType.getType() == "LOFAC" then
        Quit()        
        base.mmw.showMissionEditor()
	elseif base.__PRODUCT_ID__ == 2 and managerModulesME.moduleMainMenu == nil then
		Quit() 
		base.mmw.showMissionEditor()
    else
        base.START_PARAMS.returnScreen = ''
        Quit()  
        base.mmw.show(true)
    end	
    show(false)
end

function onChange_btnConnectbyIP()
	endUpdate()
	serverListUpdateComplete = true
	isStarting = false	
	
    PasswordPanel.show(true)     
    PasswordPanel.setIp(MeSettings.getLastIp())
    PasswordPanel.setCallback(startClient)  
    PasswordPanel.setReadOnlyIP(false)                  
end

function onChange_btnNickname()
    nickname.show(true, updatePlayer)   
end

function onChange_btnIntegrityCheck()

end

function onChange_btnIntegrityCheckNo()
    --show(false)
    listIC.show(true, filesIntegrityCheck)
end

function onChange_tbtnEnableStartVisible(self)
    bEnableStartVisible = not self:getState()
    if serverList ~= nil then
        update(serverList)               
    end
end

function onChange_btnJoin()
    endUpdate()
	serverListUpdateComplete = true
	isStarting = false	
	
    local curRow = serverGrid:getSelectedRow()

    if curRow then         
        local widget = serverGrid:getCell(0, curRow)
        if widget and widget.data and widget.data.server then
			if widget.data.server.enableStart ~= false then
				local server = widget.data.server
				
				
				local ping = base.math.ceil(server.ping*1000)
				if server.advanced and server.advanced.maxPing and server.advanced.maxPing > 0 and ping > server.advanced.maxPing then
					MsgWindow.warning(_("Your ping is too high to fly in this server"), _("WARNING"), _("OK")):show()
				elseif net.check_ic_requirements(server) then
					server_addr = server.address 
					password = nil
					if widget.data.server.password == true then 
						PasswordPanel.show(true, true)
						PasswordPanel.setCallback(startClient, server.name, server.advanced)  
						PasswordPanel.setReadOnlyIP(true) 
						PasswordPanel.setIp(server_addr) 
					
						if passwordsList[server_addr] then
							PasswordPanel.setPassword(passwordsList[server_addr]) 
						end
					else
						startClient(server_addr, "", server.name, server.advanced)
					end  
				else                
					MsgWindow.warning(_("Pure client is required"), _("WARNING"), _("OK")):show()
				end 
			else
				if TheatreOfWarData.isEnableTheatre(widget.data.server.theatre) ~= true then
					if modulesInfo.isHave(widget.data.server.theatre) == true then
						if (ProductType.getType() ~= "STEAM") then
							local handler = MsgWindow.warning(_("You need to buy and install the following module:")..modulesInfo.getModulDisplayNameByModulId(widget.data.server.theatre), _("WARNING"), _("NO, THANKS"), _("INSTALL"))
							function handler:onChange(buttonText)
								if buttonText == _("INSTALL") then 							
									mod_updater.installComponent(modulesInfo.getUpdateId(widget.data.server.theatre))
								end
							end 
							handler:show() 
						end
					else
						local handler = MsgWindow.warning(_("You need to buy and install the following module:")..modulesInfo.getModulDisplayNameByModulId(widget.data.server.theatre), _("WARNING"), _("NO, THANKS"), _("BUY"))
						function handler:onChange(buttonText)
							if buttonText == _("BUY") then 
								local blink = modulesInfo.getBlink(widget.data.server.theatre)
								if blink then
									local url = DcsWeb.make_auth_url(blink)
									os.open_uri(url)
								end
							end
						end 
						handler:show()						
					end
				end
			end
        end       
    end        
end

function startClient(a_server_addr, a_password, a_server_name, a_advanced)
   --base.print("---start_client--",a_server_addr, a_password, a_server_name)
    MeSettings.setLastIp(a_server_addr)

	if a_advanced and a_advanced.server_can_screenshot == true 
		and optionsEditor.getOption("miscellaneous.allow_server_screenshots") == false then
		
		local result = nil
		local handler = MsgWindow.question(_("This server can take screenshots from you. Do you want to connect?"), _('QUESTION'), _("Always allow"), _("Allow once"), _("Do not connect"))
		function handler:onChange(button)			
			result = button
		end
		handler:show()

		if result == _("Always allow") then                
			optionsEditor.setOption("miscellaneous.allow_server_screenshots", true)			
		elseif result == _("Allow once") then                
			
		elseif result == _("Do not connect") then                
			return false, 'screenshots'
		else
			return false, 'screenshots'
		end
	end
	
    net.set_name(playerName)   
    local result = net.start_client(a_server_addr, a_password)
    if result == 0 then 
		base.initTer = true
		waitScreen.showSplash(true)
		Analytics.pageview(Analytics.Client)
		Analytics.report_server_name(a_server_name or "")
		
		passwordsList[a_server_addr] = a_password
		savePasswords()   
        return true
    end

    return false
end

-- не удалось подключиться, неверный пароль
function onNetDisconnect()
	PasswordPanel.show(true, true)
	PasswordPanel.showIncorrectPassword(true)
	waitScreen.showSplash(false)
end 

-- удалось подключиться
function onNetConnect()
	base.START_PARAMS.returnScreen = 'multiplayer'
	
	Quit(false)  
	show(false)
	PasswordPanel.show(false)  	   
	
	if base.MapWindow.getVisible() == true then
		base.MapWindow.show(false)
	end 
	
	Chat.clear()
end

function onChange_btnCreateServer()  
	endUpdate()
	serverListUpdateComplete = true
	isStarting = false	
	
    Chat.clear()    
    Quit() 
    show(false)
    Create_server.show(true)
end

-------------------------------------------------------------------------------
-- 
serverListTEST = 
{
    [1] = {
        password = true,
        status = "online",
        missionName = "missionName1",
        numPlayers = 1,
        map = "Nevada",
        maxPlayers = 32,
        gameTime = 234,
        address = "111.111.131.111:10308",
        ping = 0.342,
        name = "serverName1",
        theatre = 'Normandy',
        },
    [2] = {
        password = true,
        status = "online",
        missionName = "missionName2",
        numPlayers = 6,
        map = "Nevada",
        maxPlayers = 32,
        gameTime = 233,
        address = "111.121.111.112:10308",
        ping = 0.334,
        name = "serverName2",
        theatre = 'Caucasus',
        },
    [3] = {
        password = false,
        status = "online",
        missionName = "missionName3",
        numPlayers = 4,
        map = "Nevada",
        maxPlayers = 32,
        gameTime = 222,
        address = "111.111.161.113:10308",
        ping = 0.354,
        name = "serverName3",
        theatre = 'Caucasus',
        },
    [4] = {
        password = false,
        status = "online",
        missionName = "missionName4",
        numPlayers = 7,
        map = "Nevada",
        maxPlayers = 32,
        gameTime = 41,
        address = "111.171.178.114:10308",
        ping = 0.35,
        name = "serverName4",
        theatre = 'Caucasus',
        },
    [5] = {
        password = true,
        status = "online",
        missionName = "missionName5",
        numPlayers = 5,
        map = "Nevada",
        maxPlayers = 32,
        gameTime = 54,
        address = "111.111.101.111:10308",
        ping = 0.324,
        name = "serverName5",
        theatre = 'Caucasus',
        },
    [6] = {
        password = true,
        status = "online",
        missionName = "missionName6",
        numPlayers = 16,
        map = "Nevada",
        maxPlayers = 16,
        gameTime = 23,
        address = "111.111.151.112:10308",
        ping = 0.346,
        name = "serverName6",
        theatre = 'Caucasus',
        },
    [7] = {
        password = false,
        status = "online",
        missionName = "missionName7",
        numPlayers = 13,
        map = "Nevada",
        maxPlayers = 16,
        gameTime = 242,
        address = "111.111.671.113:10308",
        ping = 0.134,
        name = "serverName7",
        theatre = 'Caucasus',
        },
    [8] = {
        password = false,
        status = "offline",
        missionName = "missionName8",
        numPlayers = 123,
        map = "Nevada",
        maxPlayers = 16,
        gameTime = 211,
        address = "111.111.151.114:10308",
        ping = 0.234,
        name = "serverName8",
        theatre = 'Caucasus',
        },
    [9] = {
        password = true,
        status = "online",
        missionName = "missionName9",
        numPlayers = 16,
        map = "Nevada",
        maxPlayers = 16,
        gameTime = 124,
        address = "111.151.111.111:10308",
        ping = 0.334,
        name = "serverName9",
        theatre = 'Caucasus',
        },
    [10] = {
        password = true,
        status = "online",
        missionName = "missionName10",
        numPlayers = 11,
        map = "Nevada",
        maxPlayers = 16,
        gameTime = 323,
        address = "771.111.111.112:10308",
        map = "nevada",
        ping = 0.314,
        name = "serverName10",
        theatre = 'Caucasus5',
        requiredModules = 
        {
		["1"] = "1",
		["2"] = "2",
		["3"] = "3",
		["4"] = "4",
		["5"] = "5",
		["6"] = "6",
		["7"] = "7",
		["8"] = "8",
		["9"] = "9",
		["10"] = "10",
		["11"] = "11",
		["12"] = "12",
		["13"] = "13",
		["14"] = "14",
		["15"] = "15",
		["163"] = "16",
		["164"] = "17",
		["165"] = "18",
		["166"] = "19",
		["167"] = "20",
		["168"] = "21",
		["169"] = "22",
		["1668"] = "23",
        }
        },
    [11] = {
        password = false,
        status = "online",
        missionName = "missionName11",
        numPlayers = 14,
        map = "Normandy",
        maxPlayers = 16,
        gameTime = 222,
        address = "111.111.151.113:10308",
        ping = 0.324,
        name = "serverName11",
        theatre = 'Caucasus4',
		requiredModules = 
        {
        FFG="FFG",
		},
        },
    [12] = {
        password = false,
        status = "online",
        missionName = "missionName12",
        numPlayers = 12,
        map = "Nevada",
        maxPlayers = 16,
        gameTime = 521,
        address = "111.171.111.114:10308",
        ping = 0.314,
        name = "serverName12",
        theatre = 'Caucasus5',
		requiredModules = 
        {
        FFG="FFG",
        ["F-86F Sabre by Belsimtek"] = "F-86F Sabre by Belsimtek",
		["1"] = "1er",
		["2"] = "1ere",
		["3"] = "ewr1",
		["4"] = "1",
		["5"] = "1",
		["6"] = "1",
		["7"] = "1",
		["8"] = "1",
		["9"] = "1",
		["10"] = "1",
		["11"] = "1",
		["12"] = "1",
		["13"] = "1",
		["14"] = "1",
		["15"] = "1",
		["163"] = "1",
		["164"] = "1",
		["165"] = "1",
		["166"] = "1",
		["167"] = "1",
		["168"] = "1xx",
        },
        },
    [13] = {
        password = true,
        status = "offline",
        missionName = "missionName13",
        numPlayers = 15,
        map = "Nevada",
        maxPlayers = 16,
        gameTime = 234,
        address = "111.111.111.181:10308",
        ping = 0.314,
        name = "serverName13",
        theatre = 'Caucasus3',
        },
    [14] = {
        password = true,
        status = "online",
        missionName = "missionName14",
        numPlayers = 13,
        map = "Nevada",
        maxPlayers = 16,
        gameTime = 223,
        address = "111.151.111.112:10308",
        ping = 0.3324,
        name = "serverName14",
        theatre = 'Caucasus3',
        },
    [15] = {
        password = false,
        status = "offline",
        missionName = "missionName15",
        numPlayers = 11,
        map = "Nevada",
        maxPlayers = 16,
		geoContinent = "AN",
        gameTime = 252,
        address = "111.111.189.113:10308",
        ping = 0.314,
        name = "serverName15",
        theatre = 'Caucasus',
        },
    [16] = {
        password = false,
        status = "online",
        missionName = "missionName16",
        numPlayers = 18,
        map = "Nevada",
		geoContinent = "OC",
		geoCountry = "CA",
        maxPlayers = 16,
        gameTime = 221,
        address = "161.161.111.114:10308",		
        ping = 1.12,
        name = "serverName16",
        theatre = 'Caucasus',
		advanced = {
		maxPing = 20,
		}
        },
    [17] = {
        password = true,
        status = "online",
        missionName = "missionName17",
        numPlayers = 13,
        map = "Nevada",
        maxPlayers = 16,
		geoCountry = "AX",
        gameTime = 24,
        address = "111.111.161.111:10308",
        ping = 0.324,
        name = "serverName17",
        theatre = 'Caucasus',
        },
    [18] = {
        password = true,
        status = "online",
        missionName = "missionName18",
        numPlayers = 16,
        map = "Nevada",
		geoContinent = "AN",
        maxPlayers = 16,
		geoCountry = "BM",
        gameTime = 23,
        address = "141.111.111.112:10308",
        ping = 0.314,
        name = "serverName18",
        theatre = 'Nevada',
        },
    [19] = {
        password = false,
        status = "online",
        missionName = "missionName19",
        numPlayers = 5,
        map = "Nevada",
        maxPlayers = 16,
		geoContinent = "AN",
		geoCountry = "IO",
        gameTime = 262,
        address = "111.151.161.113:10308",
        ping = 0.14,
        name = "serverName19",
        theatre = 'Caucasus',
		advanced = {
			allow_trial_only_clients = true,
			allow_players_pool = true,
		},
		opts = {},
        },
    [20] = {
        password = false,
        status = "online",
        missionName = "missionName20",
        numPlayers = 4,
        map = "Nevada",
        maxPlayers = 16,
        gameTime = 218,
		geoCountry = "MQ",
		start_time  = 64444,
        address = "111.111.181.114:10308",
        ping = 0.24,
        name = "serverName20",
        theatre = 'Caucasus',
        },
    [21] = {
        password = true,
        status = "offline",
        missionName = "missionName21",
        numPlayers = 4,
        map = "Nevada",
        maxPlayers = 16,
        gameTime = 234,
		geoCountry = "BR",
		start_time  = 14444,
        address = "141.111.111.111:10308",
        ping = 0.34,
        name = "serverName21",
        theatre = 'Caucasus',
        },
    [22] = {
        password = true,
        status = "online",
        missionName = "missionName22",
        numPlayers = 6,
        map = "Nevada",
        maxPlayers = 16,
        gameTime = 123,
		geoCountry = "RU",
		start_time  = 74444,
        address = "111.111.116.112:10308",
        ping = 0.004,
        name = "serverName22",
        theatre = nil,
        },
    [23] = {
        password = false,
        status = "online",
        missionName = "missionName23",
        numPlayers = 11,
        map = "Nevada5",
        maxPlayers = 16,
        gameTime = 222,
        address = "111.114.111.113:10308",
        ping = 0.32,
        name = "serverName23",
        theatre = 'NEVADA_terrain',
		slots = 
			{
				neutrals = { },
				blue = {},
				red = { },
			},
        },
    [24] = {
        password = false,
        status = "online",
        require_pure_clients = true,
        missionName = "missionName24",
        numPlayers = 12,
        map = "none",
        maxPlayers = 16,
        gameTime = 231,
        address = "111.111.118.114:10308",
        ping = 0.31,
        name = "11serverName24",
        theatre = nil,
        desc = 'gfdfg dfgf gdf gdfgdfgdfg fg fdsf dsf sfdgdfgdfgdf hh ghgh gfhgfhdghgf hgh gfhgh',
        descMis = '3434 dfgg dfgfgdfg  dsf ds dsfd sfd fdsf dsf dfd sfgfgfgdf',
		slots = 
		{
			blue = {{'A-10C',
					{	[4] = {pilotName = "PILOT_687", role = "Pilot", crew_index = 0}, 
						[2] = {pilotName = "playerName2111111111111111",role = "role2", crew_index = 1},
						[3] = {pilotName = "playerName3",role = "role3", crew_index = 2}, 
						[1] = {pilotName = "playerName4",role = "role4", crew_index = 3}},
				'CAS'},
					{'F-666C',
					{[1] = {pilotName = "playerName1",role = "role1", crew_index = 0}, 
					[2] = {pilotName = "playerName2",role = "role2", crew_index = 1}, 
					[3] = {pilotName = "playerName3",role = "role3", crew_index = 2}, 
					[4] = {pilotName = "playerName4",role = "role4", crew_index = 3}},
				'CAS'},
				
					{'A-10C',{[1] = {pilotName = "wwwwww",			role = "Pilot", crew_index = 0}},'CAS'},	
					{'F-15C',{[1] = {pilotName = "aPILOT_138944",	role = "Pilot", crew_index = 0}},'CAS'},
					{'F-15C',{[1] = {pilotName = "sPILOT_3",		role = "Pilot", crew_index = 3}},'CAS'},
					{'F-15C',{[1] = {pilotName = "dPILOT_687",		role = "Pilot", crew_index = 0}},'CAS'},
					{'F-15C',{[1] = {pilotName = "hPILOT_776657",	role = "Pilot", crew_index = 0}},'CAS'},
				},
			red = {{'A-10C',
					{	[4] = {pilotName = "PILOT_687", role = "Pilot", crew_index = 0}, 
						[2] = {pilotName = "playerName2",role = "role2", crew_index = 1},
						[3] = {pilotName = "playerName311111111111111",role = "role3", crew_index = 2}, 
						[1] = {pilotName = "playerName4",role = "role4", crew_index = 3}},
				'CAS'},
					{'F-666C',
					{[1] = {pilotName = "playerName1",role = "role1", crew_index = 0}, 
					[2] = {pilotName = "playerName2",role = "role2", crew_index = 1}, 
					[3] = {pilotName = "playerName3",role = "role3", crew_index = 2}, 
					[4] = {pilotName = "playerName4",role = "role4", crew_index = 3}},
				'CAS'},
				
					{'A-10C',{[1] = {pilotName = "wwwwww",			role = "Pilot", crew_index = 0}},'CAS'},	
					{'F-15C',{[1] = {pilotName = "aPILOT_138944",	role = "Pilot", crew_index = 0}},'CAS'},
					{'F-15C',{[1] = {pilotName = "sPILOT_3",		role = "Pilot", crew_index = 3}},'CAS'},
					{'F-15C',{[1] = {pilotName = "dPILOT_687",		role = "Pilot", crew_index = 0}},'CAS'},
					{'F-15C',{[1] = {pilotName = "hPILOT_776657",	role = "Pilot", crew_index = 0}},'CAS'},
				},
		},
        },        
}

