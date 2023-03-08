dofile(LockOn_Options.script_path.."CDU/indicator/CDU_definitions.lua")

AddStaticText("PageNameWNDEDIT",  2, 1, LFT, "WNDEDIT")

AddText		 ("WNDDIV",			 17, 2, LFT, {{"AnnVisible", 0}}, "/")
AddText		 ("WNDEDWindDirection1", 14, 2, LFT, {{"AnnVisible", 0}, {"WindParamsValid", 0}}, "***")
AddText		 ("WNDEDWindDirection2", 14, 2, LFT, {{"AnnVisible", 0}, {"WindParamsValid", 1}, {"WAYPTWindDirection"}})
AddText		 ("WNDEDWindSpeed1",	 18, 2, LFT, {{"AnnVisible", 0}, {"WindParamsValid", 0}}, "***")
AddText		 ("WNDEDWindSpeed2",	 18, 2, LFT, {{"AnnVisible", 0}, {"WindParamsValid", 1}, {"WAYPTWindSpeed"}})
AddText		 ("WINDTemp",		 24, 2, RGHT, {{"AnnVisible", 0}, {"TempMode", 0}, {"WINDTempCur", 0}})
AddText		 ("WINDTemp1",		 24, 2, RGHT, {{"AnnVisible", 0}, {"TempMode", 1}, {"WINDTempCur", 1}})

AddStaticText("PAGE", 19 + PageNumNorOffset, 10, LFT, "P /2")
