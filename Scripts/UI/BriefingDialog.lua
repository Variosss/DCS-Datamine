dofile('./Scripts/UI/initGUI.lua')

local base = _G

module('BriefingDialog')

local type        = base.type
local require = base.require
local print = base.print
local assert = base.assert
local tostring = base.tostring
local pairs = base.pairs
local ipairs = base.ipairs
local tonumber = base.tonumber
local table = base.table
local math = base.math
local string = base.string


local Gui               = require('dxgui')
local GuiWin            = require('dxguiWin')
local DialogLoader      = require('DialogLoader')
local WidgetParams      = require('WidgetParams')
local gettext           = require('i_18n')
local DCS               = require('DCS')
local ChoiceOfRoleDialog = require('ChoiceOfRoleDialog')
local autobriefingutils = require('autobriefingutils')
local UC				= require('utils_common')
local net               = require('net')
local keys              = require('mul_keys')
local Terrain           = require('terrain')
local i18n 				= require('i18n')
local DB                = require('me_db_api')
local imagePreview      = require('imagePreview')

base.setmetatable(base.dxgui, {__index = base.dxguiWin})

local indexPict = 1
local unpauseMessage = false
local dataImagesCount = 0
local returnScreen = nil
local airdromesById_ = {}
local tblStartGroups = {}

local function _(text, dText) 
    local newText = gettext.translate(text)
    if newText == text and dText then
        return dText
    end
	return newText
end

local cdata = {
        BRIEFING = _('BRIEFING_HEADER','BRIEFING'),
		details = _('Details'),
		BACK = _('BACK'),
		FLY = _('FLY'),
		flyMission = _('Fly mission'),
		pauseMsg = _('Press Pause/Break to start'),
        of = _('OF'),
        title_data = _('TITLE DATA'),
        title = _('Title'),
        start = _('Start at'),
        my_side = _('My Side'),
        friends = _('Friends'),
        enemies = _('Enemies'),
        mission_data = _('MISSION DATA'),
        my_task = _('My task'),
        targets = _('Targets'),
        flight = _('Flight'),
        fuel = _('Fuel'),
        weapon = _('Weapon'),
        description = _('DESCRIPTION'),
        mission_goal = _('MISSION GOAL'),
        specification = _('KNOWN THREATS'),
        awacs = _('AWACS'),
        tanker = _('TANKER'),
        threat = _('Threat'),
        package = _('Package'),
        weather = _('WEATHER'),
        temperature = _('Temperature'),
        cloud_cover = _('Cloud cover'),
        wind = _('Nav Wind'),
        turbulence = _('Turbulence'),
        take_off_and_departure = _('TAKE OFF AND DEPARTURE'),
        airfield = _('Airfield'),
        takeoff_time = _('Take off time'),
        landing = _('LANDING'),
        airfield = _('Airfield'),
        landing_time = _('Landing time'),
        mission_start = _('Mission start'),
        allies_flight_title = _('ALLIES FLIGHT'),
        allies_flight = _('Allies flight'),
        
        km_unit = _('km'),
        cloud_cover_base = _('base'),
        NA = _('N/A'),
		
		SITUATION 		= _('SITUATION'),
		MISSION 		= _('MISSION'),
		EXECUTION 		= _('EXECUTION'),
		ADMIN 			= _('ADMINISTRATION / LOGISTICS'),
		COMMAND 		= _('COMMAND / SIGNAL'),
    }
    
    if base.LOFAC then
        cdata.mission_start = _('Mission start-LOFAC')
        cdata.mission_goal = _('MISSION GOAL-LOFAC')
        cdata.mission_data = _('MISSION DATA-LOFAC')
    end

