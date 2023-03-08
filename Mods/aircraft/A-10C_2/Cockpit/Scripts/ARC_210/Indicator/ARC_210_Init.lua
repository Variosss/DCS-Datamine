dofile("Mods\\aircraft\\A-10C_2\\Cockpit\\Scripts\\ARC_210\\devices_defs.lua") 
dofile(LockOn_Options.script_path.."materials.lua")


indicator_type 	 = indicator_types.COMMON

-- mode enums
ARC_210_NONE			= 0
ARC_210_POWER_ON		= 1
ARC_210_TEST			= 2
ARC_210_TR				= 3

--TEST submodes
ARC_210_TEST_START		= 0
ARC_210_TEST_PROGRES	= 1

--TR submodes
ARC_210_TR_PRSET		= 0
ARC_210_TR_MAN			= 1


-------PAGE IDs-------
id_Page =
{
	PAGE_ARC_210_NONE			= 0,
	PAGE_ARC_210_POWER_ON		= 1,
	PAGE_ARC_210_TEST			= 2,
	PAGE_ARC_210_TEST_PROGRES	= 3,
	PAGE_ARC_210_TR_PRSET		= 4,
	PAGE_ARC_210_TR_MAN			= 5,
}

id_pagesubset =
{
	ARC_210_NONE				= 0,
	ARC_210_POWER_ON			= 1,
	ARC_210_TEST				= 2,
	ARC_210_TEST_PROGRES		= 3,
	ARC_210_TR_PRSET			= 4,
	ARC_210_TR_MAN				= 5,
	ARC_210_CUR_FREQ_MOD		= 6,
}

page_subsets = {}
page_subsets[id_pagesubset.ARC_210_NONE]   			= LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_page_POWER_ON.lua"
page_subsets[id_pagesubset.ARC_210_POWER_ON]   		= LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_page_POWER_ON.lua"
page_subsets[id_pagesubset.ARC_210_TEST]   			= LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_page_TEST.lua"
page_subsets[id_pagesubset.ARC_210_TEST_PROGRES]   	= LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_page_TEST_PROGRES.lua"
page_subsets[id_pagesubset.ARC_210_TR_PRSET]   		= LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_page_TR_PRSET.lua"
page_subsets[id_pagesubset.ARC_210_TR_MAN]   		= LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_page_TR_MAN.lua"
page_subsets[id_pagesubset.ARC_210_CUR_FREQ_MOD]	= LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_page_CUR_FREQ_MOD.lua"

----------------------
pages = {}
pages[id_Page.PAGE_ARC_210_NONE]			= {}
pages[id_Page.PAGE_ARC_210_POWER_ON] 		= {id_pagesubset.ARC_210_POWER_ON}
pages[id_Page.PAGE_ARC_210_TEST] 			= {id_pagesubset.ARC_210_TEST}
pages[id_Page.PAGE_ARC_210_TEST_PROGRES] 	= {id_pagesubset.ARC_210_TEST_PROGRES}
pages[id_Page.PAGE_ARC_210_TR_PRSET] 		= {id_pagesubset.ARC_210_TR_PRSET, id_pagesubset.ARC_210_CUR_FREQ_MOD}
pages[id_Page.PAGE_ARC_210_TR_MAN] 			= {id_pagesubset.ARC_210_TR_MAN, id_pagesubset.ARC_210_CUR_FREQ_MOD}

--init_pageID          = id_Page.PAGE_MFCD_NONE
use_parswer            = false
HUD_Only_status        = false
--HUD_Only_scale       = 10;
--HUD_Only_diplacement = {0.5*1.3333, -0.3};

function get_page_by_mode(master, L2, L3, L4)
	return get_page_by_mode_global(pages_by_mode, init_pageID, master, L2, L3, L4)
end

pages_by_mode = {}
clear_mode_table(pages_by_mode, 3, 2, 5)

pages_by_mode[ARC_210_NONE]		[0][0][0]   = id_Page.PAGE_ARC_210_NONE
pages_by_mode[ARC_210_POWER_ON]	[0][0][0]   = id_Page.PAGE_ARC_210_POWER_ON
pages_by_mode[ARC_210_TEST]		[ARC_210_TEST_START][0][0]		= id_Page.PAGE_ARC_210_TEST
pages_by_mode[ARC_210_TEST]		[ARC_210_TEST_PROGRES][0][0]	= id_Page.PAGE_ARC_210_TEST_PROGRES
pages_by_mode[ARC_210_TR]		[ARC_210_TR_PRSET][0][0]	= id_Page.PAGE_ARC_210_TR_PRSET
pages_by_mode[ARC_210_TR]		[ARC_210_TR_MAN][0][0]	= id_Page.PAGE_ARC_210_TR_MAN
