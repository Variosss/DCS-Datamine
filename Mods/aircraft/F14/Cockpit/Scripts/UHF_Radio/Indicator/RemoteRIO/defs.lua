dofile(LockOn_Options.common_script_path.."elements_defs.lua")

SetScale(FOV)

UHF_DEFAULT_LEVEL = 40
UHF_NOCLIP_LEVEL  = UHF_DEFAULT_LEVEL

-- material
BASE_COLOR = {20,220,20,220} -- white
BG_COLOR_OLD = {13,67,40,60}
BG_COLOR = {5,53,0,255}

DIGIT_RED = {191,11,12,220}
DIGIT_SHADOW = {191,11,12,220}

COLOR_GREEN = {0,255,0,255}
COLOR_RED = {255,0,0,255}
COLOR_BLUE = {0,0,255,255}
COLOR_WHITE = {255,255,255,255}
COLOR_PURPLE = {160,32,240,255}
COLOR_YELLOW = {255,255,0,255}
COLOR_BLACK = {0,0,0,255}
COLOR_TRANSPARENT = {0,255,255,128}

SYMBOL_PIXELS_X =  58 * 2 -- pi
SYMBOL_PIXELS_Y =  72.0 * 2

IndTexture_Path = LockOn_Options.script_path.."Resources/IndicationTextures/"

font_desc = {
	texture     = IndTexture_Path.."font_digit.dds",
	size        = {7, 7},
	resolution  = {1024, 1024},
	default     = {SYMBOL_PIXELS_X, SYMBOL_PIXELS_Y},
	chars	    = {
		 [1]   = {32, SYMBOL_PIXELS_X, SYMBOL_PIXELS_Y}, -- [space]
		 [2]   = {42, SYMBOL_PIXELS_X, SYMBOL_PIXELS_Y}, -- *
		 [3]   = {43, SYMBOL_PIXELS_X, SYMBOL_PIXELS_Y}, -- +
		 [4]   = {45, SYMBOL_PIXELS_X, SYMBOL_PIXELS_Y}, -- -
		 [5]   = {46, SYMBOL_PIXELS_X, SYMBOL_PIXELS_Y}, -- .
		 [6]   = {47, SYMBOL_PIXELS_X, SYMBOL_PIXELS_Y}, -- /
		 [7]   = {48, SYMBOL_PIXELS_X, SYMBOL_PIXELS_Y}, -- 0
		 [8]   = {49, SYMBOL_PIXELS_X, SYMBOL_PIXELS_Y}, -- 1
		 [9]   = {50, SYMBOL_PIXELS_X, SYMBOL_PIXELS_Y}, -- 2
		 [10]  = {51, SYMBOL_PIXELS_X, SYMBOL_PIXELS_Y}, -- 3
		 [11]  = {52, SYMBOL_PIXELS_X, SYMBOL_PIXELS_Y}, -- 4
		 [12]  = {53, SYMBOL_PIXELS_X, SYMBOL_PIXELS_Y}, -- 5
		 [13]  = {54, SYMBOL_PIXELS_X, SYMBOL_PIXELS_Y}, -- 6
		 [14]  = {55, SYMBOL_PIXELS_X, SYMBOL_PIXELS_Y}, -- 7
		 [15]  = {56, SYMBOL_PIXELS_X, SYMBOL_PIXELS_Y}, -- 8
		 [16]  = {57, SYMBOL_PIXELS_X, SYMBOL_PIXELS_Y}, -- 9
		 [17]  = {58, SYMBOL_PIXELS_X, SYMBOL_PIXELS_Y}, -- :
		 [18]  = {65, SYMBOL_PIXELS_X, SYMBOL_PIXELS_Y}, -- A
		 [19]  = {66, SYMBOL_PIXELS_X, SYMBOL_PIXELS_Y}, -- B
		 [20]  = {67, SYMBOL_PIXELS_X, SYMBOL_PIXELS_Y}, -- C
		 [21]  = {68, SYMBOL_PIXELS_X, SYMBOL_PIXELS_Y}, -- D
		 [22]  = {69, SYMBOL_PIXELS_X, SYMBOL_PIXELS_Y}, -- E
		 [23]  = {70, SYMBOL_PIXELS_X, SYMBOL_PIXELS_Y}, -- F
		 [24]  = {71, SYMBOL_PIXELS_X, SYMBOL_PIXELS_Y}, -- G
		 [25]  = {72, SYMBOL_PIXELS_X, SYMBOL_PIXELS_Y}, -- H
		 [26]  = {73, SYMBOL_PIXELS_X, SYMBOL_PIXELS_Y}, -- I
		 [27]  = {74, SYMBOL_PIXELS_X, SYMBOL_PIXELS_Y}, -- J
		 [28]  = {75, SYMBOL_PIXELS_X, SYMBOL_PIXELS_Y}, -- K
		 [29]  = {76, SYMBOL_PIXELS_X, SYMBOL_PIXELS_Y}, -- L
		 [30]  = {77, SYMBOL_PIXELS_X, SYMBOL_PIXELS_Y}, -- M
		 [31]  = {78, SYMBOL_PIXELS_X, SYMBOL_PIXELS_Y}, -- N
		 [32]  = {79, SYMBOL_PIXELS_X, SYMBOL_PIXELS_Y}, -- O
		 [33]  = {80, SYMBOL_PIXELS_X, SYMBOL_PIXELS_Y}, -- P
		 [34]  = {81, SYMBOL_PIXELS_X, SYMBOL_PIXELS_Y}, -- Q
		 [35]  = {82, SYMBOL_PIXELS_X, SYMBOL_PIXELS_Y}, -- R
		 [36]  = {83, SYMBOL_PIXELS_X, SYMBOL_PIXELS_Y}, -- S
		 [37]  = {84, SYMBOL_PIXELS_X, SYMBOL_PIXELS_Y}, -- T
		 [38]  = {85, SYMBOL_PIXELS_X, SYMBOL_PIXELS_Y}, -- U
		 [39]  = {86, SYMBOL_PIXELS_X, SYMBOL_PIXELS_Y}, -- V
		 [40]  = {87, SYMBOL_PIXELS_X, SYMBOL_PIXELS_Y}, -- W
		 [41]  = {88, SYMBOL_PIXELS_X, SYMBOL_PIXELS_Y}, -- X
		 [42]  = {89, SYMBOL_PIXELS_X, SYMBOL_PIXELS_Y}, -- Y
		 [43]  = {90, SYMBOL_PIXELS_X, SYMBOL_PIXELS_Y}, -- Z
		 [44]  = {91, SYMBOL_PIXELS_X, SYMBOL_PIXELS_Y}, -- [
		 [45]  = {93, SYMBOL_PIXELS_X, SYMBOL_PIXELS_Y}, -- ]
		 [46]  = {62, SYMBOL_PIXELS_X, SYMBOL_PIXELS_Y}, -- >
		 [47]  = {111,SYMBOL_PIXELS_X, SYMBOL_PIXELS_Y}, -- o
		 [48]  = {94, SYMBOL_PIXELS_X, SYMBOL_PIXELS_Y}} -- ^
}

