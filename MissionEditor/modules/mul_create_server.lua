local base = _G

module('mul_create_server')

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
local MsgWindow         = require('MsgWindow')
local DialogLoader      = require('DialogLoader')
local net               = require('net')
local Static            = require('Static')
local Skin              = require('Skin')
local textutil          = require('textutil')
local lfs 				= require('lfs')
local Tools 			= require('tools')
local Button			= require('Button')
local Gui               = require('dxgui')
local server_list       = require('mul_server_list')
local FileDialogFilters	= require('FileDialogFilters')
local MeSettings	 	= require('MeSettings')
local FileDialog 		= require('FileDialog')
local ListBoxItem       = require('ListBoxItem')
local DcsWeb            = require('DcsWeb')
local Advanced          = require('mul_advanced')
local IntegrityCheck    = require('mul_IntegrityCheck')
local waitScreen        = require('me_wait_screen')
local Chat		        = require('mul_chat')
local music             = require('me_music')
local FileDialogUtils	= require('FileDialogUtils')
local nickname          = require('mul_nickname')
local TableUtils        = require('TableUtils')
local UC				= require('utils_common')
local advGrid           = require('advGrid')
local Analytics			= require("Analytics")
local ProductType		= require('me_ProductType') 

i18n.setup(_M)

cdata = 
{
    multiplayer         = _("MULTIPLAYER"),
    ServerSettings      = _("SERVER SETTINGS"),
    ServerName          = _("Server name"),
    password            = _("Password"),
    playersUpTo         = _("Player limit"),
    ip                  = _("Public IP"),
    port                = _("Port"),
    ServerDesc          = _("Server Description"),
    publicServer        = _("Public server"),
    MissionList         = _("Mission list"),
    save_as             = _("SAVE AS"),
    Open                = _("OPEN"),
    Back                = _("BACK"),
    Start               = _("START"),
    
    addMission          = _('Choose mission file to add'), 
    openListMissions    = _('Choose mission list file to open'),    
    saveListMissions    = _('Save mission list file'),  

    welcome             = _('Welcome to our DCS server!'),   
    Advanced            = _('Advanced'),
    
    tool_Shuffle        = _('Shuffle'),
    tool_Loop           = _('Loop '),
    Player              = _("Player"),
    IntegrityCheck      = _("Integrity Check"),
    
}

local settingsServer = {}

local defaultSettingsServer = {}   
local version = 1
local returnScreen = nil
local forceMiz = nil
    

--------------------------------------------------
-- 
function create()
    w, h = Gui.GetWindowSize()
    window = DialogLoader.spawnDialogFromFile("MissionEditor/modules/dialogs/mul_create_server.dlg", cdata)    
    local container = window.main_panel
 --   container:setBounds(parent:getBounds())
    parent = parent
 
    local main_panel = window.main_panel
    
    pWork                   = main_panel.pWork
    pCenter                 = pWork.pCenter
    pNoVisible              = window.pNoVisible 
    pBtn                    = main_panel.pBtn 
    pUp                     = main_panel.pUp
    pLeftUp                 = pCenter.pLeftUp
    pLeftDown               = pCenter.pLeftDown 
    pRight                  = pCenter.pRight
    pRDBtn                  = pRight.pRDBtn
    pRTbtn                  = pRight.pRTbtn
	gridMissions 			= pRight.gridMissions
    eServerDesc             = pLeftDown.eServerDesc    
    
    tbShuffle               = pRight.pRTbtn.tbShuffle
    tbLoop                  = pRight.pRTbtn.tbLoop
    
    btnOpen                 = pRDBtn.bOpen
    btnSaveAs               = pRDBtn.bSaveAs
    btnDel                  = pRDBtn.bDel
    btnAdd                  = pRDBtn.bAdd
    btnDown                 = pRDBtn.bDown
    btnUp                   = pRDBtn.bUp
  
	btnClose				= pUp.btnClose
    btnBack                 = pBtn.btnBack
    btnStart                = pBtn.btnStart
    sLoginNickname          = pCenter.sLoginNickname
    ePort                   = pLeftUp.ePort
    eIP                     = pLeftUp.eIP
    spPlayers               = pLeftUp.spPlayers
    eServerName             = pLeftUp.eServerName
    cbPublicServer          = pLeftUp.cbPublicServer
    ePassword               = pLeftUp.ePassword
    btnAdvanced             = pLeftUp.btnAdvanced  
	btnIntegrityCheck		= pLeftUp.btnIntegrityCheck
	
	
	staticSkinGridNormal	= pNoVisible.staticNormal:getSkin()
    staticSkinGridSelect	= pNoVisible.staticSelected:getSkin()
    staticSkinGridHover		= pNoVisible.staticHover:getSkin()
   
	gridMissionsAdv = advGrid.new(gridMissions)
	
	skinsForGrid =
    {
        all = {
            normal = staticSkinGridNormal,
            select = staticSkinGridSelect,
            hover  = staticSkinGridHover,
        },
    }    
    
    gridMissionsAdv:setSkins(skinsForGrid)
   
    resize(w, h)
    setupCallbacks()
    
    defaultSettingsServer = net.get_default_server_settings()
    
  --  base.U.traverseTable(defaultSettingsServer)
  -- base.print("-----defaultSettingsServer----")
  
	window:addHotKeyCallback('escape', onChange_btnBack)
	window:addHotKeyCallback('return', onChange_btnStart)
	
    loadSettings()

    return window
