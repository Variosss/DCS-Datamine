local DialogLoader	= require('DialogLoader')
local dxgui			= require('dxgui')

local window_
local staticCross_
local crossOffsetX_
local crossOffsetY_
local staticDistance_
local panelDistance_

local function create(window)
	if window then
		window_	= window
	else
		window_	= DialogLoader.spawnDialogFromFile('./Scripts/UI/DebugSight.dlg')	
	end
	
	local screenWidth, screenHeight = dxgui.GetScreenSize()
	
	window_:setBounds(0, 0, screenWidth, screenHeight)
	
	staticCross_	= DialogLoader.findWidgetByName(window_, 'staticCross'		)
	staticShell_	= DialogLoader.findWidgetByName(window_, 'staticShell'	)
	staticDistance_	= DialogLoader.findWidgetByName(window_, 'staticDistance'	)
	panelDistance_	= DialogLoader.findWidgetByName(window_, 'panelDistance'	)
	
	local w, h = staticCross_:getSize()
	
	crossOffsetX_ = w / 2
	crossOffsetY_ = h / 2
	staticCross_:setPosition(screenWidth / 2 - crossOffsetX_, screenHeight / 2 - crossOffsetY_)
	
	w, h = panelDistance_:getSize()
	panelDistance_:setPosition(screenWidth / 2, screenHeight / 2 + h / 2)
end

local function show()
	window_:setVisible(true)
end

local function hide()
	window_:setVisible(false)
end

local function setShellText(text)
	staticShell_:setText(text)
end

local function setDistanceText(text)
	staticDistance_:setText(text)
end

local function setColor(r, g, b, a)
	local color = string.format("0x%.2x%.2x%.2x%.2x", r, g, b, a)
	local skinShell = staticShell_:getSkin()
	skinShell.skinData.states.released[1].text.color = color
	staticShell_:setSkin(skinShell)
	local skinDistance = staticDistance_:getSkin()
	skinDistance.skinData.states.released[1].text.color = color
	staticDistance_:setSkin(skinDistance)
	local skinCross = staticCross_:getSkin()
	skinCross.skinData.states.released[1].picture.color = color
	staticCross_:setSkin(skinCross)
end

local function setDistanceWidgetPosition(x, y)
	panelDistance_:setPosition(x, y)
end

local function setCrossPosition(x, y)
	staticCross_:setPosition(x - crossOffsetX_, y - crossOffsetY_)
end

return {
	create						= create,
	show						= show,
	hide						= hide,
	setShellText				= setShellText,
	setDistanceText				= setDistanceText,
	setColor					= setColor,
	setDistanceWidgetPosition	= setDistanceWidgetPosition,
	setCrossPosition			= setCrossPosition,
}