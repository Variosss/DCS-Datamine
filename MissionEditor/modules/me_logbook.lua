local base = _G

module('me_logbook')

local require   = base.require
local string    = base.string
local tostring  = base.tostring
local print     = base.print
local table     = base.table
local ipairs    = base.ipairs
local pairs     = base.pairs
local math      = base.math
local tonumber  = base.tonumber
local loadfile  = base.loadfile

local Static            = require('Static')
local U                 = require('me_utilities')
local S                 = require('Serializer')
local MsgWindow         = require('MsgWindow')
local MissionModule     = require('me_mission')
local Campaign          = require('me_campaign')
local DB                = require('me_db_api')
local ListBoxItem       = require('ListBoxItem')
local FileDialog        = require('FileDialog')
local FileDialogFilters = require('FileDialogFilters')
local MeSettings      	= require('MeSettings')
local i18n              = require('i18n')
local crutches          = require('me_crutches')
local Skin              = require('Skin')
local Picture           = require('Picture')
local lfs				= require('lfs')
local select_role		= require('mul_select_role')
local create_server		= require('mul_create_server')
local server_list		= require('mul_server_list')
local textutil          = require('textutil')
local DialogLoader		= require('DialogLoader')
local Gui				= require("dxgui")
local Analytics			= require("Analytics")  
local ProductType 		= require('me_ProductType') 
local log      			= require('log')

i18n.setup(_M)

cdata = {
    Logbook = _('LOGBOOK'),
    leftBtn = _('CANCEL'),
    rightBtn = _('OK'),
    general = _("TOTAL"),
    
    aakills = _('A-A Kills'),
    agkills = _('A-G Kills'),
    awards = _('awards'),
    callsign = _('callsign'),
    campaigns = _('Campaigns'),
    commissioned = _('Commissioned'),
    daytime = _('Daytime'),
    deaths = _('Deaths'),
    delete = _('Delete'),
    ejections = _('Ejections'),
    flighthours = _('Flight Hours'),
    invulnerable = _('Invulnerable'),
    friendlyaakills = _('Friendly A-A Kills'),
    friendlyagkills = _('Friendly A-G Kills'),
    killratio = _('Kill Ratio'),
    landings = _('Landings'),
    missions = _('Missions'),
	companing_missions = _('Campaign Missions'),
    name = _('name'),
    naval = _('Naval'),
	refuels = _('Aerial Refuelings'),
    new = _('New'),
    nation = _('country'),
    nighttime = _('Nighttime'),
    rank = _('rank'),
    squadron = _('squadron'),
    static = _('Static'),
    status = _('Status'),
    totalscore = _('Total Score'),
    pilot_already_present = _('Pilot alredy present'),
    empty_name = _('Pilot name is empty'),
    last_pilot_deleting = _('Deleting the last remaining profile is not possible.\nCreate a new profile first.'),
    pilot_deleting = _('You are sure you want to delete player "%s"?\n Press "Yes" to confirm deletion'),
    pilot_absent = _('Pilot "%s" is absent'),
    yes = _('YES'),
    no = _('NO'),
    ok = _('OK'),
    error = _('ERROR'),
    warning = _('WARNING'),
    question = _('QUESTION'),
    new_pilot_name = _('New Pilot'),
    new_callsign  = _('New callsign'),
    new_pilot = _('New Pilot'),
    choosePilotPicture = _('Choose picture for pilot'),
    timeStr = _('%dh %dmin'),
    promotionGreeting = _('Congratulations! You have been promoted to "%s"!'),
    awardGreeting = _('Congratulations! You have been awarded "%s"!'),
    pilotDeadMessage = _('Our condolences but pilot "%s" is dead...'),
    lastPilotDeadMessage = _('Our condolences but pilot "%s" is dead...\
Pilot "%s" was the only pilot, so new pilot named "%s" created.'),
    message = _('MESSAGE'),
    changeCountryWarning  = _('You choosed to change your country.\
When changing country all your awards and rank will remain intact,\
but your combat score will be reset to zero.\
Press "Yes" to confirm changing country, press "No" to discard'),
    degradeMessage = _('You have committed fratricide. You have lost all your combat scores.'),
    messageDead = _("Your pilot is dead. Please create new pilot and save changes."),
    Units = _('Units'),
    AnotherInfo = _('Squadron Patch'),
    InfoProfile = _('Profile Info'),
    statistic = _('Statistics'), 
    cancel = _('Cancel'),
	
}
playerNames = {}
playerByName = {}
currentPlayer = {}
MIN_REFUEL_TIME = 20

local curType = "GENERAL"

ScoreLastMission = 0

local logbookPath = base.userDataDir..'logbook.lua'

local widgetRankPicSkin
local sUploadImgSkin
local widgetEmblemSkin


function setSkinPicture(skin, filename, x1, y1, x2, y2)
    local interactiveStates = skin.skinData.states
    
    for interactiveStateName, interactiveState in pairs(interactiveStates) do
        if interactiveStateName ~= 'hover' then
            for innerStateValue, innerState in pairs(interactiveState) do            
                local picture = innerState.picture
                
                if picture then
                    local rect = picture.rect
                    
                    picture.file = filename
                    
                    rect.x1 = x1 or 0
                    rect.y1 = y1 or 0
                    rect.x2 = x2 or 0
                    rect.y2 = y2 or 0
                end
            end
        end
    end
end

function loadOneOrAnother(a_path1, a_noShowError)
    local a, errA = lfs.attributes(a_path1)
    local result

    if (a and a.mode == 'file')  then
        result, err = loadfile(a_path1) 
		if result == nil then
			log.error('File read error "'..a_path1..'": '..(err or ""))
		end	
    elseif a_noShowError ~= true then
        print("ERROR: loadOneOrAnother: OpenFile(" .. a_path1.."): The system cannot find the path specified.")
    end

    return result
end

local function compareUnitsByName(left, right)
	return left.name < right.name
end

function fillUnitsList()	
    updateUnitsData()
    listUnits:clear()
	
    local listItem = ListBoxItem.new(_('General'))
    listItem.name = 'General'
    listItem.type = 'GENERAL'
    listItem:setSkin(listBoxUnitItemSkin)
    listUnits:insertItem(listItem)            

    table.sort(plData, compareUnitsByName)
    
    for k,v in base.pairs(plData) do
        local listItem = ListBoxItem.new(_(v.name))  
        listItem.type = v.type   
        listItem:setSkin(listBoxUnitItemSkin)
        listUnits:insertItem(listItem)
    end
end

