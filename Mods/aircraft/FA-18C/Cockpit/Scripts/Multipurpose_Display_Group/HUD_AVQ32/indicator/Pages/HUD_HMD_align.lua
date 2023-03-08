dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/HUD_AVQ32/indicator/HUD_page_defs.lua")

local horizontalLineLenght 	= DegToDI(10)
local verticalLineLenght 	= DegToDI(13.6)

local HUD_aligment_cross = addPlaceholder("HUD_aligment_cross_PH", nil, nil)
	addStrokeLine("HUD_aligment_cross_horizontal_line", horizontalLineLenght, {-horizontalLineLenght/2, DegToDI(4.5)}, -90, HUD_aligment_cross.name)
	addStrokeLine("HUD_aligment_cross_vertical_line"  , verticalLineLenght  , {0, -DegToDI(5)}, 0, HUD_aligment_cross.name)