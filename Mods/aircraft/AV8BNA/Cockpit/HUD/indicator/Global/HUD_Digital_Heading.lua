-- DIGITAL HEading Mode
-- For AA and AG HUD

local	AC_Heading					= CreateElement "ceStringSLine"
		AC_Heading.name				= "Digital_Heading"
		AC_Heading.material			= stroke_font
		AC_Heading.init_pos			= {0, 24.0 * MilToDI(HUD_SCALE), 0}
		AC_Heading.formats			= {"%03d"}
		AC_Heading.stringdefs		= stringdefs[STROKE_FNT_DFLT_150]
		AC_Heading.alignment		= "CenterCenter"
		AC_Heading.parent_element	= HUD_center.name
		AC_Heading.controllers		= {{"hdg_dmg_lvl_0"}, {"ac_hdg_aux"}}
AddHUDElement(AC_Heading)

local	AC_Heading					= CreateElement "ceStringSLine"
		AC_Heading.name				= "Digital_Heading_Mode"
		AC_Heading.material			= stroke_font
		AC_Heading.init_pos			= {30.0 * MilToDI(HUD_SCALE), 38.0 * MilToDI(HUD_SCALE), 0}
		AC_Heading.value			= "T"
		AC_Heading.stringdefs		= stringdefs[STROKE_FNT_DFLT_100]
		AC_Heading.alignment		= "CenterCenter"
		AC_Heading.parent_element	= HUD_center.name
		AC_Heading.controllers		= {{"hdg_dmg_lvl_0"}, {"ac_hdg_mode"}}
AddHUDElement(AC_Heading)
