local DialogLoader		= require('DialogLoader')
local ListBoxItem		= require('ListBoxItem')
local U					= require('me_utilities')
local FileDialog		= require('FileDialog')
local FileDialogFilters = require('FileDialogFilters')
local FileDialogUtils	= require('FileDialogUtils')
local minizip			= require('minizip')
local lfs				= require('lfs')
local MeSettings		= require('MeSettings')
local PanelUtils		= require('PanelUtils')
local i18n				= require('i18n')

local _ = i18n.ptranslate

local window_
local editBoxTrackFilename_
local comboListVideoCodecs_
local startTimePanel_
local finishTimePanel_
local editBoxResolutionX_
local editBoxResolutionY_
local editBoxAspect_
local spinBoxQuality_
local spinBoxRate_
local editBoxFolder_
local editBoxFilename_
local initialBounds_
local editBoxNameInvalidSkin_
local listener_

local startTime = 0
local finishTime = 0

local videoCodecs_ = {
	{name = 'Theora + Vorbis',		encoder ='THEORA', format ='%s.ogv'},
	{name = 'PNG sequence + WAV',	encoder ='PNGWAV'},
	{name = 'Uncompressed AVI',		encoder ='RAWAVI', format ='%s.avi'},
}

local function setListener(listener)
	listener_ = listener
end

local function create(...)
  initialBounds_ = {...}
end

local function getTimePanelTime(timePanel)
	local dd = tonumber(timePanel.dd:getText())
	local hh = tonumber(timePanel.hh:getText())
	local mm = tonumber(timePanel.mm:getText())
	local ss = tonumber(timePanel.ss:getText())
	
	return (((dd - 1) * 24 + hh) * 60 + mm) * 60 + ss
end

local function setTimePanelTime(timePanel, timeValue)
	timePanel.dd:setText(math.floor(timeValue / 86400) + 1)
	timeValue = math.fmod(timeValue, 86400)

	timePanel.hh:setText(math.floor(timeValue / 3600))
	timeValue = math.fmod(timeValue, 3600)

	timePanel.mm:setText(math.floor(timeValue / 60))
	timeValue = math.fmod(timeValue, 60)

	timePanel.ss:setText(math.floor(timeValue))
end

local function blinkEditBox(editBox)
	PanelUtils.blinkWidget(editBox, editBoxNameInvalidSkin_)
end

local function createTimePanels()
	startTimePanel_ = U.create_time_panel()
	startTimePanel_:setBounds(window_.staticStartPlaceholder:getBounds())
	window_:insertWidget(startTimePanel_)

	finishTimePanel_ = U.create_time_panel()
	finishTimePanel_:setBounds(window_.staticFinishPlaceholder:getBounds())
	window_:insertWidget(finishTimePanel_)	 

	finishTimePanel_.dd:setText(999)
	
	startTimePanel_.onChange = function()
		updateStartEnabled()
	end
	
	finishTimePanel_.onChange = function()
		updateStartEnabled()
	end
end

function updateStartEnabled()
	local startTimeTmp = getTimePanelTime(startTimePanel_)
	local finishTimeTmp = getTimePanelTime(finishTimePanel_)
			
	if startTimeTmp < startTime or startTimeTmp > finishTimeTmp 
		or finishTimeTmp > finishTime then
		buttonStart:setEnabled(false)
	else
		buttonStart:setEnabled(true)
	end
end

local function setTrackFile(filename)		   
	local a, err = lfs.attributes(filename)
	
	if a and a.mode == 'file' then
		editBoxTrackFilename_:setText(filename)

		local fileNameShort = U.extractFileName(filename)		
		if fileNameShort then
			local dotIdx = string.find(fileNameShort, '%.')
			if dotIdx then
				fileNameShort = string.sub(fileNameShort, 1, dotIdx-1)
			end
			if fileNameShort then
				editBoxFilename_:setText(fileNameShort)
			end
		end
		-- после выбора трека читаем стартовые-стоповые времена
		-- пытаемся открыть трек
		local zipFile = assert(minizip.unzOpen(filename, 'rb'))
			if not zipFile then
				print('invalid track file: '..filename)
			return
		end

		local times = zipFile:unzLocateFile('track_data/times')
		
		if not times then
			print('can\'t extract \'track_data/times\' from track file: '.. filename)
			return
		end

		local misStr = zipFile:unzReadAllCurrentFile(false)
		
		if not misStr then
			print('can\'t read \'track_data/times\'')
			return
		end
		
		zipFile:unzClose()
		
		-- исполняем загруженую строку
		local fun = loadstring(misStr)
		local env = { }
		
		setfenv(fun, env)
		fun()

		-- прописываем времена в диалог
		setTimePanelTime(startTimePanel_, env.absoluteTime0)
		setTimePanelTime(finishTimePanel_, env.absoluteTime1)
		
		startTime = env.absoluteTime0
		finishTime = env.absoluteTime1

		startTimePanel_:setEnabled(true)
		finishTimePanel_:setEnabled(true)
	end
