module('FileDialogFilters', package.seeall)

local i18n = require('i18n')

i18n.setup(_M)

local all_				= {_('All files')			, '(*.*)'}
local sound_ 			= {_('Sound files')			, '(*.ogg;*.wav)'}
local image_ 			= {_('Images')				, '(*.jpg;*.jpeg;*.png)'}
local pngImage_			= {_('PNG Images')			, '(*.png)'}
local mission_			= {_('Mission files')		, '(*.miz)'}
local track_			= {_('Tracks')				, '(*.trk)'}
local script_			= {_('Scripts')				, '(*.lua)'}
local campaign_			= {_('Campaigns')			, '(*.cmp)'}
local debriefing_		= {_('Debriefing files')	, '(*.log)'}
local input_			= {_('Input profiles')		, '(*.diff.lua)'}
local listMissions_		= {_('Mission List')		, '(*.lst)'}
local aerobaticPreset_	= {_('Aerobatic maneuvers sequence preset'), '(*.amsp)'}
local rts_				= {_('RTS files')			, '(*.rts)'}
local dcm_				= {_('DCM files')			, '(*.dcm)'}
local dialogs_			= {_('Dialogs')				, '(*.dlg)'}
		
function all()
	return all_
end

function sound()
	return sound_
end

function image()
	return image_
end

function mission()
	return mission_
end

function listMissions()
	return listMissions_
end

function track()
	return track_
end
	
function script()
	return script_
end

function campaign()
	return campaign_
end

function debriefing()
	return debriefing_
end

function input()
	return input_
end

function aerobaticPreset()
	return aerobaticPreset_
end

function rts()
	return rts_
end

function dcm()
	return dcm_
end

function dialogs()
	return dialogs_
end	

function pngImage()
	return pngImage_
end	
