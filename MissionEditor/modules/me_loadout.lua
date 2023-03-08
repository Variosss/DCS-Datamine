-- модуль выбора подвесок для ЛА
local base = _G

module('me_loadout')

local require = base.require
local pairs = base.pairs
local ipairs = base.ipairs
local table = base.table
local tostring = base.tostring
local math = base.math
local string = base.string
local print = base.print
local assert = base.assert
local next = base.next

-- Модули LuaGUI
local DialogLoader      = require('DialogLoader')
local MsgWindow         = require('MsgWindow')
local U                 = require('me_utilities')
local Size              = require('Size')
local loadoutUtils      = require('me_loadoututils')
local DB                = require('me_db_api')
local panel_payload     = require('me_payload')
local panel_aircraft    = require('me_aircraft')
local panel_paramFM     = require('me_paramFM')
local Mission 			= require('me_mission')
local MeSettings      	= require('MeSettings')
local ProductType 		= require('me_ProductType') 
local DemoSceneWidget 	= require('DemoSceneWidget')
local loadLiveries		= require('loadLiveries')
local ListBoxItem		= require('ListBoxItem')
local S					= require('Serializer')
local MapWindow			= require('me_map_window')
local UpdateManager		= require('UpdateManager')
local lfs 				= require('lfs')
local Static            = require('Static')
local Button			= require('Button')
local textutil          = require('textutil')
local panel_waitDsbweb 	= require('me_waitDsbweb')
local TableUtils		= require('TableUtils')
local AmunitionParameters = require('me_AmunitionParameters')

require('i18n').setup(_M)

local gettext = require("i_18n")

local function _translate(str)
	return gettext.dtranslate("payloads", str)
end

local currentUnitType = nil
local currentTaskWorldID = nil
local columnIndexByNumbers = {}
local numbersByColumnIndex = {}
local columnDNameByNumbers = {}
local DSWidget
local lastPreviewType
local previewParamsByType = {}

previewParamsByType.versoin = 1

cdata = 
{
	title = _('PAINT AND LOADOUT'),
	empty = _('Empty'),
	weapon = _('WEAPON'), 
	loadout = _('LOADOUT'),
	ok = _('OK'),
	cancel = _('CANCEL'),
	yes = _('YES'),
	no = _('NO'),
	list = _('LIST'),
	copy = _('COPY'),
	add = _('ADD'),
	pylon = _('PYLON'),
	of = _('OF'),
	new = _('NEW'),
	save = _('SAVE'),
	delete = _('DELETE'),
	reset = _('RESET'),
	export = _('EXPORT'),
	rename = _('RENAME'),
	enter_payload_name = _('Enter payload name:'),
	new_payload = _('New Payload'),
	copy_ = _('Copy '),
	delete_payload = _('Delete payload '),
	delete_payload_from_task = _('Delete payload %s from task %s?'),
	payload_name_is_not_unique = _('Payload name is not unique!\nPayload %s is used in tasks:'),
	payload_name_is_not_valid = _('Payload name is not valid (empty or contains \' or ")!'),
	invalid_mission_payload	= _('Mission payload is not equal to any unit payload. Save mission payload?'), 
	save_payload = _('SAVE PAYLOAD'),
	error = _('ERROR'),
	remove = _('REMOVE'),
	export_payload_to_task = _('Export payload to task:'),
	missionPayload = _('Mission payload'),
	color_scheme = _('PAINT SCHEME'),
	standard = _('Standard'),
	PayloadRestriction = _('PAYLOAD RESTRICTION'),
	notAvailable = _('Not supported'),
	Restriction = _('Restriction'),
}

if ProductType.getType() == "LOFAC" then
    cdata.invalid_mission_payload	= _('Mission payload is not equal to any unit payload. Save mission payload?-LOFAC')
end

vdata =
{
	onboard_num = '101',
	weight = 0,
	empty_weight = 0,
	max_take_off_weight = 0,
	max_fuel_weight = 0,
	fuel = 0
}

local x_
local y_
local w_
local h_

local gridHeaderCell_

function create(x, y, w, h)
	x_ = x
	y_ = y
	w_ = w
	h_ = h
	
	window = DialogLoader.spawnDialogFromFile('MissionEditor/modules/dialogs/me_loadout_panel.dlg', cdata)

	gridHeaderCell_ = window.pNoVisible.gridHeaderCell
	staticPayloadCellMSkin = window.pNoVisible.staticPayloadCellM:getSkin()
	staticPayloadCellSkin = window.pNoVisible.staticPayloadCell:getSkin()
	staticPylonCaptionSkin = window.pNoVisible.staticPylonCaption:getSkin()
	panelPylonCellSkin = window.pNoVisible.panelPylonCell:getSkin()
	bFuseSkin = window.pNoVisible.bFuse:getSkin()
	bCellRestSkin = window.pNoVisible.bCellRest:getSkin()
	bCellNoSkin = window.pNoVisible.bCellNo:getSkin()
	bCellSkin = window.pNoVisible.bCell:getSkin()
	
	loadoutUtils.init(	staticPayloadCellSkin, 
						staticPylonCaptionSkin, 
						panelPylonCellSkin,
						bFuseSkin)

	grid = window.grid
	gridRest = window.gridRest
--	gridRest:setVisible(false)
	containerButtons = window.containerButtons
	sColorScheme = window.sColorScheme
	
	gridM = window.gridM
	
	c_color_scheme = window.c_color_scheme
    function c_color_scheme:onChange(item)
        base.panel_route.vdata.unit.livery_id = item.itemId
        vdata.livery_id = item.itemId
        updatePreviewLivery()  
    end
	
	cbPayloadRest = window.cbPayloadRest
	function cbPayloadRest:onChange()
		setPayloadRestriction(cbPayloadRest:getState())	
		if cbPayloadRest:getState() == false then
			updateGrid()
		end
    end
	
	loadPreviewParamsByType()
	
	function window:onClose()
		show(false)	
	end

	function grid:onMouseDown(x, y, button)
		onPylonMouseDown(x, y, button)
	end	 
	
	function gridM:onMouseDown(x, y, button)
		onMisPylonMouseDown(x, y, button)
	end	 

	function containerButtons.buttonNew:onChange()
		onNew()
	end

	function containerButtons.buttonCopy:onChange()
		onCopy()
	end

	function containerButtons.buttonDelete:onChange()
		onDel()
	end

	function containerButtons.buttonRename:onChange()
		onRename()
	end

	function containerButtons.buttonExport:onChange()
		onExport()
	end
end

function resizeWindow()
	window:setBounds(x_, y_, w_, h_)
	local cx, cy = window:getClientRectSize()
	local offset = 8

	local buttonsWidth, buttonsHeight = containerButtons:getSize()
	local containerButtonsY = cy - buttonsHeight - 8
	local gridWidth = cx - 16 - 8
	local wds = gridWidth
	local hds = h_/2
	
	DSWidget:setBounds(16, offset, wds, hds)
	base.preview.onChangeSize(gridWidth, hds)
	offset = offset + hds + 8
	
	sColorScheme:setPosition(24, offset)
	c_color_scheme:setPosition(125, offset)
	cbPayloadRest:setPosition(645, offset)
	offset = offset + 20 + 8
	
	gridM:setBounds(16, offset, gridWidth, 70) -- подвеска миссии
	offset = offset + 70 + 8
	
	gridHeight = cy - offset - buttonsHeight - 16
	grid:setBounds(16, offset, gridWidth, gridHeight)
	gridRest:setBounds(16, offset, gridWidth, gridHeight)
	offset = offset + gridHeight + 8
	
	containerButtons:setPosition(16, offset)	 
end


function getNotFixedPayload(rowIndex)
	return grid:getCell(0, rowIndex).fixed ~= true
