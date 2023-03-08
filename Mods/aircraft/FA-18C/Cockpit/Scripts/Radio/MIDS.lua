--
local gettext = require("i_18n")
_ = gettext.translate

--
need_to_be_closed = true -- lua_state  will be closed in post_initialize()
device_timer_dt = 0.05

-- TACAN
warmupDelay				= 1.0	-- sec
cooldownDelay			= 1.0	-- sec

bearingMemoryDuration	= 3.0	-- sec
rangeMemoryDuration		= 15.0	-- sec

bearingAcqDuration		= 0.5	-- sec
rangeAcqDuration		= 0.5	-- sec

-- 


--[[
FAILURE_MIDS_ANT		= 0
FAILURE_MIDS_TOTAL	= 1

Damage = {	
	{Failure = FAILURE_MIDS_ANT,	Failure_name = "FAILURE_MIDS_ANT",		Failure_editor_name = _("MIDS Antenna FAILURE"),	Element = 1,	Integrity_Treshold = 0.3, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},	-- TODO: element
	{Failure = FAILURE_MIDS_TOTAL,	Failure_name = "FAILURE_MIDS_TOTAL",	Failure_editor_name = _("MIDS Total FAILURE"),		Element = 82,	Integrity_Treshold = 0.2, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},	-- TODO: element
}
--]]


AirSpecificTypes = {}

AirSpecificTypes[63]	= {"MG23"}		-- MIG_23_FLOGGER
AirSpecificTypes[73]	= {"MG29"}		-- MIG_29_FULCRUM
AirSpecificTypes[72]	= {"SU27"}		-- SU_27_FLANKER
AirSpecificTypes[89]	= {"SU33"}		-- SU_33_SU_27K
AirSpecificTypes[4]		= {"F14"}		-- F_14_TOMCAT
AirSpecificTypes[5]		= {"F15"}		-- F_15_EAGLE
AirSpecificTypes[6]		= {"F16"}		-- F_16_FIGHTING_FALCON

AirSpecificTypes[64]	= {"MG25"}		-- MIG_25_FOXBAT
AirSpecificTypes[74]	= {"MG31"}		-- MIG_31_FOXHOUND
AirSpecificTypes[322]	= {"GR4"}		-- TORNADO_GR4

AirSpecificTypes[65]	= {"MG27"}		-- MIG_27_FLOGGER
AirSpecificTypes[58]	= {"SU24"}		-- SU_24_FENCER
AirSpecificTypes[88]	= {"SU30"}		-- SU_30
AirSpecificTypes[12]	= {"FA18"}		-- F_A_18_HORNET_FIGHTER
AirSpecificTypes[11]	= {"F111"}		-- F_111_GENERAL_DYNAMICS

AirSpecificTypes[59]	= {"SU25"}		-- SU_25_FROGFOOT
AirSpecificTypes[259]	= {"A10"}		-- A_10_THUNDERBOLT_II

AirSpecificTypes[298]	= {"TU160"}		-- TU_160_BLACKJACK
AirSpecificTypes[261]	= {"B1"}		-- B_1_ROCKWELL
AirSpecificTypes[90]	= {"SU34"}		-- SU_34
AirSpecificTypes[294]	= {"TU95"}		-- TU_95_BEAR
AirSpecificTypes[295]	= {"TU142"}		-- TU_142_BEAR
AirSpecificTypes[262]	= {"B52"}		-- B_52_STRATOFORTRESS

AirSpecificTypes[64]	= {"MG25"}		-- MIG_25_FOXBAT
AirSpecificTypes[293]	= {"TU22"}		-- TU_22M_BACKFIRE

AirSpecificTypes[601]	= {"IL76"}		-- IL_76_MAINSTAY
AirSpecificTypes[513]	= {"E3"}		-- E_3_SENTRY_AWACS

AirSpecificTypes[1137]	= {"IL78"}		-- IL_78_MIDAS
AirSpecificTypes[525]	= {"KC10"}		-- KC_10_EXTENDER

AirSpecificTypes[1100]	= {"IL76"}		-- IL_76_CANDID
AirSpecificTypes[1031]	= {"C130"}		-- C_130_HERCULES
AirSpecificTypes[73]	= {"MG29"}		-- MIG_29_FULCRUM
AirSpecificTypes[544]	= {"S3"}		-- S_3_VIKING
AirSpecificTypes[41]	= {"M2000"}		-- MIRAGE_2000_FIGHTER

