dofile(LockOn_Options.script_path.."HUD/Indicator/HUD_definitions.lua")

AddHUDTexElement("DRC_Line", 
				{{-6.0, -1.0}, {-6.0, 1.0}, 
				{6.0, 1.0}, {6.0, -1.0}},
				{15.57/texture_size, 7.38/texture_size, tex_scale, tex_scale},
				{{"MasterArmSafe", 0}, {"IsMaverickSelected", 0}, {"DRC_Line_pos", 20, ZSL, 100, 20}},
				{0.0, 0.0, 0.0},
				{0.0, 0.0, 0.0},
				nil,
				HUD_DEFAULT_LEVEL)
				
AddHUDTexElement("DRC_invalid", 
				{{-6.0, -6.0}, {-6.0, 6.0}, 
				{6.0, 6.0}, {6.0, -6.0}},
				{16.24/texture_size, 14.44/texture_size, tex_scale, tex_scale},
				{{"DRC_invalid_show"}},
				{0.0, 0.0, 0.0},
				{0.0, 0.0, 0.0},
				"DRC_Line",
				HUD_DEFAULT_LEVEL)
				
AddHUDTexElement("MRS", 
				{{-12.0, -3.8}, {-12.0, 1.0}, 
				{12.0, 1.0}, {12.0, -3.8}},
				{6.275/texture_size, 3.54/texture_size, tex_scale, tex_scale},
				{{"MasterArmSafe", 0}, {"IsMaverickSelected", 0}, {"MRS_pos", 20, ZSL, 100, 20}},
				{0.0, 0.0, 0.0},
				{0.0, 0.0, 0.0},
				nil,
				HUD_DEFAULT_LEVEL)
				
AddHUDTexElement("MRS_invalid", 
				{{-12.0, -12.0}, {-12.0, 12.0}, 
				{12.0, 12.0}, {12.0, -12.0}},
				{10.41/texture_size, 16.19/texture_size, tex_scale, tex_scale},
				{{"MRS_invalid_show"}},
				{0.0, 0.0, 0.0},
				{0.0, 0.0, 0.0},
				"MRS",
				HUD_DEFAULT_LEVEL)
				
Pipper_Reticle_pnt			= CreateDummy()
Pipper_Reticle_pnt.name		= "Pipper_Reticle_pnt"
Pipper_Reticle_pnt.level 	= HUD_DEFAULT_LEVEL
Pipper_Reticle_pnt.controllers =
	{{"MasterArmSafe", 0}, --[[{"IsIAM", 0},--]] {"pipper_reticle_pos", ZSL, 100, TFOV, 28},
	 {"pipper_reticle_max_defl", 160, CCRP_MaxPiperDefl}}
Add(Pipper_Reticle_pnt)

AddHUDTexElement("gun_pipper_reticle",
					{{-31.0, -31.0}, {-31.0, 31.0}, 
					{31.0, 31.0}, {31.0, -31.0}},
					{3.57 / texture_size, 10.43 / texture_size, tex_scale, tex_scale},
					{--[[{"IsIAM", 0},--]]{"pipper_reticle_blink", 0.1667}},
					{0.0, 0.0, 0.0},
					{0.0, 0.0, 0.0},
					"Pipper_Reticle_pnt",
					HUD_DEFAULT_LEVEL)

AddHUDTexElement("gun_pipper_reticle_pnt1", 
					{{-1.0, -1.0}, {-1.0, 1.0}, 
					{1.0, 1.0}, {1.0, -1.0}},
					{15.75/texture_size, 10.43/texture_size, tex_scale, tex_scale},
					{{"gun_pipper_reticle_pnt_pos", 1, ZSL}},
					{0.0, 0.0, 0.0},
					{0.0, 0.0, 0.0},
					"gun_pipper_reticle",
					HUD_DEFAULT_LEVEL)

AddHUDTexElement("gun_pipper_reticle_pnt2", 
					{{-1.0, -1.0}, {-1.0, 1.0}, 
					{1.0, 1.0}, {1.0, -1.0}},
					{15.75/texture_size, 10.43/texture_size, tex_scale, tex_scale},
					{{"gun_pipper_reticle_pnt_pos", 2, ZSL}},
					{0.0, 0.0, 0.0},
					{0.0, 0.0, 0.0},
					"gun_pipper_reticle",
					HUD_DEFAULT_LEVEL)

AddHUDTextElement("Range_Numeric", 
				  {{"Range_Numeric_txt", 10.0}}, 
				  {0.0, -35.0, 0.0}, 
				  "gun_pipper_reticle",
				  HUD_DEFAULT_LEVEL)

