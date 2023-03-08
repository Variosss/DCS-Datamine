dofile(LockOn_Options.common_script_path.."devices_defs.lua")
dofile(LockOn_Options.script_path.."HUD/device/HUD_param.lua")


indicator_type = indicator_types.COLLIMATOR
purposes 	 = {render_purpose.GENERAL,render_purpose.HUD_ONLY_VIEW}


-------PAGE IDs-------
id_Page =
{
	PAGE_OFF						= 0,
	PAGE_HUD_NAV					= 1,
	PAGE_HUD_GUNS					= 2,
	PAGE_HUD_CCIP					= 3,
	PAGE_HUD_CCRP					= 4,
	PAGE_HUD_AIR_TO_AIR				= 5,
	PAGE_HUD_TEST					= 6,
	PAGE_HUD_TEST_GROUND_BIT		= 7,
	PAGE_HUD_TEST_INFLT_BIT			= 8,
	PAGE_HUD_TEST_AAS				= 9,
	PAGE_HUD_TEST_WEAPONS			= 10,
	PAGE_HUD_TEST_WPN_REL_DATA		= 11,
	PAGE_HUD_TEST_DISPLAY_MODES		= 12,
	PAGE_HUD_TEST_MAINTENANCE		= 13,
	PAGE_HUD_TEST_DELTA_CAL			= 14,
	PAGE_HUD_TEST_BIT_FAULT_DISP	= 15,
	PAGE_HUD_TEST_AAS_MAN_FXD		= 16,
	PAGE_HUD_TEST_AAS_MAN_RTY		= 17,
	PAGE_HUD_TEST_WPNS_30MM			= 18,
	PAGE_HUD_TEST_WPNS_OFFSET_ADJ	= 19,
	PAGE_HUD_TEST_GCAS_BIT			= 20,
	PAGE_HUD_TEST_PREFLIGHT_BIT		= 21,
	PAGE_HUD_TEST_POWER_ON			= 22,
	PAGE_HUD_TEST_GCAS_TRAINING		= 23,
	PAGE_HUD_TEST_GCAS_CAPTURE		= 24,
	PAGE_HUD_TEST_DELTA_CAL			= 25,
	PAGE_HUD_TEST_IFF_ALERT			= 26,
	PAGE_HUD_TEST_WPN_RELEASE		= 27,
	PAGE_HUD_TEST_WPN_REL_GUNS		= 28,
    PAGE_HUD_TEST_WPN_REL_CCIP		= 29,
	PAGE_HUD_TEST_WPN_REL_CCRP		= 30,
	PAGE_HUD_TEST_WPN_REL_MAV		= 31,
	PAGE_HUD_STANDBY				= 32,
	PAGE_HUD_TEST_VMU_BIT			= 33
}

id_pagesubset =
{
	HUD_BASE					= 0,
	HUD_COMMON					= 1,
	HUD_TYPE1_SYMBOLOGY			= 2,
	HUD_NO_CLIP_SYMBOLOGY		= 3,
	HUD_NAV						= 4,
	HUD_GUNS					= 5,
	HUD_CCIP					= 6,
	HUD_CCRP					= 7,
	HUD_AIR_TO_AIR				= 8,
	HUD_WEAP_COMMON				= 9,
	HUD_TEST_MAIN_MENU			= 10,
	HUD_RETICLE					= 11,
	HUD_TEST_COMMON				= 12,
	HUD_TEST_GROUND_BIT			= 13,
	HUD_TEST_INFLT_BIT			= 14,
	HUD_TEST_AAS				= 15,
	HUD_TEST_WEAPONS			= 16,
	HUD_TEST_WPN_REL_DATA		= 17,
	HUD_TEST_DISPLAY_MODES		= 18,
	HUD_TEST_MAINTENANCE		= 19,
	HUD_TEST_DELTA_CAL			= 20,
	HUD_TEST_BIT_FAULT_DISP		= 21,
	HUD_TEST_AAS_MAN_FXD		= 22,
	HUD_TEST_AAS_MAN_RTY		= 23,
	HUD_TEST_WPNS_30MM			= 24,
	HUD_TEST_WPNS_OFFSET_ADJ	= 25,
	HUD_SOLUTION_PAGE			= 26,
	HUD_TEST_GCAS_BIT			= 27,
	HUD_TEST_PREFLIGHT_BIT		= 28,
	HUD_TEST_POWER_ON			= 29,
	HUD_TEST_GCAS_TRAINING		= 30,
	HUD_TEST_GCAS_CAPTURE		= 31,
	HUD_TEST_DELTA_CAL			= 32,
	HUD_TEST_IFF_ALERT			= 33,
	HUD_TEST_WPN_RELEASE		= 34,
	HUD_TEST_WPN_REL_GUNS		= 35,
    HUD_TEST_WPN_REL_CCIP		= 36,
	HUD_TEST_WPN_REL_CCRP		= 37,
	HUD_TEST_WPN_REL_MAV		= 38,
	HUD_STANDBY					= 39,
	HUD_TEST_VMU_BIT			= 40,
}

