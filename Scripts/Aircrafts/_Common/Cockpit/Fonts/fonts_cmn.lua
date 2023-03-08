
if symbols_locale_included == nil then
	dofile(LockOn_Options.common_script_path.."Fonts/symbols_locale.lua")
end

fontdescription_cmn = {}

function addCharsetMultitex(font_, texture_, layer_, set_)
	if font_.textures == nil then
		font_.textures = {}
	end
	
	if font_.chars == nil then
		font_.chars = {}
	end
	
	font_.textures[#font_.textures + 1] = texture_
	font_.chars[#font_.chars + 1] = {layer = layer_, set = set_}
end

-- general font
dofile(LockOn_Options.common_script_path.."Fonts/font_general.lua")

fontdescription_cmn["font_general_loc"] = {
	class     = "ceMultiTexPolyFont",
	size      = {7, 7},
	resolution = {1024, 1024},
	default    = {font_general_xsize, font_general_ysize}
}

addCharsetMultitex(fontdescription_cmn["font_general_loc"], "Fonts/font_general_EN.dds", 0, generalSetEN)
addCharsetMultitex(fontdescription_cmn["font_general_loc"], "Fonts/font_general_RU.dds", 1, generalSetRU)
addCharsetMultitex(fontdescription_cmn["font_general_loc"], "Fonts/font_general_EUR_SPEC.dds", 2, generalSetEURSPEC)
