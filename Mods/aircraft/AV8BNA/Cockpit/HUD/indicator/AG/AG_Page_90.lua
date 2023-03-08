-------------------
-- AG NO WEAPONS --
-------------------
local hud_path = LockOn_Options.script_path.."HUD/indicator/"
dofile(hud_path.."AG/AG_Base.lua")

-- SYMBOLOGY
local	AG_NWPN_Symbol					= CreateElement "ceSMultiLine"
		AG_NWPN_Symbol.name				= "warning_cue"
		AG_NWPN_Symbol.material			= stroke_material
		AG_NWPN_Symbol.init_pos			= {0, 0, 0}
		AG_NWPN_Symbol.points_set		= {"HUD_stroke_symbols", "warning"}
		AG_NWPN_Symbol.scale			= HUD_SCALE
		AG_NWPN_Symbol.controllers 		= {{"sms_dmg_lvl_0"}}
AddHUDStrokeSymbol(AG_NWPN_Symbol)

