dofile(LockOn_Options.common_script_path.."Fonts/symbols_locale.lua")
dofile(LockOn_Options.common_script_path.."Fonts/fonts_cmn.lua")
dofile(LockOn_Options.common_script_path.."tools.lua")

-- Stroke fonts and symbology
dofile(LockOn_Options.script_path.."Displays/Display_StrokeDefs.lua")

dbg_drawStrokesAsWire = false

-------MATERIALS-------

materials = {}   
materials["INDICATION_COMMON_RED"]		= {255, 0, 0, 255}
materials["INDICATION_COMMON_WHITE"]	= {255, 255, 255, 255}
materials["MASK_MATERIAL"]				= {255, 0, 255, 50}

materials["HUD_IND_YELLOW"]				= {243, 116, 13, 255}
materials["INDICATION_COMMON_RED"]		= {255, 0, 0, 255}

materials["LBLUE"]						= {173, 216, 230, 255}
materials["ORANGE_RED"]					= {255, 69, 0, 255}
materials["DODGER_BLUE"]				= {30, 144, 255, 255}

materials["DBG_LGREY"]					= {100, 100, 100, 255}
materials["DBG_GREY"]					= {25, 25, 25, 255}
materials["DBG_BLACK"]					= {0, 0, 0, 100}
materials["DBG_RED"]					= {255, 0, 0, 100}
materials["DBG_GREEN"]					= {0, 255, 0, 100}
materials["BLACK"]						= {0, 0, 0, 255}
materials["SIMPLE_WHITE"]				= {255, 255, 255, 255}
materials["PURPLE"]						= {255, 0, 255, 255}
materials["VIOLET"]						= {238, 130, 238, 255}

materials["GENERAL_INFO_GOLD"]			= {255, 197, 3, 255}
materials["YELLOW"]						= {255, 255, 0, 255}
materials["BLUE"]						= {0, 0, 255, 255}
materials["RED"]						= {255, 0, 0, 255}

-- HUD
materials["HUD_GREEN_BRIGHT"]			= {2, 255, 20, 385}		-- {0, 255, 0, 255}		-- hud_indicator_color = {0,204,102,255}
materials["HUD_RL_GREEN_BRIGHT"]		= {122, 240, 41, 255}	-- hud_indicator_color = {0,204,102,255}
materials["HUD_RR_GREEN_BRIGHT"]		= {122, 240, 41, 255}	-- hud_indicator_color = {0,204,102,255}
materials["HUD_GREEN_DIMM"]				= {0, 204, 102, 128}
materials["HUD_HLPR_YELLOW"]			= {255, 255, 0, 225}	-- hud_helper_color    = {255,255,0,225}
materials["HUD_IND_GREEN"]				= {20, 255, 20, 255}	-- hud_ind_color       = {20,255,20,225}
materials["HUD_VIDEO_GREEN"]			= {2, 255, 20, 65}		-- {0, 255, 0, 255}		-- hud_indicator_color = {0,204,102,255}

-- MPCDs
materials["MPCD_GREEN_DAY"]				= {122, 240, 41, 255}
materials["MPCD_GREEN_NIGHT"]			= {112, 200, 60, 255}
materials["MPCD_WHITE_DAY"]				= {255, 255, 255, 255}
materials["MPCD_GREEN_BRIGHT"]			= {0, 255, 0, 255}
materials["MPCD_BLACK"]					= {0, 0, 0, 255}

-- UFC/ODU
materials["UFC_GREEN"]					= {0, 255, 100, 255}

-------TEXTURES-------
textures = {}

textures["ARCADE"]				= {"arcade.tga",	materials["INDICATION_COMMON_RED"]}
textures["ARCADE_PUPRLE"]		= {"arcade.tga",	materials["PURPLE"]}
textures["ARCADE_WHITE"]		= {"arcade.tga",	materials["SIMPLE_WHITE"]}

-- HUD
textures["hud_pitch_ladder"]			= {LockOn_Options.script_path.."Resources/HUD/HUD_Symbols_1.dds", 		materials["HUD_GREEN_BRIGHT"]}
textures["hud_ind_material"]			= {LockOn_Options.script_path.."Resources/HUD/HUD_Symbols_2.dds", 		materials["HUD_GREEN_BRIGHT"]}
textures["hud_hdg_material"]			= {LockOn_Options.script_path.."Resources/HUD/HUD_Heading_Tape.tga",	materials["HUD_GREEN_BRIGHT"]}
textures["hud_align_material"]			= {LockOn_Options.script_path.."Resources/HUD/HUD_Align.tga",			materials["HUD_HLPR_YELLOW"]}
textures["hud_lines_material"]			= {nil, materials["HUD_GREEN_BRIGHT"]}
textures["hud_dashed_lines_material"]	= {LockOn_Options.script_path.."Resources/HUD/Dashed_Line.dds", 		materials["HUD_GREEN_BRIGHT"]}
textures["hud_video_output"]			= {"mfd2", materials["HUD_VIDEO_GREEN"]}

-- HUD Repater Left
textures["hrl_pitch_ladder"]			= {LockOn_Options.script_path.."Resources/HUD/HUD_Symbols_1.dds", 		materials["MPCD_GREEN_DAY"]}
textures["hrl_ind_material"]			= {LockOn_Options.script_path.."Resources/HUD/HUD_Symbols_2.dds", 		materials["MPCD_GREEN_DAY"]}
textures["hrl_hdg_material"]			= {LockOn_Options.script_path.."Resources/HUD/HUD_Heading_Tape.tga",	materials["MPCD_GREEN_DAY"]}
textures["hrl_align_material"]			= {LockOn_Options.script_path.."Resources/HUD/HUD_Align.tga",			materials["HUD_HLPR_YELLOW"]}
textures["hrl_lines_material"]			= {nil, materials["MPCD_GREEN_DAY"]}
textures["hrl_dashed_lines_material"]	= {LockOn_Options.script_path.."Resources/HUD/Dashed_Line.dds", 		materials["MPCD_GREEN_DAY"]}

