dofile(LockOn_Options.script_path.."ABRIS\\ABRIS_usefull_definitions.lua")

AddButtons("ПОИСК","НА","ИНФО","ИМЯ","НАВ")
AddMode("ПОИСК")
AddSignalsBorder()
AddMap()
---------------------------------------------------------------------------------------
cursor_menu     		  = CreateElement "ceMeshPoly"
cursor_menu.name		  = "cursor_menu"
cursor_menu.primitivetype = "triangles"
cursor_menu.vertices	  = {{0, 0},
							 {1.5*new_delta, 0},
							 {1.5*new_delta,-3*new_delta},
							 {0,-3*new_delta}}
cursor_menu.indices      = box_ind
cursor_menu.material	 = "GULL_GREY"			   
cursor_menu.init_pos  	 = {-0.99*x_size,y_center_render - y_render_size -new_delta,0} 
cursor_menu.controllers  = {{"current_list_controller",-3*new_delta*GetScale(),0,1000}}
Add(cursor_menu);
use_mipfilter(cursor_menu)

local grid  = Add_SEARCH_tableLines()

txt_1			   	  = CreateElement "ceStringPoly"
txt_1.name            = "txt_1"
txt_1.material        = "font_Ka-50_ABRIS_WHITE"
txt_1.init_pos		  = {-0.99*x_size,0.15*new_delta,0}
txt_1.alignment       = "LeftBottom"
txt_1.stringdefs      = abris_font[3]
txt_1.parent_element  = grid.name
txt_1.value           = "/\\\\/"
Add(txt_1)
use_mipfilter(txt_1)

dummy				   = CreateElement "ceMeshPoly"
dummy.name             = "dummy"
dummy.material         = "GREEN"
dummy.isvisible        = false
dummy.init_pos		   = {0,-0.15*new_delta,0}
dummy.controllers      = {{"set_frame_size_for_current_menu",3},{"specific_set_simple_menu"}} 
dummy.parent_element   = txt_1.name
Add(dummy)

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
------------------------------------------------------------------------------------------------------------------------------------------------------------------------
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
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

AddContextBlock(LOCALIZE("АЭРОДРОМ").."\n"..LOCALIZE("VOR").."\n"..LOCALIZE("ОПРС").."\n"..LOCALIZE("ППМ").."\n"..LOCALIZE("ГОРОД"))
