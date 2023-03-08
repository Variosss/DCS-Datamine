local base = _G

module('OverlayWidget')
mtab = { __index = _M }

local Factory		= base.require('Factory')
local Widget		= base.require('Widget')
local gui_overlay	= base.require('gui_overlay')

Factory.setBaseClass(_M, Widget)

function new()
	return Factory.create(_M)
end

function construct(self)
	Widget.construct(self)
end

function newWidget()
	return gui_overlay.NewOverlayWidget()
end

-- color таблица вида {r = [0;1], g = [0;1], b = [0;1], a = [0;1]}
-- где [0;1] - значение в диапазоне от 0 до 1
function addHorzLine(self, distance, color)
	local lineHandler = gui_overlay.OverlayWidgetAddHorzLine(self.widget, distance, color)
	
	return lineHandler
end

function addVertLine(self, distance, color)
	local lineHandler = gui_overlay.OverlayWidgetAddVertLine(self.widget, distance, color)
	
	return lineHandler	
end

function addLine(self, x1, y1, x2, y2, color)
	local lineHandler = gui_overlay.OverlayWidgetAddLine(self.widget, x1, y1, x2, y2, color)
	
	return lineHandler
end

function removeLine(self, lineHandler)
	gui_overlay.OverlayWidgetRemoveLine(self.widget, lineHandler)
end

-- для горизонтальных и вертикальных линий
function setLineDistance(self, lineHandler, distance)
	gui_overlay.OverlayWidgetSetLineDistance(self.widget, lineHandler, distance)
end

-- color таблица вида {r = [0;1], g = [0;1], b = [0;1], a = [0;1]}
-- где [0;1] - значение в диапазоне от 0 до 1
function setLineColor(self, lineHandler, color)
	gui_overlay.OverlayWidgetSetLineColor(self.widget, lineHandler, color)
end

function setLinePoints(self, lineHandler, x1, y1, x2, y2)
	gui_overlay.OverlayWidgetSetLinePoints(self.widget, lineHandler, x1, y1, x2, y2)
end

-- удаляет все линии
function clearLines(self)
	gui_overlay.OverlayWidgetClearLines(self.widget)
end

-- устанавливает текущий шрифт
-- все последующие вызовы addCaption будут использовать текущий шрифт
function setCaptionFont(self, fontName, fontSize)
	gui_overlay.OverlayWidgetSetCaptionFont(self.widget, fontName, fontSize)
end

-- создает строку текста
-- текст использует шрифт, заданный последним вызовом setCaptionFont()
-- color таблица вида {r = [0;1], g = [0;1], b = [0;1], a = [0;1]}
-- где [0;1] - значение в диапазоне от 0 до 1
function addCaption(self, text, x, y, color, bkgColor)
	local captionHandler = gui_overlay.OverlayWidgetAddCaption(self.widget, text, x, y, color, bkgColor)
	
	return captionHandler
end

-- удаляет строку текста
-- использует хендлер, возвращенный функцией addCaption()
function removeCaption(self, captionHandler)
	gui_overlay.OverlayWidgetRemoveCaption(self.widget, captionHandler)
end

-- использует хендлер, возвращенный функцией addCaption()
function setCaptionText(self, captionHandler, text)
	gui_overlay.OverlayWidgetSetCaptionText(self.widget, captionHandler, text)
end

-- использует хендлер, возвращенный функцией addCaption()
function setCaptionPosition(self, captionHandler, x, y)
	gui_overlay.OverlayWidgetSetCaptionPosition(self.widget, captionHandler, x, y)
end

-- использует хендлер, возвращенный функцией addCaption()
function setCaptionColor(self, captionHandler, color, bkgColor)
	gui_overlay.OverlayWidgetSetCaptionColor(self.widget, captionHandler, color, bkgColor)
end

-- удаляет все строки текста
function clearCaptions(self)
	gui_overlay.OverlayWidgetClearCaptions(self.widget)
end
