dofile(LockOn_Options.script_path.."Displays/HUD/indicator/HUD_Page_defs.lua")

local char_w = glyphWidth_100
local char_h = glyphHeight_100
local char_aspect = char_h / char_w

local char_space = fontIntercharDflt_75
local line_space = 5.0

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

-- main placeholder for all elements
local MainPlaceholderName = "HUD_DED_Placeholder"
local DED_placeholder = addPlaceholder(MainPlaceholderName, {0,-124.0}, nil, {{"HUD_DED_Show"}})


function addLocalPlaceholder(name, parent, controllers)
	parent = parent or MainPlaceholderName
	local placeholder = addPlaceholder(name, {0,0}, parent, controllers)
	return placeholder
end

-- pos = { column, line }
local function addSimpleText(name, text, pos, inv, parent, controllers, formats)
	local line		= pos[2]
	local column	= pos[1]
	local init_pos	= {get_x(column), get_y(line), 0}

	local string_defs = STROKE_FNT_DFLT_100_NARROW
	if inv == true then
		string_defs = STROKE_FNT_DFLT_120
	end

	return addStrokeText(name, text, string_defs, "LeftTop", init_pos, parent, controllers, formats)
end

function addText(name, text, pos, inv, parent, controllers, formats)
	parent = parent or MainPlaceholderName
	text = text or ""

	-- displacement controller
	local line		= pos[2]
	local column	= pos[1]
	local width		= string.len(text)
	local delta_pos = {"HUD_DED_DeltaPos", line, column, width}

	if type(inv) == "table" then
		inv[#inv + 1] = line
		inv[#inv + 1] = column
		inv[#inv + 1] = width

		inv[#inv + 1] = 1
		local placeholder_inv = addPlaceholder(name.."_placeholder_inv", {0,0}, parent, {inv, delta_pos})
		addSimpleText(name.."_inv", text, pos, true, placeholder_inv.name, controllers, formats)
		
		inv[#inv] = 0
		local placeholder = addPlaceholder(name.."_placeholder", {0,0}, parent, {inv, delta_pos})
		addSimpleText(name, text, pos, false, placeholder.name, controllers, formats)
	else
		-- controller for inv table
		local inv_controller = {"HUD_DED_Inv", line, column, width, inv}

		local placeholder = addPlaceholder(name.."_placeholder", {0,0}, parent, {inv_controller, delta_pos})
		addSimpleText(name, text, pos, inv, placeholder.name, controllers, formats)
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
	addText(name, "OFF", pos, false, nil, controllers)
end