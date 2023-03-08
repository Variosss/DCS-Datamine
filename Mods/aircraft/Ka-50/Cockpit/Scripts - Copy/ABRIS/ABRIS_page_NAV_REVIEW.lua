dofile(LockOn_Options.script_path.."ABRIS\\ABRIS_usefull_definitions.lua")

AddButtons("ПОИСК","КАРТА","ШБЖ","РУЧН","ПНП")
AddMode("ОБЗОР")

corner_size    = (383 - 218)/512
x_corner_start = 3/512
y_corner_start = 383/512 

workspace_HSI					= CreateElement "ceMeshPoly"
workspace_HSI.primitivetype     = "triangles"
--[[
workspace_HSI.vertices			=  {{-x_size, y_render_size},
								{course_wnd_x_start, y_render_size},
								{course_wnd_x_start, course_wnd_y_end},
								{course_wnd_x_end  , course_wnd_y_end},
								{course_wnd_x_end  , y_render_size},
								{x_size, y_render_size},
								{x_size,-y_render_size},
								{-x_size,-y_render_size}}
workspace_HSI.indices			=  {0,1,7;
									7,1,2;
									7,2,3;
									7,3,6;
									6,3,4;
									6,4,5}
									
--]]

local rmi_wnd_end_y    = -0.7*y_render_size
local rmi_wnd_end_x    = -0.5*x_size
local vnav_wnd_start_x =  0.8*x_size
local vnav_wnd_start_y = -0.35*y_render_size
local vnav_wnd_end_y   =  0.3*y_render_size

workspace_HSI.vertices			=
{{-x_size, rmi_wnd_end_y},
 {-x_size,y_render_size},
 {course_wnd_x_start, y_render_size},
 {course_wnd_x_start, course_wnd_y_end},
 {course_wnd_x_end  , course_wnd_y_end},
 {course_wnd_x_end  , y_render_size},
 {x_size,y_render_size},
 {x_size,vnav_wnd_end_y},
 {vnav_wnd_start_x,vnav_wnd_end_y},
 {vnav_wnd_start_x,vnav_wnd_start_y},
 {x_size,vnav_wnd_start_y},
 {x_size			   , scale_start_y},
 {scale_start_x	   , scale_start_y},
 {scale_start_x	   ,-y_render_size},
 {rmi_wnd_end_x,-y_render_size},
 {rmi_wnd_end_x, rmi_wnd_end_y}}
 
workspace_HSI.indices			= 
{
1,2,3;
0,1,3;
0,3,15;
3,4,8;
3,8,9;
3,9,12;
3,12,15;
15,12,14;
12,13,14;
4,5,6;
4,6,7;
4,7,8;
9,10,11;
9,11,12
} 

--[[
									
workspace_HSI.vertices			= { {-x_size		   , y_render_size},
								{course_wnd_x_start, y_render_size},
								{course_wnd_x_start, course_wnd_y_end},
								{course_wnd_x_end  , course_wnd_y_end},
								{course_wnd_x_end  , y_render_size},
								{x_size			   , y_render_size},
								{x_size			   , scale_start_y},
								{scale_start_x	   , scale_start_y},
								{scale_start_x	   ,-y_render_size},
								{-x_size		   ,-y_render_size}}
workspace_HSI.indices			= {	0,1,9;
								9,1,2;
								9,2,3;
								9,3,8;
								8,3,7;
								7,3,6;
								6,3,4;
								6,4,5}										
--]]

workspace_HSI.name				= "workspace_HSI"
workspace_HSI.material			= "RED"
workspace_HSI.h_clip_relation   = h_clip_relations.REWRITE_LEVEL
workspace_HSI.level				= DEFAULT_LEVEL + 3
workspace_HSI.init_pos			= {0,y_center_render,0}
workspace_HSI.isvisible	  	    = false
Add(workspace_HSI)

-----compass block-------------------------------------------------
local magnifier      = 0.880
local size_HSI       = 1.6625*magnifier*corner_size/scale_2
local scale_HSI      = scale_2/magnifier
local center_compass = y_center_render - 0.5*x_size

