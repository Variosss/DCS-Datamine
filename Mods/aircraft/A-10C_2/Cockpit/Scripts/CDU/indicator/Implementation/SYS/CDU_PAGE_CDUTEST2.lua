dofile(LockOn_Options.script_path.."CDU/indicator/CDU_definitions.lua")

AddStaticText("PageNameCDUTEST2",   2, 1, LFT, "CDUTEST")

AddStaticText("DISPLAY_TEST",   1, 3, LFT, SYS_ACTION.."DISPLAY TEST")

AddStaticText("DISPLAY_TEST1",   2, 5, LFT, "CODE    NAME")
AddStaticText("DISPLAY_TEST_VALUES",   2, 6, LFT,      " 22      3")

AddStaticText("PAGE_NUMBER", 19 + PageNumNorOffset, 10, LFT, "P2/2")

add_static_hint_CDU("L1", _("Display the CDU test pattern. Not Functional"))