dofile(LockOn_Options.script_path.."HUD/Indicator/HUD_definitions.lua")

------------------------------------------------------------------------
-- Break X

AddHUDTexElement("Break_X_1", 
				{{-52.0, -1.0}, {-52.0, 1.0}, 
				{52.0, 1.0}, {52.0, -1.0}},
				{6.025/texture_size, 14.19/texture_size, tex_scale, tex_scale},
				{{"GCAS_Break_X", 0.1667}},
				FROM_HUD_CENTER(0,0),
				{45.0, 0.0, 0.0},
				nil,
				HUD_DEFAULT_LEVEL)


AddHUDTexElement("Break_X_2", 
				{{-52.0, -1.0}, {-52.0, 1.0}, 
				{52.0, 1.0}, {52.0, -1.0}},
				{6.025/texture_size, 14.19/texture_size, tex_scale, tex_scale},
				nil,
				{0.0, 0.0, 0.0},
				{90.0, 0.0, 0.0},
				"Break_X_1",
				HUD_DEFAULT_LEVEL)

-- Положение надписи по вертикали - 24 mil для первой строки,
-- 13 mil для второй строки.
-- Для многострочного текста положение подбирать (межстрочный интервал настроен)

border_sizeY		= 11

------------------------------------------------------------------------
-- CCIP INVALID

CCIP_INVALID_sizeX = OneSymbolSpace * 9

border_CCIP_INVALID_Verts = {{-CCIP_INVALID_sizeX, -border_sizeY},
							 {-CCIP_INVALID_sizeX, border_sizeY},
							 {CCIP_INVALID_sizeX, border_sizeY},
							 {CCIP_INVALID_sizeX, -border_sizeY}
							}
border_CCIP_INVALID_Ctrls = {{"MasterArmSafe", 0}, {"hud_mode_txt", 0}, {"CCIP_INVALID_msg", 1}}

border_CCIP_INVALID_Up = addType1SymBorder("border_CCIP_INVALID_Up", border_CCIP_INVALID_Verts, nil, FROM_HUD_CENTER(0, 24), border_CCIP_INVALID_Ctrls)

AddHUDTextElement_Pos_Val("CCIP_txt", 
				  nil,
				  {0.0, 0.0, 0.0},
				  border_CCIP_INVALID_Up.name,
				  HUD_DEFAULT_LEVEL + 2,
				  "CenterCenter",
				  "CCIP",
				  2)

border_CCIP_INVALID_Dn = addType1SymBorder("border_CCIP_INVALID_Dn", border_CCIP_INVALID_Verts, nil, FROM_HUD_CENTER(0, 13), border_CCIP_INVALID_Ctrls)

AddHUDTextElement_Pos_Val("INVALID_txt", 
				  nil,
				  {0.0, 0.0, 0.0},
				  border_CCIP_INVALID_Dn.name,
				  HUD_DEFAULT_LEVEL + 2,
				  "CenterCenter",
				  "INVALID",
				  2)


------------------------------------------------------------------------

------------------------------------------------------------------------
-- CCRP INVALID

CCRP_INVALID_sizeX = OneSymbolSpace * 9

border_CCRP_INVALID_Verts = {{-CCRP_INVALID_sizeX, -border_sizeY},
							 {-CCRP_INVALID_sizeX, border_sizeY},
							 {CCRP_INVALID_sizeX, border_sizeY},
							 {CCRP_INVALID_sizeX, -border_sizeY}
							}
border_CCRP_INVALID_Ctrls = {{"MasterArmSafe", 0}, {"hud_mode_txt", 0}, {"CCRP_INVALID_msg", 1}}

border_CCRP_INVALID_Up = addType1SymBorder("border_CCRP_INVALID_Up", border_CCRP_INVALID_Verts, nil, FROM_HUD_CENTER(0, 24), border_CCRP_INVALID_Ctrls)

AddHUDTextElement_Pos_Val("CCRP_txt", 
				  nil,
				  {0.0, 0.0, 0.0},
				  border_CCRP_INVALID_Up.name,
				  HUD_DEFAULT_LEVEL + 2,
				  "CenterCenter",
				  "CCRP",
				  2)

border_CCRP_INVALID_Dn = addType1SymBorder("border_CCRP_INVALID_Dn", border_CCRP_INVALID_Verts, nil, FROM_HUD_CENTER(0, 13), border_CCRP_INVALID_Ctrls)