page_subsets = {}
page_subsets[id_pagesubset.HUD_BASE] =
	LockOn_Options.script_path.."HUD/Indicator/HUD_base_page.lua"
page_subsets[id_pagesubset.HUD_COMMON] =
	LockOn_Options.script_path.."HUD/Indicator/HUD_COMMON_page.lua"
page_subsets[id_pagesubset.HUD_TYPE1_SYMBOLOGY] =
	LockOn_Options.script_path.."HUD/Indicator/HUD_TYPE1_SYM_page.lua"
page_subsets[id_pagesubset.HUD_NO_CLIP_SYMBOLOGY] =
	LockOn_Options.script_path.."HUD/Indicator/HUD_NOCLIP_SYM_page.lua"
page_subsets[id_pagesubset.HUD_NAV] =
	LockOn_Options.script_path.."HUD/Indicator/HUD_NAV_page.lua"
page_subsets[id_pagesubset.HUD_GUNS] =
	LockOn_Options.script_path.."HUD/Indicator/HUD_GUNS_page.lua"
page_subsets[id_pagesubset.HUD_CCIP] =
	LockOn_Options.script_path.."HUD/Indicator/HUD_CCIP_page.lua"
page_subsets[id_pagesubset.HUD_CCRP] =
	LockOn_Options.script_path.."HUD/Indicator/HUD_CCRP_page.lua"
page_subsets[id_pagesubset.HUD_AIR_TO_AIR] =
	LockOn_Options.script_path.."HUD/Indicator/HUD_AIR_TO_AIR_page.lua"
page_subsets[id_pagesubset.HUD_WEAP_COMMON] =
	LockOn_Options.script_path.."HUD/Indicator/HUD_WEAP_COMMON_page.lua"
page_subsets[id_pagesubset.HUD_TEST_MAIN_MENU] =
	LockOn_Options.script_path.."HUD/Indicator/TEST/HUD_TEST_MAIN_MENU_page.lua"
page_subsets[id_pagesubset.HUD_RETICLE]	=
	LockOn_Options.script_path.."HUD/Indicator/HUD_PIPPER_RETICLE_page.lua"
page_subsets[id_pagesubset.HUD_STANDBY] =
	LockOn_Options.script_path.."HUD/Indicator/HUD_STANDBY_page.lua"
page_subsets[id_pagesubset.HUD_TEST_COMMON]	=
	LockOn_Options.script_path.."HUD/Indicator/TEST/HUD_TEST_COMMON.lua"
page_subsets[id_pagesubset.HUD_TEST_GROUND_BIT]	=
	LockOn_Options.script_path.."HUD/Indicator/TEST/HUD_TEST_GROUND_BIT_page.lua"
page_subsets[id_pagesubset.HUD_TEST_INFLT_BIT]	=
	LockOn_Options.script_path.."HUD/Indicator/TEST/HUD_TEST_INFLIGHT_BIT_page.lua"
page_subsets[id_pagesubset.HUD_TEST_AAS]	=
	LockOn_Options.script_path.."HUD/Indicator/TEST/HUD_TEST_AAS_page.lua"
page_subsets[id_pagesubset.HUD_TEST_WEAPONS]	=
	LockOn_Options.script_path.."HUD/Indicator/TEST/HUD_TEST_WEAPONS_page.lua"
page_subsets[id_pagesubset.HUD_TEST_DISPLAY_MODES]	=
	LockOn_Options.script_path.."HUD/Indicator/TEST/HUD_TEST_DISPLAY_MODES_page.lua"
page_subsets[id_pagesubset.HUD_TEST_BIT_FAULT_DISP]	=
	LockOn_Options.script_path.."HUD/Indicator/TEST/HUD_TEST_BIT_FAULT_DISP_page.lua"
