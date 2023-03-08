dofile(LockOn_Options.script_path.."fonts.lua")

-------MATERIALS-------
materials = {}
materials["EKRAN_STNCL"]= {255, 0, 0, 255}
materials["RED"]		= {255, 0, 0, 255}
materials["HUD_NIGHT"]	= {127, 128, 45, 255} -- смесь 50/50 цветов светофильтра и индикации
materials["ORANGE"]		= {243, 116, 13, 255}
materials["ORANGE_2"]	= {255, 180, 0, 255}
materials["YELLOW"]		= {255, 255, 0, 255}
materials["YELLOW_2"]   = {255, 255, 0, 60}
materials["AMBER_HUD"]	= {255, 255, 0, 255}
materials["GREEN"]		= {0, 255, 0, 255}
materials["GREEN_2"]	= {0, 255, 48, 70}
materials["DARK_GREEN"]	= {60, 135, 0, 255}
materials["BLUE"]		= {0, 0, 255, 255}
materials["CYAN"]		= {113, 204, 250, 255}
materials["PURPLE"]		= {255, 0, 255, 255}
materials["SIMPLE_WHITE"]		= {255, 255, 255, 255}
materials["BLACK_IND"]		= {0, 0, 0, 255, 255}
materials["BLACK2"]		= {5, 5, 5, 255}
materials["BLACK3"]		= {5, 5, 5, 120}
materials["LIGHT_GREY"] = {245, 245, 245, 255}
materials["DARK_GREY"]  = {94, 100, 72, 255}
materials["GREY"]       = {160, 160, 160, 255}
materials["GULL_GREY"]  = {94, 147, 170, 255}
materials["VIOLET"]     = {204,102,204,255}
materials["BROWN_GLASS"]  = {94, 72, 12, 100}
materials["BRIGHTNESS_MASK_BLACK"] = {0, 0, 0, 0}
materials["DIGITAL_RED"] = {204, 26, 18, 255}
materials["DIGITAL_GREEN"] = {36, 148, 102, 255}
materials["SAM_BLUE"]  = {0, 0, 255, 50}
materials["SAM_RED"]   = {255, 0, 0, 50}
materials["SHKVAL_RECT"]   = {0, 255, 255, 255}
materials["WHITE_2"]   = {255, 255, 255, 120}
materials["PENCIL_GREY"]   = {38, 38, 38, 255}
materials["RED_TRANSPARENT"]    = {255, 0, 0, 100}
materials["GREEN_TRANSPARENT"]  = {0, 255, 0, 100}
materials["YELLOW_TRANSPARENT"] = {255, 255, 0, 100}
materials["ARK_TABLE"]   = {0, 0, 0, 150}


local IndicationTexturesPath = LockOn_Options.script_path.."../IndicationTextures/"

-------TEXTURES-------
textures = {}

HUD_color = materials["GREEN"]
--HUD_color = materials["AMBER_HUD"]

-- HUD

textures["INDICATION_HUD_KA50"]			 		= {IndicationTexturesPath.."Indication_hud_ka-50.tga", HUD_color}
textures["INDICATION_HUD_KA50_BORDER_FAR"] 		= {IndicationTexturesPath.."Indication_HUD_border_far_ka-50.tga", HUD_color}
textures["INDICATION_HUD_KA50_BORDER_NEAR"] 	= {IndicationTexturesPath.."Indication_HUD_border_near_ka-50.tga", HUD_color}
textures["MASK_HUD_KA50_BORDER_FAR"] 			= {IndicationTexturesPath.."Indication_HUD_border_far_ka-50.tga",  {255,0,255,255}}
textures["MASK_HUD_KA50_BORDER_NEAR"] 			= {IndicationTexturesPath.."Indication_HUD_border_near_ka-50.tga", {255,0,255,255}}

-- SHKVAL
textures["INDICATION_SHKVAL-V_TEMPLATE"]		 = {IndicationTexturesPath.."Indication_SHKVAL-V_template.tga", materials["SIMPLE_WHITE"]}
textures["INDICATION_SHKVAL-V_KA50"]			 = {IndicationTexturesPath.."Indication_shkval_ka-50.tga", materials["LIGHT_GREY"]}
textures["INDICATION_SHKVAL-V_TEST_PATTERN"]	 = {IndicationTexturesPath.."Test pattern.bmp", materials["LIGHT_GREY"]}

