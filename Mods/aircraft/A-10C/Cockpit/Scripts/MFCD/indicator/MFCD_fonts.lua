
--[[
•	F1: FreeType-Crystal-Medium-R-Normal--18-150-81-86-P-48-ISO10646-1, Bitmap size (pixels) 8x13
•	F2: FreeType-Crystal-Medium-R-Normal--24-200-81-86-P-66-ISO10646-1, Bitmap size (pixels) 12x20
•	F3: FreeType-Crystal-Medium-R-Normal--35-290-81-86-P-90-ISO10646-1, Bitmap size (pixels) 16x26
•	F4: FreeType-Crystal-Medium-R-Normal--44-370-81-86-P-117-ISO10646-1, Bitmap size (pixels) 20x33
•	F5: FreeType-Crystal-Medium-R-Normal--51-430-81-86-P-141-ISO10646-1, Bitmap size (pixels) 24x40
--]]

dofile(LockOn_Options.script_path.."fonts.lua")

function get_desc_2(desc_1,needed_size_x)
    local  font_aspect        = MFCD_ysize/MFCD_xsize
    local  y = desc_1/new_scale
    return desc_1 * (font_aspect * needed_size_x) / y
end

function get_mfcd_size_of_chars(desc)
    local  font_aspect        = MFCD_ysize/MFCD_xsize
    local  y = desc[1]/new_scale
    local  x = y /((desc[1]/desc[2]) * font_aspect)
    return x,y
end


local font_scale = new_scale * 1.8
local font_horiz_spacing = 0.0
local font_vert_spacing  = 0.0

font_horiz_spacing = font_horiz_spacing / font_scale
font_vert_spacing  = font_vert_spacing / font_scale

fonts_sizes = {}

for i = 1, 5 do
	fonts_sizes[i] = {}
end

fonts_sizes[1] = {8 ,13}
fonts_sizes[2] = {12,20}
fonts_sizes[3] = {16,26}
fonts_sizes[4] = {20,33}
fonts_sizes[5] = {24,40}

predefined_fonts = {}
predefined_fonts[1] = {fonts_sizes[1][2] * font_scale, 0.8 * fonts_sizes[1][2] * font_scale, font_horiz_spacing * font_scale, font_vert_spacing * font_scale}
predefined_fonts[2] = {fonts_sizes[2][2] * font_scale, 		 fonts_sizes[2][2] * font_scale, font_horiz_spacing * font_scale, font_vert_spacing * font_scale}
predefined_fonts[3] = {fonts_sizes[3][2] * font_scale, 		 fonts_sizes[3][2] * font_scale, font_horiz_spacing * font_scale, font_vert_spacing * font_scale}
predefined_fonts[4] = {fonts_sizes[4][2] * font_scale, 		 fonts_sizes[4][2] * font_scale, font_horiz_spacing * font_scale, -0.0008  + font_vert_spacing * font_scale}
predefined_fonts[5] = {fonts_sizes[5][2] * font_scale, 		 fonts_sizes[5][2] * font_scale, font_horiz_spacing * font_scale, font_vert_spacing * font_scale}


needed_font_1_x = (569 - 60) * 0.779220779 / 36 

predefined_fonts[1][2] = get_desc_2(predefined_fonts[1][1],needed_font_1_x)
--dbg_print(string.format("font 1 aspect %f\n",predefined_fonts[1][2]/predefined_fonts[1][1]))
txt_labels_font 	=  predefined_fonts[1]
txt_CDU_font 		= {fonts_sizes[3][2] * font_scale, 		  fonts_sizes[3][2] * font_scale		, font_horiz_spacing * font_scale - 0.0002	, font_vert_spacing * font_scale - 0.00101}
txt_Warnings1 		= {fonts_sizes[4][2] * font_scale * 0.9,  fonts_sizes[4][2] * font_scale * 0.9	, font_horiz_spacing * font_scale			, font_vert_spacing * font_scale}
txt_Advisories_font = {fonts_sizes[4][2] * font_scale * 0.82, fonts_sizes[4][2] * font_scale * 0.82	, font_horiz_spacing * font_scale			, font_vert_spacing * font_scale}

txt_font_2_1 = {fonts_sizes[2][2] * font_scale * 1.1,
                fonts_sizes[2][2] * font_scale * 1.1,
                font_horiz_spacing * font_scale,
                font_vert_spacing * font_scale}

txt_smallest_font = {}
txt_smallest_font[1] = 0.8 * txt_labels_font[1]
txt_smallest_font[2] = 0.8 * txt_labels_font[2]
txt_smallest_font[3] = txt_labels_font[3]
txt_smallest_font[4] = txt_labels_font[4]


 




font_1_x, font_1_y = get_mfcd_size_of_chars(txt_labels_font) -- 10.6

--font_1_y          = txt_labels_font[2]/new_scale
