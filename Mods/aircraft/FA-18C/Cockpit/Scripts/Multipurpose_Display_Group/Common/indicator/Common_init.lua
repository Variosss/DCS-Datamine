-- Common initialization for all MDG indicators (Multipurpose Displays and Head-Up Display)

local count = 0
local function counter()
	count = count + 1
	return count
end
local function reset_counter()
	count = 0
end

dynamically_update_geometry = false
	
local PagesPathCommon	= LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/"
local PagesPathHUD		= LockOn_Options.script_path.."Multipurpose_Display_Group/HUD_AVQ32/indicator/Pages/"
local PagesPathMDG		= LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/"
local PagesPathHSI		= PagesPathMDG.."HSI/"


reset_counter()
-- Display borders, collimator projecting areas, etc
local SUBSET_BASE					= counter()
-- Flashing "STANDBY"
local SUBSET_STANDBY				= counter()
-- Currently - Cautions/Advisories and MENU for MPDs
local SUBSET_SPECIFIC				= counter()
-- Head-Up Display (also HUD repeater for MPDs)
local SUBSET_HUD_MODE_INDEP			= counter() -- mode independent symbology
local SUBSET_HUD_NAV				= counter()
local SUBSET_HUD_WEAP_CMN			= counter()
local SUBSET_HUD_AA					= counter()
local SUBSET_HUD_AG					= counter()
local SUBSET_HUD_HMD_ALIGN			= counter()

-- Multipurpose displays

-- MENU
local SUBSET_MENU_SUPT				= counter()
local SUBSET_MENU_TAC				= counter()

-- ADI/SPIN
local SUBSET_ADI_SPIN_COMMON		= counter()
local SUBSET_ADI					= counter()
local SUBSET_SPIN					= counter()
-- AZ/EL
local SUBSET_AZ_EL					= counter()
local SUBSET_AZ_EL_TRACKS 			= counter()
-- BIT
local SUBSET_BIT_COMMON				= counter()
local SUBSET_BIT_MAIN				= counter()
local SUBSET_BIT_SUBLEVEL_COMMON	= counter()
local SUBSET_BIT_COMM				= counter()
local SUBSET_BIT_DISPLAYS			= counter()
local SUBSET_BIT_EW					= counter()
local SUBSET_BIT_FCS_MC				= counter()
local SUBSET_BIT_NAV				= counter()
local SUBSET_BIT_SENSORS			= counter()
local SUBSET_BIT_STAT_MON			= counter()
local SUBSET_BIT_STORES				= counter()
local SUBSET_SW_CONFIG				= counter()
-- CHKLST
local SUBSET_CHECKLISTS				= counter()
-- ENGINES
local SUBSET_ENG					= counter()
-- EW
local SUBSET_EW_COMMON				= counter()
local SUBSET_EW_MAIN				= counter()--*
local SUBSET_EW_MAIN_RWR			= counter()
local SUBSET_EW_PROG				= counter()--*
-- FCS
local SUBSET_FCS					= counter()
-- FLIR
local SUBSET_FLIR_CMN				= counter()
local SUBSET_FLIR_AA				= counter()
local SUBSET_FLIR_AG				= counter()
local SUBSET_FLIR_LSS				= counter()
local SUBSET_AFLIR_WYPT_SYMB		= counter()
-- FPAS
local SUBSET_FPAS					= counter()
-- FUEL
local SUBSET_FUEL					= counter()
-- HSI
local SUBSET_HSI_DIGITAL_MAP		= counter()
-- DMC symbology outline
local SUBSET_HSI_CAUT_ADV_OUTLINED		= counter()
local SUBSET_HSI_BACKUP_COMMON_OUTLINED	= counter()
local SUBSET_HSI_MAIN_OUTLINED			= counter()
-- DMC symbology main
local SUBSET_HSI_CAUT_ADV_DMC		= counter()
local SUBSET_HSI_BACKUP_COMMON_DMC	= counter()
local SUBSET_HSI_MAIN_DMC			= counter()
-- 'normal' stroke symbology
local SUBSET_HSI_MAIN				= counter()
local SUBSET_HSI_MAIN_AMPCD			= counter()
local SUBSET_HSI_DATA_AC			= counter()
local SUBSET_HSI_DATA_WYPT			= counter()
local SUBSET_HSI_DATA_TCN			= counter()
local SUBSET_HSI_DATA_GRID			= counter()
local SUBSET_HSI_BACKUP_COMMON		= counter()
-- MUMI
local SUBSET_MUMI					= counter()
-- HMD
local SUBSET_HMD					= counter()
local SUBSET_HMD_REJECT				= counter()
local SUBSET_HMD_MIDS				= counter()
-- RDR
-- common for AA/AG, both non-backup and backup
local SUBSET_RDR_AA_AG_BASE			= counter()
-- common for AA, both non-backup and backup
local SUBSET_RDR_AA_BASE			= counter()
-- common for AG, both non-backup and backup
local SUBSET_RDR_AG_BASE			= counter()
-- common for AA/AG, non-backup
local SUBSET_RDR_AA_AG				= counter()
-- AA, main PBs
local SUBSET_RDR_AA_MAIN_PBs		= counter()
-- AA, DATA submenu PBs
local SUBSET_RDR_AA_DATA_PBs		= counter()
-- common for AA, non-backup
local SUBSET_RDR_AA					= counter()
-- AG, main PBs
local SUBSET_RDR_AG_MAIN_PBs		= counter()
-- AG, DATA submenu PBs
local SUBSET_RDR_AG_DATA_PBs		= counter()
-- common for AG, non-backup
local SUBSET_RDR_AG					= counter()
-- Currently - radar contacts only, planned - all multiple symbols (probably not limited to radar - SA and HSI pages)
local SUBSET_RDR_CONTACTS			= counter()
local SUBSET_RDR_PPLI				= counter()
local SUBSET_RDR_FF					= counter()
local SUBSET_RDR_SURVEILLANCE		= counter()
local SUBSET_RDR_TRACKS				= counter()
-- Special for AA
local SUBSET_RDR_AA_SPECIAL			= counter()
-- RDR AGR
local SUBSET_RDR_AGR				= counter()
-- RDR AGR DATA
local SUBSET_RDR_AGR_PBs			= counter()
-- RDR AG
local SUBSET_RDR_AG_TRACKS			= counter()

-- MIDS, SA
local SUBSET_MIDS					= counter()
local SUBSET_SA						= counter()
local SUBSET_SA_PPLI				= counter()
local SUBSET_SA_FF					= counter()
local SUBSET_SA_SURVEILLANCE		= counter()
local SUBSET_SA_AIR_DEFENSE			= counter()
local SUBSET_SA_DIGITAL_MAP			= counter()
local SUBSET_SA_OUTLINED			= counter()
local SUBSET_SA_DMC					= counter()
local SUBSET_SA_DYNAMIC_SYMBOLS		= counter()

-- STORES
local SUBSET_STORES					= counter()
local SUBSET_MAV_VIDEO				= counter()
local SUBSET_HARM_CMN				= counter()
local SUBSET_HARM_SP				= counter()
local SUBSET_HARM_TOO				= counter()
local SUBSET_HARM_PB				= counter()
local SUBSET_HARM_CLASS				= counter()
local SUBSET_HARM_SCAN				= counter()
local SUBSET_JDAM_JSOW				= counter()
local SUBSET_MISSION_DATA			= counter()
local SUBSET_SLAM_VIDEO				= counter()
local SUBSET_WALLEYE_VIDEO			= counter()
local SUBSET_DATALINK_VIDEO			= counter()
local SUBSET_JPF					= counter()
-- UFC BACKUP
local SUBSET_UFC_BU					= counter()

-- MIDS TGT DATA
local SUBSET_TGT_DATA_COMMON_PBs	= counter()
local SUBSET_TGT_DATA_OWNSHIP		= counter()
local SUBSET_TGT_DATA_GROUP			= counter()

local SUBSET_AMPCD_BRT_CONT			= counter()

local SUBSET_ACL					= counter()

page_subsets = {}