function loadLogbookData()
    playerNames = {}
    playerByName = {}
    currentPlayer = {}

    -- Чтение данных в контекст модуля
    local f = loadOneOrAnother(logbookPath, true)
    
    if f then    
        local env = {}
        base.setfenv(f, env)
        f()
        logbook  = env.logbook
    else
        logbook = {}
        logbook.players = {}
        addNewPlayer(cdata.new_pilot_name)
        save()
    end
		
    --convert "aircrafts"
    for k,v in base.pairs(logbook.players) do
        for kk, vv in base.pairs(v.games) do   
            if vv.campaign then
                vv.campaign = string.gsub(vv.campaign, "/mods/aircrafts", "/mods/aircraft")
                vv.campaign = string.gsub(vv.campaign, '\\', '/')
            end
        end
    end  
    
    for i=1,#logbook.players do
        table.insert(playerNames, logbook.players[i].name)
        playerByName[logbook.players[i].name] = logbook.players[i]
        if not logbook.players[i].password then
            logbook.players[i].password = "d41d8cd98f00b204e9800998ecf8427e"
        end
  --[[       
        local n_ind,v =  base.next(logbook.players[i].games)
        while n_ind do
            if not isCampaignExist(v.campaign) then 
                print('removing nonexistent campaign entry', v.campaign)
                table.remove(logbook.players[i].games,n_ind)
                logbook.lastGame = 1
                n_ind = nil
            end
            n_ind,v =  base.next(logbook.players[i].games, n_ind)
        end
        ]]
    end
    
    table.sort(playerNames)

    currentPlayer.player = playerByName[logbook.currentPlayerName]
    currentPlayer.country = DB.country_by_id[currentPlayer.player.countryId]
	-- fix not valid list awards
	if currentPlayer.player and currentPlayer.player.awards then
		for countryID, countryAwards in pairs(currentPlayer.player.awards) do 	
			if countryAwards and #countryAwards == 0 then 
				local tmp = {}
				local country = DB.country_by_id[countryID]
				for i, awardName in pairs(countryAwards) do 
					for i, award in ipairs(country.Awards) do
						if award.nativeName == awardName or award.name == awardName then
							table.insert(tmp, award.name)
						end
					end         
				end
				currentPlayer.player.awards[countryID] = tmp
			end
		end	
	end
	--end fix
end

function fillComboNation()
	local tmpCountries = {}
	for i, country in ipairs(base.db.Countries) do
		tmpCountries[i] = country
	end
	
	function compareStrings(tbl1, tbl2)
		return (tbl1.Name or " ") < (tbl2.Name or " ")
	end
	
	table.sort(tmpCountries, compareStrings)
	
	for i, country in ipairs(tmpCountries) do
        -- rect для картинки
		local item = ListBoxItem.new(country.Name)
        setSkinPicture(listBoxItemFlagsSkin,country.flag or "FUI/Common/Flags/flag-Coalition1.png" , 0, 0, 64, 30)
      
        item:setSkin(listBoxItemFlagsSkin)
        item.countryId = country.WorldID
        comboNation:insertItem(item)
        
        if currentPlayer.player.countryId == country.WorldID then
            currentPlayer.country = country
            comboNation:setText(country.Name)
            onComboNationChange(comboNation, item)
        end
    end
end

function updateComboInvulnerable()
    if currentPlayer.player.invulnerable then
        comboInvulnerable:setText(cdata.yes)
    else
        comboInvulnerable:setText(cdata.no)    
    end
end

function fillComboInvulnerable()
    U.fill_combo_list(comboInvulnerable, {cdata.yes, cdata.no})
    updateComboInvulnerable()
end

local function create_()
    window = DialogLoader.spawnDialogFromFile('MissionEditor/modules/dialogs/LogbookDialog.dlg', cdata)

    containerMain = window.containerMain
    
    local width, height = Gui.GetWindowSize()
    window:setBounds(0,0,width, height)
    containerMain:setBounds((width-1280)/2, (height-768)/2, 1280, 768)
    
    U.copyContainerMainWidgetsIntoModule(containerMain, _M)
    U.copyContainerMainWidgetsIntoModule(middlePanel, _M)
    U.copyContainerMainWidgetsIntoModule(pUser, _M)
    U.copyContainerMainWidgetsIntoModule(pRight, _M)
    U.copyContainerMainWidgetsIntoModule(pStat, _M)
    U.copyContainerMainWidgetsIntoModule(containerLeftGrid, _M)
    U.copyContainerMainWidgetsIntoModule(containerRightGrid, _M)
    U.copyContainerMainWidgetsIntoModule(footerPanel, _M)
    U.copyContainerMainWidgetsIntoModule(headPanel, _M)
    U.copyContainerMainWidgetsIntoModule(window.pNoVisible, _M)
    
    widgetRankPicSkin = pUser.widgetRankPic:getSkin()
    sUploadImgSkin = pUser.sUploadImg:getSkin()
    widgetEmblemSkin = pRight.widgetEmblem:getSkin()
    invalidCaptionSkin = staticInvalidCaption:getSkin()
    valueSkin = staticValue:getSkin()
    invalidValueSkin = staticIvalidValue:getSkin()
    awardSkin = widgetEmblem:getSkin()
    captionSkin = staticCaption:getSkin()
    listBoxUnitItemSkin = listBoxUnitItem:getSkin()
    listBoxItemFlagsSkin = listBoxItemFlags:getSkin()
    
    comboPilot = pUser.comboPilot
    
    currentPlayer.player = playerByName[logbook.currentPlayerName]
    currentPlayer.country = DB.country_by_id[currentPlayer.player.countryId]
    updatePlayers()
    
    fillComboNation()
    fillComboInvulnerable()

	containerLeftGrid.widgetRefuelsVal:setVisible(true) 
	containerLeftGrid.widgetRefuels:setVisible(true)        
        
    fillUnitsList()
    listUnits.onChange = onChangeUnitsList
	
	setupCallbacks()
end

function onChangeUnitsList(self, item)
	curType = item.type
	updateWidgets()
end

function setupCallbacks()
    btnCancel.onChange = onButtonCancel -- обработчик кнопки Exit
    btnOk.onChange = onButtonOk -- обработчик кнопки Next
    btnClose.onChange = onButtonCancel
    buttonDelete.onChange = onButtonDelete
    buttonNew.onChange = onButtonNew
    comboPilot.onChange = onComboPilotChange
    comboSquadron.onChange = onComboSquadronChange
    comboNation.onChange = onComboNationChange
    editCallsign.onFocus = onEditCallsignChange
    comboInvulnerable.onChange = onComboInvulnerableChange    
    buttonPilotPic.onChange = onButtonPilotPicChange
	
    window:addHotKeyCallback('escape', onButtonCancel)      
    window:addHotKeyCallback('return', onButtonOk)        
end

function checkNewPlayerName(name)
    if name == "" then -- имя пустое
        return false
    end
    
    if playerByName[name] then -- такое имя уже есть
        return false
    end

    return true
end

-- добавление нового игрока
-- name - имя игрока
-- md5_password - мд5 пароль
function addNewPlayer(name, md5_password)
    -- если пароль не задан, то присваиваем мд5 пустого пароля
    md5_password = md5_password or "d41d8cd98f00b204e9800998ecf8427e"
    local dbCountries = base.db.Countries
    local player = {
        name = name,
        password = md5_password,
        games = {},
        countryId = dbCountries[3].WorldID,
        squadron = dbCountries[3].Troops[1].nativeName,
        password = "d41d8cd98f00b204e9800998ecf8427e",
        picture = "",
        lastGame = 1,
        callsign = cdata.new_callsign,
        rank = dbCountries[1].Ranks[1].nativeName,
        rankName = dbCountries[1].Ranks[1].name,
        invulnerable = true,
        statistics = {
                agKills = 0,
                killRatio = "0/0",
                missionsCount = 0,
                ejections = 0,
                totalScore = 0,
                flightHours = 0,
                daytime = 0,
                commissioned = base.os.date('%x'),
                campaignsCount = 0,
                static = 0,
                faaKills = 0,
                landings = 0,
                fagKills = 0,
                nighttime = 0,
                aaKills = 0,
                naval = 0,
                deaths = 0,
                refuelings = 0,
            }, -- end of statistics
        awards = {},
    }
	
	local locale = i18n.getLocale()
	if locale == 'ru' or ProductType.getType() == "LOFAC" then
		player.countryId = dbCountries[1].WorldID
        player.squadron = dbCountries[1].Troops[1].nativeName
	end
		
    table.insert(logbook.players, player)
    playerByName[name] = player
    table.insert(playerNames, name)
    table.sort(playerNames)
    logbook.currentPlayerName = name
    currentPlayer.player = player
    currentPlayer.country = dbCountries[1]
