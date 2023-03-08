dofile('./Scripts/UI/initGUI.lua')

local base = _G

module('GameMenu')

local require = base.require
local table = base.table

local Gui						= require('dxgui')
local Skin						= require('Skin')
local GuiWin					= require('dxguiWin')
local DialogLoader				= require('DialogLoader')
local gettext					= require('i_18n')
local DCS						= require('DCS')
local ManualDialog				= require('ManualDialog')
local BriefingDialog			= require('BriefingDialog')
local ChoiceOfRoleDialog		= require('ChoiceOfRoleDialog')
local ChoiceOfCoalitionDialog	= require('ChoiceOfCoalitionDialog')
local gameMessages				= require('gameMessages')
local AdjustControlsDialog		= require('AdjustControlsDialog')
local Select_role		        = require('mul_select_role')
local net                       = require('net')
local OptionsDialog				= require('me_options')
local music						= require('me_music')
local sound						= require('sound')
local MsgWindow			        = require('MsgWindow')
local waitScreen        		= require('me_wait_screen')
local UC						= require('utils_common')
local visualizer 				= base.visualizer
local panel_voicechat 			= require('mul_voicechat')
local messagesHistory			= require('messagesHistory')
local Input						= require('Input')

base.setmetatable(base.dxgui, {__index = base.dxguiWin})

local window_
local listButtons = {}		-- все кнопки панели

-- кнопки dxgui в отличие от списков не отслеживают нажатие стрелок клавиатуры.
-- у них нет встроенной поддержки смены скина под клавиатурным фокусом.
-- variables required for keyboard focus manipulation
local listButtonsShown = {}	-- только те кнопки, что показаны в текущем режиме игры.
local currentBtnFocused_	-- хранит кнопку с фокусом
local defaultButton_		-- хранит кнопку для фокуса по-умолчанию при создании диалога. 
local defaultSkin_			-- дефолтный скин из диалога
local tempHoverSkin_ 		-- временный скин, на кнопке под клавиатурным фокусом.
local tempReleasedSkin_ 	-- временный скин, на кнопке без фокуса.

local menuControlKeys = {	-- эвенты, для блокирования в симуляции, пока активно меню.
		Input.getEnvTable().Events.KEY_TAB,
		Input.getEnvTable().Events.KEY_UPARROW,
		Input.getEnvTable().Events.KEY_DOWNARROW,
}


local countCoalitions = 0

local function _(text) 
    return gettext.translate(text) 
end

local cdata	= {
        missionPaused	= _('MISSION PAUSED'),
        resume			= _('RESUME'),
        briefing		= _('BRIEFING'),
		MessagesHistory = _('MESSAGES HISTORY'),
        manual			= _('MANUAL'),
        takeControl		= _('TAKE CONTROL'),
        quit			= _('QUIT'),
		leaveServer		= _('LEAVE SERVER'),
        adjustControls	= _('ADJUST CONTROLS'),
        choiceSlot		= _('CHOOSE SLOT'), 
        choiceCaol		= _('CHOOSE COALITION'),
        controlServer	= _('CONTROL SERVER'),
        selectRole	    = _('SELECT ROLE'),
        audioOption	    = _('OPTIONS'),
        quitToDesktop   = _('QUIT TO DESKTOP'),
        msgExit         = _('Are you sure you want to exit the game?'),
		msgLeaveServer	= _('Are you sure you want to exit the server?'),
        warning         = _('WARNING'), 
        yes             = _('YES'),
        no              = _('NO'),
    }
    
if base.LOFAC then
    cdata.missionPaused	= _('MISSION PAUSED-LOFAC') 
end    
    
