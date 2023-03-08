dofile(LockOn_Options.script_path.."fonts.lua")

-------MATERIALS-------
materials = {}   
materials["INDICATION_COMMON_WHITE"]     = {255, 255, 255, 255}   
materials["INDICATION_COMMON_GREY"]      = {245, 245, 245, 255}  
materials["INDICATION_COMMON_DARK_GREY"] = {100, 100, 100, 255}  
materials["INDICATION_COMMON_RED"]       = {255, 0, 0, 255}
materials["INDICATION_COMMON_GREEN"]     = {0, 255, 0, 255}
materials["INDICATION_COMMON_BLUE"]      = {0, 0, 255, 255}
materials["INDICATION_COMMON_BLACK"]     = {0, 0, 0, 255, 255}
materials["INDICATION_COMMON_AMBER"]     = {255,161,45,100}
materials["CMS_GREEN"]	 = {118, 249, 31, 255}
materials["MFCD_BLUE"]   = {100, 100, 255, 255}
materials["MFCD_GREEN"]  = {0, 255, 50, 255}
materials["MFCD_RED"]    = {255, 0, 0, 255}
materials["MFCD_WHITE"]  = {255, 255, 255, 255}
materials["MFCD_YELLOW"] = {255, 255, 0, 255}
materials["MFCD_VIOLET"] = {255, 0, 255, 255}
materials["DBG_GREY"]    = {25, 25, 25, 255}
materials["DBG_BLACK"]   = {0, 0, 0, 100}
materials["DBG_RED"]     = {255, 0, 0, 100}
materials["DBG_GREEN"]   = {0, 255, 0, 100}
materials["DIGIT_CLOCK"] = {120, 148, 148, 255}
materials["CDU_GREEN"]		 = {0, 255, 0, 255}
materials["TGP_STBY_GREY"] = {102, 102, 102, 255}
materials["TGP_STBY_DARK_GREY"] = {47, 47, 47, 255}
materials["HUD_IND_GREEN"]   = {0, 255, 0, 255}
materials["HUD_IND_YELLOW"]   = {243, 116, 13, 255}
materials["HUD_IND_DBG"]     = {255, 50, 0, 255}
materials["UHF_RADIO"] = {220, 220, 222, 255}
materials["UHF_RADIO_CHANNEL_MAP"] = {25, 25, 25, 255}
materials["UHF_REPEATER"]  = {227, 226, 221, 255}

materials["MFCD_CICU_BLACK"]  = {1, 1, 1, 255}
materials["MFCD_CICU_GREY"]    = {117, 117, 117, 255}
materials["MFCD_CICU_WHITE"]  = {10, 167, 244, 255}

materials["MFCD_TEST_DISP_RED_1"] = {255, 0, 0, 255}
materials["MFCD_TEST_DISP_RED_2"] = {223, 0, 0, 255}
materials["MFCD_TEST_DISP_RED_3"] = {191, 0, 0, 255}
materials["MFCD_TEST_DISP_RED_4"] = {159, 0, 0, 255}
materials["MFCD_TEST_DISP_RED_5"] = {108, 0, 0, 255}
materials["MFCD_TEST_DISP_RED_6"] = {76, 0, 0, 255}
materials["MFCD_TEST_DISP_RED_7"] = {32, 0, 0, 255}
materials["MFCD_TEST_DISP_RED_8"] = {0, 0, 0, 255}

materials["MFCD_TEST_DISP_GREEN_1"] = {0, 255, 0, 255}
materials["MFCD_TEST_DISP_GREEN_2"] = {0, 216, 0, 255}
materials["MFCD_TEST_DISP_GREEN_3"] = {0, 180, 0, 255}
materials["MFCD_TEST_DISP_GREEN_4"] = {0, 128, 0, 255}
materials["MFCD_TEST_DISP_GREEN_5"] = {0, 96, 0, 255}
materials["MFCD_TEST_DISP_GREEN_6"] = {0, 64, 0, 255}
materials["MFCD_TEST_DISP_GREEN_7"] = {0, 32, 0, 255}
materials["MFCD_TEST_DISP_GREEN_8"] = {0, 0, 0, 255}

materials["MFCD_TEST_DISP_BLUE_1"] = {0, 190, 255, 255}
materials["MFCD_TEST_DISP_BLUE_2"] = {0, 159, 221, 255}
materials["MFCD_TEST_DISP_BLUE_3"] = {0, 134, 198, 255}
materials["MFCD_TEST_DISP_BLUE_4"] = {0, 105, 160, 255}
materials["MFCD_TEST_DISP_BLUE_5"] = {0, 79, 124, 255}
materials["MFCD_TEST_DISP_BLUE_6"] = {0, 55, 85, 255}
materials["MFCD_TEST_DISP_BLUE_7"] = {0, 30, 47, 255}
materials["MFCD_TEST_DISP_BLUE_8"] = {0, 0, 0, 255}

