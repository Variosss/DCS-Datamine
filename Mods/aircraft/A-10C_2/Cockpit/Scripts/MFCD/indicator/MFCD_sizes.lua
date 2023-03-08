max_pixels_count = 569
size_k    		 = 0.97

x_size    = GetScale() * size_k -- half_width
new_scale = 2 * x_size / max_pixels_count

DSMS_StringHeight = 24
DSMS_InitPosY = max_pixels_count-515

texture_scale = 1 / 570

OSB_symbol_spacing   = 20

OSB_symbol_spacing_y = 1.19 * OSB_symbol_spacing
-- NOTE: unnecessary space was there between a symbol and a label
OSB_label_spacing = 5.0 --7.0



fov_scale = 1 --GetScale()