page_subsets[id_pagesubset.HUD_TEST_AAS_MAN_FXD]	=
	LockOn_Options.script_path.."HUD/Indicator/TEST/HUD_TEST_AAS_MAN_FXD_page.lua"
page_subsets[id_pagesubset.HUD_TEST_AAS_MAN_RTY]	=
	LockOn_Options.script_path.."HUD/Indicator/TEST/HUD_TEST_AAS_MAN_RTY_page.lua"
page_subsets[id_pagesubset.HUD_TEST_WPNS_30MM]	=
	LockOn_Options.script_path.."HUD/Indicator/TEST/HUD_TEST_WPNS_30MM_page.lua"
page_subsets[id_pagesubset.HUD_TEST_WPNS_OFFSET_ADJ]	=
	LockOn_Options.script_path.."HUD/Indicator/TEST/HUD_TEST_OFFSET_ADJUST_page.lua"
page_subsets[id_pagesubset.HUD_SOLUTION_PAGE] =
	LockOn_Options.script_path.."HUD/Indicator/HUD_solution_page.lua"
page_subsets[id_pagesubset.HUD_TEST_GCAS_BIT] =
	LockOn_Options.script_path.."HUD/Indicator/TEST/HUD_TEST_GCAS_BIT_page.lua"
page_subsets[id_pagesubset.HUD_TEST_PREFLIGHT_BIT] =
	LockOn_Options.script_path.."HUD/Indicator/TEST/HUD_TEST_PREFLIGHT_BIT_page.lua"
page_subsets[id_pagesubset.HUD_TEST_POWER_ON] =
	LockOn_Options.script_path.."HUD/Indicator/TEST/HUD_TEST_POWER_ON_page.lua"
page_subsets[id_pagesubset.HUD_TEST_GCAS_TRAINING] =
	LockOn_Options.script_path.."HUD/Indicator/TEST/HUD_TEST_GCAS_TRAINING_page.lua"
page_subsets[id_pagesubset.HUD_TEST_GCAS_CAPTURE] =
	LockOn_Options.script_path.."HUD/Indicator/TEST/HUD_TEST_GCAS_CAPTURE_page.lua"
page_subsets[id_pagesubset.HUD_TEST_DELTA_CAL] =
	LockOn_Options.script_path.."HUD/Indicator/TEST/HUD_TEST_DELTA_CAL_page.lua"
page_subsets[id_pagesubset.HUD_TEST_IFF_ALERT] =
	LockOn_Options.script_path.."HUD/Indicator/TEST/HUD_TEST_IFF_ALERT_page.lua"
page_subsets[id_pagesubset.HUD_TEST_WPN_RELEASE] =
	LockOn_Options.script_path.."HUD/Indicator/TEST/HUD_TEST_WPN_RELEASE_page.lua"
page_subsets[id_pagesubset.HUD_TEST_WPN_REL_GUNS] =
	LockOn_Options.script_path.."HUD/Indicator/TEST/HUD_TEST_WPNREL_GUNS_page.lua"
page_subsets[id_pagesubset.HUD_TEST_WPN_REL_CCIP] =
	LockOn_Options.script_path.."HUD/Indicator/TEST/HUD_TEST_WPNREL_CCIP_page.lua"
page_subsets[id_pagesubset.HUD_TEST_WPN_REL_CCRP] =
	LockOn_Options.script_path.."HUD/Indicator/TEST/HUD_TEST_WPNREL_CCRP_page.lua"
page_subsets[id_pagesubset.HUD_TEST_WPN_REL_MAV] =
	LockOn_Options.script_path.."HUD/Indicator/TEST/HUD_TEST_WPNREL_MAV_page.lua"
page_subsets[id_pagesubset.HUD_TEST_MAINTENANCE] =
	LockOn_Options.script_path.."HUD/Indicator/TEST/HUD_TEST_MAINTENANCE_page.lua"
page_subsets[id_pagesubset.HUD_TEST_VMU_BIT] =
	LockOn_Options.script_path.."HUD/Indicator/TEST/HUD_TEST_VMU_BIT_page.lua"

----------------------
pages = {}

