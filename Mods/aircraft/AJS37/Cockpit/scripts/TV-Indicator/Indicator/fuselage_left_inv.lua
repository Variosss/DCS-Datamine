dofile(LockOn_Options.script_path.."TV-Indicator/Indicator/definitions.lua")

-- precreated material for mfd0 is render_target_1 
-- precreated material for mfd1 is render_target_2 
-- precreated material for mfd2 is render_target_3 
-- precreated material for mfd3 is render_target_4 
local one_degree = 9.9104250048--16.5454545455
function AddElement(object)
    object.use_mipfilter    = true
	object.additive_alpha   = true
	object.h_clip_relation  = h_clip_relations.COMPARE
	object.level			= HUD_DEFAULT_LEVEL
    Add(object)
end

local sz 	 = 5*one_degree--70
local verts  =   {{-sz,  sz},
				  { sz,  sz},
				  { sz, -sz},
				  {-sz, -sz}}
				  
				  
frame                                       = CreateElement "ceMeshPoly"
frame.name                                  = "fr"
frame.primitivetype                         = "lines"
frame.material                              = MakeMaterial(nil,{0,0,0,255})
frame.vertices                  			= verts
frame.indices			                    = {0,1,1,2,2,3,3,0}
				
	 



function AddStaticGrid(_texturepath,_name)
	local _MATERIAL   			= MakeMaterial(_texturepath,GRID_COLOR) -- image of the fixed net

	local sight_origin	         = CreateElement "ceSimple"
	sight_origin.name 		     = create_guid_string() -- no such function in this script. Not in definitions.lua either. Could be in elements_defs.lua
	sight_origin.collimated 		 = false
	AddElement(sight_origin)

	local _sight_full_radius =  80 -- is this the radius of "HUD/net view field"? Units (pixels or angular units)?
	local _sight_shift  = -0 -- explain shift?
	local _sight_radius =  100 + _sight_shift

	local sight	    = CreateElement "ceTexPoly" --this could be the text area on HUD
	sight.name 		= _name
	sight.vertices   = {{-_sight_full_radius, _sight_full_radius},
					{ _sight_full_radius, _sight_full_radius},
					{ _sight_full_radius,-_sight_full_radius},
					{-_sight_full_radius,-_sight_full_radius}}
	sight.indices	= {0,1,2,2,3,0}
	sight.tex_coords = {{0,0},{1,0},{1,1},{0,1}}
	sight.material   = _MATERIAL	   
	sight.init_pos   = {0,0} 
	sight.additive_alpha  = true
	sight.collimated = false
	sight.init_pos   = {0,-3} 
	
	sight.controllers			= {{"radar_grid"	,0,0.9,1.1},
								 }
	sight.parent_element = sight_origin.name
	AddElement(sight)

end
AddStaticGrid(LockOn_Options.script_path.."../resources/IndicationTextures/RadarGrid.tga","RadarGrid120km")

local STORLEKEN = sz*1.2

local display_origin	         = CreateElement "ceSimple"
display_origin.name 		     = create_guid_string() -- no such function in this script. Not in definitions.lua either. Could be in elements_defs.lua
display_origin.collimated 		 = true
AddElement(display_origin)


display 			 	 = CreateElement "ceTexPoly"
display.name 			 = "radardisplay"
display.vertices 		 = {{-STORLEKEN, STORLEKEN},
					   		{ STORLEKEN, STORLEKEN},
					  		{ STORLEKEN,-STORLEKEN},
					  		{-STORLEKEN,-STORLEKEN}}
display.indices 		 = {0,1,2,2,3,0}
display.tex_coords = {{0,0},{1,0},{1,1},{0,1}}
display.init_pos		 = {0, 0, 0}-- -0.07/GetScale()}
display.init_rot		 = {0, 0, 0}---43}
display.material		 = "EP13Material"
display.primitivetype	= "triangles"
display.isdraw		 = true
display.isvisible		 = true
display.additive_alpha  = false
display.collimated = true
display.parent_element = display_origin.name
display.controllers			= {{"tvdisplay_move"	,0,0.9,1.1}, }
AddElement(display)




