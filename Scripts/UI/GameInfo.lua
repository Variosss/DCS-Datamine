dofile('./Scripts/UI/initGUI.lua')

local base = _G

module('GameInfo')

local require = base.require
local table = base.table

local Gui						= require('dxgui')
local DialogLoader				= require('DialogLoader')
local DCS						= require('DCS')

local cdata = {}
local timeStart = nil
local timeShow = 5  -- в секундах
local duration = nil

function create()
	local screenWidth, screenHeight = Gui.GetWindowSize()
	
    window_ = DialogLoader.spawnDialogFromFile('./Scripts/UI/GameInfo.dlg', cdata)	

	-- на экране с разрешением 1920х1080 окно должно находиться в позиции 680, 750
	window_:setPosition((680 / 1920) * screenWidth, (750 / 1080) * screenHeight)
end

function showText(a_text, a_duration)
	if window_ == nil then
		create()
	end
	duration = a_duration 
	timeStart = DCS.getModelTime() * 1000   
	window_.text:setText(a_text or "") 
	window_:setVisible(true)
	
end

function updateAnimations()
	if timeStart then
		local timeCur = DCS.getModelTime() * 1000 - timeStart        
		local timeShowCur = (duration or timeShow) * 1000    
		if timeCur >= timeShowCur then
			window_.text:setText("") 
			window_:setVisible(false)
			timeStart = nil
		end
	end
end