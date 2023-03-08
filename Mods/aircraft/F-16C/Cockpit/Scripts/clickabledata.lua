dofile(LockOn_Options.script_path.."clickable_defs.lua")
dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."config.lua")
dofile(LockOn_Options.script_path.."sounds.lua")


local gettext = require("i_18n")
_ = gettext.translate


elements = {}

-- Control Interface
elements["PTR-FLTCP-TMB-DIGITAL-566"]	= default_2_position_tumb(_("DIGITAL BACKUP Switch, OFF/BACKUP"),						devices.CONTROL_INTERFACE, control_commands.DigitalBackup,			566)
elements["PTR-FLTCP-TMB-AFLP-567"]		= default_2_position_tumb(_("ALT FLAPS Switch, NORM/EXTEND"),							devices.CONTROL_INTERFACE, control_commands.AltFlaps,				567)
elements["PTR-FLTCP-TMB-BIT-574"]		= springloaded_2_pos_tumb(_("BIT Switch, OFF/BIT"),										devices.CONTROL_INTERFACE, control_commands.BitSw,					574)
elements["PTR-FLTCP-TMB-FLCS-573"]		= springloaded_2_pos_tumb_small(_("FLCS RESET Switch, OFF/RESET"),						devices.CONTROL_INTERFACE, control_commands.FlcsReset,				573)
elements["PTR-FLTCP-TMB-LEFLP-572"]		= default_2_position_tumb(_("LE FLAPS Switch, AUTO/LOCK"),								devices.CONTROL_INTERFACE, control_commands.LeFlaps,				572)
elements["PTR-MANTRIM-TMB-MODE-564"]	= default_2_position_tumb(_("TRIM/AP DISC Switch, DISC/NORM"),							devices.CONTROL_INTERFACE, control_commands.TrimApDisc,				564)
elements["PTR-MANTRIM-LVR-ROLL-560"]	= default_axis_limited_1_side(_("ROLL TRIM Wheel"),										devices.CONTROL_INTERFACE, control_commands.RollTrim,				560, 0.0, 0.1, NOT_UPDATABLE, NOT_RELATIVE, {-1,1}, {0,160},{0,-135})
elements["PTR-MANTRIM-LVR-PITCH-562"]	= default_axis_limited_1_side(_("PITCH TRIM Wheel"),									devices.CONTROL_INTERFACE, control_commands.PitchTrim,				562, 0.0, 0.1, NOT_UPDATABLE, NOT_RELATIVE, {-1,1}, {-135,0},{135,0})
elements["PTR-MANTRIM-LVR-YAW-565"]		= default_axis_limited(_("YAW TRIM Knob"),												devices.CONTROL_INTERFACE, control_commands.YawTrim,				565, 0.0, 0.1, NOT_UPDATABLE, NOT_RELATIVE, {-1,1})
elements["PTR-MPCP-TMB-MP-425"]			= springloaded_2_pos_tumb_small(_("MANUAL PITCH Override Switch, OVRD/NORM"),			devices.CONTROL_INTERFACE, control_commands.ManualPitchOverride,	425)
elements["PTR-LGCP-TMB-STCONF-358"]		= default_2_position_tumb_small(_("STORES CONFIG Switch, CAT III/CAT I"),				devices.CONTROL_INTERFACE, control_commands.StoresConfig,			358)
elements["PTR-CLCP-TMB-PITCH-109"]		= springloaded_3_pos_tumb(_("Autopilot PITCH Switch, ATT HOLD/ A/P OFF/ ALT HOLD"),		devices.CONTROL_INTERFACE, control_commands.ApPitchAtt, control_commands.ApPitchAlt, 109)
elements["PTR-CLCP-TMB-ROLL-108"]		= default_3_position_tumb_small(_("Autopilot ROLL Switch, STRG SEL/ATT HOLD/HDG SEL"),	devices.CONTROL_INTERFACE, control_commands.ApRoll,					108)
elements["PTR-CLCP-BTN-ADV-97"]			= default_2_position_tumb(_("ADV MODE Switch"),											devices.CONTROL_INTERFACE, control_commands.AdvMode,				97)
elements["PTR-CLCP-BTN-ADV-97"].sound    = {{SOUND_SW12_ON, SOUND_SW12_OFF}}
elements["PTR-CLCP-BTN-ADV-97"].class_vr = {class_type.BTN_FIX}
elements["PTR-CLCP-BTN-ADV-97"].side     = {{BOX_SIDE_Y_bottom},{0}}
elements["PTR-FLTCP-TMB-MAN-568"]		= default_2_position_tumb(_("MANUAL TF FLYUP Switch, ENABLE/DISABLE"),					devices.CONTROL_INTERFACE, control_commands.ManualTfFlyup,			568)

-- External Lights
elements["PTR-EXTLGT-TMB-ANTCOL-531"]	= multiposition_switch(_("ANTI-COLL Knob, OFF/1/2/3/4/A/B/C"),						devices.EXTLIGHTS_SYSTEM, extlights_commands.AntiCollKn,	531, 8, 0.1, NOT_INVERSED, 0.0, anim_speed_default * 0.1, NOT_CYCLED)
elements["PTR-EXTLGT-TMB-FLSH-532"]		= default_2_position_tumb_small(_("FLASH STEADY Switch, FLASH/STEADY"),				devices.EXTLIGHTS_SYSTEM, extlights_commands.PosFlash,		532)
elements["PTR-EXTLGT-TMB-WNGTAIL-533"]	= default_3_position_tumb_small(_("WING/TAIL Switch, BRT/OFF/DIM"),					devices.EXTLIGHTS_SYSTEM, extlights_commands.PosWingTail,	533)
elements["PTR-EXTLGT-TMB-FUS-534"]		= default_3_position_tumb_small(_("FUSELAGE Switch, BRT/OFF/DIM"),					devices.EXTLIGHTS_SYSTEM, extlights_commands.PosFus,		534)
elements["PTR-EXTLGT-LVR-FORM-535"]		= default_axis_limited(_("FORM Knob"),												devices.EXTLIGHTS_SYSTEM, extlights_commands.FormKn,		535)
elements["PTR-EXTLGT-TMB-MASTER-536"]	= multiposition_switch(_("MASTER Switch, OFF/ALL/A-C/FORM/NORM"),					devices.EXTLIGHTS_SYSTEM, extlights_commands.Master,		536, 5, 0.1, NOT_INVERSED, 0.0, anim_speed_default * 0.1, NOT_CYCLED)
elements["PTR-EXTLGT-LVR-AREF-537"]		= default_axis_limited(_("AERIAL REFUELING Knob"),									devices.EXTLIGHTS_SYSTEM, extlights_commands.AerialRefuel,	537)
elements["PTR-LGCP-TMB-LIGHTS-360"]		= default_3_position_tumb_small(_("LANDING TAXI LIGHTS Switch, LANDING/OFF/TAXI"),	devices.EXTLIGHTS_SYSTEM, extlights_commands.LandingTaxi,	360)

-- Interior Lights
elements["PTR-CPBC-BTN-MCAUT-116"]		= default_button(_("Master Caution Button - Push to reset"),				devices.CPTLIGHTS_SYSTEM, cptlights_commands.MasterCaution,		116)
elements["PTR-TESTCP-BTN-MAL-577"]		= default_button(_("MAL & IND LTS Test Button - Push to test"),				devices.CPTLIGHTS_SYSTEM, cptlights_commands.MalIndLtsTest,		577)
elements["PTR-RLGT-LVR-PRICNS-685"]		= default_axis_limited(_("PRIMARY CONSOLES BRT Knob"),						devices.CPTLIGHTS_SYSTEM, cptlights_commands.Consoles,			685,   0, 0.1, NOT_UPDATABLE, NOT_RELATIVE, nil,{-70,-45},{90,-45})
elements["PTR-RLGT-LVR-PRIPNL-686"]		= default_axis_limited(_("PRIMARY INST PNL BRT Knob"),						devices.CPTLIGHTS_SYSTEM, cptlights_commands.IntsPnl,			686,   0, 0.1, NOT_UPDATABLE, NOT_RELATIVE, nil,{-90,-45},{90,-45})
elements["PTR-RLGT-LVR-PRIDATA-687"]	= default_axis_limited(_("PRIMARY DATA ENTRY DISPLAY BRT Knob"),			devices.CPTLIGHTS_SYSTEM, cptlights_commands.DataEntryDisplay,	687,   0, 0.1, NOT_UPDATABLE, NOT_RELATIVE, nil,{-115,-45},{135,-45})
elements["PTR-RLGT-LVR-FLDCNS-688"]		= default_axis_limited(_("FLOOD CONSOLES BRT Knob"),						devices.CPTLIGHTS_SYSTEM, cptlights_commands.ConsolesFlood,		688, nil, nil, NOT_UPDATABLE, NOT_RELATIVE, nil,{-70,-45},{90,-30})
elements["PTR-RLGT-LVR-FLDPNL-690"]		= default_axis_limited(_("FLOOD INST PNL BRT Knob"),						devices.CPTLIGHTS_SYSTEM, cptlights_commands.InstPnlFlood,		690,   0, 0.1, NOT_UPDATABLE, NOT_RELATIVE, nil,{-90,-30},{90,-30})
elements["PTR-RLGT-TMB-MALIND-691"]		= springloaded_3_pos_tumb_small(_("MAL & IND LTS Switch, BRT/Center/DIM"),	devices.CPTLIGHTS_SYSTEM, cptlights_commands.MalIndLtsDim, cptlights_commands.MalIndLtsBrt,	691)
elements["PTR-AOA-LVL-794"]				= default_axis_limited_1_side(_("AOA Indexer Dimming Lever"),				devices.CPTLIGHTS_SYSTEM, cptlights_commands.IndBrtAoA,			794, 0, 0.1, IS_UPDATABLE, NOT_RELATIVE, {0, 1.0})
elements["PTR-AR-LVL-795"]				= default_axis_limited_1_side(_("AR Status Indicator Dimming Lever"),		devices.CPTLIGHTS_SYSTEM, cptlights_commands.IndBrtAR,			795, 0, 0.1, IS_UPDATABLE, NOT_RELATIVE, {0, 1.0})