HSI_self_cue					= CreateElement "ceMeshPoly"
HSI_self_cue.primitivetype      = "triangles"
HSI_self_cue.vertices			=  {{-0.05,0.05},{0.05,0.05},{0,0}}
HSI_self_cue.indices			=  {0,1,2}
HSI_self_cue.name				= "HSI_self_cue"
HSI_self_cue.material			= "SIMPLE_WHITE"
HSI_self_cue.init_pos			= {0,center_compass + 0.98*size_HSI,0}
Add(HSI_self_cue)
use_mipfilter(HSI_self_cue)
	
function set_verts_circle(object,arc,pnts,radius_inner,radius_outer)
	local   num_points    = pnts
	local   step          = math.rad(arc/(num_points-1))
	local   verts_arrays = {}
	local   indices_array = {}
	for i = 0,num_points-1 do
		verts_arrays[0  + i + 1]         =   {radius_inner * math.cos(i * step), radius_inner * math.sin(i * step)}
		verts_arrays[num_points  + i + 1] =  {radius_outer * math.cos(i * step), radius_outer * math.sin(i * step)}
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
--[[
corner_0_90_____			   = CreateElement "ceMeshPoly"-- "ceTexPoly"
corner_0_90_____.primitivetype = "triangles"
corner_0_90_____.name       = "corner_0_90_____"
set_verts_circle(corner_0_90_____,90,8,size_HSI*0.9,size_HSI)
corner_0_90_____.material   = "GREEN"--"INDICATION_ABRIS_RED"
corner_0_90_____.init_pos   = {0,center_compass,0}
--corner_0_90_____.tex_params = {x_corner_start,y_corner_start,scale_HSI,scale_HSI}
corner_0_90_____.controllers = {{"heading_rotate"}}
SetDefaultClipWithLevel(corner_0_90_____,3)
Add(corner_0_90_____)
--]]


corner_0_90			   = CreateElement "ceTexPoly"
corner_0_90.name       = "corner_0_90"
set_verts_circle(corner_0_90,90,8,size_HSI*0.9,size_HSI)
--corner_0_90.indices    = box_ind
corner_0_90.material   = "INDICATION_ABRIS_WHITE"
corner_0_90.tex_params = {x_corner_start,y_corner_start,scale_HSI,scale_HSI}
corner_0_90.init_pos   = {0,center_compass,0}
corner_0_90.controllers = {{"heading_rotate"}}
SetDefaultClipWithLevel(corner_0_90,3)
Add(corner_0_90)
use_mipfilter(corner_0_90)

corner_90_180			   = CreateElement "ceTexPoly"
corner_90_180.name       = "corner_90_180"
corner_90_180.vertices   = corner_0_90.vertices
corner_90_180.indices    = corner_0_90.indices
corner_90_180.material   = "INDICATION_ABRIS_WHITE"
corner_90_180.tex_params = {x_corner_start,y_corner_start,scale_HSI,scale_HSI}
corner_90_180.parent_element = "corner_0_90"
corner_90_180.init_rot   = {90,0,0}
SetDefaultClipWithLevel(corner_90_180,3)
Add(corner_90_180)
use_mipfilter(corner_90_180)

corner_180_270			  = CreateElement "ceTexPoly"
corner_180_270.name       = "corner_180_270"
corner_180_270.vertices   = corner_0_90.vertices
corner_180_270.indices    = corner_0_90.indices
corner_180_270.material   = "INDICATION_ABRIS_WHITE"
corner_180_270.tex_params = {x_corner_start,y_corner_start,scale_HSI,scale_HSI}
corner_180_270.parent_element = "corner_0_90"
corner_180_270.init_rot   = {180,0,0}
SetDefaultClipWithLevel(corner_180_270,3)
Add(corner_180_270)
use_mipfilter(corner_180_270)

corner_270_360			   = CreateElement "ceTexPoly"
corner_270_360.name       = "corner_270_360"
corner_270_360.vertices   = corner_0_90.vertices
corner_270_360.indices    = corner_0_90.indices
corner_270_360.material   = "INDICATION_ABRIS_WHITE"
corner_270_360.tex_params = {x_corner_start,y_corner_start,scale_HSI,scale_HSI}
corner_270_360.parent_element = "corner_0_90"
corner_270_360.init_rot   = {270,0,0}
SetDefaultClipWithLevel(corner_270_360,3)
Add(corner_270_360)
use_mipfilter(corner_270_360)



