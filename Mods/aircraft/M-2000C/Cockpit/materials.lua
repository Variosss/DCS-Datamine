dofile(LockOn_Options.common_script_path.."Fonts/symbols_locale.lua")
dofile(LockOn_Options.common_script_path.."Fonts/fonts_cmn.lua")
dofile(LockOn_Options.common_script_path.."Fonts/font_5mmbluegelpen.lua")
dofile(LockOn_Options.script_path.."settingsloader.lua")

settings = settingsloader("settings.lua")

symbologyPaths = {LockOn_Options.script_path.."../Resources", "Mods/aircraft/M-2000C/Cockpit/Resources" }
					
-------MATERIALS-------

materials = {}   
materials["INDICATION_COMMON_RED"]		= {255, 0, 0, 255}
materials["INDICATION_COMMON_WHITE"]	= {255, 255, 255, 255}
materials["MASK_MATERIAL"] = {255, 0, 255, 50}

materials["HUD_IND_YELLOW"]   = {243, 116, 13, 255}
materials["INDICATION_COMMON_RED"] = {255, 0, 0, 255}

materials["LBLUE"] = {173, 216, 230, 255}

materials["DBG_GREY"]			= {25, 25, 25, 255}
materials["DBG_BLACK"]			= {0, 0, 0, 100}
materials["DBG_RED"]			= {255, 0, 0, 255}
materials["DBG_GREEN"]			= {0, 255, 0, 100}
materials["BLACK"]				= {0, 0, 0, 255}
materials["SIMPLE_WHITE"]		= {255, 255, 255, 255}
materials["PURPLE"]				= {255, 0, 255, 255}

materials["GENERAL_INFO_GOLD"]	= {255, 197, 3, 255}
materials["YELLOW"]				= {255, 255, 0, 255}
materials["BLUE"]				= {255, 0, 0, 255}
materials["RED"]				= {255, 0, 0, 255}

materials["VTH_GREEN"]			= {0, 255, 64, 385}
materials["GREENBOX_GREEN"]		= {20, 225, 20, 225} 
materials["VCM_GREEN"]			= { 0, 255, 48, 255} 
materials["5X7_GREEN"]			= {56, 234, 1, 255}
materials["PCA_GREEN"]			= {46, 246, 45, 225}
materials["LCD_RED"]			= {255, 0, 0, 255}

materials["VTB_GREEN"]			= { 32, 223, 32, 255}
materials["VTB_YELLOW"]			= {255, 255, 32, 255}
materials["VTB_RED"]			= {223,  32, 16, 255}

materials["SUN_VISOR"]			= {0, 0, 0, 150}

-------TEXTURES-------
textures = {}

---- VTH ----
textures["vth_green"]						= {nil, materials["VTH_GREEN"]}
textures["vth_red"]							= {nil, materials["DBG_RED"]}


---- VTB ----
textures["vtb_mrq"]							= {nil, materials["VTB_GREEN"]  }
textures["vtb_vid"]							= {nil, materials["VTB_GREEN"]  }
textures["vtb_cav"]							= {nil, materials["VTB_GREEN"]  }
textures["vtb_vid_contacts"]				= {nil, materials["VTB_GREEN"]  }
textures["vtb_cav_contacts"]				= {nil, materials["VTB_GREEN"]  }
textures["vtb_green"]						= {nil, materials["VTB_GREEN"]  }
textures["vtb_yellow"]						= {nil, materials["VTB_YELLOW"]	}
textures["vtb_red"]							= {nil, materials["VTB_RED"]    }
textures["vtb_vid_image"]					= {nil, {128,128,128,255}}
textures["vtb_baked_image"]					= {nil, materials["SIMPLE_WHITE"]}
textures["vtb_fov_material"]				= {LockOn_Options.script_path.."Resources/vtb-fov.tga", materials["SIMPLE_WHITE"]}
textures["aoa_repeater"]					= {LockOn_Options.script_path.."Resources/aoa.tga", materials["SIMPLE_WHITE"]}