-- Electric System
elements["PTR-ELEC-TMB-MPWR-510"]		= default_3_position_tumb(_("MAIN PWR Switch, MAIN PWR/BATT/OFF"),				devices.ELEC_INTERFACE, elec_commands.MainPwrSw,		510, false, anim_speed_default, false)
elements["PTR-ELEC-BTN-CRES-511"]		= default_button(_("ELEC CAUTION RESET Button - Push to reset"),				devices.ELEC_INTERFACE, elec_commands.CautionResetBtn,	511)
elements["PTR-TESTCP-TMB-EPU-579"]		= springloaded_2_pos_tumb_small(_("EPU/GEN Test Switch, EPU/GEN /OFF"),			devices.ELEC_INTERFACE, elec_commands.EPU_GEN_TestSw,	579)
elements["PTR-TESTCP-TMB-PROBE-578"]	= default_button_tumb(_("PROBE HEAT Switch, PROBE HEAT/OFF/TEST(momentarily)"),	devices.ELEC_INTERFACE, elec_commands.ProbeHeatSwTEST,	  elec_commands.ProbeHeatSw,		578)
elements["PTR-TESTCP-TMB-TEST-585"]		= default_tumb_button(_("FLCS PWR TEST Switch, MAINT/NORM/TEST(momentarily)"),	devices.ELEC_INTERFACE, elec_commands.FlcsPwrTestSwMAINT, elec_commands.FlcsPwrTestSwTEST,	585)

-- Fuel System
elements["PTR-FUELCP-TMB-MASTER-559"]	= default_2_position_tumb_small(_("FUEL MASTER Switch, MASTER/OFF"),								devices.FUEL_INTERFACE, fuel_commands.FuelMasterSw,			559)
elements["PTR-FUELCP-CVR-MASTER-558"]	= default_red_cover(_("FUEL MASTER Switch Cover, OPEN/CLOSE"),										devices.FUEL_INTERFACE, fuel_commands.FuelMasterSwCvr,		558)
elements["PTR-FUELCP-TMB-TANK-557"]		= default_2_position_tumb(_("TANK INERTING Switch, TANK INERTING /OFF"),							devices.FUEL_INTERFACE, fuel_commands.TankInertingSw,		557)
elements["PTR-FUELCP-TMB-ENGFEED-556"]	= multiposition_switch(_("ENGINE FEED Knob, OFF/NORM/AFT/FWD"),										devices.FUEL_INTERFACE, fuel_commands.EngineFeedSw,			556, 4, 0.1, NOT_INVERSED, 0.0, anim_speed_default * 0.1, NOT_CYCLED, {135, -45}, {45,-45})
elements["PTR-FUELCP-TMB-REFUEL-555"]	= default_2_position_tumb(_("AIR REFUEL Switch, OPEN/CLOSE"),										devices.FUEL_INTERFACE, fuel_commands.AirRefuelSw,			555)
elements["PTR-CDCP-TMB-FTRANS-159"]		= default_2_position_tumb(_("External Fuel Transfer Switch, NORM/ WING FIRST"),						devices.FUEL_INTERFACE, fuel_commands.ExtFuelTransferSw,	159)

elements["PTR-CDCP-TMB-FMODE-158"] =
{
	class			= {class_type.BTN,					class_type.TUMB},
	hint			= _("FUEL QTY SEL Knob, TEST(momentarily)/NORM/RSVR/INT WING/EXT WING/EXT CTR"),
	device			= devices.FUEL_INTERFACE,
	action			= {fuel_commands.FuelQtySelSwTEST,	fuel_commands.FuelQtySelSw,	fuel_commands.FuelQtySelSwTEST},
	stop_action		= {fuel_commands.FuelQtySelSwTEST,	0,							fuel_commands.FuelQtySelSwTEST},
	arg				= {158,								158,						158},
	arg_value		= {-0.1,							0.1,						-1},
	arg_lim			= {{0.0, 0.5},						{0.1, 0.5},					{-0.1, 0.5}},
	updatable		= true,
	use_OBB			= true,
	cycle			= false,
	animated		= {true,							true,						true},
	animation_speed	= {anim_speed_default * 0.1,		anim_speed_default * 0.1,	anim_speed_default * 0.1},
	sound			= {{SOUND_SW2}, {SOUND_SW2}},
	class_vr		= {nil,								class_type.MULTY_TUMB,		class_type.BTN},
	side			= {nil,{BOX_SIDE_X_top, BOX_SIDE_X_bottom, BOX_SIDE_Z_top, BOX_SIDE_Z_bottom},{BOX_SIDE_Y_bottom}}
}

-- Gear System
elements["PTR-LGCP-ARM-LG-362"]			= default_2_position_tumb(_("LG Handle, UP/DN"),								devices.GEAR_INTERFACE, gear_commands.LGHandle,			362)
elements["PTR-LGCP-ARM-LG-362"].sound = {{SOUND_SW8_DOWN,SOUND_SW8_UP}}
elements["PTR-LGCP-BTN-DNLOCK-361"]		= default_button(_("DN LOCK REL Button - Push to reset"),						devices.GEAR_INTERFACE, gear_commands.DownLockRelBtn,	361)
elements["PTR-LGCP-TMB-HOOK-354"]		= default_2_position_tumb(_("HOOK Switch, UP/DN"),								devices.GEAR_INTERFACE, gear_commands.HookSw,			354)
elements["PTR-LGCP-BTN-HORN-359"]		= default_button(_("HORN SILENCER Button - Push to reset"),						devices.GEAR_INTERFACE, gear_commands.HornSilencerBtn,	359)
elements["PTR-LGCP-TMB-BRK-356"]		= default_2_position_tumb_small(_("BRAKES Channel Switch, CHAN 1/CHAN 2"),		devices.GEAR_INTERFACE, gear_commands.BrakesChannelSw,	356)
elements["PTR-LGCP-TMB-PRKNG-357"]		= default_tumb_button(_("ANTI-SKID Switch, PARKING BRAKE/ANTI-SKID/OFF"),		devices.GEAR_INTERFACE, gear_commands.AntiSkidSw,	gear_commands.ParkingSw,	357)
elements["PTR-LGCP-ALTGEAR-380"]		= default_2_position_tumb(_("ALT GEAR Handle, PULL/STOW"),						devices.GEAR_INTERFACE, gear_commands.AltGearHandle,	380)
elements["PTR-LGCP-BTN-RESET-381"]		= default_button(_("ALT GEAR Handle - Push to reset"),							devices.GEAR_INTERFACE, gear_commands.AltGearResetBtn,	381)

-- ECS
elements["PTR-AIRCOND-TMB-TEMP-692"]	= default_axis_limited(_("TEMP Knob"),								devices.ECS_INTERFACE, ecs_commands.TempKnob, 692, 0.0, 0.1, false, false, {-0.3,0.3}, {-90,-45},{90,-30})
elements["PTR-AIRCOND-TMB-SRC-693"]		= multiposition_switch(_("AIR SOURCE Knob, OFF/NORM/DUMP/RAM"),		devices.ECS_INTERFACE, ecs_commands.AirSourceKnob, 693, 4, 0.1, NOT_INVERSED, 0.0, anim_speed_default * 0.1, NOT_CYCLED, {-115,-45},{90,-30})
elements["PTR-LARMS-DEFOG-602"]			= default_2_position_tumb(_("DEFOG Lever"),							devices.ECS_INTERFACE, ecs_commands.DefogLever, 602)
elements["PTR-LARMS-DEFOG-602"].arg_value = {-0.05,0.05}

-- EPU
elements["PTR-EPU-CVR-EPUTMB-527"]		= default_red_cover(_("EPU Switch Cover for ON, OPEN/CLOSE"),			devices.ENGINE_INTERFACE, engine_commands.EpuSwCvrOn,	527)
elements["PTR-EPU-CVR-EPUTMB-529"]		= default_red_cover(_("EPU Switch Cover for OFF, OPEN/CLOSE"),			devices.ENGINE_INTERFACE, engine_commands.EpuSwCvrOff,	529)
elements["PTR-EPU-TMB-EPUTMB-528"]		= default_3_position_tumb_small(_("EPU Switch, ON/NORM/OFF"),			devices.ENGINE_INTERFACE, engine_commands.EpuSw,	    528)

-- engine
elements["PTR-ANTICE-TMB-ENG-710"]			= default_3_position_tumb(_("Engine ANTI ICE Switch, ON/AUTO/OFF"),					devices.ENGINE_INTERFACE, engine_commands.EngAntiIceSw,	710)
elements["PTR-ENGSTART-TMB-JETFUEL-447"]	= springloaded_3_pos_tumb(_("JFS Switch, START 1/OFF/START 2"),						devices.ENGINE_INTERFACE, engine_commands.JfsSwStart2, engine_commands.JfsSwStart1, 447)
elements["PTR-ENGSTART-CVR-ENGCNT-448"]		= default_red_cover(_("ENG CONT Switch Cover, OPEN/CLOSE"),							devices.ENGINE_INTERFACE, engine_commands.EngContSwCvr,	448)
elements["PTR-ENGSTART-TMB-ENGCNT-449"]		= default_2_position_tumb_small(_("ENG CONT Switch, PRI/SEC"),						devices.ENGINE_INTERFACE, engine_commands.EngContSw,	449)
elements["PTR-ENGSTART-TMB-MAXPWR-451"]		= default_2_position_tumb(_("MAX POWER Switch (is inoperative), MAX POWER/OFF"),	devices.ENGINE_INTERFACE, engine_commands.MaxPowerSw,	451)
elements["PTR-ENGSTART-TMB-ABENG-450"]		= springloaded_3_pos_tumb(_("AB RESET Switch, AB RESET/NORM/ENG DATA"),				devices.ENGINE_INTERFACE, engine_commands.ABResetSwEngData, engine_commands.ABResetSwReset, 450, anim_speed_default, -1,0,1)
elements["PTR-TESTCP-BTN-FIRE-575"]			= default_button(_("FIRE & OHEAT DETECT Test Button - Push to test"),				devices.ENGINE_INTERFACE, engine_commands.FireOheatTestBtn,	575)

