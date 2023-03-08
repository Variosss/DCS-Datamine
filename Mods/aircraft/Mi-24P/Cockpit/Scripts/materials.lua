dofile(LockOn_Options.script_path.."fonts.lua")

-------MATERIALS-------
materials = {}
materials["RED"]		= {255, 0, 0, 255}
materials["ORANGE"]		= {243, 116, 13, 255}
materials["ORANGE_2"]	= {255, 180, 0, 30}
materials["YELLOW"]		= {255, 255, 0, 255}
materials["YELLOW_2"]   = {255, 255, 0, 60}
materials["AMBER_HUD"]	= {255, 255, 0, 255}
materials["GREEN"]		= {0, 255, 0, 255}
materials["GREEN_2"]	= {0, 255, 0, 20}
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
materials["WHITE_2"]   = {255, 255, 255, 120}
materials["PENCIL_GREY"]   = {38, 38, 38, 255}
materials["RED_TRANSPARENT"]    = {255, 0, 0, 100}
materials["GREEN_TRANSPARENT"]  = {0, 255, 0, 100}
materials["YELLOW_TRANSPARENT"] = {255, 255, 0, 100}

-- Sight
materials["PKV_IND_ORANGE"]   	= {255, 60, 0, 255}
materials["GENERAL_INFO_GOLD"]  = {255, 197, 3, 255}
-------TEXTURES-------
textures = {}

local IndicationTexturesPath = LockOn_Options.script_path.."../IndicationTextures/"

-- Sight
textures["INDICATION_ASP17_FLEX"]					= {IndicationTexturesPath.."ASP17_flex_sight.tga", materials["PKV_IND_ORANGE"]}
textures["INDICATION_PKV_GRID"]						= {IndicationTexturesPath.."PKV_Grid.tga", materials["PKV_IND_ORANGE"]}
textures["INDICATION_9K113_GRID_FIXED"]				= {IndicationTexturesPath.."9K113_Fixed_Grid.tga", materials["BLACK_IND"]}
textures["INDICATION_9K113_GRID_10x"]				= {IndicationTexturesPath.."9K113_Grid_10x.tga", materials["BLACK_IND"]}
textures["INDICATION_9K113_GRID_10x_backlight"]		= {IndicationTexturesPath.."9K113_Grid_10x_backlight.tga", materials["ORANGE"]}
textures["INDICATION_9K113_GRID_3x"]				= {IndicationTexturesPath.."9K113_Grid_3x.tga", materials["BLACK_IND"]}
textures["INDICATION_9K113_GRID_3x_backlight"]		= {IndicationTexturesPath.."9K113_Grid_3x_backlight.tga", materials["ORANGE"]}
textures["INDICATION_9K113_READY"]					= {IndicationTexturesPath.."9K113_Ready.tga", materials["PKV_IND_ORANGE"]}
textures["INDICATION_9K113_BG"]						= {IndicationTexturesPath.."9K113_bg.tga", materials["BLACK_IND"]}

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
textures["ARCADE_3_RED"]                  = {"arcade.tga",materials["RED"]}
textures["ARCADE_4_RED"]				  = {"big_circle.tga",materials["RED"]}
textures["ARCADE_TRANSP_RED"]             = {"arcade.tga",materials["RED_TRANSPARENT"]}
textures["ARCADE_TRANSP_GREEN"]           = {"arcade.tga",materials["GREEN_TRANSPARENT"]}
textures["ARCADE_TRANSP_YELLOW"]	      = {"arcade.tga",materials["YELLOW_TRANSPARENT"]}
textures["ARCADE_3_WHITE"]                = {"arcade.tga",materials["SIMPLE_WHITE"]}

textures["RADAR"]                       = {"radar.tga",materials["WHITE_2"]}

-------FONTS-------
fonts = {}
fonts["font_general"]					= {fontdescription["font_general"], 10, materials["GENERAL_INFO_GOLD"]}
fonts["font_ARCADE"]                    = {fontdescription["font_Mi8_Arcade"], 10, materials["YELLOW"]}
fonts["font_ARCADE_RED"]                = {fontdescription["font_Mi8_Arcade"], 10, materials["RED"]}
fonts["font_ARCADE_WHITE"]              = {fontdescription["font_Mi8_Arcade"], 10, materials["SIMPLE_WHITE"]}
fonts["font_ARCADE_GREEN"]              = {fontdescription["font_Mi8_Arcade"], 10, materials["GREEN_TRANSPARENT"]}
fonts["font_ARCADE_YELLOW"]             = {fontdescription["font_Mi8_Arcade"], 10, materials["YELLOW"]}
fonts["font_hints_kneeboard"]			= {fontdescription["font_general_loc"], 10, {100,0,100,255}}
fonts["font_hints_kneeboard_keys"]		= {fontdescription["font_general_loc"], 10, materials["RED"]}

fonts["font_checklist_kneeboard"]			= {fontdescription["font_general_loc"], 10, {0, 0, 0, 255}}
fonts["font_checklist_kneeboard_keys"]		= {fontdescription["font_general_loc"], 10, materials["RED"]}
fonts["font_checklist_kneeboard_item"]		= {fontdescription["font_general_loc"], 10, {0, 0, 50, 255}}
fonts["font_checklist_kneeboard_answer"]	= {fontdescription["font_general_loc"], 10, {0, 50, 0, 255}}

fonts["font_mapdisplay"]					= {fontdescription["font_general"], 10, materials["BLACK_IND"]} --do not remove!
fonts["font_helperai_menu"]              = {fontdescription["font_general"], 10, materials["SIMPLE_WHITE"]}


-- force preload resources to avoid freeze on start
preload_texture = 
{
	LockOn_Options.script_path.."../IndicationTextures/PKV_Grid.tga",
	LockOn_Options.script_path.."../IndicationTextures/ASP17_flex_sight.tga",
	LockOn_Options.script_path.."../IndicationTextures/9K113_Fixed_Grid.tga",
	LockOn_Options.script_path.."../IndicationTextures/9K113_Grid_10x.tga",
	LockOn_Options.script_path.."../IndicationTextures/9K113_Grid_3x.tga",
	LockOn_Options.script_path.."../IndicationTextures/9K113_Ready.tga",
	LockOn_Options.script_path.."../IndicationTextures/9K113_bg.tga",
}
