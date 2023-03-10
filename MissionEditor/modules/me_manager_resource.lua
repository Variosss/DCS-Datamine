local base = _G

module('me_manager_resource')

local require = base.require
local pairs = base.pairs
local ipairs = base.ipairs
local table = base.table

local DialogLoader      	= require('DialogLoader')
local SwitchButton      	= require('SwitchButton')
local GridHeaderCell    	= require("GridHeaderCell")
local spinGrid          	= require('spinGrid')
local DB                	= require('me_db_api')
local i18n 					= require('i18n')
local MapWindow				= require('me_map_window')
local ListBoxItem 			= require('ListBoxItem')
local textutil 				= require('textutil')
local U 					= require('me_utilities')
local OptionsData			= require('Options.Data')
local AirdromeController	= require('Mission.AirdromeController')
local panelContextMenu		= require('me_contextMenu')
local MeSettings      		= require('MeSettings')
local module_mission 		= require('me_mission')
local coords_info			= require('me_coords_info')
local ProductType 			= require('me_ProductType') 

i18n.setup(_M)

cdata = {
    header          = _("Resource Manager"),
    AIR 			= _("A/C"),
    FUEL 			= _("LIQUIDS"),
    EQP 			= _("EQP"),
	
	copyto			= _("CopyTo"),
	copy_air 		= _("copy_air", "A/C"),
    copy_fuel 		= _("copy_fuel", "Fuel"),
    copy_eqp 		= _("copy_eqp", "Eqp"),
    
    airbase         = _("Warehouse"),    
    airbase_coal    = _("Warehouse coalition"),
    aircrafts       = _("Aircraft"),
    unlimitedAir    = _("Unlimited Aircraft"),
    hideNotFlyable  = _("Hide Not Flyable"),
    typeofAir       = _("Type of Aircraft"),
    initialAmount   = _("Initial\nAmount"),
    resupplyHours   = _("Resupply,\nhours"),
    resupplyAmount  = _("Resupply,\namount"),
    resetToNil      = _("Fill Col"),
    speed           = _("Speed"),
    periodicity     = _("Periodicity"),
    size            = _("Size"),
       
    fuel                = _("Fuel"),
    unlimitedFuel       = _("Unlimited Liquids"),
    fuelStorageTank     = _("Fuel Storage Tank, 100 tons"),
    initFuelJet         = _("Jet fuel, tons"),    
    initFuelGasoline    = _("Aviation gasoline, tons"), 
    initFuelMethanol    = _("Water-methanol mixture MW50, tons"), 
    initFuelDiesel      = _("Diesel fuel, tons"), 
    emergencyRes    = _("Emergency Reserve, tons"),
    ResupplyFuelH   = _("Resupply Fuel, hours"),
    ResupplyFuelT   = _("Resupply Fuel, tons"),
    
    munitions       = _("Munitions"),
    unlimitedMun    = _("Unlimited Munitions"),
    MunitionsDepot  = _("Munitions Depot"),
    AAmissiles      = _("AA missiles"),
    AGmissiles      = _("AG missiles"),
    AGrockets       = _("AG Rockets"),
    AGbombs         = _("AG Bombs"),
    AGGuidedBombs   = _("AG Guided Bombs"),
    Fueltanks       = _("Fuel tanks"),
    GunOrdinance    = _("Gun Ordinance"),
    Misc            = _("Misc"),
    Type            = _("Type"),
    OperatingLevel  = _("Minimum stock, %"),
    
    minute          = _("min"),
    tonne           = _("t"),  
	clear			= _("Clear"),  
	ClearEQP		= _("Clear EQP"),  
	ClearAC			= _("Clear A/C"),  
	ClearLIQUIDS	= _("Clear LIQUIDS"),  
}

vdata = 
{
    curAirdromId = nil,
    paramEqp     = {},
    style        = 'airports',
}

vdata.paramEqp[2] = {base.wsType_Missile}
vdata.paramEqp[3] = {base.wsType_AA_Missile}

local x_
local y_
local w_
local h_
local window

local locale = i18n.getLocale()	
    
function create(x, y, w, h)
    x_ = x
    y_ = y
    w_ = w
    h_ = h
end

local function resizeLAPanel_(panelHeight)      
    local panelButton = cont_LA.panelButtonLA
    local panelButtonX, panelButtonY, panelButtonWidth, panelButtonHeight = panelButton:getBounds()
    
    panelButtonY = panelHeight - panelButtonHeight
    panelButton:setPosition(panelButtonX, panelButtonY)
    
    local grid = cont_LA.g_gridLA
    local gridX, gridY, gridWidth, gridHeight = grid:getBounds()
    
    gridHeight = panelButtonY - gridY
    grid:setSize(gridWidth, gridHeight)
