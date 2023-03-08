--Provides mechanism like C++ classes and objects

--Lua-class metatable
local LuaClass = {
	--Provides access to functions in parent class
	__index = function(class, funcName)
		local parentClass = rawget(class, 'parentClass_')
		if parentClass ~= nil then
			return parentClass[funcName]
		else
			error('Function '..funcName..' not found')
		end
	end,
	--[[
	__newindex = function(t, k, v)
		error('Modification of Lua-objects is not allowed!')
	end
	--]]
}

--Lua-object class.
local LuaObject = {
	--Compares (equal) two objects by id
	__eq = function(object1, object2)
		if object1 and object2 then
			return object1.id_ == object2.id_
		else
			return false
		end
	end,
	--Compares (less or equal) two objects by id
	__le = function(object1, object2)
		if object1 and object2 then
			return object1.id_ <= object2.id_
		else
			return false
		end
	end,
	--Compares (less than) two objects by id
	__lt = function(object1, object2)
		if object1 and object2 then
			return object1.id_ < object2.id_
		else
			return false
		end
	end,
	--Converts object to number by id
	__tonumber = function(object)
		return object.id_
	end,
	--Converts object to number by id
	tonumber = function(object)
		return object.id_
	end,
}

--Dumy base class for all classes
local voidClass = {
	className_ = 'void',
	parentClass = nil
}

local function objectModificationHandler()
	error('Modification of Lua-objects is not allowed!')
end

--Declares tbl as class with parent (multiple inheritance not allowed)
function class(tbl, parent)
	parent = parent or voidClass
	tbl.className_ = tbl.className_ or 'unknown ('..tostring(tbl)..')'
	tbl.__index = tbl
	tbl.__newindex = objectModificationHandler
	tbl.__eq = LuaObject.__eq
	tbl.__le = LuaObject.__le
	tbl.__lt = LuaObject.__lt
	tbl.__tonumber = LuaObject.__tonumber
	tbl.tonumber = LuaObject.tonumber
	assert(tbl ~= parent)
	tbl.parentClass_ = parent --parent class	
	setmetatable(tbl, LuaClass) --function searcher
end