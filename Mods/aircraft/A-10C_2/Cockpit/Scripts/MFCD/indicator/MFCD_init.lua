dofile(LockOn_Options.common_script_path.."devices_defs.lua")
dofile(LockOn_Options.script_path.."materials.lua")
dofile(LockOn_Options.script_path.."config.lua")

local USE_BAKED = true

function GetScale() 
return 1
end
dofile(LockOn_Options.script_path.."MFCD/indicator/MFCD_sizes.lua")

if USE_BAKED then
	purposes 	 	 = {100} -- avoid direct call
else
	dofile(LockOn_Options.common_script_path.."ViewportHandling.lua")

	update_screenspace_diplacement(1.0,disposition == 'L')	

	if disposition == 'L' then
		try_find_assigned_viewport("LEFT_MFCD")
	else 
		try_find_assigned_viewport("RIGHT_MFCD")
	end

	purposes 	 = {render_purpose.GENERAL,render_purpose.HUD_ONLY_VIEW}
end


indicator_type 	 = indicator_types.COMMON
used_render_mask = "interleave.dds"

DSMS_master_arm_colors = 
{
	 materials["MFCD_BLUE"],	--MASTER_ARM_TRAINING,
	 materials["MFCD_WHITE"],	--MASTER_ARM_SAFE,
	 materials["MFCD_GREEN"],	--MASTER_ARM_ON
}

MFCD_colors = 
{
	 materials["INDICATION_COMMON_BLACK"],--BLACK
	 materials["MFCD_GREEN"],			  --GREEN
	 materials["MFCD_RED"],				  --RED
	 materials["MFCD_WHITE"], 			  --WHITE
	 materials["MFCD_YELLOW"],	 		  --YELLOW
     materials["MFCD_BLUE"],	  		  --BLUE
}

MFCD_colors_night = MFCD_colors
--[[
{
	 materials["INDICATION_COMMON_BLACK"],--BLACK (REPLACE FOR NIGHT)
	 materials["MFCD_RED"],			  	  --GREEN (REPLACE FOR NIGHT)
	 materials["MFCD_RED"],				  --RED	  (REPLACE FOR NIGHT)
	 materials["MFCD_WHITE"], 			  --WHITE (REPLACE FOR NIGHT)
	 materials["MFCD_VIOLET"],	 		  --YELLOW(REPLACE FOR NIGHT)
     materials["MFCD_BLUE"],	  		  --BLUE  (REPLACE FOR NIGHT)
}
-]]


-- mode enums

MFCD_NONE			 = 0
MFCD_DTS_UPLOAD 	 = 1
MFCD_DISPLAY_PROGRAM = 2
MFCD_STAT 			 = 3
MFCD_MAV 			 = 4
MFCD_DSMS 			 = 5
MFCD_TGP 			 = 6
MFCD_TAD 			 = 7
MFCD_MSG 			 = 8
-- special mode to draw TGP video on HMCS
MFCD_VIDEO_OUT		 = 9

MFCD_TEST_CICU		 = 11
MFCD_TEST_DISP  	 = 12
MFCD_TEST_KEYS		 = 13
MFCD_TEST_HOTAS 	 = 14

MFCD_CICU_INIT		 = 15

MFCD_COMM			 = 17

--submodes TGP
MFCD_TGP_STBY = 1
MFCD_TGP_AA	  = 2
MFCD_TGP_AG   = 3

--submodes TGP STBY
MFCD_TGP_STBY_INIT	  = 1
MFCD_TGP_STBY_BIT	  = 2
MFCD_TGP_STBY_CONTROL = 3

--submodes TGP AG
MFCD_TGP_AG_CONTROL = 1

--submodes TGP AA
MFCD_TGP_AA_CONTROL = 1

--submodes STAT
MFCD_STAT_PAGE1 = 0
MFCD_STAT_PAGE2 = 1
-- STAT HMCS
MFCD_STAT_HMCS_PAGE1 = 2
MFCD_STAT_HMCS_PAGE2 = 3
--A10C2 specific STAT page
MFCD_STAT_PAGE3 = 4

--submodes COMM
MFCD_COMM_PAGE1             = 1
MFCD_COMM_PAGE2             = 2
MFCD_COMM_PAGE3             = 3
MFCD_COMM_PAGE4             = 4

-- submodes MSG
MFCD_MSG_NO_PAGE   = 0
MFCD_MSG_TEXT_PAGE = 1
MFCD_MSG_CAS_PAGE  = 2
MFCD_MSG_MA_PAGE   = 3

-------PAGE IDs-------
id_Page =
{
	PAGE_MFCD_NONE						= 0,
	PAGE_MFCD_DTS_UPLOAD				= 1,
	PAGE_MFCD_DISPLAY_PROGRAM			= 2,
	PAGE_MFCD_MAV						= 4,
	PAGE_MFCD_DSMS						= 5,
	PAGE_MFCD_TGP						= 6,
	PAGE_MFCD_TAD						= 7,
	PAGE_MFCD_DSMS_PROFILE_LIST			= 8,
	PAGE_MFCD_DSMS_VIEW_PROFILE			= 9,
	PAGE_MFCD_DSMS_PROFILE_SETTINGS		= 10,
	PAGE_MFCD_TGP_STBY					= 11,
	PAGE_MFCD_TGP_AA					= 12,
	PAGE_MFCD_TGP_AG					= 13,
	PAGE_MFCD_TGP_STBY_CONTROL			= 14,
	PAGE_MFCD_TGP_AG_CONTROL			= 15,
	PAGE_MFCD_TGP_AA_CONTROL			= 16,
	PAGE_MFCD_DSMS_INVENTORY			= 17,
	PAGE_MFCD_DSMS_INVENTORY_SELECT		= 18,
	PAGE_MFCD_DSMS_INVENTORY_BOMB		= 19,
	PAGE_MFCD_DSMS_INVENTORY_CBU		= 20,
	PAGE_MFCD_DSMS_INVENTORY_GBU		= 21,
	PAGE_MFCD_DSMS_INVENTORY_RACK		= 22,
	PAGE_MFCD_DSMS_INVENTORY_AIR		= 23,
	PAGE_MFCD_DSMS_INVENTORY_POD		= 24,
	PAGE_MFCD_DSMS_INVENTORY_MAVERICK	= 25,
	PAGE_MFCD_DSMS_INVENTORY_MISC		= 26,
	PAGE_MFCD_DSMS_INVENTORY_BDU33		= 27,
	PAGE_MFCD_DSMS_INVENTORY_ROCKET		= 28,
	PAGE_MFCD_DSMS_INVENTORY_MK84		= 29,
	PAGE_MFCD_DSMS_INVENTORY_MK82		= 30,
	PAGE_MFCD_DSMS_INVENTORY_GBU10		= 31,
	PAGE_MFCD_DSMS_INVENTORY_GBU12		= 32,
	PAGE_MFCD_DSMS_INVENTORY_GBU31		= 33,
	PAGE_MFCD_DSMS_INVENTORY_GBU38		= 34,
	PAGE_MFCD_DSMS_INVENTORY_CBU87		= 35,
	PAGE_MFCD_DSMS_INVENTORY_CBU89		= 36,
	PAGE_MFCD_DSMS_INVENTORY_CBU97		= 37,
	PAGE_MFCD_DSMS_INVENTORY_BDU56		= 38,
	PAGE_MFCD_DSMS_INVENTORY_BDU50		= 39,
	PAGE_MFCD_DSMS_INVENTORY_MK82A		= 40,
	PAGE_MFCD_DSMS_INVENTORY_FLARE		= 41,
	PAGE_MFCD_DSMS_INVENTORY_CBU103		= 42,
	PAGE_MFCD_DSMS_INVENTORY_CBU104		= 43,
	PAGE_MFCD_DSMS_INVENTORY_CBU105		= 44,
	PAGE_MFCD_DSMS_MISSILE_CONTROL		= 45,
	PAGE_MFCD_DSMS_SELECTIVE_JETTISON	= 46,
	
	PAGE_MFCD_TAD_PROFILE_PROGRAM	    = 47,
	PAGE_MFCD_STAT_PAGE1				= 48,
	PAGE_MFCD_STAT_PAGE2				= 49,
	
	PAGE_MFCD_TGP_STBYINIT				= 50,
	PAGE_MFCD_TGP_STBYBIT				= 51,
	
	PAGE_MFCD_TAD_CONTROL				= 52,
	PAGE_MFCD_TAD_CONTROL_SETTINGS		= 53,
	
	PAGE_MFCD_MSG_TEXT					= 54,
	PAGE_MFCD_MSG_CAS					= 55,
	PAGE_MFCD_MSG_MA					= 56,
	
	PAGE_MFCD_TAD_MA_TABLE				= 57,
    PAGE_MFCD_TAD_TDL                   = 58,
    PAGE_MFCD_TAD_SADL                  = 59,
	
	PAGE_MFCD_TEST_CICU					= 60,
	PAGE_MFCD_TEST_DISP					= 61,
	PAGE_MFCD_TEST_KEYS					= 62,
	PAGE_MFCD_TEST_HOTAS				= 63,

	-- special page to draw TGP video on HMCS	
	PAGE_MFCD_TGP_VIDEO_OUT				= 64,
	
	-- HMCS
	PAGE_MFCD_STAT_HMCS_PAGE1			= 65,
	PAGE_MFCD_STAT_HMCS_PAGE2			= 66,
	
	PAGE_MFCD_DSMS_INVENTORY_GBU54		= 67,
	
	PAGE_MFCD_COMM						= 68,
	PAGE_MFCD_COMM_PAGE_1				= 69,
	PAGE_MFCD_COMM_PAGE_2				= 70,
	PAGE_MFCD_COMM_PAGE_3				= 71,
	PAGE_MFCD_COMM_PAGE_4				= 72,
	
	PAGE_MFCD_STAT_PAGE3				= 73,
}