local function create_()  
	
	screenWidth, screenHeight = Gui.GetWindowSize()
	
    window_ = DialogLoader.spawnDialogFromFile('./Scripts/UI/GameMenu.dlg', cdata)	
	window_:setBounds(0, 0, screenWidth, screenHeight)

	local findWidgetByName = DialogLoader.findWidgetByName
	
    buttonCancel			= findWidgetByName(window_, "buttonCancel")
    buttonTakeControl		= findWidgetByName(window_, "buttonTakeControl")
    buttonQuit				= findWidgetByName(window_, "buttonQuit")
    buttonBriefing			= findWidgetByName(window_, "buttonBriefing")
	buttonMessagesHistory	= findWidgetByName(window_, "buttonMessagesHistory")
    buttonManual			= findWidgetByName(window_, "buttonManual")
    buttonAdjustControls	= findWidgetByName(window_, "buttonAdjustControls")
    buttonChoiceSlot		= findWidgetByName(window_, "buttonChoiceSlot")
    buttonChoiceCaol		= findWidgetByName(window_, "buttonChoiceCaol")
    buttonSelectRole		= findWidgetByName(window_, "buttonSelectRole")
    buttonAudio				= findWidgetByName(window_, "buttonAudioOption")
    buttonQuitToDesktop		= findWidgetByName(window_, "buttonQuitToDesktop")
	buttonLeaveServer		= findWidgetByName(window_, "buttonLeaveServer")

    buttonTakeControl	.onChange	= TakeControl_onChange
    buttonCancel		.onChange	= Cancel_onChange
    buttonQuit			.onChange	= Quit_onChange
    buttonBriefing		.onChange	= Briefing_onChange
	buttonMessagesHistory.onChange	= MessagesHistory_onChange
    buttonManual		.onChange	= Manual_onChange
    buttonAdjustControls.onChange	= AdjustControls_onChange
    buttonChoiceSlot	.onChange	= ChoiceSlot_onChange
    buttonChoiceCaol	.onChange	= ChoiceCaol_onChange
    buttonSelectRole	.onChange	= SelectRole_onChange
    buttonAudio			.onChange	= Audio_onChange
    buttonQuitToDesktop	.onChange	= QuitToDesktop_onChange
	buttonLeaveServer	.onChange	= LeaveServer_onChange
  
	table.insert(listButtons, buttonCancel)
    table.insert(listButtons, buttonTakeControl)
    table.insert(listButtons, buttonBriefing)
	table.insert(listButtons, buttonMessagesHistory)
    table.insert(listButtons, buttonChoiceSlot)
    table.insert(listButtons, buttonChoiceCaol)
    table.insert(listButtons, buttonSelectRole)
    table.insert(listButtons, buttonManual)
    table.insert(listButtons, buttonAdjustControls)
    table.insert(listButtons, buttonAudio)    
    table.insert(listButtons, buttonQuitToDesktop)
    table.insert(listButtons, buttonQuit)
	table.insert(listButtons, buttonLeaveServer)
	
	--adding callbacks
	window_:	addKeyDownCallback 		(windowKeyDownCallback)
	
	for k, button in base.ipairs (listButtons) do
		button:	addMouseEnterCallback 	(mouseEnterCallback)
		button: addMouseLeaveCallback 	(mouseLeaveCallback)
	end	
	--*end adding callbacks
	
	--Initial Configure 
	defaultButton_	=	buttonCancel			-- назначаем кнопку для фокуса по умолчанию
	defaultSkin_ 	= 	buttonQuit:getSkin() 	-- запоминаем дефолтный скин из диалога
	
	
	local function clone(t)
		local result = {}
		for k, v in base.pairs(t) do
			result[k] = ('table' == base.type(v) and clone(v)) or v			
		end
		
		return result
	end	
	--        создаем временные скины для сопровождение клавиатурного фокуса
	tempHoverSkin_ 		= clone (defaultSkin_)
	tempReleasedSkin_ 	= clone (defaultSkin_)	
	tempHoverSkin_.skinData.states.released[1].bkg.center_center = defaultSkin_.skinData.states.hover[1].bkg.center_center
	tempReleasedSkin_.skinData.states.hover[1].bkg.center_center = defaultSkin_.skinData.states.released[1].bkg.center_center

    
	
	buttonManual.needShow = function()
        return (DCS.getManualPath() ~= nil)
    end

    buttonTakeControl.needShow = function()
        return (DCS.isTrackPlaying() and DCS.isMultiplayer() == false)
    end
    
    buttonChoiceSlot.needShow = function()
        return (ChoiceOfRoleDialog.isSelectCoalition() and DCS.isMultiplayer() == false)
    end
    
    buttonChoiceCaol.needShow = function()
        return (countCoalitions > 1 and DCS.isMultiplayer() == false)
    end
    
    buttonSelectRole.needShow = function()
        return (DCS.isTrackPlaying() ~= true and DCS.isMultiplayer() == true)
    end
	
	buttonQuit.needShow = function()
        return (DCS.isMultiplayer() ~= true or DCS.isTrackPlaying() == true)
    end
	
	buttonLeaveServer.needShow = function()
        return (DCS.isTrackPlaying() ~= true and DCS.isMultiplayer() == true)
    end
    
end

-- ***Focus control routines and callback functions
local function setFocusByKbrd (key)
	local moveFocus = function(btn)
		currentBtnFocused_:setFocused(true)
		currentBtnFocused_:setSkin(tempHoverSkin_)
		btn:setSkin(tempReleasedSkin_)	
	end	
	
		for k, btn in base.ipairs (listButtonsShown) do
			if btn == currentBtnFocused_ then
			
				if 	key == "down" and listButtonsShown[k+1] ~= nil then
				
					currentBtnFocused_ = listButtonsShown[k+1] 		-- двигаем вниз
					moveFocus(btn)
					break;					
			
				elseif 	key == "up" and listButtonsShown[k-1] ~= nil then
				
					currentBtnFocused_ = listButtonsShown[k-1] 		-- двигаем вверх
					moveFocus(btn)
					break;
				
				elseif key == "tab" then
					if listButtonsShown[k+1] ~= nil then
						currentBtnFocused_ = listButtonsShown[k+1]	-- двигаем вниз
					else
						currentBtnFocused_ = listButtonsShown[1]	-- по кругу
					end
					moveFocus(btn)
					break;
				end
				
			end
		end
	end

