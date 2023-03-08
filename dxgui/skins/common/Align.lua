-- выравнивание
local ModuleLocker = require('ModuleLocker')

module('Align')

-- допустимые типы выравнивания:
-- выравнивание по минимальной границе диапазона
min = 'min'

-- выравнивание по середине диапазона
middle = 'middle'

-- выравнивание по максимальной границе диапазона
max = 'max'

-- растягивание внутри диапазона
stretch = 'stretch'

-- для горизонтального выравнивания введены синонимы
left = min
center = middle
right = max

-- для вертикального выравнивания введены синонимы
top = min
center = middle
bottom = max

function parseAlignType(text)
	local result
	
	if min == text or
	   middle == text or
	   max == text or
	   stretch == text or
	   left == text or
	   right == text or
	   center == text or
	   top == text or
	   bottom == text then
		result = text
	end	 
	
	return result
end

-- если offset не указано, то 0
function new(alignType, offset)
	return {
		type = parseAlignType(alignType), 
		offset = offset,
	}
end

function getNilValue(nilValue)
	return new(nilValue, nilValue)
end

ModuleLocker.lock(_M)