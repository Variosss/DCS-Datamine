dofile(LockOn_Options.common_script_path.."KNEEBOARD/indicator/definitions.lua")

SetScale(FOV)

local fnt_proto = {class  = "ceUITTF",  ttf = "DejaVuLGCSansMono-Bold.ttf" , size = 17}   -- {used_DXUnicodeFontData = "font_dejavu_lgc_sans_22"}
font_header_kneeboard				= MakeFont(fnt_proto, {  0,   0, 255, 255})
font_label_kneeboard				= MakeFont(fnt_proto, {  0,   0,   0, 255})
font_value_kneeboard				= MakeFont(fnt_proto, {255,   0,   0, 255})
