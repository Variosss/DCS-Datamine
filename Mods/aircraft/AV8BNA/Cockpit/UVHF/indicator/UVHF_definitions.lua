dofile(LockOn_Options.common_script_path.."elements_defs.lua")

UVHF_DEFAULT_LEVEL     = 5

SetScale(FOV)

UVHF_scale		= 0.55/275
UVHF_grid_scale	= 0.50/275
UVHF_hdg_scale	= 0.70/275
UVHF_hdg_displ	= (3448 * UVHF_hdg_scale / 480) * GetScale()

symbol_pixels_x =  44.0 * 2 -- pi
symbol_pixels_y =  72.0 * 2

--- Colors Definitions ---

UVHF_GREEN	= {0, 255, 0, 255}
UVHF_BLACK	= {0, 0, 0, 255}


---- Fonts Definition ----
local resources_path_f = LockOn_Options.script_path.."Resources/Fonts/"

UVHF_default_font_size   = {0.010, 0.010}
RADIO_default_font_size  = {0.015, 0.015}

symbol_pixels_x =  44.0 * 2
symbol_pixels_y =  72.0 * 2

PANEL_xsize = 29.0 * 2
PANEL_ysize = 64.0 * 2

local UVHF_font_desc = {
	texture		= resources_path_f.."font_LCD_AV8B.dds",
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
		 [48]  = {94 , symbol_pixels_x, symbol_pixels_y}, -- ^
	}
}

local UVHF_font2_desc = {
	texture		= resources_path_f.."font_LCD3_AV8B.dds",
	size		= {8, 8},
	resolution	= {1024, 1024},
	default		= {PANEL_xsize, PANEL_ysize},
	chars		= {
		[1]   = {64,  PANEL_xsize, PANEL_ysize}, -- @ == ©
		[2]   = {18,  PANEL_xsize, PANEL_ysize}, -- ^ == \18
		[3]   = {20,  PANEL_xsize, PANEL_ysize}, -- ¶ == [] == \20
		[4]   = {26,  PANEL_xsize, PANEL_ysize}, -- > == -> == \26
		[5]   = {27,  PANEL_xsize, PANEL_ysize}, -- < == <- == \27
		[6]   = {31,  PANEL_xsize, PANEL_ysize}, -- SPARE 
		[7]   = {126, PANEL_xsize, PANEL_ysize}, -- ~
		[8]   = {32,  PANEL_xsize, PANEL_ysize}, -- [space]
		[9]   = {33,  PANEL_xsize, PANEL_ysize}, -- !
		[10]  = {35,  PANEL_xsize, PANEL_ysize}, -- #
		[11]  = {40,  PANEL_xsize, PANEL_ysize}, -- (
		[12]  = {41,  PANEL_xsize, PANEL_ysize}, -- )
		[13]  = {42,  PANEL_xsize, PANEL_ysize}, -- *
		[14]  = {43,  PANEL_xsize, PANEL_ysize}, -- +
		[15]  = {45,  PANEL_xsize, PANEL_ysize}, -- -
		[16]  = {46,  PANEL_xsize, PANEL_ysize}, -- .
		[17]  = {47,  PANEL_xsize, PANEL_ysize}, -- /
		[18]  = {48,  PANEL_xsize, PANEL_ysize}, -- 0
		[19]  = {49,  PANEL_xsize, PANEL_ysize}, -- 1
		[20]  = {50,  PANEL_xsize, PANEL_ysize}, -- 2
		[21]  = {51,  PANEL_xsize, PANEL_ysize}, -- 3
		[22]  = {52,  PANEL_xsize, PANEL_ysize}, -- 4
		[23]  = {53,  PANEL_xsize, PANEL_ysize}, -- 5
		[24]  = {54,  PANEL_xsize, PANEL_ysize}, -- 6
		[25]  = {55,  PANEL_xsize, PANEL_ysize}, -- 7
		[26]  = {56,  PANEL_xsize, PANEL_ysize}, -- 8
		[27]  = {57,  PANEL_xsize, PANEL_ysize}, -- 9
		[28]  = {58,  PANEL_xsize, PANEL_ysize}, -- :
		[29]  = {61,  PANEL_xsize, PANEL_ysize}, -- =
		[30]  = {63,  PANEL_xsize, PANEL_ysize}, -- ?
		[31]  = {65,  PANEL_xsize, PANEL_ysize}, -- A
		[32]  = {66,  PANEL_xsize, PANEL_ysize}, -- B
		[33]  = {67,  PANEL_xsize, PANEL_ysize}, -- C
		[34]  = {68,  PANEL_xsize, PANEL_ysize}, -- D
		[35]  = {69,  PANEL_xsize, PANEL_ysize}, -- E
		[36]  = {70,  PANEL_xsize, PANEL_ysize}, -- F
		[37]  = {71,  PANEL_xsize, PANEL_ysize}, -- G
		[38]  = {72,  PANEL_xsize, PANEL_ysize}, -- H
		[39]  = {73,  PANEL_xsize, PANEL_ysize}, -- I
		[40]  = {74,  PANEL_xsize, PANEL_ysize}, -- J
		[41]  = {75,  PANEL_xsize, PANEL_ysize}, -- K
		[42]  = {76,  PANEL_xsize, PANEL_ysize}, -- L
		[43]  = {77,  PANEL_xsize, PANEL_ysize}, -- M
		[44]  = {78,  PANEL_xsize, PANEL_ysize}, -- N
		[45]  = {79,  PANEL_xsize, PANEL_ysize}, -- O
		[46]  = {80,  PANEL_xsize, PANEL_ysize}, -- P
		[47]  = {81,  PANEL_xsize, PANEL_ysize}, -- Q
		[48]  = {82,  PANEL_xsize, PANEL_ysize}, -- R
		[49]  = {83,  PANEL_xsize, PANEL_ysize}, -- S
		[50]  = {84,  PANEL_xsize, PANEL_ysize}, -- T
		[51]  = {85,  PANEL_xsize, PANEL_ysize}, -- U
		[52]  = {86,  PANEL_xsize, PANEL_ysize}, -- V
		[53]  = {87,  PANEL_xsize, PANEL_ysize}, -- W
		[54]  = {88,  PANEL_xsize, PANEL_ysize}, -- X
		[55]  = {89,  PANEL_xsize, PANEL_ysize}, -- Y
		[56]  = {90,  PANEL_xsize, PANEL_ysize}, -- Z
		[57]  = {91,  PANEL_xsize, PANEL_ysize}, -- [
		[58]  = {93,  PANEL_xsize, PANEL_ysize}, -- ] 
		[59]  = {124, PANEL_xsize, PANEL_ysize}, -- | == ¦
		[60]  = {38,  PANEL_xsize, PANEL_ysize}, -- & == +- 
		[61]  = {59,  PANEL_xsize, PANEL_ysize}, -- ; == ° 
		[62]  = {95,  PANEL_xsize, PANEL_ysize}, -- _
		[63]  = {37,  PANEL_xsize, PANEL_ysize},-- %
	}
}

UVHF_font_base	= MakeFont(UVHF_font_desc,  UVHF_BLACK,	"UVHF_font_base")
UVHF_font_chnl	= MakeFont(UVHF_font2_desc, UVHF_BLACK,	"UVHF_font_chnl")


----- UVHF Functions -----
function Add_Radio_Element(object)
	object.use_mipfilter      = true
	object.h_clip_relation    = h_clip_relations.COMPARE
	object.level			  = UVHF_DEFAULT_LEVEL
	object.additive_alpha     = true --additive blending
	object.collimated 		  = false
	Add(object)
end