-- установка начального фокуса
local function initFocus(button) 
		button:setFocused(true)
		currentBtnFocused_ = button
		currentBtnFocused_:setSkin(tempHoverSkin_)
end	

-- callbacks
function windowKeyDownCallback (self, key)
	-- ловим только таб и стрелки. "return" при фокусе обрабатывает сам виджет.
	if key == "up" or key == "down" or key == "tab" then
		setFocusByKbrd (key)
	end	
end

function mouseEnterCallback(self)
	self:setFocused(true)
	self:setSkin(defaultSkin_)
	if nil ~= currentBtnFocused_ then
		currentBtnFocused_:setSkin(defaultSkin_)
	end		
	currentBtnFocused_ = self
	defaultButton_:setSkin(defaultSkin_) -- сброс после первичного initFocus	
end

function mouseLeaveCallback(self)
	currentBtnFocused_:setSkin(tempHoverSkin_)
end
-- *callbacks end
-- ***End of Focus routines and callback functions

function setPause(b)
    if (DCS.isMultiplayer() ~= true) or (DCS.isTrackPlaying() == true) then
        DCS.setPause(b)
    end
end

function TakeControl_onChange()
    DCS.takeTrackControl()
    hide()
	setPause(false)
end

function Cancel_onChange()
    hide()
	setPause(false)
	DCS.onShowDialog(false)	
end

function LeaveServer_onChange()
	local handler = MsgWindow.warning(cdata.msgLeaveServer, cdata.warning, cdata.yes, cdata.no)

    function handler:onChange(buttonText)
        if buttonText == cdata.yes then
            base.START_PARAMS.returnScreen = 'multiplayer'
			waitScreen.setUpdateFunction(function()
				net.stop_game()
				hide()
				UC.sleep(1000) 
			end)
			hide()
        else
        
        end
    end

    handler:show()
end

function Quit_onChange()
    if (DCS.isMultiplayer() == false) or (DCS.isTrackPlaying() == true) then
        gameMessages.hide()
        ManualDialog.hide()
        if base.__EMBEDDED__ then
            DCS.stopMission()
        else
            DCS.exitProcess()
        end
    else    
        -- показ выбора ролей
        Select_role.show(true)
    
        -- выход из игры
       -- base.START_PARAMS.returnScreen = ''
       -- net.stop_game()
    end
	
	AdjustControlsDialog.setBlockUpdateProfile(false)
    hide()
end

function QuitToDesktop_onChange()
    local handler = MsgWindow.warning(cdata.msgExit, cdata.warning, cdata.yes, cdata.no)

    
    function handler:onChange(buttonText)
        if buttonText == cdata.yes then
            hide()
            base.START_PARAMS.returnScreen = 'quit'
            if DCS.isMultiplayer() == true then
                net.stop_game()
            end
            DCS.exitProcess()
        else
        
        end
    end

    handler:show()
end

function Close_onChange()
    hide()
	DCS.onShowDialog(false)
end

function Briefing_onChange()
    BriefingDialog.showUnpauseMessage(false)    
    hide()
    BriefingDialog.show('Menu')
end

function MessagesHistory_onChange()
	messagesHistory.show(true)
	hide()
end

function ChoiceSlot_onChange()
    hide()
    ChoiceOfRoleDialog.show(nil, true, "Menu")
end

function ChoiceCaol_onChange()
    hide()
    ChoiceOfCoalitionDialog.show()
end 

function SelectRole_onChange()
    hide()
    Select_role.show(true)
end 

