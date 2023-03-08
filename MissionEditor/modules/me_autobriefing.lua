local base = _G

module('me_autobriefing')

local require = base.require
local print = base.print
local assert = base.assert
local tostring = base.tostring
local pairs = base.pairs
local tonumber = base.tonumber
local table = base.table
local math = base.math
local string = base.string

local SkinUtils 				= require('SkinUtils')
local MissionModule 			= require('me_mission')
local DB 						= require('me_db_api')
local U 						= require('me_utilities')
local UC				        = require('utils_common')
local BriefingUtils 			= require('me_briefing_utils')
local i18n 						= require('i18n')
local Tools 					= require('tools')
local crutches 					= require('me_crutches')
local panel_generator 			= require('me_generator_dialog')
local panel_generator_simple 	= require('me_simple_generator_dialog')
local panel_campaign			= require('me_campaign')
local MapWindow					= require('me_map_window')
local ImageSearchPath           = require('image_search_path')
local mod_dictionary            = require('dictionary')
local CoalitionController		= require('Mission.CoalitionController')
local AirdromeController	    = require('Mission.AirdromeController')
local autobriefingutils         = require('autobriefingutils')
local music				        = require('me_music')
local LangController	        = require('Mission.LangController')
local waitScreen	        	= require('me_wait_screen')
local OptionsData		        = require('Options.Data')
local Terrain                   = require('terrain')
local DialogLoader	            = require('DialogLoader')
local Gui						= require('dxgui')
local imagePreview              = require('imagePreview')
local Analytics					= require("Analytics")  
local ProductType 				= require('me_ProductType') 


i18n.setup(_M)

local cdata =
{
    title_data = _('TITLE DATA'),
    title = _('Title'),
    start = _('Start at'),
    my_side = _('My Side'),
    friends = _('Friends'),
    enemies = _('Enemies'),
    mission_data = _('MISSION DATA'),
    mission_start = _('Mission start'),
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
    allies_flight_title = _('ALLIES FLIGHT'),
    allies_flight = _('Allies flight'),
    
    speed_unit = _('m/s'),
    km_unit = _('km'),
    wind_at_ground = _('At GRND'),
    wind_at_2000 = _('At 2000m'),
    wind_at_8000 = _('At 8000m'),
    cloud_cover_base = _('base'),
    
    BACK = _('CANCEL'),
    middleBtn = _('MISSION PLANNER'),
    FLY = _('START'),
    of = _('OF'),
    NA = _('N/A'),
    details = _('Details'),
    BRIEFING = _('BRIEFING_HEADER','BRIEFING'),
    noWeapon = _('No weapon'),
	
	SITUATION 		= _('SITUATION'),
	MISSION 		= _('MISSION'),
	EXECUTION 		= _('EXECUTION'),
	ADMIN 			= _('ADMINISTRATION / LOGISTICS'),
	COMMAND 		= _('COMMAND / SIGNAL'),
}

if ProductType.getType() == "LOFAC" then
    cdata.mission_start = _('Mission start-LOFAC')
    cdata.mission_goal = _('MISSION GOAL-LOFAC')
    cdata.mission_data = _('MISSION DATA-LOFAC')
end

autoBriefing = {}
doSave = false

returnToME = false

local indexPict = 1
local listPict = {}

local window