id_pagesubset =
{
	MFCD_NONE_MAIN				= 0,
	MFCD_DTS_UPLOAD_MAIN		= 1,
	MFCD_DISPLAY_PROGRAM_MAIN	= 2,
	MFCD_MAV_MAIN				= 4,
	MFCD_DSMS_MAIN				= 5,
	MFCD_TGP_MAIN				= 6,
	MFCD_TAD_MAIN				= 7,
	MFCD_OSB_11_15				= 8,
	MFCD_BACKGROUND				= 9,
	MFCD_DSMS_STATIONS			= 10,
	MFCD_DSMS_PROFILE_LIST		= 11,
	MFCD_DSMS_VIEW_PROFILE		= 12,
	MFCD_DSMS_PROFILE_TABLE		= 13,
	MFCD_DSMS_PROFILE_SETTINGS	= 14,
	MFCD_TGP_STBY_PAGE 			= 15,
	MFCD_TGP_AA_PAGE   			= 16,
	MFCD_TGP_AG_PAGE			= 17,
	MFCD_TGP_RENDERED_PAGE		= 18,
	MFCD_MAV_RENDERED_PAGE		= 19,
	MFCD_TGP_RENDERED_PAGE		= 20,
	MFCD_MAV_RENDERED_PAGE		= 21,
	MFCD_TGP_STBY_CONTROL_PAGE	= 22,
	MFCD_TGP_AG_CONTROL_PAGE	= 23,
	MFCD_TGP_AA_CONTROL_PAGE	= 24,
	MFCD_DSMS_INVENTORY			= 25,
	MFCD_DSMS_INVENTORY_SELECT	= 26,
	MFCD_CDU_REPEATER			= 27,
	MFCD_DSMS_INVENTORY_BOMB	= 28,
	MFCD_DSMS_INVENTORY_CBU		= 29,
	MFCD_DSMS_INVENTORY_GBU		= 30,
	MFCD_DSMS_INVENTORY_RACK	= 31,
	MFCD_DSMS_INVENTORY_AIR		= 32,
	MFCD_DSMS_INVENTORY_POD		= 33,
	MFCD_DSMS_INVENTORY_MAVERICK= 34,
	MFCD_DSMS_INVENTORY_MISC	= 35,
	MFCD_DSMS_INVENTORY_BDU33	= 36,
	MFCD_DSMS_INVENTORY_ROCKET	= 37,
	MFCD_DSMS_INVENTORY_MK84	= 38,
	MFCD_DSMS_INVENTORY_MK82	= 39,
	MFCD_DSMS_INVENTORY_GBU10	= 40,
	MFCD_DSMS_INVENTORY_GBU12	= 41,
	MFCD_DSMS_INVENTORY_GBU31	= 42,
	MFCD_DSMS_INVENTORY_GBU38	= 43,
	MFCD_DSMS_INVENTORY_CBU87	= 44,
	MFCD_DSMS_INVENTORY_CBU89	= 45,
	MFCD_DSMS_INVENTORY_CBU97	= 46,
	MFCD_DSMS_INVENTORY_BDU56	= 47,
	MFCD_DSMS_INVENTORY_BDU50	= 48,
	MFCD_DSMS_INVENTORY_MK82A	= 49,
	MFCD_DSMS_INVENTORY_FLARE	= 50,
	MFCD_DSMS_INVENTORY_CBU103	= 51,
	MFCD_DSMS_INVENTORY_CBU104	= 52,
	MFCD_DSMS_INVENTORY_CBU105	= 53,
	MFCD_DSMS_MISSILE_CONTROL	= 54,
	MFCD_DSMS_SELECTIVE_JETTISON= 55,
	
	MFCD_TAD_CHART				= 56,
	MFCD_TAD_BACK				= 57,
	MFCD_TAD_PROFILE_PROGRAM_PAGE=58,
	MFCD_TAD_PROFILE_SELECT_OSB_02_05=59,
	MFCD_STAT_COMMON			= 60,
	MFCD_STAT_PAGE1				= 61,
	MFCD_STAT_PAGE2				= 62,
	MFCD_TAD_OBJECTS			= 63,
	
	MFCD_TGP_STBY_PAGE_INIT		= 64,
	MFCD_TGP_RENDER_VIDEO		= 65,
	MFCD_TGP_RENDER_SYMBOLOGY	= 66,
	MFCD_TGP_RENDER_STBYINIT	= 67,
	MFCD_TGP_RENDER_STBYBIT		= 68,
	MFCD_TGP_STBY_CONTROL_PAGE	= 69,
	MFCD_TGP_STBY_PAGE_OPER		= 70,
	
	MFCD_TAD_MAP 				= 71,
	MFCD_TAD_CONTROL			= 72,
	MFCD_TAD_CONTROL_SETTINGS	= 73,
	
	MFCD_MSG					= 74,
	MFCD_MSG_TEXT				= 75,
	MFCD_MSG_CAS				= 76,
	MFCD_MSG_MA					= 77,
	
	MFCD_TAD_MA_TABLE			= 78,
    MFCD_TAD_TDL                = 79,
    
    MFCD_TGP_OFF				= 80,
    
    MFCD_TAD_SADL               = 81,
	MFCD_DSMS_STATIONS_SJ		= 82,
	
	MFCD_TEST_CICU				= 83,
	MFCD_TEST_DISP				= 84,
	MFCD_TEST_KEYS				= 85,
	MFCD_TEST_HOTAS				= 86,
	
	-- HMCS
	MFCD_STAT_HMCS_PAGE1		= 87,
	MFCD_STAT_HMCS_PAGE2		= 88,
	
	MFCD_DSMS_INVENTORY_GBU54	= 89,
	
	MFCD_COMM_MAIN				= 90,
	MFCD_COMM_PAGE_1			= 91,
	MFCD_COMM_PAGE_2			= 92,
	MFCD_COMM_PAGE_3			= 93,
	MFCD_COMM_PAGE_4			= 94,
	
	MFCD_STAT_PAGE3				= 95,
}

