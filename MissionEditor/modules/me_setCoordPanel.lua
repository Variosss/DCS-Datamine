local base = _G

module('me_setCoordPanel')

local require = base.require
local string = base.string
local os = base.os

local loader			= require('DialogLoader')
local U					= require('me_utilities')
local MapWindow			= require('me_map_window')
local Terrain			= require('terrain')
local UpdateManager		= require('UpdateManager')
local OptionsData		= require('Options.Data')
local UC				= require('utils_common')
local ListBoxItem		= require('ListBoxItem')

require('i18n').setup(_M)

cdata =
{
	invalidValue 		= 	_("Invalid value"),
	setCoord			=	_("Set position"),
	ok					=	_("ok"),
	info				=	_("Type required coordinates here (geographical or MGRS)"),
	
	Type				= _("Type"),
	Metric				= _("Metric"),
	Lat_Long			= _("Lat Long"),
	Lat_Long_Decimal	= _("Lat Long Decimal Minutes"),
	MGRS_GRID			= _("MGRS GRID"),
	Precise_Lat_Long	= _("Precise Lat/Long"),
}

local callback = nil

	---форматы:
	
	--МГРС   37 T CK 12345 12345				
	--       X-12345678 Z-12345678				
	--	     N 41°50'30"   E 42°20'32"         
	--		 N 42°54.456'   E 40°16.258'
	--		 N 42°40'50.66"   E 41°12'16.35"

function create(x, y, w, h)
	window = loader.spawnDialogFromFile('MissionEditor/modules/dialogs/me_setCoordPanel.dlg', cdata)
	window:setBounds(x, y, w, h)

	clType			= window.clType
	pMetric 		= window.pMetric
	pLatLong 		= window.pLatLong
	pPreciseLatLong = window.pPreciseLatLong
	pLatLongDecimal = window.pLatLongDecimal 
	pMGRSGRID 		= window.pMGRSGRID

	
	btnOk = window.btnOk
	sError = window.sError
	
	btnOk.onChange = btnOk_onChange
	clType.onChange = clType_onChange
	pLatLong.btnA1.onChange = btnA_onChange
	pPreciseLatLong.btnA1.onChange = btnA_onChange
	pLatLongDecimal.btnA1.onChange = btnA_onChange
	pLatLong.btnA2.onChange = btnA_onChange
	pPreciseLatLong.btnA2.onChange = btnA_onChange
	pLatLongDecimal.btnA2.onChange = btnA_onChange
	
	pMetric:setPosition(20,50)
	pLatLong:setPosition(20,50)
	pPreciseLatLong:setPosition(20,50)
	pLatLongDecimal:setPosition(20,50)
	pMGRSGRID:setPosition(20,50)
	
	pMGRSGRID.sbD2:setFormatString("%05g")
	pMGRSGRID.sbD3:setFormatString("%05g")
	
	function window:onClose()		
		if callback then
			callback(nil, nil)
		end	
	end

	fill_clType()
	update()
end    


function show(a_visible, a_callback)
	updateLimits()
    window:setVisible(a_visible)	
	sError:setVisible(false)
	callback = a_callback	
end

function getVisible()
	return window:getVisible()
end


