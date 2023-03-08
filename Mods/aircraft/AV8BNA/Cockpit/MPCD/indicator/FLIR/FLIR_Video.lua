--------------------------------------------------
-- FLIR Video Output
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

local fsw	= 0.925 * GetHalfWidth() * MeterToIn * InToDI()
local fsh1	= 0.550 * GetHalfHeight() * MeterToIn * InToDI()
local fsh2	= 0.875 * GetHalfHeight() * MeterToIn * InToDI()

local flir_verts = {
	{-fsw,  fsh1},
	{ fsw,  fsh1},
	{ fsw, -fsh2},
	{-fsw, -fsh2}
}

-- Background
local	frame				= CreateElement "ceMeshPoly"
		frame.name			= "fr"
		frame.primitivetype	= "lines"
		frame.material		= MakeMaterial(nil,{0,0,0,255})
		frame.vertices		= verts
		frame.indices		= {0,1,1,2,2,3,3,0}
Add_MPCD_Element(frame)

-- FLIR Video
local	FLIR_RENDER				= CreateElement "ceTexPoly"
		FLIR_RENDER.name		= "FLIR_RENDER"
		FLIR_RENDER.init_pos	= {0.0, 0.0, 0.0}
		FLIR_RENDER.vertices	= flir_verts
		FLIR_RENDER.indices		= {0, 1, 2, 0, 2, 3}
		FLIR_RENDER.tex_coords 	= {{0,0},{1,0},{1,1},{0,1}}
		FLIR_RENDER.material	=  "render_target_"..tostring(GetRenderTarget() + 1)
		FLIR_RENDER.controllers	= {{"flir_output"}}
Add_MPCD_Element(FLIR_RENDER)


-- Hot Spot Markers -------------------
local	video_center					= CreateElement "ceSimple"
		video_center.name				= "flir_video_center"
		video_center.init_pos			= {0, 0, 0}
		video_center.controllers		= {{"flir_output"}}
Add_MPCD_Element(video_center)

local i = 1

for i = 1, 10 do
	local	FLIR_Symbol					= CreateElement "ceSMultiLine"
			FLIR_Symbol.name			= "hot_spot_" .. string.format("%02d", i)
			FLIR_Symbol.material		= stroke_material
			FLIR_Symbol.init_pos		= {0, 0, 0}
			FLIR_Symbol.parent_element	= video_center.name
			FLIR_Symbol.points_set		= {"MPCD_stroke_symbols", "hot_spot_mrk"}
			FLIR_Symbol.scale			= MPCD_STRK_SCALE
			FLIR_Symbol.controllers		= {{"flir_hot_spot_pos", i-1, 0.95}}
	AddMPCDStrokeSymbol(FLIR_Symbol)
end