page_subsets = {}
page_subsets[id_pagesubset.MFCD_NONE_MAIN]   			= LockOn_Options.script_path.."MFCD/indicator/MFCD_page_DTS_UPLOAD.lua"
page_subsets[id_pagesubset.MFCD_DTS_UPLOAD_MAIN]  		= LockOn_Options.script_path.."MFCD/indicator/MFCD_page_DTS_UPLOAD.lua"
page_subsets[id_pagesubset.MFCD_DISPLAY_PROGRAM_MAIN]   = LockOn_Options.script_path.."MFCD/indicator/MFCD_page_DISPLAY_PROGRAM.lua"
page_subsets[id_pagesubset.MFCD_MAV_MAIN]   			= LockOn_Options.script_path.."MFCD/indicator/MAV/MFCD_page_MAV.lua"
page_subsets[id_pagesubset.MFCD_DSMS_MAIN]   			= LockOn_Options.script_path.."MFCD/indicator/DSMS/MFCD_page_DSMS.lua"
page_subsets[id_pagesubset.MFCD_TAD_MAIN]   			= LockOn_Options.script_path.."MFCD/indicator/TAD/MFCD_page_TAD.lua"
page_subsets[id_pagesubset.MFCD_OSB_11_15]				= LockOn_Options.script_path.."MFCD/indicator/MFCD_page_OSB_11_15.lua"
page_subsets[id_pagesubset.MFCD_BACKGROUND]				= LockOn_Options.script_path.."MFCD/indicator/MFCD_page_BACKGROUND.lua"
page_subsets[id_pagesubset.MFCD_DSMS_STATIONS]			= LockOn_Options.script_path.."MFCD/indicator/DSMS/MFCD_page_DSMS_stations.lua"
page_subsets[id_pagesubset.MFCD_DSMS_PROFILE_LIST]		= LockOn_Options.script_path.."MFCD/indicator/DSMS/MFCD_page_DSMS_profile_list.lua"
page_subsets[id_pagesubset.MFCD_DSMS_VIEW_PROFILE]		= LockOn_Options.script_path.."MFCD/indicator/DSMS/MFCD_page_DSMS_view_profile.lua"
page_subsets[id_pagesubset.MFCD_DSMS_PROFILE_TABLE]		= LockOn_Options.script_path.."MFCD/indicator/DSMS/MFCD_page_DSMS_profile_table.lua"
page_subsets[id_pagesubset.MFCD_DSMS_PROFILE_SETTINGS]	= LockOn_Options.script_path.."MFCD/indicator/DSMS/MFCD_page_DSMS_profile_settings.lua"
page_subsets[id_pagesubset.MFCD_DSMS_INVENTORY]			= LockOn_Options.script_path.."MFCD/indicator/DSMS/MFCD_page_DSMS_inventory.lua"
page_subsets[id_pagesubset.MFCD_DSMS_INVENTORY_SELECT]	= LockOn_Options.script_path.."MFCD/indicator/DSMS/MFCD_page_DSMS_inventory_select.lua"
page_subsets[id_pagesubset.MFCD_DSMS_INVENTORY_BOMB]	= LockOn_Options.script_path.."MFCD/indicator/DSMS/MFCD_page_DSMS_inventory_bomb.lua"
page_subsets[id_pagesubset.MFCD_DSMS_INVENTORY_CBU]		= LockOn_Options.script_path.."MFCD/indicator/DSMS/MFCD_page_DSMS_inventory_cbu.lua"
page_subsets[id_pagesubset.MFCD_DSMS_INVENTORY_GBU]		= LockOn_Options.script_path.."MFCD/indicator/DSMS/MFCD_page_DSMS_inventory_gbu.lua"
page_subsets[id_pagesubset.MFCD_DSMS_INVENTORY_RACK]	= LockOn_Options.script_path.."MFCD/indicator/DSMS/MFCD_page_DSMS_inventory_rack.lua"
page_subsets[id_pagesubset.MFCD_DSMS_INVENTORY_AIR]		= LockOn_Options.script_path.."MFCD/indicator/DSMS/MFCD_page_DSMS_inventory_air.lua"
page_subsets[id_pagesubset.MFCD_DSMS_INVENTORY_POD]		= LockOn_Options.script_path.."MFCD/indicator/DSMS/MFCD_page_DSMS_inventory_pod.lua"
page_subsets[id_pagesubset.MFCD_DSMS_INVENTORY_MAVERICK]= LockOn_Options.script_path.."MFCD/indicator/DSMS/MFCD_page_DSMS_inventory_maverick.lua"
page_subsets[id_pagesubset.MFCD_DSMS_INVENTORY_MISC]	= LockOn_Options.script_path.."MFCD/indicator/DSMS/MFCD_page_DSMS_inventory_misc.lua"
page_subsets[id_pagesubset.MFCD_DSMS_INVENTORY_BDU33]	= LockOn_Options.script_path.."MFCD/indicator/DSMS/MFCD_page_DSMS_inventory_bdu33.lua"
page_subsets[id_pagesubset.MFCD_DSMS_INVENTORY_ROCKET]	= LockOn_Options.script_path.."MFCD/indicator/DSMS/MFCD_page_DSMS_inventory_rocket.lua"
page_subsets[id_pagesubset.MFCD_DSMS_INVENTORY_MK84]	= LockOn_Options.script_path.."MFCD/indicator/DSMS/MFCD_page_DSMS_inventory_mk84.lua"
page_subsets[id_pagesubset.MFCD_DSMS_INVENTORY_MK82]	= LockOn_Options.script_path.."MFCD/indicator/DSMS/MFCD_page_DSMS_inventory_mk82.lua"
page_subsets[id_pagesubset.MFCD_DSMS_INVENTORY_GBU10]	= LockOn_Options.script_path.."MFCD/indicator/DSMS/MFCD_page_DSMS_inventory_gbu10.lua"
page_subsets[id_pagesubset.MFCD_DSMS_INVENTORY_GBU12]	= LockOn_Options.script_path.."MFCD/indicator/DSMS/MFCD_page_DSMS_inventory_gbu12.lua"
page_subsets[id_pagesubset.MFCD_DSMS_INVENTORY_GBU31]	= LockOn_Options.script_path.."MFCD/indicator/DSMS/MFCD_page_DSMS_inventory_gbu31.lua"
page_subsets[id_pagesubset.MFCD_DSMS_INVENTORY_GBU38]	= LockOn_Options.script_path.."MFCD/indicator/DSMS/MFCD_page_DSMS_inventory_gbu38.lua"
page_subsets[id_pagesubset.MFCD_DSMS_INVENTORY_GBU54]	= LockOn_Options.script_path.."MFCD/indicator/DSMS/MFCD_page_DSMS_inventory_gbu54.lua"
page_subsets[id_pagesubset.MFCD_DSMS_INVENTORY_CBU87]	= LockOn_Options.script_path.."MFCD/indicator/DSMS/MFCD_page_DSMS_inventory_cbu87.lua"
page_subsets[id_pagesubset.MFCD_DSMS_INVENTORY_CBU89]	= LockOn_Options.script_path.."MFCD/indicator/DSMS/MFCD_page_DSMS_inventory_cbu89.lua"
page_subsets[id_pagesubset.MFCD_DSMS_INVENTORY_CBU97]	= LockOn_Options.script_path.."MFCD/indicator/DSMS/MFCD_page_DSMS_inventory_cbu97.lua"
page_subsets[id_pagesubset.MFCD_DSMS_INVENTORY_BDU56]	= LockOn_Options.script_path.."MFCD/indicator/DSMS/MFCD_page_DSMS_inventory_bdu56.lua"
page_subsets[id_pagesubset.MFCD_DSMS_INVENTORY_BDU50]	= LockOn_Options.script_path.."MFCD/indicator/DSMS/MFCD_page_DSMS_inventory_bdu50.lua"
page_subsets[id_pagesubset.MFCD_DSMS_INVENTORY_MK82A]	= LockOn_Options.script_path.."MFCD/indicator/DSMS/MFCD_page_DSMS_inventory_mk82a.lua"
page_subsets[id_pagesubset.MFCD_DSMS_INVENTORY_FLARE]	= LockOn_Options.script_path.."MFCD/indicator/DSMS/MFCD_page_DSMS_inventory_flare.lua"
page_subsets[id_pagesubset.MFCD_DSMS_MISSILE_CONTROL]	= LockOn_Options.script_path.."MFCD/indicator/DSMS/MFCD_page_DSMS_missile_control.lua"
page_subsets[id_pagesubset.MFCD_DSMS_INVENTORY_CBU103]	= LockOn_Options.script_path.."MFCD/indicator/DSMS/MFCD_page_DSMS_inventory_cbu103.lua"
page_subsets[id_pagesubset.MFCD_DSMS_INVENTORY_CBU104]	= LockOn_Options.script_path.."MFCD/indicator/DSMS/MFCD_page_DSMS_inventory_cbu104.lua"
page_subsets[id_pagesubset.MFCD_DSMS_INVENTORY_CBU105]	= LockOn_Options.script_path.."MFCD/indicator/DSMS/MFCD_page_DSMS_inventory_cbu105.lua"
page_subsets[id_pagesubset.MFCD_DSMS_SELECTIVE_JETTISON]= LockOn_Options.script_path.."MFCD/indicator/DSMS/MFCD_page_DSMS_selective_jettison.lua"
page_subsets[id_pagesubset.MFCD_MAV_RENDERED_PAGE]		= LockOn_Options.script_path.."MFCD/indicator/MAV/MFCD_page_MAV_RENDERED.lua"
page_subsets[id_pagesubset.MFCD_DSMS_STATIONS_SJ]		= LockOn_Options.script_path.."MFCD/indicator/DSMS/MFCD_page_DSMS_stations_sj.lua"

page_subsets[id_pagesubset.MFCD_TGP_MAIN]   			= LockOn_Options.script_path.."MFCD/indicator/TGP/MFCD_page_TGP.lua"
page_subsets[id_pagesubset.MFCD_TGP_OFF]   				= LockOn_Options.script_path.."MFCD/indicator/TGP/MFCD_page_TGP_OFF.lua"
page_subsets[id_pagesubset.MFCD_TGP_RENDER_VIDEO]		= LockOn_Options.script_path.."MFCD/indicator/TGP/MFCD_page_TGP_RENDER_REAL.lua"
page_subsets[id_pagesubset.MFCD_TGP_RENDER_SYMBOLOGY]	= LockOn_Options.script_path.."MFCD/indicator/TGP/MFCD_page_TGP_RENDER_MAIN.lua"
page_subsets[id_pagesubset.MFCD_TGP_RENDER_STBYINIT]	= LockOn_Options.script_path.."MFCD/indicator/TGP/MFCD_page_TGP_RENDER_STBYINIT.lua"
page_subsets[id_pagesubset.MFCD_TGP_RENDER_STBYBIT]		= LockOn_Options.script_path.."MFCD/indicator/TGP/MFCD_page_TGP_RENDER_STBYBIT.lua"
page_subsets[id_pagesubset.MFCD_TGP_STBY_PAGE]			= LockOn_Options.script_path.."MFCD/indicator/TGP/MFCD_page_TGP_STBY.lua"
page_subsets[id_pagesubset.MFCD_TGP_STBY_PAGE_INIT]		= LockOn_Options.script_path.."MFCD/indicator/TGP/MFCD_page_TGP_STBY_INIT.lua"
page_subsets[id_pagesubset.MFCD_TGP_STBY_PAGE_OPER]		= LockOn_Options.script_path.."MFCD/indicator/TGP/MFCD_page_TGP_STBY_OPER.lua"
page_subsets[id_pagesubset.MFCD_TGP_STBY_CONTROL_PAGE]	= LockOn_Options.script_path.."MFCD/indicator/TGP/MFCD_page_TGP_STBY_CONTROL.lua"
page_subsets[id_pagesubset.MFCD_TGP_AA_PAGE]			= LockOn_Options.script_path.."MFCD/indicator/TGP/MFCD_page_TGP_AA.lua"
page_subsets[id_pagesubset.MFCD_TGP_AA_CONTROL_PAGE]	= LockOn_Options.script_path.."MFCD/indicator/TGP/MFCD_page_TGP_AA_CONTROL.lua"
page_subsets[id_pagesubset.MFCD_TGP_AG_PAGE]			= LockOn_Options.script_path.."MFCD/indicator/TGP/MFCD_page_TGP_AG.lua"
page_subsets[id_pagesubset.MFCD_TGP_AG_CONTROL_PAGE]	= LockOn_Options.script_path.."MFCD/indicator/TGP/MFCD_page_TGP_AG_CONTROL.lua"

