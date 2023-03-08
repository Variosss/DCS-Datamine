-- Common initialization for all MFD indicators
dynamically_update_geometry = false

local count = -1
local function counter()
	count = count + 1
	return count
end
	
local PagesPath			= LockOn_Options.script_path.."Displays/MFD/indicator/Pages/"

--------------------------------------------------------------------------------------------------
-- SUBSETS ---------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------

local count = -1
-- Display borders, collimator projecting areas, etc
local SUBSET_BASE				= counter()
local SUBSET_SOI				= counter()
local SUBSET_MENU				= counter()
local SUBSET_BLANK				= counter()
local SUBSET_INIT				= counter()
local SUBSET_BASE_MENU			= counter()

local SUBSET_FCR_OFF			= counter()
local SUBSET_FCR_BASE			= counter()
local SUBSET_FCR_COMMON			= counter()
local SUBSET_FCR_STBY			= counter()
local SUBSET_FCR_AA				= counter()
local SUBSET_FCR_AG				= counter()
local SUBSET_FCR_AG_IMAGE		= counter()
local SUBSET_FCR_IFF			= counter()

local SUBSET_WPN				= counter()
local SUBSET_WPN_MAV			= counter()
local SUBSET_WPN_MAV_VIDEO		= counter()
local SUBSET_WPN_HARM_HAS		= counter()
local SUBSET_WPN_HARM_POS		= counter()
local SUBSET_WPN_HARM_COMMON	= counter()

local SUBSET_SMS_OFF			= counter()
local SUBSET_SMS_INV			= counter()
local SUBSET_SMS_AAM			= counter()
local SUBSET_SMS_MSL			= counter()
local SUBSET_SMS_DGFT			= counter()
local SUBSET_SMS_GUN			= counter()
local SUBSET_SMS_AG				= counter()
local SUBSET_IFF				= counter()
local SUBSET_DTE				= counter()
local SUBSET_TEST				= counter()
local SUBSET_FLCS				= counter()
local SUBSET_HSD				= counter()
local SUBSET_DATA_ENTRY			= counter()
local SUBSET_TCN				= counter()

local SUBSET_TGP_OFF			= counter()
local SUBSET_TGP_CMN			= counter()
local SUBSET_TGP_AA				= counter()
local SUBSET_TGP_AG				= counter()
local SUBSET_TGP_CNTL			= counter()

local SUBSET_FCR_CONTACTS			= counter()
local SUBSET_FCR_TRACKS				= counter()
local SUBSET_FCR_AG_CONTACTS		= counter()
local SUBSET_IFF_CONTACTS			= counter()
local SUBSET_HSD_DEFENSE_ZONES		= counter()
local SUBSET_HSD_SYSTEM_TRACKS		= counter()
local SUBSET_FCR_SYSTEM_TRACKS		= counter()

local SUBSET_HAD_OFF			= counter()
local SUBSET_HAD				= counter()
local SUBSET_HAD_THRT			= counter()
local SUBSET_HAD_CONTACTS		= counter()
local SUBSET_HAD_SYSTEM_TRACKS	= counter()


page_subsets = {}

local function makeSubsets_FCR()
	page_subsets[SUBSET_FCR_OFF]				= PagesPath.."FCR/MFD_FCR_OFF.lua"
	page_subsets[SUBSET_FCR_BASE]				= PagesPath.."FCR/MFD_FCR_BASE.lua"
	page_subsets[SUBSET_FCR_COMMON]				= PagesPath.."FCR/MFD_FCR_COMMON.lua"
	page_subsets[SUBSET_FCR_STBY]				= PagesPath.."FCR/MFD_FCR_STBY.lua"
	page_subsets[SUBSET_FCR_AA]					= PagesPath.."FCR/MFD_FCR_AA.lua"
	page_subsets[SUBSET_FCR_AG]					= PagesPath.."FCR/MFD_FCR_AG.lua"
	page_subsets[SUBSET_FCR_AG_IMAGE]			= PagesPath.."FCR/MFD_FCR_AG_IMAGE.lua"
	page_subsets[SUBSET_FCR_IFF]				= PagesPath.."FCR/MFD_FCR_IFF.lua"
	page_subsets[SUBSET_FCR_CONTACTS]			= PagesPath.."FCR/Templates/FCR_contacts.lua"
	page_subsets[SUBSET_FCR_TRACKS]				= PagesPath.."FCR/Templates/FCR_tracks.lua"
	page_subsets[SUBSET_FCR_AG_CONTACTS]		= PagesPath.."FCR/Templates/FCR_AG_contacts.lua"
	page_subsets[SUBSET_IFF_CONTACTS]			= PagesPath.."FCR/Templates/IFF_contacts.lua"
	page_subsets[SUBSET_FCR_SYSTEM_TRACKS]		= PagesPath.."FCR/Templates/system_tracks.lua"