local function makeSubsetsCommon()
	page_subsets[SUBSET_BASE]					= BasePage
	-- Flashing "STANDBY"
	page_subsets[SUBSET_STANDBY]				= PagesPathCommon.."Standby.lua"
	page_subsets[SUBSET_SPECIFIC]				= IndicatorSpecificPage
	-- HUD
	page_subsets[SUBSET_HUD_MODE_INDEP]			= PagesPathHUD.."HUD_common.lua"
	page_subsets[SUBSET_HUD_NAV]				= PagesPathHUD.."HUD_NAV.lua"
	page_subsets[SUBSET_HUD_WEAP_CMN]			= PagesPathHUD.."HUD_Weapons_Common.lua"
	page_subsets[SUBSET_HUD_AA]					= PagesPathHUD.."HUD_AA.lua"
	page_subsets[SUBSET_HUD_AG]					= PagesPathHUD.."HUD_AG.lua"
	page_subsets[SUBSET_HUD_HMD_ALIGN]			= PagesPathHUD.."HUD_HMD_align.lua"
end

local function makeSubsetsMPD_BIT()
	page_subsets[SUBSET_BIT_COMMON]				= PagesPathMDG.."BIT/BIT_COMMON.lua"
	page_subsets[SUBSET_BIT_MAIN]				= PagesPathMDG.."BIT/BIT_MAIN.lua"
	page_subsets[SUBSET_BIT_SUBLEVEL_COMMON]	= PagesPathMDG.."BIT/BIT_SUBLEVEL_COMMON.lua"
	page_subsets[SUBSET_BIT_COMM]				= PagesPathMDG.."BIT/BIT_COMM.lua"
	page_subsets[SUBSET_BIT_DISPLAYS]			= PagesPathMDG.."BIT/BIT_DISPLAYS.lua"
	page_subsets[SUBSET_BIT_EW]					= PagesPathMDG.."BIT/BIT_EW.lua"
	page_subsets[SUBSET_BIT_FCS_MC]				= PagesPathMDG.."BIT/BIT_FCS_MC.lua"
	page_subsets[SUBSET_BIT_NAV]				= PagesPathMDG.."BIT/BIT_NAV.lua"
	page_subsets[SUBSET_BIT_SENSORS]			= PagesPathMDG.."BIT/BIT_SENSORS.lua"
	page_subsets[SUBSET_BIT_STAT_MON]			= PagesPathMDG.."BIT/BIT_STAT_MON.lua"
	page_subsets[SUBSET_BIT_STORES]				= PagesPathMDG.."BIT/BIT_STORES.lua"
	page_subsets[SUBSET_SW_CONFIG]				= PagesPathMDG.."BIT/SW_CONFIG.lua"
end

local function makeSubsetsMPD_HSI()
	-- Digital Map
	page_subsets[SUBSET_HSI_DIGITAL_MAP]   		= PagesPathHSI.."HSI_DIGITAL_MAP.lua"
	-- Outlined symbology to render with Digital Map in the background - generated by DMC
	-- Outline background DMC symbology
	page_subsets[SUBSET_HSI_CAUT_ADV_OUTLINED] 	= PagesPathMDG.."CautAdvAndMenuPage_outlined.lua"
	page_subsets[SUBSET_HSI_BACKUP_COMMON_OUTLINED]	= PagesPathHSI.."HSI_BACKUP_COMMON_outlined.lua"
	page_subsets[SUBSET_HSI_MAIN_OUTLINED] 		= PagesPathHSI.."HSI_MAIN_outlined.lua"
	-- Main DMC symbology
	page_subsets[SUBSET_HSI_CAUT_ADV_DMC] 		= PagesPathMDG.."CautAdvAndMenuPage_DMC.lua"
	page_subsets[SUBSET_HSI_BACKUP_COMMON_DMC]	= PagesPathHSI.."HSI_BACKUP_COMMON_DMC.lua"
	page_subsets[SUBSET_HSI_MAIN_DMC] 			= PagesPathHSI.."HSI_MAIN_DMC.lua"
	
	-- 'normal' symbology
	page_subsets[SUBSET_HSI_MAIN]     	  		= PagesPathHSI.."HSI_MAIN.lua"
	page_subsets[SUBSET_HSI_DATA_AC] 	  		= PagesPathHSI.."HSI_DATA_AC.lua"
	page_subsets[SUBSET_HSI_DATA_WYPT]	  		= PagesPathHSI.."HSI_DATA_WYPT.lua"
	page_subsets[SUBSET_HSI_DATA_TCN] 	  		= PagesPathHSI.."HSI_DATA_TCN.lua"
	page_subsets[SUBSET_HSI_DATA_GRID]			= PagesPathHSI.."HSI_DATA_GRID.lua"
	page_subsets[SUBSET_HSI_BACKUP_COMMON]		= PagesPathHSI.."HSI_BACKUP_COMMON.lua"
end

local function makeSubsetsMPD_EW()
	page_subsets[SUBSET_EW_COMMON]				= PagesPathMDG.."EW/EW_COMMON.lua"
	page_subsets[SUBSET_EW_MAIN]				= PagesPathMDG.."EW/EW_MAIN.lua"
	page_subsets[SUBSET_EW_MAIN_RWR]			= PagesPathMDG.."EW/EW_MAIN_RWR.lua"
	page_subsets[SUBSET_EW_PROG]				= PagesPathMDG.."EW/EW_PROG.lua"
end

local function makeSubsetsMPD_RDR()
	page_subsets[SUBSET_RDR_AA_AG_BASE]			= PagesPathMDG.."RDR/RDR_AA_AG_BASE.lua"
	page_subsets[SUBSET_RDR_AA_BASE]			= PagesPathMDG.."RDR/RDR_AA_BASE.lua"
	page_subsets[SUBSET_RDR_AG_BASE]			= PagesPathMDG.."RDR/RDR_AG_BASE.lua"
	page_subsets[SUBSET_RDR_AA_AG]				= PagesPathMDG.."RDR/RDR_AA_AG.lua"
	page_subsets[SUBSET_RDR_AA_MAIN_PBs]		= PagesPathMDG.."RDR/RDR_AA_MAIN_PBs.lua"
	page_subsets[SUBSET_RDR_AA_DATA_PBs]		= PagesPathMDG.."RDR/RDR_AA_DATA_PBs.lua"
	page_subsets[SUBSET_RDR_AA]					= PagesPathMDG.."RDR/RDR_AA.lua"
	page_subsets[SUBSET_RDR_AG_MAIN_PBs]		= PagesPathMDG.."RDR/RDR_AG_MAIN_PBs.lua"
	page_subsets[SUBSET_RDR_AG_DATA_PBs]		= PagesPathMDG.."RDR/RDR_AG_DATA_PBs.lua"
	page_subsets[SUBSET_RDR_AG]					= PagesPathMDG.."RDR/RDR_AG.lua"
	page_subsets[SUBSET_RDR_CONTACTS]			= PagesPathMDG.."RDR/Templates/RDR_contacts.lua"
	page_subsets[SUBSET_RDR_PPLI]				= PagesPathMDG.."RDR/Templates/RDR_PPLI.lua"
	page_subsets[SUBSET_RDR_FF]					= PagesPathMDG.."RDR/Templates/RDR_FF.lua"
	page_subsets[SUBSET_RDR_SURVEILLANCE]		= PagesPathMDG.."RDR/Templates/RDR_SURVEILLANCE.lua"
	page_subsets[SUBSET_RDR_TRACKS]				= PagesPathMDG.."RDR/Templates/RDR_TRACKS.lua"
	page_subsets[SUBSET_RDR_AA_SPECIAL]			= PagesPathMDG.."RDR/RDR_AA_SPECIAL.lua"
	page_subsets[SUBSET_RDR_AGR]				= PagesPathMDG.."RDR/RDR_AGR.lua"
	page_subsets[SUBSET_RDR_AGR_PBs]			= PagesPathMDG.."RDR/RDR_AGR_PBs.lua"
	page_subsets[SUBSET_RDR_AG_TRACKS]			= PagesPathMDG.."RDR/Templates/RDR_AG_TRACKS.lua"
end

local function makeSubsetsMPD_TGT_DATA()
	page_subsets[SUBSET_TGT_DATA_COMMON_PBs]	= PagesPathMDG.."TGT_DATA/TGT_DATA_COMMON_PBs.lua"
	page_subsets[SUBSET_TGT_DATA_OWNSHIP]		= PagesPathMDG.."TGT_DATA/TGT_DATA_OWNSHIP.lua"
	page_subsets[SUBSET_TGT_DATA_GROUP]			= PagesPathMDG.."TGT_DATA/TGT_DATA_GROUP.lua"