function create()
	window = DialogLoader.spawnDialogFromFile('MissionEditor/modules/dialogs/briefing_dialog.dlg', cdata)
    
    containerMain = window.containerMain  
    panelBottom = containerMain.panelBottom    
    cancelBtn = panelBottom.buttonBack
    flyBtn = panelBottom.buttonFly
    pCenter = containerMain.pCenter
    pNoVisible = window.pNoVisible
	sbHorz = pCenter.bgPanel.sbHorz
	sbVert = pCenter.bgPanel.sbVert
    
    
	buttonClose = DialogLoader.findWidgetByName(window, 'buttonClose')
	buttonFly = DialogLoader.findWidgetByName(window, 'buttonFly')
	staticPause = DialogLoader.findWidgetByName(window, 'staticPause')
	buttonBack = DialogLoader.findWidgetByName(window, 'buttonBack')

	buttonPrev = pCenter.buttonPrev
	buttonNext = pCenter.buttonNext
	staticImage = pCenter.bgPanel.pictureWidget  
	staticImageSkin = staticImage:getSkin()
    imagePreviewWidget = imagePreview.new(staticImage, sbHorz, sbVert)
	picture = staticImageSkin.skinData.states.released[1].picture
	staticImageNumber = pCenter.staticImageNumber
    staticOF = pCenter.widgetOf
    autoBriefingScrollPane = pCenter.bgPanel.autoBriefingScrollPane
    
    buttonClose.onChange = Close_onChange
    buttonPrev.onChange = Prev_onChange
    buttonNext.onChange = Next_onChange
    buttonFly.onChange = Fly_onChange
    buttonBack.onChange = Back_onChange
    
    buttonBack:setVisible(false)

	local screenWidth, screenHeight = Gui.GetWindowSize()

    local width, height = Gui.GetWindowSize()
    window:setBounds(0,0,width, height)
    window.containerMain:setBounds((width-1280)/2, (height-768)/2, 1280, 768)
    
    window.pSimFon:setBounds(0,0,width, height)   
    window.pSimFon.pSimBorder:setBounds((width-1284)/2, (height-772)/2, 1284, 772)
    window.pMeFon:setVisible(false)
    window.pSimFon:setVisible(true)
    containerMain.panelBottom.staticPause:setVisible(true)
    containerMain.panelBottom.middleBtn:setVisible(false)
end

function show()
	if not window then
		 create()
	end
    
	
	if window:getVisible() == false then
		DCS.lockAllMouseInput()
	end
	
	pNoVisible = window.pNoVisible
    
    autobriefingutils.setStaticSectionItemSkin(pNoVisible.staticSkinSectionItem:getSkin())
    autobriefingutils.setStaticSectionDataItemSkin(pNoVisible.staticSkinSectionDataItem:getSkin())
    autobriefingutils.setEditBoxSectionDataItemSkin(pNoVisible.editboxSkinSectionDataItem:getSkin())
    autobriefingutils.setStaticTitleItemSkin(pNoVisible.staticSkinTitleItem:getSkin())
    autobriefingutils.setStaticGridCellSkin(pNoVisible.staticGridCellSkin:getSkin())
	autobriefingutils.setStaticGridCellMiddleSkin(pNoVisible.staticGridCellMiddleSkin:getSkin())
    autobriefingutils.setGridSkin(pNoVisible.grid:getSkin())
    autobriefingutils.setGridHeaderSkin(pNoVisible.gridHeaderCell:getSkin())
	autobriefingutils.setGridHeaderMiddleSkin(pNoVisible.gridHeaderMiddle:getSkin())
	
	staticPause:setVisible(unpauseMessage)
--	buttonBack:setVisible(not unpauseMessage)
    
    unitType = DCS.getPlayerUnitType()

    update()
	window:setVisible(true)
    setPause(true)
end

function hide()
	if window then
		if window:getVisible() == true then
			DCS.unlockMouseInput()
		end
		window:setVisible(false)
	end
end

function update()
    dataBrf = DCS.getPlayerBriefing()
    updateBriefing()
    if dataBrf and dataBrf.images and (dataBrf.triggerPic == nil) then
        dataImagesCount = #dataBrf.images
    else
        dataImagesCount = 0
    end
    
    indexPict = 1
    setImageCount(dataImagesCount)
    updateNumPict()
    updatePict()
    
    if dataImagesCount < 2 then
        buttonPrev:setVisible(false)
        buttonNext:setVisible(false)  
        staticImageNumber:setVisible(false)  
        staticOF:setVisible(false)     
    else
        buttonPrev:setVisible(true)
        buttonNext:setVisible(true) 
        staticImageNumber:setVisible(true)  
        staticOF:setVisible(true)        
    end
end

function getVisible()
    if window == nil then
        return false
    end
	return window:getVisible()
end

function kill()
	Gui.SetWaitCursor(false)

	if window then
		window:kill()
		window = nil
	end
end

function Close_onChange()
    hide()
end

function Back_onChange()
    hide()
    if returnScreen == 'Menu' then
        GameMenu.show()
    else
        if (DCS.isMultiplayer() ~= true) then
            ChoiceOfRoleDialog.show(nil, true, "Menu")
        end
    end
end

function Fly_onChange()
    if DCS.isMultiplayer() then
        net.spawn_player()
    else
       	DCS.spawnPlayer()
    end
    hide()
    setPause(false)
end

function setPause(b)
    if DCS.isMultiplayer() == false or DCS.isTrackPlaying() == true then
        DCS.setPause(b)
    end    
