local ModuleProperty	= require('ModuleProperty')

local idCounter_ = 0

local M = {}

M.construct = function (self, x, y, id)
	self:setId(id)
	self:setPosition(x, y)
end

M.resetIdCounter = function()
	idCounter_ = 0
end	

ModuleProperty.makeClonable(M)

ModuleProperty.make1arg(M,	'setId',		'getId',		'id')
ModuleProperty.make2arg(M,	'setPosition',	'getPosition',	'x',	'y')

M.setId = function(self, id)
	if id then
		self.id	= id
		idCounter_	= math.max(id, idCounter_)
	else
		idCounter_	= idCounter_ + 1
		self.id		= idCounter_
	end
end

return Factory.createClass(M)