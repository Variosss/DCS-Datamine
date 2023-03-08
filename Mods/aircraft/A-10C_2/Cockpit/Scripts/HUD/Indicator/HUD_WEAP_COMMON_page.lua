dofile(LockOn_Options.script_path.."HUD/Indicator/HUD_definitions.lua")

AddHUDTextElement_Pos_Val("Release_Mode_man_rel", 
				  {{"MasterArmSafe", 0}, {"EGI_on"}, {"IsIAM", 0}, {"Release_Mode_txt", 0}}, 
				  FROM_HUD_CENTER(-70, -51.5), 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "RightCenter",
				  "MAN REL")
				  
AddHUDTextElement_Pos_Val("Release_Mode_man_rel_IAM", 
				  {{"MasterArmSafe", 0}, {"EGI_on"}, {"IsIAM", 1}, {"Release_Mode_txt_IAM"}}, 
				  FROM_HUD_CENTER(-70, -51.5), 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "RightCenter",
				  "MAN REL")
				  
AddHUDTextElement_Pos_Val("Release_Mode_5_mil", 
				  {{"MasterArmSafe", 0},{"EGI_on"}, {"IsIAM", 0}, {"Release_Mode_txt", 1}}, 
				  FROM_HUD_CENTER(-70, -51.5), 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "RightCenter",
				  "5 MIL")
				  
AddHUDTextElement_Pos_Val("Release_Mode_3_9", 
				  {{"MasterArmSafe", 0},{"EGI_on"}, {"IsIAM", 0}, {"Release_Mode_txt", 2}}, 
				  FROM_HUD_CENTER(-70, -51.5), 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "RightCenter",
				  "3/9")


AddHUDTextElement_Pos("Selected_Weapon_Profile", 
				  {{"EGI_on"},{"Selected_Weapon_Profile_txt"}}, 
				  FROM_HUD_CENTER(-70, -64.0), 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "RightCenter")
				  
			  
AddHUDTextElement_Pos_Val("Weapons_Arm_SAFE", 
				  {{"Weapons_Arm_Indication_txt", 1}}, 
				  FROM_HUD_CENTER(-70, -101.5), 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "RightCenter",
				  "SAFE")
				  
AddHUDTextElement_Pos_Val("Weapons_Arm_ARM", 
				  {{"Weapons_Arm_Indication_txt", 2}}, 
				  FROM_HUD_CENTER(-70, -101.5), 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "RightCenter",
				  "ARM")

AddHUDTextElement_Pos_Val("Weapons_Arm_TRN", 
				  {{"Weapons_Arm_Indication_txt", 3}}, 
				  FROM_HUD_CENTER(-70, -101.5), 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "RightCenter",
				  "TRN")

AddHUDTextElement_Pos_Formats("Weapons_Status_Stations",
				  {{"EGI_on"},{"Weapons_Status"}},
				  FROM_HUD_CENTER(-70, -114), 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "RightCenter",
				  {"%s", -- 0
				    "",         -- 1
				   "EMPTY",    -- 2
				   "LDG GEAR", -- 3
				   "GND SAFE", -- 4
				   "SEL JETT", -- 5
				   "INVL",     -- 6
				   "NR",       -- 7
				   "W",        -- 8
				   "***",      -- 9
				   "OFF",      -- 10
				   "ALN",      -- 11
				   "FLAPS",    -- 12
				   "RDY",      -- 13
				   "FOV LIM",  -- 14
				   "CHK STAT", -- 15
				   "STBY",     -- 16
				   "INIT",     -- 17
				   "ALN UNS",  -- 18
				   "ALN GRDY", -- 19
				   "IMU RDY",  -- 20
				   "UNSAT",    -- 21
				   "FAIL",     -- 22
				   "NO SPI",   -- 23
				   "ALN DEG",  -- 24
				   "ALN IRDY", -- 25
				   "ALN RDY",  -- 26
				   "DEG",      -- 27
				   "GPS RDY",  -- 28
				   "ERASED",   -- 29
				  })

--[[AddHUDTextElement_Pos("Secondary_Weapons_Status_Stations",
				  {{"SecondaryWeapons_Status"}},
				  FROM_HUD_CENTER(-107, -114),
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")]]--

AddHUDTextElement_Pos_Formats("TimeOfFall",
				  {{"shift_pos_tapes_visible", -12.0}, {"TimeOfFall", 0.1667}},
				  FROM_HUD_CENTER(-100.0, -33.3), 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "RightCenter",
				  {"XXX", "%d", "R%.2d:%.2d", "%.2d:%.2d", "T%.2d:%.2d"})
