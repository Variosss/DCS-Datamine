dofile(LockOn_Options.script_path.."fonts.lua")

-------MATERIALS-------
materials = {}
materials["HUD_GREEN"] = {36,221,36,255}
materials["HUD_GREEN_GLOW_C"] = {36,221,36,15} -- tune alpha to adjust collimated glow brightness
materials["HUD_GREEN_GLOW_NC"] = {36,221,36,2} -- tune alpha to adjust non-collimated glow brightness
--materials["TID_COLOR"] = {28,255,15,220}
materials["TID_COLOR"] = {4,71,7,255}
materials["TID_ASE_COLOR"] = {38,152,51,255}
materials["TID_NAVGRID_COLOR"] = {25,114,32,255}
--materials["LANTIRN_COLOR_TID"] = {30,255,25,200 }
materials["LANTIRN_COLOR_TID"] = {26,176,31,220}
materials["LANTIRN_COLOR_VDI"] = {26,176,31,220}
materials["VDI_WHITE"] = {28,255,36,220}
materials["VDI_BLACK"] = {1,1,1,255}
materials["VDI_VDARKGREEN"] = {1,10,1,255}
materials["VDI_ROLL_IDX"] = {5,0,0,250}
materials["TCS_WHITE_VDI"] = {30,255,30,200}
--materials["TCS_WHITE_TID"] = {141,202,133,200}
materials["TCS_WHITE_TID"] = {16,156,18,200}
materials["LIGHT_GREEN_MAT"] = {22,123,27,230}
materials["DARK_GREEN_MAT"] = {10,59,14,120}
materials["DBG_GREEN"] = {0,255,0,255}
materials["DBG_RED"] = {255,0,0,255}
materials["DBG_BLUE"] = {0,0,255,255}
materials["DBG_TRANSPARENT"] = {0,255,255,128}
materials["BLACK"] = {0,0,0,255}
materials["BLUE"] = {0,0,255,255}
materials["RED"] = {255,0,0,255}
materials["WHITE"] = {255,255,255,255}
materials["GREY"] = {71,71,71, 255}
materials["RWR_GREEN"] = {30,255,40,160}
materials["LIGHT_GREY"] =  {221,221,221,255}
materials["JESTER_GREY"] =  {166,166,166,255}
materials["JESTER_VECTOR"] =  {166,166,166,160}
materials["VDI_CRT"] =  {221,221,221,255}
materials["VDI_CRT2"] =  {0,0,0,255}
materials["VDI_CRT2_LANTIRN"] =  {0,0,0,32}
materials["VDI_CRT3"] =  {0,0,0,255}
materials["VDI_BORKED"] =  {51,255,88,90}
materials["VDI_NOISE"] =  {18,123,39,130}
materials["RADIO_FREQ_CHART"] = {3,2,24,230}
materials["VDI_RED_FILTER"] = {265,0,0,255}
materials["DDD_RED_FILTER"] = {512,0,0,255}
materials["DDD_GREEN_FILTER"] = {32,64,32,255}
materials["WHITE_EXPORT"] = {255,255,255,255}

local IndicationTexturesPath = LockOn_Options.script_path.."Resources/IndicationTextures/"

-------TEXTURES-------
textures = {}
textures["HUD_MAT"] = {IndicationTexturesPath.."HUD_Elements.tga",materials["HUD_GREEN"]}
textures["HUD_GLOW_C"] = {IndicationTexturesPath.."HUD_Glow_c.dds",materials["HUD_GREEN_GLOW_C"]}
textures["HUD_GLOW_NC"] = {IndicationTexturesPath.."HUD_Glow_nc.dds",materials["HUD_GREEN_GLOW_NC"]}
textures["TID_MAT"] = {IndicationTexturesPath.."tid.dds",materials["TID_COLOR"]}
textures["TID_MAT2"] = {IndicationTexturesPath.."tid2.dds",materials["TID_COLOR"]}
textures["VDI_WHITE_MAT"] = {IndicationTexturesPath.."VDI_Elements.tga",materials["VDI_WHITE"]}
textures["VDI_BLACK_MAT"] = {IndicationTexturesPath.."VDI_Elements.tga",materials["VDI_BLACK"]}
textures["VDI_VDARKGREEN_MAT"] = {IndicationTexturesPath.."VDI_Elements.tga",materials["VDI_VDARKGREEN"]}
textures["VDI_ROLL_IDX_MAT"] = {IndicationTexturesPath.."VDI_Elements.tga",materials["VDI_ROLL_IDX"]}
textures["TCS_WHITE_MAT_VDI"] = {IndicationTexturesPath.."VDI_Elements.tga",materials["TCS_WHITE_VDI"]}
textures["TCS_WHITE_MAT_TID"] = {IndicationTexturesPath.."VDI_Elements.tga",materials["TCS_WHITE_TID"]}
textures["DDD_OVERLAY"] = {IndicationTexturesPath.."DDD_overlay.dds",materials["BLACK"]}
textures["DDD_OVERLAY2"] = {IndicationTexturesPath.."DDD_overlay2.dds",materials["BLACK"]}
textures["LANTIRN_MAT_TID"] = {IndicationTexturesPath.."LANTIRN_Elements.dds",materials["LANTIRN_COLOR_TID"]}
textures["LANTIRN_MAT_VDI"] = {IndicationTexturesPath.."LANTIRN_Elements.dds",materials["LANTIRN_COLOR_VDI"]}
textures["RWR_MAT"] = {IndicationTexturesPath.."rwr_font.dds",materials["RWR_GREEN"]}
textures["VDI_CRT_TEX_MAT"] = {IndicationTexturesPath.."crtoverlay.dds",materials["VDI_CRT"]} --The "pixels"
textures["VDI_CRT_TEX_MAT2"] = {IndicationTexturesPath.."crtvignette.dds",materials["VDI_CRT2"]} --The vignette
textures["VDI_CRT_TEX_MAT2_LANTIRN"] = {IndicationTexturesPath.."crtvignette.dds",materials["VDI_CRT2_LANTIRN"]} --The vignette for LANTIRN
textures["VDI_CRT_TEX_MAT3"] = {IndicationTexturesPath.."CRT_Mask.dds",materials["VDI_CRT3"]} --Mask
textures["VDI_CRT_TEX_BORKED"] = {IndicationTexturesPath.."HB_VDI_Broken.dds",materials["VDI_BORKED"]} --Mask
textures["VDI_CRT_TEX_NOISE"] = {IndicationTexturesPath.."HB_VDI_Noise.dds",materials["VDI_NOISE"]} --Mask
textures["TCS_WHITE_MAT_EXPORT"] = {IndicationTexturesPath.."VDI_Elements.tga",materials["WHITE_EXPORT"]}
textures["LANTIRN_MAT_EXPORT"] = {IndicationTexturesPath.."LANTIRN_Elements.dds",materials["WHITE_EXPORT"]}