-- Oxygen System
elements["PTR-OXYCP-LVR-SUPP-728"]		= default_3_position_tumb_small(_("Supply Lever, PBG/ON/OFF"),							devices.OXYGEN_INTERFACE, oxygen_commands.SupplyLever,		728, false, anim_speed_default * 0.5, false, 0.5, {0,1})
elements["PTR-OXYCP-LVR-DUL-727"]		= default_2_position_tumb_small(_("Diluter Lever, 100 percent/NORM"),					devices.OXYGEN_INTERFACE, oxygen_commands.DiluterLever,		727)
elements["PTR-OXYCP-LVR-EMRG-726"]		= default_button_tumb(_("Emergency Lever, EMERGENCY/NORMAL/TEST MASK(momentarily)"),	devices.OXYGEN_INTERFACE, oxygen_commands.EmergencyLeverTestMask,	oxygen_commands.EmergencyLever,	726)
elements["PTR-TESTCP-TMB-OXY-576"]		= springloaded_2_pos_tumb_small(_("OBOGS BIT Switch, BIT/OFF"),							devices.OXYGEN_INTERFACE, oxygen_commands.ObogsBitSw,		576)

-- Sensor Power Control Panel
elements["PTR-SNSR-TMB-LEFT-670"]		= default_2_position_tumb(_("LEFT HDPT Switch, ON/OFF"),			devices.SMS, sms_commands.LeftHDPT,  670)
elements["PTR-SNSR-TMB-RIGHT-671"]		= default_2_position_tumb(_("RIGHT HDPT Switch, ON/OFF"),			devices.SMS, sms_commands.RightHDPT, 671)
elements["PTR-SNSR-TMB-FCR-672"]		= default_2_position_tumb(_("FCR Switch, FCR/OFF"),					devices.FCR, fcr_commands.PwrSw,     672)
elements["PTR-SNSR-TMB-RDR-673"]		= default_3_position_tumb(_("RDR ALT Switch, RDR ALT/STBY/OFF"),	devices.RALT, ralt_commands.PwrSw,   673)
-- Avionic Power panel
elements["PTR-AVIPWR-TMB-MMC-715"]		= default_2_position_tumb(_("MMC Switch, MMC/OFF"),				devices.MMC, mmc_commands.MmcPwr,	715)
elements["PTR-AVIPWR-TMB-STSTA-716"]	= default_2_position_tumb(_("ST STA Switch, ST STA/OFF"),		devices.SMS, sms_commands.StStaSw,	716)
elements["PTR-AVIPWR-TMB-MFD-717"]		= default_2_position_tumb(_("MFD Switch, MFD/OFF"),				devices.MMC, mmc_commands.MFD,		717)
elements["PTR-AVIPWR-TMB-UFC-718"]		= default_2_position_tumb(_("UFC Switch, UFC/OFF"),				devices.UFC, ufc_commands.UFC_Sw,	718)
elements["PTR-AVIPWR-TMB-GPS-720"]		= default_2_position_tumb(_("GPS Switch, GPS/OFF"),				devices.GPS, gps_commands.PwrSw,	720)
elements["PTR-AVIPWR-LVR-MIDS-723"]		= multiposition_switch(_("MIDS LVT Knob, ZERO/OFF/ON"),			devices.MIDS, mids_commands.PwrSw, 723, 3, 0.1, NOT_INVERSED, 0.0, anim_speed_default * 0.1, NOT_CYCLED)
elements["PTR-AVIPWR-LVR-INS-719"]		= multiposition_switch(_("INS Knob, OFF/STOR HDG/NORM/NAV/CAL/INFLT ALIGN/ATT"),	devices.INS, ins_commands.ModeKnob, 719, 7, 0.1, NOT_INVERSED, 0.0, anim_speed_default * 0.1, NOT_CYCLED)
elements["PTR-AVIPWR-TMB-MAP-722"]		= default_2_position_tumb(_("MAP Switch, MAP/OFF"),				devices.MAP, map_commands.PwrSw,	722)
elements["PTR-AVIPWR-TMB-DL-721"]		= default_2_position_tumb(_("DL Switch, DL/OFF"),				devices.IDM, idm_commands.PwrSw,	721)

-- Modular Mission Computer (MMC)
elements["PTR-CLCP-TMB-MASTER-105"]		= default_3_position_tumb(_("MASTER ARM Switch, MASTER ARM/OFF/SIMULATE"),	devices.MMC, mmc_commands.MasterArmSw,		105)
elements["PTR-LGCP-BTN-ESJETT-353"]		= default_button(_("EMER STORES JETTISON Button - Push to jettison"),		devices.MMC, mmc_commands.EmerStoresJett,	353)
elements["PTR-LGCP-TMB-GNDJETT-355"]	= default_2_position_tumb(_("GND JETT ENABLE Switch, ENABLE/OFF"),			devices.MMC, mmc_commands.GroundJett,		355)
elements["PTR-CLCP-TMB-ALT-104"]		= default_button(_("ALT REL Button - Push to release"),						devices.MMC, mmc_commands.AltRel,			104)

elements["PTR-CLCP-TMB-LASER-103"]		= default_2_position_tumb(_("LASER ARM Switch, ARM/OFF"),		devices.SMS, sms_commands.LaserSw, 103)

-- Integrated Control Panel (ICP) of Upfront Controls (UFC)
elements["PTR-ICP-BTN-NMB1-171"]	= short_way_button(_("ICP Priority Function Button, 1(T-ILS)"),									devices.UFC, ufc_commands.DIG1_T_ILS,		171)
elements["PTR-ICP-BTN-NMB2-172"]	= short_way_button(_("ICP Priority Function Button, 2/N(ALOW)"),								devices.UFC, ufc_commands.DIG2_ALOW,		172)
elements["PTR-ICP-BTN-NMB3-173"]	= short_way_button(_("ICP Priority Function Button, 3"),										devices.UFC, ufc_commands.DIG3,				173)
elements["PTR-ICP-BTN-NMB4-175"]	= short_way_button(_("ICP Priority Function Button, 4/W(STPT)"),								devices.UFC, ufc_commands.DIG4_STPT,		175)
elements["PTR-ICP-BTN-NMB5-176"]	= short_way_button(_("ICP Priority Function Button, 5(CRUS)"),									devices.UFC, ufc_commands.DIG5_CRUS,		176)
elements["PTR-ICP-BTN-NMB6-177"]	= short_way_button(_("ICP Priority Function Button, 6/E(TIME)"),								devices.UFC, ufc_commands.DIG6_TIME,		177)
elements["PTR-ICP-BTN-NMB7-179"]	= short_way_button(_("ICP Priority Function Button, 7(MARK)"),									devices.UFC, ufc_commands.DIG7_MARK,		179)
elements["PTR-ICP-BTN-NMB8-180"]	= short_way_button(_("ICP Priority Function Button, 8/S(FIX)"),									devices.UFC, ufc_commands.DIG8_FIX,			180)
elements["PTR-ICP-BTN-NMB9-181"]	= short_way_button(_("ICP Priority Function Button, 9(A-CAL)"),									devices.UFC, ufc_commands.DIG9_A_CAL,		181)
elements["PTR-ICP-BTN-NMB0-182"]	= short_way_button(_("ICP Priority Function Button, 0(M-SEL)"),									devices.UFC, ufc_commands.DIG0_M_SEL,		182)
elements["PTR-ICP-BTN-COM1-165"]	= short_way_button(_("ICP COM Override Button, COM1(UHF)"),										devices.UFC, ufc_commands.COM1,				165)
elements["PTR-ICP-BTN-COM2-166"]	= short_way_button(_("ICP COM Override Button, COM2(VHF)"),										devices.UFC, ufc_commands.COM2,				166)
elements["PTR-ICP-BTN-IFF-167"]		= short_way_button(_("ICP IFF Override Button, IFF"),											devices.UFC, ufc_commands.IFF,				167)
elements["PTR-ICP-BTN-LIST-168"]	= short_way_button(_("ICP LIST Override Button, LIST"),											devices.UFC, ufc_commands.LIST,				168)
elements["PTR-ICP-BTN-AA-169"]		= short_way_button(_("ICP Master Mode Button, A-A"),											devices.UFC, ufc_commands.AA,				169)
elements["PTR-ICP-BTN-AG-170"]		= short_way_button(_("ICP Master Mode Button, A-G"),											devices.UFC, ufc_commands.AG,				170)
elements["PTR-ICP-BTN-RCL-174"]		= short_way_button(_("ICP Recall Button, RCL"),													devices.UFC, ufc_commands.RCL,				174)
elements["PTR-ICP-BTN-ENTR-178"]	= short_way_button(_("ICP Enter Button, ENTR"),													devices.UFC, ufc_commands.ENTR,				178)
elements["PTR-ICP-LVR-RET-192"]		= default_axis_limited_1_side(_("ICP Reticle Depression Control Knob"),							devices.UFC, ufc_commands.RET_DEPR_Knob,	192,nil,nil,nil,nil,nil, {0,135},{0,-90})
elements["PTR-ICP-LVR-CONT-193"]	= default_axis_limited_1_side(_("ICP Raster Contrast Knob"),									devices.UFC, ufc_commands.CONT_Knob,		193,nil,nil,nil,nil,nil, {0,135},{0,-90})
elements["PTR-ICP-LVR-BRT-191"]		= default_axis_limited_1_side(_("ICP Raster Intensity Knob"),									devices.UFC, ufc_commands.BRT_Knob,			191,nil,nil,nil,nil,nil, {0,90},{0,-135})
elements["PTR-ICP-LVR-SYM-190"]		= default_axis_limited_1_side(_("ICP HUD Symbology Intensity Knob"),							devices.UFC, ufc_commands.SYM_Knob,			190,nil,nil,nil,nil,nil, {0,90},{0,-135})
elements["PTR-ICP-BTN-WX-187"]		= short_way_button(_("ICP FLIR Polarity Button, Wx"),											devices.UFC, ufc_commands.Wx,				187)
elements["PTR-ICP-TMB-GAIN-189"]	= default_3_position_tumb_small(_("ICP FLIR GAIN/LEVEL Switch, GAIN/LVL/AUTO"),					devices.UFC, ufc_commands.FLIR_GAIN_Sw,		189)
elements["PTR-ICP-RS-OFF-UP-183"]	= Rocker_switch_positive(_("ICP DED Increment/Decrement Switch, Up"),							devices.UFC, ufc_commands.DED_INC,			183)
elements["PTR-ICP-RS-OFF-DN-183"]	= Rocker_switch_negative(_("ICP DED Increment/Decrement Switch, Down"),							devices.UFC, ufc_commands.DED_DEC,			183)
elements["PTR-ICP-RS-FLIR-UP-188"]	= Rocker_switch_positive(_("ICP FLIR Increment/Decrement Switch, Up"),							devices.UFC, ufc_commands.FLIR_INC,			188)
elements["PTR-ICP-RS-FLIR-DN-188"]	= Rocker_switch_negative(_("ICP FLIR Increment/Decrement Switch, Down"),						devices.UFC, ufc_commands.FLIR_DEC,			188)
elements["PTR-ICP-TMB-DRIFT-186"]	= default_button_tumb(_("ICP DRIFT CUTOUT/WARN RESET Switch, DRIFT C/O /NORM/WARN RESET"),	    devices.UFC, ufc_commands.WARN_RESET, ufc_commands.DRIFT_CUTOUT, 186)

