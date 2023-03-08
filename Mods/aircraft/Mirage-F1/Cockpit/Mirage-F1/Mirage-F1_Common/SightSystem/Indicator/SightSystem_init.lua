dofile(LockOn_Options.common_script_path.."devices_defs.lua")

indicator_type = indicator_types.COLLIMATOR 
purposes 	   = {render_purpose.GENERAL,render_purpose.HUD_ONLY_VIEW} 

-------PAGE IDs-------
PAGE_OFF		= 0
PAGE_MAIN		= 1

--Source files for page subsets
SRC_HUD_GLASS	= 0
SRC_HUD_MAIN	= 1

--subsets declare lua indication source files which will be used to combines pages 
local my_path = LockOn_Options.script_path.."../../Mirage-F1/Mirage-F1_Common/SightSystem/Indicator/"

page_subsets = {
[SRC_HUD_GLASS]			= my_path.."SightSystem_glass.lua",
[SRC_HUD_MAIN] 			= my_path.."SightSystem_main.lua",
}

----------------------
pages = {
[PAGE_OFF]				= {SRC_HUD_GLASS},
[PAGE_MAIN]				= {SRC_HUD_GLASS,SRC_HUD_MAIN},
}
-- set this page on start 
init_pageID				= PAGE_OFF

collimator_default_distance_factor = {0.6,0,0}  -- angular size operations will use this as reference to calculate coverage and collimation
