dofile(LockOn_Options.common_script_path.."elements_defs.lua")

PPA_DEFAULT_LEVEL     = 8

SetScale(FOV)

----------- Fonts --------------
PPA_gauge_font   = "PPA_gauge_font"
ppa_font_size_default = {0.007,0.007}
--------------------------------

function Add_PPA_Element(object)
	object.use_mipfilter      = true
	object.h_clip_relation    = h_clip_relations.COMPARE
	object.level			  = PPA_DEFAULT_LEVEL
	object.additive_alpha     = true
	object.collimated 		  = false
	Add(object)
end

