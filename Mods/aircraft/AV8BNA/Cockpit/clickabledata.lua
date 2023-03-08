dofile(LockOn_Options.script_path.."clickable_defs.lua")
dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."devices.lua")

local gettext = require("i_18n")
_ = gettext.translate

elements = {}

-------------------------------------------------------------------
-- MAIN INSTRUMENT PANEL:
-------------------------------------------------------------------

-- Master Modes Panel
elements["PTN_282"] = default_button(_("NAV Master Mode Selector"),         					devices.MSC, msc_commands.NAV_Selector,   282)
elements["PTN_284"] = default_button(_("VSTOL Master Mode Selector"),       					devices.MSC, msc_commands.VSTOL_Selector, 284)
elements["PTN_280"] = default_button(_("AG Master Mode Selector"),          					devices.MSC, msc_commands.AG_Selector,    280)

-- Engine Display Panel
elements["PTN_272"] = default_axis_limited(_("EDP Brightness Control"),							devices.EDP, edp_commands.BRT_Knob,		272, 0, 0.1, false, 0, {0, 1})
elements["PTN_655"] = default_2_position_tumb_animated(_("EDP BIT Button"),						devices.EDP, edp_commands.BIT_Button,   655)
elements["PTN_655"].sound = {{SOUND_SW2}, {SOUND_SW2}}

-- HUD Control Panel
elements["PTN_288"] = multiposition_switch_limited_animated(_("HUD Symbology Reject Switch"),	devices.HUDCONTROL, hud_commands.RejectSwitch,		288, 3, 0.50, true, 0)
elements["PTN_288"].sound = {{SOUND_SW4_ON}, {SOUND_SW4_OFF}}
elements["PTN_289"] = default_axis_limited(_("HUD Off/Brightness Control"),						devices.HUDCONTROL, hud_commands.DisplayBRTKnob,	289, 0, 0.1, false,  0, {0, 1})
elements["PTN_290"] = multiposition_switch_limited_animated(_("HUD Display Mode Switch"),		devices.HUDCONTROL, hud_commands.DisplayModeSwitch,	290, 3, 0.50, false, 0)
elements["PTN_290"].sound = {{SOUND_SW4_ON}, {SOUND_SW4_OFF}}
elements["PTN_291"] = default_axis_limited(_("HUD Video Brightness Control"),					devices.HUDCONTROL, hud_commands.VideoBRTKnob,		291, 0, 0.1, false, 0, {0, 1})
elements["PTN_292"] = default_axis_limited(_("HUD Video Contrast Control"),						devices.HUDCONTROL, hud_commands.VideoCONTKnob,		292, 0, 0.1, false,  0, {0, 1})
elements["PTN_293"] = default_2_position_tumb_animated(_("HUD Altitude Selector Switch"),		devices.HUDCONTROL, hud_commands.AltitudeSelector,	293)
elements["PTN_293"].sound = {{SOUND_SW2}, {SOUND_SW2}}

-- UFC Panel
elements["PTN_302"] = default_button(_("UFC Button 1"),								devices.UFCCONTROL, ufc_commands.Button_1,    302)
elements["PTN_303"] = default_button(_("UFC Button 2/N"),							devices.UFCCONTROL, ufc_commands.Button_2,    303)
elements["PTN_304"] = default_button(_("UFC Button 3"),								devices.UFCCONTROL, ufc_commands.Button_3,    304)
elements["PTN_306"] = default_button(_("UFC Button 4/W"),							devices.UFCCONTROL, ufc_commands.Button_4,    306)
elements["PTN_307"] = default_button(_("UFC Button 5"),								devices.UFCCONTROL, ufc_commands.Button_5,    307)
elements["PTN_308"] = default_button(_("UFC Button 6/E"),							devices.UFCCONTROL, ufc_commands.Button_6,    308)
elements["PTN_310"] = default_button(_("UFC Button 7"),								devices.UFCCONTROL, ufc_commands.Button_7,    310)
elements["PTN_311"] = default_button(_("UFC Button 8/S"),							devices.UFCCONTROL, ufc_commands.Button_8,    311)
elements["PTN_312"] = default_button(_("UFC Button 9"),								devices.UFCCONTROL, ufc_commands.Button_9,    312)
elements["PTN_315"] = default_button(_("UFC Button 0"),								devices.UFCCONTROL, ufc_commands.Button_0,    315)
elements["PTN_316"] = default_button(_("UFC Button ."),								devices.UFCCONTROL, ufc_commands.Button_Dot,  316)
elements["PTN_313"] = default_button(_("UFC Button -"),								devices.UFCCONTROL, ufc_commands.Button_Dash, 313)
elements["PTN_314"] = default_button(_("ENTER Data Button"),						devices.UFCCONTROL, ufc_commands.Button_ENT,     314)
elements["PTN_305"] = default_button(_("Clear Entry Button"),						devices.UFCCONTROL, ufc_commands.Button_CLR,     305)
elements["PTN_294"] = default_button(_("Timer Function Selector"),					devices.UFCCONTROL, ufc_commands.Button_TMR,     294)
elements["PTN_324"] = default_button(_("Altitude Function Selector"),				devices.UFCCONTROL, ufc_commands.Button_ALT,     324)
elements["PTN_318"] = default_button(_("IFF Function Selector"),					devices.UFCCONTROL, ufc_commands.Button_IFF,     318)
elements["PTN_319"] = default_button(_("TACAN Function Selector"),					devices.UFCCONTROL, ufc_commands.Button_TCN,     319)
elements["PTN_320"] = default_button(_("All Weather Landing Function Selector"),	devices.UFCCONTROL, ufc_commands.Button_AWL,     320)
elements["PTN_317"] = default_button(_("Radalt/TACAN/AWL/IFF ON/OFF Toggle"),		devices.UFCCONTROL, ufc_commands.Button_ON_OFF,  317)
elements["PTN_325"] = default_button(_("EMCON ON/OFF Toggle"),						devices.UFCCONTROL, ufc_commands.Button_EMCON,   325)
elements["PTN_296"] = default_button(_("Target-Of-Opportunity Selector"),			devices.UFCCONTROL, ufc_commands.Button_TOO,     296)
elements["PTN_322"] = default_button(_("Waypoint Overfly INS Update Selector"),		devices.UFCCONTROL, ufc_commands.Button_WOF,     322)
elements["PTN_321"] = default_button(_("Weapons Function Selector"),				devices.UFCCONTROL, ufc_commands.Button_WPN,     321)
elements["PTN_323"] = default_button(_("Radar Beacon Function Selector"),			devices.UFCCONTROL, ufc_commands.Button_BCN,     323)
elements["PTN_297"] = default_button(_("I/P Button"),								devices.UFCCONTROL, ufc_commands.Button_IP,      297)
elements["PTN_309"] = default_button(_("Save Data Button"),							devices.UFCCONTROL, ufc_commands.Button_SVE,     309)
elements["PTN_295"] = default_axis_limited(_("Display Brightness Control"),			devices.UFCCONTROL, ufc_commands.Knob_BRT,        295, 0, 0.1, true, 0, {0, 1})
elements["PTN_298"] = default_axis_limited(_("Comm 1 Volume Control"),				devices.UFCCONTROL, ufc_commands.Knob_Comm1_Vol,  298, 0, 0.1, true, 0, {0, 1})
elements["PTN_299"] = default_axis_limited(_("Comm 2 Volume Control"),				devices.UFCCONTROL, ufc_commands.Knob_Comm2_Vol,  299, 0, 0.1, true, 0, {0, 1})
elements["PTN_300"] = default_button_lever_cycled(_("Comm 1 Channel Selector"),		devices.UFCCONTROL, ufc_commands.Button_Comm1, ufc_commands.Knob_Comm1_Chnl, 178, 300)
elements["PTN_301"] = default_button_lever_cycled(_("Comm 2 Channel Selector"),		devices.UFCCONTROL, ufc_commands.Button_Comm2, ufc_commands.Knob_Comm2_Chnl, 179, 301)

