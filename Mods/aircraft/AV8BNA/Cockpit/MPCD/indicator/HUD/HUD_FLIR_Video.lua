dofile(LockOn_Options.script_path.."MPCD/indicator/MPCD_definitions.lua")
dofile(LockOn_Options.script_path.."MPCD/indicator/MENU/MPCD_BG.lua")

-- Video Output
local szh	= 1.0
local szw	= 1.0
local fsw	= 0.925

local verts  =	{
	{-szw,  szh},
	{ szw,  szh},
	{ szw, -szh},
	{-szw, -szh}}

local	frame				= CreateElement "ceMeshPoly"
		frame.name			= "fr"
		frame.primitivetype	= "lines"
		frame.material		= MakeMaterial(nil,{0,0,0,0})
		frame.vertices		= verts
		frame.indices		= {0,1,1,2,2,3,3,0}
Add_MPCD_Element(frame)

local	FLIR_RENDER				= CreateElement "ceTexPoly"
		FLIR_RENDER.name		= "FLIR_RENDER"
		FLIR_RENDER.init_pos	= {0.0, -0.00, 0.0}
		FLIR_RENDER.vertices	= verts
		FLIR_RENDER.indices		= {0, 1, 2, 0, 2, 3}
		FLIR_RENDER.tex_coords 	= {{0,0},{1,0},{1,1},{0,1}}
		FLIR_RENDER.material	=  "render_target_"..tostring(GetRenderTarget() + 1)
		FLIR_RENDER.controllers	= {{"flir_output"}}
Add_MPCD_Element(FLIR_RENDER)

		