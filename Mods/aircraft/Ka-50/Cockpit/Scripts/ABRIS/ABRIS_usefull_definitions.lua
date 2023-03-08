dofile(LockOn_Options.common_script_path.."elements_defs.lua")

dofile(LockOn_Options.script_path.."ABRIS\\ABRIS_localizer.lua")
SetScale(FOV) -- set scale factor modifier (in this case FOV - half of horizontal size)

DEFAULT_LEVEL   = 4

mip_filter_used = true
-----------------------------
drawall        = true
-----------------------------
box_ind        = {0, 1, 2, 0, 2, 3}
-----------------------------
x_size         = 1 --0.98
y_size         = GetAspect()
up_line_pos    = {0,y_size - 0.1,0}
y_pos_delta    =  0.1 --0.08*y_size  
menu_pos_y	   =  -y_size + 0.065
frame_start_y  = 23/1024
frame_end_y    = 754/1024
frame_start_x  = 17/1024
frame_end_x    = 582/1024
tex_scale      = (frame_end_y - frame_start_y)/(2*y_size)
frame_center_x = frame_start_x + (frame_end_x - frame_start_x)*0.5
frame_center_y = frame_start_y + (frame_end_y - frame_start_y)*0.5
---------------------------------------
abris_font      = {}
abris_font[1]   = {0.007, 0.67*0.007,0.0005,0}
abris_font[2]   = {0.007, 0.67*0.007,0.0005,0}
abris_font[3]	= {0.0055,0.005,0.0005,0}

abris_font[4]   = {0.005, 0.67*0.005,0.0005,0.003}
abris_font[5]   = {0.005, 0.8*0.005,0.0008,0.001}
abris_font[6]   = {0.007, 0.67*0.007,0.0005,0.001}
abris_font[7]   = {0.0045,0.67*0.0045,0.0005,0}
abris_font[8]	= {0.0055,0.8*0.005,0.0005,0}


size_mrk 		= (abris_font[5][1] + abris_font[5][4])/GetScale()

---------------------------------------	

render_start    = 55/1024
render_end      = 497/1024
y_center_render = y_size - (render_start - frame_start_y + (render_end - render_start)*0.5)/tex_scale
y_render_size   = (render_end - render_start)*0.5/tex_scale

course_wnd_x_start =  (224/1024 - frame_center_x)/(tex_scale)
course_wnd_x_end   =  (376/1024 - frame_center_x)/(tex_scale)
course_wnd_y_end   =   (frame_center_y - 81/1024)/(tex_scale) - y_center_render

scale_start_x      = 0.6*x_size -- (504/1024 - frame_center_x)/(tex_scale)
scale_start_y      =  (frame_center_y - 474/1024)/(tex_scale) - y_center_render

start_x_2  = 9/512
end_x_2  = 431/512

scale_2    =  (end_x_2 - start_x_2)/(2*x_size)
x_center_2 =   start_x_2  + (end_x_2 - start_x_2)/2

centers_y = {}
sizes_y   = {}
sizes_y[1] = (419 - 398)/1024
sizes_y[2] = (441 - 420)/1024
sizes_y[3] = (508 - 468)/1024
centers_y[1] = (398  + (419 - 398)/2)/512
centers_y[2] = (420  + (441 - 422)/2)/512
centers_y[3] = (468  + (508 - 468)/2)/512

button_border_size      = (467 - 444)/512
button_border_down_edge =  444/512  + button_border_size

size_vnav_x        = (485 - 445)/1024
center_vnav_x      = 445/512 + size_vnav_x 
size_vnav_y        = (506 - 396)/512
down_border_vnav_y = 506 / 512 

plane_size_x   = (504 - 486)/1024
plane_size_y   = (421 - 398)/1024
plane_center_x = 486/512 + plane_size_x
plane_center_y = 398/512 + plane_size_y 

cursor_size     =(507 - 497)/512
cursor_center_x = 497/512
cursor_center_y = 483/512 

cursor_size_box     = 16/512
cursor_center_x_box = 296/512
cursor_center_y_box = 33/512 

scale_cur_box = 2*scale_2


vnav_cue_x_size   = (509 - 488)/1024
vnav_cue_y_size   = (454 - 448)/1024
vnav_cue_center_x = 488/512  + vnav_cue_x_size 
vnav_cue_center_y = 448/512 + vnav_cue_y_size


--SNR rows
SNR_X0 = -0.8 * x_size
SNR_Y0 = -0.54 * y_size
SNR_X_length = 1.7 * x_size
SNR_Y_height = 0.26 * y_size
SNR_row_width = (1 / 12 - 0.01) * x_size
SNR_row_hor_interval = (1 / 12) * x_size
SNR_row_height = 0.26 * y_size
--SKY SHPERE
horizon_center_X = 0.55 * x_size
horizon_center_Y = 0.3 * y_size
horizon_size_X = 0.4 * x_size
horizon_size_Y = 0.4 * x_size
--GPS/GNSS mark size
scale_satellite = 1.75*scale_2
satellite_mark_size = 0.05 * x_size
--GPS marks
gps_satellite_size_x   = (210 - 180)/1024
gps_satellite_size_y   = (48 - 18)/1024
gps_satellite_center_x = 180/512 + gps_satellite_size_x
gps_satellite_center_y = 18/512 + gps_satellite_size_y 
--GNSS marks
gnss_satellite_size_x   = (180 - 148)/1024
gnss_satellite_size_y   = (96 - 65)/1024
gnss_satellite_center_x = 148/512 + gnss_satellite_size_x
gnss_satellite_center_y = 65/512 + gnss_satellite_size_y 
--climb_dive_point mark
climb_dive_point_size_x   = (33 - 3)/1024
climb_dive_point_size_y   = (48 - 18)/1024
climb_dive_point_center_x = 3/512 + climb_dive_point_size_x
climb_dive_point_center_y = 18/512 + climb_dive_point_size_y 
climb_dive_point_scale = scale_satellite


new_delta 					  = (2*y_size -  3*y_pos_delta - 2*y_render_size)/10
new_delta_2					  = (2*y_size -  3*y_pos_delta)/29
new_delta_3 				  =  0.7 * new_delta_2
new_delta_4					  = (2*y_size -  2*y_pos_delta - 2*y_render_size)/14

function use_mipfilter(object)
if mip_filter_used then
	object.use_mipfilter = true
end
end


function level_reverter(level,vertices,indices)
	local 	obj 				= CreateElement "ceMeshPoly"
			obj.primitivetype   = "triangles"
			obj.material		= "RED"
			obj.h_clip_relation = h_clip_relations.REWRITE_LEVEL
			obj.vertices 		= vertices
			obj.indices         = indices
			obj.level		    = DEFAULT_LEVEL + level
			obj.isdraw		    = true
			obj.isvisible	    = false
	return  obj
end

function SetLine(object)
	local centers_line  = (385  + (388 - 385)/2)/512
	local size_line     = (388 - 385)/1024
	local line_vertices = {{-x_size,  size_line/scale_2},
						{ x_size,  size_line/scale_2},
						{ x_size, -size_line/scale_2},
						{-x_size, -size_line/scale_2}}
	object.indices		= box_ind
	object.vertices     = line_vertices
	object.material     = "INDICATION_ABRIS_WHITE"
	object.tex_params   = {x_center_2,centers_line,scale_2,scale_2}
	use_mipfilter(object)
