
dofile(LockOn_Options.script_path.."../../Mirage-F1/Mirage-F1_Common/Radar_Cyrano_IV_legacy/Indicator/CyranoLegacy_tools.lua")

SetScale(FOV)

do
	local backgndRadius = 1

	---[[
	--local CyranoLegacy_displArea_HUDonly_back			= makeDispArea(64)
	local CyranoLegacy_displArea_HUDonly_back			= add_rdr_area(backgndRadius, 64) --add_rdr_area(display_area_radius, 64)
	CyranoLegacy_displArea_HUDonly_back.name 			= "CyranoLegacy_displArea_HUDonly_back"
	CyranoLegacy_displArea_HUDonly_back.material		= "RADAR_BACKGROUND"
	CyranoLegacy_displArea_HUDonly_back.h_clip_relation = h_clip_relations.NULL
	CyranoLegacy_displArea_HUDonly_back.controllers 	= {{"render_purpose", render_purpose.HUD_ONLY_VIEW}}
	Add(CyranoLegacy_displArea_HUDonly_back)
	---]]
end

do
	local w 											= 1 -- / bake_general_scale-- / bake_general_scale
	local h 											= w

	local CyranoLegacy_picture			 				= CreateElement "ceTexPoly"
	CyranoLegacy_picture.name							= "CyranoLegacy_bake_screen"
	CyranoLegacy_picture.material		 				= MakeMaterial("CyranoLegacy_bake_general", {255, 255, 255, 255})
	CyranoLegacy_picture.vertices		 				= makeBoxVerts(-w, w, -h, h)
	CyranoLegacy_picture.indices			 			= default_box_indices
	CyranoLegacy_picture.additive_alpha   				= true
	CyranoLegacy_picture.tex_coords		 				= {{0, 0}, {1, 0}, {1, 1}, {0, 1}}
	Add(CyranoLegacy_picture)
end