AddHUDTextElement_Pos_Val("RKT_symb", 
				  {{"RKT_symb_show"}}, 
				  {0.0, -35.0, 0.0}, 
				  "gun_pipper_reticle",
				  HUD_DEFAULT_LEVEL,
				  "CenterCenter",
				  "RKT")

AddHUDTexElement("invalid_X", 
				{{-12.0, -12.0}, {-12.0, 12.0}, 
				{12.0, 12.0}, {12.0, -12.0}},
				{13.575/texture_size, 16.215/texture_size, tex_scale, tex_scale},
				{{"pipper_invalid", ZSL, 25, 25}},
				{0.0, 0.0, 0.0},
				{0.0, 0.0, 0.0},
				"gun_pipper_reticle",
				HUD_DEFAULT_LEVEL)
				
AddHUDTexElement("invalid_dashed_X", 
				{{-12.0, -12.0}, {-12.0, 12.0}, 
				{12.0, 12.0}, {12.0, -12.0}},
				{7.525/texture_size, 16.17/texture_size, tex_scale, tex_scale},
				{{"pipper_invalid_dashed", 25, 25}},
				{0.0, 0.0, 0.0},
				{0.0, 0.0, 0.0},
				"gun_pipper_reticle",
				HUD_DEFAULT_LEVEL)				  

X_symb = Add_invalid_X_symbol("gun_pipper_reticle", {{"pipper_invalid_gun"}})

gun_pipper_reticle_distance_sector					= CreateElement "ceHWSector"
gun_pipper_reticle_distance_sector.name				=  "gun_pipper_reticle_distance_sector"
gun_pipper_reticle_distance_sector.vertices1		= {{-2.0, -23.0}, {-2.0, 23.0}, 
													   {23.0, 23.0}, {23.0, -23.0}}
gun_pipper_reticle_distance_sector.tex_params1		= {14.0 / texture_size, 4.05 / texture_size, tex_scale, tex_scale}
gun_pipper_reticle_distance_sector.vertices2		= {{-23.0, -23.0}, {-23.0, 23.0}, 
													   {2.0, 23.0}, {2.0, -23.0}}
gun_pipper_reticle_distance_sector.tex_params2		= {13.69 / texture_size, 4.05 / texture_size, tex_scale, tex_scale}
gun_pipper_reticle_distance_sector.maskvertices		= {{-23.0, -23.0}, {-23.0, 23.0}, 
													   {0.0, 23.0}, {0.0, -23.0}}
gun_pipper_reticle_distance_sector.indices			= default_box_indices
gun_pipper_reticle_distance_sector.material			= "INDICATION_HUD"
gun_pipper_reticle_distance_sector.controllers    = {{"gun_pipper_distance_sector"}}
gun_pipper_reticle_distance_sector.parent_element	= "gun_pipper_reticle"
gun_pipper_reticle_distance_sector.h_clip_relation	= h_clip_relations.COMPARE
gun_pipper_reticle_distance_sector.level			= HUD_DEFAULT_LEVEL
gun_pipper_reticle_distance_sector.minangle			= math.rad(1.0)
gun_pipper_reticle_distance_sector.maxangle			= math.rad(359.0)
gun_pipper_reticle_distance_sector.angle			= math.rad(0.0)
gun_pipper_reticle_distance_sector.additive_alpha	= true
gun_pipper_reticle_distance_sector.collimated		= true
Add(gun_pipper_reticle_distance_sector)

AddHUDTexElement("gun_pipper_reticle_tick", 
					{{-1.0, -23.0}, {-1.0, 0.0}, 
					{1.0, 0.0}, {1.0, -23.0}},
					{16.8 / texture_size, 4.1 / texture_size, tex_scale, tex_scale},
					{{"gun_pipper_reticle_tick"}},
					{0.0, 0.0, 0.0},
					{180.0, 0.0, 0.0},
					"gun_pipper_reticle_distance_sector",
					HUD_DEFAULT_LEVEL)

AddHUDTexElement("pipper_reticle_triang", 
					{{-4.0, -23.0}, {-4.0, -15.0}, 
					{4.0, -15.0}, {4.0, -23.0}},
					{7.485 / texture_size, 2.85 / texture_size, tex_scale, tex_scale},
					{{"IsIAM", 0},{"analog_min_range"}},
					{0.0, 0.0, 0.0},
					{0.0, 0.0, 0.0},
					"gun_pipper_reticle",
					HUD_DEFAULT_LEVEL)