local symbols = {"N","30°","60°","E","120°","150°","S","210°","240°","W","300°","330°"}
local ticks   = {}
local step    = math.rad(360.0/12)
for i = 0, 11 do
	ticks[i]                  = CreateElement "ceStringPoly"
	ticks[i].name			  = symbols[i+1]
	ticks[i].value			  = symbols[i+1]
	ticks[i].material         = "font_Ka-50_ABRIS_WHITE"
	ticks[i].init_pos		  = {0.85*size_HSI * math.sin(i * step),0.85*size_HSI * math.cos(i * step),0}
	ticks[i].alignment        = "CenterCenter"
	ticks[i].stringdefs       = abris_font[3]
	ticks[i].parent_element   = "corner_0_90"
	ticks[i].controllers      = {{"remove_orientation"}}
	SetDefaultClipWithLevel(ticks[i],3)
	Add(ticks[i])
	use_mipfilter(ticks[i])

end

RMI_cue					= CreateElement "ceMeshPoly"
RMI_cue.primitivetype   = "triangles"
RMI_cue.vertices		=  {
								{-0.025, size_HSI - 0.05},
								{     0, 0.98*size_HSI},
								{ 0.025, size_HSI - 0.05},
								{-0.005,size_HSI  - 0.05},
								{ 0.005,size_HSI  - 0.05},
								{ 0.005, 0.8*size_HSI},
								{-0.005, 0.8*size_HSI},
								{-0.005,-0.8*size_HSI},
								{ 0.005,-0.8*size_HSI},
								{ 0.005,    -size_HSI},
								{-0.005,    -size_HSI}
							   }
RMI_cue.indices		 	= {
									0,1,2;
									3,4,6;
									4,5,6;
									7,8,10;
									8,9,10
									}
RMI_cue.indices			=  {0,1,2,3,4,5,3,5,6}
RMI_cue.name			= "RMI_cue"
RMI_cue.material		= "GREEN"
RMI_cue.parent_element  = "corner_0_90"
RMI_cue.controllers     = {{"goto_course_angle_rotate",-1}}
SetDefaultClipWithLevel(RMI_cue,3)
Add(RMI_cue)
use_mipfilter(RMI_cue)








--[[
dbg_TCA_cue					= CreateElement "ceMeshPoly"
dbg_TCA_cue.primitivetype   = "triangles"
dbg_TCA_cue.vertices		=  {{-0.05,0.4*size_HSI + 0.05},{0.05,0.4*size_HSI +  0.05},{0,0.6*size_HSI}}
dbg_TCA_cue.indices			=  {0,1,2}
dbg_TCA_cue.name			= "dbg_TCA_cue"
dbg_TCA_cue.material		= "ORANGE"
dbg_TCA_cue.parent_element  = "corner_0_90"
dbg_TCA_cue.controllers     = {{"self_course_angle_rotate",-1}}
SetDefaultClipWithLevel(dbg_TCA_cue,3)
Add(dbg_TCA_cue)
use_mipfilter(dbg_TCA_cue)
--]]

history				   = CreateElement "ceSimpleLineObject"
history.name           = "history"
history.material       = "SIMPLE_WHITE"
history.init_pos       = {0,center_compass,0}
history.width          = 0.002
history.controllers	= {{"scale_limit",0,4000000},{"history_trajectory",x_size,x_size}}
SetDefaultClipWithLevel(history,3)
Add(history)
use_mipfilter(history)

--[[
dummy 		= CreateElement "ceSimple"
dummy.name  = "entry_point"
dummy.init_pos    = {0,center_compass,0}
dummy.controllers = {{"specific_draw_route",x_size,x_size}}
Add(dummy)
--]]

threats_dummy 			    = CreateElement "ceSimple"
threats_dummy.init_pos    	= {0,center_compass,0}
threats_dummy.controllers   = {{"specific_draw_threat_areas",x_size,x_size}}
Add(threats_dummy)

level_revert             	= Copy(workspace_HSI)
Add(level_revert)
	  