-- ABRIS
textures["INDICATION_ABRIS_TEMPLATE"]	 = {"INDICATION_ABRIS_.bmp", materials["ORANGE"]}
textures["INDICATION_ABRIS_WHITE"]		 = {IndicationTexturesPath.."Indication_abris_ka-50_2.tga", materials["SIMPLE_WHITE"]}
textures["INDICATION_ABRIS_BLUE"]		 = {IndicationTexturesPath.."Indication_abris_ka-50_2.tga", materials["BLUE"]}
textures["INDICATION_ABRIS_RED"]		 = {IndicationTexturesPath.."Indication_abris_ka-50_2.tga", materials["RED"]}
textures["INDICATION_ABRIS_GREEN"]		 = {IndicationTexturesPath.."Indication_abris_ka-50_2.tga", materials["GREEN"]}
textures["INDICATION_ABRIS_YELLOW"]		 = {IndicationTexturesPath.."Indication_abris_ka-50_2.tga", materials["YELLOW"]}
textures["INDICATION_ABRIS_BLACK"]		 = {IndicationTexturesPath.."Indication_abris_ka-50_2.tga", materials["BLACK_IND"]}
textures["INDICATION_ABRIS_VIOLET"]		 = {IndicationTexturesPath.."Indication_abris_ka-50_2.tga", materials["VIOLET"]}

--Helmet
textures["INDICATION_HELMET_KA50"]		 = {IndicationTexturesPath.."Indication_Helmet.tga", materials["YELLOW"]}
textures["HELMET_FRAME"]		 		 = {IndicationTexturesPath.."helmet_frame.tga", materials["BLACK3"]}

-- caution lights
textures["CAUTION_RED"]		 = {"caution-button.tga", materials["RED_TRANSPARENT"]}
textures["CAUTION_GREEN"]	 = {"caution-button.tga", materials["GREEN_TRANSPARENT"]}
textures["CAUTION_YELLOW"]	 = {"caution-button.tga", materials["YELLOW_TRANSPARENT"]}


textures["ARCADE"]                      = {"arcade.tga",materials["RED"]}
textures["ARCADE_YELLOW"]               = {"arcade.tga",materials["YELLOW"]}
textures["ARCADE_PURPLE"]               = {"arcade.tga",materials["PURPLE"]}
textures["ARCADE_GREY"]                 = {"arcade.tga",materials["GREY"]}
textures["ARCADE_RED"]                  = {"arcade.tga",materials["RED"]}
textures["ARCADE_GREEN"]                  = {"arcade.tga",materials["GREEN"]}
textures["ARCADE_BLUE"]                  = {"arcade.tga",materials["BLUE"]}

textures["ARCADE_2"]                      = {"arcade.tga",materials["RED"]}
textures["ARCADE_2_YELLOW"]               = {"arcade.tga",materials["YELLOW"]}
textures["ARCADE_2_PURPLE"]               = {"arcade.tga",materials["PURPLE"]}
textures["ARCADE_2_GREY"]                 = {"arcade.tga",materials["GREY"]}
textures["ARCADE_3"]                      = {IndicationTexturesPath.."Indication_hud_ka-50.tga",materials["YELLOW"]}
textures["ARCADE_4"]                      = {IndicationTexturesPath.."Indication_hud_ka-50.tga",materials["RED"]}
textures["ARCADE_3_RED"]                  = {"arcade.tga",materials["RED"]}
textures["ARCADE_TRANSP_RED"]             = {"arcade.tga",materials["RED_TRANSPARENT"]}
textures["ARCADE_TRANSP_GREEN"]           = {"arcade.tga",materials["GREEN_TRANSPARENT"]}
textures["ARCADE_TRANSP_YELLOW"]	      = {"arcade.tga",materials["YELLOW_TRANSPARENT"]}

textures["RADAR"]                       = {"radar.tga",materials["WHITE_2"]}

textures["INDICATION_PENCIL_GRAY"]		= {IndicationTexturesPath.."Indication_abris_ka-50_2.tga", materials["PENCIL_GREY"]}
textures["LINES_ARK_TABLE"]				= {IndicationTexturesPath.."Indication_abris_ka-50_2.tga", materials["ARK_TABLE"]}