end

function resize(w, h)
    window:setBounds(0, 0, w, h)
    window.main_panel:setBounds(0, 0, w, h)
    
    local panelW = 1280
    
    pWork:setBounds((w-1280)/2, (h-768)/2 + 50, panelW, 671)
    
 --   pCenter:setBounds(0, 0, panelW, h - 44 - 59)

    pUp:setBounds((w-1280)/2, (h-768)/2, 1280, 51)
    pBtn:setBounds((w-1280)/2, (h-768)/2+768-50, 1280, 50)
    
 --   sLoginNickname:setBounds(w-420, 11, 400, 30)
    
 --   pLeftDown:setBounds(0, 380, 691, h-483)
--    eServerDesc:setBounds(20, 56, 651, h-566)

 --   pRight:setBounds(692, 41, 589, h-144)
 --   pRDBtn:setBounds(0, h-58, 589, 82)
    
end

function loadSettingsRaw()
    local tbl = Tools.safeDoFile(lfs.writedir() .. 'Config/serverSettings.lua', false)
    if (tbl and tbl.cfg and tbl.cfg.version and tbl.cfg.version > 0) then
        settingsServer = TableUtils.mergeTables(defaultSettingsServer, tbl.cfg)
    else
        settingsServer = defaultSettingsServer
    end 
	
    return settingsServer
end


function loadSettings()
    loadSettingsRaw()
    settingsServer.advanced.disable_events  = nil 
    updatePanel()
end

function saveSettings()
	updateSettingsServer()

    settingsServer.missionList = {}

    for i=0,gridMissions:getRowCount()-1 do
		settingsServer.missionList[i+1] = gridMissions:getCell(0,i).fullFileName
    end
	
	if gridMissions:getRowCount() > 0 then
		local selectedRowIndex = gridMissions:getSelectedRow()
		if selectedRowIndex < 0 then
			selectedRowIndex = 0
		end
		
		settingsServer.listStartIndex = selectedRowIndex + 1
		settingsServer.lastSelectedMission = gridMissions:getCell(0,selectedRowIndex).fullFileName
	end

    settingsServer.version = version
    U.saveInFile(settingsServer, 'cfg', lfs.writedir() .. 'Config/serverSettings.lua')	
end

function updateSettingsServer()
    settingsServer.listLoop = tbLoop:getState()
    settingsServer.listShuffle = tbShuffle:getState() 
    
    settingsServer.maxPlayers           = spPlayers:getValue()
    settingsServer.name                 = eServerName:getText()
    settingsServer.isPublic             = cbPublicServer:getState()
    settingsServer.description          = eServerDesc:getText()
    settingsServer.password             = ePassword:getText()
    settingsServer.port                 = ePort:getText()
end

local function addMission(a_fullFileName)
    local filename = U.extractFileName(a_fullFileName)
	local nameTheatre = UC.getNameTheatre(a_fullFileName)

	rowIndex = gridMissions:getRowCount()
	gridMissions:insertRow(20)
	
------1
    local cell = Static.new()
    cell:setText(filename)
    gridMissions:setCell(0, rowIndex, cell)
	cell:setSkin(staticSkinGridNormal)
	cell.fullFileName = a_fullFileName