end

function getCurrentPayloadName()
	local rowIndex = grid:getSelectedRow()

	if -1 < rowIndex  then 
		local payloadName = grid:getCell(0, rowIndex).payloadName
		return grid:getCell(0, rowIndex).payloadName
	end
	return
end

local function createNewNameWindow_()
	local w = 400
	local h = 100

	local result = DialogLoader.spawnDialogFromFile('MissionEditor/modules/dialogs/me_loadout_payload_name.dlg', cdata)

	function result.buttonCancel:onChange()
		result:close()
	end
	
	return result
end

-- модальное окно для задания нового либо правки существующего имени подвески
local function showNewNameWindow_(name, onOkButtonFunc)
	if not newNameWindow then
		newNameWindow = createNewNameWindow_()
		
		newNameWindow.onReturn = function()
			newNameWindow.buttonOk.onChange()
		end
		
		newNameWindow:addHotKeyCallback('escape', newNameWindow.buttonCancel.onChange)
		newNameWindow:addHotKeyCallback('return', newNameWindow.onReturn)
	end

	newNameWindow.buttonOk.onChange = onOkButtonFunc
	newNameWindow.editBoxName:setText(name)

	newNameWindow:centerWindow()
	newNameWindow:setVisible(true)
	-- выход из этой функции произойдет после закрытия окна
end

local function createExportWindow_()
	local result = DialogLoader.spawnDialogFromFile('MissionEditor/modules/dialogs/me_loadout_payload_export.dlg', cdata)

	function result.buttonOk:onChange()
		local item = result.listBoxTasks:getSelectedItem()

		if item then
			local taskId = loadoutUtils.getTaskWorldID(item:getText())
			local payloadName = getCurrentPayloadName()
			
			loadoutUtils.addTaskToPayload(currentUnitType, payloadName, taskId)
			result:setVisible(false)
		end
	end

	function result.buttonCancel:onChange()
		result:close()
	end

	return result
end

-- окно со списком задач, в которые можно импортировать текущую подвеску
local function showExportWindow_()
	if not exportWindow then
		exportWindow = createExportWindow_()
	end

	-- формируем список задач для текущего юнита
	local taskNames = {}
	local taskIds = loadoutUtils.getUnitTasks(currentUnitType)
	
	for i, taskWorldID in pairs(taskIds) do
		-- текущую задачу не добавляем в список
		if taskWorldID ~= currentTaskWorldID then
			local taskName = loadoutUtils.getTaskName(taskWorldID)
			
			table.insert(taskNames, taskName)
		end
	end
	
	table.sort(taskNames)

	-- заполняем список
	U.update_list(exportWindow.listBoxTasks, taskNames)

	exportWindow:centerWindow()
	exportWindow:setVisible(true)
	-- выход из этой функции произойдет после закрытия окна
end

local function getUnitHasPylons(unitType)
	return loadoutUtils.getPylonsCount(unitType) > 0
end

-- создание новой подвески
function onNew()
	-- если юнит не имеет точек подвески, то ничего не делаем
	if not getUnitHasPylons(currentUnitType) then
		return
	end

	local function onChange_()
		if createPayload(newNameWindow.editBoxName:getText()) then
			newNameWindow:setVisible(false)
		end
	end

	-- показываем окно выбора имени подвески
	showNewNameWindow_(cdata.new_payload, onChange_)
end

function onCopy()
	local payloadName = getCurrentPayloadName()
	
	local function onChange_()
		local newName = newNameWindow.editBoxName:getText()
		
		if copyPayload(newName, payloadName) then
			newNameWindow:setVisible(false)
		end 
	end
	
	showNewNameWindow_(cdata.copy_ .. (payloadName or cdata.missionPayload), onChange_)

end

function onDel()
	local rowIndex = grid:getSelectedRow()

	if -1 < rowIndex and getNotFixedPayload(rowIndex) then
		local payloadName = getCurrentPayloadName()
		local caption = cdata.delete_payload
		local text
		
		if currentTaskWorldID == loadoutUtils.getDefaultTaskWorldID() then
			text = cdata.delete_payload .. payloadName .. '?'
		else
			local taskName = loadoutUtils.getTaskName(currentTaskWorldID)
			
			text = string.format(cdata.delete_payload_from_task, payloadName, taskName)
		end
		
		local handler = MsgWindow.question(text, caption, cdata.yes, cdata.no)

		function handler:onChange(buttonText)
			if buttonText == cdata.yes then
				deletePayload(payloadName)
			end
		end

		handler:show()
	end
end

function onRename()
	local rowIndex = grid:getSelectedRow()

	if -1 < rowIndex and getNotFixedPayload(rowIndex) then
		local payloadName = getCurrentPayloadName()
		local function onChange_()
			local newName = newNameWindow.editBoxName:getText()
			
			if renamePayload(newName) then
				newNameWindow:setVisible(false)
			end
		end
		showNewNameWindow_(payloadName, onChange_)
	end
end

function onExport()
	local rowIndex = grid:getSelectedRow()

	if -1 < rowIndex and getNotFixedPayload(rowIndex) then 
		showExportWindow_()
	end
end

function isPayloadNameValid(payloadName)
	if loadoutUtils.getPayloadNamePresented(currentUnitType, payloadName) then
		local caption = cdata.error
		local text = string.format(cdata.payload_name_is_not_unique, payloadName)
		local payloadTaskIds = loadoutUtils.getPayloadTasks(currentUnitType, payloadName)
		local tasksList
		if payloadTaskIds and #payloadTaskIds > 0 then
			tasksList = ''
			
			for i, taskId in ipairs(payloadTaskIds) do
				local taskName = loadoutUtils.getTaskName(taskId)
				
				tasksList = tasksList .. '\n' .. (taskName or "")
			end
		else
			local defaultTaskName = loadoutUtils.getTaskName(loadoutUtils.getDefaultTaskWorldID())
			
			tasksList = '\n' .. defaultTaskName
		end
		
		MsgWindow.error(text .. tasksList, caption, cdata.ok):show()
		
		return false
	end

	if not loadoutUtils.isPayloadNameValid(payloadName) then
		MsgWindow.error(cdata.payload_name_is_not_valid, cdata.error, cdata.ok):show()
		
		return false
	end

	return true 
end

-- создание новой подвески
function createPayload(payloadName)
	local result = isPayloadNameValid(payloadName)
	
	if result then
		-- создаем новую пустую подвеску
		loadoutUtils.addPayload(currentUnitType, payloadName)
		loadoutUtils.addTaskToPayload(currentUnitType, payloadName, currentTaskWorldID)
		
		--tblContainers[payloadName] = {}
		local row = addPayloadRow(payloadName, nil)
		
		selectPayload(row)
	end

	return result
end

function renamePayload(newName)
	local payloadName = getCurrentPayloadName()

	if newName == payloadName then -- новое имя совпадает со старым
		return true -- ничего не делаем
	end

	local result = isPayloadNameValid(newName)
	
	if result then
		loadoutUtils.renamePayload(currentUnitType, payloadName, newName)
		vdata.payload = newName

		-- обновляем таблицу
		local row = grid:getSelectedRow()
		local widget = grid:getCell(0, row)
		
		loadoutUtils.setPayloadCell(newName, widget, nil)
	end
	
	return result
end

