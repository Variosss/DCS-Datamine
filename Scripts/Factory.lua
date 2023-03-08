module('Factory', package.seeall)

function setBaseClass(class, baseClass)
	assert(baseClass.mtab)
	setmetatable(class, baseClass.mtab)
end

function create(class, ...)
	local w = {}

	setBaseClass(w, class)
	w:construct(unpack({...}))

	return w
end

function registerWidget(widgetTypeName, widgetPtr)
	local class = require(widgetTypeName)
	
	if class then
		if not class.widgets[widgetPtr] then
			local w = {}
			
			setBaseClass(w, class)
			w:register(widgetPtr) -- контейнеры в этой функции должны зарегистировать в Lua вложенные виджеты
			
			return w
		end
	else
		print('Unable to register widget having type name:', widgetTypeName)
	end
end

function clone(class, widget)
	return registerWidget(widget:getTypeName(), widget:createClone())
end

function createClass(class, baseModule)
	if baseModule then
		setmetatable(class, {__index = baseModule})
	end
	
	class.new = function(...)
		local newObject = {}
		setmetatable(newObject, {__index = class})
		
		newObject:construct(...)
		
		return newObject		
	end
	
	return class
end
