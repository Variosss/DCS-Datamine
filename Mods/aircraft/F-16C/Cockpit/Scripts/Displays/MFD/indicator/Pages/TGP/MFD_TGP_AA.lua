dofile(LockOn_Options.script_path.."Displays/MFD/indicator/MFD_Symbology.lua")
dofile(LockOn_Options.script_path.."Displays/MFD/indicator/Pages/TGP/MFD_TGP_tools.lua")

-- On/Off placeholder
local flirRoot = addPlaceholder("TGP_Root", {0,0})
local operPlaceholder = addPlaceholder("TGP_OnOff", {0,0}, nil, {{"TGP_OperPlaceholder", 1}})
local videoOnPlaceholder = addPlaceholder("TGP_VideoOn", {0,0}, operPlaceholder.name, {{"TGP_VideoOn"}})
--
local TGP_NoModeMenu = addPlaceholder("TGP_NoModeMenu_Root", {0, 0}, operPlaceholder.name, {{"TGP_ModeMenu", 0}})