function addPayloadRow(payloadName, displayName)
	-- обновляем таблицу
	-- добавляем строку в таблицу
	grid:insertRow(loadoutUtils.rowHeight)

	local row = grid:getRowCount() - 1

	-- выделяем строку и делаем ее видимой
	grid:setRowVisible(row)

	-- заполняем имя подвески
	local widget = loadoutUtils.createPayloadCell(payloadName, displayName or payloadName)
	
	grid:setCell(0, row, widget)

	-- заполняем ячейки пилонов
	local pylons = loadoutUtils.getUnitPylons(currentUnitType, payloadName)
	local columnCount = grid:getColumnCount()
	
	for pylonNumber, pylon in pairs(pylons) do
		local column = columnIndexByNumbers[pylonNumber]
		
		local widget = loadoutUtils.createPylonCell(pylon.CLSID, column, row, grid, nil, payloadName, 
						columnDNameByNumbers[pylonNumber], pylonNumber, callbackSettingsOk, callbackAmunitionParameters, pylon.settings)

		grid:setCell(column, row, widget)
	end
	
	return row
end

function copyPayload(newName, payloadName)
	local result = isPayloadNameValid(newName)
	
	if result then
		if payloadName then
			if payloadName ~= cdata.empty then
				loadoutUtils.copyPayload(currentUnitType, payloadName, newName)
			else
				loadoutUtils.addPayload(currentUnitType, newName)
				loadoutUtils.addTaskToPayload(currentUnitType, newName, currentTaskWorldID)
			end	
		else		
			local missionPylons = gridM:getCell(0, 0).pylons
			loadoutUtils.copyMissionPayload(currentUnitType, missionPylons, currentTaskWorldID, newName)
		end
		
		--tblContainers[newName] = {}
		local row = addPayloadRow(newName, nil)	
		
		selectPayload(row)
	end

	return result
end

function deletePayload(payloadName)
	-- если задача дефолтная, то удаляем подвеску из списка подвесок юнита
	-- иначе удаляем задачу из списка задач подвески
--	local isDefaulTask = (loadoutUtils.getDefaultTaskWorldID() == currentTaskWorldID)
	
--	if isDefaulTask then		
		loadoutUtils.deletePayload(currentUnitType, payloadName)
--	else
--		loadoutUtils.removeTaskFromPayload(currentUnitType, payloadName, currentTaskWorldID)
--	end	
	
	-- текущая подвеска
	local row = grid:getSelectedRow()

	-- новая подвеска
	local newRow

	if grid:getRowCount() - 1 == row then
		-- если строка последняя, то выделяем предыдущую строку
		newRow = row - 1
	else
		-- иначе выделяем следующую подвеску
		newRow = row
	end

	-- удаляем строку из таблицы
	grid:removeRow(row)

	selectPayload(newRow)
end

-- рассчитывает вес подвески
function updatePayloadWeight(a_pylons, a_unitType)
	vdata.weight, vdata.fuel = loadoutUtils.calcPayloadWeight(a_pylons, a_unitType)
	panel_payload.update()	
end

-- устанавливаем подвеску в миссии
function selectPayload(row)
	local pylons = {}
	local cell = grid:getCell(0, row)
	
	if cell == nil then 
		return
	end
	
	local payloadName = cell.payloadName

	if getNotFixedPayload(row) then -- первая строка таблицы - пустая подвеска
		pylons = loadoutUtils.getUnitPylons(currentUnitType, payloadName)
	end

	if loadoutUtils.isUnitHelicopter() or loadoutUtils.isUnitPlane() then
		panel_aircraft.setUnitPayload(pylons, payloadName)
	end

	grid:selectRow(row)
	grid:setRowVisible(row)
    if row ~= 0 then
        panel_payload.setHardpointRacks(true)
        panel_paramFM.updateCtrlEmptyOnly(true)
    end

	updatePayloadWeight(pylons, currentUnitType)
	updatePayload()
	updateMissionPayload()
end

function setWeaponRestricted(a_weaponRestricted, a_state)
	if base.panel_route.vdata.unit then
		local pylons = DB.unit_by_type[base.panel_route.vdata.unit.type].Pylons
		local weaponRestricted =  base.panel_route.vdata.unit.payload.restricted or {}
		local weaponRestrictedUnit =  {}
		
		
		for k, pylon in base.pairs(pylons) do
			for kk, v in base.pairs(pylon.Launchers) do
				weaponRestrictedUnit[v.CLSID] = weaponRestrictedUnit[v.CLSID] or {}
				local enable = true
				if weaponRestricted[pylon.Number] then
					for kkk, CLSID in base.pairs(weaponRestricted[pylon.Number]) do
						if CLSID == v.CLSID then
							enable = false
						end
					end					
				end
				
				if enable == true then -- если оружие уже запрещено - не форсируем разрешение
					for wrCLSID, value in base.pairs(a_weaponRestricted) do
						if v.CLSID == wrCLSID then
							if a_state == true then
								enable = value
							else
								enable = not value
							end
							if enable == false then
								removeLauncherInMP(v.CLSID, pylon.Number)
							end
						end
					end
				end		
				
				weaponRestrictedUnit[v.CLSID][pylon.Number] = enable
			end
		end
		updateWeaponRestricted(weaponRestrictedUnit)		
	end		
end


-- Открытие/закрытие панели
function show(b)			
	window:setVisible(b)

	if b then
		init3D()
		grid:clear()
		gridM:clear()
		gridRest:clear()
		panel_waitDsbweb.show(true)	
		UpdateManager.add(function()
			setPayloadRestriction(cbPayloadRest:getState())
			update()
			MapWindow.showMap(false)					
			-- удаляем себя из UpdateManager
			return true
		end)		
	else
		savePreviewParamsByType()
		MapWindow.showMap(true)
	end
end

function loadPreviewParamsByType()
	local path = base.userDataDir.."loadoutParams.lua"
	local a, errB = lfs.attributes(path)
	if a and a.mode == 'file' then
        local f = base.loadfile(path) 
        if f then    
            local env = {}
            base.setfenv(f, env)
            local ok, res = base.pcall(f)
			if not ok then
				log.error('ERROR: loadPreviewParamsByType() failed to pcall "'..path..'": '..res)
				return
			end

            previewParamsByType = env.loadoutParams
        end    
	end
end

function savePreviewParamsByType()
	 U.saveInFile(previewParamsByType, 'loadoutParams', base.userDataDir.."loadoutParams.lua")    
end

function getUnitsPayload()
    return loadoutUtils.getUnitsPayload()
end

-- удаляет оружие у текущего юнита из текущей подвески с пилона pylonNumber
function removePylonLauncher(pylonNumber)
	local payloadName = vdata.payload	
	
	loadoutUtils.removePylonLauncher(currentUnitType, payloadName, pylonNumber)
	
	-- очищаем ячейку таблицы
	grid:setCell(vdata.col, vdata.row, nil)
	selectPayload(vdata.row)
end

function removePylonLauncher2(pylons,pylonNumber)
	local payloadName = vdata.payload	
	
	loadoutUtils.removePylonLauncher(currentUnitType, payloadName, pylonNumber)
	-- очищаем ячейку таблицы
	if -1 < grid:getSelectedRow() then	
		grid:setCell(columnIndexByNumbers[pylonNumber], vdata.row, nil)	
		pylons[pylonNumber] = nil
		selectPayload(vdata.row)
	else
		gridM:setCell(columnIndexByNumbers[pylonNumber], 0, nil)	
		pylons[pylonNumber] = nil
		panel_aircraft.setUnitPayload(pylons, payloadName)
	end
end

function removeRequired(a_pylons,a_launcherCLSIDold, a_pylonNumber)
	for pylonNumber, pylon in pairs(a_pylons) do
		local proto	= DB.unit_by_type[currentUnitType].Pylons[pylonNumber]
		local launchers = proto.Launchers
		
		for j, load in pairs(launchers) do			
			if load.required and load.CLSID == a_launcherCLSIDold then				
				if pylonNumber == a_pylonNumber and a_pylons[a_pylonNumber] then
					for k, rule in ipairs(load.required) do
						if rule.station then
							removePylonLauncher2(a_pylons, rule.station)							
						end
					end
				end
			end
		end
	end