end

function Prev_onChange()
    indexPict = indexPict - 1   
    updateNumPict()  
    updatePict()    
end

function Next_onChange()
    indexPict = indexPict + 1 
    updateNumPict()  
    updatePict()    
end

function updateNumPict()
    if indexPict == 1 then
        buttonPrev:setEnabled(false)
    else
        buttonPrev:setEnabled(true)
    end
    
    if indexPict >= dataImagesCount then
        buttonNext:setEnabled(false)
    else
        buttonNext:setEnabled(true)
    end

    staticImageNumber:setText(indexPict)
end

function showUnpauseMessage(value)
    unpauseMessage = value
end

function setImageCount(count)
    staticOF:setText(cdata.of .. ' ' .. tostring(count))
end


function updatePict()
    local pictureFilename
    
    if dataBrf.type then
        local name = 'briefing-map-'..dataBrf.type..'.png'
        --base.print("----GetTextureExists=",name,Gui.GetTextureExists(name), Gui.GetTextureExists("dfgfdgfdG"))
        if Gui.GetTextureExists(name) == true then
            pictureFilename = name
        else
            name = 'briefing-map-'..dataBrf.type..'.jpg'
            if Gui.GetTextureExists(name) == true then
                pictureFilename = name
            end
        end
    end
    
   -- pictureFilename = 'briefing-map-'..dataBrf.type..'.png' -- TMP
    
    if  pictureFilename == nil then
        pictureFilename = 'briefing-map-default.png'
    end
    
    if dataImagesCount > 0 then
        pictureFilename = dataBrf.images[indexPict]
    end    
    
    if dataBrf.triggerPic then
        pictureFilename = dataBrf.triggerPic
    end

    imagePreviewWidget:setPicture(pictureFilename)
end

function updateBriefing()
    -- генерируем автобрифинг
    if dataBrf.bHuman == true then
        generateAutoBriefing()
    else
        generateSimpleAutoBriefing()
    end
    autobriefingutils.setData(autoBriefing)
    
    autobriefingutils.updateScrollPane(autoBriefingScrollPane, 630)
end

function updateAirdrome()
    local radio 
    if Terrain.getRadio then
        radio= Terrain.getRadio()
    end
   
	for airdromeNumber, airdromeInfo in pairs(Terrain.GetTerrainConfig('Airdromes')) do
        if (airdromeInfo.reference_point) and (airdromeInfo.abandoned ~= true)  then 
            local airdrome      = {}
            airdrome.x, airdrome.y	= airdromeInfo.reference_point.x, airdromeInfo.reference_point.y
            airdrome.height        = Terrain.GetHeight(airdrome.x, airdrome.y)
            local locale		= i18n.getLocale()		
            local name	
            
            if airdromeInfo.display_name then
                airdrome.name = _(airdromeInfo.display_name) 
            else
                airdrome.name = airdromeInfo.names[locale] or airdromeInfo.names['en']
            end    

            local frequencyList = {}
            if airdromeInfo.frequency then
                frequencyList	= airdromeInfo.frequency
            else
                if airdromeInfo.radio then
                    for k, radioId in pairs(airdromeInfo.radio) do
                        local frequencys = DCS.getATCradiosData(radioId)
                        if frequencys then
                            for kk,vv in pairs(frequencys) do
                                table.insert(frequencyList, vv)  
                            end
                        end
                    end
                end            
            end
            
            airdrome.frequencyList = frequencyList
            airdromesById_[airdromeNumber]	= airdrome
        end
	end	
end

function updateStartGroups(a_tblStartData)
    tblStartGroups = {}
    local frequency
    
    if a_tblStartData.airdromeId then
        updateAirdrome()
        local airdrome = airdromesById_[a_tblStartData.airdromeId]
        if airdrome and DB.isInitialized() == true then 
            airdromeName = airdrome.name
            airdromeHeight = airdrome.height
            --frequency
            local unitTypeDesc = DB.unit_by_type[unitType]
            if unitTypeDesc and unitTypeDesc.HumanRadio then
                for _tmp, frequencyL in base.pairs(airdrome.frequencyList) do
                    local freq = frequencyL/1000000.0
					if not frequency then
						frequency = string.format("%.3f %s", freq, _('MHz'))
					else
						frequency = frequency.."\n"..string.format("%.3f %s", freq, _('MHz'))
					end                                    
                end
            end
            positionAirdrome = {x = airdrome.x, y = airdromeHeight, z = airdrome.y}
        else
            airdromeName = " "
            frequency = "0"
            positionAirdrome = {x = 0, y = 0, z = 0}
        end
        
        tblStartGroups[1] = {name = a_tblStartData.name, airdromeName = airdromeName, frequency = frequency,
                        position = positionAirdrome}
    elseif a_tblStartData.position then
        local helipadHeight = Terrain.GetHeight(a_tblStartData.position.x, a_tblStartData.position.y)
        local frequencyStr = "-"               
        if a_tblStartData.heliport_frequency then
            frequencyStr = tostring(a_tblStartData.heliport_frequency).." ".._('MHz')
        end
        local helipadHeight = Terrain.GetHeight(a_tblStartData.position.x, a_tblStartData.position.z)
        tblStartGroups[1] = {name = a_tblStartData.name, airdromeName = a_tblStartData.helipadName, frequency = frequencyStr,
                        position = {x = a_tblStartData.position.x, y = helipadHeight, z = a_tblStartData.position.z}}
    end
