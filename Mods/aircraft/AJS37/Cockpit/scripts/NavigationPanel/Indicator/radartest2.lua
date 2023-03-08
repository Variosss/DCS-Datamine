dofile(LockOn_Options.script_path.."RadarTest/Indicator/definitions.lua")

-- precreated material for mfd0 is render_target_1 
-- precreated material for mfd1 is render_target_2 
-- precreated material for mfd2 is render_target_3 
-- precreated material for mfd3 is render_target_4 

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

		  
				  
TV_RENDER					= CreateElement "ceTexPoly"
TV_RENDER.name				= "TV_RENDER"
TV_RENDER.vertices			= verts
TV_RENDER.indices			= {0, 1, 2, 0, 2, 3}
TV_RENDER.tex_coords 		= {{0,0},{1,0},{1,1},{0,1}}
TV_RENDER.material			= "render_target_1"
--AddElement(TV_RENDER)


TV_RENDER_src_view					= CreateElement "ceTexPoly"
TV_RENDER_src_view.name				= "TV_RENDER_src_view"
TV_RENDER_src_view.vertices			= verts
TV_RENDER_src_view.indices			= {0, 1, 2, 0, 2, 3}
TV_RENDER_src_view.init_pos 		= {0,-2 * sz}
TV_RENDER_src_view.tex_coords 		= {{0,0},{1,0},{1,1},{0,1}}
TV_RENDER_src_view.material			= MakeMaterial("mfd0",{255,255,255,100})
--AddElement(TV_RENDER_src_view)

-- FPM/TVV
local BASE_COLOR  = {0,0  ,0,0}
local BASE_COLOR2 = {255  ,255,255,150} --128,165,0,120
local GRID_   			= MakeMaterial(LockOn_Options.script_path.."../resources/IndicationTextures/MeatBall.tga",BASE_COLOR2) -- image of the fixed net
local BASE_COLOR_MAT    = MakeMaterial(nil,BASE_COLOR)

local shape_rotation = 0