end

function showError(text)
    MsgWindow.error(text, cdata.error, cdata.ok):show()
end

function showInfo(text)
    MsgWindow.info(text, cdata.message, cdata.ok):show()
end


-- name - имя игрока
-- md5_password - мд5 пароль
-- возвращает truе в случае успеха и false в случае сбоя
-- в случае сбоя дополнительно выводит сообщение об ошибке
function deletePlayer(name, md5_password, noConfirmation)
    function doDelete()
        playerByName[name] = nil
        for i=1,#logbook.players do
            if logbook.players[i].name == name then
                table.remove(logbook.players, i)
                break
            end
        end
        
        playerNames = {}
        for i=1,#logbook.players do
            table.insert(playerNames, logbook.players[i].name)
        end
        table.sort(playerNames)
        -- Назначить другого умалчиваемого игрока, если он удален.
        logbook.currentPlayerName = playerNames[1]
    end 
    if noConfirmation == true then 
        doDelete()
        return
    end
    -- если пароль не задан, то присваиваем мд5 пустого пароля
    md5_password = md5_password or "d41d8cd98f00b204e9800998ecf8427e"
    -- Удалить учетную запись.
    if playerByName[name] == nil then
        showError(cdata.pilot_absent .. name ..')')

        return false
    end
    
    if playerByName[name].password ~= md5_password then
        showError(cdata.invalid_password)

        return false
    end
    
    
    if  #playerNames < 2 then  -- игрок всего один, сообщаем об ошибке
        showError(cdata.last_pilot_deleting)
        
        return false
    end
    
    local msgStr = string.format(cdata.pilot_deleting, name)
    local handler = MsgWindow.question(msgStr, cdata.question, cdata.yes, cdata.no)
	local success = false
	
    function handler:onChange(buttonText) 
		success = buttonText == cdata.yes
    end
    
    handler:show()
	
	-- сюда управление попадет после того, 
	-- как окно сообщения будет закрыто
	
	if success then
		doDelete()
		update()
	end
    
    return true
end

function disablePlayer(name)
    function doDisable()
        --playerByName[name] = nil
        for i=1,#logbook.players do
            if logbook.players[i].name == name then
                logbook.players[i].dead = true
                break
            end
        end        
        local alivePilot
        for i=1,#logbook.players do
            if logbook.players[i].dead == nil then
                alivePilot = logbook.players[i]
                break
            end
        end        
        if alivePilot == nil then
            logbook.currentPlayerName = nil
        else
            logbook.currentPlayerName = alivePilot.name
        end
        
    end 
    doDisable()
end

function show(b, a_returnScreen)
    if b then
		returnScreen = a_returnScreen
        if not window then    
            create_()
        end  
		Analytics.pageview(Analytics.LogBook)
        oldCountry = currentPlayer.country
        oldSquadron = currentPlayer.player.squadron
        loadLogbookData()
        update()
    end
	
    if window then
        window:setVisible(b)
    end
end

function save()
    local f, err = base.io.open(logbookPath, 'w')
    if f then
        local s = S.new(f)
        s:serialize_simple2('logbook', logbook)
        f:close()
	else
		log.error('ERROR: save logbook failed: '..err)	
    end
end

function getCurrentGame()
    local player = playerByName[logbook.currentPlayerName]
    local game = player.games[player.lastGame]
    if not game then
        return nil
    end

    if isCampaignExist(game.campaign) then 
        return game
    else
        return nil
    end
end

function getGame(campaign)
    if (campaign) then
        local player = playerByName[logbook.currentPlayerName]
        for i = 1, #player.games do
            local game = player.games[i]
            if textutil.Utf8ToLowerCase(game.campaign) == textutil.Utf8ToLowerCase(campaign.path) then
                return game
            end
        end
    end
    return nil    
end

function setCurrentGame(campaign)
    local player = playerByName[logbook.currentPlayerName]
    for i = 1, #player.games do        
        local game = player.games[i]
        if textutil.Utf8ToLowerCase(game.campaign) == textutil.Utf8ToLowerCase(campaign.path) then
            player.lastGame = i
            return
        end
    end
end

function onButtonCancel()
	show(false)
	
	if returnScreen == 'editor' then
		base.MapWindow.show(true)
	else
		base.mmw.show(true)
	end
end

function onButtonOk()
    if (oldCountry ~= currentPlayer.country) 
        and (currentPlayer.player.statistics.totalScore ~= 0) then
        local str = string.format(cdata.changeCountryWarning, currentPlayer.country.name)
        local handler = MsgWindow.warning(str, cdata.message, cdata.yes,  cdata.no)
        
        function handler:onChange(buttonText)
            if buttonText == cdata.yes then            
                currentPlayer.player.statistics.totalScore = 0
                save()
				show(false)
				
				if returnScreen == 'editor' then
					base.MapWindow.show(true)
				else
					base.mmw.show(true)
				end
            else
                currentPlayer.country = oldCountry
                currentPlayer.player.countryId = oldCountry.WorldID
                update()
            end
        end
        
        handler:show()
    else
        save()		
        show(false)
		if returnScreen == 'editor' then
			base.MapWindow.show(true)
		else
			base.mmw.show(true)
		end
    end
end

function onButtonDelete()
    deletePlayer(logbook.currentPlayerName)
end

function updateDeathValue()
    local widgetDeathsSkin
    local widgetDeathsValSkin
    
    if currentPlayer.player.dead then   
        MsgWindow.warning(cdata.messageDead, cdata.warning, cdata.ok):show()
        btnOk:setEnabled(false)
        comboInvulnerable:setEnabled(false)
        widgetDeathsSkin = invalidCaptionSkin
        widgetDeathsValSkin = invalidValueSkin    
    else
        btnOk:setEnabled(true)
        widgetDeathsSkin = captionSkin
        widgetDeathsValSkin = valueSkin 
        comboInvulnerable:setEnabled(true)
    end
    
    widgetDeaths:setSkin(widgetDeathsSkin)    
    widgetDeathsVal:setSkin(widgetDeathsValSkin)
end

function update()
    currentPlayer.player = playerByName[logbook.currentPlayerName]
    currentPlayer.country = DB.country_by_id[currentPlayer.player.countryId]

    updatePlayers()
    
    comboPilot:setText(logbook.currentPlayerName)
    editCallsign:setText(currentPlayer.player.callsign)
    
    updateComboNation()
    updateSquadron()
    updateRank()
    updatePlayerPicture()   
    updateWidgets()
    updateAwards()
    updateDeathValue()
end