-- ODU Panel
elements["PTN_250"] = default_button(_("ODU Option 1"),		devices.ODUCONTROL, odu_commands.Button_1, 250)
elements["PTN_251"] = default_button(_("ODU Option 2"),		devices.ODUCONTROL, odu_commands.Button_2, 251)
elements["PTN_252"] = default_button(_("ODU Option 3"),		devices.ODUCONTROL, odu_commands.Button_3, 252)
elements["PTN_248"] = default_button(_("ODU Option 4"),		devices.ODUCONTROL, odu_commands.Button_4, 248)
elements["PTN_249"] = default_button(_("ODU Option 5"),		devices.ODUCONTROL, odu_commands.Button_5, 249)

-- Master Caution/Warning Panel
elements["PTN_198"] = default_button(_("Master Caution"),	devices.LTWCA, wc_lights_commands.Switch_Master_Caution, 198)
elements["PTN_199"] = default_button(_("Master Warning"),	devices.LTWCA, wc_lights_commands.Switch_Master_Warning, 199)

-- Fuel Quantity Indicator
elements["PTN_379"] = multiposition_switch_limited_animated(_("Fuel Totalizer Selector"),	devices.FQIS, fqi_commands.FuelSelector,	379, 7, 0.33, false, -0.99)
elements["PTN_379"].sound = {{SOUND_SW11_ON}, {SOUND_SW11_OFF}}
elements["PTN_380"] = default_axis_cycle(_("Bingo Fuel Set Knob"),							devices.FQIS, fqi_commands.BingoSet,		380, 0, 0.1, false, true)

-- MPCD left
elements["PTN_200"] 	= default_button(_("MPCD Left Button 1"),									devices.MPCD_LEFT, mpcd_l_commands.Button_01,			200)
elements["PTN_201"] 	= default_button(_("MPCD Left Button 2"),									devices.MPCD_LEFT, mpcd_l_commands.Button_02,			201)
elements["PTN_202"] 	= default_button(_("MPCD Left Button 3"),									devices.MPCD_LEFT, mpcd_l_commands.Button_03,			202)
elements["PTN_203"] 	= default_button(_("MPCD Left Button 4"),									devices.MPCD_LEFT, mpcd_l_commands.Button_04,			203)
elements["PTN_204"] 	= default_button(_("MPCD Left Button 5"),									devices.MPCD_LEFT, mpcd_l_commands.Button_05,			204)
elements["PTN_205"] 	= default_button(_("MPCD Left Button 6"),									devices.MPCD_LEFT, mpcd_l_commands.Button_06,			205)
elements["PTN_206"] 	= default_button(_("MPCD Left Button 7"),									devices.MPCD_LEFT, mpcd_l_commands.Button_07,			206)
elements["PTN_207"] 	= default_button(_("MPCD Left Button 8"),									devices.MPCD_LEFT, mpcd_l_commands.Button_08,			207)
elements["PTN_208"] 	= default_button(_("MPCD Left Button 9"),									devices.MPCD_LEFT, mpcd_l_commands.Button_09,			208)
elements["PTN_209"] 	= default_button(_("MPCD Left Button 10"),									devices.MPCD_LEFT, mpcd_l_commands.Button_10,			209)
elements["PTN_210"] 	= default_button(_("MPCD Left Button 11"),									devices.MPCD_LEFT, mpcd_l_commands.Button_11,			210)
elements["PTN_211"] 	= default_button(_("MPCD Left Button 12"),									devices.MPCD_LEFT, mpcd_l_commands.Button_12,			211)
elements["PTN_212"] 	= default_button(_("MPCD Left Button 13"),									devices.MPCD_LEFT, mpcd_l_commands.Button_13,			212)
elements["PTN_213"] 	= default_button(_("MPCD Left Button 14"),									devices.MPCD_LEFT, mpcd_l_commands.Button_14,			213)
elements["PTN_214"] 	= default_button(_("MPCD Left Button 15"),									devices.MPCD_LEFT, mpcd_l_commands.Button_15,			214)
elements["PTN_215"] 	= default_button(_("MPCD Left Button 16"),									devices.MPCD_LEFT, mpcd_l_commands.Button_16,			215)
elements["PTN_216"] 	= default_button(_("MPCD Left Button 17"),									devices.MPCD_LEFT, mpcd_l_commands.Button_17,			216)
elements["PTN_217"] 	= default_button(_("MPCD Left Button 18"),									devices.MPCD_LEFT, mpcd_l_commands.Button_18,			217)
elements["PTN_218"] 	= default_button(_("MPCD Left Button 19"),									devices.MPCD_LEFT, mpcd_l_commands.Button_19,			218)
elements["PTN_219"] 	= default_button(_("MPCD Left Button 20"),									devices.MPCD_LEFT, mpcd_l_commands.Button_20,			219)
elements["PTN_220_1"] 	= AMPCD_switch_negative(_("MPCD Left Display DAY Mode"),					devices.MPCD_LEFT, mpcd_l_commands.Switch_DAY_MODE,		220)
elements["PTN_220_2"] 	= AMPCD_switch_positive(_("MPCD Left Display NIGHT Mode"),					devices.MPCD_LEFT, mpcd_l_commands.Switch_NGT_MODE,		220)
elements["PTN_221_1"]	= AMPCD_switch_positive(_("MPCD Left Symbology, UP"),						devices.MPCD_LEFT, mpcd_l_commands.Switch_SYM_UP,		221)
elements["PTN_221_2"]	= AMPCD_switch_negative(_("MPCD Left Symbology, DOWN"),						devices.MPCD_LEFT, mpcd_l_commands.Switch_SYM_DN,		221)
elements["PTN_222_1"]	= AMPCD_switch_positive(_("MPCD Left Video Gain, UP"),						devices.MPCD_LEFT, mpcd_l_commands.Switch_GAIN_UP,		222)
elements["PTN_222_2"]	= AMPCD_switch_negative(_("MPCD Left Video Gain, DOWN"),					devices.MPCD_LEFT, mpcd_l_commands.Switch_GAIN_DN,		222)
elements["PTN_223_1"]	= AMPCD_switch_positive(_("MPCD Left Video Contrast, UP"),					devices.MPCD_LEFT, mpcd_l_commands.Switch_CONT_UP,		223)
elements["PTN_223_2"]	= AMPCD_switch_negative(_("MPCD Left Video Contrast, DOWN"),				devices.MPCD_LEFT, mpcd_l_commands.Switch_CONT_DN,		223)
elements["PTN_194"]		= default_axis_limited(_("MPCD Left Off/Brightness Control"),				devices.MPCD_LEFT, mpcd_l_commands.Knob_OFF_BRT,		194, 0, 0.1, true, false, {0, 1})

