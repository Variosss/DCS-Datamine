-- маяк
local Unit				= require('Mission.Unit')
local ModuleProperty	= require('ModuleProperty')
local Factory			= require('Factory')

local M = {
	construct = function(self, x, y, angle, frequency, id)
		self:setAngle(angle)
		self:setFrequency(frequency)

		Unit.construct(self, x, y, id)
	end
}

ModuleProperty.makeClonable(M)

ModuleProperty.make1arg(M,	'setAngle',				'getAngle',				'angle')
ModuleProperty.make1arg(M,	'setFrequency',			'getFrequency',			'frequency')
ModuleProperty.make1arg(M,	'setChannel',			'getChannel',			'channel')
ModuleProperty.make1arg(M,	'setTextColor',			'getTextColor',			'textColor')
ModuleProperty.make1arg(M,	'setName',			    'getName',			    'name')
ModuleProperty.make1arg(M,	'setCallsign',			'getCallsign',			'callsign')


ModuleProperty.cloneBase(M, Unit)

return Factory.createClass(M, Unit)