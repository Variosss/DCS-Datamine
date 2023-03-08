dofile(LockOn_Options.common_script_path.."elements_defs.lua")

SetScale(MILLYRADIANS)

HUD_DEFAULT_LEVEL = 9
HUD_NOCLIP_LEVEL  = HUD_DEFAULT_LEVEL - 1


-- Font from A-10C
symbol_pixels_x =   44 * 2 -- pi
symbol_pixels_y =  72.0 * 2
local font_desc = {
	texture     = "Mods/aircrafts/A-10C/Cockpit/Resources/IndicationTextures/font_HUD_A10.tga",
	size        = {7, 7},
	resolution  = {1024, 1024},
	default     = {symbol_pixels_x, symbol_pixels_y},
	chars	    = {
		 
		 [1]   = {32, symbol_pixels_x, symbol_pixels_y}, -- [space]
		 [2]   = {42, symbol_pixels_x, symbol_pixels_y}, -- *
		 [3]   = {43, symbol_pixels_x, symbol_pixels_y}, -- +
		 [4]   = {45, symbol_pixels_x, symbol_pixels_y}, -- -
		 [5]   = {46, symbol_pixels_x, symbol_pixels_y}, -- .
		 [6]   = {47, symbol_pixels_x, symbol_pixels_y}, -- /
		 [7]   = {48, symbol_pixels_x, symbol_pixels_y}, -- 0
		 [8]   = {49, symbol_pixels_x, symbol_pixels_y}, -- 1
		 [9]   = {50, symbol_pixels_x, symbol_pixels_y}, -- 2
		 [10]  = {51, symbol_pixels_x, symbol_pixels_y}, -- 3
		 [11]  = {52, symbol_pixels_x, symbol_pixels_y}, -- 4
		 [12]  = {53, symbol_pixels_x, symbol_pixels_y}, -- 5
		 [13]  = {54, symbol_pixels_x, symbol_pixels_y}, -- 6
		 [14]  = {55, symbol_pixels_x, symbol_pixels_y}, -- 7
		 [15]  = {56, symbol_pixels_x, symbol_pixels_y}, -- 8
		 [16]  = {57, symbol_pixels_x, symbol_pixels_y}, -- 9
		 [17]  = {58, symbol_pixels_x, symbol_pixels_y}, -- :
		 [18]  = {65, symbol_pixels_x, symbol_pixels_y}, -- A
		 [19]  = {66, symbol_pixels_x, symbol_pixels_y}, -- B
		 [20]  = {67, symbol_pixels_x, symbol_pixels_y}, -- C
		 [21]  = {68, symbol_pixels_x, symbol_pixels_y}, -- D
		 [22]  = {69, symbol_pixels_x, symbol_pixels_y}, -- E
		 [23]  = {70, symbol_pixels_x, symbol_pixels_y}, -- F
		 [24]  = {71, symbol_pixels_x, symbol_pixels_y}, -- G
		 [25]  = {72, symbol_pixels_x, symbol_pixels_y}, -- H
		 [26]  = {73, symbol_pixels_x, symbol_pixels_y}, -- I
		 [27]  = {74, symbol_pixels_x, symbol_pixels_y}, -- J
		 [28]  = {75, symbol_pixels_x, symbol_pixels_y}, -- K
		 [29]  = {76, symbol_pixels_x, symbol_pixels_y}, -- L
		 [30]  = {77, symbol_pixels_x, symbol_pixels_y}, -- M
		 [31]  = {78, symbol_pixels_x, symbol_pixels_y}, -- N
		 [32]  = {79, symbol_pixels_x, symbol_pixels_y}, -- O
		 [33]  = {80, symbol_pixels_x, symbol_pixels_y}, -- P
		 [34]  = {81, symbol_pixels_x, symbol_pixels_y}, -- Q
		 [35]  = {82, symbol_pixels_x, symbol_pixels_y}, -- R
		 [36]  = {83, symbol_pixels_x, symbol_pixels_y}, -- S
		 [37]  = {84, symbol_pixels_x, symbol_pixels_y}, -- T
		 [38]  = {85, symbol_pixels_x, symbol_pixels_y}, -- U
		 [39]  = {86, symbol_pixels_x, symbol_pixels_y}, -- V
		 [40]  = {87, symbol_pixels_x, symbol_pixels_y}, -- W
		 [41]  = {88, symbol_pixels_x, symbol_pixels_y}, -- X
		 [42]  = {89, symbol_pixels_x, symbol_pixels_y}, -- Y
		 [43]  = {90, symbol_pixels_x, symbol_pixels_y}, -- Z
		 [44]  = {91, symbol_pixels_x, symbol_pixels_y}, -- [
		 [45]  = {93, symbol_pixels_x, symbol_pixels_y}, -- ]
		 [46]  = {62, symbol_pixels_x, symbol_pixels_y}, -- >
		 [47]  = {111, symbol_pixels_x, symbol_pixels_y}, -- o
		 [48]  = {94 ,  symbol_pixels_x, symbol_pixels_y}} -- ^
}


indication_font   = MakeFont(font_desc,{0,255,255,255},"indication_font")
font_size_default = {0.005,0.005}