end

local function makeSubsetsMPD_SA()
	page_subsets[SUBSET_SA]						= PagesPathMDG.."SA/SA.lua"
	page_subsets[SUBSET_SA_PPLI]				= PagesPathMDG.."SA/Templates/SA_PPLI.lua"
	page_subsets[SUBSET_SA_FF]					= PagesPathMDG.."SA/Templates/SA_FF.lua"
	page_subsets[SUBSET_SA_SURVEILLANCE]		= PagesPathMDG.."SA/Templates/SA_SURVEILLANCE.lua"
	page_subsets[SUBSET_SA_AIR_DEFENSE]			= PagesPathMDG.."SA/Templates/SA_AIR_DEFENSE.lua"
	page_subsets[SUBSET_SA_DIGITAL_MAP]			= PagesPathMDG.."SA/SA_DIGITAL_MAP.lua"
	page_subsets[SUBSET_SA_OUTLINED]			= PagesPathMDG.."SA/SA_outlined.lua"
	page_subsets[SUBSET_SA_DMC]					= PagesPathMDG.."SA/SA_DMC.lua"
	page_subsets[SUBSET_SA_DYNAMIC_SYMBOLS]		= PagesPathMDG.."SA/SA_Dynamic_Symbols.lua"
end

local function makeSubsetsMPD_FLIR()
	page_subsets[SUBSET_FLIR_CMN]				= PagesPathMDG.."FLIR/FLIR_CMN.lua"
	page_subsets[SUBSET_FLIR_AA]				= PagesPathMDG.."FLIR/FLIR_AA.lua"
	page_subsets[SUBSET_FLIR_AG]				= PagesPathMDG.."FLIR/FLIR_AG.lua"
	page_subsets[SUBSET_FLIR_LSS]				= PagesPathMDG.."FLIR/FLIR_LSS.lua"
	page_subsets[SUBSET_AFLIR_WYPT_SYMB]		= PagesPathMDG.."FLIR/Templates/AFLIR_WYPT_SYMB.lua"
end

local function makeSubsetsMPD_AZ_EL()
	page_subsets[SUBSET_AZ_EL]					= PagesPathMDG.."AZ_EL/AZ_EL.lua"
	page_subsets[SUBSET_AZ_EL_TRACKS] 			= PagesPathMDG.."AZ_EL/Templates/AZ_EL_TRACKS.lua"
end

local function makeSubsetsMPD()
	makeSubsetsMPD_BIT()
	makeSubsetsMPD_HSI()
	makeSubsetsMPD_EW()
	makeSubsetsMPD_RDR()
	makeSubsetsMPD_TGT_DATA()
	makeSubsetsMPD_SA()
	makeSubsetsMPD_FLIR()
	makeSubsetsMPD_AZ_EL()

	page_subsets[SUBSET_MENU_SUPT]				= PagesPathMDG.."Menu_SUPT.lua"
	page_subsets[SUBSET_MENU_TAC]				= PagesPathMDG.."Menu_TAC.lua"
	
	page_subsets[SUBSET_ADI_SPIN_COMMON]		= PagesPathMDG.."ADI_SPIN/ADI_SPIN_common.lua"
	page_subsets[SUBSET_ADI]					= PagesPathMDG.."ADI_SPIN/ADI.lua"
	page_subsets[SUBSET_SPIN]					= PagesPathMDG.."ADI_SPIN/SPIN.lua"
	
	page_subsets[SUBSET_CHECKLISTS]				= PagesPathMDG.."Checklists.lua"
	page_subsets[SUBSET_ENG]					= PagesPathMDG.."ENG.lua"
	page_subsets[SUBSET_FCS]					= PagesPathMDG.."FCS.lua"
	page_subsets[SUBSET_FPAS]					= PagesPathMDG.."FPAS.lua"
	page_subsets[SUBSET_FUEL]					= PagesPathMDG.."FUEL.lua"

	page_subsets[SUBSET_MUMI]					= PagesPathMDG.."MUMI.lua"
	
	page_subsets[SUBSET_HMD]					= PagesPathMDG.."HMD/HMD.lua"
	page_subsets[SUBSET_HMD_REJECT]				= PagesPathMDG.."HMD/HMD_REJECT.lua"
	page_subsets[SUBSET_HMD_MIDS]				= PagesPathMDG.."HMD/HMD_MIDS.lua"
	
	page_subsets[SUBSET_MIDS]					= PagesPathMDG.."MIDS.lua"
	page_subsets[SUBSET_STORES]					= PagesPathMDG.."STORES.lua"
	page_subsets[SUBSET_UFC_BU]					= PagesPathMDG.."UFC_BU.lua"
	page_subsets[SUBSET_MAV_VIDEO]				= PagesPathMDG.."MAV/MAV_RENDERED.lua"
	page_subsets[SUBSET_WALLEYE_VIDEO]			= PagesPathMDG.."WALLEYE/WALLEYE_RENDERED.lua"
	page_subsets[SUBSET_DATALINK_VIDEO]			= PagesPathMDG.."DATALINK/DATALINK_RENDERED.lua"
	page_subsets[SUBSET_SLAM_VIDEO]				= PagesPathMDG.."SLAM/SLAM_RENDERED.lua"
	page_subsets[SUBSET_JDAM_JSOW]				= PagesPathMDG.."JDAM_JSOW/JDAM_JSOW.lua"
	page_subsets[SUBSET_MISSION_DATA]			= PagesPathMDG.."JDAM_JSOW/MISSION_DATA.lua"
	page_subsets[SUBSET_JPF]					= PagesPathMDG.."JDAM_JSOW/JPF.lua"
	page_subsets[SUBSET_HARM_CMN]				= PagesPathMDG.."HARM/HARM_CMN.lua"
	page_subsets[SUBSET_HARM_SP]				= PagesPathMDG.."HARM/HARM_SP.lua"
	page_subsets[SUBSET_HARM_TOO]				= PagesPathMDG.."HARM/HARM_TOO.lua"
	page_subsets[SUBSET_HARM_PB]				= PagesPathMDG.."HARM/HARM_PB.lua"
	page_subsets[SUBSET_HARM_CLASS]				= PagesPathMDG.."HARM/HARM_CLASS.lua"
	page_subsets[SUBSET_HARM_SCAN]				= PagesPathMDG.."HARM/HARM_SCAN.lua"
	
	page_subsets[SUBSET_ACL]					= PagesPathMDG.."ACL.lua"
end

makeSubsetsCommon()
if not isHUD == true then
	makeSubsetsMPD()
end

if isAMPCD == true then
	-- Specific for AMPCD - brightness/contrast levels display
	page_subsets[SUBSET_AMPCD_BRT_CONT]			= LockOn_Options.script_path.."Multipurpose_Display_Group/AMPCD/indicator/AMPCD_brightness_contrast.lua"
end


reset_counter()
-- globals!
PAGE_NONE				= counter()
PAGE_STANDBY			= counter()

PAGE_HUD_NAV			= counter()
PAGE_HUD_AA				= counter()
PAGE_HUD_AG				= counter()
PAGE_HUD_HMD_ALIGN		= counter()

PAGE_MENU_SUPT			= counter()
PAGE_MENU_TAC			= counter()

PAGE_ADI				= counter()
PAGE_SPIN				= counter()
PAGE_AZ_EL				= counter()

PAGE_BIT_MAIN			= counter()
PAGE_BIT_COMM			= counter()
PAGE_BIT_DISPLAYS		= counter()
PAGE_BIT_EW				= counter()
PAGE_BIT_FCS_MC			= counter()
PAGE_BIT_NAV			= counter()
PAGE_BIT_SENSORS		= counter()
PAGE_BIT_STAT_MON		= counter()
PAGE_BIT_STORES			= counter()
PAGE_SW_CONFIG			= counter()

PAGE_CHECKLISTS			= counter()
PAGE_ENG				= counter()
PAGE_EW_MAIN			= counter()
PAGE_EW_MAIN_RWR		= counter()
PAGE_EW_PROG			= counter()

PAGE_FCS				= counter()
PAGE_FLIR_AG			= counter()
PAGE_FPAS				= counter()
PAGE_FUEL				= counter()

