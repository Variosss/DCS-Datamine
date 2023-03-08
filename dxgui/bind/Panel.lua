local base = _G

module('Panel')
mtab = { __index = _M}

local require			= base.require
local print				= base.print

local Factory			= require('Factory')
local Widget			= require('Widget')
local LayoutFactory		= require('LayoutFactory')
local gui				= require('dxgui')

Factory.setBaseClass(_M, Widget)

function new(text)
	return Factory.create(_M, text)
end

function construct(self, text)
	Widget.construct(self, text)
end

function newWidget(self)
	return gui.NewPanel()
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

function createClone(self)
	return gui.PanelClone(self.widget)
end

function register(self, widgetPtr)
	Widget.register(self, widgetPtr)
	
	local count = self:getWidgetCount()
	
	for i = 1, count do
		local itemPtr = gui.PanelGetWidget(self.widget, i - 1)
		local typeName = gui.WidgetGetTypeName(itemPtr)
		
		Factory.registerWidget(typeName, itemPtr)
	end
end

function insertWidget(self, widget, index)
	gui.PanelInsertWidget(self.widget, widget.widget, index)
end

function removeWidget(self, widget)
	gui.PanelRemoveWidget(self.widget, widget.widget)
end

function removeAllWidgets(self)
	gui.PanelRemoveAllWidgets(self.widget)
end

function clear(self)
	gui.PanelClear(self.widget)
end

function getWidgetCount(self)
	return gui.PanelGetWidgetCount(self.widget)
end

function getWidget(self, index)
	return widgets[gui.PanelGetWidget(self.widget, index)]
end

function getWidgetIndex(self, widget)
	return gui.PanelGetWidgetIndex(self.widget, widget.widget)
end

function setLayout(self, layout)
	if layout then
		layout = layout.layout
	end
	
	gui.PanelSetLayout(self.widget, layout)
end

function getLayout(self)
	return LayoutFactory.bindLayout(gui.PanelGetLayout(self.widget))
end
