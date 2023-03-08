-- этот модуль сделан для того, 
-- чтобы вызываться один раз 
-- либо в MissionEditor.lua, 
-- либо в GameGUI.lua
local Gui = require('dxgui')

Gui.AddFontSearchPathes({'dxgui/skins/fonts/', tostring(os.getenv('windir')) .. '/Fonts/'})

local func, err = loadfile('./dxgui/skins/fonts/chinese_fonts_map.lua')

if func then
	Gui.SetChineseFontsMap(func())
else
	print(err)
end

return
{
}