end

function setGridCell(weapon,column,row, a_grid, payloadName, pylonNumber, settings)
	if not weapon then
		a_grid:setCell(column, row, nil)
	end
	local container = a_grid:getCell(column, row)

	if container then
		loadoutUtils.setPylonCell(container,weapon, column, row, a_grid, nil, payloadName,
					columnDNameByNumbers[pylonNumber], pylonNumber, callbackSettingsOk, callbackAmunitionParameters, settings)
	else
		container = loadoutUtils.createPylonCell(weapon, column, row, a_grid, nil, payloadName, columnDNameByNumbers[pylonNumber], pylonNumber, callbackSettingsOk, callbackAmunitionParameters, settings)
		a_grid:setCell(column, row, container)
	end		
end

function callbackAmunitionParameters(self)
	local unit = base.panel_route.vdata.unit
	local tmpSettings
	if self.data.namePayload == cdata.missionPayload then
		local pylons = loadoutUtils.getMissionPayload()
		tmpSettings = pylons[self.data.pylonNumber].settings or loadoutUtils.getLauncherSettingsDefaultValues(self.data.launcherCLSID)
	else		
		local pylons = loadoutUtils.getUnitPylons(unit.type, self.data.namePayload)
		tmpSettings = pylons[self.data.pylonNumber].settings or loadoutUtils.getLauncherSettingsDefaultValues(self.data.launcherCLSID)
	end
	
	local settingsDef = loadoutUtils.getLauncherSettings(self.data.launcherCLSID)
 
	AmunitionParameters.show(true, tmpSettings, settingsDef, { pylon = self.data.pylonDisplayName, payload = (loadoutUtils.getLauncherName(self.data.launcherCLSID) or "")}, self.data.namePayload, self.data.pylonNumber, callbackSettingsOk, self.data.container)
end

function callbackSettingsOk(a_namePayload, a_pylonNumber, a_curSettings, a_container, a_tooltip)
	local unit = base.panel_route.vdata.unit	
	if a_namePayload == base.panel_loadout.cdata.missionPayload then
		unit.payload.pylons[a_pylonNumber].settings = {}
		TableUtils.recursiveCopyTable(unit.payload.pylons[a_pylonNumber].settings, a_curSettings)		
	else
		base.loadoutUtils.setPylonSettings(unit.type, a_namePayload, a_pylonNumber, a_curSettings)
	end
	
	a_container:setTooltipText(a_container.baseTooltipText..a_tooltip)
end

-- установить оружие у текущего юнита на пилон pylonNumber
function setPylonLauncher(a_pylonNumber, a_launcherCLSID, a_settings)
	local payloadName = vdata.payload	
	local pylons
	
	if payloadName == cdata.missionPayload then
		pylons = loadoutUtils.getMissionPayload()
		pylons[a_pylonNumber] = pylons[a_pylonNumber] or {}
		pylons[a_pylonNumber].CLSID = a_launcherCLSID
		pylons[a_pylonNumber].settings = a_settings
		panel_aircraft.setUnitPayload(pylons)	
	else
		loadoutUtils.setPylonLauncher(currentUnitType, payloadName, a_pylonNumber, a_launcherCLSID, a_settings)
		pylons = loadoutUtils.getUnitPylons(currentUnitType, payloadName)
	end
	
	local column = vdata.col
	local row    = vdata.row
	
	applyRulesToPylons(a_launcherCLSID, a_pylonNumber, pylons, a_settings)
	
	for pylonNumber, pylon in base.pairs(pylons) do
		if pylonNumber ~= a_pylonNumber then
			applyRulesToPylons(pylon.clsid, pylonNumber, pylons, a_settings)
		end
	end
	
	if -1 < grid:getSelectedRow() then	
		setGridCell(pylons[a_pylonNumber].CLSID,column, row, grid, payloadName, a_pylonNumber, a_settings)
		selectPayload(row)
	else
		setGridCell(pylons[a_pylonNumber].CLSID,column, 0, gridM, payloadName, a_pylonNumber, a_settings)
	end

	local unitTypeDesc = DB.unit_by_type[base.panel_route.vdata.unit.type]
	if unitTypeDesc.HardpointRacks_Edit == true then
		panel_payload.setHardpointRacks(true)
	end	
		
	updatePayloadWeight(pylons, currentUnitType)
	updatePayload()
	updateMissionPayload()
end

function setPylonLauncher2(pylonNumber, launcherCLSID, pylons, settings)
	local payloadName = vdata.payload	
	loadoutUtils.setPylonLauncher(currentUnitType, payloadName, pylonNumber, launcherCLSID, settings)
	local column = columnIndexByNumbers[pylonNumber]
	local row    = vdata.row
	pylons[pylonNumber] = pylons[pylonNumber] or {}
	pylons[pylonNumber].CLSID = launcherCLSID
	
	if settings then
		pylons[pylonNumber].settings= {}
		TableUtils.recursiveCopyTable(pylons[pylonNumber].settings, settings)
	end

	if -1 < grid:getSelectedRow() then
		setGridCell(pylons[pylonNumber].CLSID,column, row, grid, payloadName, pylonNumber, settings)
		selectPayload(row)
	else
		setGridCell(pylons[pylonNumber].CLSID,column, 0, gridM, payloadName, pylonNumber, settings)
		panel_aircraft.setUnitPayload(pylons)	
	end
	
	updateMissionPayload()
end

function applyForbiddenRule(forbiddenRule, pylons)
	local pylonNumber = forbiddenRule.station
	local launcherCLSID = pylons[pylonNumber] and pylons[pylonNumber].CLSID
	
	if launcherCLSID then
		local forbiddenLauncherCLSIDs = forbiddenRule.loadout
		
		if forbiddenLauncherCLSIDs then
			for i, forbiddenLauncherCLSID in pairs(forbiddenLauncherCLSIDs) do
				if launcherCLSID == forbiddenLauncherCLSID then
					removePylonLauncher2(pylons,pylonNumber)
					return
				end
			end
		else
			removePylonLauncher2(pylons,pylonNumber)
		end
	end
end

function applyRequiredRule(requiredRule, pylons, a_settings)
	local pylonNumber    = requiredRule.station
	local launcherCLSID  = pylons[pylonNumber] and pylons[pylonNumber].CLSID
	local requiredCLSIDs = requiredRule.loadout

	if requiredRule.loadout then
		local first
		for i, o in ipairs(requiredRule.loadout) do
			if not first then
			   first = o
			end

			if launcherCLSID == o then				
				return true
			end
		end
		if first then		
		    setPylonLauncher2(pylonNumber,first,pylons, a_settings)
			return true
		end
	end
	return false
end

function applyRulesToPylons(a_launcherCLSID, a_pylonNumber, a_pylons, a_settings)
	local unitDef = DB.unit_by_type[currentUnitType]
	local proto	= unitDef.Pylons[a_pylonNumber]
	local launchers = proto.Launchers
	
	for j, load in pairs(launchers) do
		if load.required and load.CLSID == a_launcherCLSID then
			for k, rule in ipairs(load.required) do
				applyRequiredRule(rule, a_pylons, a_settings)
			end
		end
		
		if load.forbidden and load.CLSID == a_launcherCLSID then
			for k, rule in ipairs(load.forbidden) do
				applyForbiddenRule(rule, a_pylons)
			end
		end
	end
end

function removeLauncherInMP(a_CLSID, a_pylonNumber)
	local pylons = loadoutUtils.getMissionPayload()	
	if pylons[a_pylonNumber] and pylons[a_pylonNumber].CLSID  == a_CLSID then
		pylons[a_pylonNumber] = nil
		panel_aircraft.setUnitPayload(pylons)
		updatePayloadWeight(pylons, currentUnitType)
		updatePayload()
		updateMissionPayload()
	end
