module('FileDialog', package.seeall)

local DialogLoader		= require('DialogLoader')
local FileGrid			= require('FileGrid')
local ListBoxItem		= require('ListBoxItem')
local SelectFileBar		= require('SelectFileBar')
local FileDialogUtils	= require('FileDialogUtils')
local FileDialogFilters	= require('FileDialogFilters')
local MsgWindow			= require('MsgWindow')
local MeSettings	 	= require('MeSettings')
local BuddyWindow		= require('BuddyWindow')
local i18n				= require('i18n')
local TheatreOfWarData	= require('Mission.TheatreOfWarData')
local mod_dictionary    = require('dictionary')
local U					= require('me_utilities')
local modulesInfo       = require('me_modulesInfo')
local textutil 			= require('textutil')

i18n.setup(_M)

local cdata = {
	filename				= _('File name:'),
	setCurrentFolderRoot	= _('Set current folder root'),
	ok						= _('OK'),
	cancel					= _('Cancel'),
	yes						= _('YES'),
	no						= _('NO'),	
	invalidFilenameMsg		= _('Invalid filename!'),
	fileDoesNotExistMsg		= _('File does not exist!'),
	fileAlreadyExistsMsg	= _('File already exists!'),
	openFile				= _('Open file:'),
	selectFolder			= _('Select folder:'),
	saveFile				= _('Save file:'),
	overwriteFile			= _('File already exists on disk, do you wish to overwrite file?'), 
	warning					= _('WARNING'), 
    delFile					= _('Are you sure you want to delete the file?'), 
	Listofmodules			= _('Units  from the following modules are required to play this mission as intended'), 
	FolderBrowser 			= _('Folder Browser'),
}

local rootPath_
local maxListItemCount_ = 10

local window_
local selectFileBar_
local comboBoxFilename_
local listBoxLocations_
local comboListFilter_
local fileGrid_
local staticWarning_
local checkBoxRoot_
local result_
local modeName_
local extentions_
local msgWindowHandler_
local style_
local columnNormal = 0
local columnAddMap = 0
local reverseNormal = false
local reverseAddMap = false
local miniStyle 	= false
local showRequiredModules = false
local typeFile = nil
local buddyWindow_
local listBoxBuddy_
local listBoxBuddyItemHeight_


function modeOpen() return 'open' end
function modeSelectFolder() return 'selectFolder' end
function modeSave() return 'save' end

local function isModeOpen_()
	return modeOpen() == modeName_
end

local function ismodeSelectFolder_()
	return modeSelectFolder() == modeName_
end

local function isModeSave_()
	return modeSave() == modeName_
end

local function getFilterExtentions_(filterExtentions)
	-- filterExtentions это строка вида '(*.ogg)' или (*.*) или несколько расширений (*.jpg;*.jpeg;*.png)
	local extentions
	local patterns = string.match(filterExtentions, '.*%((.*)%)$') 

	for pattern in string.gmatch(patterns, '([^;]+)') do
		local extention = string.match(pattern, '%s*%*%.(.*)')

		if '*' ~= extention then
			extentions = extentions or {}
			table.insert(extentions, extention)
		end
	end

	return extentions
end

local function getFilename_()
	local filename = comboBoxFilename_:getText()

	if filename ~= '' and isModeSave_() then
		local ext = U.getExtension(filename)
		
		if extentions_ then
			local validExt = false
			for k, v in pairs(extentions_) do
				if v == ext then
					validExt = true
				end
			end
			
			if validExt == false then
				filename = filename .. '.' .. extentions_[1]
			end
		end
	end

	return filename
end

local function getFullPath_(filename)
	local result

	if FileDialogUtils.getFilenameIsAbsolutePath(filename) then
		result = filename
	else
		local path = selectFileBar_:getPath()

		if path then
			result = path .. '\\' .. filename
		else
			result = filename
		end
	end

	return result
end

local function getFilenameInListIndex_(filename)
	local result
	local itemCount = comboBoxFilename_:getItemCount()

	for i = 0, itemCount - 1 do
		local item = comboBoxFilename_:getItem(i)

		if item:getText() == filename then
			result = i

			break
		end
	end

	return result
