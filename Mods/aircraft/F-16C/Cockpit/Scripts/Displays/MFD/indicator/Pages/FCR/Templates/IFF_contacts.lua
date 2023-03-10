dofile(LockOn_Options.script_path.."Displays/MFD/indicator/MFD_Symbology.lua")
dofile(LockOn_Options.script_path.."Displays/MFD/indicator/Pages/FCR/MFD_FCR_Defs.lua")

local DBG_IFF_tgtPlaceholder = addPlaceholder("IFF_contact", nil, nil, {{"MFD_FCR_RawIffContactPos", tactical_display_sz_half}})

local size_l = 16
local frnd = addStrokeCircle("IFF_Friendly_contact_symbol", 10, {20, -10}, DBG_IFF_tgtPlaceholder.name, {{"MFD_IFF_CheckHafu", HAFU.FRIENDLY}, {"MFD_SetColor_IFF", HAFU.FRIENDLY}})
addStrokeText("IFF_Friendly_contact_mode", "", STROKE_FNT_DFLT_10_14, "CenterCenter", {0, 0}, frnd.name, {{"MFD_IFF_ResponseMode"}, {"MFD_SetColor_IFF", HAFU.FRIENDLY}})
