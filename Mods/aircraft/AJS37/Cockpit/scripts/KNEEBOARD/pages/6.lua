--e_referencepoints
dofile(LockOn_Options.common_script_path.."KNEEBOARD/indicator/definitions.lua")
dofile(LockOn_Options.script_path.."fonts.lua")
SetScale(FOV)

dx  = 50/512
add_picture(LockOn_Options.script_path.."KNEEBOARD/pages/backgrounds/viggen_notepad.bmp",
				0,
				0,
				2,
				2*GetAspect(),
				dx,
				0,
				1 - 2*dx,
				1)

				
DEFAULT_LEVEL 		 = 16
DEFAULT_TEXTURE_SIZE = 512

local kneeboard_font   = MakeFont(fontdescription["font_kneeboard"], materials["BLACK"], "FONT_")

local default_char_height  = 0.005
local default_char_width   = 0.54 * default_char_height

local txt 	    					= CreateElement "ceStringPoly"
	txt.material 					= kneeboard_font
	txt.name 						= "kneeboardradiotxt"
	txt.formats         			= {"%s","%s"}
	txt.stringdefs					= {default_char_height*1.0, default_char_width*1.0,0,0}
	txt.init_pos					= {0.10 - 1,GetAspect() - 0.1}
	txt.alignment					= "LeftTop"
	txt.use_mipfilter				= true
	txt.h_clip_relation   			= h_clip_relations.COMPARE
	txt.level 		    			= DEFAULT_LEVEL
	txt.controllers 				= {{"kneeboardreftext",0}}
	txt.element_params  = {0}
	Add(txt)