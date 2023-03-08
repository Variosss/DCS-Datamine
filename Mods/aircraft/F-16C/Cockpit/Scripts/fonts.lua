dofile(LockOn_Options.common_script_path.."Fonts/symbols_locale.lua")
dofile(LockOn_Options.common_script_path.."Fonts/fonts_cmn.lua")
dofile(LockOn_Options.common_script_path.."tools.lua")
dofile(LockOn_Options.script_path.."Displays/MFD/indicator/MFD_Strokes_Defs.lua")
dofile(LockOn_Options.script_path.."Displays/Common/indicator/StrokesDefs.lua")

local ResourcesPath = LockOn_Options.script_path.."../IndicationResources/"

fontdescription = {}

fontdescription["font_stroke_HUD"] = {
	class     = "ceSLineFont",
	symb_storage = "stroke_font",
	thickness  = 0.25,
	fuzziness  = 0.6,
	draw_as_wire = dbg_drawStrokesAsWire,
	default    = {13, 20},
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
		 [55]  = {symbol['>'], "symbol-greater"},
		 [56]  = {symbol['<'], "symbol-less"},
	}
}

fontdescription["font_stroke_MFD"] = {
	class     = "ceSLineFont",
	symb_storage = "MFD_stroke_font",
	thickness  = MFD_stroke_thickness,
	fuzziness  = MFD_stroke_fuzziness,
	draw_as_wire = dbg_drawStrokesAsWire,
	default    = {8, 12}, -- DIs (display increments)
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

fontdescription["font_stroke_MFD_Wide"] = {
	class     		= "ceSLineFont",
	symb_storage 	= "MFD_stroke_font",
	thickness  		= MFD_stroke_thickness * 2.1,
	fuzziness  		= MFD_stroke_fuzziness,
	draw_as_wire 	= dbg_drawStrokesAsWire,
	default    		= {8, 12},
	chars	   		= fontdescription["font_stroke_MFD"].chars
}

fontdescription["font_stroke_MFD_Bold"] = {
	class     		= "ceSLineFont",
	symb_storage 	= "MFD_stroke_font",
	thickness  		= MFD_stroke_thickness * 3.2,
	fuzziness  		= MFD_stroke_fuzziness * 1.5,
	draw_as_wire 	= dbg_drawStrokesAsWire,
	default    		= {8, 12},
	chars	   		= fontdescription["font_stroke_MFD"].chars
}

local ded_char_w = 64
local ded_char_h = 52
local font_DED_chars = {
	[1]		= {latin['A'], ded_char_w, ded_char_h},
	[2]		= {latin['B'], ded_char_w, ded_char_h},
	[3]		= {latin['C'], ded_char_w, ded_char_h},
	[4]		= {latin['D'], ded_char_w, ded_char_h},
	[5]		= {latin['E'], ded_char_w, ded_char_h},
	[6]		= {latin['F'], ded_char_w, ded_char_h},
	[7]		= {latin['G'], ded_char_w, ded_char_h},
	[8]		= {latin['H'], ded_char_w, ded_char_h},
	[9]		= {latin['I'], ded_char_w, ded_char_h},
	[10]	= {latin['J'], ded_char_w, ded_char_h},
	[11]	= {latin['K'], ded_char_w, ded_char_h},
	[12]	= {latin['L'], ded_char_w, ded_char_h},
	[13]	= {latin['M'], ded_char_w, ded_char_h},
	[14]	= {latin['N'], ded_char_w, ded_char_h},
	[15]	= {latin['O'], ded_char_w, ded_char_h},
	[16]	= {latin['P'], ded_char_w, ded_char_h},
	[17]	= {latin['Q'], ded_char_w, ded_char_h},
	[18]	= {latin['R'], ded_char_w, ded_char_h},
	[19]	= {latin['S'], ded_char_w, ded_char_h},
	[20]	= {latin['T'], ded_char_w, ded_char_h},
	[21]	= {latin['U'], ded_char_w, ded_char_h},
	[22]	= {latin['V'], ded_char_w, ded_char_h},
	[23]	= {latin['W'], ded_char_w, ded_char_h},
	[24]	= {latin['X'], ded_char_w, ded_char_h},
	[25]	= {latin['Y'], ded_char_w, ded_char_h},
	[26]	= {latin['Z'], ded_char_w, ded_char_h},

	[27]	= {symbol['1'], ded_char_w, ded_char_h},
	[28]	= {symbol['2'], ded_char_w, ded_char_h},
	[29]	= {symbol['3'], ded_char_w, ded_char_h},
	[30]	= {symbol['4'], ded_char_w, ded_char_h},
	[31]	= {symbol['5'], ded_char_w, ded_char_h},
	[32]	= {symbol['6'], ded_char_w, ded_char_h},
	[33]	= {symbol['7'], ded_char_w, ded_char_h},
	[34]	= {symbol['8'], ded_char_w, ded_char_h},
	[35]	= {symbol['9'], ded_char_w, ded_char_h},
	[36]	= {symbol['0'], ded_char_w, ded_char_h},

	[37]	= {latin['a'], ded_char_w, ded_char_h},	-- small triangles up and down in the same symbol
	[38]	= {symbol['('], ded_char_w, ded_char_h},
	[39]	= {symbol[')'], ded_char_w, ded_char_h},
	[40]	= {symbol['<'], ded_char_w, ded_char_h},
	[41]	= {symbol['>'], ded_char_w, ded_char_h},
	[42]	= {symbol['['], ded_char_w, ded_char_h},
	[43]	= {symbol[']'], ded_char_w, ded_char_h},
	[44]	= {symbol['+'], ded_char_w, ded_char_h},
	[45]	= {symbol['-'], ded_char_w, ded_char_h},
	[46]	= {symbol['*'], ded_char_w, ded_char_h},
	[47]	= {symbol['/'], ded_char_w, ded_char_h},
	[48]	= {symbol['='], ded_char_w, ded_char_h},
	[49]	= {latin['o'], ded_char_w, ded_char_h},	-- degrees
	[50]	= {symbol['|'], ded_char_w, ded_char_h},
	[51]	= {latin['d'], ded_char_w, ded_char_h},	-- arrow down
	[52]	= {latin['u'], ded_char_w, ded_char_h},	-- arrow up
	[53]	= {symbol['.'], ded_char_w, ded_char_h},
	[54]	= {symbol[','], ded_char_w, ded_char_h},
	[55]	= {symbol['!'], ded_char_w, ded_char_h},
	[56]	= {symbol['?'], ded_char_w, ded_char_h},
	[57]	= {symbol[':'], ded_char_w, ded_char_h},
	[58]	= {symbol[';'], ded_char_w, ded_char_h},
	[59]	= {symbol['&'], ded_char_w, ded_char_h},
	[60]	= {symbol['_'], ded_char_w, ded_char_h},
	[61]	= {symbol['\''], ded_char_w, ded_char_h},
	[62]	= {symbol['"'], ded_char_w, ded_char_h},
	[63]	= {symbol['%'], ded_char_w, ded_char_h},
	[64]	= {symbol['#'], ded_char_w, ded_char_h},
	[65]	= {symbol['@'], ded_char_w, ded_char_h},
	[66]	= {symbol[' '], ded_char_w, ded_char_h},
}

fontdescription["font_DED"] = {
	texture		= ResourcesPath.."/Displays/ded_font.dds",
	size		= {9, 8},	-- rows, columns
	resolution	= {512, 468},	-- [w, h] resolution of texture in pixels
	default		= {ded_char_w, ded_char_h},	-- [w,h] resolution for symbol in pixels
	chars		= font_DED_chars
}
fontdescription["font_DED_inv"] = {
	texture		= ResourcesPath.."/Displays/ded_font_inv.dds",
	size		= {9, 8},	-- rows, columns
	resolution	= {512, 468},	-- [w, h] resolution of texture in pixels
	default		= {ded_char_w, ded_char_h},	-- [w,h] resolution for symbol in pixels
	chars		= font_DED_chars
}

fontdescription["font_PFLD"]		= fontdescription.font_DED
fontdescription["font_PFLD_inv"]	= fontdescription.font_DED_inv


dofile(LockOn_Options.common_script_path.."Fonts/font_ARC_164_LCD.lua")
fontdescription["font_UHF_RADIO"] = fontdescription_ARC_164_LCD


fontdescription["font_stroke_EHSI"] = {
	class     = "ceSLineFont",
	symb_storage = "stroke_font_EHSI",
	thickness  = 0.25,
	fuzziness  = 0.6,
	draw_as_wire = dbg_drawStrokesAsWire,
	default    = {13, 20},
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
		 [55]  = {symbol['>'], "symbol-greater"},
		 [56]  = {symbol['<'], "symbol-less"},
		 
		 [57]  = {symbol['|'], "1-alt"},	-- '|' = '1' without bottom line
	}
}