page_subsets[id_pagesubset.MFCD_CDU_REPEATER]			= LockOn_Options.script_path.."MFCD/indicator/CDU_repeater/MFCD_page_CDU.lua"

page_subsets[id_pagesubset.MFCD_TAD_BACK]				  	  = LockOn_Options.script_path.."MFCD/indicator/TAD/MFCD_page_TAD_BACK.lua"
page_subsets[id_pagesubset.MFCD_TAD_PROFILE_PROGRAM_PAGE] 	  = LockOn_Options.script_path.."MFCD/indicator/TAD/MFCD_page_TAD_PROFILE_PROGRAM.lua"
page_subsets[id_pagesubset.MFCD_TAD_PROFILE_SELECT_OSB_02_05] = LockOn_Options.script_path.."MFCD/indicator/TAD/MFCD_page_MFCD_TAD_PROFILE_SELECT_OSB_02_05.lua"

page_subsets[id_pagesubset.MFCD_STAT_COMMON]			= LockOn_Options.script_path.."MFCD/indicator/STAT/MFCD_page_STAT_common.lua"
page_subsets[id_pagesubset.MFCD_STAT_PAGE1] 			= LockOn_Options.script_path.."MFCD/indicator/STAT/MFCD_page_STAT_Page1.lua"
page_subsets[id_pagesubset.MFCD_STAT_PAGE2]				= LockOn_Options.script_path.."MFCD/indicator/STAT/MFCD_page_STAT_Page2.lua"
page_subsets[id_pagesubset.MFCD_STAT_PAGE3]				= LockOn_Options.script_path.."MFCD/indicator/STAT/MFCD_page_STAT_Page3.lua"
page_subsets[id_pagesubset.MFCD_STAT_HMCS_PAGE1] 		= LockOn_Options.script_path.."MFCD/indicator/STAT/MFCD_page_STAT_HMCS_Page1.lua"
page_subsets[id_pagesubset.MFCD_STAT_HMCS_PAGE2]		= LockOn_Options.script_path.."MFCD/indicator/STAT/MFCD_page_STAT_HMCS_Page2.lua"
	
page_subsets[id_pagesubset.MFCD_TEST_CICU]				= LockOn_Options.script_path.."MFCD/indicator/TEST/MFCD_page_TEST_CICU.lua"
page_subsets[id_pagesubset.MFCD_TEST_DISP]				= LockOn_Options.script_path.."MFCD/indicator/TEST/MFCD_page_TEST_DISP.lua"
page_subsets[id_pagesubset.MFCD_TEST_KEYS]				= LockOn_Options.script_path.."MFCD/indicator/TEST/MFCD_page_TEST_KEYS.lua"
page_subsets[id_pagesubset.MFCD_TEST_HOTAS]				= LockOn_Options.script_path.."MFCD/indicator/TEST/MFCD_page_TEST_HOTAS.lua"


page_subsets[id_pagesubset.MFCD_TAD_OBJECTS]			= LockOn_Options.script_path.."MFCD/indicator/TAD/MFCD_page_TAD_OBJECTS.lua"

page_subsets[id_pagesubset.MFCD_TAD_MAP]				= LockOn_Options.script_path.."MFCD/indicator/TAD/MFCD_page_TAD_MAP.lua"

page_subsets[id_pagesubset.MFCD_TAD_CONTROL]			= LockOn_Options.script_path.."MFCD/indicator/TAD/MFCD_page_TAD_CONTROL.lua"
page_subsets[id_pagesubset.MFCD_TAD_CONTROL_SETTINGS]	= LockOn_Options.script_path.."MFCD/indicator/TAD/MFCD_page_TAD_CONTROL_SETTINGS.lua"

page_subsets[id_pagesubset.MFCD_MSG]   					= LockOn_Options.script_path.."MFCD/indicator/MSG/MFCD_page_MSG.lua"
page_subsets[id_pagesubset.MFCD_MSG_TEXT]   			= LockOn_Options.script_path.."MFCD/indicator/MSG/MFCD_page_MSG_TEXT.lua"
page_subsets[id_pagesubset.MFCD_MSG_CAS]   				= LockOn_Options.script_path.."MFCD/indicator/MSG/MFCD_page_MSG_CAS.lua"
page_subsets[id_pagesubset.MFCD_MSG_MA]   				= LockOn_Options.script_path.."MFCD/indicator/MSG/MFCD_page_MSG_MA.lua"
	
page_subsets[id_pagesubset.MFCD_TAD_MA_TABLE]			= LockOn_Options.script_path.."MFCD/indicator/TAD/MFCD_page_TAD_MA_TABLE.lua"
page_subsets[id_pagesubset.MFCD_TAD_TDL]    			= LockOn_Options.script_path.."MFCD/indicator/TAD/MFCD_page_TAD_TDL.lua"
page_subsets[id_pagesubset.MFCD_TAD_SADL]    			= LockOn_Options.script_path.."MFCD/indicator/TAD/MFCD_page_TAD_SADL.lua"

page_subsets[id_pagesubset.MFCD_COMM_MAIN]    			= LockOn_Options.script_path.."MFCD/indicator/COMM/MFCD_page_COMM.lua"
page_subsets[id_pagesubset.MFCD_COMM_PAGE_1]    		= LockOn_Options.script_path.."MFCD/indicator/COMM/MFCD_page_COMM_PAGE_1.lua"
page_subsets[id_pagesubset.MFCD_COMM_PAGE_2]    		= LockOn_Options.script_path.."MFCD/indicator/COMM/MFCD_page_COMM_PAGE_2.lua"
page_subsets[id_pagesubset.MFCD_COMM_PAGE_3]    		= LockOn_Options.script_path.."MFCD/indicator/COMM/MFCD_page_COMM_PAGE_3.lua"
page_subsets[id_pagesubset.MFCD_COMM_PAGE_4]    		= LockOn_Options.script_path.."MFCD/indicator/COMM/MFCD_page_COMM_PAGE_4.lua"

