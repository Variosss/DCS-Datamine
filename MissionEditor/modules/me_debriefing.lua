local base = _G

module('me_debriefing')

local require = base.require
local string = base.string

local U					= require('me_utilities')
local lfs				= require('lfs')
local MainMenu			= require('MainMenu')
local MapWindow			= require('me_map_window')
local MenuBar			= require('me_menubar')
local Logbook			= require('me_logbook')
local Campaign			= require('me_campaign')
local Serializer		= require('Serializer')
local MissionModule		= require('me_mission')
local BriefingUtils		= require('me_briefing_utils')
local Autobriefing		= require('me_autobriefing')
local gettext			= require('i_18n')
local mod_debriefing	= require("debriefing")
local FileDialog		= require("FileDialog")
local FileDialogFilters	= require('FileDialogFilters')
local MeSettings		= require("MeSettings")
local MsgWindow			= require('MsgWindow')
local panel_waitDsbweb	= require('me_waitDsbweb')
local music				= require('me_music')
local waitScreen		= require('me_wait_screen')
local dxgui			    = require('dxgui')
local FileDialogUtils	= require('FileDialogUtils')
local log     			= require('log')
local ProductType 		= require('me_ProductType') 
local UpdateManager		= require('UpdateManager')

require('i18n').setup(_M)

-- FIXME: высота строки задается в скине
local rowHeight = 15
local window

local cdata = {
    DEBRIEFING 				= _('DEBRIEFING'),
    attrition 				= _('Attrition'),
    generalDebriefingData 	= _('General Debriefing Data'),
    red 					= _('RED'),
    blue 					= _('BLUE'),
    logFilters 				= _('Log Filters'),
    planes 					= _('PLANES'),
    helicopters 			= _('HELICOPTERS'),
    ships 					= _('SHIPS'),
    armored 				= _('ARMORED'),
    airDefence 				= _('AIR DEFENCE'),
    vehicles 				= _('VEHICLES'),
    buildings 				= _('BUILDINGS'),
    bridges 				= _('BRIDGES'),
    missionName_ 			= _('MISSION NAME:'),
    red_ 					= _('RED:'),
    blue_ 					= _('BLUE:'),
    side_ 					= _('SIDE:'),
    time_ 					= _('TIME:'),
    pilot_ 					= _('PILOT:'),
    aircraft_ 				= _('AIRCRAFT:'),
	Myvictory 				= _('MY VICTORIES'),
	Show_ 					= _('SHOW MY VICTORIES'),
	Allvictory 				= _('ALL VICTORIES'),
    task_ 					= _('TASK:'),
    initiator 				= _('INITIATOR'),
    weapon 					= _('WEAPON'),
	object 					= _('OBJECT'),
    side 					= _('SIDE'),
    event 					= _('EVENT'),
    trgSide 				= _('TRGSIDE'),
    target 					= _('TARGET'),
    noname 					= _('no name'),
    EDITMISSION 			= _('MISSION EDITOR'),
	close 					= _('CLOSE'),
    rightBtn 				= _('FLY AGAIN'),
    middleBtn 				= _('WATCH TRACK'),    
	score_					=	_('SCORE:'),
	TimeLogged_				=	_('TIME LOGGED:'),
	results_				=	_('RESULTS'),
	building				=	_('Building'),
	engine_shutdown 		= _('engine shutdown'),
	engine_startup 			= _('engine startup'),
	saveDebriefing 			= _('Save debriefing:'),
	saveTrack 				= _('Save track:'),
    debrief_save 			= _('SAVING DEBRIEFING'),
    debrief_save_error 		= _('Can not write to file:'),
    debrief_load_error 		= _('Can not open debriefing file'),
    debrief_load 			= _('LOADING DEBRIEFING'),
	yes 					= _('YES'),
    no 						= _('NO'),
	message 				= _('Your progress will be lost. Are you sure you want to continue?'),	
	messageQ 				= _('Your progress will be lost. Are you sure you want to quit?'),	
	msgReStartCamp 			= _("You are going to update the results of the mission you've played before. You will lose the campaign progress already reached after that mission. Do you want to proceed?\n(choose \"No\" if you want to keep previous mission and campaign progress results) "),
	
}

