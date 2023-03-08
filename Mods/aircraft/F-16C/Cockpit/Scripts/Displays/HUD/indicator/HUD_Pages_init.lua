local PagesPath = LockOn_Options.script_path.."Displays/HUD/indicator/Pages/"

-- Display borders, collimator projecting areas, etc
local SUBSET_HUD_BASE				= 1
local SUBSET_HUD_MODE_INDEP			= 2 -- mode independent symbology
local SUBSET_HUD_NAV				= 3
local SUBSET_HUD_WEAP_CMN			= 4
local SUBSET_HUD_AA					= 5
local SUBSET_HUD_AG					= 6
local SUBSET_HUD_HMD_ALIGN			= 7
local SUBSET_HUD_MAN_STBY_RETICLE	= 8

page_subsets = {}

page_subsets[SUBSET_HUD_BASE]				= BasePage
page_subsets[SUBSET_HUD_MODE_INDEP]			= PagesPath.."HUD_common.lua"
page_subsets[SUBSET_HUD_NAV]				= PagesPath.."HUD_NAV.lua"
page_subsets[SUBSET_HUD_WEAP_CMN]			= PagesPath.."HUD_Weapons_Common.lua"
page_subsets[SUBSET_HUD_AA]					= PagesPath.."HUD_AA.lua"
page_subsets[SUBSET_HUD_AG]					= PagesPath.."HUD_AG.lua"
page_subsets[SUBSET_HUD_HMD_ALIGN]			= PagesPath.."HUD_HMD_ALIGN.lua"
page_subsets[SUBSET_HUD_MAN_STBY_RETICLE]	= PagesPath.."HUD_MAN_Reticle.lua"

-- globals!
PAGE_HUD_NONE				= 1
PAGE_HUD_NAV				= 2
PAGE_HUD_AA					= 3
PAGE_HUD_AG					= 4
PAGE_HUD_HMD_ALIGN			= 5
PAGE_HUD_MAN_STBY_RETICLE	= 6

pages = {}

-- Indicator if OFF
pages[PAGE_HUD_NONE]				= {}
pages[PAGE_HUD_NAV]					= {SUBSET_HUD_BASE, SUBSET_HUD_MODE_INDEP, SUBSET_HUD_NAV}
pages[PAGE_HUD_AA]					= {SUBSET_HUD_BASE, SUBSET_HUD_MODE_INDEP, SUBSET_HUD_WEAP_CMN, SUBSET_HUD_AA}
pages[PAGE_HUD_AG]					= {SUBSET_HUD_BASE, SUBSET_HUD_MODE_INDEP, SUBSET_HUD_WEAP_CMN, SUBSET_HUD_AG}
pages[PAGE_HUD_HMD_ALIGN]			= {SUBSET_HUD_BASE, SUBSET_HUD_HMD_ALIGN}
pages[PAGE_HUD_MAN_STBY_RETICLE]	= {SUBSET_HUD_BASE, SUBSET_HUD_MAN_STBY_RETICLE}

init_pageID	= PAGE_HUD_NONE

dofile(LockOn_Options.script_path.."Displays/HUD/indicator/HUD_formats_IDs.lua")

local function tablelen(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

pages_by_mode = {}
clear_mode_table(pages_by_mode, tablelen(HUD_DISPL_FMT_LEV1), tablelen(HUD_DISPL_FMT_LEV2), tablelen(HUD_DISPL_FMT_LEV3))

pages_by_mode[HUD_DISPL_FMT_LEV1.NONE]					[HUD_DISPL_FMT_LEV2.NONE]	[HUD_DISPL_FMT_LEV3.NONE]	[HUD_DISPL_FMT_LEV4.NONE]	= PAGE_HUD_NONE
pages_by_mode[HUD_DISPL_FMT_LEV1.HUD_NAV]				[HUD_DISPL_FMT_LEV2.NONE]	[HUD_DISPL_FMT_LEV3.NONE]	[HUD_DISPL_FMT_LEV4.NONE]	= PAGE_HUD_NAV
pages_by_mode[HUD_DISPL_FMT_LEV1.HUD_AA]				[HUD_DISPL_FMT_LEV2.NONE]	[HUD_DISPL_FMT_LEV3.NONE]	[HUD_DISPL_FMT_LEV4.NONE]	= PAGE_HUD_AA
pages_by_mode[HUD_DISPL_FMT_LEV1.HUD_AG]				[HUD_DISPL_FMT_LEV2.NONE]	[HUD_DISPL_FMT_LEV3.NONE]	[HUD_DISPL_FMT_LEV4.NONE]	= PAGE_HUD_AG
pages_by_mode[HUD_DISPL_FMT_LEV1.HUD_HMD_ALIGN]			[HUD_DISPL_FMT_LEV2.NONE]	[HUD_DISPL_FMT_LEV3.NONE]	[HUD_DISPL_FMT_LEV4.NONE]	= PAGE_HUD_HMD_ALIGN
pages_by_mode[HUD_DISPL_FMT_LEV1.HUD_MAN_STBY_RETICLE]	[HUD_DISPL_FMT_LEV2.NONE]	[HUD_DISPL_FMT_LEV3.NONE]	[HUD_DISPL_FMT_LEV4.NONE]	= PAGE_HUD_MAN_STBY_RETICLE

function get_page_by_mode(master, L2, L3, L4)
	return get_page_by_mode_global(pages_by_mode, init_pageID, master, L2, L3, L4)
end
