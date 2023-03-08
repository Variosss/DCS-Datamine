dofile(LockOn_Options.script_path.."HUD/Indicator/HUD_definitions.lua")

borderCCRP_sizeX = 17.29
borderCCRP_sizeY = 11

-- Положение надписи по вертикали - 24 mil для первой строки,
-- 13 mil для второй строки.
-- Для многострочного текста положение подбирать (межстрочный интервал настроен)

borderCCRP_Verts = {{-borderCCRP_sizeX, -borderCCRP_sizeY},
					{-borderCCRP_sizeX, borderCCRP_sizeY},
					{borderCCRP_sizeX, borderCCRP_sizeY},
					{borderCCRP_sizeX, -borderCCRP_sizeY}
					}
					
borderCCRP = addType1SymBorder("borderCCRP", borderCCRP_Verts, nil, FROM_HUD_CENTER(0, 24), {{"hud_mode_txt", 1}})

AddHUDTextElement_Pos_Val("HUD_Mode_CCRP_txt",
				  nil,
				  {0.0, 0.0},
				  borderCCRP.name,
				  HUD_DEFAULT_LEVEL + 2,
				  "CenterCenter",
				  "CCRP",
				  2)

--[[DLZ_PlaceHolder				= CreateDummy()
DLZ_PlaceHolder.name		= "DLZ_PlaceHolder"
DLZ_PlaceHolder.init_pos	= {-103.9, -25.0, 0.0}
DLZ_PlaceHolder.controllers	= {{"MasterArmSafe", 0}, {"IsIAM", 1}}
DLZ_PlaceHolder.collimated  = true
Add(DLZ_PlaceHolder)

local IAM_MR_halfY = 2.6
local IAM_MaxRng = AddHUDTexElement("IAM_MaxRng",
				{{-9, -IAM_MR_halfY}, {-9, IAM_MR_halfY}, 
				 {1, IAM_MR_halfY}, {1, -IAM_MR_halfY}}, 
				{17.0/texture_size, 9.50/texture_size, tex_scale, tex_scale},
				{{"WOW", 0}, {"IAM_DLZ_Index_pos_max", 50}},
				{4.1, IAM_MR_halfY, 0.0},
				{0.0, 0.0 , 0.0},
				"DLZ_PlaceHolder",
				HUD_DEFAULT_LEVEL)

AddHUDTexElement("DLZ_Index",
				{{-2.5, -3.5}, {-2.5, 3.5}, 
				 {2.5, 3.5}, {2.5, -3.5}},
				{17.58/texture_size, 8.69/texture_size, tex_scale, tex_scale},
				{{"WOW", 0}, {"IAM_DLZ_Index_pos", 50}},
				{-7.3, 0.0, 0.0},
				{0.0, 0.0, 0.0},
				"DLZ_PlaceHolder",
				HUD_DEFAULT_LEVEL)

AddHUDTextElement_Pos("DLZ_Index_txt", 
				  {{"IAM_DLZ_Index_Txt"}}, 
				   {-2.4, 0.0, 0.0}, 
				  "DLZ_Index",
				  HUD_DEFAULT_LEVEL,
				  "RightCenter")

AddHUDTextElement_Pos("DLZ_Index_txt_short", 
				  {{"IAM_DLZ_Index_Txt_short"}}, 
				  {-12.3, 50.0, 0.0}, 
				  "DLZ_PlaceHolder",
				  HUD_DEFAULT_LEVEL,
				  "RightCenter")

DLZ_ScaleHolder				= CreateDummy()
DLZ_ScaleHolder.name		= "DLZ_ScaleHolder"
DLZ_ScaleHolder.parent_element	= "DLZ_PlaceHolder"
DLZ_ScaleHolder.init_pos	= {0.0, 0.0, 0.0}
DLZ_ScaleHolder.controllers	= {{"IAM_DLZ_show"}}
DLZ_ScaleHolder.collimated = true
Add(DLZ_ScaleHolder)

AddHUDTexElement("DLZ_Index_pos_far",
				{{-8.4, -1.0}, {-8.4, 1.0}, 
				 {1.0, 1.0}, {1.0, -1.0}},
				{16.01/texture_size, 7.74/texture_size, tex_scale, tex_scale},
				{{"WOW", 0}, {"IAM_DLZ_Index_pos_far", 50}},
				{4.0, 0.0, 0.0},
				{0.0, 0.0, 0.0},
				"DLZ_ScaleHolder",
				HUD_DEFAULT_LEVEL)

AddHUDTexElement("DLZ_Index_pos_near",
				{{-8.4, -1.0}, {-8.4, 1.0}, 
				 {1.0, 1.0}, {1.0, -1.0}},
				{16.01/texture_size, 7.74/texture_size, tex_scale, tex_scale},
				{{"WOW", 0}, {"IAM_DLZ_Index_pos_near", 50}},
				{4.0, 0.0, 0.0},
				{0.0, 0.0, 0.0},
				"DLZ_ScaleHolder",
				HUD_DEFAULT_LEVEL)

addHWLine("IAM_DLZ_Staple_Left", 50, 50, {{"IAM_DLZ_Staple_vert", 50}}, {-7.4, 0, 0.0}, {90.0, 0.0, 0.0}, "DLZ_Index_pos_near", HUD_DEFAULT_LEVEL)
]]