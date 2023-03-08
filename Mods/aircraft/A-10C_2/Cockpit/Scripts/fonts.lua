dofile(LockOn_Options.common_script_path.."Fonts/symbols_locale.lua")
dofile(LockOn_Options.common_script_path.."Fonts/fonts_cmn.lua")

local IndicationTexturesPath = LockOn_Options.script_path.."../IndicationTextures/"

fontdescription = {}

dofile(LockOn_Options.common_script_path.."Fonts/font_ALQ_213.lua")
fontdescription["font_CMS"] = fontdescription_ALQ_213


MFCD_size_mult = 2
MFCD_xsize = 29 * MFCD_size_mult
MFCD_ysize = 64 * MFCD_size_mult
fontdescription["font_MFCD"] = {
		 texture    = IndicationTexturesPath.."font_MFCD_A10C.tga",
		 size      = {8, 8},
		 resolution = {1024, 1024},
		 default    = {MFCD_xsize, MFCD_ysize},
		 chars	    = {
			  [1]   = {CP1251_toUTF8[169],MFCD_xsize, MFCD_ysize}, -- 0 == ©
			  [2]   = {18, MFCD_xsize, MFCD_ysize}, -- ¦ == \18
			  [3]   = {20, MFCD_xsize, MFCD_ysize}, -- ¶ == [] = \20
			  [4]   = {26, MFCD_xsize, MFCD_ysize}, -- -> == \26
			  [5]   = {27, MFCD_xsize, MFCD_ysize}, -- <- == \27
			  [6]   = {31, MFCD_xsize, MFCD_ysize}, -- SPARE
			  [7]   = {126,MFCD_xsize, MFCD_ysize}, -- ~
			  [8]   = {32, MFCD_xsize, MFCD_ysize}, -- [space]
			  [9]   = {33, MFCD_xsize, MFCD_ysize}, -- !
			  [10]  = {35, MFCD_xsize, MFCD_ysize}, -- #
			  [11]  = {40, MFCD_xsize, MFCD_ysize}, -- (
			  [12]  = {41, MFCD_xsize, MFCD_ysize}, -- )
			  [13]  = {42, MFCD_xsize, MFCD_ysize}, -- *
			  [14]  = {43, MFCD_xsize, MFCD_ysize}, -- +
			  [15]  = {45, MFCD_xsize, MFCD_ysize}, -- -
			  [16]  = {46, MFCD_xsize, MFCD_ysize}, -- .
			  [17]  = {47, MFCD_xsize, MFCD_ysize}, -- /
			  [18]  = {48, MFCD_xsize, MFCD_ysize}, -- 0
			  [19]  = {49, MFCD_xsize, MFCD_ysize}, -- 1
			  [20]  = {50, MFCD_xsize, MFCD_ysize}, -- 2
			  [21]  = {51, MFCD_xsize, MFCD_ysize}, -- 3
			  [22]  = {52, MFCD_xsize, MFCD_ysize}, -- 4
			  [23]  = {53, MFCD_xsize, MFCD_ysize}, -- 5
			  [24]  = {54, MFCD_xsize, MFCD_ysize}, -- 6
			  [25]  = {55, MFCD_xsize, MFCD_ysize}, -- 7
			  [26]  = {56, MFCD_xsize, MFCD_ysize}, -- 8
			  [27]  = {57, MFCD_xsize, MFCD_ysize}, -- 9
			  [28]  = {58, MFCD_xsize, MFCD_ysize}, -- :
			  [29]  = {61, MFCD_xsize, MFCD_ysize}, -- =
			  [30]  = {63, MFCD_xsize, MFCD_ysize}, -- ?
			  [31]  = {65, MFCD_xsize, MFCD_ysize}, -- A
			  [32]  = {66, MFCD_xsize, MFCD_ysize}, -- B
			  [33]  = {67, MFCD_xsize, MFCD_ysize}, -- C
			  [34]  = {68, MFCD_xsize, MFCD_ysize}, -- D
			  [35]  = {69, MFCD_xsize, MFCD_ysize}, -- E
			  [36]  = {70, MFCD_xsize, MFCD_ysize}, -- F
			  [37]  = {71, MFCD_xsize, MFCD_ysize}, -- G
			  [38]  = {72, MFCD_xsize, MFCD_ysize}, -- H
			  [39]  = {73, MFCD_xsize, MFCD_ysize}, -- I
			  [40]  = {74, MFCD_xsize, MFCD_ysize}, -- J
			  [41]  = {75, MFCD_xsize, MFCD_ysize}, -- K
			  [42]  = {76, MFCD_xsize, MFCD_ysize}, -- L
			  [43]  = {77, MFCD_xsize, MFCD_ysize}, -- M
			  [44]  = {78, MFCD_xsize, MFCD_ysize}, -- N
			  [45]  = {79, MFCD_xsize, MFCD_ysize}, -- O
			  [46]  = {80, MFCD_xsize, MFCD_ysize}, -- P
			  [47]  = {81, MFCD_xsize, MFCD_ysize}, -- Q
			  [48]  = {82, MFCD_xsize, MFCD_ysize}, -- R
			  [49]  = {83, MFCD_xsize, MFCD_ysize}, -- S
			  [50]  = {84, MFCD_xsize, MFCD_ysize}, -- T
			  [51]  = {85, MFCD_xsize, MFCD_ysize}, -- U
			  [52]  = {86, MFCD_xsize, MFCD_ysize}, -- V
			  [53]  = {87, MFCD_xsize, MFCD_ysize}, -- W
			  [54]  = {88, MFCD_xsize, MFCD_ysize}, -- X
			  [55]  = {89, MFCD_xsize, MFCD_ysize}, -- Y
			  [56]  = {90, MFCD_xsize, MFCD_ysize}, -- Z
			  [57]  = {91, MFCD_xsize, MFCD_ysize}, -- [
			  [58]  = {93, MFCD_xsize, MFCD_ysize}, -- ]
			  [59]  = {CP1251_toUTF8[219],30 * MFCD_size_mult, MFCD_ysize}, -- - 
			  [60]  = {CP1251_toUTF8[241],MFCD_xsize, MFCD_ysize}, -- +- 
			  [61]  = {CP1251_toUTF8[176],MFCD_xsize, MFCD_ysize}, -- ° 
			  [62]  = {95, MFCD_xsize, MFCD_ysize}, -- _
			  [63]  = {37, MFCD_xsize, MFCD_ysize}}-- %
}