end

function menuOnChange(self, item)
	if item.removeLauncher then -- проверяем специальный флаг
		if -1 == grid:getSelectedRow() then
			-- подвеска миссии
			local pylons = loadoutUtils.getMissionPayload()
			local launcherCLSID = pylons[item.pylonNumber] and pylons[item.pylonNumber].CLSID					
			removeRequired(pylons, launcherCLSID, item.pylonNumber)
			pylons[item.pylonNumber] = nil
			panel_aircraft.setUnitPayload(pylons)
			updatePayloadWeight(pylons, currentUnitType)
			updatePayload()
			updateMissionPayload()	
		else
			-- список подвесок
			local pylons = loadoutUtils.getUnitPylons(currentUnitType, vdata.payload)	
			local launcherCLSID = pylons[item.pylonNumber] and pylons[item.pylonNumber].CLSID
			
			removePylonLauncher(item.pylonNumber)
			removeRequired(pylons, launcherCLSID, item.pylonNumber)
		end		
	end
	if item.clean then 
		setPylonLauncher(item.pylonNumber, item.launcherCLSID, nil)
	end
end

function submenuOnChange(item)
	setPylonLauncher(item.pylonNumber, item.launcherCLSID, loadoutUtils.getLauncherSettingsDefaultValues(item.launcherCLSID))
end

function onMisPylonMouseDown(x, y, button)
	if 3 == button then
		local col, row = gridM:getMouseCursorColumnRow(x, y) 
		
		if row < 0 then
			return
		end
		
		if col > 0 then -- первая ячейка - это название подвески
			local columns = gridM:getColumnCount()
			local pylonNumber = numbersByColumnIndex[col]

			vdata.col = col
			vdata.row = -1
			vdata.pylon = pylonNumber
			vdata.payload = gridM:getCell(0, row).payloadName			
			-- формируем меню
			local Year = (Mission.mission and Mission.mission.date.Year) or 2018
			local bShowEras = MeSettings.getShowEras()
			local curCLSID
			if gridM:getCell(0, row).pylons and gridM:getCell(0, row).pylons[pylonNumber] then
				curCLSID = gridM:getCell(0, row).pylons[pylonNumber].CLSID
			end	
			local menu = loadoutUtils.createPylonMenu(currentUnitType, pylonNumber, menuOnChange, submenuOnChange, vdata.payload, currentUnitIsCivil, Year, bShowEras, base.panel_route.vdata.unit.payload.restricted, curCLSID, base.panel_route.vdata.unit.AddPropAircraft)
			-- позиционируем меню
			local w, h = menu:getSize()
			menu:setBounds(x, y, w, h)
			menu:setVisible(true)
		end			
	end
	gridM:selectRow(0)
	grid:selectRow(-1) -- сбрасываем выделение в списке подвесок
end

function onPylonMouseDown(x, y, button)
	if 1 == button then
		local col, row = grid:getMouseCursorColumnRow(x, y)

		--if -1 < row and col < 1 then --TEST col < 1 
		if -1 < row then
			selectPayload(row)
			gridM:selectRow(-1) -- сбрасываем выделение в подвеске миссии
		end
	elseif 3 == button then
		local col, row = grid:getMouseCursorColumnRow(x, y) 
		
		if row < 0 then
			return
		end
		
		if col > 0 then -- первая ячейка - это название подвески
			if getNotFixedPayload(row) then -- первая строка пустая подвеска - редактировать ее нельзя
				local columns = grid:getColumnCount()
				local pylonNumber = numbersByColumnIndex[col]

				vdata.col = col
				vdata.row = row
				vdata.pylon = pylonNumber
				vdata.payload = grid:getCell(0, row).payloadName				
				-- формируем меню
				local Year = (Mission.mission and Mission.mission.date.Year) or 2018
				local bShowEras = MeSettings.getShowEras()							
				local pylons = loadoutUtils.getUnitPylons(currentUnitType, vdata.payload)
				local curCLSID	
				if pylons and pylons[pylonNumber] then					
					curCLSID = pylons[pylonNumber].CLSID
				end	
				local menu = loadoutUtils.createPylonMenu(currentUnitType, pylonNumber, menuOnChange, submenuOnChange, vdata.payload, currentUnitIsCivil, Year, bShowEras, base.panel_route.vdata.unit.payload.restricted, curCLSID, base.panel_route.vdata.unit.AddPropAircraft)
				-- позиционируем меню
				local w, h = menu:getSize()
				menu:setBounds(x, y, w, h)
				menu:setVisible(true)
			end
		end	
		
		selectPayload(row)
		gridM:selectRow(-1) -- сбрасываем выделение в подвеске миссии
	end
end

function getUnitImageFilename()
	local unit = DB.unit_by_type[currentUnitType]
	assert(unit, currentUnitType .. "!unit_by_type[]")
	local filename = unit.Picture or ''

	return filename
end

function createColumns()
	columnIndexByNumbers = {}
	columnDNameByNumbers = {}
	numbersByColumnIndex = {}
	local names = loadoutUtils.getPylonsNames(currentUnitType)
	local count = #names
	local leftColumnWidth = loadoutUtils.nameColumnWidth
	if count > 0 then
		local gx,gy,gw,gh    = grid:getBounds();

		leftColumnWidth = math.max((gw - (count * loadoutUtils.columnWidth)) / 2, loadoutUtils.nameColumnWidth)
	end
	grid:insertColumn(leftColumnWidth)
	gridM:insertColumn(leftColumnWidth)
	gridRest:insertColumn(leftColumnWidth)
	local index = 0
	for i = #names, 1, -1 do
		local pylon = names[i]	
		index = index + 1
		local columnHeader = gridHeaderCell_:clone()
		
		columnHeader:setText(pylon.DisplayName)
		columnHeader:setVisible(true)
		
		columnIndexByNumbers[pylon.Number] = index
		columnDNameByNumbers[pylon.Number] = pylon.DisplayName
		numbersByColumnIndex[index] = pylon.Number
		
		grid:insertColumn(loadoutUtils.columnWidth, columnHeader, index)
		gridM:insertColumn(loadoutUtils.columnWidth, columnHeader:clone(), index)
		gridRest:insertColumn(loadoutUtils.columnWidth, columnHeader:clone(), index)
	end
end

function updateMissionPayload()
	
	local missionPayload = loadoutUtils.getMissionPayload()
	
	-- отдельная таблица подвески миссии
	local widgetM = gridM:getCell(0, 0)
	widgetM.pylons = missionPayload
	
	for i = 1, gridM:getColumnCount() -1 do
		gridM:setCell(i, 0, nil)
	end
		
	for pylonNumber, pylon in pairs(missionPayload) do
		local column = columnIndexByNumbers[pylonNumber]
				
		if column then
			widgetM = loadoutUtils.createPylonCell(pylon.CLSID, column, 0, gridM, nil, cdata.missionPayload, columnDNameByNumbers[pylonNumber], pylonNumber, callbackSettingsOk, callbackAmunitionParameters, pylon.settings)
			gridM:setCell(column, 0, widgetM)
		end
	end
end

function createRows()
	-- первой строкой делаем текущую подвеску 
	local rowHeight = loadoutUtils.rowHeight
	local row = 0
	
	-- текущая подвеска
	local missionPayload = loadoutUtils.getMissionPayload()

	-- отдельная подвеска миссии
	gridM:insertRow(rowHeight, row)
	local widgetM = loadoutUtils.createPayloadCell(cdata.missionPayload, cdata.missionPayload)
	widgetM.payloadName = cdata.missionPayload
	widgetM.pylons = missionPayload
	gridM:setCell(0, row, widgetM)
	for pylonNumber, pylon in pairs(missionPayload) do
		local column = columnIndexByNumbers[pylonNumber]
		if column then
			widgetM = loadoutUtils.createPylonCell(pylon.CLSID, column, row, gridM, nil, cdata.missionPayload, columnDNameByNumbers[pylonNumber], pylonNumber, callbackSettingsOk, callbackAmunitionParameters, pylon.settings)
			gridM:setCell(column, row, widgetM)
		end
	end
	
	gridM:selectRow(1)
	gridM:setRowVisible(row)
	--
	
	updatePayloadWeight(missionPayload, currentUnitType)
	updatePayload()

	--  grid подвесок	
