local base = _G

module('MissionResourcesDialog')

local require				= base.require
local math					= base.math
local pairs					= base.pairs
local ipairs				= base.ipairs
local table					= base.table
local tonumber				= base.tonumber
local tostring				= base.tostring
local print					= base.print
local string				= base.string
local type 					= base.type

local DialogLoader			= require("DialogLoader")
local Menu					= require('Menu')
local loadoutUtils 			= require('me_loadoututils')
local loadLiveries 			= require('loadLiveries')
local DB					= require('me_db_api')
local OptionsData			= require('Options.Data')
local gettext				= require('i_18n')
local SkinUtils				= require('SkinUtils')
local U    					= require('me_utilities')
local AmunitionParameters 	= require('me_AmunitionParameters')
local TableUtils			= require('TableUtils')
local MenuItem 				= require('MenuItem')

_ = function(p)
	return gettext.translate(p)
end

local numbersByColumnIndex_	= {}
local menus_				= {}
local currentUnitType_
local columnDNameByNumbers = {}

local blank_run = base.blank_run

if blank_run then
	requestWeaponCount 	= function (v) return 10 end
	setLivery 			= function (v) end
	setBoardNumber 		= function (v) end
	on_cancel			= function (v) end
	on_ok				= function (v) end
	showWindow			= function (v) end
end

local cdata = 
{
	aircraftName 		= _('A-10C'),
	chaff 				= _('CHAFF'),
	flare 				= _('FLARE'),
	fuel 				= _('FUEL'),
	toWeight 			= _('TO weight, %'),
	toWeightMax 		= _('TO weight max'),
	gunAmmoType 		= _('AMMO_TYPE'),
	gunAmmo 			= _('GUN AMMO'),
	toWeightCurrent 	= _('TO weight current'),
	payload 			= _('Payload'),
	
	empty 				= _('Empty'),
	cancel 				= _("CANCEL"),
	ok	 				= _("OK"),
	totalWeight 		= _("TOTAL WEIGHT"),
	maximumWeight 		= _("MAXIMUM WEIGHT"),
	selectLoadout		= _("SELECT LOADOUT:"),
	kg					= _("KG"),
	clear				= _('REMOVE PAYLOAD'),
	available			= _('(avail: %5d) : %s'),
	not_available_weapon = _('NOT AVAILABLE : %s'),
	selectLivery		= _('SELECT LIVERY'),
	selectBoardNumber	= _('BOARD NUMBER'),
	missionResources	= _('MISSION RESOURCES'),
	missionPayload 		= _('Mission payload'),
}

local function check_pylon_not_empty(clsid)
	return clsid ~= nil and 
		   clsid ~= ""
end

function updateUnitSystem()
	local unitSystem 
	
	if not blank_run then
		unitSystem = OptionsData.getUnits()	
	else
		unitSystem = "metric"
	end	

	stcToWeightCurrentValueUnit:setUnitSystem(unitSystem)
	stcToWeightMaxValueUnit:setUnitSystem(unitSystem)
end

function updateGrid()
	gridPayloads:clear()

	local pylonsCount = loadoutUtils.getPylonsCount(currentUnitType_)
	
	if pylonsCount < 1 then 
		gridPayloads:setVisible(false)
		updateWeight()
		
		return
	else
		gridPayloads:setVisible(true)
	end
	
	local gridSkin				= gridPayloads:getSkin()
	local columnWidth			= loadoutUtils.columnWidth
	local x, y, w_g, h			= gridPayloads:getBounds()
	local x_p, y_p, w_p, h_p	= stcImage:getBounds()
	local skinParams 			= gridSkin.skinData.params
	local horzLineHeight		= skinParams.horzLineHeight
	local vertLineWidth			= skinParams.vertLineWidth
	local headerHeight			= skinParams.headerHeight

	gridPayloads:insertColumn(0) -- чтобы индексы пилонов сооответствовали индексам колонок
	
	-- добавляем толщину вертикальной линии для первого столбца с шириной 0
	local w = vertLineWidth + pylonsCount * (vertLineWidth + columnWidth) 
	
	x = x_p + w_p / 2 - w/2
	
	gridPayloads:setBounds(x, y, w, gridSkin.skinData.params.headerHeight + horzLineHeight + loadoutUtils.rowHeight)
	
	local columnIndexByNumbers = {}	
	local names	= loadoutUtils.getPylonsNames(currentUnitType_)
	local index = 0
	
	numbersByColumnIndex_ = {}
	columnDNameByNumbers = {}
	
	for i = #names, 1, -1 do
		local pylon			= names[i]	
		local columnHeader	= gridHeaderCell:clone()
		
		columnHeader:setText(pylon.DisplayName)
		columnHeader:setVisible(true)

		index = index + 1		
		
		columnIndexByNumbers[pylon.Number]	= index
		columnDNameByNumbers[pylon.Number]  = pylon.DisplayName
		numbersByColumnIndex_[index]		= pylon.Number
		
		gridPayloads:insertColumn(columnWidth, columnHeader, index)
	end
	
	local row = 0

	gridPayloads:insertRow(loadoutUtils.rowHeight, row)
	gridPayloads:setCell(0, row, nil)

	local columnCount = gridPayloads:getColumnCount()
	
	for pylonNumber, pylon in pairs(currentPayload.pylons) do
		local column = columnIndexByNumbers[pylonNumber]
		local container = nil
		
		if check_pylon_not_empty(pylon.clsid) then
			container = loadoutUtils.createPylonCell(pylon.clsid, column, row, gridPayloads, pylon.count
					, cdata.missionPayload, columnDNameByNumbers[pylonNumber], pylonNumber, callbackSettingsOk, callbackAmunitionParameters, pylon.settings)	
		end
		
		gridPayloads:setCell(column, row, container)
	end

	updateWeight()
