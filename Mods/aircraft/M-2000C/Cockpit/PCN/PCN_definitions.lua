dofile(LockOn_Options.common_script_path.."elements_defs.lua")

PCN_DEFAULT_LEVEL     = 8

SetScale(FOV)

----------- Fonts --------------
pcn_gauge_font			= "pcn_gauge_font"
pcn_font_size_default	= {0.0095,0.0095}
--------------------------------

function Add_PCN_Element(object)
	object.use_mipfilter      = true
	object.h_clip_relation    = h_clip_relations.COMPARE
	object.level			  = PCN_DEFAULT_LEVEL
	object.additive_alpha     = true
	object.collimated 		  = false
	Add(object)
end

