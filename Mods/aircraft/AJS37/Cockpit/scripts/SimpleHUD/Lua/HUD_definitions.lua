dofile(LockOn_Options.common_script_path.."elements_defs.lua")

GLASS_LEVEL  	  	  = 8   -- need to be mathed with declared in HUD_glass.lua
HUD_DEFAULT_LEVEL     = GLASS_LEVEL + 1  

--all vertices in files who include this file will be scaled in millyradians
SetScale(MILLYRADIANS)



-- we will use hud texture from Ka-50 as sample
indicaton_material = MakeMaterial("Mods/aircrafts/Ka-50/Cockpit/Resources/IndicationTextures/Indication_hud_ka-50.tga",{0,255,255,255})

symbol_pixels_x =   44 * 2 -- pi
symbol_pixels_y =  72.0 * 2
local font_desc = {
	texture     = "Mods/aircrafts/A-10C/Cockpit/Resources/IndicationTextures/font_HUD_A10.tga",
	size        = {7, 7},
	resolution  = {1024, 1024},
	default     = {symbol_pixels_x, symbol_pixels_y},
	chars	    = {
		 
		 [1]   = {32, symbol_pixels_x, symbol_pixels_y}, -- [space]
		 [2]   = {42, symbol_pixels_x, symbol_pixels_y}, -- *
		 [3]   = {43, symbol_pixels_x, symbol_pixels_y}, -- +
		 [4]   = {45, symbol_pixels_x, symbol_pixels_y}, -- -
		 [5]   = {46, symbol_pixels_x, symbol_pixels_y}, -- .
		 [6]   = {47, symbol_pixels_x, symbol_pixels_y}, -- /
		 [7]   = {48, symbol_pixels_x, symbol_pixels_y}, -- 0
		 [8]   = {49, symbol_pixels_x, symbol_pixels_y}, -- 1
		 [9]   = {50, symbol_pixels_x, symbol_pixels_y}, -- 2
		 [10]  = {51, symbol_pixels_x, symbol_pixels_y}, -- 3
		 [11]  = {52, symbol_pixels_x, symbol_pixels_y}, -- 4
		 [12]  = {53, symbol_pixels_x, symbol_pixels_y}, -- 5
		 [13]  = {54, symbol_pixels_x, symbol_pixels_y}, -- 6
		 [14]  = {55, symbol_pixels_x, symbol_pixels_y}, -- 7
		 [15]  = {56, symbol_pixels_x, symbol_pixels_y}, -- 8
		 [16]  = {57, symbol_pixels_x, symbol_pixels_y}, -- 9
		 [17]  = {58, symbol_pixels_x, symbol_pixels_y}, -- :
		 [18]  = {65, symbol_pixels_x, symbol_pixels_y}, -- A
		 [19]  = {66, symbol_pixels_x, symbol_pixels_y}, -- B
		 [20]  = {67, symbol_pixels_x, symbol_pixels_y}, -- C
		 [21]  = {68, symbol_pixels_x, symbol_pixels_y}, -- D
		 [22]  = {69, symbol_pixels_x, symbol_pixels_y}, -- E
		 [23]  = {70, symbol_pixels_x, symbol_pixels_y}, -- F
		 [24]  = {71, symbol_pixels_x, symbol_pixels_y}, -- G
		 [25]  = {72, symbol_pixels_x, symbol_pixels_y}, -- H
		 [26]  = {73, symbol_pixels_x, symbol_pixels_y}, -- I
		 [27]  = {74, symbol_pixels_x, symbol_pixels_y}, -- J
		 [28]  = {75, symbol_pixels_x, symbol_pixels_y}, -- K
		 [29]  = {76, symbol_pixels_x, symbol_pixels_y}, -- L
		 [30]  = {77, symbol_pixels_x, symbol_pixels_y}, -- M
		 [31]  = {78, symbol_pixels_x, symbol_pixels_y}, -- N
		 [32]  = {79, symbol_pixels_x, symbol_pixels_y}, -- O
		 [33]  = {80, symbol_pixels_x, symbol_pixels_y}, -- P
		 [34]  = {81, symbol_pixels_x, symbol_pixels_y}, -- Q
		 [35]  = {82, symbol_pixels_x, symbol_pixels_y}, -- R
		 [36]  = {83, symbol_pixels_x, symbol_pixels_y}, -- S
		 [37]  = {84, symbol_pixels_x, symbol_pixels_y}, -- T
		 [38]  = {85, symbol_pixels_x, symbol_pixels_y}, -- U
		 [39]  = {86, symbol_pixels_x, symbol_pixels_y}, -- V
		 [40]  = {87, symbol_pixels_x, symbol_pixels_y}, -- W
		 [41]  = {88, symbol_pixels_x, symbol_pixels_y}, -- X
		 [42]  = {89, symbol_pixels_x, symbol_pixels_y}, -- Y
		 [43]  = {90, symbol_pixels_x, symbol_pixels_y}, -- Z
		 [44]  = {91, symbol_pixels_x, symbol_pixels_y}, -- [
		 [45]  = {93, symbol_pixels_x, symbol_pixels_y}, -- ]
		 [46]  = {62, symbol_pixels_x, symbol_pixels_y}, -- >
		 [47]  = {111, symbol_pixels_x, symbol_pixels_y}, -- o
		 [48]  = {94 ,  symbol_pixels_x, symbol_pixels_y}} -- ^
}


indication_font   = MakeFont(font_desc,{0,255,255,255},"indication_font")
font_size_default = {0.005,0.005}



--texture size is 1024 x 1024

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



--all object passed to this function will be collimated and cliped by FOV and HUD Glass 
function AddHUDElement(object)
	object.use_mipfilter      = true
	object.h_clip_relation    = h_clip_relations.COMPARE  
	object.level			  = HUD_DEFAULT_LEVEL
	object.additive_alpha     = true --additive blending 
	object.collimated 		  = true
	Add(object)
end