-- MPCD Right
elements["PTN_224"] =	default_button(_("MPCD Right Button 1"), 	 								devices.MPCD_RIGHT, mpcd_r_commands.Button_01,			224)
elements["PTN_225"] = 	default_button(_("MPCD Right Button 2"),  									devices.MPCD_RIGHT, mpcd_r_commands.Button_02,			225)
elements["PTN_226"] = 	default_button(_("MPCD Right Button 3"),  									devices.MPCD_RIGHT, mpcd_r_commands.Button_03,			226)
elements["PTN_227"] = 	default_button(_("MPCD Right Button 4"),  									devices.MPCD_RIGHT, mpcd_r_commands.Button_04,			227)
elements["PTN_228"] = 	default_button(_("MPCD Right Button 5"),  									devices.MPCD_RIGHT, mpcd_r_commands.Button_05,			228)
elements["PTN_229"] = 	default_button(_("MPCD Right Button 6"),  									devices.MPCD_RIGHT, mpcd_r_commands.Button_06,			229)
elements["PTN_230"] = 	default_button(_("MPCD Right Button 7"),  									devices.MPCD_RIGHT, mpcd_r_commands.Button_07,			230)
elements["PTN_231"] = 	default_button(_("MPCD Right Button 8"),  									devices.MPCD_RIGHT, mpcd_r_commands.Button_08,			231)
elements["PTN_232"] = 	default_button(_("MPCD Right Button 9"),  									devices.MPCD_RIGHT, mpcd_r_commands.Button_09,			232)
elements["PTN_233"] = 	default_button(_("MPCD Right Button 10"), 									devices.MPCD_RIGHT, mpcd_r_commands.Button_10,			233)
elements["PTN_234"] = 	default_button(_("MPCD Right Button 11"), 									devices.MPCD_RIGHT, mpcd_r_commands.Button_11,			234)
elements["PTN_235"] = 	default_button(_("MPCD Right Button 12"), 									devices.MPCD_RIGHT, mpcd_r_commands.Button_12,			235)
elements["PTN_236"] = 	default_button(_("MPCD Right Button 13"), 									devices.MPCD_RIGHT, mpcd_r_commands.Button_13,			236)
elements["PTN_237"] = 	default_button(_("MPCD Right Button 14"), 									devices.MPCD_RIGHT, mpcd_r_commands.Button_14,			237)
elements["PTN_238"] = 	default_button(_("MPCD Right Button 15"), 									devices.MPCD_RIGHT, mpcd_r_commands.Button_15,			238)
elements["PTN_239"] = 	default_button(_("MPCD Right Button 16"), 									devices.MPCD_RIGHT, mpcd_r_commands.Button_16,			239)
elements["PTN_240"] = 	default_button(_("MPCD Right Button 17"), 									devices.MPCD_RIGHT, mpcd_r_commands.Button_17,			240)
elements["PTN_241"] = 	default_button(_("MPCD Right Button 18"), 									devices.MPCD_RIGHT, mpcd_r_commands.Button_18,			241)
elements["PTN_242"] = 	default_button(_("MPCD Right Button 19"), 									devices.MPCD_RIGHT, mpcd_r_commands.Button_19,			242)
elements["PTN_243"] = 	default_button(_("MPCD Right Button 20"),									devices.MPCD_RIGHT, mpcd_r_commands.Button_20,			243)
elements["PTN_244_1"]	= AMPCD_switch_negative(_("MPCD Right Display DAY Mode"),					devices.MPCD_RIGHT, mpcd_r_commands.Switch_DAY_MODE,	244)
elements["PTN_244_2"]	= AMPCD_switch_positive(_("MPCD Right Display NIGHT Mode"),					devices.MPCD_RIGHT, mpcd_r_commands.Switch_NGT_MODE,	244)
elements["PTN_245_1"]	= AMPCD_switch_positive(_("MPCD Right Symbology, UP"),						devices.MPCD_RIGHT, mpcd_r_commands.Switch_SYM_UP,		245)
elements["PTN_245_2"]	= AMPCD_switch_negative(_("MPCD Right Symbology, DOWN"),					devices.MPCD_RIGHT, mpcd_r_commands.Switch_SYM_DN,		245)
elements["PTN_246_1"]	= AMPCD_switch_positive(_("MPCD Right Video Gain, UP"),						devices.MPCD_RIGHT, mpcd_r_commands.Switch_GAIN_UP,		246)
elements["PTN_246_2"]	= AMPCD_switch_negative(_("MPCD Right Video Gain, DOWN"),					devices.MPCD_RIGHT, mpcd_r_commands.Switch_GAIN_DN,		246)
elements["PTN_247_1"]	= AMPCD_switch_positive(_("MPCD Right Video Contrast, UP"),					devices.MPCD_RIGHT, mpcd_r_commands.Switch_CONT_UP,		247)
elements["PTN_247_2"]	= AMPCD_switch_negative(_("MPCD Right Video Contrast, DOWN"),				devices.MPCD_RIGHT, mpcd_r_commands.Switch_CONT_DN,		247)
elements["PTN_195"] = 	default_axis_limited(_("MPCD Right Off/Brightness Control"),				devices.MPCD_RIGHT, mpcd_r_commands.Knob_OFF_BRT,		195, 0, 0.1, true, false, {0, 1})