fontdescription["font_stroke_RWR"] = {
	class     = "ceSLineFont",
	symb_storage = "FONT_RWR_F16",
	thickness  = stroke_thickness,
	fuzziness  = stroke_fuzziness,
	draw_as_wire = dbg_drawStrokesAsWire,
	default    = {1, 1},
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
	}
}

RWR_xsize = 68
RWR_ysize = 73
fontdescription["font_RWR"] = {
	texture    = ResourcesPath.."RWR/font_RWR.tga",
	size      = {7, 7},		-- rows, columns
	resolution = {512, 512},	-- [w, h] resolution of texture in pixels
	default    = {RWR_xsize, RWR_ysize},	-- [w,h] resolution for symbol in pixels
	chars	    = {
		 [1]  = {32, RWR_xsize, RWR_ysize}, -- [space]
		 [2]  = {45, RWR_xsize, RWR_ysize}, -- -
		 [3]  = {47, RWR_xsize, RWR_ysize}, -- /
		 [4]  = {48, RWR_xsize, RWR_ysize}, -- 0
		 [5]  = {49, RWR_xsize, RWR_ysize}, -- 1
		 [6]  = {50, RWR_xsize, RWR_ysize}, -- 2
		 [7]  = {51, RWR_xsize, RWR_ysize}, -- 3
		 [8]  = {52, RWR_xsize, RWR_ysize}, -- 4
		 [9]  = {53, RWR_xsize, RWR_ysize}, -- 5
		 [10]  = {54, RWR_xsize, RWR_ysize}, -- 6
		 [11]  = {55, RWR_xsize, RWR_ysize}, -- 7
		 [12]  = {56, RWR_xsize, RWR_ysize}, -- 8
		 [13]  = {57, RWR_xsize, RWR_ysize}, -- 9
		 [14]  = {58, RWR_xsize, RWR_ysize}, -- :
		 [15]  = {65, RWR_xsize, RWR_ysize}, -- A
		 [16]  = {66, RWR_xsize, RWR_ysize}, -- B
		 [17]  = {67, RWR_xsize, RWR_ysize}, -- C
		 [18]  = {68, RWR_xsize, RWR_ysize}, -- D
		 [19]  = {69, RWR_xsize, RWR_ysize}, -- E
		 [20]  = {70, RWR_xsize, RWR_ysize}, -- F
		 [21]  = {71, RWR_xsize, RWR_ysize}, -- G
		 [22]  = {72, RWR_xsize, RWR_ysize}, -- H
		 [23]  = {73, RWR_xsize, RWR_ysize}, -- I
		 [24]  = {74, RWR_xsize, RWR_ysize}, -- J
		 [25]  = {75, RWR_xsize, RWR_ysize}, -- K
		 [26]  = {76, RWR_xsize, RWR_ysize}, -- L
		 [27]  = {77, RWR_xsize, RWR_ysize}, -- M
		 [28]  = {78, RWR_xsize, RWR_ysize}, -- N
		 [29]  = {79, RWR_xsize, RWR_ysize}, -- O
		 [30]  = {80, RWR_xsize, RWR_ysize}, -- P
		 [31]  = {81, RWR_xsize, RWR_ysize}, -- Q
		 [32]  = {82, RWR_xsize, RWR_ysize}, -- R
		 [33]  = {83, RWR_xsize, RWR_ysize}, -- S
		 [34]  = {84, RWR_xsize, RWR_ysize}, -- T
		 [35]  = {85, RWR_xsize, RWR_ysize}, -- U
		 [36]  = {86, RWR_xsize, RWR_ysize}, -- V
		 [37]  = {87, RWR_xsize, RWR_ysize}, -- W
		 [38]  = {88, RWR_xsize, RWR_ysize}, -- X
		 [39]  = {89, RWR_xsize, RWR_ysize}, -- Y
		 [40]  = {90, RWR_xsize, RWR_ysize}, -- Z
		} 
}