-------------------------------------------------------------------------------
--создание окна
local function create_()

    if ProductType.getType() == "LOFAC" then
        cdata.rightBtn = _("START LOFAC", "START")
    end    

    window = DialogLoader.spawnDialogFromFile('MissionEditor/modules/dialogs/briefing_dialog.dlg', cdata)
    
    containerMain = window.containerMain  
    panelBottom = containerMain.panelBottom    
    missionEditorBtn = panelBottom.middleBtn
    cancelBtn = panelBottom.buttonBack
    flyBtn = panelBottom.buttonFly
    pCenter = containerMain.pCenter
    buttonClose = containerMain.panelTop.buttonClose
    
    local width, height = Gui.GetWindowSize()
    window:setBounds(0,0,width, height)
    window.containerMain:setBounds((width-1280)/2, (height-768)/2, 1280, 768)
    
  --  window.pSimFon:setBounds(0,0,width, height)   
  --  window.pSimFon.pSimBorder:setBounds((width-1284)/2, (height-772)/2, 1284, 772)
    window.pMeFon:setBounds(0,0,width, height)
    window.pMeFon:setVisible(true)
    window.pSimFon:setVisible(false)
    panelBottom.staticPause:setVisible(false)

    cancelBtn.onChange = cancelBtnOnChange
    buttonClose.onChange = cancelBtnOnChange
    missionEditorBtn.onChange = missionEditorBtnOnChange
    flyBtn.onChange = flyBtnOnChange
    pNoVisible = window.pNoVisible
	sbHorz = pCenter.bgPanel.sbHorz
	sbVert = pCenter.bgPanel.sbVert
    
    autobriefingutils.setStaticSectionItemSkin(pNoVisible.staticSkinSectionItem:getSkin())
    autobriefingutils.setStaticSectionDataItemSkin(pNoVisible.staticSkinSectionDataItem:getSkin())
    autobriefingutils.setEditBoxSectionDataItemSkin(pNoVisible.editboxSkinSectionDataItem:getSkin())
    autobriefingutils.setStaticTitleItemSkin(pNoVisible.staticSkinTitleItem:getSkin())
    autobriefingutils.setStaticGridCellSkin(pNoVisible.staticGridCellSkin:getSkin())
	autobriefingutils.setStaticGridCellMiddleSkin(pNoVisible.staticGridCellMiddleSkin:getSkin())
    autobriefingutils.setGridSkin(pNoVisible.grid:getSkin())
    autobriefingutils.setGridHeaderSkin(pNoVisible.gridHeaderCell:getSkin())
	autobriefingutils.setGridHeaderMiddleSkin(pNoVisible.gridHeaderMiddle:getSkin())
    
    widgetOf = pCenter.widgetOf
    
    pictureWidget = pCenter.bgPanel.pictureWidget    
    
    imagePreviewWidget = imagePreview.new(pictureWidget, sbHorz, sbVert)
    
    buttonPrev = pCenter.buttonPrev
	buttonNext = pCenter.buttonNext
    staticImageNumber = pCenter.staticImageNumber
    
    buttonPrev.onChange = Prev_onChange
    buttonNext.onChange = Next_onChange
    
    window:addHotKeyCallback('escape', cancelBtnOnChange)      
    window:addHotKeyCallback('return', flyBtnOnChange)   

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
    
    if indexPict >= #listPict then
        buttonNext:setEnabled(false)
    else
        buttonNext:setEnabled(true)
    end

    staticImageNumber:setText(indexPict)
end

function updatePict()
    local fileName = 'briefing-map-default.png'
    
    if listPict[indexPict] ~= nil then
        local tmp, path = mod_dictionary.getValueResource(listPict[indexPict], LangController.getCurLang())        
        fileName = base.tempMissionPath .. path       
    end    

	Gui.ReloadTexture(fileName)
    imagePreviewWidget:setPicture(fileName)
end

-------------------------------------------------------------------------------
--запуск симулятора
function Fly(params, doNotApplyOptions)
    -- Текущую миссию нужно сохранить во временном файле
    local path = base.tempDataDir .. base.tempMissionName
    show(false)
	
    waitScreen.setUpdateFunction(function()

		params.file = path
		params.command = params.command or ""
		if (MissionModule.play(params, returnScreen, MissionModule.mission.path, doNotApplyOptions, doSave) == false) then
			show(true)
		end
	end)
end

function updateAutoBriefing()
    -- генерируем автобрифинг
    playerUnit,
    player, 
    group, 
    countryName,
    coalition,
    alliesString, 
    enemiesString, 
    sortie,
    coalitionName = BriefingUtils.extractPlayerDetails()    
    if playerUnit then
        generateAutoBriefing(MissionModule.mission)
    else
        generateSimpleAutoBriefing(MissionModule.mission)
    end
    autobriefingutils.setData(autoBriefing)
end

