dofile(LockOn_Options.script_path.."SHKVAL\\SHKVAL_usefull_definitions.lua")
SetScale(FOV)

local ysize 	= GetAspect()

pict					= CreateElement "ceTexPoly"
pict.vertices			=  {{-1,  ysize},
							{ 1,  ysize},
							{ 1, -ysize},
							{-1, -ysize}}
pict.indices			= {0, 1, 2, 0, 2, 3}
pict.tex_coords 		= {{0,0},{1,0},{1,1},{0,1}}
pict.material			= "render_target_1"
pict.controllers		= {{"power"}}
Add(pict)