route_dummy 			    = CreateElement "ceSimple"
route_dummy.name		    = "entry_point"
route_dummy.init_pos    	= {0,center_compass,0}
route_dummy.controllers     = {{"specific_draw_route",x_size,x_size}}
Add(route_dummy)


plane_symbol            = CreateElement "ceTexPoly"
plane_symbol.name       = "plane_symbol"
plane_symbol.vertices   = {{-plane_size_x/scale_2, plane_size_y/scale_2},
						   { plane_size_x/scale_2, plane_size_y/scale_2},
						   { plane_size_x/scale_2,-plane_size_y/scale_2},
						   {-plane_size_x/scale_2,-plane_size_y/scale_2}}
plane_symbol.indices     = box_ind
plane_symbol.material    = "INDICATION_ABRIS_WHITE"
plane_symbol.tex_params  = {plane_center_x,plane_center_y,scale_2,scale_2}
plane_symbol.parent_element = route_dummy.name
Add(plane_symbol)
use_mipfilter(plane_symbol)

-----compass block-------------------------------------------------

AddDeviationBlock()

symbol            = CreateElement "ceTexPoly"
symbol.name       = "symbol"
symbol.vertices = { {-x_size,  sizes_y[1]/scale_2},
					{ x_size,  sizes_y[1]/scale_2},
					{ x_size, -sizes_y[1]/scale_2},
					{-x_size, -sizes_y[1]/scale_2}}
symbol.indices    = box_ind
symbol.material   = "INDICATION_ABRIS_WHITE"
symbol.tex_params = {x_center_2,centers_y[1],scale_2,scale_2}
symbol.init_pos	  = {0,y_center_render + y_render_size - sizes_y[1]/scale_2,0}
Add(symbol)
use_mipfilter(symbol)

txt_true_course_angle_header			   	  = CreateElement "ceStringPoly"
txt_true_course_angle_header.name             = "txt_true_course_angle_header"
txt_true_course_angle_header.material         = "font_Ka-50_ABRIS_GREEN"
txt_true_course_angle_header.init_pos		  = {0,1.2*sizes_y[1]/scale_2,0}
txt_true_course_angle_header.alignment        = "CenterTop"
txt_true_course_angle_header.stringdefs       = abris_font[6]
txt_true_course_angle_header.formats		  = {LOCALIZE("фпу").." \t"..LOCALIZE("И"), LOCALIZE("фпу").." \t"..LOCALIZE("М")}
txt_true_course_angle_header.controllers	  = {{"heading_source_index",0,1}}
txt_true_course_angle_header.parent_element   = "symbol"
Add(txt_true_course_angle_header)
use_mipfilter(txt_true_course_angle_header)

txt_true_course_angle			   	   = CreateElement "ceStringPoly"
txt_true_course_angle.name             = "txt_true_course_angle"
txt_true_course_angle.material         = "font_Ka-50_ABRIS_WHITE"
txt_true_course_angle.alignment        = "CenterTop"
txt_true_course_angle.stringdefs       = abris_font[6]
txt_true_course_angle.formats          = {" %03.f°"}
txt_true_course_angle.controllers	   = {{"txt_TCA",0,57.3}}
txt_true_course_angle.parent_element   = "txt_true_course_angle_header"
Add(txt_true_course_angle)
use_mipfilter(txt_true_course_angle)


AddSignalsBorder()

symbol3            = CreateElement "ceTexPoly"
symbol3.name       = "symbol3"
symbol3.vertices   = {{-x_size, sizes_y[3]/scale_2},
		  			  { x_size,  sizes_y[3]/scale_2},
  					  { x_size, -sizes_y[3]/scale_2},
					  {-x_size, -sizes_y[3]/scale_2}}
symbol3.indices    = box_ind
symbol3.material   = "INDICATION_ABRIS_WHITE"
symbol3.tex_params = {x_center_2,centers_y[3],scale_2,scale_2}
symbol3.init_pos   = {0, y_center_render - y_render_size - sizes_y[3]/scale_2,0}
Add(symbol3)
use_mipfilter(symbol3)


