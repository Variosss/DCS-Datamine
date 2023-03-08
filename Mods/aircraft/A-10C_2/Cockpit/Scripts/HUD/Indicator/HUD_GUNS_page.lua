dofile(LockOn_Options.script_path.."HUD/Indicator/HUD_definitions.lua")

borderGUNS_sizeX = 17.29
borderGUNS_sizeY = 11

-- Положение надписи по вертикали - 24 mil для первой строки,
-- 13 mil для второй строки.
borderGUNS_Verts = {{-borderGUNS_sizeX, -borderGUNS_sizeY},
				    {-borderGUNS_sizeX, borderGUNS_sizeY},
					{borderGUNS_sizeX, borderGUNS_sizeY},
					{borderGUNS_sizeX, -borderGUNS_sizeY}
					}
								
borderGUNS = addType1SymBorder("borderGUNS", borderGUNS_Verts, nil, FROM_HUD_CENTER(0, 24), {{"hud_mode_txt", 1}})

AddHUDTextElement_Pos_Val("HUD_Mode_GUNS_txt", 
				  nil,
				  {0.0, 0.0},
				  borderGUNS.name,
				  HUD_DEFAULT_LEVEL + 2,
				  "CenterCenter",
				  "GUNS",
				  2)
								
AddHUDTexElement("gun_4_8_12_reticle",
					{{-31.0, -31.0}, {-31.0, 31.0}, 
					{31.0, 31.0}, {31.0, -31.0}},
					{3.57 / texture_size, 10.43 / texture_size, tex_scale, tex_scale},
					{{"MasterArmSafe", 0}, {"GunSymbologyAvail", 1}, {"gun_4_8_12_reticle", 160, ZSL, 1}},
					{0.0, 0.0, 0.0},
					{0.0, 0.0, 0.0},
					nil,
					HUD_DEFAULT_LEVEL)

AddHUDTexElement("gun_4_8_12_reticle_pnt", 
					{{-1.0, -1.0}, {-1.0, 1.0}, 
					{1.0, 1.0}, {1.0, -1.0}},
					{15.75/texture_size, 10.43/texture_size, tex_scale, tex_scale},
					nil,
					{0.0, 0.0, 0.0},
					{0.0, 0.0, 0.0},
					"gun_4_8_12_reticle",
					HUD_DEFAULT_LEVEL)
					
AddHUDTexElement("gun_4_8_12_reticle_pnt4000", 
					{{-1.0, -1.0}, {-1.0, 1.0}, 
					{1.0, 1.0}, {1.0, -1.0}},
					{15.75/texture_size, 10.43/texture_size, tex_scale, tex_scale},
					{{"MasterArmSafe", 0}, {"GunSymbologyAvail", 1}, {"gun_4_8_12_reticle", 160, ZSL, 2}},
					{0.0, 0.0, 0.0},
					{0.0, 0.0, 0.0},
					nil,
					HUD_DEFAULT_LEVEL)

AddHUDTexElement("gun_4_8_12_reticle_pnt12000", 
					{{-1.0, -1.0}, {-1.0, 1.0}, 
					{1.0, 1.0}, {1.0, -1.0}},
					{15.75/texture_size, 10.43/texture_size, tex_scale, tex_scale},
					{{"MasterArmSafe", 0}, {"GunSymbologyAvail", 1}, {"gun_4_8_12_reticle", 160, ZSL, 3}},
					{0.0, 0.0, 0.0},
					{0.0, 0.0, 0.0},
					nil,
					HUD_DEFAULT_LEVEL)
					
Add_invalid_X_symbol("gun_4_8_12_reticle", {{"MasterArmSafe", 0}, {"GunSymbologyAvail", 1}, {"invalid_4000_gun"}})

AddHUDTexElement("gun_4_8_12_reticle_MRC", 
					{{-4.0, -4.5}, {-4.0, 4.5}, 
					{4.0, 4.5}, {4.0, -4.5}},
					{7.485 / texture_size, 5.03 / texture_size, tex_scale, tex_scale},
					{{"analog_MRC", 5, 32}},
					{34.0, 0.0, 0.0},
					{-90.0, 0.0, 0.0},
					"gun_4_8_12_reticle",
					HUD_DEFAULT_LEVEL)