end

local function bindTrackFilenameWidgets()
	editBoxTrackFilename_ = window_.editBoxTrackFilename
	
	function window_.buttonSelectTrack:onChange()
		local path = MeSettings.getTrackPath()
		local filters = {FileDialogFilters.track()}
		local filename = FileDialog.open(path, filters, _('Select track:'))
		
		if filename then
			setTrackFile(filename)
		end
	end
end

local function bindComboListVideoCodecs()
	comboListVideoCodecs_ = window_.comboListVideoCodecs
	
	for i, info in ipairs(videoCodecs_) do
		local item = ListBoxItem.new(info.name)
		
		item.index = i
		
		comboListVideoCodecs_:insertItem(item)
	end
end

local function bindQualityWidgets()
	local sliderQuality = window_.sliderQuality
	
	spinBoxQuality_ = window_.spinBoxQuality

	function spinBoxQuality_:onChange()
		sliderQuality:setValue( spinBoxQuality_:getValue() )
	end

	function sliderQuality:onChange()
		spinBoxQuality_:setValue( sliderQuality:getValue() )
	end
end

local function bindRateWidgets()
	local sliderRate = window_.sliderRate
	
	spinBoxRate_ = window_.spinBoxRate

	function spinBoxRate_:onChange()
		sliderRate:setValue( spinBoxRate_:getValue() )
	end

	function sliderRate:onChange()
		spinBoxRate_:setValue( sliderRate:getValue() )
	end
end

local function bindFilenameWidgets()
	editBoxFolder_ = window_.editBoxFolder
	local moviesPath = MeSettings.getMoviePath()
	
	editBoxFolder_:setText(moviesPath)
	
	function window_.buttonSelectFolder:onChange()
		local path = MeSettings.getMoviePath()
		local folderName = FileDialog.selectFolder(path, _('Select Folder'))
		
		if folderName then
			editBoxFolder_:setText(folderName)
			MeSettings.setMoviePath(folderName)
		end
	end

	editBoxFilename_ = window_.editBoxFilename
	editBoxNameInvalidSkin_	= window_.editBoxInvalidSkin:getSkin()	
end

local function updateAspect()
	local resolutionX = tonumber(editBoxResolutionX_:getText())
	local resolutionY = tonumber(editBoxResolutionY_:getText())
	
	if	resolutionX and 
		resolutionY and 
		resolutionX > 0 and 
		resolutionY > 0 then
		editBoxAspect_:setText(resolutionX / resolutionY)
	else
		editBoxAspect_:setText(0)
	end
end

local function bindResolutionWidgets()
	editBoxResolutionX_ = window_.editBoxResolutionX
	editBoxResolutionY_ = window_.editBoxResolutionY
	editBoxAspect_ = window_.editBoxAspect

	function editBoxResolutionX_:onChange()
		updateAspect()
	end

	function editBoxResolutionY_:onChange()
		updateAspect()
	end
end

local function getAviSettings()
	local aviSettings = {}
	local videoCodec = videoCodecs_[comboListVideoCodecs_:getSelectedItem().index]

	aviSettings.filename = editBoxFilename_:getText()

	if videoCodec.format then
		aviSettings.filename = string.format(videoCodec.format, aviSettings.filename)
	end
	
	aviSettings.filename		= editBoxFolder_:getText() .. '\\'.. aviSettings.filename	   
	aviSettings.encoder 		= videoCodec.encoder
	aviSettings.framerate		= spinBoxRate_:getValue()
	aviSettings.samplerate		= 44100
	aviSettings.bpp				= 32
	aviSettings.full_screen 	= false
	aviSettings.height			= tonumber(editBoxResolutionY_:getText())
	aviSettings.width			= tonumber(editBoxResolutionX_:getText())
	aviSettings.aspect			= tonumber(editBoxAspect_:getText())
	aviSettings.quality			= spinBoxQuality_:getValue() / 100.0
	
	aviSettings.startTime		= getTimePanelTime(startTimePanel_)		 
	aviSettings.finishTime		= getTimePanelTime(finishTimePanel_)
	
	return aviSettings
end

