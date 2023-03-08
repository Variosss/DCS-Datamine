dofile(LockOn_Options.common_script_path.."devices_defs.lua")

-- the parameters for 'MPD_common_bake_init.lua'
bake_page_path = LockOn_Options.script_path.."Multipurpose_Display_Group/AMPCD/indicator/BAKE/AMPCD_bake_page.lua"

dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/BAKE/MPD_common_bake_init.lua")
dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/AMPCD/indicator/AMPCD_viewport_cfg.lua")

-- general purpose
brightness_scale_gen_purp_nite = 0.085 -- night
brightness_scale_gen_purp_day = 1.0 -- day
-- HUD only, exported displays
brightness_scale_nongen_purp_nite = 0.9 -- night
brightness_scale_nongen_purp_day = 1.0  -- day