-- It is not for Audio only but it is for Settings at all
function Audio_onChange()
    hide()
    DCS.lockAllMouseInput() 
    DCS.lockAllKeyboardInput()
    local listener = {
		onOk = function()			
            DCS.unlockKeyboardInput(true)
            DCS.unlockMouseInput()
            setPause(false)
		end,
		
		onCancel = function()
            DCS.unlockKeyboardInput(true) 
            DCS.unlockMouseInput()
            setPause(false)            
		end,
		
		onSoundSetting = function(name, value)
			local function endUpdateVoiceChatOption()
				waitScreen.showSplash(false)
			end
			if name == 'music' then
				music.setMusicVolume(value)
				music.stop()
			elseif name == 'gui' then
				music.setEffectsVolume(value)
			elseif name == 'voice_chat' then
				if (DCS.isMultiplayer() == true) 
				   and (DCS.isTrackPlaying() ~= true) then					
					waitScreen.showSplash(true)
					panel_voicechat.ChangeVoiceChatOption(value, endUpdateVoiceChatOption)						
				end
			else
				sound.updateSettings{ [name] = value }	
				sound.updateVoiceChatSettings{ [name] = value }
			end
		end,
		
		onGraphicsSetting = function(name, value)
			if name == 'outputGamma' then
				visualizer.setOutputGamma(value)
--			elseif name == 'defaultFOV' then
--				DCS.setDefaultFOV(value)
			elseif name == 'currentFOV' then
				DCS.setCurrentFOV(value)
			elseif name == 'forestDistanceFactor' then
				visualizer.setForestDistanceFactor(value)
			elseif name == 'clutterMaxDistance' then
				visualizer.setGrassDistanceFactor(value/1500.0)
			elseif name == 'sceneryDetailsFactor' then
				visualizer.setSceneryDetailsFactor(value)
			elseif name == 'forestDetailsFactor' then
				visualizer.setForestDetailsFactor(value)	
			end	
		end,
		
		onVRSetting = function(name, value)
			if name == 'msaaMaskSize' then
				visualizer.setMSAAMaskSize(value)
			end	
		end,
	
	}

    OptionsDialog.show(listener, 'sim')

end

function Manual_onChange()
    hide()    
    ManualDialog.show(DCS.getManualPath())
end

local custom_input_name 

function setCustomInputProfileName(str_value_in)
	custom_input_profile_name = str_value_in
end

function AdjustControls_onChange()
    hide()		
	if custom_input_profile_name ~= nil then	
		AdjustControlsDialog.show(custom_input_profile_name)	
	else
		AdjustControlsDialog.show(DCS.getHumanUnitInputName())
	end	
end

function show()
 -- if nil == window_ then create_() end
	updateButtons()	
	
    DCS.setDebriefingShow(false)
	
    Gui.ResetTooltipText()
 --  enableTakeControlButton(DCS.isTrackPlaying())
    enableManualButton(DCS.getManualPath() ~= nil)
 --   enableChoiceSlotButton(ChoiceOfRoleDialog.isSelectCoalition())
	
		
	local function chk () --> false если сохраненная кнопка currentBtnFocused_ не показана в меню для в текущ. режима игры.
		local result
		for k, btn in base.pairs (listButtonsShown) do
			if currentBtnFocused_ == btn then
				result = btn
				break;			
			end
		end
		return result
	end
	
	if nil == currentBtnFocused_ or not chk() then
		initFocus(defaultButton_)		-- иницируем на кнопке по умолчанию		
	else
		initFocus(currentBtnFocused_) 	-- на послед. использованную юзером кнопку	
	end
	
	window_:setVisible(true)	
	setPause(true)
	DCS.lockAllMouseInput()
    DCS.lockKeyboardInput(menuControlKeys)
end

function setCountCoalitions(a_countCoalitions)
    countCoalitions = a_countCoalitions
end

function updateButtons()	
	
	listButtonsShown = {}
	
	local panelButtons	= window_.panelButtons

	-- всю работу по выравниванию кнопок делает лейаут
	-- первый виджет в panelButtons это контейнер со строкой заголовка окна и кнопкой закрытия
	local index = 1
    local offsetY = 60
	
    for i, button in base.pairs(listButtons) do
		panelButtons:removeWidget(button)
		
        if not button.needShow or button:needShow() then
            panelButtons:insertWidget(button, index)
			
			table.insert(listButtonsShown, button)
			button:setSkin(defaultSkin_)
			
            local width, height = button:getSize()
         --[[   if buttonQuitToDesktop == button then
                offsetY = offsetY + 18
            end]]
            button:setPosition(2, offsetY)
            offsetY = offsetY + height            
			index = index + 1
        end
    end
    
	local width, height = panelButtons:getSize()
	
	panelButtons:setSize(width, offsetY+12)
	local windowWidth, windowHeight = window_:getSize()
	
	panelButtons:setPosition((windowWidth - width) / 2, (windowHeight - offsetY-2) / 2 )
end

function hide()
    window_:close()
    DCS.unlockMouseInput()
	DCS.unlockKeyboardInput(true)
end

function getVisible()
    if window_ == nil then
        return false
    end
    return window_:getVisible()
end

function enableTakeControlButton(enable)
    buttonTakeControl:setEnabled(enable)
end

function enableManualButton(enable)
    buttonManual:setEnabled(enable)
end

function enableChoiceSlotButton(enable)
    buttonChoiceSlot:setEnabled(enable)
end

function kill()
	if window_ then
	   window_:setVisible(false)
	   window_:kill()
	   window_ = nil
	end
end

create_()

