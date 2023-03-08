
--------------------------------------------------------------------------------
-- Variables
--------------------------------------------------------------------------------
shape_name					= "M-2000C-CPT"
is_EDM						= true
new_model_format			= true

ambient_light				= {255,255,255}
ambient_color_day_texture	= {255, 0, 0}
ambient_color_night_texture	= {40, 60 ,150}
ambient_color_from_devices	= {50, 50, 40}
ambient_color_from_panels	= {35, 25, 25}
dusk_border					= 0.4

draw_pilot					= false
external_model_canopy_arg	= 38

use_external_views			= false
cockpit_local_point			= {2.930, 1.060, 0.000}

day_texture_set_value		= 0.0
night_texture_set_value		= 0.1

local controllers			= LoRegisterPanelControls()

-- LIVERY
dofile(LockOn_Options.common_script_path.."tools.lua")
livery = get_livery_setting_from_plugin("M-2000C")

--
Z_test =
{
	near = 0.05,
	far  = 4.0,
}


args_initial_state = 
{
}

local showPilot = get_option_value("miscellaneous.show_pilot_body","local")
if showPilot then 
	args_initial_state[1000] = 1.0
end

--Obsolete light code
--Cockpit lights
-- lights =
-- {
	-- { -- 1
		-- lighttype = "omni",  -- omni 0.3 attn
		-- attenuation = { 0, 1, 1, 0.5 }, -- Attenuation0, Attenuation1, Attenuation2, Range (measure of how lightt intensity will be changed with distance)
		-- position = { 0.370, -0.455, -0.479 },
		-- angle = math.rad(20), --80
		-- angle2 = math.rad(21),  --105
		-- direction = { azimuth = math.rad(0), elevation = math.rad(90), roll = math.rad(0) }, -- 315/80/0
	-- },
	-- { -- 2
		-- lighttype = "spot",
		-- attenuation = { 0, 1, 1, 1 }, -- Attenuation0, Attenuation1, Attenuation2, Range (measure of how lightt intensity will be changed with distance)
		-- position = { 0.100, -0.455, -0.479 },
		-- angle = math.rad(30), --30
		-- angle2 = math.rad(60), --60
		-- direction = { azimuth = math.rad(0), elevation = math.rad(60), roll = math.rad(0) },
	-- },
	-- { -- 3
		-- lighttype = "spot",
		-- attenuation = { 0, 1, 1, 1 }, -- Attenuation0, Attenuation1, Attenuation2, Range (measure of how lightt intensity will be changed with distance)
		-- position = { 0.100, -0.455, -0.479 },
		-- angle = math.rad(30), --30
		-- angle2 = math.rad(60), --60
		-- direction = { azimuth = math.rad(0), elevation = math.rad(75), roll = math.rad(0) }, -- emer light
	-- },
	-- { -- 4
		-- lighttype = "spot",
		-- attenuation = { 0, 1, 1, 1 }, -- Attenuation0, Attenuation1, Attenuation2, Range (measure of how lightt intensity will be changed with distance)
		-- position = { 0.100, -0.455, -0.479 },
		-- angle = math.rad(30), --30
		-- angle2 = math.rad(60), --60
		-- direction = { azimuth = math.rad(0), elevation = math.rad(90), roll = math.rad(0) },
	-- },
	-- { -- 5
		-- lighttype = "spot",
		-- attenuation = { 0, 1, 1, 1 }, -- Attenuation0, Attenuation1, Attenuation2, Range (measure of how lightt intensity will be changed with distance)
		-- position = { 0.400, -0.455, -0.40 },
		-- angle = math.rad(30), --30
		-- angle2 = math.rad(60), --60
		-- direction = { azimuth = math.rad(0), elevation = math.rad(60), roll = math.rad(0) },
	-- },
	-- { -- 6
		-- lighttype = "spot",
		-- attenuation = { 0, 1, 1, 1 }, -- Attenuation0, Attenuation1, Attenuation2, Range (measure of how lightt intensity will be changed with distance)
		-- position = { 0.400, -0.455, -0.40 },
		-- angle = math.rad(30), --30
		-- angle2 = math.rad(60), --60
		-- direction = { azimuth = math.rad(0), elevation = math.rad(75), roll = math.rad(0) }, -- emer light
	-- },
	-- { -- 7
		-- lighttype = "spot",
		-- attenuation = { 0, 1, 1, 1 }, -- Attenuation0, Attenuation1, Attenuation2, Range (measure of how lightt intensity will be changed with distance)
		-- position = { 0.400, -0.455, -0.40 },
		-- angle = math.rad(30), --30
		-- angle2 = math.rad(60), --60
		-- direction = { azimuth = math.rad(0), elevation = math.rad(90), roll = math.rad(0) },
	-- },
	-- --=========================================================================
	-- --=========================================================================
	-- { -- 8
		-- lighttype = "spot",
		-- attenuation = { 0, 1, 15, 22 }, -- Attenuation0, Attenuation1, Attenuation2, Range (measure of how lightt intensity will be changed with distance)
		-- position = { 0.600, -0.249, -0.223 }, --0.542, -0.249, -0.223
		-- -- angle = math.rad(90),
		-- -- angle2 = math.rad(115),
		-- angle = math.rad(30),
		-- angle2 = math.rad(115),
		-- direction = { azimuth = math.rad(335), elevation = math.rad(25), roll = math.rad(0) },
		-- connector = "CKPT_FLOOD_CL",
	-- },
	-- { -- 9
		-- lighttype = "spot",
		-- attenuation = { 0, 1, 15, 22 }, -- Attenuation0, Attenuation1, Attenuation2, Range (measure of how lightt intensity will be changed with distance)
		-- position = { 0.600, -0.249, 0.223 },
		-- -- angle = math.rad(90),
		-- -- angle2 = math.rad(115),
		-- angle = math.rad(30),
		-- angle2 = math.rad(115),
		-- direction = { azimuth = math.rad(25), elevation = math.rad(25), roll = math.rad(0) },
		-- connector = "CKPT_FLOOD_CR",
	-- },
	-- --=========================================================================
	-- --=========================================================================
	-- { -- 10
		-- lighttype = "omni",  -- omni 0.3 attn
		-- attenuation = { 0, 1, 1, 0.5 }, -- Attenuation0, Attenuation1, Attenuation2, Range (measure of how lightt intensity will be changed with distance)
		-- position = { 0.370, -0.455, 0.479 },
		-- angle = math.rad(20), --80
		-- angle2 = math.rad(21),  --105
		-- direction = { azimuth = math.rad(0), elevation = math.rad(90), roll = math.rad(0) }, -- 315/80/0
	-- },
	-- { -- 11
		-- lighttype = "spot",
		-- attenuation = { 0, 1, 1, 1 }, -- Attenuation0, Attenuation1, Attenuation2, Range (measure of how lightt intensity will be changed with distance)
		-- position = { 0.100, -0.455, 0.479 },
		-- angle = math.rad(30), --30
		-- angle2 = math.rad(60), --60
		-- direction = { azimuth = math.rad(0), elevation = math.rad(60), roll = math.rad(0) },
	-- },
	-- { -- 12
		-- lighttype = "spot",
		-- attenuation = { 0, 1, 1, 1 }, -- Attenuation0, Attenuation1, Attenuation2, Range (measure of how lightt intensity will be changed with distance)
		-- position = { 0.100, -0.455, 0.479 },
		-- angle = math.rad(30), --30
		-- angle2 = math.rad(60), --60
		-- direction = { azimuth = math.rad(0), elevation = math.rad(75), roll = math.rad(0) }, -- emer light
	-- },
	-- { -- 13
		-- lighttype = "spot",
		-- attenuation = { 0, 1, 1, 1 }, -- Attenuation0, Attenuation1, Attenuation2, Range (measure of how lightt intensity will be changed with distance)
		-- position = { 0.100, -0.455, 0.479 },
		-- angle = math.rad(30), --30
		-- angle2 = math.rad(60), --60
		-- direction = { azimuth = math.rad(0), elevation = math.rad(90), roll = math.rad(0) },
	-- },
	-- { -- 14
		-- lighttype = "spot",
		-- attenuation = { 0, 1, 1, 1 }, -- Attenuation0, Attenuation1, Attenuation2, Range (measure of how lightt intensity will be changed with distance)
		-- position = { 0.400, -0.455, 0.40 },
		-- angle = math.rad(30), --30
		-- angle2 = math.rad(60), --60
		-- direction = { azimuth = math.rad(0), elevation = math.rad(60), roll = math.rad(0) },
	-- },
	-- { -- 15
		-- lighttype = "spot",
		-- attenuation = { 0, 1, 1, 1 }, -- Attenuation0, Attenuation1, Attenuation2, Range (measure of how lightt intensity will be changed with distance)
		-- position = { 0.400, -0.455, 0.40 },
		-- angle = math.rad(30), --30
		-- angle2 = math.rad(60), --60
		-- direction = { azimuth = math.rad(0), elevation = math.rad(75), roll = math.rad(0) }, -- emer light
	-- },
	-- { -- 16
		-- lighttype = "spot",
		-- attenuation = { 0, 1, 1, 1 }, -- Attenuation0, Attenuation1, Attenuation2, Range (measure of how lightt intensity will be changed with distance)
		-- position = { 0.400, -0.455, 0.40 },
		-- angle = math.rad(30), --30
		-- angle2 = math.rad(60), --60
		-- direction = { azimuth = math.rad(0), elevation = math.rad(90), roll = math.rad(0) },
	-- },
	-- --=========================================================================
	-- --=========================================================================
	-- { -- 17
		-- lighttype = "spot",
		-- attenuation = { 0, 1, 15, 20 }, -- Attenuation0, Attenuation1, Attenuation2, Range (measure of how lightt intensity will be changed with distance)
		-- position = { 0.600, -0.249, -0.223 }, --0.542, -0.249, -0.223
		-- angle = math.rad(60),
		-- angle2 = math.rad(115),
		-- direction = { azimuth = math.rad(335), elevation = math.rad(25), roll = math.rad(0) }, -- emer light
		-- connector = "CKPT_FLOOD_CL",
	-- },
	-- { -- 18
		-- lighttype = "spot",
		-- attenuation = { 0, 1, 15, 20 }, -- Attenuation0, Attenuation1, Attenuation2, Range (measure of how lightt intensity will be changed with distance)
		-- position = { 0.600, -0.249, 0.223 },
		-- angle = math.rad(60),
		-- angle2 = math.rad(115),
		-- direction = { azimuth = math.rad(25), elevation = math.rad(25), roll = math.rad(0) }, -- emer light
		-- connector = "CKPT_FLOOD_CR",
	-- },
	-- --=========================================================================
	-- --=========================================================================
-- }

--------------------------------------------------------------------------------
-- Mirror
--------------------------------------------------------------------------------
mirrors_data =
{
    width			= 0.702, -- 0.265
    aspect			= 2, -- 1.5
    rotation		= math.rad(-25); -- -13.5
    animation_speed	= 2.0;
    near_clip		= 0.1;
    middle_clip		= 10;
    far_clip		= 60000;
    connector		= "M2KC_CPT_MIRROR",
}

mirrors_draw                    = CreateGauge()
mirrors_draw.arg_number    		= 183
mirrors_draw.input   			= {0,1}
mirrors_draw.output   			= {1,0}
mirrors_draw.controller         = controllers.mirrors_draw

need_to_be_closed			= true -- close lua state after initialization