elements["PTR-ICP-TMB-RTN-184"]			= springloaded_2_pos_tumb_small(_("ICP Data Control Switch, RTN"),	devices.UFC, ufc_commands.DCS_RTN,	184)
elements["PTR-ICP-TMB-RTN-184"].arg_value	= {-1, -1} 
elements["PTR-ICP-TMB-RTN-184"].arg_lim		= {{-1,0},{-1,0}}
elements["PTR-ICP-TMB-RTN-184"].side	    = {{BOX_SIDE_Y_bottom},{BOX_SIDE_Y_bottom}}
elements["PTR-ICP-TMB-RTN-184"].sound = {{SOUND_SW4_OFF, SOUND_SW4_ON}}
elements["PTR-ICP-TMB-SEQ-184"]			= springloaded_2_pos_tumb_small(_("ICP Data Control Switch, SEQ"),	devices.UFC, ufc_commands.DCS_SEQ,	184)
elements["PTR-ICP-TMB-SEQ-184"].side	    = {{BOX_SIDE_Y_bottom},{BOX_SIDE_Y_bottom}}
elements["PTR-ICP-TMB-SEQ-184"].sound = {{SOUND_SW4_ON, SOUND_SW4_OFF}}
elements["PTR-ICP-TMB-RTNSEQ-UP-185"]	= springloaded_2_pos_tumb_small(_("ICP Data Control Switch, UP"),	devices.UFC, ufc_commands.DCS_UP,	185)
elements["PTR-ICP-TMB-RTNSEQ-UP-185"].side	    = {{BOX_SIDE_Y_bottom},{BOX_SIDE_Y_bottom}}
elements["PTR-ICP-TMB-RTNSEQ-UP-185"].sound = {{SOUND_SW4_ON, SOUND_SW4_OFF}}
elements["PTR-ICP-TMB-RTNSEQ-DN-185"]	= springloaded_2_pos_tumb_small(_("ICP Data Control Switch, DN"),	devices.UFC, ufc_commands.DCS_DOWN,	185)
elements["PTR-ICP-TMB-RTNSEQ-DN-185"].arg_value	= {-1, -1}
elements["PTR-ICP-TMB-RTNSEQ-DN-185"].arg_lim	= {{-1,0},{-1,0}}
elements["PTR-ICP-TMB-RTNSEQ-DN-185"].side	    = {{BOX_SIDE_Y_bottom},{BOX_SIDE_Y_bottom}}
elements["PTR-ICP-TMB-RTNSEQ-DN-185"].sound = {{SOUND_SW4_OFF, SOUND_SW4_ON}}

elements["PTR-CPBC-BTN-FACK-122"]		= short_way_button(_("F-ACK Button"),							devices.UFC, ufc_commands.F_ACK,		122)
elements["PTR-CPBC-BTN-IFF-125"]		= short_way_button(_("IFF IDENT Button"),						devices.UFC, ufc_commands.IFF_IDENT,	125)
elements["PTR-CLCP-TMB-RF-100"]			= default_3_position_tumb(_("RF Switch, SILENT/QUIET/NORM"),	devices.UFC, ufc_commands.RF_Sw,		100)

-- HUD Remote Control Panel
elements["PTR-RHUD-TMB-WVAH-675"]	= default_3_position_tumb_small(_("HUD Scales Switch, VV/VAH / VAH / OFF"),						devices.MMC, mmc_commands.VvVah,	675)
elements["PTR-RHUD-TMB-ATT-676"]	= default_3_position_tumb_small(_("HUD Flightpath Marker Switch, ATT/FPM / FPM / OFF"),			devices.MMC, mmc_commands.AttFpm,	676)
elements["PTR-RHUD-TMB-DED-677"]	= default_3_position_tumb_small(_("HUD DED/PFLD Data Switch, DED / PFL / OFF"),				devices.MMC, mmc_commands.DedData,	677)
elements["PTR-RHUD-TMB-DEPR-678"]	= default_3_position_tumb(_("HUD Depressible Reticle Switch, STBY / PRI / OFF"),			devices.MMC, mmc_commands.DeprRet,	678)
elements["PTR-RHUD-TMB-CAS-679"]	= default_3_position_tumb_small(_("HUD Velocity Switch, CAS / TAS / GND SPD"),				devices.MMC, mmc_commands.Spd,		679)
elements["PTR-RHUD-TMB-ALT-680"]	= default_3_position_tumb_small(_("HUD Altitude Switch, RADAR / BARO / AUTO"),				devices.MMC, mmc_commands.Alt,		680)
elements["PTR-RHUD-TMB-DAYNGT-681"]	= default_3_position_tumb_small(_("HUD Brightness Control Switch, DAY / AUTO BRT / NIGHT"),	devices.MMC, mmc_commands.Brt,		681)
elements["PTR-RHUD-TMB-TEST-682"]	= default_3_position_tumb_small(_("HUD TEST Switch, STEP / ON / OFF"),						devices.MMC, mmc_commands.Test,		682)

-- Audio Control Panels
elements["PTR-AUDIO1-TMB-COMM1-434"]	= multiposition_switch(_("COMM 1 (UHF) Mode Knob"),											devices.INTERCOM, intercom_commands.COM1_ModeKnob,		434, 3, 0.5, NOT_INVERSED, 0.0, anim_speed_default, NOT_CYCLED, {100,-30}, {-70,-45})
elements["PTR-AUDIO1-TMB-COMM2-435"]	= multiposition_switch(_("COMM 2 (VHF) Mode Knob"),											devices.INTERCOM, intercom_commands.COM2_ModeKnob,		435, 3, 0.5, NOT_INVERSED, 0.0, anim_speed_default, NOT_CYCLED, {100,-30}, {-70,-45})
elements["PTR-AUDIO1-LVR-COMM1-430"]	= default_axis_limited(_("COMM 1 Power Knob"),												devices.INTERCOM, intercom_commands.COM1_PowerKnob,		430,nil,nil,nil,nil,nil, {100,-30}, {-70,-45})
elements["PTR-AUDIO1-LVR-COMM2-431"]	= default_axis_limited(_("COMM 2 Power Knob"),												devices.INTERCOM, intercom_commands.COM2_PowerKnob,		431,nil,nil,nil,nil,nil, {100,-30}, {-70,-45})
elements["PTR-AUDIO1-LVR-SV-432"]		= default_axis_limited(_("SECURE VOICE Knob"),												devices.INTERCOM, intercom_commands.SecureVoiceKnob,	432,nil,nil,nil,nil,nil, {100,-30}, {-100,-45})
elements["PTR-AUDIO1-LVR-MSL-433"]		= default_axis_limited(_("MSL Tone Knob"),													devices.INTERCOM, intercom_commands.MSL_ToneKnob,		433,nil,nil,nil,nil,nil, {110,-30}, {-110,-45})
elements["PTR-AUDIO1-LVR-TF-436"]		= default_axis_limited(_("TF Tone Knob"),													devices.INTERCOM, intercom_commands.TF_ToneKnob,		436,nil,nil,nil,nil,nil, {100,-30}, {-100,-45})
elements["PTR-AUDIO1-LVR-THREAT-437"]	= default_axis_limited(_("THREAT Tone Knob"),												devices.INTERCOM, intercom_commands.THREAT_ToneKnob,	437,nil,nil,nil,nil,nil, {110,-30}, {-110,-45})
elements["PTR-AUDIO2-LVR-INTERCOM-440"]	= default_axis_limited(_("INTERCOM Knob"),													devices.INTERCOM, intercom_commands.INTERCOM_Knob,		440,nil,nil,nil,nil,nil, {100,-30}, {-70,-45})
elements["PTR-AUDIO2-LVR-TACAN-441"]	= default_axis_limited(_("TACAN Knob"),														devices.INTERCOM, intercom_commands.TACAN_Knob,			441,nil,nil,nil,nil,nil, {100,-30}, {-70,-45})
elements["PTR-AUDIO2-LVR-ILS-442"]		= default_axis_limited(_("ILS Power Knob"),													devices.INTERCOM, intercom_commands.ILS_PowerKnob,		442,nil,nil,nil,nil,nil, {100,-30}, {-100,-45})
elements["PTR-AUDIO2-TMB-MODE-443"]		= default_3_position_tumb_small(_("HOT MIC CIPHER Switch, HOT MIC / OFF / CIPHER"),			devices.INTERCOM, intercom_commands.HotMicCipherSw,		443)
elements["PTR-ZROIZE-TMB-VOICE-696"]	= default_2_position_tumb_small(_("Voice Message Inhibit Switch, VOICE MESSAGE/INHIBIT"),	devices.INTERCOM, intercom_commands.VMS_InhibitSw,		696)
elements["PTR-ANTICE-TMB-IFF-711"]		= default_3_position_tumb_small(_("IFF ANT SEL Switch, LOWER/NORM/UPPER"),					devices.INTERCOM, intercom_commands.IFF_AntSelSw,		711)
elements["PTR-ANTICE-TMB-UHF-712"]		= default_3_position_tumb_small(_("UHF ANT SEL Switch, LOWER/NORM/UPPER"),					devices.INTERCOM, intercom_commands.UHF_AntSelSw,		712)