-- Armament Control Panel ACP
elements["PTN_395"] = multiposition_switch_limited_animated(_("Manual Release Control Knob"),	devices.SMC, smc_commands.Knob_Bomb_Fuze,    395, 4, 0.33, false, 0)
elements["PTN_395"].sound = {{SOUND_SW11_ON}, {SOUND_SW11_OFF}}
elements["PTN_396"] = default_2_way_spring_switch(_("Armament Mode Control"),					devices.SMC, smc_commands.Switch_ARMT,       396)
elements["PTN_397"] = default_2_way_spring_switch(_("Fuzing Control"),							devices.SMC, smc_commands.Switch_FUZE,       397)
elements["PTN_398"] = default_2_way_spring_switch(_("Quantity Selector (Tens)"),				devices.SMC, smc_commands.Switch_QTY_10,     398)
elements["PTN_399"] = default_2_way_spring_switch(_("Quantity Selector (Units)"),				devices.SMC, smc_commands.Switch_QTY_01,     399)
elements["PTN_400"] = default_2_way_spring_switch(_("Multiple Release Control"),				devices.SMC, smc_commands.Switch_MULT,       400)
elements["PTN_401"] = default_2_way_spring_switch(_("Release Interval Control (Hundreds)"),		devices.SMC, smc_commands.Switch_INTV_100,   401)
elements["PTN_402"] = default_2_way_spring_switch(_("Release Interval Control (Tens)"),			devices.SMC, smc_commands.Switch_INTV_010,   402)
elements["PTN_403"] = default_2_way_spring_switch(_("Release Interval Control (Units)"),		devices.SMC, smc_commands.Switch_INTV_001,   403)
elements["PTN_404"] = multiposition_switch_limited_animated(_("Jettison Mode Selector"),		devices.SMC, smc_commands.Knob_JETT,         404, 5, 0.5, false, -1.0)
elements["PTN_405"] = default_button(_("Jettison Stores"),										devices.SMC, smc_commands.Button_JETT,       405)
elements["PTN_407"] = default_button(_("Select Station 1 Toggle"),								devices.SMC, smc_commands.Button_1,          407)
elements["PTN_409"] = default_button(_("Select Station 2 Toggle"),								devices.SMC, smc_commands.Button_2,          409)
elements["PTN_411"] = default_button(_("Select Station 3 Toggle"),								devices.SMC, smc_commands.Button_3,          411)
elements["PTN_413"] = default_button(_("Select Station 4 Toggle"),								devices.SMC, smc_commands.Button_4,          413)
elements["PTN_415"] = default_button(_("Select Station 5 Toggle"),								devices.SMC, smc_commands.Button_5,          415)
elements["PTN_417"] = default_button(_("Select Station 6 Toggle"),								devices.SMC, smc_commands.Button_6,          417)
elements["PTN_419"] = default_button(_("Select Station 7 Toggle"),								devices.SMC, smc_commands.Button_7,          419)
elements["PTN_420"] = default_2_position_tumb_animated(_("Ground IR Cool Switch"),				devices.SMC, smc_commands.Switch_IR_COOL,    420)
elements["PTN_420"].sound = {{SOUND_SW2}, {SOUND_SW2}}

-- Master Armament Panel
elements["PTN_286"] = default_button(_("Launch Flare Salvo"),									devices.EWS,	smc_commands.Switch_FLR_SAL,    286)
elements["PTN_287"] = default_2_position_tumb_animated(_("Master Arm Switch"),					devices.SMC,	smc_commands.Switch_Master_Arm, 287)
elements["PTN_287"].sound = {{SOUND_SW2}, {SOUND_SW2}}

-- ECM Control Panel
elements["PTN_273"] = default_axis_limited(_("RWR Power/Volume Button"),						devices.RWRCONTROL,	rwr_commands.Knob_RWR, 273,  0, 0.10, true, false, {0.0, 1.0})
elements["PTN_274"] = multiposition_switch_limited_animated(_("Decoy Dispenser Control"),		devices.EWS,		rwr_commands.Knob_EXP, 274,  5, 0.25, false, 0)
elements["PTN_274"].sound = {{SOUND_SW11_ON}, {SOUND_SW11_OFF}}
elements["PTN_275"] = multiposition_switch_limited_animated(_("Jammer Control"),				devices.EWS,		rwr_commands.Knob_ECM, 275,  5, 0.25, false, 0)
elements["PTN_275"].sound = {{SOUND_SW11_ON}, {SOUND_SW11_OFF}}

-- Landing Gear/Flaps Control Panel
elements["PTN_448"] = default_button(_("Gear Down Lock Override Button"),				devices.FLIGHTCONTROLS,	fcs_commands.Button_GEAR_DN_LOCK,			448)
elements["PTN_454"] = multiposition_switch_limited_animated(_("Flaps Mode Switch"),		devices.VREST,			fcs_commands.Switch_FLAP_SELECT,			454, 3,  0.50, false, 0)
elements["PTN_454"].sound = {{SOUND_SW11_ON}, {SOUND_SW11_OFF}}
elements["PTN_457"] = multiposition_switch_limited_animated(_("Flaps Power Switch"),	devices.VREST,			fcs_commands.Switch_FLAP_PWR,				457, 3,  0.50, false, 0)
elements["PTN_457"].sound = {{SOUND_SW4_ON}, {SOUND_SW4_OFF}}
elements["PTN_458"] = default_button(_("Emergency Jettison Button"),					devices.SMC,			stores_commands.Button_EMERGENCY_JETTISION,	458)
elements["PTN_459"] = multiposition_switch_limited_animated(_("Anti-Skid Switch"),		devices.FLIGHTCONTROLS,	fcs_commands.Switch_ANTISKID,				459, 3,  0.50, false, 0)
elements["PTN_459"].sound = {{SOUND_SW4_ON}, {SOUND_SW4_OFF}}
elements["PTN_460"] = default_button(_("Flaps BIT Button"),								devices.VREST,			fcs_commands.Button_FLAP_BIT,				460)
elements["PTN_461"]	= LDG_Gear_Control_Handle(_("Landing Gear Control Handle, (RMB)UP/(LMB)DOWN/(MW)EMERGENCY DOWN"),	devices.FLIGHTCONTROLS, fcs_commands.Handle_GEAR_LEVER, 461, fcs_commands.Handle_GEAR_LEVER_EMERG, 447, 4.5)

elements["PTN_470"] = default_animated_lever(_("Landing Gear Emergency Battery Lever"),	devices.FLIGHTCONTROLS,	fcs_commands.Handle_GEAR_BATT_LIFT,			470, 5.0)
elements["PTN_470"].sound = {{SOUND_SW3_OPEN}, {SOUND_SW3_CLOSE}}

-- Combat/Water Panel
elements["PTN_449"] = multiposition_switch_limited_animated(_("H2O Mode Switch"),		devices.DECS,	engine_commands.Switch_H20,		449, 3, 0.5, false, 0)
elements["PTN_449"].sound = {{SOUND_SW8_ON}, {SOUND_SW8_OFF}}
elements["PTN_450"] = default_button(_("CMBT Thrust Button"),							devices.DECS,	engine_commands.Button_CMBT,	450)

-- Bulkhead Switches
elements["PTN_501"]  = default_animated_lever(_("MFS Emergency Lever"),					devices.FLIGHTCONTROLS,	fcs_commands.Handle_MFS_EMER_BATT,	501, 5.0)
elements["PTN_1121"] = default_button(_("Stopwatch Start/Stop"),						devices.MSC, 			3051,	1121)
elements["PTN_1122"] = default_button(_("Stopwatch Lap/Reset"),							devices.MSC, 			3052,	1122)

-- Seat
elements["PTN_800"] = default_2_position_tumb_animated(_("Seat Ground Safety Lever"),	devices.MSC,			msc_commands.Seat_SFTY_LVR,		800)
elements["PTN_800"].sound = {{SOUND_LEVER_1_UP},{SOUND_LEVER_1_DOWN}}