PAGE_HSI_MAIN			= counter()
PAGE_HSI_MAIN_AMPCD		= counter()
PAGE_HSI_DATA_AC		= counter()
PAGE_HSI_DATA_WYPT		= counter()
PAGE_HSI_DATA_TCN		= counter()
PAGE_HSI_DATA_GRID		= counter()
PAGE_HSI_BACKUP			= counter()

PAGE_MUMI				= counter()

PAGE_RDR_AA				= counter()
PAGE_RDR_AA_DATA		= counter()
PAGE_RDR_AA_BACKUP		= counter()
PAGE_RDR_AG				= counter()
PAGE_RDR_AG_DATA		= counter()
PAGE_RDR_AG_BACKUP		= counter()

PAGE_SA					= counter()
PAGE_SA_AMPCD			= counter()
PAGE_STORES				= counter()
PAGE_UFC_BU				= counter()
PAGE_MAV_VIDEO			= counter()

PAGE_HARM_SP			= counter()
PAGE_HARM_TOO			= counter()
PAGE_HARM_PB			= counter()
PAGE_HARM_CLASS			= counter()
PAGE_HARM_SCAN			= counter()

PAGE_HMD				= counter()
PAGE_HMD_REJECT			= counter()
PAGE_HMD_MIDS			= counter()

PAGE_MIDS				= counter()

PAGE_TGT_DATA_OWNSHIP	= counter()
PAGE_TGT_DATA_GROUP		= counter()

PAGE_JDAM_JSOW			= counter()
PAGE_MISSION_DATA		= counter()
PAGE_SLAM_VIDEO			= counter()
PAGE_DATALINK_VIDEO		= counter()
PAGE_WALLEYE_VIDEO		= counter()

PAGE_FLIR_AA			= counter()
PAGE_FLIR_LSS			= counter()

PAGE_RDR_AGR			= counter()  --Alyona
PAGE_RDR_AGR_DATA		= counter()

PAGE_JPF				= counter()

PAGE_ACL				= counter()

pages = {}

local function makePagesCommon()
	-- Indicator if OFF
	pages[PAGE_NONE]				= {}
	-- Flashing "STANDBY"
	pages[PAGE_STANDBY]				= {SUBSET_BASE, SUBSET_STANDBY}
	-- HUD
	pages[PAGE_HUD_NAV]				= {SUBSET_BASE, SUBSET_SPECIFIC, SUBSET_HUD_MODE_INDEP, SUBSET_HUD_NAV}
	pages[PAGE_HUD_AA]				= {SUBSET_BASE, SUBSET_SPECIFIC, SUBSET_HUD_MODE_INDEP, SUBSET_HUD_WEAP_CMN, SUBSET_HUD_AA}
	pages[PAGE_HUD_AG]				= {SUBSET_BASE, SUBSET_SPECIFIC, SUBSET_HUD_MODE_INDEP, SUBSET_HUD_WEAP_CMN, SUBSET_HUD_AG}
	pages[PAGE_HUD_HMD_ALIGN]		= {SUBSET_BASE, SUBSET_SPECIFIC, SUBSET_HUD_HMD_ALIGN}
end

local function makePagesMPD_BIT()
	pages[PAGE_BIT_MAIN]			= {SUBSET_BASE, SUBSET_SPECIFIC, SUBSET_BIT_COMMON, SUBSET_BIT_MAIN}
	pages[PAGE_BIT_COMM]			= {SUBSET_BASE, SUBSET_SPECIFIC, SUBSET_BIT_COMMON, SUBSET_BIT_SUBLEVEL_COMMON, SUBSET_BIT_COMM}
	pages[PAGE_BIT_DISPLAYS]		= {SUBSET_BASE, SUBSET_SPECIFIC, SUBSET_BIT_COMMON, SUBSET_BIT_SUBLEVEL_COMMON, SUBSET_BIT_DISPLAYS}
	pages[PAGE_BIT_EW]				= {SUBSET_BASE, SUBSET_SPECIFIC, SUBSET_BIT_COMMON, SUBSET_BIT_SUBLEVEL_COMMON, SUBSET_BIT_EW}
	pages[PAGE_BIT_FCS_MC]			= {SUBSET_BASE, SUBSET_SPECIFIC, SUBSET_BIT_COMMON, SUBSET_BIT_FCS_MC}
	pages[PAGE_BIT_NAV]				= {SUBSET_BASE, SUBSET_SPECIFIC, SUBSET_BIT_COMMON, SUBSET_BIT_SUBLEVEL_COMMON, SUBSET_BIT_NAV}
	pages[PAGE_BIT_SENSORS]			= {SUBSET_BASE, SUBSET_SPECIFIC, SUBSET_BIT_COMMON, SUBSET_BIT_SUBLEVEL_COMMON, SUBSET_BIT_SENSORS}
	pages[PAGE_BIT_STAT_MON]		= {SUBSET_BASE, SUBSET_SPECIFIC, SUBSET_BIT_COMMON, SUBSET_BIT_SUBLEVEL_COMMON, SUBSET_BIT_STAT_MON}
	pages[PAGE_BIT_STORES]			= {SUBSET_BASE, SUBSET_SPECIFIC, SUBSET_BIT_COMMON, SUBSET_BIT_SUBLEVEL_COMMON, SUBSET_BIT_STORES}
end

local function makePagesMPD_HSI()
	pages[PAGE_HSI_MAIN]			= {SUBSET_BASE, SUBSET_SPECIFIC, SUBSET_HSI_BACKUP_COMMON, SUBSET_HSI_MAIN}
	pages[PAGE_HSI_MAIN_AMPCD]		= {SUBSET_BASE, SUBSET_HSI_DIGITAL_MAP, SUBSET_HSI_CAUT_ADV_OUTLINED, SUBSET_HSI_BACKUP_COMMON_OUTLINED, SUBSET_HSI_MAIN_OUTLINED,
										SUBSET_HSI_CAUT_ADV_DMC, SUBSET_HSI_BACKUP_COMMON_DMC, SUBSET_HSI_MAIN_DMC}
	pages[PAGE_HSI_DATA_AC]			= {SUBSET_BASE, SUBSET_SPECIFIC, SUBSET_HSI_DATA_AC}
	pages[PAGE_HSI_DATA_WYPT]		= {SUBSET_BASE, SUBSET_SPECIFIC, SUBSET_HSI_DATA_WYPT}
	pages[PAGE_HSI_DATA_TCN]		= {SUBSET_BASE, SUBSET_SPECIFIC, SUBSET_HSI_DATA_TCN}
	pages[PAGE_HSI_DATA_GRID]		= {SUBSET_BASE, SUBSET_HSI_DATA_GRID}
	pages[PAGE_HSI_BACKUP]			= {SUBSET_BASE, SUBSET_SPECIFIC, SUBSET_HSI_BACKUP_COMMON}
end

local function makePagesMPD_EW()
	pages[PAGE_EW_MAIN]				= {SUBSET_BASE, SUBSET_SPECIFIC, SUBSET_EW_COMMON, SUBSET_EW_MAIN}
	pages[PAGE_EW_MAIN_RWR]			= {SUBSET_BASE, SUBSET_SPECIFIC, SUBSET_EW_COMMON, SUBSET_EW_MAIN, SUBSET_EW_MAIN_RWR}
	pages[PAGE_EW_PROG]				= {SUBSET_BASE, SUBSET_SPECIFIC, SUBSET_EW_COMMON, SUBSET_EW_PROG}
end