end

function callbackAmunitionParameters(self)
	local pylon = currentPayload.pylons[self.data.pylonNumber]
	local tmpSettings = pylon.settings or loadoutUtils.getLauncherSettingsDefaultValues(self.data.launcherCLSID)	

	local settingsDef = loadoutUtils.getLauncherSettings(self.data.launcherCLSID)

	AmunitionParameters.show(true, tmpSettings, settingsDef, { pylon = self.data.pylonDisplayName, payload = (loadoutUtils.getLauncherName(self.data.launcherCLSID) or "")}, self.data.namePayload, self.data.pylonNumber, callbackSettingsOk, self.data.container)
end

function callbackSettingsOk(a_namePayload, a_pylonNumber, a_curSettings, a_container, a_tooltip)
	local pylon = currentPayload.pylons[a_pylonNumber]
	pylon.settings ={}
	TableUtils.recursiveCopyTable(pylon.settings, a_curSettings)	
	
	a_container:setTooltipText(a_container.baseTooltipText..a_tooltip)
end

local function updatePylonCell(menuItem)
	for columIndex, pylonNumber in pairs(numbersByColumnIndex_) do
			local pylon		= currentPayload.pylons[pylonNumber] or {}
			local rowIndex	= 0
			local container

			if check_pylon_not_empty(pylon.clsid) then
				container = loadoutUtils.createPylonCell(pylon.clsid, columIndex, rowIndex, gridPayloads, pylon.count
							, cdata.missionPayload, columnDNameByNumbers[pylonNumber], pylonNumber, callbackSettingsOk, callbackAmunitionParameters, pylon.settings)
			end
			
			gridPayloads:setCell(columIndex, rowIndex, container)
			updateWeight()
	end
end

