dofile(LockOn_Options.script_path.."ABRIS\\ABRIS_usefull_definitions.lua")
AddButtons("ИНФО","МЕРИТЬ","МСШТБ+","МСШТБ-","НАВ")
AddMode("КАРТА")
AddMapNAV()

stencil_return                  = CreateElement "ceMeshPoly"
stencil_return.primitivetype    = "triangles" 
stencil_return.vertices         =  render_map.vertices	
stencil_return.indices          =  render_map.indices
stencil_return.name			    = "stencil_return"
stencil_return.material         = "GREEN"
stencil_return.isvisible        = false
stencil_return.isdraw           = true
stencil_return.parent_element   = "screen"
stencil_return.h_clip_relation  = h_clip_relations.REWRITE_LEVEL
stencil_return.level            = DEFAULT_LEVEL + 3
Add(stencil_return)

---------------------------
plane_symbol                = CreateElement "ceTexPoly"
plane_symbol.name           = "plane_symbol"
plane_symbol.vertices       = {{-plane_size_x/scale_2, plane_size_y/scale_2},
							   { plane_size_x/scale_2, plane_size_y/scale_2},
							   { plane_size_x/scale_2,-plane_size_y/scale_2},
							   {-plane_size_x/scale_2,-plane_size_y/scale_2}}
plane_symbol.indices        = box_ind
plane_symbol.material       = "INDICATION_ABRIS_RED"
plane_symbol.tex_params		= {plane_center_x,plane_center_y,scale_2,scale_2}
plane_symbol.parent_element = "screen"
plane_symbol.controllers	= {{"self_map_orient",x_size,x_size,-1}}
SetDefaultClipWithLevel(plane_symbol,3)
Add(plane_symbol)
use_mipfilter(plane_symbol)


cursor_symbol                = CreateElement "ceTexPoly"
cursor_symbol.name           = "cursor_symbol"
cursor_symbol.vertices       = {{-cursor_size/scale_2, cursor_size/scale_2},
							   {  cursor_size/scale_2, cursor_size/scale_2},
							   {  cursor_size/scale_2,-cursor_size/scale_2},
							   { -cursor_size/scale_2,-cursor_size/scale_2}}
cursor_symbol.indices        = box_ind
cursor_symbol.material       = "INDICATION_ABRIS_RED"
cursor_symbol.tex_params	 = {cursor_center_x,cursor_center_y,scale_2,scale_2}
cursor_symbol.controllers    = {{"cursor_position",x_size*GetScale(),x_size*GetScale()}}
cursor_symbol.parent_element = "screen"
SetDefaultClipWithLevel(cursor_symbol,3)
Add(cursor_symbol)
use_mipfilter(cursor_symbol)

AddDeviationBlock()


up_frame            = CreateElement "ceTexPoly"
up_frame.name       = "up_frame"
up_frame.vertices = { {-x_size,  sizes_y[1]/scale_2},
					{ x_size,  sizes_y[1]/scale_2},
					{ x_size, -sizes_y[1]/scale_2},
					{-x_size, -sizes_y[1]/scale_2}}
up_frame.indices    = box_ind
up_frame.material   = "INDICATION_ABRIS_WHITE"
up_frame.tex_params = {x_center_2,centers_y[1],scale_2,scale_2}
up_frame.init_pos	  = {0,y_center_render + y_render_size - sizes_y[1]/scale_2,0}
Add(up_frame)
use_mipfilter(up_frame)

txt_course_angle_header			   	     = CreateElement "ceStringPoly"
txt_course_angle_header.name             = "txt_course_angle_header"
txt_course_angle_header.material         = "font_Ka-50_ABRIS_GREEN"
txt_course_angle_header.init_pos		 = {0,1.2*sizes_y[1]/scale_2,0}
txt_course_angle_header.alignment        = "CenterTop"
txt_course_angle_header.stringdefs       = abris_font[6]
txt_course_angle_header.formats          = {LOCALIZE("фпу").." \t"..LOCALIZE("И"), LOCALIZE("фпу").." \t"..LOCALIZE("М")}
txt_course_angle_header.controllers	     = {{"heading_source_index",0,1}}
txt_course_angle_header.parent_element   = "up_frame"
Add(txt_course_angle_header)
use_mipfilter(txt_course_angle_header)

txt_course_angle			   	   = CreateElement "ceStringPoly"
txt_course_angle.name             = "txt_course_angle"
txt_course_angle.material         = "font_Ka-50_ABRIS_WHITE"
txt_course_angle.alignment        = "CenterTop"
txt_course_angle.stringdefs       = abris_font[6]
txt_course_angle.formats          = {" %03.f°"}
txt_course_angle.controllers	   = {{"txt_TCA",0,57.3}}
txt_course_angle.parent_element   = "txt_course_angle_header"
Add(txt_course_angle)
use_mipfilter(txt_course_angle)


AddSignalsBorder()

course_deviation_window            = CreateElement "ceTexPoly"
course_deviation_window.name       = "course_deviation_window"
course_deviation_window.vertices   = {{-x_size, sizes_y[3]/scale_2},
		  							  { x_size,  sizes_y[3]/scale_2},
  									  { x_size, -sizes_y[3]/scale_2},
									  {-x_size, -sizes_y[3]/scale_2}}
course_deviation_window.indices    = box_ind
course_deviation_window.material   = "INDICATION_ABRIS_WHITE"
course_deviation_window.tex_params = {x_center_2,centers_y[3],scale_2,scale_2}
course_deviation_window.init_pos   = {0, y_center_render - y_render_size - sizes_y[3]/scale_2,0}
Add(course_deviation_window)
use_mipfilter(course_deviation_window)

vnav_frame            = CreateElement "ceTexPoly"
vnav_frame.name       = "vnav_frame"
vnav_frame.vertices   = {{-size_vnav_x/scale_2,size_vnav_y/scale_2},
						 { size_vnav_x/scale_2,size_vnav_y/scale_2},
						 { size_vnav_x/scale_2,-0.02*size_vnav_y/scale_2},
						 {-size_vnav_x/scale_2,-0.02*size_vnav_y/scale_2}}
vnav_frame.indices    = box_ind
vnav_frame.material   = "INDICATION_ABRIS_WHITE"
vnav_frame.tex_params = {center_vnav_x,down_border_vnav_y ,scale_2,scale_2}
vnav_frame.init_pos   = {-0.99*size_vnav_x/scale_2,-y_size + 2*button_border_size/scale_2,0}
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