vnav_frame            = CreateElement "ceTexPoly"
vnav_frame.name       = "vnav_frame"
vnav_frame.vertices   = {{-size_vnav_x/scale_2,size_vnav_y/scale_2},
						 { size_vnav_x/scale_2,size_vnav_y/scale_2},
						 { size_vnav_x/scale_2,-0.02*size_vnav_y/scale_2},
						 {-size_vnav_x/scale_2,-0.02*size_vnav_y/scale_2}}
vnav_frame.indices    = box_ind
vnav_frame.material   = "INDICATION_ABRIS_WHITE"
vnav_frame.tex_params = {center_vnav_x,down_border_vnav_y ,scale_2,scale_2}
vnav_frame.init_pos   = {x_size - 0.99*size_vnav_x/scale_2,y_center_render - 0.5*size_vnav_y/scale_2,0}
Add(vnav_frame)
use_mipfilter(vnav_frame)



vnav_cue               = CreateElement "ceTexPoly"
vnav_cue.name          = "vnav_cue"
vnav_cue.vertices      = {{-vnav_cue_x_size/scale_2,vnav_cue_y_size/scale_2},
						 {  vnav_cue_x_size/scale_2,vnav_cue_y_size/scale_2},
						 {  vnav_cue_x_size/scale_2,-vnav_cue_y_size/scale_2},
						 { -vnav_cue_x_size/scale_2,-vnav_cue_y_size/scale_2}}
vnav_cue.indices        = box_ind
vnav_cue.material       = "INDICATION_ABRIS_GREEN"
vnav_cue.tex_params     = {vnav_cue_center_x,vnav_cue_center_y,scale_2,scale_2}
vnav_cue.init_pos       = {0.8*vnav_cue_x_size/scale_2,0.46 * size_vnav_y/scale_2,0}
vnav_cue.parent_element = "vnav_frame"
vnav_cue.controllers    = {{"height_deviation",(0.46 * size_vnav_y/scale_2)*GetScale()/50.0,-49,49}}
Add(vnav_cue)
use_mipfilter(vnav_cue)

vnav_frame_down_line            = CreateElement "ceTexPoly"
vnav_frame_down_line.name       = "vnav_frame_down_line"
SetLineSized(vnav_frame_down_line,-0.4*size_vnav_x/scale_2,size_vnav_x/scale_2)
vnav_frame_down_line.init_pos = {0,-0.02*size_vnav_y/scale_2,0}
vnav_frame_down_line.parent_element = "vnav_frame"
Add(vnav_frame_down_line)

AddCenterLine()

txt_menu8			   	  = CreateElement "ceStringPoly"
txt_menu8.name            = "txt_menu8"
txt_menu8.material        = "font_Ka-50_ABRIS_WHITE"
txt_menu8.init_pos		  = {-0.18*x_size,-0.71*y_size, 0}
txt_menu8.alignment       = "RightTop"
txt_menu8.stringdefs      = abris_font[3]
txt_menu8.formats         = {"%s\n","%s"}
txt_menu8.controllers	  = {{"txt_ABRIS_latitude",0},{"txt_ABRIS_longitude",1}}
Add(txt_menu8)
use_mipfilter(txt_menu8)


------------------------------------------------------------------------
AddNavigationDataBlock_1()
------------------------------------------------------------------------
AddGotoBlock()
------------------------------------------------------------------------

AddScaleTxt("txt_scale")

local scale_rmi = scale_2/0.7;
rmi_cue = {}
rmi_cue[1]                = CreateElement "ceTexPoly"
rmi_cue[1].name           = "rmi_cue_1"
rmi_cue[1].vertices       = {{-rmi_cue_size_x/scale_rmi,0},
								 { rmi_cue_size_x/scale_rmi,0},
							 { rmi_cue_size_x/scale_rmi,-rmi_cue_size_y/scale_rmi},
							 {-rmi_cue_size_x/scale_rmi,-rmi_cue_size_y/scale_rmi}}
rmi_cue[1].indices        = box_ind
rmi_cue[1].material       = "INDICATION_ABRIS_YELLOW"
rmi_cue[1].tex_params     = {rmi_cue_center_x,rmi_cue_center_y,scale_rmi,scale_rmi}
rmi_cue[1].controllers    = {{"rotate_RMI_value",0},{"move",0,0.95*size_HSI*GetScale(),0}}
rmi_cue[1].parent_element = "corner_0_90"
SetDefaultClipWithLevel(rmi_cue[1],3)
Add(rmi_cue[1])
use_mipfilter(rmi_cue[1])

