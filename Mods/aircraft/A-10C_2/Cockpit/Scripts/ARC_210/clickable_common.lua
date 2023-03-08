--Cursor Data 

--dofile("Scripts\\Plane\\Cockpit\\command_defs.lua")

Mouse_Speed					= 20
PrimitiveType				= "lines"
CursorMaterial				= {1,0,0}
OnClickMaterial				= {0,1,0}
CursorVertices				= {{-0.0025,0},{0.0025,0},{0,-0.0025},{0,0.0025},{-0.005,0},{0.005,0},{0,-0.005},{0,0.005}}
CursorIndices				= {0,2;2,1;1,3;3,0;4,5;6,7}
OnClickVertices				= {{-0.005,0},{0.005,0},{0,-0.005},{0,0.005}}
OnClickIndices				= {0,2;2,1;1,3;3,0}
---[[
show_element_boxes			= false;
show_element_parent_boxes	= false;
show_tree_boxes				= false; --true --false;
---]]
--[[
show_element_boxes			= true;
show_element_parent_boxes	= true;
show_tree_boxes				= true;
--]]

function WriteCustomZones(index,x,y,z)
     CustomZone[index]             = {}
	 CustomZone[index].pos         = {x,y,z}
	 CustomZone[index].action      = {0}
	 CustomZone[index].device      = 0	
	 CustomZone[index].is_custom   = true
	 CustomZone[index].class       = {class_type.BTN}
	 CustomZone[index].arg		   = {0}
	 CustomZone[index].arg_value   = {0}
	 CustomZone[index].arg_lim     = {{0,1}}
	 CustomZone[index].stop_action = {0}
	 CustomZone[index].normal      = {0,0,1}
end

function SaveCustomZones(fileName)
	local file = io.open(fileName, "w")
	if file then
		io.output(file)
		local t = {}
		Serialize("CustomZone", CustomZone, t)
	end
	io.close(file)
end