end

function SetLineSized(object,x_line_start,x_line_end)
	local centers_line  = (385  + (388 - 385)/2)/512
	local size_line     = (388 - 385)/1024
	local line_vertices = {{x_line_start,  size_line/scale_2},
						{   x_line_end,  size_line/scale_2},
						{   x_line_end, -size_line/scale_2},
						{   x_line_start, -size_line/scale_2}}
	object.indices		= box_ind
	object.vertices     = line_vertices
	object.material     = "INDICATION_ABRIS_WHITE"
	object.tex_params   = {x_center_2,centers_line,scale_2,scale_2}
	use_mipfilter(object)
end 

function AddButtons(button1,button2,button3,button4,button5)
	local txt_menu = {}
	for i = 1,5 do
		txt_menu[i]				= CreateElement "ceStringPoly"
		txt_menu[i].material    = "font_Ka-50_ABRIS_WHITE"  
		txt_menu[i].alignment   = "CenterCenter"
		txt_menu[i].stringdefs  = abris_font[1]
		txt_menu[i].init_pos    = {x_size*(-0.8 + 0.4 * (i - 1)), menu_pos_y, 0}
	end
	------------------
	txt_menu[1].name   = "button1"
	txt_menu[2].name   = "button2"
	txt_menu[3].name   = "button3"
	txt_menu[4].name   = "button4"
	txt_menu[5].name   = "button5"

	txt_menu[1].value  = LOCALIZE(button1)
	txt_menu[2].value  = LOCALIZE(button2)
	txt_menu[3].value  = LOCALIZE(button3)
	txt_menu[4].value  = LOCALIZE(button4)
	txt_menu[5].value  = LOCALIZE(button5)
	------------------
	for i = 1,5 do
		Add(txt_menu[i])
		use_mipfilter(txt_menu[i])
	end
	button_border          = CreateElement "ceTexPoly"
	button_border.name     = "button_border"
	button_border.vertices =   {{-x_size, button_border_size/scale_2},
								{ x_size, button_border_size/scale_2},
								{ x_size, 0},
								{-x_size, 0}}
	button_border.indices    = box_ind
	button_border.material   = "INDICATION_ABRIS_WHITE"
	button_border.tex_params = {x_center_2,button_border_down_edge,scale_2,scale_2}
	button_border.init_pos   = {0,-y_size,0}
	Add(button_border)
	
	use_mipfilter(button_border)
end

function AddSignalsBorder()
local   signals_border          = CreateElement "ceTexPoly"
		signals_border.name     = "signals_border"
		signals_border.vertices =   {{-x_size,button_border_size/scale_2},
									 { x_size,button_border_size/scale_2},
									 { x_size, 0},
									 {-x_size, 0}}
		signals_border.indices    = box_ind
		signals_border.material   = "INDICATION_ABRIS_WHITE"
		signals_border.tex_params = {x_center_2,button_border_down_edge - button_border_size,scale_2,scale_2}
		signals_border.init_pos   = {0,-y_size + button_border_size/scale_2,0}
		Add(signals_border)
		use_mipfilter(signals_border)
		
local   txt_message			   	    = CreateElement "ceStringPoly"
		txt_message.name            = "txt_message"
		txt_message.material        = "font_Ka-50_ABRIS_GREEN"
		txt_message.init_pos		= {-0.98*x_size,0.01*y_size,0}
		txt_message.formats         = {"%s"}
		txt_message.alignment       = "LeftBottom"
		txt_message.stringdefs      = abris_font[2]
	--	txt_message.value           = "ШУРИК ДУРАК!"
		txt_message.controllers     = {{"top_message",0}}
		txt_message.parent_element  = signals_border.name
		Add(txt_message)
		use_mipfilter(txt_message)
end

function AddScaleTxt(name)
local	txt_scale             = CreateElement "ceStringPoly"
		txt_scale.name        =  name
		txt_scale.material    = "font_Ka-50_ABRIS_WHITE"
		txt_scale.alignment   = "RightCenter"
		txt_scale.stringdefs  = abris_font[4] 
		txt_scale.init_pos    = {x_size,-0.26*y_size,0}
		txt_scale.formats     = {"1:%3.2f"..LOCALIZE("км")}
		txt_scale.controllers = {{"txt_scale",0,1/(1000 * 100)}}
		Add(txt_scale)
		use_mipfilter(txt_scale)
end

function AddMode(mode)
local   txt_menu_mode			   	  = CreateElement "ceStringPoly"
		txt_menu_mode.name            = "txt_menu_mode"
		txt_menu_mode.material        = "font_Ka-50_ABRIS_GREEN"
		txt_menu_mode.init_pos		  = {-0.98*x_size,0.97*y_size,0}
		txt_menu_mode.value           = LOCALIZE(mode)
		txt_menu_mode.alignment       = "LeftCenter"
		txt_menu_mode.stringdefs      = abris_font[2]
		Add(txt_menu_mode)
		use_mipfilter(txt_menu_mode)
end
function AddSubMode(mode)
local txt_menu_submode			   	  = CreateElement "ceStringPoly"
	txt_menu_submode.name            = "txt_menu_submode"
	txt_menu_submode.material        = "font_Ka-50_ABRIS_GREEN"
	txt_menu_submode.init_pos		  = {-0.98*x_size,0.97*y_size - (y_size - up_line_pos[2]),0}
	txt_menu_submode.value           = LOCALIZE(mode)
	txt_menu_submode.alignment       = "LeftCenter"
	txt_menu_submode.stringdefs      = abris_font[2]
	Add(txt_menu_submode)
	use_mipfilter(txt_menu_submode)
end
function AddSubModeControllers(formats,controllers)
local txt_menu_submode			   	 = CreateElement "ceStringPoly"
	txt_menu_submode.name            = "txt_menu_submode"
	txt_menu_submode.material        = "font_Ka-50_ABRIS_GREEN"
	txt_menu_submode.init_pos		  = {-0.98*x_size,0.97*y_size - (y_size - up_line_pos[2]),0}
	txt_menu_submode.formats         = formats
	txt_menu_submode.controllers	 = controllers
	txt_menu_submode.alignment       = "LeftCenter"
	txt_menu_submode.stringdefs      = abris_font[2]
	Add(txt_menu_submode)
	use_mipfilter(txt_menu_submode)
end
function SetDefaultClipWithLevel(object,level)
	object.h_clip_relation = h_clip_relations.COMPARE
	object.level = DEFAULT_LEVEL + level
end

function AddCurrentListControl(name1,name2,init_y,start__,end__)

local cursor_size             =  abris_font[2][1] + abris_font[2][4]
local cursor_size_scaled      =  cursor_size/GetScale()

local current_list_block_1			  = CreateElement "ceTexPoly"
current_list_block_1.name			  = name1
SetLineSized(current_list_block_1,-x_size,x_size)
current_list_block_1.init_pos		  = {0,init_y - 0.2 * cursor_size_scaled,0}
current_list_block_1.controllers      = {{"current_list_controller",-cursor_size,start__,end__}}
Add(current_list_block_1);
use_mipfilter(current_list_block_1)