end

local function resizeEQPPanel_(panelHeight)    
    local panelButton = cont_Eqp.panelButtonEqp
    local panelButtonX, panelButtonY, panelButtonWidth, panelButtonHeight = panelButton:getBounds()
    
    panelButtonY = panelHeight - panelButtonHeight
    panelButton:setPosition(panelButtonX, panelButtonY)
    
    local grid = cont_Eqp.g_gridEqp
    local gridX, gridY, gridWidth, gridHeight = grid:getBounds()
    
    gridHeight = panelButtonY - gridY
    grid:setSize(gridWidth, gridHeight)
	cont_Eqp.eSearch:setSize(gridWidth, 22)
end

local function resizePanels_(w, h)
    local panelX, panelY, panelWidth, panelHeight = window.staticPanelPlaceholder:getBounds()
    
    panelHeight = h - panelY
    
    cont_LA:setBounds(panelX, panelY, panelWidth, panelHeight)
    cont_Fuel:setBounds(panelX, panelY, panelWidth, panelHeight)
    cont_Eqp:setBounds(panelX, panelY, panelWidth, panelHeight)
    
    resizeLAPanel_(panelHeight)
    resizeEQPPanel_(panelHeight)
end

local function showTabs_()
    cont_LA:setVisible(b_LA:getState())
    cont_Fuel:setVisible(b_Fuel:getState())
    cont_Eqp:setVisible(b_Eqp:getState())
	
end

local function setTabsCallbacks_()
    function b_LA:onChange()
        showTabs_()
    end
    
    function b_Fuel:onChange()
        showTabs_()
    end
    
    function b_Eqp:onChange()
        showTabs_()
    end
end

local function initTabs_()
    b_LA = window.b_LA
    b_Fuel = window.b_Fuel
    b_Eqp = window.b_Eqp
    
    setTabsCallbacks_()
    
    b_LA:setState(true)
    showTabs_()
end

local function copyPanelWidgetsIntoModule_(panel)
    local widgetCount = panel:getWidgetCount()
    local widgets = {}
    
    for i = 1, widgetCount do
        local widget = panel:getWidget(i - 1)

        widgets[widget] = true
    end
    
    for key, value in pairs(panel) do
        if widgets[value] then
            _M[key] = value
        end
    end
end

local function createSpinGrid_(grid, callbackChangeData)
    spinGrid.new(grid)
    
    grid.callbackChangeData = callbackChangeData
end

local function setCallbacks_()
    s_speed.onChange = onChangeSpeed
    s_periodicity.onChange = onChangePeriodicity
    s_size.onChange = onChangeSize
    
    c_unlimitedAir.onChange = onChangeUnlimitedAir
    c_hideNotFlyable.onChange = onChangeHideNotFlyable
    b_resetIAmount.onChange = onChangeResetIAmountLA
    
    c_unlimitedFuel.onChange = onChangeUnlimitedFuel

    sp_initJetFuel.onChange = onChangeInitJetFuel        
    sp_initFuelGasoline.onChange = onChangeInitGasoline            
    sp_initFuelMethanol.onChange = onChangeInitMethanol         
    sp_initFuelDiesel.onChange = onChangeInitDiesel
    
    sp_OperatingLevel_Fuel.onChange = onChangeOperatingLevel_Fuel
    
    c_unlimitedMun.onChange = onChangeUnlimitedMun
    r_AAmissiles.onChange = onChangeAAmissiles
    r_AGmissiles.onChange = onChangeAGmissiles
    r_AGrockets.onChange = onChangeAGrockets
    r_AGbombs.onChange = onChangeAGbombs
    r_AGGuidedBombs.onChange = onChangeAGGuidedBombs
    r_Fueltanks.onChange = onChangeFueltanks
    r_Misc.onChange = onChangeMisc
    sp_OperatingLevel_Eqp.onChange = onChangeOperatingLevel_Eqp
    sp_OperatingLevel_Air.onChange = onChangeOperatingLevel_Air
    b_resetIAmountEqp.onChange = onChangeResetIAmountEqp
	
	cont_Eqp.eSearch.onChange = onChange_eSearch
	b_addAmountEqp.onChange = onChange_addAmountEqp
end