if ProductType.getType() == "LOFAC" then
    cdata.debrief_load = _('LOADING DEBRIEFING-LOFAC')
    cdata.debrief_load_error = _('Can not open debriefing file-LOFAC')
    cdata.debrief_save = _('SAVING DEBRIEFING-LOFAC')
    cdata.saveDebriefing = _('Save debriefing:-LOFAC')
    cdata.generalDebriefingData = _('General Debriefing Data-LOFAC')
end

returnScreen = 'mainmenu'

local function create_()
	window = mod_debriefing.create()
    
    b_exit = window.containerMain.pDown.btnExit
    b_EditMission = window.containerMain.pDown.btnEditMission
    b_refly = window.containerMain.pDown.btnRefly
    b_watchTrack = window.containerMain.pDown.btnWatchTrack
    b_close = window.containerMain.pTop.btnClose
	b_saveTrack = window.containerMain.pDown.btnSaveTrack
	b_save = window.containerMain.pDown.btnSaveDebriefing
    b_refly:setVisible(true)
    b_watchTrack:setVisible(true)
    b_saveTrack:setVisible(true)
    b_save:setVisible(true)
	b_endMission = window.containerMain.pDown.btnEndMission
    
    
    local width, height = dxgui.GetWindowSize()
    window:setBounds(0,0,width, height)
    window.containerMain:setBounds((width-1280)/2, (height-768)/2, 1280, 768)
    window.pMeFon:setBounds(0,0,width, height)
    window.pMeFon:setVisible(true)
    window.pSimFon:setVisible(false)
	
	local unitClasses = {'Plane', 'Helicopter', 'Ship', 'Car'}
	local dnUnitByType = {}
	for i, v in base.ipairs(unitClasses) do
		local units = base.db.Units[v..'s'][v]
		for j, unit in base.pairs(units) do
			dnUnitByType[unit.type] = unit
		end
	end
	mod_debriefing.setDBUnitsByType(dnUnitByType)
    
    function getCountryShortName(a_id)
        return base.me_db.country_by_id[a_id].ShortName
    end
    mod_debriefing.setGetCountryShortName(getCountryShortName)

    function onExit()
		if (returnScreen == 'campaign') then
			local handler = MsgWindow.warning(cdata.messageQ, _('Warning'), cdata.yes,  cdata.no)
			
			function handler:onChange(buttonText)
				if buttonText == cdata.yes then            
					selectReturnDialog()
				else

				end
			end
			handler:show()
		else
			selectReturnDialog()
		end	
    end    
	
	function selectReturnDialog()
		show(false)
        waitScreen.setUpdateFunction(function()
			--base.print('returnScreen',returnScreen);
			if returnScreen == 'mainmenu' then            
				--base.module_mission.create_new_mission();
				base.module_mission.removeMission()
				MainMenu.show(true)
			elseif returnScreen == 'training' then
			--	base.module_mission.create_new_mission();
				base.module_mission.removeMission()
				base.panel_training.show(true);
			elseif returnScreen == 'openmission' then
			--	base.module_mission.create_new_mission();
				base.module_mission.removeMission()
				base.panel_openfile.show(true, returnScreen, false);
			elseif returnScreen == 'track' then
			--	base.module_mission.create_new_mission();
				base.module_mission.removeMission()
				base.panel_openfile.show(true, returnScreen, true);
			elseif returnScreen == 'campaign' then
			--	base.module_mission.create_new_mission();
				base.module_mission.removeMission()
				Campaign.show(true);
			--	base.module_mission.create_new_mission();
			elseif (returnScreen == 'editor') then    
				if base.MISSION_PATH and ('' ~= base.MISSION_PATH) then
					base.module_mission.load(base.MISSION_PATH);
				end
				MapWindow.show(true)
				if base.test_dyn_missions == true then
					UpdateManager.add(function()
						base.rts.openDCM()
						-- удаляем себя из UpdateManager
						return true
					end)
				end
			elseif returnScreen == 'prepare' then
				if base.MISSION_PATH and ('' ~= base.MISSION_PATH) then
					base.module_mission.load(base.MISSION_PATH);
				end
				MapWindow.show(true)
			elseif returnScreen == 'missiongenerator' then
				base.mmw.show(true)
			else 
				base.module_mission.create_new_mission()
				MapWindow.show(true)
			end
        end)
	end
    
    b_exit.onChange = onExit
    b_close.onChange = onExit
    b_EditMission.onChange = onExit
    
    function b_refly:onChange()
		local function restart()
			--base.print('b_refly',returnScreen);
			Autobriefing.returnScreen = returnScreen;
			local command = '--track' 
			if returnScreen == 'editor' then
				command = "--mission" 
			end;
			
			local doNotApplyOptions = false;        
			if returnScreen == 'track' then
				doNotApplyOptions = true;
			end;
			
			music.stop()
			
			local path = base.START_PARAMS.realMissionPath or (base.tempDataDir .. base.tempMissionName)
			
			show(false)
			
			waitScreen.setUpdateFunction(function()
				params = {command = command }
				params.file = path
				params.command = params.command or ""
				if (MissionModule.play(params, returnScreen, path, doNotApplyOptions, false) == false) then
					show(true)
				end
			end)
		end
		
		if (returnScreen == 'campaign') then
			local handler = MsgWindow.warning(cdata.message, _('Warning'), cdata.yes,  cdata.no)
			
			function handler:onChange(buttonText)
				if buttonText == cdata.yes then  					
					restart()
				else
					
				end
			end
			handler:show()       
		else
			restart()
		end	
    end
	
	local function saveDebriefingOnDisk(fileName)
		if debriefing then
			local f, err = base.io.open(fileName, 'w')
			
			if f then
				local serializer = Serializer.new(f)
				
				serializer:serialize_sorted('debriefing', debriefing)
				f:close()
			else
				log.error('ERROR: saving debriefing failed: '..err)	
				return false
			end 
		else
			base.print('No debriefing to save')
		end
		
		return true
	end
	
	function b_save:onChange()
		local path = MeSettings.getDebriefingPath()
		local filters = {FileDialogFilters.debriefing()}
		local fileName = FileDialog.save(path, filters, cdata.saveDebriefing)
		
		if fileName then
			if saveDebriefingOnDisk(fileName) then
				MeSettings.setDebriefingPath(fileName)
			else	
				MsgWindow.error(cdata.debrief_save_error.." ".. fileName, cdata.debrief_save, 'OK'):show()
			end
		end
    end
    
    function b_saveTrack:onChange()
		local path = MeSettings.getTrackPath()
		local filters = {FileDialogFilters.track()}
		local preName
		if returnScreen == 'training' then  
			local fileTmp = FileDialogUtils.extractFilenameFromPath(base.START_PARAMS.realMissionPath) 
			preName = fileTmp.."_"..base.os.date('%d%m%Y_%H-%M')..".trk"
		end
		local filename = FileDialog.save(path, filters, cdata.saveTrack, 'track',preName)
		
		if filename then
			if MissionModule.saveTrack(filename, returnScreen) then
				MeSettings.setTrackPath(filename)
			end
		end
    end
	
	function b_watchTrack:onChange()
		local function watchTrack()
			local fileName = base.tempDataDir .. base.watchTrackFileName;
			local source   = base.tempDataDir .. base.trackFileName;
			if returnScreen == 'training' then
				source = lfs.writedir()..'Tracks/tempMission.miz.trk'
			end
			MissionModule.copyMission(fileName, source)
			local params = { file = fileName, command = '--track',  mission = MissionModule.mission.path};
			base.print('playing track',fileName);
			panel_waitDsbweb.show(true)
			music.stop()
			MissionModule.play(params, returnScreen, fileName, true)
			panel_waitDsbweb.show(false)
			show(false)
		end
		
		if (returnScreen == 'campaign') then
			local handler = MsgWindow.warning(cdata.message, _('Warning'), cdata.yes,  cdata.no)
			
			function handler:onChange(buttonText)
				if buttonText == cdata.yes then  
					returnScreen = 'mainmenu'
					watchTrack()
				else
					
				end
			end
			handler:show()  
		else
			watchTrack()
		end
    end
	
	function b_endMission:onChange()
		endMission()
	end
    
    window:addHotKeyCallback('escape', b_exit.onChange)
    window:addHotKeyCallback('return', b_exit.onChange)