pages[id_Page.PAGE_OFF]			= {}
pages[id_Page.PAGE_HUD_NAV]		=
	{id_pagesubset.HUD_BASE, id_pagesubset.HUD_TYPE1_SYMBOLOGY,
	 id_pagesubset.HUD_NAV, id_pagesubset.HUD_COMMON,
	 id_pagesubset.HUD_NO_CLIP_SYMBOLOGY}
pages[id_Page.PAGE_HUD_GUNS]	=
	{id_pagesubset.HUD_BASE, id_pagesubset.HUD_TYPE1_SYMBOLOGY, 
	 id_pagesubset.HUD_GUNS, id_pagesubset.HUD_RETICLE, id_pagesubset.HUD_COMMON,
	 id_pagesubset.HUD_WEAP_COMMON, id_pagesubset.HUD_NO_CLIP_SYMBOLOGY}
pages[id_Page.PAGE_HUD_CCIP]	=
	{id_pagesubset.HUD_BASE, id_pagesubset.HUD_TYPE1_SYMBOLOGY, 
	 id_pagesubset.HUD_CCIP, id_pagesubset.HUD_SOLUTION_PAGE, id_pagesubset.HUD_RETICLE, 
	 id_pagesubset.HUD_COMMON, id_pagesubset.HUD_WEAP_COMMON, id_pagesubset.HUD_NO_CLIP_SYMBOLOGY}
pages[id_Page.PAGE_HUD_CCRP]	=
	{id_pagesubset.HUD_BASE, id_pagesubset.HUD_TYPE1_SYMBOLOGY, 
	 id_pagesubset.HUD_CCRP, id_pagesubset.HUD_SOLUTION_PAGE, id_pagesubset.HUD_RETICLE, 
	 id_pagesubset.HUD_COMMON, id_pagesubset.HUD_WEAP_COMMON, id_pagesubset.HUD_NO_CLIP_SYMBOLOGY}
pages[id_Page.PAGE_HUD_AIR_TO_AIR] =
	{id_pagesubset.HUD_BASE, id_pagesubset.HUD_TYPE1_SYMBOLOGY, 
	 id_pagesubset.HUD_AIR_TO_AIR, id_pagesubset.HUD_COMMON,
	 id_pagesubset.HUD_WEAP_COMMON, id_pagesubset.HUD_NO_CLIP_SYMBOLOGY}
pages[id_Page.PAGE_HUD_TEST] =
	{id_pagesubset.HUD_BASE, id_pagesubset.HUD_TEST_COMMON, id_pagesubset.HUD_TEST_MAIN_MENU}
pages[id_Page.PAGE_HUD_TEST_POWER_ON] =
	{id_pagesubset.HUD_BASE, id_pagesubset.HUD_TEST_POWER_ON}
pages[id_Page.PAGE_HUD_TEST_GROUND_BIT] =
	{id_pagesubset.HUD_BASE, id_pagesubset.HUD_TEST_COMMON, id_pagesubset.HUD_TEST_GROUND_BIT}
pages[id_Page.PAGE_HUD_TEST_INFLT_BIT] =
	{id_pagesubset.HUD_BASE, id_pagesubset.HUD_TEST_COMMON, id_pagesubset.HUD_TEST_INFLT_BIT}
pages[id_Page.PAGE_HUD_TEST_AAS] =
	{id_pagesubset.HUD_BASE, id_pagesubset.HUD_TEST_COMMON, id_pagesubset.HUD_TEST_AAS}
pages[id_Page.PAGE_HUD_TEST_WEAPONS] =
	{id_pagesubset.HUD_BASE, id_pagesubset.HUD_TEST_COMMON, id_pagesubset.HUD_TEST_WEAPONS}
pages[id_Page.PAGE_HUD_TEST_DISPLAY_MODES] =
	{id_pagesubset.HUD_BASE, id_pagesubset.HUD_TEST_COMMON, id_pagesubset.HUD_TEST_DISPLAY_MODES}
pages[id_Page.PAGE_HUD_TEST_BIT_FAULT_DISP] =
	{id_pagesubset.HUD_BASE, id_pagesubset.HUD_TEST_COMMON, id_pagesubset.HUD_TEST_BIT_FAULT_DISP}
pages[id_Page.PAGE_HUD_TEST_AAS_MAN_FXD] =
	{id_pagesubset.HUD_BASE, id_pagesubset.HUD_TEST_COMMON, id_pagesubset.HUD_TEST_AAS_MAN_FXD}