local current_list_block_2			  = CreateElement "ceTexPoly"
current_list_block_2.name			  = name2
SetLineSized(current_list_block_2,-x_size,x_size)
current_list_block_2.parent_element   = name1
current_list_block_2.init_pos		  = {0,- 0.9*cursor_size_scaled,0}
Add(current_list_block_2);
use_mipfilter(current_list_block_2)
end

function AddSimpleCurrentListControl(init_y,delta)
local cursor_size             =  abris_font[2][1] + abris_font[2][4]
local cursor_size_scaled      =  cursor_size/GetScale()
local current_list_block_1			  = CreateElement "ceMeshPoly"
current_list_block_1.primitivetype    = "triangles"
current_list_block_1.vertices	 = {{-x_size, 0.7*cursor_size_scaled/2},
									{ x_size, 0.7*cursor_size_scaled/2},
									{ x_size,-0.7*cursor_size_scaled/2},
									{-x_size,-0.7*cursor_size_scaled/2}}
current_list_block_1.indices     = box_ind
current_list_block_1.material	 = "GULL_GREY"			   
current_list_block_1.init_pos  	 = {0,init_y,0}
current_list_block_1.controllers = {{"current_list_controller",delta,0,1000}}
SetDefaultClipWithLevel(current_list_block_1, 2)
Add(current_list_block_1);
use_mipfilter(current_list_block_1)
end

function RewriteDefaultLevel()
local ABRIS_workspace_common				   = CreateElement "ceMeshPoly"
	  ABRIS_workspace_common.primitivetype     = "triangles"
	  ABRIS_workspace_common.vertices		   = {{-x_size,y_size},
												  {x_size,y_size},
												  {x_size,-y_size},
												  {-x_size,-y_size}}
	  ABRIS_workspace_common.indices		   = {0, 1, 2, 0, 2, 3}
	  ABRIS_workspace_common.material		   = "RED"		
	  ABRIS_workspace_common.h_clip_relation = h_clip_relations.REWRITE_LEVEL
	  ABRIS_workspace_common.level		   = DEFAULT_LEVEL + 2
	  ABRIS_workspace_common.isdraw		   = true
	  ABRIS_workspace_common.isvisible	   = false
	  Add(ABRIS_workspace_common);
end

function AddButonBorderMask()

end
function AddContextBlock(context_string,button_number)
---------------------------CONTEXT_MENU_BLOCK-----------------------------------
local diplacement   = 0.4*x_size
if button_number == nil then
   diplacement  = 0 
else
   diplacement  = diplacement*button_number 
end
local context_menu_pos              = {-x_size + diplacement,-0.98*(y_size - button_border_size/scale_2) + y_size,0}
local cursor_size                   =  abris_font[2][1] + abris_font[2][4]
local button_border_tmp_1           = CreateElement "ceMeshPoly"
button_border_tmp_1.primitivetype   = "triangles"
button_border_tmp_1.vertices        =  {{-x_size, button_border_size/scale_2},
										{ x_size, button_border_size/scale_2},
										{ x_size, 0},
										{-x_size, 0}}
button_border_tmp_1.indices         = box_ind
button_border_tmp_1.material        = "RED"
button_border_tmp_1.init_pos        = {0,-y_size,0}

if button_number == nil then
button_border_tmp_1.controllers     = {{"context_menu_controller",0}}
else
button_border_tmp_1.controllers     = {{"context_menu_controller",button_number}}
end
button_border_tmp_1.h_clip_relation = h_clip_relations.DECREASE_LEVEL
button_border_tmp_1.isvisible	    = false
Add(button_border_tmp_1)
use_mipfilter(button_border_tmp_1)

local context_menu_border				      = CreateElement "ceMeshPoly"
context_menu_border.primitivetype     = "triangles"
context_menu_border.vertices		  = {{0,0}, {0.4*x_size,0},{0.4*x_size,-y_size},{0,-y_size}}
context_menu_border.indices		      = {0, 1, 2, 0, 2, 3}
context_menu_border.init_pos		  = context_menu_pos
context_menu_border.material		  = "BLACK2"
context_menu_border.controllers       = {{"context_menu_cursor_position",cursor_size}}
context_menu_border.parent_element    = button_border_tmp_1.name

SetDefaultClipWithLevel(context_menu_border,2)
Add(context_menu_border);
use_mipfilter(context_menu_border)

local context_menu_current				  = CreateElement "ceTexPoly"
SetLineSized(context_menu_current,0,0.4*x_size)
SetDefaultClipWithLevel(context_menu_current,2)
context_menu_current.init_pos    		  = {0,-0.2*cursor_size/GetScale(),0}
context_menu_current.parent_element       = context_menu_border.name
context_menu_current.controllers          = {{"context_menu_cursor_position",0,-cursor_size}}
Add(context_menu_current);
use_mipfilter(context_menu_current)

local context_menu_current_2				  = CreateElement "ceTexPoly"
SetLineSized(context_menu_current_2,0,0.4*x_size)
SetDefaultClipWithLevel(context_menu_current_2,2)
context_menu_current_2.parent_element		  = context_menu_current.name
context_menu_current_2.init_pos    		      = {0,-0.9*cursor_size/GetScale(),0}
Add(context_menu_current_2);
use_mipfilter(context_menu_current_2)

local txt_context_menu		   	     = CreateElement "ceStringPoly"
txt_context_menu.material        = "font_Ka-50_ABRIS_WHITE"
txt_context_menu.value           = context_string
txt_context_menu.alignment       = "LeftTop"
txt_context_menu.stringdefs      = abris_font[2]
txt_context_menu.init_pos        = {0.01*x_size,0,0}
txt_context_menu.parent_element  = context_menu_border.name
SetDefaultClipWithLevel(txt_context_menu,2)
Add(txt_context_menu)
use_mipfilter(txt_context_menu)

local context_menu_up_line                 = CreateElement "ceTexPoly"
SetLineSized(context_menu_up_line,0,0.4*x_size)
SetDefaultClipWithLevel(context_menu_up_line,2)
context_menu_up_line.parent_element  = context_menu_border.name
Add(context_menu_up_line)
use_mipfilter(context_menu_up_line)

local context_menu_right_line                 = CreateElement "ceTexPoly"
SetLineSized(context_menu_right_line,0,y_size)
SetDefaultClipWithLevel(context_menu_right_line,2)
context_menu_right_line.init_pos		= {0.4*x_size,0,0}
context_menu_right_line.init_rot		= {-90.0,0,0}
context_menu_right_line.parent_element  = context_menu_border.name
Add(context_menu_right_line)
use_mipfilter(context_menu_right_line)

local context_menu_left_line                 = CreateElement "ceTexPoly"
SetLineSized(context_menu_left_line,0,y_size)
SetDefaultClipWithLevel(context_menu_left_line,2)
context_menu_left_line.init_rot		= {-90.0,0,0}
context_menu_left_line.parent_element  = context_menu_border.name
Add(context_menu_left_line)
use_mipfilter(context_menu_left_line)