-------------------------------------------------------------------
-- CENTER CONSOLE:
-------------------------------------------------------------------
-- Flights Instruments Panel
elements["PTN_364"] = default_2_way_spring_switch(_("NAV Course Setting"),									devices.NAV_INS,			inst_commands.Knob_Course,		364)
elements["PTN_653"] = default_axis_cycle(_("Barometric Pressure Calibration"),								devices.ADC,				inst_commands.Knob_Altimeter,	653, 1, 0.1, false, true)
elements["PTN_351"] = default_button_lever(_("Backup ADI Cage/Pitch Adjust Knob"),							devices.FLIGHTINSTRUMENTS,	inst_commands.ADI_Cage, inst_commands.Knob_ADI, 350, 351)

-- Miscelaneous Switch Panel
elements["PTN_422"] = default_2_position_tumb_animated(_("Video Recorder System Mode Switch"),				devices.NAVFLIR,			misc_commands.Switch_VRS_Mode,		422)
elements["PTN_422"].sound = {{SOUND_SW1}, {SOUND_SW1}}
elements["PTN_423"] = default_2_position_tumb_animated(_("Video Recorder System Display Selector Switch"),	devices.NAVFLIR,			misc_commands.Switch_VRS_Output,	423)
elements["PTN_423"].sound = {{SOUND_SW1}, {SOUND_SW1}}
elements["PTN_424"] = default_2_position_tumb_animated(_("DMT Toggle On/Off"),								devices.DMT,				misc_commands.Switch_DMT_Power,		424)
elements["PTN_424"].sound = {{SOUND_SW1}, {SOUND_SW1}}
elements["PTN_425"] = multiposition_switch_limited_animated(_("Display Computer Mode Selector Switch"),		devices.MSC,				misc_commands.Switch_DP_Mode,		425, 3, 0.50, false, 0)
elements["PTN_425"].sound = {{SOUND_SW4_ON}, {SOUND_SW4_OFF}}
elements["PTN_426"] = default_2_position_tumb_animated(_("Probe Heat Mode Switch"),							devices.FLIGHTINSTRUMENTS,	misc_commands.Switch_PR_HT_Mode,	426)
elements["PTN_426"].sound = {{SOUND_SW1}, {SOUND_SW1}}
elements["PTN_427"] = multiposition_switch_limited_animated(_("Mission Computer Mode Switch"),				devices.MSC,				misc_commands.Switch_MC_Power,		427, 3, 0.50, false, 0)
elements["PTN_427"].sound = {{SOUND_SW4_ON}, {SOUND_SW4_OFF}}
elements["PTN_429"] = default_2_position_tumb_animated(_("FLIR Power Switch"),								devices.NAVFLIR,			misc_commands.Switch_FLIR_Power,	429)
elements["PTN_429"].sound = {{SOUND_SW1}, {SOUND_SW1}}

-- INS Panel
elements["PTN_421"] = multiposition_switch_limited_animated(_("INS Mode Knob"),								devices.NAV_INS,			misc_commands.Knob_INS_Mode,		421, 8,  0.10, false, 0)
elements["PTN_421"].sound = {{SOUND_SW11_ON}, {SOUND_SW11_OFF}}
-------------------------------------------------------------------
-- LEFT CONSOLE:
-------------------------------------------------------------------
-- Trim Panel
elements["PTN_471"] = multiposition_switch_limited_animated(_("RPS/YAW Trim Switch"),	devices.FLIGHTCONTROLS, fcs_commands.Switch_RPS_YAW,	471, 3, 0.5, false, 0)
elements["PTN_471"].sound = {{SOUND_SW4_ON}, {SOUND_SW4_OFF}}
elements["PTN_472"] = multiposition_switch_limited_animated(_("Trim Mode Switch"),		devices.FLIGHTCONTROLS, fcs_commands.Switch_TRIM_MODE,	472, 3, 0.5, false, 0)

-- SAAHS Panel
elements["PTN_476"] = default_2_position_tumb_animated(_("Alt Hold Switch"),			devices.FLIGHTCONTROLS, fcs_commands.Switch_ALT_HOLD,	476)
elements["PTN_476"].sound = {{SOUND_SW1}, {SOUND_SW1}}
elements["PTN_475"] = default_2_position_tumb_animated(_("Q Feel Switch"),				devices.FLIGHTCONTROLS, fcs_commands.Switch_Q_FEEL,		475)
elements["PTN_475"].sound = {{SOUND_SW1}, {SOUND_SW1}}
elements["PTN_477"] = multiposition_switch_limited_animated(_("AFC Switch"),			devices.FLIGHTCONTROLS, fcs_commands.Switch_AFC,		477, 3, 0.5, false, 0)
elements["PTN_477"].sound = {{SOUND_SW4_ON}, {SOUND_SW4_OFF}}
elements["PTN_478"] = default_2_position_tumb_animated(_("SAS Yaw Switch"),				devices.FLIGHTCONTROLS, fcs_commands.Switch_SAS_YAW,	478)
elements["PTN_478"].sound = {{SOUND_SW2}, {SOUND_SW2}}
elements["PTN_479"] = default_2_position_tumb_animated(_("SAS Roll Switch"),			devices.FLIGHTCONTROLS, fcs_commands.Switch_SAS_ROLL,	479)
elements["PTN_479"].sound = {{SOUND_SW2}, {SOUND_SW2}}
elements["PTN_480"] = default_2_position_tumb_animated(_("SAS Pitch Switch"),			devices.FLIGHTCONTROLS, fcs_commands.Switch_SAS_PITCH,	480)
elements["PTN_480"].sound = {{SOUND_SW2}, {SOUND_SW2}}

-- Throttle Quadrant
elements["PTN_481"] = default_2_position_tumb_animated(_("JPTL Switch"),				devices.DECS,			engine_commands.Switch_JPTL,			481)
elements["PTN_481"].sound = {{SOUND_SW1}, {SOUND_SW1}}
elements["PTN_483"] = default_2_way_spring_switch(_("Rudder Trim Switch"),				devices.FLIGHTCONTROLS,	fcs_commands.Switch_RUDDER_TRIM,		483, true)
elements["PTN_482"] = default_button(_("EMS Button"),									devices.DECS,			engine_commands.Button_EMS,				482)
elements["PTN_484"] = default_2_position_tumb_animated(_("Manual Fuel Switch"),			devices.DECS,			engine_commands.Switch_MAN_FUEL,		484)
elements["PTN_484"].sound = {{SOUND_SW1}, {SOUND_SW1}}
elements["PTN_485"] = default_axis_limited(_("Throttle Lever Friction Knob"),			devices.FLIGHTCONTROLS,	fcs_commands.Knob_FRICTION_LEFT,		485, 0, 0.1, true, 0, {0, 1.0})
elements["PTN_486"] = default_axis_limited(_("Nozzle Lever Friction Knob"),				devices.FLIGHTCONTROLS,	fcs_commands.Knob_FRICTION_RIGHT,		486, 0, 0.1, true, 0, {0, 1.0})
elements["PTN_490"] = default_animated_lever(_("Throttle Cutoff Lever"),				devices.DECS,			engine_commands.Handle_THROTTLE_CUTOFF,	490, 5.0)
elements["PTN_489"] = default_animated_lever(_("Parking Brake Lever"),					devices.FLIGHTCONTROLS,	fcs_commands.Handle_PARKING_BRAKE,		489, 5.0)
elements["PTN_487"] = default_axis_limited(_("Nozzle Control Lever"),					devices.VREST,			engine_commands.Handle_NOZZLE_CONTROL,	487, 0, -0.1, true, 0, 1)
elements["PTN_488"] = multiposition_switch_limited_animated(_("STO Stop Lever"),	    devices.VREST,          engine_commands.Handle_NOZZLE_STO_STOP,	488, 14, 0.05, false, 0.35, 20)
--elements["PTN_491"] = default_2_position_tumb_animated(_("Air Brake Switch"),			devices.FLIGHTCONTROLS,	engine_commands.Switch_AIR_BRAKE,		491)