function AddStaticSight(_texturepath,_showparametername)
	local _MATERIAL   			= MakeMaterial(_texturepath,BASE_COLOR2) -- image of the fixed net

	local sight_origin	         = CreateElement "ceSimple"
	sight_origin.name 		     = create_guid_string() -- no such function in this script. Not in definitions.lua either. Could be in elements_defs.lua
	sight_origin.collimated 		 = false
	AddElement(sight_origin)

	local _sight_full_radius =  80 -- is this the radius of "HUD/net view field"? Units (pixels or angular units)?
	local _sight_shift  = -0 -- explain shift?
	local _sight_radius =  100 + _sight_shift

	local sight	    = CreateElement "ceTexPoly" --this could be the text area on HUD
	sight.name 		= create_guid_string() -- this must be external function call.
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
	--sight.element_params   = {_showparametername} 
								   
	--sight.controllers 	   = {{"parameter_in_range"	,0,0.9,1.1},--check that piper available using WS_GUN_PIPER_AVAILABLE
	--sight.controllers			= {{"move_updown"	,0,0.9,1.1},
		--						 }
	sight.parent_element = sight_origin.name
AddElement(sight)

end
AddStaticSight(LockOn_Options.script_path.."../resources/IndicationTextures/RadarGrid.tga","blaha") 
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
	   for i = 0, 2498 do	
--AddStaticSight(LockOn_Options.script_path.."../resources/IndicationTextures/Ritprick.tga","RIKTPRICK_SHOW")
local _RIKTPRICK   			= MakeMaterial(LockOn_Options.script_path.."../resources/IndicationTextures/RadarPixel.tga",BASE_COLOR2) -- image of the fixed net

local riktprick_origin	         = CreateElement "ceSimple"
riktprick_origin.name 		     = create_guid_string() -- no such function in this script. Not in definitions.lua either. Could be in elements_defs.lua
riktprick_origin.collimated 		 = false
--AddElement(riktprick_origin)

local riktprick_full_radius =  2--1.611328125--150 -- is this the radius of "HUD/net view field"? Units (pixels or angular units)?
local riktprick_shift  = -0 -- explain shift?
local riktprick_radius =  riktprick_full_radius + riktprick_shift

local riktprick	    = CreateElement "ceTexPoly" --this could be the text area on HUD
riktprick.name 		= create_guid_string() -- this must be external function call.
riktprick.vertices   = {{-riktprick_radius, riktprick_radius},
				   { riktprick_radius, riktprick_radius},
				   { riktprick_radius,-riktprick_radius},
				   {-riktprick_radius,-riktprick_radius}}
riktprick.indices	= {0,1,2,2,3,0}
riktprick.tex_coords = {{0,0},{1,0},{1,1},{0,1}}
riktprick.material   = _RIKTPRICK	   
riktprick.init_pos   = {0,riktprick_shift + shape_rotation} 
riktprick.additive_alpha  = false
riktprick.collimated = false
riktprick.controllers			= {{"move_updown"	,0,0.9,1.1},
								 }
riktprick.parent_element = riktprick_origin.name
--AddElement(riktprick)

-- local sz 	 = 2
-- local verts  =   {{-sz,  sz},
				  -- { sz,  sz},
				  -- { sz, -sz},
				  -- {-sz, -sz}}
				  
				  
-- frame                                       = CreateElement "ceMeshPoly"
-- frame.name                                  = "fr"
-- frame.primitivetype                         = "lines"
-- frame.material                              = MakeMaterial({255  ,255,255,150},{255  ,255,255,150})
-- frame.vertices                  			= verts
-- frame.indices			                    = {0,1,1,2,2,3,3,0}
-- frame.controllers 							= {{"move_updown"	,0,0.9,1.1}}
							 
													
-- AddElement(frame)
end

--AddStaticSight(LockOn_Options.script_path.."../resources/IndicationTextures/Ritprick.tga","RIKTPRICK_SHOW")
local _BPCIRKEL   			= MakeMaterial(LockOn_Options.script_path.."../resources/IndicationTextures/BPCirkel.tga",BASE_COLOR2) -- image of the fixed net

local bpcirkel_origin	         = CreateElement "ceSimple"
bpcirkel_origin.name 		     = create_guid_string() -- no such function in this script. Not in definitions.lua either. Could be in elements_defs.lua
bpcirkel_origin.collimated 		 = false
--AddElement(bpcirkel_origin)

local bpcirkel_full_radius =  18--1.611328125--150 -- is this the radius of "HUD/net view field"? Units (pixels or angular units)?
local bpcirkel_shift  = -0 -- explain shift?
local bpcirkel_radius =  bpcirkel_full_radius + bpcirkel_shift

local bpcirkel	    = CreateElement "ceTexPoly" --this could be the text area on HUD
bpcirkel.name 		= create_guid_string() -- this must be external function call.
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
--AddElement(bpcirkel)


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
--txt_pitch.parent_element    = roll_bird.name
--AddElement(txt_pitch)
-- local FONT_         = MakeFont({used_DXUnicodeFontData = "font_cockpit_rus_2"},BASE_COLOR2,40,"test_font") --this is font object declaration. Mig-21 does not have fonts, therefore disabled.

-- local distancetext				= CreateElement "ceStringPoly"
-- distancetext.name            = create_guid_string()
-- distancetext.material        = FONT_
-- distancetext.init_pos        = {50,y}
-- distancetext.alignment       = "CenterLeft"
-- distancetext.stringdefs      = {0.004,0.4 * 0.01, 0, 0}
-- distancetext.formats         = {"%s","%s"}
-- distancetext.controllers     = {{"distancetext",0,0}} --first index is for element_params (starting with 0) , second for formats ( starting with 0)
-- distancetext.additive_alpha  = true
-- distancetext.collimated     = false
-- AddElement(distancetext)