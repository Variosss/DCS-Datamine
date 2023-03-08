dofile(LockOn_Options.common_script_path.."elements_defs.lua")
SetScale(1)--FOV

--From 3d MAX
local offset = -0.0005
local sc = 1/GetScale()


local function vtx(x_3dmax,y_3dmax,z_3dmax)	return 
	{-y_3dmax * sc,z_3dmax * sc,x_3dmax * sc}
 end



TV_RENDER 				= CreateElement "ceTexPoly" 
TV_RENDER.material		= MakeMaterial("NS430_1",{255,255,255,255})
TV_RENDER.controllers   = {{"set_origin_to_cockpit_shape"}}  -- as geometry exported from max is better to render with same origin as cockpit shape
TV_RENDER.vertices 		= {
vtx(-0.0207 + offset ,  0.0437,	 0.0254),
vtx(-0.0207 + offset ,  0.0432,	-0.0213),
vtx(-0.0207 + offset , -0.0432,	-0.0209),
vtx(-0.0207 + offset , -0.0425,	 0.0259),
vtx(-0.0207 + offset ,  0.0432,	 0.0259),
vtx(-0.0207 + offset ,  0.0435,	 0.0257),
vtx(-0.0207 + offset ,  0.0437,	-0.0209),
vtx(-0.0207 + offset ,  0.0435,	-0.0211),
vtx(-0.0207 + offset , -0.0428,	-0.0213),
vtx(-0.0207 + offset , -0.0431,	-0.0211),
vtx(-0.0207 + offset , -0.0430,	 0.0254),
vtx(-0.0207 + offset , -0.0428,	 0.0257),
}
TV_RENDER.indices	= 	{
 3,   4 ,  1 ;
 1,   8 ,  3 ;
 4,   5 ,  7 ;
 7,   1 ,  4 ;
 8,   9 , 11 ;
11,   3 ,  8 ;
 9,   2 , 10 ;
10,  11 ,  9 ;
 5,   0 ,  6 ;
 6,   7 ,  5 ;
}
TV_RENDER.tex_coords =  {
{ 0.0001,1-	0.9906},
{ 0.0051,1-	0.0000},
{ 1.0000,1-	0.0094},
{ 0.9949,1-	1.0000},
{ 0.0051,1-	1.0000},
{ 0.0020,1-	0.9965},
{ 0.0001,1-	0.0094},
{ 0.0020,1-	0.0035},
{ 0.9949,1-	0.0000},
{ 0.9981,1-	0.0035},
{ 1.0000,1-	0.9906},
{ 0.9981,1-	0.9965},
}
TV_RENDER.additive_alpha = true
TV_RENDER.init_pos = {0, 0, 0}
Add(TV_RENDER)
