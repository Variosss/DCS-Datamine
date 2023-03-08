dofile(LockOn_Options.script_path.."ABRIS\\ABRIS_usefull_definitions.lua")

AddButtons("ПОИСК","КАРТА","ШБЖ","РУЧН","МЕНЮ")
AddMode("ПНП")

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
									
workspace_HSI.name				= "workspace_HSI"
workspace_HSI.material			= "RED"
workspace_HSI.init_pos			= {0,y_center_render,0}
workspace_HSI.isvisible         = false
Add(workspace_HSI)

-----compass block-------------------------------------------------

local size_HSI  = 0.8*corner_size/scale_2
local scale_HSI = scale_2/0.8

HSI_self_cue					= CreateElement "ceMeshPoly"
HSI_self_cue.primitivetype      = "triangles"
HSI_self_cue.vertices			=  {{-0.05,0.05},{0.05,0.05},{0,0}}
HSI_self_cue.indices			=  {0,1,2}
HSI_self_cue.name				= "HSI_self_cue"
HSI_self_cue.material			= "SIMPLE_WHITE"
HSI_self_cue.init_pos			= {0,y_center_render + size_HSI,0}
Add(HSI_self_cue)
use_mipfilter(HSI_self_cue)

local lbu_scale_center_x = 397.25/512 
local lbu_scale_center_y = 375.25/512
local lbu_scale_size_x   = (397.25 - 336)/512 
local lbu_scale_size_y   = (375.25 - 369)/512


lbu_scale1			   = CreateElement "ceTexPoly"
lbu_scale1.name       = "lbu_scale_1"
lbu_scale1.vertices   = {{-lbu_scale_size_x/scale_2,-lbu_scale_size_y/scale_2},
						{-lbu_scale_size_x/scale_2, lbu_scale_size_y/scale_2},
						{ lbu_scale_size_x/scale_2, lbu_scale_size_y/scale_2},
						{ lbu_scale_size_x/scale_2,-lbu_scale_size_y/scale_2}}
lbu_scale1.indices    = box_ind
lbu_scale1.material   = "INDICATION_ABRIS_WHITE"
lbu_scale1.tex_params = {lbu_scale_center_x,lbu_scale_center_y,scale_2,scale_2}
lbu_scale1.parent_element = "needed_heading"
Add(lbu_scale1)
use_mipfilter(lbu_scale1)

lbu_scale2			      = CreateElement "ceTexPoly"
lbu_scale2.name           = "lbu_scale_2"
lbu_scale2.vertices       = lbu_scale1.vertices
lbu_scale2.indices        = lbu_scale1.indices
lbu_scale2.material       = "INDICATION_ABRIS_WHITE"
lbu_scale2.tex_params     = {lbu_scale_center_x,lbu_scale_center_y,scale_2,scale_2}
lbu_scale2.init_rot       = {90,0,0}
lbu_scale2.parent_element = "lbu_scale_1"
Add(lbu_scale2)
use_mipfilter(lbu_scale2)

local corner_verts = {}


corner_0_90			   = CreateElement "ceTexPoly"
corner_0_90.name       = "corner_0_90"
corner_0_90.vertices   = {{0, size_HSI},{size_HSI,size_HSI},{size_HSI,0},{0,0}}
corner_0_90.indices    = box_ind
corner_0_90.material   = "INDICATION_ABRIS_WHITE"
corner_0_90.tex_params = {x_corner_start,y_corner_start,scale_HSI,scale_HSI}
corner_0_90.init_pos   = {0,y_center_render,0}
corner_0_90.controllers = {{"heading_rotate"}}
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
	ticks[i].init_pos		  = {0.7*size_HSI * math.sin(i * step),0.7*size_HSI * math.cos(i * step),0}
	ticks[i].alignment        = "CenterCenter"
	ticks[i].stringdefs       = abris_font[3]
	ticks[i].parent_element   = "corner_0_90"
	ticks[i].controllers      = {{"remove_orientation"}}
	Add(ticks[i])
	use_mipfilter(ticks[i])

end



needed_heading					= CreateElement "ceMeshPoly"
needed_heading.primitivetype   = "triangles"
needed_heading.vertices		=  {
								{-0.025, size_HSI - 0.05},
								{     0, size_HSI},
								{ 0.025, size_HSI - 0.05},
								{-0.005,size_HSI  - 0.05},
								{ 0.005,size_HSI  - 0.05},
								{ 0.005, 0.7*size_HSI},
								{-0.005, 0.7*size_HSI},
								{-0.005,-0.7*size_HSI},
								{ 0.005,-0.7*size_HSI},
								{ 0.005,    -size_HSI},
								{-0.005,    -size_HSI}
							   }
