dofile(LockOn_Options.common_script_path.."elements_defs.lua")

COM_DEFAULT_LEVEL     = 8

SetScale(FOV)

COM_gauge_font			= "COM_gauge_font"
COM_greenbox_font		= "COM_greenbox_font"
COM_font_size_default	= {0.007,0.007}

function Add_COM_Element(object)
	object.use_mipfilter      = true
	object.h_clip_relation    = h_clip_relations.COMPARE
	object.level			  = COM_DEFAULT_LEVEL
	object.additive_alpha     = true
	object.collimated 		  = false
	Add(object)
end