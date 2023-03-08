local base = _G

module('MarkPanel')

local Window = base.require('Window')
local loader = base.require('DialogLoader')
local i18n = base.require('i18n')
local Gui = base.require("dxgui")

i18n.setup(_M)
local function dtransl(s) 
	if s and s ~= '' then return i18n.gettext.dtranslate('missioneditor', s) end
	return ''
end

local gWindows = {}

local window = nil
local cdata = 
{
	markLabel = _('MARK LABEL'),
}

function create( nIdx )

	window = loader.spawnDialogFromFile("./Scripts/UI/F10View/MarkPanel.dlg", cdata)

	local mw, mh = Gui.GetWindowSize()
	local x, y, w, h = window:getBounds()
	window:setBounds(15, mh/2, w, h)

	gWindows[nIdx] = window
	return window.widget
end

function setInstance( nIdx )
	window = gWindows[nIdx]
end

function move(dx,dy)
	if not window then return end
	local x, y, w, h = window:getBounds()
	window:setBounds(x + dx, y + dy, w, h)
end

function setPos(dx,dy)
	if not window then return end
	local x, y, w, h = window:getBounds()
	window:setBounds(dx, dy, w, h)
end

function getButtonClose()
	if not window then return nil end
	return window.headePanel.btnClose.widget
end

function getButtonMinimize()
	if not window then return nil end
	return window.headePanel.btnCur.widget
end

function getEditBox()
	if not window then return nil end
	return window.bodyPanel.eMarkLable.widget
end
	
function getStaticUserName()
	if not window then return nil end
	return window.headePanel.sMarkUserName.widget
end

function getStaticDate()
	if not window then return nil end
	return window.headePanel.sMarkDate.widget
end

function setIndex( nIdx )
	if not window then return end
	window.headePanel.sMarkId:setText( base.tostring(nIdx).. _('.') )
end

function setUserName( strName )
	if not window then return end
	window.headePanel.sMarkUserName:setText( strName )
end

function updateStaticData()	
end

function destroy()
	if not window then return end

	window:kill()
	window = nil
end

function show(b)
	if not window then return end
	window:setVisible(b)
end