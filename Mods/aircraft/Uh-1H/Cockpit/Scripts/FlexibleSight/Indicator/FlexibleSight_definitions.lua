dofile(LockOn_Options.common_script_path.."elements_defs.lua")
dofile(LockOn_Options.script_path.."FlexibleSight/device/FlexibleSight_param.lua")

TFOV    = 120
ZSL		= 0

SetScale(MILLYRADIANS)

HUD_DEFAULT_LEVEL = 2
HUD_NOCLIP_LEVEL = HUD_DEFAULT_LEVEL - 1

use_mipfilter	= true


function AddHUDFLEXSIGHTTexElement(name, vertices, tex_params, controllers, init_pos, init_rot, parent, level)
local 	element				= CreateElement "ceTexPoly"
	element.indices			= default_box_indices
	element.material		= "INDICATION_FLEXSIGHT"
	
	element.name			= name
	element.vertices		= vertices
	element.tex_params 		= tex_params 
	
	if controllers ~= nil then
		element.controllers	= controllers
	end
	
	element.init_pos		= init_pos
	element.init_rot		= init_rot

	element.isdraw			= false	
	if parent ~= nil then
		element.parent_element	= parent
		element.isdraw			= true
	end
	
	element.h_clip_relation	= h_clip_relations.COMPARE
	element.level			= level
	
	element.additive_alpha	= true
	element.collimated		= true

	
	element.use_mipfilter	= use_mipfilter
	element.z_enabled 		= false
	Add(element)

	return element

end