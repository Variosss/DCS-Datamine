-- отступы
local ModuleLocker = require('ModuleLocker')

module('Insets')

-- если не указаны, то все отступы 0
function new(left, right, top, bottom)
	return {
		left = left, 
		right = right, 
		top = top,
		bottom = bottom
	}
end

function getNilValue(nilValue)
	return new(nilValue, nilValue, nilValue, nilValue)
end

ModuleLocker.lock(_M)
