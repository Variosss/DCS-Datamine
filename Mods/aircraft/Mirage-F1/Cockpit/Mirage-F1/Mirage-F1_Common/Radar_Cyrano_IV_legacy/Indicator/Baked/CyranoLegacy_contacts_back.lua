dofile(LockOn_Options.script_path.."../../Mirage-F1/Mirage-F1_Common/Radar_Cyrano_IV_legacy/Indicator/CyranoLegacy_definitions.lua")
dofile(LockOn_Options.script_path.."../../Mirage-F1/Mirage-F1_Common/Radar_Cyrano_IV_legacy/Indicator/Baked/CyranoLegacy_bake_config.lua")

do
	local verts = {{-display_area_radius, -display_area_radius},
	   { display_area_radius, -display_area_radius},
	   { display_area_radius, display_area_radius},
	   {-display_area_radius, display_area_radius}}
	
	local radar_contacts_area_mask		  	  	= CreateElement "ceMeshPoly"
	radar_contacts_area_mask.collimated	  		= false
	radar_contacts_area_mask.vertices        	= verts
	radar_contacts_area_mask.indices         	= default_box_indices
	radar_contacts_area_mask.name 			  	= "radar_contacts_area_mask"
	radar_contacts_area_mask.material		  	= "MASK_MATERIAL"
	radar_contacts_area_mask.h_clip_relation 	= h_clip_relations.REWRITE_LEVEL
	radar_contacts_area_mask.level			  	= INDICATOR_DEFAULT_LEVEL
	radar_contacts_area_mask.isvisible		  	= false
	Add(radar_contacts_area_mask)
end

--drawIndicatorRefGrid(5, 1, 10, false)
