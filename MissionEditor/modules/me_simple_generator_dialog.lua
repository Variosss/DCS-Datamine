local base = _G

module('me_simple_generator_dialog')

local require = base.require

local T						= require('tools')
local U						= require('me_utilities')
local S						= require('Serializer')
local DialogLoader			= require('DialogLoader')
local AutoBriefingModule	= require('me_autobriefing')
local waitScreen			= require('me_wait_screen')
local GDData				= require('me_generator_dialog_data')
local MainMenu				= require('MainMenu')
local me_modules_mediator	= require('me_modules_mediator')
local Gui					= require('dxgui')
local MsgWindow			    = require('MsgWindow')
local Analytics				= require("Analytics")  
local UpdateManager			= require('UpdateManager')

require('i18n').setup(_M)

local enmGenStart, enmGenFinish, enmPercent = 0, 1, 2

local function onButtonFly()
	waitScreen.showMini(true, _("Generated:").."0%")
	UpdateManager.add(function()
		local MGModule = require('me_generator')
		
		if GDData.verifyCoalition() == false then
			MsgWindow.warning(GDData.cdata.noCountryInCoalition, _("WARNING"), _("OK")):show()
		else
			if cbHistorical:getState() == true then
				GDData.genParams().predefinedMission = 3 -- исторический
			else
				GDData.genParams().predefinedMission = 0
			end
			MGModule.generate(GDData.genParams(), false, GDData.genParams().theatreOfWar, nil, nil, nil, endGenerate)
		end
		return true
	end)
end

function endGenerate(returnCode, nodeId, error)
	if returnCode == enmGenFinish then
		if nodeId ~= -1 then
			AutoBriefingModule.updateAutoBriefing()
			AutoBriefingModule.returnToME = true
			AutoBriefingModule.show(true, 'mainmenu')
		end

		show(false)
		waitScreen.showMini(false)
	elseif returnCode == enmPercent then
		waitScreen.setMiniText(_("Generated:")..base.tostring(base.math.floor(nodeId or 0))..'%'--[[- '..error]])
		waitScreen.setMiniValue(base.math.floor(nodeId))
	end
end

local function onButtonExit()
	show(false)
	MainMenu.show(true);
end

local function onButtonAdvanced()
	show(false)
	me_modules_mediator.get_me_generator_dialog().show(true, 'simplegenerator');
end

local function create()	
	gdWindow = DialogLoader.spawnDialogFromFile("MissionEditor/modules/dialogs/me_gen_simple_options.dlg", GDData.cdata)
	
	gdWindow:setBounds(0, 0, base.main_w, base.main_h)
	
	function gdWindow:onClose()
		onButtonExit()
	end
	
	gdWindow:addHotKeyCallback('escape', onButtonExit)
	
	local containerCommon = gdWindow.MainPanel.containerCommon
	
	GDData.initCommonOptions(containerCommon)
	
	function containerCommon.comboboxAircraft:onChange(item)
		GDData.genParams().aircraft = item.itemId
		GDData.genParams().aircraftsType = item.aircraftType
		
		GDData.fillCountryCombobox(containerCommon.comboboxCountry)
	end
	
	cbHistorical = containerCommon.cbHistorical
	
	if GDData.genParams().predefinedMission == 3 then
		cbHistorical:setState(true)
	else	
		cbHistorical:setState(false)
	end	
	
	function cbHistorical:onChange()
		if self:getState() == true then
			GDData.genParams().predefinedMission = 3 -- исторический
		else
			GDData.genParams().predefinedMission = 0
		end
		GDData.fillCountryCombobox(containerCommon.comboboxCountry)
	end
	
	gdWindow.MainPanel.footerPanel.buttonFly.onChange = onButtonFly
	gdWindow.MainPanel.footerPanel.buttonCancel.onChange = onButtonExit
	gdWindow.MainPanel.btnClose.onChange = onButtonExit
	containerCommon.buttonAdvanced.onChange = onButtonAdvanced
end

function show(b)
	if (b == false) and (not gdWindow) then
		return
	end
	
	if not gdWindow then
		create()
	end
	
	if b then 
		GDData.setWidgetValuesFromParams(gdWindow.MainPanel.containerCommon) 
		Analytics.pageview(Analytics.FastMission)
	end
	
	-- MainMenu.setEnabled(not b)
	
	gdWindow:setVisible(b)
end