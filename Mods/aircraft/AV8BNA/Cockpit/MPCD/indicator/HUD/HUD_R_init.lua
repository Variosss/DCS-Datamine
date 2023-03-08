-------------------------------------------
-- HUD REPEATER RIGHT INITIALIZATION FILE
-------------------------------------------
dofile(LockOn_Options.common_script_path.."devices_defs.lua")
dofile(LockOn_Options.common_script_path.."elements_defs.lua")
dofile(LockOn_Options.common_script_path.."ViewportHandling.lua")

local hud_path	= LockOn_Options.script_path.."HUD/indicator/"
local mpcd_path	= LockOn_Options.script_path.."MPCD/indicator/HUD/"

dofile(hud_path.."Global/HUD_Materials_RR.lua")
dofile(hud_path.."Global/HUDR_Parameters.lua")
dofile(hud_path.."Global/HUD_PageDefs.lua")

try_find_assigned_viewport("RIGHT_MFCD")

page_subsets = {
	[SRC_HUD_GLASS]			= hud_path.."HUD_glass.lua",
	[SRC_HUD_BASE]			= hud_path.."HUD_base.lua",
	[SRC_HUD_NAV]			= hud_path.."NAV/NAV_Page_01.lua",
	[SRC_HUD_NAV_AWLS]		= hud_path.."NAV/NAV_Page_02.lua",
	[SRC_HUD_VTOL]			= hud_path.."VSTOL/VSTOL_Page_01.lua",
	[SRC_HUD_VTOL_AWLS]		= hud_path.."VSTOL/VSTOL_Page_02.lua",
	[SRC_HUD_AA_GUNS]		= hud_path.."AA/AA_Page_01.lua",
	[SRC_HUD_AA_AIM9]		= hud_path.."AA/AA_Page_11.lua",
	[SRC_HUD_AG_GUNS]		= hud_path.."AG/AG_Page_01.lua",
	[SRC_HUD_AG_RKTS]		= hud_path.."AG/AG_Page_02.lua",
	[SRC_HUD_AG_BOMBS]		= hud_path.."AG/AG_Page_03.lua",
	[SRC_HUD_AG_JDAMS]		= hud_path.."AG/AG_Page_04.lua",
	[SRC_HUD_AG_AGMS]		= hud_path.."AG/AG_Page_05.lua",
	[SRC_HUD_AG_NOWPN]		= hud_path.."AG/AG_Page_90.lua",
	[SRC_HUD_STBY]			= hud_path.."STBY/STBY_Base.lua",
	[SRC_HUD_NAV_FAIL_INS]	= hud_path.."STBY/STBY_NAV_INS.lua",
	[SRC_HUD_NAV_FAIL_MSC]	= hud_path.."STBY/STBY_NAV_MSC.lua",
}

pages = {
	[PAGE_OFF]				= {},
	[PAGE_NAV]				= {SRC_HUD_GLASS,SRC_HUD_BASE,SRC_HUD_NAV},
	[PAGE_NAV_AWLS]			= {SRC_HUD_GLASS,SRC_HUD_BASE,SRC_HUD_NAV_AWLS},
	[PAGE_VTOL]				= {SRC_HUD_GLASS,SRC_HUD_BASE,SRC_HUD_VTOL},
	[PAGE_VTOL_AWLS]		= {SRC_HUD_GLASS,SRC_HUD_BASE,SRC_HUD_VTOL_AWLS},
	[PAGE_AA_GUNS]			= {SRC_HUD_GLASS,SRC_HUD_BASE,SRC_HUD_AA_GUNS},
	[PAGE_AA_AIM9]			= {SRC_HUD_GLASS,SRC_HUD_BASE,SRC_HUD_AA_AIM9},
	[PAGE_AG_GUNS]			= {SRC_HUD_GLASS,SRC_HUD_BASE,SRC_HUD_AG_GUNS},
	[PAGE_AG_RKTS]			= {SRC_HUD_GLASS,SRC_HUD_BASE,SRC_HUD_AG_RKTS},
	[PAGE_AG_BOMBS]			= {SRC_HUD_GLASS,SRC_HUD_BASE,SRC_HUD_AG_BOMBS},
	[PAGE_AG_JDAMS]			= {SRC_HUD_GLASS,SRC_HUD_BASE,SRC_HUD_AG_JDAMS},
	[PAGE_AG_AGMS]			= {SRC_HUD_GLASS,SRC_HUD_BASE,SRC_HUD_AG_AGMS},
	[PAGE_AG_NOWPN]			= {SRC_HUD_GLASS,SRC_HUD_BASE,SRC_HUD_AG_NOWPN},
	[PAGE_STANDBY]			= {SRC_HUD_GLASS,SRC_HUD_BASE,SRC_HUD_STBY},
	[PAGE_NAV_FAIL_INS]		= {SRC_HUD_GLASS,SRC_HUD_BASE,SRC_HUD_NAV_FAIL_INS},
	[PAGE_NAV_FAIL_MSC]		= {SRC_HUD_GLASS,SRC_HUD_BASE,SRC_HUD_NAV_FAIL_MSC},
}

-- set this page on start
init_pageID			= PAGE_NAV
collimator_default_distance_factor = {0.6, 0, 0}
used_render_mask = LockOn_Options.script_path.."Resources/HUD/HUD_FLIR_MASK.dds"
--used_render_mask = "interleave2.bmp"

-- Parameters
hud_aa_zpt	= hud_aa_zeropoint
hud_ag_zpt	= hud_ag_zeropoint
hud_nv_zpt	= hud_nav_zeropoint
hud_in_zpt	= hud_inst_zeropoint
hud_lg_zpt	= hud_lgd_zeropoint
pitch_scale = hud_pitch_factor
