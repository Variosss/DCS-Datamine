dofile(LockOn_Options.script_path.."Radar/Indicator/definitions.lua")

local RADARPIXELSWIDTH = 100

function AddElement(object)
    object.use_mipfilter    = true
	object.additive_alpha   = true
	object.h_clip_relation  = h_clip_relations.COMPARE
	object.level			= HUD_DEFAULT_LEVEL
    Add(object)
end

local sz 	 = 70
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
							 
													
--AddElement(frame)

		  


-- FPM/TVV
local BASE_COLOR  = {0,0  ,0,0}
local BASE_COLOR2 = {99, 196, 138, 190}--{255  ,255,255,150} --128,165,0,120
local GRID_COLOR = {99, 196, 138, 0}--{0,0,0,120} 
local BLACK_COLOR = {0,0,0,120}
local GRID_   			= MakeMaterial(LockOn_Options.script_path.."../resources/IndicationTextures/MeatBall.tga",BASE_COLOR2) -- image of the fixed net
local BASE_COLOR_MAT    = MakeMaterial(nil,BASE_COLOR)

local shape_rotation = 0

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
AddStaticGrid(LockOn_Options.script_path.."../resources/IndicationTextures/RadarGrid60km.tga","RadarGrid60km")
AddStaticGrid(LockOn_Options.script_path.."../resources/IndicationTextures/RadarGrid30km.tga","RadarGrid30km")
AddStaticGrid(LockOn_Options.script_path.."../resources/IndicationTextures/RadarGrid15km.tga","RadarGrid15km")
AddStaticGrid(LockOn_Options.script_path.."../resources/IndicationTextures/RadarGridB.tga","RadarGridB") 
local texture_size_x = 1024
local texture_size_y = 1024

function texture_box (UL_X,UL_Y,W,H)
local ux = UL_X / texture_size_x
local uy = UL_Y / texture_size_y
local w  = W / texture_size_x
local h  = H / texture_size_y
return {{ux	    ,uy},
		{ux + w ,uy},
		{ux + w ,uy + h},
		{ux	 	,uy + h}}
end

box_indices = 
{
	0,1,2;0,2,3
}

function create_textured_box(UL_X,UL_Y,DR_X,DR_Y,CENTER_X,CENTER_Y) -- function that creates textured square

local mils_per_pixel = 100/275
local W 	   		 = DR_X - UL_X
local H 	   		 = DR_Y - UL_Y
local cx		     = (UL_X + 0.5 * W)
local cy		     = (UL_Y + 0.5 * H)

local CENTER_X 		 = CENTER_X or cx
local CENTER_Y 		 = CENTER_Y or cy
local dcx 		 	 = mils_per_pixel * (CENTER_X - cx)
local dcy 		     = mils_per_pixel * (CENTER_Y - cy)

local half_x 		 = 0.5 * W * mils_per_pixel
local half_y 		 = 0.5 * H * mils_per_pixel


local object = CreateElement "ceTexPoly"
	  object.material =  indicaton_material
 	  object.vertices =  {{-half_x - dcx, half_y + dcy},
						  { half_x - dcx, half_y + dcy},
						  { half_x - dcx,-half_y + dcy},
						  {-half_x - dcx,-half_y + dcy}}
	  object.tex_coords = texture_box(UL_X,UL_Y,W,H)
	  object.indices	  = box_indices		
	  return object
end

local  static_grid 			= create_textured_box(350,--left texture border
												  130,--top most texture border 
												  756,--right border
												  540,--down border
												  nil, -- x coordinate of center object (optional )
												  nil  -- y coordinate of center object (optional )
												  )
	   static_grid.name 	= "static_grid"
	   static_grid.init_pos = {0,0,0}
	   AddElement(static_grid)



local STORLEKEN = 100

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
display.material		 = "RadarMaterial"
display.primitivetype	= "triangles"
display.isdraw		 = true
display.isvisible		 = true
display.additive_alpha  = false
display.collimated = true
display.parent_element = display_origin.name
AddElement(display)




