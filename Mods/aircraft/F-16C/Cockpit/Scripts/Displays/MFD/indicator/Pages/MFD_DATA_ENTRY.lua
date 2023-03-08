dofile(LockOn_Options.script_path.."Displays/MFD/indicator/MFD_Symbology.lua")

local strdefs = STROKE_FNT_DFLT_10_14
local strH = stringdefs[strdefs][1] / GetScale()	-- char height
local strW = stringdefs[strdefs][2] / GetScale()	-- char width
local strS = stringdefs[strdefs][3] / GetScale()	-- char space

local function addSimpleText(name, text, align, pos, inv, parent, txt_controllers, bckgnd_controllers, formats)
	if inv == true then
		local border = 2
		local border2 = border * 2
		local txt_len = string.len(text)
		local height = strH
		local width = strW * txt_len + strS * (txt_len - 1)
		local px = pos[1]
		local py = pos[2]
		
		height = height + border2
		width = width + border2

		if align == "CenterCenter" then

		elseif align == "LeftCenter" then
			px = px - border
		elseif align == "RightCenter" then
			px = px + border
		elseif align == "CenterBottom" then
			py = py - border
		elseif align == "CenterTop" then
			py = py + border
		elseif align == "LeftBottom" then
			px = px - border
			py = py - border
		elseif align == "LeftTop" then
			px = px - border
			py = py + border
		elseif align == "RightTop" then
			px = px + border
			py = py + border
		elseif align == "RightBottom" then
			px = px + border
			py = py - border
		end

		-- white background
		addClippedBox(name.."_background", width, height, align, {px, py}, parent, bckgnd_controllers, "MFD_FONT_BKGND_WHITE")
		-- black text
		txt_controllers = txt_controllers or {}
		addBlackText(name.."_black_txt", text, strdefs, align, pos, parent, txt_controllers, formats)
	else
		addStrokeText(name.."_white_txt", text, strdefs, align, pos, parent, txt_controllers, formats)
	end
end

local function addText(name, text, align, pos, inv, parent, txt_controllers, bckgnd_controllers, formats)
	text = text or ""

	if type(inv) == "table" then
		inv[#inv + 1] = 0
		local placeholder = addPlaceholder(name.."_txt_placeholder", nil, parent, {inv})
		addSimpleText(name, text, align, pos, false, placeholder.name, txt_controllers, bckgnd_controllers, formats)

		inv[#inv] = 1
		local placeholder_inv = addPlaceholder(name.."_inv_txt_placeholder", nil, parent, {inv})
		addSimpleText(name.."_inv", text, align, pos, true, placeholder_inv.name, txt_controllers, bckgnd_controllers, formats)
	else
		local placeholder = addPlaceholder(name.."_txt_placeholder", nil, parent)
		addSimpleText(name, text, align, pos, inv, placeholder.name, txt_controllers, bckgnd_controllers, formats)
	end
end

add_PB_label(2,		"ENTR")
add_PB_label(3,		"RTN")
add_PB_label(4,		"RCL")

local NEG_PH = addPlaceholder("PB NEG PH", nil, nil, {{"MFD_DATA_ENTRY_NEG_Show"}})
add_Selectable_PB_Label(5,	"NEG", NEG_PH.name, {{"MFD_DATA_ENTRY_NEG_Enabled", 0}}, {{"MFD_DATA_ENTRY_NEG_Enabled", 1}})

add_PB_label(6,		"6")
add_PB_label(7,		"7")
add_PB_label(8,		"8")
add_PB_label(9,		"9")
add_PB_label(10,	"0")

add_PB_label(16,	"5")
add_PB_label(17,	"4")
add_PB_label(18,	"3")
add_PB_label(19,	"2")
add_PB_label(20,	"1")

addText("ENTER text",	"ENTER",	"CenterCenter", {0, 50})
addText("Prompt",		"PROMPT",	"CenterBottom", {0, 10}, false, nil, {{"MFD_DATA_ENTRY_Prompt"}})

local linespace = 25
for i = 0,4,1 do
	local line_PH = addPlaceholder("DATA ENTRY Line PH "..i, nil, nil, {{"MFD_DATA_ENTRY_LineShow", i}})
	addText("Asterisks left "..i,	"*",		"CenterTop",	{-80, -20 - linespace*i}, true, line_PH.name, {{"MFD_DATA_ENTRY_AsterisksPos", i}}, {{"MFD_DATA_ENTRY_AsterisksPos", i}})
	addText("Asterisks right "..i,	"*",		"CenterTop",	{ 80, -20 - linespace*i}, true, line_PH.name, {{"MFD_DATA_ENTRY_AsterisksPos", i}}, {{"MFD_DATA_ENTRY_AsterisksPos", i}})
	addText("Scratchpad "..i,		"12345678",	"LeftTop",		{-60, -20 - linespace*i}, {"MFD_DATA_ENTRY_Inv", i}, line_PH.name, {{"MFD_DATA_ENTRY_Scratchpad", i}}, {{"MFD_DATA_ENTRY_Length", i, strW, strS}})
end
