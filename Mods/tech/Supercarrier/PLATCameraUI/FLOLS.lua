package.path =	package.path
				.. ';./Scripts/?.lua;'
				.. './Scripts/Common/?.lua;'
				.. './Scripts/UI/?.lua;'
				.. './dxgui/bind/?.lua;'
				.. './dxgui/loader/?.lua;'
				.. './dxgui/skins/skinME/?.lua;'
				.. './dxgui/skins/common/?.lua;'
				.. './MissionEditor/modules/?.lua;'
				
local DialogLoader			= require('DialogLoader')
local gettext				= require('i_18n')
local dxgui					= require('dxgui')
local SkinUtils 			= require('SkinUtils')

local function _(text) 
    return gettext.translate(text) 
end
local FLOLS
function create()
	FLOLS	= DialogLoader.spawnDialogFromFile('Mods/tech/Supercarrier/PLATCameraUI/FLOLS.dlg')
	
	local screenWidth, screenHeigt = dxgui.GetScreenSize()
	
	local w,h = FLOLS:getSize()
	
	local x = screenWidth/4 - w/2
	local y = screenHeigt/2 - h/2
		
	FLOLS:setBounds(x,y,w,h)
	FLOLS:setVisible(false)
end

function kill()
	FLOLS:kill()
	FLOLS = nil
end


function show(val)
	FLOLS:setVisible(val)
end

function update(meatball,datum,cutlights)
	
	FLOLS.cutlights:setEnabled(cutlights > 0.95)
	FLOLS.waveoff:setEnabled(datum > 0.95)
	FLOLS.datum_outer:setEnabled(datum > 0.499)
	
	if  meatball < -1 then
		FLOLS.center.meatball:setVisible(false)
	else
		local w,h    = FLOLS.center:getSize()
		local mw,mh  = FLOLS.center.meatball:getSize();
	
		local min_y = 2
		local max_y = h - mh - 2
		local x,y = FLOLS.center.meatball:getPosition()
		y = min_y  + (1 - meatball) * (max_y - min_y)/2
		
		FLOLS.center.meatball:setVisible(true)
		FLOLS.center.meatball:setPosition(x,y)
		FLOLS.center.meatball:setEnabled(meatball > -0.9)
	end
	
	if datum > 0.7 then
		FLOLS.datum_inner:setEnabled(false)
	else
		FLOLS.datum_inner:setEnabled(datum > 0.499)
	end
	
end

local os_m
local function testUpdate()
	if not FLOLS then
		return true
	end
	update(math.sin(os_m.clock()),math.abs(math.cos(0.2*os_m.clock())),math.abs(math.sin(0.2*os_m.clock())))
	return false
end


function unit_test_FLOLS(wnd)
	os_m 				= require("os")
	FLOLS 				= wnd
	activity 			= testUpdate;
end 