-------------------------------------------------------------------------------
-- обновление диалога
function update()
    missionEditorBtn:setVisible(true)
    updateAutoBriefing()
    -- текущая миссия
    local mission = MissionModule.mission
    
    -- рисуем картинку миссии
    local pictureFilename = nil

    if coalitionName == CoalitionController.redCoalitionName() then
        if mission.pictureFileNameR and mission.pictureFileNameR[1] and (mission.pictureFileNameR[1] ~='') then
            local fileName, path = mod_dictionary.getValueResource(mission.pictureFileNameR[1],LangController.getCurLang())
            pictureFilename = base.tempMissionPath ..  path
        end
        
        dataImagesCount = #mission.pictureFileNameR
        listPict = mission.pictureFileNameR
        widgetOf:setText(cdata.of .. ' ' .. tostring(#mission.pictureFileNameR))
    elseif coalitionName == CoalitionController.blueCoalitionName() then
        if mission.pictureFileNameB and mission.pictureFileNameB[1] and (mission.pictureFileNameB[1] ~='') then
            local fileName, path = mod_dictionary.getValueResource(mission.pictureFileNameB[1],LangController.getCurLang())
            pictureFilename = base.tempMissionPath .. path
        end
        
        dataImagesCount = #mission.pictureFileNameB
        widgetOf:setText(cdata.of .. ' ' .. tostring(#mission.pictureFileNameB))
        listPict = mission.pictureFileNameB
	elseif coalitionName == CoalitionController.neutralCoalitionName() then
        if mission.pictureFileNameN and mission.pictureFileNameN[1] and (mission.pictureFileNameN[1] ~='') then
            local fileName, path = mod_dictionary.getValueResource(mission.pictureFileNameN[1],LangController.getCurLang())
            pictureFilename = base.tempMissionPath .. path
        end
        
        dataImagesCount = #mission.pictureFileNameN
        widgetOf:setText(cdata.of .. ' ' .. tostring(#mission.pictureFileNameN))
        listPict = mission.pictureFileNameN	
    else
        local list = {}
        
        for i = 1,#mission.pictureFileNameR do 
            table.insert(list, mission.pictureFileNameR[i])
        end
        
        for i = 1,#mission.pictureFileNameB do 
            table.insert(list, mission.pictureFileNameB[i])
        end
        
        dataImagesCount = #list
        widgetOf:setText(cdata.of .. ' ' .. tostring(#list))
        if list[1] then
            local fileName, path = mod_dictionary.getValueResource(list[1],LangController.getCurLang())
            pictureFilename = base.tempMissionPath ..  path
        end
        listPict = list
    end
    
    if listPict then 
        if #listPict <= 1  then
            staticImageNumber:setVisible(false)
            buttonPrev:setVisible(false)
            buttonNext:setVisible(false)
            widgetOf:setVisible(false)
        else
            staticImageNumber:setVisible(true)
            buttonPrev:setVisible(true)
            buttonNext:setVisible(true)
            widgetOf:setVisible(true)
        end
    else
        staticImageNumber:setVisible(false)
        buttonPrev:setVisible(false)
        buttonNext:setVisible(false)
        widgetOf:setVisible(false)    
    end
    
    if (pictureFilename == nil) and MissionModule.playerUnit then
        local name = 'briefing-map-'..DB.getNameByDisplayName(MissionModule.playerUnit.type)..'.png'
        if ImageSearchPath.isTextureAvailable(name) == true then
            pictureFilename = name
        else
            name = 'briefing-map-'..DB.getNameByDisplayName(MissionModule.playerUnit.type)..'.jpg'
            if ImageSearchPath.isTextureAvailable(name) == true then
                pictureFilename = name
            end
        end
    end
    
    if  pictureFilename == nil then
        pictureFilename = 'briefing-map-default.png'
    end

    updateNumPict()
	Gui.ReloadTexture(pictureFilename)
    imagePreviewWidget:setPicture(pictureFilename)
    
    -- обновляем окно с текстом автобрифинга
    autobriefingutils.updateScrollPane(pCenter.bgPanel.autoBriefingScrollPane, 630)
end

-------------------------------------------------------------------------------
--установка необходимости пересохранения
function setDoSave(save)
	doSave = save
end

-------------------------------------------------------------------------------
-- Открытие/закрытие панели
function show(b, _returnScreen)
    returnScreen = _returnScreen or returnScreen or base.defaultReturnScreen
    
    if not window then    
        create_()
    end  
    
    window:setVisible(b)
    
    if b then
        indexPict = 1
        update()
    end
end

function getDataUnit(unit)
    local group = unit.boss
    local name = group.name
    local unitType = unit.type
    local airdromeName
    local helipadName
    local frequency
    local airdromeHeight
    local helipadHeight
    local positionAirdrome
    
    if group.route and group.route.points then
        for k,vv in base.ipairs(group.route.points) do
            if vv.airdromeId ~= nil then
                local airdrome = AirdromeController.getAirdrome(AirdromeController.getAirdromeId(vv.airdromeId))                
                if airdrome then
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
                return {name = name, airdromeName = airdromeName, frequency = frequency,
                        position = positionAirdrome}
            end
            
            if vv.helipadId ~= nil or vv.grassAirfieldId ~= nil then
                local helipad = MissionModule.unit_by_id[vv.helipadId or vv.grassAirfieldId] 
                helipadName = helipad.name
                helipadHeight = Terrain.GetHeight(helipad.x, helipad.y)
                local frequencyStr = "-"               
                if helipad.heliport_frequency then
                    frequencyStr = tostring(helipad.heliport_frequency).." ".._('MHz')
                end
                
                return {name = name, airdromeName = helipadName, frequency = frequencyStr,
                        position = {x = helipad.x, y = helipadHeight, z = helipad.y}}
            end
            
        end
    end
    
    
    return {name = name, airdromeName = '-', frequency = '-'}
end        

function composeEntry(section, title, data, needGrid)
    if data == "" then
        return nil
    end
    return {section = section, title = title, data = data, needGrid = needGrid}
end
    
-------------------------------------------------------------------------------
-- генерация автобрифинга
function generateAutoBriefing(mission)    
    -- обновляем диалог редактирования брифинга для текущей загруженной миссии
    local currentTab = '  '
    local separator = '#'
    local tab1,tab2 = 2,20
    local mission_goal
    autoBriefing = {}
    -- определяем цвет коалиции
    if coalitionName == CoalitionController.redCoalitionName()	then
        mission_goal = mission.descriptionRedTask
    elseif coalitionName == CoalitionController.blueCoalitionName() then
		mission_goal = mission.descriptionBlueTask
	elseif coalitionName == CoalitionController.neutralCoalitionName() then
        mission_goal = mission.descriptionNeutralsTask
    end

    -- список угроз для игрока
    local threats_list = getThreats()
    
    local allies_list = getAllies()
    -- ветер
    local humanPosition = {x=0, y=0, z=0}
    for id,unit in pairs(MissionModule.unit_by_id) do
        if unit.skill == crutches.getPlayerSkill() then
            humanPosition = {x=unit.x, y=0, z=unit.y}
        end
    end
    local windString = UC.composeWindString(mission.weather, humanPosition)
    -- турбулентность
    local turbulenceString = UC.composeTurbulenceString(mission.weather)
    local startTime = (not group.lateActivation) and (mission.start_time + group.start_time) or 0.0
    
    local tblStartGroups = {}
    -- поиск всех игроков и клиентов
    for _tmp, unit in pairs(MissionModule.unit_by_id) do
        if unit.skill == crutches.getPlayerSkill() then            
            table.insert(tblStartGroups,1 , getDataUnit(unit))
        end
        --[[ --клиенты только для мультиплеера]]
        --base.print("---unit.boss.boss.boss.name=",unit.boss.boss.boss.name)
        if unit.skill == crutches.getClientSkill() and coalitionName == unit.boss.boss.boss.name then
            table.insert(tblStartGroups, getDataUnit(unit))
        end
    end
    
    local function getFuelPods()
        local FUEL_TANK_WORLD_ID = 7
        local fuelPods = 0  
        
        local launcherAttribute__ = {}
        local launcherNetto__ = {}
        
        for _tmp, category in pairs(DB.db.Weapons.Categories) do
          for _tmp, launcher in pairs(category.Launchers) do
            launcherAttribute__[launcher.CLSID]  = launcher.attribute
            if  launcher.Weight_Empty ~= nil  then
                launcherNetto__[launcher.CLSID] = tonumber(launcher.Weight) - tonumber(launcher.Weight_Empty)
            else
                launcherNetto__[launcher.CLSID] = tonumber(launcher.Weight)	
            end		
          end
        end  

        for _, launcherCLSID in pairs(playerUnit.payload.pylons) do
            local attribute = launcherAttribute__[launcherCLSID['CLSID']]
            if U.isFuel_Tank(attribute) then
                local _fuel_inside_tank = launcherNetto__[launcherCLSID['CLSID']]
                fuelPods = fuelPods + _fuel_inside_tank
            end
        end
        return fuelPods
    end
    
    local function composeFuelString()   
        local unitSystem = OptionsData.getDifficulty('units')
        local label = U.weightUnits[unitSystem].name
        local coeff = U.weightUnits[unitSystem].coeff
        
        return math.floor(playerUnit.payload.fuel * coeff + 0.5)..'('..math.floor(getFuelPods() * coeff + 0.5)..')'..label
    end
    
    local numGroupUnits = #playerUnit.boss.units   
	
    autoBriefing = { }
        table.insert(autoBriefing, composeEntry(cdata.title_data))
        table.insert(autoBriefing, composeEntry(nil, cdata.title,      mission.sortie))
        table.insert(autoBriefing, composeEntry(nil, cdata.start,      autobriefingutils.composeDateString(mission.start_time, true, mission.date)))
        table.insert(autoBriefing, composeEntry(nil, cdata.my_side,    countryName))
        table.insert(autoBriefing, composeEntry(nil, cdata.friends,    composeFriendsString() ))
        table.insert(autoBriefing, composeEntry(nil, cdata.enemies,    enemiesString ))
        table.insert(autoBriefing, composeEntry(cdata.mission_data))
        table.insert(autoBriefing, composeEntry(nil, cdata.my_task,    group.task ))
        table.insert(autoBriefing, composeEntry(nil, cdata.flight,     DB.getDisplayNameByName(playerUnit.type).."*"..numGroupUnits ))
        table.insert(autoBriefing, composeEntry(nil, cdata.fuel,       composeFuelString()))
        table.insert(autoBriefing, composeEntry(nil, cdata.weapon,     composeWeaponsString() ))  
        table.insert(autoBriefing, composeEntry(cdata.allies_flight_title))       
        table.insert(autoBriefing, composeEntry(nil, cdata.allies_flight,     autobriefingutils.composeString(allies_list, '*') ))
		if mission.descriptionTbl == nil then
			table.insert(autoBriefing, composeEntry(cdata.description, nil,    mission.descriptionText))
			table.insert(autoBriefing, composeEntry(cdata.mission_goal,    nil, mission_goal))
		else
			if mission.descriptionTbl[coalitionName].situation and mission.descriptionTbl[coalitionName].situation ~= "" then
				table.insert(autoBriefing, composeEntry(cdata.SITUATION, nil,    mission.descriptionTbl[coalitionName].situation))
			end
			if mission.descriptionTbl[coalitionName].mission and mission.descriptionTbl[coalitionName].mission ~= "" then
				table.insert(autoBriefing, composeEntry(cdata.MISSION, nil,    mission.descriptionTbl[coalitionName].mission))
			end
			if mission.descriptionTbl[coalitionName].execution and mission.descriptionTbl[coalitionName].execution ~= "" then
				table.insert(autoBriefing, composeEntry(cdata.EXECUTION, nil,    mission.descriptionTbl[coalitionName].execution))
			end
			if mission.descriptionTbl[coalitionName].administration and mission.descriptionTbl[coalitionName].administration ~= "" then
				table.insert(autoBriefing, composeEntry(cdata.ADMIN, nil,    mission.descriptionTbl[coalitionName].administration))
			end
			if mission.descriptionTbl[coalitionName].command and mission.descriptionTbl[coalitionName].command ~= "" then
				table.insert(autoBriefing, composeEntry(cdata.COMMAND, nil,    mission.descriptionTbl[coalitionName].command))
			end			
		end	
        table.insert(autoBriefing, composeEntry(cdata.specification))
        table.insert(autoBriefing, composeEntry(nil, cdata.threat,     autobriefingutils.composeString(threats_list, '*') ))
        table.insert(autoBriefing, composeEntry(cdata.weather))
        table.insert(autoBriefing, composeEntry(nil, cdata.temperature,    string.format('%+d', mission.weather.season.temperature) .. '°' ))
        table.insert(autoBriefing, composeEntry(nil, _('QNH_brief','QNH'),    string.format('%d / %0.2f', mission.weather.qnh or 0, (mission.weather.qnh or 0) / 25.4)))
        table.insert(autoBriefing, composeEntry(nil, cdata.cloud_cover,    cdata.cloud_cover_base .. ' ' .. mission.weather.clouds.base))
        table.insert(autoBriefing, composeEntry(nil, cdata.wind,               windString))
        table.insert(autoBriefing, composeEntry(nil, cdata.turbulence,         turbulenceString))
        table.insert(autoBriefing, composeEntry(cdata.take_off_and_departure))
        table.insert(autoBriefing, composeEntry(nil,  cdata.mission_start,  autobriefingutils.composeDateString(startTime, false, mission.date)))
        table.insert(autoBriefing, composeEntry(nil,  nil,  tblStartGroups, true ))

    
    --traverseTable(autoBriefing)
    --traverseTable(mission)
end

-------------------------------------------------------------------------------
--генерация упрощенного автобрифинга
function generateSimpleAutoBriefing(mission)
    -- обновляем диалог редактирования брифинга для текущей загруженной миссии
    local currentTab = '  '
    local mission_goal
    autoBriefing = {}
    -- ветер
    local windString = UC.composeWindString(mission.weather)
    -- турбулентность
    local turbulenceString = UC.composeTurbulenceString(mission.weather)

    autoBriefing = {}
    table.insert(autoBriefing, composeEntry(cdata.title_data))   
    table.insert(autoBriefing, composeEntry(nil, cdata.title,      MissionModule.mission.sortie))
    table.insert(autoBriefing, composeEntry(nil, cdata.start,      autobriefingutils.composeDateString(mission.start_time, true, mission.date)))
    table.insert(autoBriefing, composeEntry(cdata.description, nil,    mission.descriptionText))
    table.insert(autoBriefing, composeEntry(cdata.weather))
    table.insert(autoBriefing, composeEntry(nil, cdata.temperature,    string.format('%+d', mission.weather.season.temperature) .. '°' ))
    table.insert(autoBriefing, composeEntry(nil, cdata.cloud_cover,    cdata.cloud_cover_base .. ' ' .. mission.weather.clouds.base))
    table.insert(autoBriefing, composeEntry(nil, cdata.wind,               windString))
    table.insert(autoBriefing, composeEntry(nil, cdata.turbulence,         turbulenceString))
    table.insert(autoBriefing, composeEntry(nil, cdata.general_visbility,  mission.weather.visibility.distance/1000 .. ' ' .. cdata.km_unit ))
    --base.U.traverseTable(autoBriefing)
end

-------------------------------------------------------------------------------
-- поиск самолетов заданной категории
-- на выходе таблица с ключами, соответствующими типам юнитов, и значениями, соответствующими
-- количеству юнитов данного типа
function getPlanesByCategory(categoryName)
    -- исчем CLSID нашей категории
    local category_clsid = ''
    for k,v in pairs(DB.db.Categories.PlaneCategories) do
        if v['Name'] == categoryName then 
            category_clsid = v['CLSID']
            break
        end
    end

    -- ищем CLSID plane'а
    local plane_clsid = {}
    for k,v in pairs(DB.db.Units.Planes.Plane) do
        local category = v['Categories']
        for k1,v1 in pairs(category) do
            if v1['CLSID'] == category_clsid then
                plane_clsid[v['CLSID']] = v['Name']
            end
        end
    end

    local planes_list = {}
    for k,v in pairs(MissionModule.unit_by_name) do
        local group = v.boss
        local country = group.boss
        local countryName = country.name
        local _coalition = country.boss
        if plane_clsid[v['CLSID']] and (coalition == _coalition) then
            if planes_list[v['type']] then 
                planes_list[v['type']] = planes_list[v['type']] + 1
            else 
                planes_list[v['type']] = 1
            end
        end
    end
    --traverseTable(planes_list)
    return planes_list
end

-------------------------------------------------------------------------------
-- формирование списка угроз
-- на выходе таблица с ключами, соответствующими типам юнитов, и значениями, соответствующими
-- количеству юнитов данного типа
function getThreats()
    local threats_list = {}
    for k,v in pairs(MissionModule.unit_by_name) do
        local group = v.boss
        local country = group.boss
        local _coalition = country.boss
        if coalition ~= _coalition then
            local threat = v
            if (not group.hidden) and (group.type ~= 'static') then
                if threats_list[v['type']] then 
                    threats_list[v['type']] = threats_list[v['type']] + 1
                else 
                    threats_list[v['type']] = 1
                end
            end
        end
    end
    return threats_list
end

-------------------------------------------------------------------------------
-- формирование списка союзников
-- на выходе таблица с ключами, соответствующими типам юнитов, и значениями, соответствующими
-- количеству юнитов данного типа
function getAllies()
    local allies_list = {}
    for k,v in pairs(MissionModule.unit_by_name) do
        local group = v.boss
        local country = group.boss
        local _coalition = country.boss
        if coalition == _coalition then
            local threat = v
            if (not group.hidden) and ((group.type == 'plane') or (group.type == 'helicopter')) and (group.units[1].skill ~= crutches.getPlayerSkill()) then
                if allies_list[v['type']] then 
                    allies_list[v['type']] = allies_list[v['type']] + 1
                else 
                    allies_list[v['type']] = 1
                end
            end
        end
    end
    return allies_list
end


-------------------------------------------------------------------------------
-- формирование строки со списком оружия
function composeWeaponsString()
    local weapons = {}
    for i,pylon in pairs(playerUnit.payload.pylons) do
		if pylon.CLSID ~= "<CLEAN>" and pylon.CLSID ~= "<CLEAN-200.5>" then
			local launcherCLSID = pylon.CLSID	
			local item			= base.get_weapon_display_name_by_clsid(launcherCLSID)
			if weapons[item] then
				weapons[item] = weapons[item] + 1
			else 
				weapons[item] = 1
			end  
		end
    end
    local str = {}
    for k,v in pairs(weapons) do
        table.insert(str,"'" .._(tostring(k)) .."'" .. '*' .. tostring(v))
    end
    if #str == 0 then
        str = cdata.noWeapon
    end
    return str
end


-------------------------------------------------------------------------------
--
function composeFriendsString()
    return alliesString
end


-------------------------------------------------------------------------------
--			Обработка действий контролов									 ---------------------------
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- обрабочик кнопки cancel
function cancelBtnOnChange()
    if not returnToME then
        base.panel_openfile.show(true, 'mainmenu', false)
    end
    
    if (returnScreen == 'campaign') then
        panel_campaign.returnFromAutobrief()
	elseif (returnScreen == 'mainmenu') then
		base.mmw.show(true)
    elseif (returnScreen == 'editor') or returnToME == true then
        base.setPlannerMission(false)
        base.MapWindow.show(true)
    end

    show(false)
end

-------------------------------------------------------------------------------
-- обрабочик кнопки Mission Editor
function missionEditorBtnOnChange()
	MapWindow.unselectAll()
    show(false, returnScreen)
    panel_campaign.show(false)
    panel_generator.show(false)
    panel_generator_simple.show(false)
	
    waitScreen.setUpdateFunction(function()
		base.setPlannerMission(true)

		base.MapWindow.show(true)	
		
		base.mmw.show(false)

		base.menubar.setPlannerMission(true)
		base.toolbar.setPlannerMission(true)

		doSave = true
	end)
end

-------------------------------------------------------------------------------
-- обрабочик кнопки fly
function flyBtnOnChange()
	base.menubar.show(false)
	base.toolbar.show(false)
	base.statusbar.show(false)
    base.mapInfoPanel.show(false)
	base.setCoordPanel.show(false)
    base.panel_route.show(false)
    music.stop()

    if MissionModule.checkMissionIntroduction() then
        Fly({command = '--track'})
    else    
        Fly({command = '--mission'})
    end
end


