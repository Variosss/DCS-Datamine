package.path = '.\\Scripts\\?.lua;'.. '.\\Scripts\\UI\\?.lua;'..'.\\MissionEditor\\modules\\?.lua;'

if not START_PARAMS.nomaingui then
    dofile('./MissionEditor/MissionEditor.lua')
	mmw = require('MainMenu')
else
    print('noMainGUI mode')
    onShowMainInterface = function() DCS.exitProcess() end	
end

-- available APIs:
--[[
DCS.setPause(bool)
DCS.getPause() -> bool
--DCS.startMission(string filename) -- NOT IMPLEMENTED YET
DCS.stopMission()
DCS.exitProcess()

DCS.isMultiplayer() -> bool
DCS.isServer() -> bool
DCS.isTrackPlaying() -> bool
DCS.takeTrackControl()

DCS.getModelTime() -> number
DCS.getRealTime() -> number


DCS.setMouseCapture(bool)
DCS.setKeyboardCapture(bool)

DCS.getManualPath() -> string

DCS.getMissionOptions() -> table
DCS.getMissionDescription() -> string
DCS.getPlayerCoalition() -> string
DCS.getPlayerUnitType() -> string
DCS.getPlayerBriefing() -> table { text = string, images = { array of strings } }

DCS.spawnPlayer()

DCS.hasMultipleSlots() -> boolean
DCS.getAvailableCoalitions() -> table {
 [coalition_id] = { name = "coalition name", hasPassword = <bool> }
 ...
}
DCS.getAvailableSlots() -> array of {unitId, type, role, callsign, groupName, country}


--FIXME: these are temporary, for single-player only
DCS.getPlayerUnit() -> string

DCS.setPlayerCoalition(coalition_id)
DCS.setPlayerUnit(misId) -> sets the unit and spawns the player

]]

-- functions called by the sim
--[[
onMissionLoadBegin()
onMissionLoadProgress(progress_0_1, message)
onMissionLoadEnd()

onTriggerMessage(message, duration)
onRadioMessage(message, duration)
onRadioCommand(command_message)

onSimulationStart()
onSimulationFrame()
onSimulationStop()
onSimulationPause()
onSimulationResume()

onShowMainInterface()
onShowIntermission()
onShowGameMenu()
onShowBriefing()
onShowChatAll()
onShowChatTeam()
onShowScores()
onShowResources()
onShowGameInfo(a_text, a_duration)
onShowMessage(text, type)  
onShowChatPanel()
onHideChatPanel()
onGameEvent(eventName, args...)
onPlayerDisconnect(id)
onPlayerStart(id)
onPlayerConnect(id, name)
onNetMissionChanged(mizName)
onServerRegistrationFail(code)

onShowRadioMenu(size) --вызывается при изменении размеров радио меню
]]


local progressBar				= require('ProgressBarDialog')
local GameMenu					= require('GameMenu')
local GameInfo					= require('GameInfo')
local ChoiceOfRoleDialog		= require('ChoiceOfRoleDialog')
local ChoiceOfCoalitionDialog	= require('ChoiceOfCoalitionDialog')
local gameMessages				= require('gameMessages')
local messagesHistory			= require('messagesHistory')
local UpdateManager				= require('UpdateManager')
local Gui						= require('dxgui')
local GuiWin					= require('dxguiWin')
local Select_role				= require('mul_select_role')
local Chat						= require('mul_chat')
local PlayersPool				= require('mul_playersPool')
local net						= require('net')
local MsgWindow					= require('MsgWindow')
local RPC						= require('RPC')
local i18n						= require('i18n')
local query 					= require('mul_query')
local wait_query				= require('mul_wait_query')
local MeSettings				= require('MeSettings')
local wait_screen				= require('me_wait_screen')
local OptionsDialog				= require('me_options')
local Censorship				= require('censorship')
local PasswordPanel				= require('mul_password')
local Server_list				= require('mul_server_list')
local Analytics					= require("Analytics")
local Bda						= require('mul_bda')
local optionsEditor				= require('optionsEditor')
local panel_voicechat			= require('mul_voicechat')
local TrainingSubtitles			= require('TrainingSubtitles')
local TriggerPictures			= require('TriggerPictures')