-------------------------------------------------------
-------FONTS-------
fontdescription["font_general_loc"] = fontdescription_cmn["font_general_loc"]

fonts = {}
fonts["font_CMS"] = {fontdescription["font_CMS"], 10, materials["HUD_GREEN"]}
fonts["font_general"] = {fontdescription["font_general"], 10, materials["BLACK"]}
fonts["font_general_grey"] = {fontdescription["font_general"], 10, materials["GREY"]}
fonts["font_general_blue"] = {fontdescription["font_general"], 10, materials["BLUE"]}
fonts["font_general_red"] = {fontdescription["font_general"], 10, materials["RED"]}

fonts["font_TID"] = {fontdescription["font_TID"], 10, materials["TID_COLOR"]}

fonts["font_LANTIRN_TID"] = {fontdescription["font_LANTIRN"], 8, materials["LANTIRN_COLOR_TID"]}
fonts["font_LANTIRN_VDI"] = {fontdescription["font_LANTIRN"], 8, materials["LANTIRN_COLOR_VDI"]}

fonts["font_VDI"] = {fontdescription["font_TID"], 10, materials["VDI_WHITE"]}


fonts["font_ROSE"] = {fontdescription["font_ROSE"], 10, materials["WHITE"]}
fonts["font_RWR"] = {fontdescription["font_RWR"], 10, materials["RWR_GREEN"]}
fonts["font_JesterUI_Light_Grey"] = {fontdescription["font_JesterUI"], 10, materials["LIGHT_GREY"]}
fonts["font_JesterUI_Grey"] = {fontdescription["font_JesterUI"], 10, materials["JESTER_GREY"]}
fonts["font_kneeboard"] = {fontdescription["font_kneeboard"], 10, materials["BLACK"]}
fonts["font_radio_freq_chart"] = {fontdescription["font_Handwriting"], 10, materials["RADIO_FREQ_CHART"]}
fonts["font_LANTIRN_EXPORT"] = {fontdescription["font_LANTIRN"], 8, materials["WHITE_EXPORT"]}

multiTexFonts = {}
multiTexFonts["font_general_loc"] = {fontdescription["font_general_loc"], 10, materials["HUD_GREEN"]}

-- force preload resources to avoid freeze on start
preload_texture =
{
	IndicationTexturesPath.."HUD_Elements.tga",
	IndicationTexturesPath.."tid.dds",
	IndicationTexturesPath.."tid2.dds",
	IndicationTexturesPath.."VDI_Elements.tga",
    IndicationTexturesPath.."DDD_overlay.dds",
    IndicationTexturesPath.."DDD_overlay2.dds",
    IndicationTexturesPath.."lantirn_seizure.dds",
    IndicationTexturesPath.."lantirn_font.dds",
    IndicationTexturesPath.."kneepad.dds",
    IndicationTexturesPath.."kneepad_load.dds",
	
	IndicationTexturesPath.."JUI_Base_Circle.dds",
	IndicationTexturesPath.."JUI_Outer_Triangle.dds",
	IndicationTexturesPath.."JUI_Inner_Triangle.dds",
	IndicationTexturesPath.."JUI_CompassRing.dds",
	IndicationTexturesPath.."JUI_Categories.dds",
	IndicationTexturesPath.."JUI_Highlight.dds",
	IndicationTexturesPath.."JUI_GreyOut.dds",
}