DC_xsize = 38
DC_ysize = 65
fontdescription["font_DIGIT_CLK"] = {
	texture    = IndicationTexturesPath.."font_DigitClock.tga",
	size      = {4, 4},
	resolution = {256, 256},
	default    = {DC_xsize, DC_ysize},
	chars	     = {
	   [1]   = {32, DC_xsize, DC_ysize}, -- [space]
	   [2]   = {48, DC_xsize, DC_ysize}, -- 0
	   [3]   = {49, DC_xsize, DC_ysize}, -- 1
	   [4]   = {50, DC_xsize, DC_ysize}, -- 2
	   [5]   = {51, DC_xsize, DC_ysize}, -- 3
	   [6]   = {52, DC_xsize, DC_ysize}, -- 4
	   [7]   = {53, DC_xsize, DC_ysize}, -- 5
	   [8]   = {54, DC_xsize, DC_ysize}, -- 6
	   [9]   = {55, DC_xsize, DC_ysize}, -- 7
	   [10]  = {56, DC_xsize, DC_ysize}, -- 8
	   [11]  = {57, DC_xsize, DC_ysize}, -- 9
	   [12]  = {58, 15, DC_ysize},       -- :
	   [13]  = {67, DC_xsize, DC_ysize}, -- C
	   [14]  = {69, DC_xsize, DC_ysize}, -- E
	   [15]  = {84, DC_xsize, DC_ysize}} -- T
}