AddHUDTextElement_Pos_Val("CCRP_INVALID_txt", 
				  nil,
				  {0.0, 0.0, 0.0},
				  border_CCRP_INVALID_Dn.name,
				  HUD_DEFAULT_LEVEL + 2,
				  "CenterCenter",
				  "INVALID",
				  2)


------------------------------------------------------------------------
-- INVALID FUSING

InvalidFuzing_sizeX = OneSymbolSpace * 16
border_InvalidFuzing_Verts	= {{-InvalidFuzing_sizeX, -border_sizeY},
							   {-InvalidFuzing_sizeX, border_sizeY},
							   {InvalidFuzing_sizeX, border_sizeY},
							   {InvalidFuzing_sizeX, -border_sizeY}
							  }

border_InvalidFuzing = addType1SymBorder("border_InvalidFuzing",
										 border_InvalidFuzing_Verts, nil, FROM_HUD_CENTER(0, 24),
										 {{"MasterArmSafe", 0}, {"hud_mode_txt", 0}, {"CCIP_INVALID_msg", 0}, {"CCRP_INVALID_msg", 0}, {"InvalidFuzing_msg", 1}})

AddHUDTextElement_Pos_Val("InvalidFuzing_txt",
				  nil,
				  {0.0, 0.0},
				  border_InvalidFuzing.name,
				  HUD_DEFAULT_LEVEL + 2,
				  "CenterCenter",
				  "INVALID FUZING",
				  2)

------------------------------------------------------------------------
-- Altitude alert numerics

AltitudeWarnOrigin				= CreateDummy()
AltitudeWarnOrigin.name			= "AltitudeWarnOrigin"
AltitudeWarnOrigin.init_pos		= FROM_HUD_CENTER(-1, 13)
AltitudeWarnOrigin.controllers  = {{"hud_mode_txt", 0}, {"CCIP_INVALID_msg", 0}, {"CCRP_INVALID_msg", 0}, {"InvalidFuzing_msg", 0}}
Add(AltitudeWarnOrigin)

borderAltWarn_sizeX	= 49

borderFloorVerts = {{-borderAltWarn_sizeX, -border_sizeY},
					{-borderAltWarn_sizeX, border_sizeY},
					{borderAltWarn_sizeX, border_sizeY},
					{borderAltWarn_sizeX, -border_sizeY}
				   }
								
borderFloorAGL = addType1SymBorder("borderFloorAGL", borderFloorVerts, "AltitudeWarnOrigin", {0, 0}, {{"AltWarnSettingText", 0}})

AddHUDTextElement_Pos_Val("AGL_FLOOR_TEXT", 
				  nil,
				  {-8.2, 0.0},
				  borderFloorAGL.name,
				  HUD_DEFAULT_LEVEL + 2,
				  "LeftCenter",
				  "AGL FLOOR",
				  2)

borderFloorMSL = addType1SymBorder("borderFloorMSL", borderFloorVerts, "AltitudeWarnOrigin", {0, 0}, {{"AltWarnSettingText", 1}})

AddHUDTextElement_Pos_Val("MSL_FLOOR_TEXT", 
				  nil,
				  {-8.2, 0.0, 0.0}, 
				  borderFloorMSL.name,
				  HUD_DEFAULT_LEVEL + 2,
				  "LeftCenter",
				  "MSL FLOOR",
				  2)
						  
borderCeilingMSL_Verts	= {{-borderAltWarn_sizeX, -border_sizeY},
						   {-borderAltWarn_sizeX, border_sizeY},
						   {borderAltWarn_sizeX + OneSymbolSpace * 4, border_sizeY},
						   {borderAltWarn_sizeX + OneSymbolSpace * 4, -border_sizeY}
						  }
						  
borderCeilingMSL = addType1SymBorder("borderCeilingMSL", borderCeilingMSL_Verts, "AltitudeWarnOrigin", {0, 0}, {{"AltWarnSettingText", 2}})

AddHUDTextElement_Pos_Val("MSL_CEILING_TEXT", 
				  nil,
				  {-8.2, 0.0, 0.0}, 
				  borderCeilingMSL.name,
				  HUD_DEFAULT_LEVEL + 2,
				  "LeftCenter",
				  "MSL CEILING",
				  2)

AddHUDTextElement_Pos("AltitudeWarningValue", 
				  {{"AltitudeWarningValue"}},
				  {-15.0, 0.0, 0.0}, 
				  "AltitudeWarnOrigin",
				  HUD_DEFAULT_LEVEL + 2,
				  "RightCenter",
				  2)