end


function updateStatistic()
	if debriefing.events then
		Logbook.updateUserStatistics(debriefing);
	end
end

function endMission()
	local handler = MsgWindow.question(cdata.msgReStartCamp, cdata.question, cdata.yes, cdata.no)
	local success = false
	
	function handler:onChange(buttonText) 
		success = buttonText == cdata.yes
	end
	
	local dataStart = Campaign:getDataStart()
	if dataStart and dataStart.index then
		handler:show()
	else
		success = true
	end
	
	if success ~= true then		
		dataStart.doNotCount = true
		Campaign:setDataStart(dataStart)
	end	
		
	updateStatistic()
	local bTrack = MissionModule.isTrack(base.START_PARAMS.missionPath)
	local bIntro = MissionModule.checkMissionIntroduction(base.START_PARAMS.missionPath)
	
	if (returnScreen == 'campaign') 
		and ((not bTrack) or (bTrack and bIntro)) and success == true then			
		Campaign.onReceiveMissionResults()
	end
	selectReturnDialog()
end

function show(visible)
    if visible then
		if not window then
			create_()
		end
        
        load(lfs.writedir()..'Logs\\debrief.log')
		
		if (returnScreen == 'campaign') then
			b_endMission:setVisible(true)

			b_refly:setPosition(836,0)
			b_watchTrack:setPosition(242,0)
			b_saveTrack:setPosition(440,0)
			b_save:setPosition(638,0)
		else			
			b_endMission:setVisible(false)
			updateStatistic()

			b_refly:setPosition(1075,0)
			b_watchTrack:setPosition(342,0)
			b_saveTrack:setPosition(540,0)
			b_save:setPosition(738,0)
		end
        
        if (returnScreen == 'editor') then
            b_exit:setVisible(false)
            b_EditMission:setVisible(true)
		else
			b_exit:setVisible(true)
            b_EditMission:setVisible(false)
		end	        
    else
		if window then
			window:setVisible(false)
		end	
    end
