--Контрол 

local base = _G

module('imagePreview')
mtab = { __index = _M }

local require = base.require
local pairs = base.pairs
local type = base.type
local table = base.table

local Factory           = require('Factory')
local Static            = require('Static')
local Skin              = require('Skin')
local U                 = require('me_utilities')
local textutil          = require('textutil')
local UpdateManager	    = require('UpdateManager')
local SkinUtils 		= require('SkinUtils')


-------------------------------------------------------------------------------
--
function new(a_sImage, a_sbHorz, a_sbVert)
  return Factory.create(_M, a_sImage, a_sbHorz, a_sbVert)
end

-------------------------------------------------------------------------------
--
function construct(self, a_sImage, a_sbHorz, a_sbVert)
    self.sImage = a_sImage
	self.sbHorz = a_sbHorz
	self.sbVert = a_sbVert
    self.startDrag = false
    self.lastX = -1
    self.lastY = -1
    self.X = 0 
    self.Y = 0
    self.sImage.parent = self 
	self.sbHorz.parent = self 
	self.sbVert.parent = self 
    self.minY = 0
    self.maxY = 0
    self.minX = 0
    self.maxX = 0  
	self.pictureWidgetSkin = a_sImage:getSkin()
	self.testStatic = Static.new()
	self.scale = 1
	self.origW = 0
	self.origH = 0
	self.minScale = 1
	self.maxScale = 1
	self.PointScaleX = 0
	self.PointScaleY = 0
	self.scaleLast = 1
	self.filename = nil
	
	self.posX, self.posY = a_sImage:getPosition()
	
	self.sbHorz:addChangeCallback(function()
		self.sbHorz.parent.X = self.sbHorz:getValue() * self.scale
		self.PointScaleX = 0
		self.PointScaleY = 0
		update(self.sbHorz.parent) 
	end)
	
	self.sbVert:addChangeCallback(function()
		self.sbVert.parent.Y = self.sbVert:getValue() * self.scale
		self.PointScaleX = 0
		self.PointScaleY = 0
		update(self.sbVert.parent) 
	end)

    self.sImage:addMouseDownCallback(function(self, x, y, button)
        if button == 1 then
            self.parent.startDrag = true
            self.parent.lastX = x
            self.parent.lastY = y
        end
    end)

    self.sImage:addMouseUpCallback(function(self, x, y, button)
        if button == 1 then
            self.parent.startDrag = false
            self.parent.lastX = -1
            self.parent.lastY = -1
        end
    end)
    
    self.sImage:addMouseLeaveCallback(function(self, x, y, button)
        self.parent.startDrag = false
        self.parent.lastX = -1
        self.parent.lastY = -1
    end)

    self.sImage:addMouseMoveCallback(function(self, x, y)
		if self.parent.startDrag == true then
            local parent = self.parent
            local dx = (x - parent.lastX)
            local dy = (y - parent.lastY)
            
            moveImage(self.parent, dx, dy)
			--base.print("---addMouseMoveCallback---:", x, y)
			self.parent.lastX = x 
			self.parent.lastY = y 
			self.parent.PointScaleX = 0
			self.parent.PointScaleY = 0
			update(self.parent) 
        end
	end)
	
	self.sImage:addMouseWheelCallback(function(self, x, y, button)
		--base.print("---addMouseWheelCallback---:",button,self.scale, x, y)
		self.parent.PointScaleX = x - self.parent.posX 
		self.parent.PointScaleY = y	- self.parent.posY	 
		self.parent.scale = self.parent.scale - button/20
		update(self.parent)  
	end)
	
end

function moveImage(self, dx, dy)
	self.X = self.X - dx * self.scale
    self.Y = self.Y - dy * self.scale	

--base.print("----1111-",self.origW, self.scale, self.origW / self.scale)	
	                    
end