local function makePagesMPD_RDR()
	pages[PAGE_RDR_AA]				= {SUBSET_BASE, SUBSET_SPECIFIC, SUBSET_RDR_AA_AG_BASE, SUBSET_RDR_AA_SPECIAL, SUBSET_RDR_AA_BASE, SUBSET_RDR_AA_AG, SUBSET_RDR_AA_MAIN_PBs, SUBSET_RDR_AA}
	pages[PAGE_RDR_AA_DATA]			= {SUBSET_BASE, SUBSET_SPECIFIC, SUBSET_RDR_AA_AG_BASE, SUBSET_RDR_AA_BASE, SUBSET_RDR_AA_AG, SUBSET_RDR_AA_DATA_PBs, SUBSET_RDR_AA}
	pages[PAGE_RDR_AA_BACKUP]		= {SUBSET_BASE, SUBSET_SPECIFIC, SUBSET_RDR_AA_AG_BASE, SUBSET_RDR_AA_SPECIAL, SUBSET_RDR_AA_BASE}
	pages[PAGE_RDR_AG]				= {SUBSET_BASE, SUBSET_SPECIFIC, SUBSET_RDR_AA_AG_BASE, SUBSET_RDR_AG_BASE, SUBSET_RDR_AA_AG, SUBSET_RDR_AG_MAIN_PBs, SUBSET_RDR_AG}
	pages[PAGE_RDR_AG_DATA]			= {SUBSET_BASE, SUBSET_SPECIFIC, SUBSET_RDR_AA_AG_BASE, SUBSET_RDR_AG_BASE, SUBSET_RDR_AA_AG, SUBSET_RDR_AG_DATA_PBs, SUBSET_RDR_AG}
	pages[PAGE_RDR_AG_BACKUP]		= {SUBSET_BASE, SUBSET_SPECIFIC, SUBSET_RDR_AA_AG_BASE, SUBSET_RDR_AG_BASE}
	pages[PAGE_RDR_AGR]				= {SUBSET_BASE, SUBSET_SPECIFIC, SUBSET_RDR_AGR, SUBSET_RDR_AGR_PBs}
	pages[PAGE_RDR_AGR_DATA]		= {SUBSET_BASE, SUBSET_SPECIFIC, SUBSET_RDR_AG_DATA_PBs, SUBSET_RDR_AGR}
end

local function makePagesMPD_FLIR()
	pages[PAGE_FLIR_AG]				= {SUBSET_BASE, SUBSET_SPECIFIC, SUBSET_FLIR_AG, SUBSET_FLIR_CMN}
	pages[PAGE_FLIR_AA]				= {SUBSET_BASE, SUBSET_SPECIFIC, SUBSET_FLIR_AA, SUBSET_FLIR_CMN}
	pages[PAGE_FLIR_LSS]			= {SUBSET_BASE, SUBSET_SPECIFIC, SUBSET_FLIR_LSS}
end

local function makePagesMPD()
	makePagesMPD_BIT()
	makePagesMPD_HSI()
	makePagesMPD_EW()
	makePagesMPD_RDR()
	makePagesMPD_FLIR()

	pages[PAGE_MENU_SUPT]			= {SUBSET_BASE, SUBSET_SPECIFIC, SUBSET_MENU_SUPT}
	pages[PAGE_MENU_TAC]			= {SUBSET_BASE, SUBSET_SPECIFIC, SUBSET_MENU_TAC}
	
	pages[PAGE_ADI]					= {SUBSET_BASE, SUBSET_SPECIFIC, SUBSET_ADI_SPIN_COMMON, SUBSET_ADI}
	pages[PAGE_AZ_EL]				= {SUBSET_BASE, SUBSET_SPECIFIC, SUBSET_AZ_EL}
	
	pages[PAGE_SW_CONFIG]			= {SUBSET_BASE, SUBSET_SPECIFIC, SUBSET_BIT_COMMON, SUBSET_SW_CONFIG}

	pages[PAGE_CHECKLISTS]			= {SUBSET_BASE, SUBSET_SPECIFIC, SUBSET_CHECKLISTS}
	pages[PAGE_ENG]					= {SUBSET_BASE, SUBSET_SPECIFIC, SUBSET_ENG}
	
	pages[PAGE_FCS]					= {SUBSET_BASE, SUBSET_SPECIFIC, SUBSET_FCS}
	pages[PAGE_FPAS]				= {SUBSET_BASE, SUBSET_SPECIFIC, SUBSET_FPAS}
	pages[PAGE_FUEL]				= {SUBSET_BASE, SUBSET_SPECIFIC, SUBSET_FUEL}

	pages[PAGE_MUMI]				= {SUBSET_BASE, SUBSET_SPECIFIC, SUBSET_MUMI}

	pages[PAGE_MIDS]				= {SUBSET_BASE, SUBSET_SPECIFIC, SUBSET_MIDS}
	pages[PAGE_SA]					= {SUBSET_BASE, SUBSET_SPECIFIC, SUBSET_SA_DYNAMIC_SYMBOLS, SUBSET_SA}
	pages[PAGE_SA_AMPCD]			= {SUBSET_BASE, SUBSET_SA_DIGITAL_MAP, SUBSET_SA_DYNAMIC_SYMBOLS, SUBSET_SA_OUTLINED, SUBSET_SA_DMC}

	pages[PAGE_STORES]				= {SUBSET_BASE, SUBSET_SPECIFIC, SUBSET_STORES}
	pages[PAGE_MAV_VIDEO]			= {SUBSET_BASE, SUBSET_MAV_VIDEO}
	pages[PAGE_JDAM_JSOW]			= {SUBSET_BASE, SUBSET_JDAM_JSOW}
	pages[PAGE_MISSION_DATA]		= {SUBSET_BASE, SUBSET_MISSION_DATA}
	pages[PAGE_JPF]					= {SUBSET_BASE, SUBSET_JPF}
	pages[PAGE_SLAM_VIDEO]			= {SUBSET_BASE, SUBSET_SLAM_VIDEO}
	pages[PAGE_WALLEYE_VIDEO]		= {SUBSET_BASE, SUBSET_WALLEYE_VIDEO}
	pages[PAGE_DATALINK_VIDEO]		= {SUBSET_BASE, SUBSET_DATALINK_VIDEO}
	pages[PAGE_SPIN]				= {SUBSET_BASE, SUBSET_SPECIFIC, SUBSET_ADI_SPIN_COMMON, SUBSET_SPIN}
	pages[PAGE_UFC_BU]				= {SUBSET_BASE, SUBSET_SPECIFIC, SUBSET_UFC_BU}
	pages[PAGE_HARM_SP]				= {SUBSET_BASE, SUBSET_SPECIFIC, SUBSET_HARM_CMN, SUBSET_HARM_SP}
	pages[PAGE_HARM_TOO]			= {SUBSET_BASE, SUBSET_SPECIFIC, SUBSET_HARM_CMN, SUBSET_HARM_TOO}
	pages[PAGE_HARM_PB]				= {SUBSET_BASE, SUBSET_SPECIFIC, SUBSET_HARM_CMN, SUBSET_HARM_PB}
	pages[PAGE_HARM_CLASS]			= {SUBSET_BASE, SUBSET_SPECIFIC, SUBSET_HARM_CLASS}
	pages[PAGE_HARM_SCAN]			= {SUBSET_BASE, SUBSET_SPECIFIC, SUBSET_HARM_CLASS, SUBSET_HARM_SCAN}
	
	pages[PAGE_HMD]					= {SUBSET_BASE, SUBSET_SPECIFIC, SUBSET_HMD}
	pages[PAGE_HMD_REJECT]			= {SUBSET_BASE, SUBSET_SPECIFIC, SUBSET_HMD_REJECT}
	pages[PAGE_HMD_MIDS]			= {SUBSET_BASE, SUBSET_SPECIFIC, SUBSET_HMD_MIDS}

	pages[PAGE_TGT_DATA_OWNSHIP]	= {SUBSET_BASE, SUBSET_SPECIFIC, SUBSET_TGT_DATA_COMMON_PBs, SUBSET_TGT_DATA_OWNSHIP}
	pages[PAGE_TGT_DATA_GROUP]		= {SUBSET_BASE, SUBSET_SPECIFIC, SUBSET_TGT_DATA_COMMON_PBs, SUBSET_TGT_DATA_GROUP}
	
	pages[PAGE_ACL]					= {SUBSET_BASE, SUBSET_SPECIFIC, SUBSET_ACL}

end

makePagesCommon()
if not isHUD == true then
	makePagesMPD()
end

