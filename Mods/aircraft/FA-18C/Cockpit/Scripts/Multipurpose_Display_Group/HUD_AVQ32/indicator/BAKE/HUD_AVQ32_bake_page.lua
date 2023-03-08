dofile(LockOn_Options.script_path.."materials.lua")
dofile(LockOn_Options.common_script_path.."elements_defs.lua")
dofile(LockOn_Options.common_script_path.."tools.lua")

SetScale(1)

-- Texture to bake
local w = 1
local h = 1
local verts 	=	{{-w, h},
					 { w, h},
					 { w,-h},
					 {-w,-h}}
local inds  	= default_box_indices

local DBG_back        		= CreateElement "ceMeshPoly"
DBG_back.name				= "DBG_back"
DBG_back.material 	 		= "DBG_RED"
DBG_back.vertices      		= verts
DBG_back.indices	     	= inds
DBG_back.additive_alpha   	= false
Add(DBG_back)
	
local picture			 	= CreateElement "ceTexPoly"
picture.name				= HUD_BAKE_MATERIAL .. "_picture"
picture.material		 	= MakeMaterial(HUD_BAKE_MATERIAL,{255,255,255,255})
picture.vertices		 	= verts
picture.indices			 	= inds
picture.additive_alpha   	= true
picture.tex_coords		 	= {{0, 0},{1, 0},{1,1},{0, 1}}
picture.controllers 	 	= {{"brightness",
								-- general purpose
								0.085, -- night
								1.0, -- day
								-- HUD only, exported displays
								0.9, -- night
								1.0  -- day
								}}
Add(picture)

