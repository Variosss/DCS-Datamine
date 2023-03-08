local base = _G

module('Layout')
mtab = { __index = _M }

local Factory = base.require('Factory')
local gui = base.require('dxgui')

function new()
	base.error('Layout is abstract class for layouts and cannot be created immediately!')
end

layouts = {} -- таблица соответсвия между объектами Lua и С

function construct(self, layoutPtr)
	self.layout = layoutPtr or self:newLayout()
	layouts[self.layout] = self
end

function destroy(self)
	layouts[self.layout] = nil
	self.layout = nil
end

function getType()
	base.error('Layout is abstract class! Inherited classes must override this function!')
end

function load(self, data)
	base.error('Layout is abstract class! Inherited classes must override this function!')
end

function unload(self)
	base.error('Layout is abstract class! Inherited classes must override this function!')
end

function updateSize(self)
	gui.LayoutUpdateSize(self.layout)
end

function getPrefSize(self)
	local width, height = gui.LayoutGetPrefSize(self.layout)
	
	return width, height
end