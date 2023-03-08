dofile(LockOn_Options.common_script_path.."elements_defs.lua")
dofile(LockOn_Options.script_path.."../../Common/symbology_generic_tools.lua")

collimated 							= false
INDICATOR_DEFAULT_LEVEL 			= 7

-- texture resolution			
texture_resolution 					= 512
 
-- pixels per 1 screen unit
pixelsPerUnit 						= 512

SetScale(FOV)

dbg_marker_span						= 0.1
additive_alpha						= false

-- Base horizontal font size in screen units.
baseFontSizeScrU_X   	= 0.19

-- The font size 'number' corresponds to it's relative size to the base horizonal one. Greater number means larger font.
-- Sizes are described in the order of dependence from each other.

-- Size 2 (base)
FontSizeX2		= baseFontSizeScrU_X * GetScale()
FontSizeY2		= FontSizeX2

-- Size 1 (small)
FontSizeX1		= FontSizeX2 * 0.7
FontSizeY1		= FontSizeX1

font_1_interchar  = 0.02
font_2_interchar  = 0.0

font_1_interline  = -0.01
font_2_interline  = -0.03

predefined_font_1 = {FontSizeX1, FontSizeY1, font_1_interchar * GetScale(), font_1_interline * GetScale()}
predefined_font_2 = {FontSizeY2, FontSizeX2, font_2_interchar * GetScale(), font_2_interline * GetScale()}

function selectFont(size)
	if size ~= nil then
		if size == 1 then
			return predefined_font_1
		else
			return predefined_font_2
		end
	else
		return predefined_font_2
	end

end

local displAreaRadius								= 1

function makeDispArea(numOfPoints)
	local area		  	  							= CreateElement "ceMeshPoly"
	area.collimated	  								= collimated
	area.vertices        							= makeEllipseVerts(numOfPoints, displAreaRadius, 1)
	area.indices 									= buildConvexPolyIndices(numOfPoints)
	
	return area
end

if omitBoresightPosControllers ~= true then
	boresightPos = addPlaceholder__Raw("Boresight_Pos", {0, 0}, {{"boresight_pos"}}, false)
else
	boresightPos = addPlaceholder__Raw("Boresight_Pos", {0, 0}, nil, false)
end

dofile(LockOn_Options.script_path.."../../Common/symbology_tight_tools.lua")

function ALR_300_AddText(name, controllers, init_pos, level, size)
	local txt = AddText(name, controllers, init_pos, level, size)
	txt.material = "FONT_ALR_300_GREEN"
	return txt
end

function ALR_300_AddText_Pos(name, controllers, init_pos, level, pos, size)
	local txt = AddText_Pos(name, controllers, init_pos, level, pos, size)
	txt.material = "FONT_ALR_300_GREEN"
	return txt
end

function ALR_300_AddText_Pos_Val(name, controllers, init_pos, level, pos, value, size)
	local txt = AddText_Pos_Val(name, controllers, init_pos, level, pos, value, size)
	txt.material = "FONT_ALR_300_GREEN"
	return txt
end

function ALR_300_AddText_Pos_Formats(name, controllers, init_pos, level, pos, formats, size)
	local txt = AddText_Pos_Formats(name, controllers, init_pos, level, pos, formats, size)
	txt.material = "FONT_ALR_300_GREEN"
	return txt
end

function ALR_300_AddTexuredElement(name, vertices, tex_params, controllers, init_pos, init_rot, level)
	local element = AddTexuredElement(name, vertices, tex_params, controllers, init_pos, init_rot, level)
	element.material = "SYMB_ALR_300_GREEN"
	return element
end