-- Fuel Panel
elements["PTN_504"] = default_2_position_tumb_animated(_("Fuel Proportioner"),					devices.DECS, engine_commands.Switch_FUEL_PROP,		504)
elements["PTN_504"].sound = {{SOUND_SW8_ON}, {SOUND_SW8_OFF}}
elements["PTN_505"] = multiposition_switch_limited_animated(_("Fuel Pump L Switch"),			devices.DECS, engine_commands.Switch_FUEL_PUMP_L,	505, 3, 0.5, false, 0)
elements["PTN_505"].sound = {{SOUND_SW11_ON}, {SOUND_SW11_OFF}}
elements["PTN_506"] = multiposition_switch_limited_animated(_("Fuel Pump R Switch"),			devices.DECS, engine_commands.Switch_FUEL_PUMP_R,	506, 3, 0.5, false, 0)
elements["PTN_506"].sound = {{SOUND_SW11_ON}, {SOUND_SW11_OFF}}
elements["PTN_507"] = multiposition_switch_limited_animated(_("Air Refueling Probe Switch"),	devices.DECS, engine_commands.Switch_FUEL_PRESS,	507, 3, 0.5, false, 0)
elements["PTN_507"].sound = {{SOUND_SW2}, {SOUND_SW2}}
elements["PTN_508"] = default_2_position_tumb_animated(_("Fuel Dump L Switch"),					devices.DECS, engine_commands.Switch_FUEL_DUMP_L,	508)
elements["PTN_508"].sound = {{SOUND_SW2}, {SOUND_SW2}}
elements["PTN_509"] = default_2_position_tumb_animated(_("Fuel Dump R Switch"),					devices.DECS, engine_commands.Switch_FUEL_DUMP_R,	509)
elements["PTN_509"].sound = {{SOUND_SW2}, {SOUND_SW2}}

-- External Lights Panel
elements["PTN_472"] = multiposition_switch_limited_animated(_("Landing/Taxi Lights Switch"),	devices.LTEXT, ext_light_commands.Switch_LANDING_LT, 		472, 3, 0.5, false, 0)
elements["PTN_472"].sound = {{SOUND_SW4_ON}, {SOUND_SW4_OFF}}
elements["PTN_503"] = multiposition_switch_limited_animated(_("External Lights Mode Switch"),	devices.LTEXT, ext_light_commands.Switch_EXT_LT_NORM_NVG,	503, 3, 0.5, false, 0)
elements["PTN_503"].sound = {{SOUND_SW4_ON}, {SOUND_SW4_OFF}}
elements["PTN_510"] = default_axis_limited(_("Formation Lights Knob"), 							devices.LTEXT, ext_light_commands.Knob_FORM_LT,				510, 0, 0.2, true, 0, {0, 1.0})
elements["PTN_511"] = multiposition_switch_limited_animated(_("Position Lights Switch"),		devices.LTEXT, ext_light_commands.Switch_POS_LT,			511, 3, 0.5, false, 0)
elements["PTN_511"].sound = {{SOUND_SW4_ON}, {SOUND_SW4_OFF}}
elements["PTN_512"] = default_2_position_tumb_animated(_("Anti-Collision Lights Switch"),		devices.LTEXT, ext_light_commands.Switch_ANTI_COLL_LT,		512)
elements["PTN_512"].sound = {{SOUND_SW1}, {SOUND_SW1}}
elements["PTN_513"] = default_2_position_tumb_animated(_("External Auxiliary Lights Switch"),	devices.LTEXT, ext_light_commands.Switch_AUX_LT,			513)
elements["PTN_513"].sound = {{SOUND_SW1}, {SOUND_SW1}}

-- Pilot Service Panel
elements["PTN_514"] = default_2_position_tumb_animated(_("Oxygen Switch"), 						devices.ECS,   psp_commands.Switch_OXY,			514)
elements["PTN_514"].sound = {{SOUND_SW2}, {SOUND_SW2}}
elements["PTN_515"] = default_2_position_tumb_animated(_("H2O Dump Switch"),					devices.DECS,  engine_commands.Switch_H20_DUMP,	515)
elements["PTN_515"].sound = {{SOUND_SW2}, {SOUND_SW2}}
elements["PTN_516"] = default_2_position_tumb_animated(_("LIDS Switch"),						devices.VREST, engine_commands.Switch_LIDS,		516)
elements["PTN_516"].sound = {{SOUND_SW2}, {SOUND_SW2}}
elements["PTN_517"] = default_2_position_tumb_animated(_("ENG RPM Switch"),						devices.DECS,  engine_commands.Switch_ENG_RPM,	517)
elements["PTN_517"].sound = {{SOUND_SW2}, {SOUND_SW2}}
elements["PTN_518"] = default_2_position_tumb_animated(_("EFC Switch"),							devices.DECS,  engine_commands.Switch_EFC,		518)
elements["PTN_518"].sound = {{SOUND_SW1}, {SOUND_SW1}}

-- Bulkhead Switches
elements["PTN_502"] = default_2_way_spring_switch(_("Seat Adjustment Switch"),					devices.MSC,	msc_commands.Switch_SEAT_ADJ,			502, true)
elements["PTN_519"] = default_2_position_tumb_animated(_("Fuel Shutoff Lever"),					devices.DECS,	engine_commands.Handle_FUEL_SHUT_OFF,	519)
elements["PTN_519"].sound = {{SOUND_LEVER_1_DOWN}, {SOUND_LEVER_1_UP}}
elements["PTN_520"] = default_2_position_tumb_animated(_("DECS Switch"),						devices.DECS,	engine_commands.Switch_DECS,			520)
elements["PTN_520"].sound = {{SOUND_SW2}, {SOUND_SW2}}

-------------------------------------------------------------------
-- RIGHT CONSOLE:
-------------------------------------------------------------------
-- Electrical Panel
elements["PTN_609"] = multiposition_switch_limited_animated(_("DC Test Switch"),				devices.ELECTRIC, elec_commands.Switch_DC_TEST, 609, 3, 0.5, false, 0)
elements["PTN_609"].sound = {{SOUND_SW4_ON}, {SOUND_SW4_OFF}}
elements["PTN_610"] = { class       = {class_type.TUMB, class_type.BTN},
                        hint        = _("APU Generator Switch") , 
                        device      = devices.ELECTRIC, 
                        arg         = {610, 610},
                        arg_value 	= {0.5, 1},
                        arg_lim     = {{0, 0.5},{0.5, 1.0}},
                        action      = {elec_commands.Switch_APU_GEN,elec_commands.Switch_APU_GEN},
                        stop_action = {0, elec_commands.Switch_APU_GEN}, 
                        stop_value  = {nil, 0.5},                                   
                        use_release_message = {false, false}}