---- VCM ----
textures["vcm_green"]						= {nil, materials["VCM_GREEN"]  }
textures["vcm_baked_image"]					= {nil, materials["SIMPLE_WHITE"]}

---- Sun Visor ----
textures["helmet_sun_visor"]				= {LockOn_Options.script_path.."Resources/visor.tga", materials["SUN_VISOR"]}



-------FONTS----------
fontdescription = {}
fontdescription["font_general_loc"]   = fontdescription_cmn["font_general_loc"]

symbol_pixels_x =   44 * 2 -- pi
symbol_pixels_y =  72.0 * 2

mm_to_px = 96.0/25.4

fontdescription["VTH_font"] = {
	class     = "ceSLineFont",
	symb_storage = "vth-font",
	thickness  = settings.vth_thickness,
	fuzziness  = settings.vth_fuzziness,
	draw_as_wire = false,
	default    = {9,12}, -- display increments, must be given in SVG px
	chars	   = {
		 {symbol['0'],  "vth-font-0"},
		 {symbol['1'],  "vth-font-1"},
		 {symbol['2'],  "vth-font-2"},
		 {symbol['3'],  "vth-font-3"},
		 {symbol['4'],  "vth-font-4"},
		 {symbol['5'],  "vth-font-5"},
		 {symbol['6'],  "vth-font-6"},
		 {symbol['7'],  "vth-font-7"},
		 {symbol['8'],  "vth-font-8"},
		 {symbol['9'],  "vth-font-9"},
		 {latin['A'],  "vth-font-a"},
		 {latin['B'],  "vth-font-b"},
		 {latin['C'],  "vth-font-c"},
		 {latin['D'],  "vth-font-d"},
		 {latin['E'],  "vth-font-e"},
		 {latin['F'],  "vth-font-f"},
		 {latin['G'],  "vth-font-g"},
		 {latin['H'],  "vth-font-h"},
		 {latin['I'],  "vth-font-i"},
		 {latin['J'],  "vth-font-j"},
		 {latin['K'],  "vth-font-k"},
		 {latin['L'],  "vth-font-l"},
		 {latin['M'],  "vth-font-m"},
		 {latin['N'],  "vth-font-n"},
		 {latin['O'],  "vth-font-o"},
		 {latin['P'],  "vth-font-p"},
		 {latin['Q'],  "vth-font-q"},
		 {latin['R'],  "vth-font-r"},
		 {latin['S'],  "vth-font-s"},
		 {latin['T'],  "vth-font-t"},
		 {latin['U'],  "vth-font-u"},
		 {latin['V'],  "vth-font-v"},
		 {latin['W'],  "vth-font-w"},
		 {latin['X'],  "vth-font-x"},
		 {latin['Y'],  "vth-font-y"},
		 {latin['Z'],  "vth-font-z"},
		 {symbol['*'],  "vth-font-star"},
		 {symbol['.'],  "vth-font-dot", 6},
		 {symbol['-'],  "vth-font-dash"},
		 --[39]  = {symbol['@'],  "vth-font-alpha"},
	}
}



