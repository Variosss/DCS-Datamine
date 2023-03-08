dofile(LockOn_Options.script_path.."MFCD/indicator/MFCD_useful_definitions.lua")

------------------------------------------------------------
PATTERN_ALL_WHITE	= 0
PATTERN_RED		= 1
PATTERN_GREEN	= 2
PATTERN_BLUE	= 3
PATTERN_GREY	= 4

box_height = max_pixels_count/8

test_display_white			= CreateElement "ceMeshPoly"
test_display_white.name		= "DISP_TEST_WHITE"
test_display_white.material	= MFCD_CICU_WHITE
test_display_white.primitivetype	= "triangles"
test_display_white.vertices	=  {{-max_pixels_count/2,  max_pixels_count/2},
										 { max_pixels_count/2,  max_pixels_count/2}, 
										 { max_pixels_count/2, -max_pixels_count/2},
										 {-max_pixels_count/2, -max_pixels_count/2}}
test_display_white.indices		= box_ind
test_display_white.controllers	= {{"DISPLAY_TEST_controller",PATTERN_ALL_WHITE}}

Add(test_display_white)
use_mipfilter(test_display_white)


for index = 1,8 do
	red_display_box			= CreateElement "ceMeshPoly"
	red_display_box.name		= "DISP_TEST_BOX_RED"..index
	red_display_box.material	= MFCD_TEST_DISP_RED[index]
	red_display_box.primitivetype	= "triangles"
	red_display_box.vertices	=  {{-max_pixels_count/2,  max_pixels_count/2 - box_height*(index-1)},
									 { max_pixels_count/2,  max_pixels_count/2 - box_height*(index-1)}, 
									 { max_pixels_count/2, 	max_pixels_count/2 - box_height*index},
									 {-max_pixels_count/2,	max_pixels_count/2 - box_height*index}}
	red_display_box.indices		= box_ind
	red_display_box.controllers	= {{"DISPLAY_TEST_controller",PATTERN_RED}}
	
	Add(red_display_box)
	use_mipfilter(red_display_box)
end

for index = 1,8 do
	green_display_box			= CreateElement "ceMeshPoly"
	green_display_box.name		= "DISP_TEST_BOX_GREEN"..index
	green_display_box.material	= MFCD_TEST_DISP_GREEN[index]
	green_display_box.primitivetype	= "triangles"
	green_display_box.vertices	=  {{-max_pixels_count/2,  max_pixels_count/2 - box_height*(index-1)},
									 { max_pixels_count/2,  max_pixels_count/2 - box_height*(index-1)}, 
									 { max_pixels_count/2, 	max_pixels_count/2 - box_height*index},
									 {-max_pixels_count/2,	max_pixels_count/2 - box_height*index}}
	green_display_box.indices		= box_ind
	green_display_box.controllers	= {{"DISPLAY_TEST_controller",PATTERN_GREEN}}

	Add(green_display_box)
	use_mipfilter(green_display_box)
end

for index = 1,8 do
	blue_display_box			= CreateElement "ceMeshPoly"
	blue_display_box.name		= "DISP_TEST_BOX_BLUE"..index
	blue_display_box.material	= MFCD_TEST_DISP_BLUE[index]
	blue_display_box.primitivetype	= "triangles"
	blue_display_box.vertices	=  {{-max_pixels_count/2,  max_pixels_count/2 - box_height*(index-1)},
									 { max_pixels_count/2,  max_pixels_count/2 - box_height*(index-1)}, 
									 { max_pixels_count/2, 	max_pixels_count/2 - box_height*index},
									 {-max_pixels_count/2,	max_pixels_count/2 - box_height*index}}
	blue_display_box.indices		= box_ind
	blue_display_box.controllers	= {{"DISPLAY_TEST_controller",PATTERN_BLUE}}

	Add(blue_display_box)
	use_mipfilter(blue_display_box)
end

for index = 1,8 do
	grey_display_box			= CreateElement "ceMeshPoly"
	grey_display_box.name		= "DISP_TEST_BOX_GREY"..index
	grey_display_box.material	= MFCD_TEST_DISP_GREY[index]
	grey_display_box.primitivetype	= "triangles"
	grey_display_box.vertices	=  {{-max_pixels_count/2,  max_pixels_count/2 - box_height*(index-1)},
									 { max_pixels_count/2,  max_pixels_count/2 - box_height*(index-1)}, 
									 { max_pixels_count/2, 	max_pixels_count/2 - box_height*index},
									 {-max_pixels_count/2,	max_pixels_count/2 - box_height*index}}
	grey_display_box.indices		= box_ind
	grey_display_box.controllers	= {{"DISPLAY_TEST_controller",PATTERN_GREY}}

	Add(grey_display_box)
	use_mipfilter(grey_display_box)
end
