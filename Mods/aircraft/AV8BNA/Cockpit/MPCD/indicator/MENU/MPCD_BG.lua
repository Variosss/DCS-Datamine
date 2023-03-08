-- ===================
--   MPCD BACKGROUND 
-- ===================

local szh 	 = GetHalfHeight() * MeterToIn * InToDI()
local szw    = GetHalfWidth() * MeterToIn * InToDI()
local verts  =	{
	{-szw,  szh},
	{ szw,  szh},
	{ szw, -szh},
	{-szw, -szh}
}

local	mpcd_background					= CreateElement "ceMeshPoly"
		mpcd_background.name			= "mpcd_background"
		mpcd_background.init_pos		= {0, 0, 0}
		mpcd_background.vertices		= verts
		mpcd_background.indices			= {0,1,2 ; 0,2,3}
		mpcd_background.material		= MakeMaterial(nil, {0,0,0,192})
		mpcd_background.use_mipfilter	= true
		mpcd_background.h_clip_relation	= h_clip_relations.COMPARE
		mpcd_background.level			= MPCD_DEFAULT_LEVEL
		mpcd_background.additive_alpha	= true	-- additive blending
		mpcd_background.collimated		= false
		mpcd_background.controllers		= {{"MPCD_Backlight"}}
Add(mpcd_background)
