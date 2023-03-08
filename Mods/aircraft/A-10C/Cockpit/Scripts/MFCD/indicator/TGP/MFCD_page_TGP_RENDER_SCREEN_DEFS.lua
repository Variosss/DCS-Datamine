use_screen_space = false

geom_k = max_pixels_count/2
scale  = GetScale()

if use_screen_space then
	scale  = 1
	geom_k = 1
end

rendered_line_width  = 0.006 * geom_k
rendered_material    = MFCD_SOLID_GREY_2

