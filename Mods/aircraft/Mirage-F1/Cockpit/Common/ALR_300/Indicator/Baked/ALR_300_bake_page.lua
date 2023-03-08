
omitBoresightPosControllers = true

dofile(LockOn_Options.script_path.."../../Common/ALR_300/Indicator/ALR_300_tools.lua")

SetScale(FOV)

local ALR_300_displArea_HUDonly_back				= makeDispArea(64)
ALR_300_displArea_HUDonly_back.name 			  	= "ALR_300_displArea_HUDonly_back"
ALR_300_displArea_HUDonly_back.material		  		= "ALR_300_BACKGROUND"
ALR_300_displArea_HUDonly_back.h_clip_relation 		= h_clip_relations.NULL
ALR_300_displArea_HUDonly_back.controllers 	 		= {{"render_purpose", render_purpose.HUD_ONLY_VIEW}}
Add(ALR_300_displArea_HUDonly_back)

local aspect_adjustment 							= 1
local w 											= 1
local h 											= w * aspect_adjustment

local ALR_300_picture			 					= CreateElement "ceTexPoly"
ALR_300_picture.name								= "ALR_300_bake_screen"
ALR_300_picture.material		 					= MakeMaterial("ALR_300_bake", {255, 255, 255, 255})
ALR_300_picture.vertices		 					= makeBoxVerts(-w, w, -h, h)
ALR_300_picture.indices			 					= default_box_indices
ALR_300_picture.additive_alpha   					= true
ALR_300_picture.tex_coords		 					= {{0, 0}, {1, 0}, {1, 1}, {0, 1}}
Add(ALR_300_picture)