function btnOk_onChange()	
	local item = clType:getSelectedItem()
	local x,y

	sError:setVisible(false)
	
	if item.id == "Metric" then	
		x = pMetric.sbX:getValue()
		y = pMetric.sbY:getValue()	
	elseif item.id == "Lat_Long" then
		local lat  = LatLongToDegrees(pLatLong.btnA1:getText(), 
									pLatLong.sbGrad1:getValue(), 
									pLatLong.sbMin1:getValue(),
									pLatLong.sbSec1:getValue()) -- N 44°12'12" 
		local long = LatLongToDegrees(pLatLong.btnA2:getText(), 
									pLatLong.sbGrad2:getValue(), 
									pLatLong.sbMin2:getValue(),
									pLatLong.sbSec2:getValue()) -- N 44°12'12" 
	
		if long == nil or lat == nil then
			sError:setText(cdata.invalidValue)
			sError:setVisible(true)
			return 
		end

		x,y = Terrain.convertLatLonToMeters(lat, long)	
	elseif item.id == "Precise_Lat_Long" then		
		local lat  = LatLongPToDegrees(pPreciseLatLong.btnA1:getText(), 
									pPreciseLatLong.sbGrad1:getValue(), 
									pPreciseLatLong.sbMin1:getValue(),
									pPreciseLatLong.sbSec1:getValue()) -- N 44°12'12.343"
		local long = LatLongPToDegrees(pPreciseLatLong.btnA2:getText(), 
									pPreciseLatLong.sbGrad2:getValue(), 
									pPreciseLatLong.sbMin2:getValue(),
									pPreciseLatLong.sbSec2:getValue()) -- N 44°12'12.343"
	
		
		if long == nil or lat == nil then
			sError:setText(cdata.invalidValue)
			sError:setVisible(true)
			return 
		end
	
		x,y = Terrain.convertLatLonToMeters(lat, long)		
	elseif item.id == "Lat_Long_Decimal" then	
		local lat  = LatLongDToDegrees(pLatLongDecimal.btnA1:getText(), 
									pLatLongDecimal.sbGrad1:getValue(), 
									pLatLongDecimal.sbMin1:getValue()) -- N 44°12.343'
		local long = LatLongDToDegrees(pLatLongDecimal.btnA2:getText(), 
									pLatLongDecimal.sbGrad2:getValue(), 
									pLatLongDecimal.sbMin2:getValue()) -- N 44°12.343'
	
		if long == nil or lat == nil then
			sError:setText(cdata.invalidValue)
			sError:setVisible(true)
			return 
		end
				
		x,y = Terrain.convertLatLonToMeters(lat, long)	
		

	elseif item.id == "MGRS_GRID" then			
		x,y = Terrain.convertMGRStoMeters(base.string.format("%d %s %s %05d %05d",
											pMGRSGRID.sbD1:getValue(),
											pMGRSGRID.eT1:getText(),
											pMGRSGRID.eT2:getText(),
											pMGRSGRID.sbD2:getValue(),
											pMGRSGRID.sbD3:getValue()))  -- 38 T LL 49930 49350											
	end	

	if x and y and MapWindow.getPointInMap(x, y) == true then
		MapWindow.focusPointMap(x, y)
		if callback ~= nil then
			callback(x, y)
		end
	else
		sError:setText(cdata.invalidValue)
		sError:setVisible(true)
	end	
end	

function fill_clType()
	local item				= ListBoxItem.new(cdata.Metric)
	item.id = "Metric"
	clType:insertItem(item)
	clType:selectItem(item)
	
	item				= ListBoxItem.new(cdata.Lat_Long)
	item.id = "Lat_Long"
	clType:insertItem(item)
	
	item				= ListBoxItem.new(cdata.Lat_Long_Decimal)
	item.id = "Lat_Long_Decimal"
	clType:insertItem(item)
	
	item				= ListBoxItem.new(cdata.Precise_Lat_Long)
	item.id = "Precise_Lat_Long"
	clType:insertItem(item)
	
	item				= ListBoxItem.new(cdata.MGRS_GRID)
	item.id = "MGRS_GRID"
	clType:insertItem(item)
end

function clType_onChange()
	update()
end
		
function LatLongToDegrees(a_val1, a_val2, a_val3, a_val4) -- N 44°12'12" 
	local degrees = a_val4/3600 + a_val3/60 + a_val2
	
	if a_val1 == 'W' or a_val1 == 'w' or a_val1 == 'S' or a_val1 == 's' then
		degrees = -degrees
	end

	return degrees
end

function LatLongDToDegrees(a_val1, a_val2, a_val3) -- N 44°12.343'
	local degrees = a_val3/60 + a_val2
	
	if a_val1 == 'W' or a_val1 == 'w' or a_val1 == 'S' or a_val1 == 's' then
		degrees = -degrees
	end

	return degrees
end

function LatLongPToDegrees(a_val1, a_val2, a_val3, a_val4) -- N 44°11'12.33"
	local degrees = a_val4/3600 + a_val3/60 + a_val2
	
	if a_val1 == 'W' or a_val1 == 'w' or a_val1 == 'S' or a_val1 == 's' then
		degrees = -degrees
	end

	return degrees
end

function stringLatLongDToDegrees(str) --  E45 84.343
	local value = {} 
	local i = 1
	for w in base.string.gmatch(str,"%d+") do 
		value[i] = w
		i = i+1		
	end
	
	value[3] = setMant(base.tonumber(value[3]))
	
	local degrees = (value[3] + value[2])/60 + value[1]	
	value[4] = base.string.match(str,"%s")
	
	if value[4] == 'W' or value[4] == 'w' or value[4] == 'S' or value[4] == 's' then
		degrees = -degrees
	end

	return degrees
end



function convertStrPreciseLatLongToMeters(str) --  N 42°40'50.66" E 41°12'16.35"
	local res = {}
	local i = 1

	for w in base.string.gmatch(str,"%a %d+°%d+'%d+.%d+\"") do 
		res[i] = w
		i = i+1		
	end
	
	local lat  = stringPreciseLatLongToDegrees(res[1])
	local long = stringPreciseLatLongToDegrees(res[2])
	
	if long == nil or lat == nil then
		return nil
	end
	
	local x,y = Terrain.convertLatLonToMeters(lat, long)	
	
	return x,y	
