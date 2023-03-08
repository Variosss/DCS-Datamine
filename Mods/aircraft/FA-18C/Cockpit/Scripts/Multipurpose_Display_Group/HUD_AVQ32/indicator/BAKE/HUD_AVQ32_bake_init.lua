dofile(LockOn_Options.common_script_path.."devices_defs.lua")

-- the parameters for 'MPD_common_bake_init.lua'
--bake_page_path = LockOn_Options.script_path.."Multipurpose_Display_Group/HUD_AVQ32/indicator/BAKE/HUD_AVQ32_bake_page.lua"

--dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/BAKE/MPD_common_bake_init.lua")

purposes 	 	= render_purposes_to_use or {render_purpose.GENERAL, render_purpose.HUD_ONLY_VIEW}
--indicator_type 	= indicator_types.COMMON
indicator_type 	= indicator_types.COLLIMATOR

--page_subsets 	= {bake_page_path}
page_subsets 	= {LockOn_Options.script_path.."Multipurpose_Display_Group/HUD_AVQ32/indicator/BAKE/HUD_AVQ32_bake_page.lua"}
pages 			= {{1}}
init_pageID     = 1