function getAwards()
	local result = {}
  
	for countryID, countryAwards in pairs(currentPlayer.player.awards) do 
		for i, awardName in ipairs(countryAwards) do 
			local country = DB.country_by_id[countryID]
          
			for i, award in ipairs(country.Awards) do
				if award.nativeName == awardName or award.name == awardName then
					table.insert(result, award)
				end
			end         
		end
	end
  
	return result
end

function updateAwards()
    scrollpaneMedals:clear()
    
    local awards = getAwards()
    local cx, cy, cw, ch = scrollpaneMedals:getClientRect()
    local pictureWidth = 64
    local pictureHeight = 128
    local columnCount = math.floor(cw / pictureWidth)
    
    for i, award in ipairs(awards) do
        local column = ((i - 1) % columnCount)
        local row = math.floor((i - 1) / columnCount)
        local x = column * pictureWidth
        local y = row * pictureHeight
        local picture = Static.new()        
        
        picture:setBounds(x, y, pictureWidth, pictureHeight)
        
        local filename = 'MissionEditor/data/images/countries/' .. award.picture
        
        setSkinPicture(awardSkin, filename)
        
        picture:setSkin(awardSkin)
        picture:setTooltipText(award.nativeName)
        
        scrollpaneMedals:insertWidget(picture)
    end
end

function updateComboNation()
    comboNation:setText(currentPlayer.country.Name)
end

function updateRank()
    widgetRankText:setText(currentPlayer.country.rank_by_name[currentPlayer.player.rankName].nativeName)
    
    local rank = currentPlayer.country.rank_by_name[currentPlayer.player.rankName]
    
    if rank then
        local filename = 'MissionEditor/data/images/countries/' .. rank.stripes
        local rankPictureRect = rank.pictureRect
        local x1 = rankPictureRect[1]
        local y1 = rankPictureRect[2]
        local x2 = rankPictureRect[1] + rankPictureRect[3]
        local y2 = rankPictureRect[2] + rankPictureRect[4]        
        
        setSkinPicture(widgetRankPicSkin, filename, x1, y1, x2, y2)
        
        widgetRankPic:setSkin(widgetRankPicSkin)
    end
end

function updateSquadron()
    local t = {}
    local squadronPicture
    local troops = currentPlayer.country.Troops
    
    for i, troop in ipairs(troops) do
        table.insert(t, troop.nativeName)
        if currentPlayer.player.squadron == troop.nativeName then
            squadronPicture = troop.picture
        end
    end
    U.fill_combo_list(comboSquadron, t)
    comboSquadron:setText(currentPlayer.player.squadron)

    local filename
    
    if squadronPicture then 
        filename = 'MissionEditor/data/images/countries/' .. squadronPicture
    end
   
    setSkinPicture(widgetEmblemSkin, filename)
    widgetEmblem:setSkin(widgetEmblemSkin)
end

function updatePlayerPicture()
    if currentPlayer.player.picture and (currentPlayer.player.picture ~= '') then
        setPilotTheme(currentPlayer.player.picture)        
    else
        setPilotTheme('pilot-1.png')
    end
end

function createTimeStr(flightTime, translate)
    local hours, mins = math.modf(flightTime/3600)
    local minutes = math.floor(flightTime/60 - hours*60)
    local second = math.floor(flightTime - hours*3600 - minutes*60)
    if second >= 30 then
        minutes = minutes + 1 
    end    
    local flightTimeStr = ''
    if translate then
        flightTimeStr = string.format(cdata.timeStr, hours, minutes)
    else
        local timeStr = '%dh %dmin'
        flightTimeStr = string.format(timeStr, hours, minutes)
    end
    return flightTimeStr, hours*3600+minutes*60
end 

function isUserEvent(a_event, a_playerUnitId) 
    return ((a_playerUnitId ~= nil and
                ((a_event.initiatorMissionID == a_playerUnitId) 
                or (a_event.targetMissionID == a_playerUnitId)))
			or (a_event.type == 'took control') 
			or (a_event.type == 'mission start') 
            or (a_event.type == 'relinquished')
            or (a_event.type == 'under control')
			or (a_event.type == 'mission end') )
			or ((a_event.type == 'kill') and (a_event.initiatorMissionID == a_playerUnitId))
			
end

function filterUserEvents(userName, debriefing)
    local t = {}
    t.result = debriefing.result
    t.events = {}

    for i, debriefingEvent in ipairs(debriefing.events) do
		if ((debriefingEvent.initiator == userName) 
			or (debriefingEvent.target == userName) 
			or (debriefingEvent.type == 'took control') 
			or (debriefingEvent.type == 'mission start') 
			or (debriefingEvent.type == 'relinquished') 
			or (debriefingEvent.type == 'under control') 
			or (debriefingEvent.type == 'mission end') )then
				table.insert(t.events, debriefingEvent)
		end

        if debriefingEvent.type == 'mission start' then 
            t.start = debriefingEvent.t
        elseif debriefingEvent.type == 'mission end' then
            t.finish = debriefingEvent.t
        end
    end
    
    return t
end

local function getInfoUnit(a_playerTable, a_unitId)
   -- base.print("---getInfoUnit=",a_unitId)
  --  base.U.traverseTable(MissionModule.unit_by_id,2)
    local unit = MissionModule.unit_by_id[a_unitId]
   -- base.print("---unit=",MissionModule.unit_by_id[1])
    a_playerTable.group = unit.boss
    a_playerTable.country = a_playerTable.group.boss
    a_playerTable.coalition = a_playerTable.country.boss
    a_playerTable.countryName = a_playerTable.country.name
    a_playerTable.playerUnitName = unit.name
    a_playerTable.playerUnitType = base.me_db.getNameByDisplayName(unit.type)
    a_playerTable.playerUnit = unit
    a_playerTable.playerUnitId = unit.unitId
end

local function getInfoPlayer(a_playerTable)
  --  a_playerTable.playerName = logbook.currentPlayerName
    local mission = MissionModule.mission
    for k,v in pairs(MissionModule.unit_by_name) do
        local unit = v
        if unit.skill == crutches.getPlayerSkill() then
            getInfoUnit(a_playerTable, unit.unitId)
            break
        end
    end    
    
end

function fillAirStart(a_AirStart_by_Id)
    for _tmp, v in pairs(MissionModule.unit_by_id) do
        if v.boss and (v.boss.type == "helicopter" or v.boss.type == "plane") then
            a_AirStart_by_Id[v.unitId] = ("takeoff" ~= base.panel_route.getWptType(v.boss.route.points[1].type))           
        end
    end
end

