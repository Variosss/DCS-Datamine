dofile(LockOn_Options.script_path.."Displays/MFD/indicator/MFD_Symbology.lua")
dofile(LockOn_Options.script_path.."Displays/MFD/indicator/Pages/FCR/MFD_FCR_Defs.lua")

-- IFF
addPlaceholder("IFF_ContactsKeeper", nil, nil, {{"MFD_updateMultipleSymbolsBuffer", DYNAMIC_DATA.IFF_CONTACTS}})

local IFF_Show = addPlaceholder("MFD_IFF_Show", nil, nil, {{"MFD_IFF_Show"}})

local IFF_Mode = addStrokeText("IFF_Mode", "", STROKE_FNT_DFLT_10_14, "LeftCenter", {-235, -145}, IFF_Show.name, {{"MFD_IFF_Modes"}}, {"OFF", "M1", "M2", "M3", "M4", "M+"})
addSizeClipMask(IFF_Mode, 2, 20, {{"FCR_ModeMenu", FCR_MODE_MENU_STATE.MAIN}}, {-4, 0})

-- Select label
local posY = -165
addStrokeText("IFF_IntgFunc", "", STROKE_FNT_DFLT_8_12, "LeftCenter", {-235, posY}, IFF_Show.name, {{"MFD_IFF_IntgFunc"}}, {"", "SCAN", "LOS"})