elements["PTN_610"].sound = {{SOUND_SW2}, {SOUND_SW2}}                        

elements["PTN_611"] = default_2_position_tumb_animated(_("Engine Start Switch"),				devices.ELECTRIC, elec_commands.Switch_ENG_START, 611)
elements["PTN_611"].sound = {{SOUND_SW2}, {SOUND_SW2}}
elements["PTN_612"] = multiposition_switch_limited_animated(_("Generator Switch"),				devices.ELECTRIC, elec_commands.Switch_GEN, 612, 3, 0.5, false, 0)
elements["PTN_612"].sound = {{SOUND_SW4_ON}, {SOUND_SW4_OFF}}
elements["PTN_613"] = multiposition_switch_limited_animated(_("Battery Switch"),				devices.ELECTRIC, elec_commands.Switch_BATT, 613, 3, 0.5, false, 0)
elements["PTN_613"].sound = {{SOUND_SW2}, {SOUND_SW2}}

-- V/UHF Radio Panel
elements["PTN_614"] = default_axis_limited(_("V/UHF RSC Volume Knob"),								devices.RSC, radio_commands.Knob_VOLUME,		614, 0, 0.1, true, 0, {0, 1.0})
elements["PTN_615"] = default_axis_cycle(_("V/UHF RSC Chan/Freq Knob"),								devices.RSC, radio_commands.Knob_CHAN_FREQ,		615, 0, 0.1, false, true)
elements["PTN_616"] = multiposition_switch_limited_animated(_("V/UHF RSC Operational Mode Switch"),	devices.RSC, radio_commands.Switch_OP_MODE,		616, 7, 0.20, false, -0.2)
elements["PTN_616"].sound = {{SOUND_SW11_ON}, {SOUND_SW11_OFF}}
elements["PTN_617"] = default_button(_("V/UHF RSC Ancillary Mode Pointer"),							devices.RSC, radio_commands.Button_A_MODE,		617)
elements["PTN_618"] = default_button(_("V/UHF RSC Ancillary Mode Switch"),							devices.RSC, radio_commands.Button_P_MODE,		618)
elements["PTN_619"] = multiposition_switch_limited_animated(_("V/UHF RSC Frequency Mode Switch"),	devices.RSC, radio_commands.Switch_FREQ_MODE,	619, 8,  0.15, false, 0.0)
elements["PTN_619"].sound = {{SOUND_SW11_ON}, {SOUND_SW11_OFF}}
elements["PTN_620"] = default_button(_("V/UHF RSC LOAD/OFST Switch"),								devices.RSC, radio_commands.Button_LOAD_OFST,	620)

-- ACNIP
elements["PTN_621"] = default_2_position_tumb_animated(_("ACNIP Mode Switch"),						devices.ACNIP, acnip_commands.Switch_MODE,		621)
elements["PTN_621"].sound = {{SOUND_SW1}, {SOUND_SW1}}
elements["PTN_622"] = default_2_position_tumb_animated(_("KY-1 Cipher Type Selector Switch"),		devices.ACNIP, acnip_commands.Switch_KY1,		622)
elements["PTN_622"].sound = {{SOUND_SW2}, {SOUND_SW2}}
elements["PTN_623"] = default_2_position_tumb_animated(_("KY-2 Cipher Type Selector Switch"),		devices.ACNIP, acnip_commands.Switch_KY2,		623)
elements["PTN_623"].sound = {{SOUND_SW2}, {SOUND_SW2}}
elements["PTN_624"] = default_2_position_tumb_animated(_("KY-1 Code/Mode Switch"),					devices.ACNIP, acnip_commands.Switch_KY1_MODE,	624)
elements["PTN_624"].sound = {{SOUND_SW1}, {SOUND_SW1}}
elements["PTN_625"] = default_2_position_tumb_animated(_("KY-2 Code/Mode Switch"),					devices.ACNIP, acnip_commands.Switch_KY2_MODE,	625)
elements["PTN_625"].sound = {{SOUND_SW1}, {SOUND_SW1}}
elements["PTN_626"] = default_2_position_tumb_animated(_("ACNIP Radio Selector Switch"),			devices.ACNIP, acnip_commands.Switch_PRGM,		626)
elements["PTN_626"].sound = {{SOUND_SW2}, {SOUND_SW2}}
elements["PTN_627"] = default_2_position_tumb_animated(_("KY-58 Codes Clear Switch"),				devices.ACNIP, acnip_commands.Switch_KY_ZERO,	627)
elements["PTN_627"].sound = {{SOUND_SW2}, {SOUND_SW2}}
elements["PTN_628"] = default_3_position_tumb_animated(_("KY-58 Remote Codes Load Switch"),			devices.ACNIP, acnip_commands.Switch_KY_RVI,	628, false, true)
elements["PTN_628"].sound = {{SOUND_SW2}, {SOUND_SW2}}

-- ICS
elements["PTN_629"] = default_axis_limited(_("ICS Aux Volume Knob"),								devices.INTERCOM, acnip_commands.Knob_AUX_VOL,		629, 0, 0.1, true, 0, {0, 1.0})
elements["PTN_630"] = default_axis_limited(_("ICS Ground Volume Knob"),								devices.INTERCOM, acnip_commands.Knob_GND_VOL,		630, 0, 0.1, true, 0, {0, 1.0})
elements["PTN_631"] = multiposition_switch_limited_animated(_("ICS Mic Operational Mode Switch"),	devices.INTERCOM, acnip_commands.Switch_MIC,		631, 3, 0.5,  false, 0)
elements["PTN_631"].sound = {{SOUND_SW4_ON}, {SOUND_SW4_OFF}}

-- IFF
elements["PTN_632"] = default_2_position_tumb_animated(_("IFF Operational Mode Switch"),			devices.ACNIP, acnip_commands.Switch_IFF_OPMODE,	632)
elements["PTN_632"].sound = {{SOUND_SW2}, {SOUND_SW2}}
elements["PTN_633"] = default_3_position_tumb_animated(_("IFF Crypto Mode Switch"),					devices.ACNIP, acnip_commands.Switch_IFF_CRYPTO,	633, false, true)
elements["PTN_633"].sound = {{SOUND_SW2}, {SOUND_SW2}}

-- Interior Lights Panel
elements["PTN_634"] = { class       = {class_type.TUMB, class_type.BTN},
                        hint        = _("Compass Light/Test Lights") , 
                        device      = devices.LTINT, 
                        arg         = {634, 634},
                        arg_value 	= {0.5, 1},
                        arg_lim     = {{0, 0.5},{0.5, 1.0}},
                        action      = {int_light_commands.Switch_Compass_Light_Test,int_light_commands.Switch_Compass_Light_Test},
                        stop_action = {0, int_light_commands.Switch_Compass_Light_Test}, 
                        stop_value  = {nil, 0.5},                                   
                        use_release_message = {false, false}}