materials["MFCD_TEST_DISP_GREY_1"] = {255, 255, 255, 255}
materials["MFCD_TEST_DISP_GREY_2"] = {223, 223, 223, 255}
materials["MFCD_TEST_DISP_GREY_3"] = {180, 180, 180, 255}
materials["MFCD_TEST_DISP_GREY_4"] = {144, 144, 144, 255}
materials["MFCD_TEST_DISP_GREY_5"] = {108, 108, 108, 255}
materials["MFCD_TEST_DISP_GREY_6"] = {64, 64, 64, 255}
materials["MFCD_TEST_DISP_GREY_7"] = {32, 32, 32, 255}
materials["MFCD_TEST_DISP_GREY_8"] = {0, 0, 0, 255}

materials["MFCD_CICU_INIT_LBLUE"] = {173, 216, 230, 255}

materials["MASK_MATERIAL"] = {255, 0, 255, 50}

materials["MFCD_GREY_MAV"]     	   = {254, 254, 254, 255}   

function make_left_right(tbl,item,src)

	local src = src or item
	tbl[item .. "_LEFT"]   = tbl[src]
	tbl[item .. "_RIGHT"]  = tbl[src]
end

make_left_right(materials,"MFCD_YELLOW")
make_left_right(materials,"MFCD_RED")
make_left_right(materials,"MFCD_GREEN")
make_left_right(materials,"MFCD_BLUE")
make_left_right(materials,"MFCD_VIOLET")
make_left_right(materials,"MFCD_WHITE")
make_left_right(materials,"MFCD_GREY"  ,"INDICATION_COMMON_GREY")
make_left_right(materials,"MFCD_GREY_2","INDICATION_COMMON_GREY")
make_left_right(materials,"MFCD_GREY_MAV")
make_left_right(materials,"MFCD_DARK_GREY","INDICATION_COMMON_DARK_GREY")


--DBG
--materials["MFCD_GREEN_LEFT"]			 = materials["MFCD_RED"]

local IndicationTexturesPath = LockOn_Options.script_path.."../IndicationTextures/"

-------TEXTURES-------
textures = {}

textures["INDICATION_MFCD_YELLOW"]			 = {IndicationTexturesPath.."Indication_MFCD.tga", materials["MFCD_YELLOW"]}
textures["INDICATION_MFCD_BLUE"]			 = {IndicationTexturesPath.."Indication_MFCD.tga", materials["MFCD_BLUE"]}
textures["INDICATION_MFCD_GREEN"]			 = {IndicationTexturesPath.."Indication_MFCD.tga", materials["MFCD_GREEN"]}
textures["INDICATION_MFCD_RED"]			     = {IndicationTexturesPath.."Indication_MFCD.tga", materials["MFCD_RED"]}
textures["INDICATION_MFCD_BLACK"]			 = {IndicationTexturesPath.."Indication_MFCD.tga", materials["INDICATION_COMMON_BLACK"]}
textures["INDICATION_MFCD_WHITE"]			 = {IndicationTexturesPath.."Indication_MFCD.tga", materials["MFCD_WHITE"]}
textures["INDICATION_MFCD_GREY"]			 = {IndicationTexturesPath.."Indication_MFCD.tga", materials["INDICATION_COMMON_GREY"]}
textures["INDICATION_MFCD_VIOLET"]			 = {IndicationTexturesPath.."Indication_MFCD.tga", materials["MFCD_VIOLET"]}
textures["INDICATION_DIGIT_CLOCK"]			 = {IndicationTexturesPath.."indication_DIGIT_CLK.tga", materials["DIGIT_CLOCK"]}
textures["INDICATION_HUD"]			 		 = {IndicationTexturesPath.."Indication_hud_A-10C.tga", materials["HUD_IND_GREEN"]}
textures["INDICATION_HUD_DBG"]			 	 = {IndicationTexturesPath.."Indication_hud_A-10C.tga", materials["DBG_RED"]}
textures["INDICATION_HUD_STANDBY"]			 = {IndicationTexturesPath.."Indication_hud_A-10C_standby.tga", materials["HUD_IND_YELLOW"]}
textures["INDICATION_LINES_HUD"]			 = {IndicationTexturesPath.."Lines_hud_A-10C.tga", materials["HUD_IND_GREEN"]}
textures["INDICATION_RWR"]			 		 = {"indication_RWR.tga", materials["INDICATION_COMMON_GREEN"]}
textures["AGM_65E_GRID"]			 		 = {"agm_65e_grid.tga", materials["MFCD_WHITE"]}
--DBG
textures["DBG_SYMB"]                         = {"line_texture.tga", materials["MFCD_RED"]}
textures["DBG_SSYMB"]                        = {"", materials["MFCD_VIOLET"]}