fontdescription["VTB_font"] = {
	class     = "ceSLineFont",
	symb_storage = "vtb",
	thickness  = settings.vtb_thickness*0.06*180,
	fuzziness  = settings.vtb_thickness*0.30*180,
	draw_as_wire = false,
	default    = {4*mm_to_px,5*mm_to_px}, -- display increments, must be given in SVG px
	chars	   = {
		 {symbol['0'],  "vtb-font-0"},
		 {symbol['1'],  "vtb-font-1"},
		 {symbol['2'],  "vtb-font-2"},
		 {symbol['3'],  "vtb-font-3"},
		 {symbol['4'],  "vtb-font-4"},
		 {symbol['5'],  "vtb-font-5"},
		 {symbol['6'],  "vtb-font-6"},
		 {symbol['7'],  "vtb-font-7"},
		 {symbol['8'],  "vtb-font-8"},
		 {symbol['9'],  "vtb-font-9"},
		 {latin['A'],   "vtb-font-a"},
		 {latin['B'],   "vtb-font-b"},
		 {latin['C'],   "vtb-font-c"},
		 {latin['D'],   "vtb-font-d"},
		 {latin['E'],   "vtb-font-e"},
		 {latin['F'],   "vtb-font-f"},
		 {latin['G'],   "vtb-font-g"},
		 {latin['H'],   "vtb-font-h"},
		 {latin['I'],   "vtb-font-i"},
		 {latin['J'],   "vtb-font-j"},
		 {latin['K'],   "vtb-font-k"},
		 {latin['L'],   "vtb-font-l"},
		 {latin['M'],   "vtb-font-m"},
		 {latin['N'],   "vtb-font-n"},
		 {latin['O'],   "vtb-font-o"},
		 {latin['P'],   "vtb-font-p"},
		 {latin['Q'],   "vtb-font-q"},
		 {latin['R'],   "vtb-font-r"},
		 {latin['S'],   "vtb-font-s"},
		 {latin['T'],   "vtb-font-t"},
		 {latin['U'],   "vtb-font-u"},
		 {latin['V'],   "vtb-font-v"},
		 {latin['W'],   "vtb-font-w"},
		 {latin['X'],   "vtb-font-x"},
		 {latin['Y'],   "vtb-font-y"},
		 {latin['Z'],   "vtb-font-z"},
		 {symbol['*'],  "vtb-font-star"},
		 {symbol['.'],  "vtb-font-dot", 2*mm_to_px},
		 {symbol['-'],  "vtb-font-dash"},
		 {symbol['/'],  "vtb-font-slash"},
		 {latin['d'],	"vtb-font-delta"},
		 {latin['t'],	"vtb-font-theta"},
		 {latin['p'],	"vtb-font-rho"},
		 {symbol[':'],	"vtb-mach-dot"},
		 {14+0,  "vtb-contact-hl"},
		 {14+1,  "vtb-contact-hm"},
		 {14+2,  "vtb-contact-ht"},
		 {14+3,  "vtb-contact-cl"},
		 {14+4,  "vtb-contact-cm"},
		 {14+5,  "vtb-contact-ct"},
		 {14+6,  "vtb-contact-a"},
		 {14+7,  "vtb-jam-1"},
		 {14+8,  "vtb-jam-2"},
		 {14+9,  "vtb-jam-3"},
		 {14+10, "vtb-lock"},
		 {14+11, "vtb-lock-d"},
		 {14+12, "vtb-lock-a"},
		 {14+13, "vtb-contact-rem"},
		 {14+14, "vtb-do-rad"},
		 {14+15, "vtb-do-man"},
		 {14+16, "vtb-do-taf"},
		 {14+17, "vtb-do-tam"},
	}
}







