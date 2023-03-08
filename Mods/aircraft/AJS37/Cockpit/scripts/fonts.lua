dofile(LockOn_Options.common_script_path.."Fonts/symbols_locale.lua")
dofile(LockOn_Options.common_script_path.."Fonts/fonts_cmn.lua")

materials = {}
materials["BLACK"] = {0,0,0,255}
materials["INDICATION_COMMON_WHITE"]     = {255, 255, 255, 255}
materials["INDICATION_COMMON_GREY"]      = {245, 245, 245, 255}
materials["INDICATION_COMMON_DARK_GREY"] = {100, 100, 100, 255}
materials["INDICATION_COMMON_RED"]       = {255, 0, 0, 255}
materials["INDICATION_COMMON_GREEN"]     = {0, 255, 0, 255}
materials["INDICATION_COMMON_BLUE"]      = {0, 0, 255, 255}
materials["INDICATION_COMMON_BLACK"]     = {0, 0, 0, 255, 255}
materials["INDICATION_COMMON_AMBER"]     = {255,161,45,100}
materials["CMS_GREEN"]	 = {118, 249, 31, 255}
materials["MFD_BLUE"]   = {100, 100, 255, 255}
materials["MFD_GREEN"]  = {0, 255, 50, 255}
materials["MFD_RED"]    = {255, 0, 0, 255}
materials["MFD_WHITE"]  = {255, 255, 255, 255}
materials["MFD_YELLOW"] = {255, 255, 0, 255}
materials["MFD_VIOLET"] = {255, 0, 255, 255}
materials["DBG_GREY"]    = {25, 25, 25, 255}
materials["DBG_BLACK"]   = {0, 0, 0, 100}
materials["DBG_RED"]     = {255, 0, 0, 100}
materials["DBG_GREEN"]   = {0, 255, 0, 100}
materials["DIGIT_CLOCK"] = {120, 148, 148, 255}
materials["CDU_GREEN"]		 = {0, 255, 0, 255}
materials["TGP_STBY_GREY"] = {102, 102, 102, 255}
materials["TGP_STBY_DARK_GREY"] = {47, 47, 47, 255}
materials["HUD_IND_GREEN"]   = {0, 255, 0, 255}
materials["HUD_IND_YELLOW"]   = {243, 116, 13, 255}
materials["HUD_IND_DBG"]     = {255, 50, 0, 255}
materials["UHF_RADIO"] = {220, 220, 222, 255}
materials["UHF_RADIO_CHANNEL_MAP"] = {25, 25, 25, 255}
materials["UHF_REPEATER"]  = {227, 226, 221, 255}

materials["MFD_CICU_BLACK"]  = {1, 1, 1, 255}
materials["MFD_CICU_GREY"]    = {117, 117, 117, 255}
materials["MFD_CICU_WHITE"]  = {10, 167, 244, 255}

CP1251_toUTF8 =
{
	[128]=	1026,
	[129]=	1027,
	[130]=	8218,
	[131]=	1107,
	[132]=	8222,
	[133]=	8214,
	[134]=	8224,
	[135]=	8225,
	[136]=	8364,
	[137]=	8240,
	[138]=	1033,
	[139]=	8249,
	[140]=	1034,
	[141]=	1036,
	[142]=	1035,
	[143]=	1039,
	[144]=	1106,
	[145]=	8216,
	[146]=	8217,
	[147]=	8220,
	[148]=	8221,
	[149]=	8226,
	[150]=	8211,
	[151]=	8212,
	[152]=	8481,
	[153]=	8482,
	[154]=	1113,
	[155]=	8250,
	[156]=	1114,
	[157]=	1116,
	[158]=	1115,
	[159]=	1119,
	[160]=	160	,
	[161]=	1038,
	[162]=	1118,
	[163]=	1032,
	[164]=	164	,
	[165]=	1168,
	[166]=	166	,
	[167]=	167	,
	[168]=	1025,
	[169]=	169	,
	[170]=	1028,
	[171]=	171	,
	[172]=	172	,
	[173]=	173	,
	[174]=	174	,
	[175]=	1031,
	[176]=	176	,
	[177]=	177	,
	[178]=	1030,
	[179]=	1110,
	[180]=	1169,
	[181]=	181	,
	[182]=	182	,
	[183]=	183	,
	[184]=	1105,
	[185]=	8470,
	[186]=	1108,
	[187]=	187	,
	[188]=	1112,
	[189]=	1029,
	[190]=	1109,
	[191]=	1111,
	-- ugly hack  
	[219]=	1102,
	[241]=	1103
}

