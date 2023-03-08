dofile(LockOn_Options.script_path.."Data/Indicator/definitions.lua")
dofile(LockOn_Options.script_path.."fonts.lua")

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
local BASE_COLOR2 = {243  ,167,136,255} --128,165,0,120
local DARKER_COLOR = {125, 68, 55, 255}
local DIRT_COLOR = {143, 99, 94, 255}
local GRID_   			= MakeMaterial(LockOn_Options.script_path.."../resources/IndicationTextures/MeatBall.tga",BASE_COLOR2) -- image of the fixed net
local BASE_COLOR_MAT    = MakeMaterial(nil,BASE_COLOR)

--local BASE_COLOR2 = {93, 168, 119, 255}--{255  ,255,255,255} -- WHY DOES ONLY WHITE WORK ???? 128,165,0,120 --
--local FONT_         = MakeFont({used_DXUnicodeFontData = "font_cockpit_rus_2"},BASE_COLOR2) --MakeFont({used_DXUnicodeFontData = "font_cockpit_rus_2"},BASE_COLOR2,40,"test_font") --this is font object declaration. Mig-21 does not have fonts, therefore disabled.
local FONT_         = MakeFont({used_DXUnicodeFontData = "font_ajs37"},BASE_COLOR2)--"font_ajs37"},BASE_COLOR2) --MakeFont({used_DXUnicodeFontData = "font_cockpit_rus_2"},BASE_COLOR2,40,"test_font") --this is font object declaration. Mig-21 does not have fonts, therefore disabled.
local FONT_DARKER  =MakeFont({used_DXUnicodeFontData = "font_ajs37"},DARKER_COLOR)
--local FONT_         = MakeFont({used_DXUnicodeFontData = LockOn_Options.script_path.."../resources/IndicationTextures/font_ajs37"},BASE_COLOR2,30,"test_font2") --this is font object declaration. Mig-21 does not have fonts, therefore disabled.
--local FONTLARGE_         = MakeFont({used_DXUnicodeFontData = "FUI/Fonts/font_arial_17"},BASE_COLOR2,40,"test_font") --this is font object declaration. Mig-21 does not have fonts, therefore disabled.
local compassnrheight = 0.009
local compassnrwidth = 0.007
--local FONTLARGE_         = MakeFont({used_DXUnicodeFontData = "FUI/Fonts/font_arial_17"},BASE_COLOR2,40,"test_font") --this is font object declaration. Mig-21 does not have fonts, therefore disabled.

local charwidth = 32
local charwidth = 32

local data1           = CreateElement "ceStringPoly"
data1.name            = "data1"
data1.material        = FONT_--"font_NAV"
data1.init_pos        = {charwidth*0,-0} -- -50, -10
data1.alignment       = "CenterLeft"
data1.stringdefs      = {compassnrheight,compassnrwidth, 0, 0}
data1.formats         = {"%s","%s"}
--HDG_output.element_params  = {"NAV_SCRATCHPAD"}
data1.controllers     = {{"datatext",0}} --first index is for element_params (starting with 0) , second for formats ( starting with 0)
data1.additive_alpha  = true
data1.collimated     = false
AddElement(data1)

local data2           = CreateElement "ceStringPoly"
data2.name            = "data2"
data2.material        = FONT_DARKER--"font_NAV"
data2.init_pos        = {charwidth*1,-0} -- -50, -10
data2.alignment       = "CenterLeft"
data2.stringdefs      = {compassnrheight,compassnrwidth, 0, 0}
data2.formats         = {"%s","%s"}
--HDG_output.element_params  = {"NAV_SCRATCHPAD"}
data2.controllers     = {{"datatext",0}} --first index is for element_params (starting with 0) , second for formats ( starting with 0)
data2.additive_alpha  = true
data2.collimated     = false
AddElement(data2)

local data3           = CreateElement "ceStringPoly"
data3.name            = "data3"
data3.material        = FONT_--"font_NAV"
data3.init_pos        = {charwidth*2,-0} -- -50, -10
data3.alignment       = "CenterLeft"
data3.stringdefs      = {compassnrheight,compassnrwidth, 0, 0}
data3.formats         = {"%s","%s"}
--HDG_output.element_params  = {"NAV_SCRATCHPAD"}
data3.controllers     = {{"datatext",0}} --first index is for element_params (starting with 0) , second for formats ( starting with 0)
data3.additive_alpha  = true
data3.collimated     = false
AddElement(data3)

local data4           = CreateElement "ceStringPoly"
data4.name            = "data4"
data4.material        = FONT_--"font_NAV"
data4.init_pos        = {charwidth*3,-0} -- -50, -10
data4.alignment       = "CenterLeft"
data4.stringdefs      = {compassnrheight,compassnrwidth, 0, 0}
data4.formats         = {"%s","%s"}
--HDG_output.element_params  = {"NAV_SCRATCHPAD"}
data4.controllers     = {{"datatext",0}} --first index is for element_params (starting with 0) , second for formats ( starting with 0)
data4.additive_alpha  = true
data4.collimated     = false
AddElement(data4)

local data5           = CreateElement "ceStringPoly"
data5.name            = "data5"
data5.material        = FONT_--"font_NAV"
data5.init_pos        = {charwidth*4,-0} -- -50, -10
data5.alignment       = "CenterLeft"
data5.stringdefs      = {compassnrheight,compassnrwidth, 0, 0}
data5.formats         = {"%s","%s"}
--HDG_output.element_params  = {"NAV_SCRATCHPAD"}
data5.controllers     = {{"datatext",0}} --first index is for element_params (starting with 0) , second for formats ( starting with 0)
data5.additive_alpha  = true
data5.collimated     = false
AddElement(data5)

local data6           = CreateElement "ceStringPoly"
data6.name            = "data6"
data6.material        = FONT_DARKER--"font_NAV"
data6.init_pos        = {charwidth*5,-0} -- -50, -10
data6.alignment       = "CenterLeft"
data6.stringdefs      = {compassnrheight,compassnrwidth, 0, 0}
data6.formats         = {"%s","%s"}
--HDG_output.element_params  = {"NAV_SCRATCHPAD"}
data6.controllers     = {{"datatext",0}} --first index is for element_params (starting with 0) , second for formats ( starting with 0)
data6.additive_alpha  = true
data6.collimated     = false
AddElement(data6)

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

local DIRT_MAT= MakeMaterial(LockOn_Options.script_path.."../resources/IndicationTextures/DataDirt.tga",DIRT_COLOR)

local dirthwidth = 50
local dirtheight = 20

local riktprick_origin	         = CreateElement "ceSimple"
riktprick_origin.name 		     = create_guid_string() -- no such function in this script. Not in definitions.lua either. Could be in elements_defs.lua
riktprick_origin.collimated 		 = true

local datadirt 			= create_textured_box(0,--left texture border
	0,--top most texture border 
	200,--right border
	50,--down border
	nil, -- x coordinate of center object (optional )
	nil  -- y coordinate of center object (optional )
	)
datadirt.name 	= "datadirt"
datadirt.material = DIRT_MAT
datadirt.vertices   = {{-dirthwidth, dirtheight},
				   { dirthwidth, dirtheight},
				   { dirthwidth,-dirtheight},
				   {-dirthwidth,-dirtheight}}
datadirt.controllers = {{"datatext"}}
datadirt.init_pos = {0,0,0}
datadirt.additive_alpha  = true
datadirt.collimated = true
datadirt.parent_element = riktprick_origin.name
--AddElement(datadirt)