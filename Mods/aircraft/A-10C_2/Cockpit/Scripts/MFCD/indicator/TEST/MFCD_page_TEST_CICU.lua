dofile(LockOn_Options.script_path.."MFCD/indicator/STAT/MFCD_STAT_definitions.lua")

function display_background (name, color)
	test_display_white			= CreateElement "ceMeshPoly"
	test_display_white.name		= "bkgr"..name
	test_display_white.material	= color
	test_display_white.primitivetype	= "triangles"
	test_display_white.vertices	=  {{-max_pixels_count/2,  max_pixels_count/2},
										 { max_pixels_count/2,  max_pixels_count/2}, 
										 { max_pixels_count/2, -max_pixels_count/2},
										 {-max_pixels_count/2, -max_pixels_count/2}}
	test_display_white.indices		= box_ind
	test_display_white.controllers	= {{"CICU_TEST_Display",name}}

	Add(test_display_white)
	use_mipfilter(test_display_white)
end

display_background(MFCD_CICU_WHITE_SCR,MFCD_CICU_WHITE)
display_background(MFCD_CICU_GREY_SCR,MFCD_CICU_GREY)
display_background(MFCD_CICU_BLACK_SCR,MFCD_CICU_BLACK)
display_background(MFCD_CICU_BLUE_SCR,MFCD_CICU_INIT_BLUE)