local IndicationTexturesPath = LockOn_Options.script_path.."../resources/IndicationTextures/"

fontdescription = {}

NAV_xsize = 44 * 2
NAV_ysize = 72.0 * 2 --73.143 * 2
fontdescription["font_NAV"] = {
	texture    = IndicationTexturesPath.."font_HUD_F15C.tga",
	size      = {7, 7},
	resolution = {729, 768},
	default    = {NAV_xsize, NAV_ysize},
	chars	    = {
		 [1]   = {32, NAV_xsize, NAV_ysize}, -- [space]
		 [2]   = {42, NAV_xsize, NAV_ysize}, -- *
		 [3]   = {43, NAV_xsize, NAV_ysize}, -- +
		 [4]   = {45, NAV_xsize, NAV_ysize}, -- -
		 [5]   = {46, NAV_xsize, NAV_ysize}, -- .
		 [6]   = {47, NAV_xsize, NAV_ysize}, -- /
		 [7]   = {48, NAV_xsize, NAV_ysize}, -- 0
		 [8]   = {49, NAV_xsize, NAV_ysize}, -- 1
		 [9]   = {50, NAV_xsize, NAV_ysize}, -- 2
		 [10]  = {51, NAV_xsize, NAV_ysize}, -- 3
		 [11]  = {52, NAV_xsize, NAV_ysize}, -- 4
		 [12]  = {53, NAV_xsize, NAV_ysize}, -- 5
		 [13]  = {54, NAV_xsize, NAV_ysize}, -- 6
		 [14]  = {55, NAV_xsize, NAV_ysize}, -- 7
		 [15]  = {56, NAV_xsize, NAV_ysize}, -- 8
		 [16]  = {57, NAV_xsize, NAV_ysize}, -- 9
		 [17]  = {58, NAV_xsize, NAV_ysize}, -- :
		 [18]  = {65, NAV_xsize, NAV_ysize}, -- A
		 [19]  = {66, NAV_xsize, NAV_ysize}, -- B
		 [20]  = {67, NAV_xsize, NAV_ysize}, -- C
		 [21]  = {68, NAV_xsize, NAV_ysize}, -- D
		 [22]  = {69, NAV_xsize, NAV_ysize}, -- E
		 [23]  = {70, NAV_xsize, NAV_ysize}, -- F
		 [24]  = {71, NAV_xsize, NAV_ysize}, -- G
		 [25]  = {72, NAV_xsize, NAV_ysize}, -- H
		 [26]  = {73, NAV_xsize, NAV_ysize}, -- I
		 [27]  = {74, NAV_xsize, NAV_ysize}, -- J
		 [28]  = {75, NAV_xsize, NAV_ysize}, -- K
		 [29]  = {76, NAV_xsize, NAV_ysize}, -- L
		 [30]  = {77, NAV_xsize, NAV_ysize}, -- M
		 [31]  = {78, NAV_xsize, NAV_ysize}, -- N
		 [32]  = {79, NAV_xsize, NAV_ysize}, -- O
		 [33]  = {80, NAV_xsize, NAV_ysize}, -- P
		 [34]  = {81, NAV_xsize, NAV_ysize}, -- Q
		 [35]  = {82, NAV_xsize, NAV_ysize}, -- R
		 [36]  = {83, NAV_xsize, NAV_ysize}, -- S
		 [37]  = {84, NAV_xsize, NAV_ysize}, -- T
		 [38]  = {85, NAV_xsize, NAV_ysize}, -- U
		 [39]  = {86, NAV_xsize, NAV_ysize}, -- V
		 [40]  = {87, NAV_xsize, NAV_ysize}, -- W
		 [41]  = {88, NAV_xsize, NAV_ysize}, -- X
		 [42]  = {89, NAV_xsize, NAV_ysize}, -- Y
		 [43]  = {90, NAV_xsize, NAV_ysize}, -- Z
		 [44]  = {91, NAV_xsize, NAV_ysize}, -- [
		 [45]  = {93, NAV_xsize, NAV_ysize}, -- ]
		 [46]  = {62, NAV_xsize, NAV_ysize}, -- >
		 [47]  = {111, NAV_xsize, NAV_ysize}, -- o
		 [48]  = {94, NAV_xsize, NAV_ysize}} -- ^
}

