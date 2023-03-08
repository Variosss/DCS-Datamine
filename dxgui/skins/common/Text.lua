local base = _G

local Skin = base.require('Skin')
local Align = base.require('Align')
local Size = base.require('Size')
local ModuleLocker = base.require('ModuleLocker')

module('Text')

defaultFont_		= "DejaVuLGCSansCondensed-BoldOblique.ttf"
defaultFontSize_	= 12
defaultColor_		= '0xbec0afff'

function getDefaultFont()
	return defaultFont_
end

function setDefaultFont(font)
	ModuleLocker.setValue(_M, 'defaultFont_', font)
end

function getDefaultFontSize()
	return defaultFontSize_
end

function setDefaultFontSize(size)
	ModuleLocker.setValue(_M, 'defaultFontSize_', size)
end

function getDefaultBlur()
	return 0
end

function getDefaultBoldFont()
	return "DejaVuLGCSans-Bold.ttf"	
end

function getDefaultColor()
	return defaultColor_
end

function setDefaultColor(color)
	ModuleLocker.setValue(_M, 'defaultColor_', color)
end

function getDefaultHorzAlign()
	return Align.new(Align.center)
end

function getDefaultVertAlign()
	return Align.new(Align.center)
end

function getDefaultBkgColor()
	return nil
end

function getDefaultShadowColor()
	return nil
end

function getDefaultBlurColor()
	return nil
end

function getDefaultShadowOffset()
	return Size.new()
end

function getDefaultLineThroughColor()
	return nil
end

function getDefaultLineThroughHeight()
	return 1
end

function getDefaultLineThroughOffset()
	return 0
end

-- font - путь к файлу шрифта
-- size - размер шрифта в пикселях
-- color - цвет текста
-- horzAlign - выравнивание текста по горизонтали внутри виджета
-- vertAlign - выравнивание текста по вертикали внутри виджета
function new(font, size, color, horzAlign, vertAlign, bkgColor, shadowColor, shadowOffset, mono, blur, blurColor, lineThroughColor, lineThroughHeight, lineThroughOffset)
	return {
		font = font or getDefaultFont(),
		fontSize = size or getDefaultFontSize(),
		color = color or getDefaultColor(),
		horzAlign = horzAlign or getDefaultHorzAlign(),
		vertAlign = vertAlign or getDefaultVertAlign(),
		bkgColor = bkgColor or getDefaultBkgColor(),
		shadowColor = shadowColor or getDefaultShadowColor(),
		shadowOffset = shadowOffset or getDefaultShadowOffset(),
		mono = mono,
		blur = blur or getDefaultBlur(),
		blurColor = blurColor or getDefaultBlurColor(),
		lineThroughColor = lineThroughColor or getDefaultLineThroughColor(),
		lineThroughHeight = lineThroughHeight or getDefaultLineThroughHeight(),
		lineThroughOffset = lineThroughOffset or getDefaultLineThroughOffset(),
	}
end

function getNilValue(nilValue)
	return new(nilValue, -- font
			   nilValue, -- size
			   nilValue, -- color 
			   Align.getNilValue(nilValue), -- horzAlign
			   Align.getNilValue(nilValue), -- vertAlign
			   nilValue, -- bkgColor
			   nilValue, -- shadowColor
			   Size.getNilValue(nilValue), -- shadowOffset
			   nilValue, -- mono
			   nilValue, -- blur
			   nilValue, -- blurColor
			   nilValue, -- lineThroughColor
			   nilValue, -- lineThroughHeight
			   nilValue) -- lineThroughOffset
end


ModuleLocker.lock(_M)