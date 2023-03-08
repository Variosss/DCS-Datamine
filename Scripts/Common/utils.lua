local base = _G

module('utils')

--lua

function loadfileIn(fileName, table)
	local chunk, errMsg = base.loadfile(fileName)
	if chunk ~= nil then
		base.setfenv(chunk, table)
		return chunk
	else
		return nil, errMsg
	end
end

function dofileIn(fileName, table)
	base.assert(table ~= nil)
	local chunk, errMsg = base.loadfile(fileName)
	if chunk ~= nil then
		base.setfenv(chunk, table)
		return chunk()
	else
		return nil, errMsg
	end
end

function dofileInEx(fileName, table, base)
	table.dofile = function(fileName)
		return dofileIn(fileName, base)
	end
	base.setmetatable(table, { __index = base })
end

function verifyChunk(chunk, errMsg)
	if chunk ~= nil then
		return chunk
	else
		base.error(errMsg)
	end
end

function copyTable(dest, source)
	for key, value in base.pairs(source or {}) do
		if base.type(value) == 'table' then
		  dest[key] = {}
		  copyTable(dest[key], value)
		else
		  dest[key] = value
		end
	end
end

function createTableCopy(source)
	local dest = {}
	copyTable(dest, source)
	return dest
end

--graphics

function makeColor(R, G, B)
	return R * 256 * 256 + G * 256 + B
end

COLOR = {
	WHITE 		= makeColor(255, 255, 255),
	LIGHT_GRAY 	= makeColor(200, 200, 200),
	DARK_GRAY 	= makeColor(74, 74, 74),
	RED 		= makeColor(125, 75, 0),
	BLUE 		= makeColor(0, 75, 125),
	BLACK 		= makeColor(0, 0, 0)
}

--math

function get_vec_length(vec)
	return base.math.sqrt(vec.x * vec.x + vec.y * vec.y + vec.z * vec.z)
end

function get_lengthZX(vec)
	return base.math.sqrt(vec.x * vec.x + vec.z * vec.z)
end

function get_azimuth(vec)
	local azimuth = base.math.atan2(vec.z, vec.x)
	if azimuth < 0.0 then
		azimuth = 2 * PI + azimuth
	end
	return azimuth
end

function get_elevation(vec)
	return base.math.atan2(vec.y, self:get_hor_distance(vec))
end

function round(value, accuracy)
	return accuracy * base.math.floor(value / accuracy + 0.5)
end

function adv_round(value, maxAccuracy)
	if value == 0 then
		return 0
	end
	local rank = base.math.floor(base.math.log(value) / base.math.log(10))
	local accuracy = 10 ^ (rank - 1)
	
	local tmp = value / accuracy
	if tmp > 50 then
		accuracy = accuracy * 10
	elseif tmp > 30 then
		accuracy = accuracy * 5
	end
	if maxAccuracy then
		accuracy = base.math.max(accuracy, maxAccuracy)
	end
	return round(value, accuracy)
end

function round_qty(qty)
	if qty < 13 then
		return qty
	elseif qty < 17 then
		return 15
	elseif qty < 60 then
		return round(qty, 10)
	elseif qty < 300 then
		return round(qty, 50)
	else
		return adv_round(qty)
	end
end

function getTime(sec)
	local sec = base.timer.getAbsTime()
	local dayTime = base.math.mod(sec, 86400)
	local hh = base.math.floor(dayTime / 3600)
	dayTime = dayTime - hh * 3600
	local mm = base.math.floor(dayTime / 60)
	dayTime = dayTime - mm * 60
	local ss = base.math.floor(dayTime)
	return hh, mm, ss
end

function angleDegrees(dd, mm, ss)
	return dd + mm / 60 + ss / 3600
end

--string

function parseCordinates(str)
	local latD, latM, latS, NS, lonD, lonM, lonS, WE, course = base.string.match(str, '([0-9]+)\'([0-9]+)\'([0-9%.]+)%s*([NnSs]+)%s*([0-9]+)\'([0-9]+)\'([0-9%.]+)%s*([WwEe]+)%s*([0-9]*)')
	local latitude = angleDegrees(latD, latM, latS) 
	if NS == 'S' or NS == 's' then
		latitude = -latitude
	end
	local longitude = angleDegrees(lonD, lonM, lonS)
	if WE == 'W' or WE == 'w' then
		longitude = -longitude
	end	
	return latitude, longitude, course
end

--measure units

PI = base.math.pi

--units convertion
--native unit system - SI
--distance - m
--velocity - m/s
--angle - rad
--pressure - Pa

units = {
	m 		= { coeff = 1.0, name = 'meters' },--m
	km 		= { coeff = 1.0 / 1000.0, name = 'kilometers' },--m to km
	feet	= { coeff = 3.2808399, name = 'feet' },--m to feet
	yard 	= { coeff = 0.9144, name = 'yard' }, --m to yards
	nm 		= { coeff = 1.0 / 1851.9999984, name = 'nautical miles' }, --m to nm
	ms		= { coeff = 1.0, name = 'meters per second' }, --m/s
	kmh		= { coeff = 3600.0 / 1000.0, name = 'kilometers per hour' }, --m/s to km/h
	kts		= { coeff = 3600.0 / 1851.9999984, name = 'knots' }, --m/s to kts
	fpm		= { coeff = 60.0 * 3.2808399, name = 'feet per minute' }, --m/s to feet per minute
	deg		= { coeff = 57.296, name = 'degrees' }, --rad to deg
	mmHg	= { coeff = 1.0 / 133.3, name = 'mmHg' }, --Pa to mmHg
	im		= { coeff = 1.0 / 133.3 / 25.4, name = 'inches of mercury' }, --Pa to inches of mercury
}

--bitwise operations
--This example taken from "Iterating bits in Lua" article by r · i · c · i
--http://ricilake.blogspot.com/2007/10/iterating-bits-in-lua.html

function hasbit(x, p)
  return x % (p + p) >= p       
end

function bitor(x, y)
  local p = 1; local z = 0; local limit = x > y and x or y
  while p <= limit do
	if hasbit(x, p) or hasbit(y, p) then
	  z = z + p
	end
	p = p + p
  end
  return z
end	
