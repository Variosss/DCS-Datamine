dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."devices.lua")

std_message_timeout = 15

----------------------------------------------------------------------------------------------------
-----------------------------------------------CONFIG-----------------------------------------------
----------------------------------------------------------------------------------------------------
--TIMING
local dt = 0.2 -- Default interval between commands in the stack.
local dt_mto = 10.0 -- Default message timeout time.

--MISCELLANEOUS
--RADAR ALT
local RAsteps       = 20    -- Change this value to set RA bug.  5 = 50 ft, 20 = 250 ft, experiment as needed; scale is non-linear, so same degrees of rotation gives more altitude as it goes around.
--BINGO
local BingoAmount   = 4000  --Bingo amount, pounds of fuel
--TACAN
local TACANTens     = 5
local TACANOnes     = 9
local TACANXY       = "X"   --MUST BE CAPITAL FOR PROPER FUNCTION
--ILS
local ILSTens       = 0
local ILSOnes       = 8

--LIGHTING
--INTERNAL
local CnslLights    = 100   --desired % brightness
local PnlLights     = 100   --desired % brightness
local FloodLights   = 0     --desired % brightness
--EXTERNAL
local PosLights     = 0     --desired % brightness
local FormLights    = 25    --desired % brightness
local StrobeLight   = 0     --0 = OFF, 1 = ON (probably)
local TaxiLight     = 1     --0 = OFF, 1 = ON
--HMD
local HMDBrt        = 100   -- Desired % Brightness
local HMDRng        = 80    -- Desired Range for Datalink Contacts to be displayed on HMD (5nm increments)

--RADAR/Weapon Config
--AIM-9
local AIM9Az        = 40    --azimuth, degrees
local AIM9Bar       = 6     --bars
local AIM9Rng       = 20    --range, nm
local AIM9Time      = 16    --contact/brick timeout
local AIM9PRF       = "MED" --ILV, MED, HI
--AIM-7
local AIM7Az        = 80    --azimuth, degrees
local AIM7Bar       = 4     --bars
local AIM7Rng       = 80    --range, nm
local AIM7Time      = 16    --contact/brick timeout
local AIM7PRF       = "ILV" --ILV, MED, HI
--AIM-120
local AIM120Az      = 140
local AIM120Bar     = 2
local AIM120Rng     = 80
local AIM120Time    = 16
local AIM120PRF     = "HI"
----------------------------------------------------------------------------------------------------
-------HERE BE DRAGONS, DO NOT TOUCH (aka some guts that make config and readouts easier)-----------
----------------------------------------------------------------------------------------------------
local t_start = 0.0
local t_stop = 0.0
local ins_align_time = 1 * 60 + 55 -- Stored heading alignment is 1m50s, add 5 seconds of slop just in case.
local start_sequence_time = 3 * 60 + 25 -- Quick startup takes about 3m25s, including INS alignment (NEEDS UPDATING FOR ADDITIONS)
local stop_sequence_time = 10.0 -- TODO: timeout

local apu_start_time = 15
local engine_start_time = 40
local canopy_close_time = 8
-- APU startup = 15s
-- Align with stored heading = 1m50s
-- Close canopy = 8s
-- Right engine = 7s from crank switch to 15%, 40s to lit, 50s to warning beeps
local UFCNum    = {[0]=UFC_commands.KbdSw0, UFC_commands.KbdSw1, UFC_commands.KbdSw2, UFC_commands.KbdSw3, UFC_commands.KbdSw4,
                UFC_commands.KbdSw5, UFC_commands.KbdSw6, UFC_commands.KbdSw7, UFC_commands.KbdSw8,
                UFC_commands.KbdSw9}
local UFCOptn   = {UFC_commands.OptSw1, UFC_commands.OptSw2, UFC_commands.OptSw3, UFC_commands.OptSw4,
                UFC_commands.OptSw5}
if TACANXY == "X"
    then TACANXYConverted = UFC_commands.OptSw4 
    else TACANXYConverted = UFC_commands.OptSw5
end
local DDIOSB    = {MDI_commands.MDI_PB_1, MDI_commands.MDI_PB_2, MDI_commands.MDI_PB_3, MDI_commands.MDI_PB_4,
                MDI_commands.MDI_PB_5, MDI_commands.MDI_PB_6, MDI_commands.MDI_PB_7, MDI_commands.MDI_PB_8,
                MDI_commands.MDI_PB_9, MDI_commands.MDI_PB_10, MDI_commands.MDI_PB_11, MDI_commands.MDI_PB_12,
                MDI_commands.MDI_PB_13, MDI_commands.MDI_PB_14, MDI_commands.MDI_PB_15, MDI_commands.MDI_PB_16,
                MDI_commands.MDI_PB_17, MDI_commands.MDI_PB_18, MDI_commands.MDI_PB_19, MDI_commands.MDI_PB_20}
local AMPCDOSB  = {AMPCD_commands.AMPCD_PB_1, AMPCD_commands.AMPCD_PB_2, AMPCD_commands.AMPCD_PB_3, AMPCD_commands.AMPCD_PB_4,
                AMPCD_commands.AMPCD_PB_5, AMPCD_commands.AMPCD_PB_6, AMPCD_commands.AMPCD_PB_7, AMPCD_commands.AMPCD_PB_8,
                AMPCD_commands.AMPCD_PB_9, AMPCD_commands.AMPCD_PB_10, AMPCD_commands.AMPCD_PB_11, AMPCD_commands.AMPCD_PB_12,
                AMPCD_commands.AMPCD_PB_13, AMPCD_commands.AMPCD_PB_14, AMPCD_commands.AMPCD_PB_15, AMPCD_commands.AMPCD_PB_16,
                AMPCD_commands.AMPCD_PB_17, AMPCD_commands.AMPCD_PB_18, AMPCD_commands.AMPCD_PB_19, AMPCD_commands.AMPCD_PB_20}
local HMDDelta = (HMDRng-35)/5 --gives number of button presses required to adjust HMD settings
--
start_sequence_full = {}
stop_sequence_full = {}
cockpit_illumination_full = {}
    
