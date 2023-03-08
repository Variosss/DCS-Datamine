dofile (LockOn_Options.script_path.."EKRAN\\Device\\EKRAN_localizer.lua")

device_timer_dt = 0.2

RAM_capacity_memory = 64
RAM_capacity_queue = 256 -- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!64
RAM_capacity_RPK = 64

time_selftest = 5.0
time_to_takeoff_mode = 5.0
time_to_flightPK_mode_1 = 2.0
time_to_flightPK_mode_2 = 0.0
time_to_doc_mode_1 = 2.0
time_to_doc_mode_2 = 8.0
max_messages = 310 -- overall length of the tape = 18 meters

-- messages[ID] = {cat no, priority, output string} -- description (optional)
messages = {}
-- COMMON PART
messages[1]   = {  0,   0, LOCALIZE("BLANK")}                      -- BLANK
messages[2]   = {  0,   0, LOCALIZE("SELFTEST")}                   -- SELFTEST
messages[3]   = {  0,   0, LOCALIZE("EKRAN_READY")}                -- EKRAN READY
messages[4]   = {  0,   0, LOCALIZE("EKRAN_FAILURE")}              -- EKRAN FAILURE
messages[5]   = {  0,   0, LOCALIZE("FLIGHT")}                     -- FLIGHT
messages[6]   = {  0,   0, LOCALIZE("DOCUMENT")}                   -- DOCUMENT
messages[7]   = {  0,   0, LOCALIZE("DOC_MESS")}                   -- document message

-------------------------------------------------------------
-- SPECIPHIC PART
--
-- " = \"
-- FLIGHT CONTROL MODE
messages[8]   = {  1,   1, LOCALIZE("RECEIVE_DL_TARGET")}           -- RECEIVE DL TARGET
messages[9]   = {  2,   2, LOCALIZE("MAIN_HYDRO")}                  -- MAIN HYDRO
messages[10]  = {  3,   3, LOCALIZE("COMMON_HYDRO")}                -- COMMON HYDRO
messages[11]  = {  4,   4, LOCALIZE("EXTEND_GEAR")}                 -- EXTEND GEAR
messages[12]  = {  5,   5, LOCALIZE("MAIN_TRANSM_OIL_PRESS")}       -- MAIN TRANSM OIL PRESS
messages[13]  = {  6,   6, LOCALIZE("MAIN_TRANSM_OIL_TEMP")}        -- MAIN TRANSM OIL TEMP
messages[14]  = {  7,   7, LOCALIZE("MAIN_TRANSM_CHIP")}            -- MAIN TRANSM CHIP
messages[15]  = { 10,   8, LOCALIZE("TURN_ON_BACKUP_TRANSP")}       -- TURN ON BACKUP TRANSP
messages[16]  = { 11,   9, LOCALIZE("ELEC_ON_BATTERY")}             -- ELEC ON BATTERY
messages[17]  = { 30,  24, LOCALIZE("USE_TV")}                      -- USE TV
messages[18]  = { 31,  25, LOCALIZE("TURN_ON_MAN_ATCK_USE_HUD_TV")} -- TURN ON MAN ATCK USE HUD-TV
messages[19]  = { 34,  28, LOCALIZE("TURN_ON_NAV_BACKUP")}          -- TURN ON NAV BACKUP
messages[20]  = { 14,  12, LOCALIZE("WPN_CTRL_ROCKET_FAILURE")}     -- WPN CTRL ROCKET FAILURE

messages[21]  = {247,  13, LOCALIZE("GUN_DRIVE_FAILURE")}           -- GUN DRIVE FAILURE
messages[22]  = {250,  13, LOCALIZE("GUN_DRIVE_FAILURE")}           -- GUN DRIVE FAILURE

messages[23]  = { 16,  14, LOCALIZE("FORWARD_TANK_110")}            -- FORWARD TANK 110
messages[24]  = { 17,  15, LOCALIZE("REAR_TANK_110")}               -- REAR TANK 110
messages[25]  = { 20,  16, LOCALIZE("TURN_ON_ROTOR_ANTIICE")}       -- TURN ON ROTOR ANTIICE