rmi_cue[2]               = CreateElement "ceTexPoly"
rmi_cue[2].name          = "rmi_cue_2"
rmi_cue[2].vertices      = rmi_cue[1].vertices
rmi_cue[2].indices       = rmi_cue[1].indices
rmi_cue[2].material      = "INDICATION_ABRIS_RED"
rmi_cue[2].tex_params    = {rmi_cue_center_x,rmi_cue_center_y,scale_rmi,scale_rmi}
rmi_cue[2].controllers    = {{"rotate_RMI_value",1},{"move",0,0.95*size_HSI*GetScale(),0}}
rmi_cue[2].parent_element = "corner_0_90"
SetDefaultClipWithLevel(rmi_cue[2],3)
Add(rmi_cue[2])
use_mipfilter(rmi_cue[2])

rmi_cue_tail = {}
local rmi_cue_tail_center_x = 437.25/512
local rmi_cue_tail_center_y = 148.75/512
local rmi_cue_tail_size_x  = (437.25 - 431)/512
local rmi_cue_tail_size_y  = (148.75 - 135)/512

rmi_cue_tail[1]                = CreateElement "ceTexPoly"
rmi_cue_tail[1].name           = "rmi_cue_1_tail"
rmi_cue_tail[1].vertices       = {{-rmi_cue_tail_size_x/scale_rmi,rmi_cue_tail_size_y/scale_rmi},
								  { rmi_cue_tail_size_x/scale_rmi,rmi_cue_tail_size_y/scale_rmi},
								  { rmi_cue_tail_size_x/scale_rmi,-rmi_cue_tail_size_y/scale_rmi},
								  {-rmi_cue_tail_size_x/scale_rmi,-rmi_cue_tail_size_y/scale_rmi}}
rmi_cue_tail[1].indices        = box_ind
rmi_cue_tail[1].material       = "INDICATION_ABRIS_YELLOW"
rmi_cue_tail[1].tex_params     = {rmi_cue_tail_center_x,rmi_cue_tail_center_y,scale_rmi,scale_rmi}
rmi_cue_tail[1].parent_element = "rmi_cue_1"
rmi_cue_tail[1].init_pos       = {0,-1.8*size_HSI,0}
SetDefaultClipWithLevel(rmi_cue_tail[1],3)
Add(rmi_cue_tail[1])
use_mipfilter(rmi_cue_tail[1])

rmi_cue_tail[2]                = CreateElement "ceTexPoly"
rmi_cue_tail[2].name           = "rmi_cue_2_tail"
rmi_cue_tail[2].vertices       = {{-(2/512)/scale_rmi,rmi_cue_tail_size_y/scale_rmi},
								  { (2/512)/scale_rmi,rmi_cue_tail_size_y/scale_rmi},
								  { (2/512)/scale_rmi,-rmi_cue_tail_size_y/scale_rmi},
								  {-(2/512)/scale_rmi,-rmi_cue_tail_size_y/scale_rmi}}
rmi_cue_tail[2].indices        = box_ind
rmi_cue_tail[2].material       = "INDICATION_ABRIS_RED"
rmi_cue_tail[2].tex_params     = {433/512,rmi_cue_tail_center_y,scale_rmi,scale_rmi}
rmi_cue_tail[2].parent_element = "rmi_cue_2"
rmi_cue_tail[2].init_pos       = {0,-1.8*size_HSI,0}
SetDefaultClipWithLevel(rmi_cue_tail[2],3)
Add(rmi_cue_tail[2])
use_mipfilter(rmi_cue_tail[2])


txt_RMI_1			   	  = CreateElement "ceStringPoly"
txt_RMI_1.name            = "txt_RMI_1"
txt_RMI_1.material        = "font_Ka-50_ABRIS_WHITE"
txt_RMI_1.alignment       = "LeftCenter"
txt_RMI_1.stringdefs      = abris_font[4]-- abris_font[3]
txt_RMI_1.formats         = {"%03.f°"," %s"}
txt_RMI_1.controllers	  = {{"txt_RMI_value",0,0},{"options_main_element_draw",1,14}}
txt_RMI_1.init_pos       = {-x_size,y_center_render - y_render_size + 3.0*rmi_cue_size_x/scale_rmi,0}
Add(txt_RMI_1)
use_mipfilter(txt_RMI_1)

