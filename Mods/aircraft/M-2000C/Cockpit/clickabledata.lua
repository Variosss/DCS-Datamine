local gettext = require("i_18n")
_ = gettext.translate

dofile(LockOn_Options.script_path.."clickable_defs.lua")
dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."devices.lua")

elements = {}

-- Landing Gear
elements["PTN_404"]	= lever_2pos(_("Landing Gear Lever"),											devices.INSTPANEL,	cmds.Button_404, 404, {speed=5,sound="landing-gear"})
elements["PTN_408"]	= default_animated_lever(_("Landing Gear Emergency Release Lever"),				devices.INSTPANEL,	cmds.Button_408, 408)
elements["PTN_926"]	= push_button(_("Landing Gear Tone"),											devices.INSTPANEL,	cmds.Button_926, 926)

-- VTH
elements["PTN_201"] = lever_3pos(_("HUD Power Switch"),												devices.VTH,	cmds.Button_201, 201,	{sound="vth"})
elements["PTN_202"] = potentiometer(_("HUD Brightness Knob"),										devices.VTH,	cmds.Button_202, 202,	0,	0.1,	true,	false,	{0.0, 1.0})
elements["PTN_203"] = lever_mon_off_mon(_("HUD Declutter Switch"),									devices.VTH,	cmds.Button_203, 203	)
elements["PTN_204"] = lever_3pos(_("Radar Altimeter Mode Switch"),									devices.RS,		cmds.Button_204, 204,	{sound="rsmode", inverted=true})
elements["PTN_205"] = lever_3pos(_("Radar Altimeter Power Switch"),									devices.RS,		cmds.Button_205, 205	)
elements["PTN_206"] = lever_2pos(_("Auxiliary Gunsight"),											devices.VTH,	cmds.Button_206, 206,	{limits={0.5,1}})
elements["PTN_207"] = potentiometer(_("Auxiliary Gunsight Deflection"),								devices.VTH,	cmds.Button_207, 207,	0,	0.1,	true,	false,	{0.0, 1.0})
elements["PTN_208"] = lever_2pos(_("A/G Gun Reticle Switch"),										devices.VTH,	cmds.Button_208, 208,	{inverted=true})
elements["PTN_209"] = potentiometer(_("Target Wingspan Knob"),										devices.VTH,	cmds.Button_209, 209,	0, -0.03,	true,	false, {0.0, 0.99})
elements["PTN_210"] = push_button(_("HUD Clear Button"),											devices.VTH,	cmds.Button_210, 210	)
elements["PTN_192"] = default_axis_cycle(_("Minimum Altitude Selector"),							devices.RS,		cmds.Button_192, 192, 	0.2, 0.133203252, true)

-- VTB
elements["PTN_470"] = lever_2pos(_("Radar WOW Emitter Authorize Switch"),							devices.VTB,	cmds.Button_470, 470)
elements["PTN_213"] = lever_mon_off_mon(_("Target Data Manual Entry Begin/End"),					devices.VTB,	cmds.Button_213, 213)
elements["PTN_214"] = lever_mon_off_mon(_("N Switch (Bullseye Waypoint Selector)"),					devices.VTB,	cmds.Button_214, 214)
elements["PTN_215"] = lever_mon_off_mon(_("Rho Switch (Target Range from Bullseye)"),				devices.VTB,	cmds.Button_215, 215)
elements["PTN_216"] = lever_mon_off_mon(_("Theta Switch (Target Bearing from Bullseye)"),			devices.VTB,	cmds.Button_216, 216)
elements["PTN_217"] = lever_mon_off_mon(_("C Switch (Target Heading)"),								devices.VTB,	cmds.Button_217, 217)
elements["PTN_218"] = lever_mon_off_mon(_("Z Switch (Target Altitude)"),							devices.VTB,	cmds.Button_218, 218)
elements["PTN_219"] = lever_mon_off_mon(_("M Switch (Target Mach Number)"),							devices.VTB,	cmds.Button_219, 219)
elements["PTN_220"] = lever_mon_off_mon(_("T Switch (Target Age)"),									devices.VTB,	cmds.Button_220, 220)
elements["PTN_221"] = lever_2pos(_("VTB Power Switch"),												devices.VTB,	cmds.Button_221, 221)
elements["PTN_222"] = push_button(_("VTB Declutter"),												devices.VTB,	cmds.Button_222, 222, {inverted=true, sound="click2"})
elements["PTN_223"] = lever_2pos(_("VTB Map Forward/Centered"),										devices.VTB,	cmds.Button_223, 223, {inverted=true})
elements["PTN_224"] = thumbwheel(_("Markers Brightness"),											devices.VTB,	cmds.Button_224, 224, 8)
elements["PTN_225"] = thumbwheel(_("Main Brightness"),												devices.VTB,	cmds.Button_225, 225, 8)
elements["PTN_226"] = thumbwheel(_("Video Brightness"),												devices.VTB,	cmds.Button_226, 226, 8)
elements["PTN_227"] = thumbwheel(_("Cavalier Brightness"),											devices.VTB,	cmds.Button_227, 227, 8)

