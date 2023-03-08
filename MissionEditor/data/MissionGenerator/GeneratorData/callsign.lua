
--dofile(db_path.."db_attributes.lua");

  country_names = {}
  country_by_name = {}
  country_by_id = {}
  country_by_OldID = {}
  country_category_units = {}
  for i,v in pairs(db.Countries) do
    country_by_name[v.Name] = v
    country_by_id[v.WorldID] = v
	country_by_OldID[v.OldID] = v
    table.insert(country_names, v.Name)
  end
  

-----------------------------------------------------------------------------------------
-- Read DB
-----------------------------------------------------------------------------------------
local categories = {
	'AWACS',
	'Tankers',
	'Air',
	'Helipad',
	'Ground Units',
    'GrassAirfield',
	'Aircraft Carriers',
}

 local function getCallnames(countryId, category)
	local callnames = db.Callnames[countryId] and db.Callnames[countryId][category]
	if callnames == nil then
		local countryAsDefault = db.DefaultCountry[countryId] or country.USA
		if countryAsDefault ~= nil then
			callnames = db.Callnames[countryAsDefault] and db.Callnames[countryAsDefault][category]				
		end
	end
	return callnames
end


local function getUnitCallnames(countryId, unitAttributes)
	for categoryIndex, category in pairs(categories) do
		if findAttribute(unitAttributes, category) then	
			return getCallnames(countryId, category)
		end
	end
end
-----------------------------------------------------------------------------------------

local squadrons = {}
local freeCallsigns = {}
local function getFreeCalsign(country, unitType)
	if freeCallsigns[country] == nil then freeCallsigns[country] = {} end
	if freeCallsigns[country][unitType] == nil or #freeCallsigns[country][unitType] == 0 then
		if unit_by_type[unitType] ~= nil then
			local allCallsigns = getUnitCallnames(country_by_OldID[country].WorldID, unit_by_type[unitType].attribute)
			local callsignsData = {}
			for i, v in ipairs(allCallsigns) do
				table.insert(callsignsData, {index = i, name = v.Name})
			end
			if #callsignsData == 0 then print('callsing:: no callsigns for '..country..', '..unitType) return 0, "" end

			freeCallsigns[country][unitType] = callsignsData
		else
			print("unit_by_type("..unitType..") not found!!!")
		end
	end

	local callsigns = freeCallsigns[country][unitType]
	local callsign = table.remove(callsigns, math.random(#callsigns))
	return callsign.index, callsign.name
end

local function getSquadron(country, unitType)
	if squadrons[country] == nil then squadrons[country] = {} end
	if squadrons[country][unitType] == nil then
		local squadron =
		{
			callsignIndex = 0,
			callsign = "",
			groups = {},
			lastGroupIndex = 0,
		}
		squadron.callsignIndex, squadron.callsign = getFreeCalsign(country, unitType)

		squadrons[country][unitType] = squadron
	end
	return squadrons[country][unitType]
end

function getYearsAircraft(type,country)
	--local startDate, endDate = getYearsLocal(type,country)
	return getYearsLocal(type,country)
end

function getTypeCallsign(country)
    for k,v in pairs(db.callnamesRussia) do
        if v == country then
            return 1 --red
        end
    end
    return 2 --blue
end

function getCallsign(country, unitType, groupId)
	local squadron = getSquadron(country, unitType)
	if squadron.groups[groupId] == nil then
		squadron.lastGroupIndex = squadron.lastGroupIndex + 1
		squadron.groups[groupId] = {unitIndex = 0, groupIndex = squadron.lastGroupIndex}
	end

	local groupData = squadron.groups[groupId]
	groupData.unitIndex = groupData.unitIndex + 1

	return squadron.callsign..groupData.groupIndex..groupData.unitIndex, squadron.callsignIndex, groupData.groupIndex, groupData.unitIndex
end


local availableJTACCallsigns = {}
local jtacFrequency = 29000000
function getJTACCallsign()
	if #availableJTACCallsigns == 0 then
		local callsigns = getCallnames(country.USA, 'Ground Units')
		for i, v in ipairs(callsigns) do
			table.insert(availableJTACCallsigns, {i, v.Name})
		end
	end
	
	if #availableJTACCallsigns == 0 then return 0, '', 0 end
	local callsignData = table.remove(availableJTACCallsigns, math.random(#availableJTACCallsigns))
	jtacFrequency = jtacFrequency + 1000000

	return callsignData[1], callsignData[2], jtacFrequency
end