pages[id_Page.PAGE_HUD_TEST_AAS_MAN_RTY] =
	{id_pagesubset.HUD_BASE, id_pagesubset.HUD_TEST_COMMON, id_pagesubset.HUD_TEST_AAS_MAN_RTY}
pages[id_Page.PAGE_HUD_TEST_WPNS_30MM] =
	{id_pagesubset.HUD_BASE, id_pagesubset.HUD_TEST_COMMON, id_pagesubset.HUD_TEST_WPNS_30MM}
pages[id_Page.PAGE_HUD_TEST_WPNS_OFFSET_ADJ] =
	{id_pagesubset.HUD_BASE, id_pagesubset.HUD_TEST_COMMON, id_pagesubset.HUD_TEST_WPNS_OFFSET_ADJ}
pages[id_Page.PAGE_HUD_TEST_GCAS_BIT] =
	{id_pagesubset.HUD_BASE, id_pagesubset.HUD_TEST_GCAS_BIT}
pages[id_Page.PAGE_HUD_TEST_PREFLIGHT_BIT] =
	{id_pagesubset.HUD_BASE, id_pagesubset.HUD_TEST_PREFLIGHT_BIT}
pages[id_Page.PAGE_HUD_TEST_GCAS_TRAINING] =
	{id_pagesubset.HUD_BASE, id_pagesubset.HUD_TEST_COMMON, id_pagesubset.HUD_TEST_GCAS_TRAINING}
pages[id_Page.PAGE_HUD_TEST_GCAS_CAPTURE] =
	{id_pagesubset.HUD_BASE, id_pagesubset.HUD_TEST_COMMON, id_pagesubset.HUD_TEST_GCAS_CAPTURE}
pages[id_Page.PAGE_HUD_TEST_DELTA_CAL] =
	{id_pagesubset.HUD_BASE, id_pagesubset.HUD_TEST_COMMON, id_pagesubset.HUD_TEST_DELTA_CAL}
pages[id_Page.PAGE_HUD_TEST_IFF_ALERT] =
	{id_pagesubset.HUD_BASE, id_pagesubset.HUD_TEST_COMMON, id_pagesubset.HUD_TEST_IFF_ALERT}
pages[id_Page.PAGE_HUD_TEST_WPN_RELEASE] =
	{id_pagesubset.HUD_BASE, id_pagesubset.HUD_TEST_COMMON, id_pagesubset.HUD_TEST_WPN_RELEASE}
pages[id_Page.PAGE_HUD_TEST_WPN_REL_GUNS] =
	{id_pagesubset.HUD_BASE, id_pagesubset.HUD_TEST_COMMON, id_pagesubset.HUD_TEST_WPN_REL_GUNS}
pages[id_Page.PAGE_HUD_TEST_WPN_REL_CCIP] =
	{id_pagesubset.HUD_BASE, id_pagesubset.HUD_TEST_COMMON, id_pagesubset.HUD_TEST_WPN_REL_CCIP}
pages[id_Page.PAGE_HUD_TEST_WPN_REL_CCRP] =
	{id_pagesubset.HUD_BASE, id_pagesubset.HUD_TEST_COMMON, id_pagesubset.HUD_TEST_WPN_REL_CCRP}
pages[id_Page.PAGE_HUD_TEST_WPN_REL_MAV] =
	{id_pagesubset.HUD_BASE, id_pagesubset.HUD_TEST_COMMON, id_pagesubset.HUD_TEST_WPN_REL_MAV}
pages[id_Page.PAGE_HUD_TEST_MAINTENANCE] =
	{id_pagesubset.HUD_BASE, id_pagesubset.HUD_TEST_COMMON, id_pagesubset.HUD_TEST_MAINTENANCE}
pages[id_Page.PAGE_HUD_STANDBY]	= {id_pagesubset.HUD_BASE, id_pagesubset.HUD_STANDBY}
pages[id_Page.PAGE_HUD_TEST_VMU_BIT] = {id_pagesubset.HUD_BASE, id_pagesubset.HUD_TEST_VMU_BIT}
	
init_pageID		= id_Page.PAGE_OFF
use_parser		= false

-- master modes
A10C_HUD_OFF				= 0
A10C_HUD_NAV				= 1 
A10C_HUD_GUNS				= 2
A10C_HUD_CCIP				= 3
A10C_HUD_CCRP				= 4
A10C_HUD_AIR_TO_AIR			= 5
A10C_HUD_TEST				= 6
A10C_HUD_STANDBY			= 7
A10C_HUD_TEST_POWER_ON		= 8

