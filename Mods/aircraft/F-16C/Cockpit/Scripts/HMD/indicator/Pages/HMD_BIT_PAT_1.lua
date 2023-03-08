dofile(LockOn_Options.script_path.."HMD/indicator/HMD_Page_defs.lua")

addStrokeCircle("HMD_BIT_PATTERN_1_circle_", DegToMil(10), {0,0})

local lineLength	= DegToMil(20)
local linePos		= DegToMil(10)

for i = 0, 1 do
	addStrokeLine("HMD_BIT_PATTERN_1_line"..i, lineLength, {-linePos * i, -linePos * (1-i)}, -90 * i)
end

local tickLength	= DegToMil(2.5)
local tickStep		= DegToMil(2.5)
local tickPos		= tickLength * 0.5

for i = -4, 4 do
	addStrokeLine("HMD_BIT_PATTERN_1_vtick"..i, tickLength, {i * tickStep, -tickPos}, 0)
	addStrokeLine("HMD_BIT_PATTERN_1_htick"..i, tickLength, {-tickPos, i * tickStep}, -90)
end

local boxSize	= DegToMil(2)
local boxPos	= DegToMil(5)

addStrokeBox("HMD_BIT_PATTERN_1_box".. 1, boxSize, boxSize, "CenterCenter", {-boxPos,  boxPos})
addStrokeBox("HMD_BIT_PATTERN_1_box".. 2, boxSize, boxSize, "CenterCenter", { boxPos,  boxPos})
addStrokeBox("HMD_BIT_PATTERN_1_box".. 3, boxSize, boxSize, "CenterCenter", { boxPos, -boxPos})
addStrokeBox("HMD_BIT_PATTERN_1_box".. 4, boxSize, boxSize, "CenterCenter", {-boxPos, -boxPos})

local labelStep	= DegToMil(5)
local labelPosY	= DegToMil(1.3)
local labelPosX	= DegToMil(1.3)

for i = -2, 2 do
	if i == 0 then
		addStrokeText("HMD_BIT_PATTERN_1_hlabel"..i, "0.0", STROKE_FNT_DFLT_150, "LeftBottom", {DegToMil(0.1), labelPosY})
	else
		addStrokeText("HMD_BIT_PATTERN_1_hlabel"..i, 400 * i, STROKE_FNT_DFLT_150, "CenterBottom", {labelStep * i, labelPosY})
	end
end

for i = -1, 1, 2 do
	addStrokeText("HMD_BIT_PATTERN_1_vlabel"..i, 400 * i, STROKE_FNT_DFLT_150, "LeftCenter", {labelPosX, labelStep * i})
end

addStrokeText("HMD_BIT_PATTERN_1_text", "STROKE", STROKE_FNT_DFLT_150, "CenterCenter", {-2*tickStep, tickStep})