local function create_()    
    window = DialogLoader.spawnDialogFromFile('MissionEditor/modules/dialogs/me_resource_manager_panel.dlg', cdata)
    window:setBounds(x_, y_, w_, h_)
    
	function window:onClose()
		show(false)
	end
	
    cont_LA 			= window.cont_LA
    cont_Fuel 			= window.cont_Fuel
    cont_Eqp 			= window.cont_Eqp
	
	cb_Airports 		= window.cbAirports
	b_CopyTo 			= window.b_CopyTo
	b_CopyTo.onChange 	= onChangeCopyTo
	
	ch_copy_air 		= window.ch_copy_air
	ch_copy_eqp 		= window.ch_copy_eqp
	ch_copy_fuel 		= window.ch_copy_fuel
	
	b_clearAll			= window.b_clearAll
	b_clearAmountEqp 	= cont_Eqp.panelButtonEqp.b_clearAmountEqp
	b_clearLA			= cont_LA.panelButtonLA.b_clearLA
	b_clearFuel			= cont_Fuel.b_clearFuel
	
	b_clearAll.onChange 		= onChange_clearAll
	b_clearAmountEqp.onChange 	= onChange_clearAmountEqp
	b_clearLA.onChange 			= onChange_clearLA
	b_clearFuel.onChange 		= onChange_clearFuel
	
	
    
    -- пока не используются
 --[[   cb_Airports:setVisible(false)
	b_CopyTo:setVisible(false)
	ch_copy_air:setVisible(false)
	ch_copy_eqp:setVisible(false)
	ch_copy_fuel:setVisible(false)
    window.fon_copy:setVisible(false)
	]]
    
    local cw, ch = window:getClientRectSize()

    resizePanels_(cw, ch)
    initTabs_()
    
    s_speed = window.s_speed
    text_speed = window.text_speed
    speedSpinBox = U.createUnitSpinBox(text_speed, s_speed, U.speedUnits, s_speed:getRange())
    
    s_periodicity = window.s_periodicity
    s_size = window.s_size
    
    b_resetIAmount = cont_LA.panelButtonLA.b_resetIAmount
    b_resetIAmountEqp = cont_Eqp.panelButtonEqp.b_resetIAmountEqp
	
	sbResetLA	= cont_LA.panelButtonLA.sbResetLA
	sbResetEqp 	= cont_Eqp.panelButtonEqp.sbResetEqp
	
	cbWeaponEqp 	= cont_Eqp.panelButtonEqp.cbWeaponEqp	
	sbWeaponEqp		= cont_Eqp.panelButtonEqp.sbWeaponEqp
	b_addAmountEqp  = cont_Eqp.panelButtonEqp.b_addAmountEqp

    copyPanelWidgetsIntoModule_(cont_LA)
    copyPanelWidgetsIntoModule_(cont_Fuel)
    copyPanelWidgetsIntoModule_(cont_Eqp)
    
	if base.__PRODUCT_ID__ == 2 then
		s_initFuelMethanol:setVisible(false)
		sp_initFuelMethanol:setVisible(false)
	end	
	
    setCallbacks_()    
    
	createSpinGrid_(g_gridLA, callbackChangeDataGridLA)
	createSpinGrid_(g_gridEqp, callbackChangeDataGridEqp)
    
    r_AAmissiles:setState(true)
    onChangeAAmissiles(r_AAmissiles)
end

local function updateUnitSystem()
	local unitSystem = OptionsData.getUnits()
	
	speedSpinBox:setUnitSystem(unitSystem)
end

function fillListAirdromes()
	function compAirdromes(tab1, tab2)
		return textutil.Utf8Compare(tab1.name, tab2.name)    
	end

	cb_Airports:clear() 
	cb_Airports:setText("")
	local t = {}
	for k, v in pairs(MapWindow.listAirdromes) do
		if vdata.curAirdromId ~= k then 
			local air = {}            
            if v.display_name then
                air.name = _(v.display_name) 
            else
                air.name = v.names[locale] or v.names['en']
            end 
			air.id = k
			base.table.insert(t, air)
		end
	end
	
	table.sort(t, compAirdromes)
	
	for k, v in pairs(t) do	
		local item = ListBoxItem.new(v.name)	
		item.id = v.id
		cb_Airports:insertItem(item)
	end
	
	cb_Airports:selectItem(cb_Airports:getItem(0))
end

-------------------------------------------------------------------------------
--
function init() 
	if not window then
		create_()
	end
	
    fillLA(c_hideNotFlyable:getState())
    fillEqp()	
	fillListAirdromes()
end

-------------------------------------------------------------------------------
--
function updateGridLA()
	fillLA(c_hideNotFlyable:getState())
end

-------------------------------------------------------------------------------
--
function getAirdrome()
    local airdrome
    
    if vdata.curAirdromId then
        airdrome = vdata.AirportsEquipment[vdata.style][vdata.curAirdromId]
    end
    
    return airdrome
end

-------------------------------------------------------------------------------
--
function getAirdromeById(a_type, a_id)
    local airdrome
    
    if a_type and a_id then
        airdrome = vdata.AirportsEquipment[a_type][a_id]
    end
    
    return airdrome
end

