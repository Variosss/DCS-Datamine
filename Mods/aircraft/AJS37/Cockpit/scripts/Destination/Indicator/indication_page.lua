dofile(LockOn_Options.script_path.."Destination/Indicator/definitions.lua")

function AddElement(object)
    object.use_mipfilter    = true
	object.additive_alpha   = true
	object.h_clip_relation  = h_clip_relations.COMPARE
	object.level			= HUD_DEFAULT_LEVEL
    Add(object)
end

function AddStaticSight(_texturepath,_showparametername)
	local _MATERIAL   			= MakeMaterial(_texturepath,BASE_COLOR2) -- image of the fixed net

	local sight_origin	         = CreateElement "ceSimple"
	sight_origin.name 		     = create_guid_string() -- no such function in this script. Not in definitions.lua either. Could be in elements_defs.lua
	sight_origin.collimated 		 = true
	AddElement(sight_origin)

	local _sight_full_radius =  100 -- is this the radius of "HUD/net view field"? Units (pixels or angular units)?
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
	sight.collimated = true
	sight.element_params   = {_showparametername} 
								   
	sight.controllers 	   = {{"parameter_in_range"	,0,0.9,1.1},--check that piper available using WS_GUN_PIPER_AVAILABLE
								 }
	sight.parent_element = sight_origin.name
--AddElement(sight)

end

-- FPM/TVV
local BASE_COLOR  = {0,0  ,0,0}
local BASE_COLOR2 = {255  ,255,255,255} --128,165,0,120
local GRID_   			= MakeMaterial(LockOn_Options.script_path.."../resources/IndicationTextures/MeatBall.tga",BASE_COLOR2) -- image of the fixed net
local BASE_COLOR_MAT    = MakeMaterial(nil,BASE_COLOR)

local shape_rotation = 0

shape_rotation = math.tan(shape_rotation/57.3) * 1000 -- to mils -- NOTE: this does nothing currently, returns 0


local full_radius =  45 -- is this the radius of "HUD/net view field"? Units (pixels or angular units)?
local grid_shift  = 0---35 -- explain shift?
local grid_radius =  full_radius + grid_shift

local grid_origin	         = CreateElement "ceSimple"
grid_origin.name 		     = create_guid_string() -- no such function in this script. Not in definitions.lua either. Could be in elements_defs.lua
grid_origin.collimated 		 = true
AddElement(grid_origin)


--
local BASE_COLOR2 = {255  ,255,255,255} --128,165,0,120
local GRID_   			= MakeMaterial(LockOn_Options.script_path.."../resources/IndicationTextures/MeatBall.tga",BASE_COLOR2) -- image of the fixed net
local BASE_COLOR_MAT    = MakeMaterial(nil,BASE_COLOR)
local DARKER_COLOR = {125, 68, 55, 255}
local DIRT_COLOR = {143, 99, 94, 255}
local GRID_   			= MakeMaterial(LockOn_Options.script_path.."../resources/IndicationTextures/MeatBall.tga",BASE_COLOR2) -- image of the fixed net
local BASE_COLOR_MAT    = MakeMaterial(nil,BASE_COLOR)

--local BASE_COLOR2 = {93, 168, 119, 255}--{255  ,255,255,255} -- WHY DOES ONLY WHITE WORK ???? 128,165,0,120 --
--local FONT_         = MakeFont({used_DXUnicodeFontData = "font_cockpit_rus_2"},BASE_COLOR2) --MakeFont({used_DXUnicodeFontData = "font_cockpit_rus_2"},BASE_COLOR2,40,"test_font") --this is font object declaration. Mig-21 does not have fonts, therefore disabled.
local FONT_         = MakeFont({used_DXUnicodeFontData = "font_ajs37"},BASE_COLOR2)--"font_ajs37"},BASE_COLOR2) --MakeFont({used_DXUnicodeFontData = "font_cockpit_rus_2"},BASE_COLOR2,40,"test_font") --this is font object declaration. Mig-21 does not have fonts, therefore disabled.
local FONT_DARKER  =MakeFont({used_DXUnicodeFontData = "font_ajs37"},DARKER_COLOR)
--local BASE_COLOR2 = {93, 168, 119, 255}--{255  ,255,255,255} -- WHY DOES ONLY WHITE WORK ???? 128,165,0,120 --
--local FONT_         = MakeFont({used_DXUnicodeFontData = "font_cockpit_rus_2"},BASE_COLOR2) --MakeFont({used_DXUnicodeFontData = "font_cockpit_rus_2"},BASE_COLOR2,40,"test_font") --this is font object declaration. Mig-21 does not have fonts, therefore disabled.
--local FONT_         = MakeFont({used_DXUnicodeFontData = "font_ajs37"},BASE_COLOR2)--"font_ajs37"},BASE_COLOR2) --MakeFont({used_DXUnicodeFontData = "font_cockpit_rus_2"},BASE_COLOR2,40,"test_font") --this is font object declaration. Mig-21 does not have fonts, therefore disabled.
--local FONT_         = MakeFont({used_DXUnicodeFontData = LockOn_Options.script_path.."../resources/IndicationTextures/font_ajs37"},BASE_COLOR2,30,"test_font2") --this is font object declaration. Mig-21 does not have fonts, therefore disabled.
--local FONTLARGE_         = MakeFont({used_DXUnicodeFontData = "FUI/Fonts/font_arial_17"},BASE_COLOR2,40,"test_font") --this is font object declaration. Mig-21 does not have fonts, therefore disabled.
local compassnrheight = 0.01
local compassnrwidth = 0.0037

