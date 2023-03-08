--Static menu with items

local base = _G

module('StaticMenu')
mtab = { __index = _M }

local Factory = base.require('Factory')
local StaticList = base.require("StaticList")

function new(...)
  return Factory.create(_M, ...)
end

function construct(self, text, x, y, w, h, size, skin, cdPanel)
	self.staticList = StaticList.new(text)
	self.staticList:setBounds(x, y, w, h)
	self.staticList:setSkin(skin)
	for i = 1, size do
		self.staticList:insertItem(nil,nil,nil,cdPanel)
	end
end

function setSkin(self, skin)
	self.staticList:setSkin(skin)
end

function clear(self)
	local size = self.staticList:getItemCount()
	for i = 1, size do
		self.staticList:setItem(i)
	end
end

function setItem(self, index, text, color)
	base.assert(index <= self.staticList:getItemCount())
	self.staticList:setItem(index, text, color)
end

function getItem(self, index)
	base.assert(index <= self.staticList:getItemCount())
	return self.staticList:getItem(index)
end

function setBounds(self, x, y, w, h)
	self.staticList:setBounds(x, y, w, h)
end

function getContainer(self)
	return self.staticList:getContainer()
end