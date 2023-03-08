local base = _G

module('me_backup')

local require   = base.require
local ipairs    = base.ipairs
local next      = base.next


local i18n 						= require('i18n')
local DialogLoader				= require('DialogLoader')
local OptionsData 				= require('Options.Data')
local menubar 					= require('me_menubar')
local MissionModule				= require('me_mission')
local lfs						= require('lfs')
local panel_ChangingCoalitions 	= require('me_changingCoalitions') 
local CoalitionPanel			= require('Mission.CoalitionPanel')
local TriggerZonePanel			= require('Mission.TriggerZonePanel')
local Static 					= require('Static')
local Serializer 				= require('Serializer')
local Tools  					= require('tools')
local MapWindow 				= require('me_map_window')
local TableUtils				= require('TableUtils')
local waitScreen				= require('me_wait_screen')
local log      					= require('log')

i18n.setup(_M)

cdata = {
	Load 		= _("Load"),
	Exit 		= _("Exit"),
	Backup 		= _("Backup"),
	file 		= _("file"),
	dateMiz 	= _("date"),
	newMission 	= _('New Mission.miz'),
}

local lastTime = -1
local pausePrint = -1
local needBackup = false
local StackBackupsOrig = 
{
	{file = "10.miz", name = nil, dateMiz = nil},
	{file = "9.miz", name = nil, dateMiz = nil},
	{file = "8.miz", name = nil, dateMiz = nil},
	{file = "7.miz", name = nil, dateMiz = nil},
	{file = "6.miz", name = nil, dateMiz = nil},
	{file = "5.miz", name = nil, dateMiz = nil},
	{file = "4.miz", name = nil, dateMiz = nil},
	{file = "3.miz", name = nil, dateMiz = nil},
	{file = "2.miz", name = nil, dateMiz = nil},
	{file = "1.miz", name = nil, dateMiz = nil},
}
local StackBackups = nil

function create()
	window = DialogLoader.spawnDialogFromFile('MissionEditor/modules/dialogs/me_backup.dlg', cdata)
	window:setPosition(100, 100)
	
	bExit 		= window.bExit
	bLoad 		= window.bLoad
	grid 		= window.grid
	pNoVisible 	= window.pNoVisible
	
	gridStaticSkin 	= pNoVisible.gridStatic:getSkin()
	
	bExit.onChange = bExit_onChange
	bLoad.onChange = bLoad_onChange
	grid.onMouseDown = onMouseDown_grid
	
	loadStackBackups()
end

function show(b)
	window:setVisible(b)
	if b then
		updatePanel()
	end
end

function saveStackBackups()	
	local path = lfs.writedir().."Backup/Backup.lua"
	local file, err = base.io.open(path, 'w')
	
	if file then
		local s = Serializer.new(file)
		s:serialize_simple2('StackBackups', StackBackups)
		file:close()
	else
		log.error('ERROR: saveStackBackups failed: '..err)		
	end
end

function loadStackBackups()	
	local path = lfs.writedir().."Backup/Backup.lua"
	
	local env = Tools.safeDoFile(path, false)
	if env then
		StackBackups = env.StackBackups
	else
		StackBackups = TableUtils.copyTable(nil, StackBackupsOrig)
	end
end

function updatePanel()
	grid:removeAllRows()
	
	local rowIndex = 0
	if StackBackups then
		for i, v in base.ipairs(StackBackups) do
			if v.name ~= nil and v.dateMiz ~= nil then
				grid:insertRow(20)
				local cell = Static.new()
				cell:setSkin(gridStaticSkin)
				cell:setText(v.name)
				cell.file = v.file
				cell.name = v.name
				grid:setCell(0, rowIndex, cell)
				
				local cell = Static.new()
				cell:setSkin(gridStaticSkin)
				cell:setText(v.dateMiz)
				grid:setCell(1, rowIndex, cell)

				rowIndex = rowIndex + 1
			end
		end
	end
end

function isNeedCloseWindows()
	return (base.panel_trigrules.isVisible() == true 
		or panel_ChangingCoalitions.isVisible() == true
		or TriggerZonePanel.isVisible() == true)
end

function save()
	if MissionModule.check_mission(false) then
		local tmp 
		if StackBackups == nil or StackBackups[10] == nil then
			StackBackups = TableUtils.copyTable(nil, StackBackupsOrig)
		end
		tmp = StackBackups[10]
		
		if MissionModule.save_mission(lfs.writedir().."Backup/"..tmp.file, false, true) then
			StackBackups[10] = nil
			tmp.dateMiz = base.os.date('%d.%m.%Y %H:%M') 
			tmp.name = menubar.getFileName()	
			base.table.insert(StackBackups, 1, tmp)
			saveStackBackups()
			reset()		
		end
	else
		reset()
		menubar.updateTimeBackup(_("impossible to save the mission"))
		pausePrint = 5
	end	
	 
	--base.U.traverseTable(StackBackups)
	--base.print("---tmp.dateMiz--",tmp.dateMiz)
end

function reset()
	lastTime = OptionsData.getMiscellaneous('backupTime') * 60
	menubar.updateTimeBackup("")
	needBackup = OptionsData.getMiscellaneous('backup')
end

function update(a_dt)
	if needBackup == true 		
		and CoalitionPanel.isVisible() ~= true
		and window:getVisible() ~= true	then
		
		loadStackBackups()
		
		if pausePrint < 0 then
			lastTime = lastTime - a_dt
			
			if lastTime < 0 then
				if isNeedCloseWindows() == true then
					menubar.updateTimeBackup(_("waiting for the window to close"))
				else
					save()	
				end	
			else
				local minutes  = base.math.floor(lastTime/60)
				local sec = base.math.floor((lastTime/60 - minutes)*60)
			--	base.print("--fff--",minutes,sec,base.string.format("%d ".._("min").." ".."%02d ".._("sec"),minutes,sec))
				menubar.updateTimeBackup(base.string.format("%.2d"..":".."%.2d",minutes,sec))
			end
		else
			pausePrint = pausePrint - a_dt
		end
	end
end

function bExit_onChange()
	show(false)
end

function bLoad_onChange()
	local selectedRowIndex = grid:getSelectedRow()
	if -1 ~= selectedRowIndex then
		local cell = grid:getCell(0, selectedRowIndex)
		
		if cell then
			local filename = lfs.writedir().."Backup/"..cell.file
			waitScreen.setUpdateFunction(function()
				local result, err, theatre = MissionModule.load(filename)
				
				if base.isInitTerrain() == true then
					MapWindow.show(true)
					MissionModule.mission.path = nil --чтобы не писали в файл бекапа
					menubar.setFileName(cell.name)
				end
			end)
		end
	end
end

function onMouseDown_grid(self, x, y, button)
	local col, row = self:getMouseCursorColumnRow(x, y)

	if -1 < row then
		self:selectRow(row)  
	end
end