local button_border_tmp_2           = CreateElement "ceMeshPoly"
button_border_tmp_2.primitivetype   = "triangles"
button_border_tmp_2.vertices        = button_border_tmp_1.vertices
button_border_tmp_2.indices         = button_border_tmp_1.indices
button_border_tmp_2.material        = "RED"
button_border_tmp_2.init_pos        = {0,-y_size,0}
button_border_tmp_2.h_clip_relation = h_clip_relations.INCREASE_LEVEL
button_border_tmp_2.parent_element  = button_border_tmp_1.name
button_border_tmp_2.isvisible	    = false
Add(button_border_tmp_2)
use_mipfilter(button_border_tmp_2)
---------------------------CONTEXT_MENU_BLOCK-----------------------------------
end

function AddBrighnessMask()
BrighnessMask				   = CreateElement "ceMeshPoly"
BrighnessMask.name			   = "BrighnessMask"
BrighnessMask.primitivetype    = "triangles"
BrighnessMask.vertices		   = {{-x_size,y_size}, {x_size,y_size}, {x_size,-y_size},{-x_size,-y_size}}
BrighnessMask.indices		   = {0, 1, 2, 0, 2, 3}
BrighnessMask.material		   = "BRIGHTNESS_MASK_BLACK"
Add(BrighnessMask);
end
function add_map_error_remover(name)
local	render_map_border					= CreateElement "ceMeshPoly"
		render_map_border.primitivetype		= "lines"
		render_map_border.vertices			= {{-x_size,y_size},{x_size,y_size},{x_size,-y_size},{-x_size,-y_size}}
		render_map_border.indices			= {0,1,1,2,2,3,3,0}
		render_map_border.name				= name
		render_map_border.material			= "RED"
        
        render_map_border.isvisible         = false
        
		Add(render_map_border)
end

function  AddNavigationDataBlock_1()

local	txt_datablock1_header			   	   = CreateElement "ceStringPoly"
		txt_datablock1_header.name             = "txt_datablock1_header"
		txt_datablock1_header.material         = "font_Ka-50_ABRIS_WHITE"
		txt_datablock1_header.init_pos		   = {-0.98*x_size,-0.38*y_size, 0}
		txt_datablock1_header.value            = LOCALIZE("пс").."\n"..LOCALIZE("пнг").."\n"..LOCALIZE( "т").."\n"..LOCALIZE("выс") --"пс\nпнг\nт\nвыс"
		txt_datablock1_header.alignment        = "LeftTop"
		txt_datablock1_header.stringdefs       = abris_font[6]
		Add(txt_datablock1_header)
		use_mipfilter(txt_datablock1_header)

local	txt_datablock1		   	       = CreateElement "ceStringPoly"
		txt_datablock1.name            = "txt_datablock1"
		txt_datablock1.material        = "font_Ka-50_ABRIS_WHITE"
		txt_datablock1.alignment       = "LeftTop"
		txt_datablock1.stringdefs      = abris_font[6]
		txt_datablock1.formats         = {"\t%03.f" ,"\n\t%03.f°","\n\t%02.f:%02.f:%02.f","\n\t%04.f"}
		txt_datablock1.controllers     = {{"txt_ABRIS_speed"         ,0, -999.0, 999.0},
										 {"txt_goto_heading",1,57.3},
										 {"flight_time"         ,2},
										 {"txt_ABRIS_altitude"        ,3, -9999.0, 9999.0}}
		txt_datablock1.parent_element  = "txt_datablock1_header"
		Add(txt_datablock1)
		use_mipfilter(txt_datablock1)

local	txt_datablock1_units		   	     = Copy(txt_datablock1)
		txt_datablock1_units.material        = "font_Ka-50_ABRIS_GREEN"
		txt_datablock1_units.formats         = {"\t\t%s\n\n\n","\t\t%s\n"}
		txt_datablock1_units.controllers     = {{"measurements_units_speed" ,0},
												{"measurements_units_height",1}}
		txt_datablock1_units.parent_element  = txt_datablock1.name
		Add(txt_datablock1_units)
end

function  AddNavigationDataBlock_2()
local	txt_datablock2_header			   	   = CreateElement "ceStringPoly"
		txt_datablock2_header.name             = "txt_datablock2_header"
		txt_datablock2_header.material         = "font_Ka-50_ABRIS_WHITE"
		txt_datablock2_header.init_pos		   = {-0.98*x_size,-0.3*y_size, 0}
		txt_datablock2_header.value            =  LOCALIZE("фпу").."\n".. LOCALIZE("пс").."\n"..LOCALIZE("пнг").."\n"..LOCALIZE( "т").."\n"..LOCALIZE("выс") -- "фпу\nпс\nпнг\nт\nвыс"
		txt_datablock2_header.alignment        = "LeftTop"
		txt_datablock2_header.stringdefs       = abris_font[6]
		Add(txt_datablock2_header)
		use_mipfilter(txt_datablock2_header)

local	txt_datablock2		   	       = CreateElement "ceStringPoly"
		txt_datablock2.name            = "txt_datablock2"
		txt_datablock2.material        = "font_Ka-50_ABRIS_WHITE"
		txt_datablock2.alignment       = "LeftTop"
		txt_datablock2.stringdefs      = abris_font[6]
		txt_datablock2.formats         = {"\t%03.f°","\n\t%03.f" ,"\n\t%03.f°","\n\t%02.f:%02.f:%02.f","\n\t%04.f"}
		txt_datablock2.controllers     = {{"txt_TCA"		 ,0,57.3},
										  {"txt_ABRIS_speed"         ,1, -999.0, 999.0},
										  {"txt_goto_heading",2,57.3},
										  {"flight_time"     ,3},
										  {"txt_ABRIS_altitude"        ,4, -9999.0, 9999.0}}
		txt_datablock2.parent_element  = "txt_datablock2_header"
		Add(txt_datablock2)
		use_mipfilter(txt_datablock2)

local	txt_datablock2_units		   	     = Copy(txt_datablock2)
		txt_datablock2_units.material        = "font_Ka-50_ABRIS_GREEN"
		txt_datablock2_units.formats         = {"\n\t\t%s\n\n\n","\t\t%s\n"}
		txt_datablock2_units.controllers     = {{"measurements_units_speed" ,0},
												{"measurements_units_height",1}}
		txt_datablock2_units.parent_element  = txt_datablock2.name
		Add(txt_datablock2_units)
end

function AddCenterLine()
	center_line             = CreateElement "ceTexPoly"
	center_line .name		= "center_line"
	SetLineSized(center_line ,0.440*y_size,0.840*y_size)
	center_line.init_rot	= {-90.0,0,0}
	Add(center_line)
end

function AddGotoBlock()
	--Goto Info--------------------------------------------------------
local	txt_goto_info_header			= CreateElement "ceStringPoly"
		txt_goto_info_header.name       = "txt_goto_info_header"
		txt_goto_info_header.material   = "font_Ka-50_ABRIS_WHITE"
		txt_goto_info_header.init_pos	= {0.015*x_size,y_center_render - y_render_size - sizes_y[3]/scale_2,0}
		txt_goto_info_header.value      = "   "..LOCALIZE("на").."\n"..
												 LOCALIZE("зпу").."\n"..
												 LOCALIZE("рст").."\n"..
												 LOCALIZE("Тппм")
		txt_goto_info_header.alignment  = "LeftTop"
		txt_goto_info_header.stringdefs = abris_font[6]
		Add(txt_goto_info_header)
		use_mipfilter(txt_goto_info_header)
	
