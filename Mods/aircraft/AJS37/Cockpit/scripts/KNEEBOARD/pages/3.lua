--c_radios
dofile(LockOn_Options.common_script_path.."KNEEBOARD/indicator/definitions.lua")
dofile(LockOn_Options.script_path.."fonts.lua")
SetScale(FOV)
--[[
sample page,
some agreements used in this file:
+-----+-----+
|	  |		|
|	  |		|
|	  |		|
|	  |		|
+-----+-----+
|	  |		|
|	  |		|
|	  |		|
|	  |		|
+-----+-----+

full page width  : 2
full page height : full_page_width * GetAspect()
center of page : 0,0
Upper left  corner : -1 , GetAspect()
Upper right corner :  1 , GetAspect()
Lower left  corner : -1 ,-GetAspect()
Lower right corner :  1 ,-GetAspect()

some basic functions  

add_picture (image_name,
			 UL_X, -- coordinates of UL corner of image from UL corner of page
			 UL_Y, -- coordinates of UL corner of image from UL corner of page
			 W,	   -- width
			 H,	   -- height
			 tx_ULX, -- texture coordinates (optional)
			 tx_ULY,-- texture coordinates(optional)
			 tx_W,	-- texture coordinates(optional)
			 tx_H)  -- texture coordinates(optional)
			 
			 
add_picture("pilot_KA50_notepad",
			 0,
			 0,
			 2,
			 2*GetAspect(),
			 0,
			 0,
			 1,
			 1)			 
will create full coverage of page by pilot_KA50_notepad texture

add_text(text,
		 UL_X, -- coordinates of UL corner of image from UL corner of page
	     UL_Y  -- coordinates of UL corner of image from UL corner of page 
		 )
text can include tab symbols and new line symbols

Picture example:
add_picture("Scripts\Aircrafts\_Common\Cockpit\KNEEBOARD\indicator\CUSTOM\picture_name")


--]]
dx  = 50/512
add_picture(LockOn_Options.script_path.."KNEEBOARD/pages/backgrounds//viggen_notepad.bmp",
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
local default_char_width   = 0.5517 * default_char_height

local txt 	    					= CreateElement "ceStringPoly"
	  txt.material 					= kneeboard_font
	  txt.name 						= "kneeboardradiotxt"
	  txt.formats         			= {"%s","%s"}
	  txt.stringdefs				= {default_char_height*1.0, default_char_width*1.0,0,0}
	  txt.init_pos					= {0.10 - 1,GetAspect() - 0.1}
	  txt.alignment					= "LeftTop"
	  txt.use_mipfilter				= true
	  txt.h_clip_relation   		= h_clip_relations.COMPARE
	  txt.level 		    		= DEFAULT_LEVEL	
	  txt.controllers 				= {{"kneeboardradiotxt",0}}
	  Add(txt)