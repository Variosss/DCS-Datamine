dofile(LockOn_Options.common_script_path.."KNEEBOARD/indicator/definitions.lua")
SetScale(FOV)

local width  	   = 1.045;
local aspect 	   = GetAspect()
local height 	   = width * GetAspect()
local back   	   = CreateElement "ceTexPoly"
back.material 	   = MakeMaterial("Bazar/Textures/AvionicsCommon/kneeboard_background.dds",{255,255,255,255})
back.vertices 	   = {{-width, height},
					  { width, height},
					  { width,-height},
					  {-width,-height}}
back.indices		= {0,1,2;0,2,3}
back.tex_coords		=	{{0, 0},
						 { 1, 0},
						 { 1, 1},
						 { 0, 1}}
back.blend_mode 	=  blend_mode.IBM_ONLY_ALPHA
Add(back)