function getMeSettings()
	return{
		video		= comboListVideoCodecs_:getSelectedItem().index,
		folder		= editBoxFolder_:getText(),
		height		= editBoxResolutionY_:getText(),
		width		= editBoxResolutionX_:getText(),
		rate		= spinBoxRate_:getValue(),
		quality		= spinBoxQuality_:getValue(),
		fileName	= editBoxFilename_:getText(),
		trackname	= editBoxTrackFilename_:getText(),
	}
end

local function onStart()
	local trackname = editBoxTrackFilename_:getText()
	
	if not trackname or trackname == '' then 
		blinkEditBox(editBoxTrackFilename_)
		
		return 
	end
	
	if FileDialogUtils.getFilenameContainsProhibitedSymbols(editBoxFilename_:getText()) then
		blinkEditBox(editBoxFilename_)
		
		return
	end
	
	local resolutionX = tonumber(editBoxResolutionX_:getText())
	
	if not resolutionX or 0 >= resolutionX then
		blinkEditBox(editBoxResolutionX_)
		
		return		
	end
	
	local resolutionY = tonumber(editBoxResolutionY_:getText())
	
	if not resolutionY or 0 >= resolutionY then
		blinkEditBox(editBoxResolutionY_)
		
		return		
	end	
	
	if listener_ then
		listener_.saveAviSettings(getAviSettings())
		listener_.saveMeSettings(getMeSettings())
		listener_.playMission(trackname)
	end
end

local hide
local function create_()
	local localization = {
	  record_avi	= _('RECORD AVI'),
	  time			= _('TIME'),
	  start			= _('START'),
	  finish		= _('FINISH'),
	  compression	= _('COMPRESSION'),
	  video_method	= _('VIDEO METHOD'),
	  full_frames	= _('Full Frames (Uncompressed)'),
	  quality		= _('QUALITY'),
	  audio_method	= _('AUDIO METHOD'),
	  pcm			= _('Microsoft PCM (Uncompressed)'),
	  file			= _('FILE'),
	  name			= _('OUTPUT FILE NAME'),
	  rate			= _('FPS'),
	  resolution	= _('RESOLUTION'),
	  aspect		= _('ASPECT'),
	  cancel		= _('CANCEL'),
	  ltrackname	= _('TRACK'),
	  lfolder		= _('FOLDER')
	}
	
	window_ = DialogLoader.spawnDialogFromFile('MissionEditor/modules/dialogs/me_record_avi_panel.dlg', localization)
	
	buttonStart = window_.buttonStart
	
	if initialBounds_ then
		window_:setBounds(unpack(initialBounds_))
	end

	function window_:onClose()
		hide()
	end
	
	createTimePanels()	
	bindTrackFilenameWidgets()
	bindComboListVideoCodecs()
	bindQualityWidgets()
	bindRateWidgets()
	bindFilenameWidgets()
	bindResolutionWidgets()

	function window_.buttonStart:onChange()
		onStart()
	end

	function window_.buttonCancel:onChange()
		hide()
	end
end

local function loadSettings()
	local recordAviParams = MeSettings.getRecordAviParams()
	
	local itemIndex = 0
	
	if recordAviParams.video then
		itemIndex = recordAviParams.video - 1
	end	
	
	local item = comboListVideoCodecs_:getItem(itemIndex)
	
	if item then
		comboListVideoCodecs_:selectItem(item) 
	end	   

	if recordAviParams.folder then
		editBoxFolder_:setText(recordAviParams.folder) 
	end	  

	if recordAviParams.height then
		editBoxResolutionY_:setText(recordAviParams.height)
	end

	if recordAviParams.width then
		editBoxResolutionX_:setText(recordAviParams.width) 
	end
	
	updateAspect()
	
	if recordAviParams.rate then
		spinBoxRate_:setValue(recordAviParams.rate)
		spinBoxRate_:onChange()
	end

	if recordAviParams.quality then		
		spinBoxQuality_:setValue(recordAviParams.quality)
		spinBoxQuality_:onChange()
	end
	
	if recordAviParams.fileName then  
		editBoxFilename_:setText(recordAviParams.fileName)
	end
	
	if recordAviParams.trackname then 
		editBoxTrackFilename_:setText(recordAviParams.trackname)
		setTrackFile(recordAviParams.trackname)
	end
end

-- объявлена ранее
local function show()
	if not window_ then
		create_()
	end
	
	loadSettings()
	
	window_:setVisible(true)
end

hide = function()
	if window_ then
		window_:setVisible(false)
	end
	
	if listener_ then
		listener_.onTrackRecordPanelHide()
	end
end

return {
	setListener	= setListener,
	create		= create,
	show		= show,
	hide		= hide,
}