fontdescription["VCM_font"] = {
	class			= "ceSLineFont",
	symb_storage	= "vcm",
	thickness		= settings.vcm_thickness*0.2*180,
	fuzziness		= settings.vcm_thickness*0.6*180,
	draw_as_wire	= false,
	default			= {2.8*mm_to_px,5*mm_to_px}, -- display increments, must be given in SVG px
	chars	   = {
		 {symbol['0'],  "vcm-font-0"},
		 {symbol['1'],  "vcm-font-1"},
		 {symbol['2'],  "vcm-font-2"},
		 {symbol['3'],  "vcm-font-3"},
		 {symbol['4'],  "vcm-font-4"},
		 {symbol['5'],  "vcm-font-5"},
		 {symbol['6'],  "vcm-font-6"},
		 {symbol['7'],  "vcm-font-7"},
		 {symbol['8'],  "vcm-font-8"},
		 {symbol['9'],  "vcm-font-9"},
		 {latin['A'],   "vcm-font-a"},
		 {latin['B'],   "vcm-font-b"},
		 {latin['C'],   "vcm-font-c"},
		 {latin['D'],   "vcm-font-d"},
		 {latin['E'],   "vcm-font-e"},
		 {latin['F'],   "vcm-font-f"},
		 {latin['G'],   "vcm-font-g"},
		 {latin['H'],   "vcm-font-h"},
		 {latin['I'],   "vcm-font-i"},
		 {latin['J'],   "vcm-font-j"},
		 {latin['K'],   "vcm-font-k"},
		 {latin['L'],   "vcm-font-l"},
		 {latin['M'],   "vcm-font-m"},
		 {latin['N'],   "vcm-font-n"},
		 {latin['O'],   "vcm-font-o"},
		 {latin['P'],   "vcm-font-p"},
		 {latin['Q'],   "vcm-font-q"},
		 {latin['R'],   "vcm-font-r"},
		 {latin['S'],   "vcm-font-s"},
		 {latin['T'],   "vcm-font-t"},
		 {latin['U'],   "vcm-font-u"},
		 {latin['V'],   "vcm-font-v"},
		 {latin['W'],   "vcm-font-w"},
		 {latin['X'],   "vcm-font-x"},
		 {latin['Y'],   "vcm-font-y"},
		 {latin['Z'],   "vcm-font-z"},
		 {symbol['*'],  "vcm-font-star"},
		 {symbol['+'],  "vcm-font-plus"},
		 {symbol['-'],  "vcm-font-minus"},
		 {symbol[';'],  "vcm-font-cir"},
		 {symbol['.'],  "vcm-font-dot"},
		 {symbol['='],  "vcm-font-arw"},
		 {symbol['?'],  "vcm-font-ivt"},
		 {symbol['>'],  "vcm-font-sqp"},
		 {symbol['<'],  "vcm-font-br3"},
		 {symbol['@'],  "vcm-font-ids"},
	}
}


fontdescription["THREATS_font"] = {
	class			= "ceSLineFont",
	symb_storage	= "vcm",
	thickness		= 3,
	fuzziness		= 4,
	draw_as_wire	= false,
	default			= {5*mm_to_px,5*mm_to_px}, -- display increments, must be given in SVG px
	chars	   		= fontdescription["VCM_font"].chars,
}




x_test = 136.0
y_test = 144.0
fontdescription["PCA_font"]  = {
	texture     = LockOn_Options.script_path.."Resources/IndicationTextures/font_PCA_M2KC.tga",
	size        = {7, 7},
	resolution  = {1024, 1024},
	default     = {symbol_pixels_x, symbol_pixels_y},
	chars	    = {
		 {32, x_test, y_test}, -- [space]
		 {42, x_test, y_test}, -- *
		 {43, x_test, y_test}, -- +
		 {45, x_test, y_test}, -- -
		 {46, x_test, y_test}, -- .
		 {47, x_test, y_test}, -- /
		 {48, x_test, y_test}, -- 0
		 {49, x_test, y_test}, -- 1
		 {50, x_test, y_test}, -- 2
		 {51, x_test, y_test}, -- 3
		 {52, x_test, y_test}, -- 4
		 {53, x_test, y_test}, -- 5
		 {54, x_test, y_test}, -- 6
		 {55, x_test, y_test}, -- 7
		 {56, x_test, y_test}, -- 8
		 {57, x_test, y_test}, -- 9
		 {58, x_test, y_test}, -- :
		 {65, x_test, y_test}, -- A
		 {66, x_test, y_test}, -- B
		 {67, x_test, y_test}, -- C
		 {68, x_test, y_test}, -- D
		 {69, x_test, y_test}, -- E
		 {70, x_test, y_test}, -- F
		 {71, x_test, y_test}, -- G
		 {72, x_test, y_test}, -- H
		 {73, x_test, y_test}, -- I
		 {74, x_test, y_test}, -- J
		 {75, x_test, y_test}, -- K
		 {76, x_test, y_test}, -- L
		 {77, x_test, y_test}, -- M
		 {78, x_test, y_test}, -- N
		 {79, x_test, y_test}, -- O
		 {80, x_test, y_test}, -- P
		 {81, x_test, y_test}, -- Q
		 {82, x_test, y_test}, -- R
		 {83, x_test, y_test}, -- S
		 {84, x_test, y_test}, -- T
		 {85, x_test, y_test}, -- U
		 {86, x_test, y_test}, -- V
		 {87, x_test, y_test}, -- W
		 {88, x_test, y_test}, -- X
		 {89, x_test, y_test}, -- Y
		 {90, x_test, y_test}, -- Z
		 {91, x_test, y_test}, -- [
		 {93, x_test, y_test}, -- ]
		 {62, x_test, y_test}, -- >
		 {111, x_test, y_test}, -- o
		 {94 ,  x_test, y_test}} -- ^
}