-- level 2
A10C_HUD_TEST_GROUND_BIT		= 1
A10C_HUD_TEST_INFLT_BIT			= 2
A10C_HUD_TEST_BIT_FAULT_DISP	= 3
A10C_HUD_TEST_AAS				= 4
A10C_HUD_TEST_WEAPONS			= 5
A10C_HUD_TEST_WPN_REL_DATA		= 6
A10C_HUD_TEST_DISPLAY_MODES		= 7
A10C_HUD_TEST_MAINTENANCE		= 8
A10C_HUD_TEST_DELTA_CAL			= 9
A10C_HUD_TEST_GCAS_BIT			= 10
A10C_HUD_TEST_PREFLIGHT_BIT		= 11
A10C_HUD_TEST_GCAS_TRAINING		= 12
A10C_HUD_TEST_IFF_ALERT			= 13
A10C_HUD_TEST_WPN_RELEASE		= 14
A10C_HUD_TEST_VMU_BIT			= 15

-- level 3
A10C_HUD_TEST_AAS_MAN_FXD		= 1
A10C_HUD_TEST_AAS_MAN_RTY		= 2

A10C_HUD_TEST_WPNS_30MM			= 1
A10C_HUD_TEST_WPNS_OFFSET_ADJ	= 2

A10C_HUD_TEST_WPN_REL_GUNS		= 1
A10C_HUD_TEST_WPN_REL_CCIP		= 2
A10C_HUD_TEST_WPN_REL_CCRP		= 3
A10C_HUD_TEST_WPN_REL_MAV		= 4
	
A10C_HUD_TEST_GCAS_CAPTURE		= 1	
------------------------------------
pages_by_mode                 = {}
clear_mode_table(pages_by_mode, 9, 15, 4)

function get_page_by_mode(master,L2,L3,L4)
	return get_page_by_mode_global(pages_by_mode,init_pageID,master,L2,L3,L4)
end

pages_by_mode[A10C_HUD_OFF][0][0][0]		  = id_Page.PAGE_OFF
pages_by_mode[A10C_HUD_NAV][0][0][0]		  = id_Page.PAGE_HUD_NAV
pages_by_mode[A10C_HUD_GUNS][0][0][0]		  = id_Page.PAGE_HUD_GUNS
pages_by_mode[A10C_HUD_CCIP][0][0][0]		  = id_Page.PAGE_HUD_CCIP
pages_by_mode[A10C_HUD_CCRP][0][0][0]		  = id_Page.PAGE_HUD_CCRP
pages_by_mode[A10C_HUD_AIR_TO_AIR][0][0][0]	  = id_Page.PAGE_HUD_AIR_TO_AIR
pages_by_mode[A10C_HUD_STANDBY][0][0][0]	  = id_Page.PAGE_HUD_STANDBY

pages_by_mode[A10C_HUD_TEST][0][0][0] =
	id_Page.PAGE_HUD_TEST
pages_by_mode[A10C_HUD_TEST_POWER_ON][0][0][0] =
	id_Page.PAGE_HUD_TEST_POWER_ON
pages_by_mode[A10C_HUD_TEST][A10C_HUD_TEST_GROUND_BIT][0][0] =
	id_Page.PAGE_HUD_TEST_GROUND_BIT
pages_by_mode[A10C_HUD_TEST][A10C_HUD_TEST_INFLT_BIT][0][0] =
	id_Page.PAGE_HUD_TEST_INFLT_BIT
pages_by_mode[A10C_HUD_TEST][A10C_HUD_TEST_BIT_FAULT_DISP][0][0] =
	id_Page.PAGE_HUD_TEST_BIT_FAULT_DISP
pages_by_mode[A10C_HUD_TEST][A10C_HUD_TEST_GCAS_BIT][0][0] =
	id_Page.PAGE_HUD_TEST_GCAS_BIT
pages_by_mode[A10C_HUD_TEST][A10C_HUD_TEST_PREFLIGHT_BIT][0][0] =
	id_Page.PAGE_HUD_TEST_PREFLIGHT_BIT
pages_by_mode[A10C_HUD_TEST][A10C_HUD_TEST_AAS][0][0] =
	id_Page.PAGE_HUD_TEST_AAS
