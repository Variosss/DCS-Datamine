dofile(LockOn_Options.common_script_path.."elements_defs.lua")

AOA_DEFAULT_LEVEL     = 12

SetScale(METERS)

function Add_COM_Element(object)
	object.use_mipfilter      = true
	object.h_clip_relation    = h_clip_relations.COMPARE
	object.level			  = AOA_DEFAULT_LEVEL
	object.additive_alpha     = false
	object.collimated 		  = false
	Add(object)
end