end

function setMant(number)

	while number > 1 do
		number = number / 10
	end

	return number
end

function update()
	local item = clType:getSelectedItem()
	
	pMetric:setVisible(false)
	pLatLong:setVisible(false)
	pPreciseLatLong:setVisible(false)
	pLatLongDecimal:setVisible(false)
	pMGRSGRID:setVisible(false)

	if item.id == "Metric" then	
		pMetric:setVisible(true)
	elseif item.id == "Lat_Long" then	
		pLatLong:setVisible(true)
	elseif item.id == "Precise_Lat_Long" then	
		pPreciseLatLong:setVisible(true)
	elseif item.id == "Lat_Long_Decimal" then	
		pLatLongDecimal:setVisible(true)
	elseif item.id == "MGRS_GRID" then	
		pMGRSGRID:setVisible(true)
	end					

end

function isStateSetPosUnit()
	if window and window:getVisible() == true and callback ~= nil then
		return true
	end
	return false
end

function setMapPoint(x, y)
	if callback then
		callback(x, y)
	end
end	

function hide()	
	window:setVisible(false)
end

function updateLimits()
	local SW_bound 		= Terrain.GetTerrainConfig("SW_bound")
    local NE_bound 		= Terrain.GetTerrainConfig("NE_bound")

	pLatLong.btnA1.items = {}
	pPreciseLatLong.btnA1.items = {}
	pLatLongDecimal.btnA1.items = {}
	pLatLong.btnA2.items = {}
	pPreciseLatLong.btnA2.items = {}
	pLatLongDecimal.btnA2.items = {}
	
	for k,v in base.pairs({SW_bound, NE_bound}) do
		local lat, long = MapWindow.convertMetersToLatLon(v[1]*1000, v[3]*1000)

		local latLongFormatString = '%s %2d°%2d\'%2d"'
		
		local g, m, s, dLat   = U.degreesToLatitude(lat)
		local g, m, s, dLong  = U.degreesToLongitude(long)
				
		if pLatLong.btnA1.items[1] ~= dLat and pLatLong.btnA1.items[2] ~= dLat then
			base.table.insert(pLatLong.btnA1.items,dLat)
			pLatLong.btnA1.curItem = 1
			pLatLong.btnA1:setText(pLatLong.btnA1.items[1])
		end
		
		if pPreciseLatLong.btnA1.items[1] ~= dLat and pPreciseLatLong.btnA1.items[2] ~= dLat then
			base.table.insert(pPreciseLatLong.btnA1.items,dLat)
			pPreciseLatLong.btnA1.curItem = 1
			pPreciseLatLong.btnA1:setText(pPreciseLatLong.btnA1.items[1])
		end
		
		if pLatLongDecimal.btnA1.items[1] ~= dLat and pLatLongDecimal.btnA1.items[2] ~= dLat then
			base.table.insert(pLatLongDecimal.btnA1.items,dLat)
			pLatLongDecimal.btnA1.curItem = 1
			pLatLongDecimal.btnA1:setText(pLatLongDecimal.btnA1.items[1])
		end
		----------
		if pLatLong.btnA2.items[1] ~= dLong and pLatLong.btnA2.items[2] ~= dLong then
			base.table.insert(pLatLong.btnA2.items,dLong)
			pLatLong.btnA2.curItem = 1
			pLatLong.btnA2:setText(pLatLong.btnA2.items[1])
		end
		
		if pPreciseLatLong.btnA2.items[1] ~= dLong and pPreciseLatLong.btnA2.items[2] ~= dLong then
			base.table.insert(pPreciseLatLong.btnA2.items,dLong)
			pPreciseLatLong.btnA2.curItem = 1
			pPreciseLatLong.btnA2:setText(pPreciseLatLong.btnA2.items[1])
		end
		
		if pLatLongDecimal.btnA2.items[1] ~= dLong and pLatLongDecimal.btnA2.items[2] ~= dLong then
			base.table.insert(pLatLongDecimal.btnA2.items,dLong)
			pLatLongDecimal.btnA2.curItem = 1
			pLatLongDecimal.btnA2:setText(pLatLongDecimal.btnA2.items[1])
		end
		
	end	
end

function btnA_onChange(self)
	if self.curItem and self.items then
		self.curItem = self.curItem + 1
		
		if self.curItem > #self.items then
			self.curItem = 1
		end	
	end
	
	self:setText(self.items[self.curItem])
end