------2
    cell = Static.new()
    cell:setText(nameTheatre)
    gridMissions:setCell(1, rowIndex, cell)
	cell:setSkin(staticSkinGridNormal)
	
	gridMissions:selectRow(rowIndex)
end

function updatePanel()
--base.U.traverseTable(settingsServer)
    tbShuffle:setState(settingsServer.listShuffle)
    tbLoop:setState(settingsServer.listLoop) 
    
    spPlayers:setValue(settingsServer.maxPlayers)
    eServerName:setText(settingsServer.name)
    cbPublicServer:setState(settingsServer.isPublic)
    eServerDesc:setText(settingsServer.description)
    ePassword:setText(settingsServer.password)
    
	gridMissions:removeAllRows()
	if forceMiz then
		settingsServer.missionList = {[1] = forceMiz,}
	end

    if (settingsServer.missionList) then
        for i = 1, #settingsServer.missionList do
            if FileDialogUtils.getFileExists(settingsServer.missionList[i]) == true then
                addMission(settingsServer.missionList[i])				
            end   
        end
		
		if gridMissions:getRowCount() > 0 then
			local selRow = 0
			for i=0,gridMissions:getRowCount()-1 do
				if settingsServer.lastSelectedMission 
					and settingsServer.lastSelectedMission == gridMissions:getCell(0,i).fullFileName then
					selRow = i
				end	
			end
			gridMissions:selectRow(selRow)
		end
    end 
end

function setupCallbacks()
	btnClose.onChange			= onChange_btnBack
    btnBack.onChange        	= onChange_btnBack
    btnOpen.onChange        	= onChange_btnOpen
    btnSaveAs.onChange     	 	= onChange_btnSaveAs
    btnAdd.onChange         	= onChange_btnAdd
    btnDel.onChange         	= onChange_btnDel
    btnDown.onChange        	= onChange_btnDown
    btnUp.onChange          	= onChange_btnUp
    btnStart.onChange       	= onChange_btnStart
    btnAdvanced.onChange    	= onChange_btnAdvanced
	btnIntegrityCheck.onChange 	= onChange_btnIntegrityCheck	
	
	gridMissions.onMouseDown 	= onMouseDown_grid

end 

function onMouseDown_grid(self, x, y, button)
	local col, row = gridMissions:getMouseCursorColumnRow(x, y)
	
	if -1 < row then
		gridMissions:selectRow(row) 
	else
		gridMissions:selectRow(-1)
	end
end

function onChange_btnAdvanced()
    Advanced.setSettings(settingsServer)
    Advanced.show(true)
end

function onChange_btnIntegrityCheck()
    IntegrityCheck.setSettings(settingsServer)
    IntegrityCheck.show(true)
end

function onChange_btnStart()
    saveSettings()
	
    local tbl = settingsServer
    tbl.missionList = {}
    
	-- формирование списка для запуска
    local selectedRowIndex = gridMissions:getSelectedRow()
	
	if selectedRowIndex < 0 then
		selectedRowIndex = 0
	end
	
	tbl.listStartIndex = selectedRowIndex + 1

    for i = 0, gridMissions:getRowCount()-1 do
		tbl.missionList[i+1] = gridMissions:getCell(0,i).fullFileName 
    end
	
    ---------------------
	--base.U.traverseTable(tbl)
	--base.print("--onChange_btnStart--")
	
	base.initTer = true
	show(false)
    waitScreen.setUpdateFunction(function()
		net.set_name(playerName)
		net.start_server(tbl)
		Analytics.pageview(Analytics.Server)
		music.stop()
			        
		if base.MapWindow.getVisible() == true then
			base.MapWindow.show(false)
		end 
    end)
end

function onChange_btnBack()
	saveSettings()
	
	if returnScreen == "mission" then
		base.panel_openfile.show(true, 'mainmenu', false)
	elseif returnScreen == "track" then
		base.panel_openfile.show(true, 'mainmenu', true)
	elseif returnScreen == "editor" then	
		base.mmw.showMissionEditor()
		if forceMiz then
			base.toolbar.loadMission(forceMiz)	
		end
	else
		if net.NO_CLIENT ~= true then
			server_list.show(true)
		else
			base.mmw.show(true)
		end
	end
    show(false)
end

