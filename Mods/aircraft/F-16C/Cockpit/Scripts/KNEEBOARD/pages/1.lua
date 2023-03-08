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

HintsBase					= CreateElement "ceSimple"
HintsBase.name				= "HintsBase"
HintsBase.init_pos			= {0, GetAspect() - 3.5 * 0.0075}
AddElement(HintsBase)

-- fonts
FontSizeY1	= 0.0075
FontSizeX1	= FontSizeY1 * 0.64

predefined_font_title	= {FontSizeY1,			FontSizeX1,			0.0005,		0.0}
predefined_font_item	= {FontSizeY1 * 0.75,	FontSizeX1 * 0.75,	0.00025,	0.0}
predefined_font_key		= {FontSizeY1 * 0.75,	FontSizeX1 * 0.75,	0.00025,	0.0}

-- lines
local FirstLineY	= 1.167
local LineSizeY		= 0.092

local function getLineY(line)
	return FirstLineY - LineSizeY * (line)
end

--
local KeyPosX = 0.95

local function setSymbolAlignment(symbol, align)
	if align ~= nil then
		symbol.alignment = align
	else
		symbol.alignment = "CenterCenter"
	end
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

-- Weapon Status ------------------------------------------------
-----------------------------------------------------------------
local Weapon_pos_y = getLineY(0)

AddText("txt_WeaponStatus", _("WEAPON_board"), predefined_font_title, "CenterBottom", {0.0, Weapon_pos_y}, noParent, noControllers, font_hints_kneeboard)

-- Laser Code ---------------------------------------------------
-----------------------------------------------------------------
local LaserCode_pos_x 			= 0.32
local LaserCode_pos_y			= getLineY(1)
local LaserCode100_pos_y		= getLineY(2)
local LaserCode10_pos_y			= getLineY(3)
local LaserCode1_pos_y			= getLineY(4)

AddText("Name_LaserCode", _("LASER CODE - _board"), predefined_font_item, "RightBottom", {LaserCode_pos_x,  LaserCode_pos_y}, noParent, noControllers, font_hints_kneeboard)
AddText("Status_LaserCode1000",	"1", predefined_font_item, "LeftBottom", {LaserCode_pos_x, LaserCode_pos_y},	noParent, noControllers,			 font_hints_kneeboard)
AddText("Status_LaserCode100",	"",  predefined_font_item, "LeftBottom", {LaserCode_pos_x, LaserCode100_pos_y},	noParent, {{"Status_LaserCode", 0}}, font_hints_kneeboard, {"5", "6", "7"})
AddText("Status_LaserCode10",	"",  predefined_font_item, "LeftBottom", {LaserCode_pos_x, LaserCode10_pos_y},	noParent, {{"Status_LaserCode", 1}}, font_hints_kneeboard, {"1", "2", "3", "4", "5", "6", "7", "8"})
AddText("Status_LaserCode1",	"",  predefined_font_item, "LeftBottom", {LaserCode_pos_x, LaserCode1_pos_y},	noParent, {{"Status_LaserCode", 2}}, font_hints_kneeboard, {"1", "2", "3", "4", "5", "6", "7", "8"})
AddText("Key_LaserCode100",	_("RS+RA+[9]_board"), predefined_font_key, "RightBottom", {KeyPosX, LaserCode100_pos_y},noParent, noControllers, font_general_keys)
AddText("Key_LaserCode10",	_("RS+RA+[0]_board"), predefined_font_key, "RightBottom", {KeyPosX, LaserCode10_pos_y},	noParent, noControllers, font_general_keys)
AddText("Key_LaserCode1",	_("RS+RA+[-]_board"), predefined_font_key, "RightBottom", {KeyPosX, LaserCode1_pos_y},	noParent, noControllers, font_general_keys)