----------------------
pages = {}
pages[id_Page.PAGE_MFCD_NONE] 						 	= {}
pages[id_Page.PAGE_MFCD_DTS_UPLOAD] 					= {id_pagesubset.MFCD_BACKGROUND , id_pagesubset.MFCD_DTS_UPLOAD_MAIN	  ,id_pagesubset.MFCD_OSB_11_15}
pages[id_Page.PAGE_MFCD_DISPLAY_PROGRAM] 				= {id_pagesubset.MFCD_BACKGROUND , id_pagesubset.MFCD_DISPLAY_PROGRAM_MAIN,id_pagesubset.MFCD_OSB_11_15}
pages[id_Page.PAGE_MFCD_MAV] 							= {id_pagesubset.MFCD_BACKGROUND , id_pagesubset.MFCD_MAV_RENDERED_PAGE	  ,id_pagesubset.MFCD_MAV_MAIN, id_pagesubset.MFCD_OSB_11_15}
pages[id_Page.PAGE_MFCD_DSMS] 							= {id_pagesubset.MFCD_BACKGROUND , id_pagesubset.MFCD_DSMS_MAIN			  , id_pagesubset.MFCD_DSMS_STATIONS, id_pagesubset.MFCD_OSB_11_15}
pages[id_Page.PAGE_MFCD_DSMS_PROFILE_LIST]				= {id_pagesubset.MFCD_BACKGROUND , id_pagesubset.MFCD_DSMS_PROFILE_LIST	  ,id_pagesubset.MFCD_OSB_11_15}
pages[id_Page.PAGE_MFCD_DSMS_VIEW_PROFILE]				= {id_pagesubset.MFCD_BACKGROUND , id_pagesubset.MFCD_DSMS_VIEW_PROFILE	  , id_pagesubset.MFCD_DSMS_PROFILE_TABLE, id_pagesubset.MFCD_OSB_11_15}
pages[id_Page.PAGE_MFCD_DSMS_PROFILE_SETTINGS]			= {id_pagesubset.MFCD_BACKGROUND , id_pagesubset.MFCD_DSMS_PROFILE_SETTINGS, id_pagesubset.MFCD_DSMS_PROFILE_TABLE, id_pagesubset.MFCD_OSB_11_15}
pages[id_Page.PAGE_MFCD_DSMS_INVENTORY] 				= {id_pagesubset.MFCD_BACKGROUND , id_pagesubset.MFCD_DSMS_STATIONS       , id_pagesubset.MFCD_DSMS_INVENTORY, id_pagesubset.MFCD_OSB_11_15}
pages[id_Page.PAGE_MFCD_DSMS_INVENTORY_SELECT] 			= {id_pagesubset.MFCD_BACKGROUND , id_pagesubset.MFCD_DSMS_INVENTORY_SELECT,id_pagesubset.MFCD_OSB_11_15}
pages[id_Page.PAGE_MFCD_DSMS_INVENTORY_BOMB] 			= {id_pagesubset.MFCD_BACKGROUND , id_pagesubset.MFCD_DSMS_INVENTORY_BOMB ,id_pagesubset.MFCD_OSB_11_15}
pages[id_Page.PAGE_MFCD_DSMS_INVENTORY_CBU] 			= {id_pagesubset.MFCD_BACKGROUND , id_pagesubset.MFCD_DSMS_INVENTORY_CBU  ,id_pagesubset.MFCD_OSB_11_15}
pages[id_Page.PAGE_MFCD_DSMS_INVENTORY_GBU] 			= {id_pagesubset.MFCD_BACKGROUND , id_pagesubset.MFCD_DSMS_INVENTORY_GBU  ,id_pagesubset.MFCD_OSB_11_15}
pages[id_Page.PAGE_MFCD_DSMS_INVENTORY_RACK] 			= {id_pagesubset.MFCD_BACKGROUND , id_pagesubset.MFCD_DSMS_INVENTORY_RACK ,id_pagesubset.MFCD_OSB_11_15}
pages[id_Page.PAGE_MFCD_DSMS_INVENTORY_AIR] 			= {id_pagesubset.MFCD_BACKGROUND , id_pagesubset.MFCD_DSMS_INVENTORY_AIR  ,id_pagesubset.MFCD_OSB_11_15}
pages[id_Page.PAGE_MFCD_DSMS_INVENTORY_POD] 			= {id_pagesubset.MFCD_BACKGROUND , id_pagesubset.MFCD_DSMS_INVENTORY_POD  ,id_pagesubset.MFCD_OSB_11_15}
pages[id_Page.PAGE_MFCD_DSMS_INVENTORY_MAVERICK] 		= {id_pagesubset.MFCD_BACKGROUND , id_pagesubset.MFCD_DSMS_INVENTORY_MAVERICK,id_pagesubset.MFCD_OSB_11_15}
pages[id_Page.PAGE_MFCD_DSMS_INVENTORY_MISC] 			= {id_pagesubset.MFCD_BACKGROUND , id_pagesubset.MFCD_DSMS_INVENTORY_MISC ,id_pagesubset.MFCD_OSB_11_15}
pages[id_Page.PAGE_MFCD_DSMS_INVENTORY_BDU33] 			= {id_pagesubset.MFCD_BACKGROUND , id_pagesubset.MFCD_DSMS_INVENTORY_BDU33,id_pagesubset.MFCD_OSB_11_15}
pages[id_Page.PAGE_MFCD_DSMS_INVENTORY_ROCKET] 			= {id_pagesubset.MFCD_BACKGROUND , id_pagesubset.MFCD_DSMS_INVENTORY_ROCKET,id_pagesubset.MFCD_OSB_11_15}
pages[id_Page.PAGE_MFCD_DSMS_INVENTORY_MK84] 			= {id_pagesubset.MFCD_BACKGROUND , id_pagesubset.MFCD_DSMS_INVENTORY_MK84  ,id_pagesubset.MFCD_OSB_11_15}
pages[id_Page.PAGE_MFCD_DSMS_INVENTORY_MK82] 			= {id_pagesubset.MFCD_BACKGROUND , id_pagesubset.MFCD_DSMS_INVENTORY_MK82  ,id_pagesubset.MFCD_OSB_11_15}
pages[id_Page.PAGE_MFCD_DSMS_INVENTORY_GBU10] 			= {id_pagesubset.MFCD_BACKGROUND , id_pagesubset.MFCD_DSMS_INVENTORY_GBU10 ,id_pagesubset.MFCD_OSB_11_15}
pages[id_Page.PAGE_MFCD_DSMS_INVENTORY_GBU12] 			= {id_pagesubset.MFCD_BACKGROUND , id_pagesubset.MFCD_DSMS_INVENTORY_GBU12 ,id_pagesubset.MFCD_OSB_11_15}
pages[id_Page.PAGE_MFCD_DSMS_INVENTORY_GBU31] 			= {id_pagesubset.MFCD_BACKGROUND , id_pagesubset.MFCD_DSMS_INVENTORY_GBU31 ,id_pagesubset.MFCD_OSB_11_15}
pages[id_Page.PAGE_MFCD_DSMS_INVENTORY_GBU38] 			= {id_pagesubset.MFCD_BACKGROUND , id_pagesubset.MFCD_DSMS_INVENTORY_GBU38 ,id_pagesubset.MFCD_OSB_11_15}
pages[id_Page.PAGE_MFCD_DSMS_INVENTORY_GBU54] 			= {id_pagesubset.MFCD_BACKGROUND , id_pagesubset.MFCD_DSMS_INVENTORY_GBU54 ,id_pagesubset.MFCD_OSB_11_15}
pages[id_Page.PAGE_MFCD_DSMS_INVENTORY_CBU87] 			= {id_pagesubset.MFCD_BACKGROUND , id_pagesubset.MFCD_DSMS_INVENTORY_CBU87 ,id_pagesubset.MFCD_OSB_11_15}
pages[id_Page.PAGE_MFCD_DSMS_INVENTORY_CBU89] 			= {id_pagesubset.MFCD_BACKGROUND , id_pagesubset.MFCD_DSMS_INVENTORY_CBU89 ,id_pagesubset.MFCD_OSB_11_15}
pages[id_Page.PAGE_MFCD_DSMS_INVENTORY_CBU97] 			= {id_pagesubset.MFCD_BACKGROUND , id_pagesubset.MFCD_DSMS_INVENTORY_CBU97 ,id_pagesubset.MFCD_OSB_11_15}
pages[id_Page.PAGE_MFCD_DSMS_INVENTORY_BDU56] 			= {id_pagesubset.MFCD_BACKGROUND , id_pagesubset.MFCD_DSMS_INVENTORY_BDU56 ,id_pagesubset.MFCD_OSB_11_15}
pages[id_Page.PAGE_MFCD_DSMS_INVENTORY_BDU50] 			= {id_pagesubset.MFCD_BACKGROUND , id_pagesubset.MFCD_DSMS_INVENTORY_BDU50 ,id_pagesubset.MFCD_OSB_11_15}
pages[id_Page.PAGE_MFCD_DSMS_INVENTORY_MK82A] 			= {id_pagesubset.MFCD_BACKGROUND , id_pagesubset.MFCD_DSMS_INVENTORY_MK82A ,id_pagesubset.MFCD_OSB_11_15}
pages[id_Page.PAGE_MFCD_DSMS_INVENTORY_FLARE] 			= {id_pagesubset.MFCD_BACKGROUND , id_pagesubset.MFCD_DSMS_INVENTORY_FLARE ,id_pagesubset.MFCD_OSB_11_15}
pages[id_Page.PAGE_MFCD_DSMS_INVENTORY_CBU103] 			= {id_pagesubset.MFCD_BACKGROUND , id_pagesubset.MFCD_DSMS_INVENTORY_CBU103 ,id_pagesubset.MFCD_OSB_11_15}
pages[id_Page.PAGE_MFCD_DSMS_INVENTORY_CBU104] 			= {id_pagesubset.MFCD_BACKGROUND , id_pagesubset.MFCD_DSMS_INVENTORY_CBU104 ,id_pagesubset.MFCD_OSB_11_15}
pages[id_Page.PAGE_MFCD_DSMS_INVENTORY_CBU105] 			= {id_pagesubset.MFCD_BACKGROUND , id_pagesubset.MFCD_DSMS_INVENTORY_CBU105 ,id_pagesubset.MFCD_OSB_11_15}
pages[id_Page.PAGE_MFCD_DSMS_MISSILE_CONTROL] 			= {id_pagesubset.MFCD_BACKGROUND , id_pagesubset.MFCD_DSMS_MISSILE_CONTROL ,id_pagesubset.MFCD_OSB_11_15}
pages[id_Page.PAGE_MFCD_DSMS_SELECTIVE_JETTISON] 		= {id_pagesubset.MFCD_BACKGROUND , id_pagesubset.MFCD_DSMS_STATIONS_SJ     ,id_pagesubset.MFCD_DSMS_SELECTIVE_JETTISON, id_pagesubset.MFCD_OSB_11_15}
pages[id_Page.PAGE_MFCD_TAD] 							= {id_pagesubset.MFCD_BACKGROUND , 
														   id_pagesubset.MFCD_TAD_BACK,
														   id_pagesubset.MFCD_TAD_CHART,
														   id_pagesubset.MFCD_TAD_MAP,
														   id_pagesubset.MFCD_TAD_MAIN,
														   id_pagesubset.MFCD_TAD_PROFILE_SELECT_OSB_02_05,
														   id_pagesubset.MFCD_OSB_11_15}
														   
pages[id_Page.PAGE_MFCD_TAD_CONTROL] 					= {id_pagesubset.MFCD_BACKGROUND , 
														   id_pagesubset.MFCD_TAD_BACK,
														   id_pagesubset.MFCD_TAD_CHART,
														   id_pagesubset.MFCD_TAD_MAP,
														   id_pagesubset.MFCD_TAD_CONTROL,
														   id_pagesubset.MFCD_OSB_11_15}
														   
pages[id_Page.PAGE_MFCD_TAD_CONTROL_SETTINGS]			= {id_pagesubset.MFCD_BACKGROUND , 
														   id_pagesubset.MFCD_TAD_BACK,
														   --id_pagesubset.MFCD_TAD_CHART,
														   --id_pagesubset.MFCD_TAD_MAP,
														   id_pagesubset.MFCD_TAD_CONTROL_SETTINGS,
														   id_pagesubset.MFCD_OSB_11_15}
														   