end

local function saveFilesListInFile_()
	local list = {}
	local itemCount = comboBoxFilename_:getItemCount()

	for i = 0, itemCount - 1 do
		local item = comboBoxFilename_:getItem(i)

		table.insert(list, item:getText())
	end
	
	if style_ == "normal" then
		columnNormal, reverseNormal = fileGrid_:getSortColumnReverse()
	else
		columnAddMap, reverseAddMap = fileGrid_:getSortColumnReverse()
	end

	MeSettings.setLastOpenedFileParams(list, columnNormal, columnAddMap, reverseNormal, reverseAddMap)
	MeSettings.setFileDialogMiniStyleParams(miniStyle)
end

local function loadFilesListFromFile_()	
	local list = {}
	local tbl
	local column
	local reverse
	tbl, columnNormal, columnAddMap, reverseNormal, reverseAddMap = MeSettings.getLastOpenedFileParams()	
	
	comboBoxFilename_:clear()

	if tbl then
		if style_ == "normal" then
			column = columnNormal
			reverse = reverseNormal
		else
			column = columnAddMap
			reverse = reverseAddMap
		end
		fileGrid_:setSortColumnReverse(column, reverse)
		list = tbl
	end	

	for i, filename in ipairs(list) do
		comboBoxFilename_:insertItem(ListBoxItem.new(filename))
	end
	
end

local function addFilenameToList_(filename)
	local index = getFilenameInListIndex_(filename)

	if index then
		comboBoxFilename_:removeItem(comboBoxFilename_:getItem(index))
		comboBoxFilename_:insertItem(ListBoxItem.new(filename), 0)
	else
		comboBoxFilename_:insertItem(ListBoxItem.new(filename), 0)

		while comboBoxFilename_:getItemCount() > maxListItemCount_ do
			local item = comboBoxFilename_:getItem(comboBoxFilename_:getItemCount() - 1)

			comboBoxFilename_:removeItem(item)
		end
	end
	saveFilesListInFile_()
end

local function getFileExists_(filename)
	local fullPath = getFullPath_(filename)

	return FileDialogUtils.getFileExists(fullPath)
end

local function setWarningText_(text)
	staticWarning_:setText(text)
	staticWarning_:setEnabled(nil ~= text)
	updateSize()
end

local function onOkButtonOpen_(filename)
	if getFileExists_(filename) then
		local fullPath = getFullPath_(filename)
		local absPath = FileDialogUtils.getAbsolutePath(fullPath)

		result_ = FileDialogUtils.cropRootPath(absPath, rootPath_)

		addFilenameToList_(absPath)
		setWarningText_()
		window_:setVisible(false)
	else
		local fullPath = getFullPath_(filename)

		if FileDialogUtils.getFilenameIsValid(fullPath) then
			setWarningText_(cdata.fileDoesNotExistMsg)
		else
			setWarningText_(cdata.invalidFilenameMsg)
		end
	end
end

function onOkButtonSelectFolder_()
	result_ = selectFileBar_:getPath()
		setWarningText_()
		window_:setVisible(false)
end

local function getAbsolutePathToSave(filename)
	local fullPath = getFullPath_(filename)
	local folder = FileDialogUtils.extractFolderFromPath(fullPath)
	local name = FileDialogUtils.extractFilenameFromPath(fullPath)
	local absPath = FileDialogUtils.getAbsolutePath(folder)

	return absPath .. '\\' .. name
end

local function showOverwriteExistingFileWarningWindow_(filename)
	local result = true
	local attributes = lfs.attributes(filename)
	
	if attributes then
		result = false
		msgWindowHandler_ = MsgWindow.warning(cdata.overwriteFile, cdata.warning, cdata.yes, cdata.no)
        
		function msgWindowHandler_:onChange(buttonText)
			result = (buttonText == cdata.yes)
		end

		msgWindowHandler_:show()
		msgWindowHandler_ = nil
	end

	return result