------------------------------------------------------------------------
-- Delta radar/GPS altitude numerics

Border_Delta_EGI_Radar_Elev_Verts	= {{-OneSymbolSpace * 9, -border_sizeY},
									   {-OneSymbolSpace * 9, border_sizeY},
									   {OneSymbolSpace * 7, border_sizeY},
									   {OneSymbolSpace * 7, -border_sizeY}
									  }
Delta_EGI_RadarElevationCtrls =
	{{"hud_mode_txt", 0}, {"CCIP_INVALID_msg", 0}, {"CCRP_INVALID_msg", 0}, {"InvalidFuzing_msg", 0},
	 {"AltWarnSettingText", -1}, {"Delta_EGI_RadarElevation", 1}}

BorderDeltaElev = addType1SymBorder("BorderDeltaElev", Border_Delta_EGI_Radar_Elev_Verts, "", {OneSymbolSpace / 2, 24}, Delta_EGI_RadarElevationCtrls)

AddHUDTextElement_Pos("DeltaElev",
				  {{"DeltaElevationTxt", 0.1667}},
				  {14.72, 0},
				  BorderDeltaElev.name,
				  HUD_DEFAULT_LEVEL + 2,
				  "RightCenter",
				  2)

BorderEGI_RadarElev = addType1SymBorder("BorderEGI_RadarElev", Border_Delta_EGI_Radar_Elev_Verts, "", {OneSymbolSpace / 2, 13}, Delta_EGI_RadarElevationCtrls)

AddHUDTextElement_Pos("EGI_RadarElev", 
				  {{"EGI_RadarElevationTxt", 0.1667}},
				  {14.72, 0}, 
				  BorderEGI_RadarElev.name,
				  HUD_DEFAULT_LEVEL + 2,
				  "RightCenter",
				  2)

------------------------------------------------------------------------
-- Mark point elevation

BorderMarkElev_Verts	= {{-OneSymbolSpace * 7, -border_sizeY},
					  	   {-OneSymbolSpace * 7, border_sizeY},
						   {OneSymbolSpace * 7, border_sizeY},
						   {OneSymbolSpace * 7, -border_sizeY}
						  }

BorderMarkElev = addType1SymBorder("BorderMarkElev", BorderMarkElev_Verts, "", {OneSymbolSpace / 2, 13},
	{{"hud_mode_txt", 0}, {"CCIP_INVALID_msg", 0}, {"CCRP_INVALID_msg", 0}, {"InvalidFuzing_msg", 0},
	 {"AltWarnSettingText", -1}, {"Delta_EGI_RadarElevation", 0}, {"MarkpointElevation", 1}})

AddHUDTextElement_Pos("MarkpointElevation", 
				  {{"MarkpointElevationTxt", 0.1667}},
				  {20.5, 0, 0}, 
				  BorderMarkElev.name,
				  HUD_DEFAULT_LEVEL + 2,
				  "RightCenter",
				  2)

------------------------------------------------------------------------
-- USE CCRP

USE_CCRP_sizeX = OneSymbolSpace * 10

border_USE_CCRP_Verts = {{-USE_CCRP_sizeX, -border_sizeY},
					     {-USE_CCRP_sizeX, border_sizeY},
						 {USE_CCRP_sizeX, border_sizeY},
						 {USE_CCRP_sizeX, -border_sizeY}
						}

border_USE_CCRP_Ctrls = {{"MasterArmSafe", 0}, {"hud_mode_txt", 0}, {"CCIP_INVALID_msg", 0}, {"CCRP_INVALID_msg", 0}, {"InvalidFuzing_msg", 0},
	{"AltWarnSettingText", -1}, {"Delta_EGI_RadarElevation", 0}, {"MarkpointElevation", 0},
	{"Use_CCRP_msg", 1}}

border_USE_CCRP = addType1SymBorder("border_USE_CCRP",
                               border_USE_CCRP_Verts, nil, FROM_HUD_CENTER(0, 24),
                               border_USE_CCRP_Ctrls)

AddHUDTextElement_Pos_Val("USE_CCRP_txt", 
				  nil,
				  {0.0, 0.0},
				  border_USE_CCRP.name,
				  HUD_DEFAULT_LEVEL + 2,
				  "CenterCenter",
				  "USE CCRP",
				  2)
