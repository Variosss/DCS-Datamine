-- F1CE/BE/EE common clickable data description

local gettext = require("i_18n")
_ = gettext.translate

RWR_type = RWR_type or "BF"

----------------------------------------------------------------
-- Armament control panel

-- Sight selector
elements["PNT-590"] = multiposition_switch(_("Sight selector"), 0, devices.MAIN, devCmds.Cmd580, 590, 3, 0.5, nil, nil, nil, sounds.sound_warning_horn_sw)
-- Bomb/Rocket selector
elements["PNT-592"] = multiposition_switch(_("Bomb/Rocket selector"), 0, devices.MAIN, devCmds.Cmd581, 592, 3, 0.5, nil, nil, nil, sounds.sound_warning_horn_sw)
-- MATRA 550 or Sidewinder missile switch
elements["PNT-593"] = default_2_position_tumb(_("MATRA 550 or Sidewinder missile switch"), 0, devices.MAIN, devCmds.Cmd582, 593, nil, nil, nil, nil, sounds.sound_warning_horn_sw)
-- Fore/Aft selector switch
elements["PNT-594"] = default_2_position_tumb(_("Fore/Aft selector switch"), 0, devices.MAIN, devCmds.Cmd583, 594, nil, nil, nil, nil, sounds.sound_warning_horn_sw)
-- Auto/Manual firing selector switch
elements["PNT-595"] = default_2_position_tumb(_("Auto/Manual firing selector switch"), 0, devices.MAIN, devCmds.Cmd584, 595, nil, nil, nil, nil, sounds.sound_warning_horn_sw)
-- Single/Salvo selector
elements["PNT-596"] = default_2_position_tumb(_("Single/Salvo selector"), 0, devices.MAIN, devCmds.Cmd585, 596, nil, nil, nil, nil, sounds.sound_warning_horn_sw)
-- Instantaneous/Delay/Safe selector switch
elements["PNT-597"] = multiposition_switch(_("Instantaneous/Delay/Safe selector switch"), 0, devices.MAIN, devCmds.Cmd586, 597, 3, 0.5, nil, nil, nil, sounds.sound_warning_horn_sw)

-- Armament control panel - lighted pushbutton selectors

-- Left MATRA R550 or Sidewinder missile pushbutton
elements["PNT-604"] = default_2_position_tumb(_("Left MATRA R550 or Sidewinder missile pushbutton"), 0, devices.MAIN, devCmds.Cmd587, 604, 1, {0, 1}, true, false, nil, false)
-- Left or fuselage MATRA R530 missile pushbutton
elements["PNT-606"] = default_2_position_tumb(_("Left or fuselage MATRA R530 missile pushbutton"), 0, devices.MAIN, devCmds.Cmd588, 606, 1, {0, 1}, true, false, nil, false)
-- Air-to-Air guns pushbutton
elements["PNT-608"] = default_2_position_tumb(_("Air-to-Air guns pushbutton"), 0, devices.MAIN, devCmds.Cmd589, 608, 1, {0, 1}, true, false, nil, false)
-- Wing bombs pushbutton
elements["PNT-610"] = default_2_position_tumb(_("Wing bombs pushbutton"), 0, devices.MAIN, devCmds.Cmd590, 610, 1, {0, 1}, true, false, nil, false)
-- Right MATRA R550 or Sidewinder missile pushbutton
elements["PNT-612"] = default_2_position_tumb(_("Right MATRA R550 or Sidewinder missile pushbutton"), 0, devices.MAIN, devCmds.Cmd591, 612, 1, {0, 1}, true, false, nil, false)
-- Right MATRA R530 missile pushbutton
elements["PNT-614"] = default_2_position_tumb(_("Right MATRA R530 missile pushbutton"), 0, devices.MAIN, devCmds.Cmd592, 614, 1, {0, 1}, true, false, nil, false)
-- Air-to-Ground guns or rockets pushbutton
elements["PNT-616"] = default_2_position_tumb(_("Air-to-Ground guns or rockets pushbutton"), 0, devices.MAIN, devCmds.Cmd593, 616, 1, {0, 1}, true, false, nil, false)
-- Fuselage bombs pushbutton
elements["PNT-618"] = default_2_position_tumb(_("Fuselage bombs pushbutton"), 0, devices.MAIN, devCmds.Cmd594, 618, 1, {0, 1}, true, false, nil, false)


