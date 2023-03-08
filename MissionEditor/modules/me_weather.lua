local base = _G

module('me_weather')

local require = base.require
local table = base.table
local string = base.string
local pairs = base.pairs
local math = base.math
local tonumber = base.tonumber

-- Модули LuaGUI
local DialogLoader          = require('DialogLoader')
local ListBoxItem           = require('ListBoxItem')
local SwitchButton          = require('SwitchButton')
local MsgWindow             = require('MsgWindow')
local mod_mission           = require('me_mission')
local MapWindow             = require('me_map_window')
local dllWeather            = require('Weather')
local lfs                   = require('lfs')
local toolbar               = require('me_toolbar')
local S                     = require('Serializer')
local U                     = require('me_utilities')
local T                     = require('tools')
local i18n                  = require('i18n')
local OptionsData           = require('Options.Data')
local Terrain               = require('terrain')
local textutil        	  	= require('textutil')
local SkinUtils 			= require('SkinUtils')
local Gui                   = require('dxgui')
local Button 				= require('Button')
local Static            	= require('Static')
local DCS    				= require('DCS')
local magvar 				= require('magvar')
local UC					= require('utils_common')
local OptionsData			= require('Options.Data')

i18n.setup(_M)

local defaultPresetsPath = 'MissionEditor/data/scripts/weather/' -- путь к файлу переменных данных
local userPresetsPath = base.userDataDir..'weather/' -- путь к файлу переменных данных
local regimenStandard = 0
local regimenDynamic = 1
local defaultNames = {}
local numSeason = 3
local presetsClouds = {}
local presetsHalo = {}
local sunDeploy = false
local AtmRandParam = {}

local seasons = {
    _('SUMMER'), 
    _('WINTER'), 
    _('SPRING'), 
    _('AUTUMN'),
}

local precptnsList = {
    _('NONE'), 
    _('RAIN'), 
    _('THUNDERSTORM'), 
    _('SNOW'), 
    _('SNOWSTORM'),
}

local weatherTypes = {
    {name = _('W_CYCLONE','CYCLONE'),           id = 0},
    {name = _('W_ANTICYCLONE','ANTICYCLONE'),   id = 1},
    {name = _('W_NONE','NONE'),                 id = 2},
}

local defaultTimeByMonth = 
{
	[1] = 36000,
	[2] = 36000,
	[3] = 36000,
	[4] = 36000,
	[5] = 28800,
	[6] = 28800,
	[7] = 28800,
	[8] = 28800,
	[9] = 28800,
	[10] = 36000,
	[11] = 36000,
	[12] = 36000,

}

local cdata = 
{
    title       = _('TIME AND WEATHER'),
    check_fog   = _('FOG_ENABLE'),  
    standard    = _('W_STATIC', 'STATIC'),
    dynamic     = _('W_DYNAMIC', 'DYNAMIC'),
    conditions  = _("CONDITIONS"), 
    
    clouds = _('CLOUDS AND ATMOSPHERE'),
    base = _('BASE'),
    thickness = _('THICKNESS'),
    density = _('DENSITY'),
    precptns = _('PRECPTNS'), 
	preset = _('PRESET'), 
    qnh = _('QNH'),
    
    wind = _('WIND'), 
    speed = _('SPEED'), 
    dir = _('DIR'), 
    atGround    = _('at 10 m'),
    at2000      = _('at 2000 m'),
    at8000      = _('at 8000 m'),
    at500       = _('at 500 m'),
    atGroundI   = _('at 33 ft'),
    at2000I     = _('at 6600 ft'),
    at8000I     = _('at 26000 ft'),
    at500I      = _('at 1600 ft'),
    turbulence 	= _('TURBULENCE'),
    fog			= _('FOG'),
    visibility 	= _('VISIBILITY'),
	dust 		= _('DUST SMOKE'),
	check_dust 	= _('DUST SMOKE ENABLE'),  
	start 		= _('START'),
    
    dynamicWeather = _('DYNAMIC WEATHER'),
    baricSystem = _('BARIC SYSTEM'), 
    of = _('OF'),
    pressureExcess = _('PRESSURE EXCESS'),
    generate = _('GENERATE'),
    typeWeather = _('TYPE WEATHER'), 
	randomPreset  = _('Random preset'),  

    load = _('LOAD'),
    save = _('SAVE'),
    remove = _('REMOVE'),
    defaultWeather = _('DEFAULT WEATHER'),
        
    yes = _('YES'),
    no = _('NO'),
    turbSize = _('m/s').." * 0.1",
    ms = _('m/s'),
    m = _('m'),
	NOTHING = _('NOTHING'),
	ok = _('OK'),
	Cancel = _('CANCEL'),
	CLOUDSPRESET = _('CLOUDS PRESET'), 
	HALOPRESET = _('HALO PRESET'), 	
	SunAndMoon = _('Sun And Moon'),
	coords = _('Coords'),
	sunset = _('Sunset'),
	sunrise = _('Sunrise'),
	
	cyclones = _('Cyclones'),
	pressure_spread = _('Pressure spread'),
	ellipticity = _('Ellipticity'),
	pressure_excess = _('Pressure excess'),
	rotation = _('Rotation'),
	minusH = "-1 ".._("h"),
	plusH = "+1 ".._("h"),
	Appearance = _("APPEARANCE"),
	halo = _("ICE HALO"),
}

-- Переменные загружаемые/сохраняемые данные (путь к файлу - defaultPresetsPath)
vdata =
{
    season = {temperature = 20},
    clouds = {preset = nil, base = 300, thickness = 200, density = 0, iprecptns = 0},
	halo = {preset = 'off', crystalsPreset = nil},
    wind = {atGround = {speed = 0, dir = 0}, at2000 = {speed = 0, dir = 0}, at8000 = {speed = 0, dir = 0}},
    groundTurbulence = 0,
    visibility = {distance = 80000},
    enable_fog = false,
	enable_dust = false,
    fog = {thickness = 0, visibility = 0},
	dust_density = 0,
    qnh = 760,
    cyclones = {},
    type_weather = 0,
	modifiedTime = false,	
}

local start_time = 28800
local date = {Year = 1900 , Month  = 1 , Day = 1}
local selectedPresetClouds = nil
local pcItemsById = {}
local selectedPresetHalo = nil
local phItemsById = {}
local tblCyc = {}

defaultCyclone = 
{
    centerX = 0,	-- координаты центра циклона в метрах
    centerZ = 0,	-- координаты центра циклона в метрах   
    rotation = 0,	-- угол поворота циклона
    ellipticity = 1,	-- эллиптичность циклона
    pressure_excess = 100, -- смещение давления в центре циклона от "нормального"
    pressure_spread = 50, -- размер циклона
}

lfs.mkdir(userPresetsPath)
lfs.mkdir(userPresetsPath .. '/dynamic')

local windowWidth = 0
local windowHeight = 0

-------------------------------------------------------------------------------
-- получать дефолтные значения нужно только через эту функцию!
function getDefaultCyclone()
    local tmp_prop = {}
    U.copyTable(tmp_prop, defaultCyclone)
    tmp_prop.centerX, tmp_prop.centerZ = MapWindow.getCenterMap(windowWidth, 0) 
    return tmp_prop
end

-------------------------------------------------------------------------------
-- list of precptns types and their restrictions
local precptns = {
    {
        name = _('NONE'),
    },

    {
        name = _('RAIN'),
        minDensity = 5,
        minTemp = 0,
    },

    {
        name = _('THUNDERSTORM'),
        minDensity = 9,
        minTemp = 0,
    },

    {
        name = _('SNOW'), 
        minDensity = 5,
        maxTemp = 0,
    },
    
    {
        name = _('SNOWSTORM'), 
        minDensity = 9,
        maxTemp = 0,
    },
}


-------------------------------------------------------------------------------
-- temperature minimums and maximums
local temperatures = {
    [1] = { min = -50, max = 50 }, -- SUMMER
    [2] = { min = -50, max = 50 }, -- WINTER
    [3] = { min = -50, max = 50 }, -- SPRING
    [4] = { min = -50, max = 50 }, -- AUTUMN
}

function loadAllPresets(dynamic)
	local postfix
	if dynamic then postfix =  'dynamic/' else postfix = '' end
	
	presets = { }
    defaultNames = {}
	loadPresets(defaultPresetsPath .. postfix, true)
    loadPresets(userPresetsPath .. postfix)
    
    updatePresetsList()
end
-------------------------------------------------------------------------------
--
function applyTempRestrictions(doNotSave)
    local maxR = temperatures[numSeason].max
    local minR = temperatures[numSeason].min
    if Terrain.getTempratureRangeByDate then
        minR, maxR = Terrain.getTempratureRangeByDate(mod_mission.mission.date.Day, mod_mission.mission.date.Month)      
    end
    sp_temperature:setRange(minR, maxR)
    if not doNotSave then
        vdata.season.temperature = sp_temperature:getValue()
    end
end

-------------------------------------------------------------------------------
-- returns true if list contains value
function isInList(value, list)
    for k, v in pairs(list) do
        if v == value then
            return true
        end
    end
    return false
end


-------------------------------------------------------------------------------
-- returns list of available precptns
function getPrecptns(season, density, temp)
    local res = { }
    for k, v in pairs(precptns) do
        if (nil == v.minDensity) or (v.minDensity <= density) then
            if (nil == v.seasons) or isInList(season, v.seasons) then
                if (nil == v.minTemp) or (v.minTemp <= temp) then
                    if (nil == v.maxTemp) or (v.maxTemp >= temp) then
                        table.insert(res, v.name)
                    end
                end
            end
        end
    end
    return res
end


-------------------------------------------------------------------------------
-- update precptns combo
function updatePrecptns()
    local curPrecptns = precptnsList[vdata.clouds.iprecptns + 1]
    local season = seasons[numSeason]
    local density = vdata.clouds.density
    local temp = vdata.season.temperature

    local precptns = getPrecptns(season, density, temp)
    
    c_precptns:clear()
	
    for _k, v in pairs(precptns) do
		local item = ListBoxItem.new(v)
		
        c_precptns:insertItem(item)
		
		if v == curPrecptns then
			c_precptns:selectItem(item)
		end
    end
   
    if not isInList(curPrecptns, precptns) then
        vdata.clouds.iprecptns = 0
        c_precptns:setText(precptnsList[1])
    end
end


-------------------------------------------------------------------------------
-- add presets to presets combo box
-- set current preset to selected.  if selected is nil, selects default preset
function updatePresetsList(selected)
    local items = { }
    for displayName, _v in pairs(presets) do
        table.insert(items, displayName)
    end
    table.sort(items, U.listFirstComparator({cdata.defaultWeather}))
    U.fill_combo(c_presets, items)
    if not selected then
        selected = cdata.defaultWeather
    end
    
    c_presets:setText(selected)