fontdescription["7SEG_FIL_font"]  = {
	texture     = LockOn_Options.script_path.."Resources/IndicationTextures/font_7_SEG_FIL_M2KC.tga",
	size        = {7, 7},
	resolution  = {1024, 1024},
	default     = {symbol_pixels_x, symbol_pixels_y},
	chars	    = {
		 {32, symbol_pixels_x, symbol_pixels_y}, -- [space]
		 {42, symbol_pixels_x, symbol_pixels_y}, -- *
		 {43, symbol_pixels_x, symbol_pixels_y}, -- +
		 {45, symbol_pixels_x, symbol_pixels_y}, -- -
		 {46, symbol_pixels_x, symbol_pixels_y}, -- .
		 {47, symbol_pixels_x, symbol_pixels_y}, -- /
		 {48, symbol_pixels_x, symbol_pixels_y}, -- 0
		 {49, symbol_pixels_x, symbol_pixels_y}, -- 1
		 {50, symbol_pixels_x, symbol_pixels_y}, -- 2
		 {51, symbol_pixels_x, symbol_pixels_y}, -- 3
		 {52, symbol_pixels_x, symbol_pixels_y}, -- 4
		 {53, symbol_pixels_x, symbol_pixels_y}, -- 5
		 {54, symbol_pixels_x, symbol_pixels_y}, -- 6
		 {55, symbol_pixels_x, symbol_pixels_y}, -- 7
		 {56, symbol_pixels_x, symbol_pixels_y}, -- 8
		 {57, symbol_pixels_x, symbol_pixels_y}, -- 9
		 {58, symbol_pixels_x, symbol_pixels_y}, -- :
		 {65, symbol_pixels_x, symbol_pixels_y}, -- A
		 {66, symbol_pixels_x, symbol_pixels_y}, -- B
		 {67, symbol_pixels_x, symbol_pixels_y}, -- C
		 {68, symbol_pixels_x, symbol_pixels_y}, -- D
		 {69, symbol_pixels_x, symbol_pixels_y}, -- E
		 {70, symbol_pixels_x, symbol_pixels_y}, -- F
		 {71, symbol_pixels_x, symbol_pixels_y}, -- G
		 {72, symbol_pixels_x, symbol_pixels_y}, -- H
		 {73, symbol_pixels_x, symbol_pixels_y}, -- I
		 {74, symbol_pixels_x, symbol_pixels_y}, -- J
		 {75, symbol_pixels_x, symbol_pixels_y}, -- K
		 {76, symbol_pixels_x, symbol_pixels_y}, -- L
		 {77, symbol_pixels_x, symbol_pixels_y}, -- M
		 {78, symbol_pixels_x, symbol_pixels_y}, -- N
		 {79, symbol_pixels_x, symbol_pixels_y}, -- O
		 {80, symbol_pixels_x, symbol_pixels_y}, -- P
		 {81, symbol_pixels_x, symbol_pixels_y}, -- Q
		 {82, symbol_pixels_x, symbol_pixels_y}, -- R
		 {83, symbol_pixels_x, symbol_pixels_y}, -- S
		 {84, symbol_pixels_x, symbol_pixels_y}, -- T
		 {85, symbol_pixels_x, symbol_pixels_y}, -- U
		 {86, symbol_pixels_x, symbol_pixels_y}, -- V
		 {87, symbol_pixels_x, symbol_pixels_y}, -- W
		 {88, symbol_pixels_x, symbol_pixels_y}, -- X
		 {89, symbol_pixels_x, symbol_pixels_y}, -- Y
		 {90, symbol_pixels_x, symbol_pixels_y}, -- Z
		 {91, symbol_pixels_x, symbol_pixels_y}, -- [
		 {93, symbol_pixels_x, symbol_pixels_y}, -- ]
		 {62, symbol_pixels_x, symbol_pixels_y}, -- >
		 {111, symbol_pixels_x, symbol_pixels_y}, -- o
		 {94 ,  symbol_pixels_x, symbol_pixels_y}} -- ^
}