end

function composeEntry(section, title, data, needGrid)
    if data == "" then
        return nil
    end
    return {section = section, title = title, data = data, needGrid = needGrid}
end
    
-------------------------------------------------------------------------------
-- генерация автобрифинга
function generateAutoBriefing()    
    -- обновляем диалог редактирования брифинга для текущей загруженной миссии
    local currentTab = '  '
    local separator = '#'
    local tab1,tab2 = 2,20
    autoBriefing = {}
    
    coalitionName = dataBrf.coalitionName -- 'red' 'blue'
    --base.print("----coalitionName=",coalitionName)

    -- список угроз для игрока
    local threats_list = {}
    local allies_list = {}
    if dataBrf.threats_list then
        for k,v in base.pairs(dataBrf.threats_list) do
            threats_list[keys.getDisplayName(k)] = v
        end  
    end 
    
    if dataBrf.allies_list then
        for k,v in base.pairs(dataBrf.allies_list) do
            allies_list[keys.getDisplayName(k)] = v
        end
    end
    
    local countryName = dataBrf.countryName
    local side
    
    if  countryName then
        side = _(countryName)    
    else
        if dataBrf.side == "red" then
            side = _("Red coalition")
        elseif dataBrf.side == "blue" then
            side = _("Blue coalition")
		elseif dataBrf.side == "neutrals" then
			side = _("Neutrals")	
        end       
    end
    
    updateStartGroups(dataBrf.tblStartData)
        
    autoBriefing = {} 
    table.insert(autoBriefing, composeEntry(cdata.title_data))
    table.insert(autoBriefing, composeEntry(nil, cdata.title,      dataBrf.sortie))
    table.insert(autoBriefing, composeEntry(nil, cdata.start,    autobriefingutils.composeDateString(dataBrf.mission_start_time, true, dataBrf.mission_date)))
    table.insert(autoBriefing, composeEntry(nil, cdata.my_side,    side))
     --   table.insert(autoBriefing, composeEntry(nil, cdata.friends,    composeFriendsString() ))
     --   table.insert(autoBriefing, composeEntry(nil, cdata.enemies,    enemiesString ))
    if dataBrf.task then
        table.insert(autoBriefing, composeEntry(cdata.mission_data))
        table.insert(autoBriefing, composeEntry(nil, cdata.my_task,    _(dataBrf.task)))
        table.insert(autoBriefing, composeEntry(nil, cdata.flight,     keys.getDisplayName(dataBrf.type).."*"..dataBrf.numGroupUnits ))
    end
 --   table.insert(autoBriefing, composeEntry(nil, cdata.fuel,       playerUnit.payload.fuel..'('..getFuelPods()..')' ))
--   table.insert(autoBriefing, composeEntry(nil, cdata.weapon,     dataBrf.weaponsString ))
    table.insert(autoBriefing, composeEntry(cdata.allies_flight_title))        
    table.insert(autoBriefing, composeEntry(nil, cdata.allies_flight,     autobriefingutils.composeString(allies_list, '*') ))
	
	if dataBrf.descriptionTbl == nil then
		table.insert(autoBriefing, composeEntry(cdata.description, nil,    dataBrf.descText))
		if dataBrf.mission_goal ~= "" then
			table.insert(autoBriefing, composeEntry(cdata.mission_goal,    nil, dataBrf.mission_goal))
		end
	else
		base.U.traverseTable(dataBrf.descriptionTbl)
