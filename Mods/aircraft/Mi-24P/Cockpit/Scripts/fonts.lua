dofile(LockOn_Options.common_script_path.."Fonts/symbols_locale.lua")
dofile(LockOn_Options.common_script_path.."Fonts/fonts_cmn.lua")

local IndicationTexturesPath = LockOn_Options.script_path.."../IndicationTextures/"

fontdescription = {}		

char_xsize = 49
char_ysize = 59
fontdescription["font_Mi8_Arcade"] = {		
texture    = IndicationTexturesPath.."font_arcade.tga",	
size      = {9, 9},
resolution = {512, 512},
default   = {char_xsize, char_ysize},
chars		= {
	{32, char_xsize, char_ysize}, --[space]
	{33, char_xsize, char_ysize}, --!
	{34, char_xsize, char_ysize}, --"
	{43, char_xsize, char_ysize}, --+
	{45, char_xsize, char_ysize}, ---
	{46, 30, char_ysize}, --.
	{47, char_xsize, char_ysize}, --/
	{48, char_xsize, char_ysize}, --0
	{49, char_xsize, char_ysize}, --1
	{50, char_xsize, char_ysize}, --2
	{51, char_xsize, char_ysize}, --3
	{52, char_xsize, char_ysize}, --4
	{53, char_xsize, char_ysize}, --5
	{54, char_xsize, char_ysize}, --6
	{55, char_xsize, char_ysize}, --7
	{56, char_xsize, char_ysize}, --8
	{57, char_xsize, char_ysize}, --9
	{58, char_xsize, char_ysize}, --:
	{65, char_xsize, char_ysize}, --A
	{66, char_xsize, char_ysize}, --B
	{67, char_xsize, char_ysize}, --C
	{68, char_xsize, char_ysize}, --D
	{69, char_xsize, char_ysize}, --E
	{70, char_xsize, char_ysize}, --F
	{71, char_xsize, char_ysize}, --G
	{72, char_xsize, char_ysize}, --H
	{73, char_xsize, char_ysize}, --I
	{74, char_xsize, char_ysize}, --J
	{75, char_xsize, char_ysize}, --K
	{76, char_xsize, char_ysize}, --L
	{77, char_xsize, char_ysize}, --M
	{78, char_xsize, char_ysize}, --N
	{79, char_xsize, char_ysize}, --O
	{80, char_xsize, char_ysize}, --P
	{81, char_xsize, char_ysize}, --Q
	{82, char_xsize, char_ysize}, --R
	{83, char_xsize, char_ysize}, --S
	{84, char_xsize, char_ysize}, --T
	{85, char_xsize, char_ysize}, --U
	{86, char_xsize, char_ysize}, --V
	{87, char_xsize, char_ysize}, --W
	{88, char_xsize, char_ysize}, --X
	{89, char_xsize, char_ysize}, --Y
	{90, char_xsize, char_ysize}, --Z
	{92, char_xsize, char_ysize}, --\
	{124, char_xsize, char_ysize}, --|
	{cyrillic['??'], char_xsize, char_ysize}, --??
	{cyrillic['??'], char_xsize, char_ysize}, --??
	{cyrillic['??'], char_xsize, char_ysize}, --??
	{cyrillic['??'], char_xsize, char_ysize}, --??
	{cyrillic['??'], char_xsize, char_ysize}, --??
	{cyrillic['??'], char_xsize, char_ysize}, --??
	{cyrillic['??'], char_xsize, char_ysize}, --??
	{cyrillic['??'], char_xsize, char_ysize}, --??
	{cyrillic['??'], char_xsize, char_ysize}, --??
	{cyrillic['??'], char_xsize, char_ysize}, --??
	{cyrillic['??'], char_xsize, char_ysize}, --??
	{cyrillic['??'], char_xsize, char_ysize}, --??
	{cyrillic['??'], char_xsize, char_ysize}, --??
	{cyrillic['??'], char_xsize, char_ysize}, --??
	{cyrillic['??'], char_xsize, char_ysize}, --??
	{cyrillic['??'], char_xsize, char_ysize}, --??
	{cyrillic['??'], char_xsize, char_ysize}, --??
	{cyrillic['??'], char_xsize, char_ysize}, --??
	{cyrillic['??'], char_xsize, char_ysize}, --??
	{cyrillic['??'], char_xsize, char_ysize}, --??
	{cyrillic['??'], char_xsize, char_ysize}, --??
	{cyrillic['??'], char_xsize, char_ysize}, --??
	{cyrillic['??'], char_xsize, char_ysize}, --??
	{cyrillic['??'], char_xsize, char_ysize}, --??
	{cyrillic['??'], char_xsize, char_ysize}, --??
	{cyrillic['??'], char_xsize, char_ysize}, --??
	{cyrillic['??'], char_xsize, char_ysize}, --??
	{cyrillic['??'], char_xsize, char_ysize}, --??
	{cyrillic['??'], char_xsize, char_ysize}, --??
	{cyrillic['??'], char_xsize, char_ysize}, --??
	{cyrillic['??'], char_xsize, char_ysize}, --??
	{cyrillic['??'], char_xsize, char_ysize}, --??
	{cp1251_after_128_due_192[150], char_xsize, char_ysize}, --- == \150
	}
}