-- PCA/PPA
elements["PTN_463"]	= lever_2pos(_("Gun Arm/Safe Switch"),										devices.PCA,	cmds.Button_463, 463)
elements["PTN_234"] = lever_2pos(_("Master Arm Switch"),										devices.PCA,	cmds.Button_234, 234, {sound="masterarm"})
elements["PTN_248"] = switch_guard(_("Selective Jettison Switch Cover"),						devices.PCA,	cmds.Button_248, 248, {sound="seljetguard"})
elements["PTN_249"] = lever_2pos(_("Selective Jettison Switch"),								devices.PCA,	cmds.Button_249, 249, {sound="seljet"})
elements["PTN_235"] = push_button_impl(_("PCA Button 1"),										devices.PCA,	cmds.Button_235, 235)
elements["PTN_237"] = push_button_impl(_("PCA Button 2"),										devices.PCA,	cmds.Button_237, 237)
elements["PTN_239"] = push_button_impl(_("PCA Button 3"),										devices.PCA,	cmds.Button_239, 239)
elements["PTN_241"] = push_button_impl(_("PCA Button 4"),										devices.PCA,	cmds.Button_241, 241)
elements["PTN_243"] = push_button_impl(_("PCA Button 5"),										devices.PCA,	cmds.Button_243, 243)
elements["PTN_245"] = push_button_impl(_("Gun Mode Button"),									devices.PCA,	cmds.Button_245, 245)
elements["PTN_250"] = push_button_impl(_("Weapons Selector Button 1"),							devices.PCA,	cmds.Button_250, 250)
elements["PTN_253"] = push_button_impl(_("Weapons Selector Button 2"),							devices.PCA,	cmds.Button_253, 253)
elements["PTN_256"] = push_button_impl(_("Weapons Selector Button 3"),							devices.PCA,	cmds.Button_256, 256)
elements["PTN_259"] = push_button_impl(_("Weapons Selector Button 4"),							devices.PCA,	cmds.Button_259, 259)
elements["PTN_262"] = push_button_impl(_("Weapons Selector Button 5"),							devices.PCA,	cmds.Button_262, 262)
elements["PTN_409"] = push_button_impl(_("Emergency Jettison"),									devices.PCA,	cmds.Button_409, 409)


elements["PTN_266"] = push_button(_("S530 Standby"),											devices.PPA,	cmds.Button_266, 266)
elements["PTN_269"] = push_button(_("AUTO/MAN Button"),											devices.PPA,	cmds.Button_269, 269)
elements["PTN_272"] = push_button(_("MAGIC Standby"),											devices.PPA,	cmds.Button_272, 272)
elements["PTN_279"] = push_button(_("530D/Rockets/Guns Firing Mode Selector"),					devices.PPA,	cmds.Button_279, 279)

elements["PTN_265"] = lever_3pos(_("Missile Selector Switch"),									devices.PPA,	cmds.Button_265, 265, {limits={-1,1}, inverted=true})
elements["PTN_275"] = lever_mon_off_mon(_("PPA Test Switch"),									devices.PPA,	cmds.Button_275, 275, {inverted=true})
elements["PTN_276"] = lever_3pos(_("Bomb Fuze Selector Switch"),								devices.PPA,	cmds.Button_276, 276, {inverted=true})
elements["PTN_277"] = lever_mon_off_mon(_("Bomb Release Quantity Selector Switch"),				devices.PPA,	cmds.Button_277, 277)
elements["PTN_278"] = lever_mon_off_mon(_("Bomb Release Interval Selector Switch"),				devices.PPA,	cmds.Button_278, 278)


--CDVE
elements["PTN_282"] = push_button(_("Autopilot Master Button"),									devices.CDVE,	cmds.Button_282, 282)
elements["PTN_285"] = push_button(_("Altitude Hold Button"),									devices.CDVE,	cmds.Button_285, 285)
elements["PTN_288"] = push_button(_("Selected Altitude Hold Button"),							devices.CDVE,	cmds.Button_288, 288)
elements["PTN_294"] = push_button(_("Approach Hold Button"),									devices.CDVE,	cmds.Button_294, 294)
elements["PTN_302"] = push_button(_("Autopilot Lights Test Button"),							devices.CDVE,	cmds.Button_302, 302)
elements["PTN_299"] = thumbwheel(_("Altitude 10,000 ft Selector"),								devices.CDVE,	cmds.Button_299, 299,  6)
elements["PTN_300"] = thumbwheel(_("Altitude 1,000 ft Selector"),								devices.CDVE,	cmds.Button_300, 300, 10)
elements["PTN_301"] = thumbwheel(_("Altitude 100 ft Selector"),									devices.CDVE,	cmds.Button_301, 301, 10)
elements["PTN_514"] = switch_guard(_("Autopilot Test Switch Cover"),							devices.CDVE,	cmds.Button_514, 514)
elements["PTN_515"] = lever_2pos(_("Autopilot Test Switch"),									devices.CDVE,	cmds.Button_515, 515)
elements["PTN_516"] = switch_guard(_("FBW Test Switch Cover"),									devices.CDVE,	cmds.Button_516, 516)
elements["PTN_517"] = lever_3pos(_("FBW Test Switch"),											devices.CDVE,	cmds.Button_517, 517, {inverted=true})
elements["PTN_479"]	= switch_guard(_("FBW Channel 5 Switch Cover"),								devices.CDVE,	cmds.Button_479, 479)
elements["PTN_480"]	= lever_2pos(_("FBW Channel 5 Switch"),										devices.CDVE,	cmds.Button_480, 480)
elements["PTN_508"] = default_animated_lever(_("Trim Control Mode Dial"),						devices.CDVE,	cmds.Button_508, 508)
elements["PTN_509"] = lever_mon_off_mon(_("Rudder Trim Paddle"),								devices.CDVE,	cmds.Button_509, 509)

--FBW
elements["PTN_330"] = lever_2pos(_("FBW Spin Mode Switch"),										devices.ENGINE,	cmds.Button_330, 330, {inverted=true})
elements["PTN_420"] = switch_guard(_("FBW Gain Mode Switch Cover"),								devices.ENGINE,	cmds.Button_420, 420)
elements["PTN_421"] = lever_2pos(_("FBW Gain Mode Switch"),										devices.ENGINE,	cmds.Button_421, 421, {inverted=true})
elements["PTN_422"] = lever_2pos(_("FBW G-Limiter Switch"),										devices.ENGINE,	cmds.Button_422, 422, {inverted=true})
elements["PTN_423"] = push_button(_("FBW Reset Button"),										devices.CDVE,	cmds.Button_423, 423)