local	goto_info_right_line                    = CreateElement "ceTexPoly"
		goto_info_right_line.name				= "goto_info_right_line"
		SetLineSized(goto_info_right_line,0.38*y_size,0.840*y_size)
		goto_info_right_line.init_pos	= {0.6*x_size,0,0}
		goto_info_right_line.init_rot	= {-90.0,0,0}
		Add(goto_info_right_line)
		use_mipfilter(goto_info_right_line)	
		
		
local	txt_goto_name		   			= CreateElement "ceStringPoly"
		txt_goto_name.name				= "txt_goto_name"
		txt_goto_name.material			= "font_Ka-50_ABRIS_GREEN"
		txt_goto_name.formats			= {"\t  %s"}
		txt_goto_name.alignment			= "LeftTop"
		txt_goto_name.stringdefs		= abris_font[6]
		txt_goto_name.parent_element	= "txt_goto_info_header"
		txt_goto_name.controllers       = {{"txt_goto_name",0},{"txt_UTF8_substr",0,8}}
		Add(txt_goto_name)
		use_mipfilter(txt_goto_name)


local		txt_goto_info_data			        = CreateElement "ceStringPoly"
			txt_goto_info_data.name             = "txt_goto_info_data"
			txt_goto_info_data.material         = "font_Ka-50_ABRIS_WHITE"
			txt_goto_info_data.parent_element	= "txt_goto_info_header"
			txt_goto_info_data.formats			= {"\n\t  %03.f°",
                                                   "\n\t  %03.1f",
                                                   "\n\t%02.f:%02.f:%02.f"}
			txt_goto_info_data.alignment		= "LeftTop"
			txt_goto_info_data.stringdefs		=  abris_font[6] 
			txt_goto_info_data.controllers      = {{"txt_goto_course_angle",0,57.3},
			                                       {"txt_goto_distance",1,0.001},
												   {"txt_goto_time_over_target",2},
												   {"txt_goto_time_left",2}}
			Add(txt_goto_info_data)
			use_mipfilter(txt_goto_info_data)
	
local		txt_goto_info_units			        = Copy(txt_goto_info_data)
			txt_goto_info_units.parent_element  = txt_goto_info_data.name
			txt_goto_info_units.material        = "font_Ka-50_ABRIS_GREEN"
			txt_goto_info_units.formats			= {"\n\n\t\t  %s"}
			txt_goto_info_units.controllers     = {{"measurements_units_range",0}}
			Add(txt_goto_info_units)
			
local 		next_waypoint_anchor = CreateElement "ceSimple"
next_waypoint_anchor.name 			= "next_waypoint_anchor"
next_waypoint_anchor.parent_element	= "txt_goto_info_header"
next_waypoint_anchor.init_pos		= {0.6*x_size,0,0}
Add(next_waypoint_anchor)

-----------------------------------------------------------------
local		txt_next_info_data			        = CreateElement "ceStringPoly"
			txt_next_info_data.name             = "txt_next_info_data"
			txt_next_info_data.material         = "font_Ka-50_ABRIS_DARK_GREY"
			txt_next_info_data.parent_element	= "next_waypoint_anchor"
			txt_next_info_data.formats			= {"%s","\n%03.f°","\n%03.1f","\n%02.f:%02.f"}
			txt_next_info_data.alignment		= "LeftTop"
			txt_next_info_data.stringdefs		=  abris_font[6] 
			txt_next_info_data.controllers      = {{"txt_next_name",0},{"txt_UTF8_substr",0,5},
												   {"txt_next_course_angle",1},
												   {"txt_next_distance",2},{"measurements_units_range",0},
												   {"txt_next_time_over_target",3},
												   {"txt_next_time_left",4}}
			Add(txt_next_info_data)
			use_mipfilter(txt_next_info_data)
end

function AddCursor(boxed,color)

local cursor_sz      = cursor_size
local cursor_sc      = scale_2
local cursor_start_x = cursor_center_x
local cursor_start_y = cursor_center_y

if boxed then
cursor_sz      = cursor_size_box
cursor_sc	   = scale_cur_box
cursor_start_x = cursor_center_x_box
cursor_start_y = cursor_center_y_box
end

cursor_sz = cursor_sz/cursor_sc

local cursor_symbol                = CreateElement "ceTexPoly"
	  cursor_symbol.name           = "cursor_symbol"
	  cursor_symbol.vertices       = {{-cursor_sz, cursor_sz},
								      { cursor_sz, cursor_sz},
								      { cursor_sz,-cursor_sz},
								      {-cursor_sz,-cursor_sz}}
	  cursor_symbol.indices        = box_ind
	  cursor_symbol.material       = "INDICATION_ABRIS_"..color
	  cursor_symbol.tex_params	   = {cursor_start_x,cursor_start_y,cursor_sc,cursor_sc}
	  cursor_symbol.controllers    = {{"cursor_position",x_size*GetScale(),x_size*GetScale()}}
	  cursor_symbol.init_pos       = {0,y_center_render,0}
	  SetDefaultClipWithLevel(cursor_symbol,3)
	  Add(cursor_symbol)
	  use_mipfilter(cursor_symbol)
end

function add_line(y_pos)
local up_line          = CreateElement "ceTexPoly"
	  SetLine(up_line)
	  up_line.init_pos = {0,y_pos,0}
	  Add(up_line)
	  use_mipfilter(up_line)
end

function add_line_vertical(x_pos,y_pos,y_min,y_max)
local up_line          = CreateElement "ceTexPoly"
	  SetLineSized(up_line,y_min,y_max)
	  up_line.init_pos = {x_pos,y_pos,0}
	  up_line.init_rot = {90,0,0}
	  Add(up_line)
	  use_mipfilter(up_line)
end
simple_wpt = {}
simple_wpt.x_st = 18.5/512
simple_wpt.y_st = 33/512
simple_wpt.x_sz = 16/512

simple_wpt_curr      = {}
simple_wpt_curr.x_st = 53/512
simple_wpt_curr.y_st = 33/512
simple_wpt_curr.x_sz = 18/512

beacon_wpt_arrow   = {}
beacon_wpt_arrow.x_st = 88/512
beacon_wpt_arrow.y_st = 33/512
beacon_wpt_arrow.x_sz_pl = (113-88)/512
beacon_wpt_arrow.x_sz_mi = (88 - 75)/512
beacon_wpt_arrow.y_sz_pl = (33 - 3)/512
beacon_wpt_arrow.y_sz_mi = (50 - 33)/512

beacon_wpt   = {}
beacon_wpt.x_st    = 133.5/512
beacon_wpt.y_st    = 33/512
beacon_wpt.x_sz    = (88 - 74)/512
beacon_wpt.y_sz_pl = (33 - 15)/512
beacon_wpt.y_sz_mi = (50 - 33)/512

marker_wpt   = {}
marker_wpt.x_st    = 163/512
marker_wpt.y_st    = 33/512
marker_wpt.x_sz    = (175 - 163)/512
marker_wpt.y_sz    = (33  - 8)/512

solid_simple_wpt  = {}
solid_simple_wpt.x_st = 196/512
solid_simple_wpt.y_st = simple_wpt.y_st
solid_simple_wpt.x_sz = simple_wpt.x_sz