function fillLA(a_onlyFlyable)
    g_gridLA:clear()
    
    local airdrome = getAirdrome()

    if not airdrome then
        return
    end

    local aircrafts = airdrome.aircrafts
    local tmpTableData = {}
	
	local function getYearsByType(a_type)
		if YearsByType == nil then
			YearsByType = {}
			for _tmp, country in pairs(DB.db.Countries) do
				for _tmp, plane in pairs(country.Units.Helicopters.Helicopter) do
					local tmp_in, tmp_out = DB.db.getYearsLocal(plane.Name, country.OldID)
					if tmp_in ~= 0 and tmp_out ~= 0 then
						YearsByType[plane.Name] = YearsByType[plane.Name] or {inY = 100000, outY = 0}	
						if YearsByType[plane.Name].inY > tmp_in then
							YearsByType[plane.Name].inY = tmp_in
							
						end
						if YearsByType[plane.Name].outY < tmp_out then
							YearsByType[plane.Name].outY = tmp_out
						end
					end
				end
			
				for _tmp, plane in pairs(country.Units.Planes.Plane) do
					local tmp_in, tmp_out = DB.db.getYearsLocal(plane.Name, country.OldID)
					if tmp_in ~= 0 and tmp_out ~= 0 then
						YearsByType[plane.Name] = YearsByType[plane.Name] or {inY = 100000, outY = 0}	
						if YearsByType[plane.Name].inY > tmp_in then
							YearsByType[plane.Name].inY = tmp_in
						end
						if YearsByType[plane.Name].outY < tmp_out then
							YearsByType[plane.Name].outY = tmp_out
						end
					end
				end
			end
		end
			
		return YearsByType[a_type] or {inY = 0, outY = 0}	
	end
	
	local Year = (module_mission.mission and module_mission.mission.date.Year) or 2018
	
    --самолеты
    for k, v in pairs(aircrafts.planes) do 
        if (a_onlyFlyable == nil 
            or a_onlyFlyable == false 
            or a_onlyFlyable == DB.unit_by_type[k].HumanCockpit) then
		
			
			local years = getYearsByType(k)
			if ((MeSettings.getShowEras() ~= true))
				or (MeSettings.getShowEras() == true and years.inY <= Year and Year <= years.outY) then
			
				local tmpTable = {}
				tmpTable.key = k
				tmpTable[1] = DB.unit_by_type[k].DisplayName
				tmpTable[2] = v.initialAmount
				
				table.insert(tmpTableData, tmpTable)
			end	
        end
    end
    
    --вертолеты
    for k, v in pairs(aircrafts.helicopters) do 
        if (a_onlyFlyable == nil 
            or a_onlyFlyable == false 
            or a_onlyFlyable == DB.unit_by_type[k].HumanCockpit) then
			
			
			local years = getYearsByType(k)
			if ((MeSettings.getShowEras() ~= true))
				or (MeSettings.getShowEras() == true and years.inY <= Year and Year <= years.outY) then
								
				local tmpTable = {}
				tmpTable.key = k
				tmpTable[1] = DB.unit_by_type[k].DisplayName
				tmpTable[2] = v.initialAmount
				
				table.insert(tmpTableData, tmpTable)
			end
        end
    end
    g_gridLA:setData(tmpTableData) 

    local paramSpin = {}
    paramSpin[2] = {min = 0, max = 1000, step = 1}
    paramSpin[3] = {min = 0, max = 100, step = 1}
    paramSpin[4] = {min = 0, max = 1000, step = 1}
    g_gridLA:setSpinParam(paramSpin)    
end

-------------------------------------------------------------------------------
--
function clearDataLA()
	local airdrome = getAirdrome()

    if not airdrome then
        return
    end

    local aircrafts = airdrome.aircrafts
    local tmpTableData = {}
	
    --самолеты
    for k, v in pairs(aircrafts.planes) do 
        aircrafts.planes[k].initialAmount = 0
    end
    
    --вертолеты
    for k, v in pairs(aircrafts.helicopters) do 
        aircrafts.helicopters[k].initialAmount = 0
    end
end

-------------------------------------------------------------------------------
--
function clearDataEqp()
	local airdrome = getAirdrome()

    if not airdrome then
        return
    end
   
    --оружие
    for k, v in pairs(airdrome.weapons) do   
		airdrome.weapons[k].initialAmount = 0
    end 
end