-- HUD Repeater Right
textures["hrr_pitch_ladder"]			= {LockOn_Options.script_path.."Resources/HUD/HUD_Symbols_1.dds", 		materials["MPCD_GREEN_DAY"]}
textures["hrr_ind_material"]			= {LockOn_Options.script_path.."Resources/HUD/HUD_Symbols_2.dds", 		materials["MPCD_GREEN_DAY"]}
textures["hrr_hdg_material"]			= {LockOn_Options.script_path.."Resources/HUD/HUD_Heading_Tape.tga",	materials["MPCD_GREEN_DAY"]}
textures["hrr_align_material"]			= {LockOn_Options.script_path.."Resources/HUD/HUD_Align.tga",			materials["HUD_HLPR_YELLOW"]}
textures["hrr_lines_material"]			= {nil, materials["MPCD_GREEN_DAY"]}
textures["hrr_dashed_lines_material"]	= {LockOn_Options.script_path.."Resources/HUD/Dashed_Line.dds", 		materials["MPCD_GREEN_DAY"]}

-- MPCDs
textures["mpcd_align_mtl_y"]	= {LockOn_Options.script_path.."Resources/MPCD/MPCD_Align.tga", 		materials["YELLOW"]}
textures["mpcd_align_mtl_w"]	= {LockOn_Options.script_path.."Resources/MPCD/MPCD_Align.tga", 		materials["SIMPLE_WHITE"]}
textures["mpcd_symbols_1_w"]	= {LockOn_Options.script_path.."Resources/MPCD/MPCD_Symbols_01.dds", 	materials["SIMPLE_WHITE"]}		-- EHSD WHITE (AGM-65)
textures["mpcd_symbols_1_b"]	= {LockOn_Options.script_path.."Resources/MPCD/MPCD_Symbols_01.dds", 	materials["BLACK"]}				-- EHSD BLACK (AGM-65)
textures["mpcd_symbols_2_w"]	= {LockOn_Options.script_path.."Resources/MPCD/MPCD_Symbols_02.tga", 	materials["SIMPLE_WHITE"]}		-- STRS WHITE

textures["mpcd_ehsd_lines_fg"]			= {nil, materials["MPCD_GREEN_DAY"]}
textures["mpcd_ehsd_lines_bg"]			= {nil, materials["BLACK"]}
textures["mpcd_ehsd_route_lines_fg"]	= {nil, materials["PURPLE"]}
textures["mpcd_ehsd_route_lines_vl"]	= {nil, materials["VIOLET"]}
textures["mpcd_ehsd_route_lines_gr"]	= {nil, materials["MPCD_GREEN_DAY"]}
textures["mpcd_ehsd_route_lines_bl"]	= {nil, materials["DODGER_BLUE"]}
textures["mpcd_ehsd_route_lines_or"]	= {nil, materials["ORANGE_RED"]}
textures["mpcd_ehsd_route_lines_rd"]	= {nil, materials["RED"]}
textures["mpcd_ehsd_dashed_lines_bg"]	= {LockOn_Options.script_path.."Resources/MPCD/Dashed_Line.dds", 		materials["BLACK"]}
textures["mpcd_ehsd_dashed_lines_fg"]	= {LockOn_Options.script_path.."Resources/MPCD/Dashed_Line.dds", 		materials["PURPLE"]}

-- LEFT MPCD
textures["mpcdl_strk_symb_fg"]	= {nil, materials["MPCD_GREEN_DAY"]}
textures["mpcdl_strk_symb_bg"]	= {nil, materials["BLACK"]}
textures["mpcdl_symbols_1_g"]	= {LockOn_Options.script_path.."Resources/MPCD/MPCD_Symbols_01.dds", 	 materials["MPCD_GREEN_DAY"]}	-- EHSD GREEN
textures["mpcdl_symbols_2_g"]	= {LockOn_Options.script_path.."Resources/MPCD/MPCD_Symbols_02.tga", 	 materials["MPCD_GREEN_DAY"]}	-- STRS GREEN
textures["mpcdl_symbols_3"]		= {LockOn_Options.script_path.."Resources/MPCD/MPCD_Symbols_03.tga", 	 materials["MPCD_GREEN_DAY"]}	-- RWR + SIGHT LINES
textures["mpcdl_symbols_4"]		= {LockOn_Options.script_path.."Resources/MPCD/MPCD_Symbols_04.tga", 	 materials["MPCD_GREEN_DAY"]}	-- DMT LOCK SIGHT
textures["mpcdl_symbols_5"]		= {LockOn_Options.script_path.."Resources/MPCD/MPCD_Symbols_05.tga", 	 materials["MPCD_GREEN_DAY"]}	-- AGM65 SIGHT GREEN
textures["mpcdl_symbols_6"]		= {LockOn_Options.script_path.."Resources/MPCD/HUD_Symbols.tga", 		 materials["MPCD_GREEN_DAY"]}	-- HUD ELEMENTS GREEN
textures["tpod_symbols_L"]		= {LockOn_Options.script_path.."Resources/MPCD/TPOD_Symbols_01.tga",	 materials["MPCD_GREEN_DAY"]}	-- TPOD ELEMENTS GREEN
textures["mpcdl_ehsd_dashed_lines_bg"]	= {LockOn_Options.script_path.."Resources/MPCD/Dashed_Line.dds", materials["BLACK"]}
textures["mpcdl_ehsd_dashed_lines_fg"]	= {LockOn_Options.script_path.."Resources/MPCD/Dashed_Line.dds", materials["PURPLE"]}

