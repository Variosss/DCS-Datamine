dofile(LockOn_Options.common_script_path.."devices_defs.lua")

indicator_type = indicator_types.COMMON  -- ensure that this is HUD 
purposes 	   = {render_purpose.GENERAL,render_purpose.HUD_ONLY_VIEW}  -- HUD will be rendered on hud only view 

-------PAGE IDs-------
PAGE_0		= 0
PAGE_1		= 1
PAGE_2		= 2
PAGE_3		= 3
--Source files for page subsets
SRC_HUD_GLASS	= 0
SRC_HUD_BASE	= 1
SRC_HUD_0		= 2
SRC_HUD_1		= 3
SRC_HUD_2		= 4
SRC_HUD_3		= 5

--subsets declare lua indication source files which will be used to combines pages 

local my_path = LockOn_Options.script_path.."SimpleHUD/Lua/"

page_subsets = {
[SRC_HUD_GLASS]= my_path.."HUD_glass.lua",
[SRC_HUD_BASE] = my_path.."HUD_base.lua",
[SRC_HUD_0]	   = my_path.."HUD_page_0.lua",
[SRC_HUD_1]	   = my_path.."HUD_page_1.lua",
[SRC_HUD_2]	   = my_path.."HUD_page_2.lua",
[SRC_HUD_3]	   = my_path.."HUD_page_3.lua",
}

--[[
SRC_HUD_GLASS,SRC_HUD_BASE  will be background for all other pages 
--]]
----------------------
pages = {
[PAGE_0]			= {SRC_HUD_GLASS,SRC_HUD_BASE,SRC_HUD_0},
[PAGE_1]			= {SRC_HUD_GLASS,SRC_HUD_BASE,SRC_HUD_1},
[PAGE_2]			= {SRC_HUD_GLASS,SRC_HUD_BASE,SRC_HUD_2},
[PAGE_3]			= {SRC_HUD_GLASS,SRC_HUD_BASE,SRC_HUD_3},--there is TV page 
}
-- set this page on start 
init_pageID			= PAGE_0

collimator_default_distance_factor = {0.6,0,0}  -- angular size operations will use this as reference to calculate coverage and collimation


used_render_mask = "interleave.bmp" --default mask for TV
