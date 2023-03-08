dofile(LockOn_Options.common_script_path.."elements_defs.lua")

ODU_DEFAULT_LEVEL     = 5

SetScale(FOV)

odu_scale		= 0.55/275
odu_grid_scale	= 0.50/275
odu_hdg_scale	= 0.70/275
odu_hdg_displ	= (3448 * odu_hdg_scale / 480) * GetScale()

symbol_pixels_x =  44.0 * 2 -- pi
symbol_pixels_y =  72.0 * 2

--- Colors Definitions ---

ODU_GREEN	= {0, 255, 100, 255}

---- Fonts Definition ----
local resources_path_f = LockOn_Options.script_path.."Resources/Fonts/"

ODU_default_font_size    = {0.010, 0.010}

odu_font_base	= "ufc_font_base"


----- ODU Functions -----
function Add_ODU_Element(object)
	object.use_mipfilter      = true
	object.h_clip_relation    = h_clip_relations.COMPARE
	object.level			  = ODU_DEFAULT_LEVEL
	object.additive_alpha     = true --additive blending
	object.collimated 		  = false
	Add(object)
end