end

local function onOkButtonSave_(filename)
	local filenameIsValid = filename ~= ''
	local absPath
	
	if filenameIsValid then 
		absPath = getAbsolutePathToSave(filename)

		filenameIsValid = FileDialogUtils.getFilenameIsValid(absPath)
	end	
	
	if filenameIsValid then	
		local folder = FileDialogUtils.extractFolderFromPath(absPath)
	
		filenameIsValid = FileDialogUtils.getFolderExists(folder)
	end
	
	if filenameIsValid then
		filenameIsValid = ('' ~= FileDialogUtils.extractFilenameFromPath(absPath))
	end
	
	if filenameIsValid then
		if showOverwriteExistingFileWarningWindow_(absPath) then
			result_ = absPath

			addFilenameToList_(absPath)
			setWarningText_() 
			window_:setVisible(false)
		end
	end

	if not filenameIsValid then
		setWarningText_(cdata.invalidFilenameMsg)
	end	
end

local function onOkButton_()
	local filename, isFolder = fileGrid_:getSelectedFile()
	
	if isFolder then
		fileGrid_:onFolderClick(filename, true)
	else	
		local filename = getFilename_()
		
		if isModeOpen_() then
			onOkButtonOpen_(filename)
		elseif ismodeSelectFolder_() then
			onOkButtonSelectFolder_()
		elseif isModeSave_() then
			onOkButtonSave_(filename)
		end
	end
end

local function onChangeListBoxOpen_(filename)
	if getFileExists_(filename) then
		setWarningText_()
	else
		setWarningText_(cdata.fileDoesNotExistMsg)
	end
end

local function onChangeListBoxSave_(filename)
	if getFileExists_(filename) then
		setWarningText_(cdata.fileAlreadyExistsMsg)
	else
		setWarningText_()
	end 
end

local function onChangeEditBoxOpen_(filename)
	if '' == filename then
		setWarningText_()
	else
		local fullPath = getFullPath_(filename)
		local absPath = FileDialogUtils.getAbsolutePath(fullPath)
		
		if getFileExists_(absPath) then
			setWarningText_()
		else
			local fullPath = getFullPath_(filename)

			if FileDialogUtils.getFilenameIsValid(absPath) then
				setWarningText_(cdata.fileDoesNotExistMsg)
			else
				setWarningText_(cdata.invalidFilenameMsg)
			end
		end
	end
end

local function onChangeEditBoxSave_(filename)
	local fullPath = getFullPath_(filename)
	local absPath = FileDialogUtils.getAbsolutePath(fullPath)
	
	if getFileExists_(absPath) then
		setWarningText_(cdata.fileAlreadyExistsMsg)
	else
		if FileDialogUtils.getFilenameIsValid(absPath) then
			setWarningText_()
		else
			setWarningText_(cdata.invalidFilenameMsg)
		end
	end 
end

local function showHelperWindow()
	local text = comboBoxFilename_:getText()
	
	if '' == text then
		buddyWindow_:setVisible(false)
	else
		listBoxBuddy_:clear()
		
		local namesList		= fileGrid_:getFileNamesList()
		
		for i, name in ipairs(namesList) do
			if 0 == textutil.Utf8FindNoCase(name, text) then
				local item = ListBoxItem.new(name)
				
				item.text = name
				listBoxBuddy_:insertItem(item)
			end
		end
		
		local itemCount = listBoxBuddy_:getItemCount()
		
		if itemCount > 0 then			
			local w, h = comboBoxFilename_:getSize()
			local x, y = comboBoxFilename_:widgetToWindow(0, h)
			
			x = x + 4
			y = y - 3
			buddyWindow_:setPosition(x, y)
			
			w = w - 24
			
			local maxVisibleItemCount = 10
			local windowHeight = math.min(maxVisibleItemCount, itemCount) * listBoxBuddyItemHeight_
			local listWidth, listHeight = listBoxBuddy_:calcSize()
			
			w = math.max(w, listWidth)
			
			listBoxBuddy_:setSize(w, windowHeight) 
			buddyWindow_:setSize(w, windowHeight)
			
			buddyWindow_:setVisible(true)
			comboBoxFilename_:setFocused(true)
		else
			buddyWindow_:setVisible(false)
		end
	end