function AddBPCirkel(_texturepath,_name)
	local _BPCIRKEL   			= MakeMaterial(LockOn_Options.script_path.._texturepath,BASE_COLOR2) -- image of the fixed net

	local bpcirkel_origin	         = CreateElement "ceSimple"
	bpcirkel_origin.name 		     = create_guid_string() -- no such function in this script. Not in definitions.lua either. Could be in elements_defs.lua
	bpcirkel_origin.collimated 		 = false
	AddElement(bpcirkel_origin)

	local bpcirkel_full_radius =  18--1.611328125--150 -- is this the radius of "HUD/net view field"? Units (pixels or angular units)?
	local bpcirkel_shift  = -0 -- explain shift?
	local bpcirkel_radius =  bpcirkel_full_radius + bpcirkel_shift

	local bpcirkel	    = CreateElement "ceTexPoly" --this could be the text area on HUD
	bpcirkel.name 		= _name -- this must be external function call.
	bpcirkel.vertices   = {{-bpcirkel_full_radius, bpcirkel_full_radius},
					   { bpcirkel_full_radius, bpcirkel_full_radius},
					   { bpcirkel_full_radius,-bpcirkel_full_radius},
					   {-bpcirkel_full_radius,-bpcirkel_full_radius}}
	bpcirkel.indices	= {0,1,2,2,3,0}
	bpcirkel.tex_coords = {{0,0},{1,0},{1,1},{0,1}}
	bpcirkel.material   = _BPCIRKEL	   
	bpcirkel.init_pos   = {0,0,0}--{0,riktprick_shift + shape_rotation} 
	bpcirkel.additive_alpha  = true
	bpcirkel.collimated = false
	bpcirkel.controllers			= {{"bp_move"	,0,0.9,1.1}}
	bpcirkel.parent_element = bpcirkel_origin.name
	AddElement(bpcirkel)

end

--AddBPCirkel("../resources/IndicationTextures/LNS_VIG_RADAR_BPCirkel_15.tga",  "bp15")
--AddBPCirkel("../resources/IndicationTextures/LNS_VIG_RADAR_BPCirkel_30.tga",  "bp30")
--AddBPCirkel("../resources/IndicationTextures/LNS_VIG_RADAR_BPCirkel_60.tga",  "bp60")
--AddBPCirkel("../resources/IndicationTextures/LNS_VIG_RADAR_BPCirkel_120.tga", "bp120")

-- Distance text
local FONT_         = MakeFont({used_DXUnicodeFontData = "font_cockpit_rus_2"},BASE_COLOR2,40,"test_font") --this is font object declaration. Mig-21 does not have fonts, therefore disabled.

txt_pitch					= CreateElement "ceStringPoly"
txt_pitch.name				= "txt_pitch"
txt_pitch.material			= FONT_
txt_pitch.init_pos			= {50.0,-70}
txt_pitch.alignment			= "CenterCenter"
txt_pitch.formats			= {"%0.f"}
txt_pitch.stringdefs		= {0.004,0.4 * 0.01, 0, 0}
txt_pitch.controllers 		= {{"distancetext",0}}
AddElement(txt_pitch)

-- Gräns (line)
local _GRANS   			= MakeMaterial(LockOn_Options.script_path.."../resources/IndicationTextures/Grans.tga",BASE_COLOR2) -- image of the fixed net

local grans_origin	         = CreateElement "ceSimple"
grans_origin.name 		     = create_guid_string() -- no such function in this script. Not in definitions.lua either. Could be in elements_defs.lua
grans_origin.collimated 		 = false
AddElement(grans_origin)

local grans_full_radius =  18--1.611328125--150 -- is this the radius of "HUD/net view field"? Units (pixels or angular units)?
local grans_shift  = -0 -- explain shift?
local grans_radius =  grans_full_radius + grans_shift



--local grans	    = CreateElement "ceTexPoly" --this could be the text area on HUD
--grans.name 		= create_guid_string() -- this must be external function call.
--grans.vertices   = {{-grans_full_radius, grans_full_radius},
--				   { grans_full_radius, grans_full_radius},
--				   { grans_full_radius,-grans_full_radius},
--				   {-grans_full_radius,-grans_full_radius}}
--grans.indices	= {0,1,2,2,3,0}
--grans.tex_coords = {{0,0},{1,0},{1,1},{0,1}}
--grans.material   = _GRANS	   
--grans.init_pos   = {0,0,0}--{0,riktprick_shift + shape_rotation} 
--grans.additive_alpha  = true
--grans.collimated = false
--grans.controllers			= {{"beam_move"	,0,0.9,1.1}}
--grans.parent_element = grans_origin.name
--AddElement(grans)

-- VideoCross (marker for fixes)
local _CROSS   			= MakeMaterial(LockOn_Options.script_path.."../resources/IndicationTextures/VideoKors.tga",BASE_COLOR2) -- image of the fixed net

