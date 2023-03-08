local base = _G

module('AWACSInfo')

local Window 	= base.require('Window')
local loader 	= base.require('DialogLoader')
local i18n 		= base.require('i18n')
local Gui 		= base.require("dxgui")

i18n.setup(_M)

local window = nil
local cdata = 
{
	altitude 	= _('ALT'),
	speed 		= _('SPEED'),
	heading 	= _('HEADING'),
	coord 		= _('COORD'),
	country 	= _('COUNTRY'),
	group 		= _('GROUP'),
	type 		= _('TYPE'),
	task 		= _('TASK'),
	callsign 	= _('CALLSIGN'),
	life 		= _('LIFE'),
}

local  update_gm = function()
	if  window.lifeSlider then 
		window.lifeSlider:setVisible(setLifeAllowed())
	end
	if  window.sLife then 
		window.sLife:setVisible(setLifeAllowed())
	end
end

function create()
	if  window then 
		return
	end

	window = loader.spawnDialogFromFile("./Scripts/UI/F10View/AWACSInfo.dlg", cdata)
	
	local mw, mh = Gui.GetWindowSize()
	local x, y, w, h = window:getBounds()
	window:setBounds(0,mh - h, w, h)
	
	function window.btnStats:onChange()
		if onShowStats ~= nil then
		   onShowStats()
		end
	end
	update_gm()
	if  window.lifeSlider then 
		window.lifeSlider:setRange(0,100)
		window.lifeSlider.onChange = function (self)   setLife(0.01 * self:getValue()) end
	end
end

function updateStaticData(country, group, unitType, callsign)
	window.sCountryValue:setText(country)
	window.sGroupValue:setText(group)
	window.sTypeValue:setText(unitType)
	window.sCallsignValue:setText(callsign)
end

function updateDynamicData(alt, speed, hdg, coordsStr, task , mag ,life_relative)
	window.sAltValue:setText(base.tostring(alt))
	window.sSpeedValue:setText(base.tostring(speed))
	window.sHeadingValue:setText(base.tostring(hdg))
	window.sCoordsValue:setText(coordsStr)
	window.sTaskValue:setText(task)
	window.sHeadingMagneticValue:setText(mag)
	if  window.lifeSlider and life_relative ~= nil then 
		window.lifeSlider:setValue(100 * life_relative)
	end
end

function destroy()
	if not window then return end
	window:kill()
	window = nil
end

function show(b,NONE_F10)
	window:setVisible(b)
	if  b then
		update_gm()
		local dy = 0
		if 	NONE_F10 then 
			dy = -30
		end
		local mw, mh 	 = Gui.GetWindowSize()
		local x, y, w, h = window:getBounds()
		window:setBounds(0,mh - h + dy,w,h)
	end
end