function push_command(sequence, run_t, command)
    sequence[#sequence + 1] = command
    sequence[#sequence]["time"] = run_t
end

function push_start_command(delta_t, command)
    t_start = t_start + delta_t
    push_command(start_sequence_full, t_start, command)
end

function push_stop_command(delta_t, command)
    t_stop = t_stop + delta_t
    push_command(stop_sequence_full, t_stop, command)
end

--
local count = 0
local function counter()
    count = count + 1
    return count
end

-- conditions
count = -1

F18_AD_NO_FAILURE = counter()
F18_AD_ERROR = counter()

F18_AD_WING_FOLD_HANDLE_SET_SAME_AS_POS = counter()

F18_AD_LEFT_THROTTLE_SET_TO_OFF = counter()
F18_AD_RIGHT_THROTTLE_SET_TO_OFF = counter()
F18_AD_LEFT_THROTTLE_AT_OFF = counter()
F18_AD_RIGHT_THROTTLE_AT_OFF = counter()
F18_AD_LEFT_THROTTLE_SET_TO_IDLE = counter()
F18_AD_RIGHT_THROTTLE_SET_TO_IDLE = counter()
F18_AD_LEFT_THROTTLE_AT_IDLE = counter()
F18_AD_RIGHT_THROTTLE_AT_IDLE = counter()
F18_AD_LEFT_THROTTLE_DOWN_TO_IDLE = counter()
F18_AD_RIGHT_THROTTLE_DOWN_TO_IDLE = counter()

F18_AD_APU_READY = counter()
F18_AD_LEFT_ENG_IDLE_RPM = counter()
F18_AD_RIGHT_ENG_IDLE_RPM = counter()
F18_AD_LEFT_ENG_CHECK_IDLE = counter()
F18_AD_RIGHT_ENG_CHECK_IDLE = counter()
F18_AD_ENG_CRANK_SW_CHECK_OFF = counter()
F18_AD_APU_VERIFY_OFF = counter()

F18_AD_INS_ALIGN = counter()
F18_AD_INS_STOR_HDG = counter()
F18_AD_INS_CHECK_RDY = counter()

F18_AD_HMD_BRT_KNOB = counter()
F18_AD_HMD_ALIGN = counter()

--
alert_messages = {}

alert_messages[F18_AD_ERROR] = { message = _("FM MODEL ERROR"), message_timeout = std_message_timeout}

alert_messages[F18_AD_WING_FOLD_HANDLE_SET_SAME_AS_POS] = { message = _("WING_FOLD_HANDLE - SET SAME AS WING POSITION"), message_timeout = std_message_timeout}

alert_messages[F18_AD_LEFT_THROTTLE_SET_TO_OFF] = { message = _("LEFT THROTTLE - TO OFF"), message_timeout = std_message_timeout}
alert_messages[F18_AD_RIGHT_THROTTLE_SET_TO_OFF] = { message = _("RIGHT THROTTLE - TO OFF"), message_timeout = std_message_timeout}
alert_messages[F18_AD_LEFT_THROTTLE_AT_OFF] = { message = _("LEFT THROTTLE MUST BE AT STOP"), message_timeout = std_message_timeout}
alert_messages[F18_AD_RIGHT_THROTTLE_AT_OFF] = { message = _("RIGHT THROTTLE MUST BE AT STOP"), message_timeout = std_message_timeout}
alert_messages[F18_AD_LEFT_THROTTLE_SET_TO_IDLE] = { message = _("LEFT THROTTLE - TO IDLE"), message_timeout = std_message_timeout}
alert_messages[F18_AD_RIGHT_THROTTLE_SET_TO_IDLE] = { message = _("RIGHT THROTTLE - TO IDLE"), message_timeout = std_message_timeout}
alert_messages[F18_AD_LEFT_THROTTLE_AT_IDLE] = { message = _("LEFT THROTTLE MUST BE AT IDLE"), message_timeout = std_message_timeout}
alert_messages[F18_AD_RIGHT_THROTTLE_AT_IDLE] = { message = _("RIGHT THROTTLE MUST BE AT IDLE"), message_timeout = std_message_timeout}
alert_messages[F18_AD_LEFT_THROTTLE_DOWN_TO_IDLE] = { message = _("LEFT THROTTLE - TO IDLE"), message_timeout = std_message_timeout}
alert_messages[F18_AD_RIGHT_THROTTLE_DOWN_TO_IDLE] = { message = _("RIGHT THROTTLE - TO IDLE"), message_timeout = std_message_timeout}

alert_messages[F18_AD_APU_READY] = { message = _("READY LIGHT MUST BE ON WITHIN 30 SEC"), message_timeout = std_message_timeout}
alert_messages[F18_AD_LEFT_ENG_IDLE_RPM] = { message = _("LEFT ENGINE RPM FAILURE"), message_timeout = std_message_timeout}
alert_messages[F18_AD_RIGHT_ENG_IDLE_RPM] = { message = _("RIGHT ENGINE RPM FAILURE"), message_timeout = std_message_timeout}
alert_messages[F18_AD_LEFT_ENG_CHECK_IDLE] = { message = _("LEFT ENGINE PARAMETERS FAILURE"), message_timeout = std_message_timeout}
alert_messages[F18_AD_RIGHT_ENG_CHECK_IDLE] = { message = _("RIGHT ENGINE PARAMETERS FAILURE"), message_timeout = std_message_timeout}
alert_messages[F18_AD_ENG_CRANK_SW_CHECK_OFF] = { message = _("ENG CRANK SWITCH MUST BE IN OFF POSITION"), message_timeout = std_message_timeout}
alert_messages[F18_AD_APU_VERIFY_OFF] = { message = _("APU MUST BE OFF"), message_timeout = std_message_timeout}

alert_messages[F18_AD_INS_ALIGN] = { message = _("INS ERROR"), message_timeout = std_message_timeout}
alert_messages[F18_AD_INS_STOR_HDG] = { message = _("INS STOR HDG ALIGN UNAVAILABLE"), message_timeout = std_message_timeout}
alert_messages[F18_AD_INS_CHECK_RDY] = { message = _("INS ALIGNMENT ERROR"), message_timeout = std_message_timeout}


----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
-- Start sequence
push_start_command(0, {message = _("HAVOC'S QUICKSTART (Biscuit Edition) IS RUNNING (3m25s)"), message_timeout = start_sequence_time})
--
-- Engine Start
push_start_command(dt, {message = _("BATT SWITCH - ON"), message_timeout = dt_mto})
push_start_command(dt, {device = devices.ELEC_INTERFACE, action = elec_commands.BattSw, value = 1.0})
push_start_command(dt, {message = _("APU START (15s)"), message_timeout = apu_start_time})
push_start_command(dt, {message = _("APU SWITCH - ON"), message_timeout = dt_mto})
push_start_command(dt, {device = devices.ENGINES_INTERFACE, action = engines_commands.APU_ControlSw, value = 1.0})
push_start_command(dt, {device = devices.ENGINES_INTERFACE, action = engines_commands.APU_ControlSw, value = 0.0})
push_start_command(dt, {message = _("CANOPY - CLOSE"), message_timeout = canopy_close_time})
push_start_command(dt, {device = devices.CPT_MECHANICS, action = cpt_commands.CanopySwitchClose, value = -1.0})
push_start_command(8.0, {device = devices.CPT_MECHANICS, action = cpt_commands.CanopySwitchClose, value = 0.0}) -- Turn off canopy switch 8 seconds later.
push_start_command(8.0, {message = _("READY LIGHT - CHECK"), check_condition = F18_AD_APU_READY})

push_start_command(dt, {message = _("LEFT DDI - ON"), message_timeout = dt_mto})
push_start_command(dt, {device = devices.MDI_LEFT, action = MDI_commands.MDI_off_night_day, value = 0.2})
push_start_command(dt, {message = _("RIGHT DDI - ON"), message_timeout = dt_mto})
push_start_command(dt, {device = devices.MDI_RIGHT, action = MDI_commands.MDI_off_night_day, value = 0.2})
push_start_command(dt, {message = _("HUD DDI - ON"), message_timeout = dt_mto})
push_start_command(dt, {device = devices.HUD, action = HUD_commands.HUD_SymbBrightCtrl, value = 1.0})
push_start_command(dt, {message = _("AMPCD - ON"), message_timeout = dt_mto})
push_start_command(dt, {device = devices.AMPCD, action = AMPCD_commands.AMPCD_off_brightness, value = 1.0})
push_start_command(dt, {message = _("UFC BRIGHTNESS - MAX"), message_timeout = dt_mto})
push_start_command(dt, {device = devices.UFC, action = UFC_commands.BrtDim, value = 1.0})

push_start_command(dt, {message = _("COMM 1 AND 2 KNOBS - ON"), message_timeout = dt_mto})
push_start_command(dt, {device = devices.UFC, action = UFC_commands.Comm1Vol, value = 0.8})
push_start_command(dt, {device = devices.UFC, action = UFC_commands.Comm2Vol, value = 0.8})

-- RIGHT ENGINE
push_start_command(dt, {message = _("RIGHT ENGINE - START (40s)"), message_timeout = engine_start_time})
push_start_command(dt, {message = _("ENG CRANK SWITCH - R"), message_timeout = dt_mto})
push_start_command(dt, {check_condition = F18_AD_RIGHT_THROTTLE_AT_OFF})
push_start_command(dt, {device = devices.ENGINES_INTERFACE, action = engines_commands.EngineCrankRSw, value = 1.0})
push_start_command(dt, {device = devices.ENGINES_INTERFACE, action = engines_commands.EngineCrankRSw, value = 0.0})
push_start_command(dt, {message = _("RIGHT THROTTLE - IDLE (15% RPM MINIMUM)"), message_timeout = 10.0})
for i = 0, 50, 1 do
    push_start_command(0.2, {check_condition = F18_AD_RIGHT_THROTTLE_SET_TO_IDLE})
end
push_start_command(40.0, {check_condition = F18_AD_RIGHT_ENG_IDLE_RPM})
-- END RIGHT ENGINE

push_start_command(dt, {message = _("HMD SWITCH - ON"), message_timeout = dt_mto})
push_start_command(0.5, {check_condition = F18_AD_HMD_BRT_KNOB}) 
push_start_command(dt, {message = _("IFEI - CHECK"), message_timeout = dt_mto})
push_start_command(dt, {check_condition = F18_AD_RIGHT_ENG_CHECK_IDLE})
push_start_command(dt, {message = _("BLEED AIR KNOB - CYCLE THRU OFF TO NORM"), message_timeout = dt_mto})
push_start_command(dt, {device = devices.ECS_INTERFACE, action = ECS_commands.BleedAirSw, value = 0.3})
push_start_command(dt, {device = devices.ECS_INTERFACE, action = ECS_commands.BleedAirSw, value = 0.0})
push_start_command(dt, {device = devices.ECS_INTERFACE, action = ECS_commands.BleedAirSw, value = 0.1})
push_start_command(dt, {device = devices.ECS_INTERFACE, action = ECS_commands.BleedAirSw, value = 0.2})

push_start_command(dt, {message = _("RADAR ALTIMETER - ON, SET TO 250 FT"), message_timeout = dt_mto})
-- First turn it all the way off, then back on to 50 ft.
for i = 0, 61, 1 do -- Note 0-index.  60 total steps to go from 5000 ft to 0 ft, 62 steps to turn off completely.
    push_start_command(0.01, {device = devices.ID2163A, action = id2163a_commands.ID2163A_SetMinAlt, value = -0.05}) -- value = positive number to go up, negative number to go down.  Actual number doesn't seem to make a difference, only +/-??
end
for i = 0, RAsteps, 1 do --alt set by RASteps in config
    push_start_command(0.01, {device = devices.ID2163A, action = id2163a_commands.ID2163A_SetMinAlt, value = 0.05}) -- value = positive number to go up, negative number to go down.  Actual number doesn't seem to make a difference, only +/-.
end

push_start_command(dt, {message = _("RADAR KNOB - OPR"), message_timeout = dt_mto})
push_start_command(dt, {device = devices.RADAR, action = RADAR_commands.RADAR_SwitchChange, value = 0.2})
push_start_command(dt, {message = _("FCS RESET BUTTON - PUSH"), message_timeout = dt_mto})
push_start_command(dt, {device = devices.CONTROL_INTERFACE, action = ctrl_commands.ResetSw, value = 1.0})
push_start_command(dt, {device = devices.CONTROL_INTERFACE, action = ctrl_commands.ResetSw, value = 0.0})
push_start_command(dt, {message = _("FLAP SWITCH - HALF"), message_timeout = dt_mto})
push_start_command(dt, {device = devices.CONTROL_INTERFACE, action = ctrl_commands.FlapSw, value = 0.0})
push_start_command(dt, {message = _("T/O TRIM BUTTON - PRESS UNTIL TRIM ADVISORY DISPLAYED"), message_timeout = dt_mto})
push_start_command(dt, {device = devices.CONTROL_INTERFACE, action = ctrl_commands.TOTrimSw, value = 1.0})
-- TODO: check condition
push_start_command(dt, {device = devices.CONTROL_INTERFACE, action = ctrl_commands.TOTrimSw, value = 0.0})
push_start_command(dt, {message = _("STANDBY ATTITUDE REFERENCE INDICATOR - UNCAGE"), message_timeout = dt_mto})
push_start_command(dt, {device = devices.SAI, action = sai_commands.SAI_rotate, value = -0.01})
push_start_command(dt, {message = _("ATT SWITCH - STBY"), message_timeout = dt_mto})
push_start_command(dt, {device = devices.HUD, action = HUD_commands.HUD_AttitudeSelSw, value = -1.0})
push_start_command(dt, {message = _("ATT SWITCH - AUTO"), message_timeout = dt_mto})
push_start_command(dt, {device = devices.HUD, action = HUD_commands.HUD_AttitudeSelSw, value = 0.0})
push_start_command(dt, {message = _("OBOGS CONTROL SWITCH - ON"), message_timeout = dt_mto})
push_start_command(dt, {device = devices.OXYGEN_INTERFACE, action = oxygen_commands.OBOGS_ControlSw, value = 1.0})
push_start_command(dt, {message = _("HMD - AUTOSTART ALIGN"), message_timeout = dt_mto})
push_start_command(1.0, {check_condition = F18_AD_HMD_ALIGN})

-- BEGIN INS START ALIGN
local ins_timer = t_start -- Start a timer for the INS at the current t_start value.
push_start_command(dt, {message = _("INS KNOB - ALIGN"), message_timeout = dt_mto})
push_start_command(dt, {check_condition = F18_AD_INS_ALIGN})
push_start_command(dt, {message = _("INS - SELECT STOR HDG ALIGN"), message_timeout = dt_mto})
-- try set STOR HDG
for i = 0, 10, 1 do
    push_start_command(0.3, {check_condition = F18_AD_INS_STOR_HDG})
end
push_start_command(dt, {message = _("WAITING FOR INS ALIGN ("..ins_align_time.."s)"), message_timeout = ins_align_time})
-- END INS START ALIGN

push_start_command(dt, {message = _("HUD ALT SWITCH - RDR"), message_timeout = dt_mto})
push_start_command(dt, {device = devices.HUD, action = HUD_commands.HUD_AltitudeSw, value = -1.0})
push_start_command(dt, {message = _("IR COOL SWITCH - NORM"), message_timeout = dt_mto})
push_start_command(dt, {device = devices.SMS, action = SMS_commands.IRCoolingSw, value = 0.1})
push_start_command(dt, {message = _("HMD BRT - "..HMDBrt.."%"), message_timeout = dt_mto})
push_start_command(dt, {device = devices.HMD_INTERFACE, action = hmd_commands.BrtKnob, value = HMDBrt*.75})--HMD max axis value is 0.75, % value set in config
push_start_command(dt, {message = _("DISPENSER SWITCH - ON"), message_timeout = dt_mto})
push_start_command(dt, {device = devices.CMDS, action = cmds_commands.Dispenser, value = 0.1})
push_start_command(dt, {message = _("ECM - REC"), message_timeout = dt_mto})
push_start_command(dt, {device = devices.ASPJ, action = ASPJ_commands.ASPJ_SwitchChange, value = 0.3})
push_start_command(dt, {message = _("RWR POWER - ON"), message_timeout = dt_mto})
push_start_command(dt, {device = devices.RWR, action = rwr_commands.Power, value = 1.0})

--LIGHTS
push_start_command(dt, {device = devices.EXT_LIGHTS,	action = extlights_commands.Position, value = PosLights/.85,    message = _("POSITION LIGHTS - "..PosLights.."%"), message_timeout = dt_mto})
push_start_command(dt, {device = devices.EXT_LIGHTS,	action = extlights_commands.Formation,value = FormLights/.85,   message = _("FORMATION LIGHTS - "..FormLights.."%"), message_timeout = dt_mto})
push_start_command(dt, {device = devices.EXT_LIGHTS,	action = extlights_commands.Strobe,   value = StrobeLight})
push_start_command(dt, {device = devices.EXT_LIGHTS,	action = extlights_commands.LdgTaxi,  value = TaxiLight})
push_start_command(dt, {device = devices.CPT_LIGHTS,	action = cptlights_commands.Consoles, value = CnslLights/.85,   message = _("CONSOLE LIGHTS - "..CnslLights.."%"), message_timeout = dt_mto})
push_start_command(dt, {device = devices.CPT_LIGHTS,	action = cptlights_commands.InstPnl,  value = PnlLights/.85,    message = _("INSTRUMENT PANEL LIGHTS - "..PnlLights.."%"), message_timeout = dt_mto})
-- LEFT ENGINE
push_start_command(dt, {message = _("LEFT ENGINE START ("..engine_start_time.."s)"), message_timeout = engine_start_time})
push_start_command(dt, {message = _("ENG CRANK SWITCH - L"), message_timeout = dt_mto})
push_start_command(dt, {check_condition = F18_AD_LEFT_THROTTLE_AT_OFF})
push_start_command(dt, {device = devices.ENGINES_INTERFACE, action = engines_commands.EngineCrankLSw, value = -1.0})
push_start_command(dt, {device = devices.ENGINES_INTERFACE, action = engines_commands.EngineCrankLSw, value = 0.0})
push_start_command(dt, {message = _("LEFT THROTTLE - IDLE (15% RPM MINIMUM)"), message_timeout = 10.0})
for i = 0, 50, 1 do
    push_start_command(0.2, {check_condition = F18_AD_LEFT_THROTTLE_SET_TO_IDLE})
end
push_start_command(40.0, {check_condition = F18_AD_LEFT_ENG_IDLE_RPM})
push_start_command(dt, {message = _("ENG CRANK SWITCH - CHECK OFF"), message_timeout = dt_mto})
push_start_command(dt, {check_condition = F18_AD_ENG_CRANK_SW_CHECK_OFF})
push_start_command(dt, {message = _("IFEI - CHECK"), message_timeout = dt_mto})
push_start_command(dt, {check_condition = F18_AD_LEFT_ENG_CHECK_IDLE})
-- END LEFT ENGINE
-- SET BINGO
push_start_command(dt, {message = _("BINGO WARNING - SET TO "..BingoAmount.."LBS"), message_timeout = dt_mto})
for i = 0, BingoAmount/100, 1 do
    push_start_command(0.05, {device = devices.IFEI,    action = IFEI_commands.IFEI_BTN_UP_ARROW, value = 1.0})
    push_start_command(0.05, {device = devices.IFEI,    action = IFEI_commands.IFEI_BTN_UP_ARROW, value = 0.0})
end
-- BIT STOP
push_start_command(dt, {message = _("BIT FORMAT - STOP OSB"), message_timeout = dt_mto})
push_start_command(dt, {device = devices.MDI_RIGHT, action = MDI_commands.MDI_PB_10, value = 1.0}) -- BIT page STOP OSB
push_start_command(dt, {device = devices.MDI_RIGHT, action = MDI_commands.MDI_PB_10, value = 0.0}) -- release

-- Dispenser mode MAN 1 and RWR to HUD
push_start_command(dt, {message = _("BIT FORMAT - STOP OSB"), message_timeout = dt_mto})
push_start_command(dt, {device = devices.MDI_RIGHT, action = MDI_commands.MDI_PB_18, value = 1.0}) -- MENU OSB
push_start_command(dt, {device = devices.MDI_RIGHT, action = MDI_commands.MDI_PB_18, value = 0.0}) -- release
push_start_command(dt, {device = devices.MDI_RIGHT, action = MDI_commands.MDI_PB_17, value = 1.0}) -- EW OSB
push_start_command(dt, {device = devices.MDI_RIGHT, action = MDI_commands.MDI_PB_17, value = 0.0}) -- release
push_start_command(dt, {device = devices.MDI_RIGHT, action = MDI_commands.MDI_PB_8,  value = 1.0}) -- ALE-47 OSB
push_start_command(dt, {device = devices.MDI_RIGHT, action = MDI_commands.MDI_PB_8,  value = 0.0}) -- release
push_start_command(dt, {device = devices.MDI_RIGHT, action = MDI_commands.MDI_PB_19, value = 1.0}) -- MODE OSB
push_start_command(dt, {device = devices.MDI_RIGHT, action = MDI_commands.MDI_PB_19, value = 0.0}) -- release
push_start_command(dt, {device = devices.MDI_RIGHT, action = MDI_commands.MDI_PB_14, value = 1.0}) -- HUD OSB
push_start_command(dt, {device = devices.MDI_RIGHT, action = MDI_commands.MDI_PB_14, value = 0.0}) -- released
--HMD Range Increase
push_start_command(dt, {device = devices.MDI_RIGHT, action = MDI_commands.MDI_PB_18, value = 1.0}) -- MENU OSB (SUPT)
push_start_command(dt, {device = devices.MDI_RIGHT, action = MDI_commands.MDI_PB_18, value = 0.0}) -- release
push_start_command(dt, {device = devices.MDI_RIGHT, action = MDI_commands.MDI_PB_18, value = 1.0}) -- MENU OSB (TAC)
push_start_command(dt, {device = devices.MDI_RIGHT, action = MDI_commands.MDI_PB_18, value = 0.0}) -- release
push_start_command(dt, {device = devices.MDI_RIGHT, action = MDI_commands.MDI_PB_3,  value = 1.0}) -- HMD
push_start_command(dt, {device = devices.MDI_RIGHT, action = MDI_commands.MDI_PB_3,  value = 0.0}) -- release
push_start_command(dt, {device = devices.MDI_RIGHT, action = MDI_commands.MDI_PB_17, value = 1.0}) -- MIDS SETUP OSB
push_start_command(dt, {device = devices.MDI_RIGHT, action = MDI_commands.MDI_PB_17, value = 0.0}) -- release
if HMDDelta >= 0
    then for i = 1, HMDDelta, 1 do
            push_start_command(dt, {device = devices.MDI_RIGHT, action = MDI_commands.MDI_PB_14, value = 1.0}) -- press MIDS range up
            push_start_command(dt, {device = devices.MDI_RIGHT, action = MDI_commands.MDI_PB_14, value = 0.0}) -- release
        end
    else for i = -1, HMDDelta, -1 do
            push_start_command(dt, {device = devices.MDI_RIGHT, action = MDI_commands.MDI_PB_15, value = 1.0}) -- press MIDS range down
            push_start_command(dt, {device = devices.MDI_RIGHT, action = MDI_commands.MDI_PB_15, value = 0.0}) -- release
        end
end

--RADAR CONFIGURATION
local RWSRangePattern	= { [5] = 1, [10] = 2, [20] = 3, [40] = 4, [80] = 5, [160] = 6}
--AIM-9 Adjustment
local AIM9AzPresses    	= { [80] = 0, [140] = 1, [20] = 2, [40] = 3, [60] = 4} --OSB 6
local AIM9BarPresses   	= { [4] = 0, [6] = 1, [1] = 2, [2] = 3}
local AIM9TimePresses  	= { [8] = 0, [16] = 1, [32] = 2, [2] = 3, [4] = 5}
local AIM9PRFPresses    = { ["ILV"] = 0, ["MED"] = 1, ["HI"] = 2}

push_start_command(dt, {message = _("CONFIGURING STORED RADAR PREFERENCES"), message_timeout = dt_mto})
--AIM-9
push_start_command(dt, {device = devices.HOTAS, action = hotas_commands.STICK_WEAPON_SELECT_DOWN,   value = 1.0})
push_start_command(dt, {device = devices.HOTAS, action = hotas_commands.STICK_WEAPON_SELECT_DOWN,   value = 0.0, message = _("AIM-9 SELECTED"), message_timeout = dt_mto})
--Range
push_start_command(dt, {message = _("AIM-9 RADAR RANGE - "..AIM9Rng.."nm"), message_timeout = dt_mto})
if (RWSRangePattern[AIM9Rng]-4) >= 0
    then 
        for i = 1, (RWSRangePattern[AIM9Rng]-4), 1 do --4 is default value of AIM-9 range in lookup table. Subtracting gives the number of +- presses required
            push_start_command(dt, {device = devices.MDI_RIGHT, action = MDI_commands.MDI_PB_11, value = 1.0}) -- press RDR range up (OSB 11)
            push_start_command(dt, {device = devices.MDI_RIGHT, action = MDI_commands.MDI_PB_11, value = 0.0}) -- release
        end
    else 
        for i = -1, (RWSRangePattern[AIM9Rng]-4), -1 do
            push_start_command(dt, {device = devices.MDI_RIGHT, action = MDI_commands.MDI_PB_12, value = 1.0}) -- press RDR range down (OSB 12)
            push_start_command(dt, {device = devices.MDI_RIGHT, action = MDI_commands.MDI_PB_12, value = 0.0}) -- release
        end
end
--Azimuth
push_start_command(dt, {message = _("AIM-9 RADAR AZIMUTH - "..AIM9Az.."°"), message_timeout = dt_mto})
for i=1, AIM9AzPresses[AIM9Az], 1 do
    push_start_command(dt, {device = devices.MDI_RIGHT, action = MDI_commands.MDI_PB_19, value = 1.0}) -- AZ OSB (19)
    push_start_command(dt, {device = devices.MDI_RIGHT, action = MDI_commands.MDI_PB_19, value = 0.0}) -- release
end
--Bars
push_start_command(dt, {message = _("AIM-9 RADAR Bars - "..AIM9Bar), message_timeout = dt_mto})
for i=1, AIM9BarPresses[AIM9Bar], 1 do
    push_start_command(dt, {device = devices.MDI_RIGHT, action = MDI_commands.MDI_PB_6, value = 1.0}) -- BAR OSB (6)
    push_start_command(dt, {device = devices.MDI_RIGHT, action = MDI_commands.MDI_PB_6, value = 0.0}) -- release
end
--PRF
push_start_command(dt, {message = _("AIM-9 RADAR PRF - "..AIM9PRF), message_timeout = dt_mto})
for i=1, AIM9PRFPresses[AIM9PRF], 1 do
    push_start_command(dt, {device = devices.MDI_RIGHT, action = MDI_commands.MDI_PB_1, value = 1.0}) -- PRF OSB (1)
    push_start_command(dt, {device = devices.MDI_RIGHT, action = MDI_commands.MDI_PB_1, value = 0.0}) -- release
end
--DATA SUBPAGE
push_start_command(dt, {message = _("AIM-9 RADAR BRICK TIMEOUT - "..AIM9Time.."s"), message_timeout = dt_mto})
push_start_command(dt, {device = devices.MDI_RIGHT, action = MDI_commands.MDI_PB_16, value = 1.0}) -- DATA OSB (16)
push_start_command(dt, {device = devices.MDI_RIGHT, action = MDI_commands.MDI_PB_16, value = 0.0}) -- release
--Timeout
for i=1, AIM9TimePresses[AIM9Time], 1 do
    push_start_command(dt, {device = devices.MDI_RIGHT, action = MDI_commands.MDI_PB_10, value = 1.0}) -- TIMEOUT OSB (10)
    push_start_command(dt, {device = devices.MDI_RIGHT, action = MDI_commands.MDI_PB_10, value = 0.0}) -- release
end
--Exit Data Subpage
push_start_command(dt, {device = devices.MDI_RIGHT, action = MDI_commands.MDI_PB_16, value = 1.0}) -- DATA OSB (16)
push_start_command(dt, {device = devices.MDI_RIGHT, action = MDI_commands.MDI_PB_16, value = 0.0}) -- release
--Set
push_start_command(dt, {device = devices.MDI_RIGHT, action = MDI_commands.MDI_PB_13, value = 1.0}) -- SET OSB (13)
push_start_command(dt, {device = devices.MDI_RIGHT, action = MDI_commands.MDI_PB_13, value = 0.0}) -- release
push_start_command(dt, {message = _("AIM-9 RADAR PREFERENCES - SET"), message_timeout = dt_mto})

--AIM-7 Adjustment
local AIM7AzPresses    	= { [140] = 0, [20] = 1, [40] = 2, [60] = 3, [80] = 4} --OSB 6
local AIM7BarPresses   	= { [2] = 0, [4] = 1, [6] = 2, [1] = 3} 
local AIM7TimePresses  	= { [8] = 0, [16] = 1, [32] = 2, [2] = 3, [4] = 4}
local AIM7PRFPresses    = { ["ILV"] = 0, ["MED"] = 1, ["HI"] = 2}
--AIM-7
push_start_command(dt, {device = devices.HOTAS, action = hotas_commands.STICK_WEAPON_SELECT_FWD,   value = 1.0})
push_start_command(dt, {device = devices.HOTAS, action = hotas_commands.STICK_WEAPON_SELECT_FWD,   value = 0.0, message = _("AIM-7 SELECTED"), message_timeout = dt_mto})
--Range
push_start_command(dt, {message = _("AIM-7 RADAR RANGE - "..AIM7Rng.."nm"), message_timeout = dt_mto})
if (RWSRangePattern[AIM7Rng]-4) >= 0
    then 
        for i = 1, (RWSRangePattern[AIM7Rng]-4), 1 do --4 is default value of AIM-7 range in lookup table. Subtracting gives the number of +- presses required
            push_start_command(dt, {device = devices.MDI_RIGHT, action = MDI_commands.MDI_PB_11, value = 1.0}) -- press RDR range up (OSB 11)
            push_start_command(dt, {device = devices.MDI_RIGHT, action = MDI_commands.MDI_PB_11, value = 0.0}) -- release
        end
    else 
        for i = -1, (RWSRangePattern[AIM7Rng]-4), -1 do
            push_start_command(dt, {device = devices.MDI_RIGHT, action = MDI_commands.MDI_PB_12, value = 1.0}) -- press RDR range down (OSB 12)
            push_start_command(dt, {device = devices.MDI_RIGHT, action = MDI_commands.MDI_PB_12, value = 0.0}) -- release
        end
end
--Azimuth
push_start_command(dt, {message = _("AIM-7 RADAR AZIMUTH - "..AIM7Az.."°"), message_timeout = dt_mto})
for i=1, AIM7AzPresses[AIM7Az], 1 do
    push_start_command(dt, {device = devices.MDI_RIGHT, action = MDI_commands.MDI_PB_17, value = 1.0}) -- AZ OSB (17)
    push_start_command(dt, {device = devices.MDI_RIGHT, action = MDI_commands.MDI_PB_17, value = 0.0}) -- release
end
--Bars
push_start_command(dt, {message = _("AIM-7 RADAR Bars - "..AIM7Bar), message_timeout = dt_mto})

for i=1, AIM7BarPresses[AIM7Bar], 1 do
    push_start_command(dt, {device = devices.MDI_RIGHT, action = MDI_commands.MDI_PB_6, value = 1.0}) -- BAR OSB (6)
    push_start_command(dt, {device = devices.MDI_RIGHT, action = MDI_commands.MDI_PB_6, value = 0.0}) -- release
end
--PRF
push_start_command(dt, {message = _("AIM-7 RADAR PRF - "..AIM7PRF), message_timeout = dt_mto})
for i=0, AIM7PRFPresses[AIM7PRF], 1 do
    push_start_command(dt, {device = devices.MDI_RIGHT, action = MDI_commands.MDI_PB_1, value = 1.0}) -- PRF OSB (1)
    push_start_command(dt, {device = devices.MDI_RIGHT, action = MDI_commands.MDI_PB_1, value = 0.0}) -- release
end
--DATA SUBPAGE
push_start_command(dt, {message = _("AIM-7 RADAR BRICK TIMEOUT - "..AIM7Time.."s"), message_timeout = dt_mto})
push_start_command(dt, {device = devices.MDI_RIGHT, action = MDI_commands.MDI_PB_16, value = 1.0}) -- DATA OSB (16)
push_start_command(dt, {device = devices.MDI_RIGHT, action = MDI_commands.MDI_PB_16, value = 0.0}) -- release
--Timeout
for i=1, AIM7TimePresses[AIM7Time], 1 do
    push_start_command(dt, {device = devices.MDI_RIGHT, action = MDI_commands.MDI_PB_10, value = 1.0}) -- TIMEOUT OSB (10)
    push_start_command(dt, {device = devices.MDI_RIGHT, action = MDI_commands.MDI_PB_10, value = 0.0}) -- release
end
--Exit Data Subpage
push_start_command(dt, {device = devices.MDI_RIGHT, action = MDI_commands.MDI_PB_16, value = 1.0}) -- DATA OSB (16)
push_start_command(dt, {device = devices.MDI_RIGHT, action = MDI_commands.MDI_PB_16, value = 0.0}) -- release
--Set
push_start_command(dt, {device = devices.MDI_RIGHT, action = MDI_commands.MDI_PB_13, value = 1.0}) -- SET OSB (13)
push_start_command(dt, {device = devices.MDI_RIGHT, action = MDI_commands.MDI_PB_13, value = 0.0}) -- release
push_start_command(dt, {message = _("AIM-7 RADAR PREFERENCES - SET"), message_timeout = dt_mto})


--AIM-120 Adjustment
local AIM120AzPresses   = { [80] = 0, [140] = 1, [20] = 2, [40] = 3, [60] = 4} --OSB 6
local AIM120BarPresses  = { [4] = 0, [6] = 1, [1] = 2, [2] = 3}
local AIM120TimePresses = { [4] = 0, [8] = 1, [16] = 2, [32] = 3}
local AIM120PRFPresses  = { ["ILV"] = 0, ["MED"] = 1, ["HI"] = 2}
push_start_command(dt, {device = devices.HOTAS, action = hotas_commands.STICK_WEAPON_SELECT_IN,   value = 1.0})
push_start_command(dt, {device = devices.HOTAS, action = hotas_commands.STICK_WEAPON_SELECT_IN,   value = 0.0, message = _("AIM-120 SELECTED"), message_timeout = dt_mto})
--Range
push_start_command(dt, {message = _("AIM-120 RADAR RANGE - "..AIM120Rng.."nm"), message_timeout = dt_mto})
if (RWSRangePattern[AIM120Rng]-4) >= 0
    then 
        for i = 1, (RWSRangePattern[AIM120Rng]-4), 1 do --4 is default value of AIM-120 range in lookup table. Subtracting gives the number of +- presses required
            push_start_command(dt, {device = devices.MDI_RIGHT, action = MDI_commands.MDI_PB_11, value = 1.0}) -- press RDR range up (OSB 11)
            push_start_command(dt, {device = devices.MDI_RIGHT, action = MDI_commands.MDI_PB_11, value = 0.0}) -- release
        end
    else 
        for i = -1, (RWSRangePattern[AIM120Rng]-4), -1 do
            push_start_command(dt, {device = devices.MDI_RIGHT, action = MDI_commands.MDI_PB_12, value = 1.0}) -- press RDR range down (OSB 12)
            push_start_command(dt, {device = devices.MDI_RIGHT, action = MDI_commands.MDI_PB_12, value = 0.0}) -- release
        end
end
--Azimuth
push_start_command(dt, {message = _("AIM-120 RADAR AZIMUTH - "..AIM120Az.."°"), message_timeout = dt_mto})
for i=1, AIM120AzPresses[AIM120Az], 1 do
    push_start_command(dt, {device = devices.MDI_RIGHT, action = MDI_commands.MDI_PB_1120, value = 1.0}) -- AZ OSB (1120)
    push_start_command(dt, {device = devices.MDI_RIGHT, action = MDI_commands.MDI_PB_1120, value = 0.0}) -- release
end
--Bars
push_start_command(dt, {message = _("AIM-120 RADAR Bars - "..AIM120Bar), message_timeout = dt_mto})
for i=1, AIM120BarPresses[AIM120Bar], 1 do
    push_start_command(dt, {device = devices.MDI_RIGHT, action = MDI_commands.MDI_PB_6, value = 1.0}) -- BAR OSB (6)
    push_start_command(dt, {device = devices.MDI_RIGHT, action = MDI_commands.MDI_PB_6, value = 0.0}) -- release
end
--PRF
push_start_command(dt, {message = _("AIM-120 RADAR PRF - "..AIM120PRF), message_timeout = dt_mto})
for i=1, AIM120PRFPresses[AIM120PRF], 1 do
    push_start_command(dt, {device = devices.MDI_RIGHT, action = MDI_commands.MDI_PB_1, value = 1.0}) -- PRF OSB (1)
    push_start_command(dt, {device = devices.MDI_RIGHT, action = MDI_commands.MDI_PB_1, value = 0.0}) -- release
end
--DATA SUBPAGE
push_start_command(dt, {message = _("AIM-120 RADAR BRICK TIMEOUT - "..AIM120Time.."s"), message_timeout = dt_mto})
push_start_command(dt, {device = devices.MDI_RIGHT, action = MDI_commands.MDI_PB_16, value = 1.0}) -- DATA OSB (16)
push_start_command(dt, {device = devices.MDI_RIGHT, action = MDI_commands.MDI_PB_16, value = 0.0}) -- release
--Timeout
for i=1, AIM120TimePresses[AIM120Time], 1 do
    push_start_command(dt, {device = devices.MDI_RIGHT, action = MDI_commands.MDI_PB_10, value = 1.0}) -- TIMEOUT OSB (10)
    push_start_command(dt, {device = devices.MDI_RIGHT, action = MDI_commands.MDI_PB_10, value = 0.0}) -- release
end
--Exit Data Subpage
push_start_command(dt, {device = devices.MDI_RIGHT, action = MDI_commands.MDI_PB_16, value = 1.0}) -- DATA OSB (16)
push_start_command(dt, {device = devices.MDI_RIGHT, action = MDI_commands.MDI_PB_16, value = 0.0}) -- release
--Missile Settings
push_start_command(dt, {device = devices.MDI_LEFT, action = MDI_commands.MDI_PB_5, value = 1.0}) -- RCS Select (OSB 7)
push_start_command(dt, {device = devices.MDI_LEFT, action = MDI_commands.MDI_PB_5, value = 0.0}) -- release
push_start_command(dt, {device = devices.MDI_LEFT, action = MDI_commands.MDI_PB_5, value = 1.0}) -- RCS - Small (OSB 6)
push_start_command(dt, {device = devices.MDI_LEFT, action = MDI_commands.MDI_PB_5, value = 0.0}) -- release
push_start_command(dt, {device = devices.MDI_LEFT, action = MDI_commands.MDI_PB_5, value = 1.0}) -- S-MODE AUTO (OSB 5)
push_start_command(dt, {device = devices.MDI_LEFT, action = MDI_commands.MDI_PB_5, value = 0.0}) -- release
--Set
push_start_command(dt, {device = devices.MDI_RIGHT, action = MDI_commands.MDI_PB_13, value = 1.0}) -- SET OSB (13)
push_start_command(dt, {device = devices.MDI_RIGHT, action = MDI_commands.MDI_PB_13, value = 0.0}) -- release
push_start_command(dt, {message = _("AIM-120 RADAR PREFERENCES - SET"), message_timeout = dt_mto})

push_start_command(dt, {message = _("ALL RADAR PREFERENCES - SET"), message_timeout = dt_mto})

--UFC FUNCTIONS
--IFF
push_start_command(dt, {message = _("IFF - ON"), message_timeout = dt_mto})
push_start_command(dt, {device = devices.UFC, action = UFC_commands.FuncSwIFF,      value = 1.0}) -- UFC IFF button
push_start_command(dt, {device = devices.UFC, action = UFC_commands.FuncSwIFF,      value = 0.0}) -- release
push_start_command(dt, {device = devices.UFC, action = UFC_commands.FuncSwOnOff,    value = 1.0}) -- UFC ON/OFF button
push_start_command(1.0, {device = devices.UFC, action = UFC_commands.FuncSwOnOff,   value = 0.0}) -- release
--TACAN
push_start_command(dt, {message = _("TACAN - ON"), message_timeout = dt_mto})
push_start_command(dt, {device = devices.UFC, action = UFC_commands.FuncSwTCN,      value = 1.0}) -- UFC TACAN button
push_start_command(dt, {device = devices.UFC, action = UFC_commands.FuncSwTCN,      value = 0.0}) -- release
push_start_command(dt, {device = devices.UFC, action = UFC_commands.FuncSwOnOff,    value = 1.0}) -- UFC ON/OFF button
push_start_command(1.0,{device = devices.UFC, action = UFC_commands.FuncSwOnOff,    value = 0.0}) -- release
push_start_command(dt, {message = _("TACAN - SET TO "..TACANTens..TACANOnes..TACANXY), message_timeout = dt_mto})
push_start_command(dt, {device = devices.UFC, action = UFCNum[TACANTens],           value = 1.0}) -- UFC TACAN Tens Digit pushed
push_start_command(dt, {device = devices.UFC, action = UFCNum[TACANTens],           value = 0.0}) -- release
push_start_command(dt, {device = devices.UFC, action = UFCNum[TACANOnes],           value = 1.0}) -- UFC TACAN Ones Digit pushed
push_start_command(dt, {device = devices.UFC, action = UFCNum[TACANOnes],           value = 0.0}) -- release
push_start_command(dt, {device = devices.UFC, action = UFC_commands.KbdSwENT,       value = 1.0}) -- UFC ENTER pushed
push_start_command(dt, {device = devices.UFC, action = UFC_commands.KbdSwENT,       value = 0.0}) -- release
push_start_command(dt, {device = devices.UFC, action = UFCNum[TACANXYConverted],    value = 1.0}) -- UFC TACAN X/Y Option pushed
push_start_command(dt, {device = devices.UFC, action = UFCNum[TACANXYConverted],    value = 0.0}) -- release
--ILS
push_start_command(dt, {message = _("ILS - ON"), message_timeout = dt_mto})
push_start_command(dt, {device = devices.UFC, action = UFC_commands.FuncSwILS,      value = 1.0}) -- UFC ILS button
push_start_command(dt, {device = devices.UFC, action = UFC_commands.FuncSwILS,      value = 0.0}) -- release
push_start_command(dt, {device = devices.UFC, action = UFC_commands.FuncSwOnOff,    value = 1.0}) -- UFC ON/OFF button
push_start_command(1.0,{device = devices.UFC, action = UFC_commands.FuncSwOnOff,    value = 0.0}) -- release
push_start_command(dt, {message = _("ILS - SET TO CHANNEL "..ILSTens..ILSOnes), message_timeout = dt_mto})
push_start_command(dt, {device = devices.UFC, action = UFCNum[ILSTens],           value = 1.0}) -- UFC ILS Tens Digit pushed
push_start_command(dt, {device = devices.UFC, action = UFCNum[ILSTens],           value = 0.0}) -- release
push_start_command(dt, {device = devices.UFC, action = UFCNum[ILSOnes],           value = 1.0}) -- UFC ILS Ones Digit pushed
push_start_command(dt, {device = devices.UFC, action = UFCNum[ILSOnes],           value = 0.0}) -- release
push_start_command(dt, {device = devices.UFC, action = UFC_commands.KbdSwENT,       value = 1.0}) -- UFC ENTER pushed
push_start_command(dt, {device = devices.UFC, action = UFC_commands.KbdSwENT,       value = 0.0}) -- release
--DATALINK
push_start_command(dt, {message = _("DATALINK - Link 4 ON"), message_timeout = dt_mto})
push_start_command(dt, {device = devices.UFC, action = UFC_commands.FuncSwDL, value = 1.0}) -- UFC D/L button
push_start_command(dt, {device = devices.UFC, action = UFC_commands.FuncSwDL, value = 0.0}) -- release
push_start_command(dt, {device = devices.UFC, action = UFC_commands.FuncSwOnOff, value = 1.0}) -- UFC ON/OFF button
push_start_command(1.0, {device = devices.UFC, action = UFC_commands.FuncSwOnOff, value = 0.0}) -- release
push_start_command(dt, {message = _("DATALINK - Link 16 ON"), message_timeout = dt_mto})
push_start_command(dt, {device = devices.UFC, action = UFC_commands.FuncSwDL, value = 1.0}) -- UFC D/L button, press again to go to the second D/L page
push_start_command(dt, {device = devices.UFC, action = UFC_commands.FuncSwDL, value = 0.0}) -- release
push_start_command(dt, {device = devices.UFC, action = UFC_commands.FuncSwOnOff, value = 1.0}) -- UFC ON/OFF button
push_start_command(1.0, {device = devices.UFC, action = UFC_commands.FuncSwOnOff, value = 0.0}) -- release



-- Trigger the INS alignment check after the correct time (total process time minus the difference between now and when the process started).
push_start_command(ins_align_time - (t_start - ins_timer), {message = _("CHECK INS ALIGNMENT - READY"), check_condition = F18_AD_INS_CHECK_RDY, message_timeout = dt_mto})
push_start_command(dt, {message = _("INS KNOB - IFA"), message_timeout = dt_mto})
push_start_command(dt, {device = devices.INS, action = INS_commands.INS_SwitchChange, value = 0.4})

-- NOTE Should be done after INS alignement is complete.
push_start_command(dt, {message = _("AMPCD GAIN - DOWN 9 FOR VR"), message_timeout = dt_mto})
for i = 0, 8, 1 do
    push_start_command(0.05, {device = devices.AMPCD, action = AMPCD_commands.AMPCD_gain_DOWN, value = -1.0})
    push_start_command(0.05, {device = devices.AMPCD, action = AMPCD_commands.AMPCD_gain_DOWN, value = 0.0})
end

push_start_command(dt, {message = _("PARK BRK HANDLE - FULLY STOWED"), message_timeout = dt_mto})
push_start_command(dt, {device = devices.GEAR_INTERFACE, action = gear_commands.EmergParkHandleSelectPark, value = 0.333})
push_start_command(dt, {device = devices.GEAR_INTERFACE, action = gear_commands.EmergParkHandleSelectPark, value = 0.0})
push_start_command(dt, {device = devices.GEAR_INTERFACE, action = gear_commands.EmergParkHandleSelectEmerg, value = -0.666})
--
push_start_command(dt, {message = _("EJECTION SEAT SAFE/ARM HANDLE - ARM"), message_timeout = dt_mto})
push_start_command(dt, {device = devices.CPT_MECHANICS, action = cpt_commands.EjectionSeatSafeArmedHandle, value = 0.0})
--
push_start_command(dt, {message = _("HAVOC'S QUICKSTART COMPLETE"), message_timeout = 30})
--




----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
-- Stop sequence
push_stop_command(0, {message = _("HAVOC'S QUICK AUTOSTOP SEQUENCE IS RUNNING"), message_timeout = stop_sequence_time})
--
push_stop_command(dt, {message = _("EJECTION SEAT SAFE/ARM HANDLE - SAFE"), message_timeout = dt_mto})
push_stop_command(dt, {device = devices.CPT_MECHANICS, action = cpt_commands.EjectionSeatSafeArmedHandle, value = 1.0})
push_stop_command(dt, {message = _("LDG GEAR HANDLE - DN"), message_timeout = dt_mto})
push_stop_command(dt, {device = devices.GEAR_INTERFACE, action = gear_commands.GearHandle, value = 0.0})
push_stop_command(dt, {message = _("FLAP SWITCH - FULL"), message_timeout = dt_mto})
push_stop_command(dt, {device = devices.CONTROL_INTERFACE, action = ctrl_commands.FlapSw, value = -1.0})
push_stop_command(dt, {message = _("T/O TRIM BUTTON - PRESS UNTIL TRIM ADVISORY DISPLAYED"), message_timeout = dt_mto})
push_stop_command(dt, {device = devices.CONTROL_INTERFACE, action = ctrl_commands.TOTrimSw, value = 1.0})
-- TODO: check condition
push_stop_command(dt, {device = devices.CONTROL_INTERFACE, action = ctrl_commands.TOTrimSw, value = 0.0})
push_stop_command(dt, {message = _("PARK BRK HANDLE - SET"), message_timeout = dt_mto})
push_stop_command(dt, {device = devices.GEAR_INTERFACE, action = gear_commands.EmergParkHandleSelectPark, value = 0.333})
push_stop_command(dt, {device = devices.GEAR_INTERFACE, action = gear_commands.EmergParkHandleSelectPark, value = 0.0})
push_stop_command(dt, {device = devices.GEAR_INTERFACE, action = gear_commands.EmergParkHandleOnOff, value = 0.1})
push_stop_command(dt, {device = devices.GEAR_INTERFACE, action = gear_commands.EmergParkHandleSelectPark, value = 0.333})
push_stop_command(dt, {device = devices.GEAR_INTERFACE, action = gear_commands.EmergParkHandleSelectPark, value = 0.0})
push_stop_command(dt, {device = devices.GEAR_INTERFACE, action = gear_commands.EmergParkHandleOnOff, value = -0.1})
push_stop_command(dt, {message = _("INS KNOB - OFF"), message_timeout = dt_mto})
push_stop_command(dt, {device = devices.INS, action = INS_commands.INS_SwitchChange, value = 0.0})
push_stop_command(dt, {message = _("STANDBY ATTITUDE REFERENCE INDICATOR - CAGE/LOCK"), message_timeout = dt_mto})
push_stop_command(dt, {device = devices.SAI, action = sai_commands.SAI_pull, value = 1.0})
push_stop_command(dt, {device = devices.SAI, action = sai_commands.SAI_rotate, value = 0.01})
push_stop_command(dt, {device = devices.SAI, action = sai_commands.SAI_pull, value = 0.0})
push_stop_command(dt, {message = _("RADAR - OFF"), message_timeout = dt_mto})
push_stop_command(dt, {device = devices.RADAR, action = RADAR_commands.RADAR_SwitchChange, value = 0.0})

push_stop_command(dt, {message = _("EXT AND INT LT KNOBS - OFF"), message_timeout = dt_mto})
push_stop_command(dt, {device = devices.EXT_LIGHTS, action = extlights_commands.Formation, value = 0.0})
push_stop_command(dt, {device = devices.EXT_LIGHTS, action = extlights_commands.Position, value = 0.0})

push_stop_command(dt, {device = devices.EXT_LIGHTS, action = extlights_commands.LdgTaxi, value = 0.0})
push_stop_command(dt, {device = devices.CPT_LIGHTS, action = cptlights_commands.Consoles, value = 0.0})
push_stop_command(dt, {device = devices.CPT_LIGHTS, action = cptlights_commands.InstPnl, value = 0.0})
push_stop_command(dt, {device = devices.CPT_LIGHTS, action = cptlights_commands.Flood, value = 0.0})
push_stop_command(dt, {device = devices.CPT_LIGHTS, action = cptlights_commands.Chart, value = 0.0})

push_stop_command(dt, {message = _("RADAR ALTIMETER - OFF, SET TO 0 FT"), message_timeout = dt_mto})
for i = 0, 61, 1 do -- Note 0-index.  60 total steps to go from 5000 ft to 0 ft, 62 steps to turn off completely.
    push_stop_command(0.01, {device = devices.ID2163A, action = id2163a_commands.ID2163A_SetMinAlt, value = -0.05}) -- value = positive number to go up, negative number to go down.  Actual number doesn't seem to make a difference, only +/-??
end

push_stop_command(dt, {message = _("HUD ALT SWITCH - BARO"), message_timeout = dt_mto})
push_stop_command(dt, {device = devices.HUD, action = HUD_commands.HUD_AltitudeSw, value = 1.0})
push_stop_command(dt, {message = _("IR COOL SWITCH - OFF"), message_timeout = dt_mto})
push_stop_command(dt, {device = devices.SMS, action = SMS_commands.IRCoolingSw, value = 0.0})
push_stop_command(dt, {message = _("DISPENSER SWITCH - OFF"), message_timeout = dt_mto})
push_stop_command(dt, {device = devices.CMDS, action = cmds_commands.Dispenser, value = 0.0})
push_stop_command(dt, {message = _("ECM - OFF"), message_timeout = dt_mto})
push_stop_command(dt, {device = devices.ASPJ, action = ASPJ_commands.ASPJ_SwitchChange, value = 0.0})
--
push_stop_command(dt, {message = _("CANOPY - OPEN"), message_timeout = dt_mto})
push_stop_command(dt, {device = devices.CPT_MECHANICS, action = cpt_commands.CanopySwitchOpen, value = 1.0})
push_stop_command(dt, {device = devices.CPT_MECHANICS, action = cpt_commands.CanopySwitchOpen, value = 0.0})
-- Engine shutdown
push_stop_command(dt, {message = _("LEFT THROTTLE - OFF"), check_condition = F18_AD_LEFT_THROTTLE_DOWN_TO_IDLE, message_timeout = dt_mto})
push_stop_command(dt, { check_condition = F18_AD_LEFT_THROTTLE_SET_TO_OFF})
push_stop_command(dt, {message = _("L(R) DDI, AMPCD, HUD AND HMD KNOBS - OFF"), message_timeout = dt_mto})
push_stop_command(dt, {device = devices.MDI_LEFT, action = MDI_commands.MDI_off_night_day, value = 0.0})
push_stop_command(dt, {device = devices.MDI_RIGHT, action = MDI_commands.MDI_off_night_day, value = 0.0})
push_stop_command(dt, {device = devices.HUD, action = HUD_commands.HUD_SymbBrightCtrl, value = 0.0})
push_stop_command(dt, {device = devices.HMD_INTERFACE, action = hmd_commands.BrtKnob, value = 0.0})
push_stop_command(dt, {device = devices.AMPCD, action = AMPCD_commands.AMPCD_off_brightness, value = 0.0})
push_stop_command(dt, {message = _("RIGHT THROTTLE - OFF"), check_condition = F18_AD_RIGHT_THROTTLE_DOWN_TO_IDLE})
push_stop_command(dt, { check_condition = F18_AD_RIGHT_THROTTLE_SET_TO_OFF})
push_stop_command(dt, {message = _("BATT SWITCH - OFF"), message_timeout = dt_mto})
push_stop_command(dt, {device = devices.ELEC_INTERFACE, action = elec_commands.BattSw, value = 0.0})
--
push_stop_command(dt, {message = _("HAVOC'S AUTOSTOP COMPLETE"), message_timeout = 30})
--