-- HSI
elements["PTN_340"] = lever_mon_off_mon("HSI VAD Selector",										devices.NAVINST,	cmds.Button_340, 340)
elements["PTN_341"] = knob_limited(_("HSI Mode Selector Switch"),								devices.NAVINST,	cmds.Button_341, 341, 7, {speed=5})


-- PELLES, SOURIES AND BECS
elements["PTN_460"] = lever_2pos(_("Intake Slats Operation Switch"),							devices.ENGINE,		cmds.Button_460, 460, {inverted=true})
elements["PTN_461"] = lever_2pos(_("Intake Cones Operation Switch"),							devices.ENGINE,		cmds.Button_461, 461, {inverted=true})
elements["PTN_462"] = lever_3pos(_("Slats Operation Switch"),									devices.HYDRAULICS,	cmds.Button_462, 462, {sound="becs", limits={-1,1}})
elements["PTN_396"] = potentiometer("Pedal Adjustment Lever",									devices.HYDRAULICS,	cmds.Button_396,396, 0.5, -0.1, true, 0)
elements["PTN_395"] = lever_2pos(_("Hydraulic System Selector"),								devices.HYDRAULICS,	cmds.Button_395, 395)

-- RADAR
elements["PTN_481"] = knob_free(_("Change radar channel A"),									devices.PCR, cmds.Button_481, 481, 12, 2.0/12, {min=-1})
elements["PTN_482"] = push_button(_("Radar Test Button"),										devices.PCR, cmds.Button_482, 482)
elements["PTN_483"] = push_button(_("Radar Rearm Button"),										devices.PCR, cmds.Button_483, 483)
elements["PTN_484"] = lever_3pos(_("Radar Doppler Reject Switch"),								devices.PCR, cmds.Button_484, 484, {limits={-1,1}})
elements["PTN_485"] = knob_free(_("Change radar channel B"),									devices.PCR, cmds.Button_485, 485, 12, 2.0/12, {min=-1})
elements["PTN_486"] = knob_limited(_("Radar Power Selector"),									devices.PCR, cmds.Button_486, 486, 4, {speed=9, limits={0,1}})
elements["PTN_488"] = potentiometer(_("Radar Gain Dial"),										devices.PCR, cmds.Button_488, 488, 0.0, 0.5, true, false, {0.0, 1.0})
elements["PTN_489"] = push_button_impl(_("Validate channel change"),							devices.PCR, cmds.Button_489, 489)
elements["PTN_491"] = push_button_impl(_("Hardened Clutter Gate Mode"),							devices.PCR, cmds.Button_491, 491)
elements["PTN_493"] = push_button_impl(_("A/G Radar DEC Mode Button"),							devices.PCR, cmds.Button_493, 493)
elements["PTN_495"] = push_button_impl(_("A/G Radar VISU Mode Button"),							devices.PCR, cmds.Button_495, 495)
elements["PTN_499"] = lever_2pos(_("Radar Grid Selector Switch"),								devices.PCR, cmds.Button_499, 499)
elements["PTN_500"] = lever_2pos(_("Target Memory Time Selector Switch"),						devices.PCR, cmds.Button_500, 500)
elements["PTN_502"] = lever_3pos(_("Radar Scan Lines Selector"),								devices.PCR, cmds.Button_502, 502, {inverted=true})
elements["PTN_503"] = lever_mon_off_mon(_("Radar Range Selector Switch"),						devices.PCR, cmds.Button_503, 503)
elements["PTN_504"] = push_button_impl(_("PSIC/STT Mode Button"),								devices.PCR, cmds.Button_504, 504)
elements["PTN_506"] = lever_3pos(_("Radar Azimuth Selector"),									devices.PCR, cmds.Button_506, 506)
elements["PTN_109"] = lever_3pos(_("Radar PRF Switch"),											devices.PCR, cmds.Button_109, 109, {limits={-1,1}})
elements["PTN_710"] = lever_2pos(_("TDC Mode Switch"),											devices.PCR, cmds.Button_710, 710)

-- RADAR IFF
elements["PTN_598"] = knob_limited(_("Radar IFF Mode Switch"),					devices.PCR, cmds.Button_598, 598, 6, {limits={0,1}, sound="click1"})
elements["PTN_600"] = knob_limited(_("Radar IFF Power Switch"),					devices.PCR, cmds.Button_600, 600, 3, {limits={0,1}, sound="click1"})
elements["PTN_599"] = lever_2pos(_("Radar IFF L/R Selector"),					devices.PCR, cmds.Button_599, 599, {sound="small*"})
elements["PTN_601"] = thumbwheel(_("Radar IFF Code-4 Selector"),				devices.PCR, cmds.Button_601, 601, 10)
elements["PTN_602"] = thumbwheel(_("Radar IFF Code-3 Selector"),				devices.PCR, cmds.Button_602, 602, 10)
elements["PTN_603"] = thumbwheel(_("Radar IFF Code-2 Selector"),				devices.PCR, cmds.Button_603, 603, 10)
elements["PTN_604"] = thumbwheel(_("Radar IFF Code-1 Selector"),				devices.PCR, cmds.Button_604, 604, 10)