pages[id_Page.PAGE_MFCD_TAD_PROFILE_PROGRAM] 			= {id_pagesubset.MFCD_BACKGROUND ,
														   id_pagesubset.MFCD_TAD_BACK,
														   id_pagesubset.MFCD_TAD_CHART,
														   id_pagesubset.MFCD_TAD_PROFILE_PROGRAM_PAGE	,
														   id_pagesubset.MFCD_TAD_PROFILE_SELECT_OSB_02_05,
														   id_pagesubset.MFCD_OSB_11_15}
														   
pages[id_Page.PAGE_MFCD_TAD_MA_TABLE]					= {id_pagesubset.MFCD_BACKGROUND ,
														   id_pagesubset.MFCD_TAD_MA_TABLE,
														   id_pagesubset.MFCD_OSB_11_15}

pages[id_Page.PAGE_MFCD_TAD_TDL]    					= {id_pagesubset.MFCD_BACKGROUND ,
														   id_pagesubset.MFCD_TAD_TDL,
														   id_pagesubset.MFCD_OSB_11_15}
                                                          
pages[id_Page.PAGE_MFCD_TAD_SADL]    					= {id_pagesubset.MFCD_BACKGROUND,
														   id_pagesubset.MFCD_TAD_BACK,
														   id_pagesubset.MFCD_TAD_CHART,
                                                           id_pagesubset.MFCD_TAD_MAP,
														   id_pagesubset.MFCD_TAD_SADL,
														   id_pagesubset.MFCD_OSB_11_15}

pages[id_Page.PAGE_MFCD_TGP] 							= {id_pagesubset.MFCD_BACKGROUND, id_pagesubset.MFCD_TGP_MAIN, id_pagesubset.MFCD_TGP_OFF, id_pagesubset.MFCD_OSB_11_15}
pages[id_Page.PAGE_MFCD_TGP_STBYINIT] 					= {id_pagesubset.MFCD_BACKGROUND,id_pagesubset.MFCD_TGP_RENDER_STBYINIT,id_pagesubset.MFCD_TGP_MAIN,	id_pagesubset.MFCD_TGP_STBY_PAGE, id_pagesubset.MFCD_TGP_STBY_PAGE_INIT,	id_pagesubset.MFCD_OSB_11_15}
pages[id_Page.PAGE_MFCD_TGP_STBYBIT] 					= {id_pagesubset.MFCD_BACKGROUND,id_pagesubset.MFCD_TGP_RENDER_STBYBIT,id_pagesubset.MFCD_TGP_MAIN,	id_pagesubset.MFCD_TGP_STBY_PAGE,	id_pagesubset.MFCD_TGP_STBY_PAGE_INIT,	id_pagesubset.MFCD_OSB_11_15}
pages[id_Page.PAGE_MFCD_TGP_STBY]						= 	{id_pagesubset.MFCD_BACKGROUND,	id_pagesubset.MFCD_TGP_MAIN,	id_pagesubset.MFCD_TGP_STBY_PAGE,	id_pagesubset.MFCD_TGP_STBY_PAGE_OPER,	id_pagesubset.MFCD_OSB_11_15}
pages[id_Page.PAGE_MFCD_TGP_STBY_CONTROL]				= 	{id_pagesubset.MFCD_BACKGROUND,	id_pagesubset.MFCD_TGP_MAIN,	id_pagesubset.MFCD_TGP_STBY_CONTROL_PAGE,	id_pagesubset.MFCD_OSB_11_15}
			
pages[id_Page.PAGE_MFCD_TGP_AA] 						= {id_pagesubset.MFCD_BACKGROUND,
														   id_pagesubset.MFCD_TGP_RENDER_VIDEO,
														   id_pagesubset.MFCD_TGP_RENDER_SYMBOLOGY,
														   id_pagesubset.MFCD_TGP_MAIN,
														   id_pagesubset.MFCD_TGP_AA_PAGE,
														   id_pagesubset.MFCD_OSB_11_15}
pages[id_Page.PAGE_MFCD_TGP_AA_CONTROL]					= {id_pagesubset.MFCD_BACKGROUND,
														   id_pagesubset.MFCD_TGP_RENDER_VIDEO,
														   id_pagesubset.MFCD_TGP_RENDER_SYMBOLOGY,
														   id_pagesubset.MFCD_TGP_MAIN,
														   id_pagesubset.MFCD_TGP_AA_CONTROL_PAGE,
														   id_pagesubset.MFCD_OSB_11_15}
pages[id_Page.PAGE_MFCD_TGP_AG] 						= {id_pagesubset.MFCD_BACKGROUND,
														   id_pagesubset.MFCD_TGP_RENDER_VIDEO,
														   id_pagesubset.MFCD_TGP_RENDER_SYMBOLOGY,
														   id_pagesubset.MFCD_TGP_MAIN,
														   id_pagesubset.MFCD_TGP_AG_PAGE,
														   id_pagesubset.MFCD_OSB_11_15}
				
pages[id_Page.PAGE_MFCD_TGP_AG_CONTROL]					= {id_pagesubset.MFCD_BACKGROUND,
														   id_pagesubset.MFCD_TGP_RENDER_VIDEO,
														   id_pagesubset.MFCD_TGP_RENDER_SYMBOLOGY,
														   id_pagesubset.MFCD_TGP_MAIN,
														   id_pagesubset.MFCD_TGP_AG_CONTROL_PAGE,
														   id_pagesubset.MFCD_OSB_11_15}
														   
														   
pages[id_Page.PAGE_MFCD_COMM]				= {id_pagesubset.MFCD_BACKGROUND, id_pagesubset.MFCD_COMM_MAIN,   id_pagesubset.MFCD_OSB_11_15}
pages[id_Page.PAGE_MFCD_COMM_PAGE_1]		= {id_pagesubset.MFCD_BACKGROUND, id_pagesubset.MFCD_COMM_PAGE_1, id_pagesubset.MFCD_OSB_11_15}
pages[id_Page.PAGE_MFCD_COMM_PAGE_2]		= {id_pagesubset.MFCD_BACKGROUND, id_pagesubset.MFCD_COMM_PAGE_2, id_pagesubset.MFCD_OSB_11_15}
pages[id_Page.PAGE_MFCD_COMM_PAGE_3]		= {id_pagesubset.MFCD_BACKGROUND, id_pagesubset.MFCD_COMM_PAGE_3, id_pagesubset.MFCD_OSB_11_15}
pages[id_Page.PAGE_MFCD_COMM_PAGE_4]		= {id_pagesubset.MFCD_BACKGROUND, id_pagesubset.MFCD_COMM_PAGE_4, id_pagesubset.MFCD_OSB_11_15}


-- special page to draw TGP video on HMCS
pages[id_Page.PAGE_MFCD_TGP_VIDEO_OUT] 					= {id_pagesubset.MFCD_TGP_RENDER_VIDEO, id_pagesubset.MFCD_TGP_RENDER_SYMBOLOGY}

pages[id_Page.PAGE_MFCD_STAT_PAGE1]						= {id_pagesubset.MFCD_BACKGROUND, id_pagesubset.MFCD_STAT_COMMON, id_pagesubset.MFCD_STAT_PAGE1, id_pagesubset.MFCD_OSB_11_15}
pages[id_Page.PAGE_MFCD_STAT_PAGE2]						= {id_pagesubset.MFCD_BACKGROUND, id_pagesubset.MFCD_STAT_COMMON, id_pagesubset.MFCD_STAT_PAGE2, id_pagesubset.MFCD_OSB_11_15}
pages[id_Page.PAGE_MFCD_STAT_PAGE3]						= {id_pagesubset.MFCD_BACKGROUND, id_pagesubset.MFCD_STAT_COMMON, id_pagesubset.MFCD_STAT_PAGE3, id_pagesubset.MFCD_OSB_11_15}
pages[id_Page.PAGE_MFCD_STAT_HMCS_PAGE1]				= {id_pagesubset.MFCD_BACKGROUND, id_pagesubset.MFCD_STAT_HMCS_PAGE1, id_pagesubset.MFCD_OSB_11_15}
pages[id_Page.PAGE_MFCD_STAT_HMCS_PAGE2]				= {id_pagesubset.MFCD_BACKGROUND, id_pagesubset.MFCD_STAT_HMCS_PAGE2, id_pagesubset.MFCD_OSB_11_15}

pages[id_Page.PAGE_MFCD_TEST_CICU]		= {id_pagesubset.MFCD_BACKGROUND, id_pagesubset.MFCD_TEST_CICU}
pages[id_Page.PAGE_MFCD_TEST_DISP]		= {id_pagesubset.MFCD_BACKGROUND, id_pagesubset.MFCD_TEST_DISP}
pages[id_Page.PAGE_MFCD_TEST_KEYS]		= {id_pagesubset.MFCD_BACKGROUND, id_pagesubset.MFCD_TEST_KEYS}
pages[id_Page.PAGE_MFCD_TEST_HOTAS]		= {id_pagesubset.MFCD_BACKGROUND, id_pagesubset.MFCD_TEST_HOTAS}