-------------------------------------------------------------------------------
--
function fillEqp()    
    g_gridEqp:clear()
	cbWeaponEqp:clear()
    
    local airdrome = getAirdrome()

    if not airdrome then
        return
    end

    function verifyParam(a_wsType)
        if (vdata.paramEqp[2] == nil) then
            return true
        end

        local result1 = false
        for k,v in pairs(vdata.paramEqp[2]) do
            if (v == a_wsType[2]) then
                result1 = true
            end
        end
        
        local result2 = false
        for k,v in pairs(vdata.paramEqp[3]) do
            if (v == a_wsType[3]) then
                result2 = true
            end
        end
        
        if (result1 == true) and (result2 == true) then
            return true
        else
            return false
        end
    end
   
    local tmpTableData = {}
	local tmpWeapon = {}
    
    --оружие
    for k, v in pairs(airdrome.weapons) do   
        if (verifyParam(v.wsType)) then
            local tmpTable = {}
            tmpTable.key = k
		--	local nm = "("..v.wsType[1].."."..v.wsType[2].."."..v.wsType[3].."."..v.wsType[4]..")  "..base.get_weapon_display_name_by_wstype(v.wsType)
			local nm = base.get_weapon_display_name_by_wstype(v.wsType)
            if not nm or nm == '' then
                base.print("no name =",v.wsType[1],v.wsType[2],v.wsType[3],v.wsType[4])
            end

            tmpTable[1] = nm
			tmpTable[2] = v.initialAmount
			
			table.insert(tmpWeapon, {name = nm or "no name", key = k})
			
			local findText = eSearch:getText()
			
			if findText == nil or findText == "" or  nil ~= textutil.Utf8FindNoCase(nm, findText) then
				table.insert(tmpTableData, tmpTable)
			end           
        end
    end
	
	local function compWeapon(a_tab1, a_tab2)
		return textutil.Utf8Compare(a_tab1.name, a_tab2.name)    
	end
	
	table.sort(tmpWeapon, compWeapon)
	
	for k,v in base.ipairs(tmpWeapon) do
		local item = ListBoxItem.new(v.name)
		item.key = v.key
		cbWeaponEqp:insertItem(item)		
	end
	
	local item = cbWeaponEqp:getItem(0)
	if item then
		cbWeaponEqp:selectItem(item)
		b_addAmountEqp:setEnabled(true)
	else
		b_addAmountEqp:setEnabled(false)
	end

    g_gridEqp:setData(tmpTableData) 

    local paramSpin = {}
    paramSpin[2] = {min = 0, max = 1000000, step = 1}
    paramSpin[3] = {min = 0, max = 100, step = 1}
    paramSpin[4] = {min = 0, max = 1000, step = 1}
    g_gridEqp:setSpinParam(paramSpin)    
end

-------------------------------------------------------------------------------
--
function show(b)
    if not window then
        create_()
    end
    if b then 
        updateUnitSystem()
		panelContextMenu.show(false)
		coords_info.show(false)
    end
	setPlannerMission(base.isPlannerMission())
    update()
	window:setVisible(b)
	
	if b then 
		AirdromeController.onResourceManagerPanelShow()
	else
		AirdromeController.onResourceManagerPanelHide()
	end
end

-------------------------------------------------------------------------------
--
function setPlannerMission(planner_mission)
	if (planner_mission == true) then
		c_unlimitedAir:setEnabled(false);
		s_speed:setEnabled(false);   
		s_periodicity:setEnabled(false);    
		s_size:setEnabled(false);
		c_unlimitedFuel:setEnabled(false);    
        sp_initJetFuel:setEnabled(false)
        sp_initFuelGasoline:setEnabled(false)
        sp_initFuelMethanol:setEnabled(false)
        sp_initFuelDiesel:setEnabled(false)
        sp_OperatingLevel_Fuel:setEnabled(false) 
		c_unlimitedMun:setEnabled(false);
		sp_OperatingLevel_Eqp:setEnabled(false);
        sp_OperatingLevel_Air:setEnabled(false);
		b_resetIAmount:setEnabled(false);
		b_resetIAmountEqp:setEnabled(false);
		g_gridEqp:setEditable(false)
		g_gridLA:setEditable(false)
	else
		c_unlimitedAir:setEnabled(true);
		s_speed:setEnabled(true);   
		s_periodicity:setEnabled(true);    
		s_size:setEnabled(true);
		c_unlimitedFuel:setEnabled(true);    
        sp_initJetFuel:setEnabled(true)
        sp_initFuelGasoline:setEnabled(true)
        sp_initFuelMethanol:setEnabled(true)
        sp_initFuelDiesel:setEnabled(true)
        sp_OperatingLevel_Fuel:setEnabled(true) 
		c_unlimitedMun:setEnabled(true);
		sp_OperatingLevel_Eqp:setEnabled(true);
        sp_OperatingLevel_Air:setEnabled(true);
		b_resetIAmount:setEnabled(true);
		b_resetIAmountEqp:setEnabled(true);
		g_gridEqp:setEditable(true)
		g_gridLA:setEditable(true)
	end	
end

