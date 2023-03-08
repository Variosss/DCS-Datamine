dofile(LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_useful_definitions.lua")

--AddBackground()

AddRT()

AddTextLabel("TEST MODE", "LeftTop", 6, max_pixels_count_y, predefined_fonts[1], "font_ARC210_small")

bar_width	= 100
bar_height	= 22
side_width	= 2
bottom_pos	= 4
top_pos		= bottom_pos+bar_height
right_pos	= max_pixels_count_x/2+bar_width/2
left_pos	= max_pixels_count_x/2-bar_width/2

border_bottom				= CreateElement "ceMeshPoly"
border_bottom.name			= "border_bottom"
border_bottom.material		= "ARC210_GREEN"
border_bottom.primitivetype	= "triangles"
border_bottom.vertices		= {{right_pos, bottom_pos},
								{left_pos, bottom_pos},
								{left_pos, bottom_pos-side_width},
								{right_pos, bottom_pos-side_width},
								{right_pos, bottom_pos}}
border_bottom.indices		= box_ind
SetLowerLeftCornerOrigin(border_bottom)
Add(border_bottom)
use_mipfilter(border_bottom)

local border_top = Copy(border_bottom)
border_top.name              = "border_top"
border_top.vertices		= {{right_pos, top_pos+side_width},
								{left_pos, top_pos+side_width},
								{left_pos, top_pos},
								{right_pos, top_pos},
								{right_pos, top_pos+side_width}}
Add(border_top)
use_mipfilter(border_top)


local border_left = Copy(border_bottom)
border_left.name              = "border_left"
border_left.vertices		= {{left_pos-side_width, top_pos+side_width},
								{left_pos, top_pos+side_width},
								{left_pos, bottom_pos-side_width},
								{left_pos-side_width, bottom_pos-side_width},
								{left_pos-side_width, top_pos+side_width}}
Add(border_left)
use_mipfilter(border_left)

local border_right = Copy(border_left)
border_right.name              = "border_right"
border_right.vertices		= {{right_pos, top_pos+side_width},
								{right_pos+side_width, top_pos+side_width},
								{right_pos+side_width, bottom_pos-side_width},
								{right_pos, bottom_pos-side_width},
								{right_pos, top_pos+side_width}}
Add(border_right)
use_mipfilter(border_right)


texture_scale = 1 / 570

--test_time     = 5
test_time     = 32

progres_bar						= CreateElement "ceHWLine"
progres_bar.name				= "progres_bar"
progres_bar.vertices			= {{-0.6, -bar_height/2}, {-0.6, bar_height/2}, {bar_width, bar_height/2}, {bar_width, -bar_height/2}}
progres_bar.maskvertices		= {{0.0, -bar_height/2}, {0.0, bar_height/2}, {bar_width, bar_height/2}, {bar_width, -bar_height/2}}
progres_bar.indices				= box_ind
progres_bar.init_pos			= {left_pos-1, bottom_pos+bar_height/2, 0}
--progres_bar.init_rot				= {-90, 0, 0}
progres_bar.length				= bar_width+2
progres_bar.maxlength			= bar_width+2
progres_bar.material			= "ARC210_GREEN"
progres_bar.tex_params			= {2 / 512, 399.734 / 512, texture_scale * 3, texture_scale * 1.5}
--progres_bar.parent_element		=  scroll_bar_base.name
--	if BarController ~= nil then
progres_bar.controllers			= {{"test_progres_bar", 0, bar_width+2, test_time}}
--	end
SetLowerLeftCornerOrigin(progres_bar)
Add(progres_bar)
use_mipfilter(progres_bar)

AddTextLabel("GO", "RightTop", max_pixels_count_x-3, max_pixels_count_y-20, predefined_fonts[2], "font_ARC210_big", {{"test_finished", test_time}})
