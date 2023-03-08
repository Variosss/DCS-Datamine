dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/HUD_AVQ32/indicator/HUD_page_defs.lua")

-- break-X
local BreakXLineLen = 220
local BreakXLineAngle = 25
addPlaceholder("Break_X", {0, 0}, nil, {{"HideElement"}})

-- Why four lines?
addStrokeLine("Break_X_Line_1", BreakXLineLen, {0, 0}, BreakXLineAngle, "Break_X")
addStrokeLine("Break_X_Line_2", BreakXLineLen, {0, 0}, -BreakXLineAngle, "Break_X")
addStrokeLine("Break_X_Line_3", BreakXLineLen, {0, 0}, 180 - BreakXLineAngle, "Break_X")
addStrokeLine("Break_X_Line_4", BreakXLineLen, {0, 0}, 180 + BreakXLineAngle, "Break_X")