CDU_xsize = 55
CDU_ysize = 61
fontdescription["font_CDU"] = {
	texture    = IndicationTexturesPath.."font_A-10_CDU.tga",
	size      = {8, 8},
	resolution = {512, 512},
	default    = {CDU_xsize, CDU_ysize},
	chars	   = {
		 [1]   = {CP1251_toUTF8[169],CDU_xsize, CDU_ysize}, -- 0 == ©
		 [2]   = {18, CDU_xsize, CDU_ysize}, -- ¦ == \18
		 [3]   = {20, CDU_xsize, CDU_ysize}, -- ¶ == [] = \20
		 [4]   = {26, CDU_xsize, CDU_ysize}, -- -> == \26
		 [5]   = {27, CDU_xsize, CDU_ysize}, -- <- == \27
		 [6]   = {32, CDU_xsize, CDU_ysize}, -- [space]
		 [7]   = {33, CDU_xsize, CDU_ysize}, -- !
		 [8]   = {35, CDU_xsize, CDU_ysize}, -- #
		 [9]   = {40, CDU_xsize, CDU_ysize}, -- (
		 [10]  = {41, CDU_xsize, CDU_ysize}, -- )
		 [11]  = {42, CDU_xsize, CDU_ysize}, -- *
		 [12]  = {43, CDU_xsize, CDU_ysize}, -- +
		 [13]  = {45, CDU_xsize, CDU_ysize}, -- -
		 [14]  = {46, CDU_xsize, CDU_ysize}, -- .
		 [15]  = {47, CDU_xsize, CDU_ysize}, -- /
		 [16]  = {48, CDU_xsize, CDU_ysize}, -- 0
		 [17]  = {49, CDU_xsize, CDU_ysize}, -- 1
		 [18]  = {50, CDU_xsize, CDU_ysize}, -- 2
		 [19]  = {51, CDU_xsize, CDU_ysize}, -- 3
		 [20]  = {52, CDU_xsize, CDU_ysize}, -- 4
		 [21]  = {53, CDU_xsize, CDU_ysize}, -- 5
		 [22]  = {54, CDU_xsize, CDU_ysize}, -- 6
		 [23]  = {55, CDU_xsize, CDU_ysize}, -- 7
		 [24]  = {56, CDU_xsize, CDU_ysize}, -- 8
		 [25]  = {57, CDU_xsize, CDU_ysize}, -- 9
		 [26]  = {58, CDU_xsize, CDU_ysize}, -- :
		 [27]  = {61, CDU_xsize, CDU_ysize}, -- =
		 [28]  = {63, CDU_xsize, CDU_ysize}, -- ?
		 [29]  = {65, CDU_xsize, CDU_ysize}, -- A
		 [30]  = {66, CDU_xsize, CDU_ysize}, -- B
		 [31]  = {67, CDU_xsize, CDU_ysize}, -- C
		 [32]  = {68, CDU_xsize, CDU_ysize}, -- D
		 [33]  = {69, CDU_xsize, CDU_ysize}, -- E
		 [34]  = {70, CDU_xsize, CDU_ysize}, -- F
		 [35]  = {71, CDU_xsize, CDU_ysize}, -- G
		 [36]  = {72, CDU_xsize, CDU_ysize}, -- H
		 [37]  = {73, CDU_xsize, CDU_ysize}, -- I
		 [38]  = {74, CDU_xsize, CDU_ysize}, -- J
		 [39]  = {75, CDU_xsize, CDU_ysize}, -- K
		 [40]  = {76, CDU_xsize, CDU_ysize}, -- L
		 [41]  = {77, CDU_xsize, CDU_ysize}, -- M
		 [42]  = {78, CDU_xsize, CDU_ysize}, -- N
		 [43]  = {79, CDU_xsize, CDU_ysize}, -- O
		 [44]  = {80, CDU_xsize, CDU_ysize}, -- P
		 [45]  = {81, CDU_xsize, CDU_ysize}, -- Q
		 [46]  = {82, CDU_xsize, CDU_ysize}, -- R
		 [47]  = {83, CDU_xsize, CDU_ysize}, -- S
		 [48]  = {84, CDU_xsize, CDU_ysize}, -- T
		 [49]  = {85, CDU_xsize, CDU_ysize}, -- U
		 [50]  = {86, CDU_xsize, CDU_ysize}, -- V
		 [51]  = {87, CDU_xsize, CDU_ysize}, -- W
		 [52]  = {88, CDU_xsize, CDU_ysize}, -- X
		 [53]  = {89, CDU_xsize, CDU_ysize}, -- Y
		 [54]  = {90, CDU_xsize, CDU_ysize}, -- Z
		 [55]  = {91, CDU_xsize, CDU_ysize}, -- [
		 [56]  = {93, CDU_xsize, CDU_ysize}, -- ]
		 [57]  = {CP1251_toUTF8[219],CDU_xsize, CDU_ysize}, -- -
		 [58]  = {CP1251_toUTF8[241],CDU_xsize, CDU_ysize}, -- +- 
		 [59]  = {CP1251_toUTF8[176],CDU_xsize, CDU_xsize}} -- ° 
}

