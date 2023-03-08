local base = _G

module('me_editorManager')

local CoalitionData				= base.require('Mission.CoalitionData')
local DB 						= base.require('me_db_api')

local newGroupCountryName_ 	= nil
--local curCoalition_ = nil

function setNewGroupCountryName(a_country)
	newGroupCountryName_ = a_country
end

function getNewGroupCountryName()
	local coalition 
	if newGroupCountryName_ and DB.country_by_name[newGroupCountryName_] then
		coalition = CoalitionData.getCoalitionByContryId(DB.country_by_name[newGroupCountryName_].WorldID)
	end
	return newGroupCountryName_, coalition
end


--- setCountryName(a_country)
--- getCountry()