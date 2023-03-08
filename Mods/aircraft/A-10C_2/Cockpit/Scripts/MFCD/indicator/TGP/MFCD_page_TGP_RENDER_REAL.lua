dofile(LockOn_Options.script_path.."MFCD/indicator/TGP/MFCD_TGP_tools.lua")

AddRender()
--texture_scale 		 = 512/570
rendered_material    = MFCD_SOLID_GREY_2
--rendered_line_width  = 0.006

local box_size  = 4
local hole_size = 1

litening_render 		 = CreateElement "ceTexPoly"
litening_render.name     = "litening_render"
litening_render.material =   MakeMaterial("mfd0",{255,255,255,255})
litening_render.vertices = {{ -1,  1},
						    {  1,  1},
						    {  1, -1},
						    { -1, -1}}
litening_render.indices	 = {0,1,2;0,2,3}
litening_render.tex_coords = {{0,0},{1,0},{1,1},{0,1}}
--litening_render.controllers = {{"tgp_custom_mfd_params",0,0.3,0}}
SetScreenSpace(litening_render)
Add(litening_render)

tgp_roll_stabilize_artifact 				= CreateElement "ceMeshPoly"
tgp_roll_stabilize_artifact.name 			= "tgp_roll_stabilize_artifact"
tgp_roll_stabilize_artifact.primitivetype   = "triangles"
tgp_roll_stabilize_artifact.material	   	= "TGP_STBY_DARK_GREY"
tgp_roll_stabilize_artifact.vertices        = {{-box_size, box_size},
											   { box_size, box_size},
											   { box_size,-box_size},
											   {-box_size,-box_size},
											   
											   {-hole_size, hole_size},
											   { hole_size, hole_size},
											   { hole_size,-box_size},
											   {-hole_size,-box_size}}
tgp_roll_stabilize_artifact.indices			= {0,1,4;4,1,5;
											   1,2,5;5,2,6;
											   2,3,6;3,6,7;
											   3,0,7;7,0,4}
tgp_roll_stabilize_artifact.controllers		= {{"tgp_roll_stabilize_artifact"}}
SetScreenSpace(tgp_roll_stabilize_artifact)
Add(tgp_roll_stabilize_artifact)

local sc =  219 / 512

gray_scale  			= CreateElement "ceTexPoly"
gray_scale.name         = "gray_scale"
gray_scale.material	 	= MFCD_GREY_2
gray_scale.vertices     = {{0,0},
						   {max_pixels_count,0},
						   {max_pixels_count,-0.25 * (max_pixels_count/2)},
						   {0,-0.25 * (max_pixels_count/2)}}
gray_scale.indices      = box_ind
gray_scale.init_pos		= {-(max_pixels_count/2),-0.75*(max_pixels_count/2),0}
gray_scale.tex_params   = {0,0,1/(max_pixels_count) * sc,1/(max_pixels_count) * sc}
gray_scale.controllers  = {{"tgp_video_mode",1,2},{"tgp_test_gray_scale"}}
Add(gray_scale)
