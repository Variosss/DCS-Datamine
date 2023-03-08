dofile(LockOn_Options.common_script_path.."elements_defs.lua")

PCA_DEFAULT_LEVEL     = 8

SetScale(FOV)

----------- Fonts --------------
-- 0.010 , 0.010
pca_gauge_font			= "pca_gauge_font"
pca_font_size_default	= {0.0105,0.0098} 
--------------------------------

function Add_PCA_Element(object)
	object.use_mipfilter      = true
	object.h_clip_relation    = h_clip_relations.COMPARE
	object.level			  = PCA_DEFAULT_LEVEL
	object.additive_alpha     = true
	object.collimated 		  = false
	Add(object)
end

