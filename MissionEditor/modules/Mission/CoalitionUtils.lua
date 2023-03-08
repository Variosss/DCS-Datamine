local base = _G

local require = base.require
local pairs = base.pairs
local ipairs = base.ipairs
local print = base.print
local table = base.table
local string = base.string
local tonumber = base.tonumber
local tostring = base.tostring
local assert = base.assert
local math = base.math

local ListBoxItem	= require('ListBoxItem')
local i18n			= require('i18n')

local _ = i18n.ptranslate

local controller_
local coalitionNameListerData_
local coalitionIdListerData_
local offlineCoalitionName_	= 'offline'

local function setController(controller)
	controller_ = controller
end

local function fillComboListCoalition(comboList, coalitionNames, func)
	comboList:clear()
	
	for i, coalitionName in ipairs(coalitionNames) do
		local item = ListBoxItem.new(controller_.getLocalizedCoalitionName(coalitionName))
		
		item.coalitionName = coalitionName
		
		comboList:insertItem(item)
		
		if 1 == i then
			comboList:selectItem(item)
		end
	end
	
	function comboList:onChange(item)
		func(item.coalitionName)
	end
end

local function getComboListCoalition(comboList, emptyValue)
	local item = comboList:getSelectedItem()
	
	if item then
		return item.coalitionName
	end
	
	return emptyValue
end

local function setComboListCoalition(comboList, coalitionName)
	for i = 0, comboList:getItemCount() - 1 do
		local item = comboList:getItem(i)
		
		if item.coalitionName == coalitionName then
			comboList:selectItem(item)
			
			break
		end
	end
end

local function getCoalitionNameListerData()
	if not coalitionNameListerData_ then
		local redCoalitionName		= controller_.redCoalitionName()
		local blueCoalitionName		= controller_.blueCoalitionName()
		local neutralCoalitionName	= controller_.neutralCoalitionName()
		local getLocalizedCoalitionName = controller_.getLocalizedCoalitionName
		
		coalitionNameListerData_ = {
			[redCoalitionName]		= getLocalizedCoalitionName(redCoalitionName),
			[blueCoalitionName] 	= getLocalizedCoalitionName(blueCoalitionName),
			[neutralCoalitionName] 	= getLocalizedCoalitionName(neutralCoalitionName),
			[offlineCoalitionName_]	= _("OFFLINE"),
		}
	end
	
	return coalitionNameListerData_
end

local function createListerNameValue(coalitionName, localizedName)
	return {id = coalitionName, name = localizedName or getCoalitionNameListerData()[coalitionName]}
end

local function listerNameRedBlue()	
	local result = { 
		createListerNameValue(controller_.redCoalitionName()),
		createListerNameValue(controller_.blueCoalitionName()),
		createListerNameValue(controller_.neutralCoalitionName()),
	}
	
    return result
end

local function listerNameRedBlueOffline()
	local result = { 
		createListerNameValue(controller_.redCoalitionName()),
		createListerNameValue(controller_.blueCoalitionName()),
		createListerNameValue(offlineCoalitionName_),
		createListerNameValue(controller_.neutralCoalitionName()),
	}

    return result
end

local function coalitionNameToLocalizedName(coalitionName, unknownValue)
	if '' == coalitionName then
		return ''
	end
	
	local localizedName = getCoalitionNameListerData()[coalitionName]
	
	if localizedName then
		return localizedName
	else
		return unknownValue
	end
end

local neutralId_	= 0
local redId_		= 1
local blueId_		= 2

local function getCoalitionIdListerData()
	if not coalitionIdListerData_ then
		local getLocalizedCoalitionName = controller_.getLocalizedCoalitionName
		
		coalitionIdListerData_ = {
			[neutralId_]	= getLocalizedCoalitionName(controller_.neutralCoalitionName()),
			[redId_]		= getLocalizedCoalitionName(controller_.redCoalitionName()),
			[blueId_]		= getLocalizedCoalitionName(controller_.blueCoalitionName()),
		}
	end
	
	return coalitionIdListerData_
end

local function createListerIdValue(id)
	return {id = id, name = getCoalitionIdListerData()[id]}
end

local function listerNeutralRedBlueId()
	local result = { 
		createListerIdValue(redId_),
		createListerIdValue(blueId_),
		createListerIdValue(neutralId_),
	}
	
	return result
end

local function coalitionIdToLocalizedName(coalitionId, unknownValue)
	if '' == coalitionId then
		return ''
	end
	
	local localizedName = getCoalitionIdListerData()[coalitionId]
	
	if localizedName then
		return localizedName
	else	
		return unknownValue
	end
end

local function getLocalizedCoalitionName(a_name)
	return controller_.getLocalizedCoalitionName(a_name)
end

return {
	setController				= setController,
		
	fillComboListCoalition		= fillComboListCoalition,
	getComboListCoalition		= getComboListCoalition,
	setComboListCoalition		= setComboListCoalition,
		
	createListerNameValue		= createListerNameValue,
	listerNameRedBlue			= listerNameRedBlue,
	listerNameRedBlueOffline	= listerNameRedBlueOffline,
	coalitionNameToLocalizedName	= coalitionNameToLocalizedName,
	
	listerNeutralRedBlueId		= listerNeutralRedBlueId,
	coalitionIdToLocalizedName	= coalitionIdToLocalizedName,
	getLocalizedCoalitionName	= getLocalizedCoalitionName,
}