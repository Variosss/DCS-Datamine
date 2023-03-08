dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/MPD_page_defs.lua")


------------------------------ Manual Program Creation ---------------------------
addStrokeText("EW_CMDS_PROG", 	"", STROKE_FNT_DFLT_120, "CenterCenter", {0, 0}, nil, {{"MPD_EW_PROG_parameters", 7}}, {"CMDS PROG %d"})
addStrokeLine("EW_Prog_line", 700, {350, -45},  90, nil)
addStrokeText("EW_Prog_chaff", 	"", STROKE_FNT_DFLT_120, "CenterCenter", {-298, -100}, nil, {{"MPD_EW_PROG_parameters", 1}}, {"CHAFF\n%d"})
addStrokeText("EW_Prog_flare", 	"", STROKE_FNT_DFLT_120, "CenterCenter", {-155, -100}, nil, {{"MPD_EW_PROG_parameters", 2}}, {"FLARE\n%d"})
addStrokeText("EW_Prog_oth1", 	"", STROKE_FNT_DFLT_120, "CenterCenter", { -22, -100}, nil, {{"MPD_EW_PROG_parameters", 3}}, {"OTH1\n%d"})
addStrokeText("EW_Prog_oth2", 	"", STROKE_FNT_DFLT_120, "CenterCenter", { 102, -100}, nil, {{"MPD_EW_PROG_parameters", 4}}, {"OTH2\n%d"})
addStrokeText("EW_Prog_rpt", 	"", STROKE_FNT_DFLT_120, "CenterCenter", { 215, -100}, nil, {{"MPD_EW_PROG_parameters", 5}}, {"RPT\n%d"})
addStrokeText("EW_Prog_int", 	"", STROKE_FNT_DFLT_120, "CenterCenter", { 318, -100}, nil, {{"MPD_EW_PROG_parameters", 6}}, {"INT\n%.2f"})


-------------------------------------- Menu --------------------------------------
add_PB_label(2, {"OTH2", 	nil, nil, {{"MPD_EW_PROG_Parameter_Box", 4}}})
add_PB_label(3, {"OTH1", 	nil, nil, {{"MPD_EW_PROG_Parameter_Box", 3}}})
add_PB_label(4, {"FLAR", 	nil, nil, {{"MPD_EW_PROG_Parameter_Box", 2}}})
add_PB_label(5, {"CHAF", 	nil, nil, {{"MPD_EW_PROG_Parameter_Box", 1}}})

add_PB_label(9, "RTN")

add_PB_symbol(12, "124-arrow-up")
add_PB_symbol(13, "124-arrow-down")

add_PB_label(14, {"RPT", 	nil, nil, {{"MPD_EW_PROG_Parameter_Box", 5}}})
add_PB_label(15, {"INT", 	nil, nil, {{"MPD_EW_PROG_Parameter_Box", 6}}})

add_PB_label(19, "SAVE")