end

local function onChangeEditBox_()
	local filename = getFilename_()

	if isModeOpen_() then
		onChangeEditBoxOpen_(filename)
	elseif isModeSave_() then
		onChangeEditBoxSave_(filename)
	end
end

local function onChangeListBox_(filename)
	if isModeOpen_() then
		onChangeListBoxOpen_(filename)
	elseif isModeSave_() then
		onChangeListBoxSave_(filename)
	end	 
end

local function onSelectFile_(filename)
	comboBoxFilename_:setText(filename)
	onChangeEditBox_()
	updateSoundPlayer()
	updateRequiredModules()
end

local function onChangeFolder_(filename)    
	fileGrid_:setPath(selectFileBar_:getPath())
	onChangeEditBox_()
end

local function createFileFrid_()
	fileGrid_ = FileGrid.new(window_.grid, nil, nil, nil, true)
	fileGrid_:setCellSkins(window_.staticFolderCell:getSkin(), window_.staticFileCell:getSkin(), window_.staticDateCell:getSkin(), window_.staticMapCell:getSkin())
	fileGrid_:setColumnHeaderSkins(window_.gridHeaderCellNoSort:getSkin(), window_.gridHeaderCellSortUp:getSkin(), window_.gridHeaderCellSortDown:getSkin())

	function fileGrid_:onFileClick(fileName, dblClick)
		if dblClick then
			if isModeOpen_() then
				onOkButtonOpen_(fileName)
			end
		else
			onSelectFile_(fileName)
		end
	end

	function fileGrid_:onFolderClick(folderName, dblClick)
		if dblClick then
			if '..' == folderName then
				-- нужно выделить текущую папку
				local path = selectFileBar_:getPath()
				local prevFolder = FileDialogUtils.extractFilenameFromPath(path)
				
				selectFileBar_:removeFolder()
				
				fileGrid_:setPath(selectFileBar_:getPath())
				onChangeEditBox_()
			else
				selectFileBar_:addFolder(folderName)
				
				local filename = comboBoxFilename_:getText()

				onChangeFolder_(filename)
			end
		end
	end
end

local function createSelectFileBar_()
	selectFileBar_ = SelectFileBar.new()
	local panel = selectFileBar_:getPanel()

	panel:setBounds(window_.selectFileBarPlaceholder:getBounds())
	window_:insertWidget(panel)

	function selectFileBar_:onSelectFolder(path)
		local filename = comboBoxFilename_:getText()

		onChangeFolder_(filename)
	end

	function selectFileBar_:onSelectFile(path, filename)
		onChangeFolder_(filename)
	end
end

local function fillListBoxLocations_()
	local locations = lfs.locations()

		for i, location in ipairs(locations) do
				local item = ListBoxItem.new(_(location.name))

				item.path = location.path
				listBoxLocations_:insertItem(item)
		end

	function listBoxLocations_:onChange()
		local item = self:getSelectedItem()
		local path = item.path

		selectFileBar_:setPath(path)
		fileGrid_:setPath(path)
		onChangeEditBox_()
	end
end

local function selectLocationByPath(a_path)
	--print("---selectLocationByPath---",a_path)
end

local function deleteFile()
    local fullName = fileGrid_:getFullName()
    
    if fullName then
        msgWindowHandler_ = MsgWindow.warning(cdata.delFile, cdata.warning, cdata.yes, cdata.no)
        
        function msgWindowHandler_:onChange(buttonText)
            if (buttonText == cdata.yes) then
                os.remove(fullName)
                fileGrid_:setPath(fileGrid_:getPath())
            end
        end

        msgWindowHandler_:show()
        msgWindowHandler_ = nil
    end
end