fontdescription["MIP_font"]  = fontdescription_5mmbluegelpen

fontdescription["LCD_font"]  = {
	texture     = LockOn_Options.script_path.."Resources/IndicationTextures/font_LCD_M2KC.tga",
	size        = {4, 8},
	resolution  = {1024, 512},
	default     = {87.5, 126},
	chars	    = {
	 {48, 87.5, 126}, -- 0
	 {49, 87.5, 126}, -- 1
	 {50, 87.5, 126}, -- 2
	 {51, 87.5, 126}, -- 3
	 {52, 87.5, 126}, -- 4
	 {53, 87.5, 126}, -- 5
	 {54, 87.5, 126}, -- 6
	 {55, 87.5, 126}, -- 7
	 {56, 87.5, 126}, -- 8
	 {57, 87.5, 126}, -- 9
	 {69, 87.5, 126}, -- E
	 {78, 87.5, 126}, -- N
	 {87, 87.5, 126}, -- W
	 {83, 87.5, 126}, -- S
	 {43, 87.5, 126}, -- +
	 {45, 87.5, 126}, -- -
	 {46, 87.5, 126}, -- .
	 {32, 87.5, 126}, -- [space]
	 {38 ,87.5, 126}, -- Ampersand & placeholder for all segments on
	}
}


fontdescription["EVF_font"]  = {
	texture     = LockOn_Options.script_path.."Resources/IndicationTextures/font_EVF_M2KC.tga",
	size        = {4, 4},
	resolution  = {512, 512},
	default     = {80, 128},
	chars	    = {
	 {48, 80, 128}, -- 0
	 {49, 80, 128}, -- 1
	 {50, 80, 128}, -- 2
	 {51, 80, 128}, -- 3
	 {52, 80, 128}, -- 4
	 {53, 80, 128}, -- 5
	 {54, 80, 128}, -- 6
	 {55, 80, 128}, -- 7
	 {56, 80, 128}, -- 8
	 {57, 80, 128}, -- 9
	 {38, 80, 128}, -- Ampersand & placeholder for all segments on
	 {32, 80, 128} -- [space]
	}
}