-- UHF Backup Control Panel
elements["PTR-ANARC164-CHNL-SELECTOR-410"]		= multiposition_switch_tumb(_("UHF CHAN Knob"),							devices.UHF_CONTROL_PANEL, uhf_commands.ChannelKnob,			410, 20, 0.05, NOT_INVERSED, 0.0, anim_speed_default * 0.05, NOT_CYCLED)
elements["PTR-ANARC164-100MHZ-SEL-411"]			= multiposition_switch_tumb(_("UHF Manual Frequency Knob 100 MHz"),		devices.UHF_CONTROL_PANEL, uhf_commands.FreqSelector100Mhz,		411,  3,  0.1, NOT_INVERSED, 0.1, anim_speed_default *  0.1, NOT_CYCLED)
elements["PTR-ANARC164-10MHZ-SEL-412"]			= multiposition_switch_tumb(_("UHF Manual Frequency Knob 10 MHz"),		devices.UHF_CONTROL_PANEL, uhf_commands.FreqSelector10Mhz,		412, 10,  0.1, NOT_INVERSED, 0.0, anim_speed_default *  0.1, NOT_CYCLED)
elements["PTR-ANARC164-1MHZ-SEL-413"]			= multiposition_switch_tumb(_("UHF Manual Frequency Knob 1 MHz"),		devices.UHF_CONTROL_PANEL, uhf_commands.FreqSelector1Mhz,		413, 10,  0.1, NOT_INVERSED, 0.0, anim_speed_default *  0.1, NOT_CYCLED)
elements["PTR-ANARC164-0.1MHZ-SEL-414"]			= multiposition_switch_tumb(_("UHF Manual Frequency Knob 0.1 MHz"),		devices.UHF_CONTROL_PANEL, uhf_commands.FreqSelector01Mhz,		414, 10,  0.1, NOT_INVERSED, 0.0, anim_speed_default *  0.1, NOT_CYCLED)
elements["PTR-ANARC164-0.025MHZ-SEL-415"]		= multiposition_switch_tumb(_("UHF Manual Frequency Knob 0.025 MHz"),	devices.UHF_CONTROL_PANEL, uhf_commands.FreqSelector0025Mhz,	415,  4, 0.25, NOT_INVERSED, 0.0, anim_speed_default *  0.1, NOT_CYCLED)
elements["PTR-ANARC164-FUNCTION-417"]			= multiposition_switch(_("UHF Function Knob"),						devices.UHF_CONTROL_PANEL, uhf_commands.FunctionKnob,			417,  4,  0.1, NOT_INVERSED, 0.0, anim_speed_default *  0.1, NOT_CYCLED, {100,-30}, {-70,-45})
elements["PTR-ANARC164-FREQMODE-416"]			= multiposition_switch(_("UHF Mode Knob"),							devices.UHF_CONTROL_PANEL, uhf_commands.FreqModeKnob,			416,  3,  0.1, NOT_INVERSED, 0.0, anim_speed_default *  0.1, NOT_CYCLED, {110,-30}, {-100,-45})
elements["PTR-ANARC164-T-TONE-418"]				= default_button(_("UHF Tone Button"),								devices.UHF_CONTROL_PANEL, uhf_commands.TToneSw,				418)
elements["PTR-ANARC164-T-TONE-418"].sound 	= {{SOUND_SW3, SOUND_SW3_OFF}, {SOUND_SW3, SOUND_SW3_OFF}}
elements["PTR-ANARC164-SQUELCH-419"]			= default_2_position_tumb_small(_("UHF SQUELCH Switch"),			devices.UHF_CONTROL_PANEL, uhf_commands.SquelchSw,				419)
elements["PTR-ANARC164-VOLUME-420"]				= default_axis_limited(_("UHF VOL Knob"),							devices.UHF_CONTROL_PANEL, uhf_commands.VolumeKnob,				420,nil,nil,nil,nil,nil, {100,-30}, {-90,-45})
elements["PTR-ANARC164-TEST-DISPLAY-421"]		= default_button(_("UHF TEST DISPLAY Button"),						devices.UHF_CONTROL_PANEL, uhf_commands.TestDisplayBtn,			421)
elements["PTR-ANARC164-STATUS-422"]				= default_button(_("UHF STATUS Button"),							devices.UHF_CONTROL_PANEL, uhf_commands.StatusBtn,				422)
elements["PTR_ANARC164-CHNL-SELECTOR01-734"]	= default_2_position_tumb(_("Access Door, OPEN/CLOSE"),				devices.UHF_CONTROL_PANEL, uhf_commands.AccessDoor,				734, anim_speed_default * 0.5)
elements["PTR_ANARC164-CHNL-SELECTOR01-734"].side = {{BOX_SIDE_Y_top},{BOX_SIDE_Y_bottom}}

-- IFF Control Panel
 elements["PTR-AUXCOM-TMB-CNI-542"]		= multiposition_switch(_("C & I Knob, UFC/BACKUP"),							devices.IFF_CONTROL_PANEL, iff_commands.CNI_Knob,		542, 2, 1, NOT_INVERSED, 0.0, anim_speed_default, NOT_CYCLED, nil, {45,-45})
elements["PTR-AUXCOM-LVR-MODE-540"]		= multiposition_switch(_("IFF MASTER Knob, OFF/STBY/LOW/NORM/EMER"),		devices.IFF_CONTROL_PANEL, iff_commands.MasterKnob,		540, 5, 0.1, NOT_INVERSED, 0.0, anim_speed_default * 0.1, NOT_CYCLED, nil, {45,-45})
elements["PTR-AUXCOM-TMB-M4-541"]		= default_3_position_tumb(_("IFF M-4 CODE Switch, HOLD/ A/B /ZERO"),		devices.IFF_CONTROL_PANEL, iff_commands.M4CodeSw,		541)
elements["PTR-AUXCOM-TMB-REPLY-543"]	= default_3_position_tumb(_("IFF MODE 4 REPLY Switch, OUT/A/B"),			devices.IFF_CONTROL_PANEL, iff_commands.M4ReplySw,		543)
elements["PTR-AUXCOM-TMB-MONITOR-544"]	= default_2_position_tumb_small(_("IFF MODE 4 MONITOR Switch, OUT/AUDIO"),	devices.IFF_CONTROL_PANEL, iff_commands.M4MonitorSw,	544)
elements["PTR-AUXCOM-TMB-TACAN-553"]	= default_3_position_tumb_small(_("IFF ENABLE Switch, M1/M3 /OFF/ M3/MS"),	devices.IFF_CONTROL_PANEL, iff_commands.EnableSw,		553)

elements["PTR-AUXCOM-TMB-CHNL1-545"]	= springloaded_3_pos_tumb(_("IFF MODE 1 Selector Lever, DIGIT 1"),		devices.IFF_CONTROL_PANEL, iff_commands.M1M3Selector1_Dec, iff_commands.M1M3Selector1_Inc, 545)
elements["PTR-AUXCOM-TMB-CHNL1-545"].sound = {{SOUND_SW5_OFF, SOUND_SW7}, {SOUND_SW7, SOUND_SW5_OFF}}
elements["PTR-AUXCOM-TMB-CHNL2-547"]	= springloaded_3_pos_tumb(_("IFF MODE 1 Selector Lever, DIGIT 2"),		devices.IFF_CONTROL_PANEL, iff_commands.M1M3Selector2_Dec, iff_commands.M1M3Selector2_Inc, 547)
elements["PTR-AUXCOM-TMB-CHNL2-547"].sound = {{SOUND_SW5_OFF, SOUND_SW7}, {SOUND_SW7, SOUND_SW5_OFF}}
elements["PTR-AUXCOM-TMB-CHNL3-549"]	= springloaded_3_pos_tumb(_("IFF MODE 3 Selector Lever, DIGIT 1"),		devices.IFF_CONTROL_PANEL, iff_commands.M1M3Selector3_Dec, iff_commands.M1M3Selector3_Inc, 549)
elements["PTR-AUXCOM-TMB-CHNL3-549"].sound = {{SOUND_SW5_OFF, SOUND_SW7}, {SOUND_SW7, SOUND_SW5_OFF}}
elements["PTR-AUXCOM-TMB-CHNL4-551"]	= springloaded_3_pos_tumb(_("IFF MODE 3 Selector Lever, DIGIT 2"),		devices.IFF_CONTROL_PANEL, iff_commands.M1M3Selector4_Dec, iff_commands.M1M3Selector4_Inc, 551)
elements["PTR-AUXCOM-TMB-CHNL4-551"].sound = {{SOUND_SW5_OFF, SOUND_SW7}, {SOUND_SW7, SOUND_SW5_OFF}}

