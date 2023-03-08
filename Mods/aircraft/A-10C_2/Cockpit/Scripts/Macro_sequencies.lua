-- For the DCS A-10C_2

dofile(LockOn_Options.script_path.."devices.lua")

----------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------- DESCRIPTION -----------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------

-- ACCELERATED AUTO-START and AUTO-STOP SEQUENCES for the A-10C II, by Digg3r
-- Latest update: 12 February 2023  - version 1.4

-- Purpose: Provides better organized, better sequenced, better timed, complete, faster AUTO-START and AUTO-PROCESSES

-- This script uses the FAST ALIGN function  for the Inertial Navigation System greatly speed up alignment time.
-- Fast align time is approximately 01:26 (mm:ss); default alignment takes 04:40 (mm:ss).
-- Despite the faster INS alignment, warming up the MFCDs, starting the engines separately, and initializing the navigation system all take time.
-- The overall time for the accelerated AUTO-START procedure is 03:18 (mm:ss)

-- AUTO-STOP time = 39 seconds (default time = 55 seconds)

-- Place this script in ...\Eagle Dynamics\DCS World OpenBeta\Mods\aircraft\A-10C_2\Cockpit\Scripts

-- Changelog:

-- GLOBAL changes:
	-- Translated (where required) then removed all Russian-language annotations and working notes
	-- Verified every entry against the source data scripts (devices.lua and clickabledata.lua)
	-- Completed a rewrite of the whole script from a clean sheet
	-- Removed hundreds of unnecessary six-decimal-point time/value entries; replaced all with one-decimal-point entries
	-- Grouped the script into logical blocks for each sub-process
	-- Reworked event timings to remove unnecessary delays and speed up execution
	-- Added descriptions for all actions in the sequence, for easier reading/editing
	-- Added new code to cancel multiple Master Caution warnings 
	-- Amended the script to provide fewer, less verbose text messages

-- In the AUTO-START section:
	-- Added new code to set all switches to the off position to start the sequence from a truly 'cold and dark' condition
	-- Added new code to turn on the oxygen system
	-- Removed more than 650 lines of code related to cockpit lighting, that could only be activated by separate (incomplete) DCS macros
	-- Added a new block of code for cockpit lighting, suitable for both day and night operations; user can adjust in-game if required at night
	-- Added additional code to ensure external lights are correctly set if the user has the physical pinky switch fully forward
	-- Added a new block of code to initiate FAST ALIGN for the Inertial Navigation System
	-- Changed Counter Measures System code to set the system to STBY instead of MAN
	-- Added new code to provide accurate updates on start and spool-up of the APU and engines 
	-- Added new code to provide accurate updates on the INS alignment process process
	-- Added new code to set the NMSP to TCN and EGI
	-- Added new code to turn on the Helmet Mounted Cueing System
	-- Amended the script to correctly turn on TAXI lights in preparation for taxi, with an option to change this to LANDING lights

-- In the AUTO-STOP section:
	-- Added new code to ensure that all weapons and the TGP are turned off on the AHCP
	-- Added new code to turn the Radar Altimeter off
	-- Added new code to ensure that the Counter Measures System is turned off
	-- Added new code to ensure that the ILS and TACAN are turned off 
	-- Added new code to turn off all engine systems including boost pumps
	-- Added new code to turn off all cockpit lighting
	-- Added new code to turn off the Helmet Mounted Cueing System
	-- Added new code to place the flaps in the fully down position as per SOP, regardless of the user's flap setting
	-- Added new code to turn off the oxygen system
	-- Added new code to DISARM the Ejection Seat

----------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------- AUTO-START PROCESS -------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------

std_message_timeout = 9
short_message_timeout = 6