messages[26]  = { 21,  17, LOCALIZE("RADAR_ALT")}                   -- RADAR ALT
messages[27]  = { 22,  18, LOCALIZE("INU")}                         -- INU
messages[28]  = { 23,  19, LOCALIZE("DL_MEMORY_FAILURE")}           -- DL MEMORY FAILURE
messages[29]  = { 24,  20, LOCALIZE("TURN_ON_SBY_RTCL_USE_FIXED_GUN")} -- TURN ON SBY RTCL USE FIXED GUN
messages[30]  = { 25,  21, LOCALIZE("USE_FIXED_GUN")}               -- USE FIXED GUN
messages[31]  = { 26,  22, LOCALIZE("DATALINK_FAILURE")}            -- DATALINK FAILURE
messages[32]  = { 40,  31, LOCALIZE("TURN_ON_INVERTER")}            -- TURN ON INVERTER
messages[33]  = { 44,  35, LOCALIZE("LWS_FAILURE")}                 -- LWS FAILURE
messages[34]  = { 45,  36, LOCALIZE("LEFT_TRANSM_OIL_PRESS")}       -- LEFT TRANSM OIL PRESS
messages[35]  = { 46,  37, LOCALIZE("LEFT_TRANSM_OIL_TEMP")}        -- LEFT TRANSM OIL TEMP
messages[36]  = { 47,  38, LOCALIZE("LEFT_TRANSM_CHIP")}            -- LEFT TRANSM CHIP
messages[37]  = { 50,  39, LOCALIZE("RIGHT_TRANSM_OIL_PRESS")}      -- RIGHT TRANSM OIL PRESS
messages[38]  = { 51,  40, LOCALIZE("RIGHT_TRANSM_OIL_TEMP")}       -- RIGHT TRANSM OIL TEMP
messages[39]  = { 52,  41, LOCALIZE("RIGHT_TRANSM_CHIP")}           -- RIGHT TRANSM CHIP
messages[40]  = { 53,  42, LOCALIZE("ACTUATOR_OIL_PRESS")}          -- ACTUATOR OIL PRESS
messages[41]  = { 54,  43, LOCALIZE("TURN_ON_ARM_SYS_SAFE_SW")}     -- TURN ON ARM SYS SAFE SW
messages[42]  = { 55,  44, LOCALIZE("STANDBY_ATTITUDE_IND")}        -- STANDBY ATTITUDE IND
messages[43]  = { 56,  44, LOCALIZE("LEFT_PROBE_HEAT_FAILURE")}     -- LEFT PROBE HEAT FAILURE
messages[44]  = { 57,  44, LOCALIZE("RIGHT_PROBE_HEAT_FAILURE")}    -- RIGHT PROBE HEAT FAILURE
messages[45]  = { 60,  45, LOCALIZE("AIR_DATA_SYS")}                -- AIR DATA SYS
messages[46]  = { 61,  46, LOCALIZE("DOPPLER_NAV_SYS")}             -- DOPPLER NAV SYS
messages[47]  = { 41,  32, LOCALIZE("HUNG_WEAPON")}                 -- HUNG WEAPON
messages[48]  = { 42,  33, LOCALIZE("TURN_OFF_L-140")}              -- TURN OFF L-140
messages[49]  = { 62,  47, LOCALIZE("HEADING_INVALID")}             -- HEADING INVALID
messages[50]  = { 63,  48, LOCALIZE("NAV_POS_INVALID")}             -- NAV POS INVALID
messages[51]  = { 64,  49, LOCALIZE("ROUTE_NAV_FAILURE")}           -- ROUTE NAV FAILURE
messages[52]  = { 65,  50, LOCALIZE("NAV_DATA_MEMORY_FAILURE")}     -- NAV DATA MEMORY FAILURE
messages[53]  = { 66,  51, LOCALIZE("PERFORM_NAV_POS_FIX")}         -- PERFORM NAV POS FIX
messages[54]  = { 67,  52, LOCALIZE("LEFT_GEN")}                    -- LEFT GEN
messages[55]  = { 70,  53, LOCALIZE("RIGHT_GEN")}                   -- RIGHT GEN
messages[56]  = { 71,  54, LOCALIZE("LEFT_DC_RECTIF_FAILURE")}      -- LEFT DC RECTIF FAILURE
messages[57]  = { 72,  55, LOCALIZE("RIGHT_DC_RECTIF_FAILURE")}     -- RIGHT DC RECTIF FAILURE
messages[58]  = { 73,  56, LOCALIZE("LEFT_ENG_GOVERNOR")}           -- LEFT ENG GOVERNOR
messages[59]  = { 74,  57, LOCALIZE("RIGHT_ENG_GOVERNOR")}          -- RIGHT ENG GOVERNOR
messages[60]  = { 43,  34, LOCALIZE("CMD_FAILURE")}                 -- CMD FAILURE
messages[61]  = { 35,  29, LOCALIZE("LOW_COCKPIT_PRESS")}           -- LOW COCKPIT PRESS
messages[62]  = { 76,  59, LOCALIZE("NO_HYDRO_PRESS")}              -- NO HYDRO PRESS
messages[63]  = { 36,  29, LOCALIZE("AIRCOND_FAILURE")}             -- AIRCOND FAILURE
messages[64]  = { 37,  30, LOCALIZE("ROTOR_ANTIICE_FAILURE")}       -- ROTOR ANTIICE FAILURE
messages[65]  = { 77,  60, LOCALIZE("HI_VIBR_LEFT_ENG")}            -- HI VIBR LEFT ENG
messages[66]  = {100,  61, LOCALIZE("HI_VIBR_RIGHT_ENG")}           -- HI VIBR RIGHT ENG
messages[67]  = {142,  62, LOCALIZE("FLIGHT_DATA_REC_FAILURE")}     -- FLIGHT DATA REC FAILURE
messages[68]  = {102,  63, LOCALIZE("WPN_CTRL_MEMORY_FAILURE")}     -- WPN CTRL MEMORY FAILURE
messages[69]  = {103,  64, LOCALIZE("LEFT_ENG_CHIP")}               -- LEFT ENG CHIP
messages[70]  = {104,  65, LOCALIZE("RIGHT_ENG_CHIP")}              -- RIGHT ENG CHIP
messages[71]  = {105,  66, LOCALIZE("LEFT_ENG_OIL_PRESS")}          -- LEFT ENG OIL PRESS
messages[72]  = {106,  67, LOCALIZE("RIGHT_ENG_OIL_PRESS")}         -- RIGHT ENG OIL PRESS
messages[73]  = {107,  68, LOCALIZE("NO_GUN_INTERLCK")}             -- NO GUN INTERLCK

