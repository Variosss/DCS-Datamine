local base = _G

module('AnchorLayout')
mtab = { __index = _M }

local require = base.require
local print = base.print
local ipairs = base.ipairs
local pairs = base.pairs
local table = base.table
local debug = base.debug

local Factory = require('Factory')
local Layout = require('Layout')
local Align = require('Align')
local gui = require('dxgui')

Factory.setBaseClass(_M, Layout)

function getType()
	return 'anchor'
end

function new(layoutPtr)
	return Factory.create(_M, layoutPtr)
end

function construct(self, layoutPtr)
	Layout.construct(self, layoutPtr)
end

function newLayout(self)
	return gui.NewAnchorLayout()
end

-- anchorInfo таблица вида {left = Align, top = Align, right = Align, bottom = Align}
function insertAnchorInfo(self, anchorInfo, index)
	gui.AnchorLayoutInsertAnchorInfo(self.layout, anchorInfo, index)
end

function removeAnchorInfo(self, index)
	return gui.AnchorLayoutRemoveAnchorInfo(self.layout, index)
end

function setAnchorInfo(self, anchorInfo, index)
	gui.AnchorLayoutSetAnchorInfo(self.layout, anchorInfo, index)
end

function getAnchorInfo(self, index)
	local anchorInfo = gui.AnchorLayoutGetAnchorInfo(self.layout, index)

	return anchorInfo
end

function getAnchorInfoCount(self)
	local count = gui.AnchorLayoutGetAnchorInfoCount(self.layout)
	
	return count
end

function load(self, data)
	local anchorInfos = data.anchorInfos
	local anchorInfoCount = self:getAnchorInfoCount()
	
	while data.count > anchorInfoCount do
		local anchorInfo = {left = Align.new(), top = Align.new(), right = Align.new(), bottom = Align.new()}
		
		self:insertAnchorInfo(anchorInfo)
		table.insert(anchorInfos, anchorInfo)
		anchorInfoCount = anchorInfoCount + 1		
	end
	
	while data.count < anchorInfoCount do
		anchorInfoCount = anchorInfoCount - 1
		self:removeAnchorInfo(anchorInfoCount)
		table.remove(anchorInfos)
	end

	for i, anchorInfo in ipairs(anchorInfos or {}) do
		self:setAnchorInfo(anchorInfo, i - 1)
	end
end

function unload(self)
	local anchorInfos = {}
	local count = self:getAnchorInfoCount()

	for i = 0, count - 1 do
		table.insert(anchorInfos, self:getAnchorInfo(i))
	end
	
	return {count = count, anchorInfos = anchorInfos}
end