start_sequence_full = {
-- Housekeeping - all switches to off
{time = 3.80,device = 36,action = 3007,value = 0.0},
{time = 3.81,device = 36,action = 3005,value = 0.0},
{time = 3.82,device = 36,action = 3008,value = 0.0},
{time = 3.83,device = 36,action = 3006,value = 0.0},
{time = 3.84,device = 1,action = 3004,value = 0.0},
{time = 3.85,device = 1,action = 3005,value = 0.0},
{time = 3.86,device = 40,action = 3001,value = 0.0},

{time = 3.87,message = _("ACCELERATED AUTO-START SEQUENCE IN PROGRESS"),message_timeout = 197.0},
{time = 3.88,message = _(" "),message_timeout = 197.5},  -- Spacer

-- Emergency Brake OFF
{time = 3.89,device = 38,action = 3030,value = 0.0,message = _("EMERGENCY BRAKE - OFF"),message_timeout = std_message_timeout}, 

-- Battery ON
{time = 4.0,device = 1,action = 3006,value = 1.0,message = _("BATTERY - ON"),message_timeout = std_message_timeout},

-- Inverter STBY
{time = 4.5,device = 1,action = 3002,value = 1.0,message = _("INVERTER - STBY"),message_timeout = std_message_timeout},

-- APU ON
{time = 5.0,device = 37,action = 3005,value = 1.0,message = _("APU - ON"),message_timeout = std_message_timeout},  -- Run up to 100% = 21 secs

-- Oxygen ON
{time = 5.5,device = 40,action = 3001,value = 1.0,message = _("OXYGEN - ON"),message_timeout = std_message_timeout},

-- Cockpit Lighting
-- Set to DIM (20% brightness) for both day and night operations, user can adjust in-game if required at night
{time = 6.0,device = 49,action = 3006,value = 0.2},  -- Console Lights
{time = 6.1,device = 49,action = 3002,value = 0.2},  -- Flight Instrument Lights
{time = 6.3,device = 49,action = 3003,value = 0.2},  -- Auxilliary Instrument Lights
{time = 6.5,device = 49,action = 3004,value = 0.2},  -- Accelerometer & Compass Lights
{time = 6.7,device = 49,action = 3001,value = 0.2},  -- Engine Instrument Lights
{time = 6.9,device = 49,action = 3005,value = 0.2},  -- Flood Light
{time = 7.0,message = _("COCKPIT LIGHTING - SET"),message_timeout = std_message_timeout},

-- External Lights Set
{time = 7.5,device = 49,action = 3008,value = 1.0},  -- Position Lights FLASH
{time = 7.8,action = 569},  -- Pinky Switch AFT
{time = 8.0,action = 569},  -- Second AFT action in case user has physical pinky switch fully forward
{time = 8.5,message = _("EXTERNAL LIGHTS - SET"),message_timeout = std_message_timeout},

-- Boost Pumps ON
{time = 9.0,device = 36,action = 3007,value = 1.0},  -- Boost Pump Main Left
{time = 9.5,device = 36,action = 3005,value = 1.0},  -- Boost Pump Wing Left
{time = 10.0,device = 36,action = 3008,value = 1.0},  -- Boost Pump Main Right
{time = 10.5,device = 36,action = 3006,value = 1.0},  -- Boost Pump Wing Right
{time = 11.0,message = _("ALL BOOST PUMPS - ON"),message_timeout = std_message_timeout},

-- VHF and UHF Radios ON
{time = 12.0,device = 55,action = 3003,value = 0.1},  -- VHF AM Radio
{time = 12.5,device = 54,action = 3008,value = 0.1},  -- UHF Radio
{time = 13.0,device = 56,action = 3003,value = 0.1,message = _("VHF and UHF RADIOS - ON"),message_timeout = std_message_timeout},  -- VHF FM Radio

-- Engine Generators ON
{time = 13.5,device = 1,action = 3004,value = 1.0},  -- Generator Left ON
{time = 13.8,device = 1,action = 3005,value = 1.0,message = _("LEFT and RIGHT AC GENERATORS - ON"),message_timeout = std_message_timeout},  -- Generator Right ON

-- APU Percentage
{time = 14.0,message = _("APU - 50%"),message_timeout = std_message_timeout},
{time = 26.0,message = _("APU - 100%"),message_timeout = std_message_timeout},

-- APU Generator ON
{time = 26.3,device = 1,action = 3001,value = 1.0,message = _("APU GENERATOR - ON"),message_timeout = std_message_timeout},  -- Not less than 21 seconds after APU ON

-- NMSP TCN OFF
{time = 26.8,device = 46,action = 3006,value = 1.0},  -- Re-engage with NMSP EGI after INS aligned

-- Left Engine START
{time = 27.0,action = 311,message = _("LEFT ENGINE - START"),message_timeout = std_message_timeout},
{time = 29.0,message = _("LEFT ENGINE SPOOLING UP..."),message_timeout = std_message_timeout},

-- Canopy CLOSE
{time = 30.0,device = 39,action = 3006,value = 0.0,message = _("CANOPY - CLOSING"),message_timeout = 6.0},

-- Canopy LOCK
{time = 37.0,device = 39,action = 3006,value = 0.5,message = _("CANOPY - LOCKED"),message_timeout = std_message_timeout},

-- EGI ON
{time = 38.0,device = 22,action = 3006,value = 1.0,message = _("EGI - ON"),message_timeout = std_message_timeout},

-- CDU ON
{time = 38.5,device = 22,action = 3005,value = 1.0,message = _("CDU - ON"),message_timeout = std_message_timeout},

-- CICU ON
{time = 39.0,device = 7,action = 3008,value = 1.0,message = _("CICU - ON"),message_timeout = std_message_timeout},

-- JTRS ON
{time = 39.5,device = 7,action = 3009,value = 1.0,message = _("JTRS - ON"),message_timeout = std_message_timeout},

-- IFFCC ON
{time = 41.0,device = 7,action = 3010,value = 0.1,message = _("IFFCC - ON"),message_timeout = std_message_timeout},
{time = 41.3,device = 7,action = 3010,value = 0.2},

-- Left MFCD Day
{time = 42.0,device = 2,action = 3036,value = 0.1,message = _("LEFT MFCD - ON/DAY"),message_timeout = std_message_timeout},
{time = 42.2,device = 2,action = 3036,value = 0.2},

-- Right MFCD Day
{time = 43.0,device = 3,action = 3036,value = 0.1,message = _("RIGHT MFCD - ON/DAY"),message_timeout = std_message_timeout},
{time = 43.2,device = 3,action = 3036,value = 0.2},

-- Master Caution CANCEL
--{time = 43.5,device = 24,action = 3001,value = 1.0,message = _("MASTER CAUTION - PRESSED"),message_timeout = std_message_timeout},
--{time = 43.5,device = 24,action = 3001,value = 1.0},
--{time = 43.6,device = 24,action = 3001,value = 0.0},

-- Counter Measures System ON
{time = 44.0,message = _("SETTING UP COUNTER MEASURES SYSTEM..."),message_timeout = 3},
{time = 45.0,device = 4,action = 3018,value = 0.1,message = _("CMSP MODE - STBY"),message_timeout = std_message_timeout},  -- Selector to STBY
{time = 45.5,device = 4,action = 3010,value = 0.1,message = _("MWS - ON"),message_timeout = std_message_timeout},  -- MWS ON
{time = 46.0,device = 4,action = 3012,value = 0.1,message = _("JAMMER - ON"),message_timeout = std_message_timeout},  -- JMR ON
{time = 46.5,device = 4,action = 3014,value = 0.1,message = _("RWR - ON"),message_timeout = std_message_timeout},  -- RWR ON
{time = 47.0,device = 4,action = 3016,value = 0.1,message = _("CHAFF/FLARE DISPENSERS - ON"),message_timeout = std_message_timeout},  -- DISP ON
{time = 48.0,message = _("COUNTER MEASURES SYSTEM - READY / STBY"),message_timeout = std_message_timeout},

-- Left Engine start update
{time = 53.0,message = _("LEFT ENGINE - 40%"),message_timeout = std_message_timeout},

-- Left Engine start updates
{time = 63.0,message = _("LEFT ENGINE - 50%"),message_timeout = std_message_timeout},

-- Master Caution CANCEL
--{time = 64.0,device = 24,action = 3001,value = 1.0,message = _("MASTER CAUTION - PRESSED"),message_timeout = std_message_timeout},
{time = 64.0,device = 24,action = 3001,value = 1.0},
{time = 64.1,device = 24,action = 3001,value = 0.0},

-- Left Engine start update
{time = 72.0,message = _("LEFT ENGINE STABILIZING..."),message_timeout = std_message_timeout},

-- Left Engine start update
{time = 80.0,message = _("GOOD START ON LEFT ENGINE"),message_timeout = std_message_timeout},

-- INS Alignment Started
{time = 85.0,message = _("PREPARING FOR FAST INS ALIGNMENT SEQUENCE..."),message_timeout = 5},
{time = 88.0,device = 9,action = 3008,value = 1.0,message = _("CDU - SELECT INS PAGE"),message_timeout = std_message_timeout},  -- CDU to INS Page, LSK R4
{time = 88.5,device = 9,action = 3008,value = 0.0},
{time = 89.0,device = 9,action = 3002,value = 1.0,message = _("CDU - SELECT ALT ALIGN PAGE"),message_timeout = std_message_timeout}, -- CDU to ALT ALIGN Page, LSK L2
{time = 89.5,device = 9,action = 3002,value = 0.0},
{time = 90.0,device = 9,action = 3005,value = 1.0,message = _("CDU - SELECT FAST PAGE"),message_timeout = std_message_timeout},  -- CDU to FAST Page, LSK R1
{time = 90.5,device = 9,action = 3005,value = 0.0},
{time = 91.0,message = _("FAST INS ALIGNMENT - INITIATED"),message_timeout = 30},

-- Right Engine START
{time = 92.0,action = 312,message = _("RIGHT ENGINE - START"),message_timeout = std_message_timeout},
{time = 95.0,message = _("RIGHT ENGINE SPOOLING UP..."),message_timeout = 29.0},

-- Master Caution CANCEL
--{time = 94.0,device = 24,action = 3001,value = 1.0,message = _("MASTER CAUTION - PRESSED"),message_timeout = std_message_timeout},
{time = 96.0,device = 24,action = 3001,value = 1.0},
{time = 96.1,device = 24,action = 3001,value = 0.0},

-- Right Engine start update
{time = 118.0,message = _("RIGHT ENGINE - 40%"),message_timeout = std_message_timeout},

-- INS Progress updates
{time = 119.0,message = _("FAST ALIGNING INS - 1 MINUTE REMAINING..."),message_timeout = 30},

-- Right Engine start updates
{time = 128.0,message = _("RIGHT ENGINE - 50%"),message_timeout = std_message_timeout},
{time = 139.0,message = _("RIGHT ENGINE STABILIZING..."),message_timeout = std_message_timeout},

-- Right Engine start update
{time = 144.0,message = _("GOOD START ON RIGHT ENGINE"),message_timeout = std_message_timeout},

-- APU Generator OFF
{time = 145.0,device = 1,action = 3001,value = 0.0,message = _("APU GENERATOR - OFF"),message_timeout = std_message_timeout},

-- APU OFF
{time = 146.0,device = 37,action = 3005,value = 0.0,message = _("APU - OFF"),message_timeout = std_message_timeout},

-- INS progress update
{time = 148.0,message = _("FAST ALIGNING INS - 30 SECONDS REMAINING..."),message_timeout = 30},

-- YAW and PITCH SAS ON
{time = 149.0,device = 38,action = 3003,value = 1.0},  -- YAW SAS Left
{time = 149.5,device = 38,action = 3004,value = 0.0},
{time = 150.0,device = 38,action = 3005,value = 1.0},  -- YAW SAS Righ
{time = 150.5,device = 38,action = 3006,value = 0.0},
{time = 151.0,device = 38,action = 3007,value = 1.0},  -- PITCH SAS Left
{time = 151.5,device = 38,action = 3008,value = 0.0},
{time = 152.0,device = 38,action = 3009,value = 1.0},  -- PITCH SAS Right
{time = 152.5,device = 38,action = 3010,value = 0.0},
{time = 153.0,message = _("YAW and PITCH SAS - ON"),message_timeout = std_message_timeout},

-- T/O Trim SET
{time = 154.0,device = 38,action = 3012,value = 1.0,message = _("TAKEOFF TRIM - SET"),message_timeout = std_message_timeout},
{time = 154.5,device = 38,action = 3012,value = 0.0},

-- Anti-Collision ON
{time = 155.0,device = 49,action = 3010,value = 1.0,message = _("ANTI-COLLISION LIGHTS - ON"),message_timeout = std_message_timeout},
{time = 155.5,device = 49,action = 3011,value = 0.0},

-- Anti-Skid ON
{time = 157.0,device = 38,action = 3032,value = 1.0,message = _("ANTI-SKID - ON"),message_timeout = std_message_timeout},

-- Left MFCD select LOAD ALL
{time = 159.0,device = 2,action = 3010,value = 1.0,message = _("LEFT MFCD - LOAD ALL"),message_timeout = std_message_timeout},  -- Presses OSB 10
{time = 159.3,device = 2,action = 3010,value = 0.0},

-- INS progress update
{time = 168.0,message = _("FAST ALIGNING INS - 10 SECONDS REMAINING..."),message_timeout = 9},

-- INS Aligned
{time = 178.0,message = _("INERTIAL NAVIGATION SYSTEM - ALIGNED"),message_timeout = std_message_timeout},

-- RIGHT MFCD to CDU Page (OSB 13) 
{time = 180.0,device = 3,action = 3013,value = 1.0,message = _("RECALL CDU PAGE ON RIGHT MFCD"),message_timeout = std_message_timeout}, -- Presses OSB 13
{time = 180.1,device = 3,action = 3013,value = 0.0},

-- INS to NAV
{time = 181.0,device = 9,action = 3007,value = 1.0,message = _("CDU - INS to NAV"),message_timeout = std_message_timeout}, -- Presses OSB 9
{time = 181.3,device = 9,action = 3007,value = 0.0},

-- NMSP to EGI
{time = 182.0,device = 46,action = 3002,value = 1.0,message = _("NMSP - EGI MODE"),message_timeout = std_message_timeout},
{time = 182.2,device = 46,action = 3002,value = 0.0},

-- NMSP to TCN
{time = 183.0,device = 46,action = 3006,value = 1.0,message = _("NMSP - TCN MODE"),message_timeout = std_message_timeout},
{time = 183.2,device = 46,action = 3006,value = 0.0},

-- Radar Altimeter NORM
{time = 184.0,device = 67,action = 3001,value = 1.0,message = _("RADAR ALTIMETER - NORM"),message_timeout = std_message_timeout},

-- EAC System ON
{time = 185.0,device = 38,action = 3026,value = 1.0,message = _("EAC - ON"),message_timeout = std_message_timeout},
{time = 185.5,device = 38,action = 3027,value = 0.0},

-- CDU to WAYPOINT MENU Page
{time = 186.0,device = 9,action = 3011,value = 1.0,message = _("CDU - SELECT WP MENU PAGE"),message_timeout = std_message_timeout},
{time = 186.5,device = 9,action = 3011,value = 0.0},

-- CDU to STEERPOINT Page (Row select button 3L)
{time = 187.0,device = 9,action = 3001,value = 1.0,message = _("CDU - SELECT STEERPOINT PAGE"),message_timeout = std_message_timeout},
{time = 187.5,device = 9,action = 3001,value = 0.0},

-- AAP STEER POINT to FLT PLN
{time = 188.0,device = 22,action = 3001,value = 0.100000,message = _("AAP STEERPT SWITCH - SET FLT PLAN"),message_timeout = std_message_timeout},
{time = 188.5,device = 22,action = 3001,value = 0.0},

-- Left MFCD to TAD
{time = 189.0,device = 2,action = 3015,value = 1.0,message = _("LEFT MFCD - TAD PAGE"),message_timeout = std_message_timeout}, -- Presses OSB 15
{time = 189.5,device = 2,action = 3015,value = 0.0},

-- Flaps to MVR
{time = 191.0,device = 39,action = 3002,value  = 0.5,message = _("FLAPS - MVR (10°)"),message_timeout = std_message_timeout},

---Nosewheel Steering ON
{time = 192.0,device = 17, action = 3001,value  = 1.0,message = _("NOSEWHEEL STEERING - ON"),message_timeout = std_message_timeout},

-- TAXI LIGHT ON
{time = 193.0,device = 49,action = 3014,value = 0.0,message = _("TAXI LIGHT - ON"),message_timeout = std_message_timeout},
--LANDING LIGHTS ON (if preferred)
--{time = 351.0,device = 49,action = 3014,value = 1.0,message = _("LANDING LIGHTS - ON"),message_timeout = std_message_timeout},

-- SAI Uncaged
{time = 194.0,device = 48,action = 3003,value = -0.075000,message = _("SAI - UNCAGE"),message_timeout = std_message_timeout},
{time = 194.2,device = 48,action = 3003,value = -0.075000},
{time = 194.4,device = 48,action = 3003,value = -0.075000},
{time = 194.6,device = 48,action = 3003,value = 0.075000},
{time = 195.3,device = 48,action = 3003,value = -0.075000},

-- Pitot Heat ON
{time = 196.0,device = 41,action = 3005,value = 1.0,message = _("PITOT HEAT - ON"),message_timeout = std_message_timeout},

-- HMCS ON
{time = 196.5,device = 75,action = 3001,value = 1.0,message = _("SCORPION HMCS - ON"),message_timeout = std_message_timeout},

-- Ejection Seat Handle to ARMED 
{time = 197.0,device = 39,action = 3010,value = 0.0,message = _("EJECTION SEAT - ARMED"),message_timeout = std_message_timeout},

-- AUTO-START COMPLETE
{time = 198.0,message = _("ACCELERATED AUTO-START COMPLETE: AIRCRAFT READY TO TAXI"),message_timeout = std_message_timeout},
}