solid_marker_wpt   = {}
solid_marker_wpt.x_st    = 228.5/512
solid_marker_wpt.y_st    = 33/512
solid_marker_wpt.x_sz    = marker_wpt.x_sz
solid_marker_wpt.y_sz    = marker_wpt.y_sz


solid_beacon_wpt   = {}
solid_beacon_wpt.x_st    = 260.5/512
solid_beacon_wpt.y_st    = 33/512
solid_beacon_wpt.x_sz    = beacon_wpt.x_sz 
solid_beacon_wpt.y_sz_pl = beacon_wpt.y_sz_pl
solid_beacon_wpt.y_sz_mi = beacon_wpt.y_sz_mi

scale_wpt = 2.5*scale_2
aspect_scale_wpt = scale_2/scale_wpt

scale_wpt_big = scale_wpt / 1.1948332
scale_wpt_small = scale_wpt / 0.747517
scale_wpt_datalink = scale_wpt / 1.5
scale_wpt_spi = scale_wpt / 2.5

north_symbol_center_x = 488.5/512
north_symbol_center_y = 137.5/512
north_symbol_size     = (488.5 - 465)/512

rmi_cue_center_x = 437.5/512
rmi_cue_center_y = 113/512
rmi_cue_size_x   = (456 - 437.5)/512
rmi_cue_size_y   = (133 - 113)/512


function AddMapScales(use_course_window,x_min,x_max,y_min,y_max)
	local map_center_x 	  = 1 + x_min/(x_max - x_min)
	local map_center_y 	  = 1 + y_min/(y_max - y_min)
	local map_tex_scale_y = 1/(y_max - y_min)
	local map_tex_scale_x = 1/(x_max - x_min)
	local dy			  = 0.5 * (y_max + y_min)
	local dx              = 0.5 * (x_max + x_min)

	render_map					= CreateElement "ceTexPoly"
	render_map.name				= "screen"
	render_map.tex_params		= {map_center_x,map_center_y,map_tex_scale_x,map_tex_scale_y}
	render_map.material			= "render_target_2"
	render_map.init_pos			= {0,y_center_render - dy,0}
	render_map.h_clip_relation  = h_clip_relations.INCREASE_IF_LEVEL
	render_map.level			= DEFAULT_LEVEL + 2
	render_map.controllers      = {{"set_draw_volume_scales",x_min,x_max,y_min,y_max}}
	add_map_error_remover("error_remover")
	render_map.additive_alpha	= true
	Add(render_map)

	if use_course_window then
		render_map.vertices			= { {x_min		 	   ,y_max},
										{course_wnd_x_start,y_max},
										{course_wnd_x_start,course_wnd_y_end + dy},
										{course_wnd_x_end  ,course_wnd_y_end + dy},
										{course_wnd_x_end  ,y_max},
										{x_max			   ,y_max},
										{x_max			   ,scale_start_y    + dy},
										{scale_start_x	   ,scale_start_y    + dy},
										{scale_start_x	   ,y_min},
										{x_min		   	   ,y_min}}
		render_map.indices			= {	0,1,9;
										9,1,2;
										9,2,3;
										9,3,8;
										8,3,7;
										7,3,6;
										6,3,4;
										6,4,5}
	else
		render_map.vertices			= { {x_min		 	   ,y_max},
										{x_max			   ,y_max},
										{x_max			   ,scale_start_y    + dy},
										{scale_start_x	   ,scale_start_y    + dy},
										{scale_start_x	   ,y_min},
										{x_min		   	   ,y_min}}
		render_map.indices			=  {0,1,2;
										0,2,3;
										0,3,5;
										3,4,5}
	end

	--[[
	map_dbg_border					= CreateElement "ceMeshPoly"
	map_dbg_border.name				= "we"
	map_dbg_border.primitivetype    = "lines"
	map_dbg_border.material			= "GREEN"
	map_dbg_border.parent_element   = render_map.name	
	map_dbg_border.vertices			=  {{x_min		,y_max},
										{x_max		,y_max},
										{x_max		,y_min},
										{x_min		,y_min}}
	map_dbg_border.indices			= {0,1,1,2,2,3,3,0}
	Add(map_dbg_border)
	--]]


	local   goto_segment				= CreateElement "ceSimpleLineObject"
			goto_segment.material       = "GREEN"
			goto_segment.parent_element = "screen"
			goto_segment.width          = 0.004
			goto_segment.controllers	= {{"goto_segment",x_size,x_size}}
			SetDefaultClipWithLevel(goto_segment,3)
			Add(goto_segment)
			use_mipfilter(goto_segment)

	local history				 = CreateElement "ceSimpleLineObject"
		  history.material       = "BLACK2" 
		  history.width          = 0.004
		  history.parent_element = "screen"
		  history.controllers	= {{"scale_limit",0,4000000},{"history_trajectory",x_size,x_size}}
		  SetDefaultClipWithLevel(history,3)
		  Add(history)
		  use_mipfilter(history)

	local threats_dummy 			    = CreateElement "ceSimple"
		  threats_dummy.parent_element  = "screen"
		  threats_dummy.controllers     = {{"specific_draw_threat_areas",x_size,x_size}}
		  Add(threats_dummy)

	local level_revert             	  = level_reverter(3,render_map.vertices,render_map.indices)
		  level_revert.parent_element = "screen"
		  Add(level_revert)
	  
	local route_dummy 			    = CreateElement "ceSimple"
		  route_dummy.parent_element  = "screen"
		  route_dummy.controllers     = {{"specific_draw_route",x_size,x_size}}
		  Add(route_dummy)
		  


	local   north_direction                = CreateElement "ceTexPoly"
			north_direction.name           = "north_direction"
			north_direction.vertices       = {{-north_symbol_size/scale_2, north_symbol_size/scale_2},
											  { north_symbol_size/scale_2, north_symbol_size/scale_2},
											  { north_symbol_size/scale_2,-north_symbol_size/scale_2},
											  {-north_symbol_size/scale_2,-north_symbol_size/scale_2}}
			north_direction.indices        = box_ind
			north_direction.material       = "INDICATION_ABRIS_WHITE"
			north_direction.tex_params	   = {north_symbol_center_x,north_symbol_center_y,scale_2,scale_2}
			north_direction.parent_element = "screen"
			north_direction.init_pos       = {-x_size        +1.2*north_symbol_size/scale_2,
											   y_render_size -1.2*north_symbol_size/scale_2 + dy}
			north_direction.controllers	   = {{"north_direction"}}
			Add(north_direction)
			use_mipfilter(north_direction)

	local scale_window                = CreateElement "ceMeshPoly"
		  scale_window.name           = "scale_window"
		  scale_window.primitivetype  = "triangles"
		  scale_window.vertices       = {{scale_start_x, scale_start_y + dy},
										   {x_size       , scale_start_y + dy},
										   {x_size       ,-y_render_size + dy},
										   {scale_start_x,-y_render_size + dy}}
		  scale_window.indices        = box_ind
		  scale_window.material       = "RED"
		  scale_window.parent_element = "screen"
		  scale_window.isvisible      =  false
		  scale_window.h_clip_relation  = h_clip_relations.INCREASE_IF_LEVEL
		  scale_window.level			= DEFAULT_LEVEL + 2
		  
	Add(scale_window)

	AddScaleTxt("txt_scale")
