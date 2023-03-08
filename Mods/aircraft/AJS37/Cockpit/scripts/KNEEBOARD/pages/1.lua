--a_waypoints
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
add_picture(LockOn_Options.script_path.."KNEEBOARD/pages/backgrounds/Waypoint1.bmp",
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
local offset_y = -0.072

local column = 1
local row = 1

-- Firstly, the start point:
starting_point 					= CreateElement "ceStringPoly"
starting_point.name 			= "starting_point"
starting_point.material 		= kneeboard_font
starting_point.formats         	= {"%s","%s"}
starting_point.stringdefs		= {default_char_height*1.0, default_char_width*1.0,0,0}
starting_point.init_pos 		= {offset_x + (0)*box_spacing_x,GetAspect()+ offset_y - (0)*box_spacing_y}
starting_point.alignment		= "LeftTop"
starting_point.use_mipfilter	= true
starting_point.h_clip_relation  = h_clip_relations.COMPARE
starting_point.level 		    = DEFAULT_LEVEL
starting_point.controllers 		= {{"kneeboardtxt",0, 0, 1}}
Add(starting_point)

-- Now mission ID:
mission_id 					= CreateElement "ceStringPoly"
mission_id.name 			= "mission_id"
mission_id.material 		= kneeboard_font
mission_id.formats         	= {"%s","%s"}
mission_id.stringdefs		= {default_char_height*1.0, default_char_width*1.0,0,0}
mission_id.init_pos 		= {offset_x + (0)*box_spacing_x,GetAspect()+ offset_y - (1)*box_spacing_y}
mission_id.alignment		= "LeftTop"
mission_id.use_mipfilter	= true
mission_id.h_clip_relation  = h_clip_relations.COMPARE
mission_id.level 		    = DEFAULT_LEVEL
mission_id.controllers 		= {{"kneeboardtxt",0, 0, 2}}
Add(mission_id)

-- Callsign:
callsign 					= CreateElement "ceStringPoly"
callsign.name 				= "callsign"
callsign.material 			= kneeboard_font
callsign.formats         	= {"%s","%s"}
callsign.stringdefs			= {default_char_height*1.0, default_char_width*1.0,0,0}
callsign.init_pos 			= {offset_x + (2)*box_spacing_x,GetAspect()+ offset_y - (1)*box_spacing_y}
callsign.alignment			= "LeftTop"
callsign.use_mipfilter		= true
callsign.h_clip_relation  	= h_clip_relations.COMPARE
callsign.level 		    	= DEFAULT_LEVEL
callsign.controllers 		= {{"kneeboardtxt",0, 0, 3}}
Add(callsign)

-- NOTE: arg[0] represents waypoint page number, arg[1] represents page section, arg[2] represents individual field ID within that section
row = 3

for field = 4,15 do
	waypoint_field 					= CreateElement "ceStringPoly"
	waypoint_field.name 			= "waypoint_field"..field
	waypoint_field.material 		= kneeboard_font
	waypoint_field.formats         	= {"%s","%s"}
	waypoint_field.stringdefs		= {default_char_height*1.0, default_char_width*1.0,0,0}
	waypoint_field.init_pos 		= {offset_x + (column - 1)*box_spacing_x,GetAspect()+ offset_y - (row - 1)*box_spacing_y}
	waypoint_field.alignment		= "LeftTop"
	waypoint_field.use_mipfilter	= true
	waypoint_field.h_clip_relation  = h_clip_relations.COMPARE
	waypoint_field.level 		    = DEFAULT_LEVEL
	waypoint_field.controllers 		= {{"kneeboardtxt",0, 0, field}}
	Add(waypoint_field)

	column = column + 1

	if math.fmod(field - 3, 4) == 0 then
		column = 1
		row = row + 1
	end
end

local waypoint_spacing_y = -0.413
local waypoint_offset_y = -0.578---0.38

for waypoint = 1, 5 do
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
	waypoint_title.controllers 		= {{"kneeboardtxt",0, 1, 16 + ((waypoint-1) * 13)}}
	Add(waypoint_title)

	row = 2

	for field = (17+ ((waypoint-1) * 13)), (28 + ((waypoint-1) * 13)) do
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
		waypoint_field.controllers 		= {{"kneeboardtxt",0, 1, field}}
		Add(waypoint_field)

		column = column + 1

		if math.fmod(field - waypoint - 3, 4) == 0 then
			column = 1
			row = row + 1
		end
	end
end
