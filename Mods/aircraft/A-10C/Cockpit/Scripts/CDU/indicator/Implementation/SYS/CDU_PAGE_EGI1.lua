dofile(LockOn_Options.script_path.."CDU/indicator/CDU_definitions.lua")

AddStaticText("PageNameEGI",   2, 1, LFT, "EGI")

AddStaticText("STATUS_LINE",   2, 3, LFT, "INS")
AddStaticText("STATUS_LINE1",  10, 3, LFT, "GPS")
AddStaticText("STATUS_LINE2",  18, 3, LFT, "MSN")


AddText		 ("EGIStatus",     6, 3, LFT, {{"EGIStatus", 0, 0}}, "N")
AddText		 ("EGIStatus1",     6, 3, LFT, {{"EGIStatus", 0, 1}}, "I")
AddText		 ("EGIStatus2",     6, 3, LFT, {{"EGIStatus", 0, 2}}, "V")
AddText		 ("EGIStatus3",     6, 3, LFT, {{"EGIStatus", 0, 3}}, "F")
AddText		 ("EGIStatus4",     6, 3, LFT, {{"EGIStatus", 0, 4}}, "T")

AddText		 ("EGIStatus5",    14, 3, LFT, {{"EGIStatus", 1, 0}}, "N")
AddText		 ("EGIStatus6",    14, 3, LFT, {{"EGIStatus", 1, 1}}, "I")
AddText		 ("EGIStatus7",    14, 3, LFT, {{"EGIStatus", 1, 2}}, "V")
AddText		 ("EGIStatus8",    14, 3, LFT, {{"EGIStatus", 1, 3}}, "F")
AddText		 ("EGIStatus9",    14, 3, LFT, {{"EGIStatus", 1, 4}}, "T")

AddText		 ("EGIStatus10",    22, 3, LFT, {{"EGIStatus", 2, 0}}, "N")
AddText		 ("EGIStatus11",    22, 3, LFT, {{"EGIStatus", 2, 1}}, "I")
AddText		 ("EGIStatus12",    22, 3, LFT, {{"EGIStatus", 2, 2}}, "V")
AddText		 ("EGIStatus13",    22, 3, LFT, {{"EGIStatus", 2, 3}}, "F")
AddText		 ("EGIStatus14",    22, 3, LFT, {{"EGIStatus", 2, 4}}, "T")

AddStaticText("FLIGHT DRIVER", 5, 4, LFT, "FLIGHT DRIVER")

AddText		("FLIGHT_DRIVER1",  6, 5, LFT, {{"EGI_NS", 0}}, "NONE")
AddText		("FLIGHT_DRIVER2",  6, 5, LFT, {{"EGI_NS", 1}}, "BLENDED")
AddText		("FLIGHT_DRIVER3",  6, 5, LFT, {{"EGI_NS", 2}}, "GPS")
AddText		("FLIGHT_DRIVER4",  6, 5, LFT, {{"EGI_NS", 3}}, "INS")

AddText		 ("EGIStatus15",    17, 5, LFT, {{"EGIStatus", 3, 2}}, "V")
AddText		 ("EGIStatus16",    17, 5, LFT, {{"EGIStatus", 3, 3}}, "F")

AddStaticText("FOM",		  11, 7, LFT, "FOM")
AddStaticText("FOM_LINE",	   2, 8, LFT, "INS     GPS     BLD")

AddText		("EGI_INS_FOM",	   6, 8, LFT, {{"EGI_FOM", 3, 0}}, "*")
AddText		("EGI_INS_FOM1",	   6, 8, LFT, {{"EGI_FOM", 3, 1}}, "1")
AddText		("EGI_INS_FOM2",	   6, 8, LFT, {{"EGI_FOM", 3, 2}}, "2")
AddText		("EGI_INS_FOM3",	   6, 8, LFT, {{"EGI_FOM", 3, 3}}, "3")
AddText		("EGI_INS_FOM4",	   6, 8, LFT, {{"EGI_FOM", 3, 4}}, "4")
AddText		("EGI_INS_FOM5",	   6, 8, LFT, {{"EGI_FOM", 3, 5}}, "5")
AddText		("EGI_INS_FOM6",	   6, 8, LFT, {{"EGI_FOM", 3, 6}}, "6")
AddText		("EGI_INS_FOM7",	   6, 8, LFT, {{"EGI_FOM", 3, 7}}, "7")
AddText		("EGI_INS_FOM8",	   6, 8, LFT, {{"EGI_FOM", 3, 8}}, "8")
AddText		("EGI_INS_FOM9",	   6, 8, LFT, {{"EGI_FOM", 3, 9}}, "9")

AddText		("EGI_GPS_FOM",	  14, 8, LFT, {{"EGI_FOM", 2, 0}}, "*")
AddText		("EGI_GPS_FOM1",	  14, 8, LFT, {{"EGI_FOM", 2, 1}}, "1")
AddText		("EGI_GPS_FOM2",	  14, 8, LFT, {{"EGI_FOM", 2, 2}}, "2")
AddText		("EGI_GPS_FOM3",	  14, 8, LFT, {{"EGI_FOM", 2, 3}}, "3")
AddText		("EGI_GPS_FOM4",	  14, 8, LFT, {{"EGI_FOM", 2, 4}}, "4")
AddText		("EGI_GPS_FOM5",	  14, 8, LFT, {{"EGI_FOM", 2, 5}}, "5")
AddText		("EGI_GPS_FOM6",	  14, 8, LFT, {{"EGI_FOM", 2, 6}}, "6")
AddText		("EGI_GPS_FOM7",	  14, 8, LFT, {{"EGI_FOM", 2, 7}}, "7")
AddText		("EGI_GPS_FOM8",	  14, 8, LFT, {{"EGI_FOM", 2, 8}}, "8")
AddText		("EGI_GPS_FOM9",	  14, 8, LFT, {{"EGI_FOM", 2, 9}}, "9")

AddText		("EGI_BLD_FOM",	  22, 8, LFT, {{"EGI_FOM", 1, 0}}, "*")
AddText		("EGI_BLD_FOM1",	  22, 8, LFT, {{"EGI_FOM", 1, 1}}, "1")
AddText		("EGI_BLD_FOM2",	  22, 8, LFT, {{"EGI_FOM", 1, 2}}, "2")
AddText		("EGI_BLD_FOM3",	  22, 8, LFT, {{"EGI_FOM", 1, 3}}, "3")
AddText		("EGI_BLD_FOM4",	  22, 8, LFT, {{"EGI_FOM", 1, 4}}, "4")
AddText		("EGI_BLD_FOM5",	  22, 8, LFT, {{"EGI_FOM", 1, 5}}, "5")
AddText		("EGI_BLD_FOM6",	  22, 8, LFT, {{"EGI_FOM", 1, 6}}, "6")
AddText		("EGI_BLD_FOM7",	  22, 8, LFT, {{"EGI_FOM", 1, 7}}, "7")
AddText		("EGI_BLD_FOM8",	  22, 8, LFT, {{"EGI_FOM", 1, 8}}, "8")
AddText		("EGI_BLD_FOM9",	  22, 8, LFT, {{"EGI_FOM", 1, 9}}, "9")

AddStaticText("PAGE_NUMBER", 19 + PageNumNorOffset, 10, LFT, "P1/4")