end


-------------------------------------------------------------------------------
-- scan presets directory for presets
function loadPresets(dir, a_default)
    local displayName     
	for file in lfs.dir(dir) do
        local fullName = dir .. '/' .. file
        if 'file' == lfs.attributes(fullName).mode then
			local data = T.safeDoFile(fullName)
            local preset = data.vdata
            if preset then
                preset.fileName = fullName        
                if 'default.lua' == file then
                    displayName = cdata.defaultWeather
                else
                    displayName = i18n.getLocalizedValue(preset, "name")
                end
                
                fixTurbulence(preset)  

				if data.dtime then
					if data.dtime.date then
						preset.date = data.dtime.date
					end
					
					if data.dtime.start_time then
						preset.start_time = data.dtime.start_time
					end
				end	
				
				if preset.halo == nil then
					preset.halo = {preset = 'off', crystalsPreset = nil}
				end
                
                presets[displayName] = preset
                
                if a_default == true then
                    defaultNames[displayName] = displayName
                end
            end
        end
    end
    updatePresetsList(displayName)
	updatePresetHalo()
end

function showWarningMessageBox(text)
	MsgWindow.warning(text, _('WARNING'), 'OK'):show()
end

-------------------------------------------------------------------------------
-- save preset
-- if displayName already present, overwrite preset
-- if displayName is unique, create new preset
function savePreset(displayName)
    local preset = presets[displayName]
    if not preset then
        preset = U.copyTable(nil, vdata)
        preset.name = displayName
        local locale = i18n.getLocale()
        if (locale ~= 'en') then
            preset['name_'..locale] = displayName
        end
    
        if (vdata.atmosphere_type == regimenStandard) then        
            preset.fileName = userPresetsPath	.. '/' .. displayName .. '.lua'
        else
            preset.fileName = userPresetsPath .. '/dynamic/' .. displayName .. '.lua'
        end
        
        presets[displayName] = preset
        updatePresetsList(displayName)
    else
        preset.name = displayName
        local locale = i18n.getLocale()
        if (locale ~= 'en') then
            preset['name_'..locale] = displayName
        end
        preset.cyclones = {}
        U.copyTable(preset, vdata)
    end
	
	local dtime = {}
	dtime.date = mod_mission.mission.date
	dtime.start_time = mod_mission.mission.start_time
	
    local v = U.copyTable(nil, preset)
    v.fileName = nil
    local f = base.io.open(preset.fileName, 'w')
    if f then
        local s = S.new(f)
        s:serialize_simple('vdata', v)
		s:serialize_simple('dtime', dtime)
        f:close()
    else
		showWarningMessageBox(_('Error saving preset file'))
    end
end

-------------------------------------------------------------------------------
-- load preset into dialog
function loadPreset(displayName)
    local preset = presets[displayName]
    if not preset then
		showWarningMessageBox(_('Preset not found'))
    else
        if (vdata.atmosphere_type == regimenDynamic) then  
           delAllCyclone()
        end

		if preset.start_time then
			mod_mission.mission.start_time = preset.start_time
		end
		
		if preset.date then
			mod_mission.mission.date = preset.date
		end

		vdata.halo = nil
		U.copyTable(vdata, preset)
        vdata.fileName = nil
		vdata.start_time = nil
		vdata.date = nil
		
		if preset.enable_fog == nil then
			if vdata.fog.thickness == 0 then
				vdata.enable_fog = false
			else
				vdata.enable_fog = true
			end
		end
		
		if vdata.enable_fog == false then
			vdata.fog.thickness = 0
            vdata.fog.visibility = 0
		end
    end
    c_presets:setText(displayName)
    
    if (vdata.atmosphere_type == regimenDynamic) then         
        createCycloneVdata()
    end
    
    generateWinds()
    mod_mission.setWindsVisible(MapWindow.listWinds,true) 

    update()
end


-------------------------------------------------------------------------------
-- remove preset from disk
function removePreset(displayName)
    if displayName == cdata.defaultWeather then
		showWarningMessageBox(_("Can't delete default preset"))
        return
    end

    local preset = presets[displayName]
    if not preset then
		showWarningMessageBox(_('Preset not found'))
    else
        local handler = MsgWindow.question(_('Are you sure?'), _('QUESTION'), cdata.yes, cdata.no)
		
        function handler:onChange(buttonText)
            if buttonText == cdata.yes then
                base.os.remove(preset.fileName)
                presets[displayName] = nil
                updatePresetsList()
            end
        end
		
        handler:show()
    end
end

-------------------------------------------------------------------------------
-- returns true if preset name contatins allowed characters
function isValidPresetName(str)
    local len = string.len(str)
    if (0 >= len) or (60 < len) then
        return false
    end
    if (nil ~= string.find(str, '[%*/%?<>%|%\\%:%.%"]')) or 
                (0 == string.len(str))
    then
        return false
    else
        return true
    end
end

local function loadCloudsPresets()
	return base.dofile("Config/Effects/getCloudsPresets.lua")
end

local function loadHaloPresets()
	return base.dofile("Config/Effects/getHaloPresets.lua")
end

local function createRegimenPanel()
    c_regimen_stand = window.pDate.c_regimen_stand

    function c_regimen_stand:onShow()
        if (self:getState() == true) then        
            vdata.atmosphere_type = regimenStandard
            updateRegimen()   
            update()
        end
    end
    
    c_regimen_stand:setState(true)
    
    c_regimen_dyn = window.pDate.c_regimen_dyn

    function c_regimen_dyn:onShow()
        if (self:getState() == true) then        
            vdata.atmosphere_type = regimenDynamic
            updateRegimen() 
            generateCyclones() 			
        end
    end
	
	presetsClouds = loadCloudsPresets()
	presetsHalo = loadHaloPresets()
end

local function createSeasonPanel()
    season = box.season
    sp_temperature = season.sp_temperature

    function sp_temperature:onChange()
        vdata.season.temperature = self:getValue()
        updatePrecptns()
    end
end

function updateSeason(a_startTime, MissionDate, noUpdateTime)
    local mon, d, h, m, s = U.timeToMDHMS(a_startTime, MissionDate)

    if mon == 12 or mon <=2 then
        numSeason = 2 -- WINTER
    elseif mon >= 3 and mon <=5 then 
        numSeason = 3 -- SPRING
    elseif mon >= 6 and mon <=8 then
        numSeason = 1 -- SUMMER
    else
        numSeason = 4 -- AUTUMN
    end

	update(noUpdateTime)
	
    vdata.season.temperature = sp_temperature:getValue()
end

function createCloudsPanel()
    clouds = box.clouds
    sl_base = clouds.sl_base
    e_base = clouds.e_base
    e_baseUnitSpinBox = U.createUnitSpinBox(clouds.sBase, e_base, U.altitudeUnits, e_base:getRange())
	bPresetClouds = clouds.bPresetClouds
	bPresetClouds.onChange = onChange_bPresetClouds	
	
    function sl_base:onChange()
        local value = self:getValue()
        
        vdata.clouds.base = value
        e_baseUnitSpinBox:setValue(value)
    end
    
    function e_base:onChange()
        local value = e_baseUnitSpinBox:getValue()
        
        vdata.clouds.base = value
        sl_base:setValue(value)
    end
                
    sl_thickness = clouds.p_noPreset.sl_thickness
    e_thickness = clouds.p_noPreset.e_thickness
    e_thicknessUnitSpinBox = U.createUnitSpinBox(clouds.p_noPreset.sThickness, e_thickness, U.altitudeUnits, e_thickness:getRange())

    function sl_thickness:onChange()
        local value = self:getValue()
        
        vdata.clouds.thickness = value
        e_thicknessUnitSpinBox:setValue(value)
    end
                
    function e_thickness:onChange()
        local value = e_thicknessUnitSpinBox:getValue()

        vdata.clouds.thickness = value
        sl_thickness:setValue(value)
    end
    
    sp_density = clouds.p_noPreset.sp_density
    
    function sp_density:onChange()
        vdata.clouds.density = self:getValue()
        updatePrecptns()
    end
    
    c_precptns = clouds.p_noPreset.c_precptns
    
    function c_precptns:onChange()
        vdata.clouds.iprecptns = U.find(precptnsList, 
                self:getText()) - 1
    end

    sp_qnh = clouds.p_qnh.sp_qnh
    local minV, maxV = sp_qnh:getRange()
    sp_qnhUnitSpinBox = U.createUnitSpinBox(clouds.p_qnh.sQnh, sp_qnh, U.pressureUnits, minV, maxV, 0.01)
    
    function sp_qnh:onChange()
        local value = sp_qnhUnitSpinBox:getValue()
        vdata.qnh = value
    end
end

function createHaloPanel()
	pHalo = box.pHalo
	bPresetHalo = pHalo.bPresetHalo 
	bPresetHalo.onChange = onChange_bPresetHalo
	clIceHalo = pHalo.clIceHalo
	clIceHalo.onChange = onChange_clIceHalo
	
	local item = ListBoxItem.new(_("Off"))
	item.id = "off"
	clIceHalo:insertItem(item)
	if "off" == vdata.halo.preset then
		clIceHalo:selectItem(item)
	end

	item = ListBoxItem.new(_("Auto"))
	item.id = "auto"
	clIceHalo:insertItem(item)
	if "auto" == vdata.halo.preset then
		clIceHalo:selectItem(item)
	end
	
	for _k, v in pairs(presetsHalo.presets) do
		item = ListBoxItem.new(v.readableName)
		item.id = v.id
        clIceHalo:insertItem(item)
		
		if v.id == vdata.halo.preset then
			clIceHalo:selectItem(item)
		end
    end
	
end

function onChange_bPresetClouds()	
	wnd_cloud_presets:setVisible(true)
	
	local w, h = Gui.GetWindowSize()
	local x, y
	--base.print("--onChange_bPresetClouds--",w - windowWidth)
	if (w - windowWidth) < 1280 then
		x = 0		
	else
		x = w - windowWidth - 1280
	end
	
	if (h - U.top_toolbar_h) < 768 then		
		y = 0
	else
		y = U.top_toolbar_h
	end
	
	wnd_cloud_presets:setPosition(x, y)
	
	if pcItemsById[vdata.clouds.preset] then
		selectedPresetClouds = vdata.clouds.preset
		local x,y = pcItemsById[vdata.clouds.preset]:getPosition()
		sPresetClouds:setPosition(x,y)
		sPresetClouds:setTooltipText(pcItemsById[vdata.clouds.preset].tooltip)
	else
		selectedPresetClouds = nil
		sPresetClouds:setPosition(0,0)
		sPresetClouds:setTooltipText(cdata.NOTHING)
	end