elements["PTN_634"].sound = {{SOUND_SW4_ON}, {SOUND_SW4_OFF}}                        
                        
elements["PTN_635"] = default_axis_limited(_("Instruments Lights"),				devices.LTINT,	int_light_commands.Knob_Instr_Lights,			635, 0, 0.1, true, 0, {0, 1.0})
elements["PTN_636"] = default_axis_limited(_("Console Lights"),					devices.LTINT,	int_light_commands.Knob_Console_Lights,			636, 0, 0.1, true, 0, {0, 1.0})
elements["PTN_637"] = default_axis_limited(_("Flood Lights"),					devices.LTINT,	int_light_commands.Knob_Flood_Lights,			637, 0, 0.1, true, 0, {0, 1.0})
elements["PTN_638"] = default_axis_limited(_("Annunciator Lights"),				devices.LTINT,	int_light_commands.Knob_Annunciator_Lights,		638, 0, 0.1, true, 0, {0, 0.9})

-- ECS Panel
elements["PTN_639"] = default_axis_limited(_("Temperature Control Knob"), 						devices.ECS, ecs_commands.Knob_TEMP, 639, 0, 0.1, true, 0, {0, 1.0})
elements["PTN_640"] = default_2_way_spring_switch(_("Fwd Equipment Bay ECS Switch"),			devices.ECS, ecs_commands.Switch_FWD_EQUIP, 640)
elements["PTN_641"] = multiposition_switch_limited_animated(_("Cabin Defog Switch"),			devices.ECS, ecs_commands.Switch_CABIN, 641, 3, 0.5, false, 0)
elements["PTN_641"].sound = {{SOUND_SW4_ON}, {SOUND_SW4_OFF}}
elements["PTN_642"] = multiposition_switch_limited_animated(_("Aft Equipment Bay ECS Switch"),	devices.ECS, ecs_commands.Switch_AFT_EQUIP, 642, 3, 0.5, false, 0)
elements["PTN_642"].sound = {{SOUND_SW4_ON}, {SOUND_SW4_OFF}}
elements["PTN_643"] = multiposition_switch_limited_animated(_("Cabin Pressure Switch"),			devices.ECS, ecs_commands.Switch_PRESS, 643, 3, 0.5, false, 0)
elements["PTN_643"].sound = {{SOUND_SW2}, {SOUND_SW2}}

-- VRS Panel
-- @todo others already in command defs

-- Rear Tub Wall Right Panel
-- @todo others already in command defs

-------------------------------------------------------------------
-- FLOOD LAMPS:
-------------------------------------------------------------------
elements["PTN_150"] = default_axis_limited(_("Flood Lamp"),						devices.LTINT, int_light_commands.Flood_Right_Canopy_Frame_Top,	150, 0, -0.25, true, 0, {-1, 1})
elements["PTN_151"] = default_axis_limited(_("Flood Lamp"),						devices.LTINT, int_light_commands.Flood_Right_Canopy_Frame_Btm,	151, 0, -0.25, true, 0, {-1, 1})
elements["PTN_152"] = default_axis_limited(_("Flood Lamp"),						devices.LTINT, int_light_commands.Flood_Right_BH_FWD,			152, 0, -0.25, true, 0, {-1, 1})
elements["PTN_153"] = default_axis_limited(_("Flood Lamp"),						devices.LTINT, int_light_commands.Flood_Right_BH_AFT_Front,		153, 0, -0.25, true, 0, {-1, 1})
elements["PTN_154"] = default_axis_limited(_("Flood Lamp"),						devices.LTINT, int_light_commands.Flood_Right_BH_AFT_Back,		154, 0, -0.25, true, 0, {-1, 1})
elements["PTN_155"] = default_axis_limited(_("Flood Lamp"),						devices.LTINT, int_light_commands.Flood_Left_BH_AFT_Back,		155, 0, -0.25, true, 0, {-1, 1})
elements["PTN_156"] = default_axis_limited(_("Flood Lamp"),						devices.LTINT, int_light_commands.Flood_Left_BH_AFT_Front,		156, 0, -0.25, true, 0, {-1, 1})
elements["PTN_157"] = default_axis_limited(_("Flood Lamp"),						devices.LTINT, int_light_commands.Flood_Left_BH_FWD,			157, 0, -0.25, true, 0, {-1, 1})
elements["PTN_158"] = default_axis_limited(_("Flood Lamp"),						devices.LTINT, int_light_commands.Flood_Left_Canopy_Frame_Btm,	158, 0, -0.25, true, 0, {-1, 1})
elements["PTN_159"] = default_axis_limited(_("Flood Lamp"),						devices.LTINT, int_light_commands.Flood_Left_Canopy_Frame_Top,	159, 0, -0.25, true, 0, {-1, 1})

-------------------------------------------------------------------
-- CANOPY CONTROLS:
-------------------------------------------------------------------
elements["PTN_801"] = default_2_position_tumb(_("Canopy Handle"),			devices.FLIGHTCONTROLS, misc_commands.canopy_left_handle,	801)
elements["PTN_802"] = default_2_position_tumb(_("Canopy Handle"),			devices.FLIGHTCONTROLS, misc_commands.canopy_right_handle,	802)
elements["PTN_803"] = default_2_position_tumb_animated(_("Canopy Locking Lever"),	devices.FLIGHTCONTROLS, misc_commands.canopy_lock_lever,	803)
elements["PTN_803"].sound = {{SOUND_SW9_UP}, {SOUND_SW9_DOWN}}

-------------------------------------------------------------------
-- MISC CONTROLS:
-------------------------------------------------------------------
elements["PTN_1124"] = default_2_position_tumb(_("Mirror Rendering Toggle"),	devices.FLIGHTINSTRUMENTS,	misc_commands.mirror_left, 1124)
elements["PTN_1125"] = default_2_position_tumb(_("Mirror Rendering Toggle"),	devices.FLIGHTINSTRUMENTS,	misc_commands.mirror_center, 1125)
elements["PTN_1126"] = default_2_position_tumb(_("Mirror Rendering Toggle"),	devices.FLIGHTINSTRUMENTS,	misc_commands.mirror_right, 1126)
elements["PTN_999"] = default_2_position_tumb(_("Show/Hide Controls"),	devices.FLIGHTCONTROLS,	misc_commands.stick_vis, 999)

--default_animated_lever(hint_, device_, command_, arg_, animation_speed_,arg_lim_)
--elements["PTN_461"] = default_animated_lever(_("Landing Gear Lever"),					devices.FLIGHTCONTROLS,	fcs_commands.Handle_GEAR_LEVER,				461, 5.0)

-- Add more lines in command_defs.lua if needed

for i,o in pairs(elements) do
    if  o.class[1] == class_type.TUMB or
       (o.class[2]  and o.class[2] == class_type.TUMB) or
       (o.class[3]  and o.class[3] == class_type.TUMB)  then
       o.updatable = true
       o.use_OBB   = true
    end
end
