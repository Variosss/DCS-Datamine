
if symbols_locale_included == nil then
	dofile(LockOn_Options.common_script_path.."Fonts/symbols_locale.lua")
end

local EKRAN_ysize = 55.5
local EKRAN_xsize = EKRAN_ysize * 0.8597
fontdescription_EKRAN = {	
	texture    = "Fonts/font_EKRAN.dds",
	size      = {9, 9},
	resolution = {512, 512},	
	default    = {EKRAN_xsize, EKRAN_ysize},	
	chars		 = {
	{32, EKRAN_xsize, EKRAN_ysize}, --[space]
	{34, EKRAN_xsize, EKRAN_ysize}, --"
	{45, EKRAN_xsize, EKRAN_ysize}, ---
	{48, EKRAN_xsize, EKRAN_ysize}, --0
	{49, EKRAN_xsize, EKRAN_ysize}, --1
	{50, EKRAN_xsize, EKRAN_ysize}, --2
	{51, EKRAN_xsize, EKRAN_ysize}, --3
	{52, EKRAN_xsize, EKRAN_ysize}, --4
	{53, EKRAN_xsize, EKRAN_ysize}, --5
	{54, EKRAN_xsize, EKRAN_ysize}, --6
	{55, EKRAN_xsize, EKRAN_ysize}, --7
	{56, EKRAN_xsize, EKRAN_ysize}, --8
	{57, EKRAN_xsize, EKRAN_ysize}, --9
	{65, EKRAN_xsize, EKRAN_ysize}, --A
	{66, EKRAN_xsize, EKRAN_ysize}, --B
	{67, EKRAN_xsize, EKRAN_ysize}, --C
	{68, EKRAN_xsize, EKRAN_ysize}, --D
	{69, EKRAN_xsize, EKRAN_ysize}, --E
	{70, EKRAN_xsize, EKRAN_ysize}, --F
	{71, EKRAN_xsize, EKRAN_ysize}, --G
	{72, EKRAN_xsize, EKRAN_ysize}, --H
	{73, EKRAN_xsize, EKRAN_ysize}, --I
	{74, EKRAN_xsize, EKRAN_ysize}, --J
	{75, EKRAN_xsize, EKRAN_ysize}, --K
	{76, EKRAN_xsize, EKRAN_ysize}, --L
	{77, EKRAN_xsize, EKRAN_ysize}, --M
	{78, EKRAN_xsize, EKRAN_ysize}, --N
	{79, EKRAN_xsize, EKRAN_ysize}, --O
	{80, EKRAN_xsize, EKRAN_ysize}, --P
	{81, EKRAN_xsize, EKRAN_ysize}, --Q
	{82, EKRAN_xsize, EKRAN_ysize}, --R
	{83, EKRAN_xsize, EKRAN_ysize}, --S
	{84, EKRAN_xsize, EKRAN_ysize}, --T
	{85, EKRAN_xsize, EKRAN_ysize}, --U
	{86, EKRAN_xsize, EKRAN_ysize}, --V
	{87, EKRAN_xsize, EKRAN_ysize}, --W
	{88, EKRAN_xsize, EKRAN_ysize}, --X
	{89, EKRAN_xsize, EKRAN_ysize}, --Y
	{90, EKRAN_xsize, EKRAN_ysize}, --Z
	{cp1251_after_128_due_192[170],EKRAN_xsize, EKRAN_ysize}, --Є
	{cyrillic['А'], EKRAN_xsize, EKRAN_ysize}, --А
	{cyrillic['Б'], EKRAN_xsize, EKRAN_ysize}, --Б
	{cyrillic['В'], EKRAN_xsize, EKRAN_ysize}, --В
	{cyrillic['Г'], EKRAN_xsize, EKRAN_ysize}, --Г
	{cyrillic['Д'], EKRAN_xsize, EKRAN_ysize}, --Д
	{cyrillic['Е'], EKRAN_xsize, EKRAN_ysize}, --Е
	{cyrillic['Ж'], EKRAN_xsize, EKRAN_ysize}, --Ж
	{cyrillic['З'], EKRAN_xsize, EKRAN_ysize}, --З
	{cyrillic['И'], EKRAN_xsize, EKRAN_ysize}, --И
	{cyrillic['Й'], EKRAN_xsize, EKRAN_ysize}, --Й
	{cyrillic['К'], EKRAN_xsize, EKRAN_ysize}, --К
	{cyrillic['Л'], EKRAN_xsize, EKRAN_ysize}, --Л
	{cyrillic['М'], EKRAN_xsize, EKRAN_ysize}, --М
	{cyrillic['Н'], EKRAN_xsize, EKRAN_ysize}, --Н
	{cyrillic['О'], EKRAN_xsize, EKRAN_ysize}, --О
	{cyrillic['П'], EKRAN_xsize, EKRAN_ysize}, --П
	{cyrillic['Р'], EKRAN_xsize, EKRAN_ysize}, --Р
	{cyrillic['С'], EKRAN_xsize, EKRAN_ysize}, --С
	{cyrillic['Т'], EKRAN_xsize, EKRAN_ysize}, --Т
	{cyrillic['У'], EKRAN_xsize, EKRAN_ysize}, --У
	{cyrillic['Ф'], EKRAN_xsize, EKRAN_ysize}, --Ф
	{cyrillic['Х'], EKRAN_xsize, EKRAN_ysize}, --Х
	{cyrillic['Ц'], EKRAN_xsize, EKRAN_ysize}, --Ц
	{cyrillic['Ч'], EKRAN_xsize, EKRAN_ysize}, --Ч
	{cyrillic['Ш'], EKRAN_xsize, EKRAN_ysize}, --Ш
	{cyrillic['Щ'], EKRAN_xsize, EKRAN_ysize}, --Щ
	{cyrillic['Ъ'], EKRAN_xsize, EKRAN_ysize}, --Ъ
	{cyrillic['Ы'], EKRAN_xsize, EKRAN_ysize}, --Ы
	{cyrillic['Ь'], EKRAN_xsize, EKRAN_ysize}, --Ь
	{cyrillic['Э'], EKRAN_xsize, EKRAN_ysize}, --Э
	{cyrillic['Ю'], EKRAN_xsize, EKRAN_ysize}, --Ю
	{cyrillic['Я'], EKRAN_xsize, EKRAN_ysize}, --Я
	}
}	
