dofile(LockOn_Options.script_path.."MFCD/indicator/TGP/MFCD_TGP_tools.lua")

AddRender()
rendered_material    = MFCD_SOLID_GREY_2

CameraInitBlank    				= CreateElement "ceMeshPoly"
CameraInitBlank.name			= "CameraInitBlank"
CameraInitBlank.primitivetype	= "triangles"
CameraInitBlank.material		= "TGP_STBY_GREY"
CameraInitBlank.vertices		=  {{-1, 1},
									{ 1, 1},
									{ 1,-1},
									{-1,-1}}
CameraInitBlank.indices			= box_ind
SetScreenSpace(CameraInitBlank)
Add(CameraInitBlank)

test_dot 	   			 = CreateElement "ceMeshPoly"
test_dot.name 			 = "test_dot"
test_dot.primitivetype   = "triangles"
test_dot.material	   	 = rendered_material
test_dot.vertices        = {{-0.02, 0.02},
							{ 0.02, 0.02},
							{ 0.02,-0.02},
							{-0.02,-0.02}}
test_dot.indices		 = box_ind 
test_dot.init_pos        = {0.0, 0.0, 0}
test_dot.controllers	 = {{"tgp_stby_init_dot"}}
SetScreenSpace(test_dot)
Add(test_dot)
use_mipfilter(test_dot)
