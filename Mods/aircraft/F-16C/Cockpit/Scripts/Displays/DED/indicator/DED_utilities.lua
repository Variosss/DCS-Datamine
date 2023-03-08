dofile(LockOn_Options.common_script_path.."elements_defs.lua")


local pixel_size = 0.078994 / 192.0

local char_w = pixel_size * 8 * 2
local char_h = pixel_size * 13
local char_aspect = char_h / char_w

local char_space = pixel_size * -8
local line_space = pixel_size * 0--2

local font_DED_stringdefs = { char_h, char_w, char_space, line_space }

local lines_num = 5
local columns_num = 24

local DED_size_x = char_w * columns_num + char_space * (columns_num - 1)
local DED_size_y = char_h * lines_num + line_space * (lines_num - 1)

local DED_size_x_05 = DED_size_x * 0.5
local DED_size_y_05 = DED_size_y * 0.5

local x0 = -DED_size_x_05
local y0 = DED_size_y_05

local function get_x(column)
	return x0 + char_w * column + char_space * column
end

local function get_y(line)
	return y0 - char_h * line - line_space * line
end


-- placeholder without pos
local function addPlaceholder(name, parent, controllers)
	local placeholder			= CreateElement "ceSimple"
	placeholder.name			= name
	placeholder.init_pos		= {0, 0, 0}
	placeholder.collimated		= collimated or false

	if parent ~= nil then
		placeholder.parent_element	= parent
	end	
	
	if controllers ~= nil then
		placeholder.controllers		= controllers
	end
	
	Add(placeholder)
	return placeholder
end

function addLocalPlaceholder(name, parent, controllers)
	local placeholder = addPlaceholder(name, parent, controllers)
	return placeholder
end

-- pos = { column, line }
local function addSimpleText(name, text, pos, inv, parent, controllers, formats)
	local elem			= CreateElement "ceStringPoly"

	local line = pos[2]
	local column = pos[1]

	local font_material = "font_DED"
	if inv == true then
		font_material = "font_DED_inv"
	end

	elem.name			= name
	elem.material		= font_material
	elem.init_pos		= {get_x(column), get_y(line), 0}
	elem.alignment		= "LeftTop"
	elem.stringdefs		= font_DED_stringdefs
	elem.value			= text
	elem.controllers	= controllers
	elem.formats		= formats
	elem.parent_element	= parent
	elem.use_mipfilter	= true
	elem.additive_alpha	= true

	Add(elem)
	return elem
end

function addText(name, text, pos, inv, parent, controllers, formats)
	text = text or ""

	if type(inv) == "table" then
		--local controller_true = {inv[1], 1, inv[2]}
		--local controller_false = {inv[1], 0, inv[2]}

		inv[#inv + 1] = 1
		local placeholder_inv = addPlaceholder(name.."_placeholder_inv", parent, {inv})
		addSimpleText(name.."_inv", text, pos, true, placeholder_inv.name, controllers, formats)
		
		inv[#inv] = 0
		local placeholder = addPlaceholder(name.."_placeholder", parent, {inv})
		addSimpleText(name, text, pos, false, placeholder.name, controllers, formats)
	else
		addSimpleText(name, text, pos, inv, parent, controllers, formats)
	end
end


function addAsteriscs(name, pos, length, parent, controllers)
	local line = pos[2]
	local column = pos[1]
	local pos_right = { column + length + 1, line }

	addText(name.."_lhs", "*", pos, true, parent, controllers)
	addText(name.."_rhs", "*", pos_right, true, parent, controllers)
end


function addBigOFF(name, pos, controllers)
	local line = pos[2]
	local column = pos[1]

	local tex_coords = {	{16/256,	16/256},
							{200/256,	16/256},
							{200/256,	88/256},
							{16/256,	88/256}	}

	local w = pixel_size * 6 * 6 + pixel_size * 2 * 5		-- pixels per symbol * symbols num + pixels per space * spaces num
	local h = pixel_size * 9 * 2 + pixel_size * 2

	local x0 = get_x(column + 1) - pixel_size * 3
	local y0 = get_y(line) - pixel_size * 2

	local vertices = {	{x0 + 0,	y0 +  0},
						{x0 + w,	y0 +  0},
						{x0 + w,	y0 + -h},
						{x0 + 0,	y0 + -h}	}

	local texturedMesh			= CreateElement "ceTexPoly"
	texturedMesh.name			= name
	texturedMesh.parent			= nil
	texturedMesh.controllers	= controllers
	texturedMesh.material		= "DED_BIG_OFF"
	texturedMesh.indices		= default_box_indices
	texturedMesh.vertices		= vertices
	texturedMesh.tex_coords		= tex_coords
	texturedMesh.pos			= {0, 0, 0}
	texturedMesh.additive_alpha	= true
	Add(texturedMesh)

	return texturedMesh;
end