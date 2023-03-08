dofile(LockOn_Options.script_path.."HMD/indicator/HMD_Page_defs.lua")

addStrokeCircle("HMD_BIT_PATTERN_4_circle_"..2,  DegToMil(2),  {0,0})
addStrokeCircle("HMD_BIT_PATTERN_4_circle_"..6,  DegToMil(6),  {0,0})
addStrokeCircle("HMD_BIT_PATTERN_4_circle_"..9,  DegToMil(9),  {0,0})
addStrokeCircle("HMD_BIT_PATTERN_4_circle_"..10, DegToMil(10), {0,0})

local lineLength	= DegToMil(20)
local linePos		= DegToMil(10)
local dAngle		= 45
local dAngleRad		= math.rad(dAngle)

for i = 0, 3 do
	addStrokeLine("HMD_BIT_PATTERN_4_line"..i, lineLength, {-linePos * math.sin(dAngleRad * i), -linePos * math.cos(dAngleRad * i)}, -dAngle * i)
end