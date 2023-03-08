
local base = _G

module('loadLiveries')

local i18n = base.require('i18n')
local log      = base.require('log')
local DCS    = base.require('DCS')
i18n.setup(_M)


-- заменяет "/" на "_"
function fixUnitType(typeName)
    local typeName = base.string.gsub(typeName, '/', '_');
    return typeName
end


function loadSchemes(livery_entry_point,countryShortName)
	local schemes = {}
	local fixed_unit   = fixUnitType(livery_entry_point)
	
	--[DCSCORE-5294: Allow all liveries to be availiable to Joint task force red and blue](https://jira.eagle.ru/browse/DCSCORE-5294)
	if countryShortName ~= nil and
	  (countryShortName == "BLUE" or 
	   countryShortName == "RED") then
	   
	   countryShortName = nil
    end
	


	local liveriesData = DCS.getObjectLiveriesNames(fixed_unit, countryShortName, base.string.lower(i18n.getLocale()))

	if liveriesData then
		for k,v in base.ipairs(liveriesData) do
			base.table.insert(schemes, {itemId = v[1], name = v[2]})  
		end 
	end
	 
	return schemes
end