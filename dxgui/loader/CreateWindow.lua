package.path =	'./dxgui/bind/?.lua;' .. 
				'./dxgui/loader/?.lua;' .. 
				'./dxgui/skins/skinME/?.lua;' .. 
				'./dxgui/skins/common/?.lua;' ..
				'./Scripts/?.lua;'

-- 	filename, windowPtr передаются из симулятора
local filename, windowPtr = ...

local DialogLoader	= require('DialogLoader')

if windowPtr then
	DialogLoader.loadDialogFromFile(filename, windowPtr)
else
	local window = DialogLoader.spawnDialogFromFile(filename)

	return window.widget
end

