dofile(LockOn_Options.script_path.."HMD/indicator/HMD_Page_defs.lua")

local lineLength	= DegToMil(9)

for i = 0, 2 do
	addStrokeLine("HMD_BIT_PATTERN_3_line"..i, lineLength, {0, 0}, -90 + 120 * i)
end