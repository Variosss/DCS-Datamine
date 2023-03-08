dofile(LockOn_Options.script_path.."ABRIS\\ABRIS_usefull_definitions.lua")
----------------------------------------------------------------------------------
AddMode("КАРТА")
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
AddMap()
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

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
------------------------------------------------------------------------------------------
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


---------------------------------------------------------------------------------------
AddSignalsBorder()
---------------------------------------------------------------------------------------
up_line             = CreateElement "ceTexPoly"
up_line.name		= "up_line"
SetLine(up_line)
up_line.init_pos	= {0,y_center_render + y_render_size,0}
Add(up_line)
---------------------------------------------------------------------------------------
middle_line             = CreateElement "ceTexPoly"
middle_line.name		= "middle_line"
SetLine(middle_line)
middle_line.init_pos	= {0,y_center_render - y_render_size,0}
Add(middle_line)
---------------------------------------------------------------------------------------
center_line             = CreateElement "ceTexPoly"
center_line .name		= "center_line"
center_line.init_pos	= {-0.3*x_size,y_center_render - y_render_size,0}
center_line.init_rot	= {-90.0,0,0}
SetLineSized(center_line ,0,0.545*y_size)
Add(center_line)
---------------------------------------------------------------------------------------
AddNavigationDataBlock_2()
---------------------------------------------------------------------------------------