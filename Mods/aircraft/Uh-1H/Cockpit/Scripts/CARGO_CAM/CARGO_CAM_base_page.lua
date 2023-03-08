dofile(LockOn_Options.common_script_path.."elements_defs.lua")

SetScale(FOV)

size=1;
line_width=0.0005
local width  = 1.0;
local height = width * GetAspect()

HUD_OnlyVerts  = {{-width,height},{width,height},{width,-height},{-width,-height}}

frame                                       = CreateElement "ceMeshPoly"
frame.name                                  = "fr"
frame.primitivetype                         = "lines"
frame.material                              = "BLACK2"
frame.vertices                  			= HUD_OnlyVerts
frame.indices			                    = {0,1,1,2,2,3,3,0}
frame.controllers                           = {{"tv_control"}}
Add(frame)

render_tv_in_HUD_only_view					= CreateElement "ceTexPoly"
render_tv_in_HUD_only_view.name				= "render_tv_in_HUD_only_view"
render_tv_in_HUD_only_view.vertices			= HUD_OnlyVerts
render_tv_in_HUD_only_view.indices			= {0, 1, 2, 0, 2, 3}
render_tv_in_HUD_only_view.tex_coords		= {{0,0},{1,0},{1,1},{0,1}}
--render_tv_in_HUD_only_view.level		      = 0
render_tv_in_HUD_only_view.material			= "render_target_1"
render_tv_in_HUD_only_view.parent_element   =  frame.name
Add(render_tv_in_HUD_only_view)

local box_height				= 0.025
local box_width					= 0.025
Sight       		= CreateElement "ceMeshPoly"
Sight.name		    = "Sight"
Sight.primitivetype  = "triangles"
Sight.material       = "RED"
Sight.vertices       = {{-box_width, -box_height},
                       {-box_width, box_height }, 
                       { box_width, box_height },
                       { box_width, -box_height}}        
Sight.indices        = default_box_indices
Sight.init_pos       = {0.0,0.0}
Sight.controllers    = {{"narrow_position"}}
Sight.screenspace 	= 2 -- DRAW_LEVEL_RENDER_TARGET
Add(Sight)


circle 						= CreateElement "ceCircle"
circle.name       			=  "circle"
circle.primitivetype 		= "triangles"
circle.material  		 	= "ORANGE"
circle.vertices       = {{-box_width, box_height},
                       {-box_width, box_height }, 
                       { box_width, -box_height },
                       { -box_width, -box_height}}     
circle.indices        = default_box_indices
circle.init_pos       = {0.0,0.0}
circle.controllers    = {{"circle_position"},{"radius"}}
--circle.parent_element 		= "Sight"
set_circle(circle, 0.8, 0.815)
circle.screenspace	  		= 2-- DRAW_LEVEL_RENDER_TARGET
Add(circle)


scale 						= CreateElement "ceMeshPoly"
scale.name       			=  "scale"
scale.primitivetype 		= "triangles"
scale.material  		 	= "RED"
scale.vertices       = {{-size	, -line_width},
                         {-size	, line_width}, 
                         { size	, line_width},
                         { size	,-line_width}}    
scale.indices        = default_box_indices
scale.init_pos       = {0.0,0.0}
--circle.parent_element 	 =  frame.name
scale.screenspace	  		= 2-- DRAW_LEVEL_RENDER_TARGET
Add(scale)

scale2 						= CreateElement "ceMeshPoly"
scale2.name       			=  "scale2"
scale2.primitivetype 		= "triangles"
scale2.material  		 	= "RED"
scale2.vertices       = {{-line_width	, -size},
                         {-line_width	, size}, 
                         { line_width	, size},
                         { line_width	,-size}}    
scale2.indices        = default_box_indices
scale2.init_pos       = {0.0,0.0}
--circle.parent_element 	 =  frame.name
scale2.screenspace	  		= 2-- DRAW_LEVEL_RENDER_TARGET
Add(scale2)

--[[cargo_distance			= CreateElement "ceStringPoly"
cargo_distance.name		= "cargo_distance"
cargo_distance.material	= "font_general"
cargo_distance.init_pos	= {aspect,  firstLineY+0.05, 0}
cargo_distance.value    = "RSHIFT ]/[     "
cargo_distance.alignment  = "RightCenter"
cargo_distance.stringdefs	= predefined_font_0
cargo_distance.screenspace	 = 2-- DRAW_LEVEL_RENDER_TARGET
cargo_distance.controllers    = {{"show_distance"}}
AddElement(cargo_distance)--]]



