dofile(LockOn_Options.script_path.."CDU/indicator/CDU_definitions.lua")

AddStaticText("PageNameDTSDNLD", 2, 1, LFT, "DTSDNLD")

AddText      ("ALL1", 1, 3, LFT, {{"DTSDownloadAvailable"}}, SYS_ACTION)
AddStaticText("ALL2", 2, 3, LFT, "ALL")

AddText      ("GPS1", 1, 5, LFT, {{"DTSDownloadAvailable"}}, SYS_ACTION)
AddStaticText("GPS2", 2, 5, LFT, "GPS ALMANAC")

AddText      ("LRU1", 1, 7, LFT, {{"DTSDownloadAvailable"}}, SYS_ACTION)
AddStaticText("LRU2", 2, 7, LFT, "LRU BIT LOG")

AddStaticText("DTS", 24, 9, RGHT, "DTS" .. BRANCH_R)

add_static_hint_CDU("L1", _("Download All Original Data (waypoints, flight plans, CDU preferences and LASTE settings)"))
add_static_hint_CDU("L2", _("Download the Entire GPS Constellation Almanac"))
add_static_hint_CDU("L3", _("Download the Built-In-Test (BIT) log for all Line Replaceable Units (LRU)"))

add_static_hint_CDU("R4", _("Branch to the DTS page"))