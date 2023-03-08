dofile(LockOn_Options.script_path.."Displays/MFD/indicator/MFD_Symbology.lua")

addStrokeText("FLCS_BIT_Status_Lvl1", "______", STROKE_FNT_DFLT_10_14, "CenterCenter", {0, 170}, nil, {{"FLCS_BIT_Status", 0, 0}})

--Static FLCS Page

addStrokeText("FLCS_Content_Label", "CONTENT", STROKE_FNT_DFLT_10_14, "CenterCenter", {0, 70})
addStrokeText("FLCS_Content_Str1", "______", STROKE_FNT_DFLT_10_14, "CenterCenter", {0, 30} )
addStrokeText("FLCS_Content_Str2", "______", STROKE_FNT_DFLT_10_14, "CenterCenter", {0, -20} )
addStrokeText("FLCS_Content_Str3", "______", STROKE_FNT_DFLT_10_14, "CenterCenter", {0, -70} )
addStrokeText("FLCS_Content_Str4", "______", STROKE_FNT_DFLT_10_14, "CenterCenter", {0, -120})

add_Simple_PB_label(7, "LOC\n0000")
add_Simple_PB_label(9, "HEX")