local cross_origin	         = CreateElement "ceSimple"
cross_origin.name 		     = create_guid_string() -- no such function in this script. Not in definitions.lua either. Could be in elements_defs.lua
cross_origin.collimated 		 = false
AddElement(cross_origin)

local cross_full_radius =  18--1.611328125--150 -- is this the radius of "HUD/net view field"? Units (pixels or angular units)?
local cross_shift  = -0 -- explain shift?
local cross_radius =  cross_full_radius + cross_shift



local cross	    = CreateElement "ceTexPoly" --this could be the text area on HUD
cross.name 		= create_guid_string() -- this must be external function call.
cross.vertices   = {{-cross_full_radius, cross_full_radius},
				   { cross_full_radius, cross_full_radius},
				   { cross_full_radius,-cross_full_radius},
				   {-cross_full_radius,-cross_full_radius}}
cross.indices	= {0,1,2,2,3,0}
cross.tex_coords = {{0,0},{1,0},{1,1},{0,1}}
cross.material   = _CROSS	   
cross.init_pos   = {0,0,0}--{0,riktprick_shift + shape_rotation} 
cross.additive_alpha  = true
cross.collimated = false
cross.controllers			= {{"cross_move"	,0,0.9,1.1}}
cross.parent_element = cross_origin.name
AddElement(cross)

-- Max distance for Rb04
local _MAXDISTANCE   			= MakeMaterial(LockOn_Options.script_path.."../resources/IndicationTextures/Rb04MaxDistance.tga",BASE_COLOR2) -- image of the fixed net

local maxdistance_origin	         = CreateElement "ceSimple"
maxdistance_origin.name 		     = create_guid_string() -- no such function in this script. Not in definitions.lua either. Could be in elements_defs.lua
maxdistance_origin.collimated 		 = false
AddElement(maxdistance_origin)

local maxdistance_full_radius =  18--1.611328125--150 -- is this the radius of "HUD/net view field"? Units (pixels or angular units)?
local maxdistance_shift  = -0 -- explain shift?
local maxdistance_radius =  maxdistance_full_radius + maxdistance_shift



local maxdistance	    = CreateElement "ceTexPoly" --this could be the text area on HUD
maxdistance.name 		= "rb04maxdistance" -- this must be external function call.
maxdistance.vertices   = {{-maxdistance_full_radius, maxdistance_full_radius},
				   { maxdistance_full_radius, maxdistance_full_radius},
				   { maxdistance_full_radius,-maxdistance_full_radius},
				   {-maxdistance_full_radius,-maxdistance_full_radius}}
maxdistance.indices	= {0,1,2,2,3,0}
maxdistance.tex_coords = {{0,0},{1,0},{1,1},{0,1}}
maxdistance.material   = _MAXDISTANCE	   
maxdistance.init_pos   = {0,0,0}--{0,riktprick_shift + shape_rotation} 
maxdistance.additive_alpha  = true
maxdistance.collimated = false
maxdistance.controllers			= {{"maxmindistance"	,0,0.9,1.1}}
maxdistance.parent_element = maxdistance_origin.name
AddElement(maxdistance)

-- Min distance for Rb04
local _MINDISTANCE   			= MakeMaterial(LockOn_Options.script_path.."../resources/IndicationTextures/Rb04MinDistance.tga",BASE_COLOR2) -- image of the fixed net

local mindistance_origin	         = CreateElement "ceSimple"
mindistance_origin.name 		     = create_guid_string() -- no such function in this script. Not in definitions.lua either. Could be in elements_defs.lua
mindistance_origin.collimated 		 = false
AddElement(mindistance_origin)

local mindistance_full_radius =  18--1.611328125--150 -- is this the radius of "HUD/net view field"? Units (pixels or angular units)?
local mindistance_shift  = -0 -- explain shift?
local mindistance_radius =  mindistance_full_radius + mindistance_shift



local mindistance	    = CreateElement "ceTexPoly" --this could be the text area on HUD
mindistance.name 		= "rb04mindistance" 
mindistance.vertices   = {{-mindistance_full_radius, mindistance_full_radius},
				   { mindistance_full_radius, mindistance_full_radius},
				   { mindistance_full_radius,-mindistance_full_radius},
				   {-mindistance_full_radius,-mindistance_full_radius}}
