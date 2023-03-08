dofile(LockOn_Options.script_path.."ASP17V/Indicator/ASP_17V_definitions.lua")
dofile(LockOn_Options.common_script_path.."elements_defs.lua")


--drawIndicatorRefGrid(17, 10, 260, true, 170)

tex_scale = 1.0 / 1024.0
local scale = 3.22--3.15 соотв.размеру 49тыс при заданных 50тыс

local upY = 168 / scale
local downY = 342 / scale
local leftX = 506.0 / 2.0 / scale


AddHUD_ASP17_FLEXSIGHTTexElement("asp17_grid", 
				{{-leftX, -downY}, {-leftX, upY}, 
				{leftX, upY}, {leftX, -downY}},
				{tex_scale * 768, tex_scale * 683, tex_scale * scale, tex_scale * scale},
				{{"SightBrightness", 0}},
				{0.0, 0.0, 0.0},
				{0.0, 0.0, 0.0},
				nil,
				HUD_DEFAULT_LEVEL)

local scale = 7.0
local upY = 6 / scale

local	flex_sight = AddHUD_ASP17_FLEXSIGHTTexElement("FlexCross", 
				{{-upY, -upY}, {-upY, upY}, 
				{upY, upY}, {upY, -upY}},
				{tex_scale * 768, tex_scale * 683, tex_scale * scale, tex_scale * scale},
				{{"SightBrightness", 1}, {"FlexSight_Pos"}},
				{0.0, 0.0, 0.0},
				{0.0, 0.0, 0.0},
				nil,
				HUD_DEFAULT_LEVEL)		


scale = 4.5
		
local leftY = 7 / scale				
local leftUp = 200 / scale				
local	roll_pointer = AddHUD_ASP17_FLEXSIGHTTexElement("RollPointer", 
				{{-leftY, 0.0}, {-leftY, leftUp}, 
				{leftY, leftUp}, {leftY, 0.0}},
				{tex_scale * 35, tex_scale * 207, tex_scale * scale, tex_scale * scale},
				{{"SightBrightness", 1}, {"RollPointer"}},
				{0.0, 0.0, 0.0},
				{0.0, 0.0, 0.0},
				"FlexCross",
				HUD_DEFAULT_LEVEL)		


local upY = 4 / scale
local leftX = 1.0 / scale
local rightX = 181.0 / scale

local	Line			= CreateElement("ceHWLine")
Line.name				= "FlexCrossLine1"
Line.vertices			= {{-leftX, -upY}, {-leftX, upY},
						   {rightX, upY}, {rightX, -upY}}
Line.maskvertices		= {{0, -upY}, {0,upY},
						   {rightX, upY}, {rightX, -upY}}
Line.indices			= default_box_indices
Line.maxlength			= 40.8
Line.length				= 40.8
Line.material			= "INDICATION_ASP17_FLEX"
Line.tex_params			= {tex_scale * 16, tex_scale * 496.5, tex_scale * scale, tex_scale * scale}
Line.init_pos			= {-43.7, 0.0, 0.0}
Line.init_rot			= {0.0, 0.0, 0.0}
Line.controllers    	= {{"SightBrightness", 1}, {"FlexSight_Base", tex_scale * scale}}
Line.parent_element		= "FlexCross"
Line.isdraw				= true
Line.h_clip_relation	= h_clip_relations.COMPARE
Line.level				= HUD_DEFAULT_LEVEL
Line.additive_alpha		= true
Line.collimated			= true
Line.use_mipfilter		= true
Line.z_enabled 			= false
Add(Line)

local Line2    			= Copy(Line)
Line2.name				= "FlexCrossLine2"
Line2.init_pos			= {0.0, -43.7, 0.0}
Line2.init_rot			= {90.0, 0.0, 0.0}
Add(Line2)

local Line3    			= Copy(Line)
Line3.name				= "FlexCrossLine3"
Line3.init_pos			= {0.0, 43.7, 0.0}
Line3.init_rot			= {-90.0, 0.0, 0.0}
Add(Line3)

local Line4    			= Copy(Line)
Line4.name				= "FlexCrossLine4"
Line4.init_pos			= {43.7, 0.0, 0.0}
Line4.init_rot			= {180.0, 0.0, 0.0}
Add(Line4)



distance_border                 = CreateElement "ceMeshPoly"
distance_border.name            = "distance_border"
distance_border.primitivetype   = "triangles"
distance_border.vertices        = {{-20.0, 0.0}, {60.0, 0.0}, {60.0, -60.0}, {-20.0, -60.0}}
distance_border.indices         = default_box_indices
distance_border.parent_element  = "FlexCross"
distance_border.material        = "GREEN_2"
distance_border.init_rot		= {-16.0, 0.0, 0.0}
distance_border.controllers    	= {{"SightBrightness", 1},{"FlexSight_Distance"}}
distance_border.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL
distance_border.level			= HUD_DEFAULT_LEVEL
distance_border.isdraw          = true
distance_border.isvisible       = false
Add(distance_border)

scale = 3.48
local left = 4 / scale
local right = 170 / scale
local up = 170 / scale
local down = 46 / scale
local	distance_sector = AddHUD_ASP17_FLEXSIGHTTexElement("Distance_Sector", 
				{{-left, -down}, {-left, up}, 
				{right, up}, {right, -down}},
				{tex_scale * 56, tex_scale * 171, tex_scale * scale, tex_scale * scale},
				{{"SightBrightness", 1}},
				{0.0, 0.0, 0.0},
				{0.0, 0.0, 0.0},
				"FlexCross",
				HUD_DEFAULT_LEVEL)		

scale = 3.36
local radius = 183.0 / scale

effective_distance_sector					= CreateElement "ceHWSector"
effective_distance_sector.name				=  "effective_distance_sector"
effective_distance_sector.vertices1			= {{-0.0/ scale, -radius}, {-0.0/ scale, radius}, {radius, radius}, {radius, -radius}}
effective_distance_sector.tex_params1		= {tex_scale * 423, tex_scale * 170, tex_scale * scale, tex_scale * scale}
effective_distance_sector.vertices2			= {{-radius, -radius}, {-radius, radius}, {0.0/ scale, radius}, {0.0/ scale, -radius}}
effective_distance_sector.tex_params2		= {tex_scale * 423, tex_scale * 171, tex_scale * scale, tex_scale * scale}
effective_distance_sector.maskvertices		= {{-radius, -radius}, {-radius, radius}, 
														{0.0, radius}, {0.0, -radius}}
effective_distance_sector.indices			= default_box_indices
effective_distance_sector.material			= "INDICATION_ASP17_FLEX"
effective_distance_sector.controllers    	= {{"SightBrightness", 1}, {"FlexSight_Effective_Dist"}}
effective_distance_sector.parent_element	= "FlexCross"
effective_distance_sector.h_clip_relation	= h_clip_relations.COMPARE
effective_distance_sector.level				= HUD_DEFAULT_LEVEL
effective_distance_sector.minangle			= math.rad(0.0)
effective_distance_sector.maxangle			= math.rad(360.0)
effective_distance_sector.angle				= math.rad(0.0)
effective_distance_sector.init_pos			= {0.0, 0.0, 0.0}
effective_distance_sector.init_rot			= {0.0, 0.0, 0.0}
effective_distance_sector.additive_alpha	= true
effective_distance_sector.collimated		= true
Add(effective_distance_sector)