end

local function makeSubsets_WPN()
	page_subsets[SUBSET_WPN]					= PagesPath.."MFD_WPN.lua"
	page_subsets[SUBSET_WPN_MAV]				= PagesPath.."WPN/MFD_WPN_MAV.lua"
	page_subsets[SUBSET_WPN_MAV_VIDEO]			= PagesPath.."WPN/MAV/MAV_RENDERED.lua"
	page_subsets[SUBSET_WPN_HARM_HAS]			= PagesPath.."WPN/HARM/MFD_WPN_HARM_HAS.lua"
	page_subsets[SUBSET_WPN_HARM_POS]			= PagesPath.."WPN/HARM/MFD_WPN_HARM_POS.lua"
	page_subsets[SUBSET_WPN_HARM_COMMON]		= PagesPath.."WPN/HARM/MFD_WPN_HARM_COMMON.lua"
end

local function makeSubsets_SMS()
	page_subsets[SUBSET_SMS_OFF]					= PagesPath.."SMS/MFD_SMS_OFF.lua"
	page_subsets[SUBSET_SMS_INV]					= PagesPath.."SMS/MFD_SMS_INV.lua"
	page_subsets[SUBSET_SMS_AAM]					= PagesPath.."SMS/MFD_SMS_AAM.lua"
	page_subsets[SUBSET_SMS_MSL]					= PagesPath.."SMS/MFD_SMS_MSL.lua"
	page_subsets[SUBSET_SMS_DGFT]					= PagesPath.."SMS/MFD_SMS_DGFT.lua"
	page_subsets[SUBSET_SMS_GUN]					= PagesPath.."SMS/MFD_SMS_GUN.lua"
	page_subsets[SUBSET_SMS_AG]						= PagesPath.."SMS/MFD_SMS_AG.lua"
end

local function makeSubsets_IFF()
	page_subsets[SUBSET_IFF]					= PagesPath.."MFD_IFF.lua"
end

local function makeSubsets_DTE()
	page_subsets[SUBSET_DTE]					= PagesPath.."MFD_DTE.lua"
end

local function makeSubsets_TEST()
	page_subsets[SUBSET_TEST]					= PagesPath.."MFD_TEST.lua"
end

local function makeSubsets_FLCS()
	page_subsets[SUBSET_FLCS]					= PagesPath.."MFD_FLCS.lua"
end

local function makeSubsets_HSD()
	page_subsets[SUBSET_HSD]					= PagesPath.."HSD/MFD_HSD.lua"
	page_subsets[SUBSET_HSD_DEFENSE_ZONES]		= PagesPath.."HSD/Templates/DL_defense_zones.lua"
	page_subsets[SUBSET_HSD_SYSTEM_TRACKS]		= PagesPath.."HSD/Templates/system_tracks.lua"
	end

local function makeSubsets_TGP()
	page_subsets[SUBSET_TGP_OFF]				= PagesPath.."TGP/MFD_TGP_OFF.lua"
	page_subsets[SUBSET_TGP_CMN]				= PagesPath.."TGP/MFD_TGP_CMN.lua"
	page_subsets[SUBSET_TGP_AA]					= PagesPath.."TGP/MFD_TGP_AA.lua"
	page_subsets[SUBSET_TGP_AG]					= PagesPath.."TGP/MFD_TGP_AG.lua"
	page_subsets[SUBSET_TGP_CNTL]				= PagesPath.."TGP/MFD_TGP_CNTL.lua"
