local base = _G

module('me_video_player')

local require = base.require

local DialogLoader		= require('DialogLoader')
local videoWidget		= require("VideoPlayerWidget")
local Gui				= require('dxgui')
local music				= require('me_music')

local function resizeControlPanel(controlPanel, main_w, main_h)
    local controlPanelX, controlPanelY, controlPanelWidth, controlPanelHeight = controlPanel:getBounds()
    
    controlPanel:setBounds(0, main_h - controlPanelHeight, main_w, controlPanelHeight)
    
    local buttonCloseX, buttonCloseY, buttonCloseWidth, buttonCloseHeight = buttonClose:getBounds()
    
    buttonClose:setPosition(main_w - buttonCloseWidth, buttonCloseY)
    
    local sliderX, sliderY, sliderWidth, sliderHeight = slider:getBounds()
    
    slider:setSize(main_w - buttonCloseWidth - sliderX, sliderHeight)
end

function create(main_w, main_h)
	local main_w, main_h = Gui.GetWindowSize()
    window = DialogLoader.spawnDialogFromFile("MissionEditor/modules/dialogs/me_video_player.dlg")
    window:setBounds(0, 0, main_w, main_h)

    window:addHotKeyCallback('escape', onExit)    
    
    local controlPanel = window.controlPanel

    toggleButtonPlay = controlPanel.toggleButtonPlay
    buttonClose = controlPanel.buttonClose
    slider = controlPanel.slider
    
    resizeControlPanel(controlPanel, main_w, main_h)

    widget = videoWidget.new()
    widget:setBounds(0, 0, main_w, main_h)
    window:insertWidget(widget, 0) -- изображение дожно быть под элементами управления

    function widget:onVideoFinished()
        onExit()
    end  

    function widget:onVideoUpdate()
        local pos = widget:getPos()
        slider:setValue(pos)
    end    

    buttonClose.onChange = onExit
    
    function toggleButtonPlay:onChange()
        if self:getState() then
            widget:play()
        else
            widget:pause()
        end
    end
   
    function slider:onChange()
        widget:setSeek(self:getValue())
    end
    
    window:setVisible(false)
            
    return window;
end

function show(b, video_file)
    Gui.EnableHighSpeedUpdate(b)
    if b == true then
        toggleButtonPlay:setState(true)
        widget:openVideo(video_file)
        local length = widget:getLength()
        slider:setRange(0, length)
        widget:openVideo(video_file)
    end
    
    window:setVisible(b)        
    
    return result
end; 

function closeVideo()
    widget:closeVideo()
end

function isVisible()
    if window then
        return window:isVisible()
    else
        return false
    end
end

function onExit()
    music.start()
    closeVideo()
    show(false)
end

