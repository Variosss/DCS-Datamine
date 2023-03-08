-- размер
local ModuleLocker = require('ModuleLocker')

module('Size')

-- если размер не указан, то 0
function new(horz, vert)
  return {
    horz = horz or 0, 
    vert = vert or 0,
  }
end

function getNilValue(nilValue)
	return new(nilValue, nilValue)
end


ModuleLocker.lock(_M)
