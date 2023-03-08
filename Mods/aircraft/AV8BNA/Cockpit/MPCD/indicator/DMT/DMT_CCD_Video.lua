--------------------------------------------------
-- DMT Camera Video Output
--------------------------------------------------
-- Vertices
local szh 	 = GetHalfHeight() * MeterToIn * InToDI()
local szw    = GetHalfWidth() * MeterToIn * InToDI()
local verts  =	{
	{-szw,  szh},
	{ szw,  szh},
	{ szw, -szh},
	{-szw, -szh}
}

-- Background
local	frame				= CreateElement "ceMeshPoly"
		frame.name			= "fr"
		frame.primitivetype	= "lines"
		frame.material		= MakeMaterial(nil,{0,0,0,255})
		frame.vertices		= verts
		frame.indices		= {0,1,1,2,2,3,3,0}
Add_MPCD_Element(frame)

-- Video
local	DMT_RENDER				= CreateElement "ceTexPoly"
		DMT_RENDER.name			= "DMT_RENDER"
		DMT_RENDER.init_pos		= {0.0, 0.0, 0.0}
		DMT_RENDER.vertices		= verts
		DMT_RENDER.indices		= {0, 1, 2, 0, 2, 3}
		DMT_RENDER.tex_coords 	= {{0,0},{1,0},{1,1},{0,1}}
		DMT_RENDER.material		= "render_target_"..tostring(GetRenderTarget() + 1)
		DMT_RENDER.controllers	= {{"dmt_with_video"}}
Add_MPCD_Element(DMT_RENDER)