-- KY-58
elements["PTR-KY58-LVR-MODE1-705"]		= multiposition_switch(_("KY-58 MODE Knob, P/C/LD/RV"),						devices.KY58, ky58_commands.KY58_ModeSw,			705, 4, 0.1, NOT_INVERSED, 0.0, anim_speed_default * 0.1, NOT_CYCLED, {135,-30}, {45,-30})
elements["PTR-KY58-LVR-VOL-708"]		= default_axis_limited(_("KY-58 VOLUME Knob"),								devices.KY58, ky58_commands.KY58_Volume,			708, 0.0, 0.1, false, false, {0,1}, {135,-30}, {45,-30})
elements["PTR-KY58-LVR-MODE2-706"]		= multiposition_switch(_("KY-58 FILL Knob, Z 1-5/1/2/3/4/5/6/Z ALL"),		devices.KY58, ky58_commands.KY58_FillSw,			706, 8, 0.1, NOT_INVERSED, 0.0, anim_speed_default * 0.1, NOT_CYCLED, {135,-30}, {45,-30})
elements["PTR-KY58-LVR-MODE3-707"]		= multiposition_switch(_("KY-58 Power Knob, OFF/ON/TD"),					devices.KY58, ky58_commands.KY58_PowerSw,			707, 3, 0.5, NOT_INVERSED, 0.0, anim_speed_default * 0.5, NOT_CYCLED, {135,-30}, {45,-30})

elements["PTR-NUCLR-TMB-PLAIN-701"]		= default_3_position_tumb_small(_("PLAIN Cipher Switch, CRAD 1/PLAIN/CRAD 2"),	devices.INTERCOM, intercom_commands.PlainCipherSw,	701)
elements["PTR-ZROIZE-CVR-ZERO-694"]		= default_red_cover(_("ZEROIZE Switch Cover, OPEN/CLOSE"),					devices.INTERCOM, intercom_commands.ZeroizeSwCvr,	    694)
elements["PTR-ZROIZE-TMB-ZERO-695"]		= default_3_position_tumb_small(_("ZEROIZE Switch, OFP/OFF/DATA"),				devices.INTERCOM, intercom_commands.ZeroizeSw,		695)

-- HMCS
elements["PTR-HMDP-LVR-SMBINT-392"]		= default_axis_limited(_("HMCS SYMBOLOGY INT Knob"),	devices.HMCS, hmcs_commands.IntKnob,	392,nil,nil,nil,nil,nil,{100, -60}, {-45,-55})

-- RWR
elements["PTR-CMSC-LVR-BRT-140"]	= default_axis_limited(_("RWR Intensity Knob - Rotate to adjust brightness"),	devices.RWR, rwr_commands.IntKnob,		140, 0, 0.1, NOT_UPDATABLE, NOT_RELATIVE, {0, 0.8},{95, -35},{80, -35})
elements["PTR-CMSC-BTN-HNDOFF-141"]	= short_way_button(_("RWR Indicator Control HANDOFF Button"),					devices.RWR, rwr_commands.Handoff,		141)
elements["PTR-CMSC-BTN-LNCH-143"]	= short_way_button(_("RWR Indicator Control LAUNCH Button"),					devices.RWR, rwr_commands.Launch,		143)
elements["PTR-CMSC-BTN-MODE-145"]	= short_way_button(_("RWR Indicator Control MODE Button"),						devices.RWR, rwr_commands.Mode,			145)
elements["PTR-CMSC-BTN-OBJ-147"]	= short_way_button(_("RWR Indicator Control UNKNOWN SHIP Button"),				devices.RWR, rwr_commands.UnknownShip,	147)
elements["PTR-CMSC-BTN-STEST-149"]	= short_way_button(_("RWR Indicator Control SYS TEST Button"),					devices.RWR, rwr_commands.SysTest,		149)
elements["PTR-CMSC-BTN-T-151"]		= short_way_button(_("RWR Indicator Control T Button"),							devices.RWR, rwr_commands.TgtSep,		151)

elements["PTR-TWAP-LVR-DIM-404"]	= default_axis_limited(_("RWR Indicator Control DIM Knob - Rotate to adjust brightness"),	devices.RWR, rwr_commands.BrtKnob,		404,nil,nil,nil,nil,nil,{100, -60})
elements["PTR-TWAP-BTN-SRCH-395"]	= short_way_button(_("RWR Indicator Control SEARCH Button"),								devices.RWR, rwr_commands.Search,		395)
elements["PTR-TWAP-BTN-ACTPWR-397"]	= short_way_button(_("RWR Indicator Control ACT/PWR Button"),								devices.RWR, rwr_commands.ActPwr,		397)
elements["PTR-TWAP-BTN-ALT-399"]	= short_way_button(_("RWR Indicator Control ALTITUDE Button"),								devices.RWR, rwr_commands.Altitude,		399)
elements["PTR-TWAP-BTN-PWR-401"]	= default_2_position_tumb(_("RWR Indicator Control POWER Button"),							devices.RWR, rwr_commands.Power,		401)
elements["PTR-TWAP-BTN-PWR-401"].sound    = {{SOUND_SW4_ON, SOUND_SW4_OFF}}
elements["PTR-TWAP-BTN-PWR-401"].class_vr = {class_type.BTN_FIX}
elements["PTR-TWAP-BTN-PWR-401"].side     = {{BOX_SIDE_Y_bottom}}

-- CMDS
elements["PTR-LSIDE-BTN-CHAFF-604"]		= default_button(_("CHAFF/FLARE Dispense Button - Push to dispense"),			devices.CMDS, cmds_commands.DispBtn,	604)
elements["PTR-LPAN-CMDS-TMB-RWR-375"]	= default_2_position_tumb_small(_("RWR 555 Switch, ON/OFF"),					devices.CMDS, cmds_commands.RwrSrc,		375)
elements["PTR-LPAN-CMDS-TMB-JMR-374"]	= default_2_position_tumb_small(_("JMR Source Switch, ON/OFF"),					devices.CMDS, cmds_commands.JmrSrc,		374)
elements["PTR-LPAN-CMDS-TMB-MWS-373"]	= default_2_position_tumb_small(_("MWS Source Switch, ON/OFF (no function)"),	devices.CMDS, cmds_commands.MwsSrc,		373)
elements["PTR-LPAN-CMDS-TMB-JTSN-371"]	= default_2_position_tumb(_("Jettison Switch, JETT/OFF"),						devices.CMDS, cmds_commands.Jett,		371)
elements["PTR-LPAN-CMDS-BTN-OSB1-365"]	= default_2_position_tumb_small(_("O1 Expendable Category Switch, ON/OFF"),		devices.CMDS, cmds_commands.O1Exp,		365)
elements["PTR-LPAN-CMDS-BTN-OSB2-366"]	= default_2_position_tumb_small(_("O2 Expendable Category Switch, ON/OFF"),		devices.CMDS, cmds_commands.O2Exp,		366)
elements["PTR-LPAN-CMDS-BTN-OSB3-367"]	= default_2_position_tumb_small(_("CH Expendable Category Switch, ON/OFF"),		devices.CMDS, cmds_commands.ChExp,		367)
elements["PTR-LPAN-CMDS-BTN-OSB4-368"]	= default_2_position_tumb_small(_("FL Expendable Category Switch, ON/OFF"),		devices.CMDS, cmds_commands.FlExp,		368)
elements["PTR-LPAN-CMDS-LVR-PRGM-377"]	= multiposition_switch(_("PROGRAM Knob, BIT/1/2/3/4"),					devices.CMDS, cmds_commands.Prgm,	377, 5, 0.1, NOT_INVERSED, 0.0, anim_speed_default, NOT_CYCLED, {100, -60}, {-45,-55})
elements["PTR-LPAN-CMDS-LVR-MODE-378"]	= multiposition_switch(_("MODE Knob, OFF/STBY/MAN/SEMI/AUTO/BYP"),		devices.CMDS, cmds_commands.Mode,	378, 6, 0.1, NOT_INVERSED, 0.0, anim_speed_default, NOT_CYCLED, {120, -60}, {-45,-55})

