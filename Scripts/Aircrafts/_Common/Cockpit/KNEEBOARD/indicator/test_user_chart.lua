dofile(LockOn_Options.common_script_path.."KNEEBOARD/indicator/definitions.lua")

SetScale(FOV)
local USER_PICTURE  = MakeMaterial("pilot_KA50_notepad",{255,255,255,255})
local width  = 1;
local height = width * GetAspect()

local back   = CreateElement "ceTexPoly"
back.name     	   =  "USER_PICTURE"
back.material 	   =  USER_PICTURE
back.vertices 	   = {{-width, height},
					  { width, height},
					  { width,-height},
					  {-width,-height}}
back.indices	  = {0,1,2;0,2,3}

local dx = 50/512

back.tex_coords   = {{dx, 0},
					{ 1 - dx, 0},
					{ 1 - dx, 1},
					{ dx, 1}}
Add(back)