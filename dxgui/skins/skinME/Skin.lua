local base = _G

module('Skin')

local error = base.error
local require = base.require
local pairs = base.pairs
local print = base.print
local loadfile = base.loadfile
local table = base.table
local type = base.type
local string = base.string

local Gui = require('dxgui')

Gui.AddFontSearchPathes({'dxgui/skins/fonts/', base.tostring(base.os.getenv('windir')) .. '/Fonts/'})

local func, err = loadfile('dxgui/skins/fonts/chinese_fonts_map.lua')

if func then
	Gui.SetChineseFontsMap(func())
else
	print(err)
end

local skinPath = './dxgui/skins/skinME/'

-- добавляем к пути поиска модулей путь к папке common
base.package.path = base.package.path .. ';./dxgui/skins/skinME/?.lua;./dxgui/skins/common/?.lua;'

local loadedSkins = {}

local function cloneTable(t)
	local result = {}

	for k, v in pairs(t) do
		if 'table' == type(v) then
			result[k] = cloneTable(v)
		else
			result[k] = v
		end
	end

	return result
end

local names = {}
local namesFilename = skinPath .. 'skin_names.lua'

function getSkinNames()
	return names
end

local function getFullSkinPath(filename)
	return skinPath .. filename
end

local errors = {}

local function loadSkin(filename)
	local fullPath = getFullSkinPath(filename)
	local result = loadedSkins[fullPath]

	if not result then
		local f, err = loadfile(fullPath)

		if f then
			result = f()

			if result and result.skinData.skins then
				for widgetName, widgetSkin in pairs(result.skinData.skins) do
					-- FIXME: remove
					if type(widgetSkin) == 'string' then
						result.skinData.skins[widgetName] = getSkin(widgetSkin)
					end
				end
			end

			loadedSkins[fullPath] = result
		else
			if not errors[err] then
				print('Cannot load skin:', err)
				errors[err] = true
			end
		end
	end

	return result
end

local function getLoadedSkin(filename)
	local result

	if filename then
		local skin = loadSkin(filename)

		if skin then
			result = cloneTable(skin)
		end
	end

	return result
end

local invalidSkinNames = {}
local invalidSkinFilenames = {}

function getSkin(name)
	local skinFilename = names[name]
	local result = getLoadedSkin(skinFilename)

	if result then
		result.skinData.params = result.skinData.params or {}
		result.skinData.params.name = name
	else
		local filename = base.tostring(skinFilename)
		local needPrint = false

		if not invalidSkinNames[name] then
			invalidSkinNames[name] = true
			needPrint = true
		end

		if not invalidSkinFilenames[filename] then
			invalidSkinFilenames[filename] = true
			needPrint = true
		end

		if needPrint then
			print('Cannot load skin[' .. name .. '] from file [' .. filename .. ']')
		end
	end

	return result
end

local function getSortedNames(names)
	local result = {}

	for name, filename in pairs(names) do
		table.insert(result, {name = name, filename = filename})
	end

	table.sort(result, function(t1, t2) return t1.name < t2.name end)

	return result
end

function saveSkinNames()
	local file, err = base.io.open(namesFilename, 'w')

	if file then
		local sortedNames = getSortedNames(names)

		for i, sortedName in pairs(sortedNames) do
			file:write(sortedName.name .. " = '" .. sortedName.filename .. "'\n")
		end
		file:close()
	else
		print('Error:' .. err)
	end
end

local function addSkinFunction(name)
	_M[name] = function() return getSkin(name) end
end

local function unloadSkins()
	for name, filename in pairs(names) do
		local fullPath = getFullSkinPath(filename)

		loadedSkins[fullPath] = nil
	end
end

function addSkinName(name, filename)
	-- измененный скин может повлиять на другие скины, 
	-- которые его содержат
	-- поэтому скины должны быть загружены заново
	unloadSkins()
	names[name] = filename
	addSkinFunction(name)
	saveSkinNames()
end

local function loadSkinNamesFromFile()
	local f, err = loadfile(namesFilename)

	if f then
		base.setfenv(f, names)
		f()
	else
		print('Cannot load ' .. namesFilename .. '!')
	end
end

local function loadSkinNames()
	for name, filename in pairs(names) do
		addSkinFunction(name)
	end
end

loadSkinNamesFromFile()
loadSkinNames()