mindistance.indices	= {0,1,2,2,3,0}
mindistance.tex_coords = {{0,0},{1,0},{1,1},{0,1}}
mindistance.material   = _MINDISTANCE	   
mindistance.init_pos   = {0,0,0}--{0,riktprick_shift + shape_rotation} 
mindistance.additive_alpha  = true
mindistance.collimated = false
mindistance.controllers			= {{"maxmindistance"	,0,0.9,1.1}}
mindistance.parent_element = mindistance_origin.name
AddElement(mindistance)


-- HUD overlay

local grid_origin	 = CreateElement "ceSimple"
	grid_origin.name = create_guid_string() 
	grid_origin.collimated = true
	grid_origin.init_pos = {00, -0, 0} -- <R> hack, for testing purposes only
AddElement(grid_origin)

local navigation_marker	 = CreateElement "ceSimple"
	navigation_marker.name = create_guid_string() 
	navigation_marker.collimated = true
	navigation_marker.init_pos = {0, 0, 0}
	navigation_marker.parent_element = grid_origin.name
AddElement(navigation_marker)


local one_degree = 5--0.99104250048
--local BASE_COLOR = {255,255,255,255} -- white
local HUD_MAT= MakeMaterial(LockOn_Options.script_path.."../resources/IndicationTextures/hud3.tga",BASE_COLOR2)

local outer_height_line_width = 0.1325966851*one_degree--8*0.2363714286
local outer_height_line_height = 3*one_degree --181*0.2363714286

local outer_height_line1 			= create_textured_box(579,--left texture border
	175-0,--top most texture border 
	579+8,--right border
	357,--down border
	nil, -- x coordinate of center object (optional )
	nil  -- y coordinate of center object (optional )
	)
outer_height_line1.name 	= "outer_height_line1"
outer_height_line1.material = HUD_MAT
outer_height_line1.vertices   = {{-outer_height_line_width, outer_height_line_height},
				   { outer_height_line_width, outer_height_line_height},
				   { outer_height_line_width,-outer_height_line_height},
				   {-outer_height_line_width,-outer_height_line_height}}
outer_height_line1.controllers = {{"height_lines"}}
outer_height_line1.init_pos = {0,0,0}
outer_height_line1.parent_element = navigation_marker.name
AddElement(outer_height_line1)

local outer_height_line2 			= create_textured_box(579,--left texture border
	175-0,--top most texture border 
	579+8,--right border
	357,--down border
	nil, -- x coordinate of center object (optional )
	nil  -- y coordinate of center object (optional )
	)
outer_height_line2.name 	= "outer_height_line2"
outer_height_line2.material = HUD_MAT
outer_height_line2.vertices   = {{-outer_height_line_width, outer_height_line_height},
				   { outer_height_line_width, outer_height_line_height},
				   { outer_height_line_width,-outer_height_line_height},
				   {-outer_height_line_width,-outer_height_line_height}}
outer_height_line2.controllers = {{"height_lines"}}
outer_height_line2.init_pos = {0,0,0}
outer_height_line2.parent_element = navigation_marker.name
AddElement(outer_height_line2)


local reference_height_line1 			= create_textured_box(579,--left texture border
	175-0,--top most texture border 
	579+8,--right border
	357,--down border
	nil, -- x coordinate of center object (optional )
	nil  -- y coordinate of center object (optional )
	)
reference_height_line1.name 	= "reference_height_line1"
reference_height_line1.material = HUD_MAT
reference_height_line1.vertices   = {{-outer_height_line_width, outer_height_line_height},
				   { outer_height_line_width, outer_height_line_height},
				   { outer_height_line_width,-outer_height_line_height},
				   {-outer_height_line_width,-outer_height_line_height}}
reference_height_line1.controllers = {{"reference_height"}}
reference_height_line1.init_pos = {0,0,0}
reference_height_line1.parent_element = grid_origin.name
AddElement(reference_height_line1)

local reference_height_line2 			= create_textured_box(579,--left texture border
	175-0,--top most texture border 
	579+8,--right border
	357,--down border
	nil, -- x coordinate of center object (optional )
	nil  -- y coordinate of center object (optional )
	)
reference_height_line2.name 	= "reference_height_line2"
reference_height_line2.material = HUD_MAT
reference_height_line2.vertices   = {{-outer_height_line_width, outer_height_line_height},
				   { outer_height_line_width, outer_height_line_height},
				   { outer_height_line_width,-outer_height_line_height},
				   {-outer_height_line_width,-outer_height_line_height}}
reference_height_line2.controllers = {{"reference_height"}}
reference_height_line2.init_pos = {0,0,0}
reference_height_line2.parent_element = grid_origin.name
AddElement(reference_height_line2)

