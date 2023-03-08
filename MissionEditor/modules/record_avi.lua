local TrackRecordPanel		= require('TrackRecordPanel')
local Mission				= require('me_mission')
local OptionsController		= require('Options.Controller')
local MeSettings			= require('MeSettings')

local listener = {
	saveAviSettings = function(aviSettings)
		OptionsController.setGraphics('avi', aviSettings)
		OptionsController.saveChanges()
	end,
	
	saveMeSettings = function(meSettings)
		MeSettings.setRecordAviParams(meSettings)
	end,	
	
	playMission = function(trackname)
		TrackRecordPanel.show(false)
		
		local params = { file = trackname, command = "--avi" }
		
		Mission.mission.path = trackname
		Mission.play(params, 'record_avi', trackname, true)
	end,
	
	onTrackRecordPanelHide = function()
	end,
}

TrackRecordPanel.setListener(listener)

return {
	create	= TrackRecordPanel.create,
	show	= TrackRecordPanel.show,
	hide	= TrackRecordPanel.hide,
}