controlRequest					= require('mul_controlRequest')
swap_slot						= require('mul_swap_slot')

local _ = i18n.ptranslate

setmetatable(dxgui, {__index = dxguiWin})


Gui.SetupApplicationUpdateCallback()

-- Данная функция будет вызываться на каждом кадре отрисовки GUI.
Gui.AddUpdateCallback(UpdateManager.update)

countCoalitions = 0
isDisconnect = false
msgDisconnect = nil
codeDisconnect = nil
isShowIntermission = false


function onMissionLoadBegin()
--	print("---onMissionLoadBegin----")		
    progressBar.show()
	wait_screen.showSplash(false)
	
	if (DCS.isMultiplayer() == true) and (DCS.isTrackPlaying() ~= true) then
		local do_stop = false -- new mission or restart mission
		panel_voicechat.stop_stream(do_stop)  -- вызываем всегда для всех режимов
	end
end

function onMissionLoadProgress(progress, message)
--	print("---onMissionLoadProgress----",progress, message)
    progressBar.setValue(progress)
    if message then
        progressBar.setText(message)
    end
end

function onNetMissionChanged(mizName)
	--print("---onNetMissionChanged---",mizName)
	Analytics.pageview(Analytics.MissionOnline)
end

function onMissionLoadEnd()	
--	local serverSettings = net.get_server_settings()
--	_G.U.traverseTable(serverSettings.advanced)
--	print("---onMissionLoadEnd----",DCS.isServer(), serverSettings.advanced.voice_chat_server)
	if (DCS.isMultiplayer() == true) and (DCS.isTrackPlaying() ~= true) then		
        Select_role.onMissionLoadEnd()		
		panel_voicechat.start_stream()
	end	
end

function onShowRadioMenu(a_h)
--print("------- onShowRadioMenu------",a_h)
    gameMessages.setOffsetLentaTrigger(a_h)
end


function RPC.method.onCustomEvent(sender_id, eventName, player_id)
    --print("---RPC.method.onCustomEvent----",sender_id, eventName, player_id,arg2,arg3)
    Chat.onGameEvent(eventName,player_id) 
end

function RPC.method.onPrtScn(sender_id, ...)
    --print("---RPC.method.onPrtScn----",sender_id, arg1,arg2,arg3)
    RPC.method.onCustomEvent(sender_id, "screenshot", sender_id) -- locally
    RPC.sendEvent(0, "onCustomEvent", "screenshot", sender_id) -- to everybody else
end

--запрос на слот
function RPC.method.slotWanted(server_id, player_id, slot_id) 
    if DCS.isTrackPlaying() == true then
        return
    end
print("------- RPC.method.slotWanted------",server_id, player_id, slot_id)
    query.slotWanted(server_id, player_id, slot_id)
end

function RPC.method.slotGivenToPlayer(server_id, playerMaster_id)
	if DCS.isTrackPlaying() == true then
        return
    end
	print("------- RPC.method.slotGivenToPlayer------",server_id, playerMaster_id) 
	wait_query.slotGivenToPlayer(playerMaster_id)
end

function RPC.method.slotDenialToPlayer(server_id, playerMaster_id)
    if DCS.isTrackPlaying() == true then
        return
    end
    print("------- RPC.method.slotDenialToPlayer------",server_id, playerMaster_id)    
    wait_query.slotDenialToPlayer(playerMaster_id)
end

function RPC.method.releaseSeatToMaster(playerMaster_id, player_id)
    if DCS.isTrackPlaying() == true then
        return
    end
    print("------- RPC.method.releaseSeatToMaster------", playerMaster_id, player_id)  
    query.releaseSeatToMaster(player_id) 
end

function onChatShowHide()
    print("---onChatShowHide-----",DCS.isMultiplayer())
    if (DCS.isMultiplayer() == true) then
        Chat.onChatShowHide()
    end
end

function onBdaShowF10(bValue)
	--print("---onBdaShowF10----")
	Bda.onBdaShowF10(bValue)
end

function onBdaShowHide()
    print("---onBdaShowHide-----",DCS.isMultiplayer())
    --if (DCS.isMultiplayer() == true) then
        Bda.onBdaShowHide()
    --end