AddHUDTexElement("pipper_reticle_triang_min_iam", 
					{{-4.0, -23.0}, {-4.0, -15.0}, 
					{4.0, -15.0}, {4.0, -23.0}},
					{7.485 / texture_size, 2.85 / texture_size, tex_scale, tex_scale},
					{{"IsIAM", 1},{"iam_range",0}},
					{0.0, 0.0, 0.0},
					{0.0, 0.0, 0.0},
					"gun_pipper_reticle",
					HUD_DEFAULT_LEVEL)					

AddHUDTexElement("pipper_reticle_triang_max_iam", 
					{{-4.0, -23.0}, {-4.0, -15.0}, 
					{4.0, -15.0}, {4.0, -23.0}},
					{7.485 / texture_size, 2.85 / texture_size, tex_scale, tex_scale},
					{{"IsIAM", 1},{"iam_range",1}},
					{0.0, 0.0, 0.0},
					{0.0, 0.0, 0.0},
					"gun_pipper_reticle",
					HUD_DEFAULT_LEVEL)

AddHUDTexElement("gun_pipper_reticle_MRC", 
					{{-4.0, -4.5}, {-4.0, 4.5}, 
					{4.0, 4.5}, {4.0, -4.5}},
					{7.485 / texture_size, 5.03 / texture_size, tex_scale, tex_scale},
					{{"analog_MRC", 5, 32}},
					{34.0, 0.0, 0.0},
					{-90.0, 0.0, 0.0},
					"gun_pipper_reticle",
					HUD_DEFAULT_LEVEL)

moving_target_index				= CreateDummy()
moving_target_index.name		= "moving_target_index"
moving_target_index.init_pos	= {0.0, 0.0, 0.0}
moving_target_index.parent_element = "gun_pipper_reticle"
moving_target_index.controllers	= {{"moving_target_rot"}} 
Add(moving_target_index)

AddHUDTexElement("moving_target_index_1", 
					{{-4.0, -1.0}, {-4.0, 1.0}, 
					{4.0, 1.0}, {4.0, -1.0}},
					{7.54 / texture_size, 4.17 / texture_size, tex_scale, tex_scale},
					{{"moving_target_lead", 0, 20}},
					{0.0, 0.0, 0.0},
					{90.0, 0.0, 0.0},
					"moving_target_index",
					HUD_DEFAULT_LEVEL)

AddHUDTexElement("moving_target_index_2", 
					{{-4.0, -1.0}, {-4.0, 1.0}, 
					{4.0, 1.0}, {4.0, -1.0}},
					{7.54 / texture_size, 4.17 / texture_size, tex_scale, tex_scale},
					{{"moving_target_lead", 1, 20}},
					{0.0, 0.0, 0.0},
					{90.0, 0.0, 0.0},
					"moving_target_index",
					HUD_DEFAULT_LEVEL)
				
AddHUDTexElement("pipper_reticle_dashed", 
					{{-31.0, -31.0}, {-31.0, 31.0}, 
					{31.0, 31.0}, {31.0, -31.0}},
					{10.895 / texture_size, 10.43 / texture_size, tex_scale, tex_scale},
					{{"MasterArmSafe", 0}, {"IsMaverickSelected", 0}, {"pipper_reticle_dashed_pos", ZSL, TFOV, 28, 20}},
					{0.0, 0.0, 0.0},
					{0.0, 0.0, 0.0},
					nil,
					HUD_DEFAULT_LEVEL)
					

AddHUDTexElement("pipper_reticle_dashed_pnt", 
					{{-1.0, -1.0}, {-1.0, 1.0}, 
					{1.0, 1.0}, {1.0, -1.0}},
					{15.75/texture_size, 10.43/texture_size, tex_scale, tex_scale},
					nil,
					{0.0, 0.0, 0.0},
					{0.0, 0.0, 0.0},
					"pipper_reticle_dashed",
					HUD_DEFAULT_LEVEL)

AddHUDTextElement_Pos("PD_TTR_num", 
				  {{"PD_TTR_num", 20}}, 
				  {-6.0, -2.0, 0.0}, 
				  "pipper_reticle_dashed",
				  HUD_DEFAULT_LEVEL,
				  "RightCenter")		
					
AddHUDTexElement("invalid_X1", 
				{{-12.0, -12.0}, {-12.0, 12.0}, 
				{12.0, 12.0}, {12.0, -12.0}},
				{13.575/texture_size, 16.215/texture_size, tex_scale, tex_scale},
				{{"pipper_invalid", ZSL, 25, 25}},
				{0.0, 0.0, 0.0},
				{0.0, 0.0, 0.0},
				"pipper_reticle_dashed",
				HUD_DEFAULT_LEVEL)
				