-------------------------------------------------------------------------------
--
function update()
    local airdrome = getAirdrome()

    if not airdrome then
        return
    end
    
    if vdata.AirportsEquipment and vdata.AirportsEquipment[vdata.style] then
        c_unlimitedAir:setState(airdrome.unlimitedAircrafts)
        onChangeUnlimitedAir(c_unlimitedAir)
        c_unlimitedFuel:setState(airdrome.unlimitedFuel)
        onChangeUnlimitedFuel(c_unlimitedFuel)
        c_unlimitedMun:setState(airdrome.unlimitedMunitions)
        onChangeUnlimitedMun(c_unlimitedMun)
        
        sp_OperatingLevel_Eqp:setValue(airdrome.OperatingLevel_Eqp)
        sp_OperatingLevel_Air:setValue(airdrome.OperatingLevel_Air)
        
        sp_initJetFuel:setValue(airdrome.jet_fuel.InitFuel) 
        sp_initFuelGasoline:setValue(airdrome.gasoline.InitFuel) 
        sp_initFuelMethanol:setValue(airdrome.methanol_mixture.InitFuel) 
        sp_initFuelDiesel:setValue(airdrome.diesel.InitFuel) 
        sp_OperatingLevel_Fuel:setValue(airdrome.OperatingLevel_Fuel)
        
        speedSpinBox:setValue(airdrome.speed)
        s_periodicity:setValue(airdrome.periodicity)
        s_size:setValue(airdrome.size)
    end
end

-------------------------------------------------------------------------------
--
function onChangeAirbase(self)
    local item = c_airbase:getSelectedItem()
    vdata.curAirdromId = item.airdromeId
    
    fillLA(c_hideNotFlyable:getState())
    fillEqp()
end

-------------------------------------------------------------------------------
--
function onChangeCopyTo()
	local item = cb_Airports:getSelectedItem()
	local airdromNew = getAirdromeById('airports',item.id)
	local airdrom = getAirdrome()
	
	if ch_copy_air:getState() == true then
		airdromNew.unlimitedAircrafts = airdrom.unlimitedAircrafts
		airdromNew.aircrafts = {}
		U.recursiveCopyTable(airdromNew.aircrafts, airdrom.aircrafts)
	end
	
	if ch_copy_fuel:getState() == true then
        airdromNew.unlimitedFuel = airdrom.unlimitedFuel

        airdromNew.gasoline = {}
        U.recursiveCopyTable(airdromNew.gasoline, airdrom.gasoline)
        
        airdromNew.methanol_mixture = {}
        U.recursiveCopyTable(airdromNew.methanol_mixture, airdrom.methanol_mixture)
        
        airdromNew.diesel = {}
        U.recursiveCopyTable(airdromNew.diesel, airdrom.diesel)
        
        airdromNew.jet_fuel = {}
        U.recursiveCopyTable(airdromNew.jet_fuel, airdrom.jet_fuel)        
	end
	
	if ch_copy_eqp:getState() == true then
        airdromNew.unlimitedMunitions = airdrom.unlimitedMunitions
		airdromNew.weapons = {}
		U.recursiveCopyTable(airdromNew.weapons, airdrom.weapons)        
	end 
end

-------------------------------------------------------------------------------
--
function onChange_clearAll()
	onChange_clearAmountEqp()
	onChange_clearLA()
	onChange_clearFuel()
end

-------------------------------------------------------------------------------
--
function onChange_clearAmountEqp()
	clearDataEqp()
	fillEqp()

	c_unlimitedMun:setState(false)
	c_unlimitedMun:onChange()
	
	sp_OperatingLevel_Eqp:setValue(0)
	sp_OperatingLevel_Eqp:onChange()	
end

-------------------------------------------------------------------------------
--
function onChange_clearLA()
	c_unlimitedAir:setState(false)
	c_unlimitedAir:onChange()
		
	sp_OperatingLevel_Air:setValue(0)
	sp_OperatingLevel_Air:onChange()
	
	clearDataLA()
	updateGridLA()
end

-------------------------------------------------------------------------------
--
function onChange_clearFuel()
	sp_initJetFuel:setValue(0)
	sp_initJetFuel:onChange()
	
	sp_initFuelGasoline:setValue(0)
	sp_initFuelGasoline:onChange()
	
	sp_initFuelMethanol:setValue(0)
	sp_initFuelMethanol:onChange()
	
	sp_initFuelDiesel:setValue(0)
	sp_initFuelDiesel:onChange()
	
	sp_OperatingLevel_Fuel:setValue(0)
	sp_OperatingLevel_Fuel:onChange()
	
	c_unlimitedFuel:setState(false)
	c_unlimitedFuel:onChange()
end


-------------------------------------------------------------------------------
--
function onChangeAirbaseRadius(self)
end

