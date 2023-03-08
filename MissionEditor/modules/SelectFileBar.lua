local base = _G

module('SelectFileBar')
mtab = { __index = _M }

local require = base.require
local ipairs = base.ipairs
local table = base.table
local string = base.string
local print = base.print

local DialogLoader = require('DialogLoader')
local Factory = require('Factory')
local FileDialogUtils = require('FileDialogUtils')
local Button = require('Button')
local ComboList = require('ComboList')
local ListBoxItem = require('ListBoxItem')

local widgetHeight_ = 20
local comboListWidth_ = 7
local comboListSkin_
local buttonSkin_
local listBoxItemFolderSkin_
local listBoxItemFileSkin_
local listBoxItemDriveSkin_

local function fileType() return 'file' end
local function folderType() return 'folder' end
local function driveType() return 'folder' end

local function getListBoxItemSkin_(type)
	if fileType() == type then
		return listBoxItemFileSkin_
	elseif 	folderType() == type then
		return listBoxItemFolderSkin_
	elseif driveType() == type then
		return listBoxItemDriveSkin_
	end	
end

function new()
	return Factory.create(_M)
end

function construct(self)
	local window = DialogLoader.spawnDialogFromFile('MissionEditor/modules/dialogs/select_file_bar.dlg')
	self.panel = window.panel
	self.items = {}
	
	buttonSkin_ = window.button:getSkin()
	comboListSkin_ = window.comboList:getSkin()
	listBoxItemFolderSkin_ = window.listBoxItemFolder:getSkin()
	listBoxItemFileSkin_ = window.listBoxItemFile:getSkin()
	listBoxItemDriveSkin_ = window.listBoxItemDrive:getSkin()

	self:addItem('Disks', nil, {}, {}, FileDialogUtils.getDrives())
	self:updateWidgets()
	
	window:removeWidget(self.panel)
	window:kill()
end

function getPanel(self)
	return self.panel
end

function updateWidgets(self)
	local panel = self.panel
	local items = self.items
	
	panel:removeAllWidgets()

	local count = #items

	for i, item in ipairs(items) do
		panel:insertWidget(item.button)
		panel:insertWidget(item.comboList)
	end
end

local function removeItem_(item)
	item.button:destroy()
	item.comboList:destroy()
end

function removeItemsTillName(self, name)
	local items = self.items
	
	for i = #items, 1, -1 do
		local item = items[i]

		if item.name == name then 
			break
		else
			removeItem_(item)
			table.remove(items, i)
		end
	end

	self:updateWidgets()
end

local function getItemNameValid_(itemName, type, filter)
	if fileType() == type then
		if filter then
			for i, pattern in ipairs(filter) do
				if string.find(itemName, pattern) then
					return true
				end
			end
			
			return false
		end
	end
	
	return true
end

local function addItemsToComboList_(comboList, items, type, filter)
--[[	for i, item in ipairs(items) do
		if getItemNameValid_(item, type, filter) then
			local listBoxItem = ListBoxItem.new(item)
			
			listBoxItem:setSkin(getListBoxItemSkin_(type))

			listBoxItem.file = item
			listBoxItem.type = type

			comboList:insertItem(listBoxItem)
		end
	end]]
end

local function addFoldersToComboList_(comboList, folders)
	addItemsToComboList_(comboList, folders, folderType())
end

local function addFilesToComboList_(comboList, files, filter)
	addItemsToComboList_(comboList, files, fileType(), filter)
end

local function addDrivesToComboList_(comboList, drives)
	addItemsToComboList_(comboList, drives, driveType())
end

function addItem(self, name, path, folders, files, drives)
	local button = Button.new(name)

	button:setSkin(buttonSkin_)

	local w, h = button:calcSize()

	button:setSize(w, h)

	local selectFileBar = self

	function button:onChange()
		selectFileBar:removeItemsTillName(name)
		selectFileBar:onSelectFolder(path)
	end

	local comboList = ComboList.new()

	comboList:setSkin(comboListSkin_)
	
	addFoldersToComboList_(comboList, folders)
	addFilesToComboList_(comboList, files, self.filter)
	addDrivesToComboList_(comboList, drives)


	function comboList:onChange(item)
		selectFileBar:removeItemsTillName(name)

		if folderType() == item.type or driveType() == item.type then
			selectFileBar:addFolder(item.file)
			selectFileBar:onSelectFolder(path .. '\\' .. item.file)
		else
			selectFileBar:updateWidgets()
			selectFileBar:onSelectFile(path, item.file)
		end
	end

	table.insert(self.items, {name = name, path = path, folders = folders, files = files, drives = drives, button = button, comboList = comboList})
end

function setPath(self, path, root)
	self.items = {}

	if root and FileDialogUtils.getFolderExists(root) then
		local currFolders, currFiles = FileDialogUtils.getPathFoldersAndFiles(root)

		self:addItem('.', root, currFolders, currFiles, {})
		path = FileDialogUtils.cropRootPath(path, root)
		root = root .. '\\'
	else
		root = ''
	end

	local folders = FileDialogUtils.splitPath(path)
	local currPath

	for i, folder in ipairs(folders) do
		if currPath then
			currPath = currPath .. '\\' .. folder
		else
			currPath = folder
		end

		if FileDialogUtils.getFolderExists(root .. currPath) then
			local currFolders, currFiles = FileDialogUtils.getPathFoldersAndFiles(root .. currPath)

			self:addItem(folder, root .. currPath, currFolders, currFiles, {})
		else
			break
		end
	end

	self:updateWidgets()
end

function getPath(self)
	local result
	local lastItem = self.items[#self.items]

	if lastItem then
		result = lastItem.path
	end

	return result
end

function addFolder(self, folder)
	local path = self:getPath()
	
	if path then
		path = path .. '\\' .. folder
	else
		path = folder
	end
	local folders, files = FileDialogUtils.getPathFoldersAndFiles(path)
	
	self:addItem(folder, path, folders, files, {})
	self:updateWidgets()
end

function removeFolder(self)
	if #self.items > 1 then
		table.remove(self.items)
		self:updateWidgets()
	end
end

-- extentions = это таблица с расширениями файлов {'exe', 'miz'} или nil
function setFilter(self, extentions)
	self.filter = nil
	
	if extentions then
		self.filter = {}
		
		for i, extention in ipairs(extentions) do
			local pattern = string.format('%%.%s$', extention) -- получаем строку вида %.ext$
			
			table.insert(self.filter, pattern)
		end
	end
	
	for i, item in ipairs(self.items) do	
		local comboList = item.comboList
		
		comboList:clear()
		
		addFoldersToComboList_(comboList, item.folders)
		addFilesToComboList_(comboList, item.files, self.filter)
		addDrivesToComboList_(comboList, item.drives)
	end
end

function onSelectFolder(self, path)
	print('Folder selected!', path)
end

function onSelectFile(self, path, filename)
	print('File selected!', path, filename)
end