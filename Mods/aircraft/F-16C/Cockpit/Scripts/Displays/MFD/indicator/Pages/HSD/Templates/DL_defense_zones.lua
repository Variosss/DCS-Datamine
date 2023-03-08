dofile(LockOn_Options.script_path.."Displays/MFD/indicator/MFD_Symbology.lua")

-- main placeholder
local HSD_defense_zones_PH = addPlaceholder("HSD_defense_zones", nil, nil, {{"MFD_HSD_DL_DefenseZone_Pos"}})

addStrokeCircle("HSD_AirDefense_Circle", 150, nil, HSD_defense_zones_PH.name, {{"MFD_HSD_DL_DefenseZone_Radius"}})
addStrokeText("HSD_AirDefense_Code", "U", STROKE_FNT_DFLT_6_9, "CenterCenter", nil, HSD_defense_zones_PH.name, {{"MFD_HSD_DL_DefenseZone_Code"}})

addStrokeLine("HSD_AirDefense_isDL", 18, {6, 7}, 135, HSD_defense_zones_PH.name, {{"MFD_HSD_AirDefense_isDL"}}, false)
