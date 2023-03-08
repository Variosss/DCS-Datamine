dofile('./Scripts/UI/initGUI.lua')

local Gui				= require("dxgui")
local GuiWin			= require("dxguiWin")
local DialogLoader		= require('DialogLoader')
local SkinUtils			= require('SkinUtils')
local gettext			= require("i_18n")
local UpdateManager		= require('UpdateManager')

setmetatable(Gui, {__index = GuiWin})

local window_
local horzProgressBar_
local staticText_
local text_

local function localize(s) 
	if s and s ~= '' then 
		return gettext.dtranslate('missioneditor', s) 
	end
	
	return ''
end

local function create()
	local localization =
	{
		disclaimer  = localize("Disclaimer_info"),
	}
	window_ = DialogLoader.spawnDialogFromFile('./Scripts/UI/ProgressBarDialog.dlg', localization)
	sDisclaimer = window_.sDisclaimer
	progressBar = window_.progressBar
	staticText 	= window_.staticText

	local screenWidth, screenHeight = Gui.GetScreenSize()
	window_:setBounds(0, 0, screenWidth, screenHeight)
	
	horzProgressBar_	= window_.progressBar
	staticText_			= window_.staticText	
	
end

local function setValue(value)
	if not window_ then
		 create()
	end
	
	horzProgressBar_:setValue(value * 100)
end

local function setText(text)
	if not window_ then
		 create()
	end
	
	horzProgressBar_:setText(text)
end

local function kill()
	GuiWin.SetWaitCursor(false)
	
	if window_ then
		 window_:setVisible(false)
		 window_:kill()
		 
		 window_			= nil
		 horzProgressBar_	= nil
		 staticText_		= nil
	end
end

local function setTextStatic(text)
	if window_ then
		window_:getLayout():updateSize()
	end
	text_ = text or ""
end

local function setPicture(filename, text)
	local skin = window_:getSkin()

	skin = SkinUtils.setWindowPicture(filename, skin)

	window_:setSkin(skin)
	staticText_:setText(text)
end

local default_background = "loading-window.png"

local function show() 
	if not window_ then
		 create()
	end
	
    local unitType = DCS.getPlayerUnitType()
	--print("--ProgressBar---",unitType)
	local background
	
	if unitType then
		background = 'BackGround-' .. unitType .. '.png'
		
		if not Gui.GetTextureExists(background) then
			if not (unitType == 'MiG-29A' or unitType == 'MiG-29S' or unitType == 'MiG-29G') then
				background = default_background
			else
				background = 'BackGround-MiG-29.png'
				if not Gui.GetTextureExists(background) then
					background = default_background
				end
			end    
		end	
	else
		background = default_background
	end
	
	
   -- print("--unitType---",unitType,background,DCS.getUnitTypeAttribute(unitType, "DisplayName"))
	setPicture(background, DCS.getUnitTypeAttribute(unitType, "DisplayName"))
	
	GuiWin.SetWaitCursor(true)
	window_:setVisible(true)
end

local function showME() 
	if not window_ then
		 create()
	end

	setValue(0)
	setText("")
	setPicture("loading-window.png", text_)

	GuiWin.SetWaitCursor(true)
	window_:setVisible(true)
end

local function setUpdateFunction(func)
	showME() 
	
	UpdateManager.add(function()
		func()
		
		window_:setVisible(false)
		
		Gui.SetWaitCursor(false)
		setValue(0)
		setText("")
		-- удаляем себя из UpdateManager
		return true
	end)
end


return {
	show				= show,
	kill				= kill,
	setValue			= setValue,
	setText				= setText,
	setPicture			= setPicture,
	setUpdateFunction 	= setUpdateFunction,
	setTextStatic		= setTextStatic,
}