RMI_1_rectangle					   = AddFrameMaterial(0,0.4,-0.05,0.03,"INDICATION_ABRIS_YELLOW")
RMI_1_rectangle.init_pos		   = {-x_size,y_center_render - y_render_size + 3.0*rmi_cue_size_x/scale_rmi,0}
RMI_1_rectangle.controllers        = {{"is_rmi_indicate",0}}

txt_RMI_2			   	  = CreateElement "ceStringPoly"
txt_RMI_2.name            = "txt_RMI_2"
txt_RMI_2.material        = "font_Ka-50_ABRIS_WHITE"
txt_RMI_2.alignment       = "LeftCenter"
txt_RMI_2.stringdefs      = abris_font[4]--abris_font[3]
txt_RMI_2.formats         = {"%03.f°"," %s"}
txt_RMI_2.controllers	  = {{"txt_RMI_value",0,1},{"options_main_element_draw",1,15}}
txt_RMI_2.init_pos        = {-x_size,y_center_render - y_render_size + 1.0*rmi_cue_size_x/scale_rmi,0}
Add(txt_RMI_2)
use_mipfilter(txt_RMI_2)

RMI_2_rectangle					   = AddFrameMaterial(0,0.4,-0.05,0.03,"INDICATION_ABRIS_YELLOW")
RMI_2_rectangle.init_pos		   = {-x_size,y_center_render - y_render_size + 1.0*rmi_cue_size_x/scale_rmi,0}
RMI_2_rectangle.controllers        = {{"is_rmi_indicate",1}}

rmi_cue[3]                = CreateElement "ceTexPoly"
rmi_cue[3].name           = "rmi_cue_3"
rmi_cue[3].vertices       = rmi_cue[1].vertices
rmi_cue[3].indices        = rmi_cue[1].indices
rmi_cue[3].material       = "INDICATION_ABRIS_YELLOW"
rmi_cue[3].tex_params     = {rmi_cue_center_x,rmi_cue_center_y,scale_rmi,scale_rmi}
rmi_cue[3].init_pos       = {0.5*x_size,0,0}
rmi_cue[3].init_rot       = {-90,0,0}
rmi_cue[3].parent_element = "txt_RMI_1"
Add(rmi_cue[3])
use_mipfilter(rmi_cue[3])
	
	--стрелка слева или справа, когда РМИ1 выходит за пределы сектора
	--[[
	rmi1_left_side                = CreateElement "ceTexPoly"
	rmi1_left_side.name           = "rmi1_left_side"
	rmi1_left_side.vertices       = rmi_cue[1].vertices
	rmi1_left_side.indices        = rmi_cue[1].indices
	rmi1_left_side.material       = "INDICATION_ABRIS_YELLOW"
	rmi1_left_side.tex_params     = {rmi_cue_center_x,rmi_cue_center_y,scale_rmi,scale_rmi}
	rmi1_left_side.init_pos       = {-x_size+0.01,0.3,0}
	rmi1_left_side.init_rot       = {90,0,0}
	rmi1_left_side.parent_element = "entry_point"
	rmi1_left_side.controllers         ={{"rmi_edge_indicate",0,0}}
	Add(rmi1_left_side)
	use_mipfilter(rmi1_left_side)

	rmi1_right_side                = CreateElement "ceTexPoly"
	rmi1_right_side.name           = "rmi1_right_side"
	rmi1_right_side.vertices       = rmi_cue[1].vertices
	rmi1_right_side.indices        = rmi_cue[1].indices
	rmi1_right_side.material       = "INDICATION_ABRIS_YELLOW"
	rmi1_right_side.tex_params     = {rmi_cue_center_x,rmi_cue_center_y,scale_rmi,scale_rmi}
	rmi1_right_side.init_pos       = {x_size-0.01,0.3,0}
	rmi1_right_side.init_rot       = {-90,0,0}
	rmi1_right_side.parent_element = "entry_point"
	rmi1_right_side.controllers         ={{"rmi_edge_indicate",0,1}}
	Add(rmi1_right_side)
	use_mipfilter(rmi1_right_side)
	]]--
	
