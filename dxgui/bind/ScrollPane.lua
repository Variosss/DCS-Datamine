local base = _G

module('ScrollPane')
mtab = { __index = _M }

local Factory		= base.require('Factory')
local Widget		= base.require('Widget')
local LayoutFactory	= base.require('LayoutFactory')
local gui			= base.require('dxgui')

Factory.setBaseClass(_M, Widget)

function new()
	return Factory.create(_M)
end

function construct(self)
	Widget.construct(self)
	self:addCallback('scroll pane change', function()
		self:onScrollChange()
	end)
end

function newWidget(self)
	return gui.NewScrollPane()
end

function clone(self)
	local result = Factory.clone(_M, self)

	self:copyWidgetNames(result)
	
	return result
end

function copyWidgetNames(self, clone)
	local count = self:getWidgetCount()
	
	for i = 1, count do
		local index 		= i - 1
		local widget 		= self:getWidget(index)
		local cloneWidget 	= clone:getWidget(index)
		
		for name, param in base.pairs(self) do
			if param == widget then
				clone[name] = cloneWidget
				
				break
			end
		end
		
		widget:copyWidgetNames(cloneWidget)
	end
end

function register(self, widgetPtr)
	Widget.register(self, widgetPtr)
	
	local count = self:getWidgetCount()
	
	for i = 1, count do
		local itemPtr = gui.ScrollPaneGetWidget(self.widget, i - 1)
		local typeName = gui.WidgetGetTypeName(itemPtr)
		
		Factory.registerWidget(typeName, itemPtr)
	end
end

function createClone(self)
	return gui.ScrollPaneClone(self.widget)
end

-- index - опционально
-- если index = -1 или index = nil то widget добавляется в конец списка
function insertWidget(self, widget, index)
	gui.ScrollPaneInsertWidget(self.widget, widget.widget, index)
end

function getWidget(self, index)
	return widgets[gui.ScrollPaneGetWidget(self.widget, index)]
end

function getWidgetIndex(self, widget)
	return gui.ScrollPaneGetWidgetIndex(self.widget, widget.widget)
end

function removeWidget(self, widget)
	gui.ScrollPaneRemoveWidget(self.widget, widget.widget)
end

function removeAllWidgets(self)
	gui.ScrollPaneRemoveAllWidgets(self.widget)
end

function clear(self)
	gui.ScrollPaneClear(self.widget)
end

function getWidgetCount(self)
	return gui.ScrollPaneGetWidgetCount(self.widget)
end

function getViewSize(self)
	local w, h = gui.ScrollPaneGetViewSize(self.widget)
	
	return w, h
end

-- если размеры одного из виджетов, 
-- добавленных в scroll pane были изменены,
-- то нужно вызвать эту функцию для обновления скроллбаров
function updateWidgetsBounds(self)
	return gui.ScrollPaneUpdateWidgetsBounds(self.widget)
end

function getHorzScrollRange(self)
	local minValue, maxValue = gui.ScrollPaneGetHorzScrollRange(self.widget)
	
	return minValue, maxValue
end

function setHorzScrollValue(self, value)
	gui.ScrollPaneSetHorzScrollValue(self.widget, value)
end

function getHorzScrollValue(self)
	return gui.ScrollPaneGetHorzScrollValue(self.widget)
end

function getVertScrollRange(self)
	local minValue, maxValue = gui.ScrollPaneGetVertScrollRange(self.widget)
	
	return minValue, maxValue
end

function setVertScrollValue(self, value)
	gui.ScrollPaneSetVertScrollValue(self.widget, value)
end

function getVertScrollValue(self)
	return gui.ScrollPaneGetVertScrollValue(self.widget)
end

function setVertScrollBarStep(self, step)
	gui.ScrollPaneSetVertScrollBarStep(self.widget, step)
end

function getVertScrollBarStep(self)
	return gui.ScrollPaneGetVertScrollBarStep(self.widget)
end

function setVertScrollBarPageStep(self, step)
	gui.ScrollPaneSetVertScrollBarPageStep(self.widget, step)
end

function getVertScrollBarPageStep(self)
	return gui.ScrollPaneGetVertScrollBarPageStep(self.widget)
end

function setHorzScrollBarStep(self, step)
	gui.ScrollPaneSetHorzScrollBarStep(self.widget, step)
end

function getHorzScrollBarStep(self)
	return gui.ScrollPaneGetHorzScrollBarStep(self.widget)
end

function setHorzScrollBarPageStep(self, step)
	gui.ScrollPaneSetHorzScrollBarPageStep(self.widget, step)
end

function getHorzScrollBarPageStep(self)
	return gui.ScrollPaneGetHorzScrollBarPageStep(self.widget)
end

function setVertMouseWheel(self, value)
	gui.ScrollPaneSetVertMouseWheel(self.widget, value)
end

function getVertMouseWheel(self)
	return gui.ScrollPaneGetVertMouseWheel(self.widget)
end

function setHorzMouseWheel(self, value)
	gui.ScrollPaneSetHorzMouseWheel(self.widget, value)
end

function getHorzMouseWheel(self)
	return gui.ScrollPaneGetHorzMouseWheel(self.widget)
end

function setLayout(self, layout)
	if layout then
		layout = layout.layout
	end
	
	gui.ScrollPaneSetLayout(self.widget, layout)
end

function getLayout(self)
	return LayoutFactory.bindLayout(gui.ScrollPaneGetLayout(self.widget))
end

function onScrollChange(self)
end