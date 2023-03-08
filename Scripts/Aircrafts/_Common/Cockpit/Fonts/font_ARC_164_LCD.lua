
local UHF_xsize = 48
local UHF_ysize = 65

fontdescription_ARC_164_LCD = {
	texture    = "Fonts/font_ARC_164_LCD.tga",
	size      = {4, 4},
	resolution = {256, 256},
	default    = {UHF_xsize, UHF_ysize},
	chars	     = {
	   [1]   = {32, UHF_xsize, UHF_ysize}, -- [space]
	   [2]   = {48, UHF_xsize, UHF_ysize}, -- 0
	   [3]   = {49, UHF_xsize, UHF_ysize}, -- 1
	   [4]   = {50, UHF_xsize, UHF_ysize}, -- 2
	   [5]   = {51, UHF_xsize, UHF_ysize}, -- 3
	   [6]   = {52, UHF_xsize, UHF_ysize}, -- 4
	   [7]   = {53, UHF_xsize, UHF_ysize}, -- 5
	   [8]   = {54, UHF_xsize, UHF_ysize}, -- 6
	   [9]   = {55, UHF_xsize, UHF_ysize}, -- 7
	   [10]  = {56, UHF_xsize, UHF_ysize}, -- 8
	   [11]  = {57, UHF_xsize, UHF_ysize}, -- 9
	   [12]  = {42, UHF_xsize, UHF_ysize}, -- 0*
	   [13]  = {46, 28, UHF_ysize},        -- .
	   [14]  = {65, UHF_xsize, UHF_ysize}, -- A
	}
}
