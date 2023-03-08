dofile(LockOn_Options.script_path.."SHKVAL\\SHKVAL_usefull_definitions.lua")

test            = CreateElement "ceTexPoly"
test.name       = "camera_lim_H"
test.vertices   = {{-1, -1},
				   {-1,  1},
 				   { 1,  1},
				   { 1, -1}}
test.indices    = {0, 1, 2, 0, 2, 3}
test.material   = "INDICATION_SHKVAL-V_TEST_PATTERN"
test.tex_coords = {{0,1},{0,0},{1,0},{1,1}}
SetScreenSpace(test)
Add(test)
