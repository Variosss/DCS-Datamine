dofile(LockOn_Options.common_script_path.."elements_defs.lua")
dofile(LockOn_Options.script_path.."../../Mirage-F1/Mirage-F1_Common/Radar_Cyrano_IV_legacy/Radar_Cyrano_IV_legacy_scales.lua")
dofile(LockOn_Options.script_path.."../../Common/symbology_generic_tools.lua")

INDICATOR_DEFAULT_LEVEL 			= 5
dbg_marker_span						= 1 -- centimeters

-- texture resolution			
texture_resolution 					= 512
 
-- pixels per 1 centimeter
pixelsPerUnit 						= 47

function add_rdr_area(radius, num_of_segments, ellipse_k)
	local area		  	  					= CreateElement "ceMeshPoly"
	area.collimated	  						= false
	area.vertices        					= makeEllipseVerts(num_of_segments, radius, ellipse_k)
	area.indices 							= buildConvexPolyIndices(num_of_segments)
	
	return area
end

function addDisplayMask(name)
	local radar_display_area_mask				= add_rdr_area(display_area_radius, 64)
	radar_display_area_mask.name 			  	= name
	radar_display_area_mask.material		  	= "MASK_MATERIAL"
	radar_display_area_mask.h_clip_relation 	= h_clip_relations.REWRITE_LEVEL
	radar_display_area_mask.level			  	= INDICATOR_DEFAULT_LEVEL
	radar_display_area_mask.isvisible		  	= false
	Add(radar_display_area_mask)
end