-- RIGHT MPCD
textures["mpcdr_strk_symb_fg"]	= {nil, materials["MPCD_GREEN_DAY"]}
textures["mpcdr_strk_symb_bg"]	= {nil, materials["BLACK"]}
textures["mpcdr_symbols_1_g"]	= {LockOn_Options.script_path.."Resources/MPCD/MPCD_Symbols_01.dds", 	 materials["MPCD_GREEN_DAY"]}	-- EHSD GREEN
textures["mpcdr_symbols_2_g"]	= {LockOn_Options.script_path.."Resources/MPCD/MPCD_Symbols_02.tga", 	 materials["MPCD_GREEN_DAY"]}	-- STRS GREEN
textures["mpcdr_symbols_3"]		= {LockOn_Options.script_path.."Resources/MPCD/MPCD_Symbols_03.tga", 	 materials["MPCD_GREEN_DAY"]}	-- RWR + SIGHT LINES
textures["mpcdr_symbols_4"]		= {LockOn_Options.script_path.."Resources/MPCD/MPCD_Symbols_04.tga", 	 materials["MPCD_GREEN_DAY"]}	-- DMT LOCK SIGHT
textures["mpcdr_symbols_5"]		= {LockOn_Options.script_path.."Resources/MPCD/MPCD_Symbols_05.tga", 	 materials["MPCD_GREEN_DAY"]}	-- AGM65 SIGHT GREEN
textures["mpcdr_symbols_6"]		= {LockOn_Options.script_path.."Resources/MPCD/HUD_Symbols.tga", 		 materials["MPCD_GREEN_DAY"]}	-- HUD ELEMENTS GREEN
textures["tpod_symbols_R"]		= {LockOn_Options.script_path.."Resources/MPCD/TPOD_Symbols_01.tga", 	 materials["MPCD_GREEN_DAY"]}	-- TPOD ELEMENTS GREEN
textures["mpcdr_ehsd_dashed_lines_bg"]	= {LockOn_Options.script_path.."Resources/MPCD/Dashed_Line.dds", materials["BLACK"]}
textures["mpcdr_ehsd_dashed_lines_fg"]	= {LockOn_Options.script_path.."Resources/MPCD/Dashed_Line.dds", materials["PURPLE"]}

-------FONTS----------
fontdescription = {}
fontdescription["font_general_loc"]	= fontdescription_cmn["font_general_loc"]

HUD_x_size = 44.0 * 2 -- pi
HUD_y_size = 72.0 * 2
fontdescription["font_HUD"] = {
	texture     = LockOn_Options.script_path.."Resources/Fonts/font_HUD_AV8B.dds",
	size        = {7, 7},
	resolution  = {1024, 1024},
	default     = {HUD_x_size, HUD_y_size},
	chars	    = {
		 [1]   = {32, HUD_x_size, HUD_y_size}, -- [space]
		 [2]   = {42, HUD_x_size, HUD_y_size}, -- *
		 [3]   = {43, HUD_x_size, HUD_y_size}, -- +
		 [4]   = {45, HUD_x_size, HUD_y_size}, -- -
		 [5]   = {46, HUD_x_size, HUD_y_size}, -- .
		 [6]   = {47, HUD_x_size, HUD_y_size}, -- /
		 [7]   = {48, HUD_x_size, HUD_y_size}, -- 0
		 [8]   = {49, HUD_x_size, HUD_y_size}, -- 1
		 [9]   = {50, HUD_x_size, HUD_y_size}, -- 2
		 [10]  = {51, HUD_x_size, HUD_y_size}, -- 3
		 [11]  = {52, HUD_x_size, HUD_y_size}, -- 4
		 [12]  = {53, HUD_x_size, HUD_y_size}, -- 5
		 [13]  = {54, HUD_x_size, HUD_y_size}, -- 6
		 [14]  = {55, HUD_x_size, HUD_y_size}, -- 7
		 [15]  = {56, HUD_x_size, HUD_y_size}, -- 8
		 [16]  = {57, HUD_x_size, HUD_y_size}, -- 9
		 [17]  = {58, HUD_x_size, HUD_y_size}, -- :
		 [18]  = {65, HUD_x_size, HUD_y_size}, -- A
		 [19]  = {66, HUD_x_size, HUD_y_size}, -- B
		 [20]  = {67, HUD_x_size, HUD_y_size}, -- C
		 [21]  = {68, HUD_x_size, HUD_y_size}, -- D
		 [22]  = {69, HUD_x_size, HUD_y_size}, -- E
		 [23]  = {70, HUD_x_size, HUD_y_size}, -- F
		 [24]  = {71, HUD_x_size, HUD_y_size}, -- G
		 [25]  = {72, HUD_x_size, HUD_y_size}, -- H
		 [26]  = {73, HUD_x_size, HUD_y_size}, -- I
		 [27]  = {74, HUD_x_size, HUD_y_size}, -- J
		 [28]  = {75, HUD_x_size, HUD_y_size}, -- K
		 [29]  = {76, HUD_x_size, HUD_y_size}, -- L
		 [30]  = {77, HUD_x_size, HUD_y_size}, -- M
		 [31]  = {78, HUD_x_size, HUD_y_size}, -- N
		 [32]  = {79, HUD_x_size, HUD_y_size}, -- O
		 [33]  = {80, HUD_x_size, HUD_y_size}, -- P
		 [34]  = {81, HUD_x_size, HUD_y_size}, -- Q
		 [35]  = {82, HUD_x_size, HUD_y_size}, -- R
		 [36]  = {83, HUD_x_size, HUD_y_size}, -- S
		 [37]  = {84, HUD_x_size, HUD_y_size}, -- T
		 [38]  = {85, HUD_x_size, HUD_y_size}, -- U
		 [39]  = {86, HUD_x_size, HUD_y_size}, -- V
		 [40]  = {87, HUD_x_size, HUD_y_size}, -- W
		 [41]  = {88, HUD_x_size, HUD_y_size}, -- X
		 [42]  = {89, HUD_x_size, HUD_y_size}, -- Y
		 [43]  = {90, HUD_x_size, HUD_y_size}, -- Z
		 [44]  = {91, HUD_x_size, HUD_y_size}, -- [
		 [45]  = {93, HUD_x_size, HUD_y_size}, -- ]
		 [46]  = {62, HUD_x_size, HUD_y_size}, -- >
		 [47]  = {111, HUD_x_size, HUD_y_size}, -- o
		 [48]  = {94 , HUD_x_size, HUD_y_size}, -- ^
		 [49]  = {37 , HUD_x_size, HUD_y_size}, -- %
	}
}

