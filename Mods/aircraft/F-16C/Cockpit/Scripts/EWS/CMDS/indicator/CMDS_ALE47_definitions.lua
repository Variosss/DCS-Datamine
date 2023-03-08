dofile(LockOn_Options.common_script_path.."elements_defs.lua")

-- definitions
ALE47_CM_Type =
{
	CHAFF	= 0,
	FLARE	= 1,
	OTHER1	= 2,
	OTHER2	= 3,
	ALL		= 4,
}

-- sizes
local W = 0.0428006575 * 2
local pixel_size = W / 97

local char_w = pixel_size * 5
local char_h = pixel_size * 7
local char_aspect = char_h / char_w
local char_space = pixel_size
local line_space = pixel_size

local font_CMDS_stringdefs = { char_h, char_w, char_space, line_space }

local char_num = 16
local CMDS_size_x = char_w * char_num + char_space * (char_num + 1)
local CMDS_size_y = char_h + line_space * 2
local CMDS_size_x_05 = CMDS_size_x * 0.5
local CMDS_size_y_05 = CMDS_size_y * 0.5

local x0 = -CMDS_size_x_05
local y0 = CMDS_size_y_05

-- functions
local function get_x(column)
	return x0 + char_w * column + char_space * (column + 1)
end

function addText(name, text, column, controllers, parent, formats)
	local elem			= CreateElement "ceStringPoly"
	elem.name			= name
	elem.material		= "font_CMDS"
	elem.init_pos		= {get_x(column), y0, 0}
	elem.alignment		= "LeftTop"
	elem.stringdefs		= font_CMDS_stringdefs
	elem.value			= text
	elem.controllers	= controllers
	elem.formats		= formats
	elem.parent_element	= parent
	elem.use_mipfilter	= true

	Add(elem)
	return elem
end
