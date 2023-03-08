dofile(LockOn_Options.script_path.."HUD/Indicator/HUD_definitions.lua")

borderNAV_sizeX = 14.41
borderNAV_sizeY = 11

-- Положение надписи по вертикали - 24 mil для первой строки,
-- 13 mil для второй строки.
-- Для многострочного текста положение подбирать (межстрочный интервал настроен)
borderNAV_Verts		= {{-borderNAV_sizeX, -borderNAV_sizeY},
				 	   {-borderNAV_sizeX, borderNAV_sizeY},
					   {borderNAV_sizeX, borderNAV_sizeY},
					   {borderNAV_sizeX, -borderNAV_sizeY}
					  }

borderNAV = addType1SymBorder("borderNAV", borderNAV_Verts, nil, FROM_HUD_CENTER(0, 24), {{"hud_mode_txt", 1}})

AddHUDTextElement_Pos_Val("HUD_Mode_NAV_txt", 
				  nil,
				  {0, 0}, 
				  borderNAV.name,
				  HUD_DEFAULT_LEVEL + 2,
				  "CenterCenter",
				  "NAV",
				  2)