HUD_xsize = 44 * 2
HUD_ysize = 72.0 * 2 --73.143 * 2
fontdescription["font_HUD"] = {
	texture    = IndicationTexturesPath.."font_HUD_A10.tga",
	size      = {7, 7},
	resolution = {1024, 1024},
	default    = {HUD_xsize, HUD_ysize},
	chars	    = {
		 [1]   = {32, HUD_xsize, HUD_ysize}, -- [space]
		 [2]   = {42, HUD_xsize, HUD_ysize}, -- *
		 [3]   = {43, HUD_xsize, HUD_ysize}, -- +
		 [4]   = {45, HUD_xsize, HUD_ysize}, -- -
		 [5]   = {46, HUD_xsize, HUD_ysize}, -- .
		 [6]   = {47, HUD_xsize, HUD_ysize}, -- /
		 [7]   = {48, HUD_xsize, HUD_ysize}, -- 0
		 [8]   = {49, HUD_xsize, HUD_ysize}, -- 1
		 [9]   = {50, HUD_xsize, HUD_ysize}, -- 2
		 [10]  = {51, HUD_xsize, HUD_ysize}, -- 3
		 [11]  = {52, HUD_xsize, HUD_ysize}, -- 4
		 [12]  = {53, HUD_xsize, HUD_ysize}, -- 5
		 [13]  = {54, HUD_xsize, HUD_ysize}, -- 6
		 [14]  = {55, HUD_xsize, HUD_ysize}, -- 7
		 [15]  = {56, HUD_xsize, HUD_ysize}, -- 8
		 [16]  = {57, HUD_xsize, HUD_ysize}, -- 9
		 [17]  = {58, HUD_xsize, HUD_ysize}, -- :
		 [18]  = {65, HUD_xsize, HUD_ysize}, -- A
		 [19]  = {66, HUD_xsize, HUD_ysize}, -- B
		 [20]  = {67, HUD_xsize, HUD_ysize}, -- C
		 [21]  = {68, HUD_xsize, HUD_ysize}, -- D
		 [22]  = {69, HUD_xsize, HUD_ysize}, -- E
		 [23]  = {70, HUD_xsize, HUD_ysize}, -- F
		 [24]  = {71, HUD_xsize, HUD_ysize}, -- G
		 [25]  = {72, HUD_xsize, HUD_ysize}, -- H
		 [26]  = {73, HUD_xsize, HUD_ysize}, -- I
		 [27]  = {74, HUD_xsize, HUD_ysize}, -- J
		 [28]  = {75, HUD_xsize, HUD_ysize}, -- K
		 [29]  = {76, HUD_xsize, HUD_ysize}, -- L
		 [30]  = {77, HUD_xsize, HUD_ysize}, -- M
		 [31]  = {78, HUD_xsize, HUD_ysize}, -- N
		 [32]  = {79, HUD_xsize, HUD_ysize}, -- O
		 [33]  = {80, HUD_xsize, HUD_ysize}, -- P
		 [34]  = {81, HUD_xsize, HUD_ysize}, -- Q
		 [35]  = {82, HUD_xsize, HUD_ysize}, -- R
		 [36]  = {83, HUD_xsize, HUD_ysize}, -- S
		 [37]  = {84, HUD_xsize, HUD_ysize}, -- T
		 [38]  = {85, HUD_xsize, HUD_ysize}, -- U
		 [39]  = {86, HUD_xsize, HUD_ysize}, -- V
		 [40]  = {87, HUD_xsize, HUD_ysize}, -- W
		 [41]  = {88, HUD_xsize, HUD_ysize}, -- X
		 [42]  = {89, HUD_xsize, HUD_ysize}, -- Y
		 [43]  = {90, HUD_xsize, HUD_ysize}, -- Z
		 [44]  = {91, HUD_xsize, HUD_ysize}, -- [
		 [45]  = {93, HUD_xsize, HUD_ysize}, -- ]
		 [46]  = {62, HUD_xsize, HUD_ysize}, -- >
		 [47]  = {111, HUD_xsize, HUD_ysize}, -- o
		 [48]  = {94, HUD_xsize, HUD_ysize}} -- ^
}