end

-- load debriefing data
function load(path)   
    local f, err = base.loadfile(path)
    debriefing = {}
    if f then
        base.setfenv(f, debriefing)
        local ok, res = base.pcall(f)
		if not ok then
			log.error("ERROR pcall debrief.log: "..(res or ""))
			MsgWindow.error(cdata.debrief_load_error, cdata.debrief_load, 'OK'):show()			
			b_exit:onChange()
			return
		end
        if (debriefing.result < 0) then debriefing.result = 0; end;
        if (debriefing.result > 100) then debriefing.result = 100; end;

        result = debriefing.result;    
        events ={}
        base.U.recursiveCopyTable(events,debriefing.events)

        playerUnit = BriefingUtils.extractPlayerDetails(); 

        mod_debriefing.extractMissionData(MissionModule.mission)	
        mod_debriefing.updateMissionResults(result)
        
        if (playerUnit ~= nil) then
            local playerId = base.string.format("%i",playerUnit.unitId)
            mod_debriefing.setPlayerUnit(playerId, debriefing.callsign)
        else
            mod_debriefing.setPlayerUnit(nil, nil)
        end
            
        if events then
            for i,v in base.ipairs(events) do
                mod_debriefing.addEvent(v)
            end
        end
        
        mod_debriefing.show(true)
        
    else
		log.error("ERROR loading debrief.log: "..(err or ""))
        MsgWindow.error(cdata.debrief_load_error, cdata.debrief_load, 'OK'):show()
        b_exit:onChange()
    end 
end

-- set destination to return into
function setReturnScreen(_returnScreen)
    returnScreen = _returnScreen
end