local function init(wnd)
	window 		  = wnd
	window:centerWindow()

	containerMain	= window.containerMain
	
	local findWidgetByName = DialogLoader.findWidgetByName
	
	gridHeaderCell	= findWidgetByName(containerMain, 'gridHeaderCell')
	
	stcImage		= findWidgetByName(containerMain, 'stcImage')
	stcImageSkin	= stcImage:getSkin()
	stcImageSkinPicture = stcImageSkin.skinData.states.released[1].picture

	txtFlare		= findWidgetByName(containerMain, 'txtFlare'		)
	txtChaff		= findWidgetByName(containerMain, 'txtChaff'		)
	txtGunAmmo		= findWidgetByName(containerMain, 'txtGunAmmo'		)
	stcGunAmmoType	= findWidgetByName(containerMain, 'stcGunAmmoType'	)
	txtFuel			= findWidgetByName(containerMain, 'txtFuel'			)

	sldrFlare		= findWidgetByName(containerMain, 'sldrFlare'       )
	sldrChaff		= findWidgetByName(containerMain, 'sldrChaff'       )

	check_chaff_flare_slots = function (user_enter_flare)
		if currentUnit.passivCounterm ~= nil then
			local chaffSlots = sldrChaff:getValue() * currentUnit.passivCounterm.chaff.chargeSz
			local flareSlots = sldrFlare:getValue() * currentUnit.passivCounterm.flare.chargeSz
			if currentUnit.passivCounterm.SingleChargeTotal < chaffSlots + flareSlots then
				function limitOther(slotsCount, chargeSz, step)
					local newCount = math.floor((currentUnit.passivCounterm.SingleChargeTotal - slotsCount) / chargeSz)
					return step * math.floor(newCount / step)
				end
				
				if user_enter_flare then
					sldrChaff:setValue(limitOther(flareSlots, currentUnit.passivCounterm.chaff.chargeSz, sldrChaff:getStep()))
				else
					sldrFlare:setValue(limitOther(chaffSlots, currentUnit.passivCounterm.flare.chargeSz, sldrFlare:getStep()))
				end
			end
		end
		
		onUpdateWeight()
		return
	end

	sldrFlare.onChange = function () check_chaff_flare_slots(true)	 end
	sldrChaff.onChange = function () check_chaff_flare_slots(false) end

	sldrGunAmmo			= findWidgetByName(containerMain, 'sldrGunAmmo'			)
	sldrGunAmmo.onChange = onUpdateWeight

	cmbGunAmmoType		= findWidgetByName(containerMain, 'cmbGunAmmoType'		)

	sldrFuel			= findWidgetByName(containerMain, 'sldrFuel'			)
	sldrFuel.onChange = onUpdateWeight

	txtFlareCurrent		= findWidgetByName(containerMain, 'txtFlareCurrent'		)
	txtChaffCurrent		= findWidgetByName(containerMain, 'txtChaffCurrent'	    )
	txtGunAmmoCurrent	= findWidgetByName(containerMain, 'txtGunAmmoCurrent'	)
	txtFuelCurrent		= findWidgetByName(containerMain, 'txtFuelCurrent'	    )
	
	selectLivery		= findWidgetByName(containerMain, 'listBoxLivery'		)
	txtLivery			= findWidgetByName(containerMain, 'txtLivery'			)
	selectBoardNumber	= findWidgetByName(containerMain, 'editBoxBoardNumber'	)
	txtBoardNumber		= findWidgetByName(containerMain, 'txtBoardNumber'		)
	
	selectLivery.onChange 		= function(self,item)		if item and item.itemId then	setLivery(item.itemId)	end	end
	selectBoardNumber.onChange 	= function (self) 	setBoardNumber(self:getText()) end

	labelWeightCurrent	= findWidgetByName(containerMain, 'labelWeightCurrent'	)
	labelWeightMax		= findWidgetByName(containerMain, 'labelWeightMax'		)
	stcToWeightCurrentValue = findWidgetByName(containerMain, 'stcToWeightCurrentValue')
	stcToWeightMaxValue	= findWidgetByName(containerMain, 'stcToWeightMaxValue'	)
	txtUnitsCur			= findWidgetByName(containerMain, 'txtUnitsCur'			)
	
	stcToWeightCurrentValueUnit 	= U.createUnitWidget(txtUnitsCur, stcToWeightCurrentValue, U.weightUnits)
	stcToWeightMaxValueUnit 		= U.createUnitWidget(nil		, stcToWeightMaxValue, U.weightUnits)

	txtPreset			= findWidgetByName(containerMain, 'txtPreset'			)
	listBoxPreset		= findWidgetByName(containerMain, 'listBoxPreset'		)

	btnOk				= findWidgetByName(containerMain, 'btnOk'				)
	btnOk.onChange = onButtonOk

	btnCancel			= findWidgetByName(containerMain, 'btnCancel'			)
	btnCancel.onChange = onButtonCancel

	function window:onClose()
		btnCancel:onChange() 
	end	
	
	window:addHotKeyCallback('escape', function() onButtonCancel(window)  end)

	gridPayloads = findWidgetByName(containerMain, 'gridPayloads')
	
	function gridPayloads:onMouseDown(x, y, button)
		onPylonMouseDown(x, y, button)
	end

	loadoutUtils.init(	findWidgetByName(containerMain, 'staticPayloadCell'	):getSkin(), 
						findWidgetByName(containerMain, 'staticPylonCaption'):getSkin(), 
						findWidgetByName(containerMain, 'panelPylonCell'	):getSkin(),
						findWidgetByName(containerMain, 'bFuse'				):getSkin())
end

function create()
	init(DialogLoader.spawnDialogFromFile('./Scripts/UI/MissionResourcesDialog.dlg', cdata))
end

function onUpdateWeight(self, value)
	updateWeight()
end

function on_mission_stop()
	menus_	= {}
end

local function pass_ME_restricted(station,clsid)
	local p = currentPayload.pylons[station] 
	if not p then 
		print("something wrong - not found pylon "..tostring(station))
		return true
	end
	local restricted = p.restricted
	if not restricted then 
		return true
	end
	for i,o in ipairs(restricted) do 
		if o == clsid then 
			return false
		end
	end
	return true
end

