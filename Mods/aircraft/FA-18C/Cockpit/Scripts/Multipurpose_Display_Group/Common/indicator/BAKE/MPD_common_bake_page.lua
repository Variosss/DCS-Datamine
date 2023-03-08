dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/IndicatorBorderTools.lua")
dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/device/MDG_device_common.lua") -- MDG IDs
dofile(LockOn_Options.common_script_path.."elements_defs.lua")
dofile(LockOn_Options.common_script_path.."tools.lua")

SetScale(1)

-- the function looks for maximum coordinate (along both axes) in the vertices table
-- verts are in meters (display geometry points from 3DS)
local function getMaxCoord(verts)
	local maxCoord = 0
	
	for i, v in pairs(verts) do
		if v[1] > maxCoord then
			maxCoord = v[1]
		end
		
		if v[2] > maxCoord then
			maxCoord = v[2]
		end
	end
	
	return maxCoord
end

-- Placeholder (root) for the bake texture and related render objects
do
	pic_placeholder       				= CreateElement "ceSimple"
	pic_placeholder.name        		= "BakePlaceholder"
	--pic_placeholder.collimated  		= collimated or false
	--pic_placeholder.controllers		= {{"render_purpose", render_purpose.HUD_ONLY_VIEW}}
	Add(pic_placeholder)
end

-- Background on HUD-only view
do
	-- we need the border be rescaled to sizes -1 to 1
	local borderSzNorm = getMaxCoord(displayBorderVerts)

	local verts = {}
	copyTable(verts, displayBorderVerts)
	local inds = prepareBorderVerts(verts, 1 / borderSzNorm)

	local HUD_only_back        			= CreateElement "ceMeshPoly"
	HUD_only_back.name					= bake_material_name .. "_HUD_only_back"
	HUD_only_back.material 	 			= MakeMaterial("",{0,0,0,255})
	HUD_only_back.vertices      		= verts
	HUD_only_back.indices	     		= inds
	HUD_only_back.additive_alpha   		= false
	
	if bakeToCockpitTexture ~= true then
		HUD_only_back.controllers 	 	= {{"render_purpose", render_purpose.HUD_ONLY_VIEW}}
	end
	
	--HUD_only_back.isdraw				= false
	HUD_only_back.parent_element 		= pic_placeholder.name
	Add(HUD_only_back)
end

-- Texture to bake
do
	local aspect_adjustment = aspect_adjustment or 1
	local w = 1
	local h = w * aspect_adjustment
	local verts 	=	{{-w, h},
						 { w, h},
						 { w,-h},
						 {-w,-h}}
	local inds  	= default_box_indices

	local picture			 			= CreateElement "ceTexPoly"
	picture.name						= bake_material_name .. "_picture"
	picture.material		 			= MakeMaterial(bake_material_name,{255,255,255,255})
	picture.vertices		 			= verts
	picture.indices			 			= inds
	picture.additive_alpha   			= true
	picture.tex_coords		 			= {{0, 0},{1, 0},{1,1},{0, 1}}
	picture.parent_element 				= pic_placeholder.name
	Add(picture)
end