end

local function makeSubsets_HAD()
	page_subsets[SUBSET_HAD_OFF]				= PagesPath.."HAD/MFD_HAD_OFF.lua"
	page_subsets[SUBSET_HAD]					= PagesPath.."HAD/MFD_HAD.lua"
	page_subsets[SUBSET_HAD_THRT]				= PagesPath.."HAD/MFD_HAD_THRT.lua"
	page_subsets[SUBSET_HAD_CONTACTS]			= PagesPath.."HAD/Templates/HAD_contacts.lua"
	page_subsets[SUBSET_HAD_SYSTEM_TRACKS]		= PagesPath.."HAD/Templates/tracks.lua"
end

local function makeSubsets()
	makeSubsets_FCR()
	makeSubsets_WPN()
	makeSubsets_SMS()
	makeSubsets_IFF()
	makeSubsets_DTE()
	makeSubsets_TEST()
	makeSubsets_FLCS()
	makeSubsets_HSD()
	makeSubsets_TGP()
	makeSubsets_HAD()
end

local function makeSubsetsCommon()
	page_subsets[SUBSET_BASE]					= BasePage
	page_subsets[SUBSET_SOI]					= PagesPath.."MFD_SOI.lua"
	page_subsets[SUBSET_MENU]					= PagesPath.."MFD_MENU.lua"
	page_subsets[SUBSET_BLANK]					= PagesPath.."MFD_BLANK.lua"
	page_subsets[SUBSET_INIT]					= PagesPath.."MFD_INIT.lua"
	page_subsets[SUBSET_DATA_ENTRY]				= PagesPath.."MFD_DATA_ENTRY.lua"
	page_subsets[SUBSET_TCN]					= PagesPath.."MFD_TCN.lua"
	page_subsets[SUBSET_BASE_MENU]				= PagesPath.."MFD_BASE_MENU.lua"

	makeSubsets()
end


makeSubsetsCommon()

--------------------------------------------------------------------------------------------------
-- PAGES -----------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------

-- globals!
local pageNumber = 1
local function getPageNumber()
	pageNumber = pageNumber + 1
	return pageNumber
end

PAGE_NONE				= getPageNumber()
PAGE_STANDBY			= getPageNumber()

PAGE_FCR_OFF			= getPageNumber()
PAGE_FCR_STBY			= getPageNumber()
PAGE_FCR_AA				= getPageNumber()
PAGE_FCR_AG				= getPageNumber()

PAGE_WPN				= getPageNumber()
PAGE_WPN_MAV			= getPageNumber()
PAGE_WPN_HARM_HAS		= getPageNumber()
PAGE_WPN_HARM_POS		= getPageNumber()
PAGE_WPN_HARM_COMMON	= getPageNumber()

PAGE_SMS_OFF			= getPageNumber()
PAGE_SMS_INV			= getPageNumber()
PAGE_SMS_AAM			= getPageNumber()
PAGE_SMS_MSL			= getPageNumber()
PAGE_SMS_DGFT			= getPageNumber()
PAGE_SMS_GUN			= getPageNumber()
PAGE_SMS_AG				= getPageNumber()

PAGE_IFF				= getPageNumber()
PAGE_DTE				= getPageNumber()
PAGE_TEST				= getPageNumber()
PAGE_FLCS				= getPageNumber()
PAGE_HSD				= getPageNumber()

PAGE_MENU				= getPageNumber()
PAGE_BLANK				= getPageNumber()
PAGE_INIT				= getPageNumber()
PAGE_DATA_ENTRY			= getPageNumber()
PAGE_TCN				= getPageNumber()

PAGE_TGP_OFF			= getPageNumber()
PAGE_TGP_AG				= getPageNumber()
PAGE_TGP_AA				= getPageNumber()
PAGE_TGP_CNTL			= getPageNumber()

PAGE_HAD_OFF			= getPageNumber()
PAGE_HAD 				= getPageNumber()
PAGE_HAD_THRT 			= getPageNumber()

pages = {}

