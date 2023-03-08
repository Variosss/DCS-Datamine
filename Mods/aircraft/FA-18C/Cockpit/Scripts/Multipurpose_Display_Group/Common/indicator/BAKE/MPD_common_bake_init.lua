
purposes 	 	= render_purposes_to_use or {render_purpose.GENERAL, render_purpose.HUD_ONLY_VIEW}
indicator_type 	= indicator_types.COMMON

page_subsets 	= {bake_page_path}
pages 			= {{1}}
init_pageID     = 1

-- general purpose
brightness_scale_gen_purp_nite = 0.126 -- night
brightness_scale_gen_purp_day = 1.0 --1.5, -- day
-- HUD only, exported displays
brightness_scale_nongen_purp_nite = 0.9 -- night
brightness_scale_nongen_purp_day = 1.0  -- day