AirSpecificTypes[303]	= {"F117"}		-- F_117_NIGHTHAWK
AirSpecificTypes[93]	= {"SU39"}		-- SU_39
AirSpecificTypes[1091]	= {"AN26"}		-- AN_26_CURL
AirSpecificTypes[1093]	= {"AN30"}		-- AN_30_CLANK
AirSpecificTypes[512]	= {"E2"}		-- E_2_HAWKEYE
AirSpecificTypes[544]	= {"S3"}		-- S_3_VIKING
AirSpecificTypes[323]	= {"AV8B"}		-- AV_8B_HARRIER_PLUS
AirSpecificTypes[516]	= {"EA6"}		-- EA_6_PROWLER
AirSpecificTypes[1]		= {"F4"}		-- F_4_PHANTOM_II
AirSpecificTypes[2]		= {"F5"}		-- F_5_TIGER_II
AirSpecificTypes[1125]	= {"C17"}		-- C_17_GLOBEMASTER_III
AirSpecificTypes[54]	= {"SU17"}		-- SU_17_FITTER
AirSpecificTypes[73]	= {"MG29"}		-- MIG_29_FULCRUM
AirSpecificTypes[73]	= {"MG29"}		-- MIG_29_FULCRUM
AirSpecificTypes[58]	= {"SU24"}		-- SU_24_FENCER
AirSpecificTypes[6]		= {"F16"}		-- F_16_FIGHTING_FALCON
AirSpecificTypes[12]	= {"FA18"}		-- F_A_18_HORNET_FIGHTER
AirSpecificTypes[59]	= {"SU25"}		-- SU_25_FROGFOOT

AirSpecificTypes[288]	= {"GR1"}		-- TORNADO_GR_1_IDS
AirSpecificTypes[1106]	= {"YK40"}		-- YAK_40_CODDLING
AirSpecificTypes[259]	= {"A10"}		-- A_10_THUNDERBOLT_II
AirSpecificTypes[5]		= {"F15"}		-- F_15_EAGLE
AirSpecificTypes[527]	= {"KC135"}		-- KC_135_STRATOTANKER
AirSpecificTypes[789]	= {"L39"}		-- L_39_ALBATROS

AirSpecificTypes[72]	= {"SU27"}		-- SU_27_FLANKER

AirSpecificTypes[1335]	= {"MI8"}		-- MI_8_HIP
AirSpecificTypes[1339]	= {"MI24"}		-- MI_24_HIND
AirSpecificTypes[1340]	= {"MI26"}		-- MI_26_HALO
AirSpecificTypes[1345]	= {"KA27"}		-- KA_27_HELIX_A
AirSpecificTypes[1351]	= {"KA50"}		-- KA_50_HOKUM

AirSpecificTypes[1281]	= {"AH64"}		-- AH_64_APACHE
AirSpecificTypes[1281]	= {"AH64"}		-- AH_64_APACHE
AirSpecificTypes[1284]	= {"CH47"}		-- CH_47_CHINOOK
AirSpecificTypes[1341]	= {"CH53"}		-- CH_53E_SUPER_STALLION
AirSpecificTypes[1299]	= {"SH60"}		-- SH_60_SEA_HAWK
AirSpecificTypes[1304]	= {"UH60"}		-- UH_60_BLACK_HAWK
AirSpecificTypes[1280]	= {"AH1"}		-- AH_1_COBRA
AirSpecificTypes[1298]	= {"SH3"}		-- SH_3_SEA_KING
AirSpecificTypes[1399]	= {"MK88"}		-- SEA_LYNX_MK88A
AirSpecificTypes[1387]	= {"AB212"}		-- AB_212_AUGUSTA_BELL
AirSpecificTypes[1348]	= {"MI28"}		-- MI_28_HAVOC
AirSpecificTypes[1294]	= {"OH58"}		-- OH_58_KIOWA

AirSpecificTypes[4093]	= {"UKN"}		-- UNDEFINED (unknown)

-- dev-out
AirSpecificTypes[71]	= {"MG19"}			-- MIG_19_FARMER
AirSpecificTypes[62]	= {"MG21"}			-- MIG_21_FISHBED

-- dev-out and extentions
AirSpecificTypes[16]	= {"J11A"}			-- J_11A
AirSpecificTypes[566]	= {"KJ2000"}		-- KJ_2000
