dofile(LockOn_Options.script_path.."CDU/indicator/CDU_definitions.lua")

AddStaticText("PageNameOPTIONS",  2, 1, LFT, "OPTIONS")

AddStaticText("OPTIONS_RTRY",      1, 3, LFT, ROTARY)
AddStaticText("OPTIONS_DE",        1, 5, LFT, DATA_ENTRY)

AddText      ("OPTIONS_HF0",        2, 3, LFT, {{"HeadingFormat", 0}}, "MAG")
AddText      ("OPTIONS_HF1",        2, 3, LFT, {{"HeadingFormat", 1}}, "GRID")

AddText      ("OPTIONS_HD0",        2, 4, LFT, {{"HeadingFormat", 0}}, "MH")
AddText      ("OPTIONS_HD1",        2, 4, LFT, {{"HeadingFormat", 1}}, "GH")
AddText      ("OPTIOMS_MAGHEAD",     9, 4, RGHT,{{"HeadingValue"}})

AddText      ("OPTIONS_HS0",        2, 5, LFT, {{"HeadingFormat", 0}}, "MV")
AddText      ("OPTIONS_MV",         9, 5, RGHT, {{"HeadingFormat", 0}, {"MagneticVariation"}}  )

AddText      ("OPTIONS_HS1",        2, 5, LFT, {{"HeadingFormat", 1}}, "C")
AddText      ("OPTIONS_CF",         4, 5, LFT, {{"HeadingFormat", 1}, {"ConvergenceFactor"}}  )

AddText      ("OPTIONS_EQUAL",      4, 5, LFT, {{"HeadingFormat", 0},{"EqualSign"}}, "=")
AddText      ("OPTIONS_EQUAL1",      3, 5, LFT, {{"HeadingFormat", 1}}, "=")

add_static_hint_CDU("L1", _("Toggle between Magnetic and Variation Display and Aircraft GRID Data"))
add_hint_controllers_CDU("L2", _("Enter a new MV as (E/W)(degree).(tens of degree)"), {{"HeadingFormat",0}})