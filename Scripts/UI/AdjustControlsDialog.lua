dofile('./Scripts/UI/initGUI.lua')

local Gui					= require("dxgui")
local lfs		 			= require('lfs')
local DialogLoader 			= require('DialogLoader')
local Input 				= require('Input')
local InputView 			= require('Input.View')
local InputData				= require('Input.Data')
local ProfileDatabase		= require('Input.ProfileDatabase')
local InputLoader			= require('Input.Loader')
local i18					= require('i18n')
local DCS                   = require('DCS')
local MeSettings			= require('MeSettings')

local window_
local inputView_
local inputClassicView_
local inputFoldableView_
local onOkCallback_

local lastUsedProfileName_
local blockUpdateProfile_ 		-- флаг блокировки перерисовки списка, по умолчанию – false

-- в симуляторе этот флаг для модального окна должен быть выключен(по умолчанию)
-- а в тестах (например \trunk\Utils\GUITests\simulator\LoadInputTest.lua)включен
local lockFlow_ = false

local function setLockFlow(lockFlow)
	lockFlow_ = lockFlow
	
	if window_ then
		window_:setLockFlow(lockFlow)
	end
end

local function setBlockUpdateProfile(b)
	blockUpdateProfile_ = b
end

local function setPause(b)
    if (DCS.isMultiplayer() ~= true) then
        DCS.setPause(b)
    end
end

local function loadProfiles_()
	local userConfigPath = lfs.writedir() .. 'Config/Input/'
	local sysConfigPath = './Config/Input/'
	
	InputData.initialize(userConfigPath, sysConfigPath)
 
	local profileInfos = ProfileDatabase.createDefaultProfilesSet(sysConfigPath,DCS.getInputProfiles())

	for i, profileInfo in ipairs(profileInfos) do
		InputData.createProfile(profileInfo)
	end
end

local function hide()
    setPause(false)
	
	Input.turnForceFeedbackOn()
	
	window_:setVisible(false)
	onOkCallback_ = nil
end

local function onOk_()
	inputView_:deactivate()
	
	InputData.saveChanges()
	InputLoader.reload()
	
	if onOkCallback_ then
		onOkCallback_()
	end
	
	hide()
end

local function onCancel_()
	inputView_:deactivate()
	InputData.undoChanges()

    hide()
end

-- определена ниже
local switchToFoldableView
local function switchToClassicView()
	if not inputClassicView_ then
		local InputView 	= require('Input.View')
		
		local screenWidth, screenHeight = Gui.GetWindowSize()		
		local wBorder =  math.min(35, math.floor((screenWidth-1280)/2))
		
		inputClassicView_	= InputView.new(nil, screenWidth-2*wBorder-4, screenHeight - 100)
		inputClassicView_:setFoldableViewFunc(switchToFoldableView)	
		
		local panelView	= DialogLoader.findWidgetByName(window_, 'panelView')
		local container	= inputClassicView_:getContainer()
		
		container:setPosition(0, 3)
		panelView:insertWidget(container)
	end	
	
	inputClassicView_:setCurrentProfileName(inputView_:getCurrentProfileName())
	
	-- текущий контейнер не удаляем, а просто прячем
	inputView_:deactivate()
	inputView_:getContainer():setVisible(false)
	
	inputView_ = inputClassicView_
	
	inputView_:activate()
	inputView_:getContainer():setVisible(true)
	
	MeSettings.setShowFoldableView(false)
end

-- объявлена выше
function switchToFoldableView()
	if not inputFoldableView_ then
		local FoldableView	= require('Input.FoldableView')
		
		local screenWidth, screenHeight = Gui.GetWindowSize()		
		local wBorder =  math.min(35, math.floor((screenWidth-1280)/2))
		
		inputFoldableView_ = FoldableView.new(nil, screenWidth-2*wBorder-4, screenHeight - 100)
		inputFoldableView_:setClassicViewFunc(switchToClassicView)
		
		local panelView	= DialogLoader.findWidgetByName(window_, 'panelView')
		local container	= inputFoldableView_:getContainer()
		
		container:setPosition(0, 3)
		panelView:insertWidget(container)
	end	
	
	inputFoldableView_:setCurrentProfileName(inputView_:getCurrentProfileName())
	
	-- текущий контейнер не удаляем, а просто прячем
	inputView_:deactivate()
	inputView_:getContainer():setVisible(false)
	
	inputView_ = inputFoldableView_
	
	inputView_:activate()
	inputView_:getContainer():setVisible(true)
	
	MeSettings.setShowFoldableView(true)