--[[	local forcedPylons 
	local unit = base.panel_route.vdata.unit
	if unit.AddPropAircraft then
		local unitDef = DB.unit_by_type[unit.type]
		if unitDef.AddPropAircraft then
			for k,v in base.pairs(unitDef.AddPropAircraft) do 				
				for kk, vv in base.pairs(unit.AddPropAircraft) do
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
]]	
--	if forcedPylons == nil then 
		grid:insertRow(rowHeight, row)
		local widget = loadoutUtils.createPayloadCell(cdata.empty, cdata.empty)
		widget.fixed = true
		grid:setCell(0, row, widget)
		row = row + 1
--	end

	local columnCount = grid:getColumnCount()
	local payloadNamesTmp = loadoutUtils.getUnitPayloadNames(currentUnitType, currentTaskWorldID) or {}
	local payloadNames = {}
	local Year = (Mission.mission and Mission.mission.date.Year) or 2018
	local bShowEras = MeSettings.getShowEras() 
	
	local function isValidYearsPayload(a_pylons)
		local result = true
		for k, pylon in base.pairs(a_pylons) do
			local tmp_in, tmp_out = DB.db.getYearsLauncher(pylon.CLSID)
			if not (tmp_in <= Year and Year <= tmp_out) then
				result = false
			end
		end
		return result
	end
	
	local function isCivilPayload(a_pylons)
		for k, pylon in base.pairs(a_pylons) do
			local tmpAttribute = loadoutUtils.getLauncherAttribute(pylon.CLSID)
			if tmpAttribute == nil or not (base.wsType_Smoke_Cont == tmpAttribute[3] or base.wsType_FuelTank == tmpAttribute[3]) then
				return false
			end
		end
		return true
	end
	
	for i, v in ipairs(payloadNamesTmp) do
		local pylons = loadoutUtils.getUnitPylons(currentUnitType, v.name)		
		local bEnable = true
		local weaponRestricted =  base.panel_route.vdata.unit.payload.restricted
		for pylonNumber, pylon in base.pairs(pylons) do
			if weaponRestricted and weaponRestricted[pylonNumber] then
				for k,v in base.pairs(weaponRestricted[pylonNumber]) do						
					if v == pylon.CLSID then
						bEnable = false
					end
				end
			end
			-- if forcedPylons and forcedPylons[pylonNumber] and forcedPylons[pylonNumber] ~= pylon.CLSID then
				-- bEnable = false
			-- end
		end	

		if bEnable and (((currentUnitIsCivil ~= true) or (currentUnitIsCivil == true and isCivilPayload(pylons) == true))
			and ((bShowEras ~= true) or (bShowEras == true and isValidYearsPayload(pylons) == true))) then
			table.insert(payloadNames, {name = v.name, displayName = v.displayName})
		end
	end
	 
	local selectPayloadName
	for i, v in ipairs(payloadNames) do
		local pylons = loadoutUtils.getUnitPylons(currentUnitType, v.name)
		if loadoutUtils.arePylonsEqual(missionPayload, pylons) then
			selectPayloadName = v.name						
		end
	end	
	
	if selectPayloadName == nil then
		local n = 0
		for k,v in base.pairs(missionPayload) do
			n = n + 1
		end
		if n == 0 then
			selectPayloadName = cdata.empty
		end
	end

	for i, v in ipairs(payloadNames) do		
		grid:insertRow(rowHeight, row)
		-- имя
		widget = loadoutUtils.createPayloadCell(v.name, v.displayName or v.name)
		grid:setCell(0, row, widget)

		local pylons = loadoutUtils.getUnitPylons(currentUnitType, v.name)

		for pylonNumber, pylon in pairs(pylons) do
			local column = columnIndexByNumbers[pylonNumber]
			if column then
				widget = loadoutUtils.createPylonCell(pylon.CLSID, column, row, grid, nil, v.displayName or v.name, columnDNameByNumbers[pylonNumber], pylonNumber, callbackSettingsOk, callbackAmunitionParameters, pylon.settings)
				grid:setCell(column, row, widget)
			end
		end
		if v.name == selectPayloadName then
			grid:selectRow(row)
			grid:setRowVisible(row)
			updatePayloadWeight(pylons, currentUnitType)
			updatePayload()
		end
		row = row + 1
	end
	
	if selectPayloadName == cdata.empty then
		selectPayload(0)
	end
end

function updateGrid()
	grid:clear()
	gridM:clear()
	gridRest:clear()
	createColumns()
	createRows()
	fillGridRest()
end

local validModel = function()
	return  DSWidget and DSWidget.modelObj and DSWidget.modelObj.valid == true
end

function updatePayload()
	if base.panel_route.vdata.unit then
		setPayload3D(base.panel_route.vdata.unit.payload.pylons)
	end
end



local function cleanWeaponStation(o)
	if o.station then
	   --base.print(string.format("DEL:<%d><%s>",o.num,o.CLSID))
	   o.station:destroy()
	   o.station = nil
	   o.CLSID   = nil
	end
end 


--- clean all weapon stations
local function cleanWeapons3D()
	if  not validModel() then
		return
	end
	local obj = DSWidget.modelObj
	
	if  obj.weapons then
		for i,o in pairs(obj.weapons) do
			cleanWeaponStation(o)
		end
		obj.weapons = nil
	end
end


local function clean3D()
	--- clean all weapon stations first - they attached to model , so they need to be cleaned first 
	cleanWeapons3D()
	-----------------------------------------------------------
	local sceneAPI = DSWidget:getScene()	
	if 	DSWidget.modelObj and DSWidget.modelObj.obj ~= nil then
		sceneAPI.remove(DSWidget.modelObj)
	end
	-----------------------------------------------------------
	DSWidget.modelObj = nil
end

local function makeWeapon3D(idx,clsid)
	if idx == nil or clsid == nil then
		return nil
	else
		local  sceneAPI = DSWidget:getScene()
		local  obj 	    = DSWidget.modelObj
		--base.print(string.format("ADD:<%d><%s>",idx,clsid))
		return sceneAPI:addWeaponStationToAircraft(obj,obj.unit_type,idx,clsid)
	end
end