end


function AddFrameMaterial(xmin,xmax,ymin,ymax,mat)
	dummy 			  = CreateElement "ceSimple"
	Add(dummy)

	local up_line       = CreateElement "ceTexPoly"
	SetLineSized(up_line ,xmin,xmax)
	if mat then	   up_line.material    = mat end
	up_line.init_pos	= {0,ymax,0}
	up_line.parent_element = dummy.name
	Add(up_line)

	local down_line       = CreateElement "ceTexPoly"
	SetLineSized(down_line ,xmin,xmax)
	if mat then  down_line.material    = mat end
	down_line.init_pos	= {0,ymin,0}
	down_line.parent_element = dummy.name
	Add(down_line)

	local left_line       = CreateElement "ceTexPoly"
	SetLineSized(left_line ,ymin,ymax)
	if mat then	 left_line.material    = mat end
	left_line.init_pos	= {xmin,0,0}
	left_line.init_rot	= {90.0,0,0}
	left_line.parent_element = dummy.name
	Add(left_line)

	local right_line       = CreateElement "ceTexPoly"
	SetLineSized(right_line ,ymin,ymax)
	if mat then	right_line.material    = mat end
	right_line.init_pos	= {xmax,0,0}
	right_line.init_rot	= {90.0,0,0}
	right_line.parent_element = dummy.name
	Add(right_line)
	return dummy
end

function AddFrame(xmin,xmax,ymin,ymax)
	return   AddFrameMaterial(xmin,xmax,ymin,ymax)
end


function AddMap()
	AddMapScales(false,-x_size,x_size,-y_render_size,y_render_size)
end

function AddMapNAV()
	local y_min  =  -0.4*y_render_size
	local y_max  = 2*y_render_size + y_min 
	AddMapScales(true,-x_size,x_size,-0.4*y_render_size,2*y_render_size + y_min)
end

function  AddDeviationBlock()
--------------Course deviation block
	local cdp_frame_size  = 0.07 * 1.3 * x_size -- y_size
	local cdp_y_size 	  = 0.02 * 1.3 * x_size -- y_size
	local cdp_pos_y       = -0.035* 1.3 * x_size -- y_size

	local   course_deviation_scale_right            = CreateElement "ceStringPoly"
			course_deviation_scale_right.material   = "font_Ka-50_ABRIS_WHITE"
			course_deviation_scale_right.init_pos   = {0.93*x_size , y_center_render - y_render_size,0}
			course_deviation_scale_right.formats    = {"%2.f"}
			course_deviation_scale_right.alignment  = "CenterTop"
			course_deviation_scale_right.stringdefs = abris_font[1]
			course_deviation_scale_right.controllers = {{"scale_LBU",0}}
			Add(course_deviation_scale_right)
			use_mipfilter(course_deviation_scale_right)

	local   course_deviation_scale_left            = CreateElement "ceStringPoly"
			course_deviation_scale_left.material   = "font_Ka-50_ABRIS_WHITE"
			course_deviation_scale_left.init_pos   = {-0.93*x_size , y_center_render - y_render_size,0}
			course_deviation_scale_left.formats    = {"%2.f"}
			course_deviation_scale_left.alignment  = "CenterTop"
			course_deviation_scale_left.stringdefs = abris_font[1]
			course_deviation_scale_left.controllers = {{"scale_LBU",0}}
			Add(course_deviation_scale_left)
			use_mipfilter(course_deviation_scale_left)

	local   course_deviation_frame_positive				    = CreateElement "ceMeshPoly"
			course_deviation_frame_positive.primitivetype   = "triangles"
			course_deviation_frame_positive.material	    = "RED"
			course_deviation_frame_positive.vertices	    = {{0,0},{0.856*x_size,0},{0.856*x_size,-cdp_frame_size},{0,-cdp_frame_size}} 
			course_deviation_frame_positive.indices		    = box_ind
			course_deviation_frame_positive.init_pos	    = {0,1.03*(y_center_render - y_render_size),0}
			course_deviation_frame_positive.h_clip_relation =  h_clip_relations.INCREASE_LEVEL
			course_deviation_frame_positive.isvisible       = false
			Add(course_deviation_frame_positive)

	local	course_deviation_positive				 = CreateElement "ceMeshPoly"
			course_deviation_positive.primitivetype  = "triangles"
			course_deviation_positive.material		 = "GREEN"
			course_deviation_positive.vertices		 = {{0			  , cdp_y_size},
														{-0.856*x_size, cdp_y_size},
														{-0.856*x_size,-cdp_y_size},
														{0			  ,-cdp_y_size}} 
			course_deviation_positive.indices		 = box_ind
			course_deviation_positive.init_pos		 = {0,cdp_pos_y,0}
			course_deviation_positive.parent_element = course_deviation_frame_positive.name--"course_deviation_frame_positive"
			course_deviation_positive.controllers    = {{"course_deviation_2",0.856*x_size*GetScale(),0,1}}
			SetDefaultClipWithLevel(course_deviation_positive,2+1)
			Add(course_deviation_positive)

	local   course_deviation_frame_positive_2				  = CreateElement "ceMeshPoly"
			course_deviation_frame_positive_2.primitivetype   = "triangles"
			course_deviation_frame_positive_2.material	      = "RED"
			course_deviation_frame_positive_2.vertices	      = course_deviation_frame_positive.vertices
			course_deviation_frame_positive_2.indices	      = box_ind
			course_deviation_frame_positive_2.parent_element  = course_deviation_frame_positive.name--"course_deviation_frame_positive"
			course_deviation_frame_positive_2.h_clip_relation =  h_clip_relations.DECREASE_LEVEL
			course_deviation_frame_positive_2.isvisible       = false
			course_deviation_frame_positive_2.isdraw          = true
			Add(course_deviation_frame_positive_2)

	local   course_deviation_frame_negative					= CreateElement "ceMeshPoly"
			course_deviation_frame_negative.primitivetype	= "triangles"
			course_deviation_frame_negative.material		= "RED"
			course_deviation_frame_negative.vertices		= {{0,0},
															   {-0.856*x_size,0},
															   {-0.856*x_size,-cdp_frame_size},
															   {0,-cdp_frame_size}} 
			course_deviation_frame_negative.indices			= box_ind
			course_deviation_frame_negative.init_pos		= {0,1.03*(y_center_render - y_render_size),0}
			course_deviation_frame_negative.h_clip_relation =  h_clip_relations.INCREASE_LEVEL
			course_deviation_frame_negative.isvisible       = false
			Add(course_deviation_frame_negative)

	local   course_deviation_negative				 = CreateElement "ceMeshPoly"
			course_deviation_negative.primitivetype  = "triangles"
			course_deviation_negative.material		 = "GREEN"
			course_deviation_negative.vertices		 = {{0,cdp_y_size},{0.856*x_size,cdp_y_size},{0.856*x_size,-cdp_y_size},{0,-cdp_y_size}} 
			course_deviation_negative.indices		 = box_ind
			course_deviation_negative.init_pos		 = {0,cdp_pos_y,0}
			course_deviation_negative.parent_element = course_deviation_frame_negative.name--"course_deviation_frame_negative"
			course_deviation_negative.controllers    = {{"course_deviation_2",0.856*x_size*GetScale(),-1,0}}
			SetDefaultClipWithLevel(course_deviation_negative,2+1)
			Add(course_deviation_negative)

	local   course_deviation_frame_negative2				 = CreateElement "ceMeshPoly"
			course_deviation_frame_negative2.primitivetype	 = "triangles"
			course_deviation_frame_negative2.material		 = "GREEN"
			course_deviation_frame_negative2.vertices		 = course_deviation_frame_negative.vertices
			course_deviation_frame_negative2.indices		 = box_ind
			course_deviation_frame_negative2.parent_element  = course_deviation_frame_negative.name--"course_deviation_frame_negative"
			course_deviation_frame_negative2.h_clip_relation =  h_clip_relations.DECREASE_LEVEL
			course_deviation_frame_negative2.isvisible       = false
			course_deviation_frame_negative2.isdraw          = true
			Add(course_deviation_frame_negative2)

	local   txt_course_deviation			   	  = CreateElement "ceStringPoly"
			txt_course_deviation.material         = "font_Ka-50_ABRIS_WHITE"
			txt_course_deviation.init_pos		  = {0,y_center_render - y_render_size - sizes_y[3]/scale_2,0}
			txt_course_deviation.alignment        = "CenterTop"
			txt_course_deviation.stringdefs       = abris_font[3]
			txt_course_deviation.formats          = {"%02.1f"}
			txt_course_deviation.controllers	  = {{"txt_course_deviation",0}}
			Add(txt_course_deviation)
			use_mipfilter(txt_course_deviation)
