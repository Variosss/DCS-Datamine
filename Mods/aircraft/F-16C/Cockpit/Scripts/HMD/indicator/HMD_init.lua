dofile(LockOn_Options.common_script_path.."devices_defs.lua")

opacity_sensitive_materials = 
{
	"font_HMD",
	"HMD_SYMBOLOGY_MATERIAL"
}

-- Parameters handling functions
dofile(LockOn_Options.script_path.."HMD/indicator/InitParams.lua")

indicator_type = indicator_types.HELMET
purposes       = {render_purpose.GENERAL, render_purpose.HUD_ONLY_VIEW}

shaderLineParamsUpdatable  = true
shaderLineDefaultThickness = 6
shaderLineDefaultFuzziness = 1.5
shaderLineDrawAsWire 	   = false
shaderLineUseSpecularPass  = false

-- page specific for the indicator, implements indicator border/FOV
BasePage              = LockOn_Options.script_path.."HMD/indicator/Pages/HMD_base.lua"

-- Parameters to customize common symbology properties
writeParameter("MDG_init_specifics", LockOn_Options.script_path.."HMD/indicator/HMD_specifics.lua")
writeParameter("MDG_init_DEFAULT_LEVEL", 15)

-- Pages defs
dynamically_update_geometry = false
	
local PagesPathHMD = LockOn_Options.script_path.."HMD/indicator/Pages/"

-- Display borders, collimator projecting areas, etc
local SUBSET_HMD_BASE	      			= 1
-- Head-Up Display repeater HMD
local SUBSET_HMD_HUD_MODE_INDEP   		= 3 -- mode independent symbology
local SUBSET_HMD_HUD_NAV      			= 4
local SUBSET_HMD_HUD_WEAP_CMN       	= 5
local SUBSET_HMD_HUD_AA       			= 6
local SUBSET_HMD_HUD_AG       			= 7
-- BIT
local SUBSET_HMD_BIT					= 8
local SUBSET_HMD_BIT_PAT_1				= 9
local SUBSET_HMD_BIT_PAT_2				= 10
local SUBSET_HMD_BIT_PAT_3				= 11
local SUBSET_HMD_BIT_PAT_4				= 12
--ALIGN
local SUBSET_HMD_ALIGN					= 13

page_subsets = {}

local function makeSubsetsCommon()
	page_subsets[SUBSET_HMD_BASE]             		= BasePage
	-- HMD HUD
	page_subsets[SUBSET_HMD_HUD_MODE_INDEP]   		= PagesPathHMD.."HMD_common.lua"
	page_subsets[SUBSET_HMD_HUD_NAV]          		= PagesPathHMD.."HMD_NAV.lua"
	page_subsets[SUBSET_HMD_HUD_WEAP_CMN]     		= PagesPathHMD.."HMD_Weapons_Common.lua"
	page_subsets[SUBSET_HMD_HUD_AA]           		= PagesPathHMD.."HMD_AA.lua"
	page_subsets[SUBSET_HMD_HUD_AG]           		= PagesPathHMD.."HMD_AG.lua"
	-- BIT
	page_subsets[SUBSET_HMD_BIT]					= PagesPathHMD.."HMD_BIT.lua"
	page_subsets[SUBSET_HMD_BIT_PAT_1]				= PagesPathHMD.."HMD_BIT_PAT_1.lua"
	page_subsets[SUBSET_HMD_BIT_PAT_2]				= PagesPathHMD.."HMD_BIT_PAT_2.lua"
	page_subsets[SUBSET_HMD_BIT_PAT_3]				= PagesPathHMD.."HMD_BIT_PAT_3.lua"
	page_subsets[SUBSET_HMD_BIT_PAT_4]				= PagesPathHMD.."HMD_BIT_PAT_4.lua"
	-- ALIGN
	page_subsets[SUBSET_HMD_ALIGN]					= PagesPathHMD.."HMD_ALIGN.lua"
end

makeSubsetsCommon()

-- globals!
PAGE_HMD_NONE           = 1

PAGE_HMD_HUD_NAV        = 3
PAGE_HMD_HUD_AA         = 4
PAGE_HMD_HUD_AG         = 5

PAGE_HMD_BIT			= 6
PAGE_HMD_BIT_PAT_1		= 7
PAGE_HMD_BIT_PAT_2		= 8
PAGE_HMD_BIT_PAT_3		= 9
PAGE_HMD_BIT_PAT_4		= 10

PAGE_HMD_ALIGN			= 11

pages = {}