local cmds_char_w = 64
local cmds_char_h = 64
fontdescription["font_CMDS"] = {
	texture		= ResourcesPath.."/CMDS/CMDS_Font.tga",
	size		= {8, 8},	-- rows, columns
	resolution	= {512, 512},	-- [w, h] resolution of texture in pixels
	default		= {cmds_char_w, cmds_char_h},	-- [w,h] resolution for symbol in pixels
	chars		= {
	[1]		= {symbol['0'], cmds_char_w, cmds_char_h},
	[2]		= {symbol['1'], cmds_char_w, cmds_char_h},
	[3]		= {symbol['2'], cmds_char_w, cmds_char_h},
	[4]		= {symbol['3'], cmds_char_w, cmds_char_h},
	[5]		= {symbol['4'], cmds_char_w, cmds_char_h},
	[6]		= {symbol['5'], cmds_char_w, cmds_char_h},
	[7]		= {symbol['6'], cmds_char_w, cmds_char_h},
	[8]		= {symbol['7'], cmds_char_w, cmds_char_h},
	[9]		= {symbol['8'], cmds_char_w, cmds_char_h},
	[10]	= {symbol['9'], cmds_char_w, cmds_char_h},
	[11]	= {symbol[' '], cmds_char_w, cmds_char_h},
	[12]	= {latin['L'], cmds_char_w, cmds_char_h},
	[13]	= {latin['o'], cmds_char_w, cmds_char_h},
	}
}

-- HMD
fontdescription["font_stroke_HMD"] = {
	class     = "ceSLineFont",
	symb_storage = "stroke_font",
	thickness  = 0.5,
	fuzziness  = 0.6,
	draw_as_wire = dbg_drawStrokesAsWire,
	default    = {13, 20},
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
		 [55]  = {symbol['>'], "symbol-greater"},
		 [56]  = {symbol['<'], "symbol-less"},
	}
}

fontdescription["font_general_loc"] = fontdescription_cmn["font_general_loc"]

dofile(LockOn_Options.common_script_path.."Fonts/font_TGP_Litening_AT.lua")
fontdescription["font_TGP"] = fontdescription_TGP_Litening_AT