local function createWindow_()
	window_ = DialogLoader.spawnDialogFromFile('MissionEditor/modules/dialogs/FileDialog.dlg', cdata)
	window_:setSize(684, 540)

	pDown				= window_.pDown
	comboBoxFilename_ 	= pDown.comboBoxFilename
	listBoxLocations_ 	= window_.listBoxLocations
	comboListFilter_ 	= pDown.comboListFilter
	staticWarning_ 		= pDown.warningStatic
	checkBoxRoot_ 		= window_.checkBoxRoot
	pModules			= pDown.pModules
	lbModules			= pModules.lbModules
	cbMiniStyle			= pDown.cbMiniStyle
	
	listBoxBuddy_		= window_.listBoxBuddy
	listBoxBuddyItemHeight_ = listBoxBuddy_:getSkin().skinData.params.itemHeight
	
	window_:removeWidget(listBoxBuddy_)
	
	buddyWindow_		= BuddyWindow.new()
	buddyWindow_:setBuddyWidget(comboBoxFilename_)
	buddyWindow_:insertWidget(listBoxBuddy_)
	
	listBoxBuddy_:setPosition(0, 0)

	createFileFrid_()
	
	function listBoxBuddy_:onItemMouseDown()
		local item = self:getSelectedItem()
		
		if item then
			comboBoxFilename_:setText(item.text)
			comboBoxFilename_:setSelection(0, -1)
		end
		buddyWindow_:setVisible(false)
	end
	
	buddyWindow_:addKeyDownCallback(function(self, key, unicode)
		if 		'escape' == key then
			buddyWindow_:setVisible(false)
		elseif	'down' == key then
			local item = listBoxBuddy_:getSelectedItem()
			
			if item then
				local index = listBoxBuddy_:getItemIndex(item)
				
				listBoxBuddy_:selectItem(listBoxBuddy_:getItem(index + 1))
			else
				listBoxBuddy_:selectItem(listBoxBuddy_:getItem(0))
			end
		elseif	'up' == key then
			local item = listBoxBuddy_:getSelectedItem()
			
			if item then
				local index = listBoxBuddy_:getItemIndex(item)
				
				listBoxBuddy_:selectItem(listBoxBuddy_:getItem(index - 1))
			else
				listBoxBuddy_:selectItem(listBoxBuddy_:getItem(listBoxBuddy_:getItemCount() - 1))
			end
		elseif	'return' == key then	
			local item = listBoxBuddy_:getSelectedItem()
			
			if item then
				comboBoxFilename_:setText(item.text)
				comboBoxFilename_:setSelection(0, -1)
			end
			
			buddyWindow_:setVisible(false)	
		end
		
	end)
	
	function window_:onClose()
		saveFilesListInFile_()
		self:setVisible(false)
	end

	function pDown.buttonOk:onChange()
		onOkButton_()
	end

	function pDown.buttonCancel:onChange()
		setWarningText_()
		window_:close()
	end    

	window_:addHotKeyCallback('escape', pDown.buttonCancel.onChange)
	window_:addHotKeyCallback('return', pDown.buttonOk.onChange)
    window_:addHotKeyCallback('delete', deleteFile)

	function comboBoxFilename_:onChangeListBox()
		local filename = self:getSelectedItem():getText()

		onChangeListBox_(filename)
	end

	function comboBoxFilename_:onChangeEditBox()
		onChangeEditBox_()
		showHelperWindow()
	end

	createSelectFileBar_()

	function checkBoxRoot_:onChange()
		if self:getState() then
			rootPath_ = FileDialogUtils.getAbsolutePath(selectFileBar_:getPath())

			selectFileBar_:setPath(rootPath_, rootPath_)
			self:setText('Root is ' .. rootPath_)
			self:setTooltipText(rootPath_)
		else
			local path = selectFileBar_:getPath()

			rootPath_ = nil
			selectFileBar_:setPath(path)
			self:setText('Set current folder root')
			self:setTooltipText()
		end
	end

	fillListBoxLocations_()

	function comboListFilter_:onChange()
		onSelectFilter_(self:getSelectedItem().filterExtentions)
	end
	
	function cbMiniStyle:onChange()
		miniStyle = self:getState()
		updateMiniStyle()
	end

	window_:centerWindow()
	
	window_:addSizeCallback(windowSizeCallback)