pages_by_mode[A10C_HUD_TEST][A10C_HUD_TEST_AAS][A10C_HUD_TEST_AAS_MAN_FXD][0] =
	id_Page.PAGE_HUD_TEST_AAS_MAN_FXD
pages_by_mode[A10C_HUD_TEST][A10C_HUD_TEST_AAS][A10C_HUD_TEST_AAS_MAN_RTY][0] =
	id_Page.PAGE_HUD_TEST_AAS_MAN_RTY
pages_by_mode[A10C_HUD_TEST][A10C_HUD_TEST_WEAPONS][0][0] =
	id_Page.PAGE_HUD_TEST_WEAPONS
pages_by_mode[A10C_HUD_TEST][A10C_HUD_TEST_WEAPONS][A10C_HUD_TEST_WPNS_30MM][0] =
	id_Page.PAGE_HUD_TEST_WPNS_30MM
pages_by_mode[A10C_HUD_TEST][A10C_HUD_TEST_WEAPONS][A10C_HUD_TEST_WPNS_OFFSET_ADJ][0] =
	id_Page.PAGE_HUD_TEST_WPNS_OFFSET_ADJ
pages_by_mode[A10C_HUD_TEST][A10C_HUD_TEST_DISPLAY_MODES][0][0] =
	id_Page.PAGE_HUD_TEST_DISPLAY_MODES
pages_by_mode[A10C_HUD_TEST][A10C_HUD_TEST_GCAS_TRAINING][0][0] =
	id_Page.PAGE_HUD_TEST_GCAS_TRAINING	
pages_by_mode[A10C_HUD_TEST][A10C_HUD_TEST_GCAS_TRAINING][A10C_HUD_TEST_GCAS_CAPTURE][0] =
	id_Page.PAGE_HUD_TEST_GCAS_CAPTURE
pages_by_mode[A10C_HUD_TEST][A10C_HUD_TEST_DELTA_CAL][0][0] =
	id_Page.PAGE_HUD_TEST_DELTA_CAL
pages_by_mode[A10C_HUD_TEST][A10C_HUD_TEST_IFF_ALERT][0][0] =
	id_Page.PAGE_HUD_TEST_IFF_ALERT
pages_by_mode[A10C_HUD_TEST][A10C_HUD_TEST_WPN_RELEASE][0][0] =
	id_Page.PAGE_HUD_TEST_WPN_RELEASE
pages_by_mode[A10C_HUD_TEST][A10C_HUD_TEST_WPN_RELEASE][A10C_HUD_TEST_WPN_REL_GUNS][0] =
	id_Page.PAGE_HUD_TEST_WPN_REL_GUNS
pages_by_mode[A10C_HUD_TEST][A10C_HUD_TEST_WPN_RELEASE][A10C_HUD_TEST_WPN_REL_CCIP][0] =
	id_Page.PAGE_HUD_TEST_WPN_REL_CCIP
pages_by_mode[A10C_HUD_TEST][A10C_HUD_TEST_WPN_RELEASE][A10C_HUD_TEST_WPN_REL_CCRP][0] =
	id_Page.PAGE_HUD_TEST_WPN_REL_CCRP
pages_by_mode[A10C_HUD_TEST][A10C_HUD_TEST_WPN_RELEASE][A10C_HUD_TEST_WPN_REL_MAV][0] =
	id_Page.PAGE_HUD_TEST_WPN_REL_MAV
pages_by_mode[A10C_HUD_TEST][A10C_HUD_TEST_MAINTENANCE][0][0] =
	id_Page.PAGE_HUD_TEST_MAINTENANCE
pages_by_mode[A10C_HUD_TEST][A10C_HUD_TEST_VMU_BIT][0][0] =
	id_Page.PAGE_HUD_TEST_VMU_BIT
	
--IAM_sliding_range = true  -- option for IAM
piper_range_scales =
{
	12000,
	24000,
	36000
}

opacity_sensitive_materials = 
{
"INDICATION_HUD",
"INDICATION_HUD_STANDBY",
"INDICATION_LINES_HUD",
"font_HUD",
"font_HUD_STANDBY",
}

color_sensitive_materials = 
{
"INDICATION_HUD",
"INDICATION_LINES_HUD",
"font_HUD",
}

day_color    = {0, 255/255, 0, 255/255}
night_color  = {243/255, 116/255, 13/255, 255/255}
