local base = _G

module('ModalWindow')
mtab = { __index = _M }

local Factory = base.require('Factory')
local Window = base.require('Window')
local gui = base.require('dxgui')

Factory.setBaseClass(_M, Window)

function new(x, y, w, h, text)
	return Factory.create(_M, x, y, w, h, text) 
end

function construct(self, x, y, w, h, text)
	Window.construct(self, x, y, w, h, text)
end

function newWidget(self)
	return gui.NewModalWindow()
end

function clone(self)
	local result = Factory.clone(_M, self)

	self:copyWidgetNames(result)
	
	return result
end

function createClone(self)
	return gui.ModalWindowClone(self.widget)
end

-- прерывать поток управления при вызове setVisible(true)
-- если true, то управление вернется в приложение после того, как окно будет закрыто
-- иначе выполнение приложения продолжается после вызова setVisible(true)
-- однако события от мыши и клавиатуры обрабатывает только верхнее модальное окно
function setLockFlow(self, lockFlow)
	gui.ModalWindowSetLockFlow(self.widget, lockFlow)
end

function getLockFlow(self, lockFlow)
	return gui.ModalWindowGetLockFlow(self.widget)
end

function setZOrder(self, zOrder)
end

function getZOrder(self)
end