pages[id_Page.PAGE_MFCD_MSG_TEXT]		= {id_pagesubset.MFCD_BACKGROUND, id_pagesubset.MFCD_MSG_TEXT, id_pagesubset.MFCD_MSG, id_pagesubset.MFCD_OSB_11_15}
pages[id_Page.PAGE_MFCD_MSG_CAS]		= {id_pagesubset.MFCD_BACKGROUND, id_pagesubset.MFCD_MSG_CAS, id_pagesubset.MFCD_MSG, id_pagesubset.MFCD_OSB_11_15}
pages[id_Page.PAGE_MFCD_MSG_MA]			= {id_pagesubset.MFCD_BACKGROUND, id_pagesubset.MFCD_MSG_MA, id_pagesubset.MFCD_MSG, id_pagesubset.MFCD_OSB_11_15}

init_pageID     = id_Page.PAGE_MFCD_NONE

function get_page_by_mode(master, L2, L3, L4)
	return get_page_by_mode_global(pages_by_mode, init_pageID, master, L2, L3, L4)
end

pages_by_mode = {}
clear_mode_table(pages_by_mode, 17, 10, 29)

pages_by_mode[MFCD_NONE]			[0][0][0]   = id_Page.PAGE_MFCD_NONE
pages_by_mode[MFCD_DTS_UPLOAD]		[0][0][0]   = id_Page.PAGE_MFCD_DTS_UPLOAD
pages_by_mode[MFCD_DISPLAY_PROGRAM] [0][0][0]   = id_Page.PAGE_MFCD_DISPLAY_PROGRAM
pages_by_mode[MFCD_MAV]				[0][0][0]   = id_Page.PAGE_MFCD_MAV
pages_by_mode[MFCD_DSMS]			[0][0][0]   = id_Page.PAGE_MFCD_DSMS
pages_by_mode[MFCD_DSMS]			[1][0][0]   = id_Page.PAGE_MFCD_DSMS_PROFILE_LIST
pages_by_mode[MFCD_DSMS]			[2][0][0]   = id_Page.PAGE_MFCD_DSMS_VIEW_PROFILE
pages_by_mode[MFCD_DSMS]			[3][0][0]   = id_Page.PAGE_MFCD_DSMS_PROFILE_SETTINGS
pages_by_mode[MFCD_DSMS]			[4][0][0]   = id_Page.PAGE_MFCD_DSMS_INVENTORY
pages_by_mode[MFCD_DSMS]			[4][1][0]   = id_Page.PAGE_MFCD_DSMS_INVENTORY_SELECT
pages_by_mode[MFCD_DSMS]			[4][2][0]   = id_Page.PAGE_MFCD_DSMS_INVENTORY_BOMB
pages_by_mode[MFCD_DSMS]			[4][3][0]   = id_Page.PAGE_MFCD_DSMS_INVENTORY_CBU
pages_by_mode[MFCD_DSMS]			[4][4][0]   = id_Page.PAGE_MFCD_DSMS_INVENTORY_GBU
pages_by_mode[MFCD_DSMS]			[4][5][0]   = id_Page.PAGE_MFCD_DSMS_INVENTORY_RACK
pages_by_mode[MFCD_DSMS]			[4][6][0]   = id_Page.PAGE_MFCD_DSMS_INVENTORY_AIR
pages_by_mode[MFCD_DSMS]			[4][7][0]   = id_Page.PAGE_MFCD_DSMS_INVENTORY_POD
pages_by_mode[MFCD_DSMS]			[4][8][0]   = id_Page.PAGE_MFCD_DSMS_INVENTORY_MAVERICK
pages_by_mode[MFCD_DSMS]			[4][9][0]   = id_Page.PAGE_MFCD_DSMS_INVENTORY_MISC
pages_by_mode[MFCD_DSMS]			[4][10][0]  = id_Page.PAGE_MFCD_DSMS_INVENTORY_BDU33
pages_by_mode[MFCD_DSMS]			[4][11][0]  = id_Page.PAGE_MFCD_DSMS_INVENTORY_ROCKET
pages_by_mode[MFCD_DSMS]			[4][12][0]  = id_Page.PAGE_MFCD_DSMS_INVENTORY_MK84
pages_by_mode[MFCD_DSMS]			[4][13][0]  = id_Page.PAGE_MFCD_DSMS_INVENTORY_MK82
pages_by_mode[MFCD_DSMS]			[4][14][0]  = id_Page.PAGE_MFCD_DSMS_INVENTORY_GBU10
pages_by_mode[MFCD_DSMS]			[4][15][0]  = id_Page.PAGE_MFCD_DSMS_INVENTORY_GBU12
pages_by_mode[MFCD_DSMS]			[4][16][0]  = id_Page.PAGE_MFCD_DSMS_INVENTORY_GBU31
pages_by_mode[MFCD_DSMS]			[4][17][0]  = id_Page.PAGE_MFCD_DSMS_INVENTORY_GBU38
pages_by_mode[MFCD_DSMS]			[4][18][0]  = id_Page.PAGE_MFCD_DSMS_INVENTORY_CBU87
pages_by_mode[MFCD_DSMS]			[4][19][0]  = id_Page.PAGE_MFCD_DSMS_INVENTORY_CBU89
pages_by_mode[MFCD_DSMS]			[4][20][0]  = id_Page.PAGE_MFCD_DSMS_INVENTORY_CBU97
pages_by_mode[MFCD_DSMS]			[4][21][0]  = id_Page.PAGE_MFCD_DSMS_INVENTORY_BDU56
pages_by_mode[MFCD_DSMS]			[4][22][0]  = id_Page.PAGE_MFCD_DSMS_INVENTORY_BDU50
pages_by_mode[MFCD_DSMS]			[4][23][0]  = id_Page.PAGE_MFCD_DSMS_INVENTORY_MK82A
pages_by_mode[MFCD_DSMS]			[4][24][0]  = id_Page.PAGE_MFCD_DSMS_INVENTORY_FLARE
pages_by_mode[MFCD_DSMS]			[4][25][0]  = id_Page.PAGE_MFCD_DSMS_INVENTORY_CBU103
pages_by_mode[MFCD_DSMS]			[4][26][0]  = id_Page.PAGE_MFCD_DSMS_INVENTORY_CBU104
pages_by_mode[MFCD_DSMS]			[4][27][0]  = id_Page.PAGE_MFCD_DSMS_INVENTORY_CBU105
pages_by_mode[MFCD_DSMS]			[4][28][0]  = id_Page.PAGE_MFCD_DSMS_INVENTORY_GBU54
pages_by_mode[MFCD_DSMS]			[5][0][0]   = id_Page.PAGE_MFCD_DSMS_MISSILE_CONTROL
pages_by_mode[MFCD_DSMS]			[6][0][0]   = id_Page.PAGE_MFCD_DSMS_SELECTIVE_JETTISON
pages_by_mode[MFCD_TAD]				[0][0][0]   = id_Page.PAGE_MFCD_TAD
pages_by_mode[MFCD_TAD]				[1][0][0]   = id_Page.PAGE_MFCD_TAD_PROFILE_PROGRAM
pages_by_mode[MFCD_TAD]				[2][0][0]   = id_Page.PAGE_MFCD_TAD_CONTROL
pages_by_mode[MFCD_TAD]				[2][1][0]   = id_Page.PAGE_MFCD_TAD_CONTROL_SETTINGS
pages_by_mode[MFCD_TAD]				[3][0][0]   = id_Page.PAGE_MFCD_TAD_MA_TABLE
pages_by_mode[MFCD_TAD]				[4][0][0]   = id_Page.PAGE_MFCD_TAD_TDL
pages_by_mode[MFCD_TAD]				[5][0][0]   = id_Page.PAGE_MFCD_TAD_SADL



pages_by_mode[MFCD_TGP][0][0][0]								= id_Page.PAGE_MFCD_TGP
pages_by_mode[MFCD_TGP][MFCD_TGP_STBY][0][0]					= id_Page.PAGE_MFCD_TGP_STBY
pages_by_mode[MFCD_TGP][MFCD_TGP_STBY][MFCD_TGP_STBY_INIT][0]	= id_Page.PAGE_MFCD_TGP_STBYINIT
pages_by_mode[MFCD_TGP][MFCD_TGP_STBY][MFCD_TGP_STBY_BIT][0]	= id_Page.PAGE_MFCD_TGP_STBYBIT
pages_by_mode[MFCD_TGP][MFCD_TGP_STBY][MFCD_TGP_STBY_CONTROL][0]= id_Page.PAGE_MFCD_TGP_STBY_CONTROL
pages_by_mode[MFCD_TGP][MFCD_TGP_AA]  [0][0]					= id_Page.PAGE_MFCD_TGP_AA
pages_by_mode[MFCD_TGP][MFCD_TGP_AA][MFCD_TGP_AA_CONTROL][0]	= id_Page.PAGE_MFCD_TGP_AA_CONTROL
pages_by_mode[MFCD_TGP][MFCD_TGP_AG]  [0][0]					= id_Page.PAGE_MFCD_TGP_AG
pages_by_mode[MFCD_TGP][MFCD_TGP_AG][MFCD_TGP_AG_CONTROL][0]	= id_Page.PAGE_MFCD_TGP_AG_CONTROL

pages_by_mode[MFCD_STAT][MFCD_STAT_PAGE1][0][0]   				= id_Page.PAGE_MFCD_STAT_PAGE1
pages_by_mode[MFCD_STAT][MFCD_STAT_PAGE2][0][0]   				= id_Page.PAGE_MFCD_STAT_PAGE2
pages_by_mode[MFCD_STAT][MFCD_STAT_PAGE3][0][0]   				= id_Page.PAGE_MFCD_STAT_PAGE3
-- STAT HMCS
pages_by_mode[MFCD_STAT][MFCD_STAT_HMCS_PAGE1][0][0]   			= id_Page.PAGE_MFCD_STAT_HMCS_PAGE1
pages_by_mode[MFCD_STAT][MFCD_STAT_HMCS_PAGE2][0][0]   			= id_Page.PAGE_MFCD_STAT_HMCS_PAGE2