-------------------------------------------------------------------------------
--
function onChangeSpeed(self)
    getAirdrome().speed = speedSpinBox:getValue() 
end

-------------------------------------------------------------------------------
--
function onChangePeriodicity(self)
    getAirdrome().periodicity = self:getValue()
end

-------------------------------------------------------------------------------
--
function onChangeSize(self)
    getAirdrome().size = self:getValue()
end

-------------------------------------------------------------------------------
--
function onChangeUnlimitedAir(self)
    local bUnlimitedAir = self:getState()
    getAirdrome().unlimitedAircrafts = bUnlimitedAir
    
    if (bUnlimitedAir == true) then
        g_gridLA:setEditable(false)
        b_resetIAmount:setEnabled(false)
        sp_OperatingLevel_Air:setEnabled(false) 
    else       
		g_gridLA:setEditable(true)
		if (base.isPlannerMission() == false) then			
			b_resetIAmount:setEnabled(true)
            sp_OperatingLevel_Air:setEnabled(true) 
		end	
    end
end

-------------------------------------------------------------------------------
--
function onChangeUnlimitedFuel(self)
    local bUnlimitedFuel = self:getState()
    getAirdrome().unlimitedFuel = bUnlimitedFuel
    
    if (bUnlimitedFuel == true) then
        sp_initJetFuel:setEnabled(false) 
        sp_initFuelGasoline:setEnabled(false) 
        sp_initFuelMethanol:setEnabled(false) 
        sp_initFuelDiesel:setEnabled(false) 
        sp_OperatingLevel_Fuel:setEnabled(false) 
        
    else
		if (base.isPlannerMission() == false) then
			sp_initJetFuel:setEnabled(true)
            sp_initFuelGasoline:setEnabled(true)
            sp_initFuelMethanol:setEnabled(true) 
            sp_initFuelDiesel:setEnabled(true)
            sp_OperatingLevel_Fuel:setEnabled(true) 
		end	
    end
end

-------------------------------------------------------------------------------
--
function onChangeUnlimitedMun(self)
    local bUnlimitedMun = self:getState()
    getAirdrome().unlimitedMunitions = bUnlimitedMun
    
    if (bUnlimitedMun == true) then
        g_gridEqp:setEditable(false)
        b_resetIAmountEqp:setEnabled(false)
        r_AAmissiles:setEnabled(false)
        r_AGmissiles:setEnabled(false)
        r_AGrockets:setEnabled(false)
        r_AGbombs:setEnabled(false)
        r_AGGuidedBombs:setEnabled(false)
        r_Fueltanks:setEnabled(false)
        r_Misc:setEnabled(false)    
        sp_OperatingLevel_Eqp:setEnabled(false) 
    else       
        r_AAmissiles:setEnabled(true)
        r_AGmissiles:setEnabled(true)
        r_AGrockets:setEnabled(true)
        r_AGbombs:setEnabled(true)
        r_AGGuidedBombs:setEnabled(true)
        r_Fueltanks:setEnabled(true)
        r_Misc:setEnabled(true) 
		g_gridEqp:setEditable(true)		
		if (base.isPlannerMission() == false) then			
			b_resetIAmountEqp:setEnabled(true)
			sp_OperatingLevel_Eqp:setEnabled(true)
		end	
    end
end


-------------------------------------------------------------------------------
--
function onChangeInitJetFuel(self)
    getAirdrome().jet_fuel.InitFuel = self:getValue()
end

function onChangeInitGasoline(self)
    getAirdrome().gasoline.InitFuel = self:getValue()
end

function onChangeInitMethanol(self)
    getAirdrome().methanol_mixture.InitFuel = self:getValue()
end

function onChangeInitDiesel(self)
    getAirdrome().diesel.InitFuel = self:getValue()
end

-------------------------------------------------------------------------------
--
function onChangeEmergencyRes(self)
    getAirdrome().fuel.EmergencyReserve = self:getValue()
end

-------------------------------------------------------------------------------
--
function onChangeResupplyFuelT(self)
    getAirdrome().fuel.ResupplyTons = self:getValue()
end

-------------------------------------------------------------------------------
--
function onChangeResupplyFuelH(self)
    getAirdrome().fuel.ResupplyHours = self:getValue()
end

-------------------------------------------------------------------------------
--
function onChangeHideNotFlyable(self)
    fillLA(self:getState())
end

-------------------------------------------------------------------------------
--
function onChangeOperatingLevel_Eqp(self)
    getAirdrome().OperatingLevel_Eqp = self:getValue()
end

-------------------------------------------------------------------------------
--
function onChangeOperatingLevel_Air(self)
    getAirdrome().OperatingLevel_Air = self:getValue()
end

-------------------------------------------------------------------------------
--
function onChangeOperatingLevel_Fuel(self)
    getAirdrome().OperatingLevel_Fuel = self:getValue()
