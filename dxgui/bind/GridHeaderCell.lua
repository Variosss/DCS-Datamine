local base = _G

module('GridHeaderCell')
mtab = { __index = _M}

local Factory		= base.require('Factory')
local Widget		= base.require('Widget'	)
local LayoutFactory	= base.require('LayoutFactory'	)
local gui			= base.require('dxgui'	)

Factory.setBaseClass(_M, Widget)

function new(text)
	return Factory.create(_M, text)
end

function invalidColumnIndex()
	return 1e6
end

function construct(self, text)
	Widget.construct(self, text)
	self:setZIndex(invalidColumnIndex())
end

function newWidget(self)
	return gui.NewGridHeaderCell()
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
	return gui.GridHeaderCellClone(self.widget)
end

function register(self, widgetPtr)
	Widget.register(self, widgetPtr)
	
	local count = self:getWidgetCount()
	
	for i = 1, count do
		local itemPtr = gui.GridHeaderCellGetWidget(self.widget, i - 1)
		local typeName = gui.WidgetGetTypeName(itemPtr)
		
		Factory.registerWidget(typeName, itemPtr)
	end
end

-- изменять размер колонки при помощи мыши
function setDraggable(self, draggable)
	gui.GridHeaderCellSetDraggable(self.widget, draggable)
end

function getDraggable(self)
	return gui.GridHeaderCellGetDraggable(self.widget)
end

function insertWidget(self, widget, index)
	gui.GridHeaderCellInsertWidget(self.widget, widget.widget, index)
end

function removeWidget(self, widget)
	gui.GridHeaderCellRemoveWidget(self.widget, widget.widget)
end

function removeAllWidgets(self)
	gui.GridHeaderCellRemoveAllWidgets(self.widget)
end

function clear(self)
	gui.GridHeaderCellClear(self.widget)
end

function getWidgetCount(self)
	return gui.GridHeaderCellGetWidgetCount(self.widget)
end

function getWidget(self, index)
	return widgets[gui.GridHeaderCellGetWidget(self.widget, index)]
end

function getWidgetIndex(self, widget)
	return gui.GridHeaderCellGetWidgetIndex(self.widget, widget.widget)
end

function setLayout(self, layout)
	if layout then
		layout = layout.layout
	end
	
	gui.GridHeaderCellSetLayout(self.widget, layout)
end

function getLayout(self)
	return LayoutFactory.bindLayout(gui.GridHeaderCellGetLayout(self.widget))
end