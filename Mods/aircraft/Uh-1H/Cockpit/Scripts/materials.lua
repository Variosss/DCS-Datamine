dofile(LockOn_Options.script_path.."fonts.lua")
-------MATERIALS-------
materials = {}
materials["RED"]		= {255, 0, 0, 255}
materials["RED_1"]		= {255, 0, 0, 100}
materials["HUD_NIGHT"]	= {127, 128, 45, 255} -- смесь 50/50 цветов светофильтра и индикации
materials["ORANGE"]		= {243, 116, 13, 100}
materials["ORANGE_2"]	= {255, 180, 0, 255}
materials["YELLOW"]		= {255, 255, 0, 255}
materials["YELLOW_2"]   = {255, 255, 0, 60}
materials["AMBER_HUD"]	= {255, 255, 0, 255}
materials["GREEN"]		= {0, 255, 0, 255}
materials["GREEN_2"]	= {0, 255, 48, 200}
materials["DARK_GREEN"]	= {60, 135, 0, 255}
materials["BLUE"]		= {0, 0, 255, 255}
materials["CYAN"]		= {113, 204, 250, 255}
materials["PURPLE"]		= {255, 0, 255, 255}
materials["SIMPLE_WHITE"] = {255, 255, 255, 255}
materials["BLACK_IND"]	= {0, 0, 0, 255, 255}
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
materials["DBG_GREEN"]   		= {0, 255, 0, 100}
materials["DBG_RED"]    		= {255, 0, 0, 100}
materials["HUD_IND_YELLOW"]   	= {243, 116, 13, 255}
materials["GENERAL_INFO_GOLD"]  = {255, 197, 3, 255}
materials["ARC51_SHEET"]		= {0, 0, 0, 210}

-------TEXTURES-------
local IndicationTexturesPath = LockOn_Options.script_path.."../IndicationTextures/"
textures = {}

-- Sight
textures["INDICATION_FLEXSIGHT"]	= {IndicationTexturesPath.."sight_UH_1H.tga", materials["HUD_IND_YELLOW"]}
textures["INDICATION_PILOTSIGHT"]	= {IndicationTexturesPath.."sight_XM60.tga", materials["HUD_IND_YELLOW"]}

textures["ARCADE"]			= {"arcade.tga",materials["RED"]}
textures["ARCADE_YELLOW"]	= {"arcade.tga",materials["YELLOW"]}
textures["ARCADE_PURPLE"]	= {"arcade.tga",materials["PURPLE"]}
textures["ARCADE_GREY"]		= {"arcade.tga",materials["GREY"]}
textures["ARCADE_RED"]		= {"arcade.tga",materials["RED"]}
textures["ARCADE_RED_1"]		= {"arcade.tga",materials["RED_1"]}
textures["ARCADE_GREEN"]	= {"arcade.tga",materials["GREEN"]}
textures["ARCADE_BLUE"]		= {"arcade.tga",materials["BLUE"]}

textures["ARCADE_2"]		= {"arcade.tga",materials["RED"]}
textures["ARCADE_2_YELLOW"]	= {"arcade.tga",materials["YELLOW"]}
textures["ARCADE_2_PURPLE"]	= {"arcade.tga",materials["PURPLE"]}
textures["ARCADE_2_GREY"]	= {"arcade.tga",materials["GREY"]}
textures["ARCADE_4"]		= {IndicationTexturesPath.."Indication_arcade_UH.tga",materials["RED"]}
textures["ARCADE_3_RED"]	= {"arcade.tga",materials["RED"]}
textures["ARCADE_4_RED"]	= {"big_circle.tga",materials["RED"]}
textures["ARCADE_3_ORANGE_2"]	= {"arcade.tga",materials["ORANGE_2"]}
textures["ARCADE_TRANSP_RED"]		= {"arcade.tga",materials["RED_TRANSPARENT"]}
textures["ARCADE_TRANSP_GREEN"]		= {"arcade.tga",materials["GREEN_TRANSPARENT"]}
textures["ARCADE_TRANSP_YELLOW"]	= {"arcade.tga",materials["YELLOW_TRANSPARENT"]}
textures["ARCADE_3_WHITE"]			= {"arcade.tga",materials["SIMPLE_WHITE"]}

textures["RADAR"]					= {"radar.tga",materials["WHITE_2"]}

fonts = {}
fonts["font_general"]				= {fontdescription["font_general"], 10, materials["GENERAL_INFO_GOLD"]}
fonts["font_ARC51_sheet"]			= {fontdescription["font_Sheet"], 10, materials["ARC51_SHEET"]}

fonts["font_hints_kneeboard"]			= {fontdescription["font_general"], 10, {100,0,100,255}}
fonts["font_hints_kneeboard_keys"]		= {fontdescription["font_general"], 10, materials["RED"]}

-- force preload resources to avoid freeze on start
preload_texture = 
{
	IndicationTexturesPath.."sight_UH_1H.tga",
	IndicationTexturesPath.."Indication_arcade_UH.tga",
	"triggers.tga"
}