local function makePagesMFD_FCR()
	pages[PAGE_FCR_OFF]		= {SUBSET_BASE, SUBSET_FCR_BASE, SUBSET_FCR_OFF, SUBSET_FCR_IFF, SUBSET_BASE_MENU}
	pages[PAGE_FCR_STBY]	= {SUBSET_BASE, SUBSET_FCR_BASE, SUBSET_FCR_COMMON, SUBSET_FCR_STBY, SUBSET_FCR_IFF, SUBSET_BASE_MENU, SUBSET_SOI}
	pages[PAGE_FCR_AA]		= {SUBSET_BASE, SUBSET_FCR_BASE, SUBSET_FCR_COMMON, SUBSET_FCR_AA, SUBSET_FCR_IFF, SUBSET_BASE_MENU, SUBSET_SOI}
	pages[PAGE_FCR_AG]		= {SUBSET_BASE, SUBSET_FCR_AG_IMAGE, SUBSET_FCR_BASE, SUBSET_FCR_COMMON, SUBSET_FCR_AG, SUBSET_FCR_IFF, SUBSET_BASE_MENU, SUBSET_SOI}
end

local function makePagesMFD_WPN()
	pages[PAGE_WPN]			= {SUBSET_BASE, SUBSET_WPN, SUBSET_BASE_MENU}
	pages[PAGE_WPN_MAV]		= {SUBSET_BASE, SUBSET_WPN_MAV_VIDEO, SUBSET_WPN_MAV, SUBSET_BASE_MENU, SUBSET_SOI}
	pages[PAGE_WPN_HARM_HAS]	= {SUBSET_BASE,SUBSET_WPN_HARM_COMMON, SUBSET_WPN_HARM_HAS, SUBSET_BASE_MENU, SUBSET_SOI}
	pages[PAGE_WPN_HARM_POS]	= {SUBSET_BASE,SUBSET_WPN_HARM_COMMON, SUBSET_WPN_HARM_POS, SUBSET_BASE_MENU}
end

local function makePagesMFD_SMS()
	pages[PAGE_SMS_OFF]		= {SUBSET_BASE, SUBSET_SMS_OFF, SUBSET_BASE_MENU}
	pages[PAGE_SMS_INV]		= {SUBSET_BASE, SUBSET_SMS_INV, SUBSET_BASE_MENU}
	pages[PAGE_SMS_AAM]		= {SUBSET_BASE, SUBSET_SMS_AAM, SUBSET_BASE_MENU}
	pages[PAGE_SMS_MSL]		= {SUBSET_BASE, SUBSET_SMS_MSL, SUBSET_BASE_MENU}
	pages[PAGE_SMS_DGFT]	= {SUBSET_BASE, SUBSET_SMS_DGFT, SUBSET_BASE_MENU}
	pages[PAGE_SMS_GUN]		= {SUBSET_BASE, SUBSET_SMS_GUN, SUBSET_BASE_MENU}
	pages[PAGE_SMS_AG]		= {SUBSET_BASE, SUBSET_SMS_AG, SUBSET_BASE_MENU}
end

local function makePagesMFD_IFF()
	pages[PAGE_IFF]	= {SUBSET_BASE, SUBSET_IFF, SUBSET_BASE_MENU}
end

local function makePagesMFD_DTE()
	pages[PAGE_DTE]	= {SUBSET_BASE, SUBSET_DTE, SUBSET_BASE_MENU}
end

local function makePagesMFD_TEST()
	pages[PAGE_TEST]	= {SUBSET_BASE, SUBSET_TEST, SUBSET_BASE_MENU}
end

local function makePagesMFD_FLCS()
	pages[PAGE_FLCS]	= {SUBSET_BASE, SUBSET_FLCS, SUBSET_BASE_MENU}
end

local function makePagesMFD_HSD()
	pages[PAGE_HSD]	= {SUBSET_BASE, SUBSET_HSD, SUBSET_BASE_MENU, SUBSET_SOI}
end

