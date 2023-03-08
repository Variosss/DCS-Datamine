
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


local compass_x  = (2*(max_pixels_count - 120)/(max_pixels_count) - 1)*(max_pixels_count/2)
local compass_y  =  0.7*(max_pixels_count/2)

CompassSizeK = 1.6
local size_N_x	 = (0.5*(74.5 - 44.5)/ 512)
local size_N_y	 = (0.5*(496  - 462)/ 512)
local x_N		 =  44.5/512  + size_N_x
local y_N	 	 =  462/512   + size_N_y

compass_N 	   		  = CreateElement "ceTexPoly"
compass_N.name 		  = "compass_N"
compass_N.material	  = MFCD_GREY_2 
compass_N.vertices    = {{-size_N_x*(max_pixels_count/2) * CompassSizeK,  size_N_y*(max_pixels_count/2) * CompassSizeK}, 
			 			 { size_N_x*(max_pixels_count/2) * CompassSizeK,  size_N_y*(max_pixels_count/2) * CompassSizeK},
				 		 { size_N_x*(max_pixels_count/2) * CompassSizeK, -size_N_y*(max_pixels_count/2) * CompassSizeK},
					 	 {-size_N_x*(max_pixels_count/2) * CompassSizeK, -size_N_y*(max_pixels_count/2) * CompassSizeK}}
compass_N.indices     = box_ind
compass_N.tex_params  = {x_N, y_N, 2/(max_pixels_count) / CompassSizeK, 2/(max_pixels_count) / CompassSizeK,}
compass_N.init_pos    = {compass_x, compass_y, 0}
compass_N.controllers = {{"tgp_compass_rose_is_available", 1}}
Add(compass_N)
use_mipfilter(compass_N)	


CompassLineNS					= CreateElement "ceSimpleLineObject"
CompassLineNS.name				= "CompassLineNS"
CompassLineNS.material			= MFCD_GREY_2
CompassLineNS.width				= 2.2 * 1.3
CompassLineNS.tex_params		= {{0.1, 503.5 / 512}, {0.9, 503.5 / 512}, {texture_scale / 1.3, texture_scale * 2 / 1.3}}
CompassLineNS.vertices			= {{0, -1}, {0, 1}}
CompassLineNS.parent_element    = compass_N.name
Add(CompassLineNS)
use_mipfilter(CompassLineNS)

CompassLineWE = Copy(CompassLineNS)

CompassLineNS.controllers       = {{"tgp_compass_rose_NS_line"}}
CompassLineWE.controllers       = {{"tgp_compass_rose_WE_line"}}
Add(CompassLineWE)

local arrow_length  	= 0.03   * (max_pixels_count/2)

compass_arrow  				 = CreateElement "ceMeshPoly"
compass_arrow.name 			 = "compass_arrow"
compass_arrow.primitivetype  = "triangles"
compass_arrow.material	   	 = rendered_material 
compass_arrow.vertices  	 = {{ 0, arrow_length},
								{-arrow_length/2, 0},
								{ arrow_length/2, 0}}
compass_arrow.indices		 = {0,1,2} 
compass_arrow.parent_element = compass_N.name
compass_arrow.controllers    = {{"tgp_compass_arrow_pos"}}
Add(compass_arrow)


mils_per_half_size = 2 / 69.9 


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
