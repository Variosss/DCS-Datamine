dofile(LockOn_Options.script_path.."HMD/indicator/HMD_Page_defs.lua")

local lineLength	= DegToMil(20)
local linePos		= DegToMil(10)
local step			= DegToMil(2.5)

for i = 0, 8 do
	addStrokeLine("HMD_BIT_PATTERN_2_vline"..i, lineLength, {(i-4) * step, -linePos}, 0)
	addStrokeLine("HMD_BIT_PATTERN_2_hline"..i, lineLength, {-linePos, (i-4) * step}, -90)
end