AddHUDTexElement("invalid_dashed_X1", 
				{{-12.0, -12.0}, {-12.0, 12.0}, 
				{12.0, 12.0}, {12.0, -12.0}},
				{7.525/texture_size, 16.17/texture_size, tex_scale, tex_scale},
				{{"pipper_invalid_dashed", 25, 25}},
				{0.0, 0.0, 0.0},
				{0.0, 0.0, 0.0},
				"pipper_reticle_dashed",
				HUD_DEFAULT_LEVEL)					
				

AddHUDTexElement("CCIP_gun_cross", 
					{{-11.0, -11.0}, {-11.0, 11.0}, 
					{11.0, 11.0}, {11.0, -11.0}},
					{9.71 / texture_size, 1.54 / texture_size, tex_scale, tex_scale},
					{{"MasterArmSafe", 0}, {"pipper_reticle_pos", ZSL, 100, TFOV, 28, 1},
					 {"pipper_reticle_max_defl", 160, CCRP_MaxPiperDefl, 1}},
					{0.0, 0.0, 0.0},
					{0.0, 0.0, 0.0},
					nil,
					HUD_DEFAULT_LEVEL)
					
AddHUDTexElement("CCIP_gun_cross_tick", 
					{{-4.0, -1.0}, {-4.0, 1.0}, 
					{4.0, 1.0}, {4.0, -1.0}},
					{9.71 / texture_size, 3.28 / texture_size, tex_scale, tex_scale},
					{{"pipper_invalid_gun", 0}},
					{0.0, 10.5, 0.0},
					{0.0, 0.0, 0.0},
					"CCIP_gun_cross",
					HUD_DEFAULT_LEVEL)
					
Add_invalid_X_symbol("CCIP_gun_cross", {{"pipper_invalid_gun", 1}})					

AddHUDTextElement("Range_Numeric_GunCross", 
				  {{"Range_Numeric_txt", 10.0, 1}}, 
				  {0.0, -15.0, 0.0}, 
				  "CCIP_gun_cross",
				  HUD_DEFAULT_LEVEL)

AddHUDTexElement("CCIP_gun_cross_MRC",
					{{-4.0, -4.5}, {-4.0, 4.5}, 
					{4.0, 4.5}, {4.0, -4.5}},
					{7.485 / texture_size, 5.03 / texture_size, tex_scale, tex_scale},
					{{"analog_MRC", 5, 12}},
					{14.0, 0.0, 0.0},
					{-90.0, 0.0, 0.0},
					"CCIP_gun_cross",
					HUD_DEFAULT_LEVEL)

AddHUDTexElement("Wind_Corrected_gun_cross", 
					{{-11.0, -11.0}, {-11.0, 11.0}, 
					{11.0, 11.0}, {11.0, -11.0}},
					{9.71 / texture_size, 1.54 / texture_size, tex_scale, tex_scale},
					{{"MasterArmSafe", 0}, {"GunSymbologyAvail", 1}, {"HARS_on",0}, {"Wind_Corrected_gun_cross_pos", 160, ZSL}},
					{0.0, 0.0, 0.0},
					{0.0, 0.0, 0.0},
					nil,
					HUD_DEFAULT_LEVEL)								
					
Add_invalid_X_symbol("Wind_Corrected_gun_cross", {{"invalid_4000_gun"}})
				
AddHUDTexElement("Wind_Corrected_gun_cross_MRC",
					{{-4.0, -4.5}, {-4.0, 4.5}, 
					{4.0, 4.5}, {4.0, -4.5}},
					{7.485 / texture_size, 5.03 / texture_size, tex_scale, tex_scale},
					{{"analog_MRC", 5, 12}},
					{14.0, 0.0, 0.0},
					{-90.0, 0.0, 0.0},
					"Wind_Corrected_gun_cross",
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

AddHUDTexElement("BATA_symb", 
				{{-2.5, -2.5}, {-2.5, 2.5},
				{2.5, 2.5},	{2.5, -2.5}},
				{7.53/texture_size, 2.26/texture_size, tex_scale, tex_scale},
				{{"MasterArmSafe", 0}, {"BATA_symb_pos", ZSL}},
				{0.0, 0.0, 0.0},
				{0.0, 0.0, 0.0},
				nil,
				HUD_DEFAULT_LEVEL)						