-- ONLY DOCUMENT MODE
messages[74]  = {132, 999, LOCALIZE("ROTOR_RPM")}                   -- ROTOR RPM
messages[75]  = {133, 999, LOCALIZE("MAX_G")}                       -- MAX G
messages[76]  = {134, 999, LOCALIZE("MAX_IAS")}                     -- MAX IAS
messages[77]  = {120, 999, LOCALIZE("TRANSP_FAILURE")}              -- TRANSP FAILURE
messages[78]  = {121, 999, LOCALIZE("WARNING_THREAT")}              -- WARNING THREAT
messages[79]  = {141, 999, LOCALIZE("LEFT_ENG_FIRE")}               -- LEFT ENG FIRE
messages[80]  = {143, 999, LOCALIZE("RIGHT_ENG_FIRE")}              -- RIGHT ENG FIRE
messages[81]  = {144, 999, LOCALIZE("HYDRO_FIRE")}                  -- HYDRO FIRE
messages[82]  = {145, 999, LOCALIZE("FAN_FIRE")}                    -- FAN FIRE
messages[83]  = {146, 999, LOCALIZE("APU_FIRE")}                    -- APU FIRE
messages[84]  = {112, 999, LOCALIZE("MAX_RPM_LEFT_ENG")}            -- MAX RPM LEFT ENG
messages[85]  = {116, 999, LOCALIZE("MAX_RPM_RIGHT_ENG")}           -- MAX RPM RIGHT ENG
messages[86]  = {117, 999, LOCALIZE("DANGER_VIBR_LEFT_ENG")}        -- DANGER VIBR LEFT ENG
messages[87]  = {118, 999, LOCALIZE("DANGER_VIBR_RIGHT_ENG")}       -- DANGER VIBR RIGHT ENG
messages[88]  = {158, 999, LOCALIZE("HYDRO_FIRE_WARN_SYS")}         -- HYDRO FIRE WARN SYS
messages[89]  = {159, 999, LOCALIZE("APU_FIRE_WARN_SYS")}           -- APU FIRE WARN SYS
messages[90]  = {114, 999, LOCALIZE("FORWARD_TANK_OFF")}            -- FORWARD TANK OFF
messages[91]  = {115, 999, LOCALIZE("REAR_TANK_OFF")}               -- REAR TANK OFF
messages[92]  = {123, 999, LOCALIZE("LEFT_FUEL_VALVE")}             -- LEFT FUEL VALVE
messages[93]  = {124, 999, LOCALIZE("RIGHT_FUEL_VALVE")}            -- RIGHT FUEL VALVE
messages[94]  = {122, 999, LOCALIZE("ENG_ANTIICE")}                 -- ENG ANTIICE
messages[95]  = {125, 999, LOCALIZE("ENG_ANTIDUST")}                -- ENG ANTIDUST
messages[96]  = {130, 999, LOCALIZE("LEFT_ENG_STOP")}               -- LEFT ENG STOP
messages[97]  = {131, 999, LOCALIZE("RIGHT_ENG_STOP")}              -- RIGHT ENG STOP
messages[98]  = {303, 999, LOCALIZE("MASTER_ARM")}                  -- MASTER ARM
messages[99] = {201, 999, LOCALIZE("ANTITANK_PICKLE")}             -- ANTITANK PICKLE
messages[100] = {202, 999, LOCALIZE("ROCKET_PICKLE")}               -- ROCKET PICKLE
messages[101] = {203, 999, LOCALIZE("CANNON_FIRE")}                 -- CANNON FIRE
messages[102] = {204, 999, LOCALIZE("SUSP_RELEASE")}                -- SUSP RELEASE

