dofile(LockOn_Options.script_path.."Displays/MFD/indicator/MFD_Symbology.lua")

-- main placeholder
local HAD_contact = addPlaceholder("HAD_contact", nil, nil, {{"HAD_DefenseZone_Pos"}})

addFillBox("HarmBoxWhite", 34, 24, "CenterCenter", nil, HAD_contact.name, {{"HAD_DefenseZone_Code_BoxedWhite"}})
addFillBox("HarmBoxRed", 30, 20, "CenterCenter", nil, HAD_contact.name, {{"HAD_DefenseZone_Code_BoxedRed"}}, nil, nil, "INDICATION_COMMON_RED")

addStrokeText("HAD_AirDefense_Code", "U", STROKE_FNT_DFLT_8_12, "CenterCenter", nil, HAD_contact.name, {{"HAD_DefenseZone_Code"}})
addBlackText("HAD_AirDefense_CodeBlack", "U", STROKE_FNT_DFLT_8_12, "CenterCenter", nil, HAD_contact.name, {{"HAD_DefenseZone_CodeBlack"}})

addStrokeLine("HAD_AirDefense_isDL", 18, {6, 7}, 135, HAD_contact.name, {{"MFD_HAD_AirDefense_isDL"}}, false)