MPCD_size_mult = 2
MPCD_xsize = 29 * MPCD_size_mult
MPCD_ysize = 64 * MPCD_size_mult

fontdescription["font_MPCD"] = {
	texture		= LockOn_Options.script_path.."Resources/Fonts/font_MPCD_AV8B.dds",
	size		= {8, 8},
	resolution	= {1024, 1024},
	default		= {MPCD_xsize, MPCD_ysize},
	chars		= {
		[1]   = {64,  MPCD_xsize, MPCD_ysize}, -- @ == ©
		[2]   = {18,  MPCD_xsize, MPCD_ysize}, -- ^ == \18
		[3]   = {20,  MPCD_xsize, MPCD_ysize}, -- ¶ == [] == \20
		[4]   = {26,  MPCD_xsize, MPCD_ysize}, -- > == -> == \26
		[5]   = {27,  MPCD_xsize, MPCD_ysize}, -- < == <- == \27
		[6]   = {31,  MPCD_xsize, MPCD_ysize}, -- SPARE 
		[7]   = {126, MPCD_xsize, MPCD_ysize}, -- ~
		[8]   = {32,  MPCD_xsize, MPCD_ysize}, -- [space]
		[9]   = {33,  MPCD_xsize, MPCD_ysize}, -- !
		[10]  = {35,  MPCD_xsize, MPCD_ysize}, -- #
		[11]  = {40,  MPCD_xsize, MPCD_ysize}, -- (
		[12]  = {41,  MPCD_xsize, MPCD_ysize}, -- )
		[13]  = {42,  MPCD_xsize, MPCD_ysize}, -- *
		[14]  = {43,  MPCD_xsize, MPCD_ysize}, -- +
		[15]  = {45,  MPCD_xsize, MPCD_ysize}, -- -
		[16]  = {46,  MPCD_xsize, MPCD_ysize}, -- .
		[17]  = {47,  MPCD_xsize, MPCD_ysize}, -- /
		[18]  = {48,  MPCD_xsize, MPCD_ysize}, -- 0
		[19]  = {49,  MPCD_xsize, MPCD_ysize}, -- 1
		[20]  = {50,  MPCD_xsize, MPCD_ysize}, -- 2
		[21]  = {51,  MPCD_xsize, MPCD_ysize}, -- 3
		[22]  = {52,  MPCD_xsize, MPCD_ysize}, -- 4
		[23]  = {53,  MPCD_xsize, MPCD_ysize}, -- 5
		[24]  = {54,  MPCD_xsize, MPCD_ysize}, -- 6
		[25]  = {55,  MPCD_xsize, MPCD_ysize}, -- 7
		[26]  = {56,  MPCD_xsize, MPCD_ysize}, -- 8
		[27]  = {57,  MPCD_xsize, MPCD_ysize}, -- 9
		[28]  = {58,  MPCD_xsize, MPCD_ysize}, -- :
		[29]  = {61,  MPCD_xsize, MPCD_ysize}, -- =
		[30]  = {63,  MPCD_xsize, MPCD_ysize}, -- ?
		[31]  = {65,  MPCD_xsize, MPCD_ysize}, -- A
		[32]  = {66,  MPCD_xsize, MPCD_ysize}, -- B
		[33]  = {67,  MPCD_xsize, MPCD_ysize}, -- C
		[34]  = {68,  MPCD_xsize, MPCD_ysize}, -- D
		[35]  = {69,  MPCD_xsize, MPCD_ysize}, -- E
		[36]  = {70,  MPCD_xsize, MPCD_ysize}, -- F
		[37]  = {71,  MPCD_xsize, MPCD_ysize}, -- G
		[38]  = {72,  MPCD_xsize, MPCD_ysize}, -- H
		[39]  = {73,  MPCD_xsize, MPCD_ysize}, -- I
		[40]  = {74,  MPCD_xsize, MPCD_ysize}, -- J
		[41]  = {75,  MPCD_xsize, MPCD_ysize}, -- K
		[42]  = {76,  MPCD_xsize, MPCD_ysize}, -- L
		[43]  = {77,  MPCD_xsize, MPCD_ysize}, -- M
		[44]  = {78,  MPCD_xsize, MPCD_ysize}, -- N
		[45]  = {79,  MPCD_xsize, MPCD_ysize}, -- O
		[46]  = {80,  MPCD_xsize, MPCD_ysize}, -- P
		[47]  = {81,  MPCD_xsize, MPCD_ysize}, -- Q
		[48]  = {82,  MPCD_xsize, MPCD_ysize}, -- R
		[49]  = {83,  MPCD_xsize, MPCD_ysize}, -- S
		[50]  = {84,  MPCD_xsize, MPCD_ysize}, -- T
		[51]  = {85,  MPCD_xsize, MPCD_ysize}, -- U
		[52]  = {86,  MPCD_xsize, MPCD_ysize}, -- V
		[53]  = {87,  MPCD_xsize, MPCD_ysize}, -- W
		[54]  = {88,  MPCD_xsize, MPCD_ysize}, -- X
		[55]  = {89,  MPCD_xsize, MPCD_ysize}, -- Y
		[56]  = {90,  MPCD_xsize, MPCD_ysize}, -- Z
		[57]  = {91,  MPCD_xsize, MPCD_ysize}, -- [
		[58]  = {93,  MPCD_xsize, MPCD_ysize}, -- ] 
		[59]  = {124, MPCD_xsize, MPCD_ysize}, -- | == ¦
		[60]  = {38,  MPCD_xsize, MPCD_ysize}, -- & == +- 
		[61]  = {59,  MPCD_xsize, MPCD_ysize}, -- ; == ° 
		[62]  = {95,  MPCD_xsize, MPCD_ysize}, -- _
		[63]  = {37,  MPCD_xsize, MPCD_ysize},-- %
	}
}

