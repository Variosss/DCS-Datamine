dofile(LockOn_Options.common_script_path.."Fonts/symbols_locale.lua")
dofile(LockOn_Options.common_script_path.."Fonts/fonts_cmn.lua")

function full_cp1251_monospace(tbl, x, y)
	for i = 32,127  do	tbl[#tbl + 1] = {i							,x,y} end
	for i = 128,191 do	tbl[#tbl + 1] = {cp1251_after_128_due_192[i],x,y} end
	add_cyrillic_capitals(tbl,x,y)
	add_cyrillic_smalls  (tbl,x,y)
end

local IndicationTexturesPath = LockOn_Options.script_path.."../IndicationTextures/"

fontdescription = {}		

fontdescription["font_Ka-50_dbg"] = {		
texture    = IndicationTexturesPath.."font_dbg.tga",		
size      = {17, 17},
resolution = {512, 512},
default   = {18, 28},
chars		= {}}
full_cp1251_monospace(fontdescription["font_Ka-50_dbg"].chars,18,28)

HUD_xsize = 49
HUD_ysize = 57
fontdescription["font_Ka-50_HUD"] = {		
texture    = IndicationTexturesPath.."font_Ka-50_HUD.tga",	
size      = {9, 9},
resolution = {512, 512},
default   = {HUD_xsize, HUD_ysize},
chars		= {
	{32, HUD_xsize, HUD_ysize}, --[space]
	{33, HUD_xsize, HUD_ysize}, --!
	{34, HUD_xsize, HUD_ysize}, --"
	{43, HUD_xsize, HUD_ysize}, --+
	{45, HUD_xsize, HUD_ysize}, ---
	{46, 30, HUD_ysize}, --.
	{47, HUD_xsize, HUD_ysize}, --/
	{48, HUD_xsize, HUD_ysize}, --0
	{49, HUD_xsize, HUD_ysize}, --1
	{50, HUD_xsize, HUD_ysize}, --2
	{51, HUD_xsize, HUD_ysize}, --3
	{52, HUD_xsize, HUD_ysize}, --4
	{53, HUD_xsize, HUD_ysize}, --5
	{54, HUD_xsize, HUD_ysize}, --6
	{55, HUD_xsize, HUD_ysize}, --7
	{56, HUD_xsize, HUD_ysize}, --8
	{57, HUD_xsize, HUD_ysize}, --9
	{58, HUD_xsize, HUD_ysize}, --:
	{65, HUD_xsize, HUD_ysize}, --A
	{66, HUD_xsize, HUD_ysize}, --B
	{67, HUD_xsize, HUD_ysize}, --C
	{68, HUD_xsize, HUD_ysize}, --D
	{69, HUD_xsize, HUD_ysize}, --E
	{70, HUD_xsize, HUD_ysize}, --F
	{71, HUD_xsize, HUD_ysize}, --G
	{72, HUD_xsize, HUD_ysize}, --H
	{73, HUD_xsize, HUD_ysize}, --I
	{74, HUD_xsize, HUD_ysize}, --J
	{75, HUD_xsize, HUD_ysize}, --K
	{76, HUD_xsize, HUD_ysize}, --L
	{77, HUD_xsize, HUD_ysize}, --M
	{78, HUD_xsize, HUD_ysize}, --N
	{79, HUD_xsize, HUD_ysize}, --O
	{80, HUD_xsize, HUD_ysize}, --P
	{81, HUD_xsize, HUD_ysize}, --Q
	{82, HUD_xsize, HUD_ysize}, --R
	{83, HUD_xsize, HUD_ysize}, --S
	{84, HUD_xsize, HUD_ysize}, --T
	{85, HUD_xsize, HUD_ysize}, --U
	{86, HUD_xsize, HUD_ysize}, --V
	{87, HUD_xsize, HUD_ysize}, --W
	{88, HUD_xsize, HUD_ysize}, --X
	{89, HUD_xsize, HUD_ysize}, --Y
	{90, HUD_xsize, HUD_ysize}, --Z
	{92, HUD_xsize, HUD_ysize}, --\
	{124, HUD_xsize, HUD_ysize}, --|
	{cyrillic['А'], HUD_xsize, HUD_ysize}, --А
	{cyrillic['Б'], HUD_xsize, HUD_ysize}, --Б
	{cyrillic['В'], HUD_xsize, HUD_ysize}, --В
	{cyrillic['Г'], HUD_xsize, HUD_ysize}, --Г
	{cyrillic['Д'], HUD_xsize, HUD_ysize}, --Д
	{cyrillic['Е'], HUD_xsize, HUD_ysize}, --Е
	{cyrillic['Ж'], HUD_xsize, HUD_ysize}, --Ж
	{cyrillic['З'], HUD_xsize, HUD_ysize}, --З
	{cyrillic['И'], HUD_xsize, HUD_ysize}, --И
	{cyrillic['Й'], HUD_xsize, HUD_ysize}, --Й
	{cyrillic['К'], HUD_xsize, HUD_ysize}, --К
	{cyrillic['Л'], HUD_xsize, HUD_ysize}, --Л
	{cyrillic['М'], HUD_xsize, HUD_ysize}, --М
	{cyrillic['Н'], HUD_xsize, HUD_ysize}, --Н
	{cyrillic['О'], HUD_xsize, HUD_ysize}, --О
	{cyrillic['П'], HUD_xsize, HUD_ysize}, --П
	{cyrillic['Р'], HUD_xsize, HUD_ysize}, --Р
	{cyrillic['С'], HUD_xsize, HUD_ysize}, --С
	{cyrillic['Т'], HUD_xsize, HUD_ysize}, --Т
	{cyrillic['У'], HUD_xsize, HUD_ysize}, --У
	{cyrillic['Ф'], HUD_xsize, HUD_ysize}, --Ф
	{cyrillic['Х'], HUD_xsize, HUD_ysize}, --Х
	{cyrillic['Ц'], HUD_xsize, HUD_ysize}, --Ц
	{cyrillic['Ч'], HUD_xsize, HUD_ysize}, --Ч
	{cyrillic['Ш'], HUD_xsize, HUD_ysize}, --Ш
	{cyrillic['Щ'], HUD_xsize, HUD_ysize}, --Щ
	{cyrillic['Ъ'], HUD_xsize, HUD_ysize}, --Ъ
	{cyrillic['Ы'], HUD_xsize, HUD_ysize}, --Ы
	{cyrillic['Ь'], HUD_xsize, HUD_ysize}, --Ь
	{cyrillic['Э'], HUD_xsize, HUD_ysize}, --Э
	{cyrillic['Ю'], HUD_xsize, HUD_ysize}, --Ю
	{cyrillic['Я'], HUD_xsize, HUD_ysize}, --Я
	{cp1251_after_128_due_192[150], HUD_xsize, HUD_ysize}, --- == \150
	}
}

SHKVAL_xsize_wide = 39
SHKVAL_xsize_narrow = 35
SHKVAL_ysize = 43
fontdescription["font_Ka-50_SHKVAL"] = {		
texture    = IndicationTexturesPath.."font_Ka-50_SHKVAL.tga",		
size      = {6,6},--{5, 5}
resolution = {256, 256},	
default    = {SHKVAL_xsize_narrow, SHKVAL_ysize},	
chars		= {
	{32, SHKVAL_xsize_narrow, SHKVAL_ysize}, --[space]
	{43, SHKVAL_xsize_wide,   SHKVAL_ysize}, --+
	{45, SHKVAL_xsize_wide,   SHKVAL_ysize}, ---
	{48, SHKVAL_xsize_narrow, SHKVAL_ysize}, --0
	{49, SHKVAL_xsize_narrow, SHKVAL_ysize}, --1
	{50, SHKVAL_xsize_narrow, SHKVAL_ysize}, --2
	{51, SHKVAL_xsize_narrow, SHKVAL_ysize}, --3
	{52, SHKVAL_xsize_narrow, SHKVAL_ysize}, --4
	{53, SHKVAL_xsize_narrow, SHKVAL_ysize}, --5
	{54, SHKVAL_xsize_narrow, SHKVAL_ysize}, --6
	{55, SHKVAL_xsize_narrow, SHKVAL_ysize}, --7
	{56, SHKVAL_xsize_narrow, SHKVAL_ysize}, --8
	{57, SHKVAL_xsize_narrow, SHKVAL_ysize}, --9
	{65, SHKVAL_xsize_narrow, SHKVAL_ysize}, --A
	{70, SHKVAL_xsize_narrow, SHKVAL_ysize}, --F
	{72, SHKVAL_xsize_narrow, SHKVAL_ysize}, --H
	{82, SHKVAL_xsize_narrow, SHKVAL_ysize}, --R
	{84,  SHKVAL_xsize_narrow, SHKVAL_ysize}, --T
	{86,  SHKVAL_xsize_narrow, SHKVAL_ysize}, --V
	{127, SHKVAL_xsize_wide,  SHKVAL_ysize}, --X = \127
	{46,  SHKVAL_xsize_narrow, SHKVAL_ysize}, --.
	{cyrillic['А'], SHKVAL_xsize_narrow,SHKVAL_ysize}, --А
	{cyrillic['Г'], SHKVAL_xsize_narrow,SHKVAL_ysize}, --Г
	{cyrillic['П'], SHKVAL_xsize_narrow,SHKVAL_ysize}, --П
	{cyrillic['С'], SHKVAL_xsize_narrow,SHKVAL_ysize}, --С
	{cyrillic['Т'], SHKVAL_xsize_narrow,SHKVAL_ysize}, --Т
	}
}



local ABRIS_font_symbol =  {22,29}
local ABRIS_font_chars  = {} 

full_cp1251_monospace(ABRIS_font_chars,ABRIS_font_symbol[1],ABRIS_font_symbol[2])

function ABRIS_font(texture)
	return 	{
		texture     = texture,
		size        = {14,17},
		resolution  = {512,512},
		default     = ABRIS_font_symbol,
		grid_offset = {-1,2},
		chars       = ABRIS_font_chars		
	}
end


fontdescription["font_Ka-50_ABRIS_WHITE"] 		  = ABRIS_font(IndicationTexturesPath.."ABRIS_FONT.tga")
fontdescription["font_Ka-50_ABRIS_WHITE_INVERSE"] = ABRIS_font(IndicationTexturesPath.."ABRIS_FONT_INVERSE.tga")

dofile(LockOn_Options.common_script_path.."Fonts/font_EKRAN.lua")
fontdescription["font_EKRAN"] = fontdescription_EKRAN

DIGITAL_xsize = 42
DIGITAL_ysize = 52
fontdescription["font_PVI"] = {
texture     = IndicationTexturesPath.."font_Ka-50_digital.tga",
size        = {4, 5},
resolution  = {256, 256}	,	
grid_offset = {0,-7},
default     = {DIGITAL_xsize, DIGITAL_ysize},
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

fontdescription["font_UV26"] = fontdescription["font_PVI"]
