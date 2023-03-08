local base = _G
local Insets = require('Insets')
local Rect = require('Rect')
local ModuleLocker = require('ModuleLocker')

module('Bkg')

local Skin = base.Skin

-- если €чейка не указана, то она не рисуетс€
function new(filename, rect, insets, 
			 left_top, center_top, right_top,
			 left_center, center_center, right_center,
			 left_bottom, center_bottom, right_bottom)
	return {			
			-- отступы
			-- если не указаны, то все отступы 0
			file = filename,
			rect = rect,
			insets = insets,
			left_top = left_top,
			center_top = center_top,
			right_top = right_top,
			left_center = left_center,
			center_center = center_center,
			right_center = right_center,		 
			left_bottom = left_bottom,			
			center_bottom = center_bottom,			
			right_bottom = right_bottom,
		}
end

-- пр€моугольник, залитый цветом color
function solid(color, nilValue)
	return new(nilValue, -- filename
			   nilValue, -- rect
			   nilValue, -- insets
			   nilValue, -- left_top, 
			   nilValue, -- center_top, 
			   nilValue, -- right_top,
			   nilValue, -- left_center, 
			   color, -- center_center, 
			   nilValue, -- right_center,
			   nilValue, -- left_bottom, 
			   nilValue, -- center_bottom, 
			   nilValue)	-- right_bottom
end

function lineBorder(color, centerColor, thickness, nilValue)
	return new(nilValue, -- filename
			   nilValue, -- rect
			   Insets.new(thickness, thickness, thickness, thickness), -- insets
			   color, -- left_top, 
			   color, -- center_top, 
			   color, -- right_top,
			   color, -- left_center, 
			   centerColor, -- center_center, 
			   color, -- right_center,
			   color, -- left_bottom, 
			   color, -- center_bottom, 
			   color)	-- right_bottom
end

-- рамка толщиной в 1 пиксель цвета color
function singleLineBorder(color, centerColor)
	return lineBorder(color, centerColor, 1)
end

-- рамка толщиной в 2 пиксел€ цвета color
function doubleLineBorder(color, centerColor)
	return lineBorder(color, centerColor, 2)
end

-- рамка из текстуры с закрашенным центром
-- текстура должна содержать в центре белые пиксели
-- чтобы цвет центра бралс€ из текстуры, нужно color сделать белым
-- чтобы центр не рисовалс€, нужно color сделать прозрачным или nil
function textureBorder(filename, rect, insets, color, texColor)
	texColor = texColor or '0xffffffff'
	
	return new(filename, -- filename
			   rect, -- rect
			   insets, -- insets
			   texColor, -- left_top, 
			   texColor, -- center_top, 
			   texColor, -- right_top,
			   texColor, -- left_center, 
			   color, -- center_center, 
			   texColor, -- right_center,
			   texColor, -- left_bottom, 
			   texColor, -- center_bottom, 
			   texColor)	-- right_bottom
end

function getNilValue(nilValue)
	return new(nilValue, -- filename
			   Rect.getNilValue(nilValue), -- rect
			   Insets.getNilValue(nilValue), -- insets
			   nilValue, -- left_top, 
			   nilValue, -- center_top, 
			   nilValue, -- right_top,
			   nilValue, -- left_center, 
			   nilValue, -- center_center, 
			   nilValue, -- right_center,
			   nilValue, -- left_bottom, 
			   nilValue, -- center_bottom, 
			   nilValue)	-- right_bottom
end

ModuleLocker.lock(_M)
