dofile(LockOn_Options.common_script_path.."devices_defs.lua")
dofile(LockOn_Options.script_path.."settingsloader.lua")

settings = settingsloader("settings.lua")

indicator_type = indicator_types.COLLIMATOR  -- ensure that this is HUD
purposes 	   = {render_purpose.GENERAL,render_purpose.HUD_ONLY_VIEW}  -- HUD will be rendered on hud only view

-------PAGE IDs-------
PAGE_GND	= 0
PAGE_NAV	= 1
PAGE_APP	= 2
PAGE_AA		= 3
PAGE_AG		= 4
PAGE_TEST	= 5

--Source files for page subsets
SRC_HUD_GLASS	= 0
SRC_HUD_BASE	= 1
SRC_HUD_GND 	= 2
SRC_HUD_NAV 	= 3
SRC_HUD_APP 	= 4
SRC_HUD_AA  	= 5
SRC_HUD_AG  	= 6
SRC_HUD_TEST	= 7

--subsets declare lua indication source files which will be used to combines pages

local my_path = LockOn_Options.script_path.."VTH/"

page_subsets = {
	[SRC_HUD_GLASS]		= my_path.."HUD_glass.lua",
	[SRC_HUD_BASE]		= my_path.."HUD_base.lua",
	[SRC_HUD_GND ]		= my_path.."HUD_page_GND.lua",
	[SRC_HUD_NAV ]		= my_path.."HUD_page_NAV.lua",
	[SRC_HUD_APP ]		= my_path.."HUD_page_APP.lua",
	[SRC_HUD_AA  ]		= my_path.."HUD_page_AA.lua",
	[SRC_HUD_AG  ]		= my_path.."HUD_page_AG.lua",
	[SRC_HUD_TEST]		= my_path.."HUD_page_TEST.lua",
}

--[[
SRC_HUD_GLASS,SRC_HUD_BASE  will be background for all other pages
--]]
----------------------
pages = {
	[PAGE_GND ]		= {SRC_HUD_GLASS,SRC_HUD_BASE,SRC_HUD_GND },
	[PAGE_NAV ]		= {SRC_HUD_GLASS,SRC_HUD_BASE,SRC_HUD_NAV },
	[PAGE_APP ]		= {SRC_HUD_GLASS,SRC_HUD_BASE,SRC_HUD_APP },
	[PAGE_AA  ]		= {SRC_HUD_GLASS,SRC_HUD_BASE,SRC_HUD_AA  },
	[PAGE_AG  ]		= {SRC_HUD_GLASS,SRC_HUD_BASE,SRC_HUD_AG  },
	[PAGE_TEST]		= {SRC_HUD_GLASS,SRC_HUD_BASE,SRC_HUD_TEST},
}

-- set this page on start
init_pageID			= PAGE_NAV

collimator_default_distance_factor = {0.6, -0.6*0.079,0}  -- angular size operations will use this as reference to calculate coverage and collimation

shaderLineParamsUpdatable  = true
shaderLineDrawAsWire 	   = false
shaderLineUseSpecularPass  = false
shaderLineDefaultThickness = settings.vth_thickness
shaderLineDefaultFuzziness = settings.vth_fuzziness

brightness_sensitive_materials = {
	"vth_green",
}