-- Armament control panel - continued

-- R 530 Missile Normal/Altitude difference selector switch
elements["PNT-601"] = default_2_position_tumb(_("R 530 Missile Normal/Altitude difference selector switch"), 0, devices.MAIN, devCmds.Cmd595, 601, nil, nil, nil, nil, sounds.sound_warning_horn_sw)
-- Normal/Jammer pursuit switch
elements["PNT-603"] = default_2_position_tumb(_("Normal/Jammer pursuit switch (No function)"), 0, devices.MAIN, devCmds.Cmd596, 603, nil, nil, nil, nil, sounds.sound_warning_horn_sw)
-- Armament panel lights test
elements["PNT-602"] = default_button(_("Armament panel lights test"), 0, devices.MAIN, devCmds.Cmd597, 602)


-- CE/BE - the switches located on the armament control panel
-- EE - a group of switches on the front panel
-- Radar selector
elements["PNT-598"] = multiposition_switch(_("Radar selector"), 0, devices.MAIN, devCmds.Cmd613, 598, 3, 0.5, nil, nil, nil, sounds.sound_arthur_sw)
-- Radar emergency transmission button
elements["PNT-599"] = default_button(_("Radar emergency transmission button"), 0, devices.MAIN, devCmds.Cmd614, 599)
-- Radar 4 lines/1 line scan switch
elements["PNT-600"] = default_2_position_tumb(_("Radar 4 lines/1 line scan switch"), 0, devices.MAIN, devCmds.Cmd615, 600, nil, nil, nil, nil, sounds.sound_warning_horn_sw)


----------------------------------------------------------------
-- Radar indicator scope control box

-- Indicator lights brightness
elements["PNT-632"] = default_axis_limited(_("Indicator lights brightness"), 0, devices.MAIN, devCmds.Cmd618, 632)
-- Strobe brightness
elements["PNT-633"] = default_axis_limited(_("Strobe brightness"), 0, devices.MAIN, devCmds.Cmd620, 633)
-- Distance markers brightness
elements["PNT-634"] = default_axis_limited(_("Distance markers brightness"), 0, devices.MAIN, devCmds.Cmd622, 634)
-- Horizon and radial velocity marker brightness
elements["PNT-635"] = default_axis_limited(_("Horizon and radial velocity marker brightness"), 0, devices.MAIN, devCmds.Cmd624, 635)
-- Horizon symbol vertical position
elements["PNT-636"] = default_axis_limited(_("Horizon symbol vertical position"), 0, devices.MAIN, devCmds.Cmd626, 636)

-- Radar cover
elements["PNT-864"] = default_2_position_tumb(_("Radar cover remove toggle"), 0, devices.MAIN, devCmds.Cmd628, 864, 1, {0, 1}, true, false, sounds.sound_silence, false)

---------------------------------------------------------------
-- Radar detector indicator - Type BF
if RWR_type == "BF" then
	-- Indicator lights intensity adjusting switch and lights 'T' test button
	elements["PNT-1237"] = default_button_axis(_("Indicator lights intensity adjusting switch and lights 'T' test button"), 0, devices.MAIN, devCmds.Cmd573, devCmds.Cmd574, 1290, 1237, nil, nil, sounds.sound_RWR_T_test)
	-- Radar detector indicator test switch
	elements["PNT-1238"] = springloaded_2pos_switch(_("Radar detector indicator test switch"), 0, devices.MAIN, devCmds.Cmd577, devCmds.Cmd576, 1238, false, nil, sounds.sound_RWR_test)
end

