local Unit				= require('Mission.Unit')
local Factory			= require('Factory')
local ModuleProperty	= require('ModuleProperty')

local M = {
	construct = function(self, a_name, a_x, a_y, a_radius, a_id, a_properties, a_type, a_points)
		self:setName(a_name)
		self:setRadius(a_radius)
		self:setType(a_type or 0)  -- TYPE_CIRCLE=0  TYPE_RECTANGLE=1  TYPE_POLYGON=2 
		self:setHidden(false)
		self:setColor(1, 1, 1, 0.15)
		self:setProperties(a_properties)
		self:setPoints(a_points)
		self:setHeading(0)
		if a_type == 2 and (a_points == nil or a_points[1] == nil) then
			self:setPoints({{x = -3000, y = -3000},
							{x = -3000, y = 3000},
							{x = 3000, y = 3000},
							{x = 3000, y = -3000},
							})
		end
		Unit.construct(self, a_x, a_y, a_id)
	end
}
	
ModuleProperty.makeClonable(M)

ModuleProperty.make1arg(M,	'setName',		'getName',		'name')
ModuleProperty.make1arg(M,	'setRadius',	'getRadius',	'radius')
ModuleProperty.make1arg(M,	'setType',		'getType',		'type')
ModuleProperty.make1arg(M,	'setPoints',	'getPoints',	'points')
ModuleProperty.make1arg(M,	'setHidden',	'getHidden',	'hidden')
ModuleProperty.make1arg(M,	'setProperties','getProperties','properties')
ModuleProperty.make1arg(M,	'setLinkUnitId','getLinkUnitId',  'linkUnit')
ModuleProperty.make1arg(M,	'setLocalCoords','getLocalCoords',  'localCoords')
ModuleProperty.make1arg(M,	'setHeading',	'getHeading',  'heading')

ModuleProperty.make4arg(M,	'setColor',		'getColor',		'red', 'green', 'blue', 'alpha')

ModuleProperty.cloneBase(M, Unit)

return Factory.createClass(M, Unit)