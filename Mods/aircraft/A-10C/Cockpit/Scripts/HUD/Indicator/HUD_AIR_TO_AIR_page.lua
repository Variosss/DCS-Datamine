dofile(LockOn_Options.script_path.."HUD/Indicator/HUD_definitions.lua")

borderA_TO_A_sizeX = 34.59
borderA_TO_A_sizeY = 11

-- Положение надписи по вертикали - 24 mil для первой строки,
-- 13 mil для второй строки.
-- Для многострочного текста положение подбирать (межстрочный интервал настроен)

borderA_TO_A_Verts = {{-borderA_TO_A_sizeX, -borderA_TO_A_sizeY},
					  {-borderA_TO_A_sizeX, borderA_TO_A_sizeY},
					  {borderA_TO_A_sizeX, borderA_TO_A_sizeY},
					  {borderA_TO_A_sizeX, -borderA_TO_A_sizeY}
					 }

borderA_TO_A = addType1SymBorder("borderA_TO_A", borderA_TO_A_Verts, nil, FROM_HUD_CENTER(0, 24), {{"hud_mode_txt", 1}})

AddHUDTextElement_Pos_Val("HUD_Mode_A_TO_A_txt", 
				  nil,
				  {0.0, 0.0},
				  borderA_TO_A.name,
				  HUD_DEFAULT_LEVEL + 2,
				  "CenterCenter",
				  "AIR TO AIR",
				  2)

GBL_Cross_pnt			= CreateDummy()
GBL_Cross_pnt.name		= "GBL_Cross_pnt"
GBL_Cross_pnt.init_pos	= {0.0, GBL_CROSS_pos, 0.0}
--GBL_Cross_pnt.isdraw	= true
GBL_Cross_pnt.controllers = {{"MasterArmSafe", 0}, {"GunSymbologyAvail", 1}}
GBL_Cross_pnt.level 	= HUD_DEFAULT_LEVEL
GBL_Cross_pnt.collimated	= true
Add(GBL_Cross_pnt)

for i = 0, 4 do

	addHWLine("FunnelLine" .. string.format("%i", i+1) .. "Left", 40, 340, {{"FunnelLine", i, ZSL - GBL_CROSS_pos}}, 
								{0.0, 0.0, 0.0}, {0.0, 0.0, 0.0}, "GBL_Cross_pnt", HUD_DEFAULT_LEVEL)
								
	addHWLine("FunnelLine" .. string.format("%i", i+1) .. "Right", 40, 340, {{"FunnelLine", i+6, ZSL - GBL_CROSS_pos}}, 
								{0.0, 0.0, 0.0}, {0.0, 0.0, 0.0}, "GBL_Cross_pnt", HUD_DEFAULT_LEVEL)
end

--AddHUDTexElement("AMIL_Line", 
--				{{-1.0, -1.0}, {-1.0, 1.0}, 
--				{11.0, 1.0}, {11.0, -1.0}},
--				{14.99/texture_size, 7.38/texture_size, tex_scale, tex_scale},
--				{{"AMIL_Line", ZSL - GBL_CROSS_pos}},
--				{0.0, 0.0, 0.0},
--				{0.0, 0.0, 0.0},
--				"GBL_Cross_pnt",
--				HUD_DEFAULT_LEVEL)										

addHWLine("AMIL_Line", 
		  10, 
		  340, 
		  {{"AMIL_Line", ZSL - GBL_CROSS_pos}}, 
		  {0.0, 0.0, 0.0},
		  {0.0, 0.0, 0.0}, 
		  "GBL_Cross_pnt",
		  HUD_DEFAULT_LEVEL)
				
for i = 0, 5 do						

	addHWLine("MRGS_Line" .. string.format("%i", i+1), 10, 340, {{"MRGS_Line", i, ZSL - GBL_CROSS_pos}}, 
						{0.0, 0.0, 0.0}, {0.0, 0.0, 0.0}, "GBL_Cross_pnt", HUD_DEFAULT_LEVEL)

end

for i = 0, 20 do
	AddHUDTexElement("FEDS_dot" .. string.format("%i", i+1), 
					{{-1.5, -1.5}, {-1.5, 1.5}, 
					{1.5, 1.5}, {1.5, -1.5}},
					{15.745/texture_size, 9.845/texture_size, tex_scale, tex_scale},
					{{"FEDS_dot", i, ZSL - GBL_CROSS_pos}},
					{0.0, 0.0, 0.0},
					{0.0, 0.0, 0.0},
					"GBL_Cross_pnt",
					HUD_DEFAULT_LEVEL)
end

--addMeshBox("FEDS_dot", {tmp11}, {0.0, 0.0, 0.0}, nil)

AddHUDTexElement("AIM_9",
				{{-9, -9}, {-9, 9}, 
				{9, 9}, {9, -9}},
				{16.14/texture_size, 16.54/texture_size, tex_scale, tex_scale},
				{{"AIM_9_pos", 160.5, ZSL, 0.25}},
				{0.0, 0.0, 0.0},
				{0.0, 0.0, 0.0},
				nil,
				HUD_DEFAULT_LEVEL)

				
AddHUDTexElement("fixed_41_gun_cross", 
					{{-11.0, -11.0}, {-11.0, 11.0}, 
					{11.0, 11.0}, {11.0, -11.0}},
					{9.71 / texture_size, 1.54 / texture_size, tex_scale, tex_scale},
					{{"MasterArmSafe", 0}, {"GunSymbologyAvail", 1}, {"Fixed_41_gun_cross_pos", ZSL}},
					{0.0, 0.0, 0.0},
					{0.0, 0.0, 0.0},
					nil,
					HUD_DEFAULT_LEVEL)	