fontdescription["font_TPOD"] = {
	texture		= LockOn_Options.script_path.."Resources/Fonts/font_MPCD_AV8B_BOLD.dds",
	size		= {8, 8},
	resolution	= {1024, 1024},
	default		= {MPCD_xsize + 6, MPCD_ysize + 6},
	chars		= {
		[1]   = {64,  MPCD_xsize, MPCD_ysize}, -- @ == ©
		[2]   = {18,  MPCD_xsize, MPCD_ysize}, -- ^ == \18
		[3]   = {20,  MPCD_xsize, MPCD_ysize}, -- ¶ == [] == \20
		[4]   = {26,  MPCD_xsize, MPCD_ysize}, -- > == -> == \26
		[5]   = {27,  MPCD_xsize, MPCD_ysize}, -- < == <- == \27
		[6]   = {31,  MPCD_xsize, MPCD_ysize}, -- SPARE 
		[7]   = {126, MPCD_xsize, MPCD_ysize}, -- ~
		[8]   = {32,  MPCD_xsize, MPCD_ysize}, -- [space]
		[9]   = {33,  MPCD_xsize, MPCD_ysize}, -- !
		[10]  = {35,  MPCD_xsize, MPCD_ysize}, -- #
		[11]  = {40,  MPCD_xsize, MPCD_ysize}, -- (
		[12]  = {41,  MPCD_xsize, MPCD_ysize}, -- )
		[13]  = {42,  MPCD_xsize, MPCD_ysize}, -- *
		[14]  = {43,  MPCD_xsize, MPCD_ysize}, -- +
		[15]  = {45,  MPCD_xsize, MPCD_ysize}, -- -
		[16]  = {46,  MPCD_xsize, MPCD_ysize}, -- .
		[17]  = {47,  MPCD_xsize, MPCD_ysize}, -- /
		[18]  = {48,  MPCD_xsize, MPCD_ysize}, -- 0
		[19]  = {49,  MPCD_xsize, MPCD_ysize}, -- 1
		[20]  = {50,  MPCD_xsize, MPCD_ysize}, -- 2
		[21]  = {51,  MPCD_xsize, MPCD_ysize}, -- 3
		[22]  = {52,  MPCD_xsize, MPCD_ysize}, -- 4
		[23]  = {53,  MPCD_xsize, MPCD_ysize}, -- 5
		[24]  = {54,  MPCD_xsize, MPCD_ysize}, -- 6
		[25]  = {55,  MPCD_xsize, MPCD_ysize}, -- 7
		[26]  = {56,  MPCD_xsize, MPCD_ysize}, -- 8
		[27]  = {57,  MPCD_xsize, MPCD_ysize}, -- 9
		[28]  = {58,  MPCD_xsize, MPCD_ysize}, -- :
		[29]  = {61,  MPCD_xsize, MPCD_ysize}, -- =
		[30]  = {63,  MPCD_xsize, MPCD_ysize}, -- ?
		[31]  = {65,  MPCD_xsize, MPCD_ysize}, -- A
		[32]  = {66,  MPCD_xsize, MPCD_ysize}, -- B
		[33]  = {67,  MPCD_xsize, MPCD_ysize}, -- C
		[34]  = {68,  MPCD_xsize, MPCD_ysize}, -- D
		[35]  = {69,  MPCD_xsize, MPCD_ysize}, -- E
		[36]  = {70,  MPCD_xsize, MPCD_ysize}, -- F
		[37]  = {71,  MPCD_xsize, MPCD_ysize}, -- G
		[38]  = {72,  MPCD_xsize, MPCD_ysize}, -- H
		[39]  = {73,  MPCD_xsize, MPCD_ysize}, -- I
		[40]  = {74,  MPCD_xsize, MPCD_ysize}, -- J
		[41]  = {75,  MPCD_xsize, MPCD_ysize}, -- K
		[42]  = {76,  MPCD_xsize, MPCD_ysize}, -- L
		[43]  = {77,  MPCD_xsize, MPCD_ysize}, -- M
		[44]  = {78,  MPCD_xsize, MPCD_ysize}, -- N
		[45]  = {79,  MPCD_xsize, MPCD_ysize}, -- O
		[46]  = {80,  MPCD_xsize, MPCD_ysize}, -- P
		[47]  = {81,  MPCD_xsize, MPCD_ysize}, -- Q
		[48]  = {82,  MPCD_xsize, MPCD_ysize}, -- R
		[49]  = {83,  MPCD_xsize, MPCD_ysize}, -- S
		[50]  = {84,  MPCD_xsize, MPCD_ysize}, -- T
		[51]  = {85,  MPCD_xsize, MPCD_ysize}, -- U
		[52]  = {86,  MPCD_xsize, MPCD_ysize}, -- V
		[53]  = {87,  MPCD_xsize, MPCD_ysize}, -- W
		[54]  = {88,  MPCD_xsize, MPCD_ysize}, -- X
		[55]  = {89,  MPCD_xsize, MPCD_ysize}, -- Y
		[56]  = {90,  MPCD_xsize, MPCD_ysize}, -- Z
		[57]  = {91,  MPCD_xsize, MPCD_ysize}, -- [
		[58]  = {93,  MPCD_xsize, MPCD_ysize}, -- ] 
		[59]  = {124, MPCD_xsize, MPCD_ysize}, -- | == ¦
		[60]  = {38,  MPCD_xsize, MPCD_ysize}, -- & == +- 
		[61]  = {59,  MPCD_xsize, MPCD_ysize}, -- ; == ° 
		[62]  = {95,  MPCD_xsize, MPCD_ysize}, -- _
		[63]  = {37,  MPCD_xsize, MPCD_ysize},-- %
	}
}