local function loadout_is_authorized_for_station(station,clsid)
	if not pass_ME_restricted(station,clsid) then 
		return false
	end
	local pylon = currentUnit.Pylons[station]
	for k,launcher in pairs(pylon.Launchers) do
		if launcher.CLSID == clsid then 
			return true
		end
	end
	return false
end



local function passCivilFilter(CLSID)
	if  isCivil then 
		local atrr		= loadoutUtils.getLauncherAttribute(CLSID) or {0,0,0,0}
		return atrr[3] == 43 or  --wsType_FuelTank
			   atrr[3] == 50 or  --wsType_Smoke_Cont
			   atrr[1] == 0	
	else
		return true
	end
end


function onButtonOk(self)
	if currentUnit then
		local ammo_type = 0 
		if currentUnit.ammo_type then
			local res = cmbGunAmmoType:getSelectedItem()
			if res then
				ammo_type = res.index
			end
		end

		local outData = 
		{
			numChaff 	= tonumber(sldrChaff:getValue()),
			numFlare 	= tonumber(sldrFlare:getValue()),
			currentAmmo = tonumber(sldrGunAmmo:getValue()),
			ammoType 	= ammo_type,
			fuel 		= sldrFuel:getValue() / 100 * currentUnit.MaxFuelWeight,
			pylons 		= currentPayload.pylons or {},
		}

		on_ok(outData)-- C ++ call
	end
	show(false)
end

function onButtonCancel(self)
	on_cancel()-- C ++ call
	show(false)
end

function show(state)
	window:setVisible(state)
	if state == false then
		showWindow(false) -- C call
	end
end

function isVisible()
	return window:isVisible()
end

function get_max_chaff()
	if currentUnit.passivCounterm ~= nil then
		if currentUnit.passivCounterm.chaff.chargeSz ~= nil and 
		   currentUnit.passivCounterm.chaff.chargeSz > 0 then
		   return currentUnit.passivCounterm.SingleChargeTotal / currentUnit.passivCounterm.chaff.chargeSz
		end
	end
	
	return 0
end

function get_max_flare()
	if currentUnit.passivCounterm ~= nil then
		if currentUnit.passivCounterm.flare.chargeSz ~= nil and 
		   currentUnit.passivCounterm.flare.chargeSz > 0 then
		   return currentUnit.passivCounterm.SingleChargeTotal / currentUnit.passivCounterm.flare.chargeSz
		end
	end
	
	return 0
end

