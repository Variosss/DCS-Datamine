local base = _G

module('TabGroupItem')
mtab = { __index = _M }

local Factory = base.require('Factory')
local Widget = base.require('Widget')
local gui = base.require('dxgui')

Factory.setBaseClass(_M, Widget)

function new(text)
	return Factory.create(_M, text)
end

function construct(self, text)
	Widget.construct(self, text)
	
	self:addShowCallback(function()
		self:onShow()
	end)	
	
	self:addHideCallback(function()
		self:onHide()
	end)
end

function newWidget()
	return gui.NewTabGroupItem()
end

function clone(self)
	return Factory.clone(_M, self)
end

function createClone(self)
	return gui.TabGroupItemClone(self.widget)
end

function setState(self, state)
	gui.TabGroupItemSetState(self.widget, state)
end

function getState(self)
	return gui.TabGroupItemGetState(self.widget)
end

function addShowCallback(self, callback)
	self:addCallback('tab group item show', callback)
end

function addHideCallback(self, callback)
	self:addCallback('tab group item hide', callback)
end

function onShow(self)
end

function onHide(self)
end