UFC_xsize = 146
UFC_ysize = 146

fontdescription["font_UFC"] = {
	texture		= LockOn_Options.script_path.."Resources/Fonts/font_UFC_AV8B.dds",
	size		= {7, 7},
	resolution	= {1024, 1024},
	default		= {UFC_xsize, UFC_ysize},
	chars		= {
		[1]		= {32,	UFC_xsize, UFC_ysize},	-- SPACE
		[2]		= {48,	UFC_xsize, UFC_ysize},	-- 0
		[3]		= {49,	UFC_xsize, UFC_ysize},	-- 1
		[4]		= {50,	UFC_xsize, UFC_ysize},	-- 2
		[5]		= {51,	UFC_xsize, UFC_ysize},	-- 3
		[6]		= {52,	UFC_xsize, UFC_ysize},	-- 4
		[7]		= {53,	UFC_xsize, UFC_ysize},	-- 5
		[8]		= {54,	UFC_xsize, UFC_ysize},	-- 6
		[9]		= {55,	UFC_xsize, UFC_ysize},	-- 7
		[10]	= {56,	UFC_xsize, UFC_ysize},	-- 8
		[11]	= {57,	UFC_xsize, UFC_ysize},	-- 9
		[12]	= {126,	UFC_xsize, UFC_ysize},	-- ~
		[13]	= {65,	UFC_xsize, UFC_ysize},	-- A
		[14]	= {66,	UFC_xsize, UFC_ysize},	-- B
		[15]	= {67,	UFC_xsize, UFC_ysize},	-- C
		[16]	= {68,	UFC_xsize, UFC_ysize},	-- D
		[17]	= {69,	UFC_xsize, UFC_ysize},	-- E
		[18]	= {70,	UFC_xsize, UFC_ysize},	-- F
		[19]	= {71,	UFC_xsize, UFC_ysize},	-- G
		[20]	= {72,	UFC_xsize, UFC_ysize},	-- H
		[21]	= {73,	UFC_xsize, UFC_ysize},	-- I
		[22]	= {74,	UFC_xsize, UFC_ysize},	-- J
		[23]	= {75,	UFC_xsize, UFC_ysize},	-- K
		[24]	= {76,	UFC_xsize, UFC_ysize},	-- L
		[25]	= {77,	UFC_xsize, UFC_ysize},	-- M
		[26]	= {78,	UFC_xsize, UFC_ysize},	-- N
		[27]	= {79,	UFC_xsize, UFC_ysize},	-- O
		[28]	= {80,	UFC_xsize, UFC_ysize},	-- P
		[29]	= {81,	UFC_xsize, UFC_ysize},	-- Q
		[30]	= {82,	UFC_xsize, UFC_ysize},	-- R
		[31]	= {83,	UFC_xsize, UFC_ysize},	-- S
		[32]	= {84,	UFC_xsize, UFC_ysize},	-- T
		[33]	= {85,	UFC_xsize, UFC_ysize},	-- U
		[34]	= {86,	UFC_xsize, UFC_ysize},	-- V
		[35]	= {87,	UFC_xsize, UFC_ysize},	-- W
		[36]	= {88,	UFC_xsize, UFC_ysize},	-- X
		[37]	= {89,	UFC_xsize, UFC_ysize},	-- Y
		[38]	= {90,	UFC_xsize, UFC_ysize},	-- Z
		[39]	= {47,	UFC_xsize, UFC_ysize},	-- /
		[40]	= {95,	UFC_xsize, UFC_ysize},	-- _ 
		[41]	= {58,	UFC_xsize, UFC_ysize},	-- :
		[42]	= {42,	UFC_xsize, UFC_ysize},	-- *
		[43]	= {44,	UFC_xsize, UFC_ysize},	-- ,
		[44]	= {64,	UFC_xsize, UFC_ysize},	-- @
		[45]	= {46,	UFC_xsize, UFC_ysize},	-- .
		[46]	= {39,	UFC_xsize, UFC_ysize},	-- '
		[47]	= {45,	UFC_xsize, UFC_ysize},	-- -
		[48]	= {33,	UFC_xsize, UFC_ysize},	-- !
		[49]	= {124,	UFC_xsize, UFC_ysize},	-- |
	}
}

local agm_65e_x = 30
local agm_65e_y = 50
fontdescription["font_LMAV"] = {
	texture    = "Fonts/font_AGM_65E.tga",
	texture		= LockOn_Options.script_path.."Resources/Fonts/font_AGM_65E.dds",
	size      = {5, 5},
	resolution = {256, 256}	,
	default    = {agm_65e_x, agm_65e_y}	,
	chars	   = {
		{48, agm_65e_x, agm_65e_y}, -- 0
		{49, agm_65e_x, agm_65e_y}, -- 1
		{50, agm_65e_x, agm_65e_y}, -- 2
		{51, agm_65e_x, agm_65e_y}, -- 3
		{52, agm_65e_x, agm_65e_y}, -- 4
		{53, agm_65e_x, agm_65e_y}, -- 5
		{54, agm_65e_x, agm_65e_y}, -- 6
		{55, agm_65e_x, agm_65e_y}, -- 7
		{56, agm_65e_x, agm_65e_y}, -- 8
		{67, agm_65e_x, agm_65e_y}, -- C 
		{83, agm_65e_x, agm_65e_y}, -- S
		{32, agm_65e_x, agm_65e_y}, -- SPACE
	} 
}