UHF_FONT_GREEN = MakeFont(font_desc, COLOR_GREEN, "UHF_FONT_GREEN")
UHF_FONT_RED   = MakeFont(font_desc, COLOR_RED,   "UHF_FONT_RED")
UHF_FONT_BLUE  = MakeFont(font_desc, COLOR_BLUE,  "UHF_FONT_BLUE")
UHF_FONT_WHITE = MakeFont(font_desc, COLOR_WHITE, "UHF_FONT_WHITE")
UHF_FONT_BLACK = MakeFont(font_desc, COLOR_BLACK, "UHF_FONT_BLACK")

UHF_FONT_BASE  = MakeFont(font_desc, BASE_COLOR,  "UHF_FONT_BASE")

UHF_DIGIT_RED  = MakeFont(font_desc, DIGIT_RED,   "UHF_DIGIT_RED")
UHF_SHADOW_RED = MakeFont(font_desc, DIGIT_SHADOW, "UHF_SHADOW_RED")

UHF_FONT_SIZE = 0.005
DEF_BOX_INDICES = { 0,1,2, 0,2,3 }

fontscale = 1 -- 0.75
fontsize = UHF_FONT_SIZE
fontshrink = 0

UHF_BCOLOR = MakeMaterial(nil,BASE_COLOR)
UHF_GREEN = MakeMaterial(nil,COLOR_GREEN)
UHF_RED      = MakeMaterial(nil,COLOR_RED)
UHF_BLACK = MakeMaterial(nil,COLOR_BLACK)
UHF_WHITE = MakeMaterial(nil,COLOR_WHITE)


UHF_BG_MAT = MakeMaterial(nil,{13,67,40,255})

UHF_TRANSPARENT = MakeMaterial(nil,{0,255,255,128})
BACKGROUND_MAT = MakeMaterial(nil,BG_COLOR_OLD)

uhf_strdefs = {UHF_FONT_SIZE, UHF_FONT_SIZE, 0, 0}

custom_init_pos = {0, 0, 0}
scale = 0.6 -- custom scale up for FOV  -- 450: custom scale up for MILLYRADIUS
tex_dim = 2048
tex_dim_half = tex_dim/2

_screen_origin = {0, 0, 0}
_screen_rotation = {0, 0, 0}

