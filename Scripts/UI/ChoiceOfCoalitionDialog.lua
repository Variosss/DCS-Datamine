dofile('./Scripts/UI/initGUI.lua')

local base = _G

module('ChoiceOfCoalitionDialog')

local require = base.require

local Gui = require('dxgui')
local GuiWin = require('dxguiWin')
local DialogLoader = require('DialogLoader')
local WidgetParams = require('WidgetParams')
local gettext = require('i_18n')
local DCS = require('DCS')
local ChoiceOfRoleDialog = require('ChoiceOfRoleDialog')
local GameMenu = require('GameMenu')

base.setmetatable(base.dxgui, {__index = base.dxguiWin})

local function _(text) 
    return gettext.translate(text) 
end

AvailableCoalitions = nil

function create()
    local localization = {

		back                = _('BACK'),
        choiceOfCoalition   = _('Choice of coalition'),
        red                 = _('Red coalition'),
        blue                = _('Blue coalition'),
        spectators          = _('Spectators'),
        cancel              = _('CANCEL'),
		neutrals			= _('Neutrals'),
	}

	window = DialogLoader.spawnDialogFromFile('Scripts/UI/ChoiceOfCoalition.dlg', localization)
    local width, height = Gui.GetWindowSize()
    window:setBounds(0,0,width, height)
    window.containerMain:setBounds((width-295)/2, (height-385)/2, 295, 385)
    
    btnClose 		= window.containerMain.panelTop.btnClose
    btnCancel 		= window.containerMain.panelBottom.btnCancel
    btnRed 			= window.containerMain.btnRed
    btnBlue 		= window.containerMain.btnBlue
    btnSpectators 	= window.containerMain.btnSpectators
	btnNeutrals 	= window.containerMain.btnNeutrals
    
    btnCancel.onChange 		= onChange_Cancel
    btnClose.onChange 		= onChange_Cancel
    btnRed.onChange 		= onChange_Red
    btnBlue.onChange 		= onChange_Blue
	btnNeutrals.onChange 	= onChange_Neutrals
    btnSpectators.onChange 	= onChange_Spectators
end

function setAvailableCoalitions(a_AvailableCoalitions)
    AvailableCoalitions = a_AvailableCoalitions
end

function show()
    if not window then
		 create()
	end
    
    if AvailableCoalitions then
        if AvailableCoalitions['red'] then
            btnRed:setEnabled(true)
        else
            btnRed:setEnabled(false)
        end
        
        if AvailableCoalitions['blue'] then
            btnBlue:setEnabled(true)
        else
            btnBlue:setEnabled(false)
        end
		
		if AvailableCoalitions['neutrals'] then
            btnNeutrals:setEnabled(true)
        else
            btnNeutrals:setEnabled(false)
        end
    end
    
	if window:getVisible() == false then
		window:setVisible(true)
		DCS.lockAllMouseInput()
		DCS.setPause(true)
	end
end

function hide()
	if window and window:getVisible() == true then
		window:setVisible(false)
		DCS.unlockMouseInput()
		DCS.setPause(false)
	end
end

function getVisible()
    if window == nil then
        return false
    end
	return window:getVisible()
end

function setVisible(b)
    if window then
		if b == true then
			if window:getVisible() == false then
				window:setVisible(true)
				DCS.lockAllMouseInput()
				DCS.setPause(true)
			end
		else
			if window:getVisible() == true then
				window:setVisible(false)
				DCS.unlockMouseInput()
				DCS.setPause(false)
			end
		end	
    end
end

function onChange_Cancel()
    hide()
    GameMenu.show()
end

function onChange_Spectators()
    DCS.setPlayerUnit("")
    hide()
end

function onChange_Red()
    DCS.setPlayerCoalition("red")
    hide() 
    ChoiceOfRoleDialog.show("red", true, "ChoiceCoalition")    
end

function onChange_Blue()
    DCS.setPlayerCoalition("blue")
    hide()
    ChoiceOfRoleDialog.show("blue", true, "ChoiceCoalition")    
end

function onChange_Neutrals()
	DCS.setPlayerCoalition("neutrals")
    hide()
    ChoiceOfRoleDialog.show("neutrals", true, "ChoiceCoalition")    
end

function kill()
	if window_ then
	   window_:setVisible(false)
	   window_:kill()
	   window_ = nil
	end
end