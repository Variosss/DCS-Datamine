-- прямоугольник
local ModuleLocker = require('ModuleLocker')

module('Rect')

function new(x1, y1, x2, y2)
	return {
		x1 = x1 or 0, 
		y1 = y1 or 0, 
		x2 = x2 or 0, 
		y2 = y2 or 0, 
	}
end

function getNilValue(nilValue)
	return new(nilValue, nilValue, nilValue, nilValue)
end

ModuleLocker.lock(_M)