----------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------- AUTO-STOP PROCESS --------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------

-- AUTO-STOP SEQUENCE

stop_sequence_full =  {
{time = 3.6,message = _("AUTO-STOP SEQUENCE: STANDBY 40 SECONDS"),message_timeout = 38},

-- Pitot Heat OFF
{time = 3.8,device = devices.ENVIRONMENT_SYSTEM,action = 3005,value = 0.0,message = _("PITOT HEAT - OFF"),message_timeout = short_message_timeout},

-- YAW and PITCH SAS OFF
{time = 4.0,device = 38,action = 3003,value = 0.0}, -- YAW SAS LEFT
{time = 4.0,device = 38,action = 3004,value = 0.0},
--
{time = 4.5,device = 38,action = 3005,value = 0.0}, -- YAW SAS Right
{time = 4.5,device = 38,action = 3006,value = 0.0},
--
{time = 5.0,device = 38,action = 3007,value = 0.0}, -- PITCH SAS Left
{time = 5.0,device = 38,action = 3008,value = 0.0},
--
{time = 5.5,device = 38,action = 3009,value = 0.0,message = _("YAW and PITCH SAS  - OFF"),message_timeout = short_message_timeout},  -- PITCH SAS Right
{time = 5.5,device = 38,action = 3010,value = 0.0},

-- Master Caution CANCEL
--{time = 5.7,device = 24,action = 3001,value = 1.0,message = _("MASTER CAUTION - PRESSED"),message_timeout = short_message_timeout},
{time = 5.7,device = 24,action = 3001,value = 1.0},
{time = 5.8,device = 24,action = 3001,value = 0.0},

-- VHF and UHF Radios OFF
{time = 6.0,device = devices.VHF_AM_RADIO,action,action = 3003,value = 0.0},
{time = 6.4,device = devices.UHF_RADIO,action,action = 3008,value = 0.0,message = _("VHF and UHF RADIOS - OFF"),message_timeout = short_message_timeout},
{time = 6.8,device = devices.VHF_FM_RADIO,action,action = 3003,value = 0.0},

-- EAC System OFF
{time = 7.0,device = 38,action = 3026,value = 0.0,message = _("EAC - OFF"),message_timeout = short_message_timeout},
{time = 7.1,device = 38,action = 3027,value = 0.0},

-- Radar Altimeter OFF
{time = 7.2,device = 67,action = 3001,value = 1.0,message = _("RADAR ALTIMETER - OFF"),message_timeout = short_message_timeout},
{time = 7.4,device = 67,action = 3001,value = 0.0},

--- Master Caution CANCEL
--{time = 7.6,device = 24,action = 3001,value = 1.0,message = _("MASTER CAUTION - PRESSED"),message_timeout = short_message_timeout},
{time = 7.6,device = 24,action = 3001,value = 1.0},
{time = 7.7,device = 24,action = 3001,value = 0.0},

-- Flaps to FULL
{time = 7.8,device = 39,action = 3002,value  = 0.5},
{time = 7.9,device = 39,action = 3002,value  = 1.0,message = _("FLAPS - FULLY DOWN"),message_timeout = short_message_timeout},

-- Anti-Skid OFF
{time = 8.2,device = devices.AUTOPILOT,action = 3028,value = 1.0,message = _("ANTI-SKID - OFF"),message_timeout = short_message_timeout},

-- TAXI LIGHTS OFF
{time = 8.5,device = 49,action = 3014,value = 0.1,message = _("LANDING/TAXI LIGHTS - OFF"),message_timeout = short_message_timeout},

--- Master Caution CANCEL
--{time = 9.0,device = 24,action = 3001,value = 1.0,message = _("MASTER CAUTION - PRESSED"),message_timeout = short_message_timeout},
{time = 9.0,device = 24,action = 3001,value = 1.0},
{time = 9.1,device = 24,action = 3001,value = 0.0},

-- Left MFCD OFF
{time = 9.5,device = devices.MFCD_LEFT,action = 3036,value = 0.1,message = _("LEFT MFCD - OFF"),message_timeout = short_message_timeout},
{time = 9.8,device = devices.MFCD_LEFT,action = 3036,value = 0.0},

-- MASTER ARM OFF
{time = 10.0,device = devices.AHCP,action = 3001,value = 0.0,message = _("MASTER ARM - OFF"),message_timeout = short_message_timeout},

-- GUN/PAC OFF
{time = 10.8,device = devices.AHCP,action = 3002,value = 0.0,message = _("GUN/PAC - OFF"),message_timeout = short_message_timeout},

-- TGP OFF
{time = 11.6,device = devices.AHCP,action = 3004,value = 0.0,message = _("TGP - OFF"),message_timeout = short_message_timeout},

-- LASER ARM OFF
{time = 12.4,device = devices.AHCP,action = 3003,value = 0.0,message = _("LASER - OFF"),message_timeout = short_message_timeout},

-- Right MFCD OFF
{time = 13.0,device = devices.MFCD_RIGHT,action = 3036,value = 0.1,message = _("RIGHT MFCD - OFF"),message_timeout = short_message_timeout},
{time = 13.8,device = devices.MFCD_RIGHT,action = 3036,value = 0.0},

-- IFFCC OFF
{time = 15.0,device = devices.AHCP,action = 3010,value = 0.0,message = _("IFFCC - OFF"),message_timeout = short_message_timeout},

-- Master Caution CANCEL
--{time = 15.3,device = 24,action = 3001,value = 1.0,message = _("MASTER CAUTION - PRESSED"),message_timeout = short_message_timeout},
{time = 15.3,device = 24,action = 3001,value = 1.0},
{time = 15.4,device = 24,action = 3001,value = 0.0},

-- JTRS OFF
{time = 16.0,device = devices.AHCP,action = 3009,value = 0.0,message = _("JTRS - OFF"),message_timeout = short_message_timeout},

-- CICU OFF
{time = 17.0,device = devices.AHCP,action = 3008,value = 0.0,message = _("CICU - OFF"),message_timeout = short_message_timeout},

-- Master Caution CANCEL
--{time = 17.3,device = 24,action = 3001,value = 1.0,message = _("MASTER CAUTION - PRESSED"),message_timeout = short_message_timeout},
{time = 17.3,device = 24,action = 3001,value = 1.0},
{time = 17.4,device = 24,action = 3001,value = 0.0},

-- Counter Measures System OFF
{time = 18.0,device = 4,action = 3010,value = 0.0},  -- MWS OFF
{time = 18.5,device = 4,action = 3012,value = 0.0},  -- JAMMER OFF
{time = 19.0,device = 4,action = 3014,value = 0.0},  -- RWR OFF
{time = 19.5,device = 4,action = 3016,value = 0.0},  -- DISPENSERS OFF
{time = 20.0,device = 4,action = 3018,value = 0.1,message = _("COUNTER MEASURES SYSTEM - OFF"),message_timeout = short_message_timeout},  -- CMS OFF
{time = 20.1,device = 4,action = 3018,value = 0.0},

-- NMSP TCN OFF
{time = 21.0,device = 46,action = 3006,value = 1.0,message = _("NMSP TCN - OFF"),message_timeout = short_message_timeout},

-- CDU OFF
{time = 22.8,device = devices.AAP,	action = 3005,value = 0.0,	message = _("CDU - OFF"),message_timeout = short_message_timeout},

-- TACAN OFF
{time = 23.0,device = devices.TACAN_CTRL_PANEL,action = 3006,value = 0.0,message = _("TACAN - OFF"),message_timeout = short_message_timeout},

-- ILS OFF
{time = 24.0,device = 53,action = 3001,value = 0.0,message = _("ILS - OFF"),message_timeout = short_message_timeout},  -- ILS ON is value=1.0

-- HMCS OFF
{time = 24.5,device = 75,action = 3001,value = 0.0,message = _("SCORPION HMCS - OFF"),message_timeout = std_message_timeout},

-- COCKPIT LIGHTING
{time = 25.0,device = 49,action = 3006,value = 0.0},  -- Console Light
{time = 25.2,device = 49,action = 3002,value = 0.0},  -- Flight Instrument Lights
{time = 25.4,device = 49,action = 3003,value = 0.0},  -- Auxilliary Instrument Lights
{time = 25.6,device = 49,action = 3004,value = 0.0},  -- Accelerometer & Compass Lights
{time = 25.8,device = 49,action = 3001,value = 0.0},  -- Engine Instrument Lights
{time = 26.0,device = 49,action = 3005,value = 0.0,message = _("COCKPIT LIGHTING - OFF"),message_timeout = short_message_timeout},  -- Flood Light

-- Both Engines STOP
{time = 28.0,action = 313,value  = 0.0,	message = _("LEFT ENGINE - STOP"),	message_timeout = short_message_timeout},
{time = 28.1,action = 314,value  = 0.0,	message = _("RIGHT ENGINE - STOP"),	message_timeout = short_message_timeout},

-- Master Caution CANCEL
--{time = 28.3,device = 24,action = 3001,value = 1.0,message = _("MASTER CAUTION - PRESSED"),message_timeout = short_message_timeout},
{time = 28.3,device = 24,action = 3001,value = 1.0},
{time = 28.4,device = 24,action = 3001,value = 0.0},

-- Boost Pumps OFF
{time = 29.0,device = 36,action = 3007,value = 0.0},
{time = 29.3,device = 36,action = 3005,value = 0.0},
{time = 29.6,device = 36,action = 3008,value = 0.0},
{time = 29.9,device = 36,action = 3006,value = 0.0,message = _("BOOST PUMPS - OFF"),message_timeout = short_message_timeout},

-- Canopy OPEN
{time = 31.0,action = 71,value  = 0.0,message = _("CANOPY - OPEN"),message_timeout = short_message_timeout},

-- Oxygen OFF
{time = 32.0,device = 40,action = 3001,value = 0.0,message = _("OXYGEN - OFF"),message_timeout = short_message_timeout},

-- Both Generators OFF
{time = 33.0,device = devices.ELEC_INTERFACE,action = 3004,value = 0.0},
{time = 33.5,device = devices.ELEC_INTERFACE,action = 3005,value = 0.0,message = _("AC GENERATORS - OFF"),message_timeout = short_message_timeout},

-- Inverter OFF
{time = 34.5,device = devices.ELEC_INTERFACE,action = 3002,value = 0.0,message = _("INVERTER - OFF"),message_timeout = short_message_timeout},

-- Master Caution CANCEL
--{time = 34.8,device = 24,action = 3001,value = 1.0,message = _("MASTER CAUTION - PRESSED"),message_timeout = short_message_timeout},
{time = 34.8,device = 24,action = 3001,value = 1.0},
{time = 34.9,device = 24,action = 3001,value = 0.0},

-- Battery OFF
{time = 36.0,device = devices.ELEC_INTERFACE,action = 3006,value = 0.0,message = _("BATTERY - OFF"),message_timeout = short_message_timeout},

-- Ejection Seat Handle to SAFE 
{time = 37.0,device = 39,action = 3010,value = 1.0,message = _("EJECTION SEAT - SAFE"),message_timeout = short_message_timeout},

-- Spacer
{time = 38.0,message = _(" "),message_timeout = short_message_timeout},

-- AUTO-STOP SEQUENCE COMPLETED
{time = 39.0,message = _("AUTO-STOP COMPLETE"),message_timeout = std_message_timeout},

}

----------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------- END ---------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
