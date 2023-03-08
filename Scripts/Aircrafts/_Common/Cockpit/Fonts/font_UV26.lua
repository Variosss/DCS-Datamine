
if symbols_locale_included == nil then
	dofile(LockOn_Options.common_script_path.."Fonts/symbols_locale.lua")
end

local DIGITAL_xsize = 42
local DIGITAL_ysize = 52
fontdescription_UV26 = {
texture    = "Fonts/font_UV26.tga",
size      = {5, 5},
resolution = {256, 256}	,	
default    = {DIGITAL_xsize, DIGITAL_ysize},
	chars		= {
		{32, DIGITAL_xsize, DIGITAL_ysize}, --[space]
		{39, DIGITAL_xsize, DIGITAL_ysize}, --'
		{45, DIGITAL_xsize, DIGITAL_ysize}, ---
		{48, DIGITAL_xsize, DIGITAL_ysize}, --0
		{49, DIGITAL_xsize, DIGITAL_ysize}, --1
		{50, DIGITAL_xsize, DIGITAL_ysize}, --2
		{51, DIGITAL_xsize, DIGITAL_ysize}, --3
		{52, DIGITAL_xsize, DIGITAL_ysize}, --4
		{53, DIGITAL_xsize, DIGITAL_ysize}, --5
		{54, DIGITAL_xsize, DIGITAL_ysize}, --6
		{55, DIGITAL_xsize, DIGITAL_ysize}, --7
		{56, DIGITAL_xsize, DIGITAL_ysize}, --8
		{57, DIGITAL_xsize, DIGITAL_ysize}, --9
		{65, DIGITAL_xsize, DIGITAL_ysize}, --A
		{82, DIGITAL_xsize, DIGITAL_ysize}, --R
		{84, DIGITAL_xsize, DIGITAL_ysize}, --T
		{cyrillic['Н'], DIGITAL_xsize, DIGITAL_ysize}, --Н
		{cyrillic['П'], DIGITAL_xsize, DIGITAL_ysize}, --П
		{cyrillic['Р'], DIGITAL_xsize, DIGITAL_ysize}, --Р
		{cyrillic['С'], DIGITAL_xsize, DIGITAL_ysize}, --С
	}
}