--local FONTLARGE_         = MakeFont({used_DXUnicodeFontData = "Mods/aircraft/AJS37/Cockpit/resources/IndicationTextures/font_arial_17"},BASE_COLOR2,40,"test_font") --this is font object declaration. Mig-21 does not have fonts, therefore disabled.




local HDG_output           = CreateElement "ceStringPoly"
HDG_output.name            = "Dest1"
HDG_output.material        = FONT_DARKER
HDG_output.init_pos        = {-13,1}
HDG_output.alignment       = "CenterCenter"
HDG_output.stringdefs      = {compassnrheight,compassnrwidth, 0, 0}
HDG_output.formats         = {"%s","%s"}
--HDG_output.element_params  = {"NAV_CURRENTWP"}
HDG_output.controllers     = {{"destinationtext",0}}--{{"text_using_parameter",0,0}} --first index is for element_params (starting with 0) , second for formats ( starting with 0)
HDG_output.additive_alpha  = true
HDG_output.collimated     = false
AddElement(HDG_output)

local HDG_output           = CreateElement "ceStringPoly"
HDG_output.name            = "Dest2"
HDG_output.material        = FONT_
HDG_output.init_pos        = {10,1}
HDG_output.alignment       = "CenterCenter"
HDG_output.stringdefs      = {compassnrheight,compassnrwidth, 0, 0}
HDG_output.formats         = {"%s","%s"}
--HDG_output.element_params  = {"NAV_CURRENTWP"}
HDG_output.controllers     = {{"destinationtext",0}}--{{"text_using_parameter",0,0}} --first index is for element_params (starting with 0) , second for formats ( starting with 0)
HDG_output.additive_alpha  = true
HDG_output.collimated     = false
AddElement(HDG_output)


function texture_box (UL_X,UL_Y,W,H) --this is texture box function. Receives some coordinates and dimensions, returns 4 pairs of values. Nothing is calling this function inside script.
local texture_size_x = 128
local texture_size_y = 128
local ux = UL_X / texture_size_x
local uy = UL_Y / texture_size_y
local w  = W / texture_size_x
local h  = W / texture_size_y

return {{ux	    ,uy},
		{ux + w ,uy},
		{ux + w ,uy + h},
		{ux	 	,uy + h}}
end

function create_textured_box(UL_X,UL_Y,DR_X,DR_Y) -- function that creates textured square. This function is called 2 times in below code.

local size_per_pixel = 1/8
local texture_size_x = 128
local texture_size_y = 128
local W = DR_X - UL_X
local H = DR_Y - UL_Y

local half_x = 0.5 * W * size_per_pixel
local half_y = 0.5 * H * size_per_pixel
local ux 	 = UL_X / texture_size_x
local uy 	 = UL_Y / texture_size_y
local w  	 = W / texture_size_x
local h 	 = H / texture_size_y

local object = CreateElement "ceTexPoly"
object.vertices =  {{-half_x, half_y},
				    { half_x, half_y},
				    { half_x,-half_y},
				    {-half_x,-half_y}}
object.indices	  = {0,1,2,2,3,0}
object.tex_coords = {{ux     ,uy},
					 {ux + w ,uy},
					 {ux + w ,uy + h},
				     {ux 	 ,uy + h}}	 
				 
return object

end





