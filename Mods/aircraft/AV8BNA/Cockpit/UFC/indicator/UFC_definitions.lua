dofile(LockOn_Options.common_script_path.."elements_defs.lua")

UFC_DEFAULT_LEVEL     = 5

SetScale(FOV)

ufc_scale		= 0.55/275
ufc_grid_scale	= 0.50/275
ufc_hdg_scale	= 0.70/275
ufc_hdg_displ	= (3448 * ufc_hdg_scale / 480) * GetScale()

---- Fonts Definition ----
local resources_path_f = LockOn_Options.script_path.."Resources/Fonts/"

UFC_default_numeric_font_size	= {0.01, 0.01, -0.0045, 0.0}
UFC_default_string_font_size	= {0.01, 0.01, -0.0005, 0.0}
RADIO_default_font_size			= {0.012, 0.012}

ufc_font_base	= "ufc_font_base"

----- UFC Functions -----
function Add_UFC_Element(object)
	object.use_mipfilter      = true
	object.h_clip_relation    = h_clip_relations.COMPARE
	object.level			  = UFC_DEFAULT_LEVEL
	object.additive_alpha     = true --additive blending
	object.collimated 		  = false
	Add(object)
end
