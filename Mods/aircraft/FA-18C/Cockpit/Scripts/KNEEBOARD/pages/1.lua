dofile(LockOn_Options.script_path.."KNEEBOARD/common.lua")

add_picture("kneeboard_notepad_background.dds")

local gettext = require("i_18n")
_ = gettext.translate

local default_material = font_hints_kneeboard
local noParent = nil
local noControllers = nil

function AddElement(object)
    object.use_mipfilter = true
    Add(object)
end

ListBase					= CreateElement "ceSimple"
ListBase.name				= "ListBase"
ListBase.init_pos			= {0, GetAspect() - 3.5 * 0.0075}
AddElement(ListBase)

-- fonts
FontSizeY1	= 0.0075
FontSizeX1	= FontSizeY1 * 0.64

local font_title	= {FontSizeY1,			FontSizeX1,			0.0005,		0.0}
local font_item	= {FontSizeY1 * 0.75,	FontSizeX1 * 0.75,	0.00025,	0.0}

-- lines
local FirstLineY	= 1.167
local LineSizeY		= 0.092

local function getLineY(line)
	return FirstLineY - LineSizeY * (line)
end

local function setSymbolAlignment(symbol, align)
	if align ~= nil then
		symbol.alignment = align
	else
		symbol.alignment = "CenterCenter"
	end
end

function addPlaceholder(name, pos, parent, controllers)
	local placeholder       	= CreateElement "ceSimple"
	placeholder.name        	= name
	pos = pos or {0, 0}
	placeholder.init_pos    	= {pos[1], pos[2], 0}
	placeholder.collimated  	= collimated or false

	if parent ~= nil then
		placeholder.parent_element 	= parent
	end	
	
	if controllers ~= nil then
		placeholder.controllers		= controllers
	end
	
	Add(placeholder)
	return placeholder
end

local function AddText(name, value, stringdef, align, pos, parent, controllers, material, formats)
	local 	txt 	= CreateElement "ceStringPoly"
	txt.name		= name
	txt.material	= material or default_material
	txt.value		= value
	txt.stringdefs	= stringdef
	setSymbolAlignment(txt, align)
	local pos_		= pos or {0, 0}
	txt.init_pos	= {pos_[1], pos_[2], 0}
	if parent ~= nil then
		txt.parent_element = parent
	end
	if controllers ~= nil then
		if type(controllers) == "table" then
			txt.controllers = controllers
		end
	end
	txt.formats		= formats
	AddElement(txt)
	return txt
end

AddText("Label1", "CV Operations Data", font_title, "LeftBottom", {-0.5, getLineY(0)}, noParent, noControllers, font_header_kneeboard)

local posX = -0.91
for i = 1,5 do
	local num = i-1
	local item_root = addPlaceholder("Carrier_item"..i, {posX, getLineY(1+num*6)}, noParent, {{"Knbrd_Cvn_Root", num}})
	AddText("Carrier_name"..i,			"",			font_item, "LeftBottom", {  0,			0  }, item_root.name, {{"Knbrd_Cvn_Name", num}}, font_label_kneeboard)
	AddText("Carrier_callsign_label"..i,"Callsign:",font_item, "LeftBottom", {0.1, -LineSizeY  }, item_root.name, nil, font_label_kneeboard)
	AddText("Carrier_callsign"..i,		"",			font_item, "LeftBottom", {0.5, -LineSizeY  }, item_root.name, {{"Knbrd_Cvn_Callsign", num}}, font_label_kneeboard)
	AddText("ATC_Frequency_label"..i,	"ATC:",		font_item, "LeftBottom", {0.1, -LineSizeY*2}, item_root.name, nil, font_label_kneeboard)
	AddText("ATC_Frequency"..i,			"",			font_item, "LeftBottom", {0.5, -LineSizeY*2}, item_root.name, {{"Knbrd_Cvn_ATC_Frequency", num}}, font_value_kneeboard)
	AddText("TACAN_Channel_label"..i,	"TACAN:",	font_item, "LeftBottom", {0.1, -LineSizeY*3}, item_root.name, nil, font_label_kneeboard)
	AddText("TACAN_Channel"..i,			"",			font_item, "LeftBottom", {0.5, -LineSizeY*3}, item_root.name, {{"Knbrd_Cvn_TACAN_Channel", num}}, font_value_kneeboard)
	AddText("ILS_Channel_label"..i,		"ILS:",		font_item, "LeftBottom", {0.1, -LineSizeY*4}, item_root.name, nil, font_label_kneeboard)
	AddText("ILS_Channel"..i,			"",			font_item, "LeftBottom", {0.5, -LineSizeY*4}, item_root.name, {{"Knbrd_Cvn_ILS_Channel", num}}, font_value_kneeboard)
	AddText("Link4_Frequency_label"..i,	"Link 4:",	font_item, "LeftBottom", {0.1, -LineSizeY*5}, item_root.name, nil, font_label_kneeboard)
	AddText("Link4_Frequency"..i,		"",			font_item, "LeftBottom", {0.5, -LineSizeY*5}, item_root.name, {{"Knbrd_Cvn_Link4_Frequency", num}}, font_value_kneeboard)
end