----------------------------------------------------------------
-- Armament master switch
elements["PNT-432"] = guard_switch(_("Armament master switch guard"), 0, devices.MAIN, devCmds.Cmd143, 432, true, sounds.sound_AB_main_cock_sw_guard)
elements["PNT-433"] = multiposition_switch(_("Armament master switch"), 0, devices.MAIN, devCmds.Cmd144, 433, 3, 0.5, nil, nil, nil, sounds.sound_arthur_sw)

----------------------------------------------------------------
-- ANTENNA-GYRO switch
elements["PNT-408"] = default_2_position_tumb(_("ANTENNA-GYRO switch"), 0, devices.MAIN, devCmds.Cmd453, 408, 1, {0, 1}, true, true, sounds.sound_arthur_sw)

----------------------------------------------------------------
-- UHF radio (TRT - TRAP 137B)

-- 5W/25W selector switch
elements["PNT-340"] = default_2_position_tumb(_("5W/25W selector switch"), 0, devices.MAIN, devCmds.Cmd455, 340, nil, nil, nil, nil, sounds.sound_radio_5W_sw)
-- Squelch switch
elements["PNT-341"] = default_2_position_tumb(_("Squelch switch"), 0, devices.MAIN, devCmds.Cmd456, 341, nil, nil, nil, nil, sounds.sound_SIL_sw)
-- Test selector switch
elements["PNT-342"] = multiposition_switch(_("Test selector switch"), 0, devices.MAIN, devCmds.Cmd457, 342, 3, 1, false, false, -1, sounds.sound_SIL_sw, true, anim_speed_default)
-- CDE button (not used)
elements["PNT-343"] = default_button(_("CDE button (not used)"), 0, devices.MAIN, devCmds.Cmd458, 343)
-- Function selector
elements["PNT-344"] = multiposition_switch_cycled_relative(_("Function selector"), 0, devices.MAIN, devCmds.Cmd459, 344, 5, 0.25, false, 0, sounds.sound_omnibearing_sel_mode, 4)
-- Test light - commented as it is just a light
--elements["PNT-345"] = default_button(_("Test light"), 0, devices.MAIN, devCmds.Cmd461, 345)
-- Channel selector
do
	local channelsNumerics 			= {718, {0, 1}, 1}
	
	--elements["PNT-348"] = multiposition_switch(_("Channel selector"), 0, devices.MAIN, devCmds.Cmd462, 348, 21, 0.05)
	elements["PNT-348"] = {
		class  		 				= {class_type.LEV}, 
		hint   		 				= _("Channel selector"),
		device 		 				= devices.MAIN,
		action 		 				= {devCmds.Cmd462}, 
		arg 						= {348},
		arg_value 					= {0.1},
		arg_lim   					= {{0.0, 1.0}},
		relative					= {true},
		animated   					= {true},
		animation_speed 			= {0.7},
		gain 						= {0.1},
		slave_animation 			= {{slave = channelsNumerics}, {slave = channelsNumerics}},
		sound           			= sounds.sound_channel_sel
	}
end

----------------------------------------------------------------
-- Left wall armament switches

-- (C + M or SW) R deselection switch
elements["PNT-361"] = default_button(_("(C + M or SW) R deselection switch"), 0, devices.MAIN, devCmds.Cmd475, 361, nil, nil, nil, sounds.sound_EFF_sw)
-- Telemeter/zone scanning switch
elements["PNT-360"] = default_3_position_tumb(_("Telemeter/zone scanning switch"), 0, devices.MAIN, devCmds.Cmd476, 360, false, false, nil, nil, sounds.sound_EFF_sw)

----------------------------------------------------------------
-- Accelerometer reset button and rheostat
elements["PNT-1288"] = default_button_axis(_("Accelerometer reset button and rheostat"), 0, devices.MAIN, devCmds.Cmd477, devCmds.Cmd478, 1288, 1289)

----------------------------------------------------------------
-- Sight system and recording camera

