local Serializer	= require('Serializer')
local TableUtils	= require('TableUtils')
local lfs			= require('lfs')
local log      		= require('log')

local writeDir_ = lfs.writedir()
local userDataDir_ = lfs.writedir() .. 'MissionEditor/'
local filename_ = userDataDir_ .. 'settings.lua'
local options_

local function getMeSettingsFolder()
	return userDataDir_
end

local function loadOptions()
	local options = {
		fileDialog					= {},
		fileDialogEditor			= {},
		lastCampaign				= {},
		lastTraining				= {},
		mainMenu					= {},
		openFileDialogParams		= {},
		openFileDialogParamsMy		= {},
		openFileDialogTrackParams	= {},
		recordAviParams				= {},
		quickStart					= {},
		controlsTab					= {},
		hiddenMapLayers				= {},
		deviceNames					= {},
		showTrainingSubtilesWarning = true,
	}
	local func, err = loadfile(filename_)
	
	if func then
		local ok, res = pcall(func)
		if not ok then
			log.error('ERROR: loadOptions() failed to pcall "'..filename_..'": '..res)
			return options
		end
		options = TableUtils.mergeTables(options, res or {})
	else
		print(err)
	end
	
	return options
end

local function getOptions()
	if not options_ then
		options_ = loadOptions()
	end

	return options_
end

local function save()
	local file, err = io.open(filename_, 'w')
	
	if file then
		local serializer = Serializer.new(file)
		
		file:write('local ')
		serializer:serialize_sorted('settings', options_)
		file:write('return settings\n')
		
		file:close()
	else
		log.error('ERROR: MeSettings save() failed: '..err)	
	end
end

local function setMainMenuSkinName(skinName)
	getOptions().mainMenu.skinName = skinName
end

local function getMainMenuSkinName()
	return getOptions().mainMenu.skinName
end

local function setQuickStartClsid(clsid)
	getOptions().quickStart.clsid = clsid
end

local function getQuickStartClsid()
	return getOptions().quickStart.clsid
end

local function setQuickStartTerrain(terrain)
	getOptions().quickStart.terrain = terrain
end

local function getQuickStartTerrain()
	return getOptions().quickStart.terrain
end

local function setLastCampaign(clsid, row)
	local lastCampaign = getOptions().lastCampaign
	
	lastCampaign.clsid	= clsid
	lastCampaign.row	= row
end

local function getLastCampaign()
	local lastCampaign = getOptions().lastCampaign
	
	return lastCampaign.clsid, lastCampaign.row
end

local function setLastTraining(clsid, lesson, addId)
	local lastTraining = getOptions().lastTraining
	lastTraining.clsid	= clsid
	lastTraining.lesson	= lesson
	lastTraining.addId = addId
end

local function getLastTraining()
	local lastTraining = getOptions().lastTraining
	return lastTraining.clsid, lastTraining.lesson, lastTraining.addId
end

local function setRecordAviParams(recordAviParams)
	TableUtils.copyTable(getOptions().recordAviParams, recordAviParams)
end

local function getRecordAviParams()
	return TableUtils.copyTable(nil, getOptions().recordAviParams)
end

local function setTheatreOfWar(theatreOfWar)
	getOptions().theatreOfWar = theatreOfWar 
end

local function getTheatreOfWar()
	return getOptions().theatreOfWar
end

local function setOpenFileDialogParamsMy(lastPathTable, sortColumnIndex, sortReverse)
	local openFileDialogParams = getOptions().openFileDialogParamsMy
	if lastPathTable then
		openFileDialogParams.lastPathTable	= TableUtils.copyTable(nil, lastPathTable)
	end
	
	openFileDialogParams.sortColumnIndex	= sortColumnIndex
	openFileDialogParams.sortReverse		= sortReverse
end

local function setOpenFileDialogParams(sortColumnIndex, sortReverse)
	local openFileDialogParams = getOptions().openFileDialogParams
	
	openFileDialogParams.sortColumnIndex	= sortColumnIndex
	openFileDialogParams.sortReverse		= sortReverse
end

local function setOpenFileDialogTrackParams(lastPathTable, sortColumnIndex, sortReverse)
	local openFileDialogTrackParams = getOptions().openFileDialogTrackParams	
	if lastPathTable then
		openFileDialogTrackParams.lastPathTable	= TableUtils.copyTable(nil, lastPathTable)
	end
	
	openFileDialogTrackParams.sortColumnIndex	= sortColumnIndex
	openFileDialogTrackParams.sortReverse		= sortReverse
end

