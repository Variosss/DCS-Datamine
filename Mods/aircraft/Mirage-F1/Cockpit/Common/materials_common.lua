dofile(LockOn_Options.script_path.."../../Common/fonts_common.lua")

-------MATERIALS-------
materials = {}
materials["DBG_RED"]     					= {255, 0, 0, 50}
materials["DBG_GREEN"]     					= {0, 255, 0, 50}
materials["DBG_BLUE"]     					= {0, 0, 255, 50}
materials["DBG_BLACK"]     					= {0, 0, 0, 255}
materials["MASK_MATERIAL"] 		   			= {255, 0, 255, 50}

materials["ALR_300_GREEN"]     				= {8, 252, 2, 255}
materials["ALR_300_BACKGROUND"]   			= {1, 1, 1, 255} -- almost black

-------TEXTURES-------
textures = {}
textures["SYMB_ALR_300_GREEN"]				= {LockOn_Options.script_path.."../../Common/Resources/IndicationTextures/ALR_300/Indication_F1_ALR_300.dds", materials["ALR_300_GREEN"]}

-------FONTS-------
fonts = {}
fonts["FONT_ALR_300_GREEN"]				= {fontdescription["FONT_ALR_300"], 10, materials["ALR_300_GREEN"]}