general_xsize = 48 * 2
general_ysize = 72.0 * 2 --73.143 * 2
fontdescription["font_general"] = {
	texture    = IndicationTexturesPath.."font_general.tga",
	size      = {7, 7},
	resolution = {1024, 1024},
	default    = {general_xsize, general_ysize},
	chars	    = {
		 [1]   = {32, general_xsize, general_ysize}, -- [space]
		 [2]   = {42, general_xsize, general_ysize}, -- *
		 [3]   = {43, general_xsize, general_ysize}, -- +
		 [4]   = {45, general_xsize, general_ysize}, -- -
		 [5]   = {46, general_xsize, general_ysize}, -- .
		 [6]   = {47, general_xsize, general_ysize}, -- /
		 [7]   = {48, general_xsize, general_ysize}, -- 0
		 [8]   = {49, general_xsize, general_ysize}, -- 1
		 [9]   = {50, general_xsize, general_ysize}, -- 2
		 [10]  = {51, general_xsize, general_ysize}, -- 3
		 [11]  = {52, general_xsize, general_ysize}, -- 4
		 [12]  = {53, general_xsize, general_ysize}, -- 5
		 [13]  = {54, general_xsize, general_ysize}, -- 6
		 [14]  = {55, general_xsize, general_ysize}, -- 7
		 [15]  = {56, general_xsize, general_ysize}, -- 8
		 [16]  = {57, general_xsize, general_ysize}, -- 9
		 [17]  = {58, general_xsize, general_ysize}, -- :
		 [18]  = {latin['A'], general_xsize, general_ysize}, -- A
		 [19]  = {latin['B'], general_xsize, general_ysize}, -- B
		 [20]  = {latin['C'], general_xsize, general_ysize}, -- C
		 [21]  = {latin['D'], general_xsize, general_ysize}, -- D
		 [22]  = {latin['E'], general_xsize, general_ysize}, -- E
		 [23]  = {latin['F'], general_xsize, general_ysize}, -- F
		 [24]  = {latin['G'], general_xsize, general_ysize}, -- G
		 [25]  = {latin['H'], general_xsize, general_ysize}, -- H
		 [26]  = {latin['I'], general_xsize, general_ysize}, -- I
		 [27]  = {latin['J'], general_xsize, general_ysize}, -- J
		 [28]  = {latin['K'], general_xsize, general_ysize}, -- K
		 [29]  = {latin['L'], general_xsize, general_ysize}, -- L
		 [30]  = {latin['M'], general_xsize, general_ysize}, -- M
		 [31]  = {latin['N'], general_xsize, general_ysize}, -- N
		 [32]  = {latin['O'], general_xsize, general_ysize}, -- O
		 [33]  = {latin['P'], general_xsize, general_ysize}, -- P
		 [34]  = {latin['Q'], general_xsize, general_ysize}, -- Q
		 [35]  = {latin['R'], general_xsize, general_ysize}, -- R
		 [36]  = {latin['S'], general_xsize, general_ysize}, -- S
		 [37]  = {latin['T'], general_xsize, general_ysize}, -- T
		 [38]  = {latin['U'], general_xsize, general_ysize}, -- U
		 [39]  = {latin['V'], general_xsize, general_ysize}, -- V
		 [40]  = {latin['W'], general_xsize, general_ysize}, -- W
		 [41]  = {latin['X'], general_xsize, general_ysize}, -- X
		 [42]  = {latin['Y'], general_xsize, general_ysize}, -- Y
		 [43]  = {latin['Z'], general_xsize, general_ysize}, -- Z
		 [44]  = {91, general_xsize, general_ysize}, -- [
		 [45]  = {93, general_xsize, general_ysize}, -- ]
		 [46]  = {44, general_xsize, general_ysize}, -- ,
		 [47]  = {111, general_xsize, general_ysize}, -- o
		 [48]  = {94, general_xsize, general_ysize}, -- ^
		 [49]  = {59, general_xsize, general_ysize}} -- ;
}

fontdescription["font_general_loc"] = fontdescription_cmn["font_general_loc"]
