dofile(LockOn_Options.script_path.."ABRIS\\ABRIS_usefull_definitions.lua")

new_delta = new_delta_4

dummy				   = CreateElement "ceMeshPoly"
dummy.name             = "dummy"
dummy.primitivetype    = "triangles"
dummy.vertices         = {{0,1.5*new_delta},{2*0.99*x_size,1.5*new_delta},
						  {2*0.99*x_size,-1.5*new_delta},{0,-1.5*new_delta}}
dummy.indices 		   = box_ind  
dummy.material         = "DARK_GREY"
dummy.init_pos		   = {-0.99*x_size,y_center_render - y_render_size - 7*new_delta,0}
dummy.controllers      = {{"set_frame_size_for_current_menu",100},{"specific_draw_journal"}} 
SetDefaultClipWithLevel(dummy,2)
Add(dummy)
use_mipfilter(dummy)

AddCursor(true,"GREEN")