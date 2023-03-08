dofile(LockOn_Options.script_path.."MFCD/indicator/MFCD_useful_definitions.lua")

CDU_UNAVAILABLE						= CreateElement "ceStringPoly"
CDU_UNAVAILABLE.name				= "CDU_UNAVAILABLE"
CDU_UNAVAILABLE.material			= font_MFCD
CDU_UNAVAILABLE.alignment			= "CenterCenter"
CDU_UNAVAILABLE.stringdefs			= predefined_fonts[3] --txt_CDU_font
CDU_UNAVAILABLE.value				= "CDU UNAVAILABLE"
CDU_UNAVAILABLE.init_pos			= {max_pixels_count/2, OSB_positions[20][2], 0}
CDU_UNAVAILABLE.UseBackground		= true
CDU_UNAVAILABLE.BackgroundMaterial	= MFCD_SOLID_BLACK
CDU_UNAVAILABLE.controllers			= {{"cdu_power"}}
SetLowerLeftCornerOrigin(CDU_UNAVAILABLE)
Add(CDU_UNAVAILABLE)
use_mipfilter(CDU_UNAVAILABLE)

add_dummy_boxes({1, 2, 3, 4, 5})
add_dummy_boxes({6, 7, 8, 9, 10})
add_dummy_boxes({16, 17, 18, 19, 20})