local function getOpenFileDialogParamsMy()
	local openFileDialogParams = getOptions().openFileDialogParamsMy
	local lastPathTable
	
	if openFileDialogParams.lastPathTable then
		lastPathTable = TableUtils.copyTable(nil, openFileDialogParams.lastPathTable)
	end
	
	return lastPathTable, openFileDialogParams.sortColumnIndex, openFileDialogParams.sortReverse
end

local function getOpenFileDialogParams()
	local openFileDialogParams = getOptions().openFileDialogParams
	
	return openFileDialogParams.sortColumnIndex, openFileDialogParams.sortReverse
end

local function getOpenFileDialogTrackParams()
	local openFileDialogTrackParams = getOptions().openFileDialogTrackParams
	local lastPathTable
	
	if openFileDialogTrackParams.lastPathTable then
		lastPathTable = TableUtils.copyTable(nil, openFileDialogTrackParams.lastPathTable)
	end
	
	return lastPathTable, openFileDialogTrackParams.sortColumnIndex, openFileDialogTrackParams.sortReverse
end

local function setLastOpenedFileParams(fileList, sortColumnNormalIndex, sortColumnAddMapIndex, sortReverseNormal, sortReverseAddMap)
	local fileDialog = getOptions().fileDialog
	
	fileDialog.fileList = TableUtils.copyTable(nil, fileList)
	fileDialog.sortColumnNormalIndex	= sortColumnNormalIndex
	fileDialog.sortColumnAddMapIndex	= sortColumnAddMapIndex
	fileDialog.sortReverseNormal		= sortReverseNormal
	fileDialog.sortReverseAddMap		= sortReverseAddMap
end

local function getLastOpenedFileParams()
	local fileDialog = getOptions().fileDialog
	local lastPathTable
	
	if fileDialog.fileList then
		lastPathTable = TableUtils.copyTable(nil, fileDialog.fileList)
	end
	
	return lastPathTable, fileDialog.sortColumnNormalIndex, fileDialog.sortColumnAddMapIndex, fileDialog.sortReverseNormal, fileDialog.sortReverseAddMap
end

local function setLastOpenedFileListEditor(fileList)
	local fileDialogEditor = getOptions().fileDialogEditor
	
	fileDialogEditor.fileList = TableUtils.copyTable(nil, fileList)
end

local function getLastOpenedFileListEditor()
	local fileDialogEditor = getOptions().fileDialogEditor
	
	if fileDialogEditor.fileList then
		return TableUtils.copyTable(nil, fileDialogEditor.fileList)
	end
end

local function getFileDialogMiniStyleParams()
	local fileDialog = getOptions().fileDialog

	return fileDialog.miniStyle or false
end

local function setFileDialogMiniStyleParams(a_miniStyle)
	local fileDialog = getOptions().fileDialog
	fileDialog.miniStyle = a_miniStyle
end

local function setMissionPath(path)
	local fileDialog = getOptions().fileDialog
	
	fileDialog.missionPath = path
end

local function getMissionPath()
	local fileDialog = getOptions().fileDialog
	
	return fileDialog.missionPath or userFiles.userMissionPath
end

local function setListMissionsPath(path)
	local fileDialog = getOptions().fileDialog
	
	fileDialog.listMissionsPath = path
end

local function getListMissionsPath()
	local fileDialog = getOptions().fileDialog
	
	return fileDialog.listMissionsPath or userFiles.userMissionPath
end

local function setRTSPath(path)
	local fileDialog = getOptions().fileDialog
	
	fileDialog.rtsPath = path
end

local function getRTSPath()
	local fileDialog = getOptions().fileDialog
	
	return fileDialog.rtsPath or userFiles.userMissionPath
end

local function setCampaignPath(path)
	local fileDialog = getOptions().fileDialog
	
	fileDialog.campaignPath = path
end

local function getCampaignPath()
	local fileDialog = getOptions().fileDialog
	
	return fileDialog.campaignPath or userFiles.userCampaignPath
end

local function setScriptPath(path)
	local fileDialog = getOptions().fileDialog
	
	fileDialog.scriptPath = path
end

local function getScriptPath()
	local fileDialog = getOptions().fileDialog
	
	return fileDialog.scriptPath or writeDir_
end

local function setSoundPath(path)
	local fileDialog = getOptions().fileDialog
	
	fileDialog.soundPath = path
end

local function getSoundPath()
	local fileDialog = getOptions().fileDialog
	
	return fileDialog.soundPath or writeDir_
end

local function setImagePath(path)
	local fileDialog = getOptions().fileDialog
	
	fileDialog.imagePath = path
end

local function getImagePath()
	local fileDialog = getOptions().fileDialog
	
	return fileDialog.imagePath or writeDir_
end