-- AUTO/MAN intensity selector switch
elements["PNT-760"] = default_2_position_tumb(_("AUTO/MAN intensity selector switch"), 0, devices.MAIN, devCmds.Cmd480, 760, nil, nil, nil, nil, sounds.sound_feeder_tank_fus_sw)
-- Lighting selector switch
elements["PNT-761"] = multiposition_switch(_("Lighting selector switch"), 0, devices.MAIN, devCmds.Cmd481, 761, 3, 0.5, nil, nil, nil, sounds.sound_feeder_tank_fus_sw)
-- Manual gravity drop selection thumbwheel
--elements["PNT-769"] = default_axis_limited(_("Manual gravity drop selection thumbwheel"), 0, devices.MAIN, devCmds.Cmd482, 769)
elements["PNT-769"] = default_axis(_("Manual gravity drop selection thumbwheel"), 0, devices.MAIN, devCmds.Cmd482, 769, 1, 0.1, false, true, nil, nil, sounds.sound_sight_wheel)
-- Fixed Reticle intensity rheostat
elements["PNT-770"] = default_axis_limited(_("Fixed Reticle intensity rheostat"), 0, devices.MAIN, devCmds.Cmd483, 770)
-- Moving and Target Reticles intensity rheostat
elements["PNT-771"] = default_axis_limited(_("Moving and Target Reticles intensity rheostat"), 0, devices.MAIN, devCmds.Cmd485, 771)
-- Attitude Reticle intensity rheostat
elements["PNT-772"] = default_axis_limited(_("Attitude Reticle intensity rheostat"), 0, devices.MAIN, devCmds.Cmd487, 772)
-- Sight system test button
elements["PNT-773"] = default_button(_("Sight system test button"), 0, devices.MAIN, devCmds.Cmd489, 773)
-- Exposure time repeater
elements["PNT-774"] = default_axis_limited(_("Exposure time repeater"), 0, devices.MAIN, devCmds.Cmd490, 774)
-- Overrun select thumbwheel
elements["PNT-775"] = default_axis_limited(_("Overrun select thumbwheel"), 0, devices.MAIN, devCmds.Cmd492, 775)
-- 5/16 PPS framing rate selector switch
elements["PNT-777"] = multiposition_switch(_("5/16 PPS framing rate selector switch"), 0, devices.MAIN, devCmds.Cmd494, 777, 2, 1, true, true, 0, sounds.sound_IDN_vect_add_sw, true, 10)
-- Sight camera test switch
elements["PNT-776"] = default_button(_("Sight camera test switch"), 0, devices.MAIN, devCmds.Cmd495, 776, 1, {0, 1}, true, nil, true, 10)

----------------------------------------------------------------
-- Radar

-- Radar test buttton
elements["PNT-836"] = default_button(_("Radar test buttton"), 0, devices.MAIN, devCmds.Cmd505, 836)
-- Scope intensity adjustment
elements["PNT-837"] = default_axis_limited(_("Scope intensity adjustment"), 0, devices.MAIN, devCmds.Cmd506, 837)
-- Radar function selection
elements["PNT-838"] = multiposition_switch(_("Radar function selection"), 0, devices.MAIN, devCmds.Cmd508, 838, 8, 1/7, false, false, 0, sounds.sound_radar_function_sel, true, 3)
-- Storage adjustment
elements["PNT-839"] = default_axis_limited(_("Storage adjustment"), 0, devices.MAIN, devCmds.Cmd510, 839)
-- Scope erasing
elements["PNT-840"] = default_button(_("Scope erasing"), 0, devices.MAIN, devCmds.Cmd512, 840)
-- Polaroid screen adjustment
elements["PNT-841"] = default_axis_limited(_("Polaroid screen adjustment"), 0, devices.MAIN, devCmds.Cmd513, 841)

----------------------------------------------------------------
-- IFF