-------FONTS-------
fonts = {}
fonts["font_Ka-50_dbg"]					= {fontdescription["font_Ka-50_dbg"],	 				materials["GREEN"]}
fonts["font_Ka-50_HUD"]					= {fontdescription["font_Ka-50_HUD"],	 				HUD_color}
fonts["font_Ka-50_SHKVAL"]				= {fontdescription["font_Ka-50_SHKVAL"],		 		materials["LIGHT_GREY"]}
fonts["font_Ka-50_ABRIS_WHITE"]			= {fontdescription["font_Ka-50_ABRIS_WHITE"] , 			materials["SIMPLE_WHITE"]}
fonts["font_Ka-50_ABRIS_WHITE_INVERSE"] = {fontdescription["font_Ka-50_ABRIS_WHITE_INVERSE"],	materials["SIMPLE_WHITE"]}
fonts["font_Ka-50_ABRIS_GREEN"]			= {fontdescription["font_Ka-50_ABRIS_WHITE"] ,			materials["GREEN"]}
fonts["font_Ka-50_ABRIS_RED"]			= {fontdescription["font_Ka-50_ABRIS_WHITE"] ,			materials["RED"]}
fonts["font_Ka-50_ABRIS_YELLOW"]		= {fontdescription["font_Ka-50_ABRIS_WHITE"] ,			materials["YELLOW"]}
fonts["font_Ka-50_ABRIS_DARK_GREY"]		= {fontdescription["font_Ka-50_ABRIS_WHITE"] ,			materials["GREY"]}
fonts["font_Ka-50_ABRIS_BLACK"]			= {fontdescription["font_Ka-50_ABRIS_WHITE"] ,			materials["BLACK_IND"]}
fonts["font_Ka-50_ABRIS_BLUE"]			= {fontdescription["font_Ka-50_ABRIS_WHITE"] ,			materials["BLUE"]}
fonts["font_Ka-50_ABRIS_VIOLET"]		= {fontdescription["font_Ka-50_ABRIS_WHITE"] ,			materials["VIOLET"]}


fonts["font_Ka-50_HUD_GREEN"]			= {fontdescription["font_Ka-50_HUD"],materials["GREEN"]}
fonts["font_Ka-50_HUD_RED"]	            = {fontdescription["font_Ka-50_HUD"],materials["RED"]}
fonts["font_Ka-50_HUD_YELLOW"]			= {fontdescription["font_Ka-50_HUD"],materials["YELLOW"]}

fonts["font_EKRAN"]						= {fontdescription["font_EKRAN"],materials["ORANGE_2"]}
fonts["font_PVI"]						= {fontdescription["font_PVI"],  {255, 0, 0, 255}}
fonts["font_PUI_800"]					= {fontdescription["font_PVI"],  materials["DIGITAL_GREEN"]}
fonts["font_UV_26"]						= {fontdescription["font_UV26"], materials["DIGITAL_RED"]}

fonts["font_ARCADE"]                    = {fontdescription["font_Ka-50_HUD"], materials["YELLOW"]}
fonts["font_ARCADE_RED"]                = {fontdescription["font_Ka-50_HUD"], materials["RED"]}
fonts["font_ARCADE_GREEN"]              = {fontdescription["font_Ka-50_HUD"], materials["GREEN_TRANSPARENT"]}
fonts["font_ARK_table"] 				= {fontdescription["font_Ka-50_ABRIS_WHITE"],materials["ARK_TABLE"]}


fonts["font_CAUTION_GREEN"]				= {fontdescription["font_Ka-50_HUD"], {68 ,250,150,255} }
fonts["font_CAUTION_RED"]	            = {fontdescription["font_Ka-50_HUD"], {255,80 ,152,255} }
fonts["font_CAUTION_YELLOW"]			= {fontdescription["font_Ka-50_HUD"], {245,255,139,255} }


-- force preload resources to avoid freeze on start
preload_texture = 
{
	IndicationTexturesPath.."Indication_abris_ka-50_2.tga",
	IndicationTexturesPath.."ABRIS_FONT.tga",
	IndicationTexturesPath.."font_Ka-50_SHKVAL.tga",
	IndicationTexturesPath.."font_Ka-50_HUD.tga",
	IndicationTexturesPath.."Indication_hud_ka-50.tga",
	IndicationTexturesPath.."Indication_HUD_border_far_ka-50.tga",
	IndicationTexturesPath.."Indication_HUD_border_near_ka-50.tga",
	IndicationTexturesPath.."helmet_frame.tga"
}