-- ONLY GROUND CONTROL MODE
messages[103] = {155, 999, LOCALIZE("LEFT_ENG_FIRE_WARN_SYS")}      -- LEFT ENG FIRE WARN SYS
messages[104] = {156, 999, LOCALIZE("RIGHT_ENG_FIRE_WARN_SYS")}     -- RIGHT ENG FIRE WARN SYS
messages[105] = {157, 999, LOCALIZE("TURN_OFF_ARM_SYS_SAFE_SW")}    -- TURN OFF ARM SYS SAFE SW
messages[106] = {267, 999, LOCALIZE("FAN_FWS")}                     -- FAN FWS

need_to_be_closed = true -- lua_state  will be closed in post_initialize()
--[[
need_to_be_closed = false -- lua_state  will be closed in post_initialize()

local ekran = GetSelf()
function NextTime(r,t)
	dbg_print("ekran print:\n"..ekran:get_actual_text_frame().."\n")
	return true, t + 1
end

local routine = coroutine_create(0)
      routine.next_event = NextTime
      routine:start(1)

function CoroutineResume(index,time_)
	if     routine            == nil or 
		   routine.next_event == nil then 
		   return false 
	end
	return routine:next_event(time_) 
end

function on_state_close()
	routine:kill_me()
	routine = nil
end
--]]