local function applyWeapons3D(stations)
	-----------------------------------------
	if not validModel() or not stations then
		return
	end

	local  obj 	    = DSWidget.modelObj
	obj.weapons = {}	
	for i,o in pairs(stations) do
		if o.CLSID and o.CLSID ~= "" then	
			obj.weapons[#obj.weapons + 1] = 
			{
				num     = i, 
				station = makeWeapon3D(i,o.CLSID),
				CLSID   = o.CLSID
			}	
		end
	end
	---------------------------------------
end

setPayload3D  = function (pylons)
	if not validModel() or not pylons then
		return
	end

	local bNeedUpdate = false
	local  obj 	    = DSWidget.modelObj

	local numPilons = 0
	for k,v in base.pairs(pylons) do
		numPilons = numPilons +1
	end
	
	if obj.weapons and #obj.weapons > 0 and numPilons == #obj.weapons then			
		for i,v in base.pairs(obj.weapons) do
			if pylons[v.num] == nil or v.CLSID ~= pylons[v.num].CLSID then
				bNeedUpdate = true
			end
		end
	else
		bNeedUpdate = true
	end

	if bNeedUpdate == false then
		return
	end

	-----------------------------------------
	cleanWeapons3D()-- fully clean actual set
	-----------------------------------------
	applyWeapons3D(pylons)
	-----------------------------------------
end

function updateOnboardNumber(a_OnboardNumber)	
    if  validModel() then
        DSWidget.modelObj:setAircraftBoardNumber(a_OnboardNumber)    
    end
end

local function staticArgsSet()
    if not validModel() then
		return 
	end
	-- init value for weapon station args
	----------------------------------------------------
	local unitTypeDesc = DB.unit_by_type[DSWidget.modelObj.unit_type]
	if unitTypeDesc and unitTypeDesc.Pylons then
		for i,pylon in ipairs(unitTypeDesc.Pylons) do
			if pylon.arg ~= nil and pylon.arg_value ~= nil then
				DSWidget.modelObj:setArgument(pylon.arg,pylon.arg_value)
			end
		end
	end 
	----------------------------------------------------
	DSWidget.modelObj:setArgument(407,0.13) -- propeller 
end

function updateArguments()
	local unit = base.panel_route.vdata.unit
    local AddPropAircraft = unit.AddPropAircraft
	
    if validModel() then
		local unitTypeDesc = DB.unit_by_type[unit.type]
		if unitTypeDesc.HardpointRacks_Edit == true then
			if unit.hardpoint_racks ~= false then
				DSWidget.modelObj:setArgument(unitTypeDesc.HardpointRacksArg, 0)
			else
				DSWidget.modelObj:setArgument(unitTypeDesc.HardpointRacksArg, 1)
			end
		end

		if AddPropAircraft then		
			if unitTypeDesc.AddPropAircraft then
				for k,v in base.pairs(unitTypeDesc.AddPropAircraft) do
					if v.arg then
						if v.control == 'comboList' then
							if (AddPropAircraft[v.id] ~= nil) then
								for kk,vv in base.pairs(v.values) do
									if vv.id == AddPropAircraft[v.id] then
										DSWidget.modelObj:setArgument(v.arg, vv.value)
									end
								end
							end
						else
							if v.argTbl then
								DSWidget.modelObj:setArgument(v.arg, v.argTbl[AddPropAircraft[v.id]])
							else
								if (AddPropAircraft[v.id] == true and v.boolean_inverted ~= true)
									or (AddPropAircraft[v.id] == false and v.boolean_inverted == true) then
									DSWidget.modelObj:setArgument(v.arg,1)
								else
									DSWidget.modelObj:setArgument(v.arg,0)
								end
							end
						end
					end
				end
			end	
		end	
    end
end

local function restorePosition()
	if not DSWidget.modelObj or not DSWidget.modelObj.unit_type  then
		return 
	end
	
	local tp    = DSWidget.modelObj.unit_type
	local saved = previewParamsByType[tp]
	if saved then
		base.preview.setCurParams(saved)
	end
end

local function savePosition()
	if not DSWidget.modelObj or not DSWidget.modelObj.unit_type  then
		base.print("MODEL NOT READY")
		return 
	end
	
	local tp = DSWidget.modelObj.unit_type
	
	previewParamsByType[tp] = base.preview.getCurParams()
end

function initLiveryPreview()
	DSWidget = DemoSceneWidget.new() 
	window:insertWidget(DSWidget)
    DSWidget:setBounds(16, 8, 590, 393)
	DSWidget:loadScript('Scripts/DemoScenes/payloadPreview.lua')
	
	DSWidget:addMouseDoubleDownCallback(function(self, x, y, button)
		if button == 3 then
			base.preview.centerCamera()
			savePosition()
		end
	end)
	
	DSWidget:addMouseDownCallback(function(self, x, y, button)
		if button == 1 then
			DSWidget.bEncMouseDown = true
			DSWidget.mouseX = x
			DSWidget.mouseY = y
			DSWidget.cameraAngH = base.preview.cameraAngH
			DSWidget.cameraAngV = base.preview.cameraAngV
			self:captureMouse()
			savePosition()
		end
	end)
	
	DSWidget:addMouseUpCallback(function(self, x, y, button)
		DSWidget.bEncMouseDown = false	
		self:releaseMouse()
	end)
	
  DSWidget:addMouseMoveCallback(function(self, x, y)
		if DSWidget.bEncMouseDown == true then
			base.preview.cameraAngH = DSWidget.cameraAngH + (DSWidget.mouseX - x) * base.preview.mouseSensitivity
			base.preview.cameraAngV = DSWidget.cameraAngV - (DSWidget.mouseY - y) * base.preview.mouseSensitivity
			
			if base.preview.cameraAngV > base.math.pi * 0.48 then 
				base.preview.cameraAngV = base.math.pi * 0.48
			elseif base.preview.cameraAngV < -base.math.pi * 0.48 then 
				base.preview.cameraAngV = -base.math.pi * 0.48 
			end
			savePosition()
		end
	end)
	
	DSWidget:addMouseWheelCallback(function(self, x, y, clicks)
		base.preview.cameraDistMult = base.preview.cameraDistMult - clicks*base.preview.wheelSensitivity
		local multMax = 2.3 - base.math.mod(2.3, base.preview.wheelSensitivity)
		if base.preview.cameraDistMult > multMax then 
		   base.preview.cameraDistMult = multMax
 	    end
		savePosition()
		return true
	end)
end

function uninitialize()
	if DSWidget ~= nil then
		------------------------------
		clean3D()
        ------------------------------
		window:removeWidget(DSWidget)
        DSWidget:destroy()
        DSWidget = nil
        lastPreviewType = nil
	end
end

function updatePreviewLivery()
    if validModel() then
		local unit = base.panel_route.vdata.unit
        if unit.livery_id then
			local unitDef 			= DB.unit_by_type[unit.type]
			local liveryEntryPoint  = unitDef.livery_entry or unit.type
			DSWidget.modelObj:setLivery(unit.livery_id, liveryEntryPoint)      
		else
			DSWidget.modelObj:setLivery(nil)
        end
    end
end

function setPreviewType(a_type)
	init3D()
	
    local unitDef 			= DB.unit_by_type[a_type]
	local liveryEntryPoint  = unitDef.livery_entry or a_type
	--------------------------
	clean3D()
	-----------------------------------
	local shape = U.getShape(unitDef)
	if not shape then
	   return
	end
	
	DSWidget.modelObj = base.preview.newModel(shape)
	if DSWidget.modelObj and DSWidget.modelObj.valid == true then
		local unit = base.panel_route.vdata.unit
		DSWidget.modelObj.unit_type = a_type
		--------------------------
		staticArgsSet()		
		--------------------------		
		if unit.livery_id then
			DSWidget.modelObj:setLivery(unit.livery_id,liveryEntryPoint)	
		else			
			DSWidget.modelObj:setLivery(nil)
		end
		DSWidget.modelObj:setAircraftBoardNumber(base.panel_aircraft.getCurOnboardNumber())
		restorePosition()
		
		if unitDef then
			if unitDef.encyclopediaAnimation and unitDef.encyclopediaAnimation.args then
				for arg, value in base.pairs(unitDef.encyclopediaAnimation.args) do
					DSWidget.modelObj:setArgument(arg, value)
				end
			end
		end
		return true
	end
	return false
end

function updateLiveries()
	c_color_scheme:clear()

	local unit = base.panel_route.vdata.unit
	
    if not unit then
        return
    end

    local group = unit.boss
    local country = DB.country_by_id[group.boss.id]

	local selectedItem, firstItem
	
	local liveryEntryPoint = DB.liveryEntryPoint(unit.type)

    local schemes = loadLiveries.loadSchemes(liveryEntryPoint,country.ShortName)
 
    for k, scheme in pairs(schemes) do
        local item = ListBoxItem.new(scheme.name)
		
        item.itemId = scheme.itemId
        c_color_scheme:insertItem(item) 
    end
    
    local itemCount = c_color_scheme:getItemCount()
	local itemCounter = itemCount - 1
	
    if itemCount > 0 then			
        firstItem = c_color_scheme:getItem(0)
    end

    if unit then
        for i = 0, itemCounter do
			local item = c_color_scheme:getItem(i)
			
            if unit.livery_id == item.itemId then
                selectedItem = item
				
				break
            end
        end
    end
    
    if not firstItem then
        c_color_scheme:setText(cdata.standard)
        vdata.color_scheme = cdata.standard
        vdata.livery_id = nil
    elseif not selectedItem then
        c_color_scheme:selectItem(firstItem)
        vdata.livery_id = firstItem.itemId
    else
        c_color_scheme:selectItem(selectedItem)
        vdata.livery_id = selectedItem.itemId
    end
    
    if (unit) and (unit.livery_id == nil)  then
        unit.livery_id = vdata.livery_id
    end
end	

function init3D()
	if DSWidget == nil then
		initLiveryPreview()
		resizeWindow()
	end
end

function updateType()
	local unit = base.panel_route.vdata.unit
	if unit then
		init3D()
		
		if lastPreviewType ~= unit.type then
			if setPreviewType(unit.type, unit.AddPropAircraft) == true then
				lastPreviewType = unit.type
				updateLiveries()
			else
				lastPreviewType = nil
			end
		else
			updateLiveries()	
			updatePreviewLivery()        
		end
		updateArguments()
	end
end


function update()
	if getVisible() == false then
		return
	end
	
    if base.panel_route.vdata.unit and base.panel_route.vdata.unit.type then		
        local unitType = base.panel_route.vdata.unit.type
        if (base.me_db.helicopter_by_type[unitType] ~= nil
              or  base.me_db.plane_by_type[unitType] ~= nil) then
            currentUnitType = unitType			
			currentUnitIsCivil = base.panel_route.vdata.unit.civil_plane
            
            local currentTaskName = loadoutUtils.getCurrentTaskName()
            
            currentTaskWorldID = loadoutUtils.getTaskWorldID(currentTaskName)
            
			grid:setVisible(false)
			setPayloadRestriction(cbPayloadRest:getState())
					
			UpdateManager.add(function()	
				updateGrid()
				panel_waitDsbweb.show(false)
				return true
			end)
		else
			show(false)		
        end
		updateLiveries()
		updatePreviewLivery()  
		updateArguments()		
    end
end

function getVisible()
	return window and window:getVisible()
end

function setPayloadRestriction(a_bEnable)
	cbPayloadRest:setState(a_bEnable)
	gridRest:setVisible(a_bEnable)
	grid:setVisible(not a_bEnable)
	containerButtons:setVisible(not a_bEnable)
end

function compareTbl(tab1, tab2)
	return textutil.Utf8Compare(tab1.name, tab2.name)
end

function isCLSIDinLoadout(a_CLSID, a_loadout)
	for i, o in ipairs(a_loadout) do
		if a_CLSID == o then				
			return true
		end
	end
	return false
end
		
function fillGridRest()
	gridRest:removeAllRows()
	
	if currentUnitType == nil then
		return
	end
	
	local unitDef = DB.unit_by_type[currentUnitType]
	
	
	local weaponRestricted =  base.panel_route.vdata.unit.payload.restricted or {}
	local weaponRestrictedUnit =  {}
	
	for k, pylon in base.pairs(unitDef.Pylons) do
		for kk, v in base.pairs(pylon.Launchers) do
			weaponRestrictedUnit[v.CLSID] = weaponRestrictedUnit[v.CLSID] or {}
			local enable = true
			if weaponRestricted[pylon.Number] then
				for kkk, CLSID in base.pairs(weaponRestricted[pylon.Number]) do
					if CLSID == v.CLSID then
						enable = false
					end
				end
			end
			weaponRestrictedUnit[v.CLSID][pylon.Number] = enable
		end
	end

	local row = 0
	local tmpTbl = {}
	for launcherCLSID, pylon in base.pairs(weaponRestrictedUnit) do
		base.table.insert(tmpTbl, {	CLSID = launcherCLSID, name = loadoutUtils.getLauncherName(launcherCLSID),
								pylon = pylon})
	end
	
	base.table.sort(tmpTbl, compareTbl)
	
	for k, weapon in base.pairs(tmpTbl) do
		gridRest:insertRow(loadoutUtils.rowHeight)
		
		local cell = Static.new(weapon.name)
		cell:setTooltipText(weapon.name)
		gridRest:setCell(0, row, cell)
		cell:setSkin(staticPayloadCellMSkin)
	
		for pylonNumber, index in base.pairs(columnIndexByNumbers) do
			local cell = Button.new()
			cell.pylonNumber = pylonNumber
			cell.CLSID = weapon.CLSID
			cell.row = row
			gridRest:setCell(index, row, cell)
			cell.value = weapon.pylon[pylonNumber]
			if weapon.pylon[pylonNumber] == false then
				cell:setSkin(bCellRestSkin)
				cell:setTooltipText(cdata.Restriction)
			elseif weapon.pylon[pylonNumber] == true then
				cell:setSkin(bCellSkin)
				cell:setTooltipText(nil)
			else
				cell:setSkin(bCellNoSkin)
				cell:setTooltipText(cdata.notAvailable)
			end	
			cell.onChange = function(self)
				if cell.value ~= nil then
					local cellSkin
					local cellTooltip
					if cell.value == true then
						cell.value = false
						weaponRestrictedUnit[self.CLSID][self.pylonNumber] = false						
						cellSkin = bCellRestSkin
						cellTooltip = cdata.Restriction
					else
						cell.value = true
						weaponRestrictedUnit[self.CLSID][self.pylonNumber] = true
						cellSkin = bCellSkin
						cellTooltip = nil
					end
					cell:setSkin(cellSkin)
					cell:setTooltipText(cellTooltip)
					
					removeLauncherInMP(self.CLSID, self.pylonNumber)
					
					local pylons = DB.unit_by_type[currentUnitType].Pylons
					for k, pylon in pairs(pylons) do	
						if pylon.Number == self.pylonNumber then
							for j, load in pairs(pylon.Launchers) do	
								if load.required then													
									for k, rule in ipairs(load.required) do
										if rule.station and isCLSIDinLoadout(self.CLSID, rule.loadout) then
											local cellRequired = gridRest:getCell(columnIndexByNumbers[rule.station], cell.row)							
											cellRequired.value = cell.value
											weaponRestrictedUnit[self.CLSID][rule.station] = cell.value
											cellRequired:setSkin(cellSkin)
											cellRequired:setTooltipText(cellTooltip)
											if cell.value == false then
												removeLauncherInMP(self.CLSID, rule.station)
											end
										end
									end
								end
							end
						end
					end
					updateWeaponRestricted(weaponRestrictedUnit)
				end
			end	
		end

		row = row + 1
	end
	--grid:insertRow(loadoutUtils.rowHeight)
end

function updateWeaponRestricted(a_weaponRestrictedUnit)	
	local weaponRestricted ={}

	if a_weaponRestrictedUnit then
		for CLSID,pylon in base.pairs(a_weaponRestrictedUnit) do
			for pylonNumber,enable in base.pairs(pylon) do
				if enable == false then
					weaponRestricted[pylonNumber] = weaponRestricted[pylonNumber] or {}
					base.table.insert(weaponRestricted[pylonNumber], CLSID)	
				end
			end	
		end
	end

	base.panel_route.vdata.unit.payload.restricted = weaponRestricted
end