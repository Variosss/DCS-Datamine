dofile(LockOn_Options.common_script_path.."devices_defs.lua")
dofile(LockOn_Options.common_script_path.."ViewportHandling.lua")
dofile(LockOn_Options.script_path.."settingsloader.lua")

settings = settingsloader("settings.lua")


indicator_type = indicator_types.COMMON
purposes 	 = {100}	-- Don't render, only bake

VTB_PAGE_PPI	= 0
VTB_PAGE_BSC	= 1
VTB_PAGE_CAD	= 2
VTB_PAGE_EMP	= 3
VTB_PAGE_OFF	= 99

SRC_VTB_BASE	= 0
SRC_VTB_PPI		= 1
SRC_VTB_BSC		= 2
SRC_VTB_CAD		= 3
SRC_VTB_EMP		= 4


local my_path = LockOn_Options.script_path.."VTB/"

page_subsets = {
	[SRC_VTB_BASE]		= my_path.."VTB_BASE.lua",
	[SRC_VTB_PPI]		= my_path.."VTB_PAGE_PPI.lua",
	[SRC_VTB_BSC]		= my_path.."VTB_PAGE_BSC.lua",
	[SRC_VTB_CAD]		= my_path.."VTB_PAGE_CAD.lua",
	[SRC_VTB_EMP]		= my_path.."VTB_PAGE_EMP.lua"
}

----------------------
pages = {
	[VTB_PAGE_PPI]		= {SRC_VTB_BASE, SRC_VTB_PPI },
	[VTB_PAGE_BSC]		= {SRC_VTB_BASE, SRC_VTB_BSC },
	[VTB_PAGE_CAD]		= {SRC_VTB_BASE, SRC_VTB_CAD },
	[VTB_PAGE_EMP]		= {SRC_VTB_BASE, SRC_VTB_EMP },
}

init_pageID			= VTB_PAGE_OFF



shaderLineParamsUpdatable  = true
shaderLineDrawAsWire 	   = false
shaderLineUseSpecularPass  = false
shaderLineDefaultThickness = 1.0
shaderLineDefaultFuzziness = 1.0

brightness_sensitive_materials = {
	"vtb_mrq",
	"vtb_vid",
	"vtb_cav",
	"vtb_vid_image",
}