function setPicture(self, filename)
	self.filename = filename
	self.sImage:setSkin(SkinUtils.setStaticPicture(filename, self.pictureWidgetSkin))
	self.testStatic:setSkin(SkinUtils.setStaticPicture(filename, self.testStatic:getSkin()))

	self.origW, self.origH = self.testStatic:calcSize()
	local scaleX = self.origW / 512
	local scaleY = self.origH / 512
	--base.print("---origW----",self.origW, self.origH,scaleX,scaleY)
	if scaleX < scaleY then
		self.maxScale = scaleY
	else
		self.maxScale = scaleX
	end
	if self.maxScale < 1 then
		self.maxScale = 1
	end
	self.minScale = 1
	
	self.lastX = -1
    self.lastY = -1
    self.X = 0 
    self.Y = 0
	self.PointScaleX = 0
	self.PointScaleY = 0
	self.scale = self.maxScale
	
	self.maxX = self.origW - 512  
	self.maxY = self.origH - 512
    
	
	update(self)    
end
	
function update(self)

	if self.scale < self.minScale then
		self.scale = self.minScale
		self.PointScaleX = 0
		self.PointScaleY = 0
	end
	
	if self.scale > self.maxScale then
		self.scale = self.maxScale
		self.PointScaleX = 0
		self.PointScaleY = 0
	end
		
	self.origW, self.origH = self.testStatic:calcSize()
--base.print("---self.scale---",self.scale, self.minScale, self.maxScale)
	if 	self.origW < self.origH then
		origSize = self.origW
	else
		origSize = self.origH
	end	
--[[
	self.sImage:setSize(self.origSize/(self.maxScale + (1 - self.scale)), self.origSize/(self.maxScale + (1 - self.scale))) 
	self.sImage:setSkin(SkinUtils.setStaticPictureSize(self.origW/(self.maxScale + (1 - self.scale)), self.origH/(self.maxScale + (1 - self.scale)), self.sImage:getSkin()))
	]]
--	base.print("---cccx-",self.scale, self.origW / self.scale, self.origH / self.scale)
	local imgSizeX = 512
	local imgSizeY = 512
	
	if self.origW / self.scale < 512 then
		imgSizeX = self.origW / self.scale
	end
	
	if self.origH / self.scale < 512 then
		imgSizeY = self.origH / self.scale
	end
	
	if self.PointScaleX ~= 0 or self.PointScaleY ~= 0 then	
		local offsetX = (self.PointScaleX-256)/2
		local offsetY = (self.PointScaleY-256)/2
		
--		base.print("---offsetX, offsetY--",offsetX, offsetY)
		moveImage(self, -offsetX, -offsetY)
	end
	
	if self.X > (self.origW  - 512 * self.scale) then
		self.X = self.origW  - 512 * self.scale 
	end
	
	if self.Y > (self.origH - 512 * self.scale ) then
		self.Y = self.origH - 512 * self.scale  
	end
	
	if self.Y < self.minY then
		self.Y = self.minY
	end
	
	if self.X < self.minX then
		self.X = self.minX
	end
	
	self.sImage:setSize(imgSizeX, imgSizeY)
	self.sImage:setSkin(SkinUtils.setStaticPictureRect(self.filename, self.X, self.Y, self.X + imgSizeX * self.scale, self.Y + imgSizeY * self.scale, self.sImage:getSkin()))

--base.print("---wwww--",self.origW / self.scale - 512, self.X / self.scale)
--base.print("---wwww2--",self.X / self.scale, self.Y / self.scale)
	if self.origW / self.scale - 512 > 0 then
		--base.print("---setRange--",self.origW / self.scale - 512)
		self.sbHorz:setRange(0, self.origW / self.scale)
		local f1, f2 = self.sbHorz:getRange()
		--base.print("---setRange-2-", f1, f2)
		self.sbHorz:setValue(self.X / self.scale)
		self.sbHorz:setThumbValue(512)
		self.sbHorz:setVisible(true)
	else
		self.sbHorz:setRange(0, 0)
		self.sbHorz:setVisible(false)
	end	
	
	if self.origH / self.scale - 512 > 0 then
		self.sbVert:setRange(0, self.origH / self.scale)
		self.sbVert:setValue(self.Y / self.scale)
		self.sbVert:setThumbValue(512)
		self.sbVert:setVisible(true)
	else
		self.sbVert:setRange(0, 0)
		self.sbVert:setVisible(false)
	end	
	

end