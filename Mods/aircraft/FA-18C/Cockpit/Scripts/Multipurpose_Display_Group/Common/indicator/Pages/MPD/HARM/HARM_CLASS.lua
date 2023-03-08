dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/MPD_page_defs.lua")
dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/HARM/HARM_Utils.lua")

addStrokeText("MPD_HARM_class_Label", "CLASS ", STROKE_FNT_DFLT_150, "RightCenter", {50, 400})
addStrokeText("MPD_HARM_class", "", STROKE_FNT_DFLT_150, "LeftCenter", {50, 400}, nil, {{"MPD_HARM_Class"}}, HARM_Classes)

-------------------------------------- Menu --------------------------------------
add_PB_label(1, "ALL")
add_PB_label(2, "FRD")
add_PB_label(3, "HOS")
add_PB_label(4, "FN")
add_PB_label(5, "HN")

add_PB_label(6, "F1")
add_PB_label(7, "F2")
add_PB_label(8, "H1")
add_PB_label(9, "H2")
add_PB_label(10, "FAA")

add_PB_label(11, "HAA")
add_PB_label(12, "FS")
add_PB_label(13, "HS")
add_PB_label(14, "UKN")
add_PB_label(15, "PRI")

add_Harm_Ovrd_PB16()