end

function onChange_clIceHalo()
	local item = clIceHalo:getSelectedItem()
	vdata.halo.preset = item.id
	
	if item.id == "off" or item.id == "auto" then
		vdata.halo.crystalsPreset = nil
	else
		if vdata.halo.crystalsPreset == nil then
			local tmp = {}
			for id, preset in base.pairs(presetsHalo.crystalsPresets) do
				base.table.insert(tmp, preset)
			end	

			if #tmp == 0 then
				vdata.halo = {preset = 'off', crystalsPreset = nil}
			else
				vdata.halo.crystalsPreset = tmp[U.random(1, #tmp)].id
			end	
		end
	end
	
	wnd_halo_presets:setVisible(false)
	updatePresetHalo()
	resize()
end

function onChange_bPresetHalo()	
	wnd_halo_presets:setVisible(true)
	
	if phItemsById[vdata.halo.crystalsPreset] then
		selectedPresetHalo = vdata.halo.crystalsPreset
		local x,y = phItemsById[vdata.halo.crystalsPreset]:getPosition()
		sPresetHalo:setPosition(x,y)
		sPresetHalo:setTooltipText(phItemsById[vdata.halo.crystalsPreset].tooltip)
	end
end

function updatePresetClouds()
	if presetsClouds ~= nil then
		for k,v in base.pairs(presetsClouds) do
			if k == vdata.clouds.preset then
				setCurPresetClouds(k, false)
				return
			end
		end
	end
	setCurPresetClouds(nil, false)
end

function updatePresetHalo()
	for i=0,clIceHalo:getItemCount()-1,1 do
		local item=clIceHalo:getItem(i)
		if item.id == vdata.halo.preset then
			clIceHalo:selectItem(clIceHalo:getItem(i))
			break
		end
	end

	if presetsHalo ~= nil then
		for k,v in base.pairs(presetsHalo.crystalsPresets) do
			if k == vdata.halo.crystalsPreset then
				setCurCrystalsPresetHalo(k)
				return
			end
		end
	end
	setCurCrystalsPresetHalo(nil)
end

function setCurPresetClouds(a_preset, a_bSetDefault)
	local fileImage 
	if a_preset and presetsClouds[a_preset] then
		if presetsClouds[a_preset].thumbnailName and presetsClouds[a_preset].thumbnailName ~= '' then
			fileImage = presetsClouds[a_preset].thumbnailName
		else
			fileImage = 'bazar/effects/clouds/thumbnails/empty.png'
		end
		bPresetClouds:setSkin(bPresetSkin)
		bPresetClouds:setSkin(SkinUtils.setButtonPicture(fileImage, bPresetClouds:getSkin()))
		bPresetClouds:setText(presetsClouds[a_preset].readableNameShort or presetsClouds[a_preset].id)		
		bPresetClouds:setTooltipText(presetsClouds[a_preset].tooltip)
	else	
		bPresetClouds:setSkin(bNothingSkin)
		bPresetClouds:setSkin(SkinUtils.setButtonPicture("", bPresetClouds:getSkin()))
		bPresetClouds:setText(cdata.NOTHING)
		bPresetClouds:setTooltipText(cdata.NOTHING)
	end
	bPresetClouds:setTooltipSkin(sTooltipSkin)
	vdata.clouds.preset = a_preset
	
	if vdata.clouds.preset == nil then
		sl_base:setRange(300, 5000)
		e_baseUnitSpinBox:setRange(300, 5000)
		sl_base:setEnabled(true)
		e_baseUnitSpinBox:setEnabled(true)
		sl_base:setValue(vdata.clouds.base)
		e_baseUnitSpinBox:setValue(vdata.clouds.base)				
	else
		local preset = presetsClouds[vdata.clouds.preset]
		if preset and preset.presetAltMin ~= nil and preset.presetAltMax ~= nil then
			if preset.presetAltMin == -1 or preset.presetAltMax == -1 then
				sl_base:setEnabled(false)
				e_baseUnitSpinBox:setEnabled(false)
			else
				sl_base:setEnabled(true)
				e_baseUnitSpinBox:setEnabled(true)
				sl_base:setRange(preset.presetAltMin, preset.presetAltMax)
				e_baseUnitSpinBox:setRange(preset.presetAltMin, preset.presetAltMax)
				sl_base:setValue(vdata.clouds.base)
				e_baseUnitSpinBox:setValue(vdata.clouds.base)
				
				if a_bSetDefault == true and preset.layers[1] then
					sl_base:setValue(preset.layers[1].altitudeMin or preset.presetAltMin)
					e_baseUnitSpinBox:setValue(preset.layers[1].altitudeMin or preset.presetAltMin)
				end
			end
		end
	end
	vdata.clouds.base = sl_base:getValue()	
	
	resize()
end

function setCurCrystalsPresetHalo(a_preset)
	local fileImage 
	if a_preset and presetsHalo.crystalsPresets[a_preset] then
		if presetsHalo.crystalsPresets[a_preset].thumbnailName and presetsHalo.crystalsPresets[a_preset].thumbnailName ~= '' then
			fileImage = presetsHalo.crystalsPresets[a_preset].thumbnailName
		else
			fileImage = 'bazar/effects/clouds/thumbnails/empty.png'
		end
		bPresetHalo:setSkin(bPresetSkin)
		bPresetHalo:setSkin(SkinUtils.setButtonPicture(fileImage, bPresetHalo:getSkin()))
		bPresetHalo:setText(presetsHalo.crystalsPresets[a_preset].readableNameShort or presetsHalo.crystalsPresets[a_preset].id)		
		bPresetHalo:setTooltipText(presetsHalo.crystalsPresets[a_preset].tooltip)
	end
	bPresetHalo:setTooltipSkin(sTooltipSkin)
	vdata.halo.crystalsPreset = a_preset
end

function resize()
	local preset = presetsClouds[vdata.clouds.preset]
	local offset = 0
	local sizeHaloH = 200 
	
	if preset then
		clouds.p_noPreset:setVisible(false)
		offset = -72
	else
		--пресет не выбран
		clouds.p_noPreset:setVisible(true)
	end
	
	if vdata.halo.preset == "off" or vdata.halo.preset == "auto" then
		sizeHaloH = 50
	end
	
	clouds.p_qnh:setPosition(0, 255+offset)
	clouds:setSize(410, 282+offset)
	pHalo:setBounds(0, 344+offset, 410, sizeHaloH)
	wind:setPosition(0,344+offset+sizeHaloH)  
	turbulence:setPosition(0,593+offset+sizeHaloH)      
	fog:setPosition(0,645+offset+sizeHaloH) 
	pDust:setPosition(0,746+offset+sizeHaloH) 
	box.pPresets:setPosition(0,852+offset+sizeHaloH)  

	box:updateWidgetsBounds()
end

local function createWindPanel()
    wind = box.pWind
    pWindM =  wind.pWindM
    pWindI =  wind.pWindI
    
    sp_wind_500 = wind.sp_wind_500
    sp_wind_500UnitSpinBox = U.createUnitSpinBox(wind.sWind500, sp_wind_500, U.speedUnitsWind, sp_wind_500:getRange())
    
    e_wind_500  = wind.e_wind_500
    e_wind_ground = wind.e_wind_ground
	
    sp_wind_ground = wind.sp_wind_ground
    sp_wind_groundUnitSpinBox = U.createUnitSpinBox(wind.sWindGround, sp_wind_ground, U.speedUnitsWind, sp_wind_ground:getRange())

	function sp_wind_ground:onChange()
        vdata.wind.atGround.speed = sp_wind_groundUnitSpinBox:getValue()
		local speed, dir = dllWeather.updateSpeedDirForOtherLevel(11, 500, vdata.wind.atGround.speed, vdata.wind.atGround.dir)
        sp_wind_500UnitSpinBox:setValue(speed)
        e_wind_500:setValue(base.math.floor(dir+0.5))
    end
    
	d_wind_ground = wind.d_wind_ground
	
    function d_wind_ground:onChange()
        local value = self:getValue()
        vdata.wind.atGround.dir = value
        e_wind_ground:setValue(value)
		local speed, dir = dllWeather.updateSpeedDirForOtherLevel(11, 500, vdata.wind.atGround.speed, vdata.wind.atGround.dir)
		sp_wind_500UnitSpinBox:setValue(speed)
        e_wind_500:setValue(base.math.floor(dir+0.5))
    end
    	    
	function e_wind_ground:onChange()
        local value = self:getValue()
		
		if value == -1 then
			value = 359
			self:setValue(value)
		elseif value == 360 then
			value = 0
			self:setValue(value)
		end
		
        vdata.wind.atGround.dir = value
        d_wind_ground:setValue(value)
		local speed, dir = dllWeather.updateSpeedDirForOtherLevel(11, 500, vdata.wind.atGround.speed, vdata.wind.atGround.dir)
		sp_wind_500UnitSpinBox:setValue(speed)
        e_wind_500:setValue(base.math.floor(dir+0.5))
    end
    	
    function sp_wind_500:onChange()
		local speed, dir = dllWeather.updateSpeedDirForOtherLevel(500, 11, sp_wind_500UnitSpinBox:getValue(), e_wind_500:getValue())
        vdata.wind.atGround.speed = speed
        vdata.wind.atGround.dir = dir
        
        sp_wind_groundUnitSpinBox:setValue(vdata.wind.atGround.speed)        
        e_wind_ground:setValue(vdata.wind.atGround.dir)
        d_wind_ground:setValue(vdata.wind.atGround.dir)
    end

    sp_wind_2000 = wind.sp_wind_2000
    sp_wind_2000UnitSpinBox = U.createUnitSpinBox(wind.sWind2000, sp_wind_2000, U.speedUnitsWind, sp_wind_2000:getRange())
    
    function sp_wind_2000:onChange()
        vdata.wind.at2000.speed = sp_wind_2000UnitSpinBox:getValue()
    end
                
    d_wind_2000 = wind.d_wind_2000
    
    function d_wind_2000:onChange()
        local value = self:getValue()
        
        vdata.wind.at2000.dir = value
        e_wind_2000:setValue(value)
    end

    e_wind_2000 = wind.e_wind_2000
    
    function e_wind_2000:onChange()
        local value = self:getValue()
		
		if value == -1 then
			value = 359
			self:setValue(value)
		elseif value == 360 then
			value = 0
			self:setValue(value)
		end
        
        vdata.wind.at2000.dir = value
        d_wind_2000:setValue(value)
    end
                
    sp_wind_8000 = wind.sp_wind_8000
    sp_wind_8000UnitSpinBox = U.createUnitSpinBox(wind.sWind8000, sp_wind_8000, U.speedUnitsWind, sp_wind_8000:getRange())
    
    function sp_wind_8000:onChange()
        vdata.wind.at8000.speed = sp_wind_8000UnitSpinBox:getValue()
    end

    d_wind_8000 = wind.d_wind_8000
    
    function d_wind_8000:onChange()
        local value = self:getValue()
        
        vdata.wind.at8000.dir = value
        e_wind_8000:setValue(value)
    end
    
    e_wind_8000 = wind.e_wind_8000
    
    function e_wind_8000:onChange()
        local value = self:getValue()
		
		if value == -1 then
			value = 359
			self:setValue(value)
		elseif value == 360 then
			value = 0
			self:setValue(value)
		end
        
        vdata.wind.at8000.dir = value
        d_wind_8000:setValue(value)
    end    

    resize()
end    

local function createTurbulencePanel()
    turbulence = box.turbulence
    sp_turb_ground = turbulence.sp_turb_ground
    sp_turb_groundUnitSpinBox = U.createUnitSpinBox(turbulence.sTurb, sp_turb_ground, U.altitudeUnits, sp_turb_ground:getRange())
    
    function sp_turb_ground:onChange()
        vdata.groundTurbulence = sp_turb_groundUnitSpinBox:getValue()
    end
end

local function createFogPanel()
    fog = box.fog
    c_enable_fog = fog.c_enable_fog    
    
    function c_enable_fog:onChange()
        vdata.enable_fog = self:getState()

		if (vdata.enable_fog == false) then
            vdata.fog.thickness = 0
            vdata.fog.visibility = 0
        end
		
        update()
    end
                
    sl_fog_vis = fog.sl_fog_vis

    function sl_fog_vis:onChange()
        local value = self:getValue()
        
        vdata.fog.visibility = value
        e_fog_visUnitSpinBox:setValue(value)
    end
     
    e_fog_vis = fog.e_fog_vis
    e_fog_visUnitSpinBox = U.createUnitSpinBox(fog.sFog_vis, e_fog_vis, U.altitudeUnits, e_fog_vis:getRange())
    
    function e_fog_vis:onChange()
        local value = e_fog_visUnitSpinBox:getValue()
        
        vdata.fog.visibility = value
        sl_fog_vis:setValue(value)
    end    
    
    sl_fog_thickness = fog.sl_fog_thickness

    function sl_fog_thickness:onChange()
        local value = self:getValue()
        
        vdata.fog.thickness = value
        e_fog_thicknessUnitSpinBox:setValue(value)
    end
     
    e_fog_thickness = fog.e_fog_thickness
    e_fog_thicknessUnitSpinBox = U.createUnitSpinBox(fog.sFog_thickness, e_fog_thickness, U.altitudeUnits, e_fog_thickness:getRange())
    
    function e_fog_thickness:onChange()
        local value = e_fog_thicknessUnitSpinBox:getValue()

        vdata.fog.thickness = value
        sl_fog_thickness:setValue(value)
    end
end

local function createDustPanel()
    pDust = box.pDust
    c_enable_dust = pDust.c_enable_dust    
    
    function c_enable_dust:onChange()
        vdata.enable_dust = self:getState()
        if (vdata.enable_dust == false) then
            vdata.dust_density = 0
		elseif vdata.dust_density < 300 then
			vdata.dust_density = 300
        end
        update()
    end
                
    sl_dust_vis = pDust.sl_dust_vis

    function sl_dust_vis:onChange()
        local value = self:getValue()
        
        vdata.dust_density = value
        e_dust_visUnitSpinBox:setValue(value)
    end
     
    e_dust_vis = pDust.e_dust_vis
    e_dust_visUnitSpinBox = U.createUnitSpinBox(pDust.sDust_vis, e_dust_vis, U.altitudeUnits, e_dust_vis:getRange())
    
    function e_dust_vis:onChange()
        local value = e_dust_visUnitSpinBox:getValue()
        
        vdata.dust_density = value
        sl_dust_vis:setValue(value)
    end    
end

local function createPresetsPanel()
    c_presets = box.pPresets.c_presets
    U.fill_combo(c_presets, precptnsList)
    box.pPresets.b_savePreset:setEnabled(false)

    function c_presets:onChange()       
        if defaultNames[c_presets:getText()] ~= nil then
            box.pPresets.b_savePreset:setEnabled(false)
        else
            box.pPresets.b_savePreset:setEnabled(true)
        end
    end    
   
    function box.pPresets.b_loadPreset:onChange()
        loadPreset(c_presets:getText())
    end

    function box.pPresets.b_savePreset:onChange()
        -- remove leading and trailing spaces from string
        local name = string.gsub(string.gsub(c_presets:getText(), '^%s+', ''), '%s+$', '')
        
        if not isValidPresetName(name) then
			showWarningMessageBox(_('Invalid file name'))
        else
            savePreset(name)
            c_presets:setText(name)
        end
    end

    function box.pPresets.b_removePreset:onChange()
        removePreset(c_presets:getText())
		if defaultNames[c_presets:getText()] ~= nil then
            box.pPresets.b_savePreset:setEnabled(false)
        else
            box.pPresets.b_savePreset:setEnabled(true)
        end
    end
	
	b_randomPreset = box.pPresets.b_randomPreset
	
	function b_randomPreset:onChange()
		local num = c_presets:getItemCount()
		local randomNum = U.random(0, num-1)
		local item = c_presets:getItem(randomNum)
		loadPreset(item:getText())
	end
end

local function createDynamicWeatherPanel()
    dynamic = box.dynamic
    dynamic:setPosition(clouds:getPosition())
    
    c_type_weather = dynamic.c_type_weather
    
    U.fill_comboListIDs(c_type_weather, weatherTypes)
	
    function c_type_weather:onChange(item)
        vdata.type_weather = item.itemId  
        generateCyclones()
        update()    
    end
    
    s_cyclones = dynamic.s_cyclones

    function s_cyclones:onChange()
        MapWindow.setSelectedObject(vdata.cyclones[s_cyclones:getValue()].groupId)
        update()
    end
    
    s_cyclonesof = dynamic.s_cyclonesof

    function s_cyclonesof:onChange()
        generateCyclones()
        update()
    end
    
    sp_pressure_excess = dynamic.sp_pressure_excess

    function sp_pressure_excess:onChange()
        vdata.cyclones[s_cyclones:getValue()].pressure_excess = self:getValue() 
        mod_mission.setCyclonesVisible(vdata.cyclones, true) 
        generateWinds()
        mod_mission.setWindsVisible(MapWindow.listWinds, true)    
    end
    
    function dynamic.b_generate:onChange()
        generateCyclones()
    end
end

-------------------------------------------------------------------------------
--очищаем список циклонов
function clearCyclones()
	MapWindow.listWinds = {}
    vdata.cyclones = {}
end

-------------------------------------------------------------------------------
-- Создание и размещение виджетов
-- Префиксы названий виджетов: t - text, b - button, c - combo, sp - spin, sl - slider, e - edit, d - dial 
function create(x, y, w, h)
    windowWidth = w;
	windowHeight = h
    
    window = DialogLoader.spawnDialogFromFile("MissionEditor/modules/dialogs/me_weather_panel.dlg", cdata)
    window:setBounds(x, y, w, h)
	
	wnd_cloud_presets 	= DialogLoader.spawnDialogFromFile("MissionEditor/modules/dialogs/me_cloud_presets.dlg", cdata)
	wnd_halo_presets 	= DialogLoader.spawnDialogFromFile("MissionEditor/modules/dialogs/me_halo_presets.dlg", cdata)
	
	local wWin, hWin = Gui.GetWindowSize()
	wnd_halo_presets:setPosition(wWin-U.right_toolbar_width-802, 320)
    
        
    function window:onClose()
        show(false)
        toolbar.setWeatherButtonState(false)
    end
        
    createRegimenPanel()
    
    box = window.box
    box:setSize(w, h-137)	
	
	pDate = window.pDate
	cb_month = pDate.cb_month
	editBoxDays = pDate.editBoxDays
	editBoxYear = pDate.eYear
	editBoxHours = pDate.editBoxHours
	editBoxMinutes = pDate.editBoxMinutes
	editBoxSeconds = pDate.editBoxSeconds
	hsTime = pDate.hsTime
	bMinusH = pDate.bMinusH
	bPlusH = pDate.bPlusH
	pNoVisibleW = window.pNoVisibleW
	pSun = pDate.pSun
	bDeploy = pSun.bDeploy
	pCont	= pSun.pCont
	chart = pCont.chart
	eCoords = pCont.eCoords
	sSun = pCont.sSun
	sMoon = pCont.sMoon
	sText = pCont.sText
	spCyclones = box.dynamic.spCyclones
	pCycTmpl = pNoVisibleW.pCycTmpl
	eSunrise = pCont.eSunrise
	eSunset = pCont.eSunset
	
	bExpandSkin 		= pNoVisibleW.bExpand:getSkin()
	bRollupSkin			= pNoVisibleW.bRollup:getSkin()	
	sMoon0Skin			= pNoVisibleW.sMoon0:getSkin()	
	sMoon1Skin			= pNoVisibleW.sMoon1:getSkin()	
	sMoon2Skin			= pNoVisibleW.sMoon2:getSkin()	
	sMoon3Skin			= pNoVisibleW.sMoon3:getSkin()	
	sMoon4Skin			= pNoVisibleW.sMoon4:getSkin()	
	sMoon5Skin			= pNoVisibleW.sMoon5:getSkin()	
	sMoon6Skin			= pNoVisibleW.sMoon6:getSkin()	
	sMoon7Skin			= pNoVisibleW.sMoon7:getSkin()	
	
	bDeploy.onChange = onChange_bDeploy
	hsTime.onChange = onChange_hsTime
	bMinusH.onChange = onChange_bMinusH
	bPlusH.onChange = onChange_bPlusH
	
	U.fillComboMonths(cb_month)
    
    U.bindDataTimeCallback(editBoxYear, cb_month, editBoxHours, editBoxMinutes, editBoxSeconds, editBoxDays, callback_updateMissionStart)
	
	U.randomseed()
	
    createSeasonPanel()
    createCloudsPanel()
	createHaloPanel()
        
    createTurbulencePanel()
    createFogPanel()
	createDustPanel()
    createPresetsPanel()
    createDynamicWeatherPanel()
    
    createWindPanel()
	createPresetsCloudsPanel()
	createPresetsHaloPanel()

    box:updateWidgetsBounds()
	
	    
    AtmRandParam.InitAngle          = 2 * math.pi * U.random()
    AtmRandParam.Distance           = 950000
    AtmRandParam.DistanceStdDev     = 150000
    AtmRandParam.Spread             = 900000
    AtmRandParam.SpreadStdDev       = 150000
    AtmRandParam.PressureOffset     = 1200
    AtmRandParam.PressureStdDev     = 500
    AtmRandParam.EllipticityStdDev  = 0.25
    AtmRandParam.RotationStdDev     = 1.0471975511965977461542144610932
	

end
	

	
-------------------------------------------------------------------------------
-- Открытие/закрытие панели
function show(b)
	window:setVisible(b)
	
    if b then
        updateUnitSystem()
		loadAllPresets(vdata.atmosphere_type == regimenDynamic)

        if vdata.atmosphere_type == regimenDynamic then
            generateWinds() 
        end        
        update()     
        updateRegimen()   
		editBoxDays:setFocused(true)
		editBoxDays:setSelectionNew(0, 0, 0, editBoxDays:getLineTextLength(0))
    else
        mod_mission.setCyclonesVisible(vdata.cyclones, false) 
        mod_mission.setWindsVisible(MapWindow.listWinds, false)
        dllWeather.initAtmospere(vdata)
		wnd_cloud_presets:setVisible(false)
		wnd_halo_presets:setVisible(false)
    end
end

function resetModifiedTime()
	vdata.modifiedTime = false
end

function callback_updateMissionStart(time, date, editMonth)
	updateMissionStart(time, date, editMonth)
	hsTime:setValue(mod_mission.mission.start_time/300)
end

-------------------------------------------------------------------------------
-- set start time
function updateMissionStart(time, date, editMonth)
    mod_mission.mission.date = date
	
	if vdata.modifiedTime == false and editMonth == "month" then
		time = defaultTimeByMonth[date.Month]
		U.setDataTime(editBoxYear, cb_month, editBoxHours, editBoxMinutes, editBoxSeconds, editBoxDays, time, date)
	end
	
	if editMonth == "time" then
		vdata.modifiedTime = true
	end
	
    mod_mission.mission.start_time = time
    updateSeason(time, date, true)
end

-------------------------------------------------------------------------------
--
function setItemTypeWeather(a_id)
	for i=0, 2 do
		local wid = c_type_weather:getItem(i)
		if wid.itemId == a_id then		
			c_type_weather:selectItem(wid)
		end
	end	
end

-------------------------------------------------------------------------------
-- Обновление значений виджетов после изменения таблицы vdata
function update(noUpdateTime)
    vdata.cyclones = vdata.cyclones or {} -- чтобы непадали старые миссии
	date = mod_mission.mission.date
    start_time = mod_mission.mission.start_time or 28800
	
	magvar.init(mod_mission.mission.date.Month, mod_mission.mission.date.Year)
     	
    if (vdata.atmosphere_type == regimenStandard) then   
        c_regimen_stand:setState(true)  
    else
        c_regimen_dyn:setState(true)
    end
      
    if not vdata.qnh then
        vdata.qnh = 760
    end
    --c_season:setText(seasons[vdata.season.iseason]) 
    applyTempRestrictions(true)
    sp_temperature:setValue(vdata.season.temperature)
    sl_base:setValue(vdata.clouds.base)
	updatePresetClouds()
	updatePresetHalo()
    e_baseUnitSpinBox:setValue(vdata.clouds.base)
    sl_thickness:setValue(vdata.clouds.thickness)
    e_thicknessUnitSpinBox:setValue(vdata.clouds.thickness)
    sp_density:setValue(vdata.clouds.density)
    c_precptns:setText(precptnsList[vdata.clouds.iprecptns + 1])
    sp_qnhUnitSpinBox:setValue(vdata.qnh)
    sp_wind_groundUnitSpinBox:setValue(vdata.wind.atGround.speed)
    d_wind_ground:setValue(vdata.wind.atGround.dir)
    e_wind_ground:setValue(tonumber(vdata.wind.atGround.dir))
	
    local simSpeed500, simDir500 = dllWeather.updateSpeedDirForOtherLevel(11, 500, vdata.wind.atGround.speed, vdata.wind.atGround.dir)
    sp_wind_500UnitSpinBox:setValue(simSpeed500)
    e_wind_500:setValue(base.math.floor(simDir500+0.5))
	
    sp_wind_2000UnitSpinBox:setValue(vdata.wind.at2000.speed)
    d_wind_2000:setValue(vdata.wind.at2000.dir)
    e_wind_2000:setValue(vdata.wind.at2000.dir)
    sp_wind_8000UnitSpinBox:setValue(vdata.wind.at8000.speed)
    d_wind_8000:setValue(vdata.wind.at8000.dir)
    e_wind_8000:setValue(vdata.wind.at8000.dir)
    sp_turb_groundUnitSpinBox:setValue(vdata.groundTurbulence)
    sl_fog_thickness:setValue(vdata.fog.thickness)
    e_fog_thicknessUnitSpinBox:setValue(vdata.fog.thickness)
    sl_fog_vis:setValue(vdata.fog.visibility)
    e_fog_visUnitSpinBox:setValue(vdata.fog.visibility)
	sl_dust_vis:setValue(vdata.dust_density)
    e_dust_visUnitSpinBox:setValue(vdata.dust_density)
    updatePrecptns()
    
    c_enable_fog:setState(vdata.enable_fog)
    
    if (vdata.enable_fog == true) then
        sl_fog_thickness:setEnabled(true)
        e_fog_thickness:setEnabled(true)
        sl_fog_vis:setEnabled(true)
        e_fog_vis:setEnabled(true)
		sl_dust_vis:setEnabled(true)
        e_dust_vis:setEnabled(true)
    else
        sl_fog_thickness:setEnabled(false)
        e_fog_thickness:setEnabled(false)
        sl_fog_vis:setEnabled(false)
        e_fog_vis:setEnabled(false)
		sl_dust_vis:setEnabled(false)
        e_dust_vis:setEnabled(false)
    end
	
	c_enable_dust:setState(vdata.enable_dust)
	
	if (vdata.enable_dust == true) then
		sl_dust_vis:setEnabled(true)
        e_dust_vis:setEnabled(true)
    else
		sl_dust_vis:setEnabled(false)
        e_dust_vis:setEnabled(false)
    end
    
    if (vdata.atmosphere_type == regimenDynamic) then    
        s_cyclonesof:setValue(#vdata.cyclones)
        s_cyclones:setRange(1, #vdata.cyclones)  

		setItemTypeWeather(vdata.type_weather)	
        
        if (#vdata.cyclones > 0) then
            sp_pressure_excess:setValue(vdata.cyclones[s_cyclones:getValue()].pressure_excess)
        end		      
    end
    
	if window and noUpdateTime ~= true then
		U.setDataTime(editBoxYear, cb_month, editBoxHours, editBoxMinutes, editBoxSeconds, editBoxDays, start_time, date)
		hsTime:setValue(start_time/300)
	end	
	
    if window == nil or window:getVisible() == false or (vdata.atmosphere_type == regimenStandard) then   
        mod_mission.setCyclonesVisible(vdata.cyclones, false)    
        mod_mission.setWindsVisible(MapWindow.listWinds, false)
    else		
        mod_mission.setCyclonesVisible(vdata.cyclones, true)
        mod_mission.setWindsVisible(MapWindow.listWinds,true)  
    end	

	if sunDeploy == true then
		pCont:setVisible(true)
		pDate:setSize(415, 420)
		pSun:setSize(415, 290)
		box:setBounds(0, 430, windowWidth, windowHeight-460)
		c_regimen_stand:setPosition(0,390)
		c_regimen_dyn:setPosition(210,390)
		updateSunMoon()
	else
		pCont:setVisible(false)
		pDate:setSize(415, 170)
		pSun:setSize(415, 40)
		box:setBounds(0, 180, windowWidth, windowHeight-210)
		c_regimen_stand:setPosition(0, 140)
		c_regimen_dyn:setPosition(210, 140)
	end
	
	updateDataCyclones()
	resize()
end

function updateDataCyclones()
	spCyclones:clear()
	tblCyc = {}
	
	local offsetY = 0
	for k,v in base.ipairs(vdata.cyclones) do
		local pCyc = pCycTmpl:clone()  
		pCyc:setVisible(true)
		calcLimits(pCyc, k) 
		
		pCyc.spX:setValue(v.centerX)
		pCyc.spY:setValue(v.centerZ)		
		pCyc.spSpread:setValue(v.pressure_spread)
		pCyc.spEllipticity:setValue(v.ellipticity)
		pCyc.spExcess:setValue(v.pressure_excess)
		pCyc.spRotation:setValue(v.rotation)
		pCyc:setPosition(0,offsetY)
		
		pCyc.spX.index = k
		pCyc.spY.index = k	
		pCyc.spSpread.index = k
		pCyc.spEllipticity.index = k
		pCyc.spExcess.index = k
		pCyc.spRotation.index = k
		
		pCyc.spX:addChangeCallback(onChange_spX)
		pCyc.spY:addChangeCallback(onChange_spY)
		pCyc.spSpread:addChangeCallback(onChange_spSpread)
		pCyc.spEllipticity:addChangeCallback(onChange_spEllipticity)
		pCyc.spExcess:addChangeCallback(onChange_spExcess)
		pCyc.spRotation:addChangeCallback(onChange_spRotation)
		
		spCyclones:insertWidget(pCyc)
		
		offsetY = offsetY + 160
		tblCyc[k] = pCyc
	end
	spCyclones:updateWidgetsBounds()
end

function calcLimits(a_pCyc, a_k) 
	if centerWeather == nil then
		return
	end
	local minSign
	local maxSign
	local MainPeakExcessModifier
	local randomNormalsMin = {-5.67769,-5.67769,-5.67769,-5.67769,-5.67769,-5.67769}
	local randomNormalsMax = {5.67769,5.67769,5.67769,5.67769,5.67769,5.67769}
	local minX
	local maxX
	local minZ
	local maxZ
	
	if a_k == 1 then
		if (vdata.type_weather == weatherTypes[3].id) then
			minSign = -1
			maxSign = 1
	 	else	
			if (vdata.type_weather == weatherTypes[1].id) then    		
				minSign = -1
				maxSign = -1
			else
				minSign = 1
				maxSign = 1
			end	
		end	
	else
		minSign = -1
		maxSign = 1
	end

	if (vdata.type_weather == weatherTypes[3].id)
        or ((vdata.type_weather ~= weatherTypes[3].id) and (a_k ~= 1)) then
        MainPeakExcessModifier = 1		
		minX = centerWeather.x-(AtmRandParam.Distance + AtmRandParam.DistanceStdDev * randomNormalsMax[2])
		maxX = centerWeather.x+(AtmRandParam.Distance + AtmRandParam.DistanceStdDev * randomNormalsMax[2])
		minZ = centerWeather.y-(AtmRandParam.Distance + AtmRandParam.DistanceStdDev * randomNormalsMax[2])
		maxZ = centerWeather.y+(AtmRandParam.Distance + AtmRandParam.DistanceStdDev * randomNormalsMax[2])
		
	else
		MainPeakExcessModifier = 0.22
		minX = centerWeather.x-(AtmRandParam.DistanceStdDev * MainPeakExcessModifier * randomNormalsMax[2])
		maxX = centerWeather.x+(AtmRandParam.DistanceStdDev * MainPeakExcessModifier * randomNormalsMax[2])
		minZ = centerWeather.y-(AtmRandParam.DistanceStdDev * MainPeakExcessModifier * randomNormalsMax[2])
		maxZ = centerWeather.y+(AtmRandParam.DistanceStdDev * MainPeakExcessModifier * randomNormalsMax[2])
	end	
	
	AtmRandParam.Sign = minSign
	local minSpread 	= calcPressureSpread(AtmRandParam, randomNormalsMin, MainPeakExcessModifier, vdata.type_weather) 
	local minExcess 	= calcPressureExcess(AtmRandParam, randomNormalsMax, MainPeakExcessModifier) --randomNormalsMax не ошибка
	local minRotation	= calcRotation(AtmRandParam, randomNormalsMin)
	local minEllipticity= calcEllipticity(AtmRandParam, randomNormalsMin)
	
	AtmRandParam.Sign = maxSign
	local maxSpread 	= calcPressureSpread(AtmRandParam, randomNormalsMax, MainPeakExcessModifier, vdata.type_weather) 
	local maxExcess 	= calcPressureExcess(AtmRandParam, randomNormalsMin, MainPeakExcessModifier) --randomNormalsMin не ошибка
	local maxRotation	= calcRotation(AtmRandParam, randomNormalsMax)
	local maxEllipticity= calcEllipticity(AtmRandParam, randomNormalsMax)
	
	--base.print("--minSpread, maxSpread--",minSpread, maxSpread)
	--base.print("--minExcess, maxExcess--",minExcess, maxExcess)
	--base.print("--minRotation, maxRotation--",minRotation, maxRotation)
	--base.print("--minEllipticity, maxEllipticity--",minEllipticity, maxEllipticity)
	a_pCyc.spX:setRange(minX, maxX)
	a_pCyc.spY:setRange(minZ, maxZ)
	a_pCyc.spSpread:setRange(minSpread, maxSpread)
	a_pCyc.spExcess:setRange(minExcess, maxExcess)
	a_pCyc.spRotation:setRange(minRotation, maxRotation)
	a_pCyc.spEllipticity:setRange(minEllipticity, maxEllipticity)
	
end

function updateDataCyclonesValues()
	for k,v in base.ipairs(vdata.cyclones) do
		tblCyc[k].spX:setValue(v.centerX)
		tblCyc[k].spY:setValue(v.centerZ)		
		tblCyc[k].spSpread:setValue(v.pressure_spread)
		tblCyc[k].spEllipticity:setValue(v.ellipticity)
		tblCyc[k].spExcess:setValue(v.pressure_excess)
		tblCyc[k].spRotation:setValue(v.rotation)
	end
end

function updateSunMoon()
	local player = mod_mission.getPlayerUnit()
	local x,y
	
	if player then
		x,y = player.x, player.y
	else
		x,y = centerWeather.x, centerWeather.y 
	end
	
	local lat, long = MapWindow.convertMetersToLatLon(x,y)
	local datum = OptionsData.getMiscellaneous('Datum')
	if datum == 2 then
		lat, long = UC.LL_datum_convert(1, 2, lat, long)
	end	
	
	local coordDisplay = OptionsData.getMiscellaneous('Coordinate_Display')
	local SummerTimeDelta = Terrain.GetTerrainConfig('SummerTimeDelta')
	
	if coordDisplay == "Lat Long" then
		eCoords:setText(U.text_coords_LatLong('lat', U.toRadians(lat)).."   "..U.text_coords_LatLong('long', U.toRadians(long)))
	elseif coordDisplay == "Lat Long Decimal" then
		eCoords:setText(U.text_coords_LatLongD('lat', U.toRadians(lat)).."   "..U.text_coords_LatLongD('long', U.toRadians(long)))
	elseif coordDisplay == "Precise Lat Long" then
		eCoords:setText(U.text_coords_LatLongHornet('lat', U.toRadians(lat)).."   "..U.text_coords_LatLongHornet('long', U.toRadians(long)))
	elseif coordDisplay == "Metric" then
		eCoords:setText(U.text_coords_Metric(x,y))
	else
		eCoords:setText(Terrain.GetMGRScoordinates(x,y))
	end


	local lastELEV = nil
	local sunRiseSec = nil
	local sunSetSec = nil

	for i=0, 23 do	
		local degAZ, degELEV = DCS.getSunAzimuthElevation(lat, long, 
										mod_mission.mission.date.Year,
										mod_mission.mission.date.Month,
										mod_mission.mission.date.Day,
										(i-SummerTimeDelta) *3600)										
		
		if lastELEV ~= nil and lastELEV < 0 and  degELEV > 0 then
			sunRiseSec = (i - degELEV/(degELEV - lastELEV))*3600
		end
		
		if lastELEV ~= nil and lastELEV > 0 and  degELEV < 0 then
			sunSetSec = (i + degELEV/(lastELEV - degELEV))*3600
		end
		lastELEV = degELEV
	end
	
	--позиция солнца
	local degAZ,degELEV = DCS.getSunAzimuthElevation(lat, long, 
										mod_mission.mission.date.Year,
										mod_mission.mission.date.Month,
										mod_mission.mission.date.Day,
										base.module_mission.mission.start_time - (SummerTimeDelta * 3600))
										
	local timeIndex = 18  
	local x,y = chart:getPosition()
	
	local xSun = x-16+degAZ/360*332
	local ySun = y-16+(140-((degELEV*2)/180)*140)
--	base.print("--x,y--", xSun,ySun,degAZ,degELEV )
	if degELEV > 0 then
		sSun:setPosition(xSun, ySun)
		sText:setText(base.string.format("%.1f°, %.1f°", degELEV, degAZ))
		sSun:setVisible(true)
		sText:setVisible(true)
		
		if xSun < 315 then
			sText:setPosition(xSun+35, ySun-15)	
		else
			sText:setPosition(xSun-110, ySun-15)	
		end	
	else
		sSun:setVisible(false)
		sText:setVisible(false)
	end
	

	local sunRiseAZ, t2 = DCS.getSunAzimuthElevation(lat, long, 
										mod_mission.mission.date.Year,
										mod_mission.mission.date.Month,
										mod_mission.mission.date.Day,
										sunRiseSec - (SummerTimeDelta *3600))
										
	local sunSetAZ, t4 = DCS.getSunAzimuthElevation(lat, long, 
										mod_mission.mission.date.Year,
										mod_mission.mission.date.Month,
										mod_mission.mission.date.Day,
										sunSetSec - (SummerTimeDelta *3600))										


	eSunrise:setText(U.secToString(sunRiseSec)..base.string.format(" %.1f°",sunRiseAZ))
	eSunset:setText(U.secToString(sunSetSec)..base.string.format(" %.1f°",sunSetAZ))
	
	local tmp1, tmp2, prevMoonPHASE  = DCS.getMoonAzimuthElevationPhase(lat, long, 
										mod_mission.mission.date.Year,
										mod_mission.mission.date.Month,
										mod_mission.mission.date.Day,
										base.module_mission.mission.start_time - ((SummerTimeDelta+1) * 3600))	
										
	local moonAZ, moonELEV, moonPHASE  = DCS.getMoonAzimuthElevationPhase(lat, long, 
										mod_mission.mission.date.Year,
										mod_mission.mission.date.Month,
										mod_mission.mission.date.Day,
										base.module_mission.mission.start_time - (SummerTimeDelta * 3600))	
	local xMoon = x-16+moonAZ/360*332
	local yMoon = y-16+(140-((moonELEV*2)/180)*140)

--base.print("--moon--",moonAZ, moonELEV,U.secToString(base.module_mission.mission.start_time), moonPHASE)	
	if moonELEV > 0 then
		sMoon:setPosition(xMoon, yMoon)
		sMoon:setVisible(true)
	else
		sMoon:setVisible(false)
	end
	
	local bWaningMoon = prevMoonPHASE > moonPHASE
	
	if moonPHASE < 0.02 then
		sMoon:setSkin(sMoon0Skin)
	elseif moonPHASE < 0.33 then
		if bWaningMoon == true then
			sMoon:setSkin(sMoon7Skin)
		else
			sMoon:setSkin(sMoon1Skin)
		end
	elseif moonPHASE < 0.66 then
		if bWaningMoon == true then
			sMoon:setSkin(sMoon6Skin)
		else
			sMoon:setSkin(sMoon2Skin)
		end
	elseif moonPHASE < 0.98 then
		if bWaningMoon == true then
			sMoon:setSkin(sMoon5Skin)
		else
			sMoon:setSkin(sMoon3Skin)
		end
	elseif moonPHASE <= 1 then
		sMoon:setSkin(sMoon4Skin)
	end
	
end

function isVisible()
	if window then
		return window:getVisible()
	end
	return false
end

function isVisibleSun()
	return sunDeploy == true 
end	


-------------------------------------------------------------------------------
--
function updateRegimen()
	loadAllPresets(vdata.atmosphere_type == regimenDynamic)
    if (vdata.atmosphere_type == regimenDynamic) then
        clouds:setVisible(false)
		pHalo:setVisible(false)
        wind:setVisible(false)
		wnd_cloud_presets:setVisible(false)
		wnd_halo_presets:setVisible(false)
        
        dynamic:setVisible(true)
        
        if (#vdata.cyclones == 0) then
            addCyclone()
        end
                
    else
        clouds:setVisible(true)
		pHalo:setVisible(true)
        wind:setVisible(true)
        
        dynamic:setVisible(false)
    end
    
end

-------------------------------------------------------------------------------
--
function addCyclone()
    table.insert(vdata.cyclones, getDefaultCyclone())
    
    vdata.cyclones[#vdata.cyclones].groupId = mod_mission.createCyclone(vdata.cyclones[#vdata.cyclones])
    
    s_cyclones:setRange(1, #vdata.cyclones)
    if ((s_cyclones:getValue()+1) <= #vdata.cyclones) then
        s_cyclones:setValue(s_cyclones:getValue()+1)
    end
    
    update()
end

-------------------------------------------------------------------------------
--
function delCyclone()
    mod_mission.deleteCyclone(vdata.cyclones[#vdata.cyclones].groupId)
    table.remove(vdata.cyclones, s_cyclones:getValue())    
    if ((s_cyclones:getValue()-1) <= 1) then
        s_cyclones:setValue(s_cyclones:getValue()-1)
    end
    s_cyclones:setRange(1, #vdata.cyclones)
 
    update()
end

-------------------------------------------------------------------------------
-- удаляет все циклоны кроме первого
function delAllCyclone()  
    while (#vdata.cyclones > 0) do
        mod_mission.deleteCyclone(vdata.cyclones[#vdata.cyclones].groupId)
        table.remove(vdata.cyclones, #vdata.cyclones)    
    end
   
    s_cyclones:setRange(1, #vdata.cyclones)
    s_cyclones:setValue(1)
end

-------------------------------------------------------------------------------
-- добавляет все циклоны кроме первого
function addAllCyclone(num)   
    for i = 1, num, 1 do
        table.insert(vdata.cyclones, getDefaultCyclone())    
        vdata.cyclones[#vdata.cyclones].groupId = mod_mission.createCyclone(vdata.cyclones[#vdata.cyclones])
    end
    
    s_cyclones:setRange(1, #vdata.cyclones)
    s_cyclones:setValue(1)
    MapWindow.setSelectedObject(vdata.cyclones[1].groupId)
    update()
end

-------------------------------------------------------------------------------
-- добавляет все циклоны кроме первого
function createCycloneVdata()      
    for i = 1, #vdata.cyclones, 1 do  
        vdata.cyclones[i].groupId = mod_mission.createCyclone(vdata.cyclones[i])
    end
    
    s_cyclones:setRange(1, #vdata.cyclones)
    s_cyclones:setValue(1)
    MapWindow.setSelectedObject(vdata.cyclones[1].groupId)
    mod_mission.updateCyclone(vdata.cyclones[1])
    update()
end

-------------------------------------------------------------------------------
--
function selectCyclon(cyclon)
    local num = -1
    for k,v in pairs(vdata.cyclones) do
        if (v == cyclon) then
            num = k
        end
    end
    
    if (num > 0) then
        s_cyclones:setValue(num)
    end
end

-------------------------------------------------------------------------------
--
function getRandomNormals(a_number)
    local res_normals = {}
    
    local counter = 1;
	U.randomseed()

	for i=0, (a_number/2.0), 1 do	
		local R  = math.max(0.0000001, U.random())
		local fi = math.max(0.0000001, U.random())
        
		res_normals[counter] = math.cos(math.pi*2*fi)*math.sqrt(-2*math.log(R))
		if (counter < a_number) then
            counter = counter + 1;
        end
		
        
		res_normals[counter] = math.sin(math.pi*2*fi)*math.sqrt(-2*math.log(R))
		if (counter < a_number) then
            counter = counter + 1;
        end
	end
	
    return res_normals
end

function calcEllipticity(a_rp, a_rN)
	return 1 + a_rN[3] * a_rp.EllipticityStdDev
end

function calcPressureExcess(a_rp, a_rN, a_MainPeakExcessModifier)
	local result = math.floor(a_rp.Sign * math.abs(a_rN[4] * a_rp.PressureStdDev * a_MainPeakExcessModifier + a_rp.PressureOffset))
	--base.print("--calcPressureExcess--",a_rp.Sign,a_rN[4], result)
	return result
end

function calcRotation(a_rp, a_rN)
	return a_rp.RotationStdDev * a_rN[5]
end

function calcPressureSpread(a_rp, a_rN, a_MainPeakExcessModifier, a_typeWeather)
	local result = a_rp.Spread + a_rp.SpreadStdDev * a_MainPeakExcessModifier * a_rN[6]
	if  (a_typeWeather == weatherTypes[2].id) then
        result = result * 1.3
    end
	return result
end

-------------------------------------------------------------------------------
--
function CycloneInitialise(a_rN, a_i, a_rp, a_type_weather, a_x, a_z)
    local MainPeakExcessModifier

    local x = 0
    local z = 0
    
    if (vdata.type_weather == weatherTypes[3].id)
        or ((vdata.type_weather ~= weatherTypes[3].id) and (a_i ~= 1)) then
        MainPeakExcessModifier = 1
        x = math.cos(a_rp.InitAngle + a_rp.AngleStep * (a_i-1) + a_rp.DeltaAngle * a_rN[1]) * (a_rp.Distance + a_rp.DistanceStdDev * a_rN[2])
        z = math.sin(a_rp.InitAngle + a_rp.AngleStep * (a_i-1) + a_rp.DeltaAngle * a_rN[1]) * (a_rp.Distance + a_rp.DistanceStdDev * a_rN[2])
    else
		MainPeakExcessModifier = 0.22; -- поближе к центру карты (к циклону 1)
        x = math.cos(a_rp.InitAngle + a_rp.AngleStep * (a_i-1) + a_rp.DeltaAngle * a_rN[1]) * (a_rp.DistanceStdDev * MainPeakExcessModifier * a_rN[2])
        z = math.sin(a_rp.InitAngle + a_rp.AngleStep * (a_i-1) + a_rp.DeltaAngle * a_rN[1]) * (a_rp.DistanceStdDev * MainPeakExcessModifier * a_rN[2])
    end
	
    vdata.cyclones[a_i].centerX         = a_x + x
    vdata.cyclones[a_i].centerZ         = a_z + z
    vdata.cyclones[a_i].ellipticity     = calcEllipticity(a_rp, a_rN)
    vdata.cyclones[a_i].pressure_excess = calcPressureExcess(a_rp, a_rN, MainPeakExcessModifier)
	vdata.cyclones[a_i].rotation		= calcRotation(a_rp, a_rN)
	vdata.cyclones[a_i].pressure_spread = calcPressureSpread(a_rp, a_rN, MainPeakExcessModifier, vdata.type_weather)   
	
	-- base.print("--ellipticity--",vdata.cyclones[a_i].ellipticity)
	-- base.print("--pressure_excess--",vdata.cyclones[a_i].pressure_excess)
	-- base.print("--rotation--",vdata.cyclones[a_i].rotation)
	-- base.print("--pressure_spread--",vdata.cyclones[a_i].pressure_spread)
      
    mod_mission.updateCyclone(vdata.cyclones[a_i])        
end

-------------------------------------------------------------------------------
--
function generateCyclones()
    local CyclonesQty = tonumber(s_cyclonesof:getValue())--U.random(1,6)    
    delAllCyclone()
    addAllCyclone(CyclonesQty)
	
	AtmRandParam.InitAngle = 2 * math.pi * U.random()

    if (vdata.type_weather == weatherTypes[3].id) then
        AtmRandParam.AngleStep = 2 * math.pi * CyclonesQty
        AtmRandParam.DeltaAngle = AtmRandParam.AngleStep/4
        for  i=1, CyclonesQty, 1 do
			AtmRandParam.Sign = U.random(0,1)*2 -1
            local randomNormals = getRandomNormals(6)

			CycloneInitialise(randomNormals, i, AtmRandParam, type_weather,
                            centerWeather.x, centerWeather.y)
		end
    else
        if CyclonesQty > 1 then
            AtmRandParam.AngleStep = 2 * math.pi /(CyclonesQty-1)
        else
            AtmRandParam.AngleStep = 0
        end
    
        AtmRandParam.DeltaAngle = AtmRandParam.AngleStep/4
        
        if (vdata.type_weather == weatherTypes[1].id) then    
            AtmRandParam.Sign = -1
        else
            AtmRandParam.Sign = 1
        end
        
        for  i=1, CyclonesQty, 1 do			
            local randomNormals = getRandomNormals(6)

			CycloneInitialise(randomNormals, i, AtmRandParam, vdata.type_weather,
                            centerWeather.x, centerWeather.y)
            AtmRandParam.Sign = U.random(0,1)*2 -1
		end   
    end
 
    mod_mission.setCyclonesVisible(vdata.cyclones, false)
    mod_mission.setCyclonesVisible(vdata.cyclones, true)
    
    generateWinds()
    
    mod_mission.setWindsVisible(MapWindow.listWinds,false)  
    mod_mission.setWindsVisible(MapWindow.listWinds,true)  
    
    update()
end

-------------------------------------------------------------------------------
--
function generateWinds()
    dllWeather.initAtmospere(vdata)
	
    if (MapWindow.listWinds == nil) then
        return
    end
  	   
    local SW_bound,NE_bound = MapWindow.getMapBounds()

    local listWinds = dllWeather.getWindVelDir({rectangle =
	{
		x1      = SW_bound[1]*1000,
		z1      = SW_bound[3]*1000,
		x2      = NE_bound[1]*1000,
		z2      = NE_bound[3]*1000,
		step    = 125*1000,
	}
    })    
    
    mod_mission.setWindsVisible(MapWindow.listWinds, false) 

    for k, v in pairs(listWinds) do  
        local wind = {}
        wind.x1 = v.x
        wind.y1 = v.z
        wind.angle =  v.wind.a + math.pi
        wind.v     =  v.wind.v        
      
        if (MapWindow.listWinds[k] == nil) then            
            table.insert(MapWindow.listWinds, wind)
        else
            MapWindow.listWinds[k].x1       = wind.x1
            MapWindow.listWinds[k].y1       = wind.y1
            MapWindow.listWinds[k].angle    = wind.angle 
            MapWindow.listWinds[k].v        = wind.v 
        end
    end
    
    mod_mission.setWindsVisible(MapWindow.listWinds,true) 
end


-------------------------------------------------------------------------------
--
function setCenterWeather(a_x, a_y)
    if (not centerWeather) then
        centerWeather = {}
    end
    centerWeather.x = a_x
    centerWeather.y = a_y
end

-------------------------------------------------------------------------------
-- load default weather
function loadDefaultWeather()
	clearCyclones()
    vdata.atmosphere_type = regimenStandard
	local tmp = {}
	for id, preset in base.pairs(presetsHalo.crystalsPresets) do
		base.table.insert(tmp, preset)
	end	

    loadAllPresets(false)
    loadPreset(cdata.defaultWeather)  

	if #tmp == 0 then
		vdata.halo = {preset = 'off', crystalsPreset = nil}
	else
		vdata.halo = {preset = 'auto', crystalsPreset = nil}
	end	
	updatePresetHalo()
	resize()
end

function setData(a_data)
    vdata = a_data
    if not vdata.atmosphere_type then
        vdata.atmosphere_type = regimenStandard
    end
    fixTurbulence(a_data)
end

function fixTurbulence(a_data)
    if a_data.turbulence and a_data.turbulence.atGround then
        a_data.groundTurbulence = a_data.turbulence.atGround
        a_data.turbulence = nil
    end
end

function updateUnitSystem()
	local unitSystem = OptionsData.getUnits()
	
	sp_wind_8000UnitSpinBox:setUnitSystem(unitSystem)    
    sp_wind_2000UnitSpinBox:setUnitSystem(unitSystem)   
    sp_wind_500UnitSpinBox:setUnitSystem(unitSystem)  
    sp_wind_groundUnitSpinBox:setUnitSystem(unitSystem)    

    e_baseUnitSpinBox:setUnitSystem(unitSystem)  
    e_thicknessUnitSpinBox:setUnitSystem(unitSystem) 
    sp_qnhUnitSpinBox:setUnitSystem(unitSystem)   
    
    e_fog_visUnitSpinBox:setUnitSystem(unitSystem)    
    e_fog_thicknessUnitSpinBox:setUnitSystem(unitSystem)    
	
	e_dust_visUnitSpinBox:setUnitSystem(unitSystem)   

    sp_turb_groundUnitSpinBox:setUnitSystem(unitSystem)   

    if 'metric' == unitSystem then
        pWindM:setVisible(true)   
        pWindI:setVisible(false) 
        sp_qnh:setStep(1)
        if vdata.qnh then
            vdata.qnh = base.math.floor(vdata.qnh)
        end
    else
        pWindM:setVisible(false)   
        pWindI:setVisible(true)  
        sp_qnh:setStep(0.01)
    end    
end

local function comparePresets(a_tbl1, a_tbl2)
	return textutil.Utf8Compare(a_tbl1.order or a_tbl1.id, a_tbl2.order or a_tbl2.id)	
end

function createPresetsCloudsPanel()
	bCloseClouds = wnd_cloud_presets.bCloseClouds
	bCloseClouds.onChange = onChange_bCloseClouds
	
	spPresets = wnd_cloud_presets.spPresets
	pNoVisible = wnd_cloud_presets.pNoVisible
	bCancel = wnd_cloud_presets.bCancel
	bOk = wnd_cloud_presets.bOk
	
	bCancel.onChange = onChange_bCloseClouds
	bOk.onChange = onChange_Ok
	
	bNothingSkin = pNoVisible.bNothing:getSkin()
	bPresetSkin = pNoVisible.bPreset:getSkin()
	sPresetCloudsSkin = pNoVisible.sPresetClouds:getSkin()
	sTooltipSkin = pNoVisible.sTooltip:getSkin()
	
	local i = 0
	local bNothing = Button.new()
	bNothing.id = nil
	bNothing.onChange = onChange_bPClouds
	bNothing:setSkin(bNothingSkin)
	bNothing:setText(cdata.NOTHING)
	spPresets:insertWidget(bNothing)
	bNothing:setZIndex(0)
	bNothing:setBounds(0, 0, 244, 124)
	bNothing:setTooltipSkin(sTooltipSkin)
	bNothing:setTooltipText(cdata.NOTHING)
	bNothing.tooltip = cdata.NOTHING
	
	i = i + 1
	
	local tmp = {}
	for id, preset in base.pairs(presetsClouds) do
		base.table.insert(tmp, preset)
	end	
	table.sort(tmp, comparePresets)
	
	for k, preset in base.pairs(tmp) do
		local bButton = Button.new()
		bButton.id = preset.id
		bButton.onChange = onChange_bPClouds
		spPresets:insertWidget(bButton)
		spPresets:setZIndex(0)
		local fileImage 
		if preset.thumbnailName and preset.thumbnailName ~= '' then
			fileImage = preset.thumbnailName
		else	
			fileImage = 'bazar/effects/clouds/thumbnails/empty.png'
		end
		bButton:setSkin(SkinUtils.setButtonPicture(fileImage, bPresetSkin))
		bButton:setText(preset.readableNameShort or preset.id)
		bButton:setBounds((i-base.math.floor(i/5)*5)*249, base.math.floor(i/5)*129, 244, 124)
		bButton:setTooltipSkin(sTooltipSkin)
		bButton:setTooltipText(preset.tooltip)
		bButton.tooltip	= preset.tooltip
		
		i = i + 1
		pcItemsById[preset.id] = bButton
	end
	
	sPresetClouds = Static.new()
	sPresetClouds:setSkin(sPresetCloudsSkin)
	spPresets:insertWidget(sPresetClouds)
	sPresetClouds:setTooltipSkin(sTooltipSkin)
	sPresetClouds:setSize(244,124)
end

function createPresetsHaloPanel()
	bCloseHalo = wnd_halo_presets.bCloseHalo
	bCloseHalo.onChange = onChange_bCloseHalo
	
	spPresetsHalo = wnd_halo_presets.spPresetsHalo
	pNoVisibleHalo = wnd_halo_presets.pNoVisibleHalo
	bCancelHalo = wnd_halo_presets.bCancelHalo
	bOkHalo = wnd_halo_presets.bOkHalo
	
	bCancelHalo.onChange = onChange_bCloseHalo
	bOkHalo.onChange = onChange_OkHalo
	
	bNothingHaloSkin = pNoVisibleHalo.bNothingHalo:getSkin()
	bPresetHaloSkin = pNoVisibleHalo.bPresetHalo:getSkin()
	sPresetHaloSkin = pNoVisibleHalo.sPresetHalo:getSkin()
	sTooltipHaloSkin = pNoVisibleHalo.sTooltipHalo:getSkin()
	
	local i = 0
	
	local tmp = {}
	for id, preset in base.pairs(presetsHalo.crystalsPresets) do
		base.table.insert(tmp, preset)
	end	
	table.sort(tmp, comparePresets)
	
	for k, preset in base.pairs(tmp) do
		local bButton = Button.new()
		bButton.id = preset.id
		bButton.onChange = onChange_bPHalo
		spPresetsHalo:insertWidget(bButton)
		spPresetsHalo:setZIndex(0)
		local fileImage 
		if preset.thumbnailName and preset.thumbnailName ~= '' then
			fileImage = preset.thumbnailName
		else	
			fileImage = 'bazar/effects/clouds/thumbnails/empty.png'
		end
		bButton:setSkin(SkinUtils.setButtonPicture(fileImage, bPresetSkin))
		bButton:setText(preset.readableNameShort or preset.id)
		bButton:setBounds((i-base.math.floor(i/3)*3)*249, base.math.floor(i/3)*129, 244, 124)
		bButton:setTooltipSkin(sTooltipSkin)
		bButton:setTooltipText(preset.tooltip)
		bButton.tooltip	= preset.tooltip
		
		i = i + 1
		phItemsById[preset.id] = bButton
	end
	
	sPresetHalo = Static.new()
	sPresetHalo:setSkin(sPresetCloudsSkin)
	spPresetsHalo:insertWidget(sPresetHalo)
	sPresetHalo:setTooltipSkin(sTooltipSkin)
	sPresetHalo:setSize(244,124)
end

function onChange_bPClouds(self)	
	selectedPresetClouds = self.id
	if pcItemsById[selectedPresetClouds] then
		local x,y = pcItemsById[selectedPresetClouds]:getPosition()
		sPresetClouds:setPosition(x,y)
		sPresetClouds:setTooltipText(pcItemsById[selectedPresetClouds].tooltip)
	end
	
	if self.id == nil then
		sPresetClouds:setPosition(0,0)
		sPresetClouds:setTooltipText(cdata.NOTHING)
	end
end

function onChange_bCloseClouds()
	wnd_cloud_presets:setVisible(false)
end

function onChange_Ok()
	setCurPresetClouds(selectedPresetClouds, true)
	wnd_cloud_presets:setVisible(false)
end

function onChange_bPHalo(self)	
	selectedPresetHalo = self.id
	if phItemsById[selectedPresetHalo] then
		local x,y = phItemsById[selectedPresetHalo]:getPosition()
		sPresetHalo:setPosition(x,y)
		sPresetHalo:setTooltipText(phItemsById[selectedPresetHalo].tooltip)
	end
	
	if self.id == nil then
		sPresetHalo:setPosition(0,0)
		sPresetHalo:setTooltipText(cdata.NOTHING)
	end
end

function onChange_bCloseHalo()
	wnd_halo_presets:setVisible(false)
end

function onChange_OkHalo()
	setCurCrystalsPresetHalo(selectedPresetHalo)
	wnd_halo_presets:setVisible(false)
end


function onChange_bDeploy()
	sunDeploy = not sunDeploy
	if sunDeploy == true then
		bDeploy:setSkin(bRollupSkin)
	else
		bDeploy:setSkin(bExpandSkin)
	end	
			
	update()
end

function onChange_hsTime(self)
	setTime(self:getValue() * 300)
end

function onChange_bMinusH(self)
	local value = hsTime:getValue() - 12
		
	if (value < 0) then
		value = 287
		
		date.Day = date.Day - 1
		
		if date.Day <= 0 then 
			
			date.Month = date.Month - 1
			
			if date.Month <= 0 then 
				date.Month = 12
				date.Year = date.Year - 1
			end
			
			date.Day = U.getDaysInMonth(date.Month, date.Year)
		end
	end
	
	hsTime:setValue(value)
	setTime(value*300)
end

function onChange_bPlusH(self)
	local value = hsTime:getValue() + 12
		
	if (value > 287) then
		value = 0
		
		date.Day = date.Day + 1
		
		if date.Day > U.getDaysInMonth(date.Month, date.Year) then 
			date.Day = 1
			date.Month = date.Month + 1
			
			if date.Month > 12 then 
				date.Month = 1
				date.Year = date.Year + 1
			end			
		end
	end
	
	hsTime:setValue(value)
	setTime(value*300)
end

function setTime(a_time)
	start_time = a_time
	
	U.setDataTime(editBoxYear, cb_month, editBoxHours, editBoxMinutes, editBoxSeconds, editBoxDays, start_time, date)
	updateMissionStart(start_time, date, true)
end

function onChange_spX(self)
	vdata.cyclones[self.index].centerX = self:getValue()
	mod_mission.updateCyclone(vdata.cyclones[self.index])
end

function onChange_spY(self)
	vdata.cyclones[self.index].centerZ = self:getValue()
	mod_mission.updateCyclone(vdata.cyclones[self.index])
end

function onChange_spSpread(self)
	vdata.cyclones[self.index].pressure_spread = self:getValue()
	mod_mission.updateCyclone(vdata.cyclones[self.index])
end

function onChange_spEllipticity(self)
	vdata.cyclones[self.index].ellipticity = self:getValue()	
	mod_mission.updateCyclone(vdata.cyclones[self.index])
end

function onChange_spExcess(self)
	vdata.cyclones[self.index].pressure_excess = self:getValue()
	mod_mission.updateCyclone(vdata.cyclones[self.index])
end

function onChange_spRotation(self)
	vdata.cyclones[self.index].rotation = self:getValue()
	mod_mission.updateCyclone(vdata.cyclones[self.index])
end