function updateUserStatistics(a_debriefing)
    local debriefing = {}
    base.U.recursiveCopyTable(debriefing, a_debriefing)
    local pilotDead = false
	local fag,faa, killedUnitsCounter = 0,0,0 
    local missionScore = 0   
	local start_time = 0 
    currentPlayer = currentPlayer or {}
    
    currentPlayer.player = playerByName[logbook.currentPlayerName]
	
    local country = DB.country_by_id[currentPlayer.player.countryId]
    currentPlayer.country = country
    
    local statistics = {}
    
    local playerTable = {}
    getInfoPlayer(playerTable)
    local firstPlayer = false

    if playerTable.playerUnit == nil then
       -- updateCampResult(debriefing, 0, 0, 0)
       -- updateCampMissCount()        
       -- save()
       -- return false
        firstPlayer = false
    else
        firstPlayer = true    
    end 
 
    local userDebriefing = {}
    
    local isTrack = MissionModule.isTrack(base.START_PARAMS.missionPath)
	local bIntro  = MissionModule.checkMissionIntroduction(base.START_PARAMS.missionPath)
    local tabFlightHours = {}
    
    local startTime = 0
    local endTime = 0
    
    local AirStart_by_Id = {}
    fillAirStart(AirStart_by_Id)
    
    if debriefing.events[1] then
        startTime, endTime = debriefing.events[1].t,-1
    end
    local controlTaken = false
    local takeoff_landTime = 0
    local dayTime, nightTime = 0, 0
    local inAir = AirStart_by_Id[playerTable.playerUnitId]
    local timeLastTakeoff = -1
    local timeLastLand = -1
    
    if (not isTrack) and debriefing.events[1] then
        startTime = debriefing.events[1].t
        if (inAir) then
            timeLastTakeoff = debriefing.events[1].t
        end
    end

    local landingsCount = 0
    local ejectionsCount = 0
    local deathsCount = 0
    local lostLA = 0
    local refuelings = 0
    
    local flightHours = 0
    local dayTime = 0
    local nightTime = 0
    
    local refuelStartTime
            
    local statType={}
    local function getStatTabl(a_unitType)
        if (a_unitType) then
            statType[a_unitType] = statType[a_unitType] or {}
            stat 				= statType[a_unitType]
			stat.landingsCount  = (stat.landingsCount or 0)
            stat.ejectionsCount = (stat.ejectionsCount or 0) 
            stat.deathsCount    = (stat.deathsCount or 0)
            stat.lostLA         = (stat.lostLA or 0)
            stat.refuelings     = (stat.refuelings or 0)
            
            stat.flightHours    = (stat.flightHours or 0)
            stat.dayTime        = (stat.dayTime or 0)
            stat.nightTime      = (stat.nightTime or 0)
            
            stat.aa         = (stat.aa or 0)
            stat.ag         = (stat.ag or 0)
            stat.naval      = (stat.naval or 0)
            stat.static     = (stat.static or 0)
            stat.totalScore = (stat.totalScore or 0)
			stat.deaths 	= (stat.deaths or 0)
			stat.agKills 	= (stat.agKills or 0)
			stat.static     = (stat.static or 0)
			stat.naval 		= (stat.naval or 0)
			stat.aaKills 	= (stat.aaKills or 0)  
        end
		return stat
    end    

    local startTimeInterval = 0
    local endTimeInterval = 0

    local curStat = getStatTabl(playerTable.playerUnitType)

	-- не статистика, но надо очистить
	refuelStartTime = 0
	takeoff_landTime = 0
    
    for i =1,#debriefing.events do
        local event = debriefing.events[i]
        if event.targetMissionID then
            event.targetMissionID = tonumber(event.targetMissionID)
        end
        if event.initiatorMissionID then
            event.initiatorMissionID = tonumber(event.initiatorMissionID)
        end
		
		event.t = event.t + start_time
		
        if event.type == 'mission start' then 
            userDebriefing.start = event.t
            startTimeInterval = event.t 
			start_time = event.ta or 0	
        elseif event.type == 'mission end' then
            userDebriefing.finish = event.t
        end
        
        if event.type == 'takeoff' then
            AirStart_by_Id[event.initiatorMissionID] = true
        end
        
        if event.type == 'land' then
            AirStart_by_Id[event.initiatorMissionID] = false
        end        
            
        if (isUserEvent(event,playerTable.playerUnitId)) then			
			if event.type == 'takeoff' then
				inAir = true
			end
			
			if event.type == 'land' then
				inAir = false
			end 
		
            if isTrack and controlTaken == false then                         
                if event.type == 'took control' then                    
                    controlTaken = true
                    startTimeInterval = event.t
                    if playerTable.playerUnitId then
                        startTime = event.t
                        if (inAir) then
                            timeLastTakeoff = event.t
                        end
                    end    
                end           
            end    
            
            if (not isTrack) or controlTaken then
                if event.type == 'takeoff' then
                    timeLastTakeoff = event.t
                end
                
				if (event.type == 'under control') then
					playerTable = {}
                    getInfoUnit(playerTable, event.targetMissionID)
                    curStat = getStatTabl(playerTable.playerUnitType)
					landingsCount = 0
					ejectionsCount = 0
					deathsCount = 0
					lostLA = 0
					refuelings = 0
					
					flightHours = 0
					dayTime = 0
					nightTime = 0
					
					-- не статистика, но надо очистить
					refuelStartTime = 0
					takeoff_landTime = 0
					
                    inAir = AirStart_by_Id[event.targetMissionID]
                    timeLastTakeoff = event.t
                    timeLastLand = event.t
                    
                    startTimeInterval = event.t
                end
				
                if event.type == 'relinquished' then 
                    -- добавляем время полета между последним взлетом и покиданием самолета(посадки небыло)
                    endTime = event.t
                    if (timeLastTakeoff >= 0) then      
                        takeoff_landTime = takeoff_landTime + endTime - timeLastTakeoff
                        local dt, nt = getDayNightFlightTime(timeLastTakeoff, endTime)
                        dayTime = dayTime + dt
                        nightTime = nightTime + nt  
                    end
                    
                    flightHours = takeoff_landTime                    
                    inAir = false 
                    
                    endTimeInterval = event.t
                          
                    -- записываем статистику в statType 
					curStat.landingsCount  = (curStat.landingsCount or 0) + landingsCount
					curStat.ejectionsCount = (curStat.ejectionsCount or 0) + ejectionsCount
					curStat.deathsCount    = (curStat.deathsCount or 0) + deathsCount
					curStat.lostLA         = (curStat.lostLA or 0) + lostLA
					curStat.refuelings     = (curStat.refuelings or 0) + refuelings				
					curStat.flightHours    = (curStat.flightHours or 0) + flightHours
					curStat.dayTime        = (curStat.dayTime or 0) + dayTime
					curStat.nightTime      = (curStat.nightTime or 0) + nightTime  
			
					playerTable = {}
                    
                    startTimeInterval =  0
                    endTimeInterval = 0
                end  
				      
				-- только убийства игроком
                if (event.type == 'kill' and event.initiatorMissionID ~= nil and playerTable.playerUnitId == event.initiatorMissionID) then				
					if event.initiatorMissionID ~= event.targetMissionID and event.targetMissionID ~= nil then  
						local unitTarget  = MissionModule.unit_by_id[event.targetMissionID]
						local coal = playerTable.coalition
						if unitTarget then
							local country_idTarget = unitTarget.boss.boss.id
							local victim = unitTarget
							local victimType = victim.boss.type
												
							if isInsideCoalition(coal, country_idTarget) then --попали по своим
								if (victimType == "helicopter") or (victimType == "plane") then 
									faa = faa + 1
								elseif victimType == "vehicle" or victimType == "static" then
									fag = fag + 1
								end
							else
								local dbUnit 
								if victim.type == 'Train' then
									dbUnit = DB.unit_by_type[event.target]
								else
									dbUnit = DB.unit_by_type[victim.type]
								end
								if (victimType == "helicopter") or (victimType == "plane") then 
									curStat.aa     = (curStat.aa or 0) + 1
								elseif victimType == "vehicle" then
									curStat.ag     = (curStat.ag or 0) + 1
								elseif victimType == "ship" then
									curStat.naval  = (curStat.naval or 0) + 1
								elseif victimType == "static" then 
									curStat.static = (curStat.static or 0) + 1
								end
								curStat.totalScore = curStat.totalScore + (dbUnit.Rate or 0)								
								missionScore = missionScore  + (dbUnit.Rate or 0)	
								killedUnitsCounter = killedUnitsCounter + 1
							end    					
						end
                    end				
				end
				
                if (event.type == 'land') then
                    timeLastLand = event.t
                    landingsCount = landingsCount + 1
					endTime = event.t
                    if (timeLastLand >= timeLastTakeoff) and (timeLastLand >= 0) and (timeLastTakeoff >= 0) then
                        local t = timeLastLand - timeLastTakeoff
                        takeoff_landTime = takeoff_landTime + t
						
						
                        local dt, nt = getDayNightFlightTime(timeLastTakeoff, timeLastLand)					
                        dayTime = dayTime + dt
                        nightTime = nightTime + nt
                        timeLastTakeoff = -1
                        timeLastLand = -1
                    else 
                        print('error calculating time when landing',timeLastLand,timeLastTakeoff)

                        timeLastTakeoff = -1
                        timeLastLand = -1
                    end            
                end
                
                if event.type == 'eject' then
                    ejectionsCount = ejectionsCount + 1
                    if lostLA == 0 then
                        lostLA = lostLA + 1
                    end
                    endTime = event.t
                    inAir = false
                elseif (event.type == 'dead') or (event.type == 'crash') then
                    if lostLA == 0 then
                        lostLA = lostLA + 1
                    end
                    endTime = event.t
                    inAir = false
                elseif (event.type == 'pilot dead') then                   
                    if lostLA == 0 then
                        lostLA = lostLA + 1
                    end
                    deathsCount = deathsCount + 1
                elseif (event.type == 'refuel') then
                    refuelStartTime = event.t
                elseif (event.type == 'refuel stop') then
                    local refuelTime = event.t - (refuelStartTime or event.t)
                    if refuelTime > MIN_REFUEL_TIME then
                        refuelings = refuelings + 1
                    end
                    refuelStartTime = nil
                end
            end       
        end    
    end
    
    if (inAir) and (#debriefing.events > 0) then
        endTime = debriefing.events[#debriefing.events].t
    end
    
    -- добавляем время полета между последним взлетом и окончанием миссии (посадки небыло)
    if (endTime > 0) and (timeLastTakeoff >= 0) then        
        takeoff_landTime = takeoff_landTime + endTime - timeLastTakeoff
        local dt, nt = getDayNightFlightTime(timeLastTakeoff, endTime)
        dayTime = dayTime + dt
        nightTime = nightTime + nt  
    end
    
    flightHours = takeoff_landTime
    
    if (playerTable) and curStat then
		
        if endTime > 0 and ((startTime + 0.001) < endTime) then
            endTimeInterval = endTime
        else
            endTimeInterval = debriefing.events[#debriefing.events].t
        end   

		curStat.landingsCount  = (curStat.landingsCount or 0) + landingsCount
		curStat.ejectionsCount = (curStat.ejectionsCount or 0) + ejectionsCount
		curStat.deathsCount    = (curStat.deathsCount or 0) + deathsCount
		curStat.lostLA         = (curStat.lostLA or 0) + lostLA
		curStat.refuelings     = (curStat.refuelings or 0) + refuelings				
		curStat.flightHours    = (curStat.flightHours or 0) + flightHours
		curStat.dayTime        = (curStat.dayTime or 0) + dayTime
		curStat.nightTime      = (curStat.nightTime or 0) + nightTime  
    end
    
  --  base.U.traverseTable(statType)
    
    local fullFlightHours = 0
    for k,v in pairs(statType) do
        fullFlightHours = fullFlightHours + v.flightHours
    end
    	
    if ((fullFlightHours < 1) and isTrack and (not bIntro))
		or 
		(base.panel_debriefing.returnScreen == 'campaign' and isTrack and (not bIntro)) then
		return false
    end

    local hours = (fullFlightHours + currentPlayer.player.statistics.flightHours)/3600
    local ranks = currentPlayer.country.Ranks
    
    local r = ranks[1] or {}
    for i = 2, #ranks do 
        if (hours > ranks[i].threshold) then
            r = ranks[i]
        end
    end
    
    if (currentPlayer.player.rankName == nil) then
        currentPlayer.player.rankName = r.name
    end
    
    if (ProductType.getType() ~= "LOFAC") and (r.name ~= currentPlayer.player.rankName) then
        currentPlayer.player.rank = r.nativeName
        currentPlayer.player.rankName = r.name
        displayPromotionGreeting(r.nativeName)
    end
    
    if (userDebriefing.start == userDebriefing.finish) and (userDebriefing.start ~= nil) then
        debriefing.result = 50
    end
    

    local stat = currentPlayer.player.statistics
    
    if (faa > 0) or (fag > 0) then
        missionScore = 0
        for k, v in pairs(statType) do
            v.totalScore = 0
        end
		-- обнуляем счет у всех самолетов
		for k,v in base.pairs(stat) do
			if base.type(v) == "table" then
				if (v.totalScore) then
					v.totalScore = 0
				end
			end
		end
	
        displayDegradeWindow()
    end

--	updateStatistic(stat, debriefing) -- тут должна собираться вся статистика с миссии
	
	ScoreLastMission = missionScore
    
    local CampAG = 0
    local CampAA = 0
    local CampDeathsCount = 0
    local numLostLA = 0
	
	for typeLA, v in pairs(statType) do
		if ((availableType ~= nil) and (availableType[typeLA] ~= nil)) then
			stat[typeLA]                = stat[typeLA] or {}
			stat[typeLA].ejections 		= (stat[typeLA].ejections or 0) + v.ejectionsCount
			stat[typeLA].flightHours 	= (stat[typeLA].flightHours or 0) + v.flightHours
			stat[typeLA].daytime 		= (stat[typeLA].daytime or 0) + v.dayTime
			stat[typeLA].nighttime 		= (stat[typeLA].nighttime or 0) + v.nightTime
			stat[typeLA].landings 		= (stat[typeLA].landings or 0) + v.landingsCount
			stat[typeLA].refuelings 	= (stat[typeLA].refuelings or 0) + v.refuelings
			
			stat[typeLA].totalScore 	= (stat[typeLA].totalScore or 0) + v.totalScore
			stat[typeLA].deaths 		= (stat[typeLA].deaths or 0) + v.deathsCount
			stat[typeLA].agKills 		= (stat[typeLA].agKills or 0) + v.ag
			stat[typeLA].static 		= (stat[typeLA].static or 0) + v.static
			stat[typeLA].naval 			= (stat[typeLA].naval or 0) + v.naval
			stat[typeLA].aaKills 		= (stat[typeLA].aaKills or 0) + v.aa
		end 
        
        stat.ejections = stat.ejections + v.ejectionsCount
        stat.flightHours = stat.flightHours + v.flightHours
        stat.daytime = stat.daytime + v.dayTime
        stat.nighttime = stat.nighttime + v.nightTime
        stat.landings = stat.landings + v.landingsCount
        stat.refuelings = (stat.refuelings or 0) + v.refuelings
        
        stat.totalScore = stat.totalScore + v.totalScore
        stat.deaths = stat.deaths + v.deathsCount
        stat.agKills = stat.agKills + v.ag
        stat.static = stat.static + v.static
        stat.naval = stat.naval + v.naval
        stat.aaKills = stat.aaKills + v.aa
        
        numLostLA = numLostLA + v.lostLA
        
        CampAG = CampAG + v.ag
        CampAA = CampAA + v.aa
        CampDeathsCount = CampDeathsCount + v.deathsCount
	end

    stat.fagKills = stat.fagKills + fag
    stat.faaKills = stat.faaKills + faa
    
    local victoriesStr = string.sub(string.match(stat.killRatio,'.*/'),1, -2)
    local lossesStr = string.sub(string.match(stat.killRatio,'/.*'),2)
    local victories = base.tonumber(victoriesStr) + killedUnitsCounter
    local losses = base.tonumber(lossesStr) + numLostLA
    stat.killRatio = tostring(victories) .. '/' .. tostring(losses)
 
    missionScore = stat.totalScore
    print("--missionScore---=",missionScore)
    local awards = currentPlayer.country.Awards
    local countryID = currentPlayer.country.WorldID
    currentPlayer.player.awards[countryID] = currentPlayer.player.awards[countryID] or {}
    local award = awards[1]
    local awardIndex = 0
    for i = 2, #awards+1 do 
        if (missionScore > awards[i-1].threshold) and (currentPlayer.player.awards[countryID][i-1] == nil) then
            award = awards[i-1]
            awardIndex = i-1
            break
        end
    end
    if (ProductType.getType() ~= "LOFAC") and (awardIndex > 0) then
        if currentPlayer.player.awards[countryID][awardIndex] == nil then
            currentPlayer.player.awards[countryID][awardIndex] = award.name
            displayAwardGreeting(award)
        end
    end    
        
    updateCampResult(debriefing, CampAG, CampAA, CampDeathsCount)
    updateCampMissCount()
    
    if CampDeathsCount > 0 and (currentPlayer.player.invulnerable ~= true) then
        local deadPilotName = currentPlayer.player.name;
        disablePlayer(currentPlayer.player.name, nil, true);       
        if logbook.currentPlayerName == nil then        
            createNewPlayer()
        end
    end
    
    save()
end

function skipMission(a_game, a_camp)
	if a_game ~= nil and a_camp ~= nil then
		a_game.status = Campaign.cdata.run_on

		local gameResults = a_game.history[#a_game.history]
		gameResults.result = 100
		gameResults.datetime = base.os.date()
		gameResults.agKills = 0 
		gameResults.aaKills = 0
		gameResults.deathsCount = 0
		gameResults.skipped = true
		
		for i = 1,#a_camp.stages do 
			if i == gameResults.stage then 
				for k,tbl_mis in base.pairs(a_camp.stages[i].missions) do
					if tbl_mis.file == gameResults.mission then
						base.print("--gameResults--",gameResults.mission, tbl_mis.skipScore)
						gameResults.result = tbl_mis.skipScore or 100
					end				
				end
			end
		end	
		
		Campaign.chooseNextMission(a_game, a_camp)
		save()	
	end 
end

-------------------------------------------------------------------------------
--
function updateStatistic()

end

function updateCampResult(debriefing, ag, aa, deathsCount)
    if base.panel_debriefing.returnScreen == 'campaign' then    
        local game = getCurrentGame()
		local dataStart = Campaign:getDataStart()
        if game ~= nil and dataStart and dataStart.doNotCount ~= true  then
            game.status = Campaign.cdata.run_on

			if dataStart and dataStart.index then
				-- обрезаем миссию по index
				if (dataStart.index+1) <= #game.history then
					for i = dataStart.index+1, #game.history do
						game.history[i] = nil						
					end
				end
			end
			Campaign:clearDataStart()

            local gameResults = game.history[#game.history]
            gameResults.result = debriefing.result
            gameResults.datetime = base.os.date()
            gameResults.agKills = ag  
            gameResults.aaKills = aa
            gameResults.deathsCount = deathsCount
			gameResults.skipped = nil
        end    
    end
end

function updateCampMissCount()
    local stat = currentPlayer.player.statistics
    
    local completedCampaignsCount = 0
    local completedMissionsCount = 0
    for i = 1,#playerByName[logbook.currentPlayerName].games do
        local game = playerByName[logbook.currentPlayerName].games[i]
        if (game.status == Campaign.cdata.win) or (game.status == Campaign.cdata.defeat) then
            completedCampaignsCount = completedCampaignsCount + 1
        end
        for j = 1,#game.history do
            -- есть результат, он больше или равен 50, миссия была снята с паузы (время старта не равно времени конца)
            if game.history[j].result 
                and (game.history[j].result >= 50) 
				and game.history[j].skipped ~= true then
                completedMissionsCount = completedMissionsCount + 1
            end
        end        
    end
    
    stat.missionsCount = completedMissionsCount
    stat.campaignsCount = completedCampaignsCount
end

function getScoreLastMission()
	return ScoreLastMission
end

function getFlightHoursLastMission()
	return flightHours
end

function isCampaignExist(path)
    local file = base.io.open(path, 'rb')
    if file then
        file:close()
        return true
    else
        return false
    end
end

function onComboPilotChange(self, item)
    if item then -- выбрали из списка
        local name = item:getText()
        currentPlayer.player = playerByName[name]
        currentPlayer.country = DB.country_by_id[playerByName[name].countryId]
        logbook.currentPlayerName = name    
        oldCountry = currentPlayer.country
        update()
    else --  ввели новое имя
        local name = comboPilot:getText()
        if playerByName[name] == nil then -- такого имени нет
            currentPlayer.player.name = name
            logbook.currentPlayerName = name
            local oldName = ''
            for player_name,player_val in pairs(playerByName) do
                if player_val == currentPlayer.player then
                    oldName = player_name
                    playerByName[player_name] = nil -- убиваем старое имя
                    for player_name_ind ,player_name_ in pairs(playerNames) do
                        if player_name_ == player_name then
                            table.remove(playerNames, player_name_ind) -- убиваем старое имя
                            break
                        end
                    end
                end
            end        
            playerByName[name] = currentPlayer.player
            table.insert(playerNames, name)
            table.sort(playerNames)
			
            local itemCounter = self:getItemCount() - 1
			
            for i = 0, itemCounter do
				local item = self:getItem(i)
				
                if item:getText() == oldName then
                    item:setText(name)
                    break
                end
            end
        end
    end    
end

function onComboNationChange(self, item)
    currentPlayer.player.countryId = item.countryId
    currentPlayer.country = DB.country_by_id[currentPlayer.player.countryId]
    if #currentPlayer.country.Troops > 0 then
        currentPlayer.player.squadron = currentPlayer.country.Troops[1].nativeName
    else
        currentPlayer.player.squadron = ''
    end
    
    update()
end

function onComboSquadronChange()
    local squadName = comboSquadron:getText()
    currentPlayer.player.squadron = squadName
    updateSquadron()
end

function onEditCallsignChange(self, focused, prevFocusedWidget)
    if not focused then
        currentPlayer.player.callsign = base.assert(self:getText())
    end
end

function createNewPlayer()
    local ind = 1
    local newName
    while true do 
        newName = cdata.new_pilot .. tostring(ind)
        if checkNewPlayerName(newName) then
            addNewPlayer(newName)
            break
        else
            ind = ind + 1
        end
    end
end


function onButtonNew()    
    createNewPlayer()
    update()
end

function updatePlayers()
    comboPilot:clear()
    
    for i, player in ipairs(logbook.players) do
        local item = ListBoxItem.new(player.name, true)
        
        comboPilot:insertItem(item)
    end
end

function onComboInvulnerableChange()
    currentPlayer.player.invulnerable = (comboInvulnerable:getText() == cdata.yes)
end

function setPilotTheme(pic)
    setSkinPicture(sUploadImgSkin, pic)
    sUploadImg:setSkin(sUploadImgSkin)
end

function onButtonPilotPicChange()
	local path = MeSettings.getImagePath()
	local filters = {FileDialogFilters.image()}
	local filename = FileDialog.open(path, filters, cdata.choosePilotPicture)
	
	if filename then
        currentPlayer.player.picture = filename
        setPilotTheme(filename)  
		MeSettings.setImagePath(filename)
	end
end

function updateWidgets()    
	local curStat
	
	if (curType == "GENERAL") then
		curStat = currentPlayer.player.statistics
	else
		curStat = currentPlayer.player.statistics[curType]
	end
	
	if (curStat == nil) then
		curStat = {}
	end
	
--	local flightHoursStr = createTimeStr(curStat.flightHours or 0, true)
    local DayTimeStr, DayTimeInt = createTimeStr(curStat.daytime or 0, true)
    local NightTimeStr, NightTimeInt = createTimeStr(curStat.nighttime or 0, true)
    local flightHoursStr = createTimeStr(DayTimeInt+NightTimeInt, true)
	
	widgetFlightHoursVal:setText(flightHoursStr)
	widgetDayTimeVal:setText(DayTimeStr)
	widgetNightTimeVal:setText(NightTimeStr)
	widgetLandingsVal:setText(tostring(curStat.landings or 0))
	widgetEjectionsVal:setText(tostring(curStat.ejections or 0))       	
	widgetRefuelsVal:setText(tostring(curStat.refuelings or 0))
		
	widgetTotalScoreVal:setText(tostring(curStat.totalScore or 0)) 
	widgetAAKillsVal:setText(tostring(curStat.aaKills or 0))		
	widgetAGKillsVal:setText(tostring(curStat.agKills or 0))
	widgetStaticVal:setText(tostring(curStat.static or 0))
	widgetNavalVal:setText(tostring(curStat.naval or 0))		
	widgetDeathsVal:setText(tostring(curStat.deaths or 0))
    
	-- общие	
	widgetCampaignsVal:setText(tostring(currentPlayer.player.statistics.campaignsCount))
	widgetMissionsVal:setText(tostring(currentPlayer.player.statistics.missionsCount))
	widgetCommissionedVal:setText(tostring(currentPlayer.player.statistics.commissioned))	
	
	updateComboInvulnerable()
    
	widgetFriendlyAAKillsVal:setText(tostring(currentPlayer.player.statistics.faaKills))
	widgetFriendlyAGKillsVal:setText(tostring(currentPlayer.player.statistics.fagKills))
	widgetKillRatioVal:setText(tostring(currentPlayer.player.statistics.killRatio))
end

function createNewGame(campaign)
  local player = playerByName[logbook.currentPlayerName]
  local ind, val = base.next(player.games)
    while (ind) do
        local game = val
        if textutil.Utf8ToLowerCase(game.campaign) == textutil.Utf8ToLowerCase(campaign.path) then
            table.remove(player.games, ind)
            ind = nil
        end
        ind, val = base.next(player.games, ind)       
    end
  local game = {
      player = logbook.currentPlayerName,
      created = base.os.date(),
      status = Campaign.cdata.inactive,
      history = {},
      campaign = campaign.path
    }
  table.insert(player.games, game)
  return game
end

function displayPromotionGreeting(newRank)
    showInfo(string.format(cdata.promotionGreeting, newRank or ''))
end 

function displayDegradeWindow()
    showInfo(cdata.degradeMessage)
end 

function displayDeadPilotWindow(pilotName, last)
    local str = ''
    if last then
        str = string.format(cdata.lastPilotDeadMessage, pilotName, pilotName, cdata.new_pilot_name)
    else
        str = string.format(cdata.pilotDeadMessage, pilotName)
    end
    showInfo(str)
end 

function displayAwardGreeting(award)
    local str = string.format(cdata.awardGreeting, award.nativeName)
    local picPath = 'MissionEditor/data/images/countries/' .. award.picture
	
    MsgWindow.user(str, cdata.message, Picture.new(picPath), cdata.ok):show()
end 

-- проецирование отрезка v на отрезок n
local function segmentProjection(v1, v2, n1, n2)	
	local start = math.max(v1, n1)
	local finish = math.min(v2, n2)
	
	-- если n не лежит в пределах v тогда возвращает 0
	return math.max(0, finish - start) 
end

function getDayNightFlightTime(startTime, finishTime)
	local dayLengthInSeconds = 24 * 60 * 60
	local startDayTime = 6 * 60 * 60
	local finishDayTime = 21 * 60 * 60
	local fullDays = math.floor((finishTime - startTime) / dayLengthInSeconds)
	local daytimeLength = finishDayTime - startDayTime
	local dayTime = fullDays * daytimeLength
	local nightTime = fullDays * (dayLengthInSeconds - daytimeLength)
	
	startTime = startTime % dayLengthInSeconds
	finishTime = finishTime % dayLengthInSeconds
	
	-- теперь finishTime может быть меньше, чем startTime
	if startTime <= finishTime then
		dayTime = dayTime + segmentProjection(startDayTime, finishDayTime, startTime, finishTime)
		nightTime = nightTime + segmentProjection(0, startDayTime, startTime, finishTime)
		nightTime = nightTime + segmentProjection(finishDayTime, dayLengthInSeconds, startTime, finishTime)
	else
		dayTime = dayTime + segmentProjection(startDayTime, finishDayTime, startTime, dayLengthInSeconds)	
		dayTime = dayTime + segmentProjection(startDayTime, finishDayTime, 0, finishTime)
		nightTime = nightTime + segmentProjection(0, startDayTime, 0, finishTime)
		nightTime = nightTime + segmentProjection(finishDayTime, dayLengthInSeconds, 0, finishTime)
		nightTime = nightTime + segmentProjection(0, startDayTime, startTime, dayLengthInSeconds)
		nightTime = nightTime + segmentProjection(finishDayTime, dayLengthInSeconds, startTime, dayLengthInSeconds)
	end
	
	return dayTime, nightTime
end

function isInsideCoalition(coalition, countryWorldID)
	if coalition then
		for i,country in ipairs(coalition.country) do 
			if country.id == countryWorldID then
				return true
			end
		end
	end
    return false
end 

function updateUnitsData()
	plData = {}
	availableType ={} -- типы ЛА для которых надо сохранять статистику
	
	if (base.plugins ~= nil) then
		for i, v in ipairs(base.plugins) do
			if v.applied == true and v.LogBook ~= nil and base.type(v.LogBook) == "table" then
				for kk,vv in pairs(v.LogBook) do	
					local tmp 				= {}
					tmp.name 				= vv.name
					tmp.type  		        = vv.type
                    base.table.insert(plData, tmp)
					availableType[vv.type]  = vv.name
				end
			end
		end
    end
end

loadLogbookData()