-- ELECTRICAL PANEL
elements["PTN_520"]	= lever_2pos(_("Main Battery Switch"),						devices.PWRPNL, cmds.Button_520, 520, {sound="batt"})
elements["PTN_521"]	= lever_2pos(_("Electric Power Transfer Switch"),			devices.PWRPNL, cmds.Button_521, 521)
elements["PTN_522"]	= lever_2pos(_("Alternator 1 Switch"),						devices.PWRPNL, cmds.Button_522, 522)
elements["PTN_523"]	= lever_2pos(_("Alternator 2 Switch"),						devices.PWRPNL, cmds.Button_523, 523)
elements["PTN_524"]	= lever_mon_off_mon(_("Lights Test Switch"),				devices.PWRPNL, cmds.Button_524, 524)
elements["PTN_654"]	= lever_2pos(_("Alert Network (QRA) Switch"),				devices.PWRPNL, cmds.Button_654, 654)

-- PCN
elements["PTN_574"] = knob_free(_("INS Parameter Selector"),					devices.PCN,	cmds.Button_574, 574, 11, 0.1, {sound="pcn-knob"})
elements["PTN_575"]	= clickable_pot(_("PCN Brightness/Test"),					devices.PCN,	cmds.Button_575, 575, cmds.PCN_Test, nil)
elements["PTN_570"] = push_button_impl(_("INS PREP Switch"),					devices.PCN,	cmds.Button_570, 570, {sound="pcn-wp"})
elements["PTN_572"] = push_button_impl(_("INS DEST Switch"),					devices.PCN,	cmds.Button_572, 572, {sound="pcn-wp"})
elements["PTN_576"] = push_button_impl(_("BAD Offset Waypoint"),				devices.PCN,	cmds.Button_576, 576, {sound="pcn-grnamb"})
elements["PTN_578"] = push_button_impl(_("INS Update"),							devices.PCN,	cmds.Button_578, 578, {sound="pcn-grnamb"})
elements["PTN_580"] = push_button_impl(_("VAL Validate"),						devices.PCN,	cmds.Button_580, 580, {sound="pcn-grnamb"})
elements["PTN_582"] = push_button_impl(_("MRQ Markpoint"),						devices.PCN,	cmds.Button_582, 582, {sound="pcn-grnamb"})
elements["PTN_584"] = push_button_impl(_("INS Button 1"),						devices.PCN,	cmds.Button_584, 584, {sound="pcn-keypad"})
elements["PTN_585"] = push_button_impl(_("INS Button 2"),						devices.PCN,	cmds.Button_585, 585, {sound="pcn-keypad"})
elements["PTN_586"] = push_button_impl(_("INS Button 3"),						devices.PCN,	cmds.Button_586, 586, {sound="pcn-keypad"})
elements["PTN_587"] = push_button_impl(_("INS Button 4"),						devices.PCN,	cmds.Button_587, 587, {sound="pcn-keypad"})
elements["PTN_588"] = push_button_impl(_("INS Button 5"),						devices.PCN,	cmds.Button_588, 588, {sound="pcn-keypad"})
elements["PTN_589"] = push_button_impl(_("INS Button 6"),						devices.PCN,	cmds.Button_589, 589, {sound="pcn-keypad"})
elements["PTN_590"] = push_button_impl(_("INS Button 7"),						devices.PCN,	cmds.Button_590, 590, {sound="pcn-keypad"})
elements["PTN_591"] = push_button_impl(_("INS Button 8"),						devices.PCN,	cmds.Button_591, 591, {sound="pcn-keypad"})
elements["PTN_592"] = push_button_impl(_("INS Button 9"),						devices.PCN,	cmds.Button_592, 592, {sound="pcn-keypad"})
elements["PTN_593"] = push_button_impl(_("INS Button 0"),						devices.PCN,	cmds.Button_593, 593, {sound="pcn-keypad"})
elements["PTN_594"] = push_button_impl(_("INS Clear Button"),					devices.PCN,	cmds.Button_594, 594, {sound="pcn-keypad"})
elements["PTN_596"] = push_button_impl(_("INS ENTER Button"),					devices.PCN,	cmds.Button_596, 596, {sound="pcn-keypad"})

elements["PTN_110"] = push_button(_("INS Next Waypoint Button"),				devices.PCN,	cmds.Button_110, 110)
elements["PTN_111"] = push_button(_("INS Previous Waypoint Button"),			devices.PCN,	cmds.Button_111, 111)

-- PSM
elements["PTN_627"] = knob_limited(_("INS Mode Selector"),						devices.PCN,	cmds.Button_627, 627, 8)
elements["PTN_629"] = knob_limited(_("INS Operational Mode"),					devices.PCN,	cmds.Button_629, 629, 5, {inverted=true})
elements["PTN_628"] = lever_2pos(_("MIP Datacartridge Slot"),					devices.PCN,	cmds.Button_628, 628, {speed=5,sound="mip-door"})
elements["PTN_447"] = dtc_cartridge("",											devices.PCN,	cmds.Button_673, 673, cmds.Button_674, {speed=12})
elements["PTN_673"] = knob_limited("",											devices.PCN,	cmds.Button_675, 673, 3, {inverted=true, limits={-1,1}, speed=5})

-- EW PANEL
elements["PTN_228"]	= potentiometer(_("RWR Light Brightnes Control"),			devices.SYSLIGHTS,	cmds.Button_228, 228, 10, 0.5, false, false, {0.0, 1.0})
elements["PTN_605"] = knob_limited(_("EW Mode Selector Switch"),				devices.PCCM,		cmds.Button_605, 605, 3, {sound="ew-sel", limits={-1,1}})
elements["PTN_606"] = lever_3pos(_("BR Power Switch"),							devices.PCCM,		cmds.Button_606, 606, {sound="small4"})
elements["PTN_607"] = lever_3pos(_("RWR Power Switch"),							devices.PCCM,		cmds.Button_607, 607, {sound="small4"})
elements["PTN_608"] = lever_3pos(_("D2M Power Switch"),							devices.PCCM,		cmds.Button_608, 608, {sound="small4"})
elements["PTN_609"] = lever_3pos(_("Decoy Release Mode Switch"),				devices.PCCM,		cmds.Button_609, 609, {sound="small4"})
elements["PTN_610"] = knob_limited(_("Decoy Release Program Knob"),				devices.PCCM,		cmds.Button_610, 610, 11, {sound="click1"})
elements["PTN_990"] = push_button(_("ECM Box Clear Button"),					devices.SPIRALE,	cmds.Button_990, 990)

