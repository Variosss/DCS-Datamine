--Static list with string wrapping for items

local base = _G

module('StaticList')
mtab = { __index = _M}

local require		= base.require
local Factory		= require('Factory')
local Static		= require("Static")
local Button		= require('Button')
local Panel			= require("Panel")
local DCS   		= require('DCS') 

function new(...)
  return Factory.create(_M, ...)
end

PopFrontItem = 0
PopBackItem = 1

function construct(self, text)
	self.container = Panel.new(text)
end

function setSkin(self, skin)
	self.skin = skin
	self.container:setSkin(self.skin.container)
	local itemCount = self:getItemCount()
	for i = 0, itemCount - 1 do
    	local item = self.container:getWidget(i)
		item:setSkin(self.skin.item)
	end
end

function getContainer(self)
	return self.container
end

function setBounds(self, x, y, w, h)
	self.container:setBounds(x, y, w, h)
end

function clear(self)
	self.container:clear()
end

function getItem(self, index)
	return self.container:getWidget(index - 1)
end

function getItemCount(self)
	return self.container:getWidgetCount()
end

local function setItemColor(item, color)
	local skin = item:getSkin()
	skin.skinData.states.released[1].text.color = color
	item:setSkin(skin)  
end

local function setItemText(self, item, index, text)
	local cw, ch = self.container:getSize()

	item:setText(text)
	item:setBounds(0, 0, cw, 0)

	local y = self:getItemsHeight(index and index - 1)
	local w, h = item:calcSize()
	item:setBounds(0, y, w, h)
	
	if index ~= nil then
		self:shiftItems(index + 1, y + h)
	end

	self:removeExtraItems()
end

function insertItem(self, index, text, color, cdPanel)    
	local item = Button.new()
	self.container:insertWidget(item, index and index - 1)
	
    item.index = index
	item:setSkin(self.skin.item)

	setItemText(self, item, index, text)
    
	if color ~= nil then
		setItemColor(item, color)
	end
    
    item.onChange = function(self) 
        if DCS.isTrackPlaying() == false then
            cdPanel.handler.selectMouseMenuItem(self.index)
        end
    end    
end

function deleteItem(self, index)
	local item = self:removeItem(index)
	if item ~= nil then
		item:destroy()
	end
end

function removeItem(self, index)
	local item = self.container:getWidget(index - 1)
	if item ~= nil then
		local x, y, w, h = item:getBounds()
		self.container:removeWidget(item)  

		self:shiftItems(index, y)
	end
	return item
end

function setItem(self, index, text, color)   
	local item = self.container:getWidget(index - 1)    
	if item == nil then
		self:insertItem(index, text, color)        
	else
        item.index = index
		setItemText(self, item, index, text)
		setItemColor(item, color)
	end
end

function removeExtraItems(self)
	local cx, cy, cw, ch = self.container:getBounds()
	local itemCount = self:getItemCount()
	
	if self.skin.popItem == PopFrontItem then
		local lastItem = self.container:getWidget(itemCount - 1)
		local x, y, w, h = lastItem:getBounds()
		local r = y + h - ch
		if r > 0 then
			local hSumm = 0
			while 	self:getItemCount() > 0 and
					hSumm < r do
				local item = self.container:getWidget(0)
				local x, y, w, h = item:getBounds()
				hSumm = hSumm + h
				self.container:removeWidget(item)
				item:destroy()
			end
			self:shiftItems(0, y)
		end
	elseif self.skin.popItem == PopBackItem then
		local lastIndex = itemCount - 1
		for i = lastIndex, 0, -1 do
			local item = self.container:getWidget(i)
			local x, y, w, h = item:getBounds()

			if y + h >= ch then
				self.container:removeWidget(item)
				item:destroy()
			else
				break
			end
		end
	end
end

function shiftItems(self, index, y0)
	local yp = y0
	local lastIndex = self:getItemCount() - 1       

	for i = index - 1, lastIndex do
		local item = self.container:getWidget(i)
		local x, y, w, h = item:getBounds()

		item:setBounds(x, yp, w, h)
		yp = yp + h
	end
end

function getItemsHeight(self, index)
	local result = 0

	index = base.math.min(self:getItemCount(), index or self:getItemCount())

	for i = 0, index - 1 do
		local item = self.container:getWidget(i)
		local w, h = item:getSize()
		
		result = result + h
	end

	return result
end