end

local function create_()
	local _ = i18n.ptranslate
	local localization = {
		optionsControls		= _('CONTROL OPTIONS'),
		ok					= _('OK'),
		cancel				= _('CANCEL'),
	}
	local window = DialogLoader.spawnDialogFromFile('./Scripts/UI/AdjustControlsDialog.dlg', localization)
	
	window:setLockFlow(lockFlow_)
		
	local buttonCancel	= DialogLoader.findWidgetByName(window, 'buttonBack')
	local buttonOk		= DialogLoader.findWidgetByName(window, 'buttonOK')
	local buttonClose	= DialogLoader.findWidgetByName(window, 'buttonClose')
	
	function buttonClose:onChange()
		window:close()
	end
	
	function window:onClose()
		onCancel_()
	end
	
	function buttonCancel:onChange()
		onCancel_()
	end
	
	function buttonOk:onChange()
		onOk_()
	end

	loadProfiles_()
	
	local screenWidth, screenHeight = Gui.GetWindowSize()
	local wBorder =  math.min(35, math.floor((screenWidth-1280)/2))
	
	if MeSettings.getShowFoldableView() then
		local FoldableView	= require('Input.FoldableView')

		inputFoldableView_	= FoldableView.new(nil, screenWidth-2*wBorder-4, screenHeight - 100)
		inputView_ 			= inputFoldableView_
		inputFoldableView_:setClassicViewFunc(switchToClassicView)
		
	else
		local InputView 	= require('Input.View')
		
		inputClassicView_	= InputView.new(nil, screenWidth-2*wBorder-4, screenHeight - 100)
		inputView_ 			= inputClassicView_

		inputClassicView_:setFoldableViewFunc(switchToFoldableView)		
	end
	
	local container = inputView_:getContainer()
	local panelView = DialogLoader.findWidgetByName(window, 'panelView')
    local containerMain = DialogLoader.findWidgetByName(window, 'containerMain')
	
	container:setPosition(0, 3)
	panelView:insertWidget(container)
	
	local wBorder =  math.min(35, math.floor((screenWidth-1280)/2))
	window:setBounds(wBorder, 0, screenWidth-2*wBorder, screenHeight)
    containerMain:setBounds(0, 0, screenWidth-2*wBorder, screenHeight)
	containerMain.panelCenter:setSize(screenWidth-2*wBorder-4, screenHeight-68)
	containerMain.panelCenter.panelView:setSize(screenWidth-2*wBorder-4, screenHeight-68)
	containerMain.paneltop:setSize(screenWidth-2*wBorder-4, 50)
	containerMain.paneltop.buttonClose:setPosition(screenWidth-30, 0)
	containerMain.panelBottom:setBounds(2,screenHeight-50, screenWidth-2*wBorder-4, 50)
	containerMain.panelBottom.buttonOK:setPosition(screenWidth-2*wBorder-149, 0)
	
	return window
end

local function show(unitName, callback, commandHash, isAxis)
	if not window_ then
		window_ = create_()
	end
	
	onOkCallback_ = callback
	
	-- настройки отображения могли быть изменены в главном меню
	if MeSettings.getShowFoldableView() then
		if inputView_ == inputClassicView_ then
			switchToFoldableView()			
		end
	else
		if inputView_ == inputFoldableView_ then
			switchToClassicView()
		end	
	end
	
    setPause(true)
    
	local profileName = InputData.getProfileNameByUnitName(unitName) or InputData.getDefaultProfileName()
	
	if lastUsedProfileName ~= profileName or not blockUpdateProfile_ then	
		inputView_:setCurrentProfileName(profileName)
	end
	lastUsedProfileName = profileName
	setBlockUpdateProfile(true)
	
	inputView_:selectCommand(commandHash, isAxis)
	
	inputView_:activate()
	
	Gui.ResetTooltipText()
	
	Input.turnForceFeedbackOff()
	
	window_:setVisible(true)
end

local function kill()
	if window_ then
	   window_:setVisible(false)
	   window_:kill()
	   window_ = nil
	end
end

return {
	show					= show,
	setCallback				= setCallback,
	kill					= kill,
	setLockFlow				= setLockFlow,
	setBlockUpdateProfile 	= setBlockUpdateProfile,
}