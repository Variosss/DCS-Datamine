local Unit				= require('Mission.Unit')
local ModuleProperty	= require('ModuleProperty')
local Factory			= require('Factory')
local CoalitionData		= require('Mission.CoalitionData')

local M = {
	construct = function(self, x, y, airdromeNumber, name, class, frequencyList, angle, bounds, id, height, warehouses, fueldepots)
		self:setAirdromeNumber(airdromeNumber)
		self:setName(name)
		self:setClass(class)
		self:setAngle(angle)
		self:setBounds(bounds)
		self:setFrequencyList(frequencyList)
		self:setCoalitionName(CoalitionData.neutralCoalitionName())
        self:setHeight(height)
		self:setWarehouses(warehouses)
		self:setFueldepots(fueldepots)
		
		Unit.construct(self, x, y, id)
	end
}

ModuleProperty.makeClonable(M)

ModuleProperty.make1arg(M,	'setAirdromeNumber',	'getAirdromeNumber',	'airdromeNumber') -- id аэродрома в таблице данных
ModuleProperty.make1arg(M,	'setName',				'getName',				'name')
ModuleProperty.make1arg(M,	'setClass',				'getClass',				'class')
ModuleProperty.make1arg(M,	'setAngle',				'getAngle',				'angle')
ModuleProperty.make1arg(M,	'setBounds',			'getBounds',			'bounds')
ModuleProperty.make1arg(M,	'setCoalitionName',		'getCoalitionName',		'coalitionName')
ModuleProperty.make1arg(M,	'setRoadnet',			'getRoadnet',			'roadnet')
ModuleProperty.make1arg(M,	'setFrequencyList',		'getFrequencyList',		'frequencyList')
ModuleProperty.make1arg(M,	'setHeight',		    'getHeight',		    'height')
ModuleProperty.make1arg(M,	'setWarehouses',		'getWarehouses',		'warehouses')
ModuleProperty.make1arg(M,	'setFueldepots',		'getFueldepots',		'fueldepots')

ModuleProperty.cloneBase(M, Unit)

return Factory.createClass(M, Unit)