-- Stroke Fonts
fontdescription["font_stroke_HUD"] = {
	class     = "ceSLineFont",
	symb_storage = "stroke_font_HUD",
	thickness  = stroke_thickness,
	fuzziness  = stroke_fuzziness,
	draw_as_wire = dbg_drawStrokesAsWire,
	default    = {12, 20}, -- DIs (display increments)
	chars	   = {
		 [1]   = {latin['A'], "A"},
		 [2]   = {latin['B'], "B"},
		 [3]   = {latin['C'], "C"},
		 [4]   = {latin['D'], "D"},
		 [5]   = {latin['E'], "E"},
		 [6]   = {latin['F'], "F"},
		 [7]   = {latin['G'], "G"},
		 [8]   = {latin['H'], "H"},
		 [9]   = {latin['I'], "I"},
		 [10]  = {latin['J'], "J"},
		 [11]  = {latin['K'], "K"},
		 [12]  = {latin['L'], "L"},
		 [13]  = {latin['M'], "M"},
		 [14]  = {latin['N'], "N"},
		 [15]  = {latin['O'], "O"},
		 [16]  = {latin['P'], "P"},
		 [17]  = {latin['Q'], "Q"},
		 [18]  = {latin['R'], "R"},
		 [19]  = {latin['S'], "S"},
		 [20]  = {latin['T'], "T"},
		 [21]  = {latin['U'], "U"},
		 [22]  = {latin['V'], "V"},
		 [23]  = {latin['W'], "W"},
		 [24]  = {latin['X'], "X"},
		 [25]  = {latin['Y'], "Y"},
		 [26]  = {latin['Z'], "Z"},
		 
		 [27]  = {symbol['0'], "0"},
		 [28]  = {symbol['1'], "1"},
		 [29]  = {symbol['2'], "2"},
		 [30]  = {symbol['3'], "3"},
		 [31]  = {symbol['4'], "4"},
		 [32]  = {symbol['5'], "5"},
		 [33]  = {symbol['6'], "6"},
		 [34]  = {symbol['7'], "7"},
		 [35]  = {symbol['8'], "8"},
		 [36]  = {symbol['9'], "9"},
		 
		 [37]  = {symbol['-'], "symbol-minus"},
		 [38]  = {symbol['+'], "symbol-plus"},
		 [39]  = {symbol['\''], "symbol-apostrophe"},
		 [40]  = {symbol['('], "symbol-parenthesis-left"},
		 [41]  = {symbol[')'], "symbol-parenthesis-right"},
		 [42]  = {symbol['*'], "symbol-asterisk"},
		 [43]  = {symbol['%'], "symbol-percent"},
		 [44]  = {symbol[','], "symbol-comma"},
		 [45]  = {symbol['°'], "symbol-degree"},
		 [46]  = {symbol['.'], "symbol-period"},
		 [47]  = {symbol['/'], "symbol-slash"},
		 [48]  = {symbol['\\'], "symbol-backslash"},
		 [49]  = {symbol['\"'], "symbol-quote"},
		 [50]  = {symbol['?'], "symbol-question"},
		 [51]  = {symbol[':'], "symbol-colon"},
		 [52]  = {symbol['#'], "symbol-octothorpe"},
		 [53]  = {symbol['='], "symbol-equal"},
		 [54]  = {symbol['_'], "symbol-underscore"},
	}
}

fontdescription["font_stroke_HUD_outline"] = {}
copyTable(fontdescription["font_stroke_HUD_outline"], fontdescription["font_stroke_HUD"])
fontdescription["font_stroke_HUD_outline"].thickness = DMC_outline_thickness
fontdescription["font_stroke_HUD_outline"].fuzziness = DMC_outline_fuzziness

fontdescription["font_stroke_MPCD"] = {
	class     = "ceSLineFont",
	symb_storage = "stroke_font_MPD",
	thickness  = stroke_thickness,
	fuzziness  = stroke_fuzziness,
	draw_as_wire = dbg_drawStrokesAsWire,
	default    = {13, 22}, -- DIs (display increments)	-- {12, 20}
	chars	   = {
		 [1]   = {latin['A'], "A"},
		 [2]   = {latin['B'], "B"},
		 [3]   = {latin['C'], "C"},
		 [4]   = {latin['D'], "D"},
		 [5]   = {latin['E'], "E"},
		 [6]   = {latin['F'], "F"},
		 [7]   = {latin['G'], "G"},
		 [8]   = {latin['H'], "H"},
		 [9]   = {latin['I'], "I"},
		 [10]  = {latin['J'], "J"},
		 [11]  = {latin['K'], "K"},
		 [12]  = {latin['L'], "L"},
		 [13]  = {latin['M'], "M"},
		 [14]  = {latin['N'], "N"},
		 [15]  = {latin['O'], "O"},
		 [16]  = {latin['P'], "P"},
		 [17]  = {latin['Q'], "Q"},
		 [18]  = {latin['R'], "R"},
		 [19]  = {latin['S'], "S"},
		 [20]  = {latin['T'], "T"},
		 [21]  = {latin['U'], "U"},
		 [22]  = {latin['V'], "V"},
		 [23]  = {latin['W'], "W"},
		 [24]  = {latin['X'], "X"},
		 [25]  = {latin['Y'], "Y"},
		 [26]  = {latin['Z'], "Z"},
		 
		 [27]  = {symbol['0'], "0"},
		 [28]  = {symbol['1'], "1"},
		 [29]  = {symbol['2'], "2"},
		 [30]  = {symbol['3'], "3"},
		 [31]  = {symbol['4'], "4"},
		 [32]  = {symbol['5'], "5"},
		 [33]  = {symbol['6'], "6"},
		 [34]  = {symbol['7'], "7"},
		 [35]  = {symbol['8'], "8"},
		 [36]  = {symbol['9'], "9"},
		 
		 [37]  = {symbol['('], "symbol-parenthesis-left"},
		 [38]  = {symbol[')'], "symbol-parenthesis-right"},
		 [39]  = {symbol['*'], "symbol-asterisk"},
		 [40]  = {symbol['%'], "symbol-percent"},
		 [41]  = {symbol['-'], "symbol-minus"},
		 [42]  = {symbol['+'], "symbol-plus"},
		 [43]  = {symbol['\''], "symbol-apostrophe"},
		 [44]  = {symbol['\\'], "symbol-backslash"},
		 [45]  = {symbol[';'], "symbol-degree"},
		 [46]  = {symbol['.'], "symbol-period"},
		 [47]  = {symbol[','], "symbol-comma"},
		 [48]  = {symbol['\"'], "symbol-quote"},
		 [49]  = {symbol['?'], "symbol-question"},
		 [50]  = {symbol[':'], "symbol-colon"},
		 [51]  = {symbol['='], "symbol-equal"},
		 [52]  = {symbol['#'], "symbol-octothorpe"},
		 [53]  = {symbol['/'], "symbol-slash"},
		 [54]  = {symbol['_'], "symbol-underscore"},
		 [55]  = {symbol['>'], "symbol-greater"},
		 [56]  = {symbol['<'], "symbol-less"},
		 [57]  = {symbol['|'], "symbol-stop"},
		 [58]  = {symbol['|'], "symbol-hashtag"},
	}
}

