dofile(LockOn_Options.common_script_path.."Fonts/symbols_locale.lua")
dofile(LockOn_Options.common_script_path.."Fonts/fonts_cmn.lua")

fontdescription = {}

local ALR_300_TexturesPath = LockOn_Options.script_path.."../../Common/Resources/IndicationTextures/ALR_300/"

local ALR_300_xsize 		= 67
local ALR_300_ysize 		= 128
fontdescription["FONT_ALR_300"] = {
	--texture    		= ALR_300_TexturesPath.."FONT_F1_ALR_300.tga",
	texture    		= ALR_300_TexturesPath.."FONT_F1_ALR_300.dds",
	size      		= {8, 8},
	resolution 		= {1024, 1024},
	default    		= {ALR_300_xsize, ALR_300_ysize},
	chars	     	= {
	   [1]   = {32, ALR_300_xsize, ALR_300_ysize}, -- [space]
	   [2]   = {48, ALR_300_xsize, ALR_300_ysize}, -- 0
	   [3]   = {49, ALR_300_xsize, ALR_300_ysize}, -- 1
	   [4]   = {50, ALR_300_xsize, ALR_300_ysize}, -- 2
	   [5]   = {51, ALR_300_xsize, ALR_300_ysize}, -- 3
	   [6]   = {52, ALR_300_xsize, ALR_300_ysize}, -- 4
	   [7]   = {53, ALR_300_xsize, ALR_300_ysize}, -- 5
	   [8]   = {54, ALR_300_xsize, ALR_300_ysize}, -- 6
	   [9]   = {55, ALR_300_xsize, ALR_300_ysize}, -- 7
	   [10]  = {56, ALR_300_xsize, ALR_300_ysize}, -- 8
	   [11]  = {57, ALR_300_xsize, ALR_300_ysize}, -- 9
	   [12]  = {65, ALR_300_xsize, ALR_300_ysize}, -- A
	   [13]  = {66, ALR_300_xsize, ALR_300_ysize}, -- B
	   [14]  = {67, ALR_300_xsize, ALR_300_ysize}, -- C
	   [15]  = {68, ALR_300_xsize, ALR_300_ysize}, -- D
	   [16]  = {69, ALR_300_xsize, ALR_300_ysize}, -- E
	   [17]  = {70, ALR_300_xsize, ALR_300_ysize}, -- F
	   [18]  = {71, ALR_300_xsize, ALR_300_ysize}, -- G
	   [19]  = {72, ALR_300_xsize, ALR_300_ysize}, -- H
	   [20]  = {73, ALR_300_xsize, ALR_300_ysize}, -- I
	   [21]  = {74, ALR_300_xsize, ALR_300_ysize}, -- J
	   [22]  = {75, ALR_300_xsize, ALR_300_ysize}, -- K
	   [23]  = {76, ALR_300_xsize, ALR_300_ysize}, -- L
	   [24]  = {77, ALR_300_xsize, ALR_300_ysize}, -- M
	   [25]  = {78, ALR_300_xsize, ALR_300_ysize}, -- N
	   [26]  = {79, ALR_300_xsize, ALR_300_ysize}, -- O
	   [27]  = {80, ALR_300_xsize, ALR_300_ysize}, -- P
	   [28]  = {81, ALR_300_xsize, ALR_300_ysize}, -- Q
	   [29]  = {82, ALR_300_xsize, ALR_300_ysize}, -- R
	   [30]  = {83, ALR_300_xsize, ALR_300_ysize}, -- S
	   [31]  = {84, ALR_300_xsize, ALR_300_ysize}, -- T
	   [32]  = {85, ALR_300_xsize, ALR_300_ysize}, -- U
	   [33]  = {86, ALR_300_xsize, ALR_300_ysize}, -- V
	   [34]  = {87, ALR_300_xsize, ALR_300_ysize}, -- W
	   [35]  = {88, ALR_300_xsize, ALR_300_ysize}, -- X
	   [36]  = {89, ALR_300_xsize, ALR_300_ysize}, -- Y
	   [37]  = {90, ALR_300_xsize, ALR_300_ysize}, -- Z
	   [38]  = {45, ALR_300_xsize, ALR_300_ysize}, -- -
	}
}
