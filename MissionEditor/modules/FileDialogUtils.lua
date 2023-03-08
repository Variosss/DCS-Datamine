module('FileDialogUtils', package.seeall)

lfs = require('lfs')
Align = require('Align')
Picture = require('Picture')
Rect = require('Rect')
Insets = require('Insets')

local fileItemSkin_
local folderItemSkin_
local driveItemSkin_

function getFolderType()
	return 'folder'
end

function getFileType()
	return 'file'
end

function getDriveType()
	return 'drive'
end

local function getListBoxItemPicture_(x1, y1, x2, y2)
	local filename = './dxgui/skins/skinME/images/btn-tools-01.png'
	local color = '0xffffffff'
	local horzAlign = Align.new(Align.min, 4)
	local vertAlign = nil
	local size = nil
	local rect = Rect.new(x1, y1, x2, y2)
	local userTexSampler = nil
	local resizeToFill = false
	
	return Picture.new(filename, color, horzAlign, vertAlign, size, rect, userTexSampler, resizeToFill)
end

local function getListBoxItemSkin_(picture)
	local result = Skin.listBoxItemSkin()
	
	result.skinData.params.insets = Insets.new(0, 8, 0, 0)
	
	local states = result.skinData.states
	
	states.released[1].picture = picture
	states.released[2].picture = picture
	states.hover[1].picture = picture
	
	return result
end

function getFilePicture()
	return getListBoxItemPicture_(123, 205, 131, 216)
end

local function getFileItemSkin_()
	if not fileItemSkin_ then
		fileItemSkin_ = getListBoxItemSkin_(getFilePicture())
	end
	
	return fileItemSkin_
end

local function getFolderPicture()
	return getListBoxItemPicture_(90, 205, 103, 216)
end

function getFolderItemSkin()
	if not folderItemSkin_ then
		folderItemSkin_ = getListBoxItemSkin_(getFolderPicture())
	end
	
	return folderItemSkin_
end

function getDrivePicture()
	return getListBoxItemPicture_(16, 205, 29, 216)
end

function getDriveItemSkin()
	if not driveItemSkin_ then
		driveItemSkin_ = getListBoxItemSkin_(getDrivePicture())
	end
	
	return driveItemSkin_
end 

function getListBoxItemSkin(type)
	if getFolderType() == type then
		return getFolderItemSkin()
	elseif getFileType() == type then
		return getFileItemSkin_()
	elseif getDriveType() == type then
		return getDriveItemSkin()
	end	
end

function getDrives()
	local result = {}
	local locations = lfs.locations()
	
	for i, location in ipairs(locations) do
		-- убираем лишний символ \
		result[i] = string.sub(location.path, 1, -2)
	end
	
	return result
end

function compareStrings(string1, string2)
	return string.lower(string1) < string.lower(string2)
end

function getPathFoldersAndFiles(path)
	local files = {}
	local folders = {}
	
	for file in lfs.dir(path) do
		if '.' ~= file and '..' ~= file then
			local filePath = path	.. '\\' .. file
			local attrib = lfs.attributes(filePath)
			
			if attrib then
				if 'file' == attrib.mode then
					table.insert(files, file)
				elseif 'directory' == attrib.mode then
					table.insert(folders, file)				
				end
			end
		end
	end
	
	table.sort(files, compareStrings)
	table.sort(folders, compareStrings)

	return folders, files
end

function splitPath(path) 
	local result = {}
	
	for item in string.gmatch(path, "[^\\/]+") do
		table.insert(result, item)
	end
	
	return result
end	

function extractFilenameFromPath(path)
	return string.match(path, '.*[/\\](.*)$')
end

function extractFolderFromPath(path)
	return string.match(path, '(.*)[/\\].*$')
end

function getFilenameIsAbsolutePath(filename)
	return nil ~= string.match(filename, '%a:\\')
end

function getFilenameRelativePath(filename, folder)
	local pattern = '(.*)' .. string.lower(folder) .. '\\*/*(.*)'
	local repl = '%2'

	return string.gsub(string.lower(filename), pattern, repl)
end

function getCurrentDir()
	return lfs.currentdir()
end

function getAbsolutePath(path)
	if string.match(path, '%a:') then
		-- это диск
		return path
	end
	
	return lfs.realpath(path)
end

function getFileExists(filename)
	local attributes = lfs.attributes(filename)
	
	return attributes and 'file' == attributes.mode
end

function getFolderExists(filename)
	local attributes = lfs.attributes(filename)
	
	return attributes and 'directory' == attributes.mode
end

function getFilenameContainsProhibitedSymbols(filename)
	return nil ~= string.find(filename, '[%*/%?<>%|%\\%:"]')
end

function getDiskExists(filename)
	local result = false
	local drives = getDrives()
	
	for i, drive in ipairs(drives) do
		if drive == string.upper(filename) then
			result = true
			
			break
		end
	end
	
	return result
end

function getFilenameIsValid(filename)
	local result = false
	
	if filename and '' ~= filename then
		local items = splitPath(filename)
		local count = #items
		
		result = getDiskExists(items[1])
		
		if result then
			for i = 2, count do
				if getFilenameContainsProhibitedSymbols(items[i]) then
					result = false
					
					break
				end
			end
		end
	end
	
	return result
end

function cropRootPath(path, rootPath)
	local result = path
	
	if rootPath then
		local pos = string.find(path, rootPath)
		
		if pos then
			-- +1 для символа '/' и +1 для индекса символа стоящего за rootPath
			result = string.sub(path, string.len(rootPath) + 2) 
		end
	end
	
	return result
end