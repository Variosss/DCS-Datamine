dofile(LockOn_Options.script_path.."HUD/Indicator/HUD_definitions.lua")

borderCCIP_sizeX = 17.29
borderCCIP_sizeY = 11

-- Положение надписи по вертикали - 24 mil для первой строки,
-- 13 mil для второй строки.
-- Для многострочного текста положение подбирать (межстрочный интервал настроен)

borderCCIP_Verts = {{-borderCCIP_sizeX, -borderCCIP_sizeY},
					{-borderCCIP_sizeX, borderCCIP_sizeY},
					{borderCCIP_sizeX, borderCCIP_sizeY},
					{borderCCIP_sizeX, -borderCCIP_sizeY}
					}

borderCCIP = addType1SymBorder("borderCCIP", borderCCIP_Verts, nil, FROM_HUD_CENTER(0, 24), {{"hud_mode_txt", 1}})

AddHUDTextElement_Pos_Val("HUD_Mode_CCIP_txt",
				  nil,
				  {0.0, 0.0},
				  borderCCIP.name,
				  HUD_DEFAULT_LEVEL + 2,
				  "CenterCenter",
				  "CCIP",
				  2)
