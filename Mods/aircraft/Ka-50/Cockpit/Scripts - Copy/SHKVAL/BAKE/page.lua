SetScale(1)
local w = 1
local h = 1
local verts 			 =	{{-w, h},
							 { w, h},
							 { w,-h},
							 {-w,-h}}
local inds  			 = {0, 1, 2, 0, 2, 3}

local picture			 			 = CreateElement "ceTexPoly"
picture.material		 			 = MakeMaterial("ccSHKVAL_Bake_SRC",{255,255,255,255})
picture.vertices		 			 = verts
picture.indices			 			 = inds
picture.additive_alpha   			 = false
picture.tex_coords		 			 = {{0, 0},{1, 0},{1,1},{0, 1}}
picture.controllers 	 			 = {{"render_purpose",1,2,3}}
Add(picture)