fontdescription["RADIO_font"]  = {
	texture     = LockOn_Options.script_path.."Resources/IndicationTextures/font_GreenBoxRadio_M2KC.tga",
	size        = {7, 7},
	resolution  = {1024, 1024},
	default     = {symbol_pixels_x, symbol_pixels_y},
	chars	    = {
		 {32, 110, symbol_pixels_y}, -- [space]
		 {42, 110, symbol_pixels_y}, -- *
		 {43, 110, symbol_pixels_y}, -- +
		 {45, 110, symbol_pixels_y}, -- -
		 {46, 110, symbol_pixels_y}, -- .
		 {47, 110, symbol_pixels_y}, -- /
		 {48, 110, symbol_pixels_y}, -- 0
		 {49, 110, symbol_pixels_y}, -- 1
		 {50, 110, symbol_pixels_y}, -- 2
		 {51, 110, symbol_pixels_y}, -- 3
		 {52, 110, symbol_pixels_y}, -- 4
		 {53, 110, symbol_pixels_y}, -- 5
		 {54, 110, symbol_pixels_y}, -- 6
		 {55, 110, symbol_pixels_y}, -- 7
		 {56, 110, symbol_pixels_y}, -- 8
		 {57, 110, symbol_pixels_y}, -- 9
		 {58, 110, symbol_pixels_y}, -- :
		 {65, 110, symbol_pixels_y}, -- A
		 {66, 110, symbol_pixels_y}, -- B
		 {67, 110, symbol_pixels_y}, -- C
		 {68, 110, symbol_pixels_y}, -- D
		 {69, 110, symbol_pixels_y}, -- E
		 {70, 110, symbol_pixels_y}, -- F
		 {71, 110, symbol_pixels_y}, -- G
		 {72, 110, symbol_pixels_y}, -- H
		 {73, 110, symbol_pixels_y}, -- I
		 {74, 110, symbol_pixels_y}, -- J
		 {75, 110, symbol_pixels_y}, -- K
		 {76, 110, symbol_pixels_y}, -- L
		 {77, 110, symbol_pixels_y}, -- M
		 {78, 110, symbol_pixels_y}, -- N
		 {79, 110, symbol_pixels_y}, -- O
		 {80, 110, symbol_pixels_y}, -- P
		 {81, 110, symbol_pixels_y}, -- Q
		 {82, 110, symbol_pixels_y}, -- R
		 {83, 110, symbol_pixels_y}, -- S
		 {84, 110, symbol_pixels_y}, -- T
		 {85, 110, symbol_pixels_y}, -- U
		 {86, 110, symbol_pixels_y}, -- V
		 {87, 110, symbol_pixels_y}, -- W
		 {88, 110, symbol_pixels_y}, -- X
		 {89, 110, symbol_pixels_y}, -- Y
		 {90, 110, symbol_pixels_y}, -- Z
		 {91, 110, symbol_pixels_y}, -- [
		 {93, 110, symbol_pixels_y}, -- ]
		 {62, 110, symbol_pixels_y}, -- >
		 {111,110, symbol_pixels_y}, -- o
		 {94 ,110, symbol_pixels_y}  -- ^
	}
}