-- Mode 1 coding tens selector
elements["PNT-732"] = multiposition_switch_cycled_relative(_("Mode 1 coding tens selector"), 0, devices.MAIN, devCmds.Cmd520, 732, 9, 0.125, false, 0, sounds.sound_freq_sel, 1)
-- Mode 1 coding units selector
elements["PNT-733"] = multiposition_switch_cycled_relative(_("Mode 1 coding units selector"), 0, devices.MAIN, devCmds.Cmd522, 733, 9, 0.125, false, 0, sounds.sound_freq_sel, 1)
-- Mode 3A coding thousands selector
elements["PNT-734"] = multiposition_switch_cycled_relative(_("Mode 3A coding thousands selector"), 0, devices.MAIN, devCmds.Cmd524, 734, 9, 0.125, false, 0, sounds.sound_freq_sel, 1)
-- Mode 3A coding hundreds selector
elements["PNT-735"] = multiposition_switch_cycled_relative(_("Mode 3A coding hundreds selector"), 0, devices.MAIN, devCmds.Cmd526, 735, 9, 0.125, false, 0, sounds.sound_freq_sel, 1)
-- Mode 3A coding tens selector
elements["PNT-736"] = multiposition_switch_cycled_relative(_("Mode 3A coding tens selector"), 0, devices.MAIN, devCmds.Cmd528, 736, 9, 0.125, false, 0, sounds.sound_freq_sel, 1)
-- Mode 3A coding units selector
elements["PNT-737"] = multiposition_switch_cycled_relative(_("Mode 3A coding units selector"), 0, devices.MAIN, devCmds.Cmd530, 737, 9, 0.125, false, 0, sounds.sound_freq_sel, 1)
-- Position identification selector
elements["PNT-744"] = default_tumb_button(_("Position identification selector"), 0, devices.MAIN, devCmds.Cmd533, devCmds.Cmd532, 744, nil, sounds.sound_iff_ident_sw)
-- IFF test button
elements["PNT-738"] = default_button(_("IFF test button"), 0, devices.MAIN, devCmds.Cmd534, 738)
-- Mode 4 selector switch
elements["PNT-743"] = multiposition_switch(_("Mode 4 selector switch"), 0, devices.MAIN, devCmds.Cmd535, 743, 4, 0.3333, false, false, 0, sounds.sound_iff_mode_sel_sw, true, 5)
-- IFF monitoring light
elements["PNT-741"] = default_button_axis(_("IFF monitoring light"), 0, devices.MAIN, devCmds.Cmd537, devCmds.Cmd538, 740, 741)
-- Function selector switch
elements["PNT-739"] = multiposition_switch(_("Function selector switch"), 0, devices.MAIN, devCmds.Cmd540, 739, 4, 0.3333, false, false, 0, sounds.sound_iff_mode_sel_sw, true, 5)
-- IFF mode 4 switch
elements["PNT-745"] = default_2_position_tumb(_("IFF mode 4 switch"), 0, devices.MAIN, devCmds.Cmd542, 745, nil, nil, nil, nil, sounds.sound_iff_ident_sw)
-- IFF fault light
elements["PNT-746"] = default_button_axis(_("IFF fault light"), 0, devices.MAIN, devCmds.Cmd543, devCmds.Cmd544, 746, 747)
-- AUDIO-LIGHT switch
elements["PNT-749"] = multiposition_switch(_("AUDIO-LIGHT switch"), 0, devices.MAIN, devCmds.Cmd546, 749, 3, 1, false, false, -1, sounds.sound_iff_ident_sw, true, anim_speed_default)
-- M-1 mode switch
elements["PNT-750"] = default_2_position_tumb(_("M-1 mode switch"), 0, devices.MAIN, devCmds.Cmd547, 750, nil, nil, nil, nil, sounds.sound_iff_M1_sw)
-- M-2 mode switch
elements["PNT-751"] = default_2_position_tumb(_("M-2 mode switch"), 0, devices.MAIN, devCmds.Cmd548, 751, nil, nil, nil, nil, sounds.sound_iff_M1_sw)
-- M-3 mode switch
elements["PNT-752"] = default_2_position_tumb(_("M-3 mode switch"), 0, devices.MAIN, devCmds.Cmd549, 752, nil, nil, nil, nil, sounds.sound_iff_M1_sw)
-- M-4 mode switch
elements["PNT-753"] = default_2_position_tumb(_("M-4 mode switch"), 0, devices.MAIN, devCmds.Cmd550, 753, nil, nil, nil, nil, sounds.sound_iff_M1_sw)
