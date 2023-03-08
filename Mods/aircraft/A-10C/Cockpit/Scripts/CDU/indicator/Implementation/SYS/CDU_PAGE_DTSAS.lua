dofile(LockOn_Options.script_path.."CDU/indicator/CDU_definitions.lua")

AddStaticText("PageNameDTSAS", 2, 1, LFT, "DTSAS")

AddText		 ("DTSAS_SYMB",    1, 3, LFT, {{"DTSASAvail", 1}}, SYS_ACTION)
AddStaticText("DTSAS_TXT",     2, 3, LFT, "DTSAS")
AddText		 ("DTSAS_ON_OFF",  8, 3, LFT, {{"DTSAS_FuncOnOff", 0}}, "OFF")
AddText		 ("DTSAS_ON_OFF1", 8, 3, LFT, {{"DTSAS_FuncOnOff", 1}}, "ON")

AddText		 ("CR_SYMB",	   1, 5, LFT, {{"CRAvail", 1}}, SYS_ACTION)
AddStaticText("CR_TXT",		   2, 5, LFT, "CR")
AddText		 ("CR_ON_OFF",	   5, 5, LFT, {{"CROnOff", 0}}, "OFF")
AddText		 ("CR_ON_OFF1",	   5, 5, LFT, {{"CROnOff", 1}}, "ON")

AddStaticText("HPU",		   2, 7, LFT, "HPU")
AddText		 ("DTSAS_HPU1",	   10, 7, RGHT, {{"DTSAS_HPU"}})

AddStaticText("VPU",		   2, 8, LFT, "VPU")
AddText		 ("DTSAS_VPU1",	   9, 8, RGHT, {{"DTSAS_VPU"}})

AddStaticText("PGCAS",		  17, 3, LFT, "PGCAS")
AddText		 ("PGCAS_VALUE",  23, 3, LFT, {{"PGCAS_VALUE", 0}},"*")
AddText		 ("PGCAS_VALUE1",  23, 3, LFT, {{"PGCAS_VALUE", 1}},"F")
AddText		 ("PGCAS_VALUE2",  23, 3, LFT, {{"PGCAS_VALUE", 2}},"V")

AddStaticText("OWC",		  17, 4, LFT, "OWC")
AddText		 ("OWC_VALUE",    23, 4, LFT, {{"OWC_VALUE", 0}},"*")
AddText		 ("OWC_VALUE1",    23, 4, LFT, {{"OWC_VALUE", 1}},"F")
AddText		 ("OWC_VALUE2",    23, 4, LFT, {{"OWC_VALUE", 2}},"V")

AddStaticText("PR",			  17, 5, LFT, "PR")
AddText		 ("PR_VALUE",     23, 5, LFT, {{"PR_VALUE", 0}},"*")
AddText		 ("PR_VALUE1",     23, 5, LFT, {{"PR_VALUE", 1}},"F")
AddText		 ("PR_VALUE2",     23, 5, LFT, {{"PR_VALUE", 2}},"V")

AddStaticText("LAR",		  17, 6, LFT, "LAR")
AddText		 ("LAR_VALUE",    23, 6, LFT, {{"LAR_VALUE", 0}},"*")
AddText		 ("LAR_VALUE1",    23, 6, LFT, {{"LAR_VALUE", 1}},"F")
AddText		 ("LAR_VALUE2",    23, 6, LFT, {{"LAR_VALUE", 2}},"V")

AddStaticText("OWC1",		  21, 8, LFT, "OWC")
AddStaticText("FT_TXT",       23, 9, RGHT, "FT")
AddText		 ("FT_BRACKETS",  24, 9, RGHT, {{"DTSAS_FuncOnOff", 1}}, DATA_ENTRY)
AddText		 ("DTSAS_OWC",	  20, 9, RGHT, {{"DTSAS_FuncOnOff", 0}}, "****")
AddText		 ("DTSAS_OWC1",	  20, 9, RGHT, {{"DTSAS_FuncOnOff", 1}, {"DTSAS_OWC"}})

AddText		 ("GCAS_LAST_SOURCE", 2, 9, LFT, {{"GCAS_LAST_SOURCE"}}, {"", "DTSAS PGCAS", "IFFCC PGCAS", "IFFCC 90 - FT"})

add_static_hint_CDU("L1", _("Toggle DTSAS System ON and OFF (Not Functional)"))
add_static_hint_CDU("L2", _("Toggle CR Function ON and OFF (Not Functional)"))
add_static_hint_CDU("R4", _("Enter new OWC avoidance height from the scratchpad (from 0 to 9999 feet)"))
