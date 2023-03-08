dofile(LockOn_Options.script_path.."Displays/HUD/indicator/HUD_Page_defs.lua")

local horizontalLineLenght 	= DegToMil(7.5)
local verticalLineLenght 	= DegToMil(13.6)

local HUD_aligment_cross = addPlaceholder("HUD_aligment_cross_PH", nil, nil)
	addStrokeLine("HUD_aligment_cross_horizontal_line", horizontalLineLenght, {-horizontalLineLenght/2, 0}, -90, HUD_aligment_cross.name)
	addStrokeLine("HUD_aligment_cross_vertical_line"  , verticalLineLenght  , {0, -DegToMil(7)}, 0, HUD_aligment_cross.name)