local radar_height_width = 0.5*one_degree--58*0.2363714286
local radar_height_height = 0.1325966851*one_degree--7*0.2363714286

local radar_height1 			= create_textured_box(507,--left texture border
	348-0,--top most texture border 
	565,--right border
	355,--down border
	nil, -- x coordinate of center object (optional )
	nil  -- y coordinate of center object (optional )
	)
radar_height1.name 	= "radar_height1"
radar_height1.material = HUD_MAT
radar_height1.vertices   = {{-radar_height_width, radar_height_height},
				   { radar_height_width, radar_height_height},
				   { radar_height_width,-radar_height_height},
				   {-radar_height_width,-radar_height_height}}
radar_height1.controllers = {{"radar_height"}}
radar_height1.init_pos = {0,0,0}
radar_height1.parent_element = grid_origin.name
AddElement(radar_height1)

local radar_height2 			= create_textured_box(507,--left texture border
	348-0,--top most texture border 
	565,--right border
	355,--down border
	nil, -- x coordinate of center object (optional )
	nil  -- y coordinate of center object (optional )
	)
radar_height2.name 	= "radar_height2"
radar_height2.material = HUD_MAT
radar_height2.vertices   = {{-radar_height_width, radar_height_height},
				   { radar_height_width, radar_height_height},
				   { radar_height_width,-radar_height_height},
				   {-radar_height_width,-radar_height_height}}
radar_height2.controllers = {{"radar_height"}}
radar_height2.init_pos = {0,0,0}
radar_height2.parent_element = grid_origin.name
AddElement(radar_height2)

local artifical_horizon_width = 11*one_degree--559*0.2363714286
local artifical_horizon_height = 0.1325966851*one_degree--6*0.2363714286

local artifical_horizon1 			= create_textured_box(141+0,--left texture border
	151-0,--top most texture border 
	700+0,--right border
	157+0,--down border
	nil, -- x coordinate of center object (optional )
	nil  -- y coordinate of center object (optional )
	)
artifical_horizon1.name 	= "radar_artifical_horizon1"
artifical_horizon1.material = HUD_MAT
artifical_horizon1.vertices   = {{-artifical_horizon_width, artifical_horizon_height},
				   { artifical_horizon_width, artifical_horizon_height},
				   { artifical_horizon_width,-artifical_horizon_height},
				   {-artifical_horizon_width,-artifical_horizon_height}}
artifical_horizon1.controllers = {{"artifical_horizon"}}
artifical_horizon1.init_pos = {0,0,0}
artifical_horizon1.parent_element = grid_origin.name
AddElement(artifical_horizon1)

local artifical_horizon2			= create_textured_box(141+5,--left texture border
	151-0,--top most texture border 
	700+0,--right border
	157+0,--down border
	nil, -- x coordinate of center object (optional )
	nil  -- y coordinate of center object (optional )
	)
artifical_horizon2.name 	= "radar_artifical_horizon2"
artifical_horizon2.material = HUD_MAT
artifical_horizon2.vertices   = {{-artifical_horizon_width, artifical_horizon_height},
				   { artifical_horizon_width, artifical_horizon_height},
				   { artifical_horizon_width,-artifical_horizon_height},
				   {-artifical_horizon_width,-artifical_horizon_height}}
artifical_horizon2.controllers = {{"artifical_horizon"}}
artifical_horizon2.init_pos = {0,0,0}
artifical_horizon2.parent_element = grid_origin.name
AddElement(artifical_horizon2)

local horizion_reference_width = 1*one_degree--559*0.2363714286
local horizion_reference_height = 0.1325966851*one_degree--6*0.2363714286

local horizion_reference1			= create_textured_box(141+5,--left texture border
	151-0,--top most texture border 
	700+0,--right border
	157+0,--down border
	nil, -- x coordinate of center object (optional )
	nil  -- y coordinate of center object (optional )
	)
horizion_reference1.name 	= "radar_horizion_reference1"
horizion_reference1.material = HUD_MAT
horizion_reference1.vertices   = {{-horizion_reference_width, horizion_reference_height},
				   { horizion_reference_width, horizion_reference_height},
				   { horizion_reference_width,-horizion_reference_height},
				   {-horizion_reference_width,-horizion_reference_height}}
horizion_reference1.controllers = {{"artifical_horizon"}}
horizion_reference1.init_pos = {0,0,0}
horizion_reference1.parent_element = grid_origin.name
AddElement(horizion_reference1)