make_left_right(textures,"INDICATION_MFCD_YELLOW")
make_left_right(textures,"INDICATION_MFCD_BLUE")
make_left_right(textures,"INDICATION_MFCD_GREEN")
make_left_right(textures,"INDICATION_MFCD_RED")
make_left_right(textures,"INDICATION_MFCD_BLACK")
make_left_right(textures,"INDICATION_MFCD_WHITE")
make_left_right(textures,"INDICATION_MFCD_GREY")
make_left_right(textures,"INDICATION_MFCD_GREY_2","INDICATION_MFCD_GREY")
make_left_right(textures,"INDICATION_MFCD_VIOLET")

--DBG
--textures["INDICATION_MFCD_GREEN_LEFT"]			 = {IndicationTexturesPath.."Indication_MFCD.tga", materials["MFCD_RED"]}

-------------------------------------------------------
-------FONTS-------
fonts = {}
fonts["font_CMS"]					= {fontdescription["font_CMS"], 10, materials["CMS_GREEN"]}
fonts["font_CMSP"]					= fonts["font_CMS"]
fonts["font_MFCD"]					= {fontdescription["font_MFCD"], 10, materials["MFCD_GREEN"]}
fonts["font_MFCD_BLACK"]			= {fontdescription["font_MFCD"], 10, materials["INDICATION_COMMON_BLACK"]}
fonts["font_MFCD_BLUE"]				= {fontdescription["font_MFCD"], 10, materials["MFCD_BLUE"]}
fonts["font_MFCD_RED"]				= {fontdescription["font_MFCD"], 10, materials["MFCD_RED"]}
fonts["font_MFCD_GREY"]				= {fontdescription["font_MFCD"], 10, materials["INDICATION_COMMON_GREY"]}
fonts["font_MFCD_WHITE"]			= {fontdescription["font_MFCD"], 10, materials["MFCD_WHITE"]}
fonts["font_MFCD_YELLOW"]			= {fontdescription["font_MFCD"], 10, materials["MFCD_YELLOW"]}
fonts["font_DIGIT_CLK"]				= {fontdescription["font_DIGIT_CLK"], 10, materials["DIGIT_CLOCK"]}
fonts["font_CDU"]					= {fontdescription["font_CDU"], 10, materials["CDU_GREEN"]}
fonts["font_TGP"]					= {fontdescription["font_TGP"], 10, materials["INDICATION_COMMON_GREY"]}
fonts["font_RWR"]					= {fontdescription["font_RWR"], 10, materials["INDICATION_COMMON_GREEN"]}
fonts["font_HUD"]					= {fontdescription["font_HUD"], 10, materials["HUD_IND_GREEN"]}
fonts["font_HUD_STANDBY"]			= {fontdescription["font_HUD_STANDBY"], 10, materials["HUD_IND_YELLOW"]}
fonts["font_HUD_DBG"]				= {fontdescription["font_HUD"], 10, materials["HUD_IND_DBG"]}
fonts["font_AGM_65E"]               = {fontdescription["font_AGM_65E"], 1, materials["INDICATION_COMMON_GREY"]}
fonts["font_UHF_RADIO"]				= {fontdescription["font_UHF_RADIO"], 10, materials["UHF_RADIO"]}
fonts["font_UHF_RADIO_CH_MAP"]		= {fontdescription["font_UHF_RADIO"], 10, materials["UHF_RADIO_CHANNEL_MAP"]}
fonts["font_UHF_Repeater"]			= {fontdescription["font_UHF_Repeater"], 10, materials["UHF_REPEATER"]}

make_left_right(fonts,"font_MFCD")
make_left_right(fonts,"font_MFCD_BLACK")
make_left_right(fonts,"font_MFCD_BLUE")
make_left_right(fonts,"font_MFCD_RED")
make_left_right(fonts,"font_MFCD_GREY")
make_left_right(fonts,"font_MFCD_WHITE")
make_left_right(fonts,"font_MFCD_YELLOW")
make_left_right(fonts,"font_TGP")


--DBG
--fonts["font_MFCD_LEFT"]			 = {fontdescription["font_MFCD"], 10, materials["MFCD_RED"]}

-- force preload resources to avoid freeze on start
preload_texture = 
{
	"Fonts/font_ALQ_213.tga",
	IndicationTexturesPath.."font_MFCD_A10C.tga",
	IndicationTexturesPath.."Indication_MFCD.tga",
	IndicationTexturesPath.."font_DigitClock.tga",
	IndicationTexturesPath.."indication_DIGIT_CLK.tga",
	IndicationTexturesPath.."font_A-10_CDU.tga",
	IndicationTexturesPath.."Indication_hud_A-10C.tga",
	"Fonts/font_TGP_LITENING_AT.tga",
	"Fonts/font_RWR.tga",
	"indication_RWR.tga",
	IndicationTexturesPath.."font_HUD_A10.tga",
	"Fonts/font_ARC_164_LCD.tga",
	"Fonts/font_ARC_164_repeater_LCD.tga",
	"triggers.tga"
}
