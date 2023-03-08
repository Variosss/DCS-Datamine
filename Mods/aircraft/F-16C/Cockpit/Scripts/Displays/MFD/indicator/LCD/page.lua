SetCustomScale(1)

function addPicture(left)
	local two_inch = 0.0508
	
	local verts = 				{{-two_inch, two_inch},
								 { two_inch, two_inch},
								 { two_inch,-two_inch},
								 {-two_inch,-two_inch}}
	local inds  = {0, 1, 2, 0, 2, 3}

	local hud_only_background			 = CreateElement "ceMeshPoly"
	hud_only_background.material		 = MakeMaterial("",{0,0,0,255})
	hud_only_background.vertices		 = verts
	hud_only_background.indices			 = inds
	hud_only_background.additive_alpha   = false
	hud_only_background.tex_coords		 = {{0, 0},{1,0},{1,1},{0,1}}
	hud_only_background.controllers 	 = {{"render_purpose",1}}
	Add(hud_only_background)

	local materialName
	if left then
		materialName = "MFD_LCD_F16_LEFT"
	else
		materialName = "MFD_LCD_F16_RIGHT"
	end
	
	local picture			 = CreateElement "ceTexPoly"
	picture.material		 = MakeMaterial(materialName,{255,255,255,255})
	picture.vertices		 = verts
	picture.indices			 = inds
	picture.additive_alpha   = true
	
	--[[
	if left then
		picture.tex_coords		 = {{0, 0},{0.5, 0},{0.5,1},{0, 1}}
	else
		picture.tex_coords		 = {{0.5, 0},{1, 0},{1,1},{0.5, 1}}
	end
	--]]
	picture.tex_coords		 = {{0, 0},{1, 0},{1, 1},{0, 1}}
	picture.controllers 	 = {{"render_purpose",0,1,2,3}}
	Add(picture)

end

