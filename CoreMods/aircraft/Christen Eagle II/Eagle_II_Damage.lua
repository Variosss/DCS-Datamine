Eagle2_Damage = 
	{
	-- 10, 40, 69, 100 ( .1, .4, .69, 1)  Small / Medium / Holes / Large-Holes (Missing)

	-- Propeller --
	["ROTOR"]       = {critical_damage = 1, args = {429}, droppable = false}, -- Spinner -- 63
	["BLADE_1_OUT"] = {critical_damage = 1, args = {430}, droppable = false}, -- Blade Left -- 66
	["BLADE_2_OUT"] = {critical_damage = 1, args = {431}, droppable = false}, -- Blade Right -- 69

	-- Cowl --
	["NOSE_CENTER"]     = {critical_damage = 1, args = {147}, droppable = false}, -- Cowl Top -- 0
	["NOSE_LEFT_SIDE"]  = {critical_damage = 1, args = {150}, droppable = false}, -- Left -- 1
	["NOSE_RIGHT_SIDE"] = {critical_damage = 1, args = {149}, droppable = false}, -- Right -- 2
	["ENGINE"]          = {critical_damage = 1, args = {148}, droppable = false}, -- Bottom	-- 11

	-- Canopy --
	["ARMOR_NOSE_PLATE_LEFT"]  = {critical_damage = 1, args = {183}}, -- Glass -- 94
	["ARMOR_NOSE_PLATE_RIGHT"] = {critical_damage = 1, args = {183}}, -- Frame -- 95

	-- Fuselage --
	["COCKPIT"]           = {critical_damage = 2, args = {151}, droppable = false}, -- Nose Top -- 3
	["CABIN_LEFT_SIDE"]   = {critical_damage = 2, args = {154}, droppable = false}, -- Left -- 4
	["CABIN_RIGHT_SIDE"] = {critical_damage = 2, args = {153}, droppable = false}, -- Right -- 5
	["CABIN_BOTTOM"]      = {critical_damage = 2, args = {152}, droppable = false}, -- Bottom -- 6

	-- Tail --
	["TAIL"]            = {critical_damage = 2, args = {155}, droppable = false}, -- Tail -- 55 
	["TAIL_LEFT_SIDE"]  = {critical_damage = 2, args = {158}, droppable = false}, -- Left -- 56
	["TAIL_RIGHT_SIDE"] = {critical_damage = 2, args = {157}, droppable = false}, -- Right -- 57
	["TAIL_BOTTOM"]     = {critical_damage = 2, args = {156}, droppable = false}, -- Bottom -- 58

	-- Tail Control Surfaces --
	["STABILIZER_L_OUT"] = {critical_damage = 3, args = {236}, deps_cells = {"ELEVATOR_L_OUT", "ELEVATOR_L_IN"}}, -- Stabilizor Left -- 45
	["ELEVATOR_L_OUT"]   = {critical_damage = 1, args = {240}, deps_cells = {"ELEVATOR_L_IN"}}, -- Elevator Left -- 49 
	["ELEVATOR_L_IN"]    = {critical_damage = 1, args = {239}}, -- Trim Left -- 51

	["STABILIZER_R_OUT"] = {critical_damage = 3, args = {235}, deps_cells = {"ELEVATOR_R_OUT", "ELEVATOR_R_IN"}}, -- Stabilizor Right -- 46
	["ELEVATOR_R_OUT"]   = {critical_damage = 1, args = {238}, deps_cells = {"ELEVATOR_R_IN"}}, -- Elevator Left -- 50
	["ELEVATOR_R_IN"]    = {critical_damage = 1, args = {237}}, -- Trim Left -- 52

	["RUDDER"]           = {critical_damage = 1, args = {247}}, -- Rudder -- 53

	-- Wings Upper --
	["WING_L_IN"]  = {critical_damage = 4, args = {228}, deps_cells = {"WING_L_OUT", "AILERON_L"}}, -- Wing Left Inner -- 35
	["WING_L_OUT"] = {critical_damage = 2, args = {227}, deps_cells = {"AILERON_L"}, droppable = true}, -- Wing Left Outer -- 23

	["WING_R_IN"]  = {critical_damage = 4, args = {218}, deps_cells = {"WING_R_OUT", "AILERON_R"}}, -- Wing Right Inner -- 36
	["WING_R_OUT"] = {critical_damage = 2, args = {217}, deps_cells = {"AILERON_R"}, droppable = true}, -- Wing Right Outer -- 24

	-- Wings Lower --
	["WING_L_PART_IN"]  = {critical_damage = 4, args = {224}, deps_cells = {"WING_L_PART_OUT", "FUSELAGE_LEFT_SIDE"}, droppable = false}, -- Wing Left Inner -- 33
	["WING_L_PART_OUT"] = {critical_damage = 2, args = {223}, deps_cells = {"FUSELAGE_LEFT_SIDE"}, droppable = true}, -- Wing Left Outer -- 21

	["WING_R_PART_IN"]  = {critical_damage = 4, args = {214}, deps_cells = {"WING_R_PART_OUT", "FUSELAGE_RIGHT_SIDE"}, droppable = false}, -- Wing Right Inner -- 34
	["WING_R_PART_OUT"] = {critical_damage = 2, args = {213}, deps_cells = {"FUSELAGE_RIGHT_SIDE"}, droppable = true}, -- Wing Right Outer -- 22

	-- Wing Control Surfaces --
	["AILERON_L"]           = {critical_damage = 1, args = {229}}, -- Aileron Left Upper -- 25
	["AILERON_R"]           = {critical_damage = 1, args = {219}}, -- Aileron Right Upper -- 26

	["FUSELAGE_LEFT_SIDE"]  = {critical_damage = 1, args = {226}}, -- Aileron Left Lower -- 9
	["FUSELAGE_RIGHT_SIDE"] = {critical_damage = 1, args = {216}}, -- Aileron Right Lower -- 10

	--[[
	["FLAP_L_OUT"]          = {critical_damage = 1}, --args = { }}, -- Slave Tube Left
	["FLAP_R_OUT"]          = {critical_damage = 1}, --args = { }}, -- Slave Tube Right


	-- Supports --
	["PWD"]            = {critical_damage = 1}, --args = { }}, -- Center Support Cover and Struts

	["FLAP_L"]         = {critical_damage = 1}, --args = { }}, -- Wing Left Support
	["FLAP_R"]         = {critical_damage = 1}, --args = { }}, -- Wing Right Support

	["CREW_3"]         = {critical_damage = 1}, --args = { }}, -- Wing Left Support Rod
	["CREW_4"]         = {critical_damage = 1}, --args = { }}, -- Wing Right Support Rod

	["BLADE_1_IN"]     = {critical_damage = 1}, --args = { }}, -- Wing Left Support Guide 01
	["BLADE_1_CENTER"] = {critical_damage = 1}, --args = { }}, -- Wing Left Support Guide 02
	["BLADE_2_IN"]     = {critical_damage = 1}, --args = { }}, -- Wing Left Support Guide 03
	["BLADE_2_CENTER"] = {critical_damage = 1}, --args = { }}, -- Wing Left Support Guide 04

	["BLADE_3_IN"]     = {critical_damage = 1}, --args = { }}, -- Wing Right Support Guide 01
	["BLADE_3_CENTER"] = {critical_damage = 1}, --args = { }}, -- Wing Right Support Guide 02
	["BLADE_4_IN"]     = {critical_damage = 1}, --args = { }}, -- Wing Right Support Guide 03
	["BLADE_4_CENTER"] = {critical_damage = 1}, --args = { }}, -- Wing Right Support Guide 04

	["BLADE_5_IN"]     = {critical_damage = 1}, --args = { }}, -- Stabilizer Left Top Support Guide 01
	["BLADE_5_CENTER"] = {critical_damage = 1}, --args = { }}, -- Stabilizer Left Top Support Guide 02

	["BLADE_5_OUT"]    = {critical_damage = 1}, --args = { }}, -- Stabilizer Left Bottom Support Guide 01
	["BLADE_6_IN"]     = {critical_damage = 1}, --args = { }}, -- Stabilizer Left Bottom Support Guide 02

	["BLADE_6_CENTER"] = {critical_damage = 1}, --args = { }}, -- Stabilizer Right Top Support Guide 01
	["BLADE_6_OUT"]    = {critical_damage = 1}, --args = { }}, -- Stabilizer Right Top Support Guide 02

	["BLADE_3_OUT"]    = {critical_damage = 1}, --args = { }}, -- Stabilizer Right Bottom Support Guide 01
	["BLADE_4_OUT"]    = {critical_damage = 1}, --args = { }}, -- Stabilizer Right Bottom Support Guide 02
]]
	
	
	-- Landing Gear --
	["PYLON1"]         = {critical_damage = 4, args = {253}, deps_cells = {"PYLON2", "FRONT_GEAR_BOX", "WHEEL_F"}}, -- Leaf Spring -- 86
	["AIR_BRAKE_L"]    = {critical_damage = 4, args = {259}, deps_cells = {"LEFT_GEAR_BOX", "MTG_L_BOTTOM", "WHEEL_L"}}, -- Upper Strut Cover Left -- 19
	["AIR_BRAKE_R"]    = {critical_damage = 4, args = {255}, deps_cells = {"RIGHT_GEAR_BOX", "MTG_R_BOTTOM", "WHEEL_R"}}, -- Upper Strut Cover Right -- 20

	["PYLON2"]         = {critical_damage = 4, args = {263}, deps_cells = {"FRONT_GEAR_BOX", "WHEEL_F"}}, -- Fork Base -- 87
	["MTG_L_BOTTOM"]   = {critical_damage = 4, args = {260}, deps_cells = {"LEFT_GEAR_BOX", "WHEEL_L"}}, -- Strut Left -- 13
	["MTG_R_BOTTOM"]   = {critical_damage = 4, args = {256}, deps_cells = {"RIGHT_GEAR_BOX", "WHEEL_R"}}, -- Strut Right -- 14

	["FRONT_GEAR_BOX"] = {critical_damage = 4, args = {264}, deps_cells = {"WHEEL_F"}}, -- Fork -- 8
	["LEFT_GEAR_BOX"]  = {critical_damage = 4, args = {261}, deps_cells = {"WHEEL_L"}}, -- Pant Left -- 15
	["RIGHT_GEAR_BOX"] = {critical_damage = 4, args = {257}, deps_cells = {"WHEEL_R"}}, -- Pant Right -- 16

	["WHEEL_F"]        = {critical_damage = 3, args = {134}}, -- Wheel Rear -- 83
	["WHEEL_L"]        = {critical_damage = 3, args = {136}}, -- Wheel Left -- 84
	["WHEEL_R"]        = {critical_damage = 3, args = {135}}, -- Wheel Right -- 85
	}



	
Eagle2_DamageParts = 
	{ 
	[1000 + 21] = "CE2_Damage-Wing-Lower-L",
	[1000 + 22] = "CE2_Damage-Wing-Lower-R",
		
	[1000 + 23] = "CE2_Damage-Wing-Upper-L", 	
	[1000 + 24] = "CE2_Damage-Wing-Upper-R",	
	}

	