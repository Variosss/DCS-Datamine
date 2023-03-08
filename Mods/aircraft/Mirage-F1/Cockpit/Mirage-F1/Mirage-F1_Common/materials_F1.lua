dofile(LockOn_Options.script_path.."../../Common/materials_common.lua")
dofile(LockOn_Options.script_path.."../../Mirage-F1/Mirage-F1_Common/fonts_F1.lua")
dofile(LockOn_Options.script_path.."../../Mirage-F1/Mirage-F1_Common/SightSystem/SightSystem_colors.lua")
dofile(LockOn_Options.script_path.."../../Mirage-F1/Mirage-F1_Common/Radar_Cyrano_IV_legacy/Radar_Cyrano_IV_legacy_colors.lua")

-------MATERIALS-------
materials["SIGHT_SYSTEM_WHITE"]     		= SightSystem_WHITE
materials["SIGHT_SYSTEM_RED"]       		= SightSystem_RED
materials["SIGHT_SYSTEM_GREEN"]     		= SightSystem_GREEN
materials["SIGHT_SYSTEM_BLUE"]      		= SightSystem_BLUE
materials["SIGHT_SYSTEM_AMBER"]     		= SightSystem_AMBER

materials["SIGHT_SYSTEM_BACKLIGHT_GREEN"]   = {0, 255, 0, 30} --{0, 255, 0, 0.1}

materials["RADAR_LEGACY_GREEN"]   			= RadarLegacy_GREEN
materials["RADAR_BACKGROUND"]   			= RadarLegacy_BACKGROUND -- almost black

materials["COMMON_BLACK"]   				= {1, 1, 1, 255}

local CommonTexturesPath = LockOn_Options.script_path.."../../Common/Resources/IndicationTextures/"
local SightSysTexturesPath = LockOn_Options.script_path.."../../Mirage-F1/Mirage-F1_Common/Resources/IndicationTextures/SightSystem/"
local RadarLegacyTexturesPath = LockOn_Options.script_path.."../../Mirage-F1/Mirage-F1_Common/Resources/IndicationTextures/Cyrano_IV_legacy/"

--local sightSymbolsTexName					= "Indication_F1_SightSystem.tga"
local sightSymbolsTexName					= "Indication_F1_SightSystem.dds"
local radarLegacySymbolsTexName				= "Indication_F1_Radar_Cyrano_IV_legacy.tga"

-------TEXTURES-------
textures["SYMB_SIGHT_SYSTEM_WHITE"]			= {SightSysTexturesPath..sightSymbolsTexName, materials["SIGHT_SYSTEM_WHITE"]}
textures["SYMB_SIGHT_SYSTEM_RED"]			= {SightSysTexturesPath..sightSymbolsTexName, materials["SIGHT_SYSTEM_RED"]}
textures["SYMB_SIGHT_SYSTEM_GREEN"]			= {SightSysTexturesPath..sightSymbolsTexName, materials["SIGHT_SYSTEM_GREEN"]}
textures["SYMB_SIGHT_SYSTEM_BLUE"]		    = {SightSysTexturesPath..sightSymbolsTexName, materials["SIGHT_SYSTEM_BLUE"]}
textures["SYMB_SIGHT_SYSTEM_AMBER"]			= {SightSysTexturesPath..sightSymbolsTexName, materials["SIGHT_SYSTEM_AMBER"]}

textures["SYMB_LEGACY_RADAR_GREEN"]			= {RadarLegacyTexturesPath..radarLegacySymbolsTexName, materials["RADAR_LEGACY_GREEN"]}
textures["BUFF_LEGACY_RADAR_1"]				= {CommonTexturesPath.."buff_512.dds", materials["COMMON_BLACK"]}
textures["BUFF_LEGACY_RADAR_2"]				= {CommonTexturesPath.."buff_512.dds", materials["COMMON_BLACK"]}

--textures["SYMB_SIGHT_SYSTEM_TEMPLATE"]	= {SightSysTexturesPath.."Symbology_reference_template.tga", materials["SIGHT_SYSTEM_RED"]}

-------FONTS-------
fonts["FONT_SIGHT_SYSTEM_WHITE"]			= {fontdescription["FONT_SIGHT_SYSTEM"], 10, materials["SIGHT_SYSTEM_WHITE"]}
fonts["FONT_SIGHT_SYSTEM_RED"]				= {fontdescription["FONT_SIGHT_SYSTEM"], 10, materials["SIGHT_SYSTEM_RED"]}
fonts["FONT_SIGHT_SYSTEM_GREEN"]			= {fontdescription["FONT_SIGHT_SYSTEM"], 10, materials["SIGHT_SYSTEM_GREEN"]}
fonts["FONT_SIGHT_SYSTEM_BLUE"]				= {fontdescription["FONT_SIGHT_SYSTEM"], 10, materials["SIGHT_SYSTEM_BLUE"]}
fonts["FONT_SIGHT_SYSTEM_AMBER"]			= {fontdescription["FONT_SIGHT_SYSTEM"], 10, materials["SIGHT_SYSTEM_AMBER"]}