rmi_cue[4]                = CreateElement "ceTexPoly"
rmi_cue[4].name           = "rmi_cue_4"
rmi_cue[4].vertices       = rmi_cue[1].vertices
rmi_cue[4].indices        = rmi_cue[1].indices
rmi_cue[4].material       = "INDICATION_ABRIS_RED"
rmi_cue[4].tex_params     = {rmi_cue_center_x,rmi_cue_center_y,scale_rmi,scale_rmi}
rmi_cue[4].init_pos       = {0.5*x_size,0,0}
rmi_cue[4].init_rot       = {-90,0,0}
rmi_cue[4].parent_element = "txt_RMI_2"
Add(rmi_cue[4])
use_mipfilter(rmi_cue[4])
	
	--стрелка слева или справа, когда РМИ2 выходит за пределы сектора
	--[[
	rmi2_left_side                = CreateElement "ceTexPoly"
	rmi2_left_side.name           = "rmi2_left_side"
	rmi2_left_side.vertices       = rmi_cue[1].vertices
	rmi2_left_side.indices        = rmi_cue[1].indices
	rmi2_left_side.material       = "INDICATION_ABRIS_RED"
	rmi2_left_side.tex_params     = {rmi_cue_center_x,rmi_cue_center_y,scale_rmi,scale_rmi}
	rmi2_left_side.init_pos       = {-x_size+0.01,0.25,0}
	rmi2_left_side.init_rot       = {90,0,0}
	rmi2_left_side.parent_element = "entry_point"
	rmi2_left_side.controllers         ={{"rmi_edge_indicate",1,0}}
	Add(rmi2_left_side)
	use_mipfilter(rmi2_left_side)

	rmi2_right_side                = CreateElement "ceTexPoly"
	rmi2_right_side.name           = "rmi2_right_side"
	rmi2_right_side.vertices       = rmi_cue[1].vertices
	rmi2_right_side.indices        = rmi_cue[1].indices
	rmi2_right_side.material       = "INDICATION_ABRIS_RED"
	rmi2_right_side.tex_params     = {rmi_cue_center_x,rmi_cue_center_y,scale_rmi,scale_rmi}
	rmi2_right_side.init_pos       = {x_size-0.01,0.25,0}
	rmi2_right_side.init_rot       = {-90,0,0}
	rmi2_right_side.parent_element = "entry_point"
	rmi2_right_side.controllers         ={{"rmi_edge_indicate",1,1}}
	Add(rmi2_right_side)
	use_mipfilter(rmi2_right_side)
	]]--

local course_cue_center_x = 483.5/512
local course_cue_center_y = 373/512
local course_cue_size_x   = (500 - 483.5)/512
local course_cue_size_y   = (373 - 368)/512



course_cue    = CreateElement "ceTexPoly"
course_cue.name           = "course_cue"
course_cue.vertices       = {
								{-course_cue_size_x/scale_2,-course_cue_size_y/scale_2},
								{-course_cue_size_x/scale_2, course_cue_size_y/scale_2},
								{ course_cue_size_x/scale_2, course_cue_size_y/scale_2},
								{ course_cue_size_x/scale_2,-course_cue_size_y/scale_2}
							}
course_cue.indices        = box_ind
course_cue.material       = "INDICATION_ABRIS_YELLOW"
course_cue.tex_params     = {course_cue_center_x,course_cue_center_y,scale_2,scale_2}
course_cue.parent_element = "corner_0_90"
course_cue.controllers	  = {{"DTA_manual_cue",-1},{"move",0,size_HSI*GetScale(),0}}
SetDefaultClipWithLevel(course_cue,3)
Add(course_cue)
use_mipfilter(course_cue)



------------------------------------------------------------------------
clear_workspace(2)
------------------------------------------------------------------------
AddContextBlock(LOCALIZE("АЭРОДРОМ").."\n"..LOCALIZE("VOR").."\n"..LOCALIZE("ОПРС").."\n"..LOCALIZE("ППМ").."\n"..LOCALIZE("ГОРОД"),0)

