dofile(LockOn_Options.common_script_path.."elements_defs.lua")

FUEL_DEFAULT_LEVEL     = 8

SetScale(FOV)



fuel_gauge_font		 = "fuel_gauge_font"
fg_font_size_default = {0.007,0.007}

function Add_FUEL_Element(object)
	object.use_mipfilter      = true
	object.h_clip_relation    = h_clip_relations.COMPARE
	object.level			  = FUEL_DEFAULT_LEVEL
	object.additive_alpha     = true
	object.collimated 		  = false
	Add(object)
end