-- MFD Left
elements["PTR-LMFCD-BTN-OSB1-300"]		= mfd_button(_("Left MFD OSB 1"),											devices.MFD_LEFT, mfd_commands.OSB_1,				300)
elements["PTR-LMFCD-BTN-OSB2-301"]		= mfd_button(_("Left MFD OSB 2"),											devices.MFD_LEFT, mfd_commands.OSB_2,				301)
elements["PTR-LMFCD-BTN-OSB3-302"]		= mfd_button(_("Left MFD OSB 3"),											devices.MFD_LEFT, mfd_commands.OSB_3,				302)
elements["PTR-LMFCD-BTN-OSB4-303"]		= mfd_button(_("Left MFD OSB 4"),											devices.MFD_LEFT, mfd_commands.OSB_4,				303)
elements["PTR-LMFCD-BTN-OSB5-304"]		= mfd_button(_("Left MFD OSB 5"),											devices.MFD_LEFT, mfd_commands.OSB_5,				304)
elements["PTR-LMFCD-BTN-OSB6-305"]		= mfd_button(_("Left MFD OSB 6"),											devices.MFD_LEFT, mfd_commands.OSB_6,				305)
elements["PTR-LMFCD-BTN-OSB7-306"]		= mfd_button(_("Left MFD OSB 7"),											devices.MFD_LEFT, mfd_commands.OSB_7,				306)
elements["PTR-LMFCD-BTN-OSB8-307"]		= mfd_button(_("Left MFD OSB 8"),											devices.MFD_LEFT, mfd_commands.OSB_8,				307)
elements["PTR-LMFCD-BTN-OSB9-308"]		= mfd_button(_("Left MFD OSB 9"),											devices.MFD_LEFT, mfd_commands.OSB_9,				308)
elements["PTR-LMFCD-BTN-OSB10-309"]		= mfd_button(_("Left MFD OSB 10"),											devices.MFD_LEFT, mfd_commands.OSB_10,				309)
elements["PTR-LMFCD-BTN-OSB11-310"]		= mfd_button(_("Left MFD OSB 11"),											devices.MFD_LEFT, mfd_commands.OSB_11,				310)
elements["PTR-LMFCD-BTN-OSB12-311"]		= mfd_button(_("Left MFD OSB 12"),											devices.MFD_LEFT, mfd_commands.OSB_12,				311)
elements["PTR-LMFCD-BTN-OSB13-312"]		= mfd_button(_("Left MFD OSB 13"),											devices.MFD_LEFT, mfd_commands.OSB_13,				312)
elements["PTR-LMFCD-BTN-OSB14-313"]		= mfd_button(_("Left MFD OSB 14"),											devices.MFD_LEFT, mfd_commands.OSB_14,				313)
elements["PTR-LMFCD-BTN-OSB15-314"]		= mfd_button(_("Left MFD OSB 15"),											devices.MFD_LEFT, mfd_commands.OSB_15,				314)
elements["PTR-LMFCD-BTN-OSB16-315"]		= mfd_button(_("Left MFD OSB 16"),											devices.MFD_LEFT, mfd_commands.OSB_16,				315)
elements["PTR-LMFCD-BTN-OSB17-316"]		= mfd_button(_("Left MFD OSB 17"),											devices.MFD_LEFT, mfd_commands.OSB_17,				316)
elements["PTR-LMFCD-BTN-OSB18-317"]		= mfd_button(_("Left MFD OSB 18"),											devices.MFD_LEFT, mfd_commands.OSB_18,				317)
elements["PTR-LMFCD-BTN-OSB19-318"]		= mfd_button(_("Left MFD OSB 19"),											devices.MFD_LEFT, mfd_commands.OSB_19,				318)
elements["PTR-LMFCD-BTN-OSB20-319"]		= mfd_button(_("Left MFD OSB 20"),											devices.MFD_LEFT, mfd_commands.OSB_20,				319)
elements["PTR-LMFCD-RS-GAIN-UP-320"]	= Rocker_switch_positive(_("Left MFD GAIN Rocker Switch, Up/Increase"),		devices.MFD_LEFT, mfd_commands.GAIN_Rocker_UP, 		320)
elements["PTR-LMFCD-RS-GAIN-DN-320"]	= Rocker_switch_negative(_("Left MFD GAIN Rocker Switch, Down/Decrease"),	devices.MFD_LEFT, mfd_commands.GAIN_Rocker_DOWN, 	320)
elements["PTR-LMFCD-RS-SYM-UP-321"]		= Rocker_switch_positive(_("Left MFD SYM Rocker Switch, Up/Increase"),		devices.MFD_LEFT, mfd_commands.SYM_Rocker_UP, 		321)
elements["PTR-LMFCD-RS-SYM-DN-321"]		= Rocker_switch_negative(_("Left MFD SYM Rocker Switch, Down/Decrease"),	devices.MFD_LEFT, mfd_commands.SYM_Rocker_DOWN, 	321)
elements["PTR-LMFCD-RS-CON-UP-322"]		= Rocker_switch_positive(_("Left MFD CON Rocker Switch, Up/Increase"),		devices.MFD_LEFT, mfd_commands.CON_Rocker_UP, 		322)
elements["PTR-LMFCD-RS-CON-DN-322"]		= Rocker_switch_negative(_("Left MFD CON Rocker Switch, Down/Decrease"),	devices.MFD_LEFT, mfd_commands.CON_Rocker_DOWN, 	322)
elements["PTR-LMFCD-RS-BRT-UP-323"]		= Rocker_switch_positive(_("Left MFD BRT Rocker Switch, Up/Increase"),		devices.MFD_LEFT, mfd_commands.BRT_Rocker_UP, 		323)
elements["PTR-LMFCD-RS-BRT-DN-323"]		= Rocker_switch_negative(_("Left MFD BRT Rocker Switch, Down/Decrease"),	devices.MFD_LEFT, mfd_commands.BRT_Rocker_DOWN, 	323)

-- MFD Right
elements["PTR-RMFCD-BTN-OSB1-326"]		= mfd_button(_("Right MFD OSB 1"),											devices.MFD_RIGHT, mfd_commands.OSB_1,				326)
elements["PTR-RMFCD-BTN-OSB2-327"]		= mfd_button(_("Right MFD OSB 2"),											devices.MFD_RIGHT, mfd_commands.OSB_2,				327)
elements["PTR-RMFCD-BTN-OSB3-328"]		= mfd_button(_("Right MFD OSB 3"),											devices.MFD_RIGHT, mfd_commands.OSB_3,				328)
elements["PTR-RMFCD-BTN-OSB4-329"]		= mfd_button(_("Right MFD OSB 4"),											devices.MFD_RIGHT, mfd_commands.OSB_4,				329)
elements["PTR-RMFCD-BTN-OSB5-330"]		= mfd_button(_("Right MFD OSB 5"),											devices.MFD_RIGHT, mfd_commands.OSB_5,				330)
elements["PTR-RMFCD-BTN-OSB6-331"]		= mfd_button(_("Right MFD OSB 6"),											devices.MFD_RIGHT, mfd_commands.OSB_6,				331)
elements["PTR-RMFCD-BTN-OSB7-332"]		= mfd_button(_("Right MFD OSB 7"),											devices.MFD_RIGHT, mfd_commands.OSB_7,				332)
elements["PTR-RMFCD-BTN-OSB8-333"]		= mfd_button(_("Right MFD OSB 8"),											devices.MFD_RIGHT, mfd_commands.OSB_8,				333)
elements["PTR-RMFCD-BTN-OSB9-334"]		= mfd_button(_("Right MFD OSB 9"),											devices.MFD_RIGHT, mfd_commands.OSB_9,				334)
elements["PTR-RMFCD-BTN-OSB10-335"]		= mfd_button(_("Right MFD OSB 10"),											devices.MFD_RIGHT, mfd_commands.OSB_10,				335)
elements["PTR-RMFCD-BTN-OSB11-336"]		= mfd_button(_("Right MFD OSB 11"),											devices.MFD_RIGHT, mfd_commands.OSB_11,				336)
elements["PTR-RMFCD-BTN-OSB12-337"]		= mfd_button(_("Right MFD OSB 12"),											devices.MFD_RIGHT, mfd_commands.OSB_12,				337)
elements["PTR-RMFCD-BTN-OSB13-338"]		= mfd_button(_("Right MFD OSB 13"),											devices.MFD_RIGHT, mfd_commands.OSB_13,				338)
elements["PTR-RMFCD-BTN-OSB14-339"]		= mfd_button(_("Right MFD OSB 14"),											devices.MFD_RIGHT, mfd_commands.OSB_14,				339)
elements["PTR-RMFCD-BTN-OSB15-340"]		= mfd_button(_("Right MFD OSB 15"),											devices.MFD_RIGHT, mfd_commands.OSB_15,				340)
elements["PTR-RMFCD-BTN-OSB16-341"]		= mfd_button(_("Right MFD OSB 16"),											devices.MFD_RIGHT, mfd_commands.OSB_16,				341)
elements["PTR-RMFCD-BTN-OSB17-342"]		= mfd_button(_("Right MFD OSB 17"),											devices.MFD_RIGHT, mfd_commands.OSB_17,				342)
elements["PTR-RMFCD-BTN-OSB18-343"]		= mfd_button(_("Right MFD OSB 18"),											devices.MFD_RIGHT, mfd_commands.OSB_18,				343)
elements["PTR-RMFCD-BTN-OSB19-344"]		= mfd_button(_("Right MFD OSB 19"),											devices.MFD_RIGHT, mfd_commands.OSB_19,				344)
elements["PTR-RMFCD-BTN-OSB20-345"]		= mfd_button(_("Right MFD OSB 20"),											devices.MFD_RIGHT, mfd_commands.OSB_20,				345)
elements["PTR-RMFCD-RS-GAIN-UP-346"]	= Rocker_switch_positive(_("Left MFD GAIN Rocker Switch, Up/Increase"),		devices.MFD_RIGHT, mfd_commands.GAIN_Rocker_UP, 	346)
elements["PTR-RMFCD-RS-GAIN-DN-346"]	= Rocker_switch_negative(_("Left MFD GAIN Rocker Switch, Down/Decrease"),	devices.MFD_RIGHT, mfd_commands.GAIN_Rocker_DOWN, 	346)
elements["PTR-RMFCD-RS-SYM-UP-347"]		= Rocker_switch_positive(_("Left MFD SYM Rocker Switch, Up/Increase"),		devices.MFD_RIGHT, mfd_commands.SYM_Rocker_UP, 		347)
elements["PTR-RMFCD-RS-SYM-DN-347"]		= Rocker_switch_negative(_("Left MFD SYM Rocker Switch, Down/Decrease"),	devices.MFD_RIGHT, mfd_commands.SYM_Rocker_DOWN, 	347)
elements["PTR-RMFCD-RS-CON-UP-348"]		= Rocker_switch_positive(_("Left MFD CON Rocker Switch, Up/Increase"),		devices.MFD_RIGHT, mfd_commands.CON_Rocker_UP, 		348)
elements["PTR-RMFCD-RS-CON-DN-348"]		= Rocker_switch_negative(_("Left MFD CON Rocker Switch, Down/Decrease"),	devices.MFD_RIGHT, mfd_commands.CON_Rocker_DOWN, 	348)
elements["PTR-RMFCD-RS-BRT-UP-349"]		= Rocker_switch_positive(_("Left MFD BRT Rocker Switch, Up/Increase"),		devices.MFD_RIGHT, mfd_commands.BRT_Rocker_UP, 		349)
elements["PTR-RMFCD-RS-BRT-DN-349"]		= Rocker_switch_negative(_("Left MFD BRT Rocker Switch, Down/Decrease"),	devices.MFD_RIGHT, mfd_commands.BRT_Rocker_DOWN, 	349)

