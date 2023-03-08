dofile(LockOn_Options.script_path.."ABRIS\\ABRIS_usefull_definitions.lua")
new_delta = new_delta_2

border = 0.09 * new_delta
x = 0.25*x_size
y = 0.4*new_delta

color_item_data			   	     = CreateElement "ceMeshPoly"
color_item_data.primitivetype    = "triangles"
color_item_data.vertices         = {{-x, y},
									{ x, y},
									{ x,-y},
									{-x,-y}}
color_item_data.indices          = box_ind
color_item_data.name             = "tid_"
color_item_data.material         = "SIMPLE_WHITE"
color_item_data.init_pos		 =  {0,0,0}
color_item_data.controllers      =  {{"current_menu_in_list_position",-new_delta*GetScale()}}
Add(color_item_data)
use_mipfilter(color_item_data)


color_item_data2			   	  =  Copy(color_item_data)
color_item_data2.vertices         = {{-(x - border), (y - border)},
									 { (x - border), (y - border)},
									 { (x - border),-(y - border)},
									 {-(x - border),-(y - border)}}
color_item_data2.name             =  "tid_2"
color_item_data2.controllers      =  {{"additional_info_color_item"}}
color_item_data2.parent_element   =  "tid_"								 
Add(color_item_data2)
use_mipfilter(color_item_data2)

SetDefaultClipWithLevel(color_item_data,2)
SetDefaultClipWithLevel(color_item_data2,2)