function onChange_btnOpen()
    local path = MeSettings.getListMissionsPath()
    
    local filters = {FileDialogFilters.listMissions(), FileDialogFilters.listMissions()}
    local fullFileName = FileDialog.open(path, filters, cdata.openListMissions)

    if fullFileName then
        gridMissions:removeAllRows()
        local tbl = Tools.safeDoFile(fullFileName)
        if (tbl and tbl.missions) then            
            for i = 1, #tbl.missions do
                if FileDialogUtils.getFileExists(tbl.missions[i]) == true then					
                    addMission(tbl.missions[i])
                end
            end    
        end  
        MeSettings.setListMissionsPath(fullFileName)        
    end 
    updateStart()
end

function onChange_btnSaveAs()
    local path = MeSettings.getListMissionsPath()
	local filters = {FileDialogFilters.listMissions()}
    local fullFileName = FileDialog.save(path, filters, cdata.saveListMissions)
    
    if fullFileName then
        local listMissions = {}
        for i = 0, gridMissions:getRowCount()-1 do
            listMissions[i+1] = gridMissions:getCell(0,i).fullFileName
        end
        U.saveInFile(listMissions, 'missions', fullFileName)
        MeSettings.setListMissionsPath(fullFileName)
    end
end

function onChange_btnDel()
	local selectedRowIndex = gridMissions:getSelectedRow()
	
	if selectedRowIndex then
		gridMissions:removeRow(selectedRowIndex)
	end
	updateStart()
end

function onChange_btnAdd()
    local path = MeSettings.getMissionPath()
    local filters = {FileDialogFilters.mission(), FileDialogFilters.mission()}
    local fullFileName = FileDialog.open(path, filters, cdata.addMission)

    if fullFileName then        
        addMission(fullFileName)
        MeSettings.setMissionPath(fullFileName)
    end
    updateStart()
end

function changeRows(a_indexRow1, a_indexRow2)

	local cell_1_0 = gridMissions:getCell(0,a_indexRow1)
	local cell_1_1 = gridMissions:getCell(1,a_indexRow1)
	
	local cell_2_0 = gridMissions:getCell(0,a_indexRow2)
	local cell_2_1 = gridMissions:getCell(1,a_indexRow2)
	
	local tmpText = cell_1_0:getText()
	local tmpFullFileName = cell_1_0.fullFileName
	local tmpTheatre = cell_1_1:getText()
	
	cell_1_0:setText(cell_2_0:getText())
	cell_1_0.fullFileName = cell_2_0.fullFileName
	cell_1_1:setText(cell_2_1:getText())
	
	cell_2_0:setText(tmpText)
	cell_2_0.fullFileName = tmpFullFileName
	cell_2_1:setText(tmpTheatre)
end

function onChange_btnDown()
    local selectedRowIndex = gridMissions:getSelectedRow()
    if selectedRowIndex and selectedRowIndex >= 0 then
        if (selectedRowIndex + 1) < gridMissions:getRowCount() then
			changeRows(	selectedRowIndex, selectedRowIndex + 1)
			gridMissions:selectRow(selectedRowIndex + 1) 
        end        
    end
end

function onChange_btnUp()
    local selectedRowIndex = gridMissions:getSelectedRow()
    if selectedRowIndex and selectedRowIndex > 0 then
		changeRows(	selectedRowIndex, selectedRowIndex - 1)   
		gridMissions:selectRow(selectedRowIndex - 1) 	
    end
end

function show(b, a_returnScreen, a_forceMiz)
    if window == nil then
        create()
    end

    if b then 
		returnScreen = a_returnScreen
		forceMiz = a_forceMiz
        loadSettings()
        
        updateIP()
        updatePlayer()
        updateStart()
    end   

    window:setVisible(b)    
end

function updatePlayer()
    playerName = nickname:getNickname()
    if playerName == nil then
        sLoginNickname:setText(cdata.Player) 
    else
        sLoginNickname:setText(playerName)  
    end
end

function updateStart()
    if gridMissions:getRowCount() > 0 then
        btnStart:setEnabled(true)
    else
        btnStart:setEnabled(false)
    end
end

function updateIP()
    eIP:setText(DcsWeb.get_data('dcs:whatsmyip'))
    ePort:setText(settingsServer.port)
end

----------------------------------------------------------------------------------
function silentAutorizationSync()
	return DcsWeb.make_request('dcs:login')
end

----------------------------------------------------------------------------------
function forceServer()
	net.set_name("<SERVER>")    
	return net.start_server(loadSettingsRaw())
end
----------------------------------------------------------------------------------