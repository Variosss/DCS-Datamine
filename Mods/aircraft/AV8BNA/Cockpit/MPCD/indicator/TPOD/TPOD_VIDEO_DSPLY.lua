--------------------------------------------------
-- TPOD Video Display Page
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
local black_material = MakeMaterial(nil, {0,0,0,255})

local	TPOD_ELEMENT				= CreateElement "ceMeshPoly"
		TPOD_ELEMENT.name	    	= "scr_background"
		TPOD_ELEMENT.init_pos		= {0, 0, 0}
		TPOD_ELEMENT.vertices		= verts
		TPOD_ELEMENT.indices		= {0,1,2 ; 0,2,3}
		TPOD_ELEMENT.material		= black_material
Add_MPCD_Element(TPOD_ELEMENT)
		
local	TPOD_ELEMENT				= CreateElement "ceMeshPoly"
		TPOD_ELEMENT.name			= "frame"
		TPOD_ELEMENT.primitivetype	= "lines"
		TPOD_ELEMENT.vertices		= verts
		TPOD_ELEMENT.indices		= {0,1,1,2,2,3,3,0}
		TPOD_ELEMENT.material		= black_material
Add_MPCD_Element(TPOD_ELEMENT)

-- Video
local	TPOD_VIDEO					= CreateElement "ceTexPoly"
		TPOD_VIDEO.name				= "TPOD_VIDEO"
		TPOD_VIDEO.init_pos			= {0.0, 0.0, 0.0}
		TPOD_VIDEO.vertices			= verts
		TPOD_VIDEO.indices			= {0, 1, 2, 0, 2, 3}
		TPOD_VIDEO.tex_coords 		= {{0,0},{1,0},{1,1},{0,1}}
		TPOD_VIDEO.material			= "render_target_"..tostring(GetRenderTarget() + 1)
		TPOD_VIDEO.controllers		= {{"TPOD_Video_enabled"}}
Add_MPCD_Element(TPOD_VIDEO)

-- ForeGround
local	TPOD_ELEMENT				= CreateElement "ceMeshPoly"
		TPOD_ELEMENT.name			= "scr_frame_top"
		TPOD_ELEMENT.init_pos		= {0, 0.0, 0}
		TPOD_ELEMENT.vertices		= verts
		TPOD_ELEMENT.indices		= {0,1,2 ; 0,2,3}
		TPOD_ELEMENT.material		= black_material
		TPOD_ELEMENT.controllers	= {{"TPOD_Limits_Top", 0.135}}
Add_MPCD_Element(TPOD_ELEMENT)

-- Symbols & Icons
local	TPOD_Symbol					= CreateElement "ceSMultiLine"
		TPOD_Symbol.name			= "tpod_snsr_head"
		TPOD_Symbol.material		= stroke_material
		TPOD_Symbol.init_pos		= {0.0, PosY(0.0), 0}
		TPOD_Symbol.points_set		= {"MPCD_stroke_symbols", "lockon_cue"}
		TPOD_Symbol.scale			= MPCD_STRK_SCALE
		TPOD_Symbol.controllers		= {{"tpod_look_indicator"}}
AddMPCDStrokeSymbol(TPOD_Symbol)
