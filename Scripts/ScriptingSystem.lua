--Common initialization script for lua Environment

if console ~= nil then
	function print(...) --Console output
		console.out(...)
	end
end
	
--Classes
dofile('Scripts/Common/LuaClass.lua')

class(Object)
class(SceneryObject, 		Object)
class(StaticObject, 		Object)
class(Unit, 				Object)
class(Weapon, 				Object)
class(Airbase,				Object)
class(Group)
class(Controller)
class(Spot)

--Country identifiers
do
	dofile('Scripts/Database/db_countries.lua')
	local countries = country.names
	country.id = {}
	country.name = {}
	for id, name in pairs(countries) do
		country.id[name] = id
		country.name[id] = name
	end
end

do
	--trigger.actions wrappers
	function trigger.action.addOtherCommand(name, userFlagName, userFlagValue)
		missionCommands.addCommand(name, nil, function() trigger.action.setUserFlag(userFlagName, userFlagValue == nil and true or userFlagValue) end)
	end
	
	function trigger.action.removeOtherCommand(name)
		missionCommands.removeItem({name})
	end
	
	function trigger.action.addOtherCommandForCoalition(coalition, name, userFlagName, userFlagValue)
		missionCommands.addCommandForCoalition(coalition, name, nil, function() trigger.action.setUserFlag(userFlagName, userFlagValue == nil and true or userFlagValue) end)
	end
	
	function trigger.action.removeOtherCommandForCoalition(coalition, name)
		missionCommands.removeItemForCoalition(coalition, {name})
	end
	
	function trigger.action.addOtherCommandForGroup(groupId, name, userFlagName, userFlagValue)
		missionCommands.addCommandForGroup(groupId, name, nil, function() trigger.action.setUserFlag(userFlagName, userFlagValue == nil and true or userFlagValue) end)
	end
	
	function trigger.action.removeOtherCommandForGroup(groupId, name)
		missionCommands.removeItemForGroup(groupId, {name})
	end
	
	function trigger.action.activateGroup(group)
		group:activate()
	end
	
	function trigger.action.deactivateGroup(group)
		group:destroy()
	end
	
	function trigger.action.setGroupAIOn(group)
		group:getController():setOnOff(true)
	end

	function trigger.action.setGroupAIOff(group)
		group:getController():setOnOff(false)
	end
	
	function trigger.action.groupStopMoving(group)
		local command = {
			id = 'StopRoute',
			params = {
				value = true
			}
		}
		group:getController():setCommand(command)
	end
	
	function trigger.action.groupContinueMoving(group)
		local command = {
			id = 'StopRoute',
			params = {
				value = false
			}
		}
		group:getController():setCommand(command)
	end
	
	--Object
	
	function Object.hasAttribute(self, attribute)
		if self:getDesc().attributes and self:getDesc().attributes[attribute] == true then
			return true
		end
		return false
	end	
	
	function Object.getAttributes(self)
		return self:getDesc().attributes
	end	

	--Unit
	
	function Unit.getLife0(self)
		return self:getDesc().life
	end	
end

dofile('Scripts/World/EventHandlers.lua')