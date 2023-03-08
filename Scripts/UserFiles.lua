--TODO это временное решение для редактируемых пользовательских файлов
--в ожидании VFS
--если нет VFS, то лучше поместить userfiles в edCore

local lfs = require('lfs')
local writedir = lfs.writedir()

userMissionPath			= writedir .. 'Missions\\'
userTrackPath			= writedir .. 'Tracks\\'
userCampaignPath		= writedir .. 'Missions\\Campaigns\\'
userMoviePath			= writedir .. 'Movies\\'
userMgPath				= writedir .. 'MG\\'
userOptionsPresetsPath	= writedir .. 'Config\\OptionsPresets\\'

local function findUserLocation()	
	local locations = lfs.locations()
	
	if locations then
		for i, location in ipairs(locations) do		
			if location.path == userMissionPath then
				return true
			end
		end
	end
	
	return false
end

function initLocations()
	function _(str) return str end
	lfs.add_location(_('My Missions'), userMissionPath)
end

if not __EMBEDDED__ and findUserLocation() == false then
    initLocations()
end
