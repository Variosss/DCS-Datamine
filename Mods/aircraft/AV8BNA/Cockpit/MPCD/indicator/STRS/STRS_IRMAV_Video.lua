--------------------------------------------------
-- STRS IR Maverick Video Output
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
		frame.material		= MakeMaterial(nil,{0,0,0,0})
		frame.vertices		= verts
		frame.indices		= {0,1,1,2,2,3,3,0}
Add_MPCD_Element(frame)

-- Video
local	IRMAV_RENDER				= CreateElement "ceTexPoly"
		IRMAV_RENDER.name			= "IRMAV_RENDER"
		IRMAV_RENDER.init_pos		= {0.0, 0.0, 0.0}
		IRMAV_RENDER.vertices		= verts
		IRMAV_RENDER.indices		= {0, 1, 2, 0, 2, 3}
		IRMAV_RENDER.tex_coords 	= {{0,0},{1,0},{1,1},{0,1}}
		IRMAV_RENDER.material		= "render_target_"..tostring(GetRenderTarget() + 1)
Add_MPCD_Element(IRMAV_RENDER)