fontdescription["FUEL_font"] = {
	texture     = "Mods/aircraft/M-2000C/Cockpit/Resources/IndicationTextures/font_7_SEG_FIL_M2KC.tga",
	size        = {7, 7},
	resolution  = {1024, 1024},
	default     = {100.0, 144.0},
	chars	    = {
		 {32,	100.0, 144.0}, -- [space]
		 {42,	100.0, 144.0}, -- *
		 {43,	100.0, 144.0}, -- +
		 {45,	100.0, 144.0}, -- -
		 {46,	100.0, 144.0}, -- .
		 {47,	100.0, 144.0}, -- /
		 {48,	100.0, 144.0}, -- 0
		 {49,	100.0, 144.0}, -- 1
		 {50,	100.0, 144.0}, -- 2
		 {51,	100.0, 144.0}, -- 3
		 {52,	100.0, 144.0}, -- 4
		 {53,	100.0, 144.0}, -- 5
		 {54,	100.0, 144.0}, -- 6
		 {55,	100.0, 144.0}, -- 7
		 {56,	100.0, 144.0}, -- 8
		 {57,	100.0, 144.0}, -- 9
		 {58,	100.0, 144.0}, -- :
		 {65,	100.0, 144.0}, -- A
		 {66,	100.0, 144.0}, -- B
		 {67,	100.0, 144.0}, -- C
		 {68,	100.0, 144.0}, -- D
		 {69,	100.0, 144.0}, -- E
		 {70,	100.0, 144.0}, -- F
		 {71,	100.0, 144.0}, -- G
		 {72,	100.0, 144.0}, -- H
		 {73,	100.0, 144.0}, -- I
		 {74,	100.0, 144.0}, -- J
		 {75,	100.0, 144.0}, -- K
		 {76,	100.0, 144.0}, -- L
		 {77,	100.0, 144.0}, -- M
		 {78,	100.0, 144.0}, -- N
		 {79,	100.0, 144.0}, -- O
		 {80,	100.0, 144.0}, -- P
		 {81,	100.0, 144.0}, -- Q
		 {82,	100.0, 144.0}, -- R
		 {83,	100.0, 144.0}, -- S
		 {84,	100.0, 144.0}, -- T
		 {85,	100.0, 144.0}, -- U
		 {86,	100.0, 144.0}, -- V
		 {87,	100.0, 144.0}, -- W
		 {88,	100.0, 144.0}, -- X
		 {89,	100.0, 144.0}, -- Y
		 {90,	100.0, 144.0}, -- Z
		 {91,	100.0, 144.0}, -- [
		 {93,	100.0, 144.0}, -- ]
		 {62,	100.0, 144.0}, -- >
		 {111,	100.0, 144.0}, -- o
		 {94 ,	100.0, 144.0}} -- ^
}

fontdescription["kneeboard_font"] = fontdescription["font_general_loc"]

fonts = {}
fonts["font_general_keys"]			= {fontdescription["kneeboard_font"], 10, {255,75,75,255}}
fonts["font_hints_kneeboard"]		= {fontdescription["kneeboard_font"], 10, {64,64,96,255}}

-- VTH
fonts["vth_green"]					= {fontdescription["VTH_font"], 10, materials["VTH_GREEN"]}
fonts["vth_red"]					= {fontdescription["VTH_font"], 10, materials["DBG_RED"]}

-- VTB
fonts["vtb_cav"]					= {fontdescription["VTB_font"], 10, materials["VTB_GREEN"] }
fonts["vtb_mrq"]					= {fontdescription["VTB_font"], 10, materials["VTB_GREEN"]}
fonts["vtb_vid"]					= {fontdescription["VTB_font"], 10, materials["VTB_GREEN"]   }

-- PCA/PPA
fonts["pca_gauge_font"]				= {fontdescription["PCA_font"], 10, materials["PCA_GREEN"]}
fonts["PPA_gauge_font"]				= {fontdescription["7SEG_FIL_font"], 10, materials["PCA_GREEN"]}

-- PCN
fonts["pcn_gauge_font"]				= {fontdescription["LCD_font"], 10, materials["GREENBOX_GREEN"]}

-- EVF
fonts["evf_lcd_font"]				= {fontdescription["EVF_font"], 10, materials["GREENBOX_GREEN"]}

-- MIP
fonts["mip_label_font"]				= {fontdescription["MIP_font"], 10, {0,0,48,255}}

-- SERVAL
fonts["font_threats_kneeboard"]		= {fontdescription["THREATS_font"], 10, {255,200,190,255}}
fonts["vcm_green"]					= {fontdescription["VCM_font"], 10, materials["VCM_GREEN"]}

-- RADIO
fonts["COM_gauge_font"]				= {fontdescription["RADIO_font"], 10, materials["5X7_GREEN"]}
fonts["COM_greenbox_font"]			= {fontdescription["RADIO_font"], 10, materials["5X7_GREEN"]}

-- FUEL
fonts["fuel_gauge_font"]			= {fontdescription["FUEL_font"], 10, materials["PCA_GREEN"]}
