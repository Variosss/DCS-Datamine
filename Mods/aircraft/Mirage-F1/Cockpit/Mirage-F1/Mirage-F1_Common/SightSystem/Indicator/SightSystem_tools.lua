dofile(LockOn_Options.script_path.."../../Mirage-F1/Mirage-F1_Common/SightSystem/Indicator/SightSystem_definitions.lua")

SetScale(MILLYRADIANS)

line1_HalfWidth 		= 1.3
line2_HalfWidth 		= 1.1
line3_HalfWidth			= 0.9
line4_HalfWidth			= 0.85

-- Base horizontal font size in milliradians.
baseFontSizeMil_X   = 5.2

-- The font size 'number' corresponds to it's relative size to the base horizonal one. Greater number means larger font.
-- Sizes are described in the order of dependence from each other.

-- Size 2 (base)
FontSizeX2		= baseFontSizeMil_X * GetScale()
FontSizeY2		= FontSizeX2

-- Size 3 (x-condensed base)
FontSizeX3		= FontSizeX2
FontSizeY3		= FontSizeX3

-- Size 1 (small)
FontSizeX1		= FontSizeX2 * 0.9
FontSizeY1		= FontSizeX1

-- Size 0 (tiny)
FontSizeX0		= FontSizeX2 * 0.8
FontSizeY0		= FontSizeX0

font_0_interchar  = 2.2
font_2_interchar  = 0.5
font_3_interchar  = -0.07

predefined_font_0 = {FontSizeX0, FontSizeY0, font_0_interchar * GetScale(), 0}
predefined_font_1 = {FontSizeX1, FontSizeY1, 0, 0}
predefined_font_2 = {FontSizeY2, FontSizeX2, font_2_interchar * GetScale(), 0}
predefined_font_3 = {FontSizeY3, FontSizeX3, font_3_interchar * GetScale(), 0}

function selectFont(size)
	if size ~= nil then
		if size == 0 then
			return predefined_font_0
		elseif size == 1 then
			return predefined_font_1
		elseif size == 3 then
			return predefined_font_3
		else
			return predefined_font_2
		end
	else
		return predefined_font_1
	end

end

boresightPos = addPlaceholder__Raw("Boresight_Pos", {0, radarDatumPosY}, {{"boresight_pos"}}, collimated)

dofile(LockOn_Options.script_path.."../../Common/symbology_tight_tools.lua")

SIGHT_COLOR_WHITE	= 1
SIGHT_COLOR_RED		= 2
SIGHT_COLOR_GREEN	= 3
SIGHT_COLOR_BLUE	= 4
SIGHT_COLOR_AMBER	= 5

function selectFontColor(txt, color)
	if color == SIGHT_COLOR_WHITE then
		txt.material = "FONT_SIGHT_SYSTEM_WHITE"
	elseif color == SIGHT_COLOR_RED then
		txt.material = "FONT_SIGHT_SYSTEM_RED"
	elseif color == SIGHT_COLOR_GREEN then
		txt.material = "FONT_SIGHT_SYSTEM_GREEN"
	elseif color == SIGHT_COLOR_BLUE then
		txt.material = "FONT_SIGHT_SYSTEM_BLUE"
	elseif color == SIGHT_COLOR_AMBER then
		txt.material = "FONT_SIGHT_SYSTEM_AMBER"
	else
		txt.material = "FONT_SIGHT_SYSTEM_GREEN"
	end
end

function selectTexColor(element, color)
	if color == SIGHT_COLOR_WHITE then
		element.material = "SYMB_SIGHT_SYSTEM_WHITE"
	elseif color == SIGHT_COLOR_RED then
		element.material = "SYMB_SIGHT_SYSTEM_RED"
	elseif color == SIGHT_COLOR_GREEN then
		element.material = "SYMB_SIGHT_SYSTEM_GREEN"
	elseif color == SIGHT_COLOR_BLUE then
		element.material = "SYMB_SIGHT_SYSTEM_BLUE"
	elseif color == SIGHT_COLOR_AMBER then
		element.material = "SYMB_SIGHT_SYSTEM_AMBER"
	else
		element.material = "SYMB_SIGHT_SYSTEM_GREEN"
	end
end

function SightAddText(name, controllers, init_pos, level, size, color)
	local txt = AddText(name, controllers, init_pos, level, size)
	selectFontColor(txt, color)
	return txt
end

function SightAddText_Pos(name, controllers, init_pos, level, pos, size, color)
	local txt = AddText_Pos(name, controllers, init_pos, level, pos, size)
	selectFontColor(txt, color)
	return txt
end

function SightAddText_Pos_Val(name, controllers, init_pos, level, pos, value, size, color)
	local txt = AddText_Pos_Val(name, controllers, init_pos, level, pos, value, size)
	selectFontColor(txt, color)
	return txt
end

function SightAddText_Pos_Formats(name, controllers, init_pos, level, pos, formats, size, color)
	local txt = AddText_Pos_Formats(name, controllers, init_pos, level, pos, formats, size)
	selectFontColor(txt, color)
	return txt
end

function SightAddTexuredElement(name, vertices, tex_params, controllers, init_pos, init_rot, level, color)
	local element = AddTexuredElement(name, vertices, tex_params, controllers, init_pos, init_rot, level)
	selectTexColor(element, color)
	return element
end

-- The line zero starts at the left edge. Thus the line is directed to the right by default.
function SightAddLine(name, length, tex_params, controllers, init_pos, init_rot, level, size, color)
	
	local line_HalfWidth
	
	if size == 1 then
		line_HalfWidth = line1_HalfWidth
	elseif size == 2 then
		line_HalfWidth = line2_HalfWidth
	elseif size == 3 then
		line_HalfWidth = line3_HalfWidth
	elseif size == 4 then
		line_HalfWidth = line4_HalfWidth
	else
		line_HalfWidth = line3_HalfWidth
	end

	local verts = {{-line_HalfWidth, -line_HalfWidth},
		{-line_HalfWidth, line_HalfWidth},
		{length + line_HalfWidth, line_HalfWidth},
		{length + line_HalfWidth, -line_HalfWidth}}

	local element = AddTexuredElement(name, verts, tex_params, controllers, init_pos, init_rot, level)
	selectTexColor(element, color)
	
	return element
end

function make2milCentralDot(name, color)
	-- 2 mrad diameter
	local centralDotHalfWidth 						= 1.7
	local centralDotVerts 							=
		{{-centralDotHalfWidth, -centralDotHalfWidth},
		 {-centralDotHalfWidth, centralDotHalfWidth},
		 {centralDotHalfWidth, centralDotHalfWidth},
		 {centralDotHalfWidth, -centralDotHalfWidth}}
		 
	return SightAddTexuredElement(name, centralDotVerts, getTexParams(950, 60), nil, nil, nil, nil, color)
end