end

-------------------------------------------------------------------------------
--
function onChangeAAmissiles(self)
    vdata.paramEqp[2] = {base.wsType_Missile}
    vdata.paramEqp[3] = {base.wsType_AA_Missile,
						 base.wsType_AA_TRAIN_Missile,
						 base.wsType_SA_Missile
						 }
	
    fillEqp()
end

-------------------------------------------------------------------------------
--
function onChangeAGmissiles(self)
    vdata.paramEqp[2] = {base.wsType_Missile}
    vdata.paramEqp[3] = {base.wsType_AS_Missile,
						 base.wsType_AS_TRAIN_Missile }
    fillEqp()
end

-------------------------------------------------------------------------------
--
function onChangeAGrockets(self)
    vdata.paramEqp[2] = {base.wsType_NURS}
    vdata.paramEqp[3] = {base.wsType_Rocket}
    fillEqp()
end

-------------------------------------------------------------------------------
--
function onChangeAGbombs(self)
    vdata.paramEqp[2] = {base.wsType_Bomb}
    vdata.paramEqp[3] = {   base.wsType_Bomb_BetAB,
                            base.wsType_Bomb_A,
                            base.wsType_Bomb_Cluster,
                            base.wsType_Bomb_ODAB,
                            base.wsType_Bomb_Antisubmarine,
                            base.wsType_Bomb_Fire,
                            base.wsType_Bomb_Lighter,
							32
                        }
    fillEqp()
end

-------------------------------------------------------------------------------
--
function onChangeAGGuidedBombs(self)
    vdata.paramEqp[2] = {base.wsType_Bomb}
    vdata.paramEqp[3] = {base.wsType_Bomb_Guided}
    fillEqp()
end

-------------------------------------------------------------------------------
--
function onChangeFueltanks(self)
    vdata.paramEqp[2] = {base.wsType_Free_Fall}
    vdata.paramEqp[3] = {base.wsType_FuelTank}
    fillEqp()
end

-------------------------------------------------------------------------------
--
function onChangeMisc(self)
    vdata.paramEqp[2] = {	base.wsType_GContainer}
    vdata.paramEqp[3] = {   base.wsType_Control_Cont,
							base.wsType_Cannon_Cont,
							base.wsType_Snare_Cont,
							base.wsType_Smoke_Cont,
	                        base.wsType_Jam_Cont,
							base.wsType_Support,
                        }
	fillEqp()
end


-------------------------------------------------------------------------------
--
function onChangeResetIAmountLA()
    g_gridLA:resetCol(1, sbResetLA:getValue())
end

-------------------------------------------------------------------------------
--
function onChangeResetRHoursLA()
    g_gridLA:resetCol(2)
end

-------------------------------------------------------------------------------
--
function onChangeResetRAmountLA()
    g_gridLA:resetCol(3)
end

-------------------------------------------------------------------------------
--
function onChangeResetIAmountEqp()
    g_gridEqp:resetCol(1, sbResetEqp:getValue())
end

-------------------------------------------------------------------------------
--
function onChangeResetRHoursEqp()
    g_gridEqp:resetCol(2)
end

-------------------------------------------------------------------------------
--
function onChangeResetRAmountEqp()
    g_gridEqp:resetCol(3)
end


-------------------------------------------------------------------------------
--
function callbackChangeDataGridLA(a_table)
    local tmpTable = getAirdrome().aircrafts.planes[a_table.key]
            or getAirdrome().aircrafts.helicopters[a_table.key]
    tmpTable.initialAmount  = a_table[1]
end

-------------------------------------------------------------------------------
--
function callbackChangeDataGridEqp(a_table)
    local tmpTable = getAirdrome().weapons[a_table.key]
    tmpTable.initialAmount  = a_table[1]
end

-------------------------------------------------------------------------------
--
function isVisible()
    return window:isVisible()
end

-------------------------------------------------------------------------------
--
function setCurId(a_id, a_styleAirports)
    vdata.curAirdromId = a_id
    
    if a_styleAirports == true then
        vdata.style = 'airports'
    else
        vdata.style = 'warehouses'
    end
    
    init()
end   

function onChange_eSearch()
	fillEqp() 
end

function onChange_addAmountEqp()
	local item = cbWeaponEqp:getSelectedItem()
	local tmpTable = getAirdrome().weapons[item.key]
    tmpTable.initialAmount  = tmpTable.initialAmount + sbWeaponEqp:getValue()
	if tmpTable.initialAmount < 0 then
		tmpTable.initialAmount = 0
	end
	if tmpTable.initialAmount > 1000000 then
		tmpTable.initialAmount = 1000000
	end
	
	fillEqp() 
end
