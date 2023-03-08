dofile(LockOn_Options.common_script_path.."KNEEBOARD/indicator/definitions.lua")
SetScale(FOV)

local OBJECTS	  = MakeMaterial("Bazar/Textures/AvionicsCommon/kneeboard_indication.tga",MARK_COLOR)
local OBJECTS_RED = MakeMaterial("Bazar/Textures/AvionicsCommon/kneeboard_indication.tga",{255,0,0,255})
local TST     = MakeMaterial(nil,{255,0,255,100})
local FONT_   = MakeFont(FONT_PROTO,MARK_COLOR)
local texture_size = {256,64}

local base_half_element_size = 0.75 * 16/256
local fnt_scale 			 = base_half_element_size / (16/256)
local map_font = {fnt_scale * default_font_defs[1], fnt_scale * default_font_defs[2],0,0}


function box(half_sz)
return {{-half_sz,  half_sz},
	    { half_sz,  half_sz},
	    { half_sz, -half_sz},
		{-half_sz, -half_sz}}
end

function texture_box(UL_X,UL_Y,W,H)
	return  {{UL_X/texture_size[1]	   , UL_Y/texture_size[2]},
			{(UL_X + W)/texture_size[1], UL_Y/texture_size[2]},
			{(UL_X + W)/texture_size[1],(UL_Y + H)/texture_size[2]},
			{ UL_X/texture_size[1]     ,(UL_Y + H)/texture_size[2]}}
end


function element_XYWH(name,X,Y,W,H,mat)

local 	half_sz_x = base_half_element_size * W/40
local 	half_sz_y = base_half_element_size * H/40

local 	element					= CreateElement("ceTexPoly")
		element.name 			= name
		element.material		= mat or OBJECTS
		element.vertices		= {{-half_sz_x,  half_sz_y},
								   { half_sz_x,  half_sz_y},
								   { half_sz_x, -half_sz_y},
								   {-half_sz_x, -half_sz_y}}
		element.indices			= {0,1,2,2,3,0}
		element.use_mipfilter 	= true
		element.tex_coords		= texture_box(X,Y,W,H)
		element.blend_mode 		= blend_mode.IBM_REGULAR_RGB_ONLY
		return element
end

function element_40x40(name,UL_X,UL_Y,mat,sz_correction)
local   sz_correction  = sz_correction or 0
local 	element					= CreateElement("ceTexPoly")
		element.name 			= name
		element.material		= mat or OBJECTS
		element.vertices		= box(base_half_element_size + sz_correction)
		element.indices			= {0,1,2,2,3,0}
		element.use_mipfilter 	= true
		element.tex_coords		= texture_box(UL_X,UL_Y,40,40)
		element.blend_mode 	= blend_mode.IBM_REGULAR_RGB_ONLY
		return element
end

el_steerpoint 					= element_40x40("el_steerpoint",4,4)
el_steerpoint.h_clip_relation   = h_clip_relations.COMPARE
el_steerpoint.level 		    = DEFAULT_LEVEL		
				   
el_steerpoint.controllers		= {{"waypoint_position",GetScale()},
								   {"remove_orientation"}}
Add(el_steerpoint)

el_waypoint_name						= CreateElement "ceStringPoly"
el_waypoint_name.name					= "el_waypoint_name"
el_waypoint_name.alignment				= "LeftCenter"
el_waypoint_name.formats				= {"%s"}
el_waypoint_name.material				= FONT_
el_waypoint_name.stringdefs				= map_font
el_waypoint_name.parent_element			= el_steerpoint.name
el_waypoint_name.use_mipfilter 			= true
el_waypoint_name.init_pos				= {-0.52*base_half_element_size,0.05 * base_half_element_size}
el_waypoint_name.controllers			= {{"waypoint_name",0,0}}
el_waypoint_name.h_clip_relation   		= h_clip_relations.COMPARE
el_waypoint_name.level 		    		= DEFAULT_LEVEL	
el_waypoint_name.blend_mode 			= blend_mode.IBM_REGULAR_RGB_ONLY

Add(el_waypoint_name)