dofile(LockOn_Options.common_script_path.."Fonts/font_TGP_Litening_AT.lua")
fontdescription["font_TGP"] = fontdescription_TGP_Litening_AT

dofile(LockOn_Options.common_script_path.."Fonts/font_RWR.lua")
fontdescription["font_RWR"] = fontdescription_RWR

dofile(LockOn_Options.common_script_path.."Fonts/font_AGM_65E.lua")
fontdescription["font_AGM_65E"] = fontdescription_AGM_65E

dofile(LockOn_Options.common_script_path.."Fonts/font_ARC_164_LCD.lua")
fontdescription["font_UHF_RADIO"] = fontdescription_ARC_164_LCD

dofile(LockOn_Options.common_script_path.."Fonts/font_ARC_164_repeater_LCD.lua")
fontdescription["font_UHF_Repeater"] = fontdescription_ARC_164_repeater_LCD

STB_xsize = 38
STB_ysize = 65
fontdescription["font_HUD_STANDBY"] = {
	texture    = IndicationTexturesPath.."font_HUD_A10C_standby.tga",
	size      = {4, 4},
	resolution = {256, 256},
	default    = {STB_xsize, DC_ysize},
	chars	     = {
	   [1]   = {32, STB_xsize, STB_ysize}, -- [space]
	   [2]   = {48, STB_xsize, STB_ysize}, -- 0
	   [3]   = {49, STB_xsize, STB_ysize}, -- 1
	   [4]   = {50, STB_xsize, STB_ysize}, -- 2
	   [5]   = {51, STB_xsize, STB_ysize}, -- 3
	   [6]   = {52, STB_xsize, STB_ysize}, -- 4
	   [7]   = {53, STB_xsize, STB_ysize}, -- 5
	   [8]   = {54, STB_xsize, STB_ysize}, -- 6
	   [9]   = {55, STB_xsize, STB_ysize}, -- 7
	   [10]  = {56, STB_xsize, STB_ysize}, -- 8
	   [11]  = {57, STB_xsize, STB_ysize}, -- 9
	}
}

