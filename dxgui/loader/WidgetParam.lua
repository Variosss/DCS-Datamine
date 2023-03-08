local Factory = require('Factory')

local minNumberValue_ = -1e12
local maxNumberValue_ = 1e12

function new(name)
  return Factory.create(_M, name)
end

local function construct(self, name)
	self.name = name
	self.set = nil
	self.get = nil
	self.parse = nil
	self.hint = nil
	self.skipsave = nil
end

local function setFuncName(self, setFuncName)
	self.set = setFuncName
	return self
end

local function getFuncName(self, getFuncName)
	self.get = getFuncName
	return self
end

local function parseFunc(self, parseFunc)
	self.parse = parseFunc
	return self
end

local function hintText(self, hintText)
	self.hint = hintText
	return self
end

local function skipSave(self)
	self.skipsave = true
	return self
end

local function fieldsFunc(self, func)
	self.func = func
	return self
end

local function fieldName(self, name)
	self.fieldName_ = name
	return self
end

local function needUpdate(self)
	self.update = true
	return self
end

local function setTableFunc(self, func)
	self.setFunc = func
	return self
end

local function getTableFunc(self, func)
	self.getFunc = func
	return self
end

local function boolType(self)
	self.type = 'bool'
	return self
end

local function textType(self)
	self.type = 'text'
	return self
end

local function numberType(self, min, max)
	self.type = 'number'
	self.min = min or minNumberValue_
	self.max = max or maxNumberValue_
	return self
end

local function horzAlignType(self)
	self.type = 'horzAlign'
	return self
end

local function vertAlignType(self)
	self.type = 'vertAlign'
	return self
end

local function layoutType(self)
	self.type = 'layout'
	return self
end

return Factory.createClass({
	construct			= construct			,
	setFuncName			= setFuncName		,
	getFuncName			= getFuncName		,
	parseFunc			= parseFunc			,
	hintText			= hintText			,
	skipSave			= skipSave			,
	fieldsFunc			= fieldsFunc		,
	fieldName			= fieldName			,
	needUpdate			= needUpdate		,
	setTableFunc		= setTableFunc		,
	getTableFunc		= getTableFunc		,
	boolType			= boolType			,
	textType			= textType			,
	numberType			= numberType		,
	horzAlignType		= horzAlignType		,
	vertAlignType		= vertAlignType		,
	layoutType			= layoutType		,
})