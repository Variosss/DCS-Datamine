dofile(LockOn_Options.script_path.."CDU/indicator/CDU_definitions.lua")

AddStaticText("PageNamePOSINFO", 2, 1, LFT, "POSINFO")

AddText		 ("PresPositLat",    2, 3, LFT, {{"PresPosPresent", 0}}, "***********")
AddText		 ("PresPositLat1",   2, 3, LFT, {{"PresPosPresent", 1}, {"PresPositLat"}})
AddText		 ("PresPositLong",   2, 4, LFT, {{"PresPosPresent", 0}}, "***********")
AddText		 ("PresPositLong1",  2, 4, LFT, {{"PresPosPresent", 1}, {"PresPositLong"}})

AddText		 ("PresPositUTM",	 2, 6, LFT, {{"PresPosPresent", 0}}, "*******")
AddText		 ("PresPositUTM1",   2, 6, LFT, {{"PresPosPresent", 1}, {"PresPositUTM"}})
AddText		 ("PresPositMGRS",	 2, 7, LFT, {{"PresPosPresent", 0}}, "**************")
AddText		 ("PresPositMGRS1",  2, 7, LFT, {{"PresPosPresent", 1}, {"PresPositMGRS"}})

AddStaticText("G_ALT",			 2, 9, LFT, "G ALT")
AddText		 ("GPSAltitude",	 8, 9, LFT, {{"EGI_NS", 0}}, "******")
AddText		 ("GPSAltitude1",	 8, 9, LFT, {{"gpsAltitudeEveCondition", 1}}, "******")
AddText		 ("GPSAltitude2",    8, 9, LFT, {{"EGI_NS", 1}, {"gpsAltitudeEveCondition", 0}, {"GPSAltitude"}})
AddText		 ("GPSAltitude3",    8, 9, LFT, {{"EGI_NS", 2}, {"gpsAltitudeEveCondition", 0}, {"GPSAltitude"}})
AddText		 ("GPSAltitude4",    8, 9, LFT, {{"EGI_NS", 3}, {"gpsAltitudeEveCondition", 0}, {"GPSAltitude"}})

AddText		 ("PPOSSpeedMode",	19, 3, RGHT, {{"PPOSSpeedMode", 0}}, "IAS")
AddText		 ("PPOSSpeedMode1",	19, 3, RGHT, {{"PPOSSpeedMode", 1}}, "TAS")
AddText		 ("PPOSIAS",		23, 3, RGHT, {{"PPOSSpeedMode", 0}, {"IAS"}})
AddText		 ("PPOSTAS1",		23, 3, RGHT, {{"PPOSSpeedMode", 1}, {"TAS"}})
AddText		 ("PPOSSpeedMode2",	17, 3, LFT,  {{"EGI_NS", 0}, {"PPOSSpeedMode", 2}}, "*******")
AddText		 ("PPOSSpeedMode3",	19, 3, RGHT, {{"EGI_NS", 1}, {"PPOSSpeedMode", 2}}, "GS")
AddText		 ("PPOSGroundSpeed",23, 3, RGHT,{{"EGI_NS", 1}, {"PPOSSpeedMode", 2}, {"GroundSpeed"}})
AddText		 ("PPOSSpeedMode4",	19, 3, RGHT, {{"EGI_NS", 2}, {"PPOSSpeedMode", 2}}, "GS")
AddText		 ("PPOSGroundSpeed1",23, 3, RGHT,{{"EGI_NS", 2}, {"PPOSSpeedMode", 2}, {"GroundSpeed"}})
AddText		 ("PPOSSpeedMode5",	19, 3, RGHT, {{"EGI_NS", 3}, {"PPOSSpeedMode", 2}}, "GS")
AddText		 ("PPOSGroundSpeed2",23, 3, RGHT,{{"EGI_NS", 3}, {"PPOSSpeedMode", 2}, {"GroundSpeed"}})

AddStaticText("PPOSSpeedRotary", 24, 3, LFT, ROTARY) 

AddStaticText("MACH",			18, 4, RGHT, "MACH")
AddText		 ("Mach",			23, 4, RGHT, {{"Mach"}})

AddText		 ("MV",				16, 5, LFT, {{"EGI_NS", 0}}, "********")
AddText		 ("MV1",			17, 5, RGHT, {{"EGI_NS", 1}}, "MV")
AddText      ("MV_EQ",          18, 5, LFT,  {{"EGI_NS", 1},{"HeadingFormat", 0}, {"EqualSign"}}, "=")
AddText		 ("MV2",			23, 5, RGHT, {{"EGI_NS", 1}, {"MagneticVariation"}})
AddText		 ("MV3",			17, 5, RGHT, {{"EGI_NS", 2}}, "MV")
AddText      ("MV_EQ1",         18, 5, LFT,  {{"EGI_NS", 2},{"HeadingFormat", 0}, {"EqualSign"}}, "=")
AddText		 ("MV4",			23, 5, RGHT, {{"EGI_NS", 2}, {"MagneticVariation"}})
AddText		 ("MV5",			17, 5, RGHT, {{"EGI_NS", 3}}, "MV")
AddText      ("MV_EQ2",         18, 5, LFT,  {{"EGI_NS", 3},{"HeadingFormat", 0}, {"EqualSign"}}, "=")
AddText		 ("MV6",			23, 5, RGHT, {{"EGI_NS", 3}, {"MagneticVariation"}})

AddText		 ("Overload",		20, 7, LFT, {{"EGI_NS", 0}}, "****")
AddText		 ("Overload1",		20, 7, LFT, {{"EGI_NS", 2}}, "****")
AddText		 ("Overload2",		20, 7, LFT, {{"EGI_NS", 3}}, "****")
AddText		 ("Overload3",		23, 7, RGHT, {{"EGI_NS", 1}}, "G")
AddText		 ("Overload4",		22, 7, RGHT, {{"EGI_NS", 1}, {"Overload"}})

AddStaticText("OAT",			15, 9, LFT, "OAT")
AddText		 ("C",				23, 9, RGHT, {{"TempMode", 0}}, DEGREE .. "C")
AddText		 ("F",				23, 9, RGHT, {{"TempMode", 1}}, DEGREE .. "F")
AddText		 ("TempC",			21, 9, RGHT, {{"TempMode", 0}, {"TempC"}})
AddText		 ("TempF",			21, 9, RGHT, {{"TempMode", 1}, {"TempF"}})
AddStaticText("TempRotary",		24, 9, LFT, ROTARY) 

add_static_hint_CDU("R1", _("Rotary between IAS/TAS/GS"))
add_static_hint_CDU("R4", _("Rotary between degrees of C or degrees of F"))

