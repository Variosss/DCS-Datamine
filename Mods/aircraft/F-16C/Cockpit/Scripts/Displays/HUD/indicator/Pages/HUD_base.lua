dofile(LockOn_Options.script_path.."Displays/HUD/indicator/HUD_Page_defs.lua")
dofile(LockOn_Options.script_path.."Displays/Common/indicator/IndicatorBorderTools.lua")

local function addCombinerGlass(name, verts, inds, pos, rot)
	local glass				= CreateElement "ceMeshPoly"
	glass.name				= name
	glass.primitivetype		= "triangles"
	glass.vertices			= verts
	glass.indices			= inds
	glass.init_pos			= pos
	glass.init_rot			= rot
	glass.h_clip_relation	= h_clip_relations.REWRITE_LEVEL
	glass.level				= DEFAULT_LEVEL - 1
	glass.isdraw			= true
	glass.change_opacity	= false
	glass.z_enabled			= true

	setAsInvisibleMask(glass) -- changes material
	
	Add(glass)
end

local HUD_glassScale = 1 / GetScale()
local function scaleCombinerPos(pos)
	return {pos[1] * HUD_glassScale, pos[2] * HUD_glassScale, pos[3] * HUD_glassScale}
end

-- HUD glass vertices. From 3D Max, in meters.
-- Right half of the vertices set. Symmetric about Y axis.
local HUD_GlassVerts = {{0.0000, 0.1310},
						{0.0050, 0.1309},
						{0.0102, 0.1307},
						{0.0154, 0.1303},
						{0.0205, 0.1298},
						{0.0256, 0.1291},
						{0.0305, 0.1283},
						{0.0352, 0.1274},
						{0.0399, 0.1263},
						{0.0443, 0.1251},
						{0.0486, 0.1238},
						{0.0527, 0.1224},
						{0.0565, 0.1209},
						{0.0601, 0.1195},
						{0.0634, 0.1180},
						{0.0664, 0.1165},
						{0.0692, 0.1151},
						{0.0717, 0.1137},
						{0.0739, 0.1124},
						{0.0760, 0.1110},
						{0.0775, 0.1101},
						{0.0779, 0.1091},
						{0.0781, 0.1081},
						{0.0720, 0.1079},
						{0.0849, -0.1399},
						{0.0849, -0.1400},		--0.0915
						{0.0849, -0.1635},		--0.0928
						{0.0000, -0.1635},
						}
local HUD_GlassInds = prepareBorderVerts(HUD_GlassVerts, HUD_glassScale)

local HUD_glassAngle = -51 -- degrees

addCombinerGlass("HUD_glass",
	HUD_GlassVerts,
	HUD_GlassInds,
	scaleCombinerPos({0, 0, 0}), -- meters to Mils
	{0, 0, HUD_glassAngle}) -- clipping mask

-- Circle projected onto the combiner glass
local function Add_FOV_projection(name, radius, pos)
	local FOV_lens = openMaskArea(-1, name, {}, {}, pos, nil, nil, "HUD_GREEN_FOV")
	FOV_lens.z_enabled			= false
	set_circle(FOV_lens, radius)
	FOV_lens.collimated = false
end

local drawHUD_FOV_projections = true
if drawHUD_FOV_projections == true then
	local useBinocularFOV = true

	local Xshift = DegToMil(2.5)
	local Yshift = DegToMil(1.0)
	local Radius = DegToMil(7.5)
	
	-- FOV projections onto the combiner glass
	if useBinocularFOV == true then
		Add_FOV_projection("left_reflection", Radius, {-Xshift, Yshift, 0})
		Add_FOV_projection("right_reflection", Radius, {Xshift, Yshift, 0})
	
	else
		Add_FOV_projection("upper_reflection", Radius, {0, Yshift, 0})
	end
end

------------------------------------------------------------
-- Debug reference grid
-- Uncomment desired step or add your own
--local step = 10 -- 20 mils step
--local step = DegToMil() -- 1 degree step
--draw_dbg_grid(step, HUD_TFOV_mils, "MASK_MATERIAL_PURPLE")
