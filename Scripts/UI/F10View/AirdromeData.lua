local base = _G

module('AirdromeData')

local require	= base.require
local print		= base.print
local tostring	= base.tostring

local loader 	= require('DialogLoader')
local i18n 		= require('i18n')
local Gui 		= require("dxgui")

local isMetricSystem = require('UICommon').isMetricSystem

i18n.setup(_M)
local function dtransl(s) 
	if s and s ~= '' then return i18n.gettext.dtranslate('missioneditor', s) end
	return ''
end

local window = nil
local cdata = 
{
	airdomeData	= _('AIRDROME DATA'	),
	coalition	= _('COALITION'		),
	coordinates	= _('COORDINATES'	),
	elevation 	= _('ELEVATION'		),
	name 		= _('NAME'			),
	rwylength 	= _('RWY Length'	),
	tacan 		= _('TACAN'			),
	atc 		= _('ATC'			),				
	vor 		= _('VOR'			),				
	rsbn 		= _('RSBN'			),
	rwys 		= _('RWYs'			),
	ils 		= _('ILS'			),
	outerndb 	= _('OUTER NDB'		),
	innerndb 	= _('INNER NDB'		),
	rpmg 		= _('PRMG'			),
	icaocode 	= _('ICAO'			),
	Resources 	= _('RESOURCES'		),
}

function create()
	if window then return end
	window = loader.spawnDialogFromFile("./Scripts/UI/F10View/AirdromeData.dlg", cdata)
	
	local mw, mh = Gui.GetWindowSize()
	local x, y, w, h = window:getBounds()
	window:setBounds(15, mh-h-15, w, h)
	
	function window.Panel1.bClose:onChange()
		--print('asdasdasd')
		if onClose ~= nil then
		   onClose()
		end
		show( false )
	end

	function window.Panel1.Panel1.bResources:onChange()
		--print('asdasdasd')
		if onShowStatsAirdrome ~= nil then
		   onShowStatsAirdrome()
		end
	end

end

function move(dx,dy)
	local x, y, w, h = window:getBounds()
	window:setBounds(x + dx, y + dy, w, h)
end
	
function updateStaticData(name,atc,country,tacan,rsbn,vor,rwy1,rwy2,rwylen,ils1,ils2,outer1,outer2,inner1,inner2,alt,coordsStr,callsign,prmg1,prmg2)	
	
	local units
	
	if isMetricSystem() then
		units = _('m')
	else
		units = _('ft')
	end	
	
	local panel = window.Panel1.Panel1
	
	panel.sName			:setText(name)
	panel.sAtc			:setText(atc)
	panel.sCoalition	:setText(country)
	panel.sTacan		:setText(tacan)
	panel.sRsbn			:setText(rsbn)
	panel.sVor			:setText(vor)
	panel.sRwys1		:setText(tostring(rwy1))
	panel.sRwys2		:setText(tostring(rwy2))
	panel.sRwylenght	:setText(tostring(rwylen) .. ' ' .. units)
	panel.sIls1			:setText(ils1)
	panel.sIls2			:setText(ils2)
	panel.sOuterndb1	:setText(outer1)
	panel.sOuterndb2	:setText(outer2)
	panel.sInnerndb1	:setText(inner1)
	panel.sInnerndb2	:setText(inner2)
	panel.sElevation	:setText(tostring(alt) .. ' ' .. units)
	panel.sCoordinates	:setText(coordsStr)
	panel.sRpmg1		:setText(prmg1)
	panel.sRpmg2		:setText(prmg2)
	panel.sIcaoCode		:setText(callsign)
end

function updateDynamicData( alt, coordsStr )
end

function destroy()
	if not window then return end

	window:kill()
	window = nil
end

function show(b)
	window:setVisible(b)
end