local function makePagesMFD_TGP()
	pages[PAGE_TGP_OFF]			= {SUBSET_BASE, SUBSET_TGP_OFF,		SUBSET_BASE_MENU}
	pages[PAGE_TGP_AG]			= {SUBSET_BASE, SUBSET_TGP_CMN,		SUBSET_TGP_AG,		SUBSET_BASE_MENU, SUBSET_SOI}
	pages[PAGE_TGP_AA]			= {SUBSET_BASE, SUBSET_TGP_CMN,		SUBSET_TGP_AA,		SUBSET_BASE_MENU, SUBSET_SOI}
	pages[PAGE_TGP_CNTL]		= {SUBSET_BASE, SUBSET_TGP_CNTL,	SUBSET_BASE_MENU,	SUBSET_SOI}
end

local function makePagesMFD_HAD()
	pages[PAGE_HAD_OFF]			= {SUBSET_BASE, SUBSET_HAD_OFF,		SUBSET_BASE_MENU}
	pages[PAGE_HAD]				= {SUBSET_BASE, SUBSET_HAD, 		SUBSET_BASE_MENU,	SUBSET_SOI}
	pages[PAGE_HAD_THRT]		= {SUBSET_BASE, SUBSET_HAD_THRT,	SUBSET_BASE_MENU}
end

local function makePagesMFD()
	makePagesMFD_FCR()
	makePagesMFD_WPN()
	makePagesMFD_SMS()
	makePagesMFD_IFF()
	makePagesMFD_DTE()
	makePagesMFD_TEST()
	makePagesMFD_FLCS()
	makePagesMFD_HSD()
	makePagesMFD_TGP()
	makePagesMFD_HAD()
end

local function makePagesCommon()
	-- Indicator if OFF
	pages[PAGE_NONE]				= {}
	-- Flashing "STANDBY"
	pages[PAGE_STANDBY]				= {SUBSET_BASE, SUBSET_BASE_MENU}

	pages[PAGE_MENU]				= {SUBSET_BASE, SUBSET_MENU, SUBSET_BASE_MENU}
	pages[PAGE_BLANK]				= {SUBSET_BASE, SUBSET_BLANK, SUBSET_BASE_MENU}
	pages[PAGE_INIT]				= {SUBSET_INIT}
	pages[PAGE_DATA_ENTRY]			= {SUBSET_BASE, SUBSET_DATA_ENTRY, SUBSET_BASE_MENU}
	pages[PAGE_TCN]					= {SUBSET_BASE, SUBSET_TCN, SUBSET_BASE_MENU}

	makePagesMFD()
end

makePagesCommon()

	
init_pageID	= PAGE_NONE

--------------------------------------------------------------------------------------------------
-- PAGES BY MODE ---------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------
dofile(LockOn_Options.script_path.."Displays/MFD/indicator/MFD_formats_IDs.lua")

local function tablelen(T)
	local count = 0
	for _ in pairs(T) do count = count + 1 end
	return count
end

pages_by_mode = {}
clear_mode_table(pages_by_mode, tablelen(MFD_DISPL_FMT_LEV1), tablelen(MFD_DISPL_FMT_LEV2), tablelen(MFD_DISPL_FMT_LEV3))

pages_by_mode[MFD_DISPL_FMT_LEV1.NONE]			[MFD_DISPL_FMT_LEV2.NONE]				[MFD_DISPL_FMT_LEV3.NONE]	[MFD_DISPL_FMT_LEV4.NONE]	= PAGE_NONE
pages_by_mode[MFD_DISPL_FMT_LEV1.STANDBY]		[MFD_DISPL_FMT_LEV2.NONE]				[MFD_DISPL_FMT_LEV3.NONE]	[MFD_DISPL_FMT_LEV4.NONE]	= PAGE_STANDBY
pages_by_mode[MFD_DISPL_FMT_LEV1.MENU]			[MFD_DISPL_FMT_LEV2.NONE]				[MFD_DISPL_FMT_LEV3.NONE]	[MFD_DISPL_FMT_LEV4.NONE]	= PAGE_MENU
pages_by_mode[MFD_DISPL_FMT_LEV1.BLANK]			[MFD_DISPL_FMT_LEV2.NONE]				[MFD_DISPL_FMT_LEV3.NONE]	[MFD_DISPL_FMT_LEV4.NONE]	= PAGE_BLANK
pages_by_mode[MFD_DISPL_FMT_LEV1.INIT]			[MFD_DISPL_FMT_LEV2.NONE]				[MFD_DISPL_FMT_LEV3.NONE]	[MFD_DISPL_FMT_LEV4.NONE]	= PAGE_INIT

