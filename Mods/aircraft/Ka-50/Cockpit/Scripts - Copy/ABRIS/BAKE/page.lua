SetScale(1)
local w = 1
local h = GetAspect()
local verts 			 =	{{-w, h},
							 { w, h},
							 { w,-h},
							 {-w,-h}}
local inds  			 = {0, 1, 2, 0, 2, 3}

local hud_only_background			 = CreateElement "ceMeshPoly"
hud_only_background.material		 = MakeMaterial("",{0,0,0,255})
hud_only_background.vertices		 = verts
hud_only_background.indices			 = inds
hud_only_background.additive_alpha   = false
hud_only_background.controllers 	 = {{"render_purpose",1,2,3}}
Add(hud_only_background)

local picture			 = CreateElement "ceTexPoly"
picture.material		 = MakeMaterial("ccABRIS_Bake_SRC",{255,255,255,255})
picture.vertices		 = verts
picture.indices			 = inds
picture.additive_alpha   = true
picture.tex_coords		 = {{0, 0},{1, 0},{1,1},{0, 1}}
picture.controllers 	 = {{"brightness"}}
Add(picture)