if isAMPCD == true then
	-- Adding AMPCD current brightness/contrast levels display to each page
	for k, v in pairs(pages) do
		v[#v + 1] = SUBSET_AMPCD_BRT_CONT
	end
end

init_pageID	= PAGE_NONE

dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/display_formats_IDs.lua")

local function tablelen(T)
	local count = 0
	for _ in pairs(T) do count = count + 1 end
	return count
end

pages_by_mode = {}
clear_mode_table(pages_by_mode, tablelen(MDG_DISPL_FMT_LEV1), tablelen(MDG_DISPL_FMT_LEV2), tablelen(MDG_DISPL_FMT_LEV3))

pages_by_mode[MDG_DISPL_FMT_LEV1.NONE]			[MDG_DISPL_FMT_LEV2.NONE]				[MDG_DISPL_FMT_LEV3.NONE]	[MDG_DISPL_FMT_LEV4.NONE]	= PAGE_NONE
pages_by_mode[MDG_DISPL_FMT_LEV1.STANDBY]		[MDG_DISPL_FMT_LEV2.NONE]				[MDG_DISPL_FMT_LEV3.NONE]	[MDG_DISPL_FMT_LEV4.NONE]	= PAGE_STANDBY

pages_by_mode[MDG_DISPL_FMT_LEV1.HUD]			[MDG_DISPL_FMT_LEV2.HUD_NAV]			[MDG_DISPL_FMT_LEV3.NONE]	[MDG_DISPL_FMT_LEV4.NONE]	= PAGE_HUD_NAV
pages_by_mode[MDG_DISPL_FMT_LEV1.HUD]			[MDG_DISPL_FMT_LEV2.HUD_AA]				[MDG_DISPL_FMT_LEV3.NONE]	[MDG_DISPL_FMT_LEV4.NONE]	= PAGE_HUD_AA
pages_by_mode[MDG_DISPL_FMT_LEV1.HUD]			[MDG_DISPL_FMT_LEV2.HUD_AG]				[MDG_DISPL_FMT_LEV3.NONE]	[MDG_DISPL_FMT_LEV4.NONE]	= PAGE_HUD_AG
pages_by_mode[MDG_DISPL_FMT_LEV1.HUD]			[MDG_DISPL_FMT_LEV2.HUD_HMD_ALIGN]		[MDG_DISPL_FMT_LEV3.NONE]	[MDG_DISPL_FMT_LEV4.NONE]	= PAGE_HUD_HMD_ALIGN

pages_by_mode[MDG_DISPL_FMT_LEV1.MENU]			[MDG_DISPL_FMT_LEV2.MENU_SUPT]			[MDG_DISPL_FMT_LEV3.NONE]	[MDG_DISPL_FMT_LEV4.NONE]	= PAGE_MENU_SUPT
pages_by_mode[MDG_DISPL_FMT_LEV1.MENU]			[MDG_DISPL_FMT_LEV2.MENU_TAC]			[MDG_DISPL_FMT_LEV3.NONE]	[MDG_DISPL_FMT_LEV4.NONE]	= PAGE_MENU_TAC

pages_by_mode[MDG_DISPL_FMT_LEV1.ADI]			[MDG_DISPL_FMT_LEV2.NONE]				[MDG_DISPL_FMT_LEV3.NONE]	[MDG_DISPL_FMT_LEV4.NONE]	= PAGE_ADI
pages_by_mode[MDG_DISPL_FMT_LEV1.AZ_EL]			[MDG_DISPL_FMT_LEV2.NONE]				[MDG_DISPL_FMT_LEV3.NONE]	[MDG_DISPL_FMT_LEV4.NONE]	= PAGE_AZ_EL

pages_by_mode[MDG_DISPL_FMT_LEV1.BIT]			[MDG_DISPL_FMT_LEV2.BIT_MAIN]			[MDG_DISPL_FMT_LEV3.NONE]	[MDG_DISPL_FMT_LEV4.NONE]	= PAGE_BIT_MAIN
pages_by_mode[MDG_DISPL_FMT_LEV1.BIT]			[MDG_DISPL_FMT_LEV2.BIT_COMM]			[MDG_DISPL_FMT_LEV3.NONE]	[MDG_DISPL_FMT_LEV4.NONE]	= PAGE_BIT_COMM
pages_by_mode[MDG_DISPL_FMT_LEV1.BIT]			[MDG_DISPL_FMT_LEV2.BIT_DISPLAYS]		[MDG_DISPL_FMT_LEV3.NONE]	[MDG_DISPL_FMT_LEV4.NONE]	= PAGE_BIT_DISPLAYS
pages_by_mode[MDG_DISPL_FMT_LEV1.BIT]			[MDG_DISPL_FMT_LEV2.BIT_EW]				[MDG_DISPL_FMT_LEV3.NONE]	[MDG_DISPL_FMT_LEV4.NONE]	= PAGE_BIT_EW
pages_by_mode[MDG_DISPL_FMT_LEV1.BIT]			[MDG_DISPL_FMT_LEV2.BIT_FCS_MC]			[MDG_DISPL_FMT_LEV3.NONE]	[MDG_DISPL_FMT_LEV4.NONE]	= PAGE_BIT_FCS_MC
pages_by_mode[MDG_DISPL_FMT_LEV1.BIT]			[MDG_DISPL_FMT_LEV2.BIT_NAV]			[MDG_DISPL_FMT_LEV3.NONE]	[MDG_DISPL_FMT_LEV4.NONE]	= PAGE_BIT_NAV
pages_by_mode[MDG_DISPL_FMT_LEV1.BIT]			[MDG_DISPL_FMT_LEV2.BIT_SENSORS]		[MDG_DISPL_FMT_LEV3.NONE]	[MDG_DISPL_FMT_LEV4.NONE]	= PAGE_BIT_SENSORS
pages_by_mode[MDG_DISPL_FMT_LEV1.BIT]			[MDG_DISPL_FMT_LEV2.BIT_STAT_MON]		[MDG_DISPL_FMT_LEV3.NONE]	[MDG_DISPL_FMT_LEV4.NONE]	= PAGE_BIT_STAT_MON
pages_by_mode[MDG_DISPL_FMT_LEV1.BIT]			[MDG_DISPL_FMT_LEV2.BIT_STORES]			[MDG_DISPL_FMT_LEV3.NONE]	[MDG_DISPL_FMT_LEV4.NONE]	= PAGE_BIT_STORES
pages_by_mode[MDG_DISPL_FMT_LEV1.BIT]			[MDG_DISPL_FMT_LEV2.SW_CONFIG]			[MDG_DISPL_FMT_LEV3.NONE]	[MDG_DISPL_FMT_LEV4.NONE]	= PAGE_SW_CONFIG

pages_by_mode[MDG_DISPL_FMT_LEV1.CHECKLISTS]	[MDG_DISPL_FMT_LEV2.NONE]				[MDG_DISPL_FMT_LEV3.NONE]	[MDG_DISPL_FMT_LEV4.NONE]	= PAGE_CHECKLISTS
pages_by_mode[MDG_DISPL_FMT_LEV1.ENG]			[MDG_DISPL_FMT_LEV2.NONE]				[MDG_DISPL_FMT_LEV3.NONE]	[MDG_DISPL_FMT_LEV4.NONE]	= PAGE_ENG

pages_by_mode[MDG_DISPL_FMT_LEV1.EW]			[MDG_DISPL_FMT_LEV2.EW_MAIN]			[MDG_DISPL_FMT_LEV3.NONE]	[MDG_DISPL_FMT_LEV4.NONE]	= PAGE_EW_MAIN
pages_by_mode[MDG_DISPL_FMT_LEV1.EW]			[MDG_DISPL_FMT_LEV2.EW_MAIN_RWR]		[MDG_DISPL_FMT_LEV3.NONE]	[MDG_DISPL_FMT_LEV4.NONE]	= PAGE_EW_MAIN_RWR
pages_by_mode[MDG_DISPL_FMT_LEV1.EW]			[MDG_DISPL_FMT_LEV2.EW_PROG]			[MDG_DISPL_FMT_LEV3.NONE]	[MDG_DISPL_FMT_LEV4.NONE]	= PAGE_EW_PROG

pages_by_mode[MDG_DISPL_FMT_LEV1.FCS]			[MDG_DISPL_FMT_LEV2.NONE]				[MDG_DISPL_FMT_LEV3.NONE]	[MDG_DISPL_FMT_LEV4.NONE]	= PAGE_FCS
pages_by_mode[MDG_DISPL_FMT_LEV1.FLIR]			[MDG_DISPL_FMT_LEV2.FLIR_AG]			[MDG_DISPL_FMT_LEV3.NONE]	[MDG_DISPL_FMT_LEV4.NONE]	= PAGE_FLIR_AG
pages_by_mode[MDG_DISPL_FMT_LEV1.FLIR]			[MDG_DISPL_FMT_LEV2.FLIR_AA]			[MDG_DISPL_FMT_LEV3.NONE]	[MDG_DISPL_FMT_LEV4.NONE]	= PAGE_FLIR_AA
pages_by_mode[MDG_DISPL_FMT_LEV1.FLIR]			[MDG_DISPL_FMT_LEV2.FLIR_LSS]			[MDG_DISPL_FMT_LEV3.NONE]	[MDG_DISPL_FMT_LEV4.NONE]	= PAGE_FLIR_LSS
pages_by_mode[MDG_DISPL_FMT_LEV1.FPAS]			[MDG_DISPL_FMT_LEV2.NONE]				[MDG_DISPL_FMT_LEV3.NONE]	[MDG_DISPL_FMT_LEV4.NONE]	= PAGE_FPAS
pages_by_mode[MDG_DISPL_FMT_LEV1.FUEL]			[MDG_DISPL_FMT_LEV2.NONE]				[MDG_DISPL_FMT_LEV3.NONE]	[MDG_DISPL_FMT_LEV4.NONE]	= PAGE_FUEL

pages_by_mode[MDG_DISPL_FMT_LEV1.HSI]			[MDG_DISPL_FMT_LEV2.NONE]				[MDG_DISPL_FMT_LEV3.NONE]	[MDG_DISPL_FMT_LEV4.NONE]	= PAGE_HSI_MAIN
pages_by_mode[MDG_DISPL_FMT_LEV1.HSI_AMPCD]		[MDG_DISPL_FMT_LEV2.NONE]				[MDG_DISPL_FMT_LEV3.NONE]	[MDG_DISPL_FMT_LEV4.NONE]	= PAGE_HSI_MAIN_AMPCD
pages_by_mode[MDG_DISPL_FMT_LEV1.HSI]			[MDG_DISPL_FMT_LEV2.HSI_DATA]			[MDG_DISPL_FMT_LEV3.AC]		[MDG_DISPL_FMT_LEV4.NONE]	= PAGE_HSI_DATA_AC
pages_by_mode[MDG_DISPL_FMT_LEV1.HSI]			[MDG_DISPL_FMT_LEV2.HSI_DATA]			[MDG_DISPL_FMT_LEV3.WYPT]	[MDG_DISPL_FMT_LEV4.NONE]	= PAGE_HSI_DATA_WYPT
pages_by_mode[MDG_DISPL_FMT_LEV1.HSI]			[MDG_DISPL_FMT_LEV2.HSI_DATA]			[MDG_DISPL_FMT_LEV3.TCN]	[MDG_DISPL_FMT_LEV4.NONE]	= PAGE_HSI_DATA_TCN
pages_by_mode[MDG_DISPL_FMT_LEV1.HSI]			[MDG_DISPL_FMT_LEV2.HSI_DATA]			[MDG_DISPL_FMT_LEV3.GRID]	[MDG_DISPL_FMT_LEV4.NONE]	= PAGE_HSI_DATA_GRID
pages_by_mode[MDG_DISPL_FMT_LEV1.HSI]			[MDG_DISPL_FMT_LEV2.NONE]				[MDG_DISPL_FMT_LEV3.BACKUP]	[MDG_DISPL_FMT_LEV4.NONE]	= PAGE_HSI_BACKUP

pages_by_mode[MDG_DISPL_FMT_LEV1.MUMI]			[MDG_DISPL_FMT_LEV2.NONE]				[MDG_DISPL_FMT_LEV3.NONE]	[MDG_DISPL_FMT_LEV4.NONE]	= PAGE_MUMI

pages_by_mode[MDG_DISPL_FMT_LEV1.RDR]			[MDG_DISPL_FMT_LEV2.RDR_AA]				[MDG_DISPL_FMT_LEV3.NONE]	[MDG_DISPL_FMT_LEV4.NONE]	= PAGE_RDR_AA
pages_by_mode[MDG_DISPL_FMT_LEV1.RDR]			[MDG_DISPL_FMT_LEV2.RDR_AA]				[MDG_DISPL_FMT_LEV3.DATA]	[MDG_DISPL_FMT_LEV4.NONE]	= PAGE_RDR_AA_DATA
pages_by_mode[MDG_DISPL_FMT_LEV1.RDR]			[MDG_DISPL_FMT_LEV2.RDR_AA]				[MDG_DISPL_FMT_LEV3.BACKUP]	[MDG_DISPL_FMT_LEV4.NONE]	= PAGE_RDR_AA_BACKUP
pages_by_mode[MDG_DISPL_FMT_LEV1.RDR]			[MDG_DISPL_FMT_LEV2.RDR_AG]				[MDG_DISPL_FMT_LEV3.NONE]	[MDG_DISPL_FMT_LEV4.NONE]	= PAGE_RDR_AG
pages_by_mode[MDG_DISPL_FMT_LEV1.RDR]			[MDG_DISPL_FMT_LEV2.RDR_AG]				[MDG_DISPL_FMT_LEV3.DATA]	[MDG_DISPL_FMT_LEV4.NONE]	= PAGE_RDR_AG_DATA
pages_by_mode[MDG_DISPL_FMT_LEV1.RDR]			[MDG_DISPL_FMT_LEV2.RDR_AG]				[MDG_DISPL_FMT_LEV3.BACKUP]	[MDG_DISPL_FMT_LEV4.NONE]	= PAGE_RDR_AG_BACKUP
pages_by_mode[MDG_DISPL_FMT_LEV1.RDR]			[MDG_DISPL_FMT_LEV2.RDR_AG]				[MDG_DISPL_FMT_LEV3.AGR]	[MDG_DISPL_FMT_LEV4.NONE] 	= PAGE_RDR_AGR
pages_by_mode[MDG_DISPL_FMT_LEV1.RDR]			[MDG_DISPL_FMT_LEV2.RDR_AG]				[MDG_DISPL_FMT_LEV3.AGR]	[MDG_DISPL_FMT_LEV4.DATA] 	= PAGE_RDR_AGR_DATA

pages_by_mode[MDG_DISPL_FMT_LEV1.SA]			[MDG_DISPL_FMT_LEV2.NONE]				[MDG_DISPL_FMT_LEV3.NONE]	[MDG_DISPL_FMT_LEV4.NONE]	= PAGE_SA
pages_by_mode[MDG_DISPL_FMT_LEV1.SA_AMPCD]		[MDG_DISPL_FMT_LEV2.NONE]				[MDG_DISPL_FMT_LEV3.NONE]	[MDG_DISPL_FMT_LEV4.NONE]	= PAGE_SA_AMPCD

pages_by_mode[MDG_DISPL_FMT_LEV1.STORES]		[MDG_DISPL_FMT_LEV2.NONE]				[MDG_DISPL_FMT_LEV3.NONE]	[MDG_DISPL_FMT_LEV4.NONE]	= PAGE_STORES
pages_by_mode[MDG_DISPL_FMT_LEV1.MAV]			[MDG_DISPL_FMT_LEV2.NONE]				[MDG_DISPL_FMT_LEV3.NONE]	[MDG_DISPL_FMT_LEV4.NONE]	= PAGE_MAV_VIDEO
pages_by_mode[MDG_DISPL_FMT_LEV1.SLAM]			[MDG_DISPL_FMT_LEV2.NONE]				[MDG_DISPL_FMT_LEV3.NONE]	[MDG_DISPL_FMT_LEV4.NONE]	= PAGE_SLAM_VIDEO
pages_by_mode[MDG_DISPL_FMT_LEV1.WALLEYE]		[MDG_DISPL_FMT_LEV2.NONE]				[MDG_DISPL_FMT_LEV3.NONE]	[MDG_DISPL_FMT_LEV4.NONE]	= PAGE_WALLEYE_VIDEO
pages_by_mode[MDG_DISPL_FMT_LEV1.DATALINK]		[MDG_DISPL_FMT_LEV2.NONE]				[MDG_DISPL_FMT_LEV3.NONE]	[MDG_DISPL_FMT_LEV4.NONE]	= PAGE_DATALINK_VIDEO

pages_by_mode[MDG_DISPL_FMT_LEV1.SPIN]			[MDG_DISPL_FMT_LEV2.NONE]				[MDG_DISPL_FMT_LEV3.NONE]	[MDG_DISPL_FMT_LEV4.NONE]	= PAGE_SPIN
pages_by_mode[MDG_DISPL_FMT_LEV1.UFC_BU]		[MDG_DISPL_FMT_LEV2.NONE]				[MDG_DISPL_FMT_LEV3.NONE]	[MDG_DISPL_FMT_LEV4.NONE]	= PAGE_UFC_BU
pages_by_mode[MDG_DISPL_FMT_LEV1.HARM]	    	[MDG_DISPL_FMT_LEV2.HARM_SP]			[MDG_DISPL_FMT_LEV3.NONE]   [MDG_DISPL_FMT_LEV4.NONE]   = PAGE_HARM_SP
pages_by_mode[MDG_DISPL_FMT_LEV1.HARM]	    	[MDG_DISPL_FMT_LEV2.HARM_TOO]			[MDG_DISPL_FMT_LEV3.NONE]   [MDG_DISPL_FMT_LEV4.NONE]   = PAGE_HARM_TOO
pages_by_mode[MDG_DISPL_FMT_LEV1.HARM]	    	[MDG_DISPL_FMT_LEV2.HARM_PB]			[MDG_DISPL_FMT_LEV3.NONE]   [MDG_DISPL_FMT_LEV4.NONE]   = PAGE_HARM_PB
pages_by_mode[MDG_DISPL_FMT_LEV1.HARM]	    	[MDG_DISPL_FMT_LEV2.HARM_CLASS]			[MDG_DISPL_FMT_LEV3.NONE]   [MDG_DISPL_FMT_LEV4.NONE]   = PAGE_HARM_CLASS
pages_by_mode[MDG_DISPL_FMT_LEV1.HARM]	    	[MDG_DISPL_FMT_LEV2.HARM_SCAN]			[MDG_DISPL_FMT_LEV3.NONE]   [MDG_DISPL_FMT_LEV4.NONE]   = PAGE_HARM_SCAN

pages_by_mode[MDG_DISPL_FMT_LEV1.JDAM_JSOW]		[MDG_DISPL_FMT_LEV2.NONE]				[MDG_DISPL_FMT_LEV3.NONE]	[MDG_DISPL_FMT_LEV4.NONE]	= PAGE_JDAM_JSOW
pages_by_mode[MDG_DISPL_FMT_LEV1.MISSION_DATA]	[MDG_DISPL_FMT_LEV2.NONE]				[MDG_DISPL_FMT_LEV3.NONE]	[MDG_DISPL_FMT_LEV4.NONE]	= PAGE_MISSION_DATA
pages_by_mode[MDG_DISPL_FMT_LEV1.JPF]			[MDG_DISPL_FMT_LEV2.NONE]				[MDG_DISPL_FMT_LEV3.NONE]	[MDG_DISPL_FMT_LEV4.NONE]	= PAGE_JPF

pages_by_mode[MDG_DISPL_FMT_LEV1.HMD]			[MDG_DISPL_FMT_LEV2.NONE]				[MDG_DISPL_FMT_LEV3.NONE]	[MDG_DISPL_FMT_LEV4.NONE]	= PAGE_HMD
pages_by_mode[MDG_DISPL_FMT_LEV1.HMD]			[MDG_DISPL_FMT_LEV2.HMD_REJECT]			[MDG_DISPL_FMT_LEV3.NONE]	[MDG_DISPL_FMT_LEV4.NONE]	= PAGE_HMD_REJECT
pages_by_mode[MDG_DISPL_FMT_LEV1.HMD]			[MDG_DISPL_FMT_LEV2.HMD_MIDS]			[MDG_DISPL_FMT_LEV3.NONE]	[MDG_DISPL_FMT_LEV4.NONE]	= PAGE_HMD_MIDS

pages_by_mode[MDG_DISPL_FMT_LEV1.MIDS]			[MDG_DISPL_FMT_LEV2.NONE]				[MDG_DISPL_FMT_LEV3.NONE]	[MDG_DISPL_FMT_LEV4.NONE]	= PAGE_MIDS

pages_by_mode[MDG_DISPL_FMT_LEV1.TGT_DATA]		[MDG_DISPL_FMT_LEV2.TGT_DATA_OWNSHIP]	[MDG_DISPL_FMT_LEV3.NONE]	[MDG_DISPL_FMT_LEV4.NONE]	= PAGE_TGT_DATA_OWNSHIP
pages_by_mode[MDG_DISPL_FMT_LEV1.TGT_DATA]		[MDG_DISPL_FMT_LEV2.TGT_DATA_GROUP]		[MDG_DISPL_FMT_LEV3.NONE]	[MDG_DISPL_FMT_LEV4.NONE]	= PAGE_TGT_DATA_GROUP

pages_by_mode[MDG_DISPL_FMT_LEV1.ACL]			[MDG_DISPL_FMT_LEV2.NONE]				[MDG_DISPL_FMT_LEV3.NONE]	[MDG_DISPL_FMT_LEV4.NONE]	= PAGE_ACL

function get_page_by_mode(master, L2, L3, L4)
	return get_page_by_mode_global(pages_by_mode, init_pageID, master, L2, L3, L4)
end


multipleSymbolsIDs =
{
	RDR_CONTACT 			= 0,
	SA_PPLI 				= 1,
	SA_FF 					= 2,
	SA_SURVEILLANCE 		= 3,
	SA_AIR_DEFENSE			= 4,
	RDR_PPLI 				= 5,
	RDR_FF 					= 6,
	RDR_SURVEILLANCE 		= 7,
	RDR_TRACKS		 		= 8,
	AZ_EL_TRACKS			= 9,
	RDR_AG_TRACKS		 	= 10,
	AFLIR_WYPT_SYMB			= 11,
}
	
multipleSymbols = {}
multipleSymbols[multipleSymbolsIDs.RDR_CONTACT] 			= "RDR_contact"
multipleSymbols[multipleSymbolsIDs.SA_PPLI] 				= "SA_ppli"
multipleSymbols[multipleSymbolsIDs.SA_FF] 					= "SA_ff"
multipleSymbols[multipleSymbolsIDs.SA_SURVEILLANCE] 		= "SA_surveillance"
multipleSymbols[multipleSymbolsIDs.SA_AIR_DEFENSE]			= "SA_AirDefense"
multipleSymbols[multipleSymbolsIDs.RDR_PPLI] 				= "RDR_ppli"
multipleSymbols[multipleSymbolsIDs.RDR_FF] 					= "RDR_ff"
multipleSymbols[multipleSymbolsIDs.RDR_SURVEILLANCE] 		= "RDR_surveillance"
multipleSymbols[multipleSymbolsIDs.RDR_TRACKS] 				= "RDR_tracks"
multipleSymbols[multipleSymbolsIDs.AZ_EL_TRACKS] 			= "AZ_EL_tracks"
multipleSymbols[multipleSymbolsIDs.RDR_AG_TRACKS] 			= "RDR_AG_tracks"
multipleSymbols[multipleSymbolsIDs.AFLIR_WYPT_SYMB] 		= "AFLIR_WYPT_symb"

function getMultipleSymbolByID(id)
	local name = ""
	if multipleSymbols[id] == nil then
		return name
	else
		return multipleSymbols[id]
	end
end

templates = {}
templates["RADAR_CONTACTS"] 		= SUBSET_RDR_CONTACTS
templates["SA_PPLI"] 				= SUBSET_SA_PPLI
templates["SA_FF"] 					= SUBSET_SA_FF
templates["SA_SURVEILLANCE"] 		= SUBSET_SA_SURVEILLANCE
templates["SA_AIR_DEFENSE"] 		= SUBSET_SA_AIR_DEFENSE
templates["RDR_PPLI"] 				= SUBSET_RDR_PPLI
templates["RDR_FF"] 				= SUBSET_RDR_FF
templates["RDR_SURVEILLANCE"] 		= SUBSET_RDR_SURVEILLANCE
templates["RDR_TRACKS"] 			= SUBSET_RDR_TRACKS
templates["AZ_EL_TRACKS"] 			= SUBSET_AZ_EL_TRACKS
templates["RADAR_AG_TRACKS"] 		= SUBSET_RDR_AG_TRACKS
templates["AFLIR_WYPT_SYMB"] 		= SUBSET_AFLIR_WYPT_SYMB

function get_template(name)
	if templates[name] ~= nil then
		return templates[name]	
	end
	return -1
end
