local my_path = LockOn_Options.script_path.."SimpleHUD/Lua/"
dofile(my_path.."HUD_definitions.lua")

txt_static					= CreateElement "ceStringPoly"
txt_static.name				= "txt_static"
txt_static.material			= indication_font
txt_static.init_pos			= {0.0, 0.0, 0.0}
txt_static.alignment		= "LeftTop"
txt_static.stringdefs		= font_size_default
txt_static.value			= "STATIC TEXT\nMULTIPLE LINES"
AddHUDElement(txt_static)