fontdescription["font_stroke_MPCD_outline"] = {}
copyTable(fontdescription["font_stroke_MPCD_outline"], fontdescription["font_stroke_MPCD"])
fontdescription["font_stroke_MPCD_outline"].thickness = DMC_outline_thickness
fontdescription["font_stroke_MPCD_outline"].fuzziness = DMC_outline_fuzziness


-- FONTS DEFINITIONS
fonts = {}
-- GENERAL FONTS
fonts["font_general_keys"]		= {fontdescription["font_general_loc"], 10, {255,75,75,255}}
fonts["font_hints_kneeboard"]	= {fontdescription["font_general_loc"], 10, materials["BLUE"]}
fonts["font_data_kneeboard"]	= {fontdescription["font_general_loc"], 10, materials["BLACK"]}

-- HUD
fonts["hud_indication_font"]		= {fontdescription["font_HUD"], 				10, materials["HUD_GREEN_BRIGHT"]}
fonts["hud_alignment_font"]			= {fontdescription["font_HUD"], 				10, materials["HUD_HLPR_YELLOW"]}
fonts["font_HUD_stroke"]			= {fontdescription["font_stroke_HUD"],			10, materials["HUD_GREEN_BRIGHT"]}
fonts["font_HUD_stroke_outline"]	= {fontdescription["font_stroke_HUD_outline"],	10, materials["BLACK"]}
fonts["font_HUD_stroke_rl"]			= {fontdescription["font_stroke_HUD"],			10, materials["HUD_GREEN_BRIGHT"]}
fonts["font_HUD_stroke_ol_rl"]		= {fontdescription["font_stroke_HUD_outline"],	10, materials["BLACK"]}
fonts["font_HUD_stroke_rr"]			= {fontdescription["font_stroke_HUD"],			10, materials["HUD_GREEN_BRIGHT"]}
fonts["font_HUD_stroke_ol_rr"]		= {fontdescription["font_stroke_HUD_outline"],	10, materials["BLACK"]}

-- HUD Repeater Left
fonts["hrl_indication_font"]	= {fontdescription["font_HUD"], 10, materials["MPCD_GREEN_DAY"]}
fonts["hrl_alignment_font"]		= {fontdescription["font_HUD"], 10, materials["HUD_HLPR_YELLOW"]}

-- HUD Repeater Right
fonts["hrr_indication_font"]	= {fontdescription["font_HUD"], 10, materials["MPCD_GREEN_DAY"]}
fonts["hrr_alignment_font"]		= {fontdescription["font_HUD"], 10, materials["HUD_HLPR_YELLOW"]}

-- MPCDs
fonts["mpcd_tpod_font_bg"]		= {fontdescription["font_TPOD"], 10, materials["MPCD_BLACK"]}

-- LEFT MPCD
fonts["mpcdl_font_base"]			= {fontdescription["font_MPCD"], 10, materials["MPCD_GREEN_DAY"]}
fonts["mpcdl_tpod_font"]			= {fontdescription["font_TPOD"], 10, materials["MPCD_GREEN_DAY"]}
fonts["mpcdl_lmav_font"]			= {fontdescription["font_LMAV"], 10, materials["MPCD_GREEN_DAY"]}
fonts["font_MPCDL_stroke"]			= {fontdescription["font_stroke_MPCD"],			10, materials["MPCD_GREEN_DAY"]}
fonts["font_MPCDL_stroke_bg"]		= {fontdescription["font_stroke_MPCD"],			10, materials["BLACK"]}
fonts["font_MPCDL_stroke_outline"]	= {fontdescription["font_stroke_MPCD_outline"],	10, materials["BLACK"]}

--  RIGHT MPCD
fonts["mpcdr_font_base"]			= {fontdescription["font_MPCD"], 10, materials["MPCD_GREEN_DAY"]}
fonts["mpcdr_tpod_font"]			= {fontdescription["font_TPOD"], 10, materials["MPCD_GREEN_DAY"]}
fonts["mpcdr_lmav_font"]			= {fontdescription["font_LMAV"], 10, materials["MPCD_GREEN_DAY"]}
fonts["font_MPCDR_stroke"]			= {fontdescription["font_stroke_MPCD"],			10, materials["MPCD_GREEN_DAY"]}
fonts["font_MPCDR_stroke_bg"]		= {fontdescription["font_stroke_MPCD"],			10, materials["BLACK"]}
fonts["font_MPCDR_stroke_outline"]	= {fontdescription["font_stroke_MPCD_outline"],	10, materials["BLACK"]}

-- UFC/ODU
fonts["ufc_font_base"]			= {fontdescription["font_UFC"], 10, materials["UFC_GREEN"]}

-- path for stroke symbology
symbologyPaths = {	LockOn_Options.script_path.."Resources/Fonts",
					LockOn_Options.script_path.."Resources/HUD",
					LockOn_Options.script_path.."Resources/MPCD"}
