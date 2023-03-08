local base = _G

module('StartProgressBar')

local require = base.require
local tostring = base.tostring

local DialogLoader = require('DialogLoader')
local Gui = require('dxgui')

local window_

function create(x,y,w,h)
    window_ = DialogLoader.spawnDialogFromFile("MissionEditor/modules/dialogs/start_dialog.dlg", cdata)
    
    progressBar = window_.horzProgressBar
    
    local progressBarWidth, progressBarHeight = progressBar:getSize()
    local windowHeight = progressBarHeight
    
    window_:setBounds(0, h - windowHeight, w, windowHeight)
    progressBar:setPosition((w - progressBarWidth) / 2, 0)

	window_:setVisible(true)
end

function setValue(value)
	progressBar:setValue(value)
	progressBar:setText(tostring(value) .. "%")
	Gui.Redraw()
	Gui.SetTaskbarProgressState(2, value)
end

function getValue()	
	return progressBar:getValue()
end

function kill()
	window_:kill()
	Gui.SetTaskbarProgressState(0, 0)
end