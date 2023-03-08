dofile(LockOn_Options.common_script_path.."elements_defs.lua")
DEFAULT_LEVEL 		 = 16
DEFAULT_TEXTURE_SIZE = 512


MARK_COLOR  = {100,0,170,255}

FONT_PROTO  = {class  = "ceUITTF",  ttf = "PTM75F.ttf" , size = 20}

local FONT_   = MakeFont(FONT_PROTO,{0,0,0,255})
FONT_NOTE  	= MakeFont({class  = "ceUITTF",  ttf = "PTM55F.ttf" , size = 20},{0,0,0,255})
local TST_  = MakeMaterial(nil,{255,0,0,255})

local default_char_height     = 0.006
local default_char_width      = 0.75 * default_char_height

default_font_defs  =  {default_char_height,default_char_width,0,0}

function add_text(text,UL_X,UL_Y)

local UL_X = UL_X or 0
local UL_Y = UL_Y or 0

local txt 	    					= CreateElement "ceStringPoly"
	  txt.value 					= text
	  txt.material 					= FONT_
	  txt.stringdefs				= default_font_defs
	  txt.init_pos					= {UL_X - 1,GetAspect() - UL_Y}
	  txt.alignment					= "LeftTop"
	  txt.use_mipfilter				= true
	  txt.h_clip_relation   		= h_clip_relations.COMPARE
	  txt.level 		    		= DEFAULT_LEVEL	
	  Add(txt)
end



function texture_box_(UL_X,UL_Y,W,H)
	local UL_X = UL_X or 0
	local UL_Y = UL_Y or 0
	local W    = W    or 1
	local H    = H    or 1
	return  {{UL_X	   , UL_Y},
			{(UL_X + W), UL_Y},
			{(UL_X + W),(UL_Y + H)},
			{ UL_X     ,(UL_Y + H)}}
end

function add_picture(picture,UL_X,UL_Y,W,H,tx_ULX,tx_ULY,tx_W,tx_H)
local USER_PICTURE  = MakeMaterial(picture,{255,255,255,255})

local width 		= W
local height		= H

if width == nil then
   width = 2
end

if height == nil then
   height =  2*GetAspect()
end
local UL_X  = UL_X or 0
local UL_Y  = UL_Y or 0

local back   	    = CreateElement "ceTexPoly"
back.material 	    =  USER_PICTURE
back.init_pos   	= {UL_X - 1,GetAspect() - UL_Y}
back.vertices   	 = {{0	 ,0},
					    {width   ,0},
					    {width   ,-height},
					    {0       ,-height}}
back.indices	  = {0,1,2;0,2,3}
back.tex_coords   = texture_box_(tx_ULX,tx_ULY,tx_W,tx_H)
back.h_clip_relation   		= h_clip_relations.COMPARE
back.level 		    		= DEFAULT_LEVEL	
Add(back)

return back

end