local function makePages()
	-- Indicator if OFF
	pages[PAGE_HMD_NONE]			= {}
	-- HUD
	pages[PAGE_HMD_HUD_NAV]			= {SUBSET_HMD_BASE, SUBSET_HMD_HUD_MODE_INDEP, SUBSET_HMD_HUD_NAV}
	pages[PAGE_HMD_HUD_AA]			= {SUBSET_HMD_BASE, SUBSET_HMD_HUD_MODE_INDEP, SUBSET_HMD_HUD_WEAP_CMN, SUBSET_HMD_HUD_AA}
	pages[PAGE_HMD_HUD_AG]			= {SUBSET_HMD_BASE, SUBSET_HMD_HUD_MODE_INDEP, SUBSET_HMD_HUD_WEAP_CMN, SUBSET_HMD_HUD_AG}
	-- BIT
	pages[PAGE_HMD_BIT]				= {SUBSET_HMD_BASE, SUBSET_HMD_BIT}
	pages[PAGE_HMD_BIT_PAT_1]		= {SUBSET_HMD_BASE, SUBSET_HMD_BIT_PAT_1}
	pages[PAGE_HMD_BIT_PAT_2]		= {SUBSET_HMD_BASE, SUBSET_HMD_BIT_PAT_2}
	pages[PAGE_HMD_BIT_PAT_3]		= {SUBSET_HMD_BASE, SUBSET_HMD_BIT_PAT_3}
	pages[PAGE_HMD_BIT_PAT_4]		= {SUBSET_HMD_BASE, SUBSET_HMD_BIT_PAT_4}
	-- ALIGN
	pages[PAGE_HMD_ALIGN]			= {SUBSET_HMD_BASE, SUBSET_HMD_ALIGN}
end

makePages()

init_pageID	= PAGE_NONE

dofile(LockOn_Options.script_path.."HMD/indicator/HMD_formats_IDs.lua")

local function tablelen(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

pages_by_mode = {}
clear_mode_table(pages_by_mode, tablelen(HMD_DISPL_FMT_LEV1), tablelen(HMD_DISPL_FMT_LEV2), tablelen(HMD_DISPL_FMT_LEV3))

pages_by_mode[HMD_DISPL_FMT_LEV1.NONE]		[HMD_DISPL_FMT_LEV2.NONE]		[HMD_DISPL_FMT_LEV3.NONE]	[HMD_DISPL_FMT_LEV4.NONE]	= PAGE_HMD_NONE

pages_by_mode[HMD_DISPL_FMT_LEV1.HUD]		[HMD_DISPL_FMT_LEV2.HUD_NAV]	[HMD_DISPL_FMT_LEV3.NONE]	[HMD_DISPL_FMT_LEV4.NONE]	= PAGE_HMD_HUD_NAV
pages_by_mode[HMD_DISPL_FMT_LEV1.HUD]		[HMD_DISPL_FMT_LEV2.HUD_AA]		[HMD_DISPL_FMT_LEV3.NONE]	[HMD_DISPL_FMT_LEV4.NONE]	= PAGE_HMD_HUD_AA
pages_by_mode[HMD_DISPL_FMT_LEV1.HUD]		[HMD_DISPL_FMT_LEV2.HUD_AG]		[HMD_DISPL_FMT_LEV3.NONE]	[HMD_DISPL_FMT_LEV4.NONE]	= PAGE_HMD_HUD_AG

pages_by_mode[HMD_DISPL_FMT_LEV1.BIT]		[HMD_DISPL_FMT_LEV2.NONE]		[HMD_DISPL_FMT_LEV3.NONE]	[HMD_DISPL_FMT_LEV4.NONE]	= PAGE_HMD_BIT
pages_by_mode[HMD_DISPL_FMT_LEV1.BIT]		[HMD_DISPL_FMT_LEV2.BIT_PAT_1]	[HMD_DISPL_FMT_LEV3.NONE]	[HMD_DISPL_FMT_LEV4.NONE]	= PAGE_HMD_BIT_PAT_1
pages_by_mode[HMD_DISPL_FMT_LEV1.BIT]		[HMD_DISPL_FMT_LEV2.BIT_PAT_2]	[HMD_DISPL_FMT_LEV3.NONE]	[HMD_DISPL_FMT_LEV4.NONE]	= PAGE_HMD_BIT_PAT_2
pages_by_mode[HMD_DISPL_FMT_LEV1.BIT]		[HMD_DISPL_FMT_LEV2.BIT_PAT_3]	[HMD_DISPL_FMT_LEV3.NONE]	[HMD_DISPL_FMT_LEV4.NONE]	= PAGE_HMD_BIT_PAT_3
pages_by_mode[HMD_DISPL_FMT_LEV1.BIT]		[HMD_DISPL_FMT_LEV2.BIT_PAT_4]	[HMD_DISPL_FMT_LEV3.NONE]	[HMD_DISPL_FMT_LEV4.NONE]	= PAGE_HMD_BIT_PAT_4

pages_by_mode[HMD_DISPL_FMT_LEV1.ALIGN]		[HMD_DISPL_FMT_LEV2.NONE]		[HMD_DISPL_FMT_LEV3.NONE]	[HMD_DISPL_FMT_LEV4.NONE]	= PAGE_HMD_ALIGN

function get_page_by_mode(master, L2, L3, L4)
	return get_page_by_mode_global(pages_by_mode, init_pageID, master, L2, L3, L4)
end
