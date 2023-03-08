dofile(LockOn_Options.script_path.."MFCD/indicator/TAD/MFCD_TAD_tools.lua")

fon			        = CreateElement "ceMeshPoly"
fon.primitivetype   = "triangles"
fon.vertices        = frame_box
fon.indices	        = box_ind
fon.level		    = DEFAULT_LEVEL
fon.h_clip_relation = h_clip_relations.REWRITE_LEVEL
set_as_invisible_mask(fon)
SetLowerLeftCornerOrigin(fon)
Add(fon)