dofile(LockOn_Options.script_path.."../../Mirage-F1/Mirage-F1_Common/SightSystem/Indicator/SightSystem_definitions.lua")

--SetScale(METERS)
local displayGlassDbg 					= false

local glass_angle 						= -38.85 --degrees
local glass_angle_stretch_K 			= math.cos(math.rad(glass_angle)) * 0.97
local glass_depth_correction 			= 0.0065
local projection_radius 				= 0.07 -- meters
local vertical_shift 					= 0.028 -- meters

local area_mask_side 					= projection_radius + 0.001
local lower_mask_vertical_shift 		= -0.082
local upper_mask_vertical_shift 		= 0.074

local num_of_segments    				= 32

local sight_projection_area		  	  = CreateElement "ceMeshPoly"
sight_projection_area.name 			  = "sight_projection_area"
sight_projection_area.material		  = "MASK_MATERIAL"
sight_projection_area.h_clip_relation = h_clip_relations.REWRITE_LEVEL
sight_projection_area.level			  = INDICATOR_DEFAULT_LEVEL - 1 
sight_projection_area.collimated	  = false
sight_projection_area.isvisible		  = displayGlassDbg

sight_projection_area.init_pos		  = {0, vertical_shift * math.cos(math.rad(glass_angle)), glass_depth_correction + vertical_shift * math.sin(math.rad(glass_angle))}
sight_projection_area.init_rot		  = {0, 0, glass_angle}

sight_projection_area.vertices        = makeEllipseVerts(num_of_segments, projection_radius, glass_angle_stretch_K)             
sight_projection_area.indices         = buildConvexPolyIndices(num_of_segments)

Add(sight_projection_area)

local proj_area_mask_lower		  	  = CreateElement "ceMeshPoly"
proj_area_mask_lower.name 			  = "proj_area_mask_lower"
proj_area_mask_lower.material		  = "DBG_BLUE" --"MASK_MATERIAL"
proj_area_mask_lower.h_clip_relation  = h_clip_relations.DECREASE_IF_LEVEL
proj_area_mask_lower.level			  = INDICATOR_DEFAULT_LEVEL - 1 
proj_area_mask_lower.collimated	  	  = false
proj_area_mask_lower.isvisible		  = displayGlassDbg

proj_area_mask_lower.init_pos		  = {0, (lower_mask_vertical_shift + vertical_shift) * math.cos(math.rad(glass_angle)), glass_depth_correction + (lower_mask_vertical_shift + vertical_shift) * math.sin(math.rad(glass_angle))}
proj_area_mask_lower.init_rot		  = {0, 0, glass_angle}

proj_area_mask_lower.vertices         = {{-area_mask_side, -area_mask_side / glass_angle_stretch_K}, { -area_mask_side, 0}, { area_mask_side, 0}, {area_mask_side, -area_mask_side / glass_angle_stretch_K}}
proj_area_mask_lower.indices          = default_box_indices

Add(proj_area_mask_lower)


local proj_area_mask_upper		  	  = Copy(proj_area_mask_lower)
proj_area_mask_upper.name		  	  = "proj_area_mask_upper"
proj_area_mask_upper.init_pos		  = {0, (upper_mask_vertical_shift + vertical_shift) * math.cos(math.rad(glass_angle)), glass_depth_correction + (upper_mask_vertical_shift + vertical_shift) * math.sin(math.rad(glass_angle))}

proj_area_mask_upper.vertices         = {{-area_mask_side, 0}, { -area_mask_side, area_mask_side / glass_angle_stretch_K}, { area_mask_side, area_mask_side / glass_angle_stretch_K}, {area_mask_side, 0}}

Add(proj_area_mask_upper)