-- Instruments
-- Airspeed/Mach Indicator
elements["PTR-SPD-LVR-SET-71"]			= default_axis(_("SET INDEX Knob"), devices.AMI, ami_commands.SettingKnob, 71, 0, 0.05, true, true, true, {135,-45},{45,-45})
-- Altimeter
elements["PTR-ALT-LVR-SET-62"]			= default_axis(_("Barometric Setting Knob"),				devices.AAU34, alt_commands.ZERO, 62, 0.4, 0.2, true, true, true,{135,-45},{45,-45})
elements["PTR-ALT-TMB-MODE-60"]			= springloaded_3_pos_tumb(_("Mode Lever, ELEC/OFF/PNEU"),	devices.AAU34, alt_commands.ELEC, alt_commands.PNEU, 60)
elements["PTR-ALT-TMB-MODE-60"].sound 	= {{SOUND_SW3, SOUND_SW3_OFF}, {SOUND_SW3, SOUND_SW3_OFF}}

-- SAI ARU-42/A-2
elements["PTR-SAI-LVR-CAGE-P-66"] =
{
	class				= {class_type.BTN, class_type.LEV},
	hint				= _("SAI Cage Knob, (LMB) Pull to cage /(MW) Adjust aircraft reference symbol"),
	device				= devices.SAI,
	action				= {sai_commands.cage, sai_commands.reference},
	stop_action			= {sai_commands.cage, 0},
	is_repeatable		= {},
	arg					= {67, 66},
	arg_value			= {1.0, 1.0},
	arg_lim				= {{0, 1}, {0.375, 0.625}},
	relative			= {false, false},
	cycle				= false,
	gain				= {1.0, 0.02},
	use_release_message	= {true, false},
	sound				= {{SOUND_SW12}},
	use_OBB 			= true,
	side				= {{BOX_SIDE_Y_bottom},{BOX_SIDE_X_top, BOX_SIDE_X_bottom, BOX_SIDE_Z_top, BOX_SIDE_Z_bottom}},
	attach_left			= {90, -45},
	attach_right		= {45, -45}
}

-- ADI
elements["PTR-ADI-LVR-KNOB-22"]		= default_axis_limited(_("Pitch Trim Knob"),			devices.ADI, device_commands.Button_1, 22)

-- EHSI
elements["PTR-EHSI-LVR-CRS-44"]	= default_button_knob(_("CRS Set / Brightness Control Knob"),	devices.EHSI, ehsi_commands.RightKnobBtn, ehsi_commands.RightKnob, 43, 44)
elements["PTR-EHSI-LVR-CRS-44"].sound = {{SOUND_SW4_ON, SOUND_SW4_OFF}}
elements["PTR-EHSI-LVR-HDG-45"]	= default_button_knob(_("HDG Set Knob"),						devices.EHSI, ehsi_commands.LeftKnobBtn, ehsi_commands.LeftKnob, 42, 45)
elements["PTR-EHSI-LVR-HDG-45"].sound = {{SOUND_SW4_ON, SOUND_SW4_OFF}}
elements["PTR-EHSI-BTN-M-46"]	= default_button(_("Mode (M) Button"),							devices.EHSI, ehsi_commands.ModeBtn, 46)

-- Clock
elements["PTR-SNSR-TMB-RDR-674"] =
{
	class				= {class_type.BTN, class_type.LEV},
	hint				= _("Clock Winding and Setting Knob"), 
	device				= devices.CLOCK, 
	action				= {clock_commands.CLOCK_left_lev_up, clock_commands.CLOCK_left_lev_rotate}, 
	stop_action			= {clock_commands.CLOCK_left_lev_up, 0},
	is_repeatable		= {},
	arg					= {626, 625}, 
	arg_value			= {1.0, 0.04}, 
	arg_lim				= {{0, 1}, {0, 1}}, 
	relative			= {false,true}, 
	gain				= {1.0, 0.6}, 
	animated			= {true, false},
	animation_speed		= {anim_speed_default, 0.0},
	use_release_message	= {true, false}, 
	use_OBB				= true,
	sound				= {{SOUND_SW11}}
}

elements["PTR-RPAN-WATCH-BTN-CTRL-627"] = default_button(_("Clock Elapsed Time Knob"), devices.CLOCK, clock_commands.CLOCK_right_lev_down, 628)

-- Cockpit Mechanics
elements["PTR-LARMS-CNPOPN-600"]		= default_2_position_tumb(_("Canopy Handle, UP/DOWN"),					devices.CPT_MECH, cpt_commands.CanopyHandle, 600)
elements["PTR-LARMS-CNPOPN-600"].sound = {{SOUND_SW9_UP, SOUND_SW9_DOWN}}
elements["PTR-SEAT-TMB-ADJ-786"]		= springloaded_3_pos_tumb_small(_("SEAT ADJ Switch, UP/OFF/DOWN"),		devices.CPT_MECH, cpt_commands.SeatAdjSwitchDown, cpt_commands.SeatAdjSwitchUp, 786)
elements["PTR-LARMS-CNPJETT-601"]		= default_2_position_tumb(_("CANOPY JETTISON T-Handle, PULL/STOW"),		devices.CPT_MECH, cpt_commands.CanopyTHandle, 601)
elements["PTR-LARMS-CNPJETT-601"].sound = {{SOUND_SW11_UP, SOUND_SW11_DOWN}}
elements["PTR-SEAT-ARM-LOCK-785"]		= default_2_position_tumb(_("Ejection Safety Lever, ARMED/LOCKED"),		devices.CPT_MECH, cpt_commands.EjectionSafetyLever, 785)
elements["PTR-SEAT-ARM-LOCK-785"].sound = {{SOUND_SW10_DOWN,SOUND_SW10_UP}}
elements["PTR-LARMS-TMB-OPN-606"]		= default_button_tumb(_("Canopy Switch, OPEN/HOLD/CLOSE(momentarily)"),	devices.CPT_MECH, cpt_commands.CanopySwitchClose, cpt_commands.CanopySwitchOpen, 606)

elements["PTR-STICK-HIDE-796"]			= default_2_position_tumb(_("Hide Stick toggle"),						devices.CPT_MECH, cpt_commands.StickHide, 796)

-- ECM
elements["PTR-ECM-TMB-OPR-455"]			= default_3_position_tumb(_("ECM Power Switch"),						devices.ECM_INTERFACE, ecm_commands.PwrSw, 455, false, anim_speed_default, false)
elements["PTR-ECM-LVR-DIM-456"]			= default_axis_limited_1_side(_("ECM DIM Knob"),						devices.ECM_INTERFACE, ecm_commands.DimRotary, 456)
elements["PTR-ECM-TMB-XMIT-457"]		= default_3_position_tumb(_("ECM XMIT Switch"),							devices.ECM_INTERFACE, ecm_commands.XmitSw,	457, false, anim_speed_default, false)
elements["PTR-ECM-BTN-RESET-458"]		= default_button(_("ECM RESET Button"),									devices.ECM_INTERFACE, ecm_commands.ResetBtn, 458)
elements["PTR-ECM-BTN-BIT-459"]			= default_button(_("ECM BIT Button"),									devices.ECM_INTERFACE, ecm_commands.BitBtn, 459)
elements["PTR-ECM-BTN-1-460"]			= default_2_position_tumb(_("ECM 1 Button"),							devices.ECM_INTERFACE, ecm_commands.OneBtn, 460)
elements["PTR-ECM-BTN-2-465"]			= default_2_position_tumb(_("ECM 2 Button"),							devices.ECM_INTERFACE, ecm_commands.TwoBtn, 465)
elements["PTR-ECM-BTN-3-470"]			= default_2_position_tumb(_("ECM 3 Button"),							devices.ECM_INTERFACE, ecm_commands.ThreeBtn, 470)
elements["PTR-ECM-BTN-4-475"]			= default_2_position_tumb(_("ECM 4 Button"),							devices.ECM_INTERFACE, ecm_commands.FourBtn, 475)
elements["PTR-ECM-BTN-5-480"]			= default_2_position_tumb(_("ECM 5 Button"),							devices.ECM_INTERFACE, ecm_commands.FiveBtn, 480)
elements["PTR-ECM-BTN-6-485"]			= default_2_position_tumb(_("ECM 6 Button"),							devices.ECM_INTERFACE, ecm_commands.SixBtn, 485)
elements["PTR-ECM-BTN-FRM-490"]			= default_2_position_tumb(_("ECM FRM Button"),							devices.ECM_INTERFACE, ecm_commands.FrmBtn, 490)
elements["PTR-ECM-BTN-SPL-495"]			= default_2_position_tumb(_("ECM SPL Button"),							devices.ECM_INTERFACE, ecm_commands.SplBtn, 495)