pages_by_mode[MFCD_TEST_CICU][0][0][0]   		  = id_Page.PAGE_MFCD_TEST_CICU
pages_by_mode[MFCD_TEST_DISP][0][0][0]   		  = id_Page.PAGE_MFCD_TEST_DISP
pages_by_mode[MFCD_TEST_KEYS][0][0][0]   		  = id_Page.PAGE_MFCD_TEST_KEYS
pages_by_mode[MFCD_TEST_HOTAS][0][0][0]   		  = id_Page.PAGE_MFCD_TEST_HOTAS
pages_by_mode[MFCD_CICU_INIT][0][0][0]   		  = id_Page.PAGE_MFCD_TEST_CICU

pages_by_mode[MFCD_MSG][MFCD_MSG_TEXT_PAGE][0][0] = id_Page.PAGE_MFCD_MSG_TEXT
pages_by_mode[MFCD_MSG][MFCD_MSG_CAS_PAGE][0][0]  = id_Page.PAGE_MFCD_MSG_CAS
pages_by_mode[MFCD_MSG][MFCD_MSG_MA_PAGE][0][0]   = id_Page.PAGE_MFCD_MSG_MA

pages_by_mode[MFCD_VIDEO_OUT][0][0][0]   		  = id_Page.PAGE_MFCD_TGP_VIDEO_OUT

pages_by_mode[MFCD_COMM][0][0][0]								= id_Page.PAGE_MFCD_COMM
pages_by_mode[MFCD_COMM][MFCD_COMM_PAGE1][0][0]                 = id_Page.PAGE_MFCD_COMM_PAGE_1
pages_by_mode[MFCD_COMM][MFCD_COMM_PAGE2][0][0]                 = id_Page.PAGE_MFCD_COMM_PAGE_2
pages_by_mode[MFCD_COMM][MFCD_COMM_PAGE3][0][0]                 = id_Page.PAGE_MFCD_COMM_PAGE_3
pages_by_mode[MFCD_COMM][MFCD_COMM_PAGE4][0][0]                 = id_Page.PAGE_MFCD_COMM_PAGE_4



dofile (LockOn_Options.script_path.."MFCD/indicator/MFCD_CDU_repeater_init.lua")

local MFCD = GetSelf()

MFCD:Add_Tad_Page(id_pagesubset.MFCD_TAD_CHART,LockOn_Options.script_path.."MFCD/indicator/TAD/MFCD_page_TAD_CHART_loader.lua")
MFCD:set_buffer_cache_number(MFCD:get_render_target())

specific_element_id =
{
	TAD_ELM_STEERPOINT   = 0,              
	TAD_ELM_OWNSHIP      = 1,
	TAD_ELM_BULLSEYE     = 2,
	TAD_ELM_TGP          = 3,
	TAD_ELM_SPI  	     = 4,
	TAD_ELM_MARK_Z 	     = 5,
  
   --SADL item
    TAD_ELM_SADL_PPLI_AIR                = 6,
    TAD_ELM_SADL_TRACK_AIR_FRIENDLY      = 7,
    TAD_ELM_SADL_TRACK_AIR_NEUTRAL       = 8,
    TAD_ELM_SADL_TRACK_AIR_HOSTILE       = 9,
    TAD_ELM_SADL_TRACK_GND_NEUTRAL_1     = 10, --solid
    TAD_ELM_SADL_TRACK_GND_NEUTRAL_2     = 11,
    TAD_ELM_SADL_TRACK_GND_HOSTILE_1     = 12, --solid
    TAD_ELM_SADL_TRACK_GND_HOSTILE_2     = 13,
    TAD_ELM_SADL_PPLI_GND                = 14,
    TAD_ELM_SADL_MINISPI                 = 15,
    TAD_ELM_SADL_TRACK_GND_FRIENDLY      = 16,
    TAD_ELM_SADL_EMERGENCY_POINT         = 17,
    TAD_ELM_SADL_MA_OBJECTIVE_ATTACK     = 18,
    TAD_ELM_SADL_MA_OBJECTIVE_OTHER      = 19,
    TAD_ELM_SADL_MA_INITIAL_POINT        = 20,
    TAD_ELM_SADL_LOCAL_TARGET_REPORT     = 21,
	TAD_ELM_SADL_TARGET_LINE             = 22,
	TAD_ELM_SCS                          = 23,
	TAD_ELM_SCS_LINE                     = 24,
	TAD_ELM_SPECIFIC_MAX                 = 25
}

specific_element_names = {}
specific_element_names[specific_element_id.TAD_ELM_STEERPOINT]                   = "el_steerpoint"
specific_element_names[specific_element_id.TAD_ELM_OWNSHIP]                      = "el_ownship"
specific_element_names[specific_element_id.TAD_ELM_BULLSEYE]                     = "el_bullseye"
specific_element_names[specific_element_id.TAD_ELM_TGP] 	                     = "el_tgp" 
specific_element_names[specific_element_id.TAD_ELM_SPI] 	                     = "el_spi"
specific_element_names[specific_element_id.TAD_ELM_MARK_Z] 	                     = "el_mark_z"
specific_element_names[specific_element_id.TAD_ELM_SADL_PPLI_AIR]                = "el_dl_PPLI_air"
specific_element_names[specific_element_id.TAD_ELM_SADL_TRACK_AIR_FRIENDLY]      = "el_dl_track_air_friendly"
specific_element_names[specific_element_id.TAD_ELM_SADL_TRACK_AIR_NEUTRAL]       = "el_dl_track_air_neutral_unk"
specific_element_names[specific_element_id.TAD_ELM_SADL_TRACK_AIR_HOSTILE]       = "el_dl_track_air_hostile"
specific_element_names[specific_element_id.TAD_ELM_SADL_TRACK_GND_NEUTRAL_1]     = "el_dl_track_ground_neutral_unk"
specific_element_names[specific_element_id.TAD_ELM_SADL_TRACK_GND_NEUTRAL_2]     = "el_dl_track_ground_neutral_unk_notfilled"
specific_element_names[specific_element_id.TAD_ELM_SADL_TRACK_GND_HOSTILE_1]     = "el_dl_track_ground_hostile"
specific_element_names[specific_element_id.TAD_ELM_SADL_TRACK_GND_HOSTILE_2]     = "el_dl_track_ground_hostile_notfilled"
specific_element_names[specific_element_id.TAD_ELM_SADL_PPLI_GND]                = "el_dl_PPLI_ground"
specific_element_names[specific_element_id.TAD_ELM_SADL_MINISPI]                 = "el_dl_minispi" 
specific_element_names[specific_element_id.TAD_ELM_SADL_TRACK_GND_FRIENDLY]      = "el_dl_track_ground_friendly"
specific_element_names[specific_element_id.TAD_ELM_SADL_EMERGENCY_POINT]         = "el_dl_emergency_point"               
specific_element_names[specific_element_id.TAD_ELM_SADL_MA_OBJECTIVE_ATTACK]     = "el_dl_MA_objective_attack"
specific_element_names[specific_element_id.TAD_ELM_SADL_MA_OBJECTIVE_OTHER]      = "el_dl_MA_objective_other"
specific_element_names[specific_element_id.TAD_ELM_SADL_MA_INITIAL_POINT]        = "el_dl_MA_initial_point"
specific_element_names[specific_element_id.TAD_ELM_SADL_LOCAL_TARGET_REPORT]     = "el_dl_local_target_report"
specific_element_names[specific_element_id.TAD_ELM_SADL_TARGET_LINE]             = "el_dl_target_line"
specific_element_names[specific_element_id.TAD_ELM_SCS]                          = "el_scs"
specific_element_names[specific_element_id.TAD_ELM_SCS_LINE]                     = "el_scs_line"


templates = {}
templates["TAD_OBJECTS"]  = id_pagesubset.MFCD_TAD_OBJECTS

function get_template(name)
	if  templates[name] ~= nil then
		return templates[name]	
	end
	return -1
end

function get_specific_element_name_by_id(id)
	local name = ""
	if specific_element_names[id] == nil then
		return name
	else
		return specific_element_names[id]
	end
end


brightness_sensitive_materials = 
{ 
font_MFCD,
font_MFCD_BLACK,
font_MFCD_RED,
font_MFCD_BLUE,
font_MFCD_WHITE,
font_MFCD_YELLOW,

MFCD_SOLID_BLACK,
MFCD_SOLID_GREY,
MFCD_SOLID_DARK_GREY,
MFCD_SOLID_WHITE,
MFCD_SOLID_YELLOW,
MFCD_SOLID_RED,
MFCD_SOLID_GREEN,
MFCD_SOLID_BLUE,
MFCD_SOLID_VIOLET,

MFCD_YELLOW,
MFCD_BLUE,
MFCD_GREEN,
MFCD_RED,
MFCD_WHITE,
MFCD_GREY,
MFCD_VIOLET,
--TGP related
--font_MFCD_GREY,
--font_TGP,
}

color_sensitive_materials = 
{ 
--[[
	font_MFCD,
	MFCD_SOLID_GREEN,
	MFCD_GREEN,
--]]
}
