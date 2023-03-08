dofile(LockOn_Options.script_path.."Displays/MFD/indicator/MFD_Symbology.lua")
dofile(LockOn_Options.script_path.."Displays/MFD/indicator/Pages/FCR/MFD_FCR_Defs.lua")

local FCR_AG_contact = addPlaceholder("FCR_AG_contact", nil, nil, {{"FCR_AG_ContactPos"}})
addFillBox(FCR_AG_contact.name.."_Box", 10, 10, "CenterCenter", nil, FCR_AG_contact.name, nil, {{"FCR_AG_ContactIntensity"}})