--		base.print("--dataBrf.side--",dataBrf.side)
		if dataBrf.descriptionTbl[dataBrf.side].situation and dataBrf.descriptionTbl[dataBrf.side].situation ~= "" then
			table.insert(autoBriefing, composeEntry(cdata.SITUATION, nil,    dataBrf.descriptionTbl[dataBrf.side].situation))
		end
		if dataBrf.descriptionTbl[dataBrf.side].mission and dataBrf.descriptionTbl[dataBrf.side].mission ~= "" then
			table.insert(autoBriefing, composeEntry(cdata.MISSION, nil,    dataBrf.descriptionTbl[dataBrf.side].mission))
		end
		if dataBrf.descriptionTbl[dataBrf.side].execution and dataBrf.descriptionTbl[dataBrf.side].execution ~= "" then
			table.insert(autoBriefing, composeEntry(cdata.EXECUTION, nil,    dataBrf.descriptionTbl[dataBrf.side].execution))
		end
		if dataBrf.descriptionTbl[dataBrf.side].administration and dataBrf.descriptionTbl[dataBrf.side].administration ~= "" then
			table.insert(autoBriefing, composeEntry(cdata.ADMIN, nil,    dataBrf.descriptionTbl[dataBrf.side].administration))
		end
		if dataBrf.descriptionTbl[dataBrf.side].command and dataBrf.descriptionTbl[dataBrf.side].command ~= "" then
			table.insert(autoBriefing, composeEntry(cdata.COMMAND, nil,    dataBrf.descriptionTbl[dataBrf.side].command))
		end			
	end	
    table.insert(autoBriefing, composeEntry(cdata.specification))
    table.insert(autoBriefing, composeEntry(nil, cdata.threat,     autobriefingutils.composeString(threats_list, '*') ))
    table.insert(autoBriefing, composeEntry(cdata.weather))
    table.insert(autoBriefing, composeEntry(nil, cdata.temperature,    string.format('%+d', dataBrf.temperature) .. '°' ))
    table.insert(autoBriefing, composeEntry(nil, _('QNH_brief','QNH'),    string.format('%d / %0.2f', dataBrf.qnh or 0, (dataBrf.qnh or 0) / 25.4)))
    table.insert(autoBriefing, composeEntry(nil, cdata.cloud_cover,    cdata.cloud_cover_base .. ' ' .. dataBrf.clouds_base))
    table.insert(autoBriefing, composeEntry(nil, cdata.wind,           UC.composeWindString(dataBrf.weather, dataBrf.humanPosition)))
    table.insert(autoBriefing, composeEntry(nil, cdata.turbulence,        UC.composeTurbulenceString(dataBrf.weather)))
    
    if dataBrf.startTime then
        table.insert(autoBriefing, composeEntry(cdata.take_off_and_departure))
        table.insert(autoBriefing, composeEntry(nil,  cdata.mission_start,  autobriefingutils.composeDateString(dataBrf.startTime, false, dataBrf.mission_date)))
        if #tblStartGroups > 0 then  
            table.insert(autoBriefing, composeEntry(nil,  nil,  tblStartGroups, true ))
        end
    end    
     
    --traverseTable(autoBriefing)
    --traverseTable(mission)
end

-------------------------------------------------------------------------------
--генерация упрощенного автобрифинга
function generateSimpleAutoBriefing()
    -- обновляем диалог редактирования брифинга для текущей загруженной миссии
    local currentTab = '  '
    local mission_goal
    autoBriefing = {}

    table.insert(autoBriefing, composeEntry(cdata.title_data))
    table.insert(autoBriefing, composeEntry(nil, cdata.title,      dataBrf.sortie))
    table.insert(autoBriefing, composeEntry(nil, cdata.start,    autobriefingutils.composeDateString(dataBrf.mission_start_time, true, dataBrf.mission_date)))
    
    table.insert(autoBriefing, composeEntry(cdata.description, nil,    dataBrf.descText))
    table.insert(autoBriefing, composeEntry(cdata.weather))
    table.insert(autoBriefing, composeEntry(nil, cdata.temperature,    string.format('%+d', dataBrf.temperature) .. '°' ))
    table.insert(autoBriefing, composeEntry(nil, _('QNH_brief','QNH'),    string.format('%d / %0.2f', dataBrf.qnh or 0, (dataBrf.qnh or 0) / 25.4)))
    table.insert(autoBriefing, composeEntry(nil, cdata.cloud_cover,    cdata.cloud_cover_base .. ' ' .. dataBrf.clouds_base))
    table.insert(autoBriefing, composeEntry(nil, cdata.wind,           UC.composeWindString(dataBrf.weather, dataBrf.humanPosition)))
    table.insert(autoBriefing, composeEntry(nil, cdata.turbulence,        UC.composeTurbulenceString(dataBrf.weather)))
end