local function setTrackPath(path)
	local fileDialog = getOptions().fileDialog
	
	fileDialog.trackPath = path
end

local function getTrackPath()
	local fileDialog = getOptions().fileDialog
	
	return fileDialog.trackPath or userFiles.userTrackPath
end

local function setDebriefingPath(path)
	local fileDialog = getOptions().fileDialog
	
	fileDialog.debriefingPath = path
end

local function getDebriefingPath()
	local fileDialog = getOptions().fileDialog
	
	return fileDialog.debriefingPath or writeDir_
end

local function setMoviePath(path)
	local fileDialog = getOptions().fileDialog
	
	fileDialog.moviePath = path
end

local function getMoviePath()
	local fileDialog = getOptions().fileDialog
	
	return fileDialog.moviePath or userFiles.userMoviePath
end

local function setOptionsPath(path)
	local fileDialog = getOptions().fileDialog
	
	fileDialog.optionsPath = path
end

local function getOptionsPath()
	local fileDialog = getOptions().fileDialog
	
	return fileDialog.optionsPath or writeDir_
end

local function setLastIp(ip)
	getOptions().lastIp = ip
end

local function getLastIp()
	return getOptions().lastIp
end

local function setShowModels(bShow)	
	getOptions().showModels = bShow
end

local function getShowModels()	
	return getOptions().showModels
end

local function setShowEngAreas(bShow)	
	getOptions().showEngAreas = bShow
end

local function getShowEngAreas()	
	return getOptions().showEngAreas
end

local function setShowDetAreas(bShow)	
	getOptions().showDetAreas = bShow
end

local function getShowDetAreas()	
	return getOptions().showDetAreas
end

local function setSnap(b)	
	getOptions().Snap = b
end

local function getSnap()	
	return getOptions().Snap
end

local function setShowEras(bShow)	
	getOptions().showEras = bShow
end

local function getShowEras()	
	return getOptions().showEras
end

local function setPermissionToCollectStatistics(permissionToCollectStatistics)
	getOptions().permissionToCollectStatistics = permissionToCollectStatistics
end

local function getPermissionToCollectStatistics()
	return getOptions().permissionToCollectStatistics
end

local function setControlsTabUnitName(unitName)
	local controlsTab = getOptions().controlsTab
	
	controlsTab.unitName = unitName
end

local function getControlsTabUnitName()
	local controlsTab = getOptions().controlsTab
	
	return controlsTab.unitName
end

local function setControlsTabHidePopupMenuAnnouncement(bHide)
	local controlsTab = getOptions().controlsTab
	
	controlsTab.hidePopupMenuAnnouncement = bHide
end

local function getControlsTabHidePopupMenuAnnouncement()
	local controlsTab = getOptions().controlsTab
	
	return controlsTab.hidePopupMenuAnnouncement
end

local function setUnitsListColumnsWidth(a_unitsListColumnsWidth)
	getOptions().unitsListColumnsWidth = a_unitsListColumnsWidth
end

local function getUnitsListColumnsWidth()
	return getOptions().unitsListColumnsWidth
end

local function setMapLayerHidden(mapLayerTitle, hidden)
	getOptions().hiddenMapLayers[mapLayerTitle] = hidden
end

local function getMapLayerHidden(mapLayerTitle)
	return getOptions().hiddenMapLayers[mapLayerTitle]
end

local function setDeviceName(inputDeviceName, deviceName)
	if inputDeviceName == deviceName then
		getOptions().deviceNames[inputDeviceName] = nil
	else
		getOptions().deviceNames[inputDeviceName] = deviceName
	end
end

local function getDeviceName(inputDeviceName)
	local deviceName = getOptions().deviceNames[inputDeviceName]
	
	if not deviceName then
		deviceName = inputDeviceName
	end
	
	return deviceName
end

local function setShowFoldableView(bShow)	
	getOptions().showFoldableView = bShow
end

local function getShowFoldableView()	
	return getOptions().showFoldableView
end

local function getEnabledViewportEditor()	
	return getOptions().enabledViewportEditor
end

local function setShowTrainingSubtilesWarning(bShow)	
	getOptions().showTrainingSubtilesWarning = bShow
end

local function getShowTrainingSubtilesWarning()	
	return getOptions().showTrainingSubtilesWarning
end


local function saver(func)
	return function(...)
		func(...)
		save()
	end
end

