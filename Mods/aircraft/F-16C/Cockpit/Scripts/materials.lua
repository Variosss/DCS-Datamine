--dofile(LockOn_Options.common_script_path.."Fonts/symbols_locale.lua")
--dofile(LockOn_Options.common_script_path.."Fonts/fonts_cmn.lua")

-- variables used in stroke font description as well as in MDG stroke symbology
dbg_drawStrokesAsWire = false

dofile(LockOn_Options.script_path.."fonts.lua")

-------MATERIALS-------
-- Only green colors are described here. Red and yellow will be set via dedicated controllers

materials = {}

materials["INDICATION_COMMON_RED"]		= {255, 0, 0, 255}
materials["INDICATION_COMMON_WHITE"]	= {255, 255, 255, 255}
materials["INDICATION_COMMON_GREEN"]	= {0, 255, 0, 255}
materials["INDICATION_COMMON_LBLUE"]	= {0, 200, 255, 255}
materials["INDICATION_COMMON_AMBER"]	= {255,161,45,255}
materials["MASK_MATERIAL"]				= {255, 0, 255, 50}

materials["DBG_RED"]					= {255, 0, 0, 100}
materials["DBG_GREEN"]					= {0, 255, 0, 100}

materials["HUD"]						= {2, 255, 20, 385}
materials["FONT_DED"]					= {121, 255, 19, 255}	-- {251, 220, 0, 255}
materials["FONT_PFLD"]					= {121, 255, 19, 255}	-- {251, 220, 0, 255}
materials["MASK_MATERIAL_PURPLE"]		= {255, 0, 255, 30}

materials["MFD_BACKGROUND"]				= {0, 0, 0, 255}
materials["MFD_FONT_BKGND_WHITE"]		= {255, 255, 255, 255}

materials["LMFD_MATERIAL"]				= {255, 255, 255, 255}			-- Default color for all MFDs
materials["RMFD_MATERIAL"]				= materials["LMFD_MATERIAL"]	-- Default color for all MFDs
materials["MFD_BLACK"]					= {0, 0, 0, 255}

materials["TGP_STBY_BLACK"]				= {0, 0, 0, 255}
materials["TGP_STBY_DGRAY"]				= {5, 5, 5, 255}

local HUD_mat = materials["HUD"]
materials["HUD_GREEN_FOV"]				= {HUD_mat[0], HUD_mat[1], HUD_mat[2], 100} -- used for FOV lens render

materials["UHF_RADIO"]					= {179, 198, 85, 255}
materials["UHF_RADIO_CHANNEL_MAP"]		= {0, 0, 0, 250}

materials["EHSI_BACKGROUND"]			= {0, 0, 0, 255}
materials["EHSI_BLACK"]					= {0, 0, 0, 255}
materials["EHSI_WHITE"]					= {255, 255, 255, 255}
materials["EHSI_GRAY"]					= {200, 200, 200, 255}
materials["EHSI_RED"]					= {255,   0,   0, 255}
materials["EHSI_BLUE"]					= { 23, 140, 255, 255}
materials["EHSI_YELLOW"]				= {255, 255, 100, 255}
materials["EHSI_GOLD"]					= {255, 250, 173, 255}
materials["RWR_STROKE"]					= {0, 255, 0, 230}
materials["CMDS_GREEN"]					= {0, 255, 0, 255}
-- HMD
materials["HMD_SYMBOLOGY_MATERIAL"]		= {2, 255, 20, 255}


-------TEXTURES-------
textures = {}

local ResourcesPath = LockOn_Options.script_path.."../IndicationResources/"

textures["ARCADE"]							= {"arcade.tga",	materials["INDICATION_COMMON_RED"]}			-- Control Indicator
textures["ARCADE_WHITE"]					= {"arcade.tga",	materials["INDICATION_COMMON_WHITE"]}		-- Control Indicator

textures["INDICATION_RWR"]					= {ResourcesPath.."RWR/indication_RWR.tga", materials["INDICATION_COMMON_GREEN"]}
textures["INDICATION_RWR_LINE"]				= {"arcade.tga",							materials["INDICATION_COMMON_GREEN"]}
textures["INDICATION_TGP"]					= {ResourcesPath.."Displays/tgp_texture.tga",	materials["INDICATION_COMMON_WHITE"]}
textures["INDICATION_TGP_RED"]				= {ResourcesPath.."Displays/tgp_texture.tga",	materials["INDICATION_COMMON_RED"]}

textures["DED_BIG_OFF"]						= {ResourcesPath.."Displays/ded_font_big.dds",	materials["FONT_DED"]}

-------FONTS----------

fonts = {}

fonts["font_stroke_HUD"]			= {fontdescription["font_stroke_HUD"], 10, materials["HUD"]}

fonts["font_DED"]					= {fontdescription["font_DED"], 10, materials["FONT_DED"]}
fonts["font_DED_inv"]				= {fontdescription["font_DED_inv"], 10, materials["FONT_DED"]}

fonts["font_PFLD"]					= {fontdescription["font_PFLD"], 10, materials["FONT_PFLD"]}
fonts["font_PFLD_inv"]				= {fontdescription["font_PFLD_inv"], 10, materials["FONT_PFLD"]}

fonts["font_stroke_LMFD"]			= {fontdescription["font_stroke_MFD"], 10, materials["LMFD_MATERIAL"]}
fonts["font_stroke_RMFD"]			= {fontdescription["font_stroke_MFD"], 10, materials["RMFD_MATERIAL"]}
fonts["font_stroke_MFD_Black"]		= {fontdescription["font_stroke_MFD_Wide"], 10, materials["MFD_BLACK"]}
fonts["font_stroke_MFD_BlackBold"]	= {fontdescription["font_stroke_MFD_Bold"], 10, materials["MFD_BLACK"]}
fonts["font_TGP"]					= {fontdescription["font_TGP"], 10, materials["INDICATION_COMMON_WHITE"]}

fonts["font_UHF_RADIO"]				= {fontdescription["font_UHF_RADIO"], 10, materials["UHF_RADIO"]}
fonts["font_UHF_RADIO_CH_MAP"]		= {fontdescription["font_UHF_RADIO"], 10, materials["UHF_RADIO_CHANNEL_MAP"]}

fonts["font_stroke_EHSI"]			= {fontdescription["font_stroke_EHSI"], 10, materials["EHSI_WHITE"]}
fonts["font_stroke_EHSI_BLACK"]		= {fontdescription["font_stroke_EHSI"], 10, materials["EHSI_BLACK"]}

--fonts["font_RWR"]					= {fontdescription["font_stroke_RWR"], 10, materials["RWR_STROKE"]}
fonts["font_RWR"]					= {fontdescription["font_RWR"], 10, materials["RWR_STROKE"]}
fonts["font_CMDS"]					= {fontdescription["font_CMDS"], 10, materials["CMDS_GREEN"]}

-- HMD
fonts["font_HMD"]					= {fontdescription["font_stroke_HMD"], 10, materials["HMD_SYMBOLOGY_MATERIAL"]}

-- path for stroke symbology
symbologyPaths = {	LockOn_Options.script_path.."../IndicationResources/Displays",
					LockOn_Options.script_path.."../IndicationResources/RWR",
					LockOn_Options.script_path.."../IndicationResources/CMDS",
					LockOn_Options.script_path.."../IndicationResources/HMD",
					"Fonts/font_TGP_LITENING_AT.tga",
}
