dofile(LockOn_Options.script_path.."Displays/MFD/indicator/MFD_Symbology.lua")
dofile(LockOn_Options.script_path.."Displays/MFD/indicator/Pages/FCR/MFD_FCR_Defs.lua")

local FCR_contact = addPlaceholder("FCR_contact", nil, nil, {{"MFD_FCR_RawRadarContactPos", tactical_display_sz_half}})
local FCR_RWS_contact = addPlaceholder("FCR_RWS_contact", nil, FCR_contact.name, {{"MFD_FCR_RawRadarContactRot"}, {"MFD_FCR_RawRadarContactJamming", 0}})
addFillBox(FCR_RWS_contact.name.."_Box", 10, 10, "CenterCenter", nil, FCR_RWS_contact.name, nil, {{"MFD_FCR_RawRadarContactIntensity"}})
addStrokeLine(FCR_RWS_contact.name.."_Pointer", 10, {0, 6}, 0, FCR_RWS_contact.name, {{"MFD_FCR_RawRadarContactIntensity"}})

local FCR_ContactJammingPH = addPlaceholder("FCR_ContactJammingPH", nil, FCR_contact.name, {{"MFD_FCR_RawRadarContactJamming", 1}})
addStrokeLine("FCR_jammingLine1", 15, {0,  5},  120, FCR_ContactJammingPH.name, {{"MFD_SetColor_Yellow"}})
addStrokeLine("FCR_jammingLine2", 15, {0,  5}, -120, FCR_ContactJammingPH.name, {{"MFD_SetColor_Yellow"}})
addStrokeLine("FCR_jammingLine3", 15, {0, -5},  120, FCR_ContactJammingPH.name, {{"MFD_SetColor_Yellow"}})
addStrokeLine("FCR_jammingLine4", 15, {0, -5}, -120, FCR_ContactJammingPH.name, {{"MFD_SetColor_Yellow"}})