KNEEBOARD_FONT_X =  64
KNEEBOARD_FONT_SMALL_X =  60
KNEEBOARD_FONT_Y =  116
fontdescription["font_kneeboard"] = {
	texture = IndicationTexturesPath.."kneeboard_font.dds",
	size = { 8, 16 },
	resolution = { 1024, 1024 },
	default = { KNEEBOARD_FONT_X, KNEEBOARD_FONT_Y },
	chars = {
		[1] = { 32, KNEEBOARD_FONT_X, KNEEBOARD_FONT_Y }, -- [space]
		[2] = { 33, KNEEBOARD_FONT_SMALL_X, KNEEBOARD_FONT_Y }, -- !
		[3] = { 34, KNEEBOARD_FONT_SMALL_X, KNEEBOARD_FONT_Y }, -- "
		[4] = { 35, KNEEBOARD_FONT_SMALL_X, KNEEBOARD_FONT_Y }, -- #
		[5] = { 36, KNEEBOARD_FONT_SMALL_X, KNEEBOARD_FONT_Y }, -- $
		[6] = { 37, KNEEBOARD_FONT_X, KNEEBOARD_FONT_Y }, -- %
		[7] = { 38, KNEEBOARD_FONT_X, KNEEBOARD_FONT_Y }, -- &
		[8] = { 39, KNEEBOARD_FONT_SMALL_X, KNEEBOARD_FONT_Y }, -- '
		[9] = { 40, KNEEBOARD_FONT_SMALL_X, KNEEBOARD_FONT_Y }, -- (
		[10] = { 41, KNEEBOARD_FONT_SMALL_X, KNEEBOARD_FONT_Y }, -- )
		[11] = { 42, KNEEBOARD_FONT_SMALL_X, KNEEBOARD_FONT_Y }, -- *
		[12] = { 43, KNEEBOARD_FONT_SMALL_X, KNEEBOARD_FONT_Y }, -- +
		[13] = { 44, KNEEBOARD_FONT_SMALL_X, KNEEBOARD_FONT_Y }, -- ,
		[14] = { 45, KNEEBOARD_FONT_SMALL_X, KNEEBOARD_FONT_Y }, -- -
		[15] = { 46, KNEEBOARD_FONT_SMALL_X, KNEEBOARD_FONT_Y }, -- .
		[16] = { 47, KNEEBOARD_FONT_SMALL_X, KNEEBOARD_FONT_Y }, -- /
		[17] = { 48, KNEEBOARD_FONT_X, KNEEBOARD_FONT_Y }, -- 0
		[18] = { 49, KNEEBOARD_FONT_X, KNEEBOARD_FONT_Y }, -- 1
		[19] = { 50, KNEEBOARD_FONT_X, KNEEBOARD_FONT_Y }, -- 2
		[20] = { 51, KNEEBOARD_FONT_X, KNEEBOARD_FONT_Y }, -- 3
		[21] = { 52, KNEEBOARD_FONT_X, KNEEBOARD_FONT_Y }, -- 4
		[22] = { 53, KNEEBOARD_FONT_X, KNEEBOARD_FONT_Y }, -- 5
		[23] = { 54, KNEEBOARD_FONT_X, KNEEBOARD_FONT_Y }, -- 6
		[24] = { 55, KNEEBOARD_FONT_X, KNEEBOARD_FONT_Y }, -- 7
		[25] = { 56, KNEEBOARD_FONT_X, KNEEBOARD_FONT_Y }, -- 8
		[26] = { 57, KNEEBOARD_FONT_X, KNEEBOARD_FONT_Y }, -- 9
		[27] = { 58, KNEEBOARD_FONT_SMALL_X, KNEEBOARD_FONT_Y }, -- :
		[28] = { 59, KNEEBOARD_FONT_SMALL_X, KNEEBOARD_FONT_Y }, -- ;
		[29] = { 60, KNEEBOARD_FONT_SMALL_X, KNEEBOARD_FONT_Y }, -- <
		[30] = { 61, KNEEBOARD_FONT_SMALL_X, KNEEBOARD_FONT_Y }, -- =
		[31] = { 62, KNEEBOARD_FONT_SMALL_X, KNEEBOARD_FONT_Y }, -- >
		[32] = { 63, KNEEBOARD_FONT_SMALL_X, KNEEBOARD_FONT_Y }, -- ?
		[33] = { 64, KNEEBOARD_FONT_X, KNEEBOARD_FONT_Y }, -- @
		[34] = { 65, KNEEBOARD_FONT_X, KNEEBOARD_FONT_Y }, -- A
		[35] = { 66, KNEEBOARD_FONT_X, KNEEBOARD_FONT_Y }, -- B
		[36] = { 67, KNEEBOARD_FONT_X, KNEEBOARD_FONT_Y }, -- C
		[37] = { 68, KNEEBOARD_FONT_X, KNEEBOARD_FONT_Y }, -- D
		[38] = { 69, KNEEBOARD_FONT_X, KNEEBOARD_FONT_Y }, -- E
		[39] = { 70, KNEEBOARD_FONT_X, KNEEBOARD_FONT_Y }, -- F
		[40] = { 71, KNEEBOARD_FONT_X, KNEEBOARD_FONT_Y }, -- G
		[41] = { 72, KNEEBOARD_FONT_X, KNEEBOARD_FONT_Y }, -- H
		[42] = { 73, KNEEBOARD_FONT_X, KNEEBOARD_FONT_Y }, -- I
		[43] = { 74, KNEEBOARD_FONT_X, KNEEBOARD_FONT_Y }, -- J
		[44] = { 75, KNEEBOARD_FONT_X, KNEEBOARD_FONT_Y }, -- K
		[45] = { 76, KNEEBOARD_FONT_X, KNEEBOARD_FONT_Y }, -- L
		[46] = { 77, KNEEBOARD_FONT_X, KNEEBOARD_FONT_Y }, -- M
		[47] = { 78, KNEEBOARD_FONT_X, KNEEBOARD_FONT_Y }, -- N
		[48] = { 79, KNEEBOARD_FONT_X, KNEEBOARD_FONT_Y }, -- O
		[49] = { 80, KNEEBOARD_FONT_X, KNEEBOARD_FONT_Y }, -- P
		[50] = { 81, KNEEBOARD_FONT_X, KNEEBOARD_FONT_Y }, -- Q
		[51] = { 82, KNEEBOARD_FONT_X, KNEEBOARD_FONT_Y }, -- R
		[52] = { 83, KNEEBOARD_FONT_X, KNEEBOARD_FONT_Y }, -- S
		[53] = { 84, KNEEBOARD_FONT_X, KNEEBOARD_FONT_Y }, -- T
		[54] = { 85, KNEEBOARD_FONT_X, KNEEBOARD_FONT_Y }, -- U
		[55] = { 86, KNEEBOARD_FONT_X, KNEEBOARD_FONT_Y }, -- V
		[56] = { 87, KNEEBOARD_FONT_X, KNEEBOARD_FONT_Y }, -- W
		[57] = { 88, KNEEBOARD_FONT_X, KNEEBOARD_FONT_Y }, -- X
		[58] = { 89, KNEEBOARD_FONT_X, KNEEBOARD_FONT_Y }, -- Y
		[59] = { 90, KNEEBOARD_FONT_X, KNEEBOARD_FONT_Y }, -- Z
		[60] = { 91, KNEEBOARD_FONT_SMALL_X, KNEEBOARD_FONT_Y }, -- [
		[61] = { 92, KNEEBOARD_FONT_SMALL_X, KNEEBOARD_FONT_Y }, -- \
		[62] = { 93, KNEEBOARD_FONT_SMALL_X, KNEEBOARD_FONT_Y }, -- ]
		[63] = { 94, KNEEBOARD_FONT_SMALL_X, KNEEBOARD_FONT_Y }, -- ^
		[64] = { 95, KNEEBOARD_FONT_SMALL_X, KNEEBOARD_FONT_Y }, -- _
		[65] = { 96, KNEEBOARD_FONT_SMALL_X, KNEEBOARD_FONT_Y }, -- `
		[66] = { 97, KNEEBOARD_FONT_SMALL_X, KNEEBOARD_FONT_Y }, -- a
		[67] = { 98, KNEEBOARD_FONT_SMALL_X, KNEEBOARD_FONT_Y }, -- b
		[68] = { 99, KNEEBOARD_FONT_SMALL_X, KNEEBOARD_FONT_Y }, -- c
		[69] = { 100, KNEEBOARD_FONT_SMALL_X, KNEEBOARD_FONT_Y }, -- d
		[70] = { 101, KNEEBOARD_FONT_SMALL_X, KNEEBOARD_FONT_Y }, -- e
		[71] = { 102, KNEEBOARD_FONT_SMALL_X, KNEEBOARD_FONT_Y }, -- f
		[72] = { 103, KNEEBOARD_FONT_SMALL_X, KNEEBOARD_FONT_Y }, -- g
		[73] = { 104, KNEEBOARD_FONT_SMALL_X, KNEEBOARD_FONT_Y }, -- h
		[74] = { 105, KNEEBOARD_FONT_SMALL_X, KNEEBOARD_FONT_Y }, -- i
		[75] = { 106, KNEEBOARD_FONT_SMALL_X, KNEEBOARD_FONT_Y }, -- j
		[76] = { 107, KNEEBOARD_FONT_SMALL_X, KNEEBOARD_FONT_Y }, -- k
		[77] = { 108, KNEEBOARD_FONT_SMALL_X, KNEEBOARD_FONT_Y }, -- l
		[78] = { 109, KNEEBOARD_FONT_SMALL_X, KNEEBOARD_FONT_Y }, -- m
		[79] = { 110, KNEEBOARD_FONT_SMALL_X, KNEEBOARD_FONT_Y }, -- n
		[80] = { 111, KNEEBOARD_FONT_SMALL_X, KNEEBOARD_FONT_Y }, -- o
		[81] = { 112, KNEEBOARD_FONT_SMALL_X, KNEEBOARD_FONT_Y }, -- p
		[82] = { 113, KNEEBOARD_FONT_SMALL_X, KNEEBOARD_FONT_Y }, -- q
		[83] = { 114, KNEEBOARD_FONT_SMALL_X, KNEEBOARD_FONT_Y }, -- r
		[84] = { 115, KNEEBOARD_FONT_SMALL_X, KNEEBOARD_FONT_Y }, -- s
		[85] = { 116, KNEEBOARD_FONT_SMALL_X, KNEEBOARD_FONT_Y }, -- t
		[86] = { 117, KNEEBOARD_FONT_SMALL_X, KNEEBOARD_FONT_Y }, -- u
		[87] = { 118, KNEEBOARD_FONT_SMALL_X, KNEEBOARD_FONT_Y }, -- v
		[88] = { 119, KNEEBOARD_FONT_SMALL_X, KNEEBOARD_FONT_Y }, -- w
		[89] = { 120, KNEEBOARD_FONT_SMALL_X, KNEEBOARD_FONT_Y }, -- x
		[90] = { 121, KNEEBOARD_FONT_SMALL_X, KNEEBOARD_FONT_Y }, -- y
		[91] = { 122, KNEEBOARD_FONT_SMALL_X, KNEEBOARD_FONT_Y }, -- z
		[92] = { 123, KNEEBOARD_FONT_SMALL_X, KNEEBOARD_FONT_Y }, -- {
		[93] = { 124, KNEEBOARD_FONT_SMALL_X, KNEEBOARD_FONT_Y }, -- |
		[94] = { 125, KNEEBOARD_FONT_SMALL_X, KNEEBOARD_FONT_Y }, -- }
		[95] = { 126, KNEEBOARD_FONT_SMALL_X, KNEEBOARD_FONT_Y }, -- ~
		[96] = { 176, KNEEBOARD_FONT_SMALL_X, KNEEBOARD_FONT_Y }, -- °, 176
		[97] = { 31, KNEEBOARD_FONT_X, KNEEBOARD_FONT_Y }, -- °, 0-127 range backup
		[98] = { 129, KNEEBOARD_FONT_X, KNEEBOARD_FONT_Y }, -- reserved
		[99] = { 130, KNEEBOARD_FONT_X, KNEEBOARD_FONT_Y }, -- reserved
		[100] = { 131, KNEEBOARD_FONT_X, KNEEBOARD_FONT_Y }, -- reserved
		[101] = { 132, KNEEBOARD_FONT_X, KNEEBOARD_FONT_Y }, -- reserved
		[102] = { 133, KNEEBOARD_FONT_X, KNEEBOARD_FONT_Y }, -- reserved
		[103] = { 134, KNEEBOARD_FONT_X, KNEEBOARD_FONT_Y }, -- reserved
		[104] = { 135, KNEEBOARD_FONT_X, KNEEBOARD_FONT_Y }, -- reserved
		[105] = { 136, KNEEBOARD_FONT_X, KNEEBOARD_FONT_Y }, -- reserved
		[106] = { 137, KNEEBOARD_FONT_X, KNEEBOARD_FONT_Y }, -- reserved
		[107] = { 138, KNEEBOARD_FONT_X, KNEEBOARD_FONT_Y }, -- reserved
		[108] = { 139, KNEEBOARD_FONT_X, KNEEBOARD_FONT_Y }, -- reserved
		[109] = { 140, KNEEBOARD_FONT_X, KNEEBOARD_FONT_Y }, -- reserved
		[110] = { 141, KNEEBOARD_FONT_X, KNEEBOARD_FONT_Y }, -- reserved
		[111] = { 142, KNEEBOARD_FONT_X, KNEEBOARD_FONT_Y }, -- reserved
		[112] = { 143, KNEEBOARD_FONT_X, KNEEBOARD_FONT_Y }, -- reserved
		[113] = { 144, KNEEBOARD_FONT_X, KNEEBOARD_FONT_Y }, -- reserved
		[114] = { 145, KNEEBOARD_FONT_X, KNEEBOARD_FONT_Y }, -- reserved
		[115] = { 146, KNEEBOARD_FONT_X, KNEEBOARD_FONT_Y }, -- reserved
		[116] = { 147, KNEEBOARD_FONT_X, KNEEBOARD_FONT_Y }, -- reserved
		[117] = { 148, KNEEBOARD_FONT_X, KNEEBOARD_FONT_Y }, -- reserved
		[118] = { 149, KNEEBOARD_FONT_X, KNEEBOARD_FONT_Y }, -- reserved
		[119] = { 150, KNEEBOARD_FONT_X, KNEEBOARD_FONT_Y }, -- reserved
		[120] = { 151, KNEEBOARD_FONT_X, KNEEBOARD_FONT_Y }, -- reserved
		[121] = { 152, KNEEBOARD_FONT_X, KNEEBOARD_FONT_Y }, -- reserved
		[122] = { 153, KNEEBOARD_FONT_X, KNEEBOARD_FONT_Y }, -- reserved
		[123] = { 154, KNEEBOARD_FONT_X, KNEEBOARD_FONT_Y }, -- reserved
		[124] = { 155, KNEEBOARD_FONT_X, KNEEBOARD_FONT_Y }, -- reserved
		[125] = { 156, KNEEBOARD_FONT_X, KNEEBOARD_FONT_Y }, -- reserved
		[126] = { 157, KNEEBOARD_FONT_X, KNEEBOARD_FONT_Y }, -- reserved
		[127] = { 158, KNEEBOARD_FONT_X, KNEEBOARD_FONT_Y }, -- reserved
		[128] = { 159, KNEEBOARD_FONT_X, KNEEBOARD_FONT_Y }, -- reserved
	}
}

fontdescription["font_general_loc"] = fontdescription_cmn["font_general_loc"]
fonts = {}
fonts["font_kneeboard"] 			= {fontdescription["font_kneeboard"], 10, materials["BLACK"]}
fonts["font_CMS"]					= {fontdescription["font_CMS"], 10, materials["CMS_GREEN"]}
fonts["font_CMSP"]					= fonts["font_CMS"]
fonts["font_MFD"]					= {fontdescription["font_MFD"], 10, materials["MFD_GREEN"]}
fonts["font_MFD_BLACK"]				= {fontdescription["font_MFD"], 10, materials["INDICATION_COMMON_BLACK"]}
fonts["font_MFD_BLUE"]				= {fontdescription["font_MFD"], 10, materials["MFD_BLUE"]}
fonts["font_MFD_RED"]				= {fontdescription["font_MFD"], 10, materials["MFD_RED"]}
fonts["font_MFD_GREY"]				= {fontdescription["font_MFD"], 10, materials["INDICATION_COMMON_GREY"]}
fonts["font_MFD_WHITE"]				= {fontdescription["font_MFD"], 10, materials["MFD_WHITE"]}
fonts["font_MFD_YELLOW"]			= {fontdescription["font_MFD"], 10, materials["MFD_YELLOW"]}
fonts["font_NAV"]					= {fontdescription["font_NAV"], 10, materials["INDICATION_COMMON_WHITE"]}
fonts["font_HUD_STANDBY"]			= {fontdescription["font_HUD_STANDBY"], 10, materials["HUD_IND_YELLOW"]}
fonts["font_HUD_DBG"]				= {fontdescription["font_HUD"], 10, materials["HUD_IND_DBG"]}


--DBG
--fonts["font_MFD_LEFT"]			 = {fontdescription["font_MFD"], 10, materials["MFD_RED"]}

-- force preload resources to avoid freeze on start

preload_texture = 
{
	-- IndicationTexturesPath.."nav_font.tga",
	-- IndicationTexturesPath.."font_MFD_F15C.tga",
	-- IndicationTexturesPath.."Indication_MFD.tga",
	 IndicationTexturesPath.."font_HUD_F15C.tga",
	-- IndicationTexturesPath.."Indication_hud_F15C.tga",
--[[	IndicationTexturesPath.."font_CMS.tga",
	IndicationTexturesPath.."font_DigitClock.tga",
	IndicationTexturesPath.."indication_DIGIT_CLK.tga",
	IndicationTexturesPath.."font_TGP_LITENING_AT.tga",
	IndicationTexturesPath.."font_RWR.tga",
	IndicationTexturesPath.."indication_RWR.tga",
	IndicationTexturesPath.."font_UHF_Radio.tga",
	IndicationTexturesPath.."font_UHF_Repeater.tga",
	"triggers.tga"]]
}
