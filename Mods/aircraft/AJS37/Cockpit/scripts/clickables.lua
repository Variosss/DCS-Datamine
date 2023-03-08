-- This is an automatically generated file. Don't make edits here.

-- *** WEAPON_SYSTEM ***

elements["PNT_400"] = default_1_position_tumb("Missile Select Button (IR-RB FRAMSTEGN)", 2, 3800, -666)
elements["PNT_400"].sound = {}

-- *** RADAR ***

elements["PNT_POOP"] = default_axis_limited("Radar Night Filter", 5, 3800, -666, 1, 0.1, true, true)
elements["PNT_POOP"].sound = {}

-- *** COUNTERMEASURE ***

elements["PNT_CMEASURES"] = multiposition_switch_limited("Countermeasure Dispense", 28, 3805, -666, 3, 1, false, -1.0)
elements["PNT_CMEASURES"].sound = {}