end

function windowSizeCallback()
	updateSize()
end

function initSoundPlayer() -- для того чтобы редактор диалогов не падал
	SoundPlayer       = require('SoundPlayer')
	
	soundPlayer = SoundPlayer.new() 
	pSound = soundPlayer:getContainer()
    pDown:insertWidget(pSound)  
    soundPlayer:setBounds(140, 35, 300, 40)
	
	updateSize()
end	

local function setInitPath_(path)
	local filename
	local folder

	if path then 
		if FileDialogUtils.getFolderExists(path) then
			folder = path
		else
			folder = FileDialogUtils.extractFolderFromPath(path)

			if folder then
				if FileDialogUtils.getFolderExists(folder) then
					filename = FileDialogUtils.extractFilenameFromPath(path)
				else
					folder = nil
				end
			end
		end
	end

	if not folder then
		folder = FileDialogUtils.getAbsolutePath(FileDialogUtils.getCurrentDir())
	end

	if rootPath_ ~= folder then
		rootPath_ = nil
		checkBoxRoot_:setState(false)
	end

	selectFileBar_:setPath(folder, rootPath_)
	fileGrid_:setPath(folder)

	if filename then
		fileGrid_:selectRowText(filename)
		onSelectFile_(filename)
	end
end

function updateMiniStyle()	
	cbMiniStyle:setState(miniStyle)
	if miniStyle == true then
		listBoxLocations_:setVisible(true)
	else
		listBoxLocations_:setVisible(false)
		if typeFile == 'input' then		
			if not FileDialogUtils.getFolderExists(lfs.writedir() .. 'InputUserProfiles\\') then
				lfs.mkdir(lfs.writedir() .. 'InputUserProfiles\\')
			end
			setInitPath_(lfs.writedir() .. 'InputUserProfiles\\')
		elseif typeFile == 'track' then
			setInitPath_(_G.userFiles.userTrackPath)
		else
			setInitPath_(_G.userFiles.userMissionPath)
		end
		listBoxLocations_:selectItem(listBoxLocations_:getItem(0))
	end
	updateSize()	
end

function updateSize()
	local wWin, hWin = window_:getSize()
	local offsetY = 0
	local offsetYsw = 0
	
	if showRequiredModules == true then
		offsetY = 100
	end

	if staticWarning_:getEnabled() == true then
		offsetYsw = 20
	end
	
	if miniStyle == true then
		fileGrid_:setBounds(200, 47, wWin-24-190, hWin-173-offsetY-offsetYsw) ---684,650		
	else
		fileGrid_:setBounds(10, 47, wWin-24, hWin-173-offsetY-offsetYsw)
	end
	
	listBoxLocations_:setSize(175, hWin-173-offsetY-offsetYsw)
	pDown:setBounds(0, hWin-75-36-offsetY-offsetYsw, wWin, 195)
	comboListFilter_:setPosition(wWin-223, 0)
	pDown.buttonOk:setPosition(wWin-223, 41)
	pDown.buttonCancel:setPosition(wWin-115, 41)
	comboBoxFilename_:setSize(wWin-345,24)
	pModules:setBounds(0, 75+offsetYsw, wWin, 100)
	lbModules:setSize(wWin-30,62)
	
	fileGrid_:setSelectedFileVisible()

	fileGrid_:normalizeColumnsWidth()
end

local function compTable(value1, value2)
    return textutil.Utf8Compare(value1, value2)    
end

function fillRequiredModules(a_path)
	local desc, requiredModules = mod_dictionary.getMissionDescription(a_path,i18n.getLocale())
    
    local listRequiredModules = {}
	lbModules:clear()
    
    if requiredModules then
        for k,v in pairs(requiredModules) do
            table.insert(listRequiredModules, v)
        end
    end	
	
	table.sort(listRequiredModules, compTable)
	
	for k,v in ipairs(listRequiredModules) do		
		local item = ListBoxItem.new(modulesInfo.getModulDisplayNameByModulId(v))
		lbModules:insertItem(item)
	end
	
	return #listRequiredModules > 0
