dofile(LockOn_Options.common_script_path.."Fonts/symbols_locale.lua")
dofile(LockOn_Options.common_script_path.."Fonts/fonts_cmn.lua")

fontdescription = {}

local SightSysTexturesPath = LockOn_Options.script_path.."../../Mirage-F1/Mirage-F1_Common/Resources/IndicationTextures/SightSystem/"

local SightSys_xsize 		= 84
local SightSys_ysize 		= 128
fontdescription["FONT_SIGHT_SYSTEM"] = {
	--texture    	= SightSysTexturesPath.."FONT_F1_SightSystem.tga",
	texture    		= SightSysTexturesPath.."FONT_F1_SightSystem.dds",
	size      		= {4, 4},
	resolution 		= {512, 512},
	default    		= {SightSys_xsize, SightSys_ysize},
	chars	     	= {
	   [1]   = {32, SightSys_xsize, SightSys_ysize}, -- [space]
	   [2]   = {48, SightSys_xsize, SightSys_ysize}, -- 0
	   [3]   = {49, SightSys_xsize, SightSys_ysize}, -- 1 (left edge aligned '1')
	   [4]   = {50, SightSys_xsize, SightSys_ysize}, -- 2
	   [5]   = {51, SightSys_xsize, SightSys_ysize}, -- 3
	   [6]   = {52, SightSys_xsize, SightSys_ysize}, -- 4
	   [7]   = {53, SightSys_xsize, SightSys_ysize}, -- 5
	   [8]   = {54, SightSys_xsize, SightSys_ysize}, -- 6
	   [9]   = {55, SightSys_xsize, SightSys_ysize}, -- 7
	   [10]  = {56, SightSys_xsize, SightSys_ysize}, -- 8
	   [11]  = {57, SightSys_xsize, SightSys_ysize}, -- 9
	   [12]  = {73, SightSys_xsize, SightSys_ysize}, -- I (right edge aligned '1')
	   [13]  = {79, SightSys_xsize, SightSys_ysize}, -- O ('0' with large gaps)
	   [14]  = {71, SightSys_xsize, SightSys_ysize}, -- G ('6' with large gaps)
	   [15]  = {66, SightSys_xsize, SightSys_ysize}, -- B ('8' with large gaps)
	   [16]  = {74, SightSys_xsize, SightSys_ysize}, -- J ('9' with large gaps)
	}
}