local horizion_reference2			= create_textured_box(141+5,--left texture border
	151-0,--top most texture border 
	700+0,--right border
	157+0,--down border
	nil, -- x coordinate of center object (optional )
	nil  -- y coordinate of center object (optional )
	)
horizion_reference2.name 	= "radar_horizion_reference2"
horizion_reference2.material = HUD_MAT
horizion_reference2.vertices   = {{-horizion_reference_width, horizion_reference_height},
				   { horizion_reference_width, horizion_reference_height},
				   { horizion_reference_width,-horizion_reference_height},
				   {-horizion_reference_width,-horizion_reference_height}}
horizion_reference2.controllers = {{"artifical_horizon"}}
horizion_reference2.init_pos = {0,0,0}
horizion_reference2.parent_element = grid_origin.name
AddElement(horizion_reference2)


local radar_elevation_reference1			= create_textured_box(141+5,--left texture border
	151-0,--top most texture border 
	700+0,--right border
	157+0,--down border
	nil, -- x coordinate of center object (optional )
	nil  -- y coordinate of center object (optional )
	)
radar_elevation_reference1.name 	= "radar_elevation_reference1"
radar_elevation_reference1.material = HUD_MAT
radar_elevation_reference1.vertices   = {{-horizion_reference_width, horizion_reference_height},
				   { horizion_reference_width, horizion_reference_height},
				   { horizion_reference_width,-horizion_reference_height},
				   {-horizion_reference_width,-horizion_reference_height}}
radar_elevation_reference1.controllers = {{"radar_elevation"}}
radar_elevation_reference1.init_pos = {0,0,0}
radar_elevation_reference1.parent_element = grid_origin.name
AddElement(radar_elevation_reference1)


local radar_elevation_reference2			= create_textured_box(141+5,--left texture border
	151-0,--top most texture border 
	700+0,--right border
	157+0,--down border
	nil, -- x coordinate of center object (optional )
	nil  -- y coordinate of center object (optional )
	)
radar_elevation_reference2.name 	= "radar_elevation_reference2"
radar_elevation_reference2.material = HUD_MAT
radar_elevation_reference2.vertices   = {{-horizion_reference_width, horizion_reference_height},
				   { horizion_reference_width, horizion_reference_height},
				   { horizion_reference_width,-horizion_reference_height},
				   {-horizion_reference_width,-horizion_reference_height}}
radar_elevation_reference2.controllers = {{"radar_elevation"}}
radar_elevation_reference2.init_pos = {0,0,0}
radar_elevation_reference2.parent_element = grid_origin.name
AddElement(radar_elevation_reference2)

local radar_elevation_reference3			= create_textured_box(141+5,--left texture border
	151-0,--top most texture border 
	700+0,--right border
	157+0,--down border
	nil, -- x coordinate of center object (optional )
	nil  -- y coordinate of center object (optional )
	)
radar_elevation_reference3.name 	= "radar_elevation_reference3"
radar_elevation_reference3.material = HUD_MAT
radar_elevation_reference3.vertices   = {{-horizion_reference_width, horizion_reference_height},
				   { horizion_reference_width, horizion_reference_height},
				   { horizion_reference_width,-horizion_reference_height},
				   {-horizion_reference_width,-horizion_reference_height}}
radar_elevation_reference3.controllers = {{"radar_elevation"}}
radar_elevation_reference3.init_pos = {0,0,0}
radar_elevation_reference3.parent_element = grid_origin.name
AddElement(radar_elevation_reference3)

local radar_elevation_indication_height = 1*one_degree
local radar_elevation_indication_width = 0.75*outer_height_line_width
local radar_elevation_indication 			= create_textured_box(579,--left texture border
	175-0,--top most texture border 
	579+8,--right border
	357,--down border
	nil, -- x coordinate of center object (optional )
	nil  -- y coordinate of center object (optional )
	)
radar_elevation_indication.name 	= "radar_elevation_indication"
radar_elevation_indication.material = HUD_MAT
radar_elevation_indication.vertices   = {{-radar_elevation_indication_width, radar_elevation_indication_height},
				   { radar_elevation_indication_width, radar_elevation_indication_height},
				   { radar_elevation_indication_width,-radar_elevation_indication_height},
				   {-radar_elevation_indication_width,-radar_elevation_indication_height}}
radar_elevation_indication.controllers = {{"radar_elevation"}}
radar_elevation_indication.init_pos = {0,0,0}
radar_elevation_indication.parent_element = grid_origin.name
AddElement(radar_elevation_indication)