end

function updateRequiredModules()
	local filename = getFilename_()
	showRequiredModules = false
	if isModeSave_() == false and filename then
		local path = getFullPath_(filename)
		local ext = U.getExtension(filename)			
		local attributes = lfs.attributes(path)
		
		pModules:setVisible(false)		
		if attributes and path and (ext == 'miz' or ext == 'trk') then	
			if fillRequiredModules(path) == true then
				pModules:setVisible(true)
				showRequiredModules = true
			end	
		end
		updateSize()
	end
end

function updateStyle()
	style_ = "normal"
    
	if extentions_ then
		for i, extention in ipairs(extentions_) do
			local pattern = string.format('%%.%s$', extention) -- получаем строку вида %.ext$
            if string.match(pattern, '.miz') ~= nil or string.match(pattern, '.trk') ~= nil then
                style_ = "addMap"
            end
		end
	end
	return style_
end

function updateSoundPlayer()
	if pSound and soundPlayer then
		local filename = getFilename_()
		
		pSound:setVisible(false)
		
		if filename then			
			local path = getFullPath_(filename)
			local ext = U.getExtension(filename)			
			local attributes = lfs.attributes(path)
					
			if attributes and path and (ext == 'ogg' or ext == 'wav') then		
				soundPlayer:setPathSound(path)
				pSound:setVisible(true)
			end	
		end
	end
end

function create()
	createWindow_()
	miniStyle = MeSettings.getFileDialogMiniStyleParams() 
	loadFilesListFromFile_()
end

function show_(text, path, filters, a_preName)
	if not window_ then
		create()
	end

	result_ = nil
    
    if modeName_ == modeOpen() then
        fileGrid_:setVerifyTheatresFun(TheatreOfWarData.isEnableTheatre)
    else
        fileGrid_:setVerifyTheatresFun(nil)
    end   

	comboBoxFilename_:setText()
    setFilters(filters)
	loadFilesListFromFile_()
	miniStyle = MeSettings.getFileDialogMiniStyleParams() 
	setInitPath_(path)
	updateMiniStyle()
	window_:setText(text)
	updateSoundPlayer()
	window_.grid:setFocused(true)
	if a_preName then
		comboBoxFilename_:setText(a_preName)
		fileGrid_:selectRow(-1)
	end
	
	window_:centerWindow()
	window_:setVisible(true)	

	return result_
end

function open(path, filters, caption, a_typeFile)
	modeName_ = modeOpen()	

	typeFile = a_typeFile

	return show_(caption or cdata.openFile, path, filters)
end

function selectFolder(path, caption)
	modeName_ = modeSelectFolder()

	return show_(caption or cdata.selectFolder, path)
end

function save(path, filters, caption, a_typeFile, a_preName)
	modeName_ = modeSave()
	
	typeFile = a_typeFile

	return show_(caption or cdata.saveFile, path, filters, a_preName)
end

function close()
	if window_ then
		if msgWindowHandler_ then
			msgWindowHandler_:close()
		end
		
		window_:close()
	end
end

function setFilters(filters)
	filters = filters or {FileDialogFilters.all()}

	comboListFilter_:clear()

	for i, filter in ipairs(filters) do
		local filterName		= filter[1]
		local filterExtentions	= filter[2]
		local item				= ListBoxItem.new(filterName .. filterExtentions)

		item.filterExtentions = filterExtentions
		comboListFilter_:insertItem(item)

		if 1 == i then
			comboListFilter_:selectItem(item)
			onSelectFilter_(filterExtentions)
		end
	end
end

function onSelectFilter_(filterExtentions)
	extentions_ = getFilterExtentions_(filterExtentions)

	fileGrid_:setFilter(extentions_)
	selectFileBar_:setFilter(extentions_)
	updateStyle()
end