pages_by_mode[MFD_DISPL_FMT_LEV1.FCR]			[MFD_DISPL_FMT_LEV2.NONE]				[MFD_DISPL_FMT_LEV3.OFF]	[MFD_DISPL_FMT_LEV4.NONE]	= PAGE_FCR_OFF
pages_by_mode[MFD_DISPL_FMT_LEV1.FCR]			[MFD_DISPL_FMT_LEV2.FCR_STBY]			[MFD_DISPL_FMT_LEV3.NONE]	[MFD_DISPL_FMT_LEV4.NONE]	= PAGE_FCR_STBY
pages_by_mode[MFD_DISPL_FMT_LEV1.FCR]			[MFD_DISPL_FMT_LEV2.FCR_AA]				[MFD_DISPL_FMT_LEV3.NONE]	[MFD_DISPL_FMT_LEV4.NONE]	= PAGE_FCR_AA
pages_by_mode[MFD_DISPL_FMT_LEV1.FCR]			[MFD_DISPL_FMT_LEV2.FCR_AG]				[MFD_DISPL_FMT_LEV3.NONE]	[MFD_DISPL_FMT_LEV4.NONE]	= PAGE_FCR_AG

pages_by_mode[MFD_DISPL_FMT_LEV1.WPN]			[MFD_DISPL_FMT_LEV2.NONE]				[MFD_DISPL_FMT_LEV3.NONE]	[MFD_DISPL_FMT_LEV4.NONE]	= PAGE_WPN
pages_by_mode[MFD_DISPL_FMT_LEV1.WPN]			[MFD_DISPL_FMT_LEV2.WPN_MAV]			[MFD_DISPL_FMT_LEV3.NONE]	[MFD_DISPL_FMT_LEV4.NONE]	= PAGE_WPN_MAV
pages_by_mode[MFD_DISPL_FMT_LEV1.WPN]			[MFD_DISPL_FMT_LEV2.WPN_HARM]			[MFD_DISPL_FMT_LEV3.WPN_HARM_HAS]	[MFD_DISPL_FMT_LEV4.NONE]	= PAGE_WPN_HARM_HAS
pages_by_mode[MFD_DISPL_FMT_LEV1.WPN]			[MFD_DISPL_FMT_LEV2.WPN_HARM]			[MFD_DISPL_FMT_LEV3.WPN_HARM_POS]	[MFD_DISPL_FMT_LEV4.NONE]	= PAGE_WPN_HARM_POS

pages_by_mode[MFD_DISPL_FMT_LEV1.IFF]			[MFD_DISPL_FMT_LEV2.NONE]				[MFD_DISPL_FMT_LEV3.NONE]	[MFD_DISPL_FMT_LEV4.NONE]	= PAGE_IFF