end


function clear_workspace(level)
	local ABRIS_workspace_common				   = CreateElement "ceMeshPoly"
	  ABRIS_workspace_common.primitivetype     = "triangles"
	  ABRIS_workspace_common.vertices		   = {{-x_size,y_size},
											      { x_size,y_size},
											      { x_size,-y_size},
											      {-x_size,-y_size}}
	  ABRIS_workspace_common.indices		   = {0, 1, 2, 0, 2, 3}
	  ABRIS_workspace_common.material		   = "RED"
	  ABRIS_workspace_common.h_clip_relation   = h_clip_relations.REWRITE_LEVEL
	  ABRIS_workspace_common.level		       = DEFAULT_LEVEL + level
	  ABRIS_workspace_common.isdraw		       = true
	  ABRIS_workspace_common.isvisible	       = false
	  Add(ABRIS_workspace_common);
end

function set_verts_circle(object,arc,pnts,radius,start_phase)
	local   num_points    = pnts
	local   step          = math.rad(arc/(num_points-1))
	local   verts_arrays = {}
	local   indices_array = {}
	local   shift = math.rad(start_phase)
	for i = 0,num_points-1 do
		verts_arrays[0  + i + 1]         =   {radius * math.cos(i * step + shift), radius * math.sin(i * step + shift)}	
	end

	indices_array[1]= 0
	indices_array[2]= 1
	indices_array[3]= num_points
	indices_array[4]= 1
	indices_array[5]= num_points
	indices_array[6]= num_points + 1

	for i = 1,num_points - 1 do
		indices_array[6*i + 1]= i-1
		indices_array[6*i + 2]= i
		indices_array[6*i + 3]= num_points + i - 1
		indices_array[6*i + 4]= i
		indices_array[6*i + 5]= num_points + i - 1
		indices_array[6*i + 6]= num_points + i
	end
	object.vertices = verts_arrays
	object.indices  = indices_array
end 

function set_verts_circle_dash_line(object,arc,pnts,radius,start_phase)
	local   num_points    = pnts
	local   step          = math.rad(arc/(num_points-1))
	local   verts_arrays = {}
	local   indices_array = {}
	local   shift = math.rad(start_phase)
	for i = 0,num_points-1 do
		verts_arrays[0  + i + 1]         =   {radius * math.cos(i * step + shift), radius * math.sin(i * step + shift)}	
	end
	
	indices_array[1]= 0
	indices_array[2]= 1
--[[
	indices_array[3]= num_points
	indices_array[4]= 1
	indices_array[5]= num_points
	indices_array[6]= num_points + 1
]]--
	nm = 2
	
	for i = 1,num_points * 0.5  - 1 do
		indices_array[nm*i + 1]= i*2-1
		indices_array[nm*i + 2]= i*2
--[[		indices_array[nm*i + 3]= num_points + i*2 - 1
		indices_array[nm*i + 4]= i*2
		indices_array[nm*i + 5]= num_points + i*2 - 1
		indices_array[nm*i + 6]= num_points + i*2]]--
	end
	
	object.vertices = verts_arrays
	object.indices  = indices_array
end 


function add_console(parent,rows,font_material,font_sizes,delta_y)
local   console_lines = {}
	for i = 0,(rows - 1) do
		console_lines[i]			    = CreateElement "ceStringPoly"
		console_lines[i].material       = font_material
		console_lines[i].init_pos	    = {0, -i * delta_y, 0}
		console_lines[i].alignment      = "LeftTop"
		console_lines[i].stringdefs     = font_sizes	
		console_lines[i].parent_element = parent.name
		console_lines[i].formats 		= {"%s"}
		console_lines[i].controllers 	= {{"console_message",0,i}}
		Add(console_lines[i])
		use_mipfilter(console_lines[i])
	end
end


UP_ARROW = [[/\]]
DN_ARROW = [[\/]]

function Add_SEARCH_tableLines(init_pos_y,row_height)

	local row_height = row_height or 3 * new_delta
	
	local adj = 0
	if init_pos_y == nil then
	   adj = - 0.3 * row_height/3
	end
	
	local init_pos_y = init_pos_y or  (y_center_render - y_render_size - new_delta)
	
	
	local up_line                 = CreateElement "ceTexPoly"
		  SetLine(up_line)   
		  up_line.init_pos	      = {0,y_center_render + y_render_size,0}
		  Add(up_line)
	-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	local middle_line             = CreateElement "ceTexPoly"
		  SetLine(middle_line)
		  middle_line.init_pos	   = {0,y_center_render - y_render_size,0}
		  Add(middle_line)
	---------------------------------------------------------------------------------------
	local middle_line2             	= CreateElement "ceTexPoly"
		  SetLine(middle_line2)
		  middle_line2.init_pos	    = {0,init_pos_y,0}
		  Add(middle_line2)
	---------------------------------------------------------------------------------------
	for i =1,2 do
	local middle_line_3                = Copy(middle_line2)
		  middle_line_3.init_pos	   = {0,-i * row_height,0}
		  middle_line_3.parent_element = middle_line2.name
		  Add(middle_line_3)
	end

	left_line     = CreateElement "ceTexPoly"
	left_line.name		= "left_line"
	SetLineSized(left_line ,0, row_height * 3 + adj)
	left_line.init_rot  	 = {-90,0,0}
	left_line.init_pos		 = {-0.99*x_size + 1.5*new_delta,0,0}
	left_line.parent_element = middle_line2.name
	Add(left_line)
	---------------------------------------------------------------------------------------
	right_line          	  = Copy(left_line)
	right_line.init_pos		  = {0.99*x_size -  5.2*new_delta,0,0}
	right_line.parent_element = middle_line2.name
	Add(right_line)
	
	return middle_line2
end