el_waypoint_name2						= CreateElement "ceStringPoly"
el_waypoint_name2.name					= "el_waypoint_name2"
el_waypoint_name2.alignment				= "LeftCenter"
el_waypoint_name2.formats				= {"%s"}
el_waypoint_name2.material				= FONT_
el_waypoint_name2.stringdefs			= map_font
el_waypoint_name2.parent_element		= el_steerpoint.name
el_waypoint_name2.use_mipfilter 		= true
el_waypoint_name2.init_pos				= {base_half_element_size,0}
el_waypoint_name2.controllers			= {{"waypoint_name",0,1}}
el_waypoint_name2.h_clip_relation   	= h_clip_relations.COMPARE
el_waypoint_name2.level 		    	= DEFAULT_LEVEL	
el_waypoint_name2.blend_mode 			= blend_mode.IBM_REGULAR_RGB_ONLY
Add(el_waypoint_name2)
			
el_self_mark_point 					 = element_40x40("el_self_mark_point",204,4)
el_self_mark_point.h_clip_relation   = h_clip_relations.COMPARE
el_self_mark_point.level 		     = DEFAULT_LEVEL		
el_self_mark_point.controllers		= {{"waypoint_position",GetScale()}}
Add(el_self_mark_point)

el_self_mark_point_name 					= Copy(el_waypoint_name)
el_self_mark_point_name.parent_element		= el_self_mark_point.name
el_self_mark_point_name.init_pos			= {0,0}
el_self_mark_point_name.controllers			= {{"waypoint_name",0},{"remove_orientation"},{"move",base_half_element_size * GetScale()}}
Add(el_self_mark_point_name)		


local function circle(radius,mat)
	local verts    = {}
	local inds     = {}
	local count    = 16 
	local delta    = math.rad(360/count)
	verts[1] = {0,0}
	for i=1,count + 1 do
		verts[1 + i]      = { radius * math.sin(delta *(i-1)),radius * math.cos(delta *(i-1)) }
		inds[3*(i-1) + 1] = 0
		inds[3*(i-1) + 2] = i - 1 
		inds[3*(i-1) + 3] = i 
	end
	
	local 	obj					= CreateElement("ceMeshPoly")
			obj.material		= mat or OBJECTS
			obj.vertices        = verts              
			obj.indices         = inds
			obj.blend_mode 		= blend_mode.IBM_REGULAR_RGB_ONLY
	return obj
end

el_steerpoint_2					= circle(0.73 * base_half_element_size,TST)
el_steerpoint_2.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL
el_steerpoint_2.level 		    = DEFAULT_LEVEL	
el_steerpoint_2.parent_element  = el_steerpoint.name			   
el_steerpoint_2.isvisible		= false	
Add(el_steerpoint_2)



el_red_zone					= CreateElement "ceSimpleLineObject"
el_red_zone.name			= "el_red_zone"
el_red_zone.material		= OBJECTS_RED
el_red_zone.width			= 0.025
el_red_zone.offset          = 0.025
el_red_zone.tex_params      = {{0, 55/64}, {1,55/64},{1,(9/64)/0.025}}	
el_red_zone.controllers		= {{"zone_position",GetScale()}}
el_red_zone.level 		    = DEFAULT_LEVEL	
el_red_zone.h_clip_relation = h_clip_relations.COMPARE
el_red_zone.use_mipfilter 	= true
el_red_zone.blend_mode 			= blend_mode.IBM_REGULAR_RGB_ONLY
Add(el_red_zone)


el_red_zone_2				= Copy(el_red_zone)
el_red_zone_2.material		= TST
el_red_zone_2.width			= 0.0025
el_red_zone_2.offset       = 0
Add(el_red_zone_2)

			
el_target_point						= element_XYWH("el_target_point",165,3,203 - 165,38-3,OBJECTS_RED)
el_target_point.h_clip_relation   	= h_clip_relations.COMPARE
el_target_point.level 		     	= DEFAULT_LEVEL		
el_target_point.controllers			= {{"waypoint_position",GetScale()}}
Add(el_target_point)

el_target_point_name 					= Copy(el_waypoint_name)
el_target_point_name.parent_element		= el_target_point_name.name
el_target_point_name.init_pos			= {0,0}
el_target_point_name.controllers		= {{"waypoint_name",0},{"remove_orientation"},{"move",base_half_element_size * GetScale()}}
Add(el_target_point_name)		