pages_by_mode[MFD_DISPL_FMT_LEV1.SMS]			[MFD_DISPL_FMT_LEV2.NONE]				[MFD_DISPL_FMT_LEV3.OFF]	[MFD_DISPL_FMT_LEV4.NONE]	= PAGE_SMS_OFF
pages_by_mode[MFD_DISPL_FMT_LEV1.SMS]			[MFD_DISPL_FMT_LEV2.SMS_INV]			[MFD_DISPL_FMT_LEV3.NONE]	[MFD_DISPL_FMT_LEV4.NONE]	= PAGE_SMS_INV
pages_by_mode[MFD_DISPL_FMT_LEV1.SMS]			[MFD_DISPL_FMT_LEV2.SMS_AAM]			[MFD_DISPL_FMT_LEV3.NONE]	[MFD_DISPL_FMT_LEV4.NONE]	= PAGE_SMS_AAM
pages_by_mode[MFD_DISPL_FMT_LEV1.SMS]			[MFD_DISPL_FMT_LEV2.SMS_MSL]			[MFD_DISPL_FMT_LEV3.NONE]	[MFD_DISPL_FMT_LEV4.NONE]	= PAGE_SMS_MSL
pages_by_mode[MFD_DISPL_FMT_LEV1.SMS]			[MFD_DISPL_FMT_LEV2.SMS_DGFT]			[MFD_DISPL_FMT_LEV3.NONE]	[MFD_DISPL_FMT_LEV4.NONE]	= PAGE_SMS_DGFT
pages_by_mode[MFD_DISPL_FMT_LEV1.SMS]			[MFD_DISPL_FMT_LEV2.SMS_GUN]			[MFD_DISPL_FMT_LEV3.NONE]	[MFD_DISPL_FMT_LEV4.NONE]	= PAGE_SMS_GUN
pages_by_mode[MFD_DISPL_FMT_LEV1.SMS]			[MFD_DISPL_FMT_LEV2.SMS_AG]				[MFD_DISPL_FMT_LEV3.NONE]	[MFD_DISPL_FMT_LEV4.NONE]	= PAGE_SMS_AG
pages_by_mode[MFD_DISPL_FMT_LEV1.SMS]			[MFD_DISPL_FMT_LEV2.DATA_ENTRY]			[MFD_DISPL_FMT_LEV3.NONE]	[MFD_DISPL_FMT_LEV4.NONE]	= PAGE_DATA_ENTRY

pages_by_mode[MFD_DISPL_FMT_LEV1.DTE]			[MFD_DISPL_FMT_LEV2.NONE]				[MFD_DISPL_FMT_LEV3.NONE]	[MFD_DISPL_FMT_LEV4.NONE]	= PAGE_DTE
pages_by_mode[MFD_DISPL_FMT_LEV1.TEST]			[MFD_DISPL_FMT_LEV2.NONE]				[MFD_DISPL_FMT_LEV3.NONE]	[MFD_DISPL_FMT_LEV4.NONE]	= PAGE_TEST
pages_by_mode[MFD_DISPL_FMT_LEV1.FLCS]			[MFD_DISPL_FMT_LEV2.NONE]				[MFD_DISPL_FMT_LEV3.NONE]	[MFD_DISPL_FMT_LEV4.NONE]	= PAGE_FLCS
pages_by_mode[MFD_DISPL_FMT_LEV1.HSD]			[MFD_DISPL_FMT_LEV2.NONE]				[MFD_DISPL_FMT_LEV3.NONE]	[MFD_DISPL_FMT_LEV4.NONE]	= PAGE_HSD

pages_by_mode[MFD_DISPL_FMT_LEV1.TCN]			[MFD_DISPL_FMT_LEV2.NONE]				[MFD_DISPL_FMT_LEV3.NONE]	[MFD_DISPL_FMT_LEV4.NONE]	= PAGE_TCN
pages_by_mode[MFD_DISPL_FMT_LEV1.TCN]			[MFD_DISPL_FMT_LEV2.DATA_ENTRY]			[MFD_DISPL_FMT_LEV3.NONE]	[MFD_DISPL_FMT_LEV4.NONE]	= PAGE_DATA_ENTRY

pages_by_mode[MFD_DISPL_FMT_LEV1.TGP]			[MFD_DISPL_FMT_LEV2.NONE]				[MFD_DISPL_FMT_LEV3.OFF]	[MFD_DISPL_FMT_LEV4.NONE]	= PAGE_TGP_OFF
pages_by_mode[MFD_DISPL_FMT_LEV1.TGP]			[MFD_DISPL_FMT_LEV2.TGP_AA]				[MFD_DISPL_FMT_LEV3.NONE]	[MFD_DISPL_FMT_LEV4.NONE]	= PAGE_TGP_AA
pages_by_mode[MFD_DISPL_FMT_LEV1.TGP]			[MFD_DISPL_FMT_LEV2.TGP_AG]				[MFD_DISPL_FMT_LEV3.NONE]	[MFD_DISPL_FMT_LEV4.NONE]	= PAGE_TGP_AG
pages_by_mode[MFD_DISPL_FMT_LEV1.TGP]			[MFD_DISPL_FMT_LEV2.NONE]				[MFD_DISPL_FMT_LEV3.CNTL]	[MFD_DISPL_FMT_LEV4.NONE]	= PAGE_TGP_CNTL

