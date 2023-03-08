--b_waypoints
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
add_picture(LockOn_Options.script_path.."KNEEBOARD/pages/backgrounds/Waypoint2.bmp",
		0,
		0,
		1.9,
		1.9*GetAspect())

DEFAULT_LEVEL 		 = 16
DEFAULT_TEXTURE_SIZE = 512

local default_char_height  = 0.005
local default_char_width   = 0.5517 * default_char_height

local kneeboard_font   = MakeFont(fontdescription["font_kneeboard"], materials["BLACK"], "FONT_")

local box_spacing_x = 0.44
local box_spacing_y = 0.1

local offset_x = -0.92

local column = 1
local row = 1

-- NOTE: arg[0] represents waypoint page number, arg[1] represents page section, arg[2] represents individual field ID within that section
local waypoint_spacing_y = -0.408
local waypoint_offset_y = -0.072

for waypoint = 1, 6 do
	column = 1
	row = 1

	waypoint_title 					= CreateElement "ceStringPoly"
	waypoint_title.name 			= "waypoint_number"..waypoint
	waypoint_title.material 		= kneeboard_font
	waypoint_title.formats         	= {"%s","%s"}
	waypoint_title.stringdefs		= {default_char_height*1.0, default_char_width*1.0,0,0}
	waypoint_title.init_pos 		= {offset_x + (column - 1)*box_spacing_x,(GetAspect()+ waypoint_offset_y - (row - 1)*box_spacing_y) + waypoint_spacing_y*(waypoint-1)}
	waypoint_title.alignment		= "LeftTop"
	waypoint_title.use_mipfilter	= true
	waypoint_title.h_clip_relation  = h_clip_relations.COMPARE
	waypoint_title.level 		    = DEFAULT_LEVEL
	waypoint_title.controllers 		= {{"kneeboardtxt",1, 0, 1 + ((waypoint-1) * 13)}}
	Add(waypoint_title)

	row = 2

	for field = (2+ ((waypoint-1) * 13)), (13 + ((waypoint-1) * 13)) do
		waypoint_field 					= CreateElement "ceStringPoly"
		waypoint_field.name 			= "waypoint_field"..field
		waypoint_field.material 		= kneeboard_font
		waypoint_field.formats         	= {"%s","%s"}
		waypoint_field.stringdefs		= {default_char_height*1.0, default_char_width*1.0,0,0}
		waypoint_field.init_pos 		= {offset_x + (column - 1)*box_spacing_x,(GetAspect()+ waypoint_offset_y - (row - 1)*box_spacing_y) + waypoint_spacing_y*(waypoint-1)}
		waypoint_field.alignment		= "LeftTop"
		waypoint_field.use_mipfilter	= true
		waypoint_field.h_clip_relation  = h_clip_relations.COMPARE
		waypoint_field.level 		    = DEFAULT_LEVEL
		waypoint_field.controllers 		= {{"kneeboardtxt",1, 0, field}}
		Add(waypoint_field)

		column = column + 1

		if math.fmod(field - waypoint, 4) == 0 then
			column = 1
			row = row + 1
		end
	end
end