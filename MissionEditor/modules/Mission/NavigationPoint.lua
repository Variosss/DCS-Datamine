local Unit				= require('Mission.Unit')
local ModuleProperty	= require('ModuleProperty')
local Factory			= require('Factory')
local U = require('me_utilities')

local M = {
	construct = function (self, name, coalitionName, x, y, id, a_type)
		self:setCoalitionName(coalitionName)
		self:setName(name)
		self:setDescription('')
		self:setType(a_type)		
		
		Unit.construct(self, x, y, id)	
	end
	
}

ModuleProperty.makeClonable(M)

ModuleProperty.make1arg(M,	'setCoalitionName',	'getCoalitionName',	'coalitionName')
ModuleProperty.make1arg(M,	'setName',			'getName',			'name')
ModuleProperty.make1arg(M,	'setCallsign',		'getCallsign',		'callsign')
ModuleProperty.make1arg(M,	'setDescription',	'getDescription',	'description')
ModuleProperty.make1argTbl(M,	'setScale',			'getScale',			'scale',		'properties')
ModuleProperty.make1argTbl(M,	'setSteer',			'getSteer',			'steer',		'properties')
ModuleProperty.make1argTbl(M,	'setVnav',			'getVnav',			'vnav',			'properties')
ModuleProperty.make1argTbl(M,	'setVangle',		'getVangle',		'vangle',		'properties')
ModuleProperty.make1argTbl(M,	'setAngle',			'getAngle',			'angle',		'properties')
ModuleProperty.make1arg(M,	'setPropertiesCustom',	'getPropertiesCustom',	'propertiesCustom')
ModuleProperty.make1arg(M,	'setType',			'getType',			'type')
ModuleProperty.make1argRef(M,	'setSnapTbl',			'getSnapTbl',	'linkChildrenSnap')

ModuleProperty.cloneBase(M, Unit)

return Factory.createClass(M, Unit)