HMCS_xsize = 44 * 2
HMCS_ysize = 72.0 * 2
fontdescription["font_HMCS"] = {
	texture    = IndicationTexturesPath.."font_HMCS_A10.tga",
	size      = {7, 7},
	resolution = {1024, 1024},
	default    = {HMCS_xsize, HMCS_ysize},
	chars	    = {
		 [1]   = {32, HMCS_xsize, HMCS_ysize}, -- [space]
		 [2]   = {42, HMCS_xsize, HMCS_ysize}, -- *
		 [3]   = {43, HMCS_xsize, HMCS_ysize}, -- +
		 [4]   = {45, HMCS_xsize, HMCS_ysize}, -- -
		 [5]   = {46, HMCS_xsize, HMCS_ysize}, -- .
		 [6]   = {47, HMCS_xsize, HMCS_ysize}, -- /
		 [7]   = {48, HMCS_xsize, HMCS_ysize}, -- 0
		 [8]   = {49, HMCS_xsize, HMCS_ysize}, -- 1
		 [9]   = {50, HMCS_xsize, HMCS_ysize}, -- 2
		 [10]  = {51, HMCS_xsize, HMCS_ysize}, -- 3
		 [11]  = {52, HMCS_xsize, HMCS_ysize}, -- 4
		 [12]  = {53, HMCS_xsize, HMCS_ysize}, -- 5
		 [13]  = {54, HMCS_xsize, HMCS_ysize}, -- 6
		 [14]  = {55, HMCS_xsize, HMCS_ysize}, -- 7
		 [15]  = {56, HMCS_xsize, HMCS_ysize}, -- 8
		 [16]  = {57, HMCS_xsize, HMCS_ysize}, -- 9
		 [17]  = {58, HMCS_xsize, HMCS_ysize}, -- :
		 [18]  = {65, HMCS_xsize, HMCS_ysize}, -- A
		 [19]  = {66, HMCS_xsize, HMCS_ysize}, -- B
		 [20]  = {67, HMCS_xsize, HMCS_ysize}, -- C
		 [21]  = {68, HMCS_xsize, HMCS_ysize}, -- D
		 [22]  = {69, HMCS_xsize, HMCS_ysize}, -- E
		 [23]  = {70, HMCS_xsize, HMCS_ysize}, -- F
		 [24]  = {71, HMCS_xsize, HMCS_ysize}, -- G
		 [25]  = {72, HMCS_xsize, HMCS_ysize}, -- H
		 [26]  = {73, HMCS_xsize, HMCS_ysize}, -- I
		 [27]  = {74, HMCS_xsize, HMCS_ysize}, -- J
		 [28]  = {75, HMCS_xsize, HMCS_ysize}, -- K
		 [29]  = {76, HMCS_xsize, HMCS_ysize}, -- L
		 [30]  = {77, HMCS_xsize, HMCS_ysize}, -- M
		 [31]  = {78, HMCS_xsize, HMCS_ysize}, -- N
		 [32]  = {79, HMCS_xsize, HMCS_ysize}, -- O
		 [33]  = {80, HMCS_xsize, HMCS_ysize}, -- P
		 [34]  = {81, HMCS_xsize, HMCS_ysize}, -- Q
		 [35]  = {82, HMCS_xsize, HMCS_ysize}, -- R
		 [36]  = {83, HMCS_xsize, HMCS_ysize}, -- S
		 [37]  = {84, HMCS_xsize, HMCS_ysize}, -- T
		 [38]  = {85, HMCS_xsize, HMCS_ysize}, -- U
		 [39]  = {86, HMCS_xsize, HMCS_ysize}, -- V
		 [40]  = {87, HMCS_xsize, HMCS_ysize}, -- W
		 [41]  = {88, HMCS_xsize, HMCS_ysize}, -- X
		 [42]  = {89, HMCS_xsize, HMCS_ysize}, -- Y
		 [43]  = {90, HMCS_xsize, HMCS_ysize}, -- Z
		 [44]  = {91, HMCS_xsize, HMCS_ysize}, -- [
		 [45]  = {93, HMCS_xsize, HMCS_ysize}, -- ]
		 [46]  = {62, HMCS_xsize, HMCS_ysize}, -- >
		 [47]  = {111, HMCS_xsize, HMCS_ysize}, -- o
		 [48]  = {94, HMCS_xsize, HMCS_ysize}, -- ^
		 [49]  = {37, HMCS_xsize, HMCS_ysize}} -- %
}