end
function onBdaSetModeWrite()
    print("---onBdaSetModeWrite-----",DCS.isMultiplayer())
        Bda.setMode(Bda.mode.movedOn)
end
function onBdaSetModeRead()
    print("---onBdaSetModeRead-----",DCS.isMultiplayer())
        Bda.setMode(Bda.mode.movedOff)
end

-- used in onSimulationStart, onSimulationStop and onGameEvent
local _serverSettings = nil

function onSimulationStart()
    print("------- onSimulationStart------",DCS.getPause(),DCS.isMultiplayer(),DCS.isTrackPlaying())	
	if mmw then
		mmw.show(false) 
	end
	progressBar.kill()
    wait_screen.showSplash(false)	
    gameMessages.show()
	isDisconnect = false
	isShowIntermission = false
    if (DCS.isMultiplayer() == true) then	
		msgDisconnect = nil
		codeDisconnect = nil
		_serverSettings = net.get_server_settings()
        Select_role.onSimulationStart() 
		PlayersPool.onSimulationStart()
		
        if not _OLD_NET_GUI and DCS.isTrackPlaying() == false then
            Select_role.show(true)
        end 

        if DCS.getPause() == true then
            gameMessages.showPause()
        else
            gameMessages.hidePause()
        end        
        Chat.updateSlots()  
		Bda.updateSlots()  
        PlayersPool.updateSlots()  
        query.onChange_bDenyAll()
        RPC.sendEvent(net.get_server_id(), "releaseSeat", net.get_my_player_id())
        
        if DCS.isTrackPlaying() == false then
            local opt = DCS.getUserOptions()
            if opt and opt.miscellaneous.chat_window_at_start ~= false then  
                Chat.setMode(Chat.mode.read)
                Chat.show(true)
            end
        else
            BriefingDialog.showUnpauseMessage(true)
            BriefingDialog.show()
        end    

		local option = DCS.getUserOptions()
		if option and option.difficulty.RBDAI ~= false then  
			Bda.onBdaShowHide()
		end

        return
    end
	
	local option = DCS.getUserOptions()
	if option and option.difficulty.RBDAI ~= false then  
		--Bda.onCreateBda()
		--Bda.show(true)
		Bda.onBdaShowHide()
	end

    countCoalitions = 0
    Coalitions = DCS.getAvailableCoalitions()
    ChoiceOfCoalitionDialog.setAvailableCoalitions(Coalitions)
    CoalitionLast = nil
    
    for k,v in pairs(Coalitions) do
        countCoalitions = countCoalitions + 1
        CoalitionLast = k
    end
   -- print("------------onSimulationStart====",#(DCS.getAvailableCoalitions()),countCoalitions)
    
    if DCS.getPause() == true then
        if DCS.hasMultipleSlots() == false or DCS.isTrackPlaying() == true then
            BriefingDialog.showUnpauseMessage(true)
            BriefingDialog.show()
        elseif countCoalitions == 1 then
            ChoiceOfRoleDialog.show(CoalitionLast, true, "Menu")
        else
            ChoiceOfCoalitionDialog.show()
        end 
    end
   
    GameMenu.setCountCoalitions(countCoalitions)
end

function onSimulationFrame()
    gameMessages.updateAnimations()
	GameInfo.updateAnimations()
end 


local event2setting = {
    ['crash'] = 'event_Crash',
    ['eject'] = 'event_Ejecting',
    ['takeoff'] = 'event_Takeoff',
    ['landing'] = 'event_Takeoff',
    ['kill'] = 'event_Kill',
    ['self_kill'] = 'event_Kill',
    ['pilot_death'] = 'event_Kill',
    ['change_slot'] = 'event_Role',
    ['connect'] = 'event_Connect',
    ['disconnect'] = 'event_Connect',
    ['friendly_fire'] = nil,
    ['screenshot'] = nil,
}

-- events are filtered on the server only, because on clients they are filtered by the C++ code.
local function show_event(eventName)
    if _serverSettings then
        local settingName = event2setting[eventName]
        if settingName then
            return _serverSettings.advanced[settingName]
        end
    end
    return true
end

function onGameEvent(eventName,arg1,arg2,arg3,arg4,arg5,arg6,arg7) 
    --print("---onGameEvent(eventName)-----",eventName,arg1,arg2,arg3,arg4,arg5,arg6,arg7)
    if show_event(eventName) then
        Chat.onGameEvent(eventName,arg1,arg2,arg3,arg4,arg5,arg6,arg7) 
    end
end


function onShowBda()
	if Bda.isOn() then
		Bda.startTime()
		Bda.setMode(Bda.mode.movedOff)
		Bda.show(true)
	end
end

function onGameBdaEvent(eventName,arg1,arg2,arg3,arg4,arg5,arg6,arg7) 
	--print("---onGameBdaEvent : isOn(): ", Bda.isOn())
	--print("---onGameBdaEvent(%s)-----",eventName,arg1,arg2,arg3,arg4,arg5,arg6,arg7)
	if Bda.isOn() then
		Bda.startTime()
        Bda.onGameBdaEvent(eventName,arg1,arg2,arg3,arg4,arg5,arg6,arg7) 
    end
end

function onShowPool()
	print("---onShowPool()----")
    if PlayersPool.isVisible() ~= true then
        --if Select_role.getVisible() == true then 
            PlayersPool.show(true)
        --else
        --    PlayersPool.show(true)
        --end    
    else
        PlayersPool.show(false)
    end
end

function onSimulationEsc()
    if (DCS.isMultiplayer() == true) and (DCS.isTrackPlaying() == false) then
        if Select_role.getVisible() == true then            
            Select_role.onEsc()			
        else
            if GameMenu.getVisible() == true then
                GameMenu.hide()  
                DCS.setViewPause(false)    
            else
                GameMenu.show()
                DCS.setViewPause(true)
            end    
        end
		
        return
    end

    if GameMenu.getVisible() == true then
        GameMenu.hide()  
        gameMessages.hidePause() 
        DCS.setPause(false)    
    elseif BriefingDialog.getVisible() == true then
        BriefingDialog.hide()
        gameMessages.hidePause() 
        DCS.setPause(false) 
    elseif ChoiceOfRoleDialog.getVisible() == true then
        ChoiceOfRoleDialog.hide()
    elseif ChoiceOfCoalitionDialog.getVisible() == true then
        ChoiceOfCoalitionDialog.hide()  
    elseif OptionsDialog.getVisible() == true then
        OptionsDialog.onCancel()
    else
        GameMenu.show()
        gameMessages.showPause()
    end    
    
 --   ggg = ggg or 10
 --   ggg = ggg + 1
 --   onShowMessage("dfgdf fdg dg"..ggg, math.random(10000,20000), {r=math.random(0,1),g=math.random(0,1),b=math.random(0,1)}  ) 
end

function onShowMessage(a_text, a_duration)
    gameMessages.addMessage(a_text, a_duration) 
	messagesHistory.addMessage('trigger', a_text) 
end

function onMessageBox(message, title)
	MsgWindow.warning(message, title, _("OK")):show()
end

function onShowVoicechat(mode, value)
	if (DCS.isTrackPlaying() ~= true) and (DCS.isMultiplayer() == true) then
		local serverSettings = net.get_server_settings()
		if (serverSettings.advanced.voice_chat_server == true) and
			(optionsEditor.getOption("sound.voice_chat") == true) then
			if mode == 1 then 
				if panel_voicechat.isVisible() == false then
					panel_voicechat.show(true)
				else
					panel_voicechat.show(false)
				end
			elseif mode == 2 then		
				panel_voicechat.PushToTalkHighlight(value)
			end
		end
	end
end

--called only in multiplayer mode
function updateVoicechat(a_typeUpdate, arg1, arg2)
	if (DCS.isTrackPlaying() ~= true) and (DCS.isMultiplayer() == true) then
		if a_typeUpdate == nil or a_typeUpdate == 0 then
			panel_voicechat.update()
		elseif a_typeUpdate == 1 then
			panel_voicechat.updateMicState()
		elseif a_typeUpdate == 2 then
			panel_voicechat.updateIndication(arg1, arg2)	
		elseif a_typeUpdate == 3 then
			panel_voicechat.updateRadio(arg1, arg2)
		elseif a_typeUpdate == 4 then
			panel_voicechat.updateMicrophoneTest(arg1)
		elseif a_typeUpdate == 5 then
			panel_voicechat.updateRadioPanelControls(arg1, arg2)
		end
	end
end

function onShowGameInfo(a_text, a_duration)
	GameInfo.showText(a_text, a_duration)
end 

function onShowChatAll()
--print("----onShowChatAll()----",DCS.isMultiplayer()) 
    if (DCS.isMultiplayer() == true) then  
        if (Chat.getMode() == Chat.mode.write) and (Chat.getAll() == true) then
            Chat.setMode(Chat.mode.min)
        else
            Chat.setAll(true)
            Chat.setMode(Chat.mode.write)            
        end    
        Chat.show(true)
    else
        Chat.show(false)
    end
end

function onShowChatTeam()
--print("----onShowChatTeam()----",DCS.isMultiplayer()) 
    if (DCS.isMultiplayer() == true) then    
        if (Chat.getMode() == Chat.mode.write) and (Chat.getAll() == false) then
            Chat.setMode(Chat.mode.min)  
        else
            Chat.setAll(false)
            Chat.setMode(Chat.mode.write)  
        end
        Chat.show(true)
    else
        Chat.show(false)
    end    
end

function onShowChatRead()
--print("----onShowChatRead()----",DCS.isMultiplayer())     
    if (DCS.isMultiplayer() == true) then
        if (Chat.getMode() ~= Chat.mode.read) then
            Chat.setMode(Chat.mode.read)
        else
            Chat.setMode(Chat.mode.min)    
        end
        Chat.show(true)
    else
        Chat.show(false)
    end    
end

function onSimulationPause()
    print("----onSimulationPause---")
    if DCS.isTrackPlaying() == false then
        gameMessages.showPause()
    end    
end

function onUserRequestMissionRestart(new_mission_path)
	if new_mission_path ~= nil then 
		--this  is restart in to the new mission   triggered by some game logicc  
		START_PARAMS.realMissionPath = new_mission_path
        START_PARAMS.missionPath = new_mission_path
	else
		--this  is restart of already loaded mission
	end
end

function onSimulationStop()
    Chat.show(false)
	Bda.show(false)
	Bda.clear()
    controlRequest.show(false)
    gameMessages.clear() 
	messagesHistory.clear() 
    gameMessages.hide()
    _serverSettings = nil
		
    print("----onSimulationStop---",isDisconnect,msgDisconnect,codeDisconnect)
	
	 print("----DCS.isMultiplayer()---",DCS.isMultiplayer())
	ChoiceOfRoleDialog.setVisible(false)  -- при кике во время загрузки может остаться видимым
	ChoiceOfCoalitionDialog.setVisible(false)
	
	TrainingSubtitles.reset()
	TriggerPictures.clear()

	if isDisconnect == true then	
		progressBar.kill()
		--wait_screen.showSplash(false)
		onShowMainInterface()		
		
		if codeDisconnect ~= net.ERR_THATS_OKAY and codeDisconnect ~= net.ERR_BANNED then
			UpdateManager.add(function()
				MsgWindow.warning(msgDisconnect, _("DISCONNECT"), _("OK")):show()
				
				return true
			end)
		end	
	end
end

function onNetDisconnect(reason, code)
print("----onNetDisconnect---",reason, code, PasswordPanel.isVisible(), isShowIntermission)
	if code == 100 and PasswordPanel.isVisible() == true then
		Server_list.onNetDisconnect()
		return
	end	
  
	local do_stop = true -- stop all voice_chat
	panel_voicechat.stop_stream(do_stop) -- вызываем всегда для всех режимов
	
    local msg = Chat.getMsgByCode(code)

    if reason and (code == nil or code ~= net.ERR_INVALID_PASSWORD) and (code ~= net.ERR_DENIED_TRIAL_ONLY) then
        msg = msg.."\n\n".._(reason)
    end    
    
	wait_screen.showSplash(false)
    net.stop_network()   
    Chat.show(false)
    PlayersPool.show(false)
    Select_role.show(false)
    query.show(false)
	wait_query.show(false)
	
	isDisconnect = true  
	msgDisconnect = msg	
	codeDisconnect = code
	
	if isShowIntermission == true then
		onShowMainInterface()		
		
		if codeDisconnect ~= net.ERR_THATS_OKAY then
			UpdateManager.add(function()
				MsgWindow.warning(msgDisconnect, _("DISCONNECT"), _("OK")):show()
				
				return true
			end)
		end		
	end
	
	if code == net.ERR_BANNED or code == net.ERR_REFUSED or code == net.ERR_DENIED_TRIAL_ONLY 
		or code == net.ERR_NOT_ALLOWED or code == net.ERR_BAD_CALLSIGN then
		UpdateManager.add(function()
			MsgWindow.warning(msg, _("DISCONNECT"), _("OK")):show()
			
			return true
		end)	
	end
end 

function onNetConnect(your_player_id)
	print("----onNetConnect---",your_player_id)
	if PasswordPanel.isVisible() == true then
		Server_list.onNetConnect()
	end
	music.stop()  
	
	Select_role.resetPasswords()
	Server_list.show(false)
end

function onSimulationResume()
    print("----onSimulationResume---")
    gameMessages.hidePause()
    
    if BriefingDialog.getVisible() == true then
        BriefingDialog.hide()
    end
end

if not onShowMainInterface then
    onShowMainInterface = function() end
end

function onShowIntermission()
	print("--onShowIntermission-GAMEGUI---")

	isShowIntermission = true	
	-- temporary solution wait_screen.showSplash(true) 

end

function onShowGameMenu()
  --  GameMenu.show()
    onSimulationEsc()
end

function onShowBriefing()
    if BriefingDialog.getVisible() == false then
        BriefingDialog.showUnpauseMessage(false)
        BriefingDialog.show()   
    else
        BriefingDialog.Fly_onChange()
    end    
end

function onShowChat(say_all)
end

function onShowScores()
end

function onShowResources()
end

-- shows a trigger-induced message for a specified duration (in modeltime seconds)
function onTriggerMessage(message, duration, clearView)
--print("---onTriggerMessage---",message, duration, clearView)
    gameMessages.addTriggerMessage(message, duration, clearView)
	messagesHistory.addMessage('trigger', message) 
end

-- shows a player-activated radio message for a specified duration (in modeltime seconds)
function onRadioMessage(message, duration , subtitles)
	--print("---onRadioMessage---",message, duration)
	if  subtitles then 
		gameMessages.addRadioMessage(message, duration)
	end
	messagesHistory.addMessage('radio', message) 
end

-- shows an 'automatic' radio command, until replaced by another or an empty one
function onRadioCommand(command_message)
--print("---onRadioCommand---",command_message)
    gameMessages.onRadioCommand(command_message)
end


function onPlayerTrySendChat(playerID, msg, all) -- -> filteredMessage | "" - empty string drops the message
   -- print("---onPlayerTrySendChat----",playerID, msg, all)
    msg = Censorship.censor(msg)
    return msg
end

function onChatMessage(message, from, to)
--print("--GUI-onChatMessage----",message, from)
    Chat.onChatMessage(Censorship.censor(message), from, to)  
end

function onDebriefingEvent(e)
--_G.U.traverseTable(e)
--  print("--onDebriefingEvent----",e)
end

--- player list callbacks
function onPlayerConnect(id, name)
  --  print("---onPlayerConnect--",id, name)
    Select_role.onPlayerConnect(id)
    PlayersPool.onPlayerConnect(id)
	if (DCS.isTrackPlaying() ~= true) and (DCS.isMultiplayer() == true) then
		panel_voicechat.onPeerConnect(id)
	end	
end

function onPlayerDisconnect(id, code)
    print("----onPlayerDisconnect---", id, code)
    
    RPC.sendEvent(net.get_server_id(), "releaseSeat", id)
        
    Select_role.onPlayerDisconnect(id)
    PlayersPool.onPlayerDisconnect(id)
	if (DCS.isTrackPlaying() ~= true) and (DCS.isMultiplayer() == true) then
		panel_voicechat.onPeerDisconnect(id)
	end
end

function onPlayerStart(id)
   -- local name = net.get_player_info(id, 'name')
   -- print('Player '..name..' entered the game.')
end

function onPlayerStop(id)
end

function onPlayerTryChangeSlot(id, side, unit)
end

function onPlayerChangeSlot(id)
    --print("----onPlayerChangeSlot---", id)
    Select_role.onPlayerChangeSlot(id)
    PlayersPool.onPlayerChangeSlot(id)
    wait_query.onPlayerChangeSlot(id)
	updateVoicechat()
end

function onUpdateScore()
    PlayersPool.updateGrid()
end

--------------------------------------------------------------------------------------------------------

-- отладочная функция для сериализации таблицы на экран
function traverseTable(_t, _numLevels, _tabString, filename, filter)
    local _tablesList = {}
    filter = filter or {}
    fun = print
    if ( filename and (filename ~= '') ) then
        local out = io.open(filename, 'w')
        fun = function (...)
            out:write(..., '\n')
        end
    end
    function _traverseTable(t, tabString, tablesList, numLevels, filter)
        if (numLevels <1) then 
            return
        end

      for k,v in pairs(t or {} ) do      
            if type(k) == "number" then
                k = '[' .. tostring(k) .. ']'
            end
        if type(v) == "table" then 
            local skip = false
            for i,ignoredField in ipairs(filter) do
                if ignoredField == k then
                    skip = true
                    break
                end
            end
            if skip == false then
                local str = string.gsub(tostring(v), 'table: ','')
                if not tablesList[v] then
                    tablesList[v] = tostring(k)
                    fun(tabString  .. tostring(k) .. "--[[" .. str .. "--]]  = {")
                    --numLevels = numLevels - 1
                    _traverseTable(v, tabString .. '    ', tablesList, numLevels - 1, filter)
                    fun(tabString .. "}")
                else 
                    fun(tabString .. k .. " = -> " .. (tostring(tablesList[v])  or '') .. "--[[" .. str .. "--]],")
                end
            end
        elseif type(v) == "function" then
          fun(tabString .. k .. " = " .. "function() {},")
        elseif type(v) == "string" then
          fun(tabString .. k .. " = '" .. v .. "'")
        else
          fun(tabString .. k .. " = " .. tostring(v) or '' .. ",")
        end
      end        
    end 

    if not _t then 
        fun('traverseTable(): nil value')
        return
    end
    
    if 'table' ~= type(_t) then 
        fun('traverseTable(): not a table', tostring(_t)  or '')
        return
    end
    fun('displaying table:', (tostring(_t) or ''), tostring(_numLevels) or '')
    
    if _numLevels == nil then 
        _numLevels  = math.huge
    end
    
    if (_numLevels <1) then 
        return
    end
    
    if _tabString == nil then
        _tabString = ""
    end
    
    if not _tablesList then 
        _tablesList = {}
    end 
    --fun('_numLevels',_numLevels)
    for k,v in ipairs(filter) do
        print(k,v)
    end
    _traverseTable(_t, _tabString, _tablesList, _numLevels, filter)
    
end

function onShowTraining(text)
	TrainingSubtitles.show(text)
end

function onTriggerPicture(filename, duration, clearView, horzAlign, vertAlign, size, sizeUnits)
	TriggerPictures.show(filename, duration, clearView, horzAlign, vertAlign, size, sizeUnits)
end

function showMissionResourcesDialog()
	print('---DCS showMissionResourcesDialog---')
end

--enmEvent == 1 --Start
--enmEvent == 2 --End
function onReloadEvent(enmEvent)
	print('---DCS onReloadEvent--- ', enmEvent)
end

--enmEvent == 1 --Start
--enmEvent == 2 --End
function onRefuelEvent(enmEvent)
	print('---DCS onRefuelEvent--- ', enmEvent)
end

function onServerRegistrationFail(code)
	local text
	if code == 415 then
		text = _("Server name and/or description contain forbidden words.")
	else
		text = _("Server registration failed with code").." "..code
	end
	MsgWindow.warning(text, _("WARNING"), _("OK")):show()
end

---- Insert your stuff ABOVE this line.
dofile("MissionEditor/SimRunTimeUtilities.lua")
--- EOF