pages_by_mode[MFD_DISPL_FMT_LEV1.HAD]			[MFD_DISPL_FMT_LEV2.NONE]				[MFD_DISPL_FMT_LEV3.OFF]	[MFD_DISPL_FMT_LEV4.NONE]	= PAGE_HAD_OFF
pages_by_mode[MFD_DISPL_FMT_LEV1.HAD]			[MFD_DISPL_FMT_LEV2.NONE]				[MFD_DISPL_FMT_LEV3.NONE]	[MFD_DISPL_FMT_LEV4.NONE]	= PAGE_HAD
pages_by_mode[MFD_DISPL_FMT_LEV1.HAD]			[MFD_DISPL_FMT_LEV2.NONE]				[MFD_DISPL_FMT_LEV3.THRT]	[MFD_DISPL_FMT_LEV4.NONE]	= PAGE_HAD_THRT

function get_page_by_mode(master, L2, L3, L4)
	return get_page_by_mode_global(pages_by_mode, init_pageID, master, L2, L3, L4)
end

-- Multiple symbols
multipleSymbolsIDs =
{
	FCR_CONTACT				= 0,
	FCR_TRACKS				= 1,
	FCR_AG_CONTACT			= 2,
	IFF_CONTACT				= 3,
	HSD_DEFENSE_ZONES		= 4,
	HSD_SYSTEM_TRACKS		= 5,
	FCR_SYSTEM_TRACKS		= 6,
	HAD_CONTACT				= 7,
	HAD_SYSTEM_TRACKS		= 8,
}

multipleSymbols = {}
multipleSymbols[multipleSymbolsIDs.FCR_CONTACT]				= "FCR_contact"
multipleSymbols[multipleSymbolsIDs.FCR_TRACKS]				= "FCR_tracks"
multipleSymbols[multipleSymbolsIDs.FCR_AG_CONTACT]			= "FCR_AG_contact"
multipleSymbols[multipleSymbolsIDs.IFF_CONTACT]				= "IFF_contact"
multipleSymbols[multipleSymbolsIDs.HSD_DEFENSE_ZONES]		= "HSD_defense_zones"
multipleSymbols[multipleSymbolsIDs.HSD_SYSTEM_TRACKS]		= "HSD_SYS_air_tracks"
multipleSymbols[multipleSymbolsIDs.FCR_SYSTEM_TRACKS]		= "FCR_SYS_air_tracks"
multipleSymbols[multipleSymbolsIDs.HAD_CONTACT]				= "HAD_contact"
multipleSymbols[multipleSymbolsIDs.HAD_SYSTEM_TRACKS]		= "HAD_SYSTEM_TRACKS"

function getMultipleSymbolByID(id)
	local name = ""
	if multipleSymbols[id] == nil then
		return name
	else
		return multipleSymbols[id]
	end
end

templates = {}
templates["RADAR_CONTACTS"]			= SUBSET_FCR_CONTACTS
templates["RADAR_TRACKS"]			= SUBSET_FCR_TRACKS
templates["RADAR_AG_CONTACTS"]		= SUBSET_FCR_AG_CONTACTS
templates["IFF_CONTACTS"]			= SUBSET_IFF_CONTACTS
templates["HSD_DEFENSE_ZONES"]		= SUBSET_HSD_DEFENSE_ZONES
templates["HSD_SYSTEM_TRACKS"]		= SUBSET_HSD_SYSTEM_TRACKS
templates["FCR_SYSTEM_TRACKS"]		= SUBSET_FCR_SYSTEM_TRACKS
templates["HAD_CONTACTS"]			= SUBSET_HAD_CONTACTS
templates["HAD_SYSTEM_TRACKS"]		= SUBSET_HAD_SYSTEM_TRACKS

function get_template(name)
	if templates[name] ~= nil then
		return templates[name]	
	end
	return -1
end