needed_heading.indices		 = {
									0,1,2;
									3,4,6;
									4,5,6;
									7,8,10;
									8,9,10
									}
needed_heading.name			= "needed_heading"
needed_heading.material		= "GREEN"
needed_heading.parent_element  = "corner_0_90"
needed_heading.controllers     = {{"goto_course_angle_rotate",-1}}
Add(needed_heading)
use_mipfilter(needed_heading)


needed_heading2					= CreateElement "ceMeshPoly"
needed_heading2.primitivetype   = "triangles"
needed_heading2.vertices		=  {{ 0.005, 0.7*size_HSI},
								{-0.005, 0.7*size_HSI},
								{-0.005,-0.7*size_HSI},
								{ 0.005,-0.7*size_HSI}}
needed_heading2.indices		    = box_ind
needed_heading2.name			= "needed_heading_2"
needed_heading2.material		= "GREEN"
needed_heading2.parent_element  = "needed_heading"
needed_heading2.controllers     = {{"course_deviation",(((397.25 - 340.5)/512)/scale_2)*GetScale()/5000,-5000,5000}}
Add(needed_heading2)
use_mipfilter(needed_heading2)
--[[
dbg_TCA_cue					= CreateElement "ceMeshPoly"
dbg_TCA_cue.primitivetype   = "triangles"
dbg_TCA_cue.vertices		=  {{-0.05,0.4*size_HSI + 0.05},{0.05,0.4*size_HSI +  0.05},{0,0.6*size_HSI}}
dbg_TCA_cue.indices			=  {0,1,2}
dbg_TCA_cue.name			= "dbg_TCA_cue"
dbg_TCA_cue.material		= "ORANGE"
dbg_TCA_cue.parent_element  = "corner_0_90"
dbg_TCA_cue.controllers     = {{"self_course_angle_rotate",-1}}
Add(dbg_TCA_cue)
use_mipfilter(dbg_TCA_cue)
--]]
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
use_mipfilter(vnav_frame_down_line)

AddCenterLine()

txt_self_coordinates			   	  = CreateElement "ceStringPoly"
txt_self_coordinates.name            = "txt_self_coordinates"
txt_self_coordinates.material        = "font_Ka-50_ABRIS_WHITE"
txt_self_coordinates.init_pos		  = {-0.18*x_size,-0.71*y_size, 0}
txt_self_coordinates.alignment       = "RightTop"
txt_self_coordinates.stringdefs      = abris_font[3]
txt_self_coordinates.formats         = {"%s\n","%s"}
txt_self_coordinates.controllers	  = {{"txt_ABRIS_latitude",0},{"txt_ABRIS_longitude",1}}
Add(txt_self_coordinates)
use_mipfilter(txt_self_coordinates)
------------------------------------------------------------------------
AddNavigationDataBlock_1()
------------------------------------------------------------------------
AddGotoBlock()
------------------------------------------------------------------------
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
Add(rmi_cue_tail[2])
use_mipfilter(rmi_cue_tail[2])


txt_RMI_1			   	  = CreateElement "ceStringPoly"
txt_RMI_1.name            = "txt_RMI_1"
txt_RMI_1.material        = "font_Ka-50_ABRIS_WHITE"
txt_RMI_1.alignment       = "LeftCenter"
txt_RMI_1.stringdefs      = abris_font[4]
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
txt_RMI_2.stringdefs      = abris_font[4]
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


plane_symbol            = CreateElement "ceTexPoly"
plane_symbol.name       = "plane_symbol"
plane_symbol.vertices   = {{-plane_size_x/scale_2, plane_size_y/scale_2},
							{ plane_size_x/scale_2, plane_size_y/scale_2},
							{ plane_size_x/scale_2,-plane_size_y/scale_2},
							{-plane_size_x/scale_2,-plane_size_y/scale_2}}
plane_symbol.indices    = box_ind
plane_symbol.material   = "INDICATION_ABRIS_WHITE"
plane_symbol.tex_params = {plane_center_x,plane_center_y,scale_2,scale_2}
plane_symbol.init_pos   = {0,y_center_render,0}
Add(plane_symbol)
use_mipfilter(plane_symbol)

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
Add(course_cue)
use_mipfilter(course_cue)


------------------------------------------------------------------------
clear_workspace(2)
------------------------------------------------------------------------
AddContextBlock(LOCALIZE("АЭРОДРОМ").."\n"..LOCALIZE("VOR").."\n"..LOCALIZE("ОПРС").."\n"..LOCALIZE("ППМ").."\n"..LOCALIZE("ГОРОД"),0)