return {
	getMeSettingsFolder			= getMeSettingsFolder,

	setMainMenuSkinName			= saver(setMainMenuSkinName),
	getMainMenuSkinName			= getMainMenuSkinName,
	
	setQuickStartClsid			= saver(setQuickStartClsid),
	getQuickStartClsid			= getQuickStartClsid,
	
	setQuickStartTerrain		= saver(setQuickStartTerrain),
	getQuickStartTerrain		= getQuickStartTerrain,
			
	setLastCampaign				= saver(setLastCampaign),
	getLastCampaign				= getLastCampaign,
			
	setLastTraining				= saver(setLastTraining),
	getLastTraining				= getLastTraining,	
		
	setRecordAviParams			= saver(setRecordAviParams),
	getRecordAviParams			= getRecordAviParams,
	
	setTheatreOfWar				= saver(setTheatreOfWar),
	getTheatreOfWar				= getTheatreOfWar,
		
	setOpenFileDialogParamsMy	= saver(setOpenFileDialogParamsMy),
	getOpenFileDialogParamsMy	= getOpenFileDialogParamsMy,
	
	setOpenFileDialogParams		= saver(setOpenFileDialogParams),
	getOpenFileDialogParams		= getOpenFileDialogParams,
	
	setOpenFileDialogTrackParams	= saver(setOpenFileDialogTrackParams),
	getOpenFileDialogTrackParams	= getOpenFileDialogTrackParams,

	setLastOpenedFileParams		= saver(setLastOpenedFileParams),
	getLastOpenedFileParams		= getLastOpenedFileParams,
	
	setLastOpenedFileListEditor = saver(setLastOpenedFileListEditor),
	getLastOpenedFileListEditor = getLastOpenedFileListEditor,
	
	setFileDialogMiniStyleParams = saver(setFileDialogMiniStyleParams),
	getFileDialogMiniStyleParams = getFileDialogMiniStyleParams,
	
	setMissionPath				= saver(setMissionPath),
	getMissionPath				= getMissionPath,
	
	setRTSPath					= saver(setRTSPath),
	getRTSPath					= getRTSPath,
	
	setListMissionsPath			= saver(setListMissionsPath),
	getListMissionsPath			= getListMissionsPath, 
	
	setCampaignPath				= saver(setCampaignPath),
	getCampaignPath				= getCampaignPath,		
	
	setScriptPath				= saver(setScriptPath),
	getScriptPath				= getScriptPath,		
	
	setSoundPath				= saver(setSoundPath),
	getSoundPath				= getSoundPath,	
	
	setImagePath				= saver(setImagePath),
	getImagePath				= getImagePath,	
	
	setTrackPath				= saver(setTrackPath),
	getTrackPath				= getTrackPath,	
	
	setDebriefingPath			= saver(setDebriefingPath),
	getDebriefingPath			= getDebriefingPath,	
	
	setMoviePath				= saver(setMoviePath),
	getMoviePath				= getMoviePath,
	
	setOptionsPath				= saver(setOptionsPath),
	getOptionsPath				= getOptionsPath,
	
	setControlsTabUnitName		= saver(setControlsTabUnitName),
	getControlsTabUnitName		= getControlsTabUnitName,
	
	setControlsTabHidePopupMenuAnnouncement	= saver(setControlsTabHidePopupMenuAnnouncement),
	getControlsTabHidePopupMenuAnnouncement	= getControlsTabHidePopupMenuAnnouncement,
	
	setUnitsListColumnsWidth	= saver(setUnitsListColumnsWidth),
	getUnitsListColumnsWidth	= getUnitsListColumnsWidth,

	setMapLayerHidden			= saver(setMapLayerHidden),
	getMapLayerHidden			= getMapLayerHidden,
	
	setLastIp					= saver(setLastIp),
	getLastIp					= getLastIp,
	
	setShowModels				= saver(setShowModels),
	getShowModels				= getShowModels,
	
	setShowEngAreas				= saver(setShowEngAreas),
	getShowEngAreas				= getShowEngAreas,
	
	setShowDetAreas				= saver(setShowDetAreas),
	getShowDetAreas				= getShowDetAreas,
	
	setSnap						= saver(setSnap),
	getSnap						= getSnap,
	
	setShowEras					= saver(setShowEras),
	getShowEras					= getShowEras,
	
	setPermissionToCollectStatistics	= saver(setPermissionToCollectStatistics),
	getPermissionToCollectStatistics	= getPermissionToCollectStatistics,
	
	setDeviceName				= saver(setDeviceName),
	getDeviceName				= getDeviceName,
	
	setShowFoldableView			= saver(setShowFoldableView),
	getShowFoldableView			= getShowFoldableView,	
	
	setShowTrainingSubtilesWarning	= saver(setShowTrainingSubtilesWarning),
	getShowTrainingSubtilesWarning	= getShowTrainingSubtilesWarning,
	
	getEnabledViewportEditor 	= getEnabledViewportEditor,	
}