-- Panel Lights
elements["PTN_449"]	= lever_2pos(_("Police Lights Switch"),						devices.SYSLIGHTS,	cmds.Button_449, 449)
elements["PTN_450"]	= lever_3pos(_("Landing Lights Switch"),					devices.SYSLIGHTS,	cmds.Button_450, 450)
elements["PTN_452"]	= lever_3pos(_("SERPAM Recorder Switch"),					devices.SYSLIGHTS,	cmds.Button_452, 452)
elements["PTN_453"]	= lever_3pos(_("Anti-Collision Lights Switch"),				devices.SYSLIGHTS,	cmds.Button_453, 453)
elements["PTN_454"]	= lever_3pos(_("Navigation Lights Switch"),					devices.SYSLIGHTS,	cmds.Button_454, 454)
elements["PTN_455"]	= lever_3pos(_("Formation Lights Switch"),					devices.SYSLIGHTS,	cmds.Button_455, 455)
elements["PTN_639"]	= potentiometer(_("Dashboard U.V. Lights Knob"),			devices.SYSLIGHTS,	cmds.Button_639, 639, 10, 0.5, false, false, {0.0, 1.0})
elements["PTN_640"]	= potentiometer(_("Dashboard Panel Lights Knob"),			devices.SYSLIGHTS,	cmds.Button_640, 640, 10, 0.5, false, false, {0.0, 1.0})
elements["PTN_641"]	= potentiometer(_("Red Flood Lights Knob"),					devices.SYSLIGHTS,	cmds.Button_641, 641, 10, 0.5, false, false, {0.0, 1.0})
elements["PTN_642"]	= potentiometer(_("Console Panel Lights Knob"),				devices.SYSLIGHTS,	cmds.Button_642, 642, 10, 0.5, false, false, {0.0, 1.0})
elements["PTN_643"]	= potentiometer(_("Caution/Advisory Lights Rheostat"),		devices.SYSLIGHTS,	cmds.Button_643, 643, 10, 0.5, false, false, {0.05, 1.0})
elements["PTN_644"]	= potentiometer(_("White Flood Lights Knob"),				devices.SYSLIGHTS,	cmds.Button_644, 644, 10, 0.5, false, false, {0.0, 1.0})
elements["PTN_920"] = potentiometer(_("Refuel Lights Brightness Knob"),			devices.SYSLIGHTS,	cmds.Button_920, 920, 10, 0.5, false, false, {0.0, 1.0})
elements["PTN_672"]	= lever_2pos(_("NVG Lights Filter Switch"),					devices.SYSLIGHTS,	cmds.Button_672, 672)

-- Engine Start Panel
elements["PTN_468"]	= push_button(_("Engine In-Flight Start Switch"),			devices.ENGPANEL,	cmds.Button_468, 468)
elements["PTN_467"] = push_button(_("Unlock throttle cutoff position"),			devices.ENGPANEL,	cmds.Button_467, 467)
elements["PTN_645"]	= lever_2pos(_("Engine Start Switch Cover"),				devices.ENGPANEL,	cmds.Button_645, 645, {sound="startcover"})
elements["PTN_646"]	= lever_2pos(_("Starter Fuel Pump Switch"),					devices.ENGPANEL,	cmds.Button_646, 646, {sound="startpump"})
elements["PTN_647"]	= lever_2pos(_("Engine Fuel Left Boost Pump Switch"),		devices.INSTPANEL,	cmds.Button_647, 647, {sound="pumpl"})
elements["PTN_648"]	= lever_2pos(_("Engine Fuel Right Boost Pump Switch"),		devices.INSTPANEL,	cmds.Button_648, 648, {sound="pumpr"})
elements["PTN_649"]	= push_button(_("Engine Start Switch"),						devices.ENGPANEL,	cmds.Button_649, 649)
elements["PTN_650"] = lever_3pos(_("Igniter Selector Switch"),					devices.ENGPANEL,	cmds.Button_650, 650, {sound="small*", limits={-1,1}})
elements["PTN_651"]	= switch_guard(_("Fuel Cutoff Switch Cover"),				devices.ENGPANEL,	cmds.Button_651, 651, {sound="fuelcutguard"})
elements["PTN_652"]	= lever_2pos(_("Fuel Cutoff Switch"),						devices.ENGPANEL,	cmds.Button_652, 652)
elements["PTN_477"]	= switch_guard(_("Fuel Dump Switch Cover"),					devices.INSTPANEL,	cmds.Button_477, 477)
elements["PTN_478"]	= push_button(_("Fuel Dump Switch"),						devices.INSTPANEL,	cmds.Button_478, 478)
elements["PTN_471"]	= switch_guard(_("A/B Emergency Cutoff Switch Cover"),		devices.INSTPANEL,	cmds.Button_471, 471)
elements["PTN_472"]	= lever_2pos(_("A/B Emergency Cutoff Switch"),				devices.INSTPANEL,	cmds.Button_472, 472)
elements["PTN_464"]	= switch_guard(_("Emergency Throttle Cover"),				devices.ENGPANEL,	cmds.Button_464, 464)
elements["PTN_465"]	= lever_mon_off_mon(_("Emergency Throttle"),				devices.ENGPANEL,	cmds.Button_465, 465)
elements["PTN_473"]	= switch_guard(_("Secondary Oil Control Cover"),			devices.ENGPANEL,	cmds.Button_473, 473)
elements["PTN_474"]	= lever_2pos(_("Secondary Oil Control Switch"),				devices.ENGPANEL,	cmds.Button_474, 474)
elements["PTN_475"]	= switch_guard(_("Engine Emergency Control Cover"),			devices.ENGPANEL,	cmds.Button_475, 475)
elements["PTN_476"]	= lever_3pos(_("Engine Emergency Control Switch"),			devices.ENGPANEL,	cmds.Button_476, 476, {inverted=true})


elements["PTN_193"]	= lever_3pos(_("Refuel Transfer Switch"),										devices.ENGPANEL,	cmds.Button_193, 193)
elements["PTN_360"] = thumbwheel(_("Bingo Fuel 1,000 kg Selector"),									devices.INSTPANEL,	cmds.Button_360, 360, 4)
elements["PTN_361"] = thumbwheel(_("Bingo Fuel 100 kg Selector"),									devices.INSTPANEL,	cmds.Button_361, 361, 10)
elements["PTN_355"]	= lever_mon_off_mon(_("Fuel Detotalizer Switch"),								devices.INSTPANEL,	cmds.Button_355, 355)
elements["PTN_357"]	= default_2_position_tumb_animated(_("Fuel Crossfeeed Switch"),					devices.INSTPANEL,	cmds.Button_357, 357)

-- Radio Panel
elements["PTN_950"]	= knob_limited(_("VHF MODE"),													devices.VHF,	cmds.Button_950, 950,  7, {sound="green-mode", limits={0,0.6}})
elements["PTN_951"]	= knob_free(_("VHF CH Sel"),													devices.VHF,	cmds.Button_951, 951, 20, 0.05)
elements["PTN_952"]	= push_button_impl(_("VHF MEM/CLR"),											devices.VHF,	cmds.Button_952, 952, {sound="pushs"})
elements["PTN_953"]	= push_button_impl(_("VHF VLD/XFR"),											devices.VHF,	cmds.Button_953, 953, {sound="pushs"})
elements["PTN_954"]	= push_button_impl(_("VHF 1/READ"),												devices.VHF,	cmds.Button_954, 954, {sound="pushs"})
elements["PTN_955"]	= push_button_impl(_("VHF 2/SQL"),												devices.VHF,	cmds.Button_955, 955, {sound="pushs"})
elements["PTN_956"]	= push_button_impl(_("VHF 3/GR"),												devices.VHF,	cmds.Button_956, 956, {sound="pushs"})
elements["PTN_957"]	= push_button_impl(_("VHF 4"),													devices.VHF,	cmds.Button_957, 957, {sound="pushs"})
elements["PTN_958"]	= push_button_impl(_("VHF 5/20/LOW"),											devices.VHF,	cmds.Button_958, 958, {sound="pushs"})
elements["PTN_959"]	= push_button_impl(_("VHF 6/TONE"),												devices.VHF,	cmds.Button_959, 959, {sound="pushs"})
elements["PTN_960"]	= push_button_impl(_("VHF 7"),													devices.VHF,	cmds.Button_960, 960, {sound="pushs"})
elements["PTN_961"]	= push_button_impl(_("VHF 8/TOD"),												devices.VHF,	cmds.Button_961, 961, {sound="pushs"})
elements["PTN_962"]	= push_button_impl(_("VHF 9/ZERO"),												devices.VHF,	cmds.Button_962, 962, {sound="pushs"})
elements["PTN_963"]	= push_button_impl(_("VHF 0"),													devices.VHF,	cmds.Button_963, 963, {sound="pushs"})
elements["PTN_964"]	= push_button_impl(_("VHF CONF"),												devices.VHF,	cmds.Button_964, 964, {sound="pushs"})

elements["PTN_429"]	= default_2_position_tumb_animated(_("UHF Power 5W/25W Switch"),				devices.UHF,	cmds.Button_429, 429)
elements["PTN_430"]	= default_2_position_tumb_animated(_("UHF SIL Switch"),							devices.UHF,	cmds.Button_430, 430)
elements["PTN_431"]	= lever_mon_off_mon(_("UHF E+A2 Switch"),										devices.UHF,	cmds.Button_431, 431)
elements["PTN_432"]	= push_button(_("UHF CDE Switch"),												devices.UHF,	cmds.Button_432, 432)
elements["PTN_433"] = knob_limited(_("UHF Mode Switch"),											devices.UHF,	cmds.Button_433, 433,  4, {sound="green-mode", limits={0,0.75}})
elements["PTN_434"]	= push_button(_("UHF TEST Switch"),												devices.UHF,	cmds.Button_434, 434)
elements["PTN_435"]	= knob_free(_("UHF Knob"),														devices.UHF,	cmds.Button_435, 435, 20, 0.05)

-- Navigational Antennas
elements["PTN_616"] = knob_encoder_with_ring(_("VOR/ILS Frequency MHz / Power"),					devices.VORILS, cmds.Button_617, cmds.Button_616, 617, 616, 2, 10, {sound="ils-mode", limits={0,1}}, {sound="tacan-knob"})
elements["PTN_618"] = knob_encoder_with_ring(_("VOR/ILS Frequency 50kHz / Test"),					devices.VORILS, cmds.Button_619, cmds.Button_618, 619, 618, 3, 20, {sound="ils-mode", limits={0,1}, spring=0.5}, {sound="tacan-knob"})
elements["PTN_623"] = knob_encoder_with_ring(_("TACAN Channel 10s & X/Y"),							devices.TACAN,  cmds.Button_624, cmds.Button_623, 624, 623, 2, 13, {sound="ils-mode", limits={0,1}}, {sound="tacan-knob"})
elements["PTN_625"] = knob_encoder_with_ring(_("TACAN Channel 1s & Mode"),							devices.TACAN,  cmds.Button_626, cmds.Button_625, 626, 625, 4, 10, {sound="ils-mode", limits={0,1}}, {sound="tacan-knob"})
elements["PTN_617"] = knob_limited(_("VOR/ILS Power"),												devices.VORILS, cmds.Button_617, 617, 2, {sound="ils-mode", limits={0,1}})
elements["PTN_619"] = lever_mon_off_mon(_("VOR/ILS Test"),											devices.VORILS, cmds.Button_619, 619, 	 {sound="ils-mode", limits={0,1}})
elements["PTN_626"] = knob_limited(_("TACAN Mode"),													devices.TACAN,	cmds.Button_626, 626, 4, {sound="ils-mode", limits={0,1}})
elements["PTN_624"] = knob_limited(_("TACAN X/Y"),													devices.TACAN,	cmds.Button_624, 624, 2, {sound="ils-mode", limits={0,1}})

-- Miscelaneous Left Panel
elements["PTN_400"] = default_2_position_tumb_animated(_("Cockpit Clock"),								devices.MISCPANELS,	cmds.Button_400, 400)
elements["PTN_191"] = push_button(_("Audio Warning Reset"),												devices.SYSLIGHTS,	cmds.Button_191, 191)
elements["PTN_458"]	= switch_guard(_("Anti-Skid Switch Cover"),											devices.MISCPANELS, cmds.Button_458, 458)
elements["PTN_459"]	= lever_2pos(_("Anti-Skid Switch"),													devices.MISCPANELS, cmds.Button_459, 459)
elements["PTN_666"]	= lever_2pos(_("Parking Brake Lever"),												devices.MISCPANELS, cmds.Button_666, 666,{speed=5,sound="parkbrake"})
elements["PTN_457"]	= default_animated_lever(_("Drag Chute Lever"),										devices.MISCPANELS, cmds.Button_457, 457)
elements["PTN_807"] = lever_mon_off_mon(_("Nose Wheel Steering / IFF Interrogation Button"),			devices.MISCPANELS, cmds.Button_807, 807, {inverted=true})
elements["PTN_905"] = default_2_position_tumb_animated(_("Emergency Compass"),							devices.PCN,	cmds.Button_905, 905)

-- Canopy
elements["PTN_456"]	= canopy_handle(_("Canopy Jettison"),												devices.CANOPY, 	cmds.Button_456, 456, 25.0)
elements["PTN_656"] = canopy_lever(_("Canopy Lock/Neutral/Lower Lever"),								devices.CANOPY, 	cmds.Button_656, 656)
elements["PTN_655"] = canopy_lever(_("Canopy ajar stick L (un)fold / R auto"),							devices.CANOPY,		cmds.Button_655, 655)
elements["PTN_907"] = canopy_handle(_("Canopy Handle (L drag(manual) / R click(auto)"),					devices.CANOPY,		cmds.Button_907, 907, 4.0, cmds.CanopyMoveAuto)
elements["PTN_908"] = canopy_handle(_("Canopy Handle L drag(manual) / R click(auto)"),					devices.CANOPY,		cmds.Button_908, 908, 4.0, cmds.CanopyMoveAuto)
elements["PTN_909"] = default_2_position_tumb(_("Mirror Rendering Toggle"),								devices.CANOPY,		cmds.Button_909, 909)

-- Miscelaneous Right Panel
elements["PTN_657"]	= multiposition_switch_spring(_("Emergency Hydraulic Pump Switch"),					devices.ENGINE,		cmds.Button_657, cmds.Button_657, 657)
elements["PTN_658"]	= lever_2pos(_("Audio Warning Switch"),												devices.SYSLIGHTS,	cmds.Button_658, 658)
elements["PTN_659"] = switch_guard(_("Pitot Heat Cover"),												devices.MISCPANELS,	cmds.Button_659, 659)
elements["PTN_660"] = lever_2pos(_("Pitot Heat Switch"),												devices.MISCPANELS,	cmds.Button_660, 660)

-- Miscelaneous Seat
elements["PTN_900"] = lever_mon_off_mon(_("Seat Adjustment Switch"),									devices.MISCPANELS,	cmds.Button_900,	900)
elements["PTN_910"] = lever_2pos(_("LOX Dilution Lever"),												devices.ECS,		cmds.Button_910,	910)
elements["PTN_912"] = lever_2pos(_("LOX Emergency Supply"),												devices.ECS,		cmds.Button_912,	912)
elements["PTN_911"] = { class       = {class_type.TUMB, class_type.BTN},
                        hint        = _("LOX Test Switch") , 
                        device      = devices.ECS, 
                        arg         = {911, 911},
                        arg_value   = {0, 1.0},
                        arg_lim     = {{0, 0.5},{0.5, 1.0}},
                        action      = {cmds.Button_911,cmds.Button_911},
                        stop_action = {0, cmds.Button_911}, 
                        stop_value  = {nil, 0.5},                                   
                        use_release_message = {false, true}}

-- Sound Panel
elements["PTN_700"] = lever_2pos(_("AMPLIS Selector Knob"),												devices.SYSLIGHTS,	cmds.Button_700, 700, {inverted=true, sound="small*"})
elements["PTN_701"] = potentiometer(_("VOR/ILS Volume Knob"),											devices.SYSLIGHTS,	cmds.Button_701, 701, 0.8, 0.5, true, false, {0.0, 1.0})
elements["PTN_702"] = potentiometer(_("TACAN Volume Knob"),												devices.SYSLIGHTS,	cmds.Button_702, 702, 0.8, 0.5, true, false, {0.0, 1.0})
elements["PTN_703"] = potentiometer(_("MAGIC Tone Volume Knob"),										devices.SYSLIGHTS,	cmds.Button_703, 703, 0.8, 0.5, true, false, {0.0, 1.0})
elements["PTN_704"] = potentiometer(_("TB APP Volume Knob"),											devices.SYSLIGHTS,	cmds.Button_704, 704, 0.8, 0.5, true, false, {0.0, 1.0})
elements["PTN_705"] = potentiometer(_("Marker Signal Volume Knob"),										devices.SYSLIGHTS,	cmds.Button_705, 705, 0.8, 0.5, true, false, {0.0, 1.0})
elements["PTN_706"] = potentiometer(_("UHF Radio Volume Knob"),											devices.SYSLIGHTS,	cmds.Button_706, 706, 0.8, 0.5, true, false, {0.0, 1.0})
elements["PTN_707"] = potentiometer(_("V/UHF Radio Volume Knob"),										devices.SYSLIGHTS,	cmds.Button_707, 707, 0.8, 0.5, true, false, {0.0, 1.0})

-- Flight Instruments
elements["PTN_348"] = push_button("G-Meter Reset",														devices.FLIGHTINST,	cmds.Button_348, 348)
elements["PTN_309"] = default_axis_cycle(_("Barometric Pressure Calibration"),							devices.FLIGHTINST,	cmds.Button_309, 309, 0.5, 0.05, true)
elements["PTN_665"] = lever_3pos(_("Backup ADI Switch"),												devices.FLIGHTINST,	cmds.Button_665, 665)
elements["PTN_314"]	= lever_2pos(_("ADI Cage Lever"),													devices.FLIGHTINST,	cmds.Button_314, 314)
elements["PTN_315"] = lever_2pos(_("ADI Backlight Switch"),												devices.FLIGHTINST,	cmds.Button_315, 315)
elements["PTN_325"] = auxadi_knob(_("Backup ADI Cage/Pitch Adjust Knob - Pull and turn to uncage"),		devices.FLIGHTINST, cmds.Button_325, cmds.Button_328, 325, 328)
	
    
-- ECS Panel
elements["PTN_630"]	= lever_2pos(_("ECS Main Mode Switch"),												devices.ECS,	cmds.Button_630, 630, {inverted=true})
elements["PTN_631"]	= push_button(_("ECS C Button"),													devices.ECS,	cmds.Button_631, 631)
elements["PTN_633"]	= push_button(_("ECS F Button"),													devices.ECS,	cmds.Button_633, 633)
elements["PTN_635"]	= lever_2pos(_("ECS Cond Switch"),													devices.ECS,	cmds.Button_635, 635)
elements["PTN_636"]	= lever_2pos(_("ECS Air Exchange Switch"),											devices.ECS,	cmds.Button_636, 636)
elements["PTN_637"] = axis_limited_cycle(_("ECS Temperature Select Knob"),								devices.ECS,	cmds.Button_637, 637, 0.8, 0.5, true, false, {-1.0, 1.0})
elements["PTN_638"]	= lever_2pos(_("ECS Defog Switch"),													devices.ECS,	cmds.Button_638, 638)

-- IFF
elements["PTN_377"] = thumbwheel(_("Mode-1 Tens Selector"),												devices.INSTPANEL, cmds.Button_377, 377,  10)
elements["PTN_378"] = thumbwheel(_("Mode-1 Ones Selector"),												devices.INSTPANEL, cmds.Button_378, 378,  10)
elements["PTN_379"] = thumbwheel(_("Mode-3A Thousands Selector"),										devices.INSTPANEL, cmds.Button_379, 379,  10)
elements["PTN_380"] = thumbwheel(_("Mode-3A Hundreds Selector"),										devices.INSTPANEL, cmds.Button_380, 380,  10)
elements["PTN_381"] = thumbwheel(_("Mode-3A Tens Selector"),											devices.INSTPANEL, cmds.Button_381, 381,  10)
elements["PTN_382"] = thumbwheel(_("Mode-3A Ones Selector"),											devices.INSTPANEL, cmds.Button_382, 382,  10)
elements["PTN_382"] = thumbwheel(_("Mode-3A Ones Selector"),											devices.INSTPANEL, cmds.Button_382, 382,  10)
elements["PTN_383"] = lever_3pos(_("Ident Power Switch"),												devices.INSTPANEL, cmds.Button_383, 383)
elements["PTN_384"] = lever_2pos(_("Mode-1 Switch"),													devices.INSTPANEL, cmds.Button_384, 384)
elements["PTN_385"] = lever_2pos(_("Mode-2 Switch"),													devices.INSTPANEL, cmds.Button_385, 385)
elements["PTN_386"] = lever_2pos(_("Mode-3A Switch"),													devices.INSTPANEL, cmds.Button_386, 386)
elements["PTN_387"] = lever_2pos(_("Mode-C Switch"),													devices.INSTPANEL, cmds.Button_387, 387)

-- EVF (TAF) panel
elements["PTN_1004"] = knob_encoder(_("EVF channel selector"),											devices.TAF,	cmds.Button_1004, 1004, 20)
elements["PTN_1006"] = push_button(_("EVF panel test"),													devices.TAF,	cmds.Button_1006, 1006)


-- NVG
elements["PTN_1001"]	= default_2_position_tumb_animated(_("Mount/Unmount NVG on Helmet"),			devices.Helmet_NVG,	cmds.Button_2, 1)
elements["PTN_1002"]	= default_2_position_tumb_animated(_("STOW/UNSTOW NVG"),						devices.Helmet_NVG,	cmds.Button_1, 2)

-- Add more lines in command_defs.lua if needed

for i,o in pairs(elements) do
	if  o.class[1] == class_type.TUMB or
	   (o.class[2]  and o.class[2] == class_type.TUMB) or
	   (o.class[3]  and o.class[3] == class_type.TUMB)  then
	   o.updatable = true
	   o.use_OBB   = true
	end
end