local function updatePayloadPresets()
	listBoxPreset:clear()
	listBoxPreset:setVisible(true)
	listBoxPreset.onChange = function(self,item)
		--clear all pylons
		for i,o in pairs(currentPayload.pylons) do
			o.clsid = "" 
			o.count = 0
		end
		
		local forcedPylons 
		if AddPropAircraft then
			local unitDef = DB.unit_by_type[currentUnitType_]
			if unitDef.AddPropAircraft then
				for k,v in base.pairs(unitDef.AddPropAircraft) do 				
					for kk, vv in base.pairs(AddPropAircraft) do
						if v.id == kk then
							if v.forcedPylons and v.forcedPylons[vv] then
								for kkk, vvv in base.pairs(v.forcedPylons[vv]) do
									forcedPylons = forcedPylons or {}
									forcedPylons[kkk] = vvv
								end
							end
						end
					end	
				end
			end		
		end
	
		if item and item.preset_link then
			for i,o in pairs(item.preset_link.pylons) do
				local pylon 	= currentPayload.pylons[o.num]
				if pylon then
					if loadout_is_authorized_for_station(o.num,o.CLSID) and passCivilFilter(o.CLSID) then
						if forcedPylons and forcedPylons[o.num] then
							pylon.clsid	 = forcedPylons[o.num]
							pylon.count	 = 1
						else
							pylon.clsid	 = o.CLSID
							pylon.count	 = 1
						end
					else
						local disp_name = base.get_weapon_display_name_by_clsid(o.CLSID) or ""
						print(currentUnitType_ .. " preset " .. item.preset_link.name .. 
							  ":unauthorized "..  disp_name .. " ("..o.CLSID..") "   ..
							  " for station " ..  tostring(o.num))
					end
				end
			end
		end
		updateGrid()
	end

	local payloads = loadoutUtils.getUnitPayloads(currentUnitType_)

	listBoxPreset:newItem(cdata.empty)
	--sort alpabetically	
	local tbl_ = {}
	for i,o in pairs(payloads) do
		tbl_[#tbl_ + 1] = o
	end
	table.sort(tbl_,function(o1,o2)
		return o1.name < o2.name
	end)
	------------------------------------
	for i,o in ipairs(tbl_) do
		if o.pylons and #o.pylons > 0 then
			local comboItem = listBoxPreset:newItem(o.displayName or _(o.name))
			
			comboItem.preset_link = o
		end
	end
end

local function createPylonMenu(pylonNumber)
	local pylon					= currentUnit.Pylons[pylonNumber]
	local launcherCategories	= {}
	local clean					= {}
	local categoryNames			= {}
	
	local forcedPylons 
	if AddPropAircraft then
		local unitDef = DB.unit_by_type[currentUnitType_]
		if unitDef.AddPropAircraft then
			for k,v in base.pairs(unitDef.AddPropAircraft) do 				
				for kk, vv in base.pairs(AddPropAircraft) do
					if v.id == kk then
						if v.forcedPylons and v.forcedPylons[vv] then
							for kkk, vvv in base.pairs(v.forcedPylons[vv]) do
								forcedPylons = forcedPylons or {}
								forcedPylons[kkk] = vvv
							end
						end
					end
				end	
			end
		end		
	end
	
	for i, launcher in pairs(pylon.Launchers) do
		local CLSID			= launcher.CLSID
		local category		= loadoutUtils.getLauncherCategory(CLSID)
		local categoryName	= loadoutUtils.getLauncherNames(CLSID)
		
		if category ~= nil then				
			if categoryName == "CLEAN" then
				clean[category] = CLSID
			else
				if forcedPylons == nil or forcedPylons[pylonNumber] == nil then 
					local pass_filter = passCivilFilter(CLSID) and pass_ME_restricted(pylonNumber,CLSID)
					if pass_filter then						
						if launcherCategories[category] == nil then
							launcherCategories[category] = {}
							table.insert(categoryNames, category)
						end
						
						table.insert(launcherCategories[category], {
							clsid	= CLSID, 
							name	= base.get_weapon_display_name_by_clsid(CLSID)
						})					
					end
				end
			end
		end
	end

	table.sort(categoryNames)
	
	local menu = Menu.new()
	
	menu:setSurfaceId(window:getSurfaceId())
	
	function menu:onChange(item)
		menuOnChange(item)
	end
	
	-- для каждой категории создаем подменю
	for i, categoryName in pairs(categoryNames) do
		local launchers = launcherCategories[categoryName]
		
		table.sort(launchers, function(op1, op2) return op1.name < op2.name end)
		
		local submenu = Menu.new()
		
		function submenu:onChange(item)
			submenuOnChange(item)
		end
		
		for i, launcher in ipairs(launchers) do			
			local menuItem = MenuItem.new(launcher.name)
			local filename, blendColor = loadoutUtils.getLauncherImage(launcher.clsid)
						
			if filename then		
				menuItem:setSkin(SkinUtils.setMenuItemPicture(filename, blendColor or '0x000000ff'))
			end
			
			menuItem.pylonNumber	= pylonNumber
			menuItem.launcher		= launcher
			submenu:insertItem(menuItem)
		end
		
		local menuSubItem = menu:newSubItem(categoryName)
		
		menuSubItem:setSubmenu(submenu)
	end
	
	menu:newSeparatorItem()
	
	local menuItem
	
	if forcedPylons == nil or forcedPylons[pylonNumber] == nil then 
		menuItem = menu:newItem(cdata.clear)	
		menuItem.pylonNumber = pylonNumber
		menuItem.is_remove = true
	end

	-- добавляем в меню элемент для удаления пилона
	for categoryName, launcherCLSID in pairs(clean) do
		menuItem				= menu:newItem(categoryName)
		menuItem.pylonNumber	= pylonNumber
		menuItem.launcherCLSID	= launcherCLSID
		menuItem.clean			= true			
	end
	
	return menu
end

local function getPylonMenu(create) 
	local id 	= currentUnitType_ ..'_'..tostring(currentUnitMissionID)
	local menus = menus_[id]
	
	if not menus and create then
		menus = {}
		menus_[id] = menus
		
		for columIndex, pylonNumber in pairs(numbersByColumnIndex_) do
			menus[pylonNumber] = createPylonMenu(pylonNumber)
		end
	end
	return menus
end

function update(params)
	updateUnitSystem()
	currentPayload			= params
	currentUnitType_		= params.unitType
	currentUnitMissionID	= params.missionID
	currentUnit				= DB.unit_by_type[currentUnitType_]
	isCivil					= params.isCivil
	AddPropAircraft			= params.AddPropAircraft
	if not currentPayload.emptyWeight and  currentUnit then 
		   currentPayload.emptyWeight = currentUnit.EmptyWeight
	end

	stcImageSkinPicture.file = currentUnit.Picture
	if AddPropAircraft and AddPropAircraft.modification then
		stcImageSkinPicture.file = AddPropAircraft.modification..".png"	
	end
	
	stcImage:setSkin(stcImageSkin)
	
	local allow_boardnumber = true
	local allow_livery      = true
	
	
	if not blank_run then
		if not  net then 
			net	= require('net')
		end
		if net then
			local server_settings = net.get_server_settings()
			if  server_settings  then
				allow_boardnumber	= server_settings.advanced.allow_change_tailno
				allow_livery		= server_settings.advanced.allow_change_skin
			end
		end	
	end
	
	--------------------------------------------------------
	selectBoardNumber	:setVisible(allow_boardnumber)
	txtBoardNumber		:setVisible(allow_boardnumber)
	--------------------------------------------------------
	selectLivery		:setVisible(allow_livery)
	txtLivery			:setVisible(allow_livery)
	--------------------------------------------------------

	m_chaff = get_max_chaff()
	m_flare = get_max_flare()

	local ChaffNoEdit	= false
	local CMDS_Edit		= true
	
	local chaffCount = params.numChaff
	local flareCount = params.numFlare
	
	if currentUnit.passivCounterm ~= nil then
		if currentUnit.passivCounterm.ChaffNoEdit ~= nil then
			ChaffNoEdit = currentUnit.passivCounterm.ChaffNoEdit
		end

		if currentUnit.passivCounterm.CMDS_Edit ~= nil then
			CMDS_Edit = currentUnit.passivCounterm.CMDS_Edit
		end

		if CMDS_Edit == false and currentUnit.passivCounterm.chaff.default ~= nil then
			chaffCount = currentUnit.passivCounterm.chaff.default
		end

		if CMDS_Edit == false and currentUnit.passivCounterm.flare.default ~= nil then
			flareCount = currentUnit.passivCounterm.flare.default
		end
	end

	local chaffVisible = m_chaff > 0 and not ChaffNoEdit
	local flareVisible = m_flare > 0

	txtChaff:setVisible(chaffVisible)
	txtChaffCurrent:setVisible(chaffVisible)
	sldrChaff:setVisible(chaffVisible)
	sldrChaff:setEnabled(CMDS_Edit)
	sldrChaff:setRange(0, chaffVisible and m_chaff or 100)

	txtFlare:setVisible(flareVisible)
	txtFlareCurrent:setVisible(flareVisible)
	sldrFlare:setVisible(flareVisible)
	sldrFlare:setEnabled(CMDS_Edit)
	sldrFlare:setRange(0, flareVisible and m_flare or 100)

	sldrChaff:setValue(chaffCount)
	sldrFlare:setValue(flareCount)

	local chaffStep = 1
	local flareStep = 1
	if currentUnit.passivCounterm ~= nil then
		chaffStep = currentUnit.passivCounterm.chaff.increment or 1
		flareStep = currentUnit.passivCounterm.flare.increment or 1
		if flareStep < 1 then
		   flareStep = 1
		end
		if chaffStep < 1 then
		   chaffStep = 1
		end
	end
	
	sldrChaff:setStep(chaffStep)
	sldrFlare:setStep(flareStep)
	
	if chaffStep > 1 then
		sldrChaff:setPageStep(chaffStep)
	end
	if flareStep > 1 then
		sldrFlare:setPageStep(flareStep)
	end

	sldrGunAmmo:setRange(0, 100)
	if params.maximumAmmo > 0 then
		sldrGunAmmo:setValue(math.ceil(params.currentAmmo/params.maximumAmmo*100))
		sldrGunAmmo:setVisible(true)
		txtGunAmmo:setVisible(true)
		txtGunAmmoCurrent:setVisible(true)

		if currentUnit and currentUnit.ammo_type then
			cmbGunAmmoType:setVisible(true)
			stcGunAmmoType:setVisible(true)
			cmbGunAmmoType:clear()
			local selectedItem

			local ammoType = params.ammoType or 0
			for i = 1, #currentUnit.ammo_type do
				local comboItem = cmbGunAmmoType:newItem(currentUnit.ammo_type[i])
				
				comboItem.index = i - 1
				
				if comboItem.index == ammoType then
					selectedItem = comboItem
				end
			end
			cmbGunAmmoType:selectItem(selectedItem)
		else
			cmbGunAmmoType:setVisible(false)
			stcGunAmmoType:setVisible(false)
		end
	else
		sldrGunAmmo:setValue(0)
		sldrGunAmmo:setVisible(false)
		txtGunAmmo:setVisible(false)
		txtGunAmmoCurrent:setVisible(false)

		cmbGunAmmoType:setVisible(false)
		stcGunAmmoType:setVisible(false)
	end

	local v = math.floor(0.5 + params.numFuel/currentUnit.MaxFuelWeight*100)
	sldrFuel:setValue(v)
 
	updateGrid()
	getPylonMenu(true)
	updatePayloadPresets()
	
	if  selectBoardNumber and params.boardNumber  then
		selectBoardNumber:setText(params.boardNumber)
	end
	
	if  selectLivery then
	    selectLivery:clear()	
		local selected
		local schemes = loadLiveries.loadSchemes(params.liveryEntry or params.unitType,params.countryCode)
		for k, scheme in pairs(schemes) do
			local item = selectLivery:newItem(scheme.name)
			
			item.itemId = string.lower(scheme.itemId)

			if item.itemId == params.livery then 
			   selected = item
			end
		end	
		if selected then
		   selectLivery:selectItem(selected)
		   selected = nil
		end
	end
end

function menuOnChange(item)
	local pylon = currentPayload.pylons[item.pylonNumber] or {}
	local OldlauncherCLSID = pylon.clsid
	if item.is_remove then
		pylon.clsid = ""
		pylon.count = 0
		pylon.settings = nil
		currentPayload.pylons[item.pylonNumber] = pylon
		removeRequired(OldlauncherCLSID, item.pylonNumber)
	end
	if item.clean then
		pylon.clsid = item.launcherCLSID
		currentPayload.pylons[item.pylonNumber] = pylon
		pylon.count = 1
		pylon.settings = nil
	end
	
	applyRulesToPylons(item.launcherCLSID, item.pylonNumber, pylon.settings)
	
	for pylonNumber,v in pairs(currentPayload.pylons) do
		if pylonNumber ~= item.pylonNumber then
			applyRulesToPylons(v.clsid, pylonNumber, v.settings)
		end
	end
		
	updatePylonCell(item)
end

function submenuOnChange(item)
	if (currentPayload ~= nil) and (currentPayload.pylons ~= nil) then
		local pylon = currentPayload.pylons[item.pylonNumber] or {}
		if item.launcher then
			pylon.clsid = item.launcher.clsid
			pylon.count = 1
			pylon.settings = loadoutUtils.getLauncherSettingsDefaultValues(item.launcher.clsid)
		else
			pylon.clsid = ""
			pylon.count = 0
			pylon.settings = nil
		end
		currentPayload.pylons[item.pylonNumber] = pylon
				
		applyRulesToPylons(item.launcher.clsid, item.pylonNumber, pylon.settings)
		
		for pylonNumber,v in pairs(currentPayload.pylons) do
			if pylonNumber ~= item.pylonNumber then
				applyRulesToPylons(v.clsid, pylonNumber, v.settings)
			end
		end

		updatePylonCell(item)
	end
end

function applyRulesToPylons(a_launcherCLSID, a_pylonNumber, a_settings)
	local unitDef = DB.unit_by_type[currentUnitType_]
	local proto	= unitDef.Pylons[a_pylonNumber] 
	local launchers = proto.Launchers

	for j, load in pairs(launchers) do
		if load.required and load.CLSID == a_launcherCLSID then
			for k, rule in ipairs(load.required) do				
				if rule.loadout then
					if isNotNeedChange(rule.station, rule.loadout) == false then
						local pylon = currentPayload.pylons[rule.station]
						if rule.loadout[1] then
							pylon.clsid = rule.loadout[1]
							pylon.count = 1
							if a_settings then
								pylon.settings = {}
								TableUtils.recursiveCopyTable(pylon.settings, a_settings)	
							end
						end
					end
				end
			end
		end
		
		if load.forbidden and load.CLSID == a_launcherCLSID then
			for k, rule in ipairs(load.forbidden) do
				local pylon = currentPayload.pylons[rule.station]
				if rule.loadout then
					for i, forbiddenLauncherCLSID in ipairs(rule.loadout) do
						if pylon.clsid == forbiddenLauncherCLSID then
							pylon.clsid = ""
							pylon.count = 0
							pylon.settings = nil
						end
					end	
				else	
					pylon.clsid = ""
					pylon.count = 0
					pylon.settings = nil
				end
			end
		end
	end
end

function removeRequired(a_launcherCLSID, a_pylonNumber)
	local unitDef = DB.unit_by_type[currentUnitType_]
	local proto	= unitDef.Pylons[a_pylonNumber] 
	local launchers = proto.Launchers

	for j, load in pairs(launchers) do
		if load.required and load.CLSID == a_launcherCLSID then
			for k, rule in ipairs(load.required) do				
				if rule.loadout then					
					local pylon = currentPayload.pylons[rule.station]					
					if rule.loadout[1] then
						pylon.clsid = ""
						pylon.count = 0
					end
				end
			end
		end
	end
end

function isNotNeedChange(a_station, a_ruleLoadout)
	local pylon = currentPayload.pylons[a_station]
	
	for i, o in ipairs(a_ruleLoadout) do
		if pylon.clsid == o then
			return true
		end
	end
	
	return false
end

function onPylonMouseDown(x, y, button)
	if 3 == button then
		local col, row = gridPayloads:getMouseCursorColumnRow(x, y)
		
		if 0 < col and -1 < row then
			local pylonNumber = numbersByColumnIndex_[col]
			
			local menus = getPylonMenu()
			
			if menus then
			-- формируем меню
				local menu  = menus[pylonNumber]
				------------------------------------------------------------------------------------------------
				local count = menu:getItemCount()
				for i = 1, count do
					local item 	  = menu:getItem(i - 1)				
					if item.getSubmenu then 
						local submenu = item:getSubmenu()						
						if submenu then 
							local items_count = submenu:getItemCount()
							for j = 1,items_count do
								local itemS 		  = submenu:getItem(j - 1)							
								if itemS.launcher then
									itemS.launcher.count  	= requestWeaponCount(itemS.launcher.clsid)
									if itemS.launcher.count < 1 then
										itemS:setText(string.format(cdata.not_available_weapon,itemS.launcher.name))
									elseif itemS.launcher.count < 1e5 then
										itemS:setText(string.format(cdata.available,itemS.launcher.count,itemS.launcher.name))
									else
										itemS:setText(itemS.launcher.name)	
									end
								end
							end
						end
					end
				end
				------------------------------------------------------------------------------------------------
				menu:setPosition(x, y) -- позиционируем меню
				menu:setVisible(true)
			end
		end
	end
end

function updateWeight()
	local ammo_weight_max	= 900
	local max_to_weight		= 18000
	local max_fuel_weight	= 6000
	local empty_weight		= 6000
	
	if currentUnit then
		ammo_weight_max 	= currentUnit.AmmoWeight
		max_to_weight   	= currentUnit.MaxTakeOffWeight
		max_fuel_weight 	= currentUnit.MaxFuelWeight
		empty_weight		= currentUnit.EmptyWeight
	end
	
	local payloadsWeight = 0
	
	if  currentPayload and currentPayload.pylons ~= nil then
		for i, pylon in pairs(currentPayload.pylons) do
			local launcher = DB.db.Weapons.ByCLSID[pylon.clsid]
			if launcher then
				payloadsWeight = payloadsWeight + launcher.Weight
			end
		end
	end
	local ammoWeight = ammo_weight_max*sldrGunAmmo:getValue()/100
	local fuel 		 = sldrFuel:getValue()*max_fuel_weight/100
 
	txtFlareCurrent:setText(sldrFlare:getValue())
	txtChaffCurrent:setText(sldrChaff:getValue())
	txtGunAmmoCurrent:setText(sldrGunAmmo:getValue() .. '%')
	txtFuelCurrent:setText(sldrFuel:getValue() .. '%')
 
  
	local total		= empty_weight + payloadsWeight + ammoWeight + fuel - (currentUnit.EmptyWeight - currentPayload.emptyWeight)
	max_to_weight 	= tonumber(max_to_weight)

	stcToWeightCurrentValueUnit.widget:setEnabled(total < max_to_weight)
	
	stcToWeightCurrentValueUnit:setValue(math.ceil(total))
	stcToWeightMaxValueUnit:setValue(math.ceil(max_to_weight))
end

function unit_test(wnd)
	wnd:localize(cdata)
	init(wnd)
	update({
		unitType 	= "A-10C",
		livery   	= "",
		boardNumber = "XYZMH123",
		countryCode = "RUS",
		numChaff	= 0,
		numFlare	= 0,
		numFuel     = 1000,
		currentAmmo = 0,
		maximumAmmo = 1000,
		ammoType    = 0,
		ammoSupplyMass = 100,
		pylons = 
		{
			[1] = {clsid = "",count = 0},
			[2] = {clsid = "",count = 0},
			[3] = {clsid = "",count = 0},
			[4] = {clsid = "",count = 0},
			[5] = {clsid = "",count = 0},
			[6] = {clsid = "",count = 0},
			[7] = {clsid = "",count = 0},
			[8] = {clsid = "",count = 0},
			[9] = {clsid = "",count = 0},
			[10] = {clsid = "",count = 0},
			[11] = {clsid = "",count = 0},
		}
	})
end

