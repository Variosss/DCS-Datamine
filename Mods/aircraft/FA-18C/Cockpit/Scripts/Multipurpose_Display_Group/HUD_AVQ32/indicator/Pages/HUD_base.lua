dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Common_page_defs.lua")
dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/IndicatorBorderTools.lua")

------------------------------------------------------------
-- HUD combiner glass

local function addCombinerGlass(name, verts, inds, pos, rot)
	local glass           = CreateElement "ceMeshPoly"
	glass.name            = name
	glass.primitivetype   = "triangles"
	glass.vertices	      = verts
	glass.indices		  = inds
	--glass.blend_mode 	  = blend_mode.IBM_REGULAR
	glass.init_pos	  	  = pos -- coordinates from 3D Max, in meters
	glass.init_rot	  	  = rot
	glass.h_clip_relation = h_clip_relations.REWRITE_LEVEL
	glass.level			  = DEFAULT_LEVEL - 1
	glass.isdraw		  = true
	glass.change_opacity  = false
	
	setAsInvisibleMask(glass) -- changes material
	--glass.material	  = "MASK_MATERIAL"
	
	Add(glass)
end

local HUD_glassScale = 1 / GetScale()

local function scaleCombinerPos(pos)
	return {pos[1] * HUD_glassScale, pos[2] * HUD_glassScale, pos[3] * HUD_glassScale}
end

-- Large (forward) HUD glass vertices. From 3D Max, in meters.
-- Right half of the vertices set. Symmetric about Y axis.
--[[
-- full glass geometry
local HUD_largeGlassVerts = {{0.0267, 0.1916},
							 {0.0813, 0.117},
							 {0.0813, -0.1634},
							 {0.0553, -0.1916}
						    }
]]

-- lower half glass geometry
local HUD_lowerHalfGlassVerts = {{0.0813, 0.0431},
								 {0.0813, -0.1634},
								 {0.0553, -0.1916}
								}

local HUD_lowerHalfGlassInds = prepareBorderVerts(HUD_lowerHalfGlassVerts, HUD_glassScale)

-- Small (aft) HUD glass vertices. From 3D Max, in meters.
-- Right half of the vertices set. Symmetric about Y axis.
local HUD_upperHalfGlassVerts = {{0.0297, 0.082},
								 {0.0911, -0.0007},
								 {0.0911, -0.082}
								}

local HUD_upperHalfGlassInds = prepareBorderVerts(HUD_upperHalfGlassVerts, HUD_glassScale)

local HUD_glassAngle = -50 -- degrees

addCombinerGlass("HUD_glass_lower",
	HUD_lowerHalfGlassVerts,
	HUD_lowerHalfGlassInds,
	scaleCombinerPos({0, -0.0288, -0.009}), -- meters to DI
	{0, 0, HUD_glassAngle})

addCombinerGlass("HUD_glass_upper",
	HUD_upperHalfGlassVerts,
	HUD_upperHalfGlassInds,
	scaleCombinerPos({0, 0.0448, -0.011}), -- meters to DI
	{0, 0, HUD_glassAngle})


local function Add_FOV_circle(name, radius, pos)
	local FOV          = CreateElement "ceMeshPoly"
	FOV.name           = name
	FOV.init_pos       = pos
	FOV.primitivetype  = "triangles"
	set_circle(FOV, radius)
	--FOV.blend_mode   = blend_mode.IBM_REGULAR
	FOV.change_opacity = false
	FOV.isdraw         = true
	
	setAsInvisibleMask(FOV) -- changes material
	FOV.material       = "HUD_GREEN_FOV"
		
	Add(FOV)
	return FOV
end


-- HUD Total Field of View (The Large Circle)
local function Add_TFOV(name, radius)
	local TFOV           = Add_FOV_circle(name, radius)
	TFOV.h_clip_relation = h_clip_relations.REWRITE_LEVEL
	TFOV.level			 = DEFAULT_LEVEL - 1
	TFOV.collimated      = true
end

-- Not used in current implementation. Symbology visibility is defined by:
-- 1) the combiner glass borders
-- 2) symbology projection areas (two for monocular view, four for binocular view)
--Add_TFOV("TFOV", MilToDI(HUD_TFOV_mils))

-- Circle projected onto the combiner glass
local function Add_FOV_projection(name, radius, pos)
	local FOV_lens = openMaskArea(-1, name, {}, {}, pos, nil, nil, "HUD_GREEN_FOV")
	set_circle(FOV_lens, radius)
	FOV_lens.collimated = false
end


local drawHUD_FOV_projections = true
if drawHUD_FOV_projections == true then
	local useBinocularFOV = true

	local upperXshift = DegToDI(2.12)
	local upperYshift = DegToDI(2.11)
	local upperRadius = DegToDI(5.44)

	local lowerXshift = DegToDI(2.28)
	local lowerYshift = DegToDI(3)
	local lowerRadius = DegToDI(5.86)
		
	-- FOV projections onto the combiner glass
	if useBinocularFOV == true then
		-- upper FOV
		Add_FOV_projection("upper_left_reflection", upperRadius, {-upperXshift, upperYshift, 0})
		Add_FOV_projection("upper_right_reflection", upperRadius, {upperXshift, upperYshift, 0})
		
		-- lower FOV
		Add_FOV_projection("lower_left_reflection", lowerRadius, {-lowerXshift, -lowerYshift, 0})
		Add_FOV_projection("lower_right_reflection", lowerRadius, {lowerXshift, -lowerYshift, 0})
	else
		-- upper FOV
		Add_FOV_projection("upper_reflection", upperRadius, {0, upperYshift, 0})
		-- lower FOV
		Add_FOV_projection("lower_reflection", lowerRadius, {0, -lowerYshift, 0})
	end
end

------------------------------------------------------------
-- Debug reference grid

-- Uncomment desired step or add your own
--local step = MilToDI(10) -- 10 mils step
--local step = 20 -- 20 DI step
local step = DegToDI() -- 1 degree step
--local step = glyphNominalHeight * 2 -- 200% stroke font height step
--dbg_add_MDG_RefGrid(step, MilToDI(HUD_TFOV_mils), collimated)
