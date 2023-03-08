local OptionsData	= require('Options.Data')

local view_
local forcedView_

local function setView(view)
	view_ = view
end

local function setForcedView(view)
	forcedView_ = view
end

-- нотификация от OptionsData
local function difficultyChanged(name)
	if view_ then
		view_.updateDifficulty(name)
	end	
end

-- нотификация от OptionsData
local function graphicsChanged(name)
	if view_ then
		view_.updateGraphics(name)
	end	
end

local function updateRelationsGraphics()
	if view_ then
		view_.updateRelationsGraphics()
	end	
end

-- нотификация от OptionsData
local function viewsCockpitChanged(name)
	if view_ then
		view_.updateViewsCockpit(name)
	end	
end

-- нотификация от OptionsData
local function soundChanged(name)
	if view_ then
		view_.updateSound(name)
	end	
end

-- нотификация от OptionsData
local function miscellaneousChanged(name)
	if view_ then
		view_.updateMiscellaneous(name)
	end	
end

-- нотификация от OptionsData
local function VRChanged(name)
	if view_ then
		view_.updateVR(name)
	end	
end

-- нотификация от OptionsData
local function pluginChanged(pluginId, name)
	if view_ then
		view_.updatePlugin(pluginId, name)
	end	
end

local function optionsSaved()
	if view_ then
		view_:onOptionsSaved()
	end
end

local function optionsRestored()
	if view_ then
		view_:onOptionsRestored()
	end
end

local function forcedChanged(name)
	if forcedView_ then
		forcedView_.forcedChanged(name)
	end
end

local function onMissionOptionsViewShow()
end

local function onMissionOptionsViewHide()
end

return {
	setView						= setView,
	setForcedView				= setForcedView,
	
	load						= OptionsData.load,
	saveChanges					= OptionsData.saveChanges,
	undoChanges					= OptionsData.undoChanges,
	
	optionsSaved				= optionsSaved,
	optionsRestored				= optionsRestored,
	
	getDifficulty				= OptionsData.getDifficulty,
	setDifficulty				= OptionsData.setDifficulty,
	getDifficultyValues			= OptionsData.getDifficultyValues,
	getDifficultyChanged		= OptionsData.getDifficultyChanged,
	getDifficultyDb				= OptionsData.getDifficultyDb,
	difficultyChanged			= difficultyChanged,
	setDifficultyLow			= OptionsData.setDifficultyLow,
	setDifficultyMedium			= OptionsData.setDifficultyMedium,
	setDifficultyHigh			= OptionsData.setDifficultyHigh,
	
	getGraphics					= OptionsData.getGraphics,
	setGraphics					= OptionsData.setGraphics,
	getGraphicsValues			= OptionsData.getGraphicsValues,
	getGraphicsChanged			= OptionsData.getGraphicsChanged,
	getGraphicsDb				= OptionsData.getGraphicsDb,
	relationsGraphics			= OptionsData.relationsGraphics,
	getEnabledGraphics			= OptionsData.getEnabledGraphics,
	setEnabledGraphics			= OptionsData.setEnabledGraphics,
	graphicsChanged				= graphicsChanged,
	setGraphicsLow				= OptionsData.setGraphicsLow,
	setGraphicsMedium			= OptionsData.setGraphicsMedium,
	setGraphicsHigh				= OptionsData.setGraphicsHigh,
    setGraphicsVR               = OptionsData.setGraphicsVR,
	setGraphicsCustom1          = OptionsData.setGraphicsCustom1,
	setGraphicsCustom2          = OptionsData.setGraphicsCustom2,
	setGraphicsCustom3          = OptionsData.setGraphicsCustom3,
	saveGraphicsCustom1			= OptionsData.saveGraphicsCustom1,
	saveGraphicsCustom2			= OptionsData.saveGraphicsCustom2,
	saveGraphicsCustom3			= OptionsData.saveGraphicsCustom3,
	isGraphicsCustom1			= OptionsData.isGraphicsCustom1,
	isGraphicsCustom2			= OptionsData.isGraphicsCustom2,
	isGraphicsCustom3			= OptionsData.isGraphicsCustom3,
	updateRelationsGraphics		= updateRelationsGraphics,
	
	getViewsCockpit				= OptionsData.getViewsCockpit,
	setViewsCockpit				= OptionsData.setViewsCockpit,
	getViewsCockpitValues		= OptionsData.getViewsCockpitValues,
	getViewsCockpitChanged		= OptionsData.getViewsCockpitChanged,
	getViewsCockpitDb			= OptionsData.getViewsCockpitDb,
	viewsCockpitChanged			= viewsCockpitChanged,	
	setViewsCockpitLow			= OptionsData.setViewsCockpitLow,
	setViewsCockpitMedium		= OptionsData.setViewsCockpitMedium,
	setViewsCockpitHigh			= OptionsData.setViewsCockpitHigh,
    setViewsCockpitVR           = OptionsData.setViewsCockpitVR,
	
	getSound					= OptionsData.getSound,
	setSound					= OptionsData.setSound,
	getSoundValues				= OptionsData.getSoundValues,
	setSoundValues				= OptionsData.setSoundValues,
	getSoundChanged				= OptionsData.getSoundChanged,
	getSoundDb					= OptionsData.getSoundDb,
	soundChanged				= soundChanged,	
	
	getMiscellaneous			= OptionsData.getMiscellaneous,
	setMiscellaneous			= OptionsData.setMiscellaneous,
	getMiscellaneousValues		= OptionsData.getMiscellaneousValues,
	getMiscellaneousChanged		= OptionsData.getMiscellaneousChanged,
	getMiscellaneousDb			= OptionsData.getMiscellaneousDb,
	miscellaneousChanged		= miscellaneousChanged,	
	
	setLanguage					= OptionsData.setLanguage,
	getLanguageChanged			= OptionsData.getLanguageChanged,
    
    getVR			            = OptionsData.getVR,
	setVR			            = OptionsData.setVR,
	getVRValues		            = OptionsData.getVRValues,
	getVRChanged		        = OptionsData.getVRChanged,
	getVRDb			            = OptionsData.getVRDb,
	VRChanged		            = VRChanged,	
	
	getPlugin					= OptionsData.getPlugin,
	setPlugin					= OptionsData.setPlugin,
	getPluginValues				= OptionsData.getPluginValues,
	getPluginChanged			= OptionsData.getPluginChanged,
	getPluginDb					= OptionsData.getPluginDb,	
	pluginChanged				= pluginChanged,
	getPluginRelationsFunc		= OptionsData.getPluginRelationsFunc,
	
	setForced					= OptionsData.setForced,
	getForced					= OptionsData.getForced,
	setForcedOptions			= OptionsData.setForcedOptions,
	getForcedOptions			= OptionsData.getForcedOptions,
	forcedChanged				= forcedChanged,
	
	onMissionOptionsViewShow	= onMissionOptionsViewShow,